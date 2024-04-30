Return-Path: <linux-kernel+bounces-164569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE948B7F79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DD4281011
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637F1836EC;
	Tue, 30 Apr 2024 18:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="F9+CoEGz"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91197181B9D;
	Tue, 30 Apr 2024 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500416; cv=none; b=NMsNxuklyZjXK6TEu+I7Deer4df7XPFT124d05IFZJzQ3ypWRokkbw7itDkN8xp3YOgTggDefj2k2NZ25ohTxUWkgYkr7NYVSjiZ1tJC0Jtoz72JpK2JXVLNiKtr01ZSan+kwCrTZ72Y/UaN4p6KtIJVs9WPlkpzlc/AYMOG42c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500416; c=relaxed/simple;
	bh=0qsg5fAauxbEqdIcYQLN/yej9YBMwtvKQ9nkrp+Br4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lo9G3Fmzs2Q9MH82oojDwLPGbUJKZaAjzGj0FrTtC2o07/RXRFelGCLrSnzdm8YnlBZwN+JM931cEQsTc/TPYtVa+1UCQYve6lQemiBw7MoX07SG41PUPVY4AyukrF3HVG5XPJT/Y3t3HouL9g9yU7ctIkXXwJLXx34kDIyoZXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=F9+CoEGz; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A5F6D40E01F6;
	Tue, 30 Apr 2024 18:06:52 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vbcD7_edTS81; Tue, 30 Apr 2024 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714500409; bh=Y7s8TMJ8qHLzbZ6gWl7cQnaOJBDIe4Dw83e3EgHGNuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F9+CoEGzJ/y/ehxDH3klsh9Gsv8WNJPvz9wXGF0+toT5WaIsTGcmbMtyWkNc/8/sq
	 kRC93KCG1bKC3Bt72C28yAC+tbLXIe1cfG4NPt5elguqRn+MQs5pCfhp5bpAmY//97
	 5Qo3/nkSXyMLmt4f16aQqGTPnrJHqNpkH7XojNGQFhhdKEqxrOXPsfV8vjTMoRSY6m
	 jUb1Fa9BL9DvZ9Ql/UxaanqV1P9H3dtBdF9nAN2YIgoi9lA7H5woKt6XmEU7OLlRPv
	 18HwqQxZWPMf36yQLVk3QnEoAun3gJigVimPcSEd7SiwLgzL17QwI579/S2mffJSjn
	 T5iXPxSya5K3jIpJQowpMWUc4pfMygkGuNC4e3xrJETdvp76LBjr8GpyQg/R2X7Ysk
	 9J5qLr62N0Ci1RSA+yfhXb6V7BP1lJu7qB1YQHAAUHY/zzqriMdsaaZ1qTqJvWYdTZ
	 x0vQ9WrjA12F5Wss86aA+YfFN8mCNx4rAB8TROpxPHfsfQxasAJNOHdLjMNoV4+pMr
	 nNSxp1O4M40iUJ1oQIpx/X5siDyPKsVPjDooRgk/zTkLEH0oCThk8n8MTSJoQhxaKj
	 0Uob7rHZySNCYmUz8VQvjwUVMncOXP2a50fad4zaUZBmFM5FrSIB74vgVC2wnMES00
	 9nBDL1hoVW8sumhZfUUZ98EY=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 51D3940E0187;
	Tue, 30 Apr 2024 18:06:41 +0000 (UTC)
Date: Tue, 30 Apr 2024 20:06:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: Robert Richter <rrichter@amd.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	tony.luck@intel.com, x86@kernel.org, Avadhut.Naik@amd.com,
	John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
Message-ID: <20240430180635.GDZjEzK8H3xQ_uEGYn@fat_crate.local>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
 <Zi_oPUzvCDhRVSk4@rric.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zi_oPUzvCDhRVSk4@rric.localdomain>

On Mon, Apr 29, 2024 at 08:34:37PM +0200, Robert Richter wrote:
> After looking a while into it I think the issue was the following:
> 
> IBS offset was not enabled by firmware, but MCE already was (due to
> earlier setup). And mce was (maybe) not on all cpus and only one cpu
> per socket enabled. The IBS vector should be enabled on all cpus. Now
> firmware allocated offset 1 for mce (instead of offset 0 as for
> k8). This caused the hardcoded value (offset 1 for IBS) to be already
> taken. Also, hardcoded values couldn't be used at all as this would
> have not been worked on k8 (for mce). Another issue was to find the
> next free offset as you couldn't examine just the current cpu. So even
> if the offset on the current was available, another cpu might have
> that offset already in use. Yet another problem was that programmed
> offsets for mce and ibs overlapped each other and the kernel had to
> reassign them (the ibs offset).
> 
> I hope a remember correctly here with all details.

I think you're remembering it correct because after I read this, a very
very old and dormant brain cell did light up in my head and said, oh
yeah, that definitely rings a bell!

:-P

Yazen, this is the type of mess I was talking about.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

