Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781C47F74DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345349AbjKXNWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbjKXNWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:22:05 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5278A8;
        Fri, 24 Nov 2023 05:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832131; x=1732368131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zLBpZsi4EvW4qAY9AV/g6RcsAWxtHMXbFPgMBS5FyFo=;
  b=N83SE/duaDqv0CGmASO7QdP2tnQvN9/hpWaTU1pSFAYg5U8f01qtLvs1
   r5f9gu9tnGSBWS+oOm9vuOcSEi4KldFl/+9IsbsDfW032xepLJnFfm528
   5YlN4VrwrpEA/7aPkcw06X0T9hWYW0MiI7rW/QWsH35RVolnnMGP92Cuu
   mIvuHiNPcYW2h78GFmugkkN1WRZIW0J3U9wUD/mtQsGpLzyMu9Bp4eFWk
   isG4tZiWCotmCriwCrFDxJgSwT0Jq7409uwLW48sGfGkj/8gUvwVw0NSl
   OaAKqrsQjDRvKXQNma6zZeqYWjuVx43SGTCJ1/3TP7uDIHmY1pykfD5dY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="389575407"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="389575407"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:21:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="15632202"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 24 Nov 2023 05:21:33 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6W7e-0002oF-28;
        Fri, 24 Nov 2023 13:21:30 +0000
Date:   Fri, 24 Nov 2023 21:20:15 +0800
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
Subject: Re: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Message-ID: <202311241526.R8n6AibH-lkp@intel.com>
References: <20231123174355.1176-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123174355.1176-2-shiju.jose@huawei.com>
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
[also build test WARNING on linus/master v6.7-rc2 next-20231124]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/shiju-jose-huawei-com/cxl-mbox-Add-GET_SUPPORTED_FEATURES-mailbox-command/20231124-014622
base:   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git for-next
patch link:    https://lore.kernel.org/r/20231123174355.1176-2-shiju.jose%40huawei.com
patch subject: [PATCH v3 01/11] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
config: i386-randconfig-061-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241526.R8n6AibH-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241526.R8n6AibH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241526.R8n6AibH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/core/mbox.c:1317:30: sparse: sparse: cast from restricted __le32

vim +1317 drivers/cxl/core/mbox.c

  1305	
  1306	int cxl_get_supported_features(struct cxl_memdev_state *mds,
  1307							struct cxl_mbox_get_supp_feats_in *pi,
  1308							void *feats_out)
  1309	{
  1310		struct cxl_mbox_cmd mbox_cmd;
  1311		int rc;
  1312	
  1313		mbox_cmd = (struct cxl_mbox_cmd) {
  1314			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
  1315			.size_in = sizeof(*pi),
  1316			.payload_in = pi,
> 1317			.size_out = (size_t)pi->count,
  1318			.payload_out = feats_out,
  1319			.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
  1320		};
  1321		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
  1322		if (rc < 0)
  1323			return rc;
  1324	
  1325		return 0;
  1326	}
  1327	EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
  1328	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
