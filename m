Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772C7767C26
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 06:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbjG2EhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 00:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2EhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 00:37:13 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F4344BB;
        Fri, 28 Jul 2023 21:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690605431; x=1722141431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JKrVpxqY+0XkwkxhHP0wveZd6Ls3koVT52X+k7YompA=;
  b=hoN/rB1HVvJXG3S912zct1310zZ21A9cFzPAkMse3AbYgkt5W3XEmlPZ
   mBu3RzqpyPb52Z5trFYtm87Jcq4untnaPhfg1/TcYb5VnTysHba+Bu9RF
   Dk+sOeTFyt9OGHK7tM2f8XvBZMOK9kD7PqxveVjr+udJ2GIsKRBKkAinx
   IC9PI1SRpozRMjgWq8nreLBP2QbZR54UUphHu4WRvT3LVyh62A7EnELMV
   du/pMIUv9zFzL5jEbHR07GtGy53cB+15uIgVJoRALva9VqqErc3kc4n6U
   jzrGWfB77AJucY9smySRIFsAt7jcuEBn+wMgjASSjpgNFDml47exdL5Ap
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358761406"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="358761406"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 21:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="817728373"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="817728373"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2023 21:37:08 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPbhT-0003pT-24;
        Sat, 29 Jul 2023 04:37:07 +0000
Date:   Sat, 29 Jul 2023 12:36:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanley Chang <stanley_chang@realtek.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Stanley Chang <stanley_chang@realtek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue
 layer driver
Message-ID: <202307291202.NBP2coNC-lkp@intel.com>
References: <20230728035318.18741-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728035318.18741-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.5-rc3 next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chang/doc-dt-bindings-usb-realtek-dwc3-Add-Realtek-DHC-RTD-SoC-DWC3-USB/20230728-115507
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230728035318.18741-1-stanley_chang%40realtek.com
patch subject: [PATCH v1 1/2] usb: dwc3: add Realtek DHC RTD SoC dwc3 glue layer driver
config: x86_64-randconfig-r072-20230728 (https://download.01.org/0day-ci/archive/20230729/202307291202.NBP2coNC-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291202.NBP2coNC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291202.NBP2coNC-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `dwc3_rtk_remove_role_switch':
>> drivers/usb/dwc3/dwc3-rtk.c:196: undefined reference to `usb_role_switch_unregister'


vim +196 drivers/usb/dwc3/dwc3-rtk.c

   192	
   193	static int dwc3_rtk_remove_role_switch(struct dwc3_rtk *rtk)
   194	{
   195		if (rtk->role_switch)
 > 196			usb_role_switch_unregister(rtk->role_switch);
   197	
   198		rtk->role_switch = NULL;
   199	
   200		return 0;
   201	}
   202	#else
   203	#define dwc3_rtk_setup_role_switch(x) 0
   204	#define dwc3_rtk_remove_role_switch(x) 0
   205	#endif
   206	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
