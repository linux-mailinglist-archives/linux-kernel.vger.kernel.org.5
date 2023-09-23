Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2537AC384
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 18:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjIWQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 12:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjIWQOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 12:14:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B923A92
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 09:14:34 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4053cf48670so25184925e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695485673; x=1696090473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vflvz+AATv6d9uy0+n/CPOAt3NEI1Og8mJmqlW1xhco=;
        b=Nf/8o4t4Hin9O42VZaJp6ZCHPNKVq8reOjmV9t4RkD6fbBYZGF6J+1L+9GJE4oDwNS
         HNG32SydkaTWcwion39XSyGSo/PHho49LKglTiGdxHyG/qTL0T9PcKsPJWG5TIw7QW/D
         bjywnEUdsPf/XtRefMsqP7q5OimTsKjwFdYFYU1xv3QXdeSn7GvnUXhVe2wir6vFezPE
         tkX3CpPJgyrv40dtEOoaYhw2bf4DmkcZmN2t22JaW1tyl1l+y4XZSdyBwAoFHDl/WM7F
         OOq/h/MAIdaKe/G8gR/DxlTVVN2i4FClxKDo2c1Nc6cTVbX/zXmmxtx9GB98Avd/+/HA
         U8Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695485673; x=1696090473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vflvz+AATv6d9uy0+n/CPOAt3NEI1Og8mJmqlW1xhco=;
        b=XokoLKcaIdkplvnEntK3vHsG7eQOmOEMYNkEYqKI9uuGqyfKhaMdZWbLSroG6FHltk
         lRBfAgeCg0WNXrQ7DqnE7AbHJVp4cDX5ADXK3RYUOEqWughok/waKliSVQdYc7F5MLe4
         Ol0RCSaPtrxHE9SmXh0vAOGwydabHrn+/v5i0ZVyZtTWAPZcdpXPO1kQjZ+Z+seYlwWe
         2RcGoPfvP729lr7FDhkSYh2qpfW/QCBUkXOe9ex8xafHoVd8rgl4AtgLtCNokZtAUg/p
         X1X58q0N3dzr+tyr50MolVq6LuZX5FFUVl/8q1fhIfL2RJU59n41WAPpfmU51TUS0WgS
         DE3Q==
X-Gm-Message-State: AOJu0YwCSl7k7l3VHhrgGSGCDHOM3UYRHn7DaFXXLf/u5TTe0oO1GEGQ
        jV41mwVpC7YJN9ILnmNbxH3hBg==
X-Google-Smtp-Source: AGHT+IGa/JXt7k/sD3brA21YU73JU7T0XX5PP5dASJHJGNUDd9u/dTh6dZgbpssUlNcWDJ3phTImNA==
X-Received: by 2002:a05:600c:2282:b0:401:aa8f:7566 with SMTP id 2-20020a05600c228200b00401aa8f7566mr1692261wmf.26.1695485673156;
        Sat, 23 Sep 2023 09:14:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id f17-20020a1c6a11000000b00402f745c5ffsm7608479wmc.8.2023.09.23.09.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 09:14:32 -0700 (PDT)
Message-ID: <197aed7b-8698-98b8-5761-afd03fc6aae7@linaro.org>
Date:   Sat, 23 Sep 2023 18:14:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] dt-bindings: clock: qcom,camcc.yaml: Add sc8280xp
 CAMCC compatible
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jonathan@marek.ca, quic_tdas@quicinc.com,
        vladimir.zapolskiy@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230923150045.1068556-1-bryan.odonoghue@linaro.org>
 <20230923150045.1068556-3-bryan.odonoghue@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230923150045.1068556-3-bryan.odonoghue@linaro.org>
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

On 23/09/2023 17:00, Bryan O'Donoghue wrote:
> Document sc8280xp camcc as a new compat string with the same
> requirements as sm8250 and sm8450.
> 
> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> ---
>  .../devicetree/bindings/clock/qcom,camcc.yaml |   2 +
>  .../dt-bindings/clock/qcom,camcc-sc8280xp.h   | 179 ++++++++++++++++++
>  2 files changed, 181 insertions(+)
>  create mode 100644 include/dt-bindings/clock/qcom,camcc-sc8280xp.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,camcc.yaml b/Documentation/devicetree/bindings/clock/qcom,camcc.yaml
> index 81807b8e0d24..456d304cbea8 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,camcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,camcc.yaml
> @@ -30,6 +30,7 @@ properties:
>      enum:
>        - qcom,sc7180-camcc
>        - qcom,sc7280-camcc
> +      - qcom,sc8280xp-camcc
>        - qcom,sdm845-camcc
>        - qcom,sm6350-camcc
>        - qcom,sm8250-camcc
> @@ -127,6 +128,7 @@ allOf:
>        properties:
>          compatible:
>            enum:
> +            - qcom,sc8280xp-camcc
>              - qcom,sm8250-camcc
>              - qcom,sm8450-camcc
>      then:
> diff --git a/include/dt-bindings/clock/qcom,camcc-sc8280xp.h b/include/dt-bindings/clock/qcom,camcc-sc8280xp.h
> new file mode 100644
> index 000000000000..867fbd146ee4
> --- /dev/null
> +++ b/include/dt-bindings/clock/qcom,camcc-sc8280xp.h

Filename must match compatible (thus follow common naming scheme - SoC-IP).

Best regards,
Krzysztof

