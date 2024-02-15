Return-Path: <linux-kernel+bounces-66366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD356855BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BFC1F275AE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF16DDDC;
	Thu, 15 Feb 2024 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="uDrUPZGA";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="mdbk8U4P"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D4DDDD8
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 07:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707982427; cv=fail; b=SNYtf8IiS8osCG/xEJwA1MaaWEgi3qusZZRn5a8Np3imU6nDRnyKuaAtnlTL646obiLe8TjZpPoY6VWeXF4z4MsZNyGogZ3Bme2wa8lhsl50naL6tlw6wzoSGp6DMoCjWXAo+3r2nkJZ1Kl1S/UjP3pswBHPZPPNLkm3JH8j3Qc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707982427; c=relaxed/simple;
	bh=CA0VZvI7QMwVNl4iRxAZcGwfglZh0xvhGBcMHOh4Wnc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lZ2Eyuu/Nw+hsIhSqMbZr7j8ISOcbI/yDd6raMVF9VK2QJK4qSrV8hF73iqoLHbq8xv6KcETjjSb6LMceCyaQ30s6iBFDXZX0LNKlkusEyOkERwgzF8JqXVIRgesJJkvp/UhRNWNISZN7LeESfZJklt1pSZLxC6msvAFt/UJv6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=uDrUPZGA; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=mdbk8U4P; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 87c69478cbd411eea2298b7352fd921d-20240215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CA0VZvI7QMwVNl4iRxAZcGwfglZh0xvhGBcMHOh4Wnc=;
	b=uDrUPZGAlEBmLGM7L9eCtTXYerNdjitKcMRNWy6D8400S1GkrNOdQ/HIkjoQLAVRiiWt4xD3xXYj1ggLRkUOuK0aEDlUjUPBHfznsOKq+CdnlUgPpnWIVMSNmBNEqJXd3MYpbB8XFSNwTk7IbgiVkue1c8vVLuVtVICIc2D0+3c=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:49641294-831c-40d4-ae0b-4220c3137ff5,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:a4dae983-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 87c69478cbd411eea2298b7352fd921d-20240215
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1737523272; Thu, 15 Feb 2024 15:33:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 15 Feb 2024 15:33:34 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 15 Feb 2024 15:33:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DiwWuGh94ny+7HliUBaeByYgfeepYUDfEJWu6F7FHfaxcpbLm75RrzJsQ2Bn/80FcTgWloqTUS/2WGUoHPiBnfdJTV4spanibPsSG7r+bM1OtTXjhN8XtGtrUxtbCVKH98cwhhcV/ulJSmTcfycThS+hUlG8I6CDghIOuiz8dyCqq5qEns4KzINfEgW7+rncaWVklVGNAoI0w1Zcj+CuRmdengNJdT2WaTDN/+lpuNbOfVcuHuvGu+rh7Bw+WGORfjISmUc1UQcacPtg3Ewwj3riXmbmbv4NJEt6aIKVpD2SyohUFzPDYPFwkSq5EyM/1AZfvvIhMEPevRyjELwp9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CA0VZvI7QMwVNl4iRxAZcGwfglZh0xvhGBcMHOh4Wnc=;
 b=d0zKkgG4O8oH+FVRsXMEg51y3cNaregtNDnFGwKjawSO2Y3oif4SSJiuteZzID8BGnhwD8HMlaOTzLrSCIFzX4kFNQb6nd3qFbLx9kw/1KAUBK5/OaMkFQdmJpUFxiXZpBDlnSrRShXxdop5RgQ+OR8PHGbGf8XRXDP92H0GhptwR4zLchaPO6jGbruQgIiIv1NT4OCJ5KPQo6WxXWy0D1f47FUMwC95YHHqetxPPDEHu04Qvd7ihes/tZFmlXbE5DBBYzXch463Aj1HBFOyxjaRPCMBge+vUQLNIuvVkMuV7hy2vCQWYh9HonK3QghNzFnY3lrWWVXyGhWkqU5Vaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CA0VZvI7QMwVNl4iRxAZcGwfglZh0xvhGBcMHOh4Wnc=;
 b=mdbk8U4Px0hUPAdIPfnmUO/IXRCtyYPuqLUaoeTw8Df8eiR9H9RRkccWxS15dkNzwtZmPlN1kUhultzAE4VO0XnC3wr21BLOTSMvG51u0JwnjbSXL1mm8aA9Jylw91jb+VVyElVuV/6MnVhHz8qUsLtgCMT5xJtWzHxAUJ1DlDk=
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com (2603:1096:101:83::7)
 by TYZPR03MB8750.apcprd03.prod.outlook.com (2603:1096:405:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 07:33:32 +0000
Received: from SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe]) by SEYPR03MB6626.apcprd03.prod.outlook.com
 ([fe80::afa5:be3f:bc79:48fe%3]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 07:33:32 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"amergnat@baylibre.com" <amergnat@baylibre.com>, "airlied@gmail.com"
	<airlied@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 4/9] drm/mediatek: dsi: Use bitfield macros where
 useful
