Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06614809E3D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573359AbjLHIfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573331AbjLHIfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:35:21 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D481724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:35:27 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B84PALO016297;
        Fri, 8 Dec 2023 08:35:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=date:from:to:cc:subject:message-id:references:content-type
        :in-reply-to:mime-version; s=PPS06212021; bh=0PS1qsjAyi7LAUUUwdL
        7u90c8gVHA7BVFt0QFU/t1Hc=; b=qYSUk+S6xMvo5uZOKv3lWznkex0GDeP3ree
        CU0+LJuGreUJ1S9mEjj5z1HSLgO5p4OuuzdwgMZgrKi8e+lRat0Kw48Uwz04/cMQ
        Q8T754gLI0l0xbFdLprUzmbSZhjsREsc4M1SCRxbB9LYHHA9n4CqpVj/X9dn/Z4w
        37ezUwixG84CsVW7/iGXYR7ZPofRxIzZB1H/lFjBWeXnt9Az8jHqRe13nabkuX72
        dp2mpM+snE3ywnjHT4MOzx+0A8Svb/cpVGnpoWAZyOFAmF50/506TCTCUZJXqSza
        YvbarWRk37SXy+1f1Bndr1gwvx74wB5stUCpNLCDuroD111UBJA==
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3utd53tn6j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Dec 2023 08:35:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev51ARw+G7yoRHPLiqjPXj1g2GZrn5W425TE216IYOlGsxcESr7b/Sn6lE7AisQBf1pElgaFsDCK8SRy9/vQYazGXGy9OJyOZaELbb2LnPE29tmqMNAsgoIJoC7wA4O5gapPcQpfUvMbXsqU7L5uvabECumQSQSL5OGIgfGcBOdfC4OLvIFyN7+McBucpXvXckxcXOzy0fnNiN1s3XjqUi76Y5q4HeuADc8oKDWbzuKlh5VriYlwHCjrqqF2mk0gg7yOOCtGAgLbAUq7duD2sSQBcC+z4KDo4faZjX1Ghwafg/J6kDPSmdH8zOZQljqS0cNlqjXfP43FFBCGauV/ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0PS1qsjAyi7LAUUUwdL7u90c8gVHA7BVFt0QFU/t1Hc=;
 b=ZET3yriHt1W9kaxulN7fN9ewdbuZeFaVYGypkk+Kajx8rr5Pm2UQbJE+aw+6x4Y225Drw7eOQycP/TI3wsbMqTxUvDpcxBUiRh63gU/oe1ivgJEdgMjlr8znLo1AiN9gRov3QyE+TV4I4PSlA1FU2i7QOQkgzfs5+8FOu61Aa28sGnDlVQdmkNoQ2ioJnw13fMVbBHvQmngQaSXNyYxvUVaS36gvPrhZ+jwtkWbL2CYNIlkQaqwbmUqHlzRPZTm6i7Lde6mVaZBA3JZ5gmrWK2f8M5LsEetm0whCEJBbeq7oqjynHaSOQ3GTLk16oiAL+IYJ8wzevSxxh1dSfLkjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA0PR11MB7378.namprd11.prod.outlook.com (2603:10b6:208:432::8)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 08:35:05 +0000
