Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2B17A7985
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 12:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234245AbjITKoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 06:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233974AbjITKoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 06:44:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6DAC9;
        Wed, 20 Sep 2023 03:44:17 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 00BAC66020EE;
        Wed, 20 Sep 2023 11:44:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695206656;
        bh=NDWVRwmCVk94kKKusMIvqhB611Y4sHX8Uwz9shitv3Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cgSDyH9dtclWR0OSUy5aAVRzfOTr85L9b34Iz6kh20A22ubRHIbnWXQ9rw6drWQg6
         W+Xi+xFXNixr+CAgcIx6QgSA5ycvS+WOKfVknZn4GcSalNiNj6BFS50YxlKP6yYxpz
         zFI5Rt0YxCJHbr503PyY0lbXWOigYmF7qvoBQeJjORc3WxSRhGhoStrH+dQlssAOv/
         j4YeU3+pZZwR0Hzt04Tso4x/NhmOd05awDLDUN6VLO8a+NwvMkmEZrpAo1UMeMa/If
         UzGY1NqN2GpRhvti97Pfz3Bjtgff8ctZpY/IS40YgAE9vlUEr+PaLlpXAGoqSiMxQ9
         kQG5E8O3fwE+A==
Message-ID: <b55b708d-5564-cd98-3b87-243311319f2f@collabora.com>
Date:   Wed, 20 Sep 2023 12:44:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 07/12] regulator: mt6358: Add supply names for MT6358
 regulators
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
References: <20230919104357.3971512-1-wenst@chromium.org>
 <20230919104357.3971512-8-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230919104357.3971512-8-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/23 12:43, Chen-Yu Tsai ha scritto:
