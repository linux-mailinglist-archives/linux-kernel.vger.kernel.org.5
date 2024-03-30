Return-Path: <linux-kernel+bounces-125685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 967CF892AAB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EC29B21BC0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8B52BAEF;
	Sat, 30 Mar 2024 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME3SBlvP"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B20BE6F
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711797132; cv=none; b=Hr561AvK01G1YKpzwBzPFPC/jVM87ZJ9ysEmitzc5ahZc0DSDOCHdcmRsTdEtGcea3Hfpd45/gu++K18/lELdXCaUcFploWQgRMuYJ+9VuMvCz1pf14cXSrtGR4XC/2IEslPH2fMbiYPSNL8DLPOtM+BuUKZX9kum6wH4pXL6NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711797132; c=relaxed/simple;
	bh=/+93Og3Mv0PankfJrCm8noo2m99RdjfXeaL8llY6Zkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7sVU50pVAnPTgXVKymvyM3+/l/CoA5lzkpdmpVbsjBw2EMkTc0HW1R4XRZFuNU8+vTtcK/yHd+YFewtk2ulP2tVFjquuGpSJFi9LVFtC3cYOtlYa5kvY/2Flb4RlW2YRoKGJm4sHta71ZWRSa2QiRGl2mdPlwQd8b+QIqs9LIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME3SBlvP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4a387ff7acso328501066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711797129; x=1712401929; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDwKko1DTKW3c4OwHGe1slw6WwqSa57Xtn6YOo7f86Q=;
        b=ME3SBlvPZUtBk+GUZMkGi0dlhoyfpqKKMvig6cRPlyDVoy1wfpYpZ060jBje+16BSY
         dwD7AFGn5ECBB92EZh89oUJu1hKUeHfQ8IMaPjGXUM6dt4K+tPUEZb5RQ1xX8oOq3CIJ
         /trDsw/cpTgtv8u02XwuJxrRHlJh8e1YfSMWJUgl0VDu8hloqroy7YJiZ9QMb5MsEdtN
         Z0k/6HFFujYtUSrNwQ1dvrIsOY3mSs4LDVU/UStBcxJefT6QbRp2tyX1wcgK0dTexL7y
         a9nqXDlHa+njuzdKcRehh/FEaFXIk3fGAYIsPStwXXFZ1Ao1n+J8xXE5OgYVlThVsBUh
         wZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711797129; x=1712401929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eDwKko1DTKW3c4OwHGe1slw6WwqSa57Xtn6YOo7f86Q=;
        b=gasHfgm43COalWLbrkNS3RVJFUF6D6bhcDtejg4oHhkSDZWWgKVbDNHuL0A7iaroSA
         Z5qPB2p2pTWAgLe+ROesE2URDQxcpZG6cpasmvoyqaqDT+S0V7OcD861QFd9XLy7ufQQ
         HZ6BS+6rS4r7RXu8HQRWq+uY2gfoZ5P8wpgeRTt+UmenMAoD1tlh4HrNX770t3yCMtXj
         0rm4f9KQvJxGRx9AkgIFBf5dD6PyVt9+r40qshCB3ec4Ax+SjP9AemdqgRuj3Um+oUL0
         fh0e3vvbGH27v5749eys3UkSdYr97GR3mwmCHie6j6/MX/vvrMku4kEuZjsnL7ZfX1/M
         WC4g==
X-Forwarded-Encrypted: i=1; AJvYcCUiLFSBCg8R+RxbeRfLjxPC+4MEcClth0lgOVMf2tH4mDItJPXvRnI5yN7mAegqlEmsHy2RwLB8JhE3TOXekJ5gQkxNaL1jCcBlC+ad
X-Gm-Message-State: AOJu0YwRXbY+RhSLdbiLOwydAhqpGz59O1TCmqF10+9pLFGt125x67ln
	z/6S2tzHb+GhroI/RvBRQNFV1SLX/2IteuCuJSKrUoTgAbb+Yoqg
X-Google-Smtp-Source: AGHT+IE1ap2jUF03nDb1Ck5AiS6cak/UhsjfI9niuRfMCLjHuY008ZE5Cy+eAGnSmF6W5KvKcDw7iQ==
X-Received: by 2002:a17:906:f284:b0:a4e:2123:e3c8 with SMTP id gu4-20020a170906f28400b00a4e2123e3c8mr2775516ejb.56.1711797128733;
        Sat, 30 Mar 2024 04:12:08 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id h9-20020a1709060f4900b00a472c4b9486sm2995392ejj.84.2024.03.30.04.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Mar 2024 04:12:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sat, 30 Mar 2024 12:12:06 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: fenghua.yu@intel.com, bp@alien8.de, james.morse@arm.com,
	tony.luck@intel.com, peternewman@google.com, babu.moger@amd.com,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, james.greenhalgh@arm.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/resctrl: Fix uninitialized memory read when last CPU
 of domain goes offline
Message-ID: <ZgfzhjPP+kAQX7em@gmail.com>
References: <979cfd9522021aa6001f8995cd36fb56e1c9cd39.1711659804.git.reinette.chatre@intel.com>
 <ZgZnZgfDUWlhQQxW@gmail.com>
 <cc629f91-b4b5-4c9d-b47c-c40eddb03a07@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc629f91-b4b5-4c9d-b47c-c40eddb03a07@intel.com>


* Reinette Chatre <reinette.chatre@intel.com> wrote:

> Hi Ingo,
> 
> On 3/29/2024 12:01 AM, Ingo Molnar wrote:
> > 
> > * Reinette Chatre <reinette.chatre@intel.com> wrote:
> > 
> >> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> >> index c99f26ebe7a6..4f9ef35626a7 100644
> >> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> >> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> >> @@ -85,6 +85,10 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
> >>  	if (cpu < nr_cpu_ids && !tick_nohz_full_cpu(cpu))
> >>  		return cpu;
> >>  
> >> +	/* Only continue if tick_nohz_full_mask has been initialized. */
> >> +	if (!tick_nohz_full_enabled())
> >> +		return cpu;
> >> +
> > 
> > So we already have this a few lines up:
> > 
> >         if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
> >                 return cpu;
> > 
> > And we can combine the two checks into a single one, with the patch 
> > below, right?
> 
> Right. Indeed. Doing so is most appropriate. Thank you very much.
> 
> > 
> > Untested.
> 
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Please just pick up my optimization to your fix and submit a v2 - you 
did all the hard work.

Thanks,

	Ingo

