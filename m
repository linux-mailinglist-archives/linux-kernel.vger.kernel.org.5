Return-Path: <linux-kernel+bounces-55911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF4AD84C348
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC7C1F21E7C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D422E10A0D;
	Wed,  7 Feb 2024 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JuP6hNp6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="rmdZm5rL"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BAC10940
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 03:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277772; cv=fail; b=oNnGVmlmp6FU0aIxiKa573/b+BswEHpIfas1lb/iiUo/QaZRXxgPNaN5UtLlg8D9ZsSjQ3AfrGT3MyXnvgOu7O46gGQoeuXvR4cGWQ/Y8kkNA7zn1TWOA7rnpw5vKhE++g9klnYSUA7qU4H6eaQRPfdkA841EsOLJyzU/cyI7Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277772; c=relaxed/simple;
	bh=eOO849oW2m8o6Fdo/wiOhtBMIPOTTcy63KAt98vmbJs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FmBAocw3UEs5TNuJ9Vhb2Ll/cWP8Ou0JsN1Z4Hv93KlD7E2RCzULZ8ZJ0OM/fZSEEL69yiH0dj/GQ7nU/gUWFeGhqQvZ7tt9O6m7mboY+Ud75PFbaIWaeGMBTNa5AkYWPP2ZhiOy49n4TQ7pmPrs6nJMKb5C2Vix5Y6egN1tcBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JuP6hNp6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=rmdZm5rL; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e1107964c56b11eea2298b7352fd921d-20240207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=eOO849oW2m8o6Fdo/wiOhtBMIPOTTcy63KAt98vmbJs=;
	b=JuP6hNp62l81758xDvCOw9NbL+ao6ciLCrH4bYbrK5jslR68g+jI68bt3OYEWqZkigHsxsN+QK4K3uTAGRJOJT9hpTUgdBCwxLmuxp9kONdspVH0VGNK/YeqeOLX0V2hdRQshnCHhbt+e0Qj0fohJCjiSxpJQLuEjgfJy/a0ruk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:3bc261b6-e537-4860-8faf-9da7af988fed,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:78cf3480-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e1107964c56b11eea2298b7352fd921d-20240207
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1920533055; Wed, 07 Feb 2024 11:49:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 7 Feb 2024 11:49:21 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 7 Feb 2024 11:49:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPwslEMdKTUqMYoYeWxANqToVraalI9x7XRIV7s8AgAsMWZsWM8SQy00B/GJK3umv9FWVotH4OqlxXP9g/tE27gpqGkXzoMfPQCN/jP1V+gv6OP0PMtxIr/H1Sb669QQCt0tKaSrNMlcZtX+iGEMEc3if9O71kOXuQ5qc7/M1axvKTjViO3qvvOlsW743urDAcRLuBEwBx4jTFK6zWWWdqWyLAH6/l9QU1h595LAyN0CNczS2Dc0ZRo/98G8kECm5siYI7dEWXsRzcp9bv6aRC0tW8lJ27gyP7FK9AUFGIVzp34L3KR95OhOHJPhSJ5drJt22FTzXbtJn5VjHYx9BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOO849oW2m8o6Fdo/wiOhtBMIPOTTcy63KAt98vmbJs=;
 b=cpX7L4EMonKkRlWbS5Q2SxlO0DRFC/beR5VUondWO9yqkFyPpg1qrN+5yGzBAOMUTj7xzxVh+22N6XwIgxxXkcPRV4NqjAfquWUZ/x1GLMggHtmx65wbBAEuUd0q4GCI4AcTwevdXWq4gWxGeuf+MNo1E5Ns+5YMrwBQFkdN4inJ5a+VGHrS10ZUnUNSeJM6AOOSurNDNKbAyQpRcSYvpvmgy3/K+mMsA4QOea2D3wJbjknYPGC9Mqq/Z1/ElGkhk6FA6sfJHgzcXTi4OVFXsEJeDMD7PjzjXaUCcaCZ2T83iKJaYTFzqEa7YnA/dwQQzTVTnS8tgdkys4CKWVQlSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOO849oW2m8o6Fdo/wiOhtBMIPOTTcy63KAt98vmbJs=;
 b=rmdZm5rL5mhCpCoEtDuRbx6a9qC3zMV1+us+3TnHltAhVt9L2mPmCX3wNizEZJyX+wRjzewTK5ax8I+dYX+GZ6cD8qbI6PKNngbHM3pBOx5/Gau+5O7Nb96CdaCSAuOTrC/UQT6f2WNLWoFuDws9yra/H0XzRtwzqsCORUX2K7I=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by JH0PR03MB8862.apcprd03.prod.outlook.com (2603:1096:990:a3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 03:49:19 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::2a01:4518:f0b1:281]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::2a01:4518:f0b1:281%5]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 03:49:19 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kernel@collabora.com"
	<kernel@collabora.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"wenst@chromium.org" <wenst@chromium.org>
