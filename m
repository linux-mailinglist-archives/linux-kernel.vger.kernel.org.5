Return-Path: <linux-kernel+bounces-19828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B41528274D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F1B221C8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B6C537F7;
	Mon,  8 Jan 2024 16:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPHA5LES"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D0F53815;
	Mon,  8 Jan 2024 16:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704730578; x=1736266578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lHewpDju222Rw/uCNRj6okHLUIGcwtjsBM9ErssIwgg=;
  b=WPHA5LESMDXEa89wVbRyZfQIoamV0QRwu+oZn8eyP29hWX606odhBYiW
   sZoqNB3AXUxuPH6Xs3A6U9zS0tSK99oaZOGAPj101r3Bgx8Cl/Pb8bJIJ
   yk20dnIQW+zo1a6CeF+orHJd6nVukjvTQu+4R23Nc5ShqpYIDYUUrlI7y
   sqWrpS5rw+nOHme6VJHV+KjqsBlODhHUnzznnynfpxdgG/2yEXD5bupr0
   J9AWV6pTpnK+0hX/cd+eKpPi8Wv224m1CUd9Wybgs3fUStIIMbgsq7Oct
   Il9zTl07hgqflZbpC7efkKAoO8H9Tdla7y8CVM6P4Os6wsfNQ3YSI5Z8P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="11274302"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="11274302"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 08:16:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="774549101"
X-IronPort-AV: E=Sophos;i="6.04,180,1695711600"; 
   d="scan'208";a="774549101"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2024 08:16:12 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rMsIL-0004rN-3C;
	Mon, 08 Jan 2024 16:16:09 +0000
Date: Tue, 9 Jan 2024 00:16:08 +0800
From: kernel test robot <lkp@intel.com>
To: Petlozu Pravareshwar <petlozup@nvidia.com>, thierry.reding@gmail.com,
	jonathanh@nvidia.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, dmitry.osipenko@collabora.com,
	ulf.hansson@linaro.org, kkartik@nvidia.com, cai.huoqing@linux.dev,
	spatra@nvidia.com, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, petlozup@nvidia.com
Subject: Re: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an
 optional aperture
Message-ID: <202401090058.4xtTta86-lkp@intel.com>
References: <20240106075134.3933491-2-petlozup@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240106075134.3933491-2-petlozup@nvidia.com>

Hi Petlozu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tegra/for-next]
[also build test WARNING on robh/for-next linus/master v6.7 next-20240108]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petlozu-Pravareshwar/dt-bindings-tegra-pmc-Update-scratch-as-an-optional-aperture/20240106-155615
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
patch link:    https://lore.kernel.org/r/20240106075134.3933491-2-petlozup%40nvidia.com
patch subject: [PATCH 2/3] dt-bindings: tegra: pmc: Update scratch as an optional aperture
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240109/202401090058.4xtTta86-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401090058.4xtTta86-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml:85:12: [warning] wrong indentation: expected 12 but found 11 (indentation)

