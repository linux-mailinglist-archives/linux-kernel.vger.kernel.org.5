Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9434F75ABBF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 12:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjGTKOs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 06:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjGTKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 06:14:44 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E675A136
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:14:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so5073825e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 03:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689848081; x=1690452881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xgR/v2tSKFAWg8JGcDgIlYGNaMxVHFU8awEJ10JMgL4=;
        b=ZlWCt++5xVRaYMUvNDumyvFs9ceI6zQJoyuunF56q1OyxwajbMz0jYiNi3ts0TbAF/
         jStioDtPGEe3D67yaeXn15vdB6mU5NwAO1CsZrn4RJcSTGpGq3GDx46Y+LU90sdyatYl
         CCpYauFdbtMtt/RvOuBhPlQmmCvFCPVnMdFsI0Qyk5TZBpaUop0BchRmxsnYCgfkk4Aa
         7k08jxzQb6PYPF9VfhBDjpWC4BlqmWgNVsoZQeVPBwqmbVk+jtpUDxLJhJPuieHQEIxh
         6Yiq5z8i8rLQjboMDZJcovSVAPVuBtHCwUSVOg0mGmir80I0oTBfM/rJAmV4eydrzyWJ
         jfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689848081; x=1690452881;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xgR/v2tSKFAWg8JGcDgIlYGNaMxVHFU8awEJ10JMgL4=;
        b=YgLRAtMKpP0ccbX6vIMnHXfQnpWlD7H8u0jA2DPWsai59HLfLcNYb5kx+E9bur+yVE
         wS6r49kLrmN7PCNDE0e4mxsttjrz27rAv1T8Wbr5cxYJvWddhZm1R1/MK78z+p2PZaX7
         GqRa2twcY9Uf/nYy7GXtA33csd+m28u65V4ZCFpynHm7BZ/YF5Uz0xitkskRPZLp+PSC
         fvzdv2M1DxeziyVKvEv7s2/2PIW7axspo+25XVtHVrl7yp3aNgeq6tz5z3wIVNUkx3wh
         FBBCNZa9B4szVDLOl4kXV75PodYUBBzmDhAFqydcrazBYixb6Xq2hEcA5bpERzIBQG0I
         LcBA==
X-Gm-Message-State: ABy/qLbCRFiQfz9O//WCLBuuh24UM8Gt8qBSvyHvmKToufqrSEFQ0Fy9
        3rRfVDoqUioCsr1JyFaVc+X5aQ2+8OJ5uTWQ1JY=
X-Google-Smtp-Source: APBJJlEn7afesFYcFAVd9IolYE+oiB5KW2PNECta7r263fwwlURO3tO4QXeOXbhRd1/MVqDP6X0gwA==
X-Received: by 2002:a5d:69c3:0:b0:314:2732:e81e with SMTP id s3-20020a5d69c3000000b003142732e81emr2063397wrw.8.1689848081370;
        Thu, 20 Jul 2023 03:14:41 -0700 (PDT)
Received: from [10.1.3.131] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d4342000000b003141f96ed36sm920685wrr.0.2023.07.20.03.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 03:14:40 -0700 (PDT)
Message-ID: <44cc9cc5-7dce-f7a2-f077-b62d7851ee12@baylibre.com>
Date:   Thu, 20 Jul 2023 12:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3,3/3] drm/mediatek: dp: Add the audio divider to
 mtk_dp_data struct
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230720082604.18618-1-shuijing.li@mediatek.com>
 <20230720082604.18618-4-shuijing.li@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230720082604.18618-4-shuijing.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/07/2023 10:26, Shuijing Li wrote:
> Due to the difference of HW, different dividers need to be set.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
> Changes in v3:
> Separate these two things into two different patches.
> per suggestion from the previous thread:
> https://lore.kernel.org/lkml/e2ad22bcba31797f38a12a488d4246a01bf0cb2e.camel@mediatek.com/
> Changes in v2:
> - change the variables' name to be more descriptive
> - add a comment that describes the function of mtk_dp_audio_sample_arrange
> - reduce indentation by doing the inverse check
> - add a definition of some bits
> - add support for mediatek, mt8188-edp-tx
> per suggestion from the previous thread:
> https://lore.kernel.org/lkml/ac0fcec9-a2fe-06cc-c727-189ef7babe9c@collabora.com/
> ---
>   drivers/gpu/drm/mediatek/mtk_dp.c     | 7 ++++++-
>   drivers/gpu/drm/mediatek/mtk_dp_reg.h | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
> index d8cda83d6fef..8e1a13ab2ba2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> @@ -140,6 +140,7 @@ struct mtk_dp_data {
>   	const struct mtk_dp_efuse_fmt *efuse_fmt;
>   	bool audio_supported;
>   	bool audio_pkt_in_hblank_area;
> +	u16 audio_m_div2_bit;
>   };
>   
>   static const struct mtk_dp_efuse_fmt mt8195_edp_efuse_fmt[MTK_DP_CAL_MAX] = {
> @@ -648,7 +649,7 @@ static void mtk_dp_audio_sdp_asp_set_channels(struct mtk_dp *mtk_dp,
>   static void mtk_dp_audio_set_divider(struct mtk_dp *mtk_dp)
>   {
>   	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_30BC,
> -			   AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
> +			   mtk_dp->data->audio_m_div2_bit,
>   			   AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MASK);
>   }
>   
> @@ -2636,6 +2637,7 @@ static const struct mtk_dp_data mt8188_edp_data = {
>   	.efuse_fmt = mt8195_edp_efuse_fmt,
>   	.audio_supported = false,
>   	.audio_pkt_in_hblank_area = false,
> +	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
>   };
>   
>   static const struct mtk_dp_data mt8188_dp_data = {
> @@ -2644,6 +2646,7 @@ static const struct mtk_dp_data mt8188_dp_data = {
>   	.efuse_fmt = mt8195_dp_efuse_fmt,
>   	.audio_supported = true,
>   	.audio_pkt_in_hblank_area = true,
> +	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
>   };
>   
>   static const struct mtk_dp_data mt8195_edp_data = {
> @@ -2652,6 +2655,7 @@ static const struct mtk_dp_data mt8195_edp_data = {
>   	.efuse_fmt = mt8195_edp_efuse_fmt,
>   	.audio_supported = false,
>   	.audio_pkt_in_hblank_area = false,
> +	.audio_m_div2_bit = AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
>   };
>   
>   static const struct mtk_dp_data mt8195_dp_data = {
> @@ -2660,6 +2664,7 @@ static const struct mtk_dp_data mt8195_dp_data = {
>   	.efuse_fmt = mt8195_dp_efuse_fmt,
>   	.audio_supported = true,
>   	.audio_pkt_in_hblank_area = false,
> +	.audio_m_div2_bit = AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
>   };
>   
>   static const struct of_device_id mtk_dp_of_match[] = {
> diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> index f38d6ff12afe..6d7f0405867e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> +++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
> @@ -162,6 +162,7 @@
>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_2	(1 << 8)
>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_4	(2 << 8)
>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_MUL_8	(3 << 8)
> +#define MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2	(4 << 8)

IMO, it's a bit weird to have SoC specific define in the generic header.
Are you sure this bit is only available for MT8188 ?

>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2	(5 << 8)
>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_4	(6 << 8)
>   #define AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_8	(7 << 8)

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre
