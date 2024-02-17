Return-Path: <linux-kernel+bounces-69826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2DC858F17
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 12:29:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEB8282D93
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E094664BE;
	Sat, 17 Feb 2024 11:29:08 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2042.outbound.protection.outlook.com [40.92.89.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96248CE4;
	Sat, 17 Feb 2024 11:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708169347; cv=fail; b=htSjyVm3Ik253KNEtAB96W03jVS8FrU79Ts6kkyOU04Hyrb0FauHft58sJADciU+6tjGHK4LL2/rM1tv76viSDEAlfGOZmp5UivwsKsq7zNk2iGmFe4AR0Rw5Vhc/m9lWYRaRlmMbRQIe7A2+jp3ONKsp7JvnHDovOkMYpSi5q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708169347; c=relaxed/simple;
	bh=8+L5Iszgcy6YWvDRYQGyuIx8ZKaxQYBAUT1r2kfUO8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r3YKWmFxYo0M3Aivm5wRpslSd5BZ/ZIRcBkyJQR8V8dD4/TdCgpBqda97/ZZLajHyBkOPgirPNaTrzHcSvk+14DtAurTYFgoHjWVd+De0tKJtGn9lF6OWvWHiE7P2hq/D/KGRki6FPE84EYPR2qeq708No+vgc3A/BYXCM325GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it; spf=pass smtp.mailfrom=outlook.it; arc=fail smtp.client-ip=40.92.89.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXo6pILvqbABr+ia0xRYfCZv2Qv5jmPN+3jKRs3Oa9ZT/6iCFDkg2d/xpbn/BkTa9uKxXq6w2DmicNU/tMysMjon2zu7RhlFbNqFgUWgQtx3AjpQN2/Oup/Fwy7fZ3/SRGu7FptpxiZYsmUJzggsgDn4heN6Yhk6gN1Br5iWPfvB7pWAOmvXn95hpX7dnDuGuBlHfx3uRB01kO6CWMlKgSKHdmFBzHVgU9DBsqpG0KKthCghlUKlGaR/47Qnsku8LDTjfgYHu9PCgmLa1xYlKRnuDv/qLV3NfvRhSrBqOm16I3UU/5qGWvRg4VoNGsjTuYQ27WHmjsNmvHmBZlc85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeZ+DU0lCyAyl7LGuispgQqDRkpzAu13l7l1kLmBsPc=;
 b=TuZl1AqSAr88bkoFOmwjG24/DodD4dcdmuQXkUVh0oDA+87CC+mHtxaTEp1hIGZKLU5Oh6gOJbjoF1TLdqFa11SMFZmeOnPQZQgM1x049UBHz9yRoonoUCbSgiA9fUxebaGqBEXuN/g9cEBAN3YNqfet1X96a29DhltkWWrpAiL+TYVCpQxIVEwzDFb8r4lhwXxazisSmpPMVhH7dHF4/VYcFtxk5osIQfqHoy4r3c+ybGKNSzT1WNI1jiNDjqdpK+SgKRjDK09bEWUIYXYslrUQefWpBiK8IgOvznOjAv1t8NbrNew1Ce/TuunpooEA92KCr8rulvBUOIS6tUcfLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
 by AM9PR03MB6787.eurprd03.prod.outlook.com (2603:10a6:20b:286::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Sat, 17 Feb
 2024 11:29:02 +0000
Received: from AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5]) by AS1PR03MB8189.eurprd03.prod.outlook.com
 ([fe80::ffb3:3ff8:6ea9:52b5%5]) with mapi id 15.20.7292.026; Sat, 17 Feb 2024
 11:29:02 +0000
Message-ID:
 <AS1PR03MB81899BBE44CCD9DE416115EE82532@AS1PR03MB8189.eurprd03.prod.outlook.com>
Date: Sat, 17 Feb 2024 12:28:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sfp: add quirk for OEM DFP-34X-2C2 GPON ONU
 SFP
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f8cf41f2-4a90-4ef5-b214-906319bd82d4@outlook.it>
 <AS1PR03MB818911164FB76698446CFEDC82472@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcI+7grKa33oLtwc@shell.armlinux.org.uk>
 <AS1PR03MB818926990092981B0E09E60B82442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcSZtLSWd09xqc10@shell.armlinux.org.uk>
 <AS1PR03MB8189A24B92030AA8F011C7B582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcTzMgxmA6WOoiA/@shell.armlinux.org.uk>
 <AS1PR03MB81891A5F3C8B1A7542746CB582442@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZcUBP3g0XNMG/aU2@shell.armlinux.org.uk>
 <AS1PR03MB8189ADFF1A475AE7DB281BE782532@AS1PR03MB8189.eurprd03.prod.outlook.com>
 <ZdCKRIJfRWkDCs/n@shell.armlinux.org.uk>
