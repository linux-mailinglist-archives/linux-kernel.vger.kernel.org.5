Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C09A76B825
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbjHAO7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbjHAO7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:59:18 -0400
Received: from mgamail.intel.com (unknown [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D67E4E;
        Tue,  1 Aug 2023 07:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690901957; x=1722437957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9WtORg9ICe4cJKnB5dQPkrNEObZycRB/xV8WTCzQTxY=;
  b=Vfj6FmWml/Dzjta2F6qm9rjoHQTVyVnkg6S0krfRYcwxtkUn+o72c4tr
   WRnuoxGHJ86AtcnfwgqMqoKDRIGaSua4RnI3OQhxhd5sWmx+z30fh8pe0
   YPeXI4gV4K5EF1DdM7LA47tZon2g1j86LymECnsdupl0XNqRWrlpngHWH
   gZ2JoN6zOKIJ8Z3EALPFpnZgm3WpxNskX/XwDn74+Xju9wgJJT0jSJtFj
   uhoPottv/49a8Z7CmyL02SdDaJv3FX0RR9GLN+Fe5d5LJb042DKW9gXc+
   Hm+wuwzQCjqsXLZ7HsxPDE0bHRAzPcP7RXyz1YZYZjc0cRyHaQORVzC/j
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="369313283"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="369313283"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 07:58:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="705846281"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="705846281"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Aug 2023 07:58:00 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQqox-0000N1-2U;
        Tue, 01 Aug 2023 14:57:59 +0000
Date:   Tue, 1 Aug 2023 22:57:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhouscd <zhouscd@gmail.com>, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, dan.scally@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, m.grzeschik@pengutronix.de,
        john@keeping.me.uk, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouscd <zhouscd@gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix the function name error in
 sourcesink/loopback.
Message-ID: <202308012224.vyXfjJMA-lkp@intel.com>
References: <20230801045449.156348-1-zhouscd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801045449.156348-1-zhouscd@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi zhouscd,

kernel test robot noticed the following build errors:

[auto build test ERROR on usb/usb-testing]
[also build test ERROR on usb/usb-next usb/usb-linus linus/master v6.5-rc4 next-20230801]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/zhouscd/USB-gadget-Fix-the-function-name-error-in-sourcesink-loopback/20230801-125745
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20230801045449.156348-1-zhouscd%40gmail.com
patch subject: [PATCH] USB: gadget: Fix the function name error in sourcesink/loopback.
config: sparc-randconfig-r015-20230731 (https://download.01.org/0day-ci/archive/20230801/202308012224.vyXfjJMA-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230801/202308012224.vyXfjJMA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308012224.vyXfjJMA-lkp@intel.com/

All errors (new ones prefixed by >>):

   sparc64-linux-ld: drivers/usb/gadget/function/f_sourcesink.o: in function `sourcesinkmod_init':
>> f_sourcesink.c:(.init.text+0x0): multiple definition of `init_module'; drivers/usb/gadget/function/f_loopback.o:f_loopback.c:(.init.text+0x0): first defined here
   sparc64-linux-ld: drivers/usb/gadget/function/f_sourcesink.o: in function `sourcesinkmod_exit':
>> f_sourcesink.c:(.exit.text+0x0): multiple definition of `cleanup_module'; drivers/usb/gadget/function/f_loopback.o:f_loopback.c:(.exit.text+0x0): first defined here

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
