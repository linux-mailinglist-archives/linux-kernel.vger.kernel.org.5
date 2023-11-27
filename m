Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131FB7F9B18
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 08:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjK0Hqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 02:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjK0HKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 02:10:16 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153131FFA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:09:43 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-a0f49b31868so73315866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 23:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701068981; x=1701673781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9GW1TDioLY5vdADSFwXA/zMGb7NkUYx8GOUReKjU5Q=;
        b=MZcwNS6YFL/ecj80+tOJ9LtW+PZHNpI5mG8MV4LBVSVhCAD319aiSBfZVS/NsfCYqk
         8PtLTscJQZcuH35FtBDSCwzeIQYm0AmFzjzWevhkjjzrCHo90EBt0OWBKQRGm9W89QQU
         JvYm9zJgG4ZFLLkhlFMEy4e2nVcuY9rv8MProxI+0Htjap+xmSzcuR3xkNgEDr9ZcSui
         zfcMRycsKTS3hE8P5yumL/R+teYbqJudSMu7sA1iWYAho/tWfbPbPaDt7kor6Lv05n9k
         xI9djZuWYmkf6LP643PhgotDnB89MIOyEq4gbnJuT/jROOCf603fbLhmmNaRM6tPM8hw
         cNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701068981; x=1701673781;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9GW1TDioLY5vdADSFwXA/zMGb7NkUYx8GOUReKjU5Q=;
        b=XyaExpNxiZpFJfMqb/7180hpGa75pf34KRS8lhPzRvxUeWwi+YyMEkNAQJrq1rCXsM
         yzyayUSF1RHKN7pdFKWRy0EO6Y6jRNl7DOy6o2a57ohgrYa8+cCX5cmyoU3gUMWs9lnY
         zL54zPMrk1RcrEFdnhuJuSUhEQRFIwp4Ko1c6KE401z3N/4sRNFG+gohmIQu8ppRkNjW
         cWOmJh8bBX2cGWaMEpS/Gj+TAYvns6oNB6VCl+3F4yGUzgjE0aueBMXOVIyZDm/qXskd
         Em9ApLW41TJGaurH9dWbFL2zmC1hOXw6VRessVejZgysp0l0NZHS2wI9OAWr2oqPW1Cq
         +NNw==
X-Gm-Message-State: AOJu0YwRkwJPeLVRk/VUxrnCzO/JDntN0cdaO5dvUTrxTxh8NzX9Mna/
        9M9q+3odzSXYy5FWTKAkh/qCWQ==
X-Google-Smtp-Source: AGHT+IG/V9FhAJXFRlAWq6sCwDujgFJ0/jiTYy3NYEEszgWw0VinneHrRgG/G/1nYZtvLnF7lXLgCQ==
X-Received: by 2002:a17:906:6808:b0:a03:9680:8149 with SMTP id k8-20020a170906680800b00a0396808149mr6586573ejr.55.1701068981560;
        Sun, 26 Nov 2023 23:09:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id b10-20020a1709063f8a00b009f8af454d0dsm5350041ejj.112.2023.11.26.23.09.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Nov 2023 23:09:41 -0800 (PST)
Message-ID: <98f4cffd-0094-48c4-b899-937e555693fb@linaro.org>
Date:   Mon, 27 Nov 2023 08:09:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: soc: sophgo: Add Sophgo syscon module
Content-Language: en-US
To:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, conor@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com,
        guoren@kernel.org, jszhang@kernel.org, inochiama@outlook.com,
        samuel.holland@sifive.com
Cc:     Chen Wang <unicorn_wang@outlook.com>
References: <cover.1701044106.git.unicorn_wang@outlook.com>
 <6ff37629458cde4549067e0caddeb5cb640ca7f9.1701044106.git.unicorn_wang@outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6ff37629458cde4549067e0caddeb5cb640ca7f9.1701044106.git.unicorn_wang@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 01:58, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> Add documentation to describe Sophgo System Controller Registers for
> SG2042.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  .../soc/sophgo/sophgo,sg2042-syscon.yaml      | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
> new file mode 100644
> index 000000000000..329d645091b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-syscon.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-syscon.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sophgo SG2042 SoC system controller
> +
> +maintainers:
> +  - Chen Wang <unicorn_wang@outlook.com>
> +
> +description:
> +  The Sophgo SG2042 SoC system controller provides register information such
> +  as offset, mask and shift to configure some modules, such as clocks, reset
> +  signals and pinctrl.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - sophgo,sg2042-syscon
> +      - const: syscon
> +
> +  reg:
> +    maxItems: 1
> +
> +  clock-controller:
> +    # Child node
> +    type: object
> +    $ref: ../../clock/sophgo/sophgo,sg2042-clkgen.yaml

Use full path, so /schemas/clock/
(look at other bindings how they do it)

> +    description:
> +      Clock controller for the SoC clocks. This child node definition
> +      should follow the bindings specified in
> +      Documentation/devicetree/bindings/clock/sophgo/sophgo,sg2042-clkgen.yaml

Drop description.

> +
> +required:
> +  - compatible
> +  - reg

clock-controller, no?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    syscon@30010000 {
> +        compatible = "sophgo,sg2042-syscon", "syscon";
> +        reg = <0x30010000 0x1000>;
> +    };
> +
> +    syscon@30020000 {
> +        compatible = "sophgo,sg2042-syscon", "syscon";

Wait, these are two different devices. Why do you use the same
compatible for them? Is their register layout exactly the same?

Best regards,
Krzysztof

