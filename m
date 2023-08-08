Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4CA87741BF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234640AbjHHR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjHHR1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:27:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D527AA0;
        Tue,  8 Aug 2023 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691511106; x=1723047106;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=N0XoAVAbIxvMxMXqpn4PG97oXQGfuyCdgFNxzbmTuI8=;
  b=lkH2QWcdRgLAUnkSKeqTg0ZKoGHmT2Hbdp4h8zVZDIjneqm1V/HV5oM5
   PNk2lRWZQJUnE/ab+QXpFH+zzxufI8yhhqlrNufwlyn1cS/T0cTL3tYm4
   SqUNDgEjJlrKiaFtlyLspnzcoXz778KD8nygorJAM6sQiUYScSH8JApf5
   hSGJ5Alm5hp1ab9lkhgChjkf+vjcY7eqzvbyjT/DuhMHF5SqAwxDFHq0P
   sb0t0MqxN1QJtqIBlnDkMg15np2C36aRBqigyQ2GB5Awp29opVy+OJ674
   1GhAZgSD/fFUxTmKgaNOhbB2+idiuGX3rZSJtN6fCas4YQz+7ft9vOsPN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="355709364"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="355709364"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:35:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977781148"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977781148"
Received: from romanagn-mobl1.ger.corp.intel.com (HELO [10.252.49.59]) ([10.252.49.59])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:35:54 -0700
Message-ID: <7fd8bf2e-e7be-4bc9-b153-b156cf5ac090@linux.intel.com>
Date:   Tue, 8 Aug 2023 12:37:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: tpm_tis: Fix UPX-i11 DMI_PRODUCT_VERSION string
Content-Language: en-US
To:     peterhuewe@gmx.de, jarkko@kernel.org
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        jsnitsel@redhat.com, pmenzel@molgen.mpg.de
References: <20230808061816.15695-1-peter.ujfalusi@linux.intel.com>
From:   =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <20230808061816.15695-1-peter.ujfalusi@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/08/2023 09:18, Peter Ujfalusi wrote:
> The patch which made it to the kernel somehow lost the "01" from the
> string, making the match to not work anymore.
> 
> Link: https://lore.kernel.org/lkml/20230524085844.11580-1-peter.ujfalusi@linux.intel.com/
> Fixes: edb13d7bb034 ("tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11")
> ---
> Hi Jarkko,
> 
> Can you send this patch for the 6.5 cycle?
> edb13d7bb034 was applied in 6.5-rc3 and I just updated my work tree to notice
> the regression.
> 
> Thank you,
> Peter
> 
>  drivers/char/tpm/tpm_tis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index ac4daaf294a3..2bb9901a329a 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -183,7 +183,7 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
>  		.ident = "UPX-TGL",
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
> -			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL"),
> +			DMI_MATCH(DMI_PRODUCT_VERSION, "UPX-TGL01"),

The DMI property also got changed in the applied patch, it should have
been DMI_PRODUCT_NAME, I will send v2 shortly, please ignore this version

>  		},
>  	},
>  	{}

-- 
Péter
