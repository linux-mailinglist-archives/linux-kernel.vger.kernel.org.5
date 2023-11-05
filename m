Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E67E177E
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjKEW67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbjKEW6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:58:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894B6CF;
        Sun,  5 Nov 2023 14:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699225129; x=1730761129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IBnqEtOpVF3qUs7zi14zprYn6a0bv6FOzZ6a7h1nLOc=;
  b=KZfj525qBtCB9v+15cfAINtt6PgDNPOWv4d2R4lwnvJB23FpVeU1HUAc
   CwWlvtY1CVHZy1YcJEC7ue6cbjbUqIEqxrTkXZlIGOL7OFq1qD0Y3CZ34
   Ng/mTu0M1htGDpVQibQ+ZoZ61Q9F6h4UEdY4h7EZn46YAjDIUgtedUEX7
   xHsDZzt49ItKyEQOm+pRFjqIDfmaVHZsaRrWn6Uklva0yOty4DcBLiidC
   VJEDGifiIR1Mg0HnnSJVSMZSh+Ja73lfyMArs+FiElWASafcyhMlc6dW3
   d+ltC8CeEHyNVT5+U/9voX2avShLcZEdOI/gakVf8zr7jYcm3HD1bYIw0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="388064926"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="388064926"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2023 14:58:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="1093600479"
X-IronPort-AV: E=Sophos;i="6.03,279,1694761200"; 
   d="scan'208";a="1093600479"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Nov 2023 14:58:48 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qzm4s-0005rY-10;
        Sun, 05 Nov 2023 22:58:46 +0000
Date:   Mon, 6 Nov 2023 06:57:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        andrew@lunn.ch, pkshih@realtek.com, larry.chiu@realtek.com,
        Justin Lai <justinlai0215@realtek.com>
Subject: Re: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the
 Makefile and Kconfig in the realtek folder
Message-ID: <202311060633.814zKJdK-lkp@intel.com>
References: <20231102154505.940783-13-justinlai0215@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102154505.940783-13-justinlai0215@realtek.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Justin,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Justin-Lai/net-ethernet-realtek-rtase-Add-pci-table-supported-in-this-module/20231103-032946
base:   net-next/main
patch link:    https://lore.kernel.org/r/20231102154505.940783-13-justinlai0215%40realtek.com
patch subject: [PATCH net-next v10 12/13] net:ethernet:realtek: Update the Makefile and Kconfig in the realtek folder
config: powerpc64-allyesconfig (https://download.01.org/0day-ci/archive/20231106/202311060633.814zKJdK-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231106/202311060633.814zKJdK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311060633.814zKJdK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/realtek/rtase/rtase_main.c:68:10: fatal error: 'net/page_pool.h' file not found
      68 | #include <net/page_pool.h>
         |          ^~~~~~~~~~~~~~~~~
   1 error generated.


vim +68 drivers/net/ethernet/realtek/rtase/rtase_main.c

db2657d0fa3a98 Justin Lai 2023-11-02 @68  #include <net/page_pool.h>
db2657d0fa3a98 Justin Lai 2023-11-02  69  #include <net/pkt_cls.h>
db2657d0fa3a98 Justin Lai 2023-11-02  70  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
