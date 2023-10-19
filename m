Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDA17CFFCA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbjJSQkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:40:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C84124;
        Thu, 19 Oct 2023 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697733633; x=1729269633;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=B68lb5bc3nlqxKW2HoQvNAzdwFIr+BMgv0ZP+rlvfxo=;
  b=LhvilC3Qg9AxwrA9+1Yqeoirpjyhe/Fmc27Ug9GaQZ41neAjF517lXPf
   opcViqgh/0TXAyb+qJc/+cgnZPEHphDBPkGlEyrMNnWSJdP5QZ9tmqGmu
   M8c4IVDGmqGdWnDx2D+I8rkwyyDXw1XfP8r+DFI0kt75BxSfiX8CuXPek
   l9ibuUaYm8nFJjwtg6o2fml6dWszX4jz38LsjqI+sSuRv+RvftfeMX5pX
   8tFeaiqoc/B835QueXDypu/2VMD0gis0A73JfG1fpO1zFMPlJ0z16Uewg
   2BqwtB2OsmO9oBEw4PKxyJne2Pm750TKfqj1F/OgCkiNYDokUXkPE7PAi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="7864227"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="7864227"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 09:36:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="706900365"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="706900365"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 19 Oct 2023 09:36:16 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtW0L-0002GE-2M;
        Thu, 19 Oct 2023 16:36:13 +0000
Date:   Fri, 20 Oct 2023 00:35:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nitesh Shetty <nj.shetty@samsung.com>,
        Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
        anuj1072538@gmail.com, gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Anuj Gupta <anuj20.g@samsung.com>,
        Vincent Fu <vincent.fu@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v17 12/12] null_blk: add support for copy offload
Message-ID: <202310200001.UU0bBx9w-lkp@intel.com>
References: <20231019110147.31672-13-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019110147.31672-13-nj.shetty@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nitesh,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 213f891525c222e8ed145ce1ce7ae1f47921cb9c]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-and-sysfs-for-copy-offload-support/20231019-200658
base:   213f891525c222e8ed145ce1ce7ae1f47921cb9c
patch link:    https://lore.kernel.org/r/20231019110147.31672-13-nj.shetty%40samsung.com
patch subject: [PATCH v17 12/12] null_blk: add support for copy offload
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310200001.UU0bBx9w-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200001.UU0bBx9w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200001.UU0bBx9w-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/block/null_blk/trace.h:104,
                    from drivers/block/null_blk/main.c:15:
   drivers/block/null_blk/./trace.h: In function 'trace_raw_output_nullb_copy_op':
>> drivers/block/null_blk/./trace.h:91:27: warning: format '%lu' expects argument of type 'long unsigned int', but argument 7 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
      91 |                 TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   drivers/block/null_blk/./trace.h:73:1: note: in expansion of macro 'TRACE_EVENT'
      73 | TRACE_EVENT(nullb_copy_op,
         | ^~~~~~~~~~~
   drivers/block/null_blk/./trace.h:91:17: note: in expansion of macro 'TP_printk'
      91 |                 TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
         |                 ^~~~~~~~~
   In file included from include/trace/trace_events.h:237:
   drivers/block/null_blk/./trace.h:91:68: note: format string is defined here
      91 |                 TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
         |                                                                  ~~^
         |                                                                    |
         |                                                                    long unsigned int
         |                                                                  %u


vim +91 drivers/block/null_blk/./trace.h

    72	
    73	TRACE_EVENT(nullb_copy_op,
    74			TP_PROTO(struct request *req,
    75				 sector_t dst, sector_t src, size_t len),
    76			TP_ARGS(req, dst, src, len),
    77			TP_STRUCT__entry(
    78					 __array(char, disk, DISK_NAME_LEN)
    79					 __field(enum req_op, op)
    80					 __field(sector_t, dst)
    81					 __field(sector_t, src)
    82					 __field(size_t, len)
    83			),
    84			TP_fast_assign(
    85				       __entry->op = req_op(req);
    86				       __assign_disk_name(__entry->disk, req->q->disk);
    87				       __entry->dst = dst;
    88				       __entry->src = src;
    89				       __entry->len = len;
    90			),
  > 91			TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
    92				  __print_disk_name(__entry->disk),
    93				  blk_op_str(__entry->op),
    94				  __entry->dst, __entry->src, __entry->len)
    95	);
    96	#endif /* _TRACE_NULLB_H */
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
