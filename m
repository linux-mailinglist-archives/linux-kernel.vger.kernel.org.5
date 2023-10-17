Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E63A7CCA1F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343938AbjJQRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjJQRr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:47:59 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0941893;
        Tue, 17 Oct 2023 10:47:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LaJVSoQMJegeSuI7TxBfHPrAXu1g5Co6D8O0JFdZZ5BRs3Gi+DcEaIp3u0qzqCrOtT/Mve2dMGtkofHBTB85FGFX/rBSsTzj0z+Z4Il8xGj/BWER0TZ6vVjCn7/ZGoMEPe2WmszejHg3AcHxiv0sbhD78yCgqYN+UM/cvnrfMeI2Xwdbbbj1AfxqpMoyh+lpHfhLtVISqk1yrTAaY1RE2Qmzoi54SluHkJvP3pzv1zwCzYHo0THeSgu4vOVBIG7YvebYFo1RRFHP4z67J9up6MuLE6MR2w1dFfq4ghhn4ntYzAXoXs6xYNmvFEw6EB+GYlgmwbbs+0fBSS3K8WfdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dEQaBCTy7FYJOE8+bnLcvN6XFlySf/5TGU5bfi2PclI=;
 b=NTkN3bJgZmANDzym7sgwBpM/0cWWXleWojtmPvgf+soKl9f44L/iAMwW4/RqtysuznbXGRZPHZURodVCeVaFzRIWYuw39zkAfWHenowShQLkgGytBaiGXcpJlvFMqz3/yrQ37u+vj1kmJAHZT/ga0lzQPnMKcNhLOsFGW2PseHZseD2aqt+ahuyyjDCdOdYslyLgT+Kp0N8eeCfvePuJhRSt/8T+zvYWeR0ZHeuOpAhl3UHY4xobMxvRwAiePlFnDh9Mh2cH+C2aZlI7ot1MP4AVDZuxSQBudDF0XEKaT5LpF2ZSaXURf97yQ+F1wa09QJspHGtOq2NvIIq10SuN2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dEQaBCTy7FYJOE8+bnLcvN6XFlySf/5TGU5bfi2PclI=;
 b=jM3kC81IvJzZnCzDGIvbYzqdZTF/KbH4zd4QUs1gjxKgcwTpRpgTTYWo2EUglpkTav3bqkaaLay13TQBVFgQIvShbINt7Fv+MfI6ehVvBDvIZhqgGkAZls6RhEStXUGwQR4xsoH1LQbiof5t1ybmHl8hswktQF/ccrE5jNtVcqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH8PR12MB6769.namprd12.prod.outlook.com (2603:10b6:510:1c4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 17:47:54 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b5d1:8b74:fe73:bd39%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 17:47:53 +0000
Content-Type: multipart/mixed; boundary="------------CEmSkaqF0aOaf8z0ZhUmyQ1K"
Message-ID: <cc273d98-d73c-49bd-8799-b119966e226c@amd.com>
Date:   Tue, 17 Oct 2023 12:47:49 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v13 04/10] x86/resctrl: Add comments on RFTYPE flags
 hierarchy
To:     Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
References: <20231013202602.2492645-1-babu.moger@amd.com>
 <20231013202602.2492645-5-babu.moger@amd.com>
 <d4a33013-0448-4c36-a168-b3a953024962@intel.com>
 <0acbb031-a84e-1cbc-0857-f087b07a9056@amd.com>
 <299778a6-5ea0-c70d-54d6-1ecdc1b417d6@amd.com>
 <2c86957f-9705-4f24-aa43-60d89f636c31@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <2c86957f-9705-4f24-aa43-60d89f636c31@intel.com>
