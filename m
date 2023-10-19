Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CB37CEE26
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 04:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjJSCjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 22:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSCjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 22:39:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE795
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 19:39:11 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IIp3Nu022429;
        Thu, 19 Oct 2023 02:38:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=0ogp4D57N72W8/Md32CLSg517hv05t8SlnZejEovlf8=;
 b=yPAD1hr2RllZVX0DKjwUF3PVBX1tNW6vvm1ptFou5+d5ivf3PdZJdEqb/3fwriy8rXwN
 OaXYCw+GL3tp0Ii+BrasOoAt4dt0KVleiVGoIJo5mOghT75OslxDlKTdaOmwYwCn/0Nt
 SBE9g2UsLZ2TfyLjcrIvwNQftsCNZNCNCNVhc5gIPe0R4d6CLxBn7l498LgeN59kSKpj
 rhJoP+1gZ/KiDivNJraYcJ9Qev+g0kwzZbQKFxiPeYMVTT6O8UJ4ewhLW7DXtZxbjA4s
 MtuEqNOLEwt4Mw1XrG6UVjW+04UBHzrd7Yoft+32eEdRHvndgZUzM2v+vJXb+EyY/OAl bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28saty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:38:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39J1Y92k040443;
        Thu, 19 Oct 2023 02:38:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3trfypk2dd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Oct 2023 02:38:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBkUYCgPL5cXO1PrIv9MhLDHCwXORQhaEHs67DVU1XLdkE6KPPZRPZ+ii1qOpRntqqW+QQ9UOR78pZpUpiBG+thDaIKhu/HN4GwjDt8SAeHU3fqEHVJJqDfVVdhST5r1Luf44Omx6OkxA6aUbHEnAZZgwU46ryEnjyuYHXI4SPNRfcebPdnvnrd78Gb4TcYxyBORZ4oHVdAa4MTJS7ZbfqSqNPCGRa7K4/7a3v4cliF651LcIZMZQZs7dCaTZ5Ns+Hnufw22KHYONmueA4jKu6wiJsfBxHiWsh5tSOqEovhU0EIlO1sgV2WMEo9e62d25zkIsM6nmsYtNQBFXwtr0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ogp4D57N72W8/Md32CLSg517hv05t8SlnZejEovlf8=;
 b=SLBpTsvA3K4ZFSZGJtxH03b2GysAHa1xBruPW4vbkgFjcmDC0OharVFGce3jW8BSpnc1JxZZwIkoIZB7i5V42Y28TZIVzVsJsatZgvfp5devTQRrVh5nPW0lNP4s8YKzfM2hDfxnrWkxm9P0KsagUypgdlYrB+1h4D7mkKVOcMEVQsvte7H1ZVCm/Cy1yIoxVAjN2879Sqfk6F/sR+ShjuKtCaHDf5BvNQ34LBafdQnj6CL/hCPkDQl62XsZvblR07ToAl56GHKOae6SZurwf73FLoXKwRc7qO9959kIJJCVLbOh3lvDohbWXKIo6gh8t14yTA5CJNJJ2kqKdcdedA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ogp4D57N72W8/Md32CLSg517hv05t8SlnZejEovlf8=;
 b=jSa95RDJ4qrBTF0l+7yXV1tS68QlcKBZ9Rlf5s0XA0OPlM861/reOHtr3g/JVl49BVknaIewBd3DFunQOtXZ5glTfnIgfiYUn7+fZMfpIGkjgqJEX9PdHGQqsOGD3ZvCRbJFFU2clR/cLQ14wUAJGju6CHd41JwjgnVS3odnQTQ=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4406.namprd10.prod.outlook.com (2603:10b6:510:34::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 19 Oct
 2023 02:38:43 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::59f7:ec45:eb41:d8c2%6]) with mapi id 15.20.6863.032; Thu, 19 Oct 2023
 02:38:43 +0000
Date:   Wed, 18 Oct 2023 19:38:40 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        muchun.song@linux.dev, songmuchun@bytedance.com,
        fam.zheng@bytedance.com, liangma@liangbit.com,
        punit.agrawal@bytedance.com
Subject: Re: [PATCH] mm: hugetlb: Only prep and add allocated folios for
 non-gigantic pages
