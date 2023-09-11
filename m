Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFF579BEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354591AbjIKVyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236816AbjIKL2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:28:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5AACDD;
        Mon, 11 Sep 2023 04:28:44 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 655AC6600BB0;
        Mon, 11 Sep 2023 12:28:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694431722;
        bh=VCO8hFhrrVLv5Zdp1yxb+bem6zXtstRZklPiz0+rgd4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Uk2qcLfxmAsXKNnobr9UNWX4/Ixh2BMKHQizFVNm6y/5eJw/LNhXRmE076AoXbeb2
         KNz58L4dve0LM/UXPpGDrjBwXVKxXhvw5P51AwyLvh34KSGxD69kIsN7LM8j2PMSK5
         MCajBCmrgbPfeIyr+6ETuuxKdVDc5Z7o7JyCLuDorWYeeCLWNdzAWi9grFLIG2fc9K
         BUgSM7KUdFx0SzGwjsKUaFaGbVzCKVtCoevH40yqAHtKO4GrsosIXsrvaShGuwSdym
         M7iAZg7SgY7HvPozqZvAaTCiS6RG/8j8mlBLA469IM0D8cBMMH222+BFB49eTZC+kW
         wWrOP2B9rYW3A==
Message-ID: <247d0b44-9359-2682-7e64-313eb1dd3e67@collabora.com>
Date:   Mon, 11 Sep 2023 13:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RESEND PATCH v6 20/20] drm/mediatek: Set DPI input to 1T2P mode
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>
References: <20230911074233.31556-1-shawn.sung@mediatek.com>
 <20230911074233.31556-21-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911074233.31556-21-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/23 09:42, Hsiao Chien Sung ha scritto:
> DPI input is in 1T2P mode on MT8195,
> align the setting of MT8188 with it,
> otherwise the screen will glitch.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>

First of all, this commit needs a Fixes tag... but then, instead of getting a
1:1 duplicate of mt8195_dpintf_conf you can, at this point, entirely remove
mt8188_dpintf_conf and assign the 8195 one to the 8188 compatible: please do so.

Thanks,
Angelo

> ---
>   drivers/gpu/drm/mediatek/mtk_dpi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 2f931e4e2b60..c6ee21e275ba 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -963,7 +963,7 @@ static const struct mtk_dpi_conf mt8188_dpintf_conf = {
>   	.output_fmts = mt8195_output_fmts,
>   	.num_output_fmts = ARRAY_SIZE(mt8195_output_fmts),
>   	.pixels_per_iter = 4,
> -	.input_2pixel = false,
> +	.input_2pixel = true,
>   	.dimension_mask = DPINTF_HPW_MASK,
>   	.hvsize_mask = DPINTF_HSIZE_MASK,
>   	.channel_swap_shift = DPINTF_CH_SWAP,
> --
> 2.18.0
> 

