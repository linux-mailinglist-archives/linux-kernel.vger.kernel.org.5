Return-Path: <linux-kernel+bounces-40535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2E83E20B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5C681F22E2B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A5422313;
	Fri, 26 Jan 2024 18:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Gk6qPLPc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779681E51E;
	Fri, 26 Jan 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706295436; cv=none; b=UPeBlPPMgzrOqEVCoGqyrUmCLNVyRgbjYAkJIAxmriBF00hzgIq0k0ZnYCKmYov0lUEGc5ooeyI8hu1lfIAPVy3fLrxf3tFJsZmbXQSNWWY0M0gOz7fXk3uJvm5prl6bjPo9+P4TZNSKm7TsFH/2uvZT/JQCb7Rpjuu49DjtvEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706295436; c=relaxed/simple;
	bh=QJe1FJ1iBaalO5uoFk0dCsivP88lPhMfWnHVPQV7TEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6KKfJzSR3aD5UmZRmz5Ur+FOiAxAk0SJ7NB33z8vCwgc++05ou+BK4W9nzpws7WTGPJ5k9DQm9XJUwAOMTP1bkUdIrqtOXFOrQd66nYZ7Tt1pvPqwue57VtbmSZ/lSzvPburKAubyfD4k86CCV0NJ2Lpn+fGomTlRMupFStnkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Gk6qPLPc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 79D1240E016C;
	Fri, 26 Jan 2024 18:57:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5WLNMonkyGe7; Fri, 26 Jan 2024 18:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706295423; bh=xhhU0pI4cvWOVs/8fChYblqpo/BatkU5qzvZCo8PM24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gk6qPLPcz3QyHGb+YZrdeyar1yu/82X4/OlpJjJe/3pC3U1xpXztdO1fqU3mosVLv
	 UlsfzXIVa55o6ZrUHl5/auceFNgMAzyq7VJiNGjV7opMRfbyum2pVY7dGgHDZjxZbr
	 dYJq7D+T2rgLX6KsRaYGsDn23zcIXobLBMTQWhQXlMkJ1r+D6zZ7bRMEgu+tCyDjx0
	 XUYp/QMRJ/2x29ucUkKlG5uVKjCyBow1ySc6rHRNfGWE7/qXB2A8vA4a9wbkDgs5kK
	 7qHrYLRdyf/vF8e55qq27+E4zJzFin7H2ZCqCVL+f8Ht/xx1VJCrDaWKvBaA/c/Eku
	 J7izqRGN2k8vZ36o4hGuubBn4h04D4h68ZHx4wSc1A+5ODc0YSPjL+11qXVUK0i/Ie
	 NshSqXqMHaOSAUWnETUBy+dvVeatGrvtlsOmLdXfcLFIFn+psEC2LzzIDEeGano4gD
	 qTUjJi0C+3YBjLqqDwRnAqUxGhkYys5dO4hm42c2dxIUjFhClEp3bCMhAor5nv7hy5
	 S8rXEnukgKW6CmkvaoLDq6YvPpPwsK/r+vdpnt76JfrGjqXlNebks1B3wzs0t3GUYi
	 69hulmUU0AXfVHHBlckzj+BBhEXYwVTVQYSlEDkjI8O9oeeFOFv9E0gHnGJ7TM7W3h
	 /byjo3FsQMKAO3RyWAMVTD/8=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3E04340E0196;
	Fri, 26 Jan 2024 18:56:54 +0000 (UTC)
Date: Fri, 26 Jan 2024 19:56:49 +0100
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
Message-ID: <20240126185649.GFZbQAccZphdW_0CkH@fat_crate.local>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
 <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Jan 26, 2024 at 05:10:20PM +0000, Luck, Tony wrote:
> 12 extra bytes divided by (say) 64GB (a very small server these days, may laptop has that much)
>    = 0.00000001746%
> 
> We will need 57000 changes like this one before we get to 0.001% :-)

You're forgetting that those 12 bytes repeat per MCE tracepoint logged.
And there's other code which adds more 0.01% here and there, well,
because we can.

> But the key there is keeping the details of the source machine attached to
> the error record. My first contact with machine check debugging is always
> just the raw error record (from mcelog, rasdaemon, or console log).

Yes, that is somewhat sensible reason to have the PPIN together with the
MCE record.

> Knowing which microcode version was loaded on a core *at the time of
> the error* is critical. 

So is the rest of the debug info you're going to need from that machine.
And yet we're not adding that to the tracepoint.

> You've spent enough time with Ashok and Thomas tweaking the Linux
> microcode driver to know that going back to the machine the next day
> to ask about microcode version has a bunch of ways to get a wrong
> answer.

Huh, what does that have to do with this?

IIUC, if someone changes something on the system, whether that is
updating microcode or swapping a harddrive or swapping memory or
whatever, that invalidates the errors reported, pretty much.

You can't put it all in the trace record, you just can't. 

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

