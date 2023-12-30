Return-Path: <linux-kernel+bounces-13313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B867C820361
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB241C219BD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CC615B7;
	Sat, 30 Dec 2023 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WyvmXJh3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CD36FDC;
	Sat, 30 Dec 2023 02:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ8dagFEt1O4y/759UKXgdyFBXD8gfMkfd3uHJRDqG12hp2DGxZUOqgwpwTgkyYp7maDyYLmuZVBgcjSyeTEB/EQ+IB60hk+1lQEK4vecxO3Affqos4X+jOfx9cdtT0DqgU1BJpvN4QOO5AeLPm+FiTnOvPblgnOIgev1Y5hop26vkn31sYKwm56I5GqV6lzLOYYMP9DGY4kBSiIO6GOhGH4QL06HZN7XqNKCIxelRRlKiwKbOpl280lzPM3AvC7tjNznM07U8Hi5AqTv1ZTEYwPYdrJa1k6cRi8hTmvbua6GRGaq74szo+U832FLrW2/8fjSiz3wZtEh6vxqttXQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D595nzjudaLW97KGdFVDduWshEsWpZ3q09JznCQkrrU=;
 b=FJXgCRKOrQ6A2wWs5Th8MrobBvxcnvNghhKpCu9HVpsTYvLaqdVgjIsGa50JAlSKmhEZrW41R85O6oO8rrIDJYyjDfJnxVvscnXg9P/rwVdvKOAJD7cTPD5uSU2KoVvzC6//avVfXdrnao+lm9Ke676KYewlCdmwr4sOQ8qsNs6Kcbs5QIZ6HBgFbARCnTDa1DYkL7vFzGuXQwUI41DfqXld1yo6AJre15ptOPq9hn23r9q4x7FW06KoorcN141tOYQzG6a9rrClmu/x8yIJGH0Aa5oG1Gs/zaG8SSCLPn77q86gQls57b6inHiEeHTT8FsmxQOkZjmXWES8puzBNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D595nzjudaLW97KGdFVDduWshEsWpZ3q09JznCQkrrU=;
 b=WyvmXJh362I7EbPCN1osFrKNah5tn9CVzzx8JNuOC+E5iQuBhX6QyLQXYS/OB/t9nwsosbcIZIcQlfEbEGKZ/UyyPk0gqRr9FTJvz6iJ2DYM2RCZookmrMqzTK+oJR+4m/xhXV0YKD8COSFSWL4CIxmhmu3gDVdnUGtlJPsgHI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB9343.namprd12.prod.outlook.com (2603:10b6:610:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Sat, 30 Dec
 2023 02:42:14 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::ce8d:7121:cb06:91ba%4]) with mapi id 15.20.7135.019; Sat, 30 Dec 2023
 02:42:14 +0000
Message-ID: <0ad78e88-05d5-483f-83fa-87d5f1d80ca5@amd.com>
Date: Fri, 29 Dec 2023 20:42:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Use subsystem appropriate debug call
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, "Ma, Jun" <majun@amd.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:MAC80211" <linux-wireless@vger.kernel.org>,
 "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Jun Ma <Jun.ma2@amd.com>
