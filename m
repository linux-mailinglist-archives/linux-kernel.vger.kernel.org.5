Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD18480DF6A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345385AbjLKXWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 18:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345264AbjLKXWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 18:22:02 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4F0D9;
        Mon, 11 Dec 2023 15:22:05 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35d62401a3dso20186675ab.3;
        Mon, 11 Dec 2023 15:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702336925; x=1702941725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1JXfBtDN9YbciBnSzUN5scBUM27YowtO3B6tcHNd+tI=;
        b=b6F5q9bWCjY6vTW07GkLdtJKVqahXdqCsaMiu8jpaGhsK9IsFIW9Ymo1QhCA+hcMj3
         diJKwfLdB063q9eqn4DtVD+9wUm+hv1gHHdKxYRU6waB2F3lY81nhCl+LOZTAm5Rf5WO
         kQOoEpnR0GO1z24pq8vkjWqhmolPc4mcVs1l+X5rUmIRkm1fJR7yMVOOFKVYrbmsIYL8
         IwF9+dysdZhFUjN8qz6SWWLsWQheW++jzGq55QbLcWYcXenR80yuKYQca2mKxTeiQ2Hf
         +HTKPph91QQA7d8uf6Nto4IrjL6MT1tbGemfG5f2C/sBKWyL7Q0qRt4Ls9wr5THvK0eg
         UpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702336925; x=1702941725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JXfBtDN9YbciBnSzUN5scBUM27YowtO3B6tcHNd+tI=;
        b=WW/ykUEG2lWz2j7dBV0paKi+OHET2T1mn5MDiwIW4Yralqvek93bN57RikNkv7dndX
         qs3ZjbrFJPVvXRix1aId8kR0KCzP/h8atTSM31jcf5QPkhSK03ylZXp4nsO7pNSTQS8u
         JP+4LKqIK9zpAsQlKFioXcvGfLo5xXh9fCfgOv81QA+7U65PJoTnd+fgS65fZ3GBC7LT
         LtdfV2oSD4inWloiOBHDKMh90l3T0YF/xRLtcxCkzHNeKmzGfphMwrLhjQNw25HeVJVH
         5M2ECOqwDxR89TeHmp0WdpARPyu/R75OhYCdjyj3mezSa6lT4SAcBuUwcjoE8Stx6u19
         yuZA==
X-Gm-Message-State: AOJu0Yxw1tcVLv/RhsiwFQFt9Ncn2EGRZuSd8oIkWtP8emox4EwkbhQj
        EP02ZoBYaOmoJlMXoIBAx/c=
X-Google-Smtp-Source: AGHT+IFg/RdIJzSlpJMEiTf89v0NNVU+gjgGmrsArusbbwEtYJ7qlM443bbeE1m/fNgJWS4C8AY9HQ==
X-Received: by 2002:a92:ca0c:0:b0:35d:a6af:5fc7 with SMTP id j12-20020a92ca0c000000b0035da6af5fc7mr7039313ils.53.1702336924952;
        Mon, 11 Dec 2023 15:22:04 -0800 (PST)
Received: from localhost ([2607:fea8:529e:7800::a768])
        by smtp.gmail.com with ESMTPSA id w17-20020a0cc251000000b0067a3991d002sm3685254qvh.30.2023.12.11.15.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 15:22:03 -0800 (PST)
Date:   Mon, 11 Dec 2023 18:22:01 -0500
From:   Richard Acayan <mailingradian@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Shawn Guo <shawn.guo@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        krishna Lanka <quic_vamslank@quicinc.com>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        Iskren Chernev <me@iskren.info>,
        Martin Botka <martin.botka@somainline.org>,
        Danila Tikhonov <danila@jiaxyga.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/10] dt-bindings: pinctrl: qcom: drop common properties
Message-ID: <ZXeZmQDeiFwUJ1a6@radian>
References: <20231208215534.195854-1-krzysztof.kozlowski@linaro.org>
 <20231208215534.195854-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208215534.195854-9-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:55:33PM +0100, Krzysztof Kozlowski wrote:
