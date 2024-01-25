Return-Path: <linux-kernel+bounces-37887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E65883B71B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 03:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478941C237DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F386FA7;
	Thu, 25 Jan 2024 02:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="YkPWTFcU";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="XZERNuny"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511CE566A;
	Thu, 25 Jan 2024 02:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706149509; cv=fail; b=qAvHJ4ikzlqzIaSgun64CAjb7Uq9yzNaTujP9iioaMKuLSVI8A18J4vvXGzXd9EkjBkULzKzYpbhfBuyK+uq1aXFG1SOMz+DtRfUqINWmomBQ3KCA6Cmlgx3MduNDBvFiQ4xKxu7uDC3cbic1EoXZtYK1p4yZ+cSu7zt4cBUi1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706149509; c=relaxed/simple;
	bh=8leEpzl/CJ3bhHWIOlQ08Y7Qc2Kf6H2DtX0XFJTK38o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FZ+hUUDcC5rbnE0ravIMXizGlNL4fj7XgWV/2gLKdRbCgt37tBGfcBXsm4TRbHm+VuGVuxvCyLuLkA6xlmEYmNkbOYDpH/P6Uov8zxZ+oF8ZA0eLT/DX3kDeTobySfX3B9OO7F7lZ1Fs9aHtLrFyGX9JMIuVxum1ZEYUG1ErRRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=YkPWTFcU; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=XZERNuny; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: edfbde5ebb2811eea2298b7352fd921d-20240125
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8leEpzl/CJ3bhHWIOlQ08Y7Qc2Kf6H2DtX0XFJTK38o=;
	b=YkPWTFcU05mECUiCM/Y3QKGTzd/AtIlm6WGQgLcShg2zPRdOykajT1tQnz1ARET2uRVsbMQYoOL25+yx2ZsEj1pCQqiTpMXE/q8Tx2occWznC4q0frPozGmuFgmWSYHl5luBdQhfYuHqprEkPjZMdNLMfikMXQsmD7a1G+Rhkq0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.36,REQID:2e8356bf-8b8b-42cd-8248-557146bfe3ff,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6e16cf4,CLOUDID:2e791ffe-c16b-4159-a099-3b9d0558e447,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: edfbde5ebb2811eea2298b7352fd921d-20240125
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1506996420; Thu, 25 Jan 2024 10:24:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 25 Jan 2024 10:24:54 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 25 Jan 2024 10:24:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJJZuFan0B7gs4hbD1rt83+XnnucoPNz6bNR3w+1H3hxSoHqI06cFI/V2NhON0D7xKcHNUk+O0EYMZXpzXwsubNg5JLpvfGob3hgMu9qqKLkVSBx6UIduQkmon+Iu5rXIm/uEKsrI/dkmj0qFNQzYb4pOM3dLMnrpXgRm495WQFCSd+ob7iZCwG3Vjf8lTLkNiwY7tvmI8HkshTfJOmVAyeHf/gZSlzBIYsxcNAc12AbkOYqlRQL7ekt4FdlOX+Rkj2mWkl73dW1QcoEurMwVgLe3Ns3vpIoxDrgF94lhRBOwK3mfZ3eDO6wZGu0I5nwk6bGnvPrq/45n1K8hNdIxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8leEpzl/CJ3bhHWIOlQ08Y7Qc2Kf6H2DtX0XFJTK38o=;
 b=jQtl/qlYCa6txhfQ/keoVlMy7+yJMJATDGV55hrOaoIcFjVsgi1tFkaqdoO3v6AsxULjxH7NidHVe9rSUwXtR+CeW30jSLrLBo1wI+4b4okl8aHAv9CRFYfuMn3OCzBaYO+NoGGXK41VhADv+9aFVqi+Z3+IRAs5gqb3feLShZjdILVAdLIRcTsPt5nb1j2xDj3zUcpHCCsdplY11g+SDiZx17kOel2lJFQpIOhokIShHS5qxi44FX+PJKnzMCZj8713CRt7ecXRSGDKi48AoiRacN+Zg52xy/bi5ONur7Dofshk+BrpCnBg5nnGzWHAgq4gc0fscNodAx0ywjoIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8leEpzl/CJ3bhHWIOlQ08Y7Qc2Kf6H2DtX0XFJTK38o=;
 b=XZERNunyfult536444BTzxNU8tB+8h3PlVOKBLEoHsY1dCLg1q44SrJpMaKLga68UoTfMfWa/b3tnLbkn2ffTlS27OlBfqlxbNELTGHUE++NN21YHum/41tFpqO6F1uzC4SK0JYxf5n+dz7reOp+0jHipiuFfXPMMe76ZfNfhCQ=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by TYZPR03MB5598.apcprd03.prod.outlook.com (2603:1096:400:5e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.25; Thu, 25 Jan
 2024 02:24:53 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::33a9:162c:3c6e:4a0d]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::33a9:162c:3c6e:4a0d%7]) with mapi id 15.20.7228.023; Thu, 25 Jan 2024
 02:24:52 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "sakari.ailus@linux.intel.com" <sakari.ailus@linux.intel.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "gerald.loacker@wolfvision.net"
	<gerald.loacker@wolfvision.net>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"yunkec@chromium.org" <yunkec@chromium.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dan.scally@ideasonboard.com"
	<dan.scally@ideasonboard.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	=?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?= <Yaya.Chang@mediatek.com>,
	"mchehab@kernel.org" <mchehab@kernel.org>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, "jernej.skrabec@gmail.com"
	<jernej.skrabec@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bingbu.cao@intel.com"
	<bingbu.cao@intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "10572168@qq.com" <10572168@qq.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH v3 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH v3 2/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaQqOcaJSxAdVZgECzYCFgQ+2t6LDRRRWAgBig/YA=
