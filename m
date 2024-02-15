Return-Path: <linux-kernel+bounces-66343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5FF855AEB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB0A1F28DC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D8ACA4A;
	Thu, 15 Feb 2024 06:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="nxpdnMIW"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5542F32;
	Thu, 15 Feb 2024 06:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980380; cv=none; b=FdF7IT99lk+TW/tj3NjdiCDinGctpyBZOAyUldhk2tiLQKtFHnynlE0VSAEzpNw3zaHVJhHqRH7L9QwSqqUvJFUzRU56RwBpollMMFiP0VWSLLz9diTiIkLWJRftpxlVHvEq5Ga5gpof6M2VCo1HSqq1ZWG9FcZmfWkQnNV9kpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980380; c=relaxed/simple;
	bh=qzOGqei22NimszAMZMCbbU4jpZ8GVSl46n2BIQr07lA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+PetAnmkJAHhqtF53CpbxTj7nzR5Hh49IsPylErwLsZwpBdDK1+vOnQl5KzX0ssIowl2JCNxWRSkUGnTHS9TJZuwxGPCh8deN+WCjFVDmmelrcmYIvpRGK4Jgmnt9j523bSzycJhyGcjE4I9QM6Hx9ZvS/BZaIVJu1Di0ylDmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=nxpdnMIW; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E5B161A550F;
	Thu, 15 Feb 2024 07:59:32 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707980373; bh=N3MdoAZ1DKJLzJ3/B57rICtVu3+OvUZ4JT3UZwNYmbA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nxpdnMIWkYfe1SQrl5ajZ5tEcVh53WpUqYtTr4X98v6vWSCu758VqhJjEI+ZZaSk0
	 L+dHXndDE6dmreyDBxpZBwLwmleAT4uXRCpLDxvi4PaRHVYD7hUtDJW4/py+eSf3q0
	 YWJBYD2L0n3H8USshqA3mKBj92w9AavaKHKSlaembDheXZz1F0hclI0xC7w185Xpi4
	 gCBo3hdkSnUzWp+XcFeEQ03ADLqdN9WJpwBrYgoblb7gxplnvoN7RrFB3NGofa5w4K
	 iI3BGoKCiqgGshwF2T8vL/TmCqh+VqlYgLll8s4Fzeq8baC68s3VrOlDEhTKJxCn9F
	 utYiobdf6cb2Q==
Date: Thu, 15 Feb 2024 07:59:32 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Xin Li <xin@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H.
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Oleg
 Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Xin Li
 <xin3.li@intel.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Morton
 <akpm@linux-foundation.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Kees Cook <keescook@chromium.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Pengfei Xu <pengfei.xu@intel.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Kai Huang <kai.huang@intel.com>, David
 Woodhouse <dwmw@amazon.co.uk>, Brian Gerst <brgerst@gmail.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>, "Mike Rapoport
 (IBM)" <rppt@kernel.org>, Tina Zhang <tina.zhang@intel.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Message-ID: <20240215075932.66fef954@meshulam.tesarici.cz>
In-Reply-To: <c66fa3f4-13f0-4355-9bf4-34fec31182de@zytor.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	<20240214192214.78734652@meshulam.tesarici.cz>
	<c66fa3f4-13f0-4355-9bf4-34fec31182de@zytor.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 10:52:47 -0800
Xin Li <xin@zytor.com> wrote:

> On 2/14/2024 10:22 AM, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 14 Feb 2024 06:52:53 -0800
> > Dave Hansen <dave.hansen@intel.com> wrote:
> >  =20
> >> On 2/14/24 03:35, Petr Tesarik wrote: =20
> >>> This patch series implements x86_64 arch hooks for the generic SandBox
> >>> Mode infrastructure. =20
> >>
> >> I think I'm missing a bit of context here.  What does one _do_ with
> >> SandBox Mode?  Why is it useful? =20
> >=20
> > I see, I split the patch series into the base infrastructure and the
> > x86_64 implementation, but I forgot to merge the two recipient lists.
> > :-(
> >=20
> > Anyway, in the long term I would like to work on gradual decomposition
> > of the kernel into a core part and many self-contained components.
> > Sandbox mode is a useful tool to enforce isolation.
> >=20
> > In its current form, sandbox mode is too limited for that, but I'm
> > trying to find some balance between "publish early" and reaching a
> > feature level where some concrete examples can be shown. I'd rather
> > fail fast than maintain hundreds of patches in an out-of-tree branch
> > before submitting (and failing anyway).
> >=20
> > Petr T
> >  =20
>=20
> What you're proposing sounds a gigantic thing, which could potentially
> impact all subsystems.

True. Luckily, sandbox mode allows me to move gradually, one component
at a time.

>  Unless you prove it has big advantages with real
> world usages, I guess nobody even wants to look into the patches.
>=20
> BTW, this seems another attempt to get the idea of micro-kernel into
> Linux.

We know it's not feasible to convert Linux to a micro-kernel. AFAICS
that would require some kind of big switch, affecting all subsystems at
once.

But with a growing code base and more or less constant bug-per-LOC rate,
people will continue to come up with some ideas how to limit the
potential impact of each bug. Logically, one of the concepts that come
to mind is decomposition.

If my attempt helps to clarify how such decomposition should be done to
be acceptable, it is worthwile. If nothing else, I can summarize the
situation and ask Jonathan if he would kindly accept it as a LWN
article...

Petr T

