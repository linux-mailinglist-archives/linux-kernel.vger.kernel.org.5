Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490DB774201
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjHHRcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbjHHRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:31:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F185C7ECF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691511222; x=1723047222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dRwKRnc0pAlIZ3Hy9o9z180pyWvTYpsms8EmAZLR4Bo=;
  b=S0AhuY/bo93YQPUeL9hL7xMmrcCwPmRVIrgbYXV9HTz3TCl0E5y+NN/t
   pL9C7E/bXddBRVzmVPUnVD9bC+B8eGEGt7fxHCiNt3PZIcIxMAdPvCYaj
   3x//XdUn+RpDwmYlpNFSiQGsdhvS0ne0AICn8yBHKKzX815PPpJwjdWsS
   2PoVPY3jMVhZhxcgkTja0Rys+QRYvVpzsWIDkA3mi9DuOJ8gXaeva675u
   N4wrh4aWrBrKjUYn4i8284zthRP73zHp2YvUGBL8TEuNK6KcUB2lJjOiS
   mcQvT9MS30GghXS5898k3V/MvhSL1e/p2tF3c/48P9HkAhDxhIyUvGXuj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="370757086"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="370757086"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="766300747"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="766300747"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Aug 2023 02:04:54 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTIe5-0005FI-1h;
        Tue, 08 Aug 2023 09:04:53 +0000
Date:   Tue, 8 Aug 2023 17:04:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michael Walle <mwalle@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 02/41] mtd: spi-nor: remove Fujitsu MB85RS1MT support
Message-ID: <202308081613.cFbUU2bQ-lkp@intel.com>
References: <20230807-mtd-flash-info-db-rework-v1-2-3d3d5bef4ba4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-2-3d3d5bef4ba4@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

kernel test robot noticed the following build errors:

[auto build test ERROR on f7dc24b3413851109c4047b22997bd0d95ed52a2]

url:    https://github.com/intel-lab-lkp/linux/commits/Michael-Walle/mtd-spi-nor-remove-catalyst-flashes/20230807-213321
base:   f7dc24b3413851109c4047b22997bd0d95ed52a2
patch link:    https://lore.kernel.org/r/20230807-mtd-flash-info-db-rework-v1-2-3d3d5bef4ba4%40kernel.org
patch subject: [PATCH 02/41] mtd: spi-nor: remove Fujitsu MB85RS1MT support
config: powerpc-allmodconfig (https://download.01.org/0day-ci/archive/20230808/202308081613.cFbUU2bQ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230808/202308081613.cFbUU2bQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308081613.cFbUU2bQ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[6]: *** No rule to make target 'drivers/mtd/spi-nor/fujitsu.o', needed by 'drivers/mtd/spi-nor/spi-nor.o'.
   make[6]: Target 'drivers/mtd/spi-nor/' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
