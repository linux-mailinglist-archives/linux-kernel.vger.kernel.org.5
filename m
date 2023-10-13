Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEF67C8BB1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbjJMQj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbjJMQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:39:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637B395
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697215194; x=1728751194;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=B1ZFeff2FC+/axoCPBEmU86xwJXgzwT7MgIqAA9nOyk=;
  b=NBQPfMnpLZemig+ywjTx4QNKGKs3xoxPpp+bkecfZovh71+hEtbFyC69
   REiJB8O3Yn5z4wk4eCyaCcvMOwWNMbdaiN92X6qpqyaKokuz8+YFjxgzB
   uzGcqxnxaq6EGqquE8Mfsgis8+DAy6FrfD8qLkUNcvaZ1rC+tZBhDCwYc
   B5HlLNizrvifXZJb4OOZ9hT61Gyfkr4tND2x+C+T+NfMu7jS/XXPtU3D4
   onpLRNkgzAueL8o+gu2esaYj3nMAbFDg+tJDXO8Yp9SbSkoDt+r6HNSPC
   WupWUnzheNOl1AvT2L67onZphOsD9VLqdqAodGvuDcQomd8SfVSy7rCI/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="385058262"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="385058262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="871146758"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="871146758"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Oct 2023 09:39:52 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qrLCY-000589-1p;
        Fri, 13 Oct 2023 16:39:50 +0000
Date:   Sat, 14 Oct 2023 00:39:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: undefined reference to `.L874'
Message-ID: <202310140044.PAShwiKd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   10a6e5feccb877c3c75ad11d27942ad52c24815f
commit: 079c8d9da26ed041a54706de68b754337e6df17e mtd: rawnand: export 'nand_exit_status_op()'
date:   3 months ago
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20231014/202310140044.PAShwiKd-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231014/202310140044.PAShwiKd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310140044.PAShwiKd-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_do_write_ops':
>> (.text+0x4a24): undefined reference to `.L874'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
