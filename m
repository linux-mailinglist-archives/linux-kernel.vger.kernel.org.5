Return-Path: <linux-kernel+bounces-11393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FD881E58C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBE21C215EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEC14C604;
	Tue, 26 Dec 2023 06:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gblq/NAu";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="hYNDeTrQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC333986;
	Tue, 26 Dec 2023 06:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 71e3797ea3ba11eea5db2bebc7c28f94-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k7GNgh97iFH+X9r0OVICZxy64vjP12BxluoPwC3tfZM=;
	b=gblq/NAux9SHoPwfVJ9H6spY2gkjZT+tBALQjptf7zTOcxYquF9YqQr7hDpC3xRTFQZFcGXbvXy1wEvFGdDAggKrzqmQoxgH5n9RA+/esyP1sqQWh9K5JKycq5kso/0qluIK2faShGJYHBEOKu9TqBp/xdKKd1dUnNxnY+xijpc=;
X-CID-CACHE: Type:Local,Time:202312261415+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:bf905218-22df-43f8-b7c0-6d52a0a58a0c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:b032ac7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 71e3797ea3ba11eea5db2bebc7c28f94-20231226
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 949010238; Tue, 26 Dec 2023 14:46:06 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 14:46:04 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 14:46:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Densxt3qjUrWg7AJMn+2N9h0CtZ3BrN43Q4jVBiVueW5h02f0XKGnwZGpewBGWEje8AHxnRRsfaQlRT1sdfBZtaVYALzHJS6FavVUciDMrHHmWGp7v93Kii3+SvwDI5jAT2ejvhZwI7k6fCW3dkjztqERPCpXTIPWdacf+Q432AyihZCmE2I7eA1JHsklVTdyL0SnSKQJ85xS8OEqA8U3/5PPV7WrQJWhdy8gequ/Grsyybi8XCZnN5CSR7wyS7el1GF9NnjI/I7eq9tTFM+b1YvY3UdSHYXDrpPRAJyyLQkNroHkIAr8wyT9nsxzHyNPm5aOB4hDj8hAcXq3/yvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7GNgh97iFH+X9r0OVICZxy64vjP12BxluoPwC3tfZM=;
 b=apQQ5u8AbQRJFT185WrazpbhV/tCqYuXSx8yD4msrM5P73aYC5lJ4hjUJ+m1lEsZXe712CgNxZCldG6cnWhqWJMih+Ut8C44iBd0wbW+dkuHvxJaa01IFqbMIS9bXthtt4//wkR6xSlMwEwWr38jc87PYRAcLFwuahgUzbfLXNWZDOy9IwNEhCIQvrpbt/BV0F0OyQ+TPaC1cYYkQjDBNvg/R47sLqfY3XQvuXg3kj+MXlDz/N6XyudUPQQM/8L2VBNzg6d6sRw4mr9wrSqcIJWaBdQ5Uz3z9d8r6S5fNUX8QPYvH8lDTb2RKYIdEi/Ry4ea6y1/HhTkajfPYyZbHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k7GNgh97iFH+X9r0OVICZxy64vjP12BxluoPwC3tfZM=;
 b=hYNDeTrQo/TxqOzPXRZWkxt8kWKdwOeeLJX9QZWf5Z4gFmPAKNNUnVvKDP4yX7eR3+H2mNcmhbb931qBosDyQs3BiMgR+ErLAVB2jy50xXWABbNivf3PSUIrgUNC4iPEJeZ9hXQCqRTs8kGxnl/e1G1sVdYb7mLQygbkO3eKW1U=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB7644.apcprd03.prod.outlook.com (2603:1096:400:416::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 06:46:02 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 06:46:02 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C7JTqA
Date: Tue, 26 Dec 2023 06:46:02 +0000
Message-ID: <957c5ec4fe3a1ad6eb44df37bd68cfedfcb0b926.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20231222045228.27826-9-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB7644:EE_
x-ms-office365-filtering-correlation-id: 4b1be864-8674-4430-ede4-08dc05de53a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xz/np5mxNsxnvyzdbODMFc7W9ViSOh+3t0tUY/c4xw05ySb2HDgrA6nKB8/kh5Zi4p11i2vVPBfDJKNlV6pEmvrprHI+Jf+WEU1+AomQYK+ZEvD6NvwMMLCY5slwyHDvQ2rs0Kmm7nnMnWJfCLxLpfrGPBzq10XIiPFgOobfq/vvOCZc6vkhjnqiulT83gTCc5n4d53dB9DZ7lNjeKFidpi8T3ZTlP+Q/+N23wBfJJvIl69dE/FYy3vdztec43nyKu/ivfdzpTF3KTO0vAux6VUimzjXc/VsnpVGGwnSHIpm0bxMC+BNx9zI26pUkT5XSSZN+Q123lxuK+RQHqG1VWr5D8qnwDdLcn1lPxUZpUsC0PuWWRJUJHUlcLgO8SzccNFfjlhGrYHh4NzHRVgDPk2rH1jqzZq8yubCkNAemXXjhRPTipaW+dVzp/fat5ekJApIbraOjYduYZM+crpqfOHYx0XSsZrEUHBfFmq1l0BtZ5Rlg0OOkZysriXMdpj+P//8NKSFMCrHxzYVjjfxLdmfQHbaLRBO7tzvZ0F6zgyVFcXkx0Ad7Qus6aod+6IlODuDVl6BFVOAshDgN//1bL97Ch4j+QFEzoCQkGmFPlwwq+S8WEPg+SONzHXHOVxJ+epgHOZAqoPaL4TAbDxPeGZpbEMmHzM7zyzQGieTZzQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(136003)(39860400002)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38070700009)(83380400001)(91956017)(76116006)(316002)(66556008)(66446008)(64756008)(54906003)(66946007)(66476007)(6512007)(6506007)(110136005)(8936002)(4326008)(8676002)(71200400001)(2616005)(478600001)(26005)(41300700001)(6486002)(38100700002)(5660300002)(4001150100001)(15650500001)(2906002)(7416002)(122000001)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V09QOFlvbWhEQStMWEZNbjY4aW1pOXZJU1VxOE9zSDgyNk9QYmYxT2xSRkhY?=
 =?utf-8?B?NTBrWTZBeGJzakh1bERyRjdscGd3ekVDT1B2WHZ4TUdLcyswOCtXYisxbWw0?=
 =?utf-8?B?M3lVT0RBUzBmS3dVZWpxOUxWNk5EM3dmcGx3cG5oVEk0UlNDN21uc2g2TGVC?=
 =?utf-8?B?NERtdmFJZzNLMUNpZFp5Rmw1Y2I1YWs5SjNYVzhxZWpwU25qaWxQeXV2Z1Yy?=
 =?utf-8?B?N3VaVGJjNSsraDVaVDRwWHNTQ2dBNkxISnNhdnBLSmdxMDBQbitudVJ0dHlM?=
 =?utf-8?B?c1N2STlnZkpPNHgxN25RMTVmd2hxdXM5UExXZ2Y0bVNTd2pXQjlxVnFlVFRp?=
 =?utf-8?B?ek1YYURlc1hiS2R0SGFEMXFKVjhmbDVwOGRRcGNEbUhEUDQ4YndtTGR0dmNP?=
 =?utf-8?B?bWtxaDhkUCtLKzk1U0R0bDZCcUVxUEl6WUNoTDgxQ1BlQTdyTkJSUnkvbmNV?=
 =?utf-8?B?T2JoUmpTWVo5MUpXc1JQSjVSOGtTSFFicmk2TllOVm5VaUF5UnFJSGo5WElB?=
 =?utf-8?B?M1hDb0s4NTZibDBBbVVKMklUQ1VaaE8vZU4xT3NJelZFcmxhYU1rbElKNEpU?=
 =?utf-8?B?VDVUT1dZWEV3L3lQN21XYlNSbEZFZHF1OW1tY1RYV2VmN0ZRakVzVFZac0Nq?=
 =?utf-8?B?b3FINGRDNENnbUN4TEowdFF2QTVIV2xMMGEwSWtkaUhWNzdUVGY4Y0duWDhQ?=
 =?utf-8?B?UkM1QlJpMllkUTR2MzIydytESmNBV285eWp2aUFUZ1hiV1BuU3BPMTZSWS94?=
 =?utf-8?B?dkNxN1hYVUxwOWRVakFidUtxeCtrZm4zMWJkMmcwU2VlV2xUV1V0QldYaUNJ?=
 =?utf-8?B?TFVGcEVtSS9BODFqbnhEV1o4cG9DUkc0dkkvdmxaVjhFcGdFZzlOWjU3VXhp?=
 =?utf-8?B?TUNKNVZ1OXlnWVdKSHVBdlRUSllvSjZVc01YRlhMazJpYXV5NVJZUUVLN1JF?=
 =?utf-8?B?enJyVUJwZmJ4ZWFpZHRxcStPdGdNcVBPalFQOE5XVzV4MEk0LytQbXRQNE5t?=
 =?utf-8?B?aGVmVnRzdlBGaW5VRUJhOGdIVlRXOWxzcVlDK0dvUmJQRGREOFJMamNNdytq?=
 =?utf-8?B?NVFQcFVIcWtLcFNYcW5RWDBaZm9EVHFwbGxUN1VzN3Z1a2VOWFVWVVYzSTU0?=
 =?utf-8?B?OGlZVjZDTDNXZ1loTzRQNUdUL3pFVUpia2ZoVEdQcGpFZ0tBeWE1cTM2U3ha?=
 =?utf-8?B?T0pWRGFZQW1IZ2QwSE92N0ZyWkdJbTdYRG9WZ3F5V2JJbVFmZktIdUl2TUx6?=
 =?utf-8?B?SDM3N0hXUENubVU2N25hdDBBcDl4NTZ5TUw4UmpTNjdTREs5RlFHeXNGRkxZ?=
 =?utf-8?B?T3loaXZmYXYzaFp2bEp2ZGoxekZnK2NMTmlKcEZxVGJoSVQ2QlgwYWc2NmFk?=
 =?utf-8?B?Wk1taXhPM1RJTGQwUS9JOFhmbVptTjd6NWtZNjJGNDBaK0s5VXRXT01MUVUy?=
 =?utf-8?B?bnYzVTJWWmFGejY4S3FUcU9vSjRiYlNtanR1Q1R2YytWaGpGa3dzUlVPQzNo?=
 =?utf-8?B?amFtK1ZjNVJNMTRlQ2ZKK2t4bURkOVZqZ0dwbXlwVGptL3FualpRSTNRN2tm?=
 =?utf-8?B?YXBZNUgyUGhOUUVQWS9WTDZ5YkJLd3VsOFc2dkhpbDZmUXR4V3hkRG1rUTZS?=
 =?utf-8?B?MU10bm1xR1c2b05vd0Rlam9XWWdiTkRhR2lWOGZGeHo2aHdKQW1YSGlpdHhr?=
 =?utf-8?B?OWpVRjIxd3M0UXdBMTFQd2pJMW53dkpsbnBFcGw4NFdrLytzUm9kTUZPMmJq?=
 =?utf-8?B?WCt0SzQxT1FkZGRmbDVxYzc4L3hRNnVjQTFxTmxyZTdlZjE1NjNaM0ZFUGlK?=
 =?utf-8?B?MHFRcG1QeEpabHQ4V3hSMDdLQXZuVk1ablVmVnk1b3U3bEJPUkNmTVIrN3Bi?=
 =?utf-8?B?VEV0RWlKdWJnUStGZUh1QmJqTVVPODE3KzZNWklmNFZVRzZMVjhiL2lNRUwz?=
 =?utf-8?B?dWg3Q1Y4VTJ6V09ac3AvY21OUzdJSG1rS2NoWXhCOC9QeFBxY0hMUVFGUUts?=
 =?utf-8?B?dDdzUk9DcThGMFhnUWF4dkVYbEdSbTZoem9DWGVaTWlRQXFUSUt0SGlyNkw3?=
 =?utf-8?B?TWtsWnBVZm5rd2RrRTFqVkRKaVFCVnpISzZaUGg4Ty9Kb2N0a084NU5Dbjc3?=
 =?utf-8?Q?pocld3vn/QwIUs5gDEC5oE07B?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59F8C3B3B3D9D04EA45F44B5920CEB43@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1be864-8674-4430-ede4-08dc05de53a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 06:46:02.3982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLAgj7QnkpjgBAB3y8mIHYPNPlIPhBF8OWtbXFu9zRmnJmww1aHzumfUOkK9hwKR/O+MFepgzLaZ+XHu7Pu/0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7644
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.420300-8.000000
X-TMASE-MatchedRID: cgbqQT5W8hcOwH4pD14DsPHkpkyUphL9qQ9UezeTkThu4FknyqyshF1Q
	po5pNysMe29pTfBhqOY7b3Js3F6vVD1LciJB3541o65WJt1k1O8TbU1KYGoQp3vsbfoZixUT0+K
	701J+E5gBNg4xHr352o3/d0NuPcI1mOB2bikpqTBPuMJi/ZAk8byfV74eQpk+myiLZetSf8n5kv
	mj69FXvKEwgORH8p/AjaPj0W1qn0Q7AFczfjr/7OfTQNpLSxmRO+XplXh7E3etbRFFS4SWwx3ZZ
	ytYIcZIpeNVPeL5BOo=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.420300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	4592582562D6C0EF8DC5CC1AA8DDB7E49A244647A656EBE8CFFB360906E94C8C2000:8

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjMtMTItMjIgYXQgMTI6NTIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0Ug
aGF2ZSB0byByZWFkL3dyaXRlDQo+IHJlZ2lzdGdlcnMNCj4gaW4gdGhlIHNlY3VyZSB3b3JsZC4g
R0NFIHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzIHBlcm1pc3Npb24gdG8NCj4gdGhlDQo+
IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhlIHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gDQo+
IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIg
aXMgYWJsZSB0bw0KPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29y
bGQuIFNvIHRoYXQgR0NFIGNhbg0KPiBleGVjdXRlDQo+IGFsbCBpbnN0cnVjdGlvbnMgdG8gY29u
ZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0K
PiArDQo+ICtzdGF0aWMgaW50IGNtZHFfc2VjX3Nlc3Npb25faW5pdChzdHJ1Y3QgY21kcV9zZWNf
Y29udGV4dCAqY29udGV4dCkNCj4gK3sNCj4gKwlpbnQgZXJyID0gMDsNCj4gKw0KPiArCWlmIChj
b250ZXh0LT5zdGF0ZSA+PSBJV0NfU0VTX09QRU5FRCkgew0KPiArCQlwcl9kZWJ1Zygic2Vzc2lv
biBvcGVuZWQ6JXUiLCBjb250ZXh0LT5zdGF0ZSk7DQo+ICsJCXJldHVybiAwOw0KPiArCX0NCj4g
Kw0KPiArCXN3aXRjaCAoY29udGV4dC0+c3RhdGUpIHsNCj4gKwljYXNlIElXQ19JTklUOg0KPiAr
CQllcnIgPSBjbWRxX3NlY19pbml0X2NvbnRleHQoJmNvbnRleHQtPnRlZV9jdHgpOw0KPiArCQlp
ZiAoZXJyKQ0KPiArCQkJcmV0dXJuIGVycjsNCj4gKwkJY29udGV4dC0+c3RhdGUgPSBJV0NfQ09O
VEVYVF9JTklURUQ7DQo+ICsJZmFsbHRocm91Z2g7DQo+ICsJY2FzZSBJV0NfQ09OVEVYVF9JTklU
RUQ6DQo+ICsJCWlmIChjb250ZXh0LT5pd2NfbXNnKSB7DQo+ICsJCQlwcl9lcnIoIml3Y01lc3Nh
Z2Ugbm90IE5VTEw6JXAiLCBjb250ZXh0LQ0KPiA+aXdjX21zZyk7DQo+ICsJCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gKwkJfQ0KPiArDQo+ICsJCWVyciA9IGNtZHFfc2VjX2FsbG9jYXRlX3dzbSgmY29u
dGV4dC0+dGVlX2N0eCwNCj4gJmNvbnRleHQtPml3Y19tc2csDQo+ICsJCQkJCSAgICBzaXplb2Yo
c3RydWN0DQo+IGl3Y19jbWRxX21lc3NhZ2VfdCkpOw0KPiArCQlpZiAoZXJyKQ0KPiArCQkJcmV0
dXJuIGVycjsNCj4gKw0KPiArCQljb250ZXh0LT5zdGF0ZSA9IElXQ19XU01fQUxMT0NBVEVEOw0K
PiArCWZhbGx0aHJvdWdoOw0KDQpTcXVhc2ggY21kcV9zZWNfc2Vzc2lvbl9pbml0KCkgaW50byBj
bWRxX3NlY19tYm94X29mX3hsYXRlKCkgYW5kIGRyb3ANCnRoZSBjb250ZXh0LT5zdGF0ZS4NCg0K
UmVnYXJkcywNCkNLDQoNCj4gKwljYXNlIElXQ19XU01fQUxMT0NBVEVEOg0KPiArCQllcnIgPSBj
bWRxX3NlY19vcGVuX3Nlc3Npb24oJmNvbnRleHQtPnRlZV9jdHgsIGNvbnRleHQtDQo+ID5pd2Nf
bXNnKTsNCj4gKwkJaWYgKGVycikNCj4gKwkJCXJldHVybiBlcnI7DQo+ICsNCj4gKwkJY29udGV4
dC0+c3RhdGUgPSBJV0NfU0VTX09QRU5FRDsNCj4gKwlmYWxsdGhyb3VnaDsNCj4gKwlkZWZhdWx0
Og0KPiArCQlicmVhazsNCj4gKwl9DQo+ICsNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0K

