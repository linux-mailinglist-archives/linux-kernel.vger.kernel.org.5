Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3177BB47
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjHNOMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjHNOLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:42 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36471705;
        Mon, 14 Aug 2023 07:11:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECiS4L015365;
        Mon, 14 Aug 2023 14:11:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=37Sh5CR7SvPEjCIXRW9X4ynzpCHUEcCXDLQspxCF0hc=;
 b=TZFllJLYPh4UdPyYbl6YtY8dAzkb8XEZvyZr7kGBHQVgSJdU7ydlWxFXo+TZ63I7rXHU
 VzmLdaTy+9EYbban6o80283FSIcbyYYBEsYFzj4SLlh5GGLB/rVAS6B+gfGpOb47IcPa
 ccnQQl0A/eI5yll5W/734+8bEYaJezxTiAcsN5dgG+gxf9TfUHtiPzqEOkkI7rDTdYi6
 TJK9nT4o603OD9jol3/FLBN8GSYOQNMleLe24cifayq4cOUGnBu+EPMnnJEfXLCzlz2o
 Fz8Bp2N0KumF3zM+puFliSyGtTNFFxjsvDFjUt6skAvnyVDrcMTzZzTSR3CX4Y5s12aH 1Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfjqd7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDJ2EY019914;
        Mon, 14 Aug 2023 14:11:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3u6pa6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JwkOtCdtPawzrYLyrspiD1oNvsX+W0nIXppoxMSP4m9647WQyLKSKaHhqxs/W15oRlc66p5+Qdy9N9A//L8C9+cvv0Va0Qh6NPmm9YHEzky2kshUktNGPLLXqR+YWXrxYwuZGNbsDSqtrNXbz3+6CMz+3pHNisIBZhvqAN7Iug0hDtrr6zhIDdGCdXW5kAuFVAPcFe39QPEfKZD/VTD9UA5O34PyN6oOgb58GNSZdYObA0uteswnBwaRkUtD+fgvaMXhkoGVMi+a2noW3+ZbKroC50FNjnsjX8UPgloN9PTveTiA4xZaolquiv9tA76tOSjlSnrnr0vuYG/1W+4GDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37Sh5CR7SvPEjCIXRW9X4ynzpCHUEcCXDLQspxCF0hc=;
 b=Vcf0gzJ3BNSI/tzWbvflmmsLggilMpt6cDsbqexVBLVZ/NG547wglb4tzGxmVzsF5XKlpv78nnvDQ1PGsa7Iclft7msAWyAB90tfOU8CxfFCMRTj3No4rW99dp6dcm9K6tiaSKfAqDff0ilc2IqE/DUXsEn3u/QrEzaBK5XXNmol2LCqKuc6mUADo39uuSnLkXKDknmqLpxzvtXIBerT+4qJtf8S+SOY0qaQsSMAm7rK+IGvBSoMWJH4T6JdAgiUc2Zri6u8SIxvXuYwNpK6c3gjvzQignn755fYK8VbfwZk4/YYgFYLFaPwEmxwy+xua0ubMqsK62EO48ndqZ4mWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37Sh5CR7SvPEjCIXRW9X4ynzpCHUEcCXDLQspxCF0hc=;
 b=gUY8+B3xFL0m9Oq3Ln+rD4fNpfYnnqe2HKDolkfblrg5TaUiglKsMDAu42CNGH2h1VbpfB33RYT1TnDBsSbhjQNnQFn2dj0fIbMVQrkBPzw6Weny/NmT805bcvbj9w84pq+XTA12clpt8e4bjR78ubQiE8ellziRgKoa57T6Frk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:11:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:11:21 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 10/10] scsi: libsas: Delete sas_ata_task.retry_count
