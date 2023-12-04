Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1B3803C3F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 19:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjLDSFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:05:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjLDSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:05:46 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F51CFA;
        Mon,  4 Dec 2023 10:05:51 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4I05GS029993;
        Mon, 4 Dec 2023 18:05:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=+7dgLIyiw3H9pYcm8BtMKrsn83/gSMoaphSDdZwPsWI=;
 b=jK19AabBVxY1g2KNDRvI+sMpIQRDuBrQuQMpyCPwjKgV8HK17HgOgSJtMSBe5HGxtZxk
 ietuiIYR+a4hcsaqNlWxuvQrV//686yXoUQtdOEGC6PFZO9iVT5Xl18o5LkusGlDvN4q
 gBmESlmZqrhEMa/HKHHrXZp5KKiXJVtAZvutDOTakne3wyUIJBtz60lAStf3KliFcOQZ
 4Vc6OR2d6EBbCC6osTkmurEbQJfeqIT70Mg2+L4LgZm6QhdYKa3uIFhdf7yN6tzBLFl6
 1VMRSugl67kZSB4gwymrbmWxeA6MgroaDQKBuO+YjVuORtb+xQ9Pbb6Tz3kyYSV1e+5j 5g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3uskddr2u2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 18:05:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4HqEVq022601;
        Mon, 4 Dec 2023 18:05:33 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3uqu1cn00y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Dec 2023 18:05:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYkQ5dIHHZnl26E4NmBU2c3/TL0hjH8LjBri4ksNy6qUuITahf/g5DM+mHNs1tJ1oUXEnc6b4/9S6B/WiuMqQBvdzKC5/Dym+jiSYoe7/vlxGP8xO+/jdSRebBhWqoytPYm8gSCrkqokjMxE0O3ZrW1AvhHWgw814d3R5uZBRX97HV6oMRDSYNq8i43DhthRjp+FlHmVb1JSlsDAFcwUvaLsN3HNAV2H0lUw5PUz5E70O5/zFqq34Byk7uKKaU00qE/AYzu0xWpJyazOtIg3FVhz7PEW85GkCUCWm4tqyVqLvRtoZbpQRgr54xYz5GzcO5r/kMmnGisc1OA9nAjuKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+7dgLIyiw3H9pYcm8BtMKrsn83/gSMoaphSDdZwPsWI=;
 b=n0Ea86UdNNvhTKnhCoYpAm9G6d6AXUyBroUU8fcFHnv86tH3ddlgH6FOawLMPkR5Cwbjqu/1FAgomcv+F218Prgl/kJWf152CyxHTAiCKyJEQZJe66AXw2N5X3EKRbYDR0lQ/I+wZHuXHpRymNuBWnJHjFlu1TO/zNGuyq6Fx+D6OgUzYjYB+HnENPpXjlwudPClndYK+rcKFZccHYpGgGeACY1AJ3TeQeFeeJXRlT5+YA8mi076po+u/spPDVuSVgBejr5eaU6o3SpVg7TIcTAVr9OfDqIOHivnmQeEer8d44MgI5RpzL5OtUFgSpMRjyY53M1A923uCr98/0DpiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+7dgLIyiw3H9pYcm8BtMKrsn83/gSMoaphSDdZwPsWI=;
 b=RUQLPvuErea1mci5Ij6ZN8b/SqQ6gsbCgWGZ3jx+UPFMj1HCdtMS9PILKUg2cWXj2B5XlPnKGxtuXNXlYXAjJPv5kaDQ5TFnEb3+SVMR8hIH7+aJv3vNMV6cctJ/dZb4Pv1XCfV93F4RFAQtQvXPD69P6Ns4T8vnecXSA9zU9Aw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.29; Mon, 4 Dec
 2023 18:05:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::102a:f31:30c6:3187%4]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 18:05:30 +0000
