Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3780B1F4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 04:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjLIDzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 22:55:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLIDzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 22:55:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C1D10D7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 19:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702094153; x=1733630153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=y0/P9ZYlnsj2VGEjMZNIbQTHM3v+Cf4A+i0BdCFxRbw=;
  b=HxnMfljiS5nYX3GMz8ygY+f0jvERGkdTjz/JWK74LkVgdQDjMkY1E9nS
   LvhDLHvZ+qo4Ak2yuzRKisnSLvXj7EGL4QwJRJDLCHYCRu/7JI0uLbDu9
   V5U39ky4nZu4RGY6oTphutGesC8PxLfi3i/tD88coguXVlsbEXIDiKCFD
   fl1BcP1/LbHLIyAofrc/sjFKUfGK0V8BJJf/TsSZj3LWPtB2MOj5P/clJ
   QF3eboSUwBvejmAAVvTQDe/NqBnd86zlPQJ43U7/D4ymITqK5TLkPhxMa
   BhHQ/sgQd6Sgl9wSI/m8++JQzBeOVZb2oJqzxSytlFmO04frxwvncSQSd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="480687069"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="480687069"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 19:55:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="838330438"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="838330438"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 08 Dec 2023 19:55:52 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBoRS-000EmR-0X;
        Sat, 09 Dec 2023 03:55:50 +0000
Date:   Sat, 9 Dec 2023 11:55:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kent Overstreet <kmo@daterainc.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: fs/bcachefs/error.h:168:9: warning: function 'bch2_bkey_fsck_err'
 might be a candidate for 'gnu_printf' format attribute
Message-ID: <202312091128.LxOCXRoz-lkp@intel.com>
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
head:   5e3f5b81de80c98338bcb47c233aebefee5a4801
commit: b65db750e2bb9252321fd54c284edd73c1595a09 bcachefs: Enumerate fsck errors
date:   5 weeks ago
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20231209/202312091128.LxOCXRoz-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312091128.LxOCXRoz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312091128.LxOCXRoz-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/bcachefs/bcachefs.h:206,
                    from fs/bcachefs/acl.c:3:
   fs/bcachefs/bcachefs_format.h:215:25: warning: 'p' offset 3 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     215 |         struct bpos     p;
         |                         ^
   fs/bcachefs/bcachefs_format.h:217:25: warning: 'version' offset 27 in 'struct bkey' isn't aligned to 4 [-Wpacked-not-aligned]
     217 |         struct bversion version;
         |                         ^~~~~~~
   In file included from fs/bcachefs/str_hash.h:8,
                    from fs/bcachefs/xattr.h:5,
                    from fs/bcachefs/acl.c:6:
   fs/bcachefs/error.h: In function 'bch2_bkey_fsck_err':
>> fs/bcachefs/error.h:168:9: warning: function 'bch2_bkey_fsck_err' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     168 |         prt_vprintf(err_msg, fmt, args);
         |         ^~~~~~~~~~~


vim +168 fs/bcachefs/error.h

   138	
   139	#define __fsck_err_on(cond, c, _flags, _err_type, ...)			\
   140		(unlikely(cond) ? __fsck_err(c, _flags, _err_type, __VA_ARGS__) : false)
   141	
   142	#define need_fsck_err_on(cond, c, _err_type, ...)				\
   143		__fsck_err_on(cond, c, FSCK_CAN_IGNORE|FSCK_NEED_FSCK, _err_type, __VA_ARGS__)
   144	
   145	#define need_fsck_err(c, _err_type, ...)				\
   146		__fsck_err(c, FSCK_CAN_IGNORE|FSCK_NEED_FSCK, _err_type, __VA_ARGS__)
   147	
   148	#define mustfix_fsck_err(c, _err_type, ...)				\
   149		__fsck_err(c, FSCK_CAN_FIX, _err_type, __VA_ARGS__)
   150	
   151	#define mustfix_fsck_err_on(cond, c, _err_type, ...)			\
   152		__fsck_err_on(cond, c, FSCK_CAN_FIX, _err_type, __VA_ARGS__)
   153	
   154	#define fsck_err(c, _err_type, ...)					\
   155		__fsck_err(c, FSCK_CAN_FIX|FSCK_CAN_IGNORE, _err_type, __VA_ARGS__)
   156	
   157	#define fsck_err_on(cond, c, _err_type, ...)				\
   158		__fsck_err_on(cond, c, FSCK_CAN_FIX|FSCK_CAN_IGNORE, _err_type, __VA_ARGS__)
   159	
   160	static inline void bch2_bkey_fsck_err(struct bch_fs *c,
   161					     struct printbuf *err_msg,
   162					     enum bch_sb_error_id err_type,
   163					     const char *fmt, ...)
   164	{
   165		va_list args;
   166	
   167		va_start(args, fmt);
 > 168		prt_vprintf(err_msg, fmt, args);
   169		va_end(args);
   170	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
