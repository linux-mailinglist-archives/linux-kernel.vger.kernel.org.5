Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BD27DFE73
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 04:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjKCDkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 23:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjKCDkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 23:40:01 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCBDCE;
        Thu,  2 Nov 2023 20:39:58 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7ba170ac211so574876241.2;
        Thu, 02 Nov 2023 20:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698982798; x=1699587598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s39c0Q3vRJAr69pPcp1Cq/oOjffOhAjmF4C5gTe6n2g=;
        b=PD2JE9+YooOHpn0uTdMpwB3GqDJSgFERacV8171sp1ju7VsCAKrJh6Qyx5VMCSbce5
         tbNPESO2MWrx5XyKssExUko8PH3ROG/rnpp2cIqJSQTXwRzqLIZqZaywB8yofxWClgNf
         d7+h490/4tChddJ+wZPZ9pzpPfJ9hsjze+zYHbmP40o89MOCYpiKN6ZDny9YFdcihsYh
         85u0ablyRf2QkBA6cuc+EePwR/rY37hhBMeh8Ib0xwMsBZyEACF+Mvl1g6jFr6OaJ+xh
         oBY2ZtGUGIhsgre+sPd+uw2cEmKt1AIxNGgnJWqpFFckSOjPrF0CDt2PCMuzyPKMk4O8
         hNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698982798; x=1699587598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s39c0Q3vRJAr69pPcp1Cq/oOjffOhAjmF4C5gTe6n2g=;
        b=BBL4aqQRrQqGUOeMX6+SCFAd/oR+khjkATEyjGe0QUe7JKv47RWqv1A3xCc+QI/qPF
         FM1+YCq4X+DRdvrhy+7kcBOXzz/DmHYQ9bGc8j3DtfDLkteIwkgy8hlKlu+0epe4FSJb
         M1khsHM98MWi670c+GLJ/f5WuKWeo1devmt37CHCCflPU6jorTSILovp2zdf1dsFlUOK
         1FBd95el2tWr3mtYzsaomqPB1dEY0SnEg0/uVLtj2wDhXkyeqMzrr2dAtJ6f91dCGDWJ
         uBm9tbMDh7OBnMsbrGUPsGp17d0fle2cozeRil45eniQhzxHH+my22ook+FD6cLUZhq1
         k1Hw==
X-Gm-Message-State: AOJu0YwvI1UazfuV2fnD1zIFYuwSyNqt3b124oZ2aniI248LEWSR9e0S
        CsQPtugrz5uXNbCJikOshN9/B+jUz0w=
X-Google-Smtp-Source: AGHT+IEuKRhsbk3ee0U6AUU7P+u20ZODJN0lghzIwHvZfpJsz+Vf7wtmxDdGnCGB3WevwnexC4ZQAA==
X-Received: by 2002:a67:c399:0:b0:452:c581:5a07 with SMTP id s25-20020a67c399000000b00452c5815a07mr20410738vsj.11.1698982797741;
        Thu, 02 Nov 2023 20:39:57 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id m24-20020aa78a18000000b0068fcb70ccafsm437860pfa.129.2023.11.02.20.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 20:39:57 -0700 (PDT)
Message-ID: <999020b2-692b-4582-8ca0-e19c7b45ee92@gmail.com>
Date:   Thu, 2 Nov 2023 20:39:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: broadcom: Wire suspend/resume for BCM54612E
Content-Language: en-US
To:     Marco von Rosenberg <marcovr@selfnet.de>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231030225446.17422-1-marcovr@selfnet.de>
 <5414570.Sb9uPGUboI@5cd116mnfx>
 <fe3ad92f-31d9-4509-b851-017218229e19@lunn.ch>
 <4890615.31r3eYUQgx@5cd116mnfx>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <4890615.31r3eYUQgx@5cd116mnfx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/2023 6:47 PM, Marco von Rosenberg wrote:
> On Wednesday, November 1, 2023 11:06:56 PM CET Andrew Lunn wrote:
>> On Wed, Nov 01, 2023 at 10:42:52PM +0100, Marco von Rosenberg wrote:
>>> On Tuesday, October 31, 2023 1:31:11 AM CET Andrew Lunn wrote:
>>>> Are we talking about a device which as been suspended? The PHY has
>>>> been left running because there is no suspend callback? Something then
>>>> triggers a resume. The bootloader then suspends the active PHY? Linux
>>>> then boots, detects its a resume, so does not touch the hardware
>>>> because there is no resume callback? The suspended PHY is then
>>>> useless.
>>>
>>> Hi Andrew,
>>>
>>> thanks for your feedback. I guess a bit of context is missing here. The
>>> issue has nothing to do with an ordinary suspension of the OS. The main
>>> point is that on initial power-up, the bootloader suspends the PHY before
>>> booting Linux. With a resume callback defined, Linux would call it on
>>> boot and make the PHY usable.
>>
>> Ah, so you rely on phy_attach_direct() calling phy_resume(phydev).
>>
>> This seems an odd way to solve the problem. It was not Linux which
>> suspend the PHY, so using resume is asymmetric.
>>
>> I think soft_reset() or config_init() should be taking the PHY out of
>> suspend.

We have an unconditional call to __phy_resume() in phy_start() and we 
should always have a call to phy_start() regardless of the path though 
you have a point Andrew that we should ensure that by the time 
phy_init_hw() is called we have taken the device out of IDDQ-SR.

> 
> I agree with all of your points. This is just one way which happens to solve
> this specific problem. Of course it might be asymmetric to see the patch as
> a solution to my problem. However is there anything fundamentally wrong with
> adding suspend/resume callbacks? I see some other drivers having these
> callbacks defined and some not (it seems a bit inconsistent throughout the
> drivers in broadcom.c to be honest).
> 
> I'm wondering if I should just omit this whole "motivation" paragraph in the
> commit message and just use the commit message of commit 38b6a9073007 ("net:
> phy: broadcom: Wire suspend/resume for BCM50610 and BCM50610M") as a template.
> I mean, regardless of my motivation, I would say it makes sense for this PHY
> to support suspend and resume.

I would remove the motivation aspect from the paragraph and we could 
also improve the driver a bit to ensure that IDDQ-SR is disabled upon 
config_init(). Other than that your patch is just fine with me. Can you 
re-submit in a few days when net-next opens again?

Thanks!
-- 
Florian
