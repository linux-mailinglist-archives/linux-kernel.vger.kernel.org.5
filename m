Return-Path: <linux-kernel+bounces-142691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D84158A2EDF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCCC1F21F61
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA975FBA0;
	Fri, 12 Apr 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VoVb/NS1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23B62818
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712927290; cv=none; b=Lvph8hlBgsJhSd3/cW91lyzzrrNDfbFeuEseR0gvYvW7JjyWdDQQMrtUj8dTtwzQ3MNa1FCSt9sLxFjmFkPosvSGobIGZcoCyOlBZIoud2BsGuwBMN3E2jYj+OFfsjFWxhV/J0LuzZ3rdlVvhHiKQJSx3ABf5U28Gr7BY1lUAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712927290; c=relaxed/simple;
	bh=Q1Db/ZKdhoYZY4z6pe4loFoumzC09sqIMjzSkx6k370=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jayIpPmpMa381G45d/Hk4S/d/OJfgUr0D26KRit94DSoN2DhhMla2USoGpnkzY70aJ2/ibCDjaOss/y6mag0fEpNVkKkce5SJr+1xpwaFHtC9AqgY+eKTXfNKsRRPx0dmApQZNOPdDwH8BOAereLW3x+bnRulLdUKJx9aVWxZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VoVb/NS1; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712927287; x=1744463287;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q1Db/ZKdhoYZY4z6pe4loFoumzC09sqIMjzSkx6k370=;
  b=VoVb/NS1mseqbLFZczbgW/RuAgPsa+uBdSoRjm0JVrupz0oeiW3qFSMq
   AlwLbPzF9DCs4SpzKPhrDBD+MBaW/rq6zx/cVRrY+dK7OMoOfWgIfrgGy
   FDhkFqxKYF3bCpxs3C6SUxag9zPahtc6i2gL2N79l5KCKgGAMrR/QVApz
   MjFwNiCvfPNhlrPxmOZ8QTu0sM2VhPfL6kMWxNyVrr05OrVtd6ZMhINN7
   6KSfDHA+iipgICCmTa3LenN3UNmmeC/zG3V6xERveUHdRDGmjI/hWncEx
   q+HLn3QcqtG7jx8uHDSw8v6zHFx/amlpRsDFF0yckPrXYrnmWVQk6oJ49
   w==;
X-CSE-ConnectionGUID: QwTLxichSIi3CeFvDvI8zA==
X-CSE-MsgGUID: peYNsKP7RP27nmdGofz6jw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8239295"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8239295"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 06:08:06 -0700
X-CSE-ConnectionGUID: N6EQa6+ZS5ePyGkc5Q8A1g==
X-CSE-MsgGUID: jdRJ4EDWT0ydliAjldhpZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="25882120"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 12 Apr 2024 06:08:05 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rvGdP-0009mP-00;
	Fri, 12 Apr 2024 13:08:03 +0000
Date: Fri, 12 Apr 2024 21:07:20 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Huey <me@kylehuey.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	x86@kernel.org, Ingo Molnar <mingo@kernel.org>
Subject: [tip:perf/core 10/17] kernel/events/core.c:9634:13: warning:
 'perf_event_free_bpf_handler' defined but not used
Message-ID: <202404122021.kE3qOoZo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   93d3fde7fd19c2e2cde7220e7986f9a75e9c5680
commit: 4c03fe11b96bda60610aca77002e83f37b4a2242 [10/17] perf/bpf: Reorder bpf_overflow_handler() ahead of __perf_event_overflow()
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20240412/202404122021.kE3qOoZo-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404122021.kE3qOoZo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404122021.kE3qOoZo-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/events/core.c:9634:13: warning: 'perf_event_free_bpf_handler' defined but not used [-Wunused-function]
    9634 | static void perf_event_free_bpf_handler(struct perf_event *event)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> kernel/events/core.c:9596:12: warning: 'perf_event_set_bpf_handler' defined but not used [-Wunused-function]
    9596 | static int perf_event_set_bpf_handler(struct perf_event *event,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/perf_event_free_bpf_handler +9634 kernel/events/core.c

  9595	
> 9596	static int perf_event_set_bpf_handler(struct perf_event *event,
  9597					      struct bpf_prog *prog,
  9598					      u64 bpf_cookie)
  9599	{
  9600		if (event->overflow_handler_context)
  9601			/* hw breakpoint or kernel counter */
  9602			return -EINVAL;
  9603	
  9604		if (event->prog)
  9605			return -EEXIST;
  9606	
  9607		if (prog->type != BPF_PROG_TYPE_PERF_EVENT)
  9608			return -EINVAL;
  9609	
  9610		if (event->attr.precise_ip &&
  9611		    prog->call_get_stack &&
  9612		    (!(event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) ||
  9613		     event->attr.exclude_callchain_kernel ||
  9614		     event->attr.exclude_callchain_user)) {
  9615			/*
  9616			 * On perf_event with precise_ip, calling bpf_get_stack()
  9617			 * may trigger unwinder warnings and occasional crashes.
  9618			 * bpf_get_[stack|stackid] works around this issue by using
  9619			 * callchain attached to perf_sample_data. If the
  9620			 * perf_event does not full (kernel and user) callchain
  9621			 * attached to perf_sample_data, do not allow attaching BPF
  9622			 * program that calls bpf_get_[stack|stackid].
  9623			 */
  9624			return -EPROTO;
  9625		}
  9626	
  9627		event->prog = prog;
  9628		event->bpf_cookie = bpf_cookie;
  9629		event->orig_overflow_handler = READ_ONCE(event->overflow_handler);
  9630		WRITE_ONCE(event->overflow_handler, bpf_overflow_handler);
  9631		return 0;
  9632	}
  9633	
> 9634	static void perf_event_free_bpf_handler(struct perf_event *event)
  9635	{
  9636		struct bpf_prog *prog = event->prog;
  9637	
  9638		if (!prog)
  9639			return;
  9640	
  9641		WRITE_ONCE(event->overflow_handler, event->orig_overflow_handler);
  9642		event->prog = NULL;
  9643		bpf_prog_put(prog);
  9644	}
  9645	#else
  9646	static int perf_event_set_bpf_handler(struct perf_event *event,
  9647					      struct bpf_prog *prog,
  9648					      u64 bpf_cookie)
  9649	{
  9650		return -EOPNOTSUPP;
  9651	}
  9652	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