Subject: Re: [PATCH 1/3] drm/mediatek: Dynamically allocate CMDQ and use
 helper functions
Thread-Topic: [PATCH 1/3] drm/mediatek: Dynamically allocate CMDQ and use
 helper functions
Thread-Index: AQHZpbghA43V0G2y6EGRogXrDPk526/WyH+AgABHuACAAUvMgIAAILQAgAADLoCBJja3AIAA7zQA
Date: Wed, 7 Feb 2024 03:49:19 +0000
Message-ID: <8811a5e04514954cf379ac561023a7e1884a2da1.camel@mediatek.com>
References: <20230623094931.117918-1-angelogioacchino.delregno@collabora.com>
	 <20230623094931.117918-2-angelogioacchino.delregno@collabora.com>
	 <bd19faf644fa80f8fa77ed0841a724aa3ca871f5.camel@mediatek.com>
	 <0acd286d-d4f4-97b2-c296-b2860a00def6@collabora.com>
	 <e8e60556e53ccf319358cbef203bc84c418a352b.camel@mediatek.com>
	 <d29d342b-37f4-8d7b-ed7d-c441cc928393@collabora.com>
	 <7175ec117988657c2fb7bf6d50b67d60038e3a54.camel@mediatek.com>
	 <072f049a-021f-4f39-81ff-d3cba1e6c47c@collabora.com>
