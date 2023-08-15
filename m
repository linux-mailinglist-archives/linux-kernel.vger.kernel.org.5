Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1168977CD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjHONgn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbjHONgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:36:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462FB109
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 06:36:13 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBJSrx021704;
        Tue, 15 Aug 2023 13:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=0x3AjlP+iUgpB3apXIcU++Q0aizcNTCftd6/Apd/S4U=;
 b=RsbT1SSyAyrqzwCSyYqWbRDHsbQKB3z8bwZHLjrdfsrnFbJ3mYIOEFFBihOMcce3TeBK
 RnUsambyrmX0HZE42lF8G/Ir3J95F8tIwVpc135dARYcP7YX2Iuq1OcdpgCpXM3fA+mN
 AUzunmHzav+5Yzfnu4heMoSaGrr+qef5UHxRzY/CuF+eagCO2Ii/ElOFpNJdTeWBo7nY
 y9ulX8+CFFWTAyYT8yUWmrordfJbktL9EVXkhMQwqPSbeE8gEUI7tCaFjRxpUzvnJsg+
 l3zbryaSb4Yinw6Jzd5fkq2LbSGDkNeQm+3d5dA3Ja151Wic/vAapMvBNV4dFtZyCZiv /w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfmpsb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 13:35:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FBX7mv027391;
        Tue, 15 Aug 2023 13:35:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey1s31ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Aug 2023 13:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddw6yxDW2AxTGEPLBQWvhYhy9Tvo0XQlsM+4XHTAwN0UgMBrSku08G1nG1P+AO0eNqcSQWkBXwEDhJopUb3WUVRbFp43Uv/9FiS6f/myUWwxUl+JzbRNCcJiZDMi64eGXMK08AkkBrh+AM38kXRttxz4K+jtRsYlDqe4++Hq3OlPW3jO/Cv7TB0dleZzwlpooiQsGhknKBUhjLhsBjNWi80h5E6s/2gy/IpxoPrNdIbLvyCyCuEXmWFVPGYNmxfPMVu34eYnafyvqU8CoklISnJa2hb2PQFqfsapdfcxAdkRD9cDbMaOHZHKWi5gNfkYlQFfJ2LJkvRbDjAoTN7wwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x3AjlP+iUgpB3apXIcU++Q0aizcNTCftd6/Apd/S4U=;
 b=QOO54RQyKK+DKr+v5mkApK/hRvmp2zjeSF93ESRby+xky6CveyPnj2u4qMO0Xfv+H43YsuHI5CY0re4F6gUUhURdrX9oltV7F7RrrrOXxbB0Ts5+XTpYJeEk/GGfK9H+P8o7WEScyTK3thWPfquIIH8bThmMpuQGDjRCP9uv7kvGYf+BzM88yBSCGd+z5pmtWFW0HuYLKOTRpKj7drKFZp8TVmUERqSGnSUIaWBzdhlpaHOr6kQ8/VfSGuH747NHXQEIFqGbJu6kYm3VlMii5uhteZSomBw5NXU0byLfGVRCH9QNo8VrocO4EyRuyXJxTaO/FrVwKGlnenbcf9Kpuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x3AjlP+iUgpB3apXIcU++Q0aizcNTCftd6/Apd/S4U=;
 b=ZvF9dhuapnf8PdhCQhJG5MDEvQCVkKgGQ8iTyCxdatX1o6MfBErITzUDwgQ35cLwyfzKfrZt/P2wKSUhxc8rXPT0ekSwIsWjOuuZuB4nBLrU99TkxnWI/lTiHRPmlosXbtFYxoO0UosmexLYCI8POjMQGWDjwPgXhArBxUHeBZw=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYYPR10MB7569.namprd10.prod.outlook.com (2603:10b6:930:bb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.20; Tue, 15 Aug
 2023 13:35:47 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ebfd:c49c:6b8:6fce%7]) with mapi id 15.20.6678.022; Tue, 15 Aug 2023
 13:35:46 +0000
