Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFE079A000
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 23:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjIJVAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 17:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbjIJVAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 17:00:09 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB332188;
        Sun, 10 Sep 2023 14:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6/gRd62TONDafMEhN/fKSetlrQoo1+f3VPmvLX/JXgXzkFGxvnasexaw64pXPplHebrQ3JnsCBT7v+XcbKakqQzprZWD0ydMmvP1yiVyIM3BR+lYckedtOc0qNcFGQUfuOUYX6l7QbNPHDj5ZmB+d756hsahOuDPhoDjQLiG8IxxNKGLEeoTUhVfSBi7RnrKRNJH6q5dQ1aeGNFZB3Km0h8HFMD5pJhONNyiY0dhRKisC7+GVgJSqUKB/CzzYTg1bdnhqLxr4S08rm9XVRSF/pKvSoFT22U8zAAX/eC1k+1Rcl5oPeRRBDNo0ngJSLImp8e1Bn55z2a0l4ELCNmnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+vxArbr3Unz7qptt1siecqOdL1FAGWhnv0s+FHpKbw=;
 b=kKWZR8C756GDvF4mEO8kBGrGSDQBJexl2C3NIh2YDBGnobN40GBJeigHZMAmR8eJdHQGtqmCLqHB+eHCvzCCQajrgst4C8dSQNt9MbXoJUdK5jIcAqZc7a4sJWhTMy7GLcTTyAXMf4NEa+Rw8vG4++vNeBO9PMui1vsSANXrixfaJQMbgQ664ILQwytQM6NoO0lE1Yt7aHEWDXKj74FBOuV75jyHzTiprXKgGuvpVeqqoqtiVa8SHjVYIoMF56QbdNAsH2pMMZGCJBOTdJ1gCss+OT6kQlFD1M/bYg4GlexP5PC4fByN9Z3ZgUrBfi/lf9JP5Bh3Y3LFcd+9t26TGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hofstaedtler.name; dmarc=pass action=none
 header.from=hofstaedtler.name; dkim=pass header.d=hofstaedtler.name; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hofstaedtler.name;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+vxArbr3Unz7qptt1siecqOdL1FAGWhnv0s+FHpKbw=;
 b=mNZqGgGg3+v82COM1EJ+5Vo36BS/zj4ZFE2RkbBnDbxwnZpgX0hWfmAlTmJ+36qCH4amHx/bW3SgTdOG65MS5pB2tqG02Z2DpE4ImneGJ2kZ6Rqgz2yrN/daTpAmqTfJz1THC3EPcXKaUQf4bMWAVyyV2MXqPkxVuStUDqs1rhIeg4xTCHjRqM7SsTcikwGp2b6dvJrppeDsyQvbFMQiTJN06hj5WkdBQNCBaF8mhgQl8L2Y1XRry0GT4eLGaAL7mjnedcnUZgXHYSuNFGWuRcMitCWI6e2LWmJnrmrVBw28mBAgFOS0koGNz4Fi5JOpxQDj8PwOX6CZrrctgA5Ptg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hofstaedtler.name;
