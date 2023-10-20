Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533B27D0FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 14:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377376AbjJTMu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 08:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377239AbjJTMu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 08:50:56 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1A2D49
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 05:50:51 -0700 (PDT)
Received: from fsav117.sakura.ne.jp (fsav117.sakura.ne.jp [27.133.134.244])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 39KConMD087200;
        Fri, 20 Oct 2023 21:50:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav117.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp);
 Fri, 20 Oct 2023 21:50:49 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav117.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 39KComnl087197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 20 Oct 2023 21:50:49 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <108abe1f-56bc-42d1-90c5-180a3d66b5ab@I-love.SAKURA.ne.jp>
Date:   Fri, 20 Oct 2023 21:50:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86@kernel.org, joel@joelfernandes.org, frederic@kernel.org
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
 <90361195-4309-4a02-bd3f-8ee606e6d35b@I-love.SAKURA.ne.jp>
 <c9ddbc3f-dbb8-4ccc-8eb6-43554327984b@paulmck-laptop>
 <5ef329fe-1f3b-4d81-9625-9738620f051e@I-love.SAKURA.ne.jp>
 <87r0lq3j2t.ffs@tglx>
 <2c822e13-775c-4e55-bf2f-152dbca0c910@I-love.SAKURA.ne.jp>
 <83c9317a-b1d2-4741-b955-98e7cd23595c@paulmck-laptop>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <83c9317a-b1d2-4741-b955-98e7cd23595c@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/10/20 12:30, Paul E. McKenney wrote:
> A bit of a long shot, but given your earlier console log, could you
> please try Frederic's patches?
> 
> https://lore.kernel.org/lkml/20231019233543.1243121-1-frederic@kernel.org/

Didn't make difference.



I booted another Ubuntu kernel used by installation ISO image, and found no problem.
Maybe the only way to narrow down is to build various kernel configurations?

ubuntu-23.10-live-server-amd64.iso
[    0.000000] Linux version 6.5.0-9-generic (buildd@bos03-amd64-043) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0, GNU ld (GNU Binutils for Ubuntu) 2.41) #9-Ubuntu SMP PREEMPT_DYNAMIC Sat Oct  7 01:35:40 UTC 2023 (Ubuntu 6.5.0-9.9-generic 6.5.3)
[    0.000000] Command line: BOOT_IMAGE=/casper/vmlinuz console=ttyS0,115200n8 console=tty0 ---
(...snipped...)
[    0.896948] smp: Bringing up secondary CPUs ...
[    0.899571] smpboot: x86: Booting SMP configuration:
[    0.901912] .... node  #0, CPUs:      #1 #2 #3 #4 #5 #6 #7
[    0.914558] TSC synchronization [CPU#0 -> CPU#1]:
[    0.916496] Measured 62205 cycles TSC warp between CPUs, turning off TSC clock.
[    0.916496] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    0.940504] smp: Brought up 1 node, 8 CPUs
[    0.944498] smpboot: Max logical packages: 1
[    0.946468] smpboot: Total of 8 processors activated (41779.32 BogoMIPS)

