Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E056765616
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233844AbjG0OkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233820AbjG0Oj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:39:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187422D56;
        Thu, 27 Jul 2023 07:39:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686bea20652so1060685b3a.1;
        Thu, 27 Jul 2023 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690468796; x=1691073596;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O+2/2vDz7rd9ZVuEcJrsjVGEHOfSkIQGZOOCHutGRqs=;
        b=YoEDf9bWZ0ShujP1H2jQXCkh+jxZcSQK0dCfkjInuAPmO2CYWINn23NMXWnyUXLXqA
         GfRRj7pxpcNhdsa3TGCwGPc1yN4Hk+Bk7mcjgt3VZWcrahSoK+BdUPDUnpLbbMEMm4Sw
         Tul6FI0dMBhttLKYjMGfWCKH8YGacBcOUx8H18piNwolyNOk0jMKio6CLuKxTsYY4hEQ
         Q1FvW0O/7udVuKuFdSAcYv2prytlcwSCNKAGu6VQaN2EdRJdIzPwADl3+cfqByK5Cf3A
         gcDhoMydPICQhJSEL5UqCO0oOlShJop18pheZ7yT1AMvf9pD69gyAVF5+5RvxuUzmu1D
         cgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690468796; x=1691073596;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+2/2vDz7rd9ZVuEcJrsjVGEHOfSkIQGZOOCHutGRqs=;
        b=ISw/G5TZ5AnqXOhorYCcWjvjGm4ZOTG0bu/z+Vq9khnFsBmloGbDIpgYRjax3ccgkk
         FS8/S1443iaocBW8c5qnQOslzfRI6Vt/Z7ePtZeK/erJUCDkJgIY371Z0fckviYbb3Qr
         fAZRuOllI5RAaoBcimd7p3Yp6pnSCtP9sI4FU9PwW2QoH1N5YZSoGB++DOLoX5742Tko
         kfeLBpTH8La7zcTGFvaYEgoytsg2piyHP6fLgq2860Grol5ndqB1MPhyraFDMNQKTK+n
         oue+0cQsa9LFBfZTaI4/j6BFIgDNjeP9ImhpQyLkPZyUhCKwrq0FQvbycmZrEpQRMvjS
         hdRw==
X-Gm-Message-State: ABy/qLa6kjs2c1BbPGo0W9WFo4iuQ698ZtqLDlDuuuDP2Np+2K1wggbL
        WbysGMALH5GSAbbmRA8PJjc=
X-Google-Smtp-Source: APBJJlH9PDT+q0JgnKqxG0mAYhn5yeHuIY+jZzSDLhGNnX4V1J5t0tHwrBjixjlJSy/Lm9lQSErlrA==
X-Received: by 2002:a05:6a00:230c:b0:686:2526:ee70 with SMTP id h12-20020a056a00230c00b006862526ee70mr6668625pfh.14.1690468796397;
        Thu, 27 Jul 2023 07:39:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l198-20020a633ecf000000b005633778becasm1601252pga.41.2023.07.27.07.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 07:39:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <67eba84a-ae24-2983-a756-463f39f3ca71@roeck-us.net>
Date:   Thu, 27 Jul 2023 07:39:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org
References: <ZMJWet00+9yIl/9c@duo.ucw.cz>
 <78722041-D1F7-45FA-BA1C-41B92209BA6C@joelfernandes.org>
 <0751f5a8-2727-4a08-8bb8-50bbd4244c9c@paulmck-laptop>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 6.4 000/227] 6.4.7-rc1 review
In-Reply-To: <0751f5a8-2727-4a08-8bb8-50bbd4244c9c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/23 07:06, Paul E. McKenney wrote:
> On Thu, Jul 27, 2023 at 09:26:52AM -0400, Joel Fernandes wrote:
>>
>>
>>> On Jul 27, 2023, at 7:35 AM, Pavel Machek <pavel@denx.de> wrote:
>>>
>>> ﻿Hi!
>>>
>>>>> This is the start of the stable review cycle for the 6.4.7 release.
>>>>> There are 227 patches in this series, all will be posted as a response
>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>> let me know.
>>>>>
>>>>> Responses should be made by Thu, 27 Jul 2023 10:44:26 +0000.
>>>>> Anything received after that time might be too late.
>>>>>
>>>>> The whole patch series can be found in one patch at:
>>>>>     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.4.7-rc1.gz
>>>>> or in the git tree and branch at:
>>>>>     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.4.y
>>>>> and the diffstat can be found below.
>>>>
>>>> I saw this when running rcutorture, this one happened in the TREE04
>>>> configuration. This is likely due to the stuttering issues we are discussing
>>>> in the other thread. Anyway I am just making a note here while I am
>>>> continuing to look into it.
>>>
>>> So is the stuttering new in 6.4.7?
>>
>> No it is an old feature in RCU torture tests. But is dependent on timing. Something
>> changed in recent kernels that is making the issues with it more likely. Its hard to bisect as failure sometimes takes hours.
>>
>>>
>>>> Other than that, all tests pass:
>>>> Tested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>
>>> ...or you still believe 6.4.7 is okay to release?
>>
>> As such, it should be Ok. However naturally I am not happy that the RCU testing
>> is intermittently failing. These issues have been seen in last several 6.4 stable releases
>> so since those were released, maybe this one can be too?
>> The fix for stuttering is currently being reviewed.
> 
> Or, to look at it another way, the stuttering fix is specific to torture
> testing.  Would we really want to hold up a -stable release only because
> rcutorture occasionally gives a false-positive failure on certain types
> of systems?
> 

No. However, (unrelated) in linux-next, rcu tests sometimes result in apparent hangs
or long runtime.

[    0.778841] Mount-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.779011] Mountpoint-cache hash table entries: 512 (order: 0, 4096 bytes, linear)
[    0.797998] Running RCU synchronous self tests
[    0.798209] Running RCU synchronous self tests
[    0.912368] smpboot: CPU0: AMD Opteron 63xx class CPU (family: 0x15, model: 0x2, stepping: 0x0)
[    0.923398] RCU Tasks: Setting shift to 2 and lim to 1 rcu_task_cb_adjust=1.
[    0.925419] Running RCU-tasks wait API self tests

(hangs until aborted). This is primarily with Opteron CPUs, but also with others such as Haswell,
Icelake-Server, and pentium3. It is all but impossible to bisect because it doesn't happen
all the time. All I was able to figure out was that it has to do with rcu changes in linux-next.
I'd be much more concerned about that.

Guenter

