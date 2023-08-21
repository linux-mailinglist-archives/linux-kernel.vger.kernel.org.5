Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3C478294F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235011AbjHUMl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbjHUMl0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:41:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC4191
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692621685; x=1724157685;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tKmoTJr2xxEmNxeAl89uE3MNgQRaPZVioNtrsPGIFCM=;
  b=ETFkVRka3pyPGxni7I8yNdIV4hXHMbBDl8EHVsHflQVkf3NHubRI9pNc
   70oNhGGWr7bMt9ci1v1kiSHFhifEq14gowOoSt6YhSWM6KGJhHK3qAMiI
   pgB50ejmt3WAlVqetLkd9aFNS/R86AV6LyxFBNSSRM89VF+x6UKo/wkFX
   jQnAV6KZW65bjCNgKY67hGZgUNT1S++3klKX3o6tJU9Fwq5V8plaTpuzF
   q4dShZlsE3HjnimN85mXZr8+aBJJFWHeo+WpQ6k36+/NybCV8mCiAaDlG
   G6B1Isngkjj/qFVUslfYuo81A+VZtXnkjHXX0uUPipRfyxQ7n6bvmi7uS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353151615"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="353151615"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 05:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="770931538"
X-IronPort-AV: E=Sophos;i="6.01,190,1684825200"; 
   d="scan'208";a="770931538"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Aug 2023 05:41:23 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qY4Di-0000Tu-0r;
        Mon, 21 Aug 2023 12:41:22 +0000
Date:   Mon, 21 Aug 2023 20:40:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Subject: drivers/of/platform.c:35:34: warning: 'of_skipped_node_table'
 defined but not used
Message-ID: <202308212037.YopffWSU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f7757129e3dea336c407551c98f50057c22bb266
commit: 4550fe6370ab01f6b1dff97ceffc284d1f38e70c of: Don't create device for OPP tables
date:   5 years ago
config: sparc64-allnoconfig (https://download.01.org/0day-ci/archive/20230821/202308212037.YopffWSU-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230821/202308212037.YopffWSU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308212037.YopffWSU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/platform.c:35:34: warning: 'of_skipped_node_table' defined but not used [-Wunused-const-variable=]
      35 | static const struct of_device_id of_skipped_node_table[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~
   drivers/of/platform.c:297: warning: Function parameter or member 'lookup' not described in 'of_dev_lookup'
   drivers/of/platform.c:297: warning: Function parameter or member 'np' not described in 'of_dev_lookup'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for COMPAT_BINFMT_ELF
   Depends on [n]: COMPAT [=y] && BINFMT_ELF [=n]
   Selected by [y]:
   - COMPAT [=y] && SPARC64 [=y]


vim +/of_skipped_node_table +35 drivers/of/platform.c

    34	
  > 35	static const struct of_device_id of_skipped_node_table[] = {
    36		{ .compatible = "operating-points-v2", },
    37		{} /* Empty terminated list */
    38	};
    39	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
