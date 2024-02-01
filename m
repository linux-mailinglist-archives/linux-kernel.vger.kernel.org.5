Return-Path: <linux-kernel+bounces-48305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC93C845A06
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0711C247B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D5A5D498;
	Thu,  1 Feb 2024 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PCKLKH2G"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF635D47C;
	Thu,  1 Feb 2024 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797240; cv=none; b=U8c339bQc5JKEa56UDISXMukvOkja+ZhUNRt/yygA/2GY53KG5Qe5Gu04Ab360QkCjq3I24YuWkn22T45bPPQppvFF4dutrFOKEf5IM2lguJ+fgIUhC0e5dHDNDLviTyPPEeS95YFldz211ptynzDfwnJrA4W3MR/b488Khtlxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797240; c=relaxed/simple;
	bh=ls3Y9r/Uq4irY8NRgnSFG7fUl9lG9vHTYW3B2Qo0Tj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0Tk2psx0Yyg6WSZ6seUVTBSfuhArRN/01sRlSlY4tGJ1NTdS5dLkSI+JX/pPh1BkSg+YvVyOsOhvOgRZH/o7FVm1xoAtUN7cg+T/XjxYCB46Ep2YXv5WmVbLcWr4nMVm1rE1a6L+XeMWsxSbMrqfxRpb2aMi37bM27tF6YIWQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PCKLKH2G reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A2BA140E01A9;
	Thu,  1 Feb 2024 14:20:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 88CsPpaq-GMn; Thu,  1 Feb 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706797233; bh=xLdndXITEY495qtqbGzZcEEPT9mnJ0YIOGrS6BKjJaM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PCKLKH2GkFT3YzrJ8zxsR7Ehs6Wl+PfNG/Dkdd7QMeybdYcaLVfX6ROGM2FM8DBbk
	 pDmdTpb5pJMNFrVM3bhv+5mH2AWEa7s9Eo20bzpQ6+ZU+lDKmz3s9RWhlbe6eti1FG
	 7RQuRZwmEJhvftzGBIvW6P/lCNTx+mrfT/EwpcCYUWdsqMmGAXZYQg41/22/Tbflt1
	 U06MBKgX/d6yq9vauEkcPeB5++5fksDWecFa36Di4P2MISXL66lLnpL00scQSiEsl8
	 0fa2ZI/fuIl+s823oru494flUcBFsw1cZxFsmT9n0ectL4ylZVmnFM9NmcdAkff+aX
	 hCAGks4QivkqDRcO6dxB6SuaYCYlYRVn+L/2PloWZm0L3JCc+k5BWTSImegkx5ijPc
	 SZ9EwSSYSfz+u3u7HS8GnwGT9WsQwvkQKirwjANhNQFv2rC9rZ8nPJXh8QAX07UhQE
	 vl+aCknAX4g3BXtku8hnEml4nARoZVt+isnROhC1t5EvdvwQzB7gB4qu1JAFA8UeqH
	 2eimCKBkVKMISn0JOu2xAnfMLipmuxfgkTTQG8JkiJy9T6ZYfIKDoCmyud8+GRaTCE
	 0Y1/t0JIqsPyfNnGBqv8vzBxC09bpR8gw5cs9iVzXww6lb3NzOHUPL5OLPu9QEEYk6
	 k7cwvBP7UQ5VEXHclrZ1IjG4=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6C90940E016C;
	Thu,  1 Feb 2024 14:20:17 +0000 (UTC)
Date: Thu, 1 Feb 2024 15:20:16 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tong Tiangen <tongtiangen@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	wangkefeng.wang@huawei.com,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-mm@kvack.org, Guohanjun <guohanjun@huawei.com>
Subject: Re: [PATCH -next v4 2/3] x86/mce: rename MCE_IN_KERNEL_COPYIN to
 MCE_IN_KERNEL_COPY_MC
Message-ID: <20240201142016.GFZbuooG9CRoK90U2C@fat_crate.local>
References: <20240111135548.3207437-1-tongtiangen@huawei.com>
 <20240111135548.3207437-3-tongtiangen@huawei.com>
 <20240131070258.GGZbnwov0g918F-FGz@fat_crate.local>
 <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3009aadd-69d6-c797-20b4-95cf926b6dd9@huawei.com>
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 01, 2024 at 07:37:25PM +0800, Tong Tiangen wrote:
> =E5=9C=A8 2024/1/31 15:02, Borislav Petkov =E5=86=99=E9=81=93:
> > On Thu, Jan 11, 2024 at 09:55:47PM +0800, Tong Tiangen wrote:
> > > Currently, there are some kernel memory copy scenarios is also mc s=
afe
> > > which use copy_mc_to_kernel() or copy_mc_user_highpage().
> >=20
> > Both of those end up in copy_mc_enhanced_fast_string() which does
> > EX_TYPE_DEFAULT_MCE_SAFE.
>=20
> OK, how about this commit msg change? :)
>=20
> Currently, there are some kernel memory copy scenarios is also mc safe
> which use copy_mc_to_kernel() or copy_mc_user_highpage(), **both of tho=
se
> end up in copy_mc_enhanced_fast_string() or copy_mc_fragile() which doe=
s
> EX_TYPE_DEFAULT_MCE_SAFE.**
>=20
> In these scenarios, posion pages need to be isolated too. Therefore, a
> macro similar to MCE_IN_KERNEL_COPYIN is required. For this reason, we
> can rename MCE_IN_KERNEL_COPYIN to MCE_IN_KERNEL_COPY_MC, the new macro
> can be applied to both user-to-kernel mc safe copy and kernel-to-kernel
> mc safe copy.

Maybe my question wasn't clear: why is that renaming churn needed at
all? What are you "fixing" here?

What is the problem that you're encountering which needs fixing?

Thx.

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

