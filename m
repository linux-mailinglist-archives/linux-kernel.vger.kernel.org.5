Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F3C79E45F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbjIMJ51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjIMJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:57:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D98E198C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694599042; x=1726135042;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RcimD+Ee7KY7q2pyGzOiQd9tjbM8i0AeO2Vq6s6WBFk=;
  b=Gw0u2iv0YqP3mP6+3y2qz31O7UTGi69bCle8xbty6cTKntGqZ115lrAH
   A02mMhdEJnfjJMRiMSnjxtyvWPFwf/LGk8otGsoFuIDJH3LH52/sT6CPb
   h8yMaUlL/8M08mKxdx+VQxUPRfoW3ZA1Bx4w6OiAC2+d53jLSs8M89CGj
   f33l5B4qPYusQ5dNWyb+1OtHJco39aadGv1o+qX+0sOu5V3gKBqdWtm+N
   reEIQkuS6Y/WjjoGbM8xHgi4ptmgxFOP3wRt95lrv/cWAbB1XmkJOhESy
   a9HaRkBUtINLeLkg/X6TPaf5pvCE2J9jdj2BUgm4odhpjtNQ5NylRVVLL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="442645844"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="442645844"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 02:57:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="917769575"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="917769575"
Received: from lkp-server02.sh.intel.com (HELO cf13c67269a2) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 02:57:20 -0700
Received: from kbuild by cf13c67269a2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgMcY-0000Mh-0j;
        Wed, 13 Sep 2023 09:57:18 +0000
Date:   Wed, 13 Sep 2023 17:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: ld: warning: discarding dynamic section .rela.opd
Message-ID: <202309131708.KAZT7dk2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3669558bdf354cd352be955ef2764cde6a9bf5ec
commit: 8ad57add77d352102ba9edd500b00bc851c2e261 powerpc/build: vdso linker warning for orphan sections
date:   3 months ago
config: powerpc64-randconfig-r012-20230901 (https://download.01.org/0day-ci/archive/20230913/202309131708.KAZT7dk2-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131708.KAZT7dk2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131708.KAZT7dk2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> ld: warning: discarding dynamic section .rela.opd

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
