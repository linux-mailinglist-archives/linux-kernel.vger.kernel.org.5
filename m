Return-Path: <linux-kernel+bounces-2985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C4816592
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 05:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C11F22801
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 04:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6C9569F;
	Mon, 18 Dec 2023 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ub+IdUV/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F0F5671
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 04:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702872653; x=1734408653;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Tmnb2JQEF4jHnYCeJg/zUcmFTsCzvUpFIPHBRrPtzsE=;
  b=Ub+IdUV/auHyZlUGo2hFCW/s6YxT7b1Cw6MzkdDPCdf5dgF5s/XiIBva
   +pwSMHrBewe1QJ+kdvAGKKXipjEUdiep+4ssDw5tqU0h6weMBQVKvuygh
   BoO7QFJJHftKyJqjl4Y1Fresw/5/Q0918eOpB47qh7y0RY1AyaoJ8rEoD
   9XFuskSBnrrfhkvgj+T3WAOf0T+4R940mi25eZJ6/L4jXrmh5oz/HB23w
   HQU6wRkAnOzFLPUwnMKONehgUwfBrYxlgJWBAICwwPxjfyg1LZgZe9MhW
   Mq8aWPU+FPW5mlD/Q/2tiauNuPE58pbLqct3lXZO/tz/iXF9Rfvwp/cVY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2289481"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2289481"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 20:10:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="841339030"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="841339030"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Dec 2023 20:10:50 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rF4xs-0003kL-0w;
	Mon, 18 Dec 2023 04:10:48 +0000
Date: Mon, 18 Dec 2023 12:10:10 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Hill <daniel@gluo.nz>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Kent Overstreet <kmo@daterainc.com>
Subject: fs/bcachefs/mean_and_variance.c:67: warning: Function parameter or
 struct member 's' not described in 'mean_and_variance_get_mean'
Message-ID: <202312181258.ae2vsFwE-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ceb6a6f023fd3e8b07761ed900352ef574010bcb
commit: 92095781e0f607e735971c1a6462ca6dad8826d2 bcachefs: Mean and variance
date:   8 weeks ago
config: i386-buildonly-randconfig-002-20231218 (https://download.01.org/0day-ci/archive/20231218/202312181258.ae2vsFwE-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231218/202312181258.ae2vsFwE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312181258.ae2vsFwE-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/bcachefs/mean_and_variance.c:67: warning: Function parameter or struct member 's' not described in 'mean_and_variance_get_mean'
>> fs/bcachefs/mean_and_variance.c:78: warning: Function parameter or struct member 's1' not described in 'mean_and_variance_get_variance'
>> fs/bcachefs/mean_and_variance.c:94: warning: Function parameter or struct member 's' not described in 'mean_and_variance_get_stddev'
>> fs/bcachefs/mean_and_variance.c:108: warning: Function parameter or struct member 's' not described in 'mean_and_variance_weighted_update'
>> fs/bcachefs/mean_and_variance.c:108: warning: Function parameter or struct member 'x' not described in 'mean_and_variance_weighted_update'
   fs/bcachefs/mean_and_variance.c:108: warning: Excess function parameter 's1' description in 'mean_and_variance_weighted_update'
   fs/bcachefs/mean_and_variance.c:108: warning: Excess function parameter 's2' description in 'mean_and_variance_weighted_update'
>> fs/bcachefs/mean_and_variance.c:134: warning: Function parameter or struct member 's' not described in 'mean_and_variance_weighted_get_mean'
>> fs/bcachefs/mean_and_variance.c:143: warning: Function parameter or struct member 's' not described in 'mean_and_variance_weighted_get_variance'
>> fs/bcachefs/mean_and_variance.c:153: warning: Function parameter or struct member 's' not described in 'mean_and_variance_weighted_get_stddev'


vim +67 fs/bcachefs/mean_and_variance.c

    62	
    63	/**
    64	 * mean_and_variance_get_mean() - get mean from @s
    65	 */
    66	s64 mean_and_variance_get_mean(struct mean_and_variance s)
  > 67	{
    68		return s.n ? div64_u64(s.sum, s.n) : 0;
    69	}
    70	EXPORT_SYMBOL_GPL(mean_and_variance_get_mean);
    71	
    72	/**
    73	 * mean_and_variance_get_variance() -  get variance from @s1
    74	 *
    75	 * see linked pdf equation 12.
    76	 */
    77	u64 mean_and_variance_get_variance(struct mean_and_variance s1)
  > 78	{
    79		if (s1.n) {
    80			u128_u s2 = u128_div(s1.sum_squares, s1.n);
    81			u64  s3 = abs(mean_and_variance_get_mean(s1));
    82	
    83			return u128_lo(u128_sub(s2, u128_square(s3)));
    84		} else {
    85			return 0;
    86		}
    87	}
    88	EXPORT_SYMBOL_GPL(mean_and_variance_get_variance);
    89	
    90	/**
    91	 * mean_and_variance_get_stddev() - get standard deviation from @s
    92	 */
    93	u32 mean_and_variance_get_stddev(struct mean_and_variance s)
  > 94	{
    95		return int_sqrt64(mean_and_variance_get_variance(s));
    96	}
    97	EXPORT_SYMBOL_GPL(mean_and_variance_get_stddev);
    98	
    99	/**
   100	 * mean_and_variance_weighted_update() - exponentially weighted variant of mean_and_variance_update()
   101	 * @s1: ..
   102	 * @s2: ..
   103	 *
   104	 * see linked pdf: function derived from equations 140-143 where alpha = 2^w.
   105	 * values are stored bitshifted for performance and added precision.
   106	 */
   107	void mean_and_variance_weighted_update(struct mean_and_variance_weighted *s, s64 x)
 > 108	{
   109		// previous weighted variance.
   110		u8 w		= s->weight;
   111		u64 var_w0	= s->variance;
   112		// new value weighted.
   113		s64 x_w		= x << w;
   114		s64 diff_w	= x_w - s->mean;
   115		s64 diff	= fast_divpow2(diff_w, w);
   116		// new mean weighted.
   117		s64 u_w1	= s->mean + diff;
   118	
   119		if (!s->init) {
   120			s->mean = x_w;
   121			s->variance = 0;
   122		} else {
   123			s->mean = u_w1;
   124			s->variance = ((var_w0 << w) - var_w0 + ((diff_w * (x_w - u_w1)) >> w)) >> w;
   125		}
   126		s->init = true;
   127	}
   128	EXPORT_SYMBOL_GPL(mean_and_variance_weighted_update);
   129	
   130	/**
   131	 * mean_and_variance_weighted_get_mean() - get mean from @s
   132	 */
   133	s64 mean_and_variance_weighted_get_mean(struct mean_and_variance_weighted s)
 > 134	{
   135		return fast_divpow2(s.mean, s.weight);
   136	}
   137	EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_mean);
   138	
   139	/**
   140	 * mean_and_variance_weighted_get_variance() -- get variance from @s
   141	 */
   142	u64 mean_and_variance_weighted_get_variance(struct mean_and_variance_weighted s)
 > 143	{
   144		// always positive don't need fast divpow2
   145		return s.variance >> s.weight;
   146	}
   147	EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_variance);
   148	
   149	/**
   150	 * mean_and_variance_weighted_get_stddev() - get standard deviation from @s
   151	 */
   152	u32 mean_and_variance_weighted_get_stddev(struct mean_and_variance_weighted s)
 > 153	{
   154		return int_sqrt64(mean_and_variance_weighted_get_variance(s));
   155	}
   156	EXPORT_SYMBOL_GPL(mean_and_variance_weighted_get_stddev);
   157	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

