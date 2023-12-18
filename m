Return-Path: <linux-kernel+bounces-3422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B27816C12
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78F1AB21928
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79F19479;
	Mon, 18 Dec 2023 11:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C1LWiiru"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2055.outbound.protection.outlook.com [40.107.237.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217141A702;
	Mon, 18 Dec 2023 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+xP04svm/xb4pP/BEDNbJcTREI6lqkebAkSBr0hOQVQgVpXcFQz2HrEZvZcco1oyq63n69ZhrvM2bkyZayhet706TqJzD4ewHIawtgD+BOiUf9ddnViaGfHwZgGOTElc6aldVfGRVFZKSA9Ojj8xJUAcd67GCw1H4yJP/5V7DNP37w8Yzbla3WgAZdkLcQZV3XvEz34VIXoYR7+HYeg8bgqOdAP8uWMQO8UaDD0f0MNkQwLUfHkQT1usW9hA5f7BW6Z4y1aqdghq74tzZvU+J3JU227/KPuNghyEnQROZFYfFRh2XL2kthGS4JT4RJe/x//it/INYtWARg4p0TqUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQBIz2snt84WRLatri1BLltuYb+xMdFQGe2A9SQgY8Y=;
 b=XOSD927Bexstph0cWgX5z6wvei0YfUF/PG5SUJN0hhym/mPJxP7LhMODtQA5xOuQ8mVxRKRDufPWNJM/z1OhQljwpXsSi8R44ssc9nSPNXrxCDeB3bUxbhIz1F6sZCjo4oLrbQuCjht53e9AZvjfdHSggnYRJajM/g915Hdc6aOy1p7N3UVqwxwsOb65x+saaKnWLkohbm+vqc3fZxLH81TaDfC6Z1Ergy+S7qy9FXT9uUyPR/EW6O6MryhG5btImLFXNzLcRQuMM2T0noXeiNPLuKynhQn1pZXfR9PaOgL/gYj2sE2tgHlfdzVVVsudg1hCN86Ew9E6W9ZivuN+Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQBIz2snt84WRLatri1BLltuYb+xMdFQGe2A9SQgY8Y=;
 b=C1LWiiruwnPYqhDWnS5TV47EJd4/4p8OcZ63tUvkDqWGh2bU7r+NK8XgIw0uhmOZFMXwgifu7M/K5vXHRcE9v38RM6sJQ9RBO1daSNiINyLKvaiXT0NnGK/aZeDp2UxzVMZ9LRTyhBlAnybj/lUKtXHUym83GTppFDJo7Lr66BQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Mon, 18 Dec
 2023 11:19:22 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.034; Mon, 18 Dec 2023
 11:19:22 +0000
