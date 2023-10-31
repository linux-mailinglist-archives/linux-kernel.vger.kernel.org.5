Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F315E7DC7EA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 09:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjJaIK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 04:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjJaIKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 04:10:54 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DEEDB
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:10:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo8693919a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 01:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698739850; x=1699344650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qNR0LwRNnU1jGPNBV107BlKsfVOgNHAQnTl2aV+lYLY=;
        b=w/5LESH51X/dGnLD4gTUsaR4rMl7oFK02uVqK/05cKPfWislpR8osSV4JAaq5N49K/
         Bt0TMe8A3xT8gm/v130tBft/nTNYXNqSpd0pVgKUqcdZz+OPbGLaFE7FR6WYYZL8Fax0
         CY76Pi5LnO3f87up0mXzAccL+eZeQUaCb+8aCTZZWUmOQ35dbuBsbfQyZEDy3CGYDUAA
         0Q0BT/nY/7Dl8ki34/9AmS5kG5JHL5lLv4R0cFY8Dd2VPRID2sxBnZAXZleszADbGAZU
         CU5Zr+x5h4QrpvPOzbKq0VfJYbyqLtke8XiKTmX3U0ggIINGiua4jQoYthFrG6SHuoOc
         GyPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698739850; x=1699344650;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNR0LwRNnU1jGPNBV107BlKsfVOgNHAQnTl2aV+lYLY=;
        b=K+oih8QirYnhgqJtsZqDbnQPxVnGq3ZGR/2C+i7tsQ2Y7vTKT1meZ30ybe14DGAi7S
         9VHUKOwf/sVZGWKF2DeRgEjQmAGW1oyl5Jfy5wmwFxBlAGMIt97eWkoBhzeCMnR8GVxH
         M8DB2K33WyRRd4yVXdVNvR2f000rpuUF+FlkyHjm9GTdBDq4xJ1iULHzUy26tLhueHdE
         ld6KFsacGdIbGnVINQW4J2RycFFGUI4EwDlPAE6SdUnQNVAcFwdICIyJzH1VFknMvcqI
         wiDk/Dv/u6fuaqo3TTtoFoLnD+aTdnynTJddycxSJ24CpT65i6mIB9F1/fAXQgQA1PTG
         cl5g==
X-Gm-Message-State: AOJu0Yy81dYR6EKVXf3U0x1oeFdIgPT9bHy+/TUI7NNfL+mQemofhidU
        6U4tAZ7tfb3iNWW5+beA+/shdQ==
X-Google-Smtp-Source: AGHT+IFe5OnHjB7K9tbnv7nkE3Ici4vSlrGnWKMlKlKlcKfsBKsAiOqO3UJ0SMmFtz2j+RArk1StFg==
X-Received: by 2002:a50:d55d:0:b0:543:5281:2ad8 with SMTP id f29-20020a50d55d000000b0054352812ad8mr1861913edj.18.1698739850141;
        Tue, 31 Oct 2023 01:10:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id w23-20020aa7dcd7000000b005402748cf29sm683591edu.50.2023.10.31.01.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 01:10:49 -0700 (PDT)
Message-ID: <63af180f-956d-4fe0-b968-168bfb746d63@linaro.org>
Date:   Tue, 31 Oct 2023 09:10:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Content-Language: en-US
To:     "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc:     "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>
References: <c8bbeb3c3d9b44049d790e90d9738a83@monolithicpower.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <c8bbeb3c3d9b44049d790e90d9738a83@monolithicpower.com>
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

On 31/10/2023 07:59, Yuxi (Yuxi) Wang wrote:
> 

1. Stray blank line in your commit.
2. Send patches with proper threading (which is by default by all
tools!). Lack of threading makes it difficult to apply entire set or use
b4 diff.

> Document mps mp3326 LED driver devicetree bindings.
> 
> Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
> ---
>  .../devicetree/bindings/leds/leds-mp3326.yaml | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-mp3326.yaml b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
> new file mode 100644
> index 000000000000..df03c21ae53a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml

Filename like compatible.

> @@ -0,0 +1,184 @@

> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds-mp3326.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: LED driver for MP3326 from Monolithic Power Systems

"driver" as Linux driver? If so, drop. MP3326 could be a WLED driver, so
"driver" as hardware term, but it does not make sense in "driver for
MPS3326"


> +
> +maintainers:
> +  - Yuxi Wang <Yuxi.Wang@monolithicpower.com>
> +
> +description: |
> +  Monolithic Power Systems MP3326 LED Drivers
> +
> +  For more product information please see the link below:
> +  https://www.monolithicpower.com/en/products/mp3326.html
> +
> +properties:
> +  compatible:
> +    - const: mps,mp3326

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

I'll stop reviewing. No point to review untested code.


Best regards,
Krzysztof

