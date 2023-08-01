Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FED876BF63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjHAVjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:39:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbjHAVjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:39:47 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBB61FFA;
        Tue,  1 Aug 2023 14:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690925986; x=1722461986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PIvE+wk0gckA7IDR9rPgF7HwZhXNaKTv/MXchMaP7ZE=;
  b=lONlzIkn5LwsGUk9dT1RI9mp1Mnm+BhWXmVQkp35IAI/6M6wuAVeF95W
   hN4eWcSXRuRuApcz6dVooHe0Q4fVimSUbqewKA+JOGM5jPJrK3spg1mIJ
   aZxB463Hcyn1QOrp6EsI+4oHL5H0jpYMrt38XdhV52sWdA+xEaIuyZLoG
   Uf+wyhfJ4ZUptvTMlZvnNxSgWRU3T670WE+AkeEnPh7/jLZ2ViAYN0Ros
   EonSeAI8Yc2yEA6uGT9DTNn4h/nEOmAAah/aeojSNzFTS+ctVJJf9yMbV
   qir/KnA6x9t0dSQsjmRUZaxx5ZmjDszHw2lsvY/6gPW/1MnLHkrLK8ntT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433262590"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="433262590"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 14:39:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="902728720"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="902728720"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 01 Aug 2023 14:39:43 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qQx5i-0000bn-2N;
        Tue, 01 Aug 2023 21:39:42 +0000
Date:   Wed, 2 Aug 2023 05:39:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     zhouscd <zhouscd@gmail.com>, gregkh@linuxfoundation.org
Cc:     oe-kbuild-all@lists.linux.dev, dan.scally@ideasonboard.com,
        laurent.pinchart@ideasonboard.com, m.grzeschik@pengutronix.de,
        john@keeping.me.uk, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouscd <zhouscd@gmail.com>
Subject: Re: [PATCH] USB: gadget: Fix the function name error in
 sourcesink/loopback.
Message-ID: <202308020504.tNlWrHXN-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-r003-20230731 (https://download.01.org/0day-ci/archive/20230802/202308020504.tNlWrHXN-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230802/202308020504.tNlWrHXN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308020504.tNlWrHXN-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: drivers/usb/gadget/function/f_sourcesink.o: in function `sourcesinkmod_init':
>> drivers/usb/gadget/function/f_sourcesink.c:1266: multiple definition of `init_module'; drivers/usb/gadget/function/f_loopback.o:drivers/usb/gadget/function/f_loopback.c:586: first defined here
   ld: drivers/usb/gadget/function/f_sourcesink.o: in function `sourcesinkmod_exit':
>> drivers/usb/gadget/function/f_sourcesink.c:1266: multiple definition of `cleanup_module'; drivers/usb/gadget/function/f_loopback.o:drivers/usb/gadget/function/f_loopback.c:586: first defined here


vim +1266 drivers/usb/gadget/function/f_sourcesink.c

  1245	
  1246	static struct usb_function_instance *source_sink_alloc_inst(void)
  1247	{
  1248		struct f_ss_opts *ss_opts;
  1249	
  1250		ss_opts = kzalloc(sizeof(*ss_opts), GFP_KERNEL);
  1251		if (!ss_opts)
  1252			return ERR_PTR(-ENOMEM);
  1253		mutex_init(&ss_opts->lock);
  1254		ss_opts->func_inst.free_func_inst = source_sink_free_instance;
  1255		ss_opts->isoc_interval = GZERO_ISOC_INTERVAL;
  1256		ss_opts->isoc_maxpacket = GZERO_ISOC_MAXPACKET;
  1257		ss_opts->bulk_buflen = GZERO_BULK_BUFLEN;
  1258		ss_opts->bulk_qlen = GZERO_SS_BULK_QLEN;
  1259		ss_opts->iso_qlen = GZERO_SS_ISO_QLEN;
  1260	
  1261		config_group_init_type_name(&ss_opts->func_inst.group, "",
  1262					    &ss_func_type);
  1263	
  1264		return &ss_opts->func_inst;
  1265	}
> 1266	DECLARE_USB_FUNCTION_INIT(sourcesink, source_sink_alloc_inst,

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
