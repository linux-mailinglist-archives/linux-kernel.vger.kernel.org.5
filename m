Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0A7D4ED0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 13:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjJXLa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 07:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjJXLax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 07:30:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C144128
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 04:30:51 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39OAl8U6010553;
        Tue, 24 Oct 2023 11:30:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=OwSj7Qav/5Tv6gRXezjSI4lFV8gLW3rIn3cc60z7BhE=;
 b=oRykua3OqMwW0+TAHGdTnikIbnPV8vJxP7aQgQloKNTXdbVc4nUvoi8j3ZSFyto9NXEz
 NZeuhlMqBwH3AFH45LxbmVtx9BpcpZk5k5l3fdfKNwccI5UsNAUQhxDJyUHlw4ZNpgNQ
 KUepFfPJHaleMpWFZ0zxHsNL0uEJ1nfjhjzU027UFhzVC4gwJHB7guU8IGOUdIQHIeNu
 +PQZHQw4d1Isgva40bOZ8rtqHXCeJYEefhSndxzip7aPzbSQbP/ndGUQ2ReHIt1LSghz
 WdGmENR052mK1/J0xRtCwbRIRRs3ADG0UhVE+kGprQ8oRinYzcneO3GzDdYS8Rlu5t6Y Fg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tv52dw88e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 11:30:45 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39OAACVm034525;
        Tue, 24 Oct 2023 11:30:44 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3tv5354uxt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Oct 2023 11:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAPHxiJYL20WYEv1XuCOPRAK23k0tRjGzrbrcdW5PZUbO2c526YaFI1Fc5/iM1eIOUpc5CN+c+DxntnATqyF6NqDDLuZF8/EN7i4DPuKWGE90OwLhUS3t/vuxOP02ilcoONR5Lf8Z8c9HvFN3m4vOqm6tdUc1cpjDIt1CI2Okt426CgR/umeRczQaWsfWlEwlsvKnDItTb9w/6lny3bcdqI6V756jKRi7ZdRUE2a49yljdIdPLSSjqxbCmv9issC2nq5gSbfQ8ojAXyWCUi3XmxYvb/ciz/FN+H+kC8z0hj/g1ZQyQLIiABZbkCkaPMUK67sr5zAYuAQkHuc+X0erQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwSj7Qav/5Tv6gRXezjSI4lFV8gLW3rIn3cc60z7BhE=;
 b=kGVXgaXKhL+r5S2NMAI2RqqlRW3sWb8LzA2PrZPphUbcj0RZf4z9XE4QDpQvXziULPuJKk+BVq5yrXcqbOEoiWuDy6/KC0/w/4uzXex/zRUZh7nXRYoZB6dbdtTmIpiYeC7izNjeuEMAh+6EQ610RBq+Qp23rheyAh5C5CLonSKlWK2zcaZUW2bBk4UYb92JPtQsmTi/pSVL88D3dmrVzWt2DkZfgQGa14ydnVPyhTJcSXFgizNs6CvXX8lXygcW2FxJrRBE0S10tOqVOZsejtQBf+SFoQqQ10Snopa2v9VHIMxf8UVKNRvZO/SW73zliO0mdHC4i5RDs9HHEKIWIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwSj7Qav/5Tv6gRXezjSI4lFV8gLW3rIn3cc60z7BhE=;
 b=EwvhrwREbQWaRwYT+CbtbyCAK0xP9dFJbSoS8MI8JiCtixzrXgBqsgsEhIjJE6P1T3XvREHvZ6/oXNOVoR4zh0XOFUaDibtCPDABIvpwPMfKu9bBxq+tn2XovFovOJN0UFNhbfTcaAMC5uWv+5/7lNxAcKrbx9DVFA4NcIlJ15Q=
