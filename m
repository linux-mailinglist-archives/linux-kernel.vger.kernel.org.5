Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935B87E13AA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 14:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjKENdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 08:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjKENdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 08:33:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE46CA
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 05:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699191213; x=1730727213;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xcSEnmM82cfnpRpMAjgiN18Wb9INc9bzixTIV447hz0=;
  b=aH71Me1UPWGfLByyaOvTH3EcpGlIWTsUg/fc5etuf07Cdcg6x38Vsegd
   DVIY0yLJEkW8zud1JAtPmJFuIbDuJycmUidXZUKU3GxwTOl+OkYzb/6uo
   4aymfLzjgyclPPfaErIVGso828VNTGhNAP+FCTCvtzulh+9wklX+8wmN6
   VaqBwVPXb5pIm6c/FsZ5CN+Ix8LpHVoszQEjYouEFF5AGsXp9QaV05s76
   /2gYpjgXML9hjTgpbTkYimEVE8FnAZUAc7JL6yLtbJqEJml8xtZzNcb7z
   IfgGprDLb0xNux472XED1V36/5xhJAGSXlBR6B0DkICJimTKh9PtxwhMM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="369355419"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="369355419"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 05:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="755611767"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="755611767"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Nov 2023 05:33:31 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzdFp-0005Tj-0L;
        Sun, 05 Nov 2023 13:33:29 +0000
Date:   Sun, 5 Nov 2023 21:31:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: fs/ubifs/auth.c:30: warning: expecting prototype for
 ubifs_node_calc_hash(). Prototype was for __ubifs_node_calc_hash() instead
Message-ID: <202311052125.gE1Rylox-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: d8a22773a12c6d78ee758c9e530f3a488bb7cb29 ubifs: Enable authentication support
date:   5 years ago
config: x86_64-randconfig-012-20231101 (https://download.01.org/0day-ci/archive/20231105/202311052125.gE1Rylox-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311052125.gE1Rylox-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311052125.gE1Rylox-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/ubifs/auth.c:158:5: warning: no previous prototype for '__ubifs_shash_final' [-Wmissing-prototypes]
     158 | int __ubifs_shash_final(const struct ubifs_info *c, struct shash_desc *desc,
         |     ^~~~~~~~~~~~~~~~~~~
>> fs/ubifs/auth.c:30: warning: expecting prototype for ubifs_node_calc_hash(). Prototype was for __ubifs_node_calc_hash() instead
   fs/ubifs/auth.c:80: warning: Function parameter or member 'inhash' not described in 'ubifs_prepare_auth_node'
   fs/ubifs/auth.c:80: warning: Excess function parameter 'hash' description in 'ubifs_prepare_auth_node'
   fs/ubifs/auth.o: warning: objtool: ubifs_init_authentication()+0x225: sibling call from callable instruction with modified stack frame


vim +30 fs/ubifs/auth.c

49525e5eecca5e Sascha Hauer 2018-09-07  19  
49525e5eecca5e Sascha Hauer 2018-09-07  20  /**
49525e5eecca5e Sascha Hauer 2018-09-07  21   * ubifs_node_calc_hash - calculate the hash of a UBIFS node
49525e5eecca5e Sascha Hauer 2018-09-07  22   * @c: UBIFS file-system description object
49525e5eecca5e Sascha Hauer 2018-09-07  23   * @node: the node to calculate a hash for
49525e5eecca5e Sascha Hauer 2018-09-07  24   * @hash: the returned hash
49525e5eecca5e Sascha Hauer 2018-09-07  25   *
49525e5eecca5e Sascha Hauer 2018-09-07  26   * Returns 0 for success or a negative error code otherwise.
49525e5eecca5e Sascha Hauer 2018-09-07  27   */
49525e5eecca5e Sascha Hauer 2018-09-07  28  int __ubifs_node_calc_hash(const struct ubifs_info *c, const void *node,
49525e5eecca5e Sascha Hauer 2018-09-07  29  			    u8 *hash)
49525e5eecca5e Sascha Hauer 2018-09-07 @30  {
49525e5eecca5e Sascha Hauer 2018-09-07  31  	const struct ubifs_ch *ch = node;
49525e5eecca5e Sascha Hauer 2018-09-07  32  	SHASH_DESC_ON_STACK(shash, c->hash_tfm);
49525e5eecca5e Sascha Hauer 2018-09-07  33  	int err;
49525e5eecca5e Sascha Hauer 2018-09-07  34  
49525e5eecca5e Sascha Hauer 2018-09-07  35  	shash->tfm = c->hash_tfm;
49525e5eecca5e Sascha Hauer 2018-09-07  36  	shash->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
49525e5eecca5e Sascha Hauer 2018-09-07  37  
49525e5eecca5e Sascha Hauer 2018-09-07  38  	err = crypto_shash_digest(shash, node, le32_to_cpu(ch->len), hash);
49525e5eecca5e Sascha Hauer 2018-09-07  39  	if (err < 0)
49525e5eecca5e Sascha Hauer 2018-09-07  40  		return err;
49525e5eecca5e Sascha Hauer 2018-09-07  41  	return 0;
49525e5eecca5e Sascha Hauer 2018-09-07  42  }
49525e5eecca5e Sascha Hauer 2018-09-07  43  

:::::: The code at line 30 was first introduced by commit
:::::: 49525e5eecca5e1b4a83ac217868e8d8b843539f ubifs: Add helper functions for authentication support

:::::: TO: Sascha Hauer <s.hauer@pengutronix.de>
:::::: CC: Richard Weinberger <richard@nod.at>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
