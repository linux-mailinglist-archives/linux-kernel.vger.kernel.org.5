Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA07CDC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjJRMte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjJRMtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:49:32 -0400
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB36498;
        Wed, 18 Oct 2023 05:49:30 -0700 (PDT)
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39I6tYRk017686;
        Wed, 18 Oct 2023 05:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
        message-id:date:subject:to:cc:references:from:in-reply-to
        :content-type:content-transfer-encoding:mime-version; s=
        proofpoint20171006; bh=U7nBwqCfYFAH/7HfGLYeKq5hnEslgvn28dAkqepPd
        aQ=; b=HI96glq1p7E2+kihPDCRwV4anwnmI8EGDquF+k0rKek7on4XWKMzyrzDF
        dfvYfKQaOQtjyp1zau1tyXG0LseaSbdeHo9TzoRtHg3vaxJFgbDJlPdBx3CY1lo+
        xttLftGv0ujRVBi4xFIMYF3gD3UKmP79I4FVERbpju6UGeXFewZBfRs/d28SBvEs
        F5hmf5SdfrHYnuUmEnNzmCF2u6qu7QRf2tM5Af2W6PlYuFiONi0edsuPzr5+N7AA
        CaeaBDTwIWsh7HWhEVVFfJ7xgZitjgxdI7FcjYwFftGwP/Al0XhRodHr70cJazGa
        pGynxm/QPgkd434TnoUIAJWczx3Lw==
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 3ts6hwwp4w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 05:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0g3IzVwVhHsGCwywKTqgYMnK3o5GjU9OheBzvTcO1puICnST+Ni1dLniU1GhiH2qkAd3PWWnSXPJ9AJoxpktm9GEowfo6uu6qImoAsHvmDnah5TPVKsDC4R6mp4BWALlGFiCNmE6bgrNPw6iywAuVSKPHWZ7DNTpXYnztLMCrXp15ZSm0vTNqLNv0cMJ0wLVhCkKtncOTFR0m+uAFVjwU2l7Q6/qhG9jiBTkraHm5lXLdZoYYtNY8+lNFpF5ywIMQrSv0EpkioAK4BWm5gjsObKm7CO57pXI/9vcrEvi6Fn8KbLTQSieh1X3STpqNLUZiLzwx0ybCR8/Pm6hxrtxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7nBwqCfYFAH/7HfGLYeKq5hnEslgvn28dAkqepPdaQ=;
 b=BsXGrq3eqzcivSMTqZc758MVaueWErgDXCxdYvWeTa/axJ+z+J6bLuUJBL3e9kGrz6D+S80awPaO2prwgQRBxKsE8ElvOsG512CiMIfR3VR5YXGNgH09F5pf+q7mLrwt0MquPo94XktH3P50ioJp4V26V7vW8yG3H9PD3Q3ge/wACQoHWW+t9dvCT4flZFnUq9JZ5sddyqnORTpo//04zasr1eR0KiIS8kKI2TiRYSSvyBPNY+oZInbn1J1qRXF+/gkB+NzqvtF9uie6oFmao3sfuOZWKbGfTlGZ4Xw3DCN6r8v0ExUcJVvoJrRYbQxEwfEVMvLrahwdw/qXXIdjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7nBwqCfYFAH/7HfGLYeKq5hnEslgvn28dAkqepPdaQ=;
 b=Ugl6qQCkpSjgMmIXAZ/384voUaqTIPsX42XoJXoVPQevCPNzzU+hdrtu+zz55vSf+le7jBuoWM/Zy7C6HWock3f/DPxAHB9GlJdf3rI5q0vVfjpk8yBnz10bMGJ5Ob6C9QqcIyfKhVeK/a4EkAHZrJS32sgVVwpV8Nha8L1ME8VKYwUwO82wjOL68Roq4g1yFqP5c06OWmfgjjFYmDPkSk+DmR0KCTCV2D/xN/QUFR5QKCIdiiQsTka4AglNLluTFbV9VIbGiGuCsok8AsGRkCsprkFFm5oKKAInyr9AvMURy0MGqpARxJbyCUEus7vn8hPf1qf5kDghjU/SF6T3Zw==
