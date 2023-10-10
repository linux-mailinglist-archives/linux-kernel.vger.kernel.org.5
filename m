Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303C27BF1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376434AbjJJELV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJELS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:11:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585E9B7;
        Mon,  9 Oct 2023 21:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696911073; x=1728447073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uiUhRmSUyMde76CG1TEpnOQjwaFO/VghcBTC76PZpG8=;
  b=QDEJHv9iJ70tR2bk6mMzUDGYcB1M4zeaohkoaPCofGJiMu1T5AbK8F6q
   HGx/UvbP/N/+fWctZwlm4EMjmpZNQGht1GFMszzIKAeqxiFfeJ5vyPzah
   8IZ/9h53ms2Vib1y40NtkBg+5CzQP1o+wkReLuGENdjPglk2HNs3XQcdM
   0pGc+equqKMh4upBialFF9obKUb+IKRLZAVktoVnJKGFf8bsFzrNExDJ3
   ajvmSKTQEmYlcnvrLWWKNmAAU8QSEZKInfPLXaa8on0I7PHknLRmoXySR
   JXMIIi6Dr1QlHwMIcrE58xVKMC5ce3gdyyVoNO0Ej8n4MyXZBhOetovGK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="387142975"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="387142975"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 21:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823624534"
X-IronPort-AV: E=Sophos;i="6.03,211,1694761200"; 
   d="scan'208";a="823624534"
Received: from lkp-server02.sh.intel.com (HELO 4ed589823ba4) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Oct 2023 21:11:10 -0700
Received: from kbuild by 4ed589823ba4 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qq45L-000152-2B;
        Tue, 10 Oct 2023 04:11:07 +0000
Date:   Tue, 10 Oct 2023 12:10:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] media: i2c: imx335: Enable regulator supplies
Message-ID: <202310101224.43dpo3Ng-lkp@intel.com>
References: <20231010005126.3425444-3-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010005126.3425444-3-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on sailus-media-tree/streams linus/master v6.6-rc5 next-20231009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kieran-Bingham/media-dt-bindings-media-imx335-Add-supply-bindings/20231010-085313
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20231010005126.3425444-3-kieran.bingham%40ideasonboard.com
patch subject: [PATCH 2/5] media: i2c: imx335: Enable regulator supplies
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231010/202310101224.43dpo3Ng-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231010/202310101224.43dpo3Ng-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310101224.43dpo3Ng-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/imx335.c:159: warning: Function parameter or member 'supplies' not described in 'imx335'


vim +159 drivers/media/i2c/imx335.c

45d19b5fb9aeab Martina Krasteva 2021-05-27  116  
45d19b5fb9aeab Martina Krasteva 2021-05-27  117  /**
45d19b5fb9aeab Martina Krasteva 2021-05-27  118   * struct imx335 - imx335 sensor device structure
45d19b5fb9aeab Martina Krasteva 2021-05-27  119   * @dev: Pointer to generic device
45d19b5fb9aeab Martina Krasteva 2021-05-27  120   * @client: Pointer to i2c client
45d19b5fb9aeab Martina Krasteva 2021-05-27  121   * @sd: V4L2 sub-device
45d19b5fb9aeab Martina Krasteva 2021-05-27  122   * @pad: Media pad. Only one pad supported
45d19b5fb9aeab Martina Krasteva 2021-05-27  123   * @reset_gpio: Sensor reset gpio
45d19b5fb9aeab Martina Krasteva 2021-05-27  124   * @inclk: Sensor input clock
45d19b5fb9aeab Martina Krasteva 2021-05-27  125   * @ctrl_handler: V4L2 control handler
45d19b5fb9aeab Martina Krasteva 2021-05-27  126   * @link_freq_ctrl: Pointer to link frequency control
45d19b5fb9aeab Martina Krasteva 2021-05-27  127   * @pclk_ctrl: Pointer to pixel clock control
45d19b5fb9aeab Martina Krasteva 2021-05-27  128   * @hblank_ctrl: Pointer to horizontal blanking control
45d19b5fb9aeab Martina Krasteva 2021-05-27  129   * @vblank_ctrl: Pointer to vertical blanking control
45d19b5fb9aeab Martina Krasteva 2021-05-27  130   * @exp_ctrl: Pointer to exposure control
45d19b5fb9aeab Martina Krasteva 2021-05-27  131   * @again_ctrl: Pointer to analog gain control
45d19b5fb9aeab Martina Krasteva 2021-05-27  132   * @vblank: Vertical blanking in lines
45d19b5fb9aeab Martina Krasteva 2021-05-27  133   * @cur_mode: Pointer to current selected sensor mode
45d19b5fb9aeab Martina Krasteva 2021-05-27  134   * @mutex: Mutex for serializing sensor controls
45d19b5fb9aeab Martina Krasteva 2021-05-27  135   * @streaming: Flag indicating streaming state
45d19b5fb9aeab Martina Krasteva 2021-05-27  136   */
45d19b5fb9aeab Martina Krasteva 2021-05-27  137  struct imx335 {
45d19b5fb9aeab Martina Krasteva 2021-05-27  138  	struct device *dev;
45d19b5fb9aeab Martina Krasteva 2021-05-27  139  	struct i2c_client *client;
45d19b5fb9aeab Martina Krasteva 2021-05-27  140  	struct v4l2_subdev sd;
45d19b5fb9aeab Martina Krasteva 2021-05-27  141  	struct media_pad pad;
45d19b5fb9aeab Martina Krasteva 2021-05-27  142  	struct gpio_desc *reset_gpio;
15931cfe0b52d1 Kieran Bingham   2023-10-10  143  	struct regulator_bulk_data supplies[IMX335_NUM_SUPPLIES];
15931cfe0b52d1 Kieran Bingham   2023-10-10  144  
45d19b5fb9aeab Martina Krasteva 2021-05-27  145  	struct clk *inclk;
45d19b5fb9aeab Martina Krasteva 2021-05-27  146  	struct v4l2_ctrl_handler ctrl_handler;
45d19b5fb9aeab Martina Krasteva 2021-05-27  147  	struct v4l2_ctrl *link_freq_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  148  	struct v4l2_ctrl *pclk_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  149  	struct v4l2_ctrl *hblank_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  150  	struct v4l2_ctrl *vblank_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  151  	struct {
45d19b5fb9aeab Martina Krasteva 2021-05-27  152  		struct v4l2_ctrl *exp_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  153  		struct v4l2_ctrl *again_ctrl;
45d19b5fb9aeab Martina Krasteva 2021-05-27  154  	};
45d19b5fb9aeab Martina Krasteva 2021-05-27  155  	u32 vblank;
45d19b5fb9aeab Martina Krasteva 2021-05-27  156  	const struct imx335_mode *cur_mode;
45d19b5fb9aeab Martina Krasteva 2021-05-27  157  	struct mutex mutex;
45d19b5fb9aeab Martina Krasteva 2021-05-27  158  	bool streaming;
45d19b5fb9aeab Martina Krasteva 2021-05-27 @159  };
45d19b5fb9aeab Martina Krasteva 2021-05-27  160  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
