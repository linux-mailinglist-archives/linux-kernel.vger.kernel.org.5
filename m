Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01869791367
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234541AbjIDI2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjIDI2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:28:14 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDABD8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:28:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NO0m37v+9dFIzhxUcPFBZuiv8YRY2Fr2I/lxs70F/4s5bjRGUEdlyFKUU+qmcGQuCTn/FdmjGp3+CcF0kTiZwNjO+io/xVAXgxkNvSjTQXEkcH8nIR16/VDEt/E4qXa3G8wmWtIGX349QxVozxBzo4X1AmyubmbCfVJs1A+iShsoV+7cknrIvwgKx6Zu8kc2Yf5AQZbRk1vaEPvcBnIgy9ET2S/BHrsuBmZZrr90iwqlC7xWSlclz25npFaAOM1TaJJBPxuV3fXVqK0dwKgHNwlpkfd6+v6cqCECZeciXoqj1J+EyHzaNJK6MKdXhq77NAxZ9Ujn2VxJN8yd9a6iaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0sHXqXwz6Aea59uWcD8Miw8DEgR6mcTFKyZFU2HjXw=;
 b=QdAlHV4SDBAwN/Hy/NEw/6pQLlSbZHpjCvbsJoecMqg56JK7d2lHUPwMhmWWWwk8JDXQgMnG4utN9bEI9iSai/KImdtpIG4iAtcuFmLfg/QaO8A5fB3hegY8tAdDFCQhbAAUlSL5c3ESunInkSdyawxWqmvWQDuo8q30kLA+qh5VUXk9VmCEBGu9tPLK69OjHdP1OJuUGDxvq9F5CUZZXAVAzygQF2z6cASJ+qg1nujGfiQTp4pi2TTvE9EVTiYhUz2jLYfuPqUDlSQ4CCXoHvtAiKiOGCIZrOUhLEoozp3KK1ru4KWVipXQfqgcBq7pMT1yTFZHQ5ivJlEPCs2TlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0sHXqXwz6Aea59uWcD8Miw8DEgR6mcTFKyZFU2HjXw=;
 b=2H1qNUWC28lVdOd8PUxg9WXYz778RqnCXm+PT1Z4HUEcaZPUJ1Vw1/UoRCXvCGX3FHdCfYhRLlnfNwlJ+kZzpBPn1PSBabD9/2Xm60PU5Mbqz0UlrY5ZhJHpAXh8phBauTG9IGx2KkNKOcxF7+xp9ivx/Gdh95yDBuYjKbG6wWI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB7444.namprd12.prod.outlook.com (2603:10b6:806:2b3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Mon, 4 Sep
 2023 08:28:08 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 08:28:08 +0000
Message-ID: <faa32c9f-0456-d3e4-e554-e78eb11c6160@amd.com>
Date:   Mon, 4 Sep 2023 13:57:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH] x86/smp: Validate APIC ID before parking CPU in INIT
Content-Language: en-US
From:   Vasant Hegde <vasant.hegde@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de,
        mingo@redhat.com,
        Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
References: <20230719051302.15801-1-vasant.hegde@amd.com>
 <87fs4sjbw0.ffs@tglx> <87cyzwjbff.ffs@tglx>
 <ef4d99f1-e2af-0ead-6b6f-c577b3eeca05@amd.com>
