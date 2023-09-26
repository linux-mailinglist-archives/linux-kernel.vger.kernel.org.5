Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2647AF09B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235258AbjIZQWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbjIZQWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:22:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243C410A;
        Tue, 26 Sep 2023 09:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695745314; x=1727281314;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kOLi+tNVVtaYkWTVX/7AESQkIiZFjfH3RaEZEz2Zfb4=;
  b=OOscPrhyBOcxo1g4MgXCUQfLK6J+EnTXsod5SzOny241DoZbeos92G4r
   B6qAesdf5vdfJCyic0ZHv5ptWby/OGRKh7q/KTBDMAdpHpRpG1Kh/NfJH
   bydlqO7jA0HSKFvMiDRR7F526zCULuKLNyFRTL+xw0gOnOSekn7Sfd5xs
   pFtA5XEX335E6/+ZNpYJnBIavbm7TEdxPUXLc+k2Y3A588oBZFeaF6OyM
   zYMdiRq4XJbJP49EzB8+f2jDoQ5+vOrA7YIhpaoohxA4MU8t1eOFc+n6o
   phyVFe46jPNt/XXdOttwN73dXxXxp4Jf4BXWH1PdiGwMzLj2cqKlXOv3D
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="445739335"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="445739335"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 09:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="814540198"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="814540198"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 26 Sep 2023 09:21:47 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlAoi-000358-2u;
        Tue, 26 Sep 2023 16:21:44 +0000
Date:   Wed, 27 Sep 2023 00:21:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-media@vger.kernel.org,
        Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] media: i2c: gc2145: Galaxy Core GC2145 sensor support
Message-ID: <202309270018.GBMyNvxU-lkp@intel.com>
References: <20230926092825.819229-3-alain.volmat@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926092825.819229-3-alain.volmat@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

kernel test robot noticed the following build warnings:

[auto build test WARNING on media-tree/master]
[also build test WARNING on robh/for-next linus/master v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alain-Volmat/dt-bindings-media-i2c-add-galaxycore-gc2145-dt-bindings/20230926-173518
base:   git://linuxtv.org/media_tree.git master
patch link:    https://lore.kernel.org/r/20230926092825.819229-3-alain.volmat%40foss.st.com
patch subject: [PATCH 2/2] media: i2c: gc2145: Galaxy Core GC2145 sensor support
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230927/202309270018.GBMyNvxU-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270018.GBMyNvxU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270018.GBMyNvxU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/media/i2c/gc2145.c:1140:12: warning: 'gc2145_resume' defined but not used [-Wunused-function]
    1140 | static int gc2145_resume(struct device *dev)
         |            ^~~~~~~~~~~~~
>> drivers/media/i2c/gc2145.c:1129:12: warning: 'gc2145_suspend' defined but not used [-Wunused-function]
    1129 | static int gc2145_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~


vim +/gc2145_resume +1140 drivers/media/i2c/gc2145.c

  1128	
> 1129	static int gc2145_suspend(struct device *dev)
  1130	{
  1131		struct v4l2_subdev *sd = dev_get_drvdata(dev);
  1132		struct gc2145 *gc2145 = to_gc2145(sd);
  1133	
  1134		if (gc2145->streaming)
  1135			gc2145_stop_streaming(gc2145);
  1136	
  1137		return 0;
  1138	}
  1139	
> 1140	static int gc2145_resume(struct device *dev)
  1141	{
  1142		struct v4l2_subdev *sd = dev_get_drvdata(dev);
  1143		struct gc2145 *gc2145 = to_gc2145(sd);
  1144		struct v4l2_subdev_state *state;
  1145		int ret;
  1146	
  1147		if (gc2145->streaming) {
  1148			state = v4l2_subdev_lock_and_get_active_state(sd);
  1149			ret = gc2145_start_streaming(gc2145, state);
  1150			v4l2_subdev_unlock_state(state);
  1151			if (ret)
  1152				goto error;
  1153		}
  1154	
  1155		return 0;
  1156	
  1157	error:
  1158		gc2145_stop_streaming(gc2145);
  1159		gc2145->streaming = false;
  1160	
  1161		return ret;
  1162	}
  1163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
