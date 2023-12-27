Return-Path: <linux-kernel+bounces-11880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294EA81ECDC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 08:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89AD8B2182B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC6B5668;
	Wed, 27 Dec 2023 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="bJ5x2jB0";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oqfySnBc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2485C63AA;
	Wed, 27 Dec 2023 07:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: df3f4b42a48711eea2298b7352fd921d-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=qhrXSYAUQbwV/Tfj44onJSH8R/mTJmVvI+HDA5+nmHM=;
	b=bJ5x2jB0MVNWmK1/l+JtI0gOXnVXbSGoKGJqOK4vu6CCJ3fTHIF0/Uc+zJ4qY9JPRr1sO4pSnHTp4vNUWd8fhQ8CKvLAXwWVy6AHTTbiq/xqp7lKJn5VcGCysgLBDeyjwloYqxSi6ejtvgeuUQrJCsYKNS9zMEwC3nDsqkQ6fNY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:1e57700b-12c2-40ab-b886-9810b0432492,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:281c9e8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: df3f4b42a48711eea2298b7352fd921d-20231227
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1374133029; Wed, 27 Dec 2023 15:16:36 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 15:16:35 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 15:16:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9R5MfHw1ygaa45MQTOh4/Lfpeb/QlagvYU83yo1RRIkOccMdlRujH5tvh9I+Ma37SDwWPWHm+n+kpuBnfZQVGecqaPvm+41kZ2/CCfJy69VCodCX8NJfWZKoJ1phUnp+9DvHv2YK1OW/pzhB4/qccJJPyjNJl4d6o+9gP2+oNSojr29l//0rb4aoxU2nVY2KRBMsAoarGTAOvKaEpjECVNS0Q4yj6PyIG0aobcMB92XAGvP8CKlhWu6in8NF36Zo79+lSp6ArgKGnvTUNWifvDG+i53fJg8E5sydbmEF6hB6B63mso5xvjP/TD6P4Rid9j9NPiEmvl3i1oXsLwztA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhrXSYAUQbwV/Tfj44onJSH8R/mTJmVvI+HDA5+nmHM=;
 b=XQ+WCT04RP1LTSe5gVSWpdF5NmgP6iBvWjWJhas7rwoXVxYO1/Sd4eu9vQuKSFABQ059s7KqdchKIcS7MN2mHlOjXlXBOPYF6bskr0kMmm9+/uJD7p9k42E/dAU3Uiskv9gRK/TfFvs7jOLJuHtRlKnhuqLj0p4fCSR1IvFTieGOf8MSqAImt0xR7zl6ZEAHFxIMoaMRVGSFe4lGszSscYEjMcrNrn6Xy4Yiuv4CH7ungyC5mGp451YyfZwpo9fjnKA12K06y40yZ7VtW33Olr+79hX/Jvm3u8+1Y2zXnoSZ+c6phY80ujq9BjCjBj4gOyVLgLt6kyefCKLLBB3yBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhrXSYAUQbwV/Tfj44onJSH8R/mTJmVvI+HDA5+nmHM=;
 b=oqfySnBcjGBh4cuxRsH6a5Yik3KbnswqQsKGMKk6c80Gvln7TD8ryEjKst1RQtMJAZ0ft9E//7EebDh7wbZJnaO34VgW//qVVIKm40x9ZombSNShmMb7Y2e6CvypNlyqCXLoPQGNeLuxjcZXMT6VTksyNhrDl9YhrT1SkbBOTxE=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by KL1PR03MB5476.apcprd03.prod.outlook.com (2603:1096:820:5f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Wed, 27 Dec
 2023 07:16:32 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 07:16:31 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "chunkuang.hu@kernel.org"
	<chunkuang.hu@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Topic: [PATCH v3 07/11] drm/mediatek: Add secure layer config support
 for ovl
Thread-Index: AQHaNc3/JznM6vCxlUiudiIR7oAm1rC7CUSAgAG0WQA=
Date: Wed, 27 Dec 2023 07:16:31 +0000
Message-ID: <47c5d0e4e74fb0be651035227f0067e6b308b591.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
	 <20231223182932.27683-8-jason-jh.lin@mediatek.com>
	 <eb8fa56d4dfa78f84d32fd7c9e271186d13f4ade.camel@mediatek.com>
