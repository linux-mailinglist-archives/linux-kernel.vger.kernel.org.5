Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F29E76535D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjG0MNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjG0MNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:13:30 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFE12719;
        Thu, 27 Jul 2023 05:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690460009; x=1721996009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5uIFR6uMssEWsFWrPUBKU4Ccoe4vSSRYqdWErrCk1QM=;
  b=nD5da08hrqWZYfqxY9qqHyZQJV/OR/is6Z4dQiCsj3sYtrr65ht50r4N
   RqlcRb4fEHzsV2RjKLiL+QIByotFcKe9CrWAoiwbnCys29oa8nRcbiKil
   SahW4RvEv+YlemunI1ggldFablRhvEtQFmgkJicWo93aViMOoAkyQBHbQ
   vb0BlWado5gm7YsHAY77peGoK9AqGPUMj3ffuj2mq+eEgtYKJjp6d/OsF
   L7C1eAViWAEUIl/RB9fQ+NqiUhtZHJAsLHnKIDWhRXMh7smaULSzPQskM
   As4rI95H+VNH76LQBRPWWb1Efp9o+bHJXatTGVFK5U/w4Syh34m9xzh6S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367167844"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="367167844"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 05:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="730252652"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="730252652"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jul 2023 05:06:02 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOzkn-0002Fk-2Y;
        Thu, 27 Jul 2023 12:06:01 +0000
Date:   Thu, 27 Jul 2023 20:05:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Charles Boyer <Charles.Boyer@fii-usa.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Benjamin Fair <benjaminfair@google.com>,
        Vivekanand Veeracholan <vveerach@google.com>,
        Lancelot Kao <lancelot.cy.kao@fii-na.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Charles Boyer <Charles.Boyer@fii-usa.com>
Subject: Re: [PATCH] ARM: dts: nuvoton: Add Fii Mori system
Message-ID: <202307271949.TXhf41ue-lkp@intel.com>
References: <20230726184651.1221-1-Charles.Boyer@fii-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726184651.1221-1-Charles.Boyer@fii-usa.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Charles,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.5-rc3 next-20230727]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Charles-Boyer/ARM-dts-nuvoton-Add-Fii-Mori-system/20230727-024931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230726184651.1221-1-Charles.Boyer%40fii-usa.com
patch subject: [PATCH] ARM: dts: nuvoton: Add Fii Mori system
config: arm-randconfig-r046-20230726 (https://download.01.org/0day-ci/archive/20230727/202307271949.TXhf41ue-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230727/202307271949.TXhf41ue-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307271949.TXhf41ue-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:649.1-6 Label or path emc0 not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:662.1-7 Label or path ohci1 not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:666.1-5 Label or path aes not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:670.1-5 Label or path sha not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:761.1-8 Label or path sdhci0 not found
   Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:769.1-7 Label or path ohci1 not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:773.1-6 Label or path vdma not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:777.1-9 Label or path pcimbox not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:781.1-5 Label or path vcd not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:785.1-5 Label or path ece not found
>> Error: arch/arm/boot/dts/nuvoton/nuvoton-npcm730-mori.dts:818.1-5 Label or path otp not found
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
