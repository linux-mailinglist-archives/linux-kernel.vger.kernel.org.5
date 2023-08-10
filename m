Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795727783D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 00:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjHJWzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 18:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHJWzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 18:55:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA802710;
        Thu, 10 Aug 2023 15:55:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-686ea67195dso1092059b3a.2;
        Thu, 10 Aug 2023 15:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691708112; x=1692312912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pS0Lo1kJlHieBQ5YsJnXL1+oPBs941kGPLqenyHuerA=;
        b=lre9mOOFIQCByiKMOdS0AoOY+OeHqfFaOcw1DsXABI3FgkfXxQCtYG3L6BQ+2+l73u
         crj8E6rbWftD7wQqMyC63nRgLEEFpMfeo3PujHSpy7sRHCW2cy5JrhywJmw9j9AIpg0S
         mUcf6SOayFGcdYzJrowUlLP1zpxbdmYO8UsfBljGgeNTCtH8NdOgaQbJrAhkuZhrGVTb
         9xgSnzDUsAnPb+WIJF+BWypzUi1MiThtZPu+H9O6IDKYCZpgtm2GZukE0vn6nFl3fJX6
         eMtQiERSlMUccMYi+cuAH11RI4DCfFp9AhMmA2KV6TqK8CLSwqGowBlUr+tfYCzS8eIN
         dfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691708112; x=1692312912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pS0Lo1kJlHieBQ5YsJnXL1+oPBs941kGPLqenyHuerA=;
        b=K0OerZ7tjjhFemYohi+Z8z6s0N7SJdEZs4vk3CtM5O+3ULgWjQ36jDlxzFE2Esd164
         C2F8eMfXo2mG5z/IuuDrCprP0+t8NJ4AHFVURK6MQrxikAogAtTzRATd0q9vjZB0+9Zx
         bGmyTWIrHLJ1dfrwlymmlKPKr+Tyoj+54IBvk5STOouGJXO6kmQck8Xsq3QZlfcj+awB
         ZYgZ6D/HHuFzRGx7RqR3N5RYzb/K0Mc6bFHQOgICkkvyQ87L6hwcY7BFXE9IzpfhJEAm
         zslZs/K9nOX9mYaAy3GefSffFtuIDWDArUIXBj0DnxWARjqRv5Y08RMKjhIiAfEIZPIh
         cKQQ==
X-Gm-Message-State: AOJu0YwHwHdDppnma+7R6bZPybye8DcPwpuTwZ4ZpIlcvWjdnKvU/oFi
        xyAcyQdhu500lstGEjlpGGk=
X-Google-Smtp-Source: AGHT+IEKS/ovHAbeQfQi4ksp1kESennGreEC+4KLwjRz6tlflZmmHweJyBTEhOhgwdTF1WEzgVVDVQ==
X-Received: by 2002:a05:6a20:102:b0:13b:9ff3:f52e with SMTP id 2-20020a056a20010200b0013b9ff3f52emr316327pzr.56.1691708111821;
        Thu, 10 Aug 2023 15:55:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k17-20020aa792d1000000b006879493aca0sm2027651pfa.26.2023.08.10.15.55.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 15:55:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3d23da0b-696b-5ace-0ea7-5ac4a38cd46b@roeck-us.net>
Date:   Thu, 10 Aug 2023 15:55:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5.15 00/92] 5.15.126-rc1 review
Content-Language: en-US
To:     Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20230809103633.485906560@linuxfoundation.org>
 <20230809135326.GE3031656@google.com>
 <f47340c6-3c41-1f91-d0f9-fe0b59a23aac@roeck-us.net>
 <CAEXW_YQ4GqPwvUF8=8CWmdj=cD56v_eEVK-EirsObQXyBDFVpg@mail.gmail.com>
 <35e4b770-2ead-4a19-ad01-fa75996adef4@roeck-us.net>
 <20230809201413.GA3374446@google.com>
 <6b05a082-41a7-f0cf-c0a4-1cced8d5a230@roeck-us.net>
 <CAEXW_YT-7epvu4uUS19aDAcM0X63j9_L2aa-XGGFGSLceLu8bA@mail.gmail.com>
 <4dbe72a3-50ea-051c-96ba-d709b33d3a98@roeck-us.net>
 <882a606f-5776-46d1-a423-2c5ea0a1cd8f@paulmck-laptop>
 <20230810215416.GA562211@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230810215416.GA562211@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/23 14:54, Joel Fernandes wrote:
