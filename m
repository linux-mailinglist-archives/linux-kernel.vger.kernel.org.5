Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F326798572
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjIHKGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbjIHKGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:06:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2499A2112;
        Fri,  8 Sep 2023 03:05:35 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4F7D76607258;
        Fri,  8 Sep 2023 11:04:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694167472;
        bh=PMJKkkg9Mq7q/ZTFu38eyhxdwKmjapZyHJI+geNR8i8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IUG/kfx8gip88bw4DdX3nLfzNBnv2xviKRyZDrn+w4vbBqIIUgyBT7mOX42pt1yL3
         XWcCXO8BE5Fh7pukKJPESETYhGjpiGKgmXZUkDXyaoYTyTfJrruf80SSjaqk774DyC
         fc5vtFp782MLHA9XNnUq7ebce7N3fHoEaBB7EKGsxgX04iW9jRuDLGJ/eFLrO1DryO
         si3qe1M4FckQCQZp4tEB3d2H9EAkOzyu1EojSTrRu+LxF5qC80i6ltyXHmxQF6MKSJ
         3N34Rii9imqymq0GXH5NEjR0vk7WCiTwQ2IYnDP/ryqVKW3oZE0q1nMN9c1hdykTqS
         wTb2XAyFptyjA==
Message-ID: <c46dc0ff-3713-917b-9640-27a4afdc0002@collabora.com>
Date:   Fri, 8 Sep 2023 12:04:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] dt-bindings: phy: Add compatible for Mediatek MT8188
Content-Language: en-US
To:     Shuijing Li <shuijing.li@mediatek.com>, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        matthias.bgg@gmail.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-phy@lists.infradead.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
References: <20230908075310.17825-1-shuijing.li@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230908075310.17825-1-shuijing.li@mediatek.com>
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

Il 08/09/23 09:53, Shuijing Li ha scritto:
> Add dt-binding documentation of dsi-phy for MediaTek MT8188 SoC.
> 
> Signed-off-by: Shuijing Li <shuijing.li@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> Changes in v3:
> After upstreaming the basic version of mt8188.dtsi, we will add the
> following mipi node in mt8188.dtsi:
> mipi_tx_config0: mipi_dphy0@11c80000 {
> 			compatible = "mediatek,mt8188-mipi-tx",
> 				     "mediatek,mt8183-mipi-tx";
> 			reg = <0 0x11c80000 0 0x1000>;
> 			clocks = <&clk26m>;
> 			#clock-cells = <0>;
> 			#phy-cells = <0>;
> 			clock-output-names = "mipi_tx0_pll";
> 			status = "disabled";
> 		};
> per suggestion from the previous thread:
> https://lore.kernel.org/all/0a6d3d14-33f0-92d2-b42f-e4d336c8cd91@linaro.org/
> Changes in v2:
> Adjust mt8188 position.
> ---
>   Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index a63b20dfa4a5..6703689fcdbe 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> @@ -30,6 +30,7 @@ properties:
>             - const: mediatek,mt8173-mipi-tx
>         - items:
>             - enum:
> +              - mediatek,mt8188-mipi-tx
>                 - mediatek,mt8365-mipi-tx
>             - const: mediatek,mt8183-mipi-tx
>         - const: mediatek,mt2701-mipi-tx


