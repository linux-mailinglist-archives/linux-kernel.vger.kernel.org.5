Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2255C7F77A5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbjKXPXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345768AbjKXPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:23:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B78D1723;
        Fri, 24 Nov 2023 07:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700839437; x=1732375437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gIA5DrBHGW7PORw0zQOQIR5B34JDQO/e3P43UiTAklk=;
  b=Z+NaXP1ypefNrTZ0fBPji3wPwUrMj937ps2qI+YP2vsbetYo/vOIUfTt
   /BTxTbxXomPA+sIRoVnDSWLNGDawmVi7Iuhi/TA1scnOig7RlxeuUV48u
   i/o4h8whVUzqMMGMnfH0pTmCsv7i1I/KRZgfWqdARlnE8tAULaqJKWs7W
   58M8iw/m6moNfAm2WAqfWD778v8qfF6zWCvKrp2CSMJEtLyDHpdTxcAMm
   f73bX2y4HK2UdN0YYNP29/e6kXMyxAqeH/NoYyzmandsqm0aGqVcyHCcu
   xqn7FFf/Kam9l69yOaPPNI+UDCx1fKdKI0zVhCeeM/jKGQtN/EHVw1bxb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="5660679"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="5660679"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 07:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="16002367"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 24 Nov 2023 07:23:50 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6Y20-0002wM-16;
        Fri, 24 Nov 2023 15:23:48 +0000
Date:   Fri, 24 Nov 2023 23:23:34 +0800
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
Subject: Re: [PATCH v3 02/11] cxl/mbox: Add GET_FEATURE mailbox command
Message-ID: <202311241607.cZbPFKOR-lkp@intel.com>
References: <20231123174355.1176-3-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123174355.1176-3-shiju.jose@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
patch link:    https://lore.kernel.org/r/20231123174355.1176-3-shiju.jose%40huawei.com
patch subject: [PATCH v3 02/11] cxl/mbox: Add GET_FEATURE mailbox command
config: i386-randconfig-061-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241607.cZbPFKOR-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231124/202311241607.cZbPFKOR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241607.cZbPFKOR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/cxl/core/mbox.c:1317:30: sparse: sparse: cast from restricted __le32
>> drivers/cxl/core/mbox.c:1339:30: sparse: sparse: cast from restricted __le16
   drivers/cxl/core/mbox.c:1341:29: sparse: sparse: cast from restricted __le16

vim +1339 drivers/cxl/core/mbox.c

  1328	
  1329	int cxl_get_feature(struct cxl_memdev_state *mds,
  1330			    struct cxl_mbox_get_feat_in *pi, void *feat_out)
  1331	{
  1332		struct cxl_mbox_cmd mbox_cmd;
  1333		int rc;
  1334	
  1335		mbox_cmd = (struct cxl_mbox_cmd) {
  1336			.opcode = CXL_MBOX_OP_GET_FEATURE,
  1337			.size_in = sizeof(*pi),
  1338			.payload_in = pi,
> 1339			.size_out = (size_t)pi->count,
  1340			.payload_out = feat_out,
  1341			.min_out = (size_t)pi->count,
  1342		};
  1343		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
  1344		if (rc < 0)
  1345			return rc;
  1346	
  1347		return 0;
  1348	}
  1349	EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
  1350	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
