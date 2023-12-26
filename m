Return-Path: <linux-kernel+bounces-11408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D67981E5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3462A282A41
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF8B4CB39;
	Tue, 26 Dec 2023 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="NRzmGcSH";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="c2o75lBq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15064C625;
	Tue, 26 Dec 2023 07:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 744ad5e0a3c411eeba30773df0976c77-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=r0CqfTHdS4OW5p0Wp/Lb+OxK7C/o9ANG1rsG4dEyQV0=;
	b=NRzmGcSHQPB70KVD5eYUJ1zCTUdVUPdbKCxQyXq0HHM2eVV9PUk32pKLiEGG2nlbHOorMX3Vyq4JC6pvC3oz1QWpLRx8K+DSVwGX4EyIBN6P1YRtpa8XVlqu54owjTZtMNVQFXl2wPJILUoU6FA8F6qxu3TrUV6PIvIM+a1Shyg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:005f559a-f2c8-49ab-a929-d370bc9b479e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:99622d82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 744ad5e0a3c411eeba30773df0976c77-20231226
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1880350732; Tue, 26 Dec 2023 15:57:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 15:57:44 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 15:57:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8X4JxOOT9JWHr/xGbm64Xhhra3teoHUOpRxcoPi936DyjtAhZFl2a2a11SGzp/uv7hcOzz5YNYuwZ0HLyDfRFsnJOcOdidIq2ES7HKWko+1v6tSQe4TUemt0uZK245X2kb5tMsmX/f4IfQtm/gd+AwuXsC1e/qkcOlJkyvUO9eq9GMT4V4dk51Ug+tq/qG6RVxm5i0vTRo8MpVnHiSA9/qh/N/i+m7sE9pPNRwMXxQ5XVhC9TtyASKfrNl7m6Ix+6gAFyXvWOWK1lm0S7Jw7wrWP/QYlJnoy0n6QIPg44wfGZ113Tr8nrPsXYoFWTDeOIZlv3tSCuyU7K7XhFJuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0CqfTHdS4OW5p0Wp/Lb+OxK7C/o9ANG1rsG4dEyQV0=;
 b=JIvKi96LigTPiBU0fmQ1mgETeoO7vko+9cZzaxVXQqVz2oTtwmUCj05HrOrvAnoQ/E/msK0nO/9VM9CXWx1STb5xZujyw40vNOGaxE8zXRVdPMxQiam+mYpFEeH71pqMsf6YD+Ie0TCDY/DE4+GPLQ7NoyvXXRIdyDvpX/LbGdkAoC4HntbyjdCprDrrjkr/61cdjYvLg/dnaQDPH056jaDajOwG5NT9Fc9K32LBKgyj256g2UoGMi/GwTfp/osB6UCKLvYu18DbnSUxbND6QsTuamnYR//dzqhvIQ6iLYS2LhI6IKpIadd3jYP3/yYiGcfKXdXoR20xCo1i+4dM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0CqfTHdS4OW5p0Wp/Lb+OxK7C/o9ANG1rsG4dEyQV0=;
 b=c2o75lBqZoCRRIJlYObsmsJuvEKtrlYZcYIp6bGxDrZwR+BrWssieya/3OKaONnjZYNTc9jHflykMgXbKp8kNemhO7Bai0qChrUORoVxtv+dS42PT0VCEG74vUszBBB+MrXwOU6mK3YekBkmWdoFo00UtGX3i/qaUdFcWH0d+0A=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by SI2PR03MB6781.apcprd03.prod.outlook.com (2603:1096:4:1bd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.26; Tue, 26 Dec
 2023 07:57:41 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 07:57:41 +0000
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C7OT6A
Date: Tue, 26 Dec 2023 07:57:40 +0000
Message-ID: <13754f308ce9ff1a9787b2597e416613b638c611.camel@mediatek.com>
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
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|SI2PR03MB6781:EE_
x-ms-office365-filtering-correlation-id: 1052470f-d320-40d1-1e72-08dc05e855b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qe2R2f1OKnsWRAzyiwKxbF/9RThK+cE1x+D8QmjpGalTLHo4zvWXjo27SKy3XqLfdFsZ7amoxLn7x91pPQHwDz9JCO9SxkXm2hhIZuOItCJkDx3SH++PV0N/siRdvrbwhB0IJisOLqOhC3HXjl4yPeef/MS1j5mg4IvNivqCOuH3eOc4fzgyptJU3qtqCdHpt3dXWX+wEXMt+cwOcTEeyK5UCLABe68ansySkNZ+jYLONPt+1SOmwB/e8HcAl3+EKTynn1DDnblTkJRS4V1GBzscUhjSXo5GVg839VNB2/g2pnGd9fXdd4dh/JxCkzwMwQSnVwn2oW4p64m4k9Hn1Xund5OVd3aCmxkPxGdNtuOcSqR58+WUeAbtHPOlk828rm7vupYPAC9h1aq5rJsFXB2KEN1gKdnk/E2CVVt54+uATJFIOz16iR/uo0eqpzPmRRjyZodA+hSE2JYC2GfHZOUSmINlPs+ikkI8vzTijFIG3i+ZlKKxktfB/fpdB+ymOLZ1W30IFgyqFJXG6lEfUTd1Y3ga2DuKI09YjZ+8NEeVzwY7D9RWm+zdQPhPJ6h0ZTNBWip1JmJ9cCfNs34ookqphKppkdebUWJrDTGYTLrwksm02bkuG23q5z33QHcQknvwna/kO4FAPA2cexCGzqv5zaR38qcMvxYEoqW3N/Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(396003)(376002)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(4326008)(8936002)(8676002)(2906002)(4744005)(7416002)(4001150100001)(15650500001)(5660300002)(6512007)(6506007)(66446008)(66556008)(54906003)(64756008)(66476007)(76116006)(66946007)(110136005)(316002)(478600001)(6486002)(41300700001)(38070700009)(122000001)(38100700002)(71200400001)(86362001)(36756003)(85182001)(26005)(2616005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eWFwUkNxWXB4VmtXRHk1R29qeVo3MGcwR1pxMHdZM1Z6MTRHdzlYdVQ3anlv?=
 =?utf-8?B?Y1B6alpJcjFKVHowcTJTVEZpeWIweXlSMEJPeWdESWtlWXlWNEVHWlNTTE9F?=
 =?utf-8?B?RkZkOWtDeEhWK3V5cGI1cktCbGdDTVh5QlFHRnRnMmptLzBtY2ljWlVPZVc2?=
 =?utf-8?B?YW5mQWhScURGMFZKTXBrOHYvTEdibHMxTnRtU0QvR3YzN0pkVkIzM3IzOHJT?=
 =?utf-8?B?eUMxNlVTaHZHYWx3THZHOXQ0RUQ5MC8wZ3VjYnlIVjh1ZG90OHlnYTZudFJ6?=
 =?utf-8?B?R2I5M2ZWMkFHeFlESjdRVU5UWDBFbTZnM1hyclA0cS9ESE1lT0JvWkpKcjFS?=
 =?utf-8?B?dHlsN09UODRrcFNLZjErTForQmU1bUVEYS8yK3JmWWlKZlI2U3d0MnlPeXRj?=
 =?utf-8?B?RGRjYkw4Tmxwam10RkoxUzJ0NytIOW13a0lZd3BraFBiV1FGZVBxRUVoSXFT?=
 =?utf-8?B?K04yZXYzQUdNZkdvL1NTcjlGRmxzeUg3VER5VEVOR0hqWUxQc3ZYOEVBL2VJ?=
 =?utf-8?B?bm5uMnd2M3B3UTY4dG1penlpV3FUVkNscG0rZllVYkdidUk3TWlOaVBwSTdj?=
 =?utf-8?B?T3Rya0RxVWF5S1pjWHBwZTM2TTFKYStWUGMxYy9aL1llL3VJOHltNm5KNjJh?=
 =?utf-8?B?Ymx2bEYvbzVyRWYxL0hsR1B5YWJXY2VmSi80RHFWZlRWS1hOaklhVzRzRlpD?=
 =?utf-8?B?SHdWUW8rSVJZUXR5ak14UHp1NUpIQ0J1dnh4eWdXV3Z4VHh1Sm9GS0g5OHhj?=
 =?utf-8?B?Mm0yVFkvZjNpT2g3M3VjNzJkekliRXdOMlEvQ2tEdXQxcDlpZmNHSEcxeGt5?=
 =?utf-8?B?aUw3NDAxQ1lScnRsREovREt6YkhwQ3Z0dHdoaVQrcDRiVHE3OFptbEFvVklT?=
 =?utf-8?B?dHdCZzRsR0lzS2RWTTJFSTBPWURnM0REb252cElwSllkakkrRE55VGhBQkJ3?=
 =?utf-8?B?SmYxeEV6UEJDdlMvcEthSXdLcFpSd2NkMG1IekZGeXU4SGpHeEUraUptdWYv?=
 =?utf-8?B?TlBQQVhJK2FtYWhZWkFPSm5KanUza2pYbzFEejRMMldudTYzeFJRZzdmb0Vw?=
 =?utf-8?B?LzcvSm1NcnZRQTY2aFJMMW03VTA2L1NQckhXclJqZ25zclZpbjFlcE10S2U1?=
 =?utf-8?B?WUlQRm9TY2RLVzRpQlM5N0U4OEl4L01ybW81THhIaUNIczN4N3k4QUFjTHZV?=
 =?utf-8?B?eUNXcWcyb1ZnYTZjMFNvUUxTSnpuQnFvT1VzVVJsK1BKZnFkT2pPYXRud3Zh?=
 =?utf-8?B?SEx5VTZEb0JQblRmMzNvVTdrdlUwbUlwekdVNmtvMmVaYzVtSWFxSitNTytz?=
 =?utf-8?B?bHIyUXFGZ3ZCdkxHR0xZOUtvWGtneC9LUVNpM1A2QU9DalNXMktITFo5d1pv?=
 =?utf-8?B?KzQ2VkliZzZNVUFFRUlJZi91UXBYVURoVlR2QVRDVTFwbDhJUzVYYkt5UGJ3?=
 =?utf-8?B?VWRPQy9MMDMwY1B1TjB3dVJDaFlyY3RMWENCOE1YSEQzU1ptVzBjNWFoZnVW?=
 =?utf-8?B?UU95S3oyT3JTMTVENDVLbXhpNVBvSWhaQm1PK1dXZjhlZ1dMa0V6QmRJOE03?=
 =?utf-8?B?VzZHNUl2TE9OemFzNGp1YWVMWHBiNEdmUGgxUHZwaU1LQmhPSVlnMmpNSndr?=
 =?utf-8?B?cWR4Q09ORitxcWl0RUhXMFdmQ2cxZyt2RFUrOWc1Nkk3ZTdCRHBxb0tGeDdZ?=
 =?utf-8?B?bUpMd3hzSFNmNE1WaHRDb0RGZk01dzRUOVdQdStSTTJOZUxNWnVra0NVNWQ5?=
 =?utf-8?B?R2xWU2ZLcG8rZytlOTFyNEdYS3Zua01ENDJ4NjR4S1cvczhkdzRaaVRlNVJ3?=
 =?utf-8?B?b2RRbGVuRVVKeFN5ZzJyc2I5bVBjV3VXRys0b0Y2d1hNSTk1UG9wTGpCdzBY?=
 =?utf-8?B?MTgvRkpjYU9LOWJkcTlkRHR5OUNoVnl3ZnQyUWhiSjd6dWlsdEYweDYzZ3ZB?=
 =?utf-8?B?VlpoLzdnSlZtK1pESmVZdTIyODFQT0tWTGw2L2ZvZnJNTmlUWjBIcFdNcjdG?=
 =?utf-8?B?cVJKZHlTa091RU9DR0ZUVjRlN2d2UFo2T3VpWmd5TFMwUEx2enhRN1A3OWYx?=
 =?utf-8?B?OE1vOFBxM1Q2ODFBQ0xDdk9MSFdZNzM2Y0FobkoreGpPcWVRR1dKbFJtNEhi?=
 =?utf-8?Q?UY3mTGlM3S9D3+ITgIgi75/Rj?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDB3CE5A2D54934D973D2464B0AA77B5@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1052470f-d320-40d1-1e72-08dc05e855b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 07:57:40.8360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uQnfXzgAq5+0JFBjyc3gDG2lx8bs7Xz/pz3O79Kqz0wr64XBW0SBZWjOphjw33BesMkQB5t4m0ZnAg7Zg0RbuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6781
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--9.161800-8.000000
X-TMASE-MatchedRID: VPleTT1nwdQOwH4pD14DsPHkpkyUphL9qQ9UezeTkThu4FknyqyshF1Q
	po5pNysMe29pTfBhqOY7b3Js3F6vVD1LciJB3541o65WJt1k1O8TbU1KYGoQp3vsbfoZixUTj3Q
	bFpHxze2nOS5SZ2721L63IyjAjB8mMkaIaLbJ6ucXrP0cYcrA2xE2nvEP7i9RnLVhzy0+RX1DyL
	yEFs/t+lavpd/0qmzQkZOl7WKIImrS77Co4bNJXQtuKBGekqUpI/NGWt0UYPCuyq7yOtbX/wCCC
	TiuRgL17ebErhSlX+s+VQiogYOJ/CbONta81gX5
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.161800-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	79BBD206F05968EF6DF6665ACBCBC151E8C5B30D02498AB7F871D2732F6F39062000:8

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
PiArDQo+ICtzdGF0aWMgdTMyIGNtZHFfc2VjX2dldF9jb29raWUoc3RydWN0IGNtZHFfc2VjICpj
bWRxLCB1MzIgaWR4KQ0KPiArew0KPiArCXJldHVybiAqKHUzMiAqKShjbWRxLT5zaGFyZWRfbWVt
LT52YSArDQo+ICsJCUNNRFFfU0VDX1NIQVJFRF9USFJfQ05UX09GRlNFVCArIGlkeCAqIHNpemVv
Zih1MzIpKTsNCj4gK30NCg0KY21kcV9zZWNfZ2V0X2Nvb2tpZSgpIGlzIGNhbGxlZCBpbiBub3Jt
YWwgY29udGV4dCBub3QgaXJxIGNvbnRleHQsIHNvDQp3ZSBjb3VsZCBhbGxvdyBhIGZ1bmN0aW9u
IGNhbGwgaW50byBURUUgdG8gcXVlcnkgY29va2llIGV2ZW4gdGhvdWdoIHRoZQ0KZnVuY3Rpb24g
Y2FsbCB3b3VsZCB0YWtlIHRpbWUuIFRoZXJlZm9yZSwgaXQncyBub3QgbmVjZXNzYXJ5IHRvIHVz
ZSBhDQpjbWRxIGNvbW1hbmQgdG8gY29weSBjb29raWUgdmFsdWUgaW50byBzaGFyZSBtZW1vcnku
DQoNClJlZ2FyZHMsDQpDSw0K

