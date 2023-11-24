Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C000C7F768B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 15:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjKXOkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 09:40:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKXOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 09:40:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B519A2;
        Fri, 24 Nov 2023 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700836816; x=1732372816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iov98Pfu/Lo0+kSE5YHD91PuIN0LLLB4RgAFdj8YkBQ=;
  b=CZgK8Sbr7oJ8lo+ew+ktawgZbAiMhJ23Yerk3A+uT4QGZBiz4AIIITFZ
   vQrTYJ2MrvABNNKAWimsZc7b+mDaUSlQ+e9MYCTMmqD5ngN8FHZ4z/xjm
   EVAcmFET+m4WplK7dzDsKWjbPEOuFRh4DRF8fvFFCoxwyWN13gDQg6j1h
   s8eqQk/FRBxFtXrK+S0nONdg+4+nJ4ozBYRtxG3kTPxU0zbSnzQODSVZC
   EFeaI8KR6FOydZ8ZrWDX0tWiDSWMSxGD1DsMa7ebsLgxcg3zI3e7pgku3
   1zE1O0kkVhEDHc10Oxr0Q55mIS5NittQndbEZ07DbPkR4UJo4aYd1mlaN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="11110379"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="11110379"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 06:40:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="911464635"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="911464635"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2023 06:40:08 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6XLi-0002tg-0P;
        Fri, 24 Nov 2023 14:40:06 +0000
Date:   Fri, 24 Nov 2023 22:39:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     shiju.jose@huawei.com, linux-cxl@vger.kernel.org,
        linux-mm@kvack.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
        dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        dan.j.williams@intel.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@redhat.com,
        Vilas.Sridharan@amd.com, leo.duran@amd.com, Yazen.Ghannam@amd.com,
        rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com,
        Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org,
        lenb@kernel.org, naoya.horiguchi@nec.com, james.morse@arm.com,
        jthoughton@google.com, somasundaram.a@hpe.com,
        erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
        mike.malvestuto@intel.com
Subject: Re: [PATCH v3 11/11] cxl: scrub: sysfs: Add Documentation for CXL
 memory device scrub control attributes
Message-ID: <202311241516.q6nNPm9h-lkp@intel.com>
References: <20231123174355.1176-12-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123174355.1176-12-shiju.jose@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on krzk-mem-ctrl/for-next]
[also build test WARNING on cxl/next linus/master v6.7-rc2 next-20231124]
[cannot apply to cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231124-014622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-next
patch link:    https://lore.kernel.org/r/20231123174355.1176-12-shiju.jose%40huawei.com
patch subject: [PATCH v3 11/11] cxl: scrub: sysfs: Add Documentation for CXL memory device scrub control attributes
reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241516.q6nNPm9h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241516.q6nNPm9h-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: /sys/class/scrub/ is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-cxl-scrub-configure:0  ./Documentation/ABI/testing/sysfs-class-scrub-configure:0
>> Warning: /sys/class/scrub/scrubX/ is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-cxl-scrub-configure:8  ./Documentation/ABI/testing/sysfs-class-scrub-configure:8
>> Warning: /sys/class/scrub/scrubX/name is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-cxl-scrub-configure:16  ./Documentation/ABI/testing/sysfs-class-scrub-configure:16
>> Warning: /sys/class/scrub/scrubX/regionY/ is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-cxl-scrub-configure:23  ./Documentation/ABI/testing/sysfs-class-scrub-configure:23
>> Warning: /sys/class/scrub/scrubX/regionY/enable is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-cxl-scrub-configure:34  ./Documentation/ABI/testing/sysfs-class-scrub-configure:56
>> Warning: /sys/class/scrub/scrubX/regionY/speed is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-cxl-scrub-configure:43  ./Documentation/ABI/testing/sysfs-class-scrub-configure:74
>> Warning: /sys/class/scrub/scrubX/regionY/speed_available is defined 2 times:  ./Documentation/ABI/testing/sysfs-class-cxl-scrub-configure:52  ./Documentation/ABI/testing/sysfs-class-scrub-configure:65

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
