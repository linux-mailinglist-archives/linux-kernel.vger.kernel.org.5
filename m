Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D166782878
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbjHUMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHUMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:03:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E842990
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:03:47 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LBpwqT031859;
        Mon, 21 Aug 2023 12:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=J+k6OlNx0JmFkCFrraFX/YSaerVeUhUKykMN03r/GyY=;
 b=GW7hmGx9y5G4J5MuuEBNNwiYwqrDP1Qv52WN2bGeXXdk+2ANBGIGlcMN01+moRgpbaUH
 F/gts2Vr6kHjb2s0jS2j456U5AvbmKWYe3Erc8dWQgDtBIQqTyZ7z2PtsGu5TFtYx5ci
 tty5sa4G2lfTtzktQH6CZQkS2RKUZhsns777G6ZqhbeWijAqsAVLLZt7fWQvQbEYMIfM
 zkcZkneC4hleGvj8VIW/7O//Azllzjfjd1dNu4dz6OXeYKeEkvlWaEGUTqspGf3SmTDe
 JdEB0YEIcY5k+6Fqwp+nUJlYyY5j0SGBauKUa9V8I6qP4af6Ouw0+RR/hojTI3ogqYPK /g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sjmb1tr7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 12:03:25 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37LB5Bjt030357;
        Mon, 21 Aug 2023 12:03:24 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sjm63c44w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 12:03:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foKjFB35FN9UDaqBcatb6UnrMWkaosOc7GT9pr33AjCorEhgY3XojyR2Z4wPSfZnWTgnvbx5sqtf47jDPlXw1ncryN4ycLOrhDsLu+DmC0TaVRfd3MdV1jH+pEiceIKyAcvYlxsPhROmZ46zOddmYeIQq5TbRdS2gORo39+ELsQTKdqKUPL8m5glCCYCReMKKro0nXSJ8YypVgGAU5e9WX92a48Bf+VaIaU9BfM6okhro4J9HcWQGaC+6avuGN5EamJgm6VJ4JD1D9LSpUAZ7FRiD8t3OJcieMH1rFcm7a76g/umTaTHMBJetd+V18qr9DlHrx42RLXSPWc1DvLkow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+k6OlNx0JmFkCFrraFX/YSaerVeUhUKykMN03r/GyY=;
 b=Ij3V4/pbVR/B1yksXWDBfKR3k8HRsOdgz9sE5dzeQ0fcKQwb4QUIUryHUQC+poFoeWPC+XEzMmHHlV9qWVQ508ukYQLuzEdhPhylz5ReftruAN4ImQq39W6aP/lnK2MQNWD6g2r451YytapGon0jUHqLRbs2EYDRrnncmo4TroDJebJBu83pV5ykV03Vu2vLj3vJN8ylbyOMnOFvi4y7WpzpsV5fmQx+4b0mQxcZc2SK/KtSmeikIPWbrOOluNo8jcfAXz79aKV8BtpwdBV9uPD/AUoDY+8KVPxdxGUl6kFmfEWgeZefii2BZjIaMtknOlU3DRHxGJcPO9b3TiQkRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+k6OlNx0JmFkCFrraFX/YSaerVeUhUKykMN03r/GyY=;
 b=q7AM1pEPXMnPAXGB/xfOWWWQTMedZFdptTPX2I3rMANVPS3N0UQlkQMWZIdDGXdwzhMi36jKjdGAYuJd7I0GmSrDM/OEM3dsRonak5HRBDHHSu1xyBrSN1DnxeATBqmPHRzo1glaY1XwSUCzfaiDU5QtbsVNlFzbQ2XfAqEZ6to=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4897.namprd10.prod.outlook.com (2603:10b6:208:30f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Mon, 21 Aug
 2023 12:02:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 12:02:57 +0000
Message-ID: <7dc73727-014b-5e48-8336-73d34bc7b818@oracle.com>
Date:   Mon, 21 Aug 2023 13:02:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] iommu/iova: Make the rcache depot scale better
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
 <2c3a0f6b381ae5f743c1b28bbc6eae486160f3b7.1692033783.git.robin.murphy@arm.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2c3a0f6b381ae5f743c1b28bbc6eae486160f3b7.1692033783.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0652.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:296::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4897:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e9d2301-6788-4d6f-8665-08dba23e8ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y38N0oE3ebtk5oUUwqGdKbSuWApu1f1GmOTkyJk/yCP+Ui3IcABQWlkbZyE+GpcYB8xHqA74jUYB9pnsNb8ZGU89T5zwUF57leKIBvM1gxncHi/2lJRXeNDFbOfDqr/li/a65Z13PK57YpvNSWEodGwZhDigN4MOFdlLLS7jPICLBbpiGfTZDpVqv5LT3Oul/fXvJziGvOWNoQ6pwUhkmBOP5kv5r4w07e6wZPMoUs8S4XXBeKsu8YWhQM5JDSvHliNcCklQWlxjh6HOeqpL3YAXskAlSS6Vlb8N+SSSTX8ni38xS4Wh5LrfookGENb9VVVXqMGBqF9jDcCnJjjm+lOErFBmJZWEEwDST+utfQwDZFdbBd3rHnUaXDItAR0e+OVQQIW8IpZcY2o02BZwwflBzjQl2wOsQBFo3HgOAM/PnbrE4V+WJj780p6P0Tfs9DKlENh2QhlqRManxJfquj4QYxnIM1B7amY6z5mAHyb4onC2lstXHbd6BLi4aoseh5SlHsv0tcM6AmMWkChldnjKVQ6u5m7tde6wNDWp3cfHB8mu4xGXDtk4WayW5k0fRnkiJdvTvX2c69JIHq7RRUJ+/KiJaZ1UOWcCrnYcvpRkBpgZImrLbYpTYzM2yV9f/5BjR9a6ifjLd2Ggqx7WlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(346002)(366004)(39860400002)(186009)(1800799009)(451199024)(66946007)(66556008)(66476007)(316002)(6512007)(8676002)(8936002)(2616005)(4326008)(41300700001)(36756003)(478600001)(6666004)(38100700002)(36916002)(53546011)(6506007)(6486002)(2906002)(83380400001)(86362001)(31696002)(31686004)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkozR1o4Q2xPdVY2OHRlVVh3dlNtK2k2QmowNXdLRHR0QlNTMkQvMHQ4TUFh?=
 =?utf-8?B?Z1g4TlhHbzRaeFFNY25ST3RydmtqMWF1bTlSWTdnd0liSWVEajkrbEEra3hH?=
 =?utf-8?B?NDJEbVFEZVlYcVdFMHUvQkp4Q3Q0WU0yMHlPMnl4S3llb3Y4Q1ozU1d4a3Ax?=
 =?utf-8?B?aDNwRnhOMDRaS2UvMkhRcXNLVVhDbXlRTGhMS0h0YkcxbTR2VFBTeEhCUDJ6?=
 =?utf-8?B?L1NreTByQVFlSUpDVkFHVVZnQ1RoNGc1cDVLSFZNdXBqVVpkbFBnand2WUlt?=
 =?utf-8?B?Y0lhQlhMZGxNTE1pMkZpaDl4OU0wWEorQkZacFpHSW1YNy9oVFBtdnFWWGg5?=
 =?utf-8?B?T3VVS2JHV2lkSGxZUHJQVDJyNzZTYkpEcE5qL0lHT3RDZ2VBTWY2eHllb2VV?=
 =?utf-8?B?QWNhUkxDdlJ4Y2F5N3ZrWVdjUnBJblEwajNsekl3cmR3OHVtZmoyZ0d3OE5W?=
 =?utf-8?B?VDVTd2x4YjV0cWtVR090Z1J5eG1IZ0NsUEpMUlltL2JmYU9UbThmQzYzM1pH?=
 =?utf-8?B?Zmh4alpsUDFFbVpYb2pteHB4OGtpcXBhYkduLzVVVjdjdWg3NDEvd29SaDI4?=
 =?utf-8?B?eTBEWHVkRitYMzhYVHR4US9Jc2JOY2g2SDA3WkQwYnE4dWNiSG9Cakd2N3lI?=
 =?utf-8?B?ZkZ4UGc3dVRBTlFraEJIbXFZYzJoRHJjYlJPT0RzSTUycENWM3hZdFFaQzVs?=
 =?utf-8?B?Y1pQdGdtSW9mVDJxWDNRWjZFNHFyVnl4TTZlOGg2QnY4WTN2S1NlZTE1UjdE?=
 =?utf-8?B?MnJ1UWJiYlNxRlVFY0h2WVl2L01QUjliWXBCOWoxSy8vZ0lFWndqZ0tkbFNn?=
 =?utf-8?B?a080dDRaTG51d3F0cXhhajFuaC9OVzVzU2tUai9zQmtFc2N6T050TE9SS0VP?=
 =?utf-8?B?cDdrbWdWS0pKVlFKMFhiNVZWVnhQVlRHc2MrTUl5NnVTNzNWN2RUQUZMRHZZ?=
 =?utf-8?B?TC9XbUFNTVhuN2dIZ3pNbkpwUFhOak5CalVteUZHYU9uOERnbGVvUWc2c2Q3?=
 =?utf-8?B?L0FNc0hMTWVKVERmbTg2ZzIrQk1XMGt0OHZiMzM3ZjMxM2Jxck50WmVXVU1P?=
 =?utf-8?B?QXBKQ1ZZekF3QUpHQ01PbCszdXBvRlQ3VGRuMDZiMG9mcWhySllFL3MvNklL?=
 =?utf-8?B?QXdGbnVTdk1Sa1JVN2p5OXJpRnZnSFdEcFZqSVZJejVUcHBPNnF4bkpoQTha?=
 =?utf-8?B?QWhQVkpJVnUzeEZHTjJiY0xaRjlEUHFTOSswcXhJK0Z6M1RLT3AyaXJxVktQ?=
 =?utf-8?B?TTFQU25rL3ROZ094WWlmY3ljUlRWQldJTjJPdHc3YVZSa3plQy9SVndjZ2JN?=
 =?utf-8?B?Rjd3QkxHS0QwU3FVSTNVTnBqa3NFbU1Ed01lL1RnOFU2clBZWk9lUGlxR0x6?=
 =?utf-8?B?ZEVPNlppMjlkS2RpQVM3aG04eE5oQlNmcHM2RDRIMDU0V3lrOVcxVzZlWlVX?=
 =?utf-8?B?a3VSZnNHR2lvNUlYSHlNUFBYUjRRaUNXeW1BNHBmeVREemd2bm9KdUhrcWxO?=
 =?utf-8?B?TGplVnNKRzJ1TDM2VFoyYjFwZEZBWnpIb0RlTUhZZXl4aXVKNXJDMGJwWjZn?=
 =?utf-8?B?STJ6TGdDajNrb2IvM0M3dng2QWdpOTNDN2lacU8vZmZrRzhFOGtNc1BoUVpE?=
 =?utf-8?B?QVdCQ2k1dnk4RWVITGxWc2hSUjMrTGxsUjlVMlIyQTBkSUFkU0llRk43TWc2?=
 =?utf-8?B?Mm1jcmhtckprTUd4dlIzVThGazRROXpqZHlBTHZBUFpzNnJ0SmZIRWlqbGhZ?=
 =?utf-8?B?NWVjenhKbm80Y1NOTXA3cVNLU0N1MzV2UTRxMzBnTFRSRTZ3OTNVc0ZBOWRM?=
 =?utf-8?B?bkNaWXlDR0EyYUNkeGhBUGRKVHZFTDVhWmthS2tMN1k0LzllMXVMYXFkMzZ2?=
 =?utf-8?B?MFRmSUpTRVZRUS9WTTNOK3VuaURiaU1JcUJTa3B2eWJwTnZWTTFKNkhQemhI?=
 =?utf-8?B?d0piVkQva04yWkRCUkpOMGZHZzZDM1liaEtwRVZDM0tyWkJTeW9ndFUzWmtD?=
 =?utf-8?B?cTRzdHdmU3hVRElnVlBjN2w3MmplcmxzOEpyWlJMRUNCT29FYThmVGhDdzJz?=
 =?utf-8?B?cGhqL3N1Y2FWT1FiYkduQWhvR1d2a1NCUW94dFlDQ1A3M0l1SUdFYXJ6MllG?=
 =?utf-8?Q?1zDhCSvqOTmPprz9joJ3akQAr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 9J5l+fII+cu5U1MQfpUQ2ru+ALuYO2Isck0rdGWcpjqWnQsTpBMlYcWaVPwtZDBK9hV5O9dGSl6oiriEWXMbE9kak/2ERbLHzM6xgLKpospdSFfll4zuQcm4xTblHK+adQb/lKakLwl8qoro0I/zfXSTLKZXlS+vhmhQ7IxZzvIxVrWFAIp834CWzJhBgz+B4q0PJK8A9gJbMGzo+TxkXWqoI2wvIDloiN+LOYsk0QLhK0HkzY2VJdVIRoaYR0r4IS0MFlMROC76X9pJy67jagQWg+hl7w0vjK76xJQl3tYS6piAEUD3+QHjFa4TkqaoHklyWEXeQPBy9Qx0xJvvG+Fw4uovgYIHIIrKrJujVc5Il5pYPMG50thZrz3QB5h0HJfe/1NaVEOR6PgunLU4TEaioSVBwFKUk19pX495eDj6Yq1Ujh+aOHxLS3mw/NC5sM2RnNwQvOyvERcsCgy1PlH5talEzYGGTjihAgz6Hhehm0bPq18Cn2LwMQMrMW0wyrk2By4eN/ZnqFXIk0RkpDezFnWYqusqE6mmNd7C4yyXvmEVzfVNIYNEaWfD/P1Lk/O40qTXDsKQ2RUnMmww+7kpVH7yFxqLyTZCtqfHZ75zz3S3a76UOz+KDNa3TAI4txtP3HTH2ULoaOdXpjBwpT5iYFgQD3+oTNxoKRWfySA47FF9XOWn3u+UqSnm/U2+JWN23Yc9qTtVrvPQmcrTfcPqjLSZtWQqGLnTtX3CnFqOL1PjSUPqA5cXcnsmXC2Z57tJ3pgXSR/5sXsB4BU8wXc63VXnBmbOZLDcbhZ3iDWpuHKezw5RhzPL/h3YL/zVg3hAoxJh1/NmhtPqdbJko9gaeqczkgONhpaDzvbG7Xcw9znXAQ9Wuyou4Gmb0A8ybFLejaYELyX2fQ2WM5/flIQpbxlGy6r0EJJxinYo7T8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e9d2301-6788-4d6f-8665-08dba23e8ed3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 12:02:57.3098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WJC2ZQLvvICvcss7EqTvs/zawbBOS7+Xx8FKtd3ruKLeufQbmfqlU7B87rplx8fjA7HxV/Ef5XQTfPxCCTjCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_01,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308210112