In-Reply-To: <ef4d99f1-e2af-0ead-6b6f-c577b3eeca05@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0156.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::9) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: d3d622fe-2ca4-44f9-9124-08dbad20ddbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eWjfCsVrwwcwxp3+vCWsZf5DCQiLOfOTV7XoWsvoiuVriZpyEir7RZ29EuDhcdSqxaBwJRrcmn7WJsMomEEWycsP5bnXYOXpAd0UqsszqDQLRH/AFF7mpfjEOUOKrnAGkEEI/T6e+OOkoKRVVSghFRYbg7IEX1cPSqFKw370tWGYlELwIa8cSKB2/l58MZk0qZzLtXZOUzfbUukT2aOWYkVWdDTQ/IEmXlWGBLJUTeTlwVDAWsfKAA7ZJp4FWwXG+a8euvbnHPjCLwSLvVlHfV1LJn5/CUUi3uxXNcOvMn63BhQZP6sQyHjwy9bMlatPrQUY4KH+bphvgRmhZK9AJrGwn4Ss83FNw+bMCy48h8/BgbxAZu1r+FJ/RMuzcJITwfyFJTlZ9J+ZFyDyMeSaO9OtkFyQd6QcUlPr7XnSiRGYV9fkaXcE7FfvN9ucDVdD+3FLWZL6h6qn75RABKKmJDda+sXzLjT4Zjq43aeAWHpetwmOhupZPGLANOGxbdWsnW9bmy0TzsJiW20dqAZtLTxj3XG9ND+XhGNoZIY8x+5VSaQ0XrJoASfzJktu0btJXi5ANLnd/Adgavcgu/0v1SynihtU0ty1MOYWkXnN3cPUphR83OS1XtM6Q+rdzhcgNCugrLRFFagShI6//MT69A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199024)(1800799009)(186009)(31686004)(6506007)(6666004)(6512007)(6486002)(86362001)(31696002)(38100700002)(36756003)(2616005)(26005)(2906002)(478600001)(53546011)(66946007)(4326008)(5660300002)(8676002)(8936002)(41300700001)(44832011)(66476007)(316002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2M3cHFGL2o1aHFYLzNTUk52WWRPZ0ZZczlUQk9MNmQwVEhVL1FwZDdaTndB?=
 =?utf-8?B?T3h4MFBtSGxLVjJyOVAxVXByMzJBRnZXaWNBdUdKR2ZWTjJRUWNVTXBUb0dQ?=
 =?utf-8?B?MFdMVGtKcVBMT1VWQmJwTnNWWm1CSFZMcUJXT201TEZZeHhSZW44Y1ZBZ1N6?=
 =?utf-8?B?dXN5T2E5R04yT2FTZGtwTWtzU0RITmh2bFI0UmZ0RlRmMXFQblgyOU1mU2RB?=
 =?utf-8?B?OE5qWWtFWUV2aXVPQXRoSHp3UW1oOEMxSDN1V05oZ2Zobmhoc25jbVJMUmsx?=
 =?utf-8?B?N3d2dFpqT3dkNHI3ajNja2dnWFh0Q3hpcWQrNUhVNm9KNzJvZ21wRW1wNzlG?=
 =?utf-8?B?a0dQQUNYTXBHMGpkb1lzMlJrNkJCaDdocVY0SWMrb0tPUmlpdFZvdDRSWjhX?=
 =?utf-8?B?NXdjVFhOT09sdS8vSm1QZVBROU1CUmM5WFBEaFE1ejZYbjJxTENFZ0ZEclN0?=
 =?utf-8?B?dkpKUUFHWXpmNEVnZWRTSlFSWGVIREZMZmVqUnA2SFhGcmpXOWY0OTI3Z3gx?=
 =?utf-8?B?MGVaZVYwS0tadlZaUUpKUlJuVzcwaXdZSGNiZnhKR254dkRBVURCRzB4MjNO?=
 =?utf-8?B?R1Fhb0g0bzZsL1JPc21OSmZlNmRQK0tHenRURmdyUWJqeHk5bDl2M2V0T3Zz?=
 =?utf-8?B?RjFUVDlQd1plbmNVLzVZTGl2QVN0LzBKOVF4SGNvSzR4cHBvTTk0VDZaWGt3?=
 =?utf-8?B?Znh5WjBJeWRwTm91TVJxSnA5QkhpNzhJSElZMXNaWFdpS1BmVmg4MjB3cHJB?=
 =?utf-8?B?VFFZbXNQY0NacEJhLzVGazJaTzFmRnMxNUxKcDExR0pSQUYvNmJzb281V2tw?=
 =?utf-8?B?VGdXdmJrb1B3Vis0QmIzL2h5cEZ1dVYyNjNoV1NWZDRob05aNzEzMEpCRktt?=
 =?utf-8?B?ekQySVBOR253K20rR1cwMzkzdms5Zm52b1krTldoSE0wNjgwa2h4YTZ2R3lY?=
 =?utf-8?B?NlNjN2ZwbkY0V2kvcy9QOFRQZzRiUzhsZmFlYzd1cnVvSEtjQXVUKzdOOVFi?=
 =?utf-8?B?KzNaalJyUlQ5YWtucmpTWmkvRFQxcUl5K1pzTGpqWjdWWXB3MWp2dC9DRU8y?=
 =?utf-8?B?cXhSZjh2bE5Ea2tMd1ZVcFU5MHJSNTZJaDhTOWp3WnVSbkZWcFd1SERQVDIy?=
 =?utf-8?B?eGtSeisvc1lLdXJIcGc0K0NsM2FQRm10Y3dUTm9pTFNpWHRmRmpJY0JZZ25n?=
 =?utf-8?B?SmRhM0JXZmFTSzQ1MTR3VUhidE04elI2T2lCQ0dYYXdXNHVCeDZwZnBMVExm?=
 =?utf-8?B?UkRJN3Q0cXQ0c3RjTmg2NjlVemR3b3dOMXByMzEzbmgvWGhZVlJnRWFCVHR6?=
 =?utf-8?B?TFBKSWpodFFuNlJ3Mnhqb1VGZkdqZ2ZWSlNYUmIzY0xUQjNYSmJhVWc5NnJr?=
 =?utf-8?B?M1l5WVNCdktxYWhNRTg1Nk0zRHFkME8vZStPeXozeDZEZHNGMjRHcVBsUk1x?=
 =?utf-8?B?cVRsWlFHSGR0RkRQMzZId29jcVYwUDV5MkhQWGgwZjdWTEhkOHpvSGNWeW9D?=
 =?utf-8?B?ZGlMV3E1WXFWQTF3WGFGN3J1a2Nma1RTZnZ1V0xpZ0x6YnQ0YnRjWlN3M1hD?=
 =?utf-8?B?bGgyR1cxOGh3MmQzMG5HK01WY3NjZGM0d3RlZEFOby9rdVhVN1k2bWJaMXdl?=
 =?utf-8?B?bytkVHBDTHl0aGwrdU55SzNYaGVSWkVUVjV1bzJteHFYbUk2d3hxcjhTTGpU?=
 =?utf-8?B?bzg2Y1dNN3VVQ2QzcGF5Y0w3cEFjMjMxdFFtSnpwSldwZ21OZkN3eFVWbXpz?=
 =?utf-8?B?aDFjejlkdjNrUmNNZjE0UFpGS3I2UjlrVitCeUduK2lyS1RwTkJ1Tlp2MERU?=
 =?utf-8?B?VlcwNi9wclB2K0tTcjZ6TmhkOXk5dGcvYzRzeGJFWG5LandvWkVRUmFMdUQ4?=
 =?utf-8?B?MFVkMXpxdzkveENCM0E5a0F5L0lhU0ZLMXBKVHlsNyt2dDJTaGh1SmRFR0p1?=
 =?utf-8?B?YlBIbmY3M3RjSDB1a1ZNY3ByM0lUNDkxNzN6amxOVjlXeUlxRmNrMWpNNXlG?=
 =?utf-8?B?LzBHM1RuMDVHMG4zdXZJdDJPV1lwa0g4OXE1bGhpL0JnZXhKQkVsK3hncWk0?=
 =?utf-8?B?M0tDTEZ0NWRNNDVYRUJyZHpySlpadXZka3RWRUZOcjhZZHpxblp4ZFBud3Bl?=
 =?utf-8?Q?8eDfAbpR/CTHoVZW/tfhIbgeC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d622fe-2ca4-44f9-9124-08dbad20ddbe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 08:28:07.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HkMpA7mVQNhSZrrbwgFXA+IR9mjvF8FMq/WzlK7UcioHmFyqLjUdWDTkCMvZHJF7gURiXIHbZgjtYR6SHlTCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7444
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,


