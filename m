Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482D375BE36
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjGUGFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjGUGFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:05:20 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6444A2;
        Thu, 20 Jul 2023 23:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WlzxFzydgKQguPPo4nB+Xz+PhxGvxtNsm7dOETiI6EQ/XiWWz2WMqoIyh+OEhg2l6/LUCwko1UsK/GGaLnP4wZISCnHv7Qikr7In3ioCToHCOWOq83R1xLMkXv7O6MW58p7lL2T8E3WbphHlLhCPX5HsXhijn2BYukC6Qbk4B349pUnNqcLtEUP11VIhNN/AEMiisoCumtA0aCoLXHPkGddzi7ZwaQRn8J7hsqT/cnAD+OXHC/nWlAGSst8D0+fer8s/ushSV62aU/PMiSIL6SZAGiTh4NVWhQFWhZTyctoH13JyrqCIhbD0VLxgb15nziqIu7E0BHuWGiJYfDCGJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQVzNrhpYa6k8cb6rJhMwLGnWiaatImbeYzvRW5036A=;
 b=l5pwpF6/nbkq728LP9bSZZla0bQHLS0GEoIDfLsb9leQ9svgB+JljH3pBhFtiun5IpimzUl9f82AWzx18XwMf7+xhi6nGVAe1I2K2TXFvqtAOh4M8c2Quk73nhdTrRcYbgoS6Dwjrp554hadtuA82uMwmtZqUm6e5bU2Z4Zex9MQMdGkAcyM+NAPdKJyXyntzNT7Og7MxtPQZxb/orQKR9vul22FQsH8QJKxN3H84uwk7Y11ez9k/qi8ckfF1tHJ45zVqksBKS2PsyNAlXG57GGawpK+BZcgyhe3w+KBZqZ5fNqpb1HAeskU/NPaV/8/SK8Il+Q6vWd0sAvPJ2rw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQVzNrhpYa6k8cb6rJhMwLGnWiaatImbeYzvRW5036A=;
 b=QDcOXM1b2JMU8l7MicNufyVQIKE1nMBQYdfL1F2NgnOV74RWOpUKe/fmskK6VkDClRItLyZnQuj1JIU0YBsL/uQC/0iVqPYUTQ1AnodxpbjzaNC8suY8r9pcTEZ/MANTq/rDxXGG9I5SvbCMznM07d/i3qjOBTed0ZvhffTruQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 06:03:43 +0000
