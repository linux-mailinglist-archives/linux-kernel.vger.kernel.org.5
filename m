Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7DB76E3D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjHCJCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbjHCJBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:01:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3013E1982;
        Thu,  3 Aug 2023 02:01:48 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 59F486607194;
        Thu,  3 Aug 2023 10:01:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691053307;
        bh=mo564y8hFa/EzVh7qwCL5UykbUxG4b6tEvI+MxJGikw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mHM2KLlxcj8vE4iivWpwQTmO4tQW40qiJm0K7SuA9r6/i2yNW0CTCN+YRvQBvj/K7
         b6PjWAmzz+wOQBcIOIVhv+OHAz3+CYTqYXxnqX3kzzxj/DOik/WQKeDZaMA1kWtJpw
         BdXBWJN7UNZlatdRVOl6DkTfIcpxHT0+OslAdjDiYQcYCjBNwCZ6t0PmuETFRrQr+C
         4w3aQmGBKc9IE5DLXU01m0fV2i1ysJYPJy5JJFXljjJj7trSwRoO0tsyl2AUN8A/HI
         ZehnRa246fWmIDhycV1bTuZCCGu3ctTX88hLcozhlPOyVaDUaCh8sYNFuXJeGgZ7Oz
         gUGB9DFxmsVtw==
Message-ID: <06473794-8c9f-5c55-b14a-db326d4ab5e9@collabora.com>
Date:   Thu, 3 Aug 2023 11:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/9] regulator: mt6358: fix and drop type prefix in MT6366
 regulator node names
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230803074249.3065586-1-wenst@chromium.org>
 <20230803074249.3065586-6-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230803074249.3065586-6-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/08/23 09:42, Chen-Yu Tsai ha scritto:
> The new MT6366 binding does away with the type prefix ("buck_", "ldo_")
> in the regulator node names. This better matches the PMIC pin names.
> Remaining underscores in names are also replaced with hyphens.
> 
> Drop the type prefixes and replace remaining underscores to match the
> MT6366 binding.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

There is *no upstream devicetree* using any of those names, as the first devices
that will use the MT6366 will be MT8186 Corsola, which are not upstreamed yet.

This means that this commit does not break ABI, so, I agree - which implies....

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers,
Angelo

