Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A237D1CE3
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjJULrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjJULrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:47:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1219DD;
        Sat, 21 Oct 2023 04:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697888827; x=1729424827;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ypGCOkg3uS5RcFd6ASv/c0q1iKpdD5tLLBdOxMLsSms=;
  b=faLONxMLP8nwVleGWx9c9eN+lg/WDAHcUg0J1WwR6E6IDgaCxtD4nxR7
   M1mdqf+aJR4v3uTrCkOAQlckLbiGtwNweP98WEMsMenXoLToxRVcQchTB
   bhED5Qkl/Jak0GdtwS6FpyguxLu7c3B2muTlIC3sJ62syZwh16nNPCTxt
   oDWtItU2Myx48du3gifWgWn8EJaeZPcwP7denMf4kLCJLH0Zwk7HJKbyw
   /orKWXSKXhJMp6kdAejR58Hqts9jMX3WJcXkcBEPeQQp5s8faa9J1LiIm
   I7W2arfCLP0oK28nHgwWRLIcfyAeBPwA4Fjb1y3KudTS3p8OXt77NSNBD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="371695616"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="371695616"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2023 04:47:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="823515440"
X-IronPort-AV: E=Sophos;i="6.03,240,1694761200"; 
   d="scan'208";a="823515440"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Oct 2023 04:47:04 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1quARa-0004nG-20;
        Sat, 21 Oct 2023 11:47:02 +0000
Date:   Sat, 21 Oct 2023 19:46:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jyan Chou <jyanchou@realtek.com>, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, jh80.chung@samsung.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        jyanchou@realtek.com
Subject: Re: [PATCH V2][4/4] mmc: Add dt-bindings for realtek mmc driver
Message-ID: <202310211903.42KO5zwa-lkp@intel.com>
References: <20231018055326.18256-5-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018055326.18256-5-jyanchou@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jyan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on ulf-hansson-mmc-mirror/next linus/master v6.6-rc6 next-20231020]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jyan-Chou/mmc-Add-dt-bindings-for-realtek-mmc-driver/20231018-135538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231018055326.18256-5-jyanchou%40realtek.com
patch subject: [PATCH V2][4/4] mmc: Add dt-bindings for realtek mmc driver
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231021/202310211903.42KO5zwa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310211903.42KO5zwa-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml:46:7: [error] string value is redundantly quoted with any quotes (quoted-strings)
>> Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml:46:13: [error] syntax error: expected <block end>, but found '<scalar>' (syntax)
--
>> Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml:46:13: did not find expected key
--
>> Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml: ignoring, error parsing file

vim +46 Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml

     8	
     9	description:
    10	  Realtek uses the Synopsys designware mobile storage host controller
    11	  to interface a SoC with storage medium. This file documents the Realtek
    12	  specific extensions.
    13	
    14	allOf:
    15	  - $ref: synopsys-dw-mshc-common.yaml#
    16	
    17	maintainers:
    18	  - Jyan Chou <jyanchou@realtek.com>
    19	
    20	# Everything else is described in the common file
    21	properties:
    22	  compatible:
    23	    enum:
    24	      - realtek,rtd-dw-cqe-emmc
    25	  reg:
    26	    maxItems: 1
    27	
    28	  interrupts:
    29	    maxItems: 1
    30	
    31	  clocks:
    32	    minItems: 2
    33	    maxItems: 4
    34	    description:
    35	      Handle to "biu" and "ciu" clocks for the bus interface unit clock and
    36	      the card interface unit clock.
    37	
    38	  clock-names:
    39	    minItems: 2
    40	    items:
    41	      - const: biu
    42	      - const: ciu
    43	      - const: vp0
    44	      - const: vp1
    45	    description:
  > 46	      "vp0" and "vp1" are used to control the clock phases.
    47	
    48	  power-domains:
    49	    maxItems: 1
    50	
    51	  resets:
    52	    maxItems: 1
    53	
    54	  reset-names:
    55	    const: reset
    56	
    57	  speed-step:
    58	    maxItems: 1
    59	    description:
    60		"speed-step" represents the bus speed mode of emmc. "3" means HS400,
    61		"2" means HS200, "0" means HS.
    62	
    63	  pinctrl-names:
    64	    maxItems: 10
    65	    items:
    66	      - const: default
    67	      - const: sdr50
    68	      - const: ddr50
    69	      - const: hs200
    70	      - const: hs400
    71	      - const: tune0
    72	      - const: tune1
    73	      - const: tune2
    74	      - const: tune3
    75	      - const: tune4
    76	
    77	required:
    78	  - compatible
    79	  - reg
    80	  - interrupts
    81	  - clocks
    82	  - clock-names
    83	  - pinctrl-names
    84	  - pinctrl
    85	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
