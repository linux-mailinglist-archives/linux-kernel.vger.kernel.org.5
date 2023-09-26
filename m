Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831537AF46E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjIZTul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233431AbjIZTuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:50:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CD4A3;
        Tue, 26 Sep 2023 12:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695757833; x=1727293833;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2yuwy3Y57nWqXAlW1YASdDQfdwt4RIuFLba+rx8HU+w=;
  b=ADoBhADvXk+6Qmv5Cy/sOUCIN5Kgxj+e+DA0XWractRfYbciC/+s2qmZ
   1ZO5NYxytLRdpw91aLS2NCsG0DApzaXA5V5XZnldOchD6LWAyZcH5S0A1
   t9iHPCiGcau2KY234zK0r/ymcWO1vxCujeERRIsr29hWhwg89j9mmJnXM
   WfprBpnZdDECbhHWVMqSqln7jyZK690o2c34xDbIFhr/nMO/KZ609Nyi/
   bDJzcwrLMg8Mgf0Pi85liOHVe5vPB8iWCLk8QsId+iLY6qejZp98LZyoi
   EEYQbm+Mg3qnNgwGwFoKPluJbbt9QFIt8F5AE6dJ9VqAP1IXgqhwXR0Un
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445786846"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445786846"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="274191"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 26 Sep 2023 12:50:31 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlE4g-0003Iz-3C;
        Tue, 26 Sep 2023 19:50:27 +0000
Date:   Wed, 27 Sep 2023 03:49:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Dooks <ben@simtec.co.uk>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: dwc2: gadget: Fix a warning when compiling with W=1
Message-ID: <202309270325.uqGsh5Cw-lkp@intel.com>
References: <5cf603809388aa04c9a02bbfe3cf531c20bb043e.1695466447.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cf603809388aa04c9a02bbfe3cf531c20bb043e.1695466447.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/usb-dwc2-gadget-Fix-a-warning-when-compiling-with-W-1/20230923-185559
base:   linus/master
patch link:    https://lore.kernel.org/r/5cf603809388aa04c9a02bbfe3cf531c20bb043e.1695466447.git.christophe.jaillet%40wanadoo.fr
patch subject: [PATCH] usb: dwc2: gadget: Fix a warning when compiling with W=1
config: x86_64-buildonly-randconfig-004-20230927 (https://download.01.org/0day-ci/archive/20230927/202309270325.uqGsh5Cw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270325.uqGsh5Cw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270325.uqGsh5Cw-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/dwc2/gadget.c: In function 'dwc2_hsotg_initep':
>> drivers/usb/dwc2/gadget.c:4804:55: warning: '%u' directive output may be truncated writing between 1 and 10 bytes into a region of size 8 [-Wformat-truncation=]
    4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%u%s", epnum, dir);
         |                                                       ^~
   drivers/usb/dwc2/gadget.c:4804:52: note: directive argument in the range [1, 4294967295]
    4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%u%s", epnum, dir);
         |                                                    ^~~~~~~~
   drivers/usb/dwc2/gadget.c:4804:9: note: 'snprintf' output between 6 and 16 bytes into a destination of size 10
    4804 |         snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%u%s", epnum, dir);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +4804 drivers/usb/dwc2/gadget.c

  4775	
  4776	/**
  4777	 * dwc2_hsotg_initep - initialise a single endpoint
  4778	 * @hsotg: The device state.
  4779	 * @hs_ep: The endpoint to be initialised.
  4780	 * @epnum: The endpoint number
  4781	 * @dir_in: True if direction is in.
  4782	 *
  4783	 * Initialise the given endpoint (as part of the probe and device state
  4784	 * creation) to give to the gadget driver. Setup the endpoint name, any
  4785	 * direction information and other state that may be required.
  4786	 */
  4787	static void dwc2_hsotg_initep(struct dwc2_hsotg *hsotg,
  4788				      struct dwc2_hsotg_ep *hs_ep,
  4789				      unsigned int epnum,
  4790				      bool dir_in)
  4791	{
  4792		char *dir;
  4793	
  4794		if (epnum == 0)
  4795			dir = "";
  4796		else if (dir_in)
  4797			dir = "in";
  4798		else
  4799			dir = "out";
  4800	
  4801		hs_ep->dir_in = dir_in;
  4802		hs_ep->index = epnum;
  4803	
> 4804		snprintf(hs_ep->name, sizeof(hs_ep->name), "ep%u%s", epnum, dir);
  4805	
  4806		INIT_LIST_HEAD(&hs_ep->queue);
  4807		INIT_LIST_HEAD(&hs_ep->ep.ep_list);
  4808	
  4809		/* add to the list of endpoints known by the gadget driver */
  4810		if (epnum)
  4811			list_add_tail(&hs_ep->ep.ep_list, &hsotg->gadget.ep_list);
  4812	
  4813		hs_ep->parent = hsotg;
  4814		hs_ep->ep.name = hs_ep->name;
  4815	
  4816		if (hsotg->params.speed == DWC2_SPEED_PARAM_LOW)
  4817			usb_ep_set_maxpacket_limit(&hs_ep->ep, 8);
  4818		else
  4819			usb_ep_set_maxpacket_limit(&hs_ep->ep,
  4820						   epnum ? 1024 : EP0_MPS_LIMIT);
  4821		hs_ep->ep.ops = &dwc2_hsotg_ep_ops;
  4822	
  4823		if (epnum == 0) {
  4824			hs_ep->ep.caps.type_control = true;
  4825		} else {
  4826			if (hsotg->params.speed != DWC2_SPEED_PARAM_LOW) {
  4827				hs_ep->ep.caps.type_iso = true;
  4828				hs_ep->ep.caps.type_bulk = true;
  4829			}
  4830			hs_ep->ep.caps.type_int = true;
  4831		}
  4832	
  4833		if (dir_in)
  4834			hs_ep->ep.caps.dir_in = true;
  4835		else
  4836			hs_ep->ep.caps.dir_out = true;
  4837	
  4838		/*
  4839		 * if we're using dma, we need to set the next-endpoint pointer
  4840		 * to be something valid.
  4841		 */
  4842	
  4843		if (using_dma(hsotg)) {
  4844			u32 next = DXEPCTL_NEXTEP((epnum + 1) % 15);
  4845	
  4846			if (dir_in)
  4847				dwc2_writel(hsotg, next, DIEPCTL(epnum));
  4848			else
  4849				dwc2_writel(hsotg, next, DOEPCTL(epnum));
  4850		}
  4851	}
  4852	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
