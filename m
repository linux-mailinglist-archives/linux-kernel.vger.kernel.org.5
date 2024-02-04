Return-Path: <linux-kernel+bounces-51811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6FC848F97
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 18:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6169B2213B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 17:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658C241E3;
	Sun,  4 Feb 2024 17:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mpa9jL+R"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B542249F3
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 17:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707066420; cv=none; b=YXDu3FEiWYLOthErlGs8gM1CY66X8xis7TG8ZI4W4L/rL7HKOIx2g4+M0dPc6wEy1qHaAJ923EmkCeKJ22FOvoMLhEiwTBTMnrNkAb+8FvOhHG7GoYEdyrYMg6pcNlRQMem6M1x/rAtgPf/dBP542olCI0mVr8YBo0fFCNCmrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707066420; c=relaxed/simple;
	bh=ByeceGA27Ixs+UrMZ4SRTFzcGbuGmGiLPFgcM7emWsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IlHbeBg6jVTTod+g1m4DLkZZkDInDKd2l4oEUlM2T22kIN1Ce4dm/1152f7Vx/A0CHDL/gvO1+8ZVbKWrrLmfaIy0ooXNWO3WDgzo0ckP0F8m9l2+hnbB0KeMUUnRxXX4F6+ruuPWwJlAWL78pYCNiOWlIJLSftsLu+CL3xKMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mpa9jL+R; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-7d5a6b1dd60so1429255241.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 09:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707066417; x=1707671217; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fi4AuTTvC82QwungzGuHUs4Rd+GX71D+j2MK7Iqe+OU=;
        b=mpa9jL+R7s/5qnfcE43UTUvnMrgYZuf/h08uQEkxBBMRg4ytgv8PF5C3zFonlHx17z
         bYzS/N3yx7xbwQi1kOb4E3JJOynbt/W8Q1RQjgZKj+nkkXcwHJ7yCzSU0nDQ7e8BwilC
         oDkmT6zpZMo1IgeEvTK0P0bRH68KC49oi9Z16U0od0W0AgNsv4avx29zU/tcS09wP+hG
         GaDBWXD9/icr9aaz9AN172aL2cf4oaTlATGmOjVdoU+cX1JiX4en35FUsAXi3lwkyx97
         U7iJT1s/2WG/DQR8knsSB9jiJB4RpygqdvXSCSjYxc7AWToK9AgVn12BOy4mc3eRMqBu
         2xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707066417; x=1707671217;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fi4AuTTvC82QwungzGuHUs4Rd+GX71D+j2MK7Iqe+OU=;
        b=IlavIaU2DcVnPpTIcTpPGDHfaxQZsbswY/ZL185IC26IEt134fCbHq6b04R5aAxN0x
         fAl3IuNVwr3/llr+wooq/iB9AliCupBG0jAN+OGwl2LQJvzVSAkzgwWo9PTN22DXph3h
         NJW7SmaGpHXXiGuWWOg7yXwTMUO9NDf9XiCqLHRb4s0O+5A/mUqpJAqt4m/n5OD2ehQa
         J96PTKaXoC805MwTbbGuA7nyl5JNuoN6gmxbBAEU6gfcJbXOsvkPPdPG8PGeujZEtFa1
         qn7AkqUxVZ0Lh9W4PJ+OJsgSq2/m4WdoSRC8KPdqMMjG+IHpnyGGSKSXVtTT5bV4iwK/
         ByWg==
X-Gm-Message-State: AOJu0YyLQHZbgLGhS5Ff84qFsk20kaGRvCHap7SBpzUX5iHy/xjRb8wJ
	uhgHi/ky3KZ9ClgyqWmtl2VMVH1OqTg9us9uV19lAfcVEdvyVDAEGt4UMcPGgrYfqmrq31lDWck
	YG5zvaf/9YjAAIOLkiFCoZ3IMOAmQYAyBp99pxw==
X-Google-Smtp-Source: AGHT+IHU6gSbjHEb/W7OF52+o5q4BiVoPlZAYWZnplufKFHK468DFH7McRHN63v7vk8gRYVWC8JKd6ssMXUt4Wa6NWw=
X-Received: by 2002:a05:6122:2001:b0:4c0:2b39:dc86 with SMTP id
 l1-20020a056122200100b004c02b39dc86mr306387vkd.5.1707066415531; Sun, 04 Feb
 2024 09:06:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203174756.358721205@linuxfoundation.org> <CA+G9fYt2je2FKwdgm31isfxF2xm+HAZ-+vfwmiXhS2SpdBGLFw@mail.gmail.com>
In-Reply-To: <CA+G9fYt2je2FKwdgm31isfxF2xm+HAZ-+vfwmiXhS2SpdBGLFw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sun, 4 Feb 2024 22:36:44 +0530
Message-ID: <CA+G9fYtf1Ui3Eb_inQbDuod=0hTx00cGXFJV19xKu+2epUASwg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/221] 6.1.77-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 4 Feb 2024 at 22:27, Naresh Kamboju <naresh.kamboju@linaro.org> wro=
te:
>
> On Sat, 3 Feb 2024 at 23:22, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.1.77 release.
> > There are 221 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Mon, 05 Feb 2024 17:47:20 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.1.77-rc2.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64, arm, x86_64, and i386.
>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> NOTE:
> ----
> Following Powerpc defconfig clang nightly build errors noticed linux-6.7.=
y,
> linux-6.6.y, linux-6.1.y and Linux next-20240201 tag.
>
>   error: option '-msoft-float' cannot be specified with '-maltivec'
>   make[5]: *** [scripts/Makefile.build:243: arch/powerpc/lib/xor_vmx.o] E=
rror 1
>
> We may have to wait for the following clang fix patch to get accepted
> into mainline
>  - https://lore.kernel.org/llvm/20240127-ppc-xor_vmx-drop-msoft-float-v1-=
1-f24140e81376@kernel.org/
>
>
> ## Build
> * kernel: 6.6.16-rc2
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-6.6.y
> * git commit: 8e1719211b07ef9172b231100722f54ffc23ed27
> * git describe: v6.6.15-327-g8e1719211b07
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6=
15-327-g8e1719211b07

[ My apologies ]
Please ignore this 6.6.16-rc2 report on 6.1.77-rc2 review email.

- Naresh

