Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CBE79E121
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 09:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238660AbjIMHtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 03:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233874AbjIMHtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 03:49:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDE2173E;
        Wed, 13 Sep 2023 00:49:12 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 31DC26607319;
        Wed, 13 Sep 2023 08:49:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694591350;
        bh=O9CO6wpscQ25gSXId4JSpQF3dW+cZrAGglKuHmq0w8k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DUxO7fNLz9nzGjZFSrbleJZ3aZ1M9wGDs5FruQWelZUIqm9QzVtGjOrsS3aKb1Kys
         OU+mz5kS52QwTZ7H4ykQRNqn5WZFhPS1xuNHgMnYKaO+as4K6eKUjWr3PZVdk2pRsi
         6XKF35tyWHerWlJcW27H0QgbbP8CBd9rQG+JNcBL27zqwOpWiiUC0YWn3pZ9jtQd/p
         hbCSfrTj9EfX7HvFaKcbvvpSj0+eJQod+cWjXEv3uZvyjf2jk+I0oWu++4QSuWVjjK
         ZTGipyXoQjHxWG/zV8HBI+5q45rRdI+a4TlwWFrpWVJOAvsSCbPRO+vJzaZGqqaDp8
         PQD9+1o/iWk1w==
Message-ID: <e93aa8a6-e088-2864-6ffa-050b211be21f@collabora.com>
Date:   Wed, 13 Sep 2023 09:49:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC v1 1/3] dt-bindings: thermal: mediatek: add mt7988
 compatible
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>
References: <20230911183354.11487-1-linux@fw-web.de>
 <20230911183354.11487-2-linux@fw-web.de>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230911183354.11487-2-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/23 20:33, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Add compatible string for mt7988.
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>   .../devicetree/bindings/thermal/mediatek,lvts-thermal.yaml       | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> index fe9ae4c425c0..49effe561963 100644
> --- a/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> +++ b/Documentation/devicetree/bindings/thermal/mediatek,lvts-thermal.yaml
> @@ -18,6 +18,7 @@ description: |
>   properties:
>     compatible:
>       enum:
> +      - mediatek,mt7988-lvts

Are you sure that MT7988 has only one LVTS controller, and that it is global?

>         - mediatek,mt8192-lvts-ap
>         - mediatek,mt8192-lvts-mcu
>         - mediatek,mt8195-lvts-ap

