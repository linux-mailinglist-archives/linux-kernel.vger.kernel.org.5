Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A4B76C3FA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjHBEM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjHBEMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:12:46 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A368269A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 21:12:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzUNIK01L2f4V5sLP1XwkTCERovS6fI15ZekpW85o21PJdMgA+TM/ZPRS1J92vJAANr6t7xG7N2MnkkVXoZ8f72Uu/ayguWtA8gDS1r/SHIV1pM1rcbNoInsjwii7wyi05vAaYUNs9OAx9s5zzN8OXRCZtG+BclDynJ+VUC1DwRLBfBOC7mK61sG6X9AJbLSvqzr5Hy5QjAyKYDQjhDwx7aRrf0obfC0Lht9lqwNPFEX8IZaK6BlFPCt5jOr51YVlTA0kK7i+LCFDNc1Y+d3E7LgR7RiZqG48xiLGMnhENpp65TV4ryL/XgGWxd+dPskNP3jPg+MZbZhaejuaMqBNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r45NYATVK7KYaXBTwMJ2IYlOAdgYzW+weYoKuvCrwbk=;
 b=H9OzQMg+ZjSx7qjr4T5atpxFNmwy4kW2ts0OBhvXzK005iId3de4c2Xqn5TFQ0soIWuiRLo0rHSdmgLO5NerTq7Z8wflwHzqYU0i/5xXadPgbUIXIm0VunwIp4e664Z2XEK+V+ZUZJl+io5c5cYt9wGl9ajYgBc6ESp+2NMb/Yvs0KzV4HlS43LSN/ZRq3ZrDLmHubJJSwBpuUAI/a9bWd6KJkdUS2O68fhjkVWD8N+0EkT4PcZf1A8zPT2ZqsN/J6GkHVz2wV/cCDifJwHyIvqNnUyOH0bcOa8pj5XlmmI5qiWTIn2TYQXnxIXBidfWQOF/AyYEbEYPAAJDG5iVVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r45NYATVK7KYaXBTwMJ2IYlOAdgYzW+weYoKuvCrwbk=;
 b=kw6VCWpqTOF8xdhdaxwM2n1s1W5rqnBfMtzeCtaGtOH0CSYq1PkT7YOh+5GGerWto0S8TtY4Awaj1W0aaD1/64D1czaLf6FQk7litORq6HJ0piHdAl0Q5LLFWC0VH4BsxUIp2mSlLoQQtxR9deBXQqmH0oaYfGh2s7SG+wsGLWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) by
 CY5PR12MB6059.namprd12.prod.outlook.com (2603:10b6:930:2c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.45; Wed, 2 Aug 2023 04:12:35 +0000
Received: from DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54]) by DS7PR12MB6309.namprd12.prod.outlook.com
 ([fe80::9ade:451:96c3:7b54%3]) with mapi id 15.20.6631.042; Wed, 2 Aug 2023
 04:12:35 +0000
Message-ID: <100d7145-7307-20fc-2cc9-0c2edd08f3ef@amd.com>
Date:   Wed, 2 Aug 2023 09:42:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: nikunj@amd.com
Subject: Re: [PATCH v3 05/14] virt: sev-guest: Add vmpck_id to snp_guest_dev
 struct
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     bp@alien8.de, dionnaglaze@google.com, pgonda@google.com,
        seanjc@google.com, pbonzini@redhat.com
References: <20230722111909.15166-1-nikunj@amd.com>
 <20230722111909.15166-6-nikunj@amd.com>
 <1a4e6652-2e24-955c-5332-da84cced68e4@amd.com>
