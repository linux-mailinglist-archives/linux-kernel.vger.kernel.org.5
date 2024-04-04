Return-Path: <linux-kernel+bounces-132028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F1F898EF0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA7EFB23A71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A15130ACD;
	Thu,  4 Apr 2024 19:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C02KKjjV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1937782C63
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712258590; cv=none; b=YWwgzm2jReV9bbrRyz9FyMnc4XJed69NlQnY2LGCjk7jFeiVrt3et7CqtCYjdXJ18RSdlTfgxGJJcBpMtQY5u5aIHSyEQHtAOVCzL3zPfQbBmKGg6SvtULJk4e8mqvRrzGSNOjuzZtWpl4kzZUctU1qEIJw48o11eR7+hPw88SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712258590; c=relaxed/simple;
	bh=4pCs/zhjShv2a5Q0pU8cT+ddGAaMvFpOrp3OvBrl7rY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d1WlgDLA1ewd+4B8E9/667f0bNv7yhpZ6VkAE3Tv56kWbwZdbo06mFKfKmo1ZSIZ7pwo2swhOCAzL5XnPNNAHSyQWZfYCViNEHTPjAbP0yPfu5OPMm3d5BKMrrFnjeLAdYdMtFsyiEWcnXEg59P7BRY1CImhB/mqYciEMijF+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C02KKjjV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712258588; x=1743794588;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4pCs/zhjShv2a5Q0pU8cT+ddGAaMvFpOrp3OvBrl7rY=;
  b=C02KKjjVnys7qlyXC3BF8KvLFOFH/LSSLH99nNYcNsbgUVpqw3EhgB1u
   uZYhmS+/VqZmwdLRI9bAXm7TlZVf82G5pPJF9EX3wF39E4JEz6SAPVb1q
   O3f/IKuDobe6BQn0mwYR/aIi3fvHnggOIJaYhz2IMkTR6VvmPTVVIP7Yb
   PQ2ylUeIGCwlZyDdLQlOmmnTHgWGVmNhVZAAtSB4UBfsfw6sg/RzxqTHU
   KYoy2BPsfitb0L9EZ3i6PFfSOPZb5FsBDzfvN7GF2XJS7mKTFycNWup3j
   F9dQ6FeGeQDNnyDHFe9u+UMadGJmI1SVYIEk/ulqRWz/GlGOu0w5mNzcZ
   Q==;
X-CSE-ConnectionGUID: gqQKVzEhSAWHfiP0ATOePA==
X-CSE-MsgGUID: 2RPE3UDNTPC/YbVeh0XNeg==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="18710586"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="18710586"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 12:23:08 -0700
X-CSE-ConnectionGUID: pfT+Jks7TiyfsQwkHgEtPQ==
X-CSE-MsgGUID: hlgYl14kRwS0+Y0YoPsQ8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="42059166"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Apr 2024 12:23:06 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsSfv-0001Pa-2t;
	Thu, 04 Apr 2024 19:23:03 +0000