Received: from GV1PR08MB8240.eurprd08.prod.outlook.com (2603:10a6:150:5d::17)
 by DB9PR08MB9754.eurprd08.prod.outlook.com (2603:10a6:10:45d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Sun, 10 Sep
 2023 21:00:00 +0000
Received: from GV1PR08MB8240.eurprd08.prod.outlook.com
 ([fe80::4077:cf22:280:8f67]) by GV1PR08MB8240.eurprd08.prod.outlook.com
 ([fe80::4077:cf22:280:8f67%3]) with mapi id 15.20.6768.029; Sun, 10 Sep 2023
 21:00:00 +0000
Date:   Sun, 10 Sep 2023 22:59:54 +0200
From:   Chris Hofstaedtler <chris@hofstaedtler.name>
To:     jiajie.ho@starfivetech.com
Cc:     aurelien@aurel32.net, conor.dooley@microchip.com,
        davidlt@rivosinc.com, herbert@gondor.apana.org.au, kernel@esmil.dk,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: RE: starfive crypto list_add corruption
Message-ID: <24laigwzjtx6scexj5otiesaolgytduhfp7ahqi7hvyhyc4fnv@vc2gqkxnp7v3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <292c90859f2e4135b40307d61488692c@EXMBX168.cuchost.com>
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To GV1PR08MB8240.eurprd08.prod.outlook.com
 (2603:10a6:150:5d::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR08MB8240:EE_|DB9PR08MB9754:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc98a23-5da5-439a-4ff4-08dbb240e4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qXirfbBa7/TVO4yNvj4qXW3maiGfs9urJYfuQnb5Bxg7fB/T/d2W7xmKs7tCfJWdAGXLxhx5gUmIREN5AyrF5961+fB/wQ6CQa8j0i2uF+PkcxMVAYJaw8ePJxsjZOMtiLxwfEHwqxTazrseEgdFbGd3ETPR6DpEw2orWUrn+JcnkbyJvr1iOt1/z3Ty4eH4mSFwOAYjTlweFWrAzjaXwus6CFHQTMHO4KRkK1MtMdUF6DPGkVLPC+wig+tP13oh9cf1XaMl+oQMaKS8DZ+faRrpiKmvGunptS7P+FMuucOef8GXctey2xdJhfkVcaNpaXGcd/bJkN/PtkFr94piBGwmAx8Tz8zE7bm/V0+UQcUrpx1FOZBoXsX/kqMsCOOh51XeMDhm5YC8g14iV7IfvMAE2G6wrYgnHY56BL3XgsbNyoqmIGXGLEEswC5ocAhVVLBj6OGl0t1yc1KLWCbBc9nASOXZPFAK6wX3Apre2zND+pF7VwqvVnYhZD/kQwF3EkZEaIAMb/jDOiZvOUXaRBocBwf0dweDvCWmiFEGLYub5DZAGO4RYwZ/yEKosON2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB8240.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(346002)(396003)(376002)(39830400003)(1800799009)(186009)(451199024)(6512007)(2906002)(83380400001)(6666004)(316002)(6486002)(66476007)(66556008)(6916009)(66946007)(6506007)(478600001)(5660300002)(45080400002)(8936002)(41300700001)(8676002)(4326008)(9686003)(33716001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0NDVG1sdWJ5d0pBeE5DT1RmMlhWdXhMZno4eUl6Y0laZWZkTzhMNDZBRVAx?=
 =?utf-8?B?WG80VFFIRFMyWEI3L2RkeWJxai9nWlhnMkNXYjJjeUlRdlNndkZ4TUQ3Uy96?=
 =?utf-8?B?bXFzYVBSNmRITVorMmpvcUhic1hrMENRdVZrWDZCT0NCdWZ2RnJ2aFFZV0hQ?=
 =?utf-8?B?cGpRMDBkdTZrSy9CUHI3RVNOd1NNb0taTkdHZGZpaDRRRU5mL0hmR3cxNHhq?=
 =?utf-8?B?NXl5eHhodjBERml4ZTAvck1oRjdjWG15OVdZbTU1TFFqbUplUmtwQ2h6eHhI?=
 =?utf-8?B?QllmOGNJcklKRFhFbitDc0k2VUJ0b1ZxNkZXZ0JENFJYVjhjWVovTkpHTks2?=
 =?utf-8?B?WkFka080SDFva213eThTY2tOWk0xRVluRk9kLzdRMlJZRXlJeHA2d2tHcjdW?=
 =?utf-8?B?NzNMNG5haTdndWROVEtFM3Nwb25tcmliMnU2M3hNeXE1ZnIvRVo5SktQZVRx?=
 =?utf-8?B?NmZxV1UyLzlJQlRGRlg2LzZqcEs3dHZZOXlHc0pmOUlPRCsxODRJb1pVUGZx?=
 =?utf-8?B?VCtLeDhWYVVHRS84ZkF2TCs2b0VLbHRMOWtHVmxpeDA2blA4MHRwR3lVTmpn?=
 =?utf-8?B?NWk0UjZvVzFKc21TRzhISnBKcFRZWWk5QzQ2bzJ0dXZQdUdXTGtqeWNNcDZD?=
 =?utf-8?B?QkdyM2ZBTlpmZS83MFhRTjJ0dG5YckpOekh2SkVUeUNDREpiU0pUTzlyQmsz?=
 =?utf-8?B?cGdsY3Q3SE5HTU1DSHNpeGJsbDFEQ2pyT1J4bS9UTEhwQVdadWRsZWVhVXNF?=
 =?utf-8?B?emlVZk0zQkx6dm83ekM3cTFLQkxzY0JyWHlMQXRocWRPU3IvT3JtT1hFQWxG?=
 =?utf-8?B?cXBiUVhMUGJSN2g5aUM4R2F6Q0l3YjM1c3NnaDdad0ZPU3F1dWtseWl2WWtV?=
 =?utf-8?B?MU9Uc3RUK1oyZDZOTVZIWERWT0VqTEFFdjJSbG05UWZSOE5vc0pmWGJac0NR?=
 =?utf-8?B?TW1UTEExNFMrUGdraVgvK1RnQzZxWTNxTEwyZlJONEloNlhxYzJWZHo4Vmg1?=
 =?utf-8?B?eWdlZnNsTUdSdmFMempwWGtQQk83NVRzRXBMdjdZdFdneVpjUmVWY1orWDJX?=
 =?utf-8?B?TEliemMvY1pZUDV2b0YxZmd1a285RmZxRFZiQm1CeEhWMTBXS1o1c3B3MytH?=
 =?utf-8?B?M0xSUlc3a2VjVU9DRGZYK2JsMjdScXVKUWRNbURqV3dsRVFveUZQeFo5eUhl?=
 =?utf-8?B?ckpBK2VPUnI4ZWVHZUo0OGQxdHlnaVFyZVBLWW1rY1FWOFNNSVdiUmhQN1lJ?=
 =?utf-8?B?RFFjUDY1R3pNZG9Ma3JHWnpGeFQrMGtjeExKbmx6Q3AzYWZ2dzJhbThZM2NQ?=
 =?utf-8?B?SjRROU5KWUtrRUl0TXRvQ20rRzRZSk14R0VqZHNvK3lheDlNSGx0TUdlME9V?=
 =?utf-8?B?Vk9qSy9TNUNVeGIzaTlvNlduY29IUmlmQnIyZCtOWFpxMDlRVVZwY3k3NFdP?=
 =?utf-8?B?aS80T3BXUi9HbEg1TDg0RUE2cGxmcXRHd24zeXZtOGQ0dENLNFdsYlV2OFBU?=
 =?utf-8?B?enJ5WlVGK2N1YmxVcERJM29LNDU1Z2VLenljU3ROckpVdlliL1QyL0pHNjZY?=
 =?utf-8?B?RE9wQXNOQ0hFcVlsQ01xT0xqNUEzOGVtQVl6TllXRzZxZ2UrUlQwMFFPVWtm?=
 =?utf-8?B?dWFBdXlDYmhZSDBaRnN5L3VGWG5aNUk3Ri9YbkpzNzY0dUpLa0M0OE5wcnRt?=
 =?utf-8?B?VVEwY0p5elFoZEh0d1Ard3lEZjVvOVVVa2x5QW5kQjVjaVdpcTFyWmwrSTJ2?=
 =?utf-8?B?UUpIOEtKbDU2QVd0dzBQbi90TWJTMzlnVmtIK1J4dlNBMWp1MkFWNjVXY1Nl?=
 =?utf-8?B?V0IzTVRQdHZrQ2JraTE5RDNSUUVMNEdvR0dUcjRpNFZnZForeGU0eDlzbmc0?=
 =?utf-8?B?U0loZHlVQVR0UzdOVE9rMkVES3dwclBGK0JYbHBQdTJJdjFtYUljc3FpSFpw?=
 =?utf-8?B?NWtXWDlDYS84TWJRT0J4QS9SdGJGVzNUZUEzM2pLZmlTVzVIcmtxOHNwbjdT?=
 =?utf-8?B?V1UwTVpkbllYZGdvb28zVy8yUUhueGVCOHBMS0oxYTQ4UnhHRmFkU2JDeUVa?=
 =?utf-8?B?VWVjNURsMHBvaktPd2lNMzR3QVVqSC9EUGNHUVMwOXc3ZENtSStENTYvcXhr?=
 =?utf-8?B?bkc1VTFWMjY5T1VqSkVBM3N4SGczWFZMbkdHV1lwRVNrQ2wzN2djbkhjV08v?=
 =?utf-8?B?bFZIMHE0b0p3MExxZEhRdkE5V3lkSDN0dm54SDFWZUlOMTg1UXpUWHFmZUpU?=
 =?utf-8?B?SzRtTUJHR2l5YTFYS1BuRUJPYktnPT0=?=
X-OriginatorOrg: hofstaedtler.name
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc98a23-5da5-439a-4ff4-08dbb240e4ed
X-MS-Exchange-CrossTenant-AuthSource: GV1PR08MB8240.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2023 20:59:59.9210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ad4ff4e5-1130-42af-8172-aee53dbb240d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QBhyDG9a6eFi9niuaqrz7Z3xt7A7cBjf0WP5/q7xyNywcAaR1P3vWBlqlMdGTzD56d72Sdv/4T2rtEqYfku+WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9754
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I got this issue, if I remember correctly, I fixed it by enabling
> > CONFIG_ARM_AMBA and CONFIG_AMBA_PL08X. It improved things a bit,

I still see the list_add corruption trace with CONFIG_ARM_AMBA and
CONFIG_AMBA_PL08X set:

[    3.528140] ------------[ cut here ]------------
[    3.528535] dwmmc_starfive 16020000.mmc: IDMAC supports 32-bit address mode.
[    3.532795] list_add corruption. next->prev should be prev (ffffffff816ec4d0), but was ffffffff80e33f38. (next=ffffffd8c0133c40).
[    3.539866] dwmmc_starfive 16020000.mmc: Using internal DMA controller.
[    3.551539] WARNING: CPU: 2 PID: 10 at lib/list_debug.c:27 __list_add_valid+0x8a/0xac
[    3.551564] Modules linked in:
[    3.551574] CPU: 2 PID: 10 Comm: kworker/u8:0 Not tainted 6.5.0zeha3-00072-g385eddf4e78f #6
[    3.551586] Hardware name: StarFive VisionFive 2 v1.2A (DT)
[    3.551592] Workqueue: events_unbound deferred_probe_work_func
[    3.551607] epc : __list_add_valid+0x8a/0xac
[    3.551618]  ra : __list_add_valid+0x8a/0xac
[    3.551628] epc : ffffffff804d21be ra : ffffffff804d21be sp : ffffffc80006bb50
[    3.551636]  gp : ffffffff81723980 tp : ffffffd8c0156780 t0 : 2000000000000000
[    3.551644]  t1 : 000000000000006c t2 : 206464615f747369 s0 : ffffffc80006bb60
[    3.551652]  s1 : ffffffd8c200ae40 a0 : 0000000000000075 a1 : 0000000000000018
[    3.551659]  a2 : 0000000000000010 a3 : 0000000000000000 a4 : 0000000000000000
[    3.551665]  a5 : 0000000000000000 a6 : ffffffd8c0242640 a7 : 0000000000000038
[    3.551672]  s2 : ffffffd8c0133c40 s3 : ffffffff816ec400 s4 : ffffffd8c00f7410
[    3.551680]  s5 : ffffffd8c200af30 s6 : ffffffff816ec4d0 s7 : ffffffd8c004c038
[    3.551687]  s8 : 0000000000000402 s9 : ffffffff80024be4 s10: 0000000000001000
[    3.551694]  s11: ffffffd8c008fc00 t3 : ffffffff81736f17 t4 : ffffffff81736f17
[    3.551701]  t5 : ffffffff81736f18 t6 : ffffffff81736f17
[    3.551707] status: 0000000200000120 badaddr: 0000000000000000 cause: 0000000000000003
[    3.551715] [<ffffffff804d21be>] __list_add_valid+0x8a/0xac
[    3.551727] [<ffffffff808672a8>] starfive_cryp_probe+0x184/0x3fa
[    3.551745] [<ffffffff8061fcfa>] platform_probe+0x4e/0x92
[    3.551759] [<ffffffff8061d96a>] really_probe+0x82/0x210
[    3.551770] [<ffffffff8061db54>] __driver_probe_device+0x5c/0xd0
[    3.551782] [<ffffffff8061dbf4>] driver_probe_device+0x2c/0xb0
[    3.551793] [<ffffffff8061dce6>] __device_attach_driver+0x6e/0x8e
[    3.551805] [<ffffffff8061bc66>] bus_for_each_drv+0x5c/0xb0
[    3.551816] [<ffffffff8061dfa4>] __device_attach+0x82/0x144
[    3.551827] [<ffffffff8061e1dc>] device_initial_probe+0xe/0x16
[    3.551839] [<ffffffff8061cb76>] bus_probe_device+0x86/0x88
[    3.551849] [<ffffffff8061d73c>] deferred_probe_work_func+0x86/0xbe
[    3.551861] [<ffffffff80024a0c>] process_one_work+0x162/0x284
[    3.551876] [<ffffffff80024cd2>] worker_thread+0x1a4/0x348
[    3.551889] [<ffffffff8002bde6>] kthread+0xc2/0xd6
[    3.551900] [<ffffffff8000336a>] ret_from_fork+0xa/0x1c
[    3.551913] ---[ end trace 0000000000000000 ]---

> > name: StarFive VisionFive 2 v1.2A (DT) epc : crypto_wait_for_test+0x8e/0x92
[..]
> I'll investigate this error.

I also see this panic:

[    3.558296] jh7110-crypto 16000000.crypto: will run requests pump with realtime priority
[    3.565961] dwmmc_starfive 16020000.mmc: Version ID is 290a
[    3.566016] dwmmc_starfive 16020000.mmc: DW MMC controller at irq 70,32 bit host data width,32 deep fifo
[    3.574329] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    3.577585] mmc_host mmc1: card is polling.
[    3.606327] Unable to handle kernel paging request at virtual address ffffffff800fab24
[    3.820748] Oops [#1]
[    3.823027] Modules linked in:
[    3.826090] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0zeha3-00072-g385eddf4e78f #6
[    3.832229] mmc_host mmc1: Bus speed (slot 0) = 49500000Hz (slot req 400000Hz, actual 399193HZ div = 62)
[    3.835566] Hardware name: StarFive VisionFive 2 v1.2A (DT)
[    3.850595] epc : starfive_rsa_enc_core+0x30/0x116
[    3.855402]  ra : starfive_rsa_enc+0x5e/0xbc
[    3.859679] epc : ffffffff8086937a ra : ffffffff808694be sp : ffffffc800023910
[    3.866898]  gp : ffffffff81723980 tp : ffffffd8c0150000 t0 : ffffffd8c22380c8
[    3.874117]  t1 : 0000000000000000 t2 : 472f9351d07df710 s0 : ffffffc800023960
[    3.881335]  s1 : ffffffd8c013ea80 a0 : ffffffd8c013ea80 a1 : 0000000000000001
[    3.888553]  a2 : 0000010000000000 a3 : ffffffd8c0133c40 a4 : 0000000000000002
[    3.895770]  a5 : ffffffff800fab24 a6 : ffffffd8ff1d6d90 a7 : 0000000000000000
[    3.902988]  s2 : ffffffd8c013ea40 s3 : ffffffd8c2238180 s4 : 0000000000000001
[    3.910206]  s5 : ffffffd8c22380b0 s6 : ffffffd8c0133c40 s7 : 00000000000002a8
[    3.917425]  s8 : ffffffff8114c240 s9 : 000000001f030000 s10: 0000000000000001
[    3.924642]  s11: ffffffd8c0048300 t3 : 0a1255840a4b7df8 t4 : 28fc2f2b1f3b4e7d
[    3.931861]  t5 : e2bb8080e13469b3 t6 : ffffffd8c2238440
[    3.937170] status: 0000000200000120 badaddr: ffffffff800fab24 cause: 000000000000000f
[    3.945083] [<ffffffff8086937a>] starfive_rsa_enc_core+0x30/0x116
[    3.951183] [<ffffffff808694be>] starfive_rsa_enc+0x5e/0xbc
[    3.956762] [<ffffffff8045edc4>] pkcs1pad_verify+0xb2/0xea
[    3.962256] [<ffffffff8045e21a>] crypto_sig_verify+0xa2/0xd0
[    3.967919] [<ffffffff8047e8c0>] public_key_verify_signature+0x168/0x1d2
[    3.974625] [<ffffffff80480018>] x509_check_for_self_signed+0x58/0xa0
[    3.981071] [<ffffffff8047f486>] x509_cert_parse+0x148/0x19e
[    3.986735] [<ffffffff8047fd08>] x509_key_preparse+0x20/0x18c
[    3.992485] [<ffffffff8047d8b4>] asymmetric_key_preparse+0x52/0x86
[    3.998668] [<ffffffff8044fcb8>] __key_create_or_update+0x16c/0x372
[    4.004941] [<ffffffff8044fecc>] key_create_or_update+0xe/0x16
[    4.010780] [<ffffffff8047fc78>] x509_load_certificate_list+0x86/0xf6
[    4.017226] [<ffffffff80c3a59a>] regulatory_init_db+0x92/0x124
[    4.023068] [<ffffffff800020f0>] do_one_initcall+0x38/0x17c
[    4.028646] [<ffffffff80c00f1c>] kernel_init_freeable+0x1a2/0x204
[    4.034749] [<ffffffff80bb4b56>] kernel_init+0x1e/0x10a
[    4.039979] [<ffffffff8000336a>] ret_from_fork+0xa/0x1c
[    4.045218] Code: 0205 84aa 8a2e 000f 0140 3783 030b 4709 8793 4007 (c398) 2783 
[    4.052715] ---[ end trace 0000000000000000 ]---
[    4.057339] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.064990] SMP: stopping secondary CPUs
[    4.068927] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Maybe this can also be investigated.

Thanks,
Chris

