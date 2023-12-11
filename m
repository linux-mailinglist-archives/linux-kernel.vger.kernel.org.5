Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FF080D92E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345066AbjLKSva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjLKSv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:51:29 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E967AC;
        Mon, 11 Dec 2023 10:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702320696; x=1733856696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p9APTF5tzyihpipwQ2ls9ki52nr/EaMfY0uN9x4+UeA=;
  b=i+iQ6+iA4t4q6Ydyu9vfSpOn+ElUvM8LapVwTtCDg8+vc9JCXctEGip0
   E0DhdKcUiwmS9lpylxFFwrrNqGo1fR3OO61kobWdlEqvUC5KvM62JEv0w
   bYQeVnLlHxROmwRsRvr8QusWSUdYplv99vpUshS62OaCW8KcEm6FioQuh
   o9TAbA0ln+Wtbrg62Agro9LHm0D+fQGukZ58e/imQ4RzGMIYGwLt1cqO7
   fWvuHDR4Ca3CBmX/DVmEqkLYgg36NA2BuaxVWAPVwbFg0Nkh+FtXSzGxN
   l0HFeMlcTZvA8/LnFabg6vC2KzJzezjp6kuIfnzuu6u0exJ7d6PzHFC58
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1533553"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1533553"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:51:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1104578088"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1104578088"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Dec 2023 10:51:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rClNI-000INi-0D;
        Mon, 11 Dec 2023 18:51:28 +0000
Date:   Tue, 12 Dec 2023 02:51:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xinhu Wu <xinhu.wu@unisoc.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com,
        heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, xinhuwu.unisoc@gmail.com,
        zhiyong.liu@unisoc.com, peak.yang@unisoc.com,
        teng.zhang1@unisoc.com, bruce.chen@unisoc.com,
        surong.pang@unisoc.com, xingxing.luo@unisoc.com,
        xinhu.wu@unisoc.com
Subject: Re: [PATCH V2 1/2] usb: typec: Support sprd_pmic_typec driver
Message-ID: <202312120229.fONhCYBI-lkp@intel.com>
References: <20231211074120.27958-2-xinhu.wu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211074120.27958-2-xinhu.wu@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231212/202312120229.fONhCYBI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312120229.fONhCYBI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120229.fONhCYBI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/typec/sprd_pmic_typec.c: In function 'sprd_pmic_typec_connect':
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_DETACHED_SNK' not handled in switch [-Wswitch]
     184 |         switch (sc->state) {
         |         ^~~~~~
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_ATTACHWAIT_SNK' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_DETACHED_SRC' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_ATTACHWAIT_SRC' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_POWERED_CABLE' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_AUDIO_CABLE' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_DEBUG_CABLE' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_TOGGLE_SLEEP' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_ERR_RECOV' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_DISABLED' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_TRY_SNK' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_TRY_WAIT_SRC' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_TRY_SRC' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_TRY_WAIT_SNK' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_UNSUPOORT_ACC' not handled in switch [-Wswitch]
>> drivers/usb/typec/sprd_pmic_typec.c:184:9: warning: enumeration value 'TYPEC_ORIENTED_DEBUG' not handled in switch [-Wswitch]


vim +/TYPEC_DETACHED_SNK +184 drivers/usb/typec/sprd_pmic_typec.c

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
