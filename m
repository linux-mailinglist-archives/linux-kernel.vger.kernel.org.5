Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438FA7B05C9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjI0Nss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbjI0Nsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:48:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF66B191
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695822523; x=1727358523;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=GcN9kzSPmyXm68LDw1nkJUmpqPK9gm3OAoo5zpDl5yM=;
  b=hfq9aF8IZcmr5mKCoYorEWLkskAneisEyD5j4ZdVSk2yc2jznKI8rX+Y
   Cxh2Ah0ZG/CrK/YK911HP6hT5i1V2Y17V8ZpLvhKTV+sggfPNL6TE++Pt
   0gLVVd3jiPrzaLa9oHkESo9NzQch6/owE7wg5bh5WMjhgMfL+l4H2QU92
   4lH10H496DGPftAnZMpJHf7zSCT2UaPCUbQDFHAjRejZqwPbBacNuNyFe
   KtWr/BTWJCXGOTY49VL38l4UGB9gncB1nxd4QEDycfIszZl/+VBTBI+j6
   S5TxMbSMrtrESQhGadS5L/UFweunPpDu2p2zo/X3fyFU/4opdnrpYQWeu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="366888151"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="366888151"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 06:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="742714477"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="742714477"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Sep 2023 06:48:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 06:48:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 06:48:41 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 06:48:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPlJQSHtvEqLr1Ne3DfQLhNzWDi9JNV4r1arxpzJUqp9j0lpXlYg/FJ7Ce3moceptP6n7REvhhED2HwljKPt6mGnBj7hj/iWM74KBr6LEKYBUByZ0KFZYLOXuIYkspdFsSWemO3k6ssPAuRgXOIyqNY0OA/dH60bhlkmaTwtbFk6S4mNfUNC29R1T0HkaFeIjX4KG8pPG4s+/u3kWdhfjDOhhiw2DA9ToycvHYmbmHUgC+/ekqboeMCRIkineaNro71nwCA+NyYanizlx9HQHFwV4v6RaB7BDzej+/fGC7PWW7C1ltR/5FlI3d2PFePWFbjtU24du7qgpYB7Jcr/oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IkAiFzrtEtnIz1s5+WDBoEhHC/ukXwVVcdeXwSK/UVg=;
 b=j+EJhMUmdsEgyRiboS+40QcTdv8I61vYnh/VOun6Q5qgp+Mt3ewrbzCfDGqCsSE95Nflb+aTN0SyPK+R8EKIOJdL2NAoYft/DL7zWNpDTRMwuBh2kH1U6lYULT68cPAS5dH9Gd/u3pnVpal0WNVwP24K0c2pyBBa8Q+yrlHCxV9qj3seaJLPw5BmIyo5OAwy3RRp08XoJAAQmvJuR1ipSyrqJr/6Sw8/Tkuk8Rk0xusKH/xZXRZunNbZHtL23DODMQpY6w8Om5fywbppMKdjYPhDtkrzfk4lh+bY7UtkPd+lfvzHUxratoT7T/zra7+jDVdNrwda5jchvwwW/Rt61A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
 by DS0PR11MB7880.namprd11.prod.outlook.com (2603:10b6:8:f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 13:48:33 +0000
Received: from SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::b2f6:ff19:be0b:362d]) by SN6PR11MB3006.namprd11.prod.outlook.com
 ([fe80::b2f6:ff19:be0b:362d%7]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 13:48:33 +0000
Date:   Wed, 27 Sep 2023 21:48:21 +0800
From:   kernel test robot <philip.li@intel.com>
To:     Ziqi Chen <quic_ziqichen@quicinc.com>, <quic_asutoshd@quicinc.com>,
        <quic_cang@quicinc.com>, <bvanassche@acm.org>, <mani@kernel.org>,
        <adrian.hunter@intel.com>, <beanhuo@micron.com>,
        <avri.altman@wdc.com>, <junwoo80.lee@samsung.com>,
        <martin.petersen@oracle.com>, <quic_nguyenb@quicinc.com>,
        <quic_nitirawa@quicinc.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: qcom: dt-bindings: Add MCQ ESI property
Message-ID: <ZRQypUGFKM8pZZIv@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1694163203-39123-1-git-send-email-quic_ziqichen@quicinc.com>
X-ClientProxiedBy: SG2PR04CA0167.apcprd04.prod.outlook.com (2603:1096:4::29)
 To SN6PR11MB3006.namprd11.prod.outlook.com (2603:10b6:805:d1::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3006:EE_|DS0PR11MB7880:EE_
X-MS-Office365-Filtering-Correlation-Id: e4963e00-b6c4-4c32-17d8-08dbbf6070cb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VyIZJNApzF7+3k1Xwx5A+gPINPjloLqbvjiH1G7Lhjsm0JBG7HyeJVs6fe/ULLPtr1f5P5yDhMjGwb0+2f5kiOJoDHYz40m5tEg+N7nIaFkpt33UKmWz5a3d+zjlgYGZ6LqLjXhZSvl9Osu79dhJWt3UcaxkA3sTQO2Pa8J1yj5/rzc9z6KTJMWoofVXrASJyGe0oJHuqtDaQtKlRmv3DPwlAKqwmdlzO3DBUcHmb9uOyqpLJS8SCPRYh0w8rOrullGhGDERnrGypANYCnTTOTIoYmFREB9vpTt3P6ms5JwdrdRRPPVGapoyBVZQttCWjVa1jWTqIkxAphxFo2K/htRHyaWnXTS//iVB+spv+d9+URTJRepVGX7cefHsdj/48ACLH+x9oDy96KcbU16x5OkjPi3ijR+kS9ZuFbKx7Ql/I9GQrik8Y31BzBOitv4o/D7UD+HsV0NIvHPlY+3embOvsFplrzEEGznWLWNwJT59dyH9KCb6ISraVv4Br60FlcOAAMC44FTnOgurgjyznTBU4/IiucbA9mILFd+jgAur1FMnbZ5uZDNiV8tAWw+TKkf+khH25pMx0qV81DjJZ09WCQ6pNPX6jRDE687LLZtIfQxn3NK8h7F+tmrIHJSQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3006.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(1800799009)(186009)(451199024)(6506007)(82960400001)(26005)(66556008)(66476007)(6666004)(966005)(9686003)(86362001)(6512007)(6486002)(478600001)(33716001)(38100700002)(2906002)(83380400001)(921005)(4001150100001)(5660300002)(316002)(8936002)(66946007)(4326008)(30864003)(7416002)(41300700001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MvGGPdCQKwLE+LgQu4xswBuMFVjLKgo3qNM7HfDUFGdFNq7V6EBMUriOtuzX?=
 =?us-ascii?Q?qWrbBPuXgjsmJg1Al7uJFd4+Znj0MmHB4ZqveN50byywKQy9Xg7HZCRAHHio?=
 =?us-ascii?Q?ikinL0IUsxeA1ri7pCylFPJ0U5dr55qvTTm2X/pEkLZCT6ZaA0Pv+FJPEJy8?=
 =?us-ascii?Q?adNCQdIar9sT4oK3TsDgHB5tFcYGgDKuv9wLR7gA4KkY+7uJ8DzgXtNllIEv?=
 =?us-ascii?Q?vISjp62INo6CqorbVFtDNErJZDKwTkhEa8Pq8RJUNVa2+aGgYhUpasFZnCEB?=
 =?us-ascii?Q?mt//kVpmA9BBJuhITGKZq0JYe+6/YGgGiaVMjEA/OWlAWFspjS3p5EZTN3h4?=
 =?us-ascii?Q?6IsC0y/0feSdeP7ijWnJ08z4TNLq//xgTg5k75BssT++GfP9qCMYMEVk63j+?=
 =?us-ascii?Q?PGXB3jy+yGchMggX7bxb+4inADQGJBsZtHK6inzxoj29xBOgGNTrvfBQQlYp?=
 =?us-ascii?Q?OehM05WvzSKDTpVyYoWc3D4KVJxr1mvNKurXdUN2eEa2sObwrx4jUU4ZBJUa?=
 =?us-ascii?Q?801a9OufauL0XmLSsRRknG3dFM0cvXFdhoyZQqlviFc5xnORqAr/fi8ZYIkn?=
 =?us-ascii?Q?KM43x3reUvfqERLPH4oc4WYTHjXyxWdKw+Fx2lSvfjlOPLnWArHRfcypdNBB?=
 =?us-ascii?Q?iBHGsQkQ9Ov7gKbchDFWfoI82ITGuOj54QWxbiA04V5zjvY0dgUcq7NMM7kx?=
 =?us-ascii?Q?E2NVB1htyy/InULmFBAcBjOHVhYVR3W9FyE8/ieNvAxdBGuKNy//ve6r8jjt?=
 =?us-ascii?Q?C9zGP9f7hAofxkDommzWNEUFVwSlyyc1fyndR+lycAxDx8u/vHT4B5PJWO8S?=
 =?us-ascii?Q?5qrWg6YM9/NQG8u4tW1DE+29wS3lZEpShydgXogw0UPzTKfk29zkJMDMc9S6?=
 =?us-ascii?Q?UcaomClo6OheG2rwjNq2VwD0Rbl9wHeaxX/+m6lTXL3LxD8GutCFtx39JLvN?=
 =?us-ascii?Q?jHF3j2V8SDSJji6vPu53czTxa5BFa7MZ4Nv9tZdHuosofM19ePo5HPQrWRG3?=
 =?us-ascii?Q?CjO3MdUsKFqsB5JD2FTlQV1FYxeIhtEO4blhhue5DqWqLPIhKAe1Ed5VO/KF?=
 =?us-ascii?Q?1SLPUzw8WIQX9MupUk1amgI87onuN1xOC7Uuu/XfsQhdSZ9GVHKQ7t8QrSGW?=
 =?us-ascii?Q?WtidTHP/k+yTcfSE3ro2JalxOv9PyH14JTpMauy9hrOxVHO98i1vCX0r/1Uf?=
 =?us-ascii?Q?rWhyH7r4JaRSEdVZKBTIljqyRsg6cCMeXKDDeNxvboQ2d2BvrFKB7Mp3ubxC?=
 =?us-ascii?Q?zZ3P/6TDTfZXjPkvxHNCpLEuXxc56zyKfJc9wzkSZsH8A0zxzTSR+VeLQ9Hp?=
 =?us-ascii?Q?fBfbdMDPumxIF0ez5zZNiY2kEIiaN6z9v/3grSXMo9j+EauWqtMLn2MGTw2x?=
 =?us-ascii?Q?nvzrtQ585mOrGWNZQH6QEtGbcFZh/MuWu+cKbWAJ5JHRSEpYhcOw22Jjn3Xh?=
 =?us-ascii?Q?CmQcFwIGRfEyy+5mTVDpFl+nfjbGVSUyBt1h5BOPJdhpS5uIBWfXL+CyDrPN?=
 =?us-ascii?Q?eNxzKYn1buY9I6YQP0X6p08wPJg3cgEB24qJr9JLcmPvsdocFnslK/kB+l1L?=
 =?us-ascii?Q?SVS7xZsin3N/lmS4y+T/j0YNpP4pk+snnOP7PqUL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4963e00-b6c4-4c32-17d8-08dbbf6070cb
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3006.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 13:48:33.6510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFk/kEGt/mdZtcrkSyBvn0aS4djAlL1o9bssUF8ShSh/ToUg6vjD4i66+kujNlhoKqjIbjY44TTjiislYzRctw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7880
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ziqi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ziqi-Chen/scsi-ufs-qcom-dt-bindings-Add-MCQ-ESI-property/20230908-165641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/1694163203-39123-1-git-send-email-quic_ziqichen%40quicinc.com
patch subject: [PATCH] scsi: ufs: qcom: dt-bindings: Add MCQ ESI property
:::::: branch date: 3 weeks ago
:::::: commit date: 3 weeks ago
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230927/202309270236.73iDpbX8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202309270236.73iDpbX8-lkp@intel.com/

dtcheck warnings: (new ones prefixed by >>)
>> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml:108:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
--
   Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml: properties:adi,ext1-burnout-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
   Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml: properties:adi,ext2-burnout-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
   Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml: properties:adi,viout-burnout-current-nanoamp: '$ref' should not be valid under {'const': '$ref'}
   	hint: Standard unit suffix properties don't need a type $ref
   	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
>> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: properties:qcom,esi-affinity-mask: 'oneOf' conditional failed, one must be fixed:
   	'type' is a required property
   		hint: A vendor boolean property can use "type: boolean"
>> 	Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: properties:qcom,esi-affinity-mask: 'oneOf' conditional failed, one must be fixed:
   		'enum' is a required property
   		'const' is a required property
   		hint: A vendor string property with exact values has an implicit type
   		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
>> 	Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: properties:qcom,esi-affinity-mask: 'oneOf' conditional failed, one must be fixed:
   		'$ref' is a required property
   		'allOf' is a required property
   		hint: A vendor property needs a $ref to types.yaml
   		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
   	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
   	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

vim +108 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml

462c5c0aa7989e Krzysztof Kozlowski 2022-03-06    8  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06    9  maintainers:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   10    - Bjorn Andersson <bjorn.andersson@linaro.org>
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   11    - Andy Gross <agross@kernel.org>
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   12  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   13  # Select only our matches, not all jedec,ufs-2.0
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   14  select:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   15    properties:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   16      compatible:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   17        contains:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   18          const: qcom,ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   19    required:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   20      - compatible
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   21  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   22  properties:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   23    compatible:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   24      items:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   25        - enum:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   26            - qcom,msm8994-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   27            - qcom,msm8996-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   28            - qcom,msm8998-ufshc
8f0c17bf6bf33b Bartosz Golaszewski 2023-04-11   29            - qcom,sa8775p-ufshc
2f3b3200ac389d Johan Hovold        2022-07-11   30            - qcom,sc8280xp-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   31            - qcom,sdm845-ufshc
a11eaed308efc7 Iskren Chernev      2023-08-14   32            - qcom,sm6115-ufshc
3d8fa7a22dcd54 Luca Weiss          2022-03-21   33            - qcom,sm6350-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   34            - qcom,sm8150-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   35            - qcom,sm8250-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   36            - qcom,sm8350-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   37            - qcom,sm8450-ufshc
b8c203891121be Abel Vesa           2023-01-19   38            - qcom,sm8550-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   39        - const: qcom,ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   40        - const: jedec,ufs-2.0
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   41  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   42    clocks:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   43      minItems: 8
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   44      maxItems: 11
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   45  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   46    clock-names:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   47      minItems: 8
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   48      maxItems: 11
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   49  
85e182b48a33a4 Johan Hovold        2023-01-16   50    dma-coherent: true
85e182b48a33a4 Johan Hovold        2023-01-16   51  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   52    interconnects:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   53      minItems: 2
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   54      maxItems: 2
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   55  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   56    interconnect-names:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   57      items:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   58        - const: ufs-ddr
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   59        - const: cpu-ufs
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   60  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   61    iommus:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   62      minItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   63      maxItems: 2
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   64  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   65    phys:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   66      maxItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   67  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   68    phy-names:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   69      items:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   70        - const: ufsphy
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   71  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   72    power-domains:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   73      maxItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   74  
29a6d1215b7cd5 Abel Vesa           2023-06-12   75    qcom,ice:
29a6d1215b7cd5 Abel Vesa           2023-06-12   76      $ref: /schemas/types.yaml#/definitions/phandle
29a6d1215b7cd5 Abel Vesa           2023-06-12   77      description: phandle to the Inline Crypto Engine node
29a6d1215b7cd5 Abel Vesa           2023-06-12   78  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   79    reg:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   80      minItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   81      maxItems: 2
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   82  
7839d566c653bc Luca Weiss          2023-08-14   83    reg-names:
7839d566c653bc Luca Weiss          2023-08-14   84      items:
7839d566c653bc Luca Weiss          2023-08-14   85        - const: std
7839d566c653bc Luca Weiss          2023-08-14   86        - const: ice
7839d566c653bc Luca Weiss          2023-08-14   87  
8ffbaa98ccf823 Krzysztof Kozlowski 2022-12-28   88    required-opps:
8ffbaa98ccf823 Krzysztof Kozlowski 2022-12-28   89      maxItems: 1
8ffbaa98ccf823 Krzysztof Kozlowski 2022-12-28   90  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   91    resets:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   92      maxItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   93  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   94    '#reset-cells':
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   95      const: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   96  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   97    reset-names:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   98      items:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06   99        - const: rst
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  100  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  101    reset-gpios:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  102      maxItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  103      description:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  104        GPIO connected to the RESET pin of the UFS memory device.
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  105  
b620cbe2435f88 Ziqi Chen           2023-09-08  106    qcom,esi-affinity-mask:
b620cbe2435f88 Ziqi Chen           2023-09-08  107      description:
b620cbe2435f88 Ziqi Chen           2023-09-08 @108         UFS MCQ ESI affinity mask. Affine ESI on registration according to this CPU mask.
b620cbe2435f88 Ziqi Chen           2023-09-08  109  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  110  required:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  111    - compatible
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  112    - reg
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  113  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  114  allOf:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  115    - $ref: ufs-common.yaml
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  116  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  117    - if:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  118        properties:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  119          compatible:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  120            contains:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  121              enum:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  122                - qcom,msm8998-ufshc
8f0c17bf6bf33b Bartosz Golaszewski 2023-04-11  123                - qcom,sa8775p-ufshc
2f3b3200ac389d Johan Hovold        2022-07-11  124                - qcom,sc8280xp-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  125                - qcom,sm8250-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  126                - qcom,sm8350-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  127                - qcom,sm8450-ufshc
b8c203891121be Abel Vesa           2023-01-19  128                - qcom,sm8550-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  129      then:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  130        properties:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  131          clocks:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  132            minItems: 8
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  133            maxItems: 8
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  134          clock-names:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  135            items:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  136              - const: core_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  137              - const: bus_aggr_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  138              - const: iface_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  139              - const: core_clk_unipro
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  140              - const: ref_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  141              - const: tx_lane0_sync_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  142              - const: rx_lane0_sync_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  143              - const: rx_lane1_sync_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  144          reg:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  145            minItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  146            maxItems: 1
7839d566c653bc Luca Weiss          2023-08-14  147          reg-names:
7839d566c653bc Luca Weiss          2023-08-14  148            maxItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  149  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  150    - if:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  151        properties:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  152          compatible:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  153            contains:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  154              enum:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  155                - qcom,sdm845-ufshc
3d8fa7a22dcd54 Luca Weiss          2022-03-21  156                - qcom,sm6350-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  157                - qcom,sm8150-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  158      then:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  159        properties:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  160          clocks:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  161            minItems: 9
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  162            maxItems: 9
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  163          clock-names:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  164            items:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  165              - const: core_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  166              - const: bus_aggr_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  167              - const: iface_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  168              - const: core_clk_unipro
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  169              - const: ref_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  170              - const: tx_lane0_sync_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  171              - const: rx_lane0_sync_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  172              - const: rx_lane1_sync_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  173              - const: ice_core_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  174          reg:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  175            minItems: 2
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  176            maxItems: 2
7839d566c653bc Luca Weiss          2023-08-14  177          reg-names:
7839d566c653bc Luca Weiss          2023-08-14  178            minItems: 2
7839d566c653bc Luca Weiss          2023-08-14  179        required:
7839d566c653bc Luca Weiss          2023-08-14  180          - reg-names
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  181  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  182    - if:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  183        properties:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  184          compatible:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  185            contains:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  186              enum:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  187                - qcom,msm8996-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  188      then:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  189        properties:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  190          clocks:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  191            minItems: 11
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  192            maxItems: 11
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  193          clock-names:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  194            items:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  195              - const: core_clk_src
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  196              - const: core_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  197              - const: bus_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  198              - const: bus_aggr_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  199              - const: iface_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  200              - const: core_clk_unipro_src
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  201              - const: core_clk_unipro
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  202              - const: core_clk_ice
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  203              - const: ref_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  204              - const: tx_lane0_sync_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  205              - const: rx_lane0_sync_clk
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  206          reg:
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  207            minItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  208            maxItems: 1
7839d566c653bc Luca Weiss          2023-08-14  209          reg-names:
7839d566c653bc Luca Weiss          2023-08-14  210            maxItems: 1
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  211  
a11eaed308efc7 Iskren Chernev      2023-08-14  212    - if:
a11eaed308efc7 Iskren Chernev      2023-08-14  213        properties:
a11eaed308efc7 Iskren Chernev      2023-08-14  214          compatible:
a11eaed308efc7 Iskren Chernev      2023-08-14  215            contains:
a11eaed308efc7 Iskren Chernev      2023-08-14  216              enum:
a11eaed308efc7 Iskren Chernev      2023-08-14  217                - qcom,sm6115-ufshc
a11eaed308efc7 Iskren Chernev      2023-08-14  218      then:
a11eaed308efc7 Iskren Chernev      2023-08-14  219        properties:
a11eaed308efc7 Iskren Chernev      2023-08-14  220          clocks:
a11eaed308efc7 Iskren Chernev      2023-08-14  221            minItems: 8
a11eaed308efc7 Iskren Chernev      2023-08-14  222            maxItems: 8
a11eaed308efc7 Iskren Chernev      2023-08-14  223          clock-names:
a11eaed308efc7 Iskren Chernev      2023-08-14  224            items:
a11eaed308efc7 Iskren Chernev      2023-08-14  225              - const: core_clk
a11eaed308efc7 Iskren Chernev      2023-08-14  226              - const: bus_aggr_clk
a11eaed308efc7 Iskren Chernev      2023-08-14  227              - const: iface_clk
a11eaed308efc7 Iskren Chernev      2023-08-14  228              - const: core_clk_unipro
a11eaed308efc7 Iskren Chernev      2023-08-14  229              - const: ref_clk
a11eaed308efc7 Iskren Chernev      2023-08-14  230              - const: tx_lane0_sync_clk
a11eaed308efc7 Iskren Chernev      2023-08-14  231              - const: rx_lane0_sync_clk
a11eaed308efc7 Iskren Chernev      2023-08-14  232              - const: ice_core_clk
a11eaed308efc7 Iskren Chernev      2023-08-14  233          reg:
a11eaed308efc7 Iskren Chernev      2023-08-14  234            minItems: 2
a11eaed308efc7 Iskren Chernev      2023-08-14  235            maxItems: 2
a11eaed308efc7 Iskren Chernev      2023-08-14  236          reg-names:
a11eaed308efc7 Iskren Chernev      2023-08-14  237            minItems: 2
a11eaed308efc7 Iskren Chernev      2023-08-14  238        required:
a11eaed308efc7 Iskren Chernev      2023-08-14  239          - reg-names
a11eaed308efc7 Iskren Chernev      2023-08-14  240  
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  241      # TODO: define clock bindings for qcom,msm8994-ufshc
462c5c0aa7989e Krzysztof Kozlowski 2022-03-06  242  
29a6d1215b7cd5 Abel Vesa           2023-06-12  243    - if:
9b7c13b83c1ded Abel Vesa           2023-06-23  244        required:
9b7c13b83c1ded Abel Vesa           2023-06-23  245          - qcom,ice
29a6d1215b7cd5 Abel Vesa           2023-06-12  246      then:
29a6d1215b7cd5 Abel Vesa           2023-06-12  247        properties:
29a6d1215b7cd5 Abel Vesa           2023-06-12  248          reg:
29a6d1215b7cd5 Abel Vesa           2023-06-12  249            maxItems: 1
29a6d1215b7cd5 Abel Vesa           2023-06-12  250          clocks:
29a6d1215b7cd5 Abel Vesa           2023-06-12  251            minItems: 8
29a6d1215b7cd5 Abel Vesa           2023-06-12  252            maxItems: 8
29a6d1215b7cd5 Abel Vesa           2023-06-12  253      else:
29a6d1215b7cd5 Abel Vesa           2023-06-12  254        properties:
29a6d1215b7cd5 Abel Vesa           2023-06-12  255          reg:
9b7c13b83c1ded Abel Vesa           2023-06-23  256            minItems: 1
29a6d1215b7cd5 Abel Vesa           2023-06-12  257            maxItems: 2
29a6d1215b7cd5 Abel Vesa           2023-06-12  258          clocks:
9b7c13b83c1ded Abel Vesa           2023-06-23  259            minItems: 8
29a6d1215b7cd5 Abel Vesa           2023-06-12  260            maxItems: 11
29a6d1215b7cd5 Abel Vesa           2023-06-12  261  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

