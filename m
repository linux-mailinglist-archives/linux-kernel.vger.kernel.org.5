Return-Path: <linux-kernel+bounces-94095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE8A8739DD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44377288F06
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47AA134750;
	Wed,  6 Mar 2024 14:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7A1+a+e"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A891B134404;
	Wed,  6 Mar 2024 14:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709736922; cv=none; b=PgCm6g3/nhy+6/DyolNi/RNl3tuksLDw8GxU78iMo+K4DLxWtMwuMrurQ4q0ep2M9Xlx+zWnFvojIf5JciU3VRrDpy7TqxgDgIxNOGyXQTx2SmZVC7NAIQp7jHOJXvzduLHaSkfjzcCKnJ8gmqk58SlfqI3pTpK6ehJi9ezBSbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709736922; c=relaxed/simple;
	bh=XaDAf89/uDA4n7xDi6aw4UHtLzFhOCr6g7gX8vmEAqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5YXyrNluyOzNI+w7CM3q/J+mfXdenMKOe/4wGsLsIinHiNx3jbN/kjOUeQOL3BKlDA2qIL9F5P9c7gu+EGBeyqFdekeqYpSji2KwjdntRFhcO/TOm9wbT76DtoU1COi3a/wDPoBBDGobxol0vfzZO5Xq3GF9bPDb0Vv+NU1j9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E7A1+a+e; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29b780569d1so457386a91.3;
        Wed, 06 Mar 2024 06:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709736920; x=1710341720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G78MndKWFM+DYsygT2bBdMaWOBPhKkS5vi6PnsSzrjk=;
        b=E7A1+a+e+VfMtd3uwkHBLFuN/MTi0b8xuErpNBUQMybXVKMuGthwY814JwP8m+tnU0
         cFNCq7VmH1NnxxhzpAIEB5F1GjchL/shyQ9MZQsAo57qghWodrWWwH1o2AwK9MVApcuI
         y3i/ROQdRh2Z2J7jz7JoUcNywewNpzuJXIVqQINyHMkjBpoz/ojUsQu0tKXt4WfJrPKb
         W3HTUBgCcFKw40h0GCMlb1tJK6nr6akYz96xrUtmxgcTReHD6dYfR3zc38wABX1wUzhD
         V6ClZN8fwI9omZ0PFQ6aqoZRr6kKC2Z0od2ZBuGcIYRMOAvRbzV9wKLxiGlSwE4teyJf
         TOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709736920; x=1710341720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G78MndKWFM+DYsygT2bBdMaWOBPhKkS5vi6PnsSzrjk=;
        b=o+m6h1JmH2S+KJ1lWcuNXHUkC8yd79u+QmEHijcpcNFmJLzQMYWqyEZl8MPZLLyrJA
         hGQUY2DC0YfjAjSkpr/JMqHHZ7bGDkbnL5l4cTx6i+Y3IVoo5xfhws0nOEn8DLQMVtMX
         o7EIReIdlllCyGQlcUnROtXSgDv8do6mGdHuVwZw4S27UpMn5qk2KvLunwj8lRdMENJ4
         9oLBIYR3vO94EflfwehpXYuXLfX+8wbKiOSrdAZ0vcre6bYBrtWLoPIsOlNWlBh7WNvb
         f8DwmUZn0HfXgPhmYZQHIaoLeTCumUIqK2ZPbJiM5kDGuVecmOBif4huTIIH9EAoN/K+
         212A==
X-Forwarded-Encrypted: i=1; AJvYcCWLyIw26Wm5Oez8RW1dx3HxXuarpBIIPNZ8GHe3uZ7rlDI8ED1JucXiiBIxbK+Oi6gjWhA6arSAet5Mxt20mIuyU4xxAlobsFdd8W4C9axy7uYplvFRzMxV2Dpx849Uk41/SRik
X-Gm-Message-State: AOJu0YzRINS6ZnpDItIqHbszLDrHsMsdQb8u45Uov5Kg71M7DWlbS4wd
	ssUtFGxvBkbj3qAOkcd9LoW2iJ7rsS1xhCX87wOYBf+stP9gmG2iZKdL6y4T87bDkT3Y5/Uc7WP
	gYNifrlt3G4KppZA9ie0Jn+yLKYw=
X-Google-Smtp-Source: AGHT+IF3wcyAkHvZMzF9WcuiVVSj1V8rCwuDjIsG1zgOIc5nmnGmvau6gumyfzxT/W9FQweluiS847DbJEZzWhG9rZM=
X-Received: by 2002:a17:90a:fb81:b0:299:879a:7da7 with SMTP id
 cp1-20020a17090afb8100b00299879a7da7mr14069741pjb.34.1709736919930; Wed, 06
 Mar 2024 06:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305074649.580820283@linuxfoundation.org> <20240305-arson-panhandle-afa453ccb0aa@wendy>
 <1a9a5456-ea3f-8a30-d8db-f49269966e71@w6rz.net> <fc131a72-6421-ad75-44bd-5ab7761d1cc4@w6rz.net>
 <013ebb78-46df-0db7-d95e-51229273bd2c@w6rz.net> <2024030521-uncover-pushchair-e68c@gregkh>
