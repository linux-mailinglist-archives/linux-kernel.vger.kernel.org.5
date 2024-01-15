Return-Path: <linux-kernel+bounces-26439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B15882E0D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B3A028337D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9DA18E15;
	Mon, 15 Jan 2024 19:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="o/Rb1ICE"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2083.outbound.protection.outlook.com [40.107.22.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE8618C01;
	Mon, 15 Jan 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SZHid6C0sttxi/N/gmCO2DM+hV2ClemqEOICg/1hVtSi1aNtvKI2w/g94TFykHgm9QMLX9VV2xXZqnrkK/8Yfz0xhrp9t0gjk+GGgsxdjzh6b3984000lQzZ08ouKbeX230o2cIOhm8H0GCGuTFjRpbc2JQB/N1kNS85zYoWehYd5mgkOJoZsjRffSxisnoctkp3Wjvrh9Gj9XE1PO/R6bgeWzqdzEAdk6XKzdSJWu61Xo3bcziHVoWlHimFj+6KqZyry6CP1YU2XCYzv01jjEuGF5atQwq0vg1ok0bbJYbG/pEfyB1/sKITTMN6+jUJw1mJDbGGEsuQWQnLVBZRXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNcDV90nkyrnFhA9zP9hYXg+VtzHw4Wdw2Txx8QTmts=;
 b=Fnl+lnjoPGbPx0c6Vaq84SsT806fG/+S7JKIYAxi4MDXHmdnuymQh+fsCX4sv/dZv9jSQRsGmWTwu463hzO5brGKPNTro2vKpoiUcsOIkR44pQoAU3+jCBzazF4gLSqHXBhRNySlHeUHBzP9MvNy7hkwEsmw75lyi0XmjGHv7PYBGVL8JYnZQ6/kW4BVcB9xyIpX4IWJfhV106CdJRSBhVfgRR8uOww/1SpOu2L5TU7bG2X1s+iP2b8KCJmt28XC77zXh45SIs/ZWjWvJOMjZwZDkrtTOE2fd32X5PCD3dXUum5Ig4TmIz8QxbQ5x9qAPmVZwsS+xGkvTcmdpblVNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNcDV90nkyrnFhA9zP9hYXg+VtzHw4Wdw2Txx8QTmts=;
 b=o/Rb1ICExPhn4aBAWZxtp5FG91VQX+9jnbwQNMAXvDOtHYaiKdKgm1nJgzUuoInQZIol06ijF2FCiriPaFF7Q/yjjY9JHUOkHpZr1BsvKUHsoOnliiHqunh9f+8C+wdsB6N7RiE3z8zBUQSxOrykDrZPzcWsnvJbnBaCzLoMtAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAXPR08MB7670.eurprd08.prod.outlook.com (2603:10a6:102:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Mon, 15 Jan
 2024 19:43:13 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7181.026; Mon, 15 Jan 2024
 19:43:12 +0000
Message-ID: <16027339-0a82-4dd1-86aa-19fda6e23f88@wolfvision.net>
Date: Mon, 15 Jan 2024 20:43:09 +0100
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
Content-Language: en-US
From: Javier Carrasco <javier.carrasco@wolfvision.net>
In-Reply-To: <47bdc31c-50d2-4d33-9339-5132b6364539@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0376.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::19) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAXPR08MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e565e4f-baeb-4cd7-6c92-08dc1602357c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uOGAAlTUzmHk0LRFKefn8nMaLocX/ThKdytLOOUZsxBWolF8cPfuyUkKpKcpWEsy55Xonh99NEz9IIdrlhdxRfDYyg+jFR7E+NgYuEIdSGwJK+njhn99/pvgQ5z9XROLeObPFkvZWBcsA0ZATS59ZRp/4T+OGEeMPEJRlviI1NO/w37ag6YOf6hCih8C+L9ivwZ9Li1Sb7qJzN1OLXs9UE+GesTsDLjJOW0RyfVgWgR/uJiG2lzojerKrJ0Hjsqno1KeLN5+5k18Sfntf1FTVhqFgyz060NizalKNHzv80J2Vf/iC+IXCVfr1EsBO4QzjT/gaHFwDRiceADgtXbWLEPrU0bILhzjahGE0uIwo72T5iaGl/bDIKgaCp8Dw01w8409WA4FLYo1eO2qUwqtNqw8Ed4iZOVUT4TufAdeN/Q9pF+aycV1uWdubI6pE60Z57hbvMEXzuGoM/II/Vwqo06qgfSv4ghJbmPnwM6kWkJCQpDnu2Z037oVAA+LTEKkg2lg9R1RvT5q7tBDTA4u3yr4lafkZRmjc98WPE5c/GUZKeyqlLBnQyKNL21ZIkra8Dpi5z6iXxUlMXhws1zoGij+1Cw3695va8wIPcuklPObL7xgwjUEj5axhoFYX8+KuVtRVQ2gSgYbsfeaaIgVKA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(396003)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6506007)(2616005)(38100700002)(36756003)(31686004)(31696002)(86362001)(53546011)(6512007)(8936002)(66476007)(8676002)(6486002)(110136005)(6666004)(478600001)(316002)(66556008)(83380400001)(66946007)(2906002)(4326008)(7416002)(44832011)(5660300002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnA1bXM0aUh2NFNybVh5a0tnNEJFUHdSSUpyTnhQMUwvTS9NQ2p0djl2VFhs?=
 =?utf-8?B?Vkg1djBucVY4REh4Y3N5ZG13b0pvZnVuNjR3MWJHUHVTKzJKVTVSWVcwN3Jn?=
 =?utf-8?B?SzU2bENOYXJSSzByZ1RIV1ZucFpHQzhvcVUwQ1p5Tk16RGdQcGhnQlV2TkJ0?=
 =?utf-8?B?YUpwSUNVYmJISWlhOTk2SVQ1Ym54OHpPUUhBeVl0NUlzanpxaHBleDVsSGNw?=
 =?utf-8?B?dlhnbWlveHFyK3RvMlhCdm53UG51K1JtbU9vaXU1UjlKdE4vMFQ2TkZOaEIy?=
 =?utf-8?B?ci93b3BCMk5KVDZ0T3lnbW5BTCs4WUtCZlZoZGFBL1h5TmowSDdrbVF5aHdO?=
 =?utf-8?B?N3JkVkdmZlJ1TFRPL2V1VWkrdmwyRVpVL0hoazU5QUR3aUFyamYwVXJvOCtk?=
 =?utf-8?B?K0dSTTVDblNiR1RQeFlZTUVYWDU5TVJ4U2EvQzVxMktMSjVHL1RUbWh0TE1w?=
 =?utf-8?B?cmlQZUkrakVtTzFuL2xYTnA5eUE3aUo1NHdmUWVQU3NRREZWWlZPbXhORHoy?=
 =?utf-8?B?YVJRclhzVitiWGdNOVYxL1lxR3hPbUJPMUlnd09IckZZMWhmSmltOFYyOEdn?=
 =?utf-8?B?N05SSWVMTWRwRUdyN1lsSkhreFp4M1FoR2pVSDNXYTlLRi94WGx4cFhEOFJ2?=
 =?utf-8?B?azJZSFkwM3I0T3dRSkVLS2xJeXppSXBiMXFjSTZUWkRtU3NvWGVUTk9kcjJi?=
 =?utf-8?B?c0VVYm9ESnBoYi96UjhDbjg4VG9XNjNzTG8rNWw3UUpjUGRPcm5uSXpZQ3M3?=
 =?utf-8?B?V1JKbDA1Zk9Qbi84dVBzVzdYa0tla0xVTmVtNjhicldSOU1QdG95NzVyUk5n?=
 =?utf-8?B?L24xWlFMRnhlaTVkTmd4ZlhXZ0pWY0ZoeFVzakhBbHJnNllvclRWT0tOUW1r?=
 =?utf-8?B?cjdkSXRhK1NNVU55OXk1aWFlV1FKTElFbE1hQThnbk5xd1o0SXlKZUN6UUVB?=
 =?utf-8?B?Z0orOHVKM05JbzNBYUxMUDVwSjVnUzZOWDJBU0NENE91WEhjVE9jRjBJVy8r?=
 =?utf-8?B?WG5rbzMzMkdHTmc3QXlaZ0hjR2ZxVWNKcXNOTkFoZUtEMytlUm94cDJJSVBk?=
 =?utf-8?B?dGlRZkNRQlpOK2hReng1UUExL284VWt3V2tZZ0lyR3lZWk9aMFJvektrRGxZ?=
 =?utf-8?B?d01vSGllSnQxQ2FsSVVMbDZwMDlOUjZVQlpCamxUWWdLaHJNNzlCNE4yZy9J?=
 =?utf-8?B?aENkQ0kyM3dwYXJoRWUvK2xEUXpwZ2g0MUtlZDZZV21KenJMOGFIWktBMUZO?=
 =?utf-8?B?QWIvMldpMjVteXF0UnR5WmlaR3RFTy94S1pPM1BHUzNNa1k2S0N4MWtqSW9C?=
 =?utf-8?B?azRLSGFxSWtHM0dCRWsxb0RZUWkvanRzaEE5SzZxVGZLT3JXenNQc1EyQ3pr?=
 =?utf-8?B?RTdKYkx6bXo5RnN2Rk5iMUd0NHBUTGpLWHNrUGJXcTdOOWY5L1dGSW5UdXY3?=
 =?utf-8?B?WXJTY0Vva044NnR4aTF1TDNmR010Q0tNaTBqaXF1amszK2FXelEzb0lMTGpq?=
 =?utf-8?B?VEVQUzM3WmNRT3FueUx4NCttbjVkSlR3UDNYYmx3eTdXVjlmcWp3OGx1U2Rp?=
 =?utf-8?B?SGhQMVpzUFo5Mlo5YlFuMGlJSUs3Y3B0ZzlDVlFHcU9VNmRXZSs3NGJBLzlC?=
 =?utf-8?B?bjhFWjZCT1NYTWNlaVdoTk1Kb3hCWTZyWFpFUjFIRG16YzFwUW95eDFGekI5?=
 =?utf-8?B?OGZRbzZ2T05qQ3puVXUxRFNzbDlwY0hoc1BMcVlkVWwxWGdsQytFYnFyeENC?=
 =?utf-8?B?cnNZZXRlY2hhU21WemsvUVJWWTlOVUQ2NmN1dGFCNmlmYWIyUEZhRlJNZkdt?=
 =?utf-8?B?ODlNVk4xa0pyYm5wVXJxOTB0WU1tNGpwdWRuYXNUalBoMjZGVnhIWFgvL2Jr?=
 =?utf-8?B?VnluaUF4cHVxTFk5RlhlUXQ4UlRlSXBBNElsSWlGQVZJN0JqYit0b2ovSEw4?=
 =?utf-8?B?NmFhZXVzUHRtdUsxZFJYQUpjZkNRVjlWVE81T1YwSzZxMFBtZFdkNk1qZnA1?=
 =?utf-8?B?T3phT2ZhWWdJa2h1NEN3OUJIU2tpYklYWTlrb1p0UGJYNVVjWndZNVN4bDVo?=
 =?utf-8?B?eTZiaFFwMURZVVBXY0hGUWlaMWsxMktaYTVmdHYyTGJWWUlnRlFqZUhLeFpE?=
 =?utf-8?B?cFh2b2R6UjF3WVcxTUJ0ajZUQXEyRjZxNGo0VVVPMitYZU5Pa3NGQUhGZmJK?=
 =?utf-8?B?dm1GbzkyaEZ4K0sybkhPOU9sdW5KT2UyYXdzeW4zZFlRTWE3S0FtNXI2Sjdj?=
 =?utf-8?Q?33qJpTfdYFOgih3tI9XVII6FPfGAwK0u+B5e9xvZDM=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e565e4f-baeb-4cd7-6c92-08dc1602357c
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 19:43:12.5099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RcYHLXyHhJrzV8HxathjjiglHVCOV71zd+FEnNxgVbzfsRtIwCE2RepWLBGfzU1/5GgNE22pf/B5qElW0j5HaoGbO+fQwAIuTwrSYnjv9Yw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7670

On 15.01.24 19:11, Krzysztof Kozlowski wrote:
> On 15/01/2024 17:24, Javier Carrasco wrote:
>> Do you mean that the XVF3500 should not be represented as a platform
>> device and instead it should turn into an USB device represented as a
>> node of an USB controller? Something like this (Rockchip SoC):
>>
>> &usb_host1_xhci {
>> 	...
>>
>> 	xvf3500 {
>> 		...
>> 	};
>> };
>>
>> Did I get you right or is that not the correct representation? Thank you
>> again.
> 
> I believe it should be just like onboard hub. I don't understand why
> onboard hub was limited to hub, because other USB devices also could be
> designed similarly by hardware folks :/
> 
> And if we talk about Linux drivers, then your current solution does not
> support suspend/resume and device unbind.
> 
> Best regards,
> Krzysztof
> 

Actually this series is an attempt to get rid of a misuse of the
onboard_usb_hub driver by a device that is not a HUB, but requires the
platform-part of that driver for the initialization.

What would be the best approach to provide support upstream? Should I
turn this driver into a generic USB driver that does what the
platform-part of the onboard HUB does? Or are we willing to accept
non-HUB devices in the onboard_usb_hub driver even though it supports
more operations?

I am adding linux-usb to this thread in case someone has other suggestions.

Thanks and best regards,
Javier Carrasco





