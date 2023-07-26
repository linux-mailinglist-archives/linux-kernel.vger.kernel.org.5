Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CF576286A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 03:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGZB44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 21:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjGZB4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 21:56:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F63272B;
        Tue, 25 Jul 2023 18:56:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIv4B019208;
        Wed, 26 Jul 2023 01:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=b5IVpyu1PSHckLYyrQUzFIEprKf+tRh+lvalAbv7zDg=;
 b=LU/t8fIdK+2iZnxYgozY4QwZ7wt/VYuR9p9owcONDFktLMZixPLobBO13QaCjmqGLo4/
 DYkCw5eJj09c8wTw3kn/IWCoOgSKrFiUUc6vTbEOSt9ZLCR45UhcP7jrcF73EscBX+IJ
 R6KRBewssf4VrlAtT842Ev/3Fg1Gf1Q+u3vUhWhlVh7nWHx7hpmc1G3apqhduNqKe/wC
 rhCbfP90C5cstmqAhzSTwx+fAePLp2bpBPFEUq4Mht9pmADlM5zdpi8NqasalJignhdx
 rD8YFbi768qnZg1B00xdK3XT7bu3vbHTiefB2ZqqVBwqqsGWxFU6XO5fYNdM6Cnx3+Sy 3w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s070axdb4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:56:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PNt8M5029422;
        Wed, 26 Jul 2023 01:56:45 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j5jjth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jul 2023 01:56:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZbWJv8mbKgJOM0ji/hbb6tKIxilUJLh+sl4BUQBt6Sh30OYZVKwTNjK602bcRQu1MTDnBeCtwk6yKIy3jZfVqCBUR6+xVR2t1je1cHqoMgJ9i4ZjVR4NgsUSnrXKVd0f0/syayw1iXCzIHHv5u2v0fRaPOZRiVQRu652vXnihhTK3E2InnXSs+xT5lm4aGtyY56OGvsmKWaeJt2Ay4vFhyVRWdIWZN5BMlwG351yaLPv7EHK4M8BHDa/TYr13Q5uIavM0MiCNphf/063Xwm94lkddxZLt/lxWAV6ywBTEhG4EG63kzmzoikwEAUrZPumPunNoKYHmSWhuoUQaU3oIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5IVpyu1PSHckLYyrQUzFIEprKf+tRh+lvalAbv7zDg=;
 b=iz8hhPOzwvZsiRfplonZlOCSAhcYWk8vsrK+9pArNb09vxtXUHPD3d937S/5O29zOwfKQtl4Dp43oXxIovksJ6u/l9Pvimyg5WWvc7rosQ1yBpPpnPTKySr1+2/xrxz6b5mUxNZSWtyPam4KZNMKM5b+kL6FqLl3cX7Gu5RuGCghp2UJO/R/NMdROf7E4qdEK5yNIFnDG742hl2pN9Cg+zg5MVtlrBWofdiN84PgAJEAimgjb7NAC7ubJGN09IsNZJ1Rdup+cjGTAudXCySZvHxsuimraVTWzfoVJwvnTSB2W9ruunWuohhr/Tt7c3dDBo8iibagGJ2up3wzBoWfOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5IVpyu1PSHckLYyrQUzFIEprKf+tRh+lvalAbv7zDg=;
 b=S6/PZH4UlJg8PqUY5oPlr57+cyk+EfTyDH0J2Ly2lCuZ0EAiUkjYIUyBoKXUwHEt93tswlFCZgh53mlD/LglItsqoWX+B7NLgYPY+nOWpZhuKOCtQfyQnQp9u5YEBLA+dHUkASVBuNt3eGjMYGcOrbqEzYps6ArjShJfxN5qJTc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB7306.namprd10.prod.outlook.com (2603:10b6:610:12c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 01:56:43 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2dff:95b6:e767:d012%4]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 01:56:42 +0000
