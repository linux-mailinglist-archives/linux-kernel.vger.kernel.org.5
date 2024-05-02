Return-Path: <linux-kernel+bounces-166503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2297A8B9B89
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE921F22581
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3184A54;
	Thu,  2 May 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EZbK894e"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB757301
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 13:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714656183; cv=none; b=huKNTKmvy1MCHjQsYx0FeKtnQ0MZcZgZbu8buM+I33AY5x5zCE+0WZA0F/AfefYmsIC5hArbmDyOYyR5gefgXgoDspSoEpmtlFyAB3vq5B6+MJp704HOARokB0qJtWlMSeK47wNng90i8zmaUkoKhEzqfwHmJUKY0tSwbX0wys4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714656183; c=relaxed/simple;
	bh=zZ2GxtKL1g/Q9ETg/d4FkMA8j6lNJx0Y+6vNByPBlsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6Y+ZWBvN/GIlXY6QbwENpVYDGrWBSaAeBPN9QwcVlepV30fozP6AbBP0BXTJFZaqkUs23u16rAG7OvKf0pPtsNb/vidzIgmDdM44REH7ilW8I9Z9bqyMckdBCQ/6QDD1kRXOGY1cJMSto2jX7p5DqWLtotU9o2OksiO8vDg8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EZbK894e; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AF3E240E0192;
	Thu,  2 May 2024 13:22:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6xQRXxDKMM7M; Thu,  2 May 2024 13:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714656175; bh=KpaMMMmxEshpLndJz6FzKD16Wt8ZjX0UI6aaHqp2B5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EZbK894erBEkJD8ZKxEIlsqHFH9FFvtGZRcWE19a7cEruu0X9261Drw6In+XJsarE
	 A3SzXTVOCB6QzhFWkVe6kzeHq96bBkdsamzjbVFgJ29hgdcV4G3++w6Qxk7z+D+0ij
	 TXbNpb4C1dL8MRpFNplXKbx57oFu5KooO/U9g4HpBexPKiMXjQP/JujGnKsaYhuj9U
	 MUJ+wVZEcP8l8PgChCLmYEgaMtT2tF9sDJhMtr8B+yEEtLzvb8B6fLAPPN1+h3SeTR
	 BaB6bhc6i3LUN07MZzMKpC6+yyC6+j8gdi5TD6o1l1KxYvG8IElEWZlHctUtESxylL
	 J23wSr0NgVGzFeRuP95bHiogRwtdnq0X7BTqzmSSXHndQU/cO14I2AzpFpkY9v9Ucr
	 KS2kGNcXh0Dyff+q+E2NIh2bLpSl0PjHH5UXJ+uMPpgu/McOzPfz626462iApzwywv
	 9ARS2wzI5p34+Hg9cSm0ISw86hsUqWEdTM4W+aD0INECKBcx958SPFME0WotOn0iNd
	 ZM2VWB84VY/T+qP7ZIPY3WGAf9KMlWl/aEEXVgLI4TTKsOIgaD0SbOT7k3310BfP/f
	 OQKJiz1wL03vT9Vf9AxUIJrjlfmr5K88iHuZB3kcyn6bx2vRF9CASEb5PfdMF3SgYV
	 k3aRslk87b2AWgdKlBJl25Qk=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1346740E01A3;
	Thu,  2 May 2024 13:22:35 +0000 (UTC)
Date: Thu, 2 May 2024 15:22:29 +0200
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
	kexec@lists.infradead.org, linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHv10 05/18] x86/kexec: Keep CR4.MCE set during kexec for
 TDX guest
Message-ID: <20240502132229.GBZjOTlWg-CzSkrKA0@fat_crate.local>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <20240409113010.465412-6-kirill.shutemov@linux.intel.com>
 <20240430130323.GAZjDsG00Xdhv5mv8W@fat_crate.local>
 <rneuozes2fafzowtyftfhsqznapdr4tlfwpd5bbuw5ssvflaxo@fq3ufljshsid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <rneuozes2fafzowtyftfhsqznapdr4tlfwpd5bbuw5ssvflaxo@fq3ufljshsid>

On Tue, Apr 30, 2024 at 05:49:08PM +0300, Kirill A. Shutemov wrote:
> I assume all of these new labels have to be prefixed with ".L", right?

Oh yes, please.

Thx!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

