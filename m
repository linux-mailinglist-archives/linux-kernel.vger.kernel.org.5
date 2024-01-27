Return-Path: <linux-kernel+bounces-41184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 344E783ED0B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 13:19:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DECFA2850A3
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 12:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F39208D1;
	Sat, 27 Jan 2024 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="afLj884O"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E721E493;
	Sat, 27 Jan 2024 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706357982; cv=none; b=s33WdXzzAQdalmvLKbLJYhSIza5jlxQ0UsZymPy331/SznruGMFrj3jmm3fcnFfiUF78ounrVzD2w4OFIp6SqUp/1+HYVFyGAi5HQeGfah2bRy+1K+04gquLa2Xnp6OOnpx/K21St5W1C7qy/IF+yuOx7cBlWaG1iwyZg0mRHVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706357982; c=relaxed/simple;
	bh=QxnHtD5P3AwtVXPxKcw+KIPISw6GhG7GubZ3UIXvWkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCbOsc1yR1+h57PcbMnWOWewK4ePeOTcIp4zaVF9qppo82mhsdwIp5BScyyy/qSiTCXmlKEDcFOBpIDqrg43c/deEwPPUAHU95Hvu8rSizIyiXfv88wcw4XGkQkN9jV2gQn/FW7hH9ZReb6YL/GDSfMlj/Bue8UH8GfRRuLt/Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=afLj884O; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BB42B40E01A9;
	Sat, 27 Jan 2024 12:19:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bVxSQzP6HkWQ; Sat, 27 Jan 2024 12:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706357975; bh=5nyRNUaZUTU6WCk60U74aF9FI/0suhGdH8eOJI11zVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=afLj884OcK8C4cHqVjUxxCJX9IzRyS8T72b/KLDsxEVTMfe+JilhHsFbJG65XcTvH
	 6gnoiRyHBaLUdoGa+WjpiVW58yUE004X3VxjciudcSd2aOBhXswMTrTChu3+nYj4Lp
	 kcUdFwnbsdKcrrF8pZwpsv2LnUxbFlOnYJsIibjrnxoGabU0o3S9Vx6aQWUhT+cz4I
	 TCKoaR5HNZ5GJ4NoyTXYqA6y7FN9u6PfJzjYaMbw/7cud1ss5Qf/9zWayE+TM5/dA6
	 ai7BzHNAfloM6/VPImWZtcObMiUlmzx+iXioXE5Pq2lH6eNuCAtD42mMMCxtr/m+Ok
	 ExBl2RbUt6ddErxUiQkmChBrYr0bbHhJwq1LyzVzbOOKZU5nTZ+TexyNXKeO4pJcEC
	 qjbhG9xi9X3QcY4J0Xo9SD7KzbXhs/+6wiy/e2wxD/62t0gkitoxk/iIV1UDatMJay
	 KAKxaysqZGlc1E/Zb9xN9fmz0/EZLpjWEZRnCwD03K9lRM3MdteCIEuPvCIzj4XrUL
	 e3lYqzLf0i9gB1ctt2aziSRewrgFfdlcKqlfoufXSHzqtL5nHCq9Mdwhw2eXCrDquL
	 48H5nPbazsVLnrgUZRZusOG/mLNIKWTHAqitr0/0uJx6cO5JA5Z6068up9PuWtgBvh
	 qB4uryi7jzqH4PIj3toO93LU=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3B8D140E016C;
	Sat, 27 Jan 2024 12:19:26 +0000 (UTC)
Date: Sat, 27 Jan 2024 13:19:21 +0100
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
Message-ID: <20240127121921.GCZbT0yXiYGvw7aefr@fat_crate.local>
References: <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
 <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126185649.GFZbQAccZphdW_0CkH@fat_crate.local>
 <SJ1PR11MB6083E6BF178B9D394BD58DDBFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126194522.GGZbQL0gTwpniYGDHw@fat_crate.local>
 <SJ1PR11MB6083E1000D4B267CF4271135FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126211133.GHZbQgBfqX4Qkdbmu_@fat_crate.local>
 <SJ1PR11MB6083B9CEE1398878664D90F7FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB6083B9CEE1398878664D90F7FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Jan 26, 2024 at 10:01:29PM +0000, Luck, Tony wrote:
> PPIN: Nice to have. People that send stuff to me are terrible about
> providing surrounding details. The record already includes
> CPUID(1).EAX ... so I can at least skip the step of asking them which
> CPU family/model/stepping they were using). But PPIN can be recovered
> (so long as the submitter kept good records about which system
> generated the record).

Yes.

> MICROCODE: Must have. Microcode version can be changed at run time.
> Going back to the system to check later may not give the correct
> answer to what was active at the time of the error. Especially for an
> error reported while a microcode update is waling across the CPUs
> poking the MSR on each in turn.

Easy:

- You've got an MCE? Was it during scheduled microcode updates?
- Yes.
- Come back to me when it happens again, *outside* of the microcode
  update schedule.

Anyway, I still don't buy that. Maybe I'm wrong and maybe I need to talk
to data center operators more but this sounds like microcode update
failing is such a common thing to happen so that we *absolutely* *must*
capture the microcode revision when an MCE happens.

Maybe we should make microcode updates more resilient and add a retry
mechanism which doesn't back off as easily.

Or maybe people should script around it and keep retrying, dunno.

In my world, microcode update just works in the vast majority of the
cases and if it doesn't, then those cases need a specific look.

And if I am debugging an issue and I want to see the microcode revision,
I look at /proc/cpuinfo.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

