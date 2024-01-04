Return-Path: <linux-kernel+bounces-16279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 697D4823C1D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 07:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC646287F90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142751A710;
	Thu,  4 Jan 2024 06:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KsADN0Hg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="lGN6Swt4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC411DFE3;
	Thu,  4 Jan 2024 06:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3d93196caac811ee9e680517dc993faa-20240104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Pf/kO4WtGM61Jj1D5PQ/9bVy7L/Z+IaVQXCSNvkIdhU=;
	b=KsADN0Hg8WYYf6crLBxEbUdEGYli4z45zKj8y3mp8OmXno+YsPCiu62XI39QV7VFenqcf7QK9cPJlSf9JyJrvcOEvyu0Tg3wJIViRON4WHmCRRkBW8yQNs73WknreVcKuc/hpezn5pmr4UhRsPFSQ4R/FaetcoNk2/5IFduEPyE=;
X-CID-CACHE: Type:Local,Time:202401041400+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:492358fa-fce8-4507-a364-d18c8b9b27f3,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:5d391d7,CLOUDID:8378f97e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:0,Content:0,EDM:-3,IP:nil,URL
	:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
	,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 3d93196caac811ee9e680517dc993faa-20240104
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 208096196; Thu, 04 Jan 2024 14:12:29 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jan 2024 14:12:28 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jan 2024 14:12:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HV72/sWrV9ohuppCD+Y7qY2FRgxxSmVwoPNiJUBYgNfCf5Lt6dYnjEpQ5FdAhEb+RoZECF71QN0Qlr9O1Db+1PjVhfHcEf+5mEm5zsNVxafxGF+VMPyA73vBICKbroR7xoBHu2WNAfeDowJfn6KuVm3iP04t2AJm/SyX+lWiWz9G90ZjQcz+3GlWP9yN89vmD0+r7aZkPht3/CUKyPLGmRfAdoD3EbU4XikyMGcAmMiNDNvTEvCzgSL9guJDxP0LVq5N+MH2l5x4vjIbfao54/UHlJk+KGDBnl3M6D6pDGMIH6wPY7pHc6zL/t6O4rfmijSIHmLoHq64u4dJdDY5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pf/kO4WtGM61Jj1D5PQ/9bVy7L/Z+IaVQXCSNvkIdhU=;
 b=muvupkwjBgRNgHA+D1ZN6ebkqkHtKIzn3jyFVaESkUqe8LYTGakt08PizVFjF8hb1f5778ZDSdMQnO19871dvLu/P998IaRPSUDRQfPjVQQvy5K3fk+X2wI2EEEY4RGghPZltxSlA4jLmuxtFJORbE9cHtg8+90gjzTcHqz6zXvUSWXE8T5flymCutZMKewBMnR7gTw2enhUnPXNsH9B/YJNaJJXodQDtq5HGSgxJlT8rUAFnfprk8KYzmcTSdfsZMtNw8oReOAn9PW7IIZm3xUv5FGhWHmO/07RX2xAH8YXUoKcPDWIIdOq21G04CZYlFJAM1FqyvFRo+5E0QEDHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf/kO4WtGM61Jj1D5PQ/9bVy7L/Z+IaVQXCSNvkIdhU=;
 b=lGN6Swt41uISufBIJKHRT1FAb6W90MLRYGmGM2auQg6nhuoJo7ZLiwcc6+5kInL3yaQXxGBtA/mbP883mFOVl7gJdoWwHCZXDPXBYSPUZChdbgkWK4gdkRclIKvy0lLi9nqzhTbonJ5Wngpc4h5bGEpYkyE7z0NVgjIIhZ3ycbs=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by TY0PR03MB6428.apcprd03.prod.outlook.com (2603:1096:400:1ac::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 06:12:26 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 06:12:26 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "mathias.nyman@linux.intel.com" <mathias.nyman@linux.intel.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	=?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= <Eddie.Hung@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Topic: [PATCH v4 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Index: AQHaOIpkcdKDXzmoj0eSssQ68oUiA7C+hIWAgAq0XIA=
Date: Thu, 4 Jan 2024 06:12:26 +0000
Message-ID: <b2d007ee05f34fc2865841744e89eba39ccf4945.camel@mediatek.com>
References: <20231227060316.8539-1-chunfeng.yun@mediatek.com>
	 <1718f25d-3274-3e4d-0cdf-72fda8788e39@linux.intel.com>
In-Reply-To: <1718f25d-3274-3e4d-0cdf-72fda8788e39@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|TY0PR03MB6428:EE_
x-ms-office365-filtering-correlation-id: b3cb24af-c4b3-4ffd-f22c-08dc0cec1fa0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HnfXtPxkCjXxjEUGlEoFB1cy/TR69vUr8hxVqWsBTULdYwFQOFPi8n9DjNxZOSQPqc61pu9E/dAfl09j8G3a3bYXH+X5LUJFVfX2MiZLpZ89tr9MiarvPX53Ygs6C32LakouinSE3yqnm6V9O3S4CVSkjQTiSpgGKmv4CnWCyj9zXPqj3cPrinzpWkzYN/FutTVNJRtxQAfmI5bA7xtaCMzL72RSBAKK5O2MdOIm0a0RUx57DjDn/5BeN0KPKLxbQWwAFZ9hB6aeTlt1sm5GLs3hQQ84o4BY7a8aGlhXCrUO63u0vU9qTvymU4D9npHL4sViAFj0eGjs78mGqfaKn4IaKmgeyfdY21vNttkK11TV/6PjLo9VxLyHo26S+kmZmnvPVmh7vm124cwtrfb/Qb3RkRbbjkwkOQET4TKr/66yzpW1QDJ1muR+Qn6Wul/icLJct8XkeHvm6SnBs6eSz+FUy/g1sXIXql5pcDZSB9wuFaAaGu/snbRpYPh5oZJsIRB/0lTR6rxPgf4l92jplXym78ukYA0Un+1Vc6tlRjPry1I05KFG8Y9DEXkhxktSONoANjjYR8NeLlz6qBGELmjXtYMtv8Ea0H8ow5yCKCNwDWqI+QBba4z/TutK2MGzpPKhY77+sQBZ9YyMBXBTr6Vj8Q9BuoZnLcRs3b4maYhNCPbSsw0D6eNVJ4eUGP7PAudMIjfKhCCpx73dAMQvXCFGdQd4aYtNNckV+QgodQI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39860400002)(230922051799003)(230173577357003)(230273577357003)(1800799012)(186009)(64100799003)(451199024)(7416002)(5660300002)(478600001)(8676002)(6486002)(6512007)(6506007)(86362001)(2616005)(26005)(71200400001)(8936002)(316002)(85182001)(36756003)(91956017)(76116006)(66946007)(66556008)(110136005)(54906003)(41300700001)(66446008)(64756008)(66476007)(38100700002)(122000001)(83380400001)(4326008)(38070700009)(2906002)(4001150100001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm5ta041ZXpEZS9mY2d1UGtreE5rZm5MUlFDSTYvU3M1MVZJZUtFVnZYUXM5?=
 =?utf-8?B?MWtjWFRyNHNwc3hPYlJ6ME5LWVJIVjdUaGhqQzFDQUQxSEdzUlVJVVZOSFdk?=
 =?utf-8?B?ZHg2SXNFNHZxQ2lmWkpQdGF5TUpETHNMMERzb3RrUFQxVDdLTU5WMzlTdHJu?=
 =?utf-8?B?YVN4eHhneVBHQmdhcVU3Ym1aWm42ZHlFWG8vM3dFUXZlU3dIZDhFSVJ3b2dF?=
 =?utf-8?B?WmpvNUcyWkpSTDIzYVNNMCtBRTJzWWEzT1djdDA5ZE9tMmRjdk80M1l1c1Vj?=
 =?utf-8?B?eW8xK3dwWXE3WE1TNjZaWHpEdDVab05MM3hVMzZFUFF2QklxNGJoMWRqTFIz?=
 =?utf-8?B?L2xobTAvWU9BYmdJZHlZYzRCU1M2eWNmQUo3dWUrYy9RTHJxYlNYZjhUeU1Q?=
 =?utf-8?B?b1p0cGxtRjl4b3BrNURvTW4wTERTVS8xOFBQMGFGbVZxYVQyQWlJalpMbmc3?=
 =?utf-8?B?b09zUEpScCtyZS9sUmlYeSt5eVlTU2tqeGdLNGU2bUt0MlJvRTlRa1FXVzFH?=
 =?utf-8?B?cG1aam9KVG5PN25pNitNMHFQbU9wQTlKZDZBSjNaS1NjTkJIK3FZZTFSMkRq?=
 =?utf-8?B?N3FmWUYvTTRZMTVDdlhkN2tEY2x1WGNoeExoQ2Y3Y2xtUXVQN3M0QnlENlZj?=
 =?utf-8?B?SmNCZitiYlp0TFV2T0drdjFYNnJNdEJrRXJuQklEQjVBZkdvNmpFTWordEtp?=
 =?utf-8?B?WXpkRzhWUkR1WjczYnp6S3NZRlJreXFLR1pzVDR2VTd0dnEvRnlUWDRickNv?=
 =?utf-8?B?WklsRDIwdXlPYmlOWjdFemxnYkhROE9XRFM4OTVramVQejEzTW05ZUUzdEx1?=
 =?utf-8?B?T1I4UDE0WmZUZzhhV280bzJlb2pjMEJYb1M1dGRyNGs5eW00SldLa3hyalZm?=
 =?utf-8?B?ZTBGYStxdHo3LzNVcnp6UW9JakVoQkx3MkFxRVdGMy8yUHdlWjZoTG45SFNK?=
 =?utf-8?B?b29oU01CTmV5bkV2VmxHQUN4N1V2eFRiaFdaam9ySE1mMWJTdTdCaDBZT2sy?=
 =?utf-8?B?YmY2bUNKK2h2ODlRWk93MkhNMzk1eWtQZUR3cXYvMUh3T01KdWFQazdzUThN?=
 =?utf-8?B?eTZScWNNWEJqWDF1bEZoRHJQUnhnbDVBS1J0UUt6M2RKZVdDcEo4QndTZjlp?=
 =?utf-8?B?U2c3dld0WmlkdElINXZzVkNqeXplZVIzcGw1OHdCYzV5OFNHWnpFb2xJWDhH?=
 =?utf-8?B?dHBKcjRTMmZpYUlTYld4aXNaVFdnUGJWV1lhK0c2TzFiZU5SaGtYWTlzWnhz?=
 =?utf-8?B?aE5pOFZMcS9RVGhuUUFsQ3d2S0ZYZTg1Q1FFUmlLaFZLcnNLRyt6SkZNU096?=
 =?utf-8?B?QjJNb0h3MnBqdWlvWVZHSHI0TnFGMlMrWXphNlhwRUVJbk9BNFYraXRxYW54?=
 =?utf-8?B?cXdSMmExSXBMQXlsSHJXTnVOSk80MENCUU1PWnFiYVJscll4UXhCQkJnSUpj?=
 =?utf-8?B?REt4eXVpdGtVU2FjMjgvQmJhQVljQnJENHZFd2J4eG5xenpSQmltZVFMcjBB?=
 =?utf-8?B?WXdWOStUeTJVenFicUo2NDB2U0FLS2ZxMXhZTTVlUVVUcWJYZFN0TCtkQ01L?=
 =?utf-8?B?bDZlMTZCdEp1eU5hVHkrYTNzVzAxVGdQVXZtRmUyWUx0RnhlTEVjSWRqNFZM?=
 =?utf-8?B?bm1KaEdRMmFDVmYzQnlJOFZ5S2N1TGZUbm5qaW03STFscUhCYVpTMGtJVWNZ?=
 =?utf-8?B?RkJDMHpxY1kwUkk2alJUSnA3ZFdiVEdYUmp1UkQvUS9rZHpkVG5HRm9yV1RS?=
 =?utf-8?B?V2dhVVJGYjZrU0lhQmhIVnBKU2lJbHI1QVN2QWV4MzRZY0FjU0dtY1o2VXQr?=
 =?utf-8?B?a2RZQWFpU2lKQnFqaFdjSDNYMGt1T3ZFZkdaNkNFazc2QzEzcXFQekh2L3Bq?=
 =?utf-8?B?dU16MktLOG9wWVlLazZCUUY2cGdYeGpXUytlTk9GTnhadUFXK1F3eVYvZW1F?=
 =?utf-8?B?TTh5ejNqQU9qTlZ2U0tJSUd4VXJaS3lIdWRRR3VYcXAyVmgycE45L0ZmSVZm?=
 =?utf-8?B?RFVzTXdIRzc5TmMrM0xZN1Q3MFJ4SFBFZEM0aHdyYjdGYWVKc1RTRndlMFZ1?=
 =?utf-8?B?MUh6QzFRWXlidFJRMzA5c043d1NLVUtGM0N6cDFLWVRWRDBCdjNTbkhYOVVV?=
 =?utf-8?B?L2p3MEpPckNVdEpGUllmdEc1RUpuM1Fndmk1Z3JLRGpwbm9LRXdnRWtuMnBV?=
 =?utf-8?B?emc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5E0DF7179EAD54CA94852CAF6EDDA9C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3cb24af-c4b3-4ffd-f22c-08dc0cec1fa0
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 06:12:26.2005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qQYoa/HvgAAjEWsyTZjLwQjS4yPANfkzTdJublBLN8TcNL+4bn7z+nu5ASqagPoAxXoxUY+lyNbTpY1bLp6n3sMTm4JBhfB9MR31XI7+22M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6428
X-MTK: N

T24gVGh1LCAyMDIzLTEyLTI4IGF0IDEyOjQ0ICswMjAwLCBNYXRoaWFzIE55bWFuIHdyb3RlOg0K
PiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9w
ZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0
aGUgY29udGVudC4NCj4gIEhpDQo+IA0KPiBPbiAyNy4xMi4yMDIzIDguMDMsIENodW5mZW5nIFl1
biB3cm90ZToNCj4gPiBGb3IgR2VuMSBpc29jLWluIGVuZHBvaW50IG9uIGNvbnRyb2xsZXIgYmVm
b3JlIGFib3V0IFNTVVNCIElQTQ0KPiB2MS42LjAsIGl0DQo+ID4gc3RpbGwgc2VuZCBvdXQgdW5l
eHBlY3RlZCBBQ0sgYWZ0ZXIgcmVjZWl2aW5nIGEgc2hvcnQgcGFja2V0IGluDQo+IGJ1cnN0DQo+
ID4gdHJhbnNmZXIsIHRoaXMgd2lsbCBjYXVzZSBhbiBleGNlcHRpb24gb24gY29ubmVjdGVkIGRl
dmljZSwNCj4gc3BlY2lhbGx5IGZvcg0KPiA+IGEgNGsgY2FtZXJhLg0KPiA+IEFkZCBhIHF1aXJr
IHByb3BlcnR5ICJyeC1maWZvLWRlcHRoIiB0byB3b3JrIGFyb3VuZCB0aGlzIGhhcmR3YXJlDQo+
IGlzc3VlLA0KPiA+IHByZWZlciB0byB1c2UgM2sgYnl0ZXM7DQo+ID4gVGhlIHNpZGUtZWZmZWN0
IGlzIHRoYXQgbWF5IGNhdXNlIHBlcmZvcm1hbmNlIGRyb3AgYWJvdXQgMTAlLA0KPiBpbmNsdWRp
bmcNCj4gPiBidWxrIHRyYW5zZmVyLg0KPiANCj4gSXMgaXQgYmUgcG9zc2libGUgdG8gZGV0ZWN0
IHRob3NlIE1lZGlhdGVrIHhIQyB2ZXJzaW9ucyB0aGF0IG5lZWQNCj4gdGhpcw0KPiB3b3JrYXJv
dW5kIGluIHRoZSB4aGNpLW10ayBkcml2ZXIgZGlyZWN0bHk/DQp0aGUgdmVyc2lvbiBpbmZvIGlz
IHNhdmVkIGluIElQUEMgcmVnaXN0ZXIsIHdoZW4gc3VwcG9ydCBkdWFsLXJvbGUNCm1vZGUsIHho
Y2ktbXRrIGRyaXZlciBjYW4ndCBhY2Nlc3MgdGhlc2UgcmVnaXN0ZXIgd2hpY2ggYXJlIGNvbnRy
b2xsZWQNCmJ5IGR1YWwtcm9sZSBjb250cm9sbGVyIG10dTMgZHJpdmVyOw0KYW5vdGhlciByZWFz
b24gaXMgdGhhdCBzb21lIGNhc2VzLCBlLmcuIGNvbm5lY3RlZCBhIG9uLWJvYXJkIGZpeGVkIG1h
c3MNCnN0b3JhZ2UgZGV2aWNlLCBkbyBub3QgdXNlIDRLIGNhbWVyYSwgaXQncyBiZXR0ZXIgdG8g
dXNlIHRoZSBkZWZhdWx0DQpyeC1maWZvLWRlcHRoOw0KDQpUaGFua3MNCj4gDQo+IFRoaXMgd2F5
IHdlIGNvdWxkIGF2b2lkIHBhc3NpbmcgYSBuZXcgInJ4LWZpZm8tZGVwdGgiIHByb3BlcnR5IHRv
IGl0Lg0KPiANCj4gVGhhbmtzDQo+IE1hdGhpYXMNCj4gDQo+IA0K

