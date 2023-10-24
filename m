Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A50A7D5755
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbjJXQF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjJXQFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:05:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FA2B0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:05:19 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-53fc7c67a41so9274124a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 09:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698163518; x=1698768318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7pvsrCldZsO9TMcTvU6XWjlimLS42QXUZs+42Nhc1U=;
        b=Us4nOkTHGkiflv4TvFr51yb9R57Iz+tZ1CDdhlDC3xYpjoehUgHqVETeiUS7bSXd0O
         uwYRunMp3wT4vKQ5KB76LDGsQxPHHefHGagiWTj5LQCJjC3A5V0lsgjAQVX8qcUXiaz5
         kTd/x2dZu39U8+ZUT2OHufABMfI3jxEXS4TshgGK9D+hm5zvnBWYwVDNGRekLiuul/I2
         2ZKgQX+0d5Bve4xGZOqmmX0ewVnXfCPjLI7BPOjdaf3uOLF4enGmdvOU++MgQW5jNxu4
         OdXEp3GuMIO9D6ZKWbhJZJGfUjaZb5WaLKNN6EI7ZNG6wLFMPnr2AMS5IS8y4cSAlQmB
         zIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163518; x=1698768318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7pvsrCldZsO9TMcTvU6XWjlimLS42QXUZs+42Nhc1U=;
        b=TvFJQ6QjmSsNxJ8dIpovt40FlGGYK0i4WkN9ki8CLIgoj9fNStW127QCWGdSOWFCnq
         N08cCI6svWdubeuQgzgmDeSRqiN4+cK/bnae/MJzSnYzag9q9qG/GqmpstuFArZg0mF/
         bCt05sJfesq7/04ue0cwvpHnhTBIgu0kO95UXkhnURgsI3YvklH9Kv3TZ8eJjFiEJEEg
         /Cwe1IuQtofzBn9I6T+ttW2lDaqj5VFIw/Cz2Zv236nmXiv8aiBCsoj2eDIXcN0O0H74
         XlRL/pVj/Xgrj3X+gxfumln6FyrCK17GNWOK1VGw5FSGJ5zRUt4xNPs0nS+5i0HmWKHg
         8W+w==
X-Gm-Message-State: AOJu0YznObOdg2nezZgKmHirtBtcudjR+4W8vjUjvogv7IhINKab2pm5
        ypd1fKIxwNpQ6lxVevTE7oWHbTH5OelCm1TTdfM=
X-Google-Smtp-Source: AGHT+IHThZ8v4kObnfO5jBQYkVRF24JSbUrO9qNLXiDZs84XJalGjTp5chqf4LSOHFRgbz3139EayJey1hJKDKEEVUE=
X-Received: by 2002:a50:fc07:0:b0:53e:5c4d:ba15 with SMTP id
 i7-20020a50fc07000000b0053e5c4dba15mr14673739edr.8.1698163517781; Tue, 24 Oct
 2023 09:05:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231024142830.3226-1-ubizjak@gmail.com> <20231024155629.GGZTfpLdLyol1+FP4/@fat_crate.local>
In-Reply-To: <20231024155629.GGZTfpLdLyol1+FP4/@fat_crate.local>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 24 Oct 2023 18:05:06 +0200
Message-ID: <CAFULd4anCehMUeAjanZyxLz+w5spvnrdUhjg0wRTv5sopHt0ag@mail.gmail.com>
Subject: Re: [PATCH] x86/percpu: Return correct variable from current_top_of_stack()
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 5:56=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Tue, Oct 24, 2023 at 04:28:14PM +0200, Uros Bizjak wrote:
> > current_top_of_stack() should return variable from _seg_gs
> > qualified named address space when CONFIG_USE_X86_SEG_SUPPORT
> > is enbled.
>
> I presume you're sending those two in order to fix stuff like the splat
> below which fires in my guest with latest Linus + latest tip/master
> lineup.

Yes, the first one is the fix, the second one is only tangentially
related to the fix.

> Because disabling CONFIG_USE_X86_SEG_SUPPORT fixes it.
>
> I'm wondering that close to the merge window whether we should delay
> all that new and fancy percpu stuff one more round until it is tested
> more widely...

The percpu stuff won't be merged for 6.7, it will have to sit out until 6.8=
.

Thanks,
Uros.


>
> [    1.623994] kprobes: kprobe jump-optimization is enabled. All kprobes =
are optimized if possible.
> [    1.627398] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pa=
ges
> [    1.627101] BUG: unable to handle page fault for address: 000000000002=
f0d8
> [    1.629645] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB pag=
e
> [    1.628158] #PF: supervisor read access in kernel mode
> [    1.628161] #PF: error_code(0x0000) - not-present page
> [    1.628163] PGD 0 P4D 0
> [    1.628167] Oops: 0000 [#1] PREEMPT SMP
> [    1.628171] CPU: 1 PID: 10 Comm: kworker/u32:0 Not tainted 6.6.0-rc7+ =
#1
> [    1.631566] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pa=
ges
> [    1.629156] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.15.0-1 04/01/2014
> [    1.632494] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
> [    1.629990] Workqueue: ftrace_check_wq ftrace_check_work_func
> [    1.631041] RIP: 0010:raw_irqentry_exit_cond_resched+0x16/0x50
> [    1.631041] Code: 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 9=
0 90 90 f3 0f 1e fa 0f 1f 44 00 00 65 f7 05 d4 ff ef 7e ff ff ff 7f 75 21 <=
48> 8b 05 db ff ef 7e 48 29 e0 48 3d ff 3f 00 00 77 19 65 48 8b 05
> [    1.631041] RSP: 0018:ffffc9000005bab8 EFLAGS: 00010046
> [    1.631041] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000=
002f900
> [    1.631041] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffc9000=
005bac8
> [    1.631041] RBP: 0000000000000000 R08: 0000000000000002 R09: 000000000=
0000001
> [    1.631041] R10: 0000000000000000 R11: 0000000000000001 R12: 000000000=
0000000
> [    1.631041] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [    1.631041] FS:  0000000000000000(0000) GS:ffff88807da40000(0000) knlG=
S:0000000000000000
> [    1.631041] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    1.631041] CR2: 000000000002f0d8 CR3: 0000000002416000 CR4: 000000000=
03506f0
> [    1.631041] Call Trace:
> [    1.631041]  <TASK>
> [    1.631041]  ? __die+0x31/0x80
> [    1.631041]  ? page_fault_oops+0x160/0x440
> [    1.631041]  ? exc_page_fault+0x74/0x150
> [    1.631041]  ? asm_exc_page_fault+0x26/0x30
> [    1.631041]  ? raw_irqentry_exit_cond_resched+0x16/0x50
> [    1.631041]  irqentry_exit+0x21/0x60
> [    1.631041]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [    1.631041] RIP: 0010:get_symbol_offset+0x26/0x60
> [    1.631041] Code: 90 90 90 90 0f 1f 44 00 00 48 89 f8 48 c1 e8 08 8b 0=
4 85 80 4f 0b 82 48 05 88 af f1 81 81 e7 ff 00 00 00 74 25 31 c9 0f b6 10 <=
84> d2 79 0e 0f b6 70 01 83 e2 7f c1 e6 07 09 f2 ff c2 ff c2 ff c1
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
