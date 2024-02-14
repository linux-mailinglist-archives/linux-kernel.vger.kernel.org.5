Return-Path: <linux-kernel+bounces-65036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A3D8546FE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108A81C26E23
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F901756F;
	Wed, 14 Feb 2024 10:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTKX1q4I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F7171C4;
	Wed, 14 Feb 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707906033; cv=none; b=NDCgNvmkHPk78hINUPrua7ZKo2XhUolNjtJeUCLjYTXbG4ynUuo32XfZBnJi5l+GMUrMFGyv+2EWwB6OLypghz3tjGKZvnIR2Cg3kcfcGkJOptUR95EWt3IP7ncitHfwzIbdmH/BdPsYSGQYRRh9WOzzspyMra8icQt6TbMKZJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707906033; c=relaxed/simple;
	bh=TFMAB7MBiveFe80EybzquU5dGfWXkZIHqR0E257ofTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKcNd28uh/s1DjuryHZwOxn4/QimyogZ0ZlzN5/pFItAZWNlSFezO2RzNM9SZMcmCf+Ng6ILgmyTNAmIopjKpMpKCKzOaXY4MezSkel7Yvn/NqCrkihLoq/6t5DD4KFSpceToT/njn2JWSwoAK92Fn4OmiQfzaXxTb2tSPcjqRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTKX1q4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D17C433F1;
	Wed, 14 Feb 2024 10:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707906033;
	bh=TFMAB7MBiveFe80EybzquU5dGfWXkZIHqR0E257ofTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mTKX1q4I5bi0WSO9h8gbLDerXtf4yXy/VdjYhl0jtgwsO9d/b0pTXbbog7IrofMiZ
	 nzdQdvqY88/hYYt/DT2kKTvpzvygypjRvyqG/0oaTYBAW/ztWYK9Qi/baV3rWaudsR
	 QjiewJWSoWBUEXN4Otgvd1eEEijPhwChdIXyGUh3ZBex8V5k60jnfC2lTABOWPomu5
	 pZtg158SF8YcfPciI/PEn5pQPIFnsH/KQ/LYQCdQz8LG7PfeV8QKzuFpFfhULTSzli
	 KAZ6i8gE1yNAJBceipCVjOmkaT/Aa3XXJcbf80H1jhNVEkLLUylfbwDLkHn346YWD+
	 QtyAXBmmTeXAQ==
Date: Wed, 14 Feb 2024 11:20:30 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Costa Shulyupin <costa.shul@redhat.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>
Subject: Re: [tip:timers/core 3/3] kernel/time/hrtimer.c:2224:49: error:
 implicit declaration of function 'housekeeping' is invalid in C99
Message-ID: <ZcyT7tH35g6xOsSO@lothringen>
References: <202402141742.oYY6J3lC-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202402141742.oYY6J3lC-lkp@intel.com>

On Wed, Feb 14, 2024 at 05:33:56PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
> head:   86342554e102b0d18d50abec43d40f4fc92f1993
> commit: 86342554e102b0d18d50abec43d40f4fc92f1993 [3/3] hrtimer: Select housekeeping CPU during migration
> config: arm-defconfig (https://download.01.org/0day-ci/archive/20240214/202402141742.oYY6J3lC-lkp@intel.com/config)
> compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240214/202402141742.oYY6J3lC-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202402141742.oYY6J3lC-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>    kernel/time/hrtimer.c:1651:7: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
>            bool expires_in_hardirq;
>                 ^
> >> kernel/time/hrtimer.c:2224:49: error: implicit declaration of function 'housekeeping' is invalid in C99 [-Werror,-Wimplicit-function-declaration]
>            int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
>                                                           ^
> >> kernel/time/hrtimer.c:2224:62: error: use of undeclared identifier 'HK_TYPE_TIMER'
>            int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));
>                                                                        ^
>    1 warning and 2 errors generated.
> 
> 
> vim +/housekeeping +2224 kernel/time/hrtimer.c
> 
>   2221	
>   2222	int hrtimers_cpu_dying(unsigned int dying_cpu)
>   2223	{
> > 2224		int i, ncpu = cpumask_any_and(cpu_active_mask, housekeeping(HK_TYPE_TIMER));

Should be housekeeping_cpumask(HK_TYPE_TIMER)

Thanks.

