Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5749F77BB43
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjHNOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232170AbjHNOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6701722;
        Mon, 14 Aug 2023 07:11:22 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiXhm026716;
        Mon, 14 Aug 2023 14:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=lNj9AN1Z894cK/34/aAJy5v+TH7aMAX+Zc5kNg2UhpU=;
 b=QGXCZ5um/Hks/+keFj3n29sKW/Asv4twzkuFeSZ/eiSWTxk0+Y+GhhPQgQb4rrTR5jq5
 iybIytMD9ICdPIzjC4a5K/3CliixYMkEmAGKTJ9/lgXMe7sLH9UwezxboppXeJ/EDTcy
 BXeWZX+/iHYNJi7G5vHGhIGEB7ZbVA1KkLP4ly+y1Myr7kJWBScIQuDhwtXLBzFsrf51
 XA+JKazX9Gxbzke3kNS2NScLDwSVuadl3Zgk6XEeyjbQrMkUbgysF1MyCenCwMTB69x9
 RreCxIqOmFZLaCKscnsfBLxFW5rcqZ7XcySPaKaPcNwgfqpQ9rGmLdTXwko5Y+ObSApG 3Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwjp9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDdYtA003759;
        Mon, 14 Aug 2023 14:11:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexygpue1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN3fCkjsFDe+jzQNtrQZ/EDqCGit2N6vSVXGDeaXunoCkDocXLPd4mi9G6X2D8ctpqWUpO6ULfJ7X4cbIWv6zQF08izt4sv2NNR+LSRGOiODRuvPfMtiyhZQsBFtcI5yVULigkfnj5DB5EnXTNbFqqLuBSevbc7H4FvLoEqx/bZycNlpx3Lvx43JydIU8p/G35fq2zR+HGvqROTWfrIymti7LXiZafuqtOelAXshoAL1JeHrW0ooGxFpW3uXq6lzVJB/TrNfL0rtSpenVMQtKZlCjJNN23JK7sIzURmJ1yGmsUyE72Z+jofTaYAdmD10W2Q0k2qAFosdlf2TPskHiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNj9AN1Z894cK/34/aAJy5v+TH7aMAX+Zc5kNg2UhpU=;
 b=jX9wMTZ9rb1Fi2PrtT1ADoqYqVRZHyaXsFdZ0q4kHUj89EsiJGfV97Ya0L0W/92TgPTcOwl/1JJbQKSibjX82dpQQkqSoDsTO+reu0/B4bRfyYhCaDPRgKMuFzhlb4EjcVA7SI0p2jwkITun35uwDJJjc8/RwK71lsmsl1JSGbRelFCqWZhVqbmj3K8BSFYIW7Bj/2mhjYEcokxYhJCgqp24/KbVSYuYX+EyuB7fj3THXQVtD2G/C6Zxookr81s/dDUBWO9v8ccZroyWVghjWc0wfiVUy0zgIjc4ir+lZQ/yiVowO9edMphOck8Ol8yyY8eFwXNDHa2NqPCFh9VIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNj9AN1Z894cK/34/aAJy5v+TH7aMAX+Zc5kNg2UhpU=;
 b=zM2LV/bI/pAbh0swCn7bJNTOhTaSpj9Km3T3UlW5OVT9lWMdI8sC5qFdZLhwv3uplArtX9ZtMED9Ef0q/KcBgKICk1c9ctWFVNjZqkuBzzR+eF6hI4eJjI6aZf0FUjXCzQOXQ9vhFroppmr5cV0bot5O+bOKaZkUBapGWU1AUQ0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:11:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:11:02 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 04/10] scsi: libsas: Delete struct scsi_core