Received: from IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::bc63:b5a8:902:ee0e]) by IA1PR12MB6137.namprd12.prod.outlook.com
 ([fe80::bc63:b5a8:902:ee0e%2]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 06:03:43 +0000
Message-ID: <ddfe1603-bfd2-8da2-46d5-bb2be59322e0@amd.com>
Date:   Fri, 21 Jul 2023 11:33:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: next-20230720: BUG: kernel NULL pointer dereference
Content-Language: en-US
To:     "Aithal, Srikanth" <sraithal@amd.com>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <33b3bb31-c788-7fe7-00dc-fbb8a786c4fe@amd.com>
Cc:     "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
From:   "Jain, Ayush" <ayush.jain3@amd.com>
In-Reply-To: <33b3bb31-c788-7fe7-00dc-fbb8a786c4fe@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0018.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::23) To IA1PR12MB6137.namprd12.prod.outlook.com
 (2603:10b6:208:3eb::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6137:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e94999b-bb80-49b2-0bf5-08db89b03ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnrCc9WwHAFayH5+41RiMqMlDhAvKzdjLBh47TQoHjXaE08BCSFEK8zlhS4VIaBV1ZzWpO2TTrig6sSJnKNXMc++y9XuiAeGBb0DweJ6PYqZnsYKPzZ74o7C+KG+/mqnxXiZekQCOLLCmAMfs0gL0HZzLg4hSdNt5CMFpmGFN60UBB3HBmRu4Ni3Lv/y1F8YBSGB3A7/G/mVs4Ba9topUpxhuVhAHEsgawuyfo7Czt+NtwjO4I9cF9pLPjetDIfOncGhb0azpmCRT4xQVFnUN9GMsqknnIKLysaZVSwTFxEHmrRs9eGU+p994CXUwnjbRQBkbwuP8vQTnsx+e7Qzk9W8gjso2Xb4jwtrqQeXKZx84l6FidJ6rPk4ePtYcqhhYazgu2rDO9hC9ajn3K0s/b6u/AaJo9YSB/C5HnYJp2wabuB2bovFay58Gn/D57hhNIufanb4qX6hmKFhXIY+57iPwEFE7WK3jkOt+o9pKewpCLSrl0kyo+ca2woZqMCSYrhcljF0Myg/0hxbRZZXX0e+f/QaEYh6eOAKTWZPjfSTwL5gyfBGjIwKXebV0v+7xSIRZX4+N3Nw9Xo5WjGiPxyCq3ix4I5XILAtqkX1kOvzdSwlqE1A8Lk1C6z1RYkpuHoDV01N+CwHB5srqwbXfgKlAwnhP6CsMskbIxoYI6K6A4Xvovs/wYN/Eh661jyB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6137.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(451199021)(31686004)(6512007)(478600001)(6486002)(45080400002)(316002)(6666004)(36756003)(41300700001)(66476007)(31696002)(86362001)(4326008)(66556008)(66946007)(6506007)(53546011)(2616005)(186003)(966005)(38100700002)(83380400001)(30864003)(2906002)(8676002)(8936002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3NvdWJWdURSQiszOHdEZGNTNzUvSXBYRldTYXRudysrOUdlbWVrM1NINlcv?=
 =?utf-8?B?bW50eFdVWEpBWUNYdDQ1S2VraWJBRHFrenJGa256VXdFcXlqbHVNbjd2Ly9a?=
 =?utf-8?B?RXhnZ21aTWttVkJKWjRYMTRnL2luUWZKbmJFT1Z5Rk9uM0M1ZXdSREFNUUlh?=
 =?utf-8?B?RTQyc3U5VXVoS29OUDJ5V1lEZ291VnMvUkhBNG45MkZBeERmd0Z5eHFTbEtR?=
 =?utf-8?B?QnQ5QlJESU9VbGgvRXNHNEllUm5DUlVzZlJPdkRvM254cWs3OVdnSXVjYlVx?=
 =?utf-8?B?L041MW1pZDMrUDFWVDhhS1BZd1lMNW1abHZXTm9mdjRrZEFWOW1RdVdleExX?=
 =?utf-8?B?UDU5QjZRVUZPM2ZVWnJaQmlKMUtVYUY3REFoLy82ZWp5ckNKVVNRa0puUlFi?=
 =?utf-8?B?VFFGQW4xOFNQcmFQSnJNaFljMC9tSWZqZ2YycHpRM25FcXhOczF6c1NDWFZw?=
 =?utf-8?B?Zk1xOVVIQlp2VjZ1cnRYNDRscVhUSklwSGd4c29EZEV4b0FoY1IvUit0YXFl?=
 =?utf-8?B?cy8wREx5cENuOEp4UkFiVmdobUZEZGMvcE9nZ0o1cUJrSGJlRktpVzJLNFNq?=
 =?utf-8?B?UDFiNlE5OC9rTjF1b01Ub25Zbk5HdHc2eG9uTHg3cGpoc0RwYy9Rd3hraS9L?=
 =?utf-8?B?YjZXU2kvQnR0Z3cvRjV2U3dESDMrMDRub0p4ZEErSnV4aXBBMVYyWFU4bm5i?=
 =?utf-8?B?eFBWNlE1S0loOENMUVp1d2MwbzFSRDVzWDV4czNldWtXYnRDYjdGZlFGaFh1?=
 =?utf-8?B?QVpmUEVZNWIxUXUvSTBtVDBsSStWb1BSY2RWZWtaYkE0N0NsSkpLMWZaM0l5?=
 =?utf-8?B?dWUrc2Q2VWhTMW9yVnZEaUFwRnBYZHJDZ3JCczdMRHdJWnN3VTlRbWZhOW01?=
 =?utf-8?B?Y3ZNTE9vZEZ6TUs4ekJaK1hkYzAxL0Z1akllUnZlcGZBYVBDQXo4OVUvMU1B?=
 =?utf-8?B?NCtmUE9laXEzRTFuVTJPUVFock8vVXdXZGdGLzJ1cmJQczl6UnFHTFlkeUow?=
 =?utf-8?B?MkRJY1NhRXUwZHJ2a3FTM1pFelRiZlZIeXcwSlhhaWM4SHRDekE5eHBlc3hh?=
 =?utf-8?B?V2g1WWk0UXFhNVYrc3Q0RkRyaFdBdFRnakdCVUdiaTQzd0hlc2hpL2pjb1BE?=
 =?utf-8?B?SytyQjRDM3BDQ1kwaEhnZE80cGhES1FDYnNpMlc2ajdodXc3YTluaE95OWp4?=
 =?utf-8?B?UDFLL2Q1WHROam5GblFNS1pYSHdNNE1rZnBIekxYSDV3TDZwYUxINmlnRUpP?=
 =?utf-8?B?NnB5b2I4eERjZDRyZXM2Y2VvM3JKQ012YXB2bkRuY2VFcTdNanU2V2gvODZT?=
 =?utf-8?B?UDNLd2tBK1FjdlFDeGY0NDZudFN5cUVlSjhZNEtkdjBhYVBnNllnN25rWEh0?=
 =?utf-8?B?UkJ3bmtLbHFHTDV0d3QwR2diRmtPZzBEeFgraStvRGc2RUNWTDRMN2gzMUNR?=
 =?utf-8?B?UVgxcmVkb2dEczlxM3dKaXVLV0FTRHE4dUhjYTFObDUxUThLdDhnZkdYNUtV?=
 =?utf-8?B?Rm9kSXJKTGlMVEpXTXk0Q09YamdOVkxJMi9mb2gxNUNabjAvYTZjUU1tTUZq?=
 =?utf-8?B?bVhCOHZscGV6endzZTA0dm1WelhUeG1PUS9WWVVkcWlyQ0hRM3I0b1RjYU5k?=
 =?utf-8?B?MGc3Smo0OTVwNnlmNmhvRGlIa3lmaVplMEgzTTB4andBSG1XM2xNb2k3a1li?=
 =?utf-8?B?R0VEMUY4Q05DZFp1UkpSNVpQd3ZtY2lObXJXZ1pFY25XWnpieFlhbEx4UTZC?=
 =?utf-8?B?L1BwaEdVY0h5c0pZVlJneGIzeks4Q0FYQVA2c2xGMWVtMlgvSCtrbnJiUGtV?=
 =?utf-8?B?NGhZM2dnYnlJN2I4elJQMzlWRkw3ak1LYmNaVitic1hGWEFEWm9vRmNQZU5G?=
 =?utf-8?B?dDh1NEhWaXJnQXZjak50eURMbGM1Y2JQTldLYjZEbHJJRmxIaFdHSE9xSmwr?=
 =?utf-8?B?SmExcmx4QjVvMEliaHlURUQyOEhoVklLSStWMG9ldExGVkhMNGVRKzg4MFFy?=
 =?utf-8?B?KzFVK0swSXhOV3Z0WmlpOGZNSGtiZzVWNmszbUtrbEF5UG9iOFVScTBSUW4w?=
 =?utf-8?B?NGJ4aWNJTWphcDN0NkVOOVU1UHRtaTZtcDVSVDJzQ2FpYm1QbzBOUGRDajFN?=
 =?utf-8?Q?A5ZkQgoELh+Ql2HjT12owQkDL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e94999b-bb80-49b2-0bf5-08db89b03ca5
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6137.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 06:03:43.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Asrfiwlqo1YKI5GTyaKt5k1x1uWIzietTmGLRRPKBKUU+HycjhM2i2e+bFih9HQPQ1LNcvXsSPG+XUBSxkjBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am able to reproduce similar Kernel Panic on a AMD EPYC Baremetal Server
while running eatmemory tests on Baremetal

On 7/21/2023 9:16 AM, Aithal, Srikanth wrote:
> Hello all,
> 
> Linux next build next-20230720 hits BUG: kernel NULL pointer dereference while booting SEV guest:
> 
> ===============
> Recreation steps
> ===============
> 1. Run shutdown tests for around 10 times with SVM guest having around 85% of Host RAM [note: nothing else is running on host as well as inside guest].
> 2. Then try to boot a SEV guest with 85% of Host RAM, we hit below call trace:
> 
> ===============
> Call trace:
> ===============
> [  775.069108] BUG: kernel NULL pointer dereference, address: 0000000000000498
> [  775.076069] #PF: supervisor read access in kernel mode
> [  775.081200] #PF: error_code(0x0000) - not-present page
> [  775.086329] PGD 0 P4D 0
> [  775.088861] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [  775.093211] CPU: 45 PID: 796 Comm: kcompactd1 Kdump: loaded Not tainted 6.5.0-rc2-next-20230720-next-20230720- #1
> [  775.103465] Hardware name: Dell Inc. PowerEdge R6515/07PXPY, BIOS 2.8.5 08/18/2022
> [  775.111029] RIP: 0010:arch_tlbbatch_flush+0xcf/0x130
> [  775.115995] Code: 48 83 c2 3f 48 c1 ea 06 48 c1 e2 03 e8 3a 17 e1 00 65 ff 0d 2b b6 38 4e 74 5b 65 48 8b 04 25 40 2e 03 00 48 8b b8 e0 08 00 00 <48> 83 bf 98 04 00 00 00 75 31 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc
> [  775.134732] RSP: 0018:ffffb4a20e7aba58 EFLAGS: 00010286
> [  775.139949] RAX: ffff974907fd3300 RBX: 000000000000002d RCX: 0000000000000000
> [  775.147073] RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000000
> [  775.154197] RBP: ffffb4a20e7aba78 R08: 0000000000000080 R09: ffff974907fd4220
> [  775.161322] R10: 0000000000000002 R11: 0000000000000002 R12: ffff974907fd4220
> [  775.168454] R13: ffff9787d6372f80 R14: 000000000000002e R15: ffffb4a20e7abc80
> [  775.175577] FS:  0000000000000000(0000) GS:ffff9787d6340000(0000) knlGS:0000000000000000
> [  775.183654] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  775.189392] CR2: 0000000000000498 CR3: 0008003cca62e003 CR4: 0000000000770ee0
> [  775.196517] PKRU: 55555554
> [  775.199227] Call Trace:
> [  775.201672]  <TASK>
> [  775.203771]  ? show_regs+0x6e/0x80
> [  775.207174]  ? __die+0x29/0x70
> [  775.210224]  ? page_fault_oops+0x160/0x460
> [  775.214315]  ? __mod_lruvec_page_state+0xa4/0x150
> [  775.219012]  ? page_vma_mapped_walk+0xfd/0x8e0
> [  775.223450]  ? page_remove_rmap+0xac/0x250
> [  775.227540]  ? do_user_addr_fault+0x306/0x690
> [  775.231900]  ? exc_page_fault+0x7d/0x190
> [  775.235825]  ? asm_exc_page_fault+0x2b/0x30
> [  775.240003]  ? arch_tlbbatch_flush+0xcf/0x130
> [  775.244352]  ? arch_tlbbatch_flush+0xb6/0x130
> [  775.248705]  try_to_unmap_flush+0x2c/0x40
> [  775.252716]  migrate_pages_batch+0x678/0xbe0
> [  775.256989]  ? __pfx_compaction_free+0x10/0x10
> [  775.261435]  ? __pfx_compaction_alloc+0x10/0x10
> [  775.265958]  migrate_pages+0x9be/0xc50
> [  775.269702]  ? cgroup_rstat_updated+0xc4/0xe0
> [  775.274063]  ? __mod_lruvec_state+0x3b/0x50
> [  775.278238]  ? __pfx_compaction_free+0x10/0x10
> [  775.282677]  ? __pfx_compaction_alloc+0x10/0x10
> [  775.287203]  compact_zone+0x7a8/0xef0
> [  775.290866]  ? psi_task_switch+0xd9/0x240
> [  775.294879]  ? finish_task_switch.isra.0+0x85/0x290
> [  775.299759]  proactive_compact_node+0x88/0xe0
> [  775.304118]  kcompactd+0x37a/0x400
> [  775.307514]  ? __pfx_autoremove_wake_function+0x10/0x10
> [  775.312740]  ? __pfx_kcompactd+0x10/0x10
> [  775.316658]  kthread+0xfb/0x130
> [  775.319803]  ? __pfx_kthread+0x10/0x10
> [  775.323547]  ret_from_fork+0x40/0x60
> [  775.327127]  ? __pfx_kthread+0x10/0x10
> [  775.330870]  ret_from_fork_asm+0x1b/0x30
> [  775.334798]  </TASK>
> [  775.336988] Modules linked in: xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT xt_tcpudp nft_compat x_tables nf_nat_tftp nf_conntrack_tftp bridge stp llc ib_core nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables nfnetlink sunrpc nls_iso8859_1 ipmi_ssif intel_rapl_msr intel_rapl_common amd64_edac kvm_amd kvm acpi_ipmi ipmi_si rapl ipmi_devintf joydev wmi_bmof input_leds pcspkr efi_pstore i2c_piix4 k10temp ipmi_msghandler acpi_power_meter evbug mac_hid sch_fq_codel xfs libcrc32c hid_generic usbkbd usbmouse usbhid hid mgag200 drm_kms_helper i2c_algo_bit drm_shmem_helper drm crct10dif_pclmul crc32_pclmul ghash_clmulni_intel sha512_ssse3 aesni_intel mpt3sas crypto_simd cryptd tg3 ccp raid_class scsi_transport_sas sp5100_tco wmi dm_mirror dm_region_hash dm_log msr autofs4
> [  775.417215] CR2: 0000000000000498
> [  775.420532] ---[ end trace 0000000000000000 ]---
> [  775.504479] pstore: backend (erst) writing error (-28)
> [  775.509615] RIP: 0010:arch_tlbbatch_flush+0xcf/0x130
> [  775.514581] Code: 48 83 c2 3f 48 c1 ea 06 48 c1 e2 03 e8 3a 17 e1 00 65 ff 0d 2b b6 38 4e 74 5b 65 48 8b 04 25 40 2e 03 00 48 8b b8 e0 08 00 00 <48> 83 bf 98 04 00 00 00 75 31 5b 41 5c 41 5d 41 5e 5d c3 cc cc cc
> [  775.533326] RSP: 0018:ffffb4a20e7aba58 EFLAGS: 00010286
> [  775.538543] RAX: ffff974907fd3300 RBX: 000000000000002d RCX: 0000000000000000
> [  775.545666] RDX: 0000000000000010 RSI: 0000000000000000 RDI: 0000000000000000
> [  775.552789] RBP: ffffb4a20e7aba78 R08: 0000000000000080 R09: ffff974907fd4220
> [  775.559914] R10: 0000000000000002 R11: 0000000000000002 R12: ffff974907fd4220
> [  775.567039] R13: ffff9787d6372f80 R14: 000000000000002e R15: ffffb4a20e7abc80
> [  775.574162] FS:  0000000000000000(0000) GS:ffff9787d6340000(0000) knlGS:0000000000000000
> [  775.582238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  775.587978] CR2: 0000000000000498 CR3: 0008003cca62e003 CR4: 0000000000770ee0
> [  775.595109] PKRU: 55555554
> [  775.597814] note: kcompactd1[796] exited with irqs disabled
> 

Steps to Reproduce:
  
$ git clone https://github.com/avocado-framework/avocado.git
$ cd avocado
$ python3 setup.py install
$ cd optional_plugins/varianter_yaml_to_mux
$ python3 setup.py install
$ cd ; git clone https://github.com/avocado-framework-tests/avocado-misc-tests.git
$ avocado run --max-parallel-tasks 1 avocado-misc-tests/memory/eatmemory.py


  [18090.387115] BUG: kernel NULL pointer dereference, address: 0000000000000498
  [18090.394899] #PF: supervisor read access in kernel mode
  [18090.400635] #PF: error_code(0x0000) - not-present page
  [18090.406370] PGD 0 P4D 0
  [18090.409192] Oops: 0000 [#1] PREEMPT SMP NOPTI
  [18090.414056] CPU: 71 PID: 919 Comm: kcompactd0 Kdump: loaded Not tainted 6.5.0-rc2-next-20230720-1689888179711 #1
  [18090.425417] Hardware name: AMD Corporation Speedway/Speedway, BIOS RSW1009C 07/27/2018
  [18090.434254] RIP: 0010:arch_tlbbatch_flush+0xcb/0x120
  [18090.439805] Code: 48 83 c2 3f 48 c1 ea 06 48 c1 e2 03 e8 6e 45 b6 00 65 ff 0d 1f 08 d9 4a 74 53 65 48 8b 04 25 40 1c 03 00 48 8b b8 e0 08 00 00 <48> 83 bf 98 04 00 00 00 75 25 5b 5d 41 5c 41 5d e9 f0 89 b7 00 fa
  [18090.460754] RSP: 0018:ffffb512ced83a90 EFLAGS: 00010286
  [18090.466585] RAX: ffff932c42698000 RBX: 0000000000000047 RCX: 0000000000000000
  [18090.474549] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  [18090.482513] RBP: ffff932c42698f58 R08: 0000000000000002 R09: 0000000000000000
  [18090.490477] R10: ffff932c42698f58 R11: 0000000000000002 R12: ffff92fbff1f1d80
  [18090.498441] R13: 0000000000000048 R14: ffffb512ced83c3c R15: ffffb512ced83cd8
  [18090.506406] FS:  0000000000000000(0000) GS:ffff92fbff1c0000(0000) knlGS:0000000000000000
  [18090.515438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [18090.521845] CR2: 0000000000000498 CR3: 000000807d236000 CR4: 00000000003506e0
  [18090.529801] Call Trace:
  [18090.532536]  <TASK>
  [18090.534883]  ? __die+0x24/0x70
  [18090.538288]  ? page_fault_oops+0x82/0x150
  [18090.542768]  ? exc_page_fault+0x69/0x150
  [18090.547151]  ? asm_exc_page_fault+0x26/0x30
  [18090.551827]  ? arch_tlbbatch_flush+0xcb/0x120
  [18090.556690]  try_to_unmap_flush+0x2e/0x40
  [18090.561170]  migrate_pages_batch+0x404/0x940
  [18090.565941]  ? __pfx_compaction_alloc+0x10/0x10
  [18090.571003]  ? __pfx_compaction_free+0x10/0x10
  [18090.575967]  migrate_pages_sync+0x98/0x240
  [18090.580541]  ? __pfx_compaction_alloc+0x10/0x10
  [18090.585598]  ? __pfx_compaction_free+0x10/0x10
  [18090.590561]  migrate_pages+0x3ba/0x4f0
  [18090.594748]  ? __pfx_compaction_alloc+0x10/0x10
  [18090.599805]  ? __pfx_compaction_free+0x10/0x10
  [18090.604769]  compact_zone+0x187/0x580
  [18090.608859]  proactive_compact_node+0x88/0xe0
  [18090.613722]  ? finish_wait+0x45/0x90
  [18090.617717]  kcompactd+0x366/0x3f0
  [18090.621514]  ? __pfx_autoremove_wake_function+0x10/0x10
  [18090.627350]  ? __pfx_kcompactd+0x10/0x10
  [18090.631727]  kthread+0xe6/0x120
  [18090.635237]  ? __pfx_kthread+0x10/0x10
  [18090.639413]  ret_from_fork+0x34/0x50
  [18090.643406]  ? __pfx_kthread+0x10/0x10
  [18090.647592]  ret_from_fork_asm+0x1b/0x30
  [18090.651975] RIP: 0000:0x0
  [18090.654907] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
  [18090.662195] RSP: 0000:0000000000000000 EFLAGS: 00000000 ORIG_RAX: 0000000000000000
  [18090.670647] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
  [18090.678612] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
  [18090.686576] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
  [18090.694541] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
  [18090.702505] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
  [18090.710471]  </TASK>
  [18090.712909] Modules linked in: dm_snapshot dm_bufio ext4 mbcache jbd2 raid0 tls loop snd_seq_dummy snd_hrtimer snd_seq snd_seq_device snd_timer snd soundcore nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink intel_rapl_msr intel_rapl_common amd64_edac edac_mce_amd vfat ipmi_ssif fat kvm_amd kvm acpi_ipmi irqbypass pcspkr acpi_cpufreq i2c_piix4 k10temp ipmi_si ipmi_devintf ipmi_msghandler joydev xfs libcrc32c crc32c_generic sd_mod sg ast nvme ahci drm_kms_helper nvme_core t10_pi i2c_algo_bit libahci drm_shmem_helper ixgbe crc64_rocksoft_generic mdio crc64_rocksoft crc32c_intel drm libata dca crc64 sp5100_tco dm_mirror dm_region_hash dm_log dm_mod fuse [last unloaded: torture]
  [18090.795116] CR2: 0000000000000498

Thanks & Regards,
Ayush Jain
