Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275F278F63D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 01:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347903AbjHaX6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 19:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230260AbjHaX6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 19:58:32 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA4FE6A;
        Thu, 31 Aug 2023 16:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeZaevg/AfcMgwB2749P30rmMYPK7g18H7h7ifZujYQHxS6NV3FUz6av9p8tksBBsND2UrnARXb/7Ratbkxxt6qZPNbc/dk4ZwSnyMoIwyXfptrQRSbqhJkmk/NBvG1O7hbKutctayxQ0OrYxTMZcLnj9z9Ja2x7pEw/L0VGIYP3FXipqPxYPPiV+k3oeq9oWmQLP5KjuTnhMgg/L/MsKG1J6eM5wa69d4gS0zSnGVWoLuRQIzquWDB4AIo/p9bjokd3Ce/4QUzAtqpRnh+TZHZRxikoFqNprhVkSw0RccwFyCQpvF0cUaAikoackRfhQvRYknHFSDic5cHWsNmgpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VTtkt6aaIz4CVK3LpIFwIR8oYbY+K0Zr3odLPH70gfY=;
 b=Mm4WWOXTV/Z5rEhe+whlQK/rxSHtt/ZUst+MeHUfcgSuvBE03dvnFYjDGzCtSho1T8rgvOl2T7/NlPnPxOyNlDbq432O834ZBNCQStplolF48jm4SjHH21oKK5IIihtOl9NX2C+GnHYOlaXdmm9WJqbafF0KFIoh+APbatNAliktoGQrIvFqDszyEZvyQBS2i/i8ivUllHOTGPP2v99pXMwoGLLZX2+HQg15wO87H7A6jUH6M+Lc/DuKnReQiYxJOv8eiA83gbEdTIslnTX0MEoYycnVP7hf+8brx2cLKrFFtTWEtfNl0Td6OgRlyEWEe5qqr4PuRzgLQQQiJK1Jxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VTtkt6aaIz4CVK3LpIFwIR8oYbY+K0Zr3odLPH70gfY=;
 b=YVGuIcoDMQWmLEtJZKcvYibCcGQPkbgDdN4WsSndJxgz/7xYKeJZ1qngUTgxMRL53cWFBvt9xT4vX+57p6vpOtaH9qo6DCXkMf6+ch+zPWvQr40m4Vg6g0RG9VaW7CzrHKaOI3Z8OiwusQadzf8Mxaez8CEsUxQ7aWdEFf0M3es=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.22; Thu, 31 Aug
 2023 23:58:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::fbfe:ec9c:b106:437e%5]) with mapi id 15.20.6745.021; Thu, 31 Aug 2023
 23:58:24 +0000
