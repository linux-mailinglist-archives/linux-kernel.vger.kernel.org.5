Return-Path: <linux-kernel+bounces-102783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFAA87B739
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C587D1C21FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58724946F;
	Thu, 14 Mar 2024 05:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JyqrblSS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XAfI4fnv"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0A6127;
	Thu, 14 Mar 2024 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710393270; cv=fail; b=tIQSKJ+tdLZg6ZoTBwn8UAXuo9uoMS/k92qbfw/Wsvig+Uoh23FBBQrze3DAea7rWnS9NKgtvvBrGJrWVGzPfKmP9s3em2JbnBJL581OxjRL3+OsEwbN3Q/zb3c5OpShDWg/m5wEeQgNAb9EnWxK+kJ/DnnABM4qP+fxd9B68UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710393270; c=relaxed/simple;
	bh=Fx30Mpnk8448w5xHucGgr3cose8YeeD4A1L7jou68hU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BHHH5dKA4ZLiRGDX6Zj3YgMx2BMjSqGY+q9lnJSpS3gdu5/utWUFGQfA/f6bLjfOmKBnd+SAMvIoIHmHyyDauoRSfoTPpvklMVJVpMFFjqU0mnBIbUJ/yqumheMzteeTgqYS9aGVZLFiHTZtoXZljomUg3Sw0jADWgAxPSjkUIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JyqrblSS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XAfI4fnv; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b2ec6e68e1c111eeb8927bc1f75efef4-20240314
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Fx30Mpnk8448w5xHucGgr3cose8YeeD4A1L7jou68hU=;
	b=JyqrblSSz8qXSjfQBNA6HxNqFESoOHLd4VRJnZebQjA1znbpRX4z9QwDDv+AEbx/LUhMLjZEdwabkGRLLHQxyhhbpf/G1t0PwxaN/oAI45isAh8p9UBKyyu0Qc9Ut+xHbSnzE/fCX6A/SXqCLHjOENEGgc2jHWxhyV7IPnXRnYs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:d6cf9987-e70a-4697-87c6-b9fcd2a8f567,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:60136390-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b2ec6e68e1c111eeb8927bc1f75efef4-20240314
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1235738785; Thu, 14 Mar 2024 13:14:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 14 Mar 2024 13:14:12 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 14 Mar 2024 13:14:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSSmD11y6BTmMlJTpx98uWn/1EJYo43F2uAA1a6xf40TaPA8xx6Qw6WUrnhDvqfpvVLon+2uIfXk6FxSKRtJWuwoPyLJ5tbBDtRFfTk7/FTCPgV4aDbOHDbbTbD13P7ULweSADPqRpVJvHAjysxYpiDCm/+7+W3MCkYAfFpxOW5KsU+WObrS8tEf0aO7zpxA9mgr2v5+okQQfxGRe/Pxlnw+W3O3NfmNtpL70bi8NV5nLCJrx2qjs50J1rxZYvCI3GxFSRdEh5kM63vl/9zETC+hc875H6rhm720v3TlNzguLx9l/RWoQvQoedjTsxlpnSsp5Qui8XrZXORI6q+qEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx30Mpnk8448w5xHucGgr3cose8YeeD4A1L7jou68hU=;
 b=MJuBbn/QT/adezn/LT+C4nFkF3Zg6YJt6yH7v+8bZ4xyY88YMxPd2cLOlgmNy57sh+4RzDael86WGFsy240eOpOSBjtkHJoKUZ7MmD/Cefz8BN5fkIhdw/kN1Bo800CCeurqqE4Plyzhl6J/ARzHgM/3GVloZHVf8aTVugjuuRai4Nm6r9nDb80A1st+DghOgx1ovc9ftdXA15p1KEArxa0J7uBG5by+MqlpDSOFfePA875aSSiEhZqRo1pGKGHUDND0WR3DnQj7YlG/J/51f2jE3+0fPNmk8oiP8rBVNphW9iMh1nfrFeiBWZzt+/Rdvblx1I2QSiMmP1gStzu/Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fx30Mpnk8448w5xHucGgr3cose8YeeD4A1L7jou68hU=;
 b=XAfI4fnvZB5IBb1p+TIXcZRBABZThSjql2lEzjk7C25wGLgO1GFzOnwR8B7qQ0OkywKE3SNvetOHiZV5ss2ct75L9jiKdK6NZcbk6bPGc85IDMLbPv++eUZd5OWCUlKOnX6515EEt4lpbyNSAC1XMfKDCKHUU6Cp1TgyRrgz4Vg=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB6466.apcprd03.prod.outlook.com (2603:1096:101:4a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 05:14:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::f3b6:91a7:e0fb:cb27%7]) with mapi id 15.20.7362.031; Thu, 14 Mar 2024
 05:14:05 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"christian.koenig@amd.com" <christian.koenig@amd.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>,
	"shawn.sung@mediatek.corp-partner.google.com"
	<shawn.sung@mediatek.corp-partner.google.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH 02/11] drm/mediatek: Rename "mtk_drm_ddp_comp" to
 "mtk_ddp_comp"
