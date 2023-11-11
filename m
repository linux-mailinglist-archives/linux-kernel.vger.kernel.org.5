Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5767E8CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 22:24:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjKKVWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 16:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKVWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 16:22:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C8E324A
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 13:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699737764; x=1731273764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8TJTEj8M98pptCeTla8pXAHqvFIif4xWH6WPh59GeN4=;
  b=Y3ew54YVmjyL131W7pHeyfc+BuKuiU6BwHHKGCTNfQc1HnPLbuMe0ITV
   IaxTAinzBhVxLu6r7ExOVyqTMHSt//wMUI/1JwcJyoc2WBaoYUMR0NxEM
   lbP2L8qL5I8Z4DGKcfcG9YISb4nCe8w86zYmMrXG0q6SMEkJYybvcHs+6
   Q+zmKmUkertYoRNLfBkdXm3wUtZ2ARdRjVLk9nr2l4hRDKO+ZXkkxjx7F
   44qteiKzXtrUvqD4wycDimB1xuTl3LPB1PlZd0viPDMbipoCkcbZNxEZw
   Jk4PIsM+pFqlIdU+8jdSIgOelWHnvJQhdySFrkDIRofO6p4SeOryVjc0t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="380684427"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="380684427"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 13:22:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="740431906"
X-IronPort-AV: E=Sophos;i="6.03,296,1694761200"; 
   d="scan'208";a="740431906"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Nov 2023 13:22:42 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1vRA-000Aly-1l;
        Sat, 11 Nov 2023 21:22:40 +0000
Date:   Sun, 12 Nov 2023 05:22:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Okan Sahin <okan.sahin@analog.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: drivers/regulator/max77857-regulator.c:428:28: sparse: sparse:
 symbol 'max77857_id' was not declared. Should it be static?
Message-ID: <202311120522.0eeVKiUT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
commit: af71cccadecedad3484c2208e2c4fc8eff927d4a regulator: max77857: Add ADI MAX77857/59/MAX77831 Regulator Support
date:   4 months ago
config: i386-randconfig-062-20230912 (https://download.01.org/0day-ci/archive/20231112/202311120522.0eeVKiUT-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231112/202311120522.0eeVKiUT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311120522.0eeVKiUT-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/regulator/max77857-regulator.c:70:22: sparse: sparse: symbol 'max77857_regmap_config' was not declared. Should it be static?
   drivers/regulator/max77857-regulator.c:209:5: sparse: sparse: symbol 'max77859_get_voltage_sel' was not declared. Should it be static?
   drivers/regulator/max77857-regulator.c:221:5: sparse: sparse: symbol 'max77859_set_current_limit' was not declared. Should it be static?
   drivers/regulator/max77857-regulator.c:235:5: sparse: sparse: symbol 'max77859_get_current_limit' was not declared. Should it be static?
>> drivers/regulator/max77857-regulator.c:428:28: sparse: sparse: symbol 'max77857_id' was not declared. Should it be static?
   drivers/regulator/max77857-regulator.c:446:19: sparse: sparse: symbol 'max77857_driver' was not declared. Should it be static?

vim +/max77857_id +428 drivers/regulator/max77857-regulator.c

   427	
 > 428	const struct i2c_device_id max77857_id[] = {
   429		{ "max77831", ID_MAX77831 },
   430		{ "max77857", ID_MAX77857 },
   431		{ "max77859", ID_MAX77859 },
   432		{ "max77859a", ID_MAX77859A },
   433		{ }
   434	};
   435	MODULE_DEVICE_TABLE(i2c, max77857_id);
   436	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
