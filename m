Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA727D5F71
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 03:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjJYBR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 21:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYBRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 21:17:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2117.outbound.protection.outlook.com [40.107.117.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380F699
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 18:17:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZavXyQ7QQRWN6TUsjjrLaVZqvrHDGjSRh8qwCGX0G8BRrkGMecEBu5WctfGhi1F4qehkafSNwnfrYOIM9tKPu9jehiGPBAYn8bul3A+JoLY9JhYOBK5/lJUbslLyZ/9qHtIyVWZGouoxLWbaRXuQWtF6UbjUUtAapr4VN6A1f0mmvn4lRqJUyyXSWEnCsXG/nc6vEKAbSK3tiwZCfZhCDftqx/ExJmBJ2YVFlJxHfhWmt6Qj35ivuHCY+p6zYo/IJvjNsdEw6+okj0tDJ+F5HAfb2BNRe87y+bfmMtT++O0DxSbyXPf7xGUU8eW10BBiNUnH1vUkWnwufHijtR0xAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMIk0fLQR3yvEDMCMVz4ZLngcXrdn835HADzIizvTe4=;
 b=mPxw21gsRF+Om2Euto5yMk/y4tVq52VosUVWmJH7phCMup/JgixvKU6nZn45jajcLc0Ei9Yqvec+trR9k78cdwYtMrPcBt3YNrJYUYNnhuf0PClGToihD4P6nffjwoZ5fG0uZ/Ts/tkHB3ifPpvO50pnO3ej3S9aKJrBAxoq+dPupRMG2PArQYY3mkozPC2UuDOfZXOQzClL+S03p/ok61vBKGghotHduy6rbd/F7KNTjdLe8zrlc2dIRS3v7ROHPXWlLssSFoOwhkV6rC2Qb8eoVIRARkp/0VpNf2lqK6p0pv2DqRQnmLwXelmh32C6dksrTXIOIQmufp1Jere1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMIk0fLQR3yvEDMCMVz4ZLngcXrdn835HADzIizvTe4=;
 b=cIaIF93Js5pVw0MdMicuuRrel5vQvmpI9urz6Qt7wKduF3JWWOA/QQ+3pOt6SIm0cMUuYkgYekP4QPnjOzUcdup/3IW4O8v5GF7pluq6R/RwIsbcyCnoIVVJxA1K1B4yXV1SSaC7X0XgHP3sK5iPAZqFesL+mcx80KnJCruhKHCeWydz4grryYcLx6lQUiCCUq/v3OGr+wwR4Z9NM1M/C+SIDkIGb56qvz4C4ouVArTC1pnXI26f28Rokd03fntDT3JLfteTkb6NIkXI7Fu2mfHwKO50dCiuUesSGV1mTdbZpsP5b57x82rntqrLxtVMsZgor+ob5kjlKT3aJZ/iDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by SEYPR06MB5937.apcprd06.prod.outlook.com (2603:1096:101:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Wed, 25 Oct
 2023 01:17:47 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 01:17:46 +0000
Message-ID: <d1c01214-4548-414d-be84-21c38cfe3ede@vivo.com>
Date:   Wed, 25 Oct 2023 09:17:43 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: vm_flags including VM_EXEC can exit timely
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231024144913.421-1-justinjiang@vivo.com>
 <a1357e75-986a-4e00-a987-9d8c767a42a5@redhat.com>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <a1357e75-986a-4e00-a987-9d8c767a42a5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0220.apcprd06.prod.outlook.com
 (2603:1096:4:68::28) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|SEYPR06MB5937:EE_
X-MS-Office365-Filtering-Correlation-Id: 05bcdce1-3bc2-47c3-98e0-08dbd4f831ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rGgoBXn+NHanCc+PlrpoTi2IY2yBSsj1HXp2lJBvda8Tk9lJhVza9VFM9E1TzZTjO1GJ7eCM8rwwSfAgRzijorAcbz7Q8upy9SCycmLp1bK5lWZsreWsmBF9ZCpc4f/mtgF2D6n6DdFRdhRQfPOMFQkLOEbfJWtSeqUxP9lxwcRwxOhO/xyDRPNKJ5n+og9kmKrI+KLL9P19EJFZ2XsqcZVAriVZ+eNlooVYz8EWb7BLyMuc7ApFLxjBbZiqlAkOkEuS23S0g6g/iNnYwl4YoNabCpvesY0CJUSfwvoOUvHdd3FdcoEJ8X7dTfIZiRnu6VTT1vbQ2c00QaymUCEBhuCPbWlrRFYnjD3hH2YfAr/nKLH4TOSo+zPrMii4hbJmACWW7J9XnS+tYIrCJodjGIuxvlGnMX5+BNLpM4rQvWoY8DVVpzl4gSuaGwpRS9TIxLjghi2FKHsLl6DmuqXotOBrGtf3qhBcAIjWBcUJKBO1n5kCdGJkDZHccinI6odfsz3q989LngU4alSFHPQoFohVe4VXA0a/nJb1o65A+sgjiy7yhiPfU5ORji/JjCkfrFD1sAvV1x5kFLT243k9cmIMfsy20m8dG38XFEl1au34fNnMr9OLVVtxgnXWsSBF1fvIxbhra3vt/dkHtQtyEl/OxL0EMgid8jWPIKhxAw12yFpS1Iu0LpPL1LH/K1co
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(376002)(366004)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(38100700002)(66476007)(86362001)(66946007)(110136005)(316002)(66556008)(6666004)(2616005)(6506007)(107886003)(478600001)(6512007)(52116002)(53546011)(83380400001)(6486002)(5660300002)(31696002)(36756003)(41300700001)(4326008)(8676002)(38350700005)(8936002)(26005)(31686004)(66899024)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0EwMFhpQjM2RnlmbEhCK0xCVzhrU3RzcHU2cVhiK09URnh3V1lhclV3S3hO?=
 =?utf-8?B?dFhyTjJVMXNWYng0STJicWR3Nk5mSUFOMmQ3Uzl2b3M4UGNMR01XTVZ4dm10?=
 =?utf-8?B?OW44dExSUjkwNWtIV1dOMUtOeTJQTERNM01JM0RDK3ZMQ3dmQWtjQjVJWFhx?=
 =?utf-8?B?NGhIcXNYM1RrTTVCZko1SjdqOXBjOFA4WUJTWDlXZXppNnhyWElyWTJOTnZP?=
 =?utf-8?B?eHNMMWhkZXNkVmEwSU9haTcxc2MyZXhSdjZ2eVl2R05QY1RjbXR3ZE5nNEdB?=
 =?utf-8?B?UzBZZWZFaHpJMmxCak1XeUJsaTRwQytmODJzUkwybWxCeFpQeDlWZzQwWGUz?=
 =?utf-8?B?MTRUUHhmT05XOVl2aDRtN3ljbGJ4Y3JzSTk1RS9NWGFsZVZxREZSUEI1Sm04?=
 =?utf-8?B?TDJucnFveDhCZk03bEo1NjczeDAzZkp2Q29EdUJpVUpubFRyTmpBRW9pZWtK?=
 =?utf-8?B?a2plaGt6Tis4TC82WkhVb1pWSjc4R1prbWVXZi9yOEhmazh3d20wcXlzQnFj?=
 =?utf-8?B?TjBzMkczbC9uK09HenFJV0I3ZithY0I3VGZZZGFlQjFzSVBZd2dBSTAvN2lt?=
 =?utf-8?B?ZGhiTTBaZlZYV01sbFFTdndhUFhSUXYrOWFWOGJpdmU5N2dTaHUrYzJ5SHlR?=
 =?utf-8?B?MTNTN2dJbk9sdFB1NGdPalc4MVdldWJ1aVQrd0RKTHVjaDk5TlVHdjJYMHBC?=
 =?utf-8?B?aU40bDJOdzBXaHVhSFNkdEJCRzZjMmdzWG1BQjNaeWhVZkJSTU1XS0pJWlVj?=
 =?utf-8?B?NVhuTDVlbFp1dGc3OWpzaU0wS3crbXlUWTdmUis3d0NQK0xiYnJ1ODl6bDhE?=
 =?utf-8?B?UzBReVpTTy9wdUt4c0pwV1BuQUdSOFRCQTdISWJpNjJHUjMrTW42M2NldGpr?=
 =?utf-8?B?VjI0SWFjTWVhdXpRM3ZKM0ZSUTVQdCt1Wk1Sam9mWkJORDdYWFhPNm8yV29V?=
 =?utf-8?B?L0VhNUFIbEFzb0haU3haMVVvMUFGN1JZYjNVNTZBNEI0enhrOUtOTUMxVVZq?=
 =?utf-8?B?aWRnS2gvWHVXOElpaXNoSlhJSlo4OG9WWVFlcDg0blhhZi9HZ3JVVHVSTGZu?=
 =?utf-8?B?cVpOZTMwNVc5bys4MFZ4UVgyNWRxbXNpbEs0VTlaMm5xM1JzOCtVbGNnblFq?=
 =?utf-8?B?VmduU2RtOGlqYmxwU0l2WlBySytNMHJFbGF0a0ZBRCtwQUY1OEVDSlBjaGd5?=
 =?utf-8?B?cm5MOHNZdmEycGJYZmUwNHB6KzNDQ2xZU2VFLzhid0JENDB0WU9SSFFzeGht?=
 =?utf-8?B?b2MxeUluYXFuL0grempKT3BoTjVtRlhYaVdFUWVyL0VuOFlCek15MVRzZTJh?=
 =?utf-8?B?bHY3TnVxYVNkVjBjdXFyVHNyNlNUZUNPRWZIVnRmem5DN0Jac3NjWmtLZTdp?=
 =?utf-8?B?WFkvU1FVWUV6Nlcvb1IwamErZUVLbHRqYnpsbGc4ZDBZY2VEV3VHWHBVdS9Y?=
 =?utf-8?B?TGJkUWsxbGoxbitpNTh1NmM4VVpMVHBMRlhiMnZGRzdpRDM3eWpyaGl2VnAy?=
 =?utf-8?B?V3Y4dHYydStNek5VZU1sMUI3bzFjU2JzaDVSZXAwek9yNHIyTE05VVEyZ2Fx?=
 =?utf-8?B?elJBZE5vaDZOTFdESlVDalpqMFRWN0Fxb1JYZ1lsSnl2NmFBcU5BaEsxYUpQ?=
 =?utf-8?B?azBZZm0wR1FKVlllb3FCZ0ZnalBlQVU4eEIvMDRHejZNaW9iMlRDdzJSUU5v?=
 =?utf-8?B?MnZNdEdRK01URnRWTWcrWElqYjNXYlVtYks1elZqZ0d4ZnBCOWV0UStId1VI?=
 =?utf-8?B?Y2xHaU9xRlBQVVBoWVl0NVZHd0pvVys4cUY1YzBpcjM5QWVaMVB5ZngvNVZ2?=
 =?utf-8?B?SWdLbjBJaXJncGgzazVxNldhNkNYYlZZMGsrbXliS1VEdlNGZmQ0RGc4Lyts?=
 =?utf-8?B?S3BtdU02VHZJc2VBMmlydTdpVHB3RjYwMytVRTRxaW1FSUN4L0oyOGRWbmgw?=
 =?utf-8?B?R2dNL2FaWmxvc2tGU2RBb0NHUlpVVVdjTzUvd2toeWFya0VRdmJqZ2tsZk9D?=
 =?utf-8?B?K2RyOUd6VU5jNFI1NFFkUDdwcGg1dmdEYWRFcTRWdm9TRllhbVFIOEg1djha?=
 =?utf-8?B?QWlvVFRtK1pmZ05hRFVDMXkvV1BhTnlZRStUZVg1b214K0hWYUR0S0d0aDJT?=
 =?utf-8?Q?NbmRGbKtPJyZxScRLUx/exa21?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bcdce1-3bc2-47c3-98e0-08dbd4f831ef
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 01:17:45.9549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl0nmTDXDWl0lXECOFVUrcpxQgZqST8q879t3IIHiM7CQLNYUo81CCXXFYFBQkyvU0wXbppdclAKhk8ElLoocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5937
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/24 23:51, David Hildenbrand 写道:
> On 24.10.23 16:49, Zhiguo Jiang wrote:
>> When pra->vm_flags include VM_EXEC flag and folio is file detected in
>> folio_referenced_one(), the folio referenced traversal process can be
>> exited timely to reduce the detecting folio referenced time.
>>
>
> Can you further elaborate what the logic behind that is?
>
> Why can we stop here if we're dealing with a pagecache folio in an 
> executable VMA?
>
Functions call flow：folio_referenced() --> rmap_walk() --> 
rmap_walk_ksm()/rmap_walk_anon()/rmap_walk_file() --> rwc->rmap_one() 
--> folio_referenced_one(). And folio_referenced() is called by two 
interfaces: folio_check_references() and shrink_active_list().

1. folio_check_references():
When (referenced_ptes > 0 && (vm_flags & VM_EXEC) && 
folio_is_file_lru(folio)) is detected in folio_check_references(), 
FOLIOREF_ACTIVATE will be returned and the folio will be added to the 
active file lru. So when VM_EXEC is detected in folio_referenced_one(), 
we can stop continuing to detect the reference relationship between this 
folio and other vmas, and exit directly to avoid unnecessary traversal.

2. shrink_active_list():
The shrink_active_list() is the same as the folio_check_references().

>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>>   mm/rmap.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>   mode change 100644 => 100755 mm/rmap.c
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 7a27a2b41802..932f3b7e8521
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -884,6 +884,8 @@ static bool folio_referenced_one(struct folio 
>> *folio,
>>       if (referenced) {
>>           pra->referenced++;
>>           pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
>> +        if ((pra->vm_flags | VM_EXEC) && folio_is_file_lru(folio))
>> +            return false;
>>       }
>>         if (!pra->mapcount)
>

