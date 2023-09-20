Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84EF7A87B8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbjITO7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbjITO7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:59:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C99091;
        Wed, 20 Sep 2023 07:59:31 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-401f68602a8so76366495e9.3;
        Wed, 20 Sep 2023 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695221970; x=1695826770; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TaM1Vi4r2cWia1RtnrKubJW4eoHBqkQ8v72VUNA95Dw=;
        b=ebiXsxI4meTuIj6VU6I+REb/fIRg4ceZJGqWvEGIrMZPm2t8l1BKGgBF36hOTSIKrr
         1ibx6BgeNxd7byd7sK8pJtgWADk/QCqXxijutHjYhuNUL2qXqWjMK0reiQpYV8njZHz3
         4ndNX30TaO8aOFIBPm+wTxyt/qxibjFcVwm9zw9KM4Am24tPfkWuQoVwOp+XwaZCSqAr
         jWpq2zILhUkVZG+3ZTYulYNURCdX+DhIAv4uZ0p/p7NsYsUY2jYQfM3jI8qSn3c7vz1k
         wL92i95Yo38J32XQ1pea4zCkFnaM3bd5/oqYVLdDwekwH24H4k5zx3gdnTwqmU8mkSoK
         1Iag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695221970; x=1695826770;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TaM1Vi4r2cWia1RtnrKubJW4eoHBqkQ8v72VUNA95Dw=;
        b=ipFQZTLM2E1hYYurvWQphXmUJq7LM+9oYbLC21yZjwMXjV6j8YN3IYROoi+Bl9R1YR
         +Btvx2STo39t52YzSkxVCKH/T7dEbiE5uxekiU01LyvdAiF6XvmUYhp5tti9vJhJcHP3
         TV8HDDWqslw38DPFFwXMUI4rnC8k2aluXDXG1ugdFh4tU84zLcEFtk4gq4tsnMlZoXZ6
         YrwWBI2b0mbTSCQJ6++tsL8xM1I8rSU41LfdhteR5kSEg69deGtdV7dElEBygDt2JO3U
         G8YJPBp9+1YUkxQ/r97eZBgN/WG1I1HOKI5U5qkZyVrRKQi6o2C761rPXR+jwTJKqRCI
         7wmA==
X-Gm-Message-State: AOJu0Yzj0qWNK4PIGSksiD/+fEM+3RdgDzCTLK9fVBmBAiyk9GPtwvzg
        e9TMzGjqTKeqvTh4J9JBsMk=
X-Google-Smtp-Source: AGHT+IE8JWit79huPB0zxHTYVJXHjUZ2LznXWHeYQ5D4JoiDx1ePW1QwKszLz22fchL7FKiGawtGCg==
X-Received: by 2002:a1c:f204:0:b0:401:519:c5 with SMTP id s4-20020a1cf204000000b00401051900c5mr2639293wmc.41.1695221969482;
        Wed, 20 Sep 2023 07:59:29 -0700 (PDT)
Received: from primary ([212.34.23.120])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b003fed9b1a1f4sm1173622wmj.1.2023.09.20.07.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:59:29 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:46:00 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 04/15] USB: typec: Load TPS25750 patch bundle
Message-ID: <ZQsFqNSIFHUOGywJ@primary>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-5-alkuor@gmail.com>
 <ZQg1KjinxBRxwUSM@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQg1KjinxBRxwUSM@kuha.fi.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:31:54PM +0300, Heikki Krogerus wrote:
