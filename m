Return-Path: <linux-kernel+bounces-92205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA5871CC1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C942D1C22B52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DBD548F0;
	Tue,  5 Mar 2024 10:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="X7C4VvEe"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577DF59B7F;
	Tue,  5 Mar 2024 10:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636376; cv=none; b=aZz03g1KirEZW+iCT4kNzJbaAwc+A++gSJtpE46aUl58h0pIQFPRRfByPNJNvKGhhNzHD57ChrWTKMpwpP1DOgko5zPn1HzVskTEG3ZTzedOzeyvlWrAhMFFVLpAsYY+lGsfP1O2SVSInrO48+DmRE/RMgt6Oo+RFMe0GnZdvgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636376; c=relaxed/simple;
	bh=rkU/EUWBtwWWABqUxTFkTNu+QCtdjbQlVV4iGQMgjT8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m2JUoL61m6nwAzeLs7V1xWdu+Z76w4eci5hdBe9OpDw49sp4Y31fOleCVVNzBDaSNEUBvF8xPWPehptTjyGWupux3YPQ1OneutJdPKb4mERinxuRtOiLnbyrRfoXxkpm3S/yyCVfPa7fXKtRamGRjuuRPQ36RSiQoUSXy9gxZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=X7C4VvEe; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=FUU17H/883Su4y5t0ORguJT8aM0bkdnEyWS9d9zukeE=;
	t=1709636375; x=1710845975; b=X7C4VvEe0XoukI77UaTDV4bGeCXBV771Gu9ERiz88HDBiMA
	wiNhlP1PONCTqxxUB9re9XIa88z3+CUro2HByrE1SwpDCdmvJ9HpF6TuZok1Fd4UpvUKgtgeg1AO/
	0vlwVi61MyGG2XAo8o11z/RxWuMl+aNIbXcBVj0pouC7eK8arBWgyrhCIT8tdKCfgrVLIKd+PbO9V
	G/oFZNV3Uy8fq6YJZcgmiGaNWrnsz/DSuBFPGa+1OSISxTVNDNv7guStZ8OyeTzVhDLBGavPzligP
	ihDx+kYtd9pcb9l2YFWRSJVg8dShtvbYbV2G+j6R2scs2U/kaX2K0cICt89n95ZA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rhSVn-00000002j5H-3fnE;
	Tue, 05 Mar 2024 11:59:08 +0100
Message-ID: <65f6e65e90ca5f134ef1a238a38ab02a6c1c3360.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all
 architectures
From: Johannes Berg <johannes@sipsolutions.net>
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook
 <keescook@chromium.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet
 Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin
 Marinas <catalin.marinas@arm.com>, Guo Ren <guoren@kernel.org>, Brian Cain
 <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, Geert
 Uytterhoeven <geert@linux-m68k.org>, Michal Simek <monstr@monstr.eu>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Helge Deller
 <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Palmer Dabbelt <palmer@dabbelt.com>, John
 Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,  Andreas Larsson
 <andreas@gaisler.com>, Richard Weinberger <richard@nod.at>, x86@kernel.org,
 Max Filippov <jcmvbkbc@gmail.com>, Andy Lutomirski <luto@kernel.org>, Jan
 Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org,  linux-um@lists.infradead.org
Date: Tue, 05 Mar 2024 11:59:05 +0100
In-Reply-To: <20240226161414.2316610-4-arnd@kernel.org>
References: <20240226161414.2316610-1-arnd@kernel.org>
	 <20240226161414.2316610-4-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-02-26 at 17:14 +0100, Arnd Bergmann wrote:
>=20
>  arch/um/Kconfig                    | 1 +
>  arch/um/include/asm/page.h         | 2 +-


LGTM, thanks.

Acked-by: Johannes Berg <johannes@sipsolutions.net>

johannes

