Return-Path: <linux-kernel+bounces-123371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0F890749
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C027B2560A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F43535CA;
	Thu, 28 Mar 2024 17:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtS9F50v"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E68814A84
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 17:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711647532; cv=none; b=amagwZzR0RQwzmOjhfVsdmIQh2AtjwkB65gFTFU302jiR3gnUECEr/bRWeOyxfmKGC1I22wT5kwznNmDAT5uZJwubpqRcNC2pjNzYYNfsRAcQeaVW05oYAdxEFwgefbnlgkmNcEBt/IlfA5nUUpgwMZ7jyirZuE/KpjTEoTo0o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711647532; c=relaxed/simple;
	bh=mTJ0nmtG0NZNp0eWCead9GHxzS4WDqTAoa7fzaxOO1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScRA+pbQKN57+LOxaVLcTCpAoK9MaxLVugXS1BpK76Rplp7aUvmnroHX6kREQGFVmlFVzgOtjzDCT744RIe+5qxRdgw/bF/M+oYutrKBXujb37bxH+i/b+RQL0JZUoQOY8Gmwn5qLpkLPqGfG9FI4ecwyPvpnZ+/mgW6cI3jhck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DtS9F50v; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a20c054811so437036a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711647530; x=1712252330; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EcQTD2Kr0y2yHUjxPpxpF3woyw+SyS6YRJDLTY40Bqo=;
        b=DtS9F50vd1BVL/7SxNEYhcpuX8LewK0x8GsUaesHVTp60rtrr9cnDj8bVaYEcSS7Y3
         V8FWtyRzwfETD0oJhbPHYlVZj9NL4TvExDK4+q4uEob7kcGPSJJL+ZvdSDUeXU9eDp6y
         KRSbNeOoB9X78kf90aJciSKX/zIvEfmzSdjASnq0xaLdiAvRvkn9UNoOXiF20SgssptM
         Tp3EB0W6w58wZRyd7gPN1VZhmR9s+NmWXJRDaKttIF+EiRdJNYOmgR4KFgzN5yD/rpqi
         iXc1VXPEoAAiqRs1wVSyNIyo3PU2KGTK5WTJ6MlU3W1qja34LwQf9ZICbBfngh3LNPJp
         Eacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711647530; x=1712252330;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EcQTD2Kr0y2yHUjxPpxpF3woyw+SyS6YRJDLTY40Bqo=;
        b=fXxBayvqafeSTUTK7N4Yt7mr8jIBnMfZWT2T6zsXqnEey5FY/JZs+cHRYtwLVmi/sn
         jWZNib6Xmu8lPD6kFBj8JOtYNCiTfImMy0XR7I1kyD1iHtebgZ8qvaHPGHKeXzhCLgC+
         Ivv65UQUN9lQxzv3vbZyZg0MFpc1ba/jUzV1XsJkExZQiK1rqFNjO5V/PhZKQTXyaR3E
         3GHYCa35OEONjfvaYt7wJMfb92XTevetZq2ku0KmU4N8Aj2I2Fhmeg00+sHOY8eEyd+5
         Wvp1W+CnyHJaxzfCiwyOS6d1sC5R1jnPIOovOqRBvOiLPK2crpUe9b+yalkls4csTH1r
         zrvw==
X-Forwarded-Encrypted: i=1; AJvYcCW62WBJOVhEis5d3yj1VQ2eofY2dcfBYrl1I6+LWVxQqWT+M4iW3/RYSssHnK9lkZNe/3KTSrBM/LwtVTiCp1h8iGqGvMNQjLbBUHPu
X-Gm-Message-State: AOJu0YzSceC0VVIn/DOwrJPOK8RiirIGC7P5HIcFD8dG88cY4C38Fomy
	Pjot2a6ihd1oqYD+PxNnGCBd7LkK7qhBnhMKyeqwfzYfAuORbZxwdd61J5rzWgVXrb5ZF9gMQHh
	VXIzOeXSXnvogD+jl1Fn8tphRJR9I2dyenhjuWA==
