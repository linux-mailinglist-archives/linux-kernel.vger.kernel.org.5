Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543EA7FE21E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 22:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234470AbjK2Vgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 16:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjK2Vgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 16:36:50 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC3A10C4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 13:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701293817; x=1732829817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mSEs3HiAXgJsTJA8AoIXbmQa5mt0fhUhQ01QHpqAShQ=;
  b=IvzELzgbnj4cNdn2yE9ECzX9Qo2d+cL+jzNj3sFHy/wgkmEK+Xm/ZPAA
   5ah3VauQXKQ14HfK6cM5g+eqMAZTszUr7d36MzBbBjuYjnSO0R2VsYb1e
   i0bnWz6bPdPpWQ6/VyswbbyoCP+iHeK/mctBmCRv1vWJQk9ESVInUkTSa
   7pm4gkEgs6xDFoDIPHRA8rL7TzNDxquM5NSuDzeCUZ5Hc1Zu4qDrA2Z9d
   jaMyL60n0jKMynl6sH/dfqp01UDPel3an3rO8vRMcUHYQTf/X+yhKSJhH
   tkp9D4rgY3WyWiTGgt4YLNcjzcjCE9sVy8j55R8Rb3HRfN3+KnPFK1oyM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="212735"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="212735"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 13:36:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839568516"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="839568516"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Nov 2023 13:36:55 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8SEn-0000qz-02;
        Wed, 29 Nov 2023 21:36:53 +0000
Date:   Thu, 30 Nov 2023 05:36:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/dsa/lantiq_gswip.c:907:44: warning: '%d' directive
 output may be truncated writing between 1 and 10 bytes into a region of size
 6
Message-ID: <202311300155.M0VzROAp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3b47bc037bd44f142ac09848e8d3ecccc726be99
commit: 14fceff4771e51b23b4485b575cf9e5b3414b89b net: dsa: Add Lantiq / Intel DSA driver for vrx200
date:   5 years ago
config: x86_64-randconfig-r015-20230905 (https://download.01.org/0day-ci/archive/20231130/202311300155.M0VzROAp-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231130/202311300155.M0VzROAp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311300155.M0VzROAp-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/dsa/lantiq_gswip.c: In function 'gswip_probe':
>> drivers/net/dsa/lantiq_gswip.c:907:44: warning: '%d' directive output may be truncated writing between 1 and 10 bytes into a region of size 6 [-Wformat-truncation=]
     snprintf(gphyname, sizeof(gphyname), "gphy%d", i);
                                               ^~
   drivers/net/dsa/lantiq_gswip.c:907:39: note: directive argument in the range [0, 2147483647]
     snprintf(gphyname, sizeof(gphyname), "gphy%d", i);
                                          ^~~~~~~~
   drivers/net/dsa/lantiq_gswip.c:907:2: note: 'snprintf' output between 6 and 15 bytes into a destination of size 10
     snprintf(gphyname, sizeof(gphyname), "gphy%d", i);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +907 drivers/net/dsa/lantiq_gswip.c

   897	
   898	static int gswip_gphy_fw_probe(struct gswip_priv *priv,
   899				       struct gswip_gphy_fw *gphy_fw,
   900				       struct device_node *gphy_fw_np, int i)
   901	{
   902		struct device *dev = priv->dev;
   903		u32 gphy_mode;
   904		int ret;
   905		char gphyname[10];
   906	
 > 907		snprintf(gphyname, sizeof(gphyname), "gphy%d", i);
   908	
   909		gphy_fw->clk_gate = devm_clk_get(dev, gphyname);
   910		if (IS_ERR(gphy_fw->clk_gate)) {
   911			dev_err(dev, "Failed to lookup gate clock\n");
   912			return PTR_ERR(gphy_fw->clk_gate);
   913		}
   914	
   915		ret = of_property_read_u32(gphy_fw_np, "reg", &gphy_fw->fw_addr_offset);
   916		if (ret)
   917			return ret;
   918	
   919		ret = of_property_read_u32(gphy_fw_np, "lantiq,gphy-mode", &gphy_mode);
   920		/* Default to GE mode */
   921		if (ret)
   922			gphy_mode = GPHY_MODE_GE;
   923	
   924		switch (gphy_mode) {
   925		case GPHY_MODE_FE:
   926			gphy_fw->fw_name = priv->gphy_fw_name_cfg->fe_firmware_name;
   927			break;
   928		case GPHY_MODE_GE:
   929			gphy_fw->fw_name = priv->gphy_fw_name_cfg->ge_firmware_name;
   930			break;
   931		default:
   932			dev_err(dev, "Unknown GPHY mode %d\n", gphy_mode);
   933			return -EINVAL;
   934		}
   935	
   936		gphy_fw->reset = of_reset_control_array_get_exclusive(gphy_fw_np);
   937		if (IS_ERR(priv->gphy_fw)) {
   938			if (PTR_ERR(priv->gphy_fw) != -EPROBE_DEFER)
   939				dev_err(dev, "Failed to lookup gphy reset\n");
   940			return PTR_ERR(priv->gphy_fw);
   941		}
   942	
   943		return gswip_gphy_fw_load(priv, gphy_fw);
   944	}
   945	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
