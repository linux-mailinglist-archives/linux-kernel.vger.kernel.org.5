Return-Path: <linux-kernel+bounces-12896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326D481FC54
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 02:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCA6285E00
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 01:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4872617C0;
	Fri, 29 Dec 2023 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n9DCibkL";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Co3WR0TN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24092137F;
	Fri, 29 Dec 2023 01:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5f7bbad6a5e911eea2298b7352fd921d-20231229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UB9FV4Zh3w7vsXP7MgduU31Cz6sRW+ibus/Q4YAzwhc=;
	b=n9DCibkLjrTp1n0XMgN5Emqy4lVatAQw8UCYa4rXNTYZZ7oSABJCufVACbGib0TBDdBUpAINvWfExzMKfBFHIHxRS4OEGvs13y+VDfD9+txuueCCHyjt9+ru/uMcTZ9Ng6yRLyr6jkwi2K6AW3grMc0moprOoAVce/R3xulHmS8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:16907f1d-8ef4-49c1-8710-a28db673bbdb,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:a7c0ae8d-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 5f7bbad6a5e911eea2298b7352fd921d-20231229
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 968745390; Fri, 29 Dec 2023 09:27:04 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 29 Dec 2023 09:27:03 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 29 Dec 2023 09:27:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bukdZyq3O41YH288TtMGtEsCYHis++ZbG+xDjl67WRgEzmV3M3VCg2QhDJJZcwHKxjFVyJ0E1RkXgLE8nqJ7PvJgJyV0gHCac7rvhMu0PW73YVwZlennHJscpSc/rKja0lhUsdKXkbhDRFndqEftbUTWDF9sVbAcbzMb3uNQIaVqnGti1q2SFdinLgKmkSTRxGaplw8U5d2wknYpd85YMgwHdyJ9tMDi+H/PurcDlopMTdkCTb3YpJKW07Q5DqhHEcmd+nFmgxJOqOcw8QanpIjaU1wrEHY5l+9RTpWaKgGbUhKzSYS968900ynJHqpu7RfxXA15mo36y2pIE9Hxog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UB9FV4Zh3w7vsXP7MgduU31Cz6sRW+ibus/Q4YAzwhc=;
 b=LbDIKtO27HxbF6BNb4oPdO1Ya7CQ8sQTm8sCICEk7GRYCd5QwPdio9YiSFVhP8zmbGXe4l27dg+wgj1rvuK5B0hEKDp7tODgBtEmW9QesB7shGnUdCRwHvUmu2YNIfXMg+R+NhGWAQh3kk4h05P3AaewXW1iv/sUrzZfktCwHAnntrCX86M73WM6YqN80iltAiGc2ht0jUgq6tldmBuPD/iiXLXDLFqLUEbmO1//qthEUVdjt4cQZjpgEdLZ66sViPJXnwOZjVFziWwK8AtGxfLnajRbCLM8tBa/6gs9H/H/vg3c0a8HptWUX3s/z9lcmLXBp7ga0PsdM68kHYlCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UB9FV4Zh3w7vsXP7MgduU31Cz6sRW+ibus/Q4YAzwhc=;
 b=Co3WR0TN16MXvHkavmUVD2Vhbe1GPtasN5w+FHhMREnWl+SwkAU+3mqY/O9x8mWlkVfIUEreDxLcWMbsPr6Flpd7UPVD6Ydb0e5gV0ZUNCM1RT/RmZbxikUHMmstaY3Q/zCjV6UTaU1wl7pYuDTELAapSVunH3ovxhd2tsDD3e8=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5302.apcprd03.prod.outlook.com (2603:1096:301:40::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.21; Fri, 29 Dec
 2023 01:27:01 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 01:27:01 +0000
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C/gxcA
Date: Fri, 29 Dec 2023 01:27:00 +0000
Message-ID: <1b21f5bfa561b049193742804de42a1c03500a73.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5302:EE_
x-ms-office365-filtering-correlation-id: 1d67aca3-45c8-4fc1-7c48-08dc080d41b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8JsdUz6K9zGwxTyLp9TRSfccH6ckMzbpZmdND9VC0EAJo30SDwqKKPXwf25vOYOPCIkZhBQZJuCEAB0B+G96nnOWtCO4LjDiSQb984PMk4b0p2wHl3kstoywWr51oGgsDrA3e+xMMt2liZKyNmjW9sEfRIb61lp8VS5n1mpZYVdxyDpCDl7UlGZsKzJWtK3eoyUX8woSNWrDa5C633I6os9ZquCSY/0tQIX5NOwfTOMe5ReF60ogaY+ypwR+vPvUExT7dk3FO9gCb2WJK6NuAjG5oFcDe+4/oL857k+Zm9DXegTrYXN2JjAgjSo1YQaDRXP94BdZAStxtlGYlmDK6gR9oPek0HutR1S0DivfjSeSzrRKE/oWXV1pMeb2qr40iP//NRn2reIvM3Mg7N/GLAGdFJb4u/sFxV0lhbwa2acl1KRnu9iBWwufA6bLdcLxHi4nrogZ+Rr/Qb+CuSNbGrgkYekrHBRIniNStlndaoPAvtGoP3+JDAJPdiLrJER+Ts9u+n6QNnJxN3d61B/IO7DlfG/o4VdLVQN3FTS99yDkJcKCDX21xjj/1N4IILfksMNDhsXYqeojdvcLYKLQfG5VcVgJ+Fmly8XgXwIvkYv6wnirPyKIyXXuxdfNTIMv1sRYofMdh6BIvJ4Fix4hQHunxYq+fKmpBACES+Q1KoI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(41300700001)(83380400001)(2906002)(4001150100001)(54906003)(66946007)(76116006)(66476007)(64756008)(66446008)(66556008)(110136005)(316002)(6512007)(38070700009)(122000001)(71200400001)(6506007)(478600001)(26005)(2616005)(38100700002)(86362001)(6486002)(15650500001)(5660300002)(7416002)(8676002)(8936002)(85182001)(4326008)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHAyRjV0eFliRnp4T2RiNVVza0RVWnQySmRISkRsNGxIMzljR3czcGVDampD?=
 =?utf-8?B?WHlVVTFqaHpVSkZzQm5INTV0eHZaSWVINUE4UGd0VU9pbzZUbUx2QllDdXc2?=
 =?utf-8?B?cU1TMzkydjV2SjIwUmI1dHdPMnREdnJWRXB1S2c5TFgrdGxXclltTVgyd0J1?=
 =?utf-8?B?Z2lEd29TNHFmZy9LSlZ1ZVN4RnhYUU5JdlFKN2tUOWZocXFaRjMybzI1ZlRG?=
 =?utf-8?B?dUFpZDFBODJhazBXejBpVlZIcFAxTnROUGJ4eVVvdHZPd1NsMXJWbFgwdXpv?=
 =?utf-8?B?NUNaTUxjL1dWM1o3aTY2ekF6OUNhYXZVSTI4OENTUDZaS0dMbjRxSE1KVVNx?=
 =?utf-8?B?NUlVYThsd0RKaUNDMWc0SCtVbWlmNEtuVnFxZGpwaC9HeUlVdzBIejE1VTVv?=
 =?utf-8?B?a1ZVMDVIaXBaRHlPNFMwOWI2Wm1uUXVJVzVUZ2xiKzdQQTNtQ01HeURyS1p3?=
 =?utf-8?B?SlRuaTRrNWd1aGZPWjF2dkVLYnpMdDRvTXMvYTlsbG5rV1NLNU9VbGtQdDhs?=
 =?utf-8?B?azVQN0RHVWlpWnRDdTBFME5lWjFPKzBKbjJ6UythM010d2tZbzBpb2JXUjBS?=
 =?utf-8?B?c3pYTG1RV3RkTEZTeWVTaVhvd2dEUnVvU3BVeEtXREVhVlNpWFNZS3hSSWZY?=
 =?utf-8?B?ZjZ2TEQ5eWJ4eWQ2aDJYcnQ5L3NqVlRBREk2QmFsUFZRdG1DK2hxQVR6cFdG?=
 =?utf-8?B?Mzh4aGhoWWRrQVBVNE1md2NlV1FpRVo1UG4wOUlKajZyZzRUWis0MnR2bGlV?=
 =?utf-8?B?ckZxbkwzWk4yU2M0R2UyVituTWNDTmQ4Z0Y3c096azI2K1NIQ2J0cnVWeVAw?=
 =?utf-8?B?cExCNlBHRHRJNlIyNys3TkV2bk53RTl5b25mRDRQWVBETkxzZ3JyUHoxYXJj?=
 =?utf-8?B?QjB3ZnNFNXpKM2JvditjWk80RUwzdXRBSGFpaE1ONCswanFDeGptVURrZXhB?=
 =?utf-8?B?Z25SYWNreDZVVlJuV2hrakZGWXVDSW9WWGp1WWRnNmhpQ0hzSXIrYTVJSVBo?=
 =?utf-8?B?VnhWYmJRSFpOZXh0YzBOZFZ3Q0h1YjN5SWwyZE4wMmxmdklZTUk0YVdWZnBi?=
 =?utf-8?B?OTJvUm1yNkVrZE5DLzlzMUdlMmNZays4WTdCdFlmaWh2TUI2eWJ0RlpHbzZG?=
 =?utf-8?B?MmdFY3BDY0kzYnNZTjNBUDRYZ1BFZVROMHdRV01OclFCREx0dTBFZFU2NWx3?=
 =?utf-8?B?c3RKMUFxUzZMM2VzQlVzb25Ta0QwYlhzcnVFcjJ2dllBUkhSd0crQjdpZEUx?=
 =?utf-8?B?SGZzYnZJZHJJQW9yaXJTYVpMbHZlcTlESUxnanIzQjJ6TEJKVE1qRUQxTjd0?=
 =?utf-8?B?Qm85MHdTTGFrVEFZZDFtM3RaVTlqU2kwZXlnUXlNSzN1dzV5Q1VPWkxqMHdQ?=
 =?utf-8?B?am40dXMwSDZqcEdMelFaZTF0ak9KZ2FXMnJZZVFZREJDTERmeGJ0THZlWE5u?=
 =?utf-8?B?SFNHY3VvM2VMQ0lhUGUvallwVi91Ly9tMHI4d0N6Z2Vadm50ZTMrYVZQbmZI?=
 =?utf-8?B?UXZydkExc0N2QXptRlFwV1MyRWtTQjkrc2dMSm40NWgyLytnanJhUm53MG5P?=
 =?utf-8?B?aE50dEsraDVyRlJlODVDMmhBS2JZNEFsNUs5RVJWcDRvVUFQNTZSTlJBTTIx?=
 =?utf-8?B?ZkczTjdoUWNNTGkzYVpiT0o3MEhobDUwNklPalJ6L3NLUGtyTHBtSk9qTlUv?=
 =?utf-8?B?S056SUtLbmtlazdwSnV0Qyt3ZVRXYnU5NVVjVHpQYU44SkZ4TFQ3OVN4d25r?=
 =?utf-8?B?RmEvcEJWS2xkV3NOUjZmN1MvTmRqN0RUU0FaU0ZEZDcyQ0RmaDR2THJDWFVr?=
 =?utf-8?B?TmVFUURENW5GNXMvYWFLdlJsc0VCc0xWODNJbmZxT0t4aEliSDhUM0VPeGFi?=
 =?utf-8?B?TUt0NVM4RWxJcnRvSUlkRkpxblUzYTNTa1UwZTVWTGpBTWhvQSsyR1NvcURZ?=
 =?utf-8?B?MHVhc3RpTDZWK25YTkRPZFlHWk5Za1BKZWhpdXg5MStPbkxLUlhUdkNzVVdV?=
 =?utf-8?B?UysxWmlLV2FlakNpNDcrYlZJZytMSEcySTY2VjI5QmpPT2pHSnBFamsxeUNG?=
 =?utf-8?B?bHI3Qllzc2pmeWI5dXNuTEhhSzJoQjB0Q3l6c09mM0lEZjNObUtBVkZZQy9n?=
 =?utf-8?Q?A/nIMZ/YA7w3T15GF+WHwKtqF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D4A100A98650649AF99087C1404DAD7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d67aca3-45c8-4fc1-7c48-08dc080d41b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 01:27:00.9758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/0aCcY6tFGJYmmJOXRxkfvn1E3CwNrezVfn7FsOG0ZcVOn69IdUNwBq/JifSTluW2/7mc6xcm64pcRhgqm80A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5302
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.298800-8.000000
X-TMASE-MatchedRID: QfHZjzml1E8OwH4pD14DsPHkpkyUphL9qQ9UezeTkThu4FknyqyshF1Q
	po5pNysMe29pTfBhqOY7b3Js3F6vVD1LciJB3541o65WJt1k1O8TbU1KYGoQp3vsbfoZixUT3oz
	JRX7b4NlXDMdLGLREMMXK8CR3a95BwkdUVZ4wAsQdxBAG5/hkW9qgUkBwIfKYrcsFdtecvlP6p1
	jlhLAJAvcqU4dInnrp5tlnPJX7htRoAILruplAqrdQIb8hCnY+I7OxeNfmD+wIxs8bpapULKPFj
	JEFr+olFUew0Fl/1pEBi3kqJOK62QtuKBGekqUpI/NGWt0UYPCQjpWlTG6/YrkraxDde6naBUVv
	b7IBJzEH5eyzBoWGRHPmli6osFKp
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.298800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	AD86BE1E1160C73C4DD29A134235C7DBEC29837991A2530FB21E33118AE90AE82000:8

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
PiArDQo+ICtzdGF0aWMgaW50IGNtZHFfc2VjX3Nlc3Npb25fc2VuZChzdHJ1Y3QgY21kcV9zZWNf
Y29udGV4dCAqY29udGV4dCwNCj4gKwkJCQkgc3RydWN0IGNtZHFfc2VjX3Rhc2sgKnNlY190YXNr
LCBjb25zdA0KPiB1MzIgaXdjX2NtZCwNCj4gKwkJCQkgY29uc3QgdTMyIHRocmRfaWR4LCBzdHJ1
Y3QgY21kcV9zZWMNCj4gKmNtZHEpDQo+ICt7DQo+ICsJaW50IGVyciA9IDA7DQo+ICsJdTY0IGNv
c3Q7DQo+ICsJc3RydWN0IGl3Y19jbWRxX21lc3NhZ2VfdCAqaXdjX21zZyA9IE5VTEw7DQo+ICsN
Cj4gKwlpd2NfbXNnID0gKHN0cnVjdCBpd2NfY21kcV9tZXNzYWdlX3QgKiljb250ZXh0LT5pd2Nf
bXNnOw0KPiArDQo+ICsJbWVtc2V0KGl3Y19tc2csIDAsIHNpemVvZigqaXdjX21zZykpOw0KPiAr
CWl3Y19tc2ctPmNtZCA9IGl3Y19jbWQ7DQo+ICsJaXdjX21zZy0+Y21kcV9pZCA9IGNtZHEtPnBk
YXRhLT5od2lkOw0KPiArCWl3Y19tc2ctPmNvbW1hbmQudGhyZWFkID0gdGhyZF9pZHg7DQo+ICsN
Cj4gKwlzd2l0Y2ggKGl3Y19jbWQpIHsNCj4gKwljYXNlIENNRF9DTURRX0lXQ19TVUJNSVRfVEFT
SzoNCj4gKwkJZXJyID0gY21kcV9zZWNfZmlsbF9pd2NfbXNnKGNvbnRleHQsIHNlY190YXNrLA0K
PiB0aHJkX2lkeCk7DQo+ICsJCWlmIChlcnIpDQo+ICsJCQlyZXR1cm4gZXJyOw0KPiArCQlicmVh
azsNCj4gKwljYXNlIENNRF9DTURRX0lXQ19DQU5DRUxfVEFTSzoNCj4gKwkJaXdjX21zZy0+Y2Fu
Y2VsX3Rhc2sud2FpdF9jb29raWUgPSBzZWNfdGFzay0NCj4gPndhaXRfY29va2llOw0KPiArCQlp
d2NfbXNnLT5jYW5jZWxfdGFzay50aHJlYWQgPSB0aHJkX2lkeDsNCj4gKwkJYnJlYWs7DQo+ICsJ
Y2FzZSBDTURfQ01EUV9JV0NfUEFUSF9SRVNfQUxMT0NBVEU6DQo+ICsJCWlmICghY21kcS0+c2hh
cmVkX21lbSB8fCAhY21kcS0+c2hhcmVkX21lbS0+dmEpIHsNCj4gKwkJCWRldl9lcnIoY21kcS0+
bWJveC5kZXYsICIlcyAlZDogc2hhcmVkX21lbSBpcw0KPiBOVUxMIiwgX19mdW5jX18sIF9fTElO
RV9fKTsNCj4gKwkJCXJldHVybiAtRUZBVUxUOw0KPiArCQl9DQo+ICsJCWl3Y19tc2ctPnBhdGhf
cmVzb3VyY2Uuc2l6ZSA9IGNtZHEtPnNoYXJlZF9tZW0tPnNpemU7DQo+ICsJCWl3Y19tc2ctPnBh
dGhfcmVzb3VyY2Uuc2hhcmVfbWVtb3lfcGEgPSBjbWRxLQ0KPiA+c2hhcmVkX21lbS0+cGE7DQo+
ICsJCWl3Y19tc2ctPnBhdGhfcmVzb3VyY2UudXNlX25vcm1hbF9pcnEgPSAxOw0KPiArCQlicmVh
azsNCj4gKwlkZWZhdWx0Og0KPiArCQlicmVhazsNCj4gKwl9DQo+ICsNCj4gKwljbWRxLT5zZWNf
aW52b2tlID0gc2NoZWRfY2xvY2soKTsNCj4gKwlkZXZfZGJnKGNtZHEtPm1ib3guZGV2LCAiJXMg
ZXhlY3V0ZSBjbWRxOiVwIHNlY190YXNrOiVwDQo+IGNvbW1hbmQ6JXUgdGhyZWFkOiV1IGNvb2tp
ZTolZCIsDQo+ICsJCV9fZnVuY19fLCBjbWRxLCBzZWNfdGFzaywgaXdjX2NtZCwgdGhyZF9pZHgs
DQo+ICsJCXNlY190YXNrID8gc2VjX3Rhc2stPndhaXRfY29va2llIDogLTEpOw0KPiArDQo+ICsJ
Lyogc2VuZCBtZXNzYWdlICovDQo+ICsJZXJyID0gY21kcV9zZWNfZXhlY3V0ZV9zZXNzaW9uKCZj
b250ZXh0LT50ZWVfY3R4LCBpd2NfY21kLA0KPiBDTURRX1RJTUVPVVRfREVGQVVMVCk7DQo+ICsN
Cj4gKwljbWRxLT5zZWNfZG9uZSA9IHNjaGVkX2Nsb2NrKCk7DQo+ICsJY29zdCA9IGRpdl91NjQo
Y21kcS0+c2VjX2RvbmUgLSBjbWRxLT5zZWNfaW52b2tlLCAxMDAwMDAwKTsNCj4gKwlpZiAoY29z
dCA+PSBDTURRX1RJTUVPVVRfREVGQVVMVCkNCg0KTWF5YmUgZm9yIHNvbWUgY2xpZW50IGRyaXZl
ciwgMSBtcyBpcyB0b28gbG9uZywgYW5kIGZvciBzb21lIGNsaWVudA0KZHJpdmVyIDEgc2Vjb25k
IGlzIG5vdCBsb25nLiBTbyBJIHRoaW5rIHRoZSB0aW1lb3V0IGRldGVjdGlvbiBzaG91bGQgYmUN
CmRvbmUgYnkgY2xpZW50IGRyaXZlci4gQW5kIHRoZSBleGVjdXRpb24gdGltZSBkZXBlbmQgb24g
dGhlIGNvbW1hbmQNCmJ1ZmZlciBnZW5lcmF0ZWQgYnkgY2xpZW50IGRyaXZlciwgc28gb25seSBj
bGllbnQgZHJpdmVyIGhhcyB0aGUNCmFiaWxpdHkgdG8gZGVidWcgdGhlIGNvbW1hbmQgYnVmZmVy
IGl0IGdlbmVyYXRlZC4gU28gaXQncyBub3QgbmVjZXNzYXJ5DQp0byBkZXRlY3QgdGltZW91dCBp
biBjbWRxIGRyaXZlci4NCg0KUmVnYXJkcywNCkNLDQoNCj4gKwkJZGV2X2VycihjbWRxLT5tYm94
LmRldiwgIiVzIGV4ZWN1dGUgdGltZW91dCBjbWRxOiVwDQo+IHNlY190YXNrOiVwIGNvc3Q6JWxs
dXVzIiwNCj4gKwkJCV9fZnVuY19fLCBjbWRxLCBzZWNfdGFzaywgY29zdCk7DQo+ICsJZWxzZQ0K
PiArCQlkZXZfZGJnKGNtZHEtPm1ib3guZGV2LCAiJXMgZXhlY3V0ZSBkb25lIGNtZHE6JXANCj4g
c2VjX3Rhc2s6JXAgY29zdDolbGx1dXMiLA0KPiArCQkJX19mdW5jX18sIGNtZHEsIHNlY190YXNr
LCBjb3N0KTsNCj4gKw0KPiArCWlmIChlcnIpDQo+ICsJCXJldHVybiBlcnI7DQo+ICsNCj4gKwlj
b250ZXh0LT5zdGF0ZSA9IElXQ19TRVNfT05fVFJBTlNBQ1RFRDsNCj4gKwlyZXR1cm4gMDsNCj4g
K30NCj4gKw0K

