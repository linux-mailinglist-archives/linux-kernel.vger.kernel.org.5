Return-Path: <linux-kernel+bounces-51024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9929684852B
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 11:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4413DB26657
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2105D73E;
	Sat,  3 Feb 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZMGm9u9a"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC2E5C91A
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706955604; cv=none; b=eM7CssUeJmfIgu1Fsql/i9F6ZTANzp/zNNF9WxR4K/3V+Fpn7aZbH0TY4kNYt8T3wIlQYFdv00f2R1tKrNzxpxzmgtmB33gcl/HpdZ6cSMzqemnL7DywVbwXHDeReqhvkZDcnKlRimT2BMiWLeCoQSi9q69myMqv7Q7MJxVBHDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706955604; c=relaxed/simple;
	bh=PVKxAsYPQohK0Nj/GK+q1ZmGmqklyWwfThPeHDKkpRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyyBpNLahrYoRwTnnc/guXZlY5UqJumLw5wIn6GmFXE/0Bg5w5hDI8UJsCRPTqbqLK7laJh7BAV27Evqufb4iSLzUv5W4lPt1NrLnpU5+Ht2n741f5fMx7aa4M8xJQkxYoNPeVYlnjMGI2XruwcEkXj+IbE1XNT18o7WIrefZms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZMGm9u9a; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BC50C40E01A9;
	Sat,  3 Feb 2024 10:19:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 0tpSz7JZZM7c; Sat,  3 Feb 2024 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706955597; bh=2zyWyVqFNtMTEIdHrsP05059AHmN6V8QJQNY6SWCBbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZMGm9u9acJLuhOw2QRKAusUZ83IveTFWrLShnMkmC/rVfjIb3vb4aFNETN+qrS+1b
	 aAGFfZVBEx4YJbsO/7ARE7Yg3UTe4SOupTSLg38l1RvzpnuUGDwAzfBTYAOF9Uiqy5
	 9++twFAUX73uVzN5u3/W75mTjPXD14TF20NMLl5A37maHVujR+HVoOOM0FYkpjkUBo
	 JK7h06alNIvKlDdkpA/w22Szo/126zKhE5wjIOQ6SrEBTUcGxBzNty79Y/RyQ0fBVO
	 IoBlu8ZrK8+Niy1t0lETFexiV9yMevDNlLh4CEdUs+qmfheM4UOi1VEMS/ZRyRq65k
	 oNgnNG65SGFyRG8u919Lm95E4h2sEfCuHy9LtYVGCFruv3JGCeIbLCIUuQ1hprl5MS
	 6EeKFRiLiQ7i0smvqIvwwNXUEJwl9nXltHFfQSeIO39Y4rQwIQmWnufnfA493JBZTX
	 zlPA9o1npowgmDT4ofTDfNanp1GmlSPY6rs04iQG73slewasPI9Fi9GG702p3jQWkT
	 eV1Lz6Ga/JjYPIBEm4mrt+NrKRDXe8pPO86cLbt0DiM5bkoUzL1xWispgAa22XZ9yo
	 1/4LiwUtJYnUz1bk4VvhHwES5yts5cVpgJH0IJXlPg65TPP70uej5CwejhA+k5pObX
	 S5J0sX3Y1dZ6hFiVaXbKMTGI=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E336440E016C;
	Sat,  3 Feb 2024 10:19:32 +0000 (UTC)
Date: Sat, 3 Feb 2024 11:19:27 +0100
From: Borislav Petkov <bp@alien8.de>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Jacob Xu <jacobhxu@google.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [PATCH v3 0/2] x86: enforce and cleanup RIP-relative accesses in
 early boot code
Message-ID: <20240203101927.GEZb4TL2H3XTqCSo5d@fat_crate.local>
References: <20240121182040.GBZa1geI5NxWSslvt0@fat_crate.local>
 <20240130220845.1978329-1-kevinloughlin@google.com>
 <20240131140037.GDZbpShX2b0elXlqDA@fat_crate.local>
 <CAJ5mJ6j-Vw2P=QLK-J_J79S35UggvZPtm5sia74=enR1qq9X9A@mail.gmail.com>
 <20240131182944.GJZbqRmBN_KDgK_nmB@fat_crate.local>
 <CAGdbjmJgu4euOTEzns4-7pqUWo8n-gNJiAfARoZWxw8T252zJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGdbjmJgu4euOTEzns4-7pqUWo8n-gNJiAfARoZWxw8T252zJQ@mail.gmail.com>

On Fri, Feb 02, 2024 at 04:22:02PM -0800, Kevin Loughlin wrote:
> True. I just think it would be better to have an upstream fix for
> clang builds of SEV-SNP guests; I believe the first such SEV-SNP code
> was merged in 5.19 if I'm not mistaken.

SNP host support is not upstream yet. So we'd be supporting something
which is out-of-tree. Lemme see how ugly it'll get...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