Message-ID: <20231019023840.GA345531@monkey>
References: <20231009145605.2150897-1-usama.arif@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009145605.2150897-1-usama.arif@bytedance.com>
X-ClientProxiedBy: MW4PR04CA0262.namprd04.prod.outlook.com
 (2603:10b6:303:88::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 21cb2032-49c6-4337-d9ec-08dbd04c82c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TtPtheFpxFiSiL7yulYGwLQU9lLDKrVL9iCwOWoLcGS2wp2KAT9qVxbTp7dEBjfN3LiymNLPKyG2l6w3vkjQR8vMZQlaeggQTjGP09zy94UAFrpli63tSBAyaXHMK6q4J5w3axSmKqeI87S9nuO7638WnxxgqsPCeTvVoB0Zwl0m/HKYfmc2A/4ivrgUraQw0KgIQzaLoLiKk+PBT8k8pkQrDp6I4HLjatbZ0r+vcCItODSJc7XcV2lFyp+wzf5Eb1co1HT4Dk3zCfLAjHYV8dJePJkFhNvxq0Yo02hlRMI0mI5QCtbd9nvQRpcxVFIKY5uMek/tABUgaJcY0/1JNg/3MojyPum14rP+CRgy1kWXEM+kPCnPnfZldJunPE3DPYeDw+gfrseMAFF6qQV3ZICoJnuVd4efPMS1UkrQ5QNXBHV5IaO1xeYqSYPyGwEWXwhp9Q4huYQlJtUuF5bm3e8PrvsjGRQrHaj4pFAZDmhas0zhmfomZ3a4YFt9ZR4HIDmQ9hu40rMLmKiy/nVsW2jgXtmh2SpB6AGGTWjWLyTzWALV4EuP3pZ8g3u2OYil
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(346002)(376002)(39860400002)(366004)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(1076003)(66556008)(110136005)(4744005)(66476007)(66946007)(4326008)(33656002)(8676002)(2906002)(33716001)(8936002)(86362001)(5660300002)(83380400001)(41300700001)(44832011)(26005)(478600001)(53546011)(6506007)(38100700002)(6486002)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uENno8JbaDQ5LJIhLQ80wHrVIDI1uQV3C0GsIVB6tOfE9h975ENJw+5FR0YF?=
 =?us-ascii?Q?eN4Fw4/nAPtBBKnTRdlnPmCDtznrlbkVsuHRx3QwA0m6TMf/8B+VsxCYl2Kv?=
 =?us-ascii?Q?FkBnBAjUiSkhOchoy27Y6mbu0vGHFPZqbqQ3tLHPKqGk/iQEaZGH6SSdMv9D?=
 =?us-ascii?Q?zJkCemvGTZ7xng/m1+KsSx0jgAXnyp2jPYZrYyK/QsrBlBGEIaSdvBR/P2Bu?=
 =?us-ascii?Q?MDe4dwcLLN40CPS12nwpreT5w5xL0wduW8rQC+nHy1LUCylPGlEJQxS96W8X?=
 =?us-ascii?Q?IXfnFR4AuoJWDdugwsj6Yo0Modnt1tSbuKhmdoKf2OjPki43WsI2Zemky3ph?=
 =?us-ascii?Q?X2joMlH75gKAAjQ3mXyLMCLlpAuHD42FgFhZK2m/jDLy+0AzAqXeAaMTNrwy?=
 =?us-ascii?Q?mSq/mcfMCscvBI1NwFxqxyYi2+1ChyaBY8BsQi583UxxM6nS+2dOFbgYvSBK?=
 =?us-ascii?Q?WFpovreIWId3IJaH7AyP9aQi3/wxnJ82oXzrBjaG2JoVb591tj18Gk/nxmv0?=
 =?us-ascii?Q?Wze+vfcgGSRFlZ4Tu6c0yk3/LmzG9Xs7DaP8jGHZL7hTe3m4ZTIDmegRXwHR?=
 =?us-ascii?Q?VIMxnKx2oFx/F5gxqy1fXdS9rakRjQOFQPyJj2iMIOXbEcPtoNKy1MViet4o?=
 =?us-ascii?Q?m0mYmBTULYOJl+MC5jCK3N6EHmOdkXnWEAOuP7t/MdvayWa8i7gILWT6lGlK?=
 =?us-ascii?Q?IosjtEUJWaiW019zqQqZeawOGp4pR5URToUwhwYOPWeOf9NmkgujV0yBc/EX?=
 =?us-ascii?Q?9DkhNy3cTmhtaw1xcU0GvnSjU5lngLIJf58flM0BzfNzQ8eAMTC4O2pv+7PB?=
 =?us-ascii?Q?YAFJexKesYnfz3KaK8KI2Bc5/QsfG0dW8P8C2A+70cvEsttoC+STwBNwZbTm?=
 =?us-ascii?Q?5b7QfeCwXtBMehubSNS4FqPc6UZTjRGUJvbnAavle3J6vHxAdTjuD2jPxhBS?=
 =?us-ascii?Q?vg+iThOBu6GLHDcCwjoDXJ3kHF9wC+oyc8A//zll+W4oY8yL4IESDG4hTWLd?=
 =?us-ascii?Q?bC7gLoR7AWD6durkZSumDE4hEZ6vEV5sOKN9eyLi3nzZced8j674tv38XRXi?=
 =?us-ascii?Q?KM8YQ6Kd8pYKfPLRHI4EJQf3FyAt54aoAYX0IniWDMvXrXYdWqiOMZBVlKSy?=
 =?us-ascii?Q?wn6+ieYkWcuBkU/mkpYL/0kVno+jeERQCS5SidWmL0ZV1XY2GxanXRVNqCvu?=
 =?us-ascii?Q?FYevfuRIra82i3SRHjo3aJql/NSrAP0F/oejShoQb4aQTfsWQbPISWTTl4pW?=
 =?us-ascii?Q?PIGopjxH9r8jLqHMR4dyYi5L2O5nZYXtwhGAXy3pf7p/avxuz/KkVuHoOlnJ?=
 =?us-ascii?Q?Pni9YYfMmid58syRv7pwR0FSYsxNla87ZqHRlcU9IBJSKPpWeURUKUP0xwwI?=
 =?us-ascii?Q?IVA1uIEb682/ivK4ELmV+b3fxpeNwrzkElbXgVeLJkPpGcPtkI+hXRsTcnUw?=
 =?us-ascii?Q?fxJnqFjfL5lCU70/xuxSRy9oRM+vrfYdtLYGH0WXxQbZKVJzR805SqEThbFv?=
 =?us-ascii?Q?bfwfBCqasoGm9ofXZp9P96if5aDK118de+DNbMbLR55GvMtniVxOrGzfpUnx?=
 =?us-ascii?Q?u7XgCewBbkRQEK/gKvMWWEoW/B5VCBc0BWqFT2c2sL5XGFz6x6AvZA0Bt8LD?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+DeJmUPTL20PfjIxslxHYZL5BK4gJkiGY/Dj8AgnOd35+8db6dasXBVgXorR?=
 =?us-ascii?Q?04buJbNieVKKkKhEYZmzP/fqyJ79uN2EepWin4H1Umv46ucJZC5LvncnHE6b?=
 =?us-ascii?Q?Ldb4WLHLIwDycGwKA1CMhEmtK7wZ1Q87XKyCyKiGsan2UQuDmFZQ4/7YrnZ4?=
 =?us-ascii?Q?F6rpWTfVscgCQLd4uaPwlystRTHIpyh9Ogv2eUIV9PG7o2/neTY+5gaqp9VC?=
 =?us-ascii?Q?T+MuysZ9U3OsAiezzbOn+cF/GbOvMn1Yo61EXtj7aflyfpx7+D+l2Mfz7iXZ?=
 =?us-ascii?Q?tfEUlloNi9iRnZKtLayKITukuFKPfAUTTgB/RXEXh5Fi1n2ygXf9mCnpWRI4?=
 =?us-ascii?Q?3OgY25yyH4zD7JG7x3pvc4gPAHFx/FHTghU7++QK5f0QpJnuK9XkLJrApYbi?=
 =?us-ascii?Q?exCT0pxE1/18kGEza+vY2ukrYxSZn6QqIlOEt+IJXKxWfwi2L14NU4c0Hwbq?=
 =?us-ascii?Q?aAfAP3NTOumk5odhkZ5xwFhmhJHdF2SXf1eIRXIfX2AEvQH50753bnMW4J80?=
 =?us-ascii?Q?4SiDiGy8YVm1cGyRoxvpfFYqB+nB52cIVdTl1CoVQPUnFw1OLaRe3/75RCoE?=
 =?us-ascii?Q?bAR8aaYUJ98zDS7BeqzaloFVa0oV0SkoZcP31LIZWk4XK9JlAOdXM9uu0p7C?=
 =?us-ascii?Q?HxXpukZmOvvt091J9syceMhQ/woy9y9O7t/ixLBLyboW0yrO3/Ap/YSQHsip?=
 =?us-ascii?Q?CfasX8gV7GbTHCzqHShnHX7DGpUydtS2/Xm6/9SMowttrltS/IbBNPKl/+Ke?=
 =?us-ascii?Q?3OTbVv/rLUxPtzkdcWgo0VkbYEd/oGKldd0MH81ZSho5rofyvmVRxzMJep6B?=
 =?us-ascii?Q?6OdeCdKilGk+vcxw4EoLXaAfACQPVSFUUAnlNbm6U4OX0im2CouGKs0bvaB2?=
 =?us-ascii?Q?oh73T7ma6Uht4qGsD4zW+yBX2hPP4RLWkmOyEGDL0gh9FUbankZx+45JzXJf?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21cb2032-49c6-4337-d9ec-08dbd04c82c7
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 02:38:43.4499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42dki54A+IqucjjcjurAgB1yknXnqkve6WGLznaajdJu8Hq1RCVbQTFLO3BXNX1YJxTbJA2RNkIthMgbJ9GkuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4406
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_02,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=532 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190020
X-Proofpoint-ORIG-GUID: DCSBmdfJFsN7JTy12uLUaoAvOy9uwdN7
X-Proofpoint-GUID: DCSBmdfJFsN7JTy12uLUaoAvOy9uwdN7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/23 15:56, Usama Arif wrote:
> Calling prep_and_add_allocated_folios when allocating gigantic pages
> at boot time causes the kernel to crash as folio_list is empty
> and iterating it causes a NULL pointer dereference. Call this only
> for non-gigantic pages when folio_list has entires.
> 
> Fixes: bfb41d6b2fe148 ("hugetlb: restructure pool allocations")
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  mm/hugetlb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Hi Andrew,

Can you remove this from mm-unstable.  The root cause of Usama's crash
was improper irq enablement via locking calls.  The changes Usama
verified (later in this thread) are in v8 of the "Batch hugetlb vmemmap
modification operations" series I just sent.
-- 
Mike Kravetz
