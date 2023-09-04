Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E98F791262
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344698AbjIDHkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjIDHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:40:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70043ED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:40:10 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso1435285a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693813209; x=1694418009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ZiyfBk/r1bxVGsjBsSvDTn19yqQ/kz7BAwS13tREAw=;
        b=Z2yHlVjpxLYaw0lLLW/nHJ1mqyJdq8GHC1oMzYD74ED9Lw5OFwtFbqrykZEoLuEt6J
         m/vNk5ATxnu71uhv1RrkT/kla34CoxNrg9j4psK9bl6wUIeARDiknitXneAnPd8H5F+N
         jpzrp94TkYEPKzCp5mtfO99Xnkh/m0EqMBzGw1fboqdiHFfrjIR5/O+nHOM1ItxU/USC
         HLvOON3l8PNbWyG7UrU19NPEdyVuywtGEn38zZcMb0hMPqN2OqHzLrquvhng2e5ZZJP8
         ETOgM1NWdshbR4we5QGXMv149i6IWiaeWlLuBVwY1CVLttriPQ6sE7qLW5O81I5wjoMm
         zZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813209; x=1694418009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZiyfBk/r1bxVGsjBsSvDTn19yqQ/kz7BAwS13tREAw=;
        b=Gm5/TlTtsVNr08w37M+t4tvZTzq1QRTUSjvESlKwsHYmdgOb7U1pF8vQVCS8+7muOO
         /UtU6ejX4evXMZTPc8hu04MqqOPt5cH19FMgaDcQdwfzCT3P0diG4ldARBLvXhzxTSiP
         KAkfHvBJBQ5pnqo+hj9xbo7TgFhWBlmA9z6aPdwB2J/+ku4XJFQy2Wt9R9WUoiCdsYID
         YZ4UL+n1fRD9amSKMucy/dpDC1AbJ29yaU0OxB5Z19lm1zE95NxgX8ibtzXI4wR0UBpV
         zL80Dcr57oDD+0dGdjIyCgocjzMtvIVqciJWApIPcQjbCQ2OhA/7L5NzIv0oE2jllXVV
         B0KQ==
X-Gm-Message-State: AOJu0YyS83JjhSrJZeY7Q8oeeq2Qj0ObiH8u6z7ZjGwuYHPT7HaKf9M3
        vKJJfxAZndTdVYRTDEn6YH3zDA==
X-Google-Smtp-Source: AGHT+IFkCIVYkfoeeb2iN7vQlubSqIOvwsjm5rz39/rqvsnjtlkVv2BNSvos3LWAE3psdKUqzxodpw==
X-Received: by 2002:aa7:ccc2:0:b0:522:57d9:6553 with SMTP id y2-20020aa7ccc2000000b0052257d96553mr6725528edt.1.1693813208972;
        Mon, 04 Sep 2023 00:40:08 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id w16-20020a056402269000b0052e1959db1csm1419637edd.20.2023.09.04.00.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:40:08 -0700 (PDT)
Message-ID: <8bc40c78-9d5a-ea23-586a-5cf38845bfaf@linaro.org>
Date:   Mon, 4 Sep 2023 09:40:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: loongson,liointc:
 Fix warnings about liointc-2.0
Content-Language: en-US
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Binbin Zhou <zhoubb.aaron@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        loongson-kernel@lists.loongnix.cn, devicetree@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, diasyzhang@tencent.com,
        linux-kernel@vger.kernel.org
References: <20230821061315.3416836-1-zhoubinbin@loongson.cn>
 <e62185ca-cdf6-bde9-ad46-f4150db9ed6d@linaro.org>
 <CAMpQs4JhfuB4=s9VFc+xmw_+8h5u2EwPdM_0x2vO_=SYabAAxw@mail.gmail.com>
 <6ba31912-6738-6156-d5f4-3c8d3a3ca7bc@linaro.org>
 <CAMpQs4+GiExt9uMmV1pf8gg8rFwWxbLkx9mdW7hY9xxXDOza3Q@mail.gmail.com>
 <d11873a1-b552-71f5-1100-7464687f8bb4@linaro.org>
 <a084e6e9-46b0-42ef-b500-69c114ae11b2@flygoat.com>
 <3412e871-ae2b-bed0-88fb-2272f9db3af0@linaro.org>
 <a3e934eb-7517-f313-46d9-fd5335ce305e@flygoat.com>
 <CAMpQs4L0DYxoqQbpi7WeNMBf9g+58L2=D6BXrKbSUqJQEEKZLQ@mail.gmail.com>
 <3ed7bddd-2c86-90e0-a8bf-0b322bb92bd9@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3ed7bddd-2c86-90e0-a8bf-0b322bb92bd9@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/2023 08:32, Jianmin Lv wrote:
> Each IRQ source of liointc may be routed to different IRQ source of 
> cpuintc, for implementing this, bit mapping between liointc and cpuintc 
> is required, and the mapping information is used for liointc IRQ routing 
> register setting. It seems that interrupt-map can not pass the mapping 
> to driver in current driver/of code,  so the mapping is used in a 
> non-standard way(of cause, underscore style may be changed in dts and 
> driver).
> 
> IMO, hardcode routing completely in driver is not flexible and not 

"not recommended" by whom?

> recommended, and if possible, keep current map unchanged please.
> 

You could have proposed that time, when review was happening. The
property was added AFTER review, so the review was invalidated.

Drop the property and use interrupt-map. Eventually change it to
something acceptable which will PASS review, not bypass it.

Best regards,
Krzysztof

