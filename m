Return-Path: <linux-kernel+bounces-67045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1CD856546
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B83F1F21C47
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEBC131E33;
	Thu, 15 Feb 2024 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="V2I2tjJ+"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2090.outbound.protection.outlook.com [40.107.8.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CD712EBC1;
	Thu, 15 Feb 2024 14:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005868; cv=fail; b=E483mPv1kdjWOirB1ueaFnRbqhtOmKCuJeFph/HT8d19bWqJAylDEa2AXVMchVtSsY7l0pRMStmez2YU/by9NJFOwQrHwglxMpWjnFN7cdev8OcTRrkCr2M/hGyo09MrrnxKIu+TDPjEg8nnSddJ5Sni3922SMHyxYZwlEWTULw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005868; c=relaxed/simple;
	bh=kvsX0XUf9L3f37+I6ZIlu6mTO1WfCENZPRWUL2++8oQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eH3mLJWxuvx+/Bhoct/GzJ/BeD33xa+qWgNOD31aHVkRyjsAsghChFuniQW/T0qWSPcahDh6m5zQ832JZ+sK92m69bd4zI/+FWzqlP8eOqeeu5HPpJ5ycDhJ/ZAfGcRbq00eRjd6ZFBLbkevNOuiAXPpxvP78tWbm/mJsOodPo8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=V2I2tjJ+; arc=fail smtp.client-ip=40.107.8.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYq/mS/rJPde3y0YfWE48Zqonx2rJLvjuM4yvNUl0DNtXceOZw1yEepnKlO5Cw2N6A9hdhPs1FZN4UhdLN0ehpupTIhR5lHoTICi51e5ua07vRvONMge4hlXiTpW9m3zp9COLih98OD7ss+Z+TnFkWIfFWJF5gsvU/y+mEiE999aAKsw4cA0qGalIt+D4HO4hlhMbhW8HlDz6JeR/uXOBX7E+qTgo79KPM8JPPXWYhTh+QikvpwSIIzWI0mjdPxdzmlQqr9K16gqnp2Gt54VMNWQTa7R+ulFzSAwQQTbdIRHrUQBxFc05qqAivF+Y3t2a4YjILsjnC4bTAoXfgrk6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5T3YgzsoARN3XsgdN2LsCFISddbkr0VlhUYcOz+4L5Y=;
 b=RzuWKvhbAwB6CzKE3QQRX18o6bNug4AbkcYEUekbwRXxkMTKDIW1P1lbnXiE53a2YVfWi+hifKjxN7HGvyn5uIXmL5g5I/jYE48tJiiB/d8rcUkSQAmSLenA+tb3OxF9t5W8QP8cgYQk0QWNi3lHXrexGB9sCXMm35HSd9SPQ1lYxxWnEL0x6+UHWhUkbqohlDFvA3WCdDtPjBiTpyDHHguIWbIa5/y4Q2UqlfSangn4nQqgc0PDghZoiIiTujSbief9opNXEXuqeznXU40KThkAcHIEd9d6Vg8zUOAyfVAZs9SqR7/HFVftVSuC2C8pGOOlyRQrSPYHszu5GpD0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5T3YgzsoARN3XsgdN2LsCFISddbkr0VlhUYcOz+4L5Y=;
 b=V2I2tjJ+ALOj4PvuRAyTmsvUU7P6u1dCo0vhKX4p11PEVRyB+UCkJdRgqPZEUj8rR66H3+HvlGu3X/AmVC8ccrl4nshiglg7mehYTg9SdaGhKrg+F3GqR5GdVAkSBTuwO5gYpIX6THvR+okJKjudA2nfRG4wnISvfc2rVHuMyZ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8581.eurprd04.prod.outlook.com (2603:10a6:10:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.27; Thu, 15 Feb
 2024 14:04:23 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.039; Thu, 15 Feb 2024
 14:04:23 +0000
Message-ID: <48f04999-687e-41d5-a0c0-0cfed481dc50@solid-run.com>
Date: Thu, 15 Feb 2024 15:04:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] dt-bindings: rtc: abx80x: convert to yaml
Content-Language: en-US
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Alessandro Zummo <a.zummo@towertech.it>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Tudor Ambarus <tudor.ambarus@linaro.org>,
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>,
 Yazan Shhady <yazan.shhady@solid-run.com>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
 linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
 linux-mtd@lists.infradead.org
References: <20240212-add-am64-som-v6-0-b59edb2bc8c3@solid-run.com>
 <20240212-add-am64-som-v6-2-b59edb2bc8c3@solid-run.com>
 <2024021220055301ade3d4@mail.local>
From: Josua Mayer <josua@solid-run.com>
In-Reply-To: <2024021220055301ade3d4@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0006.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::9)
 To AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 9db4cf98-463e-4b80-0e69-08dc2e2f0310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ylkYSAu9OwdPybPmPuX/VM+vZec2Hgcca307eP1z0OWFYUZNvPzbgiEicEEBw79hcVlGXnwdaYOVBv0QOxAB5x/gx9e4dJBAFq8kKJfB6LRoMNiOg8sM5RtPak7xB7i8lxk0p1fRtJlGnDEIcB6TRFXDqb6mVXL3/fGwZ79+va+biiGT/PZHh0WFSZ1SpMVhwSfULzp6Cks7raN1w7FEOt7RhLO1cD+0P5syCO4WsaZCPH8gFoowIQId2yVIg1NggMLWOIUckqSTVuO5KupGNAqGKvVrcDMM7I/GmkHuIsl7R1qzuDh5utLyKH+O4JswKZxIQtXpv+kGyszoiE0691gg13UhUqlb/ga/VLCC8uLDgqOIxWhfPgRRPLAHuTOe+U3mWHk588PcUaE+mMjcmTo9yalbfd2VEbkLSf6LVyUfgG4awkYj2AJGFnnAHh7xdPGIGXnTCBSlvecuMaSBUrnPTghRymMRolKaDDo/kRYLl5FdcCO8DELcNpqJ3ZFWg+6ctNknmzbBQ3L2s1zVcPbtGd/ftugGFEzmgRRkHbI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39830400003)(346002)(366004)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(6666004)(6486002)(6512007)(478600001)(41300700001)(966005)(7416002)(2906002)(8676002)(8936002)(5660300002)(4326008)(66946007)(6506007)(66556008)(316002)(54906003)(66476007)(6916009)(83380400001)(2616005)(31696002)(86362001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L21kNHRQODRSWVpPeDdFVkNKMlhzUkR3QXFLOXZKQkVNL0U3d2t5eVBkS2hK?=
 =?utf-8?B?ZzY4bXRra002aE5yNG5PTkdJaldWNUNDSndlMUJsYmhKRXlwWi93cS9DdmZB?=
 =?utf-8?B?aGpRdktHVEk3SDRtbWZKMGpXZHZPWlU2ZXhIL0RsR2tLTTBJWnVWNm5aQ2Rl?=
 =?utf-8?B?ZHlrQm1vRW5tMFZnaG85UGJLRjZLbUdQUVFxL3NmNXRIak4xVkhLVGhtWm5G?=
 =?utf-8?B?VjYzdkduOTZERnU4cTJrWnBpNVViNE51ejMxeWxwWUZ1MHhxZkRUK21lK2Y5?=
 =?utf-8?B?REJoWUE1Y3BVM0JxSW1zZnVJd0xCNy9yOEU5d25yYkxNK2J2M2duWjNTeEVs?=
 =?utf-8?B?Uit6a1RsS1hmdFFhcVdjTENnUDJabW1mTGdSSkRISDRJUHkyM0J3OFo2Z20w?=
 =?utf-8?B?UVVvbUl0VktSeWNLSmF0d2N1dlAyYzlBU2J2SHY5a2ZpRHZNWnFBN1B4dURy?=
 =?utf-8?B?RlZwR0NuWG94V3hYZC9DZk9ETjZxcldkVDhiU2xMMTAyMXY1WFgwQWFXY29M?=
 =?utf-8?B?Rng2RTdFKzBKbGVxU2JvbkVDc3dzZEZWMkJDQnc5ZWFlOGRHVG8vc2hkYzJz?=
 =?utf-8?B?MS9FV3BqZ3Q2endyaWZvMitNbDFzSTJaSUZ2NkpzYXArZ21GSDF2Q3RzTzNh?=
 =?utf-8?B?alJVcWF2bDdETHUzb3lTUEFjWlhzSXlkdnc4RGwzOG55MGFFdms4QVVLdWRQ?=
 =?utf-8?B?R3VXRW5INk5vNFhqYStoMk1Ua3ZNUldMeTlNZXZOaGxFS0hFNTZVdXVuWkxT?=
 =?utf-8?B?TENJY3E5QnkyMTRDcDByUGRqME5sQUxkaXpHazlxVGRtd1B5N1RqMHI4cDNs?=
 =?utf-8?B?TmZCZDNxYjV0VFVmYWpUNk9kSzM0SkJoOTJhNnU0bzlTU2ZGeFRNWHk4SHdJ?=
 =?utf-8?B?ZHhuUmlWUExzVDFpM1Z5RkJhN25RTWloQzk0dWw2eUtwNUUyV0RKSzBDbUFU?=
 =?utf-8?B?UlM5OUlLY3ZwWXFnNGU2M3hBQXkrckV2bU9yeG8vRm9yNTV5ZndZMU5YQnR0?=
 =?utf-8?B?WWgwVFhtSWhGOW9lSEpNSFcvTWFORDNCU0RIK1QwTTlKQjZxMGs5cURhdDMy?=
 =?utf-8?B?enBLYjNZM2lRbkl0ekZDaDB5dDFDUFREQzRkVWFZM3JFSzZON1RGdW1iNUhx?=
 =?utf-8?B?R0VGeURYVlhCSkNENXFEdEk1ekp2anFlNVV0OWthL0lUYlpUeTR3MGZ0MGo3?=
 =?utf-8?B?ZGVIVkd5T3N3VjhsTTdFTlZGVG54K2JiNHUrMjZaekppYzltQ1pGT24wMDd2?=
 =?utf-8?B?SzY0bTFuYmYwN0tGZzB6RVY1RXc3Q3kvZkdYWTM2c1NEaW9MZWIydUVwMEV4?=
 =?utf-8?B?a1gzL21IVUxrRUlhV3hrbkpCOGE4TkVHanl2SjBxQjdCeXhTYXlla2hTUkNq?=
 =?utf-8?B?WHg2czV4M2tLUVJDOHFMZmdaUWR5QStoRkFGMGVMTU5tRmU4T24zMXVWRjdN?=
 =?utf-8?B?ZjdiMEQ5dWJlMlJXR3JJTFVGWThUaFBndy9TYXVTUGM4RFEwZGVNekdlUUsv?=
 =?utf-8?B?QWJjZlJLK0x6UExMOWxiTkZZMjBHdkZ6cWlxQTJFa1MzMlNTYTkraVZ3R1Bt?=
 =?utf-8?B?eFNoUWZhR2ZrY1NXYmF2R0hKdVVFUWlPNDBWbzk1dlNmZHFpV0VzL1dac2pP?=
 =?utf-8?B?MGlodWJzVUZyWkNESTVtZkFKVllvd21GQXRKaUVnTWNaWkJLTUlFYlo1UVFW?=
 =?utf-8?B?Tk42RWxEUldlMktqQ1RyR2gzOHFaWG1DTEU0NlVaSnpaZ2hndGs4MzZEVEtV?=
 =?utf-8?B?OWt2K2NlN0xad1BLMUY0Q3hzSXRZcXdmM1BUdEdOM1V6d1R4VGFISm11QUFw?=
 =?utf-8?B?eXFpenFHbXhPQXNKYjJnNVJKendud3F1TmFNaDY3eFl0UExoQmdjRnE3b0l6?=
 =?utf-8?B?R25MejdlK1pwUk5XemM5YXFjLzA2Smo4TWdGR2NhRlBnNFNzNHpTSW5ZS2tw?=
 =?utf-8?B?Zm41aTNsUWZhazNJcHdpclozQk9idVpYYnZTS1cwbnROU01uaDdKd0RmWFdp?=
 =?utf-8?B?M2dOTE5WWHhZUkJhVUpCdk9sRlJMVTJCYWsrb0wvWWo3eTAyUGNNRmt4eUN3?=
 =?utf-8?B?aTdaQ09LemN5aFg3VmcycXl6czhwTVptUm1HV095M3pNR3BSWmxjSWw3b016?=
 =?utf-8?Q?iARARR9NsGIY1mES89fOtqhGt?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db4cf98-463e-4b80-0e69-08dc2e2f0310
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 14:04:23.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sw2L7YY15QybVz7DyDn6O9F7SQ0vhukl984YRP8pwIF0lOJdSEteSpGPCM31tgCjSYiRY72cH8miQ2eVm11bvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8581

Am 12.02.24 um 21:06 schrieb Alexandre Belloni:
> On 12/02/2024 18:38:09+0100, Josua Mayer wrote:
>> Convert the abracon abx80x rtc text bindings to dt-schema format.
>>
>> In addition to the text description reference generic interrupts
>> properties and add an example.
>>
>> Signed-off-by: Josua Mayer <josua@solid-run.com>
> Did something change since v6? If not, why didn't you collect the
> reviewed-by tag?
I forgot about seeing the tag by Krzysztof ... which is why I didn't 
collect it.
Nothing changed since v6, so this still valid:

Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>

>
>> ---
>>   .../devicetree/bindings/rtc/abracon,abx80x.txt     | 31 ---------
>>   .../devicetree/bindings/rtc/abracon,abx80x.yaml    | 79 ++++++++++++++++++++++
>>   2 files changed, 79 insertions(+), 31 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt b/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
>> deleted file mode 100644
>> index 2405e35a1bc0..000000000000
>> --- a/Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
>> +++ /dev/null
>> @@ -1,31 +0,0 @@
>> -Abracon ABX80X I2C ultra low power RTC/Alarm chip
>> -
>> -The Abracon ABX80X family consist of the ab0801, ab0803, ab0804, ab0805, ab1801,
>> -ab1803, ab1804 and ab1805. The ab0805 is the superset of ab080x and the ab1805
>> -is the superset of ab180x.
>> -
>> -Required properties:
>> -
>> - - "compatible": should one of:
>> -        "abracon,abx80x"
>> -        "abracon,ab0801"
>> -        "abracon,ab0803"
>> -        "abracon,ab0804"
>> -        "abracon,ab0805"
>> -        "abracon,ab1801"
>> -        "abracon,ab1803"
>> -        "abracon,ab1804"
>> -        "abracon,ab1805"
>> -        "microcrystal,rv1805"
>> -	Using "abracon,abx80x" will enable chip autodetection.
>> - - "reg": I2C bus address of the device
>> -
>> -Optional properties:
>> -
>> -The abx804 and abx805 have a trickle charger that is able to charge the
>> -connected battery or supercap. Both the following properties have to be defined
>> -and valid to enable charging:
>> -
>> - - "abracon,tc-diode": should be "standard" (0.6V) or "schottky" (0.3V)
>> - - "abracon,tc-resistor": should be <0>, <3>, <6> or <11>. 0 disables the output
>> -                          resistor, the other values are in kOhm.
>> diff --git a/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
>> new file mode 100644
>> index 000000000000..58dbbca27deb
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
>> @@ -0,0 +1,79 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/rtc/abracon,abx80x.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Abracon ABX80X I2C ultra low power RTC/Alarm chip
>> +
>> +maintainers:
>> +  - linux-rtc@vger.kernel.org
>> +
>> +allOf:
>> +  - $ref: rtc.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    description:
>> +      The wildcard 'abracon,abx80x' may be used to support a mix
>> +      of different abracon rtc`s. In this case the driver
>> +      must perform auto-detection from ID register.
>> +    enum:
>> +      - abracon,abx80x
>> +      - abracon,ab0801
>> +      - abracon,ab0803
>> +      - abracon,ab0804
>> +      - abracon,ab0805
>> +      - abracon,ab1801
>> +      - abracon,ab1803
>> +      - abracon,ab1804
>> +      - abracon,ab1805
>> +      - microcrystal,rv1805
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  abracon,tc-diode:
>> +    description:
>> +      Trickle-charge diode type.
>> +      Required to enable charging backup battery.
>> +
>> +      Supported are 'standard' diodes with a 0.6V drop
>> +      and 'schottky' diodes with a 0.3V drop.
>> +    $ref: /schemas/types.yaml#/definitions/string
>> +    enum:
>> +      - standard
>> +      - schottky
>> +
>> +  abracon,tc-resistor:
>> +    description:
>> +      Trickle-charge resistor value in kOhm.
>> +      Required to enable charging backup battery.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    enum: [0, 3, 6, 11]
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    i2c {
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        rtc@69 {
>> +            compatible = "abracon,abx80x";
>> +            reg = <0x69>;
>> +            abracon,tc-diode = "schottky";
>> +            abracon,tc-resistor = <3>;
>> +            interrupts = <44 IRQ_TYPE_EDGE_FALLING>;
>> +        };
>> +    };
>>
>> -- 
>> 2.35.3
>>

