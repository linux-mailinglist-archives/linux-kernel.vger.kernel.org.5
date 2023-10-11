Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86C77C4C0D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 09:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344796AbjJKHhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJKHhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 03:37:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C3E1;
        Wed, 11 Oct 2023 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697009860; x=1728545860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i869bTlkDvlvhw+3PFO7u3lAm6RWC1HKuCi+xwZmGyQ=;
  b=H7QuN7NGYg4FUpYhqWdpAF989OcVVOIZn78eKmJnL/c4iK6cm+BOkUgD
   5+wg0L2CcAGhhwEr0mqwBOK9C36P8bs9oWKTl8lotEKmiTGiOUBtSBc4O
   lP8DrmKJzBAhxO6tZvp8I2daBIYrMjxBebz7rVQHhymuZlpDzFX9SFlsk
   0MTm50yOC6aN/8xNJj5xyDTbXsNZJXhLVe54e65RdQ2dWLF77wljkqq3x
   9oEwrCkNVSG1gO5vXTfmBrlZbZRGs4U2RD0xYX8isgwzmhaQE+W13p2z9
   ulfzeFwhQYJ9qOb1tj6XR0S/lnaiJts9V1NwJGkCtQoMktBlRXEPWCPBk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="3193853"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="3193853"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 00:37:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="877573199"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="877573199"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Oct 2023 00:37:34 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqTme-0001vq-1U;
        Wed, 11 Oct 2023 07:37:32 +0000
Date:   Wed, 11 Oct 2023 15:37:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maramaina Naresh <quic_mnaresh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_nguyenb@quicinc.com
Subject: Re: [PATCH V1 1/4] dt-bindings: ufs: qcom: Add qos property
Message-ID: <202310111509.fFHOVdaI-lkp@intel.com>
References: <1696952947-18062-2-git-send-email-quic_mnaresh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696952947-18062-2-git-send-email-quic_mnaresh@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maramaina,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next robh/for-next linus/master v6.6-rc5 next-20231010]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maramaina-Naresh/dt-bindings-ufs-qcom-Add-qos-property/20231010-235602
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/1696952947-18062-2-git-send-email-quic_mnaresh%40quicinc.com
patch subject: [PATCH V1 1/4] dt-bindings: ufs: qcom: Add qos property
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231011/202310111509.fFHOVdaI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310111509.fFHOVdaI-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml:83:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
   Documentation/devicetree/bindings/ufs/qcom,ufs.yaml:85:6: [warning] wrong indentation: expected 6 but found 5 (indentation)
--
>> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: properties:qos: 'anyOf' conditional failed, one must be fixed:
   	'cpumask' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
   	'type' was expected
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
>> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: properties:qos: 'anyOf' conditional failed, one must be fixed:
   	'vote' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
   	'type' was expected
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

