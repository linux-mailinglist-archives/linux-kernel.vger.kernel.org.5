Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE6B7F3A90
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 01:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234933AbjKVAEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 19:04:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234718AbjKVAEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 19:04:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580F31A2;
        Tue, 21 Nov 2023 16:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700611470; x=1732147470;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KtjrAbyXKalylP4mxnUfIL2egA57NGVYwHyA1wH+6zw=;
  b=HtylT4R5zkPz3Fr2XdAQXJ80JiLDbWibeTQP4R1Q4Oecwflx2v9x3fUs
   CFnwZg6jqaSwghWcVbzrV3OH70bWIbMJHPOWhRmVrc0GWP+UkXMMMo9+v
   TY8RPn4AW9ISs3A9JrFE4xMIAj4SkOXQmTzRL2goLgFziH/68xnncKCgH
   u42PVlbac06kfzeu1ig8OFKApVm/rl7dleYgeCvJvwBq622kmjhkgl0WT
   bgfQ1oNoNWIFM4mHfXzvjxZF2dOL+OV8cQMpFDiukflLd2uUJIXC5T59S
   YlQULnNLrcmzfFbWkwH45OKFgJgd65oHT2IP51qOaOs2d0vX9ALgXkdFW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13499719"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="13499719"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 16:04:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716661035"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="716661035"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 21 Nov 2023 16:04:22 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5aj5-0008Q6-0y;
        Wed, 22 Nov 2023 00:04:19 +0000
Date:   Wed, 22 Nov 2023 08:04:05 +0800
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
Subject: Re: [PATCH v2 01/10] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox
 command
Message-ID: <202311220753.mm74Rat7-lkp@intel.com>
References: <20231121101844.1161-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121101844.1161-2-shiju.jose@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
patch link:    https://lore.kernel.org/r/20231121101844.1161-2-shiju.jose%40huawei.com
patch subject: [PATCH v2 01/10] cxl/mbox: Add GET_SUPPORTED_FEATURES mailbox command
config: alpha-randconfig-r112-20231122 (https://download.01.org/0day-ci/archive/20231122/202311220753.mm74Rat7-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220753.mm74Rat7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220753.mm74Rat7-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/cxl/core/mbox.c:1318:31: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long [usertype] size_out @@     got restricted __le32 [usertype] count @@
   drivers/cxl/core/mbox.c:1318:31: sparse:     expected unsigned long [usertype] size_out
   drivers/cxl/core/mbox.c:1318:31: sparse:     got restricted __le32 [usertype] count

vim +1318 drivers/cxl/core/mbox.c

  1306	
  1307	int cxl_get_supported_features(struct cxl_memdev_state *mds,
  1308							struct cxl_mbox_get_supp_feats_in *pi,
  1309							void *feats_out)
  1310	{
  1311		struct cxl_mbox_cmd mbox_cmd;
  1312		int rc;
  1313	
  1314		mbox_cmd = (struct cxl_mbox_cmd) {
  1315			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
  1316			.size_in = sizeof(*pi),
  1317			.payload_in = pi,
> 1318			.size_out = pi->count,
  1319			.payload_out = feats_out,
  1320			.min_out = sizeof(struct cxl_mbox_get_supp_feats_out),
  1321		};
  1322		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
  1323		if (rc < 0)
  1324			return rc;
  1325	
  1326		return 0;
  1327	}
  1328	EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
  1329	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
