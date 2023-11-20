Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44E7F0AEA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjKTDWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjKTDWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:22:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4AB137;
        Sun, 19 Nov 2023 19:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700450556; x=1731986556;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=ui5Tee19isrDVn9L7x81rVAU84lnkVqqdjnEKfPqS28=;
  b=JMgo7PoL6c/owOUAXxdBomxQhs+sYAfIgkDQPEX9yquI5IIJyuatV7BL
   IVpBpQwXPs0/miG0nxJUvKO+Dao2227bEkRHyPUNcItFKnrCWocCFwmf4
   3mDRx/e+GJGS1CekVr/6gfiVda7hPUikHUwjv1kp79k8wyak1ZIIPYwEH
   gbCTDGrg0c175GeU+0vn8Z10GkcDusH7g//p0R4AeHTPuj7tsJszKzk0X
   nAvDQRAEi27JVf6NaNFoCoRANAJPW2e18UWkQwKCXDVSgH1Qecken+KUa
   0S5nW6ZoeopjKbzKb5PVOwEVZm6dqkbpH+2vcNIMXorqW8y9IBeid184C
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="455864397"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="455864397"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 19:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="1097628203"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="1097628203"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Nov 2023 19:22:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 19 Nov 2023 19:22:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 19 Nov 2023 19:22:33 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 19 Nov 2023 19:22:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrr1e9ULqMjZZymmmaygQ8zoqif59UZe4MGHguDy3J4eqYmIdUwpvoUxvm/ONgajcsALPG/sZK8PJQCiqbAj2+gtbgrRHFJAJBZlLrDxcTli8NZnB6eQ0CWlTOaOZ4P1dxYzOwVo0LqLPXd9jt275LheiYu207/Y2H0EnqYJPe+RTo8jMGpMncCPwXGBKO15+I+u/sRMPTZmmK/FbL8KDnbLMz9oQGZ+FBBSG7XjHzRF5MklhdirXmH3yxk5DDTHmIhxtsoYkQP9eJdpYwNpPpfdiqPPq5cvT9ciV4fFzX4Xehu+h4DDjQEvivggU53Z8n2IXIP5kT1WYGvtMetcVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oiimqo7x2vneAaalccxsNT9zZhXMQVWQeFgbKWVzi/A=;
 b=S/d0Dt4/1LGrav7P40qXhJWouLHy2XiNR0UAI+jZ3QdY1FjtJYeo5jTYPMn02y0PXvpzh7B5NDun/57ipPnXEmyyIqRfSsgjsV8x+ofA+iMsZX3W9ZDZRqYkTDYVX9DUJqyRGFCH4KOo1y4TBJ2MSgBFeo9/MI2Nzoah5bzAGYqHnSN38IL5QqBNd8NMBOMjBzXca4w/TqZjniGVRU8+616D46k4l007IC9naMMSj2CHqtJ/QBCvn6TQyIhObrCna9fM7oEv3/OONzh1N/TTVRzEBON7Pz9KHpZN24cKbS9OtVX/DwVqcbZOdG3S6kPz/YJQ3brgkw1VBx1F203Y5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 03:22:26 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 03:22:26 +0000