> Drop common properties already defined in referenced common Qualcomm SoC
> TLMM bindings and use "unevaluatedProperties: false".  This makes the
> binding smaller and easier to review.
> 
> In few places move the "required:" block to bottom, to match convention.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Nice, acked for the SDM670 part.

>  .../bindings/pinctrl/qcom,ipq5332-tlmm.yaml   |  9 +-----
>  .../pinctrl/qcom,ipq8074-pinctrl.yaml         |  9 +-----
>  .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml   |  9 +-----
>  .../bindings/pinctrl/qcom,mdm9607-tlmm.yaml   | 18 ++++--------
>  .../pinctrl/qcom,msm8660-pinctrl.yaml         |  9 +-----
>  .../bindings/pinctrl/qcom,msm8909-tlmm.yaml   | 18 ++++--------
>  .../pinctrl/qcom,msm8916-pinctrl.yaml         |  9 +-----
>  .../pinctrl/qcom,msm8960-pinctrl.yaml         |  9 +-----
>  .../pinctrl/qcom,msm8974-pinctrl.yaml         |  9 +-----
>  .../pinctrl/qcom,msm8976-pinctrl.yaml         |  9 +-----
>  .../pinctrl/qcom,msm8994-pinctrl.yaml         |  9 +-----
>  .../pinctrl/qcom,msm8996-pinctrl.yaml         |  9 +-----
>  .../pinctrl/qcom,msm8998-pinctrl.yaml         |  9 +-----
>  .../bindings/pinctrl/qcom,qcm2290-tlmm.yaml   |  9 +-----
>  .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml |  9 +-----
>  .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 10 +------
>  .../bindings/pinctrl/qcom,sa8775p-tlmm.yaml   | 19 ++++---------
>  .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml |  9 +-----
>  .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml | 28 +------------------
>  .../bindings/pinctrl/qcom,sc8180x-tlmm.yaml   | 20 +++++--------
>  .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml  | 18 ++++--------
>  .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml | 10 +------
>  .../bindings/pinctrl/qcom,sdm670-tlmm.yaml    | 19 ++++---------
>  .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml | 10 +------
>  .../bindings/pinctrl/qcom,sdx75-tlmm.yaml     | 10 +------
>  .../bindings/pinctrl/qcom,sm6115-tlmm.yaml    |  8 +-----
>  .../bindings/pinctrl/qcom,sm6125-tlmm.yaml    | 20 +++++--------
>  .../bindings/pinctrl/qcom,sm6350-tlmm.yaml    | 20 ++++---------
>  .../bindings/pinctrl/qcom,sm6375-tlmm.yaml    | 18 ++++--------
>  .../bindings/pinctrl/qcom,sm7150-tlmm.yaml    |  9 +-----
>  .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml |  9 +-----
>  .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml |  9 +-----
>  .../bindings/pinctrl/qcom,sm8350-tlmm.yaml    | 20 ++++---------
>  .../bindings/pinctrl/qcom,sm8450-tlmm.yaml    | 20 ++++---------
>  .../bindings/pinctrl/qcom,sm8550-tlmm.yaml    | 10 +------
>  .../bindings/pinctrl/qcom,sm8650-tlmm.yaml    | 10 +------
>  .../bindings/pinctrl/qcom,x1e80100-tlmm.yaml  | 10 +------
>  37 files changed, 94 insertions(+), 375 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
> index 3d3086ae1ba6..e571cd64418f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq5332-tlmm.yaml
> @@ -26,13 +26,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 27
> @@ -100,7 +93,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
> index e053fbd588b5..6f90dbbdbdcc 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 35
> @@ -103,7 +96,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
> index e5e9962b2174..bca903b5da6d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,ipq9574-tlmm.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 33
> @@ -97,7 +90,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
> index 5ece3b9d676b..bd3cbb44c99a 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,mdm9607-tlmm.yaml
> @@ -25,19 +25,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
>    gpio-reserved-ranges: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
>  
>  patternProperties:
>    "-state$":
> @@ -110,6 +98,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
> index a05971611780..61f5be21f30c 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 86
> @@ -92,7 +85,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> index 5095e86fe9a2..295dd5fcf4c3 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8909-tlmm.yaml
> @@ -25,19 +25,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
>    gpio-reserved-ranges: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
>  
>  patternProperties:
>    "-state$":
> @@ -108,6 +96,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
> index 063d004967bb..904af87f9eaf 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 61
> @@ -114,7 +107,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
> index 9172b50f7a98..46618740bd31 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 76
> @@ -108,7 +101,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
> index 8a3be65c51ed..840fdaabde12 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 73
> @@ -124,7 +117,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
> index ca95de0b87a6..d4391c194ff7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8976-pinctrl.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 73
> @@ -104,7 +97,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
> index 41525ecfa8e3..fa90981db40b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.yaml
> @@ -25,13 +25,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 73
> @@ -114,7 +107,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
> index 59d406b60957..c5010c175b23 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 75
> @@ -133,7 +126,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
> index bd6d7caf499a..bcaa231adaf7 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,msm8998-pinctrl.yaml
> @@ -23,13 +23,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 75
> @@ -118,7 +111,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml
> index c323f6d495a4..e123beb33aef 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml
> @@ -22,13 +22,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -92,7 +85,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
> index b1b9cd319e50..4009501b3414 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qcs404-pinctrl.yaml
> @@ -29,13 +29,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 60
> @@ -130,7 +123,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> index 47363c23f4ea..88afeae530c6 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> @@ -26,10 +26,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 76
> @@ -37,10 +33,6 @@ properties:
>    gpio-line-names:
>      maxItems: 151
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -103,7 +95,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
> index d27933258db7..e9abbf2c0689 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
> @@ -25,13 +25,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 74
> @@ -39,12 +32,6 @@ properties:
>    gpio-line-names:
>      maxItems: 148
>  
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -110,6 +97,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
> index 573e459b1c44..5606f2136ad1 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7180-pinctrl.yaml
> @@ -29,13 +29,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 60
> @@ -112,7 +105,7 @@ required:
>    - reg
>    - reg-names
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> index c8735ab97e40..5329fe2a4397 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc7280-pinctrl.yaml
> @@ -23,24 +23,6 @@ properties:
>      description: Specifies the TLMM summary IRQ
>      maxItems: 1
>  
> -  interrupt-controller: true
> -
> -  '#interrupt-cells':
> -    description:
> -      Specifies the PIN numbers and Flags, as defined in defined in
> -      include/dt-bindings/interrupt-controller/irq.h
> -    const: 2
> -
> -  gpio-controller: true
> -
> -  '#gpio-cells':
> -    description: Specifying the pin number and flags, as defined in
> -      include/dt-bindings/gpio/gpio.h
> -    const: 2
> -
> -  gpio-ranges:
> -    maxItems: 1
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 88
> @@ -48,8 +30,6 @@ properties:
>    gpio-line-names:
>      maxItems: 175
>  
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -124,14 +104,8 @@ allOf:
>  required:
>    - compatible
>    - reg
> -  - interrupts
> -  - interrupt-controller
> -  - '#interrupt-cells'
> -  - gpio-controller
> -  - '#gpio-cells'
> -  - gpio-ranges
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml
> index b086a5184235..c122bb849f0f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8180x-tlmm.yaml
> @@ -31,20 +31,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  '#interrupt-cells': true
> -  gpio-controller: true
>    gpio-reserved-ranges: true
> -  '#gpio-cells': true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -  - reg-names
> -
> -additionalProperties: false
>  
>  patternProperties:
>    "-state$":
> @@ -106,6 +93,13 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
> index 4bd6d7977d3e..ed344deaf8b9 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-tlmm.yaml
> @@ -25,19 +25,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
>    gpio-reserved-ranges: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
>  
>  patternProperties:
>    "-state$":
> @@ -108,6 +96,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
> index 508e0633b253..a00cb43df144 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm630-pinctrl.yaml
> @@ -34,10 +34,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 57
> @@ -45,10 +41,6 @@ properties:
>    gpio-line-names:
>      maxItems: 114
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -130,7 +122,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> index 84a15f77e710..b56e717aa28e 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm670-tlmm.yaml
> @@ -25,23 +25,10 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 75
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -98,6 +85,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> index d301881ddfa8..dfe5616b9b85 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm845-pinctrl.yaml
> @@ -26,10 +26,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 75
> @@ -37,10 +33,6 @@ properties:
>    gpio-line-names:
>      maxItems: 150
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -110,7 +102,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
> index 62cd8f84af9c..cb1d978d02c9 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdx75-tlmm.yaml
> @@ -25,10 +25,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 67
> @@ -36,10 +32,6 @@ properties:
>    gpio-line-names:
>      maxItems: 133
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -102,7 +94,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> index 871df54f69a2..7f36f9b93333 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-tlmm.yaml
> @@ -29,13 +29,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
>    gpio-reserved-ranges: true
> -  wakeup-parent: true
>  
>  patternProperties:
>    "-state$":
> @@ -97,7 +91,7 @@ required:
>    - reg
>    - reg-names
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
> index 8d77707b02b9..ddeaeaa9a450 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6125-tlmm.yaml
> @@ -30,20 +30,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
>    gpio-reserved-ranges: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -  - reg-names
> -
> -additionalProperties: false
>  
>  patternProperties:
>    "-state$":
> @@ -105,6 +92,13 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
> index 27af379cf791..a4771f87d936 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6350-tlmm.yaml
> @@ -26,10 +26,6 @@ properties:
>      minItems: 9
>      maxItems: 9
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 78
> @@ -37,16 +33,6 @@ properties:
>    gpio-line-names:
>      maxItems: 156
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -112,6 +98,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
> index 6e02ba24825f..047f82863f9b 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6375-tlmm.yaml
> @@ -25,19 +25,7 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
>    gpio-reserved-ranges: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
>  
>  patternProperties:
>    "-state$":
> @@ -113,6 +101,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml
> index ede0f3acad9c..7f23f939ad32 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml
> @@ -32,13 +32,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 60
> @@ -111,7 +104,7 @@ required:
>    - reg
>    - reg-names
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
> index c6439626464e..bdb7ed4be026 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8150-pinctrl.yaml
> @@ -30,13 +30,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 88
> @@ -113,7 +106,7 @@ required:
>    - reg
>    - reg-names
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> index 021c54708524..b5d04347c064 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8250-pinctrl.yaml
> @@ -28,13 +28,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 90
> @@ -106,7 +99,7 @@ required:
>    - reg
>    - reg-names
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
> index 6e8f41ff0a76..ec5e09611d81 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8350-tlmm.yaml
> @@ -25,10 +25,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 102
> @@ -36,16 +32,6 @@ properties:
>    gpio-line-names:
>      maxItems: 203
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -108,6 +94,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
> index 5163fe3f5365..16fd2c5e2339 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8450-tlmm.yaml
> @@ -25,10 +25,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 105
> @@ -36,16 +32,6 @@ properties:
>    gpio-line-names:
>      maxItems: 210
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
> -required:
> -  - compatible
> -  - reg
> -
> -additionalProperties: false
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -107,6 +93,12 @@ $defs:
>      required:
>        - pins
>  
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
> index 567e44875c29..c2ae79df424f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8550-tlmm.yaml
> @@ -25,10 +25,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 105
> @@ -36,10 +32,6 @@ properties:
>    gpio-line-names:
>      maxItems: 210
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -119,7 +111,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
> index 370789ce934b..c0a06abf851d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
> @@ -25,10 +25,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 105
> @@ -36,10 +32,6 @@ properties:
>    gpio-line-names:
>      maxItems: 210
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -112,7 +104,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml
> index 3249c63a29cf..a1333e0743a9 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml
> @@ -25,10 +25,6 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> -  interrupt-controller: true
> -  "#interrupt-cells": true
> -  gpio-controller: true
> -
>    gpio-reserved-ranges:
>      minItems: 1
>      maxItems: 119
> @@ -36,10 +32,6 @@ properties:
>    gpio-line-names:
>      maxItems: 238
>  
> -  "#gpio-cells": true
> -  gpio-ranges: true
> -  wakeup-parent: true
> -
>  patternProperties:
>    "-state$":
>      oneOf:
> @@ -108,7 +100,7 @@ required:
>    - compatible
>    - reg
>  
> -additionalProperties: false
> +unevaluatedProperties: false
>  
>  examples:
>    - |
> -- 
> 2.34.1
> 
