Return-Path: <linux-kernel+bounces-47218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC0C844A9D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B997A28BFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C785439AFA;
	Wed, 31 Jan 2024 21:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hrAfohi4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED4F39AC3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738343; cv=none; b=caZ3GU+ijS81JEKdAiT+M5XdJmQh2udAU+3y22ZqL6FTPka0vyx0XB38+y0LRCWYHjkNFONKhZ4wWDmZFD7lqYkgcMuuZ0WN0yMxCuMPU3RYoqWDk8zV/jFDb3aZB+k+6ydrExxFSwyI8saCOQ6Vbopdnjc4vuJNKUUHvDJeeWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738343; c=relaxed/simple;
	bh=bXOTyyHuGYiBb33uLigukbTHh4dila4CSe3JVRtU8/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnwK0LmTuvHr+22kdGzlSEeAIsAuNgGUkFtOqmxKzutvJhM/wzE8/eTGZr0Db+HQ0rsdU1ZvSSdOc6spMPlCtslCp4rfN6PqFJAXj2ylvtM06oFdCLfrVbMDryrJlU0rcpDtMbo1tza6Pgzdgf7rdrC+2bT1VMQW0gn5dFQc3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hrAfohi4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706738341; x=1738274341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bXOTyyHuGYiBb33uLigukbTHh4dila4CSe3JVRtU8/4=;
  b=hrAfohi4HNqcrVgI3P9iZ98Hf+pTrN2h2FaADep6Kxp7kUzzGXK6dbP9
   7Wp77mVFrdoNaXHQu60Jp32T5MFcIZhE4JMwj/d/S/fIug6AN5nMmi/pt
   xMgCEtSA6ny0p7U4ydk75+4mlAy/uyD7dDckVmmayjj7NgpPKPbGDYVJ4
   1Nbs0TTwaSXA38NGAeVDFfZ4B09BwnTgRdr7crjHcjvBJYb5+Ou9pSQv4
   lxYsn5a8w1a6Cv9D3WpHrI9J3WKSZrqDjviGcAri2vch3+cJp0NykLC94
   NO5jXddMGx2hjjPyeV5XJm1Yzb3eQiEWa9MJb4A5U6bR8JidzWz7WzFig
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10391417"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10391417"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:58:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="878913084"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="878913084"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 13:58:56 -0800
Date: Wed, 31 Jan 2024 14:00:18 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: alexs@kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org, sshegde@linux.ibm.com
Subject: Re: [PATCH v2 1/6] sched/fair: add SD_CLUSTER in comments
Message-ID: <20240131220018.GA18560@ranerica-svr.sc.intel.com>
References: <20240130131708.429425-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130131708.429425-1-alexs@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Tue, Jan 30, 2024 at 09:17:03PM +0800, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
> 
> The SD_CLUSTER omitted in following TOPOLOGY_SD_FLAGS explaination, add
> it to fill the absent.

Perhaps saying: "The description of SD_CLUSTER is missing. Add it." is
sufficient.

> 
> Signed-off-by: Alex Shi <alexs@kernel.org>
> To: linux-kernel@vger.kernel.org
> To: Daniel Bristot de Oliveira <bristot@redhat.com>
> To: Ben Segall <bsegall@google.com>
> To: Steven Rostedt <rostedt@goodmis.org>
> To: Dietmar Eggemann <dietmar.eggemann@arm.com>
> To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> To: Valentin Schneider <vschneid@redhat.com>
> To: Vincent Guittot <vincent.guittot@linaro.org>
> To: Juri Lelli <juri.lelli@redhat.com>
> To: Peter Zijlstra <peterz@infradead.org>
> To: Ingo Molnar <mingo@redhat.com>
> ---
>  kernel/sched/topology.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 10d1391e7416..c342c52b1f34 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1554,6 +1554,7 @@ static struct cpumask		***sched_domains_numa_masks;
>   * function:
>   *
>   *   SD_SHARE_CPUCAPACITY   - describes SMT topologies
> + *   SD_CLUSTER		    - describes Cluster topologies

This description does not really add much. Perhaps syaing "describes
CPU cluster topologies". Then users can go to the definiton of
SD_CLUSTER.

