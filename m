Return-Path: <linux-kernel+bounces-73960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD1F85CE16
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5ED71F23A68
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FF428371;
	Wed, 21 Feb 2024 02:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="jwl0FdUf";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aTLnL5JI"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE0F6FC9;
	Wed, 21 Feb 2024 02:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483066; cv=fail; b=M0wSItKlJIXkbikAcX8f9Q32MrN90eiGvY46NYrx08yev01yBcuzina6vy2uDizMWi8j0Wh+9YXpozkHjt5Zi5TfriRVWLNgSqsEMU7Y4vIh786CG4o3bLB4gJBNaT0UE3Ou3/nPewOfWnSiIF5uexVI7xYTus7TIDu1ukfgt6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483066; c=relaxed/simple;
	bh=BMJBEkL2ESDy8wIa9wbHx7qC+VWfzOBy+0ep1048Y3Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h4xJMADDlrJ3BJ0kS5wHxVKESDkr5bDry8UdImDcU3NS81NIoC7kvBdnWTdmhGcgQqhs17kMFIGlOgM0QtvvYyi4AGthC7f5F1ZilZvP0UI3ZZb2zma94pCQRxuT0Hnt6V5OR0dpMjj6hfIYCRHR6xTzS5RY4bE1lUiUDo/kywY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=jwl0FdUf; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=aTLnL5JI; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 2a70d7f6d06211ee9e680517dc993faa-20240221
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BMJBEkL2ESDy8wIa9wbHx7qC+VWfzOBy+0ep1048Y3Q=;
	b=jwl0FdUf7FTO5JnnO7R4KbSEmqn8bTUyE5oUBHLK8ASl6/NCR2dJsghFKS6S8SQ8Dfo7L506IKWxIvYnxSmJW9qA47oPFNqLQU5o9grceMCfTlsMDndUJkeK+uRPme+WwqAvuuPdE2tj09pmnOIk59Y0P5aypCWVGmsumJrwzXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d9118782-3f81-4da5-8292-212113c8418a,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6f543d0,CLOUDID:2506878f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 2a70d7f6d06211ee9e680517dc993faa-20240221
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 693204710; Wed, 21 Feb 2024 10:37:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 21 Feb 2024 10:37:31 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 21 Feb 2024 10:37:31 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XdIosLxhK4eNodje4Bn/Z4Aorb9achqWrkSqQ3pMemInA91xDWQFb0bw+mwgAr3zyLqWhYlkBAfJRPWmDBbH1uVm8YGUz6PKZIb6OVcSBeqX0FeQPy4ZoepdsYO6TZSBRxl1rC7LDh7+4Uux99RfRU2jkxiiXTJYF+FiFKKCevFe9kj+MGpFVPwqgyWtdzRXWmEonkSGi4LPZv7hXuUfwiiywxVfbq/fSbDhdOaUV6VFnomCuhicXUKVjuavMfcakj0u2qW0tIrt8M8XK4PpFBqbAUqXVNVfMR6fgd2WRiQDNKi4dP553xFNSsxejBTeqx676t1P2AYkWtuT3LMvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMJBEkL2ESDy8wIa9wbHx7qC+VWfzOBy+0ep1048Y3Q=;
 b=huz2a1jfEagtNyELTv9hcchDAd5T3/hrZIeCXxk/JVnCpps8zgHcJScBRY7Atzx0N8a3DpFFRfKSCX2Kk7UrK6lJErxcwUQV3Q9a6P6NG2RdWyhzdRMAuuQ4QvJuFucfIOXH/5h/J2hZIhQJME79etPm9l4cHGBwl8wDEBWwE3RYB06eR+c3/hKceMfSEggkxmuD0pOu+huY4vwfIXzQtfaKz3YbDf43yJci6BZT2rANnq+Uz0CItgA/L7kfEgSm9J2ymcQM8HVI+RkkZ9hZpyRghkLiBrf86aPJbPQPumrODnnCj47reNLVMiFKt7DNmtcgkI6wveZf+OAtCaHH4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMJBEkL2ESDy8wIa9wbHx7qC+VWfzOBy+0ep1048Y3Q=;
 b=aTLnL5JIbzXJNlrw7msaQ0iUpYyqYF5oaj68BctiFxeeGEn5YGzZUDLdyEr34Q84XvYMKxmbe8S2LPbnyT1SkVc5QfX17NsTlXYC8oNPDiSwEEaYYhdo81hZ3j9xFbu4wRY4TEPwViQ3/NcTtLUN0LwS5Es3aJ0tA9TPSw5Tj7k=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by JH0PR03MB8842.apcprd03.prod.outlook.com (2603:1096:990:a9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Wed, 21 Feb
 2024 02:37:28 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::c435:bad8:87ad:994c]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::c435:bad8:87ad:994c%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 02:37:27 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yunkec@chromium.org" <yunkec@chromium.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"jacopo.mondi@ideasonboard.com" <jacopo.mondi@ideasonboard.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"10572168@qq.com" <10572168@qq.com>, "hverkuil-cisco@xs4all.nl"
	<hverkuil-cisco@xs4all.nl>, "bingbu.cao@intel.com" <bingbu.cao@intel.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH v4 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaVzH+Ve+4uX+wTUqBqQq2qHHPDrD9qvsAgBTrHQCAAA2ZAIAALgyAgAAb+ICAAUG2AA==