> On Sun, Sep 17, 2023 at 11:26:28AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > TPS25750 controller requires a binary to be loaded with a configuration
> > binary by an EEPROM or a host.
> > 
> > Appling a patch bundling using a host is implemented based on the flow
> > diagram pg.62 in TPS25750 host interface manual.
> > https://www.ti.com/lit/ug/slvuc05a/slvuc05a.pdf
> > 
> > The flow diagram can be summarized as following:
> > - Start the patch loading sequence with patch bundle information by
> >   executing PBMs
> > - Write the whole patch at once
> > - When writing the patch fails, execute PBMe which instructs the PD controller
> >   to end the patching process
> > - After writing the patch successfully, execute PBMc which verifies the patch
> >   integrity and applies the patch internally
> > - Wait for the device to switch into APP mode (normal operation)
> > 
> > The execuation flow diagram polls the events register and then polls the
> > corresponding register related to the event as well before advancing to the next
> > state. Polling the events register is a redundant step, in this implementation
> > only the corresponding register related to the event is polled.
> > 
> > Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> > ---
> >  drivers/usb/typec/tipd/core.c | 237 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 236 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index 6d2151325fbb..fea139c72d6d 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/usb/typec_altmode.h>
> >  #include <linux/usb/role.h>
> >  #include <linux/workqueue.h>
> > +#include <linux/firmware.h>
> >  
> >  #include "tps6598x.h"
> >  #include "trace.h"
> > @@ -43,6 +44,23 @@
> >  /* TPS_REG_SYSTEM_CONF bits */
> >  #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
> >  
> > +/*
> > + * BPMs task timeout, recommended 5 seconds
> > + * pg.48 TPS2575 Host Interface Technical Reference
> > + * Manual (Rev. A)
> > + * https://www.ti.com/lit/ug/slvuc05a/slvuc05a.pdf
> > + */
> > +#define TPS_BUNDLE_TIMEOUT	0x32
> > +
> > +/* BPMs return code */
> > +#define TPS_TASK_BPMS_INVALID_BUNDLE_SIZE	0x4
> > +#define TPS_TASK_BPMS_INVALID_SLAVE_ADDR	0x5
> > +#define TPS_TASK_BPMS_INVALID_TIMEOUT		0x6
> > +
> > +/* PBMc data out */
> > +#define TPS_PBMC_RC	0 /* Return code */
> > +#define TPS_PBMC_DPCS	2 /* device patch complete status */
> > +
> >  enum {
> >  	TPS_PORTINFO_SINK,
> >  	TPS_PORTINFO_SINK_ACCESSORY,
> > @@ -88,6 +106,8 @@ struct tps6598x {
> >  	struct mutex lock; /* device lock */
> >  	u8 i2c_protocol:1;
> >  
> > +	u8 is_tps25750:1;
> > +
> >  	struct typec_port *port;
> >  	struct typec_partner *partner;
> >  	struct usb_pd_identity partner_identity;
> > @@ -708,6 +728,203 @@ static int devm_tps6598_psy_register(struct tps6598x *tps)
> >  	return PTR_ERR_OR_ZERO(tps->psy);
> >  }
> >  
> > +static int
> > +tps25750_write_firmware(struct tps6598x *tps,
> > +			u8 bpms_addr, const u8 *data, size_t len)
> > +{
> > +	struct i2c_client *client = to_i2c_client(tps->dev);
> > +	int ret;
> > +	u8 slave_addr;
> > +	int timeout;
> > +
> > +	slave_addr = client->addr;
> > +	timeout = client->adapter->timeout;
> > +
> > +	/*
> > +	 * binary configuration size is around ~16Kbytes
> > +	 * which might take some time to finish writing it
> > +	 */
> > +	client->adapter->timeout = msecs_to_jiffies(5000);
> > +	client->addr = bpms_addr;
> > +
> > +	ret = regmap_raw_write(tps->regmap, data[0], &data[1], len - 1);
> > +
> > +	client->addr = slave_addr;
> > +	client->adapter->timeout = timeout;
> > +
> > +	return ret;
> > +}
> > +
> > +static int
> > +tps25750_exec_pbms(struct tps6598x *tps, u8 *in_data, size_t in_len)
> > +{
> > +	int ret;
> > +	u8 rc;
> > +
> > +	ret = tps6598x_exec_cmd(tps, "PBMs", in_len, in_data,
> > +				sizeof(rc), &rc, 4000, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	switch (rc) {
> > +	case TPS_TASK_BPMS_INVALID_BUNDLE_SIZE:
> > +		dev_err(tps->dev, "%s: invalid fw size\n", __func__);
> > +		return -EINVAL;
> > +	case TPS_TASK_BPMS_INVALID_SLAVE_ADDR:
> > +		dev_err(tps->dev, "%s: invalid slave address\n", __func__);
> > +		return -EINVAL;
> > +	case TPS_TASK_BPMS_INVALID_TIMEOUT:
> > +		dev_err(tps->dev, "%s: timed out\n", __func__);
> > +		return -ETIMEDOUT;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tps25750_abort_patch_process(struct tps6598x *tps)
> > +{
> > +	int ret;
> > +	u8 mode;
> > +
> > +	ret = tps6598x_exec_cmd(tps, "PBMe", 0, NULL, 0, NULL, 1000, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = tps6598x_check_mode(tps, &mode);
> > +	if (mode != TPS_MODE_PTCH)
> > +		dev_err(tps->dev, "failed to switch to \"PTCH\" mode\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static int tps25750_start_patch_burst_mode(struct tps6598x *tps)
> > +{
> > +	int ret;
> > +	const struct firmware *fw;
> > +	const char *firmware_name;
> > +	struct {
> > +		u32 fw_size;
> > +		u8 addr;
> > +		u8 timeout;
> > +	} __packed bpms_data;
> > +
> > +	ret = device_property_read_string(tps->dev, "firmware-name",
> > +					  &firmware_name);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = request_firmware(&fw, firmware_name, tps->dev);
> > +	if (ret) {
> > +		dev_err(tps->dev, "failed to retrieve \"%s\"\n", firmware_name);
> > +		return ret;
> > +	}
> > +
> > +	if (fw->size == 0) {
> > +		ret = -EINVAL;
> > +		goto release_fw;
> > +	}
> > +
> > +	ret = device_property_read_u8(tps->dev, "ti,patch-address", &bpms_data.addr);
> > +	if (ret) {
> > +		dev_err(tps->dev, "failed to get patch address\n");
> > +		return ret;
> > +	}
> > +
> > +	bpms_data.fw_size = fw->size;
> > +	bpms_data.timeout = TPS_BUNDLE_TIMEOUT;
> > +
> > +	ret = tps25750_exec_pbms(tps, (u8 *)&bpms_data, sizeof(bpms_data));
> > +	if (ret)
> > +		goto release_fw;
> > +
> > +	ret = tps25750_write_firmware(tps, bpms_data.addr, fw->data, fw->size);
> > +	if (ret) {
> > +		dev_err(tps->dev, "Failed to write patch %s of %lu bytes\n",
> > +			firmware_name, fw->size);
> > +		goto release_fw;
> > +	}
> > +
> > +	/*
> > +	 * A delay of 500us is required after the firmware is written
> > +	 * based on pg.62 in tps6598x Host Interface Technical
> > +	 * Reference Manual
> > +	 * https://www.ti.com/lit/ug/slvuc05a/slvuc05a.pdf
> > +	 */
> > +	udelay(500);
> > +
> > +release_fw:
> > +	release_firmware(fw);
> > +
> > +	return ret;
> > +}
> > +
> > +static int tps25750_complete_patch_process(struct tps6598x *tps)
> > +{
> > +	int ret;
> > +	u8 out_data[40];
> > +	u8 dummy[2] = { };
> > +
> > +	/*
> > +	 * Without writing something to DATA_IN, this command would
> > +	 * return an error
> > +	 */
> > +	ret = tps6598x_exec_cmd(tps, "PBMc", sizeof(dummy), dummy,
> > +				sizeof(out_data), out_data, 2000, 20);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (out_data[TPS_PBMC_RC]) {
> > +		dev_err(tps->dev,
> > +			"%s: pbmc failed: %u\n", __func__,
> > +			out_data[TPS_PBMC_RC]);
> > +		return -EIO;
> > +	}
> > +
> > +	if (out_data[TPS_PBMC_DPCS]) {
> > +		dev_err(tps->dev,
> > +			"%s: failed device patch complete status: %u\n",
> > +			__func__, out_data[TPS_PBMC_DPCS]);
> > +		return -EIO;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int tps25750_apply_patch(struct tps6598x *tps)
> > +{
> > +	int ret;
> > +	unsigned long timeout;
> > +	u8 mode;
> > +
> > +	ret = tps25750_start_patch_burst_mode(tps);
> > +	if (ret) {
> > +		tps25750_abort_patch_process(tps);
> > +		return ret;
> > +	}
> > +
> > +	ret = tps25750_complete_patch_process(tps);
> > +	if (ret)
> > +		return ret;
> > +
> > +	timeout = jiffies + msecs_to_jiffies(1000);
> > +
> > +	do {
> > +		ret = tps6598x_check_mode(tps, &mode);
> > +		if (ret)
> > +			return ret;
> > +
> > +		if (time_is_before_jiffies(timeout))
> > +			return -ETIMEDOUT;
> > +
> > +	} while (mode != TPS_MODE_APP);
> > +
> > +	dev_info(tps->dev, "controller switched to \"APP\" mode\n");
> > +
> > +	return 0;
> > +};
> > +
> >  static int tps6598x_probe(struct i2c_client *client)
> >  {
> >  	irq_handler_t irq_handler = tps6598x_interrupt;
> > @@ -757,6 +974,8 @@ static int tps6598x_probe(struct i2c_client *client)
> >  
> >  		irq_handler = cd321x_interrupt;
> >  	} else {
> > +
> > +		tps->is_tps25750 = of_device_is_compatible(np, "ti,tps25750");
> >  		/* Enable power status, data status and plug event interrupts */
> >  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
> >  			TPS_REG_INT_DATA_STATUS_UPDATE |
> > @@ -769,9 +988,15 @@ static int tps6598x_probe(struct i2c_client *client)
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (tps->is_tps25750 && mode == TPS_MODE_PTCH) {
> > +		ret = tps25750_apply_patch(tps);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> >  	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
> >  	if (ret)
> > -		return ret;
> > +		goto err_reset_controller;
> >  
> >  	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
> >  	if (ret < 0)
> > @@ -891,6 +1116,10 @@ static int tps6598x_probe(struct i2c_client *client)
> >  	fwnode_handle_put(fwnode);
> >  err_clear_mask:
> >  	tps6598x_write64(tps, TPS_REG_INT_MASK1, 0);
> > +err_reset_controller:
> > +	/* Reset PD controller to remove any applied patch */
> > +	if (tps->is_tps25750)
> > +		tps6598x_exec_cmd(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
> >  	return ret;
> >  }
> >  
> > @@ -901,9 +1130,14 @@ static void tps6598x_remove(struct i2c_client *client)
> >  	if (!client->irq)
> >  		cancel_delayed_work_sync(&tps->wq_poll);
> >  
> > +	devm_free_irq(tps->dev, client->irq, tps);
> >  	tps6598x_disconnect(tps, 0);
> >  	typec_unregister_port(tps->port);
> >  	usb_role_switch_put(tps->role_sw);
> > +
> > +	/* Reset PD controller to remove any applied patch */
> > +	if (tps->is_tps25750)
> > +		tps6598x_exec_cmd(tps, "GAID", 0, NULL, 0, NULL, 2000, 0);
> >  }
> >  
> >  static int __maybe_unused tps6598x_suspend(struct device *dev)
> > @@ -946,6 +1180,7 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
> >  static const struct of_device_id tps6598x_of_match[] = {
> >  	{ .compatible = "ti,tps6598x", },
> >  	{ .compatible = "apple,cd321x", },
> > +	{ .compatible = "ti,tps25750", },
> 
> This is probable OK for now, we can mix this stuff into core.c now, but
> later I want this driver (core.c) to be converted into a library that
> contains only the common functionality. TPS5750 will at that point have
> its own probe/glue driver.
>
Duly noted. 
> >  	{}
> >  };
> >  MODULE_DEVICE_TABLE(of, tps6598x_of_match);
> > -- 
> > 2.34.1
> 
> thanks,
> 
> -- 
> heikki

Abdel
