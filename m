Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB42790172
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350391AbjIAR3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjIAR3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:29:01 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107B1B2;
        Fri,  1 Sep 2023 10:28:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRY4iY1wIop1wumb5cEUmjzLiHWHVJ5p5Ks6iqhlKmVon+l1WK5FLdfPuORRnBUU2ozJpvfVodH7Fh2bnB1Nr+KtNRtoBAcbEwQWjP55lGO5kulPoEB33+vUP80mTF6yZpy8XHD7MwqvsrlG6W/GrYLIYQ9vczevP3MmXr+Xjco2quWofElU5naBDIlHpuGPvozgH+J2Q7Au3/TnWZqVcBzdAmdPVmRBAoZYL0YZu8tv7i/LdLPK13d7h/dDH3Mx5Yav3PKSRbPFsKTvttUVSg9D3XaAbpWVniNfGpKVOMPirXZUADCe6u6tsL9JZhNFbmHSxD0y9QcCVS+M8sTNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDrvmqz0LQ4bsnb5jN/dmEECfYm3QJ5KUb4QcTqjcWE=;
 b=oGbUouSDnC7fypXFgq4oj7PUm9P9LobAAgMVetmUDiKikEBF8ZgOTZnlUh9ezWOVPuzqQ6cIrdP4wNz4234D0KnIfZOLY3vJA3NGkw0EG8y92hR392w5ZnGv7m+IJX6wcyWveKIf4sMhH6u7ntTXJjTgNO0YffciEn5oK3U/nk7ikXfBVHQclkSVbxVlhKTHToEUmKW1uHLAIcUNNw3MpPao4Zg76Sg8oUtbSpmKHfY+FsPqagq/lCpv+ccYjzLr/BNOr6qlgF8L0OWWoN+NL1z4BpUtfnCdfvX1N41zdg6g8jVLc592OKds8aKRVZ+WibG4s4RI8VaDLVCSzA7pdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDrvmqz0LQ4bsnb5jN/dmEECfYm3QJ5KUb4QcTqjcWE=;
 b=PlFaJUhC7NpnAlYsKf+m0jSovI16yFdqGVANBloGrr5tcy+8Zxnl5DN0O2BmUPFKxYxa2dpteeUvUzBFqjAfK4Eiu97tPcTSrcDZzr+Ek7njYXt1ZJ6eoNwG/J0M1aV1Lmw4tmsnzZtP4R+gDgzcAZQrit0KgQUSsAifUaMgGUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 17:28:52 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.023; Fri, 1 Sep 2023
 17:28:52 +0000
