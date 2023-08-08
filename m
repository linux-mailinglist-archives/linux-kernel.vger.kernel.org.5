Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2885177461D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjHHSxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231405AbjHHSw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:52:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B87D15791F;
        Tue,  8 Aug 2023 10:07:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378DASCg023300;
        Tue, 8 Aug 2023 15:20:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kLKUkvI7vDxW5eM1jTFfv8vrjwu01q66RXOC4CQd5Z0=;
 b=Azl973nw0OAJG7+0+TvWFsDY14E78AyHgAxT6rMDilySU35BWc6+aZSeQQ+WpEhghnMU
 E32b0vNXJ9Y8l0QY9aRJEQ1Y3uEfi/abj5fz9Fgy1U15Rst3Q29LT3DFZaLFZiRyPbZZ
 znpPwROHDZD5+/664stFdqk6Dn2FMoimGW5c0suk7ekuRGbSLRSIfcQYYL5CQ39dcBYr
 +vbgn/w+j/AYrqkrDS0UDY9XtjlEiMXc4XAecc0jhUE0FIL3HBB1aRmnsyurUQS/XXCn
 8b4t9/8BNCNPoiAX3+RLi2IwJVeihwdA+Et/p4LKrTtMp//1UB++SH/Jl4XTYaYZM0LH 7w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s9d12dg81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 15:20:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 378EIsxC022965;
        Tue, 8 Aug 2023 15:20:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cv66mmd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Aug 2023 15:20:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xqjms9I+ZHuZ2NTaQSe3U0HqW6d1ZT/VGlwGasWOlBjzHl3Y5KR6GTBFfSXYpCqnsJUQBS6oKsHza67K2jizdokWFy2jBALyTl5h5bvGiBZ1QqZVE4e1O0hObtevW+BNYvdE/3YKbrrW0GV+xwqed6Hf3t6gAFz9R0j9ALCxws/41oFgAAt2fYz+pmv7RS4ncXVgnAUjGjyUBDVEU7WuCY0Jy8Ci6oMim6ZwxFMLgVEEemxav973ZGWJf6zUTeoUFxLWlMLE0GTUSRWoqW4Y0ma4OgMy2K0C+3SQor3bprI+wUx3qAaaQzWi9GfUr/cfsuDfTAdqZe0Muf0CVHYhOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLKUkvI7vDxW5eM1jTFfv8vrjwu01q66RXOC4CQd5Z0=;
 b=l9q6VrozUo7b4fzFEXlEgT25jl2HMndl2m8KS0js3cna7YctWAwkh6p6qduEDUQDBV++w3ftbHfe5vU1vHXW30aV7QtgKR4RthIlx5wTVJQ5zQPfKQKiJGK5YgsgwJ14oEQKlnbIer51mfiHXdrj7n5aRJfK3+SkXAd6tTUV4oVdfgZrF1HQLpCBlB6qAJYEnX8IYZTEf3DVm7ldN0BhEjDVZ3iWAFvLZXoYAhUZ30Xo8zEbqYiIfaGaIiC5a+vrBNGRPInnEp1qmV6x254JTNzKusS3DV+MxGvHn2GvhN6Vn147yt2RgPxmYIAcCPR0DVY6D31bnE7IMzIJWz1CZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLKUkvI7vDxW5eM1jTFfv8vrjwu01q66RXOC4CQd5Z0=;
 b=sIrscU5QQX1hfwBR1WU39foN+voDf+hCsW/zYUF15xosuQsXGjsQ46ezpqvZKV+qAF1kB8vRxaPCPxtijPtGJ27TuzKJnhG0ojD/A0xncW3opY/U+HNYoXhFr9w+YqxmI6viPafHWNk/cFwBLZA7rv1E8vQB0fQL0WVbcm3a6PE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB5729.namprd10.prod.outlook.com (2603:10b6:510:146::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Tue, 8 Aug
 2023 15:20:37 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::9a1:a343:e04c:5150%4]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 15:20:37 +0000
