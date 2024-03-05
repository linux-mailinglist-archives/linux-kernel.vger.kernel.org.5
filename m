Return-Path: <linux-kernel+bounces-91827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B981871732
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2861C20DF5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5009E7EEE1;
	Tue,  5 Mar 2024 07:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDBXhqeC"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8507E773;
	Tue,  5 Mar 2024 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709624673; cv=none; b=jJ8aWurD0g8F+H4zyR/WSo+emWdo+g0x1XpNrP3nZICwdV+OmcT+evSBbjHaCng8bj3mndrl2TS8KNMoa9GlwMjOE0sLUl4HtkWANElx5z/pSXwauOFaIU875bbT3D7DdRKcXMptqa922sE2aBHaKgh/hSB5e4XI+O9yiKJp7xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709624673; c=relaxed/simple;
	bh=BCQGFqrl9qAJiLjSxFHy/VDGRlS1Q7ZbEuhboWZ4S6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=liSGR6+JsBCEyPM3qiIyE/UCh2AkKuDg0H6AQ4PIJU21DmlzSjCHG+d7y9slcU7aQAtxiVeLUDgT7fEJBYnVtVr+6Ph9Y3An8K32/h16FjOgLLhwuq3dOTqT/ZBEnrOSTaQPWq81OnVpqQj+JJgPYWKrhXT+URiiCGrABUeGjZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDBXhqeC; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2997cb49711so253681a91.3;
        Mon, 04 Mar 2024 23:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709624671; x=1710229471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMd2OlEWfF0C6xL6a9NwH9s2DhRohxTw6+HDyEIrfVI=;
        b=TDBXhqeCNq6Ta/6kf3jQ7RfA2F2SHYkaXal0QfPOguMdsr8p/ushQfZLA/BDYeMY0R
         tEw/t9MyRvDaxhHamw7GVY+bSVXbaInqgqLlWAJXQXY4SojhkEVhjnoUbEm7MYZGBMaj
         F0+i71VWBg51cBcImhBV+HGmUAMfsd6/j9k9kSsea50/xV0dfyaKq+Lnr6WnTDkAna3l
         H5B++yQvpW8tlyfI3TSSG7zgAsSrMzZCPCMaS9AjeMxgQMGvdVatABQjRQOlmRP+3i+d
         hKtnabUA09fceNF3fzzXR+qSNsvSwbVCUdql/l/QLMJHgCecDSR4bOzrToAcKkBqa1YP
         b53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709624671; x=1710229471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMd2OlEWfF0C6xL6a9NwH9s2DhRohxTw6+HDyEIrfVI=;
        b=E5PpwhfQvbCY23flk8K2rDAq2+aR0L2KXBpu6Ys6+9CggwsVfD2qjdZ3Av3AZLhY1M
         xVNWoPS6HALUmOuDswyMVXJJpE2Flxu7uKmDQxcnLiESG4gu37yi3KJPMV8TTDb775e6
         eKBxmXmJJfMLZrU17oSY11omqlx4IPEK7haoRVsiOdB+frWN1nzIFK2FCTTZuEfxnjCd
         uapiOH8zGdOGWp3Ac+eZQgbyqNuxlcxMmMvCM5qjYpyXJeD8g09tgXoTCJVlvyOtqo8X
         Y0UY9DF2KAltysBGrheXW2hZQ7QPjUtKoU7Jc/NF9eHWL9aiNYcUgKWdiapNj4Y1EawR
         JhoA==
X-Forwarded-Encrypted: i=1; AJvYcCVSMBrmrfN4WZXVROD1vh3HdUgxrO3LzzzuSi2VMaCcZpDko9ET9lLzQIPFLHPgOcBU7dSz7yxaD2ejA0BjSZJFxTG8Z2upq3878VxiAN79E8uFFF4qq6gV5Of0pQL44k3jkKCU
X-Gm-Message-State: AOJu0YxmgQsr47nlVlAkxg/v0ZyZO4ok9ENWWmk9S7CG1d7O6IFc7TfX
	/sfQXQGLZ9Wk7RZk93b3k+9lRt5OPrZ0vC0e9TE1V10nA6oKiC9Au7XNfnRVZsPSV3qU0WzGfum
	8G3LTYcfl+0DsFPphfSsnLpQkz3Q=
