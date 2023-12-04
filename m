Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED304803B9C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234067AbjLDRdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjLDRd2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:33:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A86BA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701711214; x=1733247214;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tm472bhj1mgn39K6p4g1VDzuW05DNjEf6P3PlSrfgaE=;
  b=cpuieT3+Z7J3MNUi9CUqy4PUg7NNOv+4vJpOiYFb25iAU0hGxf5/UdZU
   xsJx80o6LrYpmrAVNZJm50Rae/2b5JycZphO9MTgyrtZG8hXLHtg/JsIb
   MiRJ9x0ftG3AuNnpeQ7BFNc49oLh0DstPArKmGZI3VRDqtGVjM6WtZdzq
   Q+JvbI7Kx4Qh2ZHrG4+KpMXF2GgUJXmhlrzKuAISpOba4fbG4oXx8Jv4C
   BNEVjKzgd6Fqt8UayXBBG159bLzi0XpCZvvRSVCMRUbvsuNpT1IUcOQZx
   qLuYTg490MylojyFZerCI5BzjX7JAGnczQ1hQ3hVpxnFgPmUYpogi+CC0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="384174441"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="384174441"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 09:33:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764027146"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="764027146"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 09:33:31 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rACoy-0007xR-2k;
        Mon, 04 Dec 2023 17:33:28 +0000
Date:   Tue, 5 Dec 2023 01:32:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: drivers/gpu/drm/nouveau/nouveau_ioc32.c:2: warning: Cannot
 understand  * \file mga_ioc32.c
