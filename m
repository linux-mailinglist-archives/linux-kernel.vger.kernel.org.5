Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B06812546
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443051AbjLNC2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNC2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:28:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD43E8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 18:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702520902; x=1734056902;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mKzFdrIWoX0BpH5k0/eMGKgcWpzsIiHp71We/53gSwI=;
  b=LEDVCwk1vI+1kqVUxZRau8wutGVahVxJs5ILXDZgRXSLgo38Do0cLA+b
   Yx+tYaYUtGoLhrDHiHJQatKpDvjtjV9+dhGkxdu/xJwOU4/yUwuZhttGR
   Z+RTKzBIXy1m+1Z8yhK5O65+mhR0Hf2UImJGT40FGylSqvFznTGpDjKY/
   wuMtiudRrUGRP0SCx0Vpae8oUa/o+5azmuBOyAkrURWz3bJxpwNFuaTnF
   jRK8OJFon3oN9YlrLgRIsyAiGBD62HKE53NyadJtcl1uv47Oa1CHpQbdA
   KFOYXyXtvjXJbhrq3MzeW04odBoKbz5K5IzDttSdwz3CkfS3pkgpy0yIc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398894830"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="398894830"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 18:28:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="892258651"
X-IronPort-AV: E=Sophos;i="6.04,274,1695711600"; 
   d="scan'208";a="892258651"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Dec 2023 18:28:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Dec 2023 18:28:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Dec 2023 18:28:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Dec 2023 18:28:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKy6FWvp+0NdzgUX4XoX44uUNKLA3EE3F73o/HkuR8CdQapL+Da6+PTPjVI/tdT4y2v49S+k69LmVLZWKDIedaZ73yQOzIMnV5KKrfUmA3+0KrZ0W4Ul2dy23plD4SzuzHjCqeZ4edxUdOVp14terPEsIUdldqbhK54X+tNJ1JS/VOEfhqe4FL5O263qeBWNs/3z6RDpkxreXF/TxRlhXBIdl0Olr32GVb7WZHCngWKbaX+nXdaz3H0khjW7lU27mskZspjIL3kB1qYsdChvBao/mW3yDhm4mkw87csyHotceQzgMGhKuHcEl8zNaRUmWPg1ZwIRt1Z7huoQDCSTnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sme5NqpjgYZs7ZsQ5glumINJ0kocG45DAFF5eLIGYKg=;
 b=mgjTJ7urDOd2gaSl4SxGRdnZG4pqbKnvA/PpMwIzmw/I3AS2xoqCPstnhk6lq5oeL1Du1u2xecm0B3nPzH+FbgDQ8kDSFuIOdhAT9dB53EExpA89n7Sm9+TPvyBEwkremSnV4sNovb+Ab6oOj3IL8LRZYXP6Tc4waCC1h0emJWEN2Urnu3pZDs1scq1R4zKhnCAOPiwdjs9Z8fLLYxPXTZeBsbRdzGTb6j4yYJ+jSPz2RmqG/XhF1j5KvqgX4xrXJh9NOIsi9F/GxVuHVkPJ0F0A3AkZjecluwmtMtEa5B5xN5GbJtOU0zA0ecVxAE4M2TZee6OcnMXRmnfhJQ13nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by MW4PR11MB7163.namprd11.prod.outlook.com (2603:10b6:303:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 02:28:18 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::25c4:9c11:c628:1283%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 02:28:18 +0000
Date:   Thu, 14 Dec 2023 10:22:34 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <heng.su@intel.com>,
        <pengfei.xu@intel.com>, <lkp@intel.com>
Subject: [Syzkaller & bisect] There is WARNING in perf_event_open in v6.7-rc5
 kernel
Message-ID: <ZXpm6gQ/d59jGsuW@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR01CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::15) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|MW4PR11MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a3c18d-63cb-437e-15c0-08dbfc4c5561
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WICqjirkH42YXW/eqJUAJnwlm50BKs8oNQGbiJeRhZEd3dsums1IIY4VUPjKnRQW2yDq0O0p5bjIpZf7UBs/bQh3tc8K7kBYAMIFOwu5/tB0RGluC+hlEuhBzT5kvfGDWaIoV1xwgH99uE8Qi1aFq5/WTo2yQCsINaga1ZDC+M6EIxqkZpUVS9TrvpyfSiVMps7fIEjue4pUeG6tQ89CriLOhvePar9IPfdxJQYv/4zLX6GbvRFJ4lpw3QATa2qyf4KAl4bM2pFpsZgBBmHMKroy9/FTBcyRoBv7QGyh8Npqt4vsUZ9bgGMJGLf1XnRSX9ZyIs8WULD8fSBpmPokvpspguZS8NbcghJBvuGNyeul1TJrR12JMm0mQd5XOfUCuhH4eA7LSJ029ntuFPcI4XgOrzB6LYIzkAPWPLUdmAyk5filaCcIyWadmbldVwmM/oqPiEPCwLys0Q8PX72tOzJSRBhsJbfJD+vQPQ6IMUDGPY3RE6ESliSU9rD2NwtjjvevDqNIsdt/4665p/FB00ERpOGkug75p1LA/EXhhkW94+MLWQUaays2/74NN736LbFBoKar8xvaRdmGVMqpJDriZplF7mfLSe9kM1kUjr3aryGpwjF0Zi0sDOQLXCedmaKBLKtc/A5XLU40CWiRAIR3wKsvYeDtyBujazNEPtcvWy9yuNKH/ydy82WkIP3l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(346002)(376002)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(38100700002)(5660300002)(45080400002)(44832011)(478600001)(6486002)(966005)(6512007)(6666004)(2906002)(82960400001)(6916009)(316002)(66476007)(66556008)(66946007)(8676002)(4326008)(8936002)(86362001)(107886003)(26005)(6506007)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rexhbwoh/rG/F/UhGvloZQjCcf1l5LXzwJtUmVPL5miXVLmJXxQbZTSftN9f?=
 =?us-ascii?Q?MtecO5l8zkRfP/lLJ9bF/RCxFwEPAk/0MC9oMGwn9OLVVCbbrjZPtOC4v15r?=
 =?us-ascii?Q?GE9KEf/sFnZR2rEtchT0FsCmuT5MNvo72O1OUGVU7cF+RbsPh76IuFNkpVCC?=
 =?us-ascii?Q?58Z4xFq1RJPsMIlAtLcG7Nh+N/8CeItqjkVgi1/z0US1fmIynVyI8OpchID9?=
 =?us-ascii?Q?XhME4gcS1oUq0OwYOGbParN5VgyNaBqrD20NdSCYZvcOQbOt0uVMlmOAA2oC?=
 =?us-ascii?Q?u8rHzBHLra8AsAM7/GQUxg9FRV/lVEz6udOkH+Jv5kQp3JoY0Z71TR4lNBtX?=
 =?us-ascii?Q?98I2A4FbBUXyaiacCsoEn6HSjwONKz16sdtFmF8/tqv5LH9kQYCFY1XCHs5Z?=
 =?us-ascii?Q?xSAcoGL7XjnaIWhIIw//+qqvPHau/9RaKf5Nk5pGxR+gywS5zfFI0ZD1V1y3?=
 =?us-ascii?Q?idVwXBgYmaGa1r1bcIVw5qkIqJFC0AuAqQE2B7uMUr0fFdcy9qXdxMij+AD4?=
 =?us-ascii?Q?mEahEeq81dWwPmTEVfFIQmSRwERMJKHdGsH9+GY57dYdJ3XPanIl3ZngylFV?=
 =?us-ascii?Q?AmcxA5kqa6moTpPbJu8AFDJWxpOIcAWooV8VPwU9Nj3ppgK1FiJEM7qKaBpO?=
 =?us-ascii?Q?ZZ+4LAdsuSF7/uY5rcwDQbAkYKaoDlQe0TRXEfQrGcM1cxM14xY1dXvvSOH3?=
 =?us-ascii?Q?dNE/9KoB2xzsity8qlGTpOmPvIobYlIE7s3QMIQD0+cHwa/xqz1DsswdDbs+?=
 =?us-ascii?Q?Yk6zKWGTx6Cj4Zp3AMYkECHGqvEsMCN/dMkNgvQLjklOdcV4arkZfExzzuiS?=
 =?us-ascii?Q?dD5gJjpBcgN6zgl8uOMz6E7byO1OcezGD8Nb6D1bM+vbHJBdrok3TzDoGS3n?=
 =?us-ascii?Q?GNVSpWhsePFeIeCSJiJzTIekdV1FPrxTnDS9+SrtIqPKpLckgD9SwQM/PS2t?=
 =?us-ascii?Q?7PXTGWNAV3C/V7d9ZcPO/YxViH+1PSsmk+WlYyHqWxpfWikzEutrckvaRBzJ?=
 =?us-ascii?Q?P1w14GXLcAcuaB0Fe9TKvEldTYK1FYlKsewwmx2EjIw1LgYtjXLzAO77Z1G5?=
 =?us-ascii?Q?jGyUna8Y12S4b8z2elRdvm4hh/YDb8lb0zAvo10+huC2FcBSCy3qJkAjD1cV?=
 =?us-ascii?Q?WLr6CSrXiFxgDwIZqK7Wx21eS1Dh/NM4JPWT5G4fTbl5nmwW9iWWqKws42G9?=
 =?us-ascii?Q?eZiwAqj3NHgSuR0o+RFFlGxzfCIA1/3fV5fDA5jYzmocEvlTXHEGv4xkmdqx?=
 =?us-ascii?Q?mcto2/ZFUb4IU2UNkKZiAzYF6ZDoLMkw5u83O1tCVs3NGPOa4joCt96oBPi0?=
 =?us-ascii?Q?w4tElHOx00pHtOkICa4B7qWL81Hlsa5FiL2Dl//uk0t8LAm0f2o2aS4i853K?=
 =?us-ascii?Q?AnGNcpF3ep9XOE6GmU/nnIUFss5V1FpdzhQbTRp07EBIyNel+4+vYS6foTbc?=
 =?us-ascii?Q?XMXwdg9f7ZqaGtjtuVDPqNtouz3lp8nUZM8QkMc1jKZN77ro4voiJ2EvQHgv?=
 =?us-ascii?Q?Q57Rxpzip0NlIhMMdLG2GgKqQY8fyC7SwBh+pR1kQBaQqMpan35GKZB5FqXs?=
 =?us-ascii?Q?PZl8FoZvHPMka1cuD0/KAgd4oVxF9txde0klXfWf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a3c18d-63cb-437e-15c0-08dbfc4c5561
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 02:28:18.6249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aB04fnTyMw2TMn7pjx7wzZezThI5rqAXtc1TLEtPVl1vzUy4fqC+8txKvixeApD20zwOmxfjdFGK3fUvDDmEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7163
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Greeting!

