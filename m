Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AF57B60A0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbjJCGEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjJCGEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:04:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72ADEB7;
        Mon,  2 Oct 2023 23:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696313048; x=1727849048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PQoOxp5uH3JSr9lFmLJ6gLBj5jlaiqqD/shujUnKOuk=;
  b=UO3Zdm59gSfZd8IvXl/V5XfUTw3NI3liOg5laozSSd3O3zgE4WNTB54I
   b1675aK3XJ/I77cuRzGrItnjn2qViTLgD1PumswoONzv3mSzJD3USP1L/
   dc+CH2o2G/gS1PrFdmXMvOGdcrBm4DID3/eMkWb8UJ4ksC9J5G8ss0kzb
   48ghB3G/19kFzHy0C803tdJzf1A88GvugX7yGfUEPWyLFkldkpMtHaSaW
   1NYmLKRGfw2D5uhoZBJ+jaCeVrb6qX8K+yQiA7cPIwE0mPRZWfw5hatv5
   MpKaHY25t2xwX0T4ixSny2lNE/kwgFMrd81n9PcCg41FC30b+6qWXx6NH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="469074427"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="469074427"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:03:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="924525370"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="924525370"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga005.jf.intel.com with SMTP; 02 Oct 2023 23:03:43 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Oct 2023 09:03:42 +0300
Date:   Tue, 3 Oct 2023 09:03:42 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 06/14] USB: typec: tps6598x: Clear dead battery flag
Message-ID: <ZRuuvj3r1kBqc+EI@kuha.fi.intel.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-7-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001081134.37101-7-alkuor@gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:11:26AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> Dead battery flag must be cleared after switching tps25750 to APP mode
> so the PD controller becomes fully functional.
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

I'm sorry I noticed these so late, but this one really feels like it
should be part of the patch 4/14. Is there some reason why you do this
separately?

> ---
> Changes in v9:
>   - No changes
> Changes in v8:
>   - No changes
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6:
>   - No changes
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
> 
>  drivers/usb/typec/tipd/core.c     | 16 ++++++++++++++++
>  drivers/usb/typec/tipd/tps6598x.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 21b0ea2c9627..2598433a69cf 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -946,6 +946,22 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  
>  	} while (ret != TPS_MODE_APP);
>  
> +	/*
> +	 * The dead battery flag may be triggered when the controller
> +	 * port is connected to a device that can source power and
> +	 * attempts to power up both the controller and the board it is on.
> +	 * To restore controller functionality, it is necessary to clear
> +	 * this flag
> +	 */
> +	if (status & TPS_BOOT_STATUS_DEAD_BATTERY_FLAG) {
> +		ret = tps6598x_exec_cmd(tps, "DBfg", 0, NULL, 0, NULL);
> +		if (ret) {
> +			dev_err(tps->dev,
> +				"failed to clear dead battery %d\n", ret);

One line is enough.

> +			return ret;
> +		}
> +	}
> +
>  	dev_info(tps->dev, "controller switched to \"APP\" mode\n");
>  
>  	return 0;
> diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
> index a80d0929f3ee..c000170f4547 100644
> --- a/drivers/usb/typec/tipd/tps6598x.h
> +++ b/drivers/usb/typec/tipd/tps6598x.h
> @@ -200,6 +200,7 @@
>  #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
>  
>  /* BOOT STATUS REG*/
> +#define TPS_BOOT_STATUS_DEAD_BATTERY_FLAG	BIT(2)
>  #define TPS_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
>  
>  #endif /* __TPS6598X_H__ */
> -- 
> 2.34.1

Br,

-- 
heikki
