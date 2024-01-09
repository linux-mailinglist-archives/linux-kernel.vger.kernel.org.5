Return-Path: <linux-kernel+bounces-20612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3077828264
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50714B2730C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA2635EF8;
	Tue,  9 Jan 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="UqLK+520";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="urDk25tK"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D6532C63;
	Tue,  9 Jan 2024 08:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3ec397f6aecb11ee9e680517dc993faa-20240109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=X0hFntTknyVzHDT/JUhE1Mr5ZFX+9PYVUDCgM78Xbd0=;
	b=UqLK+520NCMIxFbttOpHBJ97+4nf53KG/8Q6VhJm8rKZOfoCfC5bO7285TEFnpX/HI8nHIDEOtNpVgfoEusxwnk+iijOYfe5hdWKU+02PUnU/FLFmS6iWPVoD2xdmu3AwIFHli4gB2Xgkc9Gde1IoGEQ5FXQwbzevzw11I9qtLQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:95b49fac-8af0-45be-8bbd-d49b4fa76de9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:cd60267f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3ec397f6aecb11ee9e680517dc993faa-20240109
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <zhi.mao@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 527637858; Tue, 09 Jan 2024 16:44:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Jan 2024 16:44:04 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 9 Jan 2024 16:44:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m35TX75+UCCQTg9EEKXMhLElyCAo26JE/xUT3KVGsEcpGx03f0HjE7HopaJZbYs8kmNrGiQyZWljygFwJwEsV4zfaJsMo5EmfaJ6CZekEwgWOqUR73X7xU0GZh0nPp0i9EqTnVWZydUFG02KzO9thXIYpCasZq8/R/l+U7sWnyXVKy07UnBrhO+jaOZchnL384XHYAtuLHyTMOIrMrHWNrzOsVnvOammlV21lrujnRS957BkMpONniq6zIaOo+21WafRvr1qsxe5fTRTMGTLGkE1nV636Esql418ZK3XDBGk+SMuZroItwkNYpZ5HOWOwfSIxPsjr1PuXiaZ+FJ7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0hFntTknyVzHDT/JUhE1Mr5ZFX+9PYVUDCgM78Xbd0=;
 b=kFESBv2rbvMU8PG8qnXlifviN02X11OBVLopy4IJlkuJuMmNgt2INtYJD2ISYjr1+Vhp+aJjF9fz/O9wL6Tz/jIVSeGhCIVHmdCBYn2n5ODndzNw1hzr45O4/qSORjWAMycn3U1d15F5TaQMfy0eFdZy0akOpMFaXcAtqnC9KbNrMnqjDT8aNLXE8L8E3lor2boqUXj7Cmk9Fc8iAvpUhz3tOrPx+gZ0oT8zRVpa1b6iSt5uBPVGWmSOnyRAmIRDPLXNWbq6Xsq8M5RNwTZxCfRwO6bs8zbxCNqnAG8V+MOPzJE84ejRvL55cdaA4d63Tl1QCFWs3njE7MEWcj5bJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0hFntTknyVzHDT/JUhE1Mr5ZFX+9PYVUDCgM78Xbd0=;
 b=urDk25tKjlP9gsLYYiA/bfF3i9x9a+DCZoYmHFwGw01b9duci1yHN480dr1lMEQ5BH4PirfDYs7OvijmSDTYi6wcVuozAX1T91qh0rWB3akDIy4IJsK3qtvpFhWVuUARcv3i5ECaWIYGD/Rxk4SSii2bWHEdx90Gf/BzQq9WSmE=
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com (2603:1096:400:53::7)
 by KL1PR03MB6169.apcprd03.prod.outlook.com (2603:1096:820:90::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 08:44:01 +0000
Received: from TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ccc5:b092:efbe:6134]) by TYZPR03MB5566.apcprd03.prod.outlook.com
 ([fe80::ccc5:b092:efbe:6134%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 08:44:01 +0000
From: =?utf-8?B?WmhpIE1hbyAo5q+b5pm6KQ==?= <zhi.mao@mediatek.com>
To: "laurent.pinchart@ideasonboard.com" <laurent.pinchart@ideasonboard.com>
CC: "gerald.loacker@wolfvision.net" <gerald.loacker@wolfvision.net>,
	"heiko@sntech.de" <heiko@sntech.de>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "yunkec@chromium.org" <yunkec@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dan.scally@ideasonboard.com" <dan.scally@ideasonboard.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	=?utf-8?B?U2hlbmduYW4gV2FuZyAo546L5Zyj55S3KQ==?=
	<shengnan.wang@mediatek.com>, "hdegoede@redhat.com" <hdegoede@redhat.com>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>, "jacopo.mondi@ideasonboard.com"
	<jacopo.mondi@ideasonboard.com>, =?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?=
	<Yaya.Chang@mediatek.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "bingbu.cao@intel.com"
	<bingbu.cao@intel.com>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"tomi.valkeinen@ideasonboard.com" <tomi.valkeinen@ideasonboard.com>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "10572168@qq.com" <10572168@qq.com>,
	"hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "macromorgan@hotmail.com"
	<macromorgan@hotmail.com>
Subject: Re: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Thread-Topic: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
Thread-Index: AQHaKM07MRhkqnzY9kyFxe9G5PmOILCdekUAgDOBR4CAAGFVgIAAAX8A
Date: Tue, 9 Jan 2024 08:44:01 +0000
Message-ID: <994bc7cdf0993e70956ce1b3dcb4be6c5f331fc5.camel@mediatek.com>
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
	 <20231207052016.25954-2-zhi.mao@mediatek.com>
	 <1d58c2b9-4206-409c-b312-87f4fb649512@linaro.org>
	 <e709beb2acaf0cb68c6922f3b48431644e9a0246.camel@mediatek.com>
	 <20240109083839.GH20868@pendragon.ideasonboard.com>
In-Reply-To: <20240109083839.GH20868@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB5566:EE_|KL1PR03MB6169:EE_
x-ms-office365-filtering-correlation-id: ae20c5f0-7e4d-42dc-f736-08dc10ef20fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PcUsTPXh4+4GEazYVi1Mueh0sQ4tkZiwUFfyiP9vjgAYnhNsHTNc2kGD2xFG/TGEVWsDwa99MaIi4sSmb1tuBEr4rje+UDAOsMpB3SVNzYXtsNajfJ0t84/+pRCiNxm3cO0SLHMREqFYIfafI8KO8azf3vSutQQihmLHBO+m0x8WopAu2ObXuzzRBtBiaQDOj96TQ6WLLxPWX6E7vPptxa2Uo4KFBy3xNczIrFhO77Jlln6J5w1pIwoTWNldUp5DEuFDBEM2NOKETACQZuvpKUGKXyzLMg9AuLeG3YfGAh+3c+CrVrxPqPzJnc4fDvTm5PL3ZFlZ7Xz57cAafu6lhFSQn9wHf4wIUXxjLWd30keBPPPIf1xb2z+41wb8OlerC+1k+bgAH/gc7WD8LO7R0aHjsxoGE7RdivpCxyPp6cy78blV7dfoiBiM2eLIGujFCLW8TwRYQZQw+4QcFsB67Et7UtbMIVYvq2IIGinX7wWUs8+XX2M0TxRLyJcw+4t+7MOUlaR34yb79IkWNXPedcHL3ZNlNIdEe29jHRRR9pXfw2qFdF3Wm20bTRAbsJ17j8XJiBV/snhdz0zcr+FcdMb0zTccGrEJ59nXu/iP4eus3ep3YHWS/pYV7lPyq0d3twcFoaO7UfsTi74+yMOtI+9l/0AgCaiHrE/iIXeftVTtp3uXGxnBJ5QSMxXofwlU8gCTJT3iikIVZuH9RBYUhQ7HKwZvRhV8lxLK/wGGusQpXGvtaXfnOGTgqKnHHMfz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5566.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(39860400002)(346002)(136003)(366004)(230473577357003)(230373577357003)(230273577357003)(230173577357003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(71200400001)(26005)(2616005)(6506007)(6512007)(478600001)(6486002)(38100700002)(122000001)(36756003)(85182001)(86362001)(7416002)(2906002)(41300700001)(66476007)(5660300002)(83380400001)(38070700009)(66446008)(91956017)(66946007)(66556008)(316002)(6916009)(64756008)(54906003)(8676002)(4326008)(76116006)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SndHNUl3NmFETXpQdG9XUU1FelQrYkxDenJoN3psZ3dBNFE1cFc4RW1ldTRG?=
 =?utf-8?B?Qjl1TGpsbndJK2dxNlZTd2laWThxVTFxbVkxbXhqT0xPTmp5QWZESSt4K0lE?=
 =?utf-8?B?Q0NQeDlWOTl3RFg3a1Q1ejY3MHFCYTFUd1ZObmpDY1owU0g0QjhKZmpBaW5X?=
 =?utf-8?B?UFo3YURpS3krYUpMNVd0dUVqamk3Um1sQ1NDVDgxL3RkcFBQWi94QXBsYUxG?=
 =?utf-8?B?ZURrV3Y3NlBmRUx0RHI0OC9YVGM1RkVIZ2Z1MngrRlBuVWlFUlduTGhTTjVn?=
 =?utf-8?B?QWtUMlpSdWR0c0RjZ1dBTDlhTGx1VElFTHI3OUExekdHbmRJU21YcjBVNHYz?=
 =?utf-8?B?Rk9mMmFPamg0VVVBdmpmbFcrWGpxZURiWUNZeEhncDQxQkJkQzlTTHhkaXNB?=
 =?utf-8?B?cyt1ZTcwVFB0K0pxMC9iL3c2S3Q3YVhiSFV3aXBSazcrZ2lGd0hPdjliNCtZ?=
 =?utf-8?B?dzUrN2dIOGhwSjNZR0dNQUVQNERBazl1VHFSSERJTnpSSUM1RHg3bmZFKzJa?=
 =?utf-8?B?ZWdOU2hta09haTQwUkNtN1FhQVJpWCtmeG1MZUhyYzdNYzd4UlVKVkRIS0pp?=
 =?utf-8?B?S2xkblFlcUVId3JOQ0VBU0NkWEI0bUhWTVU2eXMvMm5lakZnYTZ1bWxsSUpq?=
 =?utf-8?B?dytuVW9CcjNIQWYxRjl6NXUxbGZNaGpISXo1cklTVzBUVDlXVndIbVQ5Umw5?=
 =?utf-8?B?TFZxSWMxT1A0TGJtLzFFSlE3MjBqd3Y0bCt3SnNXR3BTWjZmYThYcDh6bTAw?=
 =?utf-8?B?OTZxOGYwbUk0cDFCMVIzbWdtanlla3dhajJkTXFxWlFTOCs1NlJ5SXo0ZWt3?=
 =?utf-8?B?bUJjQjBwZDV4NjYrcHA1R0czZ2NydnFSTmFRdE9PMXhtVEN5RGpqMUZSNzcr?=
 =?utf-8?B?ZnNWbGdGY1BGNXJjbDhWRUdrVzFDSFk2Z2cxL240ZzFKZUxZMUxRZFVzUnUy?=
 =?utf-8?B?cXIxRFNtem83TnljeVFTVUtidGJBT1RWaWpzc21YU1l1UWg5VXZpWlh1MGox?=
 =?utf-8?B?NCtRNFdtOXlpMlFqU09Xc0pZQThMMGNvWExwaTQ5ckttWHhPQVBQRWh6aFcx?=
 =?utf-8?B?YXNOd1JmM2l4NVJ5MnI0Q3VCbWtDV29LQWZrK0t1Wmt3RkJSQXN1Ti9hU3o1?=
 =?utf-8?B?SnRhMlFvVFQ2ZU1VWExpRkhZV3Vwdk1WVHBPcVA0eXIvbDZ3Sm84R1hEaWVn?=
 =?utf-8?B?aWdvYjJVMDJ2VXRvQ0g1Z0RIdVZVWkxyNHJRbmlreFFGbUM3eTVtSEhZaDV3?=
 =?utf-8?B?bW9rUjNxY2d0MHhzblFYYkNmOVo4bEdtQ0MweCt4cXFMaG1oMWxhVTJXc2dB?=
 =?utf-8?B?NXFvZmFOd3JNNEtrb1FWMDdkYXpBUVNwVlJQdFAvRUJJckttcGdzVzdNQWFP?=
 =?utf-8?B?RW5aanhKL0M4ODlVL3NTb3pZR2JlSzUwR0VldnJjejJuZFhXYUdrd000ZVYr?=
 =?utf-8?B?RkxRb3FhdHVrSXRqMCs1K29KR3VmSnVZdGsydld3NVhtaUV4UEtHUm91K2hv?=
 =?utf-8?B?MDBvU2szVGVIUjlUdlZEd01JRHBGb3lCRk1iRlorWW9CL2lLTTRtSjVZSFJu?=
 =?utf-8?B?ZW9KMUd2VW5SK2FYWGQrbzNhWUdPdVl3b1haU0xPL0NDWEFGMU5ETGE4M0U3?=
 =?utf-8?B?VjJLZzUxaEFqYXVzamY4NDJMWjJhMS81QXZ5cThPSXdhY0prMk54Lyt3UjI2?=
 =?utf-8?B?UDhaR2JCZUtPWTRWQStSUU55U242K2EvcEdmeEo3UkFGelBYZmVtZ1ZJbFlZ?=
 =?utf-8?B?Y2lWc3dOTGg4NzVBWlVBQ0pHRGxmd2syRWVPWDNZYXZzK2NaR20ySjU2ZVZO?=
 =?utf-8?B?WWNwNEtqVXZsYzM2UGdnazNlNzJjam9sLzZJajRleFRCbXdSVWU0b3JucWpO?=
 =?utf-8?B?eWs4My9zYkxRNzdqNFZZV2lra3NsYjh6RDBOSDZRSEROWllNc1FobktuZkRM?=
 =?utf-8?B?aTFWNkR1QmlpZlluaDZjeldRMTJweks2ekNwWDMyT0J4Uk14bHhjVEd0WHZQ?=
 =?utf-8?B?MVZEYWh2MmJlWmJjVVRRN1dXc3ZKTWErQTNGWlJpdXZ2M25vaEJRQzJYOUlO?=
 =?utf-8?B?Q1VDWmVFbXhmZEJJaG9VaVdHZ1VkMEo0bWhtdDBlNVRLNG1kMkd4Mm5DTEtN?=
 =?utf-8?Q?bDkl1/3AtoFINWYDBI8fNEtbd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <462A46C170D50144BC6CB66BE8C0B317@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5566.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae20c5f0-7e4d-42dc-f736-08dc10ef20fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 08:44:01.6291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /sVGvJJNpVovHi7yGm2CvMLu3GjUlg5dXdTGPEQY2wramOWEGaHNdorp4gIY1Tdkyzhxqm5zDqxbBkyexaiDrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB6169

T24gVHVlLCAyMDI0LTAxLTA5IGF0IDEwOjM4ICswMjAwLCBMYXVyZW50IFBpbmNoYXJ0IHdyb3Rl
Og0KPiAgCSANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9y
IG9wZW4gYXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBv
ciB0aGUgY29udGVudC4NCj4gIEhlbGxvIFpoaSwNCj4gDQo+IEhUTUwgZS1tYWlscyBhcmUgbm90
IGFsbG93ZWQgb24gdGhlIExpbnV4IGtlcm5lbCBtYWlsaW5nIGxpc3QuIFBsZWFzZQ0KPiB1c2Ug
cGxhaW4gdGV4dCBvbmx5Lg0KU29ycnksIGl0IHNlZW1zIG15IGUtbWFpbCBmb3JtYXQgaGFzIHNv
bWUgcHJvYmxlbS4NCkkgd2lsbCBjaGVjaywgYW5kDQpyZXBseSBpdCBhZ2Fpbi4NCg0KPiBbc25p
cF0NCj4gDQo+ID4gKioqKioqKioqKioqKiBNRURJQVRFSyBDb25maWRlbnRpYWxpdHkgTm90aWNl
DQo+ID4gICoqKioqKioqKioqKioqKioqKioqDQo+ID4gVGhlIGluZm9ybWF0aW9uIGNvbnRhaW5l
ZCBpbiB0aGlzIGUtbWFpbCBtZXNzYWdlIChpbmNsdWRpbmcgYW55DQo+ID4gYXR0YWNobWVudHMp
IG1heSBiZSBjb25maWRlbnRpYWwsIHByb3ByaWV0YXJ5LCBwcml2aWxlZ2VkLCBvcg0KPiBvdGhl
cndpc2UNCj4gPiBleGVtcHQgZnJvbSBkaXNjbG9zdXJlIHVuZGVyIGFwcGxpY2FibGUgbGF3cy4g
SXQgaXMgaW50ZW5kZWQgdG8gYmUNCj4gPiBjb252ZXllZCBvbmx5IHRvIHRoZSBkZXNpZ25hdGVk
IHJlY2lwaWVudChzKS4gQW55IHVzZSwNCj4gZGlzc2VtaW5hdGlvbiwNCj4gPiBkaXN0cmlidXRp
b24sIHByaW50aW5nLCByZXRhaW5pbmcgb3IgY29weWluZyBvZiB0aGlzIGUtbWFpbA0KPiAoaW5j
bHVkaW5nIGl0cw0KPiA+IGF0dGFjaG1lbnRzKSBieSB1bmludGVuZGVkIHJlY2lwaWVudChzKSBp
cyBzdHJpY3RseSBwcm9oaWJpdGVkIGFuZA0KPiBtYXkNCj4gPiBiZSB1bmxhd2Z1bC4gSWYgeW91
IGFyZSBub3QgYW4gaW50ZW5kZWQgcmVjaXBpZW50IG9mIHRoaXMgZS1tYWlsLA0KPiBvciBiZWxp
ZXZlDQo+ID4gDQo+ID4gdGhhdCB5b3UgaGF2ZSByZWNlaXZlZCB0aGlzIGUtbWFpbCBpbiBlcnJv
ciwgcGxlYXNlIG5vdGlmeSB0aGUNCj4gc2VuZGVyDQo+ID4gaW1tZWRpYXRlbHkgKGJ5IHJlcGx5
aW5nIHRvIHRoaXMgZS1tYWlsKSwgZGVsZXRlIGFueSBhbmQgYWxsIGNvcGllcw0KPiBvZg0KPiA+
IHRoaXMgZS1tYWlsIChpbmNsdWRpbmcgYW55IGF0dGFjaG1lbnRzKSBmcm9tIHlvdXIgc3lzdGVt
LCBhbmQgZG8NCj4gbm90DQo+ID4gZGlzY2xvc2UgdGhlIGNvbnRlbnQgb2YgdGhpcyBlLW1haWwg
dG8gYW55IG90aGVyIHBlcnNvbi4gVGhhbmsgeW91IQ0KPiANCj4gVGhpcyBpcyBhbHNvIG5vdCBh
cHByb3ByaWF0ZSBmb3IgbWFpbGluZyBsaXN0cy4gUGxlYXNlIGVuc3VyZSB0aGF0DQo+IGZ1dHVy
ZSByZXBsaWVzIHdpbGwgbm90IGNvbnRhaW4gc3VjaCBmb290ZXJzLiBZb3UgbWF5IG5lZWQgdG8g
Y29udGFjdA0KPiB5b3VyIElUIGRlcGFydG1lbnQgaWYgdGhleSBhcmUgYWRkZWQgYXV0b21hdGlj
YWxseSBieSB0aGUgTWVkaWF0ZWsNCj4gbWFpbA0KPiBzZXJ2ZXJzLg0KPiANCj4gLS0gDQo+IFJl
Z2FyZHMsDQo+IA0KPiBMYXVyZW50IFBpbmNoYXJ0DQo=

