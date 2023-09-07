Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C716797624
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236479AbjIGQBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244391AbjIGP77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:59:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861B64EE0;
        Thu,  7 Sep 2023 08:50:21 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 128E466072EE;
        Thu,  7 Sep 2023 10:15:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694078113;
        bh=Rxr9wSnatrcikI+JJAyDpY5hrb72I1tP/ucCHPKp+4U=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oAnhasf8H14BX1NPjT3BsrDvEucrf2ZGAoLRd5zQlOXr2R0oZIJjohj6HyskepAZO
         Y2CLeVG9KcJ2d641YVHNYos39QTXEJOQkclRgbDNhxuBSMkQcamneh5PUmIXF+0vuJ
         o9KbG1RvRDyJLh/4RJ9VB0bTM240n1lUcoLAIe0iuQrkgGq0vNZC7GFupZHUPZeYmp
         lHQoVPQYl+B9+YPIUUIZDq1Cy3K6XIu/ePkByJXIN/CxpHv2GExeT35w0BMlCZpsoc
         WbAgNLd3wGJDhH/5s2ljSs5qYw0z87wfXz+opNESPPgUHCoKrLSzN8LxUyyLqdX9Ye
         52ifx7/NZ5jYg==
Message-ID: <99510f2c-82cb-a3ed-764f-9411a16cac09@collabora.com>
Date:   Thu, 7 Sep 2023 11:15:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 1/2] arm64: dts: mediatek: mt8195-demo: fix the memory
 size to 8GB
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>, stable@vger.kernel.org
References: <20230825114623.16884-1-macpaul.lin@mediatek.com>
 <20230905034511.11232-1-macpaul.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230905034511.11232-1-macpaul.lin@mediatek.com>
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

Il 05/09/23 05:45, Macpaul Lin ha scritto:
> The onboard dram of mt8195-demo board is 8GB.
> 
> Cc: stable@vger.kernel.org      # 6.1, 6.4, 6.5
> Fixes: 6147314aeedc ("arm64: dts: mediatek: Add device-tree for MT8195 Demo board")
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8195-demo.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Changes for v2:
> Changes for v3:
>   - No change.
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> index b2485ddfd33b..ff363ab925e9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
> @@ -48,7 +48,7 @@
>   
>   	memory@40000000 {
>   		device_type = "memory";
> -		reg = <0 0x40000000 0 0x80000000>;
> +		reg = <0 0x40000000 0x2 0x00000000>;
>   	};
>   
>   	reserved-memory {

