Return-Path: <linux-kernel+bounces-92177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3958871C52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 809791F255C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E189522097;
	Tue,  5 Mar 2024 10:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aD1aIHIY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39F3EA90;
	Tue,  5 Mar 2024 10:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635610; cv=none; b=d+04TYHeqX2Dv43v1gxclOPvbXwCdXFBzkAeOfOzIG6owYzZHf49SMNtLjYmdtq3nIPKgqSkzaNeD8qxRF2+9mIY2Et6BwQItLPHTsUco3XqoeBOjnhVkRY8zrs9KUnjnchgoe0zYoYt8MzwjYqgzblW0IHCHxeSYGXUvRgO2uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635610; c=relaxed/simple;
	bh=mjAuyuvA9ZdWxFTUqAfiA34ElW/sURoOH878JjpXRBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ose7VtxIfxH51OBVoPY/4h1h244y94v5bE097234Wr+xfFicnyTd+lbrS+VDAqTg/o8NtiAKSGJQmq/DnYmwfTb2ucjh6+6f1YgOCGuprBC1PmQcZW1ImEFID1a01z0GDo8R+/KRMJs8Y83PuJ1m80SKY/d7oBjXqO3una2pQtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aD1aIHIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC16C433C7;
	Tue,  5 Mar 2024 10:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709635609;
	bh=mjAuyuvA9ZdWxFTUqAfiA34ElW/sURoOH878JjpXRBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aD1aIHIYiKzuX8QL9/005A26ktUHANdjd2kNLmArfp4csJ7dlQm+MFXbX12UbYit3
	 Ec9GachpHAngTpeJuqaoV9yAzwWK92JAotuPrWxLny3S+/OEwI63aIt0k74chDuHEt
	 HkuZF2iGvi5/GZmRt2dN6Y+8/sCi9OQ/6m6cyFvSZYkea1g1xP+yimNFZf3U5EtyMW
	 0NJM6nfiAmJg3gyLKgopAkgYDTCyTTnzHoUK1f5+4Kyd5c1orm29vcjATct85e/okC
	 FmVbn3nJvz7VciTEdAUrEyxybcQ0n2U9DytQnDE7TyT6c4DyI4s5rssByOSVQ5t3KW
	 uG561wm+GjQLw==
Date: Tue, 5 Mar 2024 11:46:46 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <Zeb4FpYEs/ocJMji@lothringen>
References: <202403011511.24defbbd-oliver.sang@intel.com>
 <ZeUWreWcp4UWQ081@pavilion.home>
 <ZeUuLPXfLCmB39qq@xsang-OptiPlex-9020>
 <ZeWwYUY56IG0yzzQ@localhost.localdomain>
 <ZeaAx662HfbpMLdg@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeaAx662HfbpMLdg@xsang-OptiPlex-9020>

