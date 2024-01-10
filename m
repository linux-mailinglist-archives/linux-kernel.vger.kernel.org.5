Return-Path: <linux-kernel+bounces-21730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7555682936D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 029081F2297E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CCADF5B;
	Wed, 10 Jan 2024 05:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cvbRzAax";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PCPouoJ6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58980DDD1;
	Wed, 10 Jan 2024 05:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4f051b7aaf7b11ee9e680517dc993faa-20240110
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=XTWtR5oKs5BXnNVPj/KhjmlGunFCZ8V+8wQIpVvJuHY=;
	b=cvbRzAax/6mtIX9bICNdFD5b8/c101i8SdPtpRXpqnVpkgdCNSWiCfQ3NgHjknrQ6JdOXKOR7lhZ4iuGvwHjMz35by0nG8UaFubUnGFc6WAP0+Zev7hnCN18Dtn6eOU/wOMEloiIY4aQJP6rapKHq1wX/0lDcO2JojSFPYQZzuc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:42d47eb2-30f8-40a8-9204-721830c06387,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:6414168e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 4f051b7aaf7b11ee9e680517dc993faa-20240110
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <chun-jen.tseng@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 938685804; Wed, 10 Jan 2024 13:44:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Jan 2024 13:44:22 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Jan 2024 13:44:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHHdZkKYy0nO7mxwpUyZRl/ZEM8bWYSqg3xCx7JawbzAvQsum4M3+axJvo5+EBekjgM80OpfM74EipLv15g57TDHAoYmg+b5n+F30cHOnI8P/qPa04rPg7LWzMwwVAB/YO1utK5dC3d5kszaeIEqs7QQE6kyS+xJMYUAexMt2BEn3GHWKtTj8Bp4NDR9GNoEFd1NgWvnJsdVI0yiWSIo7o+6gF5FUG5wLq+4FuklGJdXUI07t17PtaKSkP7+Iv8X+KuYxtWRGXqwIn4bVTuKDbQ8t5S4x/1qWCOUlQN9wR5zGsKT8gB5u0dqXiMmlOjD6bzofv3nxtHowZOpBCfF2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XTWtR5oKs5BXnNVPj/KhjmlGunFCZ8V+8wQIpVvJuHY=;
 b=bB5Sz+NCKbsWX6p2GCb92L6WUmn6VH2z7VIipKjHhJzXy43dfeqTnyvW7KWfWdDYMrrvXJU3HFhtMF47afmqHNmzEnPCvoYCdAY1A3NyTD35k/SMnJnjMBDBV+V+TxdekK2IIW60MoijSDhqc4nGwnVpVgzAGvJF/zvhZC0SUslX5n7rLczU75si8JdB6iyOoxXnBhz6/rpqOudd1xNi4PZO8KOBBptxd+r3VPKMLRvVXdRa5xMNOe9oKNd5VOZTluPPHm8v8AdIUXVcHZBfhnyWW5ycynTJpMJ1jRltPJATzcF/Aedf6bBVrC6q4dS11JW2fxjF0ubUIA9sicnHsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XTWtR5oKs5BXnNVPj/KhjmlGunFCZ8V+8wQIpVvJuHY=;
 b=PCPouoJ6yCwMAFg7vD65vAkl4qDMl6ttw8V5gzWrT7DBgGWJkpgOfCtpL3s2LWUymumAZz0Kw1LDsSh+aIk1FnJTt2kokLdb1b6BiLCYjvqHP+8FcIMJsuR0YMCaTjEFK5wnfJHcZR1HxWhpJ+dsGCmtrYzR5DIDdAogYP09Gcs=
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com (2603:1096:301:40::11)
 by KL1PR03MB8259.apcprd03.prod.outlook.com (2603:1096:820:113::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 05:44:19 +0000
Received: from PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::e883:35a:fe3d:65b9]) by PSAPR03MB5351.apcprd03.prod.outlook.com
 ([fe80::e883:35a:fe3d:65b9%6]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 05:44:19 +0000
From: =?utf-8?B?Q2h1bi1KZW4gVHNlbmcgKOabvuS/iuS7gSk=?=
	<Chun-Jen.Tseng@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "wenst@chromium.org"
	<wenst@chromium.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: mediatek: mt8186: Increase CCI
 frequency
Thread-Topic: [PATCH v2 1/1] arm64: dts: mediatek: mt8186: Increase CCI
 frequency
Thread-Index: AQHZ5wSUhbsMZ16YIEu+XAqYgTN4rLCRwDuAgEGB1gA=
Date: Wed, 10 Jan 2024 05:44:18 +0000
Message-ID: <894594bd2adb156fa8f290f4e603edbccdbbcdab.camel@mediatek.com>
References: <20230914121035.17320-1-chun-jen.tseng@mediatek.com>
	 <20230914121035.17320-2-chun-jen.tseng@mediatek.com>
	 <c9881e63-a52a-4d14-895e-9a14d31004e3@collabora.com>
In-Reply-To: <c9881e63-a52a-4d14-895e-9a14d31004e3@collabora.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5351:EE_|KL1PR03MB8259:EE_
x-ms-office365-filtering-correlation-id: 8607a6dc-ca3a-49f1-fd74-08dc119f307d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zk9nr92ZqkSAxZl8HvVdJldL2xRhWBD1/lJ5dtBwbn5wrM16l48wz+2cCXOprFVfe6YDULiGdXJCBxjD7GJo/WW+6kQGw+v6jD5Rr0N27fp5DlodbqgsPiQiD6DeToIQpSK18kMvrPj9g+OaeXMWjufZ8P8RyndEZdSnl+fbO6V77bAXNXM2MMMa14v575R15otnAMmqlHaMb1JOQsroyGn78RCs0PDrapBMeCddxXI3bU0ayxuvYDdXHORaRbl4eDqshMHCzWX41Qhrq9pDfj353YygofSLNfl6XGjyBaiowLWnn2fkv/2T8lTn6o6ubObS4Gz4HIbH3iFM/z4wPLdFoMBPcJWSpkPnepIRsOrwIeo3tQYGsOJm7AI84yIXoku98UYh0dwQGmb0xGcXa+nAkeXD4GmlrP53R0Mt41QJDPIJ88TCoJC/zfcIHnqtGXOkMIKRkCIvVrhIWD2VJ62ta8gRMQDCgKGAVWVNNikyAvkkxRaUg8MdrvDIUnHBlb2+82KTE1dyG91XT3MU61yri8/eQ43TYNoBA2/lwfsAbjx1jpYg1uGqwf6sHrJHBrhCM/YnRt392YvgWcX/MAhXgtHev69OZMnaXQYyq5tmVB+oj8A78uJXGXYRseRnYzSRqFWXknwR4f7sECQSrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5351.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(478600001)(6506007)(966005)(71200400001)(2616005)(6512007)(76116006)(64756008)(66446008)(66556008)(66476007)(91956017)(66946007)(54906003)(110136005)(316002)(6486002)(26005)(107886003)(83380400001)(41300700001)(5660300002)(2906002)(7416002)(8676002)(8936002)(4326008)(4001150100001)(38070700009)(36756003)(85182001)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0pOZWNRWjhlcVFBK2NNWkhxYnpGTTAyalZDcWlQczBuOU5PMUs2NGttR005?=
 =?utf-8?B?TGhxYmdCSzA4M29lRllLVDFrNkZFa0NMampWYUZhR3RzeHJhTFlSc0tFZ09F?=
 =?utf-8?B?Vy9QUVpZaEpRQnI1THVqdGFnZmwrZTZlcThZTXNTM093ZDdrZGpSaStPTmQy?=
 =?utf-8?B?Q1ljSXBGQ0QvRDluTDU0U1lRekR4NXBCVGFTanpnWWpZakhYR3U2citER0hO?=
 =?utf-8?B?U3VtRUlKNzB0TjVDODloem1FdVk2US8zeU8xTno4WGRnUnl1MUJ1bkZ1ZzY3?=
 =?utf-8?B?Uy9ibS9NME9FZGZ3dWNlYlVrbjdWTklNR2ZEcVZMU2ZYWjNTNm5RTStZWkpp?=
 =?utf-8?B?OGVveEpIRkJXT2daUHJYcVJpcnJjZXZOQkRVOE42akY1WDQ0UHNkRXhLZXBq?=
 =?utf-8?B?NXIyQk9LYm5jK2JPQTI4UkZkbWRkQThsa1BHMm1RdmNDdDUzSEQ0VENJK0wr?=
 =?utf-8?B?ZnpMOVh0bGtZRzdGQVRBa1M0Tjk1aTdaTnBpSjNianNtRWtRQkkzQ1cxd1hI?=
 =?utf-8?B?YnlyQVR1WVJ2ZlZDRWdYNzF3QzkwV2k1OVhSd3JZYklOa3F5VWEzVzlpT0RV?=
 =?utf-8?B?SjhLWFNxWDIzVHJBcHdmM0oveTk4R0pkcjI0cW1EUDR0VWtWVkJodzU1M0pz?=
 =?utf-8?B?VFB2N0FZbDhaRzNKVXlQNW9SaDdQSmxFL0NrT29qL2trUGtLT1lHNW1sYmNi?=
 =?utf-8?B?bWl0VWFUZ25yOFlPZnNVdjNUTzBmOVRzV3Ftd0pRempVajVLNjkyWHIxZ2V2?=
 =?utf-8?B?d0NEMjhWTi9TTFNidUpSQk9SeS9sUms4UXh5R2R3c1JreFVQSXdhRE5FMnYw?=
 =?utf-8?B?Wm90bkZnaTRrb01EWGpuYWRCeDR3RjRESlNxOFlMSmJCVjQ0YUZJc3k3TlE3?=
 =?utf-8?B?TFFIT2RSWFVsbU1mdTJvOEc4dXdiUkk3NzV4bGJORU4xTXNWSUV1M0EvYzdq?=
 =?utf-8?B?M2FlcU5uMFU2dFg1dmVFZjU5b0JqU3RMUXN5REk2bHhBUUVJMVNpdklqZHhv?=
 =?utf-8?B?aGQyekNmY21HRGdIYysyQmZEUDNoMjV0a21LRy84dVhtS1RqRFNrR0VRTUli?=
 =?utf-8?B?YWUxa0xqbkJaV3dCajFJcHZ0MUdJZTY3MmU4WU9nUUdJKzE2aW1ScnZ6WmpU?=
 =?utf-8?B?bnRKTWNuRURwbnVKM01oUFhJSHhHamR2WlVYS2lLTmdjVjBWZnJ1dDBocm12?=
 =?utf-8?B?T2pEQWtwdVN2RU8xVEF4ZkxRN0NpUHlLUVVaRUVFM1RBVG9jOWVNSitVWGYr?=
 =?utf-8?B?bktRdVpiNTFGSko1bU85d2NjMkp6dUkzL0ZRTHZvakE5TkZFTVlXSFZZVkJm?=
 =?utf-8?B?blhxUjNFNDYrdHhGS1NucVozU05YT1RuRk9jTmZsTmJMZ2dJYzFHVFVRVE9V?=
 =?utf-8?B?MVZ0WWpOTVBKU3l1WjVTbnQ2YnJrYW9FQ3lXNCtObGlKbm5Tajlvb1I0aE5B?=
 =?utf-8?B?U2FGdmhIbFFReEFZYVF1NlV2UGNnRS8zN0J4UWc4WTc3Q0o5UzZ4TStOakI0?=
 =?utf-8?B?djM3Vm1lSkoxeEFTY0dPOUR2eFBleE5VL3R1M0E2ckhXdkhzaGVxNUpFaE4w?=
 =?utf-8?B?eDBiSTVFUno2ZXBpR1czNGQwK2I5UW9LVWZXK09VR3hGNlI2MlZUSExqa3l5?=
 =?utf-8?B?UjhFSCtpa01Rd0U2VSthUjdEdmpqdG9TSWJSMURKOExSTU5yNDAyYzFHYkh3?=
 =?utf-8?B?dW5FNm5qa0JOekwzWlNvbkovb0xsOFFYK1pLcHFxRisvNmw5dkZ5ZW8rdjRt?=
 =?utf-8?B?T09pNmtwSGdWQ0JtbkpuQVEvWjF6RTM5ZzBkSWdKVmd5bXg0NzNmaVJjZDhv?=
 =?utf-8?B?dHN3YUNjbkd2ai9EWHg5U1gwZzFGTitBTlVOYlh6Mk11MjBTbmtSQUJpZEx3?=
 =?utf-8?B?SUw4V1MwdUdjMm9oQlhJR0llcitkQ0paVnNESnN2dzBVVGVRWU5tUmZTa0FU?=
 =?utf-8?B?eWZ2NWlSWDVTcyt2SmlmbDVEK0JQRkNMVG1ZQ29UekRYMjRIUHIwalZvWjhm?=
 =?utf-8?B?OS8xMmxBbmNlRnRGQVRubWZtZU1EdlQ4N0NTcHZYeEdZQ2VnQnZNdjVINkRX?=
 =?utf-8?B?NmlDTkJucS8yMk5iTHkwRXpUY3M1dHM2NG9KQlViQkY4K21WOWFseUFkQlpF?=
 =?utf-8?B?VVFCNGNVU0NpMnRFRjJ3cmk2d2VXa0lEMDFiaHpGaFVLQVFOdjJnU1ZCWXZY?=
 =?utf-8?B?U0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D689D5DDC63C24E8A8C52BF16699766@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5351.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8607a6dc-ca3a-49f1-fd74-08dc119f307d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 05:44:19.0546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +uoLClWyT7I/FWeqpH5BWROuem/y4NI+swPZtmKTmjjn9ZWoLyUtLs/LvjKsevmN8NYgYQxpIzXjwL74pY/F9sUAu7urRCItiKkjBJow23U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8259
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.579000-8.000000
X-TMASE-MatchedRID: 9M69yBZ2Ml7UL3YCMmnG4pkEOBootbylYefZ7F9kLgsNcckEPxfz2Iqe
	hz/PsL8GqZFEOMJ4eYr89WDKQGB2Lr2qE/TXOSRcO9+ygK4Bw/4Cfg/sW4pUUFwpnAAvAwazJue
	jAccQ+DfA0A1lR3Z6hZkjw6+I2QxRuBKKB37nRtozw5Ejs3g1llsChor7BLiN1gisw2JKo8n2wt
	JdngDYbSSokrz/9xB4u7YXZyzcQdSPLG+A0qvEppmug812qIbzBdebOqawiLth7WbOnt2TB92v7
	KCkib/qBQl5gCSY8ZjrmgsWcquPnl3MeDPg67Bebc297PAGtWb4qCLIu0mtILDOZkvqV9x1o8WM
	kQWv6iUVR7DQWX/WkQGLeSok4rrZC24oEZ6SpSk6XEE7Yhw4FpRMZUCEHkRt
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.579000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	45DFCA3A8190DD0BFE3A7D42FEAB4E30CDC32E018AC1FCD23CA17FBE116D94A92000:8

T24gV2VkLCAyMDIzLTExLTI5IGF0IDE0OjIyICswMTAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gSWwgMTQvMDkvMjMgMTQ6MTAsIE1hcmsgVHNlbmcgaGEgc2NyaXR0bzoN
Cj4gPiBUaGUgb3JpZ2luYWwgQ0NJIE9QUCB0YWJsZSdzIGxvd2VzdCBmcmVxdWVuY3kgNTAwIE1I
eiBpcyB0b28gbG93DQo+ID4gYW5kIGNhdXNlcw0KPiA+IHN5c3RlbSBzdGFsbHMuIEluY3JlYXNl
IHRoZSBmcmVxdWVuY3kgcmFuZ2UgdG8gMS4wNSBHSHogfiAxLjQgR0h6DQo+ID4gYW5kIGFkanVz
dA0KPiA+IHRoZSBPUFBzIGFjY29yZGluZ2x5Lg0KPiA+IA0KPiA+IEZpeGVzOiAzMmRmYmMwM2Zj
MjYgKCJhcm02NDogZHRzOiBtZWRpYXRlazogbXQ4MTg2OiBBZGQgQ0NJIG5vZGUNCj4gPiBhbmQg
Q0NJIE9QUCB0YWJsZSIpDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTWFyayBUc2VuZyA8Y2h1
bi1qZW4udHNlbmdAbWVkaWF0ZWsuY29tPg0KPiANCj4gWW91IGlnbm9yZWQgbXkgY29tbWVudCBb
MV0gb24gdGhlIHYxIG9mIHRoaXMgcGF0Y2guDQo+IA0KPiBCZXNpZGVzLCBJIHRoaW5rIHRoYXQg
eW91IHNob3VsZCBhdCBsZWFzdCBrZWVwIHRoZSA1MDBNSHogZnJlcXVlbmN5DQo+IGZvciBhDQo+
IHNsZWVwLW9ubHkvaWRsZSBPUFAgdG8gc2F2ZSBwb3dlci4NCj4gDQo+IEl0IHdvdWxkIGFsc28g
YmUgaGVscGZ1bCB0byB1bmRlcnN0YW5kIHdoeSB5b3UgY2hvc2UgdGhpcyBuZXcNCj4gZnJlcXVl
bmN5IHJhbmdlLA0KPiBzbyBpZiB5b3UgY2FuLCBwbGVhc2UgcHV0IHNvbWUgbnVtYmVycyBpbiB0
aGUgY29tbWl0IGRlc2NyaXB0aW9uLA0KPiBzaG93aW5nIHRoZQ0KPiBzdGFsbCBpbiB0ZXJtcyBv
ZiByZXF1ZXN0ZWQgQlcgdnMgYWN0dWFsIEJXIChhcyBJJ2QgaW1hZ2luZSB0aGF0IGEgMngNCj4g
aW5jcmVhc2UNCj4gaW4gQ0NJIGZyZXF1ZW5jeSBtZWFucyB0aGF0IHdlIG5lZWQgKnR3aWNlKiB0
aGUgYmFuZHdpZHRoIGNvbXBhcmVkIHRvDQo+IHdoYXQgd2UNCj4gaGF2ZSBmb3IgdGhlIHdvcmts
b2FkcyB0aGF0IGFyZSBzdGFsbGluZyB0aGUgc3lzdGVtKS4NCj4gDQpIaSBBbmdlbG9HaW9hY2No
aW5vIERlbCBSZWdubywNCg0KVGhhbmtzIHlvdXIgcmVtaW5kZXIgdGhpcyBpc3N1ZS4gQWZ0ZXIg
YWpkdXN0bWVudCBDQ0kgT1BQLCB3ZSBhbHNvIGRvDQpwb3dlciB0ZXN0IGJlbmNobWFyayBhbmQg
dGhlIHJlc3VsdCBpcyBQQVNTLg0KDQpUaGUgb3JpZ2luYWwgQ0NJIHRhYmxlIGhhcyBzdGFsbCBp
c3N1ZS4gIFdoZW4gdGhlIEJpZyBDUFUgZnJlcXVlbmN5IHNldA0Kb24gMi4wNUcgYW5kIENDSSBm
cmVxdWVuY3kga2VlcCBvbiA1MDBNSHogdGhlbiBydW4gQ1RTIE1lZGlhVGVzdCB3aWxsDQpzeXN0
ZW0gc3RhbGwgdGhlbiB0cmlnZ2VyIHdhdGNoZG9nIHJlc2V0IFNvQy4NCg0KVGhlIENQVSBhbmQg
Q0NJIGZyZXF1ZW5jeSBzZXR0aW5nIGFyZSBub3QgaW4gdGhlIHNhbWUgZHJpdmVyLiBTbyBpdA0K
d2lsbCBoYXZlIHRpbWluZyBpc3N1ZSBjYXVzZSBDUFUgc3RhbGwgc2lkZSBlZmZlY3QuDQoNCkJS
cywNCg0KTWFyayBUc2VuZw0KDQo+IFsxXTogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC83OTkzMjVmNS0yOWI1LWYwYzAtMTZlYS1kNDdjMDY4MzBlZDNAY29sbGFib3JhLmNvbS8NCj4g
DQo+IFJlZ2FyZHMsDQo+IEFuZ2Vsbw0K

