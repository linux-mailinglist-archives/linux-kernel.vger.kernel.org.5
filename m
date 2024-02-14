Return-Path: <linux-kernel+bounces-65883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5D7855340
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45CC281B7A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D7113B78C;
	Wed, 14 Feb 2024 19:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="XgQsAz2b"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2D11E4B7;
	Wed, 14 Feb 2024 19:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939219; cv=none; b=h++XiKbKOtPxJyi5/fYNAeWiiZkl17iS4Ww/IcPZ6+Vm2buUWRS35ymk2HxtfbSODhO8AkqaxaXAEwcKZgWXdTYoM/7Am61TmpSzXrT9cEAGBuMqmq13tQLo97ZBSMduwVIY3UADjooykexGb9PaNdCLEL8aHZtp0L0fDVZBBbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939219; c=relaxed/simple;
	bh=3Uxw2BBpPfLn6Mh91wTNWE4KZxWkqy1JIOiIb4xxOw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8NAbgT5/qEbje1zQRbC4dsKqXPRYFPI5GYM1HxBLgp+uKfLuvHIT07Ik2nIxf4+VNdf4v6wn1zHtNJXDonF5aYgNC8rgi+H7ZKajfNkjsY7PTJhon05+8SkyKv9Xnc5VaHaA7BhP15qBy0u4h0utlfNDARgqNrJenDSV/UbYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=XgQsAz2b; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id A0FE91A36A5;
	Wed, 14 Feb 2024 20:33:32 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707939213; bh=3C0Q3eC899xoDvzLqtNRjkK3NL6o8Y9GbWdF64ouq0c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XgQsAz2bWVerxxg+fZgeInCVn9WFce0qUwc6Tc4ZaxsDMTcbA2LE5RjETQhfiPqr/
	 D+WYw0uMYvdygK4CKZiJ8SxMDMgUylgSIRC9mlCfKiN3i2VWRzhmT7l1Cj66KWk30b
	 b1eUgbW6kuV3BvyEXHX1KAlOTY8eULSfy28CgIiC2WuVqUbKblvFMbTn+0qkc2EmEZ
	 ipfLU3qkjBWRDpNaA/cJFtm/bP9zoVc58itsqmWl5De7tKaK11cwBU9nIqkFwrrvkM
	 KVvLsOgOyEAEt28tHBT8AorMWz/IK/k/0FAc9qLPpogDSuWKDoGBmBlPH1UHL8M8Wa
	 rUBFW/Bt/zRRA==
Date: Wed, 14 Feb 2024 20:33:31 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, Jonathan Corbet
 <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Andy
 Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Kees Cook <keescook@chromium.org>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Pengfei Xu
 <pengfei.xu@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao
 <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Message-ID: <20240214203331.240a6863@meshulam.tesarici.cz>
In-Reply-To: <a762aaba-feb7-46ab-9e13-cea3a097311e@intel.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	<20240214192214.78734652@meshulam.tesarici.cz>
	<a762aaba-feb7-46ab-9e13-cea3a097311e@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 10:42:57 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/14/24 10:22, Petr Tesa=C5=99=C3=ADk wrote:
> > Anyway, in the long term I would like to work on gradual decomposition
> > of the kernel into a core part and many self-contained components.
> > Sandbox mode is a useful tool to enforce isolation. =20
>=20
> I'd want to see at least a few examples of how this decomposition would
> work and how much of a burden it is on each site that deployed it.

Got it. Are you okay with a couple of examples to illustrate the
concept? Because if you want patches that have been acked by the
respective maintainers, it somehow becomes a chicken-and-egg kind of
problem...

> But I'm skeptical that this could ever work.  Ring-0 execution really is
> special and it's _increasingly_ so.  Think of LASS or SMAP or SMEP.

I have just answered a similar concern by hpa. In short, I don't think
these features are relevant, because by definition sandbox mode does
not share anything with user mode address space.

> We're even seeing hardware designers add hardware security defenses to
> ring-0 that are not applied to ring-3.
>=20
> In other words, ring-3 isn't just a deprivileged ring-0, it's more
> exposed to attacks.
>=20
> > I'd rather fail fast than maintain hundreds of patches in an
> > out-of-tree branch before submitting (and failing anyway). =20
>=20
> I don't see any remotely feasible path forward for this approach.

I can live with such decision. But first, I want to make sure that the
concept has been understood correctly. So far, at least some concerns
suggest an understanding that is not quite accurate.

Is this sandbox idea a bit too much out-of-the-box?

Petr T

