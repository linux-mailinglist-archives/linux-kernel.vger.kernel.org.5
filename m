Return-Path: <linux-kernel+bounces-129263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21648967EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF9328C65D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5826A71733;
	Wed,  3 Apr 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MD3geP9l"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D565D134418;
	Wed,  3 Apr 2024 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131577; cv=none; b=dznOpJHTNZsKGIdZMLt5d/eWLis0d1GjDsV1sJGrFH7csaDpjwQt390gPjMZ+Ed/qVQOO71oQ0CGqlduQZ1Wat/VFQLCLWbmTVysILZMdqT4BTaejlagm0IiO/3fE7Qn+meeFtdki22rV5ytd/9TiiwzcTUQdRcEKPSkdK2cS0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131577; c=relaxed/simple;
	bh=iDWigVh+imkJ9X0D+jZiWMMwXzwCp4g0Qv68aVRNWYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUcCDtei2VmcAKPEYrQ6a19wFb8ouZ6STzn03NT7gVfoS8f0+iTuMtnK8TyZZkQweH9FAlfvcTeFAEf/w3BUAEARUYp29IpcD59LrKW5G8TSJy9PWrUgvYz22XyVnHkfq0zBx43ePFAg+vxo5JcRR5imcuy/iw3CHsnx2JYx+x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MD3geP9l; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a465ddc2c09so336976066b.2;
        Wed, 03 Apr 2024 01:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712131574; x=1712736374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6WHGIKD551lF8wTwIhWNInmwZL2Kud7NJUZhv25O5kY=;
        b=MD3geP9luE5KeWt5kl+xCilZxZANMh59pKZNB0h5HZnrjizK5KSW/eJ6ZQAYNciNa/
         9o7rvLgNWTI55HwTgkx1qf8KwuqRIGXejRabdxMDRUilixeAFgQ9OtSY/3TRueHTj/3j
         e5pqrZBWvZ0cPai2nGW2oyxuenTF67+TdAzgbLvttnMOyXrHIGvC1eQjGe12nBaEOMdD
         Cd+NzKbLQZG1LxWQWUxaU3+kT27+LTi3PIAU1dqW8bCsaQry46W7UVHbT/4AyNHJlxwU
         OduS7wfNY/YLKLO9bPZRVbAZ3AL+Sw7a2gZtKoa09ZNlbJQ3FLGJx61oFHlSH+tL+Yzv
         ppOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712131574; x=1712736374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WHGIKD551lF8wTwIhWNInmwZL2Kud7NJUZhv25O5kY=;
        b=mDe0UFvL1wtw2WrkMRhunROUytPHVNM6j7ViLJnv+s0XIHUM4l6B0wmhef3BBi39/P
         GgQnfOahH0yaL9rvvD5DF+rg9fQQB4sTqY2YrWw1boGB/XLABMYh7ZhXwS1368cuCSyY
         p9RH0gdiEWhrog5OYU29ChbfnDVniHRyZ6oH/aG0t7eONuOiN5iKyRPBsVpQhcZlQy/r
         trS3L5zQdJ4Nj0U7/EnBlxc3NYZkuuxN5L6EirrS2sEf0VLV3pxX816No15uKyVnstSu
         aFgdHyU1kgBF+IKiUKj4yJXJrYDHjnfunWuVH1k08o2LWzcTTqkFVbuuQTocp6y2o9io
         Azxw==
X-Forwarded-Encrypted: i=1; AJvYcCUm3Ho66Ag9shbRxWbtGjVldZF7i3DTKSMhXHXBrCvUd8+0cCqKE5l54VSc1FaULwoUUj8/liCwr4MQOe4zAr9qPvMX/+Q8L1J1qk4+Y7xBMOrfFL17Ho7tc12XGxtmVUn/
X-Gm-Message-State: AOJu0YzQBgUmsqzX5hlVeEi5ffvsL/9BfrsgNjGF545T5K/YjoFdLN4F
	yANX1pWVvoKFhIMY0LJZPO6wNwyOYUsHJ0QLaXUas9T05mEGhi+w
X-Google-Smtp-Source: AGHT+IFepiu4oRgTc8adbzTnLE3AhBosdPeCKzHoE0bIey/qYMU++sVnV8kEwple8BtMzSURM3bu2g==
X-Received: by 2002:a05:6402:5253:b0:56d:ee15:4925 with SMTP id t19-20020a056402525300b0056dee154925mr3774580edd.0.1712131573804;
        Wed, 03 Apr 2024 01:06:13 -0700 (PDT)
Received: from gmail.com (84-236-113-97.pool.digikabel.hu. [84.236.113.97])
        by smtp.gmail.com with ESMTPSA id f8-20020a056402150800b0056e0988bccesm329848edw.31.2024.04.03.01.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 01:06:13 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 3 Apr 2024 10:06:11 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, x86@kernel.org,
	peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org,
	song@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v4 0/4] perf/x86/amd: add LBR capture support outside of
 hardware events
Message-ID: <Zg0N87sfBdB5Cydk@gmail.com>
References: <20240331041830.2806741-1-andrii@kernel.org>
 <Zgp+lYLOZU3OkO7w@gmail.com>
 <CAEf4BzZEuDRt=dLN79uJ0EwQcxuxCp8LZx1ayNBsw82BytPTqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZEuDRt=dLN79uJ0EwQcxuxCp8LZx1ayNBsw82BytPTqg@mail.gmail.com>


* Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Mon, Apr 1, 2024 at 2:30 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > Add AMD-specific implementation of perf_snapshot_branch_stack static call that
> > > allows LBR capture from arbitrary points in the kernel. This is utilized by
> > > BPF programs. See patch #3 for all the details.
> > >
> > > Patches #1 and #2 are preparatory steps to ensure LBR freezing is completely
> > > inlined and have no branches, to minimize LBR snapshot contamination.
> > >
> > > Patch #4 removes an artificial restriction on perf events with LBR enabled.
> > >
> > > Andrii Nakryiko (4):
> > >   perf/x86/amd: ensure amd_pmu_core_disable_all() is always inlined
> > >   perf/x86/amd: avoid taking branches before disabling LBR
> > >   perf/x86/amd: support capturing LBR from software events
> > >   perf/x86/amd: don't reject non-sampling events with configured LBR
> > >
> > >  arch/x86/events/amd/core.c   | 37 +++++++++++++++++++++++++++++++++++-
> > >  arch/x86/events/amd/lbr.c    | 11 +----------
> > >  arch/x86/events/perf_event.h | 11 +++++++++++
> > >  3 files changed, 48 insertions(+), 11 deletions(-)
> >
> > So there's a new conflict with patch #2, probably due to interaction
> > with this recent fix that is now upstream:
> >
> >    598c2fafc06f ("perf/x86/amd/lbr: Use freeze based on availability")
> >
> > I don't think it should change the logic of the snapshot feature
> > materially, X86_FEATURE_AMD_LBR_PMC_FREEZE should be orthogonal to it,
> > as the LBR snapshot isn't taken from a PMI.
> >
> 
> Yep, seems like there was a parallel change to related code in 
> perf/urgent branch. And yes, you are right that it's orthogonal and 
> doesn't regress anything as far as branching and whatnot (just 
> retested everything on real hardware). So I've rebased my patches on 
> top of perf/urgent, will send v5 momentarily.

Thank you - it's now all in tip:perf/core and lined up for v6.10.

> Sorry for an extra round on this.

Not your doing really - just crossing patches.

Thanks,

	Ingo

