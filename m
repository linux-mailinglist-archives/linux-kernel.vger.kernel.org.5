Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE5760CA4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjGYIHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjGYIHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:07:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E9F102;
        Tue, 25 Jul 2023 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690272469; x=1721808469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S1C6UZ72UcgoyakEvkbEicyn8aR4o2mt1dR1fFY40UY=;
  b=i7op6SUrw0EmeVUDej1NiTERYr9OBxFbvqE6u5B0mN0N0T0C9h9KSqv1
   iV7d9Twqxxp9uaBf+Zw0xa1So8hMAPKQkw1mbWgzLQZF/x9HdXohR6pei
   TkyPJ+rQWu7IwWVgM5ZOcxzGBkLbpHCCfViwrWlDnIo9KP1zGilaNyRwI
   WEWAB+8o7XIkzQuPHFKZj+X83dKmvXRZqXVg+rl3RsG/rcwkXDZwhlNHI
   uUEj2l4SJVswwc6IREtzJEgQQtwsy+Vz8lC1JbPbs5ZzxbjB2rTxaWqLN
   sv6+A/TV7mrWlY9ZGisEs3sp661BfvnDPlriGCpe/KYCLZaI5SSLeb+nc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="370320072"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="370320072"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 01:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="719961358"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="719961358"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 25 Jul 2023 01:07:43 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOD55-000AS0-02;
        Tue, 25 Jul 2023 08:07:43 +0000
Date:   Tue, 25 Jul 2023 16:07:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Tipton <quic_mdtipton@quicinc.com>, djakov@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_okukatla@quicinc.com,
        quic_viveka@quicinc.com, Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH 2/3] interconnect: Reintroduce icc_get()
Message-ID: <202307251508.Z4w38USw-lkp@intel.com>
References: <20230725012859.18474-3-quic_mdtipton@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725012859.18474-3-quic_mdtipton@quicinc.com>
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

Hi Mike,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.5-rc3 next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mike-Tipton/debugfs-Add-write-support-to-debugfs_create_str/20230725-093242
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20230725012859.18474-3-quic_mdtipton%40quicinc.com
patch subject: [PATCH 2/3] interconnect: Reintroduce icc_get()
config: um-randconfig-m031-20230725 (https://download.01.org/0day-ci/archive/20230725/202307251508.Z4w38USw-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307251508.Z4w38USw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307251508.Z4w38USw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/opp/opp.h:15,
                    from drivers/opp/core.c:23:
>> include/linux/interconnect.h:63:18: warning: no previous prototype for 'icc_get' [-Wmissing-prototypes]
      63 | struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
         |                  ^~~~~~~


vim +/icc_get +63 include/linux/interconnect.h

    62	
  > 63	struct icc_path *icc_get(struct device *dev, const char *src, const char *dst)
    64	{
    65		return NULL;
    66	}
    67	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
