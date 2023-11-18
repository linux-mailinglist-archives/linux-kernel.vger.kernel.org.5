Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8274C7EFD08
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjKRBzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjKRBzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:55:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29621AD
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 17:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700272547; x=1731808547;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=z/E5k6YGpLtW63pm/TX6WPtMPYzqGnai09ma/xUhj1s=;
  b=RkFfI5Exft34GW82meIWS3SP5rAvyq7eGOEnHoVvwnjbASuLj83eAoih
   vytNYP1gDCi7R3d3cuTGGhLXRzvqNCP9wM+MZDWPebm0cXbQAaO+6c2E6
   8PbzXeFHwFjx3n+yhinq6YjnAm0thPmuf3qtQVvUtnWMS1jcfiSEyxeVu
   /Nw+GICsGIo+CiVoMiSDUDaZ9wMrvERxXMkJtjXUemMet+xJmScSj9LwG
   HDknsgb7bKTo+sOX0kSIYbumbmG4AkcwMXTSYAjRa21Ajcxw8Ag2lw36/
   Qk979DU0u89SZOks+b3FABZWHUNX47WKKVtaMmhXtXGgXyKst1SQbxIbS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="12950326"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="12950326"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 17:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="939313721"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="939313721"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Nov 2023 17:55:45 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4AYg-0003PT-2g;
        Sat, 18 Nov 2023 01:55:42 +0000
