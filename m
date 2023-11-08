Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61ED7E4ECD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjKHCJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:09:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjKHCJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:09:10 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FA610F4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699409348; x=1730945348;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Pfy0I3g+W3yv746xYQJWCG94JQ6/J0qUeblesX57LY4=;
  b=XPO/9U4xwcb+7AcyJd/kQsYqkYgFInWeDEdaXgOJs8yZlFWBoTo9OnQN
   THEoI46rOrdp0QvwJvDUm5Dbev395Gp1XHIWG0g4+8ql5ierEbe3uHOoT
   MqBGnVJulgh+gLigwGAHIyzfkVQXgD8OzSQg9R5acrG0KJhLhgzasMr+5
   OXXthXKIPLpRj8WnRVXRhg2OECIDOfhWyuiS+rLmgkk1fUPsLRs4DPS4F
   6px9mHpgLcLhQvloR7KbBLuyHjtTkap5A6EMbHEwCfVgDAgxLSbKmPXhC
   wlNYsDlsfDzoEGge8nLyBHD+a8FEujcLoNDZZK9Cr63C2WjTRe83qUPJ8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="2605496"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="2605496"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 18:09:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="880039324"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="880039324"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 18:09:08 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 18:09:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 18:09:07 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 18:09:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfkdKxkBZceWdPyQH760ptWMZlqiT1olcFEeeY+yeNyhY+p16V+C92eAzVBBXYQRnAi8mU5Ouaq6DkmhCOu8XYSOl0rCzU0AaT2LZFAAY6mjxOrGgxIjgjxpFgawaQQx2FYt2XYzJ1fp9RFiOS2VmnXwBQI1DVqePC2A6F1EHkkrYz7cS8LDtcDOGWHhAauxwJQw3r99BxQmrqcxkzLCkvm2S/SJMVihxHmaKSEzmM8mWknDeqNzgEQt8CNVGvePZ0xhluR513wzN1Z6zXkUvjaDljjLR+N6U3k+g1KoIBhY0sx/fDPM/O1M6Mt3K7LJZXGWuWSq5/zHIy3eK/PdgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUX6zdk3mFH6MJyRe3s4T81bU6tVgDaLR16oHPHxneE=;
 b=cShrkJNIVatI6fFAFfa2GvH9dnyrNUr+Vh0JwYSupgy/l9J0mmBbW8ouEQcYLghySU74n6A9ac2WVKKMda+/hxKUC2V+L7/jiC/PE7Ofkt+hMQvvhTkHmrF1gTtClBJZo1hjlxBmAyqXlS7zbqeA3PpylGBugOe6/uJxlKZR/ZdRHsOsmS6lv6/bOgksvYmuRNTE30uhgIejUTMdbdLnbQ/OgqzKMzZVwienRdcW2Jg/bXHlL4rCTsKTMvS1UrXu4GLEVVPgV6Q/oGutwtcZ49km26x+dJkKqbbdI7BGQH/dmXk7KzoEqDF1BXouG3ziMFlitR0pYKPbifOsQR3+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by PH7PR11MB6956.namprd11.prod.outlook.com (2603:10b6:510:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 02:09:04 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::1fb2:76a1:8655:4707]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::1fb2:76a1:8655:4707%7]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 02:09:04 +0000
Date:   Wed, 8 Nov 2023 10:03:00 +0800
From:   Pengfei Xu <pengfei.xu@intel.com>
To:     syzbot <syzbot+6b8ea5bb987ec6fe0fd1@syzkaller.appspotmail.com>,
        <peterz@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <luto@kernel.org>,
        <peterz@infradead.org>, <syzkaller-bugs@googlegroups.com>,
        <tglx@linutronix.de>, <pengfei.xu@intel.com>, <heng.su@intel.com>,
        <lkp@intel.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in try_to_wake_up (3)
