Return-Path: <linux-kernel+bounces-27077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A6A82EA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75772828D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693211702;
	Tue, 16 Jan 2024 07:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="hwHQJSGY"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2063.outbound.protection.outlook.com [40.107.22.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F111185;
	Tue, 16 Jan 2024 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYSsCl4qKrnTsSDZfa1SyNwiy8kYpWoLOGfpdOfmP9i2joPzZwyrUqn76NPAzD/NvAFtlJ/U7ASHHt5fzQ4sLA0p3wEASO6R3wrJRDdpc/zyeSpqOlSF2KfAzoS7o4RdjdGHF85jU435ljBKXaUwC5Ujbhi6C+gerEiszBtJ/9tdQT7eNbwLNu57tJEXq8txOG8GvpVePtDSV91Z2zdnM7jsJnWIsMaykpTgKh0bjlgJPpuaSqptj1PUU5Yg57k4ddikJZjg1qg5tPlf3ZdTnD4KdlTyoIKer2eydPUIYVkCCNnekZU6f6OJmoQmMx0BzOYNx1xRGB0OtNVGRC9ufA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2nxDtTOCpwadOXMwuCsNBf/DNfGF401SdQI/hBezgc=;
 b=EZPaoUTWrEfFRnig9S53dV/AuQTAJspN44wkleaAIG4GC2JBdEg75e2BOyQwF9lWfMG4+M+6q8JwP1fdgrV4kqTCXDGYkexknrF14MH3pJz2RxJ0eCdHzOBIUSy/nMTezdLT65m8lf06bd24rTD14OoWYvMF+6tuzZC2CCU+gaNTq6ePkXB+3LYM0QhjvK/99ImeFCvOMGszNv4dDBiDktxo1vD8aPND7itq39ZQVyNLT/0AcLuSe5e08IJTlPHFt/bb7mO+EvS7RB63wpHk3xMO0wlpHNtklFpEPwOIuUkNIeJlGK79Haatm/GjA4N3oDaBKrXO2Qug4/Vj6kF8Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2nxDtTOCpwadOXMwuCsNBf/DNfGF401SdQI/hBezgc=;
 b=hwHQJSGYr9CctPZvU7tAe+ZNFNeolkkM9LKTSYn37yzJtgnuCq3v6tL51N0K9G/Wb6KiTgyrcMTiBdZbCO6VEOpjxvTlSagnpejwjCs6e35IdeX6XTY/pqLDZZ6sVluLLBjJ5ZN+NorhVKOLUcCukcfpcZbp0/EOsiYr/A5JZW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI0PR08MB10485.eurprd08.prod.outlook.com (2603:10a6:800:1b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.28; Tue, 16 Jan
 2024 07:29:06 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::c8ee:9414:a0c6:42ab%6]) with mapi id 15.20.7181.027; Tue, 16 Jan 2024
 07:29:06 +0000
