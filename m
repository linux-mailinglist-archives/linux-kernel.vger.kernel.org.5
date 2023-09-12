Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB42879D3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjILOb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbjILObO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:31:14 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6C1E7E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:31:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31dca134c83so5767544f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694529063; x=1695133863; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vv/75kEeRc6C4365WMEK2alu3JAPt7L7OwFhBAHlLpE=;
        b=LnbBjgqFIcUEIj/bO9MGb2NBe2a1Tkv7bIZtWEhWsdXJUe6JPdJYsWYLQ0VX6ErCx8
         v5z1S0WXPSFeLYaRAQkCSWwyx80cW9MzkwJn5kjj0+FNVrj+gEk/90VL0oM0blydrATK
         r2Zc7fASf+8kd9n5E5jpZRzRPMYm7z/8dIqxzamqiiUYlZ0L0mn2jdvnsw2r3ZsYHc+o
         coKP0y6j4jtCFB91Ky7yDnNLXHVYWrbsCOd1AcQ/FQ9zICIFU/poG4PB2ZEUZrhixLHG
         kzpIgeDBMoQfWKaYGCbfyQ+6cItMgP6PUOXRPL8RRPsQOgO/hwGHM3myOe1XkkFgX3Cw
         X7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694529063; x=1695133863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vv/75kEeRc6C4365WMEK2alu3JAPt7L7OwFhBAHlLpE=;
        b=NvbJHni+Vdk1C6v1rjhbZzigSjApdye4054lvuVLCpqbVbWFkX38gJYIVnCTYEkkDu
         4MBNTXebgxlKJbaqKrPGl6bH7WJJQ6vRjJDSRnbxqh4j6xL9/D5BpC5Q299HP2PfTPL+
         uwhOoKL4TF/6BJIgT0s4Bk36TK0XpqNRDx8N+dnxk8N1g8zLEK4nTIHvmVcxeycUQi1U
         fa8tiSW1yxrXxg2KRsbfWbAmMGWJl+4qsLso0KZCTLEUuYmiy3FmH+yWzZ2G4xJZHgA8
         CcPbdyRMlPHcvKbBXb+xtrtoN1w0Ove8fvKpUyRpFF+NYuGlcNVDr+a/pSFE6KnyE3nV
         tcvw==
X-Gm-Message-State: AOJu0YxDo+tDimHTCZ6zgSg9pCCgAkW1gi56cB3sYAUnFkuHozqcDeLa
        JZGO+nONvUoKMAOYd7ZBBZwBog==
X-Google-Smtp-Source: AGHT+IGE7Z3u/8T793GKchkW1xN+y/cWqm86V7IOqnn7C832w8YiIwv3OoyWdiXIu0ouE9rBXGP+kg==
X-Received: by 2002:adf:f48e:0:b0:31a:e73f:3fe7 with SMTP id l14-20020adff48e000000b0031ae73f3fe7mr11464586wro.3.1694529062899;
        Tue, 12 Sep 2023 07:31:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id o14-20020adfeace000000b003197869bcd7sm12954388wrn.13.2023.09.12.07.31.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 07:31:02 -0700 (PDT)
Message-ID: <d147a163-3696-8fdf-4c76-ec8375243d2c@linaro.org>
Date:   Tue, 12 Sep 2023 16:31:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: add mt8390-evk
 board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230912140613.6528-1-macpaul.lin@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912140613.6528-1-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 16:06, Macpaul Lin wrote:
> 1. Add compatible for MT8390.
> 2. Add bindings for the MediaTek mt8390-evk board, also known
> as the "Genio 700-EVK".
> 
> The MT8390 and MT8188 belong to the same SoC family,
> with only minor differences in their physical characteristics.
> They utilize unique efuse values for differentiation.
> 
> The booting process and configurations are managed by boot
> loaders, firmware, and TF-A. Consequently, the part numbers
> and procurement channels vary.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> dependencies for v1:
>  - This patch should be applied after the following patch set
>   - mt8365's bindings
>    - https://lore.kernel.org/linux-arm-kernel/20230912092444.31635-1-macpaul.lin@mediatek.com/T/
>   - mt8395's bindings
>    - https://lore.kernel.org/lkml/20230911115717.26184-1-macpaul.lin@mediatek.com/T/
>   - mt8188's bindings
>    - https://lore.kernel.org/lkml/a4e1a80ebd19896410f50b0297e05dce06fb47cc.camel@mediatek.com/T/
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index d8e449c6a7d7..047204a4aff5 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -251,6 +251,12 @@ properties:
>        - items:
>            - const: mediatek,mt8365-evk
>            - const: mediatek,mt8365
> +      - description: MediaTek Genio 700 Boards (Genio 700 EVK)

We had a long discussion, so again: drop description.



Best regards,
Krzysztof

