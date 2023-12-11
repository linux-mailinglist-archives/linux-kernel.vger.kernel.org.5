Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE880DAA1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 20:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbjLKTLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 14:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjLKTLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 14:11:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1268D5;
        Mon, 11 Dec 2023 11:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702321898; x=1733857898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yhQd7y9Wdldb9/07q1uo+4kf/Siy+N3pv42fCvdn3Wo=;
  b=U9Bg6zSLFhYLYRlRMzSQZdVaQwGqThd20WEhVLkLMAAZLxG0s2OARepK
   DQgflOGzWkTGsl5N27MH8BTSTKxm2yIz4+Jy1qCKZfDtPsYgharIA7uNw
   wRiJImtojtGvsud2kmp9WQ0Mw/Th41f1UXAmOJ62RBDpxdceNhZNUzfSO
   T0lGkIn8lcFyqq2ta962a9cvX6WyEAQPfTk0OyVa1HlybFw/iMb5ohNdT
   kwfErsyBYhi6z4VxgiA7hM+kO7dUY2+uDSB1Ak7U9oZDAgvAQHrDAB0vQ
   0Bv6kz+6yJkkVHyzMFR+CmTZnqG41UZo3XpAkxzCUiyZggrqJ3WZXuaS6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="391866539"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="391866539"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 11:11:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="916964903"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="916964903"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Dec 2023 11:11:32 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rClgg-000IOw-1u;
        Mon, 11 Dec 2023 19:11:30 +0000
Date:   Tue, 12 Dec 2023 03:11:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xinhu Wu <xinhu.wu@unisoc.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        xinhuwu.unisoc@gmail.com, zhiyong.liu@unisoc.com,
        peak.yang@unisoc.com, teng.zhang1@unisoc.com,
        bruce.chen@unisoc.com, surong.pang@unisoc.com,
        xingxing.luo@unisoc.com, xinhu.wu@unisoc.com
Subject: Re: [PATCH V2 1/2] usb: typec: Support sprd_pmic_typec driver
Message-ID: <202312120233.giTFvDie-lkp@intel.com>
References: <20231211074120.27958-2-xinhu.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211074120.27958-2-xinhu.wu@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xinhu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus robh/for-next westeri-thunderbolt/next linus/master v6.7-rc5 next-20231211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xinhu-Wu/usb-typec-Support-sprd_pmic_typec-driver/20231211-154328
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231211074120.27958-2-xinhu.wu%40unisoc.com
patch subject: [PATCH V2 1/2] usb: typec: Support sprd_pmic_typec driver
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20231212/202312120233.giTFvDie-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312120233.giTFvDie-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120233.giTFvDie-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/typec/sprd_pmic_typec.c:184:10: warning: 16 enumeration values not handled in switch: 'TYPEC_DETACHED_SNK', 'TYPEC_ATTACHWAIT_SNK', 'TYPEC_DETACHED_SRC'... [-Wswitch]
     184 |         switch (sc->state) {
         |                 ^~~~~~~~~
   1 warning generated.


vim +184 drivers/usb/typec/sprd_pmic_typec.c

   173	
   174	static int sprd_pmic_typec_connect(struct sprd_pmic_typec *sc, u32 status)
   175	{
   176		enum typec_data_role data_role = TYPEC_DEVICE;
   177		enum typec_role power_role = TYPEC_SINK;
   178		enum typec_role vconn_role = TYPEC_SINK;
   179		struct typec_partner_desc desc;
   180	
   181		if (sc->partner)
   182			return 0;
   183	
 > 184		switch (sc->state) {
   185		case TYPEC_ATTACHED_SNK:
   186			power_role = TYPEC_SINK;
   187			data_role = TYPEC_DEVICE;
   188			vconn_role = TYPEC_SINK;
   189			break;
   190		case TYPEC_ATTACHED_SRC:
   191			power_role = TYPEC_SOURCE;
   192			data_role = TYPEC_HOST;
   193			vconn_role = TYPEC_SOURCE;
   194			break;
   195		}
   196	
   197		desc.usb_pd = 0;
   198		desc.identity = NULL;
   199		if (sc->state == TYPEC_AUDIO_CABLE)
   200			desc.accessory = TYPEC_ACCESSORY_AUDIO;
   201		else if (sc->state == TYPEC_DEBUG_CABLE)
   202			desc.accessory = TYPEC_ACCESSORY_DEBUG;
   203		else
   204			desc.accessory = TYPEC_ACCESSORY_NONE;
   205	
   206		sc->partner = typec_register_partner(sc->port, &desc);
   207		if (!sc->partner)
   208			return -ENODEV;
   209	
   210		typec_set_pwr_opmode(sc->port, TYPEC_PWR_MODE_USB);
   211		typec_set_pwr_role(sc->port, power_role);
   212		typec_set_data_role(sc->port, data_role);
   213		typec_set_vconn_role(sc->port, vconn_role);
   214	
   215		switch (sc->state) {
   216		case TYPEC_ATTACHED_SNK:
   217			sc->pre_state = TYPEC_ATTACHED_SNK;
   218			/*notify USB, USB PHY, charger, and bc1p2 driver*/
   219			extcon_set_state_sync(sc->edev, EXTCON_USB, true);
   220			break;
   221		case TYPEC_ATTACHED_SRC:
   222			sc->pre_state = TYPEC_ATTACHED_SRC;
   223			/*notify USB, USB PHY driver*/
   224			extcon_set_state_sync(sc->edev, EXTCON_USB_HOST, true);
   225			break;
   226		case TYPEC_AUDIO_CABLE:
   227			/*notify analog audio driver*/
   228			sc->pre_state = TYPEC_AUDIO_CABLE;
   229			extcon_set_state_sync(sc->edev, EXTCON_JACK_HEADPHONE, true);
   230			break;
   231		default:
   232			break;
   233		}
   234	
   235		spin_lock(&sc->lock);
   236		sc->partner_connected = true;
   237		spin_unlock(&sc->lock);
   238		sprd_pmic_typec_set_cc_polarity_role(sc);
   239	
   240		return 0;
   241	}
   242	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