Date:   Mon, 14 Aug 2023 14:10:16 +0000
Message-Id: <20230814141022.36875-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::28) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 537308e8-76d7-48c4-0d11-08db9cd04ae1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwGoukucvKQL3djHZAaurfkVNfRLhY6NQrDttISWq5GjY1rBPPmrFXmJVAzVxSoKu4d7LXCNKtQUJg6tKiDc3fQDCC+3gwrGFjzfBbxNlVqpCNyVG/k9h5dHONtOUaV79ouKRV5I2/Ll3/HM0VBfoQiFIGt09EEigN8oa0jAbBccTpl0uTYDO4CQ24iIRuF6sydoCKZKwYU/FjsJnjIq8aKI7nhGYVN3DyRThcVTREoTnyghix6kapCwWkcyf/GFL16ZrL/HRiYecFYymGtwn7CdHG9Pueibu1k9M528jdtNeBGJTAUOjRYCOarKeHyDlO6vo+7/4Jy8fyEEVI3rPeOxXwxutPwOm4ZUIfdDblM3Fbn/iMvCHFAuTIFv2JMyawt6H9y8o2OI4jcXWqMrolPC/UFp3TNNLwE3T/m0b/YfRAwuysEq0AKH2mj1D+SnI44twzjVv4tjPoZLJi3SCvqnHR8NtgY8QBjb/qBzrDqKF+eAxvkHhIT+gtAGJmUxcPMp2a0i7i42KW3Rg4D9Vfcb/E3O2ZUtnjpDjrGpj3znoJIDAR4H1g3vQfoqfws6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(6666004)(6486002)(6506007)(478600001)(103116003)(36756003)(86362001)(83380400001)(6512007)(26005)(107886003)(1076003)(66946007)(2616005)(2906002)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(30864003)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o3Ky6i+seF/tCxjzo/9A+n+KsrPd6/qBvxtRICFFriw4eQbl7H6ZxuGdk5Oy?=
 =?us-ascii?Q?T8bnFu1TcnMHjer6LpsLPa3YN0cHvP3u4/rNVq5QDQPwyX2YpQeDDfwVkBKT?=
 =?us-ascii?Q?M9roHlRucBQ/q9qKnVWCGELy4GeHkCttEwzYWF9DsCUThHaZAxR0oowuMBkR?=
 =?us-ascii?Q?VOPcOYAmznFmYCvn0Z0BfJYIYa5gNEDBbHikAUyfU4IVTvS4m+buftYi6crN?=
 =?us-ascii?Q?zKf52JTQwRcVA/vNDDY315ZmpnGQt3OTqBT1K9s4NFaipvIy4w1UJh45aJBn?=
 =?us-ascii?Q?JBlzrtE++e7qsoVDRWt8k6PR+4ZmlDZOZBh2fsL0pl3nxT2IkSXCuGOynWnC?=
 =?us-ascii?Q?VfytwsePBpWXkCkpkhUo+2VB+xQhjRq/A5dWiEdaS4tjxFCyuyiJFTa0U5ON?=
 =?us-ascii?Q?yLTpyyw0iUsBivGLSloqY4bb73GBjabyNW03y613SqnwPdXjGNvzIklZxe19?=
 =?us-ascii?Q?usqh92MLp0CHNe2N+2OV2RL0gZ95lYx+D0wWNIP9R/BkBgFzNdzJqFPUk5W+?=
 =?us-ascii?Q?UtIVwIoN2j201aGSfR5Dkvh622A5yOElw5HOdzLrYQh1ORQLOQE4+fdkRRSW?=
 =?us-ascii?Q?TRJ0WGNIWMn99+MJdNvrC1uUsQmwTQq0BEFg63uHocBDenWE2nhRsznrGC5B?=
 =?us-ascii?Q?1NQ+kGVbcH60w46MwqfqRd3DRJFwkDQ6T4lqc/NqVvZtx2IG/CVAmnL0uGsX?=
 =?us-ascii?Q?/LkribuTgmlNvIPJ/aCZrXojjYeTgLDUpGr1mNyALHCL9E0ZvvFZY4dvE32W?=
 =?us-ascii?Q?ti8YHfBdVqBTJqrmVctzJbmpTXNF2N8TK7CC3BqKDknLeFJWTU3mw+jSo41a?=
 =?us-ascii?Q?W3zVJDUlwzYrwZx3HqOt5yPrbDc7+pM0YluV7JT1aSeXvXIR81r8MxXHe1mY?=
 =?us-ascii?Q?lX7WdChPdj7PukKKYQx0CQEXc3DGpqmv/v+DOKB7Zat4U8uIMdVjrRaav2Rg?=
 =?us-ascii?Q?fNf1sDqtC0pJjxxcGyzw1myORYufaBMS+jzBlcTtGHtF8cH5jPENvWJ2hiS9?=
 =?us-ascii?Q?Eq9RwCNwij+rShiGVTvnDS1VjjEaTZcYAv13naRYqCm+8gf+I+LzP11CSpC1?=
 =?us-ascii?Q?2gWcKjw36doLEwwZo1smccHpRt6vC/EqYXFwLp/GQ5X4yVXv7Oak1RNBBpNp?=
 =?us-ascii?Q?u08rlB4S7mpak8YzgfqC++zdzzWNYE9o2ZnX9X5+sqeZBuaDPfdHfU2rOLrN?=
 =?us-ascii?Q?b5OFn7F9UYIPimuaY00ktw8bhcD8Sgwc9F3U1QbTbHtJIL6SDiCnvUIsaXyv?=
 =?us-ascii?Q?4G7fSEntjL4LtOTSVTpywIn159b76QYtMI080SNRWqXHE1p40XwmxFgX1+LZ?=
 =?us-ascii?Q?SGL6WBFXWwTS4e+Al5Reug8bMVvqAcSqT8yqCExQRm+kpkIUK7VSPGt6nkXu?=
 =?us-ascii?Q?veKwmjyPGqvOwa8Ox2nUgABKF3eSwTNyybmQhgnZU+30pEYnYW1fzXvq0iLz?=
 =?us-ascii?Q?nKFwSUTKhvO4hGPzqR5vHqww6nvwtoTHQmGIykadZXPiGTWL7XWrybgK/DXA?=
 =?us-ascii?Q?zPH0oYTfD0f4yehTJxY0yFCbdxoJA7jQOJrU+RNb8M7AQXjg8OpsjwvTuZrj?=
 =?us-ascii?Q?Hp0z7jwupriQa1wfrLIRjey+LxoFmYE0hpJDZIwn+kAMZpLrtRTpOWN3sI8E?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Dmnbx4WndDR1NhVeBgx6yPQvUrn/EKx/SF1bZ16BdD4FpzHPDnMiZSVwSv+k?=
 =?us-ascii?Q?WFyXX6nl5hL+xIgtNa+16XKetHdrHl6xbnUxuPpZi3orpVB+6hfmgP95M4Fb?=
 =?us-ascii?Q?yxGmKB14zcXRuCsw1SV661x3q8RnSxb9XhItqAAWl4INDUbDzHq3qlT1QN7b?=
 =?us-ascii?Q?riYZjfsw5ksthvP/QXnUJL/ZYC8Cj/Njo7K9uDqbsEKh1Z7lQUlFdXAw98fl?=
 =?us-ascii?Q?LofX3khyuvu1/l5st4Ow8u9koFfD0Vpvy9LNI/yd1SnXb6ZillCCuqtGuoz/?=
 =?us-ascii?Q?9xJZQyF6mUw/8vyUNsYRQ5EH58TfjeMVtEKoVT+HyjmAY/t8gJHB5lpSQfhp?=
 =?us-ascii?Q?8bAeVfxLrprV/wMGN/DfPdzm7nCmCnjS6hrd5nECevqNzW6f3wPJ/7NWsbRW?=
 =?us-ascii?Q?G8ZdjkynT7nvtXRjxgYtYhEI8IGdPDfrxqS1FfI4aPQYcvINXWWE07M5IQAJ?=
 =?us-ascii?Q?JUBO+IoUsi+wLWVD7QLiArxZNf1MrMuofTFhSBMepTwCaXkOj68nG3cCWOw9?=
 =?us-ascii?Q?3kpWbvlC/+UfmBFrCTaskEIZPaEUN4VLZEeTuhcsh9vWruSRJ5UHE6qeKo3/?=
 =?us-ascii?Q?+xthIcZxU63hy3Y5pGeJvom29FyiSkSNSk2QG/dtVdCHiEXV5nVEZUYvrpCI?=
 =?us-ascii?Q?QBxOP1MJMcOMDXw2IM2je9NTU3HNFIGvltmb0/5xTglezblHYuep27qE4SJ1?=
 =?us-ascii?Q?eUUqdqUz1dA1JsUpgWsUaMMotPrXEb5H9BFY39PxRXYWvMlfgjNJV1Z9QpC+?=
 =?us-ascii?Q?aZRS9MyUxZFsOnDA68mFal5Ul0Vhsc4dN9pXPwVjB4gdYJBEJPPQ6OmsJ7a8?=
 =?us-ascii?Q?h8YfOMN5KGhEroz2NWHdA1r7YNwImDINtdmbK+uwIskeHM3Z2nnjt6Sm4mQq?=
 =?us-ascii?Q?w/eBQkqJYIFJVsJ9nBVlH8Ly9zJZxK15d5LxE2tJA/uVBu73aT6XdtMvlr2A?=
 =?us-ascii?Q?xqnpKkB1zwV5+o6CHQpUjg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537308e8-76d7-48c4-0d11-08db9cd04ae1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:11:02.8591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Upb/zHH8rrbyVmmiKF4i9jLJab+04sjTMVc58vcwubISKpuBVk9SHKVAc7mGkVHEFm7+CF+RMGe+X/uQhTEQ3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140131
