Return-Path: <linux-kernel+bounces-59749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E92284FB35
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AE728EDA6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711F80BFA;
	Fri,  9 Feb 2024 17:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="A8nl5JmG"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910727BB15;
	Fri,  9 Feb 2024 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500528; cv=none; b=Ei0O8MmIQyothlc06ibHEWPwolvSSvhUhbywISxruj22+Drg1MiagB+Amq5CSVKIJBPGqTnS3SuQWVvudOy4xzYl/ZVd8FbYM6g6MzDiNTJig/xSBPpIb/AtWVNleg4NCdo3SUgeRGrRPwNSbzxbn8wFPQvv21Q5vEojUSOihKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500528; c=relaxed/simple;
	bh=5m/3eJmfothhnhgxKnpNtpJvugtTYUTPVjgm3HJHwlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJsDDEcKvH4f7Ig+TWjowV/jXA7eC7Hki3Rh4+55fnMrK1AcA6BOfg4iyAnBW4pITTQUkRyBqy6G287SJGvB4s/Xml4iNRngAxrLZJaHgMOoal9k96p8W8atDO+z/nwZQeOBrz3dSJSTDidA3cOHlwgvXRtYc0l5uT2gxMDHbwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=A8nl5JmG; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7AE1940E01A9;
	Fri,  9 Feb 2024 17:42:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id vPlwjzkI-XUz; Fri,  9 Feb 2024 17:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707500522; bh=mGQ5M66FN/MWid9y/3BfbjpRXrDFgbqHu66GLoKJcCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A8nl5JmGx+0NzvVn8k1oO9VMbOBGpj+aJqmmPBQPk7BfdUfsA9Miy9VEK2oPYoB2j
	 PUe9qNw7ol4OeV6BvW8BQF9kB31kIb7a/KbZutP14jzTKHp7z0j/cgvMWD8+drbycz
	 x2lm2ElA2I1kNUzhUG53HTnhZF1/E+zGIZLKRZhYMje227mgkik8ZwWGpqStv7Y9RC
	 NMsBPT+57ol3i/7Io1ZmB4QdhpUpxsi4M+HkbJ8SONmbHWHyu0aTn8j/makSGDN3kg
	 3h8bbIZAQNeAgYN6O7nDCr8C0GcBFGo+phVjCjFuu3OaCiqc6RK8XSeYQs/YvpBRnw
	 m72jFT4oy8WcHqv+9pTlCNJNS1p1entpUFbGmJDw1IcNrJuWMT9rFo8q3YZdX6CEBA
	 eoQhmE5W+y4clMJIvLZNx6VZFyDECO+DLNrLHnGDdvd68x3GJJSaQmPqsrzUBSBlaU
	 RCGSp4t9R9yded72vFxjeYWyxnv/1cYY+tR1INMy7k5O6ah+MlzVdg8mNrcsN4cw0s
	 rqsHVU31kpuEdpiSVHtp3uo21J6PKOEpj+mutxpsdQ7jWkxAVhn3Y3FvQEMIR5Xk7u
	 QjAD4SMngUVfHI/occoKlDYVbnszhDmaxqP2iKi+OjyzzUWTaiyyQCsf2AX3EifzrL
	 5NNPjy/7UJz6Z9+CEUZQxRTo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4B02F40E0192;
	Fri,  9 Feb 2024 17:41:50 +0000 (UTC)
Date: Fri, 9 Feb 2024 18:41:45 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "Yuan, Perry" <Perry.Yuan@amd.com>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"Limonciello, Mario" <Mario.Limonciello@amd.com>,
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Huang, Shimmer" <Shimmer.Huang@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 0/6] AMD Pstate Fixes And Enhancements
Message-ID: <20240209174145.GCZcZj2XKVsWSIefuz@fat_crate.local>
References: <cover.1707363758.git.perry.yuan@amd.com>
 <20240208102122.GAZcSrIkbPJfIExdF6@fat_crate.local>
 <BL1PR12MB514409256AE93E5D13556F90F7442@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20240209155119.GAZcZJ92bTnwwO8l6Z@fat_crate.local>
 <BL1PR12MB514496D92AE89A52D767192DF74B2@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BL1PR12MB514496D92AE89A52D767192DF74B2@BL1PR12MB5144.namprd12.prod.outlook.com>

On Fri, Feb 09, 2024 at 05:33:35PM +0000, Deucher, Alexander wrote:
> My reading of the rules is that you should wait before resending or
> pinging if you have not received feedback. 

But the feedback you've received is not the whole feedback. Someone
might want to review them but not have the time right now. So at the
time we did agree that a week is kinda ok to let people have a look.

And from experience reviewers tend to ignore patchsets which get resent
rapidly.

> If you are actively receiving feedback, to me, it makes sense to
> rapidly iterate.  If a patch is reviewed and comments are addressed,
> it can land rather than waiting an extra week or two.

There's the other problem - if you keep dealing with only a single
patchset, all the others who are waiting get starved. I, for example,
try to have at least some fairness when it comes to looking at people's
submissions and round-robin between them as much as I can.

> It also adds extra latency.  With my maintainer hat on, I'd like to
> have new revisions rapidly.  I guess it comes down to personal
> preference, but I don't do well with task switching.

I know *exactly* what you mean. I usually read my replies to the
previous submissions in order to swap in everything I was pointing at
the last time...

Can you review it all? Definitely not. :-\

> When a patch set is fresh in my mind, I'd rather see it finished off
> and committed sooner rather than lingering and then a week or two
> later, I'd need to page the whole discussion back into my head to make
> sure everything was addressed and all the tags were collected.

Yeah, I definitely see your point. But there are also those other
things I mentioned. I think one could find a good balance between the
two...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

