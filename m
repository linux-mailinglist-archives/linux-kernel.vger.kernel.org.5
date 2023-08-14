Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E0277BB41
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjHNOL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbjHNOLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACE718E;
        Mon, 14 Aug 2023 07:11:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECfjYr011034;
        Mon, 14 Aug 2023 14:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2fuH3p/3n/cfA1BIuqfB9Bpg8gENm/NfOHr9YMez4Ks=;
 b=CIeNAwAZB4RXhZaRk3Ds0H0FSGL3usWCVBDsztc/HhBUlz36B9Poy3ir1ijNBPAA8HYn
 2Va694YjkklWcLnGP+lMdMluu0G+zttI8e9LFWJxp56ptlSXz84SqHz/2LbpPuB7VH2a
 kWymQdz6p6Q6m02v4rYKOGcrU5IHZ7X9nUs+6voB6R7GvZ60zHoi6GUfwggckijXuxet
 ioDooZkAx2x6wbDBujvIFr51H1iBpik1ur6Kxt71Zn2G6n/jKkMc4PH91DaLxt3AYkJz
 FYiESqmhvfvzWLdmmECzs4zRj6K/aPM0N8zEd6+O+kMDJBGEKpZ/YR4s0W+hhy8ctSmP Fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se349aqkr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDdYtB003759;
        Mon, 14 Aug 2023 14:11:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sexygpue1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqVsJTk8WwDbE9JXNwW3MlBk9BuOuk7B7TSIGYnc2Vmpllhstxx8omP+0zijztFmAZHql32i+beKIlfmfA9/MB7+P9x4b66/L1ePSbPzv/SasrBrLvS0eTZ3UN2vraEF6zibPrnMVryslNv0Wz1m0STfa+aD2awxs7Sk6alnH/T/4yWkETzBzYG2rvER5hHhrdGfwOexjrY7i1KBcR8eVKgZeUr85UsvHrZ9VTWsIzkw8KlCv0j8Lvws7jVwg1DpX9yPt1j06GwYC4PhqCTBz+KAyUeqBgUGVRwu6sQEZwsoAhV3sr3nVwwPTSfEot4wzHoFGlKQb9b1Mvbk+sXtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fuH3p/3n/cfA1BIuqfB9Bpg8gENm/NfOHr9YMez4Ks=;
 b=XKwuPHO1J6tr36ukp38zI0KyUZRdL8y86ItPff6wmbo8KD4JPHYsjO/Ujwnup+zK3vWo6VX1ybOKS7DrWMdgWEVZtpkRld5QARE/MAPvKhlvv/4Ne+LTKF8DwKLcfayuJEZk25K+u3uk3SOMyvPEsAaPCNKD4BpgEoD8LIU1plliqB5SjfWWIr7ZzMqVgPnCx9Mhbqsm5ikrETe6tosbjjtZc0rDq92TBdFGbj3NhBFD99YIIvb0PcuT1sqGVx0KuWow80WcobuOrLCQXsloh0YX6kN34zjqKgw5PWJtjBfU+GcvMBOAqrbqr+SjqP3t3sUq7qXA2OVM+94tyAN8+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fuH3p/3n/cfA1BIuqfB9Bpg8gENm/NfOHr9YMez4Ks=;
 b=ibW4Z7T/PKmcENQV/9wWP/mXsXD505PT5f7aJIQkgpSwk5HSW/JfBqfsVk1Az7AFDaNWIeM2wKY2YAbi+VYeqEVMPuc1bRnnVcuQSY3o+GObx8fSJ0b/Qexx5n9MXEBzeDn5mkGhIkahLmMiFfFTMD9cltHP7d/Nui++TbAgqHE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5629.namprd10.prod.outlook.com (2603:10b6:a03:3e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 14:11:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:11:04 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 05/10] scsi: libsas: Delete sas_ssp_task.retry_count
