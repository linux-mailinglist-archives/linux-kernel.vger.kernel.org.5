Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8807E825B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346153AbjKJTRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346090AbjKJTQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:16:50 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980614590B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:40:43 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b2b1af09c5so1233170b6e.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1699638043; x=1700242843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HrebI6zohBxl5u8DkEUaInQTNbtoP68hU5Hdc32f034=;
        b=cUeE4VNgINvzZGex3c1lNGKl3o7xVjwbYrcXXgjfbtAPUlhTW9ALylPNi2wo/OKBEr
         Je8azzsxhA7r4Gs+nYm4EJfsPoM1QJzMuI7I18WodaR43yNhdfCzWdS+a9Z4BQ4c+oHq
         Muw34c0ZFKKUeDkdzcpNReEkMix4rZ15y+8EyYhuiss5p69s+VmUVm0TjOrzko9IiyPE
         tgK3Xu9wGPjGjM+8sg+88YwZpPxb1W4XXA9UDUyF9ylLJo5iSl0AYoTyuoakoaG7KYJh
         Gz6Lc6K2HXWh8K9BXKVwGWmpjf1Lqt9uT7LRAjhauex+1/iA0LKzYK3i+AxVXFfZ35Ec
         4GBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699638043; x=1700242843;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HrebI6zohBxl5u8DkEUaInQTNbtoP68hU5Hdc32f034=;
        b=gl3YphFAQ46aN776dZ47+l13HeSEeRxUKNwHW6uB+EMxtXvVOD2tlB46KGBNy+ht8W
         v8KFjoidRaXYZGB8zACB1k6rj4gouuGKr4pCutY6r9FrctcBg8+NLxgcH4I8PkKP0leH
         cDzflCkJ34BOjJxsaJy0YFc+jDTDmlEbpwg/b3oV9iVXiuzfIO/J0j63B4/XD9eUymtp
         xFO5f6S5sqVqTR15Ht4j0LkwIv4Cim7t2mYg38pxWT+MHy+DMPEi6FtngP1ggC5YyBPd
         SL/xPXFJmdS/B465IpqRdOqNx9M808VNPuNsrrN8vNLQI4bQK9Uc3unGsr9sm4pms335
         Oogw==
X-Gm-Message-State: AOJu0Ywj6IPLZ91DLAd5wy8dGV1EoFd3NHcy3X3/HxqDeW19kEzSi81f
        /uHdDloDnQkJZPMi9gIk1CO5EQ==
X-Google-Smtp-Source: AGHT+IGNxgT+7VupBwkRr5oBAnlu+Zh6h+oQMEsGdkGOqCFbsuH/3JoVKmwlTt0Ssgz7Vrft8Iobxg==
X-Received: by 2002:a05:6808:64f:b0:3b2:e2d5:bcec with SMTP id z15-20020a056808064f00b003b2e2d5bcecmr5156961oih.47.1699638042906;
        Fri, 10 Nov 2023 09:40:42 -0800 (PST)
Received: from [10.46.15.71] ([156.39.10.100])
        by smtp.gmail.com with ESMTPSA id c10-20020a655a8a000000b005b6c1972c99sm6015061pgt.7.2023.11.10.09.40.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 09:40:42 -0800 (PST)
Message-ID: <a37be8f7-64a4-4cec-8692-28ad92a02b00@sifive.com>
Date:   Fri, 10 Nov 2023 09:40:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] clocksource: Add JH7110 timer driver
Content-Language: en-US
To:     Xingyu Wu <xingyu.wu@starfivetech.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Walker Chen <walker.chen@starfivetech.com>,
        Samin Guo <samin.guo@starfivetech.com>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor@kernel.org>
References: <20231019053501.46899-1-xingyu.wu@starfivetech.com>
 <20231019053501.46899-3-xingyu.wu@starfivetech.com>
 <3f76f965-7c7b-109e-2ee0-3033e332e84b@linaro.org>
 <bb819333-52d3-49fc-9bb9-1a227bd5ca8f@starfivetech.com>
 <d0e70434-e273-4799-c5ec-bbee1b3f5cc7@linaro.org>
 <540136d4-6f8f-49a6-80ff-cc621f2f462b@starfivetech.com>
 <65c38717-3e0c-46d3-a124-29cae48f1a2e@linaro.org>
 <72ad5029-42b2-481a-887f-8f6079d8859b@starfivetech.com>
 <a8f0011c-5689-4071-b5e0-90bd6b7c66bc@linaro.org>
 <b402eb4d-a770-4988-8274-8a2544362229@starfivetech.com>
 <1dd3d765-c583-4db9-a0aa-303bfcf871db@linaro.org>
 <7c2e9b70-201c-45f8-9871-a823cc2ded16@starfivetech.com>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <7c2e9b70-201c-45f8-9871-a823cc2ded16@starfivetech.com>
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

On 2023-11-08 11:51 PM, Xingyu Wu wrote:
> On 2023/11/8 17:10, Daniel Lezcano wrote:
>> On 08/11/2023 04:45, Xingyu Wu wrote:
>>> On 2023/11/2 22:29, Daniel Lezcano wrote:
>> 
>> [ ... ]
>> 
>>> Thanks. The riscv-timer has a clocksource with a higher rating but a 
>>> clockevent with lower rating[1] than jh7110-timer. I tested the 
>>> jh7110-timer as clockevent and flagged as one shot, which could do some
>>> of the works instead of riscv-timer. And the current_clockevent changed
>>> to jh7110-timer.
>>> 
>>> Because the jh7110-timer works as clocksource with lower rating and only
>>> will be used as global timer at CPU idle time. Is it necessary to be
>>> registered as clocksource? If not, should it just be registered as
>>> clockevent?
>> 
>> Yes, you can register the clockevent without the clocksource.
>> 
>> You mentioned the JH7110 has a better rating than the CPU architected
>> timers. The rating is there to "choose" the best timer, so it is up to the
>> author of the driver check against which timers it compares on the
>> platform.
>> 
>> Usually, CPU timers are the best.
>> 
>> It is surprising the timer-riscv has a so low rating. You may double check
>> if jh7110 is really better. If it is the case, then implementing a
>> clockevent per cpu would make more sense, otherwise one clockevent as a
>> global timer is enough.

The timer-riscv clockevent has a low rating because it requires a call to
firmware to set the timer, as well as a trap to firmware to handle the
interrupt, which both add overhead. Implementations which support the Sstc
extension[1] do not require firmware assistance to implement the clockevent, so
in that case we register the clockevent with a higher rating.

[1]: https://github.com/riscv/riscv-time-compare

>> Unused clocksource, clockevents should be stopped in case the firmware let
>> them in a undetermined state.
> 
> The interrupts of jh7110-timer each channel are global interrupts like
> SPI(Shared Peripheral Interrupt) not PPI (Private Peripheral Interrupt). They
> are up to PLIC to select which core to respond to. So it is hard to implement
> a clockevent per cpu core. I tested this with request_percpu_irq() and it
> failed.

You cannot use request_percpu_irq(), but the driver should be able to set the
affinity of each IRQ to a separate CPU.

Regards,
Samuel

> I think it is enough to implement a clockevent as a global timer. Thank you
> for your advice.
> 
> Best regards, Xingyu Wu
