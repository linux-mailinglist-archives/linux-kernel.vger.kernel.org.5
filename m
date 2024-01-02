Return-Path: <linux-kernel+bounces-14059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F385A821778
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 06:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C95E28237E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A49115A1;
	Tue,  2 Jan 2024 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="h0b9dCbm";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sVrGtFYc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D05382;
	Tue,  2 Jan 2024 05:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: dee4a65ca93111eea2298b7352fd921d-20240102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=KLQcb+mOOJBK/CzPTZJ2BeRUxrQaQqEedxCjokG75+M=;
	b=h0b9dCbmR4g4/yVkqS7ffGzrwD76TkAWRV7HCrWGnEImOsq0T0cx1maP2Fyvqth5TPKPS9ZpP3Imto7z73YAHYMsTkgx2oX5a5mwgihMLinpCGehrNbXDfOZixizvw3FXkIeuI5A4y2QVMDInTquxJ8NA4idzp7puq/yappoM8I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:2e7b8eb5-b828-4af7-80a0-f122f8d68906,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:41d26382-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: dee4a65ca93111eea2298b7352fd921d-20240102
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 340785227; Tue, 02 Jan 2024 13:43:35 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jan 2024 13:43:33 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jan 2024 13:43:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MpcnDU9t/b9yli1OZqs4EJv8iDYxwM/yNpTNvvoZmtIFCaRGGEgAp3fAIWJyqeTVjzctwWY2D+GBVM7xWTj9PwSjyLMFDQT38z4Doz8jdH1nEas7MBT39KASt3r0ZUjXOHE8HWeTDbsVcKHK/eVEMIxxyHu+V77LpH2kQSYjWuH+N9YgS5I98ANzcdq+X0nZODutd4ALlBEFUV6hPBvGGPZIX1EJC2aIFE1porLJV64x0SEF6fE2QW69GkyTcqivbKpIYZmKkSZnzrygPjGu/v55VSYutZSOSunoqLFVi5DF/uWR+OZOLpnA5Txe6xOgi45A7pzJwUqHtyxJkipVgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLQcb+mOOJBK/CzPTZJ2BeRUxrQaQqEedxCjokG75+M=;
 b=Q1lwTKwt3OxTb9L8Ne/tg89EfRRxbS9jKLU/cr2O6bPfeuIHj70ZoulUe5dHM/uWIELu/pqU/eJTblZ9oXpazSLc+EjFtKXD20UeVudr+EKa5B3o/19OavVe9P1DYPSeMIuzIF+ef7sYBMMMsfKatU9zn3Clt6y/G/lVx64DvRzxwJDL8WPmg2QB7pWgRy5UupGstQlzXWe7RBcGjq5kTmakft1kX+MzXV+dNVVRRt7MmOowP0fMftnr69eLVGHfTuhWrqlJVgpYKBDl+fcIkV8210zwGdmbxdbmV/mOX4OM8x7ZUSDiRtlhXnKrwCI6/l2el9AIR8gAZ77T0phgMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLQcb+mOOJBK/CzPTZJ2BeRUxrQaQqEedxCjokG75+M=;
 b=sVrGtFYcZmTv8tLTfhK+53XUoZS0IQAMBYYafl7iEmhZXUePdatrfGCBFvGAqDUwBn1ceIXgh7cZzgSjVhVWOJqZMrZGfzcMIYZEWekZ+MOn0QiDn8xtTT2cpKr5NOmkEPRRMyvs3pHB9Ggp8ybh/KBRlfB02rlIl/fM/h4pplE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB7939.apcprd03.prod.outlook.com (2603:1096:820:f1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 05:43:30 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 05:43:30 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wenst@chromium.org" <wenst@chromium.org>,
	=?utf-8?B?QmliYnkgSHNpZWggKOisnea/n+mBoCk=?= <Bibby.Hsieh@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "daniel@ffwll.ch"
	<daniel@ffwll.ch>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "sean@poorly.run" <sean@poorly.run>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "fshao@chromium.org"
	<fshao@chromium.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 06/17] drm/mediatek: Support alpha blending in OVL
