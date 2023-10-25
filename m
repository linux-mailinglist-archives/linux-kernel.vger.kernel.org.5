Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD317D603A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbjJYDE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYDEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:04:55 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2119.outbound.protection.outlook.com [40.107.255.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE585116
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 20:04:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTHvKpwjBVFQ8gl3cB1k4kGmdV81nvC7TLzzAjovARGBuLp4ZgkP8Zid8Us30uyzk9t2r5r5KvteCA+ecvglaEkLmNOmgMg8+HaiJqX2osZiFUg1vMsMrJBcNN2TqT/FNdFL/8cLw0JTNnWDNKiVRooE1ZfE+nzIYRbRojg7+52Rq7ffzKs6//FFqDJgi6RBMFBTt4CZ/ri1QrlQXSygg4nbxLhzdQJf91yyKd2ZPExL+bU2Ce2DUCJFCWTY+STyQ00lTJJF9qxJUiGI27nTgtCmy5p7whv8FkN66NxH/NTgrFqObDMyJ0cqw235SJwNayUaf9yJsk0q6acw0tW/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu/Q52XEzXEyAREZKNcBvmrBTEibyodjMYRR0ulNqsE=;
 b=F3wwpHuiJObKD6jJr5BIvBZlDLEaqntOfmZABYcMcXcLn1rQfXA3sxC/l9t1yWbEdppLtluLB0tX138ckrJTWfplDk0eHcYNuqSbhND6jFIVlM/alvPpWVl0HutLuJN1ExVYKPSYfTyLCgf5ZHtbKSfDJmkTEZkM5tzW0H83Ld8K84DxWQ7JwGJWKUA2OEyrS03a/1yw9EVOmth1I6r2e90oWnY0sqpTDu/jfG/uwzvl3QcOlHMDPlL1M76rZ/HcyjJBFwPiHWf9TLi/680jZ9kLaBBGP0CejpNPMOHqwqR9kbm+skYhxNZEfF14qg3pw0FHWKD6HXkMsm2VekB2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu/Q52XEzXEyAREZKNcBvmrBTEibyodjMYRR0ulNqsE=;
 b=ezuzAyp7Z75ZwftRJnhWu+tpGseZ0+raUw7pVoiAWfFyR/cPzF4ofIoAvRkv2EIyohNwfHDCoWWri0nEioerGv9TkxYfiZ0peYJ0sPFtCvzDgJe9o/YgXQmvX6SEAdk8ohG0qG+AHcf0RH3NVE6ubB5ekgfAbHSoiPaA90ossRsKJwQCZU2DR4n6B25KYAl1dwWX2pwFw2mpAXi08+On4MdTkYuiXy3LvCtgEVHQAe64y6CxGJm9YFL9niQcKOesayrFCApL91Y1HnD5eSSYdhc//3h7SQ52l7Aiq1mqKkWX/l3eWCGSBULpiGXvPLPUkI61tl4He8GLQ0Bufs5sMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by TYZPR06MB4478.apcprd06.prod.outlook.com (2603:1096:400:8b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 03:04:48 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 03:04:48 +0000
Message-ID: <d2d78a5b-fa57-4e46-950d-e8e48bb020be@vivo.com>
Date:   Wed, 25 Oct 2023 11:04:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: vm_flags including VM_EXEC can exit timely
From:   zhiguojiang <justinjiang@vivo.com>
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231024144913.421-1-justinjiang@vivo.com>
 <a1357e75-986a-4e00-a987-9d8c767a42a5@redhat.com>
 <d1c01214-4548-414d-be84-21c38cfe3ede@vivo.com>
In-Reply-To: <d1c01214-4548-414d-be84-21c38cfe3ede@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0048.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::11) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|TYZPR06MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: b5e8dcae-b130-4069-5fe2-08dbd5072586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G8oO7pnv7COL2JxM9Fa7ze7uVMri11YGGz9sNV56DBmywV86irEF+GKrrQxfhkj1Uv3L73bjfPGetCygfge9IMJxsIxvIKOb9iyGmXBnhlTlKOa15MEFtLqw2QadBA/J+HfIOaG4Kq8yvcIkBSbqmHnKZ14r+IQsTqC4IKRMtgn2WR+BxQ0DqAUROj8CpwNd6D4RQYhwl+gkQ3rdiPIFViw8YOM2TLM2AfVcLSON1nPgwC1L5TjrbEIwhgWbmRht71x8TpgUCyhNLX5Z6eNiUg8cE6hHId2rNkD6Z3Hb+O83ERlTtmePJYSwlnwowf28o2+FMVdNSowoJO9i2LagzL7HRpNVyMyly7bKU0SQUpXbxPlJD0ScygvTZIxDyN1/H0EJLan+KXRaDRvZqYxZeGFX26OKDcp/NuhIMUkWJhEc30lU5RSvn5L3vgjP43THPMc+Jryg9cMpWcQDbVBMwfufVGLIsDObuPzpo6ZxnSs0SleGwi6Gb+FhiqncLpXS6qe/9XvWHEu+QvzznFMHsqSad1Ih0RuoZqCmd/jLDHV1Q2WsT9kOc/9byW27XewQlxtIyVZkNK202OE0pac8hN6W6MV3vPDCAR+wHL/y9U132yxuiOo75BA8xeSnuHLEnj2sRlLNQF0N12eADyoM0/NlpS2oRFzWOpO0wu+8IOMNBfoZfyNv+V3s9XTBDGDl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(6506007)(6486002)(53546011)(6512007)(478600001)(52116002)(83380400001)(2616005)(26005)(107886003)(2906002)(66946007)(66476007)(110136005)(66556008)(5660300002)(316002)(8676002)(4326008)(8936002)(41300700001)(38100700002)(31696002)(86362001)(36756003)(38350700005)(66899024)(31686004)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWF6dzVKaFY2UVJFKzlGNytuam4rbTl6aHNjZ2dscmFZekRaRGVyWnRhVnFs?=
 =?utf-8?B?R0lPeDl5VHN1eExJYjhmblVtMXJtNDJmWGl4b1ZuYWdkRnNpcUp2azZYY09v?=
 =?utf-8?B?WkR3Q2poT29Rd0lic0tjWWN4cnFGVHhrRm15eXB2N3Z4UjZRMFRvYi91c2Mx?=
 =?utf-8?B?TGpqaFd6K0VIYmpVTEI1Nys5c0ZWdXp5YnpiR1p5V0ZFVnFxM3ZBK210djBP?=
 =?utf-8?B?dmNXaHpzSTROcE5IbnRBUi9WRTkrUlR4Q1l2dkZnbWpyY0R2QTRZaCs0NXRS?=
 =?utf-8?B?NTI2b1ZVRGhwZUJzVFBNemovTzdCVUhtY1g3NlpWN3RhMWtDRWh1MDFvMWgx?=
 =?utf-8?B?SVhycWJ3TXlNcWwrZEFkYXJEUWlIdDZoUk5YZzZHdXJ6UU5HeWJMUmpXdHov?=
 =?utf-8?B?dzk5MnB5Ym5NQTRUTDNpWDB0amlsTVdaaTZ3RXlQV1BYeDhGMXhBS3R1YS80?=
 =?utf-8?B?ektmNUdSdnFOT3R4a3Iyd245bklaTFhLR1NJejZ0bVdLVVB3T3YvczhIN081?=
 =?utf-8?B?bUlXSlJiWk14UG5SYmwyN1RwMDUweDgxTjlyUXZwZW1WbmErNXkweTdsdUpS?=
 =?utf-8?B?RXpDbE5vMkIvNGhXMGNUYzgwUzdSVEpHa3lJQ29kSnhLd3VXcTlpclFYRFMy?=
 =?utf-8?B?T21PWFVZOGdkYzF1RndpUjhNTVFiUGpxQnJ5UG9hMFhzNW55TGJ2ZHNwOUc0?=
 =?utf-8?B?WXRqTEhaRVdEeDNCMDNybVpTcVVXcSt4azlodTVUaTlRbG1HdzQ3VGJidXll?=
 =?utf-8?B?elFQLy83S3Y1SGExc0RFdVJ1Ymk4UVdiR3BzMnp4SERNa0VkOUJLbXBHbVpF?=
 =?utf-8?B?WVhBM3ZRc05lQTYrR0l6S0ZqUFc3ZnM1Q2RsczJSN01qTWFnNEtnSEs5OXJP?=
 =?utf-8?B?Tnh0dzVkWDlpLzYzZlQ5UTJLdDhJdk05UnBXbXJsSXdNYldnWE9aYndaeGRH?=
 =?utf-8?B?cFpnVVg2Wm9PMW5kd0Zkcks2MzZKUG9Db01RMWc0TkNFb2NsOGlkSWF4eE1R?=
 =?utf-8?B?bklzeTF6NmNza29ZdjZlRlRreFdVVjNYS2tzbUI1blVCTTYrSGxkU0NKNHM0?=
 =?utf-8?B?SXZIallPM2RWemNWbnhqM3hXS1o2YUR6RnFxMUNCKzdydDZhU2haMGdkRVYy?=
 =?utf-8?B?M28ya0lQUXNRZXdwY3dOY0N2ejh0WjB0MlJnZjcxV2U1ZStZRjB4VXBmL0JV?=
 =?utf-8?B?aUplbDlsSUNPNlBQQWs3UmVHOVFpSnU0VlNBWGlvNk9IRGZ4b3VWSDJocUQy?=
 =?utf-8?B?U2lSUVlYR0pDNHBqTDczUEM0QllmeFhibEVhWGZDS3BlNmtWeG5sMGJOblRN?=
 =?utf-8?B?RnpEajFnUVY1ODJ4WnJ5SEprM1VLMlZCWUFESU5aY0dsTUxjOEJFWGxhNy9P?=
 =?utf-8?B?M0dvWCtmaWd5L3NoU013WHZJTHVUL2l3S3FDcjBCOWt3bU9mRFkrWDdLZXRF?=
 =?utf-8?B?aVdnVnBNMi9BZEgyZldpOG05SFFTa1BzZlRLSmFOM2pTWVJrUkYxU29iMmhG?=
 =?utf-8?B?bER3dkpNR2U1Sk10UE9XSitGcEU2UzlTdCtwN2lVK0gxQkFlRERtNkRXQTRX?=
 =?utf-8?B?aWNOVWRWdk9TMHQ2aXRoQ0hFbmNzNDZpZnpFbFNDTkJlMm1GZENwMzhnTnNl?=
 =?utf-8?B?OE96YmkwZit6WWRnelJNRUd1bEJRRGlKOUZrbm9acTE2cmlwWDF1dTN0THdR?=
 =?utf-8?B?eTZ2NU1KQ1pXZ1hqWmkxN3lIRDlVU3JMT2ZDTXJsVXIzb2djcE1rS2V1M05t?=
 =?utf-8?B?amlaRzhoaFdMM09qMUtLZUtkd2djTzV1TkVXYVZnSEhvbVVIYmpIRFNzeUlE?=
 =?utf-8?B?VmxiZy91aFRqZEg2V0dyUnRibGNOMTFGMDZxdmNvYk5FcEUzOWV3bjQ5b05x?=
 =?utf-8?B?dnNJY0lQWExySUVrcUhMQXV1MGExWjV6L1hSRmhiNjQzTFBnb2VMVzJ4ZTll?=
 =?utf-8?B?WFU1SWpsRndTVDRmN1pxVG9sakw4S0dUdm1xblRldkFmUmNNTzU5VWRxRkJV?=
 =?utf-8?B?dW5QaUtyVTBEbEZsZDNtTUFnclZCTWVGSFlUZkpleUFSdVhTRzNqSjArZzJo?=
 =?utf-8?B?WTkwN0JOMG9reldrOFY0RzQ4TTU0b2FHY21leVpSa2x0QzdjaERrRGEzVUFn?=
 =?utf-8?Q?Bl0vy5qIxGpdMLX8slX2Uz/yx?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5e8dcae-b130-4069-5fe2-08dbd5072586
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 03:04:47.5982
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XZIufUfLxQmkT6UxHnAVqk7zlQNIslSbBE1sSHRhCF7MSXD6KtQdSSYV3+6dbxI1RDlONFID/hLss7vwBssew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4478
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/25 9:17, zhiguojiang 写道:
>
>
> 在 2023/10/24 23:51, David Hildenbrand 写道:
>> On 24.10.23 16:49, Zhiguo Jiang wrote:
>>> When pra->vm_flags include VM_EXEC flag and folio is file detected in
>>> folio_referenced_one(), the folio referenced traversal process can be
>>> exited timely to reduce the detecting folio referenced time.
>>>
>>
>> Can you further elaborate what the logic behind that is?
>>
>> Why can we stop here if we're dealing with a pagecache folio in an 
>> executable VMA?
>>
> Functions call flow：folio_referenced() --> rmap_walk() --> 
> rmap_walk_ksm()/rmap_walk_anon()/rmap_walk_file() --> rwc->rmap_one() 
> --> folio_referenced_one(). And folio_referenced() is called by two 
> interfaces: folio_check_references() and shrink_active_list().
>
> 1. folio_check_references():
> When (referenced_ptes > 0 && (vm_flags & VM_EXEC) && 
> folio_is_file_lru(folio)) is detected in folio_check_references(), 
> FOLIOREF_ACTIVATE will be returned and the folio will be added to the 
> active file lru. So when VM_EXEC is detected in 
> folio_referenced_one(), we can stop continuing to detect the reference 
> relationship between this folio and other vmas, and exit directly to 
> avoid unnecessary traversal.
>
> 2. shrink_active_list():
> The shrink_active_list() is the same as the folio_check_references().
>
>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>> ---
>>>   mm/rmap.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>   mode change 100644 => 100755 mm/rmap.c
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 7a27a2b41802..932f3b7e8521
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -884,6 +884,8 @@ static bool folio_referenced_one(struct folio 
>>> *folio,
>>>       if (referenced) {
>>>           pra->referenced++;
>>>           pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
>>> +        if ((pra->vm_flags | VM_EXEC) && folio_is_file_lru(folio))
>>> +            return false;
>>>       }
>>>         if (!pra->mapcount)
Sorry, Patch mistake in writing, patch should be:
+        if ((pra->vm_flags & VM_EXEC) && folio_is_file_lru(folio))
+            return false;
>>
>

