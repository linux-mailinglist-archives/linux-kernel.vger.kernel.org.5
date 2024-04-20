Return-Path: <linux-kernel+bounces-152079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5598AB885
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3B21F2328B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ADFC8C7;
	Sat, 20 Apr 2024 01:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="axaCT5Xj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="s6CBJbl6"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2A739B;
	Sat, 20 Apr 2024 01:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713577748; cv=fail; b=RhPUenjoy/pDR6v41Ja6mriaiN0zp5bR+tTOMQXIv8zQEI9g6W95io9tlxRc6H216vfxe5XeogFULwJZ77ot4FJ/x4NaVItTZPoGhfMhjze0yhYTVISus1b0pXTGKIqYZ71k0Q24GP26CkC5teq0FuU1OrXXqgpbOt7b3TM8Zps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713577748; c=relaxed/simple;
	bh=/5IfKBZ9YolGHyzLq8HNV3LDVPSLQJoCjGwpaq5mv80=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qWfrtjDOrnEpYAEg5gecGUMF+ftAx6xhC+u2wv+SBPgNjeo+Ly7pCESWeDdMEA6iNlWmqfhRa9EawLaYX9Wlyk08M6NYW874WJGwOxgAu7G0aZHZF1rPqaQdNbGpvRWKZwjPZ7rV4n3fI4wjOYH+coOALC+owwUJuN/2WQzNMAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=axaCT5Xj; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=s6CBJbl6; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 282e4922feb811ee935d6952f98a51a9-20240420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=/5IfKBZ9YolGHyzLq8HNV3LDVPSLQJoCjGwpaq5mv80=;
	b=axaCT5Xjz/2ZWVyQyjvcuSEGIp2lNM9a4ZBt9s1FEklqwKpR8hKAu4fYnvO522nAkc3aU1gauWrwnMH4ZepLAeIIwk9YlnbYo/0oU9fnP+0AAAJi2lAQ3r74JCaJGqrbnCjFEA9oIWbpfA/+r507LAsXRVxYeS4nmUfGqBP6bL8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:31a8e489-90a8-41d7-9c0b-0d66d88e975c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:7215cc91-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 282e4922feb811ee935d6952f98a51a9-20240420
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 524545862; Sat, 20 Apr 2024 09:48:59 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 20 Apr 2024 09:48:58 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 20 Apr 2024 09:48:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjVdgyivkoJpBjQgOrdNdH1ZMhjDMJDdhkvq4xCnsOQEasRetGY9sSHd/RkUZohEE2oBlMPtfWpD2UmlkpwlPT7iW4EoGgUhzxjKNfa2BtOy793tFRKylB9odZSVmX0fQaSVJhP3GZEva8FJ3flvTpmQIRr6k2662l/a9LssKXmlaYHfqrnc0ZhaXIiB0Qha6lArU1B2TmbmMGyQZpdSr5ed/VNjBi9ncEW5MU7jTZySkIP3mqfnG5bCKMnrYR0nPWPmC/tQuIM9e920fazvudU/fO5h2A+42cx96o91uOjLg5mOIJ/SMFn+QHTSuUoejHkxYJok2AX5EZ1akgCgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5IfKBZ9YolGHyzLq8HNV3LDVPSLQJoCjGwpaq5mv80=;
 b=IXzBtponUXvbvuFsp6af+fmksJeVpx8cNxuLjkeLAMeOcuOa4GkhwfrtaIOyZ1TpMSHSTJUyRVuRXsg5PoiWcGZd+82eIWoNpyaFRdxWQtzL/ozjI/SQ4fguQWTNDo2qHpwX3+IfQAEFtmnsREJvZ5sNMRAX36+9YlYXB1i0TEpLuX70nRROsfXTR6bQMy7z6BkS+NedOfZstuV0qDSw7BtZDXJW2PQU9a3aZNGtcQYzmcLsQw+sH6Us3T3bXddMfkRbarMMd/BGthPWdIHOjqKsrE6DehaQOFcRfFQTNa3YixVOQxauKIb5qxodHyjGHUU4zvxJ2EXaZ93JAz1HBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5IfKBZ9YolGHyzLq8HNV3LDVPSLQJoCjGwpaq5mv80=;
 b=s6CBJbl6Dw5L/qiIpdHUrLv7NJ081HyIdw3OdDzSI2JqUxuMrcW2rEwg271p4kQG340XyrSotfZkcVy79J/1gZlrRJW8wzJqlpzqjmW7F4nPji/tINsZdjxNrG2bghi0PpbkPtwY7Nh0crSf26qA0T2L6yUWiZMOzr9nIpxl/ZI=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by TYZPR03MB7556.apcprd03.prod.outlook.com (2603:1096:400:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Sat, 20 Apr
 2024 01:48:56 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::6b1b:cceb:5ca3:2907]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::6b1b:cceb:5ca3:2907%5]) with mapi id 15.20.7472.044; Sat, 20 Apr 2024
 01:48:55 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>
