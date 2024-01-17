Return-Path: <linux-kernel+bounces-28461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C69882FECA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D66E8B23A1E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006B74687;
	Wed, 17 Jan 2024 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="n8aeSihb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="VYX0WOZt"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE208BE3;
	Wed, 17 Jan 2024 02:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458292; cv=fail; b=tMjlYDnDHtRv1Lhzf3xJ7DJK48PCwNEzWvbq+VCaMLxd7n3TyThphsFttH/kUsdy943hhEBhh959+K+UiwwhCbhAcICDcJqSp/xeQmL5iy64NLake7hTvaOP6rmIT6A5BsJ5rin8zsjzggLIj+2dI0raz95Qu4l3BLE4jYy3CAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458292; c=relaxed/simple;
	bh=Aoz3Aoxs4An6uWeF/GtsX9/vDD369l/SoYu419rm2VU=;
	h=X-UUID:DKIM-Signature:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-UUID:Received:Received:Received:
	 ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:From:To:CC:Subject:Thread-Topic:Thread-Index:
	 Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
	 Content-Transfer-Encoding:MIME-Version:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-TM-AS-Product-Ver:X-TM-AS-Result:X-TMASE-MatchedRID:
	 X-TM-AS-User-Approved-Sender:X-TM-AS-User-Blocked-Sender:
	 X-TMASE-Result:X-TMASE-Version:X-TM-SNTS-SMTP; b=ffSOn9OGNVkFEUpgLb6aFOaZGAiGuMrFHVjQwGcEtDi10kYPI8V8BNBPve7M1wBfq1nl6XNkqAuNkZsLvMBG7ArYNd9b1VwYyPgAFlvgNvpkoPv7kJRbpmgJSBzuFaB4y9Pwmm+y51uV7OGOskynNzp5/JyFOKa6OtN/BaP5JeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=n8aeSihb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=VYX0WOZt; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 9017b62cb4df11ee9e680517dc993faa-20240117
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=Aoz3Aoxs4An6uWeF/GtsX9/vDD369l/SoYu419rm2VU=;
	b=n8aeSihbaAVSFnjlEtTWreBYtxRIJSzta5CDu4yi1bZNzcRYgyEdWzPzJHz9ruPTcBFDZFevIbmbk5mDi9T+vTouWm8kbspgG2+nYcS/ESYBXGgplQBsJ5vbRIGcuPPeXCr9j+kYJdFUT/iusJGLN8qw/QzDhtf/17+zLCT9UCQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:25e17406-5432-43b9-b6e0-e18cfbbb6f09,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:3ab16d7f-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9017b62cb4df11ee9e680517dc993faa-20240117
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1947762337; Wed, 17 Jan 2024 10:24:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 Jan 2024 10:24:36 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 Jan 2024 10:24:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSBQRa0M+G6tX0/W8DNtMeYASXnjUkp/gD+8gcXsA6YgV9ijz7HF9wn/P+hPz5j3WJZWPCt5tt7GoazSpeB123qKQXoZtMCdYQj4dyU0YC1Y1FOVV+Z4j2Qy3DdMVAS3Ni+SE2MpAoBigHzNynaMlP8Dx1ph7vu/ThAWEO6PsITpAOTF3Se2XJ7EK9zsP8WuOUtuQ2UjVVGccgWHf/hw00SbIz4alu2cODjUZwv06ioKfn12Oo1S/ZBYuOcHAz0/R+FrXuj+fEUVIDh4vc2lLoDFmfGpV5GN4BKSm+VdkJVNNoOyMTrn4iDrXYcXpmOlnuZ3zLmlXgRV9hm+Xnns1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aoz3Aoxs4An6uWeF/GtsX9/vDD369l/SoYu419rm2VU=;
 b=Nux/1ttA5U6hx+5PQ8jcSJ67dp4tdru979BlYlusnod/zgdMWGpb3J56ZTrhasOL4ChyrevGeImPu6Jmu6CEiWH5epTN6kG/8/ImjkWgmEcFKHfHlBXS7J+xGdpa9Fc9b8TbrH4OVpP6Q0CWarIda4m8T3oC0DD5ud0U+ftXpwUp+Xq05znZRB0ptEa7HRLpbypwrrrpclbvgkhrgANTUuNf9UAxbZ8fbfE4ekZkpU1z1VUgf2oT6jzLRWZct6fGRwfmKVrWVSSS5jDJvqTcKp/aKPQXfarclxz7O8XQmOwwaOBdyWs6xHYE5HpDWve+LubkoOMEfJzZ0+TdqrVMdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aoz3Aoxs4An6uWeF/GtsX9/vDD369l/SoYu419rm2VU=;
 b=VYX0WOZtJrPgcX6tER42FKzuxkSOc4hQhXJt4bR7CvJnqQCM8NrS+ga9QfxFCCmFGwofQU9yqhcuzYUtEOdmZ6zogvrk47a8KyBPhnB7x3oX+ArxKmHJBjwdvZGtQakU9mXPahNgKh8dQOaKNwNanRhvM2G7CW7aHLN0gmQ9Hpk=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by JH0PR03MB8334.apcprd03.prod.outlook.com (2603:1096:990:49::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Wed, 17 Jan
 2024 02:24:32 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%5]) with mapi id 15.20.7202.020; Wed, 17 Jan 2024
 02:24:32 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, =?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?=
	<Nancy.Lin@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Thread-Topic: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Thread-Index: AQHaQ49Q/kjMpPuFZkuoMhc+qwpaZbDS2qqAgABkfoCAAaGoAIAA7laAgAVYtQCAAPr2AIAAl1uAgACXUIA=
