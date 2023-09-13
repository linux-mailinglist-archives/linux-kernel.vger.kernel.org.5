Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB379ED75
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjIMPlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjIMPlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:41:06 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428672108
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:40:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bf5bf33bcdso113000341fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694619637; x=1695224437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6Hbh6ZXKDhz/KGGt8fE9NnsA0nrENPPs+dh7XyDcr6Q=;
        b=yrem6MrLesXG2KS3JgTkCT2FTmW5jsLargh35ebvQ5PLnpHO1Q8dvUDuiiNFvuN+qx
         PZWIP2Xp2bFfjK6vV+f38t5KZSI4hzzj9xp5X4ctYTxT0Y5jgS9pzmuKMehpB3BL1ELx
         9qmNisJKsbRidifYzmhE3LCLX1phf1ylOIi+Kxg9YbBoP9Fs72ohsfZKBSYhzMNNl07f
         6vTHu8tXMQrg82Cw2hnngCboELcknhxXBOHs8enf8mUTH4x7Z9K8unD86iQ5PMrA5nGi
         UGBooD8MfMYuXM/cTdWaNzBn7Tm+1dFzXcNSsX4exyNhnoC4qnwh2g+h3+bnqHHhR44m
         K7DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619637; x=1695224437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Hbh6ZXKDhz/KGGt8fE9NnsA0nrENPPs+dh7XyDcr6Q=;
        b=s3gCOQ3H7G/r+gwvoL+xddXvjPHuyoMrDTRRMfZRbHAZewZxdqOp+faPmqa8hTp8Rb
         4yNTqrsjaybhvy3HpRbkdOaDyGQAmbsqM7jcyQfKadQb5yA9vcDVq2Qhr1/e+IkMF71B
         eDbzD9Au4IK0m2p/qS8hVbC19uV2VqCmlZ585cLeZ1XCGd8gZcbDGpp2/SMv4Z2rZ9kU
         Uyxw3Okx4oXdew654UfyoaMfiUfZBwOumgNRYDJ+A932zwrCbQX/iB/bI9MPbxE3/usf
         2gKnpF6dgQagi0JZ41H93qoY0jq+LPgrG8Xdm3uWL2QE6MabKch/inA1Z4KAc+V18Adf
         13Bg==
X-Gm-Message-State: AOJu0YxLqWYxj2q+/j77DnntGUImPQThQ1VUwdHsKqtcFlKQQcTjTP6a
        6v4rGfWlWFAReyKJKnvbQQyWp4XGxCGXk1XhL6U=
X-Google-Smtp-Source: AGHT+IGIQlJGO3sBAtR5nD8DNpUZLzgzVbqsdyqIkbN1GwHI5WbfyunvrUH8ZxR4K05vPJG5eAuV3Q==
X-Received: by 2002:a2e:7c19:0:b0:2b6:bb21:8d74 with SMTP id x25-20020a2e7c19000000b002b6bb218d74mr2620372ljc.1.1694619637390;
        Wed, 13 Sep 2023 08:40:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id oz13-20020a170906cd0d00b0098951bb4dc3sm8623318ejb.184.2023.09.13.08.40.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:40:36 -0700 (PDT)
Message-ID: <177ef05b-0cca-be25-afad-ac518d9f6473@linaro.org>
Date:   Wed, 13 Sep 2023 17:40:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/4] dt-bindings: hwmon: Added new properties to the
 devicetree
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230913152135.457892-1-daniel.matyas@analog.com>
 <20230913152135.457892-3-daniel.matyas@analog.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230913152135.457892-3-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 17:21, Daniel Matyas wrote:

Subject: not much improved. I am sorry, but you are not adding new
properties to entire devicetree of entire world. You are actually not
adding anything to any devicetree, because these are bindings (which is
obvious, as said by prefix).

You got comments on this.

> These attributes are:
> 	- adi,comp-int - boolean property
> 	- adi,alrm-pol - can be 0, 1 (if not present, default value)
> 	- adi,flt-q - can be 1, 2, 4, 8 (if not present, default value)
> 	- adi,timeout-enable - boolean property

Don't repeat what the code does. Explain why you are adding it, what is
the purpose.

> 
> These modify the corresponding bits in the configuration register.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>  .../bindings/hwmon/adi,max31827.yaml          | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> index 2dc8b07b4d3b..6bde71bdb8dd 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> @@ -32,6 +32,37 @@ properties:
>        Must have values in the interval (1.6V; 3.6V) in order for the device to
>        function correctly.
>  
> +  adi,comp-int:
> +    description:
> +      If present interrupt mode is used. If not present comparator mode is used
> +      (default).

Why this is a property of hardware?

> +    type: boolean
> +
> +  adi,alrm-pol:
> +    description:
> +      Sets the alarms active state.
> +            - 0 = active low
> +            - 1 = active high
> +      For max31827 and max31828 the default alarm polarity is low. For max31829
> +      it is high.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +
> +  adi,flt-q:
> +    description:
> +      Select how many consecutive temperature faults must occur before
> +      overtemperature or undertemperature faults are indicated in the
> +      corresponding status bits.
> +      For max31827 default fault queue is 1. For max31828 and max31829 it is 4.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 4, 8]
> +
> +  adi,timeout-enable:
> +    description:
> +      Enables timeout. Bus timeout resets the I2C-compatible interface when SCL
> +      is low for more than 30ms (nominal).

Why this is a property of hardware?


Best regards,
Krzysztof

