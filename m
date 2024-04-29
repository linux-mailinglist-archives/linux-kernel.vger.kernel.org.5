Return-Path: <linux-kernel+bounces-161882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8038D8B52A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D17F1F21547
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 07:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE915AF9;
	Mon, 29 Apr 2024 07:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="SGySPUxn";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rwqqeEoO"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701A417559
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714377126; cv=fail; b=ICOdKbZq1orzewEyZN6ujQp9hzA4ro/haajjwhwiCMjHs1Y1Eqfs3a+OhRBVpy+t/yVB0ZTY3TOWuEnt56nhdeNtWlJBtxSPXhJjmMaFZ8OAFRf99buO9vKef9EYeeXBupajOrWFOuBK0EgNIrKbhamX9zwmCB4ivXNGHeI2NZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714377126; c=relaxed/simple;
	bh=f6rzWTyoZHZ9Pjuv/1vDzq5PAfTNbu67H+koR+0DOiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RyRYoEZC1ea8aFRk0QwwPekhOlnjfI+Xl/qrnBD22XBGJnB94BtJ02bhX1eW62OboEG6hx4Lg64i4ixnayJ59rSLjZZZUhxtd8fhEdy3ngOpBtIQKjKk1PyVWapxZN3KMFcRa4YJ8hW7ksVs3Bw7skpGS+ir+HIDoC8NYTRZ+zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=SGySPUxn; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rwqqeEoO; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 582a66dc05fd11efb92737409a0e9459-20240429
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=f6rzWTyoZHZ9Pjuv/1vDzq5PAfTNbu67H+koR+0DOiQ=;
	b=SGySPUxnIHbJ341Z8AQiwnN2zAFyXytpd553rGO6tRMXJueWRAxwA4ETbnX6AgIYyWQDn3w+v5SWf1g/o53FceN2zExIuZGc19IBGF8Et6MXPnDZ2kb+OK6cVc1BH9TAwKZ808Oj5prOPoTVuv5lAIhgW7BRnC341chItFz4ujI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:d2a941a2-b5f1-4084-86d5-45d0c0935196,IP:0,U
	RL:25,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:82c5f88,CLOUDID:529178fb-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 582a66dc05fd11efb92737409a0e9459-20240429
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 116069807; Mon, 29 Apr 2024 15:51:53 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 29 Apr 2024 15:51:52 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 29 Apr 2024 15:51:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTZJWL0QRxqq7WAJn+fkhLVaW02PKnzzFEkJ2EyHDa0BfI4/uYG/qPsNk4/q65Ffy+zuzi3ABj5X/J9VWV5M6QBjzmfOWRAIe8pCnrAqAEy3XBtif5TNNfOqjlKOSXowfHPNTOt8s1PNCmip8PQ3Gm4vmf78fPC0Qr9WM7ihpfTM0f0ZqNytavnosXhFWU8C7IqN15Nhsqpoo/a9jWKXqNfU7D51F6pybLFSYZrLV2+03bx5Vaghyellru89mD+GjCZrnvIUzIPXSKTkfwleaUSeQ8owRw58RmoAcBK8VHq2ADpBTc3jtJ6SHpK65wHOsEmsVvrTHuuc9PkUipEO0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6rzWTyoZHZ9Pjuv/1vDzq5PAfTNbu67H+koR+0DOiQ=;
 b=hJ2502m9h/P2b7oT46MMPddjRBuktaKyeqPFVWjZK4MeAZgoy4jWA7yzaBgeQLTs3/FO8okkj+JGDt66Q6GzEl1PU1DnCgeSikNmSFe6PNdKzjvs2CGes+TVzophKgHQ6gkbAL00ZEs8qWqksUFl7c6MeM/QNiBKGTixFtMkQGOPkV9odjwMrlr2wStlbWLxxZAAdN23ofmI0v4FFnPJqZrEXGamdwrx6fj6AStnQImc5gVx27RW1FJ62+sGODsPwysFoGvgsamsePY/8llox+OluXtD2nI/DhXjzAaSZ1o7VF4XGIn3g1P/qNxwfNLv0oU2gz3/+oLOg+PWTxEeWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f6rzWTyoZHZ9Pjuv/1vDzq5PAfTNbu67H+koR+0DOiQ=;
 b=rwqqeEoOZehS7+gBbJYEPo2dRwj1jTm8q73080nDZ3u7RnnlpCCbWc2033mikZcROUFcfrwFQCJkVMDeFiIuQH72brH69V8ps2eXQIeU8Dc1GGGdKwMiHpbAfLrTYbeNMbWWTCQe2RfRyEQkXcAqOQYZGNUOSPptaGZ3owk3Xjg=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by PUZPR03MB7063.apcprd03.prod.outlook.com (2603:1096:301:114::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.21; Mon, 29 Apr
 2024 07:51:49 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::45da:cd44:6032:ea9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::45da:cd44:6032:ea9%5]) with mapi id 15.20.7544.019; Mon, 29 Apr 2024
 07:51:49 +0000
