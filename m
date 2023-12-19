Return-Path: <linux-kernel+bounces-4986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF738184DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 61244B22638
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC7614265;
	Tue, 19 Dec 2023 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="v/WSKqry"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2050.outbound.protection.outlook.com [40.107.105.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131F213FFC;
	Tue, 19 Dec 2023 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFn9ZEV5LXuAEFGpdkrMYeJKUHIjXzDr5HjZqm5/bNR41boDV2hYqPkcGLqwL0qbpXUb8N7gfTfZwHbc1GYorNMhT52EeYiPCT8WkeQqcnIgUheRw9RAL380dp4QB14mXfdBI+Ou3t0DMJynhVzcSBc2B0dlWas0circSVRc9FZHr2ESqsughEfMmAgc3BJ52RYW9ihM2egz7Lxk6LG0VQ0SOoIKucFfJj+K9Wcr1uKUtUFaYH0ylGGOJAfMfWRzK7aPPK82BJYN6MBUwKxi05DmiXuyLCdPk62Z5VcsBbNnoWCX3uafgz6VOAfc+ZP2GU2ag7Hv8W932pTeIjJIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzFIxMmFqdxZRxqujFAor1tsFHwUKxhyP7RpezIOw6E=;
 b=DMNUiwSsp1BMMIs7RURVrBLaaAN9wQ0GIOUUzfT1mZl2WCCZm+1KrgJRvWadb574L9x4QZCIOY4lm1S/Vr4a5STWESFgTqsBcAU/w2YhUk4y6Yz2orhgpMIww11mxIubiCBjAfkinX9DzlXBQ6XAQsucNiz8gnH53EFoAZj4f0IhRjDUB3Qjbp0bIo1IOp2YmJgR53ZzMcO19LWcFIYJ7lWzT8OvzrowISBv2MbIIakmNfXZSa/qB7nAEgwS4zO7ef4qj5ykjXCIl6YLVfsgmF7fsEo2ZsGEt5nr9R2smLUMrRkbLJy2emVmM2zXtleI0u7a0yqgvDf3i7LRpADdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzFIxMmFqdxZRxqujFAor1tsFHwUKxhyP7RpezIOw6E=;
 b=v/WSKqryhUmXHI/1TGw03ZHP3NahXanYwG54AbiI5r3pfMd1xmBIhdd7LTiHY7FfJfQr6bz8I35WoueMEBgVc4PKkAbwfLbcTtg34TXH2E5W8nFEfYW9EoJBnO5BeLtFB+iUKgGG4s3WZyYFLxUFRZfu/pmUu/s6K/25WHHVLbVlEujGF96C0/DLunvnt4tPP5haK7VMkJHGkhlKvmnJJYNMwBY8fbOLpldI5i7rs0yH7bBOUklQteoW6RTdM3xAF+lrX+wkVOPLmo3by1HN5f0OZGwF+Ivv4kdDNoGy9opZg7n5SFQtuPMfT1G94gG0Fa2UYePuwbvZibY2SDssDQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:391::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 09:56:40 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 09:56:40 +0000
Message-ID: <d25399e3-9054-44a1-9ff9-e27252436222@siemens.com>
Date: Tue, 19 Dec 2023 10:56:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dts: iot2050: Support IOT2050-SM variant
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bao Cheng Su <baocheng.su@siemens.com>,
 Chao Zeng <chao.zeng@siemens.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Li Hua Qian <huaqian.li@siemens.com>
References: <cover.1702917360.git.jan.kiszka@siemens.com>
 <11e0b0c8b828254567a8ff89820c067cacad2150.1702917360.git.jan.kiszka@siemens.com>
 <8b3daa3c-dbf8-4286-b04e-011cd9b0efa5@linaro.org>
 <4c31adc5-3fc5-47bc-9766-6d3d1eeddb65@siemens.com>
 <fbb29d81-9ea0-4468-ad47-f6668c2be277@linaro.org>
 <de3f4778-51d6-48ab-9d4d-451f2ba01a3c@siemens.com>
 <3d2662be-3a55-4390-bd2a-cfa5cc53510f@linaro.org>
 <ef5a6cf0-4350-483d-a1e9-ce8b0ef71280@siemens.com>
In-Reply-To: <ef5a6cf0-4350-483d-a1e9-ce8b0ef71280@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8090:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b24b5ca-d0a6-4616-eb22-08dc0078cbfd
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bOhfXxm0Nkg85iRELejsQoyWK2cdto/T7HVHX2t3wf/y7cGYOIHLawzBdR7rJhaU7O+/LCOD8k/ynb/0QPUgEaMQDfEb2UzBUUcBV4PZlm4QoG0bSMwbE3S0o/ZbMmnuKjgw5oTNYSLJ0PItbRJGpiAPWAuV4TTmeKKoU/U4D0TUH2uOgtds6nT6/yk9tV5EWY5r6V/SuW5CM/FD1tLhkTzz9djcqy+UCLtCn3OcDitrbuuDtJ8lKxpWDiLWPaI0OszGMx8Jhf+g3sA5ORfYBQ8cyBCbMIjOtzIjuTWWXRVspW5Kl3sR5Hl+g/YxoPZc7yo2Bnrqe0eXr+VgQLHMbfHxTFwB9u7RbB/508/B6oFM6LuTAMu2IKUTb0ugYpD7tyRx8s8vHPAjY42HZxPMYs4ZCGtRykzPTvvtgDYAZh5+Kvkw9S+iWFNlXDyWuqireefr03aIJmSHsowQxze259KpwPDvC6KsGAgf46N/DNJBzb8G2yP7coLKHx5qt8kaXJFVI0Ao5v0cm9h/tFTNxixuMzCa8JcpN2hFe0M11wv+WaHxFgY37K8sN68qE6z53zLavBU0UinhY7PX9NMt1JwsDzEVBGRAoXGkIxSEuVbUM0PsI7NluvRv6sRgFMUs4rCEat+tj5Y79MMR9VzjPw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(366004)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(316002)(83380400001)(66556008)(110136005)(66946007)(66476007)(7416002)(5660300002)(6636002)(2906002)(44832011)(4326008)(8676002)(8936002)(53546011)(6506007)(6666004)(6512007)(26005)(478600001)(2616005)(6486002)(31686004)(107886003)(31696002)(86362001)(41300700001)(82960400001)(38100700002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dHFsM1lwMU12ZkxDSGwrM0lHenIxbDBsUjRzTnNvUW8xYm9PK1dOM0tnU3Zq?=
 =?utf-8?B?T1IyRm1nSkh2R3pXUVVBUm1taWF0bm1hTXdXYXBUaVlySU55dytGeVZtQkpv?=
 =?utf-8?B?cXZUMWFlSm9rUUx2RDRYN1E1RDJzMjZvbmUyYVJRU1FZK0dwTjBpTVFIUFh4?=
 =?utf-8?B?d2NZRjBoeE9QaDlxcm11M2N0VVNkZ1FYblFrTzVTN3NwOTZUUHFSY0ZxNUo5?=
 =?utf-8?B?VFIveFhSN2dnSktMdVUyRW1XSXJrT0ZpbDNDVWsraFM4T1IxNGFOazhQNFpx?=
 =?utf-8?B?Q3ArUk5YK2x4c3RWSE5wTmlwc3lJV0dDSWxrVFNUcjN3SjJzbjJOampSTlhL?=
 =?utf-8?B?dTg5T3kwRG4zdTgwZmx6L1VaRm1BdFl3Y3RLYXhld2lPSWg4UUJnZkswYXBm?=
 =?utf-8?B?SzFBL1F5b2xJbkdxTVc0SFZVcU1OZlR1OEZqOU51WHRyZFEyZUJLY3JNWjhE?=
 =?utf-8?B?VnM2MTduMkdPN3FhWnFMRE5xY2ZpWGJTbDRIL0I4Y21Ma2VrV1NlNi9BdHFW?=
 =?utf-8?B?VkxQQlN3OG5DM0IxVWhxZHdGbEFLN2FjU1ZrS3VLYWJCSFNLUkFSaFR0MGlF?=
 =?utf-8?B?ZEIyeDFKUnlhUkxwbU9ndld1dHY2MC9raGdjVTFXV3NOTldraHFBWXV2YWFz?=
 =?utf-8?B?VE03WmlMbkpTYWdCVWRQS1cxRDYwM3BuQnNEYllLNUVDb2pEeFVXWEpaT3Ju?=
 =?utf-8?B?aC81TjZUdG9iQWNSeCtqZkxWMWhBWFkwQ1F6allxK0lEVFBCck83ekpjKzk1?=
 =?utf-8?B?RGtFbzErL1JxWkFqQkpmUkMxTkU1OWlLZFlMUWpBM0FlL3RNNUlWQkhZc2FK?=
 =?utf-8?B?ZmJHWmh1NUZ6WlpRQlA0YlJaNTNERmxQM3ZtbCtiMUxaY3h5QTEzenl0RzRT?=
 =?utf-8?B?UnJaVldQN2d1Kzg2c0syWlExRHFBekx3Zlc4eG4wNGFQTW82NjV5ZkV2d0F2?=
 =?utf-8?B?dVlpUWM4d3FyMzQxb2ZKNFIvb1lFNGxUTlowSmNMUi9nY3lZSzZiblU3aDMw?=
 =?utf-8?B?WFVqdCswd1U0VVlOdGFIUUU3UGlGNE1QMDk5c1Z2RUNzbnNpU0JicHlxZ3J4?=
 =?utf-8?B?YjJjYTRabGIrQUhqdHR0dm9vd0NZZUcxZlg4ZU9BdEYvcU9YRCthN2RJeFJs?=
 =?utf-8?B?OTE2aFNrK0FCZHFoYW1xdDYrMFhNcXVHNXJoRkJ0SzdQZEhIcWo1TldIRGow?=
 =?utf-8?B?UTFiT2NFdTZMeW10ajZLNG4rdkMyVkwrRng2NTRzM3Y3TmFkNTlIelJ5bFZm?=
 =?utf-8?B?NHEvNGM5akZoOTBPNllza2tBeldBbXNSNlEzKzJkMkxZN3laTzdKcTEvK3lk?=
 =?utf-8?B?ckpoaWx6bmRKd3kvNzVmMFhTT2dGV1ZvRytYV2JFWWhUUzRaU3kyUE9yUWlm?=
 =?utf-8?B?ZmFXQ0NCRlpOSmlQWGtad1d3bSsrNGRxa3ZqeGtFdzRQWUtaZ3AwVFlaUzdh?=
 =?utf-8?B?VngzbnBtVXRuOVVOS0lzNG8rWUhXZWUrT0dDV1RHZjhEdjNQQ3M3U29OT1JC?=
 =?utf-8?B?TWE3MzFPalNUdWJBa0tHWHBiME0rYjFwZVYvUm9qckxjampqRFBkVVgzaThI?=
 =?utf-8?B?WWxzVGlyc2VzOENiOG8zOXRRMHVCb3JJaWxyZ2ZSNmczUzMrQ1pmZXBxMGlS?=
 =?utf-8?B?SUVEWlpEWDZkdXcxUEU0TzhjTkVLNVJQVlluSkdXWmFiV3dVc0ZZL3NOTzFS?=
 =?utf-8?B?dWtXelZkb1dHd21ObzdFeXZySWtnMVRSSW1TQjdQeENyTjhoL1gxVmlwOExM?=
 =?utf-8?B?MzBpMlRjR0s1SkVMbngxV1BaSFNXdmU4bXBBcENoQ2gzTTl6SkpRN2kvWEdT?=
 =?utf-8?B?Mzl2Q0w2K0srY0RKWXd6Zlc3YzRXZUt2a1FFSC90TEtRREc4YW9WVHVacDRy?=
 =?utf-8?B?VXRwemU3c1lpQ0FhK3UvclZTbFFvUDNjTkwydk5lbElSREIvT2tQTncyTkpQ?=
 =?utf-8?B?TnFqcW5KOTFvY3lkcVpDc2xoLzV0VllUY1ZXTEtWN0wvWG9YRThTY09GVnVO?=
 =?utf-8?B?c3pLNWV4UDhVUEUrdW5JVUFxUm53bUdST0kyWDhPbmFBZCtUSUZBa3pvOWlk?=
 =?utf-8?B?SU1UY1pRUGpWQndiTW44YUloSW1nazc3WTgzbnAzbnFaSnVRaGlSWm9OK2pB?=
 =?utf-8?B?a1VjRnV3RkR0NWJybUwzYmc3aWxibnBSWHl3ak9NWWJkOXQ0U1RTdnVOd2VE?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b24b5ca-d0a6-4616-eb22-08dc0078cbfd
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:56:39.9370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +8YDmvZVbB5/vcFexKnueD3k3Ngbs+u1SGisFV9IylZs+UpxzIXEDzCAqdyC1ySsO1F1ZvYqmlrXfeoydqRJoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8090

On 19.12.23 10:54, Jan Kiszka wrote:
> On 19.12.23 10:50, Krzysztof Kozlowski wrote:
>> On 19/12/2023 10:03, Jan Kiszka wrote:
>>> On 19.12.23 09:48, Krzysztof Kozlowski wrote:
>>>> On 19/12/2023 09:22, Jan Kiszka wrote:
>>>>>>
>>>>>>> +			gpios = <&wkup_gpio0 53 GPIO_ACTIVE_HIGH>;
>>>>>>
>>>>>> Ditto
>>>>>>
>>>>>
>>>>> This is adjusting the existing LED nodes in k3-am65-iot2050-common.dtsi,
>>>>> not introducing new ones. We can add the color properties in a separate
>>>>
>>>>
>>>> Then why aren't you overriding by phandle/label?
>>>>
>>>
>>> We could do that as well if we added labels first (they don't exist so 
>>> far). Not seeing any difference, though.
>>
>> Confusion? Your code suggests new node, thus you got review like you got.
>>
>>>
>>>>> patch, but the node names are now part of the kernel ABI. Changing them
>>>>> would break existing userland.
>>>>
>>>> You mean label. Why node names became the ABI? Which interface exposes them?
>>>
>>> root@iot2050-debian:~# ls -l /sys/class/leds/
>>> total 0
>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc0:: -> ../../devices/platform/bus@100000/4fa0000.mmc/leds/mmc0::
>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc1:: -> ../../devices/platform/bus@100000/4f80000.mmc/leds/mmc1::
>>> lrwxrwxrwx 1 root root 0 Dec 14 21:12 status-led-green -> ../../devices/platform/leds/leds/status-led-green
>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 status-led-red -> ../../devices/platform/leds/leds/status-led-red
>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-green -> ../../devices/platform/leds/leds/user-led1-green
>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-red -> ../../devices/platform/leds/leds/user-led1-red
>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-green -> ../../devices/platform/leds/leds/user-led2-green
>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-red -> ../../devices/platform/leds/leds/user-led2-red
>>
>> I replied too fast previous and did not include answer here:
>>
>> You have label for that... Somehow all these nodes are half-baked,
>> without all the expected properties and now you call node name as ABI.
>> The node name is not the ABI.
> 
> Well, existing userspace uses those names, and adding the properties
> would break that interface. Now, does Linux do that?
> 

Obviously, we could deviate from the existing naming scheme only for the
new variant, keeping it for the other 5, but that will be "fun" to maintain.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


