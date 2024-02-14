Return-Path: <linux-kernel+bounces-65870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18733855314
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D869AB21FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E5513B782;
	Wed, 14 Feb 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="rR2LV0V5"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CDC134738;
	Wed, 14 Feb 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707938221; cv=none; b=J5P+6mt4WEx6NwvOrxX5gyT9uSdZSwF/NjEcv/jTFZGYbcRxr7R4Q176U8sH/w8oqfpowmitk/+v7LGkYI66bnM2JQA7vq+0xzwCe2BpioW3Zq6nzbdhXoH+rQZBG+6mgy6LCGJX3xj2rn7tvMGYDH64Z3StZ3tUCT6Li3iHhWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707938221; c=relaxed/simple;
	bh=BTzf525kT+FV3jnbMUkzrtWmsNx3xlFJuhkjYdqXJ38=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5ldSrM0fDR5Awils20Ra03f9cgvGDkQsyPBiofmwfZB9i3yORzrBwg5Pz2C/yzjhI9QPnxZZpgnizWxf3h6zlJK6OluVm1eDJmALUngjrQdMD4CygH+YUGbhnzGg514vQtJmmTiX12aK7CwLsumXNdF+eLIXoPdGRko3/VQLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=rR2LV0V5; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 5A4D81A3A18;
	Wed, 14 Feb 2024 20:16:57 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707938218; bh=SANIeE4LUJqtp8FJcgpRO6Z+6oH6sW3ijgTEizl3tyY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rR2LV0V5nf7iWjG/raJitl+/b3Czq8jPiu7eZMAi8w9PdimMCvv+j5ZpK8gou2agU
	 GvcYN+k8lFtGuPBQm+7yDjHyPh9EA8+B29+yvUlxXMR7i9r4LcunwNW1/Z8Is+hH9G
	 a4LpSDBzOYmIc2ewFhvTthZsItsVLzLjclQZuEruemPJIsWTH9l9d5duRluEecx6FR
	 eLjzcxGlZHVSF5XmUkvmbGA3ObemmfA6FKxnbigZiIa0U2CJL94XiJ+DdnCjzB5hQs
	 1b7yarlrsdlFqpHMxjuVmLs3vhpjFkIvCEFsZAO9GqiAjUz2xmlKr8uq9g3XeIgkvx
	 IpecVRcLipkcA==
Date: Wed, 14 Feb 2024 20:16:56 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Xin Li <xin@zytor.com>
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
Subject: Re: [PATCH v1 7/8] sbm: documentation of the x86-64 SandBox Mode
 implementation
Message-ID: <20240214201656.230f58df@meshulam.tesarici.cz>
In-Reply-To: <eec160a4-fc59-4e7e-885f-0384a7ede4cf@zytor.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<20240214113516.2307-8-petrtesarik@huaweicloud.com>
	<eec160a4-fc59-4e7e-885f-0384a7ede4cf@zytor.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 10:37:19 -0800
Xin Li <xin@zytor.com> wrote:

> On 2/14/2024 3:35 AM, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > 
> > Add a section about the x86-64 implementation.
> > 
> > Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > ---
> >   Documentation/security/sandbox-mode.rst | 25 +++++++++++++++++++++++++
> >   1 file changed, 25 insertions(+)
> > 
> > diff --git a/Documentation/security/sandbox-mode.rst b/Documentation/security/sandbox-mode.rst
> > index 4405b8858c4a..84816b6b68de 100644
> > --- a/Documentation/security/sandbox-mode.rst
> > +++ b/Documentation/security/sandbox-mode.rst  
> 
> where is this file?
> 
> I assumed it's newly added, but your patch doesn't say so.

Ah, right, for people who are not on the Cc list of my arch-independent
series, this series is entirely out of context. FWIW the first part is here:

https://lore.kernel.org/lkml/20240214113035.2117-1-petrtesarik@huaweicloud.com/

I wonder, would it be better to resend it with a more complete list of
recipients?

Petr T