Message-ID: <336b3084-dfae-4e91-ba31-7e08ba4e5591@oracle.com>
Date:   Mon, 4 Dec 2023 18:05:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] scsi: libsas: Fix the failure of adding phy with
 zero-address to port
To:     Xingui Yang <yangxingui@huawei.com>, yanaijie@huawei.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        damien.lemoal@opensource.wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        chenxiang66@hisilicon.com, kangfenglong@huawei.com
References: <20231204122932.55741-1-yangxingui@huawei.com>
 <20231204122932.55741-4-yangxingui@huawei.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20231204122932.55741-4-yangxingui@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0405.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4542:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f13766c-953b-4ade-b52a-08dbf4f39a03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNUJ25rdI4TxhOr+O/15GHvICDnSHqhOr9Dl5mezlr7ZitVX1bJkH2qxQhv1Be9zxCepCulOeSCQHwFZX6p6jxCZU38Nrvo3C9HcZLbZv5prJT/XUMT/BeqBVu4ID0IWA0vV2hMbsUaB3YYBGriLShRMFWXo1CDN7NbwfmRqp32Y1q/SsaNQntFQ7Vl21Pj50Aepswakb7VJsu4mjeRoVC6Lxgh+bwiw4Pxnd8bqCilrjL8mzj4xXAv93RaiDkHo9+nVhOF/J+c50C/D8DyP70ak6ACCuOY1bYLJ1MlVwYBJPqpDq5RS+nGyvoYb3ImNZIOJsjbTeSJcdX5SfhH65PRsa1r46V0m8P24wEjVXLVULwBjjKfCEdGEvLRwJ+U9TS1VzDkG8xUJhLDKFTWrnCwufEWl/JhNSpbFh+7Jeu3RJiWTepBZaf8XlnVQog5MTis1xeLI6UE+LLRvfJ/GO0+AlIlcOVof4q2G3VsSe8tZm7Xc6/0VEyxLJUVKKiCr6ZMzjByCBAFtuixGpaqqPdzxvh78vdTwE9zPwUuF7o5KELFdEUjt8ae71MgsqMVH3Q0O68boZtTlb1EGGRg9A898Dm6HT9RCy0R4OdK5Qp5k6hBpmmfr+oMSryjRW6cFYrb7/61n2QUf3tkPR2ax7w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66476007)(66556008)(66946007)(316002)(478600001)(6486002)(6666004)(38100700002)(7416002)(5660300002)(36756003)(41300700001)(2906002)(86362001)(31696002)(8936002)(31686004)(2616005)(4326008)(83380400001)(53546011)(8676002)(26005)(6512007)(36916002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xsQ2tvVHloNHBORWg3TnJtL0s3WmsxMkFHNDQzUjJkblgrRk1kM1hxQTdo?=
 =?utf-8?B?VHVZSnh0TXJuU1VVWm81YWtvYkhCZXMrQlQzUjRmOC9ZTitPRDZqbFBQejUw?=
 =?utf-8?B?N3paeGc3S3pVVzZ2ZUFCK0p0M0xuNEd4NVhRUko3aWNuTDRxMGUwMnZndHcv?=
 =?utf-8?B?azVjYzVxSGszQ0poSTY2TXJCQVBoditIY0xueUZ2UU5tVjlUK29kQlU3cyt1?=
 =?utf-8?B?NW5Sc1BBU3NWc2ZVdzJKSG4yU3NFL3pCb2srRmF1NzNGYWRxQXVrTXRoNzJn?=
 =?utf-8?B?aXpXWWdjSXdLazBRR1Y1VUovdVd6NkF6c05DZlBubEtlcVoreTdYMHdoVkdC?=
 =?utf-8?B?MGtKNUZpMGZra25uNVlOWWFvaG5ialdjNGtoNkp2QnZROXNZYWtlUjU2YVVx?=
 =?utf-8?B?cTA3aHE5anJFNkRIZ3Z2N0pVUU1GRDhicm9iU0ZoMUdIaUxPRHFjd2JRR1Av?=
 =?utf-8?B?bDFxWE5zbk9KdUk5L0FuTjI2SHhGcXlOTC9lVFlCZ1RKR0pERzFlMXVOSElP?=
 =?utf-8?B?V2ppci9NZFJQUWZ6QWtIdktmeDkzOEg4cHFVVmsyYU1BTzJpTE9ma3ozYkZ2?=
 =?utf-8?B?TWtVZGVzcTM1SzFSb1o0Vi9sTUJBOUVqZDdCaVZpdFRQTlE3eDlheVNpOEtn?=
 =?utf-8?B?S05FMU5xSWtrLy94ME10Rlc2eTJOQjZicW81WGlSOG51T0dTZlBTWkhkcmJK?=
 =?utf-8?B?U2JNZGtjMlVaU09SdXBSd2Fyd3lyWVJVRGdUU05IYnhUdkhGZ0NlVFRSQjNu?=
 =?utf-8?B?MWREcXZ3OExkUUZqQXUzNGRnTVZSdnBIaTlxNE1tWlV3bk1vV0lGRTVTOWRZ?=
 =?utf-8?B?ZmtRaUpuaHVEN0tVb0k2MUVxV3BWbXFrZWZKSURhVFdvcGlOc21hNndGOHhX?=
 =?utf-8?B?U0d4M1VkbFFJOEVsRFVuOE1zQ0o1SEV3d3pRZ1pKaWI5cFNHNEt6c0xySHlw?=
 =?utf-8?B?OXBhK0JQbWFrVDJhVVZYRE43Rkp5UVhZK3hOM0E3SDlhZGYwQTJuN2dXMnVG?=
 =?utf-8?B?M29zUkQ3TFlrKzZvbzQ3TFM4UkJTTVZBanNxZUlvOWcxZkV2RCtXWkxCSjMw?=
 =?utf-8?B?YUN1THZYYVlZemFaTU5Tbk1kNEhEbldsV2lUOGVjYm5QNVFIdHdLaDIrMXFH?=
 =?utf-8?B?ZWxVdEtadHRLdWFENkZ1aDRhRUUyL0l6azFnK09LbzI3R3oweGRpZ0JvR0hS?=
 =?utf-8?B?Smo4dFp1UC9LZThZN1hPcWwzeXVNbmthcVZsQmk1V3hpeUNiRHFVbW5Db2tS?=
 =?utf-8?B?Wi9RV1h3R3hES0ZkNDFrOU82YS9DanQ0OHZCSDRaUm05ZVNRKy9tbWpaVFF6?=
 =?utf-8?B?eUkxQnczT2hRQm0xcUQ4NE5hT1VRbUhvemRDbGV1ZVBXTFMxTUgvTHVFSUMx?=
 =?utf-8?B?Z1FXekRuQ1F4TUVoNHlDM0VTNmlaTzdTQTIxVHU2bm5tUy9nODErTEJTM1c0?=
 =?utf-8?B?Nml2QzAwK0lrNGlDelI1MnE0OXlSYXZLTHM4czdjUjFsekZLZlBMeTlLb0VX?=
 =?utf-8?B?bzI4YWlxMEI3c3FGRUFpV0ZRdndsNEhTVnppaW1QaEFocllkeWNoZXgvN0pO?=
 =?utf-8?B?R2tXK2JPcThzTjJ4RUtMWEdCV0lXbHJhK2VZWG5BUUhqbk1UWWkySFhrb0NK?=
 =?utf-8?B?RlZwWTJiOUkxMHQxQUVKbzNUWHBmNnVkYm1JTFhQbUNQUTE4ZUNOSGZJNkhD?=
 =?utf-8?B?Ti9qc0M1V0pUY0pBL1FQZjdCbkwzM2hIYzAyZWozd29GaGI2T293eHRIQnR0?=
 =?utf-8?B?S0VEQjl2dDlhYVdkQ1Z4R1JsZ1NuSXp2Q2VlaHlaTnJldGpMM1NMeTduQUgz?=
 =?utf-8?B?bTNTUkI5ZXZzYmNMWERiYnhEN2o3Z0ZtUVVObUVuaWthazVseFN3dG9WRFlB?=
 =?utf-8?B?WmhzQ2VISmY2cDBQV0c5VHI1Y0p2R0dYdzJDUjNwaExrWk1sZG5DM2JiNENN?=
 =?utf-8?B?V0pJdjRMRGM0TnhiN21zL1pKZHpxZzNUeWFWZEk3OTRsSFhuU0ROc2JDWFVq?=
 =?utf-8?B?dXNObkxVOUpwQzJkVVVRb210WTMyWWJ6ejFvcDFpWHlYcUlweUVWTUdaS2s5?=
 =?utf-8?B?eGVUUitlQzNUb2Y0d0ZiSVE5V1cyVWpYSzBzY0o4ZHhZYWtIb1YwUDFacVNB?=
 =?utf-8?B?QkcyaGR4ZDM5NmxFVDFMWGFjVTlMaUFQSW9lL0Y5SVN6UEdLbmg3b09NeDMx?=
 =?utf-8?B?M0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ldSOmdokK0L5l6ZgPq8NFTiJu3fjgWZA/OeI7byzJVoELVj41WgE5ZtCwREFYUvfjOONE3D6vAptUTOaRvI9B4UrSm4EHj55wyjC9bgMxVy4ZECoiGzrUgQZRYBB8dMzsjUkyaZnrsdIJnZ6RXzXPBAYLL50DPkw1016q9Q1S2a0EWahtdii7aX32dWvB/rhtnV2nviFxCaWC+cG0EKuYnYhSbUawRgU1ISR7LY6jiXoJfhqO8HQ08XL4ar3/1Urc1+uR/RSDbjFm3PLhU6BSf0kjjnpnSOiKKTvYRgKDOA/lT6KewqPDvBsNPMNG0ZqrecdU2AX3+3WqRL9tbO7sYT7zUHIvSHZyL2XUOhB8WvZG3/qoolJvLbDprh/uamz1JAHmRmO3CjfNlA8zaqfRt/2U4BElCmsmSoV4p7ZVa1qT1CD3RM2yw8uat9fN/NbIUN5jyFnzjMsexg4onRbl94BT4xHfh0KtQjvLTLRrmTUtziF4Mf8Wwm5TvFyOLIIbW/6J7x0tXbCp9XFHYt/COw6cY2oNbKM0nftiIbOqdLm6W4bsTUQOHg3hT49DCzDOsXou3gCuMS8iEZIrvcT2h2wKLwRHiuS2ri72DYbePnzWuloAinvAENzGiivAyL+yaF+qfeLgyC7yGKrRKfOoODskyaqfROYx6ot2w8rowSL9k85QLSbnUD1bnLxzcNU7HcdgvLaO1f0Ftg8YB/K8aRqQ0A2FcW+Otm2VJ0TKG3BOf4p74L63G0Osv4Ig4cu4m0zmUYxRLaecZEPGJJFRTpmac0+9cbjX1+Rur/30/qBy/7rIIgasLVMja702JqszhIweiUWAKGNb6WFPjjHinTC3YBcxG8D1mMsgFPMqAxR0GfMUMN+NXD8bLJm/R80WwyvkvKq/XHeXeYJ6GXJu/MBlWSl9ONUHs7uhVeWqZE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f13766c-953b-4ade-b52a-08dbf4f39a03
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 18:05:30.3762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hwUzJVG1stv1UsqB4vY03Btea0zhTIKZQgxAm2lwMrVyBvG2di7ohfCaMokjjrcLhvjGJCYJGRHejwbQ+h3hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4542
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_17,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 phishscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312040138
X-Proofpoint-ORIG-GUID: uL_lHqy9m3zCwbGi_nsKmp0rotnQGfQp
X-Proofpoint-GUID: uL_lHqy9m3zCwbGi_nsKmp0rotnQGfQp
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/12/2023 12:29, Xingui Yang wrote:
> When the expander device which attached many SATA disks is connected to
> the host, first disable and then enable the local phy. The following BUG()
> will be triggered with a small probability:
> 
> [562240.051046] sas: phy19 part of wide port with phy16

Please use code from latest kernel. This again seems to be the old 
comment format.

> [562240.051197] sas: ex 500e004aaaaaaa1f phy19:U:0 attached: 0000000000000000 (no device)

The log at 562240.051046 tells that phy19 formed a wideport with phy16, 
but then here we see that phy19 has attached SAS address 0. How did we 
form a wideport with a phy with sas address 0? Sorry if I asked this 
before, but I looked through the thread and it is not clear.

> [562240.051203] sas: done REVALIDATING DOMAIN on port 0, pid:435909, res 0x0
> <...>
> [562240.062536] sas: ex 500e004aaaaaaa1f phy0 new device attached
> [562240.062616] sas: ex 500e004aaaaaaa1f phy00:U:5 attached: 0000000000000000 (stp)
> [562240.062680]  port-7:7:0: trying to add phy phy-7:7:19 fails: it's already part of another port
> [562240.085064] ------------[ cut here ]------------
> [562240.096612] kernel BUG at drivers/scsi/scsi_transport_sas.c:1083!
> [562240.109611] Internal error: Oops - BUG: 0 [#1] SMP
> [562240.343518] Process kworker/u256:3 (pid: 435909, stack limit = 0x0000000003bcbebf)
> [562240.421714] Workqueue: 0000:b4:02.0_disco_q sas_revalidate_domain [libsas]
> [562240.437173] pstate: 40c00009 (nZcv daif +PAN +UAO)
> [562240.450478] pc : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.465283] lr : sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.479751] sp : ffff0000300cfa70
> [562240.674822] Call trace:
> [562240.682709]  sas_port_add_phy+0x13c/0x168 [scsi_transport_sas]
> [562240.694013]  sas_ex_get_linkrate.isra.5+0xcc/0x128 [libsas]
> [562240.704957]  sas_ex_discover_end_dev+0xfc/0x538 [libsas]
> [562240.715508]  sas_ex_discover_dev+0x3cc/0x4b8 [libsas]
> [562240.725634]  sas_ex_discover_devices+0x9c/0x1a8 [libsas]
> [562240.735855]  sas_ex_revalidate_domain+0x2f0/0x450 [libsas]
> [562240.746123]  sas_revalidate_domain+0x158/0x160 [libsas]
> [562240.756014]  process_one_work+0x1b4/0x448
> [562240.764548]  worker_thread+0x54/0x468
> [562240.772562]  kthread+0x134/0x138
> [562240.779989]  ret_from_fork+0x10/0x18
> 
> What causes this problem:
> 1. For phy19, when the phy is attached and added to the parent wide port,
> the path is:
> sas_rediscover()
>      ->sas_discover_new()
>          ->sas_ex_discover_devices()
>              ->sas_ex_discover_dev()
>                  -> sas_add_parent_port()
> 
> ex_phy->port was not set and when it is removed from parent wide port the
> path is:
> sas_rediscover()
>      ->sas_unregister_devs_sas_addr()


