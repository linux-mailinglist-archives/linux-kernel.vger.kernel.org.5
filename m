Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4895B766564
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjG1Hbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbjG1Hbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:31:32 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7AB2735
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:31:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-98df3dea907so244525966b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690529489; x=1691134289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJmb5dhR/A69axFp1n/g3w1WP4NZBl+VMQ8J3r8W4Go=;
        b=CMCbVYq2we1aK2YgyhLbvUPjHv8upf6iecEYG445wcF7z+ZtnBl11qU/H7Bj19u460
         1y4KjJvJfBx/Vl3xllxT5aqmSQ6RH+kUFvp69q4awuzJ+EFcE6nLAhd70usmByNh691z
         ICJ/ReEyhmU1uDTH6tTDY4uIG1iI+9fyksVihIKHTbBLEi0FUqTHXHlKwRDu2CmKUeFE
         afBKX9LJQ9+HBerptlPVYAdx+LCppFn5rJjhopLk5cJwX/Ahf/DL5Zi8HATEbvYYUjxz
         cSvemKUlV8xr60sg1SAqQzPWhvm/zujwxNjGrk7F0W224PPu+rfjVL151HRgM2gmLCMZ
         hRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690529489; x=1691134289;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJmb5dhR/A69axFp1n/g3w1WP4NZBl+VMQ8J3r8W4Go=;
        b=FdDCiww+uzv9EPnghAYn34ABWe6joqKudqvuynKlXF9mqua6afM6qth6D/JqxK8vlr
         8F9/vL1XmwFohm7V3p8UDWsTzzQXOh3bHr6sNjrpOB3zzmbNZNOeFHXn0LOmI2Tbpug2
         lNWtQ5e8Q+PNaXjmBEOH7MRmi4meXMOlINENCzYELEMPQkJdgocAq+ANNl2wrIoBRpPu
         cIEDTcdk2jx8VgAMKyDBWep7pN+ocAvOI7nKAEYLb/Y3LtasbPtj/tXFmAIouRIwjRqc
         +TT3crAnpD0HbXDHN8gHMnWPchgfFexJ6e0RTf6fLlazRCys+AstIF0ctYTjiVV8uVF3
         qadA==
X-Gm-Message-State: ABy/qLYO82ijoDuyTkSA9ojcOpiVMPLlHHYpDVleQqwhN0PLDwxldN4a
        gR+GSUaxhNQaSocBZPasefgMfA==
X-Google-Smtp-Source: APBJJlFGeWYG4rS/QYddKDPW5upbEl7+O2bgJN59+hicqThEbi6BO/HJCDw6yicrvW9/cB7ORc4SlQ==
X-Received: by 2002:a17:906:328d:b0:993:d1b6:61cc with SMTP id 13-20020a170906328d00b00993d1b661ccmr1157247ejw.44.1690529489331;
        Fri, 28 Jul 2023 00:31:29 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906408700b009786ae9ed50sm1698270ejj.194.2023.07.28.00.31.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 00:31:28 -0700 (PDT)
Message-ID: <b4c15d67-3cbd-3c02-cfa3-54d52d0b85dd@linaro.org>
Date:   Fri, 28 Jul 2023 09:31:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] dt-bindings: leds: Add binding for Broadchip BCT3024
 LED driver
Content-Language: en-US
To:     Matus Gajdos <matuszpd@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230727160525.23312-1-matuszpd@gmail.com>
 <20230727160525.23312-3-matuszpd@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727160525.23312-3-matuszpd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 18:05, Matus Gajdos wrote:
> The BCT3024 chip is an I2C LED driver with independent 24 output
> channels. Each channel supports 256 levels.
> 
> Signed-off-by: Matus Gajdos <matuszpd@gmail.com>

Thank you for your patch. There is something to discuss/improve.

A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.

> ---
>  .../bindings/leds/broadchip,bct3024.yaml      | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml b/Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml
> new file mode 100644
> index 000000000000..0d622894e79c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/broadchip,bct3024.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/broadchip,bct3024.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadchip BCT3024 LED Driver
> +
> +maintainers:
> +  - Matus Gajdos <matuszpd@gmail.com>
> +
> +description: |
> +  The BCT3024 is an I2C LED driver with independent 24 output channels. Each
> +  channel supports 256 levels and its output current can be scaled by a factor
> +  of 1, 1/2, 1/3 and 1/4.
> +
> +properties:
> +  compatible:
> +    const: broadchip,bct3024
> +
> +  reg:
> +    description: I2C slave address of the driver.

Drop description, it is obvious.

> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator providing power to the VDD pin.
> +
> +  shutdown-gpios:

powerdown-gpios instead. See gpio-consumer-common.yaml

> +    maxItems: 1

And this won't be needed.

> +    description: GPIO attached to the SDB pin.
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +


Best regards,
Krzysztof