Message-ID: <7c71182b-f7f1-e14b-4c65-f2c78ca58d1c@oracle.com>
Date:   Tue, 8 Aug 2023 10:20:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: linux-next: build failure after merge of the mm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sourabh Jain <sourabhjain@linux.ibm.com>
References: <20230808144020.538cdab8@canb.auug.org.au>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <20230808144020.538cdab8@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:a03:167::23) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB5729:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c8f30b-277d-4c23-9f79-08db98230497
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jZUahkV+w0OYpHIJ8Y1m1yDuAo3WHEBHbGWV00JdIJAuUaFRNXvvYNNOh4uZHgczsMIxaj4uVEd7B2lRG7z1isLosKMDdIdupTfdL+wrl1X3sek1SiEil9hVvC4dX5gFg5U0vZlE8vlR03musTCgcUKEPEGY6PFTLFtylnB7EmHsulk+Sfz1Bu6VOASqmn7v8LDli93rVQj89+MpsrivozCFC97q0vZHfCvyAoO7xmG0TB2ig4aiflPdObbcn9EVNY8QQKLT1oSCvfHZrR3genUXMLkhEdzrE7qAyC+2RDy5po3eC0oynVNs0pPPzg2nXUrZHEhVkIFw8bLU+RVf1p9a8KDGk0cK/R3BuRCP9zTpLPBuw2zE9jjJiSTi5MhiAML/wyzFePhi/5/aRPjg6s5gOHkzLiIBZ/u4ZgSWmzKE3nLxW8KqLPEXqXr0o6LaMuWUhht5Y3CxpVxtfE5hM/HMwRCOSnK5dQYrMYJqe06Qrnic7ZQtwkfsdM+KvPf9x4vBrAIMI06dFEnU23jPGCBdIX5pXKBlqTyirrNl3f4u5VkU5It8SIWdiZwLo8fStz4bfVPHE8gMqYI26hjkYVmphhYepWRalebUrPLcJkqFrw4hM2QVqX5EloXH4AmNwm7AR3hwUxxOMq3UXuWAsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(346002)(376002)(136003)(186006)(1800799003)(451199021)(6666004)(83380400001)(31686004)(2616005)(54906003)(4326008)(110136005)(8936002)(316002)(8676002)(5660300002)(66476007)(66556008)(66946007)(38100700002)(478600001)(31696002)(6486002)(86362001)(2906002)(6512007)(41300700001)(6506007)(36756003)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M092RWFTTS8xYzBUZGxTMzJnVFVuS1NjL1BpRHZTakhCcEgzOXE3cVorZzN3?=
 =?utf-8?B?Q3VKaHNXb0JhazJOTTRQTjY4YkQrSExGNTZZNkd5UXVGLzZZazhtaTJzN2ZD?=
 =?utf-8?B?cFR2c3I3aDlsd2xSekxaVmxNb1ljR3pRcC9CN3pVYjVJaDFDdUNhdW9TSjUr?=
 =?utf-8?B?Qmd4MzdGV2ltSHMwSXBZOHIyS1I2UGpObnpqdnFYZDN4M0kzdThpVVhnRDVR?=
 =?utf-8?B?OVZYV1A3NjN3MkpIVWFaVytyWmx4ZU9MUUkzeXYvVERwa1R5Ky9wMVNyWWVP?=
 =?utf-8?B?bllEMmJjZFJOMXdkR25YdFFOMnByK0ZuUjRyb2dnc3NHVFB3SFFBU2pGekd3?=
 =?utf-8?B?VXFBNjhwYUZkOHRSejlSS3kvZHJWZis5YW5JeHZyTmkyRFFUNVNwQkI2dnho?=
 =?utf-8?B?MEljL2xYVjkxd1dPNG1ZUFg4QnZsVElLTFplanRxTWFaUE9UQ1hQTjFNZGgw?=
 =?utf-8?B?Tm1NdUsySCsxay9YbytydEFDTnNUdmJnMDVSbHFJZkJHRHpkR1ZGTXV1Y1RQ?=
 =?utf-8?B?SXY0MndGS28xRnFDZy9TZEltcFhLeHRvTnV5ZHFWeldmeG1ZUXl4TFUrR0VO?=
 =?utf-8?B?QmZBNktCNUFQUEFVbS9BMUJXQWZWTEJtV2RFcFFnS0I4czk0aFpIRStnbGZC?=
 =?utf-8?B?aTNYbWJZSm5NY3p0NUlndkxVQkM1MzE4ZjQyQ0crcWJHYXZ1Y1poTkV2TTdX?=
 =?utf-8?B?QTdQTHlyR2NCMTJmRVFqcjF1YzFUNzV6aHZQSHpNZE9qc1RXVTlGT053WEVY?=
 =?utf-8?B?a01JVU13dUtlYmZQQWVhSlZhc0tneDJySVd4RXdpZzNQbnB0YmoyaXQyOVZj?=
 =?utf-8?B?dzNPWSttRjFIcndlRUtMUWV2TlhGMmNONFI0T2QwcjkxVXgxdnFHazJodzkr?=
 =?utf-8?B?MFZaNmxBbGYvVmQvMnVXc3U2YllrSmtyaTlGaWFTOWx5M0hwcFljZ0VZYjhD?=
 =?utf-8?B?UnlpQXpCRHpvaVREMHo3dno0RFBxMzFiWUlBTm5UNmQ1R1NNaWczeWxlbmRx?=
 =?utf-8?B?bHdXYVF6bmxEcGFtNVRqazJJWjByN0FEOXkveTBCSG54ZWZTMG5EcEUvbjhr?=
 =?utf-8?B?QytsdnBuR2t4dG9KUDRsTE9VcElISTAxKzcxR1R0YVFJQ3lKWmtVdXdRekNR?=
 =?utf-8?B?dzdibkhKOHdyQWhSOW02UkI1V2NINnVBVTU0ZmhYSlBEc2l2Rkg4dUQwQ0Zk?=
 =?utf-8?B?U08zeWtOM0diMHpHbTVudUtsakl1K1lzdkxpd2pWOW12SVlkZ01zRVVJMGUv?=
 =?utf-8?B?Sk1kc25ndVZVQXlDVHBGZkFNdVcyWnMwZ1dLbjdlV2lwaUJhVmsxbDFtRGJY?=
 =?utf-8?B?akZOZ2hESFlES1JydDJJUjBVbHhhbnFTYzcrUi9Mdk9CTmJjNG1RbzduZnFR?=
 =?utf-8?B?UEdaZXBTY09IMGV1ekVocm5hQmtGUXpaWm9ENk9SbG5PUkJVdTZPeGRMN0Ir?=
 =?utf-8?B?QXpROEZCcSthQlVFUjFDTkRZYStDU1MwTC8rNjVzWGVXaWxJMUFLOUQzcmY3?=
 =?utf-8?B?RWlrMzVYNXZUZWlLUGxPWkxMZjgrVmgvYlppYjRndHVib0FpKzhucTdWTzdm?=
 =?utf-8?B?aVJsS2FyVGoyRThjVjAyWkMyWm9KVDhuUU41L0REQkkzMStBSFFIYk9tblRn?=
 =?utf-8?B?VWxEWDNsamRGSzY3bCtVVXl0WGg5dVFkdEExU09GbWQvVUl4UmZrQ0hSY2NP?=
 =?utf-8?B?Mk95dW04Wk16ZUVXcGlva0tVRytxTmVub09xcGZnUnFrWW1yWVRZc01jMXBq?=
 =?utf-8?B?Q2k0RWVCaUI0MHhvSDdNUlkwaHBmVER3OUtmNWp2Wlo0SmxuU0hmUmlXUHRJ?=
 =?utf-8?B?WUhXL0t5WkRmOU1yOTBWMUM3cmx6SVFUUXhTUGZlbWFqVjlKdU5pOW1LeElU?=
 =?utf-8?B?RGQ4UndvZldMY28zYnBBL3lhOWR0c2tRcDZQQjZtNEFFN2lpMWpQQlVSK1pM?=
 =?utf-8?B?dlBnNUNTcXVZR3AvRWFCRTI1YjlKYkp1aHQvK3ZFYVk1WTJUSVJhT1B6WmFq?=
 =?utf-8?B?ZVlYUFpDdm4xejhBaWp0enBQNnNFMlBwVTJ1YTBTbGhXY3UwYkJzK3Frdyth?=
 =?utf-8?B?Y0k3dHZHMFVSeXRKUnRNZ0VCc3VYR0t3akFvaTlkQW1vNXJNdmFmQmdOODB5?=
 =?utf-8?B?TGJodk5td0NvVFNzWFJsczltb2gwMjYzbFhWTjBvQUJXbEliTVFzV0pZNEpJ?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +kq7+a0Y+dWtqdCTMnXLCy8zIl9KsWQYl/6U/+/1cLSFCbhmkZjFxmkd+ysILLG0XrNOxGCChUWuHdWWK5VV+4FxdyZFZdTgD6v7uFex6FtLl7lHLHhwnIMwowusorhSnL1URMzatVV1oJfyLHGFoQz3mQTtfzYWkH+3ZW/UDI7o+3E9Id4aQiKM23+PZJiRqDSaP7VjaCiPd5oF2sStPOZENgTBjKmrZpr6/CjzPfjSoxhb2IEo6rJ1hSCx0ng5YXpTBHayHB7tAQEdtZz2rZaXgDwA6cXgRn261wpRzkbStxG9n41U/IStSYCTajBz/IFS3YQz3fX7un8D+hGFnoI2rQN2wqxqVFwdnAK7HORV5oipqoG3SovLGPFsXqovsknEQcDqAmkxoo1Kef46EuYfgjHT+C95jYdb6ToP64NJfNUNqJ/RGdUMs5Xs5DIflyroCh0ukHsFs5F4td6knBqavKCmcm1HhBeOi0/KiidUb4RuSPeazGHq6cO9lRpra5l5aiVEuFL1MaJ4m8eVJp2tL5MWznLVHclASE+vLsdp7BsN8ubVcAqQvyTQpPU8HP7GVmsJKKIijplz28F7kaeX6D8+KzuqCjLr0JHSM20gpqhY4TPFZxMBmQsZLcuDBhFMkU3cbDSeo+EHQmT9Es+0GxFM/XIeusuFEN/0+RVO+DMGExmKypstzxCfezKJLQtgpZrUL0XrxU4kBXhvj2AcpHKYeh5JOau0Uq15Dm9Y7EShwu9HzOJydn0T0gbUtrpYFigx3+WLOGC3TCM0GUq+jr56gycsLvR+Cap1UXJydRD9anVSb1bw5SRAbrtfPiNHsYMGNfGoBoeNxvSH2DeS7CzvE4uNVnRDa+/DRB5aqghz3XaVbVSlUa1rhagF3N1Z2pQHAZOonrrtXTQzkg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c8f30b-277d-4c23-9f79-08db98230497
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 15:20:37.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLKsFGaTKYWWbV7gHZRUluNy5DjDwidfmctiYMR5B86XGhHM62JQMYSn/QnzLaNPPIQ+Mf9z/ezMNFD3nZwq6EmZ2pHYQ2V78Omnsb+Y6xY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_13,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080138
X-Proofpoint-GUID: 5q2Qzru8me4WtKthnzLZlxnHri51-5tw
X-Proofpoint-ORIG-GUID: 5q2Qzru8me4WtKthnzLZlxnHri51-5tw
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking at this, turns out PROC_KCORE selects CRASH_CORE, which according to the original config 
settings, does not pickup KEXEC_CORE. So I'm looking at closing that gap.
eric

