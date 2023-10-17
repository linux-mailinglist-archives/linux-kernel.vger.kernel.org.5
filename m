Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833BE7CBFD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 11:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343534AbjJQJsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 05:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjJQJsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 05:48:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12843A2;
        Tue, 17 Oct 2023 02:48:04 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B622866072E4;
        Tue, 17 Oct 2023 10:48:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1697536082;
        bh=f1idfIPcMQyPsHWuXPvo14v1fXq19rfleCQgQ3pX2nQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ghVrzDasF81DZVT5kyGRSpfn4vBQSmeCCtp+bj2xMA7Sy2CmffoVSer/w3Kl/6CjQ
         c8sRG3qh8tdw7vbDh8C6u69DHRvNTyuX+jswhW/yi6i6YQi2X1PaPDKZT6+hNszKF5
         ujAhV0eypK8FgOXIIQCtwcTLnydbG1GN9LPT7SzS+WcvvODQhv6/2WAhoZ0AWaJRW1
         RCizx0T0ReJ6HvHSWEUgMnVJhAK74VPYU0toJGYuXC7QixDoSHoOpm2LTWM36jWCxx
         cUHiZ/B5qEnXKINHuLX5Rq3x4YNPxkJV+UoczSm+NyGTy0GpMw9muiYGsgLBYCBAdL
         sDW9UTyx3x2ew==
Message-ID: <97dae7c0-0bcb-456f-b808-b794ba9e3c8a@collabora.com>
Date:   Tue, 17 Oct 2023 11:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 18/23] drm/mediatek: Add Padding to OVL adaptor
Content-Language: en-US
To:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Fei Shao <fshao@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Johnson Wang <johnson.wang@mediatek.corp-partner.google.com>,
        "Nancy . Lin" <nancy.lin@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>,
        "Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20231016104010.3270-1-shawn.sung@mediatek.com>
 <20231016104010.3270-19-shawn.sung@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231016104010.3270-19-shawn.sung@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/10/23 12:40, Hsiao Chien Sung ha scritto:
> Add MT8188 Padding to OVL adaptor to probe the driver.
> 
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.

> ---
>   .../gpu/drm/mediatek/mtk_disp_ovl_adaptor.c   | 26 +++++++++++++++++++
>   1 file changed, 26 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> index 354ba6186166..b80425360e76 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl_adaptor.c
> @@ -29,6 +29,7 @@ enum mtk_ovl_adaptor_comp_type {
>   	OVL_ADAPTOR_TYPE_ETHDR,
>   	OVL_ADAPTOR_TYPE_MDP_RDMA,
>   	OVL_ADAPTOR_TYPE_MERGE,
> +	OVL_ADAPTOR_TYPE_PADDING,
>   	OVL_ADAPTOR_TYPE_NUM,
>   };
>   
> @@ -46,6 +47,14 @@ enum mtk_ovl_adaptor_comp_id {
>   	OVL_ADAPTOR_MERGE1,
>   	OVL_ADAPTOR_MERGE2,
>   	OVL_ADAPTOR_MERGE3,
> +	OVL_ADAPTOR_PADDING0,
> +	OVL_ADAPTOR_PADDING1,
> +	OVL_ADAPTOR_PADDING2,
> +	OVL_ADAPTOR_PADDING3,
> +	OVL_ADAPTOR_PADDING4,
> +	OVL_ADAPTOR_PADDING5,
> +	OVL_ADAPTOR_PADDING6,
> +	OVL_ADAPTOR_PADDING7,
>   	OVL_ADAPTOR_ID_MAX
>   };
>   
> @@ -66,6 +75,7 @@ static const char * const private_comp_stem[OVL_ADAPTOR_TYPE_NUM] = {
>   	[OVL_ADAPTOR_TYPE_ETHDR]	= "ethdr",
>   	[OVL_ADAPTOR_TYPE_MDP_RDMA]	= "vdo1-rdma",
>   	[OVL_ADAPTOR_TYPE_MERGE]	= "merge",
> +	[OVL_ADAPTOR_TYPE_PADDING]	= "padding",
>   };
>   
>   static const struct mtk_ddp_comp_funcs _ethdr = {
> @@ -80,6 +90,13 @@ static const struct mtk_ddp_comp_funcs _merge = {
>   	.clk_disable = mtk_merge_clk_disable,
>   };
>   
> +static const struct mtk_ddp_comp_funcs _padding = {

Please, _padding -> padding or mtk_padding


Thanks,
Angelo
