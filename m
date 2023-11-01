Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E1D7DE755
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbjKAVV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbjKAVVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 17:21:25 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F51DBD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 14:21:19 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso29455e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 14:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698873677; x=1699478477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/fgQN3OiJHDfVP9Qm+7+ddepIqX7bLr4xuUu++WmEw=;
        b=kgyejPo6mO+8Nhz6HAPYiG5Z/pwlpr5K9No4bSXhpX5jWGIqlgTn8u69zQtd7u+wgq
         oAkjnypRjaLarLxNSlajKYMadmEZn48N68IO12EjIXHohdXDj60geE3RjoKHONYuypFD
         FGcoSyHev+S6EBWEacG8+Svgw7uv7aiLCX0IgBRP0vsa1Fwe4cNyaa8umZABI0F68Aoy
         0bM0GgVxp8445vKS83gDwIdP+5lGPYMYnDsCgEEvXRhzIQGikozdCQu4kgYxQ/Gox5gI
         0NzAq6k1vsuex9q5CROj0tLnO4nDROA02uOruc/XembpnWBHKAnnDC2GjOHhgElXv34a
         KZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698873677; x=1699478477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/fgQN3OiJHDfVP9Qm+7+ddepIqX7bLr4xuUu++WmEw=;
        b=L8cpObOUHaCBnPNM7HU6qNWQ3xf9pg3pzui91Cw1/D7+9pEQaQAIUgBhso74q0lJRk
         0qUpkhpBHvVyuS6WAu0Q6y0CTRYdQw/qLm/RGA38Oe89DGM8045hyTtvxdR7u6XJkFDu
         roaGFkvwhVS7mePSsJZQnXjdpKtXLJCOCsbgcTTIWbn9pmjITz4eHTkQ6sBN8kKcUFHf
         NIGwW4CC3P3pKmsEA4y43WgZ+RjcIR2dC8uL5R7M5cyWYCxexwhbJrBzrAHlst5cM1qO
         oRIUo6MUZAm1nCdSm5IoEY0Qfc2x93AGvrd1b8FcyTsN7mKUtN2xtArh8zFF0RzYLsC6
         tl7w==
X-Gm-Message-State: AOJu0YzFbfzYAGzWwlUgfmdbWLSJZin/ruc7YoRJayUiATqzpeAqaQC6
        W/9lRs08C1w/TAOmqpnktwRVAQICYhRtVn90/vvCEw==
X-Google-Smtp-Source: AGHT+IErwiBtm/Iq7gh7Pimz2BlqwC73ys4XaTwiWhe4e9HbmDAvvbGZDCCNxxgIROWS+6kblfzTCh9GPcxBXEqbkXI=
X-Received: by 2002:a05:600c:78a:b0:408:3727:92c5 with SMTP id
 z10-20020a05600c078a00b00408372792c5mr267073wmo.2.1698873676580; Wed, 01 Nov
 2023 14:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-6-brgerst@gmail.com> <202310290927.2MuJJdu9-lkp@intel.com>
 <CAMzpN2iUrfnuGQ9eFTr=NTeC6KSUPC37Qji5_g5MWejmXnXO3A@mail.gmail.com>
 <CAMzpN2jbA=ZCbbFq=gyVAtKBr4kyYcNPLpWaEcAhEAN2J0wwTw@mail.gmail.com>
 <CAKwvOd=+MEv9aQAS91KT-Ov3N8f8XRPE3WTEwvJyom=PTCmUeQ@mail.gmail.com> <CAMzpN2iF9-AdEcpkGOVooAn_6XTYaOb6gM+GYqy2SOc0S+dRqQ@mail.gmail.com>
In-Reply-To: <CAMzpN2iF9-AdEcpkGOVooAn_6XTYaOb6gM+GYqy2SOc0S+dRqQ@mail.gmail.com>
From:   Fangrui Song <maskray@google.com>
Date:   Wed, 1 Nov 2023 14:21:02 -0700
Message-ID: <CAFP8O3+vA_+nGH1e27czWC0EbxCoNpQOu9wFxEDEgqbdkoL1VA@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] x86/stackprotector/64: Convert stack protector
 to normal percpu variable
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2023 at 10:19=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> On Mon, Oct 30, 2023 at 11:24=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Sun, Oct 29, 2023 at 10:01=E2=80=AFAM Brian Gerst <brgerst@gmail.com=
> wrote:
> > >
> > > On Sun, Oct 29, 2023 at 2:56=E2=80=AFAM Brian Gerst <brgerst@gmail.co=
m> wrote:
> > > >
> > > > On Sat, Oct 28, 2023 at 9:26=E2=80=AFPM kernel test robot <lkp@inte=
l.com> wrote:
> > > > >
> > > > > Hi Brian,
> > > > >
> > > > > kernel test robot noticed the following build errors:
> > > > >
> > > > > [auto build test ERROR on tip/master]
> > > > > [also build test ERROR on next-20231027]
> > > > > [cannot apply to tip/x86/core dennis-percpu/for-next linus/master=
 tip/auto-latest v6.6-rc7]
> > > > > [If your patch is applied to the wrong git tree, kindly drop us a=
 note.
> > > > > And when submitting patch, we suggest to use '--base' as document=
ed in
> > > > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > > > >
> > > > > url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gers=
t/x86-stackprotector-32-Remove-stack-protector-test-script/20231027-000533
> > > > > base:   tip/master
> > > > > patch link:    https://lore.kernel.org/r/20231026160100.195099-6-=
brgerst%40gmail.com
> > > > > patch subject: [PATCH v2 05/11] x86/stackprotector/64: Convert st=
ack protector to normal percpu variable
> > > > > config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/arc=
hive/20231029/202310290927.2MuJJdu9-lkp@intel.com/config)
> > > > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-proj=
ect.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-=
ci/archive/20231029/202310290927.2MuJJdu9-lkp@intel.com/reproduce)
> > > > >
> > > > > If you fix the issue in a separate patch/commit (i.e. not just a =
new version of
> > > > > the same patch/commit), kindly add following tags
> > > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202310290927.2MuJ=
Jdu9-lkp@intel.com/
> > > > >
> > > > > All errors (new ones prefixed by >>):
> > > > >
> > > > > >> Unsupported relocation type: unknown type rel type name (42)
> > > >
> > > > Clang is generating a new relocation type (R_X86_64_REX_GOTPCRELX)
> > > > that the relocs tool doesn't know about.  This is supposed to allow
> > > >         movq    __stack_chk_guard@GOTPCREL(%rip), %rax
> > > >         movq    %gs:(%rax), %rax
> > > > to be relaxed to
> > > >         leaq    __stack_chk_guard(%rip), %rax
> > > >         movq    %gs:(%rax), %rax
> > > >
> > > > But why is clang doing this instead of what GCC does?
> > > >         movq    %gs:__stack_chk_guard(%rip), %rax

https://github.com/llvm/llvm-project/issues/60116 has some discussions
on this topic.

clang-16 -fno-pic -fstack-protector -mstack-protector-guard-reg=3Dgs
-mstack-protector-guard-symbol=3D__stack_chk_guard
uses a GOT-generating relocation for __stack_chk_guard. This avoids a
copy relocation for userspace but the kernel seems to really want an
absolute relocation,
so https://reviews.llvm.org/D150841 (milestone: clang 17) has implemented i=
t.

> If an `R_X86_64_32` relocation is used and `__stack_chk_guard` is defined=
 by a shared object, copy relocation. We will need an ELF hack called [copy=
 relocation](https://maskray.me/blog/2021-01-09-copy-relocations-canonical-=
plt-entries-and-protected).

> > > Digging a bit deeper, there also appears to be differences in how the
> > > linkers behave with this new relocation:
> > >
> > > make CC=3Dclang LD=3Dld:
> > > ffffffff81002838:       48 c7 c0 c0 5c 42 83    mov    $0xffffffff834=
25cc0,%rax
> > >                         ffffffff8100283b: R_X86_64_32S  __stack_chk_g=
uard
> > > ffffffff8100283f:       65 48 8b 00             mov    %gs:(%rax),%ra=
x
> > >
> > > make CC=3Dclang LD=3Dld.lld:
> > > ffffffff81002838:       48 8d 05 81 34 42 02    lea
> > > 0x2423481(%rip),%rax        # ffffffff83425cc0 <__stack_chk_guard>
> > >                         ffffffff8100283b: R_X86_64_REX_GOTPCRELX
> > >  __stack_chk_guard-0x4
> > > ffffffff8100283f:       65 48 8b 00             mov    %gs:(%rax),%ra=
x
> > >
> > > The LLVM linker keeps the R_X86_64_REX_GOTPCRELX even after performin=
g
> > > the relaxation.  It should be R_X86_64_32S based on it changing to an
> > > LEA instruction.  The GNU linker changes it to R_X86_64_32S and a MOV
> > > immediate.
>
> Correction:  It should be R_X86_64_PC32 for the LEA instruction.
>
> Brian Gerst

Whether --emit-relocs converts the original relocation type is debatable.
I have some comments on a similar topic on RISC-V:
https://sourceware.org/bugzilla/show_bug.cgi?id=3D30844#c6

> So it seems that ppc performed conversion can all be described by existin=
g relocation types, which is nice.
>
> However, I do not know whether the property will hold for all current and=
 future RISC-V relaxation schemes.
>
> When investigating relocation overflow pressure for x86-64 small code mod=
el, I have found that preserving the original relocation type gives me more=
 information: I can tell how
many R_X86_64_PC32/R_X86_64_GOTPCRELX/R_X86_64_REX_GOTPCRELX are
problematic. If they are converted to R_X86_64_PC32/R_X86_64_32, I'd
lose some information.
>
> Perhaps whether the --emit-relocs uses the original relocation type or th=
e transformed relocation type , does not matter for the majority of use cas=
es. E.g. Linux kernel's objtool, seems to perform a sanity check on relocat=
ions. It just needs to know the categories of relocations, e.g. absolute/PC=
-relative, not the exact type.



--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF
