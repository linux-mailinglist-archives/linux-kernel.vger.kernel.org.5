Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2DBF7E776A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 03:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345724AbjKJC13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 21:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjKJC12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 21:27:28 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9FA420B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 18:27:26 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6ce2de8da87so902283a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 18:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699583245; x=1700188045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ql92P/EuYcnEEYYSTySCu4NowZkVuoLt5otzMxHlFzI=;
        b=ZWCbdJ/vDCFhbivIfbrhtXXsV4sBcr0+cG3qr2NHcNbLFUBmh6kVGp89YjPEEjnrf4
         uGDvseTJbMP4A1fq39JDP2ZQYMXl3lzRrVPn6wz74jMUTT+TVdsELUy5hrOlosnnXysg
         KaKF2RuzEjS4VSL47e52YY6R6gL0mEPm6zTv27mc5Hr0chGHLwrig0JMTiMc4LeG8pph
         JZuHYLLqFhZXfnX410PTNH7yaFyawbA7b/gqV47bnUODx0xTULvfw1bJVOAPg7CC8CbY
         BEcgZIk9Q4zPI6/0fyaadALue4wIvbEHbSsgt6JFiGsH3BM5O4XKPhEWdpr1VqhZkETM
         BwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699583245; x=1700188045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql92P/EuYcnEEYYSTySCu4NowZkVuoLt5otzMxHlFzI=;
        b=tvDbSUlfE3yAal3xTf9TLL1Xe3xfA9ILHStUOOaIM7qnku5HpcsD2Q7+ULWchlAfHN
         eCwFE4z4FhPctUZpzDbx/TfHxvr7UOxyikaRMNRjDEgsnrhStOQlXsc7HealWakXWURR
         PX9dY17ay0ELD//Fggow3/5fY4VM0Y7inOb/VmA/QfDUouBzgqI9xVMQ6N6HNJtt7zVb
         SlTEAyVzv7QIOZi88LEc6fZYS2Ikf4IdWaRIzh7i8NTtm4RBdQ4ekvmOvh0rmzXCjIIk
         qZll54rcZqehS/14FSGCIm6i/Trvktb49IVbQyNwa2Pcmps84tWazpV7AbZxOm2OpATZ
         kuKA==
X-Gm-Message-State: AOJu0YyR8eekNPRbkZnNlpqzYy1PairtF5JNuFzQxqqcgxgoRlMWtjxq
        vZwWcTwocAiYgk0beqiar5Q=
X-Google-Smtp-Source: AGHT+IFx1BvGyyC2EexgWUs0DroT9ijXQrcXt307fCWNN9vk56peYKTLmTMhCCsCxtP9XRLbVXgvAg==
X-Received: by 2002:a05:6870:c90c:b0:1ef:c637:2688 with SMTP id hj12-20020a056870c90c00b001efc6372688mr8164934oab.8.1699583245280;
        Thu, 09 Nov 2023 18:27:25 -0800 (PST)
Received: from localhost ([107.155.12.245])
        by smtp.gmail.com with ESMTPSA id c4-20020aa78c04000000b00688c733fe92sm11353014pfd.215.2023.11.09.18.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 18:27:24 -0800 (PST)
Date:   Fri, 10 Nov 2023 10:27:20 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     axboe@kernel.dk, keescook@chromium.org, akpm@linux-foundation.org,
        mcgrof@kernel.org, ebiederm@xmission.com, jannh@google.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exit: dump thread info on global init exit
Message-ID: <20231110022720.GA3087@rlk>
References: <20231108081506.149016-1-qiwu.chen@transsion.com>
 <20231108095732.GA3678@redhat.com>
 <20231109071341.GA14505@rlk>
 <20231109110129.GB12330@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109110129.GB12330@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 12:01:30PM +0100, Oleg Nesterov wrote:
