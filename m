Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96425812C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443543AbjLNKHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443503AbjLNKHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:07:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E781DBD;
        Thu, 14 Dec 2023 02:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702548459; x=1734084459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7nYqpc7DtxTseeDVLSGfvUOGoJe3vkZw3P+N4mPsjNU=;
  b=HReMX5YUR6ibBflkte62aVVnn42pMbS6Eo1iLHNn3WeeS51eGd1fwp4g
   zGf1zcOqKnBSRpG7Lvji1CW8dnBzwfw+L8FxMSFC1xSbefdPpYIIqjnXk
   FMRgs/Ocw1kFkwU8C1rdNMbsNrMi12IBAeBn/Vp79pN7kb7HotOS0cY99
   8m0g5YJjWaLAVStOFIlCuCc8sQAgrrcVoaObh6rg2B+mBXrwcqWmO4jy7
   MhQ2+1eGpFVoVRjPKnpTZu8F0RaN2TIdzuqP0FWxyd8mICrsBnUeogMJf
   AKCBpWFsIhfY+JmiVQreKA9DN3tr/mVC6eEf4gLc863qsil+oym40Lg5i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="461563519"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="461563519"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 02:07:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1105644568"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="1105644568"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 14 Dec 2023 02:07:33 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rDict-000Lsp-0w;
        Thu, 14 Dec 2023 10:07:31 +0000
Date:   Thu, 14 Dec 2023 18:06:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-imx@nxp.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
Message-ID: <202312141726.nPrR7WDt-lkp@intel.com>
References: <20231213092850.1706042-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213092850.1706042-2-sherry.sun@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sherry,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus shawnguo/for-next robh/for-next linus/master v6.7-rc5 next-20231214]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sherry-Sun/PCI-imx6-Add-pci-host-wakeup-support-on-imx-platforms/20231213-173031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20231213092850.1706042-2-sherry.sun%40nxp.com
patch subject: [PATCH V2 1/4] PCI: imx6: Add pci host wakeup support on imx platforms.
config: arm-randconfig-004-20231213 (https://download.01.org/0day-ci/archive/20231214/202312141726.nPrR7WDt-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231214/202312141726.nPrR7WDt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312141726.nPrR7WDt-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pci-imx6.c:1267:13: warning: no previous prototype for function 'host_wake_irq_handler' [-Wmissing-prototypes]
    1267 | irqreturn_t host_wake_irq_handler(int irq, void *priv)
         |             ^
   drivers/pci/controller/dwc/pci-imx6.c:1267:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
    1267 | irqreturn_t host_wake_irq_handler(int irq, void *priv)
         | ^
         | static 
   1 warning generated.


vim +/host_wake_irq_handler +1267 drivers/pci/controller/dwc/pci-imx6.c

  1266	
> 1267	irqreturn_t host_wake_irq_handler(int irq, void *priv)
  1268	{
  1269		struct imx6_pcie *imx6_pcie = priv;
  1270		struct device *dev = imx6_pcie->pci->dev;
  1271	
  1272		/* Notify PM core we are wakeup source */
  1273		pm_wakeup_event(dev, 0);
  1274		pm_system_wakeup();
  1275	
  1276		return IRQ_HANDLED;
  1277	}
  1278	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
