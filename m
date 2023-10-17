Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08087CBE48
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 10:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbjJQI7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 04:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234746AbjJQI7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 04:59:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AF48E;
        Tue, 17 Oct 2023 01:59:02 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GKO9KJ000725;
        Tue, 17 Oct 2023 08:58:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Zy9xnsZTOuX0eiSl7rPNOfcmE7rG1nHvY2dRCWW+m38=;
 b=GJyiPXz9fivOBpV5DuA/+6knoacSKR35hYyOSQfmuDMrwQ+4N3+7iydi/oW9dAfWcCe8
 pNxvxV8a7/HXnb3CInqhGzB9Zc+YFqVkcg0RjdhJWsy6FGV2eAEuuZ0gpoK0iOH6lQi7
 Ns0si4rSdHpzQDtY17ot1DEiKUIyreZlxLjnQdRiQ+ey2IJ6I7zagn17pAwGtaOBUS+E
 /wAUgtjP07hwYEtB7DWbUq1A4OpO3zSc5qDrNrT+d8YpQiAOrpfvIcdHD6vgWuH7JbhB
 7BMsoByscDrMM1tast+AUCPj3of5de33J7JmCYLuaO8AU/5UWTKfJhpEfLn/zKxmj37r sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3tqk28mp3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 08:58:32 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 39H7ovmD028226;
        Tue, 17 Oct 2023 08:58:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3trfy39f5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Oct 2023 08:58:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H43uuNiSLUV0CpABml9SH0HhF/cPJq3dseCJE8GBUpINwPxEvS7fMVq8/aPZ+6oysGt6F7CIgRSUEA8Nn7jjkacSSw2u3y4b5w0Q4f13KDa5KE0f/31sTCwcSSw1gH7fHRnb7uc9UUus/PZP6zEANvCjDamL3s8/2dDSxwU1RuM5sHolQtrTloLMRweX/uvK9aP7EwzZSFNWv0nEuNgjp6Q6IVpitHZ+pFNTSpC95XlPJdK9xZjWyvq9nTECkW+hGf1JzZJ6D1os4Roe0OphWt8vGoFFHVwBW01HtN6nmIIcc8wlX2UlPuqz6N9trfOUWq3gC/gDBHsdZaC+gt341A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zy9xnsZTOuX0eiSl7rPNOfcmE7rG1nHvY2dRCWW+m38=;
 b=OeBTTWWM0MwfeXMR/MC3G+HcF983IRbb2qvFAbdcYRjTFuRbjOnIWy/xt5uQ0STcDTkm11D8Ikyu7POukfYyUbh5UCfNAvJYbnfG3KfPbag9WGuJjzlzrLfWyO0cEQfmKRtAu3r+k3P2jo3hIeMW1u8CZCZNNQ9EF4uS+ZzE2YG/T9wE0whyabcWfhnQBeHhjQwLeSc3rAr22F9UQfhAjQi9gxybBKMngkwCt/veyCJLSCldyJOonS9/iVhRUI1pQttXD4c5/MRwzjLV0Ze6RnNFfqvjYCdAFMfLwt4Rd7bTLKIy2FUJRUhnOiQQSgWda9hC/XuwEVOSpPnsmFHyYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zy9xnsZTOuX0eiSl7rPNOfcmE7rG1nHvY2dRCWW+m38=;
 b=rXe1Tmoeh4/ZydkUUXA84y0FLh6I3sITPFlBJjqFLIHVf1rnz30WSoIZ6vBSuUsDeFX4P2JivK6i5CvUdTubdu1LEb5Swi6XE46Xu4poryIk6xSZ+pG0K0tS5ayAbqR9RfoXYFtl9va8d9Os7TUf/Khb2KaA6qc8QMGuVf4t3YE=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by PH0PR10MB5641.namprd10.prod.outlook.com (2603:10b6:510:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 17 Oct
 2023 08:58:29 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::9e2f:88c3:ca28:45a3%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 08:58:29 +0000
Message-ID: <fb1ce733-d612-4fa3-a1e4-716545625822@oracle.com>
Date:   Tue, 17 Oct 2023 10:58:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/102] 5.15.136-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org
References: <20231016083953.689300946@linuxfoundation.org>
 <a01256b5-6082-4d17-bf4d-310e7b4f7a47@oracle.com>
 <2023101641-resource-scalding-3e1d@gregkh>
 <43ad9708-47d4-4113-ab05-6012cb7c4d6c@oracle.com>
 <2023101655-throng-rickety-ff79@gregkh>
