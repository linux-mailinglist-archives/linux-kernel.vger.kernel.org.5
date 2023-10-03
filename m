Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AFA7B606F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjJCFeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjJCFeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:34:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3819B3;
        Mon,  2 Oct 2023 22:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696311257; x=1727847257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RCj7WyluIUsq7v8E4Prf3L0fuZhckvzQbOsAkGXe6P8=;
  b=fRBZXueXaHfsatylMxW1vle489ts7zRZ5Z63i70PzX02IXEsyfTNon/k
   4MrSj2LXnj9EbHaDhqvZ7I26OSMpmF6Ogo7SaxybSecHP1vJPWs/6mwio
   nwbApRDH66W9Ber1KvySnIsDFYv2iNDpC+onEo7I3YgEGNsS1firD/CuZ
   D7IM2ANnHVEXu/WuZ2WDyHmaHMaelW6wQhygpWn2xqEhIQh9PO/jhcvLO
   IBLlMknZBlU2LL+wvNHnEjr8xTGK+l1rSNtBrZbHEuezeiyH9La6FXZ/y
   5Irr2BJ60P6MmKMPnuKgAP8HvHoynvaKkk526ddxfIhG7H3SIPuWc0hpd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="449284644"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="449284644"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 22:34:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="841211944"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="841211944"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by FMSMGA003.fm.intel.com with SMTP; 02 Oct 2023 22:34:12 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Oct 2023 08:34:11 +0300
Date:   Tue, 3 Oct 2023 08:34:11 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 05/14] USB: typec: tps6598x: Check for EEPROM present
Message-ID: <ZRun0+pBJ8n6tMZU@kuha.fi.intel.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-6-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001081134.37101-6-alkuor@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:11:25AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> When an EEPROM is present, tps25750 loads the binary configuration from
> EEPROM. Hence, all we need to do is wait for the device to switch to APP
> mode
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

I'm not sure I understand why this needs separate patch, but in any
case:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
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
> 
>  drivers/usb/typec/tipd/core.c     | 13 +++++++++++++
>  drivers/usb/typec/tipd/tps6598x.h |  3 +++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 2e7b9eafaf04..21b0ea2c9627 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -37,6 +37,7 @@
>  #define TPS_REG_STATUS			0x1a
>  #define TPS_REG_SYSTEM_CONF		0x28
>  #define TPS_REG_CTRL_CONF		0x29
> +#define TPS_REG_BOOT_STATUS		0x2D
>  #define TPS_REG_POWER_STATUS		0x3f
>  #define TPS_REG_RX_IDENTITY_SOP		0x48
>  #define TPS_REG_DATA_STATUS		0x5f
> @@ -910,6 +911,17 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  {
>  	int ret;
>  	unsigned long timeout;
> +	u64 status = 0;
> +
> +	ret = tps6598x_block_read(tps, TPS_REG_BOOT_STATUS, &status, 5);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Nothing to be done if the configuration
> +	 * is being loaded from EERPOM
> +	 */
> +	if (status & TPS_BOOT_STATUS_I2C_EEPROM_PRESENT)
> +		goto wait_for_app;
>  
>  	ret = tps25750_start_patch_burst_mode(tps);
>  	if (ret) {
> @@ -921,6 +933,7 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  	if (ret)
>  		return ret;
>  
> +wait_for_app:
>  	timeout = jiffies + msecs_to_jiffies(1000);
>  
>  	do {
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index 527857549d69..a80d0929f3ee 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -199,4 +199,7 @@
>  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
>  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
>  
> +/* BOOT STATUS REG*/
> +#define TPS_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
> +
>  #endif /* __TPS6598X_H__ */
> -- 
> 2.34.1

-- 
heikki
