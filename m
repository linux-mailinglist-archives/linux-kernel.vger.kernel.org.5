Return-Path: <linux-kernel+bounces-124261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADB2891488
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9016FB2119A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F6A4AEED;
	Fri, 29 Mar 2024 07:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXR7g0yQ"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43247F72;
	Fri, 29 Mar 2024 07:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711698365; cv=none; b=VGKfbSrxdWjoG7/EL2pKgg0M67BNOqwCR/6Imv3tNvWoJI3GYsZ/BbaacbLANmpN5ptowoo2uPsGZWIO1C7sxek3tUA3QfvjJfZy/gHnNSMTGRa6AkY319WxpSLBtkRwbhrNPYCQVHSPf222c9VHg0PdAPU4UnKCXaNqCFkBcEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711698365; c=relaxed/simple;
	bh=cIQGV4no67TZGCVXh3aHtkM6DpSuoHxi9Ne/BxaufHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChyAuf5rZQPTkpyuZ1LtPGS8o8voAXKk4krHGZpRP5II5K0wQzKSb9Mf0g3XHdtgjrvl/iL/gZ21W4+ZhzH7p9HrGSY7aCgyI8hqgyujtWbRprTmnGoRsDX26wgRHAq8u07BIvzB/xdg3ntlvWDAPF4SdAbtBJ8FfHBsHtr83K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXR7g0yQ; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so2494063a12.2;
        Fri, 29 Mar 2024 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711698362; x=1712303162; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXT7CUSk8l4wjXwLdeSj0Hr6QLguW0zMSkZ3sxTxHBg=;
        b=QXR7g0yQI5w11AjGnmJhKguJLGuxonzloSHmHPMLTAqZR4G/gOjjIuAQbZOM8Zg8zI
         of0/crN8tEtRL/YSF9abObHgqcQq1v4fU/RzcNumkk18+sADHSGz43+lWzmrphropXY1
         AR1Nm0ibJuCiFIuuGFJsaGyMYnM/OT8yhHPhRM+jKBtPuFdaUlj7u79ec3TX/Xb6i0xb
         EdE6yB8JyAzaEBS0F5xJZNrNgqroFvVdayDDb5eCNw1Vm9b88W3Jv8xD4OyCwOnyJ2Bs
         C5xgqXE0ybkgrzKJ3Eg5GfSoH9y+IshuQ9U1SvUj4FBfsL3+RrzossKEppCcHKGnBdax
         XSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711698362; x=1712303162;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XXT7CUSk8l4wjXwLdeSj0Hr6QLguW0zMSkZ3sxTxHBg=;
        b=XvO0ocSlEyZmJIFFpqSrxy4AekNkmHsjebBR+gw+LBEn7c3h0PgUBdjxkgo5yYWmPP
         czTxGn0cLEnjBciBtg5H/WKYM3+2ZOSCi3IaDcoJi1JlZPe2YvumCpCbSZh24U49MFWX
         NvvNj52rA2WeINYG53KO5eVq8L/Xiw4NTC7Vx9YE9YhZ0A3+IPqebGViFw3JFefkDXFf
         MKub50EjjCKg7SDDtjShpDIWQyOdPzXyUi4chjcnKCZCFT7Ut9mVbOi00vF5t3mwpHbf
         u0BE2LqvCzaquCgrHCfmRzliFGIm4ygyi+sV3zuwvTC/Ur9Mk0B7D4VZMLzTWJuhZ8Wl
         H3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWA++hRmRKCDJv7DekQHDwm7kRqDyGM1y0l0Z0xV0HGdaI9UsE1ey00RF8sech+tHQtvuohgY1B5QbKVGIAn4UrVY0lVAlk7uLpf5zTrFos1iFtoXU/IKfTvkmnObEkc3s
X-Gm-Message-State: AOJu0YxbAEoiae0yA8IEBhRPEeici6VxvXvZyu3EUd3wMgmTHBd1QbLP
	ZSUsoekLL9yvpSv59S5oQ8KCM6ChQV88leMTRtoXAwFB+gNhlectPdb1/ogp3bA=
