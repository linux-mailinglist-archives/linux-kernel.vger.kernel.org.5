Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABD7A6126
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 13:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjISL2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 07:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjISL2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 07:28:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73A1ED
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 04:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695122888; x=1726658888;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2dAqJ9+gSlvtFbO5qEpMHNqfi35U2zHu3R+qLEw+ZPk=;
  b=Tp+AYePFkzj3bG+PWaN9oGlGXJ4scDQjQtRRnZZEkbFPxE0n8QwTtBsX
   OkZ/cAd9ntNp/rsebqXp8XeMGqsqqhtU0h2PGFuVVZFEDxKXiZ1jsyfSx
   tYHyEQBWD9P8VKHT9FIFrMxoylOZxLfX1WY9/2wa+5yqOfEz7gJ356vrK
   1Ej4BLNEG9Colf0vvkZ4elWhgi8/2xNt1ITsbIAHpS5iOgPsx/GIqW+uE
   7AfAdAB1l62x8r7wLpX2xTv304QpPxOlAHVCN4722UbTVWJulaCSwPJs2
   I7cN/6YbQXhfnXNfZf4JUEZrf0dnpHjGF5RYi3QqRwg02DcSxGglJmAGN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="410843869"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="410843869"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 04:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861502110"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000"; 
   d="scan'208";a="861502110"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 19 Sep 2023 04:28:07 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qiYth-0007He-0T;
        Tue, 19 Sep 2023 11:28:05 +0000
Date:   Tue, 19 Sep 2023 19:27:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: include/linux/dma-mapping.h:416:36: warning: array subscript i is
 outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'}
Message-ID: <202309191958.UBw1cjXk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf0f715623872823a72e451243bbf555d10d032
commit: df8fc4e934c12b906d08050d7779f292b9c5c6b5 kbuild: Enable -fstrict-flex-arrays=3
date:   4 months ago
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20230919/202309191958.UBw1cjXk-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230919/202309191958.UBw1cjXk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309191958.UBw1cjXk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/skbuff.h:28,
                    from include/net/net_namespace.h:43,
                    from include/linux/netdevice.h:38,
                    from drivers/net/ethernet/marvell/sky2.c:18:
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_unmap_skb':
>> include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
     416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/sky2.c:1257:17: note: in expansion of macro 'dma_unmap_page'
    1257 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
         |                 ^~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/marvell/sky2.c:41:
   drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
    2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
         |                         ^~~~~~~~~
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_submit':
>> drivers/net/ethernet/marvell/sky2.c:1202:59: warning: array subscript i is outside array bounds of 'const dma_addr_t[0]' {aka 'const long long unsigned int[]'} [-Warray-bounds=]
    1202 |                 sky2_rx_add(sky2, OP_BUFFER, re->frag_addr[i], PAGE_SIZE);
         |                                              ~~~~~~~~~~~~~^~~
   drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
    2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
         |                         ^~~~~~~~~
   drivers/net/ethernet/marvell/sky2.c: In function 'sky2_rx_map_skb':
>> drivers/net/ethernet/marvell/sky2.c:1222:30: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
    1222 |                 re->frag_addr[i] = skb_frag_dma_map(&pdev->dev, frag, 0,
         |                 ~~~~~~~~~~~~~^~~
   drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
    2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
         |                         ^~~~~~~~~
>> include/linux/dma-mapping.h:416:36: warning: array subscript i is outside array bounds of 'dma_addr_t[0]' {aka 'long long unsigned int[]'} [-Warray-bounds=]
     416 | #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/sky2.c:1233:17: note: in expansion of macro 'dma_unmap_page'
    1233 |                 dma_unmap_page(&pdev->dev, re->frag_addr[i],
         |                 ^~~~~~~~~~~~~~
   drivers/net/ethernet/marvell/sky2.h:2198:25: note: while referencing 'frag_addr'
    2198 |         dma_addr_t      frag_addr[ETH_JUMBO_MTU >> PAGE_SHIFT];
         |                         ^~~~~~~~~


vim +416 include/linux/dma-mapping.h

d9d200bcebc1f6 Marek Szyprowski    2020-05-13  410  
00085f1efa387a Krzysztof Kozlowski 2016-08-03  411  #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
00085f1efa387a Krzysztof Kozlowski 2016-08-03  412  #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
00085f1efa387a Krzysztof Kozlowski 2016-08-03  413  #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
00085f1efa387a Krzysztof Kozlowski 2016-08-03  414  #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
0495c3d367944e Alexander Duyck     2016-12-14  415  #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
0495c3d367944e Alexander Duyck     2016-12-14 @416  #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
ed6ccf10f24bdf Christoph Hellwig   2018-12-26  417  #define dma_get_sgtable(d, t, v, h, s) dma_get_sgtable_attrs(d, t, v, h, s, 0)
ed6ccf10f24bdf Christoph Hellwig   2018-12-26  418  #define dma_mmap_coherent(d, v, c, h, s) dma_mmap_attrs(d, v, c, h, s, 0)
c9eb6172c328dd Christoph Hellwig   2017-08-27  419  

:::::: The code at line 416 was first introduced by commit
:::::: 0495c3d367944e4af053983ff3cdf256b567b053 dma: add calls for dma_map_page_attrs and dma_unmap_page_attrs

:::::: TO: Alexander Duyck <alexander.h.duyck@intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