Message-ID: <012bf30d-7c41-b9a8-cdda-0922797d6a80@amd.com>
Date:   Thu, 31 Aug 2023 18:58:20 -0500
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
Content-Language: en-US
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <5b75506b-80ac-a89d-4b70-f775c3b354d3@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0008.namprd06.prod.outlook.com
 (2603:10b6:8:2a::15) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5cc1a0-1141-4e7a-9cfa-08dbaa7e29b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UYLqW0Bn7Erwv3LYEckz31g7vyPFRAdmPGXJIs1n0npfDzHN48FDlzbtqyh3w9keloTdKakQ/uJiE1P80PZjBSkoQGX9wGK/EvqLF7Vy9Ujw9tD73XmD0Myw1gzdTsH80NeXuFNSxyTRVVoHQEgCr0zdh+wxyX/2jcFr/itKd/b2y3K2mWOL7tg6oYB+iIrJhC+a3Acy4QvaKz6wVI/GAOcqVRyaz/rYNLkL0Qn9V9pEf3NFgDuHj/iHlhKjkECatts0nk44JuNRjbmD0fEItgJ4EuZ2USClwpkN7p+ooFGWIwtql496MQefsoxw7txzHtDgX/xhTTABKgwPdDqVSaBdh+1hCM+gcXZxViP3CdcDstAA6s1m/PATN3FUcewxTvG3v5m0iwMNxmhaBXtA0JM1Q9WfJWeU80F+kgoycfpx1mZxdIOV4BG1VwGCU0P4AgaiJQQN8BUTu/AMgTVmNx7CWPgp89K4yMTgZ649gheBln2dLjupYjVfO1Ld4OcRNs9wbyO0y+/DuUM1bl1HeTnUi+Wwn0jDyUzKorqNkQmxYI9thTFs1Z1rTwCNIByzkOmm4acOVkS1NYo5LUwKZSGiUtzM1gcUeHJkkez6KuWG2UrOmQQU3vTvnmccF+/G8qUNoCn8oaP4atchRIEGZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(39860400002)(376002)(396003)(186009)(1800799009)(451199024)(41300700001)(83380400001)(8676002)(8936002)(4326008)(478600001)(66476007)(6666004)(66556008)(26005)(2616005)(53546011)(6486002)(6506007)(6512007)(316002)(2906002)(66946007)(38100700002)(7406005)(5660300002)(7416002)(3450700001)(86362001)(31696002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXNXdlY5UFVXOGpjeU8yVXJlRTRvWEZMMGJ2ZXYxSnZXem9OTnRTOXhKbGlR?=
 =?utf-8?B?Y29FcDBhMXZmTVAyY1d0UyszcmZWcnZoeEZ5N1c5Wm1nNTNUNXRSVzR0TnpV?=
 =?utf-8?B?STEzUEJjMWJQL0NkYUl0Z0YycjNGT3k1dVNQTnlhL2lPYlNJcVUvbTUvTFB6?=
 =?utf-8?B?S3hURE80anpCOUVLVStNNm1Zb2hOeFZlMTdzYUxwV3NtdTBUdU5RZkxDWHhT?=
 =?utf-8?B?WVFqSnhWeWl6UExINXkxWGVEbmNsVVZmaUNLMW55cVpOK1NhTHp4MTY0allO?=
 =?utf-8?B?MlVtd1FoRjZBZjJoVGRXNmJReVhZbFNhWlloMXpMSlg4aFN3djRCQTdRS2t4?=
 =?utf-8?B?VmErRmZHWGJITnFLcmdJeERxQjZHVHFHck5FenArOEpjbENoemd3dktXOFFz?=
 =?utf-8?B?TlhVYlc5aWFFNEl6VlhDcFNSdVYxY2lIcjF2S0huMGxVL3YrV1NoUjViRE9m?=
 =?utf-8?B?S1NZdDZpL0FhbXQxOExTMElLK2xaUTZWSHhVT0wwWmJjMFZFWmRsVCtxb2JP?=
 =?utf-8?B?UTV1NW8zZEY0MklpU2ZiQVpSWi9CeER3TVFLcFpOd0NoMmo0b1BROG1Ockhr?=
 =?utf-8?B?T3lEem5jZmdxK2oyWWR4RC9SWU1uSys1c3BTUjFuZDRXVUoxdnZPTVU1N2tM?=
 =?utf-8?B?VWxPd3Y3QUVXQ3p2aEFIS1pJTWpjcjE0VnkxMzFiYm1TTzhNeGU3cWgrbE9W?=
 =?utf-8?B?SlIxLzJuQU1vaU9MajVLbnVpQXV0clRXN2lBQ2k0NjRkdXVHcTQwQmdpRDc1?=
 =?utf-8?B?Y1JzMlIyK2pmOGk1SWFmZVREWG9abCtBUnE2ODlPL1pZQVJwQTNqR29KTlRV?=
 =?utf-8?B?aGRIOVhUbVJVWXNnYnFSUHltUyttajlFbUtuN2lIWm0vc09rekl3dWtKZ3Jh?=
 =?utf-8?B?QzJ5U0JQWnRsd29BT1daNHQ5V0ZXaXNOeDhSMHRXT1UwV0FrS0M3V3JZOXFy?=
 =?utf-8?B?Z3E0N0lHb3R3alFBNzIyRXg2U2tEbHFzdVM5SlZWV09TUTZ0UVp5NXFyV1ZQ?=
 =?utf-8?B?UmRUYVQ1QzRCU2hDUXYrM09DRVNiY3lPQmhNR21wYUZMMXl5UW5EU1VFT3ZO?=
 =?utf-8?B?RTVqTzZUMm1kb2dnUEpOZjRqaTlmTHcrWWN0RmlzS0FnN0FnOU9pTEJueUZ0?=
 =?utf-8?B?N2o4Wnk2WjExQUQ5SXFCLzlEWEJkTzVobm85ZzZTSUFGdERyay9EbmxMZmxL?=
 =?utf-8?B?ZWZ2U0ttaE1vNzJvVVJmUEkyTk9SSEp1Q2RaUlpNNGM4UGNOVVpQbHgycG0y?=
 =?utf-8?B?ZWxYbGVkaXlrV2krckMwWS8wdHREOFF0cnJkNm9sdnpnbTF6cDk5cTdTU1JL?=
 =?utf-8?B?eUxtWk16ZXAwR1lCT0FrOVBBYnljQmZYY2NsN2pZYXp5c3JURnRmWTlkd2lX?=
 =?utf-8?B?UEx0YUpPZC9OVDdGSk95Z0N6c2docldyM3JCLzJGSG1OWHRqeTJvbDBDZmNn?=
 =?utf-8?B?SWxIaldtR2EyZWFNZG8zYkM2ZDJlVytzSnEzTTY3cmhvcElTRDhsMzF4KzZw?=
 =?utf-8?B?OGRUeHFxYXZOT2JkNnRWVXgzT2xuMzVSV3FSYjMxTFc4b2FZMDJMUDhUUDEr?=
 =?utf-8?B?UmZ4dzJheHpKeUJaaHBqbFF6Ym53VGluTHFIN3BUa0l1cVZuZGk2WE5XWEVn?=
 =?utf-8?B?MzNobHNIbitJVUVBWnRPeElLbzk1UTlFbkp1cDJKeFlIMG9NcHRuZVkrdmY0?=
 =?utf-8?B?NDBuNkdvM2lMOTU4TUpwempTNmhUU25MNmU5WDFlYUNkZ0RQd2VNSXpFRXBM?=
 =?utf-8?B?RFAvNE1vTE9jWEg5WlFZRXY1dUUyUEFhQ2hmQ09MYy8rKzVhTVFmVUdTUURK?=
 =?utf-8?B?aGdHUno0UFpiMU9GNXRHUlF2MEVMMW90ZUliZWkvRkQrUWdwdStjNHRDaksw?=
 =?utf-8?B?TEJsbWhoRHk1T20zN005b0xaZVk0ZEVLL1RlemU0NVBDcHpVUXIvV0lSdkJo?=
 =?utf-8?B?NjZlc0xZSEY3cVZ4eGpvK2cxbU5UVmx0Tm0wNjJLREJadmowSW5kWEtGWjhD?=
 =?utf-8?B?Y1RienJLaytIZnBuSzVRbzZ4NzZJTjk4Tlg0cURhU2ZuUG9PN2NhbDBaR1dn?=
 =?utf-8?B?VDNNajdwMEJwSHZGYkZJUCtDay8vYXhYNjZ2TG80TnQzUGFxVmNKeGNBc0FK?=
 =?utf-8?Q?ycCg=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5cc1a0-1141-4e7a-9cfa-08dbaa7e29b4
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 23:58:24.8130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4zTCZ8dkGOA9J8I4nY6uBSbdR3T2TmiEv5toKT3MFvoO+Omub4CSr5rNxKOrXEvR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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

On 8/31/23 12:42, Reinette Chatre wrote:
> Hi Babu,
> 
> On 8/30/2023 4:19 PM, Moger, Babu wrote:
>> On 8/29/23 15:14, Reinette Chatre wrote:
>>> On 8/21/2023 4:30 PM, Babu Moger wrote:
>>>
>>> ...
>>>
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> index 2fae6d9e24d3..3fa32c1c2677 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/internal.h
>>>> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
>>>> @@ -296,9 +296,15 @@ struct rdtgroup {
>>>>   *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>>>>   *	    Files: cpus, cpus_list, tasks
>>>>   *
>>>> + *		--> RFTYPE_DEBUG (Files to help resctrl debugging)
>>>> + *		    File: mon_hw_id
>>>> + *
>>>
>>> This does not look right. I think mon_hw_id should have RFTYPE_MON
>>> (more below).
>>
>> I am not sure about this (more below).
>>
>>>
>>>>   *		--> RFTYPE_CTRL (Files only for CTRL group)
>>>>   *		    Files: mode, schemata, size
>>>>   *
>>>> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
>>>> + *			    File: ctrl_hw_id
>>>> + *
>>>>   */
>>>>  #define RFTYPE_INFO			BIT(0)
>>>>  #define RFTYPE_BASE			BIT(1)
>>>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> index 94bd69f9964c..e0c2479acf49 100644
>>>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>>>> @@ -776,6 +776,38 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>>>>  	return ret;
>>>>  }
>>>>  
>>>> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
>>>> +				struct seq_file *s, void *v)
>>>> +{
>>>> +	struct rdtgroup *rdtgrp;
>>>> +	int ret = 0;
>>>> +
>>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>> +	if (rdtgrp)
>>>> +		seq_printf(s, "%u\n", rdtgrp->closid);
>>>> +	else
>>>> +		ret = -ENOENT;
>>>> +	rdtgroup_kn_unlock(of->kn);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
>>>> +			      struct seq_file *s, void *v)
>>>> +{
>>>> +	struct rdtgroup *rdtgrp;
>>>> +	int ret = 0;
>>>> +
>>>> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
>>>> +	if (rdtgrp)
>>>> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
>>>> +	else
>>>> +		ret = -ENOENT;
>>>> +	rdtgroup_kn_unlock(of->kn);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>>  #ifdef CONFIG_PROC_CPU_RESCTRL
>>>>  
>>>>  /*
>>>> @@ -1837,6 +1869,13 @@ static struct rftype res_common_files[] = {
>>>>  		.seq_show	= rdtgroup_tasks_show,
>>>>  		.fflags		= RFTYPE_BASE,
>>>>  	},
>>>> +	{
>>>> +		.name		= "mon_hw_id",
>>>> +		.mode		= 0444,
>>>> +		.kf_ops		= &rdtgroup_kf_single_ops,
>>>> +		.seq_show	= rdtgroup_rmid_show,
>>>> +		.fflags		= RFTYPE_BASE | RFTYPE_DEBUG,
>>>
>>> I missed this earlier but I think this also needs a RFTYPE_MON.
>>> Perhaps patch 3 can introduce a new RFTYPE_MON_BASE to not
>>> have the flags of the two new files look too different?
>>
>> We have two types of files in base directory structure.
>>
>>  if (rtype == RDTCTRL_GROUP)
>>                 files = RFTYPE_BASE | RFTYPE_CTRL;
>>         else
>>                 files = RFTYPE_BASE | RFTYPE_MON;
>>
>> 1. RFTYPE_BASE | RFTYPE_CTRL;
>>    Files for the control group only.
>>
>> 2. RFTYPE_BASE | RFTYPE_MON;
>>    Files for both control and mon groups. However, RFTYPE_MON is not used
>> for any files. It is only RFTYPE_BASE.
>>
>> Because of the check in rdtgroup_add_files it all works fine.
>> For the control group it creates files with RFTYPE_BASE | RFTYPE_CTRL and
>> RFTYPE_BASE.
>>
>> For the mon group it creates files with RFTYPE_BASE only.
> 
> This describes current behavior because there are no resctrl
> files in base that are specific to monitoring, mon_hw_id is the
> first.
> 
> This does not mean that the new file mon_hw_id should just have
> RFTYPE_BASE because that would result in mon_hw_id being created
> for all control groups, even those that do not support monitoring
> Having mon_hw_id in resctrl for a group that does not support
> monitoring is not correct.
> 
> You should be able to reproduce this when booting your system
> with rdt=!cmt,!mbmlocal,!mbmtotal.

You are right. I reproduced it.

> 
>>
>> Adding FTYPE_MON_BASE will be a problem.
>>
> 
> Yes, this change does not just involve assigning the RFTYPE_MON
> to mon_hw_id. As you describe mkdir_rdt_prepare() does not take
> RFTYPE_MON into account when creating the files. Could this not just
> be a straightforward change to have it append RFTYPE_MON to the flags
> of files needing to be created for a CTRL_MON group? This would
> support new resource groups and then the default resource group
> would need to be taken into account also. What am I missing?
> 

It is not straight forward. We have have to handle few more things.
1. Base directory creation.
2. Mon directory creation after the base.

I got it working with this patches.  We may be able to clean it little
more or we can split also.

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
b/arch/x86/kernel/cpu/resctrl/internal.h
index 3fa32c1c2677..e2f3197f1c24 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -318,6 +318,7 @@ struct rdtgroup {
 #define RFTYPE_MON_INFO                        (RFTYPE_INFO | RFTYPE_MON)
 #define RFTYPE_TOP_INFO                        (RFTYPE_INFO | RFTYPE_TOP)
 #define RFTYPE_CTRL_BASE               (RFTYPE_BASE | RFTYPE_CTRL)
+#define RFTYPE_MON_BASE                        (RFTYPE_BASE | RFTYPE_MON)

 /* List of all resource groups */
 extern struct list_head rdt_all_groups;
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e0c2479acf49..1f9abab7b9bd 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1874,7 +1874,7 @@ static struct rftype res_common_files[] = {
                .mode           = 0444,
                .kf_ops         = &rdtgroup_kf_single_ops,
                .seq_show       = rdtgroup_rmid_show,
-               .fflags         = RFTYPE_BASE | RFTYPE_DEBUG,
+               .fflags         = RFTYPE_MON_BASE | RFTYPE_DEBUG,
        },
        {
                .name           = "schemata",
@@ -2558,6 +2558,7 @@ static void schemata_list_destroy(void)
 static int rdt_get_tree(struct fs_context *fc)
 {
        struct rdt_fs_context *ctx = rdt_fc2context(fc);
+       uint flags = RFTYPE_CTRL_BASE;
        struct rdt_domain *dom;
        struct rdt_resource *r;
        int ret;
@@ -2588,7 +2589,10 @@ static int rdt_get_tree(struct fs_context *fc)

        closid_init();

-       ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
+       if (rdt_mon_capable)
+               flags |= RFTYPE_MON;
+
+       ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
        if (ret)
                goto out_schemata_free;

@@ -3336,6 +3340,9 @@ static int mkdir_rdt_prepare(struct kernfs_node
*parent_kn,
        else
                files = RFTYPE_BASE | RFTYPE_MON;

+       if (rdt_mon_capable)
+               files |= RFTYPE_MON;
+
        ret = rdtgroup_add_files(kn, files);
        if (ret) {
                rdt_last_cmd_puts("kernfs fill error\n");


-- 
Thanks
Babu Moger
