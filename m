Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863BF7C738A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379527AbjJLQz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjJLQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:55:21 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EAECA
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:55:20 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so2063528a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697129718; x=1697734518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epwmZ6Ja2wra9bxegb7w4CMuxnGf8xtXsXsf4Nf6hDE=;
        b=ZLuD2c3g8Dw5Ig1IuWwC1nhkNY+iX9MLqf3rIRijix6Q5sdyr4nkw6TM2LWIPeNIzq
         H1aITjQFxbd6sqkFztV91JHxKn4lOHBjoczQBOJMl6XzlFDk188QpP7Ma2m/AHnW+D8v
         hM2sIpE9SP8I8Q8hyka96HeCnEhWM1LzwaS7cp0rKAnGnRv98J2HjnACFPFwXigsrxfl
         LTdlZrcm2B/AV+IO7J4h+yExkNMcSUk4aYZuH5D1VQdxLzDnnWpQ0BaUlnbC0c8xBTPA
         +K3DrWB0BNuaZVoyNuaPcnMpFlly8q0ZcUH0Pxny7bLc5FL2aIqXnjqb4qE869pYOcWB
         KqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697129718; x=1697734518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epwmZ6Ja2wra9bxegb7w4CMuxnGf8xtXsXsf4Nf6hDE=;
        b=Lbj6/sB/RX0Lu49UZS2ajElXGu7NjFpIld/kSqyNQ8C9ed9UZrH5CjrmIkEBg8Mise
         3yybUt2DOmTO8532Yc82pAnHE/y0NAlOxEFxkCdxYBFU4p72GhdllgkJHmwNh48FA5Y0
         jTNthXxq/XedY8Umb4WZyIcXkAbuNPj5bbUqDUAOkp4rQb98iYTNQJZyMP0/Df0N7YLc
         xvwrc6GXqX8aJZ2uj0ZaiFcSFBjE8w9BZrSCDKt+5LfngfUh5WuUgZ/hbGYPW8PRGhRs
         lVSOcYZMpJmr96Qw4ruIsjk1yJNSFlWSPhZvLNKE4xH0waOOAuPHhtPHWJbzl4A6YN/h
         TZWA==
X-Gm-Message-State: AOJu0YwbipnmwwW8nmwD0xx2NVzUPWhs5Lvcuo+/H3SM+pcVmdCp9ORZ
        iTE49BNUqp4cJ7wqAaLFGimr0bIyziGu1zbE1Qo=
X-Google-Smtp-Source: AGHT+IEBvynBFbA2w0jd1l/UrQh64Fp/7JPG6pWRBJ+mDSfwO8S+O/PXXSoanLfKDmUG1S8ciSwszZ1W+0FnpeJeExI=
X-Received: by 2002:aa7:cd74:0:b0:52a:6497:d02b with SMTP id
 ca20-20020aa7cd74000000b0052a6497d02bmr22958463edb.16.1697129718405; Thu, 12
 Oct 2023 09:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
In-Reply-To: <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 18:55:06 +0200
Message-ID: <CAFULd4bBeMCBf5_VKWA8Ui=rhQtXf03zFUioq1DeQaYCfP8v=A@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Nadav Amit <namit@vmware.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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

On Thu, Oct 12, 2023 at 6:33=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> On Thu, Oct 12, 2023 at 5:19=E2=80=AFPM Nadav Amit <namit@vmware.com> wro=
te:
> >
> >
> > > On Oct 12, 2023, at 12:54 AM, Linus Torvalds <torvalds@linux-foundati=
on.org> wrote:
> > >
> > > !! External Email
> > >
> > > On Wed, 11 Oct 2023 at 14:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> > >>
> > >> Reading the above, it looks to me that we don't want to play games
> > >> with "const aliased" versions of current_task [1], as proposed by
> > >> Nadav in his patch series.
> > >
> > > Well, maybe I'd like it if I saw what the effect of it was, but that
> > > patch mentions "sync_mm_rss()" which doesn't actually exist
> > > (SPLIT_RSS_COUNTING is never defined, the split version is gone and
> > > hasn't existed since commit f1a7941243c1 "mm: convert mm's rss stats
> > > into percpu_counter")
> >
> > So I added a new version of the current aliasing (well, actually pcpu_h=
ot
> > in the new version) on top of Uros=E2=80=99s patches, and the effect ca=
n be seen
> > in many functions. I don=E2=80=99t want to bother with many examples so=
 here is
> > a common and simple one:
> >
> > Currently syscall_exit_work() that starts with:
> >
> >    0xffffffff8111e120 <+0>: push   %rbp
> >    0xffffffff8111e121 <+1>: mov    %rdi,%rbp
> >    0xffffffff8111e124 <+4>: push   %rbx
> >    0xffffffff8111e125 <+5>: mov    %rsi,%rbx
> >    0xffffffff8111e128 <+8>: and    $0x20,%esi
> >    0xffffffff8111e12b <+11>: je     0xffffffff8111e143 <syscall_exit_wo=
rk+35>
> >    0xffffffff8111e12d <+13>: mov    %gs:0x2ac80,%rax
> >    0xffffffff8111e136 <+22>: cmpb   $0x0,0x800(%rax)
> >    0xffffffff8111e13d <+29>: jne    0xffffffff8111e22a <syscall_exit_wo=
rk+266>
> >    0xffffffff8111e143 <+35>: mov    %gs:0x2ac80,%rax
> >    0xffffffff8111e14c <+44>: cmpq   $0x0,0x7c8(%rax)
> >
> > Using the const-alias changes the beginning of syscall_exit_work to:
> >
> >    0xffffffff8111cb80 <+0>: push   %r12
> >    0xffffffff8111cb82 <+2>: mov    %gs:0x7ef0e0f6(%rip),%r12        # 0=
x2ac80 <pcpu_hot>
> >    0xffffffff8111cb8a <+10>: push   %rbp
> >    0xffffffff8111cb8b <+11>: mov    %rdi,%rbp
> >    0xffffffff8111cb8e <+14>: push   %rbx
> >    0xffffffff8111cb8f <+15>: mov    %rsi,%rbx
> >    0xffffffff8111cb92 <+18>: and    $0x20,%esi
> >    0xffffffff8111cb95 <+21>: je     0xffffffff8111cba6 <syscall_exit_wo=
rk+38>
> >    0xffffffff8111cb97 <+23>: cmpb   $0x0,0x800(%r12)
> >    0xffffffff8111cba0 <+32>: jne    0xffffffff8111cc7a <syscall_exit_wo=
rk+250>
> >    0xffffffff8111cba6 <+38>: cmpq   $0x0,0x7c8(%r12)
> >
> > So we both see RIP-relative addressing is being used (hence the instruc=
tion is
> > one byte shorter) and the reload going away.
>
> Just a quick remark here:
>
> For some reason existing percpu_stable_op asm uses %P operand
> modifier. This will drop all syntax-specific prefixes and issue the
> bare constant. It will also remove the (%rip) suffix. What we want
> here is a generic %a modifier (See 6.47.2.8 Generic Operand Modifiers
> [1]) that will substitute a memory reference, with the actual operand
> treated as the address. In combination with "p" constraint will DTRT
> and will emit symbol with the (%rip) suffix when available, also when
> -fpie is in effect.

An example:

--cut here--
int m;

int foo (void)
{
  asm ("# %0 %P0 %a0" :: "p" (&m));
}
--cut here--

gcc -O2 -S:

       # $m m m(%rip)

gcc -O2 -fpie -S:

       # $m m m(%rip)

gcc -O2 -m32 -S:

       # $m m m

Uros.
