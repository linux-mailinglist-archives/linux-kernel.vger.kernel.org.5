Return-Path: <linux-kernel+bounces-12459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE70B81F514
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 07:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6E51C21BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 06:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9A363DE;
	Thu, 28 Dec 2023 06:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="gJU5Rtkp";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Mvl97NC+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592465386;
	Thu, 28 Dec 2023 06:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4701b02ca54a11eea2298b7352fd921d-20231228
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5iucj3ZTHlDOJnB+p/ih/MNr46i67mLy8bwro6OeIIg=;
	b=gJU5RtkpLpW1bPWJjJac6lI6cUQqMNHC13fElwU73WWNwpjZpyuszBfoJNN4WsJ7HBmBAxOTpg3iugz1zg4mc/yX4WjZUdAPxzptdw/TzVCHjqKec6V6qHnIpQR/BJtYMwTG1akoVeL8/6tOhs4Bs9IiqrnC1lXhaUduA3oKMes=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:45b61e08-8d63-4a77-8f77-dc54e3fd10b3,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:0bccc07e-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 4701b02ca54a11eea2298b7352fd921d-20231228
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1796969556; Thu, 28 Dec 2023 14:28:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Dec 2023 14:28:11 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Dec 2023 14:28:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpXz45BUwarslJZ9fX4SprYjdSiKb6oRXmqxMGa1eOccKq9byZivMBXu2DzA7okxZ7Fs1DVjSuDpV6M7cJRAJy4WLQkv+vxSQvdrz9ecufOI8wrNWYXTqcmz0o/Kh65i1U6mk/OeU+BjYv3Gm+CqS/l6o1/g1SG8Lfoun/IAngt2XeZG82GT1bnP5fsGij41CbfAwJZoNDftJfQ2oX8mm0xykyhICnemABXIr6clhIakfKImtSx3vocZUEhb4XuOAi3Ds4gY5OaSabKBT/pzwCRa5DNgAthH4i4w4SvHwxsk9Vpl1TICD8CFS3S0G9GsUVcnyXJbJyhFhaIfcLMagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iucj3ZTHlDOJnB+p/ih/MNr46i67mLy8bwro6OeIIg=;
 b=fKrcz//znWTdbJ/hJpu58+Ur1FEhy2HAJSXy9Ijz2Bx3jRAaqS/6Gzx9npFaOKQqg33ki8oNHhP8/cA1Rq4Q+8rrxLrcbUP5Ul0KVK+HCLHvUrBK+5J/2dWR9Kmsf/emLtoFsWgFZgleAe4GIH5paxEraglaUQ9+MZsBYXNdNRo0FSBteEps26a0E6H3XVzU8usl5gqAD5MYebS79gPRiBV93uz2urqTdyd7O7Y+NAUMzSaEZaKHigUEBLBNhdESLqr9IYZCXT8SKiFASx1Z8RtBykNKMouOOOiQXIjI6eHpkXtOGFHbTCD0lltvcWjuadyRJLnb3f1wNCV3819/wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5iucj3ZTHlDOJnB+p/ih/MNr46i67mLy8bwro6OeIIg=;
 b=Mvl97NC+iQV9maeOU+AwZBaj8gwPw7+F+Hd07FiWylkbF+TQsinlmIiU2B7UEOlcRsgfAkq+hvJG1XlButX9pMjq6IK9OzQ6FNP9ybuMhBQc39RCCdAfwTjcMj5uCuqQLauQjED0XDXXh8Dpk1yj+ItLypItqXRIC7e7Tzh+Fl8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by KL1PR03MB8572.apcprd03.prod.outlook.com (2603:1096:820:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Thu, 28 Dec
 2023 06:27:07 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Thu, 28 Dec 2023
 06:27:06 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
	"jason-jh.lin@mediatek.corp-partner.google.com"
	<jason-jh.lin@mediatek.corp-partner.google.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, =?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?=
	<Johnson.Wang@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 00/11] Add mediate-drm secure flow for SVP
