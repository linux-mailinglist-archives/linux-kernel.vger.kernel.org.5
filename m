Return-Path: <linux-kernel+bounces-15224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 991E48228A7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07C71C22FC8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215E7179BD;
	Wed,  3 Jan 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="b+O2PRe5";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="m5gan/Hn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D41798C;
	Wed,  3 Jan 2024 06:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 063944e6aa0511ee9e680517dc993faa-20240103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=1c2Q5krTqjjY+g5Ge8TYLvu72FbQ7+IdBVVKVrtgIxA=;
	b=b+O2PRe5dxTlKlXvdtVMhuw4z6VrjjXUxystW+/3WLMNAfHWsoWaWLflmGAlkWfk787Opld1IgYojvdBzq+xluj4W6fVVn9DmjfOXcCy5fDtEX4ZiudSV0Vka8w7xHxwYhlIJ5UgdcJNuHK6A/RG/F91+FSvoWduZY6CG4EL4nM=;
X-CID-CACHE: Type:Local,Time:202401031451+08,HitQuantity:2
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:852fdbda-3757-4b5f-a7f0-03c7aa119e0d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ec5f6f82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 063944e6aa0511ee9e680517dc993faa-20240103
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1479237881; Wed, 03 Jan 2024 14:55:05 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jan 2024 14:55:03 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Jan 2024 14:55:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6RsQg4EMbfCpysNIjhPBQjNY3O3ugJAQz8kcIKlpqEUR/ZIdrDHeIbbOu1VJs8lISxcO+MIyyMsBdtUbWCWLeAqNqO5Guq5q8fsZiaYkjCDbbVnADFEL+VBNXwjvOEZ9CcxtEdkqoq2sjMyxSz4JHah/D1J4Pg+kyxekDOTZRGgwPBEbrv8IqH4Yilj4ypOn8yrXkeXB9t8vgU/3bqME/q00/v4CGXw6i8WD7VmaF7p3DZhhsOjZ7qs8wX8FEwh1GBL/fGl63oT2o8p6kVMZgSIIITut5p5zPG76HTvSdupb22xdg0YwnCH91X1WCr3hn2/plBmVcf97rQartDHlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1c2Q5krTqjjY+g5Ge8TYLvu72FbQ7+IdBVVKVrtgIxA=;
 b=h5kNyQWmHoO2OLtfJ/ulcYH5vdWRzy2hIMHrrl54kzaloxKc8qmdxxhqYd3tInOQsqjQY41esRgkJZxafxDyPoKqUkELFW1fBe8xZ+q8/nicOMD1Ah8wTXQQnqreXE+G6hE+tewnAQEC1lZCMEAcxz/IFTYHtTIBh4DQw8j5idoi9BVkmU7FkG2dr7Q97ZYENjO1tKgwmt1nmK/z66tfCjZbvc4invo/1I4NuqyJQSVxjJyqLmQbS3Qo+Edf3umj/10Pq5EY+Z2iG0EKOHLJWBPbb3F6HN5eTCEIBPckPOdMN6OwjQuqQ5nF+D78hxSPz+pE4ls+T4cSZIwE3EZ+sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1c2Q5krTqjjY+g5Ge8TYLvu72FbQ7+IdBVVKVrtgIxA=;
 b=m5gan/HnSn0kstOSCGLvohes60wwJX9tpC9VBr8KFRNy8zIB7lwrPEnWf0UCHAEslqmpcsG3EIh5XM5meGFAGMSUfje/i94WsjLwnvCDM554dehdeIr1d+a7/3bxTceKK/XFcOxfCcXW9ZbsaWVhu9Z0SAeiMX7MN/byf52rBEw=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:55:01 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:55:01 +0000
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC+V6aAgAliv4A=
Date: Wed, 3 Jan 2024 06:55:01 +0000
Message-ID: <b91ab311c3d4cff4ad0e5236dbfebf6c9c22b345.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <d4eb25a2affed65ed30a269e4b54e8d1a671abde.camel@mediatek.com>
In-Reply-To: <d4eb25a2affed65ed30a269e4b54e8d1a671abde.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5605:EE_
x-ms-office365-filtering-correlation-id: c62b1666-b293-4f42-5ff9-08dc0c28e869
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7ENw9myXfyd3qBKEkporctBU001fMEw9eJ8gIFO6wxfcMBcirYTnCbmyBXFaWidCta3NIgrolWGET6RpFOdMnJNQjzWwre3Mnc+5rZ1paZy4uOtCQdWCBD8G9ZtHWq03uXsg2JvUcQm/UmERZOEAhdQT2tUakEeKOvl5zyx73uHoHXPILe7HdkxcrP73bRtTSOx5I61S37Uu1Xa+GJg+ig2aaZZ/3pFV4jjJzHOBqSOGfLYK3kj10rWsPu0c6iH7aS7zNN7Kwc0gcHPpIhQO0oARYPkqrjUzQYyNACe9+/mRcAAtsjETvJCUv5dox/2io34ledm/RWWpnD+mdLoVOii9LWH43hx+i5dV1RL6Y3Qjt4UofRHbbinKbqvymz5kZQQOvAW3pBeuiuZLu7C3B611eHah55RmD+DwStySpDaN+dxj8AgxBchoaR0GiLGuxtF+w1/ZocypkBr793LeV+4se0Nol4B2yDGadNREXKddFsvjHF70LiRUFmxZMw6aYgI8v4szTovW5M6L0Kr1/A8GFnn+aRyTAPyUMbGJE1qHMAjQ5Chk8eNGlNzzqd9x3nHYdk2M75ZTr6ldmU5Cue2/9TjbOJieJ5sCjSk8irdw0A2GSxXgT/8CONawORqhtu79QZDpCyGIW+SbczXUmGSgCk1xn67fZt6fvgL40g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(83380400001)(4001150100001)(38100700002)(122000001)(110136005)(41300700001)(54906003)(8936002)(316002)(15650500001)(8676002)(5660300002)(7416002)(71200400001)(2906002)(4326008)(478600001)(66446008)(6486002)(66946007)(6506007)(64756008)(91956017)(76116006)(66556008)(6512007)(66476007)(38070700009)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OXJNcnM1QTNwNGtjQTF6VUJCQlZucVdTUDNmMitjeHNWcm1iUVdUMXVHQlAw?=
 =?utf-8?B?eXY4SHhvajJhMEovSC9vanFoVDhVd041UE9KNHlOZWN2T09HdzdEVFlXQ1Y1?=
 =?utf-8?B?NzRyT1czZk5xZDZXOW13UzdLTlhWQWh6d3h6akNrMXFxSy96bmtpdDVPU0RG?=
 =?utf-8?B?amFsT3d3bDhBQm9rY0xoY0M1MVVoek5Uck5XR3JNSUJrYlg1eGxKclI1aEJF?=
 =?utf-8?B?SUFEN0VEY0thUHZHWngzVUlDU1FQTCtDbkUvRzNIRHFkL2xYd1JlTldBZlF1?=
 =?utf-8?B?aWlJY1gzdHZjWUI1YzhIaTk5VmdwQmE3RUh2VzZRRisybXdZVWRhVFIvTS9T?=
 =?utf-8?B?Z1U4OUd3ZURBN0tXRTJYL0JPenc5MXhseVRKRzBwWDdLQWwrRDgwNzhMaE9w?=
 =?utf-8?B?eXZLaUdJUXRpQUVzdGVsOU1tSnhNUEVnN1JzZklPNjJwWXVXdXJWOW4wc1FH?=
 =?utf-8?B?QXNpWkkwNVNyT3F5Q080bUZYUkhoYWxUMDFEWElNYTFPbGZKNGg0Q25CeXAr?=
 =?utf-8?B?Nm9qUnFVVUxzajJjb2hBY3k0dnZ0ZXNwODhPb2IzbHU2by9PMU4ya0dzcFdw?=
 =?utf-8?B?OWNyZDE3bU1XRFQ2QUVrQ05LTVYvcmhVaENjWExLU0FRV3JiQytJbUxyVFlM?=
 =?utf-8?B?OWFUVDcyRVllOEkyRERPeU1qNDltTWpoeGJGdVVhQng5QktlRUlXR0h4dThC?=
 =?utf-8?B?ZUJnT1dUM1lvQzl3WCs4S3NCZU5UdGpKOEhkRjZaejB2ci8wdGp4RlNTYmpa?=
 =?utf-8?B?TWdOTnVPaG5IdUI5K2UveUpHYXNudllpckpsQ05aeFJwakM5cndWNEZ4TTNu?=
 =?utf-8?B?WXlFV0ZaM3U3TXg1ZkxjcjBPV2RYa3ZBRkJ3ZVIxam9WRWxFMlpyQVZuWWow?=
 =?utf-8?B?MG0xOWQvOUpyTWFhZHYxdDdHOUxTQ1hKc25ucW1pNk02bTZnVXg0R05DMkNM?=
 =?utf-8?B?aWVMNTh5WDV1aEYxV0Nwb3Uwb3FtWnFFR0lNRFpaRXBRSUpubkhmNlROM04y?=
 =?utf-8?B?SEloWjZLR0ZkNDNWS0tHalhzVi9zbGVFZFh6VW5ZUkFJSTNRdlFQRlZkTmdv?=
 =?utf-8?B?eVdXNUgxM2FicEl3YktGR3RvOFR3ZXB2ZXY3UWdCV2ZvdkhYcmlTLzlINnFo?=
 =?utf-8?B?ODlYZUg5akhnWmc4TDhOQkVnQWhvZ0M1aHVJaHpLaXc4aHF5R2h6Qk9LcUNN?=
 =?utf-8?B?WWl1SW9mOXRjbm5uaXp1UHJWeExkaUx3cG10QjF0SkREYk5RM1BEcE5QRDhr?=
 =?utf-8?B?N2NKREhrNEh2dVdxdzNxdHFEVjRPdVptc09GN1YxQ2l1eUMrZ2IycnVBcVFV?=
 =?utf-8?B?Ym5QRE5QS3FMNmR6OGsycndSVnVRMjd4cFZSdVorWGtRaDU1OFJrMk96dlZG?=
 =?utf-8?B?U2hPdldxQUpCNTBZTm5kNHdiRmFJRzlJNmh0NTZDT3J5VTdRb2xvQ01CNHg3?=
 =?utf-8?B?cXRIVVE5MUZMZ3JLU20rNWN5WnhzUkMzRzNseis5Sm85anE3RXp5RXcxN2ph?=
 =?utf-8?B?c0J1NlRxRDM5ZWQvSXJ5SjhNWEhDdHV2ZFhETUFNV2hDQmtnZ0F6K2NnMmxp?=
 =?utf-8?B?b1VWeldEK1lCMzlaVGdzVnlmRDlMQUFsY1JjTDZzekowMlhHVE5yZDQ0dWdC?=
 =?utf-8?B?WjBMdElRUkhuWnJaMVh2TER5M3pXTzJPTklDTVJHMEZGSzVGV0xLb0hXOWdi?=
 =?utf-8?B?dTk3NDRCZnVrQ1NYVzYyNWZYWkJFSTZ2NEVPRVBTZ1hEUGFiVTE4bmFOWU9T?=
 =?utf-8?B?Ky9YQkR3Tm5rYUJxNmFXL3pBSlJqellVQ2R5dzJQTnpacmZrK1RMYm5nUVlJ?=
 =?utf-8?B?Tk54YlV0MXhxeDhPYlEremlyOG1DUDZkTHRuTEp0a0hLUDJGM3lhRXRQMWhB?=
 =?utf-8?B?bUJ2TW9mVUk2cUpLS2JxL204T3l5V3h2WHcwM3lwY0FSRk4vSThnZ1FxNW9v?=
 =?utf-8?B?UWRzOWNtN3VzeVk0QkZNRGtLM3M3QUdjRDlxd1hXSEJ0TkdMdGVxc2RwUlN2?=
 =?utf-8?B?cHlMTGQvTjREcndlaTBDZ0F1VnlrVmZ0WGhnOTdlMHF2c09IcEQxZlNpT1Ez?=
 =?utf-8?B?dWYxdnhKS3VjRjVtRVptZmdJK2VXUkNDakZuUHNCNzNYUTl5WTNDMG9xSi9R?=
 =?utf-8?B?YzFQVm5DM2N2SUxtTzVPYjlOSmNXSEE4Tm9QMmRGWktLK0dYUDhsUHYvTnVX?=
 =?utf-8?B?a0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D5C8EA4F4457224590B1957278C70EAB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c62b1666-b293-4f42-5ff9-08dc0c28e869
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 06:55:01.7162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pRi6gpaK2Ttv60voeG7dedV/xh4qB9XCuiXTmPyNLnl3B6FYhPvAiUcs1e6gAn+pYBBFDXWUqYL+H7us9s/bhrq8DfMEkNVve4Q78/L+PLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5605
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--14.677300-8.000000
X-TMASE-MatchedRID: nVQUmLJJeyYOwH4pD14DsPHkpkyUphL9fjJOgArMOCb3bBqxmjinTbs0
	9RsYKeKEiUqxWFzqa/9QGF7v4Up8Fw9FV6kNYiPHbc297PAGtWaQoBr+SFneJHPBWZjlMys28ha
	W4U9IrFpp2AbuTNMCFDutUseHeQFeSJvHZYIIxMi5kfgtJfb41T49+ukeLY91myiLZetSf8n5kv
	mj69FXvEl4W8WVUOR/joczmuoPCq2lDFBWCibETWfjdOgGq90vJv5Zq02Q+VW29WvGZS/hk69KB
	T35ECxu
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.677300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	9F9F1D1ADD1F4A36294C7CA6F297695453408D7909649B212C74237D776216DC2000:8