> The DT bindings for MT6358 regulator now defines the supply names for the
> PMIC.
> 
> Add support for them by adding .supply_name field settings for each
> regulator.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/regulator/mt6358-regulator.c | 106 +++++++++++++--------------
>   1 file changed, 51 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/regulator/mt6358-regulator.c b/drivers/regulator/mt6358-regulator.c
> index c312e79a0a39..cdb776d30a6d 100644
> --- a/drivers/regulator/mt6358-regulator.c
> +++ b/drivers/regulator/mt6358-regulator.c
> @@ -33,12 +33,13 @@ struct mt6358_regulator_info {
>   
>   #define to_regulator_info(x) container_of((x), struct mt6358_regulator_info, desc)
>   
> -#define MT6358_BUCK(match, vreg, min, max, step,		\
> -	vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
> -	_modeset_reg, _modeset_shift)		\
> +#define MT6358_BUCK(match, vreg, supply, min, max, step,	\
> +		    vosel_mask, _da_vsel_reg, _da_vsel_mask,	\
> +		    _modeset_reg, _modeset_shift)		\
>   [MT6358_ID_##vreg] = {	\
>   	.desc = {	\
>   		.name = #vreg,	\
> +		.supply_name = supply,		\
>   		.of_match = of_match_ptr(match),	\
>   		.ops = &mt6358_volt_range_ops,	\
>   		.type = REGULATOR_VOLTAGE,	\
> @@ -61,10 +62,11 @@ struct mt6358_regulator_info {
>   	.modeset_mask = BIT(_modeset_shift),	\
>   }
>   
> -#define MT6358_LDO(match, vreg, volt_ranges, enreg, enbit, vosel, vosel_mask) \
> +#define MT6358_LDO(match, vreg, supply, volt_ranges, enreg, enbit, vosel, vosel_mask) \
>   [MT6358_ID_##vreg] = {	\
>   	.desc = {	\
>   		.name = #vreg,	\
> +		.supply_name = supply,		\
>   		.of_match = of_match_ptr(match),	\
>   		.ops = &mt6358_volt_table_ops,	\
>   		.type = REGULATOR_VOLTAGE,	\
> @@ -85,12 +87,12 @@ struct mt6358_regulator_info {
>   	.qi = BIT(15),	\
>   }
>   
> -#define MT6358_LDO1(match, vreg, min, max, step,	\
> -	_da_vsel_reg, _da_vsel_mask,	\
> -	vosel, vosel_mask)	\
> +#define MT6358_LDO1(match, vreg, supply, min, max, step,	\
> +		    _da_vsel_reg, _da_vsel_mask, vosel, vosel_mask)	\
>   [MT6358_ID_##vreg] = {	\
>   	.desc = {	\
>   		.name = #vreg,	\
> +		.supply_name = supply,		\
>   		.of_match = of_match_ptr(match),	\
>   		.ops = &mt6358_volt_range_ops,	\
>   		.type = REGULATOR_VOLTAGE,	\
> @@ -110,11 +112,11 @@ struct mt6358_regulator_info {
>   	.qi = BIT(0),	\
>   }
>   
> -#define MT6358_REG_FIXED(match, vreg,	\
> -	enreg, enbit, volt)	\
> +#define MT6358_REG_FIXED(match, vreg, supply, enreg, enbit, volt)	\
>   [MT6358_ID_##vreg] = {	\
>   	.desc = {	\
>   		.name = #vreg,	\
> +		.supply_name = supply,		\
>   		.of_match = of_match_ptr(match),	\
>   		.ops = &mt6358_volt_fixed_ops,	\
>   		.type = REGULATOR_VOLTAGE,	\
> @@ -457,79 +459,73 @@ static const struct regulator_ops mt6358_volt_fixed_ops = {
>   
>   /* The array is indexed by id(MT6358_ID_XXX) */
>   static const struct mt6358_regulator_info mt6358_regulators[] = {
> -	MT6358_BUCK("buck_vdram1", VDRAM1, 500000, 2087500, 12500,
> +	MT6358_BUCK("buck_vdram1", VDRAM1, "vsys-vdram1", 500000, 2087500, 12500,
>   		    0x7f, MT6358_BUCK_VDRAM1_DBG0, 0x7f, MT6358_VDRAM1_ANA_CON0, 8),
> -	MT6358_BUCK("buck_vcore", VCORE, 500000, 1293750, 6250,
> +	MT6358_BUCK("buck_vcore", VCORE, "vsys-vcore", 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VCORE_DBG0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 1),
> -	MT6358_BUCK("buck_vpa", VPA, 500000, 3650000, 50000,
> +	MT6358_BUCK("buck_vpa", VPA, "vsys-vpa", 500000, 3650000, 50000,
>   		    0x3f, MT6358_BUCK_VPA_DBG0, 0x3f, MT6358_VPA_ANA_CON0, 3),
> -	MT6358_BUCK("buck_vproc11", VPROC11, 500000, 1293750, 6250,
> +	MT6358_BUCK("buck_vproc11", VPROC11, "vsys-vproc11", 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VPROC11_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 1),
> -	MT6358_BUCK("buck_vproc12", VPROC12, 500000, 1293750, 6250,
> +	MT6358_BUCK("buck_vproc12", VPROC12, "vsys-vproc12", 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VPROC12_DBG0, 0x7f, MT6358_VPROC_ANA_CON0, 2),
> -	MT6358_BUCK("buck_vgpu", VGPU, 500000, 1293750, 6250,
> +	MT6358_BUCK("buck_vgpu", VGPU, "vsys-vgpu", 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VGPU_ELR0, 0x7f, MT6358_VCORE_VGPU_ANA_CON0, 2),
> -	MT6358_BUCK("buck_vs2", VS2, 500000, 2087500, 12500,
> +	MT6358_BUCK("buck_vs2", VS2, "vsys-vs2", 500000, 2087500, 12500,
>   		    0x7f, MT6358_BUCK_VS2_DBG0, 0x7f, MT6358_VS2_ANA_CON0, 8),
> -	MT6358_BUCK("buck_vmodem", VMODEM, 500000, 1293750, 6250,
> +	MT6358_BUCK("buck_vmodem", VMODEM, "vsys-vmodem", 500000, 1293750, 6250,
>   		    0x7f, MT6358_BUCK_VMODEM_DBG0, 0x7f, MT6358_VMODEM_ANA_CON0, 8),
> -	MT6358_BUCK("buck_vs1", VS1, 1000000, 2587500, 12500,
> +	MT6358_BUCK("buck_vs1", VS1, "vsys-vs1", 1000000, 2587500, 12500,
>   		    0x7f, MT6358_BUCK_VS1_DBG0, 0x7f, MT6358_VS1_ANA_CON0, 8),
> -	MT6358_REG_FIXED("ldo_vrf12", VRF12,
> -			 MT6358_LDO_VRF12_CON0, 0, 1200000),
> -	MT6358_REG_FIXED("ldo_vio18", VIO18,
> -			 MT6358_LDO_VIO18_CON0, 0, 1800000),
> -	MT6358_REG_FIXED("ldo_vcamio", VCAMIO,
> -			 MT6358_LDO_VCAMIO_CON0, 0, 1800000),
> -	MT6358_REG_FIXED("ldo_vcn18", VCN18, MT6358_LDO_VCN18_CON0, 0, 1800000),
> -	MT6358_REG_FIXED("ldo_vfe28", VFE28, MT6358_LDO_VFE28_CON0, 0, 2800000),
> -	MT6358_REG_FIXED("ldo_vcn28", VCN28, MT6358_LDO_VCN28_CON0, 0, 2800000),
> -	MT6358_REG_FIXED("ldo_vxo22", VXO22, MT6358_LDO_VXO22_CON0, 0, 2200000),
> -	MT6358_REG_FIXED("ldo_vaux18", VAUX18,
> -			 MT6358_LDO_VAUX18_CON0, 0, 1800000),
> -	MT6358_REG_FIXED("ldo_vbif28", VBIF28,
> -			 MT6358_LDO_VBIF28_CON0, 0, 2800000),
> -	MT6358_REG_FIXED("ldo_vio28", VIO28, MT6358_LDO_VIO28_CON0, 0, 2800000),
> -	MT6358_REG_FIXED("ldo_va12", VA12, MT6358_LDO_VA12_CON0, 0, 1200000),
> -	MT6358_REG_FIXED("ldo_vrf18", VRF18, MT6358_LDO_VRF18_CON0, 0, 1800000),
> -	MT6358_REG_FIXED("ldo_vaud28", VAUD28,
> -			 MT6358_LDO_VAUD28_CON0, 0, 2800000),
> -	MT6358_LDO("ldo_vdram2", VDRAM2, vdram2,
> +	MT6358_REG_FIXED("ldo_vrf12", VRF12, "vs2-ldo2", MT6358_LDO_VRF12_CON0, 0, 1200000),
> +	MT6358_REG_FIXED("ldo_vio18", VIO18, "vs1-ldo1", MT6358_LDO_VIO18_CON0, 0, 1800000),
> +	MT6358_REG_FIXED("ldo_vcamio", VCAMIO, "vs1-ldo1", MT6358_LDO_VCAMIO_CON0, 0, 1800000),
> +	MT6358_REG_FIXED("ldo_vcn18", VCN18, "vs1-ldo1", MT6358_LDO_VCN18_CON0, 0, 1800000),
> +	MT6358_REG_FIXED("ldo_vfe28", VFE28, "vsys-ldo1", MT6358_LDO_VFE28_CON0, 0, 2800000),
> +	MT6358_REG_FIXED("ldo_vcn28", VCN28, "vsys-ldo1", MT6358_LDO_VCN28_CON0, 0, 2800000),
> +	MT6358_REG_FIXED("ldo_vxo22", VXO22, "vsys-ldo1", MT6358_LDO_VXO22_CON0, 0, 2200000),
> +	MT6358_REG_FIXED("ldo_vaux18", VAUX18, "vsys-ldo1", MT6358_LDO_VAUX18_CON0, 0, 1800000),
> +	MT6358_REG_FIXED("ldo_vbif28", VBIF28, "vsys-ldo1", MT6358_LDO_VBIF28_CON0, 0, 2800000),
> +	MT6358_REG_FIXED("ldo_vio28", VIO28, "vsys-ldo2", MT6358_LDO_VIO28_CON0, 0, 2800000),
> +	MT6358_REG_FIXED("ldo_va12", VA12, "vs2-ldo2", MT6358_LDO_VA12_CON0, 0, 1200000),
> +	MT6358_REG_FIXED("ldo_vrf18", VRF18, "vs1-ldo1", MT6358_LDO_VRF18_CON0, 0, 1800000),
> +	MT6358_REG_FIXED("ldo_vaud28", VAUD28, "vsys-ldo1", MT6358_LDO_VAUD28_CON0, 0, 2800000),
> +	MT6358_LDO("ldo_vdram2", VDRAM2, "vs2-ldo1", vdram2,
>   		   MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0xf),
> -	MT6358_LDO("ldo_vsim1", VSIM1, vsim,
> +	MT6358_LDO("ldo_vsim1", VSIM1, "vsys-ldo1", vsim,
>   		   MT6358_LDO_VSIM1_CON0, 0, MT6358_VSIM1_ANA_CON0, 0xf00),
> -	MT6358_LDO("ldo_vibr", VIBR, vibr,
> +	MT6358_LDO("ldo_vibr", VIBR, "vsys-ldo3", vibr,
>   		   MT6358_LDO_VIBR_CON0, 0, MT6358_VIBR_ANA_CON0, 0xf00),
> -	MT6358_LDO("ldo_vusb", VUSB, vusb,
> +	MT6358_LDO("ldo_vusb", VUSB, "vsys-ldo1", vusb,
>   		   MT6358_LDO_VUSB_CON0_0, 0, MT6358_VUSB_ANA_CON0, 0x700),
> -	MT6358_LDO("ldo_vcamd", VCAMD, vcamd,
> +	MT6358_LDO("ldo_vcamd", VCAMD, "vs2-ldo4", vcamd,
>   		   MT6358_LDO_VCAMD_CON0, 0, MT6358_VCAMD_ANA_CON0, 0xf00),
> -	MT6358_LDO("ldo_vefuse", VEFUSE, vefuse,
> +	MT6358_LDO("ldo_vefuse", VEFUSE, "vs1-ldo1", vefuse,
>   		   MT6358_LDO_VEFUSE_CON0, 0, MT6358_VEFUSE_ANA_CON0, 0xf00),
> -	MT6358_LDO("ldo_vmch", VMCH, vmch_vemc,
> +	MT6358_LDO("ldo_vmch", VMCH, "vsys-ldo2", vmch_vemc,
>   		   MT6358_LDO_VMCH_CON0, 0, MT6358_VMCH_ANA_CON0, 0x700),
> -	MT6358_LDO("ldo_vcama1", VCAMA1, vcama,
> +	MT6358_LDO("ldo_vcama1", VCAMA1, "vsys-ldo3", vcama,
>   		   MT6358_LDO_VCAMA1_CON0, 0, MT6358_VCAMA1_ANA_CON0, 0xf00),
> -	MT6358_LDO("ldo_vemc", VEMC, vmch_vemc,
> +	MT6358_LDO("ldo_vemc", VEMC, "vsys-ldo2", vmch_vemc,
>   		   MT6358_LDO_VEMC_CON0, 0, MT6358_VEMC_ANA_CON0, 0x700),
> -	MT6358_LDO("ldo_vcn33", VCN33, vcn33,
> +	MT6358_LDO("ldo_vcn33", VCN33, "vsys-ldo3", vcn33,
>   		   MT6358_LDO_VCN33_CON0_0, 0, MT6358_VCN33_ANA_CON0, 0x300),
> -	MT6358_LDO("ldo_vcama2", VCAMA2, vcama,
> +	MT6358_LDO("ldo_vcama2", VCAMA2, "vsys-ldo3", vcama,
>   		   MT6358_LDO_VCAMA2_CON0, 0, MT6358_VCAMA2_ANA_CON0, 0xf00),
> -	MT6358_LDO("ldo_vmc", VMC, vmc,
> +	MT6358_LDO("ldo_vmc", VMC, "vsys-ldo2", vmc,
>   		   MT6358_LDO_VMC_CON0, 0, MT6358_VMC_ANA_CON0, 0xf00),
> -	MT6358_LDO("ldo_vldo28", VLDO28, vldo28,
> +	MT6358_LDO("ldo_vldo28", VLDO28, "vsys-ldo2", vldo28,
>   		   MT6358_LDO_VLDO28_CON0_0, 0,
>   		   MT6358_VLDO28_ANA_CON0, 0x300),
> -	MT6358_LDO("ldo_vsim2", VSIM2, vsim,
> +	MT6358_LDO("ldo_vsim2", VSIM2, "vsys-ldo2", vsim,
>   		   MT6358_LDO_VSIM2_CON0, 0, MT6358_VSIM2_ANA_CON0, 0xf00),
> -	MT6358_LDO1("ldo_vsram_proc11", VSRAM_PROC11, 500000, 1293750, 6250,
> +	MT6358_LDO1("ldo_vsram_proc11", VSRAM_PROC11, "vs2-ldo3", 500000, 1293750, 6250,
>   		    MT6358_LDO_VSRAM_PROC11_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON0, 0x7f),
> -	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, 500000, 1293750, 6250,
> +	MT6358_LDO1("ldo_vsram_others", VSRAM_OTHERS, "vs2-ldo3", 500000, 1293750, 6250,
>   		    MT6358_LDO_VSRAM_OTHERS_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON2, 0x7f),
> -	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, 500000, 1293750, 6250,
> +	MT6358_LDO1("ldo_vsram_gpu", VSRAM_GPU, "vs2-ldo3", 500000, 1293750, 6250,
>   		    MT6358_LDO_VSRAM_GPU_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON3, 0x7f),
> -	MT6358_LDO1("ldo_vsram_proc12", VSRAM_PROC12, 500000, 1293750, 6250,
> +	MT6358_LDO1("ldo_vsram_proc12", VSRAM_PROC12, "vs2-ldo3", 500000, 1293750, 6250,
>   		    MT6358_LDO_VSRAM_PROC12_DBG0, 0x7f00, MT6358_LDO_VSRAM_CON1, 0x7f),
>   };
>   

-- 
AngeloGioacchino Del Regno
Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

