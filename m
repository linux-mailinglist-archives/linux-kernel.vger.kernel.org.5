Return-Path: <linux-kernel+bounces-5391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A31818A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDBE28BC5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941E1C293;
	Tue, 19 Dec 2023 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXq1THF9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE89225D1;
	Tue, 19 Dec 2023 14:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8V1vsCsL0Vof2siP3ib98aT4yBHpjPLl+rpRn/0Rn2MH+xvUIsWaOSkIZ00lnCFnIGWybCdRE27/xYPjEtm5gN9Q7C9bub4qqmyTmHrjGA4aav5NCRPYGL1Cds2/QFwfMhQf8+gl6JsvqnFtpQgRqbfPr72gzYzBroO1luDdEpfKcvor9KeT1BI143bu+9f2/i7h49Gnl1jEsvTRGLJo4LSHOG62MlF/QO0pme5tE7sgjUHziwbBWYTA21pEmSPtLdfSx0FtjCwwh7J+gESZJmfUuMibfOlQyxDZ+RiwVOvJMFhu0fzHdAXtUwNItyjFas5w6w85Pi9u3WHMozS7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTwczpdXpulRvCcejC7EdJT2B75XkRFzkxZS038HkMk=;
 b=fxpzXxPxnXmZh/p7zgZamqm8ItTYCMNR/2vzrcTA6Rk0b6PU8aCsxZxzvji5t1+mc37ZJHJVUxvwns082c86J7xP+tub/c4nmsGof7PXJVTIhOPFk4Id1Yhgyv+KeG+p0JvQDFcP3qef4ZLGyv+ySVv2bbgWkWvCfx8C/poTSSPQ4y9mU2O3Ow9lIZUiZw7QqMpvt7mlnMvqnwY4ANl8a4EVQIy79SzQfxZZufIGCLNT/UxTe6Gc+m0x+ADWtZCcrvqVAOcIU7bHiBjhdG4j+zO0pL88/PEhlGFe4e9FdEC/6AJQNybKtdF1l7hDi+EQojAbmM4JnlxXxS4qFsrUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTwczpdXpulRvCcejC7EdJT2B75XkRFzkxZS038HkMk=;
 b=wXq1THF9ZF+1MwaurqP12K6byPl2ZG/M7Zmzu0QQjkIAt464MHskkHXXYWwUBhnVx5z5eoLjOvuTc9pvg3B0EVueth7HoORcLBVGNZ5SOE9fQ45H/6/KHQnJ/fZCH4QSep20Og+yzLwvtYshcN0CXj2zMRsu0ham3rYKvgIFWvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14)
 by DM4PR12MB6349.namprd12.prod.outlook.com (2603:10b6:8:a4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.18; Tue, 19 Dec 2023 14:35:23 +0000
Received: from MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c]) by MW4PR12MB7016.namprd12.prod.outlook.com
 ([fe80::1f1b:e85b:abf0:3d3c%6]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 14:35:23 +0000
Message-ID: <0816caa4-81b5-d0f9-2305-80c7fec6abb9@amd.com>
Date: Tue, 19 Dec 2023 20:05:15 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Patch v2 2/2] thunderbolt: Teardown tunnels and reset downstream
 ports created by boot firmware
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Sanath S <Sanath.S@amd.com>, mario.limonciello@amd.com,
 andreas.noever@gmail.com, michael.jamet@intel.com, YehezkelShB@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <c7d174d3-028f-9ce4-7ef5-3e033c195159@amd.com>
 <20231215140224.GX1074920@black.fi.intel.com>
 <866cb714-b9a8-a7d4-4c59-6ba771ef325f@amd.com>
 <20231218104234.GB1074920@black.fi.intel.com>
 <c433f29b-597c-b6d6-aa48-2b84a26dc623@amd.com>
 <20231218113151.GC1074920@black.fi.intel.com>
 <20231218122312.GE1074920@black.fi.intel.com>
 <997f2a94-66d9-fb95-8f75-46d61937f7e8@amd.com>
 <20231218131840.GH1074920@black.fi.intel.com>
 <0fd5c09f-1cf2-8813-a8f9-1bd856e3a298@amd.com>
 <20231219122634.GJ1074920@black.fi.intel.com>
