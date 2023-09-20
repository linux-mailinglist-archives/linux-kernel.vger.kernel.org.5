Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC1C7A8044
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 14:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbjITMfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235924AbjITMeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 08:34:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C8B92
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:34:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-986d8332f50so939887466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695213276; x=1695818076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CcKt0aKuzO6PEDvEIej9OBMWn8uC5jf8/QtokW/b9d4=;
        b=vfhGsMdXakUGxuC6oR7wRjFlQCBcFp1s+mB7sUvAcQa4+xtqWaJ8PtG4mtwKmZ6psZ
         jcIS0Qhs5M0qEUEIRfcvLOE2877aE9u8ul3EwqSElE+9hwnopCrqVdsGXJtEJBoP5ThP
         evkJVp4hByZ137/9rTfP7zbyRIFqV8gyVwlGvtyXVWSscrrxLElumpGVmfK0UTvXNEuw
         QPqsaV3GvjPk+A46BgYVyiHHEPmBCNLF+pgVAoA1YE44ZQBlHYwovXYL0P18ZDKB05S/
         3WCfM+Zah5wqZ2x+4nQYmEeCyPa3MR/S8jKjL0PlULtkFSu7Y58MccOTx7yysuyiI7Kk
         q88A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695213276; x=1695818076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcKt0aKuzO6PEDvEIej9OBMWn8uC5jf8/QtokW/b9d4=;
        b=nsgQGZagolSXFZ4ckjUSIOdZ+zkktYwSZwM8AeOyOmHgDP5wMRxBD89VONdFof0yYB
         3jqSIDhmRhB8Hbus7Ui0Z+/YK/xSkcRzoF7ynMr973LFHLigekiUlCXawjRVH7WwVa40
         UnnwXK8J+BL/Onom93M0awVqVhPgZnet/yFqk+Q7m98eZmKotX6+01rm4Wm/0atqH3IC
         x5Nf9hDwziYUhtLj3TZXtZIb1Ui/3jc9298QazBpWwP3hKiIEnPX2ejNUe9fQeU4fiRm
         /j/JqeM+4fnpsTfVwJmddcGB4AkFW6aBfLAzeRJi1sMdSaxpZcKBo3Yn2pQ16ex0IHDl
         vD5A==
X-Gm-Message-State: AOJu0YwH2JHIsepwS15n6KLm9ItoU7e7wuVTswqZ8XRU1z1xn6hG7/ZG
        QuTYKqfg0FvwT4FIoKGU37ipSw==
X-Google-Smtp-Source: AGHT+IF+C0tu/LMzg7FJEiDDItq7m86WiFfb0jw8K0fAigJwSNSCXcjwdv5jloc9gLXWX3O8GQFK7A==
X-Received: by 2002:a17:906:3091:b0:99c:c50f:7fb4 with SMTP id 17-20020a170906309100b0099cc50f7fb4mr1929062ejv.1.1695213276007;
        Wed, 20 Sep 2023 05:34:36 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id x6-20020a170906710600b00992e14af9c3sm9373040ejj.143.2023.09.20.05.34.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 05:34:35 -0700 (PDT)
Message-ID: <8e8c479e-3f72-ebcf-dbcc-162b193c2e24@linaro.org>
Date:   Wed, 20 Sep 2023 14:34:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/5] dt-bindings: serial: document esp32-uart
Content-Language: en-US
To:     Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
References: <20230920022644.2712651-1-jcmvbkbc@gmail.com>
 <20230920022644.2712651-3-jcmvbkbc@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230920022644.2712651-3-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2023 04:26, Max Filippov wrote:
> Add documentation for the ESP32xx UART controllers.
> 
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> 

Thanks for the changes.

> +properties:
> +  compatible:
> +    enum:
> +      - esp,esp32-uart
> +      - esp,esp32s3-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks

You need allOf with $ref to serial.yaml# (local serial, not absolute
path). I apologize, I missed this in my previous review.

Best regards,
Krzysztof

