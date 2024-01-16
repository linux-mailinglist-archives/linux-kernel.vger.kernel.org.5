Return-Path: <linux-kernel+bounces-27328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8CF82EDDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC60C28313B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502E21B815;
	Tue, 16 Jan 2024 11:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="N1xEAh+t"
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01olkn2089.outbound.protection.outlook.com [40.92.103.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4781B940;
	Tue, 16 Jan 2024 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hjn5upMuYRX+g7sEHDZyl2uRNAWvCSpem4YOSVhzbXh5gf2spF2qzglKKfG4UtbB4rFvq0OqIAMRQPHj9C//DiP9IF5dPae0sxWEJ+y7edXLN0s0sfuOMXJN+KVxlwMtEZkjgRj2TV7T262VO5TmGekygZuqPkWBiMnjZLbdQ820tA69bvZsnnxLiqYS9N0I/bTS+HpiSLxhIEujiAMlGiDGNURAebQqJfcRL6ZSUWTrmmlXI99mZTAAvOnJyebwbm6x9Su5+y1Abizgxrt6/gqVr4WfEujiWdaCL8LHg8vLkltx+2vMyQzY1Bl7eBYw8X+NJoSzREYG3L05q2X+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIdNgyuuBvjR5UX/UXVruTVaatPQSHNgeUC/msUMZV4=;
 b=ZkdhfjhgkZ/0Dtfycwdn/fUGx3PcV8tt7syXrK44jswaBtUaU86ESaCY4mzH6T/9c2NefODSwK4PHYeDBt+6MQMV6tXiJLkRzve9bhUrz2cXGIFaM4aXM70ew+kodmRy4G0tOqaS6sl3g3mbh8eTsjGs4Sp3rUGHCP7LovD1h3MTrjA7cbyp4cTNb8r3jS9YMBCm2gJCqLAH+Cvz2I1ShsFSQDR6VzxSc13m5XCQjT3ZOalqa4xD6LnPAEHX+hp0QGRfwIPbDbkwy0ZnunLsSk8GoY6Gun1Jth7hE6rYkQuufu0W7/7aBGuQWb0j+kTWpGLrlN0Ij/4jBavtkl+lug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIdNgyuuBvjR5UX/UXVruTVaatPQSHNgeUC/msUMZV4=;
 b=N1xEAh+twTpj1QOVMv845VWMgSN9vViiTGGqUJ0VnDkULWJmFcXAQl3g3DEDEIn86Mvss9yzThEMBxL3dXhEG6lAzAiYGpewZAtCXwbMeOwoJJ5S3zqrPkOajBu0Zv+CwEVheh8aGcPl6EMmxqjEJmtl2waeJQvxBQVEtYhGlsHckV0HPxc0b64f5PdxrPAQXj/VDDoUrx414AS17Nc63MYKcgon/QaGDP1e5gThkHB1+EYFEqrC9Qqelwp/ENzrtnVhI7zxO2Hbp4nVIvr6WZjEkAKPU3VMdqxJMaSMeUMHVpix9KLzdW5ob5oWl45oqJre681JxXJJcX9+RImxbQ==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN3P287MB1847.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:19d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.29; Tue, 16 Jan
 2024 11:37:29 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::6e80:69e1:f2e7:d70d%3]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 11:37:29 +0000
Message-ID:
 <MA0P287MB282232DC6DF6290F5520BA89FE732@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Tue, 16 Jan 2024 19:37:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/5] dt-bindings: soc: sophgo: Add Sophgo system
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
References: <cover.1705388518.git.unicorn_wang@outlook.com>
 <598b1026fdf9989bc48e5e10d1034b37947d3b80.1705388518.git.unicorn_wang@outlook.com>
 <f4a46311-2e12-458b-98a8-d3caa2c95517@linaro.org>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <f4a46311-2e12-458b-98a8-d3caa2c95517@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [tX1rqsDlj7PmSqjGin9SmCxk76bAGxUn]
