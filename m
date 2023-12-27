Return-Path: <linux-kernel+bounces-11885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D1C81ECF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2941F2183A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29C5687;
	Wed, 27 Dec 2023 07:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Y4sLA2vQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tKS2TCgQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E0539C;
	Wed, 27 Dec 2023 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3799e0c6a48911ee9e680517dc993faa-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GU/cYaQBmT72sE6Uwg6U2pDEKin0V3rJpzhwPthld38=;
	b=Y4sLA2vQ89W81OlniDPflVYXCpdOMRbjEckmmE1C/rbjvgvOKZbSloIb38at9B5Qq7gdHsdeapS0bSDWUsKQVnF2NjdAvBZCnCXpy/4eiBlO6Q37geyKsBltgyUggxYp5noQWRQHHsh1mShhKy5eGhOmFhz2GE3VrB+A2m4w/cs=;
X-CID-CACHE: Type:Local,Time:202312271520+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:45023057-be75-4b00-8e9a-f6c23927cff3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:df279e8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3799e0c6a48911ee9e680517dc993faa-20231227
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 648688077; Wed, 27 Dec 2023 15:26:14 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 15:26:13 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 15:26:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jrXJXKQb9qQxN8hE5MjFPFo4yQpNSSQDtqp+4TLUpVoBtXyv9IDd7iH1KQizODn2xMClMNoAQatVbqo4L+VmTM9j9qrVvDAAkUQeR3XRRkzbzxORnsA9a8c+QxpwWZIujKRosNyrhQtjqjy3JaOpepbyQBT/yy4qVontInpFlzZa49EMqV9uqa0Z3wMNL9IlLmppXFvrjEX27LiYxuEyIFi6a9bcpBxRbTy2dxt2VLGHRzxLcM9Jn/iO5uKsR2SvMjZpRweZm4Mu8q2f1baIGx4o3GK77wiJTBl3j8r+1PFVbz1GCtGZBhsDHLVw1xGEKx9/lpU5SFog4d7iGbh3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GU/cYaQBmT72sE6Uwg6U2pDEKin0V3rJpzhwPthld38=;
 b=H9QfJppyOybgGoZJiuOTDxwhHzx8pF+ZN7r4VWH3EkYNcgegGqkKna059zuNvOlFw+58elvr0gl67YGv5yFDVPs6R5mmHcayYMY9N289lqQSaE5TtdcqKeDHd0unvNb/ckbROL828CW70WI/WGrht+ami/3vxurzgFjh3Q6p7Cj8eXf3c7h++hEQZzLULxzQ/KXAxzbwLD0QjuaoVB1F2x+t+Hqt/oYrjRNLGTlHQE0ai3Bim6f/zHx/0Ga6YvvnaGMgeMvPBMwDLwM3M1HeTDNKtAUZW5lDmpgX3II7xbF+uOGJZ9ewjIwUTEXYyoa68jl/mSOeUL3C4OfirWHrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GU/cYaQBmT72sE6Uwg6U2pDEKin0V3rJpzhwPthld38=;
 b=tKS2TCgQwOc7WDz1P7FU82utiv8GhUQtCJ2xuZTC80nmotRnrmNBOnpq7WWFdV78Q1I643Vmo/gPITLMt3KDZ+aSkXUAennsh+fb5k490x210FVZFLLXQAT8BNxLd3+4jqVs1+5o+4WHoUoAOPtezAd4nCJ+SX72cXrIJF6AWlo=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SI2PR03MB5829.apcprd03.prod.outlook.com (2603:1096:4:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 07:26:10 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 07:26:10 +0000
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC7QbyAgAGBCoA=
Date: Wed, 27 Dec 2023 07:26:10 +0000
Message-ID: <4f2cf25c730e59784afa5ce690cf4cc99544025f.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <a0c9d84f8a2d6efdfd7502f796e5629a8471c9eb.camel@mediatek.com>
In-Reply-To: <a0c9d84f8a2d6efdfd7502f796e5629a8471c9eb.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SI2PR03MB5829:EE_
x-ms-office365-filtering-correlation-id: c074fb82-298c-4516-79d8-08dc06ad1965
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2/FIGOsOS/TiFXHYIrxOBd3Dw9z3iEZFLaM2TTw57d2CgozYZWDdm77CId1awBv8t4bd3jpGst4/Zl2boAAVh1TJ2tBeJQT6foWJ48tYbb90yUU1DjzwDvrJzAhvS4RC3Iq/o0+1Arhddc18LLdz4kM+htdLKztINprxiojP4aZ7/XOmzzf8jE2+Xqev8aEdEGgLDLuDh9TeVVskHl0nmVCVVs6FdLV7JzA6++smoY7bRRYzFwKDqzl+gDhOeax8PJ8oQoq29NLALDzC9dSheUApL1J7cu8cT0zyLQNb1u8nJTE50HmQJv2yL6cZ4Dg3ifby+8xYUH8SVECOLMJPBCb0+0k9kUd2jW1jSDkYP06y4xFMdgbhggZrah6i4yTWD8ZlsC0beTwdxuQBMgqVz2meHr2jf3Ipstg8C6WUdMuz4Ep4WE1irBdt4kPoRUDhbaKx5cCXo6dry3dvM1SHk7v+O+PCihpu6ek9uP1Nr1Fg9qIV9bHKXAjCnHO9MvWkJ8d+zFLmVE5ZFqot7xpnDIToT+uAR6bGuIaQdvOGPf3QkQTSLezLiV0fbg1RSLYjrIc9kz0SOjjIQb6Q12S788X/W/ywdEQ5Cg5flvVTNWenh/BAre2Lu0CHt2o7U1lFUFWC2/4in4waR8bq41rVD7CSyeGhrZgVXNZp4Yj3/W4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(316002)(8936002)(8676002)(71200400001)(6486002)(36756003)(478600001)(86362001)(6506007)(6512007)(26005)(2616005)(85182001)(122000001)(38100700002)(38070700009)(83380400001)(41300700001)(54906003)(110136005)(91956017)(64756008)(66476007)(66556008)(66946007)(76116006)(5660300002)(15650500001)(4001150100001)(2906002)(66446008)(7416002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXpaUHZuM0t6djJmS1JCakxlSm5ZRWRtWGNnc1FrUjBLWWF6VWhkQ0RRRDFP?=
 =?utf-8?B?YUpQOTZGN0FKV2FwSXhrdjdsSEZrakxSdmRiRjVzbnp1NFFTbE1LOHBuRW1i?=
 =?utf-8?B?NWU5bVN0SGZ4Q1BrYWtmWHRjQ1RucXFZUlk4VFM1MFlrZmxEN25tcC9LMGp5?=
 =?utf-8?B?UU15eldMRHBWMnNLV3YrZW9VbnV1MTVPdXdFcUdYK2VjOWRjUmFFZVJDa1dL?=
 =?utf-8?B?TEZwb01zd0lUbmtmMHFzYzRTNUI2cHRWd0lONVh3SFh3RzdTYnJZMEMyQlVS?=
 =?utf-8?B?bk1NSnc3UUQ0TUNvSW9GaTFGNlVNai9JNkRudWxHc0hCc0ZBZFhIWUFGMlVL?=
 =?utf-8?B?N09PZ1l3Zi9JcjJXdWtjcmxNbXZDVGpKQURCOWRPSUxiRFhsMTRlZFU1L3NL?=
 =?utf-8?B?ZzRBQU4wY21ZUTVHTGpjQSsrM2hOUmhzSGJCSFVnb2QwRmUxemRGakxGcXRp?=
 =?utf-8?B?ZzhXTFhxbTlHcTZ1NWU1TDB6aG5jdTRXa3prWmY0dmlEOWVPdXJKdURiWDFD?=
 =?utf-8?B?RFk1WXBYTVVqVzhGOVQ0amNkUTREVCtDZlpGMlNnWnk0K2ZTbmhJeUFzd1B2?=
 =?utf-8?B?VlBEQkd1d0R0UHdOU1BjNUtabFByNDBsdVlYUzVtdG9XdkgrN2YxS0lITm5r?=
 =?utf-8?B?VmpaaEg1V3gzcUFQUE9ieTQxSnNEZTlPU1BaeG5nOGN6aDBoUGthR0hXYzJk?=
 =?utf-8?B?ek9PamMxbElyMjZMRFpPNVJaOTJDbEMvTG1wVGVjOU9YdHBwbXp0Z3BnaG0w?=
 =?utf-8?B?ckN1dFBxVjVFV2NDT0U2RDByYy9JOWtTMlZGS1R4dXY3UndIMWhhcnpJYy9G?=
 =?utf-8?B?ckNGM0hJNXoyYTJHS0xpRThBRm12NEpGd3JHQ0p4eXJ1Mk96SkF1M0EyRnFV?=
 =?utf-8?B?UlJLMnZzVTMzZU1oS2ZrRWRUNytiVzIyZ2s2YjJCZEJtc3Z1UmdsT3RETnlu?=
 =?utf-8?B?ZkduSnZraXRGaDNTdjhwWHI2cHlpZEZzZ2JjN2VIRWx3UVV2cHo4V1RjWkRN?=
 =?utf-8?B?ZnV0QjYxQUhLakUvZ3JndDZsSnlhU3lIM0RmdEowaGVuTjBwcjFwNFAzQklQ?=
 =?utf-8?B?aWdSQjBzV3pScG5yV216Yjl0ZmNReGxUZXZqQ0lFWnVIK2RnTFJDbXA5VGcx?=
 =?utf-8?B?Y3UwaDRseExKYkQ3V2lRRXNaeHM5SWFZYnM0cjJCN01TL2x5WmJNaDFyWjZD?=
 =?utf-8?B?UzFDNGVZa3lIVFRRUkVVQTQ1K3Y5aExXNU9HNHp6TFJONnBOd1VBT0syanhZ?=
 =?utf-8?B?Zll6TkkxSi9BOVViK25YWkdIWnk2SXpqcVJFLzkxYTh0eU52cWNNcGxVVDcy?=
 =?utf-8?B?Y2hyRGgwZHFtbS9PSGZJb3IrUzU0Vi8wanpYaVkxQm9mZm1TZjhMckdYOHBa?=
 =?utf-8?B?TlRLc2dlNmhQdmw2cGhaWG9abTZaMCtLVG9XdlROc3FkT2xtYkRWVWJVVkpP?=
 =?utf-8?B?a3BFaFlOaXdQdXlwZE1PSy90MWlBN0EyRTRSdkhMSGlNM2tTcy82eUNHNG1P?=
 =?utf-8?B?VE0xN2NsNjJmWDhHeXNJSDVRbjErU1V4TUNIbCtLM2xGaFhJckVVSTdRenhV?=
 =?utf-8?B?V3lOcEIrQzdZc0NtZFdGOTk4bDFURTQyV1cvN3BoYnNac3NRVDI0OTc4ZlpM?=
 =?utf-8?B?VkRhUFhWTEhheDVwbnc1bmQ2QVdYTEEwZE55aGNWY0RpN2dTKzd3OGE2UHRr?=
 =?utf-8?B?cWlxUm1xSFFscitBU28xYkNEYkhkeFlWQ1h1SkVmcTI0T243NHA0Z1l5UkFT?=
 =?utf-8?B?MVFPWStsQzQ5ZXlManlvOGxOa1Jwb1k3T0tZR0RhbWxqcHM0VDZyaG56cEdF?=
 =?utf-8?B?QVlHTHpTZnltQ3ppdW1HL3RDYlY2UlAyUDlZTEE0TnN4UVpXYkJCSjZ4cFA2?=
 =?utf-8?B?cWVOL2N0eVNBemx3UjNsclVtejRXU2Uyb3pQVVMwZ2ZSWXdKZUJuWXhUUzA1?=
 =?utf-8?B?Nk9vNnM0eTNUSWxNay9zWXU4NlRwWkx1Q1ZOZ0N5eXJDMWtYOWw5SnR5MlAr?=
 =?utf-8?B?bG5vdFA4MVErSzFtQzZEZGI0TDdsL1Q4U1duOG56VGNBcWRaSVJhajE5Rm5r?=
 =?utf-8?B?VUhMVHpTRFFWeGZweU1MMnpOVDFPOXgrbmtuanJPMTRLc2kyK1djcFg1QWxQ?=
 =?utf-8?B?Wk9scmcxaGIrbTE4Vy9oWU5hOEdNeEd5MTNDYmF5cklaNWlDOUVyN1lZbHg5?=
 =?utf-8?B?RWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <017507A04FFD5747990AB822FAF37446@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c074fb82-298c-4516-79d8-08dc06ad1965
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 07:26:10.4344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RXJ2Pc8w7+6qYUQXAh7n8ZAs4POWNhW/QX5lG0c/uO9aqofQqy3MW+P3Rtjanpda4ysTxk9IoOiUPXA7j2LBaBUc0TCfKIatfDuTpDCXhaU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5829
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.992000-8.000000
X-TMASE-MatchedRID: csPTYAMX1+GnykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/mNRhvDVinvypf
	0VJZhlxP3gb7k6xpVN4a/3L93pcprQTsy5Ctk/ajdAg4yd14qAQxmbT6wQT2a/t592eq2xoTHye
	T8VIiNb6ykaH8ZceX1S9G4rNM7gvBsznIV04I19FIcJTn2HkqsS6GDroi1vrl8pw+dn1doyW5cW
	RsP/eR7JMWaqBLFuhwn2+m5dWH1PdC/bXMk2XQLIMbH85DUZXy3QfwsVk0UbslCGssfkpInQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.992000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D520AC48AB51DCFB865E92BF36934C5AC110BD142886086DA7E2A4CA4A5DF0722000:8

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0yNiBh
dCAwODoyOCArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
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
PiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICsNCj4gPiAraW50IGNtZHFfc2VjX3BrdF93
cml0ZShzdHJ1Y3QgY21kcV9wa3QgKnBrdCwgdTMyIGFkZHIsIHU2NCBiYXNlLA0KPiA+ICsJCSAg
ICAgICBjb25zdCBlbnVtIGNtZHFfaXdjX2FkZHJfbWV0YWRhdGFfdHlwZSB0eXBlLA0KPiA+ICsJ
CSAgICAgICBjb25zdCB1MzIgb2Zmc2V0LCBjb25zdCB1MzIgc2l6ZSwgY29uc3QgdTMyDQo+ID4g
cG9ydCkNCj4gPiArew0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwlyZXQgPSBjbWRxX3Br
dF9hc3NpZ24ocGt0LCBDTURRX1RIUl9TUFJfSURYMCwgYWRkcik7DQo+ID4gKwlpZiAocmV0KQ0K
PiA+ICsJCXJldHVybiByZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gY21kcV9wa3Rfd3JpdGVfc19y
ZWdfdmFsdWUocGt0LCBDTURRX1RIUl9TUFJfSURYMCwNCj4gPiAodTMyKWJhc2UpOw0KPiA+ICsJ
aWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXJldHVybiBjbWRxX3Nl
Y19hcHBlbmRfbWV0YWRhdGEocGt0LCB0eXBlLCBiYXNlLCBvZmZzZXQsIHNpemUsDQo+ID4gcG9y
dCk7DQo+IA0KPiBXaHkgZG8geW91IGFwcGVuZCB0aGlzIG1ldGFkYXRhPyBJdCBsb29rcyBsaWtl
IFRFRSB3b3VsZCB1c2UgdGhpcw0KPiBtZXRhDQo+IGRhdGEgdG8gY2hlY2sgY29tbWFuZCBpcyBz
ZWN1cmUgb3Igbm90LiBCdXQgdGhpcyBtZXRhIGRhdGEgaXMgaW4NCj4gbm9ybWFsDQo+IHdvcmxk
LCBzbyBpdCBtYXkgYmUgbW9kaWZpZWQgYnkgaGFja2VyLiBJIHRoaW5rIFRFRSBzaG91bGQgY2hl
Y2sNCj4gY29tbWFuZCBidWZmZXIgZGlyZWN0bHkgbm90IGJ5IHRoZSBtZXRhIGRhdGEuDQo+IA0K
PiBSZWdhcmRzLA0KPiBDSw0KPiANCg0KT0ssIEknbGwgdHJ5IHRvIHJlbW92ZSB0aGlzLg0KDQpS
ZWdhcmRzLA0KSmFzb24tSkguTGluDQoNCj4gPiArfQ0KPiA+ICtFWFBPUlRfU1lNQk9MX0dQTChj
bWRxX3NlY19wa3Rfd3JpdGUpOw0KPiA+ICsNCg==

