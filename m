Return-Path: <linux-kernel+bounces-4984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0268184D7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:54:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BD81F231F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6614012;
	Tue, 19 Dec 2023 09:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="cocjP57x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2060.outbound.protection.outlook.com [40.107.249.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCB14A84;
	Tue, 19 Dec 2023 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBdejRaK9tJTA3KUAX5WjyezibOnn9IUKWTu6BgbhODgkNzeMzxQp5kvUug9UW81fMBYaZXlTF5F248zvkhzdz9Mwio/L1uR3lwX6cEOO03TYQAjMRz6eZevmwtU7hvviVmtuAcPqeFboFb1cNJ+vOw87jIY2uQZVjBMRccfdPwiu1qsfDPM9sYsr+tFWDw37/Mk9ltpdv1wYGeuJ7QvbVHcjMX3X2xwbsLunS31U4yGzPJRSdpCAaWJ2cCHJY3cR6drSQKlJl7VYjAYzWrMcKM2ol8aePK7JvJaYQ09AQAE0BODxo3e7JCuwq2U/3CVFU8cD/FpXa3RZQTsARt8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uDW1U56DZl7KaXkdkdUZYz6Kp85XCCn24ik8TiEkV8=;
 b=mPdqNVWKoPS9QXmRYuSAlcbHdGgmNloJUrsRqXRNwBJGGBxGcMttM66Fay4ypmRYLJCIjPdfs1IsjeL+vjYEt4G5URyy3+t6YONmx1qKqX7nuDVA1I0nIcw+8tKRYi1UGpElbfiqFnVVqmxqhMJG2iff+/zt8bl0k4ZAA2sSAmzl3naMzuldvCHE/eE2EhXhQFKWorStzJEya8UsMUDzlujI7Yvs4Pr9uRvkxJxiYeuT2r/6uJCLi21Nih0QD0v0SB7SMDe5wPme7XOcRaZU+3JEmijGHgzO7MIuSJWfMn8rEoorsNYL1dDC1wri0mM0RY0xPz2ePHXKyDksxPrgXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uDW1U56DZl7KaXkdkdUZYz6Kp85XCCn24ik8TiEkV8=;
 b=cocjP57xb6GTsEFp2BKjMFbozPH/dSsPxA3xqW5gMnmfMHB4jYVevLR2Ar3Fp0lpiaWM6HcqB4tjGh+13rkwIp2AS5O/P6QcHw+BAS5DAHSKs/TMhMNlId0fwrrfObAqVSnTgybY05xGDW8Rkzw8hfW5zwwJNUuYTXhYhpxdsm7TWY1DfdNjQna+iZblWh8yOmTEyexCiKdUsAPqoM2kdRcgArqukv33+YljIxRZI6AatiK8TsPFdLIhkqvzMq+uhIoJddVgMZWbncUpoFxpBcf9QOOukRsacw0BXbJy88OiF2hYrFjhc7y2bU2pVxXNM2qfxpRF5G3tnl6giLq8ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PRAPR10MB5202.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:29f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 09:54:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 09:54:37 +0000