In-Reply-To: <072f049a-021f-4f39-81ff-d3cba1e6c47c@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|JH0PR03MB8862:EE_
x-ms-office365-filtering-correlation-id: 1b8bfeb6-fb91-435a-63e3-08dc278fc36c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5D2momrxYmBVqVd2Tw3Y0Yydo04ruASMQH1jUm9faatEdrys6GxeYIRgJJ8dMqXpExc6JK6Mv7EHKaIeXsO5HJ25b0ZRRrXNbntdHUHTokhLMqN67jpt81C+EGDwCyAVaLZMCd7ApLA7py2cIjGEbXr8yU4Zl3I3QF4LpVHvcUz313Wuuy1SoRxoGXXpACICh+how+6HSH54FQXoEFWzSz3oj2vel0TFmCehLdZ8UCqrQx0aRQuxlQkX/TcrraqtwtDSwhkJwvPpexG9EFkPGJSenAUGdISEtH3rgrQhydBiEol0V51OxD1Uwwdq3hLOSSb7B1pbx7fRkMU7qWX/gWupmE8Acw2yoQ9jdpOIYo4MVN3LUBYkViW1swXcwoI2dh70sQouQlqLBlWcEe7zfyrFo8hCgNHPklkADTa0VBPjQasyvDxG1YkIL2DZERBKUfX3Io6Y+QqqeePS7naZkcOoTGK22nBKHz9SxSqXhcWlVK4rbG5Ud2XYTEQYD7oNKUGuxONtktNg/AIQYcyBQTdrYhXnPZTySMJ+9XYTOKToU9nLKj6hX5S3hZ0LKogAGJpVWnjuIP2MHE8VwiWZOKMqLOD8xEYDGUUxWLFPcW66kqe0lSiVy7Gcnc1iit6+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(230922051799003)(230273577357003)(451199024)(186009)(1800799012)(64100799003)(38100700002)(6506007)(122000001)(83380400001)(86362001)(26005)(41300700001)(8936002)(316002)(2616005)(8676002)(36756003)(6512007)(71200400001)(4326008)(2906002)(76116006)(6486002)(5660300002)(66446008)(38070700009)(66946007)(66556008)(66476007)(64756008)(54906003)(110136005)(478600001)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTB0T0ZvVjUvalMyK3VJRDZzRVQ4SnJTUDdGcnp5RjRQTVFsNUxza2FEcUdp?=
 =?utf-8?B?b0ZrclA5WmU0aGg0bS9ZcGs1Rjl4MEtNOGdyM2UzOW5RRUpHQXRObWdpMk90?=
 =?utf-8?B?UjFRc0hRK2YvTEV2T0tWYUhyWnhWcGY2OWp4YWhmZ3FaYm9zNlVXRHlkTVR0?=
 =?utf-8?B?enlFOFNqTU1HWnpyZGU4ZHpVdXMvUmVDc2dDZGorOWxyQzBHemhjVkQrNGZB?=
 =?utf-8?B?Y0hsb2JoQytCekREbWZkQ1dEWUhOankwQndrZGRWTFFQeTJPT0Y0NnN5OHd1?=
 =?utf-8?B?WnpBSVUrS0JTcllsa2x4cTVBRGp2YVp6L3VHcTdDcjI5OVR6OGN4UEVNRUFw?=
 =?utf-8?B?MVlHTHRMb2FXR0VSb3htQVM2OHlJbHRBZEF5NVlIR0VzWGxYV0o2NmhHOUpG?=
 =?utf-8?B?ZTh2YVR1QW5KQi9XSjNReDJkMVpqNnErNG1ackhCd2JjUGpXd3JpVXZXT0xw?=
 =?utf-8?B?RFh3dlFaOFFid1hya1J4ckdxQUZxazZiNDdteVoxMWUwUmVQdExtOWZoWThQ?=
 =?utf-8?B?aDBEemZ0RFFNSGluQklQRWFrSFNxZXArWDdndllIN0p5Z1VTV0VkUk1iYUFW?=
 =?utf-8?B?MU43VWVJdlduL0NrRHZveDJwQnRBR0tjcGpudkQ2YUdHOFJib0p2UVVDNXlk?=
 =?utf-8?B?cWhxYy9oZi9BZllDWk51dVkzaERGbmxqY0RjMDJIWmNxSTBqamxDUUJId1BB?=
 =?utf-8?B?b1hSdTBuYk5seUpPVWl3NjBQL3JOdWVVUkJRL1RRaEMvd1cycHQrcUNMaG40?=
 =?utf-8?B?WnAveWszbkxTQzh1ZitRY3RNS1JsYS82MldLM21Wam1QVEFQWGJWNHU0MlBM?=
 =?utf-8?B?OUxrZ216V1BMQnZnYzdFK1FJM2ZSaVpYdDJFaUcvRGZkVjV6djk3SGlHd1FX?=
 =?utf-8?B?UGIzb0ttTmx4L1owbnN4TURXemxsNEZVZW9sWUYyeDE4WnNjYWpSd1RqUzFq?=
 =?utf-8?B?QnVWMTdsbTBHT21JZlVIWDFQSHhTZ3R0eTdkd2Y2UnNwemo5YlJLeWxtSnRL?=
 =?utf-8?B?TGFlVXpoWnRUSi9sb05rUDFxVWJUYVFVeUlPTFFiQUg1dzBTajljL0lDOGow?=
 =?utf-8?B?U0U5OG81SDBFNEhyeCtVN2xTa21JYmEyQ0pxRWVkU245T2w1MUJDUk11Yld0?=
 =?utf-8?B?L1FpaGlRSm0yR1FTNVdKcFllOVBCWWhla0tZeUE2KytmSzdhSDhhMVA2cGJT?=
 =?utf-8?B?K1RoYXdTdHlzUlZBZGFPOUMxSzlOVXZTNFJOc25vdDJjZFozVDJQczJkMXdy?=
 =?utf-8?B?NCtkbEhoSUFQdEpWUW5qOWNjQkxTWnNyV20zRkZiNm9xUVZTRU1DSUhITVBz?=
 =?utf-8?B?QWkzWDZTMUlPaHVZc3BRL1NTNDB0cThLbGhjL0FJd1VKUDdCTVdWMHpsQklu?=
 =?utf-8?B?ZDNacHJOU1RQUDVyNzROdEdMc3R3bmVEZ29peCthVG5hZEw0bFpHWnBEbVE5?=
 =?utf-8?B?bDgzNFlyTmExQk5ndnIwOEF0U3NnUzFZVVRBM0F3akFzOFZSZDYwMjY5ZnlJ?=
 =?utf-8?B?U0NWcFFoNGt1QUR5bklUcUo3NURBR25ZdFlnbkQvODByWFN5Ui9kaWxLMmJl?=
 =?utf-8?B?enRXOXA2aVBVOFpBTTAvbS9qV09ITDk5VFVPZlgvMFpxRzc4eTZzakZwSW0w?=
 =?utf-8?B?TkM2NUVSLzRRRndoUDNIcUxFR3NBK20yWnFTUjNzWFJQOHpHb2EzY0RjQlkx?=
 =?utf-8?B?MTNZc055L2JnYVpDblQ3UHBwSm5LQlg0SXRpRHplSkY1SEVHeW1XOHBBcUwx?=
 =?utf-8?B?NE1kZnV6TDZHUEZiTTZPRDN5NG90L0o4akdOUE9CYmNpQ3JpcnhVK0wxbk1l?=
 =?utf-8?B?R0FmQ2IwMitQWlNKb0NCeERpMDFKTE1zZU8wVFVSVUdEd3MyL3BLdlo1TVN5?=
 =?utf-8?B?dFdkQUFQZnJlUC8ySXIvUEFBMXF1YjZYZTR3alFpSnlEcWlRVFpReVVwZWE1?=
 =?utf-8?B?RkZJOVoyS1JqY1JSZVpXRnlVQ2I2L2hncG9memlJYlU0eG5ZNlV4QWlGSklx?=
 =?utf-8?B?UWtCR0dqVGorOERvVWNTNmx5WGo2V3dYdW9GdVFNOTFmdVF5L0Uzb0E5dGQ5?=
 =?utf-8?B?TXhQQmtEVE9VSkRzclBWSHc0dDBWc3F6WHJiZXoyUnpzRkdKZS9uSFZhRU80?=
 =?utf-8?Q?1TA/E7jY+tk1dr915RhtDztBm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C818048FAF275F42AF961B646EB90712@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b8bfeb6-fb91-435a-63e3-08dc278fc36c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 03:49:19.1862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zuwfuMPSwXjaxHTgyyRr0nUKqbNXkSTyqsEZYpZ6TOdh9jpefl6Ru2mnRcK6g1pg/zGmGBCWmMev0fVndGyJJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8862
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--26.398400-8.000000
X-TMASE-MatchedRID: fE0JoqABJp0NtKv7cnNXnSa1MaKuob8PofZV/2Xa0cJauByPtDznde+1
	giXGd3Eefdd9BtGlLLzx1uczIHKx54/qvvWxLCnegOqr/r0d+Cy2McZY43zJ4/t592eq2xoT+lm
	NZCKoGWEU+viiDxBlnXBSByhCpcr+jlL/hujrw1tH+PTjR9EWktNte1LuSj6sjlFfNjQx+AIRcU
	eSUAEujtPTUDa8SKRWW7oC2t+5KapfW3i85vanouKXavbHY/C1Wmr/8mnjMG4UtdRZTmEaIYKOH
	gdS51oIBZONHdT1B7l7aKUDRbhLKMbYnyRUkqHDwCZxkTHxcck/FeJYf9wxdSJ8zskw0dbrLuyt
	5Ak2dzvHnDZ7RToKWLL/rkOqk8rWQy0EQbVL8CaJLx4p0P/u5B0my+2r8QlC3BDlUOLc70GjxYy
	RBa/qJRVHsNBZf9aRPcCXjNqUmkW8QIu4z6HhEH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--26.398400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	1409160E7E5E057629D61CB1872A238A0CED9564F0629CCCB4EE63AE39E01FBF2000:8

