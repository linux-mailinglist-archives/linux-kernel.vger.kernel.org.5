Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5987BCC09
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 06:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344349AbjJHEex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 00:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344270AbjJHEev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 00:34:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8D5B9;
        Sat,  7 Oct 2023 21:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696739690; x=1728275690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NpcRZ6upPB6KVeNRqZrx5uGLXTv4ErALZOmRgJWl8rk=;
  b=EjfNxM2QY3Ii7xGZwmskZlAIKQPUOMrFS2ehRH9wdSCNHScr4nKMfQzq
   xf5gbGTTQ5Lku4j5arY7j6zltNW4M4SQeC8mxmxAuWVnpu6aNeMrPso3y
   6f4T6crKkv3b53H0rCYG8joHlA9bQWlmtitYNQOZODafPHaoyg5rSGxEH
   m0XllN4+hEff3DO+7o4/6XI+DVEv5zN0gY/+t19gQLi7uuKEvtOkp5H5m
   25Abp5pMFOmhGqT/bPRlajEK626dq2y64bDMjG4NMKbqdg66+bTN9dts5
   y7zudjJGAlbn1fazCJkPULm3BnIIyHPBDySqc+xnuEmju1jOG5GW/M/Z9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="414969980"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="414969980"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 21:34:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="782128090"
X-IronPort-AV: E=Sophos;i="6.03,207,1694761200"; 
   d="scan'208";a="782128090"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Oct 2023 21:34:45 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpLV5-00057M-1L;
        Sun, 08 Oct 2023 04:34:43 +0000
Date:   Sun, 8 Oct 2023 12:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Xianwei Zhao <xianwei.zhao@amlogic.com>
Subject: Re: [PATCH 2/4] dt-bindings: clock: add Amlogic C3 peripherals clock
 controller bindings
Message-ID: <202310081229.91lXpKLx-lkp@intel.com>
References: <20230928063448.3544464-3-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928063448.3544464-3-xianwei.zhao@amlogic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xianwei,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 57b55c76aaf1ba50ecc6dcee5cd6843dc4d85239]

url:    https://github.com/intel-lab-lkp/linux/commits/Xianwei-Zhao/dt-bindings-clock-add-Amlogic-C3-PLL-clock-controller-bindings/20230928-143707
base:   57b55c76aaf1ba50ecc6dcee5cd6843dc4d85239
patch link:    https://lore.kernel.org/r/20230928063448.3544464-3-xianwei.zhao%40amlogic.com
patch subject: [PATCH 2/4] dt-bindings: clock: add Amlogic C3 peripherals clock controller bindings
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231008/202310081229.91lXpKLx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310081229.91lXpKLx-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:2:1: [error] missing document start "---" (document-start)
>> Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:50:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
--
>> Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml: properties:clocks: 'oneOf' conditional failed, one must be fixed:
   	[{'description': 'input oscillator (usually at 24MHz)'}, {'description': 'input fixed pll'}, {'description': 'input fixed pll div2'}, {'description': 'input fixed pll div2p5'}, {'description': 'input fixed pll div3'}, {'description': 'input fixed pll div4'}, {'description': 'input fixed pll div5'}, {'description': 'input fixed pll div7'}, {'description': 'input gp0 pll'}, {'description': 'input hifi pll'}] is too long
   	[{'description': 'input oscillator (usually at 24MHz)'}, {'description': 'input fixed pll'}, {'description': 'input fixed pll div2'}, {'description': 'input fixed pll div2p5'}, {'description': 'input fixed pll div3'}, {'description': 'input fixed pll div4'}, {'description': 'input fixed pll div5'}, {'description': 'input fixed pll div7'}, {'description': 'input gp0 pll'}, {'description': 'input hifi pll'}] is too short
   	False schema does not allow 10
   	1 was expected
   	10 is greater than the maximum of 2
   	10 is greater than the maximum of 3
   	10 is greater than the maximum of 4
   	10 is greater than the maximum of 5
   	10 is greater than the maximum of 6
   	10 is greater than the maximum of 7
   	10 is greater than the maximum of 8
   	10 is greater than the maximum of 9
   	hint: "minItems" is only needed if less than the "items" list length
   	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
>> Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml: properties:clock-names: 'oneOf' conditional failed, one must be fixed:
   	[{'const': 'xtal'}, {'const': 'fixed_pll'}, {'const': 'fclk_div2'}, {'const': 'fclk_div2p5'}, {'const': 'fclk_div3'}, {'const': 'fclk_div4'}, {'const': 'fclk_div5'}, {'const': 'fclk_div7'}, {'const': 'gp0_pll'}, {'const': 'hifi_pll'}] is too long
   	[{'const': 'xtal'}, {'const': 'fixed_pll'}, {'const': 'fclk_div2'}, {'const': 'fclk_div2p5'}, {'const': 'fclk_div3'}, {'const': 'fclk_div4'}, {'const': 'fclk_div5'}, {'const': 'fclk_div7'}, {'const': 'gp0_pll'}, {'const': 'hifi_pll'}] is too short
   	False schema does not allow 10
   	1 was expected
   	10 is greater than the maximum of 2
   	10 is greater than the maximum of 3
   	10 is greater than the maximum of 4
   	10 is greater than the maximum of 5
   	10 is greater than the maximum of 6
   	10 is greater than the maximum of 7
   	10 is greater than the maximum of 8
   	10 is greater than the maximum of 9
   	hint: "minItems" is only needed if less than the "items" list length
   	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
>> Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:4:1: but found another document
--
>> Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml: ignoring, error parsing file

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