X-ClientProxiedBy: SN1PR12CA0067.namprd12.prod.outlook.com
 (2603:10b6:802:20::38) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH8PR12MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 5967900b-2825-4e49-e092-08dbcf393047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: or2LUEAWkgWvHRI0Msg9QK6MDegRkXEDDFNKivD7a4GgpWqDHeDhz72kvMZnQzii68U5JaAOEm2Mefj7Wl0quo2jYm0EPJdKMrlvZL/nB32pPFAYD/fr+iG93x1ec4bjospSZZi7/2zLFMUPS5/426FH36K90qTp022LTb+eTgcTOAztSTnMll6J3zyB2a2CPUfNXh3ubSORYmnrq8pFe4ZbQNAaBx6zkfKeDqhWj4K+U80kmuglek35DRgeS30f5pmAql7ta8AjnryhRbUNN0xqVh0HRuS1EORjSVsS/vUFUM2EcIbQNwuqaPZUbQbsOO148B6qww+KFotCiOL/NqsPQ/dgKQsVoeHZl/UoN3sd8jHGWG0b/OFqgx7hzA6yvwrnyEkjJWGAmEHPCr88mGWRNkZ4cKH64bajJkgnna0McjMYOXJqLtQuyFIZHBvMxmCYrG7XXXwsSg9ry491wtOKFAduygAuJdUFvRuD4bjngv2neGecU+KIjhmA81bthZZfNTT9+WVJ9MiIx/sqKUPJxnlEj6x3X9x+QaCfgoQ5Lsj41+rfRwudlb32gQyLomXZdQ2E52+JYgkKHJkUZScJC6JIXPRG4cPRTRbxEajhpoJz5Zd4R9+3qVXVhfSIOFRGRqy7EQNc/4piK+gChw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(366004)(39860400002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31686004)(478600001)(6486002)(66946007)(6666004)(83380400001)(86362001)(66476007)(66556008)(31696002)(38100700002)(6512007)(2616005)(6506007)(33964004)(26005)(235185007)(53546011)(316002)(41300700001)(5660300002)(3450700001)(4326008)(8936002)(2906002)(8676002)(7406005)(36756003)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXl1akpZSjNodUkrV1d0K3JRSUVPZ21CTWxIQTlzd2cydU9BVGtic2tRUFpD?=
 =?utf-8?B?OUZxOSsrdnJSOUZRZytQZ0NLL0xsY3l2dk93YTg2c0luRWp0QjFjOFFCdnhv?=
 =?utf-8?B?OG1xSWdmMjltellxMGppR2pxbVlTQnVsTERUM2VocG8wVno1TU01dmVrQzlx?=
 =?utf-8?B?VC9uOEEwTyswdTNYbTVjL044bkxITWZHT2pQdkVEVDN2eFdkTFgzaXBLcTRu?=
 =?utf-8?B?SWxYM1FKTVZ5dlpibkFaQ1M0L0ova1c2Y3VZV1FIS2JHRXVqU3psZE9VNEZT?=
 =?utf-8?B?RVBFRWZqMVQxRGxCOFZHajdlVGdvcUI2K3lJQmc3dE9XQWt1ZzN3MDlzNGxW?=
 =?utf-8?B?ZGo1WHZpOWw3TGh2cFJDQWMxRUNsRTdWUFpKN1UvVWxiZEZJSnREdER1Ynky?=
 =?utf-8?B?UnVrQmx0ZUhmSndkVkYrYmxoUG9VNW5YTnZzQU03cGdyNXpIUWVxdU1SQUFy?=
 =?utf-8?B?clBmTDdrSm1DOXlocjJjUnF2b0U3amI5KzhuL00wSkdnSEhmUDZuaW9XbFVs?=
 =?utf-8?B?Z0Zad0xGOTcyTnY1bXhTci9jVklTUVdiUkdIZFJkZjJNWncxYWtKK0tQQlJw?=
 =?utf-8?B?cElvcUlqQVRJeng1bjJOUXdwMnlzb0Ixd1NtZHhoRTcyWktNYzlCSE9rb1FT?=
 =?utf-8?B?aVhwTHBmMElVZ2R2a2cxcjM1TVBDK2ltSlB3Ty9oSStvelNaSVNFLzBCejkw?=
 =?utf-8?B?dlBnVjFxK0lkb1RhYmpHQTBsOTZYUDc4NlZNZ1VmU1VMUW9CMkRPMkM1OHVi?=
 =?utf-8?B?WkdRTDQzSmxxVUJYM3RTanRyKzNvZG51eDQ3c0U0OVlkdERNWEZCSTVmbW1x?=
 =?utf-8?B?cEplSmJhTEc3MmcxU3BsTEo4Nm9sV2wvSFZqcmZpblRLdjNCdWNLTGt6cFVL?=
 =?utf-8?B?OG55N2lJOWt0bGNDWmQzblVWZ1oyaHFmY1N6WTZXMlhLMUE0NzBoUnZzdDZY?=
 =?utf-8?B?SCtyTUNTcGVaREZxUWdzZDk2THVlOWRIb3dYa2htQVlYQkJla2hYTFpYakNL?=
 =?utf-8?B?dm9HMlFUTUg3RERDaXNqV2Z5VjJQS2NiWHp1eUVKU3FydW8zcFlwZ1RtOUV5?=
 =?utf-8?B?OEFiRWRYaUdnb0RWbzMrVjlIVEM2VVp5NlUxcWVFY0xUOEZaOENFSGw1NWlV?=
 =?utf-8?B?SlVSVmozcXpXaVhnZkpZZkFOZ012SFdQbzFIZm9OMkdCQmNtRzZHdjNKRUhK?=
 =?utf-8?B?blJyYzhZQVBzbjM4NHdQZ3RTdHFscmpub1d5MUhXMnQ3dG5GVFVDWmNtRm9H?=
 =?utf-8?B?U3dXUFR0NHZXZUJSYTlCZExVV1JvOXFyYXJCSzJOYVE2YWFObS9xcXU2VnpK?=
 =?utf-8?B?Nlg3N29rU3B1ZnBRL0RldjZLM3dxekFyMzZBWnhVbEZIa2JpTXU2SStITXJz?=
 =?utf-8?B?ZUdLcFdzcXBDOThsZFNGSmhtZDlOaUZpQ3RVcnFpbk1raXVrOGRBK2V1b0xC?=
 =?utf-8?B?Y0VMeEpuZENoOFZPbXliMXBqSTd1NTJNT2lRbk9LVUhRVlhFWmxORGJGSFBp?=
 =?utf-8?B?VkxHVTk4TnA2dHYwZ2R2MFBLTm9xc3hHMVBHblBVNzErT1hPMnU1TkxKaVNM?=
 =?utf-8?B?aitLYlhGS25odENrdlRLaC9sK2xONnR0V2pNN1BWdFRpYi9OU0ZOMWU1enBZ?=
 =?utf-8?B?SjZ6WjVxSTYrNlNYNE8xaXZzZnlqTFVNWVoyZFhYN2ovRmU0eWF5eW5sMUpm?=
 =?utf-8?B?Y0UzRTBNUHNBQzZyMEkzeTA3dTM1aklEaW04NEEwbnYzZnlZczAzTldzZGNT?=
 =?utf-8?B?K242TzVrWXhVTmRKMEVJK2E0d1VRako1TGt5WUNTcTRjOEFGNXZCWGloMXQx?=
 =?utf-8?B?NmNMZ1MycmxqWG14ZFRiS1BBYmZVcnhVTFg4UWNkaVJ0eENEbHVQMmovZ3Bw?=
 =?utf-8?B?d2NOOFhpdWwwRlRiM0IrMTZLTjl3Q3FJQWtyWU5oQUVmWWhwQWVvSmVyOUdy?=
 =?utf-8?B?dzFUakxlY3VHY2xaMHZwWVNzUS9ZTTZSamZ1RWNwaDlpTkU1dko4eCtzNHk2?=
 =?utf-8?B?ZStNbGsrNHB2dmFTZlF0OFZURjJHY1A0MzltRHZUU2g5WHY0WkxFUG9hS1hN?=
 =?utf-8?B?dktsa0hWa1pVV1NObEZMdHN5QWRwc3NhVzhWV0c1OXFHMEhOUCsrdEJkQnZn?=
 =?utf-8?Q?ZKis=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5967900b-2825-4e49-e092-08dbcf393047
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 17:47:53.5128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6U8kaRq1/KsvSk8gsS8etydiCfDXv6nlMJf3gPz0fHdkmKEhPbZZbYL4RMGyph5/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6769
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------CEmSkaqF0aOaf8z0ZhUmyQ1K
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Reinette,

