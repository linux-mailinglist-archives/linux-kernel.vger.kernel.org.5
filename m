Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA12078BD8F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 06:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbjH2Epf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 00:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbjH2EpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 00:45:03 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2115.outbound.protection.outlook.com [40.107.96.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62510E;
        Mon, 28 Aug 2023 21:44:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbr7HDBtR0XA2kzMYFZF8ZgJ4FMkCW6vj7WzZ+n6rPww0d88xCOLYV0rWzQi9gpmLtzOQhXvCEYihi1m6io5QNjudEGKdrwJQakxWlwHyQloNf7fpT7egX3Jp9ZjeQYbpc/WPTpeWqBX9y5C+7FmSJkdpSdh7KD4A4Wv7fdXqJ/uYSiX+WlvgbqAj+MOMXbREenpSXR3FEiUsS5l2z/cPxMd3oxyTFTHZP8eKCrvRDElJ8rZMolJf47d/Nixd9yeQAW0fVm+ymqyGNyxI7h1MAUm9lQ6lkRZNNQaEpLiGN4joKaxWGODDJ4C3tm7vuAhD5e/gegmWTpZZJkuKwuxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0j8Mb4WPFtzlbQsRh4MNrqteqYGNY6tFffs45gC42dw=;
 b=ePML3e1c1UFPi1+KcFKbUXpanVqIVl/MTRs9c1pgHtlxTumqxVsCJumT4kyjZ+2Ef9wvx6+Ba5WgJIeaawQM1jKJ8EuaXZli8fChQjpXdG+YBoH0wFXLQXYmMBzBNRJb0fgGDz3+gvN/WDo34avfr5F5KinQhgl9CK+MCcHCuVYDtbgA4ec71VdzCNmv8/t9XFTd2rLPpQi8T5dWWtQJUa0VRZaUBIZhJfOpG/cnD4POou12ccn5Bn/KeDLZwmT0zzgcJ4gS8hXOY+u/Od0mUfOPvCZojTBoh3zKqpXu7YrH2JlMotiV+0B8chVmSG08cZst0QGWHxek2Ud530rDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0j8Mb4WPFtzlbQsRh4MNrqteqYGNY6tFffs45gC42dw=;
 b=an1XS6bZbSvPvIPN+VFGz1XPXY3u0hAC9F1IDQY5INNMm+kmqjhw3OdLEkPD1ZcHxLQVWVA1TqUqK+dijlUygyUSXWcrk1arMoxuFnVzISvTNahQZrdGi4xm46EDz9BkVsojKhztmqOeMrWvjn1aGuIOKzthg/6kbOC5QjKKgYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8062.prod.exchangelabs.com (2603:10b6:806:335::13) by
 SA1PR01MB6528.prod.exchangelabs.com (2603:10b6:806:188::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Tue, 29 Aug 2023 04:44:56 +0000
Received: from SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5]) by SA1PR01MB8062.prod.exchangelabs.com
 ([fe80::ecb8:39f9:1677:39c5%5]) with mapi id 15.20.6699.027; Tue, 29 Aug 2023
 04:44:56 +0000
