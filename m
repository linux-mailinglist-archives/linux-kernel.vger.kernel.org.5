Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1780381237C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 00:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbjLMXqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbjLMXqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:46:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9886C9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702511177; x=1734047177;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kkibd09OWbQ7qyk8+w4xeNQR2v52ToVvpvlYJrSAjC4=;
  b=bV5uMFk6Y8P6zx8VJ0LZ8rBxp6r9pdxf9H6aUK1VYWs7YJaniQzGOdpv
   nUTYocnroZVKR/dhERhtcHZ9mSZU7HQZzRaavHBwrQsIKeiR0NPm909Vm
   xgIlOQd4YtiULIa2xeqNNP3PUbJQNKXuHQR5HEAcWy5bu2LFCkqTSDz2q
   qeZwnQdTF3Lp0KAIGJG6YZVabnVVrUHziHzn9vOCSU9oRRBUdmq/fewuB
   Jk5GsV6qAg3+sjOnsCrQVDLWij9bHdyg6npzrv52C5D/ztByXdLkYwhmj
   6oTaFPr8hrz0oJQVeKGNSisF1dz9a00NZ5TwC2Jm2BPlccYb5+GTxNQfE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1877240"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="1877240"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 15:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="947354301"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="947354301"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Dec 2023 15:46:15 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDYvd-000LIF-19;
        Wed, 13 Dec 2023 23:46:13 +0000
Date:   Thu, 14 Dec 2023 07:45:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/backpointers.c:46:5-8: Unneeded variable: "ret". Return
 "  0" on line 53
Message-ID: <202312140748.LI8Jmu2W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5bd7ef53ffe5ca580e93e74eb8c81ed191ddc4bd
commit: b65db750e2bb9252321fd54c284edd73c1595a09 bcachefs: Enumerate fsck errors
date:   6 weeks ago
config: x86_64-randconfig-102-20231213 (https://download.01.org/0day-ci/archive/20231214/202312140748.LI8Jmu2W-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231214/202312140748.LI8Jmu2W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312140748.LI8Jmu2W-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/bcachefs/backpointers.c:46:5-8: Unneeded variable: "ret". Return "  0" on line 53
--
>> fs/bcachefs/inode.c:404:5-8: Unneeded variable: "ret". Return "  0" on line 437
   fs/bcachefs/inode.c:617:5-8: Unneeded variable: "ret". Return "  0" on line 623
--
>> fs/bcachefs/xattr.c:80:5-8: Unneeded variable: "ret". Return "  0" on line 104

vim +46 fs/bcachefs/backpointers.c

    39	
    40	int bch2_backpointer_invalid(struct bch_fs *c, struct bkey_s_c k,
    41				     enum bkey_invalid_flags flags,
    42				     struct printbuf *err)
    43	{
    44		struct bkey_s_c_backpointer bp = bkey_s_c_to_backpointer(k);
    45		struct bpos bucket = bp_pos_to_bucket(c, bp.k->p);
  > 46		int ret = 0;
    47	
    48		bkey_fsck_err_on(!bpos_eq(bp.k->p, bucket_pos_to_bp(c, bucket, bp.v->bucket_offset)),
    49				 c, err,
    50				 backpointer_pos_wrong,
    51				 "backpointer at wrong pos");
    52	fsck_err:
  > 53		return ret;
    54	}
    55	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
