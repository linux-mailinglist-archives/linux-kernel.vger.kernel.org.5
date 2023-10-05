Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1D17BA76A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 19:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjJEROW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 13:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjJERN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 13:13:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E2F193;
        Thu,  5 Oct 2023 10:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696525430; x=1728061430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xwH19jaXuV3IRiERrelAUrnpdPnnnaE+ZD4sNqe01N8=;
  b=gtfGmnLou5x98QXBqoeE25ff29dd2cj9xkyGsEtQz/pJCJqONF6SiIlt
   uZY1KzEKXQvGoTrqFf/gwV3EL37rgxekfM2aFeyH4B2bNk5puCgXZ6Eoj
   BuZ1N58zFblofCJ2cPjhrAHkChKQm2zAMo+Z9vTNzb7aPUwyOnTL6GbJO
   iIg7JbOs2zJYK+V/rSQxQ7kQOebfrhPltMUBEVZ+6LDK3dRNoRwgnfBBy
   +IIJU5h7tzEiXGT3H2/WT/YK8GIWHZ1LIVKQIWfs1Y8SXrMGULtXlEvhX
   eMvTnwOmRxJ80GvdSlITSUTFhgWqwrZzT2TXbOCO0Rug2g2WKW6xjpCbX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="373912245"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="373912245"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 10:03:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="745528485"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="745528485"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 05 Oct 2023 10:03:41 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoRlD-000Lgl-1p;
        Thu, 05 Oct 2023 17:03:39 +0000
Date:   Fri, 6 Oct 2023 01:02:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] Input: max77693-haptic - add device-tree compatible
 strings
Message-ID: <202310060002.ucD2eiLJ-lkp@intel.com>
References: <20231005114816.1101953-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005114816.1101953-1-m.szyprowski@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus hid/for-next linus/master v6.6-rc4 next-20231005]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Marek-Szyprowski/Input-max77693-haptic-add-device-tree-compatible-strings/20231005-231602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20231005114816.1101953-1-m.szyprowski%40samsung.com
patch subject: [PATCH] Input: max77693-haptic - add device-tree compatible strings
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231006/202310060002.ucD2eiLJ-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231006/202310060002.ucD2eiLJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310060002.ucD2eiLJ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/input/misc/max77693-haptic.c:415:34: warning: 'of_max77693_haptic_dt_match' defined but not used [-Wunused-const-variable=]
     415 | static const struct of_device_id of_max77693_haptic_dt_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/of_max77693_haptic_dt_match +415 drivers/input/misc/max77693-haptic.c

   414	
 > 415	static const struct of_device_id of_max77693_haptic_dt_match[] = {
   416		{ .compatible = "maxim,max77693-haptic", },
   417		{ .compatible = "maxim,max77843-haptic", },
   418		{ /* sentinel */ },
   419	};
   420	MODULE_DEVICE_TABLE(of, of_max77693_haptic_dt_match);
   421	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
