Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44B784DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 02:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjHWA06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 20:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjHWA04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 20:26:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703EBCE8;
        Tue, 22 Aug 2023 17:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692750415; x=1724286415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eznkHRlg2csp3AFqRUMkZPsyJ20aNCRsNuFblP9j8SU=;
  b=QVygH1sYkOH0TMCgAXlpGYjahzDgUcGSFt6jw4vYM7OosvM7Su/nP1bS
   DlQz6pzL44+vldKhovbAXpb+28L6nDctAAJLgpCKjQvWSTF6CV5ooWunK
   pX7QMUJtBvGhnzreMdYwIgHuWsSWc+v14BKlQAa1HVXOjOxweKW2Eo/Wg
   s/nvH94kCmmKVcSbvlB2Y1ilyv7vNV9c47JuIBKiaC5E1cHhHfQ76RuDs
   L+Q06cKJ+/olYffo2md4K7sLrOgPxwA0QRZ7OjubX9fg/3PWIbfA1WQnl
   MFMjXcuGEIbsirhD/si42o6chPzEBk5G0Rn+BxOV4x56UF4/I8tSOIY9y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="374003860"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="374003860"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 17:26:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="1067256440"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="1067256440"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 22 Aug 2023 17:26:52 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYbhz-0000eS-1c;
        Wed, 23 Aug 2023 00:26:51 +0000
Date:   Wed, 23 Aug 2023 08:26:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stanley Chang <stanley_chang@realtek.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Stanley Chang <stanley_chang@realtek.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
Message-ID: <202308230843.294BX49W-lkp@intel.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822102846.4683-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

kernel test robot noticed the following build errors:

[auto build test ERROR on chanwoo-extcon/extcon-next]
[also build test ERROR on linus/master v6.5-rc7 next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chang/dt-bindings-extcon-Add-Realtek-DHC-RTD-SoC-Type-C/20230822-183332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
patch link:    https://lore.kernel.org/r/20230822102846.4683-1-stanley_chang%40realtek.com
patch subject: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
config: m68k-randconfig-r024-20230823 (https://download.01.org/0day-ci/archive/20230823/202308230843.294BX49W-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230843.294BX49W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230843.294BX49W-lkp@intel.com/

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/extcon/extcon-rtk-type-c.o: in function `create_debug_files':
>> drivers/extcon/extcon-rtk-type-c.c:873:(.text+0x1948): undefined reference to `usb_debug_root'


vim +873 drivers/extcon/extcon-rtk-type-c.c

   870	
   871	static inline void create_debug_files(struct type_c_data *type_c)
   872	{
 > 873		type_c->debug_dir = debugfs_create_dir("type_c", usb_debug_root);
   874		if (!type_c->debug_dir)
   875			return;
   876	
   877		if (!debugfs_create_file("parameter", 0444, type_c->debug_dir, type_c,
   878					 &type_c_parameter_fops))
   879			goto file_error;
   880	
   881		if (!debugfs_create_file("status", 0444, type_c->debug_dir, type_c,
   882					 &type_c_status_fops))
   883			goto file_error;
   884	
   885		return;
   886	
   887	file_error:
   888		debugfs_remove_recursive(type_c->debug_dir);
   889	}
   890	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
