Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3DF77BB36
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjHNOLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjHNOLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF435E3;
        Mon, 14 Aug 2023 07:11:11 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiUao017544;
        Mon, 14 Aug 2023 14:10:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=7GPMA82MZkRr5atvM4OSn56YsayHz4XJs3GifAHucxo=;
 b=VmNBNQxL2ZyB0l5+qFqxH718S3IXfwyBAgwXVMZtBUbohAeIhnM74XtZv9stTd0T/wk6
 EWWYxAkTbaTyo5VJh4j1Za3kDBwMcVddU++PBIciJqvSc1zKytZQQkuZC5XQuFrScQUY
 78t0mDfUjK4uYHP8nw0Cw1Ykr8CBwcrzc3bizSfvDZn2lUL9F9rTAoJPDVGA275YqdTK
 iLS60UX3G9gcXbbp2pTdY8Z49XJQIxxlz1JyZIg2l39fGbMorggLMtINH3Benyiq0aOv
 dhAWSbqAVsg0JLYGI7sjkK34ImC1YMLXji3Y9BzRsarbIGBmNaIcJ5KqFJOgvxg25jhm uA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se61c2kfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:10:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDanqK040235;
        Mon, 14 Aug 2023 14:10:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0ppnma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:10:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kh06klHFDyDH4alfS3G6JVAjTqiopIH+FiVy8TOrdMnHAvi87wswCYLT4mO+vLZjNUU4ZWBKxUqZsR63yEACTvshdV2b+RvV+MCN4+CinffIbafKe743yOnUHbt6gynuHTQwEnf76nbRV/KHWPv+MesGnQFy072VO1X6TDAY9yiKik90AXhLCt13TXDg9kg579+j3l2q2gfbSbqg1hSo8VkudPmDFuw1g0m6YWmNlCUcZdf08e2EBB4v8qWOua2TscEq0KUPRNf41YPSAityphiPWq2rMeNyyI+ZNQHHJxEFZzEP1U+V7OOPjIxoLJzUuaAvQRtnNaG2Fa2OWkrVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7GPMA82MZkRr5atvM4OSn56YsayHz4XJs3GifAHucxo=;
 b=b2KGIi3JJkqbpFrrFwdLUz3xoNBAsgOZnbJiUaBlRlRhuZB0Cn4Q6TTKYxj9Hbq5hYxU9z9djvqzZf/XHnREBC6DscEpnLU73YL0vGJSvfmmO8L4ogMwH26q/3hFD/alePPVqUDnvHE3TLglzXR9C3FFTlBj6AdoyJo6umLCZ7zSHfjEb5Z3SKz//zjqKbwrPM6Q9+y8EtYG9Wsz9wkpGBVJfj2ypJp4Qvhd6lS8anXpwrGZzmgTvIykproopJcAMpXrIk/QgHbfFhveHxCsHhEFxXB6qplsB3EmcHJkXpNXxRD6UqiqzixRsWOUhvIHwgibOpbngL+xlY3lPcCJCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GPMA82MZkRr5atvM4OSn56YsayHz4XJs3GifAHucxo=;
 b=UqxyIDxpIbwqfy6X5FVjQ2M3mh6I/kgUXhVKV0MlCVPpbBqLVPFVVb9kjxglCJwHiYOq1YVH+arkqstwp7zlGdlmV6arDkDdLXPtDcmAL2FhCOf3/RKMD5RA2HEl779vLTPofMadBWevxxNZ0Ai0gDG1HX0qza+H4yanavUzMOk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:10:49 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:10:49 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 02/10] scsi: libsas: Delete enum sas_class
