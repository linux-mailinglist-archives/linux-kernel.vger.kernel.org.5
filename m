Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB6F7EB8EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbjKNVsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233554AbjKNVr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:47:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8935DD5;
        Tue, 14 Nov 2023 13:47:56 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AELi42R025887;
        Tue, 14 Nov 2023 21:47:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=UBdRVjW7gVhloa0WhBew+WvUguVfC3o1nPTn9UzchVw=;
 b=IKsSZZ12Vubym2LQ1ltXFzy7qGQ/NGjmtDQLwHWVn8buvqte+mmsEc7rnNfpvHT9ZAAK
 /C09TmHO1V+mycEFM1Ajwk7PXoZ/lXpybtLSf1bfHgGuQ2kdmaEcbGfvP7T3c5I2MOC/
 QdIRu04Eq6nbL5rpE27IR/GMU432CLE3t0218L1991WznLxvkcYXBGc2T10Egu7mqRLG
 Y4nK9jfV0HDvn7I5bMeGsZ22IFK4xKchTMcghSjGJ5VMujMjKr6aS1AzN9ZVjvZz0SOc
 03Dy49It+u8HS6q62GmRyh/nMKQ4LaVjRyITnXo/4f7O3m1qhUMxSyxjtx15x50SrVJ/ sg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ua2mdpwc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 21:47:47 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3AELZdpc038536;
        Tue, 14 Nov 2023 21:47:47 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ub5k41gmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Nov 2023 21:47:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqxGtjR6u21zK5W4JttulRcKgbyIhywkto3IDrfuP0FkvipDTCo7neTW/yI92YQE4mdPkemArZV197GciAR/NEpyCqOt/+2mfsn+zk31b+CWH/t4wjKpJR2X4ZZ0Sb0wyjGExjWG76zUaet+S63JcmMtzir2sg9QA6DEGZPkcqq1/DS9ZQO9LRE/drWwDfyOEjYQg1/vdrB4RaPB1R/3+gAPLqG4/rrxtN4nInT0t+D2pA4PfVpg7mJAn+ra2LXFt6nA/mOWmIjHGz9nVQRiXG9FiSKZEDyx4xtJdCnOxBYhEiNdFmisT/QBu0j+uiTBVzkvjCzgjsiiDI5PQ7n3Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBdRVjW7gVhloa0WhBew+WvUguVfC3o1nPTn9UzchVw=;
 b=WPf4qTSe2MLz/VaUIZqo4AIYk3Kh9esUy2qz/UBulVLJOD3GzbiVq+BbonfB513k2N3f2j5dMxy+wQqfUHUJgtNq9gt27/LYIlJ88JXm24h9y0YahDmt36JiItInAZR4j4WZZC8hmxUO0OPF61Lcq2eHz8wpe0cjvm7imIJb/+3eUjlaGzduQ1Uyc5WxqTCZgJwb3vYKmH/qEBNxBL5g5mTWME984/nQ5hLI2PJwS0U2ps5B2Kp/yg0uffLVfa3NFoV0vCWYafQ9+itpXNWvQGI48PN1a6oIW7i1iq+e0tDKFSuzstD1c1cigl96jWqbg8RJaYDhDCwkCPzjo4982g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBdRVjW7gVhloa0WhBew+WvUguVfC3o1nPTn9UzchVw=;
 b=Yz9TpSfzp7kwoH49KHgakBLTEc5i2KB487n86Gi2wELEH48qJMM2QMg3drMrfFczVQsVs9SY8MNKR/0jFpv2C/y3lFXwnsdCUzXpub9Xp+OGTg32ttIYiYPXcJqnwC8v035scuXB4PmHjHASNQJnvnqMGAh5qYT+nLaB7MYMYSg=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CY8PR10MB6778.namprd10.prod.outlook.com (2603:10b6:930:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 21:47:45 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::449f:4fd9:2d3e%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 21:47:45 +0000
Message-ID: <b00a9920-f16f-4187-9a7c-6083c5d98fb8@oracle.com>
Date:   Tue, 14 Nov 2023 15:47:43 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] scsi: scsi_core: Fix IO hang when device removing
From:   Mike Christie <michael.christie@oracle.com>
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
 <20231016020314.1269636-5-haowenchao2@huawei.com>
 <b95cf250-9a58-4a9f-8b55-4b6d00a6a6c2@oracle.com>
