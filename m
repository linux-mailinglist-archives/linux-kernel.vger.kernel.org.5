Return-Path: <linux-kernel+bounces-149957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA538A9858
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECA5E282DFF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C03515E5B0;
	Thu, 18 Apr 2024 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l6a+QUyp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ODGVWrPh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F6615D5A8;
	Thu, 18 Apr 2024 11:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713438763; cv=none; b=qKPBrcxTL6Ffntnp+F2FjHuXq0UUIvHww4BebUagiE8fDi7VbTuemO28Iw4mR8+psBOwV4J39+rBRZ+OpPqmSRCykbdFpiIUWMHvSRLiQcpX/cz8F772oi1BPVCPOmUIZQZWVJWqBX0kjJ2znaEhGAU0qBDEU2nKGu/tpbpWFBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713438763; c=relaxed/simple;
	bh=fNlxzM+FeEWS046ooaGKqIMrCq4ZXCHkyzA7h0Mb/9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEhhiNxkkQPQzkpNTmJeLuMAaa41xe6/iZpfEKOAHB7ThmCvacHPKi6uJeiri+D6mnlWjt2fknoPuYPMHE9kL4LaqBLO+rZjaIKlyk47R6Mq4/oU8NpKA+K0XWWIlM+UzXrAtoBCmHgQchaPxiODrN7de/syydPgS3zqvuswjwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l6a+QUyp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ODGVWrPh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Apr 2024 13:12:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713438759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCv9ASSWxGZcIN7EnwuxCIn0p9FkfWST0gNno06amaQ=;
	b=l6a+QUypxbl9h555q2yiw/t94zDEElznKUzGxGLAY/rHnR02Y/nSIP4bBAiuhDhJDVZUK5
	H7Np4stZZGUcBsoAjV4oysMkigqHK4i2tspfqn9A4bR1K54JUR9lxe+/RIfaJu3RwmVrS2
	7P6Bte7YnLDphUF1DtMd4oS3ccYZQTcjjXSic9zRlTt1gNqwO0q7KsZlY6/+E1Vvk50bHR
	GUeCDi7Nnkfzr4+5dYFOKNdrVCpxFh9lpbZfAKlZEmX7qQVbNeNAqfpugKtYCEAKNEJ470
	ZLMjEUwZ8XEQj7TEjffWRS5wc/xE8vPB+Xl+nB1Hd5iemqeNli8Bkz5+N+3Hrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713438759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nCv9ASSWxGZcIN7EnwuxCIn0p9FkfWST0gNno06amaQ=;
	b=ODGVWrPhBwMPbqT0n48i9td51IgqEIAiB+5frU9luBafGaLa8VPMmXOcF4TATtx3YH0bzt
	ghlP4tJrhhPeHEBA==
From: Nam Cao <namcao@linutronix.de>
To: Mike Rapoport <rppt@kernel.org>, Andreas Dilger <adilger@dilger.ca>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 linux-riscv@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, "ndesaulniers @ google . com"
 <ndesaulniers@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Ingo
 Molnar <mingo@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Tejun Heo <tj@kernel.org>, Krister Johansen <kjlx@templeofstupid.com>,
 Changbin Du <changbin.du@huawei.com>, Arnd Bergmann <arnd@arndb.de>, Geert
 Uytterhoeven <geert+renesas@glider.be>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] init: fix allocated page overlapping with PTR_ERR
Message-ID: <20240418131238.636bee2c@namcao>
In-Reply-To: <20240418102943.180510-1-namcao@linutronix.de>
References: <20240418102943.180510-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2024-04-18 Nam Cao wrote:
> There is nothing preventing kernel memory allocators from allocating a
> page that overlaps with PTR_ERR(), except for architecture-specific
> code that setup memblock.
>=20
> It was discovered that RISCV architecture doesn't setup memblock
> corectly, leading to a page overlapping with PTR_ERR() being allocated,
> and subsequently crashing the kernel (link in Close: )
>=20
> The reported crash has nothing to do with PTR_ERR(): the last page
> (at address 0xfffff000) being allocated leads to an unexpected
> arithmetic overflow in ext4; but still, this page shouldn't be
> allocated in the first place.
>=20
> Because PTR_ERR() is an architecture-independent thing, we shouldn't
> ask every single architecture to set this up. There may be other
> architectures beside RISCV that have the same problem.
>=20
> Fix this one and for all by reserving the physical memory page that
> may be mapped to the last virtual memory page as part of low memory.
>=20
> Unfortunately, this means if there is actual memory at this reserved
> location, that memory will become inaccessible. However, if this page
> is not reserved, it can only be accessed as high memory, so this
> doesn't matter if high memory is not supported. Even if high memory is
> supported, it is still only one page.
>=20
> Closes: https://lore.kernel.org/linux-riscv/878r1ibpdn.fsf@all.your.base.=
are.belong.to.us
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Cc: <stable@vger.kernel.org> # all versions

Sorry, forgot to add:
Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

> ---
>  init/main.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/init/main.c b/init/main.c
> index 881f6230ee59..f8d2793c4641 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -900,6 +900,7 @@ void start_kernel(void)
>  	page_address_init();
>  	pr_notice("%s", linux_banner);
>  	early_security_init();
> +	memblock_reserve(__pa(-PAGE_SIZE), PAGE_SIZE); /* reserve last page for=
 ERR_PTR */
>  	setup_arch(&command_line);
>  	setup_boot_config();
>  	setup_command_line(command_line);


