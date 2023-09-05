Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB7E792BEC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347820AbjIEREK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353766AbjIEIAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 04:00:51 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC22DF;
        Tue,  5 Sep 2023 01:00:47 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CEA8F6600B9D;
        Tue,  5 Sep 2023 09:00:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693900846;
        bh=2XjBi/AufZmvXBbTSDTBYuHW7Eq3EIKYGcbUyzuBYIg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lG5wTiBnMhsuK03J3bFbkZxYoWG5c3bESzHfSG3dWWMCosmfdam4ti8fPG31P6PX9
         AxtkwwWxGGTkDHTkaWC0MPdX+8LU8xU+3U3+Gye/XAiX6eHRqHfWVDLK4EF55IAykt
         5lIjKJQxXj/dVk7tfnlCJmOQh8pSjmC85pH5DsObVo8McsfpswgS1RUDGBwv0GnuM5
         jG9mZY0WivQ6dAO1oUBtFhL0Lbo9PxcIkvrfu47nt2cNg5RY95PAxegh8QaDvKYkdM
         cKeAO78mj8gIOXXB5hgkOLpQ+XuPhPVTbv1zHLLUAMbSNEmqrksa983Hixi3K4vavQ
         qF8CKg9++y69w==
Message-ID: <4e0c1222-5211-5515-99f1-b44b25f8ecfe@collabora.com>
Date:   Tue, 5 Sep 2023 10:00:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Shouldn't this get automatically filled in by the bootloader?
Usually, that's the case: if it is, then the right thing to do here
is to change this property to

		/* The bootloader will fill in the size */
		reg = <0x0 0x40000000 0x0 0x0>;

Regards,
Angelo

>   	};
>   
>   	reserved-memory {


