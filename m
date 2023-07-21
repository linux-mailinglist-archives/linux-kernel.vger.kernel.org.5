Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDD075BCF0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 05:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGUDss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 23:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUDsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 23:48:33 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2048.outbound.protection.outlook.com [40.107.212.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9672D57;
        Thu, 20 Jul 2023 20:48:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LHtEzZxbSYLGe2fkAKratCVytlAzEggkvOhx/C8CugbO5tT/kpDoXUMCzk/AcrMv1jimVGsPcBC58jLjn0Sb41ZmDbltXWogQylzVw1qqhJyfl/4id8l0UpEkAWbt3/HCRN3QDQq0/VrccxsV+nHI/Od213NWmjL1vHyo9TJhUwKiPb8DvatNuYXP9QpTVoyXzlURQOvh2zc+MolbMmro8pZs5+J8uPfLl9dR3o+MBh+UllMqCPRxmeGClJRjlm4FlGGn3njt1Euicp8Sqb0zsp9FCMWU5DhO8zYhVe3jsqJEe/Zm/Dyh2eJ/ldVYYNrLrNHDPqPoQOqVyV8fZRPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fdwBNlnBSPLHY4EGUi+C421ImHCGeMJJoMno9cZEm34=;
 b=BULNHiZAGKCiCbMjWrb+pLimk73nf7obWntSI2rln0rapW7UOlVkSJTB2FPPHLmfr/T1aCiFwDjbXO6y0hvJvPrcAmddlZiuUz4ghXmNSQ43Ka3ZQKM124iQqLo+2KWxQ2RylTI3NxVYNBH8M/7LQTIGQVixkSkDEU8p7goCZ+Mfuxk63SsGrp+FJIz73mjT0sSbSUBuZiA034UwidKyWZl3UgLzrF/r1wDhNBRhW7qWdy+8bCxfQbj2KQ0kCEihnyUQ8hpZXNqG5EnlkkWBbUWlSenqczhKlK74zbjrVoc2wJVkdvBmVSMpyolSWQ2Uzpg2reYauVhch6tDpEzKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fdwBNlnBSPLHY4EGUi+C421ImHCGeMJJoMno9cZEm34=;
 b=E/EfDUjd8/Os49TFwQcmzCQKajTOLJ4YMt5osUADPfNSDoRbeFW409udhhBtT3OMHUYrckanX+zCWpL8tpvu1XaGuJBbLvFo22Z8z8yBddiTM5ndiDikELuoITJRfGgjPUXZRJxUNM/ymegjWp16xSe9024BMXpAOJA5eQqZkl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6460.namprd12.prod.outlook.com (2603:10b6:208:3a8::13)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 03:46:27 +0000
Received: from IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::3fcf:7bf4:35f6:f173]) by IA1PR12MB6460.namprd12.prod.outlook.com
 ([fe80::3fcf:7bf4:35f6:f173%6]) with mapi id 15.20.6588.031; Fri, 21 Jul 2023
 03:46:27 +0000
