Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121B67F3E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 08:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjKVHKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 02:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjKVHKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 02:10:46 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2122.outbound.protection.outlook.com [40.107.215.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EE990
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 23:10:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXn3Os5u4pNwwGidTrtx/EDKsGTj4ktkmx6xYqXySOLqXiZHqc0pwRkFMP7DrRNlKiQ+/kesQk5j0IjiqEmEQ+ryB4gOq1kGdp+8J0u7O3cSKzKmVJwwRPPhK0mg/S++3hATPebQZD3YLf1AQg7WkHDqIE4U5UzVjKifaDHfN7omNqaTm9ROZuFEJqLJtn1eOn64pQf3/pbmbWIqfiLanNgcS73i+0bZN++XSxZc3rgSrSGzGLTePgpV1Mm8TxULtFnPhlRpB+of16LB4+BCgMArJnQAzqPZfo+l8ybVoYrOLSPtfU363x1t7wKS/Xlj+YuX6KZsAM+FIWgdnmdfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+kB8gMPG4JFe2IeWjeRiQFkUgYuF7SErpgyZkTu073U=;
 b=YtUPUp3KRwGrWlb1OFCHFQvbCRGBZhKw0X14Bu7+nUPfzuI5/MNUP/RrGM33qmRM8rOWbD9/DJb4dUq3NBA10Z24cU29zNUGpq1VzhhckdAPANHICmhivy3e/JYe8q5ziZi9Q1cFwtHKHC648W0hPlxWqNu3IBAbmdbYubwHYMqBQBptde/qG2r6ZB2MNlyaLfdYLEZNz4USyyNfruIJsXmOZZ+B+iSCtP1jZlq77PekontqFy9IjGgsF9/I7IXChrH/cRXq7xyLb6HShdaEnL85BQwEHwpfd3Gyc9vGdgiG4zjQD/av0tV6+Mtad6GB0c+hTrsvM5thEOvuNYn0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+kB8gMPG4JFe2IeWjeRiQFkUgYuF7SErpgyZkTu073U=;
 b=IZSPoiIEoZheS35HkQN8K6gX/LgiOZHXgcSRECYb0EOFQ2IM90FOJTPwINM2kpwcnb9K5UITqXUSZWwb3s3eBXwKVgySY6GXb7j+OmeMnHHn9fP07F6NS0e0Ozdt6cLQuIB50uk5Y20M/PsVK88S/q7+7g9gcoxaqccynH71ynuveT6yF7syix3U6EXfEiiNlAT7f8tlR/lB127e5tg1kS8MIQW3Wa1SvyHO4kYKf5HgmNlPZfOGPSuQDpQS20XKF51IcFW+ib/PBg7Shl3CwuwC2boo6ovC4q8NsInpt2LC3+tQDWyJQ62TqaGg/FCbT8+Lr78+YwnYvrQwogVNfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEZPR06MB6925.apcprd06.prod.outlook.com (2603:1096:101:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 07:10:34 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::bdde:31ee:f13c:79fb%4]) with mapi id 15.20.7025.017; Wed, 22 Nov 2023
 07:10:34 +0000
