Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413257819DD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbjHSOEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232958AbjHSOEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:04:02 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546102782D
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:01:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1c66876aso236311266b.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692453662; x=1693058462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=thkemmRbCkWvUXe+jR2vKC8Ui6SovxiG+qsTgoCaXjE=;
        b=i94IRUm3RTleS+89ysDiyzufOC5MkTBU1PJccTyJOiHBDZYbvaDmX8FIsI2ovhNsoX
         5dG6V74T6diwVXxlYWop2mlDfk9tFTMu8m7yRzTJ7xhAE8/B+YcOhte5Niq+C7ITBGwJ
         /aKuA3JznE+a8pgoGoEPKi3kglWWORlC1Z3g7t9e4sLalUrHHra65Ozl1hedz5FTxlWz
         64OO9RctUzgwNhylL+ovp9jqPsIcQNPZvBLEMcEF6Xw9XPZl78WyS5nCrCHw5Z2AD9Fu
         C1RBArwjei2DhPnGoJJcrnR5jBnTnmBLpRsxarKJlWcqRKhqcO5kyo6oWIM+5x4uN0MB
         HQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692453662; x=1693058462;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=thkemmRbCkWvUXe+jR2vKC8Ui6SovxiG+qsTgoCaXjE=;
        b=aroaCUXo1JWl9NLr6CdKnLQrlPpjny8j0q0bQVfA8GD+1yNqYryfbzigaEKB4hPkAK
         T1zkqPCdfDDB6xHPMvqzVdeM/548pLNdwefNkYwRuaBx8YEc3wyAD423hENpDxHijnd+
         UP1fDOU7BnHVD6Tg5iRGIigPhvjvPkIk5SZd8xRpzOYBm6fS99xBzYft0rUEWogo7Ric
         bw5r3MmI8kdnUzu8TKkCB0uNlKz/aA0snT6O/x2J2/FncHIlvlcsvfeogRL9s2wSeYRb
         DeyalF4hVQ3PzKZKl4lRf4mdIFUnYbDeGbUi67aRO/pU3MNYgBnnVGLGBYKByfbGDYnD
         neZA==
X-Gm-Message-State: AOJu0YxuDhj/vHWAXE9jPK0ZZsWcNj2wlVa95dnbQI6JzVSqIj4mO5AG
        SVXOyVXOHmh9FQzbjKxxdo4T2g==
X-Google-Smtp-Source: AGHT+IHnmtL8/hbrFpBsIJy8dnKEqB1exfqnvp0DoVpU/Ne5MR9oZiXbj87Ip5sq1zPOzryT2Aw8NQ==
X-Received: by 2002:a17:907:7889:b0:99d:e417:d6f9 with SMTP id ku9-20020a170907788900b0099de417d6f9mr1551495ejc.41.1692453661808;
        Sat, 19 Aug 2023 07:01:01 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id ga23-20020a170906b85700b0098d486d2bdfsm2790853ejb.177.2023.08.19.07.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 07:01:01 -0700 (PDT)
Message-ID: <7a9bcd78-b544-524c-e944-5fbb0c60e600@linaro.org>
Date:   Sat, 19 Aug 2023 16:00:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 1/4] dt-bindings: media: Add bindings for Imagination
 E5010 JPEG Encoder driver
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com, eugen.hristev@collabora.com,
        ezequiel@vanguardiasur.com.ar, u.kleine-koenig@pengutronix.de,
        sakari.ailus@linux.intel.com, praneeth@ti.com, nm@ti.com,
        vigneshr@ti.com, a-bhatia1@ti.com, j-luthra@ti.com,
        b-brnich@ti.com, detheridge@ti.com, p-mantena@ti.com, vijayp@ti.com
References: <20230816152210.4080779-1-devarsht@ti.com>
 <20230816152210.4080779-2-devarsht@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816152210.4080779-2-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 17:22, Devarsh Thakkar wrote:
> Add dt-bindings for Imagination E5010 JPEG Encoder driver which is
> implemented as stateful V4L2 M2M driver.
> 
> Co-developed-by: David Huang <d-huang@ti.com>
> Signed-off-by: David Huang <d-huang@ti.com>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> ---
> V2: No change
> V3: 
> - Add vendor specific compatible 
> - Fix commit title and message
> - Update reg names
> - Update clocks to 1
> - Fix dts example with proper naming

I do not see improvements in the subject.

> 
>  .../bindings/media/img,e5010-jpeg-enc.yaml    | 81 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
> new file mode 100644
> index 000000000000..d105a71ee2ea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Imagination E5010 JPEG Encoder
> +
> +maintainers:
> +  - Devarsh Thakkar <devarsht@ti.com>
> +
> +description: |
> +  The E5010 is a JPEG encoder from Imagination Technologies implemented on
> +  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YUV422
> +  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
> +  8Kx8K resolution.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: ti,e5010-jpeg-enc

TI did not make e5010. Use SoC-based compatible.

> +          - const: img,e5010-jpeg-enc
> +      - const: img,e5010-jpeg-enc

img,e5010-jpeg-enc cannot be compatible with img,e5010-jpeg-enc. It does
not make sense. I guess I did not expect you are going to use what you
wrote in v1 directly... I thought it is just about syntax.

> +
> +  reg:
> +    items:
> +      - description: The E5010 core register region
> +      - description: The E5010 mmu register region
> +
> +  reg-names:
> +    items:
> +      - const: core
> +      - const: mmu
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: core_clk

Drop _clk or even drop clock-names. It brings little benefit for
one-entry list.


Best regards,
Krzysztof

