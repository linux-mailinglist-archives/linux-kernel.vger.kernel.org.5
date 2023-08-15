Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E8A77CC19
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbjHOLxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236909AbjHOLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA9DC9;
        Tue, 15 Aug 2023 04:52:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FB9Wka015043;
        Tue, 15 Aug 2023 11:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=lO2O8osdsKvir5+74DM8NQgNLYt4d1FN4qQDFHSBH/s=;
 b=ZAgzT5iaLMIBW1XsDvLcz/1h7s4m+FenSrk3zk6edUZi6jDSYTIylGf9yztzPCMSSTgC
 gAzhdio4LwfxK1Bp17SawUv3AfSezKnsp3ZXK079w1znt/rdPt03XR9tcSybCoSwz+zA
 KdH3EJ62EKUlmMxmqlP87e/h1dmF7X225DaCvn6+v0MGyr3+w9RgIkUUG7EQKfMROgrH
 bcz2Ume0AoW2SGeqzcRNqswrIE/kmsfptoL3Yktvj9Lthw4WDMixfXCQxej0RkQwp8fo
 TQEq6S48w+lTZdnogvkvZTzkBc2+SaQwLn0mBp1iHhsTTRx5s/X4MD25UMf6Y8OVUhpl DA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwmgka-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9MGWL027586;
        Tue, 15 Aug 2023 11:52:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1rytxn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/L1V5XRMGmikLiOZzCVtJO8vwAwYUOa4RfDWZtgW+N9UoWRTReI2/2hOQXJ8OGH0qsq0/V392RAQV03BrdHgDuR5z/TVQlLU5CO4tzmwtldtA9bq+9qpO/a1xo28/1x72V+FSU2JHHcNH1Ds4g11PEggsVW+SDe9W1jIc6oXSVQvxSthNmEl2NldwhwKoFmk4KolSCk4wuTU8lSl1omEWoA0YkM9eqLUfEfDm3rD5ZzkPdFmqJsunFFcjY2neCYws7Ak4/dj3FpuGf98WPxAQQR+0r23DzFwNZXPCsT3fbLWBdFMnrsBd9ppKGd8gGkxkhqZULSgJBxJ39REySp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO2O8osdsKvir5+74DM8NQgNLYt4d1FN4qQDFHSBH/s=;
 b=Ly/rOh2g5yX2un6TKSgh9pS9btZLBgu3fyHy8nCTM7mLLiwQwBngM2h9EAuHliF8BtxwMEEY1/jRV7K4byuJhkCl9yHIR3GIMrWfF3/YTx6XNx9I0iBbWwxn7wj9zFSrK5ap3siqA229GbdjEUzdPdw66QSgayBeIesU0xkuKqcJU0UcAks3Fc0KSZRP7CmF1IXglNhfdKLoohbM3Qo7hL+CNzUTnl5aH6UpjLPVzm85Hg6AYQup5ZmD3PsT12RD8bqacZTYfXe5c3q3fGtVd6NWCsWvPm0eqjfgXPPScv/44eGtOmTKDVq4kJ8oK8KlxwaCRWmk1UGy4W7Xr5JtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO2O8osdsKvir5+74DM8NQgNLYt4d1FN4qQDFHSBH/s=;
 b=QFMTG9fXbTUM/yF9Yy3i+WhyZh+zRXybg6tf0sW3V7+fE7gLchTVT67QoA/6JDnyvkcef9s1avGxJsvCKGiiHInfo/XhmhyndMEEznpTFxewT0xrPNJWegKiPr8g1gTS83e6fXgKLjJ/tksrkTjgur6rB67MHQdjRamT3+h2wSo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 11:52:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:30 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 07/10] scsi: libsas: Delete sas_ssp_task.task_prio
