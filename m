Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BA3783AE1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjHVH3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjHVH3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:29:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D7E1A4
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689384; x=1724225384;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aNqoUFsQMSpzTu3hnVkIVtzbTImW2dUQAvJKCYA4aAg=;
  b=Y6iXifZfuRCat4tg63GQWDHI+VQc7j9zDMj4zlPe/azneBGqh08RakNc
   rA6mSGQrMzQEJFvos/nE3LttNODF5nGofjr8t8/ZPKGDhhi9yXowPF0hG
   8BmTUtpz0ILDV5tzI5dpxqSztc9jSoeQ+3qH+elDrjpwyaIoob7mt7goM
   driVAVjoiUYXeSRW9/Pdf0njWefl6pmpT+PPl//4GH0xNGI7OU17FIvId
   nUAUax2KvajVeAT+OrXv2hKU6wJnBeg2o5pdzWs6YjDL3G9EJ7hh/UcNv
   TWtOXvdYnU7UTAl3ec5Rpz5mHdCLF+zpkWWclVKAmYxe6Z3P7HdgI6xuj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="373777897"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="373777897"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:28:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="806182360"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="806182360"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Aug 2023 00:28:20 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYLo2-0001Vu-1a;
        Tue, 22 Aug 2023 07:28:12 +0000
Date:   Tue, 22 Aug 2023 15:27:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Serge Ayoun <serge.ayoun@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or
 member 'low' not described in 'sgx_calc_section_metric'
Message-ID: <202308221542.11UpkVfp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: e7e0545299d8cb0fd6fe3ba50401b7f5c3937362 x86/sgx: Initialize metadata for Enclave Page Cache (EPC) sections
date:   2 years, 9 months ago
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230822/202308221542.11UpkVfp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308221542.11UpkVfp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308221542.11UpkVfp-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or member 'low' not described in 'sgx_calc_section_metric'
>> arch/x86/kernel/cpu/sgx/main.c:124: warning: Function parameter or member 'high' not described in 'sgx_calc_section_metric'


vim +124 arch/x86/kernel/cpu/sgx/main.c

   117	
   118	/**
   119	 * A section metric is concatenated in a way that @low bits 12-31 define the
   120	 * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
   121	 * metric.
   122	 */
   123	static inline u64 __init sgx_calc_section_metric(u64 low, u64 high)
 > 124	{
   125		return (low & GENMASK_ULL(31, 12)) +
   126		       ((high & GENMASK_ULL(19, 0)) << 32);
   127	}
   128	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
