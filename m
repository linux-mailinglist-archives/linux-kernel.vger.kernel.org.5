Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92927FE649
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 02:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344033AbjK3BkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 20:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjK3BkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 20:40:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBBA198;
        Wed, 29 Nov 2023 17:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701308412; x=1732844412;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=ouNf5m7gBhw6ZLHS+dbXCY9MmS6J7XMWKEt6vHxJu88=;
  b=AIXpXHsrAIzaCMMDgm0PrsA6VmLVAtNUhIWGuCk/KXVbdC1CDAYD66DK
   jMknI3eRTSK/5AijH2b+OtuUvPIkgUpgsgXNsuN1abj4lhP9Eu7HX/UAw
   7ulWUTjowrCuClHTqbharSK67EFuXbXigYpUCDfPxVr+zcaP7wvfkisl4
   LW7HhsovyawEiR1/2GQDhGe8xQFtIOehbhA5K2LM+fqkt/PbUekBZ5932
   gC/lDW1hBteasklk3BhPpV5rHLhIZZDAviqSq8TusGoJcI53nrlN4g70k
   tBL8mw2zrhdQmHEgsq+zcAfYyU5OrIl5kuk/p6kQgDhFGm/S09/H37rk5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="132414"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="132414"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:40:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="1016471000"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="1016471000"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 17:40:09 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 17:40:07 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 17:40:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 17:40:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsLHFT+iqfkfZm8UBLVk3MGQEuIXs60a3RA5yTEbIVcCZMIh1t/uy66gD5Q5uUqwOXjeJkkWacVQ6DO4Abr5cnI/UvKBzFqSMPR/aDYO3vUKrHTRBEzung+/YXU53BXQ0OWuO//htu4QB2G0RVzqZL8dYyvUnfLQ+sUITGYLYeOzQwjsscmETLojwyrgImW1W3TZFWiw/8Kt35GGThAjN2H5Mmh8mNlv/wUB1vqKdTsJwobMkIxZEqL8TIOzI0ikRZNNGRHEsn6FHq4ZR+so2FqHSdPPH0fpoJMTn91mBshXPKeHduD9f3y7TUcdNw+nAYz/tre0MOITYmzQ66XLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KrL3hg7b8wf6kBa7teXXM0oM9Zv26QFfCs09xv3qTTQ=;
 b=XoJidYP4KTa28GOGHSDDxrX0Hxy4VDGcdJwJOVqW4FSb5vfYluoBTnQoOsFt06GDjj5Z6YYAqmFbNiq2rn2IgI64ASA+Gpoyo3e5eNMXqy3QSB1iKHHqi6zxDscu8YBFCJjN37qdVQcDSGltQJmwlqTUxF5GOjUnqvbYVUHtWDH9KA7qK6Xcu3hzTqJ65SVtYoeJXkHEsyIMya6yx0N24d5Tm/lUlMmSCVscoKibA41X15bR/LJToTQRKsFIDvPAyMjjGcf0pUhF0FdVmFWvKG3zfgzI/EKWBJSAJsmYUYp4iQ9kmaMwWbXsQ/y1AtoR40iudI09tTQrEE+ZuCn9ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MN2PR11MB4517.namprd11.prod.outlook.com (2603:10b6:208:24e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:40:04 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::1236:9a2e:5acd:a7f%3]) with mapi id 15.20.7025.022; Thu, 30 Nov 2023
 01:40:04 +0000
