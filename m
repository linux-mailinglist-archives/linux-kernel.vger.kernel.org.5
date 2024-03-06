Return-Path: <linux-kernel+bounces-94464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C83874028
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 20:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41151287CDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67D113EFE8;
	Wed,  6 Mar 2024 19:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yq+8hOq8"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD76137C29;
	Wed,  6 Mar 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709752222; cv=none; b=kGfDZWS1Dt9aYAGXg4y2lxQvoK6BM8/9l+keHZDGgz2IqJoH9o8F90Wx88nRhEjeqz2JpXH/fbQbxMFFwsRXAxeaY3+4jf9Qn/I7le/xNfX4PKwU7CBvctBgO1Nld3AqxpvNJJJjUAVlrye9/UcyPWfAL/Yiz4ZggDTfZEjrdEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709752222; c=relaxed/simple;
	bh=7ZlQAAuTZrSqrwRUl2pqjvZmax0cAWYqHp5B+26aaJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HPQZdHW9lVJCJYfFnV9IODI1r/7KvMri/zp2L76Gxyxx0jNS+Zj5etUcRBSkoVWpRcWWGxTZdm8EjIZarSwm25r9on31xEM0nlbn2cCHoiT8LeoH4L+ZEZo4oESkWH6LluqhXJJC5/HgAlrmT3+OOq2FM/NJHk0kUSqoSeGR59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yq+8hOq8; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d37114045bso605369e0c.3;
        Wed, 06 Mar 2024 11:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709752220; x=1710357020; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HZMgXEdSaT6HJkOI5fBfRL5/6AFPoxBmi8lMmVSghgs=;
        b=Yq+8hOq85YR41j5dEE8kt4h05aO1cHElIEUEAwTkEfCIfVp+gSRlbHpA/3Vfd0FMIY
         Nc/mdRsWkrI7V55QXB0ulkLF5aDt//tOmxOGp7BA67OOprG/5rmNoeQjDrWuv8xx7FCd
         PykaHKLiviNUBghhOwoI9Fx7Lr7nI9MFN9WPwAss7SrOEl7OIv9CDi94jaIJTgg5bgRW
         4IJS5teJhVG/gYWcYpuTAJ7xeNQnGupWbIYGw4cZNVWFa8yrnGlixwdf+gx3tz4P8FCU
         UvV5xV8hlgDeAdIFpJfQU+k2zD1Dy+jgESy2UONb7RkSfBCGae9YSX1PGv25wtCpUJ2L
         TvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709752220; x=1710357020;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HZMgXEdSaT6HJkOI5fBfRL5/6AFPoxBmi8lMmVSghgs=;
        b=pl3n8GzFhh3sqOCyx/luVQmfH74uOK77p3MVcQ2il9ZTzEJV6xc9zK05kpDPTMZFHt
         Y4CSbteHGG/LNQRfNPWTjb2bcKGL0N+5Td+y6RJZjEVYI58mI9YCR8Ivcv+uh5pEAk32
         sm78LpzfE0VgPtSBYdRab80vdIdTZHX6cJL5C10rMm63xWfsU/s4TDihXOXLpaGGxnam
         SodDk4hrG7a+T+xc6pUd6Ix3/zKjRMOEESUf+EMt0LvKCqRXy2lOUA4AnsOxFv+xV3mE
         2WGPt6zU37zZamVAD2D046lX0akvBas1Ts2cdR0R9RdPV3JvuDiJkxj0eoUH75hwaYRC
         mWfw==
X-Forwarded-Encrypted: i=1; AJvYcCX/tu7AidcJ2sllrqa2nkDL7+jwn8U7V/Oc65PO/Jzq8QSxNj6ewz/9HmWw+yBixU8VmymwiuCbDd18u+HfyNDrwRUYgLGCNfTkgdBv
X-Gm-Message-State: AOJu0YyJoGfXxqQvw2OrlPEsbgcT+XcxwSab5C5pRPj+PH3DOpM+grpF
	WayagMgmA2SIlTPk4JOD38EXgrGzWXiCdYT1QdkKO1kGqU7V2I/T+ujyqadR2Wod3pCqfFSFB1n
	r5ZTOfdVFOG3mnT9yBs4sH4eTG3w=
X-Google-Smtp-Source: AGHT+IFhwUx/44qzGvR8hpKXNVsA0p4fq+LFRumMitpgUYpQZ2O9PVfcdQSDU4uyAP4fuJwo/aQm+6L9VrsFBL1iFPk=
X-Received: by 2002:a05:6122:4588:b0:4c0:25db:3618 with SMTP id
 de8-20020a056122458800b004c025db3618mr6312157vkb.0.1709752220162; Wed, 06 Mar
 2024 11:10:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304211556.993132804@linuxfoundation.org>
In-Reply-To: <20240304211556.993132804@linuxfoundation.org>
From: Allen <allen.lkml@gmail.com>
Date: Wed, 6 Mar 2024 11:10:07 -0800
Message-ID: <CAOMdWSKmEzJa0bP=7kKSf3UV0wc-AbKW2mdA5=AC1DhM2puiMg@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/215] 6.1.81-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is the start of the stable review cycle for the 6.1.81 release.
> There are 215 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 06 Mar 2024 21:15:26 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.81-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Compiled and booted on my x86_64 and ARM64 test systems. No errors or
regressions.

Tested-by: Allen Pais <apais@linux.microsoft.com>

Thanks.

