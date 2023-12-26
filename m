Return-Path: <linux-kernel+bounces-11424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205CD81E611
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90233B21DF3
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAEC4CE14;
	Tue, 26 Dec 2023 08:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="QswsXSw9";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="oFBeInZ+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E54CB58;
	Tue, 26 Dec 2023 08:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: fe02400ea3cc11eea5db2bebc7c28f94-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=j6ZqMXAzo/hn6Nx6P+QNs7O4911FhhoRJoFR2OHUE40=;
	b=QswsXSw9RGAqOaOK5BEuymzjVIug+uEA0sylgC5VBLiZ4x08pJhMu/LzdvTs80D6JGNPsNHat3O9I/C1gQzjBl4DreQE+PIG2aD0I8ZzKiGnleLg+jG+4jivIYByD0BwuixAWVlcmgC/46a9RP0+6kI51qZfdoNGD6HhINtS3ww=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:f399fc25-551b-4810-a75f-5e8faf81d95a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:82fa948d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: fe02400ea3cc11eea5db2bebc7c28f94-20231226
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 454935130; Tue, 26 Dec 2023 16:58:52 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 16:58:50 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 16:58:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFtGMW2Qdv3MuIbjQLbqb5UdXLC8oc2iXwfwF9xCXT3GBekKG7gUa1tCCwgSKAVNK/73CFaLGZF97H1knF5CDIRrOBER+Wb7xwk4ZuC9B0LdlQJK2Ssg5w0DakUX5MzCLqxr7kYxsMwlUdiZIVIdNJICY3HzLeh+Y1LXM+LEn+P9ZRToK4NAAEW5U4o7AophVzoBNFo+osvotFGMlH6X3tjsgmQXL8SsdJZrfkgczVI/yaAsVZY3KtxmbHQQkxW1ANyGqFcWTzpnsQesBnq9KgsHBKKGXUOyF7HActKD0yacDd9p46VC9sHXzIf2BG1toVIshNYhiWMI0BxrVwPbfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j6ZqMXAzo/hn6Nx6P+QNs7O4911FhhoRJoFR2OHUE40=;
 b=AQMbHP+CnOS0LOV5+X9J1yUcTB2dHDsp+d7bqghaw2O4jksP0/rjIKXJbNqaqzawVGcp5KqTVS1IMc59BT/adhHL5JYdcJU8SRFFbeuLC50AGsXzgkB1AUEpZheyqfapr/YuH56GTXTzt+OBIDTt5d3PrlP0t04VbrJgG3lkGLVn0rrhyEjaRXR9gx0DsYJyFqYQM9ZQMj/go3JXqgdHn/+He9qASaXloBrGJm93zB1KV511yLYJAMq8fryJ5yh91/yDoThnBgMdoskACrinFj4Fazumlm4+0xlr8gr+EYlv++mqCad0VvxZN+UANs3QngaHx1apceRGeTPbC7l7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6ZqMXAzo/hn6Nx6P+QNs7O4911FhhoRJoFR2OHUE40=;
 b=oFBeInZ+f4F/ep38ws89/gR9fyJAlxAEwgtCL8269qt8S6h7gyyvaPr1siDqH7NVujzmKNUT/gzq++FjJv11zTEUgQT0wl7pNyzW0NlwS3UNhEpOP3vLvupuTu/7DViOUS0me5J1PAK1yarpmqkUFI3t+IROQW2MItmasZzxoOA=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SEZPR03MB7753.apcprd03.prod.outlook.com (2603:1096:101:128::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 08:58:45 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 08:58:45 +0000
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C7Sk8A
Date: Tue, 26 Dec 2023 08:58:45 +0000
Message-ID: <f338215fb8f7ff1e0ebeb0f1e21a8b4dec5f0c61.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SEZPR03MB7753:EE_
x-ms-office365-filtering-correlation-id: 2b4262ec-e764-458a-f952-08dc05f0de03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xB8Tar5ld/6zal3e4+2u3NZA2H/b/nyqiVS0Dyfmnbu5Plv1tbu00ySdAVJJ2OcDMc7C1pVWbeKqy56iTIlxa0QP+baEiKOBhaQEMyFFR8xdBuWa63et/sNsN4sWtW2gaQoTxFmSriNVbviwL1u4wwPmvJlpO9emF2xgMPh1BMpdjvjeFPUx/0G69c1ZkRY8FOL590AB9wqo8yf5NFkTIf84bgWnAYOq9ytpbWUIwZXxGHRQNGn2sgUDQaObxq91KftaFeqLqhgEhzO6S8MantprNi7rGVbY3vKeoeaKeOI9zGb9I8+kWRm3qHKgAjegN98mYi81Sp+GwB/ePqiiGds4CmFEE3icGi2yRPzWv6Lauyz0uijxSyPWo6V0M4kGyMovhyaPSSStIgz7avApu4TJH3sq/T2lx8JRbNh1Ioct1DuKtSUuxspASMpm0cAad/ZAmW4uxe2uXjuhu9gJQdg/u7e2Altn/wRb0YbmTry1WTeSgFuXPhSmOrJKSHQ1GZI3MRocTEy7WlsPqy1gtWreAtqf8iNSc5/0xiOaF+A5/oAkN2KPNyFYigB6WwgNQ/reRkuKHAxlWDrGIDf3cAaWY6AIyqt1+dFvFIQ85/CN0+i+SJ10brDA9x3MrzWhpglkPk+KwzNHqA7Sk0XcXiW+VIoyU18Ryv/ZkTUJzzo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(36756003)(85182001)(71200400001)(6512007)(6506007)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(6486002)(86362001)(38070700009)(26005)(38100700002)(122000001)(83380400001)(2616005)(41300700001)(2906002)(15650500001)(5660300002)(4001150100001)(8936002)(7416002)(8676002)(478600001)(316002)(54906003)(110136005)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M0grYk5rMTdTQS9DTGZMK1h5eUt4djNxV09NZXJNTm5GU3VwR2tyOUVzSWRW?=
 =?utf-8?B?SWpEM242eUlZVmNtQWpKcUhrbHlKUmhFVW5DKzZDQm5sdXZleTdtWXNMODdX?=
 =?utf-8?B?Z1l1cU1JaEFwRDd4eDVyRTJrd3libjRZcnhybGRWcGZjNWU4Rms5dXR3Qzdw?=
 =?utf-8?B?VUlBU0QzTHArV0tGLzVodklMYUp2eWZEQzIrR2pxOFNVeVdvQWhkQmFqSUY0?=
 =?utf-8?B?aHE2dnU5WjJqOHNrREltUkRlZStEQU9wdm5kN1hpaDRFa0ZFNU1vaHppZFlm?=
 =?utf-8?B?Rkl6TGJqTUNJSTkrbStscjBGUCtmTytObFZZTGJMak5ESEo1djBoT3dNdHd6?=
 =?utf-8?B?Q1MyZDRwSy9EcXViTy8yb2lEdTM2QjNoSEJwV1E1UFJHVjhQQ2JMS1VPMldy?=
 =?utf-8?B?UXFUVlQvMzloT0ZZVXpQVmpQUzExR3FDY2M2NjE5bEFqQ2FhcU05K0t4Y0F0?=
 =?utf-8?B?RDFLL0FoeVU5Y1Z5ZWFhcHowdlY2QjdDWFlLMFVFWHFSSVZSbSsvTzBPVmRX?=
 =?utf-8?B?d1NhY25DU1NRUWR5bStEUlhzaEhwQW9obUt3T3FackxpK05sVXlsTEEvbE9B?=
 =?utf-8?B?cGRYQ0V1VDBEVisvWEt5bTJNRlFTbG1EZ0tPVzcvRTN2aS90cS92UTF3RGFx?=
 =?utf-8?B?U1FIaGpaYUFqeVI1WXl5T2kyRHFQZkFFSy9zL0xYaGVGOFpVY0VyckIvN3ZL?=
 =?utf-8?B?SDk1Zkh5ZkhxK2E2eEtlTzVISnd1cXJzQWxTdlBHWmdmYVk1SXhXUnJmQ2NG?=
 =?utf-8?B?eXdSR2w2dTl5dWdxQTBzZFgwTUtCWTVyN1JONlJRamRkYnpYc2t6OGlpcnQ2?=
 =?utf-8?B?VWQwaG9aSGhlaUNEZzh1Ui9FNGxuY2FQTDlNTXkrclBadjZVaFhHb2JiRkd3?=
 =?utf-8?B?T0hCcVZLQWk1Y2RyRHRKMlE3ZUNvRzcwWkZoSFdOdFA5eDYrZ2k3b1hiS0k3?=
 =?utf-8?B?N3NaUE9UWnRkMGpYdG5KTzNUenpIblo3bGd2QWwrblN5U3B1djBNMTc0WTd2?=
 =?utf-8?B?cGR5cklpNVdmY3JaS2dGVm9abElUOGRkNFNMQlFob3QxbXVjSHdaSHRkN1ox?=
 =?utf-8?B?NCs3UGZrNjc2RllXcTBTMVZpaUVqYm5nQ01xT05qRVVWVzBRYUkxRUVsQy9J?=
 =?utf-8?B?dFRHdVk0U1lXc0VXU0hwbUdNc0RIMjBiTnRkZ2NXaUdYcVREMDNVd1BGRWU4?=
 =?utf-8?B?UE81UFRuOWtGRUd0V1ZoQWVTWXI2OThRVEhKQjlWaFArRmFGTEFFbEN5NEtT?=
 =?utf-8?B?SFV4QnVsdXMvSnNSVFNvR2s4VTYxYmZ6WktlUk5jY01xeHFFYmtjWEMrQThO?=
 =?utf-8?B?aVM1aURkNlZaWlJ6TWllVkl2MTNlbUNQUzI1Q2ZIRy9CUDd3clppWE5JalFW?=
 =?utf-8?B?SnpIa2hSTGhXWE9wU0VXc21tQmQ4eVA1M2Y1cTh1Rk9WVTlSZ1Z2MDhaNGVU?=
 =?utf-8?B?WGdQby9tNmVEQmFSQ0hzV1pwVGJJZzFzcXQ4ZFRidTl4emdTNTFWVFB5UGxX?=
 =?utf-8?B?K0VIY2lFcW01eFFkcmF1TTNyZW9HUEQ2Y2lzcVZ5WkNJbi9sOHNsaVFLb3V6?=
 =?utf-8?B?dzZYSlRBbWlVSEwzUmxyZndSb3NhQkdJSkREdEpubGpYNHA4MWlVOUxBUXBJ?=
 =?utf-8?B?bFkvWHZ6MFhDellKVTVhalZ0b2tscjFjaHV0cG9ySjh1b0ZtRUZvMXBOWWk5?=
 =?utf-8?B?eFJoQ1RYR3BFNWZQb1d1UkhSUUtSdHJObUJkSWdpb1BEekFRVFN2K0dUYjZC?=
 =?utf-8?B?NkRLamx2TW5ISjUxcUJIQThTM0cvL2ZTblJ3SEJzVGRxTXI0YjRXLzJiYWlB?=
 =?utf-8?B?WnlKUjNHUWhsNmZKb2hYM3dDYVh3Q0pMS3A5YnFRM2RVOFczdHlQK080RGpy?=
 =?utf-8?B?b2Vpbmk1UG1sTVNDTVIyWE85Qk9wMmpWb3kyQTFWeDBad29vY2g3TmZlOVZw?=
 =?utf-8?B?L2JaQXlaQmhLSlMybnhYQ0hSSnpsaGhhWmJRL1NQMUlpU2lnaksxRDJtMEl3?=
 =?utf-8?B?TWgzSGR1UDNqdWR3WnBFMnVrc1VoMFZrV1h6emlKbWpHSkttMTJCOTZtbi9w?=
 =?utf-8?B?Um0zWlRMeEtaQW52MlFaWVFwOE9zaHJKajBuZnVnVlAzWi9oZjEyWHAwS1lN?=
 =?utf-8?Q?CHnqKOxU0mShdfK148Ds9i4St?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <753C52BB8991954DABD3D9BA8DAD72C8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b4262ec-e764-458a-f952-08dc05f0de03
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 08:58:45.4840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udbRi6MR9uLmlgv0PFiO7ZhXSjpHXEf3LuRAgnSn+skiroyHvcgBsdqb3YLBsCSdZFdwkIMBVh1OXx2ocKIJqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7753
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--15.033300-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQOwH4pD14DsPHkpkyUphL9qQ9UezeTkThu4FknyqyshF1Q
	po5pNysMe29pTfBhqOY7b3Js3F6vVD1LciJB3541o65WJt1k1O8TbU1KYGoQp3vsbfoZixUT3oz
	JRX7b4Nkl3UHzTyg4SDjMd1TWYQcanuh7s4XRTZYbmaDSnOqZfqcX+euO9ejcvDa284z78yfyKd
	Kafi2Z4+LzNWBegCW2PZex/kxUIHW3sNbcHjySQd0H8LFZNFG7bkV4e2xSge5/sWXVzFBYYzVhL
	rNyPF2sSTLHh5jqITBw9PR+tf+HQTZFEgw6u+Np
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.033300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	D837212CDECCBA21E2D301C87A354A5F2BDB4ABB95B19956571D895E6B4B92152000:8

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
PiArDQo+ICtzdGF0aWMgaW50IGNtZHFfc2VjX2ZpbGxfaXdjX21zZyhzdHJ1Y3QgY21kcV9zZWNf
Y29udGV4dCAqY29udGV4dCwNCj4gKwkJCQkgc3RydWN0IGNtZHFfc2VjX3Rhc2sgKnNlY190YXNr
LCB1MzINCj4gdGhyZF9pZHgpDQo+ICt7DQo+ICsJc3RydWN0IGl3Y19jbWRxX21lc3NhZ2VfdCAq
aXdjX21zZyA9IE5VTEw7DQo+ICsJc3RydWN0IGNtZHFfc2VjX2RhdGEgKmRhdGEgPSAoc3RydWN0
IGNtZHFfc2VjX2RhdGEgKilzZWNfdGFzay0NCj4gPnRhc2sucGt0LT5zZWNfZGF0YTsNCj4gKwl1
MzIgc2l6ZSA9IDAsIG9mZnNldCA9IDAsICppbnN0cjsNCj4gKw0KPiArCWl3Y19tc2cgPSAoc3Ry
dWN0IGl3Y19jbWRxX21lc3NhZ2VfdCAqKWNvbnRleHQtPml3Y19tc2c7DQo+ICsNCj4gKwlpZiAo
c2VjX3Rhc2stPnRhc2sucGt0LT5jbWRfYnVmX3NpemUgKyA0ICogQ01EUV9JTlNUX1NJWkUgPg0K
PiBDTURRX1RaX0NNRF9CTE9DS19TSVpFKSB7DQo+ICsJCXByX2Vycigic2VjX3Rhc2s6JXAgc2l6
ZTolenUgPiAldSIsDQo+ICsJCSAgICAgICBzZWNfdGFzaywgc2VjX3Rhc2stPnRhc2sucGt0LT5j
bWRfYnVmX3NpemUsDQo+IENNRFFfVFpfQ01EX0JMT0NLX1NJWkUpOw0KPiArCQlyZXR1cm4gLUVG
QVVMVDsNCj4gKwl9DQo+ICsNCj4gKwlpZiAodGhyZF9pZHggPT0gQ01EUV9JTlZBTElEX1RIUkVB
RCkgew0KPiArCQlpd2NfbXNnLT5jb21tYW5kLmNtZF9zaXplID0gMDsNCj4gKwkJaXdjX21zZy0+
Y29tbWFuZC5tZXRhZGF0YS5hZGRyX2xpc3RfbGVuZ3RoID0gMDsNCj4gKwkJcmV0dXJuIC1FSU5W
QUw7DQo+ICsJfQ0KPiArDQo+ICsJaXdjX21zZy0+Y29tbWFuZC50aHJlYWQgPSB0aHJkX2lkeDsN
Cj4gKwlpd2NfbXNnLT5jb21tYW5kLnNjZW5hcmlvID0gc2VjX3Rhc2stPnNjZW5hcmlvOw0KPiAr
CWl3Y19tc2ctPmNvbW1hbmQuZW5nX2ZsYWcgPSBzZWNfdGFzay0+ZW5naW5lX2ZsYWc7DQo+ICsJ
c2l6ZSA9IHNlY190YXNrLT50YXNrLnBrdC0+Y21kX2J1Zl9zaXplOw0KPiArCW1lbWNweShpd2Nf
bXNnLT5jb21tYW5kLnZhX2Jhc2UgKyBvZmZzZXQsIHNlY190YXNrLT50YXNrLnBrdC0NCj4gPnZh
X2Jhc2UsIHNpemUpOw0KDQpJIHRoaW5rIGl0J3Mgbm90IG5lY2Vzc2FyeSB0byBjb3B5IGZyb20g
bm9ybWFsIGNvbW1hbmQgYnVmZmVyIHRvIG5vcm1hbA0KY29tbWFuZCBidWZmZXIuIEp1c3QNCg0K
aXdjX21zZy0+Y29tbWFuZC52YV9iYXNlID0gc2VjX3Rhc2stPnRhc2sucGt0LT52YV9iYXNlOw0K
DQpZb3UgaGF2ZSBhIHNlY3VyZSBjb21tYW5kIGJ1ZmZlciBmb3Igc2VjdXJlIGdjZSB0byBleGVj
dXRlIGNvbW1hbmQuIElmDQp5b3Ugd2FudCB0byBtb2RpZnkgY29tbWFuZCBidWZmZXIsIGNvcHkg
ZnJvbSBub3JtYWwgY29tbWFuZCBidWZmZXIgdG8NCnNlY3VyZSBjb21tYW5kIGJ1ZmZlciwgYW5k
IG1vZGlmeSB0aGUgc2VjdXJlIGNvbW1hbmQgYnVmZmVyLg0KDQpSZWdhcmRzLA0KQ0sNCg0KDQo+
ICsJaXdjX21zZy0+Y29tbWFuZC5jbWRfc2l6ZSArPSBzaXplOw0KPiArCW9mZnNldCArPSBzaXpl
IC8gNDsNCj4gKw0KPiArCWluc3RyID0gJml3Y19tc2ctPmNvbW1hbmQudmFfYmFzZVtpd2NfbXNn
LT5jb21tYW5kLmNtZF9zaXplIC8gNA0KPiAtIDRdOw0KPiArCWlmICgodTY0KSppbnN0ciA9PSBD
TURRX0VPQ19DTUQpDQo+ICsJCWluc3RyWzBdID0gMDsNCj4gKwllbHNlDQo+ICsJCXByX2Vycigi
JXMgJWQ6IGZpbmQgRU9DIGZhaWxlZDogJSN4ICUjeCIsDQo+ICsJCSAgICAgICBfX2Z1bmNfXywg
X19MSU5FX18sIGluc3RyWzFdLCBpbnN0clswXSk7DQo+ICsNCj4gKwlpd2NfbXNnLT5jb21tYW5k
LndhaXRfY29va2llID0gc2VjX3Rhc2stPndhaXRfY29va2llOw0KPiArCWl3Y19tc2ctPmNvbW1h
bmQucmVzZXRfZXhlYyA9IHNlY190YXNrLT5yZXNldF9leGVjOw0KPiArDQo+ICsJaWYgKGRhdGEt
PmFkZHJfbWV0YWRhdGFfY250KSB7DQo+ICsJCWl3Y19tc2ctPmNvbW1hbmQubWV0YWRhdGEuYWRk
cl9saXN0X2xlbmd0aCA9IGRhdGEtDQo+ID5hZGRyX21ldGFkYXRhX2NudDsNCj4gKwkJbWVtY3B5
KGl3Y19tc2ctPmNvbW1hbmQubWV0YWRhdGEuYWRkcl9saXN0LA0KPiArCQkgICAgICAgKHUzMiAq
KSh1bnNpZ25lZCBsb25nKWRhdGEtPmFkZHJfbWV0YWRhdGFzLA0KPiArCQkgICAgICAgZGF0YS0+
YWRkcl9tZXRhZGF0YV9jbnQgKiBzaXplb2Yoc3RydWN0DQo+IGl3Y19jbWRxX2FkZHJfbWV0YWRh
dGFfdCkpOw0KPiArCX0NCj4gKw0KPiArCWl3Y19tc2ctPmNvbW1hbmQubWV0YWRhdGEuZW5nc19u
ZWVkX2RhcGMgPSBkYXRhLQ0KPiA+ZW5nc19uZWVkX2RhcGM7DQo+ICsJaXdjX21zZy0+Y29tbWFu
ZC5tZXRhZGF0YS5lbmdzX25lZWRfc2VjX3BvcnQgPSBkYXRhLQ0KPiA+ZW5nc19uZWVkX3NlY19w
b3J0Ow0KPiArCWl3Y19tc2ctPmNvbW1hbmQubm9ybWFsX3Rhc2tfaGFuZGxlID0gKHVuc2lnbmVk
IGxvbmcpc2VjX3Rhc2stDQo+ID50YXNrLnBrdDsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0K
PiArDQo=

