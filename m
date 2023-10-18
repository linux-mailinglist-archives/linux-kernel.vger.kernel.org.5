Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F0C7CD172
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344244AbjJRAvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbjJRAu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:50:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7954D92;
        Tue, 17 Oct 2023 17:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697590257; x=1729126257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hBCoNzwppuYtIv3HP0cVy+EIKrWqggclGyfBNO0tN+U=;
  b=J1CIECijkai8JE7H3YAWTqSGVNIgLAlegoFwXJ+RuANQJcEpFSfx1W2G
   Ul4lFl6S/fukXfzzuvwompr5iKj9H8KpRdwN4pLZuVaN/FxRUY06E0N36
   oF7pqHdSTxcKjq4DyDB2yLJtoDmJ7W8/JEvfoRo1lyMTzdgUFT3dFILLf
   6kcaSx3Ow+YgsH77TwBjEdhuI2XJjI7ag+tswFGbu5ZHPchze2wbYZedT
   EZ/y8aeuzgLYLqZi7hBKC0KjfGtjqyDsNeT7bk7Fpi1ovD5KXeLPb2Hys
   VObET3xLbzWdRMKWBEYdMsLO0IQHSg4NyLeuwMr0xfPYQnVnIX7TgqktW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="384789516"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="384789516"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 17:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="785672766"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; 
   d="scan'208";a="785672766"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Oct 2023 17:50:54 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsulw-000AI3-2B;
        Wed, 18 Oct 2023 00:50:52 +0000
Date:   Wed, 18 Oct 2023 08:50:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haonan Li <lihaonan1105@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] pata_lagacy: Handle failed ATA timing computation in
 opti82c46x_set_piomode
Message-ID: <202310180858.o7Wjw0A2-lkp@intel.com>
References: <20231017233234.2170437-1-lihaonan1105@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017233234.2170437-1-lihaonan1105@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haonan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haonan-Li/pata_lagacy-Handle-failed-ATA-timing-computation-in-opti82c46x_set_piomode/20231018-073451
base:   linus/master
patch link:    https://lore.kernel.org/r/20231017233234.2170437-1-lihaonan1105%40gmail.com
patch subject: [PATCH] pata_lagacy: Handle failed ATA timing computation in opti82c46x_set_piomode
reproduce: (https://download.01.org/0day-ci/archive/20231018/202310180858.o7Wjw0A2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310180858.o7Wjw0A2-lkp@intel.com/

# many are suggestions rather than must-fix

WARNING:BRACES: braces {} are not necessary for single statement blocks
#31: FILE: drivers/ata/pata_legacy.c:582:
+	if (ata_timing_compute(adev, adev->pio_mode, &t, clock, 1000)) {
+		return;
+	}

WARNING:BRACES: braces {} are not necessary for single statement blocks
#39: FILE: drivers/ata/pata_legacy.c:589:
+		if (ata_timing_compute(pair, pair->pio_mode, &tp, clock, 1000)) {
+			return;
+		}

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