Date:   Mon, 14 Aug 2023 14:10:14 +0000
Message-Id: <20230814141022.36875-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d9ece7-914e-4d61-7705-08db9cd04313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fbo3vHpLlRDS8vxbFl+gI/TIsrk8tLNJuaIDJRxlWH6lZQC686AfA5UCDdJRy18Zb7Tnuc2gj2iNKhQT1Fzk1/dQh/eAoVu6NK/peum3MeumFfhhht/b2n+B/qrXaCUZ12ByWDDrVuFgrXfb6h7m6HwiWGXEn86GaXLemi8k9dAcrAZt+phy3UtnLP3NZFW/sT1dfua3qmnnz7pSD7bTVzX2rOF2BTA+aWqV5D81nRACk4euc5NtpuRRvh1VuhjMbyogZnWYCwB4lqeU1T97ki0PgvHSZ3BYsV1wSDYcBh7R5wa0MBwyf7eXfUVW6pmYxP+eQN1F1OfyLJmc73ddunJi8gsvZ/ZBIh4FloRrc9+zZLLZleYcgUBLObCUypl7VgSjSZiAxv9QnDeOZA6y8495F2tCl3CBK22//hond3BBPcuv4tyPw9uRYMIJ1dRWgAXi1+SOjF80fv9VG+oENsGBAx5ryVWVLrgXrgVXr8OI+lwtVrGHldMAMDI2S8VM4lw+qPTCXmc7SzU1RWT/31r4WFCAMm7wdzabBgDXFkZ7A/ouAjTlLrXvPSQFAmvW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(6666004)(6486002)(6506007)(478600001)(103116003)(36756003)(86362001)(83380400001)(6512007)(26005)(107886003)(1076003)(66946007)(2616005)(2906002)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sfURODp4jslll6sYpo4e14AuqASQ+k0m4ggMv92VfFfNWTvDUufEChs4ckgj?=
 =?us-ascii?Q?krG82WNo1WHotR9lrdpa09PgsRUxD6I9ODco37xFiBWAq4TvrEvZFYPWNUPE?=
 =?us-ascii?Q?wwU5fbPFc7g/6/ryHxtenmuMTEULEwtIWtMHFE7Xg2oFXCFVWMlURXdUcl2l?=
 =?us-ascii?Q?nEh6wSLpkzirBIEvCAAbIGrcWUnojmN4e9POpSYzFstYIcRvIcDAvvZwbjb5?=
 =?us-ascii?Q?czT7RHRM/xuYJTnQ2omozSCT69PQq6PGS/0q/4xUXqbvQsrLdW3xn2itk7m4?=
 =?us-ascii?Q?uZG501KoDsJjH1lPBPQA2oA9kcg1/NTrQSXwptRW67ZggdQDF2NwbLk8ekL7?=
 =?us-ascii?Q?yiVFFUfiSS5XARxi6xNspP3bRGeFUQuJlawYFd4k2469Yv+mu4JoQcxMIwwJ?=
 =?us-ascii?Q?CWGxWXfZ/i/rae11iBZVWDa/QOfYPlxAonEQspvhpQnCRX75IlJ5/o+9BkP1?=
 =?us-ascii?Q?t87XK3nttVBI/0BBdm9TKwWabUpBl/I6aWb9/TfLcKOmJi1yXCXgnLusBeuD?=
 =?us-ascii?Q?XhwJv4aBc0ClYw8BmLhsFfxErT80KIC6zRNRAyhT38zoiMKz3QcKmCxlCDHO?=
 =?us-ascii?Q?NaRcP+ZtlG+P+JYCoa93T69kOrRIE+jlZapUj9MgSg0vbvZKGTQ4TPcijI74?=
 =?us-ascii?Q?z+vfIcnJ8jKymxJM5lgkkyRFTlJF+j32ci8V/NJ8r6fwLiRB9+KCMda3mp6m?=
 =?us-ascii?Q?Vf5E+4sLaueJOrwQlNXZtOWPR5gOh/BEXTqBT0JMrA0iGxLHPXUu5/pabMnm?=
 =?us-ascii?Q?NNoHgWsg+0xEDyuaMMZJ4vgqJDLibbZwwu77aPsuZAK1sEsbuU3WP+2UaA7r?=
 =?us-ascii?Q?Dzur3Cxdy2Zg6RXjniSW/HezHZ2mB1MQJEmMWHClzwYXdsq+SuYDoLePmONb?=
 =?us-ascii?Q?pAF+mk4WcqEOuxx8+ZFDb5fS94iMLEPxA0VC7TxQLgyxynJVVztlNo8LF2NP?=
 =?us-ascii?Q?nRgE3GxPT5dMu4zbd9qD9FIhApLJSxtmmYzMIaclAD4ddcrflunfU/FgDJKZ?=
 =?us-ascii?Q?bPtxV0MtJfiw7NJASciFzLk95oJkB3q7XEHVw5alj7/swE6tUF2c1ZLgw2qB?=
 =?us-ascii?Q?22ALpzAXhEfFFXed4u+8NIIpL7suDWsPQvJBr7bIXiko9/16wzTv3Vw55qLA?=
 =?us-ascii?Q?gvb2R5Jo6bHyRvhIqa3fVi9weiuIMayv9bs2YKCISJmLq+wQzE3hpRM/hGaa?=
 =?us-ascii?Q?d9PS+rEkddkuJ7hNgVkPtjChs8QjK3dt+NiW5OXXhmlXzjuOsvt8FXMCJYTh?=
 =?us-ascii?Q?adEmpUE4m+Xnvi4wsrbkcPTPl4LtVOM9In7jFfKWYv0oD7PpCI9QvoAlC9/S?=
 =?us-ascii?Q?khKDi9q2n9ilHgkIQbEGKH8NJIFVnH4OqL2F8rs24xgC0waAYnRcnb689lzG?=
 =?us-ascii?Q?sXg7yzyI4WalA9EbRdnY2GZzdTmCXBaDHwmOnzOKE6fhZujCmiDJCB1zruDa?=
 =?us-ascii?Q?Tw38EOE/kKYuqUCIp4BOG6HgW23ktm3SHG5OqF1OgDTCaiOCT9WMsRPr8bkd?=
 =?us-ascii?Q?h/Cok0Hcx+xlSGMeXKVcsrfKOZHsHT/dr5NJavLSNEiaUPhcNjtZSHbBcc20?=
 =?us-ascii?Q?2+LnSVyJq5K9aYIl5+RlweBFj6nnvBQtT4Dvm+Kkm4i2dbTJ9UUdj3W6vOVI?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Pp1dHGZdA7dIHWQxUSQ7ViXCV8alez9krqdhmMzqyhQx7f3lH0m5mIk81Lbm?=
 =?us-ascii?Q?9CuzMcNdIMigj7gAtaHU93jjZ6qrTBggiWaIO+1sNMCQlxUaluoylwatuJRU?=
 =?us-ascii?Q?EudSf1/hNrUHH8qCJjUD+i2osMHWJS1xxKpVnA6UlLeRn3MWLF6YDNQVCHRn?=
 =?us-ascii?Q?3/EGG7AQSZfACLvHMNZcQZ5/HZoWl3TzDwL4mDxGZyJc6wcH/mtcA1IvjVoJ?=
 =?us-ascii?Q?hQbnmhGqkgppK6I/OcgyViT7V7+NrkAmfo/AiMxoK33c0kZf9W492O1bUFQW?=
 =?us-ascii?Q?6eklWbbTtZuswzk+VZSwOvPBNmHu7E+LKK4DJ+qXOqqQX9vewr3+EdXww5m4?=
 =?us-ascii?Q?0MRQzX5idTQg9Fxd4uy0l7Xp15zRPwPUoAjbFjLXriLCLfCnLlKnd78o+IpK?=
 =?us-ascii?Q?yN4auTNfmeDGigfR1bPMlAM36Epm23i8R7Gp52KZGluolQUFxJF0BwYZPdp9?=
 =?us-ascii?Q?O+ZV7boa0V7mVDnZ0nbCugBrIJJyN/7C12b/MtjyitjQDwQ3d+ETse764Mzn?=
 =?us-ascii?Q?xbdlqiLJHW8cC9E4VDbqwXmZu3zgKhT3ZIyBj1o7+Qzk+o1zQvseZ90a5rKo?=
 =?us-ascii?Q?RM0UF6pEYn2MJtI/xUR8AFlQhQXBBByhiinXQmgLiFHk0REht/fqdbzFaV2g?=
 =?us-ascii?Q?A4piEGf/r5j52m0PsjULh5N1yFPb3mdGrlsoTm603v7f0SwtcOxr065pJVoc?=
 =?us-ascii?Q?DgrcUVdNI4KVOxeUrtUImD4LUANniIXCge67CCqmr0Vr/vDbEkEgwgZmjPDl?=
 =?us-ascii?Q?Cj+cT6nanbUAmGFvCmGNTzSxB/3XTlGyO0NsEEY1i2Y/OadAtMb/5s0p+vS+?=
 =?us-ascii?Q?meEUe6QReBIntztLLJSmMIwgIsS0VRS6RZaAtMyAMdkrKOTUkaj+ACN4JWva?=
 =?us-ascii?Q?dsiE/crEPramWUq/Y2ICN/ktmeRM8jsWefMW8ukI58PCqZQYE2wii8rDC54a?=
 =?us-ascii?Q?01DSClVqbpXV6SSoxklUmQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d9ece7-914e-4d61-7705-08db9cd04313
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:10:49.6501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lR0eF0TyAX8OyvvBBCmur4jadvbVSLo2NOiP4RCitttd5FAoezrwo4fo4MjsjHyuIxvTtIgPnNBjq2atCD9hBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308140131
X-Proofpoint-GUID: RL4T0yTOy2LdJYeQuKir_qdSPu47T-2O
X-Proofpoint-ORIG-GUID: RL4T0yTOy2LdJYeQuKir_qdSPu47T-2O
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum sas_class prob would have been useful if function sas_show_class() was
ever implemented, which it wasn't.