X-Google-Smtp-Source: AGHT+IGc+j+itDWRUb1Gj7sF2MGo3T4hhdqDL8UhvGGTMBZd6P4wffkz0YnkrJ1thAoKjjKbv39H1Q==
X-Received: by 2002:a50:9344:0:b0:56b:fd17:3522 with SMTP id n4-20020a509344000000b0056bfd173522mr915869eda.14.1711698362153;
        Fri, 29 Mar 2024 00:46:02 -0700 (PDT)
Received: from gmail.com (195-38-112-2.pool.digikabel.hu. [195.38.112.2])
        by smtp.gmail.com with ESMTPSA id fd6-20020a056402388600b0056c53ea5affsm1492882edb.77.2024.03.29.00.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:46:01 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 29 Mar 2024 08:45:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	peterz@infradead.org, mingo@redhat.com,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, song@kernel.org
Subject: Re: [PATCH bpf-next] perf, amd: support capturing LBR from software
 events
Message-ID: <ZgZxt9ypus++f5me@gmail.com>
References: <20240319224206.1612000-1-andrii@kernel.org>
 <ZgVSxPJ4Yi/UPgjb@gmail.com>
 <CAEf4BzZkn2atLmN35tviXBu1EggRRg3Yqh2pHAnd6xe7V5xkUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZkn2atLmN35tviXBu1EggRRg3Yqh2pHAnd6xe7V5xkUA@mail.gmail.com>


* Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Thu, Mar 28, 2024 at 4:21 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > > [0] added ability to capture LBR (Last Branch Records) on Intel CPUs
> > > from inside BPF program at pretty much any arbitrary point. This is
> > > extremely useful capability that allows to figure out otherwise
> > > hard-to-debug problems, because LBR is now available based on some
> > > application-defined conditions, not just hardware-supported events.
> > >
> > > retsnoop ([1]) is one such tool that takes a huge advantage of this
> > > functionality and has proved to be an extremely useful tool in
> > > practice.
> > >
> > > Now, AMD Zen4 CPUs got support for similar LBR functionality, but
> > > necessary wiring inside the kernel is not yet setup. This patch seeks to
> > > rectify this and follows a similar approach to the original patch [0]
> > > for Intel CPUs.
> > >
> > > Given LBR can be set up to capture any indirect jumps, it's critical to
> > > minimize indirect jumps on the way to requesting LBR from BPF program,
> > > so we split amd_pmu_lbr_disable_all() into a wrapper with some generic
> > > conditions vs always-inlined __amd_pmu_lbr_disable() called directly
> > > from BPF subsystem (through perf_snapshot_branch_stack static call).
> > >
> > > Now that it's possible to capture LBR on AMD CPU from BPF at arbitrary
> > > point, there is no reason to artificially limit this feature to sampling
> > > events. So corresponding check is removed. AFAIU, there is no
> > > correctness implications of doing this (and it was possible to bypass
> > > this check by just setting perf_event's sample_period to 1 anyways, so
> > > it doesn't guard all that much).
> > >
> > > This was tested on AMD Bergamo CPU and worked well when utilized from
> > > the aforementioned retsnoop tool.
> > >
> > >   [0] https://lore.kernel.org/bpf/20210910183352.3151445-2-songliubraving@fb.com/
> > >   [1] https://github.com/anakryiko/retsnoop
> > >
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > >  arch/x86/events/amd/core.c   | 29 ++++++++++++++++++++++++++++-
> > >  arch/x86/events/amd/lbr.c    | 11 +----------
> > >  arch/x86/events/perf_event.h | 11 +++++++++++
> > >  3 files changed, 40 insertions(+), 11 deletions(-)
> >
> > Please do not queue these up in the BPF tree, all similar changes to
> > perf code should go through the perf tree.
> >
> 
> Absolutely, I rebased on top of tip's perf/core branch and sent it as
> v2. Thanks!

Thanks, much appreciated!

	Ingo