Thread-Topic: [PATCH v4 06/17] drm/mediatek: Support alpha blending in OVL
Thread-Index: AQHaLPWLhNXaxaamyUy8HkPzyFHHx7DGI06A
Date: Tue, 2 Jan 2024 05:43:30 +0000
Message-ID: <8eb9f45eea4dfd5feb67d52630cd058293d33abf.camel@mediatek.com>
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
	 <20231212121957.19231-7-shawn.sung@mediatek.com>
In-Reply-To: <20231212121957.19231-7-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB7939:EE_
x-ms-office365-filtering-correlation-id: d8acca19-2e8d-4cab-3664-08dc0b55bfff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRGwnoeUI0O9FLzCIAoIisd4KTQtrzRT2B/QmyFEGSDCeJcIRB0nj0XX2kBgdQSbdtQl89/T3Ya6CbBqhNggKElaPNW1hmlmA1M28U9tedIjOG2SGzpBmDSq6n+nRnEJuMqpWRJHq6fqFrv4X4quoeG6y9aIeXjFlCjcdFHc1mxFuWkUI7HZ500zKR8IW2NT0bG3Hx/DFVzMwsuNfJCealXnJiZ5tsq4m374M9RU+bEGXa/3eq2KbGqoHPXS8Av/XRyUNKp0bPoh/VBcI00dueyUK9yUEAlNTJcxRgtyfJ+dWRZHApBTBe2AmP1WcTKzMpZ8a7VqSZsj3+beGjf4DgFyW0V5+ayVo3kSwqwf004KHhiu2azuSf1wqnNfO/EGWNUVXqqzQqoL6rDR0cJoTnnL4StXBEYbg++gxy63CYFzqMXWfGhixrK28Fyl7jBQo4ps2prGO+C9RATa1tft31uoYH7Okt8agRn3YiQQNlaYHlFfH2OrzvWUgI+WRdpsSJSI6DXIibwqHuDcU1P+lUy8fU5duZJs69J7ymZJ9ze5P8BFvLqbqL8BtyaC2vVqgl+TBg7iS5+4g/C7/5GK7tbbRvwModR42bBkaTduPj9XlV4baa/sLsapOGy8uZebynzy+kbMX1XAzyhXib9gQ+xE5wmpYFPNoKtZJmkUrbHNI4EXqwS4K1E/DYsIL3vj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(376002)(39860400002)(396003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(38100700002)(122000001)(38070700009)(36756003)(85182001)(86362001)(6512007)(6506007)(478600001)(83380400001)(71200400001)(4326008)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6486002)(26005)(110136005)(316002)(2616005)(54906003)(8936002)(8676002)(7416002)(2906002)(41300700001)(5660300002)(4001150100001)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MjBDUlRwRElHVEV0UGdSZFJzd0JhTjVWS2NJcUg4cE1JU1NlRVhOS1h2ZWMz?=
 =?utf-8?B?QlJ1Mk1vMkU1TFdpT2NkM1BSdWJsSjExTW9PV3pvSVlWUmxycGQrc2JvSC9u?=
 =?utf-8?B?NmhYbDFaVFoxblB3bjM2SGtjL1lUTUhZWWZWL1JLTjU3K1Q5SHpWbzhuM2Zr?=
 =?utf-8?B?amhmN3NVTk93czhveW00a1BIQkF6THA3RFRiemFSbFJTTkFqSkd0cmdKNzh2?=
 =?utf-8?B?M281MkNxUWREWmlEcHVDSmZXZldCb3ZZVnRIMktvVHNFWXVSdkpJVVJDc0Fp?=
 =?utf-8?B?MlRXS3lsU1JRT2N0ZHkvcFdjNGk4VkNTM0JSaVg0d2czN0FEcGs2a2h0RDRq?=
 =?utf-8?B?eTl3dDFOR0pnWExKT0J2OGhqd0xXck9BS1UyZm1scERsU01WTU01MmZhYk1Q?=
 =?utf-8?B?czhpT3FlcjIzNm4zTmdPQVhHL3RoTHRHNGd5bjljQXdlaVYyaWxVRWs1V1Vu?=
 =?utf-8?B?ZDdCWWwzLzJMd25zNlRKY0dnOVRlR2VxQ0Vlc2RqZWs5NllBVDFxalQ1WHRk?=
 =?utf-8?B?ZWFBalVoL3NDMjh6Rmd3NGlMVThvM1JqeDlMbDRFVG85am55dUFPa2EybEla?=
 =?utf-8?B?a1R0N2hUeHB0WkhRc3NSOUxxN0ZpaHk5blVhbGp6aXYyZGhHL2d4Z2MycHR4?=
 =?utf-8?B?bGI5Zm81SEw0SUdLcTJKczVHY2hpeUxlRnBLdTVFTjlJTDZCRWwvc2ovOHd6?=
 =?utf-8?B?cGZISStBNlRaMld2MCtzSVloK21UdDVyOW1LNVl0NzQ2MkJReHRENEhpSDhM?=
 =?utf-8?B?VmhhRHJWT1d3YXVqbWpkMTJ5UkVyNlJUOURoSmlHRDI5NnhvclB4UlRjclZV?=
 =?utf-8?B?NXNiUzRqSE82Ny91OHhjZU1XM0pQYXNvNE9hOGZ6SktUaWh0TGNtcDZNSDRs?=
 =?utf-8?B?WFBsdkZyci9pVVBFNDJZTkFza1hYNXRTQnc0WHNCTkxDM1pDMXAydTZlNmcv?=
 =?utf-8?B?Y1dFYkFNV1BUU0F2b2RrM3ErRmxxalltSEdEK3ZlRmNST3UrNjgrdURobmZs?=
 =?utf-8?B?UlRjM1QyaExrVVJGNVRwNjd0Ri83M2Z3SXZkTTk1bFMxcldrd0pXbk50SmJQ?=
 =?utf-8?B?dmpQazJxK2JWQW1qbjFLTVFjYXVUWEIwYWNZTUZKdkFiV2k2Q1RoZkt0emdF?=
 =?utf-8?B?T0RXd2prZ0JYc3JoSUMzcXdNUlRSSEdCNTJjTXBFVG1WR3ZYeTdUL1BZL1VY?=
 =?utf-8?B?VldKVlFEeFphbTNwVkx1VGRUYlhxQnBsS3ozWGxNckRoR0RYRkcvNnpReTc3?=
 =?utf-8?B?dG9NaisxOHIyd1FmOGE4TGtVZEs4RDZqallpYUgveGo0OXJGeHh5cFpieUVs?=
 =?utf-8?B?WG0zNGxselRPYk9SbkNPNGx0dUpPMDBVZEsyOFpGdTc5TFdGVktaSVc3MHdy?=
 =?utf-8?B?TW9vV3lFNUVjcW9CdXoxL3pXRjJsVTMrbGJtUnYzeEhhK0lvU2c1SHZET0hM?=
 =?utf-8?B?K1JadXZVZ1NzdGgxL21wU3E2UmhoNk05UVZib1Y0Y1ViRmZZeFAvYWFNcXNo?=
 =?utf-8?B?VzJwVHZFb01tSWhoL3JVVlczUzJCWUlYaXJEaFRJL2lsRmUwT3lyOGFZTktx?=
 =?utf-8?B?Y3dBZWlPVnM4QUpRUHpaNjFIRnhwM1V5KzF5UGpSM2VwbWtwdFliMHpZWlNF?=
 =?utf-8?B?bngzUU1lTk5NOHNHNjJFeUNXZGEvZFBEN0Jadk9LK0gvcTFGck1mY3hLd2ZR?=
 =?utf-8?B?WWk3Q3h4eThtQXgycVpLSkkwcjNJQzBBaE9sZW5qTWNmZkQ0bDgxdFRWcFVR?=
 =?utf-8?B?R0dwYWJHOUFNZ3ZNZFQrdmw5dTIxbUFOaW96NHdQNGpTZS9iVHcwdjRxL1hr?=
 =?utf-8?B?SGMxVDlSZGZlSks5K0dvd1ZtZ3VkcldlbXNuSHQxMjdoMVBKVmJOd1hVbGNF?=
 =?utf-8?B?UGxmMVZNQXk0RS9wOCtvdmpaNktNOTBOOGFrUFl3Y0dYZEJYaEFBelhSWDJF?=
 =?utf-8?B?M0MxZUVBMjIzNnB3WE4vREJjUkF2NEtpOWxETktrVnYveU0rL3ZwSU0ycFRG?=
 =?utf-8?B?bmozdGp2elZwMlpQb3FjQUdrSXdvUVdNbzRwVTlwV21uRmJ1Z1htRG1kV29z?=
 =?utf-8?B?Q1JFUFhjdXR1eDZIUnBTNU8zQmlEbVRYby94SmUxRERzcVI3TjFMcU52WFVj?=
 =?utf-8?Q?rQLqd0amMmeMAx9u/cVrCsq3j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F454BBF07A2F0A4A8CEBB28B057C36A5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8acca19-2e8d-4cab-3664-08dc0b55bfff
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 05:43:30.0775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QzohfK2EZAD8WDSUrx6GWV/SHSdgLPIRLZg9lJVrIwpwbNQSK1gVUz5wEyHkWbdtVCYQG0lZgzwSQ5j06bdtyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7939

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUdWUsIDIwMjMtMTItMTIgYXQgMjA6MTkgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFN1cHBvcnQgcHJlbXVsdGlwbHkgYW5kIGNvdmVyYWdl
IGFscGhhIGJsZW5kaW5nIGluDQo+IE92ZXJsYXkuDQoNCkRlc2NyaWJlIHdoYXQga2luZCBvZiBh
bHBoYSBibGVuZGluZyBhbHJlYWR5IHN1cHBvcnQgZm9yIGN1cnNvciBwbGFuZS4NCkFuZCBzZXBh
cmF0ZSBwcmVtdWx0aXBseSBhbHBoYSBhbmQgY292ZXJhZ2UgYWxwaGEgdG8gdHdvIHBhdGNoZXMu
DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhzaWFvIENoaWVuIFN1bmcgPHNoYXduLnN1bmdAbWVk
aWF0ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmwuYyB8IDczICsrKysrKysrKysrKysrKysrLS0tLQ0KPiAtLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNTEgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGluZGV4IDVhYWY0MzQyY2RiZC4uNjYwNzRj
MmQ5MTdjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bf
b3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+
IEBAIC0zOSw2ICszOSw3IEBADQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSF9NU0IobikJ
CSgweDAwNDAgKyAweDIwICogKG4pKQ0KPiAgI2RlZmluZSBPVkxfUElUQ0hfTVNCXzJORF9TVUJC
VUYJCQlCSVQoMTYpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9QSVRDSChuKQkJCSgweDAwNDQg
KyAweDIwDQo+ICogKG4pKQ0KPiArI2RlZmluZSBPVkxfQ09OU1RfQkxFTkQJCQkJCUJJVCgyOCkN
Cj4gICNkZWZpbmUgRElTUF9SRUdfT1ZMX1JETUFfQ1RSTChuKQkJKDB4MDBjMCArIDB4MjAgKiAo
bikpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9SRE1BX0dNQyhuKQkJKDB4MDBjOCArIDB4MjAg
KiAobikpDQo+ICAjZGVmaW5lIERJU1BfUkVHX09WTF9BRERSX01UMjcwMQkJMHgwMDQwDQo+IEBA
IC01MiwxMyArNTMsMTYgQEANCj4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9ISUdICSgoMSA8PCBH
TUNfVEhSRVNIT0xEX0JJVFMpIC8gNCkNCj4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9MT1cJKCgx
IDw8IEdNQ19USFJFU0hPTERfQklUUykgLyA4KQ0KPiAgDQo+IC0jZGVmaW5lIE9WTF9DT05fQllU
RV9TV0FQCUJJVCgyNCkNCj4gLSNkZWZpbmUgT1ZMX0NPTl9NVFhfWVVWX1RPX1JHQgkoNiA8PCAx
NikNCj4gLSNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUkdCCSgxIDw8IDEyKQ0KPiAtI2RlZmluZSBP
VkxfQ09OX0NMUkZNVF9SR0JBODg4OAkoMiA8PCAxMikNCj4gLSNkZWZpbmUgT1ZMX0NPTl9DTFJG
TVRfQVJHQjg4ODgJKDMgPDwgMTIpDQo+IC0jZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1VZVlkJKDQg
PDwgMTIpDQo+IC0jZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1lVWVYJKDUgPDwgMTIpDQo+ICsjZGVm
aW5lIE9WTF9DT05fQ0xSRk1UX01BTgkJQklUKDIzKQ0KPiArI2RlZmluZSBPVkxfQ09OX0JZVEVf
U1dBUAkJQklUKDI0KQ0KPiArI2RlZmluZSBPVkxfQ09OX1JHQl9TV0FQCQlCSVQoMjUpDQo+ICsj
ZGVmaW5lIE9WTF9DT05fQ0xSRk1UX1JHQgkJKDEgPDwgMTIpDQo+ICsjZGVmaW5lIE9WTF9DT05f
Q0xSRk1UX1JHQkE4ODg4CQkoMiA8PCAxMikNCj4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfQVJH
Qjg4ODgJCSgzIDw8IDEyKQ0KPiArI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODgJKE9W
TF9DT05fQ0xSRk1UX0FSR0I4ODg4IHwNCj4gT1ZMX0NPTl9DTFJGTVRfTUFOKQ0KPiArI2RlZmlu
ZSBPVkxfQ09OX0NMUkZNVF9VWVZZCQkoNCA8PCAxMikNCj4gKyNkZWZpbmUgT1ZMX0NPTl9DTFJG
TVRfWVVZVgkJKDUgPDwgMTIpDQo+ICsjZGVmaW5lIE9WTF9DT05fTVRYX1lVVl9UT19SR0IJCSg2
IDw8IDE2KQ0KPiAgI2RlZmluZSBPVkxfQ09OX0NMUkZNVF9SR0I1NjUob3ZsKQkoKG92bCktPmRh
dGEtPmZtdF9yZ2I1NjVfaXNfMCA/DQo+IFwNCj4gIAkJCQkJMCA6IE9WTF9DT05fQ0xSRk1UX1JH
QikNCj4gICNkZWZpbmUgT1ZMX0NPTl9DTFJGTVRfUkdCODg4KG92bCkJKChvdmwpLT5kYXRhLT5m
bXRfcmdiNTY1X2lzXzAgPw0KPiBcDQo+IEBAIC0yMDgsMTQgKzIxMiwxMiBAQCB2b2lkIG10a19v
dmxfY2xrX2Rpc2FibGUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiAgdm9pZCBtdGtfb3ZsX3N0YXJ0
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gIAlzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4gKwl1bnNpZ25lZCBpbnQgcmVnID0gcmVhZGwob3Zs
LT5yZWdzICsNCj4gRElTUF9SRUdfT1ZMX0RBVEFQQVRIX0NPTik7DQo+ICANCj4gLQlpZiAob3Zs
LT5kYXRhLT5zbWlfaWRfZW4pIHsNCj4gLQkJdW5zaWduZWQgaW50IHJlZzsNCj4gKwlpZiAob3Zs
LT5kYXRhLT5zbWlfaWRfZW4pDQo+ICsJCXJlZyB8PSBPVkxfTEFZRVJfU01JX0lEX0VOOw0KPiAg
DQo+IC0JCXJlZyA9IHJlYWRsKG92bC0+cmVncyArIERJU1BfUkVHX09WTF9EQVRBUEFUSF9DT04p
Ow0KPiAtCQlyZWcgPSByZWcgfCBPVkxfTEFZRVJfU01JX0lEX0VOOw0KPiAtCQl3cml0ZWxfcmVs
YXhlZChyZWcsIG92bC0+cmVncyArDQo+IERJU1BfUkVHX09WTF9EQVRBUEFUSF9DT04pOw0KPiAt
CX0NCj4gKwl3cml0ZWxfcmVsYXhlZChyZWcsIG92bC0+cmVncyArIERJU1BfUkVHX09WTF9EQVRB
UEFUSF9DT04pOw0KDQpOb3RoaW5nIGNoYW5nZSBpbiB0aGlzIGZ1bmN0aW9uLCBzbyBkcm9wIHRo
aXMgbW9kaWZpY2F0aW9uLg0KDQo+ICAJd3JpdGVsX3JlbGF4ZWQoMHgxLCBvdmwtPnJlZ3MgKyBE
SVNQX1JFR19PVkxfRU4pOw0KPiAgfQ0KPiAgDQo+IEBAIC0yNzQsNyArMjc2LDEzIEBAIHZvaWQg
bXRrX292bF9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZA0KPiBpbnQgdywNCj4g
IAlpZiAodyAhPSAwICYmIGggIT0gMCkNCj4gIAkJbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFf
cGt0LCBoIDw8IDE2IHwgdywgJm92bC0NCj4gPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+ICAJCQkJ
ICAgICAgRElTUF9SRUdfT1ZMX1JPSV9TSVpFKTsNCj4gLQltdGtfZGRwX3dyaXRlX3JlbGF4ZWQo
Y21kcV9wa3QsIDB4MCwgJm92bC0+Y21kcV9yZWcsIG92bC0+cmVncywgDQo+IERJU1BfUkVHX09W
TF9ST0lfQkdDTFIpOw0KPiArDQo+ICsJLyoNCj4gKwkgKiBUaGUgYmFja2dyb3VuZCBjb2xvciBz
aG91bGQgYmUgb3BhcXVlIGJsYWNrIChBUkdCKSwNCj4gKwkgKiBvdGhlcndpc2UgdGhlcmUgd2ls
bCBiZSBubyBlZmZlY3Qgd2l0aCBhbHBoYSBibGVuZA0KPiArCSAqLw0KPiArCW10a19kZHBfd3Jp
dGVfcmVsYXhlZChjbWRxX3BrdCwgMHhmZjAwMDAwMCwgJm92bC0+Y21kcV9yZWcsDQo+ICsJCQkg
ICAgICBvdmwtPnJlZ3MsIERJU1BfUkVHX09WTF9ST0lfQkdDTFIpOw0KDQpJZiBjdXJzb3IgcGxh
bmUgYWxzbyBoYXMgdGhpcyBwcm9ibGVtLCBzZXBhcmF0ZSB0aGlzIHRvIGEgYnVnLWZpeA0KcGF0
Y2guIElmIG9ubHkgbmV3IGFscGhhIGJsZW5kaW5nIG1vZGUgaGFzIHRoaXMgcHJvYmxlbSwgZGVz
Y3JpYmUgbW9yZQ0KZGV0YWlsIHdoeSBuZXcgYmxlbmRpbmcgbW9kZSBoYXMgdGhpcyBwcm9ibGVt
Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAgDQo+ICAJbXRrX2RkcF93cml0ZShjbWRxX3BrdCwgMHgx
LCAmb3ZsLT5jbWRxX3JlZywgb3ZsLT5yZWdzLA0KPiBESVNQX1JFR19PVkxfUlNUKTsNCj4gIAlt
dGtfZGRwX3dyaXRlKGNtZHFfcGt0LCAweDAsICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+
IERJU1BfUkVHX09WTF9SU1QpOw0KPiBAQCAtMzU3LDcgKzM2NSw4IEBAIHZvaWQgbXRrX292bF9s
YXllcl9vZmYoc3RydWN0IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgCQkg
ICAgICBESVNQX1JFR19PVkxfUkRNQV9DVFJMKGlkeCkpOw0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMg
dW5zaWduZWQgaW50IG92bF9mbXRfY29udmVydChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsDQo+
IHVuc2lnbmVkIGludCBmbXQpDQo+ICtzdGF0aWMgdW5zaWduZWQgaW50IG92bF9mbXRfY29udmVy
dChzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsICpvdmwsDQo+IHVuc2lnbmVkIGludCBmbXQsDQo+ICsJCQkJ
ICAgIHVuc2lnbmVkIGludCBibGVuZF9tb2RlKQ0KPiAgew0KPiAgCS8qIFRoZSByZXR1cm4gdmFs
dWUgaW4gc3dpdGNoICJNRU1fTU9ERV9JTlBVVF9GT1JNQVRfWFhYIg0KPiAgCSAqIGlzIGRlZmlu
ZWQgaW4gbWVkaWF0ZWsgSFcgZGF0YSBzaGVldC4NCj4gQEAgLTM3NiwxOCArMzg1LDMwIEBAIHN0
YXRpYyB1bnNpZ25lZCBpbnQgb3ZsX2ZtdF9jb252ZXJ0KHN0cnVjdA0KPiBtdGtfZGlzcF9vdmwg
Km92bCwgdW5zaWduZWQgaW50IGZtdCkNCj4gIAkJcmV0dXJuIE9WTF9DT05fQ0xSRk1UX1JHQjg4
OChvdmwpIHwgT1ZMX0NPTl9CWVRFX1NXQVA7DQo+ICAJY2FzZSBEUk1fRk9STUFUX1JHQlg4ODg4
Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9SR0JBODg4ODoNCj4gLQkJcmV0dXJuIE9WTF9DT05fQ0xS
Rk1UX0FSR0I4ODg4Ow0KPiArCQlyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9D
T1ZFUkFHRSA/DQo+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9BUkdCODg4OCA6DQo+ICsJCSAg
ICAgICBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODg7DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUlg4
ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9CR1JBODg4ODoNCj4gKwkJcmV0dXJuIE9WTF9DT05f
QllURV9TV0FQIHwNCj4gKwkJICAgICAgIChibGVuZF9tb2RlID09IERSTV9NT0RFX0JMRU5EX0NP
VkVSQUdFID8NCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX0FSR0I4ODg4IDoNCj4gKwkJICAg
ICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCk7DQo+ICAJY2FzZSBEUk1fRk9STUFUX0JHUkEx
MDEwMTAyOg0KPiAgCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfQVJHQjg4ODggfCBPVkxfQ09OX0JZ
VEVfU1dBUDsNCj4gIAljYXNlIERSTV9GT1JNQVRfWFJHQjg4ODg6DQo+ICAJY2FzZSBEUk1fRk9S
TUFUX0FSR0I4ODg4Og0KPiArCQlyZXR1cm4gYmxlbmRfbW9kZSA9PSBEUk1fTU9ERV9CTEVORF9D
T1ZFUkFHRSA/DQo+ICsJCSAgICAgICBPVkxfQ09OX0NMUkZNVF9SR0JBODg4OCA6DQo+ICsJCSAg
ICAgICBPVkxfQ09OX0NMUkZNVF9QQVJHQjg4ODg7DQo+ICAJY2FzZSBEUk1fRk9STUFUX0FSR0Iy
MTAxMDEwOg0KPiAgCQlyZXR1cm4gT1ZMX0NPTl9DTFJGTVRfUkdCQTg4ODg7DQo+ICAJY2FzZSBE
Uk1fRk9STUFUX1hCR1I4ODg4Og0KPiAgCWNhc2UgRFJNX0ZPUk1BVF9BQkdSODg4ODoNCj4gLQkJ
cmV0dXJuIE9WTF9DT05fQ0xSRk1UX1JHQkE4ODg4IHwgT1ZMX0NPTl9CWVRFX1NXQVA7DQo+ICsJ
CXJldHVybiBPVkxfQ09OX1JHQl9TV0FQIHwNCj4gKwkJICAgICAgIChibGVuZF9tb2RlID09IERS
TV9NT0RFX0JMRU5EX0NPVkVSQUdFID8NCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1JHQkE4
ODg4IDoNCj4gKwkJICAgICAgIE9WTF9DT05fQ0xSRk1UX1BBUkdCODg4OCk7DQo+ICAJY2FzZSBE
Uk1fRk9STUFUX1VZVlk6DQo+ICAJCXJldHVybiBPVkxfQ09OX0NMUkZNVF9VWVZZIHwgT1ZMX0NP
Tl9NVFhfWVVWX1RPX1JHQjsNCj4gIAljYXNlIERSTV9GT1JNQVRfWVVZVjoNCj4gQEAgLTQwOCw2
ICs0MjksOCBAQCB2b2lkIG10a19vdmxfbGF5ZXJfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwN
Cj4gdW5zaWduZWQgaW50IGlkeCwNCj4gIAl1bnNpZ25lZCBpbnQgZm10ID0gcGVuZGluZy0+Zm9y
bWF0Ow0KPiAgCXVuc2lnbmVkIGludCBvZmZzZXQgPSAocGVuZGluZy0+eSA8PCAxNikgfCBwZW5k
aW5nLT54Ow0KPiAgCXVuc2lnbmVkIGludCBzcmNfc2l6ZSA9IChwZW5kaW5nLT5oZWlnaHQgPDwg
MTYpIHwgcGVuZGluZy0NCj4gPndpZHRoOw0KPiArCXVuc2lnbmVkIGludCBibGVuZF9tb2RlID0g
c3RhdGUtPmJhc2UucGl4ZWxfYmxlbmRfbW9kZTsNCj4gKwl1bnNpZ25lZCBpbnQgaWdub3JlX3Bp
eGVsX2FscGhhID0gMDsNCj4gIAl1bnNpZ25lZCBpbnQgY29uOw0KPiAgCWJvb2wgaXNfYWZiYyA9
IHBlbmRpbmctPm1vZGlmaWVyICE9IERSTV9GT1JNQVRfTU9EX0xJTkVBUjsNCj4gIAl1bmlvbiBv
dmVybGF5X3BpdGNoIHsNCj4gQEAgLTQyNSw5ICs0NDgsMTUgQEAgdm9pZCBtdGtfb3ZsX2xheWVy
X2NvbmZpZyhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+IHVuc2lnbmVkIGludCBpZHgsDQo+ICAJCXJl
dHVybjsNCj4gIAl9DQo+ICANCj4gLQljb24gPSBvdmxfZm10X2NvbnZlcnQob3ZsLCBmbXQpOw0K
PiAtCWlmIChzdGF0ZS0+YmFzZS5mYiAmJiBzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxw
aGEpDQo+IC0JCWNvbiB8PSBPVkxfQ09OX0FFTiB8IE9WTF9DT05fQUxQSEE7DQo+ICsJY29uID0g
b3ZsX2ZtdF9jb252ZXJ0KG92bCwgZm10LCBibGVuZF9tb2RlKTsNCj4gKwlpZiAoc3RhdGUtPmJh
c2UuZmIpIHsNCj4gKwkJY29uIHw9IE9WTF9DT05fQUVOOw0KPiArCQljb24gfD0gc3RhdGUtPmJh
c2UuYWxwaGEgJiBPVkxfQ09OX0FMUEhBOw0KPiArCX0NCj4gKw0KPiArCWlmIChibGVuZF9tb2Rl
ID09IERSTV9NT0RFX0JMRU5EX1BJWEVMX05PTkUgfHwNCj4gKwkgICAgKHN0YXRlLT5iYXNlLmZi
ICYmICFzdGF0ZS0+YmFzZS5mYi0+Zm9ybWF0LT5oYXNfYWxwaGEpKQ0KPiArCQlpZ25vcmVfcGl4
ZWxfYWxwaGEgPSBPVkxfQ09OU1RfQkxFTkQ7DQo+ICANCj4gIAlpZiAocGVuZGluZy0+cm90YXRp
b24gJiBEUk1fTU9ERV9SRUZMRUNUX1kpIHsNCj4gIAkJY29uIHw9IE9WTF9DT05fVklSVF9GTElQ
Ow0KPiBAQCAtNDQ0LDggKzQ3Myw4IEBAIHZvaWQgbXRrX292bF9sYXllcl9jb25maWcoc3RydWN0
IGRldmljZSAqZGV2LA0KPiB1bnNpZ25lZCBpbnQgaWR4LA0KPiAgDQo+ICAJbXRrX2RkcF93cml0
ZV9yZWxheGVkKGNtZHFfcGt0LCBjb24sICZvdmwtPmNtZHFfcmVnLCBvdmwtPnJlZ3MsDQo+ICAJ
CQkgICAgICBESVNQX1JFR19PVkxfQ09OKGlkeCkpOw0KPiAtCW10a19kZHBfd3JpdGVfcmVsYXhl
ZChjbWRxX3BrdCwgb3ZlcmxheV9waXRjaC5zcGxpdF9waXRjaC5sc2IsDQo+ICZvdmwtPmNtZHFf
cmVnLCBvdmwtPnJlZ3MsDQo+IC0JCQkgICAgICBESVNQX1JFR19PVkxfUElUQ0goaWR4KSk7DQo+
ICsJbXRrX2RkcF93cml0ZV9yZWxheGVkKGNtZHFfcGt0LCBvdmVybGF5X3BpdGNoLnNwbGl0X3Bp
dGNoLmxzYiB8DQo+IGlnbm9yZV9waXhlbF9hbHBoYSwNCj4gKwkJCSAgICAgICZvdmwtPmNtZHFf
cmVnLCBvdmwtPnJlZ3MsDQo+IERJU1BfUkVHX09WTF9QSVRDSChpZHgpKTsNCj4gIAltdGtfZGRw
X3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIHNyY19zaXplLCAmb3ZsLT5jbWRxX3JlZywgb3ZsLQ0K
PiA+cmVncywNCj4gIAkJCSAgICAgIERJU1BfUkVHX09WTF9TUkNfU0laRShpZHgpKTsNCj4gIAlt
dGtfZGRwX3dyaXRlX3JlbGF4ZWQoY21kcV9wa3QsIG9mZnNldCwgJm92bC0+Y21kcV9yZWcsIG92
bC0NCj4gPnJlZ3MsDQo=