To:     Lin Ma <linma@zju.edu.cn>
Cc:     ketan.mukadam@broadcom.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] scsi: be2iscsi: Add length check when parsing nlattrs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1r0ovxwoh.fsf@ca-mkp.ca.oracle.com>
References: <20230723075938.3713864-1-linma@zju.edu.cn>
Date:   Tue, 25 Jul 2023 21:56:36 -0400
In-Reply-To: <20230723075938.3713864-1-linma@zju.edu.cn> (Lin Ma's message of
        "Sun, 23 Jul 2023 15:59:38 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0416.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB7306:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f08e4bb-24cb-4c34-1d8e-08db8d7b8ef1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t+UG18V+GMAM8aK6odVKbpgDTXYxnUl9O6Skhm1SZYn5Gp2LDy2rgXOC8jsW?=
 =?us-ascii?Q?VQNKHRBWS5gJ0ZbYqziFYrIFVskBlehDEHPGmJIfeiRELl5uC8TBF4otv/Wh?=
 =?us-ascii?Q?gYsQdGEIBmghioWlOszRIGRkkMc27hM/wzZgtCnrlXOTxZ8S3oqtPKs8S8+n?=
 =?us-ascii?Q?3HNX3A0X/YA0s/jxiD3bxn3EuhSRjz8CKFebKPi+EKAx6ZwvmTNetmMI2/j0?=
 =?us-ascii?Q?e54Y8mfJwlukBfEYwA+0vrAE5+BWpd7kZRgyINi5c4/INHPd1tnoc8VFW+Dc?=
 =?us-ascii?Q?cqqmUr9uqVsikArK8n6LjOYGvkGBvXk86pgzfpQm9/W67xl+UskLjS7GWtxc?=
 =?us-ascii?Q?PmFfhwhs0NoQhsMCoSRPDVNcO8WULXRyg8xfMxpcY/BNlVIEd4KmK4FCyQ4J?=
 =?us-ascii?Q?//Hw63lVRI1DecwVrJRR011V38QPkpLX8+44zk93jBw6nyl4JJpMLfmQbayX?=
 =?us-ascii?Q?9JQXozkX+ejR6WeCyXypc8G99AdXgIXs+XIfLvrggacR5Ixt3rxucyx7Xav3?=
 =?us-ascii?Q?JWAMCWeDgzkkFW2x9F6pqD6WEq06Ol7wK2gDj0HpNwlaYLnK8WhDvi/cxkxC?=
 =?us-ascii?Q?+e+IkV2TLBZwnDNjBJPwpyDl412WLU8GQ1Fk8+RY4CtCVUmj0gV67LkwonDt?=
 =?us-ascii?Q?2Nntan4UzVy2T+eiP6GpmyDAhxJOUPGpGwRSc2zVPvVcqpB5JooSXXC5HMps?=
 =?us-ascii?Q?sLQhz7Pd7TuQJVFt6BETZ1/jU+vgRzKq52vAZPyXvDDI5eC8R9KZGbFWaM5G?=
 =?us-ascii?Q?TwLdD8VvX0mGR+m52V7QuUF4VERuccqVurHTji19RObBYkt3xFnazgnZNAGi?=
 =?us-ascii?Q?A7qMEphDvKS33CFTyNIVcqxJ6PWtyDefvgcCQS97RlTPEmTHKyhL4F/dJOdF?=
 =?us-ascii?Q?LkhTKgJ/upj4r5kcVw3FQiKULeuFKgicFQtMmbBT8lbvobT3gHtx+zb3O3HL?=
 =?us-ascii?Q?q+85MkG7Yht/BkvaTC3mryRctm+kDOCAwaQruo/nZbDt6pgbavnnXSssTZlm?=
 =?us-ascii?Q?hX4Y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230028)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199021)(6486002)(36916002)(6512007)(6666004)(478600001)(66476007)(26005)(186003)(6506007)(2906002)(66556008)(6916009)(66946007)(316002)(4326008)(5660300002)(8676002)(8936002)(41300700001)(38100700002)(558084003)(86362001)(59833002);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WmFRabtlzc/QRnrherWUUZlIzrN/uv9TfJ2MipKuZw/NK2o7PQ764a7Y6MZJ?=
 =?us-ascii?Q?1jIRjccfEcqpE7X4qXHcdQXaONZvr7+pd/1J8fjfbQ6PwdyvnNBEh2E6hm68?=
 =?us-ascii?Q?ETxC8toC0n3pwkEMIl8vkmTTSHnw0M7JQ6eS3PDN6E+YDbY1bjMYEq4LLvLw?=
 =?us-ascii?Q?wyr99XtxrQuhu937K6O7jvS767nY9RNWwpiTOUSJMaSlsdsDGyUb7gGV56SB?=
 =?us-ascii?Q?k+7xQHUWAx8DydRt4E0oigE4atkyyYnJuTKwOCmej/mue+zMqXEBMq7FMH04?=
 =?us-ascii?Q?yy9OLhM4IJhx4OZe4t2CCkGpXDO3qpaLtDiiss7bJ6ra+WL1Hdb72gEItVke?=
 =?us-ascii?Q?ANWblNSEXFvGCFWiEJ/tjjfjQ/nR/FxsbL7EN58jRKrBlmo+E+vta/CWYklc?=
 =?us-ascii?Q?fXwMepFaESliL6NeE1sv6RIc1/eGyPlz5BTIp+tC+0pIh4v4tmca54QZ92Y1?=
 =?us-ascii?Q?fhUr6MzuIzVzau/15uqDlX4z9+u5+ZwxLzcMc5Wqs77Om4MbSZqg614ffr/e?=
 =?us-ascii?Q?gT71NuO3t250jcJ6WCrrFocgX5syC0RoPIGjaU9xn2H3ke2eKrjN9EbtCqK+?=
 =?us-ascii?Q?S//rEpYghc3HU6UCxoFWfpipXjlfReL1p5GjOmDZkfxyIgApf3/JAMHxbwOc?=
 =?us-ascii?Q?1wVRDW2gNXzWX9PfF7cHp9cYnEuNkplVAwvQJBSsURiy5UTE1tdw0YL4xVZT?=
 =?us-ascii?Q?9/5P/drYwNVWnYgnygObYrNi6j4vqdjYZ6EwjxPbAiZt156iThfw6CM+G1Dy?=
 =?us-ascii?Q?GRJprEZosaSkl28OLb02AiOGuu61guMRBK1Dw2ieketIRDnoyqfEi9P1X3/l?=
 =?us-ascii?Q?u2ysT8+alenN2xOP6/sG4lxBgy3Qt4G7XQew27FGfkTN7PyHF3MasAi+foFg?=
 =?us-ascii?Q?7SX62Lui8gFmMYig7bC8T/zemH3rWZQTqjXW2dBVwM7cBOXQrSiNYbbOBuvZ?=
 =?us-ascii?Q?IePwB0ur/X4AOhQts3RiJCXGxLoaKCQknJ1BzUa4iZ9DAngYHxY3iMP+qvK4?=
 =?us-ascii?Q?P/XlXU58a1xG4BHWdTFd0EpUeUfR5lzEmDvQ8QJPE0csSE+Lt19Z6UUoiDHB?=
 =?us-ascii?Q?OTgkjI+MwLBnY0GcVEzRUbEEsyCBbeqaA1jkkbexTFGjy7agngmlxRpmESLL?=
 =?us-ascii?Q?KmxeoC0SYS731kk1guN7vdu/+z+UerCQRxq44sj8D4L2QgVW2D2vrvJttAUP?=
 =?us-ascii?Q?TISy2xjnzNFK8HEIX36/oOR1tCbAafzGUdp12cu8A9vp8iuxWA2fls//9T2T?=
 =?us-ascii?Q?nNM5/1aiBkjxWPeTL3mnau2dTHRmD778LTE/R1sAB5K/JAQuKiCfr3CqHTLp?=
 =?us-ascii?Q?exEcOdGxr+EEc0Yoru/qpEFuDbF8+jxqTapqwqirL5JFq1wMxekOqOS+d0NV?=
 =?us-ascii?Q?fADnxvidNEpuYsyFx7cgUE40AeKHh2n3RsiBo5i03puER+wGyR867w7ROIi9?=
 =?us-ascii?Q?IMObh2Ndjo+mJHkENX5EEZQ+maXDOpfjlIyNBdP0jksmZUQoHLweGpeWgxIN?=
 =?us-ascii?Q?+U2fo1kUrWa84JDrjlKq7nLNsF3cc2NCRes3yVgKX3My69QSOtEAfkTyulAF?=
 =?us-ascii?Q?kxfaufbQGu2pDIBFIUixwiKpsmkWWPD3KkXDEQKJL/ARBcUWtGINp8G859Lk?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: S/+xzbu0RZSbVe+4f3Zi6BpfcaJeU6QZzGTEB9vyKhLrkW0l2Bheeh1UFWUZG9E7DVOL3KU0EGGAMSFIxIx5V9imdDErwgSEpqxGI6V3HyW56t7f9dRkfeNL5m9TSeMde9QLO6TQoWhXqRvrRYR8UrKp+ysSWaU+uE+qSH4XX/ILfOFmvsPAZn/5njBuoJCQU/G76LjNKByn6UNk/zL+AX46Km/s4l5Jvk9X5T5iPPYK5u1o/7bzSMbhuAkXDY0F+pP7+b8QGvVXXRkMf270FUGWgixXZi1Q54dQlYS3Vbj/SvqyOhitvIfFMu6QmCslFKGdUFSZg6VhDrF2nIe4/gyeSu6wX54kqEYoUu6C7CE9nT7JD8uvCciFXaFJz9P3GgNlYuk2QBImkCWBSRaoiXz5rhPfQXIK8kMSlKKPtef46+lBJNUQM2tD0Bh8E4mBMdaG9mI8/NxeiVCe9coNNjLGLA64jto5ZeXRkXex9sL+wDgSc5tWXOX43Hn0SXo8GstwocD//InS1pDet9/UA97T+hNqOyzTXrx6z5QnCYcmzUIWCrIFCr8zouysGthWTcpN8RaGNYRajgH8t1y4JPznf0XsV/KNRfsClLHmyofm3aMAusLtURMTJsgxacu0AK9WAG8ts2uI4DWGvzqTxOXj82uXk3gADE+/dLFolrgEWBtJrLXPXRU03gTafyAAEI8rLa8QlGy/QnuNOUC22JYlq5AKPYuOzjgwJY9Xup4Iw9Nntm6cpQEKCerCpMBbvYnDrqGdoLQbxiiIG1c+ASWKuizxd5qbsJeYEtik6VyOggFWDKUTmu7HDP/DLMmH57IM/J/3zqGZBF7tLzlR2Pr95PMxAGUqnGjDGqMLP+Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f08e4bb-24cb-4c34-1d8e-08db8d7b8ef1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 01:56:42.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MJyIEf/0gU6x597EpemNT5rKNd5MUe2PiNyjM7WUlsyiv6sg/Ce4fPFWLFqCnRvORdRzSqgXbriGiKhMOFfqHdi1a4E4jgkqCGXB0VXjkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_14,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=962 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260014
X-Proofpoint-GUID: YOmHOaglZoxN5sU7Nss7w8uIg_HRuaZf
X-Proofpoint-ORIG-GUID: YOmHOaglZoxN5sU7Nss7w8uIg_HRuaZf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lin,

> beiscsi_iface_set_param parses nlattr with nla_for_each_attr and assumes
> every attributes can be viewed as struct iscsi_iface_param_info.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
