Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583107B0844
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjI0P3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232184AbjI0P3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:29:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A275C121;
        Wed, 27 Sep 2023 08:29:48 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38RDTBmI027170;
        Wed, 27 Sep 2023 15:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=YIOcN0Ldlq7o71MvBChHD0YGZZcZ7hPPbRdofUU1wkg=;
 b=m4bSs8EEA5E3/zQLtNL2foWFrEt/LCqmHNnCC5pyCu0KVEeh0Wlsxw065n9GmZQPd1Gp
 KgfBXGLSE3hLYJn4m32nQPec4p02XBOhSh2e/6YyQXhiSE1CbRHAcx+ZdHbA06UzRZfV
 5ojekV6uxB7qpc1cycUoRx/xFRYY1EiJRDtJHtAo/xy0tYPfeEZa2QP1/sc+QfM6Dk6D
 CZjIlJTtGgM5QD+6s+r1AqtYxlV5pDw7ivb4bMheHGLqDIj+F+OnHnIglHMhqkO5QPg2
 UNASZ/M6u0stWnx3YyQk6CJV1p+ICM8doSYq6dOZUeEgW7IJnE+7N+j30bkHufz+NMIo wA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t9pee9t9x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:29:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38RErGjm039423;
        Wed, 27 Sep 2023 15:29:32 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t9pfe5trg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Sep 2023 15:29:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoDu1i3HZIdz6SdjOfLZPNCR0VF7PfvrhR2vH5ilp5lnh1QSTZTaSjkgpDJmGBKz9GUZXWLGGscdoplvrFpjsizratK1+gwofqX+7sZ5VQ10/BqLxVhCs9T5Fzd1QXsLkx4/XJn2j180ibkL6O2L2Q/X4PXLgQYL/Ssb5oaPKFWJbNWuz8Blm74fYhnyGFCI7PpO1yhFYpF2b4cCRxBB9Ljz85g88SMMIDnQ9S7SowavJepVanCvHo0ThlWKHYS9vmNWPPvJuQqj3WJ7H/IemjV+cuFqNgNPvnnVSsQYCsghKRcEQg/rMVr6sG/WsLPGD7Mmimn29Fz2NpZD1QAxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIOcN0Ldlq7o71MvBChHD0YGZZcZ7hPPbRdofUU1wkg=;
 b=hOfPqgQiqexK89Wi8Mwiludk2EWtoOvdM7wMXDjEU+7BsKzo3RtQKSL8T27hy5UjR+x6s7vPOrnlCw0eaTDPsImCBkzaSi4q9LUg55kD0vG8AryrRtOIFhgfnaubRa0K9TQKRFkZrGfTjFWbGDxVrk799ntZTayMaKXn7O4CdI70InXUyzypZJKkVKu02A5gsL598egmotIaPIODgafUpNOsUqj1MfGAKsxC7+A54s6K2fAoP1rzLKCV3mjZmOVa3kGncQydRp/GNIgFW6ojjrj39SCYdN9RreH4/ACw2+kMvjnl0hsPS//j5TsqOv5HTokbpndVMv19Pz01xAFKEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIOcN0Ldlq7o71MvBChHD0YGZZcZ7hPPbRdofUU1wkg=;
 b=ypicc8opRBdcHLmh2EJtRITsyrzW712/hVnKJorqyYoU/SCtLr/CfppIqAronby2tyRYTfMW70kQAHLOCPdvdCwCO4vf4LodgvKrW/m9mww7q9P66FhlWgmLx2wEdPrz/R5oLG1NxQuTpN2bV4dqXxMUYG7njmgtBJWKz7+LdIo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DS7PR10MB7322.namprd10.prod.outlook.com (2603:10b6:8:e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.22; Wed, 27 Sep
 2023 15:29:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::59f3:b30d:a592:36be%7]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 15:29:29 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Bodo Stroesser <bostroesser@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: target: tcmu: Annotate struct tcmu_tmr with
 __counted_by
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq15y3v1vox.fsf@ca-mkp.ca.oracle.com>
References: <20230922175300.work.148-kees@kernel.org>
Date:   Wed, 27 Sep 2023 11:29:26 -0400
In-Reply-To: <20230922175300.work.148-kees@kernel.org> (Kees Cook's message of
        "Fri, 22 Sep 2023 10:53:01 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0069.namprd05.prod.outlook.com
 (2603:10b6:a03:332::14) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DS7PR10MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: bb3c16a5-9c32-416a-41e0-08dbbf6e8a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9HyC704sxzNR2RqvPXOa/Z09ImQXN8la1GhP/+p8P1A0fVyLNgIbe2hPrBGmf08E9vOhDocWLGF2eRUxuO/5vGNVH5dSytNw7ASMKJ7whO/Tgpr1cHK38OOe6ZHynHdGCXaVmnimlnBqa6JVTlh2eUF3D8yr3q/j6jg5iftGvIQOry8annff5WPMxmJJxcd61uD6ck20BrYBzBzaGvM7Ffk2gKkFN+4ikjyRl4EBoV6nNermV84M9tpcGKYnK8KxoSeI63nvsNRBUf9nBCmwHtzLxSNmvk40R5cgEnv3zhv2QbValhdBbQDYii0OjDKgH5y51Tt7j6wmHszS+ObzfY90DvR5ewfxpVEa2NLB6tGZJhvkUtB66H5U38PGieaTAbG5nLUPrk+w97Icxvg5UYihnPhnDJmGspMqLnH6rDDaLwDPjz75WlvgYmJDDLjlwChcPt+hvIH79CAcyrlpcnFSX44vTDFR/jFheVN0rH20I2kgj3udsXMR9p1zSNhDvZo+tU+/1/eTKcFV8QcDBi3OaIJgWcbab6olk9jc/aGt7oCViyN+9A/qRXmyJBS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(83380400001)(2906002)(4744005)(86362001)(41300700001)(26005)(6512007)(7416002)(36916002)(6666004)(38100700002)(478600001)(6486002)(6506007)(5660300002)(8936002)(8676002)(4326008)(316002)(6916009)(66946007)(66476007)(54906003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qJA3R9pCV7WBVsHwRyMF3J3xFWVSZih+pMP06bWsdPqPzHph+1brpp9jeWO1?=
 =?us-ascii?Q?mkvm9sSfDG9gYvtIJ9uTKrunTK8nCjpD1yxHM5I1UpIlHeaRcoADbryiorS+?=
 =?us-ascii?Q?w79K9bqaD2sscJ+jq18WySLLGYKsIvueoSOkBaVRWwYs5WLCNkKPDzcGkWJP?=
 =?us-ascii?Q?L2d4l0km/tLh9/PamkcYW1XjuvTNfqMD0lJ22cMOO5L4nN6FSSt+BkH807/L?=
 =?us-ascii?Q?4krApLf5qPmqNGdzxk/GibI+kcx9dsli46r2V/UtfAMaLg+yd10/snMoJxfI?=
 =?us-ascii?Q?P3vo8zw4CfGeXBtfn1+8Ew4lI/XGOAMPAyQqgsqmHLDFbfN1TJUZQqZAh+fq?=
 =?us-ascii?Q?ekJNXj1LIfzmwHjbk2LBQsnel8EiLZU6/88MN5GgYFrqc//TEwansvwvLdoh?=
 =?us-ascii?Q?ycvZoyO/hrhEWEFSsGtKRtjJigtk4StOrQloiIsNO9+IMiEhGygwtHk9Vfma?=
 =?us-ascii?Q?xUwSt6Fjo+kSkoYlJGTPM9UV3J6eFb2MlQpTxKO2YPjg98NqS5BzTOOOk2CF?=
 =?us-ascii?Q?Pl/7A46QZ0fTCHutZyQC0FD58O4Dghv6pN269K/c1XzDK5LAdPyqW75fS3mt?=
 =?us-ascii?Q?ndEyZsXX3b80WdjqESE8N7+mxIvRRlVniRjkhAYTcH4AvoW8SGsD1IRULpfF?=
 =?us-ascii?Q?4CRdcQaVFYWifSzc/6dRduecLm7H1PG9hW+kjqtbCck9IBMmPM6ikMYUFArF?=
 =?us-ascii?Q?OUl9WI/uPzl+qqJHrdV8WdUmuTIhTST2mlp3rvISlyfLj1UmPUke+42Qdn6R?=
 =?us-ascii?Q?xTbJPj5y9v8M9nxGXYS67qzUy0mXnSSVGm3XbUH3iruxDmbuFKjn8HAfANN5?=
 =?us-ascii?Q?//E3JS3gzGN8Q1+pp81FIWho8LedR2fxME3evDQPFy6kczOUfUPMrttb8uZS?=
 =?us-ascii?Q?WVhJ9Y/c+0YzLj+TzclV5gzZiEKXlYsnswUyvH22f01alQaG9LaJaXJgbozK?=
 =?us-ascii?Q?w2nip3kHXAKjwrugoPw0pj/cGu1wn8y8juJBCSV+Oh7DuhD/ygta+k6Zf35i?=
 =?us-ascii?Q?u0Lh93lfbcFA4CmG9hRHFvbD7x3KlGFLE7bKVi22TfriPlhTbLNOmBH79lO+?=
 =?us-ascii?Q?QoCBkkkqO4ZeNcHz2Cy7EURxz0PrmnYnUa4S0F8gH8D621nHqwRC71xipC3M?=
 =?us-ascii?Q?k0oKk5fN4SXxvhs5rD5XRv7bcQ+mCxgwh/DGcMxG5fJHwSBjVUT+YqhJ0qxQ?=
 =?us-ascii?Q?lsOw8K7Hz3yQsXgtBV841MNd+IxSC405D+hFAdpkH3g+C8a5WfjdJIAHpne8?=
 =?us-ascii?Q?JyTymEdHEXgnISg5HkZO5UVi92uor7hq3bt7o3NNKll7PR/JLAQQbrmn11r6?=
 =?us-ascii?Q?vSdt3uprDauh2P9xGYnkPwQ6lfLh9MtX2G/X9Y2C2W2YvAsMrqHHg5xB+1Li?=
 =?us-ascii?Q?mJ0IyeaeC3KJ+hmaWlA/NUpJfR/yGZ7SmfXYigCVGBr4Y9Ih3d98AssnYg4z?=
 =?us-ascii?Q?BFYa94xDGEIWBvOFGoG8CWrrWXoUIAHmykeKsghutd/78/o1Pj3p23fwA+JW?=
 =?us-ascii?Q?BYqAN13axRqrTyDwG+6Sks8cJY/Qoj8ufKx+nXjZpEA10Fh93GhthNyBhzR9?=
 =?us-ascii?Q?WS4lSerNajEF2qqiHUldZC33ibabw+qDtCy8fLu+v2BrTg0EqZdq6R3YMQZZ?=
 =?us-ascii?Q?1Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dFzAMbh53vgO2gAuAiggLw15Ld4CM8BtOdnvDkYaFSaWGcQT84QhKTS2c35y?=
 =?us-ascii?Q?88Eya6UV9s3W5d9HRiIUdco3Rj3Gpt9TTgOowFUV8nFiqdAcqcwxLa3K53D7?=
 =?us-ascii?Q?L3ohBKVPbs1tIt+8/vxFFKTm/wBVxLY5Onpd4UEG2u8JcYPGCAQ4OIOcVAzW?=
 =?us-ascii?Q?/sz95gr9O/4RCFMK8tbrmHmT/LyTN4BnOqsu/xP3GSui4w22zHrJTMZeK7Gi?=
 =?us-ascii?Q?mGgMkjpRlvA/ky8UBZ+jWxlt3vWiIjYrHd1By85cUTMMFxtaxRy5F8z4SFNj?=
 =?us-ascii?Q?rcDJoC+jz1E8vKh5DgTfyXV3IX7CGhfQM2W82JwdqZocfolzt3hJZJV+lWbj?=
 =?us-ascii?Q?/+VGQCyWXVUn8VLzlHO03PxyLVORJNutubKsNqb+IgOeDt2bqZ8eyeKF/RvT?=
 =?us-ascii?Q?w84h6LQLAvaJkBQggB0m3VxyZadcC16ijbdAdEAdESxHKiuHUpmGJ2sQPhCX?=
 =?us-ascii?Q?/HZxxwCpvD6TPJvywjY/zGM0Iko6xUxc8t9eeRYYjYLhExv41pxZO9kLo0iz?=
 =?us-ascii?Q?QxYRWT7L+1cEsZxBzsgQgRyaeXgEBT1VMEjvbGe6U0G9zG9R3qZuScjZk4JX?=
 =?us-ascii?Q?f733dcYGSRMLcUQsNAkFeOl0ju4rqQGD/Xb+aIpnqbSNlQDDJtUIygNIRWxD?=
 =?us-ascii?Q?feRv85VJi6hFT0mGXlHMma4QkgIaa44XU0l4XsqWAbbzLL6A49SmIkd9mXL3?=
 =?us-ascii?Q?IFaYEgM5FbmlPaHRxdMB8m7e02RPqq5EZWQGkdg/ZrxqaYDGnTNjYKstovf0?=
 =?us-ascii?Q?eB3AMQqeA1tJzOsMrif4hFH70CXQRVioRJT6lsu69bV3lbRhkpbEyyDqYiO+?=
 =?us-ascii?Q?lilM+qOtrDz0Us0zVrM8McqwrHAIwVvxZKUtKJ/FijJOP7ut1E5RNboTzR/a?=
 =?us-ascii?Q?ynsXslF4iJaUzesyJ3puWgGGMCe0RRKdw5VKoHW2vFOprsDpk6Q07fj1ksup?=
 =?us-ascii?Q?SMO+zEY8UHekj8d/XJ9uhA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb3c16a5-9c32-416a-41e0-08dbbf6e8a6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:29:29.4124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V2Okdp+hbTYAJotxqYCKqjinahqceYlySVDlp4InPL3B87y6x2+5mSUJEN6qsW9JypF4EFfh7yqo5jE3/83LocK1zt9g5dLlbk+2rHHiGq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7322
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_09,2023-09-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=691 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270131
X-Proofpoint-ORIG-GUID: phiokkigPzPwUW3rPKwJrVnipScr7Qvd
X-Proofpoint-GUID: phiokkigPzPwUW3rPKwJrVnipScr7Qvd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> checking via CONFIG_UBSAN_BOUNDS (for array indexing) and
> CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family functions).

Applied to 6.7/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
