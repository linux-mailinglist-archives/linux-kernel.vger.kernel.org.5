Return-Path: <linux-kernel+bounces-84608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA22286A8F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D51BB1C2463D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91DE25611;
	Wed, 28 Feb 2024 07:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gXiK1Okg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="iT/uEUNM"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0F625601
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709105326; cv=fail; b=C/BTEUY6lcbxC4NF1In1RtDgzKyuOmvxQFk7kM12xmIJ2Hx3j1kukpLf37eNRMu0xc3BysH4vXIqxkf08goQEN1rQGDmujn6yF6QZRHv1IcmaDXps7hQuqHDf12yWAvTCXhSUIGyrlp50jub1++9gEJ30fFcIQCsQknrRtx5Upo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709105326; c=relaxed/simple;
	bh=HYPn+lwHMTF/B9vVPnhWBr7aEnOxDl+ljAFtSQA4BJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d4Xqx0Bmqg5G/CvOxAnDxAx08yDySKaeXgf+9OpTMli1EhCwE8tJ4keMTIfEwVGgCC1zoWospuR98qqVjwzUI2RSJsP1t/dpZp7FANuCw9Ara/Rp8HfFIJbOIMNZB9AmX5SqVvUkd8f51oCR0SGtRi7Tuel52jM9aGO0bL2fCIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=gXiK1Okg; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=iT/uEUNM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fe1afce6d60a11ee935d6952f98a51a9-20240228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=HYPn+lwHMTF/B9vVPnhWBr7aEnOxDl+ljAFtSQA4BJ0=;
	b=gXiK1Okg9JQ89+1ZAK8XZ0ojUHL5ywJ0LHEzuCqpUWHmL0UpXED4WKKvfSS6FrA86xWgI0zMR+jCHLGSCFjAZH0mrD2ccTUZYe4bUzGSro6LNssYvKVgP8SRv450i2izApDOls5c76B2pwqLDKSId/0UZVxln9k3KjG/ntF2LwA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:8f38fe2d-4cff-47e1-b5fd-e4ce644ca30d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:8d97cd8f-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe1afce6d60a11ee935d6952f98a51a9-20240228
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <lena.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1141738975; Wed, 28 Feb 2024 15:28:39 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Feb 2024 15:28:38 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Feb 2024 15:28:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/HGyZ/OpNHnNcnww8MF0IlyGl1r2zxg74ieEvr+EqhfmY5/LC+Hl4GJEoH0Y+xxayADQ3jJuEEIvnEMPmuyvkqo8JRowzSPij8MAyJadrF5eKzwAABulipk0OEs8tGNbHgCY0KOPJh8VCEs1mZmXoFFj7LKNzp7qL0tonY2o7+oOOG18VMp+brA4WCpaW4Z4V96aTvhI1zq5I2I3ppqOWJwocUjhWTUpy8rBz2rbvSep1L26OwMRxJ6vRuq4ehp9mryjRFnEBGC0TSPlofO4w4aOfl5xRj2gUNxYhFPX72j/RY8qfb8xedYSfhUuQsI/UUIG6tYUDuibFR5ynljTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYPn+lwHMTF/B9vVPnhWBr7aEnOxDl+ljAFtSQA4BJ0=;
 b=IQ7SoKY7p2T1WWtRjmddtFN1OgEfQUI68/uTF47NnKTgSehxQda27jp1eNiMrKaA2PW8PFAzPgyMR8RWgfaBBvRIm3aUUBrCQBsonDDz7m5c2pUfbJsBKrhhYlLJuTjr3QM6oIMKm0ue6pxpLiZiOJGK6iVW8e0RMjTv8O86srocbpNkLNsDPxSCMZIWdrROadeTNrslFuLS/CfxxkMlmdTkUV+O+49PVoXvCf4IrbAQd6cW9IFIh6g/GDbxsTzG1IjUgE7PTGUNDCK8APF7W5UjGszxPTOmhXRtd6jLDrYgrmy2SF6n0XpEm2bdqZX2KLBQW0yRAb3LP1MUSpN+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYPn+lwHMTF/B9vVPnhWBr7aEnOxDl+ljAFtSQA4BJ0=;
 b=iT/uEUNMcu5p7IGJAxtgQGFxmtfib1LHS/2Exs0AXymfOR7PZN0EwlcGqjla8Q1yOLpi72+TPgRQe9raPXqvEuVZZBVtHjFZJStqcLsLSeBIT+Ewe+p0oS0ybi6+zg4SToxADcaLWOaIDdvN1Ha1w50BySlqCgIJBRVNyU9jnNk=
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8)
 by TYZPR03MB8726.apcprd03.prod.outlook.com (2603:1096:405:65::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Wed, 28 Feb
 2024 07:28:36 +0000
Received: from SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea]) by SEZPR03MB6466.apcprd03.prod.outlook.com
 ([fe80::8814:cbff:5bbb:98ea%2]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 07:28:35 +0000
From: =?utf-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>
To: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
Subject: Re: [PATCH] Net:cache didn't flush when ipv6 rule changed
Thread-Topic: [PATCH] Net:cache didn't flush when ipv6 rule changed
Thread-Index: AQHaaLU+wJdSkCun6UW5mkHaGPp8QrEeS7GAgAEOoQA=
Date: Wed, 28 Feb 2024 07:28:35 +0000
Message-ID: <3fd5e055b5f56c596416f0cf37c6b47e77af0379.camel@mediatek.com>
References: <3efcbaf0872481d1a842eb9e18fa368b4b94d940.camel@mediatek.com>
	 <655ba4a1-4f73-4ef4-aff3-0b439e65a9c9@kernel.org>
In-Reply-To: <655ba4a1-4f73-4ef4-aff3-0b439e65a9c9@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB6466:EE_|TYZPR03MB8726:EE_
x-ms-office365-filtering-correlation-id: f167907e-dc56-41c2-c00d-08dc382edfe2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOSxrfa//eaQuid2uvlnB4RN2MT7DzAQoz9/AjHswI/LF9es6hOyZvscWziZt9ORtkNLydRFCNy5fIker4mi+3rT2n4P+ZAX00keCjfc0SeeXSSrEhx/LrtbhEgH6jHrLL9cS97sVepUl9h4/GhV/2GdIU7dhjwIbuhusimvOrBXVCd1XgpRTy4nnln7fhtg8IRvCbCxraLgNIRgCnTKnUQq+ggbTL6N9U228aYWRQDu8gtTl1/8RBBPsY9piq5Zp7NEWM5vq0b/OzUWDFbm9XEkO6kMS4PlOGT9erKcYTCTYpsMjPd5uBGt6zFmR2cg8XZDiqUQRMnQnj0MqHpK/LAZa7CJ59D9H4iK75+qOqTyz+oUYpRwQEJSs0FcGpG2g5RK/kmdZmTGGGKIAGiqImZmt5fEDJtD27q73bP25WjJ7p0kPAvrvrFZ039arba6XuOnbcxchpceefdcj+uqQ56tpljBzeF14Fp+uRrUIphBA0AX84qxYLODkmGJD92SJVL8EVS7OtdPcuStBx1/l1Md5/kM1j3UGAyEAbsaRAXSJeD9COWHX7dm2PqXYreXswUmCGyR5XAOuonyHGNfkIX3AuZUzggTO7bzpFdAva5B4/diM/nL4FuBGMyAjIGp0blBIF+frUFRT+RcsLQ8UGxQTMf7UsMg2m56vLNqdAkThesIAKneSa3n0z40p/7saL/TBiic9eS5g4JFokayqTMWADnL2CNhjfqoVHkmnSg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB6466.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rm8wSDJhOHRKaDJSNVFaZ0JzM0I0N0thcEVOam0yUWJFaWx5SVJxZWVVYjF3?=
 =?utf-8?B?cWRpMUN6QmRYaDFQNUxob0VmdENyQnNlUGxHQjFRREQ3MTJ1SGVxK0Z5Nk81?=
 =?utf-8?B?WUVQL01mRzVzdUZYYllPY3czOUgyZU9jakoyakJtdGhxZEdKOTlSdU96ekdQ?=
 =?utf-8?B?RHhrdkkwV1FHWEd5R3A5aWluaDdLM0NWRTkxd2grMG5GNDRSQ3VLcDRQbEN2?=
 =?utf-8?B?MTUrbXY1Ynd3ZmtJa3lxM3RDN25TK3pRaDg5M3RDRFFpdDNVRWZvRElLSVh1?=
 =?utf-8?B?MVltY3doaG9DRi9vRFlvK1dEcmwySm12T0I0R3E5N2s2VVI3S1IrNXVGSG56?=
 =?utf-8?B?dlBXYWpObW9ZeE5OR0h0TzdiTCtqbFpJVldLK0YyNjRQenRwaE56U1d6NVZv?=
 =?utf-8?B?UjBib2RnY0RRUTNjd3ZGbkFvdHBjb1M0eElUMHpQM0trcVBOSkRpazRvRURK?=
 =?utf-8?B?ZzJFZFVlTnhndmxhcnJuejlWamh5L2I2SnRNanVJM200T0pzbWZDYmFNanA2?=
 =?utf-8?B?VnlvTlE5U1hYQnNlUmFkbWx2TWVES05CUWpmVWMwSUxGUFpMZURzNzNvcDBG?=
 =?utf-8?B?a3dOcUJhU0pHdXpDUmdVenliU0JCaUNaSEN3T1hrYVRrSU9aMVlWa1ppQVJY?=
 =?utf-8?B?bW9VcUh0MXp1SGFxRktuMTM1VGczRktGNHp4dmhIUXZ5SUdIdFVwOWgvU3ps?=
 =?utf-8?B?UGE3TjJkQXNMa1lwclA2bXlSQ1RxNk5hbEQ3RzV1V0FaUlJqZ0hNMXZ0Zmxh?=
 =?utf-8?B?dTllYTVSLzB5TlozUzJ6VC9jZExSKzE2Yk8ybWc4c2hNODZ6UHZ5WjBZSDFR?=
 =?utf-8?B?Wm5jKy8vNDNyTmJxZVRGL3RTWkxxNUdYek5LT2c2NDBNSlNFaituV2FJam1E?=
 =?utf-8?B?b1VOZmZrOTFhOTNFeG5CUWd0aDJXbi9uS3JXMmJCc0Z1MlF5L1Vrc1RFWEpP?=
 =?utf-8?B?Y3pocjZuRUNwTi9SZytmMk03SXhuaUZ5OHN5K3B3WkI5d1BxZEJKREh6ZEZF?=
 =?utf-8?B?cmwwdElKUlNvSTAwZGlORXdKZnF2TE9wSFFQQXV3dnJGU0VhbVl2ZVZHVkRq?=
 =?utf-8?B?MjJSdWVmYzY2OGg0QncvZk5PVlQza3c4c2NBajRTV2RlODliUklhWXlyYm83?=
 =?utf-8?B?TXdLNXlGUTRwUlZHUDNiaUVFcFNDb0hqUkdTV2hSbTRPNHZlYWtBYURzSFcv?=
 =?utf-8?B?VkgyK2QrWUZuYnFHdHgwMEhOaStyL3RuV3NTSmd2K3V5UzlJVkZaMmFqcW9t?=
 =?utf-8?B?K1EvT3BDdWNVc0NqV0M2KzM4MmErRXBjK1RlY1UzWml3cXhjcnhZV0xxSjFZ?=
 =?utf-8?B?QzJRNW1UTDlpSE9WQit2T2VqNk94WXFUNHRIWERqb21TSEFpdC9CL01EUU5j?=
 =?utf-8?B?WTdFVWlyUkM4RVRncytOa0FnQjRZdUJObCt3NmVHeHhrZlRYdTRyNzVHVHR0?=
 =?utf-8?B?WG11dVpyMlJDVkFlT0ZDWitHUWp0c3JkTFB0RTNXYnRjWXpWemZpR0Y4L3dm?=
 =?utf-8?B?dExtd2JJWWEzcGo0OGRPNUptSE1BZWxwVmxjY3NhM0N5NGNobmdLamg5S0hI?=
 =?utf-8?B?V1dBcUFRVi9FMGF3V3FPUjJBWWtPNFZPdjQ5Qm5iUVhXTGpQbkpaWXBwcG9N?=
 =?utf-8?B?b0YxZ2Q1TUJ0WU9zSlFkaThGVE5rVkhkOXFwazY2dnZEZVhjUE0ySDVrNmNO?=
 =?utf-8?B?S1FWaTdadVVRS3BQZlByTG9LYkFBaHhnOFZtT1pVS0RkajhEaVJTU0U1Nldn?=
 =?utf-8?B?OHhjQ29KWjVreTZHZGNpRXdBdVhtWW84YThRWHdCUVpaN0pvL2VqUWNYOGlL?=
 =?utf-8?B?V0RFUTZQOUo5V2xUOXBOUjIxa24vUHpDYVFUL2RHd1BJMmFUdWhWdjlXSVdO?=
 =?utf-8?B?YXlaeE9LK2xrK1BVbFZSam5DbWpuQk0zTkRiVFUraTZXQmxrcWxVQXRGWXpn?=
 =?utf-8?B?bkdsTmpQYWg1MnJ6MzZiRXRPWTB2ODNpbFV2V1Nia0NSMStybE9iVXc2enFv?=
 =?utf-8?B?Nko3eFF5L2d1Zjl3RTdEcEFXK2JseGFxRlRaNEwrRnZ0c1JDTHNkNkRXU3Z5?=
 =?utf-8?B?QlVUcFJ1Z0FncTE4VXRNUlZ6OGVIamZSQTVqUHMrNUFwbUlYSHJyYUk2bGFC?=
 =?utf-8?B?NHFKS3V3cVR1dHJGcGlTSkYwV0lHU0tHalVoVzBWWHEzYzlyWXB5ZGMrTG5N?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <461EDDEFE3E70347B89B5048FDE42BAB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB6466.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f167907e-dc56-41c2-c00d-08dc382edfe2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 07:28:35.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vPjfF1vS1O9tFeUjIH7Ee/UtE/q80yyYGO3FrxGDjPyiWYOURQHxkwxiUkDTHa9DXnh7QqYal1WoBjpSJ8y4zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8726

T24gVHVlLCAyMDI0LTAyLTI3IGF0IDA4OjA2IC0wNzAwLCBEYXZpZCBBaGVybiB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBPbiAyLzI2LzI0IDY6MTEgQU0sIExlbmEgV2FuZyAo546L5aicKSB3cm90
ZToNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL25ldC9pcHY2L2ZpYjZfcnVsZXMuYyBiL25ldC9pcHY2
L2ZpYjZfcnVsZXMuYw0KPiA+IGluZGV4IDc1MjNjNGJhZWYzNS4uYmVjMmNmNDQzNmUxIDEwMDY0
NA0KPiA+IC0tLSBhL25ldC9pcHY2L2ZpYjZfcnVsZXMuYw0KPiA+ICsrKyBiL25ldC9pcHY2L2Zp
YjZfcnVsZXMuYw0KPiA+IEBAIC00NDksNiArNDQ5LDE1IEBAIHN0YXRpYyBzaXplX3QgZmliNl9y
dWxlX25sbXNnX3BheWxvYWQoc3RydWN0DQo+ID4gZmliX3J1bGUgKnJ1bGUpDQo+ID4gICAgICAg
ICAgICAgICAgKyBubGFfdG90YWxfc2l6ZSgxNik7IC8qIHNyYyAqLw0KPiA+ICB9DQo+ID4gDQo+
ID4gK3N0YXRpYyB2b2lkIGZpYjZfcnVsZV9mbHVzaF9jYWNoZShzdHJ1Y3QgZmliX3J1bGVzX29w
cyAqb3BzKQ0KPiA+ICt7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbmV0ICpuZXQgPSBvcHMtPmZyb19u
ZXQ7DQo+ID4gKyAgICAgICBpZiAoIW5ldCkNCj4gPiArICAgICAgICAgICAgICAgcmV0dXJuOw0K
PiA+ICsgICAgICAgcnRfZ2VuaWRfYnVtcF9pcHY2KG5ldCk7DQo+ID4gKyAgICAgICByZXR1cm47
DQo+ID4gK30NCj4gDQo+IFRoaXMgY2FuIGJlIHdyaXR0ZW4gYXMgYSAxLWxpbmVyIC0gdGhlIHNh
bWUgd2F5IGFzIHRoZSBJUHY0IGZsdXNoDQo+IGNhY2hlOg0KPiANCj4gc3RhdGljIHZvaWQgZmli
Nl9ydWxlX2ZsdXNoX2NhY2hlKHN0cnVjdCBmaWJfcnVsZXNfb3BzICpvcHMpDQo+IHsNCj4gcnRf
Z2VuaWRfYnVtcF9pcHY2KG9wcy0+ZnJvX25ldCk7DQo+IH0NCj4gDQo+IA0KPiA+ICsNCj4gPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBmaWJfcnVsZXNfb3BzIF9fbmV0X2luaXRjb25zdA0KPiA+IGZp
YjZfcnVsZXNfb3BzX3RlbXBsYXRlID0gew0KPiA+ICAgICAgICAgLmZhbWlseSAgICAgICAgICAg
ICAgICAgPSBBRl9JTkVUNiwNCj4gPiAgICAgICAgIC5ydWxlX3NpemUgICAgICAgICAgICAgID0g
c2l6ZW9mKHN0cnVjdCBmaWI2X3J1bGUpLA0KPiA+IEBAIC00NjEsNiArNDcwLDcgQEAgc3RhdGlj
IGNvbnN0IHN0cnVjdCBmaWJfcnVsZXNfb3BzDQo+IF9fbmV0X2luaXRjb25zdA0KPiA+IGZpYjZf
cnVsZXNfb3BzX3RlbXBsYXRlID0gew0KPiA+ICAgICAgICAgLmNvbXBhcmUgICAgICAgICAgICAg
ICAgPSBmaWI2X3J1bGVfY29tcGFyZSwNCj4gPiAgICAgICAgIC5maWxsICAgICAgICAgICAgICAg
ICAgID0gZmliNl9ydWxlX2ZpbGwsDQo+ID4gICAgICAgICAubmxtc2dfcGF5bG9hZCAgICAgICAg
ICA9IGZpYjZfcnVsZV9ubG1zZ19wYXlsb2FkLA0KPiA+ICsgICAgICAgLmZsdXNoX2NhY2hlICAg
ID0gZmliNl9ydWxlX2ZsdXNoX2NhY2hlLA0KPiANCj4gdGhpcyBzaG91bGQgYmUgdGFicyBhbmQg
dGhlIGNvbHVtbnMgc2hvdWxkIGFsaWduIHdpdGggZXhpc3RpbmcgY29kZS4NCj4gDQo+IA0KPiAN
Cj4gPiAgICAgICAgIC5ubGdyb3VwICAgICAgICAgICAgICAgID0gUlROTEdSUF9JUFY2X1JVTEUs
DQo+ID4gICAgICAgICAub3duZXIgICAgICAgICAgICAgICAgICA9IFRISVNfTU9EVUxFLA0KPiA+
ICAgICAgICAgLmZyb19uZXQgICAgICAgICAgICAgICAgPSAmaW5pdF9uZXQsDQo+ID4gLS0NCj4g
PiAyLjE4LjANCj4gDQoNCkRlYXIgRGF2aWQsDQpVcGRhdGUgdGhlIHBhdGNoIGFzIGJlbG93LCB0
aGFua3MuDQoNCg0KRnJvbSBkYjAxYTQwZTQ1ZjUxZDAwY2IxOWU0NWE0MTUwN2M5NzM2M2Q2ZWQ4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogc2hpbWluZyBjaGVuZyA8c2hpbWluZy5j
aGVuZ0BtZWRpYXRlay5jb20+DQpEYXRlOiBNb24sIDI2IEZlYiAyMDI0IDIwOjE3OjU4ICswODAw
DQpTdWJqZWN0OiBbUEFUQ0hdIE5ldDpjYWNoZSBkaWRuJ3QgZmx1c2ggd2hlbiBpcHY2IHJ1bGUg
Y2hhbmdlZA0KDQpXaGVuIGNoYW5nZWQgZnJvbSBvbGQgcnVsZSZyb3V0ZSBjb25maWd1cmUgdG8g
bmV3IG9uZSBhcyBiZWxvdywNCmlwdjYgY2FjaGUgZHN0X2VudHJ5IGRpZCBub3QgY2hhbmdlIHRv
IG5ldyByb3V0ZSB0YWJsZSBhcyBubw0KY2FjaGUgZmx1c2ggY2FsbGJhY2sgZnVuY3Rpb24sIHRo
ZW4gZm9yd2FyZCB0byB3cm9uZyBvdXQgaW50ZXJmYWNlLg0KV2hlbiBmaWI2X2NoZWNrIGRzdF9l
bnRyeSwgdGhlIGZpYjZfbm9kZSB2ZXJzaW9uW2ZuX3Nlcm5tXSBpcw0KYWx3YXlzIHRoZSBzYW1l
IHdpdGggc29ja2V0IGRzdF9jb29raWUsIG9sZCBjYWNoZSBkc3RfZW50cnkgaXMNCmFsd2F5cyB1
c2VkIGFuZCBubyBjaGFuY2UgdG8gdXBkYXRlLg0KDQpTbyB3ZSBuZWVkIHRvIHVwZGF0ZSBmaWI2
X25vZGUgdmVyc2lvbiB3aGVuIHJ1bGUgY2hhbmdlZCBhbmQNCmZsdXNoIGNhY2hlIHRvIGF2b2lk
IGRpc3BhdGNoaW5nIGEgd3JvbmcgaW50ZXJmYWNlLg0KDQpTaWduZWQtb2ZmLWJ5OiBzaGltaW5n
IGNoZW5nIDxzaGltaW5nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIG5ldC9pcHY2L2ZpYjZf
cnVsZXMuYyB8IDYgKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpk
aWZmIC0tZ2l0IGEvbmV0L2lwdjYvZmliNl9ydWxlcy5jIGIvbmV0L2lwdjYvZmliNl9ydWxlcy5j
DQppbmRleCA3NTIzYzRiYWVmMzUuLjMxZDYxODMyMjFhMiAxMDA2NDQNCi0tLSBhL25ldC9pcHY2
L2ZpYjZfcnVsZXMuYw0KKysrIGIvbmV0L2lwdjYvZmliNl9ydWxlcy5jDQpAQCAtNDQ5LDYgKzQ0
OSwxMSBAQCBzdGF0aWMgc2l6ZV90IGZpYjZfcnVsZV9ubG1zZ19wYXlsb2FkKHN0cnVjdA0KZmli
X3J1bGUgKnJ1bGUpDQogICAgICAgICAgICAgICArIG5sYV90b3RhbF9zaXplKDE2KTsgLyogc3Jj
ICovDQogfQ0KDQorc3RhdGljIHZvaWQgZmliNl9ydWxlX2ZsdXNoX2NhY2hlKHN0cnVjdCBmaWJf
cnVsZXNfb3BzICpvcHMpDQorew0KKyAgICAgICBydF9nZW5pZF9idW1wX2lwdjYobmV0KTsNCit9
DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCBmaWJfcnVsZXNfb3BzIF9fbmV0X2luaXRjb25zdA0K
ZmliNl9ydWxlc19vcHNfdGVtcGxhdGUgPSB7DQogICAgICAgIC5mYW1pbHkgICAgICAgICAgICAg
ICAgID0gQUZfSU5FVDYsDQogICAgICAgIC5ydWxlX3NpemUgICAgICAgICAgICAgID0gc2l6ZW9m
KHN0cnVjdCBmaWI2X3J1bGUpLA0KQEAgLTQ2MSw2ICs0NjYsNyBAQCBzdGF0aWMgY29uc3Qgc3Ry
dWN0IGZpYl9ydWxlc19vcHMgX19uZXRfaW5pdGNvbnN0DQpmaWI2X3J1bGVzX29wc190ZW1wbGF0
ZSA9IHsNCiAgICAgICAgLmNvbXBhcmUgICAgICAgICAgICAgICAgPSBmaWI2X3J1bGVfY29tcGFy
ZSwNCiAgICAgICAgLmZpbGwgICAgICAgICAgICAgICAgICAgPSBmaWI2X3J1bGVfZmlsbCwNCiAg
ICAgICAgLm5sbXNnX3BheWxvYWQgICAgICAgICAgPSBmaWI2X3J1bGVfbmxtc2dfcGF5bG9hZCwN
CisgICAgICAgLmZsdXNoX2NhY2hlICAgICAgICAgICAgPSBmaWI2X3J1bGVfZmx1c2hfY2FjaGUs
DQogICAgICAgIC5ubGdyb3VwICAgICAgICAgICAgICAgID0gUlROTEdSUF9JUFY2X1JVTEUsDQog
ICAgICAgIC5vd25lciAgICAgICAgICAgICAgICAgID0gVEhJU19NT0RVTEUsDQogICAgICAgIC5m
cm9fbmV0ICAgICAgICAgICAgICAgID0gJmluaXRfbmV0LA0KLS0NCjIuMTguMA0KDQo=

