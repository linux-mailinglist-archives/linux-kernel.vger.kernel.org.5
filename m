Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71A7F2A72
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbjKUKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKUKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:32:39 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E46B9;
        Tue, 21 Nov 2023 02:32:34 -0800 (PST)
Received: from [100.107.97.3] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BFF2066072F1;
        Tue, 21 Nov 2023 10:32:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700562753;
        bh=6QRCpa+LpHtt2e+x4B/bsyiQHgeK35mHv9WQjcBnRjQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=k88kGO99Z3VLxoAXkOj+GxGNP0Tb/RSOiUBHLx6iwWzYROeFzsjZxFK450FWUuBte
         Z5xbwcbOATBnOl9VnDU8SF2VoVAe1W3yq+mPMdGpOrrfDszxxXrPuTC4iTBHakI1WV
         iyGICGqNcsL02NkiVR2hjbk+TwZIvGtKbwsyCI0o5CkU+/8WzHXm0j2I8I5gOzBbnr
         F4FEzlLRMTrB9TKSHFQvjz1j84t59bZhhGRLjvySkfrOyPQp3mwUaZH2fzXEB7+Dp7
         mcGN5D3lIg5ReDQxpyE6l6+sUcfxDi58qJCVLn4PYe9l+94OY7Wa7r2rvUQEigIQ7M
         YIbwtv5wVyKKA==
Message-ID: <318d602b-12ba-4af8-9cb3-24498559c254@collabora.com>
Date:   Tue, 21 Nov 2023 11:32:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: watchdog: mediatek,mtk-wdt: add
 MT7988 watchdog and toprgu
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <6478f8d2af59736d23a96b52891bb541de33870d.1700504385.git.daniel@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6478f8d2af59736d23a96b52891bb541de33870d.1700504385.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/11/23 19:21, Daniel Golle ha scritto:
> Add binding description for mediatek,mt7988-wdt.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> v4: no changes
> v3: no changes
> v2: Drop adding include/dt-binding/mt7988-resets.h as that header is not
>      actually a binding header.
> 
>   Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index cc502838bc398..8d2520241e37f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -25,6 +25,7 @@ properties:
>             - mediatek,mt6735-wdt
>             - mediatek,mt6795-wdt
>             - mediatek,mt7986-wdt
> +          - mediatek,mt7988-wdt
>             - mediatek,mt8183-wdt
>             - mediatek,mt8186-wdt
>             - mediatek,mt8188-wdt


