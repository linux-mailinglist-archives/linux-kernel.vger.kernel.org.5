Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206817BD164
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 02:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344502AbjJIAJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 20:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjJIAJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 20:09:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2491A6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696810169; x=1728346169;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IKzOvOU1UbJc+0bjE6jftHdMgIGa4ZnA/jUk75US0Vg=;
  b=NJ024MWuAcP01bTsq8/8kfAn02xQPLBUFW5KE4xGQj6++Uq5VDeV6e/Z
   kHSXLkUSlnvcKwHjeS4mOEESWtciMBEsxMFDMs/ZzZYYV6ujLAmxtAW0r
   kHN6kuud6JtSEoiyp+KjXaCxDyM5mBdNTCISFmQxJwIOzxYo5qXHoOA8S
   IlEJNj00HqwmgvIpANfLbXp6aa7gGSaF6RAq2Tqz/z3aQjLXz8tnkYlc7
   yxsFXoj66JhGhHnXKFWpeDBgLt+EaX7UdEbmdEnCaLDPKOQ0wkW2Ev6tf
   DS1eSqhsJtrt0sGsFbfi24k86fv9GHqbuwa7oeI0hhAnsHMXGNC/rtDpg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="2644837"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="2644837"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2023 17:09:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="926585693"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; 
   d="scan'208";a="926585693"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 08 Oct 2023 17:09:26 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpdps-0005tF-1k;
        Mon, 09 Oct 2023 00:09:24 +0000
Date:   Mon, 9 Oct 2023 08:08:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: fs/ntfs3/frecord.o: warning: objtool: ni_read_frame() falls through
 to next function ni_readpage_cmpr()
Message-ID: <202310090811.VuUeT0nD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   94f6f0550c625fab1f373bb86a6669b45e9748b3
commit: 6fa57d78aa7f212fd7c0de70f5756e18513dcdcf slab: Remove special-casing of const 0 size allocations
date:   11 months ago
config: x86_64-randconfig-015-20231009 (https://download.01.org/0day-ci/archive/20231009/202310090811.VuUeT0nD-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231009/202310090811.VuUeT0nD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310090811.VuUeT0nD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/ntfs3/frecord.o: warning: objtool: ni_read_frame() falls through to next function ni_readpage_cmpr()

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