Content-Language: it
From: Sergio Palumbo <palumbo.ser@outlook.it>
In-Reply-To: <ZdCKRIJfRWkDCs/n@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [IZAtXmCW3TiQWbbl/YFfesnMzJdg/mOqtoTBxj9YF8wttLjt6vVTHBYcslmHYNpN]
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To AS1PR03MB8189.eurprd03.prod.outlook.com (2603:10a6:20b:47d::10)
X-Microsoft-Original-Message-ID:
 <c706e1ff-63ca-483c-8859-3549eaef5576@outlook.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR03MB8189:EE_|AM9PR03MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 08cbd3c1-efe9-484c-0c2d-08dc2faba40f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eQm29of0R3NFCBq6PKeUni4wva7mR+MVz3TFc0N4Y+EZyjHuikaIO40E1jJNSe3jF6BJaZGZEZjrVCBr0NqOf1yhWala7akShLGF1USNMBNovzL8slVI3x4wjT8S25Jr/yhk3MpAumMvLpEbzVBLHU5t+UJSl8KFQoeMZoc5yi0bj5tnStu2TfbubHmn1XyAHCEYQ4uXLyhG1sJpkTMYzHU1wWCPre5AR51ihl+yRFw5AEa70qqV3/EyOi4DA98KzmvgzKrcXSTt+p8JyLEjmD48ew61hCPf4m/te3N2Z9pGdqj5wdkE1lzNrgPhi4p3znU90MXu++6/uRdUYMhSWH16lrqJeEfa6CC5CpEUw/cJcCDOUpH6iTJSet0Z2apFLil/yaf47bFOkXyFyAwX8W1ecXrZYxIkAHK/+yCI58tnK6JCbcoy5Qrvou19K97CskerHltv2CPzZXInHNdQ118ToIJEZhF4Iu6Af5MuopwpRaX9zN+Ld0MA5nfFwryCdcx0isXEsTbEhlYf1pt7yZAJikLW/VbREE3HggBhrK54qtY0hCm0iZLR+wY4jb5X
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K256MDM3UEFYY1JwRnRSZXJFeHo5OXh6NUxWRXN6L2REZUg4T0FlaUdFSDEr?=
 =?utf-8?B?SytXNkpCdHc3R1dvNUhJd0FQbVlXLzdUOXV2RXd0N1NGRndnYjR0bCtrSVk4?=
 =?utf-8?B?emk5MlZLZDdUVFZlc2NZb3VQNTJwenFVZ1prTzgzRHpUVUI2OXhzSlJkRFhB?=
 =?utf-8?B?dVFIRUF4YVd6UDVhc2pDWTR6VUVjNTYrcHRCazNOTzdCU21IMERJbklmL1hB?=
 =?utf-8?B?WVdnYWpQSG1sU3krd0VJMVFpcTlYQXF0ZW9IK0hMM29ZQllUc091NGJYY1Jl?=
 =?utf-8?B?WENGelV0blNJMWk2WU9selMwdHpheFNVcGtncFl0REd4dDQvb0ltY2ZaQW9J?=
 =?utf-8?B?ZEdWcHBhYXJRcUVmTlBSUi9QTzNiMnpZVnEzZUEzRUFHVXd4YXRCWWl3L2tn?=
 =?utf-8?B?MEpsdDhIRDFia2tkZGJlTUpCWTYvdVhCb2FRcTBPcVo4UFVuQ2xIRnBsM0F6?=
 =?utf-8?B?WVR2c09CS0djZGZhY0tiYmJReHl1VVRaUFdvNHJla1UzSXh0b0x4dUFsTHZ4?=
 =?utf-8?B?UnNvOGIrdzk5RHFBTUQweXY0SVBmTUN3RXNETmtIWTBNTFEwbU5lQ1FzUUhz?=
 =?utf-8?B?eCtvbm5oUWhqdHpzT2RzZDJXdmdtaFNaQTljZmEyL29vOEJCT2g3ZmNrWEtW?=
 =?utf-8?B?NWZ1bWNrL3N4ZnJqRm0yTlZYZmg0N2FMTmp1cml1eVQ2b1VvaFFULzlrbjh5?=
 =?utf-8?B?QmtOZ1dHV1IrZkJjL3lqMXgxU1hsbGd4MU40ZmxtRUdpSGlFVUpodzJCeDNj?=
 =?utf-8?B?UFBhU1N1LzNyRVJabExpMFB5cDB2RmQ1V01DV0QweExUNGcrR0FtVm5yWlRD?=
 =?utf-8?B?clFPQStZRm5WS0lmR2RzSzV6Y21VSkd5QjVjYUs3aUlNb2pVYUVmTkFlUjV1?=
 =?utf-8?B?QzVWR1g1UWFvV1pDeTVMYlpaeUtYRkFlbE1xL1l2d2dGUENGd1ppNlllRlQr?=
 =?utf-8?B?Nmd1SEgvejRHQmZ1MVMwVVQ3TUhWT1NVa2RiV3R2MkM0eU9lcVVtS09zS2kx?=
 =?utf-8?B?SU5zZ3UzQ2E1KzVjYkpOU0g1YVI4RTNmbFZydlBPSEptRS9DWlRYamtHK2tI?=
 =?utf-8?B?MmVLL2RCWWw3RE0rY25COEhUOHRHVDk5V3E3ZjJ3N0EzQnBYME42VUhnNzdK?=
 =?utf-8?B?VldxSFA5Z09aclhwS0tUSjRwVFFTTUMwcTYyRlVtVjNjeG9mTTVNOHIwRHlQ?=
 =?utf-8?B?TEhMdjNabmJYNnpXenlCNjYxangyZmI2REdVWksxTGEvaUwvazZtYitjM0pi?=
 =?utf-8?B?enJSK3ZSeXRNY1ZDVUFlRm1sb2s3ekpka2RZWDFxY2d2cmk2ZTMvckdMWitw?=
 =?utf-8?B?VnhzV2dUaVFhV3VyemhOYk9UTmVwNURRQWdXbGVuOFM5Rk8yMFdhaXcxTHox?=
 =?utf-8?B?SmJiUVZ2S1NPNTVZRVVEMUFRS3d0TnZ3UndBVHRGQW16RmZKakhuM0g0RmdK?=
 =?utf-8?B?L1VuV3VVOXI5aGJRenFwWWc1cFRLR2xIbWRBSzZSVHczQUliaDRvWEpDRCtL?=
 =?utf-8?B?d09PVEZOdjRMODNxSEhjeWJSQlNjd3c2Q3o4VkE5eGltT1U1ejdsanpSUEhl?=
 =?utf-8?B?b3YwTTBvcFoyR3FlaWxtSkpyU2YySDlCN3JyV2gvVzJRVmc3NUdKOXpsL1JZ?=
 =?utf-8?B?RElHRzNwN1c4MjVCU3IvRUhIN2EvcTgyMlZRS1FXeGw3MzhQQmE4WHIydkJI?=
 =?utf-8?B?NDJ2ZDB0WUYvN3pDT3o4S3VyNXFkRTNpb2U2dWVqT1pTMXNydjBQSWpTZ20r?=
 =?utf-8?Q?NMGytwdOXcnG/T/0OeN1cio8Xlscsxn0+QPZnDk?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-76d7b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 08cbd3c1-efe9-484c-0c2d-08dc2faba40f
