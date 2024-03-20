Return-Path: <linux-kernel+bounces-108671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC953880E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002E7283850
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360039AC4;
	Wed, 20 Mar 2024 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="hitKEN8E";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="SVkIRkVW"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C125605;
	Wed, 20 Mar 2024 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710925494; cv=fail; b=JYBnH4QI44bzjtqNvt0ttWz7HoF9EK5HBzqBNshdHYwlSIo84l4G2DOhaLE508/kuysvr77u/e7LbDwvvDvrKH3O8jD04r+MBTX21a4HBRnILddK9A/ogXT1PBLTQR9U2deK/FpAjsreXdH4iHYymbzkR9+uTiuftGbOQdI8iDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710925494; c=relaxed/simple;
	bh=ALH+1DwgTVapYVhlhXAH0fS22VQA/I2bjqvxOZsIYPE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLdnvuNNzRygeq4XXhJTSzf+25VKGd+yCZ2qXO9ylDYl6hedJPNXIV/UpzxqsA7+YpM5jY4AnuYo2G3ee+lOi7NJtFtTp8Gr/3tuG6FDAe/dWy7SSTOEteDJ5nCh9Y6/YgQFSxvKtP/vt0mfzfPzsNoxpSdkLQN9aDf4rWg7xpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=hitKEN8E; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=SVkIRkVW; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e6e4ccd4e69811eeb8927bc1f75efef4-20240320
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ALH+1DwgTVapYVhlhXAH0fS22VQA/I2bjqvxOZsIYPE=;
	b=hitKEN8EO7OjsAR3yn2mcmrO04r0QDdlR+13ibqR4hAOnkhyqfBygg16NToCLXG6cJu5Th+tTI3j6sblhs3PQ0blOdk06sIsKMBi3J08lHekmuxbgXszwsBZHTK/3VS+o2ZwkWUgzyPeWXiUETLmsnGkXu3+SaYJIJg6Rx3W5P0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:1a949141-e34b-4581-805c-5344092dddf3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:16da9e90-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e6e4ccd4e69811eeb8927bc1f75efef4-20240320
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1982857913; Wed, 20 Mar 2024 17:04:47 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Mar 2024 17:04:46 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Mar 2024 17:04:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVEEUvwLuzrdvIOQ+zDWBdD3M6cGk3IGb0C1RoWm1NuDxRqb93DGyt4eHZn5Hzfo8AmqJPcPot7MlsTJHi+yejL9PBVG4K1h17eSMDVhl8lurRm2INY0BYMz1ogxfbYF0C3gRUo5zjmIux0emHFzcuS25F8GjmlBmUNxzFtvld/PWjk1lIuxkxHHMXKGgorfZBJbU0VMHhOpnEpey6hWJ0WU5mmBvO5rVEWxRwOmjWbhFt60UgKL2Lnucuk68gOLo+OCNtGaxENio0x9abVpKnmV6WMkjnR7llwIGjNNi+Hu/SyH3X7ha8vUBDWvULuk5MPzOh/YT2G3pBDzCyWP0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALH+1DwgTVapYVhlhXAH0fS22VQA/I2bjqvxOZsIYPE=;
 b=Jq7O2Erlt/Qggib1R8qXHgwH1egIYVm1mhl4g3ihuLLm2WqjLSAfUikze4VcMpU4CnI22cFqoMF1DDmxfUegMOlkW2APc87OA5Jh1PMaay5w/UWDjhbfh0bLHgVuZGx/wNn3WuthfihCZes6gEBmveSt92S0S3USKsngSYDF7NrOMFgnWotu/bXqmAU3l1LD4c/eaSdpG19pIwSjRmdGyz4tSg251Gz+tDmkVEnxYSrEoSTYBN1riVV6AS4Ul+LnavzEH4ZQUTN6iq5ZL8t+rXpsLoSzTQQXsnTLo/0mFjWYVA4GqRJK7F3MV8SKMuq7TgsZVDW0C7xU1OOfDOzoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALH+1DwgTVapYVhlhXAH0fS22VQA/I2bjqvxOZsIYPE=;
 b=SVkIRkVWu9VVihK7piwH78tCcUTurSKi3s6A2vhvrsm37/LJ1tM2QqnmkjqdVg51pq2fjGZcBc/RapmaEOb7HM50ADc9CS2JBbmfajPkQQ/UCZ4awztFcOz9vIQg5t/HR+FEQTavPARg6ESntCTK5FGixa8Cdn2apd2CBbuCmlc=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYZPR03MB8659.apcprd03.prod.outlook.com (2603:1096:405:b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 09:04:43 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 09:04:43 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jstephan@baylibre.com" <jstephan@baylibre.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?QW5keSBIc2llaCAo6Kyd5pm655qTKQ==?= <Andy.Hsieh@mediatek.com>,
	=?utf-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?= <louis.kuo@mediatek.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "fsylvestre@baylibre.com"
	<fsylvestre@baylibre.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "pnguyen@baylibre.com"
	<pnguyen@baylibre.com>
Subject: Re: [PATCH v4 3/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Thread-Topic: [PATCH v4 3/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 sensor interface
Thread-Index: AQHaQ8+FLeNoj2TSiEO6O2ToF6Nq3rFAw6gA
Date: Wed, 20 Mar 2024 09:04:43 +0000
Message-ID: <bcc4b5c7e841e758c43733599cca3b5a5430674a.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-4-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-4-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYZPR03MB8659:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0/YwdyIFjrNYrpH733aW7W6oUcDZM0p+18kg3H1OnAwzurxh5juNsL59rLYAfemTWjX9z04qat68gMELe6RqHluwp8dax3Rh7l3Q1wpQzp3KbhKL+Ew/UHSFTvFxeJR97WKGb+M77WIRGtGtrdEPxlvi8CwfVVngxzeD3f9/f0PCjKoraYCP6q8mlUMPllKe6tR4OPjXZUNfWLOyhuIEtoagCRO0730IwTToXBKJXBe42rBCTPIZLLVtuT5/K0Y6P6v669X1DPA4+g4/ldkQZTtY6LNsvF4KTYHFYO3VtZ9oi2Z8rfrIm/3PezaTJdQNAzyMjEDbgCXAykG+up83+1rnU0wfY8LiDk6VhdfpFeTauY8tPAAd+7uvI2zf87h7pn7KpJ8CEBmtjaj4OTxWLBd6t8KY682AbgyUN+A9oKOdhZ7ZebJQwqicwIPuRe8J4v/IPp1c7kzKYBdnFC3o+W9SYV86egnmkFbNyXUIoeko9vJFT9uHfD1487irikQSzs5DaJwGhvCR2gtfLaM+29J0Uqx0ckqHG1zhfMttJlMbkBIegmmNQWT1uhXM7QdkMu1hAHu7aoVC7Qv+aAY9DJWEU3N86wG8tp9PR+TmA+MIOT26h0GGl1E4hZaAwSgyrqIe9EFgE7VSiWMUDGhdP7Y6LlsivkvEbszXEdNemw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ME5xUG56dDk2eXZuSVBvaE1VZVd4dEo1cTQvQUpYSTI1bmJIRnVTVzE2bVRk?=
 =?utf-8?B?eEM3bGhJUjA2c3Rnakt2bERFSG1ESlQreHU5MzZZNC9mYTFRTUtpdHR5M1dq?=
 =?utf-8?B?eHdzeTM2QisxaUJoYjNkNUU4TzRCdUx6S2RsN2pEazcrK00xS3dzeXhaU0l3?=
 =?utf-8?B?b0JhcklSc1JMejY3cTdpSGtBckE1SGpmNzRSdEpGWXdFN1prS0RTWmp3RnlQ?=
 =?utf-8?B?RW5MbVdpdkttMmJhenhqSzhEbm53akxnbVpDakNJbVg5Nmx1dFJwT1hJRG9W?=
 =?utf-8?B?U2ZrRWRCb2c2RW15bVdrQW8vMEhkUDNOMWFudHYzQSsvaytjemVYV2hqVXNW?=
 =?utf-8?B?MmZqUFdicis2UzhCcUc0NnU4MERvOEdEN1NaejFzdzZPaDVRVmlxU09PSnpQ?=
 =?utf-8?B?R25JeXppL21IMEtoNk5yWlJ2TU5zMDR6TC9XYzV2alNUSXlCam4xc2d0ZTJp?=
 =?utf-8?B?aXYvWnJEQkNKQk0yTzRoU2RnT050WE04OGJnMEVlNVI3SUo3WUREeXlTMTFp?=
 =?utf-8?B?S2Y4ZG1hYUJQemNrWmhnZ0lrdXBodmpuQXJ5YVJJdDhvQ214bkU4dVo5Y3Br?=
 =?utf-8?B?cUY0V2tHMEh2bXgxbTZISVBmNlUyV3IwQ2V0YzF5U0ErU3hWaURLM2dHWlFj?=
 =?utf-8?B?ZHFoRWgvRnVyYjhpblFud3d1ZDYrb2Y5NFhDYTRpVmhYSVM4dEI2UmlWbVhW?=
 =?utf-8?B?U25peDhTUWFmR0Rtall3dU5ncVBmcnFsaVd3RDJlcVNiMGN0eVpkUTRqeE80?=
 =?utf-8?B?THMrZk9DSzBlQ3ZEalFnOWFQWVNWUGlJS2xneHhYb2ttTmZVNzJZVTZjZ3FJ?=
 =?utf-8?B?SWl4ZzhSajdGS1hLS1pLaUMvV1hRNlVQZWRldW1GMXFrSmNMRFZGRGlkYUhE?=
 =?utf-8?B?UkNDeG5BblYxQStjNFZCNkUvSU85NGtaRlRCSEtHYVQ0d3p5UUJBT2h6RXBn?=
 =?utf-8?B?MDRsN2ZZSmdQRlRYMmVSUlJ5T0oxVzNPc3J3ZWVpRk9DaTBneUtRNnNqQ3lG?=
 =?utf-8?B?UWtrZ0VydVVsYUF6Z0RqVEh3VktvQlVieHFWTXNYZzkvdmowSjVBQjVsdkpX?=
 =?utf-8?B?bis3cm1RNkJ4QWw4NHg5WFl1MkR3ajgrMDN3THowZUkrRktmNDBWOGtpdmJs?=
 =?utf-8?B?NEFWMHI3ZVBrY0dMQS8reFhOajE1eDMrYmd4MlVrZkppSCtSUnBlOFdBaFQ1?=
 =?utf-8?B?ODg4eHhoVWdsZVIxenF4NnVjMHg4ZGVFSGNBbCt1TUZrQ3FUa0pLbHVCRWVl?=
 =?utf-8?B?SFhYaDRIemI0MmFKek13NGhyWUNYU1Q0ajhvdGttQVRENWtaSkRZcGZ3Wktk?=
 =?utf-8?B?M3I2YVpCbmFIS3J0V2hVM0U5Njl2bmgzK1RNZG5pVXlQZTdtdnU0TWhqYStN?=
 =?utf-8?B?d0UzSXltSG9iK1BiNExIK1NNR3pncUtsa3h5OW0zZTRyUEh3dmlTWWxDbklW?=
 =?utf-8?B?K2lvdnNKNXB6MzFNa25DSzZQb000c3RoOHlSMnA1SEUxOHVudTJJK0VKUEFW?=
 =?utf-8?B?U2htdUc3eUdhNWtoZ2tuWURFbzV1U2lleFJsNC9SV1dUVklJL2dNajhTTDF2?=
 =?utf-8?B?RDZhVko0TWdieTNMWWlTdi9tWkxSVmgvNGdsR0VyVzd0RHoyRWQvZDFTNjlk?=
 =?utf-8?B?akZWWkpMV21tNExmY0hSM2NydWVQVFpodlVCeU92UXRLZlBHSmNYai9sbHVO?=
 =?utf-8?B?ZllDbmszcCtYUExJZTJPK1BYa1RTYmRzUk84WG9UZGwvdVhxWTU4VkZsaVU2?=
 =?utf-8?B?UG9XT1FrVys2N1Nad1JXbWNQT3dyQW0vQTB1MTFvUzQyZWxOQUROd3NXN1Y3?=
 =?utf-8?B?Vmg1RzV3NThnQjBmTi9GTGtmenBkTGxqMDYrT3FDdjBXNHlQdVJ5QnV6c1J3?=
 =?utf-8?B?UkhSYzk3Tk5UeHdZd1piUlcyZ2wwTFlwSXVDcGJQM1hIdjM5emV2YjZGMjNL?=
 =?utf-8?B?L0lVQk8vYjZuZ3FhYVowZG9TOWQycis3ZTdmRmdqVW9JNVFtWmJnMGI4U2Yx?=
 =?utf-8?B?K2psTTBneXl4VStvSTlwY3YzRFBtV0ZBell0U3h0K3dITFYySGNneGN4eHd1?=
 =?utf-8?B?NloxQ0pLaFZ4NnlyZDdQcGhYWjltemlIejkyaEVBSWVYUi8yTzVWOW9INXlH?=
 =?utf-8?Q?9rDLsHSP42wskrF9KcNSufhCd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C7B0A199E5146498A4924610E693CD1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57de5a7d-074e-4ebd-6698-08dc48bcc845
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 09:04:43.0634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zjFMC9OEGs5WoO/934w2UmJOibuYurTAPi50hmE2DiD5bjwRt0kbunZ9Dl4XutXeWgXJhyII5MRUWo2BtuY8LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8659
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.482000-8.000000
X-TMASE-MatchedRID: O/y65JfDwwsOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0qbqzDH9G7eTD1LciJB3541oMfp2vHck9VUazBX+AUFScaQTVtPXXNM8ha
	W4U9IrFpRUHsj/YINIGFuO67PYQBJDPIzF4wRfrDSBVVc2BozSpwhktVkBBrQjvEeq6gAkYarus
	VRy4an8SAHAopEd76vEVDnJUqo+VN7MJTSV//Pzn6foOkrvnTN+B07salcOJe8gjl/hi1hlQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.482000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	291AA99DB4DAD444C4437E47565D335C7F01E6FFA7C7B48E25B15E63F7C7430B2000:8

SGksIEp1bGllbjoNCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE1OjE0ICswMTAwLCBKdWxpZW4g
U3RlcGhhbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBMb3VpcyBLdW8gPGxvdWlzLmt1
b0BtZWRpYXRlay5jb20+DQo+IA0KPiBUaGlzIHdpbGwgYWRkIHRoZSBtZWRpYXRlayBJU1AzLjAg
c2VuaW5mIChzZW5zb3IgaW50ZXJmYWNlKSBkcml2ZXINCj4gZm91bmQNCj4gb24gc2V2ZXJhbCBN
ZWRpYXRlayBTb0NzIHN1Y2ggYXMgdGhlIG10ODM2NS4NCj4gDQo+IFRoZW4gc2VuaW5mIG1vZHVs
ZSBoYXMgNCBwaHlzaWNhbCBDU0ktMiBpbnB1dHMuIERlcGVuZGluZyBvbiB0aGUgc29jDQo+IHRo
ZXkNCj4gbWF5IG5vdCBiZSBhbGwgY29ubmVjdGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTG91
aXMgS3VvIDxsb3Vpcy5rdW9AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBQaGktYmFu
ZyBOZ3V5ZW4gPHBuZ3V5ZW5AYmF5bGlicmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFu
IFN5bHZlc3RyZSA8ZnN5bHZlc3RyZUBiYXlsaWJyZS5jb20+DQo+IENvLWRldmVsb3BlZC1ieTog
TGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiBT
aWduZWQtb2ZmLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25i
b2FyZC5jb20+DQo+IENvLWRldmVsb3BlZC1ieTogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJh
eWxpYnJlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJh
eWxpYnJlLmNvbT4NCj4gLS0tDQoNCltzbmlwXQ0KDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX3NlbmluZl9jb25mIHNlbmluZl84MzY1X2NvbmYgPSB7DQo+ICsJLm1vZGVsID0gIm10
ay1jYW1zeXMtMy4wIiwNCj4gKwkubmJfaW5wdXRzID0gNCwNCj4gKwkubmJfbXV4ZXMgPSA2LA0K
PiArCS5uYl9vdXRwdXRzID0gNCwNCj4gK307DQoNCkkgdGhpbmsgeW91IHNob3VsZCBkaXJlY3Rs
eSBkZWZpbmUgdGhlc2UgdmFsdWUgYXMgc3ltYm9scyBiZWNhdXNlIG5vdw0Kb25seSBzdXBwb3J0
IG9uZSBTb0MuDQoNCiNkZWZpbmUgTU9ERUwgICAgICJtdGstY2Ftc3lzLTMuMCINCiNkZWZpbmUg
SU5QVVRfTlIgIDQNCiNkZWZpbmUgTVVURVhfTlIgIDYNCiNkZWZpbmUgT1VUUFVUX05SIDQNCg0K
QmVjYXVzZSB3ZSBkb24ndCBrbm93IHdoaWNoIFNvQyB3b3VsZCBiZSB1cHN0cmVhbSBsYXRlciwg
bWF5YmUgdGhlIG5leHQNClNvQyB3b3VsZCBiZQ0KDQpzdGF0aWMgY29uc3Qgc3RydWN0IG10a19z
ZW5pbmZfY29uZiBzZW5pbmZfODN4eF9jb25mID0gew0KCS5tb2RlbCA9ICJtdGstY2Ftc3lzLTMu
MCIsDQoJLm5iX2lucHV0cyA9IDQsDQoJLm5iX211eGVzID0gNiwNCgkubmJfb3V0cHV0cyA9IDQs
DQoJLnN1cHBvcnRfeHh4ID0gdHJ1ZTsNCn07DQoNCnRoZW4gbW9kZWwsIG5iX2lucHV0cywgbmJf
bXV4ZXMsIGFuZCBuYl9vdXRwdXRzIGhhcyBubyBkaWZmZXJlbmNlLCBzbw0KaXQncyBub3QgbmVj
ZXNzYXJ5IHRvIGRlZmluZSB0aGVtIGFzIHZhcmlhYmxlLiBTbyBkZWZpbmUgdGhlbSBhcw0KY29u
c3RhbnQgbm93LCBhbmQgd2hlbiBuZXh0IFNvQyB1cHN0cmVhbSwgdGhlbiB3ZSBrbm93IHdoaWNo
IG9uZSB3b3VsZA0KYmUgdmFyaWFibGUuDQoNClJlZ2FyZHMsDQpDSw0KDQo=

