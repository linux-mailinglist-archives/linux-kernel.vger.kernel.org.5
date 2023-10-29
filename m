Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885FB7DAD5F
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbjJ2RBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJ2RBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:01:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F73FBD
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:01:02 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507f1c29f25so5097096e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Oct 2023 10:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698598861; x=1699203661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehjbeH+jxTChtsEDDNVmACmNRPnSY/WOnY7rPP35b9Y=;
        b=RF1OZ53QaOOy1Rinr6kskqDb5xWFfVVIT0Yw3Djq/huQ3qPX+DHDAJt+xunICCDros
         sAiga0wd0VlNBVCHLtIeYGToY+Zkcm7L50m5jClUXYDTntZPL1QIsNQeRA3ePqzCzW8h
         Kk3IYQGZ6FtbDJVc8sNkimZ1jqfLI1I91eFYWC92iduN/XlHTvs+d2ZmhWv8P4d6yoPA
         SXlWHuceCITdER5NJRk0fqMaZoTmKCu90eWEXsr8n7r+VB836uYcQjdVbmWJfTQTVsCu
         OuasBIt6APgbE4NJvopvAU/sg8NapKb2VqK7CbC/HD+sXksWDAKqS0Jq68m/e0QaFcS+
         1hwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698598861; x=1699203661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehjbeH+jxTChtsEDDNVmACmNRPnSY/WOnY7rPP35b9Y=;
        b=Pe23eR4o5PId3OrRUM/Vdy7Yn2IfehTzyICkxBCR4IUUS8NxS6KcvoU90IttohCxwh
         hj/MZDGW0c9DaIrANYCA2SE2S32Lf6OH6Xy7PRl32WaJazefAYHIn+4nEqvE2GlpFAFs
         A5iSKeiqz6SV9k7Sm3eXUqBFCsGq2og7H1wHLxZCadkorcEoTLJ3zshJUdleOOD1932X
         BY3Ez/Fyb4tZvHte04Zzy3xWp0fUsU0dW+sxh2rt3KxkBGryywoRSTSOoziLaSf6b0jH
         WdXGf6JIho7w6afz7b8wrUOsYuyqVNWc5aKWzxk/mw/PqyFVgnP+2K5r0h38mTqvHewj
         JmvA==
X-Gm-Message-State: AOJu0Yx2VGouoO1AQEk6XLixf5V9TIA8+WinSNuYyLYdZzFIOEfaRk/8
        WDPc2nVOjtBEQrBLN5E1Je4nW4IqR2aS1+d2j17UdlE=
X-Google-Smtp-Source: AGHT+IFKCpOGLZM3vnrbaQNLC02/9n872COebcZttUxqu3qsZgdz3ReGjJKaiOKOb1YwcsyY+uu298DRgw3zKzReggA=
X-Received: by 2002:a05:6512:159f:b0:507:ce49:81bd with SMTP id
 bp31-20020a056512159f00b00507ce4981bdmr6417655lfb.61.1698598860373; Sun, 29
 Oct 2023 10:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231026160100.195099-6-brgerst@gmail.com> <202310290927.2MuJJdu9-lkp@intel.com>
 <CAMzpN2iUrfnuGQ9eFTr=NTeC6KSUPC37Qji5_g5MWejmXnXO3A@mail.gmail.com>
In-Reply-To: <CAMzpN2iUrfnuGQ9eFTr=NTeC6KSUPC37Qji5_g5MWejmXnXO3A@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Sun, 29 Oct 2023 13:00:49 -0400
Message-ID: <CAMzpN2jbA=ZCbbFq=gyVAtKBr4kyYcNPLpWaEcAhEAN2J0wwTw@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] x86/stackprotector/64: Convert stack protector
 to normal percpu variable
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Uros Bizjak <ubizjak@gmail.com>
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

On Sun, Oct 29, 2023 at 2:56=E2=80=AFAM Brian Gerst <brgerst@gmail.com> wro=
te:
>
> On Sat, Oct 28, 2023 at 9:26=E2=80=AFPM kernel test robot <lkp@intel.com>=
 wrote:
> >
> > Hi Brian,
> >
> > kernel test robot noticed the following build errors:
> >
> > [auto build test ERROR on tip/master]
> > [also build test ERROR on next-20231027]
> > [cannot apply to tip/x86/core dennis-percpu/for-next linus/master tip/a=
uto-latest v6.6-rc7]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Brian-Gerst/x86-=
stackprotector-32-Remove-stack-protector-test-script/20231027-000533
> > base:   tip/master
> > patch link:    https://lore.kernel.org/r/20231026160100.195099-6-brgers=
t%40gmail.com
> > patch subject: [PATCH v2 05/11] x86/stackprotector/64: Convert stack pr=
otector to normal percpu variable
> > config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/2=
0231029/202310290927.2MuJJdu9-lkp@intel.com/config)
> > compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.gi=
t ae42196bc493ffe877a7e3dff8be32035dea4d07)
> > reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20231029/202310290927.2MuJJdu9-lkp@intel.com/reproduce)
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202310290927.2MuJJdu9-l=
kp@intel.com/
> >
> > All errors (new ones prefixed by >>):
> >
> > >> Unsupported relocation type: unknown type rel type name (42)
>
> Clang is generating a new relocation type (R_X86_64_REX_GOTPCRELX)
> that the relocs tool doesn't know about.  This is supposed to allow
>         movq    __stack_chk_guard@GOTPCREL(%rip), %rax
>         movq    %gs:(%rax), %rax
> to be relaxed to
>         leaq    __stack_chk_guard(%rip), %rax
>         movq    %gs:(%rax), %rax
>
> But why is clang doing this instead of what GCC does?
>         movq    %gs:__stack_chk_guard(%rip), %rax

Digging a bit deeper, there also appears to be differences in how the
linkers behave with this new relocation:

make CC=3Dclang LD=3Dld:
ffffffff81002838:       48 c7 c0 c0 5c 42 83    mov    $0xffffffff83425cc0,=
%rax
                        ffffffff8100283b: R_X86_64_32S  __stack_chk_guard
ffffffff8100283f:       65 48 8b 00             mov    %gs:(%rax),%rax

make CC=3Dclang LD=3Dld.lld:
ffffffff81002838:       48 8d 05 81 34 42 02    lea
0x2423481(%rip),%rax        # ffffffff83425cc0 <__stack_chk_guard>
                        ffffffff8100283b: R_X86_64_REX_GOTPCRELX
 __stack_chk_guard-0x4
ffffffff8100283f:       65 48 8b 00             mov    %gs:(%rax),%rax

The LLVM linker keeps the R_X86_64_REX_GOTPCRELX even after performing
the relaxation.  It should be R_X86_64_32S based on it changing to an
LEA instruction.  The GNU linker changes it to R_X86_64_32S and a MOV
immediate.

So I think there are two issues here.  1) clang is producing code
referencing the GOT for stack protector accesses, despite -fno-PIE on
the command line and no other GOT references, and 2) ld.lld is using
the wrong relocation type after the relaxation step is performed.

I think the quick fix here is to teach the relocs tool about this new
relocation.  It should be able to be safely ignored since it's
PC-relative.  The code clang produces is functionally correct,
although not optimal.

Brian Gerst
