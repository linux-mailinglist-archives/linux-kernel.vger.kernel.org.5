Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E47B1F1B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjI1N7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjI1N7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:59:47 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12621A7;
        Thu, 28 Sep 2023 06:59:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+CnnVCHc+3/iBeXs2NltiysTt/Yg5Qg3ALrzqsICzGct+nqDoXq5cNeljx1H4DZfa/fxMImbAjFzh5Gil0Ra/oLIWoex2WH+nNsI/7UGXxzN663rosVpf718XG4n2MSxgZtj6LqG5ah9VEFsn0BNTge9MNGGDAtp4Am3y2jKDpldKl1l4DSV8lFj4SfKsrc3UAqcNcxXEbby2vF1zD3oHYlsrjl0ztWDLpgYMdu8NJ560i1WYLNQ5M4Um4EZLby9yn51ZSjqiRlfjK7LWlkOSJmZEcwGkO+1xczSSZ+ObBk/lJlQPMyha7Nz+GfCZPrHuTcJMxMpLrAE2LSPQYScg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ov463LcqNc/BEbgBAvm/OrRzxf/aPV0jpulh8dD+unw=;
 b=Ga7BZQ9hVVQ2fnQ9P7ctzNol4T3LOYAuZN/AxKmwbpsKlEdlNRJ0rrKMDI6xbNimch0ZefGcI9eCCl+urp69sPWNHhMjbtnUNo1xKjyRBedcTytuoAkKERwco69qiSVll5RJgKli8Y2dc06dsgKnyeFipxYZokDx2N3ZwfCRG7jCrMLn9HUQqt++6Kx97BHAcBkiz0w7ZXNOBn9IOG+oRbh0XexbLcae/g9+HPNmG28ZxzuerpqEyKXISXBfytkLLc9VsfNHjbaIS3/qjoiqBKDYBTw68Nki7KsGrA1zvtZu5XCzm3oU7Rz2sPNVQUhHEtSUSLlj4Fxuen6WUlsjyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ov463LcqNc/BEbgBAvm/OrRzxf/aPV0jpulh8dD+unw=;
 b=jEkt3O9ntIpXJyRZ7sAjqBfPmizYb7B81QFCvoFAQZDqeiB6UoHcJYASaindhOiLqAkAEfZYmBD9befulSYLiIRFbjlXXUzTw4GYGSIxnV7InnTTZKfQC9He2i+cfk2hH6MZTghjnw5a3VOzme/w+TyjCXiZ0RmGx45MUKJqCBE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB6446.namprd12.prod.outlook.com (2603:10b6:8:be::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.23; Thu, 28 Sep 2023 13:59:42 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 13:59:42 +0000
Message-ID: <90303d4b-113d-9adc-14cb-d55c7a24f4af@amd.com>
Date:   Thu, 28 Sep 2023 08:59:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v2 3/4] Documentation/x86: Document resctrl's new
 sparse_masks
