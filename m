Return-Path: <linux-kernel+bounces-389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DC2814064
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 04:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A6F01F21699
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758F46B7;
	Fri, 15 Dec 2023 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BCJ/pJiB";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="YDAdfxQN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3617C46A0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 03:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 01f2efd09af711eeba30773df0976c77-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=ySycACDlMX/yFBk9soAlL/5iVYHvxmYfXkh+YUNzJVY=;
	b=BCJ/pJiByn4AM40cZDSTSVSOOGnV7gGf3fZMfmwbHO2AwzHzWta2PK3J+uZZ8uVpaS7arcpc5NE9rf5x9jEH5PnDzpycHAX5yPBjohq1XE6Pe7bFXEzr7kDaExB17BYMYb1pnAa1dL6Ea0y61kC2NOR65ATGrgsr6u1m4lS2eng=;
X-CID-CACHE: Type:Local,Time:202312151047+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:02abf95b-6fa0-49d0-acd1-83a344a824a1,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:b0a23861-c89d-4129-91cb-8ebfae4653fc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 01f2efd09af711eeba30773df0976c77-20231215
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1392335946; Fri, 15 Dec 2023 11:06:57 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 11:06:55 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 11:06:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jcBoFunaeMpwWY14BrUi73ly4g7f96AIyLtbTo7WSgUhufEsLL/roKQd1tR1nNrFVF1TBVQUVYeL+KE045LPnC1VhAfdePYis34ROSgjYf6te7KT3AvCehCtO4fxj+BOFvgIgUTcG8iH8R5Lc6sa4ruGFTABiaxal3rutinB1sJ6hyhD6djPbIYvrYX6sNi+IbSMAc/Rk4a0G17UBdGSPwYxythZDbRDp4EXPSbE9pHCSmaE/ros9dqjSyC6z+8JB/s9Q7GjTANuLO6uTc8reip/YesW1EHsaCOg8mlLds//jYvBAKWVRe12inkfZot4tpsSCykrzW81xOA/ucCOzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySycACDlMX/yFBk9soAlL/5iVYHvxmYfXkh+YUNzJVY=;
 b=R5zC0XGL3ow1PK19VJv3MrhGnE9jOiO4F4fPCo+UPUq56OQERfd3BrCOLPJrCcZADaCYgHVYk6I2tpdGwEY0LT9uHCChKNsmKI9pFXhv/b2as2JgpTRD3MWAmt04bqDPQBK6rRjIXn+IVm1bDwMk2S0Rd/96NunO9AdRzUVrW2O8uyKKn9rRI6HsR3nPrQqsJNA8JeRhLnM9frXObePJIbhm4fuZFbc5kTrVmlxvq21ORT0dOht4o1wVTwJBpmvDW4gtjnnuvGyyXMp/ByP8617OztxpXHKtw5eHKZr1Lc8Qi2UPEhwLnsgfMpxIjq6bJLPoph5d5O3Jxii0yWPgNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySycACDlMX/yFBk9soAlL/5iVYHvxmYfXkh+YUNzJVY=;
 b=YDAdfxQN7DNe0oslnL47anEQb9Is/pyBfr97xLsdM+ipimLR8NJ/I5/mUAaIFHNlBRDDHD9JpSzZwwDgqsTThd0+GXx2Y+xtYYPcEb/8/Y9oflAsBw06Qo7/yjzDzUJBIHKbXXaHVOQCKqz2S1VH1GnrG3UypUKkg1sOvz1F/9A=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TY0PR03MB8221.apcprd03.prod.outlook.com (2603:1096:405:13::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 03:06:53 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 03:06:53 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "jkardatzke@google.com" <jkardatzke@google.com>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>
Subject: Re: [PATCH 2/2] mailbox: mtk-cmdq: Add CMDQ driver support for mt8188
Thread-Topic: [PATCH 2/2] mailbox: mtk-cmdq: Add CMDQ driver support for
 mt8188
Thread-Index: AQHaLv98fYvzUWxW/0ebLud5gpjav7CppBKAgAAFbQA=
Date: Fri, 15 Dec 2023 03:06:53 +0000
Message-ID: <270eb954c25433da1ae24d2ce219f195e628fdf3.camel@mediatek.com>
References: <20231215023546.6594-1-jason-jh.lin@mediatek.com>
	 <20231215023546.6594-3-jason-jh.lin@mediatek.com>
	 <e2952f5296d57ded1a18a0313bd44412c8e5f6b6.camel@mediatek.com>
In-Reply-To: <e2952f5296d57ded1a18a0313bd44412c8e5f6b6.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TY0PR03MB8221:EE_
x-ms-office365-filtering-correlation-id: 96e7a03b-7953-47ad-3f38-08dbfd1ae3cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bhxRvXxbe3KjahgmWoNzMLmY/q92AP07Lao6n/BmAXPeImpxV+xwJLcqMdKHaRhdr4IllSe1+4oe6mjn0BNmyPPvFQ9pUKu2fZbsGoIkt+X3QzIyPhfRcvL6tWwGKet6HsbDIPPigoIS1RPm8YlPR9TRU3jDQrhkCPAIySOvKkJcNCjPb38V0mSdpaLRY/g7toC1baSq9c++DoZTxdIf9LlZO7iUmDYsObIWHsWVe7vcB/Jh2bGIncOAHyHuaAi8rpPkiQtIEZSKjI9uM+FsW7VpIk+S3Iq5rTp9SIbmImSh9TOUY2zVH3EOC8RvlvcsAReNIxndJp8ArPn9Pyn0H3TxGdgLeWSMDpCMfkOqC8pfGIx9hj9j43+fHK8OlqbCKgBSirKO6M7CqY4k3nbd2vX7uBgmmhJuyVR5VZgqC+9wlc++3yMkQ74zg0Jn/BZIpd+8h5cGlJ32CxIGe20CfoxRNedfrWlU+Fsv1KgHQksxm+CT9NZBlTJ+JxquLmEDZZErACd9HaXafSYwRSex3nc7rgv777A/SOUZUGpV219OcuzTUwaGNbrpiNtNGhDY0+XnLVHK9ehY3vebvzkPSQj4yPFTWssNB9d15sggIu2aKLxTXLEse+DMe8m4m/yUALvoryLgR20s/bws7KuLZxKFopamZ5nh66YKbcVIi3I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(83380400001)(38100700002)(41300700001)(76116006)(110136005)(91956017)(66556008)(66476007)(66446008)(64756008)(66946007)(54906003)(2616005)(26005)(86362001)(71200400001)(122000001)(38070700009)(6512007)(4001150100001)(6506007)(478600001)(6486002)(2906002)(316002)(15650500001)(36756003)(8936002)(8676002)(4326008)(85182001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUxqVnBiTXpRNTNsUmpiNldUcS9ZWDZRNng4ZEtCUmVMMEFqZWpIdjdUWW5J?=
 =?utf-8?B?T2creGRJOXpmUWcyeGtDZmgxdXJOOVhHM2R3aEptb0U5TDNTV29SaEpxK3pB?=
 =?utf-8?B?M2FhUkpRK0ZUK0dRaWlBVUtabTdjNmRJdUVXMUVFNVdIWXFvZXJmVzF5MXFy?=
 =?utf-8?B?eTRMTnpaWWd0WG9hQXhqWm9pdXprdVdnOHUxaHIzK21DdXZjOVJJSW10Nis0?=
 =?utf-8?B?cCtZMTJTUzlPR2phTklTYmJqTW9CY3hWVE9SSGl4QldyTDhtVCtYYmN1Ni9N?=
 =?utf-8?B?WEpuekRQWTRrMWd2eWFaRkp5UXN5VlZjNU5HdDY3UEJPM2pCbjF3d21EWmhT?=
 =?utf-8?B?V2RkYnhycEN5NjdteDh4dTc2K0IzUFhhZHZHeGxublpud3lKNFJsa2E2eE9S?=
 =?utf-8?B?STltdGVneGVIOU5wMUdtVHhiM3pFVHRmY05VV05lTmZ5cTBaZ3VZOFNEei83?=
 =?utf-8?B?Z2V5VHk1SDBucnBYeUZoaDBJZTNQbXpnNUVhb3pLZkkyUE1ubWxXUWtWbGdh?=
 =?utf-8?B?dHQyOGtMVU55Q01mWmFqc1RXMXpBV1E4YzNzNmtydGdSWHlJejFDUysxQ2t6?=
 =?utf-8?B?eVNXS0FueGltRUtMdDVZVUdCalpQUGdGZFQ0Ykx1ekFBUzY2TlZ6aGZyN044?=
 =?utf-8?B?Zjk5N0JhWlZDUlZNbmVVMmQzeUFVcEtIMlBHeGtWclI4NjNYRllRWUczRVNm?=
 =?utf-8?B?b2tjYitDSU8zbVhQWWszQjFBOWpXWVpZM0dVcHdqODNMbDhKNzE4U0h5dlpo?=
 =?utf-8?B?Y0ZHTGZ3TUVlSXhKN3pZNGdOK3BQdE96Y2FMUzh1Qi9zRk5MYk1oOGhSNDFw?=
 =?utf-8?B?aHNIR1hzRDh4ZEpJV1hWTFF5NnMxMTdzZjBTYmd1U3U0RWU5STZZZEdLSnpS?=
 =?utf-8?B?U3lTSVhqeEZSUndNL09NeWNXL3U1ZWk4dU5FODc5dzFPcVdTTkFSSmdoMHJF?=
 =?utf-8?B?UjA3eFJJdFBWVThIRDhKVWhwVWhra3Zja0xLVmNuQXpESUZicnd4Q0dZMlh4?=
 =?utf-8?B?OUVFU0xxbmdzQ2hDWTE3QzVyR01lN1QzWGdlTzhYbDVSUjBOeGJSNmk3eFBx?=
 =?utf-8?B?RjhkL21GRFhtUEk5dU1SeTJyYjUvNFNHbzlGZUxmUk9SYy9uUFNMUXFhUW5I?=
 =?utf-8?B?c0djcHpzS0p2dnY3V3hpb0tuRjdXbUZzTXlLazVLN2thUjFuZm1INWZKYWFW?=
 =?utf-8?B?eW16SkxVS1paQ2xXWWpXOWd2N08xcnl2NUJzc1VFSVU3Vkw3RzZFcGRBcS93?=
 =?utf-8?B?V3JqSDBPQ1pScVY4em56MmVWN083eFpGVVRybE9rM1FOTnVuNkRpNVMwdXVz?=
 =?utf-8?B?R3lWSkZaZysrUzNINE1uSGtHWWJxT1d2QTNyL1FqMXRjdmw5YndOSmdEckhH?=
 =?utf-8?B?VzZla1kvbUVBU1FiNVNwelljS05jRGZKNk9vM2NIbTRzdmNxZ3V3YlpIMC9H?=
 =?utf-8?B?SnVkeXoyN0xhOGQ0QzJnMGdKTFVEVlkxRzdzQTYrazc1VTVqZjFsbHY0WjRF?=
 =?utf-8?B?Qi83UXVkM0hCSWd1T1g3azZNaGI2dys5eW1OSTltZ3RKR3VPSFNYTkVwNWZZ?=
 =?utf-8?B?cUdGQW1pNUJqVkt0ZFYzODlUY0xtTHZqWjB3bUlzWnJnSlRDWEJFYTh5MWls?=
 =?utf-8?B?bzZxdVNJSGc4MGhNY08vVWNZcHYzUzU0RGVyTWpEeFErcnpKS29Ta3l1ZmZZ?=
 =?utf-8?B?dUNLSDVzNGh1OS9ibWtRRDArSHppMDNoMThnVklCb2YvRVZLQks0eHlEOXpz?=
 =?utf-8?B?N2tRSGt1Q01JRkU3d0twQU8rNm9ZTVJNaFhsWVRPQzBnd1JyU09VSmd3UlVq?=
 =?utf-8?B?enFCUFFHSWo4OExBWFlWc1pQcjZ1dTFaMzlSS0F0ZnoxbzlFcHp6NnlSam9p?=
 =?utf-8?B?U0x3eWh4aDUxeFdXUmtiUkJNRmErZ3lqZXc1TDdVT0UvL0FZd1ZRNUJ4Mkpm?=
 =?utf-8?B?QUdiOGZ0QkNSSnpRRXNDSzF0K0ZabkZhcSt5T3NXcHlZc0ZIVi9WalBsRzZT?=
 =?utf-8?B?bFVwZEpNT3JVNzBybGZRYytrbkY3bC8rb3FydlpPK2gwdVdLYzBEcGZ0TlVT?=
 =?utf-8?B?QlpGcEN6TlFlM1dqUTl6WkEySE9pc1Y0aitVUFRaKzUydHZ5QmtBNVpVZmxR?=
 =?utf-8?B?Y1hQNVRPby9vUmtLSDZnNURIQWRUUWR2Mi95TE9sVWdOZVFCQlVKaU04Z3A1?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4D6B8F2589F1084A80423986D271403C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e7a03b-7953-47ad-3f38-08dbfd1ae3cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 03:06:53.5619
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cE2U9Rr2Tmn1wf/So6gMvp6LIzI4nkny1UtuH8heX2RuK0oqqRza8RD4SlHTY/Eu02PhhdF7Iz3Yt0RSVVlH79CnLjuDHSC5A7W2GcUuAbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB8221
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--16.700700-8.000000
X-TMASE-MatchedRID: +c13yJDs902nykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/mNRhvDVinv6Sx
	VUPqsOdUXuAgXl+qfJ2OIOE+FQsMqT13WcdbGR6Q4pdq9sdj8LWuiRuR9mCausJVPwCLMZ4Ua0I
	EkYOsokWVVJ7XHOXuSJcZ0icLp7DqQv21zJNl0CyDGx/OQ1GV8t0H8LFZNFG7gFAtZqE+Xpx+3B
	ndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.700700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	80E10D6730CADEC55FB7668E4C913394579AD16D3AAB7D241660EF34DF134D172000:8

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIEZyaSwgMjAyMy0xMi0xNSBh
dCAwMjo0NyArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0xMi0xNSBhdCAxMDozNSArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IEFkZCBDTURRIGRyaXZlciBzdXBwb3J0IGZvciBtdDgxODggYnkgYWRkaW5nIGl0cyBj
b21wYXRpYmxlIGFuZA0KPiA+IGRyaXZlciBkYXRhIGluIENNRFEgZHJpdmVyLg0KPiA+IA0KPiA+
IFNpZ25lZC1vZmYtYnk6IEphc29uLUpILkxpbiA8amFzb24tamgubGluQG1lZGlhdGVrLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyB8IDggKysr
KysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gYi9kcml2
ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ID4gaW5kZXggNzZlNWY3NjI2MjhjLi42
MTJiOWZlYjI1OGEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1h
aWxib3guYw0KPiA+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21kcS1tYWlsYm94LmMNCj4g
PiBAQCAtNzQ5LDExICs3NDksMTkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2Vf
cGxhdF92NyA9IHsNCj4gPiAgCS5nY2VfbnVtID0gMQ0KPiA+ICB9Ow0KPiA+ICANCj4gPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF92OCA9IHsNCj4gPiArCS50aHJlYWRf
bnIgPSAzMiwNCj4gPiArCS5zaGlmdCA9IDMsDQo+ID4gKwkuY29udHJvbF9ieV9zdyA9IHRydWUs
DQo+ID4gKwkuZ2NlX251bSA9IDINCj4gPiArfTsNCj4gPiArDQo+ID4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIGNtZHFfb2ZfaWRzW10gPSB7DQo+ID4gIAl7LmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ2Nzc5LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gPiAqKSZnY2VfcGxhdF92
NH0sDQo+ID4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdjZSIsIC5kYXRhID0g
KHZvaWQNCj4gPiAqKSZnY2VfcGxhdF92Mn0sDQo+ID4gIAl7LmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTgzLWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gPiAqKSZnY2VfcGxhdF92M30sDQo+ID4g
IAl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4g
PiAqKSZnY2VfcGxhdF92N30sDQo+ID4gKwl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4
LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gPiAqKSZnY2VfcGxhdF92OH0sDQo+IA0KPiBJIHRoaW5r
ICd2OCcgaXMgbm90IHRyaXZpYWwgZm9yIGFueW9uZS4gRXZlcnkgU29DIGhhcyBlYWNoIHNldHRp
bmcsDQo+IHNvDQo+IEkgd291bGQgbGlrZSB0aGUgbmFtZSB0byBkaXJlY3RseSBzaG93IHRoZSBT
b0MgbmFtZSwgc3VjaCBhcw0KPiAnZ2NlX3BsYXRfbXQ4MTg4Jy4gU28gZG9lcyBvdGhlciBTb0Mu
DQo+IA0KDQpPSywgSSdsbCBhZGQgYSBwYXRjaCB0byBtb2RpZnkgZ2NlX3BsYXQgcG9zdGZpeCBm
cm9tICd2MX52NycgdG8gdGhlIFNvQw0KbmFtZXMuIFRoZW4gYWRkICdnY2VfcGxhdF9tdDgxODgn
IGZvciBtdDgxODguDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBSZWdhcmRzLA0KPiBD
Sw0KPiANCj4gPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTItZ2NlIiwgLmRhdGEg
PSAodm9pZA0KPiA+ICopJmdjZV9wbGF0X3Y1fSwNCj4gPiAgCXsuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTUtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiA+ICopJmdjZV9wbGF0X3Y2fSwNCj4g
PiAgCXt9DQo=

