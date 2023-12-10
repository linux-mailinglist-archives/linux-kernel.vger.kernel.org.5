Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A1780B8EB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 06:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjLJETW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjLJETS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:19:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC64FF2;
        Sat,  9 Dec 2023 20:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702181963; x=1733717963;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=asvKB3ReQvJ+jiqRWBtIOZ61VkP+wjyfmq7Jgp5pQkw=;
  b=MpeKQgpGJ0z4uA1+f36OVE+zmhnX0Q2pN12/pvgyT0qw7+Zz2EUK36VJ
   8hVCLfiINGnqfdirwaCbE/7AyWm2t02PISndqOkI+QN0tVXFnwGg5kcs0
   u3lDLoJNi061LQgIAVmn3Qbtxjd+jLfD5G7Lm7d63+qeGFwxoRPKUk497
   GVF68fJOlTHAzqW2WAW1YnFvS+v03/UOxL0VPov4Hfh0nheMoSuJbEwq7
   spjGBya2YwBKiGQywYmOKwUhTynJgd7Wr+AB2Vs9N3Vrhd4/qNp78dJir
   708053qtFLQuq0WnEhAFne1Exjx0pYobwcMK2pfRoiOZakH60NFUs4hyj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="458851117"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="458851117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2023 20:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10919"; a="890647084"
X-IronPort-AV: E=Sophos;i="6.04,265,1695711600"; 
   d="scan'208";a="890647084"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 09 Dec 2023 20:19:19 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCBHh-000GNr-1g;
        Sun, 10 Dec 2023 04:19:17 +0000
Date:   Sun, 10 Dec 2023 12:18:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kamal Dasu <kamal.dasu@broadcom.com>, ulf.hansson@linaro.org,
        linux-kernel@vger.kernel.org, alcooperx@gmail.com,
        linux-arm-kernel@lists.infradead.org, adrian.hunter@intel.com,
        linux-mmc@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com,
        Kamal Dasu <kdasu@broadcom.com>
Subject: Re: [V3, 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for
 74165b0
Message-ID: <202312101146.IK4Nrw1S-lkp@intel.com>
References: <20231209165816.39044-1-kamal.dasu@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209165816.39044-1-kamal.dasu@broadcom.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kamal,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on soc/for-next linus/master v6.7-rc4 next-20231208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamal-Dasu/mmc-add-new-sdhci-reset-sequence-for-brcm-74165b0/20231210-010145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20231209165816.39044-1-kamal.dasu%40broadcom.com
patch subject: [V3, 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: Add support for 74165b0
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231210/202312101146.IK4Nrw1S-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312101146.IK4Nrw1S-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml:25:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
--
>> Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml:25:1: found a tab character that violates indentation
   Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,pmin-pascal: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
   Documentation/devicetree/bindings/iio/pressure/honeywell,mprls0025pa.yaml: properties:honeywell,pmax-pascal: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
--
>> Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml: ignoring, error parsing file

vim +25 Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml

50c4ef6b8ab7d1 Florian Fainelli    2021-12-07   8  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07   9  maintainers:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  10    - Al Cooper <alcooperx@gmail.com>
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  11    - Florian Fainelli <f.fainelli@gmail.com>
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  12  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  13  properties:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  14    compatible:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  15      oneOf:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  16        - items:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  17            - enum:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  18                - brcm,bcm7216-sdhci
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  19            - const: brcm,bcm7445-sdhci
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  20            - const: brcm,sdhci-brcmstb
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  21        - items:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  22            - enum:
48e24385c58e80 Kamal Dasu          2023-12-09  23                - brcm,bcm74165b0-sdhci
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  24                - brcm,bcm7445-sdhci
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07 @25  	      - brcm,bcm7425-sdhci
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  26            - const: brcm,sdhci-brcmstb
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  27  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  28    reg:
b16ebda6d00361 Krzysztof Kozlowski 2022-04-28  29      maxItems: 2
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  30  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  31    reg-names:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  32      items:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  33        - const: host
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  34        - const: cfg
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  35  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  36    interrupts:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  37      maxItems: 1
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  38  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  39    clocks:
2f8690ef64128b Kamal Dasu          2022-05-20  40      minItems: 1
2f8690ef64128b Kamal Dasu          2022-05-20  41      items:
2f8690ef64128b Kamal Dasu          2022-05-20  42        - description: handle to core clock for the sdhci controller
2f8690ef64128b Kamal Dasu          2022-05-20  43        - description: handle to improved 150Mhz clock for sdhci controller (Optional clock)
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  44  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  45    clock-names:
2f8690ef64128b Kamal Dasu          2022-05-20  46      minItems: 1
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  47      items:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  48        - const: sw_sdio
2f8690ef64128b Kamal Dasu          2022-05-20  49        - const: sdio_freq # Optional clock
2f8690ef64128b Kamal Dasu          2022-05-20  50  
2f8690ef64128b Kamal Dasu          2022-05-20  51    clock-frequency:
2f8690ef64128b Kamal Dasu          2022-05-20  52      description:
2f8690ef64128b Kamal Dasu          2022-05-20  53        Maximum operating frequency of sdio_freq sdhci controller clock
2f8690ef64128b Kamal Dasu          2022-05-20  54      $ref: /schemas/types.yaml#/definitions/uint32
2f8690ef64128b Kamal Dasu          2022-05-20  55      minimum: 100000000
2f8690ef64128b Kamal Dasu          2022-05-20  56      maximum: 150000000
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  57  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  58    sdhci,auto-cmd12:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  59      type: boolean
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  60      description: Specifies that controller should use auto CMD12
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  61  
2f8690ef64128b Kamal Dasu          2022-05-20  62  allOf:
2f8690ef64128b Kamal Dasu          2022-05-20  63    - $ref: mmc-controller.yaml#
2f8690ef64128b Kamal Dasu          2022-05-20  64    - if:
2f8690ef64128b Kamal Dasu          2022-05-20  65        properties:
2f8690ef64128b Kamal Dasu          2022-05-20  66          clock-names:
2f8690ef64128b Kamal Dasu          2022-05-20  67            contains:
2f8690ef64128b Kamal Dasu          2022-05-20  68              const: sdio_freq
2f8690ef64128b Kamal Dasu          2022-05-20  69  
2f8690ef64128b Kamal Dasu          2022-05-20  70      then:
2f8690ef64128b Kamal Dasu          2022-05-20  71        required:
2f8690ef64128b Kamal Dasu          2022-05-20  72          - clock-frequency
2f8690ef64128b Kamal Dasu          2022-05-20  73  
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  74  required:
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  75    - compatible
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  76    - reg
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  77    - interrupts
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  78    - clocks
2f8690ef64128b Kamal Dasu          2022-05-20  79    - clock-names
50c4ef6b8ab7d1 Florian Fainelli    2021-12-07  80  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
