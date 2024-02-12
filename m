Return-Path: <linux-kernel+bounces-62265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5AE851DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845D11F218CA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2472146448;
	Mon, 12 Feb 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Na5cIFTp"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8891E45C12;
	Mon, 12 Feb 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707765266; cv=none; b=QXu0PdwHUX9Jq3IhJxdG/ETshVPqGf1jz1hJdmyCknw1aNlokBCPNI4DBV4/6MFs1Oyv2B0lXhwOsAtrwdAD0p7+L+p5BBnlWTXRrhZLgoCBUYC/nWoA8VBYsCjqNgEgxgR+6gPO18WSSNAOmYGcydgB5JlwZ5GB3MyQQ5dXiNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707765266; c=relaxed/simple;
	bh=wk4IdpB+jmxZs3ctjwHg8x2TnIHTBOV5b+cPXBULd28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KqrhLP/BjDXr7SflyPlWp3Qoh2NwIqZ9tTUGYKfWrjyuhmnRfCLzrCHq1RmbgVnyZQbt+xWkL4JA9AxKdmB9+GW757a1jjmWm0Yn89KhKPQCO3Poaj1LZGSdzWPY/GJXAqYDegxTwzoAnkpgjmUG513yEu9gPHd+NmKzFN/PAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Na5cIFTp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3DBE140E01A9;
	Mon, 12 Feb 2024 19:14:20 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BVXoUC6KDzMB; Mon, 12 Feb 2024 19:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707765257; bh=C5wEpCM0L2FZSRTo/20pndRjhx4iPSK/Cw1XrpMyaoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Na5cIFTpl514oNlTpw0KdaDEwKc826n/EbZ6nue8mfsMCRolpONHuU6WJnPdRhm2H
	 s9wjWsZL1QgGvVgBjP1Uvg5OPzj71TyQTCyrNoiSl3DPTGTLnfi9QidMPMeG4yVVkq
	 rpL8PyGH+HjZx5IINDoDqUNgtIITXbdWlHjmssTG47av7EN++OmqV2vHcsKouWNnJa
	 o1tSW9xokADow36zadnrX9zA6F4UYzt+0IN38Wa5RWIQQhsrUqBMvObbaPukOcEUZq
	 UY8eDkwLcTX5FX5DsosQlvQvw8ZSlqqiaAkLX/oOEF1hqM3RGtCHxrj8tTe9RAQa9g
	 I10eeDdeTRO/az8tde8j26mD75gepjXqDke1uaMlR96/lLbf4+CBHM7sSI7jU9/S4r
	 EaoMBz6BIVQ0GCGZsmQYc7ph4r0lqycGBLMZxDWwoFZiEKTLW4egyfv3caX4omkXDN
	 DuF+1DNRrliiYuWs8ZEpu7iT3ScCVlrX7hdNvUykJn2KDa+9JJWUS9S462cbu8ncrk
	 tu+ZbbFlF7W+oDxcbCkaolwvFg62BmD4wM9msmtaYpe+Iw3lsI1WXBHtafd3ohxnFF
	 bQwf176pWCdAcL4VqGVF0ILTGYipdgPMOZpiZwhk0GkTurx00qu8wbcApX8x1D3dfg
	 W/PwjjsO+aHvEnr1jLD/6Gws=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 968F740E01F7;
	Mon, 12 Feb 2024 19:14:09 +0000 (UTC)
Date: Mon, 12 Feb 2024 20:14:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Message-ID: <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
References: <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
 <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
 <20240212085801.GAZcndma4UTPtKm33e@fat_crate.local>
 <20240212093246.GBZcnlvkPKDC8C7rv5@fat_crate.local>
 <SJ1PR11MB6083B3511D18787BE823AB2CFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212175408.GIZcpbQHVjEtwRKLS-@fat_crate.local>
 <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Mon, Feb 12, 2024 at 06:45:34PM +0000, Luck, Tony wrote:
> So it is currently true that number of CPUs has been computed at this point.

It needs a proper explanation why that's ok rather than an empirical
test only.

> I use "git send-email" to send out patches, and usually "b4" to get them
> to my desktop. I do have "mutt" on there, but IT have made it complex
> for me to use it to simply read & reply.

IT departments all around the world make sure of that. :)

> It requires separate mutt config files to fetch mail and a different
> config to send mail because of the firewall rules on the lab where my
> desktop lives.

Yeah, that's why I'm working with !company mail account. For my own
sanity.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

