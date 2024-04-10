Return-Path: <linux-kernel+bounces-139536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8858A040E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3120D1F229F2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 23:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE863E494;
	Wed, 10 Apr 2024 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="L/u/bRB/"
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8442E40E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 23:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712791976; cv=none; b=aziFNerYV/0V4+Bm4ymn7xRwfGwse9CbZVHF2qBAAOUPZZIEZy6ND3Y5redTp9bzcqng9E539wQTgoZkAq6Yp/a/i6P/vhhe0z91ozwsNzbvBEBLz9nyxwxH7FQ8J2tpnRhuRUSQboGcM1zOJ+Ws0zj0CzUCH5jUA8mqcBcrLFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712791976; c=relaxed/simple;
	bh=j0uyhERivx0zpo5d7Uab//m+L+A7uhY7E/Nr6dO6BaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gy/a2tkKO+bEA4aZ2Cw/B95Qru1gFZbUacXxYWuKebtZ/h1oqmKENSh+Vuae0rR74ElrkZiWHH3v3qDrZW81h7Q7vrI14odSqLLYKGvMGMFifyDtAI4fCEJ4tuWLQO7DShPjn/utO0iArzfimLd9nitxBn4pU67zz/YFbJ1B9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=L/u/bRB/; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id C5EE5425B7;
	Wed, 10 Apr 2024 23:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1712791409; bh=j0uyhERivx0zpo5d7Uab//m+L+A7uhY7E/Nr6dO6BaY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L/u/bRB/7IZ0MsT0QSxUrZPrLzui36sFJM8ktHUciTh1lDiFPMbf2gUhQGg9CvIaM
	 MCiYGOG9VRexB1zg5wDgb3XQozR71K0Elc//dCm8H5gBFtcbDcHXJIqLwjuvmqQRqx
	 v3OddNK5sgpwShPNplUJE2XRmE7veOXg6T9yyPaKokJvr7TEpPCasUoiGiNneUiANE
	 tqiuqLK+n4mj0nXsA9JaXPuYt7wI0AdDYyvCatJp53oN2HWDB1ybwCtLXRRBej8x6Q
	 340/SSgLiv6NCspLpp7JLrAXsGt2C7O49h6Ky/xqEZewhT36oVFJQuQhGqYlYoHgH1
	 SNLbQUkGb6cbw==
Message-ID: <f4f53335-eba9-4c71-b64d-ca2c65c29a74@marcan.st>
Date: Thu, 11 Apr 2024 08:23:23 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] tso: aarch64: Expose TSO for virtualized linux on
 Apple Silicon
To: Zayd Qumsieh <zayd_qumsieh@apple.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Brown <broonie@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mateusz Guzik <mjguzik@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>, Marc Zyngier
 <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>,
 Miguel Luis <miguel.luis@oracle.com>, Joey Gouly <joey.gouly@arm.com>,
 Christoph Paasch <cpaasch@apple.com>, Kees Cook <keescook@chromium.org>,
 Sami Tolvanen <samitolvanen@google.com>, Baoquan He <bhe@redhat.com>,
 Lecopzer Chen <lecopzer.chen@mediatek.com>,
 Joel Granados <j.granados@samsung.com>, Dawei Li <dawei.li@shingroup.cn>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florent Revest <revest@chromium.org>, David Hildenbrand <david@redhat.com>,
 Stefan Roesch <shr@devkernel.io>, Andy Chiu <andy.chiu@sifive.com>,
 Josh Triplett <josh@joshtriplett.org>, Oleg Nesterov <oleg@redhat.com>,
 Helge Deller <deller@gmx.de>, Zev Weiss <zev@bewilderbeest.net>,
 Ondrej Mosnacek <omosnace@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Justin Lu <ih_justin@apple.com>, Asahi Linux <asahi@lists.linux.dev>
References: <20240410211652.16640-1-zayd_qumsieh@apple.com>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <20240410211652.16640-1-zayd_qumsieh@apple.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/04/11 6:16, Zayd Qumsieh wrote:
> x86 CPUs use a TSO memory model. Apple Silicon CPUs have the ability to
> selectively use a TSO memory model. This can be done by setting the
> ACTLR.TSOEN bit to 1. This feature is useful for x86 emulators, since it
> removes the need for emulators to insert memory barriers in order to abide
> by the TSO memory model. This patch series will add ACTLR.TSOEN support to
> virtualized linux on Apple Silicon machines. Userspace will be able to use
> a prctl to change the memory model of the CPU from the default ARM64 memory
> model to a TSO memory model.
> 
> A simple test can be used to determine if the TSO memory model is in use.
> This must be done on Apple Silicon MacOS Sonoma version 14.4 or later,
> since earlier versions do not support modification of the TSOEN bit.
> https://github.com/saagarjha/TSOEnabler/blob/master/testtso/main.c
> 
> This program will hang indefinitely if TSO is in use, and will crash almost
> immediately if it is not in use.

Well this is unexpected, given I talked to Justin Lu at Apple back in
December and I thought our plan was to work together on the series I've
had cooking in the Asahi tree [1] for a while now, which is actually
shipping in thousands of Asahi Linux systems in production and actually
already supported by the FEX-Emu project with our ABI. You CCed 30+
people, but not me nor the asahi@lists.linux.dev mailing list...

[1] https://github.com/AsahiLinux/linux/tree/bits/220-tso

Given that we're here now, I'll send out my series for review and see
what people think about that one.

> 
> Zayd Qumsieh (3):
>   tso: aarch64: allow linux kernel to read/write ACTLR.TSOEN
>   tso: aarch64: context-switch tso bit on thread switch
>   tso: aarch64: allow userspace to set tso bit using prctl
> 
>  arch/arm64/Kconfig                 | 19 +++++++++
>  arch/arm64/include/asm/processor.h |  4 ++
>  arch/arm64/include/asm/sysreg.h    |  7 ++++
>  arch/arm64/include/asm/tso.h       | 19 +++++++++
>  arch/arm64/kernel/Makefile         |  2 +-
>  arch/arm64/kernel/process.c        | 61 +++++++++++++++++++++++++++++
>  arch/arm64/kernel/tso.c            | 62 ++++++++++++++++++++++++++++++
>  include/uapi/linux/prctl.h         |  9 +++++
>  kernel/sys.c                       | 11 ++++++
>  9 files changed, 193 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/include/asm/tso.h
>  create mode 100644 arch/arm64/kernel/tso.c
> 

- Hector

