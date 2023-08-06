Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70187715F2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjHFPkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbjHFPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 11:40:47 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF301988
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 08:40:42 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9bb097c1bso56837701fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 08:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691336440; x=1691941240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NvrJhNF2ptJeK82ja3ZQd6T/ZNrSYQqFaROioQHlrZ8=;
        b=Rbxl662yzahhaRZ96Ibb8CJ0bsgb9ziq7x+yyodzm3YsjHT+UWsDw5bVUfcruk7bRt
         OiabEfA8365KOlfoMfaQ/UYBBDTqoUNAt5nWYTCJSki8MxLdCDduizpBY2KQrEuGOq6A
         3p3qX3EsHOQ0BYxnQVzJ/oYuJzrCPM/KnW9ioxprAftXRO4QOIXkm4ku5y2ihKtLcjfk
         cSqzu+yZZFyZ9mkeiLFPrm+q6HNOdBcvzkNvu3vKIXjT6jk3ioMBrQIGwyKnthBU/+YR
         2qrXEg3ep43xHxnSombwVI+WVlXradB2g8Tcxxf+u0w0obTyB/3zD+wTVAho1mXz7qTT
         CjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691336440; x=1691941240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NvrJhNF2ptJeK82ja3ZQd6T/ZNrSYQqFaROioQHlrZ8=;
        b=S9T9ey9MWqq7VhPR7nbPKjEPkmJsLLOStM02i+iSNYZ3SDok32wnJt9e5zWYxDr//D
         uCQ5k6MAoSE4S5oJOSfUCtJQYkEI0quFZyvO3VALXn81SGCG/sJZlbCw+ZJpy1YFQQyl
         VuDtx4m7qMCqCFraqvteGbtJ1wWWziRmHDnpGzYxeXg/Tb3XzLPlP8K55e18d7geVRvD
         aIXwbgOtRZ0dG+64PQrDFPXkhdz4JkwmeveN32LKzn6dT5TNYBtCt+d7aypU1DUrBH8c
         CGQDHcyzA8r24MnnE5q8LB3umy4Sql+OZ9IDocB2QBRrQk1ADuELeEeH97k5EwcgjwR9
         gpHw==
X-Gm-Message-State: AOJu0YyJ24t6jNDQKUHmW+lJ7KVRncN/vtW9fnRrty20Y58RoFgLSKm/
        aKG36NCPygm9kyWDE5rkPKNeTmYHeKFTN6c8x9U=
X-Google-Smtp-Source: AGHT+IFNMyVbRJe9rPBqBTNx9wcpb/IUXe6XB58mQ1XqTq+4gtOHNPHNj6XJybnL/Vzg7a1MmWl+eg==
X-Received: by 2002:a2e:95cc:0:b0:2b6:dc55:c3c7 with SMTP id y12-20020a2e95cc000000b002b6dc55c3c7mr5108273ljh.20.1691336440481;
        Sun, 06 Aug 2023 08:40:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c00d400b003fbb346279dsm7990880wmm.38.2023.08.06.08.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Aug 2023 08:40:39 -0700 (PDT)
Message-ID: <f920abc5-d627-fee5-4973-d57b099f7fc9@linaro.org>
Date:   Sun, 6 Aug 2023 17:40:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 3/8] dt-bindings: clock: Add Marvell PXA1908 clock
 bindings
To:     =?UTF-8?Q?Duje_Mihanovi=c4=87?= <duje.mihanovic@skole.hr>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afaerber@suse.de
References: <20230804-pxa1908-lkml-v3-0-8e48fca37099@skole.hr>
 <20230804-pxa1908-lkml-v3-3-8e48fca37099@skole.hr>
 <609d5c1d-4ef7-22d5-d951-f32dbe410906@linaro.org>
 <12276137.O9o76ZdvQC@radijator>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <12276137.O9o76ZdvQC@radijator>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2023 12:12, Duje Mihanović wrote:
> On Saturday, August 5, 2023 10:52:22 PM CEST Krzysztof Kozlowski wrote:
>> On 04/08/2023 15:32, Duje Mihanović wrote:
>>> Add dt bindings and documentation for the Marvell PXA1908 clock
>>> controller.
>>>
>>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
>>
>> Any particular reason to use different BSD-3 than bindings? Not easy to
>> spot this difference...
> 
> Not really, I can change it to BSD-2 if needed.

Yes, please, keep the same license as other part of bindings.

Best regards,
Krzysztof

