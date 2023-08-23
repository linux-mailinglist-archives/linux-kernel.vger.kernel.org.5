Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF72785A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbjHWOPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236239AbjHWOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:15:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EAFE63;
        Wed, 23 Aug 2023 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692800134; x=1724336134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JnCZjLK+rj3cz9wTMkJV2VLhxW8FumQh+AlMNzRTk6k=;
  b=gIjRbGPkP7HpwsDkVAnIz30B0l/+DCbdDKEqS/X1DdF+bap5eFmIt91d
   t+E6nxnMxRuRdJZRe974KO8FvuqZiNE1KU0proS63bs0aSt/nOk0ZJ2SE
   ju8NZhQdDrsCeYyBktaUrafGKPexH7iXp+u24yKURlfV+3lkiFm27+6yS
   mEUk5dexxyFV9aFHTJEqWnEEFfVuYRKnj9hNM5IZhFn8UTVbezAolEOuS
   2N23s2SQViovrPHS7lNoNQDmCcGb3uypMK/kYW1CvjTaUjB0+Zf7tSrth
   GJft5QWssFOSvKATfWi3m6tBweSw2MhEdOGpbOX9mdD61Wk6mm24c5n2C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="374144779"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="374144779"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 07:15:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="771740332"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="771740332"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 23 Aug 2023 07:15:30 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYodu-0001Ga-0U;
        Wed, 23 Aug 2023 14:15:30 +0000
Date:   Wed, 23 Aug 2023 22:15:00 +0800
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
Message-ID: <202308232214.4VvP0avv-lkp@intel.com>
References: <20230822102846.4683-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822102846.4683-1-stanley_chang@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanley,

kernel test robot noticed the following build errors:

[auto build test ERROR on chanwoo-extcon/extcon-next]
[also build test ERROR on linus/master v6.5-rc7 next-20230823]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stanley-Chang/dt-bindings-extcon-Add-Realtek-DHC-RTD-SoC-Type-C/20230822-183332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
patch link:    https://lore.kernel.org/r/20230822102846.4683-1-stanley_chang%40realtek.com
patch subject: [PATCH v1 1/2] extcon: add Realtek DHC RTD SoC Type-C driver
config: loongarch-randconfig-r053-20230823 (https://download.01.org/0day-ci/archive/20230823/202308232214.4VvP0avv-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308232214.4VvP0avv-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308232214.4VvP0avv-lkp@intel.com/

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/extcon/extcon-rtk-type-c.o: in function `.L394':
>> extcon-rtk-type-c.c:(.text+0x2a18): undefined reference to `usb_debug_root'
>> loongarch64-linux-ld: extcon-rtk-type-c.c:(.text+0x2a1c): undefined reference to `usb_debug_root'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
