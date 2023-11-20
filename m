Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83297F0E94
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 10:09:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbjKTJJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 04:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbjKTJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 04:09:39 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB36E5;
        Mon, 20 Nov 2023 01:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700471375; x=1732007375;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I89fI9PTT5l0jZ52puX0Apio/xjtpZcVDTQZapvSpQ8=;
  b=PGGkZI0sN02nmxCcx0oa81ebdz9+VeTUpN4xdXlSC5GPqBGl1wmCa4Be
   NxoJ/wdRbI9r3Fj/faAI6G4O05XYIqpjocszLaZw3Sf4DZcJBi9DuREwT
   jKWAY4sMHWdVzE9KFMpZcIkC55/l0Iq9Gwmgka+x38G+OyzsJHzSOoWQF
   EdZVt0NW2mGxRLFqAwt+lOkA8F9wQmgej2ev3SNIog+Wt/BkCq50zudTO
   RkTOTh3o0D3RHAnEiAFPdV609drGb7azXVFL1GMtONEGcq76NTVnooHOL
   b+e4TbRAgfS03Gzvhweb539z1RKGVGRpgdwUyiOiaulO0cj7fER+qiZRY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="370926022"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="370926022"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 01:09:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="832209604"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="832209604"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Nov 2023 01:09:30 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r50HY-0006FH-0G;
        Mon, 20 Nov 2023 09:09:28 +0000
Date:   Mon, 20 Nov 2023 17:08:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev, enachman@marvell.com,
        cyuval@marvell.com
Subject: Re: [PATCH v5 2/3] dt-bindings: arm64: add Marvell COM Express boards
Message-ID: <202311201610.9d8EdO2Y-lkp@intel.com>
References: <20231119102638.1041978-3-enachman@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231119102638.1041978-3-enachman@marvell.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Elad,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.7-rc2 next-20231120]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Elad-Nachman/MAINTAINERS-add-ac5-to-list-of-maintained-Marvell-dts-files/20231119-182821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231119102638.1041978-3-enachman%40marvell.com
patch subject: [PATCH v5 2/3] dt-bindings: arm64: add Marvell COM Express boards
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231120/202311201610.9d8EdO2Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311201610.9d8EdO2Y-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml:64:13: [warning] wrong indentation: expected 10 but found 12 (indentation)

vim +64 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml

     8	
     9	maintainers:
    10	  - Gregory CLEMENT <gregory.clement@bootlin.com>
    11	
    12	properties:
    13	  $nodename:
    14	    const: '/'
    15	  compatible:
    16	    oneOf:
    17	
    18	      - description: Armada 7020 SoC
    19	        items:
    20	          - const: marvell,armada7020
    21	          - const: marvell,armada-ap806-dual
    22	          - const: marvell,armada-ap806
    23	
    24	      - description: Armada 7040 SoC
    25	        items:
    26	          - const: marvell,armada7040
    27	          - const: marvell,armada-ap806-quad
    28	          - const: marvell,armada-ap806
    29	
    30	      - description: Armada 8020 SoC
    31	        items:
    32	          - const: marvell,armada8020
    33	          - const: marvell,armada-ap806-dual
    34	          - const: marvell,armada-ap806
    35	
    36	      - description: Armada 8040 SoC
    37	        items:
    38	          - const: marvell,armada8040
    39	          - const: marvell,armada-ap806-quad
    40	          - const: marvell,armada-ap806
    41	
    42	      - description: Armada CN9130 SoC with no external CP
    43	        items:
    44	          - const: marvell,cn9130
    45	          - const: marvell,armada-ap807-quad
    46	          - const: marvell,armada-ap807
    47	
    48	      - description: Armada CN9131 SoC with one external CP
    49	        items:
    50	          - const: marvell,cn9131
    51	          - const: marvell,cn9130
    52	          - const: marvell,armada-ap807-quad
    53	          - const: marvell,armada-ap807
    54	
    55	      - description: Armada CN9132 SoC with two external CPs
    56	        items:
    57	          - const: marvell,cn9132
    58	          - const: marvell,cn9131
    59	          - const: marvell,cn9130
    60	          - const: marvell,armada-ap807-quad
    61	          - const: marvell,armada-ap807
    62	
    63	      - description:
  > 64	            Alleycat5X (98DX35xx) Reference Design as COM Express Carrier plus
    65	            Armada CN9131 COM Express CPU module
    66	        items:
    67	          - enum:
    68	              - marvell,ac5x-car-with-cn9131
    69	          - const: marvell,rd-ac5x-carrier
    70	          - const: marvell,cn9131-cpu-module
    71	          - const: marvell,cn9131
    72	          - const: marvell,armada-ap807-quad
    73	          - const: marvell,armada-ap807
    74	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
