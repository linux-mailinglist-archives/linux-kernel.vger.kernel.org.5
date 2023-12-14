Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029E9812657
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbjLNESQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:18:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjLNESO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:18:14 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995A8F4;
        Wed, 13 Dec 2023 20:18:21 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE0SDGr017939;
        Thu, 14 Dec 2023 04:18:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-11-20;
 bh=jj2zXtoyZrR6kmTF/SngfaevzmNGdpl/TGXkYuLi8IA=;
 b=P7YnjLw2auNs26cd7NXM4AiBCM9gp7cBvh/8+z+nBcip0KgLV5buY5akxv7BjbwyIS/b
 ph7Rj90fHkHxrdMAUthAgFy0xnsZCEv0d4WA1LNcbtdgCYqdHBrIjYQkMZoA+XFfBVfY
 UEc0dGlZF0qUg51XnCEUTLurrMXBAc/qw+AFqoOHMT60RH+A6zeXzx97DuTFJMQ1bjFq
 FLfoOozJDQz94eLnP5npOrLnE6rF0otucQYRxqIY+fRdXtjPBvpYc0I/xN5wWijqqF1M
 rNZgRWRV0qZIzCz39t99A0BZVmezepTslnZraOqwC+S72Z1TfO6JkaTeOpzzfgIF10X4 KA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uvgsuhu7m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:18:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE3AvWo003112;
        Thu, 14 Dec 2023 04:18:02 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uvep9dpsu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 04:18:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j5G9jQWYnM3A58Bf5IZFjj95dDqS+bs+tIREnsameXhjtPG15LdQGX+firfuylRjE9X3M5KAcwI8mpeor7npsWSV4y1LCynG/FsUhyN/JIN5BllSQrz72vifTnJvOPwQkHLU5If8ub/vbzi/x/RRdTqTxzv3gzcn4QO02CB4Me+yd6DaAfY2Q+p0/Jt58OpWV/ETrrrMkw9u/KwRR1UR55WyF29W9yAeS3zRckku3iHfe2prYoSxfcjc9jUvLi45mvUuZkG/PQ/BgX+oqDba0RdLM1uUrk8zNdE26h3Ymwmt+rNr8oEKOcC6rb8LG2ZzhPsvbJp3vbGaRPb8s0SLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jj2zXtoyZrR6kmTF/SngfaevzmNGdpl/TGXkYuLi8IA=;
 b=KMe1d8WrD3yFHO1Lm6KwBTAFmdqO8q2/ARgP7tscg1Lm9TJV11sC4RoezLJ7U4pTsKx69JNlJGxszQj5zFsvWZmD0K0zkw32c2zR1fUGkPcN14p0dB3mi2eOLAq1bMEkYgPRrrKno7qEYMmsC39ZGiKFSy0bcC58E0QJgv+l8tWSKHnXaAKRMxMmLCnlrH3EHHGzTzYs39ixnbC2IGv3DwDHK9zN5khvDJjIPyJmSeRbvwdJS4UtMDCkF55ukc6VIuuJ0JcLfheV3vhJSbIwoR0OiF8HVupdh43IoS5iPEHYXSZLxFhu/KeLW4e6K6A786Pjd38oO8HisfOFfJsoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jj2zXtoyZrR6kmTF/SngfaevzmNGdpl/TGXkYuLi8IA=;
 b=x4nYsuY4kD7g+lT1aB/iUVnpNT5kvHs9OJ1Jcgga1xXiL+vYjtm9g1/DJ9gKXGe/QdEhmIxoeOxn9lSFbDnNtnblRz2kmMcQ86UIZg156qqOjAU5Y6Yjte6ATchHIeJ+A4fJmjSDsvYImg9Uhe8hi8KdIC+6tYV0f7YPVGKQ9Bk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4731.namprd10.prod.outlook.com (2603:10b6:806:11e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 04:18:00 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2b0c:62b3:f9a9:5972%4]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 04:18:00 +0000
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     avri.altman@wdc.com, bvanassche@acm.org, alim.akhtar@samsung.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, mani@kernel.org,
        quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        beanhuo@micron.com, thomas@t-8ch.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikebi@micron.com, lporzio@micron.com
