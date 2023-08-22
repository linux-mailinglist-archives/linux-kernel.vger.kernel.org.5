Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A21783859
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjHVDNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjHVDNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:13:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EFE185
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692674018; x=1724210018;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vC+tbb1tdnDKJJSL3pzx2jxBfIAcartLQrSyDVFzrgo=;
  b=U/VYzAwXwABq/rWr5uhqqD2I0y18m57sWepM+SJ2iOcrvbrpGkotVxfr
   oEKDm91XPgNQauxyft3b0xrFl5rbSg98ZBpS08sy7WgtLUNvquhF/HByg
   Zj4csCmHyNhsnc+0KefEf3vN7lREb1pAy+CV0RlpOucBX5pLrBNWkr7qs
   W7Gi0VDwsJnUXWFKJurdQYj7oApH7/Hz02UvAv48wxCeXul1lr7SvuYmY
   XWv6BEsgi1K7ES/CEpbT1xSe7v5hfzKK8+277CBgPAGgozgUnm2zLdKVm
   7EzFGAUUrZxLBCmT4eY5E4Vye38vXAuYmVtH5b/KA+1v355o5uVWsDkuC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373735365"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="373735365"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 20:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="729653446"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="729653446"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 21 Aug 2023 20:13:33 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYHpk-0001Hg-1n;
        Tue, 22 Aug 2023 03:13:32 +0000
Date:   Tue, 22 Aug 2023 11:12:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: ERROR: start_text address is c000000000000800, should be
 c000000000000100
Message-ID: <202308221154.lLgdO02O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: 5750121ae7382ebac8d47ce6d68012d6cd1d7926 kbuild: list sub-directories in ./Kbuild
date:   11 months ago
config: powerpc64-randconfig-r031-20230822 (https://download.01.org/0day-ci/archive/20230822/202308221154.lLgdO02O-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221154.lLgdO02O-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221154.lLgdO02O-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ERROR: start_text address is c000000000000800, should be c000000000000100
   ERROR: try to enable LD_HEAD_STUB_CATCH config option
   ERROR: see comments in arch/powerpc/tools/head_check.sh

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
