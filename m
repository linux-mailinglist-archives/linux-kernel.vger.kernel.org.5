Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4567CDC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjJRMyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjJRMyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:54:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21D112
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 05:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697633692; x=1729169692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ObO6PdrWgckIbs2+BDV1VhHagtTJrF8FbQK6Q3qOPhA=;
  b=BYrPoh3Bii0m1X72aQYiYvFonflY+GDjdrdT1O5FbHC7624LGhJ+iWZp
   Dexpox/uE8L+Ct12DX8MOn/zj2Ql+RzH9SW78H5zEtPg8ljFKNe3mynoi
   knJIWHkmEdeRktozGrWv5BwiILBwDP4auN1WaplveY+1kvjMI/7Ufn+2j
   mwAvkJ/WGilXESZZ7AvVkpVOLZTeanuLGlGoMKKM2i/qxBTfCmIw3QKUT
   r4IqQlbpIQtuozSPOMMod36G3xxRTZgBtGS8ycwCA99rsmLt5vYaMR3Ou
   lstjIh9GuaCcU1m/rbiQYfxDsjgMM7sPlZjG6yVcNo2Q7eB7C+mTSE3tW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365354185"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="365354185"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 05:54:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="760209681"
X-IronPort-AV: E=Sophos;i="6.03,235,1694761200"; 
   d="scan'208";a="760209681"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Oct 2023 05:54:49 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qt64V-0000NW-2q;
        Wed, 18 Oct 2023 12:54:47 +0000
Date:   Wed, 18 Oct 2023 20:54:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gerhard Engleder <gerhard@engleder-embedded.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/engleder/tsnep_main.c:884:55: warning:
 'sprintf' may write a terminating nul past the end of the destination
Message-ID: <202310182028.vmDthIUa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   06dc10eae55b5ceabfef287a7e5f16ceea204aa0
commit: 58eaa8abe43a0c20e4b899d51f666393e95e4833 tsnep: Move interrupt from device to queue
date:   1 year, 1 month ago
config: x86_64-randconfig-071-20230917 (https://download.01.org/0day-ci/archive/20231018/202310182028.vmDthIUa-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231018/202310182028.vmDthIUa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310182028.vmDthIUa-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/engleder/tsnep_main.c: In function 'tsnep_request_irq':
>> drivers/net/ethernet/engleder/tsnep_main.c:884:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
     884 |                         sprintf(queue->name, "%s-rx-%d", name,
         |                                                       ^
   drivers/net/ethernet/engleder/tsnep_main.c:884:25: note: 'sprintf' output between 6 and 36 bytes into a destination of size 25
     884 |                         sprintf(queue->name, "%s-rx-%d", name,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     885 |                                 queue->rx->queue_index);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/engleder/tsnep_main.c:881:55: warning: 'sprintf' may write a terminating nul past the end of the destination [-Wformat-overflow=]
     881 |                         sprintf(queue->name, "%s-tx-%d", name,
         |                                                       ^
   drivers/net/ethernet/engleder/tsnep_main.c:881:25: note: 'sprintf' output between 6 and 36 bytes into a destination of size 25
     881 |                         sprintf(queue->name, "%s-tx-%d", name,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     882 |                                 queue->tx->queue_index);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/engleder/tsnep_main.c:878:49: warning: '-txrx-' directive writing 6 bytes into a region of size between 5 and 25 [-Wformat-overflow=]
     878 |                         sprintf(queue->name, "%s-txrx-%d", name,
         |                                                 ^~~~~~
   drivers/net/ethernet/engleder/tsnep_main.c:878:25: note: 'sprintf' output between 8 and 38 bytes into a destination of size 25
     878 |                         sprintf(queue->name, "%s-txrx-%d", name,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     879 |                                 queue->rx->queue_index);
         |                                 ~~~~~~~~~~~~~~~~~~~~~~~


vim +/sprintf +884 drivers/net/ethernet/engleder/tsnep_main.c

   864	
   865	static int tsnep_request_irq(struct tsnep_queue *queue, bool first)
   866	{
   867		const char *name = netdev_name(queue->adapter->netdev);
   868		irq_handler_t handler;
   869		void *dev;
   870		int retval;
   871	
   872		if (first) {
   873			sprintf(queue->name, "%s-mac", name);
   874			handler = tsnep_irq;
   875			dev = queue->adapter;
   876		} else {
   877			if (queue->tx && queue->rx)
 > 878				sprintf(queue->name, "%s-txrx-%d", name,
   879					queue->rx->queue_index);
   880			else if (queue->tx)
   881				sprintf(queue->name, "%s-tx-%d", name,
   882					queue->tx->queue_index);
   883			else
 > 884				sprintf(queue->name, "%s-rx-%d", name,
   885					queue->rx->queue_index);
   886			handler = tsnep_irq_txrx;
   887			dev = queue;
   888		}
   889	
   890		retval = request_irq(queue->irq, handler, 0, queue->name, dev);
   891		if (retval) {
   892			/* if name is empty, then interrupt won't be freed */
   893			memset(queue->name, 0, sizeof(queue->name));
   894		}
   895	
   896		return retval;
   897	}
   898	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
