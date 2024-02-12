Return-Path: <linux-kernel+bounces-62324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427BE851E89
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01AD2859C2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45048481B8;
	Mon, 12 Feb 2024 20:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SRYWcq5T"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D85347A53;
	Mon, 12 Feb 2024 20:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769135; cv=none; b=FohvSqZEW4iqFqQKMXxMVYsTnEGhEXfJLWcO+WKgqb4blKDrGamJ2gCTlwIBN5rIsxMLvMocolLJOdvo40aZyMPiy8Hk0wdYgJb1jq5TfbVXntCnV+jP7fsQbmITS5lVfXQIzaNr40fP5JcnuFVDhjO8hl3DJ18Lr11YYABPxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769135; c=relaxed/simple;
	bh=L9RdKNHvddbBhUkJpeTvs/p+xA7M2GWtgUvI0M6webs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6Tsgqlj4sKoCobxDz8cnT0GsXfQA+DfpFIiiTk8wdoJSgNFJbcAgA3cqw61ugD6n5JsEX9I8VkO24kV6FhOzFkwUTMHfGXWalCoLwE25Y9DidM8jUsXGjL/pphU2X06g1J2NXXK/J+lrOb29UVJEiEe4pjMuBBv6iiCYLgIU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SRYWcq5T; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6978740E01A9;
	Mon, 12 Feb 2024 20:18:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Oa2Lro1gWAqo; Mon, 12 Feb 2024 20:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707769129; bh=xJmBsDefsGJHIMQFhfxuzQrOvKpnLIUOpNNCFwnrT0c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SRYWcq5TwoykkOlPAC+7fVexxv56kvbhqMz8CmcHQNGIavRwwih3E0USQu+kCvVzM
	 VMudmxAPp0m4EmyHSAQz3CExLhNxfqO/+1uDo5CA68TR/+AXjAeYrb9jl3uJfgWVlR
	 zmSaBPe4/4h2xhBfFhXhS5Nv/GZwOOr3HjUgU+woZJBP0P4O6ZrLB98wY7cVkXlaAv
	 Dcmk88wPNfB0vAfPstWRwRBQJXxn+yNEK0TvCl8rZc9IYln94hUtuDDNk1GIDhaTPd
	 yGmdAYCfcyRnglXlSa9DevnH5s7+26MxycThdcECn4kW81R+KBouHRg2zXwUbu1Mhx
	 9DuF4sK5h2CFb6I3QiqvuGyfIQSjQ92BsC3ie5rs6Sweui9orKGarSEs1wBX/1nO5c
	 KLZ9Ml+zj7tQIB9vzSIv0X2VDF+JxHuFspoNa0nNkc/3RM+JIOubAtSTLCE9Wr1zH7
	 FLdII9bG4mBW90XmyOVgLAwR2PPOcdn07Nw8SFQ9Dc1NFfjrJ+E7MfXocVHziK4tro
	 yvAFotdFUCCqbWfg0pNm8HfoBY+DBeGKsIiIEJTf5lTOUItmUm0fM7KvAL4QrVpD84
	 3aYxP2W5HUvDwLGnkG+wOPQDUsiz1896z29Ojd55W+ffSyLC5ax1TgkSTyycjaE2zI
	 +obM4Da/uUBeh9YludNmZzpc=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDCFB40E0196;
	Mon, 12 Feb 2024 20:18:40 +0000 (UTC)
Date: Mon, 12 Feb 2024 21:18:40 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Naik, Avadhut" <avadnaik@amd.com>
Cc: "Luck, Tony" <tony.luck@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212201840.GOZcp9IFKkmsRT0Sj9@fat_crate.local>
References: <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <1cf19ecf-4785-48c9-91ef-4ca3c965f568@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1cf19ecf-4785-48c9-91ef-4ca3c965f568@amd.com>

On Mon, Feb 12, 2024 at 01:40:21PM -0600, Naik, Avadhut wrote:
> The spinlock is mostly held to prevent other primitives
> from modifying chunks within the genpool.
> 
> In #MC context however, we are not modifying the existing
> chunks, per se.

What if we decide to do

	mce[i]count++;

in #MC context?

That's modifying the existing chunks.

TBH, I'm not sure what that spinlock is for. See my reply to that same
subthread.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