Message-ID: <ZUrsVCSluTn/Cf6N@xpf.sh.intel.com>
References: <0000000000008db61e0607333294@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0000000000008db61e0607333294@google.com>
X-ClientProxiedBy: SI1PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::11) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|PH7PR11MB6956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc81749-bb65-44d3-b63d-08dbdfffae9d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hRq/W9+XXY6/pKWf3lDIiYa/dO/iGhoTWt46mUa3D0WXsbVjWWrQsHfqFOvxLUKiveDglgPHR+75/NZdt7gS3IcAu5u3WbGmc0v1pwpuMGfRCzhpQDeZcx/5egq/t7t0ZSlAtJTbBn05vROewnmBpDNO1SNyIiVBWRZQ95S7xAuKnRMrgkQnRCOQ8OKlPvEhc49bv/qeqtr9/eiPnMrNxx9sNQJ/WmIqSZREy9CpiH+/3t5+h1l0yWy40OsdV+jwkJeF7oR6qlDn/ZqcMdHlvPZnpdo+BWiOaf4ZT2iNhDzmK0R+93uNYEnzET1RU2XRLeHbPtqxXyEYEBAfgs0FLHtfDEHth1oTI8brtis/RNkFBqskhSpQTWlbxWUVYK2jVpgkhxH89QNMep8I3E4q9UKU0UGR5vjE//MmyqygAQiuI1BgB6nn2Ii01P5DcKsDCIfy9TgMGWZg62Di5SBXrrLobho0xkWwWu07UMwDGOSOsP2wVET/162OWROUIeBBbz1U56wT87aJ9djPG3YQDIr76A1xz8Yl5lowS+LVrhX76/R+yIYklzXURp/kH/9RdCwRRMjhLLgHBRyz38fxrNNDYwgm3kHOYFpa0uz7TZQQ6XNHULN165cjjbdyjPJfP6VnfW/fiWckJRGGHienn+FS7kJ9BU6BxaTYA9E6hliQ+jCOeQpiQV6dkvtRg7HlCs2Rtj72AfDeZk+dfrVcLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(6512007)(66476007)(316002)(66946007)(478600001)(66556008)(44832011)(966005)(6486002)(4326008)(41300700001)(53546011)(8936002)(6666004)(6506007)(8676002)(5660300002)(107886003)(30864003)(2906002)(83380400001)(26005)(82960400001)(38100700002)(86362001)(21314003)(99710200001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZKHCU4GtY9z0TY7dNEJCCVBRwD5Js0Vy2HvSE5rHLwASRxDgd2qK4oTdqqO?=
 =?us-ascii?Q?cEWY4CoZ45s31/GfqLyKVWnKDyeXwiVwCD5yzb4UoUtPhsBwc6CXj6wcdUaq?=
 =?us-ascii?Q?UMCGQyCvJFedbWQIVOaA2PpXMA9bBzMmFb5H+neRhfXmVzXyvs00SIqvjlME?=
 =?us-ascii?Q?1XQbUoZYV8Umzq5Vl2rudfacUdSquARBjXj+cnTeZEBtVZaB7vORv9wptZAq?=
 =?us-ascii?Q?IJQ5qim8qUNyvXO2egkVRl4r711DCi2IF60q5EO+WsFFIUJm3RmcCz9tmD0o?=
 =?us-ascii?Q?TBxSmdYc80Hrs8F4ImjugN4IzznuGtg/xmMhwE7oyjEoGeXuxElzdag/SHLZ?=
 =?us-ascii?Q?gQWkx6D3TaePgO9ItmbLPpbMi63DfP1+Xsz6khDIJuI4V/G6p4cW68YQ6Tev?=
 =?us-ascii?Q?Wk5imZMMY4hlYQuW863+vFhLx/XFhY49G1FuEQx6UEs3fh5DEK2rnbxdrH1u?=
 =?us-ascii?Q?EsyfH3/tn9s3uUvCB/kQ/W9ngC8mjzpeTAFse+U6t8uPXzpK7yRN5DCzPeam?=
 =?us-ascii?Q?5M0KZtsc/n1S6YJvLMbjd3zsdqDs/6YxYcX1kIJbxqDUwc+ePFvCdIVAjHqy?=
 =?us-ascii?Q?wQMWv9SPJyFJlkv18JQGKYNLPg71TKQCui1f3vJKTlAG2/dtga/98ULGmcep?=
 =?us-ascii?Q?JG7/kGGHg2Y2URgfrBq8MUlW2OhEf4Wm8A2fTOCqWQ9620dHDrE1EDakpxRy?=
 =?us-ascii?Q?fSDw+nlfvMQ+t4GIK+jn6jrAw6V+vTullHvdSKTyZ9g9oPLzVp5wJLfDBb9b?=
 =?us-ascii?Q?NX2g+aBMG5TA/OgLL+CfKRhL7WDAQNFSNcbSFpeSbQFaUlw6zxn7d2w22qPb?=
 =?us-ascii?Q?6+ypqFXzDBRC3/5KWRztk7mXucWLW3hE86J5vs+Da4dFwg5h9khOiaVQwthW?=
 =?us-ascii?Q?/BYPCFg3NASGxXUkeSZDHc8XJ1s2lISYQdgNjcO4XBA4ZPZE/r66pRjYPeR+?=
 =?us-ascii?Q?JLYhyv0c/tfzM+oXhqNvX+h1lpg44uMnEpvgzrnVd4w/kH2LQEFH9QxQMy3Q?=
 =?us-ascii?Q?Hup5rpO6UonQA5ZXmZc2WYuo0HfzgFbaU5pO9/VSneZP3s1OJSvpEqegpsvx?=
 =?us-ascii?Q?VwWi8Yfp7SsHeC5ZREawjrrXcK+6kk3vy7UYjk0DCbKrm0ZobtedrCTBx3Tq?=
 =?us-ascii?Q?Spt5Q08NTgkVKOPJ9hhIYwBv4Vr9fRNbdROQFNcNwRwpMM0TLMWDIMaOQ0YM?=
 =?us-ascii?Q?iICvmMNyBZCTVz7hJoyW0tHEFhuBduZDQ4ATd/+an2gI0Th7fMjviqCm4jxi?=
 =?us-ascii?Q?2PbAWaRECwuA2C1hBn4Ygv5463r4xuSQncVvJjw32nru4hisFXKEU4ctrWii?=
 =?us-ascii?Q?zgsV01ZVHTo8K45zjhh2rNxJxRz7DAgDopMKWc6cTJVKubIIHiORwBz4XOCi?=
 =?us-ascii?Q?MnydFIu2reIyuI8hIvgNSchXR0zi6xRnMasH8vYMgtZID/FIMH3+HsFwV0At?=
 =?us-ascii?Q?9oOS4cpA2cwFfyux1pdHYZpfUsQlfQYZ2PBTftJnnoHbXW9bG/DEhl+cN4qP?=
 =?us-ascii?Q?KktUiSGWIR/EXxj3dzKCSqhOngVQu1+PTPKwAajyrjNjSeQiJziesoKckkmI?=
 =?us-ascii?Q?HSbV334rFSm+jWRziOmwjAGtK0mEDjgYitd/HrCp?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc81749-bb65-44d3-b63d-08dbdfffae9d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 02:09:04.5666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KGZdTeESjGl6CdSkf4xcbXuMHuZj/BU5hOVEehlvFlzmAPU/CnSAh++YLgBRPoO4L41r1eQkGbUPrBVp225P9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6956
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Peter and syzbot,

