Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF647834A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjHUVIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjHUVIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:08:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3950112F;
        Mon, 21 Aug 2023 14:07:59 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxkMK023994;
        Mon, 21 Aug 2023 21:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=F0OpCzTNRn9LT30qLIwKPFidzwxco8p9pN5GBaND9uI=;
 b=O6pFlD/UQmP0WHrzcRX8cebi0BmKjdRwNflM6jTfXPJR5Q9YMCi5aUKrlCNpXJNZIW4p
 jLJkPG0+qE75y5UVZgtnC7At1xe0/6L8QBt5Y5K4p1LXGiQWqKVaJjcTVb+r2+45yNga
 s07HHpJ6YkfjbsBqQJ4cgT0Lzjhu+DfEOwgdqfmEfT7kxXOWsyn1tOBfT3SznggaU0tj
 ZzZ4vfX1p2wtyoSJtgS2NDBNzs0WO9E9TMLxhlRWgXfgbvJLatrIp3SenrHe38VXMAZB
 sY2hlW0XFjRb/QJReWhZVhvqjRBziOmgLsFfxkSA8RNYamU4ZfePrD9+Y5QQZqF1hB06 AQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnma3tu7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 21:02:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LK6f4e017692;
        Mon, 21 Aug 2023 21:02:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6afng0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 21:02:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3rZCG+0epootKxd0QT2WMKIlwEbC/5TKo6Qew3i/nATLFt3vfmMS5JiRi2+AYr9QyLfkZ16qPwVxPdA8ZpLtuE51XC85MfRGdHotZOLvj0UivNCndR8EO/mhoUpuq5D0JMQvlpvx2WTb50H931rfGJ79fROHquXRzC4hvXbsX6I5g/PurDnK/GuO+t2xJsHQclnwVu2T8HIOcnaRY5FM+cLN5STphAxwmMjmW4JC0MAoFBvBaMKGaYF6XHJ1GrXdlbAPd4a3GKJybYGRIvJ95uSdDyU8z2S1gMbXK7tRk6ZyL9Vnn/8dq99KCqptw7SeSixJpTYFoDRfjwRNTqlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F0OpCzTNRn9LT30qLIwKPFidzwxco8p9pN5GBaND9uI=;
 b=LWnHqZAq8Mnw3DM0p4bVtalluwr+ticBDib7Xx7nzJGpw6ZorclutUSyQtZHJDXgQlzFyX72pDNT6Xi6CVq9APvsyk8fClFEzHN1fYQLP03GagV6n9GPplyDUfiilx1tlBANgE2LU1Hf8NcPtjVRpBRQMB7opWVKBz5FvpU5/bKCydMQiRkW0lR2eVk6JymngyItZgnCdX7DJfbi01LADdxin62TNbL7Ex5RIa/BhPms9gdMMxyfptEpacqZcoM9VQMI8p/+d9/GoFJFVy5nTBoWbj3o2UgMuX5zJBH+5ARZdbbftgnyCWNBa6kuki/npFiwrbGBK/nqp5px1/9RKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0OpCzTNRn9LT30qLIwKPFidzwxco8p9pN5GBaND9uI=;
 b=DIob9u6LYkYKeSXayX2lM+YpxZM1Fxbe/oCePapDvDvTVJHBKCOKOpICLFfACp1Ivq02AgD3nl4qjWgUUz+FLZ+2RJ8i1LbReYRJR061vMGoZlG1xrmbwpYmVRtrUScLyOsSDTvIcQKHmlCEp6hM/kkjSQ0f+xB6IM8g5OMuVX0=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB5773.namprd10.prod.outlook.com (2603:10b6:303:18d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 21:02:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 21:02:43 +0000
To:     Chengfeng Ye <dg573847474@gmail.com>
Cc:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        bigeasy@linutronix.de, dave@stgolabs.net, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6os6rdl.fsf@ca-mkp.ca.oracle.com>
References: <20230817074708.7509-1-dg573847474@gmail.com>
Date:   Mon, 21 Aug 2023 17:02:41 -0400
In-Reply-To: <20230817074708.7509-1-dg573847474@gmail.com> (Chengfeng Ye's
        message of "Thu, 17 Aug 2023 07:47:08 +0000")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0055.namprd05.prod.outlook.com
 (2603:10b6:a03:74::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB5773:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f60d9e4-b5a4-440f-2039-08dba289f6b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uNNM00XvlpRmkLdEFJIO1TKGuGJ2HHXgUA8ywzo1fmGDqmHf9ka6Eg+64ojfc2MxYLGapLOj4H7sldJHnwUWfCw3rX6yXtemb8tLX+jsosWzYFz0G+lJnsAYaiSs/fxnX6FViUrpkWcuT4LsYyeV7yT24twVamnmA7a6c3QlbPR2UNK1rIt6FGXPFz86V1064v2M1GcGaOuxMzn7YrjesSBaIfDeyTNva46KoqY2/xdmGvIMe5wY0ErR0uWpXEnZKyku3bIu4pIsug/ykGTQUmqTDTp+ZumsEcXbUYiHXO8fjMC+iS3TW1iS+0GBpJbsg//u8eEaOf4/cHZafan6oUqvLlcHzah3rWmGGqnDj46CC4Lj0OnjrB8Eh9XYE4YDwrD1uPYJ/Z4HAJracjeIafvH8aVaU1BTrxraNh6RrAkgQ81EO0Xp0S0p7SFHjdzjKU+xGrh+A+hz4s/ftWdMuziwaRsGSVkOo9ed36qJP5YpyCLeBHgXbwh+ja9GJuT3FpYyv4HOQOH/PvQ73qB2KPqStjpUt1IAR4O1J9T19T14gtESw0S7ETUW1GQCkskw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(4326008)(41300700001)(478600001)(38100700002)(36916002)(6506007)(6486002)(83380400001)(4744005)(2906002)(7416002)(86362001)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6MOjIBm+ryvJG+GCvNnBntbd98W9PRemA3XYn0t5Nk1lgG8uJh5nukQDPqTn?=
 =?us-ascii?Q?20X8t8nad3mo6PjkSx61PVxDagZgb6O3fMnxb4zqbhSJspxAXsSRjFfGFTso?=
 =?us-ascii?Q?9xSiCGnAHaayR8rnMy9MGARCnUFfTSeHBDWmKQ7TA4we+SQzhy+Im/JL0AJx?=
 =?us-ascii?Q?yeFHpimZbKtQp2EMQIo3GtyI4vpf/LhJ5ZeneD/7pFZsHUFskq7Yuzt6kb5i?=
 =?us-ascii?Q?c/xwtSBM62dcxzm5WRqaNT3NHMlKu5Gm9zT1N7Syh36NubFMKgXR+rBaa6ol?=
 =?us-ascii?Q?L8qm2f0O8INGLKtdDXlSweGTuzmg+qhFlPL85BkqTKhG0cK5kQRrdYu+UdUP?=
 =?us-ascii?Q?C8IVqLhVSmsVEDuSO5JlWYCc9wKXu2N1aWcU/xXXCGoDP0KCMUy+JZNipCce?=
 =?us-ascii?Q?3Z+mE67WFq8Z6NhIs5tFtH93r1MnZaUmid8rN449XIr+786324liDbWtmeb5?=
 =?us-ascii?Q?RfahN0KYIg+Q6ybxSxnzjhNL9ol+ey53TIfmqzx7mcqEuH/ynCIrm8jZUyvG?=
 =?us-ascii?Q?eEGHM92DDIyBYnaTzI3Su2FGt/z7CaT6tA3FFkY0rTstoPtuaegFJYnHxSj3?=
 =?us-ascii?Q?Tqc4s5xRYrC62W4NV+fpGGzUflAVlYrXFv7jmg+/v6llV06vjos3jRa5nCNU?=
 =?us-ascii?Q?4YosihR5lctz8zP4GZX+LUdjl+q/tWoWcx+z4tV0GDKtvrEEGPTbu07jgoET?=
 =?us-ascii?Q?2KACUHCvWg4wcQfBJW6Vy5w1/5yEhL3qprBnGNiGh++uFY8+n4sZO3RyXEkb?=
 =?us-ascii?Q?hGw4Rr6EoHL6TC/0jKzeh9BYTvNPrLcQc73Hl/svO8rToL2uOywouNWyuBcb?=
 =?us-ascii?Q?dkjHJ2MDje/NBNwM4koDKCANUXROqPOa8rkdPf0o1zOe0DyPrlcVcl7mNNwH?=
 =?us-ascii?Q?qgEcF/dZHdRPQdeTzhJw92HGbdFA2p0g2AB4vJvajB9BI1xot/ppdMDR64bG?=
 =?us-ascii?Q?rAcLNtZ3bZWHbhipLAbgBXYLJ1APZK6adn4cWcnfNmXpyYPvh/LfERcqdTX/?=
 =?us-ascii?Q?TRhasPFfQHb+mMBDDKpoR9UPd7LPedDvitpb1SvHoKNBEOayVmhvJuqq/Inv?=
 =?us-ascii?Q?2i0Yg6tQfpjn6mCMaCXKYOAxjB4zzOLQZ6G9rh2cmAk2gNC2WGqsVBqm/Adc?=
 =?us-ascii?Q?LIQaZ+IWvBA8IxfrkcCP5zzDwKBrzjeuwmWqCAsCWvwAanPbilg4GQTPG72i?=
 =?us-ascii?Q?Dh7beK232ctStv1UUpWXBnsI1488RB5Qh8HgVuR2NoZDkc//X2QDdqpt7odo?=
 =?us-ascii?Q?mSHXYAqyh9Qa7w9KD4kaUiY9KbpmnOpX6Bp8OhHeIgU7NkKCZuyUZOaRufw1?=
 =?us-ascii?Q?fDEDSGSO015ay/4tdjXgCGKC3dpEPr1d0C+EJU6Ph4ZtBfiIjlHlv8QHBftV?=
 =?us-ascii?Q?K7+yBbkq9mdB17JtpnrUHm7wDFNQs8pbFtsfG+De8TYe4CVCfjX8o93/TdgB?=
 =?us-ascii?Q?tUSJzjV/ZWhfQK2awI2qKPZczJXy4OdLolw/TgVrucQeooZhrjFvX1n+NJSl?=
 =?us-ascii?Q?WSxX2olys5cWbdOr6WQUOW39N9Dq66CTbZ7YMWwY6T9zHyIOEZaEg6TL13yT?=
 =?us-ascii?Q?hZFfQy4mm5aK6C9OTDoI8VXKVNjQl+3Er5OvgSe+CP/Dxl2w8oT5+K1K19AH?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ei3wi3UChnli+CCSmm6jdmU2B47vZuQGVuKpC7BMILkb4Rro8NHFKf2+BgsO?=
 =?us-ascii?Q?NnZoYXRBolj9c1Le8f4eCnDAag32usbFJ9sC8kx3LT78W5V1cYI3UOQA6d9x?=
 =?us-ascii?Q?GpjECLdQ/0CkumXCFWYy1V8Iitymvnn1h9AFfYdbe2/UQQfttdNFhST1XKQh?=
 =?us-ascii?Q?2MfdpL1alAFKE6/j7vfRbF4w5k2cgkE8wKjuIdODIfglYO1KtwzzJiBuX/AA?=
 =?us-ascii?Q?dHzLnJ+BjPo4qM9u+GBWpWi0YcC3kDw+LFdEHujPFzuleTKrPAst642xYjw9?=
 =?us-ascii?Q?KzbeLXJjtSOLGoTOV4gI8IXTkTreKrzsJKJkyisYYusMc9ZL7ONrluTC2en3?=
 =?us-ascii?Q?EUVjZPK8aOlBEHmOHPtyrBVxqJsP0aVdAIgpdAOjvtK7WqM1nEZFkWJhjLSu?=
 =?us-ascii?Q?JfyliedJrK48Cz+bQSoBgYiYcHMJ+v7w88GgAn7RcRdvRmjV8P/cAjyirAPk?=
 =?us-ascii?Q?EbgY/MQK9SrHdsom0GZ6BRdhe42L8MYWdCaV6P4doTmPurujSgEjPYLVvK4l?=
 =?us-ascii?Q?+mQc6/6uT5NDWMQl4OVqfvEnpfHTKkMqyDKdwgMXBDxyQ8sjm0pK05mwKfeI?=
 =?us-ascii?Q?we3+5PPmAlzx8v0N3pkDWzj1sq/WhBx1eMz2Zjn5hmUC643Nvfx13mIswLDE?=
 =?us-ascii?Q?7bw/ut8Lf6ZjHUMrSgeQjDAsntHc9YIKg8uQMr54YJKGTbER2ZE3jPaoYUgZ?=
 =?us-ascii?Q?q9r9Wawo/xyO2bXxk6zHeCFxBKbTaOXcwN5IgURklsSObrLWcmVxjX/eS3c6?=
 =?us-ascii?Q?w5LOBaCR/CQK0njDgGekxTivNs90LE47I+aSlzOs6jRc74R3s6HnimG08Ygz?=
 =?us-ascii?Q?fF5MeY8mYeUQr5G44B9A84JUu6VZGmuMp9OYh7J6ARtmxuV+hqtgId+Vy46G?=
 =?us-ascii?Q?vsSJx6Wsn/F8tmytkiDENFduOxHxXh2ZDi+uxJIp2fuGXMe7nOgK2IxYGggA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f60d9e4-b5a4-440f-2039-08dba289f6b2
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 21:02:43.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DpDDQamPiAzHBAxJsfuRNSn2JRmtemDcw6A2dHh7Pp13QZ9oK2fOKR3ClhxYS+UAKLWJ5UWazB08/rDMRJShUsAkpJc7pGhbm/lmbKi+f3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=678 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210195
X-Proofpoint-ORIG-GUID: d2tO6m4JpV9HNnpJrwvH_vMWaxkS3XyW
X-Proofpoint-GUID: d2tO6m4JpV9HNnpJrwvH_vMWaxkS3XyW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chengfeng,

> There is a long call chain that &fip->ctlr_lock is acquired by isr
> fnic_isr_msix_wq_copy() under hard irq context. Thus other process
> context code acquiring the lock should disable irq, otherwise deadlock
> could happen if the irq preempt the execution while the lock is held
> in process context on the same CPU.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
