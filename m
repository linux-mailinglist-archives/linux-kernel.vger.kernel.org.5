Return-Path: <linux-kernel+bounces-100948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3183C879FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98A9283562
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D359648CE0;
	Tue, 12 Mar 2024 23:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJkiRD26"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0444AEC7;
	Tue, 12 Mar 2024 23:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287854; cv=none; b=QAamE9+Y9rkWFF1eRw7nlLbjAIfFnZLOzsFjw+ohszjcFOatfeKulGrEW6ABWLuqjXn74x6nL6yTec4VYJPAAnia72DL9W32B1RdX6wYhvsxUvH8HDd7ELNeC/db+yR8/3zPjelcXufkfC92IDJC/HXFBt0B2kkdj41mBvxVXmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287854; c=relaxed/simple;
	bh=lQTDOKFnPSdYos3/V0QvsaFSFKIFteWUstF7Ceh6imI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3rBobs2nST3aU97r+aGuiOx3dA3dK3mEGXpXYT8+EMdmq8FG9OwbX1b/ReOBfix5skwm5qwsHh4hvXL1dOJ8r8wM2C3btnKTUgo38suybHXLNMuxSIjJbE/98qZU7TOexrVUqz0bVy3iIzm33xuGQZMZ2bqcqkXXWAifLHmQdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJkiRD26; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C3EC433C7;
	Tue, 12 Mar 2024 23:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710287853;
	bh=lQTDOKFnPSdYos3/V0QvsaFSFKIFteWUstF7Ceh6imI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MJkiRD268/gQO8vSDTK/fASbFQBoYN+FxT3yzDd90uAUcpUYVbg/XVh6BK2ssVVD1
	 vNYWd8fDKJcTlyGTSGvVT1AtwCpmlcbQeDVB4zP+gYokKLrHCHibvxKNoTgTAdk6r3
	 J4xyXD8uCxfsqUCUaD5ITd81h+xM4y6BaeTqNZd1HFktWdpqyzgzdXGmhKCC7ahuLu
	 6IVN/M8ECUqMxPVbqFHNX3KXPTO1LUGq7sOn8p6UFMW2mD6o5al7oWZF89WBTXcrB/
	 iU5UtI/5c9+eZSCkzUbnTJRvdfUt5N69ng9PIBbyAf9DP4JC+hLkn4AvCDTa6OTbDy
	 jnYyM4m+brocA==
Date: Wed, 13 Mar 2024 00:57:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <ZfDr6qOaMVnyoB8W@pavilion.home>
References: <202403011511.24defbbd-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202403011511.24defbbd-oliver.sang@intel.com>

Le Fri, Mar 01, 2024 at 04:09:24PM +0800, kernel test robot a écrit :
> 
> 
> Hello,
> 
> kernel test robot noticed a -1.2% regression of netperf.Throughput_Mbps on:
> 
> 
> commit: 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the hierarchical pull model")
> https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git timers/core
> 
> testcase: netperf
> test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
> parameters:
> 
> 	ip: ipv4
> 	runtime: 300s
> 	nr_threads: 200%
> 	cluster: cs-localhost
> 	test: SCTP_STREAM
> 	cpufreq_governor: performance
> 
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202403011511.24defbbd-oliver.sang@intel.com
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20240301/202403011511.24defbbd-oliver.sang@intel.com
> 
> =========================================================================================
> cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
>   cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-8.3/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/SCTP_STREAM/netperf
> 
> commit: 
>   57e95a5c41 ("timers: Introduce function to check timer base is_idle flag")
>   7ee9887703 ("timers: Implement the hierarchical pull model")

So I can reproduce. And after hours staring at traces I haven't really found
the real cause of this. 1% difference is not always easy to track down.
But here are some sort of conclusion so far:

_ There is an increase of ksoftirqd use (+13%) but if I boot with threadirqs
  before and after the patch (which means that ksoftirqd is used all the time
  for softirq handling) I still see the performance regression. So this
  shouldn't play a role here.

_ I suspected that timer migrators handling big queues of timers on behalf of
  idle CPUs would delay NET_RX softirqs but it doesn't seem to be the case. I
  don't see TIMER vector delaying NET_RX vector after the hierarchical pull
  model, quite the opposite actually, they are less delayed overall.

_ I suspected that timer migrators handling big queues would add scheduling
  latency. But it doesn't seem to be the case. Quite the opposite again,
  surprisingly.

_ I have observed that, in average, timers execute later with the hierarchical
  pull model. The following delta:
       time of callback execution - bucket_expiry
  is 3 times higher with the hierarchical pull model. Whether that plays a role
  is unclear. It might still be interesting to investigate.

_ The initial perf profile seem to suggest a big increase of task migration. Is
  it the result of ping-pong wakeup? Does that play a role?

Thanks.