Date: Fri, 5 Apr 2024 03:22:06 +0800
From: kernel test robot <lkp@intel.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Matthew Sakai <msakai@redhat.com>
Subject: drivers/md/dm-vdo/murmurhash3.c:157:3-4: Unneeded semicolon
Message-ID: <202404050327.4ebVLBD3-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c85af715cac0a951eea97393378e84bb49384734
commit: f36b1d3ba533d21b5b793623f05761b0297d114e dm vdo: use a proper Makefile for dm-vdo
date:   6 weeks ago
config: x86_64-randconfig-101-20240405 (https://download.01.org/0day-ci/archive/20240405/202404050327.4ebVLBD3-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404050327.4ebVLBD3-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/md/dm-vdo/murmurhash3.c:157:3-4: Unneeded semicolon

vim +157 drivers/md/dm-vdo/murmurhash3.c

a3957b1f3ec9ec Matthew Sakai 2023-11-16   51  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   52  void murmurhash3_128(const void *key, const int len, const u32 seed, void *out)
a3957b1f3ec9ec Matthew Sakai 2023-11-16   53  {
a3957b1f3ec9ec Matthew Sakai 2023-11-16   54  	const u8 *data = key;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   55  	const int nblocks = len / 16;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   56  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   57  	u64 h1 = seed;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   58  	u64 h2 = seed;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   59  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   60  	const u64 c1 = 0x87c37b91114253d5LLU;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   61  	const u64 c2 = 0x4cf5ad432745937fLLU;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   62  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   63  	/* body */
a3957b1f3ec9ec Matthew Sakai 2023-11-16   64  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   65  	const u64 *blocks = (const u64 *)(data);
a3957b1f3ec9ec Matthew Sakai 2023-11-16   66  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   67  	int i;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   68  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   69  	for (i = 0; i < nblocks; i++) {
a3957b1f3ec9ec Matthew Sakai 2023-11-16   70  		u64 k1 = getblock64(blocks, i * 2 + 0);
a3957b1f3ec9ec Matthew Sakai 2023-11-16   71  		u64 k2 = getblock64(blocks, i * 2 + 1);
a3957b1f3ec9ec Matthew Sakai 2023-11-16   72  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   73  		k1 *= c1;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   74  		k1 = ROTL64(k1, 31);
a3957b1f3ec9ec Matthew Sakai 2023-11-16   75  		k1 *= c2;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   76  		h1 ^= k1;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   77  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   78  		h1 = ROTL64(h1, 27);
a3957b1f3ec9ec Matthew Sakai 2023-11-16   79  		h1 += h2;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   80  		h1 = h1 * 5 + 0x52dce729;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   81  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   82  		k2 *= c2;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   83  		k2 = ROTL64(k2, 33);
a3957b1f3ec9ec Matthew Sakai 2023-11-16   84  		k2 *= c1;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   85  		h2 ^= k2;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   86  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   87  		h2 = ROTL64(h2, 31);
a3957b1f3ec9ec Matthew Sakai 2023-11-16   88  		h2 += h1;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   89  		h2 = h2 * 5 + 0x38495ab5;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   90  	}
a3957b1f3ec9ec Matthew Sakai 2023-11-16   91  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   92  	/* tail */
a3957b1f3ec9ec Matthew Sakai 2023-11-16   93  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   94  	{
a3957b1f3ec9ec Matthew Sakai 2023-11-16   95  		const u8 *tail = (const u8 *)(data + nblocks * 16);
a3957b1f3ec9ec Matthew Sakai 2023-11-16   96  
a3957b1f3ec9ec Matthew Sakai 2023-11-16   97  		u64 k1 = 0;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   98  		u64 k2 = 0;
a3957b1f3ec9ec Matthew Sakai 2023-11-16   99  
a3957b1f3ec9ec Matthew Sakai 2023-11-16  100  		switch (len & 15) {
a3957b1f3ec9ec Matthew Sakai 2023-11-16  101  		case 15:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  102  			k2 ^= ((u64)tail[14]) << 48;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  103  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  104  		case 14:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  105  			k2 ^= ((u64)tail[13]) << 40;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  106  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  107  		case 13:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  108  			k2 ^= ((u64)tail[12]) << 32;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  109  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  110  		case 12:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  111  			k2 ^= ((u64)tail[11]) << 24;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  112  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  113  		case 11:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  114  			k2 ^= ((u64)tail[10]) << 16;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  115  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  116  		case 10:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  117  			k2 ^= ((u64)tail[9]) << 8;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  118  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  119  		case 9:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  120  			k2 ^= ((u64)tail[8]) << 0;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  121  			k2 *= c2;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  122  			k2 = ROTL64(k2, 33);
a3957b1f3ec9ec Matthew Sakai 2023-11-16  123  			k2 *= c1;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  124  			h2 ^= k2;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  125  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  126  
a3957b1f3ec9ec Matthew Sakai 2023-11-16  127  		case 8:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  128  			k1 ^= ((u64)tail[7]) << 56;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  129  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  130  		case 7:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  131  			k1 ^= ((u64)tail[6]) << 48;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  132  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  133  		case 6:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  134  			k1 ^= ((u64)tail[5]) << 40;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  135  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  136  		case 5:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  137  			k1 ^= ((u64)tail[4]) << 32;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  138  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  139  		case 4:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  140  			k1 ^= ((u64)tail[3]) << 24;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  141  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  142  		case 3:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  143  			k1 ^= ((u64)tail[2]) << 16;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  144  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  145  		case 2:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  146  			k1 ^= ((u64)tail[1]) << 8;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  147  			fallthrough;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  148  		case 1:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  149  			k1 ^= ((u64)tail[0]) << 0;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  150  			k1 *= c1;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  151  			k1 = ROTL64(k1, 31);
a3957b1f3ec9ec Matthew Sakai 2023-11-16  152  			k1 *= c2;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  153  			h1 ^= k1;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  154  			break;
a3957b1f3ec9ec Matthew Sakai 2023-11-16  155  		default:
a3957b1f3ec9ec Matthew Sakai 2023-11-16  156  			break;
a3957b1f3ec9ec Matthew Sakai 2023-11-16 @157  		};

:::::: The code at line 157 was first introduced by commit
:::::: a3957b1f3ec9ec78dd33422f3a8b4ee6781d8e3b dm vdo: add the MurmurHash3 fast hashing algorithm

:::::: TO: Matthew Sakai <msakai@redhat.com>
:::::: CC: Mike Snitzer <snitzer@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