CC: "heiko@sntech.de" <heiko@sntech.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "laurent.pinchart+renesas@ideasonboard.com"
	<laurent.pinchart+renesas@ideasonboard.com>, "yunkec@chromium.org"
	<yunkec@chromium.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"bingbu.cao@intel.com" <bingbu.cao@intel.com>, "paul.elder@ideasonboard.com"
	<paul.elder@ideasonboard.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, =?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?=
	<Yaya.Chang@mediatek.com>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"alain.volmat@foss.st.com" <alain.volmat@foss.st.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "mehdi.djait@bootlin.com"
	<mehdi.djait@bootlin.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "10572168@qq.com"
	<10572168@qq.com>
Subject: Re: [PATCH 2/2] media: i2c: Add GT97xx VCM driver
Thread-Topic: [PATCH 2/2] media: i2c: Add GT97xx VCM driver
Thread-Index: AQHaizOktS8Cvu/WZEmc57gPew1uO7FhqeMAgA7JggA=
Date: Sat, 20 Apr 2024 01:48:55 +0000
Message-ID: <34869abbbcce4fc82878aaafbbf59f7e52f06b8f.camel@mediatek.com>
References: <20240410104002.1197-1-zhi.mao@mediatek.com>
	 <20240410104002.1197-3-zhi.mao@mediatek.com>
	 <CAHp75VfF0pbrKXjWZg7sTr-T=_CbjP+deFQP-VLCGX8ooahctg@mail.gmail.com>
