Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C617A647C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 15:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbjISNLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 09:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjISNLF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:11:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5891F4;
        Tue, 19 Sep 2023 06:10:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C873D1FB;
        Tue, 19 Sep 2023 06:11:36 -0700 (PDT)
Received: from [192.168.1.3] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E002F3F59C;
        Tue, 19 Sep 2023 06:10:57 -0700 (PDT)
Message-ID: <55a57c4c-e846-1f94-9067-75f03b3618e7@arm.com>
Date:   Tue, 19 Sep 2023 14:10:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [EXT] Re: [RFC PATCH v3 0/8] Coresight for Kernel panic and
 watchdog reset
Content-Language: en-US
To:     Linu Cherian <lcherian@marvell.com>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        George Cherian <gcherian@marvell.com>
References: <20230904050548.28047-1-lcherian@marvell.com>
 <fafd728b-1489-4856-ced3-6759fbda2c6f@arm.com>
 <PH0PR18MB50021C74B2EC3C8795715ADBCEFAA@PH0PR18MB5002.namprd18.prod.outlook.com>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <PH0PR18MB50021C74B2EC3C8795715ADBCEFAA@PH0PR18MB5002.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/09/2023 12:39, Linu Cherian wrote:
> Hi James,
> 
>> -----Original Message-----
>> From: James Clark <james.clark@arm.com>
>> Sent: Friday, September 15, 2023 7:20 PM
>> To: Linu Cherian <lcherian@marvell.com>; suzuki.poulose@arm.com;
>> mike.leach@linaro.org; leo.yan@linaro.org
>> Cc: linux-arm-kernel@lists.infradead.org; coresight@lists.linaro.org; linux-
>> kernel@vger.kernel.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> devicetree@vger.kernel.org; Sunil Kovvuri Goutham
>> <sgoutham@marvell.com>; George Cherian <gcherian@marvell.com>
>> Subject: [EXT] Re: [RFC PATCH v3 0/8] Coresight for Kernel panic and
>> watchdog reset
>>
>> External Email
>>
>> ----------------------------------------------------------------------
>>
>>
>> On 04/09/2023 06:05, Linu Cherian wrote:
>>> This RFC v3 patch series is rebased on v6.5-rc7 and is dependent on
>>> the below two patches.
>> [...]
>>>
>>> Steps for reading trace data captured in previous boot
>>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 1. cd /sys/bus/coresight/devices/tmc_etrXX/
>>>
>>> 2. Change to special mode called, read_prevboot.
>>>
>>>    #echo 1 > read_prevboot
>>>
>>> 3. Dump trace buffer data to a file,
>>>
>>>    #dd if=/dev/tmc_etrXX of=~/cstrace.bin
>>
>> Hi Linu,
>>
>> I left this comment on V2, but I tested it again and get the same result.
>> Instead of linking it I'll just re-paste it here:
>>
>> I made a reserved region, but when I run this command I get "Unable to
>> handle kernel paging request at virtual address 001f1921ed10ffae".
>>
>> Is there an extra step involved if there was no trace captured from a previous
>> panic? I thought I'd just be able to read out uninitialised data. Or is it the
>> uninitialised metadata that's causing this issue?
>>
>> Also that's without KASAN or lockdep turned on. If I have a kernel with either
>> of those things I get a different warning for each one. I expect the lockdep
>> one would happen even in the working scenario though?
> 
> Somehow I missed this comment on V2.
> 
> I retried the above steps on my board and I do not see issues either with KASAN OR lockdep enabled configs.
> Please see logs below. 
> 
> a. Lockdep enabled config
> ~# cd /sys/bus/coresight/devices/tmc_etr0
> tmc_etr0# echo 1 > read_prevboot
> tmc_etr0# dd if=/dev/tmc_etr0 of=~/cstrace.bin
> 12324+1 records in
> 12324+1 records out
> 6310032 bytes (6.3 MB, 6.0 MiB) copied, 0.122883 s, 51.3 MB/s
> 
> # zcat /proc/config.gz | grep LOCKDEP
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_LOCKDEP=y
> CONFIG_LOCKDEP_BITS=15
> CONFIG_LOCKDEP_CHAINS_BITS=16
> CONFIG_LOCKDEP_STACK_TRACE_BITS=19
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
> # CONFIG_DEBUG_LOCKDEP is not set
> 
> b. KASAN enabled config
> # cd /sys/bus/coresight/devices/tmc_etr0/
> tmc_etr0# ls
> buf_mode_preferred   connections  power          trigger_cntr
> buf_modes_available  enable_sink  read_prevboot  uevent
> buffer_size          mgmt         subsystem      waiting_for_supplier
> tmc_etr0# echo 1 > read_prevboot
> tmc_etr0# dd if=/dev/tmc_etr0 of=~/cstrace.bin
> 12324+1 records in
> 12324+1 records out
> 6310032 bytes (6.3 MB, 6.0 MiB) copied, 0.0940671 s, 67.1 MB/s
> 
> ~# zcat /proc/config.gz | grep -i kasan
> CONFIG_KASAN_SHADOW_OFFSET=0xdfff800000000000
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_SW_TAGS=y
> CONFIG_HAVE_ARCH_KASAN_HW_TAGS=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> CONFIG_CC_HAS_KASAN_SW_TAGS=y
> CONFIG_KASAN=y
> CONFIG_KASAN_GENERIC=y
> # CONFIG_KASAN_SW_TAGS is not set
> # CONFIG_KASAN_HW_TAGS is not set
> CONFIG_KASAN_OUTLINE=y
> # CONFIG_KASAN_INLINE is not set
> CONFIG_KASAN_STACK=y
> CONFIG_KASAN_VMALLOC=y
> # CONFIG_KASAN_MODULE_TEST is not set
> 
> 
> But then I am able to trigger kernel crash with bad metadata(corrupted rwp and rrp) with below stack trace.
> 
> [  107.442991]  __arch_copy_to_user+0x180/0x240
> [  107.447254]  vfs_read+0xc8/0x2a8
> [  107.450476]  ksys_read+0x74/0x110
> [  107.453783]  __arm64_sys_read+0x24/0x38
> [  107.457611]  invoke_syscall.constprop.0+0x58/0xf8
> [  107.462309]  do_el0_svc+0x6c/0x158
> [  107.465704]  el0_svc+0x54/0x1c0
> [  107.468839]  el0t_64_sync_handler+0x100/0x130
> [  107.473188]  el0t_64_sync+0x190/0x198
> [  107.476843] Code: d503201f d503201f d503201f d503201f (a8c12027)
> 
> Does your stack trace looks similar ? Then its very likely due to bad metadata.
> If not, kindly please share yours.
> 
> For example, if we have bad values for rwp and rrp, offset can get messed up resulting in above crash.
> Will add more validation checks while setting up the prevboot buffer,  so as to avoid processing with bogus metadata values
> in the next patch version.
> 
> Thanks James for trying this out.
> 
>

I think it must be bad metadata because I didn't try it with a previous
crash saved yet. I suppose we do need some kind of validation then if
it's possible for bad metadata to cause a crash.

I will try after filling in the metadata and see if that was the issue.
> 
>>
>>>
>>> 4. Reset back to normal mode
>>>
>>>    #echo 0 > read_prevboot
>>>
