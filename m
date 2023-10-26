Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5257D7C7A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343564AbjJZFtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZFtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:49:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E548F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698299381; x=1729835381;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=6yWXcJ7q1e1JrigHI95WVWxzPtUK0DcWTYlRA5vWltY=;
  b=l92lbYuVFup3JMS7ia7iIcLxKCxk/L7zsMvO9+xfoR9B1haAC4kIDRy0
   8FargZfSvkIBeFh4DWhSVOceMLNIQVK9tu5pg3Vnf5YJQ2rQs23coe8z0
   nrBXxH3bs/h9cWLGhdTf03rcHrAOOzAnIJKzoUlMINoPfHNo5rr6BliEV
   IFzCcvY0WdamhhGlpBbEdbifZ3Rspq5H8A0CS6BCp2Pw1KAlJJxh0Q2W7
   5NgOVvcQyMUX0Q4Vxlm6faBPqmex3+EovQR/FLwEoi2R6qE48jCT73Smi
   7bNLOgkwu5e6z7/me+emJltLrN2d1KcZ+NNLJPuSsCiYWA4t2/WjV/T50
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="256686"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="256686"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 22:49:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="882704189"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="882704189"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 22:49:39 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 22:49:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 22:49:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 22:49:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW0c2j+GLPVEl5XCr0C3k0vHu2ApQdRUYbpsSFA4gfsaKFeOrVTSQqjb/mt65jP2BbILSTFMElGGVKvSbvRTfkdH0418vcb7pHTW+Mm8Y1mSmPv8VWoIt64+Iv4rYQIjuwaW5hO7MJV8SqAzKjkhjZKMPwF6djAuIUVAAdTzt6cB97iiqH2ZPtf2NhcodfQtJP4EgOkUV3dFCNiNi8UPwtJOPSDeJAZA/MHK1kg+Wzx5DIGjGnSJxQpMjM4EFRzlRFxi1RDG/7/1bF9Z8t69jIwa1+TxjfrBZbH8aPDzgJysIT0WawixyX78WY3+uKvGcvlfhOSGtxwNaDDybQRAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bHPuS79qQFsEP3AoUDG5hOys/4fYvRhn0JTQKcVd92E=;
 b=UQ75rP286HFtm/2jt/Ntgd9TmObK39ZFMyWKjfAImFkvx6V1oPIF1VKMQ8rR/O476JNhyb9k5sKKoXieYhMUX+MSmi2/S2Y2YU/JD/5WxZim6RUm5Wm5BXlQiWTmhjefiQCmTCSnFCHTjaLncoowm47Q2ivMTmyE/ORBMr7PlcGntOh0uEIkG4ipg+3sFsmH8uAFoM9jy9hRXqVRNmRGeJg6GvjTb5re8XB4TYpflLY7iLJ0BWIeyzKLTMk8bySRyyADoTReTJjcXOkD61Ix3SAEtRcaMBhVXnxzx8CzzIaBBiH3iDBpsVnJ7q3iQgARlPD2OxvwdaLb5TiFCBT5yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by DM6PR11MB4737.namprd11.prod.outlook.com (2603:10b6:5:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Thu, 26 Oct
 2023 05:49:31 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::29f0:3f0f:2591:d1f6%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 05:49:30 +0000
Date:   Thu, 26 Oct 2023 13:49:21 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     <chengming.zhou@linux.dev>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-mm@kvack.org>,
        <cl@linux.com>, <penberg@kernel.org>, <rientjes@google.com>,
        <iamjoonsoo.kim@lge.com>, <akpm@linux-foundation.org>,
        <vbabka@suse.cz>, <roman.gushchin@linux.dev>,
        <42.hyeyoo@gmail.com>, <linux-kernel@vger.kernel.org>,
        <chengming.zhou@linux.dev>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        <oliver.sang@intel.com>
Subject: Re: [RFC PATCH v3 6/7] slub: Delay freezing of partial slabs
Message-ID: <202310261032.b4590eb0-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231024093345.3676493-7-chengming.zhou@linux.dev>
X-ClientProxiedBy: KL1PR01CA0064.apcprd01.prod.exchangelabs.com
 (2603:1096:820:5::28) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|DM6PR11MB4737:EE_
X-MS-Office365-Filtering-Correlation-Id: c10ba2fb-4582-4587-b5b0-08dbd5e7529e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 731poS4Wv0giAN8TdQQnolHuguOOdd25rD5jdY5UrbTXbnFWYkYiKCNEnkZW/g4PIISgquh1XIo9FX9pvDfSw+KuGe5bxPH/tkGSwb3PanwqovQmeMIrxWeU+aDyNZ1JvRUKaSeoGEJqtLYtwmRPjXKrnCR23jhgmjzhdHIxLIiuFTIKqWmDVTzmX5l85PDwLJC0FyVNnG+8lpdBzi2fuKH6MmOuUimwgMGAqEWvATcoxrqhsCtu+zs2rDqfGJFz+9AqDJa7NiLgXNeBR9YTqA1jxVfbWkDs/KWE7ulduzQBp8nFJkBnMbOmDZjmCqxTjPncEX3DGEr88uVKVaQgAC6P9ybRHLC7jVJ+xgXev4EhlvKsGSEar75B/wVYehShlZVOf777dTrPYEOtbKxvf3RS14WU3exMFAFv5F6u96MCDW18QZ4589A4htjVL76XhsjwkKYltxVq0VHDWHvewosnQdN+zUroWYDAI0zaMDOcfigqfBzkJx9xVYydfrM8S06cUV6UOyXBJs/H97CqOnuPJ5c1zSW2xtF0L8mob64vpp+33RLBpXvAj8dcsY40EP1poAM/HkcRUohaFABCiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(1076003)(6512007)(26005)(2616005)(45080400002)(107886003)(6506007)(6666004)(478600001)(7416002)(6486002)(83380400001)(966005)(41300700001)(66476007)(5660300002)(66946007)(66556008)(8936002)(8676002)(4326008)(316002)(6916009)(38100700002)(82960400001)(86362001)(36756003)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NZE+YKRjGmTvMzlhm6OWxbDvjA/GXpmr2OME/KfDBuBTc5aevRUpylaoBeBi?=
 =?us-ascii?Q?zAVz0t8Q+sRTXfkwIlI44xiU9OxBmW94XbOtX0tPExC93lFioyfabdIo0qGd?=
 =?us-ascii?Q?3acO36iMJtm0Firfrqjg9nVzm+vXS2FKa5qumMDU5f2MfJ0k3g0oEZCGxHxt?=
 =?us-ascii?Q?jFd4rh48fLzprypLFksdslhJSzQ0AtNidlQLh8Mfvyf1B543gwZwsNEnsVJl?=
 =?us-ascii?Q?HR4eARfioeSE2mwY8M/hU22gvlUuEjZYU6ldMpqGSaZVr4Nsdskj/nLDnTNk?=
 =?us-ascii?Q?XwWNXhBivMbW7ILNmjDz0zCQlxiFG9Z7HzTeXlvNqvaSIeeoAYLfK4Q2hJMr?=
 =?us-ascii?Q?6yiad9SeGGhs/BhIknLXwZ36z4wfRpYuem3V99uaguaYy3lf4YmmK0R5BUWE?=
 =?us-ascii?Q?xSiNXWG+ziANZ9H0ZjvORFcIxR173y1R0cclq4KcjP0ISACgvHqyJab/5nUX?=
 =?us-ascii?Q?wXm2Kf60dJEIAGHx4GS6r6A7OsQftfbEAgA+3cA49RkR6VrZjnovOg94V+tg?=
 =?us-ascii?Q?X/fLuiRI3vG8hbO4sPhMf1JWG/2ZJXr6CvCNieH335oOg/3nHhjcV2EVfd+U?=
 =?us-ascii?Q?zdk1QG2Wy+P/s2UKzqnZPqtJutY/oLMPDNDR2YzKZwJ+DhiVIw8Y4bnV5/dg?=
 =?us-ascii?Q?qJB/XxQcxZsP/IoFrkJRSMZFzBk+S+1OktWtxPk/r17x9tJE42eMZ5KJYYHZ?=
 =?us-ascii?Q?YCZYT+EDI8LmCy3WUv2X+ejSexstRUSEINCHW+mCskjNwjb7+OKmvONnzUOU?=
 =?us-ascii?Q?R+O3rWcPuaglbidxF71pSobXsjAiVMUExJjEoACzSYI4IYtjSJITEZZR3BBq?=
 =?us-ascii?Q?eNNdXUrDM7r06cNnDXHC3xe/lsDnyA8QacHdLrmXCn6M7UDXg/q1ssGV4S0c?=
 =?us-ascii?Q?EaJnTtqiF8DgyLXZ/lxF1B4ROVBgsSxEMKCcXcQzDu1Z1hhIyEGwrADMkl9c?=
 =?us-ascii?Q?MNQ1ZvMuFCOCnX3X7BHC9kevI+wBFbZcKcuPh4z+W+wZ881IWiYsE4hy8Yb2?=
 =?us-ascii?Q?0B87RvULy9udq1YgtyOR8H2VgcWFRxCk8gru5BtHD6CToNjpaXis4ZPKEuBg?=
 =?us-ascii?Q?FLWr1f2Da7Tw4f/UNrJGIOAkKciLcaQiovdaT/9XHD2JATWW5X9L5VNLIprZ?=
 =?us-ascii?Q?w0jCCBdB3sWlFnMEcPe230RaTxuDy5M0FK///z8FIBO9e4YuprhfmJMHj+qX?=
 =?us-ascii?Q?JuEdk35kZw66Gknb+fxc2Ndm1jk3+pA2jQlwoLTByWVsg7aL+RUmOeP8+uhh?=
 =?us-ascii?Q?n52xtBJ7ctwXzpdkGnSEm/BEriIACAqjJQ34/zZWB+lSUW+E1SF1kZrhh+gN?=
 =?us-ascii?Q?dvNy4diASg3m1EryR0y/rKCryG0jFok4x9zo1YmP1k3OFNo3a2/R67R3ttDe?=
 =?us-ascii?Q?yTzpplHexrts+gCNQKsn4Dg9/JCSphe6SKI+qD9AJzxSF6FxNdAGbS909Ue3?=
 =?us-ascii?Q?GXXL8+QuvzvGGNWlXpURQWZcYFTjT4Bgv5kFryoPP7faHfjKTtN0Zk7u5ShB?=
 =?us-ascii?Q?orDAkNLStuaV/ya0MSE7PmuZaxOXP0Udgxb9dzqtH+m7vec9IK6QrtdmJMXK?=
 =?us-ascii?Q?sTd6qly3Bd5A36n78ZvmSQMJ1dDwquBlTICCIuTmrIvG+/w3qM7a24nhPxYX?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c10ba2fb-4582-4587-b5b0-08dbd5e7529e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 05:49:30.7226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cylnebmlEjGv+33QMejaint8yXib2FPvVSWlZ3pku7hyRJpHHukPawp2qYc4GqqVMlJhMEhUfN1N+yXpusBTwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4737
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "WARNING:at_mm/slub.c:#___slab_alloc" on:

commit: b34342e2732b0dc92b29d6807c5314e2e5e0c27c ("[RFC PATCH v3 6/7] slub: Delay freezing of partial slabs")
url: https://github.com/intel-lab-lkp/linux/commits/chengming-zhou-linux-dev/slub-Keep-track-of-whether-slub-is-on-the-per-node-partial-list/20231024-173519
base: git://git.kernel.org/cgit/linux/kernel/git/vbabka/slab.git for-next
patch link: https://lore.kernel.org/all/20231024093345.3676493-7-chengming.zhou@linux.dev/
patch subject: [RFC PATCH v3 6/7] slub: Delay freezing of partial slabs

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: default
	torture_type: rcu



compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------+------------+------------+
|                                                | e87d1d9973 | b34342e273 |
+------------------------------------------------+------------+------------+
| boot_successes                                 | 15         | 0          |
| boot_failures                                  | 0          | 15         |
| WARNING:at_mm/slub.c:#___slab_alloc            | 0          | 15         |
| RIP:___slab_alloc                              | 0          | 15         |
+------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202310261032.b4590eb0-oliver.sang@intel.com


[    4.907500][    T1] ------------[ cut here ]------------
[ 4.908232][ T1] WARNING: CPU: 0 PID: 1 at mm/slub.c:577 ___slab_alloc (mm/slub.c:577 mm/slub.c:3033 mm/slub.c:3205) 
[    4.909242][    T1] Modules linked in:
[    4.909739][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc5-00013-gb34342e2732b #1
[ 4.910746][ T1] RIP: 0010:___slab_alloc (mm/slub.c:577 mm/slub.c:3033 mm/slub.c:3205) 
[ 4.911433][ T1] Code: 9f 05 66 25 ff 7f 66 89 45 b8 48 8b 4d b8 45 85 e4 74 1a 65 8b 05 dd c4 a3 7e 85 c0 75 0f 65 8b 05 de c1 87 7e 85 c0 74 04 90 <0f> 0b 90 81 e6 00 00 00 40 74 31 4c 89 f8 f0 49 0f c7 48 20 0f 84
All code
========
   0:	9f                   	lahf
   1:	05 66 25 ff 7f       	add    $0x7fff2566,%eax
   6:	66 89 45 b8          	mov    %ax,-0x48(%rbp)
   a:	48 8b 4d b8          	mov    -0x48(%rbp),%rcx
   e:	45 85 e4             	test   %r12d,%r12d
  11:	74 1a                	je     0x2d
  13:	65 8b 05 dd c4 a3 7e 	mov    %gs:0x7ea3c4dd(%rip),%eax        # 0x7ea3c4f7
  1a:	85 c0                	test   %eax,%eax
  1c:	75 0f                	jne    0x2d
  1e:	65 8b 05 de c1 87 7e 	mov    %gs:0x7e87c1de(%rip),%eax        # 0x7e87c203
  25:	85 c0                	test   %eax,%eax
  27:	74 04                	je     0x2d
  29:	90                   	nop
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	90                   	nop
  2d:	81 e6 00 00 00 40    	and    $0x40000000,%esi
  33:	74 31                	je     0x66
  35:	4c 89 f8             	mov    %r15,%rax
  38:	f0 49 0f c7 48 20    	lock cmpxchg16b 0x20(%r8)
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	90                   	nop
   3:	81 e6 00 00 00 40    	and    $0x40000000,%esi
   9:	74 31                	je     0x3c
   b:	4c 89 f8             	mov    %r15,%rax
   e:	f0 49 0f c7 48 20    	lock cmpxchg16b 0x20(%r8)
  14:	0f                   	.byte 0xf
  15:	84                   	.byte 0x84
[    4.913822][    T1] RSP: 0000:ffffc9000001f830 EFLAGS: 00010202
[    4.914602][    T1] RAX: 0000000000000001 RBX: 0000000000000000 RCX: 0000000080270027
[    4.914743][    T1] RDX: 0000000000270021 RSI: 0000000048000000 RDI: ffffffff842e066b
[    4.915745][    T1] RBP: ffffc9000001f8e0 R08: ffffea0005931d40 R09: fffffbfff0e33a5a
[    4.916743][    T1] R10: ffffffff8719d2d7 R11: 0000000000000000 R12: 0000000000000001
[    4.917696][    T1] R13: ffff8883ae809430 R14: ffff88810033e3c0 R15: ffff888164c75dd0
[    4.918688][    T1] FS:  0000000000000000(0000) GS:ffff8883ae600000(0000) knlGS:0000000000000000
[    4.918754][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.919522][    T1] CR2: ffff88843ffff000 CR3: 0000000005c89000 CR4: 00000000000406f0
[    4.920500][    T1] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    4.921496][    T1] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    4.922461][    T1] Call Trace:
[    4.922742][    T1]  <TASK>
[ 4.923107][ T1] ? __warn (kernel/panic.c:673) 
[ 4.923632][ T1] ? ___slab_alloc (mm/slub.c:577 mm/slub.c:3033 mm/slub.c:3205) 
[ 4.924250][ T1] ? report_bug (lib/bug.c:180 lib/bug.c:219) 
[ 4.924831][ T1] ? handle_bug (arch/x86/kernel/traps.c:237) 
[ 4.925376][ T1] ? exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 4.925962][ T1] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 4.926595][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 4.926741][ T1] ? ___slab_alloc (mm/slub.c:577 mm/slub.c:3033 mm/slub.c:3205) 
[ 4.927370][ T1] ? acpi_ut_allocate_object_desc_dbg (include/linux/slab.h:710 include/acpi/platform/aclinuxex.h:67 drivers/acpi/acpica/utobject.c:359) 
[ 4.928186][ T1] ? kmem_cache_alloc (mm/slub.c:3295 mm/slub.c:3348 mm/slub.c:3440 mm/slub.c:3458 mm/slub.c:3465 mm/slub.c:3474) 
[ 4.928824][ T1] kmem_cache_alloc (mm/slub.c:3295 mm/slub.c:3348 mm/slub.c:3440 mm/slub.c:3458 mm/slub.c:3465 mm/slub.c:3474) 
[ 4.929442][ T1] ? acpi_ut_allocate_object_desc_dbg (include/linux/slab.h:710 include/acpi/platform/aclinuxex.h:67 drivers/acpi/acpica/utobject.c:359) 
[ 4.930221][ T1] acpi_ut_allocate_object_desc_dbg (include/linux/slab.h:710 include/acpi/platform/aclinuxex.h:67 drivers/acpi/acpica/utobject.c:359) 
[ 4.930743][ T1] acpi_ut_create_internal_object_dbg (drivers/acpi/acpica/utobject.c:71) 
[ 4.931576][ T1] acpi_ut_copy_esimple_to_isimple (drivers/acpi/acpica/utcopy.c:434) 
[ 4.932394][ T1] acpi_ut_copy_eobject_to_iobject (drivers/acpi/acpica/utcopy.c:618) 
[ 4.933185][ T1] ? __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383) 
[ 4.933816][ T1] acpi_evaluate_object (drivers/acpi/acpica/nsxfeval.c:259) 
[ 4.934486][ T1] ? acpi_get_data_full (drivers/acpi/acpica/nsxfeval.c:167) 
[ 4.934756][ T1] ? hlock_class (arch/x86/include/asm/bitops.h:228 arch/x86/include/asm/bitops.h:240 include/asm-generic/bitops/instrumented-non-atomic.h:142 kernel/locking/lockdep.c:228) 
[ 4.935345][ T1] ? __uuid_parse+0xd0/0x1b0 
[ 4.936024][ T1] acpi_run_osc (drivers/acpi/bus.c:217) 
[ 4.936609][ T1] ? acpi_bus_detach_private_data (drivers/acpi/bus.c:187) 
[ 4.937363][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 4.938127][ T1] ? acpi_get_data (drivers/acpi/acpica/nsxfname.c:48) 
[ 4.938710][ T1] acpi_bus_init (drivers/acpi/bus.c:352 drivers/acpi/bus.c:1329) 
[ 4.938742][ T1] ? up (include/linux/list.h:373 kernel/locking/semaphore.c:188) 
[ 4.939205][ T1] ? acpi_sleep_proc_init (drivers/acpi/bus.c:1289) 
[ 4.939862][ T1] ? _raw_spin_unlock_irqrestore (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[ 4.940581][ T1] ? acpi_os_signal_semaphore (drivers/acpi/osl.c:1294 (discriminator 5)) 
[ 4.941313][ T1] ? acpi_ut_release_mutex (drivers/acpi/acpica/utmutex.c:329) 
[ 4.942007][ T1] ? acpi_install_address_space_handler_internal (drivers/acpi/acpica/evxfregn.c:94) 
[ 4.942744][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1390) 
[ 4.943325][ T1] acpi_init (drivers/acpi/bus.c:1404) 
[ 4.943832][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1390) 
[ 4.944420][ T1] ? kb3886_init (drivers/video/fbdev/core/fbmem.c:1111) 
[ 4.944976][ T1] ? acpi_bus_init (drivers/acpi/bus.c:1390) 
[ 4.945579][ T1] do_one_initcall (init/main.c:1232) 
[ 4.946157][ T1] ? trace_event_raw_event_initcall_level (init/main.c:1223) 
[ 4.946747][ T1] ? kasan_set_track (mm/kasan/common.c:52) 
[ 4.947373][ T1] ? __kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383) 
[ 4.948010][ T1] do_initcalls (init/main.c:1293 init/main.c:1310) 
[ 4.948614][ T1] kernel_init_freeable (init/main.c:1549) 
[ 4.949315][ T1] ? rest_init (init/main.c:1429) 
[ 4.949894][ T1] kernel_init (init/main.c:1439) 
[ 4.950743][ T1] ? _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202) 
[ 4.951386][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
[ 4.951957][ T1] ? rest_init (init/main.c:1429) 
[ 4.952520][ T1] ret_from_fork_asm (arch/x86/entry/entry_64.S:312) 
[    4.953143][    T1]  </TASK>
[    4.953514][    T1] irq event stamp: 85121
[ 4.954040][ T1] hardirqs last enabled at (85129): console_unlock (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:77 arch/x86/include/asm/irqflags.h:135 kernel/printk/printk.c:347 kernel/printk/printk.c:2718 kernel/printk/printk.c:3037) 
[ 4.954736][ T1] hardirqs last disabled at (85138): console_unlock (kernel/printk/printk.c:345 kernel/printk/printk.c:2718 kernel/printk/printk.c:3037) 
[ 4.955884][ T1] softirqs last enabled at (84862): __do_softirq (arch/x86/include/asm/preempt.h:27 kernel/softirq.c:400 kernel/softirq.c:582) 
[ 4.957017][ T1] softirqs last disabled at (84857): irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644) 
[    4.958128][    T1] ---[ end trace 0000000000000000 ]---


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231026/202310261032.b4590eb0-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

