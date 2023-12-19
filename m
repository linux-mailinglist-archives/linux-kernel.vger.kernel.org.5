Return-Path: <linux-kernel+bounces-4607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D4B817FDF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C52341C216C5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF9C135;
	Tue, 19 Dec 2023 02:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XrRvVacG";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TaN/vZgr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABD8C120
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b673d449e1711eeba30773df0976c77-20231219
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Q1Rwp7zRyx46+iayWKDfpJ4ryKXqJkyU3kCLiULY+DU=;
	b=XrRvVacGq7dQHSbRGuQ6eGirpgLr84HZk6jQukR0Ci3kCSWJXFnsP164GvFT9tIGMwQhjXlAmj7MtP2JCaZf+harJD8ANtUh9uL+CZFZX31s6fnM7INw/0wyPvslEBE+OcPeW1jzXpCvUXM3ouj1vRb8p2+KKO3tU79ONw4SshU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c1480f46-fe83-405d-a5a1-09edaa883369,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:57d3d2fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 7b673d449e1711eeba30773df0976c77-20231219
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1488721760; Tue, 19 Dec 2023 10:36:58 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 19 Dec 2023 10:36:57 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 19 Dec 2023 10:36:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hU7LioPAYH29nWw6u2Rqvh1xGmtc5jsiUQBWOX0RCehK7ar4kowE0xdgJ9rfoX8WprK1K/+KEkp+0YkoHbjjr4BwD4gylbwKuDdfe0JJtXfxX2lWOOuQGa/Lnu7SwdyKvcu1kraNYai4HviEKOQFP3QnXaFUtMFoOFmI6Krew40y/zs4MbKn0Z8ymDmngq+f2nLJxP0cPM1AABaPuaiJJz7pGAJ6oNh5NNyjEiOigzTtDkxxhXQ4R9A+DRoak43ssy/eGW+Wo1xLy8+qcnKLSYLmwpHQmf3ckKclXa4LDAg71Wy5ioTAw+6TGW0RlXXLHXwYgCVDU2wwyIGkRiQMZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1Rwp7zRyx46+iayWKDfpJ4ryKXqJkyU3kCLiULY+DU=;
 b=QT8Sr3ackvZpGmktWykCHd1SsMz8JpPus6iVIeOGE+mWJMuSkC93/8DgCW+t4MwYbUJw82CHy40hNGqbiFQS2oKrPo/18iTwr8kXpdHTb49m1mbNFbVnPdFVZ1lWZRFafpGUSgNm4xHe4AuHfob7rBh5g2bAjXlTB1lT/MYk35qfxjuo0DcIzbf0r2w/Zs9EzFAbx9E3pzkQ2WEWTa3kQdxzK+S0O98ZqLDzUAvWWEQcLUU5xhrn5RrEG8+78l1SYeCPQU6+bLFzEGHeqoFbSGI0DyFVsbmwTr3aE4Tmlh1sOE5/L3R/BG3ncDHR2NiGz7BuWz9ssdTuKBzABVBN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1Rwp7zRyx46+iayWKDfpJ4ryKXqJkyU3kCLiULY+DU=;
 b=TaN/vZgrQ23eLYqhFiSEEtWPtHy95i9TTLPvx6SP6XnWynjtuxzPzJcLAQDq6yqaLFunuxCiIZ5nsdaTueciH+D0CTITaBjV9i8cSYJdFvz1c6yoUanOw5QqFTpibN25WWHhqfrMANbtHJZJuLC2pqP0h/OSG2P68SSnDcqgCko=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7076.apcprd03.prod.outlook.com (2603:1096:101:ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 02:35:44 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 02:35:44 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= <Shawn.Sung@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHaHr0goJD71O1xFUyzMlTImg6vtrCwCqWA
Date: Tue, 19 Dec 2023 02:35:43 +0000
Message-ID: <0eb813192c02ac6f8d05fe9f4fc805517f5cb97b.camel@mediatek.com>
References: <20231124100052.18599-1-shawn.sung@mediatek.com>
	 <20231124100052.18599-2-shawn.sung@mediatek.com>
In-Reply-To: <20231124100052.18599-2-shawn.sung@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7076:EE_
x-ms-office365-filtering-correlation-id: 262bd349-1674-4152-efd2-08dc003b3317
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HneYLSCBlND9wp2xm3Fd4IXmxuadZVzpAPL+RZ7/EhFxauCEjdGpurPQLDdVJJt3A08OMUJnZr9U07MjbrkSRE2TSDBrdazZesWe1JtgurBPRyTgDMSLibTz0OI++PkgcinFr+xE65erE+4/2t3W5ap4gCUyjn65Mb/l8ZfE7PcpvfaK4I49UtT/A6mMeW7hjN41QehZ+Vt1l4ScQyRrKDkpsveyYrr2I7WRAP5fJASECQaYaDMO2NdFCXxG5UgcGm8CkEzbXQKqD36aSlUwLcNRjTJyNNdsCZMQsK5hIhUljExmcg/LmtgJYkmU1D1nkn+ldu8tI2EBuQIaCf6sQ7A8kCsUoHAiQO4uipWGHRQB90KMjlyWciUYx1SgYYqspSP071cfGGGKbnEk1xHwOsxSB9imoxiGqiC+Jnsr+lW1qooyh5XqFZWCA8uGUAWwDzay7jK3piQ2bWsowdPDd+fZNPajrFSgajy97ED2ajN+CqPXWpvIdvin6Kx3S9OBB+ufyPxJ+PrPMrWlIVUyDkMNDla+2SmObp28Zcf4988iexjUNmlStZvdfHld4gG214X143cgkN1EbVs5VsqPImYLIu+Fsui1ux0iDG/E9j6sIZL/o8LZe3+Ozdyimfn5EzVHsS2ekhs8QI5SPc9sLw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4326008)(8936002)(8676002)(38070700009)(83380400001)(64756008)(66446008)(76116006)(66556008)(66946007)(66476007)(54906003)(316002)(85182001)(36756003)(4001150100001)(38100700002)(86362001)(122000001)(2906002)(41300700001)(7416002)(5660300002)(26005)(478600001)(2616005)(6486002)(966005)(6506007)(6512007)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXhzbU1hRHhMZWlkV2dJaDRZUjNVV1pHTXZuZHZ3QzBpcUMwb3JRQllWa0pq?=
 =?utf-8?B?R1EwTUc4cWMwS2U0c1U5M3R4WTZScllEZnlPbnduYTNjdmlsUHZ0TG95MCtQ?=
 =?utf-8?B?RHVZWU1DS1IzaXlNU3RBdmRQbFVKc2lkMmVKcDh3SlpCK1FYTGVSUjdySllI?=
 =?utf-8?B?a3hNSEIyWTRaRTg1bkxRejF5UExGM2QrQWliMzJiTVhFR0NwWGtUYmQ0WHpM?=
 =?utf-8?B?bTBGV29WSjRoQklKV1BOYmFKbUNHdFNVVXhGUTlocm9BYlp3ZEdVS2F3MU5E?=
 =?utf-8?B?M05DM2E0TGZndUF4ZzBFTWxPcklUVTVtUEZvdlUxQnd5dlNMdk04RGFPRXpr?=
 =?utf-8?B?TDBiNGNLR1Y4akZmNERwYnZhQ2tTcTJFNmNoOElETlRvZm1pWmx2U0V6UEF5?=
 =?utf-8?B?dU9SazNuUFZWaVVZV2VJQU1pTzhSdURiWm83ajJxTnp1TVZvR3pzdndtWDRr?=
 =?utf-8?B?QVZiVzZpMTNUR084Ym1WL202QllpTFZIRFcvMDYrRDNzV25va2wrdUx2N2JH?=
 =?utf-8?B?anI3UlRXQ28vWjJDNHBMbWF2SmNtQTRreGgvQklxay85Y0NxZkVwZUZYaVlO?=
 =?utf-8?B?YjZ5cFZuMmFiQW5ldyt4UDZzS1hiRVVuYnZKY0piOG14ckMzclpob0ZqOXlO?=
 =?utf-8?B?bkdIblFGY2wxU0F6eFd2ZXc3SWhYTE5wdXVQSU9HRlhuYXlNb05uWVlwS2hv?=
 =?utf-8?B?WUwrUnBSSkdBK0dlWXp6em1YV2pCekczQzVVZ1FLeUJUSG1OMVcrRUhDY0Zk?=
 =?utf-8?B?eEhaYW5SY1BiYmZSbjVPQVdTaUJaelhpZTdsaVJHQmNyVHpEekVvYmw2Wkwz?=
 =?utf-8?B?YUFmdVJiM1VXL3NleHVmZ3IwTG4va3dQUFFwVC9KRkcvSVhLdlhwa01Fd095?=
 =?utf-8?B?OTRFdnVxM0lYUkJTWUgzUzhVOGJDNzZEaFJldU40NWpDQ2ltMFJpV1hNcmpx?=
 =?utf-8?B?S3B6eHJzb0hxWG02UHZJNmZtNzl3OXVvNS9NMGh1OWcraGhJd1FVVHRzeDRr?=
 =?utf-8?B?bGh6dUNycFpWOGY5SGJIclhkUFdCTVRWZUxYY2l4QVlUMkNYZjU3clJya3Nz?=
 =?utf-8?B?SU1TMzNWN3hudTZVZUprUGVkMnZLSjdDNE9xTWRJVEdRMWNWUUQvcXYrRldl?=
 =?utf-8?B?K0s0RlNPdHNJTzJLUE9uK3FTZjNxY2tVTXpob1ROejNhQWdOT3FBTkhCQ2FN?=
 =?utf-8?B?Mmo0S0RZOWlqd3Nua0RPTWM2VDAzanBOc0tlU1JtalpnaXg0ejY2YUZZTW9q?=
 =?utf-8?B?SFRmNFl3VGhSMGxsV0FZUUlyVGFCR2c2clVRSDVvcEhDTjl6MnNOMEN4d1Fp?=
 =?utf-8?B?TnRPVmdjdmkza3RmbkVlaE8zZ0VhdUVPckdTNlVxUEZ5UDdMY0pnK3phK1R4?=
 =?utf-8?B?YW51NmVVK1NDTmtjVTVWalREbVFGdkhNZDZqMStWU3pnTE1KY29DVkZjUFN1?=
 =?utf-8?B?TTFIb0o4UU9TNURuMm1OL0VBNWJNVElFNDNaVUwwSDBuMjI4ZDYzNGlhQ2Iy?=
 =?utf-8?B?SmNtSUxaL1lpN2hwWm4rTmkzcTA2ODNKM2JkUWE5MjB2YUh6WlVYVWQ0R3hy?=
 =?utf-8?B?UHpIZkxuOWpiRUhmWFhHS1l2SDB3cmpXU0pjbk1OTDlCS0hiOFQwcU83R092?=
 =?utf-8?B?Y2Vmdk1oZVZvUmZ5ajNOOTN5VkJaTVMzUW5FdGVNaGxqOVhFYUR5cVFrdHZS?=
 =?utf-8?B?cys1L0ZCTzhXc1Jray84QmZkd0wxSzBoaVgwblFTa2VlSElQbHJSRWd4R3Z3?=
 =?utf-8?B?UUZmV2JTZFkzb2VTS0xpYVBlMzE0bis3Y0dTN2VkZ3hYZzhUTTlpVWo5T2kx?=
 =?utf-8?B?U0hSTnd0T0dPOXFaakVvOFZwakVtanVEc3lNRVRDb0haeFRGTUlsNVFkMXJI?=
 =?utf-8?B?dG95K0hoN294eEd3NlI1bE5wYkJtNGxLQ2FGQUZIVEZPYVh4b2NiWVA2QUNF?=
 =?utf-8?B?VW1sLzdHVFVhRUNCZ29TMVdPWEQwTWZzWmxyY0xCek81eFo2V3N1Y0Q5N096?=
 =?utf-8?B?UUtDMWM4c1A3OUxXOTlyWG5qdUFqcDBwdTNQd2QxTE10YXZGcWdCNXFFcm14?=
 =?utf-8?B?c0NSRGRGY2VUaGlDUmpydGIxY0JsbDUzdXZhVURVUk4wSm03QUUxekpJY0VU?=
 =?utf-8?Q?IoOT/C+qcsFmO8Z7qxf/8noRb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4511A9300AAEF4AA71CC32A2D161E8E@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 262bd349-1674-4152-efd2-08dc003b3317
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2023 02:35:43.9623
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: faPpbndX0CT/JBzK/fOwciO5f2JAvFkj7BndE+A/B49gyKC7wF3x0I3/UbRDldfsO7o2nbM0t3xnausuBDBiJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7076