Date: Thu, 25 Jan 2024 02:24:52 +0000
Message-ID: <42cf05ea80a2413aae588b762e67c3418b9514d4.camel@mediatek.com>
References: <20240109022715.30278-1-zhi.mao@mediatek.com>
	 <20240109022715.30278-3-zhi.mao@mediatek.com>
	 <ZZ0dcTEqxjYCohac@kekkonen.localdomain>
In-Reply-To: <ZZ0dcTEqxjYCohac@kekkonen.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|TYZPR03MB5598:EE_
x-ms-office365-filtering-correlation-id: f20edf70-8d04-4058-4842-08dc1d4cd04e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Vf+ASjx4w/UAcgCoNgicn0KLUN00gfvDuiI2WWA8ymFYHPoPHzTdB9IZ96ol1kJqvbLQjSCJpn27h1Yj3OjAkZlILFhsJdkMrioHqLs+6GRFoUZoN9h5kypaDr9IZHmneSywUGnzxE0MFHZ3QwUgLVq59SUrodvd+4pkeZzGnMKjf0f6o3ze7WNQJg/mAQ6/kh5A3xLFPbtLJi1vVvaJWNZ3/DOzSyGO8rAf9I5aliZZRssKRy4x24CpWdwoA9W1LvZKTT2MpNidVkhtSBQkpTeHFvoGtpBYrxSiIsMAY10M4YOBM1KZEFs6w2QLFtp9exHP9go889/7iBlqYFSBhNyzle9eBO9PKcxywAKXkD+dixq4zIK523ct2kdEdCko0KVJxBZT3qKBIg2UHxt0pA+fNLC8dD2z+Z6nlTDz4U60HzFxznDIdq+V7zy/3eebhpOxAvM0qvZT40ezfurwz09xsrliAWlMKtYAuiU1izhNZnfLYft6AtUrZdHdciRA1FaFY9febYUphdzaCmzJN5mzK8myOMQVAOT8sCYO/j1bWG6J89KxYa6PPkItZVwV9oZes+0e1svz+4sEWmqquUmc6NdysBv2qj1U6ohVreh16O7pOY2H35wYsEOYuitlJmGcLzArWx270tft2Biug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(83380400001)(6512007)(38100700002)(26005)(2616005)(8676002)(4326008)(8936002)(5660300002)(7416002)(2906002)(478600001)(6506007)(966005)(6486002)(66476007)(71200400001)(66556008)(54906003)(64756008)(66446008)(66946007)(6916009)(316002)(76116006)(122000001)(38070700009)(36756003)(85182001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWRwYUZIN2Q3T1ZhVzlFQ3FVeU85R0lGMDhGQkFXL3FxRjhJdWVUcUZtak51?=
 =?utf-8?B?aWh1NVlnenFad2xlRnlwZmFyVFlGdWdETFNaclpWaUZNSGp4MkJiWWJaUlVL?=
 =?utf-8?B?S1JUN2FtSy95dDl4ZTh3Uk9vV2dEaE1BVmVjMSswMmVtSVAyTHFOcW1IUnh4?=
 =?utf-8?B?anlLaTNHbGpZVzRYT1FnbU1MMGE0Q255YmVFcDR2SThxTUlTc3YrM0RqdXFH?=
 =?utf-8?B?VXg5VzFtdStNZU9qaU9KRjN0NENzY1Q5N1dGNW5ib3liWkpiZ1d2NG9JYndk?=
 =?utf-8?B?VDNLZTZWY0JVOTRpcXRkbWMxcWwxSEc3OEdXdGlZM0pSNVphVzFhK2NJZWsz?=
 =?utf-8?B?K1YyVzBmRWdReTJSRTFPOTVOOExTVHBod0dhOGpNZkREZWYwYURQS0RJSTBn?=
 =?utf-8?B?QmtVTkY3bGxmVHFhVmRhZEQ3Q1U3VUs3WlZQcDEyWFROTWxkVWFSdXhvNG01?=
 =?utf-8?B?ODhPdFFzYzc5aFd0bDJlNERWUzhqd1dZSEdEaHlXOXIzS0FBTHgxTnV0VVJB?=
 =?utf-8?B?LzlHR00rSzhQdWZaclVCQzgxb1FCNWpQeEhkUnJTRVFjM3hITmZwUXlRNjRM?=
 =?utf-8?B?cXcrc2Q2aDFzTE4yUndVL0JDblA3bWdNUDl4QXhpVEszMzZRTXdEZS9HYk9M?=
 =?utf-8?B?Qlg1TDJtZE92dE5DT0V1MTF6U0ZEOVFISUJBQnZpbjN3ejU5Q2hXQkwrM29V?=
 =?utf-8?B?a1FGWW56dnlsQ0pZYXI5YjFSMS90blBkTUN4STQyWGxCU2VZTVNyelZpNEha?=
 =?utf-8?B?REJNU2xWYlhSYjFGdWdhUHhPQTBoc28rV2JWWDAxck1sSlBpTGg3eWpmRmJV?=
 =?utf-8?B?czVUc2doWUNoVG1ISUE4Q0hoUmdlbW55T1hOeXYyVVJ0dkhKNUJ1eVFMdkc1?=
 =?utf-8?B?QlVlYUJKTkNJaEZnUFA4Z01FNGVHd01KT1JWdXFsdlNadzBwVWpGeU9rWWVN?=
 =?utf-8?B?WmNLeXdGWDNYSi80aW5Dd0Q3MmVEUk5hYTMvUllCT3N1eEJVdExZWm45M1Fn?=
 =?utf-8?B?a1AxVlpUditLZFZTbldiVEl3cStPNWlKYVhqY1FGUnQwb3IxZUJXbWRkUEdB?=
 =?utf-8?B?eHNabW42cjZIVmhuNENlc2JwOE03cDNBdkpYUWtPUWkzMFlOU3YzSmdBWnpW?=
 =?utf-8?B?QlZEVlpUV2Zxd2JVNHRGVmlPV015ZWNma0loRGNsZmlwSnhRcVZzNzd4NGQ0?=
 =?utf-8?B?OHhLRDZLVXdiZUZwNFJSVnFqSDljbTJTeExhTDB4NFBlUHl2MzAvM0JNMXF1?=
 =?utf-8?B?TFpoU0M5RXgxTWpEU3lsYmtTTFMrM3V3UVdYVDF2L05BWmpva092RnJuWjYr?=
 =?utf-8?B?UzNxQU1ZVG4vSCttaFZEYzdsd1ZrNWt4MFNvdU9XeHlWaWZQN09yOWd4KzN4?=
 =?utf-8?B?d1Jyd29OZzFhT095bzF1bUtNL0pDQzNUVDJ4bnFoNmRCZXlJWGJvQjI0ajUy?=
 =?utf-8?B?ZUo5NkREVWZiWXJxaU9mQm96SXBvb0g3UjFrWmlIZVBKNnFpdENQUnRMT09t?=
 =?utf-8?B?dTBpTlFvSnlUQkN0Y0VKQlhuY0xhTHV1VnlSRHpZV0o3NWJjUDJsTGFFYzV2?=
 =?utf-8?B?ZksxUG5jRXp6ekJMU203eEJVa01ncjBsMFJrOHVyYXJ6Vk1XMDlzUi93L3FK?=
 =?utf-8?B?MU81dUlOK1dia2hVUjYva0RXWWlCZCtGcXlELzRhT29ZRUtMMGp2UUhMZ0JT?=
 =?utf-8?B?VklGejhjdkkycTQwV3hQWk00Y1hjSk94YmV2Z3NRUDBxMlYvdjQ3bkc2RW9E?=
 =?utf-8?B?aUlzZDc5UmQ4ZEk3ekpjTEZTYjVGVWFRUkNIS3ZFZVNUcnBsK08rZzRhajlF?=
 =?utf-8?B?WFRTUFc0Q0xQV1NZTEFYQzlBRjB0YlNlVWd2NUZraDUvWnJGREViVDU5MzY2?=
 =?utf-8?B?bjI2aUtqOWFoUTg5Q2o5ZkJXSVgwSXg1RUdMRjRURVBHbTc5bHZISS9HOTE0?=
 =?utf-8?B?N3BLVXZ0djcvUHhkWll4c0JRd1lmZDVXNG80ZW5zQVBRcFI1T0MzWHBHbEdj?=
 =?utf-8?B?dWMwTE81Z0VmYnFkWmIrTGFCcjBWK0tFUjg1ZmNuTGdsdXdsdDVRSFd0OWVv?=
 =?utf-8?B?WTl5bGtReGpWR0FIeEcwL2R4dlR5cDFvYS9MbXVtV0ZMU3RCOFJxbTBySkdx?=
 =?utf-8?Q?KhMGkV5iz9GX0hVANoIfaJ04W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <963AB80C94EA0A44A160675A0B530D3E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f20edf70-8d04-4058-4842-08dc1d4cd04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 02:24:52.8761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 65VgTYLudxcpuwwJOVnFuJJpFzsza7ZKGyWxm0qklvrezL8aRAs+PbITOff1vYTOpgmj5mCsCQgrLIqFnbeSOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5598

SGkgU2FrYXJpDQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcgY29kZSBhbmQgY29tbWVudHMuDQoN
Ck9uIFR1ZSwgMjAyNC0wMS0wOSBhdCAxMDoxOCArMDAwMCwgU2FrYXJpIEFpbHVzIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIEhpIFpoaSwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHVwZGF0ZS4NCj4g
DQo+IE9uIFR1ZSwgSmFuIDA5LCAyMDI0IGF0IDEwOjI3OjE1QU0gKzA4MDAsIFpoaSBNYW8gd3Jv
dGU6DQo+ID4gQWRkIGEgVjRMMiBzdWItZGV2aWNlIGRyaXZlciBmb3IgR2FsYXh5Y29yZSBHQzA4
QTMgaW1hZ2Ugc2Vuc29yLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFpoaSBNYW8gPHpoaS5t
YW9AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21lZGlhL2kyYy9LY29uZmln
ICB8ICAgMTAgKw0KPiA+ICBkcml2ZXJzL21lZGlhL2kyYy9NYWtlZmlsZSB8ICAgIDEgKw0KPiA+
ICBkcml2ZXJzL21lZGlhL2kyYy9nYzA4YTMuYyB8IDE0NjcNCj4gKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTQ3OCBpbnNlcnRpb25z
KCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21lZGlhL2kyYy9nYzA4YTMuYw0K
PiA+IA0KPiA+ICtmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShsaW5rX2ZyZXFfbWVudV9pdGVt
cyk7IGkrKykgew0KPiA+ICtmb3IgKGogPSAwOyBqIDwgYnVzX2NmZy5ucl9vZl9saW5rX2ZyZXF1
ZW5jaWVzOyBqKyspIHsNCj4gPiAraWYgKGxpbmtfZnJlcV9tZW51X2l0ZW1zW2ldID09DQo+ID4g
KyAgICBidXNfY2ZnLmxpbmtfZnJlcXVlbmNpZXNbal0pDQo+ID4gK2JyZWFrOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtpZiAoaiA9PSBidXNfY2ZnLm5yX29mX2xpbmtfZnJlcXVlbmNpZXMpIHsNCj4g
PiArZGV2X2VycihkZXYsDQo+ID4gKyJubyBsaW5rIGZyZXF1ZW5jeSAlbGxkIHN1cHBvcnRlZCwg
cGxlYXNlIGNoZWNrIERUIiwNCj4gPiArbGlua19mcmVxX21lbnVfaXRlbXNbaV0pOw0KPiA+ICty
ZXQgPSAtRUlOVkFMOw0KPiA+ICtnb3RvIGRvbmU7DQo+ID4gK30NCj4gPiArfQ0KPiANCj4gUGxl
YXNlIHVzZSB2NGwyX2xpbmtfZnJlcV90b19iaXRtYXAoKSBhdmFpbGFibGUgaGVyZQ0KPiA8VVJM
Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1tZWRpYS8yMDI0MDEwODE1MTgwNS41
NTU4NC0yLXNha2FyaS5haWx1c0BsaW51eC5pbnRlbC5jb20vVC8jdT4NCj4gOy4NCj4gV2UnbGwg
dGhlbiBtZXJnZSBib3RoIGF0IHRoZSBzYW1lIHRpbWUuDQo+IA0KDQpBZnRlciBnb3QgdGhlIGxh
dGVzdCBsaW51eCBrZXJuZWwgY29kZSBiYXNlKHRhZzogbmV4dC0yMDI0MDEyNCksIHRoZXJlDQpz
ZWVtcyB0byBiZSBub3QgbmV3IEFQSTp2NGwyX2xpbmtfZnJlcV90b19iaXRtYXAoKSBzdGlsbC4N
Cg0KV291bGQgeW91IHBsZWFzZSBsZXQgbWUga25vdywgaG93IGFib3V0IHRoZSBzdGF0dXMgYWJv
dXQgdGhpcyBBUEk/DQoNClRoYW5rcyAmIFJlZ2FyZHMsDQpaaGkNCg0K

