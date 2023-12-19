Return-Path: <linux-kernel+bounces-4727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A1818143
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D231F23A16
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFDB848A;
	Tue, 19 Dec 2023 05:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aCtt2WcN";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZUHKTCF3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2408479
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cf6ec8289e3311eeba30773df0976c77-20231219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=CgXZ29V3PpSuc4cytXA0HhHeW0IznanvS3f2IHpSyWk=;
	b=aCtt2WcNd9aM8yIo0lbL6zg+i9q3oTcSaIPWEXfvvaL0jFhXv/ruASacuTWx/ejHKuoBn/w1IC7lLE1MOyLgcckgyhMlPbPeK9w433yyle0+7gEchmtQunrD7b6N6De7q6DaIzIYtksuAq3AzFu/UnhhIcHFXjSvCWoielIAkuQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:4c7f40dd-8add-402d-8b25-82afb64ae20f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:06165c61-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: cf6ec8289e3311eeba30773df0976c77-20231219
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
	(envelope-from <shawn.sung@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 515834396; Tue, 19 Dec 2023 13:59:45 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Dec 2023 13:59:44 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Dec 2023 13:59:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9nkPEyG4So3Kp69eF71YJqoQPCmiu7uf1nJyo1/rxRlo7KRY6eQp6FOBXaLeBJygNbcWpYiB/qwkDWmSGzA5w0ZdgDbIKDEcIJ66IwHIqfw9i/ixwWyDU20Dr8uMt+I7VNnjNiV4bW0JIargaa9kJJ5Ruvh1mFB8ktcDiy3J2JZHW+6RZDrmPf8u3FA+SnjHF9MqqYV6emCUWL16yyCnWDTO+gLo8Je5iqY11/mEqJslHMzw9M6BZmHDcIwmNbv3ZeJc052qjWnxUkK//xgpDATx+mmiTrMRx72C0/0K8znf1muj8VmZbpX+Uhnx9RJ+15bRc9gLP1YH4VIZahH6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgXZ29V3PpSuc4cytXA0HhHeW0IznanvS3f2IHpSyWk=;
 b=MDtGGFy3PWcOv4NoR46ZujFWwmpPc8CIcq7yw79d+l0PJtpqdfnh93FJ1U1OMc9cZjgzHGNN2T1TRrZ8jP25+ji3I0dtmmX2R4n+xH1h/akQAUfze3izXWF7HlnU6i0orzY0v/DzXgrmATQksdbpSzQbgwtbA3hFndrGEs3Hm+qft5zwgBC8+Ya8j3Hb2SQneofmq1Ph0G1zOg6goJhJlyc+CFR/uQUBHR9eyS2IExus7BnVGH4bN76Tq+MKTOVpOAXUzkOip8WPvowbrMVgad7GH5y60bffAe+rWugUNM+jFKdY9Y9C7iOmUgRS5WEWeCi1Cexp+17dg03OC0SD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgXZ29V3PpSuc4cytXA0HhHeW0IznanvS3f2IHpSyWk=;
 b=ZUHKTCF3ywfS7r1ljPwfdE1TJ4ElYAKrNjjPyhhAhLJpEGIkdpY3SB9h4U6wMYq+fESsHtEsJ5r3Q4UHliJ2B2Mq3H/Hsbbegl9n+6a6nrjEyH7qWrBkPZCF8f3YT162YM0Z5mpjEGqHajmWux8mfdYnfo9M5f1j0VLBbI9y9fM=
Received: from SEYPR03MB6627.apcprd03.prod.outlook.com (2603:1096:101:82::5)
 by SEZPR03MB6889.apcprd03.prod.outlook.com (2603:1096:101:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 05:59:39 +0000
Received: from SEYPR03MB6627.apcprd03.prod.outlook.com
 ([fe80::a7a3:8cf9:5fb:e553]) by SEYPR03MB6627.apcprd03.prod.outlook.com
 ([fe80::a7a3:8cf9:5fb:e553%4]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 05:59:39 +0000
From: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "seanpaul@chromium.org" <seanpaul@chromium.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH v4 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Topic: [PATCH v4 1/1] drm/mediatek: Fix errors when reporting rotation
 capability
Thread-Index: AQHaHr0gb/AOKZLcLU62t+Yy81eGg7CwCqWAgAATd4CAABuigIAACeEA
Date: Tue, 19 Dec 2023 05:59:39 +0000
Message-ID: <9890110452673e7ed4122bab7bb26f99df081f7f.camel@mediatek.com>
References: <20231124100052.18599-1-shawn.sung@mediatek.com>
	 <20231124100052.18599-2-shawn.sung@mediatek.com>
	 <0eb813192c02ac6f8d05fe9f4fc805517f5cb97b.camel@mediatek.com>
	 <23567207c3b28cb3298f85ac9be827e0ba09d278.camel@mediatek.com>
	 <a2c69e8d60dc09662be993983b6ce3d44acdf523.camel@mediatek.com>
In-Reply-To: <a2c69e8d60dc09662be993983b6ce3d44acdf523.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB6627:EE_|SEZPR03MB6889:EE_
x-ms-office365-filtering-correlation-id: 4654e7bf-a299-4506-c0f3-08dc0057b013
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N8BMmuacZ0+gQDt9DZqKA+2tDJWQihOllWikgv6PX2wWA1x6lc+m79PcGxmMsMzqEL1u1gdGzC8bnvpiVe88DXhYVLLOf8u1PmTxEsJIEBQaYL7PjLdZQ/pFdMPN9oM7nXUkhf/Yhf2HmZ+V619jAJs/6PUGjb/SOxUtVNCNqGqylnzlhQ/ZTd3jpoTNedyC35y+SBDz1XPWQZpCRSeHI9veeACCgshRTuBeZdQyrq6u2oOdSTRds9ayjkYdKq65bvT37nMQv/BOwb+7jIaONBzBnBBDiNXH3468v2uYn+hebapsI4DRZ4eT+0e9LdjFj/7FuxofKEWEInPTJKVgAY1LIaj7SZdMuisQUN1gkmJF+7bw2KEv0thV07YxU3SGvF/SFw82FSr35DuLf+MQ14ffC+H56yjyUINqpZ3XSLnbQlrc8k1iSRY7yMcVERYvoqEqxD29K/kOuXqNYhInLr5Sx0NThfSz6ojAIomK3dbFVWjbi6ckAMvI2VCKQTdUrNJscD6vmcqio/zyN011g/R/ufhuENcn/mab2Gv8arAaQmqGuL7WFjYc825mEYWsroTCFVhy4FbZa8ppfFnRei9zxcT/jO/TNtcL4+I7l4h+c1pxiqk5udLfwihCXJXRxhv45R38vmq2vs0EhtYUGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB6627.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(316002)(41300700001)(2906002)(4001150100001)(7416002)(5660300002)(8676002)(66556008)(4326008)(66476007)(110136005)(66946007)(91956017)(66446008)(54906003)(8936002)(64756008)(76116006)(38070700009)(38100700002)(478600001)(26005)(6512007)(83380400001)(71200400001)(6506007)(122000001)(6486002)(85182001)(86362001)(966005)(36756003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnYyZ2lIVmVWNDZSTngvdjZPL0c1WmlNUUZHWWpCbEtKR3RUK0RpZndjbjlt?=
 =?utf-8?B?bzVVakRrY0ErakZUQStnRzFpM0NHRzZ3ck9TdGZWZ1hGaXpWeWpNS2IvRkps?=
 =?utf-8?B?WmRvTVhidS8vSXYvYTlqR2pMRnpXMmN0cnAvZW9YenVuT1crRjhyYmFDakE3?=
 =?utf-8?B?aG04NXM2eXRQai90OU9KUjFZREZ4cmJpeW5XNGM5dldBbGtDSVJZcG5ndnl6?=
 =?utf-8?B?amdZR0Z3NDR1UDlUSUNFUVBrVlZQNjl2Yk1OMGFpK3o4Tjd3RnRCeEdwZ0NX?=
 =?utf-8?B?ZHBnZlB2eDNlZk9kYWh5NGIwU3F0U1FqS1I0NDZONURJRy9HLzAyRzdDbXZz?=
 =?utf-8?B?cExaeEVHRFFPUXFHNU9vcDZtUVBKN3MxRU1zZ3prUStMUEpHRDloY05qeDhW?=
 =?utf-8?B?a3ZBK1UvN1ZkRjlVTmdHdlBRYXhPRkZ1bkdNajFhMURBM0g5NkRvZUNZVU82?=
 =?utf-8?B?L2hGN1VXVFVoblhsMWZSVkt1QjdZNi9ja2NDRDlacmdzT1Ria2hJaGNlRDFk?=
 =?utf-8?B?cmswNnlxK0JQUGNEQnh5OXNNTlBkazU5M0tVUHlrb2NKVkVTclVDTzdLTG92?=
 =?utf-8?B?TmcvMFd3c0NGNW5ESFFqaFJ1bnZMdVlKcHlOQTRzYUhSMEhiR0NxSjJycngx?=
 =?utf-8?B?eGFRTTNuL3lDS3pLQ3FLVTlyQzByLzJXNkkzWkJqRi9qOHZ3TlM0b1IwdXRk?=
 =?utf-8?B?b1J3SXZyMDNlUkp4amJ2UUN2VUovUSs5MWZhSjM5Q2VMYlZITTRUd244OXIw?=
 =?utf-8?B?M1I1eVluVE1iZDlYdUk3UFFXYWU4Q1BSemdBOFp6RG5JU1UwQUZQL3dUcGdC?=
 =?utf-8?B?TjU1ZkZadCtlS1JPdXZZQnJzb3ZHdDlvaDVwSHFGNHlVZHRhaE5iZ3k4TDN0?=
 =?utf-8?B?QUs5U0JPN0NieWFyMmxIZ2hqbUtaSVd3WnZTN2NuVTdlcUF1V1pKMHF2bCta?=
 =?utf-8?B?NXZ3RmplUUxDUlJwMExIeVBYZURJcUF6NzhZVGxwWXIvT0N0ZU5ZNS80bVlv?=
 =?utf-8?B?M0ZuUUpHVUFUSnVtOGxodVdpSjRrQmtOZTZHV3lVOWx2N3FGY2xxN280TG5U?=
 =?utf-8?B?RDFpbENxWDM0TTFzeTkxbkFmRHVPbnRwOGVKOXpoRXJFMTQ3anFGR1dTVkVr?=
 =?utf-8?B?RXlzd29meWc5Uk91Q0ZYREFqRmJhbVFlZG9leE92ZS9zWHZOM05GSHBtNmh5?=
 =?utf-8?B?WWJEa3FYcGxHWkZ0UWVYZHJQaUUxRm1ONFIrZE9NQTlvc2l5Sm9FSjBDbnBl?=
 =?utf-8?B?N3FYYXB3TnNDQm9Ba1hVYVpEdVZiT3BNd05PTkZIMGU0RzNmSnl4dUtoMjFN?=
 =?utf-8?B?Wjk2MFE3UDk2RWxBT0RQaEIydFdpRHdJcFNQdGpzVlRrcGVRL0p1czBVZS9k?=
 =?utf-8?B?aW1yL29heEFiYW8zT0FLUEpINHBsRkgraGdlclZkYUdEUVFMS25PZjRGYkdU?=
 =?utf-8?B?Y2gxY1hqMkJmeVE2VFppSkFpWmtHUGlRMjFTS0xTdm5yamV1TVgyWUJhNzd5?=
 =?utf-8?B?YnBtNGRSUEFDWHFmeTNYd2ppM1NuN2hOc0IxV3d2dVkrOVFVWmFFNWpXZzVT?=
 =?utf-8?B?YjlzWkpINEVjblErN290YXlxWjJrR0J6UDdQSVU3a0IyVk1mNU5sbFg1Uzk0?=
 =?utf-8?B?K1ZxRG10TDhHenprOVA2RzljOXhCdmhRWGlZVWN4RlZMS0pTRzl5N2w2UExa?=
 =?utf-8?B?YnBXUjNlZzA4Q2NUZXVMTUpNeTNIMnFySnhOczd6Ym8zQ243dlBRaWhBT1Fp?=
 =?utf-8?B?UHBQckdRWUJTYVF4blplVFQ0dEF1VDM0YjVUazA4aFR5UEpTdFlSRlBlSW5p?=
 =?utf-8?B?bzhaL2o2Znl1a2VrNHFxck85RU9EM1duZ2Y0RGZrMC9LMU1ub2hQMjZXWjhw?=
 =?utf-8?B?WU5VeHZjclQyVWJwaExBNnByY2Y2Q01Zd2JGbmx2S2FvY0xveFRVbGk5WjdD?=
 =?utf-8?B?UHNBeEo4MUZKQ3pDcFZUSmtkODl4YjNkcXVxcEZESHF1MlZpTXpKMU5XUEpk?=
 =?utf-8?B?eUUweGxsNkFkR1lEV0crRFUzOUJ4OE8zRmQ5TW02L0NqZUVnajFlc21VQk1K?=
 =?utf-8?B?dTkwWU1XU1lQNFhScytvR2E5bWNZc01ieGhHUG1GbFFaVHRuU2FQSzgwSmpB?=
 =?utf-8?B?ZUhlc09mbU1YTGNxY2x2SUoyVXN4MUNjYitmSGpVSXF3L09LR1Q1VFRDSlNz?=
 =?utf-8?B?WWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44EDBE2FCF00B24286891294324197D3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB6627.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4654e7bf-a299-4506-c0f3-08dc0057b013
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 05:59:39.5500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AgrjQ6VEih5cDS2WvHrq5fgXUDUToaA7I+sl18puc5J6F0H+xQfctwg+AocySY0OI8rClgXYXS/HmLAnsYp1WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6889

SGkgQ0ssDQoNCk9uIFR1ZSwgMjAyMy0xMi0xOSBhdCAwNToyNCArMDAwMCwgQ0sgSHUgKOiDoeS/
iuWFiSkgd3JvdGU6DQo+IEhpLCBIc2lhby1jaGllbjoNCj4gDQo+IE9uIFR1ZSwgMjAyMy0xMi0x
OSBhdCAwMzo0NSArMDAwMCwgU2hhd24gU3VuZyAo5a6L5a2d6KyZKSB3cm90ZToNCj4gPiBIaSBD
SywNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjMtMTItMTkgYXQgMDI6MzUgKzAwMDAsIENLIEh1ICjo
g6Hkv4rlhYkpIHdyb3RlOg0KPiA+ID4gSGksIEhzaWFvLWNoaWVuOg0KPiA+ID4gDQo+ID4gPiBP
biBGcmksIDIwMjMtMTEtMjQgYXQgMTg6MDAgKzA4MDAsIEhzaWFvIENoaWVuIFN1bmcgd3JvdGU6
DQo+ID4gPiA+IENyZWF0ZSByb3RhdGlvbiBwcm9wZXJ0eSBhY2NvcmRpbmcgdG8gdGhlIGhhcmR3
YXJlIGNhcGFiaWxpdHkuDQo+ID4gPiA+IFNpbmNlIGN1cnJlbnRseSBPVkwgb2YgYWxsIGNoaXBz
IHN1cHBvcnQgc2FtZSByb3RhdGlvbiwNCj4gPiA+ID4gbm8gbmVlZCB0byBkZWZpbmUgaXQgaW4g
dGhlIGRyaXZlciBkYXRhLg0KPiA+ID4gPiANCj4gPiA+ID4gRml4ZXM6IDg0ZDgwNTc1Mzk4MyAo
ImRybS9tZWRpYXRlazogU3VwcG9ydCByZWZsZWN0LXkgcGxhbmUNCj4gPiA+ID4gcm90YXRpb24i
KQ0KPiA+ID4gPiANCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJl
Z25vIDwNCj4gPiA+ID4gYW5nZWxvZ2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0K
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlh
dGVrLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfZHJ2LmggICAgICAgIHwgIDEgKw0KPiA+ID4gPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX292bC5jICAgICAgICB8IDE4ICsrKysrKy0tLS0NCj4gPiA+ID4gLS0t
LQ0KPiA+ID4gPiAtLS0tDQo+ID4gPiA+ICAuLi4vZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9v
dmxfYWRhcHRvci5jICAgIHwgIDkgKysrKysrKysrDQo+ID4gPiA+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9kZHBfY29tcC5jICAgIHwgIDEgKw0KPiA+ID4gPiAgZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYyAgICAgICB8ICAyICstDQo+ID4gPiA+ICA1
IGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiA+ID4g
PiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9kcnYuaA0KPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYu
aA0KPiA+ID4gPiBpbmRleCA0ZDZlOGI2NjdiYzMuLmM1YWZlYjdjNTUyNyAxMDA2NDQNCj4gPiA+
ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gPiA+
ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9kcnYuaA0KPiA+ID4gPiBA
QCAtMTI3LDYgKzEyNyw3IEBAIHZvaWQNCj4gPiA+ID4gbXRrX292bF9hZGFwdG9yX3JlZ2lzdGVy
X3ZibGFua19jYihzdHJ1Y3QNCj4gPiA+ID4gZGV2aWNlICpkZXYsIHZvaWQgKCp2YmxhbmtfY2Ip
KHZvDQo+ID4gPiA+ICB2b2lkIG10a19vdmxfYWRhcHRvcl91bnJlZ2lzdGVyX3ZibGFua19jYihz
dHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ID4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3JfZW5hYmxl
X3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ID4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0
b3JfZGlzYWJsZV92Ymxhbmsoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiA+ID4gK3Vuc2lnbmVk
IGludCBtdGtfb3ZsX2FkYXB0b3Jfc3VwcG9ydGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNlDQo+
ID4gPiA+ICpkZXYpOw0KPiA+ID4gPiAgdm9pZCBtdGtfb3ZsX2FkYXB0b3Jfc3RhcnQoc3RydWN0
IGRldmljZSAqZGV2KTsNCj4gPiA+ID4gIHZvaWQgbXRrX292bF9hZGFwdG9yX3N0b3Aoc3RydWN0
IGRldmljZSAqZGV2KTsNCj4gPiA+ID4gIHVuc2lnbmVkIGludCBtdGtfb3ZsX2FkYXB0b3JfbGF5
ZXJfbnIoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+ID4gPiBiL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYw0KPiA+ID4gPiBpbmRleCBlY2MzODkzMmZkNDQuLjMx
OWJiZmRlNWNmOSAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kaXNwX292bC5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZGlzcF9vdmwuYw0KPiA+ID4gPiBAQCAtNDE1LDYgKzQxNSwxMCBAQCB1bnNpZ25lZCBpbnQg
bXRrX292bF9sYXllcl9ucihzdHJ1Y3QNCj4gPiA+ID4gZGV2aWNlDQo+ID4gPiA+ICpkZXYpDQo+
ID4gPiA+IA0KPiA+ID4gPiAgdW5zaWduZWQgaW50IG10a19vdmxfc3VwcG9ydGVkX3JvdGF0aW9u
cyhzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICsJLyoNCj4gPiA+ID4g
KwkgKiBhbHRob3VnaCBjdXJyZW50bHkgT1ZMIGNhbiBvbmx5IGRvIHJlZmxlY3Rpb24sDQo+ID4g
PiA+ICsJICogcmVmbGVjdCB4ICsgcmVmbGVjdCB5ID0gcm90YXRlIDE4MA0KPiA+ID4gPiArCSAq
Lw0KPiA+ID4gPiAgCXJldHVybiBEUk1fTU9ERV9ST1RBVEVfMCB8IERSTV9NT0RFX1JPVEFURV8x
ODAgfA0KPiA+ID4gPiAgCSAgICAgICBEUk1fTU9ERV9SRUZMRUNUX1ggfCBEUk1fTU9ERV9SRUZM
RUNUX1k7DQo+ID4gPiA+ICB9DQo+ID4gPiA+IEBAIC00MjMsMjcgKzQyNywxNyBAQCBpbnQgbXRr
X292bF9sYXllcl9jaGVjayhzdHJ1Y3QgZGV2aWNlDQo+ID4gPiA+ICpkZXYsDQo+ID4gPiA+IHVu
c2lnbmVkIGludCBpZHgsDQo+ID4gPiA+ICAJCQlzdHJ1Y3QgbXRrX3BsYW5lX3N0YXRlICptdGtf
c3RhdGUpDQo+ID4gPiA+ICB7DQo+ID4gPiA+ICAJc3RydWN0IGRybV9wbGFuZV9zdGF0ZSAqc3Rh
dGUgPSAmbXRrX3N0YXRlLT5iYXNlOw0KPiA+ID4gPiAtCXVuc2lnbmVkIGludCByb3RhdGlvbiA9
IDA7DQo+ID4gPiA+IA0KPiA+ID4gPiAtCXJvdGF0aW9uID0gZHJtX3JvdGF0aW9uX3NpbXBsaWZ5
KHN0YXRlLT5yb3RhdGlvbiwNCj4gPiA+ID4gLQkJCQkJIERSTV9NT0RFX1JPVEFURV8wIHwNCj4g
PiA+ID4gLQkJCQkJIERSTV9NT0RFX1JFRkxFQ1RfWCB8DQo+ID4gPiA+IC0JCQkJCSBEUk1fTU9E
RV9SRUZMRUNUX1kpOw0KPiA+ID4gPiAtCXJvdGF0aW9uICY9IH5EUk1fTU9ERV9ST1RBVEVfMDsN
Cj4gPiA+ID4gLQ0KPiA+ID4gPiAtCS8qIFdlIGNhbiBvbmx5IGRvIHJlZmxlY3Rpb24sIG5vdCBy
b3RhdGlvbiAqLw0KPiA+ID4gPiAtCWlmICgocm90YXRpb24gJiBEUk1fTU9ERV9ST1RBVEVfTUFT
SykgIT0gMCkNCj4gPiA+ID4gKwlpZiAoc3RhdGUtPnJvdGF0aW9uICYNCj4gPiA+ID4gfm10a19v
dmxfc3VwcG9ydGVkX3JvdGF0aW9ucyhkZXYpKQ0KPiA+ID4gPiAgCQlyZXR1cm4gLUVJTlZBTDsN
Cj4gPiA+IA0KPiA+ID4gVGhlIGNvbW1pdCBtZXNzYWdlIG9mIHRoaXMgcGF0Y2ggaXMgIkNyZWF0
ZSByb3RhdGlvbiBwcm9wZXJ0eQ0KPiA+ID4gYWNjb3JkaW5nDQo+ID4gPiB0byB0aGUgaGFyZHdh
cmUgY2FwYWJpbGl0eSIuIEkgdGhpbmsgdGhpcyBtb2RpZmljYXRpb24gaXMgbm90DQo+ID4gPiBy
ZWxhdGVkDQo+ID4gPiB0byBjcmVhdGUgcHJvcGVydHksIHNvIHNlcGFyYXRlIHRoaXMgdG8gYW5v
dGhlciBwYXRjaC4NCj4gPiANCj4gPiBTaW5jZSB0aGVzZSBtb2RpZmljYXRpb25zIGFyZSBhbGwg
cmVsYXRlZCB0byByb3RhdGlvbiBwcm9wZXJ0eSwgb3INCj4gPiBzaG91bGQgSSBjaGFuZ2UgdGhl
IHRpdGxlIGFuZCBjb21taXQgbWVzc2FnZSB0byAiTW9kaWZ5IHJvYXRpb24NCj4gPiBwcm9wZXJ0
eSBmb3IgcGFzc2luZyBJR1QiPw0KPiANCj4gT0suIEJ1dCBJIGRvbid0IGtub3cgd2h5IGRvIHRo
aXMsIHNvIGRlc2NyaWJlIG1vcmUgYWJvdXQgdGhpcy4NCj4gDQoNCkdvdCBpdCwgdGhhbmtzLiBX
aWxsIGFkZCBtb3JlIGluZm9ybWF0aW9uIHRvIHRoZSBjb21taXQgbWVzc2FnZS4NCg0KPiA+IA0K
PiA+ID4gDQo+ID4gPiA+IA0KPiA+ID4gPiAgCS8qDQo+ID4gPiA+ICAJICogVE9ETzogUm90YXRp
bmcvcmVmbGVjdGluZyBZVVYgYnVmZmVycyBpcyBub3QNCj4gPiA+ID4gc3VwcG9ydGVkIGF0DQo+
ID4gPiA+IHRoaXMgdGltZS4NCj4gPiA+ID4gIAkgKgkgT25seSBSR0JbQVhdIHZhcmlhbnRzIGFy
ZSBzdXBwb3J0ZWQuDQo+ID4gPiA+ICAJICovDQo+ID4gPiA+IC0JaWYgKHN0YXRlLT5mYi0+Zm9y
bWF0LT5pc195dXYgJiYgcm90YXRpb24gIT0gMCkNCj4gPiA+ID4gKwlpZiAoc3RhdGUtPmZiLT5m
b3JtYXQtPmlzX3l1diAmJiAoc3RhdGUtPnJvdGF0aW9uICYNCj4gPiA+ID4gfkRSTV9NT0RFX1JP
VEFURV8wKSkNCj4gPiA+ID4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiA+IA0KPiA+ID4gPiAt
CXN0YXRlLT5yb3RhdGlvbiA9IHJvdGF0aW9uOw0KPiA+ID4gPiAtDQo+ID4gPiA+ICAJcmV0dXJu
IDA7DQo+ID4gPiA+ICB9DQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiA+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYw0KPiA+ID4gPiBpbmRleCA0
Mzk4ZGI5YTYyNzYuLjI3M2M3OWQzN2JlZiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9n
cHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiA+ID4gKysrIGIvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gPiA+ID4gQEAg
LTM4Myw2ICszODMsMTUgQEAgdm9pZA0KPiA+ID4gPiBtdGtfb3ZsX2FkYXB0b3JfcmVnaXN0ZXJf
dmJsYW5rX2NiKHN0cnVjdA0KPiA+ID4gPiBkZXZpY2UgKmRldiwgdm9pZCAoKnZibGFua19jYiko
dm8NCj4gPiA+ID4gIAkJCQkgICAgIHZibGFua19jYiwNCj4gPiA+ID4gdmJsYW5rX2NiX2RhdGEp
Ow0KPiA+ID4gPiAgfQ0KPiA+ID4gPiANCj4gPiA+ID4gK3Vuc2lnbmVkIGludCBtdGtfb3ZsX2Fk
YXB0b3Jfc3VwcG9ydGVkX3JvdGF0aW9ucyhzdHJ1Y3QgZGV2aWNlDQo+ID4gPiA+ICpkZXYpDQo+
ID4gPiA+ICt7DQo+ID4gPiA+ICsJLyoNCj4gPiA+ID4gKwkgKiBzaG91bGQgc3RpbGwgcmV0dXJu
IERSTV9NT0RFX1JPVEFURV8wIGlmIHJvdGF0aW9uIGlzDQo+ID4gPiA+IG5vdA0KPiA+ID4gPiBz
dXBwb3J0ZWQsDQo+ID4gPiA+ICsJICogb3IgSUdUIHdpbGwgZmFpbC4NCj4gPiA+ID4gKwkgKi8N
Cj4gPiA+ID4gKwlyZXR1cm4gRFJNX01PREVfUk9UQVRFXzA7DQo+ID4gPiA+ICt9DQo+ID4gPiA+
ICsNCj4gPiA+ID4gIHZvaWQgbXRrX292bF9hZGFwdG9yX3VucmVnaXN0ZXJfdmJsYW5rX2NiKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+ID4gIHsNCj4gPiA+ID4gIAlzdHJ1Y3QgbXRrX2Rpc3Bf
b3ZsX2FkYXB0b3IgKm92bF9hZGFwdG9yID0NCj4gPiA+ID4gZGV2X2dldF9kcnZkYXRhKGRldik7
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5jDQo+ID4gPiA+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRw
X2NvbXAuYw0KPiA+ID4gPiBpbmRleCBmZmE0ODY4YjEyMjIuLjIwNmRkNmY2Zjk5ZSAxMDA2NDQN
Cj4gPiA+ID4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAu
Yw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBfY29t
cC5jDQo+ID4gPiA+IEBAIC00MjIsNiArNDIyLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtf
ZGRwX2NvbXBfZnVuY3MNCj4gPiA+ID4gZGRwX292bF9hZGFwdG9yID0gew0KPiA+ID4gPiAgCS5y
ZW1vdmUgPSBtdGtfb3ZsX2FkYXB0b3JfcmVtb3ZlX2NvbXAsDQo+ID4gPiA+ICAJLmdldF9mb3Jt
YXRzID0gbXRrX292bF9hZGFwdG9yX2dldF9mb3JtYXRzLA0KPiA+ID4gPiAgCS5nZXRfbnVtX2Zv
cm1hdHMgPSBtdGtfb3ZsX2FkYXB0b3JfZ2V0X251bV9mb3JtYXRzLA0KPiA+ID4gPiArCS5zdXBw
b3J0ZWRfcm90YXRpb25zID0NCj4gPiA+ID4gbXRrX292bF9hZGFwdG9yX3N1cHBvcnRlZF9yb3Rh
dGlvbnMsDQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiANCj4gPiA+ID4gIHN0YXRpYyBjb25zdCBjaGFy
ICogY29uc3QNCj4gPiA+ID4gbXRrX2RkcF9jb21wX3N0ZW1bTVRLX0REUF9DT01QX1RZUEVfTUFY
XQ0KPiA+ID4gPiA9DQo+ID4gPiA+IHsNCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmMNCj4gPiA+ID4gYi9kcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+ID4gPiA+IGluZGV4IGUyZWM2MWI2OTYxOC4uODk0
YzM5YTM4YTU4IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RybV9wbGFuZS5jDQo+ID4gPiA+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHJtX3BsYW5lLmMNCj4gPiA+ID4gQEAgLTM0NCw3ICszNDQsNyBAQCBpbnQgbXRrX3BsYW5l
X2luaXQoc3RydWN0IGRybV9kZXZpY2UgKmRldiwNCj4gPiA+ID4gc3RydWN0DQo+ID4gPiA+IGRy
bV9wbGFuZSAqcGxhbmUsDQo+ID4gPiA+ICAJCXJldHVybiBlcnI7DQo+ID4gPiA+ICAJfQ0KPiA+
ID4gPiANCj4gPiA+ID4gLQlpZiAoc3VwcG9ydGVkX3JvdGF0aW9ucyAmIH5EUk1fTU9ERV9ST1RB
VEVfMCkgew0KPiA+ID4gPiArCWlmIChzdXBwb3J0ZWRfcm90YXRpb25zKSB7DQo+ID4gPiANCj4g
PiA+IFdoeSBuZWVkIHRoaXMgbW9kaWZpY2F0aW9uPw0KPiA+ID4gQmVmb3JlIFNlYW4ncyBwYXRj
aCBbMV0sIG9ubHkgc3VwcG9ydCByb3RhdGUgMCBhbmQgZG9lcyBub3QNCj4gPiA+IGNyZWF0ZQ0K
PiA+ID4gcHJvcGVydHkgYW5kIGl0IHdvcmtzLiBXaHkgZG9lcyBpdCBtdXN0IGNyZWF0ZSBwcm9w
ZXJ0eSBmb3Igb25seQ0KPiA+ID4gc3VwcG9ydCByb3RhdGUgMD8NCj4gPiANCj4gPiBZZXMsIGFz
IGxvbmcgYXMgdGhlIHVzZXIgZG9lc24ndCBjaGVjayByb3RhdGlvbiBwcm9wZXJ0aWVzIGJlZm9y
ZQ0KPiA+IGNvbW1pdGluZyB0aGUgcGl0dXJlcywgdGhlcmUgd2lsbCBiZSBubyBwcm9ibGVtLiBC
dXQgSUdUIHNvbWVob3cNCj4gPiBjaGVja2VkIHRoaXMgRFJNX01PREVfUk9UQVRFXzAgZmxhZyBi
ZWZvcmUgZXhlY3V0aW5nIHRoZSB0ZXN0cyAobm90DQo+ID4gYWxsDQo+ID4gb2YgdGhlbSksIGFu
ZCBsZWFkcyB0byBmYWlsdXJlcyBpbiB0aGVzZSB0ZXN0IGl0bWVzLg0KPiANCj4gT0ssIHNvLCB3
aGVuIHN1cHBvcnRlZF9yb3RhdGlvbnMgPT0gTlVMTCAobXRrX2Rpc3BfcmRtYSksIGl0IHNob3Vs
ZA0KPiBhbHNvIGNyZWF0ZSByb3RhdGlvbiBwcm9wZXJ0eS4gQnV0IEknbSBjb25mdXNlZCB0aGF0
IGlmIElHVCBhc3N1bWUNCj4gdGhhdA0KPiBhbGwgZHJtIGRyaXZlciBzaG91bGQgaGF2ZSByb3Rh
dGlvbiBwcm9wZXJ0eSwgd2h5IGRybSBjb3JlIGRvZXMgbm90DQo+IGFkZA0KPiB0aGlzIHByb3Bl
cnR5IGZvciBhbGwgZHJtIGRyaXZlcj8NCj4gDQoNCkFmdGVyIGNoZWNraW5nIHRoZSByZXBvcnQs
IG9ubHkgImdyYXBoaWNzLklndEttcy5rbXNfZmxpcF91bnN0YWJsZSIgaGFzDQpzdWNoIGEgY29u
c3RyYWludC4gSG93ZXZlciwgc2luY2UgSUdUIHZlcnNpb24gaXMgc3RpbGwga2VlcCB1cGRhdGlu
ZywNCnRoZXJlIGFyZSBub3QgZ3VhcmFudGVlcyBhYm91dCB0aGlzIGJlaGF2aW9yLg0KDQpJIGRp
ZCBzZWFyY2ggZm9yICJEUk1fTU9ERV9ST1RBVEVfMCIgaW4gdGhlIGtlcm5lbCB0byBjaGVjayBp
ZiB0aGVyZSBpcw0KYW55IHJ1bGUgb3IgZXZlbiBzdWdnZXN0aW9uIGFib3V0IHNldHRpbmcgdGhp
cyBwcm9wZXJ0eSwgYnV0IHRoZSBmbGFnDQppcyByYXJlbHkgZXZlbiBtZW50aW9uZWQuDQoNCk1h
eWJlIHdlIGNvdWxkIGFsc28gcmVwb3J0IHRoaXMgaXNzdWUgdG8gSUdUIHRlYW0gaW5zdGVhZCBv
ZiBjaGFuZ2luZw0KdGhlIGJlaGF2aW9yIG9mIG91ciBkcml2ZXIuDQoNCj4gUmVnYXJkcywNCj4g
Q0sNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gWzFdIA0KPiA+ID4gDQo+ID4gDQo+
ID4gDQo+IA0KPiANCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kcm1fcGxhbmUuYz9oPXY2LjctcmM2JmlkPWVmODdkM2UyZGQyNTEzNzRjNWM5ZmEzYjY1MDJh
ZWZmOGZlMjlkYTkNCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IENLDQo+ID4gPiANCj4g
PiA+ID4gIAkJZXJyID0gZHJtX3BsYW5lX2NyZWF0ZV9yb3RhdGlvbl9wcm9wZXJ0eShwbGFuZSwN
Cj4gPiA+ID4gIAkJCQkJCQkgRFJNX01PDQo+ID4gPiA+IERFX1JPVEFUDQo+ID4gPiA+IEVfMCwN
Cj4gPiA+ID4gIAkJCQkJCQkgc3VwcG9yDQo+ID4gPiA+IHRlZF9yb3RhDQo+ID4gPiA+IHRpb25z
KTsNCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4zOS4yDQo+ID4gPiA+IA0KPiA+IA0KPiA+IFRoYW5r
cywNCj4gPiBTaGF3bg0K