Content-Language: en-US
From: Sanath S <sanaths2@amd.com>
In-Reply-To: <20231219122634.GJ1074920@black.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0036.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::15) To MW4PR12MB7016.namprd12.prod.outlook.com
 (2603:10b6:303:218::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB7016:EE_|DM4PR12MB6349:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c476b1b-416a-4530-f7a9-08dc009fbbf0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/IzBEyfq6K/iaJF5RxydyArrPq36dJ3ZvAvFAUorXJAifkVEnUr7DUXwBcjGA1F4FG/FOJqzeN+n4m3vi9658jxfexEMH3vZJCVWvN4L5bZBv6BemwxvvN3x3VL1rC7+9E0wvFoNFGxs76n4DTv0ig2MATUZPrnamHyXspmDFVVW+4/2yxDtA3j9LnsTmeEErtdA1gNtsfzaYquhnVJQs2pVqLL44Lg3gkManLSohmNmidVDqPkRf/uN6ZGFO49GcQ94r/p5W2VAe0B0y8ngV5IViZLJo/v6QD5nzMnbL5YmpXyHjZpqwq3MRKNyNh6Goj11qFmtWOOnwoGYpPXYQ+iDGNr3RVmgfrCP0bjOLsLrWyn0iWsSZKijCnmyYja8z5+qwXjP4v9q6EeFAMA5P/fge/woBBSakULfipS0sY/OyOobdnZfmiwwB9boW2vIkoawfh2F3goX/2YPbp0/9hf7WK5N4giU99JvOk6IkADIwqaGkOVAPRSCW+L+PUCPa6Ku50EBVwMsXbSvApHB7D+pVFSB8cXF6rxYlwewL6oEuUUcWOV4Tqd+BpmSTJA8B5ZULsy17s1jsPBERKZHQz3g79z4CEV+vPQqwAbPvN+2BGUU9cBa3VJi9F/Nj/hkmjl1o5nFZenIeBqUC+utPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR12MB7016.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(26005)(83380400001)(2616005)(36756003)(31696002)(31686004)(53546011)(6512007)(478600001)(6506007)(6666004)(6916009)(316002)(66946007)(66556008)(66476007)(4326008)(8676002)(8936002)(2906002)(5660300002)(6486002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dytqUUNEVi94MXJ6RVZHZFEvQzg2b2tja1plY1gxS3lKQXJOTjc0ZllvUCtU?=
 =?utf-8?B?Z1kxM3VUZ1pVNFcwMEJPb3VRQ0J2UGZjcVBmcjdzM0lERWxVUlY3U3lmNzBq?=
 =?utf-8?B?MzRKRE5aVGJWREFjSlAwVHhZckt2YWs5QU1HYzljY2lvMDE3NmVKWGFSb0xz?=
 =?utf-8?B?b2lyUVo3NWhUSDZHdE04YjVSZUtSUUk3Q0hRVVhIZXZOTXlPcUtGQ3IvMEdX?=
 =?utf-8?B?RCsveW1TeGpENTg5MjBJTWt2S3pXRlFIVzR3V2hqMisrTzJnc0dyRVVaNnZI?=
 =?utf-8?B?d3lnQUltNTJOd3JDRkFDK0IvemtNMnVSWjZwaER2cFNaM2ljZFAyZm40UkEy?=
 =?utf-8?B?YWFCMlVrSHY1U2U4dUZZMjFYaWRBTEtCUkdqVmFDZ21tNEU4TkdyenJhOFpj?=
 =?utf-8?B?Ymd0c1IvaEdSdEZmeHBmbjdRU1hITUJBNFlVS3pTdFllUW5ydHdubVhVcW1h?=
 =?utf-8?B?emVrMTl4S3IrSlYwd0o3VlFQbms3Y1dsYytyT1RFNVlyaGwzSzFxUDcvU21R?=
 =?utf-8?B?WTlBNnQ3NXIycXFJVW1NaHdaa0kxc1BwblJZOXM4c09lMlN4Vzh6d1hBUlRY?=
 =?utf-8?B?RjFpaUVUWmpLMWdGUXBhTkQ5UTF5VlZlSmZraUQ5K2ZlL3AxU1dibGl6aXhO?=
 =?utf-8?B?OHkrSW5veDNGSFcxSi84dHV3MDBkV1JrRTkrQnZnYkJyM2ZleUtYbXl5V2du?=
 =?utf-8?B?aDN4M3ZGRnpnNTNYczd5ekkwOHRWVGZiN2RWK2pER1lOTFlpbzIyamhBcTJR?=
 =?utf-8?B?RGhvZW51UCtuaTl5U3owUnhpeEJnMEFIRlBvcGR1d3JJUnRqM1lPbWpkbFRt?=
 =?utf-8?B?SzZkRVlac01rUkNJUFBjMWFFSmdzQmNuZXZSeWx4TUQ4cHBBQTZSYVlaM2Jo?=
 =?utf-8?B?Q0ZEckpJaEJZd1B4dkdnTS9IcjYyRytIREtYcXRQQmRmeEhuUjFMdDBQR3VC?=
 =?utf-8?B?aVFveUVqc25DTkZnY2U4QjIxdlY5bU5yTTBOTUZhb2g0bUUvcXVFTFFhaFhO?=
 =?utf-8?B?REUyQmFKVTBVbHFJNjB3ZUd1VnY5TVhMMUNVYUhRVjFmcTNhbHY4Ylhxempx?=
 =?utf-8?B?SGMydTZ2b25lRXRWcDcvUSs4QWpHT0RwVDczOGpVRFlCbnBaR29GLzJiMFNi?=
 =?utf-8?B?M21SV0o3amJHYXl5QWRrcEd2eHdlU2l3byt6ZWdIaFVmeVdWVnFBbW05Uk8r?=
 =?utf-8?B?UlY0U1RXUm11MlFqUnRNUDRZZDFWT0lPaHRXN1Q0aTd4RXFrTWlqMHo3T05w?=
 =?utf-8?B?bmRTZUp5aEE2aHQxT2wzOW9FSEV0cW15UzlueUFRRUpaNHoyZFNjWHZJbFBy?=
 =?utf-8?B?Qi9KRm9mRExLY2ZsUkt3ajZxMFcxQTdCQ1AwcmEvekNLL1dJMFQzc3BQbk54?=
 =?utf-8?B?T0ZvY1JGTXNYY05TcnNYTUdld1NzUGQ5MmFDQllENDFwMDMvbUNlMkRCY2I5?=
 =?utf-8?B?Snc4RTlwNjdSanc0MXpCaXpTWVU0L3E4QlJXY0JLUjVqV3U1VDkzNEpzWDF3?=
 =?utf-8?B?QU9IR25qRUpFSFg1TDVIQkNoWnplUm1qUDh4YW5UZ28wS0xSRWxBcU5iVUd1?=
 =?utf-8?B?bm5Idkg1aVRCcW5YNUFCaWVUV1E2Qzg4NVBhbktRaXFzYWQ3Q09WN2RXZ2JH?=
 =?utf-8?B?K1BZRmVaRDlXWGxLV1lISWlLN05jbjNMMitkeWZ5UXJKS0s1ZWZZOE03WW9D?=
 =?utf-8?B?TjJxUVAvU3hrWlg4cTg2a2o3WExid3pMenB1RkJvUzlNcUF5RGFkMDlMTVJN?=
 =?utf-8?B?bSsvNFByUW1DVmYrZHZTYUpjM1d2aDZqQlBUNXpTR2dGdVJ2dzNoRTlrV2Zn?=
 =?utf-8?B?QjVmWGNpVWFjVGFiM3greWJjR09xU283c3hVNC9sUWtTYmY5QnpkTFRzQTQ3?=
 =?utf-8?B?TkN4MTNoM3BpVEJQVC9jZTZNMzl2S1grSHl2b3Zha3A5ZUd6Y2RYMkY1NDZh?=
 =?utf-8?B?MWlrQ3diRFRwdEZvQUhkYTZKeDNvNTV4ejRkN25hWTlkYUdOWElGOE9CdmNh?=
 =?utf-8?B?cW4rNUJ1akdic1FnMUhvOHpPUDVWSFZNLzVXeVQvQ1dqZXNEWkdqLzFIWFRH?=
 =?utf-8?B?ZnhjSGVwbnVIWkcrUzdXcEw0Nmx0dW9BbVJldEVGRENWMzBhZ2dVZjJTNlJZ?=
 =?utf-8?Q?bWITAU/nCw2QYcB/LV+Og2CnN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c476b1b-416a-4530-f7a9-08dc009fbbf0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB7016.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 14:35:23.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4Q//XVqmIra8ZMKjCMbeg0MOg/NB/qeBAXkooFbij4HpVDqrNynclttlwyHkGE763L8+XP/ulbz+9mrsUFn1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6349


On 12/19/2023 5:56 PM, Mika Westerberg wrote:
> On Tue, Dec 19, 2023 at 02:41:08PM +0530, Sanath S wrote:
>> On 12/18/2023 6:48 PM, Mika Westerberg wrote:
>>> On Mon, Dec 18, 2023 at 06:35:13PM +0530, Sanath S wrote:
>>>> On 12/18/2023 5:53 PM, Mika Westerberg wrote:
>>>>> On Mon, Dec 18, 2023 at 01:31:51PM +0200, Mika Westerberg wrote:
>>>>>> On Mon, Dec 18, 2023 at 04:49:13PM +0530, Sanath S wrote:
>>>>>>>> The discover part should not do anything (like write the hardware) so
>>>>>>>> perhaps it is just some timing thing (but that's weird too).
>>>>>>>>
>>>>>>>> I think we should do something like this:
>>>>>>>>
>>>>>>>> 1. Disable all enabled protocol adapters (reset them to defaults).
>>>>>>>> 2. Clear all protocol adapter paths.
>>>>>>>> 3. Issue DPR over all enabled USB4 ports.
>>>>>>>>
>>>>>>>> BTW, what you mean "didn't work"?
>>>>>>> Path activation would go fine after DPR like below:
>>>>>>>
>>>>>>> [   15.090905] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): activating
>>>>>>> [   15.090932] thunderbolt 0000:c4:00.5: activating PCIe Down path from 0:5
>>>>>>> to 2:9
>>>>>>> [   15.091602] thunderbolt 0000:c4:00.5: activating PCIe Up path from 2:9 to
>>>>>>> 0:5
>>>>>>>
>>>>>>> But, PCIE enumeration doesn't happen (pcie link up will not happen, will not
>>>>>>> see below logs)
>>>>>>> [   15.134223] pcieport 0000:00:03.1: pciehp: Slot(0-1): Card present
>>>>>>> [   15.134243] pcieport 0000:00:03.1: pciehp: Slot(0-1): Link Up
>>>>>> Okay, what if you like reset the PCIe adapter config spaces back to the
>>>>>> defaults? Just as an experiment.
>>>>> If this turns out to be really complex then I guess it is better to do
>>>>> it like you did originally using discovery but at least it would be nice
>>>>> to see what the end result of this experiment looks like :)
>> I feel it's better to go with discover and then reset for now (as v3).
>> I'll keep this experiment as "to do" and will send out when I crack it down.
> Fair enough.
>
>>>> Yes, I'll give a try.
>>>> As an experiment, I tried to compare the path deactivation that occurs at
>>>> two place.
>>>> 1. In tb_switch_reset where we are calling tb_path_deactivate_hop(port, i).
>>>> 2. While we get a unplug event after doing DPR.
>>>>
>>>> I observed both have different hop_index and port numbers.
>>>> So, are we calling tb_path_deactivate_hop with wrong hop ids ?
>>> Wrong adapters possibly.
>>>
>>>>   From deactivate tunnel (called while unplug) :
>>>> [    3.408268] thunderbolt 0000:c4:00.5: deactivating PCIe Down path from
>>>> 2:9 to 0:5
>>>> [    3.408282] deactivate hop port = 9 hop_index=8
>>>> [    3.408328] deactivate hop port = 2 hop_index=10
>>> Definitely should be port = 5 (that's PCIe down in your log) and
>>> hop_index = 8 (that's the one used with PCIe).
>>>
>>>> Deactivate from tb_switch_reset() :
>>>> deactivate hop port = 5 hop_index=8
>>> Can you add some more logging and provide me the dmesg or
>>> alternativively investigate it yourself. You can use tb_port_dbg() to
>>> get the port numbers to the log.
>> I've sent you complete dmesg.
> Got it, thanks!
>
>> Here is the log w.r.t port numbers and path clean up.
>>
>> [    3.389038] thunderbolt 0000:c4:00.5: 0:3: Downstream port, setting DPR
>> [    3.389065] Calling usb4_port_reset
>> [    3.389068] thunderbolt 0000:c4:00.5: 0:4: Found USB3 DOWN
>> [    3.389193] thunderbolt 0000:c4:00.5: 0:4: In reset, cleaning up path,
>> port->port = 4 hopid = 8
>> [    3.389203] thunderbolt 0000:c4:00.5: 0:4: deactivating_hop port = 4
>> hop_index=8
>> [    3.389682] thunderbolt 0000:c4:00.5: 0:5: Found PCI Down
>> [    3.389811] thunderbolt 0000:c4:00.5: 0:5: In reset, cleaning up path,
>> port->port = 5 hopid = 8
>> [    3.389817] thunderbolt 0000:c4:00.5: 0:5: deactivating_hop port = 5
>> hop_index=8
>> [    3.390296] thunderbolt 0000:c4:00.5: 0:6: Found DP IN
>> [    3.390555] thunderbolt 0000:c4:00.5: 0:6: In reset, cleaning up path,
>> port->port = 6 hopid = 8
>> [    3.390558] thunderbolt 0000:c4:00.5: 0:6: deactivating_hop port = 6
>> hop_index=8
>> [    3.390686] thunderbolt 0000:c4:00.5: 0:6: In reset, cleaning up path,
>> port->port = 6 hopid = 9
>> [    3.390689] thunderbolt 0000:c4:00.5: 0:6: deactivating_hop port = 6
>> hop_index=9
>> [    3.390816] thunderbolt 0000:c4:00.5: 0:7: Found DP IN
>> [    3.391077] thunderbolt 0000:c4:00.5: 0:7: In reset, cleaning up path,
>> port->port = 7 hopid = 8
>> [    3.391080] thunderbolt 0000:c4:00.5: 0:7: deactivating_hop port = 7
>> hop_index=8
>> [    3.391213] thunderbolt 0000:c4:00.5: 0:7: In reset, cleaning up path,
>> port->port = 7 hopid = 9
>> [    3.391217] thunderbolt 0000:c4:00.5: 0:7: deactivating_hop port = 7
>> hop_index=9
>> [    3.391342] Reset success
>> [    3.391391] thunderbolt 0000:c4:00.5: 0:2: switch unplugged
>> [    3.391434] thunderbolt 0000:c4:00.5: 0:4 <-> 2:16 (USB3): deactivating
>> [    3.391471] thunderbolt 0000:c4:00.5: deactivating USB3 Down path from
>> 0:4 to 2:16
>> [    3.391477] thunderbolt 0000:c4:00.5: 0:4: deactivating_hop port = 4
>> hop_index=8
>> [    3.391641] thunderbolt 0000:c4:00.5: 2:1: deactivating_hop port = 1
>> hop_index=9
>> [    3.391651] thunderbolt 0000:c4:00.5: deactivating USB3 Up path from 2:16
>> to 0:4
>> [    3.391659] thunderbolt 0000:c4:00.5: 2:16: deactivating_hop port = 16
>> hop_index=8
>> [    3.391664] thunderbolt 0000:c4:00.5: 0:2: deactivating_hop port = 2
>> hop_index=9
>> [    3.391701] thunderbolt 0000:c4:00.6: total paths: 3
>> [    3.391720] thunderbolt 0000:c4:00.6: IOMMU DMA protection is disabled
>> [    3.392027] thunderbolt 0000:c4:00.5: 0:5 <-> 2:9 (PCI): deactivating
>> [    3.392154] thunderbolt 0000:c4:00.5: deactivating PCIe Down path from
>> 2:9 to 0:5
>> [    3.392163] thunderbolt 0000:c4:00.5: 2:9: deactivating_hop port = 9
>> hop_index=8
>> [    3.392170] thunderbolt 0000:c4:00.5: 0:2: deactivating_hop port = 2
>> hop_index=10
>> [    3.392534] thunderbolt 0000:c4:00.5: deactivating PCIe Up path from 0:5
>> to 2:9
>> [    3.392539] thunderbolt 0000:c4:00.5: 0:5: deactivating_hop port = 5
>> hop_index=8
>> [    3.392637] thunderbolt 0000:c4:00.5: 2:1: deactivating_hop port = 1
>> hop_index=10
>> [    3.392799] thunderbolt 0-2: device disconnected
>>
>> But it seems like we are not cleaning up all the paths ?
> To me this looks correct and even your dmesg the PCIe tunnel that gets
> established after the "reset" seems to be working just fine. I also see
> that in your log you are doing the discovery before reset even though
> the original idea was to avoid it.
I did this as an experiment to collect logs and check if we are 
resetting the same
path config. Just to get a comparison view.
>
> In any case this was a good experiment. I will see if I can get this
> working on my side if I have some spare time during holidays.
Sure. I'll keep trying too.
> I guess we can to with the discovery but taking into account the
> "host_reset".
Yes, along with changes in lc.c for <= TBT3
> One additional question though, say we have PCIe tunnel established by
> the BIOS CM and we do the "reset", that means there will be hot-remove
> on the PCIe side and then hotplug again, does this slow down the boot
> considerably? We have some delays there in the PCIe code that might hit
> us here although I agree that we definitely prefer working system rather
> than fast-booting non-working system but perhaps the delays are not
> noticeable by the end-user?
I've not observed any delay which is noticeable. As soon as I get the 
login screen
and check dmesg, it would already be enumerated.

And moreover, this scenario is applicable only when dock stays connected 
during reboot or S5.

