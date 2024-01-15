Return-Path: <linux-kernel+bounces-26064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22A482DABB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FF34280DB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9214F1757D;
	Mon, 15 Jan 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="vUiy9kGi"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2053.outbound.protection.outlook.com [40.107.6.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB41754C;
	Mon, 15 Jan 2024 13:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fr7Z/ot9nQkp+MnEpC2x/Jl7Iy2h5jZRTc6tg5T2ifeIda8MNy8UNOpFL3SAdtT6VTHsyG6CMsvSCKHFroeFWYEWRiIz6utJHCB1OukQsunQhO+GaLEDyQS6N0gUmf27evMyz0HCSHvco2sqa0X+oYtj2FzjOlV+COqq8DChLZ7yT7OdoIzCnzmDRneeWYO6zcbkFTffSuSd/m3baf+dXi4i0WvZhiKf6H1ym0Veopvof56tqz7qW2cLKNsRQtKCzkHN/aV8QRi9Fjmmp3hOLSSatZnPhHXB8gso9j2aylSbom5fniTBlqjr4jzhR5X6nLNwcMtPaB+XPDFB75Iqzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=br46TWzz8VRKPDC4imWbrMVSscmUVPipLXGI6K5S5HY=;
 b=TSM7+8aanHyoURh+nYJ1G2q1biun8fbDM251jecpfBHp4d5cIL0u+BxMbbyIlsV4ZDiUwjuesi+VWMGbL+rHi/hAixsaxXDgEdrGcN7sMrshOlptvztwXRZjwikr5qt/4mxa1jtmzED1ON8UQRCed00brx2Cr56v69RtsfqgaZWdXWXU7JRLvPP4i7BNueiocYq3sD9E4BxeTUIOSfyXkbA+5motaDrJVwwMToC1zJwNKanItiqlqEWn282U+CBEyHT+q4r2gRGw2pePw3QLQTr09TzHRfN9esMxHPC/VXT4/QpBnf+PI20YPKKd0CHdpNPcvMuEU6C0/lg+9h/18Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=br46TWzz8VRKPDC4imWbrMVSscmUVPipLXGI6K5S5HY=;
 b=vUiy9kGi4RCIk2KHel24XaiJ09ABnlXX8LO4CG7Y1XnGeS8+tn4UJu1OtUmBnDVmbq32A1LBdXcpzUWNLLIXbJ4RE0Hrmt+X9streziKP97yU6SOTZBhgs1+QSGv8GufOXppEHzGzskDJRtCwc8a1E46FCSWU9C7bRGN7pFps7w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 13:58:29 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 13:58:28 +0000
Message-ID: <96abddcc-fa65-4f27-84fe-2281fe0fcf1c@wolfvision.net>
Date: Mon, 15 Jan 2024 14:58:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ASoC: dt-bindings: xmos,xvf3500: add bindings for
 XMOS XVF3500
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
 <20240115-feature-xvf3500_driver-v1-2-ed9cfb48bb85@wolfvision.net>
 <333c2986-c7c2-4a46-90cf-b59ae206e55a@linaro.org>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <333c2986-c7c2-4a46-90cf-b59ae206e55a@linaro.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR04CA0072.eurprd04.prod.outlook.com
 (2603:10a6:802:2::43) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAWPR08MB8959:EE_
X-MS-Office365-Filtering-Correlation-Id: b22aa0ba-ec63-4a69-6bd9-08dc15d20cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CwUgcXkmuxGg/xlEiUC7fsWzesGV6w9inbrhJB9UafRS/wt6aMwENjbCdyCZrJ98zX/0vJN5MmmhsVWJJBkRfvMErKbrl2eJvmJMrJSuIBqCZO4K7m+g506ljyjJjK5zuuzQ/W8i9z7R2ewlwRfjF2ghkpzkcuXD6PanyA6Eo9GBqVpx8i8nAEPQKlkL+kVRT5+tvoWV0pJX0VMB1Te487/0ztClwKL+1GyJnrWYOwT/JIOXWI9VtlCsUuyqWhjD2R/EKUH7a8Jx7KcdwaEmJrXHHM6Ri/TE0COA6ZB87MjyBZos+Jh3lao/zNJ0aAMI49Cn9YxKD1JmXpC5hAjG6vs1oaAsP0MoOeyd25vlNbWJdH5Jjz9Tm+IHrzyNSZWgYut5dxrd7sFjzPdsV7FJZVhWR3D0XSyuujmM5/d3eVr2WnS4+UuPPieSpgdB/G9aPTModCMUHBb9CIoHpFtEs1N9n1LxD3u1j3Gg4tk1vaWJJmki7Bn7wHzDYB7nosK74MyjjoiE0sVSgyWunsMj1hCFLa7yFire6xbC7OgYE6mEmw5TjQjDTHsmWZbQ4/dOKGFrGss8bL/OsEXlJM3TBcuVoDCJPMSDV48tpiIWaCyyyi0bphxcbWvcdC/+lK1DAyRN/nlH7/WVBCoQ/V/COw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39850400004)(346002)(136003)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(31696002)(86362001)(38100700002)(2616005)(31686004)(26005)(36756003)(83380400001)(6506007)(6512007)(966005)(316002)(6486002)(66476007)(110136005)(53546011)(66556008)(66946007)(2906002)(8936002)(44832011)(8676002)(7416002)(45080400002)(5660300002)(4326008)(478600001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2pqM093MnlsSy9BcU9GVFYyRnFhL0NzcWFiTVl6ckFTZy93MGxkZFA3WEd0?=
 =?utf-8?B?S2UySzF4Z053STBhRWdvRXVGYzJCQWlqK3ZwWjdyOWg4ZUExREpQZG42aHBP?=
 =?utf-8?B?WmE3MTlXbnA4cjRreEk1U0s2VldXelFucy9xZ1hoOWgxeEVDR1FZY1A4L3Iv?=
 =?utf-8?B?alQ5ZmxCeUtoVm94VXNZSDNMODZuTGlnb2pyTWtwZERuM3owVkE0QUZtTFd0?=
 =?utf-8?B?d0R3WmVlT2FWSnpPTHRDUUdkZ0pMbUVZQ1FNUmlWb0VLZit6TnY2MWYvVlJ3?=
 =?utf-8?B?amlOdkRETDBTYVFvS3FXYitBbjZOcG9pMGdzWXZlT3lRUXl4MFlhQmJxMDRG?=
 =?utf-8?B?ZEhuVjQvV1c5WVdiQ2ptV3pPSDJrTTVrRjVhWmZ6R1ZQcDN0bHNvK3doSWJy?=
 =?utf-8?B?MnYwUWd2Ry9rcitUN3ZCVnh2bnhkdUJhbEd3TGtxWUhhREhkaVU1RHVmL1VO?=
 =?utf-8?B?TUFYMkdhemlNejZKc3NmeVhUWjQ3ZXJIK2lYMTAySGFrSDk4dHRicFNIdXV4?=
 =?utf-8?B?dUFaN1JJVUFYVGdNVm5hQzR2enRJL3U0cEJNckpUMGhPSnNDQTlMNkgydENs?=
 =?utf-8?B?QTB6ZjhGVXBnWXpOY3JSK2drM0lkMDJLbG9CZno1OEZQSE41OEJSQVFvclZ3?=
 =?utf-8?B?bzIxMUVSVmJUS3FYOHNKR1haRDJuVTViZ2dycEhKUUZ4WU9hRElMS0hGMVBQ?=
 =?utf-8?B?akRhaWV4NmcyamtId2tXOXN0ZGQrd0c1SFhWQXMyYlhwcFN5Yno1eTE0LzY2?=
 =?utf-8?B?WktDZkRNT2VmN0M2NFFkU1J5SE5FMlJjc05aSnRYNDdzT203RmIwTUtxaE56?=
 =?utf-8?B?clNsZU85NXI5RnlKdG9nWVZDYkFRdjdJNXdYME1objZOb2FwOGM2Y2k2ZFVy?=
 =?utf-8?B?ZU1teCtocGwzRXVBdkFpUGQ3dWxrZzNmK1Jnd2pNalpOa2R5Q2VNQlZRRDg1?=
 =?utf-8?B?Y1NSVXhaM1dxd3p2a2FXaCtuMUVLZVlaMENDVlBIakhxOFNjcWozb0pKMEI1?=
 =?utf-8?B?VEJRaEVuT0FLdU9LUThnS3gxdTFvdGhWZUNlYnhBL2xxWVg1cWRLNy9BVit4?=
 =?utf-8?B?S3RsZ0Q3UzZLc0p4Y0lGa3N3c2o2dUloSXB1bmYzME5qeVdtWjRERkp2Z05N?=
 =?utf-8?B?NG4yR0dJK1J0ejNSaW1YaWRKalBlVlpDTWptWGwveUcwakhVQlovZ1IxUS94?=
 =?utf-8?B?bEFMbGE2R3BvTTRYSCtOanZKdGlndHppTGMxamVZc0x2ZjVxRWxvQW1jNmxK?=
 =?utf-8?B?RlZVSGdMUWxLUkZVZ2hHbWNacWtDaG5uSXZOSUl3cVRIRWthVWNjYkJnazhi?=
 =?utf-8?B?UGc1TTlmU2dhQkllUlpYZGt1Wnh5OVI3czZEcUREQUhwU3dFdkNjNTRZQ2hE?=
 =?utf-8?B?RXhZbXp1MUdvK01WMkJZMFVac05zYU1Lem5CZnpQQlFtRXUrNnJ6WXVFOGZk?=
 =?utf-8?B?OGpxRmFmdDRwS3VmbXRUL1FsNG1YK1FKeEIzNTNGUEI5bXFJdVBVOTNVbjFs?=
 =?utf-8?B?Z0dDaTljdnZNc0RTUnlzTmExNHA3RFRhZ2VLR0JsUGhIVU1nSjYwTU9Uc09p?=
 =?utf-8?B?MGtPeEJySkVHM0xZM1JBMEQ3b05WdUI3SjUxZFNrVzQwU3JvVWNTTE01RkFY?=
 =?utf-8?B?MU41Y0YvMTZWNE1TVHd1THpJZktKNjdYSTdna1RBb0F1R3FrdmN4UHdnd0Vk?=
 =?utf-8?B?cXcwYUFRU3JJSitKd1E0VW5JcHBWYVArUzNadzhHN0Nvd3NYQWZDSVlVcWxp?=
 =?utf-8?B?MG9nVXBMbko4Y3BpWHhYSDNwOWVFczQwZFlIQWkwcnV6VVk3YTRuWGlVVGxv?=
 =?utf-8?B?aURzZ1k1b2poVmtWd2FmSk45azN3V1Zsc1MzQmZRczRHeU5KbUVKVjFqSDA1?=
 =?utf-8?B?SWE4bHlXTUsxZ3E5RitHSHg5MDNpL1JkQUZnTUg2cGluenB4cThRL3hyclJu?=
 =?utf-8?B?VkE5S3dEc3VTVmJHdVVralRpVXYrUEpsVVJSWjE3WTFaTDYxSFp3eUIyeTVp?=
 =?utf-8?B?OGhUZjZwbVMyYThLbHlVOC9HdjhJZWVnOE9NdDBvOGJ4NVpCOW82cDZNSXpv?=
 =?utf-8?B?TVR4Qktac2RaY2M0Vk9hT2p0dVVNV3c5ZE9rdVBISVFYRnRjZUhlTGVLWDJl?=
 =?utf-8?B?U09aK3RscUtpWVhWZ2E1b0FJczhqaVBWb1lidFZhRFJjb25vVitoYTVRdDZx?=
 =?utf-8?B?VHc9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b22aa0ba-ec63-4a69-6bd9-08dc15d20cf8
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 13:58:28.6663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ECv/6sgTRpZ/6yzohvve1M8bOfi9sZn3jThv0IB/RbJpGUgTqbhqPmn0pAqTnUtpRKqPubFOp3K8j1G4g9hXXQrpJDq1rz7m5xxpK5DPaQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8959

On 15.01.24 14:02, Krzysztof Kozlowski wrote:
> On 15/01/2024 10:16, Javier Carrasco wrote:
>> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
>> multicore controller for voice processing.
>>
>> Add new bindings to define the device properties.
> 
> I don't see any bus, so how does it work? How do you get the voice data
> from it? I also do not see any DAI: neither here nor in the driver...
> 
The voice data and any other information can be retrieved directly via
USB from userspace. Once in normal operation, the device acts as a
regular "onboard" USB device and the driver does not need to do any
further management.
> If there is going to be any new version, then implement all following
> comments:
> 
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.
> See also:
> https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18
> 
> 
>>
>> [1] https://www.xmos.com/xvf3500/
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>  .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 51 ++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
>> new file mode 100644
>> index 000000000000..e93a735a0f1a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/xmos,xvf3500.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: XMOS XVF3500 VocalFusion Voice Processor
>> +
>> +maintainers:
>> +  - Javier Carrasco <javier.carrasco@wolfvision.net>
>> +
>> +description: |-
> 
> Do not need '|-' unless you need to preserve formatting.
> 
> 
>> +  The XMOS XVF3500 VocalFusion Voice Processor is a low-latency, 32-bit
>> +  multicore controller for voice processing.
>> +  https://www.xmos.com/xvf3500/
>> +
>> +properties:
>> +  compatible:
>> +    const: xmos,xvf3500
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +
>> +  vcc1v0-supply:
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
> 
>> +      Regulator for the 1V0 supply.
>> +
>> +  vcc3v3-supply:
>> +    description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
>> +      Regulator for the 3V3 supply.
>> +
>> +additionalProperties: false
> 
> This goes after required: block.
> 
>> +
>> +required:
>> +  - compatible
>> +  - reset-gpios
>> +  - vcc1v0-supply
>> +  - vcc3v3-supply
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +
>> +    xvf3500: voice-processor {
> 
> Drop unused label.
> 
> 
> 
> Best regards,
> Krzysztof
> 
Thank you for your feedback and best regards,
Javier Carrasco

