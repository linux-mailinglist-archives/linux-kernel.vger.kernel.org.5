Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2728677666E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjHIR1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjHIR1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:27:46 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F7083
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 10:27:46 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-687087d8ddaso5453b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691602065; x=1692206865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0RfWlXl7bFQ0GrIyu2f1yP2FXAuypJVRSJWkjMA7ANQ=;
        b=BUvu7y8eJueAIs2QT9CwEwDxCOQRxZjheb9dB7C+se5N1iKk4i0F1Tr8BBCSsNtLzF
         doG3TYutPkEWIUPQBK9jSV0i34Qg0i4XlMPllf6vH8yXCNBczr9z9sFnLm2lyUHjSxBN
         xaahky4j8fGnGRfgbz6g/MWE6uz15V+ccJ3PS0uhK99h3LAS3MD8ydr05ZxJx9SYkWLj
         nR3mZJFImDSV5V4HCvUs8/lJaG1nx3kAwbnU1WiN8EfUTTlmg7JZJY2YX7PYDHV2ct2X
         k5kmXrE83DoIAHhg1/rtqnDH+kR3q+95jZySyteYBA6i2YeqFdlbSMb/H+UG8DpUmN93
         ZcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691602065; x=1692206865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0RfWlXl7bFQ0GrIyu2f1yP2FXAuypJVRSJWkjMA7ANQ=;
        b=OMVoDqar5STEYcENEiJ5q4/92tk40DACBi8e4zYH3xcIpySr0tDTd5iYWgDNPcvYat
         VH2XkZEdqKMmn8lBhV0BHyWokMVpAVNB9YvITMa3dFP3Rvd/3snt9lxAiSXnisk3zkx1
         f61fzpcyOoYS4em/jW6vjkMH5Ep0hV2eXUHHc2R+aoAvhEpzZrl35BKxI1Pmcyovd15J
         SAZr+JHlBMYRmzawtWqZvXNO1yFAtREqQ7Q4tbafeJpE9wteDbdb7sQy2FW6i0YiyObZ
         MBfOinloSTQZiNJ2gI/m/G6VZyD5LPLcw0yvk1QIJ1qMrun4PVjQ/fxx7df7ISt8qSYQ
         4obA==
X-Gm-Message-State: AOJu0Yys8+ZIaLsdyC3I1YSYLE2smAjBoctjJeF2zLKSZGjp3csbpcZJ
        C7yCPPGQ+XmFKClO0/MqXYc=
X-Google-Smtp-Source: AGHT+IFKso46ZiHFFKHMZA7a7r+hHjBEfY8ReVCQW2IgJKbMq5/40ehHtPV7suwZG9XwdVf4PVtcMQ==
X-Received: by 2002:a05:6a20:3254:b0:134:dc23:2994 with SMTP id hm20-20020a056a20325400b00134dc232994mr3286974pzc.31.1691602065397;
        Wed, 09 Aug 2023 10:27:45 -0700 (PDT)
Received: from [192.168.0.101] ([49.207.242.210])
        by smtp.gmail.com with ESMTPSA id c4-20020aa781c4000000b0068703879d3esm10233562pfn.113.2023.08.09.10.27.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 10:27:44 -0700 (PDT)
Message-ID: <d59d98e3-d43d-44fb-a07e-1bae70447ee2@gmail.com>
Date:   Wed, 9 Aug 2023 22:57:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 8/8] kbuild: modinst: do modules_install step by step
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-kernel@vger.kernel.org, sshedi@vmware.com
References: <20230623145358.568971-1-yesshedi@gmail.com>
 <20230623145358.568971-9-yesshedi@gmail.com>
 <CAK7LNARnuaOi-GwW0qnFgH5styuUTtmjSNWV92PEO6VgpqNvQg@mail.gmail.com>
 <c98ffcdc-1e2f-4496-99a3-3b590002e5b1@gmail.com>
 <CAK7LNASR1fCXG8M-3=Zb-_i2mFFt-cHpREzeWkw1Fe-Zuz_XSw@mail.gmail.com>
