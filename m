Return-Path: <linux-kernel+bounces-30747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD168323E2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 04:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9949C286231
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 03:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF0D210B;
	Fri, 19 Jan 2024 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VBRBCLmD"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130D6184E
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 03:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705636383; cv=none; b=JQJDS7Rdq2A0CwbQm11hWxXmk5YD/rGS3KFLZ4lCDD5SEhATWD38R7q7e1+NL5zjbx3R+euzG+P2bupy3IjyIXueNB9f03ILd1OEt+U4uBJDD6u5Wp+BGjb44KdgksogD7x74Tr1D/AdXXFdJg+FS+xhBd9PnjtXumATgz1D0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705636383; c=relaxed/simple;
	bh=mo8c6Bmp42CGWSM8HU8elamRn6AuuJjgecJ+w6iel0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPwwS0OW9xVyutbnB/YhVPwXvuG9IBaXXcZL4Ceu6NZIs9a9cN2lqrtFj0aiaESdUR+meIi9xauZjp4PFfXPo9IDzujaSx9hwEVVql5vExd3KXDuKUUQImDC385k51oHhDSy7oRBWISFJRvAKsGtrglCSUaSQeERuEGShq42/us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VBRBCLmD; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4b71e8790efso92698e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705636380; x=1706241180; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u3/2Z2xESJ2KA2jr25zZLyl5xbY/16kqULi2iZR1W8M=;
        b=VBRBCLmD/kHvy4Fq1qRIe7+lgBHUmLlidGZLkmT+FtEprnxRsnaReLvQlyFHGrPcYQ
         jwXzpZI+YS3aUxq4NYeuocAMNss9oqSef0hhs8K1l51fUA+Rkh9p6ffZRVnTv/Jd910w
         lt2HsiQlQOHACH9Qp9djhHqmcZ32rP06GjbHnhIFf3dYVS+pGt9bEVhu5NPY+8P6jccI
         k+/zJr/ddF+JXYCEESjNfRNJFGbqt0X2gI/DfypFLRoCrG1dlAXRBnfhMwIT/SlfIkyJ
         ywGDxOFwhG0VbkdO8rOBOCDMwSUpYH5m0yRVBzPw0dkXUN+7jX8X6lYFuskEoOBxLioW
         t35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705636380; x=1706241180;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3/2Z2xESJ2KA2jr25zZLyl5xbY/16kqULi2iZR1W8M=;
        b=wwRPVPJBp9WELtAirMJLBBgoOqHz4qWqMVPZuvkJmcpSAm/WgbFAXwyd/DRuBhpq2V
         d/SLri2e9xyXV0MBNtq9oayctd1c9LmyDbKWnZXXz4HwyZEjd7GB2IILKW61NjuPE20o
         3gDAtn14qNcWn48bJoX8qVNmm+A05ggu/BYjyZk6lVSu4thBIZXiWoyHWRrVlJBcQDDK
         U/5GixJ+N0LDTGInxiJa1z99CdhmhYhDKlHqNODsg8fviJhMJKuhmZdS0LzU7aTwjEVC
         ti5UwmRKjmVFw3zn0DopNuSUeCquj7VB3Rk0HFalVHs6/hWp6qfH1fwt/PMdjI/W4Uj5
         E4Sg==
X-Gm-Message-State: AOJu0YyMdidUh8SRBFd7eoU46McqO+Gae54dBA+pXVeIfiOwdNHuxe5M
	+sXtTscMHRKXwsxVtI3uKUAWl44Mm6NkP8ZQjVVLiMQEqoaVq/Vrgsfs9sb/T6FCIPFPk82cZ/X
	zvDpHZ9xFk/K0qvgTkK39fwTx9lryv365p6OkyA==
X-Google-Smtp-Source: AGHT+IFBn8+Y0RhN4QAWZqaCdFNIKah+oo28LokVMtCcQILvtRlHxw7vlb1tQmANN+LKttZN0RO9KtqOFtkXRHgAV0k=
X-Received: by 2002:a1f:7cc7:0:b0:4b6:f254:b234 with SMTP id
 x190-20020a1f7cc7000000b004b6f254b234mr1543594vkc.32.1705636380096; Thu, 18
 Jan 2024 19:53:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118104310.892180084@linuxfoundation.org> <96dc2b0b-ad51-42f9-a305-744d9d97272e@gmail.com>
In-Reply-To: <96dc2b0b-ad51-42f9-a305-744d9d97272e@gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 19 Jan 2024 09:22:48 +0530
Message-ID: <CA+G9fYvviOww1sOPxZDJR471TUhu+Brgv-k9YqKP_mb++Ek9GA@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/100] 6.1.74-rc1 review
To: Stefan Wiehler <stefan.wiehler@nokia.com>, Florian Fainelli <f.fainelli@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net, 
	rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jan 2024 at 00:40, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> +Stefan,
>
> On 1/18/24 02:48, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 6.1.74 release.
> > There are 100 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sat, 20 Jan 2024 10:42:49 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >       https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.74-rc1.gz
> > or in the git tree and branch at:
> >       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> ARM and ARM64 builds worked fine and passed tests, however BMIPS_GENERIC
> fails to build with:


Following MIPS builds failed on 6.6.y and 6.1.y
but passed 6.7.y and Linux-next and mainline builds.

mips:

  * build/clang-17-defconfig
  * build/clang-nightly-defconfig
  * build/gcc-12-allmodconfig
  * build/gcc-12-cavium_octeon_defconfig
  * build/gcc-12-defconfig
  * build/gcc-12-malta_defconfig
  * build/gcc-8-allmodconfig
  * build/gcc-8-cavium_octeon_defconfig
  * build/gcc-8-defconfig
  * build/gcc-8-malta_defconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

>
> arch/mips/kernel/smp.c: In function 'start_secondary':
> arch/mips/kernel/smp.c:340:2: error: implicit declaration of function
> 'rcutree_report_cpu_starting'; did you mean 'rcu_cpu_starting'?
> [-Werror=implicit-function-declaration]
>    rcutree_report_cpu_starting(cpu);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>    rcu_cpu_starting
> cc1: all warnings being treated as errors
> host-make[5]: *** [scripts/Makefile.build:250: arch/mips/kernel/smp.o]

same here,

>
> which is caused by 7c20a4cc189eff36d5aeb586008a540d8024fbff ("mips/smp:
> Call rcutree_report_cpu_starting() earlier").
>
> It looks like rcutree_report_cpu_starting() has been introduced
> 448e9f34d91d1a4799fdb06a93c2c24b34b6fd9d ("rcu: Standardize explicit
> CPU-hotplug calls") which is in v6.7.
>
> For MIPS, it would like an adequate fix would be to
> 's/rcutree_report_cpu_starting/rcu_cpu_starting/' for the 6.1 and 6.6
> branches.
>
> Stefan, do you agree?
> --
> Florian


--
Linaro LKFT
https://lkft.linaro.org

