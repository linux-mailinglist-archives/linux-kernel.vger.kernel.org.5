Return-Path: <linux-kernel+bounces-70642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8203859A9C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1FE21C209F3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 02:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635131C3E;
	Mon, 19 Feb 2024 02:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bc++yIpO";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="N06PYa2c"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1051FA3
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708308393; cv=fail; b=oIAq+DjK6q0KWlhAnCZ+IGR4HPf0/dLcCpQ97PXL9OMTjHyoVavwaNvaQxssM+R6OKGwPXKpmvcm6r2tjGUzFchYl7j4wTnZq7mBKlx7OfSWXdaLovs5EfrNoWuZ5HoZQFLP/grl3Hida739PLbzcv9NPGDplvS6P0/WzQ+fkD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708308393; c=relaxed/simple;
	bh=hDYeiLmbVewZ0JphWlUdf29bK/9XT899TeAK7ykRvbg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OfecoIRWnG/S5GE7VSvoF8klV2ps6xt/ByvVfvDAYY2D0xmy8gMtAvh95F74/d3TfXwd/lXbm3WrTja03+UhZjXXySdvf+O6hH63wUOAK0BMy6r0djXvAZkdhceZeu/DfGu1s++vkzSB8ptcnz2oj6pfEhuuoj+9EW94to9tVsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=bc++yIpO; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=N06PYa2c; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b22fac8cecb11ee9e680517dc993faa-20240219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=hDYeiLmbVewZ0JphWlUdf29bK/9XT899TeAK7ykRvbg=;
	b=bc++yIpO/wtZmuuvR+4ZNnCerJJEcuwHaWnyiEqb0vxrxSnbo+U73lYfNcG1lKae6EC2/JVNACmXsig5xHVL8NrM7AeTwkUJlaDP3/4royZhHyLEoKW/SC8696UdhbECi9h68vc+qz2o2wV+gTf4XRbP0jZ2PIRXzHaQ+irPYis=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:fe70c466-ae54-4bf6-8b60-2b6c26842298,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:67a88880-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b22fac8cecb11ee9e680517dc993faa-20240219
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2105429905; Mon, 19 Feb 2024 10:06:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Feb 2024 10:06:22 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Feb 2024 10:06:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYGnI4vA/mADo02f1UCiCDK/X1WI+PWynAgCCABiSuCeLIzFw91qNQ684rOhVm8IjCHMVKfBPGLnBAMUBXmzpCpl3Ogf1/BE2tyl6VqgPmnyJqNEwdh7HfMPuSJ3yV2z/P3LOP8dOd8bo64H4WQDCN7USFtWOfzq7kjBdr9Dzx4dXz1tS13BHbqKhjkORhBOWnPHEKRS9rPOyZ65LU9cnEhtk99sPka0SbxMYQAEZSM/pF+B8//1xsy43ve0sFuR1pnozBXH9WkwAGh/PdqJnh2KUEwSCzDiLVo4X3wkwUvHHdaOsAe75A+VdikeS6B0m4m82aiybBA8nyAO7sTuFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDYeiLmbVewZ0JphWlUdf29bK/9XT899TeAK7ykRvbg=;
 b=cUePFx1YbV5kB9onnUEhN07XGN9O6BC9WabCuD+60s7LxAvnqPwgvjAhwy95uEZQgITjfVhpnhkhU1QWqIkQWbpZRbTUe+yNRgWHnEC+jQ4OmdXn5qxV2LvITv0b+0ALDuEuVuERqdnt3Luws6UdWa5V/YK+m4qVGtnC8785/t1CSJ2USduxd8z2Ce5Yw+h/FPoWI2CWqAJsvhkCi77Ta+aMyU4uQBnFu0gFui8c3teFjGuHojsu83QJu6KSsXvhKmGNJPU+Fnpi354iruGUbCpTqmtbK9Hvj86SkzPog1KqO3OI8wF/RPyhjQjcYUKU1zIXcGEj4b6lSXKwIBs3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDYeiLmbVewZ0JphWlUdf29bK/9XT899TeAK7ykRvbg=;
 b=N06PYa2cQ6g1gL/wblSqQkiWjMCrocpWu0GDqfYe1ECnyFcMREvDjaRqQHCT2blmXXS5F4mM98ZQHj6YGcsGV82RoYk7GqKtYjYuyrdJkAlIl1G6y3BxCOkAdtzDPZx1Qgyk6iTPgixewMxMHb1/WNlSn7UbsbYaZQPRWFswL70=
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com (2603:1096:400:1f5::13)
 by OSQPR03MB8676.apcprd03.prod.outlook.com (2603:1096:604:293::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Mon, 19 Feb
 2024 02:06:20 +0000
Received: from TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b]) by TYZPR03MB6623.apcprd03.prod.outlook.com
 ([fe80::a93d:863e:c0fd:109b%6]) with mapi id 15.20.7292.026; Mon, 19 Feb 2024
 02:06:20 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: "daniel@ffwll.ch" <daniel@ffwll.ch>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"jason-ch.chen@mediatek.corp-partner.google.com"
	<jason-ch.chen@mediatek.corp-partner.google.com>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"seanpaul@chromium.org" <seanpaul@chromium.org>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?=
	<ck.hu@mediatek.com>, "dri-devel@lists.freedesktop.org"
	<dri-devel@lists.freedesktop.org>, "airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "fshao@chromium.org" <fshao@chromium.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 10/13] drm/mediatek: Support CRC in display driver