Received: from IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95]) by IA0PR11MB7378.namprd11.prod.outlook.com
 ([fe80::5548:b43c:f9ac:7b95%4]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 08:35:04 +0000
Date:   Fri, 8 Dec 2023 03:35:01 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        regressions@leemhuis.info, richard.purdie@linuxfoundation.org,
        regressions@lists.linux.dev
Subject: Re: [patch 0/2] x86/alternatives: Prevent crash in NOP optimizer
Message-ID: <ZXLVNeWBOWiauOjT@windriver.com>
References: <ZXCXc+BtnLzqMbFv@windriver.com>
 <ZUEgAAGDVqXz2Seo@windriver.com>
 <0adb772c-e8d2-4444-92b0-00cbfdaf1fac@leemhuis.info>
 <87r0k9ym0y.ffs@tglx>
 <20231207193859.961361261@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207193859.961361261@linutronix.de>
X-ClientProxiedBy: YT4PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::18) To IA0PR11MB7378.namprd11.prod.outlook.com
 (2603:10b6:208:432::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7378:EE_|SJ2PR11MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 816522d2-6513-4a39-1fc1-08dbf7c893c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F7rcS7Ec9oBbiRseiAND+e/c2TkBBMWSQB2VU58ZCiLfYm8MaDYv1d+lfIK9DBGgasZ/3oZcdsUlBl5NwcJvU4t6y5zDpyj13cl88oo/sG1U7DBDkFZX3gcf1eRlJl0b6WEvMiOZadLjYRZLSnR/O2GAvQukqc0Vw+U+794jonggxf1uOU0dknPWYvYjNlINfnplfeyXT/6itA0FNVZAcwMXYnuj2s8/p+cfrEm0XTKaTigOj109/aIRWdTjPDDpvVhnscyQF7FGFOgLTt86lsGILBmH0R+WZE3zBxYnQuOx4/Bwl3tcFuwa4hBYKc7Ec/9wYkj8UAfa0PwmIVFtNt3bbykI6u9s/i76fZpcl3EOVm9n9IkNHL9qoEjhxcQqlTxzv+T1fOI/fRdyDFWpgFeATo3UmRgbbjyPsz5NWsWfwWaIKR1r+gIu2ebNJz0XwRf2ocs1cGe95vULLcgMcahoiFhiUzGoEjhc8fTQrl5q71Rdtcuhq/mWq20eQY82yvKKJNfS1yT6Wr64JiNaYUp0/1VU9S6tX18I+CUN44P7Dq3UjUDYcWMvs3IznJYS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR11MB7378.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(376002)(346002)(366004)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(66946007)(38100700002)(86362001)(66556008)(66476007)(6916009)(6506007)(2616005)(26005)(83380400001)(36756003)(6666004)(41300700001)(6512007)(478600001)(6486002)(316002)(44832011)(4326008)(8936002)(8676002)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wnvtNRUMIuSe5B+FvzFKX2kEkkW/c2k8xLwEzZfIpIE/nsgRVVHTUGYLCUb1?=
 =?us-ascii?Q?CS4OhyaN7wya6e261/vI2b9x/IX/MaQa+Q7gfTb89+sTbB+yRXkcJxcVfMci?=
 =?us-ascii?Q?X5hEzHCWbORwrlwb9Ygh+qOHgP1LcWoyH3geciqj1Dum5Wrb2ZyCTCDGaYfr?=
 =?us-ascii?Q?dozqHTDwqkWWnifA15hb9RSe4H0qr2Aotqd/pIQB78wrEdHa3U2EVD/0rnV4?=
 =?us-ascii?Q?kdPKWlYdD+IQCEePM/uueQNjrGtL+uj0VstqyKFAHwglKx0E4IdmpI78Ss4m?=
 =?us-ascii?Q?6nF1ShyPhvk5tbSGrsmkAasdgmWaTg1X+TGz5eb2DGjArp+G7ZKzVTr/MeFI?=
 =?us-ascii?Q?CUOzep4eOM5ObN2DweI5aApfQisA+gO3J7fkhIbJYz62KZq6rK8uSTWxVnv3?=
 =?us-ascii?Q?dur54nVXyuKpePuc11D9BuCkNEYiHl6AXWWiaGK19PUa5uALSaXk8KmM2OiQ?=
 =?us-ascii?Q?LYAQMrROFmyI7RHsch2Dh1W/cshPjR0c4NM47kvhM3WfZutYUQm6dIfr1b6h?=
 =?us-ascii?Q?b3n0xqcOmI0CUR/cSXuOIGhJ3kwqRJbb9hSmhrrXw9B9mikDLUU9w4DDC5W8?=
 =?us-ascii?Q?gH6CPD4M9O3jb3uEZ+9OKFA094VT6zAmD62KUdangwHOteDQ+py3n+lYNaa9?=
 =?us-ascii?Q?zcfyWpxsqetCavr1To/Y+rcaueN/wLsRAMeKt7fw7Cq2UdUw/jtxJ/7kb6kd?=
 =?us-ascii?Q?TCNnG7h8iasIQcYBLgTGV7h9SjpM+crQx1HBQdWdjW2xrfXGO8aBN7fm4F5r?=
 =?us-ascii?Q?NZ9iKux6vN7pSVukW968gl0Z5kSRSuTtn8WS5rCNztnxCYb4T28xcvxwsw/C?=
 =?us-ascii?Q?xEd8SLoJcNzD2KcBfX4MivNPzchTLnXHAcx2Sewl8F/LN1yJzyM9Ler4rQCk?=
 =?us-ascii?Q?ta0JCTt6sxqn9YEX8kumlr7aFsmBrxtAP/eGZSde8DvGXD9zJssn5TWHZ8QH?=
 =?us-ascii?Q?CKteLWDwNGNGjNTfjiVpAxMRM5OneZwhtSAP3FMmIoVdP5z4DEZz1ysLQQpO?=
 =?us-ascii?Q?ewE5lJivLMxHxoO1qeLRGUJj3F2Qp07sl8+BCvxP1j8nrVxZgIFYUTMPrMXQ?=
 =?us-ascii?Q?NfhlY3mKejuzMCKMzuANYiAfkqzkwEH6a10EnbQKDWrkHfl/vSatGJdMm8nK?=
 =?us-ascii?Q?yJYV+zPTD9ERIpKV3Lb6c53ISeIvlGA1zRAqX9684humOXBrzl1kQhXlr3WY?=
 =?us-ascii?Q?57Ppj3lpO5a1tmZ06E958A4c1mwJjSU8YfpFsoWfSmsoMCwlATgQ3+YIEZ74?=
 =?us-ascii?Q?S910G9W36iVjlvFkXrQaLvHGC5R+kGbSyZhFHjU7HOIFBa5joENGY1z6x0RG?=
 =?us-ascii?Q?HeWHeW4qv0J1bf5tzyf42pEj+ZUfUuGffMrHI7xoyEAF9f2u23ffqEKuKO/D?=
 =?us-ascii?Q?BKRkiZbsENjF67l//pIrATF9z/tQDgDm8CpL6cBXD7ZsfBXulkthDhMDdXqk?=
 =?us-ascii?Q?x+HS7iZ1ACZ0qzaIGsPrEFOWbKIhlH9WGOXpfuuAKk9w1H7oMG7dubHu9wGG?=
 =?us-ascii?Q?8t7RdAu1zKDiK3hf3wLsdEUl0VxoplqdBJ7DUf7KJdVjXD6CQmqcRCgWIFNL?=
 =?us-ascii?Q?Dvy9zl2HM3/eGUtzX3k5xVEuE86bM+SVzrAv/gQyvVMPNqBuCLqXcmbKutxm?=
 =?us-ascii?Q?Zw=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 816522d2-6513-4a39-1fc1-08dbf7c893c1
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7378.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 08:35:04.8455
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hsIPFYoHVTxp8ZaKqE4mBxa1IvkIeUMyH7s9WyJsVQd0l23AJEAB3ymB6qVO2GPi74bywODM1pOwlbrQmrDyoXXDAVtLNWrTcS8vyBC66lo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-Proofpoint-GUID: SMh1aTmjfmDFYJvZ6dy4Dgcrg2iJcK1r
X-Proofpoint-ORIG-GUID: SMh1aTmjfmDFYJvZ6dy4Dgcrg2iJcK1r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 mlxlogscore=594 malwarescore=0 suspectscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312080070
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[[patch 0/2] x86/alternatives: Prevent crash in NOP optimizer] On 07/12/2023 (Thu 20:49) Thomas Gleixner wrote:

> The following series addresses the regression report from Paul on behalf of
> the yocto project. It turns out that the recent changes to alternatives
> opened a race window where interrupts are enabled and NOPs are optimized in
> place. An interrupt hitting into the modification will observe inconsistent
> text and crash and burn.
> 
> A 32bit QEMU crashes w/o these fixes reliably within about 50 boot
> attempts. With the fix applied it survived close to 600 attempts by
> now.

I can confirm that - since I was already set up for it, I let it run
overnight for about 1250 attempts.  With an average of one in 200 that I
was seeing before, I should have had around six fails.  Didn't see one.

> Thanks to Paul for providing all the information!

On behalf of Richard and myself, thanks for the complex fix.

Paul.
--

> 
> Thanks,
> 
> 	tglx
> 
> 
