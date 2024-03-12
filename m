Return-Path: <linux-kernel+bounces-100502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC828798B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2571C217A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76857EF0A;
	Tue, 12 Mar 2024 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HCP1iYsb"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D48E7D3F8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260048; cv=none; b=QxZGLSpjZinTdA2ioTcKuz2+aIyGfIHMkvmFSfkvdfMooxMIoO/9SmTwJ4ioKkfXSCL+o+HmFuqy8HA+dw6HKEaYSHEmjOy3DK82MC2s82XY1P7T55nvWoUPLaXSUPatVMVrGAbBNbu5OWkwD7pScb6NqDbEUqFOk8k1G08rAG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260048; c=relaxed/simple;
	bh=VqIofrJMW35b6TtvRns3ZAPwCJuIsYdZh5yQM9GrNCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFNAKmPyn6o00mzPBa3I8TyMxSA0jPJGwiOq5/RJIdds7oqSxqXiyYn2D2Ud2fqSx9PNAC16vAdmO+7zpiA3rNv9TFE5EX5HjZRCKuKmdAhWGqev3IYaP5Qzb9bX0cxM4bJfQrfXXCvxW0HBSNmdmbptE4gZftKqZaSRRbu3SPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HCP1iYsb; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 33D6F40E0174;
	Tue, 12 Mar 2024 16:14:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id brRHIjIQ3eD6; Tue, 12 Mar 2024 16:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710260040; bh=rp3UW8kgV0OpqW18xyh0tjUL+7P3rgOm1smIGfUXoH4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HCP1iYsbvT4EHsMVxG2ozNaj1IsGxM5xiGcPn3S79LV/vNMvpdcHzaEThEiXZ6flk
	 mnRRTD7m2xXL6fgbHk2HKYrAQPKtU6BjoQ8E5Ob7P2zEa74PXsWmca94fOeXJGlvcQ
	 zE6WtK4urv73nQ0x/a99cGSHDQO83PyccHASriBzN4EykPqjrCHietAGNOTuyHlybt
	 rn2PjO+HF+cdPMW8mygriQvmBpAX3GozpVShafD/Dyjfw+lJHR8tPZg9kRhghaZsyg
	 7k2SKgrV27N7YKzNjZ0d5BUM1TwU2/mvGaYrnZdRjbGn3MxTYgUf5fmzc3P8OdNWUS
	 +S0fPev4wr7HsbxEJWnkR3/kb6W6WLAfbGJP8Ch5MfbUdxXzmpErLutMJbSMv21JXM
	 l1S+ycqI1kcUgiDD1ZrLp8MoAGkB0cmk14ri2VBreWpHG1ihD7mum+OlEOHWpvNI4M
	 AmtL3VphgwB/7a2u51WniLc0C3d4tghRG06xtegWfu11vuCePxbk2ZzIcMvcQJKy9X
	 iwHU0p5oQjpIMAxYl6P3fBkQUidOdXvZLx6bZ4Xb5sZtVsZBCFJut3y108fglhRcOY
	 FNUDkHUCfpfHNwFzbmCvgfN6W8r6pocC1IFCxdJzo486hPaQA7jv3V5MMORcDZap3I
	 o67OiO35xR8kRvL98mx4ZeZo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C590F40E0028;
	Tue, 12 Mar 2024 16:13:44 +0000 (UTC)
Date: Tue, 12 Mar 2024 17:13:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Dave Hansen <dave.hansen@intel.com>, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@google.com>
Subject: Re: [PATCH v2 1/3] x86/mm: Use IPIs to synchronize LAM enablement
Message-ID: <20240312161337.GFZfB_MdSFtAUXjeLU@fat_crate.local>
References: <20240312155641.4003683-1-yosryahmed@google.com>
 <d24c8736-d963-4aa5-a3cb-5cc1110e3ca8@intel.com>
 <CAJD7tkYXfFiOQMpM+GkR7a=aUxFM-smDc-ZFTTtFu2Kbd2KoPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJD7tkYXfFiOQMpM+GkR7a=aUxFM-smDc-ZFTTtFu2Kbd2KoPQ@mail.gmail.com>

On Tue, Mar 12, 2024 at 09:09:30AM -0700, Yosry Ahmed wrote:
> My bad, I lost track of when I sent v1 and saw Kirill's comment when I
> woke up so I addressed that. FWIW, v1 and v2 are almost identical
> except for a small change in patch 2 to address Kirill's comment. I
> will hold off on sending anything else this week.

and while you do, you can have a look at

https://kernel.org/doc/html/latest/process/development-process.html

And we're in a merge window now so no queueing of new patches for
2 weeks unless they're regressions.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

