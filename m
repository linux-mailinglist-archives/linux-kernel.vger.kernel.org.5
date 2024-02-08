Return-Path: <linux-kernel+bounces-58444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8116184E693
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B941C25990
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69073823A1;
	Thu,  8 Feb 2024 17:22:01 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2056.outbound.protection.outlook.com [40.92.91.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017587C0A9;
	Thu,  8 Feb 2024 17:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707412920; cv=fail; b=BBWhYIWKsAoYCfYQoiZ+PBivMaVTKROpTegWykLy563Sz9jdk49+A1dx/xyIRk/CGOqmkTxTPrrdD7ptfl1S28eqEbo7Q6eLm1b2jnQblg2r/Q7+zVAPJzy+t+/yynRDsN+6Sn/wB+j/dMlYclhu0ba66+XGMPR87r4JTaYwspA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707412920; c=relaxed/simple;
	bh=/O/NT+iT1BhoyyanUvZWSnskpd9KeML5HbkGV4YPp4A=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tn6oK75bNslrkh2J3WKiTs8vGx3pEi8noRZtTVHGI/Z7Uz4j2Ksb+cN9CC4Wm8sIEKItEMCgHGW+IcynXMNUr+flqpLvDcDDYoKltqWLnQLQFs6AoATPCGHGJIJbb9vcgn4+evEchEentbgydZQxWUlFgm+vUd7pndqBETbPJ+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.91.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJGO7I4zwOtMVCwZB1TQEderhiSRQTykOWftH/XtnTXK25D7NF71gamk1Z61MJWm3KNQA8JtvtBFHnn2ZgGgEj5Kms+9Ki/OcwlRMTuNSQNjaBJSp9sNrRIwAEOEU/53tCPuf2xSZCm+1v1NX2t3+bRoGrc3dHP5uBZgu6WHwLwpbiIJorw2f5f66PYC2YgjjDh9ZsOwZ5YQcXwsp8SnmyBDGhCgf5yK1sMcc84IZpwyNRtTnGZahHRoEZDLtawPTa+d3GN1FoAZYODAdexUUsPCBbdOr5EkWySKHmSYUauQw1ieDUDYyzj+/RlkGmpCQlZMlo5MQ1p0Cn1rKd4WWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WO776rI5srl2BHgSilTSAonRjex29oCw/IQMQGBqgcc=;
 b=RBUtN+JkCzawWK6u5imFQY/wV/JKxybtO/y6j6z3SXE5x6MjoS0gJdvv/PTkoZrJKw/p4WPWNlftPsCzAeZQNtmbc+c1zfNwoG/XuBjtt4EHj7+qV/X6XLWdX8+CiF5Zz8KtbHpjDsAOwHngh2YzsUoe1uA8CKC4fwi4/F17qkiK6JH6e5SjNn4dVyQW3l3i5cgckU97+p7E6XRp0KrHQLX6eNc4bK22o5PHrk35OSwqCJNmVfbQMSqfaXnhfT+vwVX+LppezDnPpK17ffDzD8dhPfrNNvXzvSHd9QC6hFY0vLHD2n14ufVjTkyusyYeETJ9+IDZzhQxwidvfBKrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by AS8PR03MB9244.eurprd03.prod.outlook.com (2603:10a6:20b:5c1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 17:21:56 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7249.032; Thu, 8 Feb 2024
 17:21:56 +0000
Message-ID:
 <AS1PR03MB8189F4C542AFE05790E8DFA082442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Thu, 8 Feb 2024 18:21:54 +0100
User-Agent: Mozilla Thunderbird
From: Sergio Palumbo <palumbo.ser@outlook.it>
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU
 SFP
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
 <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcTzMgxmA6WOoiA/@shell.armlinux.org.uk>
 <AS1PR03MB81891A5F3C8B1A7542746CB582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcUBP3g0XNMG/aU2@shell.armlinux.org.uk>
Content-Language: it
In-Reply-To: <ZcUBP3g0XNMG/aU2@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [zJvYg0sHA1aj6IEggzu/oXeNfH2ZRyZJr9WvyES8jOjx5ssZAuY2zMkt3OYgIlON]
X-ClientProxiedBy: MI0P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::10) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <edc37076-b98d-4407-939d-b145306cae3a@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|AS8PR03MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e659dfb-d45e-4974-29db-08dc28ca737a
X-MS-Exchange-SLBlob-MailProps:
	suo+AMQROd6eJEloBuyGSe6B48bIkCW/6RpF7K6v6MiHTWh05NZ6M3wpZRmlECivyBzvrNPwvTDO2MCiHO6vLoDGilssO4Su2hA7VxOdtgAViUGJDgkUCsxU56g2WGmL21SDWlTJEOEl6V9Q6v4g1vcI4LaJ9Y0IssgbcEBTp/KUeC0NCv7j0tO8WtvXOMA2ELJ3knymugHddpHVAwuP6PvjLhG/c5Kx8Y5xLnPLq5KWhrXx6RyfOuWcLangvGSARFtmoZnO+y5TId4SiPO+H3Ns7/zn2hxgRSv5yS6tBQaPDivd3nbDwqGuddqUv0F0kYQ4mB8sOPZ1dSgTNFhVILIw7MZ03dpvSJo8HTHFG/Gd9bSmAgUYkvrmP4wYxcGnDVKCcUZb88pfbkllMyth/Ovn+suBFuLY6zp9tYKulMz8XLUv5gHBDKYJzMy2/I9EU1z8JBJyqDuvhxNHNG8v4qa2jmGq0QOhQfprjQGNK8JD5R2kSaCa5Uz2j0ABoFX3BJ2T6PbLOM9Yd1utgs7Xikm36Gw52WGY/uN5F3bgcb67XKrf/iye05Lac4wVehNjkAepY10U8E3aqHjUusWZWNsdxnO4h+TBRt5lZGyW0y5gtwOmilUSN4qQ7b6uJTOQ15lE4pAo0FhuhnP8Pa2OGOCrqrZpac01U1OZArEubUKSQazBXmDjGsyUEMFtfM/2xuAXADD7SSaEAYj+d65sEd/Y727qKmq/HygwEgpkr6kdvsDGGXju7JWoAMNbm+a7yrH5l/RBnEJEMK1Y8Tp5aO8+gUq5jnJKccEGLswcp65fb81oLXTMHVOBvJyIubxdEK0tioNYDQh3TvzruI8uGA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fSb+1ZXbwd8dbprFkPlSv3yTre4MuPGeLp1GXcDRwKfnEc9bMduXxtm69cwSPtOjQFrVaqrb3/vId8/eUv4NJH1OkcQJXg84A5mqKPYMJQefyvIk8ZnA0JLxQ3fS+pkuThz2ql4+sVlS08GngF41P8iqAfbFng/OYR3HZLtrs1Q844lvpUze9/PNorowyyrS6fz/xd4XJHqXGaBXXBSbk/t/iN1nh3+aa+YeTeHjWKZrYla2bDwkCrMzlXyyr5qzo5Bjkwq6Ar+aR5VejZOcnj+c7W0UwY2QfW+osWrxSTDRk9LClJ9x5Rw+RL5Ei0xKzY0pjzAa/1rM5XCYS9zqBkVbo3CG4fbnFxREVALCdXqqqO5JpINtCkQAM1bXIOZQjLe0NFeWNVqJgoJXzjH0qzRQoNJZ3OHO7upkP9WlObqBtaGKLKGIN0hU6HqauJcobadXpU6cIrHdp2A+HLsIPxRPM7sV8x3RhapqH8FUP1zjTZicavC8i2h6e8wR633wQNo+SUWs2tg0iqejJPabPKeS7EvLDlhCyfbHrX9dg09WZFySdxbV09crh7ehyIGgzDTg6PoDRfadyTC/WopsS8g+j2PPNmZu3sMcVzp0JF+heaJnc+LV8t3RkW6CsuIk3XmjCw3DTmJEFi8mYTj16A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGk2c1hETDd2ZHVRMm1Qd045MGRscDNaTlcrTnJpb1oyTy9JRWp0U0kzMTdl?=
 =?utf-8?B?R2hVeHM4K3JndkRFTm82QXRiVU9hU2UyTEgzOW9HeTE0ZnZWWFRESUl3Q2Vh?=
 =?utf-8?B?M2dyTlVpNlV0WFpjZWpwNy9OVUc3ZDROZFRIbEdETkpLYm1QdWlabEdVeGQ3?=
 =?utf-8?B?QzVzaHVJa0p0ZkxwbHh2M3dydzFCekhNMGZFeFQ5cVN5eWxyTXJOVkg3WThR?=
 =?utf-8?B?bXZzRUJqRUhRTDlyOFA5ZXdXOGVuaHg3T0JNVWpZUVpON0czZHMrRHo5L2tU?=
 =?utf-8?B?NXJWSnB4WWgrSGd5LzlwRTJNY1hzenY2TW9LSzR3NWFxaGtvWmVaNVR2VlVj?=
 =?utf-8?B?Z2NMUUl6R25pWXN2akNacjhhVENvSlR6OU43c2JmOHBvTkRMdkFORks3WC9X?=
 =?utf-8?B?c3BQdUJlWmdLQXlVbkI0VnBpN1JVbzFJTElpYWVtZ1I5M3I4RUkraDk4ai96?=
 =?utf-8?B?Rnh0MXZSM0krMTErM3lEZitKc3R6cGQzcmozL3FTVUM5L1daUmNBU2x2UVRL?=
 =?utf-8?B?NEdYZE9LMnZMVk1DYXQzQXVxalJKZWNRd1ZQbW9VUU42Z0ZaS2tKbWVaajhx?=
 =?utf-8?B?akxDei9NUTBYbDdyNW5NYWVOc213djJ1bWJaWW81S3NHUmxBcXNTcnRHaUlN?=
 =?utf-8?B?VU00alBkQkdDbHdWcUdqSENabVlyMS9yLzl0Smt6a3JSazJZa0ZxdGtKWU80?=
 =?utf-8?B?MURjejRscExKZjRlcGNUT01mVnFKOWdoYWxZNE5tckxtRjVCRWdVTHpSM1Fp?=
 =?utf-8?B?ak1KUGtjNXoxaUNXU0xrM09DSTlFcEdwNHZHMEkzUzMrSEc1MEJrMlJFRGMy?=
 =?utf-8?B?OVRXejhIOVVpUFlkaHh6VzFWQ21CMk56Z01qYTM5dExsbktDZ3UzU0VBK0ph?=
 =?utf-8?B?blBhUUswR3N3emJIUWhNNXdoaVZQVlc5R1ZGUXVoOGJkMHlDUDc3d241ZUJu?=
 =?utf-8?B?bDZPN1NKVURLU1hGelVDK3g0aUpJVHB6OXhGbmt1YmcvVGc4enk4eWJJTjBC?=
 =?utf-8?B?ZjIxYitBa0VTdG45SzZ5ZENwNmdVZXlpRi9XV2k2THpxdzZxRHZtbjdkd3ZI?=
 =?utf-8?B?amcvRFRnSEIxRGVRa1Q2OXB2RlQyRHd3QUJucnF2d2hGT3FkWjNmVTBTaXYz?=
 =?utf-8?B?Ym4vL1F3ZFh2RUo2V1N0Ri91K214b3ovdjFOa0M5TTl3d2M0RzRCSTVlOUpX?=
 =?utf-8?B?ajZiOFNjemkwUmQvc1RCT05CZFJrOExQL1dRQXYvUm5uT1B4OWxNaVhNZnVY?=
 =?utf-8?B?TVdVcXRLbWgwQU8yM2pvK3czR1VQekNKMC9VdXM5aXNIM05wLy8vaHM1MGUz?=
 =?utf-8?B?RGVLMnZsL29Ga0NGekxDTmMvaFBvemxhZlFRLzhaS09Cbm1hekZjejliaHNS?=
 =?utf-8?B?eTRlNGdCN1pabmF1b2t4aVNKOEczKzVRdTYwaThWeW5lZkdDdUsvcFlMUXo0?=
 =?utf-8?B?UlFUMUZuV2FaSjVGeTIySVNRSEc1U2NIRXJQZDM0bWh4eVhlZ2wxcUM3cE9q?=
 =?utf-8?B?YkZ6Z21hcHZJalFDNmVZVjVNOVZMQmo4cHFpNUtCY1JXSFBZdDZtNGdrQUIv?=
 =?utf-8?B?ZDRQMlh2VGFqcllzb1NhVzBkRnh1UGdIOU1ndHE1YWNEQjZqMHFsYzJ5Sms4?=
 =?utf-8?B?eG9sUXA4UnBaRU1aRjd1bVEydklYRVVwVjkzTURLc1JaWG5kWmJSdkZmUy95?=
 =?utf-8?B?bFhqUThwTTVuaVFjNEJnQVdZNENnMm9UdmpTOUo2WGlEUTdqb1dXRmxwbzNr?=
 =?utf-8?Q?4xPvbi3vYerm+rDjQI=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e659dfb-d45e-4974-29db-08dc28ca737a
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:21:56.8540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9244

Hi Russell,
GPON modules we are talking about are all ONT/ONU and all the ONT ONU 
are configured by OLT unless you have a modded firmware.
ODI DFP-34X-2C2 is an ONT/ONU.
https://hack-gpon.org/ont-huawei-ma5671a/
https://hack-gpon.org/ont-fs-com-gpon-onu-stick-with-mac/
https://hack-gpon.org/ont-odi-realtek-dfp-34x-2c2/

I think the discussion on LAN_SDS_MODE=1 or LAN_SDS_MODE=6, started by 
me is not part of the problem as the system after the quirk is working 
at 2500-X with both settings. My fault!
The problem for these kind of modules is simply that they are not 
showing up at 2500-X because EEPROM or Virtual EEPROM (in case of 
MA5671A) failure to provide the correct speed to the linux driver.

Huawei MA5671A and Fiberstone GPON-ONU-34-20BI require:
"sfp_quirk_2500basex" and "sfp_fixup_ignore_tx_fault" quirks
ODI DFP-34X-2C2
only require "sfp_quirk_2500basex"

Hope this may help.

Regards

Sergio Palumbo














Il 08/02/2024 17:28, Russell King (Oracle) ha scritto:
> On Thu, Feb 08, 2024 at 05:19:24PM +0100, Sergio Palumbo wrote:
>> Dear Russell,
>> I understand your point, but I think ODI DFP-34X-2C2 situation is quite
>> similar to:
>> FS GPON-INU-34-20BI
>> HUAWEI MA5671A
> MA5671A is configured by the OLT. The user can't configure it.
>


