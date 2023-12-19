Return-Path: <linux-kernel+bounces-4934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D68C0818409
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F6251F23F08
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D204812B61;
	Tue, 19 Dec 2023 09:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="IzodHQB1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2087.outbound.protection.outlook.com [40.107.104.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556C12B78;
	Tue, 19 Dec 2023 09:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwvkTPbNDVnebaTt4wu+aTCQLQIkHCfHCYoKTigfgKOw6+UXMV71RuvAwC9VZDcvEO5KEUixpQJ4KIVchtMqCR4Kd/OOWcmI11gAsBWjUdfz1vlJkrY0GkrW5z8+6Z6QZAjYQWlsvo5xCigF6bDKuGTGGvOWGIDQyVaS+9enl4Z0XjqoXOUkcoq/ddSTduu7pltyt1go2ZoDw3jFz/6c9vAMMoSOY656yXBSyrdnpqs/4J417pV1NhRhc2ilUbPmC8/nL6SD+OHddY2Hf1LXTXqjoqi04pibCltmnTV25/ukR49QYMFBFy/hGpG0CKYPCy+IxEcyBJ+AR5bj7sNzAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5YAJ0U5JNeAzORse94uI3+3yxtjkoy1KwuCShYKk3s=;
 b=YB6RXFuH0PHWYdzKriqSQ/nft2VOPAh0jYJHsJr+/KO8xAfJh1to9XylfmO/iyLa2/QuNyd9E3Nq7JTKi/aZlvKNGWNIWRJXi5RwFN/sdXB28PqnWOvR8aS9m0qDbV31m9Nji50LSpR1/dyT9LkC0gTv4fKJ9tKjSdTCULELE4OIcss6uMPCZqiMSNINI/x0/ci6wSut9Rz/V0chc70IHjp2JgNtUdOyDbm+RkRnK4o2a5SwiaV5qFViZPFeySB/+wCpU4GhH2yizrI5fIOU6LNq6LjmZ5Ln0OEcVGj+J2imgKBw6kmfMSpiK/ls0Eq43aVO/KhTMMB2goelO8EYEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5YAJ0U5JNeAzORse94uI3+3yxtjkoy1KwuCShYKk3s=;
 b=IzodHQB13xAoor6YQZfL6ayndLP27TGbXHT/yvjsc0GEHhbyeK3iEekgfOfe8Wt3vnM9BieW5+gthQ7Od0vWFNdkzsT2Hx7BLve+ml7xWnFuW/1OnVgB11ntVY4DeQTCatv06dVkXglXx6r0r7G5GpDoTP4zM3LreT3AcI67sO37oPwxI6SIngJ6jboRetsSovVvmPAhIpoTc2PzbIfyElp2eCTDqkZTjhiWFZ7ykfTWpGzIPzUJSWZBgssauo+V3VLLASjUEgjyygv1hwx6+mhbgHwZrpjP/vm/nYQZ2uPBvnYGIj7UsKW8ZlSF8EvBro+JVs+0gbxU2zSrFaW31g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3210.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 09:04:04 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 09:04:03 +0000