Thread-Topic: [PATCH v3 00/11] Add mediate-drm secure flow for SVP
Thread-Index: AQHaNc45Z3V+o07y+U2bMGyTisadW7C+QiOA
Date: Thu, 28 Dec 2023 06:27:06 +0000
Message-ID: <4fd704b3438e524362fada762b380bd18949cd0a.camel@mediatek.com>
References: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
In-Reply-To: <20231223182932.27683-1-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|KL1PR03MB8572:EE_
x-ms-office365-filtering-correlation-id: b2dab656-8b5b-4b29-46eb-08dc076e0333
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wy9ufIpbTowIe5sesgJefWr7Qc0/92DEACbbGCWuS4gzRsMcEk3Lg3k/eqWyUDXLRaTNjUuCZOfsBYkd1z11P7RCAEQ49QnRt7VxAMwIBb52aphTs86m2P2UzwBTrNXo30D8oVRPvsQC6MOKu6jh4Vj414/rwIaJlDC59YohQkzdIqFe0sWzBD7Y0jHNxvrsr+TgoppNkCHbb+WVZSxDKNIR403dBMgJasHsb/F34xLHdTP4yx+E8d1WBOAMw5M6XpvhNpcT+4u3iZ5Kgm6uKHUqGmKZ92Eu7kpyh7Mvzc5F3UzwU2XYsBx1VN1dUzSKqRtblywWkc7gAW2EPTuct89c2qdJcxebH1TvnmNT7ghKkupYFTi1AJ7u129a1BfeVU2MixiXe5Uawa4UvtctZnuu+PqngeOsuTYsyBo5AluAmHi+5kN8g828qwNzPO+daNxR/zfcI6H7hq2+EMYsc/MFS8pVeQyWj2YnKQD7nXCZyJ0o03voTZSZbVURTtAP2IQEGO+yRUMmWR2q0tgiOtGkXgx7FXq/JNmG3+9aOi8d1jrojYZwrKvh6MrYt75z6+DW4rpQvqgr8BcdWE1PGEU44jDGyNF3qi1KiuHUiOLwoa4G5UPotEmgaP2Xw+6z3DnsL5a7wVZE/uCxm35IDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(2616005)(86362001)(6506007)(71200400001)(966005)(6512007)(83380400001)(4326008)(8676002)(8936002)(7416002)(5660300002)(6486002)(66476007)(76116006)(110136005)(66446008)(316002)(64756008)(66556008)(38100700002)(54906003)(478600001)(122000001)(66946007)(41300700001)(36756003)(4001150100001)(38070700009)(85182001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkxqclBZMTZNbklFd1lSMS8xbkh5SitSYmwxWFFKL3AyVytQUUZ5WlhYUlVE?=
 =?utf-8?B?MkRQQm83OHcxeHZCcUhEdjdUenBEL0FTcDJWaktvSW5zME1UaFRaNysxVkcx?=
 =?utf-8?B?V0ZYNlZJTE05WTF6bXlpbmlwOVhSWVVLL0pjK3NQR2ZUM0dzK3NCZDlSc2NH?=
 =?utf-8?B?Z3dKZGR2blQzaERiM0ZYZzRUZnJzTzFLbkJkbUJkT1lqR21mNUlWY1RaVy9W?=
 =?utf-8?B?MklmVjREcXZXNW45amdzMmZxWVFDNzZuSjg2Ly9HeEpVZjBWTkg1ZXhIRWpE?=
 =?utf-8?B?cEJ5S0t1Mll5WmxCU0s5VHh3eDZQNEVHRlpxTDMzVWp5ek1aMzhtUllzNlRm?=
 =?utf-8?B?eFB2UG1sbzNHMWNaTXZyazUzMDhyQllJSGszcTh3MHBSZmpQRmVBL0VJVUpn?=
 =?utf-8?B?SXlKY29icnJtRG95K0YyWkNJcDUrYzArY1JOMnp2eVM1Y2JNd0VNS0FXZWRl?=
 =?utf-8?B?Rkl4VmRCamdQR0szZ0VMaGRmOUdwUDAzd0swUllKcTBYYm1TNkRvYURyclA4?=
 =?utf-8?B?NHBZOEQ1WkxySGhWSURLbW9KWTd3YnZlUThhS1VCTmdTbWIvZllaQmJRUnRJ?=
 =?utf-8?B?UzRHVzB5RVUyMU01djluWUoyVXVpdXhZZDRxR3huRXNMN1hXRWpTQWx0YWR3?=
 =?utf-8?B?M3pPaDNPM0FVVy9GcjFCMlBrak5LMkNjNjN1WWdlYnk3UGVBb0pEc3llU3Vu?=
 =?utf-8?B?Zml2V0tTZmFHOWh3ZXYwaG0rYWdUenVpTng1eVRiMEhNbjdBNmdLcHNDVFZL?=
 =?utf-8?B?MU9rOGhWZ0RISlZ2ZTV5amtsaVBxU1BPaHhYN3JtVzMzWnRnSFVjTE9aMEpM?=
 =?utf-8?B?cTVXRkN3YVdHSWVtWmgxTVk3Q3BHTEhXQ3V0bEgxbWNFbkZVakVYRDc4VjZx?=
 =?utf-8?B?dXV0MkgrRlBlV3JjK3VFRHN5eDNIMUpEZDNlL2pna1BOdnpIRWdSNlRGeVVY?=
 =?utf-8?B?SWJvQnUzL2hLNVdrM2QrSzlDd2h3ZHNtdVpIS3MxRkEzdkJHM0JQN1doTkxG?=
 =?utf-8?B?MjNzRGdKT1YvR2ZnSVJZelNTclQ0SHFYckhKMGsyMGwwbXFyZlRoRno4K3FB?=
 =?utf-8?B?MzU4YzAxS3A1TERFdi9kbnBoZXBoMVV5U2JXTzZOMjVzM0xxZ3hERmlESmxH?=
 =?utf-8?B?enRyb0I1ZGhJMlJ0c1NJVHUxaUxZa21hVFVEVVhwS3lhd25tR1hoZ2MzNTJX?=
 =?utf-8?B?aFlFcVhGQVI0NUV5T1NFTGJUU24zdmVLd0JtTUJtRjhJTTBmRnpsaTQyVDdC?=
 =?utf-8?B?S0ZwVHdNcU5YTkg5Nlcxc2tldTVISWhKRzQ3Zk9ucDZZaTNXWklEMEsxM2Nh?=
 =?utf-8?B?dWRwY3BZdjFsNFNTOGt3aGFTTTlQa1JUZXpCZWkvR3J5bWg2NCtmYmJtT2Yv?=
 =?utf-8?B?c2NnVUtIakx2RjgrVTNYbnJES2swQXJ2OVI0VDhrYXA3bk9xT3VSM3Q0V2lT?=
 =?utf-8?B?V0xCNmdZOWNEdzYrUVJnMDZmUWYzUkVPVEVabXRjSGQ0bTNXWXFsNEtHZmpU?=
 =?utf-8?B?c3djZGZNRVlaN1dmTzh3TkMyTHhPMm5xNGVITkpvQStPcC9lWFVtdWc2UkdT?=
 =?utf-8?B?VVBNbVhFaDNQT0xpbE1YVjNXNzFkQTFnODZsM0JSdlJEcm5SaituRHgrbElv?=
 =?utf-8?B?SXUzbXM5a1BLcnQzb0FYSzBVcWt2MXpUaVU0elpUSTBRWWdDdDJFUzZYb1BF?=
 =?utf-8?B?YU9CelVpdHZwYjBQbzdaenRvamQwZHpYeEt3YWNMdGVmekh0MGxybWo1TGdV?=
 =?utf-8?B?c1VuOTZuemxXTUx6d0d6ZDZweXhmRlVtSEJJdkRTUmJVY0RuN2g2ZG1tcmN6?=
 =?utf-8?B?L3lQdGtyc3B5dnJ6anhKMmVKRmhENkNVTU8yQ1hGQXYxOFAwTlJvMzFBRXJU?=
 =?utf-8?B?T3Qvd25vdDlFcWwxYzliRS9CWmQwVDY4aUVvTk1vRUlGQktwK1lHZmZNSjA2?=
 =?utf-8?B?bzJydFJzTzFzM0lLanJCYnN1QU95VzZWM0NqU2RUMWk3cmdXc3FtVzBUWTRF?=
 =?utf-8?B?OFFwam81NVF2aCtEOGRyQzN0QzB3aW5yUEFsYXdSNzE4Z1pMQ0tnU2RBMjhC?=
 =?utf-8?B?NDVjQXMrcndqRnVXaU9ZK3BLbkhMNHRsMGJ0V0lKaURZQWM2VXRnMzhvazFJ?=
 =?utf-8?Q?n+iNZkJzjz+MAaBqITFf5PAHf?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB9562FA67CF646A3114C23BE47D9DB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dab656-8b5b-4b29-46eb-08dc076e0333
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 06:27:06.0850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6L3U5dQRWNs7JMgNWx07uBUF4leM7C+UXXi/24p2dzjC4PlPCoxhfThhKlE9wm5vqzdDoGtUzeU+zFkMrS4Otw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8572
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.350000-8.000000
X-TMASE-MatchedRID: gzVbiXtWD9sOwH4pD14DsPHkpkyUphL9VCDy36xoPiQUKi0td+qmroqq
	/NLYoJ0ORAjjCBWd1tUMzj/6Jyp22UW4h8yvsXQnEPf7TDUOGopEkrrs6EaaQ2ULmwB6T2fLnFq
	TWUo/GE12/120FKksrM4upQc4xGVCeqv65bNPmES9HTxRE6QQB3JrB0Cu3DDnVz8J52OVy+Sozw
	9gka4dij8lS9fvVyTcAdyK8K+j12LOkUilvGnufa/Zw8tRb5352+EpBnZEzfXjud2x7TPVt+V05
	r5vXH4sXewO9NcoxSCkJpAbNH+cOwS+P0RNxd8HwCZxkTHxccn54F/2i/DwjUUNHQAoZf5cBu+l
	lRlNm+pzprJ7k+e5vxYKzR9JnWmCjROjughSj+Kk3yyn4uPtLVAI6wCVrE3viaBUxnizejdAd9s
	p7/hgkvhZBgSZWubhmsJaThnkmNYAzT8btdR14x+WEMjoO9WWVNyumldWne2bKItl61J/yfmS+a
	Pr0Ve8SlnU38LCY8tp7Kxueu/Dit0H8LFZNFG76sBnwpOylLPCRUZVLnEESP9+WGRKH/t6+gWoS
	gupWi/yUrsXBNeQB4JoQvA21ugrOwOV4inJ14p+eNTG3fkrLAncOebUDvSkG12GH118U3G5Zyim
	lDMxyA56xhuba2WuZ86KY3oNT3zIO0Si2Tuenn7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.350000-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	05C9F7B11D2B84CBB6EFFDFF64E55CB0619AA09944C1CEA9FA8D108E25DF78832000:8

SGksIEphc29uOg0KDQpPbiBTdW4sIDIwMjMtMTItMjQgYXQgMDI6MjkgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gRnJvbTogSmFzb24tamggTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsu
Y29ycC1wYXJ0bmVyLmdvb2dsZS5jb20+DQo+IA0KPiBNZW1vcnkgRGVmaW5pdGlvbnM6DQo+IHNl
Y3VyZSBtZW1vcnkgLSBNZW1vcnkgYWxsb2NhdGVkIGluIHRoZSBURUUgKFRydXN0ZWQgRXhlY3V0
aW9uDQo+IEVudmlyb25tZW50KSB3aGljaCBpcyBpbmFjY2Vzc2libGUgaW4gdGhlIFJFRSAoUmlj
aCBFeGVjdXRpb24NCj4gRW52aXJvbm1lbnQsIGkuZS4gbGludXgga2VybmVsL3VzZXJzcGFjZSku
DQo+IHNlY3VyZSBoYW5kbGUgLSBJbnRlZ2VyIHZhbHVlIHdoaWNoIGFjdHMgYXMgcmVmZXJlbmNl
IHRvICdzZWN1cmUNCj4gbWVtb3J5Jy4gVXNlZCBpbiBjb21tdW5pY2F0aW9uIGJldHdlZW4gVEVF
IGFuZCBSRUUgdG8gcmVmZXJlbmNlDQo+ICdzZWN1cmUgbWVtb3J5Jy4NCj4gc2VjdXJlIGJ1ZmZl
ciAtICdzZWN1cmUgbWVtb3J5JyB0aGF0IGlzIHVzZWQgdG8gc3RvcmUgZGVjcnlwdGVkLA0KPiBj
b21wcmVzc2VkIHZpZGVvIG9yIGZvciBvdGhlciBnZW5lcmFsIHB1cnBvc2VzIGluIHRoZSBURUUu
DQo+IHNlY3VyZSBzdXJmYWNlIC0gJ3NlY3VyZSBtZW1vcnknIHRoYXQgaXMgdXNlZCB0byBzdG9y
ZSBncmFwaGljDQo+IGJ1ZmZlcnMuDQo+IA0KPiBNZW1vcnkgVXNhZ2UgaW4gU1ZQOg0KPiBUaGUg
b3ZlcmFsbCBmbG93IG9mIFNWUCBzdGFydHMgd2l0aCBlbmNyeXB0ZWQgdmlkZW8gY29taW5nIGlu
IGZyb20gYW4NCj4gb3V0c2lkZSBzb3VyY2UgaW50byB0aGUgUkVFLiBUaGUgUkVFIHdpbGwgdGhl
biBhbGxvY2F0ZSBhICdzZWN1cmUNCj4gYnVmZmVyJyBhbmQgc2VuZCB0aGUgY29ycmVzcG9uZGlu
ZyAnc2VjdXJlIGhhbmRsZScgYWxvbmcgd2l0aCB0aGUNCj4gZW5jcnlwdGVkLCBjb21wcmVzc2Vk
IHZpZGVvIGRhdGEgdG8gdGhlIFRFRS4gVGhlIFRFRSB3aWxsIHRoZW4NCj4gZGVjcnlwdA0KPiB0
aGUgdmlkZW8gYW5kIHN0b3JlIHRoZSByZXN1bHQgaW4gdGhlICdzZWN1cmUgYnVmZmVyJy4gVGhl
IFJFRSB3aWxsDQo+IHRoZW4gYWxsb2NhdGUgYSAnc2VjdXJlIHN1cmZhY2UnLiBUaGUgUkVFIHdp
bGwgcGFzcyB0aGUgJ3NlY3VyZQ0KPiBoYW5kbGVzJyBmb3IgYm90aCB0aGUgJ3NlY3VyZSBidWZm
ZXInIGFuZCAnc2VjdXJlIHN1cmZhY2UnIGludG8gdGhlDQo+IFRFRSBmb3IgdmlkZW8gZGVjb2Rp
bmcuIFRoZSB2aWRlbyBkZWNvZGVyIEhXIHdpbGwgdGhlbiBkZWNvZGUgdGhlDQo+IGNvbnRlbnRz
IG9mIHRoZSAnc2VjdXJlIGJ1ZmZlcicgYW5kIHBsYWNlIHRoZSByZXN1bHQgaW4gdGhlICdzZWN1
cmUNCj4gc3VyZmFjZScuIFRoZSBSRUUgd2lsbCB0aGVuIGF0dGFjaCB0aGUgJ3NlY3VyZSBzdXJm
YWNlJyB0byB0aGUNCj4gb3ZlcmxheQ0KPiBwbGFuZSBmb3IgcmVuZGVyaW5nIG9mIHRoZSB2aWRl
by4NCj4gDQo+IEV2ZXJ5dGhpbmcgcmVsYXRpbmcgdG8gZW5zdXJpbmcgc2VjdXJpdHkgb2YgdGhl
IGFjdHVhbCBjb250ZW50cyBvZg0KPiB0aGUNCj4gJ3NlY3VyZSBidWZmZXInIGFuZCAnc2VjdXJl
IHN1cmZhY2UnIGlzIG91dCBvZiBzY29wZSBmb3IgdGhlIFJFRSBhbmQNCj4gaXMgdGhlIHJlc3Bv
bnNpYmlsaXR5IG9mIHRoZSBURUUuDQo+IA0KPiBEUk0gZHJpdmVyIGhhbmRsZXMgYWxsb2NhdGlv
biBvZiBnZW0gb2JqZWN0cyB0aGF0IGFyZSBiYWNrZWQgYnkgYQ0KPiAnc2VjdXJlDQo+IHN1cmZh
Y2UnIGFuZCBmb3IgZGlzcGxheWluZyBhICdzZWN1cmUgc3VyZmFjZScgb24gdGhlIG92ZXJsYXkg
cGxhbmUuDQo+IFRoaXMgaW50cm9kdWNlcyBhIG5ldyBmbGFnIGZvciBvYmplY3QgY3JlYXRpb24g
Y2FsbGVkDQo+IERSTV9NVEtfR0VNX0NSRUFURV9FTkNSWVBURUQgd2hpY2ggaW5kaWNhdGVzIGl0
IHNob3VsZCBiZSBhICdzZWN1cmUNCj4gc3VyZmFjZScuIEFsbCBjaGFuZ2VzIGhlcmUgYXJlIGlu
IE1lZGlhVGVrIHNwZWNpZmljIGNvZGUuDQoNCkkgd291bGQgbGlrZSB0byBkZWNvdXBsZSBzZWN1
cmUgZGlzcGxheSBhbmQgc2VjdXJlIGRlY29kZS4gT25lIHJlYXNvbg0KaXMgdGhhdCBJIHdvdWxk
IGxpa2Ugc2VjdXJlIGRpc3BsYXkgY291bGQgYmUgdGVzdGVkIGl0c2VsZiB3aXRob3V0DQpzZWN1
cmUgZGVjb2RlLiBBbm90aGVyIHJlYXNvbiBpcyB0aGF0IGlmIHNvbWVvbmUgaGFzIGRyYXcgYW4g
aW1hZ2UgYW5kDQp3YW50IHRvIGRpc3BsYXkgc2VjdXJlbHksIHRoaXMgaXMgbm90IHJlbGF0ZWQg
dG8gZGVjb2RlLg0KDQpUbyBhY2hpZXZlIHRoaXMsIG1lZGlhdGVrIGRybSBkcml2ZXIgc2hvdWxk
IHByb3ZpZGUgcmVuZGVyIGZ1bmN0aW9uIG9uDQpzZWN1cmUgc3VyZmFjZS4gVGhlIG1vc3Qgc2lt
cGxlIGZ1bmN0aW9uIGlzIHRvIGJpdGJsdCBhIG5vcm1hbCBzdXJmYWNlDQpvbnRvIHNlY3VyZSBz
dXJmYWNlLiBVc2VyIGNvdWxkIGFsbG9jYXRlIGJvdGggbm9ybWFsIHN1cmZhY2UgYW5kIHNlY3Vy
ZQ0Kc3VyZmFjZSwgZHJhdyBvbiBub3JtYWwgc3VyZmFjZSBhbmQgYml0Ymx0IG5vcm1hbCBzdXJm
YWNlIG9udG8gc2VjdXJlDQpzdXJmYWNlLiBXZSBjb3VsZCBoYXZlIGxpbWl0YXRpb24gdGhhdCBu
b3JtYWwgc3VyZmFjZSBhbmQgc2VjdXJlDQpzdXJmYWNlIGhhdmUgdGhlIHNhbWUgd2lkdGgsIGhl
aWdodCwgcGl0Y2gsIHBpeGVsIGZvcm1hdCwgYW5kIHRoZQ0KYml0Ymx0IGlzIHRoZSBmdWxsIGlt
YWdlIGJpdGJsdC4gU28gbWVkaWF0ZWsgZHJtIGRyaXZlciBqdXN0IG5lZWQgYSBURUUNCmZ1bmN0
aW9uIHRoYXQgZG8gbWVtb3J5IGNvcHkgZnJvbSBub3JtYWwgc3VyZmFjZSB0byBzZWN1cmUgc3Vy
ZmFjZS4NCg0KVGhpcyBpcyBub3QgYSBtdXN0LWJlIGZ1bmN0aW9uLCBidXQgaXQgaGFzIHNvbWUg
YmVuZWZpdCBmb3Igc2VjdXJlDQpkaXNwbGF5Lg0KDQpSZWdhcmRzLA0KQ0sNCg0KPiAtLS0NCj4g
VE9ETzoNCj4gMSkgUmVtb3ZlIGdldCBzZWMgbGFyYiBwb3J0IGludGVyZmFjZSBpbiBkZHBfY29t
cCwgb3ZsIGFuZA0KPiBvdmxfYWRhcHRvci4NCj4gMikgVmVyaWZ5IGluc3RydWN0aW9uIGZvciBl
bmFibGluZy9kaXNhYmxpbmcgZGFwYyBhbmQgbGFyYiBwb3J0IGluDQo+IFRFRQ0KPiAgICBkcm9w
IHRoZSBzZWNfZW5naW5lIGZsYWdzIGluIG5vcm1hbCB3b3JsZCBhbmQuDQo+IDMpIE1vdmUgRElT
UF9SRUdfT1ZMX1NFQ1VSRSBzZXR0aW5nIHRvIHNlY3VyZSB3b3JsZCBmb3INCj4gbXRrX2Rpc3Bf
b3ZsLmMuDQo+IDQpIENoYW5nZSB0aGUgcGFyYW1ldGVyIHJlZ2lzdGVyIGFkZHJlc3MgaW4gbXRr
X2RkcF9zZWNfd3JpdGUoKQ0KPiAgICBmcm9tICJ1MzIgYWRkciIgdG8gInN0cnVjdCBjbWRxX2Ns
aWVudF9yZWcgKmNtZHFfcmVnIi4NCj4gNSkgSW1wbGVtZW50IHNldHRpbmcgbW1zeXMgcm91dGlu
ZyB0YWJsZSBpbiB0aGUgc2VjdXJlIHdvcmxkIHNlcmllcy4NCj4gLS0tDQo+IEJhc2VkIG9uIDUg
c2VyaWVzIGFuZCAxIHBhdGNoOg0KPiBbMV0gdjMgZG1hLWJ1ZjogaGVhcHM6IEFkZCBNZWRpYVRl
ayBzZWN1cmUgaGVhcA0KPiAtIA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmll
cz04MDkwMjNfXzshIUNUUk5LQTl3TWcwQVJidyFsWUdXZmpqSUJseEp2d0JYV3l4SFR5YzJ2ZXc1
WWFncVRfcUpacllPTlRIMjBoOTVxeEMzUEg5VjkxdmpwbFlVM1MwYXlzZXlIcHhSUUZTcUFUSGdE
blUkDQo+ICANCj4gWzJdIHYzIGFkZCBkcml2ZXIgdG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gZGVj
b2Rlcg0KPiAtIA0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LW1lZGlhdGVrL2xpc3QvP3Nlcmllcz04MDczMDhf
XzshIUNUUk5LQTl3TWcwQVJidyFsWUdXZmpqSUJseEp2d0JYV3l4SFR5YzJ2ZXc1WWFncVRfcUpa
cllPTlRIMjBoOTVxeEMzUEg5VjkxdmpwbFlVM1MwYXlzZXlIcHhSUUZTcTlUWE1TSVEkDQo+ICAN
Cj4gWzNdIHY0IHNvYzogbWVkaWF0ZWs6IEFkZCByZWdpc3RlciBkZWZpbml0aW9ucyBmb3IgR0NF
DQo+IC0gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5r
ZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvcGF0Y2gvMjAyMzEyMTIxMjE5NTcuMTky
MzEtMi1zaGF3bi5zdW5nQG1lZGlhdGVrLmNvbS9fXzshIUNUUk5LQTl3TWcwQVJidyFsWUdXZmpq
SUJseEp2d0JYV3l4SFR5YzJ2ZXc1WWFncVRfcUpacllPTlRIMjBoOTVxeEMzUEg5VjkxdmpwbFlV
M1MwYXlzZXlIcHhSUUZTcWtPNF8wYWMkDQo+ICANCj4gWzRdIHYyIEFkZCBDTURRIGRyaXZlciBz
dXBwb3J0IGZvciBtdDgxODgNCj4gLSANCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9saXN0Lz9z
ZXJpZXM9ODEwMzAyX187ISFDVFJOS0E5d01nMEFSYnchbFlHV2ZqaklCbHhKdndCWFd5eEhUeWMy
dmV3NVlhZ3FUX3FKWnJZT05USDIwaDk1cXhDM1BIOVY5MXZqcGxZVTNTMGF5c2V5SHB4UlFGU3Fj
WGRLblhVJA0KPiAgDQo+IFs1XSBBZGQgbWVkaWF0ZWssZ2NlLWV2ZW50cyBkZWZpbml0aW9uIHRv
IG1lZGlhdGVrLGdjZS1tYWlsYm94DQo+IGJpbmRpbmdzDQo+IC0gDQo+IGh0dHBzOi8vdXJsZGVm
ZW5zZS5jb20vdjMvX19odHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgt
bWVkaWF0ZWsvbGlzdC8/c2VyaWVzPTgxMDkzOF9fOyEhQ1RSTktBOXdNZzBBUmJ3IWxZR1dmampJ
Qmx4SnZ3QlhXeXhIVHljMnZldzVZYWdxVF9xSlpyWU9OVEgyMGg5NXF4QzNQSDlWOTF2anBsWVUz
UzBheXNleUhweFJRRlNxcUdNMDhhRSQNCj4gIA0KPiBbNl0gdjMgQWRkIENNRFEgc2VjdXJlIGRy
aXZlciBmb3IgU1ZQDQo+IC0gDQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtbWVkaWF0ZWsvbGlzdC8/c2VyaWVz
PTgxMjM3OV9fOyEhQ1RSTktBOXdNZzBBUmJ3IWxZR1dmampJQmx4SnZ3QlhXeXhIVHljMnZldzVZ
YWdxVF9xSlpyWU9OVEgyMGg5NXF4QzNQSDlWOTF2anBsWVUzUzBheXNleUhweFJRRlNxX1lYVEg5
QSQNCj4gIA0KPiAtLS0NCj4gQ2hhbmdlIGluIHYzOg0KPiAxLiBmaXgga2VybmVsZG9jIHByb2Js
ZW1zDQo+IDIuIGZpeCB0eXBvIGluIHRpdGxlIGFuZCBjb21taXQgbWVzc2FnZQ0KPiAzLiBhZGp1
c3QgbmFtaW5nIGZvciBzZWN1cmUgdmFyaWFibGUNCj4gNC4gYWRkIHRoZSBtaXNzaW5nIHBhcnQg
Zm9yIGlzX3N1ZWN1cmUgcGxhbmUgaW1wbGVtZW50YXRpb24NCj4gNS4gdXNlIEJJVF9VTEwgbWFj
cm8gdG8gcmVwbGFjZSBiaXQgc2hpZnRpbmcNCj4gNi4gbW92ZSBtb2RpZmljYXRpb24gb2Ygb3Zs
X2FkYXB0b3IgcGFydCB0byB0aGUgY29ycmVjdCBwYXRjaA0KPiA3LiBhZGQgVE9ETyBsaXN0IGlu
IGNvbW1pdCBtZXNzYWdlDQo+IDguIGFkZCBjb21taXQgbWVzc2FnZSBmb3IgdXNpbmcgc2hhcmUg
bWVtb3J5IHRvIHN0b3JlIGV4ZWN1dGUgY291bnQNCj4gDQo+IENoYW5nZSBpbiB2MjoNCj4gDQo+
IDEuIHJlbW92ZSB0aGUgRFJJVkVSX1JETkRFUiBmbGFnIGZvciBtdGtfZHJtX2lvY3RsDQo+IDIu
IG1vdmUgY21kcV9pbnNlcnRfYmFja3VwX2Nvb2tpZSBpbnRvIGNsaWVudCBkcml2ZXINCj4gMy4g
bW92ZSBzZWN1cmUgZ2NlIG5vZGUgZGVmaW5lIGZyb20gbXQ4MTk1LWNoZXJyeS5kdHNpIHRvIG10
ODE5NS5kdHNpDQo+IC0tLQ0KPiBDSyBIdSAoMSk6DQo+ICAgZHJtL21lZGlhdGVrOiBBZGQgaW50
ZXJmYWNlIHRvIGFsbG9jYXRlIE1lZGlhVGVrIEdFTSBidWZmZXIuDQo+IA0KPiBKYXNvbi1KSC5M
aW4gKDEwKToNCj4gICBkcm0vbWVkaWF0ZWsvdWFwaTogQWRkIERSTV9NVEtfR0VNX0NSRUFURV9F
TkNSWVBURUQgZmxhZw0KPiAgIGRybS9tZWRpYXRlazogQWRkIHNlY3VyZSBidWZmZXIgY29udHJv
bCBmbG93IHRvIG10a19kcm1fZ2VtDQo+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGlkZW50
aWZ5IGZsYWcgYW5kIGZ1bmN1dGlvbiB0bw0KPiBtdGtfZHJtX3BsYW5lDQo+ICAgZHJtL21lZGlh
dGVrOiBBZGQgbXRrX2RkcF9zZWNfd3JpdGUgdG8gY29uZmlnIHNlY3VyZSBidWZmZXIgaW5mbw0K
PiAgIGRybS9tZWRpYXRlazogQWRkIGdldF9zZWNfcG9ydCBpbnRlcmZhY2UgdG8gbXRrX2RkcF9j
b21wDQo+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGxheWVyIGNvbmZpZyBzdXBwb3J0IGZv
ciBvdmwNCj4gICBkcm0vbWVkaWF0ZWs6IEFkZCBzZWN1cmUgbGF5ZXIgY29uZmlnIHN1cHBvcnQg
Zm9yIG92bF9hZGFwdG9yDQo+ICAgZHJtL21lZGlhdGVrOiBBZGQgc2VjdXJlIGZsb3cgc3VwcG9y
dCB0byBtZWRpYXRlay1kcm0NCj4gICBkcm0vbWVkaWF0ZWs6IEFkZCBjbWRxX2luc2VydF9iYWNr
dXBfY29va2llIGJlZm9yZSBzZWN1cmUgcGt0DQo+IGZpbmFsaXplDQo+ICAgYXJtNjQ6IGR0czog
bXQ4MTk1OiBBZGQgc2VjdXJlIG1ib3ggc2V0dGluZ3MgZm9yIHZkb3N5cw0KPiANCj4gIGFyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTk1LmR0c2kgICAgICB8ICAgNiArLQ0KPiAgZHJp
dmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kaXNwX2Rydi5oICAgICAgIHwgICAzICsNCj4gIGRy
aXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZGlzcF9vdmwuYyAgICAgICB8ICAzMSArLQ0KPiAg
Li4uL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Rpc3Bfb3ZsX2FkYXB0b3IuYyAgIHwgIDE1ICsNCj4g
IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2NydGMuYyAgICAgICB8IDI3NA0KPiAr
KysrKysrKysrKysrKysrKy0NCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJtX2Ny
dGMuaCAgICAgICB8ICAgMSArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RybV9k
ZHBfY29tcC5jICAgfCAgMzAgKysNCj4gIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHJt
X2RkcF9jb21wLmggICB8ICAxNCArDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2Ry
bV9kcnYuYyAgICAgICAgfCAgMTMgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19k
cm1fZ2VtLmMgICAgICAgIHwgMTIyICsrKysrKysrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0
ZWsvbXRrX2RybV9nZW0uaCAgICAgICAgfCAgMTYgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlh
dGVrL210a19kcm1fcGxhbmUuYyAgICAgIHwgIDI2ICsrDQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVk
aWF0ZWsvbXRrX2RybV9wbGFuZS5oICAgICAgfCAgIDIgKw0KPiAgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19tZHBfcmRtYS5jICAgICAgIHwgIDExICstDQo+ICBkcml2ZXJzL2dwdS9kcm0v
bWVkaWF0ZWsvbXRrX21kcF9yZG1hLmggICAgICAgfCAgIDIgKw0KPiAgaW5jbHVkZS91YXBpL2Ry
bS9tZWRpYXRla19kcm0uaCAgICAgICAgICAgICAgIHwgIDU5ICsrKysNCj4gIDE2IGZpbGVzIGNo
YW5nZWQsIDYwNyBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkNCj4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NCBpbmNsdWRlL3VhcGkvZHJtL21lZGlhdGVrX2RybS5oDQo+IA0K