Thread-Topic: [PATCH v5 10/13] drm/mediatek: Support CRC in display driver
Thread-Index: AQHaX/dpb4xX9vYSDEyAoA9XDt3r1rENNImAgAO7+wA=
Date: Mon, 19 Feb 2024 02:06:19 +0000
Message-ID: <3e21e3ac5d8b0002305b7081d3222f190cc317f7.camel@mediatek.com>
References: <20240215101119.12629-1-shawn.sung@mediatek.com>
	 <20240215101119.12629-11-shawn.sung@mediatek.com>
	 <Zc-Vq2MeG9X37JJe@phenom.ffwll.local>
In-Reply-To: <Zc-Vq2MeG9X37JJe@phenom.ffwll.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6623:EE_|OSQPR03MB8676:EE_
x-ms-office365-filtering-correlation-id: 238d58f8-3b34-408d-ebf9-08dc30ef5d21
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BT+Y72W7yxdpMzEugcEqeOzC+ss8172oC9AihljdRp7smhJK6Qsl2NN6NUbIymOHJyUlZ4g9ZGJb+XcurYONMJmr7Vc1wHryQ4JX4I/C0/eAe5Puo+x4GQNhAcNjchHSPUfEGsZ5ClP0AxhPi8I5NfjiwQtlgj6mwKsCQKMzMhklzyPuVaBrSmjMzoTF0Cq7OdSn+GmbGl/4eZCBBK5pLDTsmhmHVqVZlFVvC5KQfADsdIPW94nYluwYzjgw1/MNkqdHni5JTHwE5bk8FWbIflz5ExkXwX8m75RPfCErnzS5ye5EfOOXULBkcB0jBSKM8CxTP9AWiWx971oeX01CYxbgg+ixdk/TjnbHg9HBIytDvq/lhgTBQDqwTV5TXXOs84YAd/qKHVueuh0l+YGXRm59OINL1BTZkoMeKdyae/hZr1WApSBzMjcPDZJ7npriEfgG6tApISDJhuNnzPU4g+MLDrmWNPd3qYDXw9fZfiPXhXwVdn1Ijs2MreixmmmWeQn40QiA0T2v2pPnCFfSumD11KOVupipxp2HPktvlrIOpASAxlzAJoZHfNqyn4p9N/Nv9GG+CiwEfjKyJArw4bmdY2htmxvcoUWq/zQz1aPgS1Wd3qu1Rk6iGNL2nb8i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6623.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(136003)(346002)(39860400002)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(2906002)(86362001)(6506007)(6512007)(6486002)(38100700002)(122000001)(6916009)(66946007)(66446008)(66556008)(66476007)(76116006)(8676002)(64756008)(4326008)(8936002)(5660300002)(7416002)(316002)(36756003)(54906003)(85182001)(83380400001)(71200400001)(478600001)(41300700001)(2616005)(26005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eVFKRWx3a3J3TkwxcTZISTZxMk8wa2VwWjlxNnk1RkNFcE5rWlY5Z0UwN055?=
 =?utf-8?B?b2daRjdnQ3RqZjdUcXZLSHpJUnRJSnM2a0NNcU1hRUFTQStyVW0zRTNweUw1?=
 =?utf-8?B?TzJhVGVGd0RnSCtuaytYbVJiQThNczU4dGFOMlg4QXZWaVZtM0dncHUzNHhF?=
 =?utf-8?B?cDl1RGZ6UnRBb3dpMjNzS2lmc0w0R2Q5UENXbzJJRHk4aTA4a3Z4UGNJWWwz?=
 =?utf-8?B?SlJ6aHZjLy9sYloyS01pRUhoL21qSnpQc2ZDTjBDYW9FaGlQWFEwNzJvVWQ4?=
 =?utf-8?B?VVZSUnhyTTlsWW9SWXBXQjd6MHJlTTJXYnB3dSs0Ync2bUVxTXA4Q1VCOENM?=
 =?utf-8?B?U0g4N2w0U2RvZXVRUzVGWmNQR0xLNkFCNFpsVndKRnBubmMvM0ora3NQQlk3?=
 =?utf-8?B?dnBxSnFFUjd4TjA2N3BKRHM3Z2JXN2Y0K2JnN3JXTUkxSGFZby84ZUUwVDk3?=
 =?utf-8?B?dXRNQWZReHFCd2VmY01jbjNyRmZ6SWhjS0tXNE9yd25XQURoazluRFo0OU1U?=
 =?utf-8?B?Y3pWSXRJdkNYRjlScnJML3MzUUFCV0N2V0orM2tmMjlQUURBckliS1FGM2py?=
 =?utf-8?B?QmtwdSttazY3MVV3VVloZkM3ZCtFWmZ2Y2dKbVloV2dZdWt1NXQva0xiUmx6?=
 =?utf-8?B?VGF2MUtseWQvcXNqdmpCOXIrWUp3UHIzTDVETUNpK2IxZkMwYTlaeFZCZWFG?=
 =?utf-8?B?V1M2UUdmYkJHNTRRcVdlQmhZSlU0TnRzUVNRMjJuL0gvSmhoRlB3YVRGekh6?=
 =?utf-8?B?dGlzeFUvSkdQZWFFTllXam05MEFXaEtSTXRIak9VbHptMXlaMHF0ekZKQy9I?=
 =?utf-8?B?QXFwdHNuMk9wNW96WXdMeGM1OUJFQ00zNnc5UjhvY1FPRkxyZXNRMmlsTEtE?=
 =?utf-8?B?VTBDQXcwY3R1OGl0UVJ6bGNZWUl0OGxpWWxnQkh3STdFa3dHNS9NK3ZYY3Nx?=
 =?utf-8?B?dXNFMzI1amVnaGpZMkpkVDBUYjNSL1h1ZDYyWWRoaFVWeWZSZlgzajRqOXdn?=
 =?utf-8?B?M1BtYW5ueTF0QUtPdDBFZ0NCSXduZW8yRkVXb2tVTUZoMVpMUjd5U2h4WjRD?=
 =?utf-8?B?WXVoUktLd0o5QU1NcE5Vb2J0N29zMXpROTk1cXVBUy9oK3cydnJDZE5OamRj?=
 =?utf-8?B?eFZTcWdWK0gwbTJMMmZRWjBIalliMHdzRlVoTHh5SkQ5VTF5WUNYUmJmOVAv?=
 =?utf-8?B?Ukt2YVdtcDhBWUpQUm1xeDhFWGFEbUZyb0l3dVlrV2NlUVhrRUhlSzN3UDVS?=
 =?utf-8?B?TldLTnhweWV6ajlWYjlObm8xejVla3dXdjdBckFHbkFyNUMzUWtocmJZV1pm?=
 =?utf-8?B?U0dCemovMUZDU09sT2lBbmhwS0htV0c0VjRoOTJlaUNyMGVFcXJkRXhMZFpV?=
 =?utf-8?B?bnkvV3VEQjBsL1pFYTdRMGVjY2R4ak5PYkN0b3RkMnZaNWd5eldxbm55ZmM1?=
 =?utf-8?B?em9GeTZnVjZGYnlidTJ6ZGJJSjhQcEVDaFB0eWUyVFlKTTkxTTA5WEt1MlY2?=
 =?utf-8?B?SkROLy9CU01yQXBDb1lrYkxsUHNnbE8xYkZNZzFCU0FjQVcyaGs5MU05ektw?=
 =?utf-8?B?dEMvN1NkeVpReSt6MmRQaEplUlQvc3VqdXV2NnZ3NzNqRHNzblBXNmJZdVlp?=
 =?utf-8?B?TG1GZnJyY1pXZ3dOOWloMUNrdFFKRFQrdUp0UHJsSlhvRjY4TTJIbVpwbWFS?=
 =?utf-8?B?SXNGU1BrSlVkWXpybENSQW5tVlVxNzhWUVlESGczK2VheGUva21nc0FJL1Aw?=
 =?utf-8?B?cDNpcDNRYmYxQWxTQk9abFRJN0YyZWpybDBXK2hjUDVvd05lTU13OE51dVJ4?=
 =?utf-8?B?MEpIbGQ3b09TUHhkNjFSM1RFQjBGaThHOEpWV1lnTTlqb2UxRnFOaHJXWi9n?=
 =?utf-8?B?b2dhc2RBNnF5NDJNN3VUVlRvaWVQdVlpVnF4a0hTQ3VZQ1F3MzFuOCtVcGtS?=
 =?utf-8?B?a2pRTlNqUkxDcnlPNk1GbGVIdzFUUjFRdWRCS3owNm5ieDZuOE9VT0h1MlJi?=
 =?utf-8?B?SVVUOHRicFBFQVlmTGgyRjJ4L3lQaWRSRjU1SVA3WURkVlJaTXhaRlQxbDFX?=
 =?utf-8?B?VWtjWW9nU2gvaFdBSkI3KzlCVVI3Z1B3QTJmYkFQV210SFpwakkrWitFcFZS?=
 =?utf-8?B?L1hSZDdsYkZacjZ1Nk5ERWpiRGZtcGFNTTVoaDBUbHRsUEY5YmdXTVZLRkdO?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B1FC4AA33AC8C64589C17F1394EBEF31@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6623.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238d58f8-3b34-408d-ebf9-08dc30ef5d21
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 02:06:19.6979
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZBQH4r9e3PHT0f50PpOKdssYOKAaAl7g4DNFFTdgwIoCWIiMPs4Uyx8Bj92LpRPX/hkVD9v+nVQw/bWn2tITkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8676

SGkgRGFuaWVsLA0KDQpPbiBGcmksIDIwMjQtMDItMTYgYXQgMTg6MDQgKzAxMDAsIERhbmllbCBW
ZXR0ZXIgd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xp
Y2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0
aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAgT24gVGh1LCBGZWIgMTUsIDIwMjQgYXQgMDY6
MTE6MTZQTSArMDgwMCwgSHNpYW8gQ2hpZW4gU3VuZyB3cm90ZToNCj4gPiBSZWdpc3RlciBDUkMg
cmVsYXRlZCBmdW5jdGlvbiBwb2ludGVycyB0byBzdXBwb3J0DQo+ID4gQ1JDIHJldHJpZXZhbC4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1l
ZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fY3J0Yy5jICAgICB8IDIzOQ0KPiArKysrKysrKysrKysrKysrKysrKw0KPiA+ICBkcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9jcnRjLmggICAgIHwgIDM5ICsrKysNCj4gPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuaCB8ICAgMyArDQo+ID4gIDMg
ZmlsZXMgY2hhbmdlZCwgMjgxIGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fY3J0Yy5jDQo+ID4gaW5kZXggMTRjZjc1ZmEyMTdmOS4uNmNi
MWVkNDE5ZGVlNyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9jcnRjLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9j
cnRjLmMNCj4gPiBAQCAtNjgsNiArNjgsOSBAQCBzdHJ1Y3QgbXRrX2RybV9jcnRjIHsNCj4gPiAg
LyogbG9jayBmb3IgZGlzcGxheSBoYXJkd2FyZSBhY2Nlc3MgKi8NCj4gPiAgc3RydWN0IG11dGV4
aHdfbG9jazsNCj4gPiAgYm9vbGNvbmZpZ191cGRhdGluZzsNCj4gPiArDQo+ID4gK3N0cnVjdCBt
dGtfZGRwX2NvbXAqY3JjX3Byb3ZpZGVyOw0KPiA+ICt1bnNpZ25lZCBpbnRmcmFtZXM7DQo+ID4g
IH07DQo+ID4gIA0KPiA+ICBzdHJ1Y3QgbXRrX2NydGNfc3RhdGUgew0KPiA+IEBAIC02MzUsNiAr
NjM4LDE0IEBAIHN0YXRpYyB2b2lkIG10a19jcnRjX2RkcF9pcnEodm9pZCAqZGF0YSkNCj4gPiAg
c3RydWN0IGRybV9jcnRjICpjcnRjID0gZGF0YTsNCj4gPiAgc3RydWN0IG10a19kcm1fY3J0YyAq
bXRrX2NydGMgPSB0b19tdGtfY3J0YyhjcnRjKTsNCj4gPiAgc3RydWN0IG10a19kcm1fcHJpdmF0
ZSAqcHJpdiA9IGNydGMtPmRldi0+ZGV2X3ByaXZhdGU7DQo+ID4gK3N0cnVjdCBtdGtfZGRwX2Nv
bXAgKmNvbXAgPSBtdGtfY3J0Yy0+Y3JjX3Byb3ZpZGVyOw0KPiA+ICsNCj4gPiArLyoNCj4gPiAr
ICogY3JjIHByb3ZpZGVycyBzaG91bGQgbWFrZSBzdXJlIHRoZSBjcmMgaXMgYWx3YXlzIGNvcnJl
Y3QNCj4gPiArICogYnkgcmVzZXR0aW5nIGl0IGluIC5jcmNfcmVhZCgpDQo+ID4gKyAqLw0KPiA+
ICtpZiAoY3J0Yy0+Y3JjLm9wZW5lZCkNCj4gPiArY29tcC0+ZnVuY3MtPmNyY19yZWFkKGNvbXAt
PmRldik7DQo+ID4gIA0KPiA+ICAjaWYgSVNfUkVBQ0hBQkxFKENPTkZJR19NVEtfQ01EUSkNCj4g
PiAgaWYgKCFwcml2LT5kYXRhLT5zaGFkb3dfcmVnaXN0ZXIgJiYgIW10a19jcnRjLT5jbWRxX2Ns
aWVudC5jaGFuKQ0KPiA+IEBAIC02NDYsNiArNjU3LDI0IEBAIHN0YXRpYyB2b2lkIG10a19jcnRj
X2RkcF9pcnEodm9pZCAqZGF0YSkNCj4gPiAgaWYgKCFwcml2LT5kYXRhLT5zaGFkb3dfcmVnaXN0
ZXIpDQo+ID4gIG10a19jcnRjX2RkcF9jb25maWcoY3J0YywgTlVMTCk7DQo+ID4gICNlbmRpZg0K
PiA+ICsNCj4gPiArLyoNCj4gPiArICogZHJtX2NydGNfYWRkX2NyY19lbnRyeSgpIGNvdWxkIHRh
a2UgbW9yZSB0aGFuIDUwbXMgdG8gZmluaXNoDQo+ID4gKyAqIHB1dCBpdCBhdCB0aGUgZW5kIG9m
IHRoZSBpc3INCj4gPiArICovDQo+IA0KPiBVaCB0aGlzIGxvb2tzIHJlYWxseSBzY2FyeSwgZXNw
ZWNpYWxseSBzaW5jZSB5b3UgcHV0IHRoaXMgYmVmb3JlIHRoZQ0KPiBjYWxsDQo+IHRvIGRybV9j
cnRjX2hhbmRsZV92YmxhbmsgaW4gdGhlIGZ1bmN0aW9uIGJlbG93LCB3aGljaCByZWFsbHkNCj4g
c2hvdWxkbid0IGJlDQo+IHVuZWNlc3NhcmlseSBkZWxheWVkIChiZWNhdXNlIHRoYXQncyB0aGUg
b25lIHRoYXQgdGFrZXMgdGhlIHZibGFuaw0KPiB0aW1lc3RhbXApLg0KDQpUaGFuayB5b3UgZm9y
IHBvaW50aW5nIHRoaXMgb3V0LiBUaGlzIGtpbmQgb2YgZXhwZW5zaXZlIHdvcmtzIHNob3VsZCBi
ZQ0KZGVmZXJyZWQgdG8gdGhlIGJvdHRvbSBoYWx2ZSBpbnN0ZWFkIG9mIGluIHRoZSBpbnRlcnJ1
cHQgY29udGV4dC4gVGhpcw0KaXMgaW5kZWVkIGFuIGlzc3VlIHRoYXQgd2FzIG9yaWdpbmFsbHkg
dG8gYmUgc29sdmVkIGluIGEgZnV0dXJlDQp2ZXJzaW9uLCBidXQgc2luY2UgaXQgbWF5IHRha2Ug
c29tZSB0aW1lIHRvIGFkanVzdCB0aGUgZmxvdyBhbmQgdmVyaWZpeQ0KaXQsIEkgZml4ZWQgb3Ro
ZXIgbWlub3IgaXNzdWVzIGFuZCBwdXNoZWQgdGhpcyB2ZXJzaW9uIHNvIHRoZSByZXZpZXdlcnMN
CmNvdWxkIGNoZWNrIGl0IGZpcnN0LiBXaWxsIHJlc29sdmUgdGhpcyBwcm9ibGVtIGluIHRoZSBu
ZXh0IHZlcnNpb24uDQoNCj4gDQo+IFRoaXMgc291bmRzIGxpa2UgdGhlIHBlcmZlY3QgYXBwbGlj
YXRpb24gZm9yIGEgdmJsYW5rIHdvcmtlciB0aG91Z2gsDQo+IHNvDQo+IHlvdSBwbGVhc2UgbG9v
ayBpbnRvIGRybV92Ymxhbmtfd29yay5oLiBBbmQgaWYgdGhhdCBpcyBub3QgdXNlYWJsZQ0KPiBk
dWUgdG8NCj4gaGFyZHdhcmUgY29uc3RyYWludCwgdGhlbiBwbGVhc2UgZXhwbGFpbiBpbiBhIGNv
bW1lbnQgaGVyZSBhbmQgaW4gdGhlDQo+IGNvbW1pdCBtZXNzYWdlIHdoeSB5b3UgY2Fubm90IHVz
ZSB0aGF0IGFuZCBoYXZlIHRvIHJvbGwgeW91ciBvd24uDQo+IHZibGFuaw0KPiB3b3JrIHJlYWxs
eSBzaG91bGQgYmUgeW91ciBmaXJzdCBjaG9pY2UgaGVyZSwgYmVjYXVzZToNCj4gLSBpdCdzIGRl
c2lnbmVkIGZvciBleHBlbnNpdmUgdmJsYW5rIHdvcmsNCj4gLSBpdCBnaXZlcyB5b3UgYWxsIHRo
ZSBmbHVzaC9jYW5jZWxfc3luYyBmdW5jdGlvbnMgeW91IG5lZWQgZm9yDQo+IGRpc2FibGluZw0K
PiAgIGNyYyBhZ2FpbiwgYW5kIGluIGEgcmFjZS1mcmVlIGltcGxlbWVudGF0aW9uLiBNdWNoIGJl
dHRlciB0byB1c2UNCj4gY29tbW9uDQo+ICAgY29kZSB0aGFuIHRvIHJlaW52ZW50IHN5bmNocm9u
aXphdGlvbiB3aGVlbHMgaW4gZHJpdmVycyA6LSkNCj4gDQo+ID4gK2lmIChjcnRjLT5jcmMub3Bl
bmVkKSB7DQo+IA0KPiBCZWNhdXNlIHRoaXMgaXMgcHJvYmFibHkgbm90IHJhY2UtZnJlZSwgc28g
d2UgbmVlZCBzb21ldGhpbmcgc29saWQNCj4gaGVyZS4NCg0KVGhhbmsgeW91IHZlcnkgbXVjaCBm
b3IgdGhlIGhpbnQgOikNCkRpZG4ndCBrbm93IHRoZXJlIGlzIHN1Y2ggYSB1c2VmdWwNCnRvb2wg
aW4gRFJNLg0KV2lsbCB0cnkgdG8gaW50ZWdyYXRlIHRoZSBDUkMgZnVuY3Rpb24gd2l0aA0KZHJt
X3ZibGFua193b3JrLg0KDQpDaGVlcnMsIFNpbWENCj4gDQo=