From:   "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <1a4e6652-2e24-955c-5332-da84cced68e4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::14) To DS7PR12MB6309.namprd12.prod.outlook.com
 (2603:10b6:8:96::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6309:EE_|CY5PR12MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: bbfcc3b8-56cc-4372-7206-08db930eb36d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BBCUC0AGTTIuypaX3Py+b8YKzE44rIfRcZXUVWZq1Xmr8bTqRSm+oRohTcuG51vsu6pQr5n9FIMGmOJw3T/Yxj01g6XfoGjIo9bsY+D3bWMt6z/M+7+Pn06Y4ieZ+bp6rpMTKC1Ov1SGMCYFEID3qUWoyKvZFWTlwylJ3dCuNHlzIu7ay44O+UyBebHMM8VrXkLfgalvxI5orDyfu65H51qNZDLIr1EVcZM25qcGD1zSnhwMpF25dDqu7LlLWd0moISg2S0TOxkQlGWKi0eSgM8R8MhEV0RxDdewJe9UsKNKj7yAc2eqZB7LqA3EHD15o1VWN0wDah4pWjh1VNtmqy+sWn8pGw5brG/M7dHESE0rfGLuH6GIsvfSK6nQqCaD1BltfzdQqFEn3jpSN4cT02rv8ZgC4EdMz5JGNSxQEAIZ9eJhC93/TtPu4Zh5exm1JQmAt1pKwCigxmuwcJTaQPysOBH5jl76JoWLF/jhDsoPVp74RHNP4LKHhaicTvs204Q5wTz/yD8jKrypQmsFV+BNty9yvp/uhFxRB2Pl2qtAsRaYh9EQqdFF/K6NG7CFq213NZWfh091lg8dadlFJtzYYl2Ai8dHOxYr5YlG6uBDAV+8djMxnsPDgrVgCw5/aNmmTs3N8Er7F/QGeCpBKw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6309.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(451199021)(2616005)(186003)(6512007)(316002)(478600001)(38100700002)(66946007)(66556008)(66476007)(6666004)(6486002)(4326008)(31696002)(6506007)(53546011)(36756003)(41300700001)(26005)(8676002)(5660300002)(3450700001)(8936002)(2906002)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qi9NQSttZFJ2Qng4SEpwMHN5ZjdCdlZtQm1LakZweHpvb2NUTGlybWdjMUJI?=
 =?utf-8?B?VjFaNVJuMTdzU09CT2pvU01lbmtGSTB5eUZXVVNYYnB2d1RGRFkvTHNieno5?=
 =?utf-8?B?NGNzdEdCWDQzNjc1SXJTTnMwTmZUdDhCVlhQZkRXdm1kdGxBa3Q1dUtuWWRo?=
 =?utf-8?B?N2JmYTR6SisxMW9nWlE1VFdHazZvZ2d0S0FmQkVIN2Y4anBSNVNXRFZUM3hL?=
 =?utf-8?B?cCt2YjFyeTdYWnJtOEZoc2tTd3NFemNQeXIrc3V5TnpSV1ZkMEpodlRkTkJh?=
 =?utf-8?B?aVdDNi8yWHhObFRhKytVVHpWMGM2dFZrYVMxeFk5OFVkNUtqM0VXaUxxc3Z4?=
 =?utf-8?B?SWxZZ2p4eHJCalJvMXhUVllMREpVbEwzNFFWYUg1dUpWTVZBZEVRT1IrRDJt?=
 =?utf-8?B?N0NKcUFRMzZhUEloSUFGcmlwM01mUGNPRC81NUtEa2cyNVBKQlpIMkFxb1hu?=
 =?utf-8?B?eUplSmdFVGlsM1BWZ250cWlaNXJtTnFHV3c4WDJVSnBpdHdHTUlXU2dCd0lH?=
 =?utf-8?B?dklRWEc5Q2RISHJNdXRJUU9ybWZuV1hFU2JjeEltYUVsWE5CK0VwVmNvM0Vk?=
 =?utf-8?B?c1dtUmhRN3Z6ZzJ5L1E4YnltSDNDSnFmcHQ4dnJjemh3dGJpN0ZYdkxEWWcy?=
 =?utf-8?B?dDVmQUdtVkUvY29aaGcwSW5vTTlqOTF3WVVWcnJST0EwOHQybDM1NnRlMmV1?=
 =?utf-8?B?NURyMFI3UVlZWEp1eUlZaUxFUjRaU25DQStZSjg3U04rTVhVczhBMEFXcDcv?=
 =?utf-8?B?aXhlOVZLRmJ5bXIxdGpkT3c3THpHN0xaM3hLMUhrcjh4alRGdWN1em92cXB3?=
 =?utf-8?B?RlVnb0dCNUl6RjljY3ZYa2dFaDlETHVwenZsR0ExWkpOeVd6MlhtTW1QQ2FN?=
 =?utf-8?B?czFJMW0xT1ZpTHFSbFpEMmxnMlR6blU0ZW5RR1ozbFptdkhmOTBnLzdqaHU2?=
 =?utf-8?B?K3R6WHpoUmtaNmdIUGFvQlhMZnI5YlBYeVp2OHV0Z3prSGcxNURlQnR4WWZO?=
 =?utf-8?B?bTJzNE9pK2tGNHRlY0hsOVRmU0prVlpmZFllZVlUc1F4QVoyRU9Nbmc1b0po?=
 =?utf-8?B?S05WTGo4UTAxVXN2WmlqWFRsVUx2dW9GQ2wxK0p2T0lJVTM2Uk9YVG81UXRa?=
 =?utf-8?B?Ykw5U2pCajJHbElQU1BVa2pRQkdyMG9NZXlNeXpIbWdKZHFmRGkvWXBNUVdZ?=
 =?utf-8?B?b0NFSCtlRk5MZmZQekV3U2JwenZGaFFsK2s2NzFFUjgvZHhBOEE0UCtnMG8y?=
 =?utf-8?B?bnF2ZEZTNHE5ay85UXdPK3pQU1YvMjRsa1o1RUVzbUFRdTdBVEdoRDMxY2Jt?=
 =?utf-8?B?dkxLbGluMkd5dU4yaEpsb2hxZU82VS9CQjVLcmJEeUtjZ2pUTnRjZE5Pb3pU?=
 =?utf-8?B?UDN0V2RjR1pYMkZYb3dWcUFGa3BwWUwvbGxEQUM5UFQvZkZqY0J2ZVFPTUZs?=
 =?utf-8?B?Q3FKR1oydzIrYVNFYzAwam1ER1JzNWYvamd2SkxveUY1UENFQzBlcDFoeVRL?=
 =?utf-8?B?V2s5NERBK0crSlRPNGFIQ093di95YWpLR1VOUXFWQnBOYkpZdEREMjBSc1Qv?=
 =?utf-8?B?S01BOS9RaEo2T3dQREFyNVd1Z3NNaWlxb1FGUnJReFhubDhteVZiOGdLaXFz?=
 =?utf-8?B?RldRbk8zYWc5YjRBNnVvNDg1a0dUOGoxSzd3ZEFYMnZrNW1VTFFQL2duQVAw?=
 =?utf-8?B?ZmwzRVRVU2VVSUYzRllZVEtBN0oxbFl1OWVlRWlLRG1hbU5ST0I1UnZjSUR1?=
 =?utf-8?B?ZVFFeTdqSkJlM095OThHVFhka0NmTW1QaXk5allvR1ZOc1dSVWF2ZE9ycTV2?=
 =?utf-8?B?SEpYS0J5VmkvYkJxNFZpOTdVaDQyN0JmdUhSL1pXbVBzUExIOEsrWHZ4MnBN?=
 =?utf-8?B?blBNaUtubW5YOHBOeHBxRXJVSkRCZU1vNVNXVzQyWTFhb1dhbktwanJ1K1d5?=
 =?utf-8?B?cFBvWGNGZ2pzTVNVd2RJQ3BJUlpYbG1HQ3A1cGsvVWsyb21KaHdFQ2ZIQ0p0?=
 =?utf-8?B?Y0ZQL0RwZkJUeG8yUkRjb3VzT093WTBJdHBGYUorTTgwcWhFeGU5QU8vNGlv?=
 =?utf-8?B?OTJBZFFiNjNXWGdKM2NkUlVCR1dzaDNldnlYWXdzOFdMWnpOUlV4NUtPYy80?=
 =?utf-8?Q?L/v9YZtVF8sWVYClMGilTYdyu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbfcc3b8-56cc-4372-7206-08db930eb36d
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6309.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 04:12:35.5954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2hYiNby4bUi5osPIx71XzU/gkJTKdXvwc5810EYwfYpHFtw8BVBCjOoOvsoN71p02nyFmjGQ1li5+Gkv9vm9Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6059
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/2023 10:00 PM, Tom Lendacky wrote:
> On 7/22/23 06:19, Nikunj A Dadhania wrote:
>> Drop vmpck and os_area_msg_seqno pointers so that secret page layout
>> does not need to be exposed to the sev-guest driver after the rework.
>> Instead, add helper APIs to access vmpck and os_area_msg_seqno when
>> needed.
>>
>> Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
>> ---
>>   drivers/virt/coco/sev-guest/sev-guest.c | 84 +++++++++++++------------
>>   1 file changed, 43 insertions(+), 41 deletions(-)
>>
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index d4241048b397..8ad43e007d3b 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -50,8 +50,7 @@ struct snp_guest_dev {
>>         struct snp_secrets_page_layout *layout;
>>       struct snp_req_data input;
>> -    u32 *os_area_msg_seqno;
>> -    u8 *vmpck;
>> +    unsigned int vmpck_id;
>>   };
>>     static u32 vmpck_id;
>> @@ -67,12 +66,23 @@ static inline unsigned int get_ctx_authsize(struct snp_guest_dev *snp_dev)
>>       return 0;
>>   }
>>   -static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
>> +static inline u8 *snp_get_vmpck(struct snp_guest_dev *snp_dev)
>> +{
>> +    return snp_dev->layout->vmpck0 + snp_dev->vmpck_id * VMPCK_KEY_LEN;
>> +}
>> +
>> +static inline u32 *snp_get_os_area_msg_seqno(struct snp_guest_dev *snp_dev)
>> +{
>> +    return &snp_dev->layout->os_area.msg_seqno_0 + snp_dev->vmpck_id;
>> +}
>> +
>> +static bool snp_is_vmpck_empty(struct snp_guest_dev *snp_dev)
> 
> I noticed this name change from is_vmpck_empty() to snp_is_vmpck_empty(). Is that in prep for moving, too? Is so, maybe call that out in the commit message.

Yes, will add to the  commit.

> 
>>   {
>>       char zero_key[VMPCK_KEY_LEN] = {0};
>> +    u8 *key = snp_get_vmpck(snp_dev);
>>   -    if (snp_dev->vmpck)
>> -        return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
>> +    if (key)
>> +        return !memcmp(key, zero_key, VMPCK_KEY_LEN);
> 
> I believe key can't be NULL, so this check isn't required.

Sure, will update.

Regards
Nikunj

