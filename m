Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A167DF7D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 17:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377072AbjKBQig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 12:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKBQie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 12:38:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3945F1B4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 09:38:18 -0700 (PDT)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F4A7660732D;
        Thu,  2 Nov 2023 16:38:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698943096;
        bh=2U2jNYxkhbQYRZodeTJJK+isFib8B36sDeFILwRywAw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b0lMF5gVq5bLcfAU6k1wcNuaq8K5nN+WMRreweu7tYK2hlPVQRJxAUW4Z5d6TLkRL
         PaSSzMVL34q6lsjMCWVkBXMZz2SNqWFMTN1aaUhqRqt1YXaWjCLcF0SqGYko81bU4R
         jQZfQpGDqS8vdHKBYA+OVFpza2HSMds9MYAgHDAQeNVzcWvY/wzyLOjiQTlC+6FeQU
         Ph5jhdrDwZdPzr0dJBUVJcUr4z9Cw7kGKKR7EWFdjpH87WqAadsZvAoZMsUs6TO7OJ
         6rnic2Sh7E21fIdUsp5eHHZWgZAMqyWqG3e9oRLPKGaQYSong/SDnLNR9lDEFTjFTn
         LFQeEF0SFD+Qg==
Message-ID: <7f033a16-bab6-4330-9dbf-a7f4158abe1e@collabora.com>
Date:   Thu, 2 Nov 2023 17:38:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: mediatek: mmsys: Add support for MT8188 VPPSYS
To:     "yu-chang.lee" <yu-chang.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20231102113345.24775-1-yu-chang.lee@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20231102113345.24775-1-yu-chang.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/11/23 12:33, yu-chang.lee ha scritto:
> Add MT8188 VPPSYS0 and VPPSYS1 driver data.
> 
> Signed-off-by: yu-chang.lee <yu-chang.lee@mediatek.com>

This change is valid, but you have to reflect that in the bindings.
Remove mediatek,mt8188-vppsys{0,1} from clock/mediatek,mt8188-clock.yaml and add
those to arm/mediatek/mediatek,mmsys.yaml like was done with MT8195.

Of course, bindings go to a separate commit.

I can't give you a R-b tag for this one without the bindings one..... :-)

Thanks,
Angelo

> ---
>   drivers/soc/mediatek/mtk-mmsys.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
> index 7630e1d9b3a4..591e92468bea 100644
> --- a/drivers/soc/mediatek/mtk-mmsys.c
> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> @@ -89,6 +89,16 @@ static const struct mtk_mmsys_driver_data mt8188_vdosys0_driver_data = {
>   	.num_routes = ARRAY_SIZE(mmsys_mt8188_routing_table),
>   };
>   
> +static const struct mtk_mmsys_driver_data mt8188_vppsys0_driver_data = {
> +	.clk_driver = "clk-mt8188-vpp0",
> +	.is_vppsys = true,
> +};
> +
> +static const struct mtk_mmsys_driver_data mt8188_vppsys1_driver_data = {
> +	.clk_driver = "clk-mt8188-vpp1",
> +	.is_vppsys = true,
> +};
> +
>   static const struct mtk_mmsys_driver_data mt8192_mmsys_driver_data = {
>   	.clk_driver = "clk-mt8192-mm",
>   	.routes = mmsys_mt8192_routing_table,
> @@ -440,6 +450,8 @@ static const struct of_device_id of_match_mtk_mmsys[] = {
>   	{ .compatible = "mediatek,mt8183-mmsys", .data = &mt8183_mmsys_driver_data },
>   	{ .compatible = "mediatek,mt8186-mmsys", .data = &mt8186_mmsys_driver_data },
>   	{ .compatible = "mediatek,mt8188-vdosys0", .data = &mt8188_vdosys0_driver_data },
> +	{ .compatible = "mediatek,mt8188-vppsys0", .data = &mt8188_vppsys0_driver_data },
> +	{ .compatible = "mediatek,mt8188-vppsys1", .data = &mt8188_vppsys1_driver_data },
>   	{ .compatible = "mediatek,mt8192-mmsys", .data = &mt8192_mmsys_driver_data },
>   	/* "mediatek,mt8195-mmsys" compatible is deprecated */
>   	{ .compatible = "mediatek,mt8195-mmsys", .data = &mt8195_vdosys0_driver_data },

