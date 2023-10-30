Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68787DBC86
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 16:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjJ3PYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 11:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbjJ3PYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 11:24:32 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A9FA9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:24:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd19eac8so6653527e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698679467; x=1699284267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0KowZ1di5qvK5n+3JJf/2IyXXL5HDQOugqkhoSxid4=;
        b=PT90ZZmRn+F70XVdbwLQYBXVggwfwDLKNZ21pnKBvh2gF4DtRtwpxZxioIwXTWYII9
         VPLwDmtirLf/826DNgZV8Jx9i0vSWzafCyW13JqtWE7JSGdrk7nw69NnqRI0qLxhUKWY
         A9xAr5RXQ00G5HhxiLBZXKuXmhux0VPxPI+GEZ3YOETCR3xEgd40MSVBPfp3mZ3qjF+5
         3UJj6gU5mje8k4MqT/lq5EBf30XAe9RLDy0jD7TxGVEy6UfJ8HguEfrlQ//U2mUDTSEJ
         CaEeA/ZmmxMiTYRXpp4cwsOtjQWPOj07+bXopWiI3peTMNIDtLtC7DkJm3dBzdLFkubp
         mXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698679467; x=1699284267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0KowZ1di5qvK5n+3JJf/2IyXXL5HDQOugqkhoSxid4=;
        b=bLOCTCNPOPpqT8IALS/0Ny3gtVhcaAGq371yBV7AXhVR6FzrMU7HVryIJtR6JkjSS7
         vm4txlG2WpzvsD+m261zNN0VqSPAxnfRHFx0lIAi+ECt7qzhZtASSO32AEPsm5vqHjvX
         w97Cst0XKBgInqviG05IVh9kWreweHYLz1/O0RjNCWaCewjclW9srKKWjh7CJVrUrNr1
         b4HP4tMK0E8IK0gc8AVy4tzg4SbrwIaKO8Fh53Yr0BRPs6xRdvzN/nB0v5c9caH8JFdi
         7ROuMUgT05katEc0dEN1Pn7cr9IXUALm0ngJajJD745hAW46VJQm3c7RXLXgdnivBdin
         7t/A==
X-Gm-Message-State: AOJu0YzkrBr3zBy/GEmfMKOva7fVa7o9aE47oN0eO/T42UgqdiWy/R5n
        nFStNZS+P0g+IHYJexDSy/16Y3pgCV/+fh+q5frBDw==
X-Google-Smtp-Source: AGHT+IGmRgljGaofo/j9ML6PQtvuC7qBg+AsBwPZwNI7Tw42CXdzWGdq/jjJE02sR+y2ZptZG3coS3/XlrPMtirxUkw=
X-Received: by 2002:a05:6512:1103:b0:507:9a05:1aed with SMTP id
 l3-20020a056512110300b005079a051aedmr9887913lfg.4.1698679467390; Mon, 30 Oct
 2023 08:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-6-brgerst@gmail.com> <202310290927.2MuJJdu9-lkp@intel.com>
 <CAMzpN2iUrfnuGQ9eFTr=NTeC6KSUPC37Qji5_g5MWejmXnXO3A@mail.gmail.com> <CAMzpN2jbA=ZCbbFq=gyVAtKBr4kyYcNPLpWaEcAhEAN2J0wwTw@mail.gmail.com>
In-Reply-To: <CAMzpN2jbA=ZCbbFq=gyVAtKBr4kyYcNPLpWaEcAhEAN2J0wwTw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Oct 2023 08:24:16 -0700
Message-ID: <CAKwvOd=+MEv9aQAS91KT-Ov3N8f8XRPE3WTEwvJyom=PTCmUeQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] x86/stackprotector/64: Convert stack protector
 to normal percpu variable
