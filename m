Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBF57DAD5E
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjJ2RBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjJ2RA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:00:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B0CBE;
        Sun, 29 Oct 2023 10:00:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c87a85332bso32598505ad.2;
        Sun, 29 Oct 2023 10:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698598855; x=1699203655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=+GH3Ep1QSotLQp9G1VgYYbvlYhIk5BNHjZEa/6Fuf0I=;
        b=R3SVR8ga+9WN303P1EgNb8xLXnlnMabZfeIm/jG8mWDb/cc6hOy0PnaenN9g94AYak
         mqJgwKTYmZK0bOjy7qsUj/2aurk/R9bITxDPn8IiF2QLeXuBU1unuo2RLjXtrNTmjFKT
         +TL2O02W/PiEbaYY/8YmsMoTq/2UJ7x+Vvl1EUCZmIqYtzqArGcYj76nQ/LsZfxLV1tB
         QdAnFBJkH1B++LechmThrqjbHkwAi7NzkZ+yqMVy220/plQTNl1s/FxiKb5jQ6hoy/uB
         nxXdud5Pa+Jpky4H9BbBtowrM1yUAPzeVOxZRegGSuL5Dpj+hxsHRcnTptQg6jf94Ebe
         2gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698598855; x=1699203655;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GH3Ep1QSotLQp9G1VgYYbvlYhIk5BNHjZEa/6Fuf0I=;
        b=BVLE0pohj8HfMA1NyRMxVLex2GVfmiK2wwq7Gy4z4zG+v8t1LGY5XT9UFyiVgJuBzE
         b5w4BP9VbEETRW/zN2ZZmUL0XcFnmGaglLabcjDW548EoyeXk5hu/2IkjNxY9Kj8XQqj
         qWafcdWuBj5XT8wdPJOl9/NRk99+xgOTKuzzrN+3HYS6ej1tVPe5Izx6EVV6xkynER7N
         u2QNXk5He7nnszo7eTAvv3jHiFVeNWJMmDhCXnj+bnR/wxzsT8dkxAxG+fY65m3XKL0d
         NjXKQJ01DqyDMZHp4uYNvPJq/XPF3FaS5+hDS325wgZLi8iG8jlIgK4Ol+1G/ujcVPFr
         H0tQ==
X-Gm-Message-State: AOJu0YwTf9DltELccnUgKSN5r0Eyz4TKhcTe6OM4QZOFurX1Mny1bror
        KC/SaJFdZKi12tlC6KBxAVo8VjnkLtc=
X-Google-Smtp-Source: AGHT+IH1kqTg/Zqp8Q3QqBbfVl1QPLA3eFWS6aKDqHrsiFiqsnu6cKIrI7U5kT1kewj60UTFaAM9ow==
X-Received: by 2002:a17:902:e84b:b0:1cc:4559:f5 with SMTP id t11-20020a170902e84b00b001cc455900f5mr1628124plg.14.1698598855567;
        Sun, 29 Oct 2023 10:00:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ja18-20020a170902efd200b001bb892a7a67sm2989381plb.1.2023.10.29.10.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 10:00:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <750ec6f7-f075-4075-ba9d-eb67f69239ec@roeck-us.net>
Date:   Sun, 29 Oct 2023 10:00:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sbsa_gwdt: Calculate timeout with 64-bit math
Content-Language: en-US
To:     Wim Van Sebroeck <wim@linux-watchdog.org>
Cc:     Darren Hart <darren@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org,
        Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
References: <7d1713c5ffab19b0f3de796d82df19e8b1f340de.1695286124.git.darren@os.amperecomputing.com>
 <bcc41311-075c-44fe-b0f7-30564d7ac58c@roeck-us.net> <ZSpbfXzFeaoUJRZ3@Fedora>
 <1fae4d2c-4bc7-f169-7b84-501674a82ee4@roeck-us.net>
 <20231029161056.GB5887@www.linux-watchdog.org>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20231029161056.GB5887@www.linux-watchdog.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/23 09:10, Wim Van Sebroeck wrote:
> Hi Guenter,
> 
>> On 10/14/23 02:12, Darren Hart wrote:
>>> On Tue, Sep 26, 2023 at 05:45:13AM -0700, Guenter Roeck wrote:
>>>> On Thu, Sep 21, 2023 at 02:02:36AM -0700, Darren Hart wrote:
>>>>> Commit abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
>>>>> introduced new timer math for watchdog revision 1 with the 48 bit offset
>>>>> register.
>>>>>
>>>>> The gwdt->clk and timeout are u32, but the argument being calculated is
>>>>> u64. Without a cast, the compiler performs u32 operations, truncating
>>>>> intermediate steps, resulting in incorrect values.
>>>>>
>>>>> A watchdog revision 1 implementation with a gwdt->clk of 1GHz and a
>>>>> timeout of 600s writes 3647256576 to the one shot watchdog instead of
>>>>> 300000000000, resulting in the watchdog firing in 3.6s instead of 600s.
>>>>>
>>>>> Force u64 math by casting the first argument (gwdt->clk) as a u64. Make
>>>>> the order of operations explicit with parenthesis.
>>>>>
>>>>> Fixes: abd3ac7902fb ("watchdog: sbsa: Support architecture version 1")
>>>>> Reported-by: Vanshidhar Konda <vanshikonda@os.amperecomputing.com>
>>>>> Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
>>>>> Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
>>>>> Cc: Guenter Roeck <linux@roeck-us.net>
>>>>> Cc: linux-watchdog@vger.kernel.org
>>>>> Cc: linux-kernel@vger.kernel.org
>>>>> Cc: linux-arm-kernel@lists.infradead.org
>>>>> Cc: <stable@vger.kernel.org> # 5.14.x
>>>>
>>>> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>>>
>>> Guenter or Wim, I haven't seen this land in the RCs or in next yet. Have
>>> you already picked it up? Anything more needed from me?
>>>
>>> Thanks,
>>>
>>
>> Sorry, I am suffering from what I can only describe as a severe case of
>> maintainer/reviewer PTSD, and I have yet to find a way of dealing with that.
> 
> I can imagine what it is like. And I do know that if you wouldn't have been there,
> that I would have allready stopped being a maintainer. So I hope you can find the
> right cooping mechanisms. I also had to work non-stop the last 4 to 5 weeks and it was hell.
> So I wish you all the best.
> 
> PS: picking up all patches that have your review-by tag on it as we speack.
> 

Thanks,
Guenter