In-Reply-To: <eb8fa56d4dfa78f84d32fd7c9e271186d13f4ade.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|KL1PR03MB5476:EE_
x-ms-office365-filtering-correlation-id: b69975b5-90b6-49f7-77ff-08dc06abc016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TxClOvzBJBoQOF3e0pQO+LunNnuwrxPykPRfZkf9TfwXiWMhTT+dssFLkYftmUxJzgIGIuCrBaWeAiq62eWI6IEzoqTrYniBazcXPX8PmY6ISwi2mVlfJ/6d3wHVftkJZpSZksHo6YfktKYDvAzH52Wlk+/lHzF3S07F79mdQNdYvRmOgP0CtDQSeQqo+A3H+Ns/PPTyjzbigWOBrpMwiYr1ZfSMszKzx+ZBmF0WQlgnhlOB9eCn8WVoc+oqRceeOVbV5spJnwSVECusdE2HxRWVuiz1Ak5tGkENT90BoDxgeRBhWZ7EmVdfgRf6K8N+UzxYMLEY/4C/bdWMZOfKnI40Fg1feC1ObIABT95u9aJKajZM3XhqA4w1Q1oV9JVSTO4uOqMB0sVtpb/Eb1XpIk5Y2gNp41INNIoJ/ezjRDhcyMuw0O+zvmKLpuzilua0dTGxoKdrb8yi7sm9F9fbhFSfsaY5XkrDzGMZfSg9PY2oKe0VbOmZEtAZwDN17Gfudrau10LcGluTk0BISVaeUM5aWp/3p5YWtYMZ6jJy9AJJj0dq64IDfinIvTOxIctcGKeLxKQitVbjF9tZ4GdIrcoMRen6EpPoW+FIP81bzcdK1APSL0oqhaVRHdP3f5d6vBVNii26ZQNGc0w9DExQltB1yAPzNjr/31OH1BiWyhM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(346002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(54906003)(91956017)(83380400001)(36756003)(85182001)(41300700001)(86362001)(38100700002)(122000001)(5660300002)(4001150100001)(8936002)(7416002)(64756008)(66556008)(66476007)(8676002)(76116006)(316002)(4326008)(26005)(66946007)(66446008)(110136005)(2616005)(6512007)(6506007)(478600001)(71200400001)(2906002)(6486002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QmRsU0o3QlhETytFbTZpakh4MEJlaUdnNkNoVThLM3FVV3hqSUJmSVRESHFp?=
 =?utf-8?B?ZWVkSXlWby9DdmtQdmlxbHBnOVNsV0pVSEFxSUJxdXVYWkJLOHR3ZWtMQmtM?=
 =?utf-8?B?L0V0NE55dERUSjg0ck5lSVJYYTFjakpWT2xlNDJadzg3UFVEUjJVZS82cW9p?=
 =?utf-8?B?c1p0eEU4cVU1NDd3eU9BQ1JKYWx5ekhOc054bUVTY2UyS3EwUGN4TXJkSllR?=
 =?utf-8?B?LzlvaVJ4OUhUV3FON2NncVRjT1dISmdZVGd5cGg1bVpBTFhXRllmM0hZRFRu?=
 =?utf-8?B?NlBRd0wzTGhaWXBrY0RIV2RYS29nbmc5VmdyNFQwL2xTVWU2WENnenJVMUZO?=
 =?utf-8?B?T1NGa0plQTVIVkxETnQ5TEJPdXhEbGk2SUp1bTgxNXFmK2pWaGdpTjZrdkI0?=
 =?utf-8?B?czQ1ZWtoTkZYaGRHUkUyKzE2SEZwbWlKdnFXamM1YTJGNWtQMFhGQ0pvNlZi?=
 =?utf-8?B?YUQyN2IzU3JZNWVQVkZZa1IzYzFUWU1IaVFsWlVGdUE2VTN2a2t2WkpTbU4v?=
 =?utf-8?B?cm01SjhMbktacFhRVzlyQ2pDS2NBSGtrN2t1eXYwZ2lrbWY2dzdSVnFmdkd3?=
 =?utf-8?B?aG9zNTRRbDduUTBZRWt2RDJSeXFXZmdndkdxZmVUcG56cjJERFhuOFZLK0k3?=
 =?utf-8?B?MWQzaHlvUlhXVUNETkF6a0ZPbjVZU3RwbGtqNXdsNXJacmgrRkp6V0o2NWdV?=
 =?utf-8?B?WDV2MVY3ZlozVDZDSXJrMDRUbGI1UWkzbnNSeDdHRkVaKyt1OVpFaHcvQ0to?=
 =?utf-8?B?Z0NrSXd2K3Z3Nzd4dkRqWldlazdaQzFtVVhPcHViSjBKSTB6czljTDFyTzNS?=
 =?utf-8?B?eG9aclFLblJKMEd0Z3MyYW4vZER2UWJvazVZQUdSWjFESFVUcVRyQTNtWWdo?=
 =?utf-8?B?MU10UmhJTTZsbGt0Vm9NUkRzVjk3dHkweW1PR21SMlo4aWptd2x3eG9COWJD?=
 =?utf-8?B?Rm9LOWFpd3dFdmRpMmFPM1l1dTNIL0RjeGxqMGxGSzMvdWhMVk1BazVRaFp5?=
 =?utf-8?B?MGVsS1htc2JmQUJ1bEpzME5scXVNbzkxSzcxdTk2K21zT0ZsZ0xrY0RFaWRS?=
 =?utf-8?B?TUdJYWRuY2JQRDErNVBZUmZzTXlUNFEvMWF0ZjQrRkoxY2xaTlRRNTNiV29h?=
 =?utf-8?B?ODMwV1JvdjlMckFSSElYQ0crcy9pV1ZvSFc5UnZHUnJZTk1HcEoyNTBoaDRt?=
 =?utf-8?B?bHUvSlpoVk9USXVqemN0cVZXbmE1dEtEaXhmZmYvT0xrc0JNWkdwaUcyVVBL?=
 =?utf-8?B?b200a1MrK0g3VmNWelJuOGhlWDQxY2pTcDBucVU1cXlscWdOVjljNUpJVVRm?=
 =?utf-8?B?U2pjMGhkQXQzL01GTHhpNVdmd0NGWWdhZDBxVGlFcENBR2RWeHc3c3hOZE84?=
 =?utf-8?B?LzBEeWZTdFNOOEF1TEF2TVYySWlwN3pBMEY5Wk1KY3EyUjBiVG9Md2xHV3FX?=
 =?utf-8?B?bmdvL2xIYmYxZEJYSDVJVTlFbHlkYmsvVGZuSWdxV3M2dWVOM0dVMHYwZEJG?=
 =?utf-8?B?RGkzL0FwZ3VvUk0zNjlISnB1ZE96cHdOWkFUb3BBRk1tdkdleDZFUWZ1azd5?=
 =?utf-8?B?VXU4T0tXUEkvbVUvNXdUazRKVGdkQ2dpWXZ1c0ZQWTdUdWNxY1NNcWlVajlk?=
 =?utf-8?B?b2pLVDNBaTZlR2FqNUsvYUlvVjVwMVpzTmcvVmd1QkpJWFErdGVIZzdibkdC?=
 =?utf-8?B?b3lpei8yRTcrdjZ1azJIY0VtWXBVRVRHbm1rcTRjaEFhdnpqcVdCU3JIU1Nh?=
 =?utf-8?B?WnlhQlp1Qkk0ZDk0ZlF1WGNtdlMrSXRhYWptSXBRYVdmenBqS2hGYlMyZEU1?=
 =?utf-8?B?WjlZTmpJZENjL2Y2TENvL3p5K2o5aGZVOWM4OUVTdUR3c2hqcEdpamNoa204?=
 =?utf-8?B?RVNCK1dVU1E2MmxDbDNEczEzT0JaVzVvK3E2UEVMT1Vsd0tySWlScXgybjBD?=
 =?utf-8?B?YzFoaC9LbW9qc2hZbng3MnZwclYycGdMSXRUbXlnSm5oeXFaUUxzWUJFS2p4?=
 =?utf-8?B?SGUwNVVMaFJCK3NSSGZCUkFSREJkc0t6NUtlTnA5UUFCcTZ6MTlnMUZzSmtQ?=
 =?utf-8?B?K01jc1lldkxCQnFVNVZmbHN6SE1iNy80M2pNTEhDcVBpMlhJQWFDLzNmd29k?=
 =?utf-8?B?UWMvRWJWbmVqT2xUV1lHL1lpMGlmdjRyVzh1bTlFQnc4ZFFxWnUzOGhERExl?=
 =?utf-8?B?V1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <835B64009C9BEA44B29BCDE9AF4BD90A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69975b5-90b6-49f7-77ff-08dc06abc016
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 07:16:31.1053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4ZF/z7KPXnnseFeY5cf4NJcpiE7i+I8HYFM7UTFw6cL6KYG0VIi8viIP9ESwelib+iUXYUIwix8EZdg43/KG3ITzH2DlaDvBiI/OQTyTwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB5476

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KT24gVHVlLCAyMDIzLTEyLTI2IGF0
IDA1OjE0ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gSGksIEphc29uOg0KPiAN
Cj4gT24gU3VuLCAyMDIzLTEyLTI0IGF0IDAyOjI5ICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6
DQo+ID4gQWRkIHNlY3VyZSBsYXllciBjb25maWcgc3VwcG9ydCBmb3Igb3ZsLg0KPiA+IA0KPiA+
IFRPRE86DQo+ID4gMS4gTW92ZSBESVNQX1JFR19PVkxfU0VDVVJFIHNldHRpbmcgdG8gc2VjdXJl
IHdvcmxkLg0KPiA+IDIuIENoYW5nZSB0aGUgcGFyYW1ldGVyIHJlZ2lzdGVyIGFkZHJlc3MgaW4g
bXRrX2RkcF9zZWNfd3JpdGUoKQ0KPiA+ICAgIGZyb20gInUzMiBhZGRyIiB0byAic3RydWN0IGNt
ZHFfY2xpZW50X3JlZyAqY21kcV9yZWciLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEphc29u
LUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICB8ICAyICsrDQo+ID4gIGRyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgfCAzMQ0KPiA+ICsrKysrKysr
KysrKysrKysrKystLQ0KPiA+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9kZHBf
Y29tcC5jIHwgMjkNCj4gPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdl
ZCwgNjAgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+ID4gYi9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gPiBpbmRleCAxMzExNTYyZDI1Y2Mu
Ljc3MDU0YWRjZDljZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2Rpc3BfZHJ2LmgNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rp
c3BfZHJ2LmgNCj4gPiBAQCAtOSw2ICs5LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3NvYy9t
ZWRpYXRlay9tdGstY21kcS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210
ay1tbXN5cy5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc29jL21lZGlhdGVrL210ay1tdXRleC5o
Pg0KPiA+ICsjaW5jbHVkZSAibXRrX2RybV9kZHBfY29tcC5oIg0KPiA+ICAjaW5jbHVkZSAibXRr
X2RybV9wbGFuZS5oIg0KPiA+ICAjaW5jbHVkZSAibXRrX21kcF9yZG1hLmgiDQo+ID4gIA0KPiA+
IEBAIC04Miw2ICs4Myw3IEBAIHZvaWQgbXRrX292bF9jbGtfZGlzYWJsZShzdHJ1Y3QgZGV2aWNl
ICpkZXYpOw0KPiA+ICB2b2lkIG10a19vdmxfY29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5z
aWduZWQgaW50IHcsDQo+ID4gIAkJICAgIHVuc2lnbmVkIGludCBoLCB1bnNpZ25lZCBpbnQgdnJl
ZnJlc2gsDQo+ID4gIAkJICAgIHVuc2lnbmVkIGludCBicGMsIHN0cnVjdCBjbWRxX3BrdCAqY21k
cV9wa3QpOw0KPiA+ICt1NjQgbXRrX292bF9nZXRfc2VjX3BvcnQoc3RydWN0IG10a19kZHBfY29t
cCAqY29tcCwgdW5zaWduZWQgaW50DQo+ID4gaWR4KTsNCj4gPiAgaW50IG10a19vdmxfbGF5ZXJf
Y2hlY2soc3RydWN0IGRldmljZSAqZGV2LCB1bnNpZ25lZCBpbnQgaWR4LA0KPiA+ICAJCQlzdHJ1
Y3QgbXRrX3BsYW5lX3N0YXRlICptdGtfc3RhdGUpOw0KPiA+ICB2b2lkIG10a19vdmxfbGF5ZXJf
Y29uZmlnKHN0cnVjdCBkZXZpY2UgKmRldiwgdW5zaWduZWQgaW50IGlkeCwNCj4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+ID4gYi9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiBpbmRleCAyYmZmZTQyNDU0
NjYuLmMxOGY3NjQxMmEyZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2Rpc3Bfb3ZsLmMNCj4gPiBAQCAtNDYsNiArNDYsNyBAQA0KPiA+ICAjZGVmaW5lIERJU1BfUkVH
X09WTF9BRERSKG92bCwgbikJCSgob3ZsKS0+ZGF0YS0+YWRkciArDQo+ID4gMHgyMCAqIChuKSkN
Cj4gPiAgI2RlZmluZSBESVNQX1JFR19PVkxfSERSX0FERFIob3ZsLCBuKQkJKChvdmwpLT5kYXRh
LQ0KPiA+ID4gYWRkciArIDB4MjAgKiAobikgKyAweDA0KQ0KPiA+IA0KPiA+ICAjZGVmaW5lIERJ
U1BfUkVHX09WTF9IRFJfUElUQ0gob3ZsLCBuKQkJKChvdmwpLT5kYXRhLQ0KPiA+ID4gYWRkciAr
IDB4MjAgKiAobikgKyAweDA4KQ0KPiA+IA0KPiA+ICsjZGVmaW5lIERJU1BfUkVHX09WTF9TRUNV
UkUJCQkweDBmYzANCj4gPiAgDQo+ID4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9CSVRTCTE2DQo+
ID4gICNkZWZpbmUgR01DX1RIUkVTSE9MRF9ISUdICSgoMSA8PCBHTUNfVEhSRVNIT0xEX0JJVFMp
IC8gNCkNCj4gPiBAQCAtMTI2LDggKzEyNywxOSBAQCBzdHJ1Y3QgbXRrX2Rpc3Bfb3ZsIHsNCj4g
PiAgCWNvbnN0IHN0cnVjdCBtdGtfZGlzcF9vdmxfZGF0YQkqZGF0YTsNCj4gPiAgCXZvaWQJCQkJ
KCp2YmxhbmtfY2IpKHZvaWQgKmRhdGEpOw0KPiA+ICAJdm9pZAkJCQkqdmJsYW5rX2NiX2RhdGE7
DQo+ID4gKwlyZXNvdXJjZV9zaXplX3QJCQlyZWdzX3BhOw0KPiA+ICB9Ow0KPiA+ICANCj4gPiAr
dTY0IG10a19vdmxfZ2V0X3NlY19wb3J0KHN0cnVjdCBtdGtfZGRwX2NvbXAgKmNvbXAsIHVuc2ln
bmVkIGludA0KPiA+IGlkeCkNCj4gPiArew0KPiA+ICsJaWYgKGNvbXAtPmlkID09IEREUF9DT01Q
T05FTlRfT1ZMMCkNCj4gPiArCQlyZXR1cm4gQklUX1VMTChDTURRX1NFQ19ESVNQX09WTDApOw0K
PiA+ICsJZWxzZSBpZiAoY29tcC0+aWQgPT0gRERQX0NPTVBPTkVOVF9PVkwxKQ0KPiA+ICsJCXJl
dHVybiBCSVRfVUxMKENNRFFfU0VDX0RJU1BfT1ZMMSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gIHN0YXRpYyBpcnFyZXR1cm5fdCBtdGtfZGlzcF9vdmxfaXJx
X2hhbmRsZXIoaW50IGlycSwgdm9pZCAqZGV2X2lkKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgbXRr
X2Rpc3Bfb3ZsICpwcml2ID0gZGV2X2lkOw0KPiA+IEBAIC00NDksOCArNDYxLDIyIEBAIHZvaWQg
bXRrX292bF9sYXllcl9jb25maWcoc3RydWN0IGRldmljZSAqZGV2LA0KPiA+IHVuc2lnbmVkIGlu
dCBpZHgsDQo+ID4gIAkJCSAgICAgIERJU1BfUkVHX09WTF9TUkNfU0laRShpZHgpKTsNCj4gPiAg
CW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgb2Zmc2V0LCAmb3ZsLT5jbWRxX3JlZywg
b3ZsLQ0KPiA+ID4gcmVncywNCj4gPiANCj4gPiAgCQkJICAgICAgRElTUF9SRUdfT1ZMX09GRlNF
VChpZHgpKTsNCj4gPiAtCW10a19kZHBfd3JpdGVfcmVsYXhlZChjbWRxX3BrdCwgYWRkciwgJm92
bC0+Y21kcV9yZWcsIG92bC0NCj4gPiA+IHJlZ3MsDQo+ID4gDQo+ID4gLQkJCSAgICAgIERJU1Bf
UkVHX09WTF9BRERSKG92bCwgaWR4KSk7DQo+ID4gKw0KPiA+ICsJaWYgKHN0YXRlLT5wZW5kaW5n
LmlzX3NlY3VyZSkgew0KPiA+ICsJCWNvbnN0IHN0cnVjdCBkcm1fZm9ybWF0X2luZm8gKmZtdF9p
bmZvID0NCj4gPiBkcm1fZm9ybWF0X2luZm8oZm10KTsNCj4gPiArCQl1bnNpZ25lZCBpbnQgYnVm
X3NpemUgPSAocGVuZGluZy0+aGVpZ2h0IC0gMSkgKg0KPiA+IHBlbmRpbmctPnBpdGNoICsNCj4g
PiArCQkJCQlwZW5kaW5nLT53aWR0aCAqIGZtdF9pbmZvLQ0KPiA+ID4gY3BwWzBdOw0KPiA+IA0K
PiA+ICsNCj4gPiArCQltdGtfZGRwX3dyaXRlX21hc2soY21kcV9wa3QsIEJJVChpZHgpLCAmb3Zs
LT5jbWRxX3JlZywNCj4gPiBvdmwtPnJlZ3MsDQo+ID4gKwkJCQkgICBESVNQX1JFR19PVkxfU0VD
VVJFLCBCSVQoaWR4KSk7DQo+ID4gKwkJbXRrX2RkcF9zZWNfd3JpdGUoY21kcV9wa3QsIG92bC0+
cmVnc19wYSArDQo+ID4gRElTUF9SRUdfT1ZMX0FERFIob3ZsLCBpZHgpLA0KPiA+ICsJCQkJICBw
ZW5kaW5nLT5hZGRyLCBDTURRX0lXQ19IXzJfTVZBLCAwLA0KPiA+IGJ1Zl9zaXplLCAwKTsNCj4g
DQo+IE1hcHBpbmcgaW92YSBzaG91bGQgYmUgZG9uZSB3aGVuIGJ1ZmZlciBhbGxvY2F0aW9uIG9y
IHNvbWUgb3RoZXINCj4gbWFwcGluZyBmdW5jdGlvbiwgaW5zdGVhZCBvZiBldmVyeSBPVkwgZnJh
bWUgY29uZmlndXJhdGlvbi4gU28gdGhlDQo+IHNpemUNCj4gc2hvdWxkIG5vdCBiZSBzZXQgaGVy
ZS4NCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KDQpTaW5jZSB3ZSBjYW4gb25seSBnZXQgdGhl
IHNlY3VyZSBoYW5kbGUgd2hlbiB0aGUgcGxhbmUgdXBkYXRlcywgdGhlDQpidWZmZXIgaGF2ZSB0
byBiZSBtYXBwZWQgaGVyZSBldmVyeSB0aW1lLg0KU28gSSdsbCBhc2sgSU9NTVUgb3duZXIgdG8g
bW92ZSB0aGlzIG1hcHBpbmcgcHJvY2VzcyBpbnRvIGFsbG9jYXRpb24NCnN0ZXAsIHRoZW4gd2Ug
Y2FuIHJlbW92ZSB0aGUgc2l6ZSBoZXJlLg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQo=