T24gVGh1LCAyMDIzLTEyLTI4IGF0IDA3OjM1ICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gSGksIEphc29uOg0KPiANCj4gT24gRnJpLCAyMDIzLTEyLTIyIGF0IDEyOjUyICswODAw
LCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBm
ZWF0dXJlLCBHQ0UgaGF2ZSB0byByZWFkL3dyaXRlDQo+ID4gcmVnaXN0Z2Vycw0KPiA+IGluIHRo
ZSBzZWN1cmUgd29ybGQuIEdDRSB3aWxsIGVuYWJsZSB0aGUgc2VjdXJlIGFjY2VzcyBwZXJtaXNz
aW9uDQo+ID4gdG8NCj4gPiB0aGUNCj4gPiBIVyB3aG8gd2FudHMgdG8gYWNjZXNzIHRoZSBzZWN1
cmUgY29udGVudCBidWZmZXIuDQo+ID4gDQo+ID4gQWRkIENNRFEgc2VjdXJlIG1haWxib3ggZHJp
dmVyIHRvIG1ha2UgQ01EUSBjbGllbnQgdXNlciBpcyBhYmxlIHRvDQo+ID4gc2VuZGluZyB0aGVp
ciBIVyBzZXR0aW5ncyB0byB0aGUgc2VjdXJlIHdvcmxkLiBTbyB0aGF0IEdDRSBjYW4NCj4gPiBl
eGVjdXRlDQo+ID4gYWxsIGluc3RydWN0aW9ucyB0byBjb25maWd1cmUgSFcgaW4gdGhlIHNlY3Vy
ZSB3b3JsZC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpo
LmxpbkBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+IA0KPiBbc25pcF0NCj4gDQo+ID4gK3N0YXRp
YyBpbnQgY21kcV9zZWNfc2Vzc2lvbl9yZXBseShjb25zdCB1MzIgaXdjX2NtZCwgc3RydWN0DQo+
ID4gaXdjX2NtZHFfbWVzc2FnZV90ICppd2NfbXNnLA0KPiA+ICsJCQkJICB2b2lkICpkYXRhLCBz
dHJ1Y3QgY21kcV9zZWNfdGFzaw0KPiA+ICpzZWNfdGFzaykNCj4gPiArew0KPiA+ICsJc3RydWN0
IGl3Y19jbWRxX2NhbmNlbF90YXNrX3QgKmNhbmNlbCA9IGRhdGE7DQo+ID4gKwlzdHJ1Y3QgY21k
cV9zZWNfZGF0YSAqc2VjX2RhdGEgPSBzZWNfdGFzay0+dGFzay5wa3QtPnNlY19kYXRhOw0KPiA+
ICsNCj4gPiArCWlmIChpd2NfY21kID09IENNRF9DTURRX0lXQ19TVUJNSVRfVEFTSyAmJiBpd2Nf
bXNnLT5yc3AgPCAwKSB7DQo+ID4gKwkJLyogc3VibWl0IGZhaWwgY2FzZSBjb3B5IHN0YXR1cyAq
Lw0KPiA+ICsJCW1lbWNweSgmc2VjX2RhdGEtPnNlY19zdGF0dXMsICZpd2NfbXNnLT5zZWNfc3Rh
dHVzLA0KPiA+ICsJCSAgICAgICBzaXplb2Yoc2VjX2RhdGEtPnNlY19zdGF0dXMpKTsNCj4gDQo+
IHNlY19kYXRhLT5zZWNfc3RhdHVzIGlzIHVzZWxlc3MsIHNvIGRyb3AgaXQuDQo+IA0KPiA+ICsJ
CXNlY19kYXRhLT5yZXNwb25zZSA9IGl3Y19tc2ctPnJzcDsNCj4gDQo+IHNlY19kYXRhLT5yZXNw
b25zZSBpcyB1c2VsZXNzLCBzbyBkcm9wIGl0Lg0KPiANCj4gUmVnYXJkcywNCj4gQ0sNCj4gDQoN
Ck9LLCBJJ2xsIGRyb3AgdGhpcy4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQo+ID4gKwl9
IGVsc2UgaWYgKGl3Y19jbWQgPT0gQ01EX0NNRFFfSVdDX0NBTkNFTF9UQVNLICYmIGNhbmNlbCkg
ew0KPiA+ICsJCS8qIGNhbmNlbCBjYXNlIG9ubHkgY29weSBjYW5jZWwgcmVzdWx0ICovDQo+ID4g
KwkJbWVtY3B5KGNhbmNlbCwgJml3Y19tc2ctPmNhbmNlbF90YXNrLCBzaXplb2YoKmNhbmNlbCkp
Ow0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiBpd2NfbXNnLT5yc3A7DQo+ID4gK30NCj4g
PiArDQo=

