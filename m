Return-Path: <linux-kernel+bounces-147846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D6B8A7A73
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:19:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A231D1C21372
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A8F524F;
	Wed, 17 Apr 2024 02:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCkBVez3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0EC4428;
	Wed, 17 Apr 2024 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713320377; cv=none; b=kYu/ALoVOJ7hc6GQTmDdVaeLMqjB4k0uKiKrYGKyzFF/3l+k6OCDPNvF8tAmnnTxqeQ7W70gHD83S1xPukqV+s2sfw9LD2kQdXBJpuPfXdlYD4IgZ7jqEffxcBcbZBtEez82VV4khuDzJ2x4okA7V3AEKVaop732zMDoLvHrxqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713320377; c=relaxed/simple;
	bh=j7kB9fJgc9g+2BT1vi9wrK3itKid4LCQkt7eYZoFfnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V66uG455n0qUJpNX6u8l/LV1MYJZ4FY2ffm675wqcxowrhVblFOvmC034Mc/QZovGYzJwakAJiRjaeR1vLeiX7amlYy8cJ7TCagrqaWTLO2TaMklRxM0JjD8vzv7849UXxmPFxVIv6BGx07/DbgAg4K1FUhsfwAvoGI1p6/oNCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCkBVez3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D357C113CE;
	Wed, 17 Apr 2024 02:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713320376;
	bh=j7kB9fJgc9g+2BT1vi9wrK3itKid4LCQkt7eYZoFfnI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WCkBVez3QaYI7b4NH7s0rITSAl7Ce9OrpYb/eHWHf9M+XcLW/cvY9+0d8g3+rhzxd
	 SxZBRXLSAH3umFnSj1GAXSeK2llNNXWr3vEviZzBnwz8SkORAQGsAqtI92GlLSAvDy
	 XTZfuD2gLvH6xQu8zchKaz0WWOt50wzz0ZyR0NMrBqyk3GSK4S43JlgIcgw485rqaq
	 iVWTxQt2RJkGXKIKoiUaI9UzAX8dLkB67R9VIiMIGEZkha7lw7Qxfro+c/myDmCZCP
	 87Sy8bd4be6Db6A5Yn5hUu/alypjSMfq/0tDKu9U6YdndyiJsUmA000+G6aqdmTIAh
	 GM+F6HRUHd3Og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 32A07CE0C37; Tue, 16 Apr 2024 19:19:32 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:19:32 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
	Linux Regressions <regressions@lists.linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	linux-snps-arc@lists.infradead.org,
	Vineet Gupta <vgupta@kernel.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Subject: Re: sh: arc: cmpxchg.h:50:12: error: implicit declaration of
 function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
Message-ID: <e782ab32-6276-4947-a1ee-5864dc71dbe5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <CA+G9fYvMdqT3BFNkspktVVtVqd=en8-x3Oz1Ekfia+cceV2LHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYvMdqT3BFNkspktVVtVqd=en8-x3Oz1Ekfia+cceV2LHQ@mail.gmail.com>

On Mon, Apr 15, 2024 at 04:17:01PM +0530, Naresh Kamboju wrote:
> The arc and sh defconfig builds failed due to following build warnings / errors
> on the Linux next-20240415 with gcc-9 and gcc-11.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> Following builds failed.
> sh:
> arc:
>  - defconfig
>  - tinyconfig
>  - allnoconfig
>  - vdk_hs38_smp_defconfig
> 
> Build log:
> --------
> In file included from arch/arc/include/asm/atomic.h:13,
>                  from include/linux/atomic.h:7,
>                  from include/asm-generic/bitops/lock.h:5,
>                  from arch/arc/include/asm/bitops.h:188,
>                  from include/linux/bitops.h:70,
>                  from include/linux/log2.h:12,
>                  from kernel/bounds.c:13:
> include/linux/atomic/atomic-arch-fallback.h: In function 'raw_atomic_cmpxchg':
> arch/arc/include/asm/cmpxchg.h:50:12: error: implicit declaration of
> function 'cmpxchg_emu_u8' [-Werror=implicit-function-declaration]
>    50 |   _prev_ = cmpxchg_emu_u8((volatile u8 *)_p_, _o_, _n_); \
>       |            ^~~~~~~~~~~~~~
> 
> Steps to reproduce:
> ---
> # tuxmake --runtime podman --target-arch arc --toolchain gcc-9
> --kconfig defconfig
> # tuxmake --runtime podman --target-arch sh --toolchain gcc-11
> --kconfig defconfig
> 
> 
> Links:
> ---
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240415/testrun/23463978/suite/build/test/gcc-9-defconfig/details/
>  - https://storage.tuxsuite.com/public/linaro/lkft/builds/2f7sIl2MlKB5Fgq7JtTpYQ9lnXw/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240415/testrun/23463981/suite/build/test/gcc-11-defconfig/details/

Thank you for testing this!  Does the following diff (to be folded into
the originals with attribution) help?

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index c3833e18389f4..40101f9d88d45 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -8,6 +8,7 @@
 
 #include <linux/build_bug.h>
 #include <linux/types.h>
+#include <linux/cmpxchg-emu.h>
 
 #include <asm/barrier.h>
 #include <asm/smp.h>
diff --git a/arch/sh/include/asm/cmpxchg.h b/arch/sh/include/asm/cmpxchg.h
index 27a9040983cfe..726b3ad9c8703 100644
--- a/arch/sh/include/asm/cmpxchg.h
+++ b/arch/sh/include/asm/cmpxchg.h
@@ -9,6 +9,7 @@
 
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/cmpxchg-emu.h>
 
 #if defined(CONFIG_GUSA_RB)
 #include <asm/cmpxchg-grb.h>

