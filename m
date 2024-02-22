Return-Path: <linux-kernel+bounces-76369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422F85F640
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015CF287DB1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA733FE27;
	Thu, 22 Feb 2024 10:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tgx2pUFU"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08E63EA7B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599350; cv=none; b=LjnFCwazoAV8dwd8hjJ6JMAVhENnbeZtldTobSxrxUD9LU0MZ9liqOYzpr6N8Saf/1bd60lBB5kqDXNef+SHhs2aO/cw92y3CHBS8lgCzdXlc4KKD7cx8O/7KTHvhxcfhAIKMcwOgJGSH/qX2emXzrsS80sbuPraNckpz7nyhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599350; c=relaxed/simple;
	bh=439y0CawLDEh5lyhHpxtilezXhVvm/Hhbvki2S2xLNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCzvkHDRrWz/EyoV+mD5YNGXfpMcpNKwjwIXohkoj7WwasKqzAHdoBxyo3/o/Ik7C+XWhuGiVurWA+Zw9lijNn1VIAvnWTtFsB99PF2hUutU6L5FCdeUSVjQgBjFD5BEJPDrKeSRsQ3LZBW6UsnihUixXWTTbztu4ofknemf65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tgx2pUFU; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4cb26623d8dso820142e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708599347; x=1709204147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FM4z7DIQDBcuDFxLdD60iofNC7omQneCJjVmeyaqoak=;
        b=Tgx2pUFUdSF438hTbEscveydfeeumNfyXxCSO+sFQeVNfr3ZB6EpguQqC/u2CZpAox
         p+wDR95AYVDVpJWBdEvNaH/RAAz50jevE0afOYQ2r/5MP4aMy6viE7xDm6ILi5s4nABV
         R4iloNk4Zpf60AtQ9Y5hCWwqiM7tH6Mcon+eaWRx0n1NxlWKlzjSaWUN8KhVvDVwoQZM
         o0Pj9DYcmkbWGyukIu1Ti1IZ2VSWc7krgWAWsqIWSrQhRb3IjM8pPK9LyMhYpLBae5ih
         ZClyum/b4JE3oNF0Fl0zgPMxECmeE477rg4DIM+vSjAT97njZEKRJbuEXPZsBNk7IZMy
         vXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599347; x=1709204147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FM4z7DIQDBcuDFxLdD60iofNC7omQneCJjVmeyaqoak=;
        b=a0IA4fruFM91ekEGZlIRnKMi0DE30DX0ijOP3jya2J2RXVYW8ZP4uNjUlqITqN/K0q
         sIjkY6BygPuXjV9E+KzASPf3ojU5CYcJbqF1wumeM47L2cHXOIMxT0sgRKYfnLc1pi0b
         Jz00CcieHycpsTnnQ0ZGJkHwCB89S17iHPst9RIYU9fzS6frwXURKuH7TKpQQTo6W75/
         oaoAhCmZ8OYl41A5zcPc30KctBGiARXpv0us19pfxIYLd9WvNlaivFfu11dHaVY2JnhD
         zDaAGYPj+PaQ3ox7D1L89fVU6a21VxHJ36V4NXtR6gSiwerSn90VLyAZkY9pvtJSV7VX
         fVXA==
X-Forwarded-Encrypted: i=1; AJvYcCWbpgXqPGCNsuCbWzhFg89ebk0apy0rUn9Rw2lF7UULbYPaasb39n73pbJ6c7GkUM7m3B2aA1a4yMPtcj58ninNSZToJrCyz4FNpc4I
X-Gm-Message-State: AOJu0YxM7Nd6ELz/Ga+B9Se2Co0AJA9/O4d75N/adw0KCfqXZ74GPsBh
	LhC7o7y4fufleoG4xAnjfZR9NxwdgdSif0GnZ9Nf+qJWEUYLjft1aKCy5GJEeew62R53OLCbovj
	G7Jp0RvGB91pXzP5JOGtaMxp5eIiXD9j99W+TAA==
X-Google-Smtp-Source: AGHT+IEp/h0CWwA7NPsOW74oY68F34eSvRnb+Q+eHPYZkQd2Rfzkx8nC/J+bPgf3qu+051y3j5tLOkn3980LYQ3YEBA=
X-Received: by 2002:a1f:d447:0:b0:4c8:90e5:6792 with SMTP id
 l68-20020a1fd447000000b004c890e56792mr12587102vkg.7.1708599347459; Thu, 22
 Feb 2024 02:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221125940.058369148@linuxfoundation.org>
In-Reply-To: <20240221125940.058369148@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 22 Feb 2024 16:25:36 +0530
Message-ID: <CA+G9fYua_rKjdmKMgYrRY_HRyMWPdJNz5=O0K4+M9P9wBWLPcw@mail.gmail.com>
Subject: Re: [PATCH 5.4 000/267] 5.4.269-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Beyond <Wang.Beyond@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, 
	Felix Kuehling <Felix.Kuehling@amd.com>, 
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 19:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.4.269 release.
> There are 267 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 23 Feb 2024 12:59:02 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.269-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

The i386 allmodconfig builds failed on stable-rc 5.15, 5.10 and 5.4.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
make[2]: *** [/builds/linux/scripts/Makefile.modpost:133:
modules-only.symvers] Error 1

Steps to reproduce:
 tuxmake --runtime podman --target-arch i386 --toolchain gcc-12
--kconfig allmodconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.148-477-gae70058cf980/testrun/22797307/suite/build/test/gcc-12-allmodconfig/log
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.148-477-gae70058cf980/testrun/22797307/suite/build/test/gcc-12-allmodconfig/details/

--
Linaro LKFT
https://lkft.linaro.org

