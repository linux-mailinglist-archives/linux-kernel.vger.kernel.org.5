Return-Path: <linux-kernel+bounces-20195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B2D827BB4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 00:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE7FB22D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 23:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7856779;
	Mon,  8 Jan 2024 23:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNj0eHFE"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC156743
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 23:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704757645; x=1736293645;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dm7tPeEQCLzNSjz+oTFrpyMlFIImYg8aGgaIbyOr9Lg=;
  b=fNj0eHFE6gEGZa1SEkoL/jSN29iterH0lVggb4UFKM4U6IJrL1ECMr/N
   14R5MXAK8JiaZb/N72ALDId0jAyVOQXAX3/P6j9m+8OlOHP7oM3psqhdU
   aM0bGTHy9llMf0+L1alycQKOsHX0KVOm49fPVWxvwbOxXu6WFybkg+5hf
   a0uR5Ue0puXXlstE95AxIeOszEYoVbbV4T81ck+TAFghzp+0zG/k0tYpm
   V2I63ElntHGUDb8/v5koyHAffvtMggEDMWM4BwBwOkM99k/aBOlhSrWYR
   5luVrYEZuNWH41wUV9/1n6GHZI69S117ZX1cV+fFsdvsq0YkLsqxdGLk3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11520964"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="11520964"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 15:47:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="785014922"
X-IronPort-AV: E=Sophos;i="6.04,181,1695711600"; 
   d="scan'208";a="785014922"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Jan 2024 15:47:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMzKu-0005EQ-1k;
	Mon, 08 Jan 2024 23:47:16 +0000
Date: Tue, 9 Jan 2024 07:46:58 +0800
From: kernel test robot <lkp@intel.com>
To: wenxu <wenxu@ucloud.cn>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: net/netfilter/nf_flow_table_offload.c:88:25: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202401090754.reS6Tzuj-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5db8752c3b81bd33a549f6f812bab81e3bb61b20
commit: 3e1b0c168f6c8648f217c78ed6a4135af8c9d830 netfilter: flowtable: add vlan match offload support
date:   2 years, 9 months ago
config: i386-randconfig-r132-20240106 (https://download.01.org/0day-ci/archive/20240109/202401090754.reS6Tzuj-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240109/202401090754.reS6Tzuj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090754.reS6Tzuj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/netfilter/nf_flow_table_offload.c:46:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] keyid @@     got unsigned int @@
   net/netfilter/nf_flow_table_offload.c:46:32: sparse:     expected restricted __be32 [usertype] keyid
   net/netfilter/nf_flow_table_offload.c:46:32: sparse:     got unsigned int
   net/netfilter/nf_flow_table_offload.c:56:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] src @@     got unsigned int @@
   net/netfilter/nf_flow_table_offload.c:56:44: sparse:     expected restricted __be32 [usertype] src
   net/netfilter/nf_flow_table_offload.c:56:44: sparse:     got unsigned int
   net/netfilter/nf_flow_table_offload.c:58:44: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] dst @@     got unsigned int @@
   net/netfilter/nf_flow_table_offload.c:58:44: sparse:     expected restricted __be32 [usertype] dst
   net/netfilter/nf_flow_table_offload.c:58:44: sparse:     got unsigned int
