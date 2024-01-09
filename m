Return-Path: <linux-kernel+bounces-20615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E55A828277
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47CB61C235B8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F9D25757;
	Tue,  9 Jan 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y5j1A16K"
Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2061.outbound.protection.outlook.com [40.92.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCDF6FD2;
	Tue,  9 Jan 2024 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmYKV9/fRJN6w44RfB9D9vEOOklWYNFsmB179UfiaJlw21G/hUfqN6vGNJ3oX10Qah3+wW4ajIU7fO/hDD/4c23ICG778GM0Zv/UkrDPTwUArUvFYYdj0aewzxtAu7ZOUtpKeaB4cNFxWplPximuzwL8l8T7pCW/5wViS2YtQ8nJ2UjSq9nosEc4CNYnHKU7I9Xqqwlg5LGL/dw3vWZlGCBeWy++eG3KgJhbDhaRP0u3z9DMgsWW7jua0kOLmVgortSxqmOHRPMpoPyYh9WWmiWBt+l968Xx4Jd4xICdJAv8EAut/6dTdwck4RH563HGk+oJylqPRFKJ6HNUYhWP9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30UmF/SNZGaBDpLXOd9bkZ8kYK9TcPvasrHM8HXBBQo=;
 b=HE9JVerKjg2pTPN13WmSvVjioqLhwl05EIqQdh5ZaXm0Rq+hGG1PRat+4nQ6p3T51gRo9rX6JcmgILjNiZi+mZa/y5pa/X/JT+X0zz7uezphgyY0EhaqzuNTGTDOYTnECsk1NAhlLK9TN+BCIgcYpON/M3ekR1i+TWeFj88AsYHAmd6SmiFDM0zNQQPz2PM/vpLHO1NxJuOObFr2PHE7KiQMQWYCWdby0GnX1yfkv4ImtE/KMYwNGw84ofAnM0PhFGjBIYPSSxJT0pLsm4UzuRKYb2Gg67j9hMMOHekV+ZQPKPnQ82ekpp6SVOPrKdFxW86jVAg4Gta6riBSNiMivA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30UmF/SNZGaBDpLXOd9bkZ8kYK9TcPvasrHM8HXBBQo=;
 b=Y5j1A16KOPgOw9+8n6y5EgLrKnwYzLr9V8X56qMHMn5EwD0HUqzjcWguYqCIlHT6lYMW4fRUnQja1seWk8iF5kZijKsqCrgKsmBMVIHIT14e2EELmph0ZOHfHoRdUVYhSNzBTp5r5OVRwkiixK62Que66VKBT38MT+69cGF1ZVKVr+bqI0OyxEqmtibEKeXH9ji+LrJ7E+FSyNAET8jF0K1xgsfiS0zRMP5VUHkZ5dfPTT3Qw7tYlPGKlWD/y9HnWIWaoyvV4c/dPADWDzUYGMJWOy4Xoc7ui70szwMdl53aMrctrUDDbXJ9SJBxkVj91oNEeIyJHE8usp9cWXMjaw==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB2314.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 08:52:14 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 08:52:14 +0000
Message-ID:
 <MA0P287MB2822C1F51E9F03137EF42093FE6A2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 9 Jan 2024 16:52:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/4] dt-bindings: soc: sophgo: Add Sophgo system
 control module
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu, chao.wei@sophgo.com,
 conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 mturquette@baylibre.com, palmer@dabbelt.com, paul.walmsley@sifive.com,
 richardcochran@gmail.com, robh+dt@kernel.org, sboyd@kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, samuel.holland@sifive.com
