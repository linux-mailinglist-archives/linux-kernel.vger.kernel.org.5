Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080C17E6D4D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343523AbjKIPXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:23:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbjKIPXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:23:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D918B30DC;
        Thu,  9 Nov 2023 07:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699543395; x=1731079395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dca00f8u/HRqNH6WddJ2+DC+wgMmjo7ZhH+sIjOxTuI=;
  b=mDafDizY9Z9e859ixzS7YYfRT/mMyXOcEFVGKypNVj8NnmBdaltdaFBJ
   vp2mmHrGn/8YbynRLlHW2YjdDv+2lIZzy9T/W82XhGTjmqU4RourXS+rr
   ZLvIt2xKrGZ0jZV7QCrHtLvy7Pufrnp5jAE/duQS+qCt0+ZyQB3nvPJSF
   BA2x/z/8U4QSeCMQK0H1ZImOIVvUpNyhae6EZs9h3+gpXXAzFrAmZZfbU
   6mckWqQULsgGXjH71VJMV4kOtoRoHwQSxfqV035IdpNJpg5mwMUz1Sfbo
   LvFVmz6ZzSO6K/9A4bJo35exTPCA2EviTIGnxI8Jb3Ky/r7c74q9l5vev
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="2972920"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="2972920"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 07:23:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="907148487"
X-IronPort-AV: E=Sophos;i="6.03,289,1694761200"; 
   d="scan'208";a="907148487"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Nov 2023 07:23:10 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r16s7-0008q8-2g;
        Thu, 09 Nov 2023 15:23:07 +0000
Date:   Thu, 9 Nov 2023 23:22:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jyan Chou <jyanchou@realtek.com>, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, jh80.chung@samsung.com,
        riteshh@codeaurora.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, conor+dt@kernel.org,
        asutoshd@codeaurora.org, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        briannorris@chromium.org, doug@schmorgal.com,
        tonyhuang.sunplus@gmail.com, abel.vesa@linaro.org,
        william.qiu@starfivetech.com, jyanchou@realtek.com
Subject: Re: [PATCH V6][1/4] mmc: solve DMA boundary limitation of CQHCI
 driver
Message-ID: <202311092347.9A8MgzyN-lkp@intel.com>
References: <20231109082043.27147-2-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109082043.27147-2-jyanchou@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyan,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on ulf-hansson-mmc-mirror/next v6.6 next-20231109]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jyan-Chou/mmc-solve-DMA-boundary-limitation-of-CQHCI-driver/20231109-190435
base:   linus/master
patch link:    https://lore.kernel.org/r/20231109082043.27147-2-jyanchou%40realtek.com
patch subject: [PATCH V6][1/4] mmc: solve DMA boundary limitation of CQHCI driver
config: arc-randconfig-002-20231109 (https://download.01.org/0day-ci/archive/20231109/202311092347.9A8MgzyN-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231109/202311092347.9A8MgzyN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311092347.9A8MgzyN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mmc/host/cqhci-core.c: In function 'cqhci_prep_tran_desc':
>> drivers/mmc/host/cqhci-core.c:519:25: error: 'const struct cqhci_host_ops' has no member named 'setup_tran_desc'
     519 |         if (cq_host->ops->setup_tran_desc) {
         |                         ^~
   drivers/mmc/host/cqhci-core.c:520:29: error: 'const struct cqhci_host_ops' has no member named 'setup_tran_desc'
     520 |                 cq_host->ops->setup_tran_desc(data, cq_host, desc, sg_count);
         |                             ^~


vim +519 drivers/mmc/host/cqhci-core.c

   498	
   499	static int cqhci_prep_tran_desc(struct mmc_request *mrq,
   500					struct cqhci_host *cq_host, int tag)
   501	{
   502		struct mmc_data *data = mrq->data;
   503		int i, sg_count, len;
   504		bool end = false;
   505		bool dma64 = cq_host->dma64;
   506		dma_addr_t addr;
   507		u8 *desc;
   508		struct scatterlist *sg;
   509	
   510		sg_count = cqhci_dma_map(mrq->host, mrq);
   511		if (sg_count < 0) {
   512			pr_err("%s: %s: unable to map sg lists, %d\n",
   513					mmc_hostname(mrq->host), __func__, sg_count);
   514			return sg_count;
   515		}
   516	
   517		desc = get_trans_desc(cq_host, tag);
   518	
 > 519		if (cq_host->ops->setup_tran_desc) {
   520			cq_host->ops->setup_tran_desc(data, cq_host, desc, sg_count);
   521			return 0;
   522		}
   523	
   524		for_each_sg(data->sg, sg, sg_count, i) {
   525			addr = sg_dma_address(sg);
   526			len = sg_dma_len(sg);
   527	
   528			if ((i+1) == sg_count)
   529				end = true;
   530			cqhci_set_tran_desc(desc, addr, len, end, dma64);
   531			desc += cq_host->trans_desc_len;
   532		}
   533	
   534		return 0;
   535	}
   536	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