Date:   Tue, 15 Aug 2023 11:51:53 +0000
Message-Id: <20230815115156.343535-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0078.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: e25ad4e2-3752-4086-07b8-08db9d861ae4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urBWE+OAW/lqwxWSqoHoHVU1OfgKf7gdLMpHXgPYhGRh8cGeAe9y+znbe0jB8bWJj4u6YqzXUJVrHHl77GbRnWBGPnvN4lTn/kZUu2DVw3anjVxymXrpeLCgwea7w+rFUXBxrwgIBwvxheHufQ3l2CpwSjZbvMcz6nceT/D9UskR8PXbUPsrqCVWI+Rx3miRhKvbMB3NTgb57JfjhFD8I0AYtXkXrz3r4vrQ+Ukde5HjCCAB9CJB6qhl0k0IFAA4WJxKjCPB1p7LobToszj/P/4Xp5O1MsrOwEDu3YsfQ7whK1fdkyJvcy/88wRHAkNZUOUz76WLSFb0xuQgfSjD8crJM06lhkJtgzWkSyyQyzyhYh84LdzPJZDWXBIy49xMVSKYkaqnsG6u7NV86rgvojE3FQvU7MVEB+9MXhOjGq/BiqD0lUt9p437hnn/mN+kZmgMBRa122HjzG+tTI7tTQZ05rY+7VWcBbXk4hskVchKm0f4cFHoF3lZmqBk7SJDRpckPfZt/e4nLMFNTBdaj7oCLi9veYjBad29k5RAWUU7YzddoRKHqkZqwuuxn+hw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199023)(38100700002)(41300700001)(107886003)(6512007)(2616005)(5660300002)(103116003)(2906002)(36756003)(4326008)(316002)(66946007)(66476007)(6666004)(83380400001)(478600001)(8936002)(66556008)(26005)(1076003)(86362001)(8676002)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xKLJkeYeTxPf0GGwGBqy/ANF1gUvYW/7acPMV2SFsRx8Y3318mVNNEmpZg2P?=
 =?us-ascii?Q?mbkazACfNpZ0nrN8XR/qdKMUk9P3ZEnXpyWb8CtqZ3SUWSq7hW2OnTmNkPDW?=
 =?us-ascii?Q?twUa8uFqCAlewarb62urgmiqJ64lsfLNfOT+0gEQX7JVKg1dKO0DRi7Y68Fg?=
 =?us-ascii?Q?cOjtz6yAsHH9jtoMU8EZeO1prBlRUwE64Z2qKhu3AvfOimMUXIKYTn6cm9de?=
 =?us-ascii?Q?TqUGdJksPgVdzwqKzBub5aKpVeywVsnYIYKYwtGU33+h/mnXRJ1ei2NT4cm7?=
 =?us-ascii?Q?tFC9dNf6MLdOs82kJH4hKqbCpY4gcJL9v9M6IoLGIg5hTykZIHEIF7/cJvlt?=
 =?us-ascii?Q?7aOi76S1Eyxn2DeAusS01Gt06JbCboRdDGxaOs7IfmavMzoAn1mSI6buKOSg?=
 =?us-ascii?Q?tyBskMfGVXn9+mU+jCeiLkyGrcehFXv+aJUivyIPZ9aQxyvEm6EheoMUdyNz?=
 =?us-ascii?Q?flaoM57PfFYfZr3yxvbg03qeZQ5/qIsiQcZBXUUSPQHXMZTeMFwCkWWf8W6a?=
 =?us-ascii?Q?vK9j2jGJGTwu863ojF8WDEY1Vodh50At1tAFoh/+SCUHj5ISXuJ+sGuBvNnL?=
 =?us-ascii?Q?ECqWwWZkM1T6FkAzHP+aTd5Mcda8jBaOfnjBEZUMEHkxXi9uPmA/e925rJIT?=
 =?us-ascii?Q?xEp8pD7VJqAMlamDmRLwMfIwYr94AmOWFffs3FBLml/aWsvv+eZ5FmV9P+Fv?=
 =?us-ascii?Q?BERebYXlL7vQradMFuk3/OkplBxCNJ6QX7YTmn9OKUPiJhqqxi4gwQL3u2Qz?=
 =?us-ascii?Q?hcOCnE+4GSmQPUBcwRKYj6flYZsg+YFLbOE8Wf/qkW6LDUxQzrljfUqkhDLq?=
 =?us-ascii?Q?9bxEwNK+EnOlUIoMWV1tQlU0JXYbl2k49+4wTDB7NihOor/6Ghitk8c7K6yj?=
 =?us-ascii?Q?uvkiRZpElXKVfxhEP6NTWGUonfKsSeGIr5Pq5dLg+mQ+xfOmsD5QtfEd2P+v?=
 =?us-ascii?Q?SZAmJeuOwRMzsn3Lt88xgo6YVtRvy95yIlZH+bN4/d+WjxAuOaYkXo5Scc0X?=
 =?us-ascii?Q?htbCbcG/FRosb1KDvFKND8hAAKZtEEfuC2V3n1enMqbhYCHNw8EMmx42BZ7g?=
 =?us-ascii?Q?RH1XnWzGZ3zR2GRXXUUUmBtiuc/tKN2bIeocNa94odpzIp294BQxc3IiidH/?=
 =?us-ascii?Q?58kXuwPmjJ953pOaysM2XJ5iWSOxwCP1MGRLenInJk/41CLXOoHdKlEAwMZO?=
 =?us-ascii?Q?s4yeMBRYMxUF/zWPB8q0tqRsaGb8zLeZinKFtEuSWG8hmPTwzgkDKRhj5Hbu?=
 =?us-ascii?Q?bcIMk4ph9nXZ45YnfW9Nnnn7KnwTt9hgXiD15qQa8n2dGw7q+iBkD/cpbPoM?=
 =?us-ascii?Q?CreOXQMMzJ0c1RC+6zOoMUwplOXXJDkSB5BeDtEq1G3IiE5r9qbDcba6XqMh?=
 =?us-ascii?Q?4eYIDzxfIH+xlyEMJvybQwRfK0K9MCxLBoJNNngjf074cosWo7x6Bz94xuye?=
 =?us-ascii?Q?R5oBHro9LNbC+uvLm7WDN/EsrFDpFwwUkAjZ89MdhW6gh+ZVOekyTOCXby0z?=
 =?us-ascii?Q?Xj8RstdsGwDg6PD+xil4pFbVTfiZ+78MLWi/NQTy5hlmBJNwSV+osgE/mMvz?=
 =?us-ascii?Q?MeiwsMpegcX8YxAIuF6WhdVAvOvfQ6itgd4FwHGxyUBVR0+DcMCMZQYY8sdg?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BBLBNBXZg7Kk/7fCm0HZQnkMFTyWD20+l+aMFL5p0haF67YvmSBK/Kc2lygs?=
 =?us-ascii?Q?Q2OqwPiWeicsLkQZ1iltiNp3qoVQPC7RUFwgnRiDwNUKurKn7GM9IoFAjHgt?=
 =?us-ascii?Q?/uKP2j+8hbo0dh1xTjJamv/mhn9ncNLwq8G0aFsLfcFBHTE+OIp5Zs/PSLN9?=
 =?us-ascii?Q?FRo/2QTzVATSbE0UrXGWigjD/IZ8ib64nlTarr9EkUg+amrAizh/yNiHGgLs?=
 =?us-ascii?Q?GH0FJ/FLvLwTUQaf7xzuF9P91kVNrEM0crEVSUeTG+/HLrCtSwvzu3eBskwe?=
 =?us-ascii?Q?/X1d2qVVrJOVklvFvmoZMBsNdhM3JjcWFjdSTuZSLNuxyLpuy9+1jYbUFLVx?=
 =?us-ascii?Q?jCT1mGcJ4Xnm1HZb/1AgfjH3PlelO5R9tZ1rNxTT+hdhGtoGljY+UfjpWszf?=
 =?us-ascii?Q?izMUAxXrftNpsUBv+OH32gO+r5SOTOTutiRqjdRQiJZTsF36ct9kTquzGDp+?=
 =?us-ascii?Q?74rtY1G4nfk0Cmwd2oVeInR4IlIQTpWqlV7+Fqmy84H0GpDfNGVqv5qMklRR?=
 =?us-ascii?Q?lnqkLFxLdGvg+oYrKVMJGZ/3ZlYXqL9FFrh/yGtBkft39YfA64DmdFwt5qdl?=
 =?us-ascii?Q?uWx4AJ4xAotrN3GtI/4eGPMBN8NGjiN8BRgKQ1wB972xh0luX8aZH1Ts7d6J?=
 =?us-ascii?Q?GwRD8RWaHSN6UchHj2rXTL+P3D6fsJ2m4hjLWfR/kuQSF8v0FjmrPz/lsLcO?=
 =?us-ascii?Q?JZiEemrtIQiBNrmCar/KNSKweerdqXlrkIJS4AqscPWjEjyWnl5KtVUmXO/p?=
 =?us-ascii?Q?2dqlklLO6NsOIzZ5Is21PtMA+g7itcup4nWC3nb53Su6F6jbjBRPhz9yGc8i?=
 =?us-ascii?Q?xGw/uzYgKsiTTnfEjVUmaq6qJNmr/UUb+Hu98CU6eLC4vsIPePmUquV4mHwd?=
 =?us-ascii?Q?kvMe0iIaL3Wv5/4lvv3G0qcxQlZrgjCp/qcBHN04rIBydungMRIn+qEgUpUp?=
 =?us-ascii?Q?a3xVp7bAmDCVupsWo1b8RA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25ad4e2-3752-4086-07b8-08db9d861ae4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:30.6381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0+cAnD9U4IotCubdRR2gqXH94IWNgvgN9LXqyFRj1QQO0UHaimRES9liGIZDwf/1tGwz8Jnwe2PHmbrMUU/PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150106