X-MS-Exchange-CrossTenant-AuthSource: AS1PR03MB8189.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 11:29:01.9892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB6787

Hello Russell,
I never wanted to discuss your skills and I bag your pardon if this was 
your perception.
My skills are not so high and my horse is not so high (probably lower 
than a pony).
My intention was simply to give the possibility to other users to get 
the module working at the higher speed in order to support internet 
connections at 2500 kb without recompling the system with a patch.
If this is not possible I can accept it without problems and I bag your 
pardon again for the waste of time this can have generated.
I thank you for the time you spent with me (I learned a lot) and for the 
great job you and the net-dev group are doing for the linux community.
Best regards

Sergio Palumbo



Il 17/02/2024 11:28, Russell King (Oracle) ha scritto:
> On Sat, Feb 17, 2024 at 11:13:14AM +0100, Sergio Palumbo wrote:
>> [   15.459629] sfp sfp-1: module OEM              DFP-34X-2C2      rev      sn XPONxxxxxxxx     dc 230912
>> [   15.469121] mtk_soc_eth 15100000.ethernet eth1: requesting link mode inband/2500base-x with support 0000000,00000200,0000e440
>> [   15.509967] sfp sfp-2: module                                   rev 1.0  sn 2307210038       dc 230721
>> [   15.519434] mt7530-mdio mdio-bus:1f sfp2: requesting link mode inband/2500base-x with support 0000000,00000000,0000e440
>> [   24.360320] mt7530-mdio mdio-bus:1f sfp2: configuring for inband/2500base-x link mode
>> [   24.368145] mt7530-mdio mdio-bus:1f sfp2: major config 2500base-x
>> [   24.374258] mt7530-mdio mdio-bus:1f sfp2: phylink_mac_config: mode=inband/2500base-x/Unknown/Unknown adv=0000000,00000000,0000e440 pause=04 link=0 an=1
>> [   24.389679] br-lan: port 5(sfp2) entered blocking state
>> [   24.394948] br-lan: port 5(sfp2) entered disabled state
>> [   24.402405] device sfp2 entered promiscuous mode
> This shows that the interface has been configured for 2500base-X.
> However, there is no link report.
>
>> A stated by you the system is still connecting at 2500base-X even if the
>> module is set for 1000base-X, as far as I can see, without any error.
> Right, because, as I've said many times, the kernel has *no* idea that
> the module internals has been configured to operate at 1000base-X.
>
>> My assumption that the module could have forced the speed down to
>> 1000base-X was completely wrong.
> Correct - considering that I wrote all this code, it is insulting to
> have to go to this extent to get the point across.
>
> So now that we have agreement that the kernel is trying to use
> 2500base-X, you now need to get off your high horse and accept that
> it isn't working because there is _no_ _link_ with the module.
>
> In other words, you need to accept that I'm right and you're wrong.
>


