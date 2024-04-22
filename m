Return-Path: <linux-kernel+bounces-153072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEDE8AC8A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC0280E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759BE5101A;
	Mon, 22 Apr 2024 09:14:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134753E12
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777249; cv=none; b=VQ1sxQmP3Jcx3UmjQRZ5GI6H5FhCgLjTVBN73xj/A+reS3xjJpronM059Wb4YXjiG+ai6rH9MfFCY4qt3kVkjK7pCGpghNbHLD18McJadTs9SXv0hUQcOvMhM3pc7iyRLI7UXp2Rm0ojCBi9jxf0qjNzKmUCIAdYGoyjI4jL9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777249; c=relaxed/simple;
	bh=bSB47jiEPbjn+2RJwxgCUv2A6TZ3BEAuszXFpzjGwdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XqHJDSxWp5RXb2ep/q7894ubxLj6OqmO7m+xaDV6rHykdwMdnQzoodt86rrpSkQTnpnZIVqDmvG6yX5uCY4DettFp/zBmROIzfHk01oAUPohaaQ0godWOuN6Htbj9qb6CsKhBfrSe7X4pIoqfh8wWwLjZNdF3An/huZIgf2X6jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19D1F339;
	Mon, 22 Apr 2024 02:14:35 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.21.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE2253F64C;
	Mon, 22 Apr 2024 02:14:04 -0700 (PDT)
Date: Mon, 22 Apr 2024 10:13:59 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Marc Zyngier <maz@kernel.org>, joey.gouly@arm.com,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: gcc-8: arm64/kvm/pauth.: Error: unknown architectural extension
 `pauth'
Message-ID: <ZiYqV-5BWmPwgqbU@FVFF77S0Q05N>
References: <CA+G9fYsCL5j-9JzqNH5X03kikL=O+BaCQQ8Ao3ADQvxDuZvqcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsCL5j-9JzqNH5X03kikL=O+BaCQQ8Ao3ADQvxDuZvqcg@mail.gmail.com>

On Mon, Apr 22, 2024 at 02:04:43PM +0530, Naresh Kamboju wrote:
> The arm64 defconfig build failed with gcc-8 and passed with gcc-13.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Build log:
> ---
> /tmp/ccSUNNZy.s: Assembler messages:
> /tmp/ccSUNNZy.s:3159: Error: unknown architectural extension `pauth'
> make[5]: *** [scripts/Makefile.build:244: arch/arm64/kvm/pauth.o] Error 1
> 
> Steps to reproduce:
> ---
> # tuxmake --runtime podman --target-arch arm64 --toolchain gcc-8
> --kconfig defconfig

I think the key thing here is GCC 8; the associated assembler won't necessarily
have ARMv8.3-A support, since all the relevant bits got added around GCC 9.

Looking at the commits, I think this is broken since its introduction in commit:

  6ccc971ee2c61a1f  ("KVM: arm64: nv: Add emulation for ERETAx instructions")

.. where the pauth.c file only depends on ARM64_PTR_AUTH (which doesn't imply
AS_HAS_ARMV8_3), but in the file we do:

  asm volatile(ARM64_ASM_PREAMBLE ".arch_extension pauth\n"
               "pacga %0, %1, %2" : "=r" (pac) : "r" (ptr), "r" (mod));

Given the minimum supported toolchain comes with an assembler that doesn't
necessarily support ARMv8.3, I reckon we'll either have to make NV pauth
support depend upon AS_HAS_ARMV8_3, or manually assemble the PACGA instruction.

I suspect the latter is the better option.

Mark.


> 
> Links:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240422/testrun/23551634/suite/build/test/gcc-8-defconfig/details/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240422/testrun/23551634/suite/build/test/gcc-8-defconfig/log
>   - https://storage.tuxsuite.com/public/linaro/lkft/builds/2fRe0ZWWmise7cetIz0aXdnq4jJ/
> 
> --
> Linaro LKFT
> https://lkft.linaro.org
> 

