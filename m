Return-Path: <linux-kernel+bounces-16265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4E5823BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 06:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A520CB24DB5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 05:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6F118E03;
	Thu,  4 Jan 2024 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="EFAjTMI1";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="I5d3szAn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAE51DFC5;
	Thu,  4 Jan 2024 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 086f14c4aac411ee9e680517dc993faa-20240104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=BYM63l627zzCJrkFmjcv7cC6PhOosAyUWJFhZG3FtMY=;
	b=EFAjTMI1aAfVfdskMq7+A3uxg3xmm92N6JPUykIUAUGLNuXfYqKzny7ojSdrNVcPw1JYPrzoQKkUl2MjHSt6Vh3doMm73mZ/RdjPuXfUrzqDe8z3DLkx2hgsEzSEKZtGr51vr2IkvBego6asUUVGKICjsvHVlTagcGD80t+XLz8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:8dea9362-0844-4c57-8287-1f78c496d83e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:3090ca2e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 086f14c4aac411ee9e680517dc993faa-20240104
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1304695173; Thu, 04 Jan 2024 13:42:22 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 4 Jan 2024 13:42:21 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 4 Jan 2024 13:42:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzuSq7NheEOVnb5G3XEegGKLeuFZkEE8u1zY9AFse4ZcVGdsg+BqTLv5oO1qa8+hwlwBxQq3Ee++35FcfoFiyYa4umKSmesgabKumPEYBLBen9/x+72rdqmrqSQ4vCj2DnWnBJXbf/gxiXQ/9/TBQxN5fLPQ6bbUm9pkPiuCRwb50W/ygY8xRAx2IjY5Ihob+pitObk68n8+MkkzhVhLxqu6GJbedZoNfuGPFihR3MwxAMbkRjOh/TqGvGkEa0L8FuclAF4fvLl3eqZ9gy2OvS9BrmuswqVzylAdgcXMyGXCxGtjhPQ4BPhhyj2S+KbXPNKJ1teJN2Ka1zL/wLCQCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYM63l627zzCJrkFmjcv7cC6PhOosAyUWJFhZG3FtMY=;
 b=dGjOxxI7w3RVqjpoYqdmw3lpG+XmayxaxSiZ/1jUp6jgQye3YA75xH+NlOHIhWxCuHHl1+kktKdaz9t4/4qJhzCPD1F0JAOzAY4glBWZ5tjgZ3ii+JXxPMWztHqPxyfOLobUSx+O5WzylwYNO1c/Yv3m/5OHrZZi9qrkN20Nsg/KmQpkDGnt3kZArj4Khb7uyeDbEThsz5i3hI2kgB8mlIIiDo/Ku15A7o5okBsH6sYoZQ+al2UtuT2OtIxcy8DbrwHkSr0zMSXL7lxGdnADnUgZP81fgAcBNx1zCUexND1SGvQ3Ok2+jxRssV5/vb5up6TvuOChNJny1Df57xBT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BYM63l627zzCJrkFmjcv7cC6PhOosAyUWJFhZG3FtMY=;
 b=I5d3szAnrNTli7K8+UF18ZVdZvLXwTSfJLFO8XghQWjS4lIUHFikGeS7C1sgMtnJgmc4y47F/2kWcEKo6gz6CTvdfF8jZHha0jkr03T3ddQdJ0JHZagkqKHoG2LPItunj5gbGCgGma49ogctUiGgz4n9m6e0l4w05JFuqtp+B3s=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PSAPR03MB5223.apcprd03.prod.outlook.com (2603:1096:301:4a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14; Thu, 4 Jan
 2024 05:42:17 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 05:42:17 +0000
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C+WDmAgAlkogCAAXuLAA==
Date: Thu, 4 Jan 2024 05:42:17 +0000
Message-ID: <fdd275452f99e3fa1b1b98be05151121858dcc60.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <c33745a4424777df44efe811dba060700f0009f0.camel@mediatek.com>
	 <a3b2f7c395e287c6d85bfbe1dd76525f3af076c9.camel@mediatek.com>
In-Reply-To: <a3b2f7c395e287c6d85bfbe1dd76525f3af076c9.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PSAPR03MB5223:EE_
x-ms-office365-filtering-correlation-id: 33c081dc-7c90-47a2-29e7-08dc0ce7e952
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dE8CWvCHnCrtGSqeaP1aKI5v74owlUKAmykB1L2wxXXwrJKRyZCFxxullHZjOgwNSCsO2n3DuAAh6yBksGDSpYeTWEPFusPmrYSrLkFgeTfcZtGUNtte0sRjvWhRSX7SYBOhXctclXnnXuxfQsS4RzdW+lqdvI5yzdpnOurFPxVoCg3oH556ijGzIssLichBmy10uaPVAeUZzeEc76Iwe3VKt4PoLHcywmuqUMbEA5CzTxmkvvWGDCS62aTH9vtKAHoJNIZ9zv2ny+JIXpaZhW1vcU1RRwOYlask06E2V16cS0Evz0rmDv+c9RXCTD7oT2Y7BOmPRZQOOKORgKimGRC5gVp8U1V6tOu12O6DtVcTcvJjzI5bGwFkpXQaxG598D808dWnZqG0TBgY+LbM8zQm9FRNsVu7lxb9voDsZOg/YOWp/yQynxqsiujaD7BhvvImPE+nlQhTwwzopdoV7xlsQMwdtm7i8sD4yIPOsjHpyUQyRczNMMjCBsU0nNiFt33zton4VN7GyV3qHAeCZd7gJLN9WuU2kaVIQ2Fmlxp9Ptp1I2ug1lVAjHeJC3oR51s/EJ3f6YGNvoW4xAF2Nrzaggo2VhhBSwqMwTbik5y3jh7ml8N2+QQBqaZ/Kh2J0a3SuqS7Iy2MicN1n8zhx4PfHqZrCX2bh33TUTtBdCg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(478600001)(54906003)(110136005)(4326008)(8676002)(8936002)(71200400001)(6486002)(66446008)(64756008)(76116006)(66556008)(66476007)(66946007)(2616005)(6512007)(6506007)(26005)(4001150100001)(15650500001)(2906002)(7416002)(5660300002)(41300700001)(83380400001)(38070700009)(85182001)(36756003)(38100700002)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnZaTStVcVhLNWZLWmRDQU5HWGpWOS9RS3JyM0pWMjJOZUNYZ1VRd1FZbVJD?=
 =?utf-8?B?V2drTXFlRzhtZVpIWC80b2RGUnRMV2FZMmpJbCt2Yk9IUjBncURWQjVLOHk1?=
 =?utf-8?B?Y3dmZ2p6U2sxNkdNSFJiZVVpS3Bzd0IyUWF4MXdzU3drTzBsa09JUDhpZk9r?=
 =?utf-8?B?bkNtZGUvMk1wS2JzR2NqZHJ3MExDSEVTT3lreTFxL1pZaGtvb2YyUnlRZXJR?=
 =?utf-8?B?MjFQZmhHOUJZdVZpekZKd3ozbUdQU3ZiMWN6ZVY0YmtsY3k4Q2tWOTl4d2Y0?=
 =?utf-8?B?UCtKOVJ4RE9UVldXQVVUbHBUVFJSYXBxWE9LbWRDVXgxVTBhTmFYZGZkcFFw?=
 =?utf-8?B?OHZBMWtrUndSbW1GSTZ0RkVzeHRmclJaK25lQmQ3clVEMUdqUzRZMHBhQmFL?=
 =?utf-8?B?WURxY2NXditXUVltQkUzN2IvcG5XNnRRWjZlTkdQWHJKREprWDVtR0ZwaGk0?=
 =?utf-8?B?Skg4QXp6YjhmMTJDSjNCclpGYXJveGVFYkQ3dnEvNGNpdHRPSXJCdmFuRkEy?=
 =?utf-8?B?RlJXdThpM2hmNUF0TEIwcTZDZ00xVXY5L3R0citkcmtITUp3QjlJUTVNMW5a?=
 =?utf-8?B?NjRreWhPVHlHSGtKeGJPc3RlSEJQY0l6aHYvVjg4T1NEYWV0S2MrelJ1ZVp3?=
 =?utf-8?B?VDloS1dRclpMd0ZualNaaTFaL2M1M3J0ZndhemZTKy9YT2hoVTRMVlppSkJC?=
 =?utf-8?B?UjI0dzhSK0NaM3dJS2YrQkJmSXhvNFJHZHlJTVg4WEtZb2F0N09UUmRaWEFG?=
 =?utf-8?B?YS8wcFFBMlVLYXVwQ2VVMXZlQ0N6NllhSk5LMzJxNDhqK1JYbEQ2YStyYTRz?=
 =?utf-8?B?VFY5UmtjMUtPMFV2Y1IwV2JTeklPaklZWGs3aVZOY2g3d1kzb0VLcDNIVE9U?=
 =?utf-8?B?WXFWQ3N4N09yakxXcktORUhIYkNsMyt6UzBtNzl2MVY5SlRXZUxJR0RsbUhF?=
 =?utf-8?B?ZUt2WnZiRkhBRGZLdmRZY25FSkZsdFcrWXQ3UUx4bU1ncmUvdjcrSjJsQVVS?=
 =?utf-8?B?c0xVQ2NqdkpGd0swS25jMytodVhFZkR4bGVTQzJGWmtsTVlLZkVEY09DS0dE?=
 =?utf-8?B?aG85NlZTZk9XTzNxdkN1OXhpTUduK3Z0Y3d3cWV1ZHJPOXFDbGwzRW14VzQ4?=
 =?utf-8?B?M1kwKzRVZjFzQjJYQ2lraTgrNzVzekg1cXdGT0lMdFlWeTJOcSswUmV3YzlM?=
 =?utf-8?B?YThGTHo3TUxTTlhTVFhYbVV2UzVUMCswVHY0czlyc3RDSGEvSTVielRJZ1pF?=
 =?utf-8?B?RytUV1lxRExINFhuTFVpZ3hPT0dQSjRTemlYU3dtMEVrYVlVdml2dFgxRlRQ?=
 =?utf-8?B?RnlEQnpZTnorQm1NV2FKczNRdnkzWlFOT3dITkp2U1czYkV4Wi8vZUczS2xG?=
 =?utf-8?B?MFByOTlyT3pEVjFoaXZ1N3MzZGZxRXlaUzV2K2d1VEVyZzJjZmV2aVp6L2Y3?=
 =?utf-8?B?MHVDTG1mNWdqamhCQ3dELzhzeWZJbGc1TEowZEVPQk13WlNKWXd3QUc1ZGNt?=
 =?utf-8?B?K3VQNFZFU3V1YnRqRlg5OGJZSnJHWTlqQ3hjdnlKOUFNaHZxcmpXYWlkUWRB?=
 =?utf-8?B?MXBOS0VNUWQvcVNUaDJyS1RQRGhLU083NnF5K3N0TTVPcnB0R2hhTkVGbU0w?=
 =?utf-8?B?UjMwL20xVEp2dDUvNG03Snp6T1V4TitlMmlrYld1Y2VQSm05QmZPV21RaHZl?=
 =?utf-8?B?NjJFZkExSFN5K0tFSUc0NWdKNmxPTFQwNTc5dFcwUmMvRFFNSkwyaS9UclI3?=
 =?utf-8?B?RjBwTFdkMXNCM2hieXo5Z3RyWFNlZ0MwdHBVa0F0eGdndW1vbEM3cGxJbG96?=
 =?utf-8?B?eTVydm0yQzFCZG5DSi91TjhpekdxeEU3ZFFBMkthWFAxejlMRU1NR2U3KzRN?=
 =?utf-8?B?WHhmc0daQy9ZQlc3NE5neEhtMzlqajAyMnlQc1Mva0NlZS9yT0xGN21SazJz?=
 =?utf-8?B?UWdlMUI3VklVS0hsQno2MkwrQy9DSC9ZYzJNemJjNHlER0ZkVjFnRUJ3NGQx?=
 =?utf-8?B?Sms0QXpwY09WQVc5OUJzYnZCeTNqYUt0U1M5M0NocmJSREo4MENUdlpPd0pa?=
 =?utf-8?B?cEMzbFZ3RUs1ejNxMUh2TkRHRWNpVFBmVVhjdlN4VzM5S0MvTXZLdmpheXlw?=
 =?utf-8?Q?tV6L335EyXtBRSyd78Sb8UHY5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50DFE390E36CA545AA6F47B15C2751EF@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c081dc-7c90-47a2-29e7-08dc0ce7e952
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2024 05:42:17.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xlrgo4m/YBexeaE/A0peEr7z/mH9geVpA6pOhWE1lYi58NyNz/QK9taHktnNPixTWG9oexVFBudHKEsoaPSPFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5223

SGksIEphc29uOg0KDQpPbiBXZWQsIDIwMjQtMDEtMDMgYXQgMDc6MDMgKzAwMDAsIEphc29uLUpI
IExpbiAo5p6X552/56WlKSB3cm90ZToNCj4gT24gVGh1LCAyMDIzLTEyLTI4IGF0IDA3OjM3ICsw
MDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90ZToNCj4gPiBIaSwgSmFzb246DQo+ID4gDQo+ID4g
T24gRnJpLCAyMDIzLTEyLTIyIGF0IDEyOjUyICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+
ID4gPiBUbyBzdXBwb3J0IHNlY3VyZSB2aWRlbyBwYXRoIGZlYXR1cmUsIEdDRSBoYXZlIHRvIHJl
YWQvd3JpdGUNCj4gPiA+IHJlZ2lzdGdlcnMNCj4gPiA+IGluIHRoZSBzZWN1cmUgd29ybGQuIEdD
RSB3aWxsIGVuYWJsZSB0aGUgc2VjdXJlIGFjY2VzcyBwZXJtaXNzaW9uDQo+ID4gPiB0bw0KPiA+
ID4gdGhlDQo+ID4gPiBIVyB3aG8gd2FudHMgdG8gYWNjZXNzIHRoZSBzZWN1cmUgY29udGVudCBi
dWZmZXIuDQo+ID4gPiANCj4gPiA+IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBt
YWtlIENNRFEgY2xpZW50IHVzZXIgaXMgYWJsZQ0KPiA+ID4gdG8NCj4gPiA+IHNlbmRpbmcgdGhl
aXIgSFcgc2V0dGluZ3MgdG8gdGhlIHNlY3VyZSB3b3JsZC4gU28gdGhhdCBHQ0UgY2FuDQo+ID4g
PiBleGVjdXRlDQo+ID4gPiBhbGwgaW5zdHJ1Y3Rpb25zIHRvIGNvbmZpZ3VyZSBIVyBpbiB0aGUg
c2VjdXJlIHdvcmxkLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4g
PGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gPiAtLS0NCj4gPiANCj4gPiBbc25pcF0N
Cj4gPiANCj4gPiA+ICsNCj4gPiA+ICtzdGF0aWMgYm9vbCBjbWRxX3NlY19pcnFfaGFuZGxlcihz
dHJ1Y3QgY21kcV9zZWNfdGhyZWFkDQo+ID4gPiAqc2VjX3RocmVhZCwNCj4gPiA+ICsJCQkJIGNv
bnN0IHUzMiBjb29raWUsIGNvbnN0IGludCBlcnIpDQo+ID4gPiArew0KPiA+ID4gKwlzdHJ1Y3Qg
Y21kcV9zZWNfdGFzayAqc2VjX3Rhc2s7DQo+ID4gPiArCXN0cnVjdCBjbWRxX3Rhc2sgKnRhc2ss
ICp0ZW1wLCAqY3VyX3Rhc2sgPSBOVUxMOw0KPiA+ID4gKwlzdHJ1Y3QgY21kcV9zZWMgKmNtZHEg
PSBjb250YWluZXJfb2Yoc2VjX3RocmVhZC0+dGhyZWFkLmNoYW4tDQo+ID4gPiA+IG1ib3gsIHN0
cnVjdCBjbWRxX3NlYywgbWJveCk7DQo+ID4gPiANCj4gPiA+ICsJdW5zaWduZWQgbG9uZyBmbGFn
czsNCj4gPiA+ICsJaW50IGRvbmU7DQo+ID4gPiArDQo+ID4gPiArCXNwaW5fbG9ja19pcnFzYXZl
KCZzZWNfdGhyZWFkLT50aHJlYWQuY2hhbi0+bG9jaywgZmxhZ3MpOw0KPiA+ID4gKwlpZiAoc2Vj
X3RocmVhZC0+d2FpdF9jb29raWUgPD0gY29va2llKQ0KPiA+ID4gKwkJZG9uZSA9IGNvb2tpZSAt
IHNlY190aHJlYWQtPndhaXRfY29va2llICsgMTsNCj4gPiA+ICsJZWxzZSBpZiAoc2VjX3RocmVh
ZC0+d2FpdF9jb29raWUgPT0gKGNvb2tpZSArIDEpICUNCj4gPiA+IENNRFFfTUFYX0NPT0tJRV9W
QUxVRSkNCj4gPiA+ICsJCWRvbmUgPSAwOw0KPiA+ID4gKwllbHNlDQo+ID4gPiArCQlkb25lID0g
Q01EUV9NQVhfQ09PS0lFX1ZBTFVFIC0gc2VjX3RocmVhZC0+d2FpdF9jb29raWUNCj4gPiA+ICsg
MSArIGNvb2tpZSArIDE7DQo+ID4gPiArDQo+ID4gPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfc2Fm
ZSh0YXNrLCB0ZW1wLCAmc2VjX3RocmVhZC0NCj4gPiA+ID4gdGhyZWFkLnRhc2tfYnVzeV9saXN0
LCBsaXN0X2VudHJ5KSB7DQo+ID4gPiANCj4gPiA+ICsJCWlmICghZG9uZSkNCj4gPiA+ICsJCQli
cmVhazsNCj4gPiA+ICsNCj4gPiA+ICsJCXNlY190YXNrID0gY29udGFpbmVyX29mKHRhc2ssIHN0
cnVjdCBjbWRxX3NlY190YXNrLA0KPiA+ID4gdGFzayk7DQo+ID4gPiArCQljbWRxX3NlY190YXNr
X2RvbmUoc2VjX3Rhc2ssIGVycik7DQo+ID4gPiArDQo+ID4gPiArCQlpZiAoc2VjX3RocmVhZC0+
dGFza19jbnQpDQo+ID4gPiArCQkJc2VjX3RocmVhZC0+dGFza19jbnQgLT0gMTsNCj4gPiA+ICsN
Cj4gPiA+ICsJCWRvbmUtLTsNCj4gPiA+ICsJfQ0KPiA+ID4gKw0KPiA+ID4gKwljdXJfdGFzayA9
IGxpc3RfZmlyc3RfZW50cnlfb3JfbnVsbCgmc2VjX3RocmVhZC0NCj4gPiA+ID4gdGhyZWFkLnRh
c2tfYnVzeV9saXN0LA0KPiA+ID4gDQo+ID4gPiArCQkJCQkgICAgc3RydWN0IGNtZHFfdGFzaywN
Cj4gPiA+IGxpc3RfZW50cnkpOw0KPiA+ID4gKwlpZiAoZXJyICYmIGN1cl90YXNrKSB7DQo+ID4g
PiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZzZWNfdGhyZWFkLT50aHJlYWQuY2hhbi0+bG9j
aywNCj4gPiA+IGZsYWdzKTsNCj4gPiA+ICsNCj4gPiA+ICsJCXNlY190YXNrID0gY29udGFpbmVy
X29mKGN1cl90YXNrLCBzdHJ1Y3QgY21kcV9zZWNfdGFzaywNCj4gPiA+IHRhc2spOw0KPiA+ID4g
Kw0KPiA+ID4gKwkJLyogZm9yIGVycm9yIHRhc2ssIGNhbmNlbCwgY2FsbGJhY2sgYW5kIGRvbmUg
Ki8NCj4gPiA+ICsJCW1lbXNldCgmY21kcS0+Y2FuY2VsLCAwLCBzaXplb2YoY21kcS0+Y2FuY2Vs
KSk7DQo+ID4gPiArCQljbWRxX3NlY190YXNrX3N1Ym1pdChjbWRxLCBzZWNfdGFzaywNCj4gPiA+
IENNRF9DTURRX0lXQ19DQU5DRUxfVEFTSywNCj4gPiA+ICsJCQkJICAgICBzZWNfdGhyZWFkLT5p
ZHgsICZjbWRxLT5jYW5jZWwpOw0KPiA+IA0KPiA+IGNtZHEtPmNhbmNlbCBpcyB1c2VsZXNzLCBz
byBkcm9wIGl0Lg0KPiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gQ0sNCj4gPiANCj4gDQo+IEkgdGhp
bmsgd2Ugc2hvdWxkIHVzZSB0aGlzIHRvIHRlbGwgQ01EUSBQVEEgd2hpY2ggdGhyZWFkIG5lZWQg
dG8NCj4gcmVzZXQNCj4gYW5kIHVwZGF0ZSBpdHMgY29va2llIHZhbHVlLCBzbyBDTURRIGNhbiBz
dGlsbCBtb3ZlIG9uIHdoZW4gZXJyb3INCj4gb2NjdXJzLg0KDQpDTURfQ01EUV9JV0NfQ0FOQ0VM
X1RBU0sgaXMgdXNlZCB0byB0ZWxsIENNRFEgUFRBIHdoaWNoIHRocmVhZCBuZWVkIHRvDQpyZXNl
dCBhbmQgdXBkYXRlIGl0cyBjb29raWUgdmFsdWUsIGFuZCBjbWRxLT5jYW5jZWwgaXMgdGhlIHJl
dHVybiB2YWx1ZS4gQnV0IHlvdSBkb2VzIG5vdCBwcm9jZXNzIHRoaXMgcmV0dXJuIHZhbHVlLCBz
byBkcm9wIGNtZHEtPmNhbmNlbC4NCg0KUmVnYXJkcywNCkNLDQoNCj4gDQo+IFJlZ2FyZHMsDQo+
IEphc29uLUpILkxpbg0K

