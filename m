Return-Path: <linux-kernel+bounces-40584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405C283E2C9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 643321C22E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092BF225D0;
	Fri, 26 Jan 2024 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IgaEvEBX"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FAC224D1;
	Fri, 26 Jan 2024 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706298345; cv=none; b=KQndF3sK/6QMb7fqi5xSlQQx4weN7SzUWSHGrDl0H+4GoawRSWh05SI4Eu8w5yw4OsLt1jIZMZixRNJEFcADPdinlFnWIGT6bgeftoeyPekXvR/LUqICIzurZDJzjz1LQ+XT+BfIs9g48ipIYdqvRwH2oRFbwFFzA35rD9nGXsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706298345; c=relaxed/simple;
	bh=Ja5XSvXXB3bXyk3PQQIKZvOhuba76LOPTL58fZOQOys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOmuyX21GfdlhmjQnFdHoOEjSVZjY6yOeunfqvEJp2HE4EIaPnAN3eQaXhskY13pmc7x5pPPtKRpMRIaGIpQG0EWPyrzewsMD/6bT4Lx9hATv2D92cf1qBfgzn84K3e7pVOSGmV51UFAyylJcz0FeGZNpBUO9dygYhEY+/yPwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IgaEvEBX; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DEE9640E00C5;
	Fri, 26 Jan 2024 19:45:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 7kx3nQG4-2fs; Fri, 26 Jan 2024 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706298336; bh=WjM/lnqY25TseZDaAul9QfQaxjOIp7nZWMt6/hJNsoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IgaEvEBX4vdW9Ekmd/HPfVjxgsqXInQVoO+UAu7GLl75DFo0/qpdEmWfS7AC5gP7W
	 BIUxQ3KknP/xSGqWsk0ZygFwFHbn4dvJXBUheH4tcHKwF5Jgcc8p7/iRe8tNCM1Uo0
	 0R8JsdZAUSpHBDKS28l0zoZ8LQ4AR32gZMOXjvhgWm3x/o1NjwfpOu2XYuNR8Y0LUK
	 ZJkvjqdfZzZhINa4plzhNk9CQXxKCnGBT+9k+OL6JkjFCak/6SO6gLKHvGD+UrRa4M
	 1LBIPFBS5ID3tuWPXEBsB4jmULKYBUOwUH9Jj5QpEs/WAPkMYZioFIUGyXDbPZuThn
	 B+RRNkZbGGAVEpstg3qm6G2P+TPTSFQWeANoACMOmlkPRatT0GDfakur0h501924SO
	 HQfy8+OYb0GROMxnJ3AZ9HVFIdzHEatqNSwdEMj/wSl7EkGr34j8visQolShKoN9jT
	 p3sb3tB0rb7vitraBdkwXynN/YZmYN04IOLb+IscxcxWnbWU/ny7v6QDnxwgBSmNVs
	 oD/VcVwzImAxociW3mZnBlteJwLFpdOueeq1t0zyivxecjgNqeWgKGmupo6+8px7TY
	 zLRjhnbTG3QNzT9eOSdqP/DGcKQTBsbo356+lFc/q8ki+so2COsHpD/0psmn+V8ZMy
	 G6iJ4RncYadEX64dtSbkeh00=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 606AC40E0196;
	Fri, 26 Jan 2024 19:45:27 +0000 (UTC)
Date: Fri, 26 Jan 2024 20:45:22 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Avadhut Naik <avadhut.naik@amd.com>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
	"avadnaik@amd.com" <avadnaik@amd.com>
Subject: Re: [PATCH v2 0/2] Update mce_record tracepoint
Message-ID: <20240126194522.GGZbQL0gTwpniYGDHw@fat_crate.local>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
 <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126185649.GFZbQAccZphdW_0CkH@fat_crate.local>
 <SJ1PR11MB6083E6BF178B9D394BD58DDBFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083E6BF178B9D394BD58DDBFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Jan 26, 2024 at 07:15:50PM +0000, Luck, Tony wrote:
> If deployment of a microcode update across a fleet always went
> flawlessly, life would be simpler. But things can fail. And maybe the
> failure wasn't noticed. Perhaps a node was rebooting when the sysadmin
> pushed the update to the fleet and so missed the deployment. Perhaps
> one core was already acting weird and the microcode update didn't get
> applied to that core.

Yes, and you go collect data from that box. You will have to anyway to
figure out why the microcode didn't update.

> Swapping a hard drive, or hot plugging a NIC isn't very likely
> to correlate with an error reported by the CPU in machine
> check banks.

Ofc it is - coherent probe timeoutting due to problematic insertion
could be reported with a MCE, and so on and so on.

> Is it so very different to add this to a trace record so that rasdaemon
> can have feature parity with mcelog(8)?

I knew you were gonna say that. When someone decides that it is
a splendid idea to add more stuff to struct mce then said someone would
want it in the tracepoint too.

And then we're back to my original question: 

"And where does it end? Stick full dmesg in the tracepoint too?"

Where do you draw the line in the sand and say, no more, especially
static, fields bloating the trace record should be added and from then
on, you should go collect the info from that box. Something which you're
supposed to do anyway.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

