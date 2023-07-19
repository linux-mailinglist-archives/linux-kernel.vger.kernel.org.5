Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C66759E26
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGSTEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjGSTEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:04:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4E6C171E;
        Wed, 19 Jul 2023 12:04:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b89b75dc1cso7937325ad.1;
        Wed, 19 Jul 2023 12:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689793445; x=1690398245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLH+6Zz46LlJzl1i1yA09JxIas5O/oPOUZyhI4T7mFI=;
        b=n5b0q4Xn3rg53RrIdrTmMhLjm42HpNeM5NZdvruufDwj9or//t8d4CHm2YacGw7iZU
         Wga0aCISIPVVF5R+se/leWL3Ja8VaGzqyVaZhYnwMd6f02eB7MnwP7a9v9zHru0F2wXt
         PbITzYEvfPXjmuTIrT2BKVso2Bzw1vprxt+sDtvA2xqoXZDJE8gFrLMtjzASDPb7uhmp
         AmNigSmoRe0YVkvnA+bd8ShGJVApCQAVstcKXJF6yRq2YIX+ZKhg5e8U/wsdK4bh2szi
         Ih6+LEqtaEGkJFrf/8vQvuIMhoD22/TGAKGOjYNLFzhjgcBohgrqb9VS0gbRc/CW3ScO
         LbhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689793445; x=1690398245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLH+6Zz46LlJzl1i1yA09JxIas5O/oPOUZyhI4T7mFI=;
        b=ZDJGPpiNxr5RMklhJj4MJOVKjqFW3RF9PUDtWLycFkq7jgF6FqQxQ9kEzGG+DNZTuH
         6zs+yj88dH0ZTC50O2s+e6KzW+IX61YRpB6I+Qq7rmW9GQIewRYIo8bpQaSifCsXAz7o
         hh1qcS3gpjbNlvkw5D9FjnN5KGBMxmpQ2duGlug0hhcWQFR/R+93k1EKXNL/OyPfd0yQ
         ttKBy7YSkWklDVevi3kaNkKmf/d7vZB1I5xH+Fzz9JvtnXomcSHB1XB4BJlG67vIBHTb
         MnF/6HX9TpvnpybFiPfci9hY+3rzV0hcje2JZ8wQ7h87b7U3nAWJu9ZM7brIW+xyf8XY
         PK9A==
X-Gm-Message-State: ABy/qLauN7VCPnPvXRdPzLEspf8ZkE0bAb+1PxWfVhy33jr/pVBDWUX9
        Q015BQdf4LAsQ/aG2VzWShektdvqt1ognYa9iMw=
X-Google-Smtp-Source: APBJJlEobVKQwUTZELYFREJLzp3dv1g8/xLG9BPAiuSNXxuLtHGl8yz3eCa/ZDI+C4ZHXNQZAEXv3s/CnHI35Wlbb/U=
X-Received: by 2002:a17:90a:8902:b0:25e:fb6d:ce68 with SMTP id
 u2-20020a17090a890200b0025efb6dce68mr4042609pjn.6.1689793445006; Wed, 19 Jul
 2023 12:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <60f88589-5f9f-4221-82f9-5c9c11fb5d95@paulmck-laptop>
