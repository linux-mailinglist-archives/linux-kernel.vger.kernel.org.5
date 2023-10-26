Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E127D7A9F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 04:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjJZCEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 22:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjJZCE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 22:04:28 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2104.outbound.protection.outlook.com [40.107.255.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE71C116
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 19:04:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5HTihSOXJphscdCZWDXXMJPQ+4Bm131Fxnfr91/Rbr4Gw3CVB61LxH0buZ+iwneMThdC4jEKoQHHe2gWZVh3/zUrNzNiT/7Wx/gvW3J/zuzEewyX7uXsf2xzU2AxvcxrVpoNE89PK5lr/8UfTqG0mCaNbHk57fQSrzPStjviQKXe2cR3GbipELfugcx3lpfFtxQTP85/nk9tjzRE2l6Ye0v3m0JcZfW9wLaL3FRZdKYpkt8y5xLDRLdDMeHO02U/+g3iPIy/WSuGnQje3TDxBT11CB7uRjTmfyaQxg9X4BZyyGrftKyMdV+knXvbsOYSgOqhqSSEsJzVSNN5nDyiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+HivNavOGrG0nUW7ZpmIy8FWqZq3a/11qKX6RtX0P00=;
 b=lpUbIlVQkhbMmyNGppsJ9LA6S9Nv+Z+T7x3GHFpdNZsFNO7puLHIanUREEJEUd4Cb9PmV+AUPBCxbjBcu6wEBZ1DLBsezMi990+DwJ8BbjUnMgKIRtoFNIIz7i25uYgjbWQ6SXRMw7VsEAb6/r8x8/Ebv+BsCRseMzuSzXZYhstDNGJW6xzdpoUiRDkeJhwKPAaNhUlsgcdCa7DzthSY1br1ywsbuz6M6tfjXSh77syqprwSGTTrx5zyEepLycRUVOQX15bKY9qxAecMaFxJ2MYchfzJuP9GgHFcPY/SD+zWwn0OsRih5HR0ZA/TGXl1VlhJs5KFrkrueNhMhc1xrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+HivNavOGrG0nUW7ZpmIy8FWqZq3a/11qKX6RtX0P00=;
 b=KsnP9UAmQnv4EqkwrALSadceN5EicZiR6ENdjcmw5UtgOtK38y1nRfq++qfur6VUwsd1iB4ymFKa23tVVSIufzn4sSohCpw54M1RXb30xeL5+lHO0DLPhXwLQKoYtJLwcdm1PW2SFIB3P/I+y46yL7av7yKz8pXJZ5wCyFEWwczUHszBnyrAjdaHnMn8pcVp8aVzWJ8IUVHJ/eeZ3sQ9U2YYcDyI2pfCgSoFsJXYdOe2qaHtiqeZ0VWV7DRMq2IsU5pG2f6EOb1A6H6oLGAW1NkP4e8QiK/gSDbCdUHzqxQOejOBfy23yh421YdmzSvQIWkFc/CKegqjbBko1HLLHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by KL1PR06MB7087.apcprd06.prod.outlook.com (2603:1096:820:11c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 02:04:22 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed85:405e:a2c9:1f0d%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 02:04:21 +0000
Message-ID: <edd8fc72-7c94-4b9b-941c-7014c5f706ea@vivo.com>
Date:   Thu, 26 Oct 2023 10:04:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/rmap: vm_flags including VM_EXEC can exit timely
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20231024144913.421-1-justinjiang@vivo.com>
 <a1357e75-986a-4e00-a987-9d8c767a42a5@redhat.com>
 <d1c01214-4548-414d-be84-21c38cfe3ede@vivo.com>
 <d2d78a5b-fa57-4e46-950d-e8e48bb020be@vivo.com>
 <85647327-2a34-4261-a110-c726eb7b20de@redhat.com>
From:   zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <85647327-2a34-4261-a110-c726eb7b20de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::8) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|KL1PR06MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b9bcd2c-cf08-4c69-7595-08dbd5c7deda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SrZQPrCmp1lroyIMB18lBxMsk2ePfiIIerCs2L08XnlL5WC1M7CBnA0PuFztJUoeMGFstLNaD5fNKaTkF6MaZem6NjzLaBjUZ6RMM8JZt3WO6fDs2mSaRQNoB+Vaq/vYiDfdmSCbwlS0+m1TEkXcSQASIzIVSnFiQWWO1R2ffmEXaxMgDUp7qnRtO8ENow/3V5jSCFDpyC1Uw6LbOMHlVR7D1pxw6ROpovBixD8/blHmNGfDDxB2U4PdO7W9a1dPX/1CqFXJT6oD8MoHeqZUa+IGd8wzbS/+PK4fZJaDv/kBUiZ2K0sKwA2l+lBaVwRa2hwHQwoctRO7F0vCGE3I9in9vaWqN3HpH0wZjmyOWXHa8NxQ+AEKJ0V6S+bZExH7MsVYHvII4QXgnu7wd3G/7tBOxdnU1WOiWGsQJ5EPXRlpu4l0+aATgqmtRONLKfj7sYGBXh48lgOxHZac4ngHDso4N3lJAICGqFkF7MRQBhGuzny3zmYZNRPPnISlN2+xqJB1/Hk2Pamm+uESxW/k5z2ksQxYxR35xKVBxtZKd9igaOQ3RroWoy90oLiXVjdhtLxzcgprqFdrOJOG8w/X3NhgQA4/VrHjqv2swLrgS20jZUfGqMyIHfLm8cDqXUkxq6DmMyGQDu6Zk56MJXVczjvJZggmIRVoRgQq54PaXsDrNP3ftMFxAdZ3rUrkgGFG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2906002)(86362001)(38100700002)(41300700001)(6506007)(316002)(110136005)(66476007)(66556008)(107886003)(478600001)(6486002)(6512007)(53546011)(52116002)(83380400001)(31696002)(5660300002)(36756003)(4326008)(2616005)(8676002)(38350700005)(8936002)(66946007)(26005)(31686004)(66899024)(43062005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mi9DeGFQM0xiUzBQVGxZREk2MnUyN21xODZkUnpuaWg0WGQwZjkrNzBKUUdh?=
 =?utf-8?B?VE9xQ1kxYzFPNW1MWFFOUEJRNEtjUmRqelZ5dTZQaThlc3FmRFg5STlpOXJ3?=
 =?utf-8?B?R1JMSEFIdkZ3ZGQvTFRzWGwwM0xzeVA4M3dNVFJrNnlsR3RHTjg3UldWRW9N?=
 =?utf-8?B?SktHbjVhZTBGMDJ5Uk15SFlCaWFZdVRONzdMRTRtOWo5UlYxVUNQRGxqbk82?=
 =?utf-8?B?eGNTTC9SSVJjMElzTkNlNU5hMUhlSkU5TGVBbWExWFFUaDBoRi9TeTc4eExB?=
 =?utf-8?B?bWJpc1pCQkRCaXpBTEc5c0FQODRyeTk4R3FpOUsvZStMQmhaOTFUbjBsY0g3?=
 =?utf-8?B?SHlKd01EOGY3QzlZVjJ5MDJSQ3Nua3ZwV2R0Ryt0SGQ2UExnTVYvVTBOWVZI?=
 =?utf-8?B?Vzg5aGdRMWh3NnlKRy9waTdwdjdkM1I4OGVRSUhScDNHZWhHQlhCdndKcjQx?=
 =?utf-8?B?SmZTdmhFcTQ2bGxZQlNoc1luOHNZVFZJWVpiUE5RTTNJejBtUXpiUnMvTldD?=
 =?utf-8?B?NEE2dDhJZjc0RkluZk5DTS8rZ3ZsRVN5RWRQRlY5QnBIamNXT0ZBaHlweFZk?=
 =?utf-8?B?eFZvaTRCWGZTOCtKcldqL3dBN3RPcDV5b0lGbFRJbzk2OU1YVFZSbEcyOFU5?=
 =?utf-8?B?V3dMSzBKZWI3RU9FYWtDMTBZNmJxUzRBczhORDQvMGJWc2FBelloKzFPM1JN?=
 =?utf-8?B?dW42MlA2a1dQdlh1MFNhakQzYm94YzhLaUhhZXRUbW83bHdiTWoxa0VaWVNS?=
 =?utf-8?B?OTAvNmw4SkZtMlQwQlBrRnJXTnV4STh2cXdGenZ4MkU3clFEK29KMkdhUVF5?=
 =?utf-8?B?bDh2MHp5U0VKVjMrZm1yYllqdWUrUUlNL3dmWkhpUmkyZFBBUi9ERjRETDkw?=
 =?utf-8?B?YkoyaDgvQXpBWFZ4a25NZUk1UitBZkZRVE5CWVJtSWdUa3o2cUhKMGZpZ1Jh?=
 =?utf-8?B?Z3VZSElOUWFZcHFDYkIvdHlTcklreWJTdC9qUVBoVmp0UWlkQ25LemZXOWRY?=
 =?utf-8?B?OEt6blhQdTBGbG9VYkwxVnRZckRIVW9FTWVleWV3Z3BFZGRIMkozbjRSbkFX?=
 =?utf-8?B?VWI1UkRIZTNGdGR3TU5kcXdqc0RWTUl5Ym16bG1MdnljbWdQMlJvSU4wc0NB?=
 =?utf-8?B?elI1WUpoUjdVZmg1djZIK1FtVnZFdUxTaEllaGVYYVpDVXhrc01vZDNzVTB0?=
 =?utf-8?B?SnkwLzNPRVhuL3dCdi9jcTFYUUE0U0o0UHlRSXBKR1FoZTVVdFhvTnlRem81?=
 =?utf-8?B?V2ZsU25UbDNlQ0FBelVEdURGQ1h0N1ZBeVJZRnE5YWRjTlNNbFd2bjFKMnQy?=
 =?utf-8?B?TTFEaTYxYWF4NnduT2lNRWpvb2p1LytwajlqNDA1SVZwSjhwcmNFNnBoaHA1?=
 =?utf-8?B?ZWFXMWhZMEFWSGtGdldleEJpdjdwNm9GL29Bb3Byekkvd2dSOEFjbGVnT3Fs?=
 =?utf-8?B?NGRhanhLeis4aVpFejhkT3ZsZGlEN3dpSmFoSWZTRGZqUUNzQUYybFpmWC91?=
 =?utf-8?B?OThlOWhzVmU4MjFqbU85WXZzOUxiSzF0cUVIeklUOUt4ZmNVcGY5MkdGRVhh?=
 =?utf-8?B?YVVVMUttd3hocTNHNWtwVjExRnd1a1JOclFCNC9NUVA1VG9lWDBUTS9IMjJ3?=
 =?utf-8?B?NHk3c1E0RkpZL1pZQmdtbzJzaEdpQnFnaDc3bUN0aWhkcDM0T0s3WHA2eklo?=
 =?utf-8?B?VG9RSmVOZ3cvRUV2djc3MVI0c1oyelBldmJKTWNDMG44NUh5VjNONFhwVld0?=
 =?utf-8?B?QzBYL1ZPTDZrdVcybGhYOXdjUEhGcno4SGRvNG9VNlJFMnFVUnVFaStpaVZ4?=
 =?utf-8?B?S2dMOWVWUU10cXNDM1RxMkFxbXYxWUMzU2FnR2thUHhYZ2pnMUN2TnUyMGtp?=
 =?utf-8?B?S09id1dNaGhQTGJYMDRhRDlUblR4RTdGWXhUaEIyK0ZYSkZaWmpNQS9pWito?=
 =?utf-8?B?SExkN2Roak0yaGtxTFgwQWxsS3M1QWZpVzFCV1NNYzkvYTc4cGEzWTVuRmh1?=
 =?utf-8?B?U1YxamZYWk1IUUJVVVhzaFRCQ3FvL0tCRzBUeHhXKzRaVjhtQ04vZ0orTWRL?=
 =?utf-8?B?RUx2elhWQUhVdjlRNVFEZjlUU1pKNmNCVE84MmJEcElZM0dFRGkxelZ5VWZN?=
 =?utf-8?Q?Kj62HbCmepBXCaJosTcnCwFlo?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b9bcd2c-cf08-4c69-7595-08dbd5c7deda
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 02:04:21.8446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HilrnjYY/4usy3fNZUsBQtfhqDCW26Aumc0/ioJ2F9kz5bI0N2YOAV4xIFEL6YDJzylGZCcYCu6DuBgU46MPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/10/25 23:04, David Hildenbrand 写道:
> On 25.10.23 05:04, zhiguojiang wrote:
>>
>>
>> 在 2023/10/25 9:17, zhiguojiang 写道:
>>>
>>>
>>> 在 2023/10/24 23:51, David Hildenbrand 写道:
>>>> On 24.10.23 16:49, Zhiguo Jiang wrote:
>>>>> When pra->vm_flags include VM_EXEC flag and folio is file detected in
>>>>> folio_referenced_one(), the folio referenced traversal process can be
>>>>> exited timely to reduce the detecting folio referenced time.
>>>>>
>>>>
>>>> Can you further elaborate what the logic behind that is?
>>>>
>>>> Why can we stop here if we're dealing with a pagecache folio in an
>>>> executable VMA?
>>>>
>>> Functions call flow：folio_referenced() --> rmap_walk() -->
>>> rmap_walk_ksm()/rmap_walk_anon()/rmap_walk_file() --> rwc->rmap_one()
>>> --> folio_referenced_one(). And folio_referenced() is called by two
>>> interfaces: folio_check_references() and shrink_active_list().
>>>
>>> 1. folio_check_references():
>>> When (referenced_ptes > 0 && (vm_flags & VM_EXEC) &&
>>> folio_is_file_lru(folio)) is detected in folio_check_references(),
>>> FOLIOREF_ACTIVATE will be returned and the folio will be added to the
>>> active file lru. So when VM_EXEC is detected in
>>> folio_referenced_one(), we can stop continuing to detect the reference
>>> relationship between this folio and other vmas, and exit directly to
>>> avoid unnecessary traversal.
>>>
>>> 2. shrink_active_list():
>>> The shrink_active_list() is the same as the folio_check_references().
>>>
>
> Thanks, that all belongs into the patch description in some condensed 
> form.
>
> Should that "(vm_flags & VM_EXEC) && folio_is_file_lru(folio)" in all 
> three places somehow be factored out in a function with a suitable 
> name, so all these cases can be identified easily? Just a thought.
>
> Then, add a comment to the code you're adding. There are plenty of 
> comments for the other two cases you mentioned.
>
>
> folio_referenced() documents:
>
>     "Quick test_and_clear_referenced for all mappings of a folio"
>
> IIUC, you're code will stop doing that, as you break in the middle
> of processing some mappings, but not all.
>
Thank you for review, this patch will indeed interrupt 
test_and_clear_referenced for all mappings of a folio. This patch can be 
ignore.
> Please describe why that is okay and add it to the patch description 
> and update the function description.
>
>>>>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>>>>> ---
>>>>>    mm/rmap.c | 2 ++
>>>>>    1 file changed, 2 insertions(+)
>>>>>    mode change 100644 => 100755 mm/rmap.c
>>>>>
>>>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>>>> index 7a27a2b41802..932f3b7e8521
>>>>> --- a/mm/rmap.c
>>>>> +++ b/mm/rmap.c
>>>>> @@ -884,6 +884,8 @@ static bool folio_referenced_one(struct folio
>>>>> *folio,
>>>>>        if (referenced) {
>>>>>            pra->referenced++;
>>>>>            pra->vm_flags |= vma->vm_flags & ~VM_LOCKED;
>>>>> +        if ((pra->vm_flags | VM_EXEC) && folio_is_file_lru(folio))
>>>>> +            return false;
>>>>>        }
>>>>>          if (!pra->mapcount)
>> Sorry, Patch mistake in writing, patch should be:
>> +        if ((pra->vm_flags & VM_EXEC) && folio_is_file_lru(folio))
>> +            return false;
>
> So this was not even properly tested? :/
>
> Of course I have to ask: what's the net (performance) benefit of this 
> change?
>