Date: Wed, 17 Jan 2024 02:24:32 +0000
Message-ID: <ce2044f3b89e47517d7797e3684935ac3fb17fb5.camel@mediatek.com>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
	 <20240110063532.14124-3-jason-jh.lin@mediatek.com>
	 <20240110-grumbling-tattling-0202fc5e21f2@spud>
	 <8c4004d5b6f68dc096aaf2a537e429c310b60c08.camel@mediatek.com>
	 <20240111-anthology-dock-c60d28ac7f1c@spud>
	 <5eaccb10853215a6399759a715d2f0356782bac9.camel@mediatek.com>
	 <20240115-player-waltz-8efb5885a23f@spud>
	 <4f1e6bdb3e266cf0e89f8a664095ea1709f9afe0.camel@mediatek.com>
	 <20240116-cancel-perpetual-08320e21ec33@spud>
In-Reply-To: <20240116-cancel-perpetual-08320e21ec33@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|JH0PR03MB8334:EE_
x-ms-office365-filtering-correlation-id: d648bff8-862b-49b1-b5ee-08dc170370eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jH5zt1RMe2PA8V/xbM9cYTpX/dt8rPHU1wEBGQNKh2xI7h9zOR7AOouAPNjQQ/dU0kZfOo4ZNcCRVu6oWvfn/xqk2rEnO3N9/aLIZy/KSzQmdfsQ/iwF0CEwuT/vUzdV1X8VXr07ASl6o+HzBpn9r66rdIgDV0dXNjiziM5o3UrFRYo6SyL/cpIV4fnm6XvbQDtIWhcrvpUXWoEThOVHcrFqaBe3Ny2Ts97qOQgV1J8ziGpuZL9pw9xs7TFYR/GB7d8mWzUasJjZeX5+CuBErRMmAJpzEz6g852cZ0Jf8PSPz3NI9IaaP0Gb2WcrIXyT701ljD0mPyjdXMIqVDLBbGjy/ulLPEodTVzqDRBKt2bYQPHZu3X/AwkXfArhxy/fOTN5YkiCdYs+4HTzwKMUQ/nFxVSGVybp1zoZ0qQyT0j8eH1DoejZN2lpttEfQh30FW7J9MDXIzA+N5exCLcEz82E6HBv+q/UO/lp/sa2ha8fUcCMvDE0afEMQKk22caMkqbW1psczz29gRuR9vU/qovK2qadmIa9+hyf0qZt+aLPFLIErzBj63fCRXkVi2mu4OeWAzLH4j1fGaukBZ+ED/RQw98ZZzhO76OluTMmdO+CheyOHCwruSLKNpgquh70
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(346002)(396003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(85182001)(76116006)(36756003)(86362001)(41300700001)(38070700009)(122000001)(478600001)(91956017)(6512007)(2616005)(26005)(66556008)(5660300002)(15650500001)(71200400001)(2906002)(8936002)(66476007)(54906003)(6506007)(316002)(38100700002)(66446008)(6916009)(66946007)(7416002)(64756008)(8676002)(4326008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0pPNWFwcUN3V1V5RmxaQllsMlhsSDJzZFlGdnJ4K1I0UlJBZlYzMng3Q3dZ?=
 =?utf-8?B?R2hneDQ3S2pLc0F5RkdOenAzVUtab2M0ek5JRW5BcUZZOUlrU2hMcHpqR1lH?=
 =?utf-8?B?bENQK0xZd3B4YmI4UnNFQnlQVHlaMno3RE1UTmh5RHBXQWVwSlVZTVFFUUdT?=
 =?utf-8?B?SVltWGVoNWY4eWpYWGtUTHBKUkhqSmJTNnpFOFkyRWY2VEx1NHhubFRCM3JZ?=
 =?utf-8?B?djl2Q1RxaEJYVFNNRnNHZXFFVXlMb3U3L2Z5dWRtRWhXZlNKNFFXR1hVd3Qz?=
 =?utf-8?B?c3k4NnZGMmx1ZnZ4WkR5MTJGb2tKbW5OcGV4SzBxeE5Xbm9iSHdFMTlUK2F3?=
 =?utf-8?B?ME5WMUZteW14cHRtTVdHcXFBV2REU1VkOVJSdEJka25lTTI1VmRwNEFpb1FK?=
 =?utf-8?B?MG9vbXh5TS9xb0tHRkNBU0FSSzlUVGdIOG9VbzJncjdUMEhiQXJoZ2F1VGVk?=
 =?utf-8?B?QmtRUnRrazR6ZTdIRndrV0NNNEROYjd0T0JlREk4WGYwaFgrOW9FUWhqckMv?=
 =?utf-8?B?UFFsR2RhSVhIb21YeUxHdENYcGNUTDRDRW1pSTllNVJ1cDdaSjhLNStKWFB4?=
 =?utf-8?B?Tm53ajVtWm1heW5SWkhPYTRKc0lvRFU4a0hvMm9yUG1KQlNVUjlPeVNMRE1I?=
 =?utf-8?B?LzAyYzVaVE9TSS9BL2VLNFRXYjViWnFkdjZFVUxWR3BORHRZR3F3Y3RHbkpT?=
 =?utf-8?B?RFc4UXhvRGJqUGdQMUFyU0xBZkFKaXM2TlJRRCtFZXVwSkExdGcvblFIYm9S?=
 =?utf-8?B?c2FTRldheXprbW9aTXRpVFVaTXVSU1M4aXFsdUh1VWlOc2R0bFJkQkdJOCtz?=
 =?utf-8?B?N2dGMGVlZ2RVdE8zY0FCYTZOV3ZML1pFNHFHZVFZUE82cmV3NVRETHFvbXRG?=
 =?utf-8?B?YkdsSHlDcDM2MzBlRVJ2S1FGZkJ1RlJZQTBneFM4eWRwd3Uwc25DbVJPQk9K?=
 =?utf-8?B?TXIwa1IrU2dvQllzNDRBU2locUJlNHlkZ01EdlBvRk9BSENNQ2l1OW1kdkxE?=
 =?utf-8?B?TnNnbkR0d2c2OXEwZ1BUanpLRzUxNVhsTzhTYUJQdmxsVU5WMmR5WUw0UGdY?=
 =?utf-8?B?YXNuWExhV0FETmdGRFZIdkVROEluOEVDNzJLOW9VMHFkeWVVMzNqOFZiMU5I?=
 =?utf-8?B?TC9RNzd1RWZYTnorK0huVG11RWRlRk1JcFhPMHR4UkpJZjZ4Y09samdURFpi?=
 =?utf-8?B?RktSVVNiYitWQWtSWXdMZmlSZEM1UU9lTVlONzFkOHo2OE43VldDR1pFajdy?=
 =?utf-8?B?WWsvcEpwdHBNTVhxYlNuNjhMVGw0dzRlOTNGTlF1RTAyc3RVK2QxaEhhdDJM?=
 =?utf-8?B?WnEvQzJtVUk5WDlCYThtNFlCQVpFb0twZSs0R0phbWgxN2FYWFZNQnh1MTF6?=
 =?utf-8?B?L2JLYkZNSEJwYkVIKzl4c0gwL3Y2SWVGeVBsOVNYVGwxMkN2M1NUNkFVVTZN?=
 =?utf-8?B?WG5pNmFTTG9LbHRraXE0VWlDNXNoaEVYT1dsUmZzUnR4UGh5RXRCZU5UQS85?=
 =?utf-8?B?TjRTVVpoaFkvOTI1VStaSjRvUUlOSXlJYm5VSTRFWGNNQTRtUjljQVlmVHFD?=
 =?utf-8?B?Q0ZlR3VtelQvRThieHkrWmp3OUZDVjY3Nm1RSVJYcEhvTXFTYjRKZksyNlRr?=
 =?utf-8?B?MGV1YmdScjJPOEViYW9TWlduU0N5WXozU0p2ZmQvdFdJOWR3MVFuRHlZRTVm?=
 =?utf-8?B?ZUNVOC9ZWTNuTGxDaVNJeE5qWGg2OFNDWjg2Zm9hOVA2WiszVzRhQ04zdWVR?=
 =?utf-8?B?MVJXNDFLL3p2S2xnaVo1UnpjTWg3c2t6ZEpSQ3RhVTV2ZXR5WkpXbE8rbHJs?=
 =?utf-8?B?RVJSTUtqMHdhYVFiQ0hESllWR1l4ODM1NVFEblNSVVBnL21FaTlkb2N3Z25N?=
 =?utf-8?B?SnpMcHRub2d6a0d3bTMvNi9BakdHTXA5Zk5WM3lkNitZWTk0bUMwNmFuZk9l?=
 =?utf-8?B?Z2RDWWxQM004LzkvY0NoUXNXVGNpMndveVlhQkZnanhoTGJUZmZVTUN1SENr?=
 =?utf-8?B?aEFZVWgxOHBUOHV1SW55aTFrekVCNnc2QkZEc3VZNitiVFNEbWhNb2JhekFG?=
 =?utf-8?B?KzYyYUVtclJycmdDYlhwUjllbkVWVC9waFl0K0dOVFcwalJkYnlBUVcrOXJK?=
 =?utf-8?B?bElpeVkreVlza2lwYk9Fc1BIM3FzVXdmeWd5TENYd0N3c3NrZlNJZUpoOW12?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D3D4327E889AAB439E0B728A462A1BB6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d648bff8-862b-49b1-b5ee-08dc170370eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2024 02:24:32.6294
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nI/kvFBtg+azgqEu5vCS8AajH1y5uESgsM3BiPyyV2C2oGRKPNh9Apy4xahxeQXhTbWT6quyB3/3kn7VpyUZc+Uk99jrVcthEiNPeVPy2yI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8334
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--20.373900-8.000000
X-TMASE-MatchedRID: 6otD/cJAac0OwH4pD14DsPHkpkyUphL9fjJOgArMOCZV1lQ/Hn0TOsYS
	7f9q03FJIWwPHhGKUOgt9Hrwzo1Oe95yRi6HwLg5kdRuK7C3A1leu73mFK6GNIokuE0bLiKwEwa
	0+RTIVt3vAkvb7xTgsch2Rq1a1/nAlOnw5adVFsW8coKUcaOOvdZKsq3DGpalW+jwVKpqvlJRTm
	J1jjwch5VsEH/NobswjKD+OrKh5L2H6FJxCilEmbdQIb8hCnY+mX+W7bzPOQG1mUU06Uh6IGDbU
	AcMOUZ0XPYWFnRViiSmGoA01AmmltCjuUhsbmmkTSPNp9e/u1OeimGtNywjtpsoi2XrUn/J+ZL5
	o+vRV7xJeFvFlVDkf46HM5rqDwqtlExlQIQeRG0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.373900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	A344200C8DBEA6B0384DF549F238AB6F727ACA51609F657F0DF61F26CE2C39502000:8

T24gVHVlLCAyMDI0LTAxLTE2IGF0IDE3OjIyICswMDAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFR1ZSwgSmFuIDE2LCAyMDI0IGF0IDA4OjIxOjE1QU0gKzAwMDAsIEphc29uLUpIIExpbiAo
5p6X552/56WlKSB3cm90ZToNCj4gPiBPbiBNb24sIDIwMjQtMDEtMTUgYXQgMTc6MjMgKzAwMDAs
IENvbm9yIERvb2xleSB3cm90ZToNCj4gPiA+IE9uIEZyaSwgSmFuIDEyLCAyMDI0IGF0IDA3OjQ0
OjEzQU0gKzAwMDAsIEphc29uLUpIIExpbiAo5p6X552/56WlKQ0KPiA+ID4gd3JvdGU6DQo+ID4g
PiA+IE9uIFRodSwgMjAyNC0wMS0xMSBhdCAxNzozMSArMDAwMCwgQ29ub3IgRG9vbGV5IHdyb3Rl
Og0KPiA+ID4gPiA+IE9uIFdlZCwgSmFuIDEwLCAyMDI0IGF0IDA0OjM2OjIwUE0gKzAwMDAsIEph
c29uLUpIIExpbiAo5p6X552/56WlKQ0KPiA+ID4gPiA+ID4gMi4gV2UnbGwgaGF2ZSB0aGUgc2Vj
dXJlIENNRFEgbWFpbGJveCBkcml2ZXIgaW4gdGhlIGZ1dHVyZQ0KPiA+ID4gPiA+ID4gcGF0Y2gN
Cj4gPiA+ID4gPiA+IFsxXS4NCj4gPiA+ID4gPiA+IEl0IHdpbGwgcmVxdWVzdCBvciByZXNlcnZl
IGEgbWFpbGJveCBjaGFubmVsLCB3aGljaCBpcyBhDQo+ID4gPiA+ID4gPiBkZWRpY2F0ZQ0KPiA+
ID4gPiA+ID4gR0NFDQo+ID4gPiA+ID4gPiB0aHJlYWQsIGFzIGEgc2VjdXJlIElSUSBoYW5kbGVy
LiBUaGlzIEdDRSB0aHJlYWQgZXhlY3V0ZXMgYQ0KPiA+ID4gPiA+ID4gbG9vcGluZw0KPiA+ID4g
PiA+ID4gaW5zdHJ1Y3Rpb24gc2V0IHRoYXQga2VlcHMgd2FpdGluZyBmb3IgdGhlIGdjZS1ldmVu
dCBzZXQNCj4gPiA+ID4gPiA+IGZyb20NCj4gPiA+ID4gPiA+IGFub3RoZXINCj4gPiA+ID4gPiA+
IEdDRSB0aHJlYWQgaW4gdGhlIHNlY3VyZSB3b3JsZC4gU28gd2UgYWxzbyBuZWVkIHRvIHRlbGwg
dGhlDQo+ID4gPiA+ID4gPiBDTURRDQo+ID4gPiA+ID4gPiBkcml2ZXINCj4gPiA+ID4gPiA+IHdo
YXQgZ2NlLWV2ZW50IG5lZWQgdG8gYmUgd2FpdGVkLg0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IERp
dHRvIGhlcmUsIHdoYXQgbGV2ZWwgZG9lcyB0aGlzIHZhcnkgYXQ/IERvIGRpZmZlcmVudCBTb0Nz
DQo+ID4gPiA+ID4gb3INCj4gPiA+ID4gPiBkaWZmZXJlbnQNCj4gPiA+ID4gPiBib2FyZHMvcGxh
dGZvcm1zIGRpY3RhdGUgdGhlIHZhbHVlPw0KPiA+ID4gPiANCj4gPiA+ID4gSXQncyBhIFNvQyBs
ZXZlbCwgdGhlIFNvQyBzdXBwb3J0cyBzZWN1cmUgZmVhdHVyZSB3aWxsIG5lZWQNCj4gPiA+ID4g
dGhpcw0KPiA+ID4gPiBwcm9wZXJ0eS4NCj4gPiA+ID4gDQo+ID4gPiA+ID4gQ291bGQgdGhpcyBj
aGFubmVsIGJlIGRldGVybWluZWQgZnJvbSB0aGUgc29jLXNwZWNpZmljDQo+ID4gPiA+ID4gY29t
cGF0aWJsZT8NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBJbiBvdGhlciB3b3JkcywgcGxlYXNlIGV4
cGxhaW4gaW4geW91ciBjb21taXQgbWVzc2FnZSB3aHkNCj4gPiA+ID4gPiB0aGlzDQo+ID4gPiA+
ID4gcmVxdWlyZXMNCj4gPiA+ID4gPiBhIHByb3BlcnR5IGFuZCBpcyBub3QgZGV0ZWN0YWJsZSBm
cm9tIGFueSBleGlzdGluZyBtZWNoYW5pc20uDQo+ID4gPiA+ID4gRnJvbQ0KPiA+ID4gPiA+IHJl
YWRpbmcgdGhpcyBJIGRvbid0IGtub3cgd2hhdCBpcyBwcmV2ZW50aW5nIHRoZSBzZWN1cmUNCj4g
PiA+ID4gPiBtYWlsYm94DQo+ID4gPiA+ID4gY2hhbm5lbA0KPiA+ID4gPiA+IGZyb20gcGlja2lu
ZyBhICJyYW5kb20iIHVudXNlZCBjaGFubmVsLg0KPiA+ID4gPiANCj4gPiA+ID4gVGhlIHNlY3Vy
ZSBjaGFubmVsIGNvdWxkIGJlIGRlZGljYXRlZCBmcm9tIHRoZSBzb2Mtc3BlY2lmaWMNCj4gPiA+
ID4gY29tcGF0aWJsZSwNCj4gPiA+ID4gYnV0IHRoZSBldmVudCBJRCBjb3VsZG4ndC4NCj4gPiA+
ID4gDQo+ID4gPiA+IFRoZSBzYW1lIGV2ZW50IHNpZ25hbCBjb3JyZXNwb25kaW5nIGV2ZW50IElE
IG1heSBjaGFuZ2VzIGluDQo+ID4gPiA+IGRpZmZlcmVudA0KPiA+ID4gPiBTb0MuDQo+ID4gPiA+
IEUuZy4NCj4gPiA+ID4gVGhlIEhXIGV2ZW50IHNpZ25hbCBmb3IgQ01EUV9FVkVOVF9WRE8wX01V
VEVYX1NUUkVBTV9ET05FXzAgaXMNCj4gPiA+ID4gY29ycmVzcG9uZGluZyB0byBHQ0UgZXZlbnQg
SUQ6IDU3NCBpbiBNVDgxODgsIGJ1dCBpdCdzDQo+ID4gPiA+IGNvcnJlc3BvbmRpbmcgdG8NCj4g
PiA+ID4gZXZlbnRJRDogNTk3IGluIE1UODE5NS4NCj4gPiA+IA0KPiA+ID4gSXMgaXQgYWx3YXlz
IDU3NCBpbiBNVDgxODggYW5kIGFsd2F5cyA1OTcgaW4gTVQ4MTk1Pw0KPiA+ID4gDQo+ID4gDQo+
ID4gWWVzLCBzb21lIGdjZS1ldmVudHMgYXJlIGhhcmR3YXJlIGJvdW5kIGFuZCB0aGV5IGNhbiBu
b3QgY2hhbmdlIGJ5DQo+ID4gc29mdHdhcmUuIEZvciBleGFtcGxlLCBpbiBNVDgxOTUsIHdoZW4g
VkRPMF9NVVRFWCBpcyBzdHJlYW0gZG9uZSwNCj4gPiBWRE9fTVVURVggd2lsbCBzZW5kIGFuIGV2
ZW50IHNpZ25hbCB0byBHQ0UsIGFuZCB0aGUgdmFsdWUgb2YgZXZlbnQNCj4gPiBJRDo1OTcgd2ls
bCBiZSBzZXQgdG8gMS4gSW4gTVQ4MTg4LCB0aGUgdmFsdWUgb2YgZXZlbnQgSUQ6IDU3NCB3aWxs
DQo+ID4gYmUNCj4gPiBzZXQgdG8gMSB3aGVuIFZPRDBfTVVURVggaXMgc3RyZWFtIGRvbmUuDQo+
ID4gDQo+ID4gU29tZSBvZiBnY2UtZXZlbnRzIGFyZSBub3QgaGFyZHdhcmUgYm91bmQgYW5kIHRo
ZXkgY2FuIGNoYW5nZSBieQ0KPiA+IHNvZnR3YXJlLiBGb3IgZXhhbXBsZSwgaW4gTVQ4MTg4LCB3
ZSBjYW4gdGFrZSB0aGUgZXZlbnQgSUQ6IDg1NQ0KPiA+IHRoYXQgaXMNCj4gPiBub3QgYm91bmQg
dG8gYW55IGhhcmR3YXJlIHRvIHNldCBpdHMgdmFsdWUgdG8gMSB3aGVuIHRoZSBkcml2ZXIgaW4N
Cj4gPiBzZWN1cmUgd29ybGQgY29tcGxldGVzIGEgdGFzay4gQnV0IGluIE1UODE5NSwgdGhlIGV2
ZW50IElEOiA4NTUgaXMNCj4gPiBhbHJlYWR5IGJvdW5kIHRvIFZERUNfTEFUMSwgc28gd2UgaGF2
ZSB0byB0YWtlIGFub3RoZXIgZXZlbnQgSUQgdG8NCj4gPiBhY2hpZXZlIHRoZSBzYW1lIHB1cnBv
c2UuDQo+ID4gVGhpcyBldmVudCBJRCBjYW4gYmUgY2hhbmdlIHRvIGFueSBJRHMgdGhhdCBpcyBu
b3QgYm91bmQgdG8gYW55DQo+ID4gaGFyZHdhcmUNCj4gPiBhbmQgaXMgbm90IHVzZWQgaW4gYW55
IHNvZnR3YXJlIGRyaXZlciB5ZXQuDQo+ID4gV2UgY2FuIHNlZSBpZiB0aGUgZXZlbnQgSUQgaXMg
Ym91bmQgdG8gdGhlIGhhcmR3YXJlIG9yIGlzIHVzZWQgYnkNCj4gPiBzb2Z0d2FyZSBkcml2ZXIg
aW4gdGhlIGhlYWRlcg0KPiA+IGluY2x1ZGUvZGUtYmluZGluZ3MvbWFpbGJveC9tZWRpYXRlayxt
dDgxODgtZ2NlLmguDQo+IA0KPiBJIHNlZS4gQnJpbmcgdGhpcyBwYXJ0aWN1bGFyIHBhdGNoIGJh
Y2sgd2l0aCB5b3VyIGZ1dHVyZSBzZXJpZXMgdGhhdA0KPiBhZGRzIHN1cHBvcnQgZm9yIHRoZSBz
ZWN1cmUgY2hhbm5lbCB0aGVuLg0KPiANCg0KT0ssIEknbGwgbW92ZSB0aGlzIHBhcnRpY3VsYXIg
cGF0Y2ggdG8gdGhlIGZ1dHVyZSBzZWN1cmUgc2VyaWVzIHRoYXQNCmFkZHMgc3VwcG9ydCBmb3Ig
dGhlIHNlY3VyZSBjaGFubmVsLiBUaGFua3MhDQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0K
PiBUaGFua3MsDQo+IENvbm9yLg0K