In-Reply-To: <60f88589-5f9f-4221-82f9-5c9c11fb5d95@paulmck-laptop>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Thu, 20 Jul 2023 03:03:53 +0800
Message-ID: <CAABZP2xAi0FdEjmSV-DU_Pefk=Jya=XvL0OwDQspKg-jnq_fLQ@mail.gmail.com>
Subject: Re: [BUG] unable to handle page fault for address
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        akaher@vmware.com, shuah@kernel.org, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 1:40=E2=80=AFAM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> Hello!
>
> Just FYI for the moment, I hit a BUG in 10-hour overnight qemu/KVM-based
> rcutorture testing of the TASKS01, TASKS03, TREE03, and TREE07 rcutorture
> on the mainline commit:
>
> ccff6d117d8d ("Merge tag 'perf-tools-fixes-for-v6.5-1-2023-07-18' of git:=
//git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools")
>
> This commit was merged with the -rcu "dev" branch, which just yesterday
> passes overnight tests when based on v6.5-rc1.  A web search got me the
> following, which is not a very close match, but the best that there is:
>
> https://www.spinics.net/lists/bpf/msg91848.html
>
> Here is a representative splat out of 29 of them:
>
> [22544.494701] BUG: unable to handle page fault for address: fffffe0000af=
0038
> [22544.496012] #PF: supervisor read access in user mode
> [22544.496985] #PF: error_code(0x0000) - not-present page
> [22544.497970] IDT: 0xfffffe0000000000 (limit=3D0xfff) GDT: 0xfffffe355b3=
fd000 (limit=3D0x7f)
> [22544.499479] LDTR: NULL
> [22544.499959] TR: 0x40 -- base=3D0xfffffe355b3ff000 limit=3D0x4087
> [22544.501073] PGD 1ffd2067 P4D 1ffd2067 PUD 1124067 PMD 0
> [22544.502149] Oops: 0000 [#1] PREEMPT SMP PTI
> [22544.502967] CPU: 0 PID: 1 Comm: init Not tainted 6.5.0-rc2-00128-g6805=
2f2f9e35 #5844
> [22544.504435] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [22544.506581] RIP: 0033:0x400181
> [22544.507256] Code: 00 45 31 d2 4c 8d 44 24 f0 48 c7 44 24 f8 00 00 00 0=
0 0f 05 b8 60 00 00 00 48 8d 7c 24 e0 0f 05 41 89 c0 85 c0 75 c6 44 89 c0 <=
89> c2 0f af d0 ff c0 48 63 d2 48 89 15 06 01 20 00 3d a0 86 01 00
> [22544.510954] RSP: 002b:00007ffde5192288 EFLAGS: 00010283
> [22544.511963] RAX: 000000000000ebe9 RBX: 0000000000000000 RCX: 000000000=
04001a7
> [22544.513386] RDX: ffffffffd963c240 RSI: 0000000000000000 RDI: 00007ffde=
5192258
> [22544.514751] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
> [22544.516079] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [22544.517452] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [22544.518818] FS:  0000000000000000 GS:  0000000000000000
> [22544.519864] Modules linked in:
> [22544.520653] CR2: fffffe0000af0038
> [22544.521401] ---[ end trace 0000000000000000 ]---
> [22544.522297] RIP: 0033:0x400181
> [22544.522887] RSP: 002b:00007ffde5192288 EFLAGS: 00010283
> [22544.523887] RAX: 000000000000ebe9 RBX: 0000000000000000 RCX: 000000000=
04001a7
> [22544.525257] RDX: ffffffffd963c240 RSI: 0000000000000000 RDI: 00007ffde=
5192258
> [22544.526623] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
> [22544.528016] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000000
> [22544.529439] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
> [22544.530909] FS:  0000000000000000(0000) GS:ffff8d101f400000(0000) knlG=
S:0000000000000000
> [22544.532564] CS:  0033 DS: 0000 ES: 0000 CR0: 0000000080050033
> [22544.533760] CR2: fffffe0000af0038 CR3: 0000000002d8e000 CR4: 000000000=
00006f0
> [22544.535286] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [22544.536738] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [22544.538228] note: init[1] exited with irqs disabled
> [22544.540087] Kernel panic - not syncing: Attempted to kill init! exitco=
de=3D0x00000009
> [22544.544806] Kernel Offset: 0x9600000 from 0xffffffff81000000 (relocati=
on range: 0xffffffff80000000-0xffffffffbfffffff)
>
> The failure rates for each scenario are as follows:
>
> TASKS01: 13 of 15
> TASKS03: 7 of 15
> TREE03: 4 of 15
> TREE07: 5 of 15
>
> In other words, for TASKS01, there were 15 10-hour runs, and 13 of them
> hit this bug.
>
> Except that these failures were corellated:
>
> o       TASKS01 and TASKS03 failures are in batch 17 running on
>         kerneltest053.05.atn6.
>
> o       TREE03 and one of the TREE07 failures are in batch 4 running
>         on kerneltest025.05.atn6.
>
> o       Five of the TREE07 failures are in batch 6 running on
>         kerneltest010.05.atn6.
>
> All of the failures in a given batch happened at about the same time,
> suggesting a reaction to some stimulus from the host system.  There
> was no console output from any of these host systems during the test,
> other than the usual complaint about qemu having an executable stack.
>
> Now, perhaps this is hardware or configuration failure on those three
> systems.  But I have been using them for quite some time, and so why
> would three fail at the same time?
>
> Bisection will not be easy given that there were only three actual
> failures in ten hours over 20 batches.  If this is in fact a random
> kernel failure, there would be almost a 4% chance of a false positive
> on each bisection step, which gives about a 50% chance of bisecting to
> the wrong place if the usual 16 steps are required.
Hi Paul
I am also very interested in tracing this bug.
I have invoked ./tools/testing/selftests/rcutorture/bin/torture.sh on
my 16 core Intel(R) Xeon(R) CPU E5-2660 server a moment ago to see
what happens
Thanx, Zhouyi
>
> I will give this another try this evening, Pacific Time.  In the
> meantime, FYI.
>
>                                                 Thanx, Paul
