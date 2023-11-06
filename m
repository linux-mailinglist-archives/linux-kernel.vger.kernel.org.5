Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374FC7E1C4C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjKFIdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjKFIdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:33:42 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D614CC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:33:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699259620; x=1730795620;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UMBi1pRhFRy1yHTd3DnU7X0y7EIi2n9evQP9hgRgYGY=;
  b=X7mDPnNKVPmi/jp5cweY4life4yRfy4tadYpGX89qWXew4zoFD5snnue
   9AAwfslySuNKmEav6u5OjQGxoC3wb4v/GsNHPFnTCaeV6Tu/mtSIUmD58
   gQrRZ3UnxyQefAgUd6Scn3MTqEq/Gja2TVwgd98NQWBVYhkEpknDsmFis
   GoOPSaB3GMyP2Yv962RtG6hBTS9RsvHzcm8YUWjKFxdrRrJlwLnG1Jbf5
   7qZpoxINIYExVNFvasxjq5Ennys4RllBhLPnOLh82HxGOBwjNMgvEtw0p
   wtT22FuVDWOUt8Ljc2nJ0a2tOSg1568tLoGhv7XqJRFLOo9He0IGmnKYN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="10768247"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="10768247"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2023 00:33:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10885"; a="738744400"
X-IronPort-AV: E=Sophos;i="6.03,280,1694761200"; 
   d="scan'208";a="738744400"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Nov 2023 00:33:39 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:33:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 00:33:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 00:33:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 00:33:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krvl0uKCi9ZfMVxjk69Sm/A6U9D0b20N78EgEXeFpBfvfKAg4Va/qGx5cEIq7FMXIXtMCHAuRdVCjHHtZTroewZ+B7VeE/309IqcyDzvfcubTAza8ZUG68BFWUN9HbAbE+qb8DaQD3Rj+IUQgZwVp1XbIK2AC9n5Fw3ebN/5fyd798+lUcQZxy5WG8E7vqZdQ9uWCXXB3WDJSYC8UpLvHskG1QDLN4X3951TXM9zWKJ6oe5KoZMLqpb9kUhxOI1lGxB4eZvSAVMttru0h4uDpfFwFW+pyu5Ewphm2IWW1ckBf5oigWk0J9+zZUJrFak0PTX422LWmU49FxFq+jE2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cinz0bqexJ+kErZ8SEyNMx7u0+cCdgH9w3582GpyWus=;
 b=azoddYAUBYsCryWCnxnrehpOog5i9RWeBsvxIofZeH6aQ7eSVVW9bDNa2+NveTVtPxw2oQh87YCBqqjSC68rE4OjJrL+Kb4bvHkASrkY1gRUgj3Jj+7lUkKp2CWL1EqHq1o+dm6lnYmkK/TurV3giDILhD5750IbIxqc2B2W+uFfHG3woDpxB+z1yBzOCpMcKWT6hnZvXs/BXp7ym5Ztud1uigpOL53atoLa4eKFnLihkLbSS4XRyL+gukB4SDONmwPdD9UNPDTrCz/wWRaugO5IPRAcRlAOprb/fUdHMZ4MdkYNysr88xF2iASg/eRyqiPGqy5Hdc2CDEFrq9VV+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SA1PR11MB6846.namprd11.prod.outlook.com (2603:10b6:806:2b0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Mon, 6 Nov
 2023 08:33:36 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.6933.028; Mon, 6 Nov 2023
 08:33:36 +0000
Date:   Mon, 6 Nov 2023 16:28:53 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Nava kishore Manne <nava.manne@xilinx.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Moritz Fischer" <mdf@kernel.org>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: drivers/fpga/versal-fpga.c:78:34: warning: 'versal_fpga_of_match'
 defined but not used
Message-ID: <202311052137.qkYX2xHU-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG3P274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::14)
 To CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SA1PR11MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 959d003a-42a5-452c-ca70-08dbdea311ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xdvDAOQhTbaPVOmbAR1nWvjiE+P8MkNVRGEPejKU2ohH02s8ReopWrtg/ILNLi4ukUhk74ERjmv93hZeKw3HxM4Y0m31n0wM6ZuWtb+dWMmfOrtf6CkvTqXTCeF7ytRqZ1Rsz/xfIuiuCba9PKQS/Yq2EcdjIh2VQkS+PMhuqmwDm23ftZH9G5Ltusq3eu92JOHF3jMpnlgk4tc7/3jhfeME+obJk32qbRg267GfNMA23jzLPbIvueuVHTBK6ZXvYETJyXE3tc7YpRYygpTK9WpAgl/HAZJGMbYdm7mvUKqnKyWPaOUMdyD6FqwUP/V+UA4DyJ++0/TuGr/Y1XylNHLJ77pBfX9469XlvW/VQERDxHWRwM5tydO7ssJvxI3YJdoZY1r/3Qi6XCgbnGNonnY8sWBmk/WNjZY/mMdL/BkukYrACV8OIkvB0GGtb2A+n6m/23WyATF6KQv5FwW7Pk0i43hLujOgH/PET2gjpa9D4cnu2QkG5vKBqn+ofbiDrsYXTsYz9ytzqWi0VQrszJISu+Nebv6OOLuwMEPkQSFdaoYKCqeR8vuvCeZk3HI90XtDhCJt5teUKflSYr9MgKJ7jZNxWwWLbYhSEOjyZCLdMCRUMRfwDKOQ5dJQJfPUoKnlBs8njv1I7xWV5ZxLSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(2906002)(26005)(83380400001)(38100700002)(86362001)(36756003)(82960400001)(6506007)(8936002)(4326008)(8676002)(6666004)(41300700001)(6512007)(6486002)(966005)(478600001)(66556008)(66476007)(54906003)(66946007)(316002)(6916009)(5660300002)(2616005)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzfv4fNMlqWywE0q0zyfIUk1srBPI7CI8TFYNcvQ1aDblqYtEnfi00r3gKUa?=
 =?us-ascii?Q?kRiHPF3bqsYlyXylCDjfPn4dop48vtku8E2qmpVRjsWDYjh17tAqZ0UVlgfA?=
 =?us-ascii?Q?W3HYN9h7FrEUF9iLLNerC/rTOY0LxRHTvSzN1PnUJjBFBuQQXf4u2aHWszXA?=
 =?us-ascii?Q?lcozxB2DmDMv9gGFWbqTmJHdTCfNkryARF5M2dTx6PnZUXeDfBWRYlHDpYy6?=
 =?us-ascii?Q?ZK8e7AnU8V0QKidNZkxyeu8HToK0tF9EfIgqQvzlHQgRCdmu52ntfBNFuAlZ?=
 =?us-ascii?Q?n+getmjL+W3bSnaD+Adbbel2QpUBYexjol+F6A8YxyeD/2U2I2m7YA3ty4Dh?=
 =?us-ascii?Q?+wKgfWvTuWks/jAdwZ/WBNQX+s43dGhuof0xWL6CLXkRmL/oP6TmOtQSAdjh?=
 =?us-ascii?Q?rX6k10ZDshkzAA3s71bKq2sGzQ77myMOA277j5hFgrtBskU31vnUnUrlDDsb?=
 =?us-ascii?Q?RZ0o+TYKwVI1bONs3PhAW/SsCmYOXuXrWN3qCxlOB+MKTzGYae3cfAMa887w?=
 =?us-ascii?Q?+Wd2zO0CH7PBE2nxPvkFy6LBvdmFbBpLT7twhuTQ/I9H/OtqgiZoXKoXgHxd?=
 =?us-ascii?Q?8jhZXUf58j/MLF4f/nJBtr+QXzol5ETqsh0QZ4wgZHtpl0zuuqPl6/CXbFMf?=
 =?us-ascii?Q?wSANrGCNW4Q/NjecqyMyDPeLo6bC9OSGb4B16yuATu2rpRNXD4fo6M9ExsRU?=
 =?us-ascii?Q?GDTOzcBeQADvSEbbYiZebH9kXKmxMskqElWARa3KXBs5yQxQijc5qn7v9FYl?=
 =?us-ascii?Q?Nzbxbs9nxXlTlHuUuqZkIKcU58UicTgE4Iid/IfiHX6zcmT0ZxHW0f/au0+A?=
 =?us-ascii?Q?+DSi0SoHLoMz4JEuphYcERafg/7lIC2WOPS51ymp2nNA75n0dxKArftxXO24?=
 =?us-ascii?Q?ixn9fbNBhqq8FHgjJ1F1/Ud3i0pVvZM9rHA0NbmnnyBhu69a8ssFB21D/GQT?=
 =?us-ascii?Q?8ichzeor/yFReqKaXmfKRTSlSFDBwquQFQIO9CQbErYeWw3dxkrTsnmfi6dL?=
 =?us-ascii?Q?1v4F9WNm7prL8+tE8eRQSIy7FlFSkPvQ9854uCQuH2YyjYgYEEdMdEQQGBrq?=
 =?us-ascii?Q?AsCtRPnTmosJTuSLMTgtwSsyJukBD3R3ZQ31ma0T82wga5dlnHJzsfVoz3we?=
 =?us-ascii?Q?j8waKCHvx9s3k7PqboYABo+nyZoyLUukp1869iNwB9+ErbW5TwAvUOvckFjH?=
 =?us-ascii?Q?R+UBnmVd1InPrD02EU5xhtGeGCn2yhvCd1T+K8JH3RU2p0tQZ/bA826L2PXg?=
 =?us-ascii?Q?/t1d13C8O/c6L4D3xIIw41VGhqSY+Md+2BhGeOR+YSCxl+TlXSod7Upmx2JS?=
 =?us-ascii?Q?aSG12tXnrF6tYVpq1F0CEm2tSOO+wd3WjRYQvO9ztAW6Qn06ArSAo8pJl+5O?=
 =?us-ascii?Q?gdyR8lBScfJKeQx3mv0Oujhxwle/L3N7LjzN5RelnBNKEgUfhe/OBJBhQzv9?=
 =?us-ascii?Q?dK8MUFZwM3Il2PEoX8A2whnXxLsFGerxq2nAHCnMY+EUaKdJugMPMCNGJbhF?=
 =?us-ascii?Q?5sY/CcqrktESD4Rvi+vNf5IUVlM3cY1RiodoHz1QhrfgYbskRH/alGl23HWJ?=
 =?us-ascii?Q?WUXoORjwHoSUwsIlLzoWY4vSlCkP4llqNyPe1/Vu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 959d003a-42a5-452c-ca70-08dbdea311ad
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 08:33:36.1769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 50CRO/5ebWJInAkx7Aqs8nze1LvRb+pGE6xyEO2UKU3ssY+uuIksppYL/i3Aa3OdopViCJqe50unCowmTmLzhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nava,

