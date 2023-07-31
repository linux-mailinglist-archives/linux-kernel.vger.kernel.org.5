Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8990769999
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 16:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjGaOfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 10:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjGaOfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 10:35:19 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60F0114;
        Mon, 31 Jul 2023 07:35:17 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-3492c49c649so1278855ab.3;
        Mon, 31 Jul 2023 07:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690814117; x=1691418917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=eX7bMytNzv0J3fxDqTlC2BO6YnoZqvtt4NQGt1AgiU4=;
        b=rAXh0Kl41BzPzNoVSMPXW5VZDSHU/rKAb8c/yQY1STNYAQm0EcDwAC1lqjO8xBoftW
         Z1PwwISf32G10+oYRoUyc3wu6sIOaMyoKNGuGMUZDTHsOlk9einQDaUPEOTqLRLDEoS+
         BDMCuTecC+d5obNRPuZGZjSdurg91ueXLrfVFTutrUel9vFsDd3vl4bI869rP7fjh8/9
         QYV5VnIBF0piLC5dvuyosVjYiI7BmRcZ8G/VYI2AKd2q2gcLqwbKu3MH0lQR2iM4i1IJ
         N078FhR4NMXxVju552ULbWH/aQWITfEjhK+T8WG5b6W+recySTGMdoEkeqocF/XU6aj5
         pkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690814117; x=1691418917;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eX7bMytNzv0J3fxDqTlC2BO6YnoZqvtt4NQGt1AgiU4=;
        b=S5BNgasraaTPua55aSfurgtHTr+fH8kYnhZdj+77RnYVSo3hOo5O4Ye4A18oL0j5J/
         opiuogux3F3KPNVUl0tm8w3k5+2E3rfj3hBzOO0B7F8xWtXOaAibKzFAFO+x/CZQ+bBq
         Yx7l0k4KKJw9HIIGftRK/ygWgcbE+VpcWwlZWDrkuPZjlB95j3MoLQtkmFpc2hytC0Xn
         tJvOzm9YyH+2WN9ynPr/rzLdrUUYN4EWVaNEY0LA0AvDeBZE2AcKrp+AWNGC5cWyhVMg
         +Dx0rJN40x1tKQOTKhX87b7CKY04uitEc593TdniZq/vlF4a5nAelVUa64ktvYhviOJ7
         Cu9w==
X-Gm-Message-State: ABy/qLajd43t52WoLWdTqGvWNTTzytfEXf0LJCmSFfj0OAqN0wUeQtN4
        r4NI7JLasuDa9dTBp5fHwPE=
X-Google-Smtp-Source: APBJJlGikep+h8o7CaYmzfeQ/pBZ2sTGFN74ikCmDl07peGIRp46V+WHUCM8Q04L+ArVJnVtF7Cxkg==
X-Received: by 2002:a05:6e02:170d:b0:346:24c2:4f87 with SMTP id u13-20020a056e02170d00b0034624c24f87mr10125503ill.32.1690814117204;
        Mon, 31 Jul 2023 07:35:17 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b7-20020a05663801a700b0042b09036e5fsm3070050jaq.175.2023.07.31.07.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 07:35:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fdaaee62-b67e-556c-2675-aacd3ec994f6@roeck-us.net>
Date:   Mon, 31 Jul 2023 07:35:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: scheduler problems in -next (was: Re: [PATCH 6.4 000/227]
 6.4.7-rc1 review)
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Joel Fernandes <joel@joelfernandes.org>, paulmck@kernel.org,
        Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        rcu@vger.kernel.org, Ingo Molnar <mingo@kernel.org>
References: <2cfc68cc-3a2f-4350-a711-ef0c0d8385fd@paulmck-laptop>
 <D56D0318-A2EA-4448-8F4D-BE84706E26A5@joelfernandes.org>
 <3da81a5c-700b-8e21-1bde-27dd3a0b8945@roeck-us.net>
 <20230731141934.GK29590@hirez.programming.kicks-ass.net>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230731141934.GK29590@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/31/23 07:19, Peter Zijlstra wrote:
