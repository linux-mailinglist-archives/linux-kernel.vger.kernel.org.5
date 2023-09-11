Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8C179AD54
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbjIKWVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238103AbjIKNig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:38:36 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF05CC3;
        Mon, 11 Sep 2023 06:38:31 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6c07e122a78so3188369a34.2;
        Mon, 11 Sep 2023 06:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694439510; x=1695044310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=kNts3nBCiBbgFg05HO7ID3JWxHyrpiDmYPSohjswiR0=;
        b=SHzaBJ+H+R1Sf9Ehly4Qa9d5TTYwn0R3hQMGOgz+C/s0JRx1hzJZElngRg2mBdKjN+
         HBSs2PYW9VSrR+v/BJBgWiIuhJ482iXQanLzoiz2KQK1c5N6LjZ2jcV8nh1jaUaNYJs0
         QFobeOaacdZdMYq0izdZ6Q2IPiswmIiOH0peATo4PCyMgxQqp6xGG/JjBOdemv3p6Gfy
         euQ88Hll9Iy4shnxFarjuT7bJ8ZlslFBf5VsOXcO3untnnRbDQNgyGlzOqnqgS87tdn3
         nW4m5r78uRwS9TGe+5ieHsG1EIvL26XI2jzGw2PqFtDivhaAyTgHF4fO7kx90J0+Fe0e
         yVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694439510; x=1695044310;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kNts3nBCiBbgFg05HO7ID3JWxHyrpiDmYPSohjswiR0=;
        b=Pjj3E/n5j4yBN3jp7a/BJuG9iJTVNRp2ALAebi6b5nAIipDhkfTsJ+6PNibcsa4zp8
         ieboNf+PTb1MdzmX7Nui4J0dfi3eQFuWM7gkr249jcoHyHC+AjO/yy/Ato3n+qhrrKr/
         KJVkmYMKzKdsXGZdaBaeXCg+heIYbxxPhmJE2pMSQQatFWbEAXY2DtBsc+6nqurUfbo0
         Xn9a6+9mDzrmT3U9XtYXFjb1xmAzMigdkdJGEyJwayRHqfKFefhlaUFyPliDgF1mzr9G
         IIfmE2u+TB2gJ5Kcb0zamGPRZe6efO9ZKizkyD2IfKnTqJ+DaU2regzBEnNv0+AUtWMK
         AtIw==
X-Gm-Message-State: AOJu0Yyl+1AjsNhojEgis77r63cQ2YYEz3+2VqxFUqjenKjL0o+Vx/Ry
        8VQWKmpVhXmXI2AJ6Bxvncc=
X-Google-Smtp-Source: AGHT+IH06fgh3eCFYb7Hs326KKpRnBBuqO3sQ8dOBSCi4IqLaceAR/Zmj8GWxsH6vhh/T1tOTzu4Pg==
X-Received: by 2002:a9d:65d7:0:b0:6bf:3f4:3edc with SMTP id z23-20020a9d65d7000000b006bf03f43edcmr10362123oth.22.1694439510448;
        Mon, 11 Sep 2023 06:38:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z11-20020a6552cb000000b00570132a022csm4905208pgp.79.2023.09.11.06.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 06:38:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <55b4b084-5b92-9e0d-9fa8-28a4062fb249@roeck-us.net>
Date:   Mon, 11 Sep 2023 06:38:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Describe changes to the device
 tree
Content-Language: en-US
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20230911083735.11795-1-daniel.matyas@analog.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230911083735.11795-1-daniel.matyas@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/23 01:37, Daniel Matyas wrote:
> Added new attributes to the device tree:
> 	- adi,comp-int
> 	- adi,alrm-pol
> 	- adi,flt-q
> 
> These modify the corresponding bits in the configuration register.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>   .../bindings/hwmon/adi,max31827.yaml          | 21 +++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> index 2dc8b07b4d3b..b10878c4a05d 100644
> --- a/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml
> @@ -32,10 +32,28 @@ properties:
>         Must have values in the interval (1.6V; 3.6V) in order for the device to
>         function correctly.
>   
> +  adi,comp-int:
> +    description:
> +      A boolean property. If present interrupt mode is used. If not present
> +      comparator mode is used (default).
> +
> +  adi,alrm-pol:
> +    description:
> +      A boolean propert. If present, alarm is active on high. If not present,

property

> +      alarm is active on low.

Is this the chip default ? That might be worth mentioning.

> +
> +  adi,flt-q:
> +    description:
> +      Select how many consecutive temperature faults must occur before
> +      overtemperature or undertemperature faults are indicated in the
> +      corresponding status bits.
> +            - can be 1, 2, 4 or 8
> +
>   required:
>     - compatible
>     - reg
>     - vref-supply
> +  - adi,flt-q

I do not see a need to make this mandatory. Default can and should be the chip
default.

>   
>   additionalProperties: false
>   
> @@ -49,6 +67,9 @@ examples:
>               compatible = "adi,max31827";
>               reg = <0x42>;
>               vref-supply = <&reg_vdd>;
> +            adi,comp-int;
> +            adi,alrm-pol;
> +            adi,flt-q = <1>;
>           };
>       };
>   ...

