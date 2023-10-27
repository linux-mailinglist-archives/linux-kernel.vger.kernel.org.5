Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DDB7D9D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 17:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbjJ0PzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 11:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346224AbjJ0Py6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:54:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72CAC2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 08:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fANaP291v9SU3cnLBKONBUldwt/6O6HNmgd35EyvuLgeVPzgA/QcfijRfTqWwkG7sJRWc7aMTyEHmRqspc0PcTHjgwX44t32RGFPCyQYf2PtcsZ4AWN0yjQ/Uh10gbVbjLopyKrQxzCGYfPIN+3lNeJQKXXXfuQXnsWEVwTLGsaE/+zjkqbLVI7mRX74LZTaZ85sJoeOj2B0mcdLUsfWi4Q5LE0Fqr0/1EqgKyVi3kDO4eT3cn1J8gcQpVvvrid0UZUfssEQBOiRyjbRMFUt5OtiEWmKjUxle2fziutbpc/BZyzTQOFuFyYtAlOomHebNq3QVWw1eze9X82J+rUWsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXOTjOCxJBAIm3MNGaN8Qj/QTCeVQCBNEs9WO+K0aIc=;
 b=Us9U7cpmRocdDWKEpcC/O10E/K4hDIMqep97UaTxv2bAmAgzFwRwHRK8oXw+vXTtBjGke3LJfhwsUM/EJTbJ4vHOqOsEQwO2dDMifZw0Lvgv70D+hoKyv6arGKMDTD4EzOwFRXGWBnYqTICvoalGk8uT3v/VdC+Mzia4kzowU6ryLkOZaH1zYekTPS/pEbf/rDO0XVwYRGp7ZC6GYXfYD2ZxHQAMFuKxoJHIS91/TuJ4SkpFcqfsCSPlNjPhjWDtXuKgLD+1FhpdVs4WQBpEjOnTaYx8UOTqUT3GYYWMihK/xTfijvBv8qIUcys0hevchyEUR3ies/ZlHYrPJkH3Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXOTjOCxJBAIm3MNGaN8Qj/QTCeVQCBNEs9WO+K0aIc=;
 b=z/rYc145upOE89J10/mpQhixUT0245BbKOxv3v7qMjFe/4ta+NrM5wVuxm1Gk3F+jTysH9HrMszBohNGLSItCeO+ATWn/V5VdmS+pmSuLwRhDvw6LK3T2fWAsBUiVhqi6esnJF7TnDdhyC0DnXtum8DgSPA1btwEFZXFOciUyqQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Fri, 27 Oct
 2023 15:54:51 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 15:54:50 +0000