X-Proofpoint-ORIG-GUID: nTCo6Geekpk3FxQOY_Yc_OPXTgsWtYhR
X-Proofpoint-GUID: nTCo6Geekpk3FxQOY_Yc_OPXTgsWtYhR
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 79855d178557 ("libsas: remove task_collector mode"), struct
scsi_core only contains a reference to the shost. struct scsi_core is only
used in sas_ha_struct.core, so delete scsi_core and replace with a
reference to the shost there.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_hwi.c     |  2 +-
 drivers/scsi/aic94xx/aic94xx_init.c    |  6 +++---
 drivers/scsi/hisi_sas/hisi_sas_main.c  |  6 +++---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  6 +++---
 drivers/scsi/isci/host.h               |  2 +-
 drivers/scsi/isci/init.c               |  4 ++--
 drivers/scsi/libsas/sas_ata.c          |  8 ++++----
 drivers/scsi/libsas/sas_discover.c     |  8 ++++----
 drivers/scsi/libsas/sas_expander.c     |  2 +-
 drivers/scsi/libsas/sas_host_smp.c     |  4 ++--
 drivers/scsi/libsas/sas_init.c         | 16 ++++++++--------
 drivers/scsi/libsas/sas_phy.c          |  8 ++++----
 drivers/scsi/libsas/sas_port.c         |  6 +++---
 drivers/scsi/libsas/sas_scsi_host.c    | 14 +++++++-------
 drivers/scsi/mvsas/mv_init.c           |  4 ++--
 drivers/scsi/pm8001/pm8001_init.c      |  2 +-
 include/scsi/libsas.h                  |  7 +------
 17 files changed, 50 insertions(+), 55 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index 75848de13818..9dda296c0152 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -28,7 +28,7 @@ static int asd_get_user_sas_addr(struct asd_ha_struct *asd_ha)
 	if (asd_ha->hw_prof.sas_addr[0])
 		return 0;
 
