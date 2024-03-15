Return-Path: <linux-kernel+bounces-104011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA1987C7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D8B1F22CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5B3D51D;
	Fri, 15 Mar 2024 03:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="uIFbbWoV"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C84FC02;
	Fri, 15 Mar 2024 03:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710472409; cv=fail; b=NM6KURRl5xi063aOGGFqAZBmKXVmYDFifAxtNHUUu30fbSaMLgVoZdWvT8VejhGHw3p+Q6NcgcnkRzzmxwIrfXWaxaBlzUSKQ+f4cT1nQffHFI7Ok9rswmSoFquxBssCzi6lDUctUHFWJdIpWadKCjKVpxIb/wEg6PSwWxZXoOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710472409; c=relaxed/simple;
	bh=b2kCuWJlGp5XsqXNzPywhnMaWAUmrJG8NB2zey55nuk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DQ0JqDVYFAf6a8cP3hurCHVvPjylAQobOSqWFmLVLqW99vk1OucQeNsG9XKdCVLnkOSc5+0nXi1rUfTNEwMB84qYj0HV0XlCcbq4DdY/IzVsKZjK91J1uy+8KbqpnGctaUK+BZvCvVcq1pGLKajrDS3N3EKpRm7+sQltsj95M2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=uIFbbWoV; arc=fail smtp.client-ip=40.107.117.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8YTRWukrZaaKZfoyBGl0iqrAP73fEhwAWCY4MZ6S15PZMKrUC6eFAq4MROTTFt8rghJ/+ppV8sE0FiLtAyxl0ur2gJGYlmEfWJPX4cyB/7+BmEveb/h9y5T0qlXPYP+ECjC6qsg28NxG5HHlAUFSmU1lYW4NCX0jokrJE/r6skIbGVhaMJoeJJps93IFIz0HZ/SVrne1hnZsnDpAZ+UaAx64Atni+npROckFc/FOYoqK6JtSYCkLckIwiVmUDNxwjuSedZKVchlasGUHVcox/YyaTHpamk23NiEXCGqJIQ/KaDrh1VTK33An8P0dPtIJC5IGt3/jYodvvDDLXN5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHMy+e92IDXppzU96t02OfW6rC8tZr/0CMlhClx0F68=;
 b=OfcEXDmyJXvqVGAzt36pOcckVLCJFHBd/HeSl0qaj3xiUi503hupFb4q36yWHtSedYt77kyeqKDLwhwCsz7qT9ihFK/yZWCVL2yUHxAKNvjGvw/DW+Vfu8OptmElORCxxqeFkCwlGhV1ScNkMRKGBFZijWRV0tN3DCHwYy1RJQM86XSfsJa6lnO6EfKcR38MZg7IxLO6gWajrvR+C2kqtVFtOQiO1h5Dx/q3Mve0g9vx9V8f1APtqrxsBzuWcqh4o0EoCnSpb7moHS4GbPx3T0FlzjnQrZyKgn+cyD9fsa1bvYBodfJ+WrBqc1OpcjOmWRQlgE5HbRblzXzVUcOsqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHMy+e92IDXppzU96t02OfW6rC8tZr/0CMlhClx0F68=;
 b=uIFbbWoVAjpg0cFghXo6zeYgWYt2x1f0AzJ35WB/5BDHi7mw/zrbjjKLvUt02iIlLFa1uqtYCpgFLuUp/tJ5QhjXV6VZDnn4BjBcB7BTJzOu8LmcF/VKtxsQjK0TLkDxF63h6Iwh8bYy850d90ryIOvkrH0+llfzSbAkngUze9DR3/ZHmf1BZ/aZ9JfDG9331OR0aaoCDt4yHmhbRSX0jJUpxu2ou436EcrpiTZwIS14ELsbp7Ms8m5z0Phtu8+R5pO0BOIzORJT+Vps1krZvDqkZfd10PaD5h3w8NG8aYXijHAimRL1BjEjjzOp7XG9qXlCiXLk5Eqdh3wbB22yHg==
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by TYZPR03MB9049.apcprd03.prod.outlook.com (2603:1096:405:e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Fri, 15 Mar
 2024 03:13:23 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::5198:1b2f:8889:17b%4]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 03:13:22 +0000
