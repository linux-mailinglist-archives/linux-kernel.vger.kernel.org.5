Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC47DF90E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 18:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbjKBRp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjKBRpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 13:45:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4B2131
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 10:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698947119; x=1730483119;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Wk2nnSn0q59gZtHWbfcB9lciLj1M2d/5AYrCpnnTZsE=;
  b=WYWkwKdgmjs7KqTlk0NG+5259TEE+5ackYNEkhrr/UQo7M+989fsNzAS
   kUfMWTKx9SZOnGGPUtIphhOefLYYm49cp0amwOSqeGQM1YFqmidijZcw9
   I9GXykHteOF2I3RC3Sw1yOlf8mvBP/IRmYSrANhGSMiCpA9DJCp7CbI0F
   RQEMjthjIOVCvVhbpb+/65jW/Lfq9kTiuTcmPRvZ8J1++hkZeBFPYcQOg
   wjA6IoWLFYOREVXtiS4ty1+YsJAYsyiC115OBHrEFKqAsu/ei4C2K4fLt
   P13W3D3AMqwfTybBLuMk07IIgDPcdgt49uAK3wggME5qwx2kaPM33pUio
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="419879820"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="419879820"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 10:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10882"; a="737833363"
X-IronPort-AV: E=Sophos;i="6.03,272,1694761200"; 
   d="scan'208";a="737833363"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Nov 2023 10:45:16 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qybko-0001jO-1c;
        Thu, 02 Nov 2023 17:45:14 +0000
Date:   Fri, 3 Nov 2023 01:44:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Hill <daniel@gluo.nz>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Kent Overstreet <kmo@daterainc.com>
Subject: fs/bcachefs/mean_and_variance.c:78: warning: Function parameter or
 member 's1' not described in 'mean_and_variance_get_variance'
Message-ID: <202311030119.b4CdX9Kv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   21e80f3841c01aeaf32d7aee7bbc87b3db1aa0c6
commit: 92095781e0f607e735971c1a6462ca6dad8826d2 bcachefs: Mean and variance
date:   11 days ago
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20231103/202311030119.b4CdX9Kv-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231103/202311030119.b4CdX9Kv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311030119.b4CdX9Kv-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/bcachefs/mean_and_variance.c:67: warning: Function parameter or member 's' not described in 'mean_and_variance_get_mean'
>> fs/bcachefs/mean_and_variance.c:78: warning: Function parameter or member 's1' not described in 'mean_and_variance_get_variance'
>> fs/bcachefs/mean_and_variance.c:94: warning: Function parameter or member 's' not described in 'mean_and_variance_get_stddev'
>> fs/bcachefs/mean_and_variance.c:108: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_update'
   fs/bcachefs/mean_and_variance.c:108: warning: Function parameter or member 'x' not described in 'mean_and_variance_weighted_update'
   fs/bcachefs/mean_and_variance.c:108: warning: Excess function parameter 's1' description in 'mean_and_variance_weighted_update'
   fs/bcachefs/mean_and_variance.c:108: warning: Excess function parameter 's2' description in 'mean_and_variance_weighted_update'
   fs/bcachefs/mean_and_variance.c:134: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_mean'
   fs/bcachefs/mean_and_variance.c:143: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_variance'
   fs/bcachefs/mean_and_variance.c:153: warning: Function parameter or member 's' not described in 'mean_and_variance_weighted_get_stddev'


vim +78 fs/bcachefs/mean_and_variance.c

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

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
