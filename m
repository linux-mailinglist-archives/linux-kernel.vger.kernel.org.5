Return-Path: <linux-kernel+bounces-89949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 641E186F7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 01:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299AC1C2094F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5622AA41;
	Mon,  4 Mar 2024 00:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7fsotAN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C89E385;
	Mon,  4 Mar 2024 00:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709512368; cv=none; b=ATBqcP7czQEiC5QapQqZIx5QwLw4iwBCUQwe4kOQjZRkM6tdXfcK6lk88v87ECA43L+dDA+iDHSVjAb/MmPVeCwMIOttTZbU8VR4PL1nO9H0HdHVec8wrCCLizLFkSZEp5lvnCqyHE7eWYXZae55+evxj2fNVipLq8b8PZDPTCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709512368; c=relaxed/simple;
	bh=UgCWly0UHLVcIo6ZXg1u/0Hm0vg0qVNbXLhu2wTP8mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nhdslTlgB1zMfsk+XVAefg77TjDPiHqOClZs2xNerOfCVuluEliXhmPFT/9pwgfo9CXOs+CaKaFsZ4Lpf+oKVqJAivOmeIBGxexWs7/YfoobfeKtuhGCcFPztQlJvlJW7o+rkcLwLx2aG1cR2KpKFYWskyI20XCCePTTfqk7kWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7fsotAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D431AC433C7;
	Mon,  4 Mar 2024 00:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709512368;
	bh=UgCWly0UHLVcIo6ZXg1u/0Hm0vg0qVNbXLhu2wTP8mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7fsotANAhkLwGycPo7xK06l+On1+9VnehWeiSvXLBJdvCl+6iL3zM6oqLVI6XQjl
	 KwYAOA6G8Ec4sMdpv1Qz/PX/NldbaiwGbFoqtItH6zqZRY82UIZYgRmym8G9Du2y5Z
	 5qmlE9jnEvkhvK364HvpH91ziIPMeTDBaiGhTsRKcR5AGo9HnySra1Jewjjr6Dhs2q
	 7WNoIR045G/e7O63AwivPon6uZel6M08h0ukJecobQc88VmaTCE01dkiTwdd6t4jGm
	 1aF2ZX6Ur/H32k1JCh+w9J1Fgi1u3zcPnL0XS3YGz2AvL/T5F5XkNWpK3ZZca7ALrO
	 Enr2aUNb6loow==
Date: Mon, 4 Mar 2024 01:32:45 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>, ying.huang@intel.com,
	feng.tang@intel.com, fengwei.yin@intel.com
Subject: Re: [tip:timers/core] [timers]  7ee9887703:  netperf.Throughput_Mbps
 -1.2% regression
Message-ID: <ZeUWreWcp4UWQ081@pavilion.home>
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

Is this something that is observed also with the commits that follow in this
branch?

Ie: would it be possible to compare instead:

    57e95a5c4117 (timers: Introduce function to check timer base is_idle flag)
VS
    b2cf7507e186 (timers: Always queue timers on the local CPU)

Because the improvements introduced by 7ee9887703 are mostly relevant after
b2cf7507e186.

Thanks.

