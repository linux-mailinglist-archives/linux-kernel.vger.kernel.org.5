Return-Path: <linux-kernel+bounces-11773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F087E81EB7A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 03:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61AC11F215D7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 02:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EB12113;
	Wed, 27 Dec 2023 02:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DjLt7Alz";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="J9Uubepq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18C28FA;
	Wed, 27 Dec 2023 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: df7180f0a45d11ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=98+hrGM35faupzPMJ/50SNV2zgtHidOnMPJr3lJ5n5I=;
	b=DjLt7AlzjtByJ49MevYYEC83SkovZTi7G7BE5wc8iROe9Xna1QiHsRDwMy8XvMUNN+9hCUSXdgwxqE8bVs60yfJ3lRHLuLBUR3+1bZXvpnohrnd42hm/Qgi36jqeycVGRiU3MNGkmjK9i4lC86WTjCzqVA9wvSqdqVE9jT9hmRM=;
X-CID-CACHE: Type:Local,Time:202312271008+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:168701bd-3ba0-4fa7-ace8-11c579b092bf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:7ff8b37e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: df7180f0a45d11ee9e680517dc993faa-20231227
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2138443295; Wed, 27 Dec 2023 10:15:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 10:15:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 10:15:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auJIt0k4RtRvi/O/EPBPSU2hyqr0op80DGRvcsuNR2WWMgo2fQGRmGhsx8Z0kKtgwgiurVKNcneGaVECs5WLMAxOw0gAZNmBi0icIqjdDKnW2KcJz6P6zSWkHEl33joYkoKB/T0JUAE0WkXcCB4jAXy5NVr+/UMb2AOKm0qo6ziZp6HdJjhADuGCpMUeUZn0bi0WqiDGwqaNWnbOgKQAcWOKOiVbVhu1ecditzx6RkFe+JCElwUqCR6berD145CXEpGS8PEON8Ot2iJkmye1aHQjjnFedI37kQWT4PrrUneAj0UplZpeSriuU6SeOIJeU8DcmcFG91j9Si8PVixKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98+hrGM35faupzPMJ/50SNV2zgtHidOnMPJr3lJ5n5I=;
 b=no8gMX20lEpRV7zzIJwZamJqQOXDTN2NxBE9M6Ecx5hBoKG7W8HUuX5/VrIF9nBMYeDUuk2li7NqYR2pSKKWe5fBdwgLHDTnSf1gEcuOIfPKhN9DQXn8S9edjeP0ffhu01obgNTVNNoRUVtAfDd34BMUvN+m0YajlNgDKwyBauDc3lRx3X+NxCjs1obDDRKlB7dY45Mo41CSboBGLPTnp2QhZyL/mQ+KMw1WapDzboS2g3OA1I9aJ4ErFJhaWZQq2Wak1pBTbdp/xnxmjFC7nZzmCvGC6mvDqohfirYEl57ki92EQREYKv/V7iP5Mk5wdCUB+GkMc79PW6kErq0zGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98+hrGM35faupzPMJ/50SNV2zgtHidOnMPJr3lJ5n5I=;
 b=J9UubepqOzuOxxzGKSe9gAgWbyRXgmOWUJtJGC6fSc1RUBuaR+PR1UusQdoZxhfeMb/uHQmo7zxugAodyZWCkkhk6Hy5s1CAn4wtNe/wcmE4d4Mn5SgIcZCjNG2l++oRTXJWMslQLk3ErLAFImjSwUNmT+Ql3VRV/BX45TAiTmM=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by JH0PR03MB7981.apcprd03.prod.outlook.com (2603:1096:990:31::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 02:03:02 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 02:03:02 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
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
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Topic: [PATCH v3 1/3] dt-bindings: usb: mtk-xhci: add a property for
 Gen1 isoc-in transfer issue
Thread-Index: AQHaMvB01EmIj/BXvUeSxpJjUV7Ik7CxyRGAgAqisYA=
Date: Wed, 27 Dec 2023 02:03:02 +0000
Message-ID: <26766389b92dbc0996a7e9c461a2f27c790999fb.camel@mediatek.com>
References: <20231220025842.7082-1-chunfeng.yun@mediatek.com>
	 <c3d372f0-3d21-4500-96cd-9c88aaf5ce89@linaro.org>
In-Reply-To: <c3d372f0-3d21-4500-96cd-9c88aaf5ce89@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|JH0PR03MB7981:EE_
x-ms-office365-filtering-correlation-id: 6bb9860c-ecee-4ab1-efd0-08dc067ff54e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sNnVa9H4RFPg8kdYeBCrGNIAN4DifptCpMtrQ+iumohZXuQkP+JU/2RmzFvs+6UpK2/Lv4bbhyEF3H9AeV4LxVKG96ElmLJfB/PPHIvkOPxbU7889mfBqK2zg0K+xdnuUNUhVrG23sCRI6YH9LcP0+NFgUJqXjFEOBaelMQdovp63wGcqkFn/mVD+e8v4KFUBUPDqcwqsQs2uCB9EJSo9N9jqRrWJgT0VSGAbC/dZUrlIDEiPT67oUyJZMVBFFgrB2MLwGLZjeNxDKQuAa2TKZ2daWhl/xRc76vlPR9xynw2tA/YGQ3rcHM1KGXh3g8O6tdazzzh/tRpBWyTdwcbXpJmkeDngIV2gKRN7mR9Kti83pclSo6X1eGsWVS2Us4Edh2Y13FVLszsROBcUBgMPWDhIW5RJzZU4axnDmk7TH/Gxj5yeHIdCycy9vvgSdSt+5suhciJ7SYa18AgeNfg+NpZdueS3Cw25DMER7meRR3AZJj+hB6FvwudxbNZDAwCnpl0KNNAPrP5tca0KNSCz5V3vi7unqNMXCx8y6JI5/Oju/9FYStLoCbaEjttdDjiChYtCD3C2KDEk1ZVeJ5PcwdzDPAZkuuLZN1Q3LEe6dfZKEZyd7uSxWZ0T0ltKCikNJGbbn5c0l9tLU/m8ExCy7wjyEB6HyUGVbpWwE2EkPRkEaZf1h69nSwA5YKV6ReTRGisH313mZJ2BXAiiEizi1tdG1yaCgffySN133tGwlU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(136003)(346002)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(85182001)(36756003)(91956017)(71200400001)(6512007)(6506007)(53546011)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6486002)(38070700009)(86362001)(38100700002)(316002)(26005)(122000001)(83380400001)(2616005)(41300700001)(4001150100001)(5660300002)(2906002)(7416002)(478600001)(8936002)(8676002)(54906003)(4326008)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODVKUGN4UmRvNE45SGNPTitLaXRrTENuSWhYUjhvRGFtY21oYWU1bXhwS1dw?=
 =?utf-8?B?NGRvZmN1NmVlblhlQmRlTHVwQnVRMklYTnRIcDRieUFpYTFVT3BvL24vNkV1?=
 =?utf-8?B?MXJRRkhwbjAyaHM1S2FwRk5jaHdqaG92Um1hV29RNUd6WTBieGlFaWhJcDNi?=
 =?utf-8?B?Sm92eUJuVjc5bG43dGFvbzNMblZVSzJOcGZqNWNUcGkrYTJFZnU2Mzh2UUc0?=
 =?utf-8?B?bUZydzR4d3psMnFTNlZTQktOK3AwK1lHMnNTUTJsMm12OFNBemZtZGNhdEZS?=
 =?utf-8?B?SThiNHhXS3pKZDFMMm9WYVRacXJMcUQxUCtWNEVVU1dnQXg5S3ArYTVhZGpw?=
 =?utf-8?B?N3dHZTY1VU9TT0N2MGI2S0UwZHBOOWc4Z0NBYVNwYTVrTFQxaGhBekYwMnFT?=
 =?utf-8?B?Rkk3OENyeVN0Q2hLd3FyUzd3dThDVHdoV3RkcXdEN3RnTXNrQ3Z2SzB6d2kr?=
 =?utf-8?B?V3dBc0FOci9tUGptaEwwOUp3L1JDUkVweHliYkN2WjRDS0RwOFRleXJ2dE5L?=
 =?utf-8?B?U2FEMmR3Nk05OC9wTXpBdXdZRGlhQTlMSEJNNWtZM01YYUJxNW0xblc5VGN1?=
 =?utf-8?B?NW8yOWsrVi80Z2p2WXpObUVDTmpHMURKb1lHNDdHN2c4NVgrMUhwemsrdGJm?=
 =?utf-8?B?UTdXL0lBWlVOQnE2TFJ3VXB0aFBjajRkSlEzWDNRTDlpc21QQ0JEenVTL0ZT?=
 =?utf-8?B?MXRGS1E0TTZpWEp6eE54SHdZT01Fb1Yya3BnbWMrZlhMcVFLL3NjeFFOazFS?=
 =?utf-8?B?S0pFQW9ZT3I3eHprRzZTOFNKWlRJWFRIeTJveDYrYUQ0eG9uNWZicFVIZGIy?=
 =?utf-8?B?Mmd2MVhmL3ZRMnl4ZHgyZjhveXFibmYxMHR6ODdOS1VQOWdZWTRWcHNLVDc1?=
 =?utf-8?B?Sit1UXhBVVk3dzR4RmRJQkZFRy9KWG1Ma1ZWWWZFc3A0dldkL0pqVmtvUU1h?=
 =?utf-8?B?Si8xaGFsUTU5dmR2Zy85ZkRWTkZCWEFOVytxM2FIMHNraHNkTkdiOEowSVpZ?=
 =?utf-8?B?andQSm9TeTU4d285dDRXRmpwZjA2bVJ0ZmhiVU1NTk5oVE9vaFgzUTZmMG1J?=
 =?utf-8?B?K3ZrZTJrN2dITCtNTzVCL2hBOU0yNlk2ZFMrSHRPNjgyeWxyKzFqNHVTWUUx?=
 =?utf-8?B?bURtd2hTdDVrYWVOZFBvbm53L1dSUE5KQVB2UitvTlI5bUFSdjZGMWJsYno4?=
 =?utf-8?B?TytQWnFjOFNuZk9MS24rMTZpZWNXQXpuT0RJSy8vTHhrZnc2MjVucFJzZ1I1?=
 =?utf-8?B?L1JFQzVuNG1iRkV3WUh4a3JVQ1ZmenJ5TlFsV0NZTGdoZWFScG5rc2xWeHN5?=
 =?utf-8?B?ZkhUUUgycENsUG9PY3dRb1k1YmVwc2EwU1Bkb0dWMk13R3FNM1o2LzFqZFI4?=
 =?utf-8?B?MHJLL29GdTJuN25yZ1RMUVdTWHc2TWp3SjU0RnFBWHZZMlp3TXVxQUprbkJB?=
 =?utf-8?B?cG54ejBxdjR2ellQVXg1M3g4TkdJcC9sQnNzZW5kUnU4ZENOR28rWkFPS3Ey?=
 =?utf-8?B?dmFiKzdadWZ3cnFFa2E0eGJVLy9oNk4yMkMwMGd6bXNWVThTMFR5VzVhUDA3?=
 =?utf-8?B?WnVuRU5qUk1IcHN6UHdscFg3Szl0d3NlR01WWWFabWJCMWN6bGE3Z3EvUkJt?=
 =?utf-8?B?WnNMc0hrMEV5Yk5uSXJ5YjJPMElLS2lDcEt1M0FmMG1pM21TTEJrOXZIUTRm?=
 =?utf-8?B?cXpFa3hMaDFlakFKdHdoTzdiM3d1cDBmakIvMDV4K3paTU1OeDhGL1pvMk9j?=
 =?utf-8?B?QjVTM3R0VmVDTGtSTnN6SmpVMHpvWnJ6djQramtkc0V2bmU0SWYxeC9zMWdO?=
 =?utf-8?B?a1VGMW1NZXFtbytzck5GVzlkbTJJaml1ZjhrUDdvWmloNDNYck44MVNXRlFp?=
 =?utf-8?B?V3l3S2xuM2FHeDdFOGJzanVMVlNCb3NrM3l3S0QxWEN0WDFyMHNNT1Zsd3ZJ?=
 =?utf-8?B?N2VlNERKSks4c0xybTU0Wkl0Mkt2cW5tbFVpbS9hd21YNTFoYkJycm1Lem1F?=
 =?utf-8?B?cFNneERNKzRTbWxVL2l3ZWlXdHp3UTJBSlh5NzBxQ3RLdTFZYS9WV2lZTGdm?=
 =?utf-8?B?NFFjanI3dXFnaGc1czcwUE0yaVRMQVJrdHVadmxGdm40RGlnQkp5bkxzbjFu?=
 =?utf-8?B?SGtXSWRLUGRuR1pjWVpwMlNjUnI3a0pGNUoxUWllWi9CK3piWHBuQ0lsZ016?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ABA89D77077484AA270822FD3F83DEE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb9860c-ecee-4ab1-efd0-08dc067ff54e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 02:03:02.5727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8yMDR1QnvpWeLJiIFIpdt0g33gOsT7Mn9NI1Zd+J4yx4XH64nBz6kwhqdbxEpplpan83nyzmP7UvVf+FO5VvkFfcskoFA7+ZbKrXAAoB5Xg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7981
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDA4OjM4ICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOg0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtz
IG9yIG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRl
ciBvciB0aGUgY29udGVudC4NCj4gIE9uIDIwLzEyLzIwMjMgMDM6NTgsIENodW5mZW5nIFl1biB3
cm90ZToNCj4gPiBGb3IgR2VuMSBpc29jLWluIGVuZHBvaW50IG9uIGNvbnRyb2xsZXIgYmVmb3Jl
IGFib3V0IFNTVVNCIElQTQ0KPiB2MS42LjAsIGl0DQo+ID4gc3RpbGwgc2VuZCBvdXQgdW5leHBl
Y3RlZCBBQ0sgYWZ0ZXIgcmVjZWl2aW5nIGEgc2hvcnQgcGFja2V0IGluDQo+IGJ1cnN0DQo+ID4g
dHJhbnNmZXIsIHRoaXMgd2lsbCBjYXVzZSBhbiBleGNlcHRpb24gb24gY29ubmVjdGVkIGRldmlj
ZSwNCj4gc3BlY2lhbGx5IGZvcg0KPiA+IGEgNGsgY2FtZXJhLg0KPiA+IEFkZCBhIHF1aXJrIHBy
b3BlcnR5ICJyeC1maWZvLWRlcHRoIiB0byB3b3JrIGFyb3VuZCB0aGlzIGhhcmR3YXJlDQo+IGlz
c3VlLA0KPiA+IHByZWZlciB0byB1c2UgM2sgYnl0ZXM7DQo+ID4gVGhlIHNpZGUtZWZmZWN0IGlz
IHRoYXQgbWF5IGNhdXNlIHBlcmZvcm1hbmNlIGRyb3AgYWJvdXQgMTAlLA0KPiBpbmNsdWRpbmcN
Cj4gPiBidWxrIHRyYW5zZmVyLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IENodW5mZW5nIFl1
biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiB2MzogYWRkIGZpZm8g
ZGVwdGggdW5pdCwgY2hhbmdlIHRoZSB2YWx1ZSByYW5nZSBmcm9tIDAtMyB0byAxLTQNCj4gPiB2
MjogY2hhbmdlICdtZWRpYXRlayxyeGZpZm8tZGVwdGgnIHRvICdyeC1maWZvLWRlcHRoJw0KPiA+
IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLXhoY2ku
eWFtbCAgIHwgMTINCj4gKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNl
cnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiB4aGNpLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay0NCj4geGhjaS55YW1sDQo+ID4g
aW5kZXggZTk2NDRlMzMzZDc4Li45NDc4YjcwMzE3OTYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGsteGhjaS55YW1sDQo+
ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxt
dGsteGhjaS55YW1sDQo+ID4gQEAgLTEyNCw2ICsxMjQsMTggQEAgcHJvcGVydGllczoNCj4gPiAg
ICAgICAgZGVmaW5lZCBpbiB0aGUgeEhDSSBzcGVjIG9uIE1USydzIGNvbnRyb2xsZXIuDQo+ID4g
ICAgICBkZWZhdWx0OiA1MDAwDQo+ID4gIA0KPiA+ICsgIHJ4LWZpZm8tZGVwdGg6DQo+ID4gKyAg
ICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAg
IGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBJdCBpcyBhIHF1aXJrIHVzZWQgdG8gd29yayBhcm91
bmQgR2VuMSBpc29jLWluIGVuZHBvaW50DQo+IHRyYW5zZmVyIGlzc3VlDQo+ID4gKyAgICAgIHRo
YXQgc3RpbGwgc2VuZCBvdXQgdW5leHBlY3RlZCBBQ0sgYWZ0ZXIgZGV2aWNlIGZpbmlzaCB0aGUN
Cj4gYnVyc3QgdHJhbnNmZXINCj4gPiArICAgICAgd2l0aCBhIHNob3J0IHBhY2tldCBhbmQgY2F1
c2UgYW4gZXhjZXB0aW9uLCBzcGVjaWFsbHkgb24gYQ0KPiA0SyBjYW1lcmENCj4gPiArICAgICAg
ZGV2aWNlLCBpdCBoYXBwZW5zIG9uIGNvbnRyb2xsZXIgYmVmb3JlIGFib3V0IElQTSB2MS42LjA7
DQo+IHRoZSBzaWRlLWVmZmVjdA0KPiA+ICsgICAgICBpcyB0aGF0IG1heSBjYXVzZSBwZXJmb3Jt
YW5jZSBkcm9wIGFib3V0IDEwJSwgaW5jbHVkZSBidWxrDQo+IHRyYW5zZmVyLA0KPiA+ICsgICAg
ICBwcmVmZXIgdG8gdXNlIDMgaGVyZS4gVGhlIHVuaXQgaXMgMUsgYnl0ZXMuDQo+IA0KPiBOQUsu
IFJlYWQgY29tbWVudHMgb24gcHJldmlvdXMgc3VibWlzc2lvbi4NCk9rLCB3aWxsIGRvIGl0IHRv
ZGF5DQoNClRoYW5rcyBhIGxvdA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0K
PiANCg==

