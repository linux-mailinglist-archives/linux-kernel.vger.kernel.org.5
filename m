Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3AD7EEDF2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345710AbjKQI57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKQI55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:57:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C066592
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700211475; x=1731747475;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P18y06qBXikrlzHyrhuC6s1QWYxttSrKMdJzjZkFW6A=;
  b=FsYkqOcNm9esTSRX1qFplqlkvv8kE3l6tHmFTHeLfhRbh8Ul2rMyp3B7
   nGNmL99wxlp8TcQF1lc3ku0WRkQNGWxFNJqDzQ3tvfq9/p5hYyuxjiRzN
   1eaDzZ3d8ZIm192UjTl90Th8ZMZD+hutCaGzOUIveQW4C2C7PYTLj9Nqn
   nEFP9u7cE8qkcjN8pndCOi9bkCvrkUK5MPlaOArxg/P+MemIROYZSiBHl
   +2SOwcUSzwy9GUvNeh0mS/UkG4/sqspXNNWeoE/Xz43wb3ZiFroGPBTzp
   pZfzhaEAAv2HKW09C4DV18wgkmJTsPwg91mswK/45UdtJvq2U8/cRnH21
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4350718"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4350718"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 00:57:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="883062446"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="883062446"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 00:57:54 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 00:57:54 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 00:57:54 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 00:57:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iocHg2pSDpWEzKivSGyzK08l2zZdSMWCl+bBqCqyI4ngWEVBf4CZUT/k0UI56H2Kl8ksKYQ98tb131IcUkSxOo5+BUrjaQ/8VU2+/XO+6YCBGZecMHlbaoNe7GcQiqhFBZzISFqhao+OUnJ8b3HMn4EQ+TNZaHq278Hd6ttybD8EDiG3bJTaKgx7JtVrW0s6fkq1Hy9JeZ0sMaNyH0/BuzsygHSPVe7O1sb3SB2h8A8iMDZ/9Hv81j48KSqArudtXCfcJs1gfjwRd9p+7nniYJqSt/yPskhdkj8NI6KbaBEh9+OENM6vAfr7cb1QTvd3syUSc7UXJV8efHPQ54gm3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6zE6oxsUDZE94QLPWpvy1dTyVKq+PuR71ELjdkO/UQ=;
 b=emPTAGbuO2RofoknqR340Wfl6Xms5rP3G/VE55zMU/sZJcKLoADpL9y1nsX70THgy2/fRpURuxgHpgO8qgG/lXkyq2f2QIIxvCgKD+R3ryPgbphHvVyCclZeYfC3VwIx7pxcZ5Agza6X6GS+trIDVUXQwuzT0emwqvLMdwy+oOmYjL38AbtK6i6711KwBjSf7EJeMw2TN9nC6Ea+LXiXyMYGs4yWNorI8QJd2a+Ye6ey+N9KAJnq+fY3ESb1PMUNCXooEenFxWGiyeQjfM7M7QJwGUFsbAMneyODSrB1JFopazeXal8YTki2yylY3unHrLAkHUs205gHei/moznAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by PH7PR11MB6452.namprd11.prod.outlook.com (2603:10b6:510:1f3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 08:57:51 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::15d3:7425:a09e:1c86%4]) with mapi id 15.20.7002.019; Fri, 17 Nov 2023
 08:57:50 +0000
Date:   Fri, 17 Nov 2023 16:53:11 +0800
From:   kernel test robot <yujie.liu@intel.com>
To:     Chris Morgan <macromorgan@hotmail.com>
CC:     <oe-kbuild-all@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: include/asm-generic/unaligned.h:119:16: sparse: sparse: cast
 truncates bits from constant value (aa01a0 becomes a0)
