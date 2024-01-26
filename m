Return-Path: <linux-kernel+bounces-40655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2083E3B6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F70F281576
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A02E4249EC;
	Fri, 26 Jan 2024 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="je6n8BpD"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637E6249E4;
	Fri, 26 Jan 2024 21:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706303515; cv=none; b=ZyNElmQC1giHGBIllelnZQU5XORjsLwCyU6M4ekrN1HB2/WyoHb/UoYToC+brJcu1HP6SLlaVy36TSY428j2ZApkveLAOM4nQTJvHNTQQsM/XjHJOor/Yu6LaLK6UWBBoAde65r3yuTppsDxHa+vdF1pumHI0IQ4p0SaGQG+ogs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706303515; c=relaxed/simple;
	bh=/r2Rij94/j4jISWkYEotH6eOuOW5IZKkrIcWB7ZQOcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exSXImkR0GQxwgXFi9hsCYQFnay7l2vyFUuEFDzsomztmfO6hK5/Oj78XAenlay+oVRStYHu5jg9mmrNf6D8dUZvq61+wRog3T83EU/dbY+VYpvlLBZEk6hy8oY35ZfxmWshB6g15VkWSvjpHzZuICCcbDRbNUv+HSBdnvZnhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=je6n8BpD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 9B8C540E0196;
	Fri, 26 Jan 2024 21:11:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id I1xJBykZ4bcf; Fri, 26 Jan 2024 21:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706303507; bh=V5F7Y+vNA0nhBBTS1anKbuX0bJPun4q/tCXrSChYffk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=je6n8BpDZHwh4OjBwAU2NOM+YCYPsEV2yc44p1qV2ULMxNtwqqAPGTozt10pnZo74
	 qUap0fFAw5tv86ePyQfF763Yd0EeSVxKAOK/kbO8gK5LlVuSzd10oSaiJwf8zcahG+
	 BN52arQ9mJk2nNnWdXVyHn+dSPtcOgiY2R5Eo649SMJG/T8dETt51lkk8HMBBBZWlA
	 KHU7qS/BX83NYD/DOTbKcMZa8Yi1zs5HvrVPlqddYiPJIa6oCNJ2fOnrJxMMw7OXoy
	 WL7+xUbGpRxJPwZeam5oWJbFpF51mQzscMFvA28iXB/gBICXTKyaOQQOKDlP60bSkc
	 /cfVdg1lasVb5uSPhQyiwM+czw8Aws4PRBh7f//T0f5/0FARwP4GXZgKi30L7UmLDu
	 Fu+4nZsKgDDx3em/VdwNEVvtZvMg27h8SayJrdEJ8w+TW+SldpPVL0hUwzsb3LC7ao
	 XDObF9tW8XsfXsaWXeAGOus9DE0dmmwieJQerIaQ5PLyz0YRXBmJZZf5wDof+62aek
	 xthizd/uuh/x3tc9jMhfBpLWLi4rdNb9Cv6GIplsBP/jlp+YgPXP5U0DUgeIKevT6l
	 MZPrBzggYdj6JE7OmI5FPZaXufYPXEGH85I1OCTp+VEUdbp8jYih/0zg4J4n6imzFt
	 qz/fDijnQ+Dybs6Si7gt//70=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1D70C40E00C5;
	Fri, 26 Jan 2024 21:11:38 +0000 (UTC)
Date: Fri, 26 Jan 2024 22:11:33 +0100
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
Message-ID: <20240126211133.GHZbQgBfqX4Qkdbmu_@fat_crate.local>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
 <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126185649.GFZbQAccZphdW_0CkH@fat_crate.local>
 <SJ1PR11MB6083E6BF178B9D394BD58DDBFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126194522.GGZbQL0gTwpniYGDHw@fat_crate.local>
 <SJ1PR11MB6083E1000D4B267CF4271135FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083E1000D4B267CF4271135FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Jan 26, 2024 at 08:49:03PM +0000, Luck, Tony wrote:
> Every patch that adds new code or data structures adds to the kernel
> memory footprint. Each should be considered on its merits. The basic
> question being:
> 
>    "Is the new functionality worth the cost?"
> 
> Where does it end? It would end if Linus declared:
> 
>   "Linux is now complete. Stop sending patches".
> 
> I.e. it is never going to end.

No, it's not that - it is the merit thing which determines.

> 1) PPIN
> Cost = 8 bytes.
> Benefit: Emdeds a system identifier into the trace record so there
> can be no ambiguity about which machine generated this error.
> Also definitively indicates which socket on a multi-socket system.
> 
> 2) MICROCODE
> Cost = 4 bytes
> Benefit: Certainty about the microcode version active on the core
> at the time the error was detected.
> 
> RAS = Reliability, Availability, Serviceability
> 
> These changes fall into the serviceability bucket. They make it
> easier to diagnose what went wrong.

So does dmesg. Let's add it to the tracepoint...

But no, that's not the right question to ask.

It is rather: which bits of information are very relevant to an error
record and which are transient enough so that they cannot be gathered
from a system by other means or only gathered in a difficult way, and
should be part of that record.

The PPIN is not transient but you have to go map ->extcpu to the PPIN so
adding it to the tracepoint is purely a convenience thing. More or less.

The microcode revision thing I still don't buy but it is already there
so whateva...

So we'd need a rule hammered out and put there in a prominent place so
that it is clear what goes into struct mce and what not.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

