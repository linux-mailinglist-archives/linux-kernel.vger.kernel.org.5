Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7530805C65
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346187AbjLERfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLERfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:35:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEDCA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701797716; x=1733333716;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ftp0oM4vEoQyXKRiSUHlM/FZe0BqParop+YuGijBVRs=;
  b=Roo3tGz2DtELgg8bOSlUZlduG+uO7FPvjsHa4UoZ+gbOBC4cwdNd6uCY
   /WYPFFOwcac8NF5jXBsrwgjiWKh4RWorWbM5jlM3+kpcsRvhTHyj+leRB
   T8kyLTt4Pdxlv0nYKgQsA+8Dg1k9qVXzoS7meEIxfVwdEvENR9M7U/rTQ
   4D5xpiuSD5wB87ndk1U7YHJVXt7c+SF6LVi6lyCyLqWd2ZoCTRINt+nfn
   I7nsM4SzyMeIcSk/yc2/safo6UaEDOxtHPPMVt9A8RsrkKVfWoxN2BZq8
   grl5i2J9AMrSA6oU/FybieU2hZw9W21GcGxugVcTttEvX6ADKUUPtF7ye
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="771098"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="771098"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 09:35:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="841550399"
X-IronPort-AV: E=Sophos;i="6.04,252,1695711600"; 
   d="scan'208";a="841550399"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 05 Dec 2023 09:35:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAZK5-0009SW-0k;
        Tue, 05 Dec 2023 17:35:05 +0000
Date:   Wed, 6 Dec 2023 01:34:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jun Yi <yijun@loongson.cn>
Subject: sound/soc/intel/skylake/skl-topology.c:3124:53: sparse: sparse:
 incorrect type in argument 3 (different base types)
Message-ID: <202312060150.4DCFDzUX-lkp@intel.com>
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
head:   bee0e7762ad2c6025b9f5245c040fcc36ef2bde8
commit: a275a82dcd4024c75337db15d59ed039c31e21da LoongArch: Use alternative to optimize libraries
date:   12 months ago
config: loongarch-randconfig-r132-20231203 (https://download.01.org/0day-ci/archive/20231206/202312060150.4DCFDzUX-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060150.4DCFDzUX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312060150.4DCFDzUX-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   sound/soc/intel/skylake/skl-topology.c:2561:68: sparse:     expected unsigned int [usertype] tkn
   sound/soc/intel/skylake/skl-topology.c:2561:68: sparse:     got restricted __le32 [usertype] token
   sound/soc/intel/skylake/skl-topology.c:2562:41: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2562:41: sparse:     expected unsigned int [usertype] val
   sound/soc/intel/skylake/skl-topology.c:2562:41: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2581:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2584:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected int fmt_cfg_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2584:38: sparse:     expected int fmt_cfg_idx
   sound/soc/intel/skylake/skl-topology.c:2584:38: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2588:73: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] caps_size @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2588:73: sparse:     expected unsigned int [usertype] caps_size
   sound/soc/intel/skylake/skl-topology.c:2588:73: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2594:74: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] set_params @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2594:74: sparse:     expected unsigned int [usertype] set_params
   sound/soc/intel/skylake/skl-topology.c:2594:74: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2599:72: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] param_id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2599:72: sparse:     expected unsigned int [usertype] param_id
   sound/soc/intel/skylake/skl-topology.c:2599:72: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2604:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] domain @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2604:33: sparse:     expected unsigned char [usertype] domain
   sound/soc/intel/skylake/skl-topology.c:2604:33: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2610:42: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] dma_buffer_size @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2610:42: sparse:     expected unsigned int [usertype] dma_buffer_size
   sound/soc/intel/skylake/skl-topology.c:2610:42: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2401:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2649:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2649:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2649:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2651:30: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2679:43: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2711:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected int @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:2711:32: sparse:     expected int
   sound/soc/intel/skylake/skl-topology.c:2711:32: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:2707:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2707:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2707:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:2930:13: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2930:13: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2930:13: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2941:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2941:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2941:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:2951:21: sparse: sparse: invalid assignment: +=
   sound/soc/intel/skylake/skl-topology.c:2951:21: sparse:    left side has type int
   sound/soc/intel/skylake/skl-topology.c:2951:21: sparse:    right side has type restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3074:47: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned short [usertype] event_type @@     got restricted __le16 [usertype] event_type @@
   sound/soc/intel/skylake/skl-topology.c:3074:47: sparse:     expected unsigned short [usertype] event_type
   sound/soc/intel/skylake/skl-topology.c:3074:47: sparse:     got restricted __le16 [usertype] event_type
