Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574FD7B4199
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbjI3P3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjI3P3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:29:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D94BE;
        Sat, 30 Sep 2023 08:29:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696087745; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=I0QWIsXLJ6R0JF1fTd16hMOAf1rLeCt6KnbulbQT0Hi6caHfG5q24UD4Ygf8TZ3/fz
    VxckiA0yBkHj3tAZIQHXjnEYyf8nbZZ3DHj5VFVwpQfNJK9Yj+8Hc/nTfDe+TnxIQAKT
    r1gHcoRrBp+QyeOINklG7J2EQbEUlYlDlS4HZvSEvOj252cYTSNt6PA8ZTTyOYS5GmqW
    EoRn5+lZPLbi+EigyEOrq5boza7xSq6FxGuLldye/CPabUmoqytKd6maPIdbtqqFddRL
    NzVaOhoqQomgtiuYjgG+4SnEEjvNB1M5NNdTQCNkZl08hBfvG3k5yZ9EAGcu9khPqugl
    sbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696087745;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ix09YzWH8S3gStr0pJ5Dfn8yz393MkdSkVsPuVfWquQ=;
    b=NftcBeB2r34qOOcz5AKpKD7tmYTXt+Vs/RGV4GOzcLOBTmJ2MlJaWTUHSr+rwndaNh
    zDPK1QGcByoht1/okJh6gvgDIvEkiYV8GdMiF73+Q2sK1/aOJhEkc46wYax9UFJN5rqa
    EtI0o6NO9haPKSrwdVHF0ShIHiIgWvmET64jVVcYwODp734VmVqAXAPsmGIb5aLNbvNu
    utA2udauxFhjUf/0go2EY5vz1aq8lqOm4oVOw/am4WOmtZM82Pk9BfwR8WhoFAas25hw
    yxrphCLOo+m+4zWwquhAxuqDxelWyhEHSHSI8KquZMZRZ1twTV2cGvqKpD0VNczzHQPn
    Y8yA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696087745;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ix09YzWH8S3gStr0pJ5Dfn8yz393MkdSkVsPuVfWquQ=;
    b=rzESUc0BvZGFfLq4qxlyEhscQtZuz4VQex7skFEExVHbHV+IxiNJhZB3Y23DQmPXB4
    BPSpv9m8ms/YXY2aGAel8OMByAePIwdl0MJ87MrwXeVDOBuyg3VfAsQALDydhLZiJROQ
    ObnfhkjMwp8mBbBMNT2qz2yjakX1oj/E38opfPO5tHMRCE/BddqI0A84IGndbpDO6xcQ
    gzqsYDgn3AM5JyPldkIQXL0+Ja8t0brRMchuinYKMzLAEQCPn1D9PC89tU9Bspirlbfr
    bjLETpWZJe0L45C295xgnAyZhXpx858O2fPZXQgN3XCrRSSbfOsn/omdBdADSdM508E9
    sxlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696087745;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Ix09YzWH8S3gStr0pJ5Dfn8yz393MkdSkVsPuVfWquQ=;
    b=YQ/rwi1dY7HzVX/VgBzioSSZTNFI+p63x0KFn7t1zOGrLMqjEWwqhltzY1whE0RgWE
    Op2Rr1pT6lZ2McUSxwBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8paF1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8UFT5tX4
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 30 Sep 2023 17:29:05 +0200 (CEST)
Date:   Sat, 30 Sep 2023 17:28:57 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Albrieux <jonathan.albrieux@gmail.com>
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
Message-ID: <ZRg-uZskk07jxup0@gerhold.net>
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
 <ZQYUe46/rj8jqNvg@nixie71>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQYUe46/rj8jqNvg@nixie71>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On Sat, Sep 16, 2023 at 03:47:55PM -0500, Jeff LaBundy wrote:
> On Wed, Sep 13, 2023 at 03:25:30PM +0200, Stephan Gerhold wrote:
> > From: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > 
> > Add a simple driver for the Himax HX852x(ES) touch panel controller,
> > with support for multi-touch and capacitive touch keys.
> > 
> > The driver is somewhat based on sample code from Himax. However, that
> > code was so extremely confusing that we spent a significant amount of
> > time just trying to understand the packet format and register commands.
> > In this driver they are described with clean structs and defines rather
> > than lots of magic numbers and offset calculations.
> > 
> > Signed-off-by: Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > Co-developed-by: Stephan Gerhold <stephan@gerhold.net>
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  MAINTAINERS                              |   7 +
> >  drivers/input/touchscreen/Kconfig        |  10 +
> >  drivers/input/touchscreen/Makefile       |   1 +
> >  drivers/input/touchscreen/himax_hx852x.c | 491 +++++++++++++++++++++++++++++++
> >  4 files changed, 509 insertions(+)
> > 
> > [...]
> > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> > index 62bd24f3ac8e..f42a87faa86c 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -48,6 +48,7 @@ obj-$(CONFIG_TOUCHSCREEN_EXC3000)	+= exc3000.o
> >  obj-$(CONFIG_TOUCHSCREEN_FUJITSU)	+= fujitsu_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_GOODIX)	+= goodix_ts.o
> >  obj-$(CONFIG_TOUCHSCREEN_HIDEEP)	+= hideep.o
> > +obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX852X)	+= himax_hx852x.o
> >  obj-$(CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX)	+= hynitron_cstxxx.o
> >  obj-$(CONFIG_TOUCHSCREEN_ILI210X)	+= ili210x.o
> >  obj-$(CONFIG_TOUCHSCREEN_ILITEK)	+= ilitek_ts_i2c.o
> > diff --git a/drivers/input/touchscreen/himax_hx852x.c b/drivers/input/touchscreen/himax_hx852x.c
> > new file mode 100644
> > index 000000000000..31616dcfc5ab
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/himax_hx852x.c
> > @@ -0,0 +1,491 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Himax HX852x(ES) Touchscreen Driver
> > + * Copyright (c) 2020-2023 Stephan Gerhold <stephan@gerhold.net>
> > + * Copyright (c) 2020 Jonathan Albrieux <jonathan.albrieux@gmail.com>
> > + *
> > + * Based on the Himax Android Driver Sample Code Ver 0.3 for HMX852xES chipset:
> > + * Copyright (c) 2014 Himax Corporation.
> > + */
> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/i2c.h>
> > +#include <linux/input.h>
> > +#include <linux/input/mt.h>
> > +#include <linux/input/touchscreen.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> 
> Please explicitly #include of_device.h.
> 

