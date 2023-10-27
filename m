Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207B97D9409
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 11:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345581AbjJ0Jn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbjJ0Jn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 05:43:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604959C;
        Fri, 27 Oct 2023 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698399804; x=1729935804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sZSvMj+sMmnuJAD1wIn0COel3298HD5DQCZGy+m8TEk=;
  b=LGn99RrlM4cFlsxyjEpLjNWsP/0Vadx0VcoEwtn9mP6eMI05nr4Gla4F
   B4aIUkUi0m3wsNFKvfMihhOjxgmCkRMNueb+X1n0+UlvPd/sUSXMWGKOZ
   ApVrPUi8rBoeGp2uyw5NX6MUgN2X7kzC3wS4KFPjL/mGNepLKiLQtfWDM
   gA5ngQCnlZSeGQFDE+Dx/WEOnZ52tWn8RgVchiczqacgF5CB2AdXFLEFk
   5qUrGq3itPR6iyJEHpokEEh7htUEfKTbNH5bh8jurxs/dFTjUpDjNXSwv
   TEU9g1ohTeaKMRTxCOiI8LphPRaySOIHpx40od4KL1dy/wYqLBc1SbSQ1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="473983677"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="473983677"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 02:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="736032673"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="736032673"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 27 Oct 2023 02:43:21 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwJN9-000Ahd-29;
        Fri, 27 Oct 2023 09:43:19 +0000
Date:   Fri, 27 Oct 2023 17:42:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: Add driver for Gigabyte AORUS Waterforce AIO
 coolers
Message-ID: <202310271721.sxzJ5Xir-lkp@intel.com>
References: <20231020130212.8919-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020130212.8919-1-savicaleksa83@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aleksa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on linus/master v6.6-rc7 next-20231026]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksa-Savic/hwmon-Add-driver-for-Gigabyte-AORUS-Waterforce-AIO-coolers/20231020-210452
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
patch link:    https://lore.kernel.org/r/20231020130212.8919-1-savicaleksa83%40gmail.com
patch subject: [PATCH] hwmon: Add driver for Gigabyte AORUS Waterforce AIO coolers
reproduce: (https://download.01.org/0day-ci/archive/20231027/202310271721.sxzJ5Xir-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310271721.sxzJ5Xir-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/hwmon/gigabyte_waterforce.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