Thread-Topic: [PATCH v5 4/9] drm/mediatek: dsi: Use bitfield macros where
 useful
Thread-Index: AQHaWdV9LA36F8cCR0CUUVok2K8HhrELDuGA
Date: Thu, 15 Feb 2024 07:33:32 +0000
Message-ID: <1d2310c8ebc8be3630ed6386fba7c6fbce9bfb07.camel@mediatek.com>
References: <20240207145307.1626009-1-angelogioacchino.delregno@collabora.com>
	 <20240207145307.1626009-5-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240207145307.1626009-5-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6626:EE_|TYZPR03MB8750:EE_
x-ms-office365-filtering-correlation-id: c692ec11-1231-47cb-e82b-08dc2df869b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4ib4wMaxNWULS+QJQ8HzhNM8mbGRxgUPisApnKzcoKWmx8rcv3cZnTkntm9WhXCd5Pw/CM2O3/pTtTE+Huq+4CVw+Ps8PP+2OKVqKSWythbuwTTDYgOCJ/OgAcPTv8fHWOgBVW4FOJcxO+xyQWYB3mhcquCjoLhbbnVxAZW+USqSptlP1kQEBjcD4lxrxmIwlG/IrOB6pYk5Nr/ZO3JU55YVYj3ctp6SdVX8Mg6aiA4ch5foDj3e3uDlzKwJuBFzowhoszt4RoOXfdPpwHtzqn8V/NIP6qRZ0qgcv3GeEQU+cSg2ERUhT9wMPhXEzaUxJtwOylg3xklSVlSJGSQCzr3JLqdp1soDI2kiqQV23Yxsbirvkxp5FZ+T8SPfK+TLqemd337MYPO6DqCcpnurfNzbuarBkStPoP+MdWgclEWZVC3eFSlPIXAT3w/wQ0/Q6LCXJEOAIMf0LV4b1SIu6jQ+4wZXMQCm/CUUUIeexMRPdIc6eJUChoAN3WNjMaHe06N4Z6l6Ni4eMPe6nwc4auf4OPDJW9cVXjhqolcbapCWpKzglYMSkQ6XxpTJbvNVTOtb7lLjos2O4A+pFN5L3bSsKeJ04uDOx+fyWYqzpUzpqsDZRyGBZKDErVgSDgU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6626.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(478600001)(6512007)(41300700001)(2616005)(8936002)(2906002)(4326008)(5660300002)(7416002)(8676002)(66446008)(76116006)(66556008)(66946007)(64756008)(66476007)(110136005)(6506007)(316002)(6486002)(54906003)(26005)(38070700009)(83380400001)(85182001)(36756003)(38100700002)(86362001)(71200400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mitzd2NmeU9YVzVUMXRrczBibm9Rd1BlSFNnNVo2aG80YUw1M2lmSnFlcUx2?=
 =?utf-8?B?Wmh3S215SkpId3hhVTFUOGl6d3NiNkhMNmQ2TEY5QmcxVm1URXlDUkgrc2Yv?=
 =?utf-8?B?WGtaeDVCOXlLRnZWYis4YnFjemVYOW5lbjFNTEZIMFk1cC9zWHJhRGJtTGtp?=
 =?utf-8?B?K1VnVkY3empjZ0QvVmdiQ0dIL25YTW1GVUdPbWM4VkpjQU56Skd0YnN2TEJw?=
 =?utf-8?B?M2F2Y1NZMU1rTlFTM0o0RENhbFJUL0tSeG9uZGtGdVVvbEliZmErVy94NEhB?=
 =?utf-8?B?bXhsQ1BISHJFUzRZNVFOYUFxeitUTVpablhyQjNrdEE5VEg2akFROHFvVTNF?=
 =?utf-8?B?YzYwbjBVUWdJQnNHYVdVc01HNXhCVXhvVW5WbWl3YkxPdzVySkEyNHpadkZw?=
 =?utf-8?B?ejFoWUY4MEwvTmVJZC8rQW5uU09uVDFWek9zNWVYM0xFaDEyQnBEbWpGK2VX?=
 =?utf-8?B?SDQ3d3BNYS9nSlVIOGhTdVhyTkpQZHZMZ1JmV2JsSEtQYWM4VXhZSDR3VlNn?=
 =?utf-8?B?ZTRFQS95ZTZ0Z05peXR2aWlLT0xSZXN5dHhvVUhxSHgxVEc2amN0dHRLYUFU?=
 =?utf-8?B?bkdCcTlBZm5udWNTODQ3dEw5VzlZNzN3VzU4MlB0QVRCUTYzbFVlMUJTRjgz?=
 =?utf-8?B?aFRWTmJreTI3L1BTUXhsMXUwaXJiZDVTaWZqWWw3dExabkx3ZXJOUkpnYjBY?=
 =?utf-8?B?K2txNGxOVVc4bWZDUzMvSm1aWmlMK1l1cXFhc21ybys3T0pyNXFCYUxyV295?=
 =?utf-8?B?S21OQVhvRUptZDFWbWxTTDNhc1UwOUcxa05lVDB6SnR5cmZnMkVDajBnNitu?=
 =?utf-8?B?UFZpZnVPVENwMnd5bVY5SHBUU2hKMzJYSnFtZHA1WjBSSFF1S1JWK3VuTFRn?=
 =?utf-8?B?bExMMVR2N2xpb2NnU2ZzM1hlV0N3Y2pOOGp5VVUzOGY0ak5CQkRwZXllV1ox?=
 =?utf-8?B?aFJZZDdqbkkzeEY3RVdBSWVrdWJ3YzU5VENaeGhDWW50RUJtQkFNaWI3bTVF?=
 =?utf-8?B?eW1WOVN2YXMwYkxLZEpDd0EwOWhDV1FXK3ZxK1BtU1pzK2Mxam9HbUlBTEd3?=
 =?utf-8?B?UUF4dXN4ZnhKMEQ4WktRejI0cExGbjlCcHkvWXUwb3pJRER4L2EwZWoyNXA0?=
 =?utf-8?B?WVY4Y2Y5OEJrNDJScUJiUkNITXVaTU1uOWs5TXR6U3d1RkNjNXBFQ0orT1dw?=
 =?utf-8?B?d2FUdTlZRjZGRlcxOFp6dDhrdGxvbW9kVWhkaUoza1piMzRucExsN1RaMkVU?=
 =?utf-8?B?UDVjODdXdGhjUVBpNnR0aUJmQ2lnbUM3Zjg1QVEyOFdxNlFPeHRSWEpWOC9p?=
 =?utf-8?B?Y1huMGJnYklkUlY2M0F6ZytKbURCZW14VTBrZlB6RU90bGZVUG1COU00M2xE?=
 =?utf-8?B?bnhyeW1nOTQyb01rUk5HTmJBVE0xNjYzYllBUTdOcXp4OWlwL25BZzdseTFa?=
 =?utf-8?B?V0tmc2lOMEdSVUxUaWtkU0dVMFVPY0F6YVh2RlV1cHMxRCtJNmVhbjlYQTNF?=
 =?utf-8?B?MVFZRFE5U2ErZFVZV0NmOHUrNWIvaS96QXNTTlEyQWpxK3YrZlRyNGsrUkVy?=
 =?utf-8?B?TWNTckp3bEdGMjJONFlBbWhpMzd0RUVyRHI3WWdEMWRnTFlpY1BrQjVFdnA5?=
 =?utf-8?B?enJaSDRqdWFpSzErTGQvaTdGZ0pXdFluSXM1K1ErMGwxUDE4K3ErNzQ1cnU5?=
 =?utf-8?B?V09jaHZqTUp1QWpmbjVqM1ZZR21FSVR1TUVVSFVzZ1hwWUo3cnpDeFVoZW5V?=
 =?utf-8?B?alJISlNzdXBnUVYyazZsNU54V2RDTWY3T1RZS0xBWVZXdEt1ZXlnclVEQnp4?=
 =?utf-8?B?Y1RPZlJQUFVqelU0TnpaUDBMRFVSNjNMUW1pekp5Q0d0dGNENGlmWWN1SlpK?=
 =?utf-8?B?TXNMdjVNekNoWlIvVi9uc0tqcXd5SlBhK2F6OC9yeVdxVzdKTlY2TVgrMkJT?=
 =?utf-8?B?QzNYVlBuMVhEZmRHb2dZNHdra1hpZmozY3BVdGp4ZEJSbjBibGs2ZkVJY29O?=
 =?utf-8?B?MFdCdVZIeGJyMWgra2puWUlYZFY3QVBMSTVSejJaK2laUEEzcGtKbkZaSjFB?=
 =?utf-8?B?alhOSlNSV1ZnRFFTUTZlc2FCdldidlkvVzZXYkM5b3IvcTFGSW5YWXRhYmF4?=
 =?utf-8?Q?35hbgxYdpBeOqU9RRqrEGZNSV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <19B5B2E197F78845A28F42B62CD51E25@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6626.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c692ec11-1231-47cb-e82b-08dc2df869b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 07:33:32.8081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ics5LU1RGlmKKPYGgdQggWtQoe6IL9LAwxo5BRymfGsfMmrhLCjHmd3Md/yo8EXDDa66AdMpmWeu6xNg4DE3MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8750
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--12.753800-8.000000
X-TMASE-MatchedRID: +f/wAVSGjugNtKv7cnNXnSa1MaKuob8PC/ExpXrHizxHZg0gWH5yUVYW
	wxB9tw0TrZ7ZptepI45h4t35I7152nRWFxHP6CU2vbFZsqMF9Y8YR+gKWoGXzt9zZd3pUn7KvCi
	wwGwIXrU/KV7ZuN2uoTjnKFhCgNQDJS12kaJxXhED2WXLXdz+AbLiLKO9VZOifc8MDDp7ngcwKY
	tIU69m3V39+FkP7Y6zS2SpgjJ1wJeOUv+G6OvDW7MsPmSZxbpkXeyujb7aXgQkt9BigJAcVmdl4
	xOtlYFFMK8A9MZdcS/ivP2ec7HEZSZwgV8Rg7tcbc297PAGtWaCxYB2hPS4vZsoi2XrUn/J+ZL5
	o+vRV7yhMIDkR/KfwI2j49Ftap9EOwBXM346/+xXBOdsYeWWmVwmxlLV4jr04aSvTW2DGZb3fAe
	gp5pFf2yTxzIaFo1L
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.753800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9BF797044B8054EECABB2EDE9ED1BED44B4EF33122D2812E89166B17C34972CF2000:8

SGksIEFuZ2VsbzoNCg0KT24gV2VkLCAyMDI0LTAyLTA3IGF0IDE1OjUzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSW5zdGVhZCBvZiBvcGVuIGNvZGluZyBiaXRz
aGlmdGluZyBmb3IgdmFyaW91cyByZWdpc3RlciBmaWVsZHMsDQo+IHVzZSB0aGUgYml0ZmllbGQg
bWFjcm8gRklFTERfUFJFUCgpOiB0aGlzIGFsbG93cyB0byBlbmhhbmNlIHRoZQ0KPiBodW1hbiBy
ZWFkYWJpbGl0eSwgZGVjcmVhc2UgbGlrZWxpbmVzcyBvZiBtaXN0YWtlcyAoYW5kIHJlZ2lzdGVy
DQo+IGZpZWxkIG92ZXJmbG93aW5nKSBhbmQgYWxzbyB0byBzaW1wbGlmeSB0aGUgY29kZS4NCj4g
VGhlIGxhdHRlciBpcyBlc3BlY2lhbGx5IHNlZW4gaW4gbXRrX2RzaV9yeHR4X2NvbnRyb2woKSwg
d2hlcmUNCj4gaXQgd2FzIHBvc3NpYmxlIHRvIGNoYW5nZSBhIHN3aXRjaCB0byBhIHNob3J0IGZv
ciBsb29wIGFuZCB0bw0KPiBhbHNvIHJlbW92ZSB0aGUgbmVlZCB0byBjaGVjayBmb3IgbWF4aW11
bSBEU0kgbGFuZXMgPT0gNCB0aGFua3MNCj4gdG8gdGhlIEZJRUxEX1BSRVAgbWFjcm8gbWFza2lu
ZyB0aGUgdmFsdWUuDQo+IA0KPiBXaGlsZSBhdCBpdCwgYWxzbyBhZGQgdGhlIG1pc3NpbmcgREFf
SFNfU1lOQyBiaXRtYXNrLCB1c2VkIGluDQo+IG10a19kc2lfcGh5X3RpbWNvbmZpZygpLg0KPiAN
Cj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRyZSBNZXJnbmF0IDxhbWVyZ25hdEBiYXlsaWJyZS5jb20+
DQo+IFNpZ25lZC1vZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxv
Z2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCA5NyArKysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0K
PiAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2ku
Yw0KPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCj4gaW5kZXggN2QzOGU5
NTAwNzAwLi5hMzMwYmI5NGM0NGEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRp
YXRlay9tdGtfZHNpLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2ku
Yw0KPiBAQCAtMyw2ICszLDcgQEANCj4gICAqIENvcHlyaWdodCAoYykgMjAxNSBNZWRpYVRlayBJ
bmMuDQo+ICAgKi8NCj4gIA0KPiArI2luY2x1ZGUgPGxpbnV4L2JpdGZpZWxkLmg+DQo+ICAjaW5j
bHVkZSA8bGludXgvY2xrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY29tcG9uZW50Lmg+DQo+ICAj
aW5jbHVkZSA8bGludXgvaW9wb2xsLmg+DQo+IEBAIC03MCwxNiArNzEsMTkgQEANCj4gICNkZWZp
bmUgRFNJX1BTQ1RSTAkJMHgxYw0KPiAgI2RlZmluZSBEU0lfUFNfV0MJCQlHRU5NQVNLKDEzLCAw
KQ0KPiAgI2RlZmluZSBEU0lfUFNfU0VMCQkJR0VOTUFTSygxNywgMTYpDQo+IC0jZGVmaW5lIFBB
Q0tFRF9QU18xNkJJVF9SR0I1NjUJCSgwIDw8IDE2KQ0KPiAtI2RlZmluZSBQQUNLRURfUFNfMThC
SVRfUkdCNjY2CQkoMSA8PCAxNikNCj4gLSNkZWZpbmUgTE9PU0VMWV9QU18yNEJJVF9SR0I2NjYJ
CSgyIDw8IDE2KQ0KPiAtI2RlZmluZSBQQUNLRURfUFNfMjRCSVRfUkdCODg4CQkoMyA8PCAxNikN
Cj4gKyNkZWZpbmUgUEFDS0VEX1BTXzE2QklUX1JHQjU2NQkJMA0KPiArI2RlZmluZSBQQUNLRURf
UFNfMThCSVRfUkdCNjY2CQkxDQo+ICsjZGVmaW5lIExPT1NFTFlfUFNfMjRCSVRfUkdCNjY2CQky
DQo+ICsjZGVmaW5lIFBBQ0tFRF9QU18yNEJJVF9SR0I4ODgJCTMNCj4gIA0KPiAgI2RlZmluZSBE
U0lfVlNBX05MCQkweDIwDQo+ICAjZGVmaW5lIERTSV9WQlBfTkwJCTB4MjQNCj4gICNkZWZpbmUg
RFNJX1ZGUF9OTAkJMHgyOA0KPiAgI2RlZmluZSBEU0lfVkFDVF9OTAkJMHgyQw0KPiArI2RlZmlu
ZSBWQUNUX05MCQkJCUdFTk1BU0soMTQsIDApDQo+ICAjZGVmaW5lIERTSV9TSVpFX0NPTgkJMHgz
OA0KPiArI2RlZmluZSBEU0lfSEVJR0hUCQkJCUdFTk1BU0soMzAsIDE2KQ0KPiArI2RlZmluZSBE
U0lfV0lEVEgJCQkJR0VOTUFTSygxNCwgMCkNCj4gICNkZWZpbmUgRFNJX0hTQV9XQwkJMHg1MA0K
PiAgI2RlZmluZSBEU0lfSEJQX1dDCQkweDU0DQo+ICAjZGVmaW5lIERTSV9IRlBfV0MJCTB4NTgN
Cj4gQEAgLTEyMiw2ICsxMjYsNyBAQA0KPiAgDQo+ICAjZGVmaW5lIERTSV9QSFlfVElNRUNPTjIJ
MHgxMTgNCj4gICNkZWZpbmUgQ09OVF9ERVQJCQlHRU5NQVNLKDcsIDApDQo+ICsjZGVmaW5lIERB
X0hTX1NZTkMJCQlHRU5NQVNLKDE1LCA4KQ0KPiAgI2RlZmluZSBDTEtfWkVSTwkJCUdFTk1BU0so
MjMsIDE2KQ0KPiAgI2RlZmluZSBDTEtfVFJBSUwJCQlHRU5NQVNLKDMxLCAyNCkNCj4gIA0KPiBA
QCAtMjUzLDE0ICsyNTgsMjMgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV9waHlfdGltY29uZmlnKHN0
cnVjdA0KPiBtdGtfZHNpICpkc2kpDQo+ICAJdGltaW5nLT5jbGtfaHNfemVybyA9IHRpbWluZy0+
Y2xrX2hzX3RyYWlsICogNDsNCj4gIAl0aW1pbmctPmNsa19oc19leGl0ID0gMiAqIHRpbWluZy0+
Y2xrX2hzX3RyYWlsOw0KPiAgDQo+IC0JdGltY29uMCA9IHRpbWluZy0+bHB4IHwgdGltaW5nLT5k
YV9oc19wcmVwYXJlIDw8IDggfA0KPiAtCQkgIHRpbWluZy0+ZGFfaHNfemVybyA8PCAxNiB8IHRp
bWluZy0+ZGFfaHNfdHJhaWwgPDwgMjQ7DQo+IC0JdGltY29uMSA9IHRpbWluZy0+dGFfZ28gfCB0
aW1pbmctPnRhX3N1cmUgPDwgOCB8DQo+IC0JCSAgdGltaW5nLT50YV9nZXQgPDwgMTYgfCB0aW1p
bmctPmRhX2hzX2V4aXQgPDwgMjQ7DQo+IC0JdGltY29uMiA9IDEgPDwgOCB8IHRpbWluZy0+Y2xr
X2hzX3plcm8gPDwgMTYgfA0KPiAtCQkgIHRpbWluZy0+Y2xrX2hzX3RyYWlsIDw8IDI0Ow0KPiAt
CXRpbWNvbjMgPSB0aW1pbmctPmNsa19oc19wcmVwYXJlIHwgdGltaW5nLT5jbGtfaHNfcG9zdCA8
PCA4IHwNCj4gLQkJICB0aW1pbmctPmNsa19oc19leGl0IDw8IDE2Ow0KPiArCXRpbWNvbjAgPSBG
SUVMRF9QUkVQKExQWCwgdGltaW5nLT5scHgpIHwNCj4gKwkJICBGSUVMRF9QUkVQKEhTX1BSRVAs
IHRpbWluZy0+ZGFfaHNfcHJlcGFyZSkgfA0KPiArCQkgIEZJRUxEX1BSRVAoSFNfWkVSTywgdGlt
aW5nLT5kYV9oc196ZXJvKSB8DQo+ICsJCSAgRklFTERfUFJFUChIU19UUkFJTCwgdGltaW5nLT5k
YV9oc190cmFpbCk7DQo+ICsNCj4gKwl0aW1jb24xID0gRklFTERfUFJFUChUQV9HTywgdGltaW5n
LT50YV9nbykgfA0KPiArCQkgIEZJRUxEX1BSRVAoVEFfU1VSRSwgdGltaW5nLT50YV9zdXJlKSB8
DQo+ICsJCSAgRklFTERfUFJFUChUQV9HRVQsIHRpbWluZy0+dGFfZ2V0KSB8DQo+ICsJCSAgRklF
TERfUFJFUChEQV9IU19FWElULCB0aW1pbmctPmRhX2hzX2V4aXQpOw0KPiArDQo+ICsJdGltY29u
MiA9IEZJRUxEX1BSRVAoREFfSFNfU1lOQywgMSkgfA0KPiArCQkgIEZJRUxEX1BSRVAoQ0xLX1pF
Uk8sIHRpbWluZy0+Y2xrX2hzX3plcm8pIHwNCj4gKwkJICBGSUVMRF9QUkVQKENMS19UUkFJTCwg
dGltaW5nLT5jbGtfaHNfdHJhaWwpOw0KPiArDQo+ICsJdGltY29uMyA9IEZJRUxEX1BSRVAoQ0xL
X0hTX1BSRVAsIHRpbWluZy0+Y2xrX2hzX3ByZXBhcmUpIHwNCj4gKwkJICBGSUVMRF9QUkVQKENM
S19IU19QT1NULCB0aW1pbmctPmNsa19oc19wb3N0KSB8DQo+ICsJCSAgRklFTERfUFJFUChDTEtf
SFNfRVhJVCwgdGltaW5nLT5jbGtfaHNfZXhpdCk7DQo+ICANCj4gIAl3cml0ZWwodGltY29uMCwg
ZHNpLT5yZWdzICsgRFNJX1BIWV9USU1FQ09OMCk7DQo+ICAJd3JpdGVsKHRpbWNvbjEsIGRzaS0+
cmVncyArIERTSV9QSFlfVElNRUNPTjEpOw0KPiBAQCAtMzUzLDY5ICszNjcsNjEgQEAgc3RhdGlj
IHZvaWQgbXRrX2RzaV9zZXRfdm1fY21kKHN0cnVjdCBtdGtfZHNpDQo+ICpkc2kpDQo+ICANCj4g
IHN0YXRpYyB2b2lkIG10a19kc2lfcnh0eF9jb250cm9sKHN0cnVjdCBtdGtfZHNpICpkc2kpDQo+
ICB7DQo+IC0JdTMyIHRtcF9yZWc7DQo+ICsJdTMyIHJlZ3ZhbCwgdG1wX3JlZyA9IDA7DQo+ICsJ
dTggaTsNCj4gIA0KPiAtCXN3aXRjaCAoZHNpLT5sYW5lcykgew0KPiAtCWNhc2UgMToNCj4gLQkJ
dG1wX3JlZyA9IDEgPDwgMjsNCj4gLQkJYnJlYWs7DQo+IC0JY2FzZSAyOg0KPiAtCQl0bXBfcmVn
ID0gMyA8PCAyOw0KPiAtCQlicmVhazsNCj4gLQljYXNlIDM6DQo+IC0JCXRtcF9yZWcgPSA3IDw8
IDI7DQo+IC0JCWJyZWFrOw0KPiAtCWNhc2UgNDoNCj4gLQkJdG1wX3JlZyA9IDB4ZiA8PCAyOw0K
PiAtCQlicmVhazsNCj4gLQlkZWZhdWx0Og0KPiAtCQl0bXBfcmVnID0gMHhmIDw8IDI7DQo+IC0J
CWJyZWFrOw0KPiAtCX0NCj4gKwkvKiBOdW1iZXIgb2YgRFNJIGxhbmVzIChtYXggNCBsYW5lcyks
IGVhY2ggYml0IGVuYWJsZXMgb25lIERTSQ0KPiBsYW5lLiAqLw0KPiArCWZvciAoaSA9IDA7IGkg
PCBkc2ktPmxhbmVzOyBpKyspDQo+ICsJCXRtcF9yZWcgfD0gQklUKGkpOw0KPiArDQo+ICsJcmVn
dmFsID0gRklFTERfUFJFUChMQU5FX05VTSwgdG1wX3JlZyk7DQo+ICANCj4gIAlpZiAoZHNpLT5t
b2RlX2ZsYWdzICYgTUlQSV9EU0lfQ0xPQ0tfTk9OX0NPTlRJTlVPVVMpDQo+IC0JCXRtcF9yZWcg
fD0gSFNUWF9DS0xQX0VOOw0KPiArCQlyZWd2YWwgfD0gSFNUWF9DS0xQX0VOOw0KPiAgDQo+ICAJ
aWYgKGRzaS0+bW9kZV9mbGFncyAmIE1JUElfRFNJX01PREVfTk9fRU9UX1BBQ0tFVCkNCj4gLQkJ
dG1wX3JlZyB8PSBESVNfRU9UOw0KPiArCQlyZWd2YWwgfD0gRElTX0VPVDsNCj4gIA0KPiAtCXdy
aXRlbCh0bXBfcmVnLCBkc2ktPnJlZ3MgKyBEU0lfVFhSWF9DVFJMKTsNCj4gKwl3cml0ZWwocmVn
dmFsLCBkc2ktPnJlZ3MgKyBEU0lfVFhSWF9DVFJMKTsNCj4gIH0NCj4gIA0KPiAgc3RhdGljIHZv
aWQgbXRrX2RzaV9wc19jb250cm9sKHN0cnVjdCBtdGtfZHNpICpkc2ksIGJvb2wNCj4gY29uZmln
X3ZhY3QpDQo+ICB7DQo+IC0Jc3RydWN0IHZpZGVvbW9kZSAqdm0gPSAmZHNpLT52bTsNCj4gLQl1
MzIgZHNpX2J1Zl9icHAsIHBzX3djOw0KPiAtCXUzMiBwc19icHBfbW9kZTsNCj4gKwl1MzIgZHNp
X2J1Zl9icHAsIHBzX3ZhbCwgcHNfd2MsIHZhY3Rfbmw7DQo+ICANCj4gIAlpZiAoZHNpLT5mb3Jt
YXQgPT0gTUlQSV9EU0lfRk1UX1JHQjU2NSkNCj4gIAkJZHNpX2J1Zl9icHAgPSAyOw0KPiAgCWVs
c2UNCj4gIAkJZHNpX2J1Zl9icHAgPSAzOw0KPiAgDQo+IC0JcHNfd2MgPSB2bS0+aGFjdGl2ZSAq
IGRzaV9idWZfYnBwOw0KPiAtCXBzX2JwcF9tb2RlID0gcHNfd2M7DQo+ICsJLyogV29yZCBjb3Vu
dCAqLw0KPiArCXBzX3djID0gRklFTERfUFJFUChEU0lfUFNfV0MsIGRzaS0+dm0uaGFjdGl2ZSAq
IGRzaV9idWZfYnBwKTsNCj4gKwlwc192YWwgPSBwc193YzsNCj4gIA0KPiArCS8qIFBpeGVsIFN0
cmVhbSB0eXBlICovDQo+ICAJc3dpdGNoIChkc2ktPmZvcm1hdCkgew0KPiArCWRlZmF1bHQ6DQo+
ICsJCWZhbGx0aHJvdWdoOw0KDQpUaGlzIGlzIG5vdCByZWxhdGVkIHRvIGJpdGZpZWxkIG1hY3Jv
LiBZb3UgcmVtb3ZlIGRlZmF1bHQgaW4gcHJldmlvdXMNCnBhdGNoIGJ1dCBhZGQgaXQgYmFjayBp
biB0aGlzIHBhdGNoLiBJIHRoaW5rIHRoaXMgc2hvdWxkIGJlIG1vdmVkIHRvDQpwcmV2aW91cyBw
YXRjaC4gQWZ0ZXIgdGhpcyBjaGFuZ2UsDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVk
aWF0ZWsuY29tPg0KDQo+ICAJY2FzZSBNSVBJX0RTSV9GTVRfUkdCODg4Og0KPiAtCQlwc19icHBf
bW9kZSB8PSBQQUNLRURfUFNfMjRCSVRfUkdCODg4Ow0KPiArCQlwc192YWwgfD0gRklFTERfUFJF
UChEU0lfUFNfU0VMLA0KPiBQQUNLRURfUFNfMjRCSVRfUkdCODg4KTsNCj4gIAkJYnJlYWs7DQo+
ICAJY2FzZSBNSVBJX0RTSV9GTVRfUkdCNjY2Og0KPiAtCQlwc19icHBfbW9kZSB8PSBMT09TRUxZ
X1BTXzI0QklUX1JHQjY2NjsNCj4gKwkJcHNfdmFsIHw9IEZJRUxEX1BSRVAoRFNJX1BTX1NFTCwN
Cj4gTE9PU0VMWV9QU18yNEJJVF9SR0I2NjYpOw0KPiAgCQlicmVhazsNCj4gIAljYXNlIE1JUElf
RFNJX0ZNVF9SR0I2NjZfUEFDS0VEOg0KPiAtCQlwc19icHBfbW9kZSB8PSBQQUNLRURfUFNfMThC
SVRfUkdCNjY2Ow0KPiArCQlwc192YWwgfD0gRklFTERfUFJFUChEU0lfUFNfU0VMLA0KPiBQQUNL
RURfUFNfMThCSVRfUkdCNjY2KTsNCj4gIAkJYnJlYWs7DQo+ICAJY2FzZSBNSVBJX0RTSV9GTVRf
UkdCNTY1Og0KPiAtCQlwc19icHBfbW9kZSB8PSBQQUNLRURfUFNfMTZCSVRfUkdCNTY1Ow0KPiAr
CQlwc192YWwgfD0gRklFTERfUFJFUChEU0lfUFNfU0VMLA0KPiBQQUNLRURfUFNfMTZCSVRfUkdC
NTY1KTsNCj4gIAkJYnJlYWs7DQo+ICAJfQ0KPiAgDQo+ICAJaWYgKGNvbmZpZ192YWN0KSB7DQo+
IC0JCXdyaXRlbCh2bS0+dmFjdGl2ZSwgZHNpLT5yZWdzICsgRFNJX1ZBQ1RfTkwpOw0KPiArCQl2
YWN0X25sID0gRklFTERfUFJFUChWQUNUX05MLCBkc2ktPnZtLnZhY3RpdmUpOw0KPiArCQl3cml0
ZWwodmFjdF9ubCwgZHNpLT5yZWdzICsgRFNJX1ZBQ1RfTkwpOw0KPiAgCQl3cml0ZWwocHNfd2Ms
IGRzaS0+cmVncyArIERTSV9IU1RYX0NLTF9XQyk7DQo+ICAJfQ0KPiAtCXdyaXRlbChwc19icHBf
bW9kZSwgZHNpLT5yZWdzICsgRFNJX1BTQ1RSTCk7DQo+ICsJd3JpdGVsKHBzX3ZhbCwgZHNpLT5y
ZWdzICsgRFNJX1BTQ1RSTCk7DQo+ICB9DQo+ICANCj4gIHN0YXRpYyB2b2lkIG10a19kc2lfY29u
ZmlnX3Zkb190aW1pbmcoc3RydWN0IG10a19kc2kgKmRzaSkNCj4gQEAgLTQ0Miw3ICs0NDgsOCBA
QCBzdGF0aWMgdm9pZCBtdGtfZHNpX2NvbmZpZ192ZG9fdGltaW5nKHN0cnVjdA0KPiBtdGtfZHNp
ICpkc2kpDQo+ICAJd3JpdGVsKHZtLT52YWN0aXZlLCBkc2ktPnJlZ3MgKyBEU0lfVkFDVF9OTCk7
DQo+ICANCj4gIAlpZiAoZHNpLT5kcml2ZXJfZGF0YS0+aGFzX3NpemVfY3RsKQ0KPiAtCQl3cml0
ZWwodm0tPnZhY3RpdmUgPDwgMTYgfCB2bS0+aGFjdGl2ZSwNCj4gKwkJd3JpdGVsKEZJRUxEX1BS
RVAoRFNJX0hFSUdIVCwgdm0tPnZhY3RpdmUpIHwNCj4gKwkJICAgICAgIEZJRUxEX1BSRVAoRFNJ
X1dJRFRILCB2bS0+aGFjdGl2ZSksDQo+ICAJCSAgICAgICBkc2ktPnJlZ3MgKyBEU0lfU0laRV9D
T04pOw0KPiAgDQo+ICAJaG9yaXpvbnRhbF9zeW5jX2FjdGl2ZV9ieXRlID0gKHZtLT5oc3luY19s
ZW4gKiBkc2lfdG1wX2J1Zl9icHANCj4gLSAxMCk7DQo=

