Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB3475707E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 01:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjGQX0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 19:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjGQX0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 19:26:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37391703;
        Mon, 17 Jul 2023 16:25:27 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HKOe3E026084;
        Mon, 17 Jul 2023 23:22:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=w+4cyR9oO0IZy4AHH3RLkMmoe05KifSHbuV9UHfEo7o=;
 b=eXf1xUKZw7lPniZbRKcYoKZ2o9BDGSnqFhI0x32dMqI3q9r9M0XGSSAG51d7NB89AqYp
 0PLAVK4xdioWoNUMJtHXzJ7jPd2K9rkfZGLfggjFVD4F6jiiZM+Z0eBXkpjj3RfN0kEx
 DmC0pR1lP8qThVrKvsgjbblICqpH47Wd3Cj9hF7IRT0RgnL4CeKRIJRdkGwU+gR6YKwk
 xbnFgNteNRUV4uyn/d/8eVkG+FxpIpRzTr7OwgFZS3vicGvy6U9+iMmnpjo5VIivcvLM
 samun5QHGLA4i/yqQn/+UZysZ7sjHOMbVa+w1wvl5At9MqA7xTPbne2+/GtSieQ0k0uC dg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run76uvyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 23:22:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36HL3UpH000855;
        Mon, 17 Jul 2023 23:21:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw4bcdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 23:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAEuoefU51T7VURgHagj2Y2hjrusQk7yzNMyl2V6z53l3esmS6InL47EVFOrkXnD3Jv6KHeP+6yCNR8zklYuqHcb2ZFkdScn4o9HQyh75NBm7jAvxSjof5ziAyZOs0oy7vt79STupkQjRUS3rFTAoTaWN8Kppx/ft6ldv/aTRF2oQPp9wpNI6t8GLjiIiPPvxb+H6DWaCtwkd2fdFxpgMwJw61+SKzylVBhR4QTdQ7iFXJjbg/3QncJogcY9ToYpaaN43DI7zW6berNTOvxu2HiG5kvZHt5JCnxxSG7HNrY/CrHQhWVX3/atxsRAYBwu+oMfoKQxJEjBOnXSg0PxmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+4cyR9oO0IZy4AHH3RLkMmoe05KifSHbuV9UHfEo7o=;
 b=B9LqkNbyVVU9PxRsnzSN6ukgq4WvHVBI7Y2LLjC6G3byU+Wr+8Wtw+Yth/MUQhSM64uko0UBEwF6MeGCJZsKeASVy4QvAI56ZXgjEFeWYv00c0YDoylmG/8OuogsgylfO++pyfvT8hlpCEH6RIFHwNjuyFGLLAzWOcpLcQ55SLjfJis7JNF4XN8RkRcNf2rQTNY7JNakRwd8CMuSLLlBca/dN4giYn1GeszB4T6TzX4/A9RuhUE0n0V4qWuaFw8sM2tcq6o4MSfkPuePbb8MG6MX4rF520ZQ0WpxuEkDBpcd1//Ez/HcFm14Xp83YXmgtRic9wN/TY4xsp/hYEDLag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+4cyR9oO0IZy4AHH3RLkMmoe05KifSHbuV9UHfEo7o=;
 b=jTXzjpcLk/mP7x12DyFKefiWqXEGm4rixfRyLXYjIGw00UwPZqGDE663R4lT7RgGOHvVY2+XkQ6KTJvT6n/04gtGHjuaQDdKlUpr6V6wacceCG5EEYmVGnBYZP76ocM5f2yrRQi7rLaJOcRzLLu/CGCv2aSPsS1DKzshPZK4De8=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SJ2PR10MB7110.namprd10.prod.outlook.com (2603:10b6:a03:4cd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 23:21:57 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::247a:e7bc:cd79:4db]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::247a:e7bc:cd79:4db%6]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 23:21:57 +0000
Message-ID: <d3e87889-bd00-8b92-0105-80adae8df855@oracle.com>
Date:   Mon, 17 Jul 2023 16:21:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] mm/memory-failure: fix hardware poison check in
 unpoison_memory()
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        linmiaohe@huawei.com, naoya.horiguchi@nec.com,
        stable@vger.kernel.org
