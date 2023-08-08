Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41947735C7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 03:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjHHBN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 21:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjHHBN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 21:13:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79CA9E;
        Mon,  7 Aug 2023 18:13:55 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377Kwvlo019538;
        Tue, 8 Aug 2023 01:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=YkwD9UTrYaiHd0y6loHeZKE1swSDiUmeoQ8ikYKMgMw=;
 b=uZxBudTuwrojL72aCRoDF5WoSsBcoA07cGNnEYaVMHOe8cvxQhFnMhpOSL8v+iwOqXWS
 VFOxBKNPN2shojV1nlVUkPAzVSY7pWIFy4mhDv2KCNQGZp7I5g+vEMjyetxbsWSblLFR
 y2hLeTzvfYapmPdhk8qJB6NTPdnP2G2gME7AiYcm584eQOu5LkLcBSLKvHw1fBj+roBw
 /D8K9Ks02qnhriw2+F0ujUmSGHAtOlqqzebf3Lcldu+krzS+INUQjB2OjfB6HPOKekzY
 IiiTEne3i5sRJBYCU/+5QXRkXQQie6eMMtCU9J5qUdmpsMy945R2SVy0AhwQA3ByIhcd MA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9e1u413f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 01:13:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37800SiP030552;
        Tue, 8 Aug 2023 01:13:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvbbhu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 01:13:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9VSCgZz5AFGPQSQGIsCG1ou2Gn4UsNhJ3+WsFGfjvA+oYKavFgHau6uJp6RNw+gFVGl8jx60fUxGJZwT/v1scXHGl/CyExP42V2PN44ivGMzTrS5L5giD8UYXPRu0aeFWh+cAtprbDUbEJ505lWt0NMfdz1oXLqBme9aMLurWcqeI7kzIAnush1DC0vAI+ZVXDo6yBO9Uy6qIvH7iWzaw8rN2djtDkqzKwHBD5E2CNmA3+mmvj43tDKi5D/Wka8BJ5PXMDYbav5wBYDTB0zcAiQmReBfJhPvyWMpuFQMb0uSlw9D1B9A8a/FmpYYCN1PiC8jVhfsotlEHdUcggZ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkwD9UTrYaiHd0y6loHeZKE1swSDiUmeoQ8ikYKMgMw=;
 b=j10TYYY7Mo016pOpzXAfWRfnXa8e1MTQ5ZCb+zlUDzAb0urouRIS1vo8hMZyF1kbzAB0ZfSCTZoH5bal/mGtvxeq1oXNDT/ZmQwrWWa4TnDpXSr4am4ZhkdcbHEmcX44/RtOb8WIJqStZym7ZBXDMEcEDNPFUSFqyJSOvtxemCXw5Zh2MXNJa6nyyiumy5sUe5mEjGszQ5Cl9hjBShmqPZ27Szek+o4S48ogaLroemmNZzUbYv+Abyc+pYJJBbf3eVZS4c1XJgcuLbwsR1Pcz1ke1sn4hYlCUUA6uDFr1MKZ/GTXABTdxr72Kj3yGLKR4NQrsb/mp3vqKcp2dQExZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkwD9UTrYaiHd0y6loHeZKE1swSDiUmeoQ8ikYKMgMw=;
 b=0TR1x4A/oiYiW2OHhYycMHbBFm0qhQA3OwnhJoXNAyJGDR0xzTMkzzhoj+T+GlBiosrjzhFmCk7rqYAgF0V3yntixGMz0NMQhMTWHJo6ap/MiaTVSINohFQcl1MD9r2/kyDsQdE/KILLDE375vWSOttCrDOIax0kcxUYLQW/bLU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH8PR10MB6385.namprd10.prod.outlook.com (2603:10b6:510:1c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 01:13:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 01:13:46 +0000
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     andersson@kernel.org, konrad.dybcio@linaro.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH] scsi: ufs: qcom: Make struct ufs_qcom_bw_table static
 const
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs4ul4jh.fsf@ca-mkp.ca.oracle.com>
References: <20230802040154.10652-1-manivannan.sadhasivam@linaro.org>
Date:   Mon, 07 Aug 2023 21:13:44 -0400
In-Reply-To: <20230802040154.10652-1-manivannan.sadhasivam@linaro.org>
        (Manivannan Sadhasivam's message of "Wed, 2 Aug 2023 09:31:54 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0037.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::12) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH8PR10MB6385:EE_
X-MS-Office365-Filtering-Correlation-Id: dc81f03e-35ff-4c23-d078-08db97acb6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2kYPxYwTeBjMBStwTYlTC8MzJpGVwE63HOt1xxmXqifiMQ/gOrYE12pONsdVY/bpDz0p2WhH6SAqyMrEdt2PIdq8GeynqMJSxUXjFTLTXMblQ6znUna7yPvHY2tf/0Gpb8ug6F4ebA4OIyK7/KSCPm44xWo66jwOLjmZkDFwOIfmerQ11y5b4la7KNGdIe1Pm+BmN8lu85QDgFUSHY9fTtl5U2jhbl3b5Dfpt+mR5vOobGRSV1H9HJGL89iq3ed65oPKLHAuYblARS7FxY7ikRa4NKtBjWtLXW6Efq0x9lbvht8A3vo8TGYQECnwpb6GW/AB7cxBbBdRRcLbxJZ+MQYf24u/JuBZT2lkZNioSOR6Phja2aAvf9JXbzw7nL25hTl/zhS44B2fOK6/wsYQIdDMn4aykk+TNW7oXZ4Z2Qyp4JkCu6XKpYAnvzpXTSOLUxwzjwcW7BePnufhc04NcA53cNyA5ZN8JVTm6yF3V0ODQh6Aw9bAs+tVWv0NXcQrkYxW9kLGykX7vdDSyIJmKtkaFrRa4Z7EgLAkDky2bx67GoKRySvE0V6me0PCppHKMzNjGX8maGCEygqkb+xBXdr5GAcN2ncJ/HqVPiNqJsjF7bP7Q9PUvNQIriHAr+1UVFJmHcCJqWmqsYw0pyjmWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(136003)(39860400002)(376002)(451199021)(90011799007)(90021799007)(186006)(1800799003)(478600001)(38100700002)(86362001)(6512007)(6506007)(26005)(558084003)(36916002)(6486002)(6916009)(4326008)(66946007)(66476007)(2906002)(66556008)(5660300002)(8676002)(316002)(8936002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vL5xjuzdl8RNeayx1JqGNwhMyC8FL47YY4JJ5RfX9yusWexla473Q4FfoJSV?=
 =?us-ascii?Q?8x5kVOT7Kkrqh3ia/67om1r73eFT2lmwTTez/k2KPlovDCj18Msmh/AAL/KW?=
 =?us-ascii?Q?u3xlZanmfZbMamVByvWKKYdYGKr8iT/1ZWlsA2fqqB8IBqx18V/Bvs/Oe1JH?=
 =?us-ascii?Q?mx5N6liK49ybe4BWP3X40/hmKvMxVu6GMFW2j4PvmiVbWQul9/33p5ZIWYmV?=
 =?us-ascii?Q?riWQXSgo4Zb6qQ17fZhPFrN9jsCMlnwSMVEA7uwgfAGf3PvdQWOReYps4wRM?=
 =?us-ascii?Q?dHuUL7XbzOAO23nRTiUNcdn1oHle9D30ItqwT5PY6haJq2sAjZ7WIvbhVQTa?=
 =?us-ascii?Q?mvmFE2uVAXvmDsLsbZ/VS4KfkCeUMIpxIOIiVdEkQXE+qIt5YVTg5AaTm1jt?=
 =?us-ascii?Q?2FQRPRCHwBDjzBy00cJzOKw11FpLCjLCilbKUN8qZdgMhgYi0oQN/jewMsvp?=
 =?us-ascii?Q?6l8lULBhHGiqfeTmYVbovjOA8vzss4Grs8wGrpgwBnhlLMSI49HadpoCYvAn?=
 =?us-ascii?Q?2qITVo5PTSONLpUwCDlz8qRms8NwJijYN7doSkBL1cdHQTLS/Q0xfGHnATLb?=
 =?us-ascii?Q?LTikUShxiCk0Y6aPotKJgT6R/jgcnvYWgXnIs+QeQec4a37eMwGKal7vAZ0W?=
 =?us-ascii?Q?Oe2Xwzbj3xPREnsFTficNA56v7SYB5Vc8naU//9b/qpeVsFNEJFjqqYUCr3P?=
 =?us-ascii?Q?PSJGzY5+IZklpTaD7drs6p0NDtuJjqnx5ZrjINFEwGm0o9QbBJigamlHi9Vq?=
 =?us-ascii?Q?PsP+2OVhloXuSYeJ5uFL4pzHSudFKWJ5DV4+1pMa74+umvDEtov3rp9LU2kM?=
 =?us-ascii?Q?C4Wz/G6tIvDEW09GKrvv7FIZowPP22cgATcAiPy/d/2wiyjbzOA1r+TS+jjR?=
 =?us-ascii?Q?pgiOySKljhlFC3Rl3sNCRsgUI2rHpjq5zaiDkPy1PWNh9AKSZR9MouU0TJjb?=
 =?us-ascii?Q?pyIRtMamsrChMZyzxdTknXRqbd2OeCSvG6jVLcR8wGhD8T8neCMvdsGBkjLD?=
 =?us-ascii?Q?Nv3hSRpA59lYW91Ms59qWnc2KQavQ74S+rx4bASw79NLpBYfKtbFkNsAxpiz?=
 =?us-ascii?Q?k+sYk2cpkv3HP8OE5rNf6n4gppEBL/Hm6i0C9LwHbb/jAjg9ZBsr3jKo/tR1?=
 =?us-ascii?Q?pjBt9Q2d5CHi2JAOX5c5AKTLgKV/HRrj9HnpNSDB4Rzndze6pu2Aq1p+/j9B?=
 =?us-ascii?Q?d+9iaKHl8ApL6KMp9zwjJoFtuW1fBnZ4BIiOZ4/tKwq35J/O7wJjA5kvu/ut?=
 =?us-ascii?Q?20Uhtu+7bUkf7Tv15k092E1SXr9nuCSRmXySB5mqrq1QjZpvAWAo7ljNFia0?=
 =?us-ascii?Q?3MPaIvMoiGJXonqw+wHcTObQ55djSQF+O+QvmzCqxMKRgjhb7ZZ2uCjATnDK?=
 =?us-ascii?Q?oRY1qG3PNPjzSGYc1qLAn1TYmkZV2znB00K62UmAPhgr5KjQDM/i7UTjfHHm?=
 =?us-ascii?Q?6Ji54FO0Dm0JWMgU+fUYJmTlFdbbbykNtmz2BjV0LI9BmL5K22hvb3UgHEfD?=
 =?us-ascii?Q?eIZ7unJeMPak4P/fFos8vvwZ1R+41/3LF65S7XK/FoOTvHukYuf/ruSpsEcE?=
 =?us-ascii?Q?8VapXnp4iqPDpiG82mI+VQzMIpU+TYYNKbXLxmNsvaF/cAASi0HW9Bysn5WV?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XLL7hpUf0W54Vqn7uQ0COq24kiwiV+I1H6yC2PgFTXXWlLaOl1jTZ8zxCaDEjzqBP/DU/A/44S2S5hbicdzGVlKnMGfViluP3evEY/9Wapc0esMSfTiMuMu9TJnhUEeSDtB2/GmA7l6qpShFjK3Kr/vbhg3HZK8Q93ZMoTbBtpd+wMz2tJiGOpK7jb3TJ1W3z6uqoKqcxIM16JbCpBvPznmmVKZcsPoYwGcmb83AJmnRzVRyruluTnAswYVLzx2OuNtaizrSNSY2KiJg08sLcjdpEVlUDEpZBRRrbTBE/ZU8wjdgwbU+q6XsGmWXj/7icZYevxubqmtnquMneHyjdAAQWmG72JZHYVGdy1f+VGC6pFNDBlIQjl4t5r7xktGPSpZzT3bsZzDvV4MDhRvJ8WtfS9MbA6UrWHENHTAWxOTpggI2YkJcpcB5/jsByObXYHgfxxkYcRib9EQPRKhXPAzzjNBnr83jza6jydy+fpCltY350EIKtKc8I6qTEWmNDeXAJMuCKjktjxznMYqM1V7wsphgvS55Np4+4cvd3oy1w5DREsHwrmDWgvHDQ/5RkGd50k1rX+skVHGPhdFoum2zVO2EuxiQDLjvf3Cd2KfrF7DP1j15Vq4H8gbVwvaWMG5VS0jeD7XmYZk59Zj7TBaRPXGOAj6aQY4y69xnpZMWehWiMvcegdn1HhRMlPYJruW6Gtatf8WiDpCPPKEb5KQ2Rt8J/dAtDS+eBU7MJS2qIc1I7adVChsV63Tv+7afb6k2Wk/Ixm9h2Jz1gMlQr+G9o3lK5x+Io/BgvMgm5B4r9tQlQpDkk5LM/rInMDr7vUf9fC73ffeP9UJSlFta8A2RoSD1yqLrJVybxvsuRqK6Sce2I13zTmHqS4zusjH9
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc81f03e-35ff-4c23-d078-08db97acb6f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 01:13:46.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bs+04/aRjXRf+KcYlNy9ni4HP1NDC1lcDeDUQ5MYNXcUdkkqazpvuB4KQ7ZdBUtV+cBZung5yFWPU2OLgNepbuOAP4MekWWXk0c2urFnqSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6385
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_28,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=810
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080009
X-Proofpoint-GUID: KPapCFu254IwFkkSNwIwxsh5lBFC4X9Z
X-Proofpoint-ORIG-GUID: KPapCFu254IwFkkSNwIwxsh5lBFC4X9Z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Manivannan,

> ufs_qcom_bw_table is not modified anywhere. So make it static const so that
> it can be placed in read-only memory.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