Message-ID: <d46f66b3-cb3e-458a-ba98-508389a601ed@vivo.com>
Date:   Wed, 22 Nov 2023 15:10:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: ALLOC_HIGHATOMIC flag allocation issue
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        opensource.kernel@vivo.com
References: <20231122013925.1507-1-justinjiang@vivo.com>
 <ZV2dvlKYSDUu6Uit@casper.infradead.org>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <ZV2dvlKYSDUu6Uit@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0021.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::33)
 To JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEZPR06MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: bc368872-2761-4a68-3d7c-08dbeb2a1f2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFCmQb2dSO81o3iacAeArZ3vY1iSDLnmV0/w27kNQVDFwjbd6IqrzSQEwvOmsdOVIpGgxiZeenSfU+hCASrqK8L/JEkmFwKOFg2oB+n/6VQf77DyTnuF3KtXYJzmnUOzrFU76zMsd2oLzTfvPo+kJK+OIzN6PxeyKo8FnR8LxRYfd/87P1LWdz4Dahq477DH0ml+mQubFT7+NLgPQXuQA82X6LGE1+VmIyeHWbWRtltDjVAWPiX7+Q0G4tP6Hmm8o8sWxZ4OjnxGIJDXKKj3+j+OS+RJ0O6n+E+aEloKygLqFbzeubzJZ6snEZzL/lAIDo3r2o6zNfGIumnIWuqI+bWTc5Ra583b4Bj303ATiQTZMVNDNJNzV2bbMGVzQ2I9sZvxw8hYhNlc5ZgHXhOVJ07FjZNUyfE51qXFADCStKNyZcDI5HPkvoaea2yXh1XeLjwdvZv2K5zcftn4YGgwgKeiMZsLrGC5v+OvvBBSkuvylW/kzHXm82jBDZOJc232KozgnOBKXbmChR/5HLy5Fsr4DF2fRGWL+rTxw31sg7bHfQCeUWMVpB6kZDUTcq/EOs3a/PPXK0hqIbpPTqgLFd8OO4OUTWAur6p0z3WBXfGK3EmZXiTjbGff4Q86tsqiMT4SWdOsES8KkIi8XwGtLfbw8/VHrHFsn0RvJTOl2xbLjWsRksf+oWFmGeYd5BnJNYa5OhJBjD0uaeTGAA5bdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(376002)(346002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6486002)(6512007)(478600001)(26005)(86362001)(66476007)(66556008)(54906003)(31696002)(6916009)(316002)(41300700001)(38350700005)(107886003)(36756003)(4326008)(2616005)(5660300002)(38100700002)(83380400001)(8936002)(4744005)(2906002)(8676002)(52116002)(66946007)(6506007)(31686004)(6666004)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTV3a1l1b2E2d09RaGFPT0dMR2hHZXJuSnRTNWYzKzJLcWpsellRUy9pNE1G?=
 =?utf-8?B?b2s5NGpKWjJjWW1wZFpDMGVLeXc4b1BQUkpUQVVIQW01VEZ6YzNpNUNhRU1i?=
 =?utf-8?B?L1FlOEJGRFEvNE1sa042dTh4YVJ2OTFDU2hudnNDK0RrRHdIMWhXK01rRXVt?=
 =?utf-8?B?UEs4NGpPS2h0WEhGNHFXUDZVbzkrZ3ZjMTFOSG95TUhmVm9Ic1d6MFB2T3dP?=
 =?utf-8?B?dk96VWRTdy8wRjZXMUxPZitYWXJaWnpZRy9oTHljdHE0UmlSOXNxSUtYUWVN?=
 =?utf-8?B?a0lVeVNjWU1sNDlOOThySzRHOEI2d1gzdlNob01wVldSOHdIZjR6a0R1a0Nv?=
 =?utf-8?B?UURWenBPZnRpOThnd3o2T2IwcnFXUjIwOHZOeE1QMU0zQ2Z0N3VZOEpaTzFP?=
 =?utf-8?B?QW5Nbk5YWkRTbXdPd2d3VG84UFNUcFp6TDU4azI4L09YZFQyUHlnVW9Ea2dz?=
 =?utf-8?B?UHZhd3JGNnZiZkR6Zy9oektCRTBGSnpqWS9NWDQ0ZXpZNjdzckhIb3NSd1Q5?=
 =?utf-8?B?N3RZdTBwenE4dTVHU0NhdnBTMTNKVitsS2R4NzJ3bnRBTGpwZ0tnTllPNWx5?=
 =?utf-8?B?WkxpOWpQZXdvYUQ0d1VKUUFZU1FZcjJwMzFLYVdZYjVyOWE0WThTemtjRm1z?=
 =?utf-8?B?eVBETnYyWTliU2JnMlFka2hLdFgvQ2JydS80REUwNDhSSklNZEJLSzdXNE5k?=
 =?utf-8?B?RVFUbGFiMi83a0Q4ajN0SVBYQ1VQcnRTTFoxMmhXQ1BucVB2SlpBZURkS2Fr?=
 =?utf-8?B?UUE0T3I5b1Z1M3kxSGRWSGFaKy9LUG5QREFicm52L2tibHNTcXY1azRDNTJG?=
 =?utf-8?B?VFdlSUlQK0pkQmhNMUxyK09IWXNic0FENXVaRk9rd1VGSnlHWkRTYUs1UHV3?=
 =?utf-8?B?dzFScG04eXVlZTZpbTlxQ3MvUzA4VlJDVEo0WVhpZDhvTUE2dTZzNm9WYXJv?=
 =?utf-8?B?b28xM3hwQTliUU1IUURBL01md0dqaTl6U0NsZXdLb1N1MVFXaTVnc2FGSzRY?=
 =?utf-8?B?akpBNGQxSVZZRGpsMThXVUxxeW1CdklST1JJSW5XUUlPN3lNTHU0b3BOeHZK?=
 =?utf-8?B?cFFic29mbTJLa05wTnJhdjd4bnlJVWNzTkZjMFBjZkJNWkF1bHVvazRJZ3hQ?=
 =?utf-8?B?SW41dTJxbU1SVzMxQXhVOEN5L3BhaElQbTdrRnlDeGhNYjJQemE5ajhVd2J1?=
 =?utf-8?B?NTRrVStJRUYvLzVLNXZsNGtZQVBUUm81cHlWQTZYSVUxUThlVU9BNkRTUnF6?=
 =?utf-8?B?Nk1IcnloZnNhUFJWY0dpcWNaSTBNNXpHZzRFM3VZdGtzU2s1UW1mSGVwQWR4?=
 =?utf-8?B?eUdpZHJhM2pBbUQ0ZVdJTkwzemxEdFdTTGJOb3YxOWlvQVBIZXI3NnY3bXVO?=
 =?utf-8?B?SVZ0am1PWnNOY1BEVkRidDUzRGg3V093VFpQdG9xNmNrSUFxREZpL2NvalBH?=
 =?utf-8?B?ZmRhdWZBWDVSVC9PMlU2SlB1b2lSNHpoNGFVT0Y3TjJqTWhjOFRkb0JFVGFW?=
 =?utf-8?B?TmhJdHFlWHNqdE5PUWV1dTN1OFAwUVZtZHN2Q3hmWnpOUG9uNTJ3bUFzMzh6?=
 =?utf-8?B?Rk9BcHN1WE5NSXZFcm05MndBQWczTWNHd25ER1dTYm9MVEpSS1VKMXdvVTlk?=
 =?utf-8?B?RC9MbTBFbWZ6WW95Zm5nbHVkZ1Mzc0xxTk5jbXpTZmF6ZXlZam9CYm5nUGI2?=
 =?utf-8?B?amJXcS9lTWlYNVN0S0ZnVVRUTEc0ZTdJMU5ia0J4WGp2SGo1QjFzWExsZ1BS?=
 =?utf-8?B?NzkvMUhwaE9LeDMzYWJQVzBTNzgzRUhkakVoTDZBanNkZkV1T21qc2lkK01J?=
 =?utf-8?B?OElsdkVFaW8rZ3dxaGFXZFdSZVh6bTNSR3Zmb3ZDaG9PZllER0tvN0JPaEVj?=
 =?utf-8?B?ZzVvZDl4WjJxZmFTZmJYOGdrd1QwbWtJK2xUYmw4Q2JQZGJJZ3IzWEVOemFs?=
 =?utf-8?B?TmJUQ0FDSzJsOXIzUFZmSnl5MDEvYVFUeVhPdW5RSFR0cC9qMnQrN3I4c01B?=
 =?utf-8?B?RTdKenppclFhaXdTRnBvY1loL3lUZFB6Qy90dUU3S0hCL2o4Ti9SanZLdDZz?=
 =?utf-8?B?WE15SFBlS2t6RjdGZ0U0MVVhc1FPVDEvSHJ2dWhDdS9jUWJJN2ZIaWlhYTl1?=
 =?utf-8?Q?2y7UOmrpIENJHsBKJ+lqgLFUl?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc368872-2761-4a68-3d7c-08dbeb2a1f2c
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 07:10:34.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OWG24qdvmHr9n+dZM4Uq7MYx/F2egp7qSJpthFahNDe0nXSglkKmXzhEiZpsWDT0Znsn0sSI/TFdrQm+iHKxsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6925
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/11/22 14:20, Matthew Wilcox 写道:
> On Wed, Nov 22, 2023 at 09:39:25AM +0800, Zhiguo Jiang wrote:
>> Update base on the latest Linus' tree or Andrew's tree.
>> +++ b/mm/page_alloc.c
>> @@ -2851,9 +2851,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
>>   			int alloced;
>>   
>>   			/*
>> -			 * If pcplist is empty and alloc_flags is with ALLOC_HIGHATOMIC,
>> -			 * it should alloc from buddy highatomic migrate freelist firstly
>> -			 * to ensure quick and successful allocation.
>> +			 * If pcplist is empty and alloc_flags contains
>> +			 * ALLOC_HIGHATOMIC, alloc from buddy highatomic
>> +			 * freelist first.
> No, it's still based on your earlier patch,  is it really so hard for
> you to read your patches before you send them?
Sorry, I didn't understand your meaning correctly before. I have updated 
base on the latest linux-next tree in patch v4.
Thank you for your patient guidance.

