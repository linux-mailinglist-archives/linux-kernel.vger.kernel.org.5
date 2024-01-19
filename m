Return-Path: <linux-kernel+bounces-31441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AB8832E62
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A443B1C2430F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C4F55E7D;
	Fri, 19 Jan 2024 17:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3tcY5DB"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6587554BE2;
	Fri, 19 Jan 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705686800; cv=none; b=Qn41F2cjwKULO5h/ttSpatZMN+naMitXNN/D3rKCWlZbPYDVqRxF7H5JScpxKdBu0GsYRc3AZa+w0N/WNCFBngZWQW7UZ7H2c9Reic1dkKpVy9M84jMxxDe0wvI0yzDB6EqztLjkVSaSuNXVkYpgsr5eV3fj4EfL69Ys5wku6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705686800; c=relaxed/simple;
	bh=joZ3oqdD35mH93NqBSHyDq6L05JkQomCwHe2AIIsFH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9WXDcsXwMUu1v0Uct7TuEWlTdCfeTVlahdwmoSG3qLx9PSAtPcjheQGC21XF+l2Qnu8sgSYbkW/CC9OwQV8uADWlmEPq6cMZQdYhcB7ecLxAlcGe7gdvBEj2B/1Jg6A6J0l8cb4N06uHrepn8ipUVEhZZvsEGi2zdeniNx41Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3tcY5DB; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5ce942efda5so844531a12.2;
        Fri, 19 Jan 2024 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705686799; x=1706291599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWNsVy0kTO/oiTcTQ5yfNu1I6n3cORC/fqV3uGmtSiU=;
        b=U3tcY5DBrj9pfParHxx3K/aaLviAFHR6SyDmAJoCN7dibKl7mVmgrUCmxse7eaeKlm
         IjxKRlsd9tcnK2i9r0dNzAWIsFG3i8saNxytGql9qg7nAYLFvUJIueGPPrFUcNetji9i
         TkrmiHjsUo90w2WMUXSgaaYHnKIHJXYOIvOyUZ8/ScMEGAwKTWz65OphehhalYZ2BOry
         hJk8dz25Sq0aijDIaujRFtljfTojo3KgGTs+jtMBcQAgJZS+VKI9kDGAT++9YK3L36ro
         SxyOA6hEKrCyWhu7+Shmp4iF18SxBanMCw5cZYDOi/1M67h4HwD2yOgGaw/wAj7M2lV5
         ojUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705686799; x=1706291599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWNsVy0kTO/oiTcTQ5yfNu1I6n3cORC/fqV3uGmtSiU=;
        b=kDqIF2GL3rSQ/i1vRealFroC77OSTNiEA+sLMf7djPvAYpKQ7I6LiuoqgVI65HwrQ3
         4q+3XpVbZJwmfZv/rPsa78M0Jq5KfbgtBAmam7o+UXGuWaVgfYU5ZUh8nCA6A3XzFxSG
         gI2m2o/ju+dTgHeJIa2Su95pkHiV1ZsGeZVa00pSMlfmxdE/RvtrqcN9Nno/ywDjUOen
         BBqVDbExnyY5sdQvp6vw1TSonABVWajZasAkZtYJ4DLaeA4wPhSOKYEWjYrTp1bBFZvt
         HLv5sBkJG0035oxVQuL2kKr+53W0EXemzqYyrzyEgJBpeYCzAbx2t+Rx4vQqL9OQOliv
         7DuQ==
X-Gm-Message-State: AOJu0YxwFm1yGJLh0fHJkYC/yjNAWyE1/T/MMuzOYFrNL7wzIHlRPRcU
	jnKd6vXY8oWQR3Cu0Rv8a85bel0jkWevM/vXb2NR+WNi8hHm37wRu3Aqu8p6Z9FyWFtCtNvAyAr
	GVvwREetyBMpXoB1LlZ/4kJyUy/8=
X-Google-Smtp-Source: AGHT+IE1CSWzpt0z9AJr2t26c2E94K4ctR8RmKK6fIyBA6fD4c56V3CCGLhkExsI0hw3aMK6GoEBsCipVS/DU2ngbCc=
X-Received: by 2002:a17:90a:bd03:b0:28c:cec8:cfe0 with SMTP id
 y3-20020a17090abd0300b0028ccec8cfe0mr120928pjr.94.1705686798681; Fri, 19 Jan
 2024 09:53:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104301.249503558@linuxfoundation.org> <CA+G9fYv4PdOsuFmd2BGoq57omiXWuvnSpJJ1HuLYT0rJ_h9xEw@mail.gmail.com>
In-Reply-To: <CA+G9fYv4PdOsuFmd2BGoq57omiXWuvnSpJJ1HuLYT0rJ_h9xEw@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Fri, 19 Jan 2024 18:53:05 +0100
Message-ID: <CADo9pHgVDXXw6DcFTPHU+Cg10K4dusW61N4G5CFba-Qr99TS-Q@mail.gmail.com>
Subject: Re: [PATCH 6.7 00/28] 6.7.1-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de, 
	conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Works fine on my Dell Latitude 7390 laptop with model name    :
Intel(R) Core(TM) i5-8350U CPU @ 1.70GHz
and Crystal Linux: https://getcryst.al/site

Tested-by: Luna Jernberg <droidbittin@gmail.com>

Den fre 19 jan. 2024 kl 16:48 skrev Naresh Kamboju <naresh.kamboju@linaro.o=
rg>:
>
> On Thu, 18 Jan 2024 at 16:20, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 6.7.1 release.
> > There are 28 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patc=
h-6.7.1-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-6.7.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> The arm allmodconfig clang-17 build failed on 6.7.y, Linux next and mainl=
ine.
> but passed on 6.6.y.
>
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-202401=
17/testrun/22090095/suite/build/test/clang-17-allmodconfig/details/
>
> ## Build
> * kernel: 6.7.1-rc1
> * git: https://gitlab.com/Linaro/lkft/mirrors/stable/linux-stable-rc
> * git branch: linux-6.7.y
> * git commit: ef44e963b02edb00d4de5fa3528a21f3e7b33a85
> * git describe: v6.7-29-gef44e963b02e
> * test details:
> https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7=
-29-gef44e963b02e/
>
>
> --
> Linaro LKFT
> https://lkft.linaro.org
>