> On Thu, Aug 10, 2023 at 10:55:16AM -0700, Paul E. McKenney wrote:
>> On Wed, Aug 09, 2023 at 02:45:44PM -0700, Guenter Roeck wrote:
>>> On 8/9/23 13:39, Joel Fernandes wrote:
>>>> On Wed, Aug 9, 2023 at 4:38 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>
>>>>> On 8/9/23 13:14, Joel Fernandes wrote:
>>>>>> On Wed, Aug 09, 2023 at 12:25:48PM -0700, Guenter Roeck wrote:
>>>>>>> On Wed, Aug 09, 2023 at 02:35:59PM -0400, Joel Fernandes wrote:
>>>>>>>> On Wed, Aug 9, 2023 at 12:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>>>>>>>
>>>>>>>>> On 8/9/23 06:53, Joel Fernandes wrote:
>>>>>>>>>> On Wed, Aug 09, 2023 at 12:40:36PM +0200, Greg Kroah-Hartman wrote:
>>>>>>>>>>> This is the start of the stable review cycle for the 5.15.126 release.
>>>>>>>>>>> There are 92 patches in this series, all will be posted as a response
>>>>>>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>>>>>>> let me know.
>>>>>>>>>>>
>>>>>>>>>>> Responses should be made by Fri, 11 Aug 2023 10:36:10 +0000.
>>>>>>>>>>> Anything received after that time might be too late.
>>>>>>>>>>>
>>>>>>>>>>> The whole patch series can be found in one patch at:
>>>>>>>>>>>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.126-rc1.gz
>>>>>>>>>>> or in the git tree and branch at:
>>>>>>>>>>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
>>>>>>>>>>> and the diffstat can be found below.
>>>>>>>>>>
>>>>>>>>>> Not necesscarily new with 5.15 stable but 3 of the 19 rcutorture scenarios
>>>>>>>>>> hang with this -rc: TREE04, TREE07, TASKS03.
>>>>>>>>>>
>>>>>>>>>> 5.15 has a known stop machine issue where it hangs after 1.5 hours with cpu
>>>>>>>>>> hotplug rcutorture testing. Me and tglx are continuing to debug this. The
>>>>>>>>>> issue does not show up on anything but 5.15 stable kernels and neither on
>>>>>>>>>> mainline.
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Do you by any have a crash pattern that we could possibly use to find the crash
>>>>>>>>> in ChromeOS crash logs ? No idea if that would help, but it could provide some
>>>>>>>>> additional data points.
>>>>>>>>
>>>>>>>> The pattern shows as a hard hang, the system is unresponsive and all CPUs
>>>>>>>> are stuck in stop_machine. Sometimes it recovers on its own from the
>>>>>>>> hang and then RCU immediately gives stall warnings. It takes 1.5 hour
>>>>>>>> to reproduce and sometimes never happens for several hours.
>>>>>>>>
>>>>>>>> It appears related to CPU hotplug since gdb showed me most of the CPUs
>>>>>>>> are spinning in multi_cpu_stop() / stop machine after the hang.
>>>>>>>>
>>>>>>>
>>>>>>> Hmm, we do see lots of soft lockups with multi_cpu_stop() in the backtrace,
>>>>>>> but not with v5.15.y but with v5.4.y. The actual hang is in stop_machine_yield().
>>>>>>
>>>>>> Interesting. It looks similar as far as the stack dump in gdb goes, here are
>>>>>> the stacks I dumped with the hang I referred to:
>>>>>> https://paste.debian.net/1288308/
>>>>>>
>>>>>
>>>>> That link gives me "Entry not found".
>>>>
>>>> Yeah that was weird. Here it is again: https://pastebin.com/raw/L3nv1kH2
>>>
>>> I found a couple of crash reports from chromeos-5.10, one of them complaining
>>> about RCU issues. I sent you links via IM. Nothing from 5.15 or later, though.
>>
>> Is the crash showing the eternally refiring timer fixed by this commit?
>>
>> 53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ entry")
> 
> Ah I was just replying, I have been seeing really good results after applying
> the following 3 commits since yesterday:
> 
> 53e87e3cdc15 ("timers/nohz: Last resort update jiffies on nohz_full IRQ entry")
> 5417ddc1cf1f ("timers/nohz: Switch to ONESHOT_STOPPED in the low-res handler when the tick is stopped")
> a1ff03cd6fb9 ("tick: Detect and fix jiffies update stall")
> 

Would those also apply to v5.10.y, or just 5.15.y ?

Thanks,
Guenter

> 5417ddc1cf1f also mentioned a "tick storm" which is exactly what I was
> seeing.
> 
> I did a lengthy test and everything is looking good. I'll send these out to
> the stable list.
> 
> thanks,
> 
>   - Joel
> 
> 

