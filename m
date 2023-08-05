Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA82770F36
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjHEKLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 06:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjHEKLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 06:11:19 -0400
X-Greylist: delayed 160370 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 05 Aug 2023 03:11:18 PDT
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C3E57;
        Sat,  5 Aug 2023 03:11:18 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BDDC940E01E4;
        Sat,  5 Aug 2023 10:11:16 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8Lrv6NCeWlWM; Sat,  5 Aug 2023 10:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1691230274; bh=6jxNM2HNJ2OmJ6Whx9AWVm7NZoxYaNzRw9xh2dqnHXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPT8C4GXPU91sdp4HpxN+XFKNSsmPAfuR0+FLLu5SjICpkJG+JTwtLHSIPl3QousD
         g05mrs/L0KCPsHlB9h7Ie56uhv/OG7PQALHGlgcA5NOrSocz1noXPFZvonGkdeaOeg
         zS9CmY51Fnr8V4CTqtBw0QHeec8dcloQStTW/hDHpvST0XeXAKZF0huYANdfGceRGG
         arkVuLP+PJ2fHD3kcXcIiZ6/0p3aoMQ6QoRMGAyPFiix01u7zV3SXUtT47FyFL8iFi
         qKJ7/Mu7s2TewSX5Ueo4pZ2H84SBq8e4lh+pGtcAax4o1XU4qmbebmtOVN0L0hFnNt
         YvNnJr+8nTKdzuWdKyBrqVVuddyb4ydNR8lZg2UEWfdhu1uel6MJ9gC/IoTwpJ9h4V
         K0zHMD+r85CGSK2g8WY2Eu71778K1b+LbvRxWTEBPXOZRCqLoCkHi9ZgTk4Qk0voBp
         GTc7jC22ED2TUyNq/KVhsK8WENhQiRy02gZLommCEH0rrS4ZwrxdPwVkvicb5TViXs
         c5waEVdrP1RU0YX0BD1LkW01D6BAoWib/9OYIa3vUVeC8noXAixFg7Nzf1sD/UGzkN
         C7nV+eHBFTOCixd6H/Nc9jGYWAlKK7hPY8VQTLqEhPBTAvqjl7dsBIfpj9vJcaFUiG
         t18mkmP4K2jtOGzR0dUD5sh4=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D9F4A40E019D;
        Sat,  5 Aug 2023 10:11:04 +0000 (UTC)
Date:   Sat, 5 Aug 2023 12:10:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, mchehab@kernel.org,
        nchatrad@amd.com, yazen.ghannam@amd.com,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH 5/7] EDAC/amd64: Add Fam19h Model 90h ~ 9fh enumeration
 support
Message-ID: <20230805101059.GMZM4gM4yA9AgBSEpw@fat_crate.local>
References: <20230720125425.3735538-1-muralimk@amd.com>
 <20230720125425.3735538-6-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230720125425.3735538-6-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 12:54:23PM +0000, Muralidhara M K wrote:
> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> Add AMD family 19h Model 90h-9fh. Models 90h-9fh are APUs, and
> they have built-in HBM3 memory. ECC support is enabled by default.
> 
> APU models have a single Data Fabric (DF) per Package. Each DF is
> visible to the OS in the same way as chiplet-based systems like
> Rome and later. However, the Unified Memory Controllers (UMCs) are
> arranged in the same way as GPU-based MI200 devices rather than
> CPU-based systems.
> So, it uses the gpu_ops for enumeration and adds a few fixups.

s/it uses/use/

Imperative tone:

Pls read section "2) Describe your changes" in
Documentation/process/submitting-patches.rst for more details.

> 
> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 65 +++++++++++++++++++++++++++++++--------
>  1 file changed, 53 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 597dae7692b1..45d8093c117a 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -996,12 +996,16 @@ static struct local_node_map {
>  #define LNTM_NODE_COUNT				GENMASK(27, 16)
>  #define LNTM_BASE_NODE_ID			GENMASK(11, 0)
>  
> -static int gpu_get_node_map(void)
> +static int gpu_get_node_map(struct amd64_pvt *pvt)
>  {
>  	struct pci_dev *pdev;
>  	int ret;
>  	u32 tmp;
>  
> +	/* return early for non heterogeneous systems */

Superfluous comment.

> +	if (pvt->F3->device != PCI_DEVICE_ID_AMD_MI200_DF_F3)
> +		return 0;
> +
>  	/*
>  	 * Node ID 0 is reserved for CPUs.
>  	 * Therefore, a non-zero Node ID means we've already cached the values.
> @@ -3851,7 +3855,7 @@ static void gpu_init_csrows(struct mem_ctl_info *mci)
>  
>  			dimm->nr_pages = gpu_get_csrow_nr_pages(pvt, umc, cs);
>  			dimm->edac_mode = EDAC_SECDED;
> -			dimm->mtype = MEM_HBM2;
> +			dimm->mtype = pvt->dram_type;
>  			dimm->dtype = DEV_X16;
>  			dimm->grain = 64;
>  		}
> @@ -3880,6 +3884,9 @@ static bool gpu_ecc_enabled(struct amd64_pvt *pvt)
>  	return true;
>  }
>  
> +/* Base address used for channels selection on GPUs */
> +static u32 gpu_umc_base = 0x50000;

Why isn't this part of amd64_pvt like the rest of the fields?

> +
>  static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
>  {
>  	/*
> @@ -3893,13 +3900,32 @@ static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
>  	 * On GPU nodes channels are selected in 3rd nibble
>  	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
>  	 * HBM chX[7:4]= [Y+1]5X[3:0]000
> +	 *
> +	 * On APU nodes, same as GPU but with diff base 0x90000;

"diff"?

>  	 */
>  	umc *= 2;
>  
>  	if (channel >= 4)
>  		umc++;
>  
> -	return 0x50000 + (umc << 20) + ((channel % 4) << 12);
> +	return gpu_umc_base + (umc << 20) + ((channel % 4) << 12);
> +}
> +

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