Message-ID: <ef5a6cf0-4350-483d-a1e9-ce8b0ef71280@siemens.com>
Date: Tue, 19 Dec 2023 10:54:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dts: iot2050: Support IOT2050-SM variant
Content-Language: en-US
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <3d2662be-3a55-4390-bd2a-cfa5cc53510f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PRAPR10MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: a69c0f3d-8cea-432e-164c-08dc007882eb
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xEbB2Ug9x2aiD9wUE08+NK1HhT9tZThIRy3viGR5gwK8GAXDghNeejqtPKqP37xVX6QQuwL/4OqE4XLefKku96dt1/aNJdkGMSKmX0XYmDGGy08UGmiGdRj1uTxkcEbsP8fv0sCuQ90tGjvPT1FSRZcGG4Oy93xUE7uKjHMpxrFu902bK5PsFXzHpzSqYgSaJXJc52FKDFTMp33OboPLQU/Qr353rLdDua/1+8PjxRTGqrDd7NIxRe3Dx/VRyhnXD0IBWEXFbsG1im65aCc9w918pgfEuysw+PFnXsPYjveMkG8gZaYY+dr0W+5zCliEtsdRULzGoK+o5A/LtXJyFvMhJfMXp49UBNnTKPHkbMIbT0xyxhtN3nJ/1FBt9dQ3OrjIgJ43cuO3YEwWB+DkRcoHWGhc0QjGgV8nIZlVYcfIHPLGRxpGv7doJGs69KK9bkaeHwALvV349/KL0JkNrH7gIAiB3JbR3D8l931NJ3aTGgIs5dSRmbeuPdX6Ap0/kv+SzeCGlwHQXbEzK5XPJZ8zOnLvWDzX+7MZsQRfI5StxcFIAF6AXoq9gOP4ek5FWxYzvb387LuSKv0eauz1hTHDmw7j2OuTW3EySxEZHNSNAdLEIgYayg5jfa/abh53+gbpz85o4yM0/i7yP3a4MA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(376002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(53546011)(107886003)(2616005)(478600001)(26005)(83380400001)(38100700002)(66556008)(8676002)(44832011)(8936002)(4326008)(7416002)(41300700001)(316002)(2906002)(66946007)(6486002)(6512007)(6506007)(5660300002)(66476007)(6636002)(31696002)(36756003)(86362001)(110136005)(82960400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QldEaC9TTG4xcDAwMzd3TEFlVEEvY3psWmw2dHZVRElabi9jWi93TEgvN0or?=
 =?utf-8?B?dTF3MmRVdDNVYjNpRkNVZFBpK3V4WGo2QkNUeldpMWhDaExDb2FvMm1RMTA2?=
 =?utf-8?B?L3JvQXJWYnFIejhlY2gwbHRsQWlGT0F3aEVrSGt0YXJQei8xRXFyZVVjenhL?=
 =?utf-8?B?SUNUdlBOaFV4c1l5Q0lqZGRHQ0ZwMjRFSTRjdUJ5cnhHTW5EQThEa0tlOWR6?=
 =?utf-8?B?bmRQVXNkU2NqQktTR3I2QklLSjFhbDBSQzRJYVkzeVpEM2dnNHFLamJNVjVJ?=
 =?utf-8?B?T0JxM2k3dzUyNm8zSnVnbU5UMHN4Y2FzYWIxVjlNUXIrSEtyV3ZHUlE5cEVG?=
 =?utf-8?B?aHNQcXBudXljMU05VTN2K0VNSUpKYVN6c09jeG5ZYVZBYVd5ci90d1JVTEFH?=
 =?utf-8?B?NVA4VjlGR2E2cFJGdGtwQ1ZWQ2FoOTkralNsMjFzems0OFhUV2xvYmZvU1B2?=
 =?utf-8?B?TEY5VlZUQ0R4N3hLZkhJemxHUWZqdmFUQ0thcDBubGxPemFwZmlJRlZXaUg5?=
 =?utf-8?B?YVZXd2RDUjJNQWNZSitTTjZmVkgrbDBER2QrdFp1Ni9tN0NqT0kvTFhjTktt?=
 =?utf-8?B?T25zby85dDd3V1YxM0Foc1dIMGRLMzZtZWFKcmNmVFBWRVNZc0E1Ty9ZOTRK?=
 =?utf-8?B?NmJsbVNQK3BGTVEwV0Vva1cxNWQzcG1hTWNPQnJxcGJ4ZFZ1ZUt1QWw1cXVM?=
 =?utf-8?B?cGZ2dEhVSHF3ZE1XN1hTcXJCMmNrWnhSeno3amx0UjU4YmFvSlpGeGRmS1dD?=
 =?utf-8?B?U3BQRTN5YmZZcDJZZkNSSjYySkNmRnpqSWh5RUpwSFZXSW5QTTl1MWtPajNq?=
 =?utf-8?B?cmpZWWY3eUhaeDJqQXVkNzdrN3N4L1lYOVY2aXduekJvcUx2b29paFgrZENF?=
 =?utf-8?B?OE96bXJIamZOVEFUejFkalE5TjlFS2luNXhjblp6SkRxSzhFVDNLdVZsano4?=
 =?utf-8?B?T091ZGIwRlJpUDh0OGlkSWpqQWhZODRuUi9zd0lkaU41UklTaDd5UlZIM1ZG?=
 =?utf-8?B?TGgrNVFZeXpHU003SGJCQ044cGFIdmpaUC9wa3o2azJ6eTBDb2RROVBEc1Yr?=
 =?utf-8?B?NVZkUjVWY1ZVYnZSbWtqNGhyVEo4aUFLMzgyTnZjWjR1eUZCK29WcUFXZFZR?=
 =?utf-8?B?Qm9rUW1TYzRnMVQzWEFWbTdzazkrYTVmQkhVdHVCeGE1MC9QclV6SUl1VTNt?=
 =?utf-8?B?cUpOVUt4R2crZG82K3ZPcVNRdHA2a3VCN0lwcmo0SXE4UkJudjdsMng0NWpH?=
 =?utf-8?B?R0RGVVJIUnFNb25vUklSelZRZDR1WkZLWFhWcVpNSzhpVzlZS3VFdEVmZlM3?=
 =?utf-8?B?WVd1eFB1bWZWS29mRWp5ZlZZakFRdTZvMFRhSXpYaU90bWxVUGl6ajhUSzhP?=
 =?utf-8?B?b1ViMjRLSk5HVExjNkk4RWF4R2pNZU1ycUhQd2p2WGs4aFZENGtOZFE0TTZM?=
 =?utf-8?B?MlpIb2VHYzNEaklySk5nVjBkMlNxeHNJM0JDRzgwL1NKZ2JTYm80Y28rN2dZ?=
 =?utf-8?B?S0VoNHhTVWJSeERoVFU2c0pwcWNmcitRejM3U2t6NkRWRkxCSXZldTZNclcz?=
 =?utf-8?B?QlBVMUo2TzR4eWdiMTRkZU5wQ2NvZkszUjNSTEszdUgrQzdLODlhdklZbmpJ?=
 =?utf-8?B?anlGemVocVY4NzRIV2RJVE1Sa3RyYk1WaE0xWXNTUkhXOGZZOUkrRjhqS0Fk?=
 =?utf-8?B?ZnVhRVhmL1dabDEreVkvdDhJWm1NTXZzOWZOZTlvQnVwRVZrSU5MWXFNZzNo?=
 =?utf-8?B?QitEM0FibHYvV0xwYXlzbCsvQlNtcVFFRk4wbzBkOUdVdDBGODFFZitMQUFN?=
 =?utf-8?B?aElUYXJlMFpYVFJGYTBGN0xkKzJNcHJYVDBUbUZjblRjRThMOW5jZ0twSkxS?=
 =?utf-8?B?dzdLaWN4b1NQV1pxaFZTQm5QejJPcWpEd3MwOW9zM1hZUkpmV1RsajY0cGt0?=
 =?utf-8?B?aUo4UHpPdnIrSmk1RS9jdkxjRVpPdTZETWFOT2EraVo4cFZvRVJuSThYV0hy?=
 =?utf-8?B?ZlpaRW5HMExicFNDazZMeWhDSk13d2tKejMwR3lOMkZhNitOSWZ3SGpVZjc4?=
 =?utf-8?B?MlFvbGdPbkU1RG9zNGF5OWM3ZnZ0M1cvV0FTbzIvVlRPankzY3FTVTd2UzlM?=
 =?utf-8?B?MTZyUk16cXpvWXFOTzhJSjlKdWxjLzRERGVsVWYwM2d4QWxhNEx0THhhcnFt?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a69c0f3d-8cea-432e-164c-08dc007882eb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:54:37.4853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw95YsXNYu5HXsYHDMaiJNaOVUFkgvfvsS0MadSn9g9qKbL68f6OqoR4TBuaZoZpozLbCVh6RVato+PPNh3A5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAPR10MB5202

On 19.12.23 10:50, Krzysztof Kozlowski wrote:
> On 19/12/2023 10:03, Jan Kiszka wrote:
>> On 19.12.23 09:48, Krzysztof Kozlowski wrote:
>>> On 19/12/2023 09:22, Jan Kiszka wrote:
>>>>>
>>>>>> +			gpios = <&wkup_gpio0 53 GPIO_ACTIVE_HIGH>;
>>>>>
>>>>> Ditto
>>>>>
>>>>
>>>> This is adjusting the existing LED nodes in k3-am65-iot2050-common.dtsi,
>>>> not introducing new ones. We can add the color properties in a separate
>>>
>>>
>>> Then why aren't you overriding by phandle/label?
>>>
>>
>> We could do that as well if we added labels first (they don't exist so 
>> far). Not seeing any difference, though.
> 
> Confusion? Your code suggests new node, thus you got review like you got.
> 
>>
>>>> patch, but the node names are now part of the kernel ABI. Changing them
>>>> would break existing userland.
>>>
>>> You mean label. Why node names became the ABI? Which interface exposes them?
>>
>> root@iot2050-debian:~# ls -l /sys/class/leds/
>> total 0
>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc0:: -> ../../devices/platform/bus@100000/4fa0000.mmc/leds/mmc0::
>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc1:: -> ../../devices/platform/bus@100000/4f80000.mmc/leds/mmc1::
>> lrwxrwxrwx 1 root root 0 Dec 14 21:12 status-led-green -> ../../devices/platform/leds/leds/status-led-green
>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 status-led-red -> ../../devices/platform/leds/leds/status-led-red
>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-green -> ../../devices/platform/leds/leds/user-led1-green
>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-red -> ../../devices/platform/leds/leds/user-led1-red
>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-green -> ../../devices/platform/leds/leds/user-led2-green
>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-red -> ../../devices/platform/leds/leds/user-led2-red
> 
> I replied too fast previous and did not include answer here:
> 
> You have label for that... Somehow all these nodes are half-baked,
> without all the expected properties and now you call node name as ABI.
> The node name is not the ABI.

Well, existing userspace uses those names, and adding the properties
would break that interface. Now, does Linux do that?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