Sorry, but that is not a callpath. Maybe you condensed it. Please expand it.

> 
> Then the sas address of phy19 becomes 0, and since ex_phy->port is NULL,
> phy19 was not removed from the parent wide port's phy_list.
> 
> 2. For phy0, it is connected to a new sata device and the path is:
> sas_rediscover()
>      ->sas_discover_new()->sas_ex_phy_discover()
>                              ->sas_ex_phy_discover_helper()
>                                  ->sas_set_ex_phy()
>                          ->sas_ex_discover_devices()
>                              ->sas_ex_discover_dev()
>                                  ->sas_ex_discover_end_dev()
>                                      ->sas_port_alloc() // Create port-7:7:0
>                                      ->sas_ex_get_linkrate()
>                                          ->sas_port_add_phy()
> 
> The type of the newly connected device is stp, but the linkrate is 5 which
> less than 1.5G, then the sas address is set to 0 in sas_set_ex_phy().

I don't understand why we do anything when in this state. linkrate == 5 
means phy reset in progress. Can we just bail out until the SATA phy is 
in a decent shape? I assume that when the SATA phy is in "up" state that 
we get a broadcast event and can re-evaluate.

> Subsequently, a new port port-7:7:0 was created and tried to add phy19 with
> the same zero-address to this new port. However, phy19 still belongs to
> another port, then a BUG() was triggered in sas_ex_get_linkrate().
> 
> Fix the problem as follows:
> 1. Use sas_port_add_ex_phy() instead of sas_port_add_phy() when ex_phy is
> added to the parent port.