-	return sas_request_addr(asd_ha->sas_ha.core.shost,
+	return sas_request_addr(asd_ha->sas_ha.shost,
 				asd_ha->hw_prof.sas_addr);
 }
 
diff --git a/drivers/scsi/aic94xx/aic94xx_init.c b/drivers/scsi/aic94xx/aic94xx_init.c
index 6603e91cee8a..8a3340d8d7ad 100644
--- a/drivers/scsi/aic94xx/aic94xx_init.c
+++ b/drivers/scsi/aic94xx/aic94xx_init.c
@@ -687,8 +687,8 @@ static int asd_unregister_sas_ha(struct asd_ha_struct *asd_ha)
 
 	err = sas_unregister_ha(&asd_ha->sas_ha);
 
-	sas_remove_host(asd_ha->sas_ha.core.shost);
-	scsi_host_put(asd_ha->sas_ha.core.shost);
+	sas_remove_host(asd_ha->sas_ha.shost);
+	scsi_host_put(asd_ha->sas_ha.shost);
 
 	kfree(asd_ha->sas_ha.sas_phy);
 	kfree(asd_ha->sas_ha.sas_port);
@@ -738,7 +738,7 @@ static int asd_pci_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	asd_printk("found %s, device %s\n", asd_ha->name, pci_name(dev));
 
 	SHOST_TO_SAS_HA(shost) = &asd_ha->sas_ha;
