Return-Path: <linux-kernel+bounces-475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DC68141B8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D245284AA7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB18FCA69;
	Fri, 15 Dec 2023 06:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ERx99Tl1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Z/CBrg6r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0B279E5;
	Fri, 15 Dec 2023 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 29c87c229b1111eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XR3SoF1Sx0PIJMLVSjU81pCnmO2poG/8nLG2jQ2whBk=;
	b=ERx99Tl1y1qjhllQFhTyxw/kuizG4tqP983P3PlHV31xIUHnxatZEuFXxyhSuhxCPYJQpcLcgUYSGug90DVes8VNRwUThh7llS76oCUUgWbyxMrARjlCCQ8XsVoOKESyhCqcXfAUpzhxWaJsSOW56zGuVZX1CsYiTBQZTPuYzvU=;
X-CID-CACHE: Type:Local,Time:202312151410+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:26e6b90e-fca8-4231-bf4f-41d8fe83567b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:6688b3fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 29c87c229b1111eeba30773df0976c77-20231215
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 68380914; Fri, 15 Dec 2023 14:14:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 14:14:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 14:14:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6sSDDFrpZllJo+kJ2QV/YgHjuEI3Xkzkiv32S0R5YbwmA6Lj2zJabeLHL3WHCpF6ZmmsbCyLCRbqmUB4tQOy1W0cWEmdgG05DN9ocfpBWsJlNiRbyaB8ZEmZzH34JzKd6uKQEcgi/3oQYUiWrwmI0VdraCX/EjIODi3MhxeKreEi4/zbitsBthAWhAw38hRwp3+vQPDD77AUm9BpOzvmzNXAyIaTxiXqb1RdmYNE1UhITjer2I2f9NUNTbEcAuueUA03bb2FEW/xTnrq/eID6fUcVd/B4D1bvkaVTxHodIYtpznt3ManTQV+MELzsSIrh8PQBbDFC7eoX7LV4Wz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XR3SoF1Sx0PIJMLVSjU81pCnmO2poG/8nLG2jQ2whBk=;
 b=lVH7vVPlzmRHTyt+LOL+mY44PhnENnAAOsCAl/Mh49ZLJO9WfTNUavfQ7+WwgKOCbtnplXwih5S1n62EfIB9tPelVZUqnQQfShgiMUZ8si7rOvERDVJqtC6q93rbpko0oknTPH51+7Q9YDzXuby70YJ3qMEE9kOyYVyWJvfi/XCrE8LJEImY44eZnrrkofyqMK1A0Q4O4UQc/LVn0HQT+zi3qHpHEZQ5CZxMZivv8g8da9pKp61qZceDLmXAHt/SlLHS+1H1f+gHAmPUmkLNUaZMyXr349SCL6HwYiSdaVr1eTSUVmtTGkBQlVPgjVYfHztMhXE5GEtFrH+gjM8ttA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XR3SoF1Sx0PIJMLVSjU81pCnmO2poG/8nLG2jQ2whBk=;
 b=Z/CBrg6rvUKfRXMx8sPW7WHgGxf26L3JjCBG01avHpDQNTPi7LDnALz6Lfcpq7PZqsQCvtrOJGL2TnTc7lyK7vtit7DkNjIbr2OsU6+s8lPPNEJ7/WBvNt8wJ3Jb+aZzlGENxMRlvH3EeKngn1CTyBWcTuSNJaDTGPY9dBdyud4=
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com (2603:1096:400:33c::6)
 by KL1PR03MB7078.apcprd03.prod.outlook.com (2603:1096:820:cb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 06:14:07 +0000
Received: from TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946]) by TYZPR03MB7153.apcprd03.prod.outlook.com
 ([fe80::75b5:9f6d:dc01:9946%6]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 06:14:07 +0000
From: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>
To: "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	=?utf-8?B?RWRkaWUgSHVuZyAo5rSq5q2j6ZGrKQ==?= <Eddie.Hung@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	=?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1
 isoc-in transfer issue
Thread-Topic: [PATCH 1/3] dt-bindings: usb: mtk-xhci: add a property for Gen1
 isoc-in transfer issue
Thread-Index: AQHaLY6dWSsEXZq+1E2EPlX2xQrPALCm20YAgAA1eYCAAs/0AA==
Date: Fri, 15 Dec 2023 06:14:07 +0000
Message-ID: <e2e9644e13a8c0bb6ab7a24011c98c784d3d9cb6.camel@mediatek.com>
References: <20231213063543.12435-1-chunfeng.yun@mediatek.com>
	 <c1bc144d-07d6-422c-8294-42be47f83e59@linaro.org>
	 <5327b2fd-94c6-46fe-b987-52cfff042033@collabora.com>
In-Reply-To: <5327b2fd-94c6-46fe-b987-52cfff042033@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB7153:EE_|KL1PR03MB7078:EE_
x-ms-office365-filtering-correlation-id: bd23abd2-7cda-4f11-d542-08dbfd350b8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vPZNjL6JT46aed040vhVKTVGTy4e1zUZdG2laLjseWNTlfWmJ1jzaptcGM+S/7n82iwOW7t6xs9+PaJ96eErltLxaBPBbDvi+iwUey34JQ9F6buu775TyDp/3rhuAmuUF6LIUoibHxO8Z3NxidXL+09pf8oIT1UJloKPBi+XD+G1sMQFusrmLHcbd+FruhJhKR/920qdK5pz9MOmcmmpieVa1E81hmCPwiJI+76lXiFnYSmlt1wHSE5MnXNWfDVm1V9Hv5rysG/FwewKijKG8rmPTKDbgrcj33U40bf6x9rky8z+bhODFHFNt5fBBOScU5mBpqYeDut9gZD+0mPqkRFjtBekOK9iQD8azo4+uk3ahJaNbhQc9UzVurNHEzVYqL0yflDk1FEiX8Lc94Rz20kHijylcBzIqF/yADsMjcZ/4CoFzUSe6qQXuRo7hevfRUBseHXKYH7WQLa7AcIntZ1rbRUDyf90ApwfWfrKeCfFNLbknBYlc73nnGzwbkIcxLpkQV3WdNXDxFYyJCE+PWdVyyjMPw7i81X/3qRE/jjKOCK/qYtHoRkNq36v919ii2YSJyJwz42VyLS75hrMGjB44cKwlCJ0uLy7LB0LHsSYNTEI/syTit+ex78r2ZN9aojCgohPeJ/CFSJ6f5hgG2MxexwG2P7Xv1QNp5oox2Pr1Yuga+LV2Lbeh2Fa0RIH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB7153.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(4326008)(8936002)(8676002)(316002)(36756003)(38100700002)(85182001)(41300700001)(4001150100001)(86362001)(38070700009)(2906002)(122000001)(7416002)(5660300002)(2616005)(26005)(54906003)(478600001)(6486002)(6506007)(53546011)(6512007)(71200400001)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(110136005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RThINFlReUo1azBYTGV0SjJCbGQwVTBzSDJGVnNzSXpyMFpMVFY4eXF1eVRm?=
 =?utf-8?B?cFF5RUd6RE1oSjRyczZSamVyNC84RW9rR1YvMEh3dndqbVA5ZmViTlhzbTdK?=
 =?utf-8?B?bWZVVng1VTBjYjJHOXRXamRPMitwNWxuZzBSRXEwN3NzZENDZk9rcFkrREh4?=
 =?utf-8?B?ZGlXd2FaOFF2N3gyRWlZd2dZN0plWEwzajdCQTVUOHBmZmpZMC80RWtUNkFl?=
 =?utf-8?B?YlZkNGNNMFdzMm5ZRmd3TzVvcWV4OG5xN0ZORUs5elRUSHpOWGQ4OXAzZXEy?=
 =?utf-8?B?dUNOVkFVZXhmbTVyZmFzNlV2c1VUZXk2YXBnMEg5U1dWcE9XSWdQcStEU0hB?=
 =?utf-8?B?VFZVNlVNOU9UbHVoSlRYTDFHdGx6a3BKVXZNMGR6TFVRQWtySVh3ZUdCUEJF?=
 =?utf-8?B?aWgveElWaHA0Y0VEU0ZuNlU4M0xpdGE1enNlMG52NGdPRmFSU3JWeHVrazFz?=
 =?utf-8?B?MmhUWXFXZ0t4STY3VFdKVHB0YWZ2TGc1Z0pvc0N5WmFwcSszcS9PZXNEUHhS?=
 =?utf-8?B?dnA4WW11dkc0dVlHSmNDaGhSZFFPakZXb2pLTlNwNDBja3JIVGpSL1dZVWl1?=
 =?utf-8?B?T0IvYVhhK1RwZC9DeHIzaTREMWZJenZlNVl3dHFTRERDQXp4aFAzV3BOanBY?=
 =?utf-8?B?VHV4NmprVkUxRUZYL2o4MHZZYmNqNlh0QVgvQkxLa0paYTNBakpScmV4aHpK?=
 =?utf-8?B?a1ZQeFh0MXNHZldzRWMxVnRGWXQ1SysydXdVKzJiM2dlZGlZcFMraUIxQkdx?=
 =?utf-8?B?R0hzeHZsRjdRVXU2WkxkZ0NmZjQ3S01ycFRic0twYVpqYVV6K1hiOVBSdmJw?=
 =?utf-8?B?RHFaOVBmM3VhMERHZUJnVGhCSWk5TEp3UW9oTUptSTM0WURxMTVrcWFPVFdJ?=
 =?utf-8?B?Zm9MYkNTQ011NlpEeWlWQ2YxcmpkQVgxWDJ6bXVZRmhSUzd3K0dQbzlUdjJt?=
 =?utf-8?B?bzdsOFlHR0o5Tm9lNy9OYmZyLzkrK3BJVmlpb2IxWlVuczBHWFEySnIzczNt?=
 =?utf-8?B?ZDdONExhSGJ6ZDczRjNYY0lXeXhRNkIvVUFxeWdmV0pCSzF2a2lsZ1JNTEpm?=
 =?utf-8?B?aHhhRmpUenJtQW1OMTBnRm96VXRxVHRNMXI3RWhKZzJINXEvMzBBcklYUUFl?=
 =?utf-8?B?bFFiTXBRSFBuVjkra0h5eHJPQVN1cFd3Yi8wTEN5SFlVeHdROE13a1JSTWYx?=
 =?utf-8?B?V0RCQXhFeUVMM25oSFp3TjBsUlJKQzEvY1FydVE5RDNLaHRFM1VnVko5c3ZO?=
 =?utf-8?B?R1NoMVZMWFlHWEd3VkNIZUxSdC9SeWJ5WVViTjFpZmx1WWdLbEUzTFJVNlFx?=
 =?utf-8?B?ME9qMzB0M2xNMVBoR1dLNkpGQ01SeDc2WmFmYWUrSGpvQ3RCOWJKU0JDUWp1?=
 =?utf-8?B?UjZkZk5GMmVMU1dpV2hnSm54TXk3azlxMW11QmFpQmZ4RjdXRWhJNG9WTjM0?=
 =?utf-8?B?SDc5cW1odW1wbGN0OE1jekhTU3dhWkUwTzNYaDVOMldzUllEZ25IeklqMjEy?=
 =?utf-8?B?VW5MMTlCV3RtN0dFYXNhWHNTVTJmOGdudzdtVzFKODh5ZDhYRlpHbFFFNG9p?=
 =?utf-8?B?cjB6a25jRWdQTTVhN2M3N0pXYWpWUXFFNDBhMDZFZzZMeWh5NHRzaDRZLzU5?=
 =?utf-8?B?bzNLZUJ5ZFNwQjhpRllXU2NwWWoreFk1UFZDSlc0SUNtMzBDYUVmTjdtV3V0?=
 =?utf-8?B?ZXZINklXc2ZyRm1nZ3JldXQ1WGR4MHE0d1RZdWZFd3g2b3JkUXZTMFFGR1pW?=
 =?utf-8?B?Z3pQVE9UUnNlM0QrZG54d3hFWEowUThqOUZPTGxpdVVObVdleWJ3UVM3Z0tY?=
 =?utf-8?B?VmI3cWgwdVpJVFpsOUVqd1ltM3RwSkgxaG9mSDlNTVV4YXdjWFFQNGRCa1hY?=
 =?utf-8?B?UmYydTcwLzhsV1hrQkFPZlROc3RoTko5dzl5V2hXTkY4anUzMzRCMkVnWlBv?=
 =?utf-8?B?UjE1aXN0ZDhBMVBUVzlIWlRuTWpHeTR0bHBUb0NiYnJyMzFia2s2Z293L3cz?=
 =?utf-8?B?SmtvK2JKeU1lY1NWRzhCMzNyQ1NhV04zNUU3S0FmdkNibmtxNnViOStJNC9M?=
 =?utf-8?B?V09ERHNnL3BITVFJRy8wbXRITk5IYzk1NEtIRjZOWVVLY1RRMDA2VXJ4b3NI?=
 =?utf-8?B?dXN3Q1gxQ2FMN1pCT2t6d0I2YVc3OVB0UU1Sd2l3czBUYUYyb3lheTJ1QitS?=
 =?utf-8?B?SEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9722C5CD8488D54BA225FCC25B71FFC9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB7153.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd23abd2-7cda-4f11-d542-08dbfd350b8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 06:14:07.1262
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uvtOfoWNNdBE4t26o315Vo0FVXuAfUyTOHV7PlxoBBB2LD8eB8fri4Effwb+RX0hjkiTR/ntcSx0AR8mjJoh93BSNdGQeTNiFJdquIQ2k7k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7078
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--18.444700-8.000000
X-TMASE-MatchedRID: TMsvcu6/L5fUL3YCMmnG4kD6z8N1m1ALjLOy13Cgb49qSjxROy+AU2yd
	bY7xfgXYfzQXZjDd1s9EfZEG9zzVQzbwsrznmJSKyn0GCvk40qFfFPlyDwr+135h6y4KCSJcuI1
	3sJeM6KcSz/bGxf+BBvL3NxFKQpq1az+0XDplNBbBVprK8rvWX1PgO2JKQydY3M5CjuZOAD4kOQ
	aRC4OfAx8GgtDrJ1crtmupbCupksK/JxRBHWTApkf49ONH0RaSX5TqQagR07cgcyGevtftJ6PFj
	JEFr+olFUew0Fl/1pGWc/0wwBlx2gtuKBGekqUpPjKoPgsq7cA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.444700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	559CA7802EF756196A07A95D20D405C3A6096893DC52BA9AE08ACB0C967D20582000:8
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTEzIGF0IDEyOjE3ICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTMvMTIvMjMgMDk6MDUsIEtyenlzenRvZiBLb3psb3dza2kgaGEg
c2NyaXR0bzoNCj4gPiBPbiAxMy8xMi8yMDIzIDA3OjM1LCBDaHVuZmVuZyBZdW4gd3JvdGU6DQo+
ID4gPiBGb3IgR2VuMSBpc29jLWluIGVuZHBvaW50IG9uIGNvbnRyb2xsZXIgYmVmb3JlIGFib3V0
IFNTVVNCIElQTQ0KPiA+ID4gdjEuNi4wLCBpdA0KPiA+ID4gc3RpbGwgc2VuZCBvdXQgdW5leHBl
Y3RlZCBBQ0sgYWZ0ZXIgcmVjZWl2aW5nIGEgc2hvcnQgcGFja2V0IGluDQo+ID4gPiBidXJzdA0K
PiA+ID4gdHJhbnNmZXIsIHRoaXMgd2lsbCBjYXVzZSBhbiBleGNlcHRpb24gb24gY29ubmVjdGVk
IGRldmljZSwNCj4gPiA+IHNwZWNpYWxseSBmb3INCj4gPiA+IGEgNGsgY2FtZXJhLg0KPiA+ID4g
QWRkIGEgcXVpcmsgcHJvcGVydHkgIm1lZGlhdGVrLHJ4Zmlmby1kZXB0aCIgdG8gd29yayBhcm91
bmQgdGhpcw0KPiA+ID4gaGFyZHdhcmUNCj4gPiA+IGlzc3VlOw0KPiA+ID4gVGhlIHNpZGUtZWZm
ZWN0IGlzIHRoYXQgbWF5IGNhdXNlIHBlcmZvcm1hbmNlIGRyb3AgYWJvdXQgMTAlLA0KPiA+ID4g
aW5jbHVkaW5nDQo+ID4gPiBidWxrIHRyYW5zZmVyLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBDaHVuZmVuZyBZdW4gPGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0N
Cj4gPiA+ICAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL21lZGlhdGVrLG10ay14aGNpLnlh
bWwgICAgIHwgMTANCj4gPiA+ICsrKysrKysrKysNCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiA+ID4geGhjaS55YW1sIGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRpYXRlayxtdGstDQo+ID4g
PiB4aGNpLnlhbWwNCj4gPiA+IGluZGV4IGU5NjQ0ZTMzM2Q3OC4uYjhlZDY4NTc0YmE0IDEwMDY0
NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3VzYi9tZWRp
YXRlayxtdGstDQo+ID4gPiB4aGNpLnlhbWwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy91c2IvbWVkaWF0ZWssbXRrLQ0KPiA+ID4geGhjaS55YW1sDQo+ID4g
PiBAQCAtMTI0LDYgKzEyNCwxNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ID4gICAgICAgICBkZWZpbmVk
IGluIHRoZSB4SENJIHNwZWMgb24gTVRLJ3MgY29udHJvbGxlci4NCj4gPiA+ICAgICAgIGRlZmF1
bHQ6IDUwMDANCj4gPiA+ICAgDQo+ID4gPiArICBtZWRpYXRlayxyeGZpZm8tZGVwdGg6DQo+ID4g
PiArICAgIGRlc2NyaXB0aW9uOg0KPiA+IA0KPiA+IFRoZSBwcm9wZXJ0eSBkZXNjcmlwdGlvbiBh
bmQgZHJpdmVyIHBhdGNoIHN1Z2dlc3QgeW91IGNvbmZpZ3VyZSB0aGUNCj4gPiBkZXB0aCBvZiBG
SUZPLCBzbyB0aGlzIHNob3VsZCBiZSBub3QgYm9vbCwgYnV0IHNvbWUgdWludDMyLiBBbmQNCj4g
PiB0aGVuLA0KPiA+IHVzZSBnZW5lcmljICJmaWZvLWRlcHRoIiBwcm9wZXJ0eSB0byBzZXQgZGVz
aXJlZCBkZXB0aC4NCj4gDQo+IERpZCB5b3UgbWVhbiAicngtZmlmby1kZXB0aCIgaW5zdGVhZCwg
YXMgdXNlZCBpbiBuZXQ/DQo+IFRoaXMgRklGTyBkZXB0aCBwYXJhbWV0ZXIgaXMgZm9yIFJYIG9u
bHkuDQpZZXMsIG9ubHkgZm9yIFJYDQoNCj4gDQo+IENoZWVycywNCj4gQW5nZWxvDQo+IA0KPiAN
Cg==

