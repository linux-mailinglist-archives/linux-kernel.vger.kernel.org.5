Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5967EEDE8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 09:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjKQIyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 03:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjKQIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 03:54:17 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8F8D52
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 00:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700211253; x=1731747253;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b/6ih71+7ILinrmOQv8aFjbDL8sSXQKRlMfYUzZuTmM=;
  b=WiYuJKZM6D9wJePyX4vls3fmnIQqERNm/NSt0cmZMU+m65FYUvNN8EZ3
   S9Qm3mcp2qdLTJ5EWCf05swOjmlAAqdw94K8dS90JGcY75ASI9H2Pslii
   vlzZ+v1dC1IsBqn9YDVAfzud77gmb4MTVNZs/ruSvQWa/n4lTKh5+JcA5
   u8FqwGK5jZRhUTOIqayznN7EoT5wTSrco761RQEn9qpKfgkyL0mtN/SHM
   QF8/HlS6oEa6fKcqU0+WHntRDFOQ++5cE3PzWJdOyjq3mJwrLCAnqe0sw
   2VuS2D8oDiEnulN8a9LfrgA/Curapae8eyrPgayOAJG7y0K3eqXEDd1uR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="4402936"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="4402936"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 00:54:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="6783558"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 00:54:12 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 00:54:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 00:54:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 00:54:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1OGmhIDqi9J/SLmUwYD+mzEMT8SDETYKaUjCY5dSVubqvJWGMUqF6qP609LIHJxGaj4ycy/wd6DJxcypbyESwl9laYMTFkKHrlNbz3W9o9oEZY0USGOBoQKPLL60W551y5bPkdw+R4Rnp1Lg4WpMXQbvotGHDcdVpF5I5yR06dKq+cSE7CbaF63jwTbvhCCwGDjdjima57NqfhmUpgMWvX4NBRY/FIInHa4yILmuCrsYhA1EbP6NeKKDCVuww7fQj2PQKTq1jBOsNymYQ345GEJCS5nyv3vaBYoebMJkwzYwHTM4RR1Hb/HhAxELAFnHlvgQXxjKdbgr2GUD1JWJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XexTZY9YKPMjllZRZdaViZXXuq4WSxvU1AZAJ7eLgAs=;
 b=JBqDZ4Tm+oXOijD5MraeU/PF5gPfQrp5L6GBiLQ5R81YQwUYvBqvMMkldfusyLfPUWhmf3qNRvvUBZo7cKN+QxZjSnh8ENILE8NmCsFRUrJvN2CGPDf20XR7RSzAay1wLNSdhW765utwYRO0VVj3q8Hb7HXN/DU5JghZh87i2n0z7C0OAZcrsFszOsr0lEox/BvpwhNLjGNeHLoWVbYZRRQbmtBNRA6Zaz/gN9DzBucfSOMCLxyEp37uT3NEzcQfNArbT4bGyELlItLo6wk9r78FNtymGZGZrS9vF6iXybxYDXldyXr6Dh6c/dQ4o7nCe/do1VPSj9YVuFepA9yVGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6779.namprd11.prod.outlook.com (2603:10b6:510:1ca::17)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Fri, 17 Nov
 2023 08:54:04 +0000