Date:   Sat, 18 Nov 2023 09:55:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marco Elver <elver@google.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: drivers/misc/sgi-gru/grukdump.c:60:17: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202311180934.gY2s81r5-lkp@intel.com>
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
head:   791c8ab095f71327899023223940dd52257a4173
commit: 4ec4190be4cf9cc3e0ccaf5f155a5f9066d18950 kasan, x86: don't rename memintrinsics in uninstrumented files
date:   9 months ago
config: x86_64-randconfig-123-20231118 (https://download.01.org/0day-ci/archive/20231118/202311180934.gY2s81r5-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311180934.gY2s81r5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311180934.gY2s81r5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/misc/sgi-gru/grukdump.c:60:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __user *[addressable] ubuf @@
   drivers/misc/sgi-gru/grukdump.c:60:17: sparse:     expected void const *
   drivers/misc/sgi-gru/grukdump.c:60:17: sparse:     got void [noderef] __user *[addressable] ubuf
   drivers/misc/sgi-gru/grukdump.c:60:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got void [noderef] __user *[addressable] ubuf @@
   drivers/misc/sgi-gru/grukdump.c:60:17: sparse:     expected void const *
   drivers/misc/sgi-gru/grukdump.c:60:17: sparse:     got void [noderef] __user *[addressable] ubuf
>> drivers/misc/sgi-gru/grukdump.c:60:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *p @@     got void [noderef] __user *[addressable] ubuf @@
   drivers/misc/sgi-gru/grukdump.c:60:17: sparse:     expected void *p
   drivers/misc/sgi-gru/grukdump.c:60:17: sparse:     got void [noderef] __user *[addressable] ubuf
   drivers/misc/sgi-gru/grukdump.c:129:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct gru_context_configuration_handle *ubufcch @@     got void [noderef] __user *[assigned] ubuf @@
   drivers/misc/sgi-gru/grukdump.c:129:17: sparse:     expected struct gru_context_configuration_handle *ubufcch
   drivers/misc/sgi-gru/grukdump.c:129:17: sparse:     got void [noderef] __user *[assigned] ubuf
   drivers/misc/sgi-gru/grukdump.c:192:14: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *ubuf @@     got void *[addressable] [assigned] buf @@
   drivers/misc/sgi-gru/grukdump.c:192:14: sparse:     expected void [noderef] __user *ubuf
   drivers/misc/sgi-gru/grukdump.c:192:14: sparse:     got void *[addressable] [assigned] buf
   drivers/misc/sgi-gru/grukdump.c:193:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __user *ubufend @@     got void * @@
   drivers/misc/sgi-gru/grukdump.c:193:17: sparse:     expected void [noderef] __user *ubufend
   drivers/misc/sgi-gru/grukdump.c:193:17: sparse:     got void *

vim +60 drivers/misc/sgi-gru/grukdump.c

9cc9b056ea5160 Jack Steiner 2009-06-17  34  
9cc9b056ea5160 Jack Steiner 2009-06-17  35  static int gru_dump_context_data(void *grubase,
9cc9b056ea5160 Jack Steiner 2009-06-17  36  			struct gru_context_configuration_handle *cch,
b8229bedd1f397 Jack Steiner 2009-12-15  37  			void __user *ubuf, int ctxnum, int dsrcnt,
b8229bedd1f397 Jack Steiner 2009-12-15  38  			int flush_cbrs)
9cc9b056ea5160 Jack Steiner 2009-06-17  39  {
9cc9b056ea5160 Jack Steiner 2009-06-17  40  	void *cb, *cbe, *tfh, *gseg;
9cc9b056ea5160 Jack Steiner 2009-06-17  41  	int i, scr;
9cc9b056ea5160 Jack Steiner 2009-06-17  42  
9cc9b056ea5160 Jack Steiner 2009-06-17  43  	gseg = grubase + ctxnum * GRU_GSEG_STRIDE;
9cc9b056ea5160 Jack Steiner 2009-06-17  44  	cb = gseg + GRU_CB_BASE;
9cc9b056ea5160 Jack Steiner 2009-06-17  45  	cbe = grubase + GRU_CBE_BASE;
9cc9b056ea5160 Jack Steiner 2009-06-17  46  	tfh = grubase + GRU_TFH_BASE;
9cc9b056ea5160 Jack Steiner 2009-06-17  47  
9cc9b056ea5160 Jack Steiner 2009-06-17  48  	for_each_cbr_in_allocation_map(i, &cch->cbr_allocation_map, scr) {
b8229bedd1f397 Jack Steiner 2009-12-15  49  		if (flush_cbrs)
b8229bedd1f397 Jack Steiner 2009-12-15  50  			gru_flush_cache(cb);
9cc9b056ea5160 Jack Steiner 2009-06-17  51  		if (gru_user_copy_handle(&ubuf, cb))
9cc9b056ea5160 Jack Steiner 2009-06-17  52  			goto fail;
9cc9b056ea5160 Jack Steiner 2009-06-17  53  		if (gru_user_copy_handle(&ubuf, tfh + i * GRU_HANDLE_STRIDE))
9cc9b056ea5160 Jack Steiner 2009-06-17  54  			goto fail;
9cc9b056ea5160 Jack Steiner 2009-06-17  55  		if (gru_user_copy_handle(&ubuf, cbe + i * GRU_HANDLE_STRIDE))
9cc9b056ea5160 Jack Steiner 2009-06-17  56  			goto fail;
9cc9b056ea5160 Jack Steiner 2009-06-17  57  		cb += GRU_HANDLE_STRIDE;
9cc9b056ea5160 Jack Steiner 2009-06-17  58  	}
9cc9b056ea5160 Jack Steiner 2009-06-17  59  	if (dsrcnt)
9cc9b056ea5160 Jack Steiner 2009-06-17 @60  		memcpy(ubuf, gseg + GRU_DS_BASE, dsrcnt * GRU_HANDLE_STRIDE);
9cc9b056ea5160 Jack Steiner 2009-06-17  61  	return 0;
9cc9b056ea5160 Jack Steiner 2009-06-17  62  
9cc9b056ea5160 Jack Steiner 2009-06-17  63  fail:
9cc9b056ea5160 Jack Steiner 2009-06-17  64  	return -EFAULT;
9cc9b056ea5160 Jack Steiner 2009-06-17  65  }
9cc9b056ea5160 Jack Steiner 2009-06-17  66  

:::::: The code at line 60 was first introduced by commit
:::::: 9cc9b056ea51608788609d7e26c7db55ef81bb2e gru: dump chiplet state

:::::: TO: Jack Steiner <steiner@sgi.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
