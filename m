Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41867AA0E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbjIUUtj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjIUUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:49:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82315809E;
        Thu, 21 Sep 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695318593; x=1726854593;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Ne+vrsW5UtAXBNbbGZuiUIqq3ylSla3sj1CH7LF+fA=;
  b=mppSSCJfWVdhupr/av+7YMV6WwjSB6DV7MocoSfQELXuGEJ/rVLyCeaB
   Bda198HO87Tn1fPzPgJmNkcf6tUHfd/Pt+IcnVRSJg3mnfIY6/j7Kd0om
   VGiYNOMFYua4YZ9smiqLDr/2bIsNJ0kHdwAdkGPj6rLn6N6tSrAgpLFnq
   emB6SqTABERKcBYxsbiJ91TAMmr8r1XSPYRCg7Efz5PyZhuEAJEB+bAYf
   XvgzBKOt5QO3X1K9TNjoqddS7GupHl20uhkgZBhjlCMqXCn8oO2K7VJDQ
   iPhHCUR48yUjZwfroyPEJ3IYldNJvRxXMX/oLHoG/XKE0qXEABHZpsN+I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="446964126"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="446964126"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2023 04:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="862425479"
X-IronPort-AV: E=Sophos;i="6.03,165,1694761200"; 
   d="scan'208";a="862425479"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 21 Sep 2023 04:26:23 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjHp7-0009uu-2J;
        Thu, 21 Sep 2023 11:26:21 +0000
Date:   Thu, 21 Sep 2023 19:26:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <fancer.lancer@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Richter <rric@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>,
        Punnaiah Choudary Kalluri 
        <punnaiah.choudary.kalluri@xilinx.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 16/20] EDAC/synopsys: Detach Zynq A05 DDRC support to
 separate driver
Message-ID: <202309211954.M7wyhXyv-lkp@intel.com>
References: <20230920191059.28395-17-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920191059.28395-17-fancer.lancer@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.5]
[also build test WARNING on next-20230921]
[cannot apply to linus/master v6.6-rc2 v6.6-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/EDAC-synopsys-Fix-ECC-status-data-and-IRQ-disable-race-condition/20230921-031420
base:   v6.5
patch link:    https://lore.kernel.org/r/20230920191059.28395-17-fancer.lancer%40gmail.com
patch subject: [PATCH v4 16/20] EDAC/synopsys: Detach Zynq A05 DDRC support to separate driver
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20230921/202309211954.M7wyhXyv-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309211954.M7wyhXyv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309211954.M7wyhXyv-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/edac/zynq_edac.c:194: warning: expecting prototype for handle_error(). Prototype was for zynq_handle_error() instead
>> drivers/edac/zynq_edac.c:233: warning: expecting prototype for check_errors(). Prototype was for zynq_check_errors() instead


vim +194 drivers/edac/zynq_edac.c

   185	
   186	/**
   187	 * handle_error - Handle Correctable and Uncorrectable errors.
   188	 * @mci:	EDAC memory controller instance.
   189	 * @p:		Zynq ECC status structure.
   190	 *
   191	 * Handles ECC correctable and uncorrectable errors.
   192	 */
   193	static void zynq_handle_error(struct mem_ctl_info *mci, struct zynq_ecc_status *p)
 > 194	{
   195		struct zynq_edac_priv *priv = mci->pvt_info;
   196		struct zynq_ecc_error_info *pinf;
   197	
   198		if (p->ce_cnt) {
   199			pinf = &p->ceinfo;
   200	
   201			snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
   202				 "Row %d Bank %d Col %d Bit %d Data 0x%08x",
   203				 pinf->row, pinf->bank, pinf->col,
   204				 pinf->bitpos, pinf->data);
   205	
   206			edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
   207					     p->ce_cnt, 0, 0, 0, 0, 0, -1,
   208					     priv->message, "");
   209		}
   210	
   211		if (p->ue_cnt) {
   212			pinf = &p->ueinfo;
   213	
   214			snprintf(priv->message, ZYNQ_EDAC_MSG_SIZE,
   215				 "Row %d Bank %d Col %d",
   216				 pinf->row, pinf->bank, pinf->col);
   217	
   218			edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
   219					     p->ue_cnt, 0, 0, 0, 0, 0, -1,
   220					     priv->message, "");
   221		}
   222	
   223		memset(p, 0, sizeof(*p));
   224	}
   225	
   226	/**
   227	 * check_errors - Check controller for ECC errors.
   228	 * @mci:	EDAC memory controller instance.
   229	 *
   230	 * Check and post ECC errors. Called by the polling thread.
   231	 */
   232	static void zynq_check_errors(struct mem_ctl_info *mci)
 > 233	{
   234		struct zynq_edac_priv *priv = mci->pvt_info;
   235		int status;
   236	
   237		status = zynq_get_error_info(priv);
   238		if (status)
   239			return;
   240	
   241		zynq_handle_error(mci, &priv->stat);
   242	}
   243	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
