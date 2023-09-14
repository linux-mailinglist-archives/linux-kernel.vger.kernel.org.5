Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C1A79FB66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbjINF5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbjINF5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:57:41 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C88C1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:57:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-401187f8071so3687295e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 22:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694671055; x=1695275855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sd+yNH3HCnvohWB8kKSot+DWu8r82XF/02XSPDy4hjI=;
        b=UvDXbsFrxyjkT18fjOC3Nxj0bIkmoBXqgIdESy4mNm/znxKs+DqDC3Yp2+KQqaD5K4
         nC1aZ0dgNV4kmitZlNestAqaU23OkyaHjBngBW/zSLxyGORmHJ1aVhAuheUxFJNve/Ts
         N9KhGmtOGsywG7izkjUmiB0vLeMLxsV3r14pjLlqkdgepgcKZWxXfgvZzlfj7Rq7sOvk
         0GrQ7+gjLVEiB5BFj2omrvXDmsCNpVwgHOMJ0Fktn3uZtnMtnIOR7HOkbgRUdsL0LKrH
         IXeDD690qy0lWemaSUOVQnzo6lXtwW3SQUNOBEXfdRg+FsADgt/AHTdaZ/Rc3jDCKXMq
         sk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694671055; x=1695275855;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sd+yNH3HCnvohWB8kKSot+DWu8r82XF/02XSPDy4hjI=;
        b=BKfHyHAOm2IfHP2D8ATxvAAfTuq/Z0ALFGNUKcwxrOkksLc822xJ7Kq5nSZ2fS8qNf
         KFPq5HTpPFm33dbwDPovDhK1bytB5hOYPbolqf5cARf/zT/PfDQlLPBoEx5eubyNCl4z
         WdQrliIE84VM8U97495q/wkqYlq8CIwonCEY3r+wK45vfpST+DbUm9XDpQhwL4gB4Tvg
         Gll7tALV62HLD4NBuFg3YMxhTx6XRoj5DdVIQTdtZ/AwatOXbcGqqDvkh2tDJSWwtoXu
         q11bxB3CBf31fK8HLJOKaXyxBhCGClhdVAwXoiw8NNeSDvYWiaL1hdSZx16PQF0RTfDU
         QgcQ==
X-Gm-Message-State: AOJu0YxDqOgdgRqs7QJyTeZJk39Ahrws4/pHApvrNlSRHIDyxiS8qPKC
        8SlKj3VdeN9xUJF7u3VDA5MIsg==
X-Google-Smtp-Source: AGHT+IHQ3ToshXAt0xNl0LOHLgftxsrHEuc1Dba4IRwvwAmsrwulg2mrlsMfDvVYxxeB3xwA76gJBw==
X-Received: by 2002:a05:600c:8607:b0:402:ea5c:1845 with SMTP id ha7-20020a05600c860700b00402ea5c1845mr574855wmb.5.1694671054983;
        Wed, 13 Sep 2023 22:57:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a22-20020a05600c225600b00402d7105035sm3871567wmm.26.2023.09.13.22.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 22:57:34 -0700 (PDT)
Message-ID: <196fb9ac-53b7-51a6-6ce4-9f980215fde4@linaro.org>
Date:   Thu, 14 Sep 2023 07:57:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/4] dt-bindings: serial: document esp32s3-acm bindings
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230913211449.668796-1-jcmvbkbc@gmail.com>
 <20230913211449.668796-4-jcmvbkbc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913211449.668796-4-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 23:14, Max Filippov wrote:
> Add documentation for the ESP32S3 ACM controller.

A nit, subject: drop second/last, redundant "bindings". The
"dt-bindings" prefix is already stating that these are bindings.

> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  .../bindings/serial/esp,esp32-acm.yaml        | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
> new file mode 100644
> index 000000000000..dafbae38aa64
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/esp,esp32-acm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ESP32S3 ACM controller
> +
> +maintainers:
> +  - Max Filippov <jcmvbkbc@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.


> +  ESP32S3 ACM controller is a communication device found in the ESP32S3

What is "ACM"? Why is this in serial? Only serial controllers are in
serial. The description is very vague, way too vague.

> +  SoC that is connected to one of its USB controllers.

Same comments as previous patch.

> +
> +properties:
> +  compatible:
> +    const: esp,esp32s3-acm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    acm@60038000 {
> +            compatible = "esp,esp32s3-acm";

Use 4 spaces for example indentation.

> +            reg = <0x60038000 0x1000>;
> +            interrupts = <96 3 0>;

Same comments as previous patch.

> +    };

Best regards,
Krzysztof