kernel test robot noticed a build warning:

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1c41041124bd14dd6610da256a3da4e5b74ce6b1
commit: 01c54e628932c655e4cd2c6ed0cc688ec6e6f96b fpga: versal-fpga: Add versal fpga manager driver
date:   2 years, 4 months ago
config: i386-buildonly-randconfig-005-20231101 (https://download.01.org/0day-ci/archive/20231105/202311052137.qkYX2xHU-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231105/202311052137.qkYX2xHU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202311052137.qkYX2xHU-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/fpga/versal-fpga.c:78:34: warning: 'versal_fpga_of_match' defined but not used [-Wunused-const-variable=]
      78 | static const struct of_device_id versal_fpga_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~~~


vim +/versal_fpga_of_match +78 drivers/fpga/versal-fpga.c

01c54e628932c6 Nava kishore Manne 2021-06-26  77  
01c54e628932c6 Nava kishore Manne 2021-06-26 @78  static const struct of_device_id versal_fpga_of_match[] = {
01c54e628932c6 Nava kishore Manne 2021-06-26  79  	{ .compatible = "xlnx,versal-fpga", },
01c54e628932c6 Nava kishore Manne 2021-06-26  80  	{},
01c54e628932c6 Nava kishore Manne 2021-06-26  81  };
01c54e628932c6 Nava kishore Manne 2021-06-26  82  MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
01c54e628932c6 Nava kishore Manne 2021-06-26  83  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

