Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D8C77BB46
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjHNOMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbjHNOLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:11:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF59E1708;
        Mon, 14 Aug 2023 07:11:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37ECidUj024711;
        Mon, 14 Aug 2023 14:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=2T28MYMRdv3rmVaG16qWxtN7O7wM8DGdLAvnDDRDJjA=;
 b=WlneN70MEIY9datt5Q/gdyjNEMkbDKeB6137jKW6LkuSPQuNA2IBW5/uJGhYq0mPUO3e
 LbdN+yMmdg2av/vs4hTE4MqXBxPw0ungBZ1H7v0lYNYf1LhrhBm7npVr+C8fFLoutobA
 6GZRiRFWs97G9B+Bdpentw4eVGSi+k9xNtX3gUB817YLxiiJlJnc2utcniIfVpAYjTES
 33JavA4d4Bc5yJCPXpw+eGnmfubcGRu2atnIat5kiHNRFLtVgnhaMcJykGc1U426BCMl
 PUoxziGhfXbR9LJ3mv+qGpROjnxLlUwueVxuRknJemnRiN8FWHgRuuCvXOMRPk/8cG0m Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se3142pb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37EDMmFP019770;
        Mon, 14 Aug 2023 14:11:22 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sey3u6p8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Aug 2023 14:11:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRx3Ptisv3oWVykeT2TKjVKpx66Ze3mH4FD5FFNV+gnrBWqcLH4M8u2w0zhW2Z71NuRWWTvLrZ7iucJY1Lb1H2ZsztkDihcCHblQcphMqusVsBrAzNFLjcf1aGL1tv6qXc94MdPWzk98EizhXYrjfbStyQzt78ofahGnFRVqmT92vfwsVlcUgOjFEf/c+5vay1M8J3HCjTnsTfAm6xfNwJWrbkBBNTt3Tf9XyPzZRvlz8OId+qxAOgchYUqDE93aKYzHrp3Qi8q8P5k1FV+xAG2gXq4MzeOqOilesueUxJT/itRhZ+MLgg1R5dUI03VKuAQNLWRKPslqLS4imMGqBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2T28MYMRdv3rmVaG16qWxtN7O7wM8DGdLAvnDDRDJjA=;
 b=Wv8zv25Uuleeeo3pPDCj/ghzPAEKv7kiSB6+1qoaY2tuaZMrfP1js37LVuoNNSGlwLjfIUZzuS1jCErqzQTlK8rTM+lsU0B8fIMhOIuief8xaJ3pmo+deskxIJrTnOKrEBtmK1v+7rGClNx6AZSi/h9ZKZtohFAgz9nvzUrgt2YarE2ut7CTyQKBPAWYdmP+wsYIkP6JuGOHzzEd/eJHBbh9VHhic8MSBC0iYjGeFRnP7CA469ts0n+va+RQhLrl7N7F743wPE5pziay11obcR1Ax99odLduo9i5izAFktbScE4na5/99qoTmSVYhX97dnvihCr5TLG4ODmC5YP6BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2T28MYMRdv3rmVaG16qWxtN7O7wM8DGdLAvnDDRDJjA=;
 b=xomndbrXi6RfKAbYhL9lVlJmXT0wvErweZbK2Ts5WRprcUFqGWAo4SRCf8//BRy3/cMMlN64i31O8EK0R6c7h/nrJmGXea/ugaSYHHM/M2jTFHclNe6EvRhIesSLQ7gUqVrpFcpW38qXtGKePxDxPR09LHV1JL8+2ULAuksuFl0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB6417.namprd10.prod.outlook.com (2603:10b6:303:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Mon, 14 Aug
 2023 14:11:19 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 14:11:19 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 09/10] scsi: libsas: Delete sas_ata_task.stp_affil_pol
