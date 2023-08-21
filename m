Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C085783495
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjHUUxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjHUUxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:53:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401DE91;
        Mon, 21 Aug 2023 13:53:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LFxeVg023969;
        Mon, 21 Aug 2023 20:53:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=0ArApghR8TlTTpbIF+LrC5XyvolzcM/dxMs8MEUErTg=;
 b=T6BVN5ty34uF8Ly25oK46XsPR/lF3E5tfHbH18LF0NPU0Kbhmg8GhZr/yjyHuLOE4D64
 p1sr7yssqVhJlExz97ZElB2ELCRwsu+9r3EjYg6MzDGdab0xvdmV/eg4k6s5etrJ0NR6
 Bqve8pwcbcCRu/zLmZYguaoP/WOHiQeB8DJAK7oa7y1yXCHkBld5zvt/qd5St0FCJKsU
 CzFWVTpfV6BwNckqMRUgOQ7hq70Ag9ct+YlIQ88Et1FtKYyT4uYELAzVoNlVASENgFXP
 nd+5uE/B8N5DzRxkZDUXcQCiTlLcnQAEpPSmK/rn8Ix9kYdH42YPlnbJaI7tpBfH/WCY Hg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjnma3tbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:53:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LKIwrk029816;
        Mon, 21 Aug 2023 20:53:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm6afaq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 20:53:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc/eUKIRZjFa2C7lh1Ypybi+4ieNWLDdhQYud3OY85jxjLOZgrkHNAKd6WcJBfHYqpdddwDqjyGEUy6NUAiTR1cDrOghjsEvuX7RzT8eQNA72iEvuLduq8burM7+Dk9bod2EdxbFD+wavKCXwleR5DVzpqupVoEnqEiglacbDs4gdRuS6rNNQD9cyTLqUp0Ytw9EFjU6IckVFKzG07q2QWCA66HPUpEFlyAYcc1qp1d1QXWRiu+JY/MSVUxx5ZRdvzuP+f4bKjx6FnOcrpr3Faw4LXhBPPZTuyShsJN9oLMWa4BE15ayJn7WQkv4dKDPkfJmy5N6ATzWW7/uUmxw6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ArApghR8TlTTpbIF+LrC5XyvolzcM/dxMs8MEUErTg=;
 b=K0qamtr52H0yxDOSgP+8AX34FVo5xxFpYIkTm1wBZVX8myg7EABpTbj+RlNiO7jZCOWA9VRfzwnIfpI/jFFnwCOaBCEqe94P33TmR5KBhoio/ump6Jznw20m8Ft5fcBbG/iS3QC9hz3PHSgx0bORT3JgERAwIdDkePea/XXzqhabt4adHFjLOQLuBp9nY5pkOn1fmYoqDaghJzykSO3HDy3Pp+zQuC/264wAGxmmXrL42mocoMYKTRXeB2ZB1LGbNf8Olf91WorofldKXnSH+e6CvYHgU0Kbaq9jXiICnu+B4ggcz+iQAzw0QLf+74zKb5eVPXNLWTC9joIWHy8nNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ArApghR8TlTTpbIF+LrC5XyvolzcM/dxMs8MEUErTg=;
 b=ouJwSxU2DBiMRmSICR+P9Is6BQas58VJjOEzSjxkKI0BpCslrzXSjSgxW0bo6cwm9jR6qzLL99Aal+jp4SwmvT5KtsWATh4KQyE6M6yuWhQMUAJuqfufzJ704iDS51miZh/J+7Ze48hU6nzz/YtMStnVclGpR5RIC2/3iLt/KqE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 20:53:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 20:53:39 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Anil Gurumurthy <anil.gurumurthy@qlogic.com>,
        Sudarsana Kalluru <sudarsana.kalluru@qlogic.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] scsi: bfa: Replace one-element array with
 flexible-array member in struct fc_rscn_pl_s
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf8c6rsy.fsf@ca-mkp.ca.oracle.com>
References: <ZN0VTpDBOSVHGayb@work>
Date:   Mon, 21 Aug 2023 16:53:37 -0400
In-Reply-To: <ZN0VTpDBOSVHGayb@work> (Gustavo A. R. Silva's message of "Wed,
        16 Aug 2023 12:28:30 -0600")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0034.namprd11.prod.outlook.com
 (2603:10b6:806:d0::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: d98bf0f7-6fa5-4623-6491-08dba288b263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AKiuO/I/rmrrWKg/7GB/ypLhgKFsJfbaAkIHgU5hWwEJL0iyFAllU8i3QdUA83NxlosOPqHyrk4PzAa+1Y/28VQWsQhdIcIjsdt7GBHCrzXkrgMcJk/xX2/QO7UuAbmq0ZlaT5LGZr4HNiIQ696ZfkiY2eYIwXYAkBn49UmXLowlK+SkxUIqPnEKF+N70/iUNqmOLx+7eKfIlml73CBN6aUuyQP90sW0V+mHIlT7SXp+IhvNrVNPFp21HBdCCEthFashV+gt4rsqc9D4Bx959Dd/k3WWMyYygsd9BVqfShpACOcoIXZmuqL+JBM/myRbO1PgO8M/4h8pqnT1rXQ8pHP2gPV7E/5bweSSaQhYcfkiRGVVNddVBdRh1NR4j5/Qc+zcBs3Vc7/hCgHbsy0szWQ5+Kjr/o1A/HofSSdMAP/lT1oFSDFnqjHoIJV2Y06I4jjqnyPzN94IEmUFbAVDSLiC382cw4xQK8LJFCnSkVs9juzMMf1aR0MkZP91puO4m0YK/gzt3p580sEHhTy7ecjVRTbMIpXGXtz+ypLXi7E4HbGnBYnmqy12SDsws09Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(2906002)(6486002)(38100700002)(36916002)(6506007)(558084003)(5660300002)(26005)(86362001)(8676002)(8936002)(4326008)(6512007)(6916009)(316002)(54906003)(66946007)(66476007)(66556008)(478600001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T09n0wXmr4FGAK+6bN9C3y+W4FgpzQie1PUjkmnlDc0EMzvTM56kN+CuSRH+?=
 =?us-ascii?Q?MsvmRhmfU7oeAgCJysb3a2w6AH2D8iCKpt2sr6gisfFA4fpt5IoLph6wiCQK?=
 =?us-ascii?Q?5BDFu+bqfkN/0xuQHm7EOS60we3b9p8OJJAmyk+LXAB/2MnkJBtRsUk2BIY0?=
 =?us-ascii?Q?TC5U/CoNVs2QBuZ6R0K93r778H2WE4Ira2B2jvzAGukkwZoHwOlUcN1Cryo+?=
 =?us-ascii?Q?xM+BGCPj3TvM9HUF3QLurRTMG5OZ9SnP1gVsGepdYDjRuwePIJ7zL5mkqHx3?=
 =?us-ascii?Q?PlFi/Vj11ehONYbV9+haIIVyui4P5AebBJYzFFFvkhty52liz9MrXWdWLfb0?=
 =?us-ascii?Q?oMCr43AmyXtrw0tPvKNMddZSx8vWLGNLWU8nCtmH5XnF7yEkGKBZNDkLWeFa?=
 =?us-ascii?Q?DKmfS3Pk2TBpyihLgyx5Cj66sXct3Xahm++n2lXYDDACJmAun0ePb443Ky9T?=
 =?us-ascii?Q?b0WdfIsVbjhjIhkg1ldG/g1K0SLgA8zXDdRql3fSsKo63ZATQqCFiiyG9fln?=
 =?us-ascii?Q?04xK5A2m/8Ev6WUQWQobuwbd0sYLNaWcs+xtHQZUZxvbyeNZ6RCmP3MGjPRJ?=
 =?us-ascii?Q?Xgeh35d1vBmOPEeo7bF4ghrwJQnxNnoGhAXpBThqRmhb260un/ta9ZbDM5gb?=
 =?us-ascii?Q?KpCmTUpR40DcYfAsY4we13LaYcATNPhYP8zxKW9XgCHs67pFuFzwC1xvN7TK?=
 =?us-ascii?Q?LvPTpJ9kZBIbJvfpxbcIfu7QRS5BPfL8RrvGHN8quoa3OWMJbcIwA3KySM9I?=
 =?us-ascii?Q?2snA3KriLC88M5URx3MQA9oHFcVVVJ4LBYXX9mVd0CshA0OGoeeVp1RX655z?=
 =?us-ascii?Q?ooWT0vUzCNy7sMZZCUQAYBWQdKpvDcVyBFLcRyam42Wq0cZuD20M5xOv9Yeo?=
 =?us-ascii?Q?DVrplZLDAbobMWONo2Sbqu7dwhw8y8jM+OYb0xWEBsK85Jim5mIpAGzwt0JS?=
 =?us-ascii?Q?N+uh0YJga0zsavOjbUmvBRxOaB1LQ7070Cc7NTT4zVWB4WRSzFOJWF3cYd3Z?=
 =?us-ascii?Q?BHPCVDZs5PqyEKA/0G/EhNB/dXonpL7b7D8D16cm5JZp2vGX4uX3iOk3z/Oo?=
 =?us-ascii?Q?gGE3Ky9HY3XU4gBougj73pdYJZNEAta8G1n/ZQUdYnLVa2CwYvPbQfuNmVqt?=
 =?us-ascii?Q?H6TT46efAC5q3+CZy/6r0k7nikGjmchH/RkyYmn1RBVperDV+QzmepmCsINo?=
 =?us-ascii?Q?wyJtqzXEBdLtE6Uv5pF9rdL978EfDV/y3fE8M+HmSFUCyqGl0j+1pCH96hJ3?=
 =?us-ascii?Q?6Nfh72G/fXoLs5ePMT9x5LIZQZHHqT2YthTBq9MieOtIivES7jQ+9aLHUsJ1?=
 =?us-ascii?Q?2L6WWiPAX66r4rIPmXmFZs+d0TLfuhP7tHTbiXvI+5rtQHW7yxhMQNBXrAE1?=
 =?us-ascii?Q?SUzxdEp2YgRlfZ/lIQLVoXLZXFxYGurqPriISYV3NYd+cH6mJP682tAy4d0u?=
 =?us-ascii?Q?q6IzZXdKW3Yb1BRta7ZoJ2v02N06D3FeeGiSQ8Tsp070lAAWMmmcODG7YviA?=
 =?us-ascii?Q?W8e/pRFEQm7cfq1IvnLPP9gAn2o8zHG1wBI04oOXjuGGMNlD1GJEuEeimJFe?=
 =?us-ascii?Q?GUfHx2MJ6Lco39008au/UN8ZFO+w+hMVVYarb0dUXwATaZWda6VX1jK/DaF9?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: qTeeeibJh+OJdSZ7HQEUS03kv60iXD2dtNSsEkBVBs5oPBpslCCv61b2YC8QccyrqE1yLV56qr82DpyMM4rq/p6ry2hxDFsnxuKJHsJK8XgXeUP3krvAETiejDKaIhVczSvfUDlGQi153WCvDlFTzYcUGODJw8jQ9UuWFqrNhKyh9liXkJBx9zApUXA2tyC/l7IOGTpw/e+aQuSnjWEu/IpmB6dW7ppOQPcj8aQnneTRJJb7Zjq7s1Ex9r5AJ1fYtNXnIWw2b3YfgWYNHITu4LB+D1g/+o4vSU791YYRhsfMWbQAUErIVBcFd1SdGhSOwzo+MziYnc2xRwFOEtKM6MYh9GZ5x0IcbkmyObYxrzdIGK5ui7k5AldcjRL8AxXDU6sZm71jOt11fdYk7ZCnJIT3pE1/7YCEqOIbMkA9fipusFWMBe7CVTWLYmdOCnOr9nF9ZRwvA4RpXYTtC8qXVJijLVVevoAOuGg7KmZHX8C/yVdXAARUDHrEClAv3WBigPshnpt1z+NLISIfdd9j02BVTuRf4RPg/gghFAFSrpE5hPABis6hLleKkRbIfckIrg+n7NgR3hKXhVEaw2guzQxD7maJUG7/zPe31BkUx3iXwjomKP0hOl7UMrOPWgpuCK+KyWINFd5hpsUpzq6A4Wg1kqf+0HkDgU7HIvGxSyZEC4KZxSX0Tc7BN4nJBzSqXp6UyyoPsvaMcX2QpMLQ+UjYeEbQ5pUEnjiCJA+5Q9Y45EAHsof+l3Fd7D8vos1n5R5ZsYSIjIst3+gclIxOewtPQEDiRREKO7KOlLtWLCE87rFNxKpsdHxGRxHhnqmJ8YYOf2iMJbypRHnbMjA8sjClIpFfrj+R4uZ0fC0Kwjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98bf0f7-6fa5-4623-6491-08dba288b263
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 20:53:39.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OP8Q++p6IT2FwTh8jQonUQRpzQLYvzsDOhXidrArrZSc4HUWngOwKGNyPiPqWp0NLEbK7PeIHxVh4bzbPID6bBjOZNANfQYi9NWdVlvuvpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=605
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210194
X-Proofpoint-ORIG-GUID: XRnPLvkgzgXQqmbcuA-xKVFzVQ-it6Ia
X-Proofpoint-GUID: XRnPLvkgzgXQqmbcuA-xKVFzVQ-it6Ia
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> One-element and zero-length arrays are deprecated. So, replace
> one-element array in struct fc_rscn_pl_s with flexible-array member.
>
> This results in no differences in binary output.

Applied to 6.6/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