In-Reply-To: <2024030521-uncover-pushchair-e68c@gregkh>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Wed, 6 Mar 2024 15:55:06 +0100
Message-ID: <CADo9pHhF-yaw_EgenkUt5Z6t9_TW9XroWeoeXVRquLQJfuO+FA@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/163] 6.7.9-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ron Economos <re@w6rz.net>, Conor Dooley <conor.dooley@microchip.com>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den tis 5 mars 2024 kl 12:38 skrev Greg Kroah-Hartman
<gregkh@linuxfoundation.org>:
>
> On Tue, Mar 05, 2024 at 01:52:59AM -0800, Ron Economos wrote:
> > On 3/5/24 1:48 AM, Ron Economos wrote:
> > > On 3/5/24 1:27 AM, Ron Economos wrote:
> > > > On 3/5/24 12:31 AM, Conor Dooley wrote:
> > > > > On Tue, Mar 05, 2024 at 07:58:57AM +0000, Greg Kroah-Hartman wrote:
> > > > > > This is the start of the stable review cycle for the 6.7.9 release.
> > > > > > There are 163 patches in this series, all will be posted as a response
> > > > > > to this one.  If anyone has any issues with these being
> > > > > > applied, please
> > > > > > let me know.
> > > > > >
> > > > > > Responses should be made by Thu, 07 Mar 2024 07:46:26 +0000.
> > > > > > Anything received after that time might be too late.
> > > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > > >      riscv: Save/restore envcfg CSR during CPU suspend
> > > > > >
> > > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > > >      riscv: Add a custom ISA extension for the [ms]envcfg CSR
> > > > > I left a comment in response to the off-list email about this patch,
> > > > > I don't think it's gonna work as the number this custom extension has
> > > > > been given exceeds the max in 6.7/
> > > > >
> > > > > Cheers,
> > > > > Conor.
> > > > >
> > > > > > Samuel Holland <samuel.holland@sifive.com>
> > > > > >      riscv: Fix enabling cbo.zero when running in M-mode
> > > >
> > > > Yeah, it doesn't work. Here's the new error:
> > > >
> > > > arch/riscv/kernel/cpufeature.c:180:9: error: implicit declaration of
> > > > function '__RISCV_ISA_EXT_SUPERSET'; did you mean
> > > > 'RISCV_ISA_EXT_SVPBMT'? [-Werror=implicit-function-declaration]
> > > >   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom,
> > > > RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
> > > >       |         ^~~~~~~~~~~~~~~~~~~~~~~~
> > > >       |         RISCV_ISA_EXT_SVPBMT
> > > > arch/riscv/kernel/cpufeature.c:180:34: error: 'zicbom' undeclared
> > > > here (not in a function)
> > > >   180 |         __RISCV_ISA_EXT_SUPERSET(zicbom,
> > > > RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts),
> > > >       |                                  ^~~~~~
> > > > arch/riscv/kernel/cpufeature.c:181:34: error: 'zicboz' undeclared
> > > > here (not in a function)
> > > >   181 |         __RISCV_ISA_EXT_SUPERSET(zicboz,
> > > > RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts),
> > > >       |                                  ^~~~~~
> > > > cc1: some warnings being treated as errors
> > > > make[4]: *** [scripts/Makefile.build:243:
> > > > arch/riscv/kernel/cpufeature.o] Error 1
> > > > make[3]: *** [scripts/Makefile.build:480: arch/riscv/kernel] Error 2
> > > > make[2]: *** [scripts/Makefile.build:480: arch/riscv] Error 2
> > > >
> > > >
> > > This depends on a much earlier patch, "riscv: add ISA extension parsing
> > > for vector crypto" (upstream commit
> > > aec3353963b8de889c3f1ab7cc8ba11e99626606).
> > >
> > > I think the best solution will be to revert all three patches.
> > >
> > > riscv: Save/restore envcfg CSR during CPU suspend
> > >
> > > riscv: Add a custom ISA extension for the [ms]envcfg CSR
> > >
> > > riscv: Fix enabling cbo.zero when running in M-mode
> > >
> > >
> > >
> > Sorry, "riscv: Fix enabling cbo.zero when running in M-mode" is okay. Just
> > the first two.
>
> Ok, will go drop both of them now and will push out a -rc3.
>
> thanks,
>
> greg k-h
>