Boris pulled rest of the patches. Thank you very much for the feedback and
patience.

I can send this as a separate patch with all the FTYPE documentation
update. This need go later.


On 10/16/23 15:46, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/14/2023 4:06 PM, Moger, Babu wrote:
>> On 10/13/2023 4:39 PM, Moger, Babu wrote:
>>> On 10/13/2023 4:23 PM, Reinette Chatre wrote:
>>>> On 10/13/2023 1:25 PM, Babu Moger wrote:
>>>>> resctrl uses RFTYPE flags for creating resctrl directory structure.
>>>>>
>>>>> Definitions and directory structures are not documented. Add
>>>>> comments to improve the readability and help future additions.
>>>>>
>>>>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>>>>> ---
>>>>> v13: Fixed the format issues in the documentation. Needed few minor format
>>>>>       changes to address the syntax issues.(Reinette)
>>>>>       Removed "Reviewed-by and Tested-by" flags as the patch has changed.
>>>>>
>>>>> v12: Moved the comments from arch/x86/kernel/cpu/resctrl/internal.h
>>>>>       to Documentation/arch/x86/resctrl.rst. (Boris)
>>>>> ---
>>>>>   Documentation/arch/x86/resctrl.rst | 64 ++++++++++++++++++++++++++++++
>>>>>   1 file changed, 64 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>>> index 178ab1d8f747..1163da74f734 100644
>>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>>> @@ -369,6 +369,70 @@ When monitoring is enabled all MON groups will also contain:
>>>>>       the sum for all tasks in the CTRL_MON group and all tasks in
>>>>>       MON groups. Please see example section for more details on usage.
>>>>>   +RESCTRL filesystem implementation notes
>>>>> +=======================================
>>>>> +RESCTRL filesystem has two main components
>>>>> +    a. info
>>>>> +    b. base
>>>>> +
>>>>> +    /sys/fs/resctrl/
>>>>> +    |
>>>>> +    -> info
>>>>> +    |
>>>>> +    |  (Top level directory named "info". Contains files that
>>>>> +    |   provide details on control and monitoring resources")
>>>>> +    |
>>>>> +    -> base
>>>>> +
>>>> Could you please do a "make htmldocs" and then ensure that the output looks sane?
>>>> The resulting output does not look right to me. For example, the above turns into
>>>> a single line that looks like:
>>>>
>>>> /sys/fs/resctrl/ | -> info | | (Top level directory named "info". Contains files that | provide details on control and monitoring resources") | -> base
>>>>
>>>>
>>>> The spacing also looks off when viewing this in html.
>>>
>> I have fixed the all the format issues. Please let me know if it
>> looks ok. I will send the final version after that.
>>
>> Attached the patch and also added the diff inline.
> 
> This still does not look as though you consider how the document 
> looks after the changes.
> 
> Consider the organization. Before your changes (assume numbering starts
> at 1):
> 
> 1. User Interface for Resource Control feature
> 1.1 Info directory
> 1.2 Resource alloc and monitor groups
> 1.2.1 Resource allocation rules
> 1.2.2 Resource monitoring rules
> 1.3 Notes on cache occupancy monitoring and control
> ...
> 
> After your changes:
> 
> 1. User Interface for Resource Control feature
> 1.1 Info directory
> 1.2 Resource alloc and monitor groups
> 1.2.1 Resource allocation rules
> 1.2.2 Resource monitoring rules
> 1.2.3 RESCTRL filesystem implementation notes
> 1.3 Notes on cache occupancy monitoring and control
> ...
> 
> Note how the "RESCTRL filesystem implementation notes" is inserted
> as a subsection of resource and monitoring groups. Since the text
> describes all files in resctrl (not just resource groups) I expect
> that it would not be buried as a subsection of resource groups.

we can make a separate sub chapter for this. Something like this.

1. User Interface for Resource Control feature
1.1 Info directory
1.2 Resource alloc and monitor groups
1.2.1 Resource allocation rules
1.2.2 Resource monitoring rules
1.3 RESCTRL filesystem implementation notes
1.3.1 info directory structure
1.3.2 base directory structure
1.3 Notes on cache occupancy monitoring and control

> 
> This addition also ignores existing customs. Nowhere in the
> entire document will you find "RESCTRL" (well, except for the
> config option).

Sure. We can change this to "resctrl"

>  
>> Thanks
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>> index 178ab1d8f747..e990272e9a4f 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -396,6 +396,67 @@ Resource monitoring rules
>>  3) Otherwise RDT events for the task will be reported in the root level
>>     "mon_data" group.
>>
>> +RESCTRL filesystem implementation notes
>> +---------------------------------------
>> +RESCTRL filesystem has two main components.
> 
> This documentation was extracted as-is from the header file where it
> was next to the flags being documented. With this move all that context
> is lost so it may be helpful to summarize what is documented here.

I can move the notes here with some modifications.

> 
>> +
>> +a. info
>> +b. base
>> +
>> +::
> 
> If I understand correctly, instead of adjusting to the target format you
> hardcode all the text as pre-formatted? That may be ok. I cannot speak to
> whether this matches expectations of the proposal to move the documentation
> here.

I am not sure either.

> 
>> +
>> +       /sys/fs/resctrl/
>> +               |
>> +               |--> info (Top level directory named "info". Contains files that
>> +               |          provide details on control and monitoring resources")
>> +               |
>> +               |--> base (Root directory associated with default resource group as
>> +                          well as directories created by user for MON and CTRL groups.
>> +                          Contains files to interact with MON and CTRL groups)
>> +
>> +               Note: resctrl uses flags for files, not for directories. Directories
>> +                     are created based on the resource type. Added the directories
>> +                     below for better understanding. The RFTYPE flags are defined
>> +                     in arch/x86/kernel/cpu/resctrl/internal.h.
>> +
>> +"info directory structure"::
>> +
> 
> This unexpected. In your previous response you noted that you did not know
> how to make it look like a header. I expected that you would read the manual
> to answer your own question but instead you just placed the title in quotes? I do
> not see how placing text in quotes create impression that it is a header.
> There is syntax to indicate section headers.

Actually, i have kind of understood all the formatting details. Still
learning though. Attached the patch.
-- 
Thanks
Babu Moger
--------------CEmSkaqF0aOaf8z0ZhUmyQ1K
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-resctrl-Add-comments-on-RFTYPE-flags-hierarchy.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-resctrl-Add-comments-on-RFTYPE-flags-hierarchy.patc";
 filename*1="h"
Content-Transfer-Encoding: base64

RnJvbSAwOGUyNjg0MWY4MmVjY2ZlZjljYjNjNWUyN2EyZDdiYzVlYmVhZjNhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+CkRhdGU6
IFR1ZSwgMTcgT2N0IDIwMjMgMTE6MzQ6MzMgLTA1MDAKU3ViamVjdDogW1BBVENIXSB4ODYvcmVz
Y3RybDogQWRkIGNvbW1lbnRzIG9uIFJGVFlQRSBmbGFncyBoaWVyYXJjaHkKCnJlc2N0cmwgdXNl
cyBSRlRZUEUgZmxhZ3MgZm9yIGNyZWF0aW5nIHJlc2N0cmwgZGlyZWN0b3J5IHN0cnVjdHVyZS4K
CkRlZmluaXRpb25zIGFuZCBkaXJlY3Rvcnkgc3RydWN0dXJlcyBhcmUgbm90IGRvY3VtZW50ZWQu
IEFkZApjb21tZW50cyB0byBpbXByb3ZlIHRoZSByZWFkYWJpbGl0eSBhbmQgaGVscCBmdXR1cmUg
YWRkaXRpb25zLgoKU2lnbmVkLW9mZi1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29t
PgotLS0KIERvY3VtZW50YXRpb24vYXJjaC94ODYvcmVzY3RybC5yc3QgfCA3MyArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3MyBpbnNlcnRpb25zKCspCgpk
aWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni9yZXNjdHJsLnJzdCBiL0RvY3VtZW50
YXRpb24vYXJjaC94ODYvcmVzY3RybC5yc3QKaW5kZXggYTYyNzlkZjY0YTlkLi5jODlhOTI2OTM0
ZmUgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vYXJjaC94ODYvcmVzY3RybC5yc3QKKysrIGIv
RG9jdW1lbnRhdGlvbi9hcmNoL3g4Ni9yZXNjdHJsLnJzdApAQCAtNDA3LDYgKzQwNyw3OSBAQCBS
ZXNvdXJjZSBtb25pdG9yaW5nIHJ1bGVzCiAzKSBPdGhlcndpc2UgUkRUIGV2ZW50cyBmb3IgdGhl
IHRhc2sgd2lsbCBiZSByZXBvcnRlZCBpbiB0aGUgcm9vdCBsZXZlbAogICAgIm1vbl9kYXRhIiBn
cm91cC4KIAorcmVzY3RybCBmaWxlc3lzdGVtIGltcGxlbWVudGF0aW9uIG5vdGVzCis9PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KKworVGhpcyBzZWN0aW9uIGxpc3RzIHRo
ZSBmaWxlcyBhbmQgZGlyZWN0b3JpZXMgdW5kZXIgcmVzY3RybCBmaWxlc3lzdGVtIHRvCit1bmRl
cnN0YW5kIGZpbGVzeXN0ZW0gaGllcmFyY2h5LiByZXNjdHJsIG1vZHVsZSB1c2VzIFJGVFlQRSBm
bGFncyBkZWZpbmVkCitpbiBhcmNoL3g4Ni9rZXJuZWwvY3B1L3Jlc2N0cmwvaW50ZXJuYWwuaCB0
byBjcmVhdGUgZmlsZXMuIERpcmVjdG9yaWVzIGFyZQorY3JlYXRlZCBiYXNlZCBvbiB0aGUgcmVz
b3VyY2UgdHlwZS4KKworcmVzY3RybCBmaWxlc3lzdGVtIGhhcyB0d28gbWFpbiBjb21wb25lbnRz
LgorCisxKSBpbmZvCisyKSBiYXNlCisKKzo6CisKKwkvc3lzL2ZzL3Jlc2N0cmwvCisJfAorCXwt
LT4gaW5mbyAoVG9wIGxldmVsIGRpcmVjdG9yeSBuYW1lZCAiaW5mbyIuIENvbnRhaW5zIGZpbGVz
IHRoYXQKKwl8ICAgICAgICAgcHJvdmlkZSBkZXRhaWxzIG9uIGNvbnRyb2wgYW5kIG1vbml0b3Jp
bmcgcmVzb3VyY2VzIikKKwl8CisJLS0+IGJhc2UgKFJvb3QgZGlyZWN0b3J5IGFzc29jaWF0ZWQg
d2l0aCBkZWZhdWx0IHJlc291cmNlIGdyb3VwIGFzCisJICAgICAgICAgIHdlbGwgYXMgZGlyZWN0
b3JpZXMgY3JlYXRlZCBieSB1c2VyIGZvciBNT04gYW5kIENUUkwgZ3JvdXBzLgorCSAgICAgICAg
ICBDb250YWlucyBmaWxlcyB0byBpbnRlcmFjdCB3aXRoIE1PTiBhbmQgQ1RSTCBncm91cHMpCisK
K2luZm8gZGlyZWN0b3J5IHN0cnVjdHVyZQorLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCisKKwkt
LT4gUkZUWVBFX0lORk8KKwkgICAgRGlyZWN0b3J5OiBpbmZvCisJCS0tPiBSRlRZUEVfVE9QIChG
aWxlcyBpbiB0b3AgbGV2ZWwgb2YgaW5mbyBkaXJlY3RvcnkpCisJCSAgICBGaWxlOiBsYXN0X2Nt
ZF9zdGF0dXMKKworCQktLT4gUkZUWVBFX01PTiAoRmlsZXMgZm9yIGFsbCBtb25pdG9yaW5nIHJl
c291cmNlcykKKwkJICAgIERpcmVjdG9yeTogTDNfTU9OCisJCSAgICAgICAgRmlsZXM6IG1vbl9m
ZWF0dXJlcywgbnVtX3JtaWRzCisKKwkJCS0tPiBSRlRZUEVfUkVTX0NBQ0hFIChGaWxlcyBmb3Ig
Y2FjaGUgbW9uaXRvcmluZyByZXNvdXJjZXMpCisJCQkgICAgRGlyZWN0b3J5OiBMM19NT04KKwkJ
CSAgICAgICAgRmlsZXM6IG1heF90aHJlc2hvbGRfb2NjdXBhbmN5LAorCQkJICAgICAgICAgICAg
ICAgbWJtX3RvdGFsX2J5dGVzX2NvbmZpZywKKwkJCSAgICAgICAgICAgICAgIG1ibV9sb2NhbF9i
eXRlc19jb25maWcKKworCQktLT4gUkZUWVBFX0NUUkwgKEZpbGVzIGZvciBhbGwgY29udHJvbCBy
ZXNvdXJjZXMpCisJCSAgICBEaXJlY3RvcmllczogTDIsIEwzLCBNQiwgU01CQSwgTDJDT0RFLCBM
MkRBVEEsIEwzQ09ERSwgTDNEQVRBCisJCSAgICAgICAgICAgRmlsZTogbnVtX2Nsb3NpZHMKKwor
CQkJLS0+IFJGVFlQRV9SRVNfQ0FDSEUgKEZpbGVzIGZvciBjYWNoZSBjb250cm9sIHJlc291cmNl
cykKKwkJCSAgICBEaXJlY3RvcmllczogTDIsIEwzLCBMMkNPREUsIEwyREFUQSwgTDNDT0RFLCBM
M0RBVEEKKwkJCSAgICAgICAgICBGaWxlczogYml0X3VzYWdlLCBjYm1fbWFzaywgbWluX2NibV9i
aXRzLAorCQkJICAgICAgICAgICAgICAgICBzaGFyZWFibGVfYml0cworCisJCQktLT4gUkZUWVBF
X1JFU19NQiAoRmlsZXMgZm9yIG1lbW9yeSBjb250cm9sIHJlc291cmNlcykKKwkJCSAgICBEaXJl
Y3RvcmllczogTUIsIFNNQkEKKwkJCSAgICAgICAgICBGaWxlczogYmFuZHdpZHRoX2dyYW4sIGRl
bGF5X2xpbmVhciwKKwkJCSAgICAgICAgICAgICAgICAgbWluX2JhbmR3aWR0aCwgdGhyZWFkX3Ro
cm90dGxlX21vZGUKKworYmFzZSBkaXJlY3Rvcnkgc3RydWN0dXJlCistLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQorCisJLS0+IFJGVFlQRV9CQVNFIChGaWxlcyBjb21tb24gZm9yIGJvdGggTU9O
IGFuZCBDVFJMIGdyb3VwcykKKwkgICAgRmlsZXM6IGNwdXMsIGNwdXNfbGlzdCwgdGFza3MKKwor
CQktLT4gUkZUWVBFX01PTiAoRmlsZXMgZm9yIE1PTiBncm91cCkKKworCQkJLS0+IFJGVFlQRV9E
RUJVRyAoRmlsZXMgdG8gaGVscCByZXNjdHJsIGRlYnVnZ2luZykKKwkJCSAgICBGaWxlOiBtb25f
aHdfaWQKKworCQktLT4gUkZUWVBFX0NUUkwgKEZpbGVzIGZvciBDVFJMIGdyb3VwKQorCQkgICAg
RmlsZXM6IG1vZGUsIHNjaGVtYXRhLCBzaXplCisKKwkJCS0+IFJGVFlQRV9ERUJVRyAoRmlsZXMg
dG8gaGVscCByZXNjdHJsIGRlYnVnZ2luZykKKwkJCSAgIEZpbGU6IGN0cmxfaHdfaWQKKwogCiBO
b3RlcyBvbiBjYWNoZSBvY2N1cGFuY3kgbW9uaXRvcmluZyBhbmQgY29udHJvbAogPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KLS0gCjIuMzQuMQoK

--------------CEmSkaqF0aOaf8z0ZhUmyQ1K--
