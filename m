Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4A37CD77F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjJRJFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjJRJFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:05:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33681A8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:04:44 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53db1fbee70so11093314a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697619883; x=1698224683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv5F7dGP7j+jLMtqoC4a5nyXaVdDwBEDiJlcjO2wKPk=;
        b=PQ3MqjF+ZSsthp82bS5xtBcsyRalZIKpZOjNdqYpkVVTTdyuRYDEW5HBXA/m59pXU3
         JTiIQN4XCy8km+kiKWmnWHoPBFcHqBoM9S3SzgL9EA51narKQ5PFd15BPMVVo9uHcz/z
         b7oW3PtzrU5uMgv2WdzBfITBhfZZWCYnLFnbUGOUAQVaSE4kuFRgcYDVlJ204G5VYg14
         9QTybCkSMevAduZf7GHvNiFvhuYCwuSfUxga9hYmuj4gYXuvwS4OXi/vTlf/9q0TuTMA
         FTWOOQSMrR3RTDO9dc1a0OvXW0+jsQolSNecr6pjYQUIbKpYVFBzUb3ScQdJT12LcCRg
         JjcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697619883; x=1698224683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dv5F7dGP7j+jLMtqoC4a5nyXaVdDwBEDiJlcjO2wKPk=;
        b=b1W2rHpG4WSv2QeCa3jA+hWarQpRdGg5A5K6er1qq9DN7XBG3vOTZqdN4rleIJmxbl
         /vJU0yd5r50aSaVtDMMwQm3hy3yQsBtLiljgK7RgkvsLJdpAZap3VED826VkWQigKsp8
         W7cz/gVxy7I5CMjQ9fBj6A/rCRj/Gkk8+sSbYpfJ2P/ocV3/9gSV2mH9Z0I/RvX5+Chu
         wSa0LrvftzQ8fSl3uuqsGsY9+uCoPUF2/qLLRLtO1GGtLl5/1ElFI6Mg/d50GXO1bvXR
         JuWztw6HbXE0YjZWjAlUMdE0UH1iEgMBZkyzoeADbGkcD1ihjJCYJctzIY/khPmZf24F
         tSPg==
X-Gm-Message-State: AOJu0YyxXbiaeFenpdDAdmcLyCZUwhy5gzxgtbJ2KPy5Onjiaagw1gm5
        FOhqA6T0Aq6fY1Xx6xRx9nM++GkrsTLeqlj4F94=
X-Google-Smtp-Source: AGHT+IEQWO2B3NE4J6cT10TbkI9THuSMx7Y8eL4w/lL3VcRp4U6Qg5K0ZKx3ye05J60yuYV+DHqqD0eg4XQ67vg4niQ=
X-Received: by 2002:a50:c34f:0:b0:53d:f073:587c with SMTP id
 q15-20020a50c34f000000b0053df073587cmr4217572edb.0.1697619882701; Wed, 18 Oct
 2023 02:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com> <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
In-Reply-To: <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Wed, 18 Oct 2023 11:04:30 +0200
Message-ID: <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, Oct 18, 2023 at 9:46=E2=80=AFAM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Tue, Oct 17, 2023 at 11:53=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Tue, 17 Oct 2023 at 14:06, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >
> > > But adding the attached patch on top of both patches boots OK.
> >
> > Funky.
> >
> > Mind adding a
> >
> >         WARN_ON_ONCE(!active_mm);
> >
> > to there to give a nice backtrace for the odd NULL case.
>
> [    4.907840] Call Trace:
> [    4.908909]  <TASK>
> [    4.909858]  ? __warn+0x7b/0x120
> [    4.911108]  ? begin_new_exec+0x90f/0xa30
> [    4.912602]  ? report_bug+0x164/0x190
> [    4.913929]  ? handle_bug+0x3c/0x70
> [    4.915179]  ? exc_invalid_op+0x17/0x70
> [    4.916569]  ? asm_exc_invalid_op+0x1a/0x20
> [    4.917969]  ? begin_new_exec+0x90f/0xa30
> [    4.919303]  ? begin_new_exec+0x3ce/0xa30
> [    4.920667]  ? load_elf_phdrs+0x67/0xb0
> [    4.921935]  load_elf_binary+0x2bb/0x1770
> [    4.923262]  ? __kernel_read+0x136/0x2d0
> [    4.924563]  bprm_execve+0x277/0x630
> [    4.925703]  kernel_execve+0x145/0x1a0
> [    4.926890]  call_usermodehelper_exec_async+0xcb/0x180
> [    4.928408]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
> [    4.930515]  ret_from_fork+0x2f/0x50
> [    4.931894]  ? __pfx_call_usermodehelper_exec_async+0x10/0x10
> [    4.933941]  ret_from_fork_asm+0x1b/0x30
> [    4.935371]  </TASK>
> [    4.936212] ---[ end trace 0000000000000000 ]---
>
> >
> > That code *is* related to 'current', in how we do
> >
> >         tsk =3D current;
> > ...
> >         local_irq_disable();
> >         active_mm =3D tsk->active_mm;
> >         tsk->active_mm =3D mm;
> >         tsk->mm =3D mm;
> > ...
> >         activate_mm(active_mm, mm);
> > ...
> >         mmdrop_lazy_tlb(active_mm);
> >
> > but I don't see how 'active_mm' could *poossibly* be validly NULL
> > here, and why caching 'current' would matter and change it.
>
> I have also added "__attribute__((optimize(0)))" to exec_mmap() to
> weed out compiler bugs. The result was the same oops in
> mmdrop_lazy_tlb.
>
> Also, when using WARN_ON instead of WARN_ON_ONCE, it triggers only
> once during the whole boot, with the above trace.
>
> Another observation: adding WARN_ON to the top of exec_mmap:
>
>     WARN_ON(!current->active_mm);
>     /* Notify parent that we're no longer interested in the old VM */
>     tsk =3D current;
>     old_mm =3D current->mm;
>
> also triggers WARN, suggesting that current does not have active_mm
> set on the entry to the function.

Solved.

All that is needed is to patch cpu_init() from
arch/x86/kernel/cpu/common.c with:

--cut here--
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index b14fc8c1c953..61b6fcdf6937 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2228,7 +2232,7 @@ void cpu_init_exception_handling(void)
 */
void cpu_init(void)
{
-       struct task_struct *cur =3D current;
+       struct task_struct *cur =3D this_cpu_read_stable(pcpu_hot.current_t=
ask);
       int cpu =3D raw_smp_processor_id();

#ifdef CONFIG_NUMA
--cut here--

This is effectively the old  get_current(). Since we declare and export

+DECLARE_PER_CPU_ALIGNED(const struct pcpu_hot __percpu_seg_override,
+                       const_pcpu_hot) __attribute__((alias("pcpu_hot")));
+EXPORT_PER_CPU_SYMBOL(const_pcpu_hot);

in the same file, and the "new" current represents just

return const_pcpu_hot.current_task;

GCC assumes and over-optimizes something and seemingly doesn't fully
initialize the

    cur->active_mm =3D &init_mm;

below.

Have to run now, but this will be easy to fix.

Uros.