Date:   Mon, 20 Nov 2023 11:17:42 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     mitrutzceclan <mitrutzceclan@gmail.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <andy@kernel.org>, <linux-gpio@vger.kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: adc: add AD7173
Message-ID: <202311172002.BPSsTFRY-lkp@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231116134655.21052-1-user@HYB-hhAwRlzzMZb>
X-ClientProxiedBy: SI2PR01CA0007.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::11) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SJ0PR11MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6b452a-3622-4b2f-438b-08dbe977eb36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3g3PgTGZdl6et+3+2ndZuihyMw3NWFAhlU6TxgAhJrOo5BYLDojfJcmPqWtvKqzJDxynsjuQ3lBpENnLWI/qCtJ0O9r5OGLCQmONBuoDZEZ+htqvyVp86Vkxje8xtzvQVu+Yi6xXiPPkHlK3iyxCdU6i9URA/1pb6BlhSEk+nSnWmJckTZdxzzJ2GwGCCfCo37DPuQNQ3600PfY8gPSVdv5Y4PQZpJpFjE8aHzujzKeFssHE5aOFqexhPBBA2BRQETg7Zj3MQCWe8htzCqvJARCUtZXNtoJzFrmec2I4Y/o2OM5WpIgac8MtmGsvf1FWilhACix2ls+eI7T4T72WriUJNv3yQwP5Y+bpk1NNq1rUOjcA54bNrrivfq8rAZjsJtq1JxJNzqm3O4gQNnRgLt9bZjq+6vJoN9jm6Oy1xfT1EFdOv0mdIZ6XjxjEerXEqtYaiWcH+U/OQYUMhFiLOk8x+cseQ+XEcB7AR9eK7ofA5uLtDeOQIiURZHpCXIsj75Xrzh2basbQ8NuDU7nrOLm4asge/Kpv95jaTZ6Qa9j56wviyW+yV94m/1ioWGPUe2Y7Zp2Hbxk0hK3aYbsiSVN2lvQY9SsuuYLR5UjcBr+tU0kY2sVpnINrYJP8+ZW0f0+kenFIi+PljsNtv0Xdkg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(230273577357003)(230173577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82960400001)(83380400001)(36756003)(86362001)(38100700002)(66946007)(66556008)(66476007)(6916009)(54906003)(8676002)(8936002)(4326008)(316002)(41300700001)(7416002)(5660300002)(4001150100001)(30864003)(2906002)(6512007)(1076003)(6506007)(2616005)(26005)(966005)(478600001)(6486002)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFFKb2E0czBuNG9zb1RudzZyd0Y4Q0xmYkE1MmUwQnNOcHJlcC9ib0pCNG5T?=
 =?utf-8?B?MXhYazJzS1RCVzdFNDR6SmI5ZkJMTTZZV3ZUZVVpeDdVUDNjR2NFaGkyL25R?=
 =?utf-8?B?bzlKMGtuRlRXY0dpWmJKeUZMbDM0OVN5eDkzWG9lMDladHJheFd5V3I0anUz?=
 =?utf-8?B?Z3RSUDAwVVd1c2U1Z2tiSmpZektXbGZWMlJiZ21VV2hQN3dHcFRSbnorQmxz?=
 =?utf-8?B?QTltS3ZMZWVaeUZiODcxOWxhd1VjOUNHQ2RaWTJXRGRvNmgyNmI2dllCTko3?=
 =?utf-8?B?SXdSdGxrZkdwTXFCUDdYYkszUWRyY29TMzZ0VGJyTzdWaHprQnEySVNDRUd5?=
 =?utf-8?B?TGUyZlVkeUFhZ0tyUU9ZeTlVUVhHSXJ1TXBSV09kVG44VFB2d3pPY3Vvb2RT?=
 =?utf-8?B?bk1MbEJQbFd5VmMzVFh3RC9QUlBXMmxqRERyRmo2bTFaRFF5Y0d6TU9DOWFw?=
 =?utf-8?B?T2dDb0VoV3JpbmpVR0Jzamc0ZG1RNzlnSUNRQU9maStmdlYwQzJhNis2c1pQ?=
 =?utf-8?B?ay9qRDJJMW1XdmZnd3pTdW93TS9OaFJ2YjRKU3dpakNwZGU4NW0wZHMvVURK?=
 =?utf-8?B?c2drL0FkcHFkRzJGTUU4Z0N6ZGt5QjdNTmFFOHJweHpkNEo3cWN0SmRxend6?=
 =?utf-8?B?YjdBNVpaT2N3ZkVmNktlV1VwZk5sV25LUm8vaUdQRllGTGxvWGlnTXVhMTAx?=
 =?utf-8?B?c05QOHpWMHhValg2b0p0N0xqT0dYYXZ6bkVPYUVkdjgwUFVKeUE5RE8zdUt3?=
 =?utf-8?B?K0RzeUZRck5DeHlTTHNDQlNGMkJCNmJqa0U2aUhKMlBTeFNOTkZqT3E4Zkp3?=
 =?utf-8?B?cGdOdUtncE9HelB0a0l2T2dEYmU3czkzL1NlUTlCMUN5T0ZVNU94UXlxMjZ2?=
 =?utf-8?B?N3VqN0hnOEdheDNnclNkSFdQNGZCNkMrZk8ybGJ0aDY2MWJmUVJvVC9OUUht?=
 =?utf-8?B?K1dEaFFDWXF2bHBzWU1NN3hvUlRDQjdTc2FFWEVpWnQ3eUxPSmhHT05rc0pE?=
 =?utf-8?B?RzFrL0phQTFUS0xqT3pMcU9XZjJteFBGcXd1NndyYWpycExhaUt3YTNnZEpI?=
 =?utf-8?B?S3JtZ2dPN2YySVpUc2kwZXJoaTBucGV4K3R3M281d29GQnRkZHFMN3RTRkM5?=
 =?utf-8?B?dXMxOUE2UWxmNGduMDZvdEtzcHZwSFE3MFVpVjZIWFNHQlFVVWYxckRqRDdN?=
 =?utf-8?B?YXdDM1ZVZFlwNm9IQTlyLzlTVGc5SDFnLzZ1VUp2NEpZN1VXWi9XYlIwb2JW?=
 =?utf-8?B?cDV4NlFnNm5OeGh3SUFhalFDTVh3ODNubEx2eXphWCt5ZUFoK2dycGhsWHZM?=
 =?utf-8?B?L0RjRVY3MldWakFtbTdZVWl5Y0VOcTB1c09nbmI1ZlFmRmRVeWNCclFZY3Zq?=
 =?utf-8?B?NmdRUEFFWnpkUnBrVlIvNXl5ZXFrdGFpNXRZWU5waEs4Yk00TjdLNy9qUkN3?=
 =?utf-8?B?aVZEL1J0RHR2MWNtKzJrM1V4bzZVbHVURGFrNFh6LzRjN0RqSU8vOHNYcUtH?=
 =?utf-8?B?REQyNXV1dDhmL2Npa243N282dmFIN1NlYXBSWHNERlNiY3JnVVZOMzA4Y1hu?=
 =?utf-8?B?bWRCOGxuc014cGM5amNxMWdHNUFCbkVQZXRvUHZQcDZzNmtKUGxzc0hYUEVi?=
 =?utf-8?B?VmJqa3JhdUZadEl6WFlXcTNES2gvUVE3U2dGN2xBVndIVS9tdlpXTHE0Szgr?=
 =?utf-8?B?b2tLSjNadDhPbUwybHhNT05pMVQ5Z0ZhNktnOTJOVDg5bmZlZFpXUFVGaUNT?=
 =?utf-8?B?MzRtOVo4MlRjVjhFUnBNOUlFL0ZKVWlNNGEyelFxVVdNVzdXU0I1RENWcmVL?=
 =?utf-8?B?OWE2STR5Y2pEY3FMOG5ybkdrOFcrSmdLalBWQkxoY2s3ZTJ4d2Q0NzUzanFs?=
 =?utf-8?B?YVdxUHJ3QXFsbG5UWE81cEJRdkFTNVBza0V4ZFhDWjZvQnZ6aTlNejVTeUZ2?=
 =?utf-8?B?UzdyeFNXaDh2Wm9STjhSN2NMbXpxMEtJZzVMM2luYnhXYmFPckExSjRLV3NF?=
 =?utf-8?B?RlJZVENRcGsvOG9BSi83SU9wYksxckxoaXZCUkNLWHN3L0ZVdGROcHhKVkp6?=
 =?utf-8?B?bXFsb0dYRmxMcUlnS2VkQXVvVzJqMEoyamFhbjdDUVBtS0JxR2NrSDFBdHRn?=
 =?utf-8?Q?KULYFoGcYVroDhYIY8SEswJle?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6b452a-3622-4b2f-438b-08dbe977eb36
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 03:22:26.2254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BLT9HpOPf5bMJcbnrE17HO5z4XfOitZvXrw5nBEzWVolKhU3PBhmGx91L3TlwgRY/btLRJILrZwtYlRBTH7q1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dumitru,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/mitrutzceclan/iio-adc-ad7173-add-AD7173-driver/20231116-214919
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20231116134655.21052-1-user%40HYB-hhAwRlzzMZb
patch subject: [PATCH v4 1/2] dt-bindings: adc: add AD7173
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231117/202311172002.BPSsTFRY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311172002.BPSsTFRY-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml:109:10: [error] empty value in block mapping (empty-values)
--
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: properties:required: ['compatible', 'reg', 'interrupts'] is not of type 'object', 'boolean'
   	from schema $id: http://json-schema.org/draft-07/schema#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: allOf:1:then: None is not of type 'object', 'boolean'
   	from schema $id: http://json-schema.org/draft-07/schema#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: allOf:1:else:patternProperties:^channel@[0-9a-f]$:properties:enum: [0, 2, 3] is not of type 'object', 'boolean'
   	from schema $id: http://json-schema.org/draft-07/schema#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: allOf:1:else:patternProperties:^channel@[0-9a-f]$:properties: 'enum' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
   	hint: A json-schema keyword was found instead of a DT property name.
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: allOf:1:else:patternProperties:^channel@[0-9a-f]$:properties:enum: [0, 2, 3] is not of type 'object', 'boolean'
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: properties: 'dependencies' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
   	hint: A json-schema keyword was found instead of a DT property name.
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: properties: 'required' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
   	hint: A json-schema keyword was found instead of a DT property name.
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: properties:dependencies: 'anyOf' conditional failed, one must be fixed:
   	'refin2-supply' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
   	'type' was expected
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: properties:required: ['compatible', 'reg', 'interrupts'] is not of type 'object', 'boolean'
   	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