>> net/netfilter/nf_flow_table_offload.c:88:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] vlan_tpid @@     got int @@
   net/netfilter/nf_flow_table_offload.c:88:25: sparse:     expected restricted __be16 [usertype] vlan_tpid
   net/netfilter/nf_flow_table_offload.c:88:25: sparse:     got int
   net/netfilter/nf_flow_table_offload.c:147:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] src @@     got unsigned int @@
   net/netfilter/nf_flow_table_offload.c:147:32: sparse:     expected restricted __be32 [usertype] src
   net/netfilter/nf_flow_table_offload.c:147:32: sparse:     got unsigned int
   net/netfilter/nf_flow_table_offload.c:149:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] dst @@     got unsigned int @@
   net/netfilter/nf_flow_table_offload.c:149:32: sparse:     expected restricted __be32 [usertype] dst
   net/netfilter/nf_flow_table_offload.c:149:32: sparse:     got unsigned int
   net/netfilter/nf_flow_table_offload.c:164:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] n_proto @@     got int @@
   net/netfilter/nf_flow_table_offload.c:164:29: sparse:     expected restricted __be16 [usertype] n_proto
   net/netfilter/nf_flow_table_offload.c:164:29: sparse:     got int
   net/netfilter/nf_flow_table_offload.c:182:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] src @@     got int @@
   net/netfilter/nf_flow_table_offload.c:182:22: sparse:     expected restricted __be16 [usertype] src
   net/netfilter/nf_flow_table_offload.c:182:22: sparse:     got int
   net/netfilter/nf_flow_table_offload.c:184:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be16 [usertype] dst @@     got int @@
   net/netfilter/nf_flow_table_offload.c:184:22: sparse:     expected restricted __be16 [usertype] dst
   net/netfilter/nf_flow_table_offload.c:184:22: sparse:     got int
   net/netfilter/nf_flow_table_offload.c:247:30: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 const [usertype] *value @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:247:30: sparse:     expected restricted __be32 const [usertype] *value
   net/netfilter/nf_flow_table_offload.c:247:30: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:247:36: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:247:36: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:247:36: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:252:30: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 const [usertype] *value @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:252:30: sparse:     expected restricted __be32 const [usertype] *value
   net/netfilter/nf_flow_table_offload.c:252:30: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:252:36: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:252:36: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:252:36: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:306:30: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 const [usertype] *value @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:306:30: sparse:     expected restricted __be32 const [usertype] *value
   net/netfilter/nf_flow_table_offload.c:306:30: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:306:36: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:306:36: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:306:36: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:312:30: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 const [usertype] *value @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:312:30: sparse:     expected restricted __be32 const [usertype] *value
   net/netfilter/nf_flow_table_offload.c:312:30: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:312:36: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:312:36: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:312:36: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:323:20: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 @@
   net/netfilter/nf_flow_table_offload.c:323:20: sparse:     expected unsigned int [usertype] mask
   net/netfilter/nf_flow_table_offload.c:323:20: sparse:     got restricted __be32
   net/netfilter/nf_flow_table_offload.c:341:37: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:341:37: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:341:37: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:350:20: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 @@
   net/netfilter/nf_flow_table_offload.c:350:20: sparse:     expected unsigned int [usertype] mask
   net/netfilter/nf_flow_table_offload.c:350:20: sparse:     got restricted __be32
   net/netfilter/nf_flow_table_offload.c:368:37: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:368:37: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:368:37: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:390:20: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 @@
   net/netfilter/nf_flow_table_offload.c:390:20: sparse:     expected unsigned int [usertype] mask
   net/netfilter/nf_flow_table_offload.c:390:20: sparse:     got restricted __be32
   net/netfilter/nf_flow_table_offload.c:407:60: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:407:60: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:407:60: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:415:20: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 @@
   net/netfilter/nf_flow_table_offload.c:415:20: sparse:     expected unsigned int [usertype] mask
   net/netfilter/nf_flow_table_offload.c:415:20: sparse:     got restricted __be32
   net/netfilter/nf_flow_table_offload.c:432:60: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:432:60: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:432:60: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:467:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] port @@     got restricted __be32 [usertype] @@
   net/netfilter/nf_flow_table_offload.c:467:22: sparse:     expected unsigned int [assigned] [usertype] port
   net/netfilter/nf_flow_table_offload.c:467:22: sparse:     got restricted __be32 [usertype]
   net/netfilter/nf_flow_table_offload.c:468:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 @@
   net/netfilter/nf_flow_table_offload.c:468:22: sparse:     expected unsigned int [usertype] mask
   net/netfilter/nf_flow_table_offload.c:468:22: sparse:     got restricted __be32
   net/netfilter/nf_flow_table_offload.c:473:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] port @@     got restricted __be32 [usertype] @@
   net/netfilter/nf_flow_table_offload.c:473:22: sparse:     expected unsigned int [assigned] [usertype] port
   net/netfilter/nf_flow_table_offload.c:473:22: sparse:     got restricted __be32 [usertype]
   net/netfilter/nf_flow_table_offload.c:474:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 @@
   net/netfilter/nf_flow_table_offload.c:474:22: sparse:     expected unsigned int [usertype] mask
   net/netfilter/nf_flow_table_offload.c:474:22: sparse:     got restricted __be32
   net/netfilter/nf_flow_table_offload.c:481:30: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 const [usertype] *value @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:481:30: sparse:     expected restricted __be32 const [usertype] *value
   net/netfilter/nf_flow_table_offload.c:481:30: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:481:37: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:481:37: sparse:     expected restricted __be32 const [usertype] *mask
   net/netfilter/nf_flow_table_offload.c:481:37: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:497:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] port @@     got restricted __be32 [usertype] @@
   net/netfilter/nf_flow_table_offload.c:497:22: sparse:     expected unsigned int [assigned] [usertype] port
   net/netfilter/nf_flow_table_offload.c:497:22: sparse:     got restricted __be32 [usertype]
   net/netfilter/nf_flow_table_offload.c:498:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 @@
   net/netfilter/nf_flow_table_offload.c:498:22: sparse:     expected unsigned int [usertype] mask
   net/netfilter/nf_flow_table_offload.c:498:22: sparse:     got restricted __be32
   net/netfilter/nf_flow_table_offload.c:503:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] port @@     got restricted __be32 [usertype] @@
   net/netfilter/nf_flow_table_offload.c:503:22: sparse:     expected unsigned int [assigned] [usertype] port
   net/netfilter/nf_flow_table_offload.c:503:22: sparse:     got restricted __be32 [usertype]
   net/netfilter/nf_flow_table_offload.c:504:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] mask @@     got restricted __be32 @@
   net/netfilter/nf_flow_table_offload.c:504:22: sparse:     expected unsigned int [usertype] mask
   net/netfilter/nf_flow_table_offload.c:504:22: sparse:     got restricted __be32
   net/netfilter/nf_flow_table_offload.c:511:30: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected restricted __be32 const [usertype] *value @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:511:30: sparse:     expected restricted __be32 const [usertype] *value
   net/netfilter/nf_flow_table_offload.c:511:30: sparse:     got unsigned int *
   net/netfilter/nf_flow_table_offload.c:511:37: sparse: sparse: incorrect type in argument 5 (different base types) @@     expected restricted __be32 const [usertype] *mask @@     got unsigned int * @@
   net/netfilter/nf_flow_table_offload.c:511:37: sparse:     expected restricted __be32 const [usertype] *mask

vim +88 net/netfilter/nf_flow_table_offload.c

    80	
    81	static void nf_flow_rule_vlan_match(struct flow_dissector_key_vlan *key,
    82					    struct flow_dissector_key_vlan *mask,
    83					    u16 vlan_id, __be16 proto)
    84	{
    85		key->vlan_id = vlan_id;
    86		mask->vlan_id = VLAN_VID_MASK;
    87		key->vlan_tpid = proto;
  > 88		mask->vlan_tpid = 0xffff;
    89	}
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