On 8/7/23 23:40, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
> 
> In file included from kernel/crash_core.c:23:
> kernel/kexec_internal.h:11:54: warning: 'struct kexec_segment' declared inside parameter list will not be visible outside of this definition or declaration
>     11 | int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
>        |                                                      ^~~~~~~~~~~~~
> kernel/crash_core.c:321:40: warning: 'struct crash_mem' declared inside parameter list will not be visible outside of this definition or declaration
>    321 | int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>        |                                        ^~~~~~~~~
> kernel/crash_core.c: In function 'crash_prepare_elf64_headers':
> kernel/crash_core.c:334:23: error: invalid use of undefined type 'struct crash_mem'
>    334 |         nr_phdr += mem->nr_ranges;
>        |                       ^~
> In file included from include/vdso/const.h:5,
>                   from include/linux/const.h:4,
>                   from include/linux/bits.h:5,
>                   from include/linux/ratelimit_types.h:5,
>                   from include/linux/printk.h:9,
>                   from include/asm-generic/bug.h:22,
>                   from arch/powerpc/include/asm/bug.h:116,
>                   from include/linux/bug.h:5,
>                   from arch/powerpc/include/asm/cmpxchg.h:8,
>                   from arch/powerpc/include/asm/atomic.h:11,
>                   from include/linux/atomic.h:7,
>                   from include/linux/mm_types_task.h:13,
>                   from include/linux/mm_types.h:5,
>                   from include/linux/buildid.h:5,
>                   from kernel/crash_core.c:7:
> kernel/crash_core.c:346:32: error: 'ELF_CORE_HEADER_ALIGN' undeclared (first use in this function)
>    346 |         elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>        |                                ^~~~~~~~~~~~~~~~~~~~~
> include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
>     32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
>        |                                                  ^~~~
> include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
>      8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
>        |                                 ^~~~~~~~~~~~~~
> kernel/crash_core.c:346:18: note: in expansion of macro 'ALIGN'
>    346 |         elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>        |                  ^~~~~
> kernel/crash_core.c:346:32: note: each undeclared identifier is reported only once for each function it appears in
>    346 |         elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>        |                                ^~~~~~~~~~~~~~~~~~~~~
> include/uapi/linux/const.h:32:50: note: in definition of macro '__ALIGN_KERNEL_MASK'
>     32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
>        |                                                  ^~~~
> include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
>      8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
>        |                                 ^~~~~~~~~~~~~~
> kernel/crash_core.c:346:18: note: in expansion of macro 'ALIGN'
>    346 |         elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
>        |                  ^~~~~
> kernel/crash_core.c:396:28: error: invalid use of undefined type 'struct crash_mem'
>    396 |         for (i = 0; i < mem->nr_ranges; i++) {
>        |                            ^~
> kernel/crash_core.c:397:29: error: invalid use of undefined type 'struct crash_mem'
>    397 |                 mstart = mem->ranges[i].start;
>        |                             ^~
> kernel/crash_core.c:398:27: error: invalid use of undefined type 'struct crash_mem'
>    398 |                 mend = mem->ranges[i].end;
>        |                           ^~
> kernel/crash_core.c: At top level:
> kernel/crash_core.c:420:36: warning: 'struct crash_mem' declared inside parameter list will not be visible outside of this definition or declaration
>    420 | int crash_exclude_mem_range(struct crash_mem *mem,
>        |                                    ^~~~~~~~~
> kernel/crash_core.c: In function 'crash_exclude_mem_range':
> kernel/crash_core.c:427:28: error: invalid use of undefined type 'struct crash_mem'
>    427 |         for (i = 0; i < mem->nr_ranges; i++) {
>        |                            ^~
> kernel/crash_core.c:428:28: error: invalid use of undefined type 'struct crash_mem'
>    428 |                 start = mem->ranges[i].start;
>        |                            ^~
> kernel/crash_core.c:429:26: error: invalid use of undefined type 'struct crash_mem'
>    429 |                 end = mem->ranges[i].end;
>        |                          ^~
> kernel/crash_core.c:444:28: error: invalid use of undefined type 'struct crash_mem'
>    444 |                         mem->ranges[i].start = 0;
>        |                            ^~
> kernel/crash_core.c:445:28: error: invalid use of undefined type 'struct crash_mem'
>    445 |                         mem->ranges[i].end = 0;
>        |                            ^~
> kernel/crash_core.c:446:36: error: invalid use of undefined type 'struct crash_mem'
>    446 |                         if (i < mem->nr_ranges - 1) {
>        |                                    ^~
> kernel/crash_core.c:448:52: error: invalid use of undefined type 'struct crash_mem'
>    448 |                                 for (j = i; j < mem->nr_ranges - 1; j++) {
>        |                                                    ^~
> kernel/crash_core.c:449:44: error: invalid use of undefined type 'struct crash_mem'
>    449 |                                         mem->ranges[j].start =
>        |                                            ^~
> kernel/crash_core.c:450:52: error: invalid use of undefined type 'struct crash_mem'
>    450 |                                                 mem->ranges[j+1].start;
>        |                                                    ^~
> kernel/crash_core.c:451:44: error: invalid use of undefined type 'struct crash_mem'
>    451 |                                         mem->ranges[j].end =
>        |                                            ^~
> kernel/crash_core.c:452:60: error: invalid use of undefined type 'struct crash_mem'
>    452 |                                                         mem->ranges[j+1].end;
>        |                                                            ^~
> kernel/crash_core.c:461:36: error: invalid use of undefined type 'struct crash_mem'
>    461 |                                 mem->nr_ranges--;
>        |                                    ^~
> kernel/crash_core.c:464:28: error: invalid use of undefined type 'struct crash_mem'
>    464 |                         mem->nr_ranges--;
>        |                            ^~
> kernel/crash_core.c:470:28: error: invalid use of undefined type 'struct crash_mem'
>    470 |                         mem->ranges[i].end = p_start - 1;
>        |                            ^~
> kernel/crash_core.c:474:28: error: invalid use of undefined type 'struct crash_mem'
>    474 |                         mem->ranges[i].end = p_start - 1;
>        |                            ^~
> kernel/crash_core.c:476:28: error: invalid use of undefined type 'struct crash_mem'
>    476 |                         mem->ranges[i].start = p_end + 1;
>        |                            ^~
> kernel/crash_core.c:485:21: error: invalid use of undefined type 'struct crash_mem'
>    485 |         if (i == mem->max_nr_ranges - 1)
>        |                     ^~
> kernel/crash_core.c:490:20: error: invalid use of undefined type 'struct crash_mem'
>    490 |         if (j < mem->nr_ranges) {
>        |                    ^~
> kernel/crash_core.c:492:29: error: invalid use of undefined type 'struct crash_mem'
>    492 |                 for (i = mem->nr_ranges - 1; i >= j; i--)
>        |                             ^~
> kernel/crash_core.c:493:28: error: invalid use of undefined type 'struct crash_mem'
>    493 |                         mem->ranges[i + 1] = mem->ranges[i];
>        |                            ^~
> kernel/crash_core.c:493:49: error: invalid use of undefined type 'struct crash_mem'
>    493 |                         mem->ranges[i + 1] = mem->ranges[i];
>        |                                                 ^~
> kernel/crash_core.c:496:12: error: invalid use of undefined type 'struct crash_mem'
>    496 |         mem->ranges[j].start = temp_range.start;
>        |            ^~
> kernel/crash_core.c:497:12: error: invalid use of undefined type 'struct crash_mem'
>    497 |         mem->ranges[j].end = temp_range.end;
>        |            ^~
> kernel/crash_core.c:498:12: error: invalid use of undefined type 'struct crash_mem'
>    498 |         mem->nr_ranges++;
>        |            ^~
> 
> I am not sure exactly which commit caused but I have revreted these
> for today:
> 
>    6a41fd4665e6 ("x86/crash: optimize CPU changes")
>    add3b7e011e9 ("crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()")
>    4a7eed40a7bc ("crash: hotplug support for kexec_load()")
>    8ce41bc6b147 ("x86/crash: add x86 crash hotplug support")
>    2b765af0c14f ("crash: memory and CPU hotplug sysfs attributes")
>    36d2b573329b ("kexec: exclude elfcorehdr from the segment digest")
>    ccfe0040500f ("crash: add generic infrastructure for crash hotplug support")
>    626775922a57 ("crash: move a few code bits to setup support of crash hotplug")
> 
