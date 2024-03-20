Return-Path: <linux-kernel+bounces-109096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B83A8881495
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA131C22408
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AA2524AE;
	Wed, 20 Mar 2024 15:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qyal7BuW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417D614A96
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948510; cv=none; b=FNw9fhs1poob6aAllepQn9qqgVTglqa8jGF9845FAUpUT/t4d/zY1Hr2F7vnPTffTo0mev+HyarCkTgtg0IJfBcGn6qW7NqEIrvrrFTVdRS2ZAOBAAR6omaPSCBkoMi9QL6dbZyr9O+jT59Mc/LfWHfHDXiSgt6cH8jtP8CpEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948510; c=relaxed/simple;
	bh=/fEHtW7aypddLpjPedD9VARMwM6kx3oj5E6k6UkOmFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHVmP2fK6YmS6vo0tOB347iefVkQoZneDPC5BkS/S5aVSDgtFnsqz/0Do+KHSKkXFrar3FzkG3x/gzz5KIDuwwm5oXfQm6eK4JSNfCo2N9s47xIlE+bH0U3HLbdL4SKaXE4/OtMSpetJgwUkl5Al8xexd7HBv3agIMoD8SH681c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qyal7BuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6367C433A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710948509;
	bh=/fEHtW7aypddLpjPedD9VARMwM6kx3oj5E6k6UkOmFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Qyal7BuWeyisRlRbs8KsVC1L3JkToIlQQd6L/B4AjobBMj+4BqjdnlQW3FKWJqbdN
	 yljhAQxgU13XpoTJG2bUU3YpeHMDpvFcf7/e4eNnZMSTMAE0MNQ++BQlucqgooy0In
	 xiDBIsbjmj9VaT3yl7R5guqkwG9wPGfvLHoNRra8aSLp6X7x69zrfm/Chzd1gJZmZ2
	 xE1GwIYJBI+/4PpFor7u/0NfjRNh/l3McE9483Fq4CCBLg/bW7+GBPINyTz84EI5NX
	 Iie8ht2rKw7ZfgLlXB4IA4/JiV8j5ACPvJvwjpxFyC8fwkMkGptc0CLU9SYpR8Yio+
	 R60ze6L2I59bA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512f3e75391so5464451e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:28:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhtsIjSt1Dw0zNFlckN92x4YsSsf5vLAAJg8KJ2HPUou7iLgGv
	ACcLJwP4mS0jZNHQ9P43JR7Un9DPL1y73kFe34zfUqeJOZvnSc7D/+H0p7aAnUvYSN6A+Y8cN1d
	CT3IoFOWP/rvV5Pb9+8qhFraVZb8=
X-Google-Smtp-Source: AGHT+IF2X9xhNyqu+N2vAFSUAKeLj50RJZdHqEPAxAqqLyIIPd7+uRyCyFPngBuwG671YiMvxNquU+rvfXLnjdPZLt0=
X-Received: by 2002:a19:6408:0:b0:513:a7ce:5264 with SMTP id
 y8-20020a196408000000b00513a7ce5264mr4658635lfb.44.1710948508495; Wed, 20 Mar
 2024 08:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117125807.1058477-1-masahiroy@kernel.org>
 <CAK7LNAStoCja1gnoFmsKikbzGZmKTcTu+Vc7v9zg8B9hwsH+iQ@mail.gmail.com> <CAK7LNATVAcj-pa_G-NGBTr9doCACGk1nKCNbxM50-M0mi9q=7w@mail.gmail.com>
In-Reply-To: <CAK7LNATVAcj-pa_G-NGBTr9doCACGk1nKCNbxM50-M0mi9q=7w@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 21 Mar 2024 00:27:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbyP0aLMUf0zka3VXwSkoDYZcav0EBOjkosjFsAeZPyw@mail.gmail.com>
Message-ID: <CAK7LNARbyP0aLMUf0zka3VXwSkoDYZcav0EBOjkosjFsAeZPyw@mail.gmail.com>
Subject: Re: [PATCH] riscv: compat_vdso: install compat_vdso.so.dbg to /lib/modules/*/vdso/
To: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Palmer,


Ping x 3.  Any chance for this to land during the MW?

It has been 4 months since the submission.



Masahiro








On Sat, Feb 24, 2024 at 12:37=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Ping x 2 ?
>
>
>
>
>
> On Sun, Jan 21, 2024 at 6:48=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
org> wrote:
> >
> > On Fri, Nov 17, 2023 at 9:58=E2=80=AFPM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > 'make vdso_install' installs debug vdso files to /lib/modules/*/vdso/=
.
> > >
> > > Only for the compat vdso on riscv, the installation destination diffe=
rs;
> > > compat_vdso.so.dbg is installed to /lib/module/*/compat_vdso/.
> > >
> > > To follow the standard install destination and simplify the vdso_inst=
all
> > > logic, change the install destination to standard /lib/modules/*/vdso=
/.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> >
> >
> > Ping?
> > (in case "yet more RISC-V updates" happens)
> >
> >
> >
> >
> > >
> > >  arch/riscv/Makefile | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> > > index a74be78678eb..5cbe596345c1 100644
> > > --- a/arch/riscv/Makefile
> > > +++ b/arch/riscv/Makefile
> > > @@ -146,7 +146,7 @@ endif
> > >  endif
> > >
> > >  vdso-install-y                 +=3D arch/riscv/kernel/vdso/vdso.so.d=
bg
> > > -vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/co=
mpat_vdso.so.dbg:../compat_vdso/compat_vdso.so
> > > +vdso-install-$(CONFIG_COMPAT)  +=3D arch/riscv/kernel/compat_vdso/co=
mpat_vdso.so.dbg
> > >
> > >  ifneq ($(CONFIG_XIP_KERNEL),y)
> > >  ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
> > > --
> > > 2.40.1
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
>
>
> --
> Best Regards
> Masahiro Yamada



--=20
Best Regards
Masahiro Yamada