Thread-Topic: [PATCH 02/11] drm/mediatek: Rename "mtk_drm_ddp_comp" to
 "mtk_ddp_comp"
Thread-Index: AQHaaJFA7aboyCEzyEuzAkWU8wk2s7E2y7uA
Date: Thu, 14 Mar 2024 05:14:05 +0000
Message-ID: <8139deaaaa15ce35e453ca5936abd710f0756fc2.camel@mediatek.com>
References: <20240226085059.26850-1-shawn.sung@mediatek.com>
	 <20240226085059.26850-3-shawn.sung@mediatek.com>
In-Reply-To: <20240226085059.26850-3-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB6466:EE_
x-ms-office365-filtering-correlation-id: 7fa5c3a3-3373-47a3-7f58-08dc43e5922b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6bVGZUFkwzE8zWc8gpSy+WpOMrbJCOPn4Ok4z0GYfXCB6MMveU5cwyodIaVcIHHDTBD9kshP975Gxxt4IAMrh6TRS0AZ+wsXPM+XGyyKMqofk5YP+MWX9/T4NBX283Yq4J33HWL5MizQcZHZ0aojnODcTD6Uqt2YL5ydgA/v4oNSWfOH9BW46Wz3kJBnc+HXc+8xx+jyjo+xP/L623/VRIPCTA2g0dIFRcU4ASI3YNjPAEn4oft5LAIMx2fI17JZbgMKj4AX2F+nKaLMeTzv/147E0zrM1VORz7nd33Bsx1QRb4JTEuwED1wWHmOA1lvBV5AXx/r+wwLCg3UAzhjl69agNWq9672lCcSPgk8c2VTqG8Z2c6NSi4gh02NCFaZQ9ZqWHjalSpuQX/eO8oaGZzcJyD/ccNbZj6mKc3K1Xjj4iSIHJtrqnVUCPBEnhKG3NjwVTeoWWfNSvBgNxG74oq5PgAPtM22Aa/E1ZsBGz6l58rpO1RdGY9piLXaTil/mV40xcdfOcM/FVNz2hsusMGeEIceIlbIh3V2osO/pzv8+0sWXzm7J1SyelE3V4jLtU9PtZoy7swqbiy7j4rLozlUGJIt5fZftTGijUwUgMafALi8/z0Fz12vn6vcY0bbdZobw20y6y20v9xpWWv3Tkb6+sfzVKeta7wVURswdHEYuTI6xxha7CF1AVsvHdaTJXEe0rACopeozbX1Rxd9BD3tBBUliqFnQk3ZEQTZU3s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUNmV2g1cWx0YXVHVFlPaXdpdHlkTFF3TUlBUFlYZytRdDNibWVLb2RaUUpm?=
 =?utf-8?B?eEpPc2wxM2RUdnA4T0hpcXJBeWN4TGJBamtjTXE1N2ZYRUdlQ2doSjZ0SW5s?=
 =?utf-8?B?aWJKQk9LaG1rUnR3Rkc4dWNHWWtTTXVtMXlXb1Evak5qMmJPY0puUTlUV01K?=
 =?utf-8?B?V214aWluZkNib2J5ZkMzRDUvbVZMRFZyM2kxYjdhYzN0Y2R5Z3RaNlMzc3Rj?=
 =?utf-8?B?cXUxQllTN0lEclBpNDJTRlBZYkgrNDVGQWhjaCs4RU1zSWtmaFZIMVJPZnhl?=
 =?utf-8?B?aTJsaXZJeWZyRk1wdVN4dW5wQ0I5N3pBeEhGNU82Q3dMaHp4ODNWN0dKaitX?=
 =?utf-8?B?WVNaMHF2OFJHWVhxZlNlTEVvMWs1MXNybFJBRVNGS1dtR3NwRThVNk1WcDFj?=
 =?utf-8?B?TVVMY3Arb1pWaUVnakQ1dXNabitqOTUrOTFLNEJES0c2dDZnNzUvWXBZUG1J?=
 =?utf-8?B?TEp4S3Q1ZjM2ZlU3emxWUDg5SVVxRG1FdXJRdzQrWlFpN2lvVmI2TWFxMVJr?=
 =?utf-8?B?ZzRGelBSZ3k4ZXNDRExWL2JEaEVpaFJCMmZFS1NVVHFhL3N0MitzRXEzcUEy?=
 =?utf-8?B?VU9OdVkwL2NWMFA3NHJVSEd6V2tzOE5vWFNURld3SEt3aVp4U1Q3SDRnYXFQ?=
 =?utf-8?B?R3JDME8xKzlXc1VGSVJLRVoyWFlLQUNIWmhuQUtoUHlQbGd1blk3ZnRadk8y?=
 =?utf-8?B?SFhZZjVIdGtBVG9QaVVDbnZRSkk1N2V6VVhKTWJySUZTY3pCTlRWd2g2SDdL?=
 =?utf-8?B?Sk1DSVEvMUVzQW5vV05QbDZ5aGV5Z2NNcUlDelY3MXd3R25WVjY1Tm9TQlhl?=
 =?utf-8?B?WlAxL290bVVjUmhwY0F2T3g5LzNqR2pZblllQ3ZoTHJ2TGtYYzIzWWxXaUNx?=
 =?utf-8?B?U3VtekN3WUxQMFhxU0N0ZExOdmQyTmt4NENFT2h2eUl5SUJjM3BYOThvWC9W?=
 =?utf-8?B?cGRQdExDS3ordTBJeFdlZGJKRURNVzZxUUswUWJVelpQZW4wR3JRNTR1a1BE?=
 =?utf-8?B?VHpRc3EvMndKL1d6YTA0UEh1emVvMUtTZnRNU3BmR0tjMmM4WEM5K2JHc0pK?=
 =?utf-8?B?SmdPTTMyMi9wUC9udEg3RUgxRHpyV3VMbHJob1QzMnNQTlhCRUl4K2ZIbnBG?=
 =?utf-8?B?OEo3ZWl4RkdjNTYweFdZRlF6V1FvOG5DNjRuQ3NxR1dWczFDUitXejVLMzZN?=
 =?utf-8?B?M0tnV05GZkVCd0loamEwakdrUDNETjUzc2cvandqc3BTMGx5RUp3MGl2MW5Q?=
 =?utf-8?B?dXZiV0VlWTk2bEx5RDlCRkVQQU9TKzdlaHhNZDFWZ3Q2cEh4Nld3L2xYNjZB?=
 =?utf-8?B?Qi9IeXpnWXRXbU5TOGx3TzFIZ2R5WDFUN0VQY0pKT2MxYWdLZjNTVnFHOFVT?=
 =?utf-8?B?V0FGUWdpMWo4bFhOcGNFbjBlb2Mzb1NLeUJBWlhDVGVXK3F2UW5UV0o0SE5H?=
 =?utf-8?B?YnVDK21JTlJSdkVNNDJ2Tmlhcm1VTWd5QUhJME9kNGIxUGNIbWhSQzdDNGVM?=
 =?utf-8?B?MVlRVXVTVHdBRU5TTzRqY2ltbnlpb3dPSEJaZmh3aFFxMnZFWmFtdGUyT21q?=
 =?utf-8?B?cXNKWkFmOWNLVko1QnFZQmV6NFR4WDNObVltUjlvdHUza2x2d0M4c0pGV0Vw?=
 =?utf-8?B?ZGgzNWhsR0Ywc2o2MnlsWlVSc2Q5TGJrMWl2T0pTV04yM3dEcjhhOHlIYkUv?=
 =?utf-8?B?OGp6U3lYUUJoT1VMYmZDYjVTc0pJeFVRZTdySy9TR09zL2p4NU1JZ2R5Njls?=
 =?utf-8?B?RG84NDhvcUd3T1RtOHVHZ296M2dYRnlYN2NFTExWWEJNajNRZlJRNDI5VGZn?=
 =?utf-8?B?ZllKWXUwNFNtSk9sT0tneVIyU3d6ajl3Sy9kdHQ4VlE5RlJRa01KU1JEczZ4?=
 =?utf-8?B?czlQMlpJc0MrMHBlMnNZT0s3bURoVThoRW9POWU0TXpvMkg1VW5QaG9PZ1lQ?=
 =?utf-8?B?SlZ2SWNocGlhbWRkMmI2SS8xZmJBNU5GbWFEZkxaT2w2T2ZsdDA1RDdXWUpa?=
 =?utf-8?B?ajlvbzZ4ZktyeWJyTVVrRGFaRDZJRmJpS0JybkxMeFd6LzBxejdRbWV3VTFz?=
 =?utf-8?B?SmJpQUh2S1BRMHkzNEdNTFRFUTZ6UG1uV3ZEU2NJZjZGa2MyTHdhSHJFVUJK?=
 =?utf-8?Q?sK46hOYdxkq5FGZIih4Nr0oQq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <346064C42AE69E4C87E536CFF77CB17B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fa5c3a3-3373-47a3-7f58-08dc43e5922b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 05:14:05.8543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSKQtm0pa4m/jDA5Q9vZQDIH/eUwVLSueJGaIF6yGadYAI4X6E5n3JjC5sDwQ6X4bT117jxAYsWrrXLkpVS3kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6466