> ---
>   drivers/regulator/mt6358-regulator.c | 70 ++++++++++++++--------------
>   1 file changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
> index 3cb2e6768e25..5a43a84c7a3e 100644
> --- a/drivers/regulator/mt6358-regulator.c
> +++ b/drivers/regulator/mt6358-regulator.c
> @@ -536,68 +536,68 @@ static const struct mt6358_regulator_info mt6358_regulators[] = {
>   
>   /* The array is indexed by id(MT6366_ID_XXX) */
>   static const struct mt6358_regulator_info mt6366_regulators[] = {
> -	MT6366_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
> +	MT6366_BUCK("vdram1", VDRAM1, 500000, 2087500, 12500,
>   		    0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f, MT6358_VDRAM1_ANA_CON0, 8),
> -	MT6366_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
> +	MT6366_BUCK("vcore", VCORE, 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 1),
> -	MT6366_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
> +	MT6366_BUCK("vpa", VPA, 500000, 3650000, 50000,
>   		    0x3f, MT6358_BUCK_VPA_DBG0, 0x3f, MT6358_VPA_ANA_CON0, 3),
> -	MT6366_BUCK("buck_vproc11", VPROC11, 500000, 1293750, 6250,
> +	MT6366_BUCK("vproc11", VPROC11, 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 1),
> -	MT6366_BUCK("buck_vproc12", VPROC12, 500000, 1293750, 6250,
> +	MT6366_BUCK("vproc12", VPROC12, 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 2),
> -	MT6366_BUCK("buck_vgpu", VGPU, 500000, 1293750, 6250,
> +	MT6366_BUCK("vgpu", VGPU, 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 2),
> -	MT6366_BUCK("buck_vs2", VS2, 500000, 2087500, 12500,
> +	MT6366_BUCK("vs2", VS2, 500000, 2087500, 12500,
>   		    0x7f, MT6358_BUCK_VS2_DBG0, 0x7f, MT6358_VS2_ANA_CON0, 8),
> -	MT6366_BUCK("buck_vmodem", VMODEM, 500000, 1293750, 6250,
> +	MT6366_BUCK("vmodem", VMODEM, 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f, MT6358_VMODEM_ANA_CON0, 8),
> -	MT6366_BUCK("buck_vs1", VS1, 1000000, 2587500, 12500,
> +	MT6366_BUCK("vs1", VS1, 1000000, 2587500, 12500,
>   		    0x7f, MT6358_BUCK_VS1_DBG0, 0x7f, MT6358_VS1_ANA_CON0, 8),
> -	MT6366_REG_FIXED("ldo_vrf12", VRF12,
> +	MT6366_REG_FIXED("vrf12", VRF12,
>   			 MT6358_LDO_VRF12_CON0, 0, 1200000),
> -	MT6366_REG_FIXED("ldo_vio18", VIO18,
> +	MT6366_REG_FIXED("vio18", VIO18,
>   			 MT6358_LDO_VIO18_CON0, 0, 1800000),
> -	MT6366_REG_FIXED("ldo_vcn18", VCN18, MT6358_LDO_VCN18_CON0, 0, 1800000),
> -	MT6366_REG_FIXED("ldo_vfe28", VFE28, MT6358_LDO_VFE28_CON0, 0, 2800000),
> -	MT6366_REG_FIXED("ldo_vcn28", VCN28, MT6358_LDO_VCN28_CON0, 0, 2800000),
> -	MT6366_REG_FIXED("ldo_vxo22", VXO22, MT6358_LDO_VXO22_CON0, 0, 2200000),
> -	MT6366_REG_FIXED("ldo_vaux18", VAUX18,
> +	MT6366_REG_FIXED("vcn18", VCN18, MT6358_LDO_VCN18_CON0, 0, 1800000),
> +	MT6366_REG_FIXED("vfe28", VFE28, MT6358_LDO_VFE28_CON0, 0, 2800000),
> +	MT6366_REG_FIXED("vcn28", VCN28, MT6358_LDO_VCN28_CON0, 0, 2800000),
> +	MT6366_REG_FIXED("vxo22", VXO22, MT6358_LDO_VXO22_CON0, 0, 2200000),
> +	MT6366_REG_FIXED("vaux18", VAUX18,
>   			 MT6358_LDO_VAUX18_CON0, 0, 1800000),
> -	MT6366_REG_FIXED("ldo_vbif28", VBIF28,
> +	MT6366_REG_FIXED("vbif28", VBIF28,
>   			 MT6358_LDO_VBIF28_CON0, 0, 2800000),
> -	MT6366_REG_FIXED("ldo_vio28", VIO28, MT6358_LDO_VIO28_CON0, 0, 2800000),
> -	MT6366_REG_FIXED("ldo_va12", VA12, MT6358_LDO_VA12_CON0, 0, 1200000),
> -	MT6366_REG_FIXED("ldo_vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
> -	MT6366_REG_FIXED("ldo_vaud28", VAUD28,
> +	MT6366_REG_FIXED("vio28", VIO28, MT6358_LDO_VIO28_CON0, 0, 2800000),
> +	MT6366_REG_FIXED("va12", VA12, MT6358_LDO_VA12_CON0, 0, 1200000),
> +	MT6366_REG_FIXED("vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
> +	MT6366_REG_FIXED("vaud28", VAUD28,
>   			 MT6358_LDO_VAUD28_CON0, 0, 2800000),
> -	MT6366_LDO("ldo_vdram2", VDRAM2, vdram2,
> +	MT6366_LDO("vdram2", VDRAM2, vdram2,
>   		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0x10),
> -	MT6366_LDO("ldo_vsim1", VSIM1, vsim,
> +	MT6366_LDO("vsim1", VSIM1, vsim,
>   		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00),
> -	MT6366_LDO("ldo_vibr", VIBR, vibr,
> +	MT6366_LDO("vibr", VIBR, vibr,
>   		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00),
> -	MT6366_LDO("ldo_vusb", VUSB, vusb,
> +	MT6366_LDO("vusb", VUSB, vusb,
>   		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700),
> -	MT6366_LDO("ldo_vefuse", VEFUSE, vefuse,
> +	MT6366_LDO("vefuse", VEFUSE, vefuse,
>   		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00),
> -	MT6366_LDO("ldo_vmch", VMCH, vmch_vemc,
> +	MT6366_LDO("vmch", VMCH, vmch_vemc,
>   		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
> -	MT6366_LDO("ldo_vemc", VEMC, vmch_vemc,
> +	MT6366_LDO("vemc", VEMC, vmch_vemc,
>   		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> -	MT6366_LDO("ldo_vcn33", VCN33, vcn33,
> +	MT6366_LDO("vcn33", VCN33, vcn33,
>   		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
> -	MT6366_LDO("ldo_vmc", VMC, vmc,
> +	MT6366_LDO("vmc", VMC, vmc,
>   		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
> -	MT6366_LDO("ldo_vsim2", VSIM2, vsim,
> +	MT6366_LDO("vsim2", VSIM2, vsim,
>   		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
> -	MT6366_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
> +	MT6366_LDO1("vsram-proc11", VSRAM_PROC11, 500000, 1293750, 6250,
>   		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
> -	MT6366_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
> +	MT6366_LDO1("vsram-others", VSRAM_OTHERS, 500000, 1293750, 6250,
>   		    MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON2, 0x7f),
> -	MT6366_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
> +	MT6366_LDO1("vsram-gpu", VSRAM_GPU, 500000, 1293750, 6250,
>   		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
> -	MT6366_LDO1("ldo_vsram_proc12", VSRAM_PROC12, 500000, 1293750, 6250,
> +	MT6366_LDO1("vsram-proc12", VSRAM_PROC12, 500000, 1293750, 6250,
>   		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
>   };
>   


