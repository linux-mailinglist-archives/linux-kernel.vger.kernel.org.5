Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04A27E36AF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233684AbjKGIdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjKGIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:33:10 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5107BD;
        Tue,  7 Nov 2023 00:33:07 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DBE7E66074BB;
        Tue,  7 Nov 2023 08:33:05 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699345986;
        bh=WAeItKcus8R5qgyGRaYj0c/dQFjok1MFYhPuzmvp/Lc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Fds6b7nxpvM7i2IrIUt2V/y363QEQRq1Jrl19lwXVZaFUwsnQ4CApbalOxkVrVJOk
         jQv2Vtg9c8aXmmltCabDPRAgTB2ts8HHtgY0am7PRcX+WE471fKzUiFqqc8tZkw9de
         jZ9tx2PSDsc6a4T09O4H9F71XFxLJskTmm0L9pFgDKq+875HpABK1R5POHM+VLVseI
         M5+T1YJwFldxCi/WYmaKjs4Jp5AWveP5LRFcb81ISac9/0al9aNYmrBimwzzW9sOKx
         Oql5T2p8nSes0QIDpn/mvQDOf3yBkfc3a4auJyQM+9RXwB8KyhqPhV3cHy+eeqy2Yn
         oRh4M4F3GH/0g==
Message-ID: <2ca57563-2b76-4c40-afa6-cbbc05837edf@collabora.com>
Date:   Tue, 7 Nov 2023 09:33:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v1 1/3] ASoC: dt-bindings: mt8188-mt6359: add es8326 support
Content-Language: en-US
To:     Rui Zhou <zhourui@huaqin.corp-partner.google.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, perex@perex.cz, allen-kh.cheng@mediatek.com,
        kuninori.morimoto.gx@renesas.com
Cc:     linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20231107031442.2768765-1-zhourui@huaqin.corp-partner.google.com>
 <20231107031442.2768765-2-zhourui@huaqin.corp-partner.google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231107031442.2768765-2-zhourui@huaqin.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 07/11/23 04:14, Rui Zhou ha scritto:
> Add compatible string "mediatek,mt8188-es8326" to support new board
> with es8326 codec.
> 
> Signed-off-by: Rui Zhou <zhourui@huaqin.corp-partner.google.com>
> ---
>   .../devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml        | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> index 4c8c95057ef7..9df5e44176d0 100644
> --- a/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> +++ b/Documentation/devicetree/bindings/sound/mediatek,mt8188-mt6359.yaml
> @@ -18,6 +18,7 @@ properties:
>         - mediatek,mt8188-mt6359-evb
>         - mediatek,mt8188-nau8825
>         - mediatek,mt8188-rt5682s
> +      - mediatek,mt8188-es8326

Whoops, sorry, I just noticed that this is not alphabetically ordered.
Please move that before mediatek,mt8188-mt6359-evb.

Thanks,
Angelo

>   
>     audio-routing:
>       description:


