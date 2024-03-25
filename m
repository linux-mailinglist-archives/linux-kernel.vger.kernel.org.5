Return-Path: <linux-kernel+bounces-116848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D2A88B13C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1F0DBA3CE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C0D17BB39;
	Mon, 25 Mar 2024 11:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JL5F/GnD"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C8A1494BD
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711363131; cv=none; b=dB2Zb7BS+51w6SupLfRkJGGGITaCTCJ5jO9LaBPJwVyzPeiHq15R5xfwo2CEhY7XMfp4UKebJOgw2DSytRgORgkV1EJF9KcvM74EfDs2cDXmhY8j2cZ6BGCrTuM6iOWIpc8+fc6StB1NpTJ7Fn2/Ea2TVnI1gOgZI7mNHBIljUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711363131; c=relaxed/simple;
	bh=Fh3nwgtB4/hNAKuOMOxNy2Pkpo90LJkx49Wz4JF1YMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCoXZumQQBsFKC3LKIlEr9siS5wl76C8OngBWj8UBzcrFpdoAO5XftLjXTj1Kbo0y/mTzrFfGje1JuCGKmnZ1n8CaDvqGGP1xTAKfg6Xk2OEpwwggICWe2EZnPCxZ8+b4MKdAmJldvvoOBxbv9tbBJ3Kca8ege4OJFJUZ7X54sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JL5F/GnD; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7e057fb0b69so1276428241.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711363128; x=1711967928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6g5n0zDO/k+zn99LgqTberBsE1ninTPL1fai4wdNt1g=;
        b=JL5F/GnDAQzdejdXTwVt5UTEEl5Dx2SFXl+2iPs9A9gYx+IPij6hXyFbu/3UAJVw80
         NNTrJWicWlrz+uMvJwM1jux/23UUG2ktUgRPLHCM2PWCWJcsz0ssDluMDVAgHwyHmnFS
         Nz8nf9VnrarbQzviKYDZ00nZiTbNpsH2Vbx1EDQ+mHklNDy4cM6h+aC168KEReuTDXtp
         yIvmpbhttaKxmNdv0AxxGtEonJcTeuzyg7qkeZY0xL8PaPbfqLHGifXJq6F20dHlkVfV
         KtYTgLfY3fsoVs1WIT/NHzYvq6CgOKhcFih9mmOnN8IKYgouy+0Zrm+kBGVkLRxApRAz
         Yo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711363128; x=1711967928;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6g5n0zDO/k+zn99LgqTberBsE1ninTPL1fai4wdNt1g=;
        b=vrvaqKHCNHPUTrhGSNvzNGktjPicHB3niLeYxdDcUTiY5y8OyXXIbdaGG9YDbu+OOn
         7Vztb/lyP/7ZuJjg1pvlOw4aE78LJRcXp03rrX/2WUHrmvJ5Z1ySsMCr0AxcoG/QCy1b
         UTeAZ6pMC0GilLKCpf+5++gcOPqLLf5Vbs/eNr1hSN42Yx3dQ9bRnlr2mf1oP7W4qn5a
         A4QeC6li3fJBWOfialMDrD8HLjNl1z/xsk5U41/a55yoh3waaOZbPGIAaKHwIozodcRP
         P2Ppnu8rGO7lNDuotdl1nJgPw88duUw1pqMGDhVod7vu7XvFPB7V8Izfla0ux0CY7afa
         jOaA==
X-Gm-Message-State: AOJu0YxXaKF8W90zotBiX2jVPuyXRj+Im4VgPQ+RiqQARGr9UCx8gJhe
	WjPgTv+PqBnU7c451ZNBcQ4gcWxztuQD5hC4p2CVQmi2bt6s70ucZQI0oHnJmkZMF99cUyfJDLB
	BmeoPEBMedwEC5YQPg6f2u4REmxTD/7bfDYGzRA==
X-Google-Smtp-Source: AGHT+IFJxYGwWNIHi6Lbmtdb4kZhXP5ioGaL2mD6ZgHA/n4sgaK7bl1N67pI8OeJhoqvDzhTfAxKbvKvX0om/kjbOgc=
X-Received: by 2002:a05:6102:3549:b0:472:d517:24e1 with SMTP id
 e9-20020a056102354900b00472d51724e1mr4887720vss.29.1711363128587; Mon, 25 Mar
 2024 03:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240324224720.1345309-1-sashal@kernel.org>
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 25 Mar 2024 16:08:37 +0530
Message-ID: <CA+G9fYtBKCPVmRETNpo3OdQbky-XiY6RDQ+Pc2b4Yj1yLe_e0g@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/713] 6.7.11-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	florian.fainelli@broadcom.com, pavel@denx.de, Arnd Bergmann <arnd@arndb.de>, 
	Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 25 Mar 2024 at 04:17, Sasha Levin <sashal@kernel.org> wrote:
>
>
> This is the start of the stable review cycle for the 6.7.11 release.
> There are 713 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Mar 26 10:47:13 PM UTC 2024.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> Thanks,
> Sasha

The 32-bit architecture boot failed on stable rc 6.8 and 6.7 branches.

Boot details,
 - linux-stable-rc-linux-6.8.y - arm X15, qemu-arm and qemu-i386 - Boot failed
 - linux-stable-rc-linux-6.7.y - arm X15, qemu-arm and qemu-i386 - Boot failed

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

The bisection is in progress to investigate this problem.
Serial console logs printing as "Starting kernel ..."  that's all.


Steps to reproduce:
-------
tuxrun --runtime podman --device qemu-armv7 --boot-args rw --kernel
https://storage.tuxsuite.com/public/linaro/lkft/builds/2e9fapDKuhiDqLpezalPml1QIf3/zImage
--rootfs https://storage.tuxboot.com/debian/bookworm/armhf/rootfs.ext4.xz
--modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2e9fapDKuhiDqLpezalPml1QIf3/modules.tar.xz
--parameters SKIPFILE=skipfile-lkft.yaml --image
docker.io/linaro/tuxrun-dispatcher:v0.66.0 --tests rcutorture
--timeouts boot=30


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.10-713-g6f0681544906/testrun/23140347/suite/boot/test/gcc-13-lkftconfig-rcutorture/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.7.10-713-g6f0681544906/testrun/23141457/suite/boot/test/gcc-13-lkftconfig-rcutorture/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2e9fc0JdR6N9yOjnYWnO9druaJK

 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.1-715-gb0f6de60d946/testrun/23138873/suite/boot/test/gcc-13-lkftconfig-rcutorture/history/
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.8.y/build/v6.8.1-715-gb0f6de60d946/testrun/23138873/suite/boot/test/gcc-13-lkftconfig-rcutorture/details/
 - https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/2e9dH67vQBvX6giHu5ymUEpe2H4

--
Linaro LKFT
https://lkft.linaro.org

