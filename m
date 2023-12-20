Return-Path: <linux-kernel+bounces-6448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09AB8198F2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 459DB1F228B2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D50631CF8F;
	Wed, 20 Dec 2023 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cdXtlo4m";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tm+S7rBX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA71CA8E;
	Wed, 20 Dec 2023 07:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: d801e34e9f0511eeba30773df0976c77-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uPcbDGJ8RYuYMpb8HrZXm5WeuRzf88t/taomuztoQMU=;
	b=cdXtlo4mC6QlaTt/0ivUgv15pmGjIU8CcKzpmErXLEHoKhvK5Nx2pS2O8julViSltuD7Z40Vw7vMidl8U4+SI6KhvqYzbk/YVuwhfpHKCdfBd4vW2z9j0iNt+qXbu9RULmM3HdSHMO4/gnn9pyiL+Lvm9pI5GTtGh34pcdnu2Jw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:89d5334b-662d-44e0-b715-6b190aed37d0,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:5be1e317-1474-414b-9c9f-6d23a122e796,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d801e34e9f0511eeba30773df0976c77-20231220
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <peter.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 670920551; Wed, 20 Dec 2023 15:03:14 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 15:03:12 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 15:03:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2x/RgOdrwmZg2v0vd0flmbALUsXI0DQYzUYaFwBoILs6CkMKXCjpwFoZxUCdT2eFG6REFqMmooNUjWuccTgJ8Isl7LqXXhKZSLGY6DwnToF+E6Yxp8p5D1z2NpxPWQBD63sD9SIP1wyWKUfN74zqJece2t+ELoilknUJ+x8pVnaISveK7GvBtxHGLDfsloSR6Qg9C/D+RtppknNStglY8eIwsp07OtCq/NS/+W8BIr7AY6So6eM+UcgLS6oF2RNlt+NcjjXVlMq5QnmUubgcYtDvOvqJ2w01IcbWou47ma8aDOX1xsdKaXE09qiWyooaXfh43FK3kAOeWGj0v1LYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPcbDGJ8RYuYMpb8HrZXm5WeuRzf88t/taomuztoQMU=;
 b=oCULOMpWbuwY5sQNh05cVLx6nNg4afnUAjV2N2AGens67sbczZWN4MmrGWOf9xm67pd2QvqReH0YMwvMHZQByrkl/RPSSPeAF5vxq8qEhh8wz8YLrlOdcAvTJ/CfcAX3Ms/W5DKrVi5YxpsCnbD+ozm557P9Pjn+6algNLPPdTTkY/1xnjYKwygEBglvoHma75D2KcodFHRbwGyiniqrqoupDNmuUkJz+PxYHAYKRYjyQMmXSuXjgdX+vmsKDlbyVibkfMPunh9aIR7Kd7dTTf320Xz7kHI3WwYi+iiSiLOjdSOm85xzXU2Fh/BicG7Mpb6TzHWMt04c7QZKirNfqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPcbDGJ8RYuYMpb8HrZXm5WeuRzf88t/taomuztoQMU=;
 b=tm+S7rBXxPQ9oaxTJKpawbRsJSo0pMl1zvuYkVergYNjdBOEF4n59CdjIU9lPzqp8HUEl1TVH7yv+6ZfWHAfKXvKd+f1PTP6OeYEVPgHV6Q4xOqiuowuXSZKotv26GcLluN4DM+AHWsoQQswGqqA0bxDRaPMxyVqr0gCUPlw2hc=
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6)
 by TYZPR03MB5213.apcprd03.prod.outlook.com (2603:1096:405:6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 07:03:11 +0000
Received: from PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::4cdf:58fb:79dd:4b7f]) by PSAPR03MB5605.apcprd03.prod.outlook.com
 ([fe80::4cdf:58fb:79dd:4b7f%4]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 07:03:10 +0000
From: =?utf-8?B?UGV0ZXIgV2FuZyAo546L5L+h5Y+LKQ==?= <peter.wang@mediatek.com>
To: "ebiggers@google.com" <ebiggers@google.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"quic_nguyenb@quicinc.com" <quic_nguyenb@quicinc.com>, "jejb@linux.ibm.com"
	<jejb@linux.ibm.com>, "beanhuo@micron.com" <beanhuo@micron.com>,
	"avri.altman@wdc.com" <avri.altman@wdc.com>, "bvanassche@acm.org"
	<bvanassche@acm.org>, "cw9316.lee@samsung.com" <cw9316.lee@samsung.com>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
	"alim.akhtar@samsung.com" <alim.akhtar@samsung.com>, "chu.stanley@gmail.com"
	<chu.stanley@gmail.com>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>, =?utf-8?B?UG93ZW4gS2FvICjpq5jkvK/mlocp?=
	<Powen.Kao@mediatek.com>, "Arthur.Simchaev@wdc.com"
	<Arthur.Simchaev@wdc.com>, "mani@kernel.org" <mani@kernel.org>,
	=?utf-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= <stanley.chu@mediatek.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "quic_cang@quicinc.com"
	<quic_cang@quicinc.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "yang.lee@linux.alibaba.com"
	<yang.lee@linux.alibaba.com>
CC: "jt77.jang@samsung.com" <jt77.jang@samsung.com>, "sh043.lee@samsung.com"
	<sh043.lee@samsung.com>, "grant.jung@samsung.com" <grant.jung@samsung.com>,
	"dh0421.hwang@samsung.com" <dh0421.hwang@samsung.com>
Subject: Re: [PATCH] ufs: mcq: Adding a function for MCQ enable
Thread-Topic: [PATCH] ufs: mcq: Adding a function for MCQ enable
Thread-Index: AQHaMwYy+/NXuE2dq0eEgRehSQFm3rCxvyCA
Date: Wed, 20 Dec 2023 07:03:10 +0000
Message-ID: <dad07aaadcb7f6f7597ba171c35598008e69b58c.camel@mediatek.com>
References: <CGME20231220052749epcas1p3b90f6c03110ff5f63ffc547ef0f35907@epcas1p3.samsung.com>
	 <20231220052737.19857-1-cw9316.lee@samsung.com>
In-Reply-To: <20231220052737.19857-1-cw9316.lee@samsung.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5605:EE_|TYZPR03MB5213:EE_
x-ms-office365-filtering-correlation-id: 8f65736f-2c2a-496f-8f3b-08dc0129ba29
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J/6MqgT6bA304yZYdLAPb/KYfrW/Jr+nUfVZUc1dJ0AFNGL1PhoRDF7oZc/oNrMDjlCIot8fuQcZgHze6GGpRadQW8PYGyr7+Uaxbdfrrv71lrs+EFKZycxuVhL86oL/P3fHuxcfNOGrCZidVw2u0aE7r/lkSwaIOoH0bipzVTtOmhtmfxqHXHtdpP0910p0fDTAg6jhWx81hat0V8TIgVNBsjrOeIg/j1u3CR61KGVci8XotYeTc8jjho2/dgec32hfhVwKsAAhGmXdebTq90uJ8ytONn3nB9nBrl8hZcDTg0DFEh5liEmtMi1vPDx1vEhX6mRsjJZbKeCX4wsrRjmOtyjPAnMV1NqSDYZjQdS6w9usajCTyNr+y5W+/49ypBGVY0NsMWY6X0G5enpru1E4HvyJfwwwnlgYPLRFCfChu4oVKOs4lrNeWJ1nqKhHdLzo/yVTr2D7ZeXqESBdT9Y2FtbTBB9oszUVAWg19GeJPWDhBSlwAmurJSycocfUx/gj5kyrPPniT5+JIhupY8xXYaiGJNY9Joo6W+AmWALXItzF3YPFI/Eoe7i2rjzvrlQX7posoloDyUIxxakslqbUoLn3sW/z3ul2BBn2+tUhCVEnpzJ/vfYCDGZZE1FTJg2RQ5ZouNbTAqq6Ome7VGHNbd5aEW0v5cBo/MAlcubZpXhXoFLSFvirG51tGzrFIPQY3vBGurD1a/PR+MH7onl25hgPS1qf5jZ1XX+NbUsoF+hB8gGrTSiaOxyqARdR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5605.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230273577357003)(230922051799003)(230173577357003)(64100799003)(186009)(1800799012)(451199024)(26005)(6512007)(86362001)(83380400001)(6506007)(2616005)(110136005)(54906003)(316002)(4326008)(8676002)(8936002)(66446008)(6486002)(71200400001)(478600001)(66556008)(91956017)(64756008)(66946007)(38100700002)(66476007)(76116006)(122000001)(38070700009)(41300700001)(7416002)(4001150100001)(2906002)(36756003)(85182001)(5660300002)(921008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjIxSGRGQ0R4dkpVVWRoM3d3bGpSajgrSnlIcjJNRGVoSzg1YUpNN3Z3RVRF?=
 =?utf-8?B?RVRwLzVnSTh2TVJVSWdUZDFCSERSOTlGWlh1dEl6SmdETHZpdkNJYUFqTWkz?=
 =?utf-8?B?U0pEYU5vY1B2LzV3akxHVVhQUk56SnVtYWNMSDBvUUM4MTV6S1c4TzFMcDlI?=
 =?utf-8?B?K3ZaNWlaMzJRdWxJZDA2cnllZFU0ay9Wb1QrNHBTMjhDdFFvWERrZTMxYUto?=
 =?utf-8?B?dGZzZ2NxVEJvV2tuQ1k1czA1WWZFcllBcVFMODBzYkRjOUFrNUlNNXFVSXMr?=
 =?utf-8?B?TkhISnhpSW5UbCsxcktRZ3hpZDhRckRiQVY3OXc0SUVrbWwzWVV6VFZLZVQ5?=
 =?utf-8?B?clYxSjl1U0srTDFRMlFPZTNXalU2cDBXUTdSblhuMHhRZDFra2p2dkpnakpE?=
 =?utf-8?B?TXQxVktzOFkrKzhDSXZSL2had1pqSzkveEFtSEJkT1p4cUNIT1lyOVBIaEpa?=
 =?utf-8?B?MWxSbHpYQXV6SS93alRESDNrdUl4eGFsaS9mNE05ODBkK0t4UkZ0S28zMXpj?=
 =?utf-8?B?dy9DZmNIVVBNYjJKL2tJK281MzRaVGo1Z2x3RmN5U2xtaDJibzFQODc1bE43?=
 =?utf-8?B?SjJrajRncCtUNHJBVGxNZVUwdGVqOG4rQkFiQ0Q3Q3M5dE5mWldsMG4vYXRS?=
 =?utf-8?B?WFNYZDcwd1FMK2NBNkFHYU1ZajR0cjZ1alg3akN2VSszVDBjbHI2ZmdQYkEz?=
 =?utf-8?B?RE5kYXBDWjBZNVl2cWNDUVZmQlVETVNvcEhZaVpyM1JGS1d1bFFsTEtRSG42?=
 =?utf-8?B?OERKb0k0SWpzOVRGMGVSQmRzZXM1c2EwM2U5SCs3c0czUWpDQmNkZnR1OVVJ?=
 =?utf-8?B?aS9JUG40eEJZOFIwYnhKYndmWFRPanJFa0dpdTl1bnRhUm8rOE0xamM2dFlh?=
 =?utf-8?B?TFJ3K2cxWTFvUFVUR2pBWGJQMWJnM0RFQzJuNWtTQ1dIU3R6TnNjeS8vSGsx?=
 =?utf-8?B?VmlTKy9CTm10TDQ2d1VadVg5UDVOSXllRHhVeHl5bzJTSjdlTENVd1YxRllr?=
 =?utf-8?B?bW9ZUFhCeVliK1lSTVhobnNaNE1ieCtuWC9jRHpDb29MeHZqaTlFeHBnTlNs?=
 =?utf-8?B?SUJINDdDRE01MUx5QjY0NzMwMjd0Sys1WXV5S1ZTWEFlNHRLQ1ZxSUxWaHds?=
 =?utf-8?B?eVdxOXZHUXVUdVlYQ2JpS201dTkzVVFlSkRaZ3ZoWmJrTjlPdW1IUTg4R2xn?=
 =?utf-8?B?RlU5TjdWbTljL0NtRG5HR2c0WnBKMzczWHZKV2RKOVNWY3hob0ttVVdQd0Q5?=
 =?utf-8?B?Y2FjdjhQWStQQkdFdjg0aHMrUGhHM1ExNkcvbk5QT21vd2s3dlZSQWZVcVJj?=
 =?utf-8?B?eTdhK3NYVkVkdEV3RmM1SG5KZ1ZCdXZSbW5WTXdzSjJLZ0VJV3BJRG9nV3pL?=
 =?utf-8?B?MytNbkViMVY0c1lFSGVXNU1jdFR6aE42VHpEbUNMdjJyRkc1eTA2aUszdk1y?=
 =?utf-8?B?Vm5iMkRnbm8xdnlOdVRZS0Qwdm5scmFkeXhuMTdtdjVIZmhvNGg2YmxkeXla?=
 =?utf-8?B?ekpPVE80MHZEeWRwT1NndmJlV0lyWS9ITEZIWWp5QkJYQWJwVXlwdkMyeWN2?=
 =?utf-8?B?V2tUZ2VlWFpua0hFNDdMN2hQS3JabDVtdklBTFlhaExiQnJkQUVSNnFFa0hU?=
 =?utf-8?B?bDRzRkxiQkhHUWJmM1FkQVR1VjA3aU9BaGxQSHQwTDNJNzZkSTBTNkxVQnVM?=
 =?utf-8?B?RkQ2T3l2dEpDUXgvK1pFWE5yeWFHTFBIWGZ5MHRrMlkycjNEeUZIa0dWNVZu?=
 =?utf-8?B?U2YySW9KV1VYQVd5eG5JdjlPYTA4QUxuLzY0dWY1VFVoNWJHZy9kalpoOEhR?=
 =?utf-8?B?OUxMNFcxcU9meEZoL2F1c0hZRWVIekNHSzdxZUx4SUFYTlJaNXRicEExbzd4?=
 =?utf-8?B?NWFIdXRRbHpVRzg2b2JCbU4wTlEzYnFCWFpJRTdXZWxIc0lQZ0RUZmY5THJm?=
 =?utf-8?B?R2JUejdPaGk0UDZOaDIramYrQzdQNVZqK3lmaVFleUN5eFNzM3lpaVFPeHRh?=
 =?utf-8?B?QWoyNlE2R29vOWZPbnllZndhN1oyeTVxMG9lT0dNMytNck9hL0VQeFhGekNX?=
 =?utf-8?B?akZMOTEvZDBZSXJyYmFQeVlWTG1xVFMrclphbGJFalUxeCtTSEVoMk0zZ0li?=
 =?utf-8?B?clZGcXZNZ1ZkeUo4NFN6UmNac3lZRzFpQ255dGUyWEkzOFJoQzFnNDIzZ3dj?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0679B20E1E5AE458BAC4DA36A34598A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5605.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f65736f-2c2a-496f-8f3b-08dc0129ba29
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 07:03:10.7950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rptF84E3xsEHs8PYgWpCXNfzAcDQy8qXVUZ4pgLajWDW4n08s8YqraZq8t3LSK+a8L/cbqHdoqDFvcbbWu+RRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5213
X-MTK: N

T24gV2VkLCAyMDIzLTEyLTIwIGF0IDE0OjI3ICswOTAwLCBDaGFud29vIExlZSB3cm90ZToNCj4g
IAkgDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+ICBGcm9tOiBDaGFuV29vIExlZSA8Y3c5MzE2LmxlZUBzYW1zdW5nLmNvbT4N
Cj4gDQo+IFRoZSBSRUdfVUZTX01FTV9DRkcgcmVnaXN0ZXIgaXMgdG9vIGdlbmVyYWwoYnJvYWQp
DQo+IGFuZCBpdCBpcyBkaWZmaWN1bHQgdG8ga25vdyB0aGUgbWVhbmluZyBvZiBvbmx5IHZhbHVl
cyBvZiAweDEgYW5kDQo+IDB4Mi4NCj4gU28gZmFyLCBjb21tZW50cyB3ZXJlIHJlcXVpcmVkLg0K
PiANCj4gVGhlcmVmb3JlLCBJIGhhdmUgYWRkZWQgbmV3IGZ1bmN0aW9ucyBhbmQgZGVmaW5lcw0K
PiB0byBpbXByb3ZlIGNvZGUgcmVhZGFiaWxpdHkvcmV1c2FiaWxpdHkuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBDaGFuV29vIExlZSA8Y3c5MzE2LmxlZUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL3Vmcy9jb3JlL3Vmcy1tY3EuYyAgICAgIHwgMTAgKysrKysrKysrLQ0KPiAgZHJpdmVy
cy91ZnMvY29yZS91ZnNoY2QuYyAgICAgICB8ICA1ICstLS0tDQo+ICBkcml2ZXJzL3Vmcy9ob3N0
L3Vmcy1tZWRpYXRlay5jIHwgIDQgKy0tLQ0KPiAgaW5jbHVkZS91ZnMvdWZzaGNkLmggICAgICAg
ICAgICB8ICAxICsNCj4gIGluY2x1ZGUvdWZzL3Vmc2hjaS5oICAgICAgICAgICAgfCAgNCArKysr
DQo+ICA1IGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMvY29yZS91ZnMtbWNxLmMgYi9kcml2ZXJzL3Vm
cy9jb3JlL3Vmcy1tY3EuYw0KPiBpbmRleCAwNzg3NDU2YzJiODkuLmEzNGVmM2FhYzU0MCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy91ZnMvY29yZS91ZnMtbWNxLmMNCj4gKysrIGIvZHJpdmVycy91
ZnMvY29yZS91ZnMtbWNxLmMNCj4gQEAgLTM5NCwxMSArMzk0LDE5IEBADQo+IEVYUE9SVF9TWU1C
T0xfR1BMKHVmc2hjZF9tY3FfbWFrZV9xdWV1ZXNfb3BlcmF0aW9uYWwpOw0KPiAgDQo+ICB2b2lk
IHVmc2hjZF9tY3FfZW5hYmxlX2VzaShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiAgew0KPiAtdWZz
aGNkX3dyaXRlbChoYmEsIHVmc2hjZF9yZWFkbChoYmEsIFJFR19VRlNfTUVNX0NGRykgfCAweDIs
DQo+ICt1ZnNoY2Rfd3JpdGVsKGhiYSwgdWZzaGNkX3JlYWRsKGhiYSwgUkVHX1VGU19NRU1fQ0ZH
KSB8IEVTSV9FTkFCTEUsDQo+ICAgICAgICBSRUdfVUZTX01FTV9DRkcpOw0KPiAgfQ0KPiAgRVhQ
T1JUX1NZTUJPTF9HUEwodWZzaGNkX21jcV9lbmFibGVfZXNpKTsNCj4gIA0KPiArdm9pZCB1ZnNo
Y2RfbWNxX2VuYWJsZShzdHJ1Y3QgdWZzX2hiYSAqaGJhKQ0KPiArew0KPiArdWZzaGNkX3dyaXRl
bChoYmEsIHVmc2hjZF9yZWFkbChoYmEsIFJFR19VRlNfTUVNX0NGRykgfA0KPiBNQ1FfTU9ERV9T
RUxFQ1QsDQo+ICsgICAgICBSRUdfVUZTX01FTV9DRkcpOw0KPiAraGJhLT5tY3FfZW5hYmxlZCA9
IHRydWU7DQo+ICt9DQo+ICtFWFBPUlRfU1lNQk9MX0dQTCh1ZnNoY2RfbWNxX2VuYWJsZSk7DQo+
ICsNCj4gIHZvaWQgdWZzaGNkX21jcV9jb25maWdfZXNpKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHN0
cnVjdCBtc2lfbXNnICptc2cpDQo+ICB7DQo+ICB1ZnNoY2Rfd3JpdGVsKGhiYSwgbXNnLT5hZGRy
ZXNzX2xvLCBSRUdfVUZTX0VTSUxCQSk7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vmcy9jb3Jl
L3Vmc2hjZC5jIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiBpbmRleCBhZTk5MzZmYzZm
ZmIuLjgxOTVlMDFlN2EzZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91ZnMvY29yZS91ZnNoY2Qu
Yw0KPiArKysgYi9kcml2ZXJzL3Vmcy9jb3JlL3Vmc2hjZC5jDQo+IEBAIC04NzIzLDEwICs4NzIz
LDcgQEAgc3RhdGljIHZvaWQgdWZzaGNkX2NvbmZpZ19tY3Eoc3RydWN0IHVmc19oYmENCj4gKmhi
YSkNCj4gIGhiYS0+aG9zdC0+Y2FuX3F1ZXVlID0gaGJhLT5udXRycyAtIFVGU0hDRF9OVU1fUkVT
RVJWRUQ7DQo+ICBoYmEtPnJlc2VydmVkX3Nsb3QgPSBoYmEtPm51dHJzIC0gVUZTSENEX05VTV9S
RVNFUlZFRDsNCj4gIA0KPiAtLyogU2VsZWN0IE1DUSBtb2RlICovDQo+IC11ZnNoY2Rfd3JpdGVs
KGhiYSwgdWZzaGNkX3JlYWRsKGhiYSwgUkVHX1VGU19NRU1fQ0ZHKSB8IDB4MSwNCj4gLSAgICAg
IFJFR19VRlNfTUVNX0NGRyk7DQo+IC1oYmEtPm1jcV9lbmFibGVkID0gdHJ1ZTsNCj4gK3Vmc2hj
ZF9tY3FfZW5hYmxlKGhiYSk7DQo+ICANCj4gIGRldl9pbmZvKGhiYS0+ZGV2LCAiTUNRIGNvbmZp
Z3VyZWQsIG5yX3F1ZXVlcz0lZCwgaW9fcXVldWVzPSVkLA0KPiByZWFkX3F1ZXVlPSVkLCBwb2xs
X3F1ZXVlcz0lZCwgcXVldWVfZGVwdGg9JWRcbiIsDQo+ICAgaGJhLT5ucl9od19xdWV1ZXMsIGhi
YS0+bnJfcXVldWVzW0hDVFhfVFlQRV9ERUZBVUxUXSwNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dWZzL2hvc3QvdWZzLW1lZGlhdGVrLmMgYi9kcml2ZXJzL3Vmcy9ob3N0L3Vmcy0NCj4gbWVkaWF0
ZWsuYw0KPiBpbmRleCBmYzYxNzkwZDI4OWIuLjEwNDhhZGQ2NjQxOSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91ZnMvaG9zdC91ZnMtbWVkaWF0ZWsuYw0KPiArKysgYi9kcml2ZXJzL3Vmcy9ob3N0
L3Vmcy1tZWRpYXRlay5jDQo+IEBAIC0xMjE5LDkgKzEyMTksNyBAQCBzdGF0aWMgaW50IHVmc19t
dGtfbGlua19zZXRfaHBtKHN0cnVjdCB1ZnNfaGJhDQo+ICpoYmEpDQo+ICB1ZnNfbXRrX2NvbmZp
Z19tY3EoaGJhLCBmYWxzZSk7DQo+ICB1ZnNoY2RfbWNxX21ha2VfcXVldWVzX29wZXJhdGlvbmFs
KGhiYSk7DQo+ICB1ZnNoY2RfbWNxX2NvbmZpZ19tYWMoaGJhLCBoYmEtPm51dHJzKTsNCj4gLS8q
IEVuYWJsZSBNQ1EgbW9kZSAqLw0KPiAtdWZzaGNkX3dyaXRlbChoYmEsIHVmc2hjZF9yZWFkbCho
YmEsIFJFR19VRlNfTUVNX0NGRykgfCAweDEsDQo+IC0gICAgICBSRUdfVUZTX01FTV9DRkcpOw0K
PiArdWZzaGNkX21jcV9lbmFibGUoaGJhKTsNCg0KSGkgQ2hhbndvbywNCg0KSXQgaXMgYmV0dGVy
IGNoYW5nZSAweDEgdG8gTUNRX01PREVfU0VMRUNUIG9ubHkuDQpBbmQgZG8gbm90IGNoYW5nZSBo
YmEtPm1jcV9lbmFibGVkIHZhbHVlIGJlY2F1c2Ugd2UgZW5hYmxlIG1jcSANCmJ5IGNoZWNrIGhi
YS0+bWNxX2VuYWJsZWQgaXMgdHJ1ZS4NCg0KVGhhbmtzLg0KUGV0ZXINCg0KDQoNCj4gIH0NCj4g
IA0KPiAgaWYgKGVycikNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWZzL3Vmc2hjZC5oIGIvaW5j
bHVkZS91ZnMvdWZzaGNkLmgNCj4gaW5kZXggZDg2MmM4ZGRjZTAzLi5hOTZjNDVmYTRiNGIgMTAw
NjQ0DQo+IC0tLSBhL2luY2x1ZGUvdWZzL3Vmc2hjZC5oDQo+ICsrKyBiL2luY2x1ZGUvdWZzL3Vm
c2hjZC5oDQo+IEBAIC0xMjU3LDYgKzEyNTcsNyBAQCB1bnNpZ25lZCBsb25nIHVmc2hjZF9tY3Ff
cG9sbF9jcWVfbG9jayhzdHJ1Y3QNCj4gdWZzX2hiYSAqaGJhLA0KPiAgIHN0cnVjdCB1ZnNfaHdf
cXVldWUgKmh3cSk7DQo+ICB2b2lkIHVmc2hjZF9tY3FfbWFrZV9xdWV1ZXNfb3BlcmF0aW9uYWwo
c3RydWN0IHVmc19oYmEgKmhiYSk7DQo+ICB2b2lkIHVmc2hjZF9tY3FfZW5hYmxlX2VzaShzdHJ1
Y3QgdWZzX2hiYSAqaGJhKTsNCj4gK3ZvaWQgdWZzaGNkX21jcV9lbmFibGUoc3RydWN0IHVmc19o
YmEgKmhiYSk7DQo+ICB2b2lkIHVmc2hjZF9tY3FfY29uZmlnX2VzaShzdHJ1Y3QgdWZzX2hiYSAq
aGJhLCBzdHJ1Y3QgbXNpX21zZw0KPiAqbXNnKTsNCj4gIA0KPiAgaW50IHVmc2hjZF9vcHBfY29u
ZmlnX2Nsa3Moc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgb3BwX3RhYmxlDQo+ICpvcHBfdGFi
bGUsDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Vmcy91ZnNoY2kuaCBiL2luY2x1ZGUvdWZzL3Vm
c2hjaS5oDQo+IGluZGV4IGQ1YWNjYWNhZTZiYy4uZTY2OWZhZDExZmQ0IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL3Vmcy91ZnNoY2kuaA0KPiArKysgYi9pbmNsdWRlL3Vmcy91ZnNoY2kuaA0KPiBA
QCAtMjgyLDYgKzI4MiwxMCBAQCBlbnVtIHsNCj4gIC8qIFVUTVJMUlNSIC0gVVRQIFRhc2sgTWFu
YWdlbWVudCBSZXF1ZXN0IFJ1bi1TdG9wIFJlZ2lzdGVyIDgwaCAqLw0KPiAgI2RlZmluZSBVVFBf
VEFTS19SRVFfTElTVF9SVU5fU1RPUF9CSVQweDENCj4gIA0KPiArLyogUkVHX1VGU19NRU1fQ0ZH
IC0gR2xvYmFsIENvbmZpZyBSZWdpc3RlcnMgMzAwaCAqLw0KPiArI2RlZmluZSBNQ1FfTU9ERV9T
RUxFQ1QgMHgxDQo+ICsjZGVmaW5lIEVTSV9FTkFCTEUweDINCj4gKw0KPiAgLyogQ1FJU3kgLSBD
USB5IEludGVycnVwdCBTdGF0dXMgUmVnaXN0ZXIgICovDQo+ICAjZGVmaW5lIFVGU0hDRF9NQ1Ff
Q1FJU19UQUlMX0VOVF9QVVNIX1NUUzB4MQ0KPiAgDQo+IC0tIA0KPiAyLjI5LjANCj4gDQo=

