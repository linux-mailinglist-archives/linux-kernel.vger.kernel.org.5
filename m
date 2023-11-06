Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B082E7E1952
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 05:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjKFEFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 23:05:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKFEFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 23:05:30 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBBABF
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 20:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699243527; x=1730779527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L7F5rY6Zj0vKKSUedjqWPKrqKzgauP6Yhp1Zjlw2Rrs=;
  b=kCkyZ8gbUQ06ExkIsZVO1X51P8Dw/8JL+Na90CdpL0AalEX54fzy9YOe
   2QxPuniODiZ6Iq20qGwsH8csRUP+quMSXLu4IuCoiFFej/cEOH53hhsoz
   mRUIy/2C4THwO2q3ouikJFeiY+Q+cwCXbc8XXP9890WJQdFjeBpRD41kH
   1eYuvCYuMUKke9yNHtzxo1smsJoQYZY8jMFq/wy3wvFwOchy/lk3dDUA7
   lQdYJ/oC2p2zhjPMI12PgyauqrtG+Vd+l74bA+CGxxTol31M9NxqrZRA8
   cu6Mr1ARNdARZxVqcVvmTmY4hc3fDFfb9rp+OktovwoSMGKrBaCoHBxi2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="386377953"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="386377953"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 20:05:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093647998"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="1093647998"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 20:05:00 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzqrC-00065D-15;
        Mon, 06 Nov 2023 04:04:58 +0000
Date:   Mon, 6 Nov 2023 12:03:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Tai <james.tai@realtek.com>, linux-kernel@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 4/6] irqchip: Introduce RTD1319D support using the
 Realtek Common Interrupt Controller Driver
Message-ID: <202311061137.FRpoKwcm-lkp@intel.com>
References: <20231102142731.2087245-5-james.tai@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102142731.2087245-5-james.tai@realtek.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master v6.6 next-20231106]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Tai/dt-bindings-interrupt-controller-Add-support-for-Realtek-DHC-SoCs/20231103-074117
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20231102142731.2087245-5-james.tai%40realtek.com
patch subject: [PATCH 4/6] irqchip: Introduce RTD1319D support using the Realtek Common Interrupt Controller Driver
config: i386-randconfig-061-20231106 (https://download.01.org/0day-ci/archive/20231106/202311061137.FRpoKwcm-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311061137.FRpoKwcm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311061137.FRpoKwcm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/irqchip/irq-realtek-rtd1319d.c:172:25: sparse: sparse: symbol 'realtek_intc_rtd1319d_pm_ops' was not declared. Should it be static?

vim +/realtek_intc_rtd1319d_pm_ops +172 drivers/irqchip/irq-realtek-rtd1319d.c

   171	
 > 172	const struct dev_pm_ops realtek_intc_rtd1319d_pm_ops = {
   173		.suspend_noirq = realtek_intc_rtd1319d_suspend,
   174		.resume_noirq = realtek_intc_rtd1319d_resume,
   175	};
   176	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
