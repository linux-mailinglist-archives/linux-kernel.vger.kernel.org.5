Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20DB77A709
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 16:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjHMOpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 10:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjHMOpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 10:45:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC6C10DE;
        Sun, 13 Aug 2023 07:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691937942; x=1723473942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zsDPfkuD7g67ETx7TCV+frwrh/8cdwe6/5TOBZ3FrAo=;
  b=c6L2J8LzYf6j3WDQV+Jewk3wqxCA/gPseFjE6wWHhqNXHrjdzWFOgFNw
   gFC7oq17uK7NxItntdNpWFQmpNbPuBjr/MWYYf9SquvcXovLFVmxWkUPP
   OltZL9IzaK85qRMtqSuoP8m0lbNejcf3YHqvAlHEsvz6a4hzz8JB4zq12
   0664NG8Nqi8NnQkMrT/RjN5x+x3j0T8h6vlhbcNcaCeq3Ju2TxauTd9ax
   sezGNGgeKt7uVR0uSqCmCRF2qQFYPmilAcESFD6b9I+47CLdJccYtwqQ2
   7W7ijU2hOludYa2lQVulb4q2XE26agHb1SQvKKg7s9nxN7FE9nbHES3M4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="356861348"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="356861348"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2023 07:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="979718407"
X-IronPort-AV: E=Sophos;i="6.01,170,1684825200"; 
   d="scan'208";a="979718407"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Aug 2023 07:45:37 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qVCLZ-00096u-0l;
        Sun, 13 Aug 2023 14:45:37 +0000
Date:   Sun, 13 Aug 2023 22:45:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Francesco Dolcini <francesco@dolcini.it>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: ti: verdin-am62: Add DSI display support
Message-ID: <202308132205.nYgQd2fC-lkp@intel.com>
References: <20230812191123.14779-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812191123.14779-1-francesco@dolcini.it>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Francesco,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.5-rc5 next-20230809]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Dolcini/arm64-dts-ti-verdin-am62-Add-DSI-display-support/20230813-031349
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230812191123.14779-1-francesco%40dolcini.it
patch subject: [PATCH v1] arm64: dts: ti: verdin-am62: Add DSI display support
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230813/202308132205.nYgQd2fC-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230813/202308132205.nYgQd2fC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308132205.nYgQd2fC-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi:803.1-5 Label or path dss not found
>> Error: arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi:809.1-11 Label or path dss_ports not found
   FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