On 2023-10-08 at 04:58:53 -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    7d730f1bf6f3 Add linux-next specific files for 20231005
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=15f02fa1680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f532286be4fff4b5
> dashboard link: https://syzkaller.appspot.com/bug?extid=6b8ea5bb987ec6fe0fd1
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/1d7f28a4398f/disk-7d730f1b.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d454d124268e/vmlinux-7d730f1b.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/dbca966175cb/bzImage-7d730f1b.xz

I found the similar issue and internal syzkaller & bisect tool generated the
reproduced code and bisect info: "possible deadlock in try_to_wake_up in v6.6"

All syzkaller and bisect info: https://github.com/xupengfe/syzkaller_logs/tree/main/231108_011342_try_to_wake_up
Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/231108_011342_try_to_wake_up/repro.c
Syzkaller reproduced syscall steps: https://github.com/xupengfe/syzkaller_logs/blob/main/231108_011342_try_to_wake_up/repro.prog
Syzkaller repro.stats analysis: https://github.com/xupengfe/syzkaller_logs/blob/main/231108_011342_try_to_wake_up/repro.report
Kconfig(then make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/231108_011342_try_to_wake_up/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/231108_011342_try_to_wake_up/bisect_info.log
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/231108_011342_try_to_wake_up/ffc253263a1375a65fa6c9f62a893e9767fbebfa_dmesg.log
Reproduced bzImage: https://github.com/xupengfe/syzkaller_logs/blob/main/231108_011342_try_to_wake_up/bzImage_ffc253263a1375a65fa6c9f62a893e9767fbebfa.tar.gz

Bisected and found first bad commit is:
"
f3c0eba28704 perf: Add a few assertions
"

Unfortunately, made reverted commit on top of v6.6 kernel failed, could not
double confirm for this problem.

I hope it's helpful.

Related dmesg info:
"
[   21.631830] 
[   21.631835] ======================================================
[   21.631838] WARNING: possible circular locking dependency detected
[   21.631842] 6.6.0-ffc253263a13+ #1 Not tainted
[   21.631848] ------------------------------------------------------
[   21.631850] repro/727 is trying to acquire lock:
[   21.631856] ffff888010f15760 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xc0/0x1af0
[   21.631884] 
[   21.631884] but task is already holding lock:
[   21.631887] ffffffff86c4c0f8 ((console_sem).lock){-...}-{2:2}, at: up+0x21/0xc0
[   21.631922] 
[   21.631922] which lock already depends on the new lock.
[   21.631922] 
[   21.631925] 
[   21.631925] the existing dependency chain (in reverse order) is:
[   21.631928] 
[   21.631928] -> #3 ((console_sem).lock){-...}-{2:2}:
[   21.631940]        _raw_spin_lock_irqsave+0x52/0x80
[   21.631953]        down_trylock+0x1c/0x80
[   21.631967]        __down_trylock_console_sem+0x4f/0xe0
[   21.631981]        console_trylock+0x7f/0x150
[   21.631995]        vprintk_emit+0x278/0x6b0
[   21.632011]        vprintk_default+0x2f/0x40
[   21.632026]        vprintk+0xd0/0x170
[   21.632034]        _printk+0xc4/0x100
[   21.632046]        ex_handler_msr+0x456/0x560
[   21.632056]        fixup_exception+0x8f7/0xce0
[   21.632066]        gp_try_fixup_and_notify.constprop.0+0x30/0x1b0
[   21.632082]        exc_general_protection+0x139/0x340
[   21.632098]        asm_exc_general_protection+0x2b/0x30
[   21.632113]        native_write_msr+0x22/0x60
[   21.632125]        __intel_pmu_enable_all.constprop.0+0x144/0x390
[   21.632139]        intel_pmu_enable_all+0x1e/0x30
[   21.632152]        x86_pmu_enable+0x574/0xe50
[   21.632164]        perf_ctx_enable+0x11e/0x1c0
[   21.632179]        ctx_resched+0x137/0x160
[   21.632190]        __perf_install_in_context+0x244/0x970
[   21.632203]        remote_function+0x136/0x1b0
[   21.632214]        generic_exec_single+0x202/0x560
[   21.632227]        smp_call_function_single+0x196/0x470
[   21.632239]        perf_install_in_context+0x4f4/0x5a0
[   21.632254]        perf_event_create_kernel_counter+0x4e3/0x680
[   21.632268]        hardlockup_detector_event_create+0xd1/0x1d0
[   21.632282]        watchdog_hardlockup_probe+0x34/0xa0
[   21.632297]        lockup_detector_init+0x72/0x100
[   21.632309]        kernel_init_freeable+0x93e/0x1120
[   21.632320]        kernel_init+0x28/0x2e0
[   21.632329]        ret_from_fork+0x56/0x90
[   21.632343]        ret_from_fork_asm+0x1b/0x30
[   21.632360] 
[   21.632360] -> #2 (&cpuctx_lock){-...}-{2:2}:
[   21.632372]        _raw_spin_lock+0x38/0x50
[   21.632382]        perf_cgroup_switch+0x1af/0x350
[   21.632394]        __perf_event_task_sched_out+0x12d/0x1710
[   21.632407]        __schedule+0x15a7/0x3010
[   21.632419]        schedule+0x141/0x230
[   21.632430]        schedule_preempt_disabled+0x1c/0x30
[   21.632443]        __mutex_lock+0xd8a/0x1a40
[   21.632456]        mutex_lock_nested+0x1f/0x30
[   21.632470]        tty_open+0x5a4/0x1500
[   21.632481]        chrdev_open+0x2b1/0x790
[   21.632492]        do_dentry_open+0x67c/0x1580
[   21.632503]        vfs_open+0xba/0xf0
[   21.632516]        path_openat+0x1d25/0x2920
[   21.632532]        do_filp_open+0x1ce/0x420
[   21.632541]        do_sys_openat2+0x185/0x1f0
[   21.632555]        __x64_sys_openat+0x17a/0x240
[   21.632570]        do_syscall_64+0x3c/0x90
[   21.632581]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   21.632595] 
[   21.632595] -> #1 (&rq->__lock){-.-.}-{2:2}:
[   21.632608]        _raw_spin_lock_nested+0x3e/0x60
[   21.632619]        raw_spin_rq_lock_nested+0x2c/0x40
[   21.632629]        task_fork_fair+0x69/0x1e0
[   21.632645]        sched_cgroup_fork+0x437/0x6c0
[   21.632658]        copy_process+0x44e0/0x7130
[   21.632670]        kernel_clone+0xfd/0x890
[   21.632681]        user_mode_thread+0xc5/0x100
[   21.632693]        rest_init+0x32/0x2c0
[   21.632701]        arch_call_rest_init+0x1c/0x50
[   21.632711]        start_kernel+0x3dd/0x510
[   21.632721]        x86_64_start_reservations+0x1c/0x30
[   21.632736]        x86_64_start_kernel+0xa0/0xb0
[   21.632751]        secondary_startup_64_no_verify+0x17d/0x18b
[   21.632771] 
[   21.632771] -> #0 (&p->pi_lock){-.-.}-{2:2}:
[   21.632783]        __lock_acquire+0x2fe2/0x5c70
[   21.632796]        lock_acquire+0x1c9/0x530
[   21.632808]        _raw_spin_lock_irqsave+0x52/0x80
[   21.632819]        try_to_wake_up+0xc0/0x1af0
[   21.632829]        wake_up_process+0x19/0x20
[   21.632839]        __up.isra.0+0xec/0x130
[   21.632853]        up+0x90/0xc0
[   21.632866]        console_unlock+0x2cb/0x310
[   21.632880]        con_install+0x176/0x640
[   21.632894]        tty_init_dev.part.0+0xa8/0x6b0
[   21.632904]        tty_open+0xc86/0x1500
[   21.632914]        chrdev_open+0x2b1/0x790
[   21.632924]        do_dentry_open+0x67c/0x1580
[   21.632936]        vfs_open+0xba/0xf0
[   21.632949]        path_openat+0x1d25/0x2920
[   21.632964]        do_filp_open+0x1ce/0x420
[   21.632973]        do_sys_openat2+0x185/0x1f0
[   21.632988]        __x64_sys_openat+0x17a/0x240
[   21.633003]        do_syscall_64+0x3c/0x90
[   21.633013]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   21.633028] 
[   21.633028] other info that might help us debug this:
[   21.633028] 
[   21.633031] Chain exists of:
[   21.633031]   &p->pi_lock --> &cpuctx_lock --> (console_sem).lock
[   21.633031] 
[   21.633046]  Possible unsafe locking scenario:
[   21.633046] 
[   21.633048]        CPU0                    CPU1
[   21.633050]        ----                    ----
[   21.633053]   lock((console_sem).lock);
[   21.633058]                                lock(&cpuctx_lock);
[   21.633064]                                lock((console_sem).lock);
[   21.633071]   lock(&p->pi_lock);
[   21.633076] 
[   21.633076]  *** DEADLOCK ***
[   21.633076] 
[   21.633078] 3 locks held by repro/727:
[   21.633084]  #0: ffffffff87225f28 (tty_mutex){+.+.}-{3:3}, at: tty_open+0x5a4/0x1500
[   21.633110]  #1: ffff88800eed91c0 (&tty->legacy_mutex){+.+.}-{3:3}, at: tty_lock+0x88/0xc0
[   21.633136]  #2: ffffffff86c4c0f8 ((console_sem).lock){-...}-{2:2}, at: up+0x21/0xc0
[   21.633166] 
[   21.633166] stack backtrace:
[   21.633168] CPU: 1 PID: 727 Comm: repro Not tainted 6.6.0-ffc253263a13+ #1
[   21.633180] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   21.633187] Call Trace:
[   21.633190]  <TASK>
[   21.633194]  dump_stack_lvl+0xaa/0x110
[   21.633209]  dump_stack+0x19/0x20
[   21.633222]  print_circular_bug+0x47e/0x750
[   21.633239]  check_noncircular+0x2f7/0x3e0
[   21.633254]  ? __pfx_check_noncircular+0x10/0x10
[   21.633273]  ? __pfx_lockdep_lock+0x10/0x10
[   21.633284]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
[   21.633304]  __lock_acquire+0x2fe2/0x5c70
[   21.633325]  ? __pfx___lock_acquire+0x10/0x10
[   21.633343]  ? __kasan_check_read+0x15/0x20
[   21.633358]  lock_acquire+0x1c9/0x530
[   21.633373]  ? try_to_wake_up+0xc0/0x1af0
[   21.633388]  ? __pfx_lock_acquire+0x10/0x10
[   21.633405]  ? __pfx___lock_acquire+0x10/0x10
[   21.633422]  ? __pfx_lock_release+0x10/0x10
[   21.633442]  _raw_spin_lock_irqsave+0x52/0x80
[   21.633456]  ? try_to_wake_up+0xc0/0x1af0
[   21.633470]  try_to_wake_up+0xc0/0x1af0
[   21.633485]  ? __pfx_try_to_wake_up+0x10/0x10
[   21.633499]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   21.633518]  ? __pfx_lock_release+0x10/0x10
[   21.633536]  wake_up_process+0x19/0x20
[   21.633549]  __up.isra.0+0xec/0x130
[   21.633567]  up+0x90/0xc0
[   21.633585]  console_unlock+0x2cb/0x310
[   21.633603]  ? __pfx_console_unlock+0x10/0x10
[   21.633622]  ? tty_init_termios+0x1f8/0x570
[   21.633642]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
[   21.633659]  ? tty_standard_install+0x82/0x190
[   21.633680]  con_install+0x176/0x640
[   21.633698]  ? __pfx_con_install+0x10/0x10
[   21.633716]  ? mutex_lock_nested+0x1f/0x30
[   21.633733]  ? __pfx_con_install+0x10/0x10
[   21.633751]  tty_init_dev.part.0+0xa8/0x6b0
[   21.633766]  tty_open+0xc86/0x1500
[   21.633781]  ? __pfx_tty_open+0x10/0x10
[   21.633796]  ? do_raw_spin_unlock+0x15d/0x210
[   21.633814]  ? __pfx_tty_open+0x10/0x10
[   21.633825]  chrdev_open+0x2b1/0x790
[   21.633838]  ? __pfx_chrdev_open+0x10/0x10
[   21.633849]  ? fsnotify_perm.part.0+0x27d/0x660
[   21.633867]  do_dentry_open+0x67c/0x1580
[   21.633882]  ? __pfx_chrdev_open+0x10/0x10
[   21.633899]  vfs_open+0xba/0xf0
[   21.633915]  path_openat+0x1d25/0x2920
[   21.633941]  ? __pfx_path_openat+0x10/0x10
[   21.633959]  ? __this_cpu_preempt_check+0x21/0x30
[   21.633976]  ? lock_is_held_type+0xf0/0x150
[   21.633994]  do_filp_open+0x1ce/0x420
[   21.634006]  ? __pfx_do_filp_open+0x10/0x10
[   21.634018]  ? lock_release+0x417/0x7e0
[   21.634040]  ? do_raw_spin_unlock+0x15d/0x210
[   21.634067]  do_sys_openat2+0x185/0x1f0
[   21.634083]  ? __pfx_do_sys_openat2+0x10/0x10
[   21.634101]  ? trace_hardirqs_on+0x26/0x120
[   21.634121]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
[   21.634140]  __x64_sys_openat+0x17a/0x240
[   21.634158]  ? __pfx___x64_sys_openat+0x10/0x10
[   21.634178]  ? syscall_trace_enter.constprop.0+0x160/0x1e0
[   21.634197]  do_syscall_64+0x3c/0x90
[   21.634210]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[   21.634226] RIP: 0033:0x7f7333d3e84b
[   21.634235] Code: 25 00 00 41 00 3d 00 00 41 00 74 4b 64 8b 04 25 18 00 00 00 85 c0 75 67 44 89 e2 48 89 ee bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d 00 f0 ff ff 0f 87 91 00 00 00 48 8b 54 24 28 64 48 2b 14 25
[   21.634246] RSP: 002b:00007ffff86ffd70 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
[   21.634257] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7333d3e84b
[   21.634265] RDX: 0000000000000002 RSI: 00007ffff86ffe10 RDI: 00000000ffffff9c
[   21.634272] RBP: 00007ffff86ffe10 R08: 0000000000000000 R09: 00007ffff86ffb86
[   21.634279] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
[   21.634285] R13: 0000000000401e37 R14: 0000000000403e08 R15: 00007f7333eb0000
[   21.634302]  </TASK>
"

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following
information.

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
