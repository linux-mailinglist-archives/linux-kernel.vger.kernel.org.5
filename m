Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC9476F31A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjHCS7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjHCS7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:59:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B32E3AA3;
        Thu,  3 Aug 2023 11:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691089131; x=1722625131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OJrzy2Vu0/03o5sdYpoeYg0tdpHUHZUmPmTND63DoHc=;
  b=amHt/j3pt3qCRZEFk1mDx4/oFzCAD8ANGEZC2B/t4OYFOivNex8tMhu9
   Zt4bvRNJmnAAwgkmLBKmpSfYLPTPLV78tePzb9C9xMfRw3RwY87fSra/o
   Nj1jD8XePCRKgf0AzZCBYiySGhwC058MKLITymGhcjbf4KJBVLs6v1/0Q
   5L+WfZwCQ/NS4fusv2hgSVNGcGEQ5qeQI1ZeQkZxszDhDSTgIMEx6XIe/
   YZuku8/OqnjK+/SXVNFeSWh6+0gJiuHWgzLCfLsTxgFX63hvHctiHvRPh
   /X3tyKvdJ0+vBhOirBG6ZRei1L2sU6cQ+8zINvPYUHpFt9hl+BFf59GYE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="436291586"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="436291586"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 11:58:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10791"; a="819798157"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="819798157"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Aug 2023 11:58:46 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRdX3-0002IV-0X;
        Thu, 03 Aug 2023 18:58:45 +0000
Date:   Fri, 4 Aug 2023 02:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>,
        Ming Lei <ming.lei@redhat.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Christoph Hellwig <hch@infradead.org>, gost.dev@samsung.com,
        linux-block@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <jth@kernel.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 3/3] ublk: enable zoned storage support
Message-ID: <202308040229.pFTUh2cG-lkp@intel.com>
References: <20230803140701.18515-4-nmi@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803140701.18515-4-nmi@metaspace.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4]

url:    https://github.com/intel-lab-lkp/linux/commits/Andreas-Hindborg-Samsung/ublk-add-helper-to-check-if-device-supports-user-copy/20230803-224003
base:   5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
patch link:    https://lore.kernel.org/r/20230803140701.18515-4-nmi%40metaspace.dk
patch subject: [PATCH v10 3/3] ublk: enable zoned storage support
config: sh-randconfig-r024-20230731 (https://download.01.org/0day-ci/archive/20230804/202308040229.pFTUh2cG-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230804/202308040229.pFTUh2cG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308040229.pFTUh2cG-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/block/ublk_drv.c: In function 'ublk_alloc_report_buffer':
>> drivers/block/ublk_drv.c:281:23: error: implicit declaration of function '__vmalloc'; did you mean '__kmalloc'? [-Werror=implicit-function-declaration]
     281 |                 buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
         |                       ^~~~~~~~~
         |                       __kmalloc
>> drivers/block/ublk_drv.c:281:21: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     281 |                 buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
         |                     ^
   cc1: some warnings being treated as errors


vim +281 drivers/block/ublk_drv.c

   264	
   265	/* Based on virtblk_alloc_report_buffer */
   266	static void *ublk_alloc_report_buffer(struct ublk_device *ublk,
   267					      unsigned int nr_zones, size_t *buflen)
   268	{
   269		struct request_queue *q = ublk->ub_disk->queue;
   270		size_t bufsize;
   271		void *buf;
   272	
   273		nr_zones = min_t(unsigned int, nr_zones,
   274				 ublk->ub_disk->nr_zones);
   275	
   276		bufsize = nr_zones * sizeof(struct blk_zone);
   277		bufsize =
   278			min_t(size_t, bufsize, queue_max_hw_sectors(q) << SECTOR_SHIFT);
   279	
   280		while (bufsize >= sizeof(struct blk_zone)) {
 > 281			buf = __vmalloc(bufsize, GFP_KERNEL | __GFP_NORETRY);
   282			if (buf) {
   283				*buflen = bufsize;
   284				return buf;
   285			}
   286			bufsize >>= 1;
   287		}
   288	
   289		*buflen = 0;
   290		return NULL;
   291	}
   292	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
