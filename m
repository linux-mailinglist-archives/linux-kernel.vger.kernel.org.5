Return-Path: <linux-kernel+bounces-5494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FDE818B56
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676B91C2411F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D8C1CA9E;
	Tue, 19 Dec 2023 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BM9Y3U6R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2062.outbound.protection.outlook.com [40.107.241.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AB1CA8D;
	Tue, 19 Dec 2023 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS8bZA8vFpEZ9m4GS6sxdOckzuU9XdUI4UWKv/FkhueP1LivvxqII+2RFlyGKDsosZMnbvppotjjQ2CgkdWifhOJyh6YlBSuSDC97VZQ/eKgENmrF3lPPQJSi0T7K/mkooOFkjHDQs8+V0gN0tjsmTu2a0rSEMtQpil7Y5NA4feNIGpSwfgqtIBe4mnnfCoVaSEHaq49R7zujmS98bN+9LpRYwJRjz+u7mkFmtVlBBq6Dwdy2jmosJY32BejT4581mm3gIKV9Ja9y3jeZMoehaNgYeulwnvnOQO3jNZLrLGgnKIinqsuEo4NGLUABl6lcWpYhkYMGKcJiREfBYRgCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe2ul7RPS/KXAd48+RqR6aPzjNfsOtNRk/Xgw8RI9Gs=;
 b=N9eIV+AJAYrTE/PReZFz+evZex+pS6OJqAY/sAHD2+J8wRmaEpjsPM4+9e9LC6kuneSRRvAhfJ/h2V1d1o/g/5ZJVE5QKmJvKRa2K1wlr2DjVRtJCBEHI5ZsCAeDke/vSsY9RtdvjCmYh4iWvsK2L/fYHHe3NFh67ZqZJulev/KgY7uqqcXlT5n/tV/AktZK9lIHbBZfePZiW7Sf0a4/OdhENDpB/q2CAYCIzhsjpIP5oRwbva3v8PWtzQ9mH3ct0qEAejvGIX9L7v3zUcAVkXqIxsIrgJ2JV+v8Xcdb8lNY6KNHqlSS1/Mt2uBwyCP9IUN3eWVqd2CIzOujKk581Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe2ul7RPS/KXAd48+RqR6aPzjNfsOtNRk/Xgw8RI9Gs=;
 b=BM9Y3U6RW1ZAzNx0RRfEezysow2z+OFoJ+lKBIJuaKKQNj+qsTuSV4HlsUW8UPPnJxMRjXfWBGwZ2n+I3gvA/RXInip2R1A3W2dWzAFkqpWLO03SIdjBo3imLZJsa8SBzbflLhsmlpxzAJUCYvIj/9ia41ISlapRl7cfgatUynO1xXdsa0DxMnRiBltJmAV+UsYzeVOTLHUV65pdtE5Q+qVIhGqDPQb2QEHXALNbIrx6VNg3Dly/g7g2NNauKEPcBHQmrYHMK81TEUfvkHzJym6LkPsOsZLrSMeoGbjcESX3ZYsPT79Og9Vxf2e8OG7Yl+DiqaTjS0RJ6fy5aLszSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB8187.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:391::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.36; Tue, 19 Dec
 2023 15:37:49 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 15:37:49 +0000
Message-ID: <62be89bb-1ae1-4bf6-9f9e-b6eb68e6504d@siemens.com>
Date: Tue, 19 Dec 2023 16:37:42 +0100
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
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ce6b002b-f2a6-4056-bf81-53a6c948b946@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR20CA0026.namprd20.prod.outlook.com
 (2603:10b6:610:58::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: 140f9c48-a0e1-479b-afc6-08dc00a874b1
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jkTgOKEKwAxR/YZjuP3I+4/CVOq+gA1cewyK2vMgwVh0hY+ANQipbZ96uLX/KuNaU8b9DFaX2OzRhwl6F5dxE94Oaqb2j9w/IkKl6zG46uguDPH4V97dEpQqETLabjx4KenU2XQcE0PVPC3THiYD7XfuzUkopHzUmpOzUfRrYts/v5rW7T7+0S743bC+5wkdwb5N2SFoXMbD4UvSwwAvUSHOKvwvS7ie5o3m3JbEcdKhoNpi+n63U3qpHPU4otw0+PeDWpjBSqg1mq2UVgehcU8HDiEDBgTRxQHacmkzU2i5hTFbNGMPNK1WJ8w61lBH6cWeBWM58i4zP220N4nHtkGcXONcGMT+HldbiufyyNvyLjaimargPwpmf+6Zz2vG6gTZJ9zOxCKiJtZWmj3KW0qRE3wiyu9aXLlPqavh0e3gyZ9JCDcZl5dusBlylxzqtRHU2NgwJddwnjC1Pph65GfJH+qDEr/WqhhYdNdSHK6R9FJleHKgKAvM1b0AtrLBZOpNxxHnII2STikOAhg9GEIMRdeCcdsp9PjlN+n1aMDVUbstCqZ+AHe95/SGnpJ2u5FxCHxTDsMDHhpMz2lDuVvfbZDI/1ykpmVtGcIJMcsl70K/pTlze/isOgGlG80FFDWMyNrWemOpljK6eU3XZA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(31686004)(86362001)(7416002)(2906002)(26005)(66556008)(2616005)(31696002)(6506007)(6636002)(83380400001)(107886003)(82960400001)(6512007)(53546011)(38100700002)(6666004)(5660300002)(36756003)(110136005)(6486002)(8676002)(316002)(41300700001)(8936002)(44832011)(478600001)(66476007)(4326008)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTRJa3FGT2tSaU4yRi91QitieVFCWWRueVB5S01uVHJOOHRBWnFaS0FRRzRt?=
 =?utf-8?B?SEo3N0pWMkM0NXhsWGJXYTBaRFJ4NWlqN29JaHh1WWpVR3AzRU5kTGdWZVNI?=
 =?utf-8?B?a3A4RVRQUm9pYkZ5RDAveGNHcUo1L3BsMldvRTN4ZDBrak5KL0o4dDJKMU1q?=
 =?utf-8?B?QUFLc2t4T2VQRGlKVVZSUUJ6SnVNcEkwVCt1eG1ZQmJOdzJaWTlaU1pJbUJW?=
 =?utf-8?B?aWdRM3p0UUZVcVRvMlhDVW4yU1k1aXRwZXk1UWxyd2FlK2pNQzYzajdZbGFR?=
 =?utf-8?B?YlY1Q2Fmdy9tN2x5Rk1FOUMzakQ3cm5RR0RLcDFQUSswcFRwOFJHaDV0ZS8v?=
 =?utf-8?B?citYc3lhUFhOek5sbnNXR1M4ZDVpUVF3aGZ0WHl3NlNJckpCbWdselFtZVJE?=
 =?utf-8?B?T3BRK1BxOWxIWFlWeHc2YXFoUytXVmQxbnZ2dlFMTkhISEVSUFk3T0w4ZHhl?=
 =?utf-8?B?cm9HVFdvT2twWEZJOVIvUktrVmFYRWFZRmZMdkh3QXJrLzRtNTBNUW1vRWI3?=
 =?utf-8?B?RWNpNFNqVWhzODZDMEU5dTRESXV6TzVFWXJweFdHRVZLd2h4WWpVazlRb2JM?=
 =?utf-8?B?U0FQeHNxTUVJVjdCZGVOY0s4R1ZlVy9sVXZmWklSRDY5NEpEeDlWUlpyNW1h?=
 =?utf-8?B?TXNHNW5vTkFaVzJ4OWhkeDRuUDVkZGFRWFZMYlNIbjc1Q0tENWw4T3lZR1dT?=
 =?utf-8?B?SWcvQmtkcERPeXM0dHpscXh1U2c4bk4vc3dSRXlSakVkaUVRazdCc2ZsL1A4?=
 =?utf-8?B?dDBpa2ZrWXc1L2JVU2tmU3JVUFRBaENxaFdiMnpBNXhJOXNwbVpKTUZFdnlB?=
 =?utf-8?B?ekpkbW1hZmVGRnJNaldxNWFYVXliamZEdmVPTWJBVUtUdlh0UWtMMHlKamd5?=
 =?utf-8?B?MjVaYzdualFYOHpXNXpaTjB1cTFpY1o3WjZ1NHNya0d3NVc3RmhORHgwVnJ2?=
 =?utf-8?B?U2kvOXpMQ2IvdHZza0psNzBoSld1KzE4N0pNTlM2dzJMRVFJR3pSRkhvV3Yw?=
 =?utf-8?B?WU5hZ3BiNlFubGVRMnkvMFpWM3dGR2RTSWVWSE5TVlgrWG1CYU5lelRYeEdp?=
 =?utf-8?B?alEyblgwNm80WkVKWGxRdlVPMlZjUUtNRUZwSElWc0piTmhySEVRVjd3dkJ5?=
 =?utf-8?B?TlBkNHluR0dNWVE0bWl1aE1rUjNINzk0Y00zUWhwVTM0SnMyWmtOeDdYNjFO?=
 =?utf-8?B?b01xZGtrM0NpK29mQ0ZERHRRR3FGVFZqWUQyVVE5aStPWStnQ3FoL09Zc21G?=
 =?utf-8?B?OVVIdFBOOEJ0YTAxSGx3WVVIRER1bzQzcTkyOGlVMnQyU1BiTS9xVkV2a1N1?=
 =?utf-8?B?V3R0aldHM0M0YktFTisvbkJoV0N2b3pIUi83U0NERGxaeHR5YjhPemRHYnJo?=
 =?utf-8?B?U05tdHd3VlEvTHFlaHZ2L0xONEpkVzV4Wm53bWZoYldhaVc0VnlZQnkzTHUz?=
 =?utf-8?B?eENlV0x0RmNraTcvQWoxWHEycXMySzVNTGZ5WjdWcllXZUVia1U1UnE1TmdJ?=
 =?utf-8?B?cStwWE9wTUdvaDlMSFlUUXIwdmhDb0tIUFpsSlVNTkRxYjFqd0dXYUFOUzlk?=
 =?utf-8?B?THVQVVhvclhWdEt4aDhINFFtN0ZaWlI1VDhuS2tsQ3hRazNENVJBc3h1aUxm?=
 =?utf-8?B?ZnlmUktHR3RjNlZacWd4aDFZNnNBMEJxN01tbDZISkxVOFJMYW1RNEIvbmp5?=
 =?utf-8?B?bXVNeHBPbDJwVDFmeWNYb1NjNGZ2NkY1c3BvYVp1Skk2Tmlqa0M4aEM5Z0xC?=
 =?utf-8?B?cEswV3pQTjE0anZFSDVUQmFTRUVLKzA4QjB6RDRzdDlrSVdDSHJzYnZzMEIr?=
 =?utf-8?B?bHJMU0grUUdSLzkxTkg3MTF1YVJyM0ZhT3RjU1VNeUFvQnpHZzlodWMvMHlk?=
 =?utf-8?B?RnREQ1BVZEFITWZiZ215OFJrcGppNnd1YzlnaU43WjNidVJpRWMrd2dLbGNU?=
 =?utf-8?B?UlBYSTE5WjM5Z1gwMWNFRmZXdEVPOXdkQjlmRTRZejI3WXhBNEgwMUlpWkJG?=
 =?utf-8?B?Q3JoMFlzVjlyd1dQY2hNaVBFS3pMTnZYTkJTbmlKdFFZRUY0dEEvZVJaRFNU?=
 =?utf-8?B?M2FLcWtCcXQ1Mkk0MERSSkIweHlIRXJzR0VTU0hyNjFUek1aSmNWZUcwaGl1?=
 =?utf-8?B?ZUZCQUpUanNhWVB1Z20zTzlkVmpJOGJ4aXJlUld4d1BpU0E4Z0xmVFEzem9D?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 140f9c48-a0e1-479b-afc6-08dc00a874b1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 15:37:49.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHdIh3K8BwCs+xZsnpVi5zvqB2/YRnFvVoevDwHQxTO57PBhwsOPbEF9BdmQwh421grI8Ww51v4BfcesOBERnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8187

On 19.12.23 10:58, Krzysztof Kozlowski wrote:
> On 19/12/2023 10:54, Jan Kiszka wrote:
>>>>> You mean label. Why node names became the ABI? Which interface exposes them?
>>>>
>>>> root@iot2050-debian:~# ls -l /sys/class/leds/
>>>> total 0
>>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc0:: -> ../../devices/platform/bus@100000/4fa0000.mmc/leds/mmc0::
>>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 mmc1:: -> ../../devices/platform/bus@100000/4f80000.mmc/leds/mmc1::
>>>> lrwxrwxrwx 1 root root 0 Dec 14 21:12 status-led-green -> ../../devices/platform/leds/leds/status-led-green
>>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 status-led-red -> ../../devices/platform/leds/leds/status-led-red
>>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-green -> ../../devices/platform/leds/leds/user-led1-green
>>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led1-red -> ../../devices/platform/leds/leds/user-led1-red
>>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-green -> ../../devices/platform/leds/leds/user-led2-green
>>>> lrwxrwxrwx 1 root root 0 Dec 19 08:55 user-led2-red -> ../../devices/platform/leds/leds/user-led2-red
>>>
>>> I replied too fast previous and did not include answer here:
>>>
>>> You have label for that... Somehow all these nodes are half-baked,
>>> without all the expected properties and now you call node name as ABI.
>>> The node name is not the ABI.
>>
>> Well, existing userspace uses those names, and adding the properties
>> would break that interface. Now, does Linux do that?
> 
> I don't think you understood the concept. There is no change for
> userspace. Same interface, same names. No ABI break.

I do understand the impact very well:
open("/sys/class/leds/user-led1-red") has to work for all the variants,
consistently and backward-compatible for userspace.

> 
> Anyway, changing them is not part of this patchset since these are not
> new nodes.

Fine, then we can leave the LED topic aside for now.

I will look into the other comments.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


