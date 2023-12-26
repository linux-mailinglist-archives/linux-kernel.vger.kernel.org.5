Return-Path: <linux-kernel+bounces-11386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2175D81E575
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:15:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13FB1C210A3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F1A4C3C1;
	Tue, 26 Dec 2023 06:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I7w7Jle9";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TAHEbQ6J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685564C3A0;
	Tue, 26 Dec 2023 06:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 26d01a18a3b611eea5db2bebc7c28f94-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=buodGxTirniZEaDYoO0y/Sku3gxbfKp2OHhYm+eMq6A=;
	b=I7w7Jle9+MXLToI3ViUSGUw+Px2xESGXBM/8FwCiLYD+xhnM99vR8PvyjY+rYVxIIuuhksUFjPZXbMNSGzJ5YTFNllV2enda+nI8Ike1qP7t03iCxoV5WUn3ZJWsgzG2ZaIVBpZWCg4O2e+fD/51i7MM+VPV0KNWTDaVsEtPLco=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:68a22cd2-063b-4404-a848-dd059d7aeebf,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:b032ac7e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 26d01a18a3b611eea5db2bebc7c28f94-20231226
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1509537072; Tue, 26 Dec 2023 14:15:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 14:15:20 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 14:15:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2M+dZ1w+WBwS/Y0qp8CvtFlMhFDBalEs3TzzsqfzZWknfbtIPj9s7j3UzboL0KSG2QC6fUDAOuMN7U3IAt9wyyhDC1fa3iwns0O08xbvQAk3n8xouHcJ1KUeYbQVdx4X+fmf06p0mpgEf4SPeZ73R72JwPqdqBTc3s0GeV+9DJbclRMSYWdjnc8QnQpM4t8JhXr6PuufRr5ZZgsiPkpPARhnjFRW+naF2DYXuZg7dGHmowZVwkc99TABZfucd8hP7XHOT32v8S/odNOm926NiBIj1Gf4UX9xDFAR6OjOQv3XfdlcLO0DM4joYTrxaXimncI6lqDeIyEM+jSRjumFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=buodGxTirniZEaDYoO0y/Sku3gxbfKp2OHhYm+eMq6A=;
 b=fP2pz+ZHA27BS7Osk1xUD0+pMpFLQKSD7olpfMqtw1hj7NfNC6TYcB+P1TgCVClR/N0N7Pk/nhBVmVWd4kTOnjU0VfmgpCQsYcw3IDYRAA68qUAXMT0u1s+BPHNJxo0DRR7rmvxxywZhCYi16fw0QyPKU5diqqPx1gy1IYQQGg6NxYLpY1IPMd0ukt0mPlCDZtKhpbZ4jHor05hMK+p4Cs7OD92TTP2XII5pzseUyWJ3lZeT8LRKIcYKKFDcCS94aEhp921Q5wUbEod3Z0FKBhGz1QIcR9r46K1amy4ywUwOH+RdB3Lb53FFswJK1o1kJpUrI+j6nXDR+SkywgWwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=buodGxTirniZEaDYoO0y/Sku3gxbfKp2OHhYm+eMq6A=;
 b=TAHEbQ6JN1u9Lg+yfDxqpz6m7yiLvnc3U1V3v/1s1D1488Axaynbbl5n+nJCpZm2/UA5LL+XT5FWFw/duuSjs7lvetUDJiTXoslxYr6yCQ3nhWE4G8yZ/PG0m2bXFBHQa5aFim+PIiTGhLB5oa5noWRisJ8DjdsvRF0WR1gGcwM=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB5537.apcprd03.prod.outlook.com (2603:1096:820:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 06:15:18 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 06:15:18 +0000
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C7HKSA
Date: Tue, 26 Dec 2023 06:15:18 +0000
Message-ID: <8234222df9443008db31158bfb7f203da9d5b4f0.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB5537:EE_
x-ms-office365-filtering-correlation-id: f1bb817c-759d-4046-14cb-08dc05da085b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDAlFRFFIzGy3NOvqsYv4g4t1psM/y2Z171mtjLCwtorkEFHjPZ2n71LdgD8eJSYnAJgp1guL6Hucx1aiZS8Q8CSHQgUZ229OPkhD47pCaac0Nh0ixUF1rKnjPToXwhHGQV2Zpfp4T5wVvaFuKADwQC1lIyAqoyTFn+g/9fLO5MN77NR7m7w/jSaRYL+654nwWIAK9yQZOG4FAV65+o31MqGmKpQHbi6qdComvGCtfbo3u5nU2aDCv2zYNFEFdz5oGb4zaxZlOsYS+svKxdATcnCS+Gcc+MfBo/FWgFJzxkl7TZ4zwCo+nMGBLvrZTTJ5QMnNNVTa+Jri5Ss7G0pdHyu+Qdy7lbIQI5tIy19ddq9vIlLv7J1VFk5EaiscebHUEzxnT1CTtd6+oTl3TAhAUiTaZPHDmHp5nvaVx6cxeAp/2NOlQLiFYXacO9+A3s25cPl+C20Yygpne3XP0l3HoTfBOUx9jM/nov9vPCbnI66ccKISRG1uBdA0TerPrBe9N+HDrVoimPoebLRr8okX634ShYirneX9g2MmJ6od6KTq7uzhDIS121C6DoWH5yKdcT97l4Ky9FIs7z/I+2R8fq62H0o5xT7rruC5Tk37ZKKFTgsKUPzusaAmIT0VLmK25rHayXFAsrRi8+THff9Lq1c7AgNOtaacWT1LrZFsKs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(366004)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(36756003)(85182001)(71200400001)(6512007)(6506007)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6486002)(86362001)(38070700009)(26005)(38100700002)(122000001)(83380400001)(2616005)(41300700001)(2906002)(15650500001)(5660300002)(4001150100001)(8936002)(7416002)(8676002)(478600001)(316002)(54906003)(4326008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bEdGMmRaWCtRNXNrTU1HVXNRVmlpaWZxMmdvQ0xaR1pkdXZacXo1NUFXYWxS?=
 =?utf-8?B?dmhHMGRPRVpiV1gwVm91MU5SVzVUOVJyUVBLc2FwZ3doeGp0VnFzdU01S00w?=
 =?utf-8?B?TG1ENktDMnJndWFKL1E4K3VqTTVkaTFtSXNvaUEzU3ZLTFRqQnZ0U0VaVWtM?=
 =?utf-8?B?UnlXb3ZRWFdCWkgxYUw1enhHL3VLNHBJc2lTaGY3aGFPa25XQmVqYVV2STBU?=
 =?utf-8?B?VEhuV2lNSG9DRXdUUEpRUDNsVHc2TTJJUnV0U2FMWlE0N0lleXFjaHpTaWh5?=
 =?utf-8?B?ZU9nWk00SDJhV2ozMWFxbmpMWmYrS3dVUUh3RytDQWF2UnpvdTZiRG5LQXlF?=
 =?utf-8?B?SDJCOGFhVmNhaFNQcW1NYUFJaldEaldHVVZwWE9DdUxsTVdoQkZJd2V1citU?=
 =?utf-8?B?TFJ0U20raHdkcWlka0UwM2ZiVXRxajd1RnhEZjl4M1lUdWpQeElJNFpKYzNj?=
 =?utf-8?B?QTY2cjB5SjREVVFidjBMMU1wTHd5SklGeUZQWnRXemlid0VTNjMvMnBURytR?=
 =?utf-8?B?bXlOMnM2ZGxKQmNLaDZldzFJYzZpRDhoOEVXQVlocGdZNHk0L3JHVjJyWnQr?=
 =?utf-8?B?czBZQ1g5SlBCbXFoZEd1aXNoa2dmYnBZN0t0bERWbWdJTEJZRDdod0lGV3lC?=
 =?utf-8?B?QTFZSHVzWDBtTkYxTFhhN3AxK3JEOS84OTh6Qm1HSUVLbm9Pek5XeDYrcG5p?=
 =?utf-8?B?a2EzWjYybXpPeWhjMEU4c29mUHcxSWtxZ2RWU3JzQ0xPcXY4MFpuaVlxU3BZ?=
 =?utf-8?B?VW9GYmdqUWloWDZNTDJpT0U0UDdZdnMyWWwvTHU0QlJZRmFVbTdUZEJud0VY?=
 =?utf-8?B?Z0FZZzNqK3FBSytuNSt0MkZXN1RBb0kwMmlYMmFvYkg2N1ErcHJ5ejcyaFdO?=
 =?utf-8?B?TVVCMHphU1B4Rmd0dzE2QmpQZm15YkFvOHBsZGZ3ZE1CQkVkWXM4YUxzVWZ3?=
 =?utf-8?B?L1lGdlVLbFJ2K3RvOEp1dDgrNlFVWHpqQUt1RDRTUHl4OVZ5eHQ2WW1TdFJJ?=
 =?utf-8?B?MTlSeCtwWFJ5SlkwNnlBSWFpbVA3VTl4OEhSdnNWMGRqb2RtL1BHZnhUdld6?=
 =?utf-8?B?L3FmVUhzNFdhbE8wYUkwdmJ4aW1vejdaUm9aMXFOWTllU2RSNGwwSTRocGx3?=
 =?utf-8?B?RGd0UklWa1NhaEFqbHZvNXJuSVZ4aUQzWWkyS3E2aDZLK2JyQ1lvTFd6bHJS?=
 =?utf-8?B?RUcxWi9OaUwrWW0vZzRmempkZjU4czZjZHB6VVRaOFJlcSttMTJoaG1nREcx?=
 =?utf-8?B?R3JsWTUwcnZWNnJ4Q2s0Qlp6Y2JuQTJROVFqd09VcGh5VTZ4TjVZbCt3V1VG?=
 =?utf-8?B?UnlvNFBtZFl3aGx4dERmZkw1Z0VoSUMrM29WdEYwYzNYN3dIbkNBNDlEN1JH?=
 =?utf-8?B?RHptUEZ6bW81OU5kdzRVS1pDZDhPc3N0QlB5dkxzbkR3WHJTeWl2M1FST0Rs?=
 =?utf-8?B?L0FJcE1PWnhDSzdlalVDVTAyZFFjNzNQTFptNHBqVWtXRFh6dmphSDRzNXd3?=
 =?utf-8?B?QlJWZEpMV1pqUDk4WW1xc0U0NEp3VlJXS0JlVzNmRkx5OUNFemR4MDl2VGUv?=
 =?utf-8?B?b0kxanZIWXpIbStpYXpZVkZXZDRRL3pjWHZCTlorWjg4blZqVmM1WDA4RnVY?=
 =?utf-8?B?b3daWDV6Z1FrVEZxTGRRYWYxb0N2NWhwOC9NTVBsWmRkMWdmTEErOEViTnRh?=
 =?utf-8?B?b2s0T3o4K0poS0NzajVrWnI1aXdJc1dJMkdzWGVINkJZaWxsdlVsbllJSnZL?=
 =?utf-8?B?by93K1lxU015VEhXWlpoU0lkdlVpd2pRQUdTeHY5ZWc4eUxFVlphVDFhVDI3?=
 =?utf-8?B?VnZOOS96WVZpOE01VmVCcWQrdHZWYXFOVnptTDlBOU5OaDNjNCtvRWJib2Z6?=
 =?utf-8?B?aTZsQ2xsajV4dEhtRVZnTTNndXFtNkVoajIrNEE0L2poNXVYRzZxZnVKYS8x?=
 =?utf-8?B?L3VEQ0NhN0J6MUtlMWY3OUJzWmdKbnVEMm5nTU1KVVJWSkpBVTdOczhmZkJS?=
 =?utf-8?B?MHZhUmx6V2dRUWNhUk9ZV21PUW1zSmdMRS9qS3A5QWFTaDlVUGJ6b1UzU0d4?=
 =?utf-8?B?emJzQVlNalBVUlVrUVpNZjl2Q0tTVVVtYVZTekpNMlhxY3Vvb3VQY0VVSXFj?=
 =?utf-8?Q?U9eiKjNg3/bk0KCm35dviGT4o?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10148BD1C239564B80D43E4C6FCD4D6A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bb817c-759d-4046-14cb-08dc05da085b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 06:15:18.0495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEa7WHcTJ+ttatIX1nNhUeWt6nj1LZHUQ7s5GZ+PaAQUI2kofYjR+jqy8O//c0vy8DuDXoeIwPWEKugWYWb89g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5537
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.309400-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2oOwH4pD14DsPHkpkyUphL9qQ9UezeTkThu4FknyqyshF1Q
	po5pNysMe29pTfBhqOY7b3Js3F6vVD1LciJB3541o65WJt1k1O8TbU1KYGoQp3vsbfoZixUT3oz
	JRX7b4NnONwCKwD2eBY7n73EIhmk2idh40yl3wZB05zsoB1UKTv+UEb65dgmQ4uxAgOavdLltgT
	FkLUu6pskF/UjPg4V5Vl+hnGukUcBAJLhqw2sfjfSG/+sPtZVkHIOuQjCOKFubKItl61J/yfmS+
	aPr0Ve8oTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/se1bP9VgCQwhVMPihBnbeOcn78Wb/ZbDVsLh7
	/pQVtq8Ke2M8Euargw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.309400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2FAE85DF8F5ACC069546088BEEA9A7AEA27D6569B7F5FAC32D4DE8CE9B2592902000:8

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
PiArDQo+ICtzdGF0aWMgdm9pZCBjbWRxX3NlY190YXNrX2V4ZWNfd29yayhzdHJ1Y3Qgd29ya19z
dHJ1Y3QgKndvcmtfaXRlbSkNCj4gK3sNCj4gKwlzdHJ1Y3QgY21kcV9zZWNfdGFzayAqc2VjX3Rh
c2sgPSBjb250YWluZXJfb2Yod29ya19pdGVtLA0KPiArCQkJCQkJICAgICAgc3RydWN0DQo+IGNt
ZHFfc2VjX3Rhc2ssIGV4ZWNfd29yayk7DQo+ICsJc3RydWN0IGNtZHFfc2VjX3RocmVhZCAqc2Vj
X3RocmVhZCA9IGNvbnRhaW5lcl9vZihzZWNfdGFzay0NCj4gPnRhc2sudGhyZWFkLA0KPiArCQkJ
CQkJCSBzdHJ1Y3QNCj4gY21kcV9zZWNfdGhyZWFkLCB0aHJlYWQpOw0KPiArCXN0cnVjdCBjbWRx
X3NlYyAqY21kcSA9IGNvbnRhaW5lcl9vZihzZWNfdGhyZWFkLT50aHJlYWQuY2hhbi0NCj4gPm1i
b3gsDQo+ICsJCQkJCSAgICAgc3RydWN0IGNtZHFfc2VjLCBtYm94KTsNCj4gKwlzdHJ1Y3QgY21k
cV9zZWNfZGF0YSAqZGF0YTsNCj4gKwl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiArCWludCBlcnI7
DQo+ICsNCj4gKwlkZXZfZGJnKGNtZHEtPm1ib3guZGV2LCAiJXMgZ2NlOiUjbHggc2VjX3Rhc2s6
JXAgcGt0OiVwDQo+IHRocmVhZDoldSIsDQo+ICsJCV9fZnVuY19fLCAodW5zaWduZWQgbG9uZylj
bWRxLT5iYXNlX3BhLA0KPiArCQlzZWNfdGFzaywgc2VjX3Rhc2stPnRhc2sucGt0LCBzZWNfdGhy
ZWFkLT5pZHgpOw0KPiArDQo+ICsJaWYgKCFzZWNfdGFzay0+dGFzay5wa3QtPnNlY19kYXRhKSB7
DQo+ICsJCWRldl9lcnIoY21kcS0+bWJveC5kZXYsICJwa3Q6JXAgd2l0aG91dCBzZWNfZGF0YSIs
DQo+IHNlY190YXNrLT50YXNrLnBrdCk7DQo+ICsJCXJldHVybjsNCj4gKwl9DQo+ICsJZGF0YSA9
IChzdHJ1Y3QgY21kcV9zZWNfZGF0YSAqKXNlY190YXNrLT50YXNrLnBrdC0+c2VjX2RhdGE7DQo+
ICsNCj4gKwltdXRleF9sb2NrKCZjbWRxLT5leGVjX2xvY2spOw0KPiArDQo+ICsJc3Bpbl9sb2Nr
X2lycXNhdmUoJnNlY190aHJlYWQtPnRocmVhZC5jaGFuLT5sb2NrLCBmbGFncyk7DQo+ICsJaWYg
KCFzZWNfdGhyZWFkLT50YXNrX2NudCkgew0KPiArCQltb2RfdGltZXIoJnNlY190aHJlYWQtPnRp
bWVvdXQsIGppZmZpZXMgKw0KPiArCQkJICBtc2Vjc190b19qaWZmaWVzKHNlY190aHJlYWQtPnRp
bWVvdXRfbXMpKTsNCj4gKwkJc2VjX3RocmVhZC0+d2FpdF9jb29raWUgPSAxOw0KPiArCQlzZWNf
dGhyZWFkLT5uZXh0X2Nvb2tpZSA9IDE7DQo+ICsJCXNlY190aHJlYWQtPnRhc2tfY250ID0gMDsN
Cj4gKwkJX19yYXdfd3JpdGVsKDAsICh2b2lkIF9faW9tZW0gKiljbWRxLT5zaGFyZWRfbWVtLT52
YSArDQo+ICsJCQkgICAgIENNRFFfU0VDX1NIQVJFRF9USFJfQ05UX09GRlNFVCArDQo+IHNlY190
aHJlYWQtPmlkeCAqIHNpemVvZih1MzIpKTsNCj4gKwl9DQo+ICsNCj4gKwlzZWNfdGFzay0+cmVz
ZXRfZXhlYyA9IHNlY190aHJlYWQtPnRhc2tfY250ID8gZmFsc2UgOiB0cnVlOw0KPiArCXNlY190
YXNrLT53YWl0X2Nvb2tpZSA9IHNlY190aHJlYWQtPm5leHRfY29va2llOw0KPiArCXNlY190aHJl
YWQtPm5leHRfY29va2llID0gKHNlY190aHJlYWQtPm5leHRfY29va2llICsgMSkgJQ0KPiBDTURR
X01BWF9DT09LSUVfVkFMVUU7DQo+ICsJbGlzdF9hZGRfdGFpbCgmc2VjX3Rhc2stPnRhc2subGlz
dF9lbnRyeSwgJnNlY190aHJlYWQtDQo+ID50aHJlYWQudGFza19idXN5X2xpc3QpOw0KPiArCXNl
Y190aHJlYWQtPnRhc2tfY250ICs9IDE7DQo+ICsJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmc2Vj
X3RocmVhZC0+dGhyZWFkLmNoYW4tPmxvY2ssIGZsYWdzKTsNCj4gKwlzZWNfdGFzay0+dHJpZ2dl
ciA9IHNjaGVkX2Nsb2NrKCk7DQo+ICsNCj4gKwlpZiAoIWF0b21pY19jbXB4Y2hnKCZjbWRxX3Bh
dGhfcmVzLCAwLCAxKSkgew0KPiArCQllcnIgPSBjbWRxX3NlY190YXNrX3N1Ym1pdChjbWRxLCBO
VUxMLA0KPiBDTURfQ01EUV9JV0NfUEFUSF9SRVNfQUxMT0NBVEUsDQo+ICsJCQkJCSAgIENNRFFf
SU5WQUxJRF9USFJFQUQsIE5VTEwpOw0KPiArCQlpZiAoZXJyKSB7DQo+ICsJCQlhdG9taWNfc2V0
KCZjbWRxX3BhdGhfcmVzLCAwKTsNCj4gKwkJCWdvdG8gdGFza19lbmQ7DQo+ICsJCX0NCj4gKwl9
DQo+ICsNCj4gKwlpZiAoc2VjX3RocmVhZC0+dGFza19jbnQgPiBDTURRX01BWF9UQVNLX0lOX1NF
Q1VSRV9USFJFQUQpIHsNCj4gKwkJZGV2X2VycihjbWRxLT5tYm94LmRldiwgInRhc2tfY250OiV1
IGNhbm5vdCBtb3JlIHRoYW4NCj4gJXUgc2VjX3Rhc2s6JXAgdGhyZWFkOiV1IiwNCj4gKwkJCXNl
Y190aHJlYWQtPnRhc2tfY250LA0KPiBDTURRX01BWF9UQVNLX0lOX1NFQ1VSRV9USFJFQUQsDQo+
ICsJCQlzZWNfdGFzaywgc2VjX3RocmVhZC0+aWR4KTsNCj4gKwkJZXJyID0gLUVNU0dTSVpFOw0K
PiArCQlnb3RvIHRhc2tfZW5kOw0KPiArCX0NCj4gKw0KPiArCWVyciA9IGNtZHFfc2VjX3Rhc2tf
c3VibWl0KGNtZHEsIHNlY190YXNrLA0KPiBDTURfQ01EUV9JV0NfU1VCTUlUX1RBU0ssDQo+ICsJ
CQkJICAgc2VjX3RocmVhZC0+aWR4LCBOVUxMKTsNCj4gKwlpZiAoZXJyKQ0KPiArCQlkZXZfZXJy
KGNtZHEtPm1ib3guZGV2LCAiY21kcV9zZWNfdGFza19zdWJtaXQgZXJyOiVkDQo+IHNlY190YXNr
OiVwIHRocmVhZDoldSIsDQo+ICsJCQllcnIsIHNlY190YXNrLCBzZWNfdGhyZWFkLT5pZHgpOw0K
PiArDQo+ICt0YXNrX2VuZDoNCj4gKwlpZiAoZXJyKSB7DQo+ICsJCXN0cnVjdCBjbWRxX2NiX2Rh
dGEgY2JfZGF0YTsNCj4gKw0KPiArCQljYl9kYXRhLnN0YSA9IGVycjsNCj4gKwkJY2JfZGF0YS5w
a3QgPSBzZWNfdGFzay0+dGFzay5wa3Q7DQo+ICsJCW1ib3hfY2hhbl9yZWNlaXZlZF9kYXRhKHNl
Y190aHJlYWQtPnRocmVhZC5jaGFuLA0KPiAmY2JfZGF0YSk7DQo+ICsNCj4gKwkJc3Bpbl9sb2Nr
X2lycXNhdmUoJnNlY190aHJlYWQtPnRocmVhZC5jaGFuLT5sb2NrLA0KPiBmbGFncyk7DQo+ICsJ
CWlmICghc2VjX3RocmVhZC0+dGFza19jbnQpDQo+ICsJCQlkZXZfZXJyKGNtZHEtPm1ib3guZGV2
LCAidGhyZWFkOiV1IHRhc2tfY250OiV1DQo+IGNhbm5vdCBiZWxvdyB6ZXJvIiwNCj4gKwkJCQlz
ZWNfdGhyZWFkLT5pZHgsIHNlY190aHJlYWQtPnRhc2tfY250KTsNCj4gKwkJZWxzZQ0KPiArCQkJ
c2VjX3RocmVhZC0+dGFza19jbnQgLT0gMTsNCj4gKw0KPiArCQlzZWNfdGhyZWFkLT5uZXh0X2Nv
b2tpZSA9IChzZWNfdGhyZWFkLT5uZXh0X2Nvb2tpZSAtIDENCj4gKw0KPiArCQkJQ01EUV9NQVhf
Q09PS0lFX1ZBTFVFKSAlIENNRFFfTUFYX0NPT0tJRV9WQUxVRTsNCj4gKwkJbGlzdF9kZWwoJnNl
Y190YXNrLT50YXNrLmxpc3RfZW50cnkpOw0KPiArCQlkZXZfZGJnKGNtZHEtPm1ib3guZGV2LCAi
Z2NlOiUjbHggZXJyOiVkIHNlY190YXNrOiVwDQo+IHBrdDolcCIsDQo+ICsJCQkodW5zaWduZWQg
bG9uZyljbWRxLT5iYXNlX3BhLCBlcnIsIHNlY190YXNrLA0KPiBzZWNfdGFzay0+dGFzay5wa3Qp
Ow0KPiArCQlkZXZfZGJnKGNtZHEtPm1ib3guZGV2LCAidGhyZWFkOiV1IHRhc2tfY250OiV1DQo+
IHdhaXRfY29va2llOiV1IG5leHRfY29va2llOiV1IiwNCj4gKwkJCXNlY190aHJlYWQtPmlkeCwg
c2VjX3RocmVhZC0+dGFza19jbnQsDQo+ICsJCQlzZWNfdGhyZWFkLT53YWl0X2Nvb2tpZSwgc2Vj
X3RocmVhZC0NCj4gPm5leHRfY29va2llKTsNCj4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
c2VjX3RocmVhZC0+dGhyZWFkLmNoYW4tPmxvY2ssDQo+IGZsYWdzKTsNCj4gKw0KPiArCQlrZnJl
ZShzZWNfdGFzayk7DQo+ICsJfQ0KPiArDQo+ICsJbXV0ZXhfdW5sb2NrKCZjbWRxLT5leGVjX2xv
Y2spOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGNtZHFfc2VjX21ib3hfc2VuZF9kYXRhKHN0
cnVjdCBtYm94X2NoYW4gKmNoYW4sIHZvaWQNCj4gKmRhdGEpDQo+ICt7DQo+ICsJc3RydWN0IGNt
ZHFfcGt0ICpwa3QgPSAoc3RydWN0IGNtZHFfcGt0ICopZGF0YTsNCj4gKwlzdHJ1Y3QgY21kcV9z
ZWNfZGF0YSAqc2VjX2RhdGEgPSAoc3RydWN0IGNtZHFfc2VjX2RhdGEgKilwa3QtDQo+ID5zZWNf
ZGF0YTsNCj4gKwlzdHJ1Y3QgY21kcV90aHJlYWQgKnRocmVhZCA9IChzdHJ1Y3QgY21kcV90aHJl
YWQgKiljaGFuLQ0KPiA+Y29uX3ByaXY7DQo+ICsJc3RydWN0IGNtZHFfc2VjX3RocmVhZCAqc2Vj
X3RocmVhZCA9IGNvbnRhaW5lcl9vZih0aHJlYWQsDQo+IHN0cnVjdCBjbWRxX3NlY190aHJlYWQs
IHRocmVhZCk7DQo+ICsJc3RydWN0IGNtZHFfc2VjX3Rhc2sgKnNlY190YXNrOw0KPiArDQo+ICsJ
aWYgKCFzZWNfZGF0YSkNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsNCj4gKwlzZWNfdGFzayA9
IGt6YWxsb2Moc2l6ZW9mKCpzZWNfdGFzayksIEdGUF9BVE9NSUMpOw0KPiArCWlmICghc2VjX3Rh
c2spDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KPiArDQo+ICsJc2VjX3Rhc2stPnRhc2sucGt0ID0g
cGt0Ow0KPiArCXNlY190YXNrLT50YXNrLnRocmVhZCA9IHRocmVhZDsNCj4gKwlzZWNfdGFzay0+
c2NlbmFyaW8gPSBzZWNfZGF0YS0+c2NlbmFyaW87DQo+ICsJc2VjX3Rhc2stPmVuZ2luZV9mbGFn
ID0gc2VjX2RhdGEtPmVuZ3NfbmVlZF9kYXBjIHwgc2VjX2RhdGEtDQo+ID5lbmdzX25lZWRfc2Vj
X3BvcnQ7DQo+ICsNCj4gKwlJTklUX1dPUksoJnNlY190YXNrLT5leGVjX3dvcmssIGNtZHFfc2Vj
X3Rhc2tfZXhlY193b3JrKTsNCj4gKwlxdWV1ZV93b3JrKHNlY190aHJlYWQtPnRhc2tfZXhlY193
cSwgJnNlY190YXNrLT5leGVjX3dvcmspOw0KDQpJdCdzIG5vdCBuZWNlc3NhcnkgdG8gcXVldWUg
YSB3b3JrIGhlcmUuIFNxdWFzaA0KY21kcV9zZWNfdGFza19leGVjX3dvcmsoKSBpbnRvIHRoaXMg
ZnVuY3Rpb24uDQoNClJlZ2FyZHMsDQpDSw0KDQoNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKw0K

