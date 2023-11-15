Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A907EC6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 16:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344347AbjKOPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 10:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344352AbjKOPEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 10:04:12 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA0187;
        Wed, 15 Nov 2023 07:04:08 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFE3nhk014754;
        Wed, 15 Nov 2023 15:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=7WL7ECQLLM0KRSgTBnrr1/H2J7xVAfwOs0LClpdDBW4=;
 b=HOxU8omVDrBXMQigjhwK/IaycaqCCTEbkXuLgSKetW8m0nzNDJy2K46ArhyVcSZVQXbF
 bYDF6DjVIyTYqB2CqMGaXTNxMe9xAgp9rE8tODokiTmweWgz/fPGg1W++f5hu6cbB1lq
 fxAWAvTxF8Y8gzAFCrynwfvocXr9lH1vzW9zvDNuSYBpopluFq8xNw5diyLgFUq4oIFB
 v9a8yNZd6pL8ze6aK430k9FCfNJtM6YYAHUOZBDMOFesyLd+fZxZc1njmo+jWt5SsTcO
 CBhBel9rFC6cDTMYp4bm9qB0brdy87ab0D5TOxkFcufKlSmJi7i4Ahitls/QABQq/bpf qQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2qjrsmf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 15:04:02 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AFF2mIU014849;
        Wed, 15 Nov 2023 15:04:01 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uaxqtff3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Nov 2023 15:04:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lArRzoAjt4xRtD0k/pF43H+zWX59IR2CCGJ9KvntAYJ6xXDpW4YfWdxzFDpeWgYkZ/jaXIw6kYID6+NjxwS0YpgWedsfGU/BibrcrcV3Tks4lAnM7FvR9p04ORFIeVxOAq8GltMZbEm58jKNQgosCYggdOy2yGpvnnMr7yMRXEKAvQGQPYd+yk2Xi6hq981AZwMnDfORDCA75DtoZjd8IwJcJpta6CGPHkZCHOQgPdQ2lEvHUGoRqMHxJaCPGM3oUnpF9kxP8mlplkuD7CnH/LjHf6fQJKwLGwFouy73K1p1kVhjKAFWJSidxvi6AePKFT5jRfxgM+tjradsdNVFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WL7ECQLLM0KRSgTBnrr1/H2J7xVAfwOs0LClpdDBW4=;
 b=mqiwvvbsH5Aw3ui5VgN5QzN9UO8MGQajXBRGeSysK00ETTc3tm8MPEduVw1e4eERzOeMJ1d7WaTTnrJ/mQ9/92DUNv/XJobugvJhUGJgRR3MElkLJL87Kk+9U0dU740eQWIBRVYNSuVCjeL1DKxO6y4R0I5njHnadREPrQEGPi/3RF8F4K+ltde2SpN+WXcQHXFxOmfWYOpILqDvCUfPZ7zWK171+zDLORk5hXhqH0KM8yL9lY/0ghEHaueRxC53hZsayEkeWgohTCorZC8bDpYo697ecNebSWcRAgPrpuoYv0zYVfl8rLZGMcgIruh/mR1sUfgJS4mwe9D7UlF8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WL7ECQLLM0KRSgTBnrr1/H2J7xVAfwOs0LClpdDBW4=;
 b=PRyh6JH+vTOEIRkNSOMFKS25fxQxrP+mg9MWXhi1RVxBQ+CGhjLrcI6F3ihtBNyujDUCkGIAxj4+/onwW7ghzlOWWfd3O4dO56c7gjs5dBIfYcaQ814jjKdJL3n3fX7haURPWrflSecwz0fwFNRDwRhHbE0EP9SMBIduub/uUC8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5673.namprd10.prod.outlook.com (2603:10b6:510:125::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 15 Nov
 2023 15:03:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.6977.033; Wed, 15 Nov 2023
 15:03:58 +0000
Message-ID: <09b84161-748b-c1c2-e4e8-96df5d2b01e5@oracle.com>
Date:   Wed, 15 Nov 2023 15:03:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 10/13] scsi: fnic: Add support for multiqueue (MQ) in
 fnic_main.c
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     arulponn@cisco.com, djhawar@cisco.com, gcboffa@cisco.com,
        mkai2@cisco.com, satishkh@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20231114223810.634200-1-kartilak@cisco.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231114223810.634200-1-kartilak@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0005.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: ac713f21-b111-4a61-8bcb-08dbe5ec1829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zDK2ksHN6Dr8N3LdOZxDSyzsSPn+PCI7DH/0mXJudtVJOcKV8KIHigijbpxNXV2Rm9Z4ec8/Wuf8gbLLMskN2PJwCBy8dlGr38jnZm6LQ58urKl770E1gIfuN3Ze1mzRyuEpijHHtPRWASG3rQrI4GR++PxKZLU5t1nOgLAV6dxf6YIo5HgWWliDGFTpKBLldWdnk+Q4d0JUfTO1VLxVwPL/a0zPtwH0xmyXLlc+IJJbCMRaN7n7khnsljHyearAwlvxEiIdxogHdqkMbm68ipHb9RTz/fb64cD/VKliQkRSJkj61xyBw63H3PuCXkGteEYtv7I7m7+Tm1mxYG9ooAgLWkkKdPuj37DHlT30A0TOat5XVSpTMr2C/S1UPp156SaHXio3PG/aL8I2WHKyj2IY/Ejx2Sk2OBsozTq9ArkG5cLhjR37Xl4bkh/VvcPx/E6Gh7BDoJxN/n6VguPunFC8KM2ZovFojo9P1mEMLpINsaio+5rH7sW6jHQjrjcZP9EyK28Dt0tOgoXwvnO/P6/RfKpS/v7pILBo8CUFqjE/55MYsWLWfJpMiR0b9r0jHT9GKWq+OZ7eLV0Eo5pMSQgiz67fWTcSyIa81oeEqs9tTBSKwddCO2yGyf221a4yVIdp06+I9c235Ojd+r6uPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(39860400002)(346002)(376002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(30864003)(7416002)(2906002)(41300700001)(86362001)(4326008)(8676002)(31696002)(5660300002)(8936002)(36756003)(36916002)(478600001)(6666004)(31686004)(6486002)(6506007)(6512007)(38100700002)(66556008)(66946007)(53546011)(66476007)(26005)(83380400001)(2616005)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXUybzNuUWp6bXJjYzJaeDQ5R21kcmpRSlR0YTdmbDg2NHFQdXovOEFIQU50?=
 =?utf-8?B?WW5XNnpDZkJkNCt5and6T1JsTk9tcVNSc1VRTmpmR3h0TXJUY2FXT0J6WW5v?=
 =?utf-8?B?ZmlyZis0YTc0WFV4VkdTNDdWOWMwTjVPUVhJc24zeENzZ2NIOUNxSi85M2tq?=
 =?utf-8?B?WWh4VjNuQzNNUHBrVCs1UHFVcFN2czd5UjkzY1c1Mis5VzZ2bXpSYTY0a2tN?=
 =?utf-8?B?enFsS1FKT3dnc2w2S280WHBZbEtqcXdHaU51T3k1dWR3T0F1emNxU1RFQkla?=
 =?utf-8?B?UGcxNXNBNG9wNzAxalNBR1dKNzVOMy82MVFFcVREQlludS95VFZqanAzZXVQ?=
 =?utf-8?B?WTRxaGIwb0xWOWk0SDFXd001Q2VWcTdkK3RKSXNnNE9XMUQ3WlE4aEY2eW9n?=
 =?utf-8?B?UGExTnlaeHQrU2VKT2E0NGhET0RYaSt2YTg0cDJiTnBiVDdFNXRENUFsMXBF?=
 =?utf-8?B?Y01wOGpqZGU4bVdKRkdiM3E3aWpHWHp0alJmWVQ5cXZCMFQveGlzb1duTWJ1?=
 =?utf-8?B?dkhIRjBSa3dlVC9kZWY0NE84TzRZaXhSbnI2R0x0dnRUb2J0NHAyUVk2bFNB?=
 =?utf-8?B?M0FsVjZHQ3hjb1RmVHVYTE9oRUZqdTdWN1UrSTFqV3Axcm5UM2VORGFrRXVw?=
 =?utf-8?B?aUFqQUxGdVplN1lRQVN0a0JMekZqSC9HQ0FKUDR5U3BXWHBXQUZVb2hXc3N6?=
 =?utf-8?B?dDBEVlJjY0hLcjlBUHF3K2dmaklmMmRYYjBteVBJb3hOWURDY2EwVUM2anc4?=
 =?utf-8?B?eERPWXVPcmVMZzZUUHd0YWxOaDFwQVIxeXdWMkJ1aEQ4dE41aEsrL1Q1QXVY?=
 =?utf-8?B?Q0VaaXIrTk5jT1lPZ0M0YStLelZ3YXpNY3YxVkkrUEZZbWUyeE5hUVdUYTFK?=
 =?utf-8?B?cWJ0Q3NNOGY0TWNlNzhneXZhUlhZZnlZcU9JeXhNRzI2a3RUa3RCTWVEVDc1?=
 =?utf-8?B?VnpaYjNYR2tIcEZ2dndCaEtmZFQ4Mkl3aHYyQjdxaTB1bVRIS0E4YUFOUnNH?=
 =?utf-8?B?alIzdThUbkgwQ3hjSHVLdFg0Q1ErdUtJOE0rYzE4QnpyWVhTaFlkWlRQbjAv?=
 =?utf-8?B?aUFyVkN6OEwzTm9mUUZzUGN5R1Mrd01DTnFXWGxaSmdRVWxXRHZXdjZtdFVx?=
 =?utf-8?B?M20rdHgwM3NxVHYzV1NFSFVXSlB5dnNzWjRkY2t0ejA0RTYxSlRMUExHY29h?=
 =?utf-8?B?ekptVk5lMUZKc3M0Zk91OGJMWU9FRnZaU0VYTDduQWsvakVWWSt2MFJxYjVo?=
 =?utf-8?B?S2huS1dsSEpDaVVFekszaExiQ1FMK2lCL1l0R0pqTS9BRkxvb3RNUnJHaVlZ?=
 =?utf-8?B?NzlXVlNhWXB4UzNvMEYvaWMwcXdwREtkdlZaNForc00yRmxvY1BBbm1vQ2N0?=
 =?utf-8?B?MWlFbWQvQTJFbzhyT0M1ZmJzVUp1TVdzTjFRSUZyQW9wWE9McjZtRWVUSmFG?=
 =?utf-8?B?bThDSDBtcnZMcWJWakh3TVkrL292WDY4eGZSVEVOQ1MxMzBlL0MrdHNMTkJU?=
 =?utf-8?B?dUZBdE4xRTZSemtmRE1pRnNLUzhPS0J2VkM0bGZyZ1c0blZIR2RoLzhncXVy?=
 =?utf-8?B?Z290d2duQnAzaGd3RHVzRjRQSjJXS25Hem5IaWVoZ05UUDRNZS9hLzBZcXR0?=
 =?utf-8?B?ZDNzbUdJZmNyclhQM1hSbC9zcjFtN1lYcGJQdmNENVQxQTZTUFF3TXhDUzAw?=
 =?utf-8?B?b3AzTVVoVG5YNE5PMW1hV2o0RkZQdGJzM1dXT2xpamFoZVhraTZlVlZrR25U?=
 =?utf-8?B?b3FUd3VkZ0VRaDJ5czhRUXNkb3VnYWZKUlFkVmVzZEo0VFBPQTE3Wk9nRTdl?=
 =?utf-8?B?UnhjMW9JbkR5TnQydVJ5NXB0RWNNbFQ5dCtuYlpxSk4xVVBFWUlhbzg1NGpI?=
 =?utf-8?B?VklZdzNQb21wVlVFSWJzRXBCNHVaalN6ckp6aGFoY0ZmekhvOEpJY0Y2NDF3?=
 =?utf-8?B?T0VlQktMemVlS292eHZpVDFZV3htc0Vibk9UR2g1TU45T2ErM3ZMV3NnMk8x?=
 =?utf-8?B?L1RaQVhja2Noc1pSWEo0QTJ3UndiRjZMbzdRK3V4RUVNQTdyRXBJMzRHTlhx?=
 =?utf-8?B?cm5kTTJzSmJxVGpLamlOelM1SUdRRWZDVXpjcnNybmdQdjBGV1graVlVU2NK?=
 =?utf-8?Q?caktbGrJzshfWdznOb7Lsfld4?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Mfm55uLUVt5fLFADUAx/Acv9WQEPmOqaSRT/L3JVUf2D335ZCSMClOtCAMCo6UfFvd4b8So3nxQzfOBT87OK7bziqKE/y6Cb263CTMD9y4dpQrNQWH5SE6ShZYr78PrVd3ftZFiUVGKCM21V2UebaaC/WdVZh3dpKtpL1ERzByWV+uH+hXNdnbKv/XGPlKvb/HzpR7LW8/6e3FZDmheuhMbuOLqUE79Ps2UeQZEbXN/X5D7FlgqjHI63dNJFxpCJQdbAh5IdnQkOvUz6RgSSIPtFalbeDHu5dH0L9+y9waPqfN6DtiN/1EJTXIk9k/4mEmxtzkWVj/JTeybjjKprWNSoRrPTDj8QY+izFGOpAYciaRzH0gkNAQR6071ipzqFAfiAclftMDvqlBV4hdk0JspxOWNpP2WL/vrovC768ZNZMIa+MCeT/HkJPjcLUo6ahY1PK5B0ZDx46FKtWXgxAItDfG6NAu660evRgzxbhFfYf8be71Tk9orzb4iLpas6nHmjYZ3koGFglZhxrzvtf5JbeqEelpOSUa7eo2OYDM6//t8SEKchkUXApB0XY7h6SmrHv1yRyvEiZlEhQ8Yj8+cOjqd8hs0EvfoXlvykugBcoiufnMh7CFLCJTxCXu3JMfSiumHqiarus/mEuNH1W4tzFl+4VHO25SWw39GpO320ugHMgG9mdiF29siu2xWoaWBsN/kuuIAaD2NDTDYVu0wDO6Ep0bQIxhUxF3SRWf/NREVBhMSx5MaZV0zjUM/2LYCQXD4iTNxNsqUDQm/I9Gzvmsi57Kr8TRp456urbukZocVXE/SeuqYH10HUQKN3a3TySkwNopmmiW+w7WARyMJy/sgYjWiyC0XnM2tgR2Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac713f21-b111-4a61-8bcb-08dbe5ec1829
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 15:03:58.6015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCfgVW2zd4xF+YGPzHyRxgMlIjCHvQh2WGi34kNnPLY4scRjfkohjDsbl2VuqiAMa/LTZaLYXfq2klerEtJ0/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5673
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-15_13,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311150115
X-Proofpoint-GUID: z8d_x9sJeSSrN5zxEY1RTvqkHo1Qy4Ny
X-Proofpoint-ORIG-GUID: z8d_x9sJeSSrN5zxEY1RTvqkHo1Qy4Ny
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2023 22:38, Karan Tilak Kumar wrote:
> Set map_queues in the fnic_host_template to fnic_mq_map_queues_cpus.
> Define fnic_mq_map_queues_cpus to set cpu assignment to
> fnic queues.
> Refactor code in fnic_probe to enable vnic queues before scsi_add_host.
> Modify notify set to the correct index.
> 
> Changes between v2 and v3:
>      Incorporate review comment from Hannes:
>          Replace cpy_wq_base with copy_wq_base.
>      Incorporate review comment from John Garry:
> 	Replace code in fnic_mq_map_queues_cpus
> 	with blk_mq_pci_map_queues.
>      Replace shost_printk logs with FNIC_MAIN_DBG.

JFYI, This comment does not belong here ...

> 
> Reviewed-by: Sesidhar Baddela <sebaddel@cisco.com>
> Reviewed-by: Arulprabhu Ponnusamy <arulponn@cisco.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>
> ---

... should be placed here.



Regardless of a couple of comments, below, feel free to pick up:

Reviewed-by: John Garry <john.g.garry@oracle.com>

>   drivers/scsi/fnic/fnic.h      |   4 +-
>   drivers/scsi/fnic/fnic_main.c | 109 ++++++++++++++++++++++++----------
>   2 files changed, 78 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
> index 97a2e547584a..5777a54c99c3 100644
> --- a/drivers/scsi/fnic/fnic.h
> +++ b/drivers/scsi/fnic/fnic.h
> @@ -109,7 +109,7 @@ static inline u64 fnic_flags_and_state(struct scsi_cmnd *cmd)
>   #define FNIC_ABT_TERM_DELAY_TIMEOUT  500        /* mSec */
>   
>   #define FNIC_MAX_FCP_TARGET     256
> -
> +#define FNIC_PCI_OFFSET		2
>   /**
>    * state_flags to identify host state along along with fnic's state
>    **/
> @@ -384,7 +384,7 @@ void fnic_wq_copy_cleanup_handler(struct vnic_wq_copy *wq,
>   int fnic_fw_reset_handler(struct fnic *fnic);
>   void fnic_terminate_rport_io(struct fc_rport *);
>   const char *fnic_state_to_str(unsigned int state);
> -
> +void fnic_mq_map_queues_cpus(struct Scsi_Host *host);
>   void fnic_log_q_error(struct fnic *fnic);
>   void fnic_handle_link_event(struct fnic *fnic);
>   
> diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
> index 8bb0165490f4..93c457d88fc2 100644
> --- a/drivers/scsi/fnic/fnic_main.c
> +++ b/drivers/scsi/fnic/fnic_main.c
> @@ -12,9 +12,11 @@
>   #include <linux/pci.h>
>   #include <linux/skbuff.h>
>   #include <linux/interrupt.h>
> +#include <linux/irq.h>
>   #include <linux/spinlock.h>
>   #include <linux/workqueue.h>
>   #include <linux/if_ether.h>
> +#include <linux/blk-mq-pci.h>
>   #include <scsi/fc/fc_fip.h>
>   #include <scsi/scsi_host.h>
>   #include <scsi/scsi_transport.h>
> @@ -116,6 +118,7 @@ static const struct scsi_host_template fnic_host_template = {
>   	.shost_groups = fnic_host_groups,
>   	.track_queue_depth = 1,
>   	.cmd_size = sizeof(struct fnic_cmd_priv),
> +	.map_queues = fnic_mq_map_queues_cpus,
>   };
>   
>   static void
> @@ -392,7 +395,7 @@ static int fnic_notify_set(struct fnic *fnic)
>   		err = vnic_dev_notify_set(fnic->vdev, -1);
>   		break;
>   	case VNIC_DEV_INTR_MODE_MSIX:
> -		err = vnic_dev_notify_set(fnic->vdev, FNIC_MSIX_ERR_NOTIFY);
> +		err = vnic_dev_notify_set(fnic->vdev, fnic->wq_copy_count + fnic->copy_wq_base);
>   		break;
>   	default:
>   		shost_printk(KERN_ERR, fnic->lport->host,
> @@ -565,11 +568,6 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
>   	host->max_cmd_len = FCOE_MAX_CMD_LEN;
>   
>   	host->nr_hw_queues = fnic->wq_copy_count;
> -	if (host->nr_hw_queues > 1)
> -		shost_printk(KERN_ERR, host,
> -				"fnic: blk-mq is not supported");
> -
> -	host->nr_hw_queues = fnic->wq_copy_count = 1;
>   
>   	shost_printk(KERN_INFO, host,
>   			"fnic: can_queue: %d max_lun: %llu",
> @@ -582,15 +580,42 @@ static int fnic_scsi_drv_init(struct fnic *fnic)
>   	return 0;
>   }
>   
> +void fnic_mq_map_queues_cpus(struct Scsi_Host *host)
> +{
> +	struct fc_lport *lp = shost_priv(host);
> +	struct fnic *fnic = lport_priv(lp);
> +	struct pci_dev *l_pdev = fnic->pdev;
> +	int intr_mode = fnic->config.intr_mode;
> +	struct blk_mq_queue_map *qmap = &host->tag_set.map[HCTX_TYPE_DEFAULT];
> +
> +	if (intr_mode == VNIC_DEV_INTR_MODE_MSI || intr_mode == VNIC_DEV_INTR_MODE_INTX) {
> +		FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
> +			"intr_mode is not msix\n");

Are these checks just paranoia? I mean that it is strange to have 
fnic_mq_map_queues_cpus() called but not be required to do anything.

> +		return;
> +	}
> +
> +	FNIC_MAIN_DBG(KERN_INFO, fnic->lport->host, fnic->fnic_num,
> +			"qmap->nr_queues: %d\n", qmap->nr_queues);
> +
> +	if (l_pdev == NULL) {
> +		FNIC_MAIN_DBG(KERN_ERR, fnic->lport->host, fnic->fnic_num,
> +						"l_pdev is null\n");
> +		return;
> +	}
> +
> +	blk_mq_pci_map_queues(qmap, l_pdev, FNIC_PCI_OFFSET);
> +}
> +
>   static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   {
>   	struct Scsi_Host *host;
>   	struct fc_lport *lp;
>   	struct fnic *fnic;
>   	mempool_t *pool;
> -	int err;
> +	int err = 0;
>   	int i;
>   	unsigned long flags;
> +	int hwq;
>   
>   	atomic_inc(&fnic_num);
>   	/*
> @@ -607,8 +632,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	fnic = lport_priv(lp);
>   	fnic->lport = lp;
>   	fnic->ctlr.lp = lp;
> -
>   	fnic->link_events = 0;
> +	fnic->pdev = pdev;
>   
>   	snprintf(fnic->name, sizeof(fnic->name) - 1, "%s%d", DRV_NAME,
>   		 host->host_no);
> @@ -617,11 +642,6 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	fnic->fnic_num = atomic_read(&fnic_num);
>   	fnic_stats_debugfs_init(fnic);
>   
> -	/* Setup PCI resources */
> -	pci_set_drvdata(pdev, fnic);
> -
> -	fnic->pdev = pdev;
> -
>   	err = pci_enable_device(pdev);
>   	if (err) {
>   		shost_printk(KERN_ERR, fnic->lport->host,
> @@ -723,7 +743,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		goto err_out_dev_close;
>   	}
>   
> -	fnic_scsi_drv_init(fnic);
> +	/* Setup PCI resources */
> +	pci_set_drvdata(pdev, fnic);
>   
>   	fnic_get_res_counts(fnic);
>   
> @@ -743,6 +764,16 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		goto err_out_clear_intr;
>   	}
>   
> +	fnic_scsi_drv_init(fnic);
> +
> +	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++) {
> +		fnic->sw_copy_wq[hwq].ioreq_table_size = fnic->fnic_max_tag_id;
> +		fnic->sw_copy_wq[hwq].io_req_table =
> +					kzalloc((fnic->sw_copy_wq[hwq].ioreq_table_size + 1) *
> +					sizeof(struct fnic_io_req *), GFP_KERNEL);
> +	}
> +	shost_printk(KERN_INFO, fnic->lport->host, "fnic copy wqs: %d, Q0 ioreq table size: %d\n",
> +			fnic->wq_copy_count, fnic->sw_copy_wq[0].ioreq_table_size);
>   
>   	/* initialize all fnic locks */
>   	spin_lock_init(&fnic->fnic_lock);
> @@ -827,16 +858,32 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   
>   	/* allocate RQ buffers and post them to RQ*/
>   	for (i = 0; i < fnic->rq_count; i++) {
> -		vnic_rq_enable(&fnic->rq[i]);
>   		err = vnic_rq_fill(&fnic->rq[i], fnic_alloc_rq_frame);
>   		if (err) {
>   			shost_printk(KERN_ERR, fnic->lport->host,
>   				     "fnic_alloc_rq_frame can't alloc "
>   				     "frame\n");
> -			goto err_out_free_rq_buf;
> +			goto err_out_rq_buf;
>   		}
>   	}
>   
> +	/* Enable all queues */
> +	for (i = 0; i < fnic->raw_wq_count; i++)
> +		vnic_wq_enable(&fnic->wq[i]);
> +	for (i = 0; i < fnic->rq_count; i++) {
> +		if (!ioread32(&fnic->rq[i].ctrl->enable))
> +			vnic_rq_enable(&fnic->rq[i]);
> +	}
> +	for (i = 0; i < fnic->wq_copy_count; i++)
> +		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
> +
> +	err = fnic_request_intr(fnic);
> +	if (err) {
> +		shost_printk(KERN_ERR, fnic->lport->host,
> +			     "Unable to request irq.\n");
> +		goto err_out_request_intr;
> +	}
> +
>   	/*
>   	 * Initialization done with PCI system, hardware, firmware.
>   	 * Add host to SCSI
> @@ -845,9 +892,10 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (err) {
>   		shost_printk(KERN_ERR, fnic->lport->host,
>   			     "fnic: scsi_add_host failed...exiting\n");
> -		goto err_out_free_rq_buf;
> +		goto err_out_scsi_add_host;
>   	}
>   
> +
>   	/* Start local port initiatialization */
>   
>   	lp->link_up = 0;
> @@ -871,7 +919,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	if (!fc_exch_mgr_alloc(lp, FC_CLASS_3, FCPIO_HOST_EXCH_RANGE_START,
>   			       FCPIO_HOST_EXCH_RANGE_END, NULL)) {
>   		err = -ENOMEM;
> -		goto err_out_remove_scsi_host;
> +		goto err_out_fc_exch_mgr_alloc;
>   	}
>   
>   	fc_lport_init_stats(lp);
> @@ -899,21 +947,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   	skb_queue_head_init(&fnic->frame_queue);
>   	skb_queue_head_init(&fnic->tx_queue);
>   
> -	/* Enable all queues */
> -	for (i = 0; i < fnic->raw_wq_count; i++)
> -		vnic_wq_enable(&fnic->wq[i]);
> -	for (i = 0; i < fnic->wq_copy_count; i++)
> -		vnic_wq_copy_enable(&fnic->hw_copy_wq[i]);
> -
>   	fc_fabric_login(lp);
>   
> -	err = fnic_request_intr(fnic);
> -	if (err) {
> -		shost_printk(KERN_ERR, fnic->lport->host,
> -			     "Unable to request irq.\n");
> -		goto err_out_free_exch_mgr;
> -	}
> -
>   	vnic_dev_enable(fnic->vdev);
>   
>   	for (i = 0; i < fnic->intr_count; i++)
> @@ -925,12 +960,15 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   
>   err_out_free_exch_mgr:
>   	fc_exch_mgr_free(lp);
> -err_out_remove_scsi_host:
> +err_out_fc_exch_mgr_alloc:
>   	fc_remove_host(lp->host);
>   	scsi_remove_host(lp->host);
> -err_out_free_rq_buf:
> +err_out_scsi_add_host:
> +	fnic_free_intr(fnic);
> +err_out_request_intr:
>   	for (i = 0; i < fnic->rq_count; i++)
>   		vnic_rq_clean(&fnic->rq[i], fnic_free_rq_buf);
> +err_out_rq_buf:
>   	vnic_dev_notify_unset(fnic->vdev);
>   err_out_free_max_pool:
>   	mempool_destroy(fnic->io_sgl_pool[FNIC_SGL_CACHE_MAX]);
> @@ -939,6 +977,8 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   err_out_free_ioreq_pool:
>   	mempool_destroy(fnic->io_req_pool);
>   err_out_free_resources:
> +	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
> +		kfree(fnic->sw_copy_wq[hwq].io_req_table);
>   	fnic_free_vnic_resources(fnic);
>   err_out_clear_intr:
>   	fnic_clear_intr_mode(fnic);
> @@ -965,6 +1005,7 @@ static void fnic_remove(struct pci_dev *pdev)
>   	struct fnic *fnic = pci_get_drvdata(pdev);
>   	struct fc_lport *lp = fnic->lport;
>   	unsigned long flags;
> +	int hwq;
>   
>   	/*
>   	 * Mark state so that the workqueue thread stops forwarding
> @@ -1025,6 +1066,8 @@ static void fnic_remove(struct pci_dev *pdev)
>   
>   	fc_remove_host(fnic->lport->host);
>   	scsi_remove_host(fnic->lport->host);
> +	for (hwq = 0; hwq < fnic->wq_copy_count; hwq++)
> +		kfree(fnic->sw_copy_wq[hwq].io_req_table);

you might be able to use device-managed methods for allocating this 
memory, like devm_kzalloc() (so that the manual memory free'ing is not 
required).

>   	fc_exch_mgr_free(fnic->lport);
>   	vnic_dev_notify_unset(fnic->vdev);
>   	fnic_free_intr(fnic);

