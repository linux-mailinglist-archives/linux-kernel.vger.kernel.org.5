Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0307FE7DB
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbjK3Dy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjK3Dy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:54:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F219D66;
        Wed, 29 Nov 2023 19:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701316503; x=1732852503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ko+KnnNR5xJSMUoC6K+lQ0mnuMOhszyEdMuVH3KwCmY=;
  b=AugM+YWmDYBpkNTeid3KNouRPmhTAaAegPB/LtXPJQRZxbkaXJGlvPpu
   noGhbJYFmydTJuCUciND2i5u7Jb0UOnAaacCASS29FS2/B7an+WePMUxa
   0QyGgR8M9AXTgzGZfzu+Qtw5nZ7k26zltcFa44jk3pyhnbegNNKx/HFoM
   JqjYZX4m9jC1gNgSvUbjNkJIWf/OxrIuSVq7WaZOq9sljnveA1kykNnzN
   q6IuRza56+T5/HMqLd+R92MghatFYXLpz0EGS2+/qqlOQlD/+R76y0Ijl
   pLhxDnWRMfvn1LzUxUZQMBlsq5bfsw0daec8i5PFtshZVzEK1yTSw4PLw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="459757285"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="459757285"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 19:55:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745488152"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="745488152"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 29 Nov 2023 19:55:00 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8Y8g-0001J8-16;
        Thu, 30 Nov 2023 03:54:58 +0000
Date:   Thu, 30 Nov 2023 11:54:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Haoran Liu <liuhaoran14@163.com>, geert+renesas@glider.be
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        magnus.damm@gmail.com, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haoran Liu <liuhaoran14@163.com>
Subject: Re: [PATCH] [soc/renesas] renesas-soc: Add error handling in
 renesas_soc_init
Message-ID: <202311300814.9jXQLQEU-lkp@intel.com>
References: <20231129143431.34459-1-liuhaoran14@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129143431.34459-1-liuhaoran14@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Haoran,

kernel test robot noticed the following build errors:

[auto build test ERROR on geert-renesas-devel/next]
[also build test ERROR on linus/master v6.7-rc3 next-20231129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Haoran-Liu/renesas-soc-Add-error-handling-in-renesas_soc_init/20231129-225113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git next
patch link:    https://lore.kernel.org/r/20231129143431.34459-1-liuhaoran14%40163.com
patch subject: [PATCH] [soc/renesas] renesas-soc: Add error handling in renesas_soc_init
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231130/202311300814.9jXQLQEU-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311300814.9jXQLQEU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300814.9jXQLQEU-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/soc/renesas/renesas-soc.c:492:11: error: use of undeclared identifier 'dev'
     492 |                 dev_err(dev, "Failed to read model property: %d\n", ret);
         |                         ^
   1 error generated.


vim +/dev +492 drivers/soc/renesas/renesas-soc.c

   447	
   448	static int __init renesas_soc_init(void)
   449	{
   450		struct soc_device_attribute *soc_dev_attr;
   451		unsigned int product, eshi = 0, eslo;
   452		const struct renesas_family *family;
   453		const struct of_device_id *match;
   454		const struct renesas_soc *soc;
   455		const struct renesas_id *id;
   456		void __iomem *chipid = NULL;
   457		const char *rev_prefix = "";
   458		struct soc_device *soc_dev;
   459		struct device_node *np;
   460		const char *soc_id;
   461		int ret;
   462	
   463		match = of_match_node(renesas_socs, of_root);
   464		if (!match)
   465			return -ENODEV;
   466	
   467		soc_id = strchr(match->compatible, ',') + 1;
   468		soc = match->data;
   469		family = soc->family;
   470	
   471		np = of_find_matching_node_and_match(NULL, renesas_ids, &match);
   472		if (np) {
   473			id = match->data;
   474			chipid = of_iomap(np, 0);
   475			of_node_put(np);
   476		} else if (soc->id && family->reg) {
   477			/* Try hardcoded CCCR/PRR fallback */
   478			id = &id_prr;
   479			chipid = ioremap(family->reg, 4);
   480		}
   481	
   482		soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
   483		if (!soc_dev_attr) {
   484			if (chipid)
   485				iounmap(chipid);
   486			return -ENOMEM;
   487		}
   488	
   489		np = of_find_node_by_path("/");
   490		ret = of_property_read_string(np, "model", &soc_dev_attr->machine);
   491		if (ret) {
 > 492			dev_err(dev, "Failed to read model property: %d\n", ret);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
