Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AF377CC17
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 13:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236949AbjHOLw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 07:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbjHOLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 07:52:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D410CF;
        Tue, 15 Aug 2023 04:52:42 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FAx9El015335;
        Tue, 15 Aug 2023 11:52:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=dL+jHhl/KyfGKRbeuJfecQOM+wtq15mR/pKt0RNK5NY=;
 b=I2dpcMp+Vfs2mC4BLdNXcBe775iiU1wOkppjKtDrNQ9lNh3mmhLhTxS++I1beJD4KrxA
 UxfhMps+x3/bdjbXYzZsUzc/7jRIIXWoNz38iZvROle/6qEdEcrMpcWCR3HwXWD41a7v
 ZJ7GN+cAi+LC2E51gEvtpbynUcO+EbE74qetkwxjIRHyQKvBI3AaSkbN+sHDl/6umD24
 wZ0lXIWdugSLkOY6mYwKx+Jim7qzC+2lQlfjlFEMGmqPioyAyRXl4ym7lY0xvyyVmKad
 d0RTHO0EgmH8JUq++2Qy7fiaA+GPMsZDpxpqIw5iuBYz+shovERi8RpX/0O8NFhwrP0A tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2xwmgk6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37F9TlxD040111;
        Tue, 15 Aug 2023 11:52:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0qquv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 11:52:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRco0d2EVafmuSVaGuBH1iy5/ZNqvON9nWes8ICixCQbL1A8H7MYCeA6377OPNtPS9AJOhkwLUGA3Zle1v58l91btvY0Mytig7nrfJlrbNYcVBqGh8DM2xI34kApY3UTNi3ckFWfOKgV7CWumlrB9jRjkcNN7fJDvbnfLmFCamwKX4HMwM52bBxpkEegVR0KU+Fe3kEDNXlQSJc2of9ClTdP7hNGadJafkhis1VwTW9vr5qDN8Z6im7K27/2olIRNQRR2xjn1SBMIIrt/UjtcGdoH+RjAll96k2b3KBxLIDscZTHCgZtZMQ33RliW2+bb4tM5mYICF8GATg92H7+dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dL+jHhl/KyfGKRbeuJfecQOM+wtq15mR/pKt0RNK5NY=;
 b=dXQp60AvB7/4/3tcZLVqsN7kFs96AE9oCLWHoKhAMcLQx8mqjNWUfhl7EyCmIQ0KnOu/2WO1HfMOz3pD87KEk37Y0mU1ioEaa27YEpEm+ZzOCZ/GX/VzugLFXkx55s2ZA6Y+s1xYQW5jsjhc9Ile7Aw0YGkNM3s2Jy/8IDVy0gMeTAuqoCWQ4fz38AHfaF5PAlTXegMdxnbrmeGjdyUfl1pNOoyDgLRZ45k8qHhIkECmaVnc/iDNUMKhzrn4vzbb/OWUhSzrisc+mqztSPtVr8tLxzJ/VPGOPOlgR6G1UFf0gsv+MpRqJwD4vjYZqXBeIWIZHBL9Xq9Y5jSfixj4rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dL+jHhl/KyfGKRbeuJfecQOM+wtq15mR/pKt0RNK5NY=;
 b=LggHzPDUqvY49CZg69OjjM6D5bXo8HPZl31hxNO+rdWLsTCUrh1az8gdfdtLOrK65Aj4SR0zWy4ii2DDe16ckw07AN6bhlPyt0TPqrGo8OiuKU97q5c9mQai3oXQNQlo8FHnKRxtKuwvrelxO4A+faVbWDIjZwKAvF5E6wS/2HU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6710.namprd10.prod.outlook.com (2603:10b6:208:419::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Tue, 15 Aug
 2023 11:52:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 11:52:23 +0000
From:   John Garry <john.g.garry@oracle.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        chenxiang66@hisilicon.com, artur.paszkiewicz@intel.com,
        yanaijie@huawei.com, jinpu.wang@cloud.ionos.com, dlemoal@kernel.org
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 03/10] scsi: libsas: Delete enum sas_phy_type
Date:   Tue, 15 Aug 2023 11:51:49 +0000
Message-Id: <20230815115156.343535-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230815115156.343535-1-john.g.garry@oracle.com>
References: <20230815115156.343535-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0159.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d3718d-194b-4156-7b86-08db9d8616d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q9vf1zULLzbyP6kadnRG+5L5Am2AY+XkmWH96QtJGOqOe9Nsu2kl3pMK/VcM5L9ATwU/TiivhJe06ErJYVmwrUkkA00N+NLSScNTYpFYmHVztFZfDQw+0C4RnffSCdcDgdTZ5b8WQ1HNuYsOHXRKAyafz5yHSHhfTsSqCqQrtQPCqal2qs88oejEDnZNBGejf5Hf/rfm28v/j8LI7KmEidD9aK3D5Zww7Ekf9M9gh+NWOqZLDyi5GVL5yFXWweFSIjTpC+WgmcjnzLNsdQ/8AGmXAR1RKPeCeTk8v2Mrenchz6G1uKsERnIl8duT2qlPvX6A41cTGfQBtt/RIXfAXKwg+JM7RHNElMJNjJL+Qe9RNHR2f34Bd/jFclYowDhi445BfmzokInltNzZCvkTI/kLKIRVm2CYlOC3AjB1cwj9FV8iCcmC5keYqaT+luILVfiuVaNnsQGqlagxcj3Wpbz4JIjUum8p/A4oITH5g4AIWj3g0DNcuLLcdlpYlEcbYYGnebmJI7txSxRvsGwYr1mPJlLbnwkRN1mZYR608r/VbcCmx3PVkEnfUcxDv8BE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230030)(366004)(346002)(396003)(376002)(39860400002)(136003)(1800799009)(186009)(451199023)(38100700002)(41300700001)(107886003)(6512007)(2616005)(5660300002)(103116003)(2906002)(36756003)(4326008)(316002)(66946007)(66476007)(6666004)(83380400001)(478600001)(8936002)(66556008)(26005)(1076003)(86362001)(8676002)(6486002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hW/dO4KaozCpdNAmh0VuoOBK3PNznm4qKEpharJJY4u3ja3jBqJU8sTZ9Uhc?=
 =?us-ascii?Q?iC2J5tLinWgQkgTyNHaqxmH8wgokzDQ8ZLDiwxdzOeShYCBEY2dkM1veH16W?=
 =?us-ascii?Q?LvuEkpbXN+bEfSXf7/K4uqNUpsvJ+PVdMpqBgm2td++ilxX14Infs1gLE49h?=
 =?us-ascii?Q?ACHIm9TcRvm/x6ckFa1pOggW7MxoKN5eK6zWolO73zHrqQOZWHUqL6P6K7CC?=
 =?us-ascii?Q?oaDn2Dx9SUe+AiwPdn46fT7NOWJco4lexRVSK4W1nK3lIkzY0jjKsh+dDfsZ?=
 =?us-ascii?Q?kZVHorQj8ampl6dQ4EowQGv9bT/7ef9wivrcUtonTDlkRS/Iufrw8M3AZWDl?=
 =?us-ascii?Q?GuLAzyZSjy7CR0+xbPjoFLuydT2bkK64I1gTVLggXU1rpVOQbr3p5vcQWc/m?=
 =?us-ascii?Q?KqvYB0fq49T8ecccyoIG670rBmC6m8LnZwT1YrtB1TaLKWcJfb7fyc+t0Cqy?=
 =?us-ascii?Q?xu1zxIpF3TqWazvLakgb1oHcUpYbyWdOnWKwCqkVQWAQVH6YowT92LsbbW1U?=
 =?us-ascii?Q?gE3H9ZLzcpSZlj3WLWrejrhMXQC58aM/uxSPPfWaGUn+Bw+GGjD8rxHD5iDg?=
 =?us-ascii?Q?7IDSzMQhZdTLvNGmQg83FNSZUaOG8EZBAzpNDSzwjoJCtv35rMWyl3dOMXDa?=
 =?us-ascii?Q?EGj3CEwYUmR88Su0IynVeucqdCcINKJO9BbOwaK/eqvK9zanGYu0v1Yzn7du?=
 =?us-ascii?Q?GJWWFAxhYapo10IeixuqVX5TrPVbJEpNhdjOkxn9kumlnBmhKmDjJqxnNZrH?=
 =?us-ascii?Q?ldrjHbwQW1dmAsSsgINy/zLZBv9TI0iMacIodnij3elrxl59xqoGKc83f/u6?=
 =?us-ascii?Q?SbNK5TeS984Frf0qwMaevmVF/Tk3Y8OGSsziTSguL27nipo9nsTfdzVzyDKK?=
 =?us-ascii?Q?ylzi3F0u5y2W9dMMbiw25Gkp+K+Fovj2/WDKe8gDnZxyAp9M7DUZ4d0+XdUW?=
 =?us-ascii?Q?E0hSQSrqrMX6cCxiOPcFmGZd5eUeCclcYzaTYu0uD91Qn+kvoH5SQUvjn7yn?=
 =?us-ascii?Q?nHbEWAaRVMDVs/MYgBpstm2pySPn7LGF8dle2IKAO7g9ChGOL3/1tz6HicKZ?=
 =?us-ascii?Q?p+XxJChdwZlrIivLJd5b4GBfRy/V4nRJFyWWTNjxN7sk98DZbz/zybwj76pV?=
 =?us-ascii?Q?anhZmuz0YzeyKuGzmY9oHpg1XfCX+bGuvt9xiw4WGrD2x3Q0yDYRdPoY7oK8?=
 =?us-ascii?Q?Ye39lSmKLIeBgU9X25gP3RDXXq2YEwPdSoum8f1kwxzUXPnJkOiCuTW3KOi7?=
 =?us-ascii?Q?0oovXv08RbGTvi+pUdSGfdlQnKt4IWjonjzJUEH/qrgJ0PHnXAeu5UigQbyq?=
 =?us-ascii?Q?STPS5sN0r1RcXogZxqRXsOQv9lt12AQTE48kjwT2UA/+2ekjHOjYupykcRlc?=
 =?us-ascii?Q?/8R9n4EDTwdIqMQGE3kI69s2/aDn8fJc7p93i10vpoTkvYy2fnrq05Kzhpe2?=
 =?us-ascii?Q?arzUPuUSmiBapPRpUopWOl2gQcfugSOspBK45Ck25qFcSX1n2azFJtaFDEUC?=
 =?us-ascii?Q?SRZZ5g/qYB4vvvFTvL2xsd7iSHW+7GRZhcn8Cu+UP2V1FEKEA+U7r6V2lUtk?=
 =?us-ascii?Q?XbnJtpdkYFxSMxriYybq0XoNiczZJnEbVU7SvjRWyN15lhv2bRi8KIIVWAQw?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?5ac8rmnTc6l+N90dx2Ss6tlWY9csya7oc1OWTuLGOva5Kg2U/at+HE6bcNUd?=
 =?us-ascii?Q?N0OYJXIVnhsHpRJyH+dBy6sDXIlXEVdmM930Zfd/8trRZiN4R/CQTgh5shSW?=
 =?us-ascii?Q?ksIdaoteKVTVEpxxwS64e0q5E7Fr5TyxnAFspB2OzAmIICZIgpowFSseWK7W?=
 =?us-ascii?Q?A0Sp7r7rDr43Nt41/IClwISEyiexVEVF8n+ZxN2W/NC0OkftTA/wSAq2suSU?=
 =?us-ascii?Q?HrfnR+qG2EMfmmz1JEd1/PvkKuRRDSWNgtLJFyZnkBRSqfQrPbK4nsbGZ4h/?=
 =?us-ascii?Q?fiL3FPJSsh9H3aH3MhX3Zv3Mv5BNdlTqi4lu628x3RNLiYQgdJum0RIphNnJ?=
 =?us-ascii?Q?Y1SFCBm8n95iwvwe24/Isd6x7omy8Bbxr6gDU83wVBqkMzSjiU7ZuwjecigQ?=
 =?us-ascii?Q?aWglGzZC/Zs5rDmOdwBEwqDai8NJa8sYVt6ZdcigBLa1LtFHdeAZpM8ig/g3?=
 =?us-ascii?Q?RwJBpWg0HAsnJML8q13lxLr/HYmnuLLrV2lQeiIHpJV2/12xdk3wSLPQAiCj?=
 =?us-ascii?Q?PKCLuRvSqM4nbdGab0QCohvUVCcA9bx77HrP2SXgsN+/7CQ4kd3JO09VPVTh?=
 =?us-ascii?Q?JrNN7e79UY7TKfIdJRJNxzlB3fWfRHynz05t54JKgF5lm4DiQ5I8PNN8B1qP?=
 =?us-ascii?Q?MaFbjRWgkS424wNe0gMpRHjEk9+8jQ9Eo+NZVmuLFoC5ObZlv4azUg6VgVDT?=
 =?us-ascii?Q?QFHvjEWnAYc5yCTEp/t73GgzpZ1ZfEzki5E2BlurVQVk+op2kp3zpLsYfrTh?=
 =?us-ascii?Q?3np1XspdfW8BDWAMDpX/CEWn7H1A6td2BSFiBnh2yu3zMEsUceSGdGdS5UQ7?=
 =?us-ascii?Q?67WGOolmD1T1G5UbI8EvCn/SdZ4F/nMBjWLA5d+reIH/wMT4ZHjYx+TPix9g?=
 =?us-ascii?Q?iBF9vk5IZnIGWWRt83y9sEhLlNb3b0FOnoaSv1/vCh1oxL+0z6HPFsYP1OXO?=
 =?us-ascii?Q?HyAGp3naj0IOWqf/RVOo9Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d3718d-194b-4156-7b86-08db9d8616d9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 11:52:23.9046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SghYu1enE9Bvrzggir2HcPPmfrRHozek/a8x7AUbPWbqpA75/M6/rSYixAl0gdhz+5cqK2w8V+S7WOlBOf2GlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6710
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-15_10,2023-08-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150106
X-Proofpoint-ORIG-GUID: J2FV_DXv_RJ-d_xwNDK4Wwqg3CMuB0E3
X-Proofpoint-GUID: J2FV_DXv_RJ-d_xwNDK4Wwqg3CMuB0E3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enum sas_phy_type is used for asd_sas_phy.type, which is only ever set,
so delete this member and the enum.

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/scsi/aic94xx/aic94xx_hwi.c    | 1 -
 drivers/scsi/hisi_sas/hisi_sas_main.c | 1 -
 drivers/scsi/isci/phy.c               | 1 -
 drivers/scsi/mvsas/mv_init.c          | 1 -
 drivers/scsi/pm8001/pm8001_init.c     | 1 -
 include/scsi/libsas.h                 | 6 ------
 6 files changed, 11 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_hwi.c b/drivers/scsi/aic94xx/aic94xx_hwi.c
index d8f56e528877..75848de13818 100644
--- a/drivers/scsi/aic94xx/aic94xx_hwi.c
+++ b/drivers/scsi/aic94xx/aic94xx_hwi.c
@@ -74,7 +74,6 @@ static int asd_init_phy(struct asd_phy *phy)
 	sas_phy->enabled = 1;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
-	sas_phy->type = PHY_TYPE_PHYSICAL;
 	sas_phy->role = PHY_ROLE_INITIATOR;
 	sas_phy->oob_mode = OOB_NOT_CONNECTED;
 	sas_phy->linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/drivers/scsi/hisi_sas/hisi_sas_main.c b/drivers/scsi/hisi_sas/hisi_sas_main.c
index 1172065c1d7d..72dd5e3ad9da 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_main.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_main.c
@@ -1020,7 +1020,6 @@ static void hisi_sas_phy_init(struct hisi_hba *hisi_hba, int phy_no)
 	sas_phy->enabled = (phy_no < hisi_hba->n_phy) ? 1 : 0;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
-	sas_phy->type = PHY_TYPE_PHYSICAL;
 	sas_phy->role = PHY_ROLE_INITIATOR;
 	sas_phy->oob_mode = OOB_NOT_CONNECTED;
 	sas_phy->linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/drivers/scsi/isci/phy.c b/drivers/scsi/isci/phy.c
index ea2e339f5b1a..743a3c64b0da 100644
--- a/drivers/scsi/isci/phy.c
+++ b/drivers/scsi/isci/phy.c
@@ -1406,7 +1406,6 @@ void isci_phy_init(struct isci_phy *iphy, struct isci_host *ihost, int index)
 	iphy->sas_phy.enabled = 1;
 	iphy->sas_phy.iproto = SAS_PROTOCOL_ALL;
 	iphy->sas_phy.tproto = 0;
-	iphy->sas_phy.type = PHY_TYPE_PHYSICAL;
 	iphy->sas_phy.role = PHY_ROLE_INITIATOR;
 	iphy->sas_phy.oob_mode = OOB_NOT_CONNECTED;
 	iphy->sas_phy.linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/drivers/scsi/mvsas/mv_init.c b/drivers/scsi/mvsas/mv_init.c
index 408113bf506d..d5cf563e9094 100644
--- a/drivers/scsi/mvsas/mv_init.c
+++ b/drivers/scsi/mvsas/mv_init.c
@@ -86,7 +86,6 @@ static void mvs_phy_init(struct mvs_info *mvi, int phy_id)
 	sas_phy->enabled = (phy_id < mvi->chip->n_phy) ? 1 : 0;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
-	sas_phy->type = PHY_TYPE_PHYSICAL;
 	sas_phy->role = PHY_ROLE_INITIATOR;
 	sas_phy->oob_mode = OOB_NOT_CONNECTED;
 	sas_phy->linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index e5d794a97b14..0ffde0bcd737 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -164,7 +164,6 @@ static void pm8001_phy_init(struct pm8001_hba_info *pm8001_ha, int phy_id)
 	sas_phy->enabled = (phy_id < pm8001_ha->chip->n_phy) ? 1 : 0;
 	sas_phy->iproto = SAS_PROTOCOL_ALL;
 	sas_phy->tproto = 0;
-	sas_phy->type = PHY_TYPE_PHYSICAL;
 	sas_phy->role = PHY_ROLE_INITIATOR;
 	sas_phy->oob_mode = OOB_NOT_CONNECTED;
 	sas_phy->linkrate = SAS_LINK_RATE_UNKNOWN;
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 3048660ff107..e54bcdc1ecd1 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -29,11 +29,6 @@ enum sas_phy_role {
 	PHY_ROLE_INITIATOR = 0x80,
 };
 
-enum sas_phy_type {
-	PHY_TYPE_PHYSICAL,
-	PHY_TYPE_VIRTUAL
-};
-
 /* The events are mnemonically described in sas_dump.c
  * so when updating/adding events here, please also
  * update the other file too.
@@ -316,7 +311,6 @@ struct asd_sas_phy {
 	enum sas_protocol iproto;
 	enum sas_protocol tproto;
 
-	enum sas_phy_type  type;
 	enum sas_phy_role  role;
 	enum sas_oob_mode  oob_mode;
 	enum sas_linkrate linkrate;
-- 
2.31.1