SGksIFNoYXduOg0KDQpPbiBNb24sIDIwMjQtMDItMjYgYXQgMTY6NTAgKzA4MDAsIFNoYXduIFN1
bmcgd3JvdGU6DQo+IEZyb206IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBSZW5hbWUgYWxsICJtdGtfZHJtX2RkcF9j
b21wIiB0byAibXRrX2RkcF9jb21wIjoNCj4gLSBUbyBhbGlnbiB0aGUgbmFtaW5nIHJ1bGUNCj4g
LSBUbyByZWR1Y2UgdGhlIGNvZGUgc2l6ZQ0KDQpSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1l
ZGlhdGVrLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSHNpYW8gQ2hpZW4gU3VuZyA8DQo+
IHNoYXduLnN1bmdAbWVkaWF0ZWsuY29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IC0tLQ0KPiAg
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jICAgICB8IDE2ICsrKysrKyst
LS0tLS0tLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgg
fCAgNiArKystLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5j
DQo+IGluZGV4IGZlOTY1YWQ3ZDI4Mi4uZDhiNTkxYWZmM2MyIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IEBAIC0yNzYsOSArMjc2LDkgQEAgc3RhdGlj
IHZvaWQgbXRrX2NydGNfZGRwX2Nsa19kaXNhYmxlKHN0cnVjdA0KPiBtdGtfY3J0YyAqbXRrX2Ny
dGMpDQo+ICB9DQo+ICANCj4gIHN0YXRpYw0KPiAtc3RydWN0IG10a19kZHBfY29tcCAqbXRrX2Ry
bV9kZHBfY29tcF9mb3JfcGxhbmUoc3RydWN0IGRybV9jcnRjDQo+ICpjcnRjLA0KPiAtCQkJCQkJ
c3RydWN0IGRybV9wbGFuZQ0KPiAqcGxhbmUsDQo+IC0JCQkJCQl1bnNpZ25lZCBpbnQNCj4gKmxv
Y2FsX2xheWVyKQ0KPiArc3RydWN0IG10a19kZHBfY29tcCAqbXRrX2RkcF9jb21wX2Zvcl9wbGFu
ZShzdHJ1Y3QgZHJtX2NydGMgKmNydGMsDQo+ICsJCQkJCSAgICBzdHJ1Y3QgZHJtX3BsYW5lICpw
bGFuZSwNCj4gKwkJCQkJICAgIHVuc2lnbmVkIGludCAqbG9jYWxfbGF5ZXIpDQo+ICB7DQo+ICAJ
c3RydWN0IG10a19jcnRjICptdGtfY3J0YyA9IHRvX210a19jcnRjKGNydGMpOw0KPiAgCXN0cnVj
dCBtdGtfZGRwX2NvbXAgKmNvbXA7DQo+IEBAIC00MjgsNyArNDI4LDcgQEAgc3RhdGljIGludCBt
dGtfY3J0Y19kZHBfaHdfaW5pdChzdHJ1Y3QgbXRrX2NydGMNCj4gKm10a19jcnRjKQ0KPiAgDQo+
ICAJCS8qIHNob3VsZCBub3QgZW5hYmxlIGxheWVyIGJlZm9yZSBjcnRjIGVuYWJsZWQgKi8NCj4g
IAkJcGxhbmVfc3RhdGUtPnBlbmRpbmcuZW5hYmxlID0gZmFsc2U7DQo+IC0JCWNvbXAgPSBtdGtf
ZHJtX2RkcF9jb21wX2Zvcl9wbGFuZShjcnRjLCBwbGFuZSwNCj4gJmxvY2FsX2xheWVyKTsNCj4g
KwkJY29tcCA9IG10a19kZHBfY29tcF9mb3JfcGxhbmUoY3J0YywgcGxhbmUsDQo+ICZsb2NhbF9s
YXllcik7DQo+ICAJCWlmIChjb21wKQ0KPiAgCQkJbXRrX2RkcF9jb21wX2xheWVyX2NvbmZpZyhj
b21wLCBsb2NhbF9sYXllciwNCj4gIAkJCQkJCSAgcGxhbmVfc3RhdGUsIE5VTEwpOw0KPiBAQCAt
NTE5LDggKzUxOSw3IEBAIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9jb25maWcoc3RydWN0IGRy
bV9jcnRjDQo+ICpjcnRjLA0KPiAgCQkJaWYgKCFwbGFuZV9zdGF0ZS0+cGVuZGluZy5jb25maWcp
DQo+ICAJCQkJY29udGludWU7DQo+ICANCj4gLQkJCWNvbXAgPSBtdGtfZHJtX2RkcF9jb21wX2Zv
cl9wbGFuZShjcnRjLCBwbGFuZSwNCj4gLQkJCQkJCQkgICZsb2NhbF9sYXllcikNCj4gOw0KPiAr
CQkJY29tcCA9IG10a19kZHBfY29tcF9mb3JfcGxhbmUoY3J0YywgcGxhbmUsDQo+ICZsb2NhbF9s
YXllcik7DQo+ICANCj4gIAkJCWlmIChjb21wKQ0KPiAgCQkJCW10a19kZHBfY29tcF9sYXllcl9j
b25maWcoY29tcCwNCj4gbG9jYWxfbGF5ZXIsDQo+IEBAIC01NDQsOCArNTQzLDcgQEAgc3RhdGlj
IHZvaWQgbXRrX2NydGNfZGRwX2NvbmZpZyhzdHJ1Y3QgZHJtX2NydGMNCj4gKmNydGMsDQo+ICAJ
CQlpZiAoIXBsYW5lX3N0YXRlLT5wZW5kaW5nLmFzeW5jX2NvbmZpZykNCj4gIAkJCQljb250aW51
ZTsNCj4gIA0KPiAtCQkJY29tcCA9IG10a19kcm1fZGRwX2NvbXBfZm9yX3BsYW5lKGNydGMsIHBs
YW5lLA0KPiAtCQkJCQkJCSAgJmxvY2FsX2xheWVyKQ0KPiA7DQo+ICsJCQljb21wID0gbXRrX2Rk
cF9jb21wX2Zvcl9wbGFuZShjcnRjLCBwbGFuZSwNCj4gJmxvY2FsX2xheWVyKTsNCj4gIA0KPiAg
CQkJaWYgKGNvbXApDQo+ICAJCQkJbXRrX2RkcF9jb21wX2xheWVyX2NvbmZpZyhjb21wLA0KPiBs
b2NhbF9sYXllciwNCj4gQEAgLTcwOSw3ICs3MDcsNyBAQCBpbnQgbXRrX2NydGNfcGxhbmVfY2hl
Y2soc3RydWN0IGRybV9jcnRjICpjcnRjLA0KPiBzdHJ1Y3QgZHJtX3BsYW5lICpwbGFuZSwNCj4g
IAl1bnNpZ25lZCBpbnQgbG9jYWxfbGF5ZXI7DQo+ICAJc3RydWN0IG10a19kZHBfY29tcCAqY29t
cDsNCj4gIA0KPiAtCWNvbXAgPSBtdGtfZHJtX2RkcF9jb21wX2Zvcl9wbGFuZShjcnRjLCBwbGFu
ZSwgJmxvY2FsX2xheWVyKTsNCj4gKwljb21wID0gbXRrX2RkcF9jb21wX2Zvcl9wbGFuZShjcnRj
LCBwbGFuZSwgJmxvY2FsX2xheWVyKTsNCj4gIAlpZiAoY29tcCkNCj4gIAkJcmV0dXJuIG10a19k
ZHBfY29tcF9sYXllcl9jaGVjayhjb21wLCBsb2NhbF9sYXllciwNCj4gc3RhdGUpOw0KPiAgCXJl
dHVybiAwOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZGRwX2NvbXAuaA0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21w
LmgNCj4gaW5kZXggOTNkNzlhMTM2NmU5Li5iYTk4NTIwNmZkZDIgMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmgNCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaA0KPiBAQCAtMyw4ICszLDggQEAN
Cj4gICAqIENvcHlyaWdodCAoYykgMjAxNSBNZWRpYVRlayBJbmMuDQo+ICAgKi8NCj4gIA0KPiAt
I2lmbmRlZiBNVEtfRFJNX0REUF9DT01QX0gNCj4gLSNkZWZpbmUgTVRLX0RSTV9ERFBfQ09NUF9I
DQo+ICsjaWZuZGVmIE1US19ERFBfQ09NUF9IDQo+ICsjZGVmaW5lIE1US19ERFBfQ09NUF9IDQo+
ICANCj4gICNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRp
bWUuaD4NCj4gQEAgLTM0MCw0ICszNDAsNCBAQCB2b2lkIG10a19kZHBfd3JpdGVfcmVsYXhlZChz
dHJ1Y3QgY21kcV9wa3QNCj4gKmNtZHFfcGt0LCB1bnNpZ25lZCBpbnQgdmFsdWUsDQo+ICB2b2lk
IG10a19kZHBfd3JpdGVfbWFzayhzdHJ1Y3QgY21kcV9wa3QgKmNtZHFfcGt0LCB1bnNpZ25lZCBp
bnQNCj4gdmFsdWUsDQo+ICAJCQlzdHJ1Y3QgY21kcV9jbGllbnRfcmVnICpjbWRxX3JlZywgdm9p
ZCBfX2lvbWVtDQo+ICpyZWdzLA0KPiAgCQkJdW5zaWduZWQgaW50IG9mZnNldCwgdW5zaWduZWQg
aW50IG1hc2spOw0KPiAtI2VuZGlmIC8qIE1US19EUk1fRERQX0NPTVBfSCAqLw0KPiArI2VuZGlm
IC8qIE1US19ERFBfQ09NUF9IICovDQo=

