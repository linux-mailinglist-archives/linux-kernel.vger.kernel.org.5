Return-Path: <linux-kernel+bounces-66502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E508855D8A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9863B281C7D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B8617586;
	Thu, 15 Feb 2024 09:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ieQ5BDR8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CtUvaV0g"
Received: from flow7-smtp.messagingengine.com (flow7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58CC14006;
	Thu, 15 Feb 2024 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707988433; cv=none; b=Jx18HbnF9LZPgieQW+KfyNJj5n4c2BCLAI42Y+HjK8feLDtu1T8DW2GkKbqu6j1T1QfM38aY5n87lI9W8mnqczEGTZpB/EyO3VKZ4IqGn+gTHJioYD0FpkTIqqRC4xECqlaXBOEDyAIaEhCbkiTfSgcxSCZmgfQ1gf+JmBDYEQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707988433; c=relaxed/simple;
	bh=O/RwfPbZqb3ZvLhvEoH0BjeWEPwr1fYoyD00l7xYTL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0keAoOUf5JU3bIfNMhlZniBYIgeC2YSDWuatgHiJfCGGfpJFxMCFRUwwT9wOLOqpHZkAw68HH1+jVR3FjmAwfTsqoCnBg5c/KnUMCQg32TSdFjtY+oexG3HbZwHDm/eNmkXWpSWjvJNFUXEpqGZ9r2dn2Y1OcZelBF6WEBJ1NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=ieQ5BDR8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CtUvaV0g; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailflow.nyi.internal (Postfix) with ESMTP id AD7AC2000F8;
	Thu, 15 Feb 2024 04:13:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 04:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707988430; x=1707995630; bh=IC4m81oUgj
	/tsdcLSrr2mqEGqSm9cd9fjfFWN3WrsQE=; b=ieQ5BDR8Bs4J8ZW50oIAXYAsao
	UTrP6+iqpCdYfl+BE1ZU/iYQi40eFNZfAq5UehitINaslGjEjsylvNqg556xqtwP
	vqT+ZXXZBsftS3968V0CdX63apikIw4AQ9rJTEg3DdarH/SuLjhlB7ApJVFu+WFZ
	kisOFmznpVnDsSjXEvGiu90SF45Lcq0Xi/Wb894yfokeS34EKk3oskqJx5aTWTBB
	V+/kyYYmMN1buQBiJdJwFSDH7D3kBl5sebixEGOd1v/ImizfbqiExBSA66SHJiYl
	i3RwJIx90b6ybiWlmaN11RZFlwBGq2pypHKtv/3zXDgk0Ry3pT0oYaDMTp3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707988430; x=1707995630; bh=IC4m81oUgj/tsdcLSrr2mqEGqSm9
	cd9fjfFWN3WrsQE=; b=CtUvaV0g2T8ifSQZWiCIE5LJK6NMOZ6lk3NlNBEvB7Ii
	EHgTyVtYplEvuHy3DgmnELZpfTCAqBCmDhsGt3KnkxzTwRY2FroxVx0P2UiKiwH/
	LGOk6Rki59VnzjG5qLmD4reI5GOxpjBoXK5krsGOCrwWk/cnRK86I/ZswQ9KFjNY
	H/U0irm1accRpX/HGUkFk9o1PFVBGPIwersMNqtlJ7MXffDsXtDuOJkC5ETruE3x
	3OSdI4ypz4DPoWJRHV0T+a98R5UlD9NGUCnITheXZPucfvVI+u8gd8JHOjEEk9OA
	AbD9Xol0TDQLGhl4rsLl3++2COhaeAzrLU1ZmwSYxA==
X-ME-Sender: <xms:zdXNZVmfO_RiDekOPDAVHtBn-NPqX5mTVRePn0b8oEulTwg_4jK5sg>
    <xme:zdXNZQ3rjuquUHhf6-zg5hAltWOcuNtIUNdGxUYOp_gpCKbCctkDGNvt6PNbbQD8s
    G6uYzluW9mMRQ>
X-ME-Received: <xmr:zdXNZboaZDO3YBGaO93LVD-TAUt6mh-DX_MbjxhsG5YEbl4KnC2sT9J2CSMfM2nYs8-XqlYvkMhE1fo0-r-o1D84nJWqhpJT4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfmjfcu
    oehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehueehgfdtle
    dutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgrihhnpehk
    vghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:zdXNZVnp_QUPhQz5CwySBHttpZNc1Xf-eWBRj2HJftKiRY9eINUqgA>
    <xmx:zdXNZT0VEjVElFQlldwJh3isoTCKVkLLONzjR30Hm-FdC4oTDXMXhA>
    <xmx:zdXNZUt16tIgFkoSN1XNMWaPLzG1Kt1Er7MMDoekQC7K2CEpyLgtyw>
    <xmx:ztXNZWxfD0c6ofm_OMoiqXqAu-hjN5NFNX9jucnst7Hz7n8kGiKzBGEGti4>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:13:48 -0500 (EST)
Date: Thu, 15 Feb 2024 10:13:47 +0100
From: Greg KH <greg@kroah.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jon Hunter <jonathanh@nvidia.com>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	wkarny@gmail.com, qyousef@layalina.io, tglx@linutronix.de,
	rafael@kernel.org, viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Shardar Mohammed <smohammed@nvidia.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] sched/fair: Fix frequency selection for non invariant
 case
