Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7148C781FF2
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 22:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjHTUj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 16:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjHTUjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 16:39:13 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541CF44B7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:35:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3197f632449so2312153f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 13:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692563675; x=1693168475;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UTB3I1d2dOK1JlBCBmFpfVDR6TsDJNbHoAjcns5dz18=;
        b=qP1v8T/raKveU6SJZixB0+pszHmCqZIRCwvMlLjsNb9mVEqqlVjGhChaK+QqJSMMXv
         vKm1G0F5qF6BsdJ5Q2LCMD9cL05vZZQj2f7rPLlxHco/ka48OBcjC0w8nczrYbWbdetf
         RBcS5igv8kE7+6DWxAm1vEmX5PnWppP8jZTggJhr21QH6UuwoKDADkU5nfCKPqnpFLay
         PPJm8yBfEws78tWe1zP2TA2+J8+8k3JZ1cZlIEAHgQeYt0H8FWvODgcw7q8OLmkAfpSi
         aN0gI0Lpq8lEIxAkK0914eWRZn0ki1j0jPfBXfZz4Vmaub+QeIRTdQ0rqo0H2P1eEwAP
         dm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692563675; x=1693168475;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UTB3I1d2dOK1JlBCBmFpfVDR6TsDJNbHoAjcns5dz18=;
        b=OhzHxqvqZ1Cj3ftwxEmDYZ5hzTRQ/mS8ndhFbU7oGFIRjddFzDi7/apjkDnbYlxL0U
         A0GHMFTw0UX8sFPPSHzPGx5coEzVapaaUWfZ2+4bhvgG8WyCqo/mv/tsNsbaSGuoyswz
         E4vLY51ujNtN1c/FEFofTpgjhvuiI8lTbb/EaCrfb+EDizdodtyKPFqiA+dwv/ZyFva3
         l7i6C0NTJp1tqTMk/wrFYaKiQ5D0yAmbUlevzM01cqIwgdz0Nm/tfCHXEUIKMvzaCWFq
         AKfzZWlVXUQaw0UhED1n7GzuuFRWvrCz+MvD5xN2+cqFbFwXW3OQFv3NIeabym2r3CXe
         0WgQ==
X-Gm-Message-State: AOJu0YxUs6YHzTbLx5ZOGbU/v/86hlY25JDBh5AB6Yy/bSuyyzdKhR0u
        R6f0oIyfMmqptD6017Lupl8vYw==
X-Google-Smtp-Source: AGHT+IEqDyhvLvFU8YCyTFZ/G+6hQsHWbfuVsMIai85g16w8+0nFXnOrYA1YWKnlFMd45brHG0dUhg==
X-Received: by 2002:a5d:5267:0:b0:319:7b6f:4a5d with SMTP id l7-20020a5d5267000000b003197b6f4a5dmr3416380wrc.52.1692563675393;
        Sun, 20 Aug 2023 13:34:35 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id z13-20020a1709063acd00b0099bd7b26639sm5211898ejd.6.2023.08.20.13.34.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 13:34:35 -0700 (PDT)
Message-ID: <84388311-c92c-812e-53bd-35daf8821a16@linaro.org>
Date:   Sun, 20 Aug 2023 22:34:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] dt-bindings: iio: adc: Add TI TWL603X GPADC
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230820123229.530371-1-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230820123229.530371-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2023 14:32, Andreas Kemnade wrote:
> Document TI TWL603X GPADC devicetree bindings.
> A driver is already there, the compatibles are used, but not documented.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Please provide changelog after ---.


>  .../bindings/iio/adc/ti,twl6030-gpadc.yaml    | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> new file mode 100644
> index 000000000000..5b075237bcfd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,twl6030-gpadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPADC subsystem in the TWL6030 power module
> +
> +maintainers:
> +  - Andreas Kemnade <andreas@kemnade.info>
> +
> +description:
> +  The GPADC subsystem in the TWL603X consists of a 10-bit ADC
> +  combined with a 15-input analog multiplexer in the TWL6030 resp. a
> +  19-input analog muliplexer in the TWL6032.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,twl6030-gpadc
> +      - ti,twl6032-gpadc
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - "#io-channel-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    twl {

Just skip the twl node. Anyway, the parent device binding should include
complete example.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