vim +83 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml

     8	
     9	maintainers:
    10	  - Bjorn Andersson <bjorn.andersson@linaro.org>
    11	  - Andy Gross <agross@kernel.org>
    12	
    13	# Select only our matches, not all jedec,ufs-2.0
    14	select:
    15	  properties:
    16	    compatible:
    17	      contains:
    18	        const: qcom,ufshc
    19	  required:
    20	    - compatible
    21	
    22	properties:
    23	  compatible:
    24	    items:
    25	      - enum:
    26	          - qcom,msm8994-ufshc
    27	          - qcom,msm8996-ufshc
    28	          - qcom,msm8998-ufshc
    29	          - qcom,sa8775p-ufshc
    30	          - qcom,sc8280xp-ufshc
    31	          - qcom,sdm845-ufshc
    32	          - qcom,sm6115-ufshc
    33	          - qcom,sm6350-ufshc
    34	          - qcom,sm8150-ufshc
    35	          - qcom,sm8250-ufshc
    36	          - qcom,sm8350-ufshc
    37	          - qcom,sm8450-ufshc
    38	          - qcom,sm8550-ufshc
    39	      - const: qcom,ufshc
    40	      - const: jedec,ufs-2.0
    41	
    42	  clocks:
    43	    minItems: 8
    44	    maxItems: 11
    45	
    46	  clock-names:
    47	    minItems: 8
    48	    maxItems: 11
    49	
    50	  dma-coherent: true
    51	
    52	  interconnects:
    53	    minItems: 2
    54	    maxItems: 2
    55	
    56	  interconnect-names:
    57	    items:
    58	      - const: ufs-ddr
    59	      - const: cpu-ufs
    60	
    61	  iommus:
    62	    minItems: 1
    63	    maxItems: 2
    64	
    65	  phys:
    66	    maxItems: 1
    67	
    68	  phy-names:
    69	    items:
    70	      - const: ufsphy
    71	
    72	  power-domains:
    73	    maxItems: 1
    74	
    75	  qcom,ice:
    76	    $ref: /schemas/types.yaml#/definitions/phandle
    77	    description: phandle to the Inline Crypto Engine node
    78	
    79	  qos:
    80	    minItems: 2
    81	    maxItems: 2
    82	    cpumask:
  > 83	     description: list of CPUs under CPU group
    84	    vote:
    85	     description: vote value for QoS CPU group
    86	
    87	  reg:
    88	    minItems: 1
    89	    maxItems: 2
    90	
    91	  reg-names:
    92	    items:
    93	      - const: std
    94	      - const: ice
    95	
    96	  required-opps:
    97	    maxItems: 1
    98	
    99	  resets:
   100	    maxItems: 1
   101	
   102	  '#reset-cells':
   103	    const: 1
   104	
   105	  reset-names:
   106	    items:
   107	      - const: rst
   108	
   109	  reset-gpios:
   110	    maxItems: 1
   111	    description:
   112	      GPIO connected to the RESET pin of the UFS memory device.
   113	
   114	required:
   115	  - compatible
   116	  - reg
   117	
   118	allOf:
   119	  - $ref: ufs-common.yaml
   120	
   121	  - if:
   122	      properties:
   123	        compatible:
   124	          contains:
   125	            enum:
   126	              - qcom,msm8998-ufshc
   127	              - qcom,sa8775p-ufshc
   128	              - qcom,sc8280xp-ufshc
   129	              - qcom,sm8250-ufshc
   130	              - qcom,sm8350-ufshc
   131	              - qcom,sm8450-ufshc
   132	              - qcom,sm8550-ufshc
   133	    then:
   134	      properties:
   135	        clocks:
   136	          minItems: 8
   137	          maxItems: 8
   138	        clock-names:
   139	          items:
   140	            - const: core_clk
   141	            - const: bus_aggr_clk
   142	            - const: iface_clk
   143	            - const: core_clk_unipro
   144	            - const: ref_clk
   145	            - const: tx_lane0_sync_clk
   146	            - const: rx_lane0_sync_clk
   147	            - const: rx_lane1_sync_clk
   148	        reg:
   149	          minItems: 1
   150	          maxItems: 1
   151	        reg-names:
   152	          maxItems: 1
   153	
   154	  - if:
   155	      properties:
   156	        compatible:
   157	          contains:
   158	            enum:
   159	              - qcom,sdm845-ufshc
   160	              - qcom,sm6350-ufshc
   161	              - qcom,sm8150-ufshc
   162	    then:
   163	      properties:
   164	        clocks:
   165	          minItems: 9
   166	          maxItems: 9
   167	        clock-names:
   168	          items:
   169	            - const: core_clk
   170	            - const: bus_aggr_clk
   171	            - const: iface_clk
   172	            - const: core_clk_unipro
   173	            - const: ref_clk
   174	            - const: tx_lane0_sync_clk
   175	            - const: rx_lane0_sync_clk
   176	            - const: rx_lane1_sync_clk
   177	            - const: ice_core_clk
   178	        reg:
   179	          minItems: 2
   180	          maxItems: 2
   181	        reg-names:
   182	          minItems: 2
   183	      required:
   184	        - reg-names
   185	
   186	  - if:
   187	      properties:
   188	        compatible:
   189	          contains:
   190	            enum:
   191	              - qcom,msm8996-ufshc
   192	    then:
   193	      properties:
   194	        clocks:
   195	          minItems: 11
   196	          maxItems: 11
   197	        clock-names:
   198	          items:
   199	            - const: core_clk_src
   200	            - const: core_clk
   201	            - const: bus_clk
   202	            - const: bus_aggr_clk
   203	            - const: iface_clk
   204	            - const: core_clk_unipro_src
   205	            - const: core_clk_unipro
   206	            - const: core_clk_ice
   207	            - const: ref_clk
   208	            - const: tx_lane0_sync_clk
   209	            - const: rx_lane0_sync_clk
   210	        reg:
   211	          minItems: 1
   212	          maxItems: 1
   213	        reg-names:
   214	          maxItems: 1
   215	
   216	  - if:
   217	      properties:
   218	        compatible:
   219	          contains:
   220	            enum:
   221	              - qcom,sm6115-ufshc
   222	    then:
   223	      properties:
   224	        clocks:
   225	          minItems: 8
   226	          maxItems: 8
   227	        clock-names:
   228	          items:
   229	            - const: core_clk
   230	            - const: bus_aggr_clk
   231	            - const: iface_clk
   232	            - const: core_clk_unipro
   233	            - const: ref_clk
   234	            - const: tx_lane0_sync_clk
   235	            - const: rx_lane0_sync_clk
   236	            - const: ice_core_clk
   237	        reg:
   238	          minItems: 2
   239	          maxItems: 2
   240	        reg-names:
   241	          minItems: 2
   242	      required:
   243	        - reg-names
   244	
   245	    # TODO: define clock bindings for qcom,msm8994-ufshc
   246	
   247	  - if:
   248	      required:
   249	        - qcom,ice
   250	    then:
   251	      properties:
   252	        reg:
   253	          maxItems: 1
   254	        clocks:
   255	          minItems: 8
   256	          maxItems: 8
   257	    else:
   258	      properties:
   259	        reg:
   260	          minItems: 1
   261	          maxItems: 2
   262	        clocks:
   263	          minItems: 8
   264	          maxItems: 11
   265	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
