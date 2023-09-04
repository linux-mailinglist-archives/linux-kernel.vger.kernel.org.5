Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACEF791224
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345387AbjIDH3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjIDH3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:29:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C72ACC1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:29:21 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52713d2c606so1432381a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693812560; x=1694417360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKhlI3usGbNsTVO7PIVpY6CjvMPzb/I9CgLAi4HhSko=;
        b=CfEfIF/FQkiyXhibpNoYgUrM4+ZJDuZNOzKhCjWoZclyqisZFWAuNFH7GmNPSbzvAy
         2Sg//oqPhG5GhRqDY0LYc4Y9Yk2UN2kwCMwiszarBoxngNxJ1Lrg6dXUi6zf7E7YMWcK
         xciBC1g21L6JWCO6L0UT+fa1OYTbtbVnGQn/difYGrGb5qizi44T8fhcXkg8gvr+OrtD
         qOcqMmS/RiO6lL2SPHezrRzdaRdotxlhlsKz46VyP5Q+m7KZlEhpSwTYYs9NCZCz7meq
         voDycgixJisz0DBjy2ppyDQySzylsFAMYxVHh/pjWEfvSSDTgGcLUkhvw2N8Ld1MirFC
         WgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693812560; x=1694417360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKhlI3usGbNsTVO7PIVpY6CjvMPzb/I9CgLAi4HhSko=;
        b=jS/w6jv7Gjd4KvFgWId/IAChAKaBafA2mTCwRIwGNxAhlkk9Kk7xp6pqwCTDSa4obO
         bcV14yNypMMmhz7fjbjWuhzk/ZWxJ/hmNHjLYRIeQL7Lo7k50ubJNoPhmqif7XbAXrdI
         VaNDbvBlKK9d4uhtrUWUNz8o086lcR9obR0k9RhiZFFX2Q48n0zUpUG81m6Eg6t6u+QH
         c+RS4U76eXZHKCOH2h0vhi5r4ctfHOBrVnv5NiJRq1DLH9Hz3q9uqsf2FoFok+AAQ/rQ
         Ou4cbFR7yTuKd+vMMCa+s/GBPmDQXk7f8uVKXecWPdJrO98DKzIrhYuvFCLPxPdWR//F
         thow==
X-Gm-Message-State: AOJu0Yy02ZH6JNChoNQJKulA5XnvZUCSUv5kb1NxisaMC5GDj23d9TBZ
        CEoMju8wRfWzMpQSIq+udsYhHw==
X-Google-Smtp-Source: AGHT+IFBjCYo1YPy4nz3cFsxiXZbYiH/IWUi7sSU7m3XJsicDTRb+fj5K5u9eAc3mkcfcfstepxAJg==
X-Received: by 2002:aa7:c685:0:b0:523:2e0e:5462 with SMTP id n5-20020aa7c685000000b005232e0e5462mr5727816edq.42.1693812559730;
        Mon, 04 Sep 2023 00:29:19 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id w25-20020aa7cb59000000b005222c6fb512sm5459282edt.1.2023.09.04.00.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:29:19 -0700 (PDT)
Message-ID: <0793a309-42bd-94d3-6002-8be6b2c13f6b@linaro.org>
Date:   Mon, 4 Sep 2023 09:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH 1/3] dt-bindings: reset: Document th1520 reset control
Content-Language: en-US
To:     Kwanghoon Son <k.son@samsung.com>, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jszhang@kernel.org, guoren@kernel.org,
        wefu@redhat.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, inki.dae@samsung.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20230904042559.2322997-1-k.son@samsung.com>
 <CGME20230904042603epcas1p11db03427cc5f434578d29dd51bc3ae85@epcas1p1.samsung.com>
 <20230904042559.2322997-2-k.son@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904042559.2322997-2-k.son@samsung.com>
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

On 04/09/2023 06:25, Kwanghoon Son wrote:
> Add documentation to describe th1520 reset driver

Bindings are for hardware, not drivers.

> 
> Signed-off-by: Kwanghoon Son <k.son@samsung.com>
> ---
>  .../bindings/reset/thead,th1520-reset.yaml    | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> new file mode 100644
> index 000000000000..a56d77af464a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reset/thead,th1520-reset.yaml
> @@ -0,0 +1,39 @@
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
> +properties:
> +  compatible:
> +    - items:

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

Drop '-'

Best regards,
Krzysztof

