Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE3977C0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjHNT1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjHNT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:27:02 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03C75BF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:27:01 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe24dd8898so43887635e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692041219; x=1692646019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0w/fgpvE9EH3ZN+GQBEOw8ULxNZwyV9K97iNGcWuOak=;
        b=DuLahNuZSHEiplKWjTLNFHlFwwFth24W0P5AeiDFiazHkVd6ic1UUyhbLr8HzsY9uC
         K+hgjQqpnIk0/P2AQqShygB2EMQ9N7m7BGpPudvCq7IxAQxRfKus8kIFykywQbWYthC1
         i7GEDnXTvwWy07m66rANoHptJlunDjLRA/56Hf/XaUwY1jm2pKisLPPx/xNBIWCLWj3B
         eUMvJwNu2cVDa6QVMSPoBBF6MR6l1WzMNi+VDcfo+OO2NlEEs/zx+140vZ+38zqomTQ1
         pW5GlcE+Zq9Lvk6a40CBC5coGEbMly8NyQccUyCkXnGf8gv1wbd6E3SR/L0TE0BMdfIK
         0oHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692041219; x=1692646019;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0w/fgpvE9EH3ZN+GQBEOw8ULxNZwyV9K97iNGcWuOak=;
        b=ho5fEfWS2sHvfNM1vza+Gyw8imb29bjA410bJC0nmZQLqFM1ohnVFWDIpLbZx62Xig
         Wz7MH8fbR1K2NbgB7m64meHYCkXc7gqJAR09eagV3iuMZSZkVhshf+sujwvYvJ25Po/R
         TA3fp3xejwIfeu1YTg1/RDHAnGTis4kz31vvMkbjEb3MSONV9AsEtpxSw5gqYF8HuQUn
         pje47qymEN9d4xtKkHhPNx2fuYYbV6oWQqA7PAEqXtg5C2LTHQengJap4sjIivDVBVmG
         zmc+VgW3tzrLfQd0jK6iLEfrms39SF1Pi667mMsdudLaoE3A45PpSvX6b3HDlU2wSmWP
         uKlw==
X-Gm-Message-State: AOJu0Yx+PYt0V2Le6BIdcrz1XZ5IpDdjlB5zSpUlzCROS3rb/0aFmX2Z
        s9i0RgWVMQQNGf0T4f+QWO3MSMEmFGUx5qQ1Uys=
X-Google-Smtp-Source: AGHT+IHSY/Vlhr2ysiFQyuSJox0KAP22MPDrdC4+JWNUWNi+WOKQed5gOJ8Oyyyk7a36OLUXfWgHrg==
X-Received: by 2002:a05:600c:249:b0:3fe:15e7:c8a1 with SMTP id 9-20020a05600c024900b003fe15e7c8a1mr7952429wmj.16.1692041219522;
        Mon, 14 Aug 2023 12:26:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c228800b003fbcf032c55sm18190389wmf.7.2023.08.14.12.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:26:59 -0700 (PDT)
Message-ID: <5a1ed797-d29a-e047-ccec-adb1dde6d74f@linaro.org>
Date:   Mon, 14 Aug 2023 21:26:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 0/3] arm64: dts: ti: Introduce AM62P5 SoC and board
Content-Language: en-US
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, afd@ti.com
References: <20230811184432.732215-1-vigneshr@ti.com>
 <169179403348.1346194.1236976094485793819.b4-ty@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <169179403348.1346194.1236976094485793819.b4-ty@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2023 00:49, Nishanth Menon wrote:
> Hi Vignesh Raghavendra,
> 
> On Sat, 12 Aug 2023 00:14:29 +0530, Vignesh Raghavendra wrote:
>> This series adds basic support for AM62P family of SoCs and specifically
>> AM62P5 variant. Also adds AM62P5-SK support with basic peripheral
>> like UART.
>>
>> TRM at [0] and Schematics is at [1]
>>
>> [0]: https://www.ti.com/lit/pdf/spruj83
>> [1]: https://www.ti.com/lit/zip/sprr487
>>
>> [...]
> 
> Note: since the changes were trivial, I incorporated the cosmetic
> fixup suggested by Andrew locally when I applied. I have also dropped
> bootph property from board's reserved nodes inline with what we did
> for j721s2[2]. Thanks for the bootlog.
> 
> I have applied the following to branch ti-k3-dts-next on [1].
> Thank you!
> 
> [1/3] dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
>       commit: b57fc5cbdbdfd04d44697800a9d59aeb3be2f273
> [2/3] arm64: dts: ti: Introduce AM62P5 family of SoCs
>       commit: 29075cc09f43a024d962da66d2e4f9eb577713d0
> [3/3] arm64: dts: ti: Add support for the AM62P5 Starter Kit
>       commit: 935c4047d42e53a06ec768ddc495a44f6869209c
> 

A bit too fast. simple-mfd *is not allowed* on its own.

Best regards,
Krzysztof