this seems ok

> 
> 2. Set ex_dev->parent_port to NULL when the number of phy on the port
> becomes 0.
> 
> 3. When phy->attached_dev_type != NO_DEVICE, do not set the zero address
> for phy->attached_sas_addr.
> 
> Fixes: 2908d778ab3e ("[SCSI] aic94xx: new driver")
> Fixes: 7d1d86518118 ("[SCSI] libsas: fix false positive 'device attached' conditions")
> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> ---
>   drivers/scsi/libsas/sas_expander.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
> index 7aa968b85e1e..9152152d5e10 100644
> --- a/drivers/scsi/libsas/sas_expander.c
> +++ b/drivers/scsi/libsas/sas_expander.c
> @@ -45,7 +45,7 @@ static void sas_add_parent_port(struct domain_device *dev, int phy_id)
>   		BUG_ON(sas_port_add(ex->parent_port));
>   		sas_port_mark_backlink(ex->parent_port);
>   	}
> -	sas_port_add_phy(ex->parent_port, ex_phy->phy);
> +	sas_port_add_ex_phy(ex->parent_port, ex_phy);
>   }
>   
>   /* ---------- SMP task management ---------- */
> @@ -261,8 +261,7 @@ static void sas_set_ex_phy(struct domain_device *dev, int phy_id,
>   	/* help some expanders that fail to zero sas_address in the 'no
>   	 * device' case
>   	 */

Please pay attention to this comment. It seems that some expanders 
require us to explicitly zero the SAS address.

> -	if (phy->attached_dev_type == SAS_PHY_UNUSED ||
> -	    phy->linkrate < SAS_LINK_RATE_1_5_GBPS)
> +	if (phy->attached_dev_type == SAS_PHY_UNUSED)
>   		memset(phy->attached_sas_addr, 0, SAS_ADDR_SIZE);
>   	else
>   		memcpy(phy->attached_sas_addr, dr->attached_sas_addr, SAS_ADDR_SIZE);
> @@ -1864,9 +1863,12 @@ static void sas_unregister_devs_sas_addr(struct domain_device *parent,
>   	if (phy->port) {
>   		sas_port_delete_phy(phy->port, phy->phy);
>   		sas_device_set_phy(found, phy->port);
> -		if (phy->port->num_phys == 0)
> +		if (phy->port->num_phys == 0) {
>   			list_add_tail(&phy->port->del_list,
>   				&parent->port->sas_port_del_list);
> +			if (ex_dev->parent_port == phy->port)
> +				ex_dev->parent_port = NULL;

This does not feel like the right place to do this. So the port which we 
queue to free is the ex_dev->parent_port, right?

BTW, do you know why it's called ex_dev->parent_port and not 
ex_dev->port? I find the name parent_port confusing...

Thanks,
John
