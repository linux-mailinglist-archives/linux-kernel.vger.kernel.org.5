Return-Path: <linux-kernel+bounces-135940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBA689CD8F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376771F24A37
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5673A148FEE;
	Mon,  8 Apr 2024 21:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LUExP6HT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59114884C;
	Mon,  8 Apr 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611512; cv=none; b=Ci+ueJj40BDvlENbmJUVSVsaNMt7T+SGARXQfdbPEE1cb1LsJtajl0HAWhrRRFE8cTvycTgzs3UgdgtjzMwSy+ZqUvqwPwIPsoPHMVbhOu/UMrALAE2ELZE4i6PTq9UYCopkYMBRu44+zf+Z62M09L7e/rvzTM5MIOWSUFK1EpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611512; c=relaxed/simple;
	bh=OtkJqsDRqHxww8gYyHxYwH7UByWcNGjo62aiyrPX3lc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgVXssQGSp3aTIAM/lwUQRh0KaxnsPLVKDEqtcs1UIus0D3S4OlwyocUxHE9OD9ZNrTwqGt5/WE3ExSqTlnOIxnr5iPP/qfidlYdg7iROIBwEC2u4k7rlC3oqjxHXOmcUpwkZBQ8m4VYdsjJ0pmiGvkiTYwvyRRJIm6EHBOsB+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LUExP6HT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712611511; x=1744147511;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OtkJqsDRqHxww8gYyHxYwH7UByWcNGjo62aiyrPX3lc=;
  b=LUExP6HTDW3ik8suWtFUT5nfDt86F4eo9AGFu8Lp3K6j/Zk+mdqOfwcW
   0AudPVZ5KWENMM6cs7fmwd7FOqqohmy4j3BvlX4VBgv7QQX1faHliIdjo
   eIOmKza9Ax5h9CjYTvkrPuBQi4bw94vjPx/hrxbhW4z2yvz1l88qPbqB6
   INx//fWn3ypgNIo7pd8Ppjr+x9/IQbJs1mEsqcDcg+2fiCgwph8S5MxBc
   /GZq1i/wGXq8CrU6KINXoxKq3JL1fRLv+3KRaXtW+6Kgt+bttV2ErIuaA
   jmasy4F/hkRy8kBPlVA5xHg5jTo1FQeIXNMnlZRIyA6hhr/E6A+NNlSZj
   w==;
X-CSE-ConnectionGUID: z4NOf4v6RwKCoplHm01AsA==
X-CSE-MsgGUID: BDR79HD7QbKq0N/9H36u3A==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="25354705"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="25354705"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 14:25:10 -0700
X-CSE-ConnectionGUID: qrO58ha8RyqJHmBfNrQIag==
X-CSE-MsgGUID: cWAhHusrSreh0wQEs4Hnjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="19879521"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 08 Apr 2024 14:25:04 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rtwU9-0005VC-2i;
	Mon, 08 Apr 2024 21:25:01 +0000
Date: Tue, 9 Apr 2024 05:24:16 +0800
From: kernel test robot <lkp@intel.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	oxffffaa@gmail.com, kernel@sberdevices.ru,
	Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <202404090420.FyEkmAU9-lkp@intel.com>
References: <20240408085931.456337-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408085931.456337-2-avkrasnov@salutedevices.com>

Hi Arseniy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mtd/mtd/next]
[also build test WARNING on mtd/mtd/fixes mtd/nand/next robh/for-next linus/master v6.9-rc3 next-20240408]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Arseniy-Krasnov/dt-bindings-mtd-amlogic-meson-nand-support-fields-for-boot-ROM-code/20240408-171119
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
patch link:    https://lore.kernel.org/r/20240408085931.456337-2-avkrasnov%40salutedevices.com
patch subject: [PATCH v2 1/2] dt-bindings: mtd: amlogic,meson-nand: support fields for boot ROM code
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240409/202404090420.FyEkmAU9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404090420.FyEkmAU9-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml:84:61: [warning] too few spaces after comma (commas)
   Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml:85:61: [warning] too few spaces after comma (commas)

vim +84 Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml

     8	
     9	allOf:
    10	  - $ref: nand-controller.yaml
    11	
    12	maintainers:
    13	  - liang.yang@amlogic.com
    14	
    15	properties:
    16	  compatible:
    17	    enum:
    18	      - amlogic,meson-gxl-nfc
    19	      - amlogic,meson-axg-nfc
    20	
    21	  reg:
    22	    maxItems: 2
    23	
    24	  reg-names:
    25	    items:
    26	      - const: nfc
    27	      - const: emmc
    28	
    29	  interrupts:
    30	    maxItems: 1
    31	
    32	  clocks:
    33	    minItems: 2
    34	
    35	  clock-names:
    36	    items:
    37	      - const: core
    38	      - const: device
    39	
    40	patternProperties:
    41	  "^nand@[0-7]$":
    42	    type: object
    43	    $ref: raw-nand-chip.yaml
    44	    properties:
    45	      reg:
    46	        minimum: 0
    47	        maximum: 1
    48	
    49	      nand-ecc-mode:
    50	        const: hw
    51	
    52	      nand-ecc-step-size:
    53	        enum: [512, 1024]
    54	
    55	      nand-ecc-strength:
    56	        enum: [8, 16, 24, 30, 40, 50, 60]
    57	        description: |
    58	          The ECC configurations that can be supported are as follows.
    59	            meson-gxl-nfc 8, 16, 24, 30, 40, 50, 60
    60	            meson-axg-nfc 8
    61	
    62	      nand-rb:
    63	        maxItems: 1
    64	        items:
    65	          maximum: 0
    66	
    67	      amlogic,boot-page-last:
    68	        $ref: /schemas/types.yaml#/definitions/uint32
    69	        description:
    70	          The NFC driver needs this information to select ECC
    71	          algorithms supported by the boot ROM.
    72	
    73	      amlogic,boot-page-step:
    74	        $ref: /schemas/types.yaml#/definitions/uint32
    75	        description:
    76	          The NFC driver needs this information to select ECC
    77	          algorithms supported by the boot ROM (in pages).
    78	
    79	    unevaluatedProperties: false
    80	
    81	    dependencies:
    82	      nand-ecc-strength: [nand-ecc-step-size]
    83	      nand-ecc-step-size: [nand-ecc-strength]
  > 84	      amlogic,boot-page-last: [nand-is-boot-medium, amlogic,boot-page-step]
    85	      amlogic,boot-page-step: [nand-is-boot-medium, amlogic,boot-page-last]
    86	
    87	
    88	required:
    89	  - compatible
    90	  - reg
    91	  - interrupts
    92	  - clocks
    93	  - clock-names
    94	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