X-ClientProxiedBy: SG2PR02CA0099.apcprd02.prod.outlook.com
 (2603:1096:4:92::15) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <6a4d5b98-dced-4cad-b346-b285ea303707@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN3P287MB1847:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d51ef08-5cec-4424-f6f8-08dc16878448
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IGsZifcfUoQCzyJa2Y8otupbeDQ4wbh9LZHVNjJe+IjqZF5hOcL9jNUk0WiXceXex968zMdqQCsu45bXouyBvAxVOUL/73I3CsyFuWl3eFgMvLhjsWhc2QQoM5c1kTufU/UpGF00wUaEwxKyXS8+MpP/eUG6/DLxcRCaSnsjdj5QzIzddkH/e+mn/zBchz8pvPQywdm9WmbMZPmlA3Nl4pywYle3LuIdsNhNuFuXY59G7idlSPKm75J3Kfs0ZrmSF80+KVye4SBzjnJsZhZP7CAKWF26SFTrnD7Wh5frbm9n/GdsbKk6pzk21c+N7BJDlpAH2YKowvEP/5cgNYlUpi/D69cMJQzpNsVBK2mg1uFwkCHMe4mEGflev6wVhLTk49+f8I8jJuumsRT1K5WI92D8YoOrBQAvA0We9b+AaqT2TuDoJBVF1wslv4d3QXLUtaqNvqPWdGX/m8N3gsnjWhBCgxxQ4lLUg2zCv/Btypz1ipwRFMf/2edra1GEfhtaNIa2YBU9U2KW5A0ymU0mOuemASR9DvPq6SHSIJXwc5zyjLOm1mIdZe6mt8s8RBCa5KntmxygDuXDGpFKIU9oWNBebd89L+p6603v/MTkjPDYzFy3aqA+T4G2df1AWi1/ykny85v+xxZL5yaxrXZ+Kw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmFnSlRRR0FaL3N5WWVFNmNMcUptVXM5YzdmOEVneUVFZ0FwbUZhQmFxb1pa?=
 =?utf-8?B?djRwK0daTGxVY1FaZUtHNElJbnhqcGxsQXJwTzlSNjdRNnhRSHF1YW9OSjM5?=
 =?utf-8?B?enBPbDlwd0dPWnZMNTNONlpYNXBHN3ZNOGZxbEM4ampxaWhMeE42aUtsQjdp?=
 =?utf-8?B?RW9velBYUXpYK21PYUtjQVNLNUVFVGVDcU84SnF3bHVLb2ovVXVlNWMvL3RW?=
 =?utf-8?B?NU5xbTVKZm9PRmdhYnVSMG14Nks5T05pbVpxWTlIU0RHb3dzWld5WWJuL09E?=
 =?utf-8?B?OFRTc2RLY1d0S3BNeldjRldqdjNkdDVOS2RyM1ZPaFFsanhZZlJqUUNoYWt3?=
 =?utf-8?B?M0VrRHE2VDNub3RLSndGcGZ3eitUTldFeGVoM2lNT1JPVVlQNnNjS3FTektI?=
 =?utf-8?B?U2w4SnBqMTJMTllEYWxPY01BOG53ZklOQSs3TUZXbjU4RkU2ZC9zTmtnK2NP?=
 =?utf-8?B?Y0VEamNyZ0JJRjRtVG9nekhYeHYyajhBZmhHZW41VDJGcEp3SXVBa3ZBNlFI?=
 =?utf-8?B?MkFGNFYycXpwaVNpQW53TVF4bWJsNTZicjMxcHh6ekROT2s1UGpqNHJsSVlv?=
 =?utf-8?B?VklxODgxK09KdFp5WEV2WUhBdHN4am8xbEVxTHc4RWo5VGxyT3pIN1E1UWpx?=
 =?utf-8?B?MVA4Sng4djYyM1ViTk5VVVJsRnhmVytLdVdJNXl4VWRTbFduTVk1MExOWmxU?=
 =?utf-8?B?WjEzY2NxQ1AwWThHVlNqTGJSVUF6cWRCZ0NDMjVob1BIakJDcy94a2poZFl1?=
 =?utf-8?B?anlvaER1d1RjTEJibU9HdmI4OW9RR0Mvek5qdlJLZitlcEppWDdZbitudC81?=
 =?utf-8?B?VDZDTVJNQ1FVbXNyMVowYit5ajltd1Z6LzRzWW14VVIycUllZU1QYms4SjFn?=
 =?utf-8?B?czNJY3RGeU5mQkNHV2NEVjlvcVQ2TzRacVFwYUw5My9ndkY3bFJwQ2JNQWRm?=
 =?utf-8?B?RFRPK2NwS1hIL0RSTjduSVE4NXN5ejVJU3dwQmUxWUt5aUVYayt3dFFFQmRU?=
 =?utf-8?B?ak5YTTdCbWVZaDhDc0lGSHg4Z05DWjl0eklMdHkwaUhwSVlGYy9kQ01mdEYr?=
 =?utf-8?B?SFV0anFJdXVTK1MxbnJkSmswZXMvYjEvS2JDRFdNYnVpVjZYU3ZFV2JseTF2?=
 =?utf-8?B?WWI3MnlhT0J0R1VVNWh0VzlXQWIrWmU1RkF2QW83SDBta0cwcUlHWk5sQ3Fo?=
 =?utf-8?B?UEpyVlpGZFVRNVNsNnF5WFFramc2c1dqWTVUKzN5Q29kN3ZMRnVDRmRnMnpt?=
 =?utf-8?B?T0dCNW9WTlJETmpPQTZicG9LN3FZTWNlQVdWOVl6VXpOZmViN00vcXg2cE1j?=
 =?utf-8?B?MGVnTGJaTmxObXJkTDZIR2wzamZETEVFRmZrSWR4eStJRUlmbHNvY09rNGZ1?=
 =?utf-8?B?Ym9FSjdMQjh4dEhUeTBxUjk0NDJXU3VCVXFkbUpJYXltRmZyVGtDR0Y1K3A3?=
 =?utf-8?B?ZjNFR1RNSzU1bnZlRTlIY0t4cGY0bDkrRC8vSkd1QUFLakVtZXlJMUsrQklz?=
 =?utf-8?B?aDZYOGIvd3FhZnY0T2JoSkEwdHRzYklvMXlMUmpXWXVUa1F0a1ZJdU9PN0FR?=
 =?utf-8?B?MFBRbXRpVzBDb05iNFdXVUJIN3pxa0RuUkFNUjNRbE0zN2E4WjVUYnk1VDJr?=
 =?utf-8?Q?TPEUPKPmBZhvQmxI+XO6x9PloOVf4TI3yTshoSTOy8qY=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d51ef08-5cec-4424-f6f8-08dc16878448
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 11:37:29.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB1847