Date:   Thu, 30 Nov 2023 09:39:53 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     David Howells <dhowells@redhat.com>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        "Rohith Surabattula" <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>, <dhowells@redhat.com>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: Re: [PATCH] cifs: Set the file size after doing copychunk_range
Message-ID: <202311292134.366c9c0b-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1297339.1700862676@warthog.procyon.org.uk>
X-ClientProxiedBy: SG2PR06CA0210.apcprd06.prod.outlook.com
 (2603:1096:4:68::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MN2PR11MB4517:EE_
X-MS-Office365-Filtering-Correlation-Id: d77093b1-345f-4f73-d6a0-08dbf14545d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bC4symoDWtE0GPLIU97toC0fIsJ35La57zG6zcvtNSXAeyhcD9hFjfDtmVH7BdhQi6PrB3nWe6x/xzedpLa+ZZqJyBKHAcBT/msxI417Cbqr8X7atjcpZdE9P5vlbZ3yJo926AKqzdfNePW4vUPidiwWVk5N4L4ZJp5T0bro9DvKFux6TZ4MIO9jeL6FiutcT3XgcBJ4f64pTg5cB1MSqFortisupxrVXhCFuGF39mDtqATBwBdiO+VytXzVZeNuIjn71+67NnvDa0mZA8cZJQGGf4OqZGn6ttDJp5/gaZ0Pqean5jjVCavz/hgQNTsNAaRaEgGbeJ8Kvq3KRhbqr8R1e3Ytdk1SeJvLfzn6qVLiXJk+SyObHJHq5DW45DrazS2mfWn7K4MZ1Di1QlXUannmXZnmcGtPu9Xn+SQvAkrIQfFli1ZkYaXAiC79bmEuo4E5zIyPZumhK1FgFNnMxzGMFSyPqEcl3S7+FtdDD+VNYAlIQx+sYPGg9Wkntca+aAfR1o/RQCWRlN3OwOjzPniBEPnNaVMZUSR5EJyRPAlhdi6zQv62q0Ico7hX3f6BDgYM0upB4ZTxp6+tCUGbSQ2DKI1J4X+IIQO3gKkUdOhIM3amtNntrBZkUX0GcnziWDqQol+fm40IoAkQ7/eYMw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(6506007)(6666004)(6916009)(38100700002)(41300700001)(8676002)(4326008)(8936002)(36756003)(6512007)(966005)(478600001)(2906002)(6486002)(107886003)(2616005)(1076003)(5660300002)(66946007)(316002)(54906003)(66556008)(66476007)(86362001)(26005)(202311291699003)(82960400001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jNEXdq4/Y4v577BBMo7lt8Dw36Je0Y9LvwANH1O/5gVCmBWDySL/bjiy83/W?=
 =?us-ascii?Q?dJy5BKovY71ug7cj6HGVOh/Ow/0KjLnS6H4PL/kJhJj8VZVIj8jnMcp+YEex?=
 =?us-ascii?Q?5eedrOYmmDYmOv7IPstHkgJbtCmhzWwV80Xr4utOpLWEX98MufcEoz78cZUK?=
 =?us-ascii?Q?BLbcImQUcK7+kEO0u3exZ4BXhKleKT68+wfBpvGSPdr0S3kz16023LWkOn0m?=
 =?us-ascii?Q?sR3BwVVNIZ2Vws/Vrc9QXxd3kK+5SwmL0i1xZX6S1iGaSkc6W7Vz6l3qmBV4?=
 =?us-ascii?Q?XHVW2lNl/PogAF/HOtCLpZzmvm+tQ7UPRTXRbvGZJt6Q/hzdzibs1Y1j5tEv?=
 =?us-ascii?Q?DJ2kXuTCgeDiU79qva7P8K5kkhSpfHTVXnKEWxnnJLoRQghqQmf9jCC9/ZmD?=
 =?us-ascii?Q?JXPn9GqqXeqoobZ7j81NILUAZQdR5y3C7WUj1fLmniHfpQG56h2A+hFBoLyY?=
 =?us-ascii?Q?juOD/ul3x4t05GFkBugoAJreZQkLk8OnXwhcnEpe8KRVtgwPEz/REjeUfj3t?=
 =?us-ascii?Q?+ONw/zbD8CbtIqlovf8DuhE3iYrVk358YSvteO5t3nyp6cpBb0tkw8wQ8s8s?=
 =?us-ascii?Q?+6afQLJhILw5s9/wqjlCc+pjqfE51DTaBkfd9/Uq4UHHxNtS77RRIG/Y2nrw?=
 =?us-ascii?Q?mhVfQ28CBVgB64QiAIXHBj5feTasZ/CdU7sk3urUoLTAlz6II/7A6L4I+6jF?=
 =?us-ascii?Q?tiIdkwfotOUzAP0b2SupOTAaqT3x0k/dh1gKSmhzlU9Lyt7eTLcKMy/rUKYt?=
 =?us-ascii?Q?uuDs2y+5tqJIbQQI26lvYpe/vFOPfgOOE9eUEoZQBx7dJwYFDp+UiBHkjLSo?=
 =?us-ascii?Q?3rOoKuXfDCMLiSy2lBrd+BPoBOAcpPaKo0GzeL9VcuplCFUXcI9t9i0TvhjM?=
 =?us-ascii?Q?kaMlzlkyatfWTjiKDOk676gCQ0CPAcMAm+48AaRaiy+lyMaIjHeZ6gLej+WV?=
 =?us-ascii?Q?RGCGZ1iWPCuI9QouaBzCuY9l2ip6+LtOv6A76K1vLpIyci5NY4xCZY3vRycA?=
 =?us-ascii?Q?nSVoThMeU7gludBotJzQf8W0qP8cKFhXyKSyY7xN4UpWaAe64qKfH8HeOpP0?=
 =?us-ascii?Q?cDhEJDajTajh4aUj2ynv5SxAGFMpNtY6+z5JjMJSelFrT/m09iAdoF/YJlJy?=
 =?us-ascii?Q?Z1EVXx9BzzDdrs1O05s3eMwRg4gvZRNR8gbnARg6TPAOygcB/GmmIiYnSLmi?=
 =?us-ascii?Q?0ocajyh5sUJZHhI1t4TXt0LtykvrTvw65IiILVu9A20Tp9jeCfU0GSMbpYvi?=
 =?us-ascii?Q?MsaQtN6cyAwv2+ZYoAPPooDvYd8k52l4nF7ZIRBrqprJR/jg+853uZDr7OUg?=
 =?us-ascii?Q?RoRAsvC0uCgbuf8Q+DSmV+v0sjJ6JlWLXBW0EwSs13SN0o4+cPOonXPihX1W?=
 =?us-ascii?Q?QHZr4bR2qJ0wZYdaQ2MkoxgssXPD/0FHbHTnseXHrYVy1QYjyRonWrqsCtpi?=
 =?us-ascii?Q?uSV6w0x+qTjHVuI6giKZfsaHO/ijBbCynCkmo1OK8/m4ZpG0rEvdksV0+AIA?=
 =?us-ascii?Q?dVF4nTUyu8IYIjZzQze9IhG9rhcpt8LzgDPj8HCI31GK3Le3+UsQhlGhdeSQ?=
 =?us-ascii?Q?Q2WZiBUpm+S91x3zymeZIlP7db2CWkbLLfGxD2g0sBNybCarvMMRpJJU0z1p?=
 =?us-ascii?Q?6w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d77093b1-345f-4f73-d6a0-08dbf14545d7
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:40:03.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Tgwf9VQrepjmVA3d664tAx4WI58wWytl5bDsYh2PgpUndT/g1PRUDG5VpZwQhmLhCwRd7iU/u8i5WW5j6ZOuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4517
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



Hello,

kernel test robot noticed "kernel_BUG_at_include/linux/highmem.h" on:

commit: 7ea84f5cb7518fa39de48aadafa14f129e9463c5 ("[PATCH] cifs: Set the file size after doing copychunk_range")
url: https://github.com/intel-lab-lkp/linux/commits/David-Howells/cifs-Set-the-file-size-after-doing-copychunk_range/20231125-055345
base: git://git.samba.org/sfrench/cifs-2.6.git for-next
patch link: https://lore.kernel.org/all/1297339.1700862676@warthog.procyon.org.uk/
patch subject: [PATCH] cifs: Set the file size after doing copychunk_range

in testcase: xfstests
version: xfstests-x86_64-11914614-1_20231122
with following parameters:

	disk: 4HDD
	fs: ext4
	fs2: smbv2
	test: generic-group-11



compiler: gcc-12
test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (Skylake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311292134.366c9c0b-oliver.sang@intel.com


[  207.421597][ T2704] ------------[ cut here ]------------
[  207.427162][ T2704] kernel BUG at include/linux/highmem.h:275!
[  207.433050][ T2704] invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
[  207.439375][ T2704] CPU: 3 PID: 2704 Comm: fsx Tainted: G S                 6.7.0-rc2-00006-g7ea84f5cb751 #1
[  207.449260][ T2704] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
[ 207.457394][ T2704] RIP: 0010:zero_user_segments (include/linux/mm.h:2069 include/linux/highmem.h:284) 
[ 207.464138][ T2704] Code: 41 5e 41 5f c3 48 89 df 89 ea 31 f6 4c 29 f7 44 29 e2 48 c1 ff 06 48 c1 e7 0c 4c 01 ef 4c 01 e7 e8 4f 7e 08 02 e9 5a ff ff ff <0f> 0b 48 89 df e8 60 13 1a 00 eb 91 4c 89 ef e8 36 13 1a 00 eb ae
All code
========
   0:	41 5e                	pop    %r14
   2:	41 5f                	pop    %r15
   4:	c3                   	retq   
   5:	48 89 df             	mov    %rbx,%rdi
   8:	89 ea                	mov    %ebp,%edx
   a:	31 f6                	xor    %esi,%esi
   c:	4c 29 f7             	sub    %r14,%rdi
   f:	44 29 e2             	sub    %r12d,%edx
  12:	48 c1 ff 06          	sar    $0x6,%rdi
  16:	48 c1 e7 0c          	shl    $0xc,%rdi
  1a:	4c 01 ef             	add    %r13,%rdi
  1d:	4c 01 e7             	add    %r12,%rdi
  20:	e8 4f 7e 08 02       	callq  0x2087e74
  25:	e9 5a ff ff ff       	jmpq   0xffffffffffffff84
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	48 89 df             	mov    %rbx,%rdi
  2f:	e8 60 13 1a 00       	callq  0x1a1394
  34:	eb 91                	jmp    0xffffffffffffffc7
  36:	4c 89 ef             	mov    %r13,%rdi
  39:	e8 36 13 1a 00       	callq  0x1a1374
  3e:	eb ae                	jmp    0xffffffffffffffee

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	48 89 df             	mov    %rbx,%rdi
   5:	e8 60 13 1a 00       	callq  0x1a136a
   a:	eb 91                	jmp    0xffffffffffffff9d
   c:	4c 89 ef             	mov    %r13,%rdi
   f:	e8 36 13 1a 00       	callq  0x1a134a
  14:	eb ae                	jmp    0xffffffffffffffc4
[  207.483716][ T2704] RSP: 0018:ffffc90008f6f9d0 EFLAGS: 00010297
[  207.489673][ T2704] RAX: 0000000000001000 RBX: ffffea0004b3fac0 RCX: ffffffff817f36f2
[  207.497547][ T2704] RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffea0004b3fac0
[  207.505421][ T2704] RBP: 00000000fffe35b2 R08: 0000000000000000 R09: fffff94000967f58
[  207.513295][ T2704] R10: ffffea0004b3fac7 R11: 0000000000000230 R12: 00000000000007f6
[  207.521168][ T2704] R13: ffff888000000000 R14: ffffea0000000000 R15: 00000000fffe35b2
[  207.529042][ T2704] FS:  00007f21a955d740(0000) GS:ffff88879c380000(0000) knlGS:0000000000000000
[  207.537887][ T2704] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  207.544376][ T2704] CR2: 00007f21a94bf000 CR3: 000000012e1f2002 CR4: 00000000003706f0
[  207.552250][ T2704] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  207.560125][ T2704] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  207.568001][ T2704] Call Trace:
[  207.571162][ T2704]  <TASK>
[ 207.573971][ T2704] ? die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434 arch/x86/kernel/dumpstack.c:447) 
[ 207.577572][ T2704] ? do_trap (arch/x86/kernel/traps.c:112 arch/x86/kernel/traps.c:153) 
[ 207.581695][ T2704] ? zero_user_segments (include/linux/mm.h:2069 include/linux/highmem.h:284) 
[ 207.587832][ T2704] ? do_error_trap (arch/x86/include/asm/traps.h:59 arch/x86/kernel/traps.c:174) 
[ 207.592317][ T2704] ? zero_user_segments (include/linux/mm.h:2069 include/linux/highmem.h:284) 
[ 207.598445][ T2704] ? handle_invalid_op (arch/x86/kernel/traps.c:212) 
[ 207.603265][ T2704] ? zero_user_segments (include/linux/mm.h:2069 include/linux/highmem.h:284) 
[ 207.609394][ T2704] ? exc_invalid_op (arch/x86/kernel/traps.c:265) 
[ 207.613953][ T2704] ? asm_exc_invalid_op (arch/x86/include/asm/idtentry.h:568) 
[ 207.618875][ T2704] ? zero_user_segments (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/mm.h:1063 include/linux/mm.h:1300 include/linux/highmem.h:275) 
[ 207.624919][ T2704] ? zero_user_segments (include/linux/mm.h:2069 include/linux/highmem.h:284) 
[ 207.631050][ T2704] ? folio_wait_writeback (arch/x86/include/asm/bitops.h:206 arch/x86/include/asm/bitops.h:238 include/asm-generic/bitops/instrumented-non-atomic.h:142 include/linux/page-flags.h:513 mm/page-writeback.c:3063) 
[ 207.636219][ T2704] truncate_inode_partial_folio (include/linux/page-flags.h:1113 include/linux/page-flags.h:1118 mm/truncate.c:238) 
[ 207.642001][ T2704] truncate_inode_pages_range (mm/truncate.c:379) 
[ 207.647609][ T2704] ? truncate_inode_partial_folio (mm/truncate.c:331) 
[ 207.653570][ T2704] ? _raw_spin_lock (arch/x86/include/asm/atomic.h:115 include/linux/atomic/atomic-arch-fallback.h:2164 include/linux/atomic/atomic-instrumented.h:1296 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154) 
[ 207.658139][ T2704] ? filemap_check_errors (arch/x86/include/asm/bitops.h:206 (discriminator 6) arch/x86/include/asm/bitops.h:238 (discriminator 6) include/asm-generic/bitops/instrumented-non-atomic.h:142 (discriminator 6) mm/filemap.c:350 (discriminator 6)) 
[ 207.663229][ T2704] cifs_file_copychunk_range (fs/smb/client/cifsfs.c:1312) cifs
[ 207.669432][ T2704] cifs_copy_file_range (fs/smb/client/cifsfs.c:1365) cifs
[ 207.675110][ T2704] vfs_copy_file_range (fs/read_write.c:1509) 
[ 207.680199][ T2704] ? generic_file_rw_checks (fs/read_write.c:1478) 
[ 207.685630][ T2704] ? kernel_write (fs/read_write.c:565) 
[ 207.690186][ T2704] ? preempt_notifier_dec (kernel/sched/core.c:10106) 
[ 207.695268][ T2704] ? smb3_llseek (fs/smb/client/smb2ops.c:3770) cifs
[ 207.700419][ T2704] __do_sys_copy_file_range (fs/read_write.c:1595) 
[ 207.705863][ T2704] ? vfs_copy_file_range (fs/read_write.c:1561) 
[ 207.711206][ T2704] ? ksys_write (fs/read_write.c:637) 
[ 207.715499][ T2704] ? __ia32_sys_read (fs/read_write.c:627) 
[ 207.720145][ T2704] ? fpregs_restore_userregs (arch/x86/include/asm/bitops.h:75 include/asm-generic/bitops/instrumented-atomic.h:42 include/linux/thread_info.h:94 arch/x86/kernel/fpu/context.h:79) 
[ 207.725576][ T2704] do_syscall_64 (arch/x86/entry/common.c:51 arch/x86/entry/common.c:82) 
[ 207.729885][ T2704] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129) 
[  207.735664][ T2704] RIP: 0033:0x7f21a9654f29
[ 207.739958][ T2704] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
All code
========
   0:	00 c3                	add    %al,%bl
   2:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   9:	00 00 00 
   c:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 8b 0d 37 8f 0d 00 	mov    0xd8f37(%rip),%rcx        # 0xd8f71
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W

Code starting with the faulting instruction
===========================================
   0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
   6:	73 01                	jae    0x9
   8:	c3                   	retq   
   9:	48 8b 0d 37 8f 0d 00 	mov    0xd8f37(%rip),%rcx        # 0xd8f47
  10:	f7 d8                	neg    %eax
  12:	64 89 01             	mov    %eax,%fs:(%rcx)
  15:	48                   	rex.W


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231129/202311292134.366c9c0b-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