Message-ID: <202312050000.EAJuyFfY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   33cc938e65a98f1d29d0a18403dbbee050dcad9a
commit: 83a44a4f47ad20997aebb311fc678a13cde391d7 x86: Remove toolchain check for X32 ABI capability
date:   1 year, 9 months ago
config: x86_64-buildonly-randconfig-005-20230918 (https://download.01.org/0day-ci/archive/20231205/202312050000.EAJuyFfY-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312050000.EAJuyFfY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312050000.EAJuyFfY-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/nouveau/nouveau_ioc32.c:2: warning: Cannot understand  * \file mga_ioc32.c
    on line 2 - I thought it was a doc line
>> drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'filp' not described in 'nouveau_compat_ioctl'
>> drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'cmd' not described in 'nouveau_compat_ioctl'
>> drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: Function parameter or member 'arg' not described in 'nouveau_compat_ioctl'
>> drivers/gpu/drm/nouveau/nouveau_ioc32.c:52: warning: expecting prototype for Called whenever a 32-bit process running under a 64(). Prototype was for nouveau_compat_ioctl() instead


vim +2 drivers/gpu/drm/nouveau/nouveau_ioc32.c

6ee738610f41b5 Ben Skeggs   2009-12-11  @2   * \file mga_ioc32.c
6ee738610f41b5 Ben Skeggs   2009-12-11   3   *
6ee738610f41b5 Ben Skeggs   2009-12-11   4   * 32-bit ioctl compatibility routines for the MGA DRM.
6ee738610f41b5 Ben Skeggs   2009-12-11   5   *
6ee738610f41b5 Ben Skeggs   2009-12-11   6   * \author Dave Airlie <airlied@linux.ie> with code from patches by Egbert Eich
6ee738610f41b5 Ben Skeggs   2009-12-11   7   *
6ee738610f41b5 Ben Skeggs   2009-12-11   8   *
6ee738610f41b5 Ben Skeggs   2009-12-11   9   * Copyright (C) Paul Mackerras 2005
6ee738610f41b5 Ben Skeggs   2009-12-11  10   * Copyright (C) Egbert Eich 2003,2004
6ee738610f41b5 Ben Skeggs   2009-12-11  11   * Copyright (C) Dave Airlie 2005
6ee738610f41b5 Ben Skeggs   2009-12-11  12   * All Rights Reserved.
6ee738610f41b5 Ben Skeggs   2009-12-11  13   *
6ee738610f41b5 Ben Skeggs   2009-12-11  14   * Permission is hereby granted, free of charge, to any person obtaining a
6ee738610f41b5 Ben Skeggs   2009-12-11  15   * copy of this software and associated documentation files (the "Software"),
6ee738610f41b5 Ben Skeggs   2009-12-11  16   * to deal in the Software without restriction, including without limitation
6ee738610f41b5 Ben Skeggs   2009-12-11  17   * the rights to use, copy, modify, merge, publish, distribute, sublicense,
6ee738610f41b5 Ben Skeggs   2009-12-11  18   * and/or sell copies of the Software, and to permit persons to whom the
6ee738610f41b5 Ben Skeggs   2009-12-11  19   * Software is furnished to do so, subject to the following conditions:
6ee738610f41b5 Ben Skeggs   2009-12-11  20   *
6ee738610f41b5 Ben Skeggs   2009-12-11  21   * The above copyright notice and this permission notice (including the next
6ee738610f41b5 Ben Skeggs   2009-12-11  22   * paragraph) shall be included in all copies or substantial portions of the
6ee738610f41b5 Ben Skeggs   2009-12-11  23   * Software.
6ee738610f41b5 Ben Skeggs   2009-12-11  24   *
6ee738610f41b5 Ben Skeggs   2009-12-11  25   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
6ee738610f41b5 Ben Skeggs   2009-12-11  26   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
6ee738610f41b5 Ben Skeggs   2009-12-11  27   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
6ee738610f41b5 Ben Skeggs   2009-12-11  28   * THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
6ee738610f41b5 Ben Skeggs   2009-12-11  29   * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
6ee738610f41b5 Ben Skeggs   2009-12-11  30   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
6ee738610f41b5 Ben Skeggs   2009-12-11  31   * IN THE SOFTWARE.
6ee738610f41b5 Ben Skeggs   2009-12-11  32   */
6ee738610f41b5 Ben Skeggs   2009-12-11  33  
6ee738610f41b5 Ben Skeggs   2009-12-11  34  #include <linux/compat.h>
6ee738610f41b5 Ben Skeggs   2009-12-11  35  
690ae20c0426f8 Sam Ravnborg 2019-05-19  36  #include <drm/drm.h>
690ae20c0426f8 Sam Ravnborg 2019-05-19  37  #include <drm/drm_ioctl.h>
6ee738610f41b5 Ben Skeggs   2009-12-11  38  
fce875d647171f Ben Skeggs   2012-07-26  39  #include "nouveau_ioctl.h"
6ee738610f41b5 Ben Skeggs   2009-12-11  40  
6ee738610f41b5 Ben Skeggs   2009-12-11  41  /**
6ee738610f41b5 Ben Skeggs   2009-12-11  42   * Called whenever a 32-bit process running under a 64-bit kernel
6ee738610f41b5 Ben Skeggs   2009-12-11  43   * performs an ioctl on /dev/dri/card<n>.
6ee738610f41b5 Ben Skeggs   2009-12-11  44   *
6ee738610f41b5 Ben Skeggs   2009-12-11  45   * \param filp file pointer.
6ee738610f41b5 Ben Skeggs   2009-12-11  46   * \param cmd command.
6ee738610f41b5 Ben Skeggs   2009-12-11  47   * \param arg user argument.
6ee738610f41b5 Ben Skeggs   2009-12-11  48   * \return zero on success or negative number on failure.
6ee738610f41b5 Ben Skeggs   2009-12-11  49   */
6ee738610f41b5 Ben Skeggs   2009-12-11  50  long nouveau_compat_ioctl(struct file *filp, unsigned int cmd,
6ee738610f41b5 Ben Skeggs   2009-12-11  51  			 unsigned long arg)
6ee738610f41b5 Ben Skeggs   2009-12-11 @52  {
6ee738610f41b5 Ben Skeggs   2009-12-11  53  	unsigned int nr = DRM_IOCTL_NR(cmd);
6ee738610f41b5 Ben Skeggs   2009-12-11  54  	drm_ioctl_compat_t *fn = NULL;
6ee738610f41b5 Ben Skeggs   2009-12-11  55  	int ret;
6ee738610f41b5 Ben Skeggs   2009-12-11  56  
6ee738610f41b5 Ben Skeggs   2009-12-11  57  	if (nr < DRM_COMMAND_BASE)
6ee738610f41b5 Ben Skeggs   2009-12-11  58  		return drm_compat_ioctl(filp, cmd, arg);
6ee738610f41b5 Ben Skeggs   2009-12-11  59  

:::::: The code at line 2 was first introduced by commit
:::::: 6ee738610f41b59733f63718f0bdbcba7d3a3f12 drm/nouveau: Add DRM driver for NVIDIA GPUs

:::::: TO: Ben Skeggs <bskeggs@redhat.com>
:::::: CC: Dave Airlie <airlied@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
