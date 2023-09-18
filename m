Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06F57A4958
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241951AbjIRMMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbjIRMLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:11:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F69EBA
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:11:10 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b9338e4695so70407641fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695039069; x=1695643869; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nNg5sBvXpTkFIEXWpv9DgGZCDJnmvTQX83kuJA0NYGE=;
        b=yf5Kz7a+hEt86reAJzJ/LCYDawqQPqdqCXfg2oCNSfM/IRLT9xK8VVYVpNxvCCmDp1
         yx0dkzEgjC8glOYGzgd1CKAdTzD1Vof+B69Lq3/YQdggA2Z/0p9PNgYQ4QSyY8DFTzi+
         LUmeXR9ivoguBpvWj0zwMxg28IVw3nMcWhCWJIxm4QiwDLQ3PAWO+4QwkKlz9G+sCH4M
         3aB89/1jac81Oe2uADkZUkxwh24DhZEWzoJlBaUswKip1I7bEpvhOGp50sw0a+mGgdkh
         zaYt7eHa2NA9mfohGsERP8bGNTBRGe8Zgv8Pe0smLoehJHo1krZwcI+NwE56bONJFv+6
         vfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039069; x=1695643869;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nNg5sBvXpTkFIEXWpv9DgGZCDJnmvTQX83kuJA0NYGE=;
        b=eY6xPrwgY8mbwx2TWffT58OGs2DrfwhcegEAxwjmakpavXZthHwltqySGGL5YAyujt
         +c3+O4W0YR1xHscpKCRe6qrubqK3ObVVYYIyKbyFlI6LmH/3o0H43B35KCKfw0WWH22E
         xab9H10S1hdbMkQvsxw2jgMAYc2de+NjRRSGpasP5E0AHVnT5pXsgYD1TAmlEZNpVQ1S
         ck15HOPbVU9b8RZezmPNVBSBp+ce5R24ILE8SUuSyax2Gv65dRCmHmybcbhOco/n4uxS
         Z6nUdhjpZY7AQjg2CBxg8VAFavwBG4VEf8yvK+rrhSP5G7ut73dh3jKmQJbUY307GJw8
         WEUw==
X-Gm-Message-State: AOJu0YynIR+MLtO69VhUxX3KuV1T/eZfdoNa9Tehdf+TWTucAes/ENVT
        ivbQ97d/FyCi7T4XlE56IoD9xw==
X-Google-Smtp-Source: AGHT+IFwerwMQ9p0BqOOgGf8TfiZGafrKqJF/xTtLKwKD07Ub3Rfj01f0aVJZ19zwA3dnMtXaMRXaA==
X-Received: by 2002:a05:651c:2115:b0:2bf:df8c:4e56 with SMTP id a21-20020a05651c211500b002bfdf8c4e56mr8540093ljq.39.1695039068635;
        Mon, 18 Sep 2023 05:11:08 -0700 (PDT)
Received: from [172.25.80.114] ([217.67.225.27])
        by smtp.gmail.com with ESMTPSA id rp9-20020a170906d96900b0099e05fb8f95sm6346237ejb.137.2023.09.18.05.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 05:11:08 -0700 (PDT)
Message-ID: <ed222918-68ca-cb57-15b8-57f45cdb5a5b@linaro.org>
Date:   Mon, 18 Sep 2023 14:11:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: Add Richtek rtq9128 audio
 amplifier
Content-Language: en-US
To:     cy_huang@richtek.com, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Allen Lin <allen_lin@richtek.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1695030341-20711-1-git-send-email-cy_huang@richtek.com>
 <1695030341-20711-2-git-send-email-cy_huang@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1695030341-20711-2-git-send-email-cy_huang@richtek.com>
Content-Type: text/plain; charset=UTF-8
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

On 18/09/2023 11:45, cy_huang@richtek.com wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Create richtek,rtq9128.yaml for rtq9128 amplifier.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../bindings/sound/richtek,rtq9128.yaml       | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml b/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
> new file mode 100644
> index 000000000000..a79694c2b169
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/richtek,rtq9128.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license is needed. Just like checkpatch is asking for.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/richtek,rtq9128.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Richtek RTQ9128 Automative Audio Power Amplifier
> +
> +maintainers:
> +  - ChiYuan Huang <cy_huang@richtek.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The RTQ9128 is a ultra-low output noise, high-efficiency, four-channel
> +  class-D audio power amplifier and delivering 4x75W into 4OHm at 10%
> +  THD+N from a 25V supply in automotive applications.
> +

Missing ref to dai common.

> +properties:
> +  compatible:
> +    enum:
> +      - richtek,rtq9128
> +
> +  reg:
> +    maxItems: 1
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#sound-dai-cells'
> +
> +unevaluatedProperties: false

This goes with mentioned $ref. Alone would not be correct.


Best regards,
Krzysztof

