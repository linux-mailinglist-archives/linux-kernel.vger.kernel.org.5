Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1356A7D9032
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbjJ0HrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjJ0HrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:47:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3852DB0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:47:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso2711787a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698392829; x=1698997629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s+HmKQBO5YfN5uxNe8jCr2D05b202XxgDdt3GiR2tw=;
        b=ajdqXw7BGT2zGQurdXewScLavincvIzqmW0zdD13h4f1k3mEXUhwBRM/NScKzzOHVw
         nBRK655s8nNZNjjc2UZqDBVtwHOvXOmrJ3lhsk3iyxHvS+fRqBaUMUV80vZcJApuLbEI
         LRZdAsAvIgSpBfgobGzQUvjA4Bi/PR6lH02nYlNPnjvbOpB/ToHl44jKAwj7khsMwCZo
         jkHJK925xCVkeSY9pydwFnV0tcAj9iGpLy1CsvH3BAL2B3Ijw7zmsgCNGipjy4spD8ZM
         Sfk+tSachhi74HB/ZKHaLJiplR0lLH1xit0h7qFOte7xN9OPOAEs4gHycHhddk2fC0Md
         DHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698392829; x=1698997629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s+HmKQBO5YfN5uxNe8jCr2D05b202XxgDdt3GiR2tw=;
        b=LL7kUtdKykHsInctJgMtD3yAZLQMGA9dJy0V4Sqr8N96pW3ZxO/Z6jk9lzSQmMTzgC
         zjS2kzdY9EgtbfE8C00mhvVQM7FWft2WesP4+H3mzmt3HzKAzjHd38mfo5/p9J6FkBGd
         fv8sNeN7LaJDW2MhAzvGuDOi+cBw9poofmHTRF8XE9j0K8Z2pRagZCHmR09/hXxhVXXo
         pUaG9zoxB0u6jP5F3mXX7OtFvgfPZzarxmKK0ADWsmJmV+a9zFbWJeR2Cy7j5ozU1l/T
         Lw/vQtc0FnO2dvXZlNaPLqL/evY2dGEi/+93wXgdPQUGfFDWWjiIhJ84h5C5zZzQ8c7e
         R/DA==
X-Gm-Message-State: AOJu0YzmSB7fCo5SgTLQgOEdNXIoce7723yxIhGy4Sd91K2yu/D+mm9V
        XjhheAYJDDTKBdR0xNAK+RJFOu/Ln1rxC+NOoNY=
X-Google-Smtp-Source: AGHT+IF2EbroTERLNWDfIZy8UmyVaispBEdtqSni14/t1Q/S3VfJpxBhkKhxbpzhHHNeGhqRLGuOfwp2PBOarTDAPYQ=
X-Received: by 2002:aa7:c982:0:b0:53d:a727:3846 with SMTP id
 c2-20020aa7c982000000b0053da7273846mr1650215edt.20.1698392829471; Fri, 27 Oct
 2023 00:47:09 -0700 (PDT)
MIME-Version: 1.0
References: <202310270909.QBAOkiZP-lkp@intel.com>
In-Reply-To: <202310270909.QBAOkiZP-lkp@intel.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 27 Oct 2023 09:46:58 +0200
Message-ID: <CAFULd4YbDKr-R5GOS44q+e=1qJNJXgBbvJ_gy1hA8G1VxzgVrA@mail.gmail.com>
Subject: Re: [tip:x86/percpu 21/22] arch/x86/include/asm/processor.h:522:24:
 sparse: sparse: dereference of noderef expression
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Nadav Amit <namit@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 4:01=E2=80=AFAM kernel test robot <lkp@intel.com> w=
rote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/p=
ercpu
> head:   0548eb067ed664b93043e033295ca71e3e706245
> commit: ed2f752e0e0a21d941ca0ee539ef3d4cd576bc5e [21/22] x86/percpu: Intr=
oduce const-qualified const_pcpu_hot to micro-optimize code generation
> config: x86_64-randconfig-122-20231027 (https://download.01.org/0day-ci/a=
rchive/20231027/202310270909.QBAOkiZP-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20231027/202310270909.QBAOkiZP-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310270909.QBAOkiZP-lkp=
@intel.com/

Already fixed in [1].

[1] https://lore.kernel.org/lkml/20231024142830.3226-1-ubizjak@gmail.com/

Thanks,
Uros.

>
> sparse warnings: (new ones prefixed by >>)
>    kernel/entry/common.c: note: in included file (through include/linux/s=
ched.h, include/linux/context_tracking.h):
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    kernel/entry/common.c: note: in included file (through arch/x86/includ=
e/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/threa=
d_info.h, ...):
> >> arch/x86/include/asm/processor.h:522:24: sparse: sparse: dereference o=
f noderef expression
>    kernel/entry/common.c: note: in included file (through include/linux/s=
ched.h, include/linux/context_tracking.h):
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    kernel/entry/common.c: note: in included file (through arch/x86/includ=
e/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/threa=
d_info.h, ...):
> >> arch/x86/include/asm/processor.h:522:24: sparse: sparse: dereference o=
f noderef expression
>    kernel/entry/common.c: note: in included file (through include/linux/s=
ched.h, include/linux/context_tracking.h):
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    kernel/entry/common.c: note: in included file (through arch/x86/includ=
e/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/threa=
d_info.h, ...):
> >> arch/x86/include/asm/processor.h:522:24: sparse: sparse: dereference o=
f noderef expression
>    kernel/entry/common.c: note: in included file (through include/linux/s=
ched.h, include/linux/context_tracking.h):
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    kernel/entry/common.c: note: in included file (through arch/x86/includ=
e/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/threa=
d_info.h, ...):
> >> arch/x86/include/asm/processor.h:522:24: sparse: sparse: dereference o=
f noderef expression
>    kernel/entry/common.c: note: in included file (through include/linux/s=
ched.h, include/linux/context_tracking.h):
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    kernel/entry/common.c: note: in included file (through arch/x86/includ=
e/asm/cpufeature.h, arch/x86/include/asm/thread_info.h, include/linux/threa=
d_info.h, ...):
> >> arch/x86/include/asm/processor.h:522:24: sparse: sparse: dereference o=
f noderef expression
>    kernel/entry/common.c: note: in included file (through include/linux/s=
ched.h, include/linux/context_tracking.h):
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>    arch/x86/include/asm/current.h:46:24: sparse: sparse: dereference of n=
oderef expression
>
> vim +522 arch/x86/include/asm/processor.h
>
>    513
>    514  static __always_inline unsigned long current_top_of_stack(void)
>    515  {
>    516          /*
>    517           *  We can't read directly from tss.sp0: sp0 on x86_32 is=
 special in
>    518           *  and around vm86 mode and sp0 on x86_64 is special bec=
ause of the
>    519           *  entry trampoline.
>    520           */
>    521          if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
>  > 522                  return pcpu_hot.top_of_stack;
>    523
>    524          return this_cpu_read_stable(pcpu_hot.top_of_stack);
>    525  }
>    526
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