Date: Wed, 21 Feb 2024 02:37:27 +0000
Message-ID: <063fa9763efb1570295cfef385829714dd5e42cf.camel@mediatek.com>
References: <20240204061538.2105-1-zhi.mao@mediatek.com>
	 <20240204061538.2105-3-zhi.mao@mediatek.com>
	 <20240206184542.GE2827@pendragon.ideasonboard.com>
	 <598f62bbb55157eec1e23dd1dbc307fea3851b21.camel@mediatek.com>
	 <20240220030104.GF20376@pendragon.ideasonboard.com>
	 <115698c0c549e747026cc8841a3bd571533f8e6f.camel@mediatek.com>
	 <ZdRUB92gkbRGPyr_@kekkonen.localdomain>
In-Reply-To: <ZdRUB92gkbRGPyr_@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|JH0PR03MB8842:EE_
x-ms-office365-filtering-correlation-id: 93e09659-83ee-4533-66a3-08dc32860b26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVVtGnKzVlLKgGDtVmpzQ9MTCslRQrBr9AYd/GQABFsvEzpqFxhBtrUsI9OYFNLTN1IKgeZDjW67LO7rRMMoG4FuJ3dOG0jiF5lf18B4QHxxvIh7pYLy1hTn1DOXiGW4IrOmQIfHIbWA6iw8pF7yvso78E9/yEh61XgSqC3cMHbRkRRe4JQEpiLUir8LASzHoIq373m/R3PyfCg7ZqOAzQUqIkMxq+skRtrViqU1AnliZgnr9yivqctjsAX56/ERY5R3Ho2vXEifR0W9suipDG8Sb8DM8IuVAMWvgx505S/oqPAcW+vrNw2v6cPE70f/Y7ro4xRPlkzN1eZtFmdkbSWzQv7FImhBydoSvblTehTGTlU6IPYFLreeSBqWBmPekutW3RrIjSw2EM1wyV8H+Impxsd8oUUhB/No7V0lO2SUEGzk1zuPKNmhqfJraa+rT/qhJyCjuKT5C1av0xXut4JKhhp4xj0+XZraDsiMqpafOmYxqDTV2j09sAtjAC2gfGfLhrBQHMJVbZeuxtm//+pXMzijkXFGJ9p2iU5MmXH+AQGkgPz8C93XXMqKX0myYnU1KU5igyFkvfUbdGJGCklG1TpiYbSHooob4rBbBZorVgAP+S7lNlY1XzzrXSPY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUZDN2ZEOFh4RUdWTEFDS0N1QWVZdGNHUU5Vbit4SGdnUklYUm5KQTdCb2dB?=
 =?utf-8?B?NFRETFhMRlhaVzdiaTk0aG5QUHBENGw0eVRUamxQaUtLOThuRTIvc3lNSVJC?=
 =?utf-8?B?N0ZJN2NuQUx3KzJYeGJySDNiOXkyRUxGWkN2dktOWWJsVHRLL2JkcWY5alhz?=
 =?utf-8?B?YmI0aXdHVlg5V25sQzVXYjhwTGRTb1Vib3dZbkRqWENMKysvUXFXeHVaZUVM?=
 =?utf-8?B?ZmZqUnUxMmFuRU9pazFwRWZkb1Zja1NNZW8yZ3lHNXI0Z0xDUklDN0duczhY?=
 =?utf-8?B?QXkvK29YYWJoQThnYkQxNXF3MXV3T1dsL3FqU0VlYU4waEdZL3Y1ZllTMW56?=
 =?utf-8?B?UUVYVEU4Z1lma2J3eVlmZUVzbStMSnY0dm1neWMxZHhSYmdnazVGV0tEaUdi?=
 =?utf-8?B?Qnd5TkQwNjRwOXRSaUtJa1ZzVks1THBaeTZmNEVWdyt3b1FmRGhVZHJpUFNC?=
 =?utf-8?B?OUI1TkRjb2pobjlQWmNsMmdsTW5CZU81VUd5U2VLOUU0NWRyTFlyQUI3M0F6?=
 =?utf-8?B?R2tMYUl2NU43Wi9RQWFVcDlQTkI0U0hCNFVtY2RkYXBTK3hiSzVXWm1FTy9D?=
 =?utf-8?B?dUlHQlVqUmtHYllCL1lDMGZmSnlpMlpJd1UxWlY0SzlJazNZZkxqeTJOYXg5?=
 =?utf-8?B?Y1pCTDVxZG5DYXcyblk3dTlBd2orOWpHVk5YRTh0Y1drV3d4TENuOGs4bkta?=
 =?utf-8?B?UzVGdUJCU2tCUG4wOHZhZFpnamRLR3RJYnpDVGJuYkI4T0pqcFltNElDOW1l?=
 =?utf-8?B?MXBXcEFPRTJXcDFiYUNsdjVuTUtOaVkxeTJWcVpGT0Z5MUUxK1FsbXk4dkEr?=
 =?utf-8?B?dk5jWEd1Q3kvdjE2VE1OOFZXOCs0MUtBdFdtMHhBaFF3Uy9YSGc5M3ovZ0dV?=
 =?utf-8?B?SDFqT0U3S2RNd0hMeW9OMTNXYkdFaEoxQVBTVTB0TkVPNkRPZ0ZkL2I2TmNE?=
 =?utf-8?B?UzFzMmZPT25SWmVBeU4rTVdjR1BNYXoyTGVUSCs4dzZBVWwwNjJiYUhYNXRD?=
 =?utf-8?B?d01rZ2hIem5BQWluSUtMVmlhZ2ZVMXdXS2puL3JBTHMvTGJjRlZOWjBtWlhm?=
 =?utf-8?B?N0tqanduUHBjL2xjem9VaUQ2NVV1MkRKQ20xWlNUVFZyR3Y3UEkrblZsaTFR?=
 =?utf-8?B?NnRXMEg4ME9kOFVxdkNnN3lKRnp6ZHBpbnV4M01HbVptNjZBRUo3K0lMUHp4?=
 =?utf-8?B?V0NsU0doZmJKVXl3SVdpUWxYK0ZZZUxmZWw4RE5CMkJXblBZR3dCaTBmNnBR?=
 =?utf-8?B?cW14SHloN3ZMV3lydnp2SnJjNTZIUTNVZ0JqamdBb1hObmQzWlFFWTBRclZm?=
 =?utf-8?B?UGgwUFZpU1RKcjNrbms4Sjh5NWY5UDRTVjJaeVFCK1AxTE9SMTZ2M2owM1hI?=
 =?utf-8?B?eis4elZ0dTFCSGZ1SnFkRzdWUC9OZXBVVHE4V3lpQkkxN2dtdmUxVXhHSmhs?=
 =?utf-8?B?MDJMbzZ0M2FGZ0RBSTRGZnROejBtUGRuenNNaGZ5Nm1YOEZKc2JBMGNJS0Rx?=
 =?utf-8?B?N2c2TE9GWFVEeHpCYVhEcWVsdkg3WGNBVCtSMzM2NlAvQzdEVnQvam1yYWF5?=
 =?utf-8?B?WVppNUczbXMrOFgrR3ptWmZFdk0yTlU3MmNjeDM5NnMvcmVGY3p4em85Rlpw?=
 =?utf-8?B?U2lTaXdtb1ZPcU12TUtKUHAvNSswZzhWUjUvMnQ4ZVV1aG1yUU80L1Z4RHFo?=
 =?utf-8?B?bDh0S0QwVnBzNmNxKzVxaG04eVQ0TzhIU2dOckRiYzJmbmJaU2lhMzJ1cTJz?=
 =?utf-8?B?WWt6OE5mc0Q1ekRCRjRYckpxa3VJNDhiOUxlNlp4S2k2UlVDRVFuNFpISW54?=
 =?utf-8?B?WW1hVk1XRTZMZWN4QjBObDd4MmRMd0FsTnhIWElwdTZueDN1RXRMM254WWtK?=
 =?utf-8?B?TmIzdTAzUXc5M2pPaWg5TG1NU2RZMTJOMU1kWXFPU0tGWTFrSGI4bU9CTHBX?=
 =?utf-8?B?emdoS29xSUs4STZBdkFLdFFRSjA2dkVrUjg0bWx4RklVVUJyc2k0NE1tTlNw?=
 =?utf-8?B?ckNlbnZ6VXN2YVFrbk1nQWtaWEtjR0FMZHArR2NaTHVnMURrZTIwTHhnZDFG?=
 =?utf-8?B?UitCMHh5aG5LYjgzS2Jud1huZFJjWmsxYlNmY0xYK0lYSW1UUlJUQlMyeisw?=
 =?utf-8?B?bkRzSk04RUZhQnZNdzBGaXB4TFdaVGp4bE5xOUF1d1BpTkZuckNwaXAwbTRG?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E611CA516738C48A708BDC831A79186@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e09659-83ee-4533-66a3-08dc32860b26
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 02:37:27.3257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JovBvZ65zbbej0fATgNSZFIYnXtFo2Gka58egsW4BBX4g9TV1vv5Ii7+P2uqRUzbfeqvMMFK2MOQ3x72kugCng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8842

