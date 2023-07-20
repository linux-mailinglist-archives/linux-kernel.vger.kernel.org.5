Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2529375A4AD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjGTDOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGTDO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:14:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482141FD8;
        Wed, 19 Jul 2023 20:14:22 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36K13ZwW029562;
        Thu, 20 Jul 2023 03:13:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=ma/apaptZaPIS1gO7xzt3VunE4jzQerH4My17l9O1io=;
 b=adOngVyKa212A3VRPkAzYIkI0jv2xZItJ7tQWuXVk6gPzHs4LkXY0VZnygCrS9v76ayh
 gFdCkvskQZgr5BNSJ7OMUVFuhLrDqKhJqSXuqykK02OsPjQSgFrP3bTU5nNUjVq67k4u
 q8IdcP42BjYz4JSeePhssZtp4YHCi6r3TZhtJXxy8ew3WJ3irsTE3aAKU3NNNCjMbUUS
 WiItCfb1kJHwRdigzgyAPXUFN+lrh8Ak9q90RXK0zVcEu0i6jGzCbLK2nVQUMrd+rLW5
 yrtfU7KVm5b1GGhus2xZNME1AwLaZpEH2JUgPrPXo64748p4MiiX9RfCLXhG7meII4aY tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run88rw34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 03:13:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36K3C3M4007769;
        Thu, 20 Jul 2023 03:13:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw7nweg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jul 2023 03:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E+VjdjNS83fSVxFCQr8Gl9esyeHPLJ666iYNnDxUxOSrcl52ADEzI3RaKaFYELPxQfLl5TXXXehznjG9X9Ax+eb/eoxQcoV8twmeYIsh+v0FwAuHZR5eJKQ/DYdMGUvw/YJTPur8eE+Cs+1KBRvTvuBl0mPS0YYqjRruEHJwejSoIPv2imhbOjE6hbByOY/ZAQwJIfVi0NIdq8fgywkFUz6dmj9SfIUU8Jnm3TM1tF1YqmyWfdUI72Vnx0CApR1MfuxvNECNXDDxTCZKGPnwrWk8eADfnmEzj8bJTK1/XeDITZLb+/UT4hdBO4HJyA4QxbIld39h21cBFcGEE0feKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma/apaptZaPIS1gO7xzt3VunE4jzQerH4My17l9O1io=;
 b=ISt9bpin5DZkHlcIqB03o2Xm2NLx8tzFMUAHeV2iAvcESCLOg0PAWMT/ExxuLOx0c6EWzUBdE+g6Ph/moBW2103PqwnWuIiBvWbvxm7ZSUeNclLtmRrI/dT8naeFGRq4PqCJzrYla72mYrBMUIhvW9hZZMjHS3ea+nkmBLJiyX90UVsGbwvIkZ7MOakdUKhFtTCbKb4XJUVF3e6pQQrxaIdqt474DxdMNp8JZAPZtVrP/+n2yiRqjZ4fAI2/n3XK5jqHHfkqzqqquLUC9ggUE2yArSYkhCWGdhI731J6jcdzK/AIXsZ7iIWvMFM6WO5BHLjT6ZhloLPO7FYwrma1Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma/apaptZaPIS1gO7xzt3VunE4jzQerH4My17l9O1io=;
 b=GfPTJ/LYNdbv7vFT/p/B9YXa3w2ysUa1hsjYXN54BcE9vfpO9H3D8enazHWKCiEHztYW7CWBCixny5JpORt4nQBvyz83e2byPthNi/BkBYJD2i+hcYDcEILCuNz75+7Gwa6yuZ21Gd2p/NHQwJeekf3Dir7Ee2pxOperkEnjctI=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6615.namprd10.prod.outlook.com (2603:10b6:806:2b8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 03:13:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2399:36c:d38:af63]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::2399:36c:d38:af63%4]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 03:13:50 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Yu Kuai <yukuai1@huaweicloud.com>, mhartmay@linux.ibm.com,
        bblock@linux.ibm.com, bvanassche@acm.org, hch@lst.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi/sg: fix checking return value of blk_get_queue()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sf9j6ztm.fsf@ca-mkp.ca.oracle.com>
References: <20230705024001.177585-1-yukuai1@huaweicloud.com>
        <d112d30e-d144-4c76-db98-5de4767f5945@huaweicloud.com>
        <ac099071-a16d-46a4-a1b1-2cc786a0a337@kernel.dk>