References: <cover.1704694903.git.unicorn_wang@outlook.com>
 <acebc88db3e5fcd2a2607b56842af7443a6e1289.1704694903.git.unicorn_wang@outlook.com>
 <cc7cc943-7242-4fd1-9b56-3ece0a418e05@linaro.org>
 <MA0P287MB2822E54A6DD36F914DB56E98FE6B2@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
 <1e1ef0a0-6639-4a4d-9b4e-50bcee3fb3c5@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <1e1ef0a0-6639-4a4d-9b4e-50bcee3fb3c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [/DJxhCjmcHnVVDSQWtYOv9JmWLyOEP5/]
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <ebc0a7a8-6438-4cd2-9956-1ac4f168eaa2@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB2314:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3a94eb-19b2-4bba-a7c0-08dc10f04696
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	96nXshlr0ryDvksM5f0mUwCNlgyCF29fTOPUYMmo1yuV2tQItMUBqmdi3nsqMD04+iw2dW8C29uJ3JMVuJZGwnumHBht9DIG1W1grDPmzRjDjkTd8SNZosMGI/0tQt0x67Z+M67ALDvEr7aUWQHs/Dbvjiyo8udQQPNMfYBkKSjlpqXdzzjMTJgtddBh2noghmQmOUGyB8xgmyDnhX5BUh4BYPwiM7PW2GgvqNh61bSHJp5DSnZji3OgnZUcCbJOjHUogW4uxu+xz2B++m6fC4xREHXbMiOHWrf3ErIG/qPby7Y1v5OXo3iaXieOs80rdE4/HtrF+Qn6Fc6080BGNjvO6C8TF8R2HJPAdy3p1h6zSPBtXeWVpY2P7WVljDkDS4VpeXohbYC1ZWjv68UG7o7+stnyRHPUqEhFw0Kie1POqjxJI4HDcwgNdHIE/Thhqo16+gtD/P0ZxcVMyJ77wN7O9QLi3HV7wQoApKCmv6zgKKhqaHv40PLhsdS6iyumeddvO4dRQacXegF2GERyVQPYjYn5x1rie1g5JzbZZmtMut6eItd2VOcTFrawpUQZRQLUY53UraopYguNnWTdcoDHqKIf5p8sDjE6eoy5m4k5L0mvxJlVUb4HvcYJDqKnABMOA9j9zpnsBF8NiDcoNg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0NPVDE5RUxEMkFkOHNpMDJJZnMxWHZ3VGxEYi9zTG96YUo3Uy8yU1NaUVZF?=
 =?utf-8?B?STJ1RFBZQ3NqbTFJc2ZwQlRGc1l1SnRoV3JKblVLcmozNGl5d3lYMDdsR1M3?=
 =?utf-8?B?MDVtK1Z2dmpOSjRtNEh1TG50b1pJMGVQaUpDOVdQYllYcFptYlFIanh4QWpl?=
 =?utf-8?B?SDZtUVo0L0lYeTJvUTQ0aFlWN1d0Nm9CR1hyQ2QwN3dycmFVY3hXSEZJamxk?=
 =?utf-8?B?TFFpaXhmd3E4UVcwOG9ud3kxU0pXZDkrVzcvMTRHdHpab2VmUVBwTTRPbE9h?=
 =?utf-8?B?RVVmaFdZdG1BZE1VUms4VnRsZVdTc2RVcnpyY2ZqQzZraE0rTFk0c1BoYzJR?=
 =?utf-8?B?WS9Od2pWYWZZdG0rSGd3L2VjYzlkdWllNlZOL05WNU1WWGdsWmZYV05RQW0z?=
 =?utf-8?B?M1hkWVdOQ0VrYzgwQlh2YVNmR2Y2dDdITG93M000TGFxRWhFbHkyelAyQ1BG?=
 =?utf-8?B?R2pQdGgyT2RMZG9uMTUrS3ZTb1RsbEU1cGRmQ3d5TzZxSHd5SlVjK2tzWFAx?=
 =?utf-8?B?MmVuM0paMnJQZWF1aThCQW8vS202RDhXNjlzS0lTaXV4MkRYbWQxcTJsanU2?=
 =?utf-8?B?Rlp5eTdjdUJ1d2kxMFJTd1FoSnhPUnpDSkFabG1YMDEyWUxlK2JvclQ2YjVD?=
 =?utf-8?B?K2daUzdlMFRib1JuQ0xVbzdhcUFpbkN3ZzBNMm5yaTZGbzZocWRIblVCN2lN?=
 =?utf-8?B?QUl6Mnp4M3ZpVHdkRTB0UHZDK0o0N2tYY1JWNlRYSitJYmw5VEFOK3pmNHdB?=
 =?utf-8?B?emw3R3RTUE5BQ1FwRnpKVDA4YWp6YjI3SWorQmZhMkducjBtZTJhQm9FeERx?=
 =?utf-8?B?V2JnR3NvNmNjWnAvb05YOGNBYXJ0UkZGdStnYTZsc0xrU01idjdESUNwdXJT?=
 =?utf-8?B?S3ZVM3dKUCtkTGRhekRRTGF3MXUxcVBjQnJIVDFUTXRxcEd0akM5WE9VNTlT?=
 =?utf-8?B?YkJGeDNmY0l1RFVtQ0FLd2tld2c1N1YxejM1WmlsOTBQcHU5bksyS1cxZlR4?=
 =?utf-8?B?dDdxUkhROGZEMGZ0bUdrUGhyUVZ1QWNaU29pUlQ3UW05dU9Vd1dNbzFLQk9n?=
 =?utf-8?B?akhPY004ZzFwUVF2MHpZTUVURVcwYm8wcGNjRDhRQlppR2U3Z0NHTjd6WmIz?=
 =?utf-8?B?cGY5anE0OVE5cTBpQWxndlV1OGdhRWNzcWpLcVc2UjhyU1RyK3BiaGI4c3NX?=
 =?utf-8?B?TmdDL09yNzcwbHZPS0s5SHljZGo5UllzbzJ6RGh0Yk1HUmZTVUlDelJuUktV?=
 =?utf-8?B?N0JaRjhZYldwKzZBTUQ1ZTM4aWhSYUsrVC9FNVFxVEJXT2g5QmY1NVVJYVNp?=
 =?utf-8?B?QTNPZ0ZocFJRVERsV2dPMWJGU2ZLVjI3bjdxakN0dE1OdkJ0SnByaW9FUVZY?=
 =?utf-8?B?Z2hyMkZNbFFJRnpiYi8wMEFqYXVKa0ZQZ2psYzgvbWFtN1kvS2xPWG1ySy95?=
 =?utf-8?B?TEZ4UjRzeGdURmYzdEhvYjg2T1RJZjRNNDJtUlVEMU5qbUVpV1MrMm96c0JK?=
 =?utf-8?B?amxVeGR0NkQ3SUx4ZGxUUm0zdUJsKzhvaUpnZkhQcHVwMDV5UWpRTFBMMTZ5?=
 =?utf-8?B?SnBIS3pFRzVRalh6cW8rSG9HRlV0YlZqaVdCcHZLMGZvUVJpelhOZE8ySk9x?=
 =?utf-8?Q?PvvZH1XWzPpeIKDCwCYwgoyaKiKfUF29cx2Z/h6jEcNA=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3a94eb-19b2-4bba-a7c0-08dc10f04696
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 08:52:14.5609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB2314