From:   Shreenidhi Shedi <yesshedi@gmail.com>
In-Reply-To: <CAK7LNASR1fCXG8M-3=Zb-_i2mFFt-cHpREzeWkw1Fe-Zuz_XSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 00:14, Masahiro Yamada wrote:
> On Mon, Aug 7, 2023 at 5:08 PM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
>>
>> On 07/08/23 01:02, Masahiro Yamada wrote:
>>> On Fri, Jun 23, 2023 at 11:54 PM Shreenidhi Shedi <yesshedi@gmail.com> wrote:
>>>>
>>>> Currently Makefile.modinst does three tasks on each module built:
>>>> - Install modules
>>>> - Sign modules
>>>> - Compress modules
>>>>
>>>> All the above tasks happen from a single place.
>>>>
>>>> This patch divides this task further and uses a different makefile for
>>>> each task.
>>>> Signing module logic is completely refactored and everything happens
>>>> from a shell script now.
>>>>
>>>> Signed-off-by: Shreenidhi Shedi <yesshedi@gmail.com>
>>>
>>>
>>> This patch is bad in multiple ways.
>>>
>>> 1. Break "make modules_sign"
>>
>> Correct, somehow I missed it. I will fix it.
>> I'm using below command to test sign only option. Please let me know if
>> I should use something else.
>>
>> make modules_sign modules_sign_only=1 INSTALL_MOD_PATH=$PWD/tmp -j8
>>
>>> 2.   Serialize the installation steps, that is, works less efficiently
>>
>> Even in the existing system it happens in serially.
> 
> The existing code runs in parallel.
> 
>   1.  Copy the module "foo.ko" to the destination
>   2.  Sign the module "bar.ko"
>   3.  Compress the module "baz.ko"
> 
> Those three have no dependency among them, so
> should be able to run in parallel.
> 
> Your code serializes 1 -> 2 -> 3
> 
> 
> 
>> And the existing
>> method takes more time than the proposed version.
>>
>> root@ph5dev:~/linux-6.3.5 # ./test.sh orig
>>
>> real    0m14.699s
>> user    0m55.519s
>> sys     0m9.036s
>>
>> root@ph5dev:~/linux-6.3.5 # ./test.sh new
>>
>> real    0m13.327s
>> user    0m46.885s
>> sys     0m6.770s
>>
>> Here is my test script.
>> ```
>> #!/bin/bash
>>
>> set -e
>>
>> if [ "$1" != "new" ] && [ "$1" != "orig" ]; then
>>     echo "invalid arg, ($0 [orig|new])" >&2
>>     exit 1
>> fi
>>
>> rm -rf $PWD/tmp
>>
>> s="scripts/sign-file.c"
>> m="scripts/Makefile.modinst"
>> fns=($s $m)
>>
>> for f in ${fns[@]}; do
>>       cp $f.$1 $f
>> done
>>
>> cd scripts
>> gcc -o sign-file sign-file.c -lcrypto
>> cd -
>>
>> time make modules_install INSTALL_MOD_PATH=$PWD/tmp -s -j$(nproc)
>> ```
>>
>>> 3.   Increase code without adding any benefits.
>>> Agree with increased code but this change is one step closer to Unix
>> philosophy, do one thing well wrt modules_install.
> 
> 
> I do not understand why "closer to Unix philosophy"?
> 
> You are adding extra/unnecessary complexity.
> 
> Currently, the parallel job is managed by Make's job server.
> 
> You are introducing another way of parallel execution
> in scripts/signfile.sh
> (and you completely ignored  -j <jobs> option to Make,
> and always spawned $(nproc) threads).
> 
> 
> Leave the parallel execution GNU Make.
> That is how Kbuild works _properly_.
> 
> 
> 
> 
>>> There is no good reason to do these chang >I hope the data I provided above to your 2nd point provides evidence
>> that this fix is improving existing system. Please take a look again.
> 
> 
> I saw it.   I re-confirmed this is not an improvement.  Thanks for the data.
> 
> As I replied to the other thread, my measurement did not show an
> attractive result.
> https://lore.kernel.org/lkml/CAK7LNATNRchNoj0Y6sdb+_81xwV3kAX57-w5q2zew-q8RyzJVg@mail.gmail.com/T/#m8234fc76e631363fbe6bdfb6e45ef6727fc48e80
> 
> 
>>
>>> NACK.
>>
>> Hi Masahiro Yamada,
>>
>> Replies inline above.
>>
>> Please correct me if my understanding is wrong. Thanks a lot for your
>> time and patience. Have a nice time ahead.
> 
> 
> I must let you know you are misunderstanding
> the meaning of NACK.
> 
> 
> NACK means:
>   "I do not like it. Please do not submit it any more".
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada

Thanks for all the advice and your time, I'm getting used to this 
process. I dropped Kbuild changes from my patch series v9. PTAL.

Have a nice time ahead.

-- 
Shedi

