Return-Path: <linux-kernel+bounces-58337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A13F84E4DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4B99B20B94
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE17E594;
	Thu,  8 Feb 2024 16:19:32 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04olkn2011.outbound.protection.outlook.com [40.92.74.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132C7CF29;
	Thu,  8 Feb 2024 16:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.74.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409171; cv=fail; b=K3tuL4vOLB/lNW6T72r9rr1dRcdJGFu/ERD+LdqV9QdmWgLObAVfOPU8g/Etc5pyQjprAuf7nPnLtJmpQcxVjwsWLeI3BJ2XJtNh0q6kPMLwI9/bd4UEWkZKHOCocbSzFNOWfwrRmmWPmMfCWfbqKIVcOPdLENFEIUGnZJyK09k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409171; c=relaxed/simple;
	bh=e9PHrKhQPVwvd0TopNoGkoexbfRVEegKIthPxtPzfrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZNSdekYExN1mWoc5qon9sKUpjyyic5oe/8eAjUpK8MA6e2ZiwC9O0waXjLPeZpXezz8XOUnbTqFT0PLtDqJEF86mmTt+xe/pdBU8JzLhJIX0mY5YA2WgrytBx07IDqRv7ew89VkasEdeK9jQszNeC3p7cnvTu03p2Bunu+SEGpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.74.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWIGKba5AKv7YUa2HzmPEY5RIx1JK+Ni9lU3kKEehhCLmIjww4+FfucqIDFNwdc2az7MK/dUQFxPXU4oiEbT+w85uOgs1CT8pJ45uSmoR1QZi5Al8fauTD9X2d3S2LfH9dWiuiG1C5+wO4KfUo5meFItRFcCN9i7xUhbjS483TpO0e9c3uWb07uKib48ubBuXEcBkqP7pSMkiTyO8Z2mceev8x742c30jl+XlvHtT21SvL3RJ0eXHNIXG6i+YfKYZiI0kHakHcAwfDTVaCzXyL8vGTGHh2Tu4gm9jPD4dIcx/e2mbrBS+AuofZu6OBhgankhl8bntZrSpUerZOAPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EApYE4rxTpCl0B1TMZghyqcl4NNAU2KedmOOYvur6uE=;
 b=f63RSk2Ye0DELc1YyQbRLNUFVo/lYA/+DYEDT6x/tOnttjlkNcu9b28pnbuRKIkTNhYPJIan8ZppAsorg2/nW7Qg4Y4uopEpNqRjCvUkpDhqmBzej6DDZKLqjDWj61X0VUyo9mh7zmepiCMRPMQF+LAuK2LXn3M9qKmAHn2j4CSi+11vuUXeQwIYiaARHDmAnV3VHm6IEdG5E6Zg+HeZ41txtbWFzStp1nSBxeKm0eD3pK6+eWh4h2mUlk4Q00MFuoLyGMSdgcePDqp4hqko959+P3UW7/dbU2GigNgtpZ+tUDlOShHiOWwxDF3yZst8Ho9uVMcrsR3PglZwvbGv2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by PAXPR03MB7611.eurprd03.prod.outlook.com (2603:10a6:102:205::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 16:19:27 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7249.032; Thu, 8 Feb 2024
 16:19:27 +0000
Message-ID:
 <AS1PR03MB81891A5F3C8B1A7542746CB582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Thu, 8 Feb 2024 17:19:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU
 SFP
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
 <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb1+p6FiJwUF53xc@shell.armlinux.org.uk>
 <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
 <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcTzMgxmA6WOoiA/@shell.armlinux.org.uk>
Content-Language: it
From: Sergio Palumbo <palumbo.ser@outlook.it>
In-Reply-To: <ZcTzMgxmA6WOoiA/@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [SKJ2drmKx7zqFGdGXA8huUNbgN7eAgZ9EMRNtvvW93Wv05jlhIaG4eeRsHE+Ij13]
X-ClientProxiedBy: MI1P293CA0028.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::20) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <ac202d64-1932-404d-8292-17d7d23cd249@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|PAXPR03MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: be3237a6-e3fd-4799-9170-08dc28c1b874
X-MS-Exchange-SLBlob-MailProps:
	AlkLxVwsndkxOEFX7LxSQcUfT4PsOD3o9hIqqxyxUDd7UIP9kMolFpukKoQ5aCEyhCTZk90Kz9k0Z0p4QfgWs1zuufM0zOW3l5C5KrCKAmkaavQskyiHrLs3X7Ra0kEZfuIf68taI9O1qwbdtuKMXM4gDCyXMW1WpUsbNKkAXWWcE/j+443SEnbi+0Xh/PzRQSmjFFf/uykCtGuWYwqJZ+gGKqCoG7j2N1D55Ca3Gqq/Ed3FOKuAaEW4JuV7InbswZkygPJ1fcW33HOs5aIEE30cGg09glhqIhwe2q728VJHF0lHhl6kEF21g8gHPRAVNQ72spNkJ8zfcXx0rg7Y3YDYJ7LSD03HKAdTyNLJ25t8a+MBdzCfjQiufSbq2UCHBzYbgbRLwcmDZBgoRzfuwLRNkghE08/GA0BGsN/WJwOunghaR6q80fopxaQCEfKiGdAQon7xZJ0ejNwqXvnCHhsZPJySyAlqev+RUJIhSDpTL+MoUTaQyGMpIf6DdTDlHHfSB4853esOjmS0RvAOnG9TSnyz/nrSIjEGRJKNe1bEesXDAotcO6OYV+crWns+S3oADjJK7uqwJ87AjAQcF8Mv759XGgyYAKu8yJM09NRUfi+qk9cTPj3KRiYW53udEyiWO1m44fO+n/qZxfIbYMB2lz5vWSAwJ0ZnSRUqa1eys0sYakJn95FcuW7c2C9TJS0ikjP4jc8UICI4bsFacTt7eW0Pa/ksmFp+uK7x8BR9ZBgfNkNArS8JwEC2Iuq1+H/jm0MGsTr0x2VW5ZfNRAK0RzlDjqnA
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VHf3cdtQyJLIOYuNbDL9dDnOuUW0dHySFpFXRiK/XfUqwm84svN8sn/bMrhUraoMibFcs4GmPKVFXnf8R9LJuO+x0deq6keW4S1RoOppqkN3Q6DNEpwaZt04/C3hapCeVbXxEnSmCJwlP3IuSFXcA0LZ3wuL2r3mAFbn+q7NqoIEJZS9Nh2vE7tsKp6M0vXvHJMP9zn4dTyGhi5JZbmP5g7fZ62vnNVUhEdwJ8Hxe13VZHeOnwb7NnW9USmrlQnqsQNK3pWseTch6g00N5u9onOGAX7d4DlLpaMC9s94vglomtHWw+1uF8qIczf9CQHwErknnXT3NzAdE0AeSFC+zvDxpH2Gg4VA0BSUgXkk8w+4SGq64m5xPEIMKSmkY9siTHwYvSmsuOAjHl3whvIaHwlhOtzzgK82LPq1HO0RWyOHNTfWz9KJ6Ven9oiILYlckH78vBVX/NWNzx0jbKXAvuh5/bSCKZntAIGe139/Y9+9rXidIAfdnCIqTKPEOwdxL8OV+5fE6PqKsGnqsESzw8s3hXis8h9MVUp8/m9tP3ebu4Fgn0j4fdr8nIUQJveY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anhmZlJ3bmdlZjIyZzFvNGRtakU3VlVKeDQzWWV5WTA3cVhkWDdXbFRNTkZq?=
 =?utf-8?B?S1h4MjZ1SytmKzRPK1pCQlRRMGRoN3ZaYnJyci9Tczd5bmk4TnJRYlRZWnpQ?=
 =?utf-8?B?dlBHM3dJcUpNU0d4NmhCSFJubWRERWpoU0hqR3FEMW05SW83VkczUUFlMzVw?=
 =?utf-8?B?dEMzQnRoMUxUN3VCT3ZlbGUvYUY5a1NaRlNMT2tydTRaZmVrZVFzVGMrU2lR?=
 =?utf-8?B?cFRZUnR3aHN5dUtPcnhWWTIrUVlzWk5sQzJqL0srb2lvbWxlKzRDRnh2TmRC?=
 =?utf-8?B?YkJtL3ovQ1hFQ0tveFRiVXQvbjgxTlp6YnJodTBHek4yVmtXYzA4N2x5bmR3?=
 =?utf-8?B?c2FOUmJTbXpTMHowMWp4c29XVDRUUXJKQXdkRmE1RVFQQmErM3ZnOG1lZTJr?=
 =?utf-8?B?YWNKWVEzWmxFT2tINXdiZzBiRUlrTmhTdHQyNmdFMjBnTEJtVzVXem13MlI3?=
 =?utf-8?B?K1dmVWdlOGc5WW9sNElLU25IOGhlUnhUWW9PWGdRVFV3Q3ZjS2pkOTJzNEdu?=
 =?utf-8?B?OXFiRVo5QlpocUhOMVVTQUNWZHVMck8xbW9XZEkvUHlqTE9LMlBGaGFtZWdl?=
 =?utf-8?B?TkFtUWZ0R1RkL1lOMXdYbU0xOTFzZUhoY2VOWlp1OHo3RG1DSGwxOGJiQW92?=
 =?utf-8?B?RG4zTkJXNzdSMUVKN2V5aVkweHd5T1dTVnlFTUxUanJuamRTZWppK2wrMmpz?=
 =?utf-8?B?NUpRQUEzMVQ5K05jQzJnTmtTNVBIalpKRGc0TzZhdGc1K2RDWTREMWVua1lW?=
 =?utf-8?B?K1dBdG5jQ3ZLd2VHRGwvVEg2c1kzM0RETG1tUEpyVlQ5cExpV0szMmtBaU5O?=
 =?utf-8?B?RjZwSkFHMC9HbGNXVHRuZ1R3VC80dEpCWXZlY2tmZWNWam5ycE5qSSsveWVw?=
 =?utf-8?B?MkVIVHp6eXJrL25JcWpOQWIrTlo4NzNyTFVVYlVjeStZd1FhallObTMvalhY?=
 =?utf-8?B?RmVKRTZET3RNWExlNnp5VEdtcnNuTjVUVTFpQm1ZMU5WL2NXakpzWHBxRE9h?=
 =?utf-8?B?Umo2endoOFEwODlBRUwwYVVFbXJvZDYxTnlvUzBwUzVpK1lFN295Mlo1dE1a?=
 =?utf-8?B?SXNWTkp2ZjFXdmsrNXI1NXNtNEZRaFZDeU9neEl3cXZHWE9Dc0t4dDd4RUJw?=
 =?utf-8?B?UDFXYk5HeVNPU3R4Y2RERFU4bjFDUWNRSFZTSmhUN2JFOEVEYlF3L3NDeWlI?=
 =?utf-8?B?WGtEUWhuekFMMEh6UDFKUkRpRHVhZHRwWnMybTRjeDExMk15ZEtGbFZNSnl6?=
 =?utf-8?B?MFMrWG05Qjh5b0diOWdDYnA0T2xMT1ZUTnB3MVNVNllWOE5uKzZ2NityWVFW?=
 =?utf-8?B?SE9yODY4aTdCUmIycFZ5cWZiMzBNeEVXRDZuTWFPK2xBZEtLVkp0NjdEdFlO?=
 =?utf-8?B?dlRPdm5EdnVnbGRXWVlIWHlhNFBNSFE0M2pQOGU0cW8xYzg4aVRUSlAyOWNU?=
 =?utf-8?B?OWtTUCtIcldvVU43c0sxUEdrMW15UHZ0a0VrOURIeDExd3hEQ2dyL2tZQlpp?=
 =?utf-8?B?UFM4dHEwUm53cllzc1BwSGtTYlJnYnp5N0pPWDJGZWo5eEdvMWtWamdzZHpR?=
 =?utf-8?B?WTRsbmFDZG9Tb25LeVpsakVxSm0wc2UyTXJYOFFoMlJaazkrVWNyVlVKTFBp?=
 =?utf-8?B?TU5hS1J5aDQxSldWYWlrdjlOYm9zbXIvZmNqQmZmanNzOXRhblNQak5FVjFG?=
 =?utf-8?B?ajVQcVd0NXh4bGNXcmdxNmdkQ1dJTm5WamlJRkhQUm9HaWV6cmJUWmtzS29m?=
 =?utf-8?Q?X48XU/waAXuEA/E4C8=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: be3237a6-e3fd-4799-9170-08dc28c1b874
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 16:19:27.0911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7611

Dear Russell,
I understand your point, but I think ODI DFP-34X-2C2 situation is quite 
similar to:
FS GPON-INU-34-20BI
HUAWEI MA5671A
which are incorrectly reporting the speed in their EEPROM
These modules are working at both 1000-X and 2500-X but in order to work 
at 2500-X they need the quirk.
Same as ODI DFP-34X-2C2
I'm also quite sure that those modules are used and working in openwrt 
being GPON modules.
Was this test also done before accepting the patch/quirk for those modules?
Thanks for your help and regards

Sergio Palumbo




Il 08/02/2024 16:28, Russell King (Oracle) ha scritto:
> On Thu, Feb 08, 2024 at 03:00:08PM +0100, Sergio Palumbo wrote:
>> Dear Russel,
>> this is the first time I do such a test and kindly ask you to help me in
>> preparing it.
>> In my openwrt environment I have found phylink.c file in two different
>> directories:
>> /build_dir/toolchain-aarch64_cortex-a53__gcc-112.30_musl/linux-5.15.137/drivers/net/phy
>> /build_dir/toolchain-aarch64_cortex-a53__gcc-112.30_musllinux-mediatek_filogic/linux-5.15.137/drivers/net/phy
> Oh, openwrt. That means I need to re-understand their build system to
> advise how to do it. I only know the mainline kernel.
>
>> do I have to change both adding a line:
>> #define DEBUG
>>
>> before the first #define line:
>> #define SUPPORTED_interfaces \
> Mainline has never had "SUPPORTED_interfaces" in phylink.c, so I'm
> wondeirng what that's about. I'm also wondering what other changes
> there are to it. I'm also wondering whether the behaviour you're
> seeing is somehow special to openwrt. Too many things to wonder about
> and effectively means there's too much that I don't know.
>
> Therefore, I don't think I can help you, and I don't think I can
> possibly accept your proposal for this quirk. For mainline, as far
> as I'm aware, it will cause these modules to regress when they are
> in the manufacturer default state when used with a host that supports
> both 1000base-X and 2500base-X.
>


