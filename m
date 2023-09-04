Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63736791DA2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 21:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjIDTbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 15:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233699AbjIDTbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 15:31:43 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CD4CCB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 12:31:38 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-986d8332f50so272791766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 12:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693855896; x=1694460696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJfzYAIKnwPTaNVAAkVDsZyLFKgbTLwbTGas3wSGj30=;
        b=W56Pg/SlRwpi3KzSsROpzmGaVL1LuHfS6Wh1d2qLbdLLCSsL2Mh71XhrHFh9oVZj0K
         k5mXlb5R9sS+XP501tsEQ/yc7OIn4y0flhD9FNaePvbrl5bX1oGCeLX8z/cJUUO8Srti
         9UpKv3d4QoeIokpFkmSjv45o7lAh2VRp41tl8dfmAGhI+y+kZwaTJVEN8hY8yYZeQPSt
         9868BxYjIjaaWCbgUlqPyDpaebzRIqwlXm9Bq7S2/c9ylHf576+tJpg4R238oGuFQz+P
         GORG5Y80f5B8huR2q+cd7/54NjKV3cx4Qlv9kXzK9HN7k6qPY6sb9rKPEuu2WcgJoV4q
         1BfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693855896; x=1694460696;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NJfzYAIKnwPTaNVAAkVDsZyLFKgbTLwbTGas3wSGj30=;
        b=ZGpjP1D8OWqOYz1cf8+QPDvc5UiwX+I5NCjgc67XsACZNGQbDVuusCjXprOmRq6O5/
         XcvlvIY5Tbj42fuLbP4FRr4415+S5MkouAnv67bRmSquJyICQf2Eao6w/n8XcsbMZhj6
         m8EYf0UEsmGWBEmpKBOBC7te09FhZPP8VERUoJjYpCtwpYQG4F1/x77T1CszV3f6nAa3
         SH6FkUWDSOlQmTNL7HjF1kQkl/8pBwR1kb5dSzSxkyIke8/qeTknWsamnSKggltbTnYF
         bgQ/BGOv7yueSsrjPiE2tY61+saxNvNGYyeQJaZAWMk+YK+VhAd18TzCTH4mPD6kw8If
         TcIQ==
X-Gm-Message-State: AOJu0YwI+m52eADV0lucXMGCqLHGLXQ1mYHBctwtjJuPUrM9NOLpIq0O
        oBBkOLTDYth0iO/gW/aP9dZc2A==
X-Google-Smtp-Source: AGHT+IHXIXug6nzry8NP/bG9picjl2qkVPdjAfH7GKSh1orCmcs5A6HXOx/Za69iL81di4h4TtnnlQ==
X-Received: by 2002:a17:906:109:b0:9a4:88af:b82 with SMTP id 9-20020a170906010900b009a488af0b82mr6112989eje.77.1693855896681;
        Mon, 04 Sep 2023 12:31:36 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id mc24-20020a170906eb5800b009829d2e892csm6659123ejb.15.2023.09.04.12.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 12:31:36 -0700 (PDT)
Message-ID: <f512f11a-6b66-5892-ad9e-cc45d4abc508@linaro.org>
Date:   Mon, 4 Sep 2023 21:31:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/6] dt-bindings: opp: Add compatible for H616
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Luke Harrison <bttuniversity@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rogerio Goncalves <rogerlz@gmail.com>,
        Martin Botka <martin@biqu3d.com>
References: <20230904-cpufreq-h616-v1-0-b8842e525c43@somainline.org>
 <20230904-cpufreq-h616-v1-3-b8842e525c43@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904-cpufreq-h616-v1-3-b8842e525c43@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 17:57, Martin Botka wrote:
> We need to add compatible for H616 to H6 cpufreq driver bindings.

Please describe the hardware, not what is needed for drivers.

> 
> Also enable opp_supported_hw property that will be needed for H616.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  .../bindings/opp/allwinner,sun50i-h6-operating-points.yaml          | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> index 51f62c3ae194..2fa1199f2d23 100644
> --- a/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> +++ b/Documentation/devicetree/bindings/opp/allwinner,sun50i-h6-operating-points.yaml
> @@ -23,7 +23,10 @@ allOf:
>  
>  properties:
>    compatible:
> -    const: allwinner,sun50i-h6-operating-points
> +    contains:

This does not look like part of allOf, so contains is no correct here.
This must be specific, so drop contains.

> +      enum:
> +        - allwinner,sun50i-h6-operating-points
> +        - allwinner,sun50i-h616-operating-points
>  
>    nvmem-cells:
>      description: |
> @@ -47,6 +50,7 @@ patternProperties:
>      properties:
>        opp-hz: true
>        clock-latency-ns: true
> +      opp-supported-hw: true

Why? It is already allowed. You should rather explain the values.

> 

Best regards,
Krzysztof

