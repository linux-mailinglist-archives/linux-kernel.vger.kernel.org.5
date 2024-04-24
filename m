Return-Path: <linux-kernel+bounces-156512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7508B0394
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 530F22845BD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50861158873;
	Wed, 24 Apr 2024 07:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gkiiVk0k"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B1B15821E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713945437; cv=none; b=kaGdEdjtVUvFkI9i/nwIj4SSrpZWBBtTEcZD7XB0/r/C2oIaXTIw0zUHzU1kVlkTD1/86w1WinnMPOPZdCy/6OqA/mzDFay8jvURv5Qevpvg/5fwsarToVg39v942aN/q3tgs7voxOr2s+paOtJ1u7uMMpLSBUBvZmxmjElD8nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713945437; c=relaxed/simple;
	bh=Or64OaneAWMEOpHLPP9hFWsP86VsJI1ybI9wBjzPf4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNwHgbiVWZK+1wfjZdDsgYZqtENi6py4zuzf8agjWkkiOMOSlb1g5G3Pz6VM0p7ZHq4KGZ0g7WWjQieARu/9j2DV3Yz/aBcqDraW026zAsrfn3tLDBTFbmh6dCPKhujnSwZHkdPozxb/6lvPzlCSJSIc6LSWi8ND5TD2vM8tDmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gkiiVk0k; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7ed6cf3e7f8so1051468241.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713945435; x=1714550235; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UA2CVXNklvbf0LWrbUSmouXmAKtxu5bf0ARspZd3rk0=;
        b=gkiiVk0kU3cUlosxTNSomjqMd128jrplNoxCvP8jShbz72PusgBj608q6ETjgQVw7L
         tn5LUPczwDJLRRHMqstLwapWJRAmRJaRd1UNx6lGxiy6WBlSP/B8t5MuYyBvkDzrxKfx
         EdFvGSfxhiQcn30QtKHX4vQ45Ap+eLXum9L1/e9Nnt4poQY2YebEZ+IcRNdwyjK8gWt1
         d71+fOg0tBxIoeTrREXkzQvix2NYWWXaVXsxPm6j1PTvGoVDqBtgMWy7tQkdOSGM6PSv
         a3wcJsHKXk9HrdWn5Y7A8l+jONJ8wvzqBxNqJqAcXkhe3CQ/Bhd/dAguCxRB75gGx1YP
         SD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713945435; x=1714550235;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UA2CVXNklvbf0LWrbUSmouXmAKtxu5bf0ARspZd3rk0=;
        b=axa1rrgmMsf30cKRdfNghN2QLdKtVO+joGmzjpW8eqxeSEWLOxz6lR1NaViV6PAYBp
         n8jXHnD6cdq5Vo8yfea0YgkkOqz1scpluaR8TttoatZYXPf3mfWqlpw3W9Dvo1EWTQaG
         UTutnhrfCMz76ZnWRMkQNuUU7KFqyvBlwBYaazZ7/O1EJfwQc1qEK07dpnIB1ckheBfv
         btmsFeB3WV9BPPCwBCCwV4w83tbWAnzH/A3j1Tb+K8CGDCz8ZGmQ8OnBymCi9C2b1tia
         LQ7MvvwnGlL1B0F4rTdJjqMSWmivhF12q/Q5CmCEDB6ktft9PepT3tUqhNeit0AktA5z
         HqWA==
X-Forwarded-Encrypted: i=1; AJvYcCUOF1AyoMw5cEL87qDIzhPkMxbDt4jA6EVkShHaAG4LWbVw544jI1UdeNcUtdXm7OSs+4rAPx7N18eI5ahqU4TOIkq0vgCb3njIyO7b
X-Gm-Message-State: AOJu0YyAKZ8bnJLxjGaeqkl5EW51o3uvlpwQ2fney2OpnDnEdWuXZfp0
	W7HKHRK2aTyb1zcJOyipf2FpXRtV6lan0y+/+YAHSk5RJ3MF/0AZLuaAvWFN2+BXn696oleMgnj
	InSuJi3a3VlJSrEYj5E0xH9huJv3ePpttXyuUgQ==
X-Google-Smtp-Source: AGHT+IFUwN08g7BSlDM6prRxw/urZVDh3+vum7FMACj7zISxNt8w6l0rqBWyuUBUbfTG9y+9p1LtvpT3K2vwBvNOvOI=
X-Received: by 2002:a05:6122:c89:b0:4da:9a90:a6f2 with SMTP id
 ba9-20020a0561220c8900b004da9a90a6f2mr1806626vkb.10.1713945434922; Wed, 24
 Apr 2024 00:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423213844.122920086@linuxfoundation.org>
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 24 Apr 2024 13:27:03 +0530
Message-ID: <CA+G9fYsm9OYUh+H9X2kpJWXsPdde36=WbSWc+mU0vO0i-QaWOw@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/71] 5.15.157-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org, linux-s390@vger.kernel.org, oberpar@linux.ibm.com, 
	Alexandra Winter <wintera@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 03:16, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.157 release.
> There are 71 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 25 Apr 2024 21:38:28 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.157-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


The s390 defconfig build failed with gcc-12 and clang-17 on the Linux
stable-rc linux.5.15.y branch.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build log:
---
drivers/s390/cio/qdio_main.c: In function 'qdio_int_handler':
drivers/s390/cio/qdio_main.c:761:52: error: incompatible type for
argument 2 of 'ccw_device_start'
  761 |                 rc = ccw_device_start(cdev, irq_ptr->ccw,
intparm, 0, 0);
      |                                             ~~~~~~~^~~~~
      |                                                    |
      |                                                    struct ccw1
In file included from arch/s390/include/asm/qdio.h:13,
                 from drivers/s390/cio/qdio_main.c:18:
arch/s390/include/asm/ccwdev.h:172:50: note: expected 'struct ccw1 *'
but argument is of type 'struct ccw1'
  172 | extern int ccw_device_start(struct ccw_device *, struct ccw1 *,
      |                                                  ^~~~~~~~~~~~~
make[3]: *** [scripts/Makefile.build:289: drivers/s390/cio/qdio_main.o] Error 1


Suspected commit:
--------
s390/qdio: handle deferred cc1
  [ Upstream commit 607638faf2ff1cede37458111496e7cc6c977f6f ]

Steps to reproduce:
---
# tuxmake --runtime podman --target-arch s390 --toolchain gcc-12
--kconfig defconfig


Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15.156-72-g70f39a25a6b8/testrun/23638097/suite/build/test/gcc-12-defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fWFs1EvyrjLKUD3D6ODW0Agksv/

--
Linaro LKFT
https://lkft.linaro.org