--
   /usr/local/lib/python3.11/dist-packages/dtschema/schemas/reserved-memory/framebuffer.yaml: warning: ignoring duplicate '$id' value 'http://devicetree.org/schemas/reserved-memory/framebuffer.yaml#'
   /usr/local/lib/python3.11/dist-packages/dtschema/schemas/reserved-memory/memory-region.yaml: warning: ignoring duplicate '$id' value 'http://devicetree.org/schemas/reserved-memory/memory-region.yaml#'
   /usr/local/lib/python3.11/dist-packages/dtschema/schemas/reserved-memory/reserved-memory.yaml: warning: ignoring duplicate '$id' value 'http://devicetree.org/schemas/reserved-memory/reserved-memory.yaml#'
   /usr/local/lib/python3.11/dist-packages/dtschema/schemas/reserved-memory/shared-dma-pool.yaml: warning: ignoring duplicate '$id' value 'http://devicetree.org/schemas/reserved-memory/shared-dma-pool.yaml#'
   Documentation/devicetree/bindings/media/i2c/ti,ds90ub960.yaml: i2c-alias: missing type definition
>> Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml: dependencies: missing type definition
   Documentation/devicetree/bindings/sound/audio-graph.yaml: convert-sample-format: missing type definition
   Documentation/devicetree/bindings/serial/8250_omap.yaml: rs485-rts-active-high: missing type definition
   Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml: dual-lvds-odd-pixels: missing type definition
   Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml: dual-lvds-even-pixels: missing type definition