Subject: Re: [PATCH v5 0/3] Add UFS RTC support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ttolfmdt.fsf@ca-mkp.ca.oracle.com>
References: <20231212220825.85255-1-beanhuo@iokpp.de>
Date:   Wed, 13 Dec 2023 23:17:58 -0500
In-Reply-To: <20231212220825.85255-1-beanhuo@iokpp.de> (Bean Huo's message of
        "Tue, 12 Dec 2023 23:08:22 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:208:256::13) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA2PR10MB4731:EE_
X-MS-Office365-Filtering-Correlation-Id: a0452906-5751-44e7-d73d-08dbfc5ba879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eYGHtGxVFwT1Wp2r7+7VZwpwKazuFKvApH4Olp45mzkyHjLEdX7oTuJ5cF97C5agT8CvE4ep2Zpnx0fk7WlRnBODh1ql5cH1PiZ6GuJw2jFpp+rYtXsF/ln4oFLDgwWbS9L3n7X0Wd0LHMLu1JmawCWA7NzHnv75sCBcwFTm83q0Ry5Ah5J8To2aV4zrRhIm4Ewi52ch4aDvwCMsuJSPhpSQYMA3rlzXe4alr48JXhVqGunSZtib4sdBbz4hZjIyjzkbBiQqsy2lSYIeun+I/Xzg8BPmHMCeK3sLMd5Er1uq2D+HZDrK4Hu1oH+mkQ26KFg3fsNoTKAOWjHqcl4TeCf/RufAarI8ailxeRRvj9nn+MyjXlDpQyLRxrqbbXvyXi95T3mhvYcaYAiAuyzRxMScCAwX+fgkwNCqU9juU0yAdJlk2SCaNb5fhHpQ4vU313Tz3gStAcMeaD/p0o8KJGPKXu8rUaxA3Z7RsJd2CSIw/5CCSL1NQt1Ew2icLhY+pcR0h6TyixTscrOOruoiRq4uH4S7Q2j+hJFgsZXKf/p+BSv9szFNZGeAF6s7OTf+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(6512007)(6506007)(36916002)(26005)(86362001)(41300700001)(4326008)(8676002)(8936002)(2906002)(558084003)(5660300002)(7416002)(316002)(6916009)(66476007)(66556008)(66946007)(478600001)(6486002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dSYYTIrHkFcF2ydzB3rrY9gd4Cb4wijCjp+RsPxFpca+CGn7bDEiUe7EQwCQ?=
 =?us-ascii?Q?WyJbY0iJQ7f46m7S3FDG6OZSxUfBa+leCmBAI8NmD/NkpEt8CPk9r7E2RREP?=
 =?us-ascii?Q?PiNqf2P0WejXnauz/CeU0yDsPk+ZvduUc7FEUEMj08bt+NuucloJI8Yxsxuk?=
 =?us-ascii?Q?nmM+QS1JWGKvfmqRsjN9E/woqsFSRUw9ekA2e51SR3HqFxRhWtff9z6oq994?=
 =?us-ascii?Q?ogcgXhXsXZTcrt48/GGXIQqcdNGXxwBiItPSDZjxzYK6PJYHyzG/6X7D2kcR?=
 =?us-ascii?Q?HA5iybyrmMDUqoQaNSX2eiVGUQhQdgrs82CO4HXb18mI8fNZ8/n3nL5BIdKr?=
 =?us-ascii?Q?6d/VC5yyHNWowQCOpohgxLoL4BdFtNv2eEZ0aVHedOYiNp8wx3G9l0JeYFTp?=
 =?us-ascii?Q?uqjKHJACBAISsjlsAvnyg42U3+69CxYvuLSnn4YalHws7yubaxaXomzqh/MU?=
 =?us-ascii?Q?lvaxv26CGx83XEe3BVpFkAvAX3LNuH5o93QXsunmb08les9qbuOsdAvlWjJJ?=
 =?us-ascii?Q?soarD4bZnijjljUZFMXkTCacqo+Oq/r/NnqPKgOa/WElJJQ2PurZayMDzFdX?=
 =?us-ascii?Q?AHHHg5A3SiK2fMeWueFp0YaGmBFf6YjNOyqfznHz7oHcox8na/lH1pBM7vfD?=
 =?us-ascii?Q?IfsyOUr0AjiqO48wRPfosRBAn9TNWQ+stRLuoJZiPJBZh9I/F+y39KWSc3qF?=
 =?us-ascii?Q?fuv/nOZ7x4wl6Q6csvSwi2E3sHE3UOzfmmergELs3hfoKasMztT8f+4X3bkQ?=
 =?us-ascii?Q?2e3T4n+Eyp1Cp3VZ5f/9dHXfwOEt6WdC/AVG7IqDxOn9U+VGUiDv3/qZMBMy?=
 =?us-ascii?Q?rUwfpS38WwLK6tnL3jPSm5xUHDRMwpS23PJ1cmhzuGraMgt3zkCPri/iW7ef?=
 =?us-ascii?Q?9tAtTHRvTJK5w4++B4EawXb8tp3USHlHNL3x/K6OZtfF3lk9O3jLRbPbvxLk?=
 =?us-ascii?Q?GjQGh3z1wA1Y7tB8hSB/5TX9IHhkArhAnGiEEsXIhTtigm4zix7U2n8GOVi9?=
 =?us-ascii?Q?SdTFhPqo38NQb6AJI8M0d2B3Jx84zP+0/Fz/sOMQz7kUBg/vSn0QYlp2rZli?=
 =?us-ascii?Q?ZVNkrOU6JDj0H0seYcDKylbjsExstuXhv7/46yK4Rln04o+V/uWvv1d3dYrD?=
 =?us-ascii?Q?w0ipQFZfjwYZ7fLGRutPyYkSkqmvdOfm8R9wiyoseUrjzwMV0DMBp27be2Ex?=
 =?us-ascii?Q?Mv6REzNR26bWAJleFajdZfG7wDbzfjLBG9QNgMA9BsjCTsFs63KxXVRdKwj8?=
 =?us-ascii?Q?uN67Jetl7ll5Fu1FQCgx4QdwZm2xF/WxcPYTX+Z3NnNxU0NUH+E2xaMBilfd?=
 =?us-ascii?Q?vX9asMzTx3rlK4IjmW+bhALYpvYZi8AaNlK8iOrkaqQnOTnixXuKzoetJ7m5?=
 =?us-ascii?Q?wztHNuGBrkO/ZaFibqsDTDAmrEXPqyOCi04F2ZKk9GrSpC2ZsqApH/O+ZF21?=
 =?us-ascii?Q?AsBv969V2tRfMoqDVM5hwXMnIAsuzv1/hHAOBirLotN96IaejQi5xlzEv4j6?=
 =?us-ascii?Q?nJCG0zvdlpaiP80B2lOy9agxpWvJxKMg00LslFqJpSI19IWVaa5f0KgN06te?=
 =?us-ascii?Q?zJYXjZX1KIm/JvJ4QX861vq9GtbcWr4Py0/8t71r1iTdsdTHNxOW5t04ehAZ?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xjijw8PT5waexssn+oCHi9RHTjGjaWb0TcTObfV2So0BmGJrow3y7NuSgZGGD7wTD/+OepFgkGwlzDFUY2sQnbj7KKOrbTffn65GKG+e9ZcJ7gJNN8M0FjNUnN8rSJABtQRdBiZpCPGpDu2KtA5zYzl9NR0PE+x9dOjbC5vsgeTk+FDnx3kb6872LMHbDGPEx47882B81jH047uWqNdLJUF3uCQ0Kl1m8L3gC4S+cvHcDsnCwa9RYaMR4Md+vvfF+EWpHR8aDcj9BIJD8NkXYxUDeh11ioa1p+POk+0gFy5h2gmjqqCqmZKsxh4lZjYE8ObFXaDe1+i/W5Oppt1H1mTagN4aTVMMjgxFHCtGvCHI6hc3fm7TJbTEsq79rz9YkhXkvRxxl/FK77KTCdIcznYf3A9n5l0OqcIE3VHgBdDiyUFhGoWZ09x61BgavtjeMLIFz+GSMf3/DbLxT8H5QA2vh2eo4bw/ps4zlOghElXpMd8C/M67cjmV5RkwqtVxdx9E2thvtY+39iRTlf2pkgOZhAGPlvXlY1uYpGaKnoN5Wq9yS5hzSJXB5TWaq3B8ELJyk1f6CLW4DVsgP24ob9GaNhRV/uD/i1X3aVQvnTY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0452906-5751-44e7-d73d-08dbfc5ba879
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 04:18:00.3152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4NNetxD40ifqnew1Os10xVw22eX0QA8U/9AVJPe2xifc9gt3hEDwn2j3N6ltyi8uA7n1IcnF7sFoZMiwG84Kk4k6es8olUyY1yw6vZMHlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4731
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_01,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=856 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312140023
X-Proofpoint-ORIG-GUID: ch7HqMeNXAvICJs8XN536eLN-xHDtD2M
X-Proofpoint-GUID: ch7HqMeNXAvICJs8XN536eLN-xHDtD2M
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean,

> Adding RTC support for embedded storage device UFS in its driver, it
> is important for a few key reasons:

Applied to 6.8/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
