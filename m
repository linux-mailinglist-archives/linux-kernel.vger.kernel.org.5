Return-Path: <linux-kernel+bounces-53832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114EA84A712
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E32283635
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D7360DF8;
	Mon,  5 Feb 2024 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="DdgTTn8E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C92660DF2;
	Mon,  5 Feb 2024 19:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162096; cv=none; b=Oh7Gd9v9Jib3+tXFAW6QNLmHQ8miHX095HLtG9H0wUlfkhr6TNeBWxfLdVzr5TwsH8n9WVmUERvqanJ6jCY9JxsR+zwoEA6rAppt9s1SUbGhlscujkS0eXw/WSOLeKx1DomZOHEk6/kh5+y6QaZSTDIaGXGJUF5J8fyZxrdDssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162096; c=relaxed/simple;
	bh=gwNsUaGGaqv8vHcEre9Xj6V4R/eUrjnrSdACMEeFbI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj8IqB2ovcjrbk2DruwP14uNveA29qM2l2ZDLeHcWu0T0tv+84nOqXnnCncDC0VZ3BvyDQFiUVK38uGzrqnD8lQaQ8C954bZMOQMutsELTVamIldgdQ8S5YeyoMXpnRWsyV9zBqUS9oRX8ylLTcKFeCw+Z3TjC4ByLViS1QCFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=DdgTTn8E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 82A6540E00B2;
	Mon,  5 Feb 2024 19:41:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NP_oJnZ5KlIR; Mon,  5 Feb 2024 19:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707162086; bh=R7Pr/RRw/kKo0+V44VWePgEa5COJIWtlsvccbXKuuLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DdgTTn8EhXbDQwcy9aF5OiE0bR9RrAAhcvznERiA54w2FwnBS42Sa93mT/Dn//IWB
	 CppjyaDnWIk5UIOgrnMPNRnLBFMs+rlCTUPQ1UpZRLLbcUiPJY99tyJ/vcuDVLHQ8O
	 SNO1mo+4PnS30AMvNbyM6jgEdCUWz1CCCVDJyIu7tW72Ho6e2lN1umiNYruuJT96lo
	 Is6hTjfDm8GUFG0peMG259zIeRYjR6T3QwNE97tcvHqwXM8gCd9UzFv7aF4fLa3Fg1
	 vE6Cx2DengLdjS/0GBNupx8HhE+xvwnlmnx0W/OxReEqpN1aYlwah6mMsilk0tCl6H
	 oSHvFLy3qXGfGVyg7KNLwqvbdrND19JxT6XrYY6v226IGUf2gDd3qhDlgSI4GEgr1m
	 K7V3sjWmZnN4/eQnPTbfiW/2pDvOUMCz4TOhlzDyEAeXohaZXJa06ROPed4pgWyfcD
	 WbIPb2EbLEumkjlwHHlFTNPs3gXcozv0su9yGrwDYFKtPWiHeiXxdrk1w0ra+S5JBT
	 eKIh3WLzb2PxZ1fb2SpCwnUyxQHW0ftKS9kQeheHhZcDX0b3qMZi38V3IYuqgDyxD8
	 TdcaG8xntoVHxT9QoWCD/hxHRaQgXnkEmoqQhnCQXNlqHefoCqnrx5m6d7U9TdeHwO
	 ttkkKG0+BzKXQSbA6AWQ0V7k=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2CC9440E01A9;
	Mon,  5 Feb 2024 19:41:18 +0000 (UTC)
Date: Mon, 5 Feb 2024 20:41:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Tony Luck <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>,
	Muralidhara M K <muralimk@amd.com>, linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muralidhara M K <muralidhara.mk@amd.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: Begin a RAS section
Message-ID: <20240205194112.GGZcE52DXtK2lr0-14@fat_crate.local>
References: <20231102114225.2006878-1-muralimk@amd.com>
 <20231102114225.2006878-2-muralimk@amd.com>
 <20231128142049.GTZWX3QQTSaQk/+u53@fat_crate.local>
 <87a5pes8jy.fsf@meer.lwn.net>
 <20240109183646.GAZZ2SPiMZv83J3f0a@fat_crate.local>
 <87wmsiqok6.fsf@meer.lwn.net>
 <20240109200434.GBZZ2m0vWjm9v795YX@fat_crate.local>
 <20240124124030.GDZbEFPo4APcggdE33@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124124030.GDZbEFPo4APcggdE33@fat_crate.local>

On Wed, Jan 24, 2024 at 01:40:30PM +0100, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Wed, 24 Jan 2024 13:37:52 +0100
> Subject: [PATCH] Documentation: Move RAS section to admin-guide
> 
> This is where this stuff should be.
> 
> Requested-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>  Documentation/RAS/index.rst                        | 14 --------------
>  .../{ => admin-guide}/RAS/address-translation.rst  |  0
>  .../{ => admin-guide}/RAS/error-decoding.rst       |  0
>  Documentation/admin-guide/RAS/index.rst            |  7 +++++++
>  .../admin-guide/{ras.rst => RAS/main.rst}          | 10 +++++++---
>  Documentation/admin-guide/index.rst                |  2 +-
>  Documentation/index.rst                            |  1 -
>  7 files changed, 15 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/RAS/index.rst
>  rename Documentation/{ => admin-guide}/RAS/address-translation.rst (100%)
>  rename Documentation/{ => admin-guide}/RAS/error-decoding.rst (100%)
>  create mode 100644 Documentation/admin-guide/RAS/index.rst
>  rename Documentation/admin-guide/{ras.rst => RAS/main.rst} (99%)

Now queued.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

