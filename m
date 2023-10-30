Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A31967DB9CD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjJ3MV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbjJ3MVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:21:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9F0C6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698668512; x=1730204512;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AIxYKjfYMQDoHG7BdQKYuYyA19w72M5Vxmei2/AcHIs=;
  b=Rh4UD9Zl+ppGPS/1h4j4AwRDvWg2WhrZB1AjO7doYWQIha4O/nAJ3jlS
   Mno4KUF757Krq4X1/lIT2klaz2+tF1g27EcfzJQ8UL6MKslU9SbpamO2U
   VocR+58IUyFwsg12nze48l2la5nbyEzUEUvy8EiJ2jspYim4cxYqB1xQ1
   6dN4y5Se+LV3Np7GeMD+D3PJ9jxItoNQPb78AJBnPriwv11CT8dEmPReb
   pB40IK0UEkyaoIZ/nJLe7klrkU8odPf26nWuWr5QqoG437GsftNPRXin0
   YBPkZyNdUzOeFMkjZCA/R+rWkNLS6L+47sHsdhNBMqpgO02HqW0oneB4A
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="386953149"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="386953149"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="883842404"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="883842404"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 30 Oct 2023 05:21:51 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qxRHA-000DFf-2Q;
        Mon, 30 Oct 2023 12:21:48 +0000
Date:   Mon, 30 Oct 2023 20:21:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: undefined reference to `.L874'
Message-ID: <202310302008.l48xgOrQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arseniy,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ffc253263a1375a65fa6c9f62a893e9767fbebfa
commit: 079c8d9da26ed041a54706de68b754337e6df17e mtd: rawnand: export 'nand_exit_status_op()'
date:   4 months ago
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20231030/202310302008.l48xgOrQ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231030/202310302008.l48xgOrQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310302008.l48xgOrQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   hppa-linux-ld: drivers/mtd/nand/raw/nand_base.o: in function `nand_do_write_ops':
>> (.text+0x4a24): undefined reference to `.L874'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