Message-ID: <de3f4778-51d6-48ab-9d4d-451f2ba01a3c@siemens.com>
Date: Tue, 19 Dec 2023 10:03:59 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <fbb29d81-9ea0-4468-ad47-f6668c2be277@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3210:EE_
X-MS-Office365-Filtering-Correlation-Id: 310f9d3d-c3d1-47ef-5f22-08dc00717249
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VmHn6rLHcZH32AhP//VJJeA8ropnj7Rp9dJM46YnySJE0a0w/vo4V+g3wxCr1Z+lkUxD6D3dUXR2k71BfExYzcTn8hU3YaiYKWrIR0K2PhVfrAUIErYMeTTRqvPQrjXkhbzi5FhFBxi9A4CpylDiae9XvcJl2NRmW6YNAWXEaQ7lovdbSYCGrQvWh6XGbFvMa/h2UZJQl30/dU+VhS4bWlTlIZcKJSkEYVxJq75AmDRS8KOtIMTs96O/sz2RNaSse5mTVlaQekb93QYeO36hqXQ9DABmuJYVZq4BV7BjzNwFpyOj7XUOkkHg8UzAdGS91BlItfFp4FAk5uKJupcJHaPbYz17VXqIkYZWmH2Aert0fI8KiZ9jqx3KWn0DToPVi5n4baUpByJHV/4ULTQWdnHq1/El/uBkxUP+AsEtShMlnstDTSVVpvO97I+LtKFFXT7Pj6kHgOH5rPGd74PGMsxYaNsGgUhY19dnS2jhnvkoeKwdJrmLfrrU0Vtb5Jb6pbzXz15zrDxbGxje7Q1mHjfLOqzjrbLZnAcwfgWgXxAeYMzmoi95OoU8ur8LT852ZUZrETCW3IrzxT9IcPpz6moE5gDb6jyAKyF2mM9HTnM1h6hK1PZZ/cSVBoppU3K42NOkxnYr2tfdKlvAyV5evg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(44832011)(2906002)(4326008)(8936002)(8676002)(6666004)(6512007)(6506007)(53546011)(83380400001)(316002)(110136005)(5660300002)(66556008)(7416002)(6636002)(66476007)(66946007)(38100700002)(82960400001)(478600001)(2616005)(107886003)(31686004)(26005)(6486002)(41300700001)(36756003)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?allCZUlvME16ODV2R0hLSmdqTlRwWEYyN1Rxa1VCSWdjMmtocWtTMWp5WHJ6?=
 =?utf-8?B?ZW83ak9Od0lRTGJ3Y2JYcFpmOFVHVy9aR1l4UkxQa2Z2dTFzd0ZIY3ZSWXJz?=
 =?utf-8?B?REZnRTQ2bnFMOVRMR3hxaTFoZEpDcU8rSDJoZkxwWWJnUEt2dVpMcHd2QWM3?=
 =?utf-8?B?bjZrdTErcVZkajNXMExRWXRhL0F1eXh1UnU3eVA0akhSRWsrTTJibWI3YTBu?=
 =?utf-8?B?L0FMOGg2NXlzZVMwL0dYVUI4Qng2blFhS1d6YWYyanZhMTZNWlZ6SStPaEY0?=
 =?utf-8?B?RFRsZWIzL3hMNnlXS1BYL1JGajJzVmNiK2pVYXVoYjJ2Mm5LRGNpbDhoYjBT?=
 =?utf-8?B?NUZGTWNjdU14NVRxeHdDWEdNMmRteWdDTURrakhsWnJla1lqRnVsTjd1MjMw?=
 =?utf-8?B?TmhLNlFpR2tLemRiZ1M4Y0Fudk9uQW5yNnYra0ZNNStBYVU4cHRHbTdWSUZx?=
 =?utf-8?B?QmgrcUVlUkpRV2RlQ21ZY2draW9YVTNqMVdYTXk2ZDYxU1pTdVp0TEVpKzBm?=
 =?utf-8?B?T3cyQXMrRzVlN2swUmFIelpVcEJhNW9SN1ZSOGZESkRaS05wQkJtNXhEREk1?=
 =?utf-8?B?dFNSOGlMSFROTk5SMFF6THBDOGdJNWUzaUxUbGs4WEplYklSOFp1Rmt4THQz?=
 =?utf-8?B?ZXNqNWJYRjZoS3RHSm40Ti9vWlo5WVdsMExKcVRPSHNXL00yZXZvenQ1TFdp?=
 =?utf-8?B?OVZuWXMva29hOEdQcWtXOE9hNiswVkI3OEt5M1RtSUxucGZHUEh1OFBhMFNI?=
 =?utf-8?B?anhHT25Ybm05aVIvYjY4bFdUMEt6djUzNU4xVVQvSTZLM2hiNG9kNjdkUTZn?=
 =?utf-8?B?Yi9iY3gzSlBxczlwdE94aGVwZXY1S1J3S1kvMlY1ejFVWWVhdmtIQXN3ZTFm?=
 =?utf-8?B?dW9rd0tRYmg4L1czM3ZJYXVkbWQ4R0h5M1l1Zzk0UlJKTW1IWkwzUHAxYVpE?=
 =?utf-8?B?ZlRJZTgvOHJpTGRWUVk4dE5BUjI0MFRHUUx6OHRzSGJRdHVENGlnRTBMUllu?=
 =?utf-8?B?Y0x4cjU2RDB1dXJsZ3VoTzlXS2N6RHMrUFJhMXNVcHNsUTlOY2I1T1pZTzFn?=
 =?utf-8?B?bjFFQ0dkemtJRzVJaVdCU0lRQVFKQ1hVL2ZoZmNPZXVEZnZKaFZRRk0yWlpP?=
 =?utf-8?B?a2FPRkNGZUV0ZFlRb3M2VTRiOVBXaVJFSk5JUS94cDVFeFZ3VU1GSys1bXRa?=
 =?utf-8?B?MzFkd3JiRlBwU0EzaFF4bU91eUZDRzJRVlY0eitxQkc3NmwrenpnL1FBakZo?=
 =?utf-8?B?N001UE9YQWVEWTEwa2g2NnZzNXI1U2N5Q3RWMmNWTUFNQStuUzVWVmloM3JN?=
 =?utf-8?B?RVBPYVBHM1BSRmNoa25lbFR3UE8wMUE3RXFTRlV0ZDRHQkRGaXpqMDJrcTRq?=
 =?utf-8?B?NkxSQXNWRVd1azlLdFpXZ2g0eVhUbENNMlpRRm01Tmx0cnNoWGhpRWIweGlX?=
 =?utf-8?B?RjlFcmNxZmZoZnNKczBVcWd5MDhIbFZCTE1TTXBHbzI3em5Td2JXeUhmc21Y?=
 =?utf-8?B?bkU3SkpiWngrWDlvMzlmc2twMURqYzk5WWdwU2I3RVJjZFpZeEgxOExWTnI4?=
 =?utf-8?B?OXNhWUdodjJnQzBndjNMbFJMZnZzOXFOeFJnQnpKZmllVmpLenJZTGVzNnh5?=
 =?utf-8?B?NERRc3paRnJLMDVFNUVwSFJYSkFOcHozbGVqSG9TdzRGS0FiQnhwSElkMlUr?=
 =?utf-8?B?OW05M3pSekVnNE1BNmhHbExxSE5TK2x4T083RGc4ek84VWxhQ0dNS1VKVS9F?=
 =?utf-8?B?N1FreG9PYmN0amtsdm1wZjJGMncxUFJKbXBlbldsblJQNFg4YnU1ajBTcytM?=
 =?utf-8?B?N05iNzBpQlVEMXJUWkZFTW50OXhxOWthNUdVanVOWUtpUThVUk8ySDRFOEwr?=
 =?utf-8?B?dmVVWVJ0Y2t0akN3bWxDMUROSnNSeUNEN1dHNXk5N1BKK0xoK2oxNnJtNzM4?=
 =?utf-8?B?dTBpRUtZUG5DdXRCYzdyckJrbXpzckpScG0rSlNwKzBQNU1VV2tRRloyTkQ3?=
 =?utf-8?B?SlZObTVzTU1oMDNDaWk2b2srQ1haejVGanpSYVFka3BJelRHN3lZdTFzYUc0?=
 =?utf-8?B?Kzc0bndPamdJQ2F5ZGN2K2FNQkVIbU9TUkUvWHl6NE1MUDlieXlNZ2RVbEFu?=
 =?utf-8?B?VDR2bWpTMDc0WXprMjk5NjkzQ2s1bWd3WEJVRzRkOVgrRlc5M2VsQVRkekk3?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 310f9d3d-c3d1-47ef-5f22-08dc00717249
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 09:04:03.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKipVp/cjsy8It6lCNKCgVTp6OC5DptV3JBPB75ENnyUuUoaJpwRZFMiYhl3swpoeCY27dN+Ar1YQ+t566FVtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3210