On 2024/1/16 18:06, Krzysztof Kozlowski wrote:
> On 16/01/2024 08:21, Chen Wang wrote:
>> From: Chen Wang <unicorn_wang@outlook.com>
>>
>> Add documentation to describe Sophgo System Control for SG2042.
>>
>> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
>> ---
>>   .../soc/sophgo/sophgo,sg2042-sysctrl.yaml     | 46 +++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>> new file mode 100644
>> index 000000000000..7b50bb56b4cf
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,sg2042-sysctrl.yaml
>> @@ -0,0 +1,46 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,sg2042-sysctrl.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sophgo SG2042 SoC system control
>> +
>> +maintainers:
>> +  - Chen Wang <unicorn_wang@outlook.com>
>> +
>> +description:
>> +  The Sophgo system control is a registers block (SYS_CTRL), providing multiple
>> +  low level platform functions like chip configuration, clock control, etc.
>> +
>> +properties:
>> +  compatible:
>> +    const: sophgo,sg2042-sysctrl
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clock-controller:
>> +    # Child node
> Drop the comment, it is obvious. It cannot be anything else.
>
>> +    $ref: /schemas/clock/sophgo,sg2042-sysclk.yaml#
>> +    type: object
> Why isn't this merged here? You do not need the child node really...
> unless the clock inputs are specific to that clock controller and you
> will have here more devices? But where are they in such case?
I don't see more devices will be included later. It should be ok to 
merge them into one.
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clock-controller
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    system-control@30010000 {
> Why did you change the name? Please provide detailed changelog with
> explanation of such changes.

I changed the name due to I find the 
TRM(https://github.com/sophgo/sophgo-doc/blob/main/SG2042/TRM/source/system-control.rst) 
call it "system control",  so I changed it in v8.

Which one do you prefer? I'm not sure if there are any requirements for 
this?

>> +        compatible = "sophgo,sg2042-sysctrl";
>> +        reg = <0x30010000 0x1000>;
>> +
> Best regards,
> Krzysztof
>