From:   Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2023101655-throng-rickety-ff79@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PAYP264CA0025.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f::12) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|PH0PR10MB5641:EE_
X-MS-Office365-Filtering-Correlation-Id: 8882688c-9471-4302-c350-08dbceef3b72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLLT5WsBoBjlze3QoCsFUU0rhDReHzY+vOyi8zQjXza7ulU/PRhFlWZCYIldTvdFaj2BKPA+B1n3BbcNGioLseYe5QzLTTamTSt8kM3/ycyh5I4F/Ao/ONPw99j6sZoE+TcBd/i/V33/PgrsuWeWYKMtm0CX419GC3kVShF5c7WMiYC7CbWxPfKqCCPsvuVASOTR+xR4QhUc8aAiKBK9ywfECZtCSM6iONkqLqVSMUVJI0yq9ptdIt+Asy3Sd3R+XAAjI7sutEKYOgV+08YlkR5xx6sEuNvqhkpccKjc3FuMfPnUB/dd6zGWdVWTpZ7Xa028wURSLyRmAL0b9VDy/F5tmQvkQMTin0gu8m8LqjtlcxhQuX+FP7MgeFxmDV2SB8Az/jWt8boRRPSpyfpSp2gRS17O6yZaqYM3GvwCLeLIOpKUJXdAKyZ7OJSJ4uYJ0wMZCUf1a1UKATCmoEry2TnVEtfKHYjLewmkx8WBVcWsLGP3tyAdReHnHTw3kL2b9JbwJOlpWTKmEQaWV6STL+CcJO5H97aMWkKDpLd1xo/may/2oO5OHON9vayfdICK4qRGMx9d1b0A4V31QNzWjm9kUFdokVmlJMtgzx+svBJW3meErw6HcO8u6aGZqS/nENdvjW/46kS6+AsgKwLqJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(346002)(376002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(6506007)(2616005)(53546011)(2906002)(7416002)(66556008)(66946007)(31696002)(6486002)(26005)(66476007)(83380400001)(5660300002)(4326008)(8936002)(110136005)(6636002)(316002)(44832011)(478600001)(38100700002)(36756003)(86362001)(31686004)(6666004)(41300700001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3NHSllKUkdUcFp3Q2sxeVBpUEtzMVlNRmRGVFZGUm84OWU2NUJvSktkbkRJ?=
 =?utf-8?B?YldVbitXcmFJV29nTStVNTZ1QkdCNjg3VmIvQ0Z1a3VJeFdSL05XdG9haUlt?=
 =?utf-8?B?cDNrNlhkNVU5VVo5dnFYa25sZWhuWGR0WWorYkFLT0U0THF1REhpRFBZVlJy?=
 =?utf-8?B?OENkV25IamJPd3pyRU5qRjhja0tWNHJYbXp0cXJMb25CWlZuYUJlNzdTZldW?=
 =?utf-8?B?MFFXR2xKUTRIKzdjcjM3bTRseHV1eGo1dUM1T3dUV213d3R0WW41VCtvQ1hs?=
 =?utf-8?B?MFZJaVI2YVNCWTk3VldjOG9UazdOQkpYYXYwRktKMDNUUEpTRFF0ZGdNd0Fj?=
 =?utf-8?B?dE51SUQrMDVQMEExVEF0dy9TM0hzVTZqeFRnREFPUjBIL3p1R3lyU0cyaEpE?=
 =?utf-8?B?eGZRc09sY1JycnVnclhPczlSanA1T3h6NVYxTW4waVYxdjZHdURPakNZNjJr?=
 =?utf-8?B?TmZzbERNK1lGY1JocDMyMHhuSDl5MHBBTEdqS0JYQW1DdXljc0dPcUVZUmhm?=
 =?utf-8?B?OVh3WG9lK1UzZDBqcTRWWFV4Q2RBbGRNTE5ZMytZTnQ5SUxYVFgzNkV4QjB2?=
 =?utf-8?B?SkoxaVZqMVhTemdsSWRPSTdZRVk4eG13TWx0UXFLQ3FkNFlSUE1vbm9QY0dY?=
 =?utf-8?B?Q3hGTktteWpUbE9qZVYxVmpSeU9ZWndkY2hxY0pyWWh6K203WXFIazEwbjc1?=
 =?utf-8?B?d29PTzNVdGg0U09zcHgrVCt5WjJjRktLMWxJM0lnTk5xSjNKdEh5S1NDZGhL?=
 =?utf-8?B?M0doQ3BVVFJobGRkdlNVWlBjUCtGRzNTRkRpcTFybG9nRXg5WVZKNjg4U1VX?=
 =?utf-8?B?bGozWk1WZStYQTZ3UDZqOHZ0NEJUOEh0UWQrNFRXUm1CVUJrU0FWVUo5VkJW?=
 =?utf-8?B?LzRWenJTUW01dnZhOFByRlJTcm1ZZVQ2d0F0WkFlbS9ZYVpBbHNrYzNGSTBp?=
 =?utf-8?B?cDNGZDR5S2pzc0o4TVJ6bHRKazZvd1RheTIrOXZZdm5NMElmemZ6dmtXa2FK?=
 =?utf-8?B?ejBCTk9rMnF2dGV4TmtEMWg0cW9IdVcrcnQ0SnNmMmdIN0VIelNDc3R6Rnpq?=
 =?utf-8?B?UzVueWZCSGVBWXUxWGtvOGZPdVRGMzR3RUljc0dkRU14MThxbWRXbnB1ak14?=
 =?utf-8?B?SHM1Z2pGRjF6VHJQNUJrNWtyd0ZiUTZSSDQwYUpFdnpDM01ZbTMwcCszbmp5?=
 =?utf-8?B?M2NBeU5SVDJsVjRQWUpPMnRZNTgvbUpGcWpKdVI4VE5hdncxSkhXMmZ0R2hP?=
 =?utf-8?B?RFRzL3dPUVprZUUyanQ5TUt6Mm9TZ0N2dVdXOG1lQWdZUk5tU05tblZUYWxF?=
 =?utf-8?B?ckFuQU9vOXV1eEhCNmFZNitZa1F1VjhQR2NrN29OOUp4czhhamUvUUJtMW1I?=
 =?utf-8?B?RWJ3RjdIdFN1bmRUazQ2cTRjdUNwL2xlM3p1dW1NRFlkVHlEYTlEL3RDTDRN?=
 =?utf-8?B?cmNaN2dvV2VpcExqd0E5QzM3VXhyVy9VQkR6TkJINlREUGpENHVIZlZBa092?=
 =?utf-8?B?MHVZUVZuZ3hRYXIyOHNJbFpta21ZWlI1WkRWNnFpc1l6U0NJWFBGdWdkTDFC?=
 =?utf-8?B?M0xmbm5mOXV1aWVhNmpOUGhycURaOGFQWHFKZm8wVWk1dWtJU3lrOXg0TTZ1?=
 =?utf-8?B?YTBZclp6Z3NINTlFVVJzOGgwMFcwTG9JaG95emh6K2krMFJlQjU3ajA0bEZz?=
 =?utf-8?B?MkQ0VEo2QzVhdHBBZlN3eE41NUF5U05zMW5XTHpXcGppWmdjcWFwbEdVQUpX?=
 =?utf-8?B?NU5UZC82bDdUSk1sUTE1dkxmYkttcUlNN2pPL1NNSk9jNUdneDBTTDNRYnJN?=
 =?utf-8?B?ZG1TY3Q1RGxMc1RnMFJwd25weHVuc1ZRQ1l2NHJSaTZXaUNQMUdQRWZqQzJh?=
 =?utf-8?B?NURVOWF3c1RRSGdFdkxUdUN6QWdtMGh5WG5odC9WbkFSYzducHlSRzRkZzJl?=
 =?utf-8?B?MjI3TTNML1J5VzdVUG5Id2p1Q2NRQjB6VnEraE9RMm1tdk1sYlJ4UE1GZWRY?=
 =?utf-8?B?VjZ2NlhMYmhUMHM1VHlWc3FFdVgvb09xSks1MU90SmVOR0l4Q0dLQVVjRHEw?=
 =?utf-8?B?TW5KWWpuWE5Ia1hybmo3cGxMclE4WDhzSE41YitkOTNhRUw0OXZLNG9qOEtY?=
 =?utf-8?Q?VQdE2UzUVA4lVddgj+CGhha+E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WUZQemlVb2orZkR5NyttdWdkMCtGUXhZZ05xZkVvblIvSTU1bEJlTDNJRWxZ?=
 =?utf-8?B?YzQxdDdqWDh4QU1mMzdQRC9OYmlXOEpCRk1ER3d3TkUvOGlXak9UTTBGZXFC?=
 =?utf-8?B?V3B4aVg0OEVLZGo4RDdqck0zVlIxeGN2ZXRNSVZ6MDczc2MzY0ZWNmlucC9D?=
 =?utf-8?B?cjJmYlNlVCs4MGNsUG5ZUnZ3UHduQkIyRThZb3kweUxEWE5ocVdBYittbENJ?=
 =?utf-8?B?eG04emdrYUtyaXlZSVg4MWEyN2tCR0d0Ty8vTnI5M0pDNHlhay90U1lQWHdF?=
 =?utf-8?B?VDlyUG5kc0F1SE5EZFM4Ykp3cStqalIrMGZSR040U0FLN0VuNzl4YVQxNWMv?=
 =?utf-8?B?WHFlTnptNEc0eG9nb1YxbUh0YTgzR0Q5VkdUYTRqNDdHY3Nncmk4MGpoRnJR?=
 =?utf-8?B?RFh1MTRwOTJQd0VpQ3JTQU4wRmVMSFUxSW5NNHhHbE9RT3hkRmJheXJDVWgv?=
 =?utf-8?B?cU1peDhYbjZpdGNnQUcxQ3FoeHRhWFJTcE44UVpaMSs4WXFWeTRWTkJ6U1Jr?=
 =?utf-8?B?MWtJOUg0V0ZWUXl1ZTQ5YUc1dW42SWFOcDZkYnQ2amxkeXg5bVY1RXR5UVNW?=
 =?utf-8?B?dmpsTWpBT1V0a3FXRHZwaHhIM09GaEdmb2hGWFFuM0tvaXU2bXU5SjdqSFJF?=
 =?utf-8?B?OGpLYnErRWszVVVWc2pXWGduTXJDcEd5QkhEWFYxZmRyZHluNnRNUnRjTVNU?=
 =?utf-8?B?WFpQeGxLNXhXamE5OVVWNG1hSG1wSXp5bDdlRmNGTmp4a2FWSlcyTVdubUh6?=
 =?utf-8?B?V2ppZUluZUI2cUgwR3o3UXpqRVBJY1FOWE9SNTFQaGxTdGtuVXA2anQvUWVv?=
 =?utf-8?B?cHJXbENYcTB1bHZRZGVVOW9CSGFoNDJieVBQTUxXSUUza2d2aklNVTgwVm5G?=
 =?utf-8?B?UnJZL2s1TDdYdERaMVgvVlRrYmtYYk0wY2phUnMvUy9ZK0gwdHlXUDl4SzFS?=
 =?utf-8?B?V1ZUSEZEbytOL1ZpdnVLTk1HK3ZkbW9wamJyOGVTbE80emNyUGQ4bzRaWDJT?=
 =?utf-8?B?L0cvdlROQlV3ajBpRWlrbTRJcHArZ3pONmhKNWxGU3RYQzZabXlTcC9UR241?=
 =?utf-8?B?eU1BSzVKdkphS1NYekRDMVI4Lyt3c2xxKzFyMG9wR2ZIK0dPeHRqNGVMeDFY?=
 =?utf-8?B?bUphWUxSUkU5UFhweHd0eHBhK2hGN1R5QVd1RFNEQ056bTd5bUNLdzdXdXRL?=
 =?utf-8?B?aC8yY280TkNXQm54a0thazUvVitIRkZzTE1YWlVldjc4ZlBQQllxVExMVWpY?=
 =?utf-8?B?YW10ZzFQYjF3QzNBSk5OZHhNdGIrQ0ZkUXpxL3JRQTdGRmltcHZWM3FUTW1J?=
 =?utf-8?B?dm1rTitPQ1lFY0ZRUnplc0ROa3YvT2toZUxKMFA1ZXJNTm5UaXE2TG12akFs?=
 =?utf-8?B?RzdPUEZZLzJOR3lUMVN3ZTg4ZStxNFY3SGRNZXdJdHVKdkZjcDcrSXk4bWFE?=
 =?utf-8?B?OUNvMEEzSXdZTDg3ZldudGJ1SGJPV2NyR1hPSzZhemp3cklPbVhla256akZm?=
 =?utf-8?B?VGtrc2g2UmVqYWhEeUQ1a2phVVdiZ3lRdkhBUGxwS0x6VHVGdDZkczFwVEl5?=
 =?utf-8?Q?z5WaP9ZWoJXYwMjkWP8i0SexdOnLbd3RX2108qrjnCcbxu?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8882688c-9471-4302-c350-08dbceef3b72
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 08:58:29.4093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2sAO1+6lWfWmxSZrJoSRXQHNFpdazJjzluGleK3Cu8X4M/0DWRUC1Z5jYF8skBTOdsFomDBhIUbJmQ5BhEJLbpSgFSGMr9MZNJX7ir0Yrac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5641
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_13,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310170074
X-Proofpoint-ORIG-GUID: D7B73yKTeytpCZ3fFBfWIiP0EZr7qP0c
X-Proofpoint-GUID: D7B73yKTeytpCZ3fFBfWIiP0EZr7qP0c
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/10/2023 18:58, Greg Kroah-Hartman wrote:
> On Mon, Oct 16, 2023 at 09:23:36PM +0530, Harshit Mogalapalli wrote:
>> Cause for this build issue:
>> Commit: e2bf685d7e311 ("perf inject: Fix GEN_ELF_TEXT_OFFSET for jit")
>>
>> And this issue is not in upstream due to presence of commit d6e6a27d960f
>> ("tools: Fix math.h breakage") in upstream but not in 5.15.y
> 
> Ok, I'll go drop the patch entirely, I can't even get perf to build at
> all for me on 5.15, which is why I've given up on it even mattering
> anymore :(

Just for maximal clarity, there are several commits involved here:

1. babd04386b1d perf jit: Include program header in ELF files

This commit is already in 5.15.y but introduced a bug...

2. 89b15d00527b perf inject: Fix GEN_ELF_TEXT_OFFSET for jit

This commit is in this -rc1 and fixes the bug above, but introduces a
new perf build failure on 5.15.y. [This is the one I think you've now
dropped.]

3. d6e6a27d960f tools: Fix math.h breakage

This is a prerequisite for #2 and is not in 5.15.y. However, it has some
conflicts on 5.15.y, i.e. it probably has some prerequisites of its own
that I haven't looked into.

I guess the question is -- if we're dropping #2, should we drop #1 as
well? Or... instead of dropping either of them we could also apply a
minimal fix:

diff --git a/tools/perf/util/genelf.h b/tools/perf/util/genelf.h
index 159c69bcc33e..6e202db6c4d9 100644
--- a/tools/perf/util/genelf.h
+++ b/tools/perf/util/genelf.h
@@ -2,7 +2,7 @@
  #ifndef __GENELF_H__
  #define __GENELF_H__

-#include <linux/math.h>
+#include <linux/kernel.h>

  /* genelf.c */
  int jit_write_elf(int fd, uint64_t code_addr, const char *sym,


However, this is not what mainline does so technically it runs afoul of
the stable rules (although arguably I think we could also just make this
change to #2 and call it a backport).

Out of curiosity, Greg: what is your build error with perf? Given that
it builds for us (and we actually package perf so we need it) it sounds
like maybe you're missing a package in your environment or something? If
you pass us your config + the output of

   make -C tools/perf/

I'd be happy to look into it. Only if you want though :-)


Vegard