Message-ID: <ed8cea4c-a261-60ca-f4e1-333ec73cca8f@os.amperecomputing.com>
Date:   Mon, 28 Aug 2023 21:44:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
From:   Steve Clevenger <scclevenger@os.amperecomputing.com>
Subject: About ARM64 Kernel Instruction Trace
Reply-To: scclevenger@os.amperecomputing.com
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Organization: Ampere Computing
Cc:     yang@os.amperecomputing.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:610:cd::10) To SA1PR01MB8062.prod.exchangelabs.com
 (2603:10b6:806:335::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8062:EE_|SA1PR01MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: b5edb1eb-ddc0-4733-c0d0-08dba84ab139
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q3+wPMRwL2HVe+mNlf8nKIa0Du5VukuQGyUau6gjhSMqNg9W11B7wy7NV9Tr3YA6E7Bq6hIT1e3WS5WEYwenOFVW/Fbj3Dbfj+xc7+RNPZaPRoZ5jFChzDykwEoxDKmSvtFxQPSD7pibVcbuOkmSd1st5GBRjvotiTteUTu44eC1bUuBnuz7FYDL0I31uNVB0e3R0lCOQbuNq/vkEab8R6RxWkxGcnxu1zIQD0lFjF0LkrAHQjdz3bTYNpIloJ1Xwm8O4jyU+u7o735FU6V6op3IUjvKLJ9dHvqj4HC9G7OnqsEJOzG69bRK8kqYvTmVmMO7j2Vl3L4F+KZhRiARlL9C6gOXDhgrZQvG/Z+N1EAXl2FmLSm38JCcYgGkI6pgVIC3989c9OmhEDvaLajGD0SkwQKciuB7WMVqJK+u5Zef/O2FU5e4D5YUWv0ci0WOwOW2O11hoSYcw7TkaZpGX0pEHg60ajOo4JWwVtXrqh0/YBNqZeEh9VYYGgG9O0Utgiy+9wAEQRdyzNz6gmYKrJwnm7p1FXDYheTD+MhCUQ6KawssUMFNpJg2/v82SKLcVUBh5NjL2cHf5qycgj631sSjbaIs00Rb0y3OUi0qMCgyRCfUOQxPnmjVP04kRSxq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8062.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39850400004)(186009)(451199024)(1800799009)(6512007)(6666004)(6486002)(6506007)(36916002)(478600001)(83380400001)(107886003)(26005)(2906002)(3450700001)(30864003)(2616005)(316002)(66476007)(66946007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(4326008)(38100700002)(86362001)(31696002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVFSeGVJTXJNY1hVN2lUTHdDRVRYNEdleWIyVExKUXp6c0VTSytwcjhhY0Jn?=
 =?utf-8?B?eWNVSlFBcFd5bmR2cUdpams3dldVQUZrd3VYTmx6SjhncStERDh5VTl4VVly?=
 =?utf-8?B?TmxqeHZKcG5uQWlVQXg0aHNqcUdBaElGYkFpekhCR3JZTXJIakVLOEpSR3Bl?=
 =?utf-8?B?RzY1R3diakpndnRoNXBIdHEyUklHc3ZNNEowZHR2akEvMkY2b2lwdWVRMmNw?=
 =?utf-8?B?UkU4aERRWHdvSUVaKzkyWndlQ2VMS3cxTXd6ZU1vL3dIN29uWTZzZFdTUmJK?=
 =?utf-8?B?SGRiMDF4V0FSZHFTclVvODJUM2pMRXpSQlB4U3QrUzdRSlNwbFZoU3JlN3V3?=
 =?utf-8?B?em1NNUlncnBPam1RdkNaUGdjU2FvMUlleDMrbHdmdlBXZWVCUjdteVg2UUFh?=
 =?utf-8?B?RVZPQUpCK1VDWVZMLzdrU1ptd096bEhyU0k2d1JZQ1JuMm9pRElmVjRHNXZ2?=
 =?utf-8?B?aGk4QzBOMml4SUNmVU8rYVFMaVE0Y3lTeUR4M0Q2L3NzWTVIZDg4aitFakZ2?=
 =?utf-8?B?RngxRkpFOS9tMkdvMVVQaHZJVVRSZkJHc0M2YTZ4NG1LTURCUWxOblpJSmN5?=
 =?utf-8?B?VnYycTA3bEVmTENEbGowZlNESDluR1M2ZTJJYXo3VUFUZkQvdXpQMFBPRlN4?=
 =?utf-8?B?TkEyU0t5SmhXWjM2S1dCRUZTVFM1TXVLdng2azIrVnMvNEcyNmtSR1NIRTV0?=
 =?utf-8?B?TzZMRFhobFIwaW54b056UTJWSjFYWWtwcEpoMHRGeHM3MEEzVlc2UnN5Risw?=
 =?utf-8?B?Yzk5YkxzZ09aYy94Y1dVcFJDbUlrd005OGY5YXBMMlhIWGRFWTdjNFZCNW9s?=
 =?utf-8?B?TW94eFFMR2lRMjIrcDcrMHlXSFJUZW45aHZoNDZwWS9GbkxER1M5RVhSTWJT?=
 =?utf-8?B?ZWRKSUx6UTE5SkhEUmVCZFJ2Q1FYZ3AzWFdLOENmaEtpdDRqdHZpRFBwQXN1?=
 =?utf-8?B?L1EyM2Rabk9EZ3dUOE9ZMjVCZzFvaklCNzhBUU9Fdzdic2h4WHlWL21FL0pq?=
 =?utf-8?B?VHJWQXJLTVM2QTFhYmlLdnhsaDUvVDZVOWFhWTMya3ZySFlNTzBYbnRNQmNP?=
 =?utf-8?B?NUVheVZCSVAzaW5JVnIrVGcxZlNhWmpzdlU0RnFWN253emhCTXA5dEJ4K2FE?=
 =?utf-8?B?ZW52aWdIMGhvOGl5c1lvZktsVmR0UFJjTW5PcmtiK1M2R0Q4ZnE2TzBDN1dM?=
 =?utf-8?B?VEw0TEVoYkpqd0pDS0pFWjZGNjFENDExY0w3dHhFQnhVUFdneVpEVjBHZTVk?=
 =?utf-8?B?aUlDb01iVGxsMHFHMUZIaHVXUVViRlM5elBxaUhHalBzMUNVZjlHY2k1RTA0?=
 =?utf-8?B?Y09CY01zWFN1V0JoM0MwU0JENERBTlVZK3p4UERlRVpodDU4bnJxT0hRWSti?=
 =?utf-8?B?SnJpbXI0U2tOUm9uK0xTRjgwelNWYzFYMS9kRjYwcmp2dXc1WUJWVkVPcEFC?=
 =?utf-8?B?eEJiTFUydkMwdUpRMFhISnU3VzBUcTU3Y1F6UzhFVnd1MlhTTFJucVBTU2Q0?=
 =?utf-8?B?M3UycnJZalJXUjBITUx3aWVCNURCV0F6eFN1NnJhYW1TMDlmNjdHaXRITitN?=
 =?utf-8?B?ZVFkanJHbGlUb3hxdFIxV3BNMHU1UVlZeEZKVEtBK1NxdFhTV3BMdFNGaUNp?=
 =?utf-8?B?RHNhdEU4c29XYU5LR1UwcTNCUGY4UGExS0JNaVovNGQ1Q3BoU1l0SWk0eDF3?=
 =?utf-8?B?NURCbFdYN2IzVkJWWHJNbWVpcE9ENTdnODRLNXQ0SXZBZ1MweUFNZEdjeVFy?=
 =?utf-8?B?QWpoczRtbjZyYnpQNmVtVlZBZFZPMElacUJZOGg5OHFQelJCM3pEN1B3dnBR?=
 =?utf-8?B?R0k2S3RBSkNNbjBVNDMrTXdpVWM3WWNCYzNEamo4d3J3bEVxZE9PcUVYaGxU?=
 =?utf-8?B?WEhMTVVvd09LMXhDU2h2cElFYXNDNStFcnBHdjhoRGZqdXc5Q1JYN1BmMFll?=
 =?utf-8?B?VUlJQ21YRkhvRXVvczQ4WTNMa1FzZGlmdkdZL2kzcG4rc2J6ck1NQ2ZnSEY5?=
 =?utf-8?B?WG1CMHZPUDlMNU9rbFdrSHduaG95cXdSMVVFcm1Va0d1RS9CVWM2YVhyb0xp?=
 =?utf-8?B?WEN6Y0llZHN3ZHNiT0twdkZTVk1oajdJVytsVjV5UVpxZlhJQmFCcTR6cmNQ?=
 =?utf-8?B?UE4zKzczV2ZTV1ZzM2tldGk2Uk1NTlpGRm03UEUrbEx4MUFndVhGNEJOSFZR?=
 =?utf-8?Q?tuTILMUHzz8lBTImYuWThi0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5edb1eb-ddc0-4733-c0d0-08dba84ab139
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8062.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2023 04:44:55.9358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ozftww4d5Kpw9qLKS+YbL8mPdruzswHnE5X4bDaXDQ988NMeUwMZvIjwHbwbARTrW7dRYRPPn/LPi4ls5+C2b8/r5ECFxJcgEKbl1tq/3QgXYLQh75V0anONUfg4RMnd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6528
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Ampere has been using the following command sequence to generate a 'perf
record' kernel instruction trace on an AmpereOne AARCH64 based systems
using a 6.3.0 Fedora distribution with CoreSight related patches.


[root@sut01sys-b212 kernel]# uname -a
Linux sut01sys-b212.scc-lab.amperecomputing.com 6.3.0-coresight-enabled+
#9 SMP PREEMPT_DYNAMIC Fri Jun 30 12:54:14 PDT 2023 aarch64 aarch64
aarch64 GNU/Linux
[root@sut01sys-b212 kernel]#
[root@sut01sys-b212 kernel]# timeout 45s perf record --kcore -o kcore -e
cs_etm/@tmc_etr63/k --per-thread taskset --cpu-list 15 dd if=/dev/zero
of=/dev/null
[ perf record: Woken up 41 times to write data ]
[ perf record: Captured and wrote 144.056 MB kcore ]
[root@sut01sys-b212 kernel]#
[root@sut01sys-b212 kernel]# ls -l ~/linux/vmlinux
-rwxr-xr-x. 1 root root 390426912 Jun 30 12:54 /home/stevec/linux/vmlinux*
[root@sut01sys-b212 kernel]#
[root@sut01sys-b212 kernel]# timeout 45s perf script --input
./kcore/data -s ../../scripts/arm-cs-trace-disasm.py -F
cpu,event,ip,addr,sym – -d objdump -k ~/linux/vmlinux > ./perf.itrace
[root@sut01sys-b212 kernel]#
[root@sut01sys-b212 kernel]# ls -l perf.itrace
-rw-r--r--. 1 root root  485834744 Jul 17 14:18 perf.itrace


The executive summary is the code sections in vmlinux do not match the
actual code executing on the target due to self-modifying code
(alternate code sequences) in the kernel image. These sequences are
typically applied over nop place-holder instructions. This was verified
by comparing a location in the ./drivers/char/mem.c read_zero objdump
instruction stream to the memory resident instructions captured with the
TRACE32 ETM instruction trace feature. This particular instruction trace
example shows a disconnect. It displays a ‘b    ffff800008ab8a70
<read_zero+0x168>’ instruction at address 0xffff800008ab89e8 which did
not branch. The actual instruction present at 0xffff800008ab89e8 is a ‘nop’.
        .
        .
        ffff800008ab89a8:       1400000d        b       ffff800008ab89dc
<read_zero+0xd4>
              dd  8774/8774  [0015]         0.000000000  read_zero+0xa0
        ffff800008ab89dc <read_zero+0xd4>:
        ffff800008ab89dc:       9248f840        and     x0, x2,
#0xff7fffffffffffff
        ffff800008ab89e0:       aa1403e1        mov     x1, x20
        ffff800008ab89e4:       9418b6fb        bl      ffff8000090e65d0
<__arch_clear_user>
              dd  8774/8774  [0015]         0.000000000  read_zero+0xdc
ffff8000090e65d0 <__arch_clear_user>:
        ffff8000090e65d0:       d503245f        bti     c
        ffff8000090e65d4:       8b010002        add     x2, x0, x1
        ffff8000090e65d8:       f1002021        subs    x1, x1, #0x8
        ffff8000090e65dc:       54000104        b.mi    ffff8000090e65fc
<__arch_clear_user+0x2c>  // b.first
        ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
        ffff8000090e65e4:       91002000        add     x0, x0, #0x8
        ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
        ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
<__arch_clear_user+0x10>  // b.pmore
              dd  8774/8774  [0015]         0.000000000
__arch_clear_user+0x1c
...vec/linux/arch/arm64/lib/clear_user.S   31         b.hi    1b
        ffff8000090e65e0 <__arch_clear_user+0x10>:
        ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
        ffff8000090e65e4:       91002000        add     x0, x0, #0x8
        ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
        ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
<__arch_clear_user+0x10>  // b.pmore
        .
        .
        ffff8000090e65f0:       f81f885f        sttr    xzr, [x2, #-8]
        ffff8000090e65f4:       d2800000        mov     x0, #0x0
               // #0
        ffff8000090e65f8:       d65f03c0        ret
              dd  8774/8774  [0015]         0.000000000
__arch_clear_user+0x28
...vec/linux/arch/arm64/lib/clear_user.S   34         ret
        ffff800008ab89e8 <read_zero+0xe0>:
        ffff800008ab89e8:       14000022        b       ffff800008ab8a70
<read_zero+0x168>
        ffff800008ab89ec:       d503201f        nop
             dd  8774/8774  [0015]         0.000000000  read_zero+0xe4
                        /home/stevec/linux/drivers/char/mem.c     521
             left = clear_user(buf + cleared, chunk);
        ffff800008ab8a18 <read_zero+0x110>:
        ffff800008ab8a18:       8b14035a        add     x26, x26, x20
        ffff800008ab8a1c:       b5000360        cbnz    x0,
ffff800008ab8a88 <read_zero+0x180>
        ffff800008ab8a20:       f9400320        ldr     x0, [x25]
        ffff800008ab8a24:       cb140273        sub     x19, x19, x20
        .
        .

Ostensibly, the ‘perf record –kcore’ option produces a representative
image of the kernel. But this option does not produce suitable output to
generate ARM64 kernel instruction trace. perf doesn’t disassemble ARM64,
so the arm-cs-trace-disasm.py python script is used with the native
objdump utility to provide ARM64 disassembly from CoreSight trace
capture. objdump itself requires an ELF/DWARF file image + symbols to
generate the symbolic (+ line information for mixed source) disassembly.
The linux vmlinux image + symbols file is typically used for this
purpose. The kallsyms file is not formatted for objdump use. As an
experiment, I patched the executable code sections in a local copy of
vmlinux with the corresponding executable code segments extracted from
the kcore image using an Ampere internal ELF patch utility.

This patch utility leverages the (MIT Licensed) ELFIO open source
library API. These were the commands.


[root@sut01sys-b212 kernel]# timeout 30s perf record --kcore -o kcore -e
cs_etm/@tmc_etr63/k --per-thread taskset --cpu-list 15 dd if=/dev/zero
of=/dev/null
[ perf record: Woken up 25 times to write data ]
[ perf record: Captured and wrote 88.053 MB kcore ]
[root@sut01sys-b212 kernel]#
[root@sut01sys-b212 kernel]# ls -l ~/linux/vmlinux
-rwxr-xr-x. 1 root root 390426912 Jun 30 12:54 /home/stevec/linux/vmlinux*
[root@sut01sys-b212 kernel]# cp ~/linux/vmlinux .
[root@sut01sys-b212 kernel]# patch-elf --help

patch-elf overlays the kernel image from a local copy of
'/proc/kcore' to the  corresponding (by address) ELF sections
in a local copy of the vmlinux ELF file.
A local '/proc/kcore' is created by:
    'perf report --kcore -e cs_etm/@tmc_etr1/k ...'
The local (patched) vmlinux copy is used by:
    'perf script -s arm-cs-trace-disasm.py ...'
See the CoreSight Hardware-Assisted Trace Application Note for
use of the 'perf report' and 'perf script' commands.

Usage: patch-elf <--verbose> kcore_file vmlinux_file
[root@sut01sys-b212 kernel]#
[root@sut01sys-b212 kernel]# patch-elf kcore/kcore_dir/kcore ./vmlinux
ELF File kcore Properties
ELF file class:     ELF64
ELF file encoding:  Little endian
Machine:            ARM AArch64
Type:               Core file
Number of segments: 3
Number of sections: 0

ELF File vmlinux Properties
ELF file class:     ELF64
ELF file encoding:  Little endian
Machine:            ARM AArch64
Type:               Shared object file
Number of segments: 3
Number of sections: 43

Patching section[ 2] ffff800008010000  17997936 bytes

Patching section[15] ffff800009a31000  20480 bytes

Patching section[16] ffff800009a40000  612372 bytes

Patching section[17] ffff800009ad5818  24752 bytes

[root@sut01sys-b212 kernel]# ls -l ./vmlinux
-rwxr-xr-x. 1 root root 390426908 Jul 19 11:14 ./vmlinux*
[root@sut01sys-b212 kernel]#
[root@sut01sys-b212 kernel]# timeout 45s perf script --input
./kcore/data -s ../../scripts/arm-cs-trace-disasm.py -F
cpu,event,ip,addr,sym – -d objdump -k ./vmlinux > ./perf.itrace
[root@sut01sys-b212 kernel]#
[root@sut01sys-b212 kernel]# ls -l perf.itrace
-rw-r--r--. 1 root root  32142060 Jul 19 11:18 perf.itrace

Here is the representative kernel instruction trace using a patched vmlinux.

        .
        .
        ffff800008ab89a8:       1400000d        b       ffff800008ab89dc
<read_zero+0xd4>
              dd  8774/8774  [0015]         0.000000000  read_zero+0xa0
        ffff800008ab89dc <read_zero+0xd4>:
        ffff800008ab89dc:       9248f840        and     x0, x2,
#0xff7fffffffffffff
        ffff800008ab89e0:       aa1403e1        mov     x1, x20
        ffff800008ab89e4:       9418b6fb        bl      ffff8000090e65d0
<__arch_clear_user>
              dd  8774/8774  [0015]         0.000000000  read_zero+0xdc
ffff8000090e65d0 <__arch_clear_user>:
        ffff8000090e65d0:       d503245f        bti     c
        ffff8000090e65d4:       8b010002        add     x2, x0, x1
        ffff8000090e65d8:       f1002021        subs    x1, x1, #0x8
        ffff8000090e65dc:       54000104        b.mi    ffff8000090e65fc
<__arch_clear_user+0x2c>  // b.first
        ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
        ffff8000090e65e4:       91002000        add     x0, x0, #0x8
        ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
        ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
<__arch_clear_user+0x10>  // b.pmore
              dd  8774/8774  [0015]         0.000000000
__arch_clear_user+0x1c
        ffff8000090e65e0 <__arch_clear_user+0x10>:
        ffff8000090e65e0:       f800081f        sttr    xzr, [x0]
        ffff8000090e65e4:       91002000        add     x0, x0, #0x8
        ffff8000090e65e8:       f1002021        subs    x1, x1, #0x8
        ffff8000090e65ec:       54ffffa8        b.hi    ffff8000090e65e0
<__arch_clear_user+0x10>  // b.pmore
        .
        .
        ffff8000090e65f0:       f81f885f        sttr    xzr, [x2, #-8]
        ffff8000090e65f4:       d2800000        mov     x0, #0x0
               // #0
        ffff8000090e65f8:       d65f03c0        ret
              dd  8774/8774  [0015]         0.000000000
__arch_clear_user+0x28
...vec/linux/arch/arm64/lib/clear_user.S   34         ret
        ffff800008ab89e8 <read_zero+0xe0>:
        ffff800008ab89e8:       d503201f        nop
        ffff800008ab89ec:       1400000b        b       ffff800008ab8a18
<read_zero+0x110>
              dd  8774/8774  [0015]         0.000000000  read_zero+0xe4
                         /home/stevec/linux/drivers/char/mem.c     521
              left = clear_user(buf + cleared, chunk);
        ffff800008ab8a18 <read_zero+0x110>:
        ffff800008ab8a18:       8b14035a        add     x26, x26, x20
        ffff800008ab8a1c:       b5000360        cbnz    x0,
ffff800008ab8a88 <read_zero+0x180>
        ffff800008ab8a20:       f9400320        ldr     x0, [x25]
        ffff800008ab8a24:       cb140273        sub     x19, x19, x20
        .
        .
        .

This begs the question what perf enhancements could be added to make
ARM64 kernel instruction trace easier to use? The process I’ve followed
is cumbersome, but could be done behind the scenes by perf. The caveat
is it requires a vmlinux which might not be available to an end user.
Here are 2 options.

1.	'perf report -kcore'could use the process I’ve used here
transparently in the background. The plus side is the objdump feature of
mixed disassembly is available based on the current vmlinux.

2.	'perf report -kcore' generates an ELF + symbols file based on
kallsyms (and/or System.map). No vmlinux patching, so intermixed source
and disassembly wouldn’t be available. It’s a reasonable alternative
without relying on vmlinux.

It makes sense performance-wise to use an ARM64 disassembler directly
through perf. perf-script use of the arm-cs-trace-disasm.py python
script can be slow. I’m unfamiliar with the Intel implementation, but
perf-annotate uses objdump. Unfortunately, I can't seem to get annotate
to work for me. A patch operation is still be required if vmlinux is used.

I suspect the CoreSight/perf communities are aware of these issues.
Is there any ongoing work not known to the outside world?

Thanks and regards,
Steve C.