Date:   Mon, 14 Aug 2023 14:10:21 +0000
Message-Id: <20230814141022.36875-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230814141022.36875-1-john.g.garry@oracle.com>
References: <20230814141022.36875-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0240.namprd03.prod.outlook.com
 (2603:10b6:5:3ba::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7efe8f-204a-4a91-0768-08db9cd05518
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBeiJmqBY28ssh8YXl6EieXohvFf75shD4EaIwJawKwkTMxKfHFJbBX8irKxCAJg9agviSlfrEXA7xsldIaALO805gkUHw1u93sERRsxAKlWb4eGBhyJuICXXn+PZlAmpRe1vYF4e4vWx3QcBxvhHPukbpnz+sOLxGlmEkBvXtyvfUOfNUmjrTAelrE0wFwkL4Vxs2FyqX+O83RyRA8vMY3Ks9iO3Red8Rx+42RdnFcyIg4m/GpyPLhcGPlO+ORdMVemfSpGbiFivLvV2inWcObnXsdslOV5N1J67S+Ekh2+7T/V2RSrq/A2coMEGaBq1qmGyx4vrQShcRFvycfew3dY9iAoQzR0wEtZlOLe+FESV1f0Yu7qxQUF/GkopwEMUmdQ1FxMylWO/AoiIgJpeWJB0HOPaHNJGv545Wmb1RfRoFJpURviH4CziEoFZI067nLy8bpeWVrMGLbilUEQFm18Vn4vEVd6z9NeTYYLH3w+woa92AgO8sC3IJYvlPTWt1Q4R1DhHrAFJIT6P9VwNpRZbQNpnty2AjdpFj8MtNgTIm+TxKbGjNvMQ91Yc//y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(1800799006)(186006)(451199021)(38100700002)(36756003)(86362001)(103116003)(6512007)(6506007)(6486002)(6666004)(478600001)(2906002)(1076003)(107886003)(2616005)(26005)(83380400001)(316002)(41300700001)(66946007)(66556008)(66476007)(5660300002)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MCQB24MKQrWDBLOEU2eFUdE7poKOBNSGzwSh2SiccpShqQVCezNSo5+OPQUe?=
 =?us-ascii?Q?UK8LTA1pL5/xRmN9pCnwF2DTQLOc2bhMFRldEdNqz2PItlgjpyvBX/1f2ztU?=
 =?us-ascii?Q?sMOgndYJ3PhCxvbxPm0/GbgHo4yVZMFxdQU1DD2CtdIna4hwdpK2Dq17KZ6r?=
 =?us-ascii?Q?RUVJ06SbTq3HGPy7LA6z6Zqb8G7f0fTwB3lfn4CMh0LAan1BNUUXHVplfav9?=
 =?us-ascii?Q?TujFvAafTIWURCRtiQ2kKDAkkVwJmSG44YiZxElj/7ZWLs3SCw+BelO7eVLA?=
 =?us-ascii?Q?RpooA0qkfJAKNBAoofS1H5c8krax9lY+9AgKk5cpClIGyvfie4VtCDYztOLW?=
 =?us-ascii?Q?N1VmuOGXAgWSN5XY5UranSsmcCzOEYAbV4+QJjgs0zItIEd4msJbN8ZB8TtE?=
 =?us-ascii?Q?M8UkVM5XhU1jpMJJo5cjelVSxgvmQ8r4ALPSpNAqQHI6O2IWgkymtFoH9bTt?=
 =?us-ascii?Q?c/I5VxLyU1X1Fm2YikHCcy5tv7CyQUikx0jraVZdwLarC116DknOU6pZcsw8?=
 =?us-ascii?Q?9UYiNlqznEHyTb3gUjMg3YZbfNlVY0l92R8/7djVX5l6K+kDW/qOxt6KPH1u?=
 =?us-ascii?Q?fPjgNipMP3FXN6lKjNAqSUDGMGuqWj0MHBcWknfBDAbFq8klcjYe8+RAj5VW?=
 =?us-ascii?Q?ZC+qS6JaMhBWyJmsiitVuCYjZtyEkEloAbKF5pJdde6gBR5PZQUTpduIL0hs?=
 =?us-ascii?Q?L5mAWiWnUbLnvhRf74Amo6m3WDelWhSiN3JKHbnvoy6qG/vOMa2RhjXS0dVC?=
 =?us-ascii?Q?LGZ+MyrInh/e2Q7XxdOiCUkG7jLFhXFmJnVJUwgqvvYfdRvOM8UlzPGGXXfw?=
 =?us-ascii?Q?j1PPDT9QakgHzFlsgiuYi08uZ3HJzjpV11VvCCTSnSV5AvIK7Ux5kHo0EGqN?=
 =?us-ascii?Q?cRUtEC7JVW7GpDRDunNLTPkMmP8hjYoccY9WjW4o6rLercZY8HMqzynfrdbT?=
 =?us-ascii?Q?lf8omlIAR28RZCjrftTekVAOnbLSWMbRXRC20BNWuAkoZ6iAr3iRknoDH24q?=
 =?us-ascii?Q?8HExnDIaPRZ+rMaTfOOgYgKkirgbin/5jdkcBe7KKbdDy6sEGxmu2Dk+3xyG?=
 =?us-ascii?Q?WAuB/OGLAxFUky5FXvcVszkzxzk3CO+C3MmJ9dVN6T3AQOa/EPN1Hh3ltAk8?=
 =?us-ascii?Q?hABEeYv8gacSMRBVBJ23HxG+m8pmxm/MmhwhOzBWpSVVJMpZbPiLyAJJVtAQ?=
 =?us-ascii?Q?Am3N0YgxekT93YveOiFhCBnjh7KON9T9gr9vHjBKirPeOcT8gEnk6KTtG7x7?=
 =?us-ascii?Q?n5o0Js2WEjOVb/GfrJFKXVMoN0asW/lZCgwyWTIdk9TBJpO1I3UH053x0Em+?=
 =?us-ascii?Q?N+D5vB31j3AOwWSWzWr3ZP7iAq9m/wfXfQMxAFvev7V0spTbqrUhgmqZvAXW?=
 =?us-ascii?Q?ao/hK4bp3AG54gTDpQ3lUNWIZm3VK5xvSgRcKzyniIJEIvRpA24OFsUbv/Lo?=
 =?us-ascii?Q?WB9nsBU9MzOx9/2nVVk1MduAnK98siWfcKvJKs+jlBbkBMlUV8KwugDjDqmy?=
 =?us-ascii?Q?WLPPD0IOsr2SWNFsPPaQSL4cltCzW8NxUn6qnsVHu4A/WzVsrZSBerUIcZaW?=
 =?us-ascii?Q?qGFyA3eKXlHHrLBLKnEBEXkX8PE7YMxJ7oL3g2zRtNVXzUbMm0OuDg3XaeUj?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?JaSTYKgLQMlCkjy4aPnu3up8OIr8Lb22GO8HgpFXZt6+LgncKLvHGBdzJX1m?=
 =?us-ascii?Q?pmyOP8FjaLWWCs3w0YBHQ3ybM83w6JwA+jKzxdQnY7QH8vqcA8/kQv2HYs+T?=
 =?us-ascii?Q?o8JTN9MaZkFWzLq2VuSQaJRMN1/gU75jDpEGi8FTHIOYdeN5Oxsc2CWoZsaW?=
 =?us-ascii?Q?un/Kq0KFEMl1VI4S3aReGKo6Fkeer/6zXfDI0rrJFzBodGASu6A62MKxwdYC?=
 =?us-ascii?Q?1MS4NtumIp8ZuIS4WRpEi8x/Fswy51fjPD0PBFr52tdazMpuGyFmrPrJjk6B?=
 =?us-ascii?Q?Zd1EBxBbGC+mJUJj4cTBbObkrtYtKgHgAHt+zT/2i9HF/uWYPtyaZnWanQYa?=
 =?us-ascii?Q?HZCegH8ln+eDzxHGXAT4Q79QH21B7hArE0MmzqVBD7X/RFYjuQXEsZjr93VX?=
 =?us-ascii?Q?o2dgGgOInp+opoFgH0gwYIlclDDHFucipt0hBEetvlD1HCaRpLD4kabWbPXk?=
 =?us-ascii?Q?YbocBnGQc7UnmSrqXLRqqEnU64Ardr8huwyjPpKWzzis4ErASBLDkvGG5zmZ?=
 =?us-ascii?Q?W1D1XSVyllt2kxqHYWn3utl5QYNUVVmU0fphV7AUwAt+TgE77a6EknQMx9VF?=
 =?us-ascii?Q?dv7I7WJPk3VZqb7LGVXqw99Smz/lA6esrjNF74LiI4tSCxRnGeXKp+XP/4zW?=
 =?us-ascii?Q?5FGRXLaxwBO66CCU9qaFDQsUq8cajC3IsHzlUeyVs0aNsXOF5HvGdwRPMNsT?=
 =?us-ascii?Q?hl5opnu0d0phpMH3e/eqOxoPUS59I54aV7IG8Eqk/r0zHJxRMGOiVrmqsyXg?=
 =?us-ascii?Q?I0p219qvqjNtTSsI1PRXkPZ/bRiSC6h/bRLC+6JNMnc1hF8/Gu6PxSP0KOOn?=
 =?us-ascii?Q?rWdib4AhR/FRaqOg8gpixQOSL128Pz2/Q+dAWktGv4oWXUvMibeeKV5HAWCF?=
 =?us-ascii?Q?5ya+FqC8rIX1GLFY/QuEkG9de2pjRO0K7VJ2x7hRoF00HxH1udugNT4v6l91?=
 =?us-ascii?Q?EXq5bzJUFZzjoeemc7huQg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7efe8f-204a-4a91-0768-08db9cd05518
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 14:11:19.8647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 63KMDyjCiiVspK87lqnSXd64n6ibI0ZWNX/Trps4HaRKG3ICFOxq8gQHkJQi3YJuoaboTExKIk762Tp5YmqZtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6417
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-14_10,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308140131
X-Proofpoint-GUID: 0IR1psQEs9U-LWV6OhBqCV8eaZQkyNzf
X-Proofpoint-ORIG-GUID: 0IR1psQEs9U-LWV6OhBqCV8eaZQkyNzf
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since libsas was introduced in commit 2908d778ab3e ("[SCSI] aic94xx: new
driver"), sas_ata_task.stp_affil_pol is never set, so delete it and the
reference in asd_build_ata_ascb().

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c | 6 +-----
 include/scsi/libsas.h               | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index ca435811c310..21b69e592664 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -390,11 +390,7 @@ static int asd_build_ata_ascb(struct asd_ascb *ascb, struct sas_task *task,
 
 		scb->ata_task.retry_count = task->ata_task.retry_count;
 
-		if (task->ata_task.stp_affil_pol)
-			flags = STP_AFFIL_POLICY;
-		else
-			flags = 0;
-		scb->ata_task.flags = flags;
+		scb->ata_task.flags = 0;
 	}
 	ascb->tasklet_complete = asd_task_tasklet_complete;
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 3a52094090a1..a65c16643315 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -529,7 +529,6 @@ struct sas_ata_task {
 
 	u8     dma_xfer:1;	  /* PIO:0 or DMA:1 */
 	u8     use_ncq:1;
-	u8     stp_affil_pol:1;
 
 	u8     device_control_reg_update:1;
 
-- 
2.35.3