References: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
Content-Language: en-US
From:   Jane Chu <jane.chu@oracle.com>
In-Reply-To: <20230717181812.167757-1-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0237.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::32) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|SJ2PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: f7870255-c026-4bb0-5c55-08db871c9d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GwlMf6Q3FyGuxtwGi1DB6IAGIW6vLsNxMEMfPxWmDtl1FumLsaoRueue3FqkFzLzGDdezwuFZ8Cz0YiLGVn8IJRVd4GL1X4q4wZi0OjA/H7ECqwkhb7zccRJFv3xHcCH7YFq/buQIK5hoMGqzQ7SPUoJjGZ//hSfT5+Kna7OqpXmzxj0f84O5J1JwNVqYCkEW/xLC5faSJrjEGdLIxoS3Ztn2MJIpT4upEG2Lhv26vHOKFWvi6NVpfqXKdNc1aTBr3H1dDNS8HGelbJPwqjhshJBnwtIj94GH3WdxKi42gqwtjItYTcevWDRgC0GXHC8h+P38oc9A6aiGPDN38oz1wjcuVRxRn+aiYL4402X8w8F+kMETD2ljkMqjPMYPOt7tePzCi5vpa/QONgqnNZw2doiiu9BouagoOL8RIjCvFtqyNI7qmQHA3eKGVA77LlYgkWMsrsiyKRVNDLQPu2vkDhFusRfEyLyIDQwU3jP2GqS982jQYy6W8GLRob9Eyhc3oMuFfI/qaMpSH7bhBTMJdP4qrexkKlCN68KxlkKQ1gWYZQZJs5MRWNtZQNJ0KL2gAI8UgPLCyHJpfrmnG4kHuoh0HuB9yRTl4KmPDJJDQ+97cDTPrwL8YhucDMIJPPgCQHkvwA2nu9p29JTtQIBvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(376002)(396003)(39860400002)(451199021)(2616005)(186003)(26005)(53546011)(6506007)(66556008)(66476007)(66946007)(4326008)(44832011)(5660300002)(8676002)(316002)(41300700001)(2906002)(8936002)(6486002)(6666004)(966005)(36756003)(478600001)(6512007)(83380400001)(38100700002)(86362001)(31686004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UzNBTVNEZnZUR3MxNTYyL2JOdjlOSHN6cW5uOGZ5RCswNFh4SzRXSGNzaGdj?=
 =?utf-8?B?cEtBWFVPeEVSKzNZOGNqcGFuNU1YcFNFTjFJcmFFdk02d0Y2R2RHbGhhcEJm?=
 =?utf-8?B?UmlIMlhWcVIvT3c3UnRxZzB1UDlHblo1NkIzdStMUWVKY1JlRmYwR3pZZS9n?=
 =?utf-8?B?MVphWVc5TkFqQUJZd2o4VWllZDlTV3ppemJQM05lMUtFOTZYdCtpcU00VThs?=
 =?utf-8?B?OUlobEJacHEyc2c1N2VTSnd2RUFxbW5UT2lTYmJ2MUVEKzQ1SVN2VkRHM00x?=
 =?utf-8?B?c25Wa013cWVLcS9uWEZpRVowNlI3czlWb2JpcE4zK0VKVW5RUXN4NGd3NW5S?=
 =?utf-8?B?aThlTDlCY1I2WUN2YWptdEFsQ2h6aUNiMXB5anpDNDg0S0cxeEVLWnNMZG9O?=
 =?utf-8?B?RFI0RTFvdW9wSHlxWHRMZEQ2ZFN2SGJhUVF1MWw0WGlINS9CZG9wMFRTNU9R?=
 =?utf-8?B?dWVENkN1c3BSc1I3SDFxbjVWRW14NGlobkN2UHFUQnc3NDdEdlYrYXlqZ0Rz?=
 =?utf-8?B?RlBYb3RmSXBxbUVGVzdZUldVTzhpWW03c1JmS3k3WXJldmgyc0FWTHFIaTNN?=
 =?utf-8?B?bGxhQ2NWaDF0K2p2OE1pT21JMGd1cGRTcTZ2YnY2bWRuVzRpY1N1NWFZU01u?=
 =?utf-8?B?V3RVOGszRDF1WWJQbkZDUjVzTVBGa09PY2U3UHF1bnFpMnAvOGJvbGc4V3pi?=
 =?utf-8?B?ekk5VWZnSFp6SVRLWjZGV09PSGZRYnRtUHU0Zy8rVU9hMHdhb2ZSVWcxOUZM?=
 =?utf-8?B?VzJ5ZDlEVWttQ2xTSitjc1dIM2FYbHEzb29vbjY3eDdGNVpoNTNrc1BEMUMy?=
 =?utf-8?B?a05kcGlKTmIzSEhPWTJQdGRYNjJXR0JZNVNMRys4VDh0bjBDKzcrWldiRGx1?=
 =?utf-8?B?bDZhMkdFUVdsbEx6SGVSaGNuQThRSzJuazVQVnlsRVVhdTFBODVTWUxkVk82?=
 =?utf-8?B?TS9wdzFOUUV3eEV4MWlmSDI5c05oQm1ueDNuY2V6M0lJbm9qcTgrRnlLNGpS?=
 =?utf-8?B?c28vSnVuVFlaV3RxNVAwZENQNFRkaDFqSHBSemdDV243VE9lNS96K2VxVlFR?=
 =?utf-8?B?MGFxcGlReFF4dTFhUnNqdk1OdE9vMWRlL1Y0eVJuUEZkVVQzaGY0V0F1djUv?=
 =?utf-8?B?Q1FDU1E2RE5jL0I1dWFLeDJnWlE2ODM0SjVEWXFFS2JoUTNUZnVmck0ydzBM?=
 =?utf-8?B?V3Qwdm5IWEZQYXFiRm5abTlGMjNQZVlYUmNweE5SZEZkMmNVRDNvZjlvZjdp?=
 =?utf-8?B?WTFaYVdBWUZPaUp0M01uKzFHQTUzUjJaeCt0M29MYnNKRS9wc3ZrNzlHNVZr?=
 =?utf-8?B?UUx6M1BJZGVGTU1tekxQSEpYdWk0VGdWSEM3dHZZRmk0Yi85NmZyTFZtaGRq?=
 =?utf-8?B?eVJ6Zk42aVI0Z1hxMnBadkdsMU9mcjloV052RnpSWTZMNi9LclNuVkpxeHgw?=
 =?utf-8?B?bDd6UFVLMVpvcGt0WE1WTElYcGU4cFM2THN2dFNDOXZ6eHV3a2hENlExNjA1?=
 =?utf-8?B?Mk9hL3RRWXpJTmtWd04xakwvYjVmb1F3a3FINFhSV3hNQXFIL1BkdDJYd2hG?=
 =?utf-8?B?SzJxRndOdWQxMkZzakZNT2ZXcnEyVkMxcGxvTlJFTFdyMFZrWFkzR0hCUlhw?=
 =?utf-8?B?NEU5TDY2U1psdkdxU1YvZUw2Y2kxaEtQYnZPbEVLcFpwOWhxdzA0T3FEaDRk?=
 =?utf-8?B?cVkrMnIxTzkzQ2orNVVSUGJ6VCtLajJOSHIzbmc2QW41T2QyMXlOR1owVEhP?=
 =?utf-8?B?NjNlWTg5Zzl1V3JwS2hoa3QrVTJRb0dXbWluWUc5L2lFVm9Lc25iTjdiZEFY?=
 =?utf-8?B?blUyWCs5RitGbWk1Ym5XcEFIb1ludlZNZnlBWGNtaUx6aVcxdkVwcWVxS0cy?=
 =?utf-8?B?enltRS8vQ1pTRVFVbXloVjZTUUxqejRuemZDYjVudW1HU01sbno4eFR1T3hk?=
 =?utf-8?B?MHUwK2U4RFp6UUV5SVI3SWw2dTFwdS90c1pGUXJkOWVwRy9hcnFmV25jd2p5?=
 =?utf-8?B?Z2hhdm80T0tDeDE5RjRreVZ0aFl5cmgwUHlVSHc2VEMrNmwxRmNEc094dHZr?=
 =?utf-8?B?M0g5NjhtRFNFQ09SV3d1QkFhRXlTaHhpQTZFdnZpbG5DRlZJSVBpYXFmN1R1?=
 =?utf-8?Q?mpMMJzuDbeIRTAiEt6nfgQy20?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UU1YUWtVMnlpM3BlME1FK3NXVkU0OC9aa2wrc09Iei9hYXZ2TGRoaUN5VGNF?=
 =?utf-8?B?WndkMW1sR2dRbUZHYXo5dzArOHZxc0QrYkY0V3hiazJRc2JKL3JmemdPRnRF?=
 =?utf-8?B?bjVkUUdUc043bzFlajgxdStrcW1yVjdyVUQvV3FtSkR1c1ZFSGljM2YwN2Vo?=
 =?utf-8?B?Z2RJNmxPcnlCVFFKcGxyd1ZjNmxJWWtad2d3aW93ZnJvMFJpRnlUYXJKdU8z?=
 =?utf-8?B?M0o1ZnVLd1lCM3ZGSmZudzRBbjhqMGpzTEpoR0g3SHF5VTZNSG9Ed2ZCbmxU?=
 =?utf-8?B?UldjWHdockNzeTNmL3V1ZC82S1Z6N0ZUR0JPbWlFeDlqb1ZEK0ZQQ3psVU9F?=
 =?utf-8?B?YzVSWVlKV1RZOW9mdXkvMFFZZXVpTE41QkE0N0czQnp3TlpjellQRmJuU2kw?=
 =?utf-8?B?SmNqREhWRmtuamJYQWNyRWtQeFFUVkl5Nm96R3FESzdwREtFZytMSmxiLzJj?=
 =?utf-8?B?RzV2UEJXcWo5QTd5ZEZ2SGRQajB3Nm14c0QxWlBNdDU4UkY0NnVzZGhtdVJv?=
 =?utf-8?B?dGVXMTVscjhrenRvRTIyVlJOUXJIdk5sVFJiWkF0dzAvMGFPem42S015bDBW?=
 =?utf-8?B?NlAyY014NEZVYTRoQzZKRUgzN3VlVkpNMjN3YkxUbXYyVVFGRjBEYXBGaVlj?=
 =?utf-8?B?YjVzTGhVRVBHWE8xQVlBMko0emw3V0YvU3BKalFQVG4vZVF2dEFWKzB2cndj?=
 =?utf-8?B?dk9iTHBRN1FyQkY5Y1Jkbm55OHBLRE0yZ1ZRTlBraUxQbXBvMUFMU0ZUQUhU?=
 =?utf-8?B?b0dOdzdMbzNyUXB3VGcyajQ5MUsyOXdFVE9SQThmNndNbUF0aE1pQzNqS3JS?=
 =?utf-8?B?WnJSVWVQRlhhL0hMbDg3Rm9zbDNiYnhxcC9oZnIwdkVkaW43OVMwYkl4dGIw?=
 =?utf-8?B?NFREVThtdGVlWGxJaXNiRWVoSjhUMlhOS2wwTExJdGVYSTRGWTBzc3I5MzlJ?=
 =?utf-8?B?TDNSZFJnSWNjNVZaSjhTOGU5T2Q0V1l5RnBsMEE2U2lSSkRLQWNtdmp0MEVK?=
 =?utf-8?B?b0tYOWMzNWlhZEV6bTBta1kxeXRKS3V4d2pSSWU3QVViNmhKNDJzWFBQV21h?=
 =?utf-8?B?a1QwWXY1ZUMxZGJDS0VBVDRwdUZ4em1zdmF6YUd6Vk9Bb09aNGJvdmZWZURk?=
 =?utf-8?B?K0FQdGNJcWdDVU82ZEw4MVNkV1lpSlg2MnlUMS9JT3NnVzVaZE5KS3JLeTFC?=
 =?utf-8?B?M1M4bGpLRk9FemJQRkZuVmExRC90M0xFb3IrbmJ1Z3FVQTlMb1N1UmNVWGFY?=
 =?utf-8?Q?boplZLLktLIoNpH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7870255-c026-4bb0-5c55-08db871c9d2c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 23:21:57.0845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkCItZIe2lyxiYTk1Yx4M1X6nxQXk3+o8Ij8PWb1+KGoltKmaLvJpImaDM+Zop3xG7cQm6H4XLRUc1d6XOWkCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7110
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_15,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170212
X-Proofpoint-GUID: JRbTIIDwmgLAXFhw47qv_RDi_dLi2Fr-
X-Proofpoint-ORIG-GUID: JRbTIIDwmgLAXFhw47qv_RDi_dLi2Fr-
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/2023 11:18 AM, Sidhartha Kumar wrote:
> It was pointed out[1] that using folio_test_hwpoison() is wrong
> as we need to check the indiviual page that has poison.
> folio_test_hwpoison() only checks the head page so go back to using
> PageHWPoison().
> 
> Reported-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
> Cc: stable@vger.kernel.org #v6.4
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> 
> [1]: https://lore.kernel.org/lkml/ZLIbZygG7LqSI9xe@casper.infradead.org/
> ---
>   mm/memory-failure.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 02b1d8f104d51..a114c8c3039cd 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -2523,7 +2523,7 @@ int unpoison_memory(unsigned long pfn)
>   		goto unlock_mutex;
>   	}
>   
> -	if (!folio_test_hwpoison(folio)) {
> +	if (!PageHWPoison(p)) {
>   		unpoison_pr_info("Unpoison: Page was already unpoisoned %#lx\n",
>   				 pfn, &unpoison_rs);
>   		goto unlock_mutex;

Would it worth the trouble to create folio_page_test_##lname(folio, 
index) macros to address folio subpage?

thanks!
-jane