On 8/10/2023 4:56 PM, Vasant Hegde wrote:
> Hi,
> 
> 
> On 8/10/2023 12:22 AM, Thomas Gleixner wrote:
>> On Wed, Aug 09 2023 at 20:42, Thomas Gleixner wrote:
>>> On Wed, Jul 19 2023 at 05:13, Vasant Hegde wrote:
>>>> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
>>>> index e1aa2cd7734b..e5ca0689c4dd 100644
>>>> --- a/arch/x86/kernel/smpboot.c
>>>> +++ b/arch/x86/kernel/smpboot.c
>>>> @@ -1360,7 +1360,7 @@ bool smp_park_other_cpus_in_init(void)
>>>>  		if (cpu == this_cpu)
>>>>  			continue;
>>>>  		apicid = apic->cpu_present_to_apicid(cpu);
>>>> -		if (apicid == BAD_APICID)
>>>> +		if (apicid == BAD_APICID || !apic->apic_id_valid(apicid))
>>>>  			continue;
>>>>  		send_init_sequence(apicid);
>>>>  	}
>>
>> I think this papers over the underlying problem that this sends INIT to
>> an APIC which was never booted. The below is curing the root cause.
> 
> I have tested below patch and it fixes the issue. Thanks
> 
> Tested-by: Vasant Hegde <vasant.hegde@amd.com>

Ping.

Will you be posting/picking below patch -OR- Do you want me to resend below patch?

-Vasant

> 
> -Vasant
> 
>>
>> Thanks,
>>
>>         tglx
>> ---
>> --- a/arch/x86/kernel/smpboot.c
>> +++ b/arch/x86/kernel/smpboot.c
>> @@ -1356,7 +1356,7 @@ bool smp_park_other_cpus_in_init(void)
>>  	if (this_cpu)
>>  		return false;
>>  
>> -	for_each_present_cpu(cpu) {
>> +	for_each_cpu_and(cpu, &cpus_booted_once_mask, cpu_present_mask) {
>>  		if (cpu == this_cpu)
>>  			continue;
>>  		apicid = apic->cpu_present_to_apicid(cpu);
