Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3817F467C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344140AbjKVMm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbjKVMmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:42:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E9D8;
        Wed, 22 Nov 2023 04:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700656969; x=1732192969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SqizgiAch9won05vBf6kAWzFctwB2I+ZrA5SgAqyzfY=;
  b=PxvPBb6w9J1TIWGo34Hg9WG0/XUS3ORzLxjQe5Uq5xocbvnpOOF48eUI
   w+UhqQCZpN/w9XDhPc6hzjSNcGOGeiJw5PgEPt1HEqu07qn4KldCrGFwT
   HVOquZRLz4fb484wmxRtM0dMjEn8fILyoUUHqpvBXQumisHfBfYhMM01j
   fbLkJDoRCBJUEK97O+tpSb8hemOujkvhVqkXWF+wH39842wh5Fnj8S0zp
   R8sTcZs5h3cbbYeAnPrU03VlAi8g2N/v3PXXDkYb3jp+MW4ciWKwr4+wn
   OQo58ayCUx0X03fNTQbSJo83RxupnGbl6kG0+WVToowLKM+TitP/npR3k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="391815110"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="391815110"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:42:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910779563"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="910779563"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Nov 2023 04:42:46 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5mZ2-0000T1-0u;
        Wed, 22 Nov 2023 12:42:44 +0000
Date:   Wed, 22 Nov 2023 20:40:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     "marcelo.schmitt@analog.com" <marcelo.schmitt@analog.com>,
        beniamin.bia@analog.com, paul.cercueil@analog.com,
        Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        marcelo.schmitt1@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] dt-bindings: iio: Add binding documentation for
 AD7091R-8
Message-ID: <202311221707.P5KpelyW-lkp@intel.com>
References: <566503a54feba35178c778a7929bced66ebd8870.1700595310.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <566503a54feba35178c778a7929bced66ebd8870.1700595310.git.marcelo.schmitt1@gmail.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/marcelo-schmitt-analog-com/MAINTAINERS-Add-MAINTAINERS-entry-for-AD7091R/20231122-093706
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/566503a54feba35178c778a7929bced66ebd8870.1700595310.git.marcelo.schmitt1%40gmail.com
patch subject: [PATCH 5/7] dt-bindings: iio: Add binding documentation for AD7091R-8
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311221707.P5KpelyW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311221707.P5KpelyW-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml:50:11: [error] string value is redundantly quoted with any quotes (quoted-strings)

vim +50 Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml

     8	
     9	maintainers:
    10	  - Marcelo Schmitt <marcelo.schmitt@analog.com>
    11	
    12	description: |
    13	  Analog Devices AD7091R-8 8-Channel 12-Bit ADC
    14	  https://www.analog.com/media/en/technical-documentation/data-sheets/AD7091R-2_7091R-4_7091R-8.pdf
    15	
    16	properties:
    17	  compatible:
    18	    enum:
    19	      - adi,ad7091r2
    20	      - adi,ad7091r4
    21	      - adi,ad7091r8
    22	
    23	  reg:
    24	    maxItems: 1
    25	
    26	  vref-supply: true
    27	
    28	  spi-max-frequency: true
    29	
    30	  adi,conversion-start-gpios:
    31	    description:
    32	      Device tree identifier of the CONVST pin.
    33	      This logic input is used to initiate conversions on the analog
    34	      input channels.
    35	    maxItems: 1
    36	
    37	  reset-gpios:
    38	    maxItems: 1
    39	
    40	  interrupts:
    41	    maxItems: 1
    42	
    43	required:
    44	  - compatible
    45	  - reg
    46	  - adi,conversion-start-gpios
    47	
    48	patternProperties:
    49	  "^channel@[0-7]$":
  > 50	    $ref: "adc.yaml"
    51	    type: object
    52	    description: Represents the external channels which are connected to the ADC.
    53	
    54	    properties:
    55	      reg:
    56	        minimum: 0
    57	        maximum: 7
    58	
    59	    required:
    60	      - reg
    61	
    62	allOf:
    63	  - $ref: /schemas/spi/spi-peripheral-props.yaml#
    64	
    65	  # AD7091R-2 does not have ALERT/BUSY/GPO pin
    66	  - if:
    67	      properties:
    68	        compatible:
    69	          contains:
    70	            enum:
    71	              - adi,ad7091r4
    72	              - adi,ad7091r8
    73	    then:
    74	      properties:
    75	        interrupts: true
    76	    else:
    77	      properties:
    78	        interrupts: false
    79	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