To:     Brian Gerst <brgerst@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 10:01=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wr=
ote:
>
> On Sun, Oct 29, 2023 at 2:56=E2=80=AFAM Brian Gerst <brgerst@gmail.com> w=
rote:
> >
> > On Sat, Oct 28, 2023 at 9:26=E2=80=AFPM kernel test robot <lkp@intel.co=
m> wrote:
> > >
> > > Hi Brian,
> > >
> > > kernel test robot noticed the following build errors:
> > >
> > > [auto build test ERROR on tip/master]
> > > [also build test ERROR on next-20231027]
> > > [cannot apply to tip/x86/core dennis-percpu/for-next linus/master tip=
/auto-latest v6.6-rc7]
> > > [If your patch is applied to the wrong git tree, kindly drop us a not=
e.
> > > And when submitting patch, we suggest to use '--base' as documented i=
n
> > > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> > >
> > > url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gerst/x8=
6-stackprotector-32-Remove-stack-protector-test-script/20231027-000533
> > > base:   tip/master
> > > patch link:    https://lore.kernel.org/r/20231026160100.195099-6-brge=
rst%40gmail.com
> > > patch subject: [PATCH v2 05/11] x86/stackprotector/64: Convert stack =
protector to normal percpu variable
> > > config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive=
/20231029/202310290927.2MuJJdu9-lkp@intel.com/config)
> > > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.=
git ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/a=
rchive/20231029/202310290927.2MuJJdu9-lkp@intel.com/reproduce)
> > >
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://lore.kernel.org/oe-kbuild-all/202310290927.2MuJJdu9=
-lkp@intel.com/
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> Unsupported relocation type: unknown type rel type name (42)
> >
> > Clang is generating a new relocation type (R_X86_64_REX_GOTPCRELX)
> > that the relocs tool doesn't know about.  This is supposed to allow
> >         movq    __stack_chk_guard@GOTPCREL(%rip), %rax
> >         movq    %gs:(%rax), %rax
> > to be relaxed to
> >         leaq    __stack_chk_guard(%rip), %rax
> >         movq    %gs:(%rax), %rax
> >
> > But why is clang doing this instead of what GCC does?
> >         movq    %gs:__stack_chk_guard(%rip), %rax
>
> Digging a bit deeper, there also appears to be differences in how the
> linkers behave with this new relocation:
>
> make CC=3Dclang LD=3Dld:
> ffffffff81002838:       48 c7 c0 c0 5c 42 83    mov    $0xffffffff83425cc=
0,%rax
>                         ffffffff8100283b: R_X86_64_32S  __stack_chk_guard
> ffffffff8100283f:       65 48 8b 00             mov    %gs:(%rax),%rax
>
> make CC=3Dclang LD=3Dld.lld:
> ffffffff81002838:       48 8d 05 81 34 42 02    lea
> 0x2423481(%rip),%rax        # ffffffff83425cc0 <__stack_chk_guard>
>                         ffffffff8100283b: R_X86_64_REX_GOTPCRELX
>  __stack_chk_guard-0x4
> ffffffff8100283f:       65 48 8b 00             mov    %gs:(%rax),%rax
>
> The LLVM linker keeps the R_X86_64_REX_GOTPCRELX even after performing
> the relaxation.  It should be R_X86_64_32S based on it changing to an
> LEA instruction.  The GNU linker changes it to R_X86_64_32S and a MOV
> immediate.
>
> So I think there are two issues here.  1) clang is producing code
> referencing the GOT for stack protector accesses, despite -fno-PIE on
> the command line and no other GOT references, and 2) ld.lld is using
> the wrong relocation type after the relaxation step is performed.
>
> I think the quick fix here is to teach the relocs tool about this new
> relocation.  It should be able to be safely ignored since it's
> PC-relative.  The code clang produces is functionally correct,
> although not optimal.

Thanks for the report.  + Fangrui for thoughts on relocations against
__stack_chk_guard; clang has similar issues for 32b x86 as well.

>
> Brian Gerst
>


--=20
Thanks,
~Nick Desaulniers