In v2 I have added linux/of.h and linux/mod_devicetable.h, since I'm
actually using definitions from these two only. Seems like including
of_device.h is discouraged nowadays, see commit dbce1a7d5dce ("Input:
Explicitly include correct DT includes").

> > [...]
> > +static void hx852x_stop(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SENSE_OFF);
> > +	if (error)
> > +		dev_err(dev, "failed to send TS_SENSE_OFF: %d\n", error);
> 
> Granted the function is of void type, should we not still return if there
> is an error?
> 
> Actually, I would still keep this function as an int for future re-use, even
> though hx852x_input_close() simply ignores the value. This way, the return
> value can be propagated to the return value of hx852x_suspend() and elsewhere.
> 
> > +
> > +	msleep(20);
> > +
> > +	error = i2c_smbus_write_byte(hx->client, HX852X_TS_SLEEP_IN);
> > +	if (error)
> > +		dev_err(dev, "failed to send TS_SLEEP_IN: %d\n", error);
> 
> Same here; no need to sleep following a register write that seemingly did
> not happen.
> 
> > +
> > +	msleep(30);
> > +}
> > +
> > +static void hx852x_power_off(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	int error;
> > +
> > +	error = regulator_bulk_disable(ARRAY_SIZE(hx->supplies), hx->supplies);
> > +	if (error)
> > +		dev_err(dev, "failed to disable regulators: %d\n", error);
> > +}
> 
> Same comment with regard to function type; it's nice for internal helpers
> to be of type int, even if the core callback using it is void.
> 
> > +
> > +static int hx852x_read_config(struct hx852x *hx)
> > +{
> > +	struct device *dev = &hx->client->dev;
> > +	struct hx852x_config conf = {0};
> > +	int x_res, y_res;
> > +	int error;
> > +
> > +	error = hx852x_power_on(hx);
> > +	if (error)
> > +		return error;
> > +
> > +	/* Sensing must be turned on briefly to load the config */
> > +	error = hx852x_start(hx);
> > +	if (error)
> > +		goto power_off;
> > +
> > +	hx852x_stop(hx);
> 
> See my earlier comment about promoting this function's type to int.
> 
> > +
> > +	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH,
> > +					  HX852X_SRAM_SWITCH_TEST_MODE);
> > +	if (error)
> > +		goto power_off;
> > +
> > +	error = i2c_smbus_write_word_data(hx->client, HX852X_REG_SRAM_ADDR,
> > +					  HX852X_SRAM_ADDR_CONFIG);
> > +	if (error)
> > +		goto exit_test_mode;
> > +
> > +	error = hx852x_i2c_read(hx, HX852X_REG_FLASH_RPLACE, &conf, sizeof(conf));
> > +	if (error)
> > +		goto exit_test_mode;
> > +
> > +	x_res = be16_to_cpu(conf.x_res);
> > +	y_res = be16_to_cpu(conf.y_res);
> > +	hx->max_fingers = (conf.max_pt & 0xf0) >> 4;
> > +	dev_dbg(dev, "x res: %d, y res: %d, max fingers: %d\n",
> > +		x_res, y_res, hx->max_fingers);
> > +
> > +	if (hx->max_fingers > HX852X_MAX_FINGERS) {
> > +		dev_err(dev, "max supported fingers: %d, found: %d\n",
> > +			HX852X_MAX_FINGERS, hx->max_fingers);
> > +		error = -EINVAL;
> > +		goto exit_test_mode;
> > +	}
> > +
> > +	if (x_res && y_res) {
> > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_X, 0, x_res - 1, 0, 0);
> > +		input_set_abs_params(hx->input_dev, ABS_MT_POSITION_Y, 0, y_res - 1, 0, 0);
> > +	}
> > +
> > +exit_test_mode:
> > +	i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
> 
> Nit: it would still be nice to preserve as many return values as possible, perhaps
> as follows:
> 
> +exit_test_mode:
> 	error = i2c_smbus_write_byte_data(...) ? : error;
> 
> > +power_off:
> > +	hx852x_power_off(hx);
> > +	return error;
> 
> Similarly, with hx852x_power_off() being promoted to int as suggested above,
> this could be:
> 
> 	return hx852x_power_off(...) ? : error;
> 
> There are other idiomatic ways to do the same thing based on your preference.
> Another (perhaps more clear) option would be to move some of these test mode
> functions into a helper, which would also avoid some goto statements.
> 

I played with this for a bit. A problem of the "? : error" approach is
that it hides the original error in case the new calls error again.

Let's assume

	error = hx852x_start(hx);
	if (error)
		goto power_off;

fails with error = -ENXIO. We jump to power_off:

power_off:
	return hx852x_power_off(hx) ? : error;

Let's say for whatever reason hx852x_power_off() fails too but returns
-EINVAL. Then the final return value will be -EINVAL, while with the
current approach in this patch it would return the original cause
(-ENXIO). I think that's more clear.

I also played with moving code to a separate function to avoid the
gotos, but I feel like that makes the fairly focused logic of this
function (reading the configuration by temporarily entering the test
mode) just more confusing.

To still fix the error handling I ended up with duplicating the
"success" code path and the "error" code path (it's just two function
calls), i.e.:

	error = i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
	if (error)
		goto err_power_off;

	return hx852x_power_off(hx);

err_test_mode:
	i2c_smbus_write_byte_data(hx->client, HX852X_REG_SRAM_SWITCH, 0);
err_power_off:
	hx852x_power_off(hx);
	return error;

I hope that's fine too. A bit ugly maybe but in this case I would prefer
having the main code path (reading the configuration) clearly readable.

Let me know if you have a better suggestion for these (I'll send v2 in a
bit so that you can see the full diff there).

Thanks!
Stephan