Date:   Mon, 14 Aug 2023 14:10:22 +0000
Message-Id: <20230814141022.36875-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR07CA0009.namprd07.prod.outlook.com
 (2603:10b6:5:3af::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: a6082cd2-1590-4d6c-7f1c-08db9cd055db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I5LUawi8usiIYmHw5etJbUci/9Avb8IBaeoXIz5CP3hgr9zxBeVhsM63mkwgeMSHn6pQma7sQJSSHKcQjI1T4EM/ncN9LSWUrVOO+0f6rByaYrJZzn0xY96Tr0kcNuNmAOvQnVrM+1aFv+0n+EhDPQ+cqNOrJ6RX340badt/AwYjVU1qONYnJmEV2OuM5Gg6LfjiIM4GQMalL66unlb3naeJFViKQSagHYVquTmbOjQileGMmtcqzCywo1g/81tAZ36K5igB5XtQTLoz37rtvFJmud/bVsI6Qh6ndVD4NGaM2oIY4+D8W3DIKsKQRP6KS774U88NSpm65vkbyOtsfzhpaT1NSvxUmclsBMSJ4WXDc6myR8kXMPj6MUb/qEo0l7OiNNBbQx9dtwSqZP+4yFCiuhQJ4Xzw8KgIu7lU6LKkvMycWlK3vS2NveRdYsT0gfVkjJYwoQjgCYZWyYPMk2r3m7YlrZXbrpcbJrbmBgR/5yNE8u/Q6Y7Kr0m78bPJ9/4gKyBrAPoHlFGlJtaUzAsk1+d/b4htdj0kFCDQKEcOvn6tqT5FdESXSgtStmdG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(1800799006)(186006)(451199021)(38100700002)(36756003)(86362001)(103116003)(6512007)(6506007)(6486002)(478600001)(2906002)(1076003)(107886003)(2616005)(26005)(83380400001)(316002)(41300700001)(66946007)(66556008)(66476007)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCdpewP7PaHgPdM4zoumseFso1ssAu6VslV9GvP/k8bq6GhRHcKrpbiMRSj5?=
 =?us-ascii?Q?feeZVRlEnLme/eVyAYE8m+gkSQb2i7ouEV/R6Mzq169WwFoyhF7sGZumf2kp?=
 =?us-ascii?Q?KuCGOjYcIRNBgcOLJEDskf9VUPjeFTlIGYgoj8DgmizBD2t/BTgJTYES3YWB?=
 =?us-ascii?Q?7UhtnZSMUpQJijbiQn2GojkrykAi8O/DaNPt2qbHEzIbPi0Znt1LfoBIiwxm?=
 =?us-ascii?Q?UieuwDQgxTK7fZWnRi/X9a287YowOuAE7/PCbeZwZRqw537qBt7YQHewcJx7?=
 =?us-ascii?Q?tVaaQTQZili6ilMNs1NE55dBrKE4NWnBB3DoHGFfcnWJN18hhqB+YO48yHdp?=
 =?us-ascii?Q?JOPlXOlT0ry2yyfDIz2DKBWn/gfilDmQaCg+bQvDHF/ZYM0MNUrdakrkZhyU?=
 =?us-ascii?Q?U2WrlaVcuZmkbixTn7BgYAS+o1hERDF0ab3wXNk08axqDyyRLv3pKP+ILvp0?=
 =?us-ascii?Q?ndWXfTFzne+VjknfWQiqbTPA06y5mLV6oazJRKVkZn89/86zLL9/uWA6UVXM?=
 =?us-ascii?Q?q7VnctB8VbJgHO2mapSiSuVqM3RagXlqcBaB6uuvNgLmjxCOX8nUXA0ABQYF?=
 =?us-ascii?Q?UtSvybBXjw+SPKbhJrWQh5xwOnfXao48W9ntAK1XirwB/xguJp+EgCmw/PqC?=
 =?us-ascii?Q?+AWOV11klDjcd+nAwBoQuv7sZbtITx152x6MXPdkoNNkBDZTpiNhjFfhB4Iw?=
 =?us-ascii?Q?B//UnDNSINGxYhjP5gQmBBjbZJmQqHgHgUdo1XVRphm1OAmR/DJlNsbw0K1R?=
 =?us-ascii?Q?mS5YzHplbu5fFipmC8BofPZsyrqdGqcZ4eMsgzy5cdFqtRd2y7PaTFpItx8i?=
 =?us-ascii?Q?k3/cHNtp8+JIyIppCp9UV+TZiqNu5lnmVytfpA1OoRYzOG6coRsO/SH/zEKv?=
 =?us-ascii?Q?zDYwToM4kB1OEJ6uQ0sBPn4PW4XZG+5kR8QkgoljJIhiKbYnrkEp/d6Qs20m?=
 =?us-ascii?Q?ZqPA+PyCrqH5hIW8k7AMSaru6RnlMIF6AJpYznvSM6Bb7Io1V3vBT0THjngE?=
 =?us-ascii?Q?HfdOuVk+trP0KTVGHDbWZM7Z8UPBEr/4HKudY59WLpztF7/yZl8/OFL1YKsz?=
 =?us-ascii?Q?nUhU7Vl59eD8wNHL7bQQncYMwnzDEZVjsZLuNKxCPjNTlcQ9d0pzA3UBWbU4?=
 =?us-ascii?Q?wOhJbnldHmbf8dFHqkh4ODm6uEoUsiTe1tfUCq5YsiwUN89cLhEMIlrCYWZi?=
 =?us-ascii?Q?a9FVyUYXYFF+/Q4mM2BUBRrFfbzX3lb/xQJrnFdOn4rBSRNM6eWfi+oGZpyo?=
 =?us-ascii?Q?78zE0nLCY2MtysxrY5aqBEK3ln9fo93Qe3RrTIqPgv7yFTRZ+xLCdei8UOeP?=
 =?us-ascii?Q?PZ3ffB76x9OPw3YVbJAsT2WH780LxW6m8KjqK+L8fwEF5r9JwqaDUem4MvHq?=
 =?us-ascii?Q?Na5TIp6697U8Yz6Ef+QlGa79SQ9f9XjDHTQC6K8StqLTaSmpgE3J2fXwOBo2?=
 =?us-ascii?Q?LWa0g7V56at0dQhJSajVxSXdQqb3unFtms1YTNnGrGcWoD25fDzF27DRuXL/?=
 =?us-ascii?Q?ygpg6Vf4J4O4Pwa585HUoyn36LNFH/pHe9zxDiZDDev7Zz7nATjiYOxQN9T1?=
 =?us-ascii?Q?G0iGGNoeOR6m3nON3N03Hdhz/f4lPdUpbIHQgoDCJ+1UUwmox1zDuQkhztgm?=
 =?us-ascii?Q?iw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mc7dQSJ9C2/aGU3aUyCGJ/+rDWVdmylrYaTaBr6EODSRd2MnTL2mMWiOHbHA?=
 =?us-ascii?Q?Cve4ZJALHXq2c7FCOIhqEJEeHbTzpc6505NYSQwmItGVJfFZ8YVFib88sxyK?=
 =?us-ascii?Q?2EA03lmff1IYlXCPCYkLzrQs8AfRpKcyTKThpPmn4pge1yBRYq3+7Bc70vZu?=
 =?us-ascii?Q?gAhAhK3ArHmTor9H+yVDJXR4m26EVrdfHN7a1afECVeKMXlUWET/jhv2LUlK?=
 =?us-ascii?Q?LkGeZX7YfkpTSLW9sCrXjYV5VACB/oFs+FhjcTSG3E8IGAib8TeEt1945p5T?=
 =?us-ascii?Q?83uv0yfruNMxklLuLf9FdvBZEOvVGdFR+aELFA+AP/EjkzLGkQNWOInLS08y?=
 =?us-ascii?Q?Umt2Kc8Kl3x9s00i3zQDNgdFpXzKgI0nD5eNKv8m1NGIFRCCvP90eyArEMTn?=
 =?us-ascii?Q?jqABqlQxHU92dS2CaO7/fM1xJdL4vM3Y2RtXFm5P4NV1R531YC9k+5wGVpYE?=
 =?us-ascii?Q?eLFtLJJr/8MmWSTDhG1pHcgo8LXELEpc8zxZZmzUY2GYrT4c3GJgskMX8OvU?=
 =?us-ascii?Q?r8d62QxS74F6sVYm589Z+fZ6cY/LVNOtAMkxjUwlYMCKoKXzmB/oSMPzLbx2?=
 =?us-ascii?Q?afqmriB6I0SMpGxR1I+cmyn7nbY3xBcbKMjS39gJQ2XJ37OhPL1OAcmZtGmZ?=
 =?us-ascii?Q?aKOlV0teHhc3CEwYlPgnh+FRO6LbfY68FTz0Yoxsg0E2ycXn7N2jLo8qf9LZ?=
 =?us-ascii?Q?Yhy3TJcBbyvszvhpqErKYUAMGsKUmWGG9UUEAeus5bmePMHUzaGUgVXJuTTE?=
 =?us-ascii?Q?WwrtS+Zaqys2UVe7x7QsaI4gnMG2dOYEzigwrI9vg4IBAOGqnPKwZLuXcVe+?=
 =?us-ascii?Q?i+6hBisZZxtecYrUHiWHpiketJLmpeXo9o0LAeBhvgY3FUIAiOH9Cdpp/LBV?=
 =?us-ascii?Q?hGx++lfF2ykr5N46T5ZudbLLc749ncUX4JeijrqAQFS9+bclRqHRELyNKLh7?=
 =?us-ascii?Q?Bc9i+vwCBIDuKpAaeKUlWA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6082cd2-1590-4d6c-7f1c-08db9cd055db
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:11:21.1461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9Ng/g0KGjSdxTrMS6VeZb978EqvcJg3aVAAuJNz2zWIg4UJCsY8NdhAUF6II0zvhLqsxVEzZsgKLfk0sm+sfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140131
X-Proofpoint-ORIG-GUID: KVyVJpYM_XscvSmnBjPX-gJ_sGEsGmgZ
X-Proofpoint-GUID: KVyVJpYM_XscvSmnBjPX-gJ_sGEsGmgZ
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
driver"), sas_ata_task.retry_count is never set, so delete it and the
reference in asd_build_ata_ascb().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 2 +-
 include/scsi/libsas.h               | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 21b69e592664..4bfd03724ad6 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -388,7 +388,7 @@ static int asd_build_ata_ascb(struct asd_ascb *ascb, struct sas_task *task,
 		flags |= data_dir_flags[task->data_dir];
 		scb->ata_task.ata_flags = flags;
 
-		scb->ata_task.retry_count = task->ata_task.retry_count;
+		scb->ata_task.retry_count = 0;
 
 		scb->ata_task.flags = 0;
 	}
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index a65c16643315..2601f5775a99 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -525,8 +525,6 @@ struct sas_ata_task {
 	struct host_to_dev_fis fis;
 	u8     atapi_packet[16];  /* 0 if not ATAPI task */
 
-	u8     retry_count;	  /* hardware retry, should be > 0 */
-
 	u8     dma_xfer:1;	  /* PIO:0 or DMA:1 */
 	u8     use_ncq:1;
 
-- 
2.35.3