Received: from BLAPR10MB4835.namprd10.prod.outlook.com (2603:10b6:208:331::11)
 by SN7PR10MB6980.namprd10.prod.outlook.com (2603:10b6:806:34e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Tue, 24 Oct
 2023 11:30:42 +0000
Received: from BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac]) by BLAPR10MB4835.namprd10.prod.outlook.com
 ([fe80::c8c3:56ba:38d5:21ac%3]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 11:30:42 +0000
Message-ID: <ad4da3d6-c04a-4044-93ec-d5b59c35d7e1@oracle.com>
Date:   Tue, 24 Oct 2023 12:30:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include: uapi: linux: iommufd.h: fixed kernel-doc
 warnings
Content-Language: en-US
To:     Muhammad Muzammil <m.muzzammilashraf@gmail.com>, jgg@ziepe.ca,
        kevin.tian@intel.com
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20231023103852.28743-1-m.muzzammilashraf@gmail.com>
 <CAJHePoZzMagaTLdRqmisgKx5arvm_YujyefzeCku1=ETPHWLVw@mail.gmail.com>
From:   Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <CAJHePoZzMagaTLdRqmisgKx5arvm_YujyefzeCku1=ETPHWLVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0173.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::10) To BLAPR10MB4835.namprd10.prod.outlook.com
 (2603:10b6:208:331::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB4835:EE_|SN7PR10MB6980:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e6ae37-7892-4bf0-e8c4-08dbd484a7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o4h5KZenepD1xXIozZ90o8AsG/yF+oeDp5rwOk/JofQv4WtdHIoy5uRVkHq6Fl4I36i4m0TySzIcDT7/NmvrY+jjp++HHbzdT1/889TA4leajvcHsl0vU8mS6s60xGhCUTHIlsL6I4L3mxTkHr1vkAOtgoMirldtJZx449I5kqYszYLCxWFBD5j+FX2IVDyY8iFzTdrPHt41aX1DEFTxwhVR1cyfbTIoRZi7fIVTH2hop5jHo+9K6jeqlpWq38BudXOInlPNAs6XXzETLWmMiC0jyX+3Ghgaf7DmWgOMvNZ/CvYrn2kReN4OUTmPqbZh6ZcYWUVtlLYO3D/Hj6Ws36DChKNT/ljRGoDb1t6i2MzaWHmNegmcAaKxwbZxlyyqboaZF4w0s3cC5HJn+wbop46WqbbCRLP4Hv+BXrPdMrCJ6m5osq3PAx0a/fBAd11bqfwKkbZTMUj6kwg7oUpumwsweIxCw2dKxZCQpHgQJVZN1odAMBlOlGCQZwcGPjoBJC1tcR6QepEJj6VxBj+tajWh+bntidZDimzrEJey0Ec+UszGk1YKXlxSo/mL2urZo9eYIhds1jpxNJpVKwTTus0ocbmA2pp80QgbNnMSbmgv1srpk7jNNNGFCZqAuBiTEkxk43xoaJ3nnbVi9gIJXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB4835.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31696002)(2616005)(83380400001)(26005)(53546011)(6666004)(6512007)(6506007)(38100700002)(36756003)(86362001)(2906002)(966005)(41300700001)(6486002)(66946007)(478600001)(4326008)(8936002)(8676002)(66556008)(5660300002)(316002)(66476007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmwxUFg4M0Z0bEJHZ0VicnBRbDRhY0htNVRPaC9xeVpuUW82dUZoUjZnSDhQ?=
 =?utf-8?B?VHVqb1FrL241bGdEcG5GZ3NtNTA4a1dETm8zR0hXYXhEVnlMZ1MzNnE3QUc5?=
 =?utf-8?B?NE1xQjRDYnBWRStMVENNSUJKWnVEL3kzU2tMcitvMnFuQlp4eFp2TWJVeTFV?=
 =?utf-8?B?a25LREV4K2RPRXA5S2ZaYTFnTjhsNzZZZzhjSG5mMzhaZk8zUTR2V1NzZjJ6?=
 =?utf-8?B?M29adzY0MmdiMnBURDcvYWJxY0dCT0c3WVl5bWlVcU1OZ01GWVc0MlRFaVYx?=
 =?utf-8?B?Wm1HWlVmR3ZvUU9BazR4RDB2WndPUC84KzNRL1JzcFkyTXNSMVRxa2haS2Ru?=
 =?utf-8?B?Szl5b1Z4aUNLejVCSVpBdC8rT0d2NW9zZzdtaVpzVGZtbi9wNTJxY05mZC9D?=
 =?utf-8?B?YTEyWlgwelZITDg1T05aS081V0FxcS91bFZndFlnMTdnQ1hsUFZ2Y2hPV1dI?=
 =?utf-8?B?cTlyTFU1eW4yb3k1ZjBML3BTR25LQjZQVXRLcGh6aDZEWTJFczBmRVBnK1Ns?=
 =?utf-8?B?L2h5MmJNaWF0TnZ3K2VUdnFBMWU5MStNSzVqZWlCdndCenFwNVNmb3A1L09G?=
 =?utf-8?B?ZStJblUvQXVmZ2xyZUJ6cWV3KzdicjVMenN2amlOMFR3cVJTekVnZzh5YXVF?=
 =?utf-8?B?aWNiTWl0TVZza1haQXI0RU51SzRWSTlwK3ZPZGlrbGtxNlFsdVMvQkRlM29T?=
 =?utf-8?B?WmMwWXE0T2ZvaEd6UlpIVFUzLytidkpyV3U4ZTJ2M0pqNWxha3hBTklBSGk0?=
 =?utf-8?B?SDFnbHN4cU9yU0JyOHFuYTJ5ZjZXUkRvN1hPOWNkcXppOWpHdDI4YVZCNEJG?=
 =?utf-8?B?RnhpNS9md2RiWFBidFdlQ2U0Uzl0b0pLUXJESkRyUURHajV0RUw5SjQ3Ylky?=
 =?utf-8?B?SU4rNG8zNS9DZ3V3SlBjZHV5YStIODRsMDJsaHQ1TFJUVWdndW53dTVYUDVa?=
 =?utf-8?B?di81TnJwajFTV3ZHczhNT3hNOFBjZS8vRCtFY1VaRjA4WjlRTjVXVUxZYUZJ?=
 =?utf-8?B?U1ZFS3ByMU1HSCtFUnEwVGhPWkc5Z1FnSHpPNWlvcFNsUStEZVlxRnNXSWRZ?=
 =?utf-8?B?STh0S2RZT2ZsR2xJbTE3cDZvSElKd0QyUGJvaWNuNkFVdWVkZnpEa2Q5RGN3?=
 =?utf-8?B?RE1URkRHZnhjQVhwZE52NklaRVNWUUQ2MlhOZ0M1aXZHME1rTlJNN3BDSFhS?=
 =?utf-8?B?VHpxVC9YeENweExZdkxUa3Y2eXdYNUJCR1o5Z3NJYUdORFhJNHhHVFpvK1Ew?=
 =?utf-8?B?eXJuRm1hZExFZHFERmxuNGMwRWlBM2R0VkRNSDFicExlMWVldi92L0dqTXdl?=
 =?utf-8?B?MHBaWE1qQ2kxakZhOXJjSUUyMnNabnpUbEM2STQ1N1I3S1FsRzN4elRaNHNx?=
 =?utf-8?B?cWtCQytYOVpVZU9JRUxkR3UxcW8rV1lzdDNkaDVBNk5jK1RkUGs1eTF0SlVP?=
 =?utf-8?B?aGZuSmdibW1yaUVLcG1uTXFtd3dLZVdKVTQrOHhrbk44ZHZvWi9DVFREc0l2?=
 =?utf-8?B?UENDL1N6QlFwUmZpaXdxdll1VDdRelNIa0VONkhFaEtmM0NRU0tKKzc5Q0VX?=
 =?utf-8?B?Z3ExQzloYnp4ejV0ZjBPWnJPRWQwTGJ1UkM3MUpKaWpPOEU1ZWEvN2l5UCtT?=
 =?utf-8?B?SlZsT1p0bk5CbmJKRlhUK1RMN1QxRHJ2bVpOUUY2WFkyUkZ5amE2VGtuMDUz?=
 =?utf-8?B?OHM2WG5rcXBIcEQxbHB5aG90LzNCbzhiS2dnRGEvUTVDbmw0OC9JK0JkYW9n?=
 =?utf-8?B?alJ1UjdiSmVjc1ZYYnZLWjZhaUwrK245QkJVTzVLQTdiK2E0aHdaUDU4d0c3?=
 =?utf-8?B?b0JYclBEbWQ2Wlo2TWlGS0hrTjdoQ3VMMkg2STZWczErZFpLTGg3YUxkSVVx?=
 =?utf-8?B?ZUNRaG4xVFN5VHZlRm1jOXRnbElMcW1WVWVZbngrZXpzWXpMSDF4dTFEQUY4?=
 =?utf-8?B?NnNPdjdpOTNVa1dVeGdCc2h4RVBEdG5FWkNzVUwwVVRQZGxkTnNVd2FicXd4?=
 =?utf-8?B?KzVldXpMaUJoQ3RsV1IvcEpoOWNsQ2o3TEs2VnZhbFJsRzJUMDVpWHN0dkNW?=
 =?utf-8?B?dzZVVFdzOGJvS01PY0hvbXpVQllMQVRoUE84b216dUFWTllpQ2JkN0N0ZHNG?=
 =?utf-8?B?NmM3bnloQ0RjY1EwWWs1ck9UZk0rWm5jVEpvQjZyY1Fka1Npb0VoM3N5MG56?=
 =?utf-8?B?ZkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QOylWYLucqg1k+mR5nkAWcvb7Dqsy2q9Qe83grnGGOrmRTtN8x3X/IaTGG34tmDkAv/qjmL+WNbPsjUsEnGCRIpfCY9oh0ZfKip2sFRsKSOPM+oeXvae5kF4gSvMl2GY3YYRvZ9cDU0lKZYAKR49jZE15y6nDJNwlaSYfu/DrFEkjnYb0HYknJagKa8+QJdwOWrd6DYNvHy7rEDqLr7iGG9Zaq6DdPAR64DjE0rox++PBOW3G31h1AoiTyMgeYF5e674GtFvt+pP41wtVUg7Xpr7CkiTSGHEKCfd8nCOWrD3dSQuMqWo9NrnIPlLuJ/b7aXtggxtOS3+nZqw4VC+ueB8ukQg7tzQ4MefZS7QhFBTZPksQDW09BXOXNXqrpHtQ3q2ADk0JAWfQbkvj4bO4TbEoksvgIK1MDiVpvyvt8a9A3/8eFWo0xOh2GSXrSHssg91cqGgqEXfg3jKiKbScgvwwG7ffR9/f3fdnXTguLh8IHjZ25n+aoRJP+z/fSE1Y2g7A0HYrrS9Jix+qideWUqn8b7pyTwkwCFecR+9qwKEplZ9+Ky2jjExnr3MrYcTQQZZ2bHd80AHOXuWNN3e9hbxksCMja6w6WOEMvnW7Yfk1OdN7WxEAPMI4TnlSnoquov6tsI4j5D0IjL2Ep+eqqVpm/wnPP1tvfdBlvl0eVUaBpZoVlk8DJll6jwWyPTCqw8hQWNbbeiW8dnsVQFTP2hdLtDztJoAZ8tZqQI4F0wKrUQ1e/qUlscwUBzgt/INugSxLueLdHX3vLcb6p+/ANFncxl1Glbpq3VzecX4GgcOo4yNj7U9zCGh3bNWNSCTkXTp2zEFSXRu1NjbjOqApOhB20LLnSlclOzjw1fIU26CB/fYStXmmL6IZkI568B9
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e6ae37-7892-4bf0-e8c4-08dbd484a7c8
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB4835.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 11:30:42.0805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RiwA9ZQWhhKgHdRx2h9FcFHhM6v+9KgZQvulRkncblUih5RfDOIVqQQ7ShvHt8H5vXDZf79ppVZiC6KgR59YWsXWqk5TYwcNtnPcoCTR95c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6980
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-24_11,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310240097
X-Proofpoint-ORIG-GUID: iNayav4BxDORrQkff6DGgzml_OkpatNG
X-Proofpoint-GUID: iNayav4BxDORrQkff6DGgzml_OkpatNG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24/10/2023 10:48, Muhammad Muzammil wrote:
> Hi all,
> 
> Can anyone review and approve this patch?
> 

The series that introduced the errors will have it fixed in next version -- I
had fixed it myself when it was reported to me by linux-next integration.

It should hit soon (few hours) in the list (in time for tomorrow's linux-next
build) fixed but fixed in the individual patches that introduced the issue.
There are a couple more changes involved in such version fixing other issues,
hence it took a day more that I originally intended.

Another contributor submitted similar thing:

[1]
https://lore.kernel.org/linux-iommu/20231023085552.5139-1-bragathemanick0908@gmail.com/

> On Mon, Oct 23, 2023 at 3:39 PM Muhammad Muzammil
> <m.muzzammilashraf@gmail.com> wrote:
>>
>> Fixed multiple kernel-docs warnings
>>
>> Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
>> ---
>>  include/uapi/linux/iommufd.h | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
>> index 50f98f01fe10..2211f1b53d6e 100644
>> --- a/include/uapi/linux/iommufd.h
>> +++ b/include/uapi/linux/iommufd.h
>> @@ -419,7 +419,7 @@ enum iommu_hw_info_type {
>>  };
>>
>>  /**
>> - * enum iommufd_hw_info_capabilities
>> + * enum iommufd_hw_capabilities
>>   * @IOMMU_HW_CAP_DIRTY_TRACKING: IOMMU hardware support for dirty tracking
>>   *                               If available, it means the following APIs
>>   *                               are supported:
>> @@ -486,6 +486,7 @@ enum iommufd_hwpt_set_dirty_tracking_flags {
>>   * @size: sizeof(struct iommu_hwpt_set_dirty_tracking)
>>   * @flags: Combination of enum iommufd_hwpt_set_dirty_tracking_flags
>>   * @hwpt_id: HW pagetable ID that represents the IOMMU domain
>> + * @__reserved: Must be 0
>>   *
>>   * Toggle dirty tracking on an HW pagetable.
>>   */
>> @@ -499,12 +500,12 @@ struct iommu_hwpt_set_dirty_tracking {
>>                                           IOMMUFD_CMD_HWPT_SET_DIRTY_TRACKING)
>>
>>  /**
>> - * enum iommufd_get_dirty_bitmap_flags - Flags for getting dirty bits
>> - * @IOMMU_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
>> - *                                   dirty bits metadata. This flag can be
>> - *                                   passed in the expectation where the next
>> - *                                   operation is an unmap of the same IOVA
>> - *                                   range.
>> + * enum iommufd_hwpt_get_dirty_bitmap_flags - Flags for getting dirty bits
>> + * @IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR: Just read the PTEs without clearing any
>> + *                                        dirty bits metadata. This flag can be
>> + *                                        passed in the expectation where the next
>> + *                                        operation is an unmap of the same IOVA
>> + *                                        range.
>>   *
>>   */
>>  enum iommufd_hwpt_get_dirty_bitmap_flags {
>> @@ -521,6 +522,7 @@ enum iommufd_hwpt_get_dirty_bitmap_flags {
>>   * @page_size: page size granularity of each bit in the bitmap
>>   * @data: bitmap where to set the dirty bits. The bitmap bits each
>>   *        represent a page_size which you deviate from an arbitrary iova.
>> + * @__reserved: Must be 0
>>   *
>>   * Checking a given IOVA is dirty:
>>   *
>> --
>> 2.27.0
>>
> 
