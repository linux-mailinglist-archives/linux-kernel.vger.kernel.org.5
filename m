Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C467D781BE9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 03:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjHTA7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 20:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHTA6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 20:58:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D9923F763
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:35:31 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b9cdba1228so31839041fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692470129; x=1693074929;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN1OpmCbaY81QbyPI9C85rcMVU0xABdKhrlhiE3u5AI=;
        b=gQVsr71trj0v6TnZbViu5KLlzO9r2799VjZoC9vzHe1mXxDJw/DxeApmhVFYNLrAXZ
         oW0ST51eoMROfOsyQtYWf1vheuYceSIZzlFyMRdgEm97ZYBHI0UrFQZKMc9CbPHWX0zw
         z++AnrETDHCRIPmVhEy6gzWVbBid/zXgRP6XmaTbD7zTMSohxPRDhF/I0cvhjKyRE+q+
         G02eGi+xaLeP88JHBYavqUXJSdCPzr+PffwTuTwJDk7a06yn3ptH7gxAQaYCiAMWbyqy
         NWgC8yn9xxWmwjs+8OzFt88vsJeGRUf/UUQhjJjW8ohzAfXaTFNWfQqqfD5aV50qJ4pg
         R9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692470129; x=1693074929;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN1OpmCbaY81QbyPI9C85rcMVU0xABdKhrlhiE3u5AI=;
        b=LUO2n6N6pUgIphFzgw6Y4C7Vg1pI2DF0iHOu0vahs9bzgdGCYhl2TsCD0Vm5Ls9YAU
         3CjwyBctUFjRL6Gha4wO4zA3VaqLn0OVpzhcit0TxNg3kjqzV6yt31c36ULviTGv6mjm
         Utizfc3JsBQSx1cP4QxgE8oMrBfeNYolm81Hyzb1iSYQmcjVCuMayipq6zAof5Ue4svr
         UcjZ3+V5x8THrP355NXuSufvcuERyMsqg4SuWpsYnWTdLUt+PhhWv5XgqwOXGhL/2hVY
         gBuVjLLV4JTa1SNFBTbG4nkYqMqu87m4qC4G4k6oSt60pqWCkdls7ouIftr/rfjmr4rB
         fwbA==
X-Gm-Message-State: AOJu0YzJO5pThw4NZV8DoV80p8XO8qUlZq25pSCz8snLHEyZuSeBo5Rv
        x9pFDiU+lYnbX9tt5mKq4khJpQ==
X-Google-Smtp-Source: AGHT+IHyIS3/rx1L8OgHE5RB+ScVHWoDpPgPFtw8VIbtYoEjUhFHSppkQ7zw42ytcZvQ8xvrMHk2RA==
X-Received: by 2002:a2e:731a:0:b0:2bb:9710:9d99 with SMTP id o26-20020a2e731a000000b002bb97109d99mr1695872ljc.44.1692470129550;
        Sat, 19 Aug 2023 11:35:29 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id z1-20020a170906240100b0097073f1ed84sm3150266eja.4.2023.08.19.11.35.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 11:35:28 -0700 (PDT)
Message-ID: <426d78d6-9fa6-bfeb-b36a-fba264097a27@linaro.org>
Date:   Sat, 19 Aug 2023 20:35:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: iio: adc: Add TI TWL603X GPADC
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
References: <20230816202614.324457-1-andreas@kemnade.info>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230816202614.324457-1-andreas@kemnade.info>
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

On 16/08/2023 22:26, Andreas Kemnade wrote:
> Document TI TWL603X GPADC devicetree bindings.
> A driver is already there, the compatibles are used, but not documented.
> Use two separate files to reference only the allowed compatible in
> a future YAML version of
> Documentation/devicetree/bindings/mfd/twl-family.txt
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---

Thank you for your patch. There is something to discuss/improve.


>  .../bindings/iio/adc/ti,twl6030-gpadc.yaml    | 42 +++++++++++++++++++
>  .../bindings/iio/adc/ti,twl6032-gpadc.yaml    | 42 +++++++++++++++++++
>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,twl6032-gpadc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> new file mode 100644
> index 000000000000..08bc0468f616
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,twl6030-gpadc.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/ti,twl6030-gpadc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPADC subsystem in the TWL6030 power module
> +
> +maintainers:
> +  - Jonathan Cameron <jic23@kernel.org>

This should be rather someone knowing or having or caring about this
particular hardware, not subsystem maintainer.

> +
> +description:
> +  The GPADC subsystem in the TWL6030 consists of a 10-bit ADC
> +  combined with a 15-input analog multiplexer.
> +
> +properties:
> +  compatible:
> +    const: ti,twl6030-gpadc

Devices look fairly similar. Same properties. Why aren't they in one
binding (enum here instead)?

Best regards,
Krzysztof