Content-Language: en-US
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <cover.1695371055.git.maciej.wieczor-retman@intel.com>
 <308c92438288a45a12330af83aa0088a31f60343.1695371055.git.maciej.wieczor-retman@intel.com>
 <17079b9e-4efd-4258-2b5f-afc6d3ae2c0f@amd.com>
 <bced7bc7-c489-7a57-374f-62818cbfded6@intel.com>
 <c5ddb511-cc14-34f8-dd80-6471a9a72a81@intel.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <c5ddb511-cc14-34f8-dd80-6471a9a72a81@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0202.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::27) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB6446:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b59c2e-8b55-475f-e075-08dbc02b29cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BA2pjZpSTm4hfMY0U/MSf00apWlqgRNlZS9mR5VGVtRmW9mvHZf9i+j1hfiOlmd5ArCpnWNlQ2eRmPVMAJ+lgKFDHobmzckA4eu5/nBCzwAyKeb0jm8sPsItZNr1ZzfB+rwAWsZ5s5uz/me/N80N65sBGYA5jj/pPYXHsnFqyaRwDojnnImy+NIIsC8sqlCh13+Y57npB/1TCJWdo9U6goeEBhrMW6gLJzcIxYZFg4DHyP+gkeBNLn7EXWj6XTJjG+gt4ctXu1vknQX0SPN4TThOhN1sSlDr78TgwIrKEKccKUeMVXGZft0fxcaQ1Ebnx9Cr8yTApzJIW4XQ3fAWJ13f5GLPcsK7sNm3R3ttwiv4ZQhNmOCu5xlxRRZBG3ZvvoRmFAKePzMAS9Mgu9A2nJm8kPemdM+/Ir8qFO4BpZjE4hlg11CTTruvu6h3qfHnqnbtKp/E96+zqkbHg8Z6k2YFnJrxG0nl4SX/QZN9eyy67PYHvL/SlGXZwPAe5SN2ETUZRyLCDJelrJRsx6cM+ZOY6SYq8q2GUmypr1jQVFOgQl+p4WdSzxLTQbKW/n4+IoJrT/OfuA+qnDO6MQjw9sLBX4PTol5NH7LQbiQgCwjQYu9M7mXBXrXYfRgc2SbQXOp7VhKROrhawPLOh27uFrAp0WWkht+wa+iFaVYlI7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(31686004)(2906002)(921005)(3450700001)(86362001)(38100700002)(31696002)(5660300002)(6506007)(6486002)(7416002)(53546011)(478600001)(36756003)(83380400001)(6666004)(6512007)(26005)(4326008)(66946007)(66556008)(110136005)(66476007)(316002)(8936002)(8676002)(41300700001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2RRS0w4NTQ5MnBCa2ZMYU53MzMxVzNPTnhEM3o3U2pyYU1jOGMyRG0walFt?=
 =?utf-8?B?OFhpL25vYjlkNzZEazVvVmExTFI2SmYrZUs3ZENNZVIzMUR5RTZ6dWxnalRO?=
 =?utf-8?B?MXF4OVVOKzlnRVkrcGRRRXcxWW5CSFp5Z2dXbjd4cE5tZzF0dVZlOVYwK2sw?=
 =?utf-8?B?MjdxdXJGYjBWTm0vc2NmNjVuUXErSGZicGlyV1dveGVrblRjRGdjVkExZ2pZ?=
 =?utf-8?B?eUpJaUlLbVBkTzNNNTA3dXB4bHUxcy9QWm1FZkFQSm1Qbk5OQkZzdnowVmFL?=
 =?utf-8?B?TWpIUTE4OVBsLy9pY2phS1lEOFF3Qk1wb0c4dGZ4dVJER3kwY1F6QlpOQVQ2?=
 =?utf-8?B?bXQ1RXhTeHVUOGhiWlgvQlRHOFNEY0hoUndsMDZ2aWxMRllSRzdoaVQrb3cy?=
 =?utf-8?B?bWg1a2VnZEpQUDgzNmZSTml3REh2YXNDZUNVRkJpLzBoOEdsaHNOYUM1T3Rz?=
 =?utf-8?B?VXBIaFNiektZZHM2b1dodEROTUMyT2hQeWEvL2IxbHdYdWxtQk5wMlB0c3Fs?=
 =?utf-8?B?Wk5UajI1UVJITTJTSk1QMUg2Zmt1VXlmUHBBSDQyYVRpaWtYMUt6SFB6SHNp?=
 =?utf-8?B?RXNnVTk3MzFET0txdGRsZ0xkYkxwclJMUHgyaS9Sa1YwU21GK3h4NEdYbjNp?=
 =?utf-8?B?ZkFWVmhIQnRvbHB1YkZQa0liZmsxZGJ3MVB0RU1udFlDMUJheWd3TnQ1bG53?=
 =?utf-8?B?Z1V0S3JsS3ZlTlhZWW9CeTQ4aXZmV3I2b013UzFocmM3c0kwTVZWSjdQTDdt?=
 =?utf-8?B?SjJlQnB3UEhFaGs2cFZPVkRvdE5taFd4VG9FYTVialY0Z21scnJobU1VTSsy?=
 =?utf-8?B?NWkrZ3ZrY1NtS3FCaFphU3ozaTdMbEQ0L3dSSTZLUURiSjVrSllZdjd5YlZC?=
 =?utf-8?B?ekNGa1h5cW9TLzRWaGdzVlF6cFFyYzlVZ0FrRDJ5c0pHWmluYjBYZk1KZVV6?=
 =?utf-8?B?bm9XN1NYYlI4K3lKZU5rdVlSS0NhS3BwNkc2NVUvV3Q5SVV0U2hYWDl2Mlp3?=
 =?utf-8?B?cVNOalVkbzh5bllZd21sbnVpMWE1OVlnbktpYUE2Qk5tTDdqTk9FWEcrSEhh?=
 =?utf-8?B?enZXenBtWTYrOUl1VEtSbzJFaWJjaUpxakZlMlNwZlBCQkFOeXNvVzZSSzhH?=
 =?utf-8?B?T2hRaTFvMVNzV3NLL1VKdTV3VDRWK214NFhkcWRnVHRMMTFvNERlSmVvTTZB?=
 =?utf-8?B?L2JyNGFsNFAzWDZLbkwwZDBLeDdpTnZqaGdmWWVWblZ4b0h4emQvbkZiek5S?=
 =?utf-8?B?VjNLcnJPVU5nUW04K2trWXA5RGhjRGI0blpLTS9abklaM2ZoMXpOaG0vbVZz?=
 =?utf-8?B?dXovbmNLZVM2Q1ArbHF0R2M2SFRZZGFiK1ZsSmRPRTcvejdtY0pjUDF0M1lJ?=
 =?utf-8?B?WVR3MUdvVWxkNzVyQm0wbE5PSDVmSEFBUDdBVm5zUHU2WEVCYU1Kd0NQSGpi?=
 =?utf-8?B?cnI3OUVxUkNsK3VzeTA1cTZuZ1J3bjY1c01IRzdDRytvQ1BoQnFDaVlERU8w?=
 =?utf-8?B?aFpmbmRzZHZIY0tRUFF6ZkdkTnRkYkRhTmVrRGZ0UThEL29wemhEUlF2eitk?=
 =?utf-8?B?dDNkZmh4aHo2alE2aVVmV2pCQy9ydmJIWkRkdjVvNnZFdU5GTEM2dlYwNW9r?=
 =?utf-8?B?NHQzOVlXNEt2YmdVVm51bndJeCt5dm5zVHFBTUc3SzlmRWpkb2h3Wk9ucEZH?=
 =?utf-8?B?WUtRbkQ1Q2RaelVWVjYwSURWWGV4ZVFqZFNVMU01Ti9yaWVFT1lQNmUyTllv?=
 =?utf-8?B?bHNKOWovY212TTZCNy84L0l3eXlTMkQvSENNWmdFUWJSc2Yxand1YW1sUkFT?=
 =?utf-8?B?SVZ3djhDR05ray9VMFRkdGdSaC9NZlc4VWJaTk9WUzI3TEV4bWgva3Urd213?=
 =?utf-8?B?ak9yM0RlUWd6TXBBNXY1Yy9wS1pEaEF2Vm5MSlpSbWs2MkdjZnBqbXVWSXpG?=
 =?utf-8?B?R1I2NExRZjZ6S0o5YnE1b3NCaFI1WE9iN2JoMjhRc0p1SWF1KzA3YkFUVTV6?=
 =?utf-8?B?RU4zUHQ2SWNmTWxyQkI5OVFsZHFDZ241dkozM0paWFRaK0l5azl1c2M5elhk?=
 =?utf-8?B?Z3FaUHJtdVN0RFpyOVpiTHd3ZG5qcHFCM0tBUTIyb1lYMXRMR2k3RGNTZUhx?=
 =?utf-8?Q?yqMA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b59c2e-8b55-475f-e075-08dbc02b29cf
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 13:59:42.2305
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hX6ZgSJgEEX9ez+uxRoQLWI/zGXta5zF3Rlgm70h2v5rpcrfrivwjWY+wTeOHOT9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6446
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/23 18:02, Fenghua Yu wrote:
> 
> 
> On 9/27/23 15:58, Reinette Chatre wrote:
>> Hi Babu,
>>
>> On 9/27/2023 3:47 PM, Moger, Babu wrote:
>>> On 9/22/2023 3:48 AM, Maciej Wieczor-Retman wrote:
>>>> From: Fenghua Yu <fenghua.yu@intel.com>
>>>>
>>>> The documentation mentions that non-contiguous bit masks are not
>>>> supported in Intel Cache Allocation Technology (CAT).
>>>>
>>>> Update the documentation on how to determine if sparse bit masks are
>>>> allowed in L2 and L3 CAT.
>>>>
>>>> Mention the file with feature support information is located in
>>>> the /sys/fs/resctrl/info/{resource}/ directories and enumerate what
>>>> are the possible outputs on file read operation.
>>>>
>>>> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
>>>> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
>>>> ---
>>>> Changelog v2:
>>>> - Change bitmap naming convention to bit mask. (Reinette)
>>>>
>>>>    Documentation/arch/x86/resctrl.rst | 16 ++++++++++++----
>>>>    1 file changed, 12 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/Documentation/arch/x86/resctrl.rst
>>>> b/Documentation/arch/x86/resctrl.rst
>>>> index cb05d90111b4..4c6421e2aa31 100644
>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>> @@ -124,6 +124,13 @@ related to allocation:
>>>>                "P":
>>>>                      Corresponding region is pseudo-locked. No
>>>>                      sharing allowed.
>>>> +"sparse_masks":
>>>> +        Indicates if non-contiguous 1s value in CBM is supported.
>>>> +
>>>> +            "0":
>>>> +                  Only contiguous 1s value in CBM is supported.
>>>
>>> This is little confusing. How about?
>>>
>>> Non-contiguous 1s value in CBM is not supported
>>>
>>
>> It is not clear to me how changing it to a double
>> negative reduces confusion.
> Agree with Reinette.
> 
> The original statement is clearer and more direct to explicitly state what
> is supported without introducing a negative assertion (not supported).

Ok. If you all agree, fine with me as well.

-- 
Thanks
Babu Moger
