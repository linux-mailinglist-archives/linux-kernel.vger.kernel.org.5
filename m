Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055FC8082E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjLGIXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjLGIXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:23:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78436D7E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:23:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40c07ed92fdso7277235e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701937426; x=1702542226; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9IIO9873MnUjYDWrO8IkuU/36xiBULfRgmqcuNEoo3A=;
        b=pIG5gtRATiGR67smv0SIn4Zdl+mcp18aB5feBN05mSmjQTHySqxU/EfMLTcLJUTIZf
         J8cG08fHI2hXZlIFtATY19IN7VVruVC3okaPv3wGx9Hc3K+RNfQ17NfFEbPB+5sl07Cv
         FrvPziBupkczMG58VHPEdsfsiAJHqEZSscm6/7iinQZ7MoUOpfNms0ob+uWsn1an3U+A
         9OOYgb/sYeQEePpyyJodo0oEkF3NvSnA0X5MbSC9BnIZtYHa/BIHoQQDyqk4SXghLuRZ
         VaW7PaGxr0geT75/gb1mBlEV/DaGch8uDJnQtLF/oebaYYuPpSvCWd/qii0hnWoxbarT
         TKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937426; x=1702542226;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9IIO9873MnUjYDWrO8IkuU/36xiBULfRgmqcuNEoo3A=;
        b=bLQEtXrx9s9750K60T5ZVqlXG0VgHiBwG71RDFSUs3UxLRB0OdInOCnWrfwT92UbgE
         JHBDW7i4HMuLEglJsLxppf+K5YdIp4Xl1H4oF6b8ku2A0ccQWjmOS4e21BpVcauHt/9G
         uwRPNHj27tpW1WijaKRh8W7vGhkh/pKVkdiVDCSOfdgMSWYeAPajWdEVCP5DWVwpDwax
         O/b2cCMjTJz92oHn15CeyFwRfIYSfY5ynAxhRI6lpAFGFsUhTaAVqWjj+Z4MEDCEb2eK
         fDVNxVhmUf7T2+F9Zn5efJJeGks1XIBega4rrKi6NUva5sHFqqnYL+QczIb7CiOk7A37
         N/xg==
X-Gm-Message-State: AOJu0YwpVKzqDcMQmnCU6B6IPrTVWTDL4w/tZEhePBXnEVhIbOFIesDq
        f2XkFZR3dA6PbS3DBIf7XGU9Tw==
X-Google-Smtp-Source: AGHT+IEZZ77Si2Rch/NVJLpDVaVcnc6cmbJQHa/B0LHFoA9fzugp+5LEnSr+7KRoILy25YSvgzmbaQ==
X-Received: by 2002:a05:600c:154e:b0:40b:380e:2c9e with SMTP id f14-20020a05600c154e00b0040b380e2c9emr1249711wmg.34.1701937425217;
        Thu, 07 Dec 2023 00:23:45 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b004083729fc14sm1144817wmq.20.2023.12.07.00.23.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 00:23:44 -0800 (PST)
Message-ID: <0c1211e5-95a0-4caf-bc59-4a453fcf011a@linaro.org>
Date:   Thu, 7 Dec 2023 09:23:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: interrupt-controller:
 loongson,liointc: Fix dtbs_check warning for reg-names
Content-Language: en-US
To:     Binbin Zhou <zhoubinbin@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>, devicetree@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, lvjianmin@loongson.cn,
        WANG Xuerui <git@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <cover.1701933946.git.zhoubinbin@loongson.cn>
 <fde4d43ab25ad2a936c1b50ab7ed292345fcd32c.1701933946.git.zhoubinbin@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <fde4d43ab25ad2a936c1b50ab7ed292345fcd32c.1701933946.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 08:29, Binbin Zhou wrote:
> As we know, the Loongson-2K0500 is a single-core CPU, and the
> core1-related register (isr1) does not exist. So "reg" and "reg-names"
> should be set to "minItems 2"(main nad isr0).
> 
> This fixes dtbs_check warning:
> 
> DTC_CHK arch/loongarch/boot/dts/loongson-2k0500-ref.dtb
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11400: reg-names: ['main', 'isr0'] is too short
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11400: Unevaluated properties are not allowed ('reg-names' was unexpected)
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11400: reg: [[0, 534844416, 0, 64], [0, 534843456, 0, 8]] is too short
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> arch/loongarch/boot/dts/loongson-2k0500-ref.dtb: interrupt-controller@1fe11440: reg-names: ['main', 'isr0'] is too short
>         From schema: Documentation/devicetree/bindings/interrupt-controller/loongson,liointc.yaml
> 
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> Acked-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> Reviewed-by: Rob Herring <robh@kernel.org>

Where? Point me to exact email on lore.

Didn't we already talk some time ago about fake reviews?

Best regards,
Krzysztof