Message-ID: <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
Date: Mon, 18 Dec 2023 16:49:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
Content-Language: en-US
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231213115256.GM1074920@black.fi.intel.com>
 <f673ffc8-f6f8-4898-d809-effb2c24e53e@amd.com>
 <20231214070746.GS1074920@black.fi.intel.com>
 <32163f49-8387-0754-534f-1764e731f26d@amd.com>
 <20231214073242.GT1074920@black.fi.intel.com>
 <ff143967-63ff-c4fb-9c88-8537a663c45b@amd.com>
 <20231215115521.GW1074920@black.fi.intel.com>
 <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
 <20231215140224.GX1074920@black.fi.intel.com>
 <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20231218104234.GB1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::7) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdef423-aca6-4c52-7492-08dbffbb2f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qEhSOxv+uYonB2LM3d62ExGr2qy4OOtR5eGPCR6A59LcX1ZLDctdTso+qZNn4HZ7KYXJKheIrnnLffll3V0lh0AroKTPVJYbmxgIhvEat0dFv8gVRzpPyQWO2J1hQfKV0VyGhumfBYeL8Npn7ykx21fPHCyHQ45E/NwMsfVoKDHbHjpESHtLZxZcSM8cC4HJn1QOUUjfbTrGVAJU6jhLS1d/LE4ybLHdzRVsi2BbWVRNKTWYE/YJ4N3t1c2PTQXQeLuNg/3Gp0qIOzSgZkO+O8SGKBXK94ByVOuQoa0d+8PVbtGW89s41xe3Y/+f7bqgAzKA1+mGQd70wqOkN5kKHtcH/TeVWuAYI3PLK5J5+2VrGPID+PjClQ1kMhPhBXT3WYXvnxtT4CGVWC/CwSPTuKgZc4KTkG0bLRCGTvGbO4OEwqDoZ/L9bHPBRWW+pst2feSabTiaQNh3Yf/9pbJUrdz6s1K5moPLEThcMn+sgdekReX+Zz33Mk+DQlBdiiHlQEf9Wp2JRMisw6NGVd/qvtN/yZ1edyZMdGndDmIFn9F77gjhFeLiG3HZ0JkyIJrr16Gf3yjz6k3MsBVV2IDWHVyzqQqtgTtKCoCuWMTqwUpMGOLfKmv+VvD0i4w6hFTowSDFLzARDAnc6tk3fkrgNg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(38100700002)(30864003)(2906002)(41300700001)(31696002)(31686004)(83380400001)(6666004)(4326008)(8936002)(8676002)(6486002)(2616005)(478600001)(26005)(66476007)(66556008)(66946007)(6916009)(66574015)(316002)(53546011)(6506007)(5660300002)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXhMdW0vYXA5ZUp6UWwxUTA2Tkc4YkpqcGJYcmpVUDFDYnBrMHF2UEFZVEpq?=
 =?utf-8?B?dXhNazZtR0xMRjA3TUhLdUQ3YUdZV3o0VEt0VEQ1WGlhdjNJQWtlWW1pL3hE?=
 =?utf-8?B?T3AxWnZIQkhWTkZNektNbFNLa2RIUzlQSTFiemhxcWZzZ1NLWkUwdlpVaTFS?=
 =?utf-8?B?dk5hMGZwYkFvQnl6dkVwV0t5UzErR0l1Z0U4eGRLSXYwcXJLSXJmdFVHcGJE?=
 =?utf-8?B?UVpucDlaaUxrTXFicFNMZlNSNDBWNjNxZ3R0dms0UGt6UFg3eG05R3NzM0pa?=
 =?utf-8?B?dTd2TnZTdkc4K2dNWW1mL2QxSU85T3p6NGdFUFpqSEc1NHlERGorc0hGQzVo?=
 =?utf-8?B?WFBjQjFCR3djZ2llMUwxcjF1RDQ4cmZjWHRWQ1BtS1d0RTRSa1RGS0I0bVF4?=
 =?utf-8?B?Zk1HbDhSNUwzR3NDRzNZY2dNbUQ1YUJOUUIrODRzZFJod3hkK1JOWG83R2Ny?=
 =?utf-8?B?T1JQcmVaaXBvRVh0M3BlSXIybFE3Zk15aDhrMk5VUnJMbEkxbm90Yzdqbk11?=
 =?utf-8?B?Mnc0bFI3eHlGNFU0QVlsUWZsKzN4dHZxendhd2RXU3padmF0YWw3TFNYb096?=
 =?utf-8?B?MHowOHlaMFJUblhrVzlCTmtieWkvSU0wMlgrczRIMmJPWVRkUk5UNDhjUEFp?=
 =?utf-8?B?Ym5zT1VybUVHK3Q2MXBIQzRPUlYxYzBCVE5SeG54Wk92OTBrdWcrakphcXYz?=
 =?utf-8?B?MFdKaXI4UHdtU2hFUy9yWVMzWi85YkpZNEUzbFkyNmFSZDhnbWtpMWo4OEsy?=
 =?utf-8?B?VG0vM3pNVWdFQWFYTVg5Mk42Zm05dW82ZGIrMmxocDE5UEp0UjcvN2pjTTAv?=
 =?utf-8?B?QlhNT2Z5VTkzRHQ5dWJpR2YvbGZmVm1ST0hTUmdJNWRjZVJzOUxLY0xWdkgv?=
 =?utf-8?B?cjgyUmhvNktyQzZzUWhrSGJJY3FOdFNqVnlucTFPMSttTXhGa1FibE5YSy8y?=
 =?utf-8?B?TnV0VWFRM2huVWxxbUxjMTlFbmhVcnc5RjlpNFRoVzNuTjQySXRYUEk2UnJZ?=
 =?utf-8?B?K1NvOG1JOE55OVhsck44SUlSNU1nMGZtb3dDLzR6dG1Ec25SdXZqL0FhM1JU?=
 =?utf-8?B?TTYyQVI1ZkdpOVF3VXU0U1I1NlJrQ1hneXJ3bzJpTVcyYXBRN0JCMTBxVzFa?=
 =?utf-8?B?MytzeThqTkw1U0J3WTRzcFlITmI4bCtRZFpXakxUeHlLOTNKRUZwdGlVbWxC?=
 =?utf-8?B?MElOZzM1NkZ6TXZ4UTdieWl3S0JiM0pOUUZ2d1RQdGlwc2E3Vy9NRE9CREor?=
 =?utf-8?B?VU0rVWV6aU5tNWVFRjE4ZnJDTTFtT08rVm85MDNjWDRmYnJITTk0VkpIZVVj?=
 =?utf-8?B?QnpKeFY4K3NiK09Kam5QTVl1UHRNNm9QTHZBaFpwWHl2OUI5ZmE2TzUxSFNk?=
 =?utf-8?B?TStPNUxad1BmTnJPVzFxUHRwRitqMzNrdGY3WFJFbnlGMG1UdlF2OEVSVGto?=
 =?utf-8?B?WlZWaFlFSnNRMFVsQVRua2g1a1hHTGhlTzhoSmVsWGpaZmJDTTdlcTlOVkdi?=
 =?utf-8?B?bmo5STR6MmFxQlB3U3d5Z0tEMlFDU0tnOFprYXVBZzdMdEdzc2JFSlFVK1Jk?=
 =?utf-8?B?N003TVhVclpzR2NYSEFEb2QzTWRDaWNIR0I2aE8wUTg5MWVRVGQ0K2cxdUk2?=
 =?utf-8?B?TkduMWJvNTFLdk5EdXJ0WlE4L2w0WEFud1RFZ3JlczllZzh0dnVkQ1E1Qm5s?=
 =?utf-8?B?MlN3MElJdCtCZGgvNW1aSXRFUk50QVBpZ3VnVmFwWEZza2FNejZSYVlYalZD?=
 =?utf-8?B?S0JSM0tPOUpZZmFSU2Y3aGR6b2x0YWlBa0xBSlRmSGxZN21jSmhESExBZ0Fo?=
 =?utf-8?B?ai9TdEU3MmpMTndUNWRXUm5HS2ErNkJXYytyT0FxeWNtNDhLaGhjZ3h2UFlT?=
 =?utf-8?B?OTRDYWxQMzVsR1BOMzk1OUM1dGo4a2doWVl2ZDBDZGJ3LzJlMlpzZUhaOFFQ?=
 =?utf-8?B?alFFUzAxclI0ZktDQk51V3EyOXhlcHhYcXFlbVdEcHpNanlreFAxRVk2K0o0?=
 =?utf-8?B?WnhwWExOaDA4YmFxRDdYVlU0a1BzYk5sR01BRnhBOVljb2xtUWhSYldWREpW?=
 =?utf-8?B?NjUxWW1DSFlRTEEzNTViMThQQ0hiUWcxTEdFKytySXBqMjFWS0pkN3MyNFBN?=
 =?utf-8?Q?4Nw5XB97PDd3z5x2FqqyctbaS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdef423-aca6-4c52-7492-08dbffbb2f04
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2023 11:19:21.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqzzrKtDxWA2WZcM3miP4+z0un19pEhdw1FvK3hzOxPon1QwVlqCwx6hvXnaeNa41976r9AnrUZkviCt9fVMYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493


