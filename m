Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD857F397C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 23:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbjKUWw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 17:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjKUWw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 17:52:27 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEB6BB;
        Tue, 21 Nov 2023 14:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700607143; x=1732143143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6+g96D1uXgJOhDkq1ma1Sy1l9Wrpt2ZIVG+Q/XijQcE=;
  b=ZBG65u+fAuENuWTGkvcaNMkv+WlcJW1JPGm/+tiCYUQdV3JZcHZkGVrY
   hs/ueWDj3jS9hlrav2dvuFPQv6spWjomYRsR04xIgsh94o1wYaRbZDXa7
   fUsA26bdeoa5boJcS9fomYKnOOMA0/7B6j0Sg/5tX5D1LN37RvW0GOeac
   GNo2U6DgxA+M6c/bj9Q2B43TrelsaMxkOYZHAtg2NYLllHoTSo+4+seDP
   c6dWfI+GnF4QUErdIsXMcJWfC7u59POfxhz+Q8ANxFM3LDpr8qMpnpbJ0
   iD3O/gtK17zCzVTlNXEm2jktWJvrKolCD1jqBPS7cQz8wTLS9+PxpABpb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="371290747"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="371290747"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 14:52:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="837191859"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; 
   d="scan'208";a="837191859"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2023 14:52:20 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5ZbO-0008Mo-1A;
        Tue, 21 Nov 2023 22:52:18 +0000
Date:   Wed, 22 Nov 2023 06:52:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kim Seer Paller <kimseer.paller@analog.com>
Cc:     oe-kbuild-all@lists.linux.dev, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kim Seer Paller <kimseer.paller@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: frequency: add admfm2000
Message-ID: <202311220624.J7Nqg5h1-lkp@intel.com>
References: <20231121100012.112861-1-kimseer.paller@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121100012.112861-1-kimseer.paller@analog.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kim,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 98b1cc82c4affc16f5598d4fa14b1858671b2263]

url:    https://github.com/intel-lab-lkp/linux/commits/Kim-Seer-Paller/iio-frequency-admfm2000-New-driver/20231121-180427
base:   98b1cc82c4affc16f5598d4fa14b1858671b2263
patch link:    https://lore.kernel.org/r/20231121100012.112861-1-kimseer.paller%40analog.com
patch subject: [PATCH v2 1/2] dt-bindings: iio: frequency: add admfm2000
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231122/202311220624.J7Nqg5h1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311220624.J7Nqg5h1-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml:14:5: [warning] wrong indentation: expected 2 but found 4 (indentation)

vim +14 Documentation/devicetree/bindings/iio/frequency/adi,admfm2000.yaml

     9	
    10	maintainers:
    11	  - Kim Seer Paller <kimseer.paller@analog.com>
    12	
    13	description:
  > 14	    Dual microwave down converter module with input RF and LO frequency ranges
    15	    from 0.5 to 32 GHz and an output IF frequency range from 0.1 to 8 GHz.
    16	    It consists of a LNA, mixer, IF filter, DSA, and IF amplifier for each down
    17	    conversion path.
    18	
    19	properties:
    20	  compatible:
    21	    enum:
    22	      - adi,admfm2000
    23	
    24	  switch1-gpios:
    25	    description:
    26	      Must contain an array of 2 GPIO specifiers, referring to the GPIO pins
    27	      connected to the B15 and B16.
    28	    minItems: 2
    29	    maxItems: 2
    30	
    31	  switch2-gpios:
    32	    description:
    33	      Must contain an array of 2 GPIO specifiers, referring to the GPIO pins
    34	      connected to the L14 and K14.
    35	    minItems: 2
    36	    maxItems: 2
    37	
    38	  attenuation1-gpios:
    39	    description:
    40	      Must contain an array of 5 GPIO specifiers, referring to the GPIO pins
    41	      connected to the C14, C15, C16, D14, and D15.
    42	    minItems: 5
    43	    maxItems: 5
    44	
    45	  attenuation2-gpios:
    46	    description:
    47	      Must contain an array of 5 GPIO specifiers, referring to the GPIO pins
    48	      connected to the L15, L16, M14, M15, and M16.
    49	    minItems: 5
    50	    maxItems: 5
    51	
    52	  '#address-cells':
    53	    const: 1
    54	
    55	  '#size-cells':
    56	    const: 0
    57	
    58	patternProperties:
    59	  "^channel@[0-1]$":
    60	    type: object
    61	    description: Represents a channel of the device.
    62	
    63	    additionalProperties: false
    64	
    65	    properties:
    66	      reg:
    67	        description:
    68	          The channel number.
    69	        minimum: 0
    70	        maximum: 1
    71	
    72	      adi,mode:
    73	        description:
    74	          RF path selected for the channel.
    75	            0 - Direct IF mode
    76	            1 - Mixer mode
    77	        $ref: /schemas/types.yaml#/definitions/uint32
    78	        enum: [0, 1]
    79	
    80	    required:
    81	      - reg
    82	      - adi,mode
    83	
    84	required:
    85	  - compatible
    86	  - switch1-gpios
    87	  - switch2-gpios
    88	  - attenuation1-gpios
    89	  - attenuation2-gpios
    90	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
