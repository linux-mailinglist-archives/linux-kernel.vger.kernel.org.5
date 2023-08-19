Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3504A7819E5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjHSOJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHSOJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:09:41 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DD749FD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:08:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so3108541fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692454078; x=1693058878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOWWo2LjMhwURY3WvPqWf8b8/SlL/lTQ9/nUQ2JsfPw=;
        b=e7dfceNuswSHhV2Q+Q8etq2aBEtr3w98FUvAaizPaJTpFDUtoqVa9BCoW1frz6RI8/
         xWt6BgfLhHzC64ZxzfasewKSEvAfH1q0y0awButVa4UXJJaAXuzNdWcCVodpGARhmMwA
         N9bxmnfd4g1g5L7M3oJ1KxgQNpMSBZlG1m9ohRhYqLDJiG5WCrfn1Swzw7QbFdKPTJr/
         lqQd9HJtrviGU4m+8/hck/l8qxawL8sXEw2T62OIHr5YEwZQzhv+wgWIIq/yZYwK84WH
         CsKAy8xId5oupp/WFjLBSFA11OMJb86IcFn+p46LPZZP0UNu2l+dVG/noZV2K6CbpFSF
         RfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454078; x=1693058878;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rOWWo2LjMhwURY3WvPqWf8b8/SlL/lTQ9/nUQ2JsfPw=;
        b=FhXhyhdqlQK66BOzU060fA3FwvjANxmHPngfd4bdLPY8HGRiBlwVzEEFdWREzhT2PP
         TZ22n/zKwl1cPh3+bWA6B94d95GCDA7NLYUZGXBjLo8FK0TcG3Y66Veng90hgX8JC7fb
         H1spFHT6QKgnU2skESrLt0UDR6XiQ3GOnliLjrmUXIvmr1IryvpgcX9+YCnETJmy1Zmv
         4XoYRQZxldfxB7TNa9esl9ivLrDleFfv0Fw8dqapmDpMZ1TOAq6JoTu3tlB/stGc7EIL
         7bhGbsETDwFUXF+hCd96lGOV0PUdrQCodHXYA61uOp0AK0kpLv0w0n5a2TcUiJJW57Do
         YJVw==
X-Gm-Message-State: AOJu0YweQv/5FgFHR4G5hXmEzLgCYYzHkKBuvC2N1wfreMpNBEdx9tO2
        8MbWqxpRI7DF9xER1yjCLWpZJw==
X-Google-Smtp-Source: AGHT+IFcVY3kUSEo4uMdTwq4eVoLkaPw9Pk8yz0tAyTzHiev4w1z2+aBXysOe8ooRigg1Fhn8d8yEQ==
X-Received: by 2002:a2e:9b4e:0:b0:2b9:ecc5:d1de with SMTP id o14-20020a2e9b4e000000b002b9ecc5d1demr1374245ljj.37.1692454078299;
        Sat, 19 Aug 2023 07:07:58 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id m18-20020a1709061ed200b00988dbbd1f7esm2758273ejj.213.2023.08.19.07.07.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 07:07:57 -0700 (PDT)
Message-ID: <3c2bfa91-44b3-0b1d-aa41-52f1e46df796@linaro.org>
Date:   Sat, 19 Aug 2023 16:07:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/2] regulator: dt-bindings: Add Awinic AW37503
Content-Language: en-US
To:     like@awinic.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        liweilei@awinic.com, liangdong@awinic.com, wangweidong.a@awinic.com
References: <20230816081728.2812458-1-like@awinic.com>
 <20230816081728.2812458-3-like@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816081728.2812458-3-like@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 10:17, like@awinic.com wrote:
> From: Alec Li <like@awinic.com>
> 
> Add aw37503 regulator device-tree binding documentation.
> 
> Signed-off-by: Alec Li <like@awinic.com>
> ---
>  .../bindings/regulator/awinic,aw37503.yaml    | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> new file mode 100644
> index 000000000000..65a891505808
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/regulator/awinic,aw37503.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Awinic AW37503 Voltage Regulator
> +
> +maintainers:
> +  - Alec Li <like@awinic.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The AW37503 are dual voltage regulator, designed to support positive/negative
> +  supply for driving TFT-LCD panels. It support software-configurable output
> +  switching and monitoring. The output voltages can be programmed via an I2C
> +  compatible interface.
> +
> +properties:
> +  compatible:
> +    const: awinic,aw37503
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^out[pn]$":
> +    type: object
> +    $ref: regulator.yaml#
> +    unevaluatedProperties: false
> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Properties for single regulator.
> +
> +    properties:
> +      regulator-name: true
> +      regulator-always-on: true
> +      regulator-boot-on: true

Drop all three above. They are not needed, because you use
unevaluatedProperties:false.

> +      enable-gpio:

I believe the name *everywhere* is enable-gpios.


Best regards,
Krzysztof

