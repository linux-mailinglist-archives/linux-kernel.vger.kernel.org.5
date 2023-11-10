Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98ABF7E81EB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbjKJSo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjKJSom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:44:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE34E348D1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:02:53 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4084de32db5so18152275e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 10:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699639361; x=1700244161; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QNLq0qmMJNvfKP5O63+BxM6jCmlb62b2gPfwV2vURLs=;
        b=stdUCWcL95tnIk/HH5/Xz8KJw1PM99Uyu1MTljwsEPdQu/7X5ccyPOG8JOahQNTWNC
         ECJmLyyVgKF7uVDE1FrTL/v8M49a3hzLPqZT/yWTnlB6Ac0CxBhGw6Pu1gxlLHKpXJAi
         KgTTBNKnM+dorGx1k+vs0G6QCd3aDITWEMgpP7JytHM6jlAsX3CDfaFvTXlAupuOMNAa
         upqSUDxlVCP5Na7WL/5JIiLGtou6jSa8HIGY2cyEx+Ghrp3ieKvQ2HsKJWdx42sbJr+w
         mzZQ3x80lQjbe0byI7ZHAQXY++T1AX3JNVHb5RTsUSEA/8dOxEGCNVrv9Uqf9B/0n/uw
         RkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699639361; x=1700244161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QNLq0qmMJNvfKP5O63+BxM6jCmlb62b2gPfwV2vURLs=;
        b=E7JSf0Q3V3MbIF7mh5xlVBBHAE4PRfCjSeMxajPLsfu/BLQ7j1qONwWhLjPiY34HVd
         5T8Czxlnsbqd/XklKA/F6+A1nvwSyFsh1+JMOeCB4DF/f3+1RGBNA2Tw8RAFE/2wp8zi
         YfFGPxNovcpn6b4z8OcQYUC0smgBpBtbNkDz1zWKwHqv/yhlxypJHg4UxVKA3rcNYVN8
         qrw1ae5qI3yU2cKZqtuV51DExLiq4iejY3Pm5RhulGPfUpDRvGv11VYApqgzBcFdajIx
         RUTFWYqBGptOKWt/SbhGHQ71lPct6Xuk2jPG+cBZFJ98tWhPD22BwXjJpGVOf8X+4H9e
         Gkng==
X-Gm-Message-State: AOJu0YzYPRIrE5tCx317wqTOpe09rmMLvZqpCnA5oaVUSo+IBymppwXN
        tFBUrpuH1a0wxYfvpxvA+oid3w==
X-Google-Smtp-Source: AGHT+IFkgENQd+VCrNMqWIay+eSx1NNSFAAtgRFGrcbVElc6SAlYS3F/4RutTpyTNZbw0mULeuI4uw==
X-Received: by 2002:a5d:4d46:0:b0:32f:89e5:ef60 with SMTP id a6-20020a5d4d46000000b0032f89e5ef60mr37775wru.11.1699639361285;
        Fri, 10 Nov 2023 10:02:41 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id y9-20020adfee09000000b0031f82743e25sm2350227wrn.67.2023.11.10.10.02.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 10:02:40 -0800 (PST)
Message-ID: <bbd2ee8d-4349-4752-859a-02fb0252d496@linaro.org>
Date:   Fri, 10 Nov 2023 19:02:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] clocksource: Add JH7110 timer driver
Content-Language: en-US
To:     Samuel Holland <samuel.holland@sifive.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>
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
 <a37be8f7-64a4-4cec-8692-28ad92a02b00@sifive.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <a37be8f7-64a4-4cec-8692-28ad92a02b00@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Samuel,

On 10/11/2023 18:40, Samuel Holland wrote:
> On 2023-11-08 11:51 PM, Xingyu Wu wrote:
>> On 2023/11/8 17:10, Daniel Lezcano wrote:
>>> On 08/11/2023 04:45, Xingyu Wu wrote:
>>>> On 2023/11/2 22:29, Daniel Lezcano wrote:
>>>
>>> [ ... ]
>>>
>>>> Thanks. The riscv-timer has a clocksource with a higher rating but a
>>>> clockevent with lower rating[1] than jh7110-timer. I tested the
>>>> jh7110-timer as clockevent and flagged as one shot, which could do some
>>>> of the works instead of riscv-timer. And the current_clockevent changed
>>>> to jh7110-timer.
>>>>
>>>> Because the jh7110-timer works as clocksource with lower rating and only
>>>> will be used as global timer at CPU idle time. Is it necessary to be
>>>> registered as clocksource? If not, should it just be registered as
>>>> clockevent?
>>>
>>> Yes, you can register the clockevent without the clocksource.
>>>
>>> You mentioned the JH7110 has a better rating than the CPU architected
>>> timers. The rating is there to "choose" the best timer, so it is up to the
>>> author of the driver check against which timers it compares on the
>>> platform.
>>>
>>> Usually, CPU timers are the best.
>>>
>>> It is surprising the timer-riscv has a so low rating. You may double check
>>> if jh7110 is really better. If it is the case, then implementing a
>>> clockevent per cpu would make more sense, otherwise one clockevent as a
>>> global timer is enough.
> 
> The timer-riscv clockevent has a low rating because it requires a call to
> firmware to set the timer, as well as a trap to firmware to handle the
> interrupt, which both add overhead. Implementations which support the Sstc
> extension[1] do not require firmware assistance to implement the clockevent, so
> in that case we register the clockevent with a higher rating.
> 
> [1]: https://github.com/riscv/riscv-time-compare

Thanks for the pointer and the clarification.

>>> Unused clocksource, clockevents should be stopped in case the firmware let
>>> them in a undetermined state.
>>
>> The interrupts of jh7110-timer each channel are global interrupts like
>> SPI(Shared Peripheral Interrupt) not PPI (Private Peripheral Interrupt). They
>> are up to PLIC to select which core to respond to. So it is hard to implement
>> a clockevent per cpu core. I tested this with request_percpu_irq() and it
>> failed.
> 
> You cannot use request_percpu_irq(), but the driver should be able to set the
> affinity of each IRQ to a separate CPU.

Absolutely. And given the bad rating of the local timers, it may be 
worth to implement this driver in a per CPU (affinity set) basis.

At the first glance, the arm_global_timer can be used as an example.

Note in this case, you may want to double check what does with an idle 
state with a local timer stop flag and this timer which is always on.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