Message-ID: <2024021545-rise-plot-24c3@gregkh>
References: <20240114183600.135316-1-vincent.guittot@linaro.org>
 <6ec54a8f-a602-4f33-96ce-0204f07046e1@nvidia.com>
 <CAHk-=wgjiVanO4ZS1hy2sfAFTN_pYtQqVQb_g+dbrP34M6xTDw@mail.gmail.com>
 <CAKfTPtA8W+SijB9D3GtNbC7o_XHUV-umcL6chJQbMDxWeX7exg@mail.gmail.com>
 <42052f23-d582-4533-a09d-a1de437836b7@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42052f23-d582-4533-a09d-a1de437836b7@leemhuis.info>

On Thu, Feb 15, 2024 at 09:45:01AM +0100, Thorsten Leemhuis wrote:
> Linus, what...
> 
> On 14.02.24 18:22, Vincent Guittot wrote:
> > On Wed, 14 Feb 2024 at 18:20, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> >> On Wed, 14 Feb 2024 at 09:12, Jon Hunter <jonathanh@nvidia.com> wrote:
> >>> We have also observed a performance degradation on our Tegra platforms
> >>> with v6.8-rc1. Unfortunately, the above change does not fix the problem
> >>> for us and we are still seeing a performance issue with v6.8-rc4. For
> >>> example, running Dhrystone on Tegra234 I am seeing the following ...
> >>> [...]
> >>> If I revert this change and the following ...
> >>>   b3edde44e5d4 ("cpufreq/schedutil: Use a fixed reference frequency")
> >>>   f12560779f9d ("sched/cpufreq: Rework iowait boost")
> >>>   9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor
> >>> ... then the perf is similar to where it was ...
> >>
> >> Ok, guys, this whole scheduler / cpufreq rewrite seems to have been
> >> completely buggered.
> >> [...]
> > This should fix it:
> > https://lore.kernel.org/lkml/20240117190545.596057-1-vincent.guittot@linaro.org/
> 
> ...do you want me to do in situations like this? I'm asking, as I see
> situations like this frequently -- e.g. people reporting problems a
> second, third, or fourth time while the fix is already sitting in -next
> for a few days.
> 
> Want me to list them in the weekly reports so that you can cherry-pick
> them from -next if you want?

Poke the maintainer to get off their butt and submit the pull request to
Linus (note, this is me in this case...)

I'll get it into the next -rc, sorry for the delay, other things got in
the way, my fault.

greg k-h