In-Reply-To: <CAHp75VfF0pbrKXjWZg7sTr-T=_CbjP+deFQP-VLCGX8ooahctg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|TYZPR03MB7556:EE_
x-ms-office365-filtering-correlation-id: 5a756d7d-5c91-44b5-5234-08dc60dc0a24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?utf-8?B?RnhXek4raTQ5Y3pTQjg5UXlLSzlOZWhZRG1EMVFKeU9adlJzU0dXR204N0px?=
 =?utf-8?B?Znpkb0NkVXg4QldMSWNFbGd1bTdMS1JIbVM4SmFvbitxcDZ0aFNDTjdWYnJw?=
 =?utf-8?B?RENtbXkrMVlJMmc4R0M0UHhqUTNycXlWZXZvU1o0bjVaSjdKMmt1dldwSUdC?=
 =?utf-8?B?T05Ba0kzd0tWT2g5S2dXWE04N3gza3R3akU2ODl0S3dSL3kvdWYrMi9FVHJk?=
 =?utf-8?B?RTk3T3BwNHBVVnZBVWRQUFVTeitIb3B2TDdaN0VGREllZFVLcm5XcWxENkY0?=
 =?utf-8?B?UnNhemRkRGF6UnNiQ3VMK2pQVmQwQ3JCRWxKcDhMOEoxYmNKRS93SXNScFVD?=
 =?utf-8?B?YXBYYWYrYWtoUXh0cXpiOGk1WFlZYXdYek1mWGJRZDdxN3VPeGxURVY2aGdz?=
 =?utf-8?B?dFNyRTNnQWtqREUxUTNSME5jc3ZMMGd3Z0RQMHhGbzZvYmhCOHRrYTZGR3Iw?=
 =?utf-8?B?RzVVYi8zbDVsTHgwRkh2MnhBWFE4MkNxMTM0VlF0R0xqQzJNNnNwd1FqY1gv?=
 =?utf-8?B?eHFJY3VsUlRxMlQwMDRLYzNDRzUweDVJQzJFaCtvSXBJRDZPbnN4N09TSHlV?=
 =?utf-8?B?VnZPK1hJRW43UWFHcUt4WWU2c0cvaXlFUFZPenRnY1A0N0FwelBCbGhCMVk2?=
 =?utf-8?B?UGttakhsSkJFcG1wOS9lQVdtcTRVWitmK1U2YkVTdzBUdDR6YjB4M2ZnQnF2?=
 =?utf-8?B?TFZ4SldXWWtkSjQ3dUlPSXBSUWUyYlhqNjVydmkrK1l2K2xrMEJBcjJDMmVv?=
 =?utf-8?B?bVVMeHg2bUFNUnFFRUk1eDYzVWVJN2xkNUxPTG5mejV2T0kxRTNOK0d3eGxs?=
 =?utf-8?B?ZTY1b2RxbHNxOUFicUpiZkZLRnBYMzYyeEZHaE5OUmcvbHV5UnNndHhaa0Zt?=
 =?utf-8?B?YW11KzR4M1JlQjM0b1ZZNG9SaEorOTMreDZrTUg0Ymg0L1FuY1BmRXozZjVY?=
 =?utf-8?B?UXEvcnc4b0dHemFXR09zc2Iyamh3SGRNK3BNa2hoSXpsaUpIRkZmV2ZWMC9O?=
 =?utf-8?B?TGFrLzV4RHRYcFN6bGxjTkp2UEdJUC9iUTNsYzlEVVRJWHI0WGluU1h6SVBn?=
 =?utf-8?B?YlhwNEdHc2J1YmhpeTY2UUdJVjd0OWlhZUUvaENNWWM4V2x4K05NdWtxeENr?=
 =?utf-8?B?NFdOT1dRSXltcHk4dVhHZStNTVFrZGpvSG4xazNDMWVnSlcvMTY5Vmw4eDVL?=
 =?utf-8?B?MEJjK1hibUZReCt6WGFCV1lCd0lVdENWamIwMGRNMXoyRnB0MFR4UjlpSG8y?=
 =?utf-8?B?dzZSRUJQZ3BkSWlobTFnN2NUV1VnTk9EUTk1YVh5RERkQTY1S0V6VC8vK1Yv?=
 =?utf-8?B?aVFaaVdtTHNpYmY5SE1uYTVxNUg4UVVuK0tlaWs3Tm5JVnA3b0NnWkNVeVFD?=
 =?utf-8?B?R3djdkswRjhkV056R0w2czJwU0wxVGV2WE9LdTlldUFTSDVZRlJkWUl6djd2?=
 =?utf-8?B?dlRHM2hVc0E4UVZHMjVaNmZDSlpnRjU2TnlXTnk1WStrbHVtZVBKVjNDcGJ2?=
 =?utf-8?B?cFBXN241NGdZOUdPaWJ6VWpZTjc1N1dzZHNpaTVjajJuQmZrZVI5YnVXUHU5?=
 =?utf-8?B?UXptSUxEWmtWdXpjWHV6eG1WOVhrc2tQeFk1SHVBc2MySlhOS3EwQWFMYkU3?=
 =?utf-8?B?a2sydTdCZVBhMi94UFNYL0hjclNMdnJyZjgzbFF1TTRKV3FDRXRvaFZIZWJa?=
 =?utf-8?B?SVVqUnQ2U2tpSHFFczhLTGlGOVpQa2JSWFFNV0t3cmRnRWtscXBibVMzOGRu?=
 =?utf-8?B?KytqYUlLbng3M1pwK1UwWnJEcEZlMTZ0ZkFGUzhmWmRsVUx1U043U0xCaEJr?=
 =?utf-8?B?b3FjYWZRVzYxaXlqelZ4Zz09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnZPYTBIajNrcyt4MG1QYnhLb2FEK1gyeG9QWEhLMkt3aWRha2pCOHlNQU1Y?=
 =?utf-8?B?eGFUUnhYdzB5N0ZOZ05tYzZ1TndobzZsSXdUckMvMUlhNlltYXk1T1ZNNHkr?=
 =?utf-8?B?TEtzUVRYSG1CbVI2RWhBcmlpYTdXMTVNaTNSRU5CMXlEbUx5dmJMMGdHUXV1?=
 =?utf-8?B?RmJ4U1VJUXZjRnZXQStmNVBWY1A1ZlRxZU8ybFFiS0lpRVA1ZmY1R1NjRVRl?=
 =?utf-8?B?NGlkYzAxWk5EMDBLcXFCQzhUVlFyd1FHUlc4a0hkNEloSVJxWnU0MEtBUFRN?=
 =?utf-8?B?V3ljNUcvOVdXZFVvZ1ZQTjVhU1Y0VFpnNnd4UnlpMUtkNXNIejc3R2N2L1Ni?=
 =?utf-8?B?Y2ZkZnpJRDE0eWJXQWNDRUhvWG9MUlg2RzI2MFNISEFXK0FUbnlwUWZTKzhV?=
 =?utf-8?B?RlN2MmxpRXFoc25ab3lvY1BzdG5pRG5ta3RCTzVoLzRrQXFZejd6VlZSbXVH?=
 =?utf-8?B?UUZYbkd3Njl1RHdnc1NIWGt3dGNQbHJKejJJcmFvRDFLUElDMU4reUdqSzAy?=
 =?utf-8?B?WGEyL2dQQm9aU2NoQng5YnVaayttUW9JaUNtSzk1WEpQemZBMmlza2FHcEVi?=
 =?utf-8?B?dTdFbkxFZjV4OUNEem5xcjUxbURwYVFTbWRPWEVpZjdwMENUTjU4dWlaV0lI?=
 =?utf-8?B?dURsekJHa3BjK01GWGRhS0dwZlh5K2ZYdVhzWXZJSlhPL0R5Y3NkeW9XNWNL?=
 =?utf-8?B?UnJwRnd4c0liUzAxUXd1cWRiVHNLb09PSng1cGxRZ01TM3ZhNVpkOTZmYWlZ?=
 =?utf-8?B?c09DdlNSa0R1NHV5UFJvL3BMZ1dYRlRteURIMjlEWGxybzNINWpRdjlYRTRv?=
 =?utf-8?B?SGdaNHprN0FvT1hBRmJHWnk4ZlN4WWV5aktwZ1U2NjFJbUJHMElIRkpYZ3cw?=
 =?utf-8?B?VmR3SzNMNk9NZ3ExMlZFSXFQSDBYQnZGOXhPYys2QmZXcThIVlNKKzhwcjBZ?=
 =?utf-8?B?cU91OTBCdVF0amxYZVBjc1o0N1JZSGZqUUdOcGRtMDBhc1BnNnA3WXNjNHZH?=
 =?utf-8?B?RS93UDNzOVd0eGZZVXF1TkF6MWJwNGtJQ09MSjdUMVhXYVRHTFRxZ1lnbytC?=
 =?utf-8?B?NGpzbDVDTWczNHlueFJUaW9rTjIxUUNkUFAvYjZXTXpoeHRoM0p2cytMV2F0?=
 =?utf-8?B?VkE2K3VhNEl4MlNzZUxaWWQ0Wm5xdnVmMVA0cUFuN2d6OUVYMmJNd1hySUNy?=
 =?utf-8?B?eGNwMjc0MXZBb0RLMmF0NkFvMUcrZHlWM1dLdnpqVGVVaWRDd0hsOTFEdW5h?=
 =?utf-8?B?YUViL1BJdXQ5Z1Zpd3h6RE15SkNDN1hDQk5aOXhOcU9nUUdJQlFOV2t6Q256?=
 =?utf-8?B?N25UY2taSC8vYTdveVNxZi9sNFMrZ21jTGpSZEs5aWc1bi9kSTJtTUJZaW1Q?=
 =?utf-8?B?eHEzQURzd3JqVWZxV2Q5dWEwNmxRbmcwbCtaajlVaUcvQU1QZHQxRllJVnUr?=
 =?utf-8?B?N3gzako1bFNmbjUxMjdrNjdWNlFqY2k5Q2VHVUtoazdKK2NMZjJMMGVaZUlF?=
 =?utf-8?B?Nm51OEdud2tvWkxVVXd1SldVWlp1SjhIcHE5bHR6LytqeHdtcUUrRG5xRXBP?=
 =?utf-8?B?U1Ivb1N0N0w3NmFtZDZLbHArOE9SS2cwU1hhb0tzNGxyeTZYWExVN1BNTU14?=
 =?utf-8?B?bjhVRURLL0g4bW4yTDFXOUw4UmNQY1Q3b1NIUWxGUTZyT2VzUjlxNzZ0aU5p?=
 =?utf-8?B?NnRBRVdvK0F6c3BTd2VsQlVqS3JOdDdHRXh2NndES3VSWktwdDUyMWtvV09C?=
 =?utf-8?B?RjIvM2NCbUpYemQyTWVVZHBlTEJMbmQ1MFFHK1AreEo5M3dxS3hGa0xORXBp?=
 =?utf-8?B?dlFzVGFKdXlRNHl5UCt6Z0Q5OG5VejVJekxwaVV1Q2xOdlVjMEUya1Qramli?=
 =?utf-8?B?OGs4MGhUL2JvL2ducm9ZM0hHU01EYU1Hd0xDV2NFRkFvUzFobE4yOEFXMFVG?=
 =?utf-8?B?MlgvSlZsUzAwVUduVjNIUG9kUHB1U0doWGpiaFQrc3c5UDhodEp1bVE3NGdF?=
 =?utf-8?B?OG9VQlI0cDJ4bmltZkhtZXFyYzA5NE1LVDdhVnRFa2JwbVM0VEc2ZTFBN1dE?=
 =?utf-8?B?UG14aWUrOU9VMG9ZVDVUOWlxbFV1THRWVVNqYWJ2dStuemMzaklGVk9mcS82?=
 =?utf-8?B?a1pQTHdsV2tYQXR3YmQ4NDZQQWU5TmdscllqMGIvY2J2TFBsMCtLNlBla0Yx?=
 =?utf-8?B?UVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A6CB550FC9B64418CEAD33706FFF464@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a756d7d-5c91-44b5-5234-08dc60dc0a24
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2024 01:48:55.8727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9gw+taUw/htdvqp4AmstquwyC0UjCS51ZZ3ifI28SU2bqt+XafiP2yO70wOqv39OTmnmHZkIsQ6uzemp64I8tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7556