Message-ID: <b1d59c5e-26ae-45a8-8677-13d2bb5e9751@amlogic.com>
Date: Fri, 15 Mar 2024 11:13:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [DMARC error][DKIM error] [PATCH 3/4] arm64: dts: add support for
 A4 based Amlogic BA400
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org
References: <20240312-basic_dt-v1-0-7f11df3a0896@amlogic.com>
 <20240312-basic_dt-v1-3-7f11df3a0896@amlogic.com>
 <20240313095311.dxrr7gvt4t3gwoho@CAB-WSD-L081021>
 <74f96887-572d-47eb-bce4-9d61ec51b88d@amlogic.com>
 <c0e564f1-bfd9-450f-8bce-835837719688@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <c0e564f1-bfd9-450f-8bce-835837719688@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:196::7) To TYZPR03MB6896.apcprd03.prod.outlook.com
 (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|TYZPR03MB9049:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pAMvUWoPeBdcnnjuxgXOod+qbulTqUVjnFztJR3GzuRQPEFuf4Pv/1Y2sXzsbvuo5FMsCluvdQy2SWowybuIbWLsuwVdRzMy22Zv3ybKdhXsIeOQYEXu7T70sIpjcM0NsEaG9YXovUXMMKvQ+mQ2y4kEagP898a7mMnuiuk2koa8oByqz04pAGtmz1jc0+ziqdap+5ljXTThiOhGsDKwcUkaZMKnWKwgSg1OAR86G48Et+mZyd9tINu8ZnKMn6gl4XGCs+J9JVcjkOP7E56kvn5rGD4Dajx2ohFZMhlaECfzB5eKgteuxJtli4MK7BJcycKnjXlp9mXrMXhXNE3+IW4FJ5dEpocny8rg6k+3uBNVogyp3aZS6zICyE7xbTKmltjMmKk+0lSasM6A7Jajd7KQw6mY08NHVhJQF7aPMAo1kMsJuPFMlgUhwtx5fjNkoeXyCS5Dh9Kjw3PoB7el0di7eKbG4Rifx4PCXGbufoby8PJ6PsiJsUcrGyGzl9rfzcQA5F4giI6JxD6UCBLZ5wNYgNyDPlWihU+J/gx0T0om32/mTuRAlmRnF7+YkG//cvM9kzrz+Izl24AyrvqB0bGbNQihJA4soEDSA7Gn1clpBcv/+XvMs4G9iDblyKJ9McbxDDyGOWC+5sCk1l6VAT5bkiFePZYhVmDMJwk1O7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QjlKVmJjUlZWNUUyeG1CQ1FxSWt0UHlLbytEczA4TGt5L2pGREdLUFIrVjBZ?=
 =?utf-8?B?a25zbkcwb1ZyekNQbmR6UmNnU2p5WS9BcnY3SUFTWkU3dGYzQUtzSjB0VUla?=
 =?utf-8?B?TGUrZWJoQTFYRmZnUGRTVk5OdkVWVEdhRHFJZm01eWsycW9CUTNLSGt3TDJj?=
 =?utf-8?B?R1dycDV0amtwUXhJK2dOS3E2MUdFcFl2bzNIV2lmazAyWm5jMUpUMFR3Y0Rl?=
 =?utf-8?B?c2EzNnZQYWpnOHV3ZVBXTjliVEtBMGN2YnF0cUhSM0loaVlWYUZaRDU0S3BF?=
 =?utf-8?B?cHFNbnRiVlFBMEhCZzFvWExTUGZ3QURrclNKSEc4aEJiRVAzcE5RNmM2QWFt?=
 =?utf-8?B?WU9XMVZROUxKY1hVQ0U4dktnWDVxZWJXcExuQ252Q2VINFFEZnFzMDZrREdq?=
 =?utf-8?B?RUh5TzVVdndtQzZBRlY3bUtNY0JJdG9Xc2FpNkYxM0NQenFzSWtoTml1OVBF?=
 =?utf-8?B?OUQ5UmFIVmowQTRpWk5GQythQWpvSzlZQnQ3ZFVYSlc0dDFNRll5QlRHc3pm?=
 =?utf-8?B?VXNEeWNVTlFzcXRuODhjdUFrMXBGMm9PdGxRZWFoL2JHK2pTSGJjMSs3OGRP?=
 =?utf-8?B?OVdoQkpkNk05OFFqbVdJNm9pQnZEcDdNVHJRRE82eVMvV09aaWcwVWIzdk9O?=
 =?utf-8?B?cVlVK3FUYjJCQStZZzJyRWY0OVk3ZDNYenh6NGQvVFBxQTUwc05Cd2l4RUs1?=
 =?utf-8?B?SUgrSkJkRzhKazQxbXdlUjJWa092YmpVTUVJTXBhTVlHaElKSUpLcm9OSXN3?=
 =?utf-8?B?RjkyVDdGQ1JrL3BFbTl3VThXQk9hM1llWWR4bW9OY3dqdmMzUjdQKytleEJn?=
 =?utf-8?B?ZHVBMEF4S3pRRGFSUG5TRTFkWFcwYVNOVjgvZUE5SW0vbVpUb01tL1VFOEdK?=
 =?utf-8?B?b3dJaFZHNlBKZzRDKzU4RSs2amY3Qlg3akIwSkJ6eUFNUnFrWWppMzJKMGRa?=
 =?utf-8?B?dHpxa3hiblUyUlpHeTFDL2cyRzdzQ2dYL1l4ZUh0b2pyMGVDeXdkZE0zeS9I?=
 =?utf-8?B?MkgwanV2NGtEVk1aaGRESW53Z0NvZmlCbjBLMkxkazNHUDNFS1V2MncybnBC?=
 =?utf-8?B?RmlMY0tNZG8wQWwycUlLbngySWxTQnpsa1RpY1JRZWFxREcwMmdKdDk3OFVI?=
 =?utf-8?B?dTJqcm9rYnZQQmlTVldoU29HOTRvbFhrdTNvck1ySTV4OU1BMnpQN28xNnF1?=
 =?utf-8?B?Q1UyL3lqcWNoS3NTZXphRkdUVzVPdjhmelVRVGVMdlNWN2VBTzJtYXVZejBi?=
 =?utf-8?B?cFZ4OUpTeW01YVJReVBrWVNMSTdnbmlnNERFVTcwUWtOM2lObCtTKzNUWjdI?=
 =?utf-8?B?SFErV3ZVN3loOEY3K2R5YXhQMWhtMk9lZ2dYWk1Uc0dJOEhYa214ZEdMeG9F?=
 =?utf-8?B?RlZMN25sN3NHK1REdHR4R3YyanoyTjBFV0lmeVRoM09reXplOUdyN01uQzh5?=
 =?utf-8?B?SElqN0Y1YlYxMzFTYWRrS3RVS29ialpuMUV5aGhrVmtmWHhxeWlqU3NDb1VS?=
 =?utf-8?B?TzNYcnBqcGpxTjk0bTNzci9lV1FBUUYrVnYyTEx1Vlp6VWFwdmJjakY5Y2Z5?=
 =?utf-8?B?SlhjWjZ2Q1c3eWt1WVRZb1paZXNsSmlSTTdXLzFDa3M1SjdOc2Vsb3BsV3NZ?=
 =?utf-8?B?UXVvalFvRGZ6NDZZR3hqbnN0S1F5VWVTUE5lUmdnY1kvNllnOHJDZFNtdkwz?=
 =?utf-8?B?UitzeTZsREtTckE4b2JXaG9lc3ArUmErc2JaSzlibWhJbExsLyszcUhZbW52?=
 =?utf-8?B?cTJCdWdmT2xqQ0xvWDhHSXdmK2lac1F5dldIdGttV1c4WDgwSVlNd2VwTldn?=
 =?utf-8?B?dnh4MWZCS1BGQVZJQkxoOXpKU0lRbGhDdVRvWndpMXk1SE5KM2lrM2JkRTRK?=
 =?utf-8?B?R2d0WnNEWXJnYTBaUENQTFJmZ0hmNDJScnFmcW9sY1pQSnIxL09XMFRlU05v?=
 =?utf-8?B?K3pBUFBXL0lXeFlBN3FCU3A2elMzTTVJcnk5c0dwZDFpaGhiTlJOTFc3UGNY?=
 =?utf-8?B?WXhtM0dyZDlnYjlHbEdpb2FHR1dDUWl2N002eE9ZR3dqeC90NXFvUnJZYTIr?=
 =?utf-8?B?VXRTUmFtUmkxMU1sQXZ0aXdwUXhUd3E1ekRhSmdjeHVHL3ZkclpMUm1DTUJY?=
 =?utf-8?B?anN1RW1BblZKR1kyQTFadm44NWZmL0JnUWNIL0tOK0d6QnBIZUdIWDAzMXBK?=
 =?utf-8?B?NXc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c34e65-f177-4123-53d1-08dc449ddf2f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:13:22.6465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmAT9cBUPyaiHW0OJYn+/+A1wQCveCoKHb+UHgEY4EHm/QZTepqmYI0srUq1iUXzL6okqte/fu/rVDhkipi30QqKi21sx5JBUQM/h7avqN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB9049

Hi Krzysztof,
      Thanks for your reply.

On 2024/3/14 14:58, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
> 
> On 14/03/2024 06:19, Xianwei Zhao wrote:
>>>> +
>>>> +             apb@fe000000 {
>>>> +                     compatible = "simple-bus";
>>>> +                     reg = <0x0 0xfe000000 0x0 0x480000>;
>>>> +                     #address-cells = <2>;
>>>> +                     #size-cells = <2>;
>>>> +                     ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>>> +
>>>> +                     uart_b: serial@7a000 {
>>>> +                             compatible = "amlogic,meson-s4-uart",
>>>
>>> If I'm not wrong, you need to create dt-binding alias for meson-a4-uart
>>> and use it as 3rd compatible string.
>>>
>> On UART module, A4 and A5 SoCs exactly the same as S4. There's no
>> difference.
> 
> That's not really the point. You are supposed to always provide SoC
> specific compatible in front of the fallback. See writing bindings document.
> 
Will add bindings.
If two chips use a common dtsi, and this module is in the common dtsi, 
can I only add one to suit this two chips?
> 
> Best regards,
> Krzysztof
> 

