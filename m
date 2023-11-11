Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C309B7E8991
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 07:52:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjKKGwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 01:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKKGwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 01:52:04 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE021716
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 22:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699685522; x=1731221522;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=D/Ym0syXN0CjtRQavxwU85mnwe2o6+O0A84AlHvyvi8=;
  b=AcZxhEXVQoblOuXxuIEnvUixV3K/nYYw1uIcX7VBbpYYxuSj6YI4ssn/
   n+beEZuad7RWc3PK5DAtwck5yaLAsleDy2CpndUa1FgPUqrkh0BtyG1TD
   a9zNtXrvcIZiT97AjgWf6KNokBk3qedszyjq/AoOH58IPUgWwX1pVzUZ8
   Qxrx0jfqFsxJHh4kVhnAARH/+QT6OG5A+tH+wKk8ihIBAmiYIF9nRDxLL
   qVVDszRVD/NVbx1ucZbMJ2i9i+NMtMbjoodhwj76Vs375JMN9RcMnCTrf
   G/yaoE7J8TpI1iFn9lDvb6BxZXTPnTXdhabpKBaQd1qUIJq9jXQ7UNeKG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="8909897"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="8909897"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 22:52:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="937331054"
X-IronPort-AV: E=Sophos;i="6.03,294,1694761200"; 
   d="scan'208";a="937331054"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 10 Nov 2023 22:51:59 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1hqX-000AHW-26;
        Sat, 11 Nov 2023 06:51:57 +0000
Date:   Sat, 11 Nov 2023 14:51:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Subject: drivers/gpu/drm/tests/drm_format_helper_test.c:757:36: sparse:
 sparse: incorrect type in argument 2 (different base types)
Message-ID: <202311111442.HJ4fGRDW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: c37ea39c1fa880da0d7fd2c719e5c96be19f0fc5 Merge tag 'drm-misc-next-2023-01-12' of git://anongit.freedesktop.org/drm/drm-misc into drm-next
date:   10 months ago
config: i386-randconfig-062-20230909 (https://download.01.org/0day-ci/archive/20231111/202311111442.HJ4fGRDW-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231111/202311111442.HJ4fGRDW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311111442.HJ4fGRDW-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/tests/drm_format_helper_test.c:757:36: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected restricted __le32 const [usertype] *buf @@     got unsigned int [usertype] *[assigned] buf @@
   drivers/gpu/drm/tests/drm_format_helper_test.c:757:36: sparse:     expected restricted __le32 const [usertype] *buf
   drivers/gpu/drm/tests/drm_format_helper_test.c:757:36: sparse:     got unsigned int [usertype] *[assigned] buf

vim +757 drivers/gpu/drm/tests/drm_format_helper_test.c

175073d694cd9db Thomas Zimmermann 2023-01-02  729  
453114319699b6b José Expósito     2022-09-26  730  static void drm_test_fb_xrgb8888_to_xrgb2101010(struct kunit *test)
453114319699b6b José Expósito     2022-09-26  731  {
453114319699b6b José Expósito     2022-09-26  732  	const struct convert_xrgb8888_case *params = test->param_value;
453114319699b6b José Expósito     2022-09-26  733  	const struct convert_to_xrgb2101010_result *result = &params->xrgb2101010_result;
453114319699b6b José Expósito     2022-09-26  734  	size_t dst_size;
4db88a9026c2205 Thomas Zimmermann 2023-01-02  735  	u32 *buf = NULL;
58f5d9830da0d4f Thomas Zimmermann 2023-01-02  736  	__le32 *xrgb8888 = NULL;
453114319699b6b José Expósito     2022-09-26  737  	struct iosys_map dst, src;
453114319699b6b José Expósito     2022-09-26  738  
453114319699b6b José Expósito     2022-09-26  739  	struct drm_framebuffer fb = {
453114319699b6b José Expósito     2022-09-26  740  		.format = drm_format_info(DRM_FORMAT_XRGB8888),
453114319699b6b José Expósito     2022-09-26  741  		.pitches = { params->pitch, 0, 0 },
453114319699b6b José Expósito     2022-09-26  742  	};
453114319699b6b José Expósito     2022-09-26  743  
453114319699b6b José Expósito     2022-09-26  744  	dst_size = conversion_buf_size(DRM_FORMAT_XRGB2101010,
453114319699b6b José Expósito     2022-09-26  745  				       result->dst_pitch, &params->clip);
453114319699b6b José Expósito     2022-09-26  746  	KUNIT_ASSERT_GT(test, dst_size, 0);
453114319699b6b José Expósito     2022-09-26  747  
453114319699b6b José Expósito     2022-09-26  748  	buf = kunit_kzalloc(test, dst_size, GFP_KERNEL);
453114319699b6b José Expósito     2022-09-26  749  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
453114319699b6b José Expósito     2022-09-26  750  	iosys_map_set_vaddr(&dst, buf);
453114319699b6b José Expósito     2022-09-26  751  
58f5d9830da0d4f Thomas Zimmermann 2023-01-02  752  	xrgb8888 = cpubuf_to_le32(test, params->xrgb8888, TEST_BUF_SIZE);
453114319699b6b José Expósito     2022-09-26  753  	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xrgb8888);
453114319699b6b José Expósito     2022-09-26  754  	iosys_map_set_vaddr(&src, xrgb8888);
453114319699b6b José Expósito     2022-09-26  755  
453114319699b6b José Expósito     2022-09-26  756  	drm_fb_xrgb8888_to_xrgb2101010(&dst, &result->dst_pitch, &src, &fb, &params->clip);
7089003304c6765 David Gow         2022-10-19 @757  	buf = le32buf_to_cpu(test, buf, dst_size / sizeof(u32));
a52a5451f43bb76 Maíra Canal       2022-10-25  758  	KUNIT_EXPECT_MEMEQ(test, buf, result->expected, dst_size);
453114319699b6b José Expósito     2022-09-26  759  }
453114319699b6b José Expósito     2022-09-26  760  

:::::: The code at line 757 was first introduced by commit
:::::: 7089003304c67658caead22f841840fc4a26b198 drm: tests: Fix a buffer overflow in format_helper_test

:::::: TO: David Gow <davidgow@google.com>
:::::: CC: Javier Martinez Canillas <javierm@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