SGksIEhzaWFvLWNoaWVuOg0KDQpPbiBGcmksIDIwMjMtMTEtMjQgYXQgMTg6MDAgKzA4MDAsIEhz
aWFvIENoaWVuIFN1bmcgd3JvdGU6DQo+IENyZWF0ZSByb3RhdGlvbiBwcm9wZXJ0eSBhY2NvcmRp
bmcgdG8gdGhlIGhhcmR3YXJlIGNhcGFiaWxpdHkuDQo+IFNpbmNlIGN1cnJlbnRseSBPVkwgb2Yg
YWxsIGNoaXBzIHN1cHBvcnQgc2FtZSByb3RhdGlvbiwNCj4gbm8gbmVlZCB0byBkZWZpbmUgaXQg
aW4gdGhlIGRyaXZlciBkYXRhLg0KPiANCj4gRml4ZXM6IDg0ZDgwNTc1Mzk4MyAoImRybS9tZWRp
YXRlazogU3VwcG9ydCByZWZsZWN0LXkgcGxhbmUNCj4gcm90YXRpb24iKQ0KPiANCj4gUmV2aWV3
ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5k
ZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBIc2lhbyBDaGllbiBTdW5n
IDxzaGF3bi5zdW5nQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2Rpc3BfZHJ2LmggICAgICAgIHwgIDEgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX292bC5jICAgICAgICB8IDE4ICsrKysrKy0tLS0tLS0tDQo+IC0tLS0N
Cj4gIC4uLi9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMgICAgfCAgOSAr
KysrKysrKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMg
ICAgfCAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jICAg
ICAgIHwgIDIgKy0NCj4gIDUgZmlsZXMgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210
a19kaXNwX2Rydi5oDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5o
DQo+IGluZGV4IDRkNmU4YjY2N2JjMy4uYzVhZmViN2M1NTI3IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3BfZHJ2LmgNCj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oDQo+IEBAIC0xMjcsNiArMTI3LDcgQEAgdm9pZCBt
dGtfb3ZsX2FkYXB0b3JfcmVnaXN0ZXJfdmJsYW5rX2NiKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwg
dm9pZCAoKnZibGFua19jYikodm8NCj4gIHZvaWQgbXRrX292bF9hZGFwdG9yX3VucmVnaXN0ZXJf
dmJsYW5rX2NiKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9l
bmFibGVfdmJsYW5rKHN0cnVjdCBkZXZpY2UgKmRldik7DQo+ICB2b2lkIG10a19vdmxfYWRhcHRv
cl9kaXNhYmxlX3ZibGFuayhzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiArdW5zaWduZWQgaW50IG10
a19vdmxfYWRhcHRvcl9zdXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBkZXZpY2UNCj4gKmRldik7
DQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl9zdGFydChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAg
dm9pZCBtdGtfb3ZsX2FkYXB0b3Jfc3RvcChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiAgdW5zaWdu
ZWQgaW50IG10a19vdmxfYWRhcHRvcl9sYXllcl9ucihzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGIv
ZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX292bC5jDQo+IGluZGV4IGVjYzM4OTMy
ZmQ0NC4uMzE5YmJmZGU1Y2Y5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2Rpc3Bfb3ZsLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
aXNwX292bC5jDQo+IEBAIC00MTUsNiArNDE1LDEwIEBAIHVuc2lnbmVkIGludCBtdGtfb3ZsX2xh
eWVyX25yKHN0cnVjdCBkZXZpY2UNCj4gKmRldikNCj4gDQo+ICB1bnNpZ25lZCBpbnQgbXRrX292
bF9zdXBwb3J0ZWRfcm90YXRpb25zKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gKwkvKg0K
PiArCSAqIGFsdGhvdWdoIGN1cnJlbnRseSBPVkwgY2FuIG9ubHkgZG8gcmVmbGVjdGlvbiwNCj4g
KwkgKiByZWZsZWN0IHggKyByZWZsZWN0IHkgPSByb3RhdGUgMTgwDQo+ICsJICovDQo+ICAJcmV0
dXJuIERSTV9NT0RFX1JPVEFURV8wIHwgRFJNX01PREVfUk9UQVRFXzE4MCB8DQo+ICAJICAgICAg
IERSTV9NT0RFX1JFRkxFQ1RfWCB8IERSTV9NT0RFX1JFRkxFQ1RfWTsNCj4gIH0NCj4gQEAgLTQy
MywyNyArNDI3LDE3IEBAIGludCBtdGtfb3ZsX2xheWVyX2NoZWNrKHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4gdW5zaWduZWQgaW50IGlkeCwNCj4gIAkJCXN0cnVjdCBtdGtfcGxhbmVfc3RhdGUgKm10
a19zdGF0ZSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHJtX3BsYW5lX3N0YXRlICpzdGF0ZSA9ICZtdGtf
c3RhdGUtPmJhc2U7DQo+IC0JdW5zaWduZWQgaW50IHJvdGF0aW9uID0gMDsNCj4gDQo+IC0Jcm90
YXRpb24gPSBkcm1fcm90YXRpb25fc2ltcGxpZnkoc3RhdGUtPnJvdGF0aW9uLA0KPiAtCQkJCQkg
RFJNX01PREVfUk9UQVRFXzAgfA0KPiAtCQkJCQkgRFJNX01PREVfUkVGTEVDVF9YIHwNCj4gLQkJ
CQkJIERSTV9NT0RFX1JFRkxFQ1RfWSk7DQo+IC0Jcm90YXRpb24gJj0gfkRSTV9NT0RFX1JPVEFU
RV8wOw0KPiAtDQo+IC0JLyogV2UgY2FuIG9ubHkgZG8gcmVmbGVjdGlvbiwgbm90IHJvdGF0aW9u
ICovDQo+IC0JaWYgKChyb3RhdGlvbiAmIERSTV9NT0RFX1JPVEFURV9NQVNLKSAhPSAwKQ0KPiAr
CWlmIChzdGF0ZS0+cm90YXRpb24gJiB+bXRrX292bF9zdXBwb3J0ZWRfcm90YXRpb25zKGRldikp
DQo+ICAJCXJldHVybiAtRUlOVkFMOw0KDQpUaGUgY29tbWl0IG1lc3NhZ2Ugb2YgdGhpcyBwYXRj
aCBpcyAiQ3JlYXRlIHJvdGF0aW9uIHByb3BlcnR5IGFjY29yZGluZw0KdG8gdGhlIGhhcmR3YXJl
IGNhcGFiaWxpdHkiLiBJIHRoaW5rIHRoaXMgbW9kaWZpY2F0aW9uIGlzIG5vdCByZWxhdGVkDQp0
byBjcmVhdGUgcHJvcGVydHksIHNvIHNlcGFyYXRlIHRoaXMgdG8gYW5vdGhlciBwYXRjaC4NCg0K
PiANCj4gIAkvKg0KPiAgCSAqIFRPRE86IFJvdGF0aW5nL3JlZmxlY3RpbmcgWVVWIGJ1ZmZlcnMg
aXMgbm90IHN1cHBvcnRlZCBhdA0KPiB0aGlzIHRpbWUuDQo+ICAJICoJIE9ubHkgUkdCW0FYXSB2
YXJpYW50cyBhcmUgc3VwcG9ydGVkLg0KPiAgCSAqLw0KPiAtCWlmIChzdGF0ZS0+ZmItPmZvcm1h
dC0+aXNfeXV2ICYmIHJvdGF0aW9uICE9IDApDQo+ICsJaWYgKHN0YXRlLT5mYi0+Zm9ybWF0LT5p
c195dXYgJiYgKHN0YXRlLT5yb3RhdGlvbiAmDQo+IH5EUk1fTU9ERV9ST1RBVEVfMCkpDQo+ICAJ
CXJldHVybiAtRUlOVkFMOw0KPiANCj4gLQlzdGF0ZS0+cm90YXRpb24gPSByb3RhdGlvbjsNCj4g
LQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9tZWRpYXRlay9tdGtfZGlzcF9vdmxfYWRhcHRvci5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19kaXNwX292bF9hZGFwdG9yLmMNCj4gaW5kZXggNDM5OGRiOWE2Mjc2Li4yNzNj
NzlkMzdiZWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdmxfYWRhcHRvci5jDQo+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlz
cF9vdmxfYWRhcHRvci5jDQo+IEBAIC0zODMsNiArMzgzLDE1IEBAIHZvaWQgbXRrX292bF9hZGFw
dG9yX3JlZ2lzdGVyX3ZibGFua19jYihzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsIHZvaWQgKCp2Ymxh
bmtfY2IpKHZvDQo+ICAJCQkJICAgICB2YmxhbmtfY2IsIHZibGFua19jYl9kYXRhKTsNCj4gIH0N
Cj4gDQo+ICt1bnNpZ25lZCBpbnQgbXRrX292bF9hZGFwdG9yX3N1cHBvcnRlZF9yb3RhdGlvbnMo
c3RydWN0IGRldmljZSAqZGV2KQ0KPiArew0KPiArCS8qDQo+ICsJICogc2hvdWxkIHN0aWxsIHJl
dHVybiBEUk1fTU9ERV9ST1RBVEVfMCBpZiByb3RhdGlvbiBpcyBub3QNCj4gc3VwcG9ydGVkLA0K
PiArCSAqIG9yIElHVCB3aWxsIGZhaWwuDQo+ICsJICovDQo+ICsJcmV0dXJuIERSTV9NT0RFX1JP
VEFURV8wOw0KPiArfQ0KPiArDQo+ICB2b2lkIG10a19vdmxfYWRhcHRvcl91bnJlZ2lzdGVyX3Zi
bGFua19jYihzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ICB7DQo+ICAJc3RydWN0IG10a19kaXNwX292
bF9hZGFwdG9yICpvdmxfYWRhcHRvciA9DQo+IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBi
L2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gaW5kZXggZmZh
NDg2OGIxMjIyLi4yMDZkZDZmNmY5OWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfZHJtX2RkcF9jb21wLmMNCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fZGRwX2NvbXAuYw0KPiBAQCAtNDIyLDYgKzQyMiw3IEBAIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgbXRrX2RkcF9jb21wX2Z1bmNzDQo+IGRkcF9vdmxfYWRhcHRvciA9IHsNCj4gIAku
cmVtb3ZlID0gbXRrX292bF9hZGFwdG9yX3JlbW92ZV9jb21wLA0KPiAgCS5nZXRfZm9ybWF0cyA9
IG10a19vdmxfYWRhcHRvcl9nZXRfZm9ybWF0cywNCj4gIAkuZ2V0X251bV9mb3JtYXRzID0gbXRr
X292bF9hZGFwdG9yX2dldF9udW1fZm9ybWF0cywNCj4gKwkuc3VwcG9ydGVkX3JvdGF0aW9ucyA9
IG10a19vdmxfYWRhcHRvcl9zdXBwb3J0ZWRfcm90YXRpb25zLA0KPiAgfTsNCj4gDQo+ICBzdGF0
aWMgY29uc3QgY2hhciAqIGNvbnN0IG10a19kZHBfY29tcF9zdGVtW01US19ERFBfQ09NUF9UWVBF
X01BWF0gPQ0KPiB7DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRr
X2RybV9wbGFuZS5jDQo+IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUu
Yw0KPiBpbmRleCBlMmVjNjFiNjk2MTguLjg5NGMzOWEzOGE1OCAxMDA2NDQNCj4gLS0tIGEvZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcm1fcGxhbmUuYw0KPiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9wbGFuZS5jDQo+IEBAIC0zNDQsNyArMzQ0LDcgQEAgaW50
IG10a19wbGFuZV9pbml0KHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsIHN0cnVjdA0KPiBkcm1fcGxh
bmUgKnBsYW5lLA0KPiAgCQlyZXR1cm4gZXJyOw0KPiAgCX0NCj4gDQo+IC0JaWYgKHN1cHBvcnRl
ZF9yb3RhdGlvbnMgJiB+RFJNX01PREVfUk9UQVRFXzApIHsNCj4gKwlpZiAoc3VwcG9ydGVkX3Jv
dGF0aW9ucykgew0KDQpXaHkgbmVlZCB0aGlzIG1vZGlmaWNhdGlvbj8NCkJlZm9yZSBTZWFuJ3Mg
cGF0Y2ggWzFdLCBvbmx5IHN1cHBvcnQgcm90YXRlIDAgYW5kIGRvZXMgbm90IGNyZWF0ZQ0KcHJv
cGVydHkgYW5kIGl0IHdvcmtzLiBXaHkgZG9lcyBpdCBtdXN0IGNyZWF0ZSBwcm9wZXJ0eSBmb3Ig
b25seQ0Kc3VwcG9ydCByb3RhdGUgMD8NCg0KDQpbMV0gDQpodHRwczovL2dpdC5rZXJuZWwub3Jn
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0L2RyaXZl
cnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX3BsYW5lLmM/aD12Ni43LXJjNiZpZD1lZjg3ZDNl
MmRkMjUxMzc0YzVjOWZhM2I2NTAyYWVmZjhmZTI5ZGE5DQoNClJlZ2FyZHMsDQpDSw0KDQo+ICAJ
CWVyciA9IGRybV9wbGFuZV9jcmVhdGVfcm90YXRpb25fcHJvcGVydHkocGxhbmUsDQo+ICAJCQkJ
CQkJIERSTV9NT0RFX1JPVEFUDQo+IEVfMCwNCj4gIAkJCQkJCQkgc3VwcG9ydGVkX3JvdGENCj4g
dGlvbnMpOw0KPiAtLQ0KPiAyLjM5LjINCj4gDQo=

