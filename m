Return-Path: <linux-kernel+bounces-5515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED0818B8E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A403D284A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769751CF8A;
	Tue, 19 Dec 2023 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="kadCOFCg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E071DA46;
	Tue, 19 Dec 2023 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFIVLj6nxtWGTJbEVnjDT0/q/GDIPjuserW3PNve2WMsIn4FwU0QP4Eq6jmfmwLhLKIGr8G63VAX73i6VoIaEulcXNRMpZGwL7N4u8RoTrVMbmRnGR4Ct0UeKeWgwyHvzGopfaxThf01N6+E/ILHQG/twyWa1hdxC7+1Y9dkqEIYxrCj7Sc38rzN12L6hj8ADEcx6Hftd/k/MS2eRJNJmde3PZm/YZYrK/1XXo9fl27gl0p8HKuRHfXV/kETdeBRnHiQ1X3akmcS+XXi8yYwHuAnb2ZwuYs/TReheyG8aQ1jmLYioEArIwBF3UfncMDeI0nFolWj+iTkLRlrAo90zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s4gUVFpEN5ya9v8thQf82+DVXkbb7d7eJzGHL+f+WRg=;
 b=aEPVEtS1ZrYl5b2VAOQAZK/vqAWCmC02t56VEY5MGlvH0of+PXC14yEjw4cAXBdpdUH/VP7kShA/h6F/47NWLXtM79pRXpjrEhjUF9KMH01LDzYjU3RTS/MdUpYiy8TPzX9D49gDr4/YRkzjNegOY4OprS9AiuX0RGSwN8tpcpOZVI67t3uSSUR5MPTu59oWv53DIghCmk6qMkM0sPYSVqR87//B2hVhkWZ2XQ8oa9BvcG/hb91MdtNqIybrdncOBTWgEA0Pv7BZLhBM7ufGejai/r6fg/PayIHAs8P4FsGaKm3a8TKI7EfWALoIC3HA+CgdmoN7wh3JPVH5u/uxyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s4gUVFpEN5ya9v8thQf82+DVXkbb7d7eJzGHL+f+WRg=;
 b=kadCOFCg1Ma4cdy14TNjmEGLpWYMcSqzfcS4XLGyxgnB0sHT9ISUEOuaT63rw3oNbKf6z3zMkOLcspT56rS0unCjRv7dgQ6xbCr1biBHHex4ldNZqPEyyih47iXm3dOEwbxXvnt0WuZkAi2zPHusEYV1Rvs+Hm5SwclFtzCFGfO5gct+PXnFriR2ecYX3omkfQjrWQrAxGfL6wfRdLW7VsEgGL8jVAAmWFhivrvVxFsMsDMhTULcDvZrUwLkiBYC3PFeH4TsyELRzkI0iW62CvTj4c4VyCT6WaaD5R/482wahmb2628qB3XfrVYz4M8Xv4e3OyWGyn9nNig9v7JB9Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5672.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 15:48:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 15:48:20 +0000
Message-ID: <cc6b7f99-3439-45a1-b4b4-0b5796dcbbbf@siemens.com>
Date: Tue, 19 Dec 2023 16:48:18 +0100
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
 <ef5a6cf0-4350-483d-a1e9-ce8b0ef71280@siemens.com>
 <ce6b002b-f2a6-4056-bf81-53a6c948b946@linaro.org>
 <62be89bb-1ae1-4bf6-9f9e-b6eb68e6504d@siemens.com>
 <f6241b58-202e-4624-ae83-ce52fc286edf@linaro.org>
 <29c030e1-c493-4521-b5e8-db3f484eefb8@siemens.com>
 <7edab40c-1ac2-4044-9337-9f26e80024a1@linaro.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <7edab40c-1ac2-4044-9337-9f26e80024a1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5672:EE_
