Return-Path: <linux-kernel+bounces-13997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0358216A4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C30A1C21048
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B681FEC6;
	Tue,  2 Jan 2024 03:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="KLt+gqYv";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="wM+LisWB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33084EBC;
	Tue,  2 Jan 2024 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 133aad0aa92011ee9e680517dc993faa-20240102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=8HAt7cGkxWOXTsVGlENPJkjsZDjZRZmT3dSV28CkviM=;
	b=KLt+gqYvEl5p+Y/ZoWU85L64TqUzgMPVUrgPbTSj4mHj+LDfRiD40Cy5OydUXz9tWm77KMInzibfGM5QZw6cUcWJ5QEj00FA4MHLUSuh6w5phR8kwLRwcOw54jAgTajf2Sa1vkuY7TdzeVd35v/SY4ihSWY3aOkW4XpHElfIlLE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:b2dcd02c-b754-48fd-a005-7d8283a4ac2f,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:28af6282-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 133aad0aa92011ee9e680517dc993faa-20240102
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1969021716; Tue, 02 Jan 2024 11:36:12 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 2 Jan 2024 11:36:10 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 2 Jan 2024 11:36:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q3HzmeFhHCKj0122psoullv/BkGnUnLMAZf9Chmfhm6FYLXr+fnBgBm6A+eDIRcnAg/N4CAbfEgvPr0Kdf7934UWmHZjfuAu4qz83YVgRmUWeBSn9pbpBCx8uYmypXtRl/pwRncVtaJtV8UEKjakR9HnNJEv67xQMeDW98ZrhV5loPNMAjQEgbqmvCyd+m6p1CmD6ljEQKnvVpf9EtpiLHdsYgBy+1O2LLyAt6qGyBKEcTYvW45TKveZaeqpanFWY5NuZXEbSNh5GXpcKQh6V7S21SwIWIo/210OKY3FpylEKzVzj/sAFtPxJXqroxFGagbg++laZpMIqNTVIZEmbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HAt7cGkxWOXTsVGlENPJkjsZDjZRZmT3dSV28CkviM=;
 b=Rnn2jnrmWhyG+rRZvy8wC0lYoDOtwd7vypfBBBKaPVjWzrnGLM0JKxsBhWy/IdNMnrQR2PlF7xpVvWxxSb6CnlaxHxcT1Mkq/QilrgmcJ/dojDVQPRT5Kx+jhdIJ3yMR3MW53BGcIIg23ciN45X9vQERC4DdpfLgZ5dJG4/yIMSgFoGNPacbf9/IJT6bd02SnpRrgUaV/jaf/PxPYkBOM1cchIUum1DXP7GjHY+yNQ4D0TNJ8QaHn8GVAAYuwlL3ENDyEULGTvh8CZ6Kcamkq6qxD9B86o57GMSpK2bFOWwojTjbnBmt0wnHN/9noTh7Xn7IFzzXTIop5IH3diXjCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HAt7cGkxWOXTsVGlENPJkjsZDjZRZmT3dSV28CkviM=;
 b=wM+LisWBuhxRoPycOUNiD3eBqPoDl55jdyO4brKiB+ntXw86EnPjpMKC4so6R39kfgRufg0PxrMnvGaZceJflPk1gx36ZmWRXPuDA9kfkQ3WsNniaWkEQgL06bFO6gkoiqJ11BXgtMv/WxObowXTn7etetvhwVdwu8DR0vjA3aE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB9013.apcprd03.prod.outlook.com (2603:1096:101:24a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 03:36:08 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 03:36:07 +0000
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
Subject: Re: [PATCH v4 05/17] drm/mediatek: Set DRM mode configs accordingly
Thread-Topic: [PATCH v4 05/17] drm/mediatek: Set DRM mode configs accordingly
Thread-Index: AQHaLPWXAQgBDfDWlUOLY6fTYpFcj7DF/7iA
Date: Tue, 2 Jan 2024 03:36:07 +0000
Message-ID: <5f84eabf7127a80304d4ac87fba4f667a202fd12.camel@mediatek.com>
References: <20231212121957.19231-1-shawn.sung@mediatek.com>
	 <20231212121957.19231-6-shawn.sung@mediatek.com>
In-Reply-To: <20231212121957.19231-6-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB9013:EE_
x-ms-office365-filtering-correlation-id: ae534d4c-8081-4cfb-6a78-08dc0b43f4ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dZWGHaV0rlx48OLkWyFF0Vf/FJJGuqrWHSesPNz+sfZqSHB5Y3lisvuTTw/RLU/9bW9rFeCxzMow7hlXqRQWigt1Bub6J4D99+GMe3DtgzZ5N4JL5dGgE0SRai8G17H2zDw7hIwfMDIVkxfNbMdqo1/vtwGvBms/t3X3VhHzDF8MPviVBa4GVMLRLd6FnUtAR7hoO8ro+yTFwIHbmFFF4FJleDaJoVCJI5p46X+kJoPfobSRt8LC8H076mIR+mKTGi8+yN3kDCvEbfd2uZ9u7bAANFfcc+nKP1Xd05rypHT35UBc0WJHElwTfueZBmsoCm0Y8VYslB2sa01KQbKbIDZlhEsPmTSblkFCgBQpy8PrzGzN+MA5MsPgjmGuW8JTWZMa+DNI0v4e5tUOB44CChCW5vidDCAWAlRtZIkkDfESQ3vnn+UPtX6bORnfEv0p+CXEEuA86SxTBXyB+6lsaOQL3SzpAWK/KtwKMhE53pmm+QYeeSfouIB/sJOORNIb7Q70knxhCd7U2jwwD+YsBj/UDu+JYZBoHj2oxlcjL0Ho8OYCFWRpquL9w/et7FBm/D7MWvPAXh+u7Lpsoy5jWKnJBLN+qHTeg3yQW+6EfbZ2jyRdmAZ9CyrPRz2XnUBipdB2iE/DaOJbpK188s4iVfhDz5sPCpJvMnFm3nb20L8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(39860400002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(41300700001)(2616005)(26005)(38100700002)(122000001)(8676002)(8936002)(316002)(110136005)(54906003)(5660300002)(4326008)(7416002)(2906002)(4001150100001)(478600001)(71200400001)(6506007)(6512007)(66446008)(66476007)(64756008)(66556008)(66946007)(76116006)(6486002)(38070700009)(86362001)(36756003)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anRaa0tTdkdXQ3hjbXJWRFFhQkNqakE5OUgyRVdyRHdHT2NGbGY1RHBUZ2FU?=
 =?utf-8?B?VUtQWmV5WGFLTFUyenNybGU1Y1ZqejYvamYrSUREUXdFRGlzQUxyM2N3NGVU?=
 =?utf-8?B?NWFpWlYyYVdHaWxTRzNGY29kTW9SQW5OSVFNSGZ0QzRBV3N2djJ1Q00wSWc5?=
 =?utf-8?B?VmR5UEF3RFJ5RVdTV0x0MmlzOTRSK25FTTVkRzZuMU1WU1YzQjk1TzV4SHpL?=
 =?utf-8?B?OFNxenhCb2cwS1FjWUx6aHhKckk4bWJPUk9VMlEwUzQ2TDBBNkJReVFGcTZW?=
 =?utf-8?B?ZzZOb3JJK0FYaHNNYWEvSkE3RnpVK1RwMi9JQkpBTWpQc1B1eVUrTEhoUjlk?=
 =?utf-8?B?RFpFN2hWQ1JLd2NKQ3ZqczZNc0Z4SHZkZHlXVDVCQkxzU3I3UmNGc2JaUnE3?=
 =?utf-8?B?bDAxMGgrbTIyVk5CWk9DK202N2VvbU5VeDZDYmpMUGFRS3ExNTZwVGJWbUxh?=
 =?utf-8?B?bElybkFybGxtc2pZdDI3ZHl1dG9vRTg5Rk5IZTcyZnFpZVhodXVHS3dhL3RF?=
 =?utf-8?B?NXRwUVJ4UVlBYWppOTg3YklFR0hIcUxWVlQ2UzRMTTVLSW96TzFkeWZ2ZkJK?=
 =?utf-8?B?aW51aDcvcVFYK3gya0wwMzRTR3g5M2pJdllpSGF3T2JsRjgyUkZtS2l2Ylo0?=
 =?utf-8?B?TXdZeFFESUpmOC8xMjB3UFpUZDZscTVNL3prRUFHRnZnM0dWeSsrV1liZlZV?=
 =?utf-8?B?dkNKRHRNRXplTnBXN3M0UE5NNU1TaTkwZ1VQL3dZNXRCV1F5TXhlQUhwbXVT?=
 =?utf-8?B?TnRSeEZCNWtTOGNGQWpReEFNSEF4MmRoUklPMWYwN3B0UWNpaFhkdWNEc2w0?=
 =?utf-8?B?Ukppc3pZY21jU1JMS1NiOTV5QXZHd1EwMmVma0NvT2xNYThXcUZTUnM0RlJu?=
 =?utf-8?B?ZGpCRGJ5OEpaVVBsUlV3M0ZMek1TbDVpOGRJWHFQenpjcmVZRTk5c3N3Y0tK?=
 =?utf-8?B?Rkk0OVRQY2pxNDNjaDlnckdjU0txY3FXYWpoR2RLakNaeStUTWFORlZpMExX?=
 =?utf-8?B?ZlBxTDZRVGF2c0w2QWtsVm9iODEzUHFCYTdOQjVGdEU1K2hIOTdaRWRMSkJE?=
 =?utf-8?B?N2tSN2hpVmZ1TjNnY1YxWjdML1pob1BkQ1F2SXQxM2gwTExpYVFXS0Q4eWlL?=
 =?utf-8?B?RTZOQnQwUHNCclk2elBadExDbHVxL0t1N1NrcGxpNHJJckxYcHBORElyN3NL?=
 =?utf-8?B?dUpkRVp4djBXRE95QTlUZnJIUGRxTW03UTZoNmwvSGxKTUw0MnR6L25Hbitw?=
 =?utf-8?B?SHVNUjFaN1hycmJNTnJjYS9sbkswdjVaY1krOGU0aHR5V2pHQW1qWmdZNTls?=
 =?utf-8?B?UmNzeDMyZWlRSnQxVkk5RlpWZno3QkZkNFJjWDZaWVAvVEo1Q21YV1VZU3RL?=
 =?utf-8?B?dFVNbmVXTmxzSFRCYlhqY1U4dDFaYm5WSUU3Q1JleXg4U0lYaFNzVE5KdHRj?=
 =?utf-8?B?Y0tiQ2pOQUhwKytONGhyRDludWF6MjF6VjE0emVFVEtXNUg1b3dycmdFRlVS?=
 =?utf-8?B?ZWdhVGg3cHh0eFFTMjFzUTI3ZzYzek1lWGJMV2tQYW9YdE9xTzZqd29DTjBr?=
 =?utf-8?B?NFE4amljWC9RWk1KdHlGdjJyVUJIaGIwcnVFWDFsRUdJWDJRZUU3a25hb1pJ?=
 =?utf-8?B?eHU4U2ZYKzN1QWlvSVJzWFptVCt4K0QxcWJJMXJSUXNUNjZ6dm9tb1BDaHB6?=
 =?utf-8?B?amgvazYzd09OMm9PNlhZV0xzaU80enRyMmJPNGpsUHBlMmtxck5PbVdTUGtx?=
 =?utf-8?B?U1hmU2dwQVRoYmppYS9YS2JOeEdFSitBM0JwalNKN2lIZ2tsdEY0WE03N0hL?=
 =?utf-8?B?dG1VdVJvOE1wR3hBNXN4ck1ESlZwWDhjUU1WTWo0Vitrb1lOTGJLT095Zy95?=
 =?utf-8?B?WnFOdmZURGx2MUcwblk1UndHTXBDWDVseUxCdjVBNUFoSXZTNHdjZ2t4MjBh?=
 =?utf-8?B?VjBaWUJwR1QyYXgzMENWa2xIVnd2WUJkLzVEQnlKb2EveFdYM2pDenU2TzRP?=
 =?utf-8?B?c2x5TmdFOW9sckY4NlBudWN1WVdCRFkvZ3Qzd1BMVzNtSlBNSTBnVm5Md1lm?=
 =?utf-8?B?ZVAxN1B2eTIxL21hK2V0WlFNYmwyU3hyY1lmeDdjNGFOZUxad0xFSDFFNjRE?=
 =?utf-8?Q?P53z1C/BpvL/cjV5O08VDKEXR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF068B55B5011A48B100C107E02EBF1A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae534d4c-8081-4cfb-6a78-08dc0b43f4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 03:36:07.8930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wUMFEpkAJMpr9boSOv1hcE4KbFfUDj0QMyUiJfMHsuhJDs5fh7NYVwI2N03Xe+Zp5kV5b91rdsm5W8/hJkdU/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB9013
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.600200-8.000000
X-TMASE-MatchedRID: L8tZF6zWW2o/XHdICuW5rya1MaKuob8PC/ExpXrHizy7qpOHKudqc9qg
	NX5JOETkGQdEeHBaW03ijpjet3oGSJCoy9iDotiwbc297PAGtWZPn74Ug5EKEPNhzIgXtFJVbBt
	5vTg9JXgWZxCauDH9LKCVmgiPL15lQkfxbJAyTm6p4G6k2AuBhwRryDXHx6oXW/Kb+C9IfiJ8VE
	cpJdDXG3RRGyIHHSh2vJZvfm9QLzzIUa50wSQxmLqQyAveNtg6PZmbnY2qDImbKItl61J/yfmS+
	aPr0Ve8oTCA5Efyn8CNo+PRbWqfRDsAVzN+Ov/s6bhXAxanj6Q3gdqWoHzWK7ssjI8mMNz1fTDw
	UYnLVJiDxc8G732Ayw==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.600200-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	2ED2C4A559FA158C84769A2DA7CD0C5B80B005144755FD54EACE4B293BB3A6132000:8

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBUdWUsIDIwMjMtMTItMTIgYXQgMjA6MTkgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IFNldCBEUk0gbW9kZSBjb25maWdzIGxpbWl0YXRpb24g
YWNjcm9kaW5nIHRvIHRoZQ0KPiBoYXJkd2FyZSBjYXBhYmlsaXRpZXMuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5nIDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0t
DQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuYyB8IDI4ICsrKysrKysr
KysrKysrKysrKy0tLS0NCj4gLS0tLQ0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZHJ2LmggfCAgMSArDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDgg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVr
L210a19kcm1fZHJ2LmMNCj4gYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYu
Yw0KPiBpbmRleCA1ZDU1MWJmZjZiM2YuLmE0Yjc0MDQyMGViYiAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmMNCj4gQEAgLTMwNCw2ICszMDQsNyBAQCBzdGF0aWMg
Y29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YQ0KPiBtdDgxODhfdmRvc3lzMF9kcml2
ZXJfZGF0YSA9IHsNCj4gIAkuY29ubl9yb3V0ZXMgPSBtdDgxODhfbXRrX2RkcF9tYWluX3JvdXRl
cywNCj4gIAkuY29ubl9yb3V0ZXNfbnVtID0gQVJSQVlfU0laRShtdDgxODhfbXRrX2RkcF9tYWlu
X3JvdXRlcyksDQo+ICAJLm1tc3lzX2Rldl9udW0gPSAyLA0KPiArCS5tYXhfcGl0Y2ggPSBHRU5N
QVNLKDE1LCAwKSwNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX21tc3lz
X2RyaXZlcl9kYXRhIG10ODE5Ml9tbXN5c19kcml2ZXJfZGF0YSA9DQo+IHsNCj4gQEAgLTMxOCw2
ICszMTksNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YQ0KPiBt
dDgxOTVfdmRvc3lzMF9kcml2ZXJfZGF0YSA9IHsNCj4gIAkubWFpbl9wYXRoID0gbXQ4MTk1X210
a19kZHBfbWFpbiwNCj4gIAkubWFpbl9sZW4gPSBBUlJBWV9TSVpFKG10ODE5NV9tdGtfZGRwX21h
aW4pLA0KPiAgCS5tbXN5c19kZXZfbnVtID0gMiwNCj4gKwkubWF4X3BpdGNoID0gR0VOTUFTSygx
NSwgMCksDQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2
ZXJfZGF0YSBtdDgxOTVfdmRvc3lzMV9kcml2ZXJfZGF0YQ0KPiA9IHsNCj4gQEAgLTMyNSw2ICsz
MjcsNyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YQ0KPiBtdDgx
OTVfdmRvc3lzMV9kcml2ZXJfZGF0YSA9IHsNCj4gIAkuZXh0X2xlbiA9IEFSUkFZX1NJWkUobXQ4
MTk1X210a19kZHBfZXh0KSwNCj4gIAkubW1zeXNfaWQgPSAxLA0KPiAgCS5tbXN5c19kZXZfbnVt
ID0gMiwNCj4gKwkubWF4X3BpdGNoID0gR0VOTUFTSygxNSwgMCksDQo+ICB9Ow0KPiAgDQo+ICBz
dGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdGtfZHJtX29mX2lkc1tdID0gew0KPiBA
QCAtNDYzLDE2ICs0NjYsMTYgQEAgc3RhdGljIGludCBtdGtfZHJtX2ttc19pbml0KHN0cnVjdCBk
cm1fZGV2aWNlDQo+ICpkcm0pDQo+ICAJaWYgKHJldCkNCj4gIAkJZ290byBwdXRfbXV0ZXhfZGV2
Ow0KPiAgDQo+IC0JZHJtLT5tb2RlX2NvbmZpZy5taW5fd2lkdGggPSA2NDsNCj4gLQlkcm0tPm1v
ZGVfY29uZmlnLm1pbl9oZWlnaHQgPSA2NDsNCj4gLQ0KPiAgCS8qDQo+IC0JICogc2V0IG1heCB3
aWR0aCBhbmQgaGVpZ2h0IGFzIGRlZmF1bHQgdmFsdWUoNDA5Nng0MDk2KS4NCj4gLQkgKiB0aGlz
IHZhbHVlIHdvdWxkIGJlIHVzZWQgdG8gY2hlY2sgZnJhbWVidWZmZXIgc2l6ZQ0KPiBsaW1pdGF0
aW9uDQo+IC0JICogYXQgZHJtX21vZGVfYWRkZmIoKS4NCj4gKwkgKiBTZXQgZGVmYXVsdCB2YWx1
ZXMgZm9yIGRybSBtb2RlIGNvbmZpZw0KPiArCSAqIHRoZXNlIHZhbHVlcyB3aWxsIGJlIHJlZmVy
ZW5jZWQgYnkgZHJtX21vZGVfYWRkZmIoKSBhcw0KPiArCSAqIGZyYW1lIGJ1ZmZlciBzaXplIGxp
bWl0YXRpb24uDQo+ICAJICovDQo+IC0JZHJtLT5tb2RlX2NvbmZpZy5tYXhfd2lkdGggPSA0MDk2
Ow0KPiAtCWRybS0+bW9kZV9jb25maWcubWF4X2hlaWdodCA9IDQwOTY7DQo+ICsJZHJtLT5tb2Rl
X2NvbmZpZy5taW5fd2lkdGggPSAxOw0KPiArCWRybS0+bW9kZV9jb25maWcubWluX2hlaWdodCA9
IDE7DQo+ICsJZHJtLT5tb2RlX2NvbmZpZy5jdXJzb3Jfd2lkdGggPSA1MTI7DQo+ICsJZHJtLT5t
b2RlX2NvbmZpZy5jdXJzb3JfaGVpZ2h0ID0gNTEyOw0KDQpXaHkgZG8geW91IGNoYW5nZSBvdGhl
ciBTb0MncyBtaW5fd2lkdGgvbWluX2hlaWdodCBhbmQNCmN1cnNvcl93aWR0aC9jdXJzb3JfaGVp
Z2h0PyBEZXNjcmliZSB0aGUgcmVhc29uLg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiArDQo+ICAJZHJt
LT5tb2RlX2NvbmZpZy5mdW5jcyA9ICZtdGtfZHJtX21vZGVfY29uZmlnX2Z1bmNzOw0KPiAgCWRy
bS0+bW9kZV9jb25maWcuaGVscGVyX3ByaXZhdGUgPSAmbXRrX2RybV9tb2RlX2NvbmZpZ19oZWxw
ZXJzOw0KPiAgDQo+IEBAIC01MDIsNiArNTA1LDE1IEBAIHN0YXRpYyBpbnQgbXRrX2RybV9rbXNf
aW5pdChzdHJ1Y3QgZHJtX2RldmljZQ0KPiAqZHJtKQ0KPiAgCQlmb3IgKGogPSAwOyBqIDwgcHJp
dmF0ZS0+ZGF0YS0+bW1zeXNfZGV2X251bTsgaisrKSB7DQo+ICAJCQlwcml2X24gPSBwcml2YXRl
LT5hbGxfZHJtX3ByaXZhdGVbal07DQo+ICANCj4gKwkJCWlmIChwcml2X24tPmRhdGEtPm1heF9w
aXRjaCkgew0KPiArCQkJCS8qIFNhdmUgNCBieXRlcyBmb3IgdGhlIGNvbG9yIGRlcHRoDQo+IChw
aXRjaCA9IHdpZHRoIHggYnBwKSAqLw0KPiArCQkJCWRybS0+bW9kZV9jb25maWcubWF4X3dpZHRo
ICA9IHByaXZfbi0NCj4gPmRhdGEtPm1heF9waXRjaCA+PiAyOw0KPiArCQkJCWRybS0+bW9kZV9j
b25maWcubWF4X2hlaWdodCA9IHByaXZfbi0NCj4gPmRhdGEtPm1heF9waXRjaCA+PiAyOw0KPiAr
CQkJfSBlbHNlIHsNCj4gKwkJCQlkcm0tPm1vZGVfY29uZmlnLm1heF93aWR0aCA9IDQwOTY7DQo+
ICsJCQkJZHJtLT5tb2RlX2NvbmZpZy5tYXhfaGVpZ2h0ID0gNDA5NjsNCj4gKwkJCX0NCj4gKw0K
PiAgCQkJaWYgKGkgPT0gMCAmJiBwcml2X24tPmRhdGEtPm1haW5fbGVuKSB7DQo+ICAJCQkJcmV0
ID0gbXRrX2RybV9jcnRjX2NyZWF0ZShkcm0sIHByaXZfbi0NCj4gPmRhdGEtPm1haW5fcGF0aCwN
Cj4gIAkJCQkJCQkgIHByaXZfbi0+ZGF0YS0NCj4gPm1haW5fbGVuLCBqLA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmgNCj4gYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kcnYuaA0KPiBpbmRleCBkMmVmZDcxNTY5OWYuLjNkNmMx
ZjU4YTdlYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1f
ZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZHJ2LmgNCj4g
QEAgLTQxLDYgKzQxLDcgQEAgc3RydWN0IG10a19tbXN5c19kcml2ZXJfZGF0YSB7DQo+ICAJYm9v
bCBzaGFkb3dfcmVnaXN0ZXI7DQo+ICAJdW5zaWduZWQgaW50IG1tc3lzX2lkOw0KPiAgCXVuc2ln
bmVkIGludCBtbXN5c19kZXZfbnVtOw0KPiArCXUzMiBtYXhfcGl0Y2g7DQo+ICB9Ow0KPiAgDQo+
ICBzdHJ1Y3QgbXRrX2RybV9wcml2YXRlIHsNCg==

