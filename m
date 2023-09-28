Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC1F7B2078
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjI1PGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbjI1PGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:06:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4859E1B2;
        Thu, 28 Sep 2023 08:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695913566; x=1727449566;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=82qSmG45u85QY9VwTRRFaJd3r/P+NKsvrvyVwpqtbJo=;
  b=CssQKIT2MhR0Ai/7OrNKhst6fovx01PK3GbWV2ex7X3eE46sk73YFCys
   RQzPgs//nF0lDBlHG9YsHhBpoPufrRLkHcUHixH5J1LN5PIOC44Wn1d6P
   dNWSw4lYCn3SG0MiLYr7Uv/K0d5S5a+eTJFuSCqCJfgJdE+1l4JenyPeP
   XpZl+EC20JeD8vW/cqK5yRV7R7BB3DwdIKY2a+aR4bS+cvJGtml6VlP6m
   Oi6tBMegtygzR6lG/i8wtyExq69qkkL+lQrzF+He+RvoV2ifcVE3vJggI
   0oqt0xLVeFbE+QVyhi+qH/xua4ctEsy+7SET5tvDaUTZ3owwlYY5gRqSd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="446235863"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="446235863"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 08:06:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="873321351"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="873321351"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 28 Sep 2023 08:06:02 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlsaV-0001aI-1t;
        Thu, 28 Sep 2023 15:05:59 +0000
Date:   Thu, 28 Sep 2023 23:05:07 +0800
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
Message-ID: <202309282224.aGUP85Fs-lkp@intel.com>
References: <20230928063448.3544464-3-xianwei.zhao@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928063448.3544464-3-xianwei.zhao@amlogic.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
reproduce: (https://download.01.org/0day-ci/archive/20230928/202309282224.aGUP85Fs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309282224.aGUP85Fs-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:2:1: [error] missing document start "---" (document-start)
>> Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:50:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
--
>> Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:4:1: but found another document
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
--
>> Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml: ignoring, error parsing file

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