Message-ID: <ce3e0cf3-9b4c-86ae-8095-d433a5669737@amd.com>
Date:   Fri, 1 Sep 2023 12:28:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v8 8/8] x86/resctrl: Display hardware ids of resource
 groups
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
References: <20230821233048.434531-1-babu.moger@amd.com>
 <20230821233048.434531-9-babu.moger@amd.com>
 <4019a73a-8478-f18b-7f34-b8d838dfc7fe@intel.com>
 <da47698a-aa9e-3760-1321-5ec3ea1a14e6@amd.com>
 <5b75506b-80ac-a89d-4b70-f775c3b354d3@intel.com>
 <012bf30d-7c41-b9a8-cdda-0922797d6a80@amd.com>
 <2feb3e01-96c7-fdde-a0d2-509fa1527243@intel.com>
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <2feb3e01-96c7-fdde-a0d2-509fa1527243@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0284.namprd03.prod.outlook.com
 (2603:10b6:5:3ad::19) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: 7deda862-1417-41c0-fc21-08dbab10e938
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cw1lSZ7UoCBzRgHlKFFyxWErMbmlpiEYdYsE31i4Wsxu1IiQr2hPuj1VIcAuV28H2PXJ3teQ9NF30qpK6fW7Hm0ewRHJajSQ8cRc/vtvY7UxJgCjLLuGq/bR3eRv/q2KTN/mg1+kuaT2rWMvLPDdoAANE1XTJlMktKpRlonmXF2XAc8UtR91mrNGI08jkznm5TO6jSDz/Ou9YCiIuKkJszP+pOsXAKpl5rl0J+7Lr4HTBQTG1CW4UuWoWPrV5YG0/muwY+UFWAgnnlZ0gf8/wvLqhGq3W7rakMwQ3srVuRtHzOgcUkuPAJ9YSvJx5XzGEb0n5jv8by2Zls0AapFjYKXoP04r1nTVdZ9s9zCl5stCVcCvlQvBEbmh0FCWEhw/cQUdpmBTP18Eqjwr6Br7kllEj0gO6nBZxMGgdhFXDxtlgF103Q3agmBSsJAUCmsMWH1aujHTFOyBYYpyDshq/jyHJGUaEVy7N4CeFc6C1EEyBtwUrXWwpyD5geUZ6rThPCma9KcNYWf3SuPiOUi4srgsByA/bOU/Iu0y/+m3LD8flGRumE485Ebj9F9bw79XfZJ0uDhm6WTHQ3CSGyp8MfQ2A7NgqLrzDXUzNo1J7XHHALnrrF/uTdNVYypKJHyXRVWxi+jcXzF/uIpnGM++A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199024)(1800799009)(186009)(31686004)(6666004)(6486002)(6512007)(66946007)(6506007)(36756003)(38100700002)(86362001)(31696002)(3450700001)(2906002)(2616005)(26005)(53546011)(83380400001)(478600001)(4326008)(8936002)(316002)(66556008)(8676002)(5660300002)(7406005)(66476007)(41300700001)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c3R6d3o2YVVEWjVPV1FKZVBnSUpSOXRRSVJ4d1EyZ1M1aVc3QmlpL2diQzV4?=
 =?utf-8?B?RWt2NzVHcjEvYXNUMzlMN1IzQnNYQzNYUW5DL3BYL1NlSzZaSkJKcitLWEEz?=
 =?utf-8?B?RXNpTXZPZFVRb0VaRDRJYUZsMWFlaGQzMGF3di85RExENlNuWlBjK0FiRVBx?=
 =?utf-8?B?VFBHU3BYekF5V3IzSlE5dVJRekpxSThFajBNV0pQK01xME1rTzhIR2ZuZGdL?=
 =?utf-8?B?Zy9QTjVoZW1TaEZ2M2dBZHY4OC9jMytoa0hYcUNWdXNaQUl6Q1Q4Q2NZU250?=
 =?utf-8?B?alhHZDQ1WVpnc014cGNXbEEvZmVjVlNDa09tMy84K0FEOUdwRlBpWnYweExM?=
 =?utf-8?B?VHQxbXJPT1dFT2o0bWdNQ3lkTTloeTRFajkwSGVKSms0N01XV2hQVVRKbklK?=
 =?utf-8?B?RjNNY1haRCtaUnhrU0E2SklkajRla2dMM1VnQkpqTVo1RUdGbUFzMnZzbmZZ?=
 =?utf-8?B?c3phdVpUUTkxbUpSVVZiTS9Nblk5SHQ2WXpOby9XRk1CWTROQzlHcGhRU3dK?=
 =?utf-8?B?UUNtNXF2ZlozYzNzOXFTdjA2TTl6ZitWUVNuTGNwTnNtSjF0V1NMVHU1cmpj?=
 =?utf-8?B?bXFwVWhBMFhZaENiaG9LdWRPa3Z2YkhuU21McmFEVlF1Y0Z2ZFV5Nmx3aXBX?=
 =?utf-8?B?NVJWZTlpU3FCV24yMm03TExWdXhKTG5MOEdqTjJpSUp6dUN3eVV1cVd0clA4?=
 =?utf-8?B?R3JzNkVBOTBpcEtwSlJTNDZTWEVGbHRpNm81WUFyTFEweENNY0ZsUEE0V2lB?=
 =?utf-8?B?eUh1QW9rcUtUb2JSZjVOaGVEZU9BemxQMGEwUkw1ejJhWGpPZjFwbjFrMHE4?=
 =?utf-8?B?ZmRyYWxUOTZtRmVsaFZOdGNraTRSNUt4ZnBEOXM1UXk1c1lYK0wrWkxnc3Jx?=
 =?utf-8?B?aUJ6MjBJSEFOZmRBVUpDYkZHNFM2QXJSaUZPdFFLajdsQ0U4aVdodnBKNDNP?=
 =?utf-8?B?V3I5ODdRV1lIcWlYejNaY2NjSlRiN3o0SkVMdFJ1Tkx1c2lrUWJtajhod3R3?=
 =?utf-8?B?dkdUZDFNMlNINUsvSkxrclhybkMzdkJJVHljUVBRcXo4bkEwVGpYRFl2bDlE?=
 =?utf-8?B?U21XcDlFR0p3OWUvWlJDcXhTbjZwQVdNTkpmZWRXSUJydy9vcHNMZHJpZmNv?=
 =?utf-8?B?M1B6WlhGNGx0Z2l4OExmdmJNNEo5M1p4QjdLNEc5YmdJcWhBK1FBOEdrZ0M5?=
 =?utf-8?B?VUFaVlhPZW5qdDhTdnJ5Q25ZMjVpRE93MGYwQ0xCdGNLZktRTSsySG1lMmlY?=
 =?utf-8?B?Q2FqNS9YR1M5VFA1Sk5WaDl1YnZyTGpwMDd0WUpPUUdXR1loYklhUWhDaVYx?=
 =?utf-8?B?c1FyaVllWnJuQmpGcTBGOExPTVdBTDJXNlVBdkZMdjRFUXRpYy9uZWhlcjl1?=
 =?utf-8?B?VHlRYVR6NUdrTThLaTUzWGJWaFFxTzJNWGFPbUZWM0xRK2hHY0MwdVc5NjZH?=
 =?utf-8?B?TXRzWEtydFBsZHlQUDhrbHduWjhYM2QyREFDZy8xbTBvdlcyUHNISWNHNmpT?=
 =?utf-8?B?NWo4TFR6VFdRNlRkUVlDNm9JbVRIUXZTS1BQUVZKYWJLUERoOGhUcmRvKzky?=
 =?utf-8?B?QlAwZENMK0tMcDQ3NDVoY2VIU3lTSXM0aWNORE5EREFiaGFRNVFRbElLQ2Vp?=
 =?utf-8?B?Z3MvbFhIV1Uzb09udENST0xJcnYwZ2VWVHJ4S2Vtdm9RcTc4VGFnK2F2SlN2?=
 =?utf-8?B?RjNLQjYrZ1h5RU5kOEMwcmxuanhxeGFDbUM5WUFoWEd3SXhzVFlRbG9CZlo4?=
 =?utf-8?B?OUVxdkNjUG9OR3BsMlo1WTZXY2xxQUZzaTNCZ1cxOHhkZWJPdHR6bzhYSEFx?=
 =?utf-8?B?TFFjanpUNHVKSnNoem9zUEhRVWx2NDFqeGR6c1VmcGJJVjRYMm5TQ01QODlU?=
 =?utf-8?B?QnFYR3RoQjJVRjhmOW5mTXdBRXgyaHlYZWYwaDZKaExyUXFFTUh4STlldXhU?=
 =?utf-8?B?cnJUTVVKQ2d4OE5saVB3bFdLVDhya0I4RHUrRTBFVER4RlV1cUNzRUFZOUNr?=
 =?utf-8?B?NlhxTHF6dElrZWZ3YjJVSkUvZXFkdnA2UVBJODNkVlVBQ25jY3BaK0xQVGVq?=
 =?utf-8?B?Mkx2NXVXZi94QVNucUprTzVGSENQRGJpUUdXdzJrenRVS0JZOE5yMTl0UUI1?=
 =?utf-8?Q?UxxY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7deda862-1417-41c0-fc21-08dbab10e938
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 17:28:52.6326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ80wenuT+7NVXm8CqbohRK2bniOAqD4ZCYvbDbyaJqMPeRkqtSYQcbCHfbl1CnD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 8/31/23 19:43, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/31/2023 4:58 PM, Moger, Babu wrote:
>> On 8/31/23 12:42, Reinette Chatre wrote:
>>> On 8/30/2023 4:19 PM, Moger, Babu wrote:
>>>> On 8/29/23 15:14, Reinette Chatre wrote:
>>>>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>>>>
>>>>> ...
>>>>>
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> index 2fae6d9e24d3..3fa32c1c2677 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>>>> @@ -296,9 +296,15 @@ struct rdtgroup {
>>>>>>   *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>>>>>   *	    Files: cpus, cpus_list, tasks
>>>>>>   *
>>>>>> + *		--> RFTYPE_DEBUG (Files to help resctrl debugging)
>>>>>> + *		    File: mon_hw_id
>>>>>> + *
>>>>>
>>>>> This does not look right. I think mon_hw_id should have RFTYPE_MON
>>>>> (more below).
>>>>
>>>> I am not sure about this (more below).
>>>>
>>>>>
>>>>>>   *		--> RFTYPE_CTRL (Files only for CTRL group)
>>>>>>   *		    Files: mode, schemata, size
>>>>>>   *
>>>>>> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
>>>>>> + *			    File: ctrl_hw_id
>>>>>> + *
>>>>>>   */
>>>>>>  #define RFTYPE_INFO			BIT(0)
>>>>>>  #define RFTYPE_BASE			BIT(1)
>>>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> index 94bd69f9964c..e0c2479acf49 100644
>>>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>>>> @@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>>>>>>  	return ret;
>>>>>>  }
>>>>>>  
>>>>>> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
>>>>>> +				struct seq_file *s, void *v)
>>>>>> +{
>>>>>> +	struct rdtgroup *rdtgrp;
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>>> +	if (rdtgrp)
>>>>>> +		seq_printf(s, "%u\n", rdtgrp->closid);
>>>>>> +	else
>>>>>> +		ret = -ENOENT;
>>>>>> +	rdtgroup_kn_unlock(of->kn);
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>>>>> +			      struct seq_file *s, void *v)
>>>>>> +{
>>>>>> +	struct rdtgroup *rdtgrp;
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>>>> +	if (rdtgrp)
>>>>>> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>>>>>> +	else
>>>>>> +		ret = -ENOENT;
>>>>>> +	rdtgroup_kn_unlock(of->kn);
>>>>>> +
>>>>>> +	return ret;
>>>>>> +}
>>>>>> +
>>>>>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>>>>>  
>>>>>>  /*
>>>>>> @@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
>>>>>>  		.seq_show	= rdtgroup_tasks_show,
>>>>>>  		.fflags		= RFTYPE_BASE,
>>>>>>  	},
>>>>>> +	{
>>>>>> +		.name		= "mon_hw_id",
>>>>>> +		.mode		= 0444,
>>>>>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>>>>>> +		.seq_show	= rdtgroup_rmid_show,
>>>>>> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>>>>>
>>>>> I missed this earlier but I think this also needs a RFTYPE_MON.
>>>>> Perhaps patch 3 can introduce a new RFTYPE_MON_BASE to not
>>>>> have the flags of the two new files look too different?
>>>>
>>>> We have two types of files in base directory structure.
>>>>
>>>>  if (rtype == RDTCTRL_GROUP)
>>>>                 files = RFTYPE_BASE | RFTYPE_CTRL;
>>>>         else
>>>>                 files = RFTYPE_BASE | RFTYPE_MON;
>>>>
>>>> 1. RFTYPE_BASE | RFTYPE_CTRL;
>>>>    Files for the control group only.
>>>>
>>>> 2. RFTYPE_BASE | RFTYPE_MON;
>>>>    Files for both control and mon groups. However, RFTYPE_MON is not used
>>>> for any files. It is only RFTYPE_BASE.
>>>>
>>>> Because of the check in rdtgroup_add_files it all works fine.
>>>> For the control group it creates files with RFTYPE_BASE | RFTYPE_CTRL and
>>>> RFTYPE_BASE.
>>>>
>>>> For the mon group it creates files with RFTYPE_BASE only.
>>>
>>> This describes current behavior because there are no resctrl
>>> files in base that are specific to monitoring, mon_hw_id is the
>>> first.
>>>
>>> This does not mean that the new file mon_hw_id should just have
>>> RFTYPE_BASE because that would result in mon_hw_id being created
>>> for all control groups, even those that do not support monitoring
>>> Having mon_hw_id in resctrl for a group that does not support
>>> monitoring is not correct.
>>>
>>> You should be able to reproduce this when booting your system
>>> with rdt=!cmt,!mbmlocal,!mbmtotal.
>>
>> You are right. I reproduced it.
>>
>>>
>>>>
>>>> Adding FTYPE_MON_BASE will be a problem.
>>>>
>>>
>>> Yes, this change does not just involve assigning the RFTYPE_MON
>>> to mon_hw_id. As you describe mkdir_rdt_prepare() does not take
>>> RFTYPE_MON into account when creating the files. Could this not just
>>> be a straightforward change to have it append RFTYPE_MON to the flags
>>> of files needing to be created for a CTRL_MON group? This would
>>> support new resource groups and then the default resource group
>>> would need to be taken into account also. What am I missing?
>>>
>>
>> It is not straight forward. We have have to handle few more things.
>> 1. Base directory creation.
>> 2. Mon directory creation after the base.
>>
> 
> heh ... these are not a "few more things" ... these are exactly
> the items I mentioned: "base directory creation" is taking into account
> the default resource group and "mon directory creation after the
> base" are the changes needed in mkdir_rdt_prepare() where RFTYPE_MON
> is appended to the flags.

Ok. Got it.
> 
>> I got it working with this patches.  We may be able to clean it little
>> more or we can split also.
> 
> I think it would make things easier to understand if there
> is a separate patch that adds support for files with
> RFTYPE_MON flag.

Ok. Sure,

> 
>>
>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
>> b/arch/x86/kernel/cpu/resctrl/internal.h
>> index 3fa32c1c2677..e2f3197f1c24 100644
>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>> @@ -318,6 +318,7 @@ struct rdtgroup {
>>  #define RFTYPE_MON_INFO                        (RFTYPE_INFO | RFTYPE_MON)
>>  #define RFTYPE_TOP_INFO                        (RFTYPE_INFO | RFTYPE_TOP)
>>  #define RFTYPE_CTRL_BASE               (RFTYPE_BASE | RFTYPE_CTRL)
>> +#define RFTYPE_MON_BASE                        (RFTYPE_BASE | RFTYPE_MON)
>>
>>  /* List of all resource groups */
>>  extern struct list_head rdt_all_groups;
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index e0c2479acf49..1f9abab7b9bd 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -1874,7 +1874,7 @@ static struct rftype res_common_files[] = {
>>                 .mode           = 0444,
>>                 .kf_ops         = &rdtgroup_kf_single_ops,
>>                 .seq_show       = rdtgroup_rmid_show,
>> -               .fflags         = RFTYPE_BASE | RFTYPE_DEBUG,
>> +               .fflags         = RFTYPE_MON_BASE | RFTYPE_DEBUG,
>>         },
>>         {
>>                 .name           = "schemata",
>> @@ -2558,6 +2558,7 @@ static void schemata_list_destroy(void)
>>  static int rdt_get_tree(struct fs_context *fc)
>>  {
>>         struct rdt_fs_context *ctx = rdt_fc2context(fc);
>> +       uint flags = RFTYPE_CTRL_BASE;
> 
> I assume that you may have just copied this from mkdir_rdt_prepare() but
> I think this should rather match the type as this is used (unsigned long).

Yes. Will correct it.

> 
>>         struct rdt_domain *dom;
>>         struct rdt_resource *r;
>>         int ret;
>> @@ -2588,7 +2589,10 @@ static int rdt_get_tree(struct fs_context *fc)
>>
>>         closid_init();
>>
>> -       ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
>> +       if (rdt_mon_capable)
>> +               flags |= RFTYPE_MON;
>> +
>> +       ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
>>         if (ret)
>>                 goto out_schemata_free;
>>
>> @@ -3336,6 +3340,9 @@ static int mkdir_rdt_prepare(struct kernfs_node
>> *parent_kn,
>>         else
>>                 files = RFTYPE_BASE | RFTYPE_MON;
>>
>> +       if (rdt_mon_capable)
>> +               files |= RFTYPE_MON;
>> +
> 
> Is this not redundant considering what just happened a few lines above?

Yea. Right. I will change the previous line to

files = RFTYPE_BASE;

Thanks
Babu Moger
