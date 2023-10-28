Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5207DA824
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjJ1Qyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Qyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:54:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5C5D3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Oct 2023 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698512073; x=1730048073;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dzK2Toyt3q+Mkf5r2daPoKDylIhodn+OhjhsWsffjvo=;
  b=AbX8qDmkuiNdAQN4t0U6fSQBM9lLq3gXluJYR7qTtwDaWJQYX4V0furk
   7hxYojvlC10s7FUJWc5P6EPO7QNynNdRIyRjgKmPdAE6rqASmRJmfGeGu
   x3BLd33nrbnLHU0np7L3x4G9TKSa7M0TGe12CvTwivoOvswKbeciIWfrP
   fVqVb/siG0oXNZf6M/eoqCichpeH0Yr2JpmCqz2q26pMmxgpoybHvYKAt
   V0QdoJFCn1XnfA1EB+k1kD8ixupZw8KdIWT6YBvk86s2l06eiRUGOqmrI
   t0P/zRW+d8S1qwM/d5iuOxlQvLOK2CW26pq6SvMiWwM964rbLWFOhqzCG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="391776192"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="391776192"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2023 09:54:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10877"; a="763521956"
X-IronPort-AV: E=Sophos;i="6.03,259,1694761200"; 
   d="scan'208";a="763521956"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 28 Oct 2023 09:54:31 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwmZw-000Bv5-3B;
        Sat, 28 Oct 2023 16:54:28 +0000
Date:   Sun, 29 Oct 2023 00:54:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Danny Tsen <dtsen@linux.ibm.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: arch/powerpc/crypto/aes-gcm-p10-glue.c:121:9: error:
 'gcm_init_htable' accessing 256 bytes in a region of size 224
Message-ID: <202310290004.TQsw1iN1-lkp@intel.com>
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

Hi Danny,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   56567a20b22bdbf85c3e55eee3bf2bd23fa2f108
commit: 9c716e1bd369afa2d1c5038297e8ceda3f82db7d crypto: p10-aes-gcm - Remove POWER10_CPU dependency
date:   6 months ago
config: powerpc64-randconfig-r005-20230913 (https://download.01.org/0day-ci/archive/20231029/202310290004.TQsw1iN1-lkp@intel.com/config)
compiler: powerpc64le-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231029/202310290004.TQsw1iN1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310290004.TQsw1iN1-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/powerpc/crypto/aes-gcm-p10-glue.c: In function 'gcmp10_init':
>> arch/powerpc/crypto/aes-gcm-p10-glue.c:121:9: error: 'gcm_init_htable' accessing 256 bytes in a region of size 224 [-Werror=stringop-overflow=]
     121 |         gcm_init_htable(hash->Htable+32, hash->H);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/powerpc/crypto/aes-gcm-p10-glue.c:121:9: note: referencing argument 1 of type 'unsigned char[256]'
   arch/powerpc/crypto/aes-gcm-p10-glue.c:121:9: note: referencing argument 2 of type 'unsigned char[16]'
   arch/powerpc/crypto/aes-gcm-p10-glue.c:41:17: note: in a call to function 'gcm_init_htable'
      41 | asmlinkage void gcm_init_htable(unsigned char htable[256], unsigned char Xi[16]);
         |                 ^~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/gcm_init_htable +121 arch/powerpc/crypto/aes-gcm-p10-glue.c

cdcecfd9991fe9a Danny Tsen 2023-02-20  113  
cdcecfd9991fe9a Danny Tsen 2023-02-20  114  static void gcmp10_init(struct gcm_ctx *gctx, u8 *iv, unsigned char *rdkey,
cdcecfd9991fe9a Danny Tsen 2023-02-20  115  			struct Hash_ctx *hash, u8 *assoc, unsigned int assoclen)
cdcecfd9991fe9a Danny Tsen 2023-02-20  116  {
cdcecfd9991fe9a Danny Tsen 2023-02-20  117  	__be32 counter = cpu_to_be32(1);
cdcecfd9991fe9a Danny Tsen 2023-02-20  118  
cdcecfd9991fe9a Danny Tsen 2023-02-20  119  	aes_p8_encrypt(hash->H, hash->H, rdkey);
cdcecfd9991fe9a Danny Tsen 2023-02-20  120  	set_subkey(hash->H);
cdcecfd9991fe9a Danny Tsen 2023-02-20 @121  	gcm_init_htable(hash->Htable+32, hash->H);
cdcecfd9991fe9a Danny Tsen 2023-02-20  122  
cdcecfd9991fe9a Danny Tsen 2023-02-20  123  	*((__be32 *)(iv+12)) = counter;
cdcecfd9991fe9a Danny Tsen 2023-02-20  124  
cdcecfd9991fe9a Danny Tsen 2023-02-20  125  	gctx->Plen = 0;
cdcecfd9991fe9a Danny Tsen 2023-02-20  126  
cdcecfd9991fe9a Danny Tsen 2023-02-20  127  	/*
cdcecfd9991fe9a Danny Tsen 2023-02-20  128  	 * Encrypt counter vector as iv tag and increment counter.
cdcecfd9991fe9a Danny Tsen 2023-02-20  129  	 */
cdcecfd9991fe9a Danny Tsen 2023-02-20  130  	aes_p8_encrypt(iv, gctx->ivtag, rdkey);
cdcecfd9991fe9a Danny Tsen 2023-02-20  131  
cdcecfd9991fe9a Danny Tsen 2023-02-20  132  	counter = cpu_to_be32(2);
cdcecfd9991fe9a Danny Tsen 2023-02-20  133  	*((__be32 *)(iv+12)) = counter;
cdcecfd9991fe9a Danny Tsen 2023-02-20  134  	memcpy(gctx->iv, iv, 16);
cdcecfd9991fe9a Danny Tsen 2023-02-20  135  
cdcecfd9991fe9a Danny Tsen 2023-02-20  136  	gctx->aadLen = assoclen;
cdcecfd9991fe9a Danny Tsen 2023-02-20  137  	memset(gctx->aad_hash, 0, 16);
cdcecfd9991fe9a Danny Tsen 2023-02-20  138  	if (assoclen)
cdcecfd9991fe9a Danny Tsen 2023-02-20  139  		set_aad(gctx, hash, assoc, assoclen);
cdcecfd9991fe9a Danny Tsen 2023-02-20  140  }
cdcecfd9991fe9a Danny Tsen 2023-02-20  141  

:::::: The code at line 121 was first introduced by commit
:::::: cdcecfd9991fe9aac8160a9731b0ffd1e702d19d crypto: p10-aes-gcm - Glue code for AES/GCM stitched implementation

:::::: TO: Danny Tsen <dtsen@linux.ibm.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