X-MS-Office365-Filtering-Correlation-Id: 1598e036-a530-487d-639c-08dc00a9eca4
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YKyALxGiRst3XiJ0cCLujIXX4G5jWr3LSTcHJLpxk8f64PjxjM/tsKRXlJrsqGo0z5pgtP4V/brg+xMgNV8yGSNW9cCOeqsVmrQFVq0ywlDXgNhdMXVw4FEow2GUy7cQhe4bTH87HmSfE77sxyR3/n8zDRfjrSzgXS4pf4rCL7sDb+w8ZsL6NDcIu0Y7IVtGN4ZkH59mUUmNpNkngpd4VrirGf8mLIBVFXzV0ZF088mbR7hmxN8IIk7FudqnGxi4wLCz19edIHqYu511B6QVyIh/fYqXln4h8x1rV1iqM/S/uJ6KOafXZmUq1b+YFPdwQ779CogfEqir8pB6q5gXqgTyLM7tFUhlw+FvFCJmotYWCjX32I6cmlpuhco+x7NxsgMZ3jMi9aK92JoR7Gr7ybgF7taKh1SwVzwnRZkrq+ME2K6smN3cINndFLaK7OAY1lqf3PkC4AqSiiHwXrEfbPGFxntiDqdEYz2ZbVb1i8+ZRACamwA7vCp3FFHF2Ruuw1Hbr1qjC+fdRpvgxC02fagw3qfn1/7V0nWttwd1VoGZHLnXCXKwz8MxwrbJqv2DmDvGmUrz/1GnXcEfpJn54p1g5g1E5TMHsigz7TuQdfgrE0CIexv269cTtzoUeeeqoSGOGk8H5/jxKNg6NHcuzg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(396003)(366004)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(107886003)(2616005)(6512007)(6506007)(53546011)(7416002)(83380400001)(44832011)(5660300002)(478600001)(2906002)(8676002)(8936002)(4326008)(41300700001)(110136005)(66556008)(6486002)(316002)(6636002)(66476007)(66946007)(38100700002)(82960400001)(36756003)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SG1qN2pBZ2RIR2pOVjFLcnJ0Qk9lT0hXTDlxYVNZZlNKb2w4WFlnSkVraE10?=
 =?utf-8?B?dC9vMENlZCtYM29MVFl3RDZFQmUzYUVlVW5DcEl0UjZUZzJ6WGgzL2ExT2xY?=
 =?utf-8?B?UEN4Yy9CamFCNFo0dTdlVmx6ekFtc3VSVkRnZjFwaWc2OWFEV0ZrZTdxWjFR?=
 =?utf-8?B?WW5IcU1zenpCemttRGUzTWNIZWNWblBRSWd6a2c0b3g2V3RjSmR1b3dtL2VX?=
 =?utf-8?B?Q0kvdmVpRGd0SlZOUEROQnozajdzZ1hTNno4Mm9adjVKOGRJaEV1a0ZWMys2?=
 =?utf-8?B?Q1dQcnFxVWd6a2prQWFiZ2N1WkdHQTVEcHdhcWhmemVOMytmVFZqZms3ODgv?=
 =?utf-8?B?ZnJmdjZQWW14VzFwYmxiSU4rRVJvUFlmclNhSGFMRnREd01ZbWkrb1ZHczVT?=
 =?utf-8?B?V0pJY1hWbjd4WkZIajhmbWRBNHNER2E1c2hISk5vODh6WkFoOWJPTTJPOERz?=
 =?utf-8?B?TkU4dFNJTGVsL1plUVVLOEFUbEtyMVc3Uy94SlEzRjBnMktSWWFPRWhaVnBD?=
 =?utf-8?B?N1FsTXZWWlgrN1pWSDlubTdjbU9rQ1Q0NU1SeVVBZTBXN2hQWXpJTHlJVUxn?=
 =?utf-8?B?ZzdxOFRQYkVRVVNuZ3NJSklVMVhMaTB2ZndKUk1KVmp2Mms4VjNqUlR0OGFY?=
 =?utf-8?B?ZmVreHJLV0dlNTR6OWJDV1V1d3lkUlVydmdIUlJEVGJTZ2hMaDFieW9uVTJy?=
 =?utf-8?B?bFRvd2FPZ3MwRE5ZWk1xMS96cjZ5aDhjeGJZVEh4eXRyVzZhU2JPeG1EQTlt?=
 =?utf-8?B?MWZJbjBEQjYyYXFYMDk2VGlsd3oxSXRtd09Uc1RaUlhPS204NGdYZ2IrN0JF?=
 =?utf-8?B?UXlldTdRQ2t5ZWU5Y0x2dyttZlpIemo3SVdPbnp6MjlVcXBpZzhmaDVWSDdi?=
 =?utf-8?B?dFY2ZUZTajd1QXRxTnp3bU5mL3B3cFZlaTBLQ2IyMkxBMVN1a2lheERmeloz?=
 =?utf-8?B?VDdBdXR5QjNLSjduQVRGM3JGZWIzclFrL2QwOFZCTzJSZnd5Wk1ZZFJLaE9o?=
 =?utf-8?B?SjdkZGxuOFlqYWIrZFNBejBMUHQ4YnErWk9Vd3AwN3p2WW5ocE1pSUhuZDJu?=
 =?utf-8?B?OGxjcDZzU3RzT1ErR2Ria01qZGVzRXVlUkdKZDNvOGxONDVxaHJsRExSMFhL?=
 =?utf-8?B?SHkwY2k1UXcwUk40SnVZUHdmSmtzQXBmeEJ3dm8xb2VWNWFyNkxsVnJCNWF2?=
 =?utf-8?B?VFNGTkI3aFpIQURYRHMvNU0xQmMyOWtVWVU3N3ZpOHNGNDFnRXBlY3R0Z3RM?=
 =?utf-8?B?WVdzQ3MwVDljSlFjY09tZVRyR2dLUVgwcW05Tkpaa3AwaTBGL2Frc3p0MVRX?=
 =?utf-8?B?Umt1b1FFcUt5UktJd1MwdTdFc1lmOEYreUxPakoveHJBVGN4WDJWT0VXQW56?=
 =?utf-8?B?N1AwbmhWc0QwczZ6NFlGL0VBVVlSOVg2VWZrYjE4MHdTaWQrUmt1T3NKTVBN?=
 =?utf-8?B?ekdOSExmaVJSc0xkOWlXb241ejNGbWo5Z1MwemYzMi9YcmdZMENQWktidGow?=
 =?utf-8?B?QlA2VmxmYzd6US9tV1ZHNUE5b2RGOS9hMS94aG45NUUxWkc2RllGQjE5aTFr?=
 =?utf-8?B?aGVaajdnT253VmhFeU1FUDVobk9PbXZEbC9GaDZQS0lRNC91NHJRbEIydU9P?=
 =?utf-8?B?dGUxUzBzaU1xNE5UakZGRFNkaktOSjQxcmZWb0FMT2o2UTBENDhjMFdpN2VP?=
 =?utf-8?B?MzErdWlHZE84YUJBY2FVRUFQQzhPN1ZMRENuTTQrRFFiQUxuMENLbE9wY0lu?=
 =?utf-8?B?SHpIb2dBRkhVWUdKcmZ4TDkzbkFJbE5XaHdOQVBpZzVDUExycXcwekpHSXNO?=
 =?utf-8?B?V0RKeWkvSzc2YTlNRnN5ZHdCdkp4d213YVQ2Sk5hblVUMUltOHpHNVQvYWUw?=
 =?utf-8?B?NXpDekhJRmNxVmlrdmw4S3FUZUhiK29aVWgzdEt2NWdWM2xUQUNTek9FQXNs?=
 =?utf-8?B?TXBlcnA1clFYcmYrSndEdXloUjdha1VOc2dyY1JJMEllVWlaejFWQXo3ekdM?=
 =?utf-8?B?VU1OMFBOOGVieUdodDdyeFNEeDZURUxhNTRWTTR3ZkoybEdXSk9kNmdjaXEw?=
 =?utf-8?B?NUhNajNneHgwQ0JtMCtIVk5JUExBeld6aVJkOEFudGdaclZlZXBnUDROdW9B?=
 =?utf-8?B?dEFaSlVaMVZLZFdEN2RSV2oyb0pSYzBtdUhseFhvbXZPMHVzR0kvOHBJdTFy?=
 =?utf-8?B?MkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1598e036-a530-487d-639c-08dc00a9eca4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 15:48:20.0707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yD2nKn0VWvdZ+iCrXsHoY3a5AEGMcZzu51+SWO4ptN9D+sHt70p9fjaU71dKz+RLYGjNvE4JUb7r0xSPWSq+OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5672