On 19.12.23 09:48, Krzysztof Kozlowski wrote:
> On 19/12/2023 09:22, Jan Kiszka wrote:
>>>
>>>> +			gpios = <&wkup_gpio0 53 GPIO_ACTIVE_HIGH>;
>>>
>>> Ditto
>>>
>>
>> This is adjusting the existing LED nodes in k3-am65-iot2050-common.dtsi,
>> not introducing new ones. We can add the color properties in a separate
> 
> 
> Then why aren't you overriding by phandle/label?
> 

We could do that as well if we added labels first (they don't exist so 
far). Not seeing any difference, though.

>> patch, but the node names are now part of the kernel ABI. Changing them
>> would break existing userland.
> 
> You mean label. Why node names became the ABI? Which interface exposes them?

root@iot2050-debian:~# ls -l /sys/class/leds/
total 0
lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc0:: -> ../../devices/platform/bus@100000/4fa0000.mmc/leds/mmc0::
lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc1:: -> ../../devices/platform/bus@100000/4f80000.mmc/leds/mmc1::
lrwxrwxrwx 1 root root 0 Dec 14 21:12 status-led-green -> ../../devices/platform/leds/leds/status-led-green
lrwxrwxrwx 1 root root 0 Dec 19 08:55 status-led-red -> ../../devices/platform/leds/leds/status-led-red
lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-green -> ../../devices/platform/leds/leds/user-led1-green
lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-red -> ../../devices/platform/leds/leds/user-led1-red
lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-green -> ../../devices/platform/leds/leds/user-led2-green
lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-red -> ../../devices/platform/leds/leds/user-led2-red

>>>> +
>>>> +&dwc3_0 {
>>>> +	assigned-clock-parents = <&k3_clks 151 4>,  /* set REF_CLK to 20MHz i.e. PER0_PLL/48 */
>>>> +				 <&k3_clks 151 9>;  /* set PIPE3_TXB_CLK to CLK_12M_RC/256 (for HS only) */
>>>> +	/delete-property/ phys;
>>>> +	/delete-property/ phy-names;
>>>
>>> If your board need to remove phys from the SoC node, something is wrong.
>>> Either your board or SoC.
>>>
>>> Any removal of properties in DTS is weird and unexpected. It deserves
>>> comments.
>>
>> This goes along disabling USB3 which is by default enabled via
>> k3-am65-iot2050-common-pg2.dtsi
> 
> Isn't this mistake? Common part enables only these pieces which are
> working in common hardware SoM. If your common part of hardware, which
> DTSI should represent, has USB3 then why is it being disabled here? If
> common hardware design does not have USB3, then why is it being enabled
> in DTSI?

It's a trade-off between adding yet another dtsi for those widely 
common bits vs. adjusting the differences of only one variant from 
that. We do the same for the Display Port so far.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


