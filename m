Return-Path: <linux-kernel+bounces-116701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B9788A2B6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52E7D1C33C29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351615253B;
	Mon, 25 Mar 2024 10:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="b2sLlp8z"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48C7179974
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 08:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711355673; cv=none; b=imr88eMHsrKlCkaaTqowVE+1KJG7BZvxI8Gd0dIDdOfiBg/EmUjjt/l56cNK07x4KOdOkK/CxYz146mhQQ6FFFxzN+WNxZ9/EGIUQjuYALSUGvg1w8E9k07AGrxK1re/OiPlhsyN45df98zVQMMpCHTcDhh/dBmCUL9+GNBOLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711355673; c=relaxed/simple;
	bh=tPIRFSPxN25LKZa/0qm9RtJhghWTt6/30NQFtcUEX64=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VhxE6FgK6j93QfJLpDvQqXr8PaEL+8Y00Xn9ZRcHv/FKzjN1XZBd1HVILJAHqG/iVAxMhVEhTiIhywLJQ/t3DB349bEU2E2yF/s/i0KbIzdo/175aIih0Nmu1Nkmu39jbCE640axvlVNNBx3FyVElS6a9FuWVZa32UOqrgHR8hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=b2sLlp8z; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 129D61AEE0E;
	Mon, 25 Mar 2024 09:34:21 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1711355661; bh=DOQWHEPRh11dluA0A/Vu5ZC7wXfT5BEZSOr1l8WJ9bg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b2sLlp8z468b/IZqd2c4rt11W5BjIIuPtrURA9lD+izLgO0ftIb0BjHdh8rPRJIEQ
	 A6SNtRxQ9mjJXeDhMoRstYgC9T5iUnOMNrcZlEpCec1sH1Tg8qkSdKp20Z0Gqwdyr9
	 9XdwO06W+1GyX/1SjRM+mbQeyZwvxFIvBfnMcMMYDxkKYWXoLwEfo9flx5ik2J58Z8
	 NaaDxWoMrZr3QFf2J3I9X4McF+1dXlZC5iEXK0so0goXKAUQXRmyeAnea+2/DFObem
	 gkyzhnxqcyiGHyAdcBn1yF3YhTB+YKQVkThbwpy6nourKHGFkITuIWtuVHMnTGonz/
	 gq78+2Tl7mb1A==
Date: Mon, 25 Mar 2024 09:34:20 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Petr Tesarik <petrtesarik@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND
 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "open list:X86
 ENTRY CODE" <linux-kernel@vger.kernel.org>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>
Subject: Re: [PATCH 1/1] x86/entry: Use one cmpq in NMI entry to check RIP
 for nested NMIs
Message-ID: <20240325093420.5de035d7@meshulam.tesarici.cz>
In-Reply-To: <dc48c7c6-1aa9-4bf3-9a0d-f5acd6574228@huaweicloud.com>
References: <20240229083711.721-1-petrtesarik@huaweicloud.com>
	<dc48c7c6-1aa9-4bf3-9a0d-f5acd6574228@huaweicloud.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Mar 2024 16:03:17 +0100
Petr Tesarik <petrtesarik@huaweicloud.com> wrote:

> On 2/29/2024 9:37 AM, Petr Tesarik wrote:
> > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > 
> > Optimize the check whether a nested NMI occurred between repeat_nmi and
> > end_repeat_nmi. Although this is not a hot path, this is standard code to
> > check whether a value is within a given range; it is slightly faster, takes
> > up less bytes of code and saves one entry in the branch predictor.
> > 
> > This patch also removes the only relocation for end_repeat_nmi, removing
> > the need for ANNOTATE_NOENDBR.  
> 
> Any comment on this?

Ping. If you don't like the change, can I at least get an orderly NAK?

(Or have I made it onto an x86 maintainer blacklist?)

Petr T

> Kind regards
> Petr T
> 
> > Signed-off-by: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > ---
> >  arch/x86/entry/entry_64.S | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
> > index 9bb485977629..cae40076e109 100644
> > --- a/arch/x86/entry/entry_64.S
> > +++ b/arch/x86/entry/entry_64.S
> > @@ -1251,13 +1251,10 @@ SYM_CODE_START(asm_exc_nmi)
> >  	 * the outer NMI.
> >  	 */
> >  
> > -	movq	$repeat_nmi, %rdx
> > -	cmpq	8(%rsp), %rdx
> > -	ja	1f
> > -	movq	$end_repeat_nmi, %rdx
> > -	cmpq	8(%rsp), %rdx
> > -	ja	nested_nmi_out
> > -1:
> > +	movq	8(%rsp), %rdx
> > +	subq	$repeat_nmi, %rdx
> > +	cmpq	$(end_repeat_nmi - repeat_nmi), %rdx
> > +	jb	nested_nmi_out
> >  
> >  	/*
> >  	 * Now check "NMI executing".  If it's set, then we're nested.
> > @@ -1383,8 +1380,6 @@ repeat_nmi:
> >  	.endr
> >  	subq	$(5*8), %rsp
> >  end_repeat_nmi:
> > -	ANNOTATE_NOENDBR // this code
> > -
> >  	/*
> >  	 * Everything below this point can be preempted by a nested NMI.
> >  	 * If this happens, then the inner NMI will change the "iret"  
> 


