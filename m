Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572217E0D27
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 03:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjKDBfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 21:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKDBfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 21:35:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE569D42
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 18:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699061737; x=1730597737;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HzK5cUwm2AZrpuUQKMkbn3Lu1JwcyBXBCtaNIzvAp+c=;
  b=ClSYpd4l5TDnBrAXn1Z/pT3zS1Q5PD/ODja473fAF1/1cJzlqGoHL9Xj
   EfeABtlJrncwTzwjmW34wHHgNq5dP12dT3h5VDiVQjM8fHACKOUCEha8f
   ocay0mAkxJJP7m9F0Fwq0w+uacyAaurH0w505KuLn6bgy9uJbcRZ6ByZD
   vAYEs/OX758m9eEa1whJNRyJRlpITHQwW7xcyLlpRA4DcTi7EBpMvbtMs
   MHFwb2rbnARRyv/IyjTDE/9+gXMKX0bVn7/TiIgoBZy5a9SIhI+6YRbO9
   TckfX80XT/XQzLjT1PchAM2H0NAH8e1vHRdp9UKrFGjJuzqM31sHmSm6h
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1932581"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1932581"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 18:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="1093243901"
X-IronPort-AV: E=Sophos;i="6.03,275,1694761200"; 
   d="scan'208";a="1093243901"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Nov 2023 18:35:36 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qz5ZV-0003Bz-39;
        Sat, 04 Nov 2023 01:35:33 +0000
Date:   Sat, 4 Nov 2023 09:34:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Hill <daniel@gluo.nz>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kent Overstreet <kmo@daterainc.com>
Subject: fs/bcachefs/mean_and_variance.c:67: warning: Function parameter or
 member 's' not described in 'mean_and_variance_get_mean'
Message-ID: <202311040908.NtUddtR8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e392ea4d4d00880bf94550151b1ace4f88a4b17a
commit: 92095781e0f607e735971c1a6462ca6dad8826d2 bcachefs: Mean and variance
date:   12 days ago
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20231104/202311040908.NtUddtR8-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231104/202311040908.NtUddtR8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311040908.NtUddtR8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/bcachefs/mean_and_variance.c:67: warning: Function parameter or member 's' not described in 'mean_and_variance_get_mean'
   fs/bcachefs/mean_and_variance.c:78: warning: Function parameter or member 's1' not described in 'mean_and_variance_get_variance'
   fs/bcachefs/mean_and_variance.c:94: warning: Function parameter or member 's' not described in 'mean_and_variance_get_stddev'
   fs/bcachefs/mean_and_variance.c:108: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_update'
>> fs/bcachefs/mean_and_variance.c:108: warning: Function parameter or member 'x' not described in 'mean_and_variance_weighted_update'
>> fs/bcachefs/mean_and_variance.c:108: warning: Excess function parameter 's1' description in 'mean_and_variance_weighted_update'
>> fs/bcachefs/mean_and_variance.c:108: warning: Excess function parameter 's2' description in 'mean_and_variance_weighted_update'
>> fs/bcachefs/mean_and_variance.c:134: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_mean'
>> fs/bcachefs/mean_and_variance.c:143: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_variance'
>> fs/bcachefs/mean_and_variance.c:153: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_stddev'


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
    78	{
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
    94	{
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