On 2024/1/9 3:36, Krzysztof Kozlowski wrote:
> On 08/01/2024 08:20, Chen Wang wrote:
>> On 2024/1/8 15:03, Krzysztof Kozlowski wrote:
>>> On 08/01/2024 07:48, Chen Wang wrote:
>>>> From: Chen Wang <unicorn_wang@outlook.com>
>>>>
>>>> Add documentation to describe Sophgo System Controller for SG2042.
>>>>
>>>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>>>    .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 34 +++++++++++++++++++
>>>>    1 file changed, 34 insertions(+)
>>>>    create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>> new file mode 100644
>>>> index 000000000000..1ec1eaa55598
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>>> @@ -0,0 +1,34 @@
>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>> +%YAML 1.2
>>>> +---
>>>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>> +
>>>> +title: Sophgo SG2042 SoC system controller
>>>> +
>>>> +maintainers:
>>>> +  - Chen Wang <unicorn_wang@outlook.com>
>>>> +
>>>> +description:
>>>> +  The Sophgo SG2042 SoC system controller provides register information such
>>>> +  as offset, mask and shift that can be used by other modules, such as clocks.
>>> "offset, mask and shift" is not a register information stored in
>>> syscons. Are you really sure, that your system controller hardware
>>> stores offsets of some other registers?
>>>
>>> Show as some example of such offsets, masks and shifts provided by this
>>> hardware.
>> The system control module is defined here:
>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst.
>> It contains some registers related to pll and gates.
> I do not see there registers providing shifts and offsets... just values.
>
>> Some other clocks registars are defined in
>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/clock.rst.
>>
>> memory-map is defined in
>> https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/mmap.rst
>
> Please fix the wording because it does not make sense. System controller
> does not provide register information. Your datasheet provides register
> information.

Could it be that what I said "that can be used by other modules, such as 
clocks." may cause misunderstanding. I plan to change it to "The Sophgo 
SG2042 SoC system controller provides register information such as 
offset, mask and shift to configure related modules such as clock." Is 
this better?



>
> Best regards,
> Krzysztof
>

