Return-Path: <linux-kernel+bounces-50705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F26E847D1A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A394F1C250F7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9670A12C80A;
	Fri,  2 Feb 2024 23:18:23 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2031.outbound.protection.outlook.com [40.92.91.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAE41EEE7;
	Fri,  2 Feb 2024 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706915902; cv=fail; b=rKk4KqEHJiw2Lk/AYaGdXpbzeru3aJucakwSZ33o+Bf5/ay5UR7JYK9Qn6RzVRA7hqpHr9q+g72ymPfUaObLxSTM2VJk4fL3sMXvpjN40M4DYpvfYX8kXLNOoZ052A6I6NNaM/v5J/km7UMiNEn6PIOcCze9Ee0dWnXgU5FchUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706915902; c=relaxed/simple;
	bh=IyXJvgNuIwsdXWlqvyjeSsFUL34V47fn6nw4rmsV9jA=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YdY1cN2CgoQQ5UxfglKSLC92oa5LAO/lNs4Cbwjx0Dhx8S1gwYK4jEHfb3xA76SNR77qQ6CcDDBNewD3+UmSEyse6oKoCStkrer/eGLatKKpDu3Rve1JJFE7jds1EkHJPzCP8/CnL633W1cq6RgeliqR92In/Iz0mztKfsF7X8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.91.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MuF1p+SAlAGZc4U9TXZLSVR1CBagMKYykciXhgNzfPYhOOJdS9EebUMhkNQ3/11wmQFvOL/9+IeeJPhxZYnbzwY7TAGsu0IpQoWy9R5sHXvP7yvPKFo/qmBgW+3gwk6JIeh7moQdgwOO3+pQ+zV0FGICtqEtTll9Go+uQX33268/ghvCFHvmVuXOJejAr9waXldwct4Srpx0RzwVN+jRwpaM0CIrPAD5tYVTdPVyPPSfvR7k+5kxpgkV9L2pA30aYDYMa6Rv2bCp7Dt0D1VQHU4F+TKiahrLorS1D4FtC73xEWEdnHEtn/rR0oMokL6dPpgm4q1XpH1hIOGmmTplIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UckP0dmTkqRTCU1OYbtyYJ1mg4WuQhLwmHmqYOoZZw=;
 b=OJrQCueJg3uJEf320rB24d4rcaa6U3FKlI4tOZ2yx4I5RjsbOnusZCgmK6N9F3Rw7/WwVbJaU7h7g7lgx0171ODhZlJrspjpBKZx9cmTbj5ir16t3ClkNl44bFxyW7Lvmv0duPUMy2XOuXamajnWCjfATISo2tVOAexZutwnwqmT+2iCr1WxGL3RYuI+GSET4uBaNWu18Fsd0X3NOZ1cYKjt91A/Z4++ZM0Ps778crg2D0io15ypjzWyN6QHfJxUk56jcFmvqH+qGg/cYja6i0QCXLN8vOyMCIsC2GPRgcfRu2zhg6v9Iigw90DmYWJUCbAkRYokK9Rea6eJCdO0fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by AS8PR03MB7239.eurprd03.prod.outlook.com (2603:10a6:20b:2eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.31; Fri, 2 Feb
 2024 23:18:16 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7202.035; Fri, 2 Feb 2024
 23:18:16 +0000
Message-ID:
 <AS1PR03MB8189D48114A559B080AF5BEA82422@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Sat, 3 Feb 2024 00:18:13 +0100
User-Agent: Mozilla Thunderbird
From: Sergio Palumbo <palumbo.ser@outlook.it>
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU
 SFP
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AS1PR03MB8189AD85CEB6E139F27307D3827F2@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZbZn8oCiyc1aNPuW@shell.armlinux.org.uk>
 <AS1PR03MB8189B99C360FB403B8A0DD6882422@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
Content-Language: it
In-Reply-To: <Zb0t+zKHx+0wTXH5@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [ndP3sb6i8tlPcCS47fFEJhc8VYazFblxJxunVHwgQQGBdczloJ6YbeTbv0Y2W28F]
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To AS1PR03MB8189.eurprd03.prod.outlook.com
 (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <d28a1b4b-4809-483c-ba32-1eaef4421122@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|AS8PR03MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ce0a2a5-ff5a-4e8d-d2e2-08dc24453c40
X-MS-Exchange-SLBlob-MailProps:
	AlkLxVwsndnKCvQ/MAtVGZuRYfxhVfNmT+28bNf9n2b2i8hcFKXFyisW1vO/MASiwLp9KRyyjqn5Vo0S6JN/w6nxexuls0ZkYxsHcfJA6Lwqy5h7j9Jb/J7PIlDQhRR0p8YyZel341FVEzLbtxjcJC2au2XQeJ8JlN1Zh2B6vV0XVUsL9M8hjkiKrs58/nKzznjUSnbGpLwVx3zYiC/p2S+whblePZPCOGaVXIBg+NM7huwdcJJ0LU66V4+7qd7ck4Zs2tMCyFEOdF2rLknEEFjqQGb5SZ7lS+ZxcDT+8Jdb4ir2CCMowX5Ee9KYoJfjukmYP9yl8R3XtN8anra9LBYqFN3EJ94AymcJK3D6MSQs6EGP4I+KHwKR3cLlJH3Yhwj/Z1rgckH+18ARABtG1eGETTL0vXA8VLW57d7yrCXsHRqnpUtO2H35st88ltBQIAq2e5ni3gajoFuDVReynWJf8IwduFZJyyAAqw5OEXSOjJz+ycfOdy0jesfEywzhMxV01KhN1vQ4m8M9sltz6BkZgQurs7kVgDsyxn2idI5mfFEjY+rPb4s06qOMBXPiA4Agj+roe6Whu9cP6cmnZ0AyAAHRQGbc9Vvu3KeMvn19kIx6p5C5VqcdrcveUfYXGXgwVAu34MM9gssBEjTCDG3tq7sRrvUkWh+2cxhhKx9i/SHBqMNNfSugSLLEnwPsFKn1zUyCy/uwSNawuwKdbo6amPmW+meNdcdh7vzZaOnhqWBWERzV3Zz+ELUmopfhKHocUnpJyo/W1GUa3ybPbfbuVV9/5I+3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7iS6l6aqRq+6EuXAxTLfdOZwJD2scjPmZorSo7YKROEfMB3iTtcpfURfm8Z9wIXCg7XeztYIvFw0nPQBaKGIiBHVYthG3paVZITpLFBjFhvrV65ZDqpJwlsWul1IuQ0fH9PfM+a2+ZcqdGVFzovPQ+E/IPPo3all9Q5ys2zSMGBg3Z5i6gu4E7NPZOa7KivQjy+x+GDrzQL1w4M9iPxiAQ6ZMQDdKtOD02nZLul0UxSFLBgW7GG7IEA/uyjLzacf1o3LrAi46TkqfxF6XrYvk8Mj4J929dZiYCZdNJmMHLGzfusW67qq2ge+aZFWpZFtDqo5fVAU4KKCq/Xmn7Nv0tHXb+mY8ZVttg9vx4gpjnQAnuYCOyxWYE9nJ+gOZ13fVTq26T3hU21ZO9CuMxDW9cfUeSY6s7Te4Itx+6mWas22s8jqkMBsF5lAYoX7XGyh7v3J4FrX1fDEXQeVaoXOFnFLy3qtpvA1jKBvJ+Kl57ClZgPPRpGgdmMwCcGzjU4HtE3bSZQqcmEvD5nyrh+aZb5WEfDMO88fHmnS1pM8FEM8u0XkwMKTv8HVOJQlQ0yk
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tjg4bEhKTHBjeWRWZmFCSWU0WFJJUU5oQThSdWZETzc5cXN0eE1hTE1WbVkx?=
 =?utf-8?B?THZPak9jYU1WWTNtTzVTUFBLMUM4b3dmVzJnWldIYXMzZXZGUXhZZ2pDU3ho?=
 =?utf-8?B?VmpOUXI5SmIxYklqQ1haRHptUFNxV29rMHdOZ05nOGMzMHU0RWVMSDNTbzc4?=
 =?utf-8?B?dEswd2kwVFpjVmZoYmFtTFVGNWd2ZmlGR1JMMUdoYTk2cHdzdWh2RkVUc2Fz?=
 =?utf-8?B?VWZUNWxJT0twUzJNdDhySG9nVkJHenR5M3ExMlNTYW1peXRHZDdHK3dGSDNt?=
 =?utf-8?B?SmhVMGdLVDd6a2tiRG84RFY2MW55RjNvd213V1BZVnZhbEdSQzFWS3VuUnEy?=
 =?utf-8?B?SjR3Z1g5ejRQSEtDTWx5NG1hbHNYRjI3eFhOS0lNeEh6enVYWHhIOTJ2dHlw?=
 =?utf-8?B?T080NzNndGZLSmFOOW1nMWZURmh4R2VnQ0wrbi81a3RaSmRjRk5WTTVzSEsz?=
 =?utf-8?B?WkpacjRyUGdmb0ZJdDdTdE0yZEZSM0xVVFYvWVg2UVhEcjlhYkVlTG1ZandM?=
 =?utf-8?B?bHMrbVpPSHNvMWg3aE93OHNRMkFNL0Y5NFQxdGpaVDhNaUlJTFI3bU16Yk13?=
 =?utf-8?B?bzBCVi9uTkdoMGpNSkt2aVZqamJ1c1daWWdaZzJ1NWV2MnZ1ZjBhSFVvVmhR?=
 =?utf-8?B?YXc3NTJFUllmWWpXVG9Xclc4U2hqbzJZdXFlV1VJajN1REV2TStJMlFXaWFa?=
 =?utf-8?B?VkRSakwvdzhnSFdncEJ3blgrMEwrWjM0b0NUWERqeDUvUFNLeTBVeTZ1aFFy?=
 =?utf-8?B?TFFDNjZCMCswaUQrYUlRMEl2RDduMWlOTVdVRXVMdU5jNE90aDJwQmdiT0Jo?=
 =?utf-8?B?SE9MUzUyY05sUStiVVY0NDg2TU5TdlFWRVpWREpMRTA4bUpVVy9KUzFVMXox?=
 =?utf-8?B?OWJ5QTdoU0ZsR0JveXN1NDFYOWdSWlZwZGQ1MEp5ODE0c0o4ODhxRTllaWo1?=
 =?utf-8?B?cXIvQkJyT0RpQUhTQkxpSTlGcnZVZEIvTkJqYkJwSU1kSm5oZ0xjNCtWa2tN?=
 =?utf-8?B?cVBMVHFjbVZzeHJGejV3Y0NHZDBEUmFXT3VEN3lQRXpJQmNnaURsZXhIamNs?=
 =?utf-8?B?WHFQakJLa1JHNDlxbVlsQVRVbW9XU1RIT0FOTTFRTnZzNk1uZjBWMU5tb3Ar?=
 =?utf-8?B?MXBBT0VDdDJhUGRqaHcxRWF2OTFxRWhoWUU4U3N2cGM5MFRYK0cyQ0YrRFNz?=
 =?utf-8?B?dnlHR1JYUCt3YUhoakNReUFacFBaUzdKdUlsdWZ2dHRZSDVWdE5BMEVaRms1?=
 =?utf-8?B?QXBKYWdrTG1IMTRaRkVMOUlsS05VWFZGQ0NkT2s3Z3oxZXFTY3lOWUIrR0Qx?=
 =?utf-8?B?ZnVWQXAxc2pYQUU1QWxpOEU2dW16WG10R1FwNjhVQlVDREZyM2MrQm5JZVB2?=
 =?utf-8?B?ak9LMnhmM0xxSno4TzB5ZVdseURqa1ZMRFBQaGdaZk5MZXp5WE9ubmk0UFJD?=
 =?utf-8?B?d0xvamRCcSsrKy8rTVlRWi8wM1BlSFhVSExzMnVnaUN4U0V3QVpJRjFCeUgy?=
 =?utf-8?B?WFpUTFlURDdQS1IyZ0lMNmNhdkF6SEYwK3lpRm1qQUQ0M1FEY1VPeUtkMzV0?=
 =?utf-8?B?aVZyUnFnMHNQVXYrTlZJODlqdm5iRFc4TUxiRzJYclpSd0dCamswazZpLzdB?=
 =?utf-8?B?TE00SGJSZnpJOE8rSnlqMDFyb2lVT3Jqb0JWU1MxbnRvR01WNjVVMHJabEtR?=
 =?utf-8?B?YUZzdXVXSkZtbTFoVnMrc1dsNjMrMHRIMko1cWpuNmhxNmJlenNZc1IzdWJQ?=
 =?utf-8?Q?S4GmRw6kl0nUNl68vI=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-10f0b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce0a2a5-ff5a-4e8d-d2e2-08dc24453c40
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 23:18:16.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7239

Hello Russell,
thanks for your  explanation. I have to say that:
Module default is LAN_SDS_MODE=1
Host banana PI R3 supporting 1000base-X + 2500base-X
I would update the table as follows:

The current situation:
Host supports		Module		Mode		Functional
1000base-X		LAN_SDS_MODE=1	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X
1000base-X		LAN_SDS_MODE=6	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X
1000base-X + 2500base-X	LAN_SDS_MODE=1	1000base-X	Yes
1000base-X + 2500base-X	LAN_SDS_MODE=6	1000base-X	Yes (host forcing module at 1000base-X)

I suppose that Banana PI R3 host is forced by linux drivers
at 1000base-X so first two cases should be same as second two cases.


With the quirk:
Host supports		Module		Mode		Functional
1000base-X		LAN_SDS_MODE=1	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X host
1000base-X		LAN_SDS_MODE=6	1000base-X	Not tested, but expect to work as 1000base-X + 2500base-X host
1000base-X + 2500base-X	LAN_SDS_MODE=1	1000base-X	Yes (module forcing host at 1000base-X)
1000base-X + 2500base-X	LAN_SDS_MODE=6	2500base-X	Yes


I suppose Banana PI R3 forcing Linux drivers at 1000-X when
module in LAN_SDS_MODE=1 and expect it should work alpso with
hosts at 1000base-X only in LAN_SDS_MODE=1 and LAN_SDS_MODE=6



I also  tested them a Linux PC with ethernet at 1GB (Host) attached to
a media converter ethertnet <-> sfp 2.5G module working at 1000base-X
(speed of the host ehternet) with module set at both LAN_SDS_MODE=1 and
LAN_SDS_MODE=6

Do you think this could be enough?

Waitng your comments.

Best regards

Sergio Palumbo


Il 02/02/2024 19:01, Russell King (Oracle) ha scritto:
> On Fri, Feb 02, 2024 at 06:41:51PM +0100, Sergio Palumbo wrote:
>> Dear Russell,
>> sorry for the indenting. I will no longer use indenting in future postings.
>> As explained in the description setting up the module via telnet with
>> LAN_SDS_MODE=6 puts the module in 2500X autonegotiating mode.
> Okay, so this requires manual configuration to switch the module into
> 2500base-X.
>
>> Without applying the patch the module shows up to linux at 1000X
>> because the EEPROM is not correctly reporting the 2500X speeds.
> Okay, so in its default as-new state without reconfiguring the module,
> it reports 1000base-X and Linux drives it as such. This sounds fine.
>
>> Ethtool lines in the description repporting only 1000X and host
>> connecting only at 1000X.
> That would be expected.
>
>> After the quirk as you can see from the ethtool lines I put in the
>> description the module shows up to linux with both speeds 1000X and 2500X.
> Yes, adding the quirk will have that effect, but it will also have the
> effect that we will choose 2500base-X for host interfaces that support
> it, whether or not the module has been reconfigured to operate at
> 2500base-X. This will result in a mismatch between the module and the
> host, and the link will not come up.
>
>> According to the above if the host has the ability to connect at 2500X
>> the module is connecting at 2500X, if the host has the ability to connect
>> at 1000X only it will connect at 1000X.
> The current situation:
>
> Host supports		Module		Mode		Functional
> 1000base-X		default		1000base-X	Yes
> 1000base-X		LAN_SDS_MODE=6	1000base-X	No
> 1000base-X + 2500base-X	default		1000base-X	Yes	***
> 1000base-X + 2500base-X	LAN_SDS_MODE=6	1000base-X	No
>
> With the quirk:
> Host supports		Module		Mode		Functional
> 1000base-X		default		1000base-X	Yes
> 1000base-X		LAN_SDS_MODE=6	1000base-X	No
> 1000base-X + 2500base-X	default		2500base-X	No	***
> 1000base-X + 2500base-X	LAN_SDS_MODE=6	2500base-X	Yes
>
> The lines marked "***" are what I'm concerned about - by adding this
> quirk, it has the effect of trading one working configuration (the
> one where the module is in its default factory configuration) for one
> which requires special configuration of the module _and_ which breaks
> the factory configuration.
>
> On the plus side, ethtool _can_ be used to switch the interface mode
> back to 1000base-X, but given that this was working it seems backwards
> to need manual intervention.
>
>> On the other side after the quirk and the module set to LAN_SDS_MODE=1
>> 1000X mode. Linux host is connecting at 1000X only.
> No it won't. The module will still be detected, the quirk will be used,
> which will indicate to the kernel that the module supports both
> 1000base-X and 2500base-X. With a host interface that supports both,
> the kernel will choose 2500base-X, but the module will be using
> 1000base-X - and the link will not come up.
>
> At the very least, this needs to be mentioned in the commit message,
> so that the implications of this can be properly considered.
>


