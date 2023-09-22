Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5177AADD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjIVJ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjIVJ0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:26:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E16618F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 02:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695374756; x=1726910756;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bJxNMs6leX9yPPHruYqFso3LB1WZbu07e94JRfjBR8g=;
  b=RDBZ1IFnPOIV4qyd25FOQuKSQ6rpd4KEH7vRSMUaRpPXMbaKWK6FfyIv
   Yf9LYfdQ6OOv4BHac8Q8EVQSwlzLrSO2A6Xy2F2Y6sAQmF8SPmIYbxsCF
   bNRpBAbJGKm4AjgunMn+OSfiZGd4bITLx96TqABqZlem3Phbvqmtk8OMH
   +j1u5oN3ZKkqmq+r7mIKdSSLrHBih0rjFYhLLYXP4/2tQjzrSmA67dmrL
   BjAw1pKLDfjg/21rQzM4g99B7KP9KKy+/n4rIe4PTxYP55QFveDoGddR8
   Lrg4JFP7BwTEOKX9WNdsaeg2xRd7qOMgkbH7kg8+/4h91nlvNA6V8qNCJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="365841165"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="365841165"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 02:25:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="862878346"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="862878346"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 22 Sep 2023 02:25:54 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjcQ4-0000TH-2C;
        Fri, 22 Sep 2023 09:25:52 +0000
Date:   Fri, 22 Sep 2023 17:25:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c:1435:5-8:
 Unneeded variable: "err". Return "  - ENOENT" on line 1450
Message-ID: <202309221718.XOjvU63U-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bbf45eae9ca98877a2d52a92a188147cd61b07
commit: e1d597ecbe5c5d7128630d4c9ec27c42018613ed net: microchip: sparx5: Add TC template support
date:   7 months ago
config: csky-randconfig-r051-20230812 (https://download.01.org/0day-ci/archive/20230922/202309221718.XOjvU63U-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230922/202309221718.XOjvU63U-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309221718.XOjvU63U-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/microchip/sparx5/sparx5_tc_flower.c:1435:5-8: Unneeded variable: "err". Return "  - ENOENT" on line 1450

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