X-Google-Smtp-Source: AGHT+IE3WwtFIH0kVnVKEFAwqITjKvf/SjYZPDfN1LKWvwo5hkfPrdMbq7NnfsGNxpX6ZYOqgDyDogM9TBn4IGF+rMM=
X-Received: by 2002:a17:90b:682:b0:29b:331e:ec47 with SMTP id
 m2-20020a17090b068200b0029b331eec47mr117121pjz.27.1711647529777; Thu, 28 Mar
 2024 10:38:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711584739.git.vitaly@bursov.com> <da4454bf368e51369c74e4574d22e8f0bfd9d368.1711584739.git.vitaly@bursov.com>
 <CAKfTPtCux6diCArXcF11w+D1VMKLwj-eWUeXQq3d=2=2Xfe8uw@mail.gmail.com>
 <1679cb16-a4a1-4a5f-9742-3523555d33f9@bursov.com> <CAKfTPtDbRUNEQ4g3rBxuC8daa6Dj_Eba8mHhVr+9UZ9eAFTPkw@mail.gmail.com>
 <163e1980-41ff-4a5f-9d93-431e65fd3a9d@bursov.com>
In-Reply-To: <163e1980-41ff-4a5f-9d93-431e65fd3a9d@bursov.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 28 Mar 2024 18:38:38 +0100
Message-ID: <CAKfTPtDu_kMMMfgToyTqhiPQ6biBo1ROjccUBrPuaQwyqG14=w@mail.gmail.com>
Subject: Re: [PATCH 1/1] sched/fair: allow disabling newidle_balance with sched_relax_domain_level
To: Vitalii Bursov <vitaly@bursov.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 18:10, Vitalii Bursov <vitaly@bursov.com> wrote:
>
>
>
> On 28.03.24 18:48, Vincent Guittot wrote:
> > On Thu, 28 Mar 2024 at 17:27, Vitalii Bursov <vitaly@bursov.com> wrote:
> >>
> >>
> >> On 28.03.24 16:43, Vincent Guittot wrote:
> >>> On Thu, 28 Mar 2024 at 01:31, Vitalii Bursov <vitaly@bursov.com> wrote:
> >>>>
> >>>> Change relax_domain_level checks so that it would be possible
> >>>> to exclude all domains from newidle balancing.
> >>>>
> >>>> This matches the behavior described in the documentation:
> >>>>   -1   no request. use system default or follow request of others.
> >>>>    0   no search.
> >>>>    1   search siblings (hyperthreads in a core).
> >>>>
> >>>> "2" enables levels 0 and 1, level_max excludes the last (level_max)
> >>>> level, and level_max+1 includes all levels.
> >>>
> >>> I was about to say that max+1 is useless because it's the same as -1
> >>> but it's not exactly the same because it can supersede the system wide
> >>> default_relax_domain_level. I wonder if one should be able to enable
> >>> more levels than what the system has set by default.
> >>
> >> I don't know is such systems exist, but cpusets.rst suggests that
> >> increasing it beyoud the default value is possible:
> >>> If your situation is:
> >>>
> >>>  - The migration costs between each cpu can be assumed considerably
> >>>    small(for you) due to your special application's behavior or
> >>>    special hardware support for CPU cache etc.
> >>>  - The searching cost doesn't have impact(for you) or you can make
> >>>    the searching cost enough small by managing cpuset to compact etc.
> >>>  - The latency is required even it sacrifices cache hit rate etc.
> >>>    then increasing 'sched_relax_domain_level' would benefit you.
> >
> > Fair enough. The doc should be updated as we can now clear the flags
> > but not set them
> >
>
> SD_BALANCE_NEWIDLE is always set by default in sd_init() and cleared
> in set_domain_attribute() depending on default_relax_domain_level
> ("relax_domain_level" kernel parameter) and cgroup configuration
> if it's present.

Yes, I meant that before
9ae7ab20b483 ("sched/topology: Don't set SD_BALANCE_WAKE on cpuset
domain relax")
The flags SD_BALANCE_NEWIDLE and SD_BALANCE_WAKE could also be set
even though sd_init() would not set them

>
> So, it should work both ways - clearing flags when relax level
> is decreasing, and not clearing the flag when it's increasing,
> isn't it?
>
> Also, after a closer look at set_domain_attribute(), it looks like
> default_relax_domain_level is -1 on all systems, so if cgroup does
> not set relax level, it won't clear any flags, which probably means
> that level_max+1 is redundant today.

Except if the boot parameter has set it to another level which was my
point. Does it make sense to be able to set a relax_level to level_max
in one cgroup if  we have "relax_domain_level=1" in boot params as an
example ? But this is out of the scope of this patch because it
already works for level_max-1 so why not for level_max

So keep your change in update_relax_domain_level()

Thanks

