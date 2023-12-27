Return-Path: <linux-kernel+bounces-12167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEA81F0DA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28D90283BB1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA5546457;
	Wed, 27 Dec 2023 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H8dQLyTj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC3E46527
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703697529; x=1735233529;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KNkeJXzrhPg5SrbX1SggyVGkeRW2gxTO0WMQfJzUh/Y=;
  b=H8dQLyTjCCWHbaYIELmTjHBq+rR3yD7o5DijlSk+5jv7v/nfiVMYY5Wh
   J2ousvjCW8q+shd33zBKLWirKTqiYGy9pb94hK1dWeUZLxBPf7JoOcGFB
   MK/PdYTHZW5aRH/ucyUSYvuruLwV2An1Rl9cgWRSdy5e64MRyKpx5ivbF
   YePHXKreju4BEvRXLi9qVMjxpkHYnr6LeFUMl0Lh9Ragtv/bNYwIcoR2y
   +p5OBW6VQSmX2Z17WvS4qkV7z+tg5JMSzsw2e7ZKy4stEuIEhWy3u8UPG
   412UUaYc5pMKuPvVKvbWU1IF8IvuEX+O1nMvzhl+YXIhSRsMNLb3zBi/q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="3769498"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="3769498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2023 09:18:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10936"; a="1025433809"
X-IronPort-AV: E=Sophos;i="6.04,309,1695711600"; 
   d="scan'208";a="1025433809"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 27 Dec 2023 09:18:46 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rIXYK-000Fax-1M;
	Wed, 27 Dec 2023 17:18:44 +0000
Date: Thu, 28 Dec 2023 01:18:37 +0800
From: kernel test robot <lkp@intel.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: kernel/trace/bpf_trace.c:2254:21: sparse: sparse: dereference of
 noderef expression
Message-ID: <202312280124.W09SBhfq-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fbafc3e621c3f4ded43720fdb1d6ce1728ec664e
commit: 0236fec57a15dc2a068dfe4488e0c2ab4559b1ec bpf: Resolve symbols with ftrace_lookup_symbols for kprobe multi link
date:   1 year, 8 months ago
config: i386-randconfig-061-20231101 (https://download.01.org/0day-ci/archive/20231228/202312280124.W09SBhfq-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231228/202312280124.W09SBhfq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312280124.W09SBhfq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/trace/bpf_trace.c:2254:21: sparse: sparse: dereference of noderef expression
   kernel/trace/bpf_trace.c:2258:66: sparse: sparse: dereference of noderef expression

vim +2254 kernel/trace/bpf_trace.c

  2236	
  2237	static int copy_user_syms(struct user_syms *us, unsigned long __user *usyms, u32 cnt)
  2238	{
  2239		unsigned long __user usymbol;
  2240		const char **syms = NULL;
  2241		char *buf = NULL, *p;
  2242		int err = -ENOMEM;
  2243		unsigned int i;
  2244	
  2245		syms = kvmalloc(cnt * sizeof(*syms), GFP_KERNEL);
  2246		if (!syms)
  2247			goto error;
  2248	
  2249		buf = kvmalloc(cnt * KSYM_NAME_LEN, GFP_KERNEL);
  2250		if (!buf)
  2251			goto error;
  2252	
  2253		for (p = buf, i = 0; i < cnt; i++) {
> 2254			if (__get_user(usymbol, usyms + i)) {
  2255				err = -EFAULT;
  2256				goto error;
  2257			}
  2258			err = strncpy_from_user(p, (const char __user *) usymbol, KSYM_NAME_LEN);
  2259			if (err == KSYM_NAME_LEN)
  2260				err = -E2BIG;
  2261			if (err < 0)
  2262				goto error;
  2263			syms[i] = p;
  2264			p += err + 1;
  2265		}
  2266	
  2267		us->syms = syms;
  2268		us->buf = buf;
  2269		return 0;
  2270	
  2271	error:
  2272		if (err) {
  2273			kvfree(syms);
  2274			kvfree(buf);
  2275		}
  2276		return err;
  2277	}
  2278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

