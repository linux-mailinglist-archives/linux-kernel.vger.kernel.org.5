Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0077E769D86
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjGaRBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbjGaRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:01:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE14A199E;
        Mon, 31 Jul 2023 10:01:00 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VDTJIq029571;
        Mon, 31 Jul 2023 17:00:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wfY7EgoUpDGbrnOtdWeyNRVtzZsnxqJDo44qsVyfC+c=;
 b=18yhNuLisPzNBTQUaLIdotp4sN/QeUyzqi2B5/cVnoYkI3hNf3W5ae1mvP/A/2GNUbZj
 6WlUGKNmdAiA0wERxzSFYx4xipOp1NkDRuMfaxXEQD0ZQOTSxTDQU06vyTHDZoZEH6Jm
 DAQLkZV/RwGvgjU9EJk8Qj0EgJz1LRRLZHheA5FXXSLij86QHU23FbH+y6HMzFzt9wPk
 51vNPnHdcUe7IbVM5SV+slqnpBO/MRagK/3eligMcFeFutvWXEFJWhTQFkVtYCTRE9C7
 9G9dEjsyPXZC7uEsyQVLTbOLt5i90KWp2VhtE/NvxILn6lGebRycmvt3gPF2+Y7DlfnL Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4ttd346a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 17:00:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36VFijBa000812;
        Mon, 31 Jul 2023 17:00:19 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s74x3ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jul 2023 17:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lphI2oLm27zumhl3o0b/n88hr9sjpAG8XRKnoXPS4/QXDqrNbhb+sTVFR9FZskj0z7S+KNxoKLi/iAHhR1K5T2uOASmqpB+yDVhbTH7E57qI6B+jE9ufJxXcnLBXAjBcSrWW/MOeZjq1+8St1cF43VfrizZyuyCZW7WXcpMn9aDg73pAXkap4p1lngMOnqDBI7zfIYUcPs3St4IoCf5xG6bgL2DUBCfcS7D62f4Yrsy7Ir7OjK0lNxyXNuwgZm8Hg3enaEvIKxwzyPpqy+PnmBOdXf3cFP64QRBWdAvbYyQLHfvFnjecAwNK6TNYGIoW8/lLraCBRv4R4CtQavJiMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfY7EgoUpDGbrnOtdWeyNRVtzZsnxqJDo44qsVyfC+c=;
 b=AR89Q0KG7J6Tht6rE71rQfL7f56GOYufn5ZfoaR0Z9oDpwrB6OXpLe+6INt6Xq/TXvN17clq4RJk55velfRQD15lkmUzDZR7XxFSq2BQ3oIFc8F0Fx+gkdC/pKOQbqqvHZPAOD42ued/bLL1M0KDtHfL0QyzpxLk9xRokFG+IvRKXFNCkCRumvGnpT/jWLTPWnJEmxGTU16T961+2A2kkauzs20NXkRK59tQ4DIbv+BG3fXF5Ymd2Qv6qBsFK6cOIoA2NcdVD6Ywc85Aspe5tYCooFn12bHYINAIu4DZprVUi2IjM4H2XtNQuW17AKFiLydNvGfQ0LZ67f0DCEJmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfY7EgoUpDGbrnOtdWeyNRVtzZsnxqJDo44qsVyfC+c=;
 b=EwwNT8ftVkYna319n/HwSylXIIzvTFSBMEp4VHVIWrypdSO9WoEcfflWNGCuSNnIzzRovXIJmk3no7GCdva//Q1NJ7AUVbJT/+EUfbSdeHTzLRHNzfonDk7yj29WH5FHtU3hhvvW6+ZxvRpyyyWIYXuv+E8YDPxLdWtcHMmmSTs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB4783.namprd10.prod.outlook.com (2603:10b6:a03:2d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 17:00:16 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.041; Mon, 31 Jul 2023
 17:00:16 +0000
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang Chen <chenxiang66@hisilicon.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] scsi: hisi_sas: Fix warning detected by sparse
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1tttkqanh.fsf@ca-mkp.ca.oracle.com>
References: <20230726051759.30038-1-sunilvl@ventanamicro.com>
Date:   Mon, 31 Jul 2023 13:00:10 -0400
In-Reply-To: <20230726051759.30038-1-sunilvl@ventanamicro.com> (Sunil V. L.'s
        message of "Wed, 26 Jul 2023 10:47:59 +0530")
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0036.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b938773-6d2e-4b61-34dc-08db91e79d67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jA3s/9Z8Zl2SwKuCHZeb+7vkcODadgw/YLn5N3EWI5Yef1DzMVYATDIVJc0zVqNKPeG3wCmf/D0otSAiaoDpvso9YldjlMUqH0O3Ox/hBonZ2rtHNIYDL1mAPWUETXYkU3rEWA5sUcB+BqYj8MPVMNBTkg42CKIy65ViFH6kRRc7Wn9bjYCvsd0TPDfmDsHzE+ICWuPmbAIUGeO5uiRTv4qF/HOwIkjk0b5s/LBnOzyKSYS/dCKrSV2jNfk55e7+8qh56rsoE66thfni2DqJ6lG8CzlbjYc5wBmFX7itps9642ziA5u0AkFt6GrUR7T1nHmq1xgSMImjxR78g8YHJxjyk01HCzuCZ+RZ6LP0KoHWuMCo86XRjuhpZOpSaTX+HcfdejYnxvVFcJji8ALR/4JUjTDWogo3TF7b3b3kBtG4bHXZlO6NPt2AinZ7ZL1W+E8MFySQapsr7/+etleUKTUub4Msky1oucu5AI7o/r1U9iAr+odpNSzhMvDVZLs2eZUWYVkOHFUqhjI3RAdgQ+c+0xDtDgpAE6Y7ueGivR0ODV+pBYtvY0+S/D1ZwEVc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(376002)(39860400002)(136003)(451199021)(26005)(6506007)(54906003)(478600001)(186003)(6512007)(6666004)(6486002)(36916002)(66556008)(66476007)(6916009)(4326008)(83380400001)(38100700002)(66946007)(5660300002)(558084003)(41300700001)(316002)(2906002)(8676002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aiPPTjwImmEbb9xu8NBEJRC7nLtuYbEHwG3SDBZ+ipz6Qv0Hb9zb7zR1vU23?=
 =?us-ascii?Q?pp2I1LeTXwphvEEARLbwTFvx8+dKEDDa1eYFHTrjuEnYQyoNGRwdCEt3/4F3?=
 =?us-ascii?Q?JQV7SkzbTmvymfEV9tW/jOkovjjG1Y0UYCQCd+w4tYQ86dXnCfYaOxw25Ih1?=
 =?us-ascii?Q?pDPpJkpSpvjG4CIOCq8No9sVJCGjYL0GRgYwbMhqflQ/czH+PoRdgjIwKXEH?=
 =?us-ascii?Q?p7fJDNyQjVjIgUq9H6CeDabMf453r/K6K6Pf/3kqHZUow7k40nKE1aqMGpkk?=
 =?us-ascii?Q?C3ZEXogkJp5GbBlsb8dFy6+i0ZZIC0pPaFI4DevV1pueZ/l6DxUrMu57UmhM?=
 =?us-ascii?Q?tthSKxv0c7+Ck1VA4QqUSzgUP5ZT5Rae2X5yOMvQ7pYl93qHdwJ1FFANYymP?=
 =?us-ascii?Q?I+3lLuOkK9rnovK8CXcDrNq/ojJdzyZMsoic3u55JEJ/Z6K4LJPNyg1sh1J9?=
 =?us-ascii?Q?uK894PRn1oBJFnV5LwnjZw9gabpiCxEyljOpGKl5RcDem5aiDVuVSLv44ohC?=
 =?us-ascii?Q?W+7mJEJSQMVYX91NVsyG5HyYwXUkTjXkY5LrwaNjrtUo3Rbz7tMXCUUDeMmr?=
 =?us-ascii?Q?HRNfu8sU2+v2n4I5J9KhPqEq3aqLw9wg4tzvmc5/o88s+61B8zJTc1V06H+v?=
 =?us-ascii?Q?CuKo0vDGAB/MaENQAft+muCD28mLixkQ13qv40NiY6d6v70Z6Vb0EBx3uIvt?=
 =?us-ascii?Q?qwy0bqsyWShcRYKJ7ANqFyj/S1lob6+4aTAlPwm0O1uJ7oRnbYxRLGkfUksd?=
 =?us-ascii?Q?T4UWZWwAtDFQFHDdvcS9NzxnNMBwQ6WKhmW7fh1AvyklrsqDumEik6viZrq7?=
 =?us-ascii?Q?O/ze72vwCOk6oJwW9vCtmfkwXO+BHiIfaNZIgj4RQw42phvotHzsEHdQ/w0c?=
 =?us-ascii?Q?JMxyS4W8fvUFAOnKkvQ/oOtrxv3UHKhMwU8YJ1RIirahfZdMFDBIZdrL8BXK?=
 =?us-ascii?Q?Bscnkl7nXuL5VuyX6/q+rlU5oTlwQnPTmX46xPh3bJfkk3tCP7JStCjBIltu?=
 =?us-ascii?Q?qbaM1iIaGumqej6DRiQSDC+08kGHUozUBBzsxN5Grx5Lo7yuxzqHLnUQ8PPr?=
 =?us-ascii?Q?T9TPQvc32JXhbF0VzvmnBPQgIpWxMY8WKD2KG9wRaTn+Wwn6MaTN28fi6iLh?=
 =?us-ascii?Q?bXp34tD2MnlT9IzocnZK7r6Nl6O16gsSAWN8cSYL1SJ7mvOQYHIASQaTCw4H?=
 =?us-ascii?Q?1794N3Vqs+Z6lSAIgW4iSMO6Dhwv6nX5kOuyM4fJM1BNVaegvXHvUjqFN4kb?=
 =?us-ascii?Q?70bZm7aBZvT6kbtN7MThtUG17fWlOv1vU76VBZ4HVYMhxCYVy5iy89N130N1?=
 =?us-ascii?Q?n7VWc5T+CjQUmGwA1KN1gaMB5YAYeF1S4qSIVyg6gZn2yqAv+/EJ+bjRSIvZ?=
 =?us-ascii?Q?bdmNEijJAs3oEuhPK+m3oFLEFN/cpHhTWqxYy8s7fGWCDE/T8nijofHQ+9Ki?=
 =?us-ascii?Q?UV5bQv1L5GuLArcu+CVr3EuBXVzVv17hVIpahkS+I33wWtvrmI/z4bon0K6x?=
 =?us-ascii?Q?0bP31h4kz6b0QdKWV7IIxNNRdUdW2wxB6m9Q3Dk+U5VGxVmKOUdSgNDRB/6Y?=
 =?us-ascii?Q?qcuKcgDUReQ9ToAat7u4CBtEt3wC/D9ySsqR7x0kiH6lS6Ck9w0LcoZi2+/G?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TaucF59lpQJHbLD9PtDqLthaa/VNil4E2EB+PGk1IKdFBXOAd0WS0V0obNRn?=
 =?us-ascii?Q?XptGYzyfrMhMcKqLWMagAqm2rMb8SYeJ0QvFedPE2wFqZf4Ju3sshoi7Pnon?=
 =?us-ascii?Q?CB6YtA57RsWWUUvVYmwbzQYYqqD5/nnrQCQ/yoqq92y2HoxK+OfNHkjKNKaV?=
 =?us-ascii?Q?SGGVYS6dDS52/ojk4kRyyrsthbh81xuceUQAegCpvRCzUQd0YTFk2UnZQ0P5?=
 =?us-ascii?Q?o0PMh9Bc7vPj1tIVWRx8waizzUF1HNx9P+HgEmEtuyRtvuBXpthTv6RsT26t?=
 =?us-ascii?Q?dy+eVUeGoYMgYYVGtZs6bOzAL11QO+DXrndwW7rzxdciG31QRMq4nLUI1Aun?=
 =?us-ascii?Q?/TaRQlKoA2cxdkd2OD7bNmHyFgYBUxfU/325gcZu2WMajg1KoFwp7XXlgqO9?=
 =?us-ascii?Q?McNzhaWQ5DJ6gnQU8mxNHidXsneipLJ+tiD1gvxL2mjixUyxocRXjM2NGoy7?=
 =?us-ascii?Q?KzHRsjByrcSMWzsTkJskwqQ1w5q+2w6qIXzhpLNQFUcf4vabxA9hWO4Ld3Mo?=
 =?us-ascii?Q?mlMCNZ1ITpl5pEy11BgELpi7llmfofwhvk3vfowisKi90DgPg4Uy6Y6hoz1A?=
 =?us-ascii?Q?0KhrhqJC40/CTOTjk1tMAnjZ1/TR+n1YP/h5+H4QH46zaGzdKGaTgjZHYskL?=
 =?us-ascii?Q?QDJZXLt3oBY6I4Xi6FCAiDrDdzGG2bLa1zWmZizYqHVrSib0rz79d/P3G1Ts?=
 =?us-ascii?Q?7+3OloraMbJkMN6I/yial63nBN2QxVlhngkAQBViu6R8MkzCdZLTcDZJL4Fe?=
 =?us-ascii?Q?++uwSiGHzsaNzifdQ3GCnE1wepn4+0HQzPXNcVYVRk014emijwyunuEF9FXO?=
 =?us-ascii?Q?gR90p2mdOgZznzCi46NZZWkHOf2fN8C9NjK0A6mx9sX1MH33pGQif0F1jc34?=
 =?us-ascii?Q?whDmtoGj0abB5XkpVlTkjuHTkhs/qy2k8Wa2opp498OQFEaCbnkucQtbV9Pt?=
 =?us-ascii?Q?+z9YHyjOKGoS5Lkbt7FYstZifFsfMD204GGwsLM6pPs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b938773-6d2e-4b61-34dc-08db91e79d67
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:00:16.8549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vB93l48+uQlU1dTb2QU44PBlXRfWazodRwfHCE0VaYLWcn3o3kV/S4YvsWXiVmMTTmPj1bAdzt3ALThiAiQuZtu1racWMcNrgZZQil5lyBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_10,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=784 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307310153
X-Proofpoint-GUID: 357J1rjbp9Em44unbmeIVMw6OOeKylQu
X-Proofpoint-ORIG-GUID: 357J1rjbp9Em44unbmeIVMw6OOeKylQu
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sunil,

> LKP reports below warning when building for RISC-V with randconfig
> configuration.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
