Return-Path: <linux-kernel+bounces-11851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801B581EC80
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4FC91C22269
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3606538B;
	Wed, 27 Dec 2023 06:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RqAoF+c4";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OdEUN0TU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C438663A8;
	Wed, 27 Dec 2023 06:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4aa0efe8a47f11eea2298b7352fd921d-20231227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=7757bhZgdxOiDKXWuYA7Rm/mftj9qU4RxuS5bGJ3JCc=;
	b=RqAoF+c46zGR6AKQiXlkTqP2F7bXXnS+yYz1TAg7me7kHvwVzRN4dyT7Vwp6HbTBbi3nDIxoutKJv1QrSY7MIEBM1vagSoLRsdSboos0KIielpHFWfESHioQgFPHmIdiwVto1GRWIbowgbrSiexjXGT021hjPGaW3Skl4eqrKGk=;
X-CID-CACHE: Type:Local,Time:202312271413+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:bd625d9c-a0a1-42b9-bf8d-9f170f2b755a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:207c3682-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 4aa0efe8a47f11eea2298b7352fd921d-20231227
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 622068764; Wed, 27 Dec 2023 14:15:11 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 27 Dec 2023 14:15:10 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 27 Dec 2023 14:15:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfA5niDYVZGmDENcSKy0x3nIqEfopdUNp/xBTkuQmU2gx40KmH3ZdRk+klfyDUaMrW0WidSP/wgDYbT7hO0F2jSyhQkQRMbyZps12GrukI/4tsj2zMg5KKHwMsFmBgJ4mpOHZCXkqWYPx8C1JIcZIWHAuUYb6AGNTYAt9uAidC4or11CjSGEqNcf7f6jIP2DLr0nwNkCBrHWfyAWaOyCtX9GVqWFlDVQpVk9+P4TqtwPX3GWy24HAuf9+o3NOG1yrDklfftucrJ9fmIXus280t+2UDC/LeKFhRGrUQyNcCNSD+S63isRJIDaLXsWaO/pZI0xG0pVUgrf365I1HbBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7757bhZgdxOiDKXWuYA7Rm/mftj9qU4RxuS5bGJ3JCc=;
 b=Ei9vZFIz1F1FLn+T6ywGAMBd8s5BszJzcjlo9E2pOra6bzO4nhOnnGRZXEoBBb+t7VggecgdoIFhqgRMFrnmsDu/j8WZ/6Yu+N6SxMqOyaXxfW3HqiChiGub4yZfnzFRwKWr7hJNexWxOseY5ClpIGfQtVHj7JmJT6Ue/KLYTbSTCKmppVuFOpDKcZM4ce7QcD7pHjc3KNAiq9mdt5F4UgUYaNUSum90G4YYYPgB3TcQIfoMRIvy/gxNW0erFSzdwbC/wGPxVoMze1xn5sV1Fh0P3MbUTMS5OVulSeI7aYbAdvPrYirpVwII/etwSIK5QTV0trDOPwhMrVBffbvhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7757bhZgdxOiDKXWuYA7Rm/mftj9qU4RxuS5bGJ3JCc=;
 b=OdEUN0TU0JX4CiHVB4YBhkFXGbpDGekosUCY4gHyhUSCttbII0AyQeZnlYK4UAS9XFF5iQcB6OkBN2R1OkkDJdE9/SFyKs90/29iUgD8ArBNzJCZjq38dUZJ/AtIlRJwZ14sJMW0zWL3nTK0eZs+wewnsfMtGJM5PIUsNQSQiI0=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by OSQPR03MB8482.apcprd03.prod.outlook.com (2603:1096:604:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.18; Wed, 27 Dec
 2023 06:15:07 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.027; Wed, 27 Dec 2023
 06:15:07 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC7OT8AgAF1rQA=
Date: Wed, 27 Dec 2023 06:15:07 +0000
Message-ID: <96712d3424f630480eed4bf2f4d5417a70b2a3a4.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <13754f308ce9ff1a9787b2597e416613b638c611.camel@mediatek.com>
In-Reply-To: <13754f308ce9ff1a9787b2597e416613b638c611.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|OSQPR03MB8482:EE_
x-ms-office365-filtering-correlation-id: 1e6e24a8-49d1-45f6-4c39-08dc06a32c48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0B2ky+yL7YaKXVqvu9k0Bgu7yOFEIRyARGS0kF/x+305vV1QF2bymNOV+X+003cpYFaSpuUxwRsVYbV8zfk1xlAvBioMtJvzeAQz3815aCoIk9SZtiR4HWXo3Lf+3KIG9zpU85cHuu3tf/tCFHJ2YuLF1SD0z1XQAOGbfelXLKQRdvNAXpETDv+zvPyPlt9zB3lBS8uvLdlekLggLtXguh4LrXA0At8xhxyH3kwYeRLaQ5vEvy2zVlgMSAnEsYVPmegNXt/hoIc2mrHVGPyEx7jMiJ5bxdk56WyapCn55S5uDeTZ8yI1nGarXIaGu3INgVb5IZEQSZD20o71B32F1ZN2h/kJIYPs6ieQLytNM+xTAvFY7gthLzjsf8F6Vt7F+vf4PTuBhbDklrAJGPPS3EfVswFEvoC3qrUU/MExSHWyE52jzfRsXNmjUd1vmGXgQHaPbjOVR6scU3NrXz49qqvsgc+kl/KN2viXwgJSfllKx/v3BWD0+tiTP+/ugSFgJYUHfzrrr6NChvkdN54S+eppDmE8dFFIqyJhgqgYt0vrMdLZFqioXj1VV+kC/pJTy/laQxWi1PJUv1jaEM1skct+u18SdoUh42HXywW0wuhgQ+pR9Z3JOwKbOmpsRNeOM0Wj76AZJI14nMfA9+uwZWT3tSiw9asRo7r5AeX0eq4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4001150100001)(2906002)(64756008)(66946007)(66556008)(66446008)(66476007)(76116006)(5660300002)(15650500001)(7416002)(4326008)(8676002)(8936002)(316002)(54906003)(110136005)(41300700001)(91956017)(85182001)(6486002)(478600001)(36756003)(71200400001)(6512007)(6506007)(2616005)(86362001)(26005)(38070700009)(83380400001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWk0VWc1WGNzNVV4MTA3cjZTZGt3dkdEK0RYc3JOMmxTY000andoRG12U3FH?=
 =?utf-8?B?WEFIQmRIbDgwRnpaRGViTlBNdHUybjFyektLSTl5REcwSzVSVkdaelZ1TkZY?=
 =?utf-8?B?RGxDMDBkSDRXZDU5QnVJUkExMVJZMUh6RDBtRk5JRmJHSGluTk1BMytXQndh?=
 =?utf-8?B?cklFYWVaVkZmblJFNEQ0WHloVjlzWG9QOExsZGFBci96eWg2SkpVQkczTEFj?=
 =?utf-8?B?Y1RpL1BXc2ZOaWhHN1dSMzVCaTZBRFlBNW5BV1gvQmd6QnZFRVFaNVVuUjE1?=
 =?utf-8?B?WXMvVkhpVDZhb2g3Y3JBRFVkY1BtcCtMRGo1SktyMVJ5UmVuNVNiT051akFv?=
 =?utf-8?B?amgvRkxtSHFnamZyQjhzOS9XWHBSYUEzSWZXTExMSXZqTlpHWFFJQXdkUHNW?=
 =?utf-8?B?L3k1UnFXMTIzWHZIVzdHVkxpQ2tTUFJ0VDVjTDVkSkxzSkNjYXFtUEFWR3Zh?=
 =?utf-8?B?S3ZCTTRPTkZ4eUF5RDYyTDFkdGRYWjNiUTEyTVdyTGlVelRwejYrdHRpMUtn?=
 =?utf-8?B?L2s1Y2d5cHJVbERWZGF3U3I0TFF0V2Nnbmk3b2gwSVBuWGJvQUt1aFNGb0pz?=
 =?utf-8?B?TUR1VkowWXRIMmJrZUl1Qkxsd0lidEVvaDhsUjBlSFBNSHV2NVdQNUJZbXFn?=
 =?utf-8?B?ZUFuL2xoUHZxUmoycFFadmc4OGFNR1dqRHo1RWgyNStndnJHWDlFN050eUx6?=
 =?utf-8?B?Wkc1M09pdFBqK29CeVd6RzM3eDdnUmtPSS91OEswMmlUSlM5TXMrQnZSb2po?=
 =?utf-8?B?eHdiMTZPUUNSczhQTE5MaGhQVHpWS1NienlZd00wZmExam8yT0tvbzVxWTNu?=
 =?utf-8?B?bG9Id2ZKMFpSU0pYL3JlWWJDdjhVKzVrd0pRRnhQdk1UbThjQkdtL2V0cFZ3?=
 =?utf-8?B?WEl5U1JXVDluVy9iaE0vK2xLRHNHWUh0MGRiWUYxaEJWLysyUi96cS9xU3lv?=
 =?utf-8?B?dE9VNEFmaDlIbzI5WEduL0xoZzlYS0JnRG1CYkdld1hEdml3cTVSWGI5YjJa?=
 =?utf-8?B?cDZITEFSVTBnU0M4TXMrejU2eXVCdTFNT0g1RG9mQVB2ejZXRmJiZ3BXL2Jz?=
 =?utf-8?B?WVdUWFRENFA1Wko5N0FqL1dlaGszekpGdWhDNXFuSWhJejVQWCsrcXJpenVo?=
 =?utf-8?B?R3FiNFFZZFExcHcwYi90L1RKMjVQdG4xaWlnMklOeEduL082TU5aUnhBVEdz?=
 =?utf-8?B?Wk8vb3dsdkdOamsrblBxZWFnNzJhc0tyeDFSRjRIRUJWbXV5bWhscTl4V0Fz?=
 =?utf-8?B?Ri8wWGZvd2hXeHQ4dmM2QmpQM0F5RzJHU3FQb2xjbjRhck92SU5nYU54THdL?=
 =?utf-8?B?MUpZSVdnMUtMY0QyR1UyK1BnQWlMRWdrNW1xWE54cDJ3QVdaR1B5TzZjak9s?=
 =?utf-8?B?K2EvM1U3cmRZUEJEaW9qemtpcFg3UFVoVWFwbXAwME14dGdrQjlXQXlSdzY0?=
 =?utf-8?B?dVJna2dpVUM0dGlCL1owT20vazJMZHFCWXFOc1FJL3FNNFhacmZvV3BtTTEv?=
 =?utf-8?B?YXg0MngwK3RFY3lkeXFxVlZ4VFJSZ2hNL0NJOUF6azdKS3VmOU1zdk1WNG1i?=
 =?utf-8?B?WHQ3S3hkdjJWbU9ybjVFalJicXNSWW9UZTJCMFBVSGZnQ0xyeFBhOVhPMUhh?=
 =?utf-8?B?R01RbmhudTFGLzhaUEhJb1NZSHk2anRYQXRQVDVTU0toaHFVNFNPbVlCc1hz?=
 =?utf-8?B?azQ3Z0srdjZlazU2dmVGTnJyczB5Y3EyRHhrNDhBaVFHM05lcFF4YUo2WWZG?=
 =?utf-8?B?Um1Id1VEdEhiQWxsRlVjdVFqTmRTdG8ybUx3Nk9vQUd5a2RxKzdveGM5MjFo?=
 =?utf-8?B?b1M0Q2VMeHNmM09kWHdWejU5bXErMnZNMGdsY0x3VHpFMkdacURibTRFOGtp?=
 =?utf-8?B?TmtGQklMUkNheXowQzhkYkRHS0U2Rmp1RTB4Q3Npa1MxTzBBT0dLZGNWakxE?=
 =?utf-8?B?U0FTR0FIQWhyWFpIeVB6aGtWSGhaR3N0TnplWU9uZXRHU2JHZEF1SkJ6Y0Mr?=
 =?utf-8?B?NjIwc1VHZXVuTlVGaTdXSnptcXNCY0krdWJya3R1SFhpSzR6VmZPZm5ObFlE?=
 =?utf-8?B?Y1ViQjg1REhSRDZZTEtQemMwQ25sTnJReG5MRGp3TTRoMWI1U1RDYkxEcEc2?=
 =?utf-8?B?ejJJNkZLTTVYT1Ixa3VUOHo4czFSYkRKT2hNUE80NC9sWXBoVHdXZnlpdXdT?=
 =?utf-8?B?SWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6430FBFA61780E47AE701274182A7407@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6e24a8-49d1-45f6-4c39-08dc06a32c48
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Dec 2023 06:15:07.1511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2DR4D6hVRXttB9Gy9YCcPhD0AcGRHOnHAXOKE7EJbab8f4vx9NnQNSSZ+TLgaymFcJxKueKxuTRsJIjvdMgsi0PuDJD0vPQMMmv8Myk3mds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8482
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.045500-8.000000
X-TMASE-MatchedRID: oTBA/+sdKaanykMun0J1wmjZ8q/Oc1nAjLOy13Cgb4/mNRhvDVinvypf
	0VJZhlxP3gb7k6xpVN4a/3L93pcprQTsy5Ctk/ajdAg4yd14qAQxmbT6wQT2a/t592eq2xoTHye
	T8VIiNb6ykaH8ZceX1bWrjxGHjCv1DEVT5M0HH4Xk7k9yXJiqql7OZ6hrwwnzBlt4RZwvTdX+UD
	zHKK1SQrDQvlwN/Bf3dCnwFnnJfgD9jxte3IFskBIRh9wkXSlFfS0Ip2eEHnylPA9G9KhcvZkw8
	KdMzN86KrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.045500-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	ADE9B825ED26D7F66C43BA5B4C2C580F336BF4101AC0CF2A3E9896C94B41E9702000:8

SGkgQ0ssDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0yNiBh
dCAwNzo1NyArMDAwMCwgQ0sgSHUgKOiDoeS/iuWFiSkgd3JvdGU6DQo+IEhpLCBKYXNvbjoNCj4g
DQo+IE9uIEZyaSwgMjAyMy0xMi0yMiBhdCAxMjo1MiArMDgwMCwgSmFzb24tSkguTGluIHdyb3Rl
Og0KPiA+IFRvIHN1cHBvcnQgc2VjdXJlIHZpZGVvIHBhdGggZmVhdHVyZSwgR0NFIGhhdmUgdG8g
cmVhZC93cml0ZQ0KPiA+IHJlZ2lzdGdlcnMNCj4gPiBpbiB0aGUgc2VjdXJlIHdvcmxkLiBHQ0Ug
d2lsbCBlbmFibGUgdGhlIHNlY3VyZSBhY2Nlc3MgcGVybWlzc2lvbg0KPiA+IHRvDQo+ID4gdGhl
DQo+ID4gSFcgd2hvIHdhbnRzIHRvIGFjY2VzcyB0aGUgc2VjdXJlIGNvbnRlbnQgYnVmZmVyLg0K
PiA+IA0KPiA+IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xp
ZW50IHVzZXIgaXMgYWJsZSB0bw0KPiA+IHNlbmRpbmcgdGhlaXIgSFcgc2V0dGluZ3MgdG8gdGhl
IHNlY3VyZSB3b3JsZC4gU28gdGhhdCBHQ0UgY2FuDQo+ID4gZXhlY3V0ZQ0KPiA+IGFsbCBpbnN0
cnVjdGlvbnMgdG8gY29uZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogSmFzb24tSkguTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29tPg0K
PiA+IC0tLQ0KPiANCj4gW3NuaXBdDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIHUzMiBjbWRxX3Nl
Y19nZXRfY29va2llKHN0cnVjdCBjbWRxX3NlYyAqY21kcSwgdTMyIGlkeCkNCj4gPiArew0KPiA+
ICsJcmV0dXJuICoodTMyICopKGNtZHEtPnNoYXJlZF9tZW0tPnZhICsNCj4gPiArCQlDTURRX1NF
Q19TSEFSRURfVEhSX0NOVF9PRkZTRVQgKyBpZHggKiBzaXplb2YodTMyKSk7DQo+ID4gK30NCj4g
DQo+IGNtZHFfc2VjX2dldF9jb29raWUoKSBpcyBjYWxsZWQgaW4gbm9ybWFsIGNvbnRleHQgbm90
IGlycSBjb250ZXh0LCBzbw0KPiB3ZSBjb3VsZCBhbGxvdyBhIGZ1bmN0aW9uIGNhbGwgaW50byBU
RUUgdG8gcXVlcnkgY29va2llIGV2ZW4gdGhvdWdoDQo+IHRoZQ0KPiBmdW5jdGlvbiBjYWxsIHdv
dWxkIHRha2UgdGltZS4gVGhlcmVmb3JlLCBpdCdzIG5vdCBuZWNlc3NhcnkgdG8gdXNlIGENCj4g
Y21kcSBjb21tYW5kIHRvIGNvcHkgY29va2llIHZhbHVlIGludG8gc2hhcmUgbWVtb3J5Lg0KPiAN
Cj4gUmVnYXJkcywNCj4gQ0sNCg0KT0ssIEkgd2lsbCB0cnkgaXQgYW5kIHNlZSBpZiB3ZSBjYW4g
cmVtb3ZlIHRoaXMgc2hhcmUgbWVtb3J5Lg0KDQpSZWdhcmRzLA0KSmFzb24tSkguTGluDQo=

