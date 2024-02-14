Return-Path: <linux-kernel+bounces-65884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67C19855343
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:35:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7581C25F23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B70113B793;
	Wed, 14 Feb 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="DvWDt/wU"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6401E4B7;
	Wed, 14 Feb 2024 19:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939336; cv=none; b=kI5lwwg/B50zqaVqejmV5PaWZSkTf5VQtEGTEYGeq36JtinnU2DdRS8rFkxVrlE0sxvDnsByRgu33vdjOssCC83Zfzvcm9I4g5CH0XZ+tGvN/IiDZT9P27+aOEMcN/koJmAhfjGaPNyAeiknbRpxh5snrD9YfVg24gXVyLfzuJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939336; c=relaxed/simple;
	bh=P4Bh5FcGvSk9durew7iUkAxjBkiLsJ7x2lUEm+PGSW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3RIpKZobWFrul2LOA2rQNRkR15ldWueyLxRYvuLT340LK0WnWUPNN5DV5YzR1aPw/dKHgbEWjDRYIWaBF2qv7enIERcFsQPpc7Jlfp2kEQ/KognVhww7mHiXowheOC5LOSMmShDHpLe4gi8pVoz01AO9OM/sBABA3SzMCVUK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=DvWDt/wU; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id A8D361A4082;
	Wed, 14 Feb 2024 20:35:30 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707939331; bh=P4Bh5FcGvSk9durew7iUkAxjBkiLsJ7x2lUEm+PGSW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DvWDt/wUl3uJfrhp2L+7o5xiIszepQH4gfE2VzxMasWVhcu82Wtz97NmY/RByuJiP
	 lhMOR8uGDaTWlAwK2yc83HLc6jeQsbAQKNTZPWk1EXV/ix1rnZ/7V0F+fFSZ3mZp7k
	 ox6/g+mKYu+MUFjpk1q54peK7qVbc70+HKZqSPoii/u8aEMSwgQdaHCZmdRHrnk/rb
	 K7mjD4+IidrdmKP8Xm3YEPPNdmLkjgY4YBK1IA9ARuprZjcxD6wT/j7ukIuMP7nOLs
	 kkGuLehOiA8Rn6SkieoMjBuUhY/Ylpqe6jhBxEUWidQYnMF3UFw34u3f/iiXjTZ3lJ
	 F1Fs8Rd+iqh6g==
Date: Wed, 14 Feb 2024 20:35:29 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc: "Xu, Pengfei" <pengfei.xu@intel.com>, "tglx@linutronix.de"
 <tglx@linutronix.de>, "luto@kernel.org" <luto@kernel.org>,
 "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
 "brgerst@gmail.com" <brgerst@gmail.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "corbet@lwn.net" <corbet@lwn.net>, "Li, Xin3" <xin3.li@intel.com>,
 "roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "petr.tesarik1@huawei-partners.com" <petr.tesarik1@huawei-partners.com>,
 "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, "x86@kernel.org" <x86@kernel.org>,
 "bp@alien8.de" <bp@alien8.de>, "peterz@infradead.org"
 <peterz@infradead.org>, "rppt@kernel.org" <rppt@kernel.org>,
 "arnd@arndb.de" <arnd@arndb.de>, "mhiramat@kernel.org"
 <mhiramat@kernel.org>, "oleg@redhat.com" <oleg@redhat.com>,
 "keescook@chromium.org" <keescook@chromium.org>, "Huang, Kai"
 <kai.huang@intel.com>, "jacob.jun.pan@linux.intel.com"
 <jacob.jun.pan@linux.intel.com>, "zegao2021@gmail.com"
 <zegao2021@gmail.com>, "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com"
 <mingo@redhat.com>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>, "Rodel,
 Jorg" <jroedel@suse.de>, "Zhang, Tina" <tina.zhang@intel.com>, "Hansen,
 Dave" <dave.hansen@intel.com>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "akpm@linux-foundation.org"
 <akpm@linux-foundation.org>, "dave.hansen@linux.intel.com"
 <dave.hansen@linux.intel.com>, "petrtesarik@huaweicloud.com"
 <petrtesarik@huaweicloud.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Message-ID: <20240214203529.68eccc68@meshulam.tesarici.cz>
In-Reply-To: <78fe4fdefa4f427b3fb1b6968d8799035c0c4124.camel@intel.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	<34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com>
	<20240214174143.74a4f10c@meshulam.tesarici.cz>
	<a27c9c32e410fc3582f3593f209cc1cf3b287042.camel@intel.com>
	<20240214193241.7447a082@meshulam.tesarici.cz>
	<78fe4fdefa4f427b3fb1b6968d8799035c0c4124.camel@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 19:19:27 +0000
"Edgecombe, Rick P" <rick.p.edgecombe@intel.com> wrote:

> On Wed, 2024-02-14 at 19:32 +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > > What use case needs to have the sandbox both protected from the
> > > kernel
> > > (trusted operations) and non-privileged (the kernel protected from
> > > it
> > > via CPL3)? It seems like opposite things. =20
> >=20
> > I think I have mentioned one: parsing keys for the trusted keyring.
> > The
> > parser is complex enough to be potentially buggy, but the security
> > folks have already dismissed the idea to run it as a user mode
> > helper. =20
>=20
> Ah, I didn't realize the kernel needed to be protected from the key
> parsing part because you called it out as a trusted operation. So on
> the protect-the-kernel-side it's similar to the microkernel security
> reasoning.
>=20
> Did I get the other part wrong - that you want to protect the sandbox
> from the rest of kernel as well?

Protecting the sandbox from the rest of the kernel is out of scope.
However, different sandboxes should be protected from each other.

Petr T

