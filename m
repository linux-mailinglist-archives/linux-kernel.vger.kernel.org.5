Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83AC780B5F8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 20:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjLITIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 14:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjLITID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 14:08:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21F0F9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702148889; x=1733684889;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B1kQg7J9907SlOlnirWbA1kwjXEhu8Z2YMCu2e9KBJo=;
  b=FkBzR2F4Fm/obQXU74savq93B9H++rxtBekanLTLo39TOs7Jkkel2Ttw
   /9gIxaCgAeuS1O2wOrDLtAnpLz3B/gXNsCTOGGcoBhSnTbDsa86SFSO2f
   AZoaKPmf5azBbfHqtH4J3g7FGsFRzt+wMr1VDqPLbJmbkh7kLk60Nmp3k
   zCaLZQDpmC0uRU93yNBW5CRes0KZooxaWBlfl3TbYUSgxud5CmMvkJZ4m
   dNgWKAqJk4sfFggLXurxEvMW4TS7uNWNnuWVaLqsIW4XCWI7Idr6ME08z
   pvWj4huMLYAUWNSueUf79B0UUGAPz6ClKsygLLOReNasWimM440z5XHWX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="16074333"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="16074333"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 11:08:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="776152961"
X-IronPort-AV: E=Sophos;i="6.04,264,1695711600"; 
   d="scan'208";a="776152961"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 09 Dec 2023 11:08:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rC2gG-000FoD-2h;
        Sat, 09 Dec 2023 19:08:04 +0000
Date:   Sun, 10 Dec 2023 03:07:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Axtens <dja@axtens.net>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output
 may be truncated writing up to 254 bytes into a region of size between 0 and
 4095
Message-ID: <202312100355.lHoJPgKy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f2e8a57ee9036c7d5443382b6c3c09b51a92ec7e
commit: 6a39e62abbafd1d58d1722f40c7d26ef379c6a2f lib: string.h: detect intra-object overflow in fortified string functions
date:   3 years ago
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20231210/202312100355.lHoJPgKy-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231210/202312100355.lHoJPgKy-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312100355.lHoJPgKy-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/block/rnbd/rnbd-srv.c: In function 'process_msg_open.isra':
>> drivers/block/rnbd/rnbd-srv.c:616:51: warning: '%s' directive output may be truncated writing up to 254 bytes into a region of size between 0 and 4095 [-Wformat-truncation=]
     616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
         |                                                   ^~
   In function 'rnbd_srv_get_full_path',
       inlined from 'process_msg_open.isra' at drivers/block/rnbd/rnbd-srv.c:721:14:
   drivers/block/rnbd/rnbd-srv.c:616:17: note: 'snprintf' output between 2 and 4351 bytes into a destination of size 4096
     616 |                 snprintf(full_path, PATH_MAX, "%s/%s",
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     617 |                          dev_search_path, dev_name);
         |                          ~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +616 drivers/block/rnbd/rnbd-srv.c