Received: from PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7]) by PH8PR11MB6779.namprd11.prod.outlook.com
 ([fe80::b8:30e8:1502:b2a7%4]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 08:54:03 +0000
Date:   Fri, 17 Nov 2023 16:53:57 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>,
        <linux-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [rt-devel:linux-6.6.y-rt-rebase] [panic]  768c33033e:
 BUG:workqueue_lockup-pool
Message-ID: <202311171611.78d41dbe-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To PH8PR11MB6779.namprd11.prod.outlook.com
 (2603:10b6:510:1ca::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6779:EE_|MW5PR11MB5762:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b6eb3c5-29eb-4d73-9d0b-08dbe74abfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQPg07d8OrfUR/Qh7BMTUcsUHmqg1Q0OE1BbspKkisnjqXOVkkx/z+QemWbo+wteapEAo2t+bL8EWcv+Z99j5ZRqUwM/XmvOql2Na6bZcbro466yv8vC7Qk8bGhqjjzalxcCYbugfrYQS1RKdQRyaB9If/e9UP2lbsgNoq/AFOCAOakMGLjFYh4s9sRrf1Ok07Bcm4KrBs6584R1ZM68Otzfe3Kwg9YimhK2oTw+V58w1n6wl/ONN+5zjrYVq4zXV7Ayui4sVsLcE8cXGCJhSYMXogKjtKqV/i9fgWyXhEAsCJJvyp0DEZv7KUaELf9pXoQ/JftI6Grweb4xksoudXpKbO72iUknSlG05RvHNRGOV22M4mG52C+0e62SFJKkY8Lu7Raw25kiTxoSkyhYYFKXOMuyxwqslnDI29tmGu+6mmIwQIKGrSIC5ab7LlWOKJAtosuMo9gRzqmMabv4yaCSBzgyOSRk1L8mR+b/qtaAp6M9F8Mk+51LZbgWwFAmbxlR2Z/AkopHjAWJyrdYPjQ01KBxDhYBLOv/Y2ZgHDgRPsKQsgEDgiUYyMecfpd4MI99242ZTdgVTGjDpqahKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6779.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(366004)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(6486002)(966005)(478600001)(2906002)(6506007)(2616005)(6512007)(6666004)(5660300002)(86362001)(6916009)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38100700002)(30864003)(83380400001)(41300700001)(26005)(1076003)(82960400001)(107886003)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a48qAyEcMkpoWYYztUubXQnyLfHKi3TzsPsfTec225WSq2tdjcu5AE5DTNuH?=
 =?us-ascii?Q?ek2RHf63ZPtSds+d6aeXjzQHKvXQT2HROuOATGG0WvRUfdfaFWFuEXSxTiaL?=
 =?us-ascii?Q?jMRW6WpqGzmhRPr02ggfCXq59RRR40jzK5iewOBxMh0tGv2+nW2e02YK3MNW?=
 =?us-ascii?Q?uNRNIsYLZGz/6KVuyeQ2WC+J17IGEM6jyVXCaIbTLcg++pPOhRZ6QhXeZg7y?=
 =?us-ascii?Q?AY5OAKrgWQARfECleFoKnwepR6Mg65Cmn9pcdzhWAGrN3BDtXuR/1hO8oyXD?=
 =?us-ascii?Q?+F0DZZN5RAPBED2CLKMofVndHxdbpfQLQCSsMiDS9GuLf84ZmrBhNGsPjRsH?=
 =?us-ascii?Q?Vd40eoIhAnSWsrBz/Oddo5Lp4OttvJYSTcTiIJCAJABHz8YDVdE2gb/4Crxn?=
 =?us-ascii?Q?XjAOgFXc7Jg2MSnBA74M3JL5FQ55uLhyh2JAMFeOSbuLUsD3tM/4KDgyGMUC?=
 =?us-ascii?Q?ZnpEybzW1xjNP8ULBzkmr6y9VdhSkrn/7zujVUv59C/dVqOoHfvQ/d+VxGKv?=
 =?us-ascii?Q?3ofw6MraKbRDTvOD1GpmuPkM3E9qlqHjQKosq0prkTqid8ggYKgJXj59CVkE?=
 =?us-ascii?Q?IaH3Z+lRE/K8pDpcrCCxbeLoHhwZjAtGDMX8cJkRmT8tXxQLF5tIoSutsBEu?=
 =?us-ascii?Q?+hK3H1NpAy4V9tq3xRi3VOwTlULdyFU5f2AVkb4A136yxsIO1QongQECmpsj?=
 =?us-ascii?Q?VjUyXXwMUiIXlZKK6KWMwKtX+oXwT/Dh00qQ6tsVwNXGU5fgPMAw0NS5uwQQ?=
 =?us-ascii?Q?SUGMgwY4IciCz7OgCU5pT/Q7nn1MIhxLQ3VR/jFjN4LpA2hp9lp+9hy3ihqv?=
 =?us-ascii?Q?QMKtY/R8tMAv8lyo/uVs8HNlohlAykdB3/8TwniM4R6L9zGrIuqBw7cYRIGB?=
 =?us-ascii?Q?qH1kSt2nnNrg8igsByVqNUTdJN8UyMucbJTFLxyhoJNwKMQyTR9QQ1ySIRCT?=
 =?us-ascii?Q?BhyA1erFvo1aj2rZ2sUj+Y6ZEsGa8Urcm7lTaH27kxXBQmeiPR1XOQh3RpF9?=
 =?us-ascii?Q?aL5MfUSIiithJ9BQdtouCCABh3TL2bym6AlWozPIkHR6xmfjvhqYqkssvfhY?=
 =?us-ascii?Q?cdhrR/DZ1XhyCBBhsXuBBQFr5NI9CkaZTJZ4XnIJqmfbRGIaK61iib1RjTEv?=
 =?us-ascii?Q?356ad+o6Kayl7xS4BL7oLPJpkSD0DkRUccBSuE1t7nuU6JvEs3EMK6VUuQTV?=
 =?us-ascii?Q?YsH6+3ccTJTtFBjX4SprCVSaIt1tdi6A44n7clIyoMYWGvKQebPPKBJsK0kq?=
 =?us-ascii?Q?IW8MGmWvkBInbe1vd/UizhnGH0xAxYMtTZvXl67VzX0LpQkGwDWQHzmayE2p?=
 =?us-ascii?Q?rLx7b+ATJz04dpFCKCCU3QFgecm6aGBKp/8DB+DLobTzBfRWVkj6rJf3CBGP?=
 =?us-ascii?Q?NKW/ltRDIqVY2i7USnbuLAcORDuvMksMrApcgxvOgPxMrsZwRbkMrfLx+/4p?=
 =?us-ascii?Q?UYNIbkExXrh8vMYPsa6pnTWs4bDiO3nzBQw5+dzfcn/l4dv0P4NVcYHgOXKs?=
 =?us-ascii?Q?TB1LrKZeyNvNN5GTj0aODlUFk9OuZod9ZVfNorZJtdJx0hZyqtWexosIV32d?=
 =?us-ascii?Q?meFhW6l1EN3ULKERuztlAF4a7CK2hiFTrSwXEeldYb9H8C5YFamAAWQEOlDa?=
 =?us-ascii?Q?Jg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6eb3c5-29eb-4d73-9d0b-08dbe74abfd6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6779.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 08:54:03.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RvMSpyR5OWAAslWt1BsK1N293ADb+tVreGc/IB1tv0DaEeTD5LX+gpfW5Qh8ku1V4Pz73wu5HivdsNBjGFwu4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

kernel test robot noticed "BUG:workqueue_lockup-pool" on:

commit: 768c33033e41ad195a9304ebb183afb730d5ae98 ("panic: Mark emergency section in warn")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-6.6.y-rt-rebase

in testcase: boot

compiler: gcc-12
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+----------------------------------------------------------------------------------+------------+------------+
|                                                                                  | fd2ace830c | 768c33033e |
+----------------------------------------------------------------------------------+------------+------------+
| BUG:workqueue_lockup-pool                                                        | 0          | 12         |
| INFO:rcu_sched_self-detected_stall_on_CPU                                        | 0          | 12         |
| EIP:desc_read                                                                    | 0          | 12         |
+----------------------------------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202311171611.78d41dbe-oliver.sang@intel.com


[   64.476562][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 39s!
[   64.495685][    C0] Showing busy workqueues and worker pools:
[   64.496091][    C0] workqueue events: flags=0x0
[   64.496427][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   64.496432][    C0]     pending: deferred_probe_timeout_work_func
[   64.496442][    C0] workqueue events_power_efficient: flags=0x82
[   64.497853][    C0]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/256 refcnt=2
[   64.497856][    C0]     pending: do_cache_clean
[   64.497862][    C0] workqueue mm_percpu_wq: flags=0x8
[   64.499031][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   64.499034][    C0]     pending: vmstat_update
[   64.499044][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[   95.196556][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 70s!
[   95.197232][    C0] Showing busy workqueues and worker pools:
[   95.197640][    C0] workqueue events: flags=0x0
[   95.197963][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   95.197969][    C0]     pending: deferred_probe_timeout_work_func
[   95.197976][    C0] workqueue events_power_efficient: flags=0x82
[   95.199381][    C0]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/256 refcnt=2
[   95.199384][    C0]     pending: do_cache_clean
[   95.199390][    C0] workqueue mm_percpu_wq: flags=0x8
[   95.200580][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[   95.200583][    C0]     pending: vmstat_update
[   95.200593][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  125.916557][    C0] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 101s!
[  125.917235][    C0] Showing busy workqueues and worker pools:
[  125.917650][    C0] workqueue events: flags=0x0
[  125.917979][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  125.917984][    C0]     pending: deferred_probe_timeout_work_func
[  125.917992][    C0] workqueue events_power_efficient: flags=0x82
[  125.919409][    C0]   pwq 4: cpus=0-1 flags=0x4 nice=0 active=1/256 refcnt=2
[  125.919412][    C0]     pending: do_cache_clean
[  125.919419][    C0] workqueue mm_percpu_wq: flags=0x8
[  125.920619][    C0]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
[  125.920622][    C0]     pending: vmstat_update
[  125.920632][    C0] Showing backtraces of running workers in stalled CPU-bound worker pools:
[  129.568547][    C1] rcu: INFO: rcu_sched self-detected stall on CPU
[  129.568553][    C1] rcu: 	1-....: (26250 ticks this GP) idle=3c24/1/0x40000000 softirq=5858/5934 fqs=13122
[  129.568558][    C1] rcu: 	(t=26251 jiffies g=301 q=598 ncpus=2)
[  129.568562][    C1] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W        N 6.6.0-00134-g768c33033e41 #1
[ 129.568565][ C1] EIP: desc_read (kernel/printk/printk_ringbuffer.c:439) 
[ 129.568573][ C1] Code: fb 83 c4 08 5b 5e 5f 5d c3 8d 74 26 00 0f 0b eb d2 3e 8d 74 26 00 55 89 e5 57 89 cf 56 53 89 c3 83 ec 08 8b 08 b8 ff ff ff ff <89> 55 f0 d3 e0 f7 d0 21 d0 6b f0 58 83 f9 1f 0f 87 a7 e6 83 00 03
All code
========
   0:	fb                   	sti
   1:	83 c4 08             	add    $0x8,%esp
   4:	5b                   	pop    %rbx
   5:	5e                   	pop    %rsi
   6:	5f                   	pop    %rdi
   7:	5d                   	pop    %rbp
   8:	c3                   	ret
   9:	8d 74 26 00          	lea    0x0(%rsi,%riz,1),%esi
   d:	0f 0b                	ud2
   f:	eb d2                	jmp    0xffffffffffffffe3
  11:	3e 8d 74 26 00       	ds lea 0x0(%rsi,%riz,1),%esi
  16:	55                   	push   %rbp
  17:	89 e5                	mov    %esp,%ebp
  19:	57                   	push   %rdi
  1a:	89 cf                	mov    %ecx,%edi
  1c:	56                   	push   %rsi
  1d:	53                   	push   %rbx
  1e:	89 c3                	mov    %eax,%ebx
  20:	83 ec 08             	sub    $0x8,%esp
  23:	8b 08                	mov    (%rax),%ecx
  25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  2a:*	89 55 f0             	mov    %edx,-0x10(%rbp)		<-- trapping instruction
  2d:	d3 e0                	shl    %cl,%eax
  2f:	f7 d0                	not    %eax
  31:	21 d0                	and    %edx,%eax
  33:	6b f0 58             	imul   $0x58,%eax,%esi
  36:	83 f9 1f             	cmp    $0x1f,%ecx
  39:	0f 87 a7 e6 83 00    	ja     0x83e6e6
  3f:	03                   	.byte 0x3

Code starting with the faulting instruction
===========================================
   0:	89 55 f0             	mov    %edx,-0x10(%rbp)
   3:	d3 e0                	shl    %cl,%eax
   5:	f7 d0                	not    %eax
   7:	21 d0                	and    %edx,%eax
   9:	6b f0 58             	imul   $0x58,%eax,%esi
   c:	83 f9 1f             	cmp    $0x1f,%ecx
   f:	0f 87 a7 e6 83 00    	ja     0x83e6bc
  15:	03                   	.byte 0x3
[  129.568575][    C1] EAX: ffffffff EBX: c1d5cd60 ECX: 0000000f EDX: 3fff8001
[  129.568576][    C1] ESI: 00000001 EDI: c320fd78 EBP: c320fd28 ESP: c320fd14
[  129.568578][    C1] DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068 EFLAGS: 00000286
[  129.568582][    C1] CR0: 80050033 CR2: b7d77b93 CR3: 022b4000 CR4: 00040690
[  129.568583][    C1] DR0: 00000000 DR1: 00000000 DR2: 00000000 DR3: 00000000
[  129.568584][    C1] DR6: fffe0ff0 DR7: 00000400
[  129.568585][    C1] Call Trace:
[ 129.568589][ C1] ? show_regs (arch/x86/kernel/dumpstack.c:479) 
[ 129.568596][ C1] ? dump_cpu_task (kernel/sched/core.c:11572) 
[ 129.568602][ C1] ? rcu_dump_cpu_stacks (include/linux/cpumask.h:143 include/linux/cpumask.h:150 include/linux/cpumask.h:212 kernel/rcu/tree_stall.h:367) 
[ 129.568606][ C1] ? vprintk (kernel/printk/printk_safe.c:46) 
[ 129.568611][ C1] ? print_cpu_stall (kernel/rcu/tree_stall.h:692) 
[ 129.568616][ C1] ? check_cpu_stall (kernel/rcu/tree_stall.h:775) 
[ 129.568620][ C1] ? rcu_sched_clock_irq (kernel/rcu/tree.c:3869 kernel/rcu/tree.c:2240) 
[ 129.568623][ C1] ? update_process_times (arch/x86/include/asm/preempt.h:27 kernel/time/timer.c:2080) 
[ 129.568628][ C1] ? tick_sched_timer (kernel/time/tick-sched.c:1497) 
[ 129.568632][ C1] ? __hrtimer_run_queues (kernel/time/hrtimer.c:1688 kernel/time/hrtimer.c:1752) 
[ 129.568636][ C1] ? cpumask_weight (arch/x86/kernel/alternative.c:1766) 
[ 129.568640][ C1] ? hrtimer_interrupt (kernel/time/hrtimer.c:1817) 
[ 129.568645][ C1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1074) 
[ 129.568650][ C1] ? __sysvec_apic_timer_interrupt (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:444 include/linux/jump_label.h:260 include/linux/jump_label.h:270 arch/x86/include/asm/trace/irq_vectors.h:41 arch/x86/kernel/apic/apic.c:1081) 
[ 129.568653][ C1] ? sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1074) 
[ 129.568656][ C1] ? handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 129.568662][ C1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1074) 
[ 129.568664][ C1] ? desc_read (kernel/printk/printk_ringbuffer.c:439) 
[ 129.568668][ C1] ? sysvec_call_function_single (arch/x86/kernel/apic/apic.c:1074) 
[ 129.568670][ C1] ? desc_read (kernel/printk/printk_ringbuffer.c:439) 
[ 129.568675][ C1] desc_read_finalized_seq (kernel/printk/printk_ringbuffer.c:1907) 
[ 129.568680][ C1] prb_next_reserve_seq (kernel/printk/printk_ringbuffer.c:2084) 
[ 129.568682][ C1] ? nbcon_get_cpu_emergency_nesting (kernel/printk/nbcon.c:984) 
[ 129.568689][ C1] nbcon_atomic_flush_all (kernel/printk/nbcon.c:1133) 
[ 129.568692][ C1] ? nbcon_atomic_flush_all (kernel/printk/nbcon.c:1133) 
[ 129.568695][ C1] printk_trigger_flush (arch/x86/include/asm/preempt.h:85 kernel/printk/printk.c:3993) 
[ 129.568698][ C1] nbcon_cpu_emergency_exit (kernel/printk/nbcon.c:1193) 
[ 129.568701][ C1] ? refcount_warn_saturate (lib/refcount.c:28 (discriminator 3)) 
[ 129.568706][ C1] __warn (kernel/panic.c:692) 
[ 129.568711][ C1] ? refcount_warn_saturate (lib/refcount.c:28 (discriminator 3)) 
[ 129.568714][ C1] report_bug (lib/bug.c:201 lib/bug.c:219) 
[ 129.568720][ C1] ? exc_overflow (arch/x86/kernel/traps.c:250) 
[ 129.568722][ C1] handle_bug (arch/x86/kernel/traps.c:216) 
[ 129.568724][ C1] exc_invalid_op (arch/x86/kernel/traps.c:258 (discriminator 1)) 
[ 129.568727][ C1] handle_exception (arch/x86/entry/entry_32.S:1049) 
[ 129.568729][ C1] EIP: refcount_warn_saturate (lib/refcount.c:28 (discriminator 3)) 
[ 129.568731][ C1] Code: 79 18 c2 01 68 a8 b9 c3 c1 e8 03 7b cf ff 0f 0b 58 c9 c3 8d b6 00 00 00 00 c6 05 86 79 18 c2 01 68 50 b9 c3 c1 e8 e7 7a cf ff <0f> 0b 59 c9 c3 66 90 89 c2 8b 00 3d 00 00 00 c0 74 12 83 f8 01 74
All code
========
   0:	79 18                	jns    0x1a
   2:	c2 01 68             	ret    $0x6801
   5:	a8 b9                	test   $0xb9,%al
   7:	c3                   	ret
   8:	c1 e8 03             	shr    $0x3,%eax
   b:	7b cf                	jnp    0xffffffffffffffdc
   d:	ff 0f                	decl   (%rdi)
   f:	0b 58 c9             	or     -0x37(%rax),%ebx
  12:	c3                   	ret
  13:	8d b6 00 00 00 00    	lea    0x0(%rsi),%esi
  19:	c6 05 86 79 18 c2 01 	movb   $0x1,-0x3de7867a(%rip)        # 0xffffffffc21879a6
  20:	68 50 b9 c3 c1       	push   $0xffffffffc1c3b950
  25:	e8 e7 7a cf ff       	call   0xffffffffffcf7b11
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	59                   	pop    %rcx
  2d:	c9                   	leave
  2e:	c3                   	ret
  2f:	66 90                	xchg   %ax,%ax
  31:	89 c2                	mov    %eax,%edx
  33:	8b 00                	mov    (%rax),%eax
  35:	3d 00 00 00 c0       	cmp    $0xc0000000,%eax
  3a:	74 12                	je     0x4e
  3c:	83 f8 01             	cmp    $0x1,%eax
  3f:	74                   	.byte 0x74

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	59                   	pop    %rcx
   3:	c9                   	leave
   4:	c3                   	ret
   5:	66 90                	xchg   %ax,%ax
   7:	89 c2                	mov    %eax,%edx
   9:	8b 00                	mov    (%rax),%eax
   b:	3d 00 00 00 c0       	cmp    $0xc0000000,%eax
  10:	74 12                	je     0x24
  12:	83 f8 01             	cmp    $0x1,%eax
  15:	74                   	.byte 0x74


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20231117/202311171611.78d41dbe-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