SGkgQW5keSwNCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KT24gV2VkLCAyMDI0LTA0LTEw
IGF0IDE5OjAwICswMzAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ICAJIA0KPiBFeHRlcm5h
bCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRoZSBjb250ZW50Lg0KPiAg
T24gV2VkLCBBcHIgMTAsIDIwMjQgYXQgMTo0MOKAr1BNIFpoaSBNYW8gPHpoaS5tYW9AbWVkaWF0
ZWsuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEFkZCBhIFY0TDIgc3ViLWRldmljZSBkcml2ZXIg
Zm9yIEdpYW50ZWMgR1Q5N3h4IFZDTS4NCj4gDQo+IC4uLg0KPiANCj4gPiArLyoNCj4gPiArICog
UmluZyBjb250cm9sIGFuZCBQb3dlciBjb250cm9sIHJlZ2lzdGVyDQo+ID4gKyAqIEJpdFsxXSBS
SU5HX0VODQo+ID4gKyAqIDA6IERpcmVjdCBtb2RlDQo+ID4gKyAqIDE6IEFBQyBtb2RlIChyaW5n
aW5nIGNvbnRyb2wgbW9kZSkNCj4gPiArICogQml0WzBdIFBEDQo+ID4gKyAqIDA6IE5vcm1hbCBv
cGVyYXRpb24gbW9kZQ0KPiA+ICsgKiAxOiBQb3dlciBkb3duIG1vZGUNCj4gPiArICogZ3Q5N3h4
IHJlcXVpcmVzIHdhaXRpbmcgdGltZSBvZiBUb3ByIGFmdGVyIFBEIHJlc2V0IHRha2VzDQo+IHBs
YWNlLg0KPiA+ICsgKi8NCj4gPiArI2RlZmluZSBHVDk3WFhfUklOR19QRF9DT05UUk9MX1JFRyBD
Q0lfUkVHOCgweDAyKQ0KPiANCj4gPiArI2RlZmluZSBHVDk3WFhfUERfTU9ERV9PRkYgMHgwMA0K
PiANCj4gT2theSwgdGhpcyBzZWVtcyB0byBiZSBiaXRtYXBwZWQsIGJ1dCBkbyB5b3UgcmVhbGx5
IG5lZWQgdG8gaGF2ZSB0aGlzDQo+IHNlcGFyYXRlIGRlZmluaXRpb24/DQo+IA0KPiA+ICsjZGVm
aW5lIEdUOTdYWF9QRF9NT0RFX0VOIEJJVCgwKQ0KPiA+ICsjZGVmaW5lIEdUOTdYWF9BQUNfTU9E
RV9FTiBCSVQoMSkNCj4gDQo+IC4uLg0KPiANCj4gPiArI2RlZmluZSBHVDk3WFhfVFZJQl9NU19C
QVNFMTAgKDY0IC0gMSkNCj4gDQo+IFNob3VsZCBpdCBiZSAoQklUKDYpIC0gMSkgPw0KPiANCj4g
Li4uDQo+IA0KPiA+ICsjZGVmaW5lIEdUOTdYWF9BQUNfTU9ERV9ERUZBVUxUIDINCj4gPiArI2Rl
ZmluZSBHVDk3WFhfQUFDX1RJTUVfREVGQVVMVCAweDIwDQo+IA0KPiBTb21lIGFyZSBkZWNpbWFs
LCBzb21lIGFyZSBoZXhhZGVjaW1hbCwgYnV0IGxvb2sgdG8gbWUgbGlrZQ0KPiBiaXRmaWVsZHMu
DQo+IA0KU29tZSAiYWFjLW1vZGUvYWFjLXRpbWluZy9jbG9jay1wcmVzYyIgY29udHJvbCBmdW5j
dGlvbiB3ZXJlIHJlbW92ZWQsDQpzbyB0aGVzZSByZWxhdGVkIGRlZmluZXMgd2VyZSBhbHNvIHJl
bW92ZWQuDQoNCj4gLi4uDQo+IA0KPiA+ICsjZGVmaW5lIEdUOTdYWF9NQVhfRk9DVVNfUE9TICgx
MDI0IC0gMSkNCj4gDQo+IChCSVQoMTApIC0gMSkgPw0KPiANCmZpeGVkIGluIHBhdGNoOnYxLg0K
PiAuLi4NCj4gDQo+ID4gK2VudW0gdmNtX2dpYW50ZWNfcmVnX2Rlc2Mgew0KPiA+ICsgICAgICAg
R1RfSUNfSU5GT19SRUcsDQo+ID4gKyAgICAgICBHVF9SSU5HX1BEX0NPTlRST0xfUkVHLA0KPiA+
ICsgICAgICAgR1RfTVNCX0FERFJfUkVHLA0KPiA+ICsgICAgICAgR1RfQUFDX1BSRVNDX1JFRywN
Cj4gPiArICAgICAgIEdUX0FBQ19USU1FX1JFRywNCj4gDQo+ID4gKyAgICAgICBHVF9NQVhfUkVH
LA0KPiANCj4gTm8gY29tbWEgZm9yIHRoZSB0ZXJtaW5hdG9yLg0KPiANCmZpeGVkIGluIHBhdGNo
OnYxLg0KPiA+ICt9Ow0KPiANCj4gLi4uDQo+IA0KPiA+ICtzdGF0aWMgdTMyIGd0OTd4eF9maW5k
X290X211bHRpKHUzMiBhYWNfbW9kZV9wYXJhbSkNCj4gPiArew0KPiA+ICsgICAgICAgdTMyIGN1
cl9vdF9tdWx0aV9iYXNlMTAwID0gNzA7DQo+ID4gKyAgICAgICB1bnNpZ25lZCBpbnQgaTsNCj4g
PiArDQo+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShhYWNfbW9kZV9vdF9t
dWx0aSk7IGkrKykgew0KPiA+ICsgICAgICAgICAgICAgICBpZiAoYWFjX21vZGVfb3RfbXVsdGlb
aV0uYWFjX21vZGVfZW51bSA9PQ0KPiBhYWNfbW9kZV9wYXJhbSkgew0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGN1cl9vdF9tdWx0aV9iYXNlMTAwID0NCj4gPg0KPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGFhY19tb2RlX290X211bHRpW2ldLm90X211bHRpX2Jhc2UxMDAN
Cj4gOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+IA0KPiBObyBicmVhayAvIHJldHVybiBoZXJl
Pw0KZml4ZWQgaW4gcGF0Y2g6djEuDQo+IA0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAg
ICAgIHJldHVybiBjdXJfb3RfbXVsdGlfYmFzZTEwMDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3Rh
dGljIHUzMiBndDk3eHhfZmluZF9kaXZpZGluZ19yYXRlKHUzMiBwcmVzY19wYXJhbSkNCj4gDQo+
IFNhbWUgY29tbWVudHMgYXMgcGVyIGFib3ZlIGZ1bmN0aW9uLg0KPiANCj4gLi4uDQo+IA0KPiA+
ICtzdGF0aWMgaW5saW5lIHUzMiBndDk3eHhfY2FsX21vdmVfZGVsYXkodTMyIGFhY19tb2RlX3Bh
cmFtLCB1MzINCj4gcHJlc2NfcGFyYW0sDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHUzMiBhYWNfdGltaW5nX3BhcmFtKQ0KPiANCj4gV2h5IGlubGluZT8NCj4g
DQo+IC4uLg0KPiANCj4gPiArICAgICAgIHJldHVybiB0dmliX3VzICogb3RfbXVsdGlfYmFzZTEw
MCAvIDEwMDsNCj4gDQo+IEhFQ1RPID8NCj4gDQo+IC4uLg0KPiANCj4gPiArICAgICAgIHZhbCA9
ICgodW5zaWduZWQgY2hhcilyZWFkX3ZhbCAmIH5tYXNrKSB8ICh2YWwgJiBtYXNrKTsNCj4gDQo+
IFdoeSBjYXN0aW5nPw0KPiANClNvbWUgImFhYy1tb2RlL2FhYy10aW1pbmcvY2xvY2stcHJlc2Mi
IHJlbGF0ZWQgY29udHJvbCBmdW5jdGlvbiB3ZXJlDQpyZW1vdmVkLg0KPiAuLi4NCj4gDQo+ID4g
K3N0YXRpYyBpbnQgZ3Q5N3h4X3Bvd2VyX29uKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0K
PiA+ICsgICAgICAgc3RydWN0IHY0bDJfc3ViZGV2ICpzZCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYp
Ow0KPiA+ICsgICAgICAgc3RydWN0IGd0OTd4eCAqZ3Q5N3h4ID0gc2RfdG9fZ3Q5N3h4KHNkKTsN
Cj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0ID0NCj4gcmVndWxh
dG9yX2J1bGtfZW5hYmxlKEFSUkFZX1NJWkUoZ3Q5N3h4X3N1cHBseV9uYW1lcyksDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3Q5N3h4LT5zdXBwbGllcyk7DQo+ID4g
KyAgICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJyKGRldiwg
ImZhaWxlZCB0byBlbmFibGUgcmVndWxhdG9yc1xuIik7DQo+IA0KPiA+ICsgICAgICAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPiANCj4gRHVwLg0KZml4ZWQgaW4gcGF0Y2g6djEuDQo+IA0KPiA+ICsg
ICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXQ7DQo+ID4gK30NCj4gPiArDQo+
ID4gK3N0YXRpYyBpbnQgZ3Q5N3h4X3Bvd2VyX29mZihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4g
K3sNCj4gPiArICAgICAgIHN0cnVjdCB2NGwyX3N1YmRldiAqc2QgPSBkZXZfZ2V0X2RydmRhdGEo
ZGV2KTsNCj4gPiArICAgICAgIHN0cnVjdCBndDk3eHggKmd0OTd4eCA9IHNkX3RvX2d0OTd4eChz
ZCk7DQo+ID4gKyAgICAgICBpbnQgcmV0Ow0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9DQo+IHJl
Z3VsYXRvcl9idWxrX2Rpc2FibGUoQVJSQVlfU0laRShndDk3eHhfc3VwcGx5X25hbWVzKSwNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ3Q5N3h4LT5zdXBwbGllcyk7
DQo+ID4gKyAgICAgICBpZiAocmV0IDwgMCkgew0KPiA+ICsgICAgICAgICAgICAgICBkZXZfZXJy
KGRldiwgImZhaWxlZCB0byBkaXNhYmxlIHJlZ3VsYXRvcnNcbiIpOw0KPiANCj4gPiArICAgICAg
ICAgICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IERpdHRvLg0KZml4ZWQgaW4gcGF0Y2g6djEuDQo+
IA0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIHJldHVybiByZXQ7DQo+ID4gK30N
Cj4gDQo+IC4uLg0KPiANCj4gPiArc3RhdGljIGludCBndDk3eHhfb3BlbihzdHJ1Y3QgdjRsMl9z
dWJkZXYgKnNkLCBzdHJ1Y3QNCj4gdjRsMl9zdWJkZXZfZmggKmZoKQ0KPiA+ICt7DQo+ID4gKyAg
ICAgICByZXR1cm4gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldChzZC0+ZGV2KTsNCj4gPiArfQ0K
PiA+ICsNCj4gPiArc3RhdGljIGludCBndDk3eHhfY2xvc2Uoc3RydWN0IHY0bDJfc3ViZGV2ICpz
ZCwgc3RydWN0DQo+IHY0bDJfc3ViZGV2X2ZoICpmaCkNCj4gPiArew0KPiA+ICsgICAgICAgcmV0
dXJuIHBtX3J1bnRpbWVfcHV0KHNkLT5kZXYpOw0KPiA+ICt9DQo+IA0KPiBIbW0uLi4gU2hvdWxk
bid0IHY0bDIgdGFrZSBjYXJlIGFib3V0IHRoZXNlIChQTSBjYWxscyk/DQo+IA0KQWNjb3Jpbmcg
dG8gZGlzc2N1c3Npb24gaW4gYW5vdGhlciB0aHJlYWQsIHRoZXJlIGlzIG5vdCBhIGdvb2QNCm1l
Y2hhbmlzbSBhdCBwcmVzZW50LCBzbyBJIGtlZXAgdGhpcyBtZXRob2QuIA0KPiAuLi4NCj4gDQo+
ID4gKyAgICAgICBndDk3eHgtPmNoaXAgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2KTsN
Cj4gDQo+IGRldmljZV9nZXRfbWF0Y2hfZGF0YSgpDQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAg
ICBmd25vZGVfcHJvcGVydHlfcmVhZF91MzIoZGV2X2Z3bm9kZShkZXYpLCAiZ2lhbnRlYyxhYWMt
DQo+IG1vZGUiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZndDk3eHgt
PmFhY19tb2RlKTsNCj4gDQo+IE5vLCB1c2UgZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKCkgZGly
ZWN0bHkuDQo+IA0KPiAuLi4NCj4gDQo+ID4gKyAgICAgICBmd25vZGVfcHJvcGVydHlfcmVhZF91
MzIoZGV2X2Z3bm9kZShkZXYpLCAiZ2lhbnRlYyxjbG9jay0NCj4gcHJlc2MiLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZndDk3eHgtPmNsb2NrX3ByZXNjKTsNCj4gDQo+
IERpdHRvLg0KPiANCj4gLi4uDQo+IA0KPiA+ICsgICAgICAgZndub2RlX3Byb3BlcnR5X3JlYWRf
dTMyKGRldl9md25vZGUoZGV2KSwgImdpYW50ZWMsYWFjLQ0KPiB0aW1pbmciLA0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZndDk3eHgtPmFhY190aW1pbmcpOw0KPiANCj4g
RGl0dG8uDQo+IA0KU29tZSAiYWFjLW1vZGUvYWFjLXRpbWluZy9jbG9jay1wcmVzYyIgcmVsYXRl
ZCBjb250cm9sIGZ1bmN0aW9uIHdlcmUNCnJlbW92ZWQuDQo+IC4uLg0KPiANCj4gPiArICAgICAg
IC8qcG93ZXIgb24gYW5kIEluaXRpYWxpemUgaHcqLw0KPiANCj4gTWlzc2luZyBzcGFjZXMgKGFu
ZCBjYXBpdGFsaXNhdGlvbj8pLg0KPiANCmZpeGVkIGluIHBhdGNoOnYxLg0KPiAuLi4NCj4gDQo+
ID4gKyAgICAgICByZXQgPSBndDk3eHhfcnVudGltZV9yZXN1bWUoZGV2KTsNCj4gPiArICAgICAg
IGlmIChyZXQgPCAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiZmFpbGVk
IHRvIHBvd2VyIG9uOiAlZFxuIiwgcmV0KTsNCj4gDQo+IFVzZSBkZXZfZXJyX3Byb2JlKCkgdG8g
bWF0Y2ggdGhlIHN0eWxlIG9mIHRoZSBtZXNzYWdlcy4NCj4gDQpmaXhlZCBpbiBwYXRjaDp2MS4N
Cj4gPiArICAgICAgICAgICAgICAgZ290byBlcnJfY2xlYW5fZW50aXR5Ow0KPiA+ICsgICAgICAg
fQ0KPiANCj4gLi4uDQo+IA0KPiA+ICsgICAgICAgcmV0ID0gdjRsMl9hc3luY19yZWdpc3Rlcl9z
dWJkZXYoJmd0OTd4eC0+c2QpOw0KPiA+ICsgICAgICAgaWYgKHJldCA8IDApIHsNCj4gPiArICAg
ICAgICAgICAgICAgZGV2X2VycihkZXYsICJmYWlsZWQgdG8gcmVnaXN0ZXIgVjRMMiBzdWJkZXY6
ICVkIiwNCj4gcmV0KTsNCj4gDQo+IERpdHRvLg0KZml4ZWQgaW4gcGF0Y2g6djEuDQo+IA0KPiA+
ICsgICAgICAgICAgICAgICBnb3RvIGVycl9wb3dlcl9vZmY7DQo+ID4gKyAgICAgICB9DQo+IA0K
PiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=

