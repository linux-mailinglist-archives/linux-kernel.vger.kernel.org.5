Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2497B6065
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 07:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbjJCF2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 01:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjJCF2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 01:28:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BC1AD;
        Mon,  2 Oct 2023 22:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696310922; x=1727846922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=203ognjAhnNOsI/vtF++RU0GEWWjqcYC0JjAaxaiY6w=;
  b=h6Ckbp4+b4DuqWQ73vsscdp2lhi3eEUSQdnIUg8K1Ao4nHs5L3YbFDph
   6wJG5TxtjLmm/j5L089na3fCKJ410NB73wkfyPtAr8qjSaWKhw6Y3SR+y
   NfN9KRsg0nB09vIa+knrVXA8tXKcpYWwBUjoiYFp/C3IQGMSZ3V01lIeU
   ODkddcAiIorrRVKXEjjmjLboiv1P+ccjHcHv6Pi3Ze67EI+TTiP+Fy781
   1uJBXJqZAIuBsZDbCnSecgsf0VILEKDZFz6EmcG8m4D5ewhMc6n9xuLsX
   5l4UDJXofIICGlC2wPngK8nLx/1wbTZRj9URhMkJsmieXYrYMtdR9L0w3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="380072528"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="380072528"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 22:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="821110122"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="821110122"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga004.fm.intel.com with SMTP; 02 Oct 2023 22:28:38 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Oct 2023 08:28:37 +0300
Date:   Tue, 3 Oct 2023 08:28:37 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 03/14] USB: typec: tps6598x: Add patch mode to tps6598x
Message-ID: <ZRumhX32sb9atoPQ@kuha.fi.intel.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-4-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001081134.37101-4-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:11:23AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 has a patch mode indicating the device requires
> a configuration to get the device into operational mode
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v9:
>   - No changes
> Changes in v8:
>   - Revert mode check return
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6:
>   - Return current mode and check it directly
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
> 
>  drivers/usb/typec/tipd/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 32420c61660d..c5bbf03cb74a 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -68,6 +68,7 @@ enum {
>  	TPS_MODE_BOOT,
>  	TPS_MODE_BIST,
>  	TPS_MODE_DISC,
> +	TPS_MODE_PTCH,
>  };
>  
>  static const char *const modes[] = {
> @@ -75,6 +76,7 @@ static const char *const modes[] = {
>  	[TPS_MODE_BOOT]	= "BOOT",
>  	[TPS_MODE_BIST]	= "BIST",
>  	[TPS_MODE_DISC]	= "DISC",
> +	[TPS_MODE_PTCH] = "PTCH",
>  };
>  
>  /* Unrecognized commands will be replaced with "!CMD" */
> @@ -595,6 +597,7 @@ static int tps6598x_check_mode(struct tps6598x *tps)
>  
>  	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
>  	case TPS_MODE_APP:
> +	case TPS_MODE_PTCH:
>  		return 0;
>  	case TPS_MODE_BOOT:
>  		dev_warn(tps->dev, "dead-battery condition\n");
> -- 
> 2.34.1

-- 
heikki
