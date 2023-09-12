Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEEC79C79C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbjILHFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjILHE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:04:56 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511E10D0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:04:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso56312595e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694502290; x=1695107090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6LYSAyqOGAquE7WJUWpSo20AQyTJGIFtgc4llB7UU2A=;
        b=d0sHYZ0uefz3BiUfy0UEGE7mGilu/K5MqsrIsUXUNLrLkGDvpmZuLywuDUFfTd5qBF
         jR4/MD8fh8J2TigwWDv5+GSY56bcDHd++kbWKAdRyAsHscH9mAwl4juMBLshDf0Ro0on
         i9RXPjNnoydioAoxKOUNNHcgYNM/Z28wqy5iwaPMkBdbTnAtv5XymnsPnG59QcsihztA
         Dmk7gQEH9PbXBhEStFNVjLqkrelMtp86XR0Tq4AwQPXp4k8nOJ8kWDhlt8z7eKJvLdTX
         rtlXNDZ4lhomWr+HeFj/Q3HrC4DlbL4dj0BAm34+rSIF4i8LRdzXsDipQ3HL6yx6TGUz
         Fmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502290; x=1695107090;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6LYSAyqOGAquE7WJUWpSo20AQyTJGIFtgc4llB7UU2A=;
        b=AyDCo4TOMonrqK205zD4LzX8Ak0IT9Il1v/DpU5LkijAuwdtcsp8RjX3vNZtzvHHMI
         mlJacW8WdyeuT5hx7D0fd/1ktU8uYpa/klj7x9ctvnVlw8tKnO/ywErONMDnxiITHNEP
         dffvTLu2gcpRofeG7MqnII0fQsORPQHbZmYjmR4Nw0oXZYcq93MdPqlXLNjNwV266cbk
         U39cQ7rTyMH4YjktOPrvlc6yrmVQocvYvJRilu5OsGtM4fviFJOwvYz1BA0x4/KGrPo/
         NHDrhRVkmy0csSeMlPIgHnPyx5gUchw1Vhcu9y73uo4sgsxtVUFBmCcRp658MIY4Dzb0
         96fQ==
X-Gm-Message-State: AOJu0Yw9VXgS1cMHEINGcqgsVU1iFBMXU3L5I4PHkdq36weenOh10xBi
        IbXkw3LsVG+m3VnapxBhtJgIKA==
X-Google-Smtp-Source: AGHT+IGDPgmBAH+Gv4gPep6zQB5ZcHI+8juP8EnWdQ5W/MaG4tXyzUAhDYJSgVfdo5qrPdjOy7lXrA==
X-Received: by 2002:a7b:cc8e:0:b0:3fe:687a:abb8 with SMTP id p14-20020a7bcc8e000000b003fe687aabb8mr10368161wma.7.1694502290167;
        Tue, 12 Sep 2023 00:04:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4570000000b00317f70240afsm12024520wrc.27.2023.09.12.00.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:04:49 -0700 (PDT)
Message-ID: <9da4efe6-bbff-62af-8d05-b05cf12a4c31@linaro.org>
Date:   Tue, 12 Sep 2023 09:04:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/3] dt-bindings: reset: Document th1520 reset control
Content-Language: en-US
To:     k.son@samsung.com, p.zabel@pengutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jszhang@kernel.org, guoren@kernel.org, wefu@redhat.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230912024914.3769440-1-k.son@samsung.com>
 <CGME20230912024917epcas1p4bb4d649f97b592c3245b10b6450d32cf@epcas1p4.samsung.com>
 <20230912024914.3769440-2-k.son@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230912024914.3769440-2-k.son@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2023 04:49, k.son@samsung.com wrote:
> From: Kwanghoon Son <k.son@samsung.com>
> 
> Add documentation to describe th1520 reset device

Full stop.

> 
> Signed-off-by: Kwanghoon Son <k.son@samsung.com>

This is v2, not v1. Please provide changelog after ---.


> ---
>  .../bindings/reset/thead,th1520-reset.yaml    | 47 +++++++++++++++++++
>  include/dt-bindings/reset/th1520-reset.h      |  9 ++++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
>  create mode 100644 include/dt-bindings/reset/th1520-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> new file mode 100644
> index 000000000000..6724a9ccdd55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reset/thead,th1520-reset.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: T-HEAD th1520 SoC Reset Controller
> +
> +maintainers:
> +  - Kwanghoon Son <k.son@samsung.com>
> +
> +allOf:
> +  - $ref: /schemas/mfd/syscon.yaml#

Why do you need it? Which existing file suggested such code?

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: thead,th1520-reset
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#reset-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/reset/th1520-reset.h>
> +
> +    soc {
> +      #address-cells = <2>;

Your indentation is messed up. Here two spaces, further four. Just keep
one indentation for the example - 4 spaces.

> +      #size-cells = <2>;
> +
> +      reset-controller@ffef014000 {
> +          compatible = "thead,th1520-reset", "syscon";
> +          reg = <0xff 0xef014000 0x0 0x1000>;
> +          #reset-cells = <1>;
> +      };
> +    };
> diff --git a/include/dt-bindings/reset/th1520-reset.h b/include/dt-bindings/reset/th1520-reset.h
> new file mode 100644
> index 000000000000..ec10751814e5
> --- /dev/null
> +++ b/include/dt-bindings/reset/th1520-reset.h

Filename matching bindings/compatible - missing vendor prefix.


Best regards,
Krzysztof