enum sas_class is used as asd_sas_port.class and asd_sas_phy.class, which
are only ever set, so delete these members and the enum.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_hwi.c    | 1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c | 1 -
 drivers/scsi/isci/phy.c               | 1 -
 drivers/scsi/libsas/sas_internal.h    | 1 -
 drivers/scsi/libsas/sas_port.c        | 2 --
 drivers/scsi/mvsas/mv_init.c          | 1 -
 drivers/scsi/pm8001/pm8001_init.c     | 1 -
 include/scsi/libsas.h                 | 7 -------
 8 files changed, 15 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index 3dd110143471..d8f56e528877 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -72,7 +72,6 @@ static int asd_init_phy(struct asd_phy *phy)
 	struct asd_sas_phy *sas_phy = &phy->sas_phy;
 
 	sas_phy->enabled = 1;
-	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
 	sas_phy->type = PHY_TYPE_PHYSICAL;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 9585f1ed8ae5..1172065c1d7d 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1018,7 +1018,6 @@ static void hisi_sas_phy_init(struct hisi_hba *hisi_hba, int phy_no)
 	phy->minimum_linkrate = SAS_LINK_RATE_1_5_GBPS;
 	phy->maximum_linkrate = hisi_hba->hw->phy_get_max_linkrate();
 	sas_phy->enabled = (phy_no < hisi_hba->n_phy) ? 1 : 0;
