Return-Path: <linux-kernel+bounces-66547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BE0855E2E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B29F28A4C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B25182D8;
	Thu, 15 Feb 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="HL3FvJFS"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE89018037;
	Thu, 15 Feb 2024 09:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989469; cv=none; b=J7Nl4ICy781xOomvGDcVxrEO/IBGsdpwH3nWQMaLMLP/0n09jeE77sA+sCoxam6LYIfFcf9QN5wYisseRs0wHaR6OkjPixJN2zjjxx2KhdlUVmdVVmTYDgzew6GQyE+4XzY/H7rME2TnfXBlnsg1e/ov+7MJcFdLZWw61CiQ1Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989469; c=relaxed/simple;
	bh=IGUUgoQv8fEzz2nY3/U/CkDsbN0lZVUbVVLYQfpeQAI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPf/kA8R9e1n64tolJCAx91+2rVODAtvEgtfPCqtssUANDGQ9EdoS6vB7UVzygyg9N2tkVdbgxiZZAazZMaRT0vqj/+uef09/FUkXIWHXrcyM6imjNf7gCsclB5Jo9BB7QU4CNOi12gVaR0DsuiKU6/mimqKQ8zoVaTdrDdCF0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=HL3FvJFS; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 6DAC91A601E;
	Thu, 15 Feb 2024 10:30:59 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707989460; bh=dKEi4/z9hKMT6w7OFzhXiUpF0cBZZojtikynuA7xrqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HL3FvJFSNEEFF47AcfBwODUkLgp9ZS9Lm/nJwHw5qdhaOTSKSiq9y5yXF05yoUkai
	 p07ETT8dae0IPABgfAtv6lR0MR1uGbZ9vOSCIb09WGCli5wLVuRZHmd+9BHqrQ6/cg
	 DZWUAAPZQ4IzNjJCHQ8GhiwTyIBeVq9q8HSA2f/YM436ezs5ZcMcxIZT3cZqW+Ty0d
	 imXFAdBer3Fwk85ODUaBRailji2nC8RR1b1dNNieT6t/0bhNtda2oQqm3CYI9mIodS
	 xuIUzZA47sjRLwdXMaQ6Yvi67EBmRiHjexQK8hvEnkrXy9XGi8lhr50W5idNjkUsQA
	 lz+8S/RS9tY4Q==
Date: Thu, 15 Feb 2024 10:30:58 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "H. Peter Anvin" <hpa@zytor.com>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Cc: Xin Li <xin@zytor.com>, Dave Hansen <dave.hansen@intel.com>, Petr
 Tesarik <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
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
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, Petr
 Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
Message-ID: <20240215103058.52461397@meshulam.tesarici.cz>
In-Reply-To: <5434F240-2F74-4D9F-8BEE-220C8EC53C0F@zytor.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<c424618c-d6c6-430a-8975-8851a617204e@intel.com>
	<20240214192214.78734652@meshulam.tesarici.cz>
	<c66fa3f4-13f0-4355-9bf4-34fec31182de@zytor.com>
	<20240215075932.66fef954@meshulam.tesarici.cz>
	<5434F240-2F74-4D9F-8BEE-220C8EC53C0F@zytor.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Feb 2024 00:16:13 -0800
"H. Peter Anvin" <hpa@zytor.com> wrote:

> On February 14, 2024 10:59:32 PM PST, "Petr Tesa=C5=99=C3=ADk" <petr@tesa=
rici.cz> wrote:
> >On Wed, 14 Feb 2024 10:52:47 -0800
> >Xin Li <xin@zytor.com> wrote:
> > =20
> >> On 2/14/2024 10:22 AM, Petr Tesa=C5=99=C3=ADk wrote: =20
> >> > On Wed, 14 Feb 2024 06:52:53 -0800
> >> > Dave Hansen <dave.hansen@intel.com> wrote:
> >> >    =20
> >> >> On 2/14/24 03:35, Petr Tesarik wrote:   =20
> >> >>> This patch series implements x86_64 arch hooks for the generic San=
dBox
> >> >>> Mode infrastructure.   =20
> >> >>
> >> >> I think I'm missing a bit of context here.  What does one _do_ with
> >> >> SandBox Mode?  Why is it useful?   =20
> >> >=20
> >> > I see, I split the patch series into the base infrastructure and the
> >> > x86_64 implementation, but I forgot to merge the two recipient lists.
> >> > :-(
> >> >=20
> >> > Anyway, in the long term I would like to work on gradual decompositi=
on
> >> > of the kernel into a core part and many self-contained components.
> >> > Sandbox mode is a useful tool to enforce isolation.
> >> >=20
> >> > In its current form, sandbox mode is too limited for that, but I'm
> >> > trying to find some balance between "publish early" and reaching a
> >> > feature level where some concrete examples can be shown. I'd rather
> >> > fail fast than maintain hundreds of patches in an out-of-tree branch
> >> > before submitting (and failing anyway).
> >> >=20
> >> > Petr T
> >> >    =20
> >>=20
> >> What you're proposing sounds a gigantic thing, which could potentially
> >> impact all subsystems. =20
> >
> >True. Luckily, sandbox mode allows me to move gradually, one component
> >at a time.
> > =20
> >>  Unless you prove it has big advantages with real
> >> world usages, I guess nobody even wants to look into the patches.
> >>=20
> >> BTW, this seems another attempt to get the idea of micro-kernel into
> >> Linux. =20
> >
> >We know it's not feasible to convert Linux to a micro-kernel. AFAICS
> >that would require some kind of big switch, affecting all subsystems at
> >once.
> >
> >But with a growing code base and more or less constant bug-per-LOC rate,
> >people will continue to come up with some ideas how to limit the
> >potential impact of each bug. Logically, one of the concepts that come
> >to mind is decomposition.
> >
> >If my attempt helps to clarify how such decomposition should be done to
> >be acceptable, it is worthwile. If nothing else, I can summarize the
> >situation and ask Jonathan if he would kindly accept it as a LWN
> >article...
> >
> >Petr T
> > =20
>=20
> I have been thinking more about this, and I'm more than ever convinced th=
at exposing kernel memory to *any* kind of user space is a really, really b=
ad idea. It is not a door we ever want to open; once that line gets muddled=
, the attack surface opens up dramatically.

Would you mind elaborating on this a bit more?

For one thing, sandbox mode is *not* user mode. Sure, my proposed
x86-64 implementation runs with the same CPU privilege level as user
mode, but it is isolated from user mode with just as strong mechanisms
as any two user mode processes are isolated from each other. Are you
saying that process isolation in Linux is not all that strong after all?

Don't get me wrong. I'm honestly trying to understand what exactly
makes the idea so bad. I have apparently not considered something that
you have, and I would be glad if you could reveal it.

> And, in fact, we already have a sandbox mode in the kernel =E2=80=93 it i=
s called eBPF.=20

Sure. The difference is that eBPF is a platform of its own (with its
own consistency model, machine code etc.). Rewriting code for eBPF may
need a bit more effort.

Besides, Roberto wrote a PGP key parser as an eBPF program at some
point, and I believe it was rejected for that reason. So, it seems
there are situations where eBPF is not an alternative.

Roberto, can you remember and share some details?

Petr T