References: <20231215145439.57286-1-mario.limonciello@amd.com>
 <87frzzsfoi.fsf@kernel.org> <46bf6ed5-31f6-48f4-b63d-f532e163204e@amd.com>
 <87cyv0oyaf.fsf@kernel.org>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <87cyv0oyaf.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:6e::27) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b1a3d2d-9808-4ae8-d2b2-08dc08e0ee2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l5SbJ0WyBjcAxL3/5P07RT3x8WU75dEXxEYCv0v65dOC+UJIsXp3ssYENlfh7+Zms/6KTuYxiMPLjmXN8MUP9lX7OaKipTeOBmOVJ7vLZdk7anua7AiZXiw5sz4lBt7AqXEzkB0v+K4ZDjXABFhALrEOrgoeCao3DZEp1GBfhn3UFrF3VrRmLz7epZKprhbe5F9q9Ta2Svep09cydiA8HtBqQATWpODUitMuHp2R1anRrFFf6cgQp3roMCZ9C6+yyzmAn4U/QL08B0iRy2SB9SnI8fdhWY1/isEns7tFMwAi1XOh4bNGF+yNpznBJw+Ut8AjT8xx6Zip7HSj1b2pu7g9Jh5UewGr9INC7jDTVyU+BZ8uhgHW6raDFSpNYkLqv/EZo4+TLgZ9AkSgPZBjuAyPpVMx5QuNh0FLBbZvGLvcBb94i32QozSHQrmC3lUPZ4PtF2kHqPwKIZ5UqCMuoJuIC3DDgqGQSi32jRWUH9NEYxcnlfZD7oQfO1BQhsryzq5jDnLOOHFnWzbrmjagKtJjmBC1chh13u6S0xtrbpGoOjaq0VBIF0BCdoeNG4Btna1W8Av7keoBAtlvLdDbUtZyC7AiNcO7PEERbYvlFL4E/NCBEWLl2iiq9UFHWLx/zJzAQkGjJxHzs8OLx/LD9w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(396003)(366004)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(6512007)(44832011)(66899024)(6506007)(2906002)(31696002)(86362001)(478600001)(53546011)(36756003)(6666004)(5660300002)(6486002)(966005)(110136005)(54906003)(66946007)(66556008)(4326008)(31686004)(8676002)(66476007)(8936002)(6636002)(316002)(41300700001)(83380400001)(38100700002)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2VraTRTdWZVVXB1RTMwTHpSQzBQY3hSeEpHV2hYWnBROEg2amZsdVZCR3l3?=
 =?utf-8?B?dlVjc0ljNzFMVVhKNzhHblRKUlJkSzAvaThzMVcwbVlZWlA2c1FEbVZiYXJs?=
 =?utf-8?B?b1FQUXBLKzN5NHYwYVFEQkhlaHRhWmJFbFdXSkI2OGU1b1Z2Z3ZoWDZlWnFD?=
 =?utf-8?B?akVxT0QxZzl3OFYrNjh4ZFJySDB0aUJMTHVQUFprV01yMHJyY0dVOC9QMkp0?=
 =?utf-8?B?TUFadXVKTE1qQ25IMWRnRGh6ajNQZ0tMU2NsbmFFUFZIZklReDkwMld5MFFO?=
 =?utf-8?B?dlc2NEZjSnZsOGhWeGlmSkkyK2ZTODVkdUtvcFhvMUM2RGNHUHRFWHdQUS94?=
 =?utf-8?B?WkxFWENhc2J5Y1JRemFta1lGY09TUHhXZlYvYjRLTUtaYlo2dDduTlZ1NVFN?=
 =?utf-8?B?ZUdodVlHbklUVnNHSDZRRGdWQnRzaStNYlFKb3VBWlkyRWRzZnVWME9xcHdF?=
 =?utf-8?B?b0ZXMkhhZXBvTmc1R3N3QjRKb0tKYUZ6U01ONnN4QjJnOWMxaWhNZFByWDZo?=
 =?utf-8?B?emdUbndHUVBTQ0I0YlNSSDVGRDRXNi9remprank1WGlJdzJBUXZxZ0tGdWtZ?=
 =?utf-8?B?YU10ZmU5SEhJT1lvNzN3YnNYWXRNajFmSUYzWGFmdFhrYzVoN3h1eWxQQnBK?=
 =?utf-8?B?OGVNd0QwUDRHdmNJQkx6bDRoalZ3ZG5PelI5a0FzejAxMU00NEUzNmI3TTVV?=
 =?utf-8?B?Mk5GdmF5MHpkZ0hCVEprekxCTTVaWXZEZkVBV1ZLRXppaEVLQ1B0SmFvbmR0?=
 =?utf-8?B?Z0FCdHUwNDRrc2ZvUy9OQzZxQXBlMWN4YXQ5OWxHS0oyOGFML1dTVlBid3RL?=
 =?utf-8?B?ejk3N3pZNU9WdDl0czBmeDdwUlhMTm5PcElpOURxOG8zOVdKak9rbWFYeVJr?=
 =?utf-8?B?ZHFOcWliZ3NLUlI1V3dvSjVXNmFvQXN4QXcyZXcvV3NSVmE2U3QvVnFxL3c3?=
 =?utf-8?B?UlVHa1pxVXBwSzNkcjFwRVphUmF2REV6UWViMTFwL3VvRmtLUk9JaGdMVGRT?=
 =?utf-8?B?aVdTNFBCZ1JINko5WVpGRUwxTDVtTnFUdEhwMHVYdWxLMm9VL3l4MFlhUCtX?=
 =?utf-8?B?T0FaSW9Rd3JyeDhZQ3pjbGRCNVRxdE40QWo2ai9MaytKL3NIWEczR1FrZzF2?=
 =?utf-8?B?TkV2SkVKRjZqWnFMN2VsY2ZYZmVVZk1ZQW5yZnE1bUFPVjJHQTJxcGxybDlN?=
 =?utf-8?B?WnZuZkEwWDZKL3pVUHhadWhueWVqdWs3My9iTmFqNThCcXFpTXVzWXNIVEQ2?=
 =?utf-8?B?YSt1aFlKcTJxcGVBcGJyWi91ZUVnczRFK3VMam1NdlNRTjRnQUtKaS9QcWlZ?=
 =?utf-8?B?S0xVY3NjRUhnZlBROUdzV21aNjd1ci9UUGwwZHN4UnM2d2hyd2RJbHpNQW9D?=
 =?utf-8?B?MVoycVFrYmxNOWVZMEtaQmpydVV3REJaOWhHeGNJNzdQSlhDNE5rRWJLaDRz?=
 =?utf-8?B?b3AyOGw2TDhrUXJudDhxa2lhb1YzM3pDeGQwYWNlamZESnFGZm1rUGN6Q3pV?=
 =?utf-8?B?YitHckZoeStNZVdTdDdPZmQ5RTNpNWtxQmtmbkd6bEVlVElrTGtkaFpEZHhn?=
 =?utf-8?B?bThaY3d0czlabFBHRlAxNzJKY2wrNzZJRnJHdWdiWGo1aVVPMTFPRzZMQ2tr?=
 =?utf-8?B?MFNUdmRuM2NvaU9Gd09SU2lGcUVmTGdTRzhzUlNBNGMzZ3ZzSFVmUlllWXhz?=
 =?utf-8?B?YVpTekRJeHorNFJaVVF2Wml1ZjBNeFp3UkYxSUd1UDloNm9BNDE0SVVpMXZW?=
 =?utf-8?B?UDBVMXpGVlVaanYySVZjemQwcThzNFpaZ1VMNVlKQ09RWG1td3NqUnpLOWxY?=
 =?utf-8?B?ajdVQTF0b1U5c1RxQmtjRHJ2WU1MK0l4SkZCWWR4VE9hTGNvdlRqSm91dkI2?=
 =?utf-8?B?b1FCa0xjWUI4SnV2OGhIOHg0RlZGTkJqVkg4cTBuSVdQOUNXVWhrZENqNGxC?=
 =?utf-8?B?RXYwckFiU3ZIVklxakg0V1JnYnVXYitHMFVsZ3piczlHRkVDcmVZZVdvNUhX?=
 =?utf-8?B?RGxqdTV6YlB0NHgvTTNHQmtFbitSRXdyTmpMdis3T2puM3FwN1NTNTFwdGRK?=
 =?utf-8?B?Y1VCQmlSOGdmYk9mejRZYnF6YkxNKzVKQS9jdlpvUkJQaVBHUWc3Q1dBcDFC?=
 =?utf-8?Q?CsCkeJDtXeWCg+DLbS/MLSSc4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b1a3d2d-9808-4ae8-d2b2-08dc08e0ee2a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2023 02:42:14.2714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rjnPpZWnV77E4VRK27Bjh5D8CVprfm/qS5iQIr7BUfZrSCJQkik2f6MJI2PdhwGJMvvssiuoqikFdDa1YLTX9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9343

