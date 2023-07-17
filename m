Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BB7563C8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 15:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbjGQNFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 09:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbjGQNFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 09:05:07 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2091.outbound.protection.outlook.com [40.107.22.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9AAA1;
        Mon, 17 Jul 2023 06:05:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVRpXG5bYB9NPymttIfhw0wloG/zj/oWWZGPAPZRHd48aVzMqdU+TpGDP7u12MBnOUQDUTuaA+paqv0DuMvBKJ76zE7Cuf/dd/X3A6c3VgINTvPz7qVhHFAtCC7Gjm/7rZDFF62UtzKmd+HpUIVEETmeVBBtriHa9UMOxLzoApAjwheOsU/ajt72d7cNeFd94eitL9OVaJnnmEDoNvVGJTR0mSYRhqcueylvZ+awXwecVd8yz3RxCGHz3b+40vX5DlPCY4mbxmiLAHiZ0iBnTKSBoEenNZLFS3VS0CKl12SFqBUpvxXSdoXdNatD6tRnIiWG1n8GFBfQR+In9CnQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/nxbBVxZ0JTCHQeEmKNgIXdLj2KNV5YKgJOIaDJkcI=;
 b=gKhsVkU7SYKocQk18fnJBbJ9USRdPsd1yK0da40v7ilzgI2cIIK64U+2XycAZorBOUqUTh4c6vlcYy+d8MNo1SaigqXU98LCfcT/iyxknwsqpN+XqK97oeV3cMkjf0r0qMIfB1ercQFsK5aaKGMlc9dPKGT0troky9fcUEY2fBllw+8YK2deBg30WuHnirqzr6F4dwbRquHM8TJrXzI75n3F3B8ZZDOe4PSee4/gbESHXXwAnL/K3FiCgdj7p42mjeqIRt2n0UbukzfkxGCYohm+D3oKOUjepSI0KPdSh9mrRWoz5OiFBu2oSBteyd8HaUMHe7W6WROpjZxKOl98og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cvut.cz; dmarc=pass action=none header.from=cvut.cz; dkim=pass
 header.d=cvut.cz; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cvut.cz; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/nxbBVxZ0JTCHQeEmKNgIXdLj2KNV5YKgJOIaDJkcI=;
 b=zyQqUpWPw52OQnIfGNw4XFwDGjIg6gCs+7uE/vnX2viukE0JJ64cqoDuNDGtilfzTzzxFtt/SaGgIN3IW35aVm7Oj6jpFMYWKjYBYdQjI6WGKJq/A97EBd5HeFz5+ONrKmMSeOQ2xosHlV3sg7cb1KGcHz/Hg5RVCUMrw88RSzYetYf7MD5xdkvSBdoNK1mgYGVUhVqOit9Uh66Aps3zuC8OAh39vSFKDFcC9/6ere2QuK+nVVVjVPP5xRR0RECVoSd1i+3UXxBa769ql0fJ6UnsqPET3TW9wAa+/DKiShR8fMQ8F0Q2O8fflft1FM7RdAHG36iVWSEMsS7in+lAQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cvut.cz;
Received: from AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32) by DB9PR06MB8791.eurprd06.prod.outlook.com
 (2603:10a6:10:4c1::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 13:05:03 +0000
Received: from AM6PR0602MB3749.eurprd06.prod.outlook.com
 ([fe80::ae5:23c0:ec83:bedf]) by AM6PR0602MB3749.eurprd06.prod.outlook.com
 ([fe80::ae5:23c0:ec83:bedf%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 13:05:03 +0000
From:   Michal Sojka <michal.sojka@cvut.cz>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Maxime Jayat <maxime.jayat@mobile-devices.fr>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Dae R. Jeong" <threeearcat@gmail.com>,
        Hillf Danton <hdanton@sina.com>
Subject: Re: can: isotp: epoll breaks isotp_sendmsg
In-Reply-To: <20230717-disbelief-catalyst-bcff471e0433-mkl@pengutronix.de>
References: <11328958-453f-447f-9af8-3b5824dfb041@munic.io>
 <87cz1czihl.fsf@steelpick.2x.cz>
 <20230717-disbelief-catalyst-bcff471e0433-mkl@pengutronix.de>
Date:   Mon, 17 Jul 2023 15:05:01 +0200
Message-ID: <875y6ielj6.fsf@steelpick.2x.cz>
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0154.eurprd07.prod.outlook.com
 (2603:10a6:802:16::41) To AM6PR0602MB3749.eurprd06.prod.outlook.com
 (2603:10a6:209:1e::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR0602MB3749:EE_|DB9PR06MB8791:EE_
X-MS-Office365-Filtering-Correlation-Id: 0922f283-4468-4b9b-4be1-08db86c66f3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GZ3Aw2pgJznDdwdv+avnO5dUPQnFF3D4muMPCQWCkFkb5j7q1F8RGcrKgC/tDobpPexnckSP/EHuVmTEFXNHP/0R5yc9ECmwVcrL6/cCGFZwomEpLlllV3ljMfmkR+CtqDYz1n7YhaQgDQouq4+pPYZ1Hn0f3kJSJsi9T13ZON0pg8Y/UkMiAG/eW2eDWeWoG1z3cuwUiOOLGSm4RIibbuds68R65ze8B93fu8d+Zt+gI0UM7qRYVKkLcbz41ULkSM+FCabhIygFNNAk8MsewHvHnFL1xxQg+gE62LbOKwrLWT7FePSTtN0+7+MkAJ1obTswjCnAc6jvnOiWeJ9s8lttrUdBrzR/FNAZi/GpdfwRM7hQqOlGNd50kWqe/xr+lzeLy4Mbi2Gmxt7s9CcvtBCl/zZmRsU/ITzXtsFCNOvsuKol9j0jAEr09AnCigcYJ4v4QiyKmgoa1IFrRmgxYaGuWStPZVX2l8l2bTTFG6GVGmLOgIpy3+icY0ca3M09myRz/VbRQ4t+1JA3SSy4VvVjQlShPxjgT6oZnzlRB2/o7jXX33vpanJkfCCA/KK2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR0602MB3749.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39850400004)(366004)(136003)(376002)(451199021)(54906003)(38100700002)(6486002)(41300700001)(8676002)(8936002)(478600001)(5660300002)(66476007)(316002)(4326008)(66946007)(66556008)(6916009)(786003)(186003)(6512007)(6506007)(26005)(9686003)(86362001)(558084003)(44832011)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NnxmjIc55U69rt9mS7mUWHsDvCnYrzjQXVHlSxcFVbw7LtgNQbsskrmGv5Rm?=
 =?us-ascii?Q?eiyPeYcKYVauWj+3TXFArJ3QvToyU8lajSHYxo3/o31cPncL0Jvefci0lJFN?=
 =?us-ascii?Q?JvqSaz2M38M4CMwhGoXRUWOIn+SKwstHAMdLsl1xfsibB0nespcWQ+X+Gx7S?=
 =?us-ascii?Q?cAS+WUVY8rweuU0AUrOqAxkWaCucUwJt+zQCe+9+U2FuxwJ0x1l0aryuomYF?=
 =?us-ascii?Q?D/wHPyGgNt+LBfqra7xIJXulRmXaQqjR11HhnP651wInDY5Tk4pBjuwdA842?=
 =?us-ascii?Q?m4HDODGTSx/PEq4eSIv5Q/WeZAAvqEtawWdAN3KM/vbkrCftz2hw71dfZjnG?=
 =?us-ascii?Q?4BIiJRdjqdVVuo0O5x6GrL42rZH+DBmjx2DJ/t3oKAtJFkRkLp+bAsJYQNt4?=
 =?us-ascii?Q?/u352sf8UFrjukk5+W4f+9Lmwynx6yUAgTRexHU2+GDFw65M5/8IyGAv7RSx?=
 =?us-ascii?Q?ERqb32aJaaAN+39imd/kDsSkSD4w4OCObU8nXnnWFbibbGtfjCmAdHeFeVFX?=
 =?us-ascii?Q?w5gGumnPup/BLDnxCTOHRXgycc8VEkn4B+FSKAOqP5soYoYOofuit1UbRTs4?=
 =?us-ascii?Q?eryZo6J+Klp/842lFCLhLoTK1qys9q1BLAACeeRx3hhgL1kWC1TFGWA0DMhg?=
 =?us-ascii?Q?Jdk3suaFMsP+9SBlTDGvItSYcLsbV4n6LzFL8/McTZNRkzBKqnYaqaYjk3AV?=
 =?us-ascii?Q?H5UhdA+rq9EYUAWQjjsx6J6xMCPurVdPZZFfxtOrnPtlyCqkdQxUU5WLrgBd?=
 =?us-ascii?Q?EPsO2nU5quTpkJhpslgQ+nLMQaj5UezQSQczBm91Dhn9VuTGX1mGXDkn/fOl?=
 =?us-ascii?Q?LBws69/ncLiOFltK9Mz7giQrWakUvHjN0zkqMr8NoE1ExZXFVRk+Vig0Lmig?=
 =?us-ascii?Q?FIgE1CrPEjJFu115LiG8ce8HvPuJz5r7VjYHS2yftXdnJJqeGCpMU+0QRBNp?=
 =?us-ascii?Q?CDbD1qQBK8YjtbkrV+hl2IjtOGyvxKx7e/J1v9uYw+dbdErqGxbguREoNPGn?=
 =?us-ascii?Q?s8B5xln2m4qbqERW6ltEf2Nsz2F6YXhoNluuiz621CMwHozAQzmUxjE87F0G?=
 =?us-ascii?Q?khXLA7skEk/xarhlxhZTVIUT8a1i5TRBrYHvwJF2y1C8fonN2aVG5u3bWmR1?=
 =?us-ascii?Q?eHUybpA4exfngjxX4AFSZKT+l45s0A9SDUHUjhoe82xpEaDggbey8cME7c1K?=
 =?us-ascii?Q?xnBNTED+3kGvZ952JyLtm9IQPh1tlL05/mrTdGs6t4nDdst2m5mqneUD4BPa?=
 =?us-ascii?Q?fHIZGkM1ngHTGBk+g/uh2zncAdVl3H+HZ4wUhq4jjL7PQmGmZpXVxgbZ5bPz?=
 =?us-ascii?Q?sU5O2x5IcrAlu67Ygg2vAuZgyucuE/UEUz9Gx5iiYPfdHzC3EciH6DGeWZDw?=
 =?us-ascii?Q?I62rHRwucwGtnWE9Pl4LBc7R9CI9zs1fzLXvfn3zRyizvbYZoAWk5KPOz1jE?=
 =?us-ascii?Q?paC06HPhVJnSxa3t2oI0tBdes9b8/3TBUOUTc+XyzO4KahVAqyL34vXYmA9v?=
 =?us-ascii?Q?3gAMxtPCX0/V/oGp9OqOaXZtMDLryvWVb5Jz9v6ASVZPIqwhi5e1rtVpOOQN?=
 =?us-ascii?Q?kn5m57ByKh3xinwrJfQ=3D?=
X-OriginatorOrg: cvut.cz
X-MS-Exchange-CrossTenant-Network-Message-Id: 0922f283-4468-4b9b-4be1-08db86c66f3c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR0602MB3749.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 13:05:03.2085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f345c406-5268-43b0-b19f-5862fa6833f8
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KF1V6J+i0Da7rK1Fk8oK9RA0j+yBzmZZdxtRrz6ZtlerQrlF5I3MyThZsQW726II
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8791
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17 2023, Marc Kleine-Budde wrote:
> Any progress on this issue?

I was on the vacation until today. Hope to look at it soon.

-Michal
