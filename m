Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C940E75CE4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGUQTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbjGUQTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:19:16 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557F4694
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:17:51 -0700 (PDT)
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BB58C3F18F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1689956267;
        bh=wgUHzoDXTjjtOlC3+rEyxVrID6ad/R99TbcI30d00dI=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=NlP/Nqqa+uxbUxjPE+afV1fHv/xPJeOktIFEi7waNL2W5oxDt6kL2gE1pKXlu4v/t
         EitN/4kpfGU9k2VNJxJxbK489W3cxVokD/tXT9Zj9HoQkMOGou3IUnSEUcQCAneaqD
         BNZpwIuW78j5V3bi66JqHnB298hCnm0z41x1lMbRqtaW/fLpJRB+LpLeqyT6a4YyKJ
         /8ejGXvISaeiZmm3PuwDBHBgYHff3D5sSWkaFCwXj2poHjePE0IfHmZrN9qFELLdEW
         3Ng5kQwarNVWiRX6fJfYaE8n9f0XspnO6AoCzCFuQjRyeF6HXJPNfFHxN5gQ9hpP24
         LKzvCm4scKVkg==
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-403b0674ec8so24592931cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689956267; x=1690561067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgUHzoDXTjjtOlC3+rEyxVrID6ad/R99TbcI30d00dI=;
        b=B4uyIWI8ctY8g97a07f1n5AkMDTrlYvydrCo7nslfiWRF+gLvHurljwiftmLWKc7M5
         4nowI5InOzlOvRGG8ot3C40WW10pPpU4ZjJPAaB1WyNVnQW8vbMBslWDaEmko9yrfQcq
         phA8s22ZHBbRq8oNjlK2krLoMdnqRLp8pFcyqBuMuzerdYwbAAQflquV5Pcg4tO5NfNn
         0oR/6n0KZ/5eClp8xu9OGokEqI163UHP2W09zOnLfJBDr6LgUQA4MibDwcJhqGjHQcIx
         td75Vqg+sU2mIRuw1d/mXNRM3aQfZfqZXj4RcmpyxTcwXk2TIyfbsqqRoy618TGr2TRx
         99Zg==
X-Gm-Message-State: ABy/qLYVADommWRrjlMxW5+mONQt57aOO6ZqfUrAkBKkI/ZpwD1tHo6w
        Ih5farwoLfTL0XX/roiogo4JaDZHqGBhAs4IyFS+1ehIVjbS+TnwoZbaU9bW4TpUZqDnmQ4hNun
        VNfMWtYfAVSoyCZeqKsi5pWUUccw7nrMDLvI6i5V8vlYfDblFx8VFFIHAtw==
X-Received: by 2002:a05:622a:1a10:b0:405:464d:5bb0 with SMTP id f16-20020a05622a1a1000b00405464d5bb0mr631975qtb.32.1689956266708;
        Fri, 21 Jul 2023 09:17:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFsCtZK/fs1CfxrSe/Xx436U1H1O2FZ1chxm9c/Euubsm64CDfYfu3uIBllDzWDiITFbRjGF/uMcbffo5sTip0=
X-Received: by 2002:a05:622a:1a10:b0:405:464d:5bb0 with SMTP id
 f16-20020a05622a1a1000b00405464d5bb0mr631956qtb.32.1689956266458; Fri, 21 Jul
 2023 09:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230720140348.4716-1-CoelacanthusHex@gmail.com>
In-Reply-To: <20230720140348.4716-1-CoelacanthusHex@gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Fri, 21 Jul 2023 18:17:30 +0200
Message-ID: <CAJM55Z83u+aEVYAA0+9PEXK6hbre2=FS_=SDdxQ1uQN7L2PjkA@mail.gmail.com>
Subject: Re: [PATCH v4] riscv: entry: set a0 = -ENOSYS only when syscall != -1
To:     Celeste Liu <coelacanthushex@gmail.com>
Cc:     Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andreas Schwab <schwab@suse.de>,
        David Laight <David.Laight@aculab.com>,
        Felix Yan <felixonmars@archlinux.org>,
        Ruizhe Pan <c141028@gmail.com>,
        Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 16:05, Celeste Liu <coelacanthushex@gmail.com> wrote=
:
>
> When we test seccomp with 6.4 kernel, we found errno has wrong value.
> If we deny NETLINK_AUDIT with EAFNOSUPPORT, after f0bddf50586d, we will
> get ENOSYS instead. We got same result with commit 9c2598d43510 ("riscv: =
entry:
> Save a0 prior syscall_enter_from_user_mode()").
>
> After analysing code, we think that regs->a0 =3D -ENOSYS should only be e=
xecuted
> when syscall !=3D -1 In __seccomp_filter, when seccomp rejected this sysc=
all with
> specified errno, they will set a0 to return number as syscall ABI, and th=
en
> return -1. This return number is finally pass as return number of
> syscall_enter_from_user_mode, and then is compared with NR_syscalls after
> converted to ulong (so it will be ULONG_MAX). The condition
> syscall < NR_syscalls will always be false, so regs->a0 =3D -ENOSYS is al=
ways
> executed. It covered a0 set by seccomp, so we always get ENOSYS when matc=
h
> seccomp RET_ERRNO rule.
>
> Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
> Reported-by: Felix Yan <felixonmars@archlinux.org>
> Co-developed-by: Ruizhe Pan <c141028@gmail.com>
> Signed-off-by: Ruizhe Pan <c141028@gmail.com>
> Co-developed-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> Signed-off-by: Shiqi Zhang <shiqi@isrc.iscas.ac.cn>
> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
> Tested-by: Felix Yan <felixonmars@archlinux.org>

With this patch I can use groupmod, groupadd, usermod, useradd etc.
inside systemd-nspawn again. Thanks!
Tested-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> ---
>
> v3 -> v4: use long instead of ulong to reduce type cast and avoid
>           implementation-defined behavior, and make the judgment of sysca=
ll
>           invalid more explicit
> v2 -> v3: use if-statement instead of set default value,
>           clarify the type of syscall
> v1 -> v2: added explanation on why always got ENOSYS
>
>  arch/riscv/kernel/traps.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f910dfccbf5d2..729f79c97e2bf 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -297,7 +297,7 @@ asmlinkage __visible __trap_section void do_trap_brea=
k(struct pt_regs *regs)
>  asmlinkage __visible __trap_section void do_trap_ecall_u(struct pt_regs =
*regs)
>  {
>         if (user_mode(regs)) {
> -               ulong syscall =3D regs->a7;
> +               long syscall =3D regs->a7;
>
>                 regs->epc +=3D 4;
>                 regs->orig_a0 =3D regs->a0;
> @@ -306,9 +306,9 @@ asmlinkage __visible __trap_section void do_trap_ecal=
l_u(struct pt_regs *regs)
>
>                 syscall =3D syscall_enter_from_user_mode(regs, syscall);
>
> -               if (syscall < NR_syscalls)
> +               if (syscall >=3D 0 && syscall < NR_syscalls)
>                         syscall_handler(regs, syscall);
> -               else
> +               else if (syscall !=3D -1)
>                         regs->a0 =3D -ENOSYS;
>
>                 syscall_exit_to_user_mode(regs);
> --
> 2.41.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