>> sound/soc/intel/skylake/skl-topology.c:3124:53: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned long [usertype] __n @@     got restricted __le32 [usertype] size @@
   sound/soc/intel/skylake/skl-topology.c:3124:53: sparse:     expected unsigned long [usertype] __n
   sound/soc/intel/skylake/skl-topology.c:3124:53: sparse:     got restricted __le32 [usertype] size
   sound/soc/intel/skylake/skl-topology.c:3170:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3143:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3143:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3191:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3221:33: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3264:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3264:29: sparse:     expected unsigned char [usertype] id
   sound/soc/intel/skylake/skl-topology.c:3264:29: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3268:63: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int [usertype] tkn @@     got restricted __le32 [usertype] token @@
   sound/soc/intel/skylake/skl-topology.c:3268:63: sparse:     expected unsigned int [usertype] tkn
   sound/soc/intel/skylake/skl-topology.c:3268:63: sparse:     got restricted __le32 [usertype] token
   sound/soc/intel/skylake/skl-topology.c:3269:49: sparse: sparse: incorrect type in argument 4 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3269:49: sparse:     expected unsigned int [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3269:49: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3262:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3288:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] input_pin_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3288:37: sparse:     expected unsigned char [usertype] input_pin_type
   sound/soc/intel/skylake/skl-topology.c:3288:37: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3292:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] output_pin_type @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3292:38: sparse:     expected unsigned char [usertype] output_pin_type
   sound/soc/intel/skylake/skl-topology.c:3292:38: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3296:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] max_input_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3296:37: sparse:     expected unsigned char [usertype] max_input_pins
   sound/soc/intel/skylake/skl-topology.c:3296:37: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3300:38: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] max_output_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3300:38: sparse:     expected unsigned char [usertype] max_output_pins
   sound/soc/intel/skylake/skl-topology.c:3300:38: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3304:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_resources @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3304:35: sparse:     expected unsigned char [usertype] nr_resources
   sound/soc/intel/skylake/skl-topology.c:3304:35: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3308:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_interfaces @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3308:36: sparse:     expected unsigned char [usertype] nr_interfaces
   sound/soc/intel/skylake/skl-topology.c:3308:36: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3286:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3286:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3286:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3286:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3286:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3286:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3342:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int lib_count @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3342:32: sparse:     expected int lib_count
   sound/soc/intel/skylake/skl-topology.c:3342:32: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3346:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_modules @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3346:33: sparse:     expected unsigned char [usertype] nr_modules
   sound/soc/intel/skylake/skl-topology.c:3346:33: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3361:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static mod_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3361:25: sparse:     expected int static mod_idx
   sound/soc/intel/skylake/skl-topology.c:3361:25: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3370:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse: sparse: cast from restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse: sparse: cast from restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long [usertype] factor1 @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse:     expected unsigned long [usertype] factor1
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse: sparse: cast from restricted __le32
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned long [usertype] factor1 @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse:     expected unsigned long [usertype] factor1
   sound/soc/intel/skylake/skl-topology.c:3376:24: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3383:52: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] count @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3383:52: sparse:     expected unsigned int [usertype] count
   sound/soc/intel/skylake/skl-topology.c:3383:52: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3387:29: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3393:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static astate_cfg_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3393:32: sparse:     expected int static astate_cfg_idx
   sound/soc/intel/skylake/skl-topology.c:3393:32: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3397:51: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] kcps @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3397:51: sparse:     expected unsigned int [usertype] kcps
   sound/soc/intel/skylake/skl-topology.c:3397:51: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3401:54: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] clk_src @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3401:54: sparse:     expected unsigned int [usertype] clk_src
   sound/soc/intel/skylake/skl-topology.c:3401:54: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3416:31: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3417:36: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3424:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] id @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3424:25: sparse:     expected unsigned char [usertype] id
   sound/soc/intel/skylake/skl-topology.c:3424:25: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3425:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static res_val_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3425:29: sparse:     expected int static res_val_idx
   sound/soc/intel/skylake/skl-topology.c:3425:29: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3432:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] fmt_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3432:30: sparse:     expected unsigned char [usertype] fmt_idx
   sound/soc/intel/skylake/skl-topology.c:3432:30: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3433:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected int static intf_val_idx @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3433:30: sparse:     expected int static intf_val_idx
   sound/soc/intel/skylake/skl-topology.c:3433:30: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3454:36: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_input_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3454:36: sparse:     expected unsigned char [usertype] nr_input_pins
   sound/soc/intel/skylake/skl-topology.c:3454:36: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3461:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned char [usertype] nr_output_pins @@     got restricted __le32 [usertype] value @@
   sound/soc/intel/skylake/skl-topology.c:3461:37: sparse:     expected unsigned char [usertype] nr_output_pins
   sound/soc/intel/skylake/skl-topology.c:3461:37: sparse:     got restricted __le32 [usertype] value
   sound/soc/intel/skylake/skl-topology.c:3340:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3340:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3340:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3340:25: sparse: sparse: restricted __le32 degrades to integer
   sound/soc/intel/skylake/skl-topology.c:3340:25: sparse: sparse: restricted __le32 degrades to integer

vim +3124 sound/soc/intel/skylake/skl-topology.c

7a1b749b34e8238 Dharageswari R 2017-05-31  3117  
7a1b749b34e8238 Dharageswari R 2017-05-31  3118  	void *data;
7a1b749b34e8238 Dharageswari R 2017-05-31  3119  
7a1b749b34e8238 Dharageswari R 2017-05-31  3120  	if (ec->priv.size) {
7a1b749b34e8238 Dharageswari R 2017-05-31  3121  		data = devm_kzalloc(dev, sizeof(ec->priv.size), GFP_KERNEL);
7a1b749b34e8238 Dharageswari R 2017-05-31  3122  		if (!data)
7a1b749b34e8238 Dharageswari R 2017-05-31  3123  			return -ENOMEM;
7a1b749b34e8238 Dharageswari R 2017-05-31 @3124  		memcpy(data, ec->priv.data, ec->priv.size);
7a1b749b34e8238 Dharageswari R 2017-05-31  3125  		se->dobj.private = data;
7a1b749b34e8238 Dharageswari R 2017-05-31  3126  	}
7a1b749b34e8238 Dharageswari R 2017-05-31  3127  
7a1b749b34e8238 Dharageswari R 2017-05-31  3128  	return 0;
7a1b749b34e8238 Dharageswari R 2017-05-31  3129  

:::::: The code at line 3124 was first introduced by commit
:::::: 7a1b749b34e8238acae8a039a8f6822f4f4e2061 ASoC: Intel: Skylake: Add enum control for mic selection

:::::: TO: Dharageswari R <dharageswari.r@intel.com>
:::::: CC: Mark Brown <broonie@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