SGksIEFuZ2VsbzoNCg0KT24gVHVlLCAyMDI0LTAyLTA2IGF0IDE0OjMzICswMTAwLCBBbmdlbG9H
aW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMDMvMDgvMjMgMTA6MzcsIENLIEh1ICjo
g6Hkv4rlhYkpIGhhIHNjcml0dG86DQo+ID4gSGksIEFuZ2VsbzoNCj4gPiANCj4gPiBPbiBUaHUs
IDIwMjMtMDgtMDMgYXQgMTA6MjUgKzAyMDAsIEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vDQo+
ID4gd3JvdGU6DQo+ID4gPiBJbCAwMy8wOC8yMyAwODoyOCwgQ0sgSHUgKOiDoeS/iuWFiSkgaGEg
c2NyaXR0bzoNCj4gPiA+ID4gSGksIEFuZ2VsbzoNCj4gPiA+ID4gDQo+ID4gPiA+IE9uIFdlZCwg
MjAyMy0wOC0wMiBhdCAxMjo0MSArMDIwMCwgQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8NCj4g
PiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gSWwgMDIvMDgvMjMgMDg6MjQsIENLIEh1ICjog6Hkv4rl
hYkpIGhhIHNjcml0dG86DQo+ID4gPiA+ID4gPiBIaSwgQW5nZWxvOg0KPiA+ID4gPiA+ID4gDQo+
ID4gPiA+ID4gPiBPbiBGcmksIDIwMjMtMDYtMjMgYXQgMTE6NDkgKzAyMDAsIEFuZ2Vsb0dpb2Fj
Y2hpbm8gRGVsDQo+ID4gPiA+ID4gPiBSZWdubw0KPiA+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+
ID4gPiA+ICAgICAJDQo+ID4gPiA+ID4gPiA+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5v
dCBjbGljayBsaW5rcyBvciBvcGVuDQo+ID4gPiA+ID4gPiA+IGF0dGFjaG1lbnRzDQo+ID4gPiA+
ID4gPiA+IHVudGlsDQo+ID4gPiA+ID4gPiA+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIg
b3IgdGhlIGNvbnRlbnQuDQo+ID4gPiA+ID4gPiA+ICAgICBJbnN0ZWFkIG9mIHN0YWNrIGFsbG9j
YXRpbmcgdGhlIGNtZHFfY2xpZW50IGFuZA0KPiA+ID4gPiA+ID4gPiBjbWRxX2hhbmRsZQ0KPiA+
ID4gPiA+ID4gPiBzdHJ1Y3R1cmVzDQo+ID4gPiA+ID4gPiA+IHN3aXRjaCB0aGVtIHRvIHBvaW50
ZXJzLCBhbGxvd2luZyB1cyB0byBtaWdyYXRlIHRoaXMNCj4gPiA+ID4gPiA+ID4gZHJpdmVyDQo+
ID4gPiA+ID4gPiA+IHRvDQo+ID4gPiA+ID4gPiA+IHVzZQ0KPiA+ID4gPiA+ID4gPiB0aGUNCj4g
PiA+ID4gPiA+ID4gY29tbW9uIGZ1bmN0aW9ucyBwcm92aWRlZCBieSBtdGstY21kcS1oZWxwZXIu
DQo+ID4gPiA+ID4gPiA+IEluIG9yZGVyIHRvIGRvIHRoaXMsIGl0IHdhcyBhbHNvIG5lY2Vzc2Fy
eSB0byBhZGQgYQ0KPiA+ID4gPiA+ID4gPiBgcHJpdmANCj4gPiA+ID4gPiA+ID4gcG9pbnRlciB0
bw0KPiA+ID4gPiA+ID4gPiBzdHJ1Y3QgY21kcV9jbGllbnQsIGFzIHRoYXQncyB1c2VkIHRvIHBh
c3MgKGluIHRoaXMgY2FzZSkNCj4gPiA+ID4gPiA+ID4gYQ0KPiA+ID4gPiA+ID4gPiBtdGtfY3J0
Yw0KPiA+ID4gPiA+ID4gPiBoYW5kbGUgdG8gdGhlIGRkcF9jbWRxX2NiKCkgbWFpbGJveCBSWCBj
YWxsYmFjayBmdW5jdGlvbi4NCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiA+ID4gPiA+ID4gYW5nZWxv
Z2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+ID4gPiA+ID4gPiAtLS0NCj4g
PiA+ID4gPiA+ID4gICAgIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyB8
IDEwNw0KPiA+ID4gPiA+ID4gPiArKysrKysrLS0tLS0NCj4gPiA+ID4gPiA+ID4gLS0tDQo+ID4g
PiA+ID4gPiA+IC0tLS0tLS0NCj4gPiA+ID4gPiA+ID4gLS0NCj4gPiA+ID4gPiA+ID4gICAgIGlu
Y2x1ZGUvbGludXgvc29jL21lZGlhdGVrL210ay1jbWRxLmggICB8ICAgMSArDQo+ID4gPiA+ID4g
PiA+ICAgICAyIGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDc2IGRlbGV0aW9ucygt
KQ0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4gPiA+ID4gPiBpbmRleCAwZGY2MmIw
NzZmNDkuLmI2MzI4OWFiNjc4NyAxMDA2NDQNCj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYw0KPiA+ID4gPiA+ID4gPiBAQCAtNTAs
OCArNTAsOCBAQCBzdHJ1Y3QgbXRrX2RybV9jcnRjIHsNCj4gPiA+ID4gPiA+ID4gICAgIAlib29s
CQkJCXBlbmRpbmdfYXN5bmNfcGxhDQo+ID4gPiA+ID4gPiA+IG5lczsNCj4gPiA+ID4gPiA+ID4g
ICAgIA0KPiA+ID4gPiA+ID4gPiAgICAgI2lmIElTX1JFQUNIQUJMRShDT05GSUdfTVRLX0NNRFEp
DQo+ID4gPiA+ID4gPiA+IC0Jc3RydWN0IGNtZHFfY2xpZW50CQljbWRxX2NsaWVudDsNCj4gPiA+
ID4gPiA+ID4gLQlzdHJ1Y3QgY21kcV9wa3QJCQljbWRxX2hhbmRsZTsNCj4gPiA+ID4gPiA+ID4g
KwlzdHJ1Y3QgY21kcV9jbGllbnQJCSpjbWRxX2NsaWVudDsNCj4gPiA+ID4gPiA+ID4gKwlzdHJ1
Y3QgY21kcV9wa3QJCQkqY21kcV9oYW5kbGU7DQo+ID4gPiA+ID4gPiA+ICAgICAJdTMyCQkJCWNt
ZHFfZXZlbnQ7DQo+ID4gPiA+ID4gPiA+ICAgICAJdTMyCQkJCWNtZHFfdmJsYW5rX2NudDsNCj4g
PiA+ID4gPiA+ID4gICAgIAl3YWl0X3F1ZXVlX2hlYWRfdAkJY2JfYmxvY2tpbmdfcXVldWUNCj4g
PiA+ID4gPiA+ID4gOw0KPiA+ID4gPiA+ID4gPiBAQCAtMTA4LDQ3ICsxMDgsNiBAQCBzdGF0aWMg
dm9pZA0KPiA+ID4gPiA+ID4gPiBtdGtfZHJtX2ZpbmlzaF9wYWdlX2ZsaXAoc3RydWN0DQo+ID4g
PiA+ID4gPiA+IG10a19kcm1fY3J0YyAqbXRrX2NydGMpDQo+ID4gPiA+ID4gPiA+ICAgICAJfQ0K
PiA+ID4gPiA+ID4gPiAgICAgfQ0KPiA+ID4gPiA+ID4gPiAgICAgDQo+ID4gPiA+ID4gPiA+IC0j
aWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4gPiA+ID4gPiA+ID4gLXN0YXRpYyBp
bnQgbXRrX2RybV9jbWRxX3BrdF9jcmVhdGUoc3RydWN0IGNtZHFfY2xpZW50DQo+ID4gPiA+ID4g
PiA+ICpjbGllbnQsDQo+ID4gPiA+ID4gPiA+IHN0cnVjdCBjbWRxX3BrdCAqcGt0LA0KPiA+ID4g
PiA+ID4gPiAtCQkJCSAgIHNpemVfdCBzaXplKQ0KPiA+ID4gPiA+ID4gPiAtew0KPiA+ID4gPiA+
ID4gPiAtCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4gPiA+ID4gPiA+ID4gLQlkbWFfYWRkcl90IGRt
YV9hZGRyOw0KPiA+ID4gPiA+ID4gPiAtDQo+ID4gPiA+ID4gPiA+IC0JcGt0LT52YV9iYXNlID0g
a3phbGxvYyhzaXplLCBHRlBfS0VSTkVMKTsNCj4gPiA+ID4gPiA+ID4gLQlpZiAoIXBrdC0+dmFf
YmFzZSkgew0KPiA+ID4gPiA+ID4gPiAtCQlrZnJlZShwa3QpOw0KPiA+ID4gPiA+ID4gPiAtCQly
ZXR1cm4gLUVOT01FTTsNCj4gPiA+ID4gPiA+ID4gLQl9DQo+ID4gPiA+ID4gPiA+IC0JcGt0LT5i
dWZfc2l6ZSA9IHNpemU7DQo+ID4gPiA+ID4gPiA+IC0JcGt0LT5jbCA9ICh2b2lkICopY2xpZW50
Ow0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBJIGhhdmUgYSBwbGFuIHRvIHJlbW92ZSBjbCBp
biBzdHJ1Y3QgY21kcV9wa3QuIEJ1dCB0aGlzDQo+ID4gPiA+ID4gPiBtb2RpZmljYXRpb24NCj4g
PiA+ID4gPiA+IHdvdWxkIG1ha2UgdGhpcyBwbGFuIG1vcmUgZGlmZmljdWx0LiBTbyBJIHdvdWxk
IHBlbmRpbmcNCj4gPiA+ID4gPiA+IHRoaXMNCj4gPiA+ID4gPiA+IHBhdGNoDQo+ID4gPiA+ID4g
PiB1bnRpbCBjbCBpcyByZW1vdmVkIGZyb20gc3RydWN0IGNtZHFfcGt0Lg0KPiA+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gSSB0aGluayB0aGF0IHRoaXMgaWZkZWYgY2xlYW51cCBp
cyBtb3JlIHVyZ2VudCB0aGFuIHRoZQ0KPiA+ID4gPiA+IHJlbW92YWwNCj4gPiA+ID4gPiBvZg0K
PiA+ID4gPiA+IGBjbGAgZnJvbQ0KPiA+ID4gPiA+IHN0cnVjdCBjbWRxX3BrdCwgYXMgdGhvc2Ug
aWZkZWZzIHNob3VsZG4ndCBoYXZlIHJlYWNoZWQNCj4gPiA+ID4gPiB1cHN0cmVhbQ0KPiA+ID4g
PiA+IGluDQo+ID4gPiA+ID4gdGhlIGZpcnN0DQo+ID4gPiA+ID4gcGxhY2UsIGRvbid0IHlvdSBh
Z3JlZT8NCj4gPiA+ID4gDQo+ID4gPiA+IEkgdGhpbmsgcmVtb3ZpbmcgaWZkZWZzIGFuZCB1c2lu
ZyBoZWxwZXIgZnVuY3Rpb24gYXJlIGRpZmZlcmVudA0KPiA+ID4gPiB0aGluZ3MuDQo+ID4gPiA+
IFlvdSBjb3VsZCByZW1vdmUgaWZkZWZzIGFuZCBrZWVwIG10a19kcm1fY21kcV9wa3RfY3JlYXRl
KCkuDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBJIGNob3NlIHRvIGRvIGl0IGxpa2UgdGhhdCBi
ZWNhdXNlIHRoaXMgZnVuY3Rpb24gd291bGQgb3RoZXJ3aXNlDQo+ID4gPiBiZSBhDQo+ID4gPiAx
MDAlIGR1cGxpY2F0ZSBvZiB0aGUgcmVsYXRlZCBjbWRxIGhlbHBlciA6LSkNCj4gPiANCj4gPiBS
ZW1vdmluZyBjbCB3b3VsZCBjaGFuZ2UgdGhlIGludGVyZmFjZSBvZiBjbWRxX3BrdF9jcmVhdGUo
KS4gQW5kDQo+ID4gdGhpcw0KPiA+IGlzIHJlbGF0ZWQgdG8gZGlmZmVyZW50IG1haW50YWluZXIn
cyB0cmVlLiBTbyBpdCB3b3VsZCBiZSBhIGxvbmcNCj4gPiB0aW1lDQo+ID4gdG8gcHJvY2Vzcy4g
Rm9yIHlvdSwgb25seSByZW1vdmluZyBpZmRlcyBpcyB1cmdlbnQsIHNvIHVzZQ0KPiA+IGNtZHFf
cGt0X2NyZWF0ZSgpIGlzIG5vdCB1cmdlbnQuIFNvIGxldCdzIGtlZXANCj4gPiBtdGtfZHJtX2Nt
ZHFfcGt0X2NyZWF0ZSgpIGFuZCB5b3UgY291bGQgcmVtb3ZlIGlmZGVmcy4NCj4gPiANCj4gDQo+
IEhlbGxvIENLLA0KPiANCj4gbXkgQ01EUSBjbGVhbnVwIGhhcyBiZWVuIHN0dWNrIG9uIHlvdXIg
aW50ZW50aW9uIHRvIHJlbW92ZSBgY2xgIGZyb20NCj4gdGhlIENNRFENCj4gaGVscGVycyBmb3Ig
Kiogc2l4IG1vbnRocyAqKiBub3cuDQo+IA0KPiBBcmUgeW91IHBlcmZvcm1pbmcgdGhhdCByZW1v
dmFsLCBvciBjYW4gd2UganVzdCBnZXQgdGhpcyBjbGVhbnVwDQo+IGZpbmFsbHkgZG9uZT8NCg0K
SXQncyBidXN5IGxhc3QgeWVhciBhbmQgSSBhbG1vc3QgZm9yZ2V0IHRoaXMuIFRoYW5rIHlvdSB0
byBub3RpY2UgbWUuIEkNCndvdWxkIHNlbmQgcGF0Y2ggYWZ0ZXIgQ2hpbmVzZSBuZXcgeWVhciAo
RmViIDh0aCB+IEZlYiAxNHRoKS4NCg0KUmVnYXJkcywNCkNLDQoNCg0KPiANCj4gUmVnYXJkcywN
Cj4gQW5nZWxvDQo+IA0KPiANCj4gDQo=

