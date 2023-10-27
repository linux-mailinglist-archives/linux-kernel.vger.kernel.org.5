Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820777D9BF5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 16:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345558AbjJ0OqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 10:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjJ0OqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 10:46:15 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF0218F;
        Fri, 27 Oct 2023 07:46:12 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4288440E0173;
        Fri, 27 Oct 2023 14:46:10 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FJu8B9566n5W; Fri, 27 Oct 2023 14:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698417965; bh=LPC8mpeSgp4TsBzPFrqVfjz+tZPR3x2leEpXNZsAuTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aAhsbyz9LLp8achvasUIJp21woMpk7YXH3S9FK9NmzS4qNVW9vhVyAzI1d2whlNlW
         GdwhMxwPIFfyP1XZwk00z+GpKl3DNnpBgIXtCtvZH9uUVzsPxGP/jnDnaKlCX232AS
         1dYkc3zVBzaqvHPbbHB/2+SRCryxqWz59yJiWQnVgp0og+iWuDx72gzJPDAkBP6RH/
         yBTTeETTXbtt9C6HnoVGTwxQ3++rD5St+nd+d6nemMdVuwks7RdHrQ3ZzcPLcVueAL
         ClnvHxInSI83ggMcKwHDOGn8d4/T/dELWrEJjl36sEZqkVRzfIhfsvQ5m16Iua9pwu
         ET/yIfEYCExilWeHDaxeuOxquAG00bXZBFNkubLVl9tzGyB7RV/Can4ucsf7UkMjT6
         pFnWensFp5yJMId/+uwU5vwc1JsoM3vdUEGI0qb57jCjj4GntCN1aIZtmvO4gwlHH+
         MdI2L/oLyvgaNUIQtrXDJLYfqQoie9SbrN1hzX9DzKhIixoBHVmY+xHNBbWlF7Mnd0
         sjyxjphLTB+CIwiGV/SfWoofcRLpUmwZuY9YBQej2OO/1FZ4GWKX1sHdGZ+KxIqnem
         bCFvdULLS8qtvQV10mQteBA/27TG/efzuUlh8pqf4Ko+ad5QHA/8Wd48jDMxCOQMSn
         hgxl+uO81doIs3IGFjO9Hzug=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3346A40E0171;
        Fri, 27 Oct 2023 14:46:00 +0000 (UTC)
Date:   Fri, 27 Oct 2023 16:45:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Muralidhara M K <muralimk@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, Muralidhara M K <muralidhara.mk@amd.com>
Subject: Re: [PATCH v2 4/4] EDAC/amd64: Add Family 19h Models 90h ~ 9fh
 enumeration support
Message-ID: <20231027144552.GGZTvNIE7g1S3jBM72@fat_crate.local>
References: <20231025051455.101424-1-muralimk@amd.com>
 <20231025051455.101424-5-muralimk@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025051455.101424-5-muralimk@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 05:14:55AM +0000, Muralidhara M K wrote:
> Subject: Re: [PATCH v2 4/4] EDAC/amd64: Add Family 19h Models 90h ~ 9fh enumeration support

"Add support for family 0x19, models 0x90-9f devices"

> From: Muralidhara M K <muralidhara.mk@amd.com>
> 
> AMD Models 90h-9fh are APUs, They have built-in HBM3 memory.

s/,/./

> ECC support is enabled by default.
> 
> APU models have a single Data Fabric (DF) per Package. Each DF is
> visible to the OS in the same way as chiplet-based systems like
> Rome and later. However, the Unified Memory Controllers (UMCs) are

s/Rome/Zen2 CPUs/

> arranged in the same way as GPU-based MI200 devices rather than
> CPU-based systems.
>
> So, use the gpu_ops for enumeration and adds a few fixups to
> support enumeration of nodes and memory topology.

Do not talk about *what* the patch is doing in the commit message - that
should be obvious from the diff itself. Rather, concentrate on the *why*
it needs to be done.

> Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
> ---
>  drivers/edac/amd64_edac.c | 69 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
> index 9b6642d00871..82302393894c 100644
> --- a/drivers/edac/amd64_edac.c
> +++ b/drivers/edac/amd64_edac.c
> @@ -996,12 +996,19 @@ static struct local_node_map {
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
> +	/* Mapping of nodes from hardware-provided AMD Node ID to a Linux logical

verify_comment_style: WARNING: Multi-line comment needs to start text on the second line:
 [+     /* Mapping of nodes from hardware-provided AMD Node ID to a Linux logical]

> +	 * one is applicable for MI200 models.
> +	 * Therefore return early for other heterogeneous systems.
> +	 */
> +	if (pvt->F3->device != PCI_DEVICE_ID_AMD_MI200_DF_F3)
> +		return 0;
> +
>  	/*
>  	 * Node ID 0 is reserved for CPUs.
>  	 * Therefore, a non-zero Node ID means we've already cached the values.
> @@ -3851,7 +3858,7 @@ static void gpu_init_csrows(struct mem_ctl_info *mci)
>  
>  			dimm->nr_pages = gpu_get_csrow_nr_pages(pvt, umc, cs);
>  			dimm->edac_mode = EDAC_SECDED;
> -			dimm->mtype = MEM_HBM2;
> +			dimm->mtype = pvt->dram_type;
>  			dimm->dtype = DEV_X16;
>  			dimm->grain = 64;
>  		}
> @@ -3880,6 +3887,9 @@ static bool gpu_ecc_enabled(struct amd64_pvt *pvt)
>  	return true;
>  }
>  
> +/* Base address used for channels selection on MI200 GPUs */
> +static u32 gpu_umc_base = 0x50000;

That gpu_umc_base assignment can happen in per_family_init() too.

> +
>  static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
>  {
>  	/*
> @@ -3893,13 +3903,33 @@ static inline u32 gpu_get_umc_base(u8 umc, u8 channel)
>  	 * On GPU nodes channels are selected in 3rd nibble
>  	 * HBM chX[3:0]= [Y  ]5X[3:0]000;
>  	 * HBM chX[7:4]= [Y+1]5X[3:0]000
> +	 *
> +	 * On MI300 APU nodes, same as GPU nodes but channels are selected
> +	 * in the base address of 0x90000
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
> +static void gpu_determine_memory_type(struct amd64_pvt *pvt)
> +{
> +	if (pvt->fam == 0x19) {
> +		switch (pvt->model) {
> +		case 0x30 ... 0x3F:
> +			pvt->dram_type = MEM_HBM2;
> +			break;
> +		case 0x90 ... 0x9F:
> +			pvt->dram_type = MEM_HBM3;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	edac_dbg(1, "  MEM type: %s\n", edac_mem_types[pvt->dram_type]);

That whole assignment can happen in per_family_init() - no need for that
function here.

>  static void gpu_read_mc_regs(struct amd64_pvt *pvt)
> @@ -3960,7 +3990,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
>  {
>  	int ret;
>  
> -	ret = gpu_get_node_map();
> +	ret = gpu_get_node_map(pvt);
>  	if (ret)
>  		return ret;
>  
> @@ -3971,6 +4001,7 @@ static int gpu_hw_info_get(struct amd64_pvt *pvt)
>  	gpu_prep_chip_selects(pvt);
>  	gpu_read_base_mask(pvt);
>  	gpu_read_mc_regs(pvt);
> +	gpu_determine_memory_type(pvt);
>  
>  	return 0;
>  }
> @@ -4142,6 +4173,12 @@ static int per_family_init(struct amd64_pvt *pvt)
>  			pvt->ctl_name			= "F19h_M70h";
>  			pvt->flags.zn_regs_v2		= 1;
>  			break;
> +		case 0x90 ... 0x9f:
> +			pvt->ctl_name			= "F19h_M90h";
> +			pvt->max_mcs			= 4;
> +			gpu_umc_base			= 0x90000;
> +			pvt->ops			= &gpu_ops;
> +			break;
>  		case 0xa0 ... 0xaf:
>  			pvt->ctl_name			= "F19h_MA0h";
>  			pvt->max_mcs			= 12;
> @@ -4180,23 +4217,31 @@ static const struct attribute_group *amd64_edac_attr_groups[] = {
>  	NULL
>  };
>  
> +/*
> + * For Heterogeneous and APU models EDAC CHIP_SELECT and CHANNEL layers

s/Heterogeneous/heterogeneous/

> + * should be swapped to fit into the layers.
> + */
> +static unsigned int get_layer_size(struct amd64_pvt *pvt, u8 layer)
> +{
> +	bool is_gpu = (pvt->ops == &gpu_ops);
> +
> +	if (!layer)
> +		return is_gpu ? pvt->max_mcs : pvt->csels[0].b_cnt;
> +
> +	return is_gpu ? pvt->csels[0].b_cnt : pvt->max_mcs;

Balance that for better readability:

        if (!layer)
                return is_gpu ? pvt->max_mcs
			      : pvt->csels[0].b_cnt;
	else
		return is_gpu ? pvt->csels[0].b_cnt
			      : pvt->max_mcs;


Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
