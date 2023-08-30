Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8211778DDE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbjH3Sy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbjH3Lb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 07:31:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3BC1B0;
        Wed, 30 Aug 2023 04:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693395115; x=1724931115;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=klUOrnS68kiYHJSvp43FiBRWNuZaWII5hwctFS+95Wc=;
  b=TehUcdBKgG4kkIaptvuP5GvmbkdpMyA9sUA4B3jHY73iucIXJiFsked3
   Cs5ubd6+y0XWVpeUojewakSGL9++rjAyvFquBrt8W32lpyL4xYXcfQrUy
   0LRXXMLz2f4oOptLvwf25JrXvfblgweJZz5VPZNwcx2IUbExTUvx2i0Sy
   XYJ2rK7sB91WqYA52KgBIpLnBavhTxt9xhoUSd3cguoOvqg0CezxIJ/E9
   9MK6oHl1hDNTCdrG6Sst2eXWa9g9alAAtrL+BzlczBHNhPxVieJrEFSJd
   FK6rqJt117iw8YIrmLrMI0N7TnI0gj6Y6RAvZUXike5fqQidiT38jHp7z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406615821"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="406615821"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 04:31:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="882721329"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.251.213.104])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 04:31:57 -0700
Date:   Wed, 30 Aug 2023 14:31:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Luke D. Jones" <luke@ljones.dev>
cc:     hdegoede@redhat.com, corentin.chary@gmail.com,
        markgross@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: corrections to egpu safety
 check
In-Reply-To: <20230830022908.36264-2-luke@ljones.dev>
Message-ID: <24d07d16-5562-3737-7fe0-827b5145f2a8@linux.intel.com>
References: <20230830022908.36264-1-luke@ljones.dev> <20230830022908.36264-2-luke@ljones.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Aug 2023, Luke D. Jones wrote:

> An incorrect if statement was preventing the enablement of the egpu.
> 
> Fixes: d49f4d1a30ac ("platform/x86: asus-wmi: don't allow eGPU switching if eGPU not connected")
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Please don't leave extra spaces into tags block.

> ---
>  drivers/platform/x86/asus-wmi.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 9783893d2d6e..f54178d6f780 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -726,19 +726,18 @@ static ssize_t egpu_enable_store(struct device *dev,
>  		return -EINVAL;
>  
>  	err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
> -	if (err < 0)
> -		return err;
> -	if (err < 1) {
> -		err = -ENODEV;
> -		pr_warn("Failed to set egpu disable: %d\n", err);
> +	if (err < 0) {
> +		pr_warn("Failed to get egpu connection status: %d\n", err);

So this is the Fixes: part? You should make own patch out of it.

>  		return err;
>  	}
>  
>  	if (asus->gpu_mux_mode_available) {
>  		result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_GPU_MUX);
> -		if (result < 0)
> +		if (result < 0) {
>  			/* An error here may signal greater failure of GPU handling */
> +			pr_warn("Failed to get gpu mux status: %d\n", err);
>  			return result;
> +		}
>  		if (!result && enable) {
>  			err = -ENODEV;
>  			pr_warn("Can not enable eGPU when the MUX is in dGPU mode: %d\n", err);
> @@ -748,12 +747,12 @@ static ssize_t egpu_enable_store(struct device *dev,
>  
>  	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
>  	if (err) {
> -		pr_warn("Failed to set egpu disable: %d\n", err);
> +		pr_warn("Failed to set egpu state: %d\n", err);
>  		return err;
>  	}
>  
>  	if (result > 1) {
> -		pr_warn("Failed to set egpu disable (retval): 0x%x\n", result);
> +		pr_warn("Failed to set egpu state (retval): 0x%x\n", result);
>  		return -EIO;
>  	}
>  
> 

These others are good changes too but just not to be made in the same 
patch.


-- 
 i.



