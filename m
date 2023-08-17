Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E079677F1D3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 10:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348750AbjHQIIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 04:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348792AbjHQIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 04:07:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7A52D5D;
        Thu, 17 Aug 2023 01:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692259676; x=1723795676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KychCsHzKBpmzeBVOBfgQM/sUcx1OtGZqhI1w+uM8yI=;
  b=nWWNYuLA4WrTxzem1/8hq5GFaN01YiH2SyE1BFGHsPv9ActEtIb7GjNk
   z6A5n6uoGLAgaRfwwjdyRfralEwdVvBUtjvoNaodOSfbE1+JYCfil9EyH
   myu8pTfcTCi2frCHgvdLg6n4oPDYyyNhDVZAT8LaL4FuuXFnG6yWMMoK8
   YJC3eEnyx1WGis4jSmg8GVtmoE6dJ1nxAc2p0BpmXSZcNUbq/frXqjTYP
   +HU6IQbQ+c9l/UVc6+INr+GmwbD1TiImbwF4Ies2+jCFECX+vqStp1GLc
   2WE7Z8zeVwBw2DkzUoytk7Zk7QNAJ3iO2FKJK/dQ1yremWuCLQ2IY3MGL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362896132"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="362896132"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 01:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769522322"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="769522322"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 17 Aug 2023 01:07:47 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWY2i-0000vz-10;
        Thu, 17 Aug 2023 08:07:45 +0000
Date:   Thu, 17 Aug 2023 16:06:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bhavya Kapoor <b-kapoor@ti.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, nm@ti.com,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, b-kapoor@ti.com
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add support for MCAN
 interfaces
Message-ID: <202308171509.khN4qjEZ-lkp@intel.com>
References: <20230816193533.25722-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816193533.25722-1-b-kapoor@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhavya,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.5-rc6 next-20230817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bhavya-Kapoor/arm64-dts-ti-k3-j784s4-evm-Add-support-for-MCAN-interfaces/20230817-033647
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230816193533.25722-1-b-kapoor%40ti.com
patch subject: [PATCH] arm64: dts: ti: k3-j784s4-evm: Add support for MCAN interfaces
config: arm64-randconfig-r032-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171509.khN4qjEZ-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171509.khN4qjEZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171509.khN4qjEZ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm64/boot/dts/ti/k3-j784s4-evm.dts:897.1-10 syntax error
>> FATAL ERROR: Unable to parse input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