On 12/21/2023 00:38, Kalle Valo wrote:
> "Ma, Jun" <majun@amd.com> writes:
> 
>> Hi,
>>
>> On 12/18/2023 11:17 PM, Kalle Valo wrote:
>>> Mario Limonciello <mario.limonciello@amd.com> writes:
>>>
>>>> mac80211 doesn't use dev_dbg() but instead various macros from
>>>> net/mac80211/debug.h. Adjust wbrf code to use wiphy_dbg() instead.
>>>>
>>>> Cc: Jun Ma <Jun.ma2@amd.com>
>>>> Reported-by: kvalo@kernel.org
>>>> Closes:
>>>> https://lore.kernel.org/amd-gfx/8bd60010-7534-4c22-9337-c4219946d8d6@amd.com/T/#mfe2f29372c45130d27745912faf33d9f7ce50118
>>>> Fixes: d34be4310cbe ("wifi: mac80211: Add support for WBRF features")
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>> ---
>>>>   net/mac80211/wbrf.c | 4 ++--
>>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/mac80211/wbrf.c b/net/mac80211/wbrf.c
>>>> index a05c5b971789..12c23e14f884 100644
>>>> --- a/net/mac80211/wbrf.c
>>>> +++ b/net/mac80211/wbrf.c
>>>> @@ -23,8 +23,8 @@ void ieee80211_check_wbrf_support(struct ieee80211_local *local)
>>>>   		return;
>>>>   
>>>>   	local->wbrf_supported = acpi_amd_wbrf_supported_producer(dev);
>>>> -	dev_dbg(dev, "WBRF is %s supported\n",
>>>> -		local->wbrf_supported ? "" : "not");
>>>> +	wiphy_dbg(wiphy, "WBRF is %s supported\n",
>>>> +		  local->wbrf_supported ? "" : "not");
>>>>   }
>>>
>>> This won't work, I still see the debug message:
>>>
>>> [  333.765867] ieee80211 phy0: WBRF is not supported
>>>
>>> The issue seems to be that mac80211 defines DEBUG in
>>> net/mac80211/Makefile:
>>>
>>> ccflags-y += -DDEBUG
>>>
>>> That -DDEBUG should be cleaned up, but I think separately. It's just
>>> that I cannot come up with any good proposal, all the macros in
>>> net/mac80211/debug.h require sdata and we don't have that in this stage.
>>> Any ideas?
>>
>> I will submit a patch that only compiles wbrf.c when CONFIG_AMD_WBRF=y
> 
> But does this mean that the debug is still printed when CONFIG_AMD_WBRF
> is enabled? And I would assume all distros enable that, right?
> 

Maybe just discard the debug message instead of have to deal with this.

We'll be able to tell from the consumer (amdgpu right now) when WBRF is 
being used and if we need to debug an issue knowing that it's supported 
or not supported from the producer side is the least of our worries.