SGkgTGF1cmVudCAmIHNha2FyaSwNCg0KVGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrLg0KDQpPbiBU
dWUsIDIwMjQtMDItMjAgYXQgMDc6MjUgKzAwMDAsIHNha2FyaS5haWx1c0BsaW51eC5pbnRlbC5j
b20gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sg
bGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUg
c2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgSGkgWmhpLA0KPiANCj4gT24gVHVlLCBGZWIgMjAs
IDIwMjQgYXQgMDU6NDU6NTRBTSArMDAwMCwgWmhpIE1hbyAo5q+b5pm6KSB3cm90ZToNCj4gPiBI
aSBMYXVyZW50LA0KPiA+IA0KPiA+IFRoYW5rcyBmb3IgeW91IHJlcGx5Lg0KPiA+IEknZCBsaWtl
IHRvIGFzayBmb3IgYWR2aWNlIGFib3V0IGhvdyB0byBjb250cmwgInJlc2V0LXBpbiIsIHBsZWFz
ZQ0KPiA+IGNoZWNrIHRoZSBiZWxvdyBjb21tZW50cy4NCj4gPiANCj4gPiBPbiBUdWUsIDIwMjQt
MDItMjAgYXQgMDU6MDEgKzAyMDAsIExhdXJlbnQgUGluY2hhcnQgd3JvdGU6DQo+ID4gPiAgIA0K
PiA+ID4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMNCj4gdW50aWwNCj4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ID4gPiAgSGkgWmhpLA0KPiA+ID4gDQo+ID4gPiBPbiBUdWUsIEZl
YiAyMCwgMjAyNCBhdCAwMjoxMjoyNkFNICswMDAwLCBaaGkgTWFvICjmr5vmmbopIHdyb3RlOg0K
PiA+ID4gPiBPbiBUdWUsIDIwMjQtMDItMDYgYXQgMjA6NDUgKzAyMDAsIExhdXJlbnQgUGluY2hh
cnQgd3JvdGU6DQo+ID4gPiA+ID4gT24gU3VuLCBGZWIgMDQsIDIwMjQgYXQgMDI6MTU6MzhQTSAr
MDgwMCwgWmhpIE1hbyB3cm90ZToNCj4gPiA+ID4gPiA+IEFkZCBhIFY0TDIgc3ViLWRldmljZSBk
cml2ZXIgZm9yIEdhbGF4eWNvcmUgR0MwOEEzIGltYWdlDQo+ID4gPiBzZW5zb3IuDQo+ID4gPiA+
ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWmhpIE1hbyA8emhpLm1hb0BtZWRpYXRl
ay5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ICBkcml2ZXJzL21lZGlhL2kyYy9L
Y29uZmlnICB8ICAgMTAgKw0KPiA+ID4gPiA+ID4gIGRyaXZlcnMvbWVkaWEvaTJjL01ha2VmaWxl
IHwgICAgMSArDQo+ID4gPiA+ID4gPiAgZHJpdmVycy9tZWRpYS9pMmMvZ2MwOGEzLmMgfCAxNDQ4
DQo+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiA+
ICAzIGZpbGVzIGNoYW5nZWQsIDE0NTkgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiA+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL2kyYy9nYzA4YTMuYw0KPiA+ID4gDQo+ID4gPiBb
c25pcF0NCj4gPiA+IA0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvaTJj
L2djMDhhMy5jDQo+ID4gPiBiL2RyaXZlcnMvbWVkaWEvaTJjL2djMDhhMy5jDQo+ID4gPiA+ID4g
PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi4z
ZmM3ZmZmYjgxNWMNCj4gPiA+ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gPiA+ICsrKyBi
L2RyaXZlcnMvbWVkaWEvaTJjL2djMDhhMy5jDQo+ID4gPiA+ID4gPiBAQCAtMCwwICsxLDE0NDgg
QEANCj4gPiA+IA0KPiA+ID4gW3NuaXBdDQo+ID4gPiANCj4gPiA+ID4gPiA+ICtzdGF0aWMgaW50
IGdjMDhhM19wb3dlcl9vbihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+ID4gPiArew0KPiA+
ID4gPiA+ID4gK3N0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQgPSB0b19pMmNfY2xpZW50KGRldik7
DQo+ID4gPiA+ID4gPiArc3RydWN0IHY0bDJfc3ViZGV2ICpzZCA9IGkyY19nZXRfY2xpZW50ZGF0
YShjbGllbnQpOw0KPiA+ID4gPiA+ID4gK3N0cnVjdCBnYzA4YTMgKmdjMDhhMyA9IHRvX2djMDhh
MyhzZCk7DQo+ID4gPiA+ID4gPiAraW50IHJldDsNCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+
ICtyZXQgPQ0KPiByZWd1bGF0b3JfYnVsa19lbmFibGUoQVJSQVlfU0laRShnYzA4YTNfc3VwcGx5
X25hbWUpLA0KPiA+ID4gPiA+ID4gKyAgICBnYzA4YTMtPnN1cHBsaWVzKTsNCj4gPiA+ID4gPiA+
ICtpZiAocmV0IDwgMCkgew0KPiA+ID4gPiA+ID4gK2Rldl9lcnIoZ2MwOGEzLT5kZXYsICJmYWls
ZWQgdG8gZW5hYmxlIHJlZ3VsYXRvcnM6ICVkXG4iLA0KPiA+ID4gcmV0KTsNCj4gPiA+ID4gPiA+
ICtyZXR1cm4gcmV0Ow0KPiA+ID4gPiA+ID4gK30NCj4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+
ICtyZXQgPSBjbGtfcHJlcGFyZV9lbmFibGUoZ2MwOGEzLT54Y2xrKTsNCj4gPiA+ID4gPiA+ICtp
ZiAocmV0IDwgMCkgew0KPiA+ID4gPiA+ID4gK3JlZ3VsYXRvcl9idWxrX2Rpc2FibGUoQVJSQVlf
U0laRShnYzA4YTNfc3VwcGx5X25hbWUpLA0KPiA+ID4gPiA+ID4gKyAgICAgICBnYzA4YTMtPnN1
cHBsaWVzKTsNCj4gPiA+ID4gPiA+ICtkZXZfZXJyKGdjMDhhMy0+ZGV2LCAiY2xrIHByZXBhcmUg
ZW5hYmxlIGZhaWxlZFxuIik7DQo+ID4gPiA+ID4gPiArcmV0dXJuIHJldDsNCj4gPiA+ID4gPiA+
ICt9DQo+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiArdXNsZWVwX3JhbmdlKEdDMDhBM19NSU5f
U0xFRVBfVVMsIEdDMDhBM19NQVhfU0xFRVBfVVMpOw0KPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ID4gK2dwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChnYzA4YTMtPnJlc2V0X2dwaW8sIDEpOw0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gQXJlIHlvdSBhc3NlcnRpbmcgcmVzZXQgd2hlbiBwb3dlcmluZyBv
biA/IFRoYXQgc291bmRzIHdyb25nLA0KPiB5b3UNCj4gPiA+IHNob3VsZA0KPiA+ID4gPiA+IGRl
LWFzc2VydCByZXNldCBoZXJlIChhbmQgYWNxdWlyZSB0aGUgcmVzZXQgZ3BpbyBpbiBwcm9iZSgp
DQo+IHdpdGgNCj4gPiA+ID4gPiBHUElPRF9PVVRfSElHSCkuIERyaXZlcnMgc2hvdWxkIHVzZSBs
b2dpY2FsIGxldmVscyBmb3IgR1BJT3MsDQo+ID4gPiBzZXR0aW5nIGENCj4gPiA+ID4gPiBHUElP
IG5hbWVkICJyZXNldCIgdG8gMSBzaG91bGQgYXNzZXJ0IHRoZSByZXNldCBzaWduYWwsIGV2ZW4N
Cj4gaWYNCj4gPiA+IHRoZQ0KPiA+ID4gPiA+IHBoeXNpY2FsIHNpZ25hbCBpcyBhY3RpdmUgbG93
LiBZb3UgbWF5IGhhdmUgdGhlIHdyb25nDQo+IHBvbGFyaXR5IGluDQo+ID4gPiB0aGUNCj4gPiA+
ID4gPiBkZXZpY2UgdHJlZS4NCj4gPiA+ID4NCj4gPiA+ID4gQWNjb3JkaW5nIHRvIHRoZSBzZW5z
b3IgcG93ZXIgc2VxdWVuY2Ugc2VwYywgInJlc2V0IiBwaW4gc2hvdWxkDQo+IGJlDQo+ID4gPiBw
dWxsDQo+ID4gPiA+IGZyb20gbG93IHRvIGhpZ2ggYWZ0ZXIgImRvdmRkL2R2ZGQvYXZkZCIgcG93
ZXIgb24sIHNvIEkgZm9sbG93DQo+IHRoaXMNCj4gPiA+ID4gcG93ZXIgc2VxdWVjZSB0byBwdWxs
ICJyZXNldCIgcGluIGhpZ2ggaW4gc29mdHdhcmUgZmxvdy4NCj4gPiA+IA0KPiA+ID4gRnJvbSBh
IGhhcmR3YXJlIHBvaW50IG9mIHZpZXcgdGhhdCdzIHJpZ2h0LCBidXQgdGhlIExpbnV4IGtlcm5l
bA0KPiA+ID4gaGFuZGxlcw0KPiA+ID4gbG9naWNhbCBsZXZlbCBvZiBHUElPcy4gSWYgYSBHUElP
IGlzIG5hbWVkICJyZXNldCIsIGl0IGlzDQo+IGV4cGVjdGVkDQo+ID4gPiB0aGF0DQo+ID4gPiBj
YWxsaW5nDQo+ID4gPiANCj4gPiA+IGdwaW9kX3NldF92YWx1ZV9jYW5zbGVlcChnYzA4YTMtPnJl
c2V0X2dwaW8sIDEpOw0KPiA+ID4gDQo+ID4gPiB3aWxsICJhc3NlcnQiIHRoZSByZXNldCBzaWdu
YWwsIHNldHRpbmcgaXQgdG8gYSBsb2dpY2FsICJyZXNldCA9DQo+ID4gPiB0cnVlIg0KPiA+ID4g
bGV2ZWwuIFRoaXMgbWFwcyB0byB0aGUgaGFyZHdhcmUgMFYgb3V0cHV0IGxldmVsLCBhcyB0aGUg
c2lnbmFsDQo+IGlzDQo+ID4gPiBhY3RpdmUtbG93LiBUbyBhY2hpZXZlIHRoaXMsIGRlZmluZSB0
aGUgcmVzZXQgR1BJTyBhcyBhY3RpdmUgbG93DQo+IGluDQo+ID4gPiBEVCwNCj4gPiA+IGFuZCB0
aGUgR1BJTyBmcmFtZXdvcmsgd2lsbCBpbnZlcnQgdGhlIHNpZ25hbCBmb3IgeW91LiBZb3Ugc2hv
dWxkDQo+ID4gPiB0aGVuDQo+ID4gPiBjYWxsDQo+ID4gPiANCj4gPiA+IGdwaW9kX3NldF92YWx1
ZV9jYW5zbGVlcChnYzA4YTMtPnJlc2V0X2dwaW8sIDEpOw0KPiA+ID4gDQo+ID4gPiBpbiB0aGUg
ZHJpdmVyIHdoZW4geW91IHdhbnQgdG8gYXNzZXJ0IHJlc2V0IChzZXQgaXQgdG8gMFYpLCBhbmQN
Cj4gPiA+IA0KPiA+ID4gZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGdjMDhhMy0+cmVzZXRfZ3Bp
bywgMCk7DQo+ID4gPiANCj4gPiA+IHdoZW4geW91IHdhbnQgdG8gZGVhc3NlcnQgaXQgKHNldCBp
dCB0byAzLjNWLCBvciB3aGF0ZXZlciB0aGUgSS9PDQo+ID4gPiB2b2x0YWdlIGZvciB0aGUgc2ln
bmFsIGlzKS4NCj4gPiA+IA0KPiA+ID4gVGhpcyB3YXkgYWxsIGRyaXZlciB1c2UgbG9naWNhbCBz
dGF0ZXMsIGFuZCB0aGUgaW52ZXJzaW9uIGlzDQo+IGhhbmRsZWQNCj4gPiA+IGluDQo+ID4gPiBE
VC4NCj4gPiA+IA0KPiA+IA0KPiA+IFNlbnNvciBwb3dlciBzZXF1ZW5jZSBhcyBiZWxvdzoNCj4g
PiAgICAgICAgICAgICAgICAgICAgICAgLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gICAgICAgICAg
ICAgICAgICAgICAgfCB8IHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICB8IHwgfCANCj4gPiBk
dmRkL2F2ZGQvZG92ZGQgIC0tLS0tLS0tDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIC0tLS0tLS0tLQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gcmVzZXQtcGluICAgICAgICAtLS0t
LS0tLS0tLS0tDQo+ID4gDQo+ID4gSW4gb3JkZXIgdG8gbWF0Y2ggdGhpcyBwb3dlciBzZXF1ZWNl
LCAicmVzZXQtcGluIiBjb250cmwgZmxvdyBpcw0KPiBiZWxvdzoNCj4gPiAxLiBjb25maWcgdGhl
ICJyZXNldC1waW4iIGlzICJhY3RpdmUtaGlnaCIgaW4gRFRTOg0KPiA+ICAgICByZXNldC1ncGlv
cyA9IDwmcGlvIDE5IEdQSU9fQUNUSVZFX0hJR0g+Ow0KPiA+IA0KPiA+IDIuIGltYWdlIHNlbnNv
ciBkcml2ZXIgcHJvYmUgZnVuY3Rpb246DQo+ID4gZ2MwOGEzLT5yZXNldF9ncGlvID0gZGV2bV9n
cGlvZF9nZXQoZGV2LCAicmVzZXQiLA0KPiA+IEdQSU9EX09VVF9MT1cpOyAgLy9pbml0ICJyZXNl
dC1waW4iIGlzIGxvdw0KPiA+IA0KPiA+IDMuIGltYWdlIHNlbnNvciBkcml2ZXIgcG93ZXJfb24g
ZnVuY3Rpb246DQo+ID4gZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGdjMDhhMy0+cmVzZXRfZ3Bp
bywgMSk7IC8vcHVsbCAicmVzZXQtcGluIg0KPiA+IGhpZ2ggDQo+ID4gDQo+ID4gc28sIHRoZSBl
eHBlY3Qgc3RhdGUgb2YgInJlc2V0LXBpbiIgaXMgZnJvbSBsb3cgdG8gaGlnaC4NCj4gPiBJZiBJ
IGFtIHdyb25nLCBwbGVhc2UgY29ycmVjdCBtZS4NCj4gDQo+IA0KPiBGcm9tIERvY3VtZW50YXRp
b24vZHJpdmVyLWFwaS9ncGlvL2NvbnN1bWVyLnJzdDoNCj4gDQo+IEFzIGEgY29uc3VtZXIgc2hv
dWxkIG5vdCBoYXZlIHRvIGNhcmUgYWJvdXQgdGhlIHBoeXNpY2FsIGxpbmUNCj4gbGV2ZWwsIGFs
bCBvZiB0aGUgZ3Bpb2Rfc2V0X3ZhbHVlX3h4eCgpIG9yDQo+IGdwaW9kX3NldF9hcnJheV92YWx1
ZV94eHgoKSBmdW5jdGlvbnMgb3BlcmF0ZSB3aXRoIHRoZSAqbG9naWNhbCoNCj4gdmFsdWUuIFdp
dGggdGhpcyB0aGV5IHRha2UgdGhlIGFjdGl2ZSBsb3cgcHJvcGVydHkgaW50byBhY2NvdW50Lg0K
PiBUaGlzIG1lYW5zIHRoYXQgdGhleSBjaGVjayB3aGV0aGVyIHRoZSBHUElPIGlzIGNvbmZpZ3Vy
ZWQgdG8gYmUNCj4gYWN0aXZlIGxvdywgYW5kIGlmIHNvLCB0aGV5IG1hbmlwdWxhdGUgdGhlIHBh
c3NlZCB2YWx1ZSBiZWZvcmUgdGhlDQo+IHBoeXNpY2FsIGxpbmUgbGV2ZWwgaXMgZHJpdmVuLg0K
PiANCj4gSS5lLiB3aGVuIHlvdSB3YW50IHRvIGVuYWJsZSByZXNldCwgeW91IHNldCB0aGUgdmFs
dWUgdG8gMSBpbiB0aGUNCj4gZHJpdmVyLiBJDQo+IHRoaW5rIHlvdSdyZSBub3cgc2V0dGluZyB0
aGUgdmFsdWUgdG8gMCBpbiB0aGF0IGNhc2UuIFRoZSBvcHBvc2l0ZQ0KPiBmb3INCj4gZGlzYWJs
aW5nIGl0IG9mIGNvdXJzZS4NCj4gDQpBZnRlciBjaGVja2luZyAiRG9jdW1lbnRhdGlvbi9kcml2
ZXItYXBpL2dwaW8vY29uc3VtZXIucnN0IjoNClRvIHN1bW1hcml6ZTo6DQogIEZ1bmN0aW9uIChl
eGFtcGxlKSAgICAgICAgICAgICAgICAgbGluZSBwcm9wZXJ0eSAgICAgICAgICBwaHlzaWNhbA0K
bGluZQ0KLi4uDQogIGdwaW9kX3NldF92YWx1ZShkZXNjLCAxKTsgICAgICAgICAgZGVmYXVsdCAo
YWN0aXZlIGhpZ2gpICBoaWdoDQogIGdwaW9kX3NldF92YWx1ZShkZXNjLCAwKTsgICAgICAgICAg
YWN0aXZlIGxvdyAgICAgICAgICAgICBoaWdoDQouLi4NCg0KDQpGcm9tIG15IHVuZGVyc3RhbmRp
bmcsIGl0IHNlZW1zIHRoYXQgInJlc2V0LXBpbiIgaXMgdXNpbmcgdGhlDQpmb2xsb3dpbmcoYWN0
aXZlX2hpZ2gpIGNhc2UgaW4gY3VycmVudCBjb2RlOiANCiJncGlvZF9zZXRfdmFsdWUoZGVzYywg
MSk7ICAgICAgICAgIGRlZmF1bHQgKGFjdGl2ZSBoaWdoKSAgaGlnaCIgDQoNCkRvIHlvdSBtZWFu
LCB3ZSBzaG91bGQgdXNlIHRoZSAiYWN0aXZlX2xvdyIgY2FzZToNCiJncGlvZF9zZXRfdmFsdWUo
ZGVzYywgMCk7ICAgICAgICAgIGFjdGl2ZSBsb3cgICAgICAgICAgICAgaGlnaCINCkNvZGUgc2hv
dWxkIGJlIGNoYW5nZWQgYXMgYmVsb3c6DQoxLiBjb25maWcgdGhlICJyZXNldC1waW4iIGlzICJh
Y3RpdmUtbG93IiBpbiBEVFM6DQogICAtIHJlc2V0LWdwaW9zID0gPCZwaW8gMTkgR1BJT19BQ1RJ
VkVfTE9XPg0KMi4gaW1hZ2Ugc2Vuc29yIGRyaXZlciBwb3dlcl9vbiBmdW5jdGlvbjoNCiAgIC0g
Z3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKGdjMDhhMy0+cmVzZXRfZ3BpbywgMCk7IC8vcHVsbCBo
aWdoIA0KSXMgdGhhdCBzbz8NCg0KDQo+IC0tIA0KPiBSZWdhcmRzLA0KPiANCj4gU2FrYXJpIEFp
bHVzDQo=