Message-ID: <c0ea139c-9861-4ea1-b547-6e3c380301b3@amd.com>
Date:   Fri, 27 Oct 2023 10:54:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] ASoC: amd: acp: add machine driver support for pdm
 use case
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, venkataprasad.potturu@amd.com,
        arungopal.kondaveeti@amd.com, mastan.katragadda@amd.com,
        juan.martinez@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marian Postevca <posteuca@mutex.one>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
 <20231021145110.478744-9-Syed.SabaKareem@amd.com>
 <4d5a4c67-2f4b-4111-b98b-ef575543fa6e@kernel.org>
 <3ec97548-1f91-49d0-adfb-4f8051ca9a97@amd.com>
 <f8f8017c-4e76-4d70-918f-d7cb45186184@kernel.org>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <f8f8017c-4e76-4d70-918f-d7cb45186184@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0095.namprd04.prod.outlook.com
 (2603:10b6:805:f2::36) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|BL1PR12MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: fe905bf6-b083-456a-0fa0-08dbd7050dab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txzPuIjBmFDD3FzbMcrrJnIQ00yvq3xEArp+H90zRVdmW5iHiJq2IMtr6cnGiPBFEPiTolacYNWYRGzQH6kYBMJGKbjWSOPGNryJfVnuSpjipQxFBCcy4pCGdXcVcubQS0tkKntXdrGEWfZC5No5omMARrUaAYMnPsJa3YjMkLHKH0i1ZSsaMznn8WP7LlmYGjWVix8GzymaiI97epzwJ7fp0XoA1JZr51rFk9RQfqgUKzEsDu3ko33g1zlbdmMvLT4ySLSPQHW9hqFTx1dn8a8KHnyMLzxXT0CW0cGmy7rKc27Rq8Ar/bRrhSIL24SdZbDkdiDxxduBmiSqby5Rqqys14E9BBTq6XYzVF8oThqVxUq+hVrSPkoJOz7oPRORxq//dl+1o3jEJrahwg46oBrqSSST0dE67hHb6je2k4tiBOF7Fk3TMFBTmzOc0hfeXE8dMYESFumYx5pjAFpK3Wx8xkOYMk/y3XiSdH5qKG++ujtEAGiGacQwy1d5jF4XYKxfSCR8zyg5M7RKkY5FJXQ0vlXqqhAfvG4XRLhdalKvjat+PBe/vpphdjyjQGP8UGa4o/4HkGBxqTwl4Ykn3i9IqiftU1cMjAKr/qFfpebh0sWpIdXAXPlI9fINW3j0NPLrd/yN6N5Rh4llWdc9ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(39860400002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(31686004)(38100700002)(86362001)(31696002)(36756003)(8936002)(4326008)(44832011)(8676002)(478600001)(6486002)(83380400001)(2616005)(6506007)(53546011)(6666004)(6512007)(110136005)(54906003)(66476007)(66946007)(66556008)(316002)(26005)(41300700001)(2906002)(7416002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlBra3NCd0NOdGRPRFNJSEZxTm1iMTZ4T1V5aGhzYWsvbjcyaTNtd0hNUjhJ?=
 =?utf-8?B?ckZaR3l2U21ZSGhJMTdoQmdMajdYMTd0bGVpdUpjTVRGZVV4NUdTM21FRUsz?=
 =?utf-8?B?cFMveThNb3VmaDF6UVNYK3EwZFJHS1hJdkpxSzE2SzRWbG12cFRMT05hUmpR?=
 =?utf-8?B?Tkk3TE45V0hGeWlBS054Mm5TSGNEVVExY1RjYWtnSVIyTjJYWWNyU01XWEs1?=
 =?utf-8?B?akpEUjRSRThTYWY0Tlp3WnRFbWVsT1FBbjZsN0orazV2Q0YvVjA1dHVJZzNE?=
 =?utf-8?B?TE85Mk8vZXJPYjB6UnhRQlk2Wk5HVlorNGR2SzNXYnI2NlNyMGhKN0s3VHJx?=
 =?utf-8?B?WVNTemF5RVNBd0Q4WmdTaFR4Ly9aM2s1enpsY3FHWkNUUkw2bDd6eGpuaWp6?=
 =?utf-8?B?TTNxMjVGS2dWSmtmd3lBekdFZlE5bm1SR2daZG5TRUtLaUJUL2dCVDlLd0F3?=
 =?utf-8?B?T2tvRWRWaVRET0xhQVUvbFJnUXhuOFI5WVNtMW9xVitwbFRhSzRxd01qMVRM?=
 =?utf-8?B?S1kycDdZTkI1TUZ2QjhmckEwV1hFR3dsL0N6UURwSHdGbUJ3eDlTSjF4UjZ3?=
 =?utf-8?B?YXZHRmc4ZEFEWFNYdmhrTzVvOG9BOUJLQjJVWkZNZjJ3enZxZEZYSVd4eml1?=
 =?utf-8?B?TklreWpIdE9TZkE4SGdKeDFaZFZDNDNiRzlVT0swdUVwSVhmKzFlVlFORnlX?=
 =?utf-8?B?eE04N2wwK2ZpNmNIcFNtdFpacDlRRko0QWo5ZHhyNFFJOFlmbUd1OXM2R0Yw?=
 =?utf-8?B?Mm1hWUJIVEJNakhRRkdJeWZFVnZqQks0S1pBZ281b3RvMUxNUHZEKytoOGVz?=
 =?utf-8?B?c3FHMjFUdUZvaGNYUlRQY3Fac0JNVFBLdjdrajl0bUp5WkFLSkNZWXJPQms0?=
 =?utf-8?B?ZUxOV2o1UktjaFk4K2xQRkZVbm5tdU4yNThVRUxKMk5qN1FiYkVISThRS3Zz?=
 =?utf-8?B?ZmJpenM4bGQ0NXBySXN2UlNxY2s1anlEeG1pZVdsendYRmxXTTg2LzdEMDQy?=
 =?utf-8?B?UnZxOCtQM00zNWZhMHkvQ1hLbm9BS1RVTVVkWWc4SDMyeTV0V1NINVc2Vjh4?=
 =?utf-8?B?a2d1dEkwbHlVZ0VqcFRScTYzcHRVRGxqTUFVZFF6SE9hUWFJS2xJUFgwTXlE?=
 =?utf-8?B?eUg3dVUrcE9ncVF6cERjWXNjc3RQOC9zQW1HdUg4ZXFWbXY2T3lLTVV5NDdS?=
 =?utf-8?B?QXNNc2NYSmJpeUJ6ajk2ZVJJM3M5bkoweCtIRTU2NEFiYmErUkRwSXJaZ0x1?=
 =?utf-8?B?SGsvWW1YT09lNG8xVXBLb3FYQVZWUTUwVDNQaFFSZDdnOFQ0dVc3M3RuVjN5?=
 =?utf-8?B?SW5iSGdHSDdienV4VkNiUmsyYVZTUGRGOUsxMG1ON0tIcXdYNnN4SXNhMWpN?=
 =?utf-8?B?c1F2N01qdTJZVHAwWFkxMjkwVnRpVFU2VjNMNXRqVjdwcUVoTmduMjB3aXpU?=
 =?utf-8?B?U09QZEZmRGpJNGpRNDl5eUZKek5ocmx2enEvWGZ6NURBTlBDTHdid1VJSHU4?=
 =?utf-8?B?NzBZbVFPdXNGK1MxNy9wWEY1Rnd5dkpTcEVBc3VNdHB3ZlhIZmFFaU1lOFJK?=
 =?utf-8?B?RFAyY0lQNHNhZCtlR2UrMEkrbTEvNmlmWmh1cG9pZ3laT2FydzRtejNUUkEx?=
 =?utf-8?B?azdHUG5WS1ZiOWJvNTNIV3Z2T21PYUh5ZzRKWURBUVhoTDhTaFkvVGZUdTFT?=
 =?utf-8?B?VTU2WDFvWGpsNk1xUm5jOUtWY1dROXdFNFB5ellDckpBRlpNNE5IOVdEQ2dt?=
 =?utf-8?B?TVZHNVZjMS9HSUlvUTdUTGsyTDdpWHZWa3dNL1JJcWh2clB5MzhNaWdtQnBY?=
 =?utf-8?B?bVFuVXYzVSttSmRxQlFIRk1pejh3aG5nazRsSCt6WCtBU0dNUnhzTFM0SzEw?=
 =?utf-8?B?N3Fqc2l2MDZON3dZQzQ3cXhRU0sxNElEbVlBOVBqdXhPZllFcGxzRmRJNXY5?=
 =?utf-8?B?dnV5M0dHank4aXNKUzVrZUdGYzhlVy9wUFNFSGVvMVNUUjMrcDlNemNXbnh3?=
 =?utf-8?B?UzQ3aUpqMDdFQWN6WmZwanpIVlFianVJRHBuL0VSRFFoc1N4YTM0QW12SGtL?=
 =?utf-8?B?MU84c1g4R3VHN1lFSkNDSGtKNC9NRCtVd3Zqek5oTldwc3h3Q2h1dXV6TjJY?=
 =?utf-8?Q?/xTNjTs3HnxfyuXdxUgGa3OB9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe905bf6-b083-456a-0fa0-08dbd7050dab
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 15:54:50.8682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g/SuMr9PzGaetFxrY/xohODp+xpZZGZOW4nTbGddTICDSrszouu/sfXvfcpg2oz6I6fRafLXFZE4hCuwL+utwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/2023 10:51, Krzysztof Kozlowski wrote:
> On 27/10/2023 17:28, Mario Limonciello wrote:
>> On 10/27/2023 03:49, Krzysztof Kozlowski wrote:
>>> On 21/10/2023 16:50, Syed Saba Kareem wrote:
>>>> add pdm use case machine driver support
>>>>
>>>> Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>>>> ---
>>>
>>>
>>>>    	dmi_id = dmi_first_match(acp_quirk_table);
>>>>    	if (dmi_id && dmi_id->driver_data)
>>>> @@ -214,6 +221,10 @@ static const struct platform_device_id board_ids[] = {
>>>>    		.name = "rmb-rt5682s-rt1019",
>>>>    		.driver_data = (kernel_ulong_t)&rt5682s_rt1019_rmb_data,
>>>>    	},
>>>> +	{
>>>> +		.name = "acp-pdm-mach",
>>>> +		.driver_data = (kernel_ulong_t)&acp_dmic_data,
>>>> +	},
>>>>    	{ }
>>>>    };
>>>>    static struct platform_driver acp_asoc_audio = {
>>>> @@ -235,4 +246,5 @@ MODULE_ALIAS("platform:acp3xalc5682s1019");
>>>>    MODULE_ALIAS("platform:acp3x-es83xx");
>>>>    MODULE_ALIAS("platform:rmb-nau8825-max");
>>>>    MODULE_ALIAS("platform:rmb-rt5682s-rt1019");
>>>> +MODULE_ALIAS("platform:acp-pdm-mach");
>>>
>>> Please stop growing the aliases. Module alias is not a substitute for
>>> missing MODULE_DEVICE_TABLE.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> I thought the way that this works is that top level ACP driver (IE
>> acp-pci.c) will have MODULE_DEVICE_TABLE.  This is how that module gets
>> loaded.
>>
>> Then it creates platform devices based on the detected needs for the
>> situation and the creation of those platform devices triggers a uevent
>> which due to MODULE_ALIAS will get appropriate other platform drivers
>> like this one loaded.
> 
> And why you cannot use MODULE_DEVICE_TABLE here? IOW, why do you need to
> manually duplicate entire table and re-invent MODULE_DEVICE_TABLE with
> MODULE_ALIAS?

What would actually go into MODULE_DEVICE_TABLE?

The platform devices created are contingent upon what was found during 
the top level ACP driver probe.  You don't want all the "child" platform 
drivers to load unless they're needed.