X-Proofpoint-ORIG-GUID: 2kBd43CS97Lv3fm_eilOFuEeZ7Z58Y3b
X-Proofpoint-GUID: 2kBd43CS97Lv3fm_eilOFuEeZ7Z58Y3b
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 18:53, Robin Murphy wrote:
> The algorithm in the original paper specifies the storage of full
> magazines in the depot as an unbounded list rather than a fixed-size
> array. It turns out to be pretty straightforward to do this in our
> implementation with no significant loss of efficiency. This allows
> the depot to scale up to the working set sizes of larger systems,
> while also potentially saving some memory on smaller ones too.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

This looks ok (ignoring the crash reported), so feel free to add:

Reviewed-by: John Garry <john.g.garry@oracle.com>

A small comment and question below.

> ---
>   drivers/iommu/iova.c | 65 ++++++++++++++++++++++++--------------------
>   1 file changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 10b964600948..d2de6fb0e9f4 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -625,10 +625,16 @@ EXPORT_SYMBOL_GPL(reserve_iova);
>    * will be wasted.
>    */
>   #define IOVA_MAG_SIZE 127
> -#define MAX_GLOBAL_MAGS 32	/* magazines per bin */
>   
>   struct iova_magazine {
> -	unsigned long size;
> +	/*
> +	 * Only full magazines are inserted into the depot, so we can avoid
> +	 * a separate list head and preserve maximum space-efficiency.

It might be worth explicitly mentioning that we try to keep total mag 
size as power-of-2

> +	 */
> +	union {
> +		unsigned long size;
> +		struct iova_magazine *next;
> +	};
>   	unsigned long pfns[IOVA_MAG_SIZE];
>   };
>   
> @@ -640,8 +646,7 @@ struct iova_cpu_rcache {
>   
>   struct iova_rcache {
>   	spinlock_t lock;
> -	unsigned long depot_size;
> -	struct iova_magazine *depot[MAX_GLOBAL_MAGS];
> +	struct iova_magazine *depot;
>   	struct iova_cpu_rcache __percpu *cpu_rcaches;
>   };
>   
> @@ -717,6 +722,21 @@ static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>   	mag->pfns[mag->size++] = pfn;
>   }
>   
> +static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
> +{
> +	struct iova_magazine *mag = rcache->depot;
> +
> +	rcache->depot = mag->next;
> +	mag->size = IOVA_MAG_SIZE;
> +	return mag;
> +}
> +
> +static void iova_depot_push(struct iova_rcache *rcache, struct iova_magazine *mag)
> +{
> +	mag->next = rcache->depot;
> +	rcache->depot = mag;
> +}
> +
>   int iova_domain_init_rcaches(struct iova_domain *iovad)
>   {
>   	unsigned int cpu;
> @@ -734,7 +754,6 @@ int iova_domain_init_rcaches(struct iova_domain *iovad)
>   
>   		rcache = &iovad->rcaches[i];
>   		spin_lock_init(&rcache->lock);
> -		rcache->depot_size = 0;
>   		rcache->cpu_rcaches = __alloc_percpu(sizeof(*cpu_rcache),
>   						     cache_line_size());
>   		if (!rcache->cpu_rcaches) {
> @@ -776,7 +795,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   				 struct iova_rcache *rcache,
>   				 unsigned long iova_pfn)
>   {
> -	struct iova_magazine *mag_to_free = NULL;
>   	struct iova_cpu_rcache *cpu_rcache;
>   	bool can_insert = false;
>   	unsigned long flags;
> @@ -794,12 +812,7 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   
>   		if (new_mag) {
>   			spin_lock(&rcache->lock);
> -			if (rcache->depot_size < MAX_GLOBAL_MAGS) {
> -				rcache->depot[rcache->depot_size++] =
> -						cpu_rcache->loaded;
> -			} else {
> -				mag_to_free = cpu_rcache->loaded;
> -			}
> +			iova_depot_push(rcache, cpu_rcache->loaded);
>   			spin_unlock(&rcache->lock);

Out of curiosity, do you know why we take the approach (prior to this 
change) to free the loaded mag and alloc a new empty mag? Why not 
instead just say that we can't insert and bail out?

>   
>   			cpu_rcache->loaded = new_mag;
> @@ -812,11 +825,6 @@ static bool __iova_rcache_insert(struct iova_domain *iovad,
>   
>   	spin_unlock_irqrestore(&cpu_rcache->lock, flags);
>   
> -	if (mag_to_free) {
> -		iova_magazine_free_pfns(mag_to_free, iovad);
> -		iova_magazine_free(mag_to_free);
> -	}
> -
>   	return can_insert;
>   }
>   
> @@ -854,9 +862,9 @@ static unsigned long __iova_rcache_get(struct iova_rcache *rcache,
>   		has_pfn = true;
>   	} else {
>   		spin_lock(&rcache->lock);
> -		if (rcache->depot_size > 0) {
> +		if (rcache->depot) {
>   			iova_magazine_free(cpu_rcache->loaded);
> -			cpu_rcache->loaded = rcache->depot[--rcache->depot_size];
> +			cpu_rcache->loaded = iova_depot_pop(rcache);
>   			has_pfn = true;
>   		}
>   		spin_unlock(&rcache->lock);
> @@ -894,10 +902,10 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   {
>   	struct iova_rcache *rcache;
>   	struct iova_cpu_rcache *cpu_rcache;
> +	struct iova_magazine *mag;
>   	unsigned int cpu;
> -	int i, j;
>   
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (int i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>   		rcache = &iovad->rcaches[i];
>   		if (!rcache->cpu_rcaches)
>   			break;
> @@ -907,8 +915,8 @@ static void free_iova_rcaches(struct iova_domain *iovad)
>   			iova_magazine_free(cpu_rcache->prev);
>   		}
>   		free_percpu(rcache->cpu_rcaches);
> -		for (j = 0; j < rcache->depot_size; ++j)
> -			iova_magazine_free(rcache->depot[j]);
> +		while ((mag = iova_depot_pop(rcache)))
> +			iova_magazine_free(mag);
>   	}
>   
>   	kfree(iovad->rcaches);
> @@ -941,17 +949,16 @@ static void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
>   static void free_global_cached_iovas(struct iova_domain *iovad)
>   {
>   	struct iova_rcache *rcache;
> +	struct iova_magazine *mag;
>   	unsigned long flags;
> -	int i, j;
>   
> -	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
> +	for (int i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
>   		rcache = &iovad->rcaches[i];
>   		spin_lock_irqsave(&rcache->lock, flags);
> -		for (j = 0; j < rcache->depot_size; ++j) {
> -			iova_magazine_free_pfns(rcache->depot[j], iovad);
> -			iova_magazine_free(rcache->depot[j]);
> +		while ((mag = iova_depot_pop(rcache))) {
> +			iova_magazine_free_pfns(mag, iovad);
> +			iova_magazine_free(mag);
>   		}
> -		rcache->depot_size = 0;
>   		spin_unlock_irqrestore(&rcache->lock, flags);
>   	}
>   }