Date:   Mon, 14 Aug 2023 14:10:17 +0000
Message-Id: <20230814141022.36875-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:5:14c::42) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: 295365c2-2650-403e-31a0-08db9cd04bd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IwEFi62t6/PqGhNLSTpwPqQg5d2wei05s1H8a+YIS6Yhr3ie0TpOZ/Y3foiTg0HhnHnSF/4mIkbJKd0aaByXguoybDI993ATGbtfKYfrRLHsKLujzZ/s7muMU0iX3mlDEWfSypmgi40e70IH2U/9AqSBc/YhXaRbhlqIFyOr2ZZ6KfcT7ipDfRC5HIKHc4UHdNFSd0QiFMyazbnVwfeTlXvHWJSOZQ76PxXhw35UBOuzSsctAU1zZ96H737GlH7HeQ4tpjk/sXu+Ic5rQ8a0JlV2a/T7+tD6E5pqfsw3Ggt8bbhweR8a5SRpgNtFkm986t/Iy/8f+d6zppo0kndKQS0pmbB+3ZHyzBVoJ+942QNETLySjLz8FiUmKvp8Y6xPmzPjxUMr8hPnkO4MZNdwe8TjwcvIgxL6bsrkaTdp22bqVjrv7YEtnVpY+1BjrjWqtTuwXFwrJxgM7jl0Bxbficy3+5Gt8wdpTwz985xTdJYoF7o4vlnA07kxTEEa2f4gveqqA+RasE5Rb1qbgw0BQYRhatIj1oT9encvKBKFQcU0rXJXRw0QmvpiZiBo1O5z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(1800799006)(186006)(6666004)(6486002)(6506007)(478600001)(103116003)(36756003)(86362001)(83380400001)(6512007)(26005)(107886003)(1076003)(66946007)(2616005)(2906002)(38100700002)(316002)(4326008)(66556008)(66476007)(8676002)(5660300002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K/Krg3tyTCivyGesIC2Flr6A09oIrpQjl4rg0vwAx8oKvvbbTLomjcA0QuiQ?=
 =?us-ascii?Q?tH0ITLk7r040ovHMzlFOxUjzAiGDUIP1LR6DEdiB+48f1mWXVP1J5WVIGNVX?=
 =?us-ascii?Q?iRBVPmKsCOwhWiQx6RcgDt/ZPXpGnbEGZ1+mLbeqy72rqKvI1C6s24FzFtME?=
 =?us-ascii?Q?ohxDM3sLPnd1OKU7NYoxyAdQv/HMDMPcXeeaBc8MY9oZCCvf2f3TqhuEJlTO?=
 =?us-ascii?Q?Heyw1Oq8sFdFQDDLWYthTFAjKEMunBvepvTjpSGQ7DqClPjWwj+gXiyK6VhA?=
 =?us-ascii?Q?+EhTv2sWxfZHNS3YKZMlqLUu2hcUEVNLnChwKf9Z5hIllZU8NlJS+uANTrgs?=
 =?us-ascii?Q?bNUfoBC1pQKQg1vCnb1PQ57sjw4L0bMSZE5sKOavoBpA3swKzq1qnME2QFEF?=
 =?us-ascii?Q?czqrBjA4yc+Cz83xp7UtT0bzoN7GDqEJJQbDuNqvoPmMCoIOmktBtWROQZLp?=
 =?us-ascii?Q?W0NLRsgbClJ33S9fmlO8GLYS9lEBkqtIsbMBofYFQnzjMI9R6og4+d+lIeFA?=
 =?us-ascii?Q?w5PykzMTPW6tR8UgXPBWu0GRV+vQ78G8/Jx+Qa3m5VL5aTT0j/7M1AFTESqk?=
 =?us-ascii?Q?7h5zllOlSKMoy9nO5ZI8DzqZgakfc2MMNipWQmpq7JEXRrlVQ43YHb1TOvdF?=
 =?us-ascii?Q?DZ5bAAWGeH7cJ6i/D4CwpTh0Utw/1HiJHhWVnNGgeuVHtM+fI66ArlgM52sn?=
 =?us-ascii?Q?RKdUtXJAOA8O50YE0kGla3NDPyjXglFrX/5ur/9C23AbPdCPBglGdYN7dSGT?=
 =?us-ascii?Q?cD7eWpy0WFOtAWbMxtcuv+AdCZtPLLT/smMyL/ZBIhU7yIoM+LbzvbKiq6JQ?=
 =?us-ascii?Q?qy4JP/1YCtnHs14wd7zlEwQULXXLJ2WF9NdKb9ETFG2xZ668L3Vlwd4SXIbk?=
 =?us-ascii?Q?7v9AP4ZsVJw6dGKf9LlELqtSF4Y7LwqyDryAT5os4TX2O2EZc9KgQsOo2aUB?=
 =?us-ascii?Q?s7EJMi7dTM5U0Kb5E5lVOgOVywFe0vCdBjlE1W4xnipS68rMkAHn4Lni4I3E?=
 =?us-ascii?Q?tbE3E6RjksE+d+o9CuLqH7CmqDs1M7fVP2Hv990CPfSQaeEgiHNfgOjt6Fdq?=
 =?us-ascii?Q?Ka3ivdFyMBsA8QYaTRjhPqNLo4DQcEPTzFvtURc2n0Gvv3jU2GhvsDNaj/fC?=
 =?us-ascii?Q?1zlQRAeX1MopWvILPstyyC+gFbglRHyXO4m23Gav27Xf4jOoVdzRo/gZUvJJ?=
 =?us-ascii?Q?La3DeLXoJlXP+D0O6KGMj2FQ5Dtc1T+vfPhjjvdcyBFShaR4GTV0fNrtjkax?=
 =?us-ascii?Q?3NhCD4LZOrdAKCMbxVZOveLAJiJRVkctgZT4JOONcMgjn2bW7rpKNE6e4Y6C?=
 =?us-ascii?Q?ZoCpuQwkaWmflGPssWNLvnxUbHa3JpElMkQ0jGGdoVvohtPHXbUcj4r/Fj2Y?=
 =?us-ascii?Q?g6Ju/kLvkqwTT2mP69qfEMgcC/d8m7gUz12eUv1/ik69D0PbeGhQKJJA9GRZ?=
 =?us-ascii?Q?d0DjyAh5uR+blgYOfF/pPw7Qt7pj2Y+KgtutokkWFiDxnj86FHYTOvvSF5/U?=
 =?us-ascii?Q?WSQq9zCV1bUJ5lV2xRgT0vlNDqWTDhZ1fpfvLfD0Mcq/A3+5sAfv87RTyXoy?=
 =?us-ascii?Q?ntQxpfyeJ9B0PdIw10VIaTR5nm4oxH/dExtWsNhUSI0k3Sb9IudsArJNutCO?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?Ms4pnayBGVZBEU5zcE5m1dBaWxPyJrKMjMGyqETcO8BBzsW+dI7Mz1AGALRg?=
 =?us-ascii?Q?PIe/GLDZdUKeXIDVKp+4OJGErpffp1y4exKRoaBhcRp/GukBjv6/5bAq3psr?=
 =?us-ascii?Q?Zy9HvEQFUnTBBPpmr3fAWdZ1+eCQDwsCzl8c4rMJE7XOL1h9umGTmKE1H5ML?=
 =?us-ascii?Q?yssUiKJqAj6YFhgmn6Vnr41ZvV+1CNZgrTKhiB8a5TpoOaFRcZeEHEBDITz5?=
 =?us-ascii?Q?yAEhqMPN8NQ/qHOCyZSEdYhE82iyeoaQ8PoIGy7RTJoj01Knhg+6clBonvOX?=
 =?us-ascii?Q?IFmcRbv/Je0pV4y9hST4gJY2rPMhmCsnN0dbPIkwUgUeCpWEPCFog1TEPajG?=
 =?us-ascii?Q?FFhKmnttFyFst3l3TlKPWC/OcOSsEr7okC8StamPrYVVQmOEDN0nEJxQ2xat?=
 =?us-ascii?Q?8ZrMUBVDozgGErQTb4jYuoS6hTzCsCSfWao2VnXx0H+S9CT2cFBvCmlAvJRJ?=
 =?us-ascii?Q?pI+gpER3+fMa6VrIQM7ebd/myOxM5rcQj3xn5u2I76Bj9qT/EmE2uBw9Iotl?=
 =?us-ascii?Q?jejmYioiKXAI4JEQQooGS4Oedbr0j5QvQKQaQQv32FBGipxTOItql9jAUE8k?=
 =?us-ascii?Q?LR0rIHnVRs0YyZJPV3j/VlnK2qR1HOaDhF6if6Bq70pG8Mp4l4913GzYLPt3?=
 =?us-ascii?Q?HdOUTCiCacGrKgRtEM5ytM+izybaOqyHtcuErT/+GDu/OwaFSUgg4+rLhTLv?=
 =?us-ascii?Q?yMbjgFcfXOajmKBrY8M9g4Z/+KUM6wlOmCm4HDPWr7E34UGH0m9qFPbV33Sg?=
 =?us-ascii?Q?R2zxL3m2JVBGwPyTmtpPVg1xICO875vlA+5o+iwXRToSCO+gGYARY7cDVVls?=
 =?us-ascii?Q?Fg1Hah1Btt8xQ7Uij6yYwXyl9kRZYsnX9Y6SaAV+0KEyUqxKuB8rLzu9fXWf?=
 =?us-ascii?Q?Wixy0T4ARtYzUh6kwweCDVt4KHI8i3sYF9suMwT2ja9BNAZ8/XYmpI4CyhfL?=
 =?us-ascii?Q?h80TztqaPvo1mpObwSfpJQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295365c2-2650-403e-31a0-08db9cd04bd4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:11:04.3197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MW6KGNQTlbwPBn3kPs0n9FVuXVF6ujDo11EWG4rbDfJN10vZA9ubrUUufG1ufrG9D4o9jNfMHQncf4nvn38ujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140131
X-Proofpoint-GUID: -Ubu2piWH9aU9DskbkvgzsOltCqGjRtK
X-Proofpoint-ORIG-GUID: -Ubu2piWH9aU9DskbkvgzsOltCqGjRtK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
driver"), sas_ssp_task.retry_count is only ever set, so delete it.

The aic94xx driver also had its own retry_count definition in struct scb
sub-structs, which may have caused a mix-up.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/libsas/sas_ata.c       | 1 -
 drivers/scsi/libsas/sas_scsi_host.c | 1 -
 include/scsi/libsas.h               | 2 --
 3 files changed, 4 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 2d29154ca8ef..ed9af2b401ef 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -201,7 +201,6 @@ static unsigned int sas_ata_qc_issue(struct ata_queued_cmd *qc)
 		task->data_dir = qc->dma_dir;
 	}
 	task->scatter = qc->sg;
-	task->ata_task.retry_count = 1;
 	qc->lldd_task = task;
 
 	task->ata_task.use_ncq = ata_is_ncq(qc->tf.protocol);
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 86b5d6b87282..0c103f4523b8 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -142,7 +142,6 @@ static struct sas_task *sas_create_task(struct scsi_cmnd *cmd,
 	task->dev = dev;
 	task->task_proto = task->dev->tproto; /* BUG_ON(!SSP) */
 
-	task->ssp_task.retry_count = 1;
 	int_to_scsilun(cmd->device->lun, &lun);
 	memcpy(task->ssp_task.LUN, &lun.scsi_lun, 8);
 	task->ssp_task.task_attr = TASK_ATTR_SIMPLE;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index d42bfdff7812..d8222c442640 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -563,8 +563,6 @@ enum task_attribute {
 };
 
 struct sas_ssp_task {
-	u8     retry_count;	  /* hardware retry, should be > 0 */
-
 	u8     LUN[8];
 	u8     enable_first_burst:1;
 	enum   task_attribute task_attr;
-- 
2.35.3