On 19.12.23 16:42, Krzysztof Kozlowski wrote:
> On 19/12/2023 16:40, Jan Kiszka wrote:
>> On 19.12.23 16:39, Krzysztof Kozlowski wrote:
>>> On 19/12/2023 16:37, Jan Kiszka wrote:
>>>>>>>
>>>>>>> You have label for that... Somehow all these nodes are half-baked,
>>>>>>> without all the expected properties and now you call node name as ABI.
>>>>>>> The node name is not the ABI.
>>>>>>
>>>>>> Well, existing userspace uses those names, and adding the properties
>>>>>> would break that interface. Now, does Linux do that?
>>>>>
>>>>> I don't think you understood the concept. There is no change for
>>>>> userspace. Same interface, same names. No ABI break.
>>>>
>>>> I do understand the impact very well:
>>>> open("/sys/class/leds/user-led1-red") has to work for all the variants,
>>>> consistently and backward-compatible for userspace.
>>>
>>> And it will. The name is the same.
>>
>> Nope, it's not - I tried that already :)
>>
>> root@iot2050-debian:~# ls -l /sys/class/leds/
>> total 0
>> lrwxrwxrwx 1 root root 0 Dec 19 09:49 green:indicator -> ../../devices/platform/leds/leds/green:indicator
> 
> And how does your DTS look like?
> 
> Because I also tried and it is exactly the same.
> 

