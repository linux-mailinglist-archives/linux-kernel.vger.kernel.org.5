Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2B07F3B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 03:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbjKVCLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 21:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbjKVCLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 21:11:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2877181;
        Tue, 21 Nov 2023 18:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700619086; x=1732155086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=joeFRjsVxmWaUuEury+J3PVtroe1ztWzYGGwNVPnXL4=;
  b=AeZZLsxsqGFXFUFvWnO3blwrst3s1f5EEvw4Kj7eAQBExfW+lcCsEi95
   qlDp6Ph9YGO6FJUhcCd5HftE3qS6BCb6sZfLN0jnfwlaHRclP6xbLYviw
   6iADmNk+VSD2E4YJdaDdaeS6DYI9b4ABaUlinXuLJ7N2Zg9O2tTNplOgH
   mavhkKBEmZ40EnoSRCmFVwgVKW0S3bk+YFtGB+IvIqzOgyuqEAG1tzikc
   EODvTW+dnTfbY6qKHvmz4/ZzEYjan5BM+KezCFIehrA008Lh/Ghw2Ntcn
   fWMO8LPVri4FEUEkqqbS+4Xbr5awiuLN6o45wF+NB4rRA67BxmvSasB7G
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="423054598"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="423054598"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 18:11:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="940275290"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="940275290"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 Nov 2023 18:11:18 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5chj-0008X2-0C;
        Wed, 22 Nov 2023 02:11:07 +0000
Date:   Wed, 22 Nov 2023 10:10:23 +0800
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
Subject: Re: [PATCH v2 02/10] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <202311220929.CK5dLmp5-lkp@intel.com>
References: <20231121101844.1161-3-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121101844.1161-3-shiju.jose@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc2 next-20231121]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231121-182247
base:   linus/master
patch link:    https://lore.kernel.org/r/20231121101844.1161-3-shiju.jose%40huawei.com
patch subject: [PATCH v2 02/10] cxl/mbox: Add GET_FEATURE mailbox command
config: alpha-randconfig-r112-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220929.CK5dLmp5-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220929.CK5dLmp5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220929.CK5dLmp5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/cxl/core/mbox.c:1319:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] size_out @@     got restricted __le32 [usertype] count @@
   drivers/cxl/core/mbox.c:1319:31: sparse:     expected unsigned long [usertype] size_out
   drivers/cxl/core/mbox.c:1319:31: sparse:     got restricted __le32 [usertype] count
>> drivers/cxl/core/mbox.c:1341:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] size_out @@     got restricted __le16 [usertype] count @@
   drivers/cxl/core/mbox.c:1341:31: sparse:     expected unsigned long [usertype] size_out
   drivers/cxl/core/mbox.c:1341:31: sparse:     got restricted __le16 [usertype] count
>> drivers/cxl/core/mbox.c:1343:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] min_out @@     got restricted __le16 [usertype] count @@
   drivers/cxl/core/mbox.c:1343:30: sparse:     expected unsigned long [usertype] min_out
   drivers/cxl/core/mbox.c:1343:30: sparse:     got restricted __le16 [usertype] count

vim +1341 drivers/cxl/core/mbox.c

  1330	
  1331	int cxl_get_feature(struct cxl_memdev_state *mds,
  1332			    struct cxl_mbox_get_feat_in *pi, void *feat_out)
  1333	{
  1334		struct cxl_mbox_cmd mbox_cmd;
  1335		int rc;
  1336	
  1337		mbox_cmd = (struct cxl_mbox_cmd) {
  1338			.opcode = CXL_MBOX_OP_GET_FEATURE,
  1339			.size_in = sizeof(*pi),
  1340			.payload_in = pi,
> 1341			.size_out = pi->count,
  1342			.payload_out = feat_out,
> 1343			.min_out = pi->count,
  1344		};
  1345		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
  1346		if (rc < 0)
  1347			return rc;
  1348	
  1349		return 0;
  1350	}
  1351	EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
  1352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
