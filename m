Return-Path: <linux-kernel+bounces-11849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0552981EC7A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DA97B2186C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0FD525B;
	Wed, 27 Dec 2023 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="DnsNsP89";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="o/9Blt8v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BE263A8;
	Wed, 27 Dec 2023 06:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 010aad4ca47f11eea2298b7352fd921d-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3xNpDwUUF9bxdc60RyZ7lgR4Ag351L7+hWX3bsK+j4E=;
	b=DnsNsP89h4xJ9Odj+nPsl53bONAUDb1DIP4oUDIeTwzNGDxc0rQ3FcnoAxZSXMQ553+uHVp48aqN26x9NTHe9M+DgLsSJdinWmF8HFUR7hhv/+5os2B76cXa1scWevV8IAgudKF9UTRX0dMhMTAPLnghvdrZDg+oc7oN369KVlU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:6ddff808-97d1-49c0-a61b-a22690ffc875,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:207c3682-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 010aad4ca47f11eea2298b7352fd921d-20231227
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1982319506; Wed, 27 Dec 2023 14:13:08 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 14:13:05 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 14:13:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BT7GVDq1iIj0SK84CBzYJU//e7IL/F8VUAaxnbFZu2Z+ziScpIktwUkP0UhKQK3LicjZdBR6xyfnkkXaMLYFOOKLFtmyE2L+OmAF4PsprSKftD7+OkkgLamCOcvXQkNAvC4ZlkTzPsp2R3lBFBhsFO5jZ53W/Iyc+UisYNfgaiUntmupuFDdsUKVl1cHkwKdawh7yIyo0xNEt7kWkMEOMxa8lS8LGsCMDAd8/k/JKZWRFKFtkvHa3op/mSGtbrcEi16xc8ZOLtySJhin8LyWfGgxO51nGDpB8j94wvBtdrH3injXxndAnWjH49tTsYePxucD3sKTvFq8eJhnRJotkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xNpDwUUF9bxdc60RyZ7lgR4Ag351L7+hWX3bsK+j4E=;
 b=Y1vNU33lChpHj3WxBmMBQo9Z2LF0TxXqyAri6tws3qMVq3EySKzaW7L1fxwhrAuh+NI9e+H/uT8AoxV61qnvjL2kgIfB0CLJRk0jeFn+n+X1YbW0JgGEGoBmXLuUfoTGvH2TOAz4m/ZujF3jHF7wLViPhgjn7BLYk/P197LewgY1rHrsuoaGiO/K3b4qwXmFp0MdQgOHXkp+7duMxR6UBqfs2qFGUM8/tuXLrYgagbFwhFah/kmQxYs5MJkHIgwesge8CwkYUrKClI8XAdSun9s29PDc2I6ilcGyLfYEporGGcnZioK3EWtMsHCa3PerGYFU9Wji1ynwzApoWNXLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xNpDwUUF9bxdc60RyZ7lgR4Ag351L7+hWX3bsK+j4E=;
 b=o/9Blt8vzRNmWxy2lqdKl7xRq/wTrSrqLkYyZtGFKKwtXum86SQw6usn7SKU9IgvE8L1tz/aU3C7U23IbwQSLwhNRweTr5VFN1nIrXD3s68S7hY/W14Av91Gd1Xuujpd/J8TDAfJsNEaAAxSiraCkI/8+Es9nSo79jGwEYHzv1U=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by OSQPR03MB8482.apcprd03.prod.outlook.com (2603:1096:604:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Wed, 27 Dec
 2023 06:13:02 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 06:13:01 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Topic: [PATCH v3 8/9] mailbox: mediatek: Add CMDQ secure mailbox driver
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC7JTwAgAGJGgA=
Date: Wed, 27 Dec 2023 06:13:01 +0000
Message-ID: <db1591bdf52f3cd02335155c45cb7841da9fcbc1.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <957c5ec4fe3a1ad6eb44df37bd68cfedfcb0b926.camel@mediatek.com>
In-Reply-To: <957c5ec4fe3a1ad6eb44df37bd68cfedfcb0b926.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|OSQPR03MB8482:EE_
x-ms-office365-filtering-correlation-id: 3c0a3a22-7eb9-4104-e28f-08dc06a2e18f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWOSO6FN2fOD9U+ThmJuZ0lY5I6c2qtRNYspZDSs6Q7tZ97EWTg2eKSDBOHYodnpwHgwgq6p4AK34k3bwaiUmjCIRJW+Xz9l5qht1FXDOf98bmhNyGd7r4BOg8gB8h794J+IHxYYWAfyRqCinIkLMKJIvVkSHNaawfk9EpMMwR7lY3/s0sK5y/uRZPiySIlJrOT3oyig4cgnqAeSVQqJba5jwDOoveRLzryUngkePYD2Y5AhxrWee0GMfGIqPSKQr6PxRhuQVGwOANs6puy1e1RuAzc+6K97hG50zFUyZ4C88ulo30BrnDDef8UQoit7gPUcIHgVM3+HtcHoVbwz3Cw18q5P4pZdxWNOJ9fO4RAuVMmC4PD323ckioIQkX/8xF1xn4cviT5TbQFM0NplfD2rVunj8bYoZiEyARRRNXY//5FHs7D3oTFTP0I10171zM958icu3a23DQ5qSFHewzjWH7VvgU1oR+X7sg6sq2TU1sjabU9QPKpxYNXTCw/5vx3aGTzFEdl2UcCDS2nRirutzLiFDvGsUEAZN0/VaYG5A9hzcE0riIXiNc43f9M2YzrNxtPBq2seEJwtD8BnlR6n7Lu5x6+nTLFrkKJM2CR40vYmoUYW58dO/rH4ls9OAmuJ/vdsy1NZMSkh3SQXTKK3wUUTS095UfRCCX0njqg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4001150100001)(2906002)(64756008)(66946007)(66556008)(66446008)(66476007)(76116006)(5660300002)(15650500001)(7416002)(4326008)(8676002)(8936002)(316002)(54906003)(110136005)(41300700001)(91956017)(85182001)(6486002)(478600001)(36756003)(71200400001)(6512007)(6506007)(2616005)(86362001)(26005)(38070700009)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnpVWGRHZ05sK1MwaVlRbDZkRHpJM3MraG9CbWJ0T2JlSGhud1p1SXRsT3RT?=
 =?utf-8?B?NWRWWi90d2k0ZkNFbmJOZTBiQWpXVzFsT2JuTTVwak1HUG0zeDUxZDFlcFZN?=
 =?utf-8?B?dUJWeHZsSm9KSzhUek1hTGloVC8xNEJiSExZVEE5WTFzRnhQL2FOUXJhYjJI?=
 =?utf-8?B?aS9tZ1o3d2E1MCtISHFQREcxTWdJS2RWKzk5TnYvVEtNU01uQ0dqTEErUzRv?=
 =?utf-8?B?dTQ4aDVWdVJaY2R1ZUUzcDBGcnkxOTFGTW52ZzUzMS83NW1HWDV4QytCVFQv?=
 =?utf-8?B?NEhqenkwSmgrOU9IWEplRjJDRHVydWJSVkJpbnFVS2IwalRpa2cxVkJZeDNi?=
 =?utf-8?B?VW82NUNYRkhEeUlXUjQwL2xKN1Bpb2ZTNi9sWTJMa0FITjhGU1hndTZIbmxU?=
 =?utf-8?B?RkRmV1E1L1kxOGoyOXRRVFNheElGVk9WK2ZZYml4a1FvTzE1QmJ3NDFrMHd1?=
 =?utf-8?B?TGlVdnoyVFQ5VmpySExmSUl1a3Z5ek1UOEVOZktJQzBVdmlDK3ByQUYxMTI2?=
 =?utf-8?B?Vm01aWRIRXZWUE0wUjRNUm8vWWtTYlAvRTRqTzhRbUhOWHBQMkFqbit3Q3hq?=
 =?utf-8?B?L3VsaTRxaDZSTCtQV3RjK1o2Y0pnenhsYXZ4Qm5RV2hIalJRSFQ3d2F0Wlc5?=
 =?utf-8?B?WFlRU2p4a3JFNmtXdVdKUjBlYnZ2MHk5THhPc2h5Uk1YKy9UbUZPSU5oN0Fr?=
 =?utf-8?B?Tld5YTJGV0dQSHk0SU8rVGo5MUp0YzR4RmdKTjRYZWV2MitsYk9MM2E1aExt?=
 =?utf-8?B?eGVTTjhDV0R0cUF6T2lJTCtnM2dhZjNYMmVtbGU0QktnUERLdStDVUJaVVp2?=
 =?utf-8?B?NWVMVit2SzlOdFVTTUF4eXFiNDU1Uy9DUXRXZHlQR01qNVc0K1VZRzFMMlUy?=
 =?utf-8?B?WnVnOUx4Yk9WZERGNGU5QjBWRVUxdlhmWXNPdUk2bFhySUlkdU1DVHl4amdn?=
 =?utf-8?B?UUxoQm1xR3lkZlRvSTRJYUpudnM5LzNxOHA1T1RYaUhNZ29Hc2I4YmVDbnJD?=
 =?utf-8?B?MGRTdXgyYmJ3eVZPcTd4MXJKTVpYL0owMzV4UzMwaEZaV3lzbGYrRGltTmNh?=
 =?utf-8?B?b0VPcHlieXlmbUdEc1JGYnBiY00wckx5aGsrOVIwZUZTVVllN3hvMjVUV3k5?=
 =?utf-8?B?eHNDb3o1RVQ0aG5IOGVHVUZmZFNuTE50aGlkZW8vdkU5eFNvL01Qd1VtN3pK?=
 =?utf-8?B?UU9IN1RjVy91d1hvQXZpdGNRc1A1RDNyZUFxSVo1c2dpWmJLaFdyS282SjNn?=
 =?utf-8?B?dDZsZkQxK2JJTXg3WG5hVEJDY29SNlpkQmtEZGk3eE1XWCtpQjk4ZmN2cEtZ?=
 =?utf-8?B?TUd2Z0ZBMVpqTnRPNjhYc1dYSW82NjV5MlFLaGQ5SEN2TVhyaTVrelBFM3Qz?=
 =?utf-8?B?RlIxMU45Z3QwanJYTEI2UTZaek9ZWGlCT09LdWNKUW9JU2pycU92VGV6Z25O?=
 =?utf-8?B?NmxwNlVoenhJVlR1cEt2cklNeW5RUFRob0orb2MzVmlRKzlTUmNpWWVDdllN?=
 =?utf-8?B?Ym8vcEpFMURqWC9mZTFwT1FMT2JmQXVTaFFIZEVmWnhHT0JyRzlaallzQkt4?=
 =?utf-8?B?d1JvazE4cEVwMG45RU9jRGpCT01WMTF4b0ZoU2RTR1lWdzZ6WEVXRzZmUTZa?=
 =?utf-8?B?K2lIZHd0N3lDSEF5VmxSVW5Dc2RhL0kwaExVWjkyQUVTUnZON3dWcUpVK05Q?=
 =?utf-8?B?MWRMYkR2bFhwYnFQMnNVVUVZNjJzY1FuYTVJYmRnY1pBNnhOOTR0SzdHYUlG?=
 =?utf-8?B?ejRRZHRRQ2Q3SE1uNDZhWmhjalV5dGFDZGYrbS9ld2pINFFsWkNmZGk0WFNP?=
 =?utf-8?B?MXdqRCt4cUE1L2h4MmNQWDVmVWNpeFVENnpzYm1BeEdZSThBZE5ndkV6Rjh4?=
 =?utf-8?B?b0ZNWUFjcjdNSWc0eUUwL0I2VldmUmtmdlRjRTJQVFh3ZE9Ocjd1LzdrRm1m?=
 =?utf-8?B?bi9WTlhQSTV6TWZnc3EvN2ZZMHVkbVZkR1h0WHRMSlY1V0EyYkRZMnRZdFUv?=
 =?utf-8?B?QmlhREwxWW1sWUxBOEpieSt4R21xdU9zY2NObmFkK1hyZ05STU50ZG9SYjlQ?=
 =?utf-8?B?T25GeDR2cys5Z2xXc1dreUVOcFU2eUhrSGpiMzV4MDdOM3BCbUIxNHU1MEtT?=
 =?utf-8?B?NHBNb08rTW9SejdNYnlnbTB6WlJuQWgrV0lmUlluMTB5bU1kTWlHR3o0UllM?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <134C9D156AE08442B3D0468875333651@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0a3a22-7eb9-4104-e28f-08dc06a2e18f
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 06:13:01.8060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vHE8j3SUff/oHoxNy02JWQYF+5oWxqYrsWTM9c/IzEHw/kI1Z57iReIMmXMyas9dqcCJb1pRWFuXqDGPAkYsV9tGliz3kNYAtbVqUrTjXQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8482
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.764800-8.000000
X-TMASE-MatchedRID: VPleTT1nwdSnykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/mNRhvDVinvypf
	0VJZhlxP3gb7k6xpVN4a/3L93pcprQTsy5Ctk/ajdAg4yd14qAQxmbT6wQT2a/t592eq2xoTHye
	T8VIiNb6ykaH8ZceX1bWrjxGHjCv1oqIp1AUZB5rRfDQgu+j+5SlayzmQ9QV0TUobVis5Bb8+UX
	k3m3aAv/HvqvD8PlimkZOl7WKIImrS77Co4bNJXQtuKBGekqUpPjKoPgsq7cA=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.764800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0F1742E4A1E3BEAC76E5646EA701BDC79F0EA162E891CC5101CD282C4FADC9802000:8

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0yNiBh
dCAwNjo0NiArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0xMi0yMiBhdCAxMjo1MiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IFRvIHN1cHBvcnQgc2VjdXJlIHZpZGVvIHBhdGggZmVhdHVyZSwgR0NFIGhhdmUgdG8g
cmVhZC93cml0ZQ0KPiA+IHJlZ2lzdGdlcnMNCj4gPiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBHQ0Ug
d2lsbCBlbmFibGUgdGhlIHNlY3VyZSBhY2Nlc3MgcGVybWlzc2lvbg0KPiA+IHRvDQo+ID4gdGhl
DQo+ID4gSFcgd2hvIHdhbnRzIHRvIGFjY2VzcyB0aGUgc2VjdXJlIGNvbnRlbnQgYnVmZmVyLg0K
PiA+IA0KPiA+IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xp
ZW50IHVzZXIgaXMgYWJsZSB0bw0KPiA+IHNlbmRpbmcgdGhlaXIgSFcgc2V0dGluZ3MgdG8gdGhl
IHNlY3VyZSB3b3JsZC4gU28gdGhhdCBHQ0UgY2FuDQo+ID4gZXhlY3V0ZQ0KPiA+IGFsbCBpbnN0
cnVjdGlvbnMgdG8gY29uZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIGludCBjbWRxX3Nl
Y19zZXNzaW9uX2luaXQoc3RydWN0IGNtZHFfc2VjX2NvbnRleHQgKmNvbnRleHQpDQo+ID4gK3sN
Cj4gPiArCWludCBlcnIgPSAwOw0KPiA+ICsNCj4gPiArCWlmIChjb250ZXh0LT5zdGF0ZSA+PSBJ
V0NfU0VTX09QRU5FRCkgew0KPiA+ICsJCXByX2RlYnVnKCJzZXNzaW9uIG9wZW5lZDoldSIsIGNv
bnRleHQtPnN0YXRlKTsNCj4gPiArCQlyZXR1cm4gMDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlz
d2l0Y2ggKGNvbnRleHQtPnN0YXRlKSB7DQo+ID4gKwljYXNlIElXQ19JTklUOg0KPiA+ICsJCWVy
ciA9IGNtZHFfc2VjX2luaXRfY29udGV4dCgmY29udGV4dC0+dGVlX2N0eCk7DQo+ID4gKwkJaWYg
KGVycikNCj4gPiArCQkJcmV0dXJuIGVycjsNCj4gPiArCQljb250ZXh0LT5zdGF0ZSA9IElXQ19D
T05URVhUX0lOSVRFRDsNCj4gPiArCWZhbGx0aHJvdWdoOw0KPiA+ICsJY2FzZSBJV0NfQ09OVEVY
VF9JTklURUQ6DQo+ID4gKwkJaWYgKGNvbnRleHQtPml3Y19tc2cpIHsNCj4gPiArCQkJcHJfZXJy
KCJpd2NNZXNzYWdlIG5vdCBOVUxMOiVwIiwgY29udGV4dC0NCj4gPiA+IGl3Y19tc2cpOw0KPiA+
IA0KPiA+ICsJCQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCWVyciA9
IGNtZHFfc2VjX2FsbG9jYXRlX3dzbSgmY29udGV4dC0+dGVlX2N0eCwNCj4gPiAmY29udGV4dC0+
aXdjX21zZywNCj4gPiArCQkJCQkgICAgc2l6ZW9mKHN0cnVjdA0KPiA+IGl3Y19jbWRxX21lc3Nh
Z2VfdCkpOw0KPiA+ICsJCWlmIChlcnIpDQo+ID4gKwkJCXJldHVybiBlcnI7DQo+ID4gKw0KPiA+
ICsJCWNvbnRleHQtPnN0YXRlID0gSVdDX1dTTV9BTExPQ0FURUQ7DQo+ID4gKwlmYWxsdGhyb3Vn
aDsNCj4gDQo+IFNxdWFzaCBjbWRxX3NlY19zZXNzaW9uX2luaXQoKSBpbnRvIGNtZHFfc2VjX21i
b3hfb2ZfeGxhdGUoKSBhbmQgZHJvcA0KPiB0aGUgY29udGV4dC0+c3RhdGUuDQo+IA0KPiBSZWdh
cmRzLA0KPiBDSw0KPiANCmNtZHFfc2VjX3Nlc3Npb25faW5pdCgpIGlzIGNhbGxlZCBpbiB0aGUg
Zmlyc3QgY21kcV9zZWNfdGFza19zdWJtaXQoKS4NCkl0IG1lYW5zIHdlIGRvbid0IG5lZWQgdG8g
Y29ubmVjdCBhIHNlc3Npb24gdG8gVEVFIG9yIGFsbG9jYXRlIHNoYXJlDQptZW1vcnkgaWYgbm8g
b25lIHN1Ym1pdCBzZWN1cmUgdGFzay4NCg0KT24gdGhlIG90aGVyIGhhbmQsIG9wdGVlIG1heSBs
b2FkIHNsb3dlciB0aGFuIGNtZHEgc2VjdXJlIGRyaXZlci4gSWYgd2UNCm1vdmUgaXQgdG8geGxh
dGUgc2VjdXJlIHNlc3Npb24gbWF5IGluaXQgZmFpbC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxp
bg0K