vim +109 Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml

6817f96dd6ee22 Dumitru Ceclan 2023-11-16   @1  # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
6817f96dd6ee22 Dumitru Ceclan 2023-11-16    2  # Copyright 2023 Analog Devices Inc.
6817f96dd6ee22 Dumitru Ceclan 2023-11-16    3  %YAML 1.2
6817f96dd6ee22 Dumitru Ceclan 2023-11-16    4  ---
6817f96dd6ee22 Dumitru Ceclan 2023-11-16    5  $id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
6817f96dd6ee22 Dumitru Ceclan 2023-11-16    6  $schema: http://devicetree.org/meta-schemas/core.yaml#
6817f96dd6ee22 Dumitru Ceclan 2023-11-16    7  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16    8  title: Analog Devices AD7173 ADC device driver
6817f96dd6ee22 Dumitru Ceclan 2023-11-16    9  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   10  maintainers:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   11    - Ceclan Dumitru <dumitru.ceclan@analog.com>
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   12  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   13  description: |
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   14    Bindings for the Analog Devices AD717X ADC's. Datasheets for supported chips:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   15      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7172-2.pdf
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   16      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7173-8.pdf
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   17      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7175-2.pdf
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   18      https://www.analog.com/media/en/technical-documentation/data-sheets/AD7176-2.pdf
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   19  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   20  properties:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   21    compatible:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   22      enum:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   23        - adi,ad7172-2
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   24        - adi,ad7173-8
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   25        - adi,ad7175-2
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   26        - adi,ad7176-2
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   27  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   28    reg:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   29      maxItems: 1
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   30  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   31    interrupts:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   32      maxItems: 1
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   33  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   34    '#address-cells':
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   35      const: 1
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   36  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   37    '#size-cells':
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   38      const: 0
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   39  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   40    spi-max-frequency:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   41      maximum: 20000000
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   42  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   43    refin-supply:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   44      description: external reference supply, can be used as reference for conversion.
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   45  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   46    refin2-supply:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   47      description: external reference supply, can be used as reference for conversion.
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   48  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   49    avdd-supply:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   50      description: avdd supply, can be used as reference for conversion.
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   51  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   52    dependencies:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   53      refin2-supply:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   54        properties:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   55          compatible:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   56            adi,ad7173-8
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   57  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   58    required:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   59      - compatible
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   60      - reg
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   61      - interrupts
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   62  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   63  patternProperties:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   64    "^channel@[0-9a-f]$":
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   65      type: object
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   66      $ref: adc.yaml
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   67      unevaluatedProperties: false
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   68  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   69      properties:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   70        reg:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   71          minimum: 0
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   72          maximum: 15
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   73  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   74        diff-channels:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   75          items:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   76            minimum: 0
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   77            maximum: 31
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   78  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   79        adi,reference-select:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   80          description: |
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   81            Select the reference source to use when converting on
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   82            the specific channel. Valid values are:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   83            0: REFIN(+)/REFIN(−).
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   84            1: REFIN2(+)/REFIN2(−)
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   85            2: REFOUT/AVSS (Internal reference)
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   86            3: AVDD
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   87  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   88            External reference 2 only available on ad7173-8.
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   89            If not specified, internal reference used.
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   90          $ref: /schemas/types.yaml#/definitions/uint32
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   91          enum: [0, 1, 2, 3]
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   92          default: 2
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   93  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   94        bipolar:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   95          type: boolean
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   96  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   97      required:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   98        - reg
6817f96dd6ee22 Dumitru Ceclan 2023-11-16   99        - diff-channels
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  100  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  101  allOf:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  102    - $ref: /schemas/spi/spi-peripheral-props.yaml#
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  103  
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  104    - if:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  105        properties:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  106          compatible:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  107            contains:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  108              const: adi,ad7173-8
6817f96dd6ee22 Dumitru Ceclan 2023-11-16 @109      then:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  110      else:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  111        patternProperties:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  112          "^channel@[0-9a-f]$":
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  113            properties:
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  114              enum: [0, 2, 3]
6817f96dd6ee22 Dumitru Ceclan 2023-11-16  115  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

