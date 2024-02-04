Return-Path: <linux-kernel+bounces-51603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A306848D24
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4178B219CA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7984322097;
	Sun,  4 Feb 2024 11:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RlgY14DT"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7264219EB;
	Sun,  4 Feb 2024 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707046017; cv=none; b=CG2RKwDbP6+TTNlavsiU0QxjkJBc4DV0emxcWjJC+agOWFck2PcFEy03K8hCq2rq1ZTqbwRQmDqk5AtOHkDdRfrGpKX0+lvfOyL7wX6hV5rRDC/BSGx8mL3yDsWEnWPhAZ4MLJijKzlH2RRCUabJhkF0d+wiSAhA4KI2Q5TV+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707046017; c=relaxed/simple;
	bh=AGiif2Xtf5Y9Uddc6aaMw+kq1ikhS4jFGlHsCtCYShU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+F++GzT79lN0IpNtJMp/2ZQAt69wTCh6JAlrkCuEc4zWbmHG6DL2kNku2WyBu0TwLCFftSX82g42AKmarJ2l3OTH03lOpaMcoJav8bZOZzKw4y6/UQmrKYIZGwzYGtplJ+u607wF1Y31OzoP7CpvY5G00erfM8awL227xSJHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RlgY14DT; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 068E640E0196;
	Sun,  4 Feb 2024 11:26:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TYR2N3tSIz_N; Sun,  4 Feb 2024 11:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707046008; bh=RfFrsqpQx96GuQZbFdGwWU2a+cMGMQVi1r+5tU7keZc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RlgY14DT7ko2GjFpMlO7h43uXl+NTmo8dOMN4am0SwPXgD7VJmBXpS7sc28ntTCXA
	 JAGRebVS6Eusygd9etwhyTM/3TQmmJsYGMxrI6m3Ralh+iZIknVhLAiCOAAMk8L5E4
	 ujZPVD5Q+zz6EQYQwcdbwf/OApTlkeB5f4t6WCIsu8tGARAcD//SfMkLcapU9jA2TL
	 Bv9LGEcmsag5zL1vKv8mN5zX+aelm5SYx/A6G0Jc+JYO7zZ6xoq2jQh+9MaW5QLRD1
	 wvv6ZWy/xYUuYZx9ljQs+p+02tfFA4oIYLk4/w9PJhOrpol6S8AtaOcM1Wpxb/3zq8
	 o22UWavl15mYSkrUjN02UEsK/L3yc5CUX3qIr30n/0/jr3NsrToVQ4E8Rx5uUZThd3
	 KQSbXRfOu2mk5FemlIQAky97+2X0mqt2Z2c3imrd2JvqIRdeGX4P7KeLACUUAFmnww
	 xuq8nH3j2iW0gdnLX4jrubZqdwax13fVCXO1G3Mpk2ofIqHqkWNJcaVn/PL95n44/5
	 uLZDYrbgPpt/BF3TySPKqUEoLcEcOSct51qrXR0LOzg9C5YGd53MRFiCd7la0Ixei2
	 8wBvjUv8asPAW4wEEFbnBjoE+W3ikA16dNIS8B9Ln2bdkRWRoub06wFqQrMNrI6quH
	 P3eVSnENTkjW+b6+xVYVOwyM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2C48840E01A9;
	Sun,  4 Feb 2024 11:26:32 +0000 (UTC)
Date: Sun, 4 Feb 2024 12:26:26 +0100
From: Borislav Petkov <bp@alien8.de>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Roth <michael.roth@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Peter Gonda <pgonda@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] crypto: ccp: Fix sev_issue_cmd code block
Message-ID: <20240204112626.GBZb90Yl5ps7awXOZT@fat_crate.local>
References: <20240204110604.192024-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204110604.192024-1-bagasdotme@gmail.com>

On Sun, Feb 04, 2024 at 06:06:04PM +0700, Bagas Sanjaya wrote:
> Stephen Rothwell reports htmldocs warnings when merging tip tree:
> 
> Documentation/virt/coco/sev-guest.rst:75: WARNING: Inline emphasis start-string without end-string.
> Documentation/virt/coco/sev-guest.rst:78: WARNING: Inline emphasis start-string without end-string.
> Documentation/virt/coco/sev-guest.rst:81: WARNING: Inline emphasis start-string without end-string.
> Documentation/virt/coco/sev-guest.rst:83: WARNING: Definition list ends without a blank line; unexpected unindent.
> 
> sev_issue_cmd struct code block has unindented block marker, hence above
> warnings. Fix the marker by appending it instead at the end of preceding
> paragraph to silence these warnings.
> 
> Fixes: f5db8841ebe59d ("crypto: ccp: Add the SNP_PLATFORM_STATUS command")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/linux-next/20240202145932.31c62fd6@canb.auug.org.au/
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/virt/coco/sev-guest.rst | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

https://git.kernel.org/tip/1bfca8d2800ab5ef0dfed335a2a29d1632c99411

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

