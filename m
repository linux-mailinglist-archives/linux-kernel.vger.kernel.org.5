Return-Path: <linux-kernel+bounces-65570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EE1854EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7DD4284E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC5E60DDE;
	Wed, 14 Feb 2024 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="KMr/uUb6"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3193604CB;
	Wed, 14 Feb 2024 16:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928910; cv=none; b=XXQE2m4GetkY4An3zYqC5t7hpM2kEvkUYw0sjiW+DVb7zN1EKxGm8jfyOvw+7tV6299M06MFRMzvTGFZknPtYwkJxSlFPE+FKgqVNFRKOs06o75+MFvK3/9aJiLJgr3cWhphkSKnammuqmhSJobha3CMGP94aZWIlTsGvB4+bmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928910; c=relaxed/simple;
	bh=Q71/BpMJg/AbWqKP1qYJYFEPWrystXrQwaexXADRFQI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/X6K5IUt6nYyDqiF6ToYwdqbSQWTEXss4Ihc76MNupJALGwyPT2UPaxX4/firSvhAwY4BQ0mHsueQA5jnJ5UlkQDsz1Bdib2ZM+Br7nVvAYG8WFxLhFwcv7EMoUG4OeDVuFckQhNlbR/PFlTx5DLi3lSC0IuYuScUAFmGCqy0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=KMr/uUb6; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id ABAE01A3327;
	Wed, 14 Feb 2024 17:41:44 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707928905; bh=mWZaJmgfhSWtEVIgRgaY/fsWvIsUU9IZYFtOlNYiHBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KMr/uUb6j0nYhwom+VKWjHGvMY7NB+megm25xjcgJ1qMcXzqb/MECJqgd3Wj9U6bW
	 dGKUN/hbKMkhuNY0/L9kNi/2Vu2Qd16/7ScV7CWQNWxE13hd6WV7gv7mU8dYK+7Dn3
	 WCombV/Ju5/DhXQqzSKaUY97Zxwz/MVN76c+3nJjWG7wLSBKdApg46oMgS5RzCRSWw
	 ZVCXhmIc6nS5e2k46nMxJxBcSKiruSLp9ECp73KU3yGyiSw3ky+gZa7PV2uRSUqFSC
	 R/U5HMItUgGvJRUIihuVkRc2mlxbCOaPB51IpKrKTmy1m5TR/5EHWzcE+F7tpPww1M
	 /Q0ONf7ZdyBig==
Date: Wed, 14 Feb 2024 17:41:43 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, Andy
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
Message-ID: <20240214174143.74a4f10c@meshulam.tesarici.cz>
In-Reply-To: <34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	<34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 07:28:35 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On February 14, 2024 6:52:53 AM PST, Dave Hansen <dave.hansen@intel.com> =
wrote:
> >On 2/14/24 03:35, Petr Tesarik wrote: =20
> >> This patch series implements x86_64 arch hooks for the generic SandBox
> >> Mode infrastructure. =20
> >
> >I think I'm missing a bit of context here.  What does one _do_ with
> >SandBox Mode?  Why is it useful? =20
>=20
> Seriously. On the surface it looks like a really bad idea =E2=80=93 basic=
ally an ad hoc, *more* privileged version of user shave.

Hi hpa,

I agree that it kind of tries to do "user mode without user mode".
There are some differences from actual user mode:

First, from a process management POV, sandbox mode appears to be
running in kernel mode. So, there is no way to use ptrace(2), send
malicious signals or otherwise interact with the sandbox. In fact,
the process can have three independent contexts: user mode, kernel mode
and sandbox mode.

Second, a sandbox can run unmodified kernel code and interact directly
with other parts of the kernel. It's not really possible with this
initial patch series, but the plan is that sandbox mode can share locks
with the kernel.

Third, sandbox code can be trusted for operations like parsing keys for
the trusted keychain if the kernel is locked down, i.e. when even a
process with UID 0 is not on the same trust level as kernel mode.

HTH
Petr T

