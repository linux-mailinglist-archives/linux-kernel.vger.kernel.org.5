Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B26783330
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 22:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjHUTyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjHUTyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:54:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713710B;
        Mon, 21 Aug 2023 12:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692647683; x=1724183683;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uojYPtSeSRn90ap/xQEo2sFrpcBYeD2eHRgnIC5QHXw=;
  b=l+kSaqNp9X4uEyig7i2n+fOtUjTKAJPBVMayMtYEMO2+Q5sYOX+Wr8Wh
   zOJ5287XM53nnuNgVV2OeTsyTQrnakU3kG9D4Ck3ku2LwfoOudW5Q+r71
   YXC2UUsP288oaIXBLZGqbui/JICgJRRZciHzpisGEG7w86Yr64USPKiZe
   vF5Ra8c1sAX4r080H6sQorD0D+ZhuOUeGJrmV0ISXT5KsCT2FAmsvMbNb
   yNFgxoaVPCMq0NRDaK6jCqI+QI94g5erScNdPKwbePrMb0AT0LU4IVnDb
   245hF//TcgR3SErac2XH4Ri0qg/+1Xy2i25X0YvvqG+bVWvny9A/T4i6y
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="460054998"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="460054998"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 12:54:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="859606457"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="859606457"
Received: from lkp-server02.sh.intel.com (HELO 6809aa828f2a) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2023 12:54:39 -0700
Received: from kbuild by 6809aa828f2a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYAz0-0000rU-12;
        Mon, 21 Aug 2023 19:54:38 +0000
Date:   Tue, 22 Aug 2023 03:54:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hardik Gajjar <hgajjar@de.adit-jv.com>, gregkh@linuxfoundation.org,
        mathias.nyman@intel.com, stern@rowland.harvard.edu,
        yangyingliang@huawei.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        jinpu.wang@ionos.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, erosca@de.adit-jv.com
Subject: Re: [PATCH] usb: hcd: xhci: Add set command timer delay API
Message-ID: <202308220340.2SPzc4kd-lkp@intel.com>
References: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818092353.124658-1-hgajjar@de.adit-jv.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hardik,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.5-rc7 next-20230821]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hardik-Gajjar/usb-hcd-xhci-Add-set-command-timer-delay-API/20230821-094400
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230818092353.124658-1-hgajjar%40de.adit-jv.com
patch subject: [PATCH] usb: hcd: xhci: Add set command timer delay API
config: x86_64-randconfig-013-20230821 (https://download.01.org/0day-ci/archive/20230822/202308220340.2SPzc4kd-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230822/202308220340.2SPzc4kd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308220340.2SPzc4kd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/usb/core/hcd.c:3133: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * usb_hcd_set_cmd_timer_delay Set the delay of the command timer.


vim +3133 drivers/usb/core/hcd.c

  3131	
  3132	/**
> 3133	 * usb_hcd_set_cmd_timer_delay Set the delay of the command timer.
  3134	 * @hcd - pointer to the HCD representing the controller
  3135	 * @delay - Delay value to be used in command timer.
  3136	 *
  3137	 * wrapper function to call the set_cmd_timer_delay API of the host
  3138	 * diver.
  3139	 *
  3140	 * return 0 on success; otherwise -ENODEV means the feature not
  3141	 * supported by host driver.
  3142	 */
  3143	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