From: =?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"andreyknvl@gmail.com" <andreyknvl@gmail.com>, "dvyukov@google.com"
	<dvyukov@google.com>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, =?utf-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?=
	<Iverlin.Wang@mediatek.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>,
	=?utf-8?B?TGlnaHQgQ2hlbiAo6Zmz5pix5YWJKQ==?= <Light.Chen@mediatek.com>,
	"ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "glider@google.com"
	<glider@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2] arm: kasan: clear stale stack poison
Thread-Topic: [PATCH v2] arm: kasan: clear stale stack poison
Thread-Index: AQHaixkSs+zAunuNbEaFD9FHAsfJirFkUwEAgBmMPoCAAR68AA==
Date: Mon, 29 Apr 2024 07:51:49 +0000
Message-ID: <292f9fe4bab26028aa80f63bf160e0f2b874a17c.camel@mediatek.com>
References: <20240410073044.23294-1-boy.wu@mediatek.com>
	 <CACRpkdZ5iK+LnQ0GJjZpxROCDT9GKVbe9m8hDSSh2eMXp3do0Q@mail.gmail.com>
	 <Zi5hDV6e0oMTyFfr@shell.armlinux.org.uk>
In-Reply-To: <Zi5hDV6e0oMTyFfr@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|PUZPR03MB7063:EE_
x-ms-office365-filtering-correlation-id: 70ecfeb2-60ad-46cf-de6d-08dc682139fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?STl4SU05Wm1HMGdVbUhFRGN4ZkdaNlBaajU4UnlZNG1YNEFMcVY4WG5iUmhZ?=
 =?utf-8?B?SllRUHkza2tXMi85MENSTDNFM2ZOUnJ2NGRZTG5FdVJURjhOMENtQ1F1ZWty?=
 =?utf-8?B?dU02aTUveXpaWFZ3dFY4QzMxbDNmTFRxR0xIWisrbEVzOEV6SUM0NmJaQ2tY?=
 =?utf-8?B?dVU3Nmhmd29ybERkR2dNeGN3anp5b3BZTkpCZ1Y4MlZaNWF5UW5uSVNNZ0NS?=
 =?utf-8?B?WFhUdC9vV0plZWUxRGNJd2ZRT0JiZ0dYbmpGeUUrbkJjeENTRmtQT1Q0WHZV?=
 =?utf-8?B?cEhjZG5mY1VLS0RQNWhLYTZ2NXNudFhVV1V2WEdOUzYyMkl3THdMeEVkS3NN?=
 =?utf-8?B?aDR2YUVNTGVlV0xBcGZveHJpQis5NlpJNzA3dzFyQWJIZC9lWmxDK1ZhWGUz?=
 =?utf-8?B?Sy9LbXRHMURXTEQrSHNnTjVQZUlpS3puWjJnb2ZNaE8vVWMxU1krQnk2UE9O?=
 =?utf-8?B?ZTEveGlrSUdaZnFuNElyTUExbkRtQzQzNTJ5UDRWdnFtZ1IxSFVYekhpcGpp?=
 =?utf-8?B?OUVlYmI5MFJlaEZjSVBUcXlEZzZITWpjQUVmR3YybS9aQjlnYXNDSGhiVXJx?=
 =?utf-8?B?VjFFRGRUUHNXS0l1cmcvVFpCcGw2bDdYd3h0bzVnNHBRYUJud2dyOGFjNGF1?=
 =?utf-8?B?Zm0wV3d2b0tGNWtZZnFvRzFVWm14RkNsRGhlQVZPV1JHTURkTzJKQkNwSEZM?=
 =?utf-8?B?SmNnOUF6c2VtVFBIc2owb01lb2pTL1dOck9aRGF2dFgxQlRpVjVxVCtSdC9Y?=
 =?utf-8?B?N3owVzlMR2cxUitka1I1UG1GRkZSOGxEd2RGV2VwTXhKeWdyRUJPd3l0QmIz?=
 =?utf-8?B?YlpWZGNzYUJQTGtJT3YyTVN0N0ZZUVlqWFR2NFVOaCtmS1IxaHVZVlJkVjlU?=
 =?utf-8?B?Rlo1eFFmWlJ6RGdPSWtUSTNmZlBXQWNSSDBCYVBCNnp3eEhKdnZpY29iUXRo?=
 =?utf-8?B?Vkp3eWlSSDdpQzdLd0UwNkJmcFROK0c0REpoL25lNG43UGpHSWpBZmZ5dE55?=
 =?utf-8?B?Y29VaW1meXV5d0FJL3gwcFVUV2NPUHhncFYvWG9WSkptM3VQUmNNVjNXRWp4?=
 =?utf-8?B?Q1NOWFR5RkI0UmNGM0MxNVhHR0ZORkNvS3QxaFR3YUIyUkdZejBIK0tEVGEy?=
 =?utf-8?B?eXJZMkc3Rlp1MG1nUXhuRjd4TjBtQUJuZ3Yza3pCb1oyaTRSMUU1ZXdlL0N1?=
 =?utf-8?B?UG8rMnBITW1qNVQrbjlPWXFyd0V1M3NXVGJuVmJwYXBxYy9aNjJyZVI0TXJV?=
 =?utf-8?B?ZUpqVVR1b0ExbS9QNnJqQmRvY3BacDdnR1dEUWx1T1J2OWFVMmtpN0xYbnJs?=
 =?utf-8?B?SlFHbUNEak05MjgyekRtYVVrcUJxWVJOejdBUTBZbmtuQm1PdGVzWGRVeDZH?=
 =?utf-8?B?d1dGWlJoUHdudUJNUHYvT3EyZXhrYWxWYUxTY1BtaXZkK0syNzhtM2M2djRP?=
 =?utf-8?B?bFQ0WERNa0lJUXphSkRnNmZNc2lQVjhnQkxMeUdzOEF0Vk9hMk1LMno2dFRj?=
 =?utf-8?B?L3M4UklKUjFlOVBNN3M4TUhza2lnOHNpMUVvSnhGTWZ6TWdCeTZaTE9DSDVt?=
 =?utf-8?B?Y3ZtckpTWGJzYW5Sam4wTjZ5a3JieGErR1k1VmZ2dEJ2MTcvRXkrV2VxbGlo?=
 =?utf-8?B?VElmZGQwZTUyMnduQXRJdzNtMXQreW5KUjBVK0UxWDVpYURiUVpLQXVEWWlr?=
 =?utf-8?B?ZDFtSjM5NjRsNDFlUWJ4WGNvMU1NVklRdUNKTmg5L0F2bWdyMTgzVWh3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnBkczh1ME9IcTg4akJUQnM0d1FZZXhJbkgxQ2NHc2pJcVlaaVVGT1hYMXpk?=
 =?utf-8?B?dDlwS1BhaUVHVExCRm9EQWYrSmdaNFlrSzhGdHJnVjZwd2NRc3N0eGErMzJt?=
 =?utf-8?B?bHo0WG51dUxkclQwV2ZCYUJzZ0RsbWZaSjh0Y3lsNm01cXUxbmlPY3FIZFgr?=
 =?utf-8?B?VXJORDJCb3dBemVZRWFuSVZHbVFUUHg1NWtXQS9YWllyQTkyYVU4V3gxTTBZ?=
 =?utf-8?B?K0ZOZVJTZ0FTeE1IWU9rRWI5RVhTSFk3VW5vR2oxcnA3anRsZGZTa0R3M3By?=
 =?utf-8?B?UnRXVElKZzdZY3k3RjJtYURKd09kMENnNndiaFRKQ1Jhc3lCQmFUZ1RMRTJF?=
 =?utf-8?B?Q0hhendlTWdGVFk3dmI2NWMzMFJLRlc0aXlFbUxGWHdzSzU5bTRJeHZvQzdG?=
 =?utf-8?B?c0lVc2NLREEwVWo0cDgxYmh2UFA4QWFCejd4ajJDeTlJUEYvYTF3dkJGemM4?=
 =?utf-8?B?WG1RdzZhYWV3RERwdndDRUc1RHE3NTZrWDRCMG0yckxWZ0xZdFAvdGlIU2FH?=
 =?utf-8?B?MHlTQnEwb1haNGV1THpJZjh1cGZNSkM2cFBWcjB0Nm1yRFJyN1Uwd2hvNVNv?=
 =?utf-8?B?YUxXWnJuTHZ3YnNFcXpHM1lGQ3BwSGlROUtZbnA5cWxZbnR2Q3l6aU1va2Nv?=
 =?utf-8?B?Q2pMOFNEb3U0L2htOEtSbE1YdVgwS2IzaVdPSENXYmJEUjVKUm4zNmdwVjg4?=
 =?utf-8?B?Z2ZBUVViWFhkK3h3bjM1MnNsLzBkNnMvSjZJZ3lmdnhXWVdBSEVKRTBGUTI5?=
 =?utf-8?B?L2d5Ym5lUHRqeVY5Ui9SaUNVMklpNUlpME5NdjBGRmtGSFZyTWRqNkI5U3No?=
 =?utf-8?B?Z2VDMUdPaU9qa3hML3ZlOXEwbGJrSjdSZ1cxVVoxWmhkbjJOVlVWdFNKWk0y?=
 =?utf-8?B?bGhmMWc2Q1dZaUVBSWIvcmxsUmdVUm9QSjZGZGFBTnp3WWZ2UmhsRERoNHdI?=
 =?utf-8?B?YzZsOGt2bmZLNkE0UjBGMXMrYkNJandCVitsVUVJZEp4dHJqMnBmdVFDNzBY?=
 =?utf-8?B?L0dmT2RiVlBrYVJvYXhqYXNNR0NrYmtkSXlTVDZYa1E5MHRQQjQ0dWNySllG?=
 =?utf-8?B?QWp3RWJMS3g5VktqaDNrcWRUd3dHcHNMMks2TWEwa0J4T0swcm9CRlN4Ym1Y?=
 =?utf-8?B?NW9NRVFScHpwS2xvL2JDM0prSHkvMVRnRkc4SjFScitkSitYakZhaHE3Qm5z?=
 =?utf-8?B?UlZiV25hUzB4Q0xuTGFrVHRXTmtnVFZ3UUtjWlR4SkVoSXcwbFdsWlBha1JG?=
 =?utf-8?B?TDcyVlQrT2swQ2cybWVaMXZGQVEwR0FWbFdvYThsRUt1aHArMWNHZmNRUHF5?=
 =?utf-8?B?d3MvYXdZUU5XcU1aL0haR01CbTVCVUdnTm8yTm1hUmRZbmE1WjZSalprU2dw?=
 =?utf-8?B?RlZLOGJUMWJJcE5RWWNEUVNKR2hmejNWUHh1Wi9PbnhSVDJxSTMzR3QzR3dQ?=
 =?utf-8?B?N2pwVTBSSU1Rei9EczNqcWtXVHBXY0IzTTNWeUY2MnZLY09QSkdXZ2NEZE9G?=
 =?utf-8?B?RFRCa01EcFdDc2h1amtFQzFhTXlZVmpwdzlNNXFscVNnUGxoZGpybUR2dnBE?=
 =?utf-8?B?bE9aeDVGUUY4VkwzbjVMTmFZZVViMDR6aDBNWEcrL2dEekRxdG1IMUFia0tu?=
 =?utf-8?B?ZUkvR0I3aDM2bjJlZnQ1NkxSUVdvZkRvVTNnVGpHcTVYQ1lPQk5uVzlrRERs?=
 =?utf-8?B?WUZzSVhsY0hDS0d1NzA0bVhjMTV2WW9xOU9JZmFXMEpFb3lVMEJNZkdlVEdl?=
 =?utf-8?B?b1ZFWVg5Nk5Ua2JOV096bURJME9nL2dLWnJ6cG1DYWR2Zll0aDUxZ0hMVC9R?=
 =?utf-8?B?a3RrV0licC9OdzcwS1l3SmtwQk9sNWFyMm50TjYwZGVIbGhMc2pDSTUzYUtX?=
 =?utf-8?B?bkpSY0ZFNlJ1TGRZSlBzUFFlS3VlTGFJZm81dFlZME9ZV0ZBM2FGSEttTFNk?=
 =?utf-8?B?a1ZPc1lCTmkvM0swS0N6V2VRNTg3ejFrWTk1UmczWUNYSFFZQnhRV05iUFlZ?=
 =?utf-8?B?M3h1TE40VFhyWGEwREFUaEZFU2Z6Rzc5eE5xYzd4NWlPaDhWbjRaVW5HS2Js?=
 =?utf-8?B?YjJWbVp6bFR2SG1Sd3VEKzBjclEyQkw3ZUk0Uk1MYWxuYUdZZWxNUjhEcWlx?=
 =?utf-8?Q?0Vjt6NO7mBkkuqM57/DeH8sxA?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9003FF89DD52F4A93E20DB6338F4B17@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ecfeb2-60ad-46cf-de6d-08dc682139fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 07:51:49.5887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rleMXmBm3SnVYB+2wYW6iGH8N/N3H6woBTfnCR71U6R288UVTK8J+yc0Ybg9uc88OhKNS+XbvfQSLsoSEHvcug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7063