X-Google-Smtp-Source: AGHT+IG2+qfdZr1nofkwlPclqBFT5xGc+hrjVZinMntd1h9imMZoywFZlWNRZV/8mQmYGVx+i3QwYJ1WuvFEUSzxJWI=
X-Received: by 2002:a17:90a:3907:b0:299:5b06:5814 with SMTP id
 y7-20020a17090a390700b002995b065814mr8213585pjb.40.1709624671459; Mon, 04 Mar
 2024 23:44:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211551.833500257@linuxfoundation.org> <dcc13107-8e7e-12c9-e9f0-d0fa96ea9c39@w6rz.net>
 <2024030538-affair-bristle-25d8@gregkh>
In-Reply-To: <2024030538-affair-bristle-25d8@gregkh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Tue, 5 Mar 2024 08:44:18 +0100
Message-ID: <CADo9pHg4YfspsQNmLip_DEOeJb-RjSM3GaWQPeCXoZ-uyMdv3g@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/162] 6.7.9-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ron Economos <re@w6rz.net>, stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den tis 5 mars 2024 kl 08:41 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Mon, Mar 04, 2024 at 03:31:00PM -0800, Ron Economos wrote:
> > On 3/4/24 1:21 PM, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.7.9 release.
> > > There are 162 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> > >
> > > Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.9-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > The build fails on RISC-V RV64 with:
> >
> > arch/riscv/kernel/suspend.c: In function =E2=80=98suspend_save_csrs=E2=
=80=99:
> > arch/riscv/kernel/suspend.c:14:66: error: =E2=80=98RISCV_ISA_EXT_XLINUX=
ENVCFG=E2=80=99
> > undeclared (first use in this function); did you mean
> > =E2=80=98RISCV_ISA_EXT_ZIFENCEI=E2=80=99?
> >    14 |         if (riscv_cpu_has_extension_unlikely(smp_processor_id()=
,
> > RISCV_ISA_EXT_XLINUXENVCFG))
> > | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > | RISCV_ISA_EXT_ZIFENCEI
> > arch/riscv/kernel/suspend.c:14:66: note: each undeclared identifier is
> > reported only once for each function it appears in
> > arch/riscv/kernel/suspend.c: In function =E2=80=98suspend_restore_csrs=
=E2=80=99:
> > arch/riscv/kernel/suspend.c:37:66: error: =E2=80=98RISCV_ISA_EXT_XLINUX=
ENVCFG=E2=80=99
> > undeclared (first use in this function); did you mean
> > =E2=80=98RISCV_ISA_EXT_ZIFENCEI=E2=80=99?
> >    37 |         if (riscv_cpu_has_extension_unlikely(smp_processor_id()=
,
> > RISCV_ISA_EXT_XLINUXENVCFG))
> > | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> > | RISCV_ISA_EXT_ZIFENCEI
> > make[4]: *** [scripts/Makefile.build:243: arch/riscv/kernel/suspend.o] =
Error
> > 1
> > make[3]: *** [scripts/Makefile.build:480: arch/riscv/kernel] Error 2
> > make[2]: *** [scripts/Makefile.build:480: arch/riscv] Error 2
> >
> > The patch "riscv: Save/restore envcfg CSR during CPU suspend" (commit
> > 64e54f78d9f2dc30ac399a632922bb1fe036778a) requires patch "riscv: Add a
> > custom ISA extension for the [ms]envcfg CSR" (upstream commit
> > 4774848fef6041716a4883217eb75f6b10eb183b).
>
> Ah, that wasn't obvious, I've applied that pre-requsite patch now,
> needed to be done by-hand.  I'll push out a -rc2 in a bit with this fix
> in it, thanks for testing!
>
> greg k-h
>

Alright thanks for the info will test RC2 later today then