Message-ID: <33b3bb31-c788-7fe7-00dc-fbb8a786c4fe@amd.com>
Date:   Fri, 21 Jul 2023 09:16:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
X-Mozilla-News-Host: news://54.189.247.149:119
Content-Language: en-US
From:   "Aithal, Srikanth" <sraithal@amd.com>
Subject: next-20230720: BUG: kernel NULL pointer dereference
To:     linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0008.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::13) To IA1PR12MB6460.namprd12.prod.outlook.com
 (2603:10b6:208:3a8::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6460:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 739797b4-3b0d-4212-f724-08db899d0fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3Pz3lkDf36YBHyAYVQT9b6WWXuOEIXpKma8gsnvCb5Gu2tQo2DWprODsilzAXLmNdLfPTNXeUvjCjUT85FGuSQlgNDyl8tqCommfQ7fwCfv0YXiU9/apdnXkYc+vNWM5vR5XUAYSoH5UwTq5HWWcB5W5tDIaHtNTahDk2ZfLWwlyHeF6gL/Y4ZG9zSw893vXR/Zsk0oNeq/MmBgCcHTWJAVvBbUOxk+1X1KpSVqyEC1rEOehWLo8F98H0SqeL9l4HqbkpVUdijhT15WN/Aqd4JZEIkaRcG2f9tCnA+5F/psEtemZTulc5USlPb1Bx+hDHq+er1SUOvcNphV59EDxg5J7adYBmFWoPMPbRV84lHooxb/QRWXaFTU2ULR9ZL5pjJticJYAPsnAG7QzvXK4mlK7RU/Mnd+vS1P/vMk7gIHRtV9z/RM4jhgRmUuPmFs5ZIqszm8gBk/FPj5b2RGt0Zx7SQroRplitzhROatEbjPLz6U6IlMKlPQubtD0GjEBRB4IdgqAJXh8gAZ5YHCfaRBko3Yj2lDYq14vOmmTr+MzWk6zqpsg2vx11jqAH5nIBmTESEwFQ9qLfBTG+NLa7iBXG72cebdrL6rpgWKyYvivPmvyr4eanzaEuEq7baQtbhT2+N9KpxtGUbKR+GUTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6460.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(41300700001)(6506007)(186003)(26005)(45080400002)(478600001)(316002)(31686004)(450100002)(66476007)(66556008)(66946007)(8936002)(8676002)(5660300002)(6666004)(6512007)(6486002)(2616005)(83380400001)(2906002)(38100700002)(36756003)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekhJTXY3YmpIeGpzQjh5bXMra3JJNTJiWEd1NmJISE03TlFyRlp0K0UxWHI1?=
 =?utf-8?B?VTlobEhDR3lISDlBYVhkOUxXMWJOU29sTk9lMm9CL1lOenhTb1U3dkJtMy9S?=
 =?utf-8?B?dWhXZmI3Wllna3RORVZrbkg1N0hvNUlMeUxiVWJGZ2JWdXBCa1VPTi9MSzla?=
 =?utf-8?B?aHZHL2FsYUZDazlxS2g2UHpLbzVhSHZ6MEFUMTZjVURNRml5YTVZYng3anZV?=
 =?utf-8?B?Uks1UERESEVZUjFmaC9vUFI0VHFCbGNFMUhGeG01d0RmcDJibUVuZDJwVXZt?=
 =?utf-8?B?eTg5Znh4ZjlSbUtlaGNnLzVTc0dyL2JlWlQ2MVI2TjhWdm1ZZmFvLzNsdjcw?=
 =?utf-8?B?aEJBT1BlRDgxSDI4Zm04UGFCMWoyMytMU1ZRNWxBUFg5OEdGS2JTbkRqR1Jy?=
 =?utf-8?B?aTBuRFpqNXdIamlaNlo4OXNwTGVjajhLNXRpZE5YamFyR3FwVlR5N0syYW1D?=
 =?utf-8?B?TGsxTjJlRFd1MC93YTByYnNTYXIxQktuRWZvU04yaE1Ma2dEM0hNVGZoN3Er?=
 =?utf-8?B?YUtCdzR4cXhYMDZ3OEM1aEx5Zk1HM04yaUwzSHJYZzNnb2twYzJlZHBheEF3?=
 =?utf-8?B?WXhFdmMrYU1rNG9jczJHV3p2dVF4MmNzeEtCalMvUEE1ajFJN3hSb2k5NXNN?=
 =?utf-8?B?Tk12TkFkMnVna0hkaktWUXQ2U043S3VPbzd3d01EZDRWYUVMUFg3U1Z6aS9t?=
 =?utf-8?B?SldrQkxNeVBxOWFKVHBIOEs5R0pKNlU0aWFKb2lYbXI0TmtHL1J5N041ODJv?=
 =?utf-8?B?ZUUrb3pnS1pSNlBDRmppUWJKTG5EdzMyN3NZakgwcElKY1l4REU3UGI4R2R6?=
 =?utf-8?B?WDdPMHJaajV5NlpDcVZoeWUwbjdPeEgzQjBPRCtRdGJ2RVo0cU9PT3ZQdnow?=
 =?utf-8?B?QmVSRWl5NlVWNmN3Z1dxcFRZTEwrK2FPYngrUWdNSGNyNWhEaFQ1cDI5dk44?=
 =?utf-8?B?OGxhNjU2cVFQcHNBZGxiK3BTVGNRY3Vib0RrOXVwbmY2RjZSTFkxRTBNY0xL?=
 =?utf-8?B?NFlhaEVpUmNnMU1ZeEFJN3ZJUHRWVEFqdXRlRFhxa2paMmdkeC9hVCtXNVJ5?=
 =?utf-8?B?aUgxblhOREU1UWY4MjlZL3ptWFc5ZGFqdkJONFhzRWZUeC93NzBXQUFyclQ3?=
 =?utf-8?B?Z0F0Ky9tVFF2L2w2QjlGZnpQRkorQzhubnFlbmx1MGg5Nk1IR0Y2bExGaGVp?=
 =?utf-8?B?MUVYdkUxTlFGaVpIdFN4elh6MGhPL29qS0ViZXUydmdLUGx3Vml5Z2NFWFlD?=
 =?utf-8?B?c3BrN1lwVDhBYVpQN0pSUzNsWFJZMHMwU0M3eUppZnZnQy9WQVl3UFNKTHVL?=
 =?utf-8?B?T1c1dG1QcTdpQmJMV1pNNEE3RnNLNDhmalRTU3FkWkFway9GdkxkaVBTMUJN?=
 =?utf-8?B?clFRVGh2RVNYMjc2bnkwMkpQVW45dVBxaXNRV1Q3TE9FYUMycDU5cGZMVFVP?=
 =?utf-8?B?Y0xQbDlyZWNpK2swa2R2cVM3UjZrdEYvVURUbDZySFRqUGVVeGREQjlDa1p3?=
 =?utf-8?B?RmtGWG1XUHVIUWJtR0FUbDI4WE9HM1c5Q3hYWUgwOEpIdFBYSnk3eXJOcmhI?=
 =?utf-8?B?enhZaXB5Wnh3bXZSV2JOUk9wNnZRYW12ZDlMc3pUQU5GZndvYmdTczVnNTlD?=
 =?utf-8?B?ZkFIMTFWUGxGeHBCZ1IrTkFMTnFtWkNlbmE5MktZR1RRUVVDOEdPOFU1Qytv?=
 =?utf-8?B?cHZ4aS9pdzdCRVp5UEJRNnc4S2tZQ0w0U21sMnY2Z2IyWHhBNEhOdk1ERWJ0?=
 =?utf-8?B?SU5EUFRlQTNxVG5SN0kyTjhUcExYNFdHeC9HWkRISU1HNlpTV0VrWWIvQVBj?=
 =?utf-8?B?bm9RVTNKemhqSVlNc0dzTjl6em5CcUFiRUxHTXZPU0gwU3F6eTBxTjk5aEt4?=
 =?utf-8?B?NVhTSTE1akhZcmV4Z1NFY2R6ZFdGU1A4THliVHpacCthb3NVczRsbVhwVXJZ?=
 =?utf-8?B?ZzRDU2Q3MDBVRUR3OW1WT0s4UE5lSkpHTjhDeGN1enFoQlMzbUNyUDBPZGJL?=
 =?utf-8?B?U3ZvRmdKVm13NVBNeDRINHRnalk2RGtrb0thNSs1MExsSE1RWEdiVFVFeUMy?=
 =?utf-8?B?RkZrTG9Fb1Y4cXZMUHNONVA4WngrUTZSUlR3Nk1Uc2NiRkpIMHlqSHFZczQ1?=
 =?utf-8?Q?1xO/y1QrCN77wGUs8hEllCaoS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739797b4-3b0d-4212-f724-08db899d0fa8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6460.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 03:46:27.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxJGtXDaZWIENkux0+JhjnuE+CRb3bq2kwwk3CjDzGevcnWI6otu1Eng99X4M0igQ1h9ljAd6JBkqp/G+PCPDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Linux next build next-20230720 hits BUG: kernel NULL pointer dereference 
while booting SEV guest:

===============
Recreation steps
===============
1. Run shutdown tests for around 10 times with SVM guest having around 
85% of Host RAM [note: nothing else is running on host as well as inside 
guest].
2. Then try to boot a SEV guest with 85% of Host RAM, we hit below call 
trace:

===============
Call trace:
===============
[  775.069108] BUG: kernel NULL pointer dereference, address: 
0000000000000498
[  775.076069] #PF: supervisor read access in kernel mode
[  775.081200] #PF: error_code(0x0000) - not-present page
[  775.086329] PGD 0 P4D 0
[  775.088861] Oops: 0000 [#1] PREEMPT SMP NOPTI
[  775.093211] CPU: 45 PID: 796 Comm: kcompactd1 Kdump: loaded Not 
tainted 6.5.0-rc2-next-20230720-next-20230720- #1
[  775.103465] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 
2.8.5 08/18/2022
[  775.111029] RIP: 0010:arch_tlbbatch_flush+0xcf/0x130
[  775.115995] Code: 48 83 c2 3f 48 c1 ea 06 48 c1 e2 03 e8 3a 17 e1 00 
65 ff 0d 2b b6 38 4e 74 5b 65 48 8b 04 25 40 2e 03 00 48 8b b8 e0 08 00 
00 <48> 83 bf 98 04 00 00 00 75 31 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc
[  775.134732] RSP: 0018:ffffb4a20e7aba58 EFLAGS: 00010286
[  775.139949] RAX: ffff974907fd3300 RBX: 000000000000002d RCX: 
0000000000000000
[  775.147073] RDX: 0000000000000010 RSI: 0000000000000000 RDI: 
0000000000000000
[  775.154197] RBP: ffffb4a20e7aba78 R08: 0000000000000080 R09: 
ffff974907fd4220
[  775.161322] R10: 0000000000000002 R11: 0000000000000002 R12: 
ffff974907fd4220
[  775.168454] R13: ffff9787d6372f80 R14: 000000000000002e R15: 
ffffb4a20e7abc80
[  775.175577] FS:  0000000000000000(0000) GS:ffff9787d6340000(0000) 
knlGS:0000000000000000
[  775.183654] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  775.189392] CR2: 0000000000000498 CR3: 0008003cca62e003 CR4: 
0000000000770ee0
[  775.196517] PKRU: 55555554
[  775.199227] Call Trace:
[  775.201672]  <TASK>
[  775.203771]  ? show_regs+0x6e/0x80
[  775.207174]  ? __die+0x29/0x70
[  775.210224]  ? page_fault_oops+0x160/0x460
[  775.214315]  ? __mod_lruvec_page_state+0xa4/0x150
[  775.219012]  ? page_vma_mapped_walk+0xfd/0x8e0
[  775.223450]  ? page_remove_rmap+0xac/0x250
[  775.227540]  ? do_user_addr_fault+0x306/0x690
[  775.231900]  ? exc_page_fault+0x7d/0x190
[  775.235825]  ? asm_exc_page_fault+0x2b/0x30
[  775.240003]  ? arch_tlbbatch_flush+0xcf/0x130
[  775.244352]  ? arch_tlbbatch_flush+0xb6/0x130
[  775.248705]  try_to_unmap_flush+0x2c/0x40
[  775.252716]  migrate_pages_batch+0x678/0xbe0
[  775.256989]  ? __pfx_compaction_free+0x10/0x10
[  775.261435]  ? __pfx_compaction_alloc+0x10/0x10
[  775.265958]  migrate_pages+0x9be/0xc50
[  775.269702]  ? cgroup_rstat_updated+0xc4/0xe0
[  775.274063]  ? __mod_lruvec_state+0x3b/0x50
[  775.278238]  ? __pfx_compaction_free+0x10/0x10
[  775.282677]  ? __pfx_compaction_alloc+0x10/0x10
[  775.287203]  compact_zone+0x7a8/0xef0
[  775.290866]  ? psi_task_switch+0xd9/0x240
[  775.294879]  ? finish_task_switch.isra.0+0x85/0x290
[  775.299759]  proactive_compact_node+0x88/0xe0
[  775.304118]  kcompactd+0x37a/0x400
[  775.307514]  ? __pfx_autoremove_wake_function+0x10/0x10
[  775.312740]  ? __pfx_kcompactd+0x10/0x10
[  775.316658]  kthread+0xfb/0x130
[  775.319803]  ? __pfx_kthread+0x10/0x10
[  775.323547]  ret_from_fork+0x40/0x60
[  775.327127]  ? __pfx_kthread+0x10/0x10
[  775.330870]  ret_from_fork_asm+0x1b/0x30
[  775.334798]  </TASK>
[  775.336988] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack 
ipt_REJECT xt_tcpudp nft_compat x_tables nf_nat_tftp nf_conntrack_tftp 
bridge stp llc ib_core nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib 
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct 
nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set 
nf_tables nfnetlink sunrpc nls_iso8859_1 ipmi_ssif intel_rapl_msr 
intel_rapl_common amd64_edac kvm_amd kvm acpi_ipmi ipmi_si rapl 
ipmi_devintf joydev wmi_bmof input_leds pcspkr efi_pstore i2c_piix4 
k10temp ipmi_msghandler acpi_power_meter evbug mac_hid sch_fq_codel xfs 
libcrc32c hid_generic usbkbd usbmouse usbhid hid mgag200 drm_kms_helper 
i2c_algo_bit drm_shmem_helper drm crct10dif_pclmul crc32_pclmul 
ghash_clmulni_intel sha512_ssse3 aesni_intel mpt3sas crypto_simd cryptd 
tg3 ccp raid_class scsi_transport_sas sp5100_tco wmi dm_mirror 
dm_region_hash dm_log msr autofs4
[  775.417215] CR2: 0000000000000498
[  775.420532] ---[ end trace 0000000000000000 ]---
[  775.504479] pstore: backend (erst) writing error (-28)
[  775.509615] RIP: 0010:arch_tlbbatch_flush+0xcf/0x130
[  775.514581] Code: 48 83 c2 3f 48 c1 ea 06 48 c1 e2 03 e8 3a 17 e1 00 
65 ff 0d 2b b6 38 4e 74 5b 65 48 8b 04 25 40 2e 03 00 48 8b b8 e0 08 00 
00 <48> 83 bf 98 04 00 00 00 75 31 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc
[  775.533326] RSP: 0018:ffffb4a20e7aba58 EFLAGS: 00010286
[  775.538543] RAX: ffff974907fd3300 RBX: 000000000000002d RCX: 
0000000000000000
[  775.545666] RDX: 0000000000000010 RSI: 0000000000000000 RDI: 
0000000000000000
[  775.552789] RBP: ffffb4a20e7aba78 R08: 0000000000000080 R09: 
ffff974907fd4220
[  775.559914] R10: 0000000000000002 R11: 0000000000000002 R12: 
ffff974907fd4220
[  775.567039] R13: ffff9787d6372f80 R14: 000000000000002e R15: 
ffffb4a20e7abc80
[  775.574162] FS:  0000000000000000(0000) GS:ffff9787d6340000(0000) 
knlGS:0000000000000000
[  775.582238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  775.587978] CR2: 0000000000000498 CR3: 0008003cca62e003 CR4: 
0000000000770ee0
[  775.595109] PKRU: 55555554
[  775.597814] note: kcompactd1[796] exited with irqs disabled