Content-Language: en-US
In-Reply-To: <b95cf250-9a58-4a9f-8b55-4b6d00a6a6c2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::41) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CY8PR10MB6778:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dea59e1-9c34-474f-a09a-08dbe55b5612
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V7t0U6S9+dFTR5ketgygb/C4GRpsxEZUsTWy6u48bZSoUMMrNyzvDXFbuixY+oTNh5X1rCc+N79vrYJO9P2xp6YkrjBFIPJvA73GolSHmmvOn3hs83x7z5RLMlwMwNBDqfTNpn+Jx1icUCBLfW2FYe4p0YIaXLpKtyp08pmFjIpWWhiMGwo6a561wem8lIqKozRP1f8qSFWGshx4/nCx2kDqmbGxOorltcuXu44sIYrB0gzJKOzlffi3wuUQLLdU80KXyR4zsorJw+SD0o+UP10CgtfPDNzt+K+tY+3GcZ7qLIvCAGc9JK5M1TTcyp/PcgAq7J8Z4FQI7gqVUXmIwt42QwU7HuwhJNvBszLZJ4WuysmnJYfcuvgoc50aWq9rqJ3JM4RI2qmFizUOH/f6GED9AD2QZ8DyTcv/pP4dkm7NohMJwa4cr/CcAkBepjQxeckVVsvRXloA05jh/htXLYq42TnauRUt0Ud1GqfB+dI4vp9ONDRwKBuxxkNVk7ueO4y+llsdrGqV4Na4Ih/pu9mnPOSuWopnpjJF325hxihO7Oj6+2CJFdLVDGAU3rfnsXzfN4kXX2RnYmtfI1v71yBynQqNGnyZ7PUZVauhSvPvv6IPSOCMTnuBDewVZNIfbjS7wOGHKoB7h2CHLW9pog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(2616005)(83380400001)(6486002)(2906002)(5660300002)(478600001)(8936002)(66946007)(4326008)(66476007)(66556008)(110136005)(8676002)(41300700001)(53546011)(6506007)(6512007)(31696002)(86362001)(316002)(36756003)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3hBUVlHYWZvZ0FNSDNOU0daSlR5MExabHdETVBiWGt2a0FwNUVaaVV3ZkxP?=
 =?utf-8?B?UVphYVhIWVA0K3NCTFpYWUY3TWtkUUJhelNGb0szR1ExS0xsZ1ErbjNMOHAx?=
 =?utf-8?B?QzlwczNxMUkwYjFGdzIxVzZXeFMyVnFYS2dhdGZKQXNUMkRGWmd2SEtqRG5u?=
 =?utf-8?B?cEhsRmk1UG13a3BpZEc4TDJ3SVJTWUJFSzZOc2RRWkpCOHZjS29qeTZHQTJU?=
 =?utf-8?B?WFcxbkVySllYci9OZ0F5VUtMOHYyRklEVjhrMjFNMDcyZUtQSDg4a3FkYTFD?=
 =?utf-8?B?QXR2RFlUZlFqdXpuemt0MlFJdGoxdTBGK3VERWFNRUdNSHpYR1dSVXE0enQr?=
 =?utf-8?B?SFhVSUN0a080L1JMNlExQWZmY3NnSk9NVHRVczdQOC93c1F3bTBFQ0wzQzB5?=
 =?utf-8?B?TDhCcVBXK0ZwajdKd1I4U1JkUytvQnp5VVRVdjB3QysxaWhSVW5yZ0RlWUs3?=
 =?utf-8?B?N2kvNUh4U2IvY2IydnlNTWNrMDF3OEZ0VGt4UHVHdTVycHZDTGxYNmdEekVS?=
 =?utf-8?B?N1ZkMWFTQlh5WG9HcVF1QVpucHpzd3dzYU9neTFGdWJRWkpUQ2c0RE93dW1q?=
 =?utf-8?B?QzRRa2UrZm42QVFEYVN6MmM5bytSZC9uaU9pcHlITEtrdVNUK2dXc24xWlV2?=
 =?utf-8?B?YVppazZMZ1U3RDhWTjlweFBIRmNIOWFlS0tpYzlIMjJqZGp1ZmtzYnhBMUdu?=
 =?utf-8?B?Q2R2cGVkNXpKaStsQkxObnZVcC83VUwrUm95bEpxK1NwNTMxdE9JYXZQNE5I?=
 =?utf-8?B?VTJDdWJGRG1PMHVzL3BNZEhUR05CNXg0Z2haa3lGVWNqNGNOMEloSGY1WVFB?=
 =?utf-8?B?VnJTSjFnaDFpeDF1dnMyUm5WYm9UNnIrdHBsT1Z2Z1VkOXNCOVV5Ykx5K3Vr?=
 =?utf-8?B?OFNjRnoxL3NMV1ZBcS9yV29lb3RaOUcvRnloWTVVQkE0NG1QQ29TOEFZVGNB?=
 =?utf-8?B?V2R4TStZYStRN21CcUJPMGJRbFRaRkdLR3ZmM3dldStoUnR1S21LeG1WNWtF?=
 =?utf-8?B?bTNHVWg0T2x5eVplSnYwTFNIRVdwYzhFem1vaS9JdnVLRDVGQ0kxQmZvRjQy?=
 =?utf-8?B?WTZha1VhOFVpZEJyWlRlb3JXdTBKTG5MOGlpTzdBaCswUXlMM2ZwbE1EbnJt?=
 =?utf-8?B?SThxV1UwdUgxYnByelBoa1ppb05DTFpDODVpNXNnMFZQSmN3WFh3ZHRpUHQx?=
 =?utf-8?B?NW5IR25mRVN6SlJMRGpOUmdZaG9ibk9XRE0zdVJ0dS9Eb2ZTeGV1RXlZSTlX?=
 =?utf-8?B?bWN4UWFhLzBYVjBKU3MrRVNIUENMa3o3R1ZBcTVuSndGV1htcEk5eld1ODhK?=
 =?utf-8?B?U0Y3ME5TVEhJRDA1b20zNnYyUkpXeGFiRlNyd1lGakN2SlUwemdNTXVYUUVR?=
 =?utf-8?B?MEJKQ04rM0Nnc044UmF3WG1WbHMxSWVqU0YxSlZjMUVNRDlsZVQrR0o1TEIr?=
 =?utf-8?B?TmF5anUyempLdEwyMHYyTmlPbGFlWDQ1VEg3V3U5N3hiYlJocUFySVBVcjZB?=
 =?utf-8?B?VDBMSUFoRU13T3lYQ0xVQWRnU21EUGkrNFRQRVhSZXdBbVVhbGJ0S0JNajJq?=
 =?utf-8?B?TktaWUZoaUlsS2FEZmE0NEFPS3NTSTZhRXJ2ZU01YWZSV01Yc2RGOTdxMWpB?=
 =?utf-8?B?NUsrMFowaGFJTkcyblJWWEdpaVM3c0ZKalk3ZFUwei84TzR1RWZ2bmNSR2dE?=
 =?utf-8?B?S3k2bFJqVk0wbFdBRzBSZUFnQlh5K0lmMklBVENoUVI0UytTWmhnTFU4eEVk?=
 =?utf-8?B?dTVsaGhIckVMNDVWbmorZEk2a2dPREt0b0trTllOcWcyeUNDSjIwQVkvRC9S?=
 =?utf-8?B?MUswKzd6VWxzTDB3M0J4RS9sTVNGRWxvVk1pcWE4TWlQRjI0Z0JOaDJKTko3?=
 =?utf-8?B?NWgycUJNREFHbURFekZLSlhqUzEzMXBtMjcwQ1NBMlhzbFdaSnBneUhZNVQr?=
 =?utf-8?B?S0c5MnZaNjVSQ2VSMFpyTFEzTk91QWhrTkNLdHdYYkNBbFRIQlhxdGZnUGQv?=
 =?utf-8?B?d0RyZmRtVHduTDJheFM2a21yc1crNFZzVWFqZmJYa3lINTU2V01nZnkrSTE4?=
 =?utf-8?B?YzljNERrRjhVZGo3NmphWC9ZYnc2WVNrK2Z1M05CRGlLa0lXVW1jYzlPQ2E4?=
 =?utf-8?B?Z2cwRGoxcGdsQzl6UUI0VDFkWVdMd21MajlVMU92RG5TZmdGQnNNSHZVQlI0?=
 =?utf-8?B?Wnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 7j8TfJib2NpbWKLNG+lBm0Eq0/uSTA/qW4aprEy0a36wKz8hdrKSDmL922fj0PLINhYcg69klsbdjwu8HcfpjUeiMxzaS9l/kNDEwn7Cwz9bpfyDIJqWMKPAi8uP69ifOoip9jkTcN2m/2gylPolO7oWNZDm2/T8N9JgWjXDANwggqWL3Q5kwUqUUOtLC+MmhncFlCUdAXiRqXVgwrdiZ+Swf01QaEftLZomBSUTodxTB0KtCSSe0afVvCZ5WG4Nm8B7HErNX0DJyP6wmpHjvt5GYhzdP9JZ4gDTJa4gUKjNTl8T530tLBg2VS8PHJm01uEOWxdn0eaeUJDde2mZ9MuEP6zepRrkJzSBOpsFwV9i0TMVufLsop+YWTVG8DaD4NEe7as6nXYfvvBPQ8Ub++SlCyDB0DYlcBpX9pINL5MowIfJGbbJ6WnVoOAmBdR2Ye1RDYBTV7+bUw6rBaENhHuGbA+3tEpi8mVtgdVKFnuTBJtmHiLVBuYcNpmRSB1IVe8m/4At/4UQVs8sGv8TshPGnIYpYDKNqJWg4MOPXDSBq70TdTh7SpdjhbntVroC5tc6BG6IYYV26Jr2QZ7GU/WUU82ZBuKU6qdISTxmur6NgWmMhS7k2jbXr2WfZCTuSqeLMUC70mQRdy0D4I9TSDx62hhqGikmgZMNDKnN9KCIWw4JbGxopyC5y/C7g2LYEhj5iMAIWwTtrqXOlwk/fBpqV48OobxYB50piR9PuDwj0TKPcFZJmG3GTXFk1DslkOewCJ3q0oeerT9N8rdeBQqLdIISSk/whKx7QjkVI18HL4j5YDSjySVDvs8/XfjghKPrAjvTPcJ9VKSTMvCiQA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dea59e1-9c34-474f-a09a-08dbe55b5612
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 21:47:45.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPvWabgRpmNyAUZ6MuX2DtPJJiQcCgvwyNKilsfwIFuNhOiv1VBdB9EfmPc1Ga4F0bN0JPyxotkJOvXeRKWnkQIBC4fRquzIk1lyNSaZ5YA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_22,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140160
X-Proofpoint-GUID: Iacjf3WzeH8Uytht52DPZx6VsO1lDoya
X-Proofpoint-ORIG-GUID: Iacjf3WzeH8Uytht52DPZx6VsO1lDoya
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/23 3:23 PM, Mike Christie wrote:
> On 10/15/23 9:03 PM, Wenchao Hao wrote:
>> shost_for_each_device() would skip devices which is in progress of
>> removing, so scsi_run_queue() for these devices would be skipped in
>> scsi_run_host_queues() after blocking hosts' IO.
>>
>> IO hang would be caused if return true when state is SDEV_CANCEL with
>> following order:
>>
>> T1:					    T2:scsi_error_handler
>> __scsi_remove_device()
>>   scsi_device_set_state(sdev, SDEV_CANCEL)
>>   ...
>>   sd_remove()
>>   del_gendisk()
>>   blk_mq_freeze_queue_wait()
>>   					    scsi_eh_flush_done_q()
>> 					      scsi_queue_insert(scmd,...)
>>
>> scsi_queue_insert() would not kick device's queue since commit
>> 8b566edbdbfb ("scsi: core: Only kick the requeue list if necessary")
>>
>> After scsi_unjam_host(), the scsi error handler would call
>> scsi_run_host_queues() to trigger run queue for devices, while it
>> would not run queue for devices which is in progress of removing
>> because shost_for_each_device() would skip them.
>>
>> So the requests added to these queues would not be handled any more,
>> and the removing device process would hang too.
>>
>> Fix this issue by using shost_for_each_device_include_deleted() in
>> scsi_run_host_queues() to trigger a run queue for devices in removing.
>>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>> ---
>>  drivers/scsi/scsi_lib.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
>> index 195ca80667d0..40f407ffd26f 100644
>> --- a/drivers/scsi/scsi_lib.c
>> +++ b/drivers/scsi/scsi_lib.c
>> @@ -466,7 +466,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
>>  {
>>  	struct scsi_device *sdev;
>>  
>> -	shost_for_each_device(sdev, shost)
>> +	shost_for_each_device_include_deleted(sdev, shost)
>>  		scsi_run_queue(sdev->request_queue);
> 
> What happens if there were no commands for the device that
> was destroyed and we race with this code and device deletion?
> 
> So thread1 has set the device state tp SDEV_DEL and has finished
> blk_mq_destroy_queue because there were no commands running.
> 
> The above eh thread, then is calling:
> 
> scsi_run_queue -> blk_mq_kick_requeue_list
> 
> and that queues the requeue work.
> 
> blk_mq_destroy_queue had done blk_mq_cancel_work_sync but
> blk_mq_kick_requeue_list just added it back on the kblockd_workqueue.
> 
> When __scsi_iterate_devices does scsi_device_put it would call
> scsi_device_dev_release and call blk_put_queue which frees the
> request_queue while it's requeue work might still be queued on
> kblockd_workqueue.
> 

Oh yeah, for your other lun/target reset patches were you trying to
do something where you have a list for each scsi_device or a list of
scsi_devices that needed error handler work? If so, maybe break that
part out and use it here first.

You can then just loop over the list of devices that needed work and
start those above.
