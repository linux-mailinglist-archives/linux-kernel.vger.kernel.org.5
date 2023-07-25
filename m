Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44007760E79
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 11:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjGYJWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 05:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjGYJVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 05:21:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0862D1FDD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690276879; x=1721812879;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=anr+zGDyxyZpRIPnP0EHmo6aP/jhd2ftB2YDGHkf03A=;
  b=SgGLBqLbBLuZWNLXVvlyDRiCsB7nG4NZpPNM0n+Vy8WLzldcNSMG2EJA
   OlE8dbKdt2ikuhXGPUqQPu10L02nsl6iQXcFRorka1ox4NCfjgBuZiYg2
   3JEAzqWMV8FSTjr6oNJOnXuch4NImmDfKMke4xhQIzXeMpzJE7wAY12k6
   ocNgSc8K9XsSkghRP3pf1+q47cwkWnosYFglN3XkhyyZDyj5440Yr26ht
   NTrj1wg2GP/AFnSKIVq7pLSTo48z8f4y/yVRoCNbSHeG840Q3WuhuHEje
   TcqEq5nAiXZkIG2HJnXZLwWICuLaUBaW8H6HWLzt2EOw1KbJd0DObnk9q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="367691788"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367691788"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 02:21:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="761149957"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="761149957"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2023 02:21:18 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOEEH-000AUk-0l;
        Tue, 25 Jul 2023 09:21:17 +0000
Date:   Tue, 25 Jul 2023 17:20:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/kexec/file_load_64.c:939: warning: expecting prototype
 for get_cpu_node_size(). Prototype was for cpu_node_size() instead
Message-ID: <202307251721.bUGcsCeQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0b5547c51827e053cc754db47d3ec3e6c2c451d2
commit: 340a4a9f8773e102cc5ef531665970a686dfa245 powerpc: Take in account addition CPU node when building kexec FDT
date:   8 months ago
config: powerpc-skiroot_defconfig (https://download.01.org/0day-ci/archive/20230725/202307251721.bUGcsCeQ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251721.bUGcsCeQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251721.bUGcsCeQ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/powerpc/kexec/file_load_64.c:939: warning: expecting prototype for get_cpu_node_size(). Prototype was for cpu_node_size() instead


vim +939 arch/powerpc/kexec/file_load_64.c

   931	
   932	/**
   933	 * get_cpu_node_size - Compute the size of a CPU node in the FDT.
   934	 *                     This should be done only once and the value is stored in
   935	 *                     a static variable.
   936	 * Returns the max size of a CPU node in the FDT.
   937	 */
   938	static unsigned int cpu_node_size(void)
 > 939	{
   940		static unsigned int size;
   941		struct device_node *dn;
   942		struct property *pp;
   943	
   944		/*
   945		 * Don't compute it twice, we are assuming that the per CPU node size
   946		 * doesn't change during the system's life.
   947		 */
   948		if (size)
   949			return size;
   950	
   951		dn = of_find_node_by_type(NULL, "cpu");
   952		if (WARN_ON_ONCE(!dn)) {
   953			// Unlikely to happen
   954			return 0;
   955		}
   956	
   957		/*
   958		 * We compute the sub node size for a CPU node, assuming it
   959		 * will be the same for all.
   960		 */
   961		size += strlen(dn->name) + 5;
   962		for_each_property_of_node(dn, pp) {
   963			size += strlen(pp->name);
   964			size += pp->length;
   965		}
   966	
   967		of_node_put(dn);
   968		return size;
   969	}
   970	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
