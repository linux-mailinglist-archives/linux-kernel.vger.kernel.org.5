Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBC17B2733
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbjI1VLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjI1VLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:11:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE491B1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695935493; x=1727471493;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JZzcF/RE+QQCAwtGUFO42r4634qOfEeUd9jYMeM50JQ=;
  b=D/JsqoGyCsar3MBURWczUtfbIK+MLP+AGqjx0/BhWjAwz9QRzujw7+pj
   OV6hva71lyhs/Ua7go1iDe3kK3mGSHcSPzgLRPX1U7fVkqBhMJwqrx33c
   beBWV9EefOpIi5AgJ/c5u0sCT0Uim/VgkdRb3qqBtnxQtXXTKpYtVl4+W
   otMMPnc9fQkkXxqgHKARJ5ZD//51dT8ygPxggrz58CoJalYjngIYxh8G0
   PWLMroiTdZrtpS6g3PY/K8VBWkK60unlfRiwkaIozOlZF2qGPCwOyt289
   ZTHeX88PHfYpBa9rJGAufXtr8vP/IIcjpqGVxcGmZE/BRHeMs7TnANrQD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="446338037"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="446338037"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 14:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="996712650"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="996712650"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 28 Sep 2023 14:11:30 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlyIC-0001yM-2b;
        Thu, 28 Sep 2023 21:11:28 +0000
Date:   Fri, 29 Sep 2023 05:10:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Lyude Paul <lyude@redhat.com>
Subject: drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:423:31-32: Unneeded
 semicolon
Message-ID: <202309290549.7IPOeLw5-lkp@intel.com>
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
head:   9ed22ae6be817d7a3f5c15ca22cbc9d3963b481d
commit: 78a43c7e3b2ff5aed1809f93b4f87a418355789e drm/nouveau/gr/gf100-: make global attrib_cb actually global
date:   11 months ago
config: i386-randconfig-053-20230928 (https://download.01.org/0day-ci/archive/20230929/202309290549.7IPOeLw5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230929/202309290549.7IPOeLw5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290549.7IPOeLw5-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/gpu/drm/nouveau/nvkm/engine/gr/gf100.c:423:31-32: Unneeded semicolon

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
