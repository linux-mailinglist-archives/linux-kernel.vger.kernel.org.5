Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AF5774A05
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232640AbjHHULc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHHULT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:11:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52B429540
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691519710; x=1723055710;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BuaT2/ImKU0LR1ovRnINUVS5qWtOBhmIP+p3v/iplT0=;
  b=Oiu4W0frv2p7ZH8im5tFYyoaRS6n7ZvVsWhqL2U2XAu1y4RtAbrZ5Bv3
   3mg369MoOLWWpYjmuWoanXA+7RjaIwfan7rrDe3LyhmRMQHXMUef3PSFj
   Mr5Ynw9w4DVBLRFxBXuZSuymG1lE3vhFMwuhkbChtb6RN2Cgymk5l6+V9
   JiY2+bq88upc9/6T5epkxa1pu4CO+0ZWxzJi/8uXNy60QgzklsvEQIzZd
   yH2xWaGsdu7IF4I/QMcPWAHNEnfS+QCDuqcDxm7szXVjAswss9zAoUfR3
   WOP2cWsQQ3t9souIZBnBw3R+xJt/eWGA/5WlrR8hMjjywAmqVIl1hpt0v
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="369815569"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="369815569"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 11:35:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="978016740"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="978016740"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2023 11:35:08 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qTRXv-0005XQ-0y;
        Tue, 08 Aug 2023 18:35:07 +0000
Date:   Wed, 9 Aug 2023 02:34:12 +0800
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
Subject: Re: [PATCH 01/41] mtd: spi-nor: remove catalyst 'flashes'
Message-ID: <202308090236.poj47Yz8-lkp@intel.com>
References: <20230807-mtd-flash-info-db-rework-v1-1-3d3d5bef4ba4@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-mtd-flash-info-db-rework-v1-1-3d3d5bef4ba4@kernel.org>
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
patch link:    https://lore.kernel.org/r/20230807-mtd-flash-info-db-rework-v1-1-3d3d5bef4ba4%40kernel.org
patch subject: [PATCH 01/41] mtd: spi-nor: remove catalyst 'flashes'
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20230809/202308090236.poj47Yz8-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230809/202308090236.poj47Yz8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308090236.poj47Yz8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> make[6]: *** No rule to make target 'drivers/mtd/spi-nor/catalyst.o', needed by 'drivers/mtd/spi-nor/built-in.a'.
   make[6]: Target 'drivers/mtd/spi-nor/' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
