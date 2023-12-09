Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2370780B115
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 01:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbjLIAuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 19:50:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLIAui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 19:50:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD511716;
        Fri,  8 Dec 2023 16:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702083044; x=1733619044;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i9QEEQKqddCQ+SjwoKUw1jGw26KPrfv+qyu4RfjOEkM=;
  b=FpG2UwM8GzwWE7EzumEkSHg2I+uowGOcAZiuyB2dvHhhHZAzUAIclciz
   FfAtOyCNTVDEUZHNKzikTE37uNLZFlFugvt6qG0tYIbujZM/2kMkJ1ujv
   eWauEylIsfEy/2C+rFapggzomm6tXqDCuEXFl7U6M8F6SyNl9NFM15HcY
   E29ft3UkpoO77GFrw7Sj3kWoZxs0oivoqS+mM4XccUp8QqBPWg17ROBaY
   EENigCLzMyqeTINehqazNrZN2LVmiLlp/G84Dt5TvKM5x/OaMsQvw2Yvk
   D0gD3skVZWky/dvxKZuGVg2jOj6tA9u1jG0YDLitSEYRG/kz1p/MqxHvR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="397276169"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="397276169"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2023 16:50:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10918"; a="916136533"
X-IronPort-AV: E=Sophos;i="6.04,262,1695711600"; 
   d="scan'208";a="916136533"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 08 Dec 2023 16:50:40 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rBlYE-000EbZ-2Y;
        Sat, 09 Dec 2023 00:50:38 +0000
Date:   Sat, 9 Dec 2023 08:50:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Umang Jain <umang.jain@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        "Paul J . Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Umang Jain <umang.jain@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] media: i2c: imx335: Support 2592x1940 10-bit mode
Message-ID: <202312090803.2jM0Kj0d-lkp@intel.com>
References: <20231208150756.124720-8-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208150756.124720-8-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Umang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.7-rc4]
[also build test WARNING on linus/master next-20231208]
[cannot apply to media-tree/master linuxtv-media-stage/master sailus-media-tree/streams]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Umang-Jain/media-dt-bindings-media-imx335-Add-supply-bindings/20231208-230953
base:   v6.7-rc4
patch link:    https://lore.kernel.org/r/20231208150756.124720-8-umang.jain%40ideasonboard.com
patch subject: [PATCH v3 7/8] media: i2c: imx335: Support 2592x1940 10-bit mode
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20231209/202312090803.2jM0Kj0d-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231209/202312090803.2jM0Kj0d-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312090803.2jM0Kj0d-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/imx335.c:160: warning: Function parameter or member 'cur_mbus_code' not described in 'imx335'


vim +160 drivers/media/i2c/imx335.c

45d19b5fb9aeab Martina Krasteva 2021-05-27  117  
45d19b5fb9aeab Martina Krasteva 2021-05-27  118  /**
45d19b5fb9aeab Martina Krasteva 2021-05-27  119   * struct imx335 - imx335 sensor device structure
45d19b5fb9aeab Martina Krasteva 2021-05-27  120   * @dev: Pointer to generic device
45d19b5fb9aeab Martina Krasteva 2021-05-27  121   * @client: Pointer to i2c client
45d19b5fb9aeab Martina Krasteva 2021-05-27  122   * @sd: V4L2 sub-device
45d19b5fb9aeab Martina Krasteva 2021-05-27  123   * @pad: Media pad. Only one pad supported
45d19b5fb9aeab Martina Krasteva 2021-05-27  124   * @reset_gpio: Sensor reset gpio
84a97de1949593 Kieran Bingham   2023-12-08  125   * @supplies: Regulator supplies to handle power control
45d19b5fb9aeab Martina Krasteva 2021-05-27  126   * @inclk: Sensor input clock
45d19b5fb9aeab Martina Krasteva 2021-05-27  127   * @ctrl_handler: V4L2 control handler
45d19b5fb9aeab Martina Krasteva 2021-05-27  128   * @link_freq_ctrl: Pointer to link frequency control
45d19b5fb9aeab Martina Krasteva 2021-05-27  129   * @pclk_ctrl: Pointer to pixel clock control
45d19b5fb9aeab Martina Krasteva 2021-05-27  130   * @hblank_ctrl: Pointer to horizontal blanking control
45d19b5fb9aeab Martina Krasteva 2021-05-27  131   * @vblank_ctrl: Pointer to vertical blanking control
45d19b5fb9aeab Martina Krasteva 2021-05-27  132   * @exp_ctrl: Pointer to exposure control
45d19b5fb9aeab Martina Krasteva 2021-05-27  133   * @again_ctrl: Pointer to analog gain control
45d19b5fb9aeab Martina Krasteva 2021-05-27  134   * @vblank: Vertical blanking in lines
45d19b5fb9aeab Martina Krasteva 2021-05-27  135   * @cur_mode: Pointer to current selected sensor mode
45d19b5fb9aeab Martina Krasteva 2021-05-27  136   * @mutex: Mutex for serializing sensor controls
45d19b5fb9aeab Martina Krasteva 2021-05-27  137   */
45d19b5fb9aeab Martina Krasteva 2021-05-27  138  struct imx335 {
45d19b5fb9aeab Martina Krasteva 2021-05-27  139  	struct device *dev;
45d19b5fb9aeab Martina Krasteva 2021-05-27  140  	struct i2c_client *client;
45d19b5fb9aeab Martina Krasteva 2021-05-27  141  	struct v4l2_subdev sd;
45d19b5fb9aeab Martina Krasteva 2021-05-27  142  	struct media_pad pad;
45d19b5fb9aeab Martina Krasteva 2021-05-27  143  	struct gpio_desc *reset_gpio;
84a97de1949593 Kieran Bingham   2023-12-08  144  	struct regulator_bulk_data supplies[ARRAY_SIZE(imx335_supply_name)];
84a97de1949593 Kieran Bingham   2023-12-08  145  
45d19b5fb9aeab Martina Krasteva 2021-05-27  146  	struct clk *inclk;
45d19b5fb9aeab Martina Krasteva 2021-05-27  147  	struct v4l2_ctrl_handler ctrl_handler;
45d19b5fb9aeab Martina Krasteva 2021-05-27  148  	struct v4l2_ctrl *link_freq_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  149  	struct v4l2_ctrl *pclk_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  150  	struct v4l2_ctrl *hblank_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  151  	struct v4l2_ctrl *vblank_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  152  	struct {
45d19b5fb9aeab Martina Krasteva 2021-05-27  153  		struct v4l2_ctrl *exp_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  154  		struct v4l2_ctrl *again_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  155  	};
45d19b5fb9aeab Martina Krasteva 2021-05-27  156  	u32 vblank;
45d19b5fb9aeab Martina Krasteva 2021-05-27  157  	const struct imx335_mode *cur_mode;
45d19b5fb9aeab Martina Krasteva 2021-05-27  158  	struct mutex mutex;
b843d1b4daf24e Umang Jain       2023-12-08  159  	u32 cur_mbus_code;
45d19b5fb9aeab Martina Krasteva 2021-05-27 @160  };
45d19b5fb9aeab Martina Krasteva 2021-05-27  161  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
