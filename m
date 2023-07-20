Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4A475A496
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 04:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGTC6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 22:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGTC6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 22:58:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DD8172A;
        Wed, 19 Jul 2023 19:58:49 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K26nXg022403;
        Thu, 20 Jul 2023 02:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=XV7g18B9hzlXj3dhc6SG7LApKa1v4UFOSjaK6NSUxB4=;
 b=ocUuXa5HLhOBqEQKVSFM6CZIg3pDskJnYMOenorVkH3ihLxHm4damiy6gMOORqaLhKrh
 aIb0uFh9ZVmk0QaUGWNY9/Ki7jDZU6v27bcI9r9SDHCS6tfV7GaI21LI29Jn3UGfKYTv
 7C0tDf00H++jIVDgSWfaJKO1PeKlIacmnZ3HB3Wo1BTj+A6lUBW9yUDJKIiuuvtxPOfN
 XAzhOb889eC4/rPR4yNBTf2FQ8y6xnkjgj9kcmuTu1L0qjMmroQWImYEGQ9B+5o54lwA
 ejh9JSI62FZSBaZsaQ/YEoLojoS+HfLCGe4KvbiuOfEZnqRqc5ra3+VTXuftcp3dReU6 Ig== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a0v41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 02:58:45 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K1V0lV017383;
        Thu, 20 Jul 2023 02:58:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7ur7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 02:58:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jAtz+8CYjrM1m/o5hGuaIrzaermwXC0qO8/DUHohSH/cMMgInrhMvqasXBdKJVGBpwroMGRYXgj3Gv6TaiLA1MBm4LQ6vqphmeeDxlTVBpgyfPK8lX/hVxzitSlA7C4Yez2I4t3sRYJVsiOs5J42NT8G9YPO+XidP8kwP0iR/+5m5a6BboWkUUP5iKXRanjQRHSOctovcOS1IDspiL8vUNTqhKNX5UbzlnYGVjMzxt8sy1l6PXd5KHaHLMzBZX8a634bpUb53phyTnKspUR9bmVN3QRIMQcOdadj0kk30YClSz2ZxWRtiqmuZIQW5ON0QIjaNB03cDEM4pvSEGqIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XV7g18B9hzlXj3dhc6SG7LApKa1v4UFOSjaK6NSUxB4=;
 b=Y9fZzfJY4KY77SglrFuyGq9x/t6fwuqmhOPt2KWgoadqhNDb4mAzK904si0J6jmVBCCAz0RbQd68sEB9Mygodnhz/vhMwN9WZYdiWw5XrZu2C0MZIpkYphnt5l77WvWyP6RV6S7EsRk86MHHtggQXkIGy5iDcrC6Y+ilhRhAZfIr7V+oO5V5EOxJZHzt/xcijCl6TpQPSNn/KwQhf3XqoVdHCflO/FEqSPqPhshDEWbCPXunxHW5woX+s2c3MhZJ9sFWlHR8aumu6JCd7k0mRfIMNgpscsLD7phWsqL31Jquqn9Bacf3ggZ1aH9l4k5mVyl6pC78ZPDU1qgfFXDmbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XV7g18B9hzlXj3dhc6SG7LApKa1v4UFOSjaK6NSUxB4=;
 b=O004pYWI1JDwXVbdF9VTL49rdwp9q5WfEiv2dXwjCM1fhaC8d4QrD+CQHCW8uEZF126yOXBdSBAev+hwoM6mAh5zN/tzpmZgWa9Bhfgbv4K1jrxeAU9hN12JTZjwZlMKO8Mr7xFWSAgvLDqZwItq1qXcAXXEbQChYLAGxcAPARw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS0PR10MB7407.namprd10.prod.outlook.com (2603:10b6:8:15c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 02:58:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2399:36c:d38:af63]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2399:36c:d38:af63%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 02:58:20 +0000
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     Jens Axboe <axboe@kernel.dk>, martin.petersen@oracle.com,
        gost.dev@samsung.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: refactor to use helper
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14jlz8f37.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230719121928epcas5p3c2af8016b8ffd5d4cb53238a5528eec8@epcas5p3.samsung.com>
        <20230719121608.32105-1-nj.shetty@samsung.com>