I played with

diff --git a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
index 402afa4bc1b6..a791444eeb93 100644
--- a/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi
@@ -10,6 +10,7 @@
  */
 
 #include "k3-am654.dtsi"
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/phy/phy.h>
 #include <dt-bindings/net/ti-dp83867.h>
 
@@ -84,27 +85,39 @@ leds {
 		pinctrl-0 = <&leds_pins_default>;
 
 		status-led-red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_STATUS;
 			gpios = <&wkup_gpio0 32 GPIO_ACTIVE_HIGH>;
 			panic-indicator;
 		};
 
 		status-led-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_STATUS;
 			gpios = <&wkup_gpio0 24 GPIO_ACTIVE_HIGH>;
 		};
 
 		user-led1-red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
 			gpios = <&pcal9535_3 14 GPIO_ACTIVE_HIGH>;
 		};
 
 		user-led1-green {
+			color = <LED_COLOR_ID_GREEN>;
+			function = LED_FUNCTION_INDICATOR;
 			gpios = <&pcal9535_2 15 GPIO_ACTIVE_HIGH>;
 		};
 
 		user-led2-red {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
 			gpios = <&wkup_gpio0 17 GPIO_ACTIVE_HIGH>;
 		};
 
 		user-led2-green {
+			color = <LED_COLOR_ID_RED>;
+			function = LED_FUNCTION_INDICATOR;
 			gpios = <&wkup_gpio0 22 GPIO_ACTIVE_HIGH>;
 		};
 	};

Jan

-- 
Siemens AG, Technology
Linux Expert Center