> I've just noticed we discuss this offlist. Add lkml...
> 
> On 11/09, chenqiwu wrote:
> >
> > On Wed, Nov 08, 2023 at 10:57:32AM +0100, Oleg Nesterov wrote:
> >
> > > > +	if (mmap_read_lock_killable(mm)) {
> > >
> > > why do you need _killable ?
> > >
> > I'm not sure which type lock (killable or unkillable) should be used here
> 
> killable should be used to allow to kill the task which waits for this lock.
> Who can kill the global init? Yes it is possible (but very unlikely) that
> fatal_signal_pending() is true, but I don't think this was your concern.
> 
> > if there is a lock contention, perhaps using down_read_trylock is better.
> 
> Perhaps. If we have another bug mmap_read_lock() can hang forever.
> 
Yes, but we really don't want to hang here forever if we cannot get the mmap read
lock. I think using down_read_trylock should be better, I wiil resend the patch as
V2 cc LKML to discuss the thing.

> > > > +static void dump_thread_info(struct task_struct *tsk)
> > > > +{
> > > > +	struct pt_regs *regs = task_pt_regs(tsk);
> > > > +
> > > > +	if (user_mode(regs))
> > > > +		dump_thread_maps_info(tsk);
> > > > +	show_regs(regs);
> > >
> > > This looks confusing to me...
> > >
> > > How can user_mode() return false in this case? And even if this is
> > > possible, then show_regs() should depend on user_mode() as well?
> > > I must have missed something.
> > >
> > Sure, the last global init thread cannot be exited in non-user mode.
> 
> Forgot to mention... panic() should dump the regs, so I think show_regs()
> is not needed?
> 
In fact, panic don't dump the regs. For example, the current kill init panic log from Andriod system:
[ 4.706445][T400001] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00007f0000
[ 4.706459][T400001] CPU: 4 PID: 1 Comm: init Tainted: G S W 5.10.136-android12-9-00005-gf9a66cbe7091-ab9177899 #1
[ 4.706464][T400001] Hardware name: MTxxxx/TCZA (DT)
[ 4.706469][T400001] Call trace:
[ 4.706482][T400001] dump_backtrace.cfi_jt+0x0/0x8
[ 4.706493][T400001] dump_stack_lvl+0xc4/0x140
[ 4.706504][T400001] panic+0x178/0x464
[ 4.706511][T400001] do_exit+0xb30/0xf9c
[ 4.706517][T400001] do_group_exit+0x130/0x1c8
[ 4.706523][T400001] do_group_exit+0x0/0x1c8
[ 4.706529][T400001] __do_sys_exit_group+0x0/0x18
[ 4.706535][T400001] __se_sys_exit_group+0x0/0x14
[ 4.706543][T400001] el0_svc_common+0xd4/0x270
[ 4.706551][T400001] el0_svc+0x28/0x88
[ 4.706559][T400001] el0_sync_handler+0x8c/0xf0
[ 4.706567][T400001] el0_sync+0x1b4/0x1c0
[ 4.706576][T400001] SMP: stopping secondary CPUs

I try to create an NULL pointer in Andriod init code with my patch. From the test log,
we can see the user registers and decode pc/lr with section info easily:
[    4.535666] <6>.(6)[1:init]init-1: Dump maps info start
[    4.536327] <6>.(6)[1:init]5582f61000-558308e000 r-xp 000ab000 /system/bin/init
[    4.537252] <6>.(6)[1:init]7fa7001000-7fa7002000 r-xp 00001000 /system/lib64/libsquashfs_utils.so
[    4.538370] <6>.(6)[1:init]7fa7048000-7fa7066000 r-xp 00008000 /system/lib64/liblzma.so
[    4.539378] <6>.(6)[1:init]7fa7081000-7fa7082000 r-xp 00001000 /system/lib64/libpackagelistparser.so
[    4.540590] <6>.(6)[1:init]7fa70e3000-7fa7111000 r-xp 00023000 /system/lib64/libpcre2.so
[    4.541608] <6>.(6)[1:init]7fa7153000-7fa716f000 r-xp 00013000 /system/lib64/libjsoncpp.so
[    4.542644] <6>.(6)[1:init]7fa7182000-7fa7183000 r-xp 00002000 /system/lib64/libcgrouprc.so
[    4.543700] <6>.(6)[1:init]7fa71c4000-7fa71c8000 r-xp 00004000 /system/lib64/libsparse.so
[    4.544725] <6>.(6)[1:init]7fa7207000-7fa7212000 r-xp 00007000 /system/lib64/libfec.so
[    4.545719] <6>.(6)[1:init]7fa7241000-7fa7242000 r-xp 00001000 /system/lib64/libcrypto_utils.so
[    4.546809] <6>.(6)[1:init]7fa72d9000-7fa734c000 r-xp 00059000 /system/lib64/libcrypto.so
[    4.547848] <6>.(6)[1:init]7fa734c000-7fa7397000 --xp 000cc000 /system/lib64/libcrypto.so
[    4.548873] <6>.(6)[1:init]7fa7397000-7fa7399000 r-xp 00117000 /system/lib64/libbase.so
[    4.571715] <6>.(6)[1:init]7fa858a000-7fa85a3000 r-xp 0000a000 /system/lib64/libbacktrace.so
[    4.573583] <6>.(6)[1:init]7fa9897000-7fa997c000 r-xp 00037000 /system/bin/linker64
[    4.574543] <6>.(6)[1:init]init-1: Dump maps info end
[    4.575180] <6>.(6)[1:init]CPU: 6 PID: 1 Comm: init Tainted: G S      W         4.19.191-02983-ga8a102dc29ef-dirty #4
[    4.576516] <6>.(6)[1:init]Hardware name: MTxxxxV/CZ (DT)
[    4.577198] <6>.(6)[1:init]pstate: 60001000 (nZCv daif -PAN -UAO)
[    4.577962] <6>.(6)[1:init]pc : 0000005582fa54b4
[    4.578542] <6>.(6)[1:init]lr : 0000005582fa54b0
[    4.579123] <6>.(6)[1:init]sp : 0000007fd11ba7b0
[    4.579709] <6>.(6)[1:init]x29: 0000007fd11ba7c0 x28: 63726f662e746f6f
[    4.580540] <6>.(6)[1:init]x27: 0000007fa8712010 x26: 0000005582ed76e0
[    4.581371] <6>.(6)[1:init]x25: 6c616d726f6e5f65 x24: 6264696f72646e61
[    4.582201] <6>.(6)[1:init]x23: 313d746f6f625f6c x22: b400007eb700cdf7
[    4.583030] <6>.(6)[1:init]x21: 0000007fa8712010 x20: 0000000000000002
[    4.583867] <6>.(6)[1:init]x19: 0000007fa998b7f8 x18: 0000007fa8852000
[    4.584697] <6>.(6)[1:init]x17: 0000007fa743cb70 x16: 0000007fa7ea97d0
[    4.585528] <6>.(6)[1:init]x15: 0000000000000010 x14: 0000000000000000
[    4.586358] <6>.(6)[1:init]x13: 7265746e696f7020 x12: 0000fffffffff3ff
[    4.587187] <6>.(6)[1:init]x11: 000000000000000d x10: 0000000000000160
[    4.588025] <6>.(6)[1:init]x9 : 591ec1e81c3d3cdb x8 : 591ec1e81c3d3cdb
[    4.588855] <6>.(6)[1:init]x7 : 000000000000000a x6 : 000000000000000a
[    4.589686] <6>.(6)[1:init]x5 : 0000007fd11ba1e8 x4 : 0000000000000128
[    4.590516] <6>.(6)[1:init]x3 : 0000007fd11ba718 x2 : 0000007e5700c190
[    4.591345] <6>.(6)[1:init]x1 : 0000007fa74d87cc x0 : 0000007fa74d87cc
[    5.076262] <6>-(6)[1:init]Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000005
[    5.076262] <6>
[    5.077606] <6>-(6)[1:init]SMP: stopping secondary CPUs
[    5.087741] <6>-(6)[1:init]Kernel Offset: 0x2f87c00000 from 0xffffff8008000000
[    5.088647] <6>-(6)[1:init]PHYS_OFFSET: 0xffffffdd40000000
[    5.089336] <6>-(6)[1:init]Modules linked in:
[    5.094708] <6>-(6)[1:init]CPU: 6 PID: 1 Comm: init Tainted: G S      W         4.19.191-02983-ga8a102dc29ef-dirty #4
[    5.096037] <6>-(6)[1:init]Hardware name: MTxxxxV/CZ (DT)
[    5.096715] <6>-(6)[1:init]Call trace:
[    5.097191] <6>-(6)[1:init] dump_backtrace+0x0/0x158
[    5.097815] <6>-(6)[1:init] show_stack+0x14/0x1c
[    5.098398] <6>-(6)[1:init] dump_stack+0xb8/0xf0
[    5.098980] <6>-(6)[1:init] mrdump_common_die+0x170/0x214
[    5.099658] <6>-(6)[1:init] ipanic+0xa8/0xd4
[    5.100197] <6>-(6)[1:init] atomic_notifier_call_chain+0x4c/0x84
[    5.100952] <6>-(6)[1:init] panic+0x15c/0x2a0
[    5.101501] <6>-(6)[1:init] dump_thread_info+0x0/0x230
[    5.102146] <6>-(6)[1:init] do_group_exit+0x88/0x9c
[    5.102761] <6>-(6)[1:init] get_signal+0x7d0/0x980
[    5.103364] <6>-(6)[1:init] do_notify_resume+0x164/0x2448
[    5.104042] <6>-(6)[1:init] work_pending+0x8/0x10

Qiwu
