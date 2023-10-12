Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ECA7C731C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379497AbjJLQdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343912AbjJLQdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:33:39 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD58C0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:33:36 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507975d34e8so320200e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 09:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697128414; x=1697733214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLyH6yQ7oOXpP9deXgxc3Z6pkd3CfbHZ/Wfl0aSvuj0=;
        b=avpOyrpijl49x6OXB9leHSo/KS3iz3cILNKM8FSejNZrQfehuObNzCtaG36s74jQYr
         78+oQpZrN75QJv3r5HVKSR9CcRk+8ngBtRSvCyaR2ng5x/gozcllvsmrIrogw5HUpEqA
         Jg/cSCAz+CdioMCG0Ewxs3Nex6WUC7NjLfST/7j3dVyXpBb1YBZe5oFXK4j6DzS/1C9K
         +LYGld6k9xVE0T+aOSqV3XMSgw46nqMpzxBW2Jrq1XAkHgVJa24IUTZYvBoLuppdfmQP
         5I/QwB7+8Qa1CehzSUJQstROZbwapEP0FRtn0wCC2Mu39E36rwmnFsfOUCO7lq4CYn6S
         0KMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697128414; x=1697733214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLyH6yQ7oOXpP9deXgxc3Z6pkd3CfbHZ/Wfl0aSvuj0=;
        b=VOdPUvT6cJFlj7ubvZTb0nhtO0qwAXkHRlmWFs9FbV8VVTmuWUVeAPGhQS2ukl/Z+B
         B04W3rNUSfJUjKKp8y+n91yxD8eJMP/AFOYHXHAPYX5FFVI6f9SOHsLCEwYP3JRUAxq5
         pOIYfzA/g6ru1FYTj5vLvrMzbJJlLmX9Fdvdx6725oGRrO3AnSzrLEJmi+7aCe8/x4UD
         yAYQgFAimt+4Us0MstSZ8GB1pggDCftos2+KmGUqyLOpBFHf/SXJkdrP9ktnisGHuKPt
         y36t2o034eQ1TdnHtKkqApqrTvx9CNxcVlCO5ugSVFF0DVslfcYB7yAgSE+Ma+ndAVrP
         VLXg==
X-Gm-Message-State: AOJu0Yx5OVnGpDdUHeMh2Fg4FzYen2iRix4enSdWh6nMT9/BswBq77xe
        Kwrlc42/KqlDN/LQREPi6dpVuQmHzDhVq8vzGas=
X-Google-Smtp-Source: AGHT+IHBvaXreECltK9+IqA/KHLRTJ2l27nnFxnm8m2aOmpo+4SlKZEhJRYehBusH8I7Y4umXWzkNqhM5euxmKVUPmQ=
X-Received: by 2002:ac2:5e21:0:b0:502:ff3b:766f with SMTP id
 o1-20020ac25e21000000b00502ff3b766fmr17488538lfg.6.1697128414290; Thu, 12 Oct
 2023 09:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com> <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
In-Reply-To: <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Thu, 12 Oct 2023 18:33:22 +0200
Message-ID: <CAFULd4Zp-eDsxpStBznMHUE3OcHZ97NAZrZEjJW63oEFWtM3OQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 5:19=E2=80=AFPM Nadav Amit <namit@vmware.com> wrote=
:
>
>
> > On Oct 12, 2023, at 12:54 AM, Linus Torvalds <torvalds@linux-foundation=
.org> wrote:
> >
> > !! External Email
> >
> > On Wed, 11 Oct 2023 at 14:33, Uros Bizjak <ubizjak@gmail.com> wrote:
> >>
> >> Reading the above, it looks to me that we don't want to play games
> >> with "const aliased" versions of current_task [1], as proposed by
> >> Nadav in his patch series.
> >
> > Well, maybe I'd like it if I saw what the effect of it was, but that
> > patch mentions "sync_mm_rss()" which doesn't actually exist
> > (SPLIT_RSS_COUNTING is never defined, the split version is gone and
> > hasn't existed since commit f1a7941243c1 "mm: convert mm's rss stats
> > into percpu_counter")
>
> So I added a new version of the current aliasing (well, actually pcpu_hot
> in the new version) on top of Uros=E2=80=99s patches, and the effect can =
be seen
> in many functions. I don=E2=80=99t want to bother with many examples so h=
ere is
> a common and simple one:
>
> Currently syscall_exit_work() that starts with:
>
>    0xffffffff8111e120 <+0>: push   %rbp
>    0xffffffff8111e121 <+1>: mov    %rdi,%rbp
>    0xffffffff8111e124 <+4>: push   %rbx
>    0xffffffff8111e125 <+5>: mov    %rsi,%rbx
>    0xffffffff8111e128 <+8>: and    $0x20,%esi
>    0xffffffff8111e12b <+11>: je     0xffffffff8111e143 <syscall_exit_work=
+35>
>    0xffffffff8111e12d <+13>: mov    %gs:0x2ac80,%rax
>    0xffffffff8111e136 <+22>: cmpb   $0x0,0x800(%rax)
>    0xffffffff8111e13d <+29>: jne    0xffffffff8111e22a <syscall_exit_work=
+266>
>    0xffffffff8111e143 <+35>: mov    %gs:0x2ac80,%rax
>    0xffffffff8111e14c <+44>: cmpq   $0x0,0x7c8(%rax)
>
> Using the const-alias changes the beginning of syscall_exit_work to:
>
>    0xffffffff8111cb80 <+0>: push   %r12
>    0xffffffff8111cb82 <+2>: mov    %gs:0x7ef0e0f6(%rip),%r12        # 0x2=
ac80 <pcpu_hot>
>    0xffffffff8111cb8a <+10>: push   %rbp
>    0xffffffff8111cb8b <+11>: mov    %rdi,%rbp
>    0xffffffff8111cb8e <+14>: push   %rbx
>    0xffffffff8111cb8f <+15>: mov    %rsi,%rbx
>    0xffffffff8111cb92 <+18>: and    $0x20,%esi
>    0xffffffff8111cb95 <+21>: je     0xffffffff8111cba6 <syscall_exit_work=
+38>
>    0xffffffff8111cb97 <+23>: cmpb   $0x0,0x800(%r12)
>    0xffffffff8111cba0 <+32>: jne    0xffffffff8111cc7a <syscall_exit_work=
+250>
>    0xffffffff8111cba6 <+38>: cmpq   $0x0,0x7c8(%r12)
>
> So we both see RIP-relative addressing is being used (hence the instructi=
on is
> one byte shorter) and the reload going away.

Just a quick remark here:

For some reason existing percpu_stable_op asm uses %P operand
modifier. This will drop all syntax-specific prefixes and issue the
bare constant. It will also remove the (%rip) suffix. What we want
here is a generic %a modifier (See 6.47.2.8 Generic Operand Modifiers
[1]) that will substitute a memory reference, with the actual operand
treated as the address. In combination with "p" constraint will DTRT
and will emit symbol with the (%rip) suffix when available, also when
-fpie is in effect.

[1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc.pdf

Uros.
