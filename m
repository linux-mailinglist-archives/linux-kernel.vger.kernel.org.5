Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5697A8638
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbjITOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjITOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:10:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87AFAD;
        Wed, 20 Sep 2023 07:09:57 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qixtq-0005eU-Jm; Wed, 20 Sep 2023 16:09:54 +0200
Message-ID: <2662e142-8b19-6e88-8030-47815598bf12@leemhuis.info>
Date:   Wed, 20 Sep 2023 16:09:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: 5c8a79e8e12b ("wifi: rtw88: correct PS calculation for
 SUPPORTS_DYNAMIC_PS", 2023-05-27) increases CPU usage usage for irq
Content-Language: en-US, de-DE
To:     brett hassall <brett.hassall@gmail.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Kalle Valo <kvalo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Wireless <linux-wireless@vger.kernel.org>
References: <5a7f2a6e-46a4-a5c8-fe6a-c2581496b5cd@gmail.com>
 <c7e70f54-9696-4b39-aa17-576987ffce85@leemhuis.info>
 <CANiJ1U80VNiLGKEmgYpGjUQ2poREN9uGnv2QXM_GtzjgBtUSWQ@mail.gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CANiJ1U80VNiLGKEmgYpGjUQ2poREN9uGnv2QXM_GtzjgBtUSWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1695218997;47eed383;
X-HE-SMSGID: 1qixtq-0005eU-Jm
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.09.23 01:04, brett hassall wrote:
> 
> I'd suggest that there are actually 2 regressions
> (https://bugzilla.kernel.org/show_bug.cgi?id=217841 and this bug). Bug
> 217841 masks this bug

Is that maybe a duplicate of this one:
https://bugzilla.kernel.org/show_bug.cgi?id=217321

In that case it might make sense to test with a proposed fix for that
bug (that iirc is
https://lore.kernel.org/all/20230911073352.3472918-1-mika.westerberg@linux.intel.com/
) to speed up fixing the rtw88 regression in case there is one.

Ciao, Thorsten

> as it prevents the laptop reaching package C8
> and I'm assuming this bug shows when in C8. The patch for 21784 only
> affects devices connected to a VMD controller so I wouldn't expect it
> to affect the 8822CE.
> 
> Options that I can see are:
> 1. Park this bug until 217841 is resolved
> 2. Try to test on a laptop with a Realtek 8822CE but not a VMD
> controller. I have access to 5 different laptop models but none meet
> those criteria.
> 
> 
> Thanks for the reply
> Brett
> 
> On Mon, 11 Sept 2023 at 23:29, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
>>
>> On 27.08.23 04:37, Bagas Sanjaya wrote:
>>>
>>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>>
>>>> This commit improves power saving - it enables the kernel to
>>>> achieve package C8. To achieve package C8, 3 Ubuntu VMD commits
>>>> must be applied as well. [...]
>>
>> To me that sounds like there is no upstream problem, hence this
>> shouldn't be tracked as a regression. Please correct me if I'm wrong.
>>
>>> #regzbot introduced: 26a125f550a3bf
>>> https://bugzilla.kernel.org/show_bug.cgi?id=217828 #regzbot title:
>>> correcting SUPPORTS_DYNAMIC_PS calculation for rtw88 increases CPU
>>> utilization #regzbot link:
>>> https://bugs.launchpad.net/ubuntu/+source/linux-hwe-6.2/+bug/2025040
>>>
>>> Thanks.
>>>
>>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217828
>>
>> #regzbot resolved: invalid: seems to only be a problem with a patched kernel
>> #regzbot ignore-activity
>>
>> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
>> --
>> Everything you wanna know about Linux kernel regression tracking:
>> https://linux-regtracking.leemhuis.info/about/#tldr
>> If I did something stupid, please tell me, as explained on that page.
>>
>>
> 
> 
