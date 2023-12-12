Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEC880E558
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 09:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346011AbjLLIB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 03:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345957AbjLLIBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 03:01:25 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7F8A7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:01:29 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so55093105e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 00:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1702368088; x=1702972888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeYaPkYZV1gUI785r4n26WvSzflCnVMfe7xejKrvhGw=;
        b=yH2jBSwimfFNyIGLUWyUTYjjEtoyVRkXkG3gOZduV62s91oKAxbBkawkuvjtUtHHyv
         tFNAmmUG4XvLdeakHHt5dgs8oGRaE6h9VXRJATJe2P7Sv1Noq1LxZLSPZot8H+5DrRmx
         ByBdg4S9/xUQSlei8AWhfDxiGymdQvoCp1/B88gDjmnuDyNvU4yG+UmeASiCJIlEq/R9
         Q/LKRmjVZsRJ3TaTAKWJtRKnTLccA133IfkP7SY24zMq1kah5fj+SDssZkz7IISCVEuR
         FPtPGGGNAPLG/57dx18KvkWYTWnfWUuGjFKHPReH33JfYoi2Q0d6SklOkaSXJGzPhxgR
         AJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702368088; x=1702972888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LeYaPkYZV1gUI785r4n26WvSzflCnVMfe7xejKrvhGw=;
        b=lIz0rxNddOuLvLhw9BSE4ja8sYWlpjMpJnSLdiR6o37DeGVYITAyxTRFE4JjRBvrPT
         d5kDc5OaMjLAsZLP0sDOVu0ZAxrbrVSorJdK6mg8xa3C9QXV/0Rcwk/FAN7U3nXKW0Qq
         k51DETkwy2IpyPmwy97DBB4yZ8S8uf8h7d8G/BjFNusnky2TQOkHOrlUR/thMExNziHn
         2rR2kSQJleP18LQCY5B5VLy665CdLokEaniIBYleai8gQEAKfjnJxV7jv1Coy5WgNKsl
         UoFbl72RbkSDEtMTX2Wk0Z64auRwVkIvtezB41fWhpKW4IEIe13Cn14rXmSH23pHpk+6
         iNOQ==
X-Gm-Message-State: AOJu0Yx+PclgTmYxsW649tddtKC5EeTymHV4HCHr24Fz3zTbL7W2sozw
        I9mdmgKoj48Xf6rnBRlzk2PLsTum1l4fCETwf5dldw==
X-Google-Smtp-Source: AGHT+IFthsZWcAFKZ2O87HfQ853PVDauwWiX60VS5xQ0+k/2Rm3ww0q4uXdZGsXn0wGM3e/0uXgR2LhRggD6zLr6gKo=
X-Received: by 2002:a05:600c:3093:b0:40c:2b93:6a08 with SMTP id
 g19-20020a05600c309300b0040c2b936a08mr3205498wmn.16.1702368087940; Tue, 12
 Dec 2023 00:01:27 -0800 (PST)
MIME-Version: 1.0
References: <20231211172504.058ad6b6@canb.auug.org.au> <9f0763c0-8175-4160-b72e-8e9e3aee42f8@infradead.org>
In-Reply-To: <9f0763c0-8175-4160-b72e-8e9e3aee42f8@infradead.org>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Tue, 12 Dec 2023 09:01:17 +0100
Message-ID: <CAHVXubjbVxEvL01uu_Cm-_R8oLddwc6fUaQYE_Bc+sBThTmvWA@mail.gmail.com>
Subject: Re: linux-next: Tree for Dec 11 (riscv32: patch.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Dec 11, 2023 at 10:17=E2=80=AFPM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 12/10/23 22:25, Stephen Rothwell wrote:
> > Hi all,
> >
> > Changes since 20231208:
> >
>
> on riscv32:
>
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: arch=
/riscv/kernel/patch.o: in function `.L4':
> patch.c:(.text+0xbe): undefined reference to `__exittext_begin'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: patc=
h.c:(.text+0xc2): undefined reference to `__exittext_begin'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: arch=
/riscv/kernel/patch.o: in function `.L12':
> patch.c:(.text+0xd2): undefined reference to `__exittext_end'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: patc=
h.c:(.text+0xd6): undefined reference to `__exittext_end'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: arch=
/riscv/kernel/patch.o: in function `.L15':
> patch.c:(.text+0x1ea): undefined reference to `__exittext_begin'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: arch=
/riscv/kernel/patch.o: in function `.L7':
> patch.c:(.text+0x1ee): undefined reference to `__exittext_begin'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: patc=
h.c:(.text+0x1fe): undefined reference to `__exittext_end'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: arch=
/riscv/kernel/patch.o: in function `.L22':
> patch.c:(.text+0x202): undefined reference to `__exittext_end'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: arch=
/riscv/kernel/patch.o: in function `__patch_insn_write':
> patch.c:(.text+0x410): undefined reference to `__exittext_begin'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: patc=
h.c:(.text+0x414): undefined reference to `__exittext_begin'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: patc=
h.c:(.text+0x424): undefined reference to `__exittext_end'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: patc=
h.c:(.text+0x428): undefined reference to `__exittext_end'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: arch=
/riscv/kernel/patch.o: in function `.L46':
> patch.c:(.text+0x53c): undefined reference to `__exittext_begin'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: patc=
h.c:(.text+0x540): undefined reference to `__exittext_begin'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: arch=
/riscv/kernel/patch.o: in function `.L48':
> patch.c:(.text+0x550): undefined reference to `__exittext_end'
> /opt/crosstool/gcc-13.2.0-nolibc/riscv32-linux/bin/riscv32-linux-ld: patc=
h.c:(.text+0x554): undefined reference to `__exittext_end'
>
>
> Full randconfig file is attached.

We can ignore this one as CONFIG_XIP is enabled and we agreed at LPC
that I'll remove this soon.

Thanks,

Alex

>
> --
> #Randy
> https://people.kernel.org/tglx/notes-about-netiquette
> https://subspace.kernel.org/etiquette.html
