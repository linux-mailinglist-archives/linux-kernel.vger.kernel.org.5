Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8261979EDF2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjIMQGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjIMQGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:06:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C44492
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694621206; x=1726157206;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EGfEOxdAYf5EgE3oBsesna+TMXHSoZpHq3Y5tKMSCQE=;
  b=IwfmTKb+MOGJ0AH/vGTnaRhu572oYIFNh/fewS7Do3jIo9vijzHBGjnO
   JQwFOge5/uOGfMAouJHZIL7eG3N11CpLMiHBQiBnjFZJ37qTdjB9dqMaM
   puNnV8nby3wOtV0Q/e7HIACIHPo2K/f8aR6n7DeooDSwgcKDP6H5s0u75
   mlsSN3/yvAycRB6+LZV2ZxddcRqGqY3051E2HGVe+6TFH53NJeGYnelKb
   hxKPOQlt/zM3bkSReINUsUz/0k4Q1x4U3XTG66zlgCNxyEnQc1CTzC+W4
   Y8av8mbpwodEcOyovFAtKqgt9PCELh6SOfAKlGG9lZaL7p1pfm8BmCaNa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="378616286"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="378616286"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 09:04:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="917879675"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="917879675"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Sep 2023 09:04:24 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qgSLl-0000HR-36;
        Wed, 13 Sep 2023 16:04:21 +0000
Date:   Thu, 14 Sep 2023 00:03:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ping Gan <jacky_gam_2001@163.com>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, ping_gan@dell.com,
        jacky_gam_2001@163.com
Subject: Re: [PATCH 2/4] nvmet: Add polling queue task for nvme target
Message-ID: <202309132330.9Vr4qPji-lkp@intel.com>
References: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ping,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6-rc1]
[also build test WARNING on linus/master next-20230913]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Gan/nvmet-Add-nvme-target-polling-queue-task-parameters/20230913-164112
base:   v6.6-rc1
patch link:    https://lore.kernel.org/r/84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001%40163.com
patch subject: [PATCH 2/4] nvmet: Add polling queue task for nvme target
config: x86_64-randconfig-121-20230913 (https://download.01.org/0day-ci/archive/20230913/202309132330.9Vr4qPji-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309132330.9Vr4qPji-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309132330.9Vr4qPji-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/target/polling-queue-thread.c:72:29: sparse: sparse: symbol 'nvmet_pqt_data' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
