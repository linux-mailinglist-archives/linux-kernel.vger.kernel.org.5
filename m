Return-Path: <linux-kernel+bounces-39155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D07D83CBA1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5221FB23B32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD61339B5;
	Thu, 25 Jan 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="eTg4QeI5"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC276341A;
	Thu, 25 Jan 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208894; cv=none; b=PN7LDyNalhUOcebSNmqhYAdHS9L+psnT3gwxv2LAXGbfqFni/PtawbAa/C6IGXi56Le/jsp9zQSjUEqW9tooEdOJmBo1RPoNE7Bd8OEMiAgnRtndcEF6Jv2SBtBMdvLdDEdifrX+Zg/3nA0agfxMTDnh2Dyg7dYapB2LJDOKKlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208894; c=relaxed/simple;
	bh=uUhFUZXQ4vRb3CNL/o+LkzhDQHu7ajYW4NMDA3n5IN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u9fbeU2cK71KFeuiAYPajSCeN7q8nedBH6dXIcfGEix5PSn2hLoK6tyg+WVrLZvhmZ+Gsp19n6/epj0DmatVMrhX34veWTnrcTA2f4V5TeFqOIv2XTrUeDW4xo6Ur6ikJxGLyuOw61jI3Jpgh5KEz980hI3/p5x0p7ufmB9qHU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=eTg4QeI5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4B54D40E00C5;
	Thu, 25 Jan 2024 18:54:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 1B73w0UfRrJD; Thu, 25 Jan 2024 18:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706208880; bh=nPXhbPzMU7Z8LSGsHzQlCMKYBA7gkUxN+sOfblh11lE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eTg4QeI5+iJej5EIxhAHAXLWalh3Lw8ot9yp0ezjBd5+8SGkK2FXE6yw0F9FTvULV
	 ylpBmjtWNZy9t3rlF6HIg8WUN6rcYn82GYTAVEWE/VmI9v25e6Ke2Wu3IfiBP6OkNF
	 opPPEejlncO6EN4L409GY6D4yPgvUFNDYPQY3nqHYJjYd/bwWV8HUYo22x56+AAQmr
	 6Gk+ue+b21SWxCBnXcGMxtifAj1/oDBm6fw3+hYpKkuBIxuz1VoVo4v3TbZliuvT2b
	 6u5wfL7Fi6N8CbRQlriNA9+Xn6P0L3/A9aw+BCWq0q52ddlfUquxRuyqfjxW3yBou4
	 djMOwGoI0w3BO9jw3EWAaPMYQzY5LYrDbF8nadJ7537v+p0BOHHwgomfCkcJBA0WP2
	 5jqikpByplVmiiMdftS1rtfbBW4F6D+aXsbLrcaAq0KZiO2wa1zBrjbgxz1URLJ0nQ
	 +iym9dNrL8tYddP4b9ApxSycm1IAE08O0hSpROXwXoO42cC3qXag40KX79M6Q3vzyE
	 I+nfw9u9b6MQgPVDXLdh+bzVCPiiTZHa9U0V44Pog2UfZjeK77eRt8KPOhzc10pJ1+
	 QyBG6q0OE+oyEu05SBD5wMZqTt/OtPzbXBvt3JffDWfsVmZhNQW3Dd0a54SExufodV
	 od/mNGlabxq3MyyzAlTnYGvs=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CF2B040E016C;
	Thu, 25 Jan 2024 18:54:30 +0000 (UTC)
Date: Thu, 25 Jan 2024 19:54:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Naik, Avadhut" <avadnaik@amd.com>, Tony Luck <tony.luck@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	linux-trace-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org, yazen.ghannam@amd.com
Subject: Re: [PATCH] tracing: Include PPIN in mce_record tracepoint
Message-ID: <20240125185422.GCZbKuXpLUaOzV8IlO@fat_crate.local>
References: <20240123235150.3744089-1-avadhut.naik@amd.com>
 <ZbBV4EGrZw6hJ5IE@agluck-desk3>
 <be870e14-eeb9-4dcf-ba43-a72ef66a3d87@amd.com>
 <20240123203853.66655e95@rorschach.local.home>
 <20240124095708.GAZbDe9Hks0tL2Aj94@fat_crate.local>
 <20240124090908.1c4daea8@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124090908.1c4daea8@rorschach.local.home>

On Wed, Jan 24, 2024 at 09:09:08AM -0500, Steven Rostedt wrote:
> I don't think that's a worry anymore. The offsets can change based on
> kernel config. PowerTop needed to have the library ported to it because
> it use to hardcode the offsets but then it broke when running the 32bit
> version on a 64bit kernel.
> 
> > 
> > I guess no until we break some use case and then we will have to revert.
> > At least this is what we've done in the past...
> > 
> 
> But that revert was reverted when we converted PowerTop to use libtraceevent.

Ok, sounds like a good plan.

/me makes a mental note for the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

