Return-Path: <linux-kernel+bounces-35213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8243F838DCC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 224D51F235E4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9575D8FC;
	Tue, 23 Jan 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="IbWTGkWD"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5793C5D8E0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706010382; cv=none; b=nX46xAfc8ZobHV3v4rhigKhDwxMNQxO2sAfsI7Sl9QN2ow28xrkJtgYUEleZTrqgufwSWNwnner14sozYWIeAJacIFJajjvy7jP2Fa1Pgv/3m4O/6RJGNrC0RfkFT+ejOamXS3YxjG7BMc926AHsWAgltYsLoEiUX5QEcpu5U88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706010382; c=relaxed/simple;
	bh=u+vnMh0bDwsz8C9HM93KCNUrx9aKpW+7M6cJvDcuWDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzQFROZ20ABWn+QWLmyBrtnzLDEIiMkY1n3fLG+FlZZA9Zkm+SxPqSEwxnVaACj8ZV7M9P9heA3He4vz5nPAlDbd8b+TywXTPl6ox+VygdUqqlO0DBw+mXiVi8WDc6Zy1uVLiXnh+jH2dzf0d2qOt3ckIhj4wmsTBX1clv4j4/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=IbWTGkWD; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29041136f73so2041843a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 03:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1706010379; x=1706615179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwSEZTvPmPib/iq3ufXx/1zhqV62G5jcQEWDJ/1dtko=;
        b=IbWTGkWDJSVPJpCRMxStkmeCiKbjxdbbQL9elf6Fvsfd1WvyeDc6EymTBw/4VftOcz
         /a2mhVDMUe9tvAVqHPNW3bQ2SSMOdVDgy9ZERgmwQ0UZfSSW4EFTlhnF7FMZZq5fcM0i
         +RbUBNLh+Swp6QkNRJ7gd3rRnuqOjulLO6+vv11UgIuqDQSxeZs6hQEHhnvLfdSf5EtJ
         mZu6Ktgo49r2y8sbkFKt8On9aJg+ouSAT4ZPXhTPPfOS5Bv+bX8L9XJUVFP+i9pZBQ9m
         cFscjJOkmRW3KfM4KnMcS6NwAfxLBa0oWDfaxrtO8GPfJ7NERdt/5UChf2TGriac5oxW
         /XMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706010379; x=1706615179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwSEZTvPmPib/iq3ufXx/1zhqV62G5jcQEWDJ/1dtko=;
        b=i4ViDxJiIO1dlT2mWsWivE9/mpmgkjHVT4Ql2ZhwhBZwvnqBnzUgw/iV5VNeK2IUF1
         Yco81dkQ3oNfnDTi3mLpd/90zp5uIi3Fq0BeLDtnp9WyWSGZfpCpu7Nyn5AKSx0Q/6K/
         HNOagALIB0vZEx5NWY+/mhzJELmC3MRFMC5cA3zWUvTlocrdZTezmguyE67gs0pAMDqL
         UiP+PXwTe1hn6rSgUQgoilRsaIXyAFYD4vvQus3Yp44rTCdmqGOdL2x0Jy0wQFRdDs+2
         qQHfkyj6on2Wg6AoEgWyt75L4iSs0uMO+/ZwSHzkS5GR+8m6uPMc2A0zxr94WcnD/9gW
         vxZw==
X-Gm-Message-State: AOJu0YxFiE86YkavuieBiOTwp5+8QZQ3aKut7/w5G3gItTETLd7UZSai
	wpi+tymDG4r7oB0uNw6FwYtlBzqY3obLdyoRdLSCeqEOlEKNe699Ci1UNJ2PcWM2sk0elUIsMpR
	xgwsV+cLWViY53JUbIhVqII2sG8qxHt7mhmkYKw==
X-Google-Smtp-Source: AGHT+IEACBp9H8QI1TqOIOZDLZgpEkwSJrj7m5dkRr4i9ZL9tXNUnb1GT+Fl2iLJmxsq+b68QpV00sU4bXL7cu2SlKk=
X-Received: by 2002:a17:90b:10f:b0:28d:f182:b85 with SMTP id
 p15-20020a17090b010f00b0028df1820b85mr2536584pjz.87.1706010379397; Tue, 23
 Jan 2024 03:46:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122235812.238724226@linuxfoundation.org>
In-Reply-To: <20240122235812.238724226@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Tue, 23 Jan 2024 20:46:08 +0900
Message-ID: <CAKL4bV55aK_qpQ-ubYKGrZ+=2tnr5zLqTgdaGuMUEVvNEe2w4Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/583] 6.6.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg

On Tue, Jan 23, 2024 at 11:17=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.14 release.
> There are 583 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 24 Jan 2024 23:56:49 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.14-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

6.6.14-rc1 tested.

Build successfully completed.
Boot successfully completed.
No dmesg regressions.
Video output normal.
Sound output normal.

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

[    0.000000] Linux version 6.6.14-rc1rv
(takeshi@ThinkPadX1Gen10J0764) (gcc (GCC) 13.2.1 20230801, GNU ld (GNU
Binutils) 2.41.0) #1 SMP PREEMPT_DYNAMIC Tue Jan 23 20:11:26 JST 2024

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

