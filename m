Return-Path: <linux-kernel+bounces-127431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE82894B39
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA051F226EC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67D5199A1;
	Tue,  2 Apr 2024 06:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NwfplQWr";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tKZPuemv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD317588
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038809; cv=fail; b=CIy/t91b43Qy9nIMKcAsFytroPlLSZrlLdoNxLGHnir4PnOXJcBorLJik5J0klorsll4a6Z3PS/mVkk3rDnk7BbX7Cv81yMBYY2pt8ZcOHuQbYaTLWguwoJ33X8fSJ1swIiGTNA4NLbb6ExScW4fblPRkvNBB1Micen8uYFVrI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038809; c=relaxed/simple;
	bh=f2Lh5eRLWX3yb6bWKYqHH1vp77wJljITj+EIHLEAYB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hCeKiILmxuq2EOUiiTNLfyR8B92K+UGJMKcUUF4OlcFBQl/k2zyxhyjsc+ujtjr06Ee7BNB3cKgC1KyJDz3hcv0xxtRqe1qy8QSkrGWvCoDl6Zc65HWjo+p5R9jtHlVu7sVnbifeg3ejnTNd3x3lTz8KcjiM3V9klZ0VxmIdnXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=NwfplQWr; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tKZPuemv; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 05692ccaf0b911eeb8927bc1f75efef4-20240402
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=f2Lh5eRLWX3yb6bWKYqHH1vp77wJljITj+EIHLEAYB8=;
	b=NwfplQWrHoUw8t09RU0kYMylZ4EOmCrKX9reESrrKkJ9tgzZr218GLAOUDyYJcj+XWarW02pB8BtMaSymunkjz0+S+g6lqywjRzJhn/TZsu0M/HvSKruWK70QHJ+ayVebZaLblrP6Y9wRwbML1+TsS8ifKRQYIngdwaREIAuRg4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:f6f52f98-bc39-49f2-9817-e34b8e4d2ca3,IP:0,U
	RL:25,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:6f543d0,CLOUDID:ad11b785-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 05692ccaf0b911eeb8927bc1f75efef4-20240402
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <boy.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 593041149; Tue, 02 Apr 2024 14:19:54 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Apr 2024 14:19:53 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Apr 2024 14:19:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1M1DnopipzgAffSK0mfGHqQGmbu85x9gzRxCtObPT4JFizFW+LlrveRdZcGS5Y5S9w1PC/9qechiEMlBWwSZ939JSrAjHhHS+7+qDHLWY0EGl2drv+f6eZ+12KD1IRfV13LwjQOgWjYFia+xho67Ew0ELAohl9q7Pk2MKinmN4LcnAQpBzoPpyth568lc0OF/AYTdxLuxjxlMviIge5Jf9vvavYmsydrZUZpfI79vDRiofEgZyz3sEB/b9g/OpGwFA5t4WplFYiVs5DFh78o7l2y3npm+nHgxN5CAE0XC6L/xA7S90ujDCgdbfP8/kOR6ieOnUZ8B4vQM9EICdakA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f2Lh5eRLWX3yb6bWKYqHH1vp77wJljITj+EIHLEAYB8=;
 b=HLMkKNaF08MhBvXTjTK9jlTXt+4XTzgA8tdEnbFxkOzW/7T5L8jgLuBdcpUqe5H4WViW/hY8XN7OYlNlyWjB1x/2LA6j98Ix7sZirSApkJnCFWgJWZg7FFR5RyC8T/Rojv94hmzZs5BvwFJweuc0mYZz22k2TGLOhno9DuQABrZ2r2xMaiYehn8rAY6Uhmjk4eLPWAW5EXfejuBIjtVoGdsQ31O2OMjvVWvyQXAEVVbfgMDxCTutxpen/kJQz0a0Sg7+AVv4F14pxlKI+/BqapHGw02Dc9NQTIhL1x+nynxDkm4Z7h+9tECmwe4EaNTLaZkggHogaB210jDbuVJmwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f2Lh5eRLWX3yb6bWKYqHH1vp77wJljITj+EIHLEAYB8=;
 b=tKZPuemvF8iUvu78Qc0Mzb9DcOzjEqt1oe562utVGmiyLk2dfMORSIYyqM77HF6u0gkSmgKPMNPlIO6KjEf7uUa3g1hYJL8xfcmWlGcnTVFWrApKXGJW0xdYDgxBBr0a7J4JNeXt0t/x2Lwz789OlaaQu4ibzoAlb5JiHhA8riw=
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com (2603:1096:400:465::7)
 by SEZPR03MB8418.apcprd03.prod.outlook.com (2603:1096:101:21d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Tue, 2 Apr
 2024 06:19:51 +0000
Received: from TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::45da:cd44:6032:ea9]) by TYZPR03MB7867.apcprd03.prod.outlook.com
 ([fe80::45da:cd44:6032:ea9%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 06:19:51 +0000
From: =?utf-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "ryabinin.a.a@gmail.com"
	<ryabinin.a.a@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "andreyknvl@gmail.com"
	<andreyknvl@gmail.com>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "dvyukov@google.com" <dvyukov@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "glider@google.com" <glider@google.com>,
	"vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH] arm: kasan: clear stale stack poison
Thread-Topic: [PATCH] arm: kasan: clear stale stack poison
Thread-Index: AQHaNH50g4opuV1/1EWa6LrsT9gdhLFOplGAgAKS7oCAA+lIAA==
Date: Tue, 2 Apr 2024 06:19:51 +0000
Message-ID: <1b18064c7ca66b26114610772f17753159351355.camel@mediatek.com>
References: <20231222022741.8223-1-boy.wu@mediatek.com>
	 <6837adc26ed09b9acd6a2239a14014cd3f16c87c.camel@mediatek.com>
	 <Zghbkx67hKErqui2@shell.armlinux.org.uk>
In-Reply-To: <Zghbkx67hKErqui2@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7867:EE_|SEZPR03MB8418:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hmTl+8hCLhD2FKA2uSSjnam2fiOhA4lVr1QEup+z43+MfKsydGp+DsZLVywFfOUX1m3KiQaKwdACvBrv3O2N6/z8aNqP3hJ73zOGj/MvwJRiB2BIgzqSCEtAEWg9lZN74KP7gx7Sun1SnyA5Y43hySNs0gV4FIQWOvZkuzOt3WDrcDNMqFO2o/kN4sV4xIj4LoGA9KqGmicM8U4jEUSoPKhqcTda459XhU58ucP0gBfxvgmb9m/qGXg1CPhotnafotWycv0GtGYxzr5uQGHXxtBRZiSCr7u2hJRqH5DyVxfzTmFJKRvzDO83LuvMdo7mfekkReIfF9oGJiYjYWijZMx9opqSlWyJq9ohJPyH9WAWTUicGwBnnieYjkMcRSWF5EUHBpty/Qr0t2wSdOy1HlSjCvBDhebw8rKxt+zBL8A+2WMZLIG/5sXqiH1SMyGzX0+JWZlX2p7BcnxySN+ESk1hlB0ScO165b8P3JG/0QOO538KUyNxgwQtKkvcCZHvAnhadR0G+ZO58Rgiq6WZUtHLyODZntSyAZbLQwdpxkzQWDrSCq65+Zka+QGrZNsCrH4ZSTufLln6Y2XM0Eoqk6GEc2lGgl6E/2Us2SBwhag=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7867.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHVMWlI4anJIa3ErS2xvaWhpZmpUZklvTlBweFNKLy8xUWI5TlJGMjVqZkRv?=
 =?utf-8?B?akR4R1NPSENPYStRanlLNnNyVWZuY1VLQi9DMWFCQXZXVFFlaGFpaC95a0g3?=
 =?utf-8?B?L0RuK3pJMlBrbEVycEU5RDRlTFN0alM1WWpwYnRUb2kxdVZSdkYxanZQZFJ3?=
 =?utf-8?B?NysvZkc0YmQzSS9OWWVmYmtBYmRFSjBJM0xLTXpnRWszSGo3ZXViTEtaZUNz?=
 =?utf-8?B?NlUveGNrR1dFR2xaSS9zY3B4dUlDem80Z29TeUxCekkxTnNtMjZ2ZDJpZmtF?=
 =?utf-8?B?ak9uaWl2REsyUWpTU0cyOVVEWTBuclFDeGRReXRZRHl1WkdZYWJFZG9VdWpP?=
 =?utf-8?B?TUVpVUFmc3NYdnNjbVlORWY4M0lNQW50cUFOVjRkSjRmUFF5Z2pGaVhoSEcr?=
 =?utf-8?B?bUYvVndZdVJ3SEh1ajdrVk9BeSttb3AwM0ZXQ3V5MVVlakV0My9DWStBMllJ?=
 =?utf-8?B?VloyYXgwZ2w5eDA1K0ZaOWU0YTJrMGhZd3ViVEJIaENjTGpERUd6NkxldmtJ?=
 =?utf-8?B?dmFCRkZ4ZW5ZSDhIQnhqWXRzVFdQWlF1THJqL2FyNU14UWtROFJzYUdQdmQx?=
 =?utf-8?B?LyswT0NHdlZ4cUFEd1ZBVGRNRm9ZUkQyaG9WU1psZ0Y2WGNWdyt5SytORnJJ?=
 =?utf-8?B?UTEraW4xcEEyOU9hQlF3NnhWTEZqUmt5MWowSG54NkZBQlFyTjhydWVzQ2Q1?=
 =?utf-8?B?MnNWdU8vYVBURjBQNE8xTUdlYUE4d0UwUTZjR1c1UU0wN2dMUjFOTnhERTli?=
 =?utf-8?B?bklia1FWL2tBNEVJOHFlTzJsaENIZEVodnJ3S09LaWdISkxuUGh0VGZCekFW?=
 =?utf-8?B?cHIreTd3NTNNUE9FK0kya090bThOTkZrM0xSekpGekVhdms0WVRJQ0N6V1Nw?=
 =?utf-8?B?VUpuQ2QrNm5OTDZsa1gxckFIWVU1QjRNNmxFODcrQUcyeVQ1dUM4Zlp4U2V4?=
 =?utf-8?B?ODBzRFdwa25BRGhUMFNSb1VkeEp0Wld3L2oyNmh5SzdTcTZTei91ZXFraTFV?=
 =?utf-8?B?QzZTMGY4TzBlN1RFMkdwQ3FxNEtISW5lSG80NlpwNWRlL2pWR3JSOUdQdXJ5?=
 =?utf-8?B?V0tRUjJUOHZCc2VaNjd6VFl6UUdBb3hoNzR4dENVdUYycGVWQWlmVjNxV0xG?=
 =?utf-8?B?TklOaFhSbS9XTGdJSVVKRjlHR0pPemxlaWZua3ZIUTBKRktJeDN3TDZObzRS?=
 =?utf-8?B?TEJOM1l3V3FobzQwQ1NmZEd1K2R5Y1BMakp4T1dzYzZnbkZHMmE4NFRjN3dw?=
 =?utf-8?B?ejFpdHl2VUdRU1hleTlDWTNoOEx2NGhTRHRLZkw0SVVpanlGckR1QkYzdFJj?=
 =?utf-8?B?UXRZRWY0ZDdJb3VuUndtbWhNdDlmL201VCthSjdCVEZSQ1kzS1U4UmNOTlBC?=
 =?utf-8?B?T0k0bmdSc1N1MkhxZWxDL3lhSWYzOTk2Z3pMR3pOTmpTakdHMXl6TkorQlc1?=
 =?utf-8?B?QU5Dc1hkYWFac0xsZ1ZTMjdxdmt0R2wzTWZJdzEzN09tc1FhcnJNeGFhSzVN?=
 =?utf-8?B?bmt4TE1NSE5wVTFGdmhPOGpFRjE5UEZydGs4QzNvUnczYkluelUwRWNZSWlX?=
 =?utf-8?B?ajZsbUVHOTBVVnU1MGI5cEtYOGVwcXd0aTU4aXVHWmtKQkRiT0x5RE5nRXFZ?=
 =?utf-8?B?MldQWWFqY1hzVlpqczRqcWdGVTlLZVQybFRreElDWHJmVkdpVUJsSkF5eDRZ?=
 =?utf-8?B?UWdaU1lCN0dtcnZkOEt0ZkJuMXByYWJwNk5tVlM5N2srYkZUNWJHaTVoZGxE?=
 =?utf-8?B?SS9MZXc1TGk2UWFzaENGRmh1dXhYaWcvY0o2dXhQK0ZKbVkzclZWTDF5N014?=
 =?utf-8?B?Q1NxdnM4cXFERCtXVWszaGlLODB4dCtCNVYwd3NEUm9hOUNhYlNReE0wTUVU?=
 =?utf-8?B?TUNudjBUdGVZVGFLZ0RRalFzNm4vR0JWOG9nVUVVTDNlK3A4SWFyUjBZQ0tj?=
 =?utf-8?B?cUVReXMxTXFZbTA4cXJtSk5rZGJzSEhJWktCMzBuQ2kyQUk1TkpmVWpsSFRT?=
 =?utf-8?B?Q3dBaXhzQmNRNmdrR0EyM3FTcXpJNFZ5M2llT2RZdWNOTVdCYUpxdG5RQ21J?=
 =?utf-8?B?elZTcFBCcDAvRkJsc0pCTFhSM3NmMFp6SlhKQXYvS01vY0grSERFU2ZtOUtE?=
 =?utf-8?Q?d1zLaYQ4HSFuknfD59BbkSzPx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A803291350A36141BE4301FBB87B7EB4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7867.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03853e36-222c-4b44-bd39-08dc52dce790
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 06:19:51.0986
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNjSacrvt5mzFrIxSoy3yHy7dnC1RxbKDcC+bkf7fsdCwWnyf64qKWmy8ykVoMHyC7odMdAdIpe81q5tLOfwSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8418

SGkgQW5kcmV5LA0KDQpDb3VsZCB5b3UgcGxlYXNlIGhlbHAgcmV2aWV3IHRoaXMgcGF0Y2g/DQoN
Ck9uIFNhdCwgMjAyNC0wMy0zMCBhdCAxODozNiArMDAwMCwgUnVzc2VsbCBLaW5nIChPcmFjbGUp
IHdyb3RlOg0KPiAgT24gRnJpLCBNYXIgMjksIDIwMjQgYXQgMDM6MTc6MzlBTSArMDAwMCwgQm95
IFd1ICjlkLPli4PoqrwpIHdyb3RlOg0KPiA+IEhpIFJ1c3NlbGw6DQo+ID4gDQo+ID4gS2luZ2x5
IHBpbmcNCj4gDQo+IEknbSBhZnJhaWQgSSBrbm93IG5vd3QgYWJvdXQgS0FTQU4uIEl0IHdhcyBh
ZGRlZCB0byBBUk0zMiBieSBvdGhlcnMuDQo+IEkndmUgbm8gaWRlYSB3aGV0aGVyIHRoaXMgaXMg
Y29ycmVjdCBvciBub3QuIENhbiB3ZSBnZXQgc29tZW9uZSB3aG8NCj4ga25vd3MgS0FTQU4gdG8g
cmV2aWV3IHRoaXM/DQo+IA0KPiAtLSANCj4gUk1LJ3MgUGF0Y2ggc3lzdGVtOiBodHRwczovL3d3
dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvDQo+IEZUVFAgaXMgaGVyZSEgODBN
YnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQgY29ubmVjdGl2aXR5IGF0IGxhc3QhDQo=