-	asd_ha->sas_ha.core.shost = shost;
+	asd_ha->sas_ha.shost = shost;
 	shost->transportt = aic94xx_transport_template;
 	shost->max_id = ~0;
 	shost->max_lun = ~0;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 72dd5e3ad9da..bd5f39de83d1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -2514,7 +2514,7 @@ int hisi_sas_probe(struct platform_device *pdev,
 	sha->dev = hisi_hba->dev;
 	sha->sas_addr = &hisi_hba->sas_addr[0];
 	sha->num_phys = hisi_hba->n_phy;
-	sha->core.shost = hisi_hba->shost;
+	sha->shost = hisi_hba->shost;
 
 	for (i = 0; i < hisi_hba->n_phy; i++) {
 		sha->sas_phy[i] = &hisi_hba->phy[i].sas_phy;
@@ -2556,12 +2556,12 @@ void hisi_sas_remove(struct platform_device *pdev)
 {
 	struct sas_ha_struct *sha = platform_get_drvdata(pdev);
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
-	struct Scsi_Host *shost = sha->core.shost;
+	struct Scsi_Host *shost = sha->shost;
 
 	del_timer_sync(&hisi_hba->timer);
 
 	sas_unregister_ha(sha);
-	sas_remove_host(sha->core.shost);
+	sas_remove_host(shost);
 
 	hisi_sas_free(hisi_hba);
 	scsi_host_put(shost);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 7b40f0eed703..813807a24ae1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4956,7 +4956,7 @@ hisi_sas_v3_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	sha->sas_phy = arr_phy;
 	sha->sas_port = arr_port;
-	sha->core.shost = shost;
+	sha->shost = shost;
 	sha->lldd_ha = hisi_hba;
 
 	shost->transportt = hisi_sas_stt;
@@ -5060,14 +5060,14 @@ static void hisi_sas_v3_remove(struct pci_dev *pdev)
 	struct device *dev = &pdev->dev;
 	struct sas_ha_struct *sha = dev_get_drvdata(dev);
 	struct hisi_hba *hisi_hba = sha->lldd_ha;
-	struct Scsi_Host *shost = sha->core.shost;
+	struct Scsi_Host *shost = sha->shost;
 
 	pm_runtime_get_noresume(dev);
 	del_timer_sync(&hisi_hba->timer);
 
 	sas_unregister_ha(sha);
 	flush_workqueue(hisi_hba->wq);
-	sas_remove_host(sha->core.shost);
+	sas_remove_host(shost);
 
 	hisi_sas_v3_destroy_irqs(pdev, hisi_hba);
 	hisi_sas_free(hisi_hba);
diff --git a/drivers/scsi/isci/host.h b/drivers/scsi/isci/host.h
index 6bc3f022630a..52388374cf31 100644
--- a/drivers/scsi/isci/host.h
+++ b/drivers/scsi/isci/host.h
@@ -306,7 +306,7 @@ static inline struct isci_pci_info *to_pci_info(struct pci_dev *pdev)
 
 static inline struct Scsi_Host *to_shost(struct isci_host *ihost)
 {
-	return ihost->sas_ha.core.shost;
+	return ihost->sas_ha.shost;
 }
 
 #define for_each_isci_host(id, ihost, pdev) \
diff --git a/drivers/scsi/isci/init.c b/drivers/scsi/isci/init.c
index c3704208511b..db4784cc976a 100644
--- a/drivers/scsi/isci/init.c
+++ b/drivers/scsi/isci/init.c
@@ -574,7 +574,7 @@ static struct isci_host *isci_host_alloc(struct pci_dev *pdev, int id)
 		goto err_shost;
 
 	SHOST_TO_SAS_HA(shost) = &ihost->sas_ha;
-	ihost->sas_ha.core.shost = shost;
+	ihost->sas_ha.shost = shost;
 	shost->transportt = isci_transport_template;
 
 	shost->max_id = ~0;
@@ -729,7 +729,7 @@ static int isci_resume(struct device *dev)
 		sas_prep_resume_ha(&ihost->sas_ha);
 
 		isci_host_init(ihost);
-		isci_host_start(ihost->sas_ha.core.shost);
+		isci_host_start(ihost->sas_ha.shost);
 		wait_for_start(ihost);
 
 		sas_resume_ha(&ihost->sas_ha);
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 77714a495cbb..2d29154ca8ef 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -162,7 +162,7 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 	struct ata_port *ap = qc->ap;
 	struct domain_device *dev = ap->private_data;
 	struct sas_ha_struct *sas_ha = dev->port->ha;
-	struct Scsi_Host *host = sas_ha->core.shost;
+	struct Scsi_Host *host = sas_ha->shost;
 	struct sas_internal *i = to_sas_internal(host->transportt);
 
 	/* TODO: we should try to remove that unlock */
@@ -235,7 +235,7 @@ static void sas_ata_qc_fill_rtf(struct ata_queued_cmd *qc)
 
 static struct sas_internal *dev_to_sas_internal(struct domain_device *dev)
 {
-	return to_sas_internal(dev->port->ha->core.shost->transportt);
+	return to_sas_internal(dev->port->ha->shost->transportt);
 }
 
 static int sas_get_ata_command_set(struct domain_device *dev)
@@ -584,7 +584,7 @@ static struct ata_port_info sata_port_info = {
 int sas_ata_init(struct domain_device *found_dev)
 {
 	struct sas_ha_struct *ha = found_dev->port->ha;
-	struct Scsi_Host *shost = ha->core.shost;
+	struct Scsi_Host *shost = ha->shost;
 	struct ata_host *ata_host;
 	struct ata_port *ap;
 	int rc;
@@ -822,7 +822,7 @@ static void async_sas_ata_eh(void *data, async_cookie_t cookie)
 	struct sas_ha_struct *ha = dev->port->ha;
 
 	sas_ata_printk(KERN_DEBUG, dev, "dev error handler\n");
-	ata_scsi_port_error_handler(ha->core.shost, ap);
+	ata_scsi_port_error_handler(ha->shost, ap);
 	sas_put_device(dev);
 }
 
diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 8c6afe724944..15cb9965faa2 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -170,7 +170,7 @@ int sas_notify_lldd_dev_found(struct domain_device *dev)
 {
 	int res = 0;
 	struct sas_ha_struct *sas_ha = dev->port->ha;
-	struct Scsi_Host *shost = sas_ha->core.shost;
+	struct Scsi_Host *shost = sas_ha->shost;
 	struct sas_internal *i = to_sas_internal(shost->transportt);
 
 	if (!i->dft->lldd_dev_found)
@@ -192,7 +192,7 @@ int sas_notify_lldd_dev_found(struct domain_device *dev)
 void sas_notify_lldd_dev_gone(struct domain_device *dev)
 {
 	struct sas_ha_struct *sas_ha = dev->port->ha;
-	struct Scsi_Host *shost = sas_ha->core.shost;
+	struct Scsi_Host *shost = sas_ha->shost;
 	struct sas_internal *i = to_sas_internal(shost->transportt);
 
 	if (!i->dft->lldd_dev_gone)
@@ -234,7 +234,7 @@ static void sas_suspend_devices(struct work_struct *work)
 	struct domain_device *dev;
 	struct sas_discovery_event *ev = to_sas_discovery_event(work);
 	struct asd_sas_port *port = ev->port;
-	struct Scsi_Host *shost = port->ha->core.shost;
+	struct Scsi_Host *shost = port->ha->shost;
 	struct sas_internal *si = to_sas_internal(shost->transportt);
 
 	clear_bit(DISCE_SUSPEND, &port->disc.pending);
@@ -373,7 +373,7 @@ static bool sas_abort_cmd(struct request *req, void *data)
 static void sas_abort_device_scsi_cmds(struct domain_device *dev)
 {
 	struct sas_ha_struct *sas_ha = dev->port->ha;
-	struct Scsi_Host *shost = sas_ha->core.shost;
+	struct Scsi_Host *shost = sas_ha->shost;
 
 	if (dev_is_expander(dev->dev_type))
 		return;
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index adcac57aaee6..a2204674b680 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -37,7 +37,7 @@ static int smp_execute_task_sg(struct domain_device *dev,
 	int res, retry;
 	struct sas_task *task = NULL;
 	struct sas_internal *i =
-		to_sas_internal(dev->port->ha->core.shost->transportt);
+		to_sas_internal(dev->port->ha->shost->transportt);
 	struct sas_ha_struct *ha = dev->port->ha;
 
 	pm_runtime_get_sync(ha->dev);
diff --git a/drivers/scsi/libsas/sas_host_smp.c b/drivers/scsi/libsas/sas_host_smp.c
index 32cdc969b736..2ecb8535634c 100644
--- a/drivers/scsi/libsas/sas_host_smp.c
+++ b/drivers/scsi/libsas/sas_host_smp.c
@@ -114,7 +114,7 @@ static int sas_host_smp_write_gpio(struct sas_ha_struct *sas_ha, u8 *resp_data,
 				   u8 reg_type, u8 reg_index, u8 reg_count,
 				   u8 *req_data)
 {
-	struct sas_internal *i = to_sas_internal(sas_ha->core.shost->transportt);
+	struct sas_internal *i = to_sas_internal(sas_ha->shost->transportt);
 	int written;
 
 	if (i->dft->lldd_write_gpio == NULL) {
@@ -182,7 +182,7 @@ static void sas_phy_control(struct sas_ha_struct *sas_ha, u8 phy_id,
 			    enum sas_linkrate max, u8 *resp_data)
 {
 	struct sas_internal *i =
-		to_sas_internal(sas_ha->core.shost->transportt);
+		to_sas_internal(sas_ha->shost->transportt);
 	struct sas_phy_linkrates rates;
 	struct asd_sas_phy *asd_phy;
 
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index f2c05ebeb72f..8586dc79f2a0 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -183,7 +183,7 @@ static int sas_get_linkerrors(struct sas_phy *phy)
 		struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(shost);
 		struct asd_sas_phy *asd_phy = sas_ha->sas_phy[phy->number];
 		struct sas_internal *i =
-			to_sas_internal(sas_ha->core.shost->transportt);
+			to_sas_internal(sas_ha->shost->transportt);
 
 		return i->dft->lldd_control_phy(asd_phy, PHY_FUNC_GET_EVENTS, NULL);
 	}
@@ -232,7 +232,7 @@ static int transport_sas_phy_reset(struct sas_phy *phy, int hard_reset)
 		struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(shost);
 		struct asd_sas_phy *asd_phy = sas_ha->sas_phy[phy->number];
 		struct sas_internal *i =
-			to_sas_internal(sas_ha->core.shost->transportt);
+			to_sas_internal(sas_ha->shost->transportt);
 
 		if (!hard_reset && sas_try_ata_reset(asd_phy) == 0)
 			return 0;
@@ -266,7 +266,7 @@ int sas_phy_enable(struct sas_phy *phy, int enable)
 		struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(shost);
 		struct asd_sas_phy *asd_phy = sas_ha->sas_phy[phy->number];
 		struct sas_internal *i =
-			to_sas_internal(sas_ha->core.shost->transportt);
+			to_sas_internal(sas_ha->shost->transportt);
 
 		if (enable)
 			ret = transport_sas_phy_reset(phy, 0);
@@ -303,7 +303,7 @@ int sas_phy_reset(struct sas_phy *phy, int hard_reset)
 		struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(shost);
 		struct asd_sas_phy *asd_phy = sas_ha->sas_phy[phy->number];
 		struct sas_internal *i =
-			to_sas_internal(sas_ha->core.shost->transportt);
+			to_sas_internal(sas_ha->shost->transportt);
 
 		ret = i->dft->lldd_control_phy(asd_phy, reset_type, NULL);
 	} else {
@@ -339,7 +339,7 @@ int sas_set_phy_speed(struct sas_phy *phy,
 		struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(shost);
 		struct asd_sas_phy *asd_phy = sas_ha->sas_phy[phy->number];
 		struct sas_internal *i =
-			to_sas_internal(sas_ha->core.shost->transportt);
+			to_sas_internal(sas_ha->shost->transportt);
 
 		ret = i->dft->lldd_control_phy(asd_phy, PHY_FUNC_SET_LINK_RATE,
 					       rates);
@@ -438,7 +438,7 @@ static void _sas_resume_ha(struct sas_ha_struct *ha, bool drain)
 	/* all phys are back up or timed out, turn on i/o so we can
 	 * flush out disks that did not return
 	 */
-	scsi_unblock_requests(ha->core.shost);
+	scsi_unblock_requests(ha->shost);
 	if (drain)
 		sas_drain_work(ha);
 	clear_bit(SAS_HA_RESUMING, &ha->state);
@@ -468,7 +468,7 @@ void sas_suspend_ha(struct sas_ha_struct *ha)
 	int i;
 
 	sas_disable_events(ha);
-	scsi_block_requests(ha->core.shost);
+	scsi_block_requests(ha->shost);
 	for (i = 0; i < ha->num_phys; i++) {
 		struct asd_sas_port *port = ha->sas_port[i];
 
@@ -641,7 +641,7 @@ struct asd_sas_event *sas_alloc_event(struct asd_sas_phy *phy,
 	struct asd_sas_event *event;
 	struct sas_ha_struct *sas_ha = phy->ha;
 	struct sas_internal *i =
-		to_sas_internal(sas_ha->core.shost->transportt);
+		to_sas_internal(sas_ha->shost->transportt);
 
 	event = kmem_cache_zalloc(sas_event_cache, gfp_flags);
 	if (!event)
diff --git a/drivers/scsi/libsas/sas_phy.c b/drivers/scsi/libsas/sas_phy.c
index a0d592d11dfb..57494ac97076 100644
--- a/drivers/scsi/libsas/sas_phy.c
+++ b/drivers/scsi/libsas/sas_phy.c
@@ -38,7 +38,7 @@ static void sas_phye_oob_error(struct work_struct *work)
 	struct sas_ha_struct *sas_ha = phy->ha;
 	struct asd_sas_port *port = phy->port;
 	struct sas_internal *i =
-		to_sas_internal(sas_ha->core.shost->transportt);
+		to_sas_internal(sas_ha->shost->transportt);
 
 	sas_deform_port(phy, 1);
 
@@ -66,7 +66,7 @@ static void sas_phye_spinup_hold(struct work_struct *work)
 	struct asd_sas_phy *phy = ev->phy;
 	struct sas_ha_struct *sas_ha = phy->ha;
 	struct sas_internal *i =
-		to_sas_internal(sas_ha->core.shost->transportt);
+		to_sas_internal(sas_ha->shost->transportt);
 
 	phy->error = 0;
 	i->dft->lldd_control_phy(phy, PHY_FUNC_RELEASE_SPINUP_HOLD, NULL);
@@ -95,7 +95,7 @@ static void sas_phye_shutdown(struct work_struct *work)
 	struct asd_sas_phy *phy = ev->phy;
 	struct sas_ha_struct *sas_ha = phy->ha;
 	struct sas_internal *i =
-		to_sas_internal(sas_ha->core.shost->transportt);
+		to_sas_internal(sas_ha->shost->transportt);
 
 	if (phy->enabled) {
 		int ret;
@@ -131,7 +131,7 @@ int sas_register_phys(struct sas_ha_struct *sas_ha)
 		spin_lock_init(&phy->sas_prim_lock);
 		phy->frame_rcvd_size = 0;
 
-		phy->phy = sas_phy_alloc(&sas_ha->core.shost->shost_gendev, i);
+		phy->phy = sas_phy_alloc(&sas_ha->shost->shost_gendev, i);
 		if (!phy->phy)
 			return -ENOMEM;
 
diff --git a/drivers/scsi/libsas/sas_port.c b/drivers/scsi/libsas/sas_port.c
index 7893c462169a..e3f2ed913419 100644
--- a/drivers/scsi/libsas/sas_port.c
+++ b/drivers/scsi/libsas/sas_port.c
@@ -28,7 +28,7 @@ static void sas_resume_port(struct asd_sas_phy *phy)
 	struct domain_device *dev, *n;
 	struct asd_sas_port *port = phy->port;
 	struct sas_ha_struct *sas_ha = phy->ha;
-	struct sas_internal *si = to_sas_internal(sas_ha->core.shost->transportt);
+	struct sas_internal *si = to_sas_internal(sas_ha->shost->transportt);
 
 	if (si->dft->lldd_port_formed)
 		si->dft->lldd_port_formed(phy);
@@ -108,7 +108,7 @@ static void sas_form_port(struct asd_sas_phy *phy)
 	struct asd_sas_port *port = phy->port;
 	struct domain_device *port_dev = NULL;
 	struct sas_internal *si =
-		to_sas_internal(sas_ha->core.shost->transportt);
+		to_sas_internal(sas_ha->shost->transportt);
 	unsigned long flags;
 
 	if (port) {
@@ -211,7 +211,7 @@ void sas_deform_port(struct asd_sas_phy *phy, int gone)
 	struct sas_ha_struct *sas_ha = phy->ha;
 	struct asd_sas_port *port = phy->port;
 	struct sas_internal *si =
-		to_sas_internal(sas_ha->core.shost->transportt);
+		to_sas_internal(sas_ha->shost->transportt);
 	struct domain_device *dev;
 	unsigned long flags;
 
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 94c5f14f3c16..86b5d6b87282 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -279,7 +279,7 @@ static enum task_disposition sas_scsi_find_task(struct sas_task *task)
 	unsigned long flags;
 	int i, res;
 	struct sas_internal *si =
-		to_sas_internal(task->dev->port->ha->core.shost->transportt);
+		to_sas_internal(task->dev->port->ha->shost->transportt);
 
 	for (i = 0; i < 5; i++) {
 		pr_notice("%s: aborting task 0x%p\n", __func__, task);
@@ -327,7 +327,7 @@ static int sas_recover_lu(struct domain_device *dev, struct scsi_cmnd *cmd)
 	int res = TMF_RESP_FUNC_FAILED;
 	struct scsi_lun lun;
 	struct sas_internal *i =
-		to_sas_internal(dev->port->ha->core.shost->transportt);
+		to_sas_internal(dev->port->ha->shost->transportt);
 
 	int_to_scsilun(cmd->device->lun, &lun);
 
@@ -355,7 +355,7 @@ static int sas_recover_I_T(struct domain_device *dev)
 {
 	int res = TMF_RESP_FUNC_FAILED;
 	struct sas_internal *i =
-		to_sas_internal(dev->port->ha->core.shost->transportt);
+		to_sas_internal(dev->port->ha->shost->transportt);
 
 	pr_notice("I_T nexus reset for dev %016llx\n",
 		  SAS_ADDR(dev->sas_addr));
@@ -410,7 +410,7 @@ static void sas_wait_eh(struct domain_device *dev)
 	spin_unlock_irq(&ha->lock);
 
 	/* make sure SCSI EH is complete */
-	if (scsi_host_in_recovery(ha->core.shost)) {
+	if (scsi_host_in_recovery(ha->shost)) {
 		msleep(10);
 		goto retry;
 	}
@@ -440,7 +440,7 @@ static int sas_queue_reset(struct domain_device *dev, int reset_type,
 			set_bit(SAS_DEV_EH_PENDING, &dev->state);
 			set_bit(reset_type, &dev->state);
 			int_to_scsilun(lun, &dev->ssp_dev.reset_lun);
-			scsi_schedule_eh(ha->core.shost);
+			scsi_schedule_eh(ha->shost);
 		}
 		spin_unlock_irq(&ha->lock);
 
@@ -925,7 +925,7 @@ static int sas_execute_internal_abort(struct domain_device *device,
 				      unsigned int qid, void *data)
 {
 	struct sas_ha_struct *ha = device->port->ha;
-	struct sas_internal *i = to_sas_internal(ha->core.shost->transportt);
+	struct sas_internal *i = to_sas_internal(ha->shost->transportt);
 	struct sas_task *task = NULL;
 	int res, retry;
 
@@ -1015,7 +1015,7 @@ int sas_execute_tmf(struct domain_device *device, void *parameter,
 {
 	struct sas_task *task;
 	struct sas_internal *i =
-		to_sas_internal(device->port->ha->core.shost->transportt);
+		to_sas_internal(device->port->ha->shost->transportt);
 	int res, retry;
 
 	for (retry = 0; retry < TASK_RETRY; retry++) {
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index d5cf563e9094..43ebb331e216 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -414,7 +414,7 @@ static int mvs_prep_sas_ha_init(struct Scsi_Host *shost,
 
 	sha->sas_phy = arr_phy;
 	sha->sas_port = arr_port;
-	sha->core.shost = shost;
+	sha->shost = shost;
 
 	sha->lldd_ha = kzalloc(sizeof(struct mvs_prv_info), GFP_KERNEL);
 	if (!sha->lldd_ha)
@@ -470,7 +470,7 @@ static void  mvs_post_sas_ha_init(struct Scsi_Host *shost,
 	shost->sg_tablesize = min_t(u16, SG_ALL, MVS_MAX_SG);
 	shost->can_queue = can_queue;
 	mvi->shost->cmd_per_lun = MVS_QUEUE_SIZE;
-	sha->core.shost = mvi->shost;
+	sha->shost = mvi->shost;
 }
 
 static void mvs_init_sas_add(struct mvs_info *mvi)
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 0ffde0bcd737..8ed3bb1f698a 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -654,7 +654,7 @@ static void  pm8001_post_sas_ha_init(struct Scsi_Host *shost,
 	sha->strict_wide_ports = 1;
 	sha->sas_addr = &pm8001_ha->sas_addr[0];
 	sha->num_phys = chip_info->n_phy;
-	sha->core.shost = shost;
+	sha->shost = shost;
 }
 
 /**
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index e54bcdc1ecd1..d42bfdff7812 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -333,11 +333,6 @@ struct asd_sas_phy {
 	void *lldd_phy;		  /* not touched by the sas_class_code */
 };
 
-struct scsi_core {
-	struct Scsi_Host *shost;
-
-};
-
 enum sas_ha_state {
 	SAS_HA_REGISTERED,
 	SAS_HA_DRAINING,
@@ -358,7 +353,7 @@ struct sas_ha_struct {
 
 	struct mutex disco_mutex;
 
-	struct scsi_core core;
+	struct Scsi_Host *shost;
 
 /* public: */
 	char *sas_ha_name;
-- 
2.35.3