On 12/18/2023 4:12 PM, Mika Westerberg wrote:
> On Mon, Dec 18, 2023 at 03:50:26PM +0530, Sanath S wrote:
>> On 12/15/2023 7:32 PM, Mika Westerberg wrote:
>>> On Fri, Dec 15, 2023 at 07:24:07PM +0530, Sanath S wrote:
>>>> On 12/15/2023 5:25 PM, Mika Westerberg wrote:
>>>>> On Thu, Dec 14, 2023 at 09:00:29PM +0530, Sanath S wrote:
>>>>>>> Unfortunately that's not possible because tb_switch_reset() lives in
>>>>>>> switch.s (and should live there) and tb_deactivate_and_free_tunnel() is
>>>>>>> part of tb.c (as should be). This is actually why I would like to try
>>>>>>> the "reset" protocol adapters + their path config spaces in
>>>>>>> tb_switch_reset() as then that would work with any router and does not
>>>>>>> need to have any knowledge about tunnels or tb.c internals.
>>>>>> Ok.
>>>>>> To perform a protocol adapter reset we would require upstream and downstream
>>>>>> adapter ports. So that we can use tb_port_write() set the ADP_PCIE_CS_0.Path
>>>>>> Enable bits.
>>>>>> Challenge here is to get the upstream port without discovering. I'll think
>>>>>> more on this line
>>>>>> if its possible to reset the protocol adapters and its path.
>>>>>>
>>>>>> If you have any reference here or any idea already in mind, let me know, I
>>>>>> can give it a try :)
>>>>> Here is something I had in mind. Only build tested now, and not split
>>>>> into proper patches. This would make it possible to reset any router if
>>>>> we ever need that (not sure if we want to add the TBT2/3 bits now). Let
>>>>> me know if you see problems with this.
>>>>>
>>>>> Feel free to use this code as you like (or ignore completely).
>>>> Thanks Mika for your suggestion.
>>>> It looks good to me and I'll be checking this on Monday.
>>> Okay.
>> Unfortunately this is not working :(
>>>> I have one doubt on protocol adapter reset part which I have mentioned
>>>> below.
>>>>> diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
>>>>> index ec7b5f65804e..31f3da4e6a08 100644
>>>>> --- a/drivers/thunderbolt/domain.c
>>>>> +++ b/drivers/thunderbolt/domain.c
>>>>> @@ -423,6 +423,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
>>>>>     /**
>>>>>      * tb_domain_add() - Add domain to the system
>>>>>      * @tb: Domain to add
>>>>> + * @reset: Issue reset to the host router
>>>>>      *
>>>>>      * Starts the domain and adds it to the system. Hotplugging devices will
>>>>>      * work after this has been returned successfully. In order to remove
>>>>> @@ -431,7 +432,7 @@ struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize
>>>>>      *
>>>>>      * Return: %0 in case of success and negative errno in case of error
>>>>>      */
>>>>> -int tb_domain_add(struct tb *tb)
>>>>> +int tb_domain_add(struct tb *tb, bool reset)
>>>>>     {
>>>>>     	int ret;
>>>>> @@ -460,7 +461,7 @@ int tb_domain_add(struct tb *tb)
>>>>>     	/* Start the domain */
>>>>>     	if (tb->cm_ops->start) {
>>>>> -		ret = tb->cm_ops->start(tb);
>>>>> +		ret = tb->cm_ops->start(tb, reset);
>>>>>     		if (ret)
>>>>>     			goto err_domain_del;
>>>>>     	}
>>>>> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
>>>>> index d8b9c734abd3..623aa81a8833 100644
>>>>> --- a/drivers/thunderbolt/icm.c
>>>>> +++ b/drivers/thunderbolt/icm.c
>>>>> @@ -2144,7 +2144,7 @@ static int icm_runtime_resume(struct tb *tb)
>>>>>     	return 0;
>>>>>     }
>>>>> -static int icm_start(struct tb *tb)
>>>>> +static int icm_start(struct tb *tb, bool not_used)
>>>>>     {
>>>>>     	struct icm *icm = tb_priv(tb);
>>>>>     	int ret;
>>>>> diff --git a/drivers/thunderbolt/lc.c b/drivers/thunderbolt/lc.c
>>>>> index 633970fbe9b0..63cb4b6afb71 100644
>>>>> --- a/drivers/thunderbolt/lc.c
>>>>> +++ b/drivers/thunderbolt/lc.c
>>>>> @@ -6,6 +6,8 @@
>>>>>      * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>>>      */
>>>>> +#include <linux/delay.h>
>>>>> +
>>>>>     #include "tb.h"
>>>>>     /**
>>>>> @@ -45,6 +47,49 @@ static int find_port_lc_cap(struct tb_port *port)
>>>>>     	return sw->cap_lc + start + phys * size;
>>>>>     }
>>>>> +/**
>>>>> + * tb_lc_reset_port() - Trigger downstream port reset through LC
>>>>> + * @port: Port that is reset
>>>>> + *
>>>>> + * Triggers downstream port reset through link controller registers.
>>>>> + * Returns %0 in case of success negative errno otherwise. Only supports
>>>>> + * non-USB4 routers with link controller (that's Thunderbolt 2 and
>>>>> + * Thunderbolt 3).
>>>>> + */
>>>>> +int tb_lc_reset_port(struct tb_port *port)
>>>>> +{
>>>>> +	struct tb_switch *sw = port->sw;
>>>>> +	int cap, ret;
>>>>> +	u32 mode;
>>>>> +
>>>>> +	if (sw->generation < 2)
>>>>> +		return -EINVAL;
>>>>> +
>>>>> +	cap = find_port_lc_cap(port);
>>>>> +	if (cap < 0)
>>>>> +		return cap;
>>>>> +
>>>>> +	ret = tb_sw_read(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	mode |= TB_LC_PORT_MODE_DPR;
>>>>> +
>>>>> +	ret = tb_sw_write(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	fsleep(10000);
>>>>> +
>>>>> +	ret = tb_sw_read(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	mode &= ~TB_LC_PORT_MODE_DPR;
>>>>> +
>>>>> +	return tb_sw_write(sw, &mode, TB_CFG_SWITCH, cap + TB_LC_PORT_MODE, 1);
>>>>> +}
>>>>> +
>>>>>     static int tb_lc_set_port_configured(struct tb_port *port, bool configured)
>>>>>     {
>>>>>     	bool upstream = tb_is_upstream_port(port);
>>>>> diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
>>>>> index fb4f46e51753..b22023fae60d 100644
>>>>> --- a/drivers/thunderbolt/nhi.c
>>>>> +++ b/drivers/thunderbolt/nhi.c
>>>>> @@ -1221,7 +1221,7 @@ static void nhi_check_iommu(struct tb_nhi *nhi)
>>>>>     		str_enabled_disabled(port_ok));
>>>>>     }
>>>>> -static void nhi_reset(struct tb_nhi *nhi)
>>>>> +static bool nhi_reset(struct tb_nhi *nhi)
>>>>>     {
>>>>>     	ktime_t timeout;
>>>>>     	u32 val;
>>>>> @@ -1229,11 +1229,11 @@ static void nhi_reset(struct tb_nhi *nhi)
>>>>>     	val = ioread32(nhi->iobase + REG_CAPS);
>>>>>     	/* Reset only v2 and later routers */
>>>>>     	if (FIELD_GET(REG_CAPS_VERSION_MASK, val) < REG_CAPS_VERSION_2)
>>>>> -		return;
>>>>> +		return false;
>>>>>     	if (!host_reset) {
>>>>>     		dev_dbg(&nhi->pdev->dev, "skipping host router reset\n");
>>>>> -		return;
>>>>> +		return false;
>>>>>     	}
>>>>>     	iowrite32(REG_RESET_HRR, nhi->iobase + REG_RESET);
>>>>> @@ -1244,12 +1244,14 @@ static void nhi_reset(struct tb_nhi *nhi)
>>>>>     		val = ioread32(nhi->iobase + REG_RESET);
>>>>>     		if (!(val & REG_RESET_HRR)) {
>>>>>     			dev_warn(&nhi->pdev->dev, "host router reset successful\n");
>>>>> -			return;
>>>>> +			return true;
>>>>>     		}
>>>>>     		usleep_range(10, 20);
>>>>>     	} while (ktime_before(ktime_get(), timeout));
>>>>>     	dev_warn(&nhi->pdev->dev, "timeout resetting host router\n");
>>>>> +
>>>>> +	return false;
>>>>>     }
>>>>>     static int nhi_init_msi(struct tb_nhi *nhi)
>>>>> @@ -1331,6 +1333,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>>     	struct device *dev = &pdev->dev;
>>>>>     	struct tb_nhi *nhi;
>>>>>     	struct tb *tb;
>>>>> +	bool reset;
>>>>>     	int res;
>>>>>     	if (!nhi_imr_valid(pdev))
>>>>> @@ -1365,7 +1368,11 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>>     	nhi_check_quirks(nhi);
>>>>>     	nhi_check_iommu(nhi);
>>>>> -	nhi_reset(nhi);
>>>>> +	/*
>>>>> +	 * Only USB4 v2 hosts support host reset so if we already did
>>>>> +	 * that then don't do it again when the domain is initialized.
>>>>> +	 */
>>>>> +	reset = nhi_reset(nhi) ? false : host_reset;
>>>>>     	res = nhi_init_msi(nhi);
>>>>>     	if (res)
>>>>> @@ -1392,7 +1399,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>>>     	dev_dbg(dev, "NHI initialized, starting thunderbolt\n");
>>>>> -	res = tb_domain_add(tb);
>>>>> +	res = tb_domain_add(tb, reset);
>>>>>     	if (res) {
>>>>>     		/*
>>>>>     		 * At this point the RX/TX rings might already have been
>>>>> diff --git a/drivers/thunderbolt/path.c b/drivers/thunderbolt/path.c
>>>>> index 091a81bbdbdc..f760e54cd9bd 100644
>>>>> --- a/drivers/thunderbolt/path.c
>>>>> +++ b/drivers/thunderbolt/path.c
>>>>> @@ -446,6 +446,19 @@ static int __tb_path_deactivate_hop(struct tb_port *port, int hop_index,
>>>>>     	return -ETIMEDOUT;
>>>>>     }
>>>>> +/**
>>>>> + * tb_path_deactivate_hop() - Deactivate one path in path config space
>>>>> + * @port: Lane or protocol adapter
>>>>> + * @hop_index: HopID of the path to be cleared
>>>>> + *
>>>>> + * This deactivates or clears a single path config space entry at
>>>>> + * @hop_index. Returns %0 in success and negative errno otherwise.
>>>>> + */
>>>>> +int tb_path_deactivate_hop(struct tb_port *port, int hop_index)
>>>>> +{
>>>>> +	return __tb_path_deactivate_hop(port, hop_index, true);
>>>>> +}
>>>>> +
>>>>>     static void __tb_path_deactivate_hops(struct tb_path *path, int first_hop)
>>>>>     {
>>>>>     	int i, res;
>>>>> diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
>>>>> index 900114ba4371..c4f486629a2b 100644
>>>>> --- a/drivers/thunderbolt/switch.c
>>>>> +++ b/drivers/thunderbolt/switch.c
>>>>> @@ -676,6 +676,13 @@ int tb_port_disable(struct tb_port *port)
>>>>>     	return __tb_port_enable(port, false);
>>>>>     }
>>>>> +static int tb_port_reset(struct tb_port *port)
>>>>> +{
>>>>> +	if (tb_switch_is_usb4(port->sw))
>>>>> +		return usb4_port_reset(port);
>>>>> +	return tb_lc_reset_port(port);
>>>>> +}
>>>>> +
>>>>>     /*
>>>>>      * tb_init_port() - initialize a port
>>>>>      *
>>>>> @@ -1532,20 +1539,64 @@ static void tb_dump_switch(const struct tb *tb, const struct tb_switch *sw)
>>>>>     }
>>>>>     /**
>>>>> - * tb_switch_reset() - reconfigure route, enable and send TB_CFG_PKG_RESET
>>>>> - * @sw: Switch to reset
>>>>> + * tb_switch_reset() - Perform reset to the router
>>>>> + * @sw: Router to reset
>>>>>      *
>>>>> - * Return: Returns 0 on success or an error code on failure.
>>>>> + * Issues reset to the router. Can be used for any router. Returns %0
>>>>> + * on success or an error code on failure.
>>>>>      */
>>>>>     int tb_switch_reset(struct tb_switch *sw)
>>>>>     {
>>>>>     	struct tb_cfg_result res;
>>>>> -	if (sw->generation > 1)
>>>>> -		return 0;
>>>>> +	tb_sw_dbg(sw, "resetting router\n");
>>>>> +
>>>>> +	if (sw->generation > 1) {
>>>>> +		struct tb_port *port;
>>>>> +
>>>>> +		tb_switch_for_each_port(sw, port) {
>>>>> +			int i, ret;
>>>>> +
>>>>> +			/*
>>>>> +			 * For lane adapters we issue downstream port
>>>>> +			 * reset. That clears up also the path config
>>>>> +			 * spaces.
>>>>> +			 *
>>>>> +			 * For protocol adapters we disable the path and
>>>>> +			 * clear path config space one by one (from 8 to
>>>>> +			 * Max Input HopID of the adapter).
>>>>> +			 */
>>>>> +			if (tb_port_is_null(port) && !tb_is_upstream_port(port)) {
>>>>> +				ret = tb_port_reset(port);
>>>>> +				if (ret)
>>>>> +					return ret;
>>>>> +				continue;
>>>> I had thought in similar lines when you told about reset protocol adapters.
>>>>
>>>> But, here we are traversing through all the ports, what if we get to perform
>>>> the DPR first ?
>>>> and then the PCIe, USB and DP reset. This may cause unplug event before we
>>>> tear down
>>>> protocol adapters and its path configuration. (I may be wrong)
>>> Yeah, it could be that it is better first disable protocol adapters and
>>> then do the DPR or so.
>> I gave it a try doing a DPR later and before disabling protocol adapters.
>> Both the methods didn't work.
>>
>> However, when I do it like below, it works.
>>
>>                  tb_switch_discover_tunnels(tb->root_switch,
>>                           &tcm->tunnel_list, false);
>>                  ret = tb_switch_reset(tb->root_switch);
>>
>> We are missing something here.
> The discover part should not do anything (like write the hardware) so
> perhaps it is just some timing thing (but that's weird too).
>
> I think we should do something like this:
>
> 1. Disable all enabled protocol adapters (reset them to defaults).
> 2. Clear all protocol adapter paths.
> 3. Issue DPR over all enabled USB4 ports.
>
> BTW, what you mean "didn't work"?
Path activation would go fine after DPR like below:

[   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
[   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 
0:5 to 2:9
[   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 
2:9 to 0:5

But, PCIE enumeration doesn't happen (pcie link up will not happen, will 
not see below logs)
[   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
[   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up

>>>> I'll check the behavior on Monday and update.
>>>>
>>>> Assuming this works, I can incorporate the suggestion and send out v3 with
>>>> appropriate tags ? It can be split into 3 patches.
>>> Sure.
>>>
>>> Bonus points if you can drop some more lines from that :)
>>>
>>>>> +			} else if (tb_port_is_usb3_down(port) ||
>>>>> +				   tb_port_is_usb3_up(port)) {
>>>>> +				tb_usb3_port_enable(port, false);
>>>>> +			} else if (tb_port_is_dpin(port) ||
>>>>> +				   tb_port_is_dpout(port)) {
>>>>> +				tb_dp_port_enable(port, false);
>>>>> +			} else if (tb_port_is_pcie_down(port) ||
>>>>> +				   tb_port_is_pcie_up(port)) {
>>>>> +				tb_pci_port_enable(port, false);
>> Here, as per spec it would be better if we first teardown it for DOWN path
>> and then the UP
>> path.
> Right makes sense.
We never get up_port of protocol adapters here for reset. It's always 
down_port.
So probably when we discover the path, we do path deactivation for both 
down and up ports.
>>>>> +			} else {
>>>>> +				continue;
>>>>> +			}
>>>>> -	tb_sw_dbg(sw, "resetting switch\n");
>>>>> +			/* Cleanup path config space of protocol adapter */
>>>>> +			for (i = TB_PATH_MIN_HOPID;
>>>>> +			     i <= port->config.max_in_hop_id; i++) {
>>>>> +				ret = tb_path_deactivate_hop(port, i);
>>>>> +				if (ret)
>>>>> +					return ret;
>>>>> +			}
>>>>> +		}
>>>>> +
>>>>> +		return 0;
>>>>> +	}
>>>>> +	/* Thunderbolt 1 uses the "reset" config space packet */
>>>>>     	res.err = tb_sw_write(sw, ((u32 *) &sw->config) + 2,
>>>>>     			      TB_CFG_SWITCH, 2, 2);
>>>>>     	if (res.err)
>>>>> diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
>>>>> index 8bc3985df749..5e5e3aebe018 100644
>>>>> --- a/drivers/thunderbolt/tb.c
>>>>> +++ b/drivers/thunderbolt/tb.c
>>>>> @@ -2590,7 +2590,7 @@ static int tb_scan_finalize_switch(struct device *dev, void *data)
>>>>>     	return 0;
>>>>>     }
>>>>> -static int tb_start(struct tb *tb)
>>>>> +static int tb_start(struct tb *tb, bool reset)
>>>>>     {
>>>>>     	struct tb_cm *tcm = tb_priv(tb);
>>>>>     	int ret;
>>>>> @@ -2631,12 +2631,22 @@ static int tb_start(struct tb *tb)
>>>>>     	tb_switch_tmu_configure(tb->root_switch, TB_SWITCH_TMU_MODE_LOWRES);
>>>>>     	/* Enable TMU if it is off */
>>>>>     	tb_switch_tmu_enable(tb->root_switch);
>>>>> -	/* Full scan to discover devices added before the driver was loaded. */
>>>>> -	tb_scan_switch(tb->root_switch);
>>>>> -	/* Find out tunnels created by the boot firmware */
>>>>> -	tb_discover_tunnels(tb);
>>>>> -	/* Add DP resources from the DP tunnels created by the boot firmware */
>>>>> -	tb_discover_dp_resources(tb);
>>>>> +
>>>>> +	if (reset && usb4_switch_version(tb->root_switch) == 1) {
>>>>> +		ret = tb_switch_reset(tb->root_switch);
>>>>> +		if (ret) {
>>>>> +			tb_sw_warn(tb->root_switch, "failed to reset\n");
>>>>> +			return ret;
>>>>> +		}
>>>>> +	
>>>> Ok. So idea is to drop reset for <= TBT3 currently.
>>> Yes, there are some older Apple systems that "benefit" from the
>>> discovery so I would keep it there for them.
>>>
>>>>> } else {
>>>>> +		/* Full scan to discover devices added before the driver was loaded. */
>>>>> +		tb_scan_switch(tb->root_switch);
>>>>> +		/* Find out tunnels created by the boot firmware */
>>>>> +		tb_discover_tunnels(tb);
>>>>> +		/* Add DP resources from the DP tunnels created by the boot firmware */
>>>>> +		tb_discover_dp_resources(tb);
>>>>> +	}
>>>>> +
>>>>>     	/*
>>>>>     	 * If the boot firmware did not create USB 3.x tunnels create them
>>>>>     	 * now for the whole topology.
>>>>> @@ -2702,7 +2712,7 @@ static int tb_resume_noirq(struct tb *tb)
>>>>>     {
>>>>>     	struct tb_cm *tcm = tb_priv(tb);
>>>>>     	struct tb_tunnel *tunnel, *n;
>>>>> -	unsigned int usb3_delay = 0;
>>>>> +	unsigned int usb3_delay;
>>>>>     	LIST_HEAD(tunnels);
>>>>>     	tb_dbg(tb, "resuming...\n");
>>>>> @@ -2715,19 +2725,7 @@ static int tb_resume_noirq(struct tb *tb)
>>>>>     	tb_free_unplugged_children(tb->root_switch);
>>>>>     	tb_restore_children(tb->root_switch);
>>>>> -	/*
>>>>> -	 * If we get here from suspend to disk the boot firmware or the
>>>>> -	 * restore kernel might have created tunnels of its own. Since
>>>>> -	 * we cannot be sure they are usable for us we find and tear
>>>>> -	 * them down.
>>>>> -	 */
>>>>> -	tb_switch_discover_tunnels(tb->root_switch, &tunnels, false);
>>>>> -	list_for_each_entry_safe_reverse(tunnel, n, &tunnels, list) {
>>>>> -		if (tb_tunnel_is_usb3(tunnel))
>>>>> -			usb3_delay = 500;
>>>>> -		tb_tunnel_deactivate(tunnel);
>>>>> -		tb_tunnel_free(tunnel);
>>>>> -	}
>>>>> +	usb3_delay = tb_switch_is_usb4(tb->root_switch) ? 500 : 0;
>>>>>     	/* Re-create our tunnels now */
>>>>>     	list_for_each_entry_safe(tunnel, n, &tcm->tunnel_list, list) {
>>>>> diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
>>>>> index 7ad55f5966f3..2bc8eca965ed 100644
>>>>> --- a/drivers/thunderbolt/tb.h
>>>>> +++ b/drivers/thunderbolt/tb.h
>>>>> @@ -489,7 +489,7 @@ struct tb_path {
>>>>>      */
>>>>>     struct tb_cm_ops {
>>>>>     	int (*driver_ready)(struct tb *tb);
>>>>> -	int (*start)(struct tb *tb);
>>>>> +	int (*start)(struct tb *tb, bool reset);
>>>>>     	void (*stop)(struct tb *tb);
>>>>>     	int (*suspend_noirq)(struct tb *tb);
>>>>>     	int (*resume_noirq)(struct tb *tb);
>>>>> @@ -752,7 +752,7 @@ int tb_xdomain_init(void);
>>>>>     void tb_xdomain_exit(void);
>>>>>     struct tb *tb_domain_alloc(struct tb_nhi *nhi, int timeout_msec, size_t privsize);
>>>>> -int tb_domain_add(struct tb *tb);
>>>>> +int tb_domain_add(struct tb *tb, bool reset);
>>>>>     void tb_domain_remove(struct tb *tb);
>>>>>     int tb_domain_suspend_noirq(struct tb *tb);
>>>>>     int tb_domain_resume_noirq(struct tb *tb);
>>>>> @@ -1156,6 +1156,7 @@ struct tb_path *tb_path_alloc(struct tb *tb, struct tb_port *src, int src_hopid,
>>>>>     void tb_path_free(struct tb_path *path);
>>>>>     int tb_path_activate(struct tb_path *path);
>>>>>     void tb_path_deactivate(struct tb_path *path);
>>>>> +int tb_path_deactivate_hop(struct tb_port *port, int hop_index);
>>>>>     bool tb_path_is_invalid(struct tb_path *path);
>>>>>     bool tb_path_port_on_path(const struct tb_path *path,
>>>>>     			  const struct tb_port *port);
>>>>> @@ -1175,6 +1176,7 @@ int tb_drom_read(struct tb_switch *sw);
>>>>>     int tb_drom_read_uid_only(struct tb_switch *sw, u64 *uid);
>>>>>     int tb_lc_read_uuid(struct tb_switch *sw, u32 *uuid);
>>>>> +int tb_lc_reset_port(struct tb_port *port);
>>>>>     int tb_lc_configure_port(struct tb_port *port);
>>>>>     void tb_lc_unconfigure_port(struct tb_port *port);
>>>>>     int tb_lc_configure_xdomain(struct tb_port *port);
>>>>> @@ -1307,6 +1309,7 @@ void usb4_switch_remove_ports(struct tb_switch *sw);
>>>>>     int usb4_port_unlock(struct tb_port *port);
>>>>>     int usb4_port_hotplug_enable(struct tb_port *port);
>>>>> +int usb4_port_reset(struct tb_port *port);
>>>>>     int usb4_port_configure(struct tb_port *port);
>>>>>     void usb4_port_unconfigure(struct tb_port *port);
>>>>>     int usb4_port_configure_xdomain(struct tb_port *port, struct tb_xdomain *xd);
>>>>> diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
>>>>> index 87e4795275fe..efcae298b370 100644
>>>>> --- a/drivers/thunderbolt/tb_regs.h
>>>>> +++ b/drivers/thunderbolt/tb_regs.h
>>>>> @@ -389,6 +389,7 @@ struct tb_regs_port_header {
>>>>>     #define PORT_CS_18_CSA				BIT(22)
>>>>>     #define PORT_CS_18_TIP				BIT(24)
>>>>>     #define PORT_CS_19				0x13
>>>>> +#define PORT_CS_19_DPR				BIT(0)
>>>>>     #define PORT_CS_19_PC				BIT(3)
>>>>>     #define PORT_CS_19_PID				BIT(4)
>>>>>     #define PORT_CS_19_WOC				BIT(16)
>>>>> @@ -584,6 +585,9 @@ struct tb_regs_hop {
>>>>>     #define TB_LC_POWER				0x740
>>>>>     /* Link controller registers */
>>>>> +#define TB_LC_PORT_MODE				0x26
>>>>> +#define TB_LC_PORT_MODE_DPR			BIT(0)
>>>>> +
>>>>>     #define TB_LC_CS_42				0x2a
>>>>>     #define TB_LC_CS_42_USB_PLUGGED			BIT(31)
>>>>> diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
>>>>> index 675d1ed62372..9e002bf73d2e 100644
>>>>> --- a/drivers/thunderbolt/usb4.c
>>>>> +++ b/drivers/thunderbolt/usb4.c
>>>>> @@ -1107,6 +1107,45 @@ int usb4_port_hotplug_enable(struct tb_port *port)
>>>>>     	return tb_port_write(port, &val, TB_CFG_PORT, ADP_CS_5, 1);
>>>>>     }
>>>>> +/**
>>>>> + * usb4_port_reset() - Issue downstream port reset
>>>>> + * @port: USB4 port to reset
>>>>> + *
>>>>> + * Issues downstream port reset to @port.
>>>>> + */
>>>>> +int usb4_port_reset(struct tb_port *port)
>>>>> +{
>>>>> +	int ret;
>>>>> +	u32 val;
>>>>> +
>>>>> +	if (!port->cap_usb4)
>>>>> +		return -EINVAL;
>>>>> +
>> We've to drop this check here and check it before calling for that port.
>> Otherwise, I it may throw -EINVAL and results in probe failure.
> Agree.
>
>>>>> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
>>>>> +			   port->cap_usb4 + PORT_CS_19, 1);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	val |= PORT_CS_19_DPR;
>>>>> +
>>>>> +	ret = tb_port_write(port, &val, TB_CFG_PORT,
>>>>> +			    port->cap_usb4 + PORT_CS_19, 1);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	fsleep(10000);
>>>>> +
>>>>> +	ret = tb_port_read(port, &val, TB_CFG_PORT,
>>>>> +			   port->cap_usb4 + PORT_CS_19, 1);
>>>>> +	if (ret)
>>>>> +		return ret;
>>>>> +
>>>>> +	val &= ~PORT_CS_19_DPR;
>>>>> +
>>>>> +	return tb_port_write(port, &val, TB_CFG_PORT,
>>>>> +			     port->cap_usb4 + PORT_CS_19, 1);
>>>>> +}
>>>>> +
>>>>>     static int usb4_port_set_configured(struct tb_port *port, bool configured)
>>>>>     {
>>>>>     	int ret;
>>>>>
>>>>>