Message-ID: <202311160124.gAKUkd4c-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR01CA0127.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::31) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|PH7PR11MB6452:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce75fdf-5a18-4240-374f-08dbe74b4700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zFZv1IkbD5oBj47bZjuxRnMUCCz1WZ+VX21arEd9sTeTJmw/cEDCY2QI/Kacg1tlBOsPKiVhSFFn1oNvmHC9pGLAF1X4NYF0z6oQPWpIffUmO/E4vF1oLil4pSB4Sf96GQqUnUnE8frX94C12uJPR1azf0fMs/HVc101RUh+KqM+Uierc7pBZAEKj9XF0HIfKTskcAv7uLGQMLVJB8U7v7db7JvEmcFnFyAI1iLIhvkSD0On+DPdFRPQHQDoGpuF5fvDdo//1V+io1BHh1KM36EVbWXuqYGLKGwyn7dQ/DXMqFkreuzcDaNfDQN5HS7MGTXV+UQ+fHz1V7vxQOLk8GRZNv09koP1u8jUK/LfaeKzo2y3ee8VP44dWdWWHQP+qus3T89oV6OzMdVyUuTBSQwOfDZ7viayznDSsV41xCL+0xznaBuV4nnWdCmL6nobMads85P2NnTKHbMqugjxPyViAlwuaMM2g7kyToE660XS+3EYJuhZfXtY0z1SjwMJaYyT2vhNoZXjzL/iGcpXA3G+Juf/d0xhXzkmW4VsbXV07ud5+HWbqfi9gqp52gZnEwZLm45MyRWJwsofS+UwZovm5WDXkg6PFM+09YXtxyujAybLNaESXaWzTXRA61oOMxKQaWrcDr9ap5XadKMNPqJY+tRn5Y/KzytbUprmK5hSQmJo0TuynAuOA3IL+LId
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(230173577357003)(230273577357003)(1800799009)(64100799003)(186009)(451199024)(6506007)(66556008)(66476007)(478600001)(6666004)(6486002)(6916009)(8936002)(316002)(966005)(4326008)(8676002)(6512007)(5660300002)(66946007)(2616005)(1076003)(26005)(83380400001)(38100700002)(41300700001)(36756003)(86362001)(82960400001)(2906002)(41533002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qdDIwpQ+L0Q63Q/0mgzy96l9p9GEN8NMorrSLkWsD49prFf/g4fB0wIVGCOy?=
 =?us-ascii?Q?9f3Z/ipzu6yVPDEoFbp46WnseFKmluxqwBg+XamWF2fu/pEgRL0HQC/L4j13?=
 =?us-ascii?Q?xFhXcwYuSMx+JYotvbpxZ9+CPc2Fww2bD3nB6FajdEI9IkxUpRAm9aTb3OGg?=
 =?us-ascii?Q?MHcewo084OzhHpP62RO/0dBx0YJWrB3f1CJR26HGEtVbN71OpMOu+wwAtQJD?=
 =?us-ascii?Q?60F1pAJBolQQKTCTFbhzti2G3dwz+0zmnGugb9D+ToHWMH87JUEWnYmulww2?=
 =?us-ascii?Q?U4zns0JkQmh0XiUGY+ysflrupVYh8YtfY9xtYN2M79Z9r+eT3RRUekQZL2UN?=
 =?us-ascii?Q?1+277HG6y3fd5bkR3kQ63aNj4Q7LUJJqboqJE1k5HuLzVEpVnmH+oT3VxJ8H?=
 =?us-ascii?Q?zJ8C6BUyaS4L1CAvRffYfqxTTabgAPdPa7hqRqrevQTl6oXZrrh7Z8l0P8p/?=
 =?us-ascii?Q?jQfQlXq7j3goUqiKpwvwuQGs90qa7qS3OE7J6oM8GIbSYpc00n5AMd/RUJgs?=
 =?us-ascii?Q?SPHeCp1BvcE1+S4x7p6645MfzWPBLOC3/BoXcVeRLZNYRlet6bb0ZpJB6qnz?=
 =?us-ascii?Q?DyxsZVoZwFk1fK32jC2Vmk1XjY1w24aq6g+jb0SSMdMRiR5MADvxDFgDb47H?=
 =?us-ascii?Q?GNGr+67OhgTz5hNX6KAxlJf8NvyhThK6Ft5aXySNTNVrwRTQEp+56YQFiYJk?=
 =?us-ascii?Q?fJ7Lw2J4/CRZb3cJ2dEZNG8nXcWzJxTsIrXrcZKgL4GbjdTkJitghS4LuLIO?=
 =?us-ascii?Q?FM9EY7Hyh69VarPIutdQJ3eik8Q2WnpBBqoA8RyoI1BeZ0mwK13ib8fN3XnK?=
 =?us-ascii?Q?e/6vXWixFZnVTqiORY7fAAWopRpMK4yg45atZh9lTWSodeyVvRhTIByyj4GL?=
 =?us-ascii?Q?7KNb6WibgAy9qsGTmlKdEQwNe3k9hzXGGHJ0F4MEHJ3G3uCOG7DJDgVzt5eX?=
 =?us-ascii?Q?rUkJgVUWfDohrLhH31zxFoxpcC4gypnSt53953ieG/+8nt6tIb04fYE5ToRU?=
 =?us-ascii?Q?uqAaX/Sqy0ju6tr6fgUgE7sbdZW1ji5Oy2TfaCnB8Zc5RcEV+NUzn/iqQyKh?=
 =?us-ascii?Q?eXnrL5UozD1hxiO8maKacgpCvoXBg7j93+EXtpjMLZ4tHRS/QBbfzWTHU3vz?=
 =?us-ascii?Q?g1KPayb0jBPWWGTWP9H49GVD8J7vcExabzCdazM6vDdu4Rna9TF1Z+8jqn/M?=
 =?us-ascii?Q?h1vN0pYA0aWtHGXPXOqsElji45skc+XhRrEd93ZR5DC6eo12frUD2+ixrQzx?=
 =?us-ascii?Q?EHq3sBq7LtWBQB4FDxrA0ptC1argkweyw5Mkggy+SA3zyz2SRP6+FKfsLzgg?=
 =?us-ascii?Q?EEsGbeBINi5pTBew05WtV2d5L8E3lf8vylw/9sjgMM9MJ7R2hjslKAk0cYQS?=
 =?us-ascii?Q?861wzIF+nmEgNFvOJavM8HXlFZ7jcVvtbeBn4aY8ezO/mXq4GFgiyB2ClRKt?=
 =?us-ascii?Q?9YaNOa0iV/Ue83y+Z9Co7Kt7jPfSe2sV3qm3ThfKSNpImvKmOY8xaLcKgspG?=
 =?us-ascii?Q?Ask4gwHuVroB/IEXUZOr2LiHHOvWeauhmB5MgLmwg+K/bFICgPnOQcWqkf20?=
 =?us-ascii?Q?LYf4rXhiEaD4cqBj7Sn/0dG5NNA9Vkg23ddY2zOw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce75fdf-5a18-4240-374f-08dbe74b4700
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:57:50.3752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+idIHVa5i5GE1q0syb6Ti2DC8TUwwRJgftjbebGgHhEs9pmoaBbqXWtbMBYO/BIroN59qIa3hIzFcxNJMOcZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6452
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c42d9eeef8e5ba9292eda36fd8e3c11f35ee065c
commit: 66603243f5283f7f28c795f09e7c2167233df0bd Input: add driver for Hynitron cstxxx touchscreens
config: x86_64-randconfig-x001-20230717 (https://download.01.org/0day-ci/archive/20231116/202311160124.gAKUkd4c-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160124.gAKUkd4c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160124.gAKUkd4c-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/input/touchscreen/hynitron_cstxxx.c: note: in included file (through arch/x86/include/generated/asm/unaligned.h):
>> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (aa01a0 becomes a0)
   include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (aa01 becomes 1)
>> include/asm-generic/unaligned.h:119:16: sparse: sparse: cast truncates bits from constant value (ab00d0 becomes d0)
   include/asm-generic/unaligned.h:120:20: sparse: sparse: cast truncates bits from constant value (ab00 becomes 0)

vim +119 include/asm-generic/unaligned.h

803f4e1eab7a89 Arnd Bergmann 2021-05-08  116  
803f4e1eab7a89 Arnd Bergmann 2021-05-08  117  static inline void __put_unaligned_le24(const u32 val, u8 *p)
803f4e1eab7a89 Arnd Bergmann 2021-05-08  118  {
803f4e1eab7a89 Arnd Bergmann 2021-05-08 @119  	*p++ = val;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  120  	*p++ = val >> 8;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  121  	*p++ = val >> 16;
803f4e1eab7a89 Arnd Bergmann 2021-05-08  122  }
803f4e1eab7a89 Arnd Bergmann 2021-05-08  123  

:::::: The code at line 119 was first introduced by commit
:::::: 803f4e1eab7a8938ba3a3c30dd4eb5e9eeef5e63 asm-generic: simplify asm/unaligned.h

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

