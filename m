Return-Path: <linux-kernel+bounces-56998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0C84D287
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C761C24E1A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9032126F03;
	Wed,  7 Feb 2024 20:02:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D48662E;
	Wed,  7 Feb 2024 20:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707336145; cv=none; b=aV/J4KGiVBgyExuzU9r/wV4CN/WGqQrQGCwqlj4gOfdEU5+4PH2gGZPHj9Z8aYUJLovz9MSAOAzxAxQfWDIC4spFhGDDXmLWly0eUicHHCEi8JvzPAYMkH6r2d4+exAk5jCm1Te99dDNH0CDtjtL71oJAZngjGPSz4TVssPCo7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707336145; c=relaxed/simple;
	bh=TrjEqjLvOxUxtg4GqmJF1cp5iazOi1slhQk9UHFTM38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QExhm6ULN4R5oU9NH/j0hAbyTSIgMm1PtWZgHoTpLqYYm54+a0m7r2RfLdL5OeMsiKtqlJoe4deo6yHNFnwc43hcKhNThH4gFD7UqcY6VdBQt0oO7qarhLpIReHtew7hTD14+LJqR7KXjlflzibSgNulGyQ4DL0EMz9N1+jOrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com; spf=pass smtp.mailfrom=intel.com; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=black.fi.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="982540"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="982540"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 12:02:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="933895627"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="933895627"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2024 12:02:19 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 74EB94C4; Wed,  7 Feb 2024 16:03:35 +0200 (EET)
Date: Wed, 7 Feb 2024 16:03:35 +0200
From: Andy Shevchenko <andy@black.fi.intel.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v2] x86/tdx: replace deprecated strncpy with strtomem_pad
Message-ID: <ZcONt_he_08batik@black.fi.intel.com>
References: <20231003-strncpy-arch-x86-coco-tdx-tdx-c-v2-1-0bd21174a217@google.com>
 <ZR0VJsgA6g0Wk4dq@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZR0VJsgA6g0Wk4dq@gmail.com>

On Wed, Oct 04, 2023 at 09:32:54AM +0200, Ingo Molnar wrote:

..

> > Note: Ingo Molnar has some concerns about the comment being out of sync
> > [1] but I believe the comment still has a place as we can still
> > theoretically copy 64 bytes into our destination buffer without a
> > NUL-byte. The extra information about the 65th byte being NUL may serve
> > helpful to future travelers of this code. What do we think? I can drop
> > the comment in a v3 if needed.
> 
> >  	/* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
> > -	strncpy(message.str, msg, 64);
> > +	strtomem_pad(message.str, msg, '\0');
> 
> My concern was that with the old code it was obvious that the size
> of message.str was 64 bytes - but I judged this based on the
> patch context alone, which seemingly lost context due to the change.
> 
> In reality it's easy to see it when reading the code, because the
> length definition is right before the code:
> 
>         union {
>                 /* Define register order according to the GHCI */
>                 struct { u64 r14, r15, rbx, rdi, rsi, r8, r9, rdx; };
> 
>                 char str[64];
>                 ^^^^^^^^^^^^^
>         } message;
> 
>         /* VMM assumes '\0' in byte 65, if the message took all 64 bytes */
>         strtomem_pad(message.str, msg, '\0');

This comment and size of union seems not in agreement.
How does the previous code work if message indeed takes 64 bytes?
By luck?

-- 
With Best Regards,
Andy Shevchenko



