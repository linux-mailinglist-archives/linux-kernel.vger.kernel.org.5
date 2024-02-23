Return-Path: <linux-kernel+bounces-77976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0EA4860D9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E2811C214B7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B981B59B;
	Fri, 23 Feb 2024 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rANtBvbO"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0E81B59C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679431; cv=none; b=agUhKN2UYHeFKevEBB3k24h6xVsLVH5CTziYRmMFwBcaqDBrVmt5hr0yrrcN5TAp87js3PKh4gKBfta6+pPXTFz2rDXlhZbJwG62e3mEenrujFDLQp8pfVgp6lXCW6uVqAP2V6IgDVUiPRD2AdkOpBEJMWxSWApbC9b394hzPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679431; c=relaxed/simple;
	bh=vQFNPAEeZnC5taMrPLaupp21rVTklP2VlFjsZ2mjr1U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Nx1SnwTRe4Gq/XOfdCKz5VkTesviLkfc2kb1QlY6OxvaawmZKkMJ2cWZe2wg3nCIA2c4KZ7bpaB6/M++KiAx1dxbKL70LaOyajB6HLVeNvY2VTOxdq8m5x74h6qWPxVH3B66IHzhXveWmFaadpKcj9NWle/LX7UvnUsfDK60dYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rANtBvbO; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7d5c257452dso29394241.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708679429; x=1709284229; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Pb/pghdbVExNH64gH4NAktINHalqRI8PQy6k/UZrD+Y=;
        b=rANtBvbOwCcCurLbzH6n6P7DB+JGBfRMQ1ACA/rX4MiXGNIEsUxLQxTlYap5orvwrg
         w+QFOYS15LG4pfGA84DGfEuRGy+5OG6UtM52QjdxerNHldGNyuXebEQkgalhENoCzynz
         CUciaSe5LpVp8wQpJMTHBv+bHZEJRporBgTsU2ENNAOS7hLHrxOqzWUZ0bQj8bly4e/0
         2iiFPvV+7S1N3DtC12nmV6jedxu0J1iBF+B4oWWaHOlTlvOb9sWF1+92vTloZV8vyev4
         SR53m6N519pPYmnTGtl9GLgpl7ZHRk5eEDh4oKiPNHQ0HyY8fzO+27U5fgB/yy3MCIH7
         lNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708679429; x=1709284229;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pb/pghdbVExNH64gH4NAktINHalqRI8PQy6k/UZrD+Y=;
        b=mSuLriBxBja5OtpTzO09Iw1EJnm/pzkrJhoY5p1bKtE9iQ8Set2eYCPXPgQ4azp8RN
         GF/Ja8cL2fK4UkH+tVckGpGYCANSI4OOOpgqrYITIjsJPMEJFwEMcMXbINlEAObDy+Ua
         ReRl6Z642LDgC1Movv44v8nBFGTLI5gax0aABLB5J19IZqXvVAuFW2BgH90u2TEJIJLB
         b4DowiqaZ0sps3qyTLHoTZ7fvZRS1u97uD9JzEeHEx1SsEVfRb8S0NwX/3TaRcOuT02G
         6ZOajq1G85Vkp7aVXuDcOXUyS2c6Do/PqzY4SXRJ8ltB/deDmgMxsEDz7vH7wTqLfH1x
         lnew==
X-Gm-Message-State: AOJu0YxEGOe8cu2/CPrrOx7NkcphVzR7oqCFqG1ZM6eNyunI1FMTt+ox
	IxLZWoXQkg0mejOdqud4Qhk4G8GYMz8wEU7MsaERcwSA7Dm6q+CNUchG7Kc+h6U5tFQLXAN47Tu
	UyeUgiUEpKky1seEsqH7sjuTnljHYxX17M6iMFejh8xeVhCLFIPM=
X-Google-Smtp-Source: AGHT+IGLfJ2WsyogQkiTRWZwbXtdtHnlzU8BfhBoSMFKD5hZHhFuVJToCGeZYN362co9YMSebXdf/PL/IANOsIQmSsk=
X-Received: by 2002:a05:6102:e0e:b0:470:4702:49b0 with SMTP id
 o14-20020a0561020e0e00b00470470249b0mr1167473vst.26.1708679428673; Fri, 23
 Feb 2024 01:10:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 23 Feb 2024 14:40:17 +0530
Message-ID: <CA+G9fYtrXXm_KO9fNPz3XaRxHV7UD_yQp-TEuPQrNRHU+_0W_Q@mail.gmail.com>
Subject: arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
To: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ardb@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"

The arm64 defconfig builds failed on today's Linux next tag  next-20240223.

arm64:
    defconfig: gcc-13 - Failed
    defconfig: clang-17 - Failed

Build log:
------
2024/02/23 08:03:02 socat-internal[923] W waitpid(-1, {}, WNOHANG): no
child has exited
2024/02/23 08:03:02 socat-internal[923] W waitpid(-1, {}, WNOHANG): no
child has exited
2024/02/23 08:03:02 socat-external[919] W waitpid(-1, {}, WNOHANG): no
child has exited
arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning
(interrupt_provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing
'#interrupt-cells' in interrupt provider
arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dtb: Warning
(interrupt_map): Failed prerequisite 'interrupt_provider'
2024/02/23 08:03:04 socat-internal[923] W waitpid(-1, {}, WNOHANG): no
child has exited
2024/02/23 08:03:06 socat-external[919] W waitpid(-1, {}, WNOHANG): no
child has exited
In file included from arch/arm64/include/asm/lse.h:5,
                 from arch/arm64/include/asm/cmpxchg.h:14,
                 from arch/arm64/include/asm/atomic.h:16,
                 from include/linux/atomic.h:7,
                 from include/asm-generic/bitops/atomic.h:5,
                 from arch/arm64/include/asm/bitops.h:25,
                 from include/linux/bitops.h:68,
                 from arch/arm64/include/asm/memory.h:209,
                 from arch/arm64/include/asm/page.h:46,
                 from include/vdso/datapage.h:22,
                 from lib/vdso/gettimeofday.c:5,
                 from <command-line>:
arch/arm64/include/asm/atomic_ll_sc.h:298:9: error: unknown type name 'u128'
  298 |         u128 full;
      |         ^~~~
arch/arm64/include/asm/atomic_ll_sc.h:305:24: error: unknown type name 'u128'
  305 | static __always_inline u128
         \
      |

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Steps to reproduce:
 $ tuxmake --runtime podman --target-arch arm64 --toolchain gcc-13
--kconfig defconfig

Links:
 - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240223/testrun/22811036/suite/build/test/gcc-13-defconfig/details/
 - https://storage.tuxsuite.com/public/linaro/lkft/builds/2cl8paYnjzOljEurAWeMOWjikoy/


--
Linaro LKFT
https://lkft.linaro.org

