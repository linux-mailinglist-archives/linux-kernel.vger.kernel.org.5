Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B202D7E7FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjKJSAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbjKJR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:59:17 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B2E7D88
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 22:45:01 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc79f73e58so312135ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 22:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699598700; x=1700203500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1gTqrJKHlb0DQZEnTZIMK5A0G74ZbPPA6krp64Uv1U=;
        b=YBaov/6/Z7ts06bOFke54tdbMkFCQXJ2HZrEVDpKvvcqdYKhNuHA0nSFawgDzyLLmI
         cjgJeKah6hyL8RqSMdoK+qtZKI72tDm/n1E7TPsj1zstlFAldKODrewJPk+iLYiqyfuL
         2PVK9Qq/K6cdSTddT2OEKpfNKkwyKfsqw7HzJEd9v6F7vpLvK48Q5rhrY4hPdWil/Vo0
         JAucgIZaxYe4Gy0nvd4D8zJn6Goav6ZBlXmuv+zNqu8RP9CoXbjEL6+KLOcdRUrQBIEO
         416ewJRC0VIUOjFAutghxFEu7eVIyguJ0pUdl4bJvG5bt+kJz1/cq39toOAlDm8sScKj
         8F3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699598700; x=1700203500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1gTqrJKHlb0DQZEnTZIMK5A0G74ZbPPA6krp64Uv1U=;
        b=b4/HlfAFLnRqoaPUHI7qF/kWGlg0dp2Z+Q9uG+YtGHGouh16YAPfMwyHh5BtV+46kN
         Naz0+GzPuRBNz2RccU2PVwimp2cRLvXXBhGYok4t4/VQ2zGcCknEeKEyJA06jiFPIpVZ
         i7b3bk+yJAPBhg6kF8SYur+2b2mTS8JMBMjxOSOcUE6q/+mzjlV9mI4vqT8mymUVqIrL
         m430ERmT2Q/sj//vHNRCtJ+oRmpoWimz8rekzDW2u17mPoSNJ9mxHAIlsHhkQAGdXwVg
         HRyGS5tfPBrq4OqN1K/1C7EbjTQmg9vcQhZyp9NlyjXoVfRVbcU9FGFJ7mN9/7swoBKy
         kD6A==
X-Gm-Message-State: AOJu0Yyy9r+0h+lOBzoMXaIE2z0kAh0IE9fhNzRhWwfL6vrXMVT9ag88
        SfOlYETtWKBYfAB3OqhjMk2y+zrYrO3qQLGQ5Hz7SMuZ6cTXK2B6A40KS5jA
X-Google-Smtp-Source: AGHT+IFfJqPrd41UFTHcJYQAfbj7mIw6bg8DwFRN5S/STX1gsKnTCPU/T443l/TfVXIpwH1zvFQDYoS9WL1D7NKTe0Y=
X-Received: by 2002:a17:902:f688:b0:1bb:2c7b:6d67 with SMTP id
 l8-20020a170902f68800b001bb2c7b6d67mr475537plg.11.1699592431687; Thu, 09 Nov
 2023 21:00:31 -0800 (PST)
MIME-Version: 1.0
References: <000000000000cfd180060910a687@google.com> <875y2lmxys.ffs@tglx>
 <CANp29Y7EQ0cLf23coqFLLRHbA5rJjq0q1-6G7nnhxqBOUA7apw@mail.gmail.com> <87r0l8kv1s.ffs@tglx>
In-Reply-To: <87r0l8kv1s.ffs@tglx>
From:   Aleksandr Nogikh <nogikh@google.com>
Date:   Thu, 9 Nov 2023 21:00:18 -0800
Message-ID: <CANp29Y5BnnYBauXyHmUKrgrn5LZpz8nDuZFTwLLB7WHq4DS6Wg@mail.gmail.com>
Subject: Re: [syzbot] [ext4?] general protection fault in hrtimer_nanosleep
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     syzbot <syzbot+b408cd9b40ec25380ee1@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 2, 2023 at 8:57=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Thu, Nov 02 2023 at 13:08, Aleksandr Nogikh wrote:
> > On Wed, Nov 1, 2023 at 1:58=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
> >> Unfortunately repro.syz does not hold up to its name and refuses to
> >> reproduce.
> >
> > For me, on a locally built kernel (gcc 13.2.0) it didn't work either.
> >
> > But, interestingly, it does reproduce using the syzbot-built kernel
> > shared via the "Downloadable assets" [1] in the original report. The
> > repro crashed the kernel in ~1 minute.
> >
> > [1] https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.=
md
> >
> > [  125.919060][    C0] BUG: KASAN: stack-out-of-bounds in rb_next+0x10a=
/0x130
> > [  125.921169][    C0] Read of size 8 at addr ffffc900048e7c60 by task
> > kworker/0:1/9
> > [  125.923235][    C0]
> > [  125.923243][    C0] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted
> > 6.6.0-rc7-syzkaller-00142-g888cf78c29e2 #0
> > [  125.924546][    C0] Hardware name: QEMU Standard PC (Q35 + ICH9,
> > 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > [  125.926915][    C0] Workqueue: events nsim_dev_trap_report_work
> > [  125.929333][    C0]
> > [  125.929341][    C0] Call Trace:
> > [  125.929350][    C0]  <IRQ>
> > [  125.929356][    C0]  dump_stack_lvl+0xd9/0x1b0
> > [  125.931302][    C0]  print_report+0xc4/0x620
> > [  125.932115][    C0]  ? __virt_addr_valid+0x5e/0x2d0
> > [  125.933194][    C0]  kasan_report+0xda/0x110
> > [  125.934814][    C0]  ? rb_next+0x10a/0x130
> > [  125.936521][    C0]  ? rb_next+0x10a/0x130
> > [  125.936544][    C0]  rb_next+0x10a/0x130
> > [  125.936565][    C0]  timerqueue_del+0xd4/0x140
> > [  125.936590][    C0]  __remove_hrtimer+0x99/0x290
> > [  125.936613][    C0]  __hrtimer_run_queues+0x55b/0xc10
> > [  125.936638][    C0]  ? enqueue_hrtimer+0x310/0x310
> > [  125.936659][    C0]  ? ktime_get_update_offsets_now+0x3bc/0x610
> > [  125.936688][    C0]  hrtimer_interrupt+0x31b/0x800
> > [  125.936715][    C0]  __sysvec_apic_timer_interrupt+0x105/0x3f0
> > [  125.936737][    C0]  sysvec_apic_timer_interrupt+0x8e/0xc0
> > [  125.936755][    C0]  </IRQ>
> > [  125.936759][    C0]  <TASK>
>
> Which is a completely different failure mode.
>
> It explodes in the hrtimer interrupt when dequeuing an hrtimer for
> expiry. That means the corresponding embedded rb_node is corrupted,
> which points to random data corruption.
>
> As you can reproduce (it still fails here with the provided assets),
> does the failure change when you run it several times?

Hmm, it's weird. Maybe I was very lucky that time.

The reproducer does work on the attached disk image, but definitely
not very often. I've just run it 10 times or so and got interleaved
BUG/KFENCE bug reports like this (twice):
https://pastebin.com/W0TkRsnw

These seem to be related to ext4 rather than hrtimers though.

--=20
Aleksandr

>
> Thanks,
>
>         tglx
