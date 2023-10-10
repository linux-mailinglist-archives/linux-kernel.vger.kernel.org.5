Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F627BF285
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 07:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442146AbjJJF4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 01:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378119AbjJJF4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 01:56:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657FD9F;
        Mon,  9 Oct 2023 22:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696917361; x=1728453361;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aWq9hwV/A6/bUaNv4YsOmbsmfw4MDHlv+vchRo9plSw=;
  b=gKL3bUbbSYkKCMEIFVXFEDYDEx7U1s6Cyq32SsJ79AXotr50zuIUBnZq
   WO6bjSkLRL/bwExbD90vKOixtJb9qKa16C3d8E7EiZTuDlreib1QcJbEA
   pMPUgcTfpAzC7s3SsxHdb84MV875uFZvY68a9OuU2qQWFmPmSJ6mwxIZd
   /qavOsVL3CkddLOjTuqzyEetdNWBSJsE/zSEJ9hM/CfK1Vm8wNPT6wNXV
   mLND76hq6SCoenruDXjg3R26/AdyktDvQceAVHd1q8B6gyd46ue+ptrBK
   J3V1qryRP6/Vn0tnuA9a01sqt6zVSLazgvebWoVbIO9vlXZHUr8CDnJ3i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="363665663"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="363665663"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 22:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="869543017"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="869543017"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga002.fm.intel.com with SMTP; 09 Oct 2023 22:55:57 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 10 Oct 2023 08:55:56 +0300
Date:   Tue, 10 Oct 2023 08:55:56 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v10 5/9] USB: typec: tps6598x: Add device data to
 of_device_id
Message-ID: <ZSTnbGdYp1/yaIf2@kuha.fi.intel.com>
References: <20231003155842.57313-1-alkuor@gmail.com>
 <20231003155842.57313-6-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003155842.57313-6-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:58:38AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> Part of tps6598x refactoring, we need to move the following functions
> to device data as tps25750 has different implementation than tps6598x
> and cd321x:
> - interrupt handler
> - port registration
> - power status trace
> - status trace
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v10:
>   - Move 0005-USB-typec-tps6598x-Check-for-EEPROM-present.patch to patch 6
>   - Add device data for tps6598x and cd321x
> Changes in v9:
>   - No changes
> Changes in v8:
>   - No changes
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6: 
>   - Update eeprom macro to use TPS instead
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
>  drivers/usb/typec/tipd/core.c | 57 ++++++++++++++++++++++++++---------
>  1 file changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 56e4997c484a..9c973ffb4c49 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -82,6 +82,15 @@ static const char *const modes[] = {
>  /* Unrecognized commands will be replaced with "!CMD" */
>  #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
>  
> +struct tps6598x;
> +
> +struct tipd_data {
> +	irq_handler_t irq_handler;
> +	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
> +	void (*trace_power_status)(u16 status);
> +	void (*trace_status)(u32 status);
> +};
> +
>  struct tps6598x {
>  	struct device *dev;
>  	struct regmap *regmap;
> @@ -101,7 +110,8 @@ struct tps6598x {
>  	int wakeup;
>  	u16 pwr_status;
>  	struct delayed_work	wq_poll;
> -	irq_handler_t irq_handler;
> +
> +	const struct tipd_data *data;
>  };
>  
>  static enum power_supply_property tps6598x_psy_props[] = {
> @@ -432,7 +442,9 @@ static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
>  		dev_err(tps->dev, "%s: failed to read status\n", __func__);
>  		return false;
>  	}
> -	trace_tps6598x_status(*status);
> +
> +	if (tps->data->trace_status)
> +		tps->data->trace_status(*status);
>  
>  	return true;
>  }
> @@ -463,7 +475,9 @@ static bool tps6598x_read_power_status(struct tps6598x *tps)
>  		return false;
>  	}
>  	tps->pwr_status = pwr_status;
> -	trace_tps6598x_power_status(pwr_status);
> +
> +	if (tps->data->trace_power_status)
> +		tps->data->trace_power_status(pwr_status);
>  
>  	return true;
>  }
> @@ -581,7 +595,7 @@ static void tps6598x_poll_work(struct work_struct *work)
>  	struct tps6598x *tps = container_of(to_delayed_work(work),
>  					    struct tps6598x, wq_poll);
>  
> -	tps->irq_handler(0, tps);
> +	tps->data->irq_handler(0, tps);
>  	queue_delayed_work(system_power_efficient_wq,
>  			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
>  }
> @@ -765,7 +779,6 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
>  
>  static int tps6598x_probe(struct i2c_client *client)
>  {
> -	irq_handler_t irq_handler = tps6598x_interrupt;
>  	struct device_node *np = client->dev.of_node;
>  	struct tps6598x *tps;
>  	struct fwnode_handle *fwnode;
> @@ -807,7 +820,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  			APPLE_CD_REG_INT_DATA_STATUS_UPDATE |
>  			APPLE_CD_REG_INT_PLUG_EVENT;
>  
> -		irq_handler = cd321x_interrupt;
>  	} else {
>  		/* Enable power status, data status and plug event interrupts */
>  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
> @@ -815,7 +827,10 @@ static int tps6598x_probe(struct i2c_client *client)
>  			TPS_REG_INT_PLUG_EVENT;
>  	}
>  
> -	tps->irq_handler = irq_handler;
> +	tps->data = device_get_match_data(tps->dev);
> +	if (!tps->data)
> +		return -EINVAL;
> +
>  	/* Make sure the controller has application firmware running */
>  	ret = tps6598x_check_mode(tps);
>  	if (ret)
> @@ -825,10 +840,10 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
> -	if (ret < 0)
> +	if (!tps6598x_read_status(tps, &status)) {
> +		ret = -ENODEV;
>  		goto err_clear_mask;
> -	trace_tps6598x_status(status);
> +	}
>  
>  	/*
>  	 * This fwnode has a "compatible" property, but is never populated as a
> @@ -851,7 +866,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	if (ret)
>  		goto err_role_put;
>  
> -	ret = tps6598x_register_port(tps, fwnode);
> +	ret = tps->data->register_port(tps, fwnode);
>  	if (ret)
>  		goto err_role_put;
>  
> @@ -868,7 +883,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  
>  	if (client->irq) {
>  		ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> -						irq_handler,
> +						tps->data->irq_handler,
>  						IRQF_SHARED | IRQF_ONESHOT,
>  						dev_name(&client->dev), tps);
>  	} else {
> @@ -954,9 +969,23 @@ static const struct dev_pm_ops tps6598x_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(tps6598x_suspend, tps6598x_resume)
>  };
>  
> +static const struct tipd_data cd321x_data = {
> +	.irq_handler = cd321x_interrupt,
> +	.register_port = tps6598x_register_port,
> +	.trace_power_status = trace_tps6598x_power_status,
> +	.trace_status = trace_tps6598x_status,
> +};
> +
> +static const struct tipd_data tps6598x_data = {
> +	.irq_handler = tps6598x_interrupt,
> +	.register_port = tps6598x_register_port,
> +	.trace_power_status = trace_tps6598x_power_status,
> +	.trace_status = trace_tps6598x_status,
> +};
> +
>  static const struct of_device_id tps6598x_of_match[] = {
> -	{ .compatible = "ti,tps6598x", },
> -	{ .compatible = "apple,cd321x", },
> +	{ .compatible = "ti,tps6598x", &tps6598x_data},
> +	{ .compatible = "apple,cd321x", &cd321x_data},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, tps6598x_of_match);
> -- 
> 2.34.1

-- 
heikki