vim +85 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra186-pmc.yaml

     8	
     9	maintainers:
    10	  - Thierry Reding <thierry.reding@gmail.com>
    11	  - Jon Hunter <jonathanh@nvidia.com>
    12	
    13	properties:
    14	  compatible:
    15	    enum:
    16	      - nvidia,tegra186-pmc
    17	      - nvidia,tegra194-pmc
    18	      - nvidia,tegra234-pmc
    19	
    20	  reg:
    21	    minItems: 4
    22	    maxItems: 5
    23	
    24	  reg-names:
    25	    minItems: 4
    26	    maxItems: 5
    27	
    28	  interrupt-controller: true
    29	
    30	  "#interrupt-cells":
    31	    description: Specifies the number of cells needed to encode an
    32	      interrupt source. The value must be 2.
    33	    const: 2
    34	
    35	  nvidia,invert-interrupt:
    36	    description: If present, inverts the PMU interrupt signal.
    37	    $ref: /schemas/types.yaml#/definitions/flag
    38	
    39	allOf:
    40	  - if:
    41	      properties:
    42	        compatible:
    43	          contains:
    44	            const: nvidia,tegra186-pmc
    45	    then:
    46	      properties:
    47	        reg:
    48	          maxItems: 4
    49	        reg-names:
    50	          items:
    51	            - const: pmc
    52	            - const: wake
    53	            - const: aotag
    54	            - const: scratch
    55	
    56	  - if:
    57	      properties:
    58	        compatible:
    59	          contains:
    60	            const: nvidia,tegra194-pmc
    61	    then:
    62	      properties:
    63	        reg:
    64	          minItems: 5
    65	        reg-names:
    66	          items:
    67	            - const: pmc
    68	            - const: wake
    69	            - const: aotag
    70	            - const: scratch
    71	            - const: misc
    72	
    73	  - if:
    74	      properties:
    75	        compatible:
    76	          contains:
    77	            const: nvidia,tegra234-pmc
    78	    then:
    79	      properties:
    80	        reg:
    81	          minItems: 4
    82	          maxItems: 5
    83	        reg-names:
    84	          anyOf:
  > 85	           - items:
    86	               - const: pmc
    87	               - const: wake
    88	               - const: aotag
    89	               - const: misc
    90	           - items:
    91	               - const: pmc
    92	               - const: wake
    93	               - const: aotag
    94	               - const: scratch
    95	               - const: misc
    96	
    97	patternProperties:
    98	  "^[a-z0-9]+-[a-z0-9]+$":
    99	    if:
   100	      type: object
   101	    then:
   102	      description: |
   103	        These are pad configuration nodes. On Tegra SoCs a pad is a set of
   104	        pins which are configured as a group. The pin grouping is a fixed
   105	        attribute of the hardware. The PMC can be used to set pad power
   106	        state and signaling voltage. A pad can be either in active or
   107	        power down mode. The support for power state and signaling voltage
   108	        configuration varies depending on the pad in question. 3.3 V and
   109	        1.8 V signaling voltages are supported on pins where software
   110	        controllable signaling voltage switching is available.
   111	
   112	        Pad configurations are described with pin configuration nodes
   113	        which are placed under the pmc node and they are referred to by
   114	        the pinctrl client properties. For more information see
   115	
   116	          Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
   117	
   118	        The following pads are present on Tegra186:
   119	
   120	          csia, csib, dsi, mipi-bias, pex-clk-bias, pex-clk3, pex-clk2,
   121	          pex-clk1, usb0, usb1, usb2, usb-bias, uart, audio, hsic, dbg,
   122	          hdmi-dp0, hdmi-dp1, pex-cntrl, sdmmc2-hv, sdmmc4, cam, dsib,
   123	          dsic, dsid, csic, csid, csie, dsif, spi, ufs, dmic-hv, edp,
   124	          sdmmc1-hv, sdmmc3-hv, conn, audio-hv, ao-hv
   125	
   126	        The following pads are present on Tegra194:
   127	
   128	          csia, csib, mipi-bias, pex-clk-bias, pex-clk3, pex-clk2,
   129	          pex-clk1, eqos, pex-clk-2-bias, pex-clk-2, dap3, dap5, uart,
   130	          pwr-ctl, soc-gpio53, audio, gp-pwm2, gp-pwm3, soc-gpio12,
   131	          soc-gpio13, soc-gpio10, uart4, uart5, dbg, hdmi-dp3, hdmi-dp2,
   132	          hdmi-dp0, hdmi-dp1, pex-cntrl, pex-ctl2, pex-l0-rst,
   133	          pex-l1-rst, sdmmc4, pex-l5-rst, cam, csic, csid, csie, csif,
   134	          spi, ufs, csig, csih, edp, sdmmc1-hv, sdmmc3-hv, conn,
   135	          audio-hv, ao-hv
   136	
   137	      properties:
   138	        pins:
   139	          $ref: /schemas/types.yaml#/definitions/string
   140	          description: Must contain the name of the pad(s) to be
   141	            configured.
   142	
   143	        low-power-enable:
   144	          description: Configure the pad into power down mode.
   145	          $ref: /schemas/types.yaml#/definitions/flag
   146	
   147	        low-power-disable:
   148	          description: Configure the pad into active mode.
   149	          $ref: /schemas/types.yaml#/definitions/flag
   150	
   151	        power-source:
   152	          $ref: /schemas/types.yaml#/definitions/uint32
   153	          description: |
   154	            Must contain either TEGRA_IO_PAD_VOLTAGE_1V8 or
   155	            TEGRA_IO_PAD_VOLTAGE_3V3 to select between signalling
   156	            voltages.
   157	
   158	            The values are defined in
   159	
   160	              include/dt-bindings/pinctrl/pinctrl-tegra-io-pad.h
   161	
   162	            The power state can be configured on all of the above pads
   163	            except for ao-hv. Following pads have software configurable
   164	            signaling voltages: sdmmc2-hv, dmic-hv, sdmmc1-hv, sdmmc3-hv,
   165	            audio-hv, ao-hv.
   166	
   167	        phandle: true
   168	
   169	      required:
   170	        - pins
   171	
   172	      additionalProperties: false
   173	
   174	required:
   175	  - compatible
   176	  - reg
   177	  - reg-names
   178	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