> On Sat, Jul 29, 2023 at 09:00:02PM -0700, Guenter Roeck wrote:
>> On 7/27/23 16:18, Joel Fernandes wrote:
>>
>> [ ... ]
>>
>>>> I freely confess that I am having a hard time imagining what would
>>>> be CPU dependent in that code.  Timing, maybe?  Whatever the reason,
>>>> I am not seeing these failures in my testing.
>>>>
>>>> So which of the following Kconfig options is defined in your .config?
>>>> CONFIG_TASKS_RCU, CONFIG_TASKS_RUDE_RCU, and CONFIG_TASKS_TRACE_RCU.
>>>>
>>>> If you have more than one of them, could you please apply this patch
>>>> and show me the corresponding console output from the resulting hang?
>>>
>>> FWIW, I am not able to repro this issue either. If a .config can be shared of the problem system, I can try it out to see if it can be reproduced on my side.
>>>
>>
>> I managed to bisect the problem. See bisect log below. Bisect repeated twice.
>> so it should be reliable. I don't really understand it, but the following
>> reverts fix the problem. This is on top of next-20230721 because next-20230728
>> crashes immediately in my tests.
>>
>> 0caafe9b94ab (HEAD) Revert "sched/fair: Remove sched_feat(START_DEBIT)"
>> 518bdbd39fdb Revert "sched/fair: Add lag based placement"
>> a011162c3e32 Revert "sched/fair: Implement an EEVDF-like scheduling policy"
>> df579720bf98 Revert "sched/fair: Commit to lag based placement"
>> aac459a7e738 Revert "sched/smp: Use lag to simplify cross-runqueue placement"
>> 8d686eb173e1 Revert "sched/fair: Commit to EEVDF"
>> 486474c50f95 Revert "sched/debug: Rename sysctl_sched_min_granularity to sysctl_sched_base_slice"
>> 79e94d67d08a Revert "sched/fair: Propagate enqueue flags into place_entity()"
>> ae867bc97b71 (tag: next-20230721) Add linux-next specific files for 20230721
>>
>> For context: x86 images (32 and 64 bit) in -next tend to hang at
>>
>> [    2.309323] RCU Tasks: Setting shift to 0 and lim to 1 rcu_task_cb_adjust=1.
>> [    2.311634] Running RCU-tasks wait API self tests
>>
>> The hang is not seen with every boot; it happens roughly about once every
>> 10 boot attempts. It is not CPU dependent as I initially thought.
>>
>> Configuration file is at http://server.roeck-us.net/qemu/x86-next/config.
>> Example qemu command line:
> 
> Hurmph, let me see if I can reproduce on next-20230731 (not having the
> older next thingies around).

That crashes hard with my configuration.

[    6.353191] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[    6.353392] BUG: unable to handle page fault for address: ffff9b10c0013cd0
[    6.353531] #PF: supervisor instruction fetch in kernel mode
[    6.353624] #PF: error_code(0x0011) - permissions violation
[    6.353751] PGD 1000067 P4D 1000067 PUD 1205067 PMD 1206067 PTE 800000000124e063
[    6.354011] Oops: 0011 [#1] PREEMPT SMP PTI
[    6.354164] CPU: 0 PID: 182 Comm: kunit_try_catch Tainted: G                 N 6.5.0-rc4-next-20230731 #1
[    6.354315] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-0-gea1b7a073390-prebuilt.qemu.org 04/01/2014
[    6.354525] RIP: 0010:0xffff9b10c0013cd0
[    6.354793] Code: ff ff 60 64 ce a9 ff ff ff ff 00 00 00 00 00 00 00 00 d1 3a bc a8 ff ff ff ff 00 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <f0> 00 01 44 10 8a ff ff b8 01 01 44 10 8a ff ff 00 00 00 00 00 00
[    6.355059] RSP: 0000:ffff9b10c027fd60 EFLAGS: 00000246
[    6.355157] RAX: ffff9b10c0013cd0 RBX: ffff8a1043bdb400 RCX: 0000000000000000
[    6.355259] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8a1043bdb400
[    6.355358] RBP: ffff9b10c027fdc8 R08: 0000000000000001 R09: 0000000000000001
[    6.355456] R10: 0000000000000001 R11: 0000000000000001 R12: ffff9b10c027fe74
[    6.355556] R13: ffff8a10440100f0 R14: ffff8a10440101b8 R15: ffff9b10c027fe74
[    6.355679] FS:  0000000000000000(0000) GS:ffff8a104fc00000(0000) knlGS:0000000000000000
[    6.355798] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    6.355886] CR2: ffff9b10c0013cd0 CR3: 000000000e048000 CR4: 00000000003506f0
[    6.356029] Call Trace:
[    6.356158]  <TASK>
[    6.356334]  ? __die+0x1f/0x70
[    6.356472]  ? page_fault_oops+0x14a/0x460
[    6.356547]  ? exc_page_fault+0xee/0x1c0
[    6.356612]  ? asm_exc_page_fault+0x26/0x30
[    6.356703]  ? kunit_filter_attr_tests+0xc4/0x2e0
[    6.356796]  kunit_filter_suites+0x2e2/0x460
[    6.356889]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    6.356979]  filter_suites_test+0xea/0x2c0
[    6.357051]  ? __pfx_kunit_generic_run_threadfn_adapter+0x10/0x10
[    6.357148]  kunit_generic_run_threadfn_adapter+0x15/0x20
[    6.357228]  kthread+0xef/0x120
[    6.357282]  ? __pfx_kthread+0x10/0x10
[    6.357343]  ret_from_fork+0x2f/0x50
[    6.357399]  ? __pfx_kthread+0x10/0x10
[    6.357458]  ret_from_fork_asm+0x1b/0x30
[    6.357560]  </TASK>
[    6.357632] Modules linked in:
[    6.357786] CR2: ffff9b10c0013cd0
[    6.358010] ---[ end trace 0000000000000000 ]---

Enabling CONFIG_ZERO_CALL_USED_REGS might fix (hide) this, but I have not tried.

Guenter

