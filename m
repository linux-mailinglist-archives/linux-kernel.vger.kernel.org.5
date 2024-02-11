Return-Path: <linux-kernel+bounces-60695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B818508A5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01341F21796
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132705A11D;
	Sun, 11 Feb 2024 10:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b="Jd9A54zX"
Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AE37149;
	Sun, 11 Feb 2024 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707647554; cv=none; b=EfDOLZYBCA9Wzw8sLXShc4eX4+w+4b/DTWUlFjAOl4VpW/32uKCVPvAV+6SK02ZxtgNt84TVfWq0ejxTCtfKRr8anrGuAjQr8WI8zN5IEp6LzPZnmIOmVq4qSqQugRYQ+l1hNmbCTuLmq9swcuTr/MZeakDrd3ymjg9I7B+Thd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707647554; c=relaxed/simple;
	bh=etRjsipeELaWCrmPD0sbIzv/CUhY77/idogMRUDkIGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tR4dL7veUBBMnIf8SLlnhntLNTCVRaWj5lG0S4lJ+Bkbtm8d1Xy+FTQIgQ6x4y65k21RDdW3ORrSnd+cfkbLpwXTPtti39FbohoXxm0bZkI4JyNA4QUILCSRgKUefXrajFGUFLpe15DZ3AaaCcgPTRInORpClMGcZ+7nxHX6BFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; dkim=pass (4096-bit key) header.d=envs.net header.i=@envs.net header.b=Jd9A54zX; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 2EB1F38A0673;
	Sun, 11 Feb 2024 10:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
	t=1707647542; bh=dLh7MlVuk355kto4z+2BT9WqRjzdR9Gl3cXp8/KeMec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jd9A54zXfJ1xQmZ6O4wlZ1OPR2ame5KhRLXD1s0iYIb4wB6Xn0HQgUWPgiBldl00Y
	 hCSRTlbzcMI60Kmn4XoYF2kxpck/0hCE7rZYYKrPwt/X+3cYZHsrncO9qnVfGUlAF+
	 D/hnz1QnoLFIbv2ONMvYSU0VAH+9MGB/unrU6CL9Q+sxRqS0n2pSvBaGJN8zwltopJ
	 FUqzFc+cNF9ovSkVbcnuLIgE6csHcCsRZy0xAODusFEpvhhyemV+WBWytlFmHK0O/d
	 mPEgZez+T/e6dItllz5fgVA+SOTZoAzOIPkZjTz4xU6nNkf55z5VjK1c+DLNg4uIXy
	 9+uy6gZKghfV6Cj/eLEQUWf3+BES12+z51bgbzdNVOlsJocPL1bsByECK80WcpCRAs
	 9CnruCSy6Y95CXJtbD34tYfIm6EakRvlIom6YzZDW+tDRdc1mgIz302UNgNrcv/m8x
	 NFnS34NbU5AUDgjDcPWrFhj8X+eUUdltEADHTXaxLWmSMjwjy8+NNAzY+DHurungbs
	 CH8eQc4ufGNqSmF28IUn6/pQ2oJ1zqI05MBrWFF49OQPLjf6F3Iv6XVX9GR0dgCRng
	 pY00VZciZ75yI1PtwTeDloj/tBy57e3g7zK6it+g/tDci0UbYey5vHApQLQcheT2Ha
	 rdf0UH3FDXjINE85+27U8oWI=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id M1aevNjCSz4D; Sun, 11 Feb 2024 10:31:41 +0000 (UTC)
Received: from xtex.localnet (unknown [103.84.217.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Sun, 11 Feb 2024 10:31:41 +0000 (UTC)
From: xtex <xtex@envs.net>
To: Nicolas Schier <nicolas@fjasle.eu>, Masahiro Yamada <masahiroy@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Nathan Chancellor <nathan@kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: Abort make on install failures
Date: Sun, 11 Feb 2024 18:31:36 +0800
Message-ID: <2646117.S0smAIiGLA@xtex>
In-Reply-To:
 <CAK7LNAQPm7PXoKM+id25wX9AtVmmXvE7i8GrGB9etU__EMUwdg@mail.gmail.com>
References:
 <20240210074601.5363-1-xtex@envs.net> <ZcfoZKJHkdEh5JmV@fjasle.eu>
 <CAK7LNAQPm7PXoKM+id25wX9AtVmmXvE7i8GrGB9etU__EMUwdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Sunday, February 11, 2024 7:35:35 AM CST Masahiro Yamada wrote:
> 
> The separate 'set -e' statement works for both cases,
> so I think this is safer, though it is kind of bike-shedding.

Thanks!
I also think it is safer to use 'set -e' in the case of 'sh install.sh',
 so I support not to use 'sh -e' in the shebang line. The planned V2 patch for 
this disappeared.

-- 
Zhang Bingwu @ Sun Feb 11 10:27:48 AM UTC 2024




