Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399547E17D6
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjKEXPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjKEXPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:15:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD8BEE0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 15:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699226106; x=1730762106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NLvyoEtw/T4lswhya0GIpu6PjCWuUfVZ+IjEo1JoCYE=;
  b=Ayh5d18MfBIl+ZZkbLAG38tBo7J3nLn7RVcNWnTMKG1rEQFRmsKRBB0X
   NxosfvdqlvTjkPUwsVFzyKtcZPQEdIF9KuyI8WwDyro+nWE3fGmEgwdyy
   DcuU86Y6clQRxkA6N4lWXSp+i7R50IhwkBYcgVbS3whfGXyne2chcchL8
   czNbg4q3XuDeh2L7VI2B7LfzM9tPmUuO+skXrUxRlxaDqyooj27PKwfdh
   BjXSiruju397y3sk6qJu+Tj43v6IcIGkfzK1OYCvz3WA9rADeXKLCpsQR
   FhjPeJwUI5rlM5avkJqUJCjtJofi9GQ0hoM0H4V8G89QZ/g/jtUdL4HD9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388999697"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="388999697"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 15:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="738634497"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="738634497"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Nov 2023 15:15:04 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzmKc-0005sS-0A;
        Sun, 05 Nov 2023 23:15:02 +0000
Date:   Mon, 6 Nov 2023 07:13:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: net/ceph/osdmap.c:1246:10: warning: result of comparison of constant
 4611686018427387891 with expression of type 'u32' (aka 'unsigned int') is
 always false
Message-ID: <202311060731.8P11QmUf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   77fa2fbe87fc605c4bfa87dff87be9bfded0e9a3
commit: afe956c577b2d5a3d9834e4424587c1ebcf90c4c kbuild: Enable -Wtautological-compare
date:   3 years, 7 months ago
config: x86_64-randconfig-012-20230909 (https://download.01.org/0day-ci/archive/20231106/202311060731.8P11QmUf-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060731.8P11QmUf-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060731.8P11QmUf-lkp@intel.com/

All warnings (new ones prefixed by >>):

   net/ceph/osdmap.c:176:6: warning: no previous prototype for function 'clear_choose_args' [-Wmissing-prototypes]
   void clear_choose_args(struct crush_map *c)
        ^
   net/ceph/osdmap.c:176:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void clear_choose_args(struct crush_map *c)
   ^
   static 
>> net/ceph/osdmap.c:1246:10: warning: result of comparison of constant 4611686018427387891 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
               ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/ceph/osdmap.c:1429:10: warning: result of comparison of constant 2305843009213693945 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           if (len > (SIZE_MAX - sizeof(*pg)) / (2 * sizeof(u32)))
               ~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   3 warnings generated.
--
>> drivers/block/rbd.c:6190:17: warning: result of comparison of constant 2305843009213693948 with expression of type 'u32' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           if (snap_count > (SIZE_MAX - sizeof (struct ceph_snap_context))
               ~~~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1246 net/ceph/osdmap.c

10db634e2083a2 Ilya Dryomov 2014-03-21  1236  
a303bb0e58345f Ilya Dryomov 2017-06-21  1237  static struct ceph_pg_mapping *__decode_pg_temp(void **p, void *end,
a303bb0e58345f Ilya Dryomov 2017-06-21  1238  						bool incremental)
a303bb0e58345f Ilya Dryomov 2017-06-21  1239  {
a303bb0e58345f Ilya Dryomov 2017-06-21  1240  	struct ceph_pg_mapping *pg;
a303bb0e58345f Ilya Dryomov 2017-06-21  1241  	u32 len, i;
a303bb0e58345f Ilya Dryomov 2017-06-21  1242  
a303bb0e58345f Ilya Dryomov 2017-06-21  1243  	ceph_decode_32_safe(p, end, len, e_inval);
a303bb0e58345f Ilya Dryomov 2017-06-21  1244  	if (len == 0 && incremental)
a303bb0e58345f Ilya Dryomov 2017-06-21  1245  		return NULL;	/* new_pg_temp: [] to remove */
a303bb0e58345f Ilya Dryomov 2017-06-21 @1246  	if (len > (SIZE_MAX - sizeof(*pg)) / sizeof(u32))
a303bb0e58345f Ilya Dryomov 2017-06-21  1247  		return ERR_PTR(-EINVAL);
a303bb0e58345f Ilya Dryomov 2017-06-21  1248  
a303bb0e58345f Ilya Dryomov 2017-06-21  1249  	ceph_decode_need(p, end, len * sizeof(u32), e_inval);
a303bb0e58345f Ilya Dryomov 2017-06-21  1250  	pg = alloc_pg_mapping(len * sizeof(u32));
10db634e2083a2 Ilya Dryomov 2014-03-21  1251  	if (!pg)
a303bb0e58345f Ilya Dryomov 2017-06-21  1252  		return ERR_PTR(-ENOMEM);
10db634e2083a2 Ilya Dryomov 2014-03-21  1253  
35a935d75d51ab Ilya Dryomov 2014-03-21  1254  	pg->pg_temp.len = len;
10db634e2083a2 Ilya Dryomov 2014-03-21  1255  	for (i = 0; i < len; i++)
35a935d75d51ab Ilya Dryomov 2014-03-21  1256  		pg->pg_temp.osds[i] = ceph_decode_32(p);
10db634e2083a2 Ilya Dryomov 2014-03-21  1257  
a303bb0e58345f Ilya Dryomov 2017-06-21  1258  	return pg;
10db634e2083a2 Ilya Dryomov 2014-03-21  1259  
10db634e2083a2 Ilya Dryomov 2014-03-21  1260  e_inval:
a303bb0e58345f Ilya Dryomov 2017-06-21  1261  	return ERR_PTR(-EINVAL);
10db634e2083a2 Ilya Dryomov 2014-03-21  1262  }
10db634e2083a2 Ilya Dryomov 2014-03-21  1263  

:::::: The code at line 1246 was first introduced by commit
:::::: a303bb0e58345fe9f7ab2f82b90266f2b5036058 libceph: introduce and switch to decode_pg_mapping()

:::::: TO: Ilya Dryomov <idryomov@gmail.com>
:::::: CC: Ilya Dryomov <idryomov@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