Date:   Wed, 19 Jul 2023 23:13:44 -0400
In-Reply-To: <ac099071-a16d-46a4-a1b1-2cc786a0a337@kernel.dk> (Jens Axboe's
        message of "Wed, 19 Jul 2023 10:34:11 -0600")
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0018.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6615:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ddcec67-95c6-4ec5-e232-08db88cf56d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yq3Gx5Qlr+vceiNMHl1TutgUlOYEtkW85YgDMVoLvl7+O1/cUvMpo9RXO6N2NuDFcZGiMHwRKZVyYAw8SqnoW0D/WKOJbaYAq8zXoy8sToF3Yg2i4PgvSUD67adjj2mZvQTptwWZHYSBo37zdJ0EcdK4V8JehzmWgGd1vqqdrDdbA0uegmJp7oKHRZrJSnPzIAhPGnjw5WjTEf3/WH8Wskzaxc47mXzJdmXfrBvJfRX3FZU9sVWVu/gMwfTCLdEZx+mjYEbl3Qjx4LwpR+C90Zcqj8+GjMBJdNRYHg7UEn0dOcYvhXUseWWuNUY6lSdrWuF0vzM7X1j8yM1VuO1rlsPacN/KtWdnBHQtgjN58GrDGYI1+Rr9xxwi0AvaQnBOXtyAbF2EV+5Po5ObSkSWwGiWGuV+YmUOmXs/hV5kmN9+e94TQMGwT5/cweLMMfAG/BSa4EFGaKgv4JiJEq9MBEUDhj0SW1GEc91RzbB2KMCLO99ySkzkS7XfSR2HRuZUgvdKoa2vVjjumiadR5FrI+pfi0Q5Jqxc+DWLZY7UEuEhSwRgUHJnuikOX4qIbU8R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199021)(6916009)(4326008)(8936002)(8676002)(54906003)(66556008)(41300700001)(66476007)(316002)(66946007)(5660300002)(36916002)(2906002)(4744005)(38100700002)(26005)(478600001)(6512007)(6486002)(6666004)(107886003)(6506007)(186003)(86362001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z/+/xcPaKVDtXYgTMnXndJcyJj8MG84WDJ/Ll0xvNQAwm9z4efTZ+IYxQZMP?=
 =?us-ascii?Q?Lhxhdshvm7HCqymAYn3lGPGhFzhYEh3Cyi5GRF5m7Ooala/6SPvaAQ6zm0bV?=
 =?us-ascii?Q?q1eWCiaDIiv0VPbucCBtP8cGZ7KBziyx5LWeBDjKPLY0OtBqwtGPzKQTbXA1?=
 =?us-ascii?Q?265tN+ATbq3I3W5+R1PlE0VjtIDgbsEcu7UhAIbP7xom0Jodgnu1uVbNmC1H?=
 =?us-ascii?Q?nIe6KwC1r4FyE5iFgxe2GPqdnM2kSkgk5qkWYF3z7ITr6ujPt5cUlH84cOAF?=
 =?us-ascii?Q?+HSdiFMBCLCwkYZ0tqHGoXkh+pGf6cOoWvhdDJzQtUuQRV8SQ72XnG0igPr6?=
 =?us-ascii?Q?wYpk/1N4/6AKz3MUJ2NWCpTIbg3YWM8XuX2gQDFJXfIsScOyapeFrl1v290L?=
 =?us-ascii?Q?uFGtp68jlec+VuGSarUVeQrbA/fjGQp5bXeHIxymMhBMeOYkmmLm0nXnO/RA?=
 =?us-ascii?Q?nVPvtFGxCEiOkOOSXRQaEndLj4agRMqxZuMbTkFG9wB9wSaahtLYCDngQIkQ?=
 =?us-ascii?Q?Cdyb9oBwbZGbKyYxVCTud+V7y1Utc6w8G60Bp5zYPHFpR6aeqjYWOaNYFEzr?=
 =?us-ascii?Q?O8KdlqRSYx/37/X3ThdZIPRGVuc7q4rwYbdfNjwhA6/2EltEH66T2pEE19hY?=
 =?us-ascii?Q?1qFViMrvKMg3vot4gz1vHA/WdgTs+fdObdkgDLga0OIikOE3ki/XIcylqvS9?=
 =?us-ascii?Q?iltLBN8E4gZXDWpWeqwWkuU6QF3dw27gPO7qirztaY7dy4avgfbyDC2wHiBo?=
 =?us-ascii?Q?BppohXZ5MM7zxvEZgGLK2y3BkjodtJWFneqB8rQzMfUVRp8HydGKpzpmxkMr?=
 =?us-ascii?Q?wVbuj4so2RNE09XnrJqOO1D0X325V7sp62SOberlS1UhBPiRGXjTtnWZmpdq?=
 =?us-ascii?Q?r/P7p11j0+PYyozJmUh03HFfqdgnSgGlkGB5W+WgeFJH6OE6+R0M3f42t3K7?=
 =?us-ascii?Q?WyvMNg1qSUtFlNMLzJuqKEO/t0sixILwbZC1x47lz6u3q95ycdgJJOU1+zHf?=
 =?us-ascii?Q?kqgY+qZFI9tZ1/vI/PtCrIwy3cqyLz3bdzIZKSn24RriEmDXLmWT2MJYXjOV?=
 =?us-ascii?Q?LQxzaGjiDxXIgeERokGvw0op4b4tX38Ir6Zt9rBfHUaQwufXURH6bSbNLG1w?=
 =?us-ascii?Q?Sxy8OoATNApOup1orEspe8MbYMZAg1YbKsl2oBwcnnXZOjL/E1PON/0O8Fgq?=
 =?us-ascii?Q?zY098DQOMiUVj3wq73ZbQggerS+WfeVBuaXc+ZShhlNlP1wVY7Yrdo3hl6db?=
 =?us-ascii?Q?+Gxr5VLF7UzPStYZGQTNXdyzMjphDY1se7NqdVV0B2/PiPtkWsEOgeKWbH7h?=
 =?us-ascii?Q?mw4ClxwAR4UinYM+Qgk/2N8AQK+oCNv6quRVwF+kqQUGh6WcJ3V9jmA2Xgxn?=
 =?us-ascii?Q?P2lLrBveL7HIMDtRWjMM3bM5DpmeoITFcIcfx2El/8aVGHyeaghQ3B0LRT4p?=
 =?us-ascii?Q?lH8UAepyjwj9MvY2gNOm5TvRw3txYjOOxvsyQExErZm3m594iBfar4LkpgKf?=
 =?us-ascii?Q?LpD1cDrr9o3xqKrHzkxpXnWOBgJQdpMByAvsbccipRoKIX2i5/oA7xaw8UFm?=
 =?us-ascii?Q?NyTVaUNcoamd+fSQ8NjNdjGCRxt5MneZkkVvKRIMCf/YhfW3uGi45omdlI2u?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SUhg2yhuTDLrabB7m03+Gyiovazw4s5K+J87CtdBCIMQxeinPWm/yeaJvG1L?=
 =?us-ascii?Q?2jmQ8m6V6mcQV+dkGmIqc6uo1Hrk+gN8FC1bjQnQkcElLcxIAUwf/IafRncX?=
 =?us-ascii?Q?0XtkMET5LZOydVWV4vX889tmJAU7CvgfgZcBsOiiM6iTmcWzDL+szTv+woqm?=
 =?us-ascii?Q?3YfHwYYxZ+Y7jnZFvz3CbYOaQx5djkuuKOpgvvN3uOtXZ8zI0sYgj3KpIOHG?=
 =?us-ascii?Q?nWr9PIhjlcf1iiLy11LrgFLeO8HgtPVYgPQK6USQFjKONv2rbwc1kJA4DVZc?=
 =?us-ascii?Q?5Bpg/UuT+lZzjZUncmke+SXqP+ejoi8CfgcYhgqxAYV/q9zBAP8hydgQ/+Lg?=
 =?us-ascii?Q?r0cjsbmfjyrUXbznwLxSmKtZeNSen7r/hmjnbBR1DLOlRUoHfF4ZKnEkUk2/?=
 =?us-ascii?Q?RHrXtlE7U5y8cd7JEB5kHOXcvL04FcViaBv0+LGGe8OF2pHsGkVGefc6IV/n?=
 =?us-ascii?Q?j1TyhgajAhAN71gHBsm0KIAknuSehHXBSm+8AByGmS0H66MoE7l0BidY+Mlu?=
 =?us-ascii?Q?tkLrbAApCbXo1efQiOJPNDAbMuduZX9MRnm61lVQE5UBvNcP4Pjt+85Z7BvE?=
 =?us-ascii?Q?zCoAuUNmHNPnfNdxnIf+WAytF2YZU11ub9n6ezJtphSGl1cQEKPPXT5/y2G2?=
 =?us-ascii?Q?ax1aKg/hn5764jAJza0XXPC9PZhrb90hp5BTFzkVJhVjpr5Pt4uwMy9yWGH9?=
 =?us-ascii?Q?XLfLq8OudURgRoDISzXQLf6crMkt68wsDMVKTqObUJV+rUiXJQNBzSs27Gxg?=
 =?us-ascii?Q?z349sy6fss+N90dky26CZxF82s9KsqPf1Ovdq91ZH4FM0sJlotoZtkzoVdjt?=
 =?us-ascii?Q?SqDfHSTHYWQn15ucopr8TBrk0E8AfMcsmshLdWzrLajBjhbJOclswqHwHVDN?=
 =?us-ascii?Q?83gG6SgaNxA/fYeUohM6u4bjti0l0xDmzitoZ0fPaywk8BwcwV6gGQiIQ6WO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ddcec67-95c6-4ec5-e232-08db88cf56d9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 03:13:50.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k27ZVOtVf3Cve50TJgLxJMZVd8RBLk8ltzUKYqqGyNCMh+Nuzpu27rPYz3mhGWhwVsAY+BjCWzUtuUZcfNWEK84RIEJ0/M19FHD89+EIxt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_16,2023-07-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=764
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200024
X-Proofpoint-GUID: pS8t8X797ekAYYVZhIfMhFFWAxL5-Xh0
X-Proofpoint-ORIG-GUID: pS8t8X797ekAYYVZhIfMhFFWAxL5-Xh0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jens,

>> Sorry about the trouble... Can you apply this patch? I notice that the
>> original patch is applied to stable.
>
> I can, I had assumed that Martin would pick it up on the SCSI side?

Ah, but since the offending commit went through block I didn't have it
in SCSI until I set up the new trees. Now applied to 6.5/scsi-fixes.

-- 
Martin K. Petersen	Oracle Linux Engineering
