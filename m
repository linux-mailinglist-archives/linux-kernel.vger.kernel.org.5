Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7A47CB7AB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 02:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbjJQAyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 20:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjJQAyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 20:54:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BEC92;
        Mon, 16 Oct 2023 17:54:08 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO4xE027744;
        Tue, 17 Oct 2023 00:53:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=wzW8S8KrAJS42rKG0pjCD8KVYqfsP/OaN6SD8+WAWPs=;
 b=X78IgcdnoWmlOq4MD3+nCH4UCHPD1ERs57FF0lGKiNxB4iUvOsVFpU3JmOfVmSJReAXw
 fN9cE35p833uFldLt9dkVSkckC3LaKr+y1pyGrwDsg13cWpr4uVCDshM3Of+yzI4IL+b
 8rVIbZjytFTJ/z3zfKXoEfMdQwYCtU4+NmbMCl14lsVBrvecLl4y7FubXabwyldVv4pU
 xmokgL4HZVuvTI9B1NzeTkie2JjbsYyNQLtD9SB8K+i84byVIoJGujJ02aHbLGdgiAk1
 Fe2XjZJ0GI08vwU0ZJZAEAIjGFADpxoZZzDI/WFsxW2LF70WFWMxqJ/KNjRTOjpTdTUC Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk1cc21g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:53:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39GMc7Ej040709;
        Tue, 17 Oct 2023 00:53:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfykm638-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 00:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+W0B4NOgUt5HR/c20PvxRbKhD+2t7ASz4FIUQCYpNHKAGZMxTp21hzHZxi75uDYRnpJ/ImyzWG9my5NwHyct7pe7pXtEVztOD44QXGr7McNS5kqb+5EkISDU0weq2xdV03HPrs2R6SLONbN/pn09vUHqiB5Qx5ulbpiJZdpJhwBs/24NiZtWdvSG3Yi0o+3zagDK4NmcrqVgC5t/QyNaNr0pr6xn8rOqV2bVjjQp9exLtkrG89HLTAyJHgSMPa8VA74b2JZf1dt7gatY8zXH95OqscQzDr8jU1QtBIovYw2m8lQMRQVpnwpm7TYbe7iff1lT+EqASmQ3BYOxb6giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wzW8S8KrAJS42rKG0pjCD8KVYqfsP/OaN6SD8+WAWPs=;
 b=lU1DcKfLrnlQ58yb0InS3RqpWPJ9VZnNISYetcHcLwMW36yhmlJ0YscwuA4bxx1IQ+/OZ7YgdLjmvkQF3/g3smNgUJ/O277p3aWBAZEZLiEAjNC4QNQ5ig3OXlnIxC6SOQWYKA5Fp00WrQy9W0kKx9BfDvrp1/mfuf6eR4L3hNCBbThme+OU3J/xfgzvgFg5wp9YL1p7SjMZkit8G5BIjFfmbvOk10ljHWlxJ7hnNc0jIb5SdVzDkG8rF2iGD7hqvDpM0Qxx2k4ERydxtYYuNVxK5AhAILnKBKDJ0zVulZDHo3i4AMZ+EkzMx9YmOse5CeNyQu6RQmNGqr518ol+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wzW8S8KrAJS42rKG0pjCD8KVYqfsP/OaN6SD8+WAWPs=;
 b=TTBr/KUhZIFRXnvXPDAZFPT1hMLuoOWAAb0OuMjSB4y2YBcIxc1IFSbnUNhepzwfcT40/2/95h0CNc6kYb+PkuETyNspwWRyBzwzgXTzV+cEJnGeA3bZeGBsvoVDWdmnYaV1Wr5oNlEvpd+Yzc6rg2V6dDXYpphrsp3+qAcV4eY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM3PR10MB7912.namprd10.prod.outlook.com (2603:10b6:0:43::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Tue, 17 Oct
 2023 00:53:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1ae3:44f0:f5b:2383%4]) with mapi id 15.20.6863.046; Tue, 17 Oct 2023
 00:53:07 +0000
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>
Subject: Re: [PATCH v6 00/10] scsi:scsi_debug: Add error injection for
 single device
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pm1ehxy0.fsf@ca-mkp.ca.oracle.com>
References: <20231010092051.608007-1-haowenchao2@huawei.com>
Date:   Mon, 16 Oct 2023 20:53:04 -0400
In-Reply-To: <20231010092051.608007-1-haowenchao2@huawei.com> (Wenchao Hao's
        message of "Tue, 10 Oct 2023 17:20:41 +0800")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0016.namprd21.prod.outlook.com
 (2603:10b6:a03:114::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM3PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c017c49-d064-4aa8-fa29-08dbceab6d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pyNUBshh1g/v5nYIQSVnKgzqAn9SPH6KAbyuICrDKm76oBwWxaMfxqjKruGhP7EVz2FuWEIvoh3q5zCU2MTuoPThr5N/WJnnfndMH8ro6wI6A2MEZzc8N+ENNWyp1HpygaccXxxxWGALXymF8AiHxpaGLo9JVLLBF08Z5ASMYyD8KcGSMU42Lgh0Lamm0SE6iME84DiqdhQrxatO4wYXFwhVERPmfPWd7gNyOjJNfYTus6UFW2pb9QnHUalfZLtiU+4SZzCGl/Ped1PXjQiPxxpxw2sd2lFgGq+zApeGDFG7uQuxqhuO5Vd6qNdtHqNNSRqHau3XWHWHHfUWTLV5m3B7kPl7YczTd+2DQbjfL4qp0Rl+SuJEwGuRgGeEiMGMe6PSthT+Evt+5ogZf7v5qPbrKEOg7FGk1FaBWhNaetyp1y+k7PuG/P7LsErMq9xf4cGIUnpAArHZqGZwJ8lvuOCIIqMR/QhtlaMktsU4D73Fza8EzAXOPs3wbFPupQUYEO1yhqGPv7PH/pIlhPR8M4QsnhSbMABfNRKZlvmwWDUA1NJS504IyYP4K4w5p1XG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66556008)(66946007)(6486002)(66476007)(478600001)(54906003)(6916009)(6666004)(26005)(36916002)(6512007)(6506007)(316002)(8676002)(4326008)(2906002)(5660300002)(558084003)(41300700001)(8936002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oo5YiF7QpSMYb3+YpfDaivYiYna6ihDnPULMoRVWQinzu3FBahIq6mT7JwM6?=
 =?us-ascii?Q?JTtIGT3fTP2IyDoPH7A9VOEfjbGE9N11gBWPtGNa4Sf874C/4+DN0+Fvvo3E?=
 =?us-ascii?Q?8jDuK0mBtBGnJ5lF2Pe2UdUgozq+Sj9208qGBdleQlek+kBa+mDesdUMS+r/?=
 =?us-ascii?Q?fpdpxUEHIBDJi6VwifbL2MYJPyPxSyO388Y+bl46quZJFkgbHsFgwZcTNNEb?=
 =?us-ascii?Q?NE0HMLEATf65OyTzrpR741Mziy/T+3TVYV8p8mB0SZVYR+c+QCal8i1wj3qy?=
 =?us-ascii?Q?UEXqN3L3v0YSGS3l0SkBweIoK7dx1A1s3ZFZoZdG5JSJZ0Nn7rTueF4tpijR?=
 =?us-ascii?Q?MAjfdUTgAsSu44fD/YjA+287hKbouzW5lvqRy0byOfXVyBi2k3GOZVsKEkTd?=
 =?us-ascii?Q?QLMdAqx4zwcrYzm5U3d/k4O9abKaBTrLjr5OiRsKGjtuD7SsxXbbFGpX3Pd2?=
 =?us-ascii?Q?ucUkNPpVruABgZGcgwdilBSbO0NhoTru4Mmo0LbMeumYSM5cVAh5VNd46zV5?=
 =?us-ascii?Q?oxTu/CQLE/mMQhi+vhJ/w4kZeMRQ+G+g2HzNjK7+sUrRk+uenm7QQtBBv0wF?=
 =?us-ascii?Q?uCu6gQ9ufXCXHPoLXBc8PQh4eCgwjzLJ9lVpJchcLjCWZsCGIXhk6sSqZqkT?=
 =?us-ascii?Q?ogQ26bdaTUk3mdVKIvyckSbfGdXmTFUUk/qhu2WzC4bi3MUCutMgKLfx5hjH?=
 =?us-ascii?Q?q69pwLnr+2d0Z/riXpmyxM3wSksHrxzWHi2gJ7zwhDZsagnWnZkrzLRRvUwq?=
 =?us-ascii?Q?XHuHAY2wAHzeaEZnzqRpGvL+bPqbpRE5XimSQhhev0FYZp7Gf3IiyBN2t2rc?=
 =?us-ascii?Q?TdDjVItDtRjSki5FC2zbT1Svd63s32FOSqQULc4Jy9pSFufmY71YPnNk7eTr?=
 =?us-ascii?Q?0TR1hCdEHDkl2BXwSr1qTbn80pvpkQNHXHRTujK57ANXm4mG8gYG1DhAq6rG?=
 =?us-ascii?Q?VbsETBietUgL1K4hH35cPk5sQnj7s09TxvlKtx1EOPWj/pc9rPU9UJjOvj+D?=
 =?us-ascii?Q?HyY1dV2y1mc/L1nhIxceYuWbp4cGlNUrLp8sSiALnQHvI/h1YPAlbLKTb6wR?=
 =?us-ascii?Q?x5UrFMF4w2i1S21tsQmQiG5+E1y0I3vFdmhsEUMQfCsyOqxhTtx3dygHYjsO?=
 =?us-ascii?Q?/6GI9vpOO2YzMm7BafkRH5Iu/HK+V41b7DGFZSQVYXBt1Dz7bgUi1sEqFJlL?=
 =?us-ascii?Q?8IFQIaw9zI8tbAjfO2V+F3H2wYIXH3RkL7OMErZ0TbV8o/v6QR1MtnMA3Oz5?=
 =?us-ascii?Q?T2N7fcYwhKlsoxgVB4R1ASwHbGxJ6Gp19LQNcFdaPtXH4zKkTInVgLdzTc+9?=
 =?us-ascii?Q?aKmWE5ybAHubOC6Gcg2JTGxOF2NOiVTGvcEjfLZads6IISgnxZL10AlmSHT+?=
 =?us-ascii?Q?dN6INQFYKH1jsCMfw8TEcfrfQBNIy2HmaWrq3wWOOX7N9rgrmlCJjx8YTIpN?=
 =?us-ascii?Q?3Sgyl8QRi3QURCLZsJL9EZ5mSfHT84SOorNVKq1PB9OZO/GYVr/etdPoE03q?=
 =?us-ascii?Q?aRXiaa0LpzaqbhE//f/ICTK3GR1YFUJNd+l1xmyeCnR/jvhGvH3V4K4GaoK5?=
 =?us-ascii?Q?217OUHLxt0pupVDuIX2/1p3DY/E3EXx+l8Ee4nXDvDxhjE9VBluktDHcYfbS?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /8kAyjLUpC9IfBBsaT5GDV30Jyh93LdW6OQtylmCFUAQuv9rfCYXDg2ElTewgg2VygTC1P8nI5mI3+U6RyYfv1K/fW0IuVyuw5HuOtaOEXCn4mGigjMLFSSMLIJfNlVtcJCsoW/VACqUSNKiyvw5Dfb/PrCeKYI0e99RA28tWO5OIo5TsPeO33ufGEyLdrQYM4hTIQPGgkEu5ghtKKbJqQA0GRgeszi9OPXdX4GzTxySIq/Anc52V31lBic6H1TQpqfPLpt2jor65m2huIgvvr/G6Wlh2qE4xVBq+ZjgzvTPiaKLL6AItobYNRjgPVFv5TVVwXs3p9M0l6QdjztFnXe1xHlbwAh9PkIvaohmj+pOs6pcaCZGT5pTjEKdZiChVCmIxYasjdfyAOPPCaVjSTE38JCMh03oufHhJdS2MaRFxjw0ItxBV7YBXgBPmehoT6cUroRZlQkVznUuImgq+NqiDEL7RH9SkEqMARPKrE6BQr/RCW4qRwhLEgor1xGkAVWgCQmWR6nqjX1RG6QH+q9VVcGFpoOyFUXPe+UKMKxHPS1EigM9k3rQsPiRR0ShM0ANby/taPENrmQ88ikfChM6nWL/uJcWDdG84TMhvZCeOMhhM1ma3bFE15w720J6auU372+midLoGRd/p9PF8VYVs3yTrMZea9qRUaRw5351e7GqxnYlX9QDuGqOxxNkd0eaozsMRnmQ2eZvdvMbBGzogDyeH/UGwuUMOrRJwErsZ5S2lsKdK0rNYunmx3L9zHP7TWqKsvXUoIG7Gv8VC7K95fXNFcQbD5BKW7c5t0m5Lpw/4Zhybgm7W0zsRLcj/bcX97tRfmsxTyBclDbpcAIHK2Ds+5RIBH8BQTGkenQ8xX6gX3ZKlTC7QEfckZiD
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c017c49-d064-4aa8-fa29-08dbceab6d66
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 00:53:07.4299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Zd2e9S8kLE4hduZd6EegwfH4pru3V+PSdhhf6uXayKVhv5d0QOSmrWe2vcHDLlhkKlNqbJRO9/v2jvnsc4yv5aBQy49Z6zPh1Nn8w3eMzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=755 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310170006
X-Proofpoint-ORIG-GUID: ucPc96H1HgGZ53n_Ws7DTYry-xZe9ySV
X-Proofpoint-GUID: ucPc96H1HgGZ53n_Ws7DTYry-xZe9ySV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Wenchao,

> The original error injection mechanism was based on scsi_host which
> could not inject fault for a single SCSI device.

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
