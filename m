Return-Path: <linux-kernel+bounces-51110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7437848697
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2003A1C21B20
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 13:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DD7E5D90F;
	Sat,  3 Feb 2024 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b="JNJ2Ax2U"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E9D5D902
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706968141; cv=none; b=eHRphVZpTJk7Kk5RoVmKbfvOtIeYHt2Am1ZXE7FDDT2Us3Gf9m5Nl5foXWZZ0qWPDwKGGOj+YUF1g6HccjJgwx9p97KFaUjxyhOUYW+hygXfv1jsEZU39qlNiS9TnexalQsYNx7We2O2kV9/GoKIF1bago9U3Vs3t8B+b158ySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706968141; c=relaxed/simple;
	bh=zrF3irUwnrdNP7FMC6C5/C1TKOlChsEbui8AaDKbpBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BERY9yeksY+UsFETQGotZ2mLJPB5PW+i8vjTo3FfbvRJnV9Wy5o8V63A9ju6p3D7Oz8Lyyr5I0sdP8g5Hudb8QFHqWkZtd0O9qyT5BtEKxZh+p9VGyL50BnH6uwC2UJyLB97w12HxnYfmyp9tEG1p2H7YQnfsjBQ9DMPWdWXs30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com; spf=pass smtp.mailfrom=futuring-girl.com; dkim=pass (2048-bit key) header.d=futuring-girl-com.20230601.gappssmtp.com header.i=@futuring-girl-com.20230601.gappssmtp.com header.b=JNJ2Ax2U; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=futuring-girl.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=futuring-girl.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2965b5aeae8so578662a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 05:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=futuring-girl-com.20230601.gappssmtp.com; s=20230601; t=1706968139; x=1707572939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0/nxMUqpRTi8jjAM49HCOb52nB9yGpz/fFP3sr9Ovg=;
        b=JNJ2Ax2U8C7NKzlrxlygZIQK8L+vOW8IFYn9Jw4EI4WH8QOZhXugnPhfs1hvwdHkah
         SvKV7X+0l8HtNTL3kkWAPO4TY1xdvcqUwogwccWdIlVmWxuQ+RC9Pv5Sh/N8MoultjBb
         s6khzvBh2fvUyBtYOgsohQBgFWBCQa0e1lCR4Pz+jiJmMfvbXcLGgAdkpNXnIe5cMZf2
         8bX21LmPB5+GSK3ypv1ysiGEPEcm6BZKU8CNSEsbzRGy4w1kC7tI5QTFd1poMIURnv3K
         JD0NK4nyS3IjX1/YiRv/S1Ny2L1WlRGDY86UM7yOk8S+HHyB3RPiLexlq1pUgetoEFqk
         B6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706968139; x=1707572939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0/nxMUqpRTi8jjAM49HCOb52nB9yGpz/fFP3sr9Ovg=;
        b=hkBD+ARwO+YYh32KyhUNLFbqUBLGz1yqyQiTm+iUwnDA23rtpoNkVUkArqSDModJtf
         uKE3GDb606yNSOl/AHGSMJnz/0eClrIB6xIKiwwtlnU+CR5sVZTGnfovmmoi34IkWBDY
         sNa52s3GOiY1oZx05E2cq3G5EwVCCI+RU5ysZhwOE9j2B2IBh0CcrvwNOI7vcU/6CGIZ
         kISfVI0ltTpkxavmhmDr5f5A41ymmcrl+QzgxsL9ShXUeOHebaoqyXPrZxwMHuRKf7xp
         UIBJEzuuY8+r7qgP/9wSRnOd0ntstCxsMvJaStcpnEXRW2ifS0+qL1LFDU2kKF1piw4a
         MPrg==
X-Gm-Message-State: AOJu0YzlOiZJnvaQeepsys6g0V8Oum1KyItYH0WncfLFfMfTsp6FizDU
	Mis670MoS9UhXa5T2nJDehHpjpnqtsC0H+iqhecC9GFh4d0gtaM0szMEAlEujct+bq6E94gVXEX
	hyiJljf4j/pbmLLJFbxMaA4UOF0dJiaO755AFHb8FOoC0NxPIw/Q=
X-Google-Smtp-Source: AGHT+IEocWB16L1EG/HpxOXkrTVWk8Pkve8M5gMV7M9fc7jLH1KbVGt2V/vu1tsLFiZmtqlSbNEGm8aLlgF3mID0lic=
X-Received: by 2002:a17:90a:d717:b0:296:5c13:6ea7 with SMTP id
 y23-20020a17090ad71700b002965c136ea7mr2095454pju.25.1706968139041; Sat, 03
 Feb 2024 05:48:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203035359.041730947@linuxfoundation.org>
In-Reply-To: <20240203035359.041730947@linuxfoundation.org>
From: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>
Date: Sat, 3 Feb 2024 22:48:48 +0900
Message-ID: <CAKL4bV59sRxqmyn33Xyh9uU8EMxytfqqNFAKxAdFALdWXzr-pQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/322] 6.6.16-rc1 review
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

On Sat, Feb 3, 2024 at 1:16=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.16 release.
> There are 322 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon, 05 Feb 2024 03:51:47 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.6.16-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

6.6.16-rc1 tested.

Build successfully completed.
Boot error.

After selecting the rc kernel in grub I can't proceed further

Lenovo ThinkPad X1 Carbon Gen10(Intel i7-1260P(x86_64) arch linux)

Thanks

Tested-by: Takeshi Ogasawara <takeshi.ogasawara@futuring-girl.com>

