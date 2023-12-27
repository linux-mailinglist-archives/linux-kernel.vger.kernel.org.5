Return-Path: <linux-kernel+bounces-11875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2420181ECC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:06:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94D32B21D84
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A5263AE;
	Wed, 27 Dec 2023 07:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tcByV1H2";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NgCjWGfz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4645CB5;
	Wed, 27 Dec 2023 07:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5dbef5c8a48611ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=o/v9h9XHmDf8DbKLGyWLTiKYKIwlDnsGRA/6zBungoM=;
	b=tcByV1H2G1zZOb5+em+un1vWla4VI9Wnfhf+0ugtk7LGrYFL/vy5G8LP2TM+hPEbGSz+rPWKBDX3m/JzYrTpHjVOERF9vvqBi9KugjUfs2ssW1SpLGZgbwHuXadrERNrnmCZsKrsOgNnDqDW4aIv8myuZtur4iQ3roxbQy78PVI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:d8eeac34-cdf3-4832-b9ee-527f8a5cab99,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ba61882e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5dbef5c8a48611ee9e680517dc993faa-20231227
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1373084698; Wed, 27 Dec 2023 15:05:50 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 15:05:48 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 15:05:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJJmlIk+oL1+gAiGYqKaS9Bbn4CmJFaDhewH8fdqynimMaZeYWh7LxI9HcgeydPFOb2izs5XY0WqPemgB6ZLwq3XNS808+ypc1EwZ241x6X5Cy+GEsG28gSmZdYIOIcPGlsQQ6EXSUH4lZv6HdYpsoxMgd9NJGfYfoJBShVZPJIuSuIO/D9MZD7E5/MMmcXVjsTR/hDX+lSGFH+4Qr4i06XV81zKOIh8uDAUdinn/iEGF1dfExw68/GfgTI7Dpju9YDj2zqUK7yJaSdwf9eZV7V4I/O17J/m2AD5zSp+CedGAslWiFosE1ICsejR3zSmNb5AOfLqIlDNJMN8jWdoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/v9h9XHmDf8DbKLGyWLTiKYKIwlDnsGRA/6zBungoM=;
 b=T/XAvQdqy8tx+WEgzt1xpIEItWyzuPZiSKFsQHuc4ZgkMP0UFzAg63nFjWEMc38g1da2Vr30dxFAsbrMPnDZbCX5XJkKB6QKlLGnohovgvYBo0dmCIZekUL4Lm0jXHUOTMAz2wnSLaXsQN1gukWkf6Jj70qgFZZ5GT59Xmt4wiBqE8WXjQbA8rYWkcE2YIdecNBZ/18Rpo++L2tY0AFSFIJQWfF6VC1Q+l5RSBTQ0PohnhBMQT5y+xR+a7j/aiQepxEqPLBccMIdbJPG0VI4N9XVqduTQcoAyIzInar6gEBz0P1xJwLF4dX0RmPtKmayIBzucukCcMGklTizbHcWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/v9h9XHmDf8DbKLGyWLTiKYKIwlDnsGRA/6zBungoM=;
 b=NgCjWGfzoknUaE1dBk2AJcFd7urOiBtmoBKZqM1f8HuQEkGPj9EGHla4kfKF35UD7rJDylSVASDih9Yio1FKtfSd7iSLhdpvHbZI/5KF2I5smoIc0A/H1FE9uaLVyFEzJWM9xGso1wCYjlz2rzwhlMJHssc3C04e6JMN2lYiUJk=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB6303.apcprd03.prod.outlook.com (2603:1096:820:aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Wed, 27 Dec
 2023 07:05:45 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 07:05:45 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Topic: [PATCH v3 09/11] drm/mediatek: Add secure flow support to
 mediatek-drm
Thread-Index: AQHaNc4e47dh3v98oUWLWilHBBgY3LC7ETuAgAGpYAA=
Date: Wed, 27 Dec 2023 07:05:45 +0000
Message-ID: <e21a66b279fd780e4d23f3f58f0b1108e6cda2b7.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
	 <20231223182932.27683-10-jason-jh.lin@mediatek.com>
	 <63c24cda9e007ef2128e9350b6a6ed3bc61f3a85.camel@mediatek.com>
In-Reply-To: <63c24cda9e007ef2128e9350b6a6ed3bc61f3a85.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB6303:EE_
x-ms-office365-filtering-correlation-id: dc8637a2-c502-4798-2eab-08dc06aa3f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPorK2WbhUqTShy2NwsGuFUvb2NzDh8Po7qSCh84OmE9hwSQO0iE+fBtcT6TVRmViOb103eiRcog/n9k+U4x8wv5DWG3HvZ87N44oeoYs7k5AWolwGuv+49yBgDWjxeoL7JUYM/APckhS9Ko6tBkBCy+r46ra64pSBzYreNYFvSVBkFfq3WQTVIdsn/DDZakjICen3cU2ZJXzo9RJIXkgoYvmTDmK/QrXFYS0U1dN0bzs+wOA8Vu1oK3iK/6yRLLyWxXgRLTLDAtOv4xJOWiv9HQMHeFLkIV/ewfxAJcahIHSIdrrckGQk0FAZG6D1R1ojBW51bOKvM5Ir9Lno8dTHyTAF49fVSieOnvtNYNNNomtEyiO8atOWCNGp3Bx/NkCoAII+KIu3YnZ2GaPTyERjadKXHxbJVMQcQVf8KLJtOH11E7uXvNOEiHbSKFKw0PZIxpL8e//1dMWE6mm4iBSGQ+yHy4PDRupm2N79J48mOrWyD1qP7d+OeOUyvwYI+ZvumwHs+diF73NgYUACtS2hKHp5szqLtH3JtXtBwPvDqQX3gZM+eGt02wtxnCUHNMP9TnXU1AQ+1yVBfOEF++obc/EW3ilaDlWRzk+dS/gpS/eZnCUq6sWvFbxdCSf5JdAjZW99bX/Yq3/tNY+9bqyc0nSSAhmq22Pz4XewjrkAQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(39860400002)(366004)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(8936002)(8676002)(71200400001)(6486002)(478600001)(36756003)(86362001)(2616005)(6506007)(6512007)(26005)(85182001)(38070700009)(38100700002)(122000001)(83380400001)(41300700001)(110136005)(54906003)(91956017)(64756008)(66476007)(66946007)(66446008)(66556008)(76116006)(5660300002)(4001150100001)(2906002)(7416002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enE1UkhnVDA4S2E1YmpvZmxEWTVGUllmbnlvQzYrVk5HU2NBNkY1WWgvMEs1?=
 =?utf-8?B?M1FKb0FmMkgyM3d4WHdhQjhyU1h6T0NaRkpxdkhFS254VDFmQ1prRlJFdTlX?=
 =?utf-8?B?RlVoeWFhSVFVOTVrRkh1MGp6UjFuTDI4VFg0dzIxWUo0YWtMNHFWUFN4NjBl?=
 =?utf-8?B?Q21YUjZCUGJMMFpmaEJpbmV3alRNTjFEc2dkVktmMU4vS04ySk5VUnRMKzRT?=
 =?utf-8?B?WHlKeVNxajVaRFVhQjdyRk1RZ1lGbUdKUU93NDlqUDhxcFVvSXJNNmZla2Ry?=
 =?utf-8?B?aU53WW9DV1ErckF0OWJWVUtUVjhUU0RhNlVUQm41NENzRU1JeTJBTDNkZ0t6?=
 =?utf-8?B?SHM1NWVqOXQ5aVdPcFNSTzBHZ0hUVjRvMkxvY1VncnozY2FSNnBRT1dlQS9n?=
 =?utf-8?B?ek9UTUFjZzF6Nko4WExXUFI2bGFubDEyTERrejZaa0c1bjVKNU00OGNvRGY4?=
 =?utf-8?B?Ui96T3M1b050THRJWHJRcm41YkpQam12bS9KUjUrbHE0UnFEdFBZbitwWm5l?=
 =?utf-8?B?MXJENjE3Rjh1a0ZtRjUySy9GOWM3TG9ORjZKbFRtVmJpRGhsRW1sYUNHbncv?=
 =?utf-8?B?R0lEeVlQN3dSa0M3QWRZMjlVVEsyZDlEK0daV2MyVGNwVkFEaUlaMlM4WjVC?=
 =?utf-8?B?YUFwYllJdmpHMm95SnM5WUJEbll5bHVzT0p0djFzZFJ6Z2VOdTBoNnhTM3ZC?=
 =?utf-8?B?UDNGeVpXVHJYR25hU0dlUllYUFpseW9IQllTbk9wUUpnVE5xTlZ4WXQ0REJY?=
 =?utf-8?B?TmduZFpqWk1qWTdEZnAvSFRJZkY3ZGp3aDFIQVZ4bHZXVlpYSDA1SVgzWndz?=
 =?utf-8?B?bklQOUwwYjRScUIxRCtENm15WFFkWlovM2NHKzRBdCtGRFlXdU1OQ0xJZlpt?=
 =?utf-8?B?NUE0Tkg2bWdhMDdadU8zVEhYRjc0YXpMQTdGVkwzRnpmd2Q5QmN6dDFYTTFH?=
 =?utf-8?B?bFlOTHN6MXZJVTRrVG1NNFJtS1Fka1FLZyszT1laT20vUTUxMFlyNWphdC9I?=
 =?utf-8?B?aFFTa3NuOG53MzlRZUdBU0gvTitrSEcwRUxlY3FhNXJzRUMrRDIwQjdnSzlP?=
 =?utf-8?B?aEtLNVg4TFpxSTlZNjRaT05QNEFXTTF3cWpTV1RpbEoyM0UzL2N6Qjh1Kzk0?=
 =?utf-8?B?SkZCWmVzU3FPQ3NsZ0tlTjByUENXQ2lYa3NlTXp0RlBiNE5xWEtnTVdpVTdj?=
 =?utf-8?B?RW5vYmtVamJpZnk0Vy9ncVBndkNlNzhwdWQzczZYbmN1OU1tZFV1OGp2OXRO?=
 =?utf-8?B?dTVlS0Q5cWZEWmNlOUxWMW5TcUNxQzNYcWZ4Ky80WXFIcithcEQ2cmVoTTRH?=
 =?utf-8?B?YnNrbExlYmZROTZCZHViTms3NkVuV3lCQ0JlY3dZRlE1S0cvek5ydURncGVj?=
 =?utf-8?B?UG1HcVAwTCtZa0d6RjNnczZadVNSaEZIU0M5RUJRNDBsQmhDMVp4SWNOdnQr?=
 =?utf-8?B?aENabGNPSHFMdnpDbW50bUR3a2tTbGxlWHRYYmdOOGh5TnZSazN2Z054SGQr?=
 =?utf-8?B?YUZLZG5pRmpTVWg3elVwbklEZTJIMkFmVHhVYTZOVnRZZVlRTDRqakZPWHZv?=
 =?utf-8?B?WjNxRXJHZ0RPRGc1NThXUVBleEJ5UGhzemtnUjlWOVpUME1rYVpsZFAzVUYx?=
 =?utf-8?B?WmZMSy9GbkJRNU8rbDNFOFFaN3RKeDRYUHFkemVtcE43OVNpTU12NUMrSHRi?=
 =?utf-8?B?b1c0dGY4NEtzQzY2aG8rVldxNjVtWnpXNDNTNFZnNUl3cythNkNWOEpyZ1FX?=
 =?utf-8?B?UWZOenFTNVZrM29UY1dKVnFWNXlMVzFPamdkQ3lENTJTeWZVbXFZc3NLYS9W?=
 =?utf-8?B?Unl4MkwzWnREMkk0UWFpWUUwdWdLZHFqQzJ1VVZsRDdzZ3BYRmxqVElZbVkz?=
 =?utf-8?B?U3RzLy81d2lTczY0VFdxaW15UGdFZkhBdEpNQmhYcDZydjB0UVNFU1oxaWkz?=
 =?utf-8?B?VG03ckpNN29XZXBRaUZRT0lRR3lKaTU4SEZiM0VFMDMzUDl2T2JEU2pBNXBQ?=
 =?utf-8?B?VDN3SnlwRU1qZGlYcWNPTnY1V1FyRUdjdHNFOThPQ3JCbVJyMTRVakdZVG4x?=
 =?utf-8?B?MG9rcmpRR1RGNXFJL1lPNHp3a1grajZROFBrZFlnYnBvdnNxR2dRenI5T2pj?=
 =?utf-8?B?YjZvaXNVU1pxTFJ2VkJxRm44Y2x2U2lPNzFiUVdna3dUcnNueXJEOXhLYVRp?=
 =?utf-8?B?cHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D7A9C98AE5124240B53553CDC6606BC3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8637a2-c502-4798-2eab-08dc06aa3f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 07:05:45.3607
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tgjUA+quh4PZXBcl1fegepOzB2r+UN+Wqh5FyogXqiQ44iRXukmtMAoKEG6m7Fj6VBXHnloAuigKkpmvSazLHz0URLuE14G+OhW0IVZdnus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6303
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.034500-8.000000
X-TMASE-MatchedRID: y/2oPz6gbvinykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/mNRhvDVinv6Sx
	VUPqsOdUXJHwgBAo9RpitkvYBbEBaAvAB4D4lleIsyNb+yeIRAoTbU1KYGoQp9vpj5+dNlQvohQ
	ioQPL1+7pei94w5zOw6QmkBs0f5w7BL4/RE3F3wddtN+hx8BZv7n7V+KB+3cuuqWf6Nh7tmHSnr
	qDj9ZW6MpsntH0/Aai2Uyc3vPhYlDrbEGb+5Q/ecqXjImgj58bmyqQJWNsukkY0A95tjAn+/S3e
	S1IfvbyM0lfiZz1T6LY/FoqAB0MSFNgK05AHomungIgpj8eDcDBa6VG2+9jFNZE3xJMmmXc+gtH
	j7OwNO0CpgETeT0ynA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.034500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	E2D943AB32723E9190588B1D7BC3BA56102A80CAC49BC6F22E9C2CE59DCCD8A92000:8

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0yNiBh
dCAwNTo0MyArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIFN1biwgMjAyMy0xMi0yNCBhdCAwMjoyOSArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IFRvIGFkZCBzZWN1cmUgZmxvdyBzdXBwb3J0IGZvciBtZWRpYXRlay1kcm0sIGVhY2gg
Y3J0YyBoYXZlIHRvDQo+ID4gY3JlYXRlIGEgc2VjdXJlIGNtZHEgbWFpbGJveCBjaGFubmVsLiBU
aGVuIGNtZHEgcGFja2V0cyB3aXRoDQo+ID4gZGlzcGxheSBIVyBjb25maWd1cmF0aW9uIHdpbGwg
YmUgc2VudCB0byBzZWN1cmUgY21kcSBtYWlsYm94DQo+ID4gY2hhbm5lbA0KPiA+IGFuZCBjb25m
aWd1cmVkIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4gRWFjaCBjcnRjIGhhdmUgdG8g
dXNlIHNlY3VyZSBjbWRxIGludGVyZmFjZSB0byBjb25maWd1cmUgc29tZQ0KPiA+IHNlY3VyZQ0K
PiA+IHNldHRpbmdzIGZvciBkaXNwbGF5IEhXIGJlZm9yZSBzZW5kaW5nIGNtZHEgcGFja2V0cyB0
byBzZWN1cmUgY21kcQ0KPiA+IG1haWxib3ggY2hhbm5lbC4NCj4gPiANCj4gPiBJZiBhbnkgb2Yg
ZmIgZ2V0IGZyb20gY3VycmVudCBkcm1fYXRvbWljX3N0YXRlIGlzIHNlY3VyZSwgdGhlbiBjcnRj
DQo+ID4gd2lsbCBzd2l0Y2ggdG8gdGhlIHNlY3VyZSBmbG93IHRvIGNvbmZpZ3VyZSBkaXNwbGF5
IEhXLg0KPiA+IElmIGFsbCBmYnMgYXJlIG5vdCBzZWN1cmUgaW4gY3VycmVudCBkcm1fYXRvbWlj
X3N0YXRlLCB0aGVuIGNydGMNCj4gPiB3aWxsDQo+ID4gc3dpdGNoIHRvIHRoZSBub3JtYWwgZmxv
dy4NCj4gPiANCj4gPiBUT0RPOg0KPiA+IDEuIFJlbW92ZSBnZXQgc2VjIGxhcmIgcG9ydCBpbnRl
cmZhY2UgaW4gZGRwX2NvbXAsIG92bCBhbmQNCj4gPiBvdmxfYWRhcHRvci4NCj4gPiAyLiBWZXJp
ZnkgaW5zdHJ1Y3Rpb24gZm9yIGVuYWJsaW5nL2Rpc2FibGluZyBkYXBjIGFuZCBsYXJiIHBvcnQg
aW4NCj4gPiBURUUNCj4gPiAgICBkcm9wIHRoZSBzZWNfZW5naW5lIGZsYWdzIGluIG5vcm1hbCB3
b3JsZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxp
bkBtZWRpYXRlay5jb20+DQo+ID4gDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gQEAgLTEwOTEsMTQg
KzEyOTIsNjMgQEAgaW50IG10a19kcm1fY3J0Y19jcmVhdGUoc3RydWN0IGRybV9kZXZpY2UNCj4g
PiAqZHJtX2RldiwNCj4gPiAgCQkJaWYgKHJldCkgew0KPiA+ICAJCQkJZGV2X2RiZyhkZXYsICJt
dGtfY3J0YyAlZCBmYWlsZWQgdG8NCj4gPiBjcmVhdGUgY21kcSBwYWNrZXRcbiIsDQo+ID4gIAkJ
CQkJZHJtX2NydGNfaW5kZXgoJm10a19jcnRjLQ0KPiA+ID4gYmFzZSkpOw0KPiA+IA0KPiA+IC0J
CQkJbWJveF9mcmVlX2NoYW5uZWwobXRrX2NydGMtDQo+ID4gPiBjbWRxX2NsaWVudC5jaGFuKTsN
Cj4gPiANCj4gPiAtCQkJCW10a19jcnRjLT5jbWRxX2NsaWVudC5jaGFuID0gTlVMTDsNCj4gPiAr
CQkJCWdvdG8gY21kcV9lcnI7DQo+ID4gIAkJCX0NCj4gPiAgCQl9DQo+ID4gIA0KPiA+ICAJCS8q
IGZvciBzZW5kaW5nIGJsb2NraW5nIGNtZCBpbiBjcnRjIGRpc2FibGUgKi8NCj4gPiAgCQlpbml0
X3dhaXRxdWV1ZV9oZWFkKCZtdGtfY3J0Yy0+Y2JfYmxvY2tpbmdfcXVldWUpOw0KPiA+ICAJfQ0K
PiA+ICsNCj4gPiArCW10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2xpZW50LmRldiA9IG10a19j
cnRjLT5tbXN5c19kZXY7DQo+ID4gKwltdGtfY3J0Yy0+c2VjX2NtZHFfY2xpZW50LmNsaWVudC50
eF9ibG9jayA9IGZhbHNlOw0KPiA+ICsJbXRrX2NydGMtPnNlY19jbWRxX2NsaWVudC5jbGllbnQu
a25vd3NfdHhkb25lID0gdHJ1ZTsNCj4gPiArCW10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2xp
ZW50LnJ4X2NhbGxiYWNrID0gZGRwX2NtZHFfY2I7DQo+ID4gKwltdGtfY3J0Yy0+c2VjX2NtZHFf
Y2xpZW50LmNoYW4gPQ0KPiA+ICsJCQltYm94X3JlcXVlc3RfY2hhbm5lbCgmbXRrX2NydGMtDQo+
ID4gPiBzZWNfY21kcV9jbGllbnQuY2xpZW50LCBpICsgMSk7DQo+ID4gDQo+ID4gKwlpZiAoSVNf
RVJSKG10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2hhbikpIHsNCj4gPiArCQlkZXZfZXJyKGRl
diwgIm10a19jcnRjICVkIGZhaWxlZCB0byBjcmVhdGUgc2VjIG1haWxib3gNCj4gPiBjbGllbnRc
biIsDQo+ID4gKwkJCWRybV9jcnRjX2luZGV4KCZtdGtfY3J0Yy0+YmFzZSkpOw0KPiA+ICsJCW10
a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2hhbiA9IE5VTEw7DQo+ID4gKwl9DQo+ID4gKw0KPiA+
ICsJaWYgKG10a19jcnRjLT5zZWNfY21kcV9jbGllbnQuY2hhbikgew0KPiANCj4gSSB3b3VsZCBs
aWtlIHVzZSBzZWN1cmUgY2hhbm5lbCB0byByZXBsYWNlIG5vcm1hbCBjaGFubmVsLiBJdCBtZWFu
cw0KPiB0aGF0IG5vIGV4dHJhIGNoYW5uZWwgaXMgcmVxdWlyZWQgYW5kIGNoYW5nZSB0aGUgb3Jp
Z2luYWwgbm9ybWFsDQo+IGNoYW5uZWwgdG8gc2VjdXJlIGNoYW5uZWwuIFRoZSBzZWN1cmUgY2hh
bm5lbCBjb3VsZCBwcm9jZXNzIGJvdGgNCj4gbm9ybWFsDQo+IGJ1ZmZlciBhbmQgc2VjdXJlIGJ1
ZmZlciwgc28geW91IG5lZWQgbm90IHRvIHN3aXRjaCB0aGUgY2hhbm5lbC4NCj4gDQo+IFJlZ2Fy
ZHMsDQo+IENLDQoNCkl0IHNvdW5kcyBxdWl0ZSByZWFzb25hYmxlIQ0KDQpJZiB0aGUgcGxhdGZv
cm0gb3IgcHJvamVjdCBzdXBwb3J0IE9QVEVFLCB3ZSBjYW4gZGVmYXVsdCB1c2Ugc2VjdXJlDQpj
aGFubmVsIHRvIGhhbmRsZSBib3RoIG5vcm1hbCBhbmQgc2VjdXJlIGJ1ZmZlcnMuIA0KSSB3aWxs
IHRyeSB0byB0byByZWZpbmUgdGhpcyBhbmQgbWFrZSBzdXJlIGl0IHdvbid0IGNhdXNlIGxhdGVu
Y3kgaXNzdWUNCm9uIE9QVEVFIHRyYW5zYWN0aW9uIGZyZXF1ZW50bHkuDQoNClJlZ2FyZHMsDQpK
YXNvbi1KSC5MaW4NCg==

