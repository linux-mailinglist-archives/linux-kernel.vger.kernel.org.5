Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F13CE7F0446
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 05:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjKSEJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 23:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjKSEJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 23:09:31 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816EC129
        for <linux-kernel@vger.kernel.org>; Sat, 18 Nov 2023 20:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700366968; x=1731902968;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bRlJWPeLEzBe1bunK/8OwiSb8VMLozlungkaic0RrMo=;
  b=K5Csw4LQAUffpC78N9bNRRalSvn8vayQI4DKFawDqA2mkhWoJioCs6ad
   C1j9ggNYGMpKwR8xQaOvh5paw7aCjjZihzZpoyQPLQtYqDHmVoZv600uj
   R+J5Uh+FRVd3sAV48+U8ijC8f9JBbLzZaj+/YrXcVrYxCZliTw1e5bRjO
   ODbcpmxBYAtbcqD4W1A8+0/+l8allbhIKAB/FL/tLq8/A8iTwNQLYK3ZB
   piKN6yV6X3rK9kCNlmEk4gkPpCHM7CU2CKlMxrNPyfLlpEFTPT1L/pOBj
   RppAcbCJJT+bYzzo2jpGyJAOwZvfPiXsJqe/Zf3y+F1VXjidTODwn7/fE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="13022211"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="13022211"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 20:09:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="715905961"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="715905961"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Nov 2023 20:09:26 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Z7b-0004d5-2I;
        Sun, 19 Nov 2023 04:09:23 +0000
Date:   Sun, 19 Nov 2023 12:09:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: kismet: WARNING: unmet direct dependencies detected for HUGETLBFS
 when selected by PPC_8xx
Message-ID: <202311191143.YRtrYJGw-lkp@intel.com>
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
head:   b8f1fa2419c19c81bc386a6b350879ba54a573e1
commit: f8142cf94d4737ea0c3baffb3b9bad8addcb9b6b hugetlb: make hugetlb depends on SYSFS or SYSCTL
date:   1 year, 2 months ago
config: powerpc-kismet-CONFIG_HUGETLBFS-CONFIG_PPC_8xx-0-0 (https://download.01.org/0day-ci/archive/20231119/202311191143.YRtrYJGw-lkp@intel.com/config)
reproduce: (https://download.01.org/0day-ci/archive/20231119/202311191143.YRtrYJGw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311191143.YRtrYJGw-lkp@intel.com/

kismet warnings: (new ones prefixed by >>)
>> kismet: WARNING: unmet direct dependencies detected for HUGETLBFS when selected by PPC_8xx
   
   WARNING: unmet direct dependencies detected for HUGETLBFS
     Depends on [n]: (X86 || IA64 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS [=y] || BROKEN [=n]) && (SYSFS [=n] || SYSCTL [=n])
     Selected by [y]:
     - PPC_8xx [=y] && <choice>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
