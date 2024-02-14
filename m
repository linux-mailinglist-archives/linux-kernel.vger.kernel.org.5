Return-Path: <linux-kernel+bounces-65799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D693855202
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:22:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5899E28BB9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBBE12837B;
	Wed, 14 Feb 2024 18:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="geaqp6/G"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436C127B74;
	Wed, 14 Feb 2024 18:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934943; cv=none; b=ssmjPiXj8eVw/w+dLT12sbZwUgAicatgYgb/ePU8301LjGJKaEkK9RVljFgITEWCLQL8BWViWh/3u/aBByyVVBQ4s7MuGsAZM/VCkDHAOwmz83Ph1Y60FH8vV52y68/ro+FZY6ulftk3Z5wslIT3VDRWYG7GOcm70XyI4Z9krFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934943; c=relaxed/simple;
	bh=cxi0K/MaHmKgVzvoFzOwJIVgRtJ/p17H3LH1t03e15I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSRQlEbR5NTUi3vvaWhEyTRsWNpR2IWkRJogUjjONquSl1+vGijyb36PNQvbwFBY+Qz5eit6Xt0/4JsEQdoVxtXoffd/d9ZjbvzUjuThqhkkMtjy+5pTmwxcHJB8AyKfHbSpkwQ4D2dHJEBU/ap8niGjrhsyU6irubVoFQnkAjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=geaqp6/G; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8E7BB1A18DE;
	Wed, 14 Feb 2024 19:22:15 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707934936; bh=tJbAk1tSLxXQwFrYiEG2aQGZJ0OdusHW11rdVdqo1Ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=geaqp6/G7md2TmsavAUsI4+sweFqr6tph+mLkunwt57KrfLl0l568VIoLZ9J+8WXV
	 Sc2MZPHxcQtHU4LJ59amKoBviPzCyL0uooAgStwFy4O1YVaPHHLFlOiiLKWDEhpEcb
	 6U5bYPKSmDK+DNlwiOhlj2LU3wtqYTGKBCtC/2Nqq792MwBFNTAxgHTr96AOFJn8nf
	 7pvC5kRnqVKzePShzkggY4ysSROZofcgpLj+RZY2dy+x/kD2XILZ41ruwGyuh8Y4bt
	 aexbTONqgfDbUQ869P8q3MFkHDwjs5zZYZxWUurYEX+T0tdrfV+jM8fU8fh+xtS4ha
	 YDQ5Oy4dwvbHg==
Date: Wed, 14 Feb 2024 19:22:14 +0100
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
Message-ID: <20240214192214.78734652@meshulam.tesarici.cz>
In-Reply-To: <c424618c-d6c6-430a-8975-8851a617204e@intel.com>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com>
	<c424618c-d6c6-430a-8975-8851a617204e@intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 06:52:53 -0800
Dave Hansen <dave.hansen@intel.com> wrote:

> On 2/14/24 03:35, Petr Tesarik wrote:
> > This patch series implements x86_64 arch hooks for the generic SandBox
> > Mode infrastructure.  
> 
> I think I'm missing a bit of context here.  What does one _do_ with
> SandBox Mode?  Why is it useful?

I see, I split the patch series into the base infrastructure and the
x86_64 implementation, but I forgot to merge the two recipient lists.
:-(

Anyway, in the long term I would like to work on gradual decomposition
of the kernel into a core part and many self-contained components.
Sandbox mode is a useful tool to enforce isolation.

In its current form, sandbox mode is too limited for that, but I'm
trying to find some balance between "publish early" and reaching a
feature level where some concrete examples can be shown. I'd rather
fail fast than maintain hundreds of patches in an out-of-tree branch
before submitting (and failing anyway).

Petr T

