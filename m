Return-Path: <linux-kernel+bounces-24194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A375682B8CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 01:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197A71F23F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5791010EE;
	Fri, 12 Jan 2024 00:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="dIMKtZ9I";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="d7E/OZvu"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC2657;
	Fri, 12 Jan 2024 00:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b696f73eb0e511ee9e680517dc993faa-20240112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=e6cI6CCcRmw4zAZLL26n4FrhOTMeMcZGjMtsTz+LfhM=;
	b=dIMKtZ9IN5nRXuBTZedS+pwQM360j601+HE5X6LT5egREYnandPUNOHyCDa0PWaDEO/hZyGm1tg0swcamSndNUYg1G5EClJwKYaqWzgKKu5xE5YaxcTW+mMVakxkOnKbjpU2F5iwOF8XluLebUl2ODGrqvcE9eXR5thJKCDeovU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:af1cab76-083d-477b-9cf7-0fc71e3e6d2b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:fce7288e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b696f73eb0e511ee9e680517dc993faa-20240112
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 217983386; Fri, 12 Jan 2024 08:58:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 12 Jan 2024 08:58:33 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 12 Jan 2024 08:58:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHL6/hqLnwYuNeQsn1CCJVRL/b4/jF+trPFJ9bozn/CK4feBVQU3+gtpXCVA8nLy7akD7iwbr8HNhGQFhb7CWIT5fLbi2YgFr+XrIYoF705bV3M4oTHUj1t+oLQKxPfsMMLiB+u9itH+KOV7ZggcMqBuXcRqAJw+HNNqkOSXh90y4XsWwyFG9dHT2Ii8V0HN7pkUSVYWAooYfbvqzUIVzICMIW8KWrJQNrM3pkiagM14jcusceBLUhSk37mQjqyFzwd/ptAFR7j1XhGNld6wCAmPYhfEv8hrSXF8An/3hPVftKYtPQo5ImekgrnP7SP1zrCU+b2LFmp0bFSi524qwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6cI6CCcRmw4zAZLL26n4FrhOTMeMcZGjMtsTz+LfhM=;
 b=h9v7lnk0FJ5Bd3lMUZ2asT58YrsqqW5pGTA9qkrKO8rfnk+LpCKs6gm4bBF2PIGNuAX2R/LDWyPN7S6ICaXSbNCmHfQn4wz9nQ6RS1P66n8hsJU/thLgTCFuwhiGZgd/eEqEmVFUtPJ2hypSZei2mxT2q2KPgmT8BY1u4gN2EHiphJ2Nt642pQaytF+vhT8uo4LJQUiypxR98WodbhVLWezhCQsB1zFqYfz/K1GTkCq737/Y5xXsRJfXzQ/1dcigLfx0cVft3fVTL5idVUVH2dDj+stsH4//IFI2NVQ0vlWE8EIGo9QfnEO+Ad7Wk5PSnqQOqKfJl3bOekTJ8aU8BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6cI6CCcRmw4zAZLL26n4FrhOTMeMcZGjMtsTz+LfhM=;
 b=d7E/OZvuowz2rmwaA5HG6qhAVfhNB/Rr3Ok4AaORDVXCyJ0/qgO7BlENCm6Esn6OIjY8R6ApeS3Sx/pdebhtS8A2QHj4MJrwIvoycc3o64CkuIzypAFUH4sJ9WCeJanBMH+Uaqgvn1mrk5hfa7DoKi27QyXjnv2Z/MnBSSCE3Go=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8468.apcprd03.prod.outlook.com (2603:1096:405:5e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 00:58:31 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 00:58:31 +0000
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
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, =?utf-8?B?TG91aXMgS3VvICjpg63lvrflr6cp?=
	<louis.kuo@mediatek.com>, "laurent.pinchart@ideasonboard.com"
	<laurent.pinchart@ideasonboard.com>, "fsylvestre@baylibre.com"
	<fsylvestre@baylibre.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "pnguyen@baylibre.com"
	<pnguyen@baylibre.com>
Subject: Re: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Topic: [PATCH v4 4/5] media: platform: mediatek: isp_30: add mediatek
 ISP3.0 camsv
Thread-Index: AQHaQ8+pgBL6pTKEqkml+zYix0rfyLDVXUsA
Date: Fri, 12 Jan 2024 00:58:31 +0000
Message-ID: <e78658d63676d86ddd499ffa636cefbacb09c8ac.camel@mediatek.com>
References: <20240110141443.364655-1-jstephan@baylibre.com>
	 <20240110141443.364655-5-jstephan@baylibre.com>
In-Reply-To: <20240110141443.364655-5-jstephan@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8468:EE_
x-ms-office365-filtering-correlation-id: fc076654-cea1-4ac2-6f69-08dc13099881
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rwp/9hUHvDrLOn55UPOWP1zSMFndOauasXRJR63nrvmXXlaDGjxicBbbtHAI92yBGvtGICyyLFi5xplHojTMbLOrEamGM8d2G5/gHn/TvHPXg7RT3la9wTNp8JvFSglUYt/CTS+1laj81gEb3NmTOumIqloj1ifbdPOs3BeLUFNbsuSQ80bLFwDop6Rq1uJm4xVH9ItOTEDtPlXlrROEITvj3LqTdZpIpnGndnuobijmnHzkxc7d5bWj1nS524YKxA/WgHU96PPH8TjhRxDdPR46Twcl8f/EX1qKXmH6QykamgIKjWnP0/X2ZDp8rs58mr77NrF5UQx/AwSxs4IhMWji6aZgmu2rmUtqTPpxaj8PPOP9EqfLp3+bW38fH8CV78DCyaNtpcAfDMoMSX8m1UIc4FxLTF8JNbgV/hPRBfAaBoPD4B9zR2MvmUTLsvgBopPJQTBjX+HUfyHTNz35j0xCVa8Ep/1VkpD5ofxlwZYDVOsvFlqtAZ1EX/MBsaaisAxwPVte2PX0S6/6oNTd5FZ/nT+NLyTQHBlwbd8rsHUAYVwHC1twO3qMLXmPsPp3ZQ9yJLfXe4cY2UVyD0E7r9OVVkvWGcST7miV5XhNWrGDz91uaYhaNanc5YuNWEBMh6o13SWSY2G0QDSJRoZhxYTZSsnhPnkBSlgJ+oZujn0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230173577357003)(230922051799003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(2616005)(26005)(71200400001)(41300700001)(38100700002)(122000001)(66476007)(66446008)(76116006)(54906003)(64756008)(66556008)(66946007)(6506007)(316002)(6916009)(5660300002)(7416002)(2906002)(6512007)(8676002)(8936002)(4326008)(6486002)(38070700009)(478600001)(86362001)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGtlVkdVTmpJTElZM2M4THdlMzRSaVJlMVFJSWxoeStvSUpNVmdrNXRYSUZp?=
 =?utf-8?B?YTdTcEo1M21kSENDQXBlOUpFbTE3L2h4bHBSVXZ4bzFLYW44RXhFSjBDUE05?=
 =?utf-8?B?SkEwOW1zZFdLQUZYV3dJYmgzK3p0Wm5kTDFlbm9QMzZ4VXdpQjlEVG5KVE1C?=
 =?utf-8?B?dGlNWG05Smg4T0dSL2VOekxyZm9reEl6UlRST0J4RCtEZVNiTVJOR0NVYzNl?=
 =?utf-8?B?N2F0STlaV3pUQ1JIa2NiYjNycS9iV3dHRXV6QWJ1d2dKZk5VZUE1cStkamty?=
 =?utf-8?B?b084Vm1KemhyOEI0bnRzOGp0NFoxM0FSMHhPcklXMUNzTmNQOTQrYnlaTXdn?=
 =?utf-8?B?UXp3QWl1SDFwT3luSy9rVmE5ZEJmYTAvbWc0SHExaEdWQjZRS3BrRm1pc2ZS?=
 =?utf-8?B?OGRaaW1MNmwzcUhGZGN2bGZVMDQ2NlhBVGIrazJlNS9aVDZjdnAwK0p0d01r?=
 =?utf-8?B?dElXejY4eWhiVmhpT0YrZ0FTN0pJczh2TG4zaDZ4SGU4Q2o4MkdGQUNYM2V5?=
 =?utf-8?B?RkxEUmpQNmxSeDNLS1RaQzE5VmxycXRsR0xsOENBbWpSZUU5WkhSbXZQNDlj?=
 =?utf-8?B?cVo0YmJ3Vll3dzRmZzFuQU1yaVZ0TEk5Tzd0WDhOSTVUb2R1aHV2T2pqWnVX?=
 =?utf-8?B?L04rOCtlQ3JiUzk5clRhWENibGlHUEZhZlRtRStHUi9Pa1ZBY250NDVVYXJV?=
 =?utf-8?B?bGhPNzBoVFpiQXh2TVhreXdlenhUT0J0c1lHY3JsUTVaeHQ0L3VMSmhvc0Nh?=
 =?utf-8?B?SUgrRXZCUVplYkJ5Q3dubTNIb1lqeituWDFzeHZ4ZW5RaGlRLy93VllaTnJo?=
 =?utf-8?B?SkhDeEJjZW01N2ljM1NBZFpHcEx0QnRQMXJUS3FsMGVpRW91azVFR0xTWFJD?=
 =?utf-8?B?ZTVCelpmc1JTd1docjhlak5WOWVXb1J4VUFYVEhSOWlXSE0zd2hoK01rTmE4?=
 =?utf-8?B?NDNEcnNUU003dlZ0dlIwK0drQjUyOCtDbjlxTC9oTkJ4NitBT0dtcXdDNGtq?=
 =?utf-8?B?MzFJNlA2TEVCVFEyNlYwUzRVcTF4TGljWjk2QWVaZjlJQXhNb01FcWQrVzEz?=
 =?utf-8?B?STcyOSs4S1JSUEd2YzBoUkN2S0F6R0kzeVg0YVFaVkh6L1d6UlgrdlFIN25k?=
 =?utf-8?B?Mjl4MGJ1NVgwR2o1U3MwYy92aDVKNXRaRTlNVldjL1VrZ1k4QzdoR1dzVUQ5?=
 =?utf-8?B?RnM3bTEvL09MVG81WDNtSkorVDUvaHg1T2lMZElmaXp0UnJReHd6U280a1hX?=
 =?utf-8?B?RmgvYnpBb3VMMU81THkrc0tUWjUyMTMydk8zWkdVYktHWFU5NVlMVmJmeFIv?=
 =?utf-8?B?SldBSnNaL2RqY3I2RGlBK09pOEllVkUvNW1OZldUVUswUXB2R0lhOCt0ak1v?=
 =?utf-8?B?ZUd4Tm1nNjdoZ3VaS3RaaGJTMTkwZXc0dldvZURNSDlsTkFNcWZNWHRQSDFX?=
 =?utf-8?B?amFVNzNhTkF1NVlwRUR4NUhtd2ZkZ0JhMHVPd2k5dlJMNER5eU5maDRPbWVQ?=
 =?utf-8?B?eDNqRDNkcVRuMjc0MlBUbWg0Y2tYRHp0OU81eXNrL3dxRUUxdVg3SEFTZXBa?=
 =?utf-8?B?bGdxaUl2UDQyalFSbDdjek5UNDFaWnY2ZFFVeDJqbTFKTHk1UnpjN2NGblBZ?=
 =?utf-8?B?NlhmaHRvakorT3QwaHp5STd6T0tqbUFyMHo2VDAvc1RRTUQrS3p4RmFHWC9E?=
 =?utf-8?B?cDFnZVA5NTVPNHpETnFibk0zQjl6RVRYTkNKNnpJTWJYQ2Roa1RqQ2pTMHBk?=
 =?utf-8?B?VFpnM0ZUQkRpNVNXdnRCc2NrdG9ZRklpbkxlNy9jSzA0dUZ1b1dJUVFqZThs?=
 =?utf-8?B?ZlZCQURWYkdXTE5UTGVsVU1sb2pmZTFURnp4K1lKbXJZcEhOekkwaFpmeWpo?=
 =?utf-8?B?d3dZZk5UZjdmdHo5b2VnWUZMdFFYUEV6UmVlQitndGl0cDBLRG9uVVNXZXJZ?=
 =?utf-8?B?ZjVmUVY5WnZLbHNXeDRQdllLc204WUNHSE5nRXVtMXNBSDNTL3YvcUtaYkZV?=
 =?utf-8?B?UlF1T1FCenFjdjJNczFKY1l5OEJ1YjVGUjBGZ3dOV1AvN2hiOVF3M3JJWkJY?=
 =?utf-8?B?ekpVNEMyaUwrMXJWU0RZYjFTeTlmZCtUMHN5UTgzVklLdnAyNVMxSmIvZTNm?=
 =?utf-8?Q?56dIPJV7Zp9JPWpz6d95rmQu5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5DB92DB52FAE6E47A882DAAA56166ECE@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc076654-cea1-4ac2-6f69-08dc13099881
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 00:58:31.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RubDd2vIex9dnVXI8KtBUt11AT6hLfkQJeEYsHz7yaNRZ5JPwxaK5NFqa/M78kZq8d9nTqdAPKzNz9f4HYupEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8468
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.854000-8.000000
X-TMASE-MatchedRID: vEvJ7Rh1lGgOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
	qIY+/skQkABPgKBt/0r/XD0CNJ3fxO4dcT3ZaTocyYHhs0mgDoxyETzgIO4sasaQTVtPXXNM8ha
	W4U9IrFq4+90dmk+Zo6U1g9lh+I50imxB5lXt794jRwcsjqWGAtvhKQZ2RM31yWCL+8tLbvZd0A
	vwubNGarwujwzWn5JPHg8wGPX6M03xVhA9+h9R2oGU23hVIa8hfrTt+hmA5bLFJnEpmt9OE/z8v
	ajouc6XLlx4AK+9x+06OPBWq+5S+ZQxl2LaGeYAHPYwOJi6PLm7nrAU9KQxUZ0Koq3EzpuHUCUR
	iGfUE24S8rHMSL0a8dZ7rGD1hsHWUW22dI8YBTqeAiCmPx4NwMFrpUbb72MU1B0Hk1Q1KyLUZxE
	AlFPo846HM5rqDwqt3Zr5HLkeu2pRTVKea7+e0cUQpxCpcsgDit3VHNIMQdaADvDq3tlciQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.854000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	8F58043FBB12D665A01F068EB90E8A8B5FB5611AB6482889B8D0A17BEBB7DD272000:8

SGksIEp1bGllbjoNCg0KT24gV2VkLCAyMDI0LTAxLTEwIGF0IDE1OjE0ICswMTAwLCBKdWxpZW4g
U3RlcGhhbiB3cm90ZToNCj4gIAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVk
IHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ICBGcm9tOiBQaGktYmFuZyBOZ3V5ZW4gPHBu
Z3V5ZW5AYmF5bGlicmUuY29tPg0KPiANCj4gVGhpcyBkcml2ZXIgcHJvdmlkZXMgYSBwYXRoIHRv
IGJ5cGFzcyB0aGUgU29DIElTUCBzbyB0aGF0IGltYWdlIGRhdGENCj4gY29taW5nIGZyb20gdGhl
IFNFTklORiBjYW4gZ28gZGlyZWN0bHkgaW50byBtZW1vcnkgd2l0aG91dCBhbnkgaW1hZ2UNCj4g
cHJvY2Vzc2luZy4gVGhpcyBhbGxvd3MgdGhlIHVzZSBvZiBhbiBleHRlcm5hbCBJU1AuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBQaGktYmFuZyBOZ3V5ZW4gPHBuZ3V5ZW5AYmF5bGlicmUuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBGbG9yaWFuIFN5bHZlc3RyZSA8ZnN5bHZlc3RyZUBiYXlsaWJyZS5j
b20+DQo+IFtQYXVsIEVsZGVyIGZpeCBpcnEgbG9ja2luZ10NCj4gU2lnbmVkLW9mZi1ieTogUGF1
bCBFbGRlciA8cGF1bC5lbGRlckBpZGVhc29uYm9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6
IExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbT4NCj4g
U2lnbmVkLW9mZi1ieTogTGF1cmVudCBQaW5jaGFydCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29u
Ym9hcmQuY29tPg0KPiBDby1kZXZlbG9wZWQtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBi
YXlsaWJyZS5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0KPiArDQo+ICtzdGF0aWMgaW50IG10a19j
YW1fdmIyX3N0YXJ0X3N0cmVhbWluZyhzdHJ1Y3QgdmIyX3F1ZXVlICp2cSwNCj4gKwkJCQkgICAg
ICAgdW5zaWduZWQgaW50IGNvdW50KQ0KPiArew0KPiArCXN0cnVjdCBtdGtfY2FtX2RldiAqY2Ft
ID0gdmIyX2dldF9kcnZfcHJpdih2cSk7DQo+ICsJc3RydWN0IG10a19jYW1fZGV2X2J1ZmZlciAq
YnVmOw0KPiArCXN0cnVjdCBtdGtfY2FtX3ZpZGVvX2RldmljZSAqdmRldiA9DQo+ICsJCXZiMl9x
dWV1ZV90b19tdGtfY2FtX3ZpZGVvX2RldmljZSh2cSk7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2
ID0gY2FtLT5kZXY7DQo+ICsJY29uc3Qgc3RydWN0IHY0bDJfcGl4X2Zvcm1hdF9tcGxhbmUgKmZt
dCA9ICZ2ZGV2LT5mb3JtYXQ7DQo+ICsJaW50IHJldDsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdz
ID0gMDsNCj4gKw0KPiArCWlmIChwbV9ydW50aW1lX2dldF9zeW5jKGRldikgPCAwKSB7DQo+ICsJ
CWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBwbV9ydW50aW1lXG4iKTsNCj4gKwkJcG1fcnVu
dGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2KTsNCj4gKwkJcmV0dXJuIC0xOw0KPiArCX0NCj4gKw0K
PiArCSgqY2FtLT5od19mdW5jdGlvbnMtPm10a19jYW1fc2V0dXApKGNhbSwgZm10LT53aWR0aCwg
Zm10LQ0KPiA+aGVpZ2h0LA0KPiArCQkJZm10LT5wbGFuZV9mbXRbMF0uYnl0ZXNwZXJsaW5lLCB2
ZGV2LT5mbXRpbmZvLQ0KPiA+Y29kZSk7DQo+ICsNCj4gKw0KPiArCS8qIEVuYWJsZSBDTU9TIGFu
ZCBWRiAqLw0KPiArCW10a19jYW1fY21vc192Zl9lbmFibGUoY2FtLCB0cnVlLCB2ZGV2LT5mbXRp
bmZvLT5wYWNrZWQpOw0KPiArDQo+ICsJbXV0ZXhfbG9jaygmY2FtLT5vcF9sb2NrKTsNCj4gKw0K
PiArCXJldCA9IG10a19jYW1fdmVyaWZ5X2Zvcm1hdChjYW0pOw0KPiArCWlmIChyZXQgPCAwKQ0K
PiArCQlnb3RvIGZhaWxfdW5sb2NrOw0KPiArDQo+ICsJLyogU3RhcnQgc3RyZWFtaW5nIG9mIHRo
ZSB3aG9sZSBwaXBlbGluZSBub3cqLw0KPiArCWlmICghY2FtLT5waXBlbGluZS5zdGFydF9jb3Vu
dCkgew0KPiArCQlyZXQgPSBtZWRpYV9waXBlbGluZV9zdGFydCh2ZGV2LT52ZGV2LmVudGl0eS5w
YWRzLA0KPiArCQkJCQkgICAmY2FtLT5waXBlbGluZSk7DQo+ICsJCWlmIChyZXQpIHsNCj4gKwkJ
CWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIHN0YXJ0IHBpcGVsaW5lOiVkXG4iLA0KPiByZXQpOw0K
PiArCQkJZ290byBmYWlsX3VubG9jazsNCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiArCS8qIE1lZGlh
IGxpbmtzIGFyZSBmaXhlZCBhZnRlciBtZWRpYV9waXBlbGluZV9zdGFydCAqLw0KPiArCWNhbS0+
c3RyZWFtX2NvdW50Kys7DQo+ICsNCj4gKwljYW0tPnNlcXVlbmNlID0gKHVuc2lnbmVkIGludCkt
MTsNCj4gKw0KPiArCS8qIFN0cmVhbSBvbiB0aGUgc3ViLWRldmljZSAqLw0KPiArCXJldCA9IHY0
bDJfc3ViZGV2X2NhbGwoJmNhbS0+c3ViZGV2LCB2aWRlbywgc19zdHJlYW0sIDEpOw0KPiArCWlm
IChyZXQpDQo+ICsJCWdvdG8gZmFpbF9ub19zdHJlYW07DQo+ICsNCj4gKwltdXRleF91bmxvY2so
JmNhbS0+b3BfbG9jayk7DQo+ICsNCj4gKwkvKiBDcmVhdGUgZHVtbXkgYnVmZmVyICovDQo+ICsJ
Y2FtLT5kdW1teV9zaXplID0gZm10LT5wbGFuZV9mbXRbMF0uc2l6ZWltYWdlOw0KPiArDQo+ICsJ
Y2FtLT5kdW1teS52YWRkciA9IGRtYV9hbGxvY19jb2hlcmVudChjYW0tPmRldiwgY2FtLQ0KPiA+
ZHVtbXlfc2l6ZSwNCj4gKwkJCQkJICAgICAgJmNhbS0+ZHVtbXkuZGFkZHIsDQo+IEdGUF9LRVJO
RUwpOw0KDQpEdW1teSBidWZmZXIgY29zdCBtdWNoIGluIERSQU0gZm9vdHByaW50LiBJIHRoaW5r
IHdlIGNhbiBnZXQgcmlkIG9mDQp0aGlzIGR1bW15IGJ1ZmZlci4gSWYgbm8gYnVmZmVyIGlzIHF1
ZXVlZCBmcm9tIHVzZXIgc3BhY2UsIGNhbGwNCm10a19jYW1zdjMwX2Ntb3NfdmZfaHdfZGlzYWJs
ZSgpIHRvIHN0b3Agd3JpdGUgZGF0YSBpbnRvIERSQU0uIEFmdGVyDQpidWZmZXIgaXMgcXVldWVk
IGZyb20gdXNlciBzcGFjZSwgY2FsbCBtdGtfY2Ftc3YzMF9jbW9zX3ZmX2h3X2VuYWJsZSgpDQp0
byBzdGFydCB3cml0ZSBkYXRhIGludG8gRFJBTS4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwlpZiAo
IWNhbS0+ZHVtbXkudmFkZHIpIHsNCj4gKwkJcmV0ID0gLUVOT01FTTsNCj4gKwkJZ290byBmYWls
X25vX2J1ZmZlcjsNCj4gKwl9DQo+ICsNCj4gKwkvKiB1cGRhdGUgZmlyc3QgYnVmZmVyIGFkZHJl
c3MgKi8NCj4gKw0KPiArCS8qIGFkZGVkIHRoZSBidWZmZXIgaW50byB0aGUgdHJhY2tpbmcgbGlz
dCAqLw0KPiArCXNwaW5fbG9ja19pcnFzYXZlKCZjYW0tPmlycWxvY2ssIGZsYWdzKTsNCj4gKwlp
ZiAobGlzdF9lbXB0eSgmY2FtLT5idWZfbGlzdCkpIHsNCj4gKwkJKCpjYW0tPmh3X2Z1bmN0aW9u
cy0+bXRrX2NhbV91cGRhdGVfYnVmZmVyc19hZGQpKGNhbSwNCj4gJmNhbS0+ZHVtbXkpOw0KPiAr
CQljYW0tPmlzX2R1bW15X3VzZWQgPSB0cnVlOw0KPiArCX0gZWxzZSB7DQo+ICsJCWJ1ZiA9IGxp
c3RfZmlyc3RfZW50cnlfb3JfbnVsbCgmY2FtLT5idWZfbGlzdCwNCj4gKwkJCQkJICAgICAgIHN0
cnVjdA0KPiBtdGtfY2FtX2Rldl9idWZmZXIsDQo+ICsJCQkJCSAgICAgICBsaXN0KTsNCj4gKwkJ
KCpjYW0tPmh3X2Z1bmN0aW9ucy0+bXRrX2NhbV91cGRhdGVfYnVmZmVyc19hZGQpKGNhbSwNCj4g
YnVmKTsNCj4gKwkJY2FtLT5pc19kdW1teV91c2VkID0gZmFsc2U7DQo+ICsJfQ0KPiArCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmNhbS0+aXJxbG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJcmV0dXJu
IDA7DQo+ICsNCj4gK2ZhaWxfbm9fYnVmZmVyOg0KPiArCW11dGV4X2xvY2soJmNhbS0+b3BfbG9j
ayk7DQo+ICsJdjRsMl9zdWJkZXZfY2FsbCgmY2FtLT5zdWJkZXYsIHZpZGVvLCBzX3N0cmVhbSwg
MCk7DQo+ICtmYWlsX25vX3N0cmVhbToNCj4gKwljYW0tPnN0cmVhbV9jb3VudC0tOw0KPiArCWlm
IChjYW0tPnN0cmVhbV9jb3VudCA9PSAwKQ0KPiArCQltZWRpYV9waXBlbGluZV9zdG9wKHZkZXYt
PnZkZXYuZW50aXR5LnBhZHMpOw0KPiArZmFpbF91bmxvY2s6DQo+ICsJbXV0ZXhfdW5sb2NrKCZj
YW0tPm9wX2xvY2spOw0KPiArCW10a19jYW1fdmIyX3JldHVybl9hbGxfYnVmZmVycyhjYW0sIFZC
Ml9CVUZfU1RBVEVfUVVFVUVEKTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo+ICsNCg==