On Tue, Mar 05, 2024 at 10:17:43AM +0800, Oliver Sang wrote:
> hi, Frederic Weisbecker,
> 
> On Mon, Mar 04, 2024 at 12:28:33PM +0100, Frederic Weisbecker wrote:
> > Le Mon, Mar 04, 2024 at 10:13:00AM +0800, Oliver Sang a écrit :
> > > On Mon, Mar 04, 2024 at 01:32:45AM +0100, Frederic Weisbecker wrote:
> > > > Le Fri, Mar 01, 2024 at 04:09:24PM +0800, kernel test robot a écrit :
> > > > > commit: 
> > > > >   57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
> > > > >   7ee9887703 ("timers: Implement the hierarchical pull model")
> > > > 
> > > > Is this something that is observed also with the commits that follow in this
> > > > branch?
> > > 
> > > when this bisect done, we also tested the tip of timers/core branch at that time
> > > 8b3843ae3634b vdso/datapage: Quick fix - use asm/page-def.h for ARM64
> > > 
> > > the regression still exists on it:
> > > 
> > > 57e95a5c4117dc6a 7ee988770326fca440472200c3e 8b3843ae3634b472530fb69c386
> > > ---------------- --------------------------- ---------------------------
> > >          %stddev     %change         %stddev     %change         %stddev
> > >              \          |                \          |                \
> > >       4.10            -1.2%       4.05            -1.2%       4.05        netperf.ThroughputBoth_Mbps
> > >       1049            -1.2%       1037            -1.2%       1036        netperf.ThroughputBoth_total_Mbps
> > >       4.10            -1.2%       4.05            -1.2%       4.05        netperf.Throughput_Mbps
> > >       1049            -1.2%       1037            -1.2%       1036        netperf.Throughput_total_Mbps
> > 
> > Oh, I see... :-/
> > 
> > > > Ie: would it be possible to compare instead:
> > > > 
> > > >     57e95a5c4117 (timers: Introduce function to check timer base is_idle flag)
> > > > VS
> > > >     b2cf7507e186 (timers: Always queue timers on the local CPU)
> > > > 
> > > > Because the improvements introduced by 7ee9887703 are mostly relevant after
> > > > b2cf7507e186.
> > > 
> > > got it. will test.
> > > 
> > > at the same time, we noticed current tip of timers/core is
> > > a184d9835a0a6 (tip/timers/core) tick/sched: Fix build failure for
> > > CONFIG_NO_HZ_COMMON=n
> > 
> > Shouldn't be a problem as it fixes an issue introduced after:
> > 
> > 	  b2cf7507e186 (timers: Always queue timers on the local CPU)
> > 
> > > 
> > > though it seems irelevant, we will still get data for it.
> > 
> > Thanks a lot, this will be very helpful. Especially with all the perf diff
> > details like in the initial email report.
> 
> the regression still exists on b2cf7507e186 and current tip of the branch:
> 
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
>   cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf
> 
> commit:
>   57e95a5c4117 (timers: Introduce function to check timer base is_idle flag)
>   b2cf7507e186 (timers: Always queue timers on the local CPU)
>   a184d9835a0a (tick/sched: Fix build failure for CONFIG_NO_HZ_COMMON=n)
>   
>   a184d9835a0a689261ea6a4a8dbc18173a031b77
> 
> 57e95a5c4117dc6a b2cf7507e18649a30512515ec0c a184d9835a0a689261ea6a4a8db
> ---------------- --------------------------- ---------------------------
>          %stddev     %change         %stddev     %change         %stddev
>              \          |                \          |                \
>       4.10            -1.4%       4.04            -1.5%       4.04        netperf.ThroughputBoth_Mbps
>       1049            -1.4%       1034            -1.5%       1033        netperf.ThroughputBoth_total_Mbps
>       4.10            -1.4%       4.04            -1.5%       4.04        netperf.Throughput_Mbps
>       1049            -1.4%       1034            -1.5%       1033        netperf.Throughput_total_Mbps
> 
> details are in below [1]

Thanks a lot!

> 
> > Because I'm having some troubles
> > running those lkp tests. How is it working BTW? I've seen it downloading
> > two kernel trees but I haven't noticed a kernel build.
> 
> you need build 7ee9887703 and its parent kernel with config in
> https://download.01.org/0day-ci/archive/20240301/202403011511.24defbbd-oliver.sang@intel.com
> then boot into kernel.
> 
> after that, you could run netperf in each kernel by following
> https://download.01.org/0day-ci/archive/20240301/202403011511.24defbbd-oliver.sang@intel.com/reproduce
> to get data.
> 
> the results will store in different path according the kernel commit, then you
> could compare the results from both kernels.

Oh I see now.

> 
> what's your OS BTW? we cannot support all distributions so far...

Opensuse, but it failed to find a lot of equivalent packages.
Then I tried Ubuntu 22.04.4 LTS but it failed saying perf didn't have the
"sched" subcommand. Which distro do you recommand using?

> 
> > Are the two compared
> > instances running through kvm?
> 
> we run performance tests on bare mental. for netperf, we just test on one
> machine so the test is really upon local net.

Ok.

Thanks!