Received: from DM5PR02MB3830.namprd02.prod.outlook.com (2603:10b6:4:b0::29) by
 SA3PR02MB9393.namprd02.prod.outlook.com (2603:10b6:806:315::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 12:49:26 +0000
Received: from DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae]) by DM5PR02MB3830.namprd02.prod.outlook.com
 ([fe80::26ba:be45:ee4b:e1ae%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 12:49:26 +0000
Message-ID: <cdcd0b8a-1098-470f-86ba-dcc858ac4cd3@nutanix.com>
Date:   Wed, 18 Oct 2023 13:49:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] audit: Send netlink ACK before setting connection in
 auditd_set
Content-Language: en-US
To:     Rinat Gadelshin <rgadelsh@gmail.com>, audit@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     jonathan.davies@nutanix.com, linux-kernel@vger.kernel.org
References: <CAHC9VhQBV1mcFUmXQs1-VKpAVdaAQ3EiGk-G3ybxfcBkoKGwcw@mail.gmail.com>
 <20231018092351.195715-1-chris.riches@nutanix.com>
 <102df7b7-a07a-475a-adb6-ae60453feb63@gmail.com>
From:   Chris Riches <chris.riches@nutanix.com>
In-Reply-To: <102df7b7-a07a-475a-adb6-ae60453feb63@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0179.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::34) To DM5PR02MB3830.namprd02.prod.outlook.com
 (2603:10b6:4:b0::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR02MB3830:EE_|SA3PR02MB9393:EE_
X-MS-Office365-Filtering-Correlation-Id: b3e28b7e-e17b-40b8-2742-08dbcfd8a8ee
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h8Z9xHubmCtdZ74PrrjK0b4m9El98c3ZUKPaE9SkvWfJ0i/MEG3Er6UdCD+LG2sIf96dSuTCb7saQyeMqk1ogE38KcFRa1UVRX+3VQ0P7S8eY+H84eZAikc+fXsBBLQ5i6VqjzoDTLEu2r5lAM1vnV0Rj1RVaC6OjGQRVqwop9xuRHPGsSWZxqFEdmKNQCEoMMHL0/N+aNrvIpo7i3/P6+cW/hJWSK1VB5ZEJNxjDFvy+LaJNNodq6Z/rISkjkTyindqS8rzPLt3nUskgIq4sUFy5Uj1gKy49a5r4CP9kSNtADOAHGgANZObT0BA2KWNjcgSXj6rEPNd267Ut/La/8ZSAh9Dsy4qSWclF3Hu3U22u+4Km1sjbRbu7hIBFf3aHHicrerUAuLOToGmSkHZp2pOJq3fw1X+ITcbJyMkbn9ivVNxDjwNgmFep17t07K3B+ck/TVKoPIbr+Dwh90nBMI/FW08R9znNcT6wuuwlkIg0hOQo8i5UskXJBrMw+XGaOgUc4TsTa7bPlAI4D1xpsBUVhm8TWH69hGXCPm+QojkbCKMtcTG778t0EPldWneraaVWADWe4du0VBMYQlmY0zrBuNiQYJfPv/peZKPdtNI/g5emv3BM+wCZd/hXw16WGYnixphuS200T2bhnZhrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR02MB3830.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(86362001)(41300700001)(44832011)(53546011)(5660300002)(8936002)(8676002)(4326008)(36756003)(38100700002)(31686004)(31696002)(2906002)(66946007)(316002)(66476007)(66556008)(26005)(2616005)(4744005)(6512007)(6666004)(6506007)(110136005)(6486002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bU9tbWpKcU1mYW84VTFvbUpRYTVrbjhRTldRZVlhVGxKYTFRTy9UL21mTDE4?=
 =?utf-8?B?U1VWU0tsNGJEaGRXaDc2M1VUOFFQZEN5TG5kdEdjTktDZllPTFFwa0Nyenp2?=
 =?utf-8?B?ak4xN3BmSDlFUytFYytDZ3RpRFZrVlRiSGY4aklEWFNtNGxwY3RLRm5aSy9k?=
 =?utf-8?B?cWdaZzBPUWsrd3hsNU5JSFU4dXdMSFN1dXZSUnFUNGhUeXpobDhadVV4Z2tN?=
 =?utf-8?B?RXZSbEJyaCsvakdOVGVBWTdVVENuNlhLV0gxR3p3WXRFbEUyMkFHd09OWC9w?=
 =?utf-8?B?UzZNMWJtVzdiUmNScTFOMVFqcm5NdEtWNVducVR1Q1V4Ly9xWHQ3Wml5YXdj?=
 =?utf-8?B?UGNPMis2aHZnZUZyUktUekFPOVVha2xZY0FGZmwrdE1GWTBHRUNjdDJWMzFr?=
 =?utf-8?B?eDU4TWxwd2txV0xHOVBrb2VFT3hwTGQ2VGNuOUhRVjZ5ak0yRzcyZmdGS1ZF?=
 =?utf-8?B?dHZqNTYxdWdMalUvSWllTW1JcHBwUStHdzRLS09lUU13RzNRSzBCTXljcGF5?=
 =?utf-8?B?cHhTQ3duTmFNK2pRTWkxUEFJQmplQmpVeWJtaEcyNnVXVnJFaUdYYmZBU2da?=
 =?utf-8?B?ZWVXcnQxdk1Fa0UvVjRSSkJUQ052NXI3NU51dzZUSVl6a0ZWZDZ3RkQ2ek1U?=
 =?utf-8?B?aHBVcUE4dUhmYmI1WnNhY253SHNvbUtteEd1OExSMW5TR1R1cW04Y1g4bllq?=
 =?utf-8?B?TVpyTFBocE1KZ016dGZTcTdWT1B6alI0ckptUWhsZDE4VHNoWkMwQm5NdFow?=
 =?utf-8?B?MWptNDBObDA0dVowTUFpMU9HVlB1blRPWkd6K2hoQktEUHFqNWtQVEN0dEg1?=
 =?utf-8?B?VEgxNktRcmY0djY0RGpNaGRUMGw4R0JKWCtGTmk3V1BFQWxZK2doK3E3eGRK?=
 =?utf-8?B?TXhaS2dZOERiU1RkNkoxMDRVR2c1ZUxZNC9MYUNVUU13bEZzU21VRVZGaHhs?=
 =?utf-8?B?UjFVcEVtdmovVjRGc3VXQ000SStuUC9BUnJrTll1SDYvTlBvRFpGL21jOGpo?=
 =?utf-8?B?dE5SL3MvNWxOaEFHL2lwbnZnNkdrUWdTQm5iOTg5d1RDc1RJQ3VWQnQwNW9Y?=
 =?utf-8?B?b3dod3daNDNGQlZJVnNxS2h5WFkwbHdFdUhyN3JkeHJ0OUFlMmo1b2lveWd1?=
 =?utf-8?B?bWw4d28wZ3JxajYrSTRLd3dXUTcvRm13V0ZIa1ZPVy9zajhQNmZnMkNxcklJ?=
 =?utf-8?B?RXBUc2xNZXpXMC9VUUlNWXdDTU9ubEE1bWdNNHFzcy9ENiswTmQyQjlGbHkw?=
 =?utf-8?B?L1paei9hZU1YVDI5VnFRaFl3VTkwWlJjRGhhUGxDS3pUUGRReTczL0ZlN2pJ?=
 =?utf-8?B?NDlUbjVLYnZjcS9kNWc5RzJDcnJkZVFvaGkzNFdqOTFWd0lORWRlWXhSeE4v?=
 =?utf-8?B?c1dlbWFodVlUZWVMa1hJdHFhdXlLaHpZRzF2REw3T3ZlSnJQTFA0b3lKMzZV?=
 =?utf-8?B?Yzk2UmcrVHNLTDZ4QWdVTVc4K0d4VURBaDVmVUVLZ2hwUjZTOGJ3TE9HQ3hq?=
 =?utf-8?B?TWhYRVNBK0hNaVJKdTkzRkJQSHpvL08yVDc5cE9vMXRSRm5MMVlhaHVOVHpX?=
 =?utf-8?B?UmR6b1VXeExBMjZZSWZ2NUxCRmU3d2lmUWljU21qNEZhWkpqTFRRemxDUzdT?=
 =?utf-8?B?UVU1cC92MnAvamNGMWxLSkdiZldxNjB6UEtlandLV3oxdDlBTG5EejdTeFRj?=
 =?utf-8?B?SjJONWJGUGppc0RiRCtxYzloYmRhclNMNXpYNkpoUlE0V25IK1d6bk0zQ3N4?=
 =?utf-8?B?bHA0RUJhTGdNRys5bzBZL2sva2Y3T3VvVWNzRHVuTGJjNjRKdnlWMzZBT09w?=
 =?utf-8?B?N1dMVmpUUTUrVEtSNFp4cjROL3dXRWlkaDFNTzU1aDJqK0VOTWNUcmFNUlpn?=
 =?utf-8?B?Ri9JOVVQUFdUQlFuVEJNQnhqdEJIZzRxSmVaMis5SjlXREhrMHZMcncxM2ps?=
 =?utf-8?B?bFBLQzVlZzZsaWsyTUhJa0pDeUFKWWpua2ZLU0NIZUJSYnF3RW5qOEhrd3E4?=
 =?utf-8?B?dmRUUUt4SWRaaHNUaC9SdUd4dTdTNUVyTGVNRkYzVFllS2FpaktWaktWS0Ji?=
 =?utf-8?B?c3I3dEwrQ1drZTNCd245L0YrUVc4V0h4ejR6eGlkRkZUVk1zYml4TFdDanVv?=
 =?utf-8?B?L1ZNR3ZCNFNQM05seStnWDAzUXVKckVaWkdjN1V3b084M1huam5tL2tRMEgv?=
 =?utf-8?B?enc9PQ==?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3e28b7e-e17b-40b8-2742-08dbcfd8a8ee
X-MS-Exchange-CrossTenant-AuthSource: DM5PR02MB3830.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 12:49:25.9432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lp/NT6ePBXpN8Slb1cWrhPJVwVbbqMVrENgFAzRMCKr4ftRmLY3V1t60jccvoLkvLupKhtSG+PocI4yx2GqmjOrXM5YCcvVyAcKY5Ld3Rag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR02MB9393
X-Proofpoint-GUID: E_Hn7eHF2zCOVH29_Ar__Kt3NSxWq4v2
X-Proofpoint-ORIG-GUID: E_Hn7eHF2zCOVH29_Ar__Kt3NSxWq4v2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_11,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/10/2023 13:11, Rinat Gadelshin wrote:
>> -static void audit_receive(struct sk_buff *skb)
>> +static void audit_receive(struct sk_buff *skb)
>>   {
>>       struct nlmsghdr *nlh;
>> +    bool ack;
> Maybe we should initialize 'ack' as 'true' here?
That doesn't feel particularly useful to me. In fact, I think it's 
actually clearer
uninitialised as a never-used initialisation could look like an 
actually-used default.
We're guaranteed to initialise before use.

- Chris
