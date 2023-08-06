Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C4B77135B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 05:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjHFDTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 23:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHFDTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 23:19:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D611FE1
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 20:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691291941; x=1722827941;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=+XJsK0JWaFcLGJRtYyZI/RzJn5iN7FYTMMyfFjYDZmU=;
  b=TBDKRdyeAt+4K6AQNliMu340/zBVS6/doB7uGRsaFH8zXpSfZyeF6sNn
   A5rUqvhI+Y4jCARIsHLz0Nq7kAsHUteIayqFAmObdOQcQEWORTWZJMWru
   OI9/aWGPSSfmUH+VzfFt7dk5/XsT3wo/umd5XkZrnmRohIE7MlNZRc+gk
   H25oF+ZZzfpLh3YOorlCZkF70WaITuma49oxxoc/z1jlfb0JGgLBnXuXv
   PwtodRqZipUNkeVacdNRlrlaRc/swQ25IH9vikAS+RvAa4Ftsw2EB91MV
   JZ3zr+D8JVjH7YBcKdto5UD5+pd8oFNqMPvKr6sR9SrY/cDvxqoGaoPe8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10793"; a="355283889"
X-IronPort-AV: E=Sophos;i="6.01,259,1684825200"; 
   d="scan'208";a="355283889"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2023 20:19:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873845916"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Aug 2023 20:19:02 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qSUIF-00040H-1A;
        Sun, 06 Aug 2023 03:18:59 +0000
Date:   Sun, 6 Aug 2023 11:18:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28:
 sparse: sparse: incorrect type in argument 1 (different base types)
Message-ID: <202308061123.JtyikTNN-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f6a691685962637e53371788fe2a72b171aedc68
commit: 0f5d4a0b995faa6537c4de79973817a4f8da206a crypto: certs: fix FIPS selftest dependency
date:   6 months ago
config: sh-randconfig-r092-20230806 (https://download.01.org/0day-ci/archive/20230806/202308061123.JtyikTNN-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230806/202308061123.JtyikTNN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308061123.JtyikTNN-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   arch/sh/boot/compressed/misc.c: note: in included file (through arch/sh/boot/compressed/../../../../lib/decompress_unxz.c):
>> arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
   arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *

vim +393 arch/sh/boot/compressed/../../../../lib/xz/xz_dec_stream.c

24fa0402a9b6a5 Lasse Collin 2011-01-12  385  
24fa0402a9b6a5 Lasse Collin 2011-01-12  386  /* Decode the Stream Header field (the first 12 bytes of the .xz Stream). */
24fa0402a9b6a5 Lasse Collin 2011-01-12  387  static enum xz_ret dec_stream_header(struct xz_dec *s)
24fa0402a9b6a5 Lasse Collin 2011-01-12  388  {
24fa0402a9b6a5 Lasse Collin 2011-01-12  389  	if (!memeq(s->temp.buf, HEADER_MAGIC, HEADER_MAGIC_SIZE))
24fa0402a9b6a5 Lasse Collin 2011-01-12  390  		return XZ_FORMAT_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  391  
24fa0402a9b6a5 Lasse Collin 2011-01-12  392  	if (xz_crc32(s->temp.buf + HEADER_MAGIC_SIZE, 2, 0)
24fa0402a9b6a5 Lasse Collin 2011-01-12 @393  			!= get_le32(s->temp.buf + HEADER_MAGIC_SIZE + 2))
24fa0402a9b6a5 Lasse Collin 2011-01-12  394  		return XZ_DATA_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  395  
24fa0402a9b6a5 Lasse Collin 2011-01-12  396  	if (s->temp.buf[HEADER_MAGIC_SIZE] != 0)
24fa0402a9b6a5 Lasse Collin 2011-01-12  397  		return XZ_OPTIONS_ERROR;
24fa0402a9b6a5 Lasse Collin 2011-01-12  398  
24fa0402a9b6a5 Lasse Collin 2011-01-12  399  	/*
24fa0402a9b6a5 Lasse Collin 2011-01-12  400  	 * Of integrity checks, we support only none (Check ID = 0) and
24fa0402a9b6a5 Lasse Collin 2011-01-12  401  	 * CRC32 (Check ID = 1). However, if XZ_DEC_ANY_CHECK is defined,
24fa0402a9b6a5 Lasse Collin 2011-01-12  402  	 * we will accept other check types too, but then the check won't
24fa0402a9b6a5 Lasse Collin 2011-01-12  403  	 * be verified and a warning (XZ_UNSUPPORTED_CHECK) will be given.
24fa0402a9b6a5 Lasse Collin 2011-01-12  404  	 */
4f8d7abaa413c3 Lasse Collin 2021-10-11  405  	if (s->temp.buf[HEADER_MAGIC_SIZE + 1] > XZ_CHECK_MAX)
4f8d7abaa413c3 Lasse Collin 2021-10-11  406  		return XZ_OPTIONS_ERROR;
4f8d7abaa413c3 Lasse Collin 2021-10-11  407  
24fa0402a9b6a5 Lasse Collin 2011-01-12  408  	s->check_type = s->temp.buf[HEADER_MAGIC_SIZE + 1];
24fa0402a9b6a5 Lasse Collin 2011-01-12  409  

:::::: The code at line 393 was first introduced by commit
:::::: 24fa0402a9b6a537e87e38341e78b7da86486846 decompressors: add XZ decompressor module

:::::: TO: Lasse Collin <lasse.collin@tukaani.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