Message-ID: <1aa1ecad-bdf0-84c8-a37f-94e1d0fb8a03@oracle.com>
Date:   Tue, 15 Aug 2023 14:35:37 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/2] iommu/iova: Make the rcache depot properly flexible
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, zhangzekun11@huawei.com
References: <cover.1692033783.git.robin.murphy@arm.com>
 <80fb865a-eb45-e783-277d-0d2e044c28f5@oracle.com>
 <b9bda816-612c-b646-63e7-54cb3fedf1f4@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <b9bda816-612c-b646-63e7-54cb3fedf1f4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:194::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYYPR10MB7569:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc019b0-d213-4809-054d-08db9d948802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxE5FI6GtQCKTWR8XA/4PR0d5RtR95lzjGUIOVMdIrhxXrw6YK9kUdub406L5sBQDvMi97sp91gFnKLkI93MVZjygfSMo9+mY4i4Pxwn7tWTdaZ8rsON3lJb6LCDhfew1HcnBF7imHzwIXgSVyXfPMmRMVsXfaDYlcj2A2l3IOH4xCcdfUL988i6kEyQVseEuz7WCv7+dEuR/b1ghRQJsJ/qD0YX4TMW6phHW37swXDcvmvgrNF3+NRiAgoKOZJ8gMm7d8DI60VdPI77x5/+SJ6SY5Fw4xw5v1rdWyuD3khGXK2zuX7TH9vnSu20Mld+fQPqJTzOh3/w1sxUz+7wQIxpIy9OgNaWPXoyoLp5pvaFciIPizZyBzQ+d4XUFRnX3eptKt4Sr4ROVeTd8MN/awkG8u3daOTtv96WNaoK7h4/GZ3FoEGalLfGHlqzJPdoE0Zy0lHcuX5Ce6/FTPQgdthH02LEYXXnyqG5znURomSTnf0VX5/7nFq5VGdMLpZ6s4E7qGKwV0yH70TIDRqe8tOA3KjreudX+s/JzIsi6RtXHLSxBWyWULgHkBB5u2rv1Iklw7iKAcUxjn3DXGkEEx2dvu8NS214m1vwl3bTcvl1XEBN8ZsXm+slTgP9WAnNn+bgQWrnAM20n0DRO7ktEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(8936002)(6486002)(4326008)(66946007)(6666004)(5660300002)(41300700001)(26005)(36756003)(31696002)(86362001)(66476007)(6506007)(316002)(53546011)(83380400001)(66556008)(966005)(6512007)(8676002)(36916002)(31686004)(38100700002)(2906002)(478600001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1M3S3hjNm5XNFRuY1dRZFNjMUx3VFpxY3UrWUF2ZTdNSUhKbmdBaDdDdUN3?=
 =?utf-8?B?VEM1RWVYTy9MemZyWVovdm9Gd0dOWXhzMTZ0bEhtZjY2U2kvWVBBNzlxSUNj?=
 =?utf-8?B?TVFiZkhTeGxwYTlNMTRTK2cwRVpldmMrbXIyelZpeGhFSUovOVZ6Wk5GZlF6?=
 =?utf-8?B?OWxYNE1IdlFSL0VTbVc1VEU4U2k3Q1BFNWFIMXpiKzBnbUdYWGF5eWx2VmFR?=
 =?utf-8?B?eHFmTUUxcTdibnY1OXRhNXNjTkVLT3VkS3duakFiY2g4bjdPcVZpTXFKVTRv?=
 =?utf-8?B?d2t6d3JMVG85ajAzQ3EwZG9CeVpzU2ZOVjRBa3RlNkM5cG1FMWRRc1FscTMv?=
 =?utf-8?B?UDUwUnlPU0IwWFlhN0Z5WjRZeVV1c3N6UUxvM2x5N01ZZFhnMkRLT2Vwcm1S?=
 =?utf-8?B?VEM2OE14OU1nTEpYenAvVUladXIrcVBLTWFWNzdnVmpia0hlR3E3QkFLd0RN?=
 =?utf-8?B?eEZiK0I3ZUJKZHdDV1pjOWhJZzkvQXVKbzA1Z3l0aWlLT2tOcG5pclN6YXkr?=
 =?utf-8?B?bEwvSm5kU0I3T25MRGo3c2NCZExHRlltR0pWTjdXYXlQalhNaTJOeEFFNmx0?=
 =?utf-8?B?Ky9ZRUpEOUc2UXJtSGJnUjJOMTU0VmZ5SGFGTzRidTlTMnkvYWJ3OWIzUU9x?=
 =?utf-8?B?RW9LN2h0OW03WlRxa1FaY240SEdWT3RncVZhZGhOSEMzMGZ5Qlk4dE9XMGZZ?=
 =?utf-8?B?VzdyUFRLaGRJc05IbXVRcFZ4UG8vc3JZV0U1MUs2TlF5Y3N4WnNMRjZhcUZq?=
 =?utf-8?B?OGxhazJqbzRKdlNGb2dhcjlkcUFXcUdqQlRjV3NUZFVQaFBReVNQWCs3TllD?=
 =?utf-8?B?TzN0NkpKVlN2MFY0TTczN2R6MjAwYyswRmhwZlF4MGZBNS8yM2FqNDJ4Z1R5?=
 =?utf-8?B?MXBNVHlqcThWQTVuMjJjb05lNWRlY0JkQ1lwNUVHbzB1enBaQ0FzZ1N5djB6?=
 =?utf-8?B?U0J3d3RkNk11VkUyZDBCSTFib29nY0ZRakU5UlN4UFpnRng3aCtzUm9zQ2ZY?=
 =?utf-8?B?b0lYK1BuWjZQdDlJTmt6aWZzSzR2NzFiQkpnNCtwSlBEaHNKVzNLQXBqQnB2?=
 =?utf-8?B?ZEhDMG12UFJ6UHFnYjN2TGNhWVZQVGw4bm41NXJtbTNWOWVncEFKL1pkSzBy?=
 =?utf-8?B?NTNjMEhvRzVBaVl4ZExYYjNyL3RNVEdFMy9pdno1TkI5cDdtUnZUc1A4bnk2?=
 =?utf-8?B?VFVvSlltcEtmVkVpUzNWdVV4a3BTUk1yQkZPbEo2dlM2RTBRMG1zeStNOGVx?=
 =?utf-8?B?d2dqcGZtOWpCVk1BdWZNNmNKaUU5bkh5ejJrcXptUWxNTG0wcXV5S0ZFcmQ3?=
 =?utf-8?B?QXljcnRRdDNyTzdyeUM1RlVMeHhwU3N0QW04Y0RodVh4aWM0YVhzb0dGVnM0?=
 =?utf-8?B?Rk1mR0lEYXJCY3N6bmRUNVJwU0dGTmpaY2NvaHJFYTJKL0NkUnk5TjBNRjNN?=
 =?utf-8?B?TE1WZEtPYm1kRGZhTUx1NTdsYzgveDkyMU4yR2tOS1lxUnBOZ0NYcGIzczFB?=
 =?utf-8?B?WE4zZHZPTEY5YU10T3prYUJwWTB5bndCRmxVVE0zVXBtTkh1d0xHQlVrTThv?=
 =?utf-8?B?aHJXTjhFalVMQy85QUgycmZuRFF1QzJ5a29vV0pOQUJxUU40REt5dkswazdl?=
 =?utf-8?B?WnVoNEY4VllHa1YybjVWZExQVjloWTV1UU04b1d2T2RaaHFhbDgzK0o3ZUdr?=
 =?utf-8?B?azROZUQ3aVlVbXlZS3BBaUVSQW1hbWRPSlhnVWxVM3J4TnRBR3dYZXI4aW4w?=
 =?utf-8?B?NnhqcmZsdU9TS3NLcEY1UDBBYjRVbXBrcEpBak9OdzZZdEtmRnIxS1l5L3h4?=
 =?utf-8?B?NE1lYmEreG9iT2xmaW50bENmSmdaTkNKMzk0RzFrUEFUazNad0w5WlRMeXNz?=
 =?utf-8?B?MHdWN1doRVZPMlREemNTanplc3RYYXlJbVMzRDVLLzNOYkxiRVZrZEFJcms2?=
 =?utf-8?B?UWxaZWNzdnN1K3h5dms5bmhJRTFLSExLaEg0L3hCM3dwSDlsOUJtYmYxeHpm?=
 =?utf-8?B?K3QxRzdhM3BGOTFGZFZDUGR1d3I2bHZQejZhczc1cVY5UFkxdVA1azlhREo5?=
 =?utf-8?B?L0xXbGlsU1VXcDQ0RTFoSUZhOEUycmErQnBlMDNDUWNhaUROaUEwTGdPbXlB?=
 =?utf-8?B?RUJCMDcwNE11Z0dRdWNud25XczVzTkU0UEQxRmVYallDVDZTL0pxVXJ0dmU5?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mNtThvFJ1Qg5K0hxytNMa7Egpi04BUu6V42Koh/AlULWEOP7B8YHhVLlJiDtezVK2xnoOE/2H1PV67Qu0MrH8ROa+puLVinvZYRg2ASwx1MxhntkLLo0dbVf4YabcvSl0lcSPcffQJ0xHOdGdn4kg0ThSHLipV6iUhGT7uFRiukW6G34psuVJ44+s8FxXPrxxjnY2QJIPAYExdNjuRpn6uQXzBOaHaJYkkp7TTzcESITM+IZRuIwuwbQf4Wfa5fScyN9Pf6X5NFwde/xeaLGL10qixYrqr0IufUZJvalSbyOrVxjK3Zhev9ycwseZYFp4dRSD0CjmA5vz+bf45OW92e/4u4E7TwYEjALlW6TBmPHIJGh+lD7OalM9vtbKA+TTlxK40kaXPps39OXjKh9cv3sJd5HeJ80eRCBNx3ibyBMVHOZi2rkWgy6AusP47HRZOy729Am6JU79C+DZhjTrrzvMPFukLWLfsJw422zPYHSjPqIs9WF3gBeQSJ8D/++KDnBeOxLvVx0veERGoARmEE0N3zEVXhvRQWC3iKPztfupFK/mdDxHP3IvXEI+VIW5Fr36LkXFXq9lynzHh2C24K4I5rLPm5MsbscMNqE2NqPDJMdVV66LqKqN2yeOUl8wKEPXjAgQnnmCV0ExzHJTAup0zytwoLTTLL2MbYNh48adYjf1h4is/xj3NkQoV1PUWhpSq3BbMxv+qCrSiM0N5c7+jfaub72yHN1PBPUe450BSpc61i+iIfrfMkbaOadEMcZBy2DQYkxjUGcWu5yIVQ8HgqRM4INRGBV8C2W1JsOwszb8OIGX+5DsemvL1kEGTikH0/Kk5Am94zfPEGgQwPHUhOCnTQAkRccrjdz2HzC7wx6Tzh0aKB2zM0KRA0LIQ4uJAUrHiGbz6mnLrOpak8LGdY8fyg/nZiBGG/NjmM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc019b0-d213-4809-054d-08db9d948802
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 13:35:46.8598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zi9KHKakMSfNoyRlakEX9Yx+buh0eo0yABTcbHr15LkFvEzUalawp/lf6vTy5/4Ui2nMSmAJmWzNpNsgZcgFRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7569
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_13,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150120
X-Proofpoint-ORIG-GUID: TInyCT8jUQHW7oWpIxJjEpVakqr-loeb
X-Proofpoint-GUID: TInyCT8jUQHW7oWpIxJjEpVakqr-loeb
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 12:11, Robin Murphy wrote:
>>
>> This threshold is the number of online CPUs, right?
> 
> Yes, that's nominally half of the current fixed size (based on all the 
> performance figures from the original series seemingly coming from a 
> 16-thread machine, 

If you are talking about 
https://lore.kernel.org/linux-iommu/20230811130246.42719-1-zhangzekun11@huawei.com/, 
then I think it's a 256-CPU system and the DMA controller has 16 HW 
queues. The 16 HW queues are relevant as the per-completion queue 
interrupt handler runs on a fixed CPU from the set of 16 CPUs in the HW 
queue interrupt handler affinity mask. And what this means is while any 
CPU may alloc an IOVA, only those 16 CPUs handling each HW queue 
interrupt will be free'ing IOVAs.

> but seemed like a fair compromise. I am of course 
> keen to see how real-world testing actually pans out.
> 
>>> it's enough of a challenge to get my 4-core dev board with spinning disk
>>> and gigabit ethernet to push anything into a depot at all 😄
>>>
>>
>> I have to admit that I was hoping to also see a more aggressive 
>> reclaim strategy, where we also trim the per-CPU rcaches when not in 
>> use. Leizhen proposed something like this a long time ago.
> 
> Don't think I haven't been having various elaborate ideas for making it 
> cleverer with multiple thresholds and self-tuning, however I have 
> managed to restrain myself 😉
> 

OK, understood. My main issue WRT scalability is that the total 
cacheable IOVAs (CPU and depot rcache) scales up with the number of 
CPUs, but many DMA controllers have a fixed number of max in-flight 
requests.

Consider a SCSI storage controller on a 256-CPU system. The in-flight 
limit for this example controller is 4096, which would typically never 
be even used up or may not be even usable.

For this device, we need 4096 * 6 [IOVA rcache range] = ~24K cached 
IOVAs if we were to pre-allocate them all - obviously I am ignoring that 
we have the per-CPU rcache for speed and it would not make sense to 
share one set. However, according to current IOVA driver, we can in 
theory cache upto ((256 [CPUs] * 2 [loaded + prev]) + 32 [depot size]) * 
6 [rcache range] * 128 (IOVA per mag) = ~420K IOVAs. That's ~17x what we 
would ever need.

Something like NVMe is different, as its total requests can scale up 
with the CPU count, but only to a limit. I am not sure about network 
controllers.

Anyway, this is just something which I think should be considered - 
which I guess already has been.

> At this point I'm just looking to confirm whether the fundamental 
> concepts are sound, and at least no worse than the current behaviour 
> (hence keeping it split into 2 distinct patches for the sake of review 
> and debugging). If it proves solid then we can absolutely come back and 
> go to town on enhancements later.

Thanks,
John