Message-ID: <b888d958-4eb0-4c1f-ace6-b2b85faa5113@wolfvision.net>
Date: Tue, 16 Jan 2024 08:29:04 +0100
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
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20240115-feature-xvf3500_driver-v1-0-ed9cfb48bb85@wolfvision.net>
 <20240115-feature-xvf3500_driver-v1-2-ed9cfb48bb85@wolfvision.net>
 <333c2986-c7c2-4a46-90cf-b59ae206e55a@linaro.org>
 <96abddcc-fa65-4f27-84fe-2281fe0fcf1c@wolfvision.net>
 <644f7f02-405d-47fb-bc72-4d54e897255f@linaro.org>
 <5db4b898-93d5-446f-bfed-b57847f9967a@wolfvision.net>
 <435f502c-1e1b-4d40-8dcc-34487905d69c@linaro.org>
 <b7f76546-9998-43e0-abff-a4e73817dbae@wolfvision.net>
 <47bdc31c-50d2-4d33-9339-5132b6364539@linaro.org>
 <16027339-0a82-4dd1-86aa-19fda6e23f88@wolfvision.net>
 <aeeb0dfb-87e2-4024-9d4a-0b9529477315@linaro.org>
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <aeeb0dfb-87e2-4024-9d4a-0b9529477315@linaro.org>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: VI1PR04CA0091.eurprd04.prod.outlook.com
 (2603:10a6:803:64::26) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI0PR08MB10485:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d026e37-68f5-43d6-feff-08dc1664d24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AA6OaYQJSfEkBIGplfVjWHzA+sGdlLcw5HWLhV8nnkDuWQQbPTfx/JHY7tHs+SsD0lEFytQkW26w5JfeMamXj+06xfzcixK9pR28cq/gyLiVi0/dSUoNj5OElfnk8cK9CvNGP00tABoGhnIdnfn8Ype0YkY0gVuhx73612lod+KgQBTiMRs4Zz7kKpmD5qlwHUDvghKUfS6STURQolqlFEcqmyeIDZ/WVU2n5aR0cSRnIuTrtDHI5O4O7BZzDk6/Jc7u/q4NIx3sBhOZxp+TjkUXT6WmRBkJsrIAJ4b3j5QfySVmfqwyl/02fVAuZLrspEhDQC8hDV8diVVQh6ORCxPwu6I/dD9rqDJh8nIffFxZgQgvf95fWdqL430uT4Saafje0TtIXjP3kIgbp0OyS5M+yHcS1bjwByAWWqTNCH+qAqwc27f/pJFH+OYiIJJ9Gq8TaGsftQCjvhDBbCDIMFhUxBbpDLRcMKOeCz3hXFtJMb8jrWC4JN5aVx1G1QS6oXf+8oFCc4PkBuWaPr73Dk4iPh/ezSBmVqtrqN8slRR1/KJ3Hoe0vv5qQ0Y/bQphIuUSMFhFfwIPTAt5AyShheLJiSBa0W097IoaNGOFARwu69tYVGIUdS06AhXhpbbpFxyv8AvmuT2frKeXepLhvg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39850400004)(376002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(38100700002)(86362001)(31696002)(6486002)(36756003)(45080400002)(316002)(66946007)(66556008)(66476007)(110136005)(478600001)(966005)(6512007)(53546011)(44832011)(6506007)(2906002)(5660300002)(7416002)(8936002)(8676002)(31686004)(4326008)(41300700001)(83380400001)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1k3eWM0RGZLaHd1cTB5Zno5TzM3ZS9rSUwyVFladGNMM1MrRzN4NjFoTXl6?=
 =?utf-8?B?UnBDdUk2U04yeFRaaGYrcFNoaUt0NUxlOWlDcnA1SWNuUHRRNDVtRGVDWnVo?=
 =?utf-8?B?UUNEUHJVYVp6d3poRTQrZURwRk96YUgvK0owM2kyVS9UUytwSEpMSnBmRWJw?=
 =?utf-8?B?dVB5c0djMlVGdkJDdE9TNjNyTTlZM29QQWppeW42SHAra0hLN3lXbnpZYStq?=
 =?utf-8?B?ZlpoVDlIR3YySmwxM21VazNmTnd5a05ZcGRhYXFXT1NFaXcrc0pTMjBFSCs1?=
 =?utf-8?B?c0cxMmtTTkRFUkFLYnJvNTdnS2VMdENrUVlPbHNpZWhzdG8zZmJLYlN3V0FL?=
 =?utf-8?B?UmJUcUdzWVN2a2RMbmpUWjZTdWEyMzM3TW1QR1ZxMDl6VkJOL3hsekFyZnRP?=
 =?utf-8?B?ZnNxYjExZkxvenlsK1dxQjRMM09xeEdGNk81eHZWbURJSGhiUzdPKzkrSGRT?=
 =?utf-8?B?RXRjbGNmRDFDaE1DTCs4V1c2bFVDakErb1l3RUhPbjd2ZWlvdGJ6ZU0vYTQ4?=
 =?utf-8?B?VHcxTlMzUFlFcnV1a1pIYXpNTmhaWmxyZW54cXE2RC93U2pGeStXbkhYaWEy?=
 =?utf-8?B?d21aUmp2bE9JeHJlRjNWemVpVUExdVFSMkJ0S29NLy92Y0hjTXZSRnNUbnpn?=
 =?utf-8?B?TzNHQXRaQjRFTXc1L3ZqSGFFOC9SRkl0QVhORmtEeXFMRWUwQWc5cHJJYnFo?=
 =?utf-8?B?RXZDc25GUWdSYklhaDJXNWFRU0Y5d3FoMnVYeVRQU3ZZTWtscDkrT1ordG4x?=
 =?utf-8?B?dHBMZ2FZWVppQSs5U1hiTTdPY01VaUtRNWhnRG5rR1dPQ1lKeFQ0YkQyRnNU?=
 =?utf-8?B?WkhJK3d4bHdsd0RnOHdGUy9qSTdCRk9tOHpPb25Hd2hGV1F3M0JRTksrOHd1?=
 =?utf-8?B?WVNmODFzNmkrNlExVnBQVEs0Yzh0Y2FlMm56SnRzeHVUTGpNWVdnVEtFeElH?=
 =?utf-8?B?ZEg4UmhqOFlBYWpwSUpVSlhwMVZ0WHVVQVpyZ1BpOTB6VFlHemFXTWI3MlB4?=
 =?utf-8?B?M3JrdWVSWHBPOTJJcE82RGtxQ2NxUkhNbzBQMmNrSHV0eXRkanBtSnF6OWYv?=
 =?utf-8?B?ZWZaYm1mNnR4Qmw4UjlUTGVxZnJ5a1dnVUNOUzFxUEVCaGg0OTNJbkVZT2c1?=
 =?utf-8?B?V1NEaDJjNFR6OW50L3lCM3VVd3hidmkxNmZjVERQVU9LRzV2WUpyNG5CMnc3?=
 =?utf-8?B?UmdGWVBkS1g5UG9rTytRaFo4bURCb3B0NXdUb0w2MlFka2dMR2FCNkxGRzRH?=
 =?utf-8?B?NkpmQ0NxTXNOWFRiSTlzUm44Mm5LbklONmExaDZhSWhqYWFKb05NZEFySTZC?=
 =?utf-8?B?SVVhU0pXbXNzM3g4Rkg3amhPZzFGUWxaeGZIWXBWbThqUEpkUlBNaEswWUQz?=
 =?utf-8?B?NlhsWXdUMFB5cE9DWUIvelBsbytuV0JBaFU4dGFBcW9ZaWZqZnZPV3hZSXR0?=
 =?utf-8?B?cUc5UnIycC9VS3FYTW9YbHZibEYrU3hUS21RU1dNemh2N0dncDl3Mk1HZkJh?=
 =?utf-8?B?TmNteGpVcmxrNTFiajhUS3RKdTBFNmY3Q3ZoOFJsN05tR0ZXNjhkWkhnQkZ1?=
 =?utf-8?B?ZzJlMFJKb1dwNFhzTG94VjlpSjhieDNEclNzL2ZHUElnajRIZEUxRXdTTDdR?=
 =?utf-8?B?VVNJMjdlVk1nYysrVzJCT1I3ZWVOc3M5VllJR2hVTUJRdEwxSWFwTGw0c2Vn?=
 =?utf-8?B?aml3QUI0bUcrUlFuVkVnSC9UckNIUzB0NFVJdmNGY1J1OEVHZ0t0R2NHcStF?=
 =?utf-8?B?WHFweGNjN3NRb0xnNXFRK0hjbG1WODVmaEZvSCt4bGt0dzl5QjJuMWt0TnFq?=
 =?utf-8?B?bGxVcjYyRTJpL01JaEFJWS9vd3lJZmxTQmdHT0VTeW5mYjlPeGtvc0swVjBN?=
 =?utf-8?B?OUVFazBsNHZLT0dUVko3U0N0OHBadzBiTmNaQWN1RzNyQ3RjeVVjTWtJSTZI?=
 =?utf-8?B?UlZDMUpXREhONjNKem41WmFkSkZRNHRPWTBiY0ppU3dzMlhFRjljM3JtZmdl?=
 =?utf-8?B?MzJUbEdabmpNUjROOUlwb1F2RGJoTng4am5RQmVlSVhwMS8vNDg4M09uS3JS?=
 =?utf-8?B?OFVDaWdkR0dvUHBHM2d1MiszNzU2MFBZOW85L0I1cEtka2FXdEJYbzVyZE1Z?=
 =?utf-8?B?Um54cVhvV1M0MjhjWU5xRVJ3U3QrWTFRb0RLUWQ5UytNWXNtSVFva0Y4YzJx?=
 =?utf-8?Q?nCyrZFzeHA2h3rmSOW0VWxg=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d026e37-68f5-43d6-feff-08dc1664d24e
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 07:29:06.3129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 445qi9gWGarKhc6j2ChHCTw7v6TT4BCXsflAT5NnwE3Y1ubbnAC6eMYJCxvKvRElp8+v0fk+2WDEr9o9S7wDlHarreTenTYhzPWRpV34F7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10485

On 15.01.24 21:43, Krzysztof Kozlowski wrote:
> On 15/01/2024 20:43, Javier Carrasco wrote:
>> On 15.01.24 19:11, Krzysztof Kozlowski wrote:
>>> On 15/01/2024 17:24, Javier Carrasco wrote:
>>>> Do you mean that the XVF3500 should not be represented as a platform
>>>> device and instead it should turn into an USB device represented as a
>>>> node of an USB controller? Something like this (Rockchip SoC):
>>>>
>>>> &usb_host1_xhci {
>>>> 	...
>>>>
>>>> 	xvf3500 {
>>>> 		...
>>>> 	};
>>>> };
>>>>
>>>> Did I get you right or is that not the correct representation? Thank you
>>>> again.
>>>
>>> I believe it should be just like onboard hub. I don't understand why
>>> onboard hub was limited to hub, because other USB devices also could be
>>> designed similarly by hardware folks :/
>>>
>>> And if we talk about Linux drivers, then your current solution does not
>>> support suspend/resume and device unbind.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Actually this series is an attempt to get rid of a misuse of the
>> onboard_usb_hub driver by a device that is not a HUB, but requires the
>> platform-part of that driver for the initialization.
> 
> That's just naming issue, isn't it?
> 
>>
>> What would be the best approach to provide support upstream? Should I
>> turn this driver into a generic USB driver that does what the
>> platform-part of the onboard HUB does? Or are we willing to accept
> 
> No, because you did not solve the problems I mentioned. This is neither
> accurate hardware description nor proper Linux driver model handling PM
> and unbind.
> 
You mentioned the PM handling twice, but I am not sure what you mean.
The driver provides callbacks for SIMPLE_DEV_PM_OPS, which I tested in
freeze and memory power states with positive results. On the other hand,
I suppose that you insisted for a good reason, so I would be grateful if
you could show me what I am doing wrong. The macro pattern was taken
from other devices under sound/, which also check CONFIG_PM_SLEEP,
but maybe I took a bad example or missed something.
>> non-HUB devices in the onboard_usb_hub driver even though it supports
>> more operations?
>>
>> I am adding linux-usb to this thread in case someone has other suggestions.
> 
> I don't see any difference between this device and onboard hub. The
> concept and the problem is the same. Therefore either treat it as as
> onboard hub or come with USB-version of PCI power sequencing.
> 
I have nothing against adding this device to onboard_usb_hub as long as
it is valid upstream, so no conflicts arise with new additions to the
list (which was the trigger for all of this with v6.7). That is
obviously the most trivial solution and as you said, it is justs a
naming issue because the power sequence is not HUB-specific.
> https://lore.kernel.org/all/20240104130123.37115-1-brgl@bgdev.pl/
> 
> Best regards,
> Krzysztof
> 
Thanks and best regards,
Javier Carrasco