Date:   Wed, 19 Jul 2023 22:58:17 -0400
In-Reply-To: <20230719121608.32105-1-nj.shetty@samsung.com> (Nitesh Shetty's
        message of "Wed, 19 Jul 2023 17:46:08 +0530")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0040.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS0PR10MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4e61b4-f40a-4f5d-10c8-08db88cd2c92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rv/C5UNJ0qXm11PE2rkgWdw/I0tCBnE71FiuPoOgVTf9xo7w6L7WyI8bobVDICbSgaaDhZs9LDWiy7D7bWP78g0eCY3dfz+S6IAPBYV2DywGYtp4SctY8s3Q7vWSDivC1awd9r8VAuvcTLhqdlVki4C2awD6UkmoUvnH5i6w/8GsAOQcwAKsFWLbUqL4JXEv/84R8LftkGZNF9mWqMGC6TG8CSsSlVURkyuxWt+Wv/FJF/Ic1YeY0ENpIuzkgJaR/PrEtbPkO5mpZrpD4Zsgua3TN+tyISKrY6HMySpM2b6w4AyNcdq514eywpSZphx4Xh+V8l839CXpgRwMEjKneLBbkdTbjaDemGDczcgSwkL4nygbWu3HSf7mSRZ/jBr67t8MpBqINuFQb1bl82Mv5DV5jgvPt7rU5f9w6UVwzNeinzc5oxkW6vXqnmYhUNPScEnmvFT6+N8uhul+a2/msuDNW8BA0ze3ec9R+hkz315MvxV6cR+m1q+odohYAQBJfr2pV7pXylbBdWurcisaKQ4Yqn245Ypz4WNZf2iNAAoWWY+3g4yVb91qnO47lTUi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199021)(316002)(4326008)(86362001)(478600001)(6666004)(6512007)(6486002)(36916002)(66476007)(66556008)(6916009)(66946007)(6506007)(41300700001)(186003)(5660300002)(38100700002)(26005)(8676002)(8936002)(558084003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aQsTk68BcLrpo/st1u0InAyOLD+HPwe+dC0XPz2Hg+LYTtoecX6GMttMl+IJ?=
 =?us-ascii?Q?HRpKP7BYvOFgU0cqA80jkQkT2Ose1AHG6lL6ghYwSnLJ10KcevldtSFD1GIR?=
 =?us-ascii?Q?Z66e9+c6n+UjLa7NRlcXPrXpk4SEN8MQyWDvpXGjYGkKWLR3lasIFqk8BAYe?=
 =?us-ascii?Q?PGQxFD7528/BAllVGhN08d90GJXyAF8kb5iuy2VQaivDbM7vSaAYcLn7gua3?=
 =?us-ascii?Q?xHc1fwTHYWDZLxzcRG0WS9PSlHlZsGrfZIFEupc8/cQ7S/TqElR82PzCXzEu?=
 =?us-ascii?Q?wBWNIwKQvYzG6VQ+468CYzvGlkzxh8UiUa3NAFDfV0BlVfkd+aC5xGUa8Leg?=
 =?us-ascii?Q?59hvWopXNPNV7dXbfVBzYj87ZcAgKOmxbzLDCEElyqbOrP5iSY34uck9s3Bo?=
 =?us-ascii?Q?NGH33Z2HOPZs1aEBoobEOWZQGOpkZWkvtWhBFC/UVMvi1x1q5l0LoLSBWtDB?=
 =?us-ascii?Q?hhNeFyiLNk6HjL6KPEOnSubkq4vnBzVOsDZuRNBoIgSOwNbORkUiOwBbndLG?=
 =?us-ascii?Q?PT6amF3ZfdTvtOv8yjho4f7O7v0lD1vF1NJ3YmcTPS0FqqY8B2XXt7G7kOp6?=
 =?us-ascii?Q?QVkh2GK8mPR/rA1A/erGrzpgbFlBI4Z35wx86JWtvDQAKWo3Vn1OAzaYtNpH?=
 =?us-ascii?Q?1UUTvJz3BtsW7LVoXaJ0KMgVrsshheLz5Cp18cfxMz5TgcrJW1o+jBpy+wiG?=
 =?us-ascii?Q?+hh/eEsAo2Pz5jGf+7WHMiZ04vAuQ9lQEsS8QoF304bfCtlocbccdhlnLYZJ?=
 =?us-ascii?Q?Ltwk8AvAUfrIO13nosb7PMYSvKhrtKRAYsGSGHS01S+bpo9/mQmc/xDX8T93?=
 =?us-ascii?Q?FnH6TufdPm7Vyoe6bU6rHZ2JrKA4hpn65da4DzeCVh5EqKqUX9ps3OyufGE/?=
 =?us-ascii?Q?ckO9jWwjR+Gzhw2ize+x88OJGtqYUiD5i5MACOuBu4tFB7vIHJrYiIcJEBTX?=
 =?us-ascii?Q?B69pPDozyv343VOxf6+jO3jjeJYOak7cS3Itfdxn28jNxQ6G6lTZP8kaFU/R?=
 =?us-ascii?Q?gy8zDTIyNRknc+FSXvuka0FSIOZSvVbFDLu92qM84YuTcbFgjdvkp6LEeQzv?=
 =?us-ascii?Q?lak2q7rgowfusm92pwa9ebGPGg04VBvKUA/g09GcyTgHJmuWICupQpI70GNl?=
 =?us-ascii?Q?ArGf5MRUYKc77N57FmGHGQbWyq2obANT1647gm6e07O501bBsv5D22Tn/+0z?=
 =?us-ascii?Q?YFUD0Ag7cX/FL20UlJsRzB1rDwmkTT6Nqq6jxiolSYUoR9kJwyUWLyQovbGr?=
 =?us-ascii?Q?C0wTX/E9XHankoUMX1BudpWWcqEIoEQt0EkUSjf30oTSrHo8guOl6LSCXqKU?=
 =?us-ascii?Q?IbAZBhEhdbH9j4hjbak5hWpMC4DoOm7rETuLZ8hkvSb4Wa+euAjlmEdIT7m9?=
 =?us-ascii?Q?Mp+fM6FeK49MpGtaT+f8PTsCodhUg5+haHVDOvcHM7xzYKhnkg8YWPTGVovL?=
 =?us-ascii?Q?yAKX8JjrAtttGQV/CpogVvtGhppPDL/4CXrS1ttQHyLGLaA/+M1UifEytpPG?=
 =?us-ascii?Q?jlDKEN3+yA9Kj5U1oX/cukqk3idyBXlqND6bXbqkVn/139UhzOo0Qt6tK41T?=
 =?us-ascii?Q?kpqSchEbMRv4W+SCLzCuxl5wN2ZqS1FuB4FBbJ5TFvb2J4eacRnhDZ1M1UM9?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2/Df8eC9/+fcHksNPvPtgFxjwe8ymYC9rOIsQjwnG4BVzq3OJS3cHZ5IXlwzg3ZQs1X+g/ZSI5HRMIuO1qp8p17z4U9b7pFPDX69Mk+J35W/Sb7pV3RxSLJoeP57k3ERmRJBHVUxRG5zAHpvRNvx/+ndMh5BHNDpm1zEsKSIdqkKnKewYdDAJ8c0NGru7FG+q4GnHA8dLN5LUZEtGKEXzP3GmV2nbbo9wsj7byd2KUn2aDKNLeSyR/QkXCltgOjRtcSDphThBYjOUXNQip/kRnO//9yMb1ExxdIVNgD/B7EzXht355zwxXCsYHvcYS9Ev5Oq87ur6vviMoKeUrr+L4bS2AnLR8d5kxBmDF4Iymlujw0ZsF55DSJYrT9lv5VLyrT+ygg3o5dMCZXyjhyOFMiuL7YxSFIR2LkoKTXGCW9e7PtCDVWIKMjI+nwQ2Q8s6Mvy33gmkuagXYH2wEJxDghv/p023tMg+2YUraWO9guFUuMt7O/ZqGTeYqcs+GyvWpxhkB97XCnwBDncWhFNG0jSP4f0tHBDYYrdBrMR6mgeOanmQm0EMQHSGyiohdYc9X2mG72k9gzt4ezeACPVpyDfWxRygyjHEMaXYuHco/tlD5dAkcjNu5O5LXgUJbmwtDuR1Jc6XIRp6aTBkuN/L5f3mdQ0iwXjVznBg5IeM95CFqfn73VsE7+hiqf750WCIFLdVbgpeovbpfs7NV7Hq5bM5ujItlVQOWdqHmv8LuUf04cadMplUmOBiUIXUURM2J1lMX0wFEzpB17qfYDd0CmyicLjEC96VpKcvJogCLD6XnacoZeG1XZc23rz8lfx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4e61b4-f40a-4f5d-10c8-08db88cd2c92
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 02:58:20.1485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtNnF/87JHQZfMrhINN7CTXhfhgSQSNe46tHV+6/JVDGlT1SaXjuxehuHgGhEI0a6x2lyySfJqf/8YNee48/9UoGLZS/GVbVpkZXdczHduE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=832
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200022
X-Proofpoint-ORIG-GUID: 1ZLZ8IUF4_Dt-phDqKsyZBheyqn8SI5O
X-Proofpoint-GUID: 1ZLZ8IUF4_Dt-phDqKsyZBheyqn8SI5O
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Nitesh,

> Reduce some code by making use of bio_integrity_bytes().

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
