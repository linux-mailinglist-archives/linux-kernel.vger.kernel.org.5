Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25D47F8722
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 01:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjKYATi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 19:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjKYATg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 19:19:36 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4013D1702;
        Fri, 24 Nov 2023 16:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700871583; x=1732407583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iLP05fkKOzGIHxGNx03aMn6ovWzCBiK0R9NEQfaGx5k=;
  b=c3MslqqgPtEg9VZC0fY+poNJe4lgJgi/rH8ndnZfQFKpxgIhjgeq4L8z
   uFt3lzmxnJhpoggo9U7Z8qHNVq+GKoo2ImgflnSVGUoelDTvgWiUXWEcZ
   PMdjLJE4MlaaS9JJMmRGFSa5AFCgnS3daMJwqbTg9KtXRlZebSP1g/ykM
   9kVvy15cSX4nf3bgZWyDVzpyTvkNLAVM26+sWNhGOjw+ZRsYT67wpvDpe
   hPJxjmboqPxn1+RZGsannjAbKB7UFy/W7GvGw9FdE8Bwccu4AUAufrej+
   KMb2QLVjgV9O+O+o4Lx8gLi81hb0u+PdeehOpSQD7aCnfGua97IJAQggp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="391350895"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="391350895"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 16:19:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="911558727"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="911558727"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 24 Nov 2023 16:19:38 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6gOW-0003Qk-2H;
        Sat, 25 Nov 2023 00:19:36 +0000
Date:   Sat, 25 Nov 2023 08:18:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ante Knezic <ante.knezic@helmholz.de>, netdev@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, woojung.huh@microchip.com,
        andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        marex@denx.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ante Knezic <ante.knezic@helmholz.de>
Subject: Re: [PATCH net-next v5 1/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <202311250528.gG5FVdW6-lkp@intel.com>
References: <0ea1db6b2f2e93c3531645f98888775a4d3165d4.1700841353.git.ante.knezic@helmholz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea1db6b2f2e93c3531645f98888775a4d3165d4.1700841353.git.ante.knezic@helmholz.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ante,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Ante-Knezic/dt-bindings-net-microchip-ksz-document-microchip-rmii-clk-internal/20231125-000625
base:   net-next/main
patch link:    https://lore.kernel.org/r/0ea1db6b2f2e93c3531645f98888775a4d3165d4.1700841353.git.ante.knezic%40helmholz.de
patch subject: [PATCH net-next v5 1/2] dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231125/202311250528.gG5FVdW6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311250528.gG5FVdW6-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:99:1: [error] syntax error: found character '\t' that cannot start any token (syntax)
--
>> Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml:99:1: found character that cannot start any token
--
>> Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml: ignoring, error parsing file

vim +99 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml

     8	
     9	maintainers:
    10	  - Marek Vasut <marex@denx.de>
    11	  - Woojung Huh <Woojung.Huh@microchip.com>
    12	
    13	allOf:
    14	  - $ref: /schemas/spi/spi-peripheral-props.yaml#
    15	
    16	properties:
    17	  # See Documentation/devicetree/bindings/net/dsa/dsa.yaml for a list of additional
    18	  # required and optional properties.
    19	  compatible:
    20	    enum:
    21	      - microchip,ksz8765
    22	      - microchip,ksz8794
    23	      - microchip,ksz8795
    24	      - microchip,ksz8863
    25	      - microchip,ksz8873
    26	      - microchip,ksz9477
    27	      - microchip,ksz9897
    28	      - microchip,ksz9896
    29	      - microchip,ksz9567
    30	      - microchip,ksz8565
    31	      - microchip,ksz9893
    32	      - microchip,ksz9563
    33	      - microchip,ksz8563
    34	
    35	  reset-gpios:
    36	    description:
    37	      Should be a gpio specifier for a reset line.
    38	    maxItems: 1
    39	
    40	  wakeup-source: true
    41	
    42	  microchip,synclko-125:
    43	    $ref: /schemas/types.yaml#/definitions/flag
    44	    description:
    45	      Set if the output SYNCLKO frequency should be set to 125MHz instead of 25MHz.
    46	
    47	  microchip,synclko-disable:
    48	    $ref: /schemas/types.yaml#/definitions/flag
    49	    description:
    50	      Set if the output SYNCLKO clock should be disabled. Do not mix with
    51	      microchip,synclko-125.
    52	
    53	  microchip,io-drive-strength-microamp:
    54	    description:
    55	      IO Pad Drive Strength
    56	    enum: [8000, 16000]
    57	    default: 16000
    58	
    59	  microchip,hi-drive-strength-microamp:
    60	    description:
    61	      High Speed Drive Strength. Controls drive strength of GMII / RGMII /
    62	      MII / RMII (except TX_CLK/REFCLKI, COL and CRS) and CLKO_25_125 lines.
    63	    enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
    64	    default: 24000
    65	
    66	  microchip,lo-drive-strength-microamp:
    67	    description:
    68	      Low Speed Drive Strength. Controls drive strength of TX_CLK / REFCLKI,
    69	      COL, CRS, LEDs, PME_N, NTRP_N, SDO and SDI/SDA/MDIO lines.
    70	    enum: [2000, 4000, 8000, 12000, 16000, 20000, 24000, 28000]
    71	    default: 8000
    72	
    73	  interrupts:
    74	    maxItems: 1
    75	
    76	required:
    77	  - compatible
    78	  - reg
    79	
    80	if:
    81	  not:
    82	    properties:
    83	      compatible:
    84	        enum:
    85	          - microchip,ksz8863
    86	          - microchip,ksz8873
    87	then:
    88	  $ref: dsa.yaml#/$defs/ethernet-ports
    89	else:
    90	  patternProperties:
    91	    "^(ethernet-)?ports$":
    92	      patternProperties:
    93	        "^(ethernet-)?port@[0-2]$":
    94	          $ref: dsa-port.yaml#
    95	          properties:
    96	            microchip,rmii-clk-internal:
    97	              $ref: /schemas/types.yaml#/definitions/flag
    98	              description:
  > 99		        When ksz88x3 is acting as clock provier (via REFCLKO) it
   100			can select between internal and external RMII reference
   101			clock. Internal reference clock means that the clock for
   102			the RMII of ksz88x3 is provided by the ksz88x3 internally
   103			and the REFCLKI pin is unconnected. For the external
   104			reference clock, the clock needs to be fed back to ksz88x3
   105			via REFCLKI.
   106			If microchip,rmii-clk-internal is set, ksz88x3 will provide
   107			rmii reference clock internally, otherwise reference clock
   108			should be provided externally.
   109	          if:
   110	            not:
   111	              required: [ ethernet ]
   112	          then:
   113	            properties:
   114	              microchip,rmii-clk-internal: false
   115	          unevaluatedProperties: false
   116	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