-	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
 	sas_phy->type = PHY_TYPE_PHYSICAL;
diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
index aa8787343e83..ea2e339f5b1a 100644
--- a/drivers/scsi/isci/phy.c
+++ b/drivers/scsi/isci/phy.c
@@ -1404,7 +1404,6 @@ void isci_phy_init(struct isci_phy *iphy, struct isci_host *ihost, int index)
 	iphy->sas_phy.ha = &ihost->sas_ha;
 	iphy->sas_phy.lldd_phy = iphy;
 	iphy->sas_phy.enabled = 1;
-	iphy->sas_phy.class = SAS;
 	iphy->sas_phy.iproto = SAS_PROTOCOL_ALL;
 	iphy->sas_phy.tproto = 0;
 	iphy->sas_phy.type = PHY_TYPE_PHYSICAL;
diff --git a/drivers/scsi/libsas/sas_internal.h b/drivers/scsi/libsas/sas_internal.h
index 6f593fa69b58..c06ecbcf1254 100644
--- a/drivers/scsi/libsas/sas_internal.h
+++ b/drivers/scsi/libsas/sas_internal.h
@@ -41,7 +41,6 @@ struct sas_phy_data {
 
 void sas_scsi_recover_host(struct Scsi_Host *shost);
 
-int sas_show_class(enum sas_class class, char *buf);
 int sas_show_proto(enum sas_protocol proto, char *buf);
 int sas_show_linkrate(enum sas_linkrate linkrate, char *buf);
 int sas_show_oob_mode(enum sas_oob_mode oob_mode, char *buf);
diff --git a/drivers/scsi/libsas/sas_port.c b/drivers/scsi/libsas/sas_port.c
index 11599c0e3fc3..7893c462169a 100644
--- a/drivers/scsi/libsas/sas_port.c
+++ b/drivers/scsi/libsas/sas_port.c
@@ -83,7 +83,6 @@ static void sas_form_port_add_phy(struct asd_sas_port *port,
 		memcpy(port->sas_addr, phy->sas_addr, SAS_ADDR_SIZE);
 
 	if (*(u64 *)port->attached_sas_addr == 0) {
-		port->class = phy->class;
 		memcpy(port->attached_sas_addr, phy->attached_sas_addr,
 		       SAS_ADDR_SIZE);
 		port->iproto = phy->iproto;
@@ -249,7 +248,6 @@ void sas_deform_port(struct asd_sas_phy *phy, int gone)
 		INIT_LIST_HEAD(&port->phy_list);
 		memset(port->sas_addr, 0, SAS_ADDR_SIZE);
 		memset(port->attached_sas_addr, 0, SAS_ADDR_SIZE);
-		port->class = 0;
 		port->iproto = 0;
 		port->tproto = 0;
 		port->oob_mode = 0;
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index aea70ec308f9..408113bf506d 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -84,7 +84,6 @@ static void mvs_phy_init(struct mvs_info *mvi, int phy_id)
 	phy->port = NULL;
 	timer_setup(&phy->timer, NULL, 0);
 	sas_phy->enabled = (phy_id < mvi->chip->n_phy) ? 1 : 0;
-	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
 	sas_phy->type = PHY_TYPE_PHYSICAL;
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 1e0154d08393..e5d794a97b14 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -162,7 +162,6 @@ static void pm8001_phy_init(struct pm8001_hba_info *pm8001_ha, int phy_id)
 	phy->minimum_linkrate = SAS_LINK_RATE_1_5_GBPS;
 	phy->maximum_linkrate = SAS_LINK_RATE_6_0_GBPS;
 	sas_phy->enabled = (phy_id < pm8001_ha->chip->n_phy) ? 1 : 0;
-	sas_phy->class = SAS;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
 	sas_phy->type = PHY_TYPE_PHYSICAL;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index ccaf8f6b1055..3048660ff107 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -23,11 +23,6 @@
 
 struct block_device;
 
-enum sas_class {
-	SAS,
-	EXPANDER
-};
-
 enum sas_phy_role {
 	PHY_ROLE_NONE = 0,
 	PHY_ROLE_TARGET = 0x40,
@@ -258,7 +253,6 @@ struct asd_sas_port {
 /* public: */
 	int id;
 
-	enum sas_class   class;
 	u8               sas_addr[SAS_ADDR_SIZE];
 	u8               attached_sas_addr[SAS_ADDR_SIZE];
 	enum sas_protocol   iproto;
@@ -319,7 +313,6 @@ struct asd_sas_phy {
 	int            enabled;	  /* must be set */
 
 	int            id;	  /* must be set */
-	enum sas_class class;
 	enum sas_protocol iproto;
 	enum sas_protocol tproto;
 
-- 
2.35.3

