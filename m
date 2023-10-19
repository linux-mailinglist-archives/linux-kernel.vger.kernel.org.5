Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B007CFDF3
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346301AbjJSPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346325AbjJSPdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:33:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DDE18D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697729596; x=1729265596;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2Z40rGQaojX6+GkIeTG0oClzzBjXurZIcm+e6oHdqJQ=;
  b=jxcvGmr5QG3DUaW8oNlN7uVbhzl60o73hjYkAqVIPtJjOQdIHW0vt8xU
   GjcFGiQOVgmg67IZ1Xgo4/WNK1y7/vrlcKDKDK8oftakgzvRVmpPoFjpV
   SXGmLEEUOd1cIbkp+gz+kI2TcbJe8XsaxCgyPMKI20KzbRpB+JaNBPNFv
   yYY/L8idPbXX1WASCqKnDC7mFZowyIkZovQZ3dWnB+lZIsMSxau3QnAAV
   b4LuYAf7ArA05QepgogH9QT4Dm2pm5lVPemKEaLZbri6IDSJtPK2QgaHJ
   627W/RtUI6KKPMtrvQgs8fU6YXEY3x5tjGnqBWv39fw4wcdB6XNJV1ZN1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="386107896"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="386107896"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 08:33:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="930645181"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="930645181"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 19 Oct 2023 08:33:14 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtV1L-0002DC-30;
        Thu, 19 Oct 2023 15:33:11 +0000
Date:   Thu, 19 Oct 2023 23:33:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bob Pearson <rpearsonhpe@gmail.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array subscript 0
 is outside array bounds of 'struct sg_table[0]'
Message-ID: <202310192300.lurP44yG-lkp@intel.com>
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
head:   dd72f9c7e512da377074d47d990564959b772643
commit: 592627ccbdff0ec6fff00fc761142a76db750dd4 RDMA/rxe: Replace rxe_map and rxe_phys_buf by xarray
date:   9 months ago
config: sparc-randconfig-c023-20211015 (https://download.01.org/0day-ci/archive/20231019/202310192300.lurP44yG-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231019/202310192300.lurP44yG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310192300.lurP44yG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_mr_fill_pages_from_sgt.constprop':
>> drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array subscript 0 is outside array bounds of 'struct sg_table[0]' [-Warray-bounds=]
     106 |         __sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: note: source object is likely at address zero
>> drivers/infiniband/sw/rxe/rxe_mr.c:106:9: warning: array subscript 0 is outside array bounds of 'struct sg_table[0]' [-Warray-bounds=]
   cc1: note: source object is likely at address zero


vim +106 drivers/infiniband/sw/rxe/rxe_mr.c

    98	
    99	static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
   100	{
   101		XA_STATE(xas, &mr->page_list, 0);
   102		struct sg_page_iter sg_iter;
   103		struct page *page;
   104		bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
   105	
 > 106		__sg_page_iter_start(&sg_iter, sgt->sgl, sgt->orig_nents, 0);
   107		if (!__sg_page_iter_next(&sg_iter))
   108			return 0;
   109	
   110		do {
   111			xas_lock(&xas);
   112			while (true) {
   113				page = sg_page_iter_page(&sg_iter);
   114	
   115				if (persistent && !is_pmem_page(page)) {
   116					rxe_dbg_mr(mr, "Page can't be persistent\n");
   117					xas_set_err(&xas, -EINVAL);
   118					break;
   119				}
   120	
   121				xas_store(&xas, page);
   122				if (xas_error(&xas))
   123					break;
   124				xas_next(&xas);
   125				if (!__sg_page_iter_next(&sg_iter))
   126					break;
   127			}
   128			xas_unlock(&xas);
   129		} while (xas_nomem(&xas, GFP_KERNEL));
   130	
   131		return xas_error(&xas);
   132	}
   133	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