T24gU3VuLCAyMDI0LTA0LTI4IGF0IDE1OjQ1ICswMTAwLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6DQo+ICBPbiBGcmksIEFwciAxMiwgMjAyNCBhdCAxMDozNzowNkFNICswMjAwLCBMaW51
cyBXYWxsZWlqIHdyb3RlOg0KPiA+IE9uIFdlZCwgQXByIDEwLCAyMDI0IGF0IDk6MzHigK9BTSBi
b3kud3UgPGJveS53dUBtZWRpYXRlay5jb20+IHdyb3RlOg0KPiA+IA0KPiA+ID4gRnJvbTogQm95
IFd1IDxib3kud3VAbWVkaWF0ZWsuY29tPg0KPiA+ID4NCj4gPiA+IFdlIGZvdW5kIGJlbG93IE9P
QiBjcmFzaDoNCj4gPiANCj4gPiBUaGFua3MgZm9yIGRpZ2dpbmcgaW4hDQo+ID4gDQo+ID4gUGxl
YXMgcHV0IHRoaXMgcGF0Y2ggaW50byBSdXNzZWxsJ3MgcGF0Y2ggdHJhY2tlciBzbyBoZSBjYW4g
YXBwbHkNCj4gaXQ6DQo+ID4gaHR0cHM6Ly93d3cuYXJtbGludXgub3JnLnVrL2RldmVsb3Blci9w
YXRjaGVzLw0KPiANCj4gSXMgdGhpcyBhIGJ1ZyBmaXg/IElmIHNvLCBoYXZpbmcgYSBGaXhlczog
dGFnIHdvdWxkIGJlIG5pY2UuLi4NCj4gDQoNClRoaXMgaXMgYSBwYXRjaCBmb3IgY3B1aWRsZSBm
bG93IHdoZW4gS0FTQU4gZW5hYmxlLCB0aGF0IGlzIGluIEFSTTY0DQpidXQgbm90IGluIEFSTSwg
c28gYWRkIHRvIEFSTS4NCg0KVGhlIHJlZmVyZW5jZSBjb21taXRzIGRpZCBub3QgbWVudGlvbiBm
aXggYW55IGNvbW1pdHMuDQpbMV0gY29tbWl0IDBkOTdlNmQ4MDI0YyAoImFybTY0OiBrYXNhbjog
Y2xlYXIgc3RhbGUgc3RhY2sgcG9pc29uIikNClsyXSBjb21taXQgZDU2YTllZjg0YmQwICgia2Fz
YW4sIGFybTY0OiB1bnBvaXNvbiBzdGFjayBvbmx5IHdpdGgNCkNPTkZJR19LQVNBTl9TVEFDSyIp
DQoNCg==