There is WARNING in perf_event_open in v6.7-rc5 kernel.

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/231212_034950_perf_event_open
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/231212_034950_perf_event_open/repro.c
Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/231212_034950_perf_event_open/repro.prog
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/231212_034950_perf_event_open/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/231212_034950_perf_event_open/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/231212_034950_perf_event_open/a39b6ac3781d46ba18193c9dbb2110f31e9bffe9_dmesg.log
bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/231212_034950_perf_event_open/bzImage_a39b6ac3781d46ba18193c9dbb2110f31e9bffe9.tar.gz


Bisected and found related commit:
"
382c27f4ed28 perf: Fix perf_event_validate_size()
"
Revert on top of v6.7-rc5, this issue was gone.

 [   23.133852] ------------[ cut here ]------------
 [   23.134146] WARNING: CPU: 1 PID: 727 at kernel/events/core.c:1950 __do_sys_perf_event_open+0x2ba3/0x2c50
 [   23.134752] Modules linked in:
 [   23.134924] CPU: 1 PID: 727 Comm: repro Not tainted 6.7.0-rc5-a39b6ac3781d+ #1
 [   23.135292] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
 [   23.135882] RIP: 0010:__do_sys_perf_event_open+0x2ba3/0x2c50
 [   23.136212] Code: 48 8d b8 a8 00 00 00 e8 5b 99 bb 03 bf 01 00 00 00 41 89 c5 89 c6 e8 fc d9 c9 ff 41 83 ed 01 0f 84 81 ec ff ff e8 fd d7 c9 ff <0f> 0b e9 75 ec ff ff e8 f1 16 29 00 e9 d1 ec ff ff e8 77 17 29 00
 [   23.137194] RSP: 0018:ffff88800cb27d88 EFLAGS: 00010293
 [   23.137465] RAX: ffff888010ea8000 RBX: ffff88800d44bd40 RCX: ffffffff8196ccf4
 [   23.137832] RDX: 0000000000000000 RSI: ffffffff8196cd03 RDI: 0000000000000005
 [   23.138229] RBP: ffff88800cb27ef8 R08: ffff888010ea8000 R09: fffffbfff11c7a2a
 [   23.138724] R10: 0000000000000001 R11: ffffffff88e3d14f R12: ffff88800d44bd40
 [   23.139126] R13: 00000000ffffffff R14: 0000000000000000 R15: 1ffff11001964fbe
 [   23.139492] FS:  00007fef8c620600(0000) GS:ffff88806cd00000(0000) knlGS:0000000000000000
 [   23.139901] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 [   23.140223] CR2: 00000000200000c0 CR3: 000000000d90a000 CR4: 0000000000750ef0
 [   23.140619] PKRU: 55555554
 [   23.140778] Call Trace:
 [   23.140920]  <TASK>
 [   23.141049]  ? show_regs+0xa2/0xb0
 [   23.141236]  ? __warn+0xef/0x340
 [   23.141412]  ? report_bug+0x2f6/0x570
 [   23.141616]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
 [   23.141881]  ? report_bug+0x360/0x570
 [   23.142083]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
 [   23.142385]  ? handle_bug+0xa4/0x130
 [   23.142668]  ? exc_invalid_op+0x3a/0x90
 [   23.142956]  ? asm_exc_invalid_op+0x1f/0x30
 [   23.143241]  ? __do_sys_perf_event_open+0x2b94/0x2c50
 [   23.143506]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
 [   23.143788]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
 [   23.144089]  ? __do_sys_perf_event_open+0x2ba3/0x2c50
 [   23.144397]  ? __pfx___do_sys_perf_event_open+0x10/0x10
 [   23.144697]  ? trace_hardirqs_on+0x26/0x120
 [   23.144951]  __x64_sys_perf_event_open+0xc7/0x160
 [   23.145202]  ? syscall_enter_from_user_mode+0x51/0x60
 [   23.145476]  do_syscall_64+0x42/0xf0
 [   23.145670]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 [   23.145940] RIP: 0033:0x7fef8c43ee5d
 [   23.146145] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
 [   23.147095] RSP: 002b:00007ffe0ede25a8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
 [   23.147633] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fef8c43ee5d
 [   23.148052] RDX: 0000000000000000 RSI: 00000000ffffffff RDI: 00000000200000c0
 [   23.148451] RBP: 00007ffe0ede25b0 R08: 0000000000000000 R09: 00007ffe0ede25e0
 [   23.148860] R10: 00000000ffffffff R11: 0000000000000246 R12: 00007ffe0ede2708
 [   23.149263] R13: 0000000000401b49 R14: 0000000000403e08 R15: 00007fef8c661000
 [   23.149654]  </TASK>
 [   23.149775] irq event stamp: 1131
 [   23.149961] hardirqs last  enabled at (1139): [<ffffffff81420a0d>] console_unlock+0x22d/0x240
 [   23.150428] hardirqs last disabled at (1148): [<ffffffff814209f2>] console_unlock+0x212/0x240
 [   23.151012] softirqs last  enabled at (944): [<ffffffff8556dd60>] __do_softirq+0x4f0/0x791
 [   23.151445] softirqs last disabled at (935): [<ffffffff81266fb1>] irq_exit_rcu+0xc1/0x110
 [   23.151884] ---[ end trace 0000000000000000 ]---


I hope it's helpful.


---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!