2de6c8de192b934 Jack Wang 2020-05-11  588  
2de6c8de192b934 Jack Wang 2020-05-11  589  static char *rnbd_srv_get_full_path(struct rnbd_srv_session *srv_sess,
2de6c8de192b934 Jack Wang 2020-05-11  590  				     const char *dev_name)
2de6c8de192b934 Jack Wang 2020-05-11  591  {
2de6c8de192b934 Jack Wang 2020-05-11  592  	char *full_path;
2de6c8de192b934 Jack Wang 2020-05-11  593  	char *a, *b;
2de6c8de192b934 Jack Wang 2020-05-11  594  
2de6c8de192b934 Jack Wang 2020-05-11  595  	full_path = kmalloc(PATH_MAX, GFP_KERNEL);
2de6c8de192b934 Jack Wang 2020-05-11  596  	if (!full_path)
2de6c8de192b934 Jack Wang 2020-05-11  597  		return ERR_PTR(-ENOMEM);
2de6c8de192b934 Jack Wang 2020-05-11  598  
2de6c8de192b934 Jack Wang 2020-05-11  599  	/*
2de6c8de192b934 Jack Wang 2020-05-11  600  	 * Replace %SESSNAME% with a real session name in order to
2de6c8de192b934 Jack Wang 2020-05-11  601  	 * create device namespace.
2de6c8de192b934 Jack Wang 2020-05-11  602  	 */
2de6c8de192b934 Jack Wang 2020-05-11  603  	a = strnstr(dev_search_path, "%SESSNAME%", sizeof(dev_search_path));
2de6c8de192b934 Jack Wang 2020-05-11  604  	if (a) {
2de6c8de192b934 Jack Wang 2020-05-11  605  		int len = a - dev_search_path;
2de6c8de192b934 Jack Wang 2020-05-11  606  
2de6c8de192b934 Jack Wang 2020-05-11  607  		len = snprintf(full_path, PATH_MAX, "%.*s/%s/%s", len,
2de6c8de192b934 Jack Wang 2020-05-11  608  			       dev_search_path, srv_sess->sessname, dev_name);
2de6c8de192b934 Jack Wang 2020-05-11  609  		if (len >= PATH_MAX) {
2de6c8de192b934 Jack Wang 2020-05-11  610  			pr_err("Too long path: %s, %s, %s\n",
2de6c8de192b934 Jack Wang 2020-05-11  611  			       dev_search_path, srv_sess->sessname, dev_name);
2de6c8de192b934 Jack Wang 2020-05-11  612  			kfree(full_path);
2de6c8de192b934 Jack Wang 2020-05-11  613  			return ERR_PTR(-EINVAL);
2de6c8de192b934 Jack Wang 2020-05-11  614  		}
2de6c8de192b934 Jack Wang 2020-05-11  615  	} else {
2de6c8de192b934 Jack Wang 2020-05-11 @616  		snprintf(full_path, PATH_MAX, "%s/%s",
2de6c8de192b934 Jack Wang 2020-05-11  617  			 dev_search_path, dev_name);
2de6c8de192b934 Jack Wang 2020-05-11  618  	}
2de6c8de192b934 Jack Wang 2020-05-11  619  
2de6c8de192b934 Jack Wang 2020-05-11  620  	/* eliminitate duplicated slashes */
2de6c8de192b934 Jack Wang 2020-05-11  621  	a = strchr(full_path, '/');
2de6c8de192b934 Jack Wang 2020-05-11  622  	b = a;
2de6c8de192b934 Jack Wang 2020-05-11  623  	while (*b != '\0') {
2de6c8de192b934 Jack Wang 2020-05-11  624  		if (*b == '/' && *a == '/') {
2de6c8de192b934 Jack Wang 2020-05-11  625  			b++;
2de6c8de192b934 Jack Wang 2020-05-11  626  		} else {
2de6c8de192b934 Jack Wang 2020-05-11  627  			a++;
2de6c8de192b934 Jack Wang 2020-05-11  628  			*a = *b;
2de6c8de192b934 Jack Wang 2020-05-11  629  			b++;
2de6c8de192b934 Jack Wang 2020-05-11  630  		}
2de6c8de192b934 Jack Wang 2020-05-11  631  	}
2de6c8de192b934 Jack Wang 2020-05-11  632  	a++;
2de6c8de192b934 Jack Wang 2020-05-11  633  	*a = '\0';
2de6c8de192b934 Jack Wang 2020-05-11  634  
2de6c8de192b934 Jack Wang 2020-05-11  635  	return full_path;
2de6c8de192b934 Jack Wang 2020-05-11  636  }
2de6c8de192b934 Jack Wang 2020-05-11  637  

:::::: The code at line 616 was first introduced by commit
:::::: 2de6c8de192b9341ffa5e84afe1ce6196d4eef41 block/rnbd: server: main functionality

:::::: TO: Jack Wang <jinpu.wang@cloud.ionos.com>
:::::: CC: Jason Gunthorpe <jgg@mellanox.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