X-Proofpoint-ORIG-GUID: 3uk2RaOkR-eb4ZhSrw8eO917AnSp7F1k
X-Proofpoint-GUID: 3uk2RaOkR-eb4ZhSrw8eO917AnSp7F1k
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
driver"), sas_ssp_task.task_prio is never set, so delete it
and any references which depend on it being set (all of them).

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/scsi/aic94xx/aic94xx_task.c    | 1 -
 drivers/scsi/hisi_sas/hisi_sas_v1_hw.c | 3 +--
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 3 +--
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
 drivers/scsi/isci/request.c            | 2 +-
 drivers/scsi/mvsas/mv_sas.c            | 3 +--
 drivers/scsi/pm8001/pm8001_hwi.c       | 1 -
 drivers/scsi/pm8001/pm80xx_hwi.c       | 1 -
 include/scsi/libsas.h                  | 1 -
 9 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 1ac4d3afc1a1..f67983e8b262 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -485,7 +485,6 @@ static int asd_build_ssp_ascb(struct asd_ascb *ascb, struct sas_task *task,
 	scb->ssp_task.ssp_frame.tptt = cpu_to_be16(0xFFFF);
 
 	memcpy(scb->ssp_task.ssp_cmd.lun, task->ssp_task.LUN, 8);
-	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	scb->ssp_task.ssp_cmd.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(scb->ssp_task.ssp_cmd.cdb, task->ssp_task.cmd->cmnd,
 	       task->ssp_task.cmd->cmd_len);
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
index d4e3c3a058e0..3c555579f9a1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v1_hw.c
@@ -1022,8 +1022,7 @@ static void prep_ssp_v1_hw(struct hisi_hba *hisi_hba,
 
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 	if (!tmf) {
-		buf_cmd[9] = task->ssp_task.task_attr |
-				(task->ssp_task.task_prio << 3);
+		buf_cmd[9] = task->ssp_task.task_attr;
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 				task->ssp_task.cmd->cmd_len);
 	} else {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 404aa7e179cb..73b378837da7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -1798,8 +1798,7 @@ static void prep_ssp_v2_hw(struct hisi_hba *hisi_hba,
 
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 	if (!tmf) {
-		buf_cmd[9] = task->ssp_task.task_attr |
-				(task->ssp_task.task_prio << 3);
+		buf_cmd[9] = task->ssp_task.task_attr;
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 				task->ssp_task.cmd->cmd_len);
 	} else {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 813807a24ae1..bbb64ee6afd7 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -1326,7 +1326,7 @@ static void prep_ssp_v3_hw(struct hisi_hba *hisi_hba,
 
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 	if (!tmf) {
-		buf_cmd[9] = ssp_task->task_attr | (ssp_task->task_prio << 3);
+		buf_cmd[9] = ssp_task->task_attr;
 		memcpy(buf_cmd + 12, scsi_cmnd->cmnd, scsi_cmnd->cmd_len);
 	} else {
 		buf_cmd[10] = tmf->tmf;
diff --git a/drivers/scsi/isci/request.c b/drivers/scsi/isci/request.c
index 6370cdbfba08..a7b3243b471d 100644
--- a/drivers/scsi/isci/request.c
+++ b/drivers/scsi/isci/request.c
@@ -180,7 +180,7 @@ static void sci_io_request_build_ssp_command_iu(struct isci_request *ireq)
 	cmd_iu->_r_a = 0;
 	cmd_iu->_r_b = 0;
 	cmd_iu->en_fburst = 0; /* unsupported */
-	cmd_iu->task_prio = task->ssp_task.task_prio;
+	cmd_iu->task_prio = 0;
 	cmd_iu->task_attr = task->ssp_task.task_attr;
 	cmd_iu->_r_c = 0;
 
diff --git a/drivers/scsi/mvsas/mv_sas.c b/drivers/scsi/mvsas/mv_sas.c
index 165f46320bd2..1444b1f1c4c8 100644
--- a/drivers/scsi/mvsas/mv_sas.c
+++ b/drivers/scsi/mvsas/mv_sas.c
@@ -663,8 +663,7 @@ static int mvs_task_prep_ssp(struct mvs_info *mvi,
 	memcpy(buf_cmd, &task->ssp_task.LUN, 8);
 
 	if (ssp_hdr->frame_type != SSP_TASK) {
-		buf_cmd[9] = task->ssp_task.task_attr |
-				(task->ssp_task.task_prio << 3);
+		buf_cmd[9] = task->ssp_task.task_attr;
 		memcpy(buf_cmd + 12, task->ssp_task.cmd->cmnd,
 		       task->ssp_task.cmd->cmd_len);
 	} else{
diff --git a/drivers/scsi/pm8001/pm8001_hwi.c b/drivers/scsi/pm8001/pm8001_hwi.c
index 18070e0e06d5..35797b56ea0a 100644
--- a/drivers/scsi/pm8001/pm8001_hwi.c
+++ b/drivers/scsi/pm8001/pm8001_hwi.c
@@ -4053,7 +4053,6 @@ static int pm8001_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
 	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
 	ssp_cmd.tag = cpu_to_le32(tag);
-	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
 	       task->ssp_task.cmd->cmd_len);
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index ad5a73b86415..1c092ee37bdd 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -4316,7 +4316,6 @@ static int pm80xx_chip_ssp_io_req(struct pm8001_hba_info *pm8001_ha,
 	ssp_cmd.data_len = cpu_to_le32(task->total_xfer_len);
 	ssp_cmd.device_id = cpu_to_le32(pm8001_dev->device_id);
 	ssp_cmd.tag = cpu_to_le32(tag);
-	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_prio << 3);
 	ssp_cmd.ssp_iu.efb_prio_attr |= (task->ssp_task.task_attr & 7);
 	memcpy(ssp_cmd.ssp_iu.cdb, task->ssp_task.cmd->cmnd,
 		       task->ssp_task.cmd->cmd_len);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index d77db53cbd8d..5b2e6932c564 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -565,7 +565,6 @@ enum task_attribute {
 struct sas_ssp_task {
 	u8     LUN[8];
 	enum   task_attribute task_attr;
-	u8     task_prio;
 	struct scsi_cmnd *cmd;
 };
 
-- 
2.31.1

