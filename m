Return-Path: <linux-kernel+bounces-655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A35C81441E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 10:06:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2342284642
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E03D171BA;
	Fri, 15 Dec 2023 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PUCqbCX/";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tAa8SLTW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7373611C9A
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 387bafb09b2911eea5db2bebc7c28f94-20231215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tK627M1BClTQd0wPk2xCqiEiooYvfgLcBQOHI2nv6Eo=;
	b=PUCqbCX/Qeyjv0chPWn1BN0noFLFdYxFq8dKyV3nSwVwlk3bR9f6T8x3b3KcNHxVllUkMD6jwm6N5AX2EDumusEU4whYVik8Tx+soY1/06tHkXyJY54oKkgBic2bR4Vtfs0XVM0KyEfB/u57MeLMNDfh164zisCVx+t963GAAoc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:dce6ded5-5192-4d2b-97dd-3628677d35d2,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:f89db5fd-4a48-46e2-b946-12f04f20af8c,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
	NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 387bafb09b2911eea5db2bebc7c28f94-20231215
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2092197783; Fri, 15 Dec 2023 17:06:23 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 15 Dec 2023 17:06:22 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 15 Dec 2023 17:06:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZmPc6GaQOBzTad+dTrWnKfg3FjplA+yoQd0b7hZ7bGV3HFiCoG38fw+BPAkBNqRP4hIMs/bSAZjSswt2iHmov9qVy8gEOshi09rNh6x8s5jDsqdCuXb3kZ0B5gB/WuPR2wUqSKMduQSdGzUS5fvWKFZ92VhWxWrCy96EKXsW5yZn0b5mb1CC+gOqm1tfdDz0G2E9qQoB92rzVvDH5sOQN9bLW7fUfSi76IBLIN+18QKaE7Eo7SR27G+EQBBcgWVsJwVHaKHig71YXfEY5WuR5n/rkYbdnykiMrgTAUstt7wSdiWG6lIOrJG9fOdIzrctYozeMV/kFnDxdVePqF0jwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tK627M1BClTQd0wPk2xCqiEiooYvfgLcBQOHI2nv6Eo=;
 b=Teb3Q+uh5pUen5rkI7517vO3r+RTrLQI6xzbEALshFP60CzMihlWkKhGftxzI4k6SwatzxP9tzcbSnqW/BoVYtDeWCn/hgdhF/ucAVpV5fBnxMF03ZdPAychbj/dTJa/uzzxsloY65tUDL3Okk3pqdRxHN1Ehtq/C7LOD4Y4aj3UWyh3gRnkvdaJfO2ItuDW2jV81/vVtFS4I9sFIxs+p7zVO7OkQ+jqvk2k7WZL2MWXAv6/KPe6zphYKYqlsSlhtVv3h2tkI4BT4EAQsM5iYL9/WFSQts7d0f+7us5DrK2aPei2JkPkzTlWH/5K3u3F8kmEG5Jppp043nw1c/snJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tK627M1BClTQd0wPk2xCqiEiooYvfgLcBQOHI2nv6Eo=;
 b=tAa8SLTW0jes7NW2pPIhBwcOzmYHXUlU4WuqlYNq6GQM1O3W6lWmbur6Gp1/CTuV9N8k43HP9kQZmBGhpU4NcTtzmv3hm42fEjAJ+qA7VIPkhd0ua9gYPCrmzVgSDPMfeN+gNUzO0wjcklyJ6sczWgWV2p4k1sPIEkOMQPPtqdU=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by TYSPR03MB8467.apcprd03.prod.outlook.com (2603:1096:405:5b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.29; Fri, 15 Dec
 2023 09:06:20 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7068.031; Fri, 15 Dec 2023
 09:06:20 +0000
From: =?utf-8?B?Q0sgSHUgKOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>
To: "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	=?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>,
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
Subject: Re: [PATCH v2 1/3] mailbox: mtk-cmdq: Rename gce_plat variable with
 SoC name postfix
Thread-Topic: [PATCH v2 1/3] mailbox: mtk-cmdq: Rename gce_plat variable with
 SoC name postfix
Thread-Index: AQHaLzVWYsalZaPkzEq43eULaR8QqrCqDYOA
Date: Fri, 15 Dec 2023 09:06:20 +0000
Message-ID: <7a5b2c164c0c8dc6b1ac0742c6f3cf2b4a4ca7a6.camel@mediatek.com>
References: <20231215070026.2507-1-jason-jh.lin@mediatek.com>
	 <20231215070026.2507-2-jason-jh.lin@mediatek.com>
In-Reply-To: <20231215070026.2507-2-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|TYSPR03MB8467:EE_
x-ms-office365-filtering-correlation-id: 658c963e-36c6-45de-d5ca-08dbfd4d1a68
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2FaRy2dPra04SxbZPOundjMUbKll25PMtTF3Zc0J6WA9vah0PsjOJ2/AioK5au7FgbIm6CtCA0ITiYpawDDPAim8fembabdmmKWSEDXz8JthT8a0hWsifGYarLBj1gX0AVs/zP9rk4Lu4c2r/SD7pEUHav6sKZK2gpfNOceWXNQGWqEQvaSksz66HFdacc3xcexulp4cZfj5iNrXQsDYumOvCN1zOKt72GV8Y6SfOAj/eW9JO0HRohTsnLhKFnDbJZsBRrCjQYPxi2rkOWnCceQeC9Ylv5Jr1tqwwiGfomI98zs8pEijEiE3lFfa4q/NevxVoQYikI9nL/SquThff1OMP3cEk7CzlKXtUoOWh79mFqOr/0rOrucVQYnsAYSupuKRZAh46/NfXUuHqr6b4If3XVmI1dxU5SBZ99/atiZgkj0cJEBlZF1WSY+sWIsI4EIzgIyl4cuI7QrYoOYd64BIODoAnKaOzr/c6giEUFWs3ZTzailVcisA8FBp0Kv8mizDRGBDl5feCRfNvj3YZqtZeKQSqcxYQlVutx9WbBnQW3cTyW5/ihPOVg+ymLk/9UIwp/9BNBKZe6MuyjmXJivlBQzlLbgW4QgahzE7aIzc8f/UO4tl2zDUvWkm/k3N2GWMjEhE30c026Vf8cV+LFbXP0/woiC6V1FuktlAysk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(8676002)(4326008)(8936002)(6486002)(110136005)(66476007)(54906003)(64756008)(66446008)(76116006)(478600001)(66556008)(66946007)(316002)(71200400001)(6512007)(86362001)(2616005)(83380400001)(38100700002)(5660300002)(15650500001)(4001150100001)(85182001)(36756003)(6506007)(38070700009)(122000001)(26005)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N252N0IwWkh2d2wya1FsUzJTVmU0TXVUd2xCUFo2NHBUU0wrNE4reGpvODdO?=
 =?utf-8?B?WGp0L2hXUzVUMzlYR1ErUDY5STF3MHoyck4xb1cxcHdxL3FrdGpZTjA0VzEy?=
 =?utf-8?B?T1Yyd2pyTnJIaW81YTdYV2FjRzJLRXJwdm5Ld0NyL0hRTDBibUVZaHZxZ3dN?=
 =?utf-8?B?Z0ZQMzd6WFlBQ2F2ZC9yb3g0MlNDMmpZTFd0UFVpQ1RNVmJWNytsNERRWGM2?=
 =?utf-8?B?WExQMk9helk5YWNURlJTY2ovSDRkbGFUQWlzVU0zZGdkV2tQTEtOd01ldjRz?=
 =?utf-8?B?VzIwRzUrNklNNzR6cnpVS0J0RER2NHZtZ0pUOTF4WEhsSHpLcTM4TVZIUUQw?=
 =?utf-8?B?SGtVNkVTcnM5NExac0pKbytTR09odmxzOGlxeHIxUFQ4bkNCVjhXWTR5VDR3?=
 =?utf-8?B?WStuS0tHZXE3WWlYVHJoZkxHc1BLcTBFcExqUWw5VC9XYS9SOUp4MU8wT3Z0?=
 =?utf-8?B?WkVBOVNlaVZKblhBYlZDOC8yc2pjNEZVWCtZZGY5d0loWGFoYUd4bXlUbWky?=
 =?utf-8?B?Tk0yK21sUTRJNnJNUEQ0b2l5NXp5ei9UbStNNngvdkdpOEgwZVh2MndRZ1oy?=
 =?utf-8?B?ek1FTndiTG02ZHprbHdhdEI5VmNnZ1Y2WjZ0cGZQR2F0NGFyV2VkTi8wWm1Y?=
 =?utf-8?B?MlNldkdmckNzZkpqK1VVZmw3SitlQ1YxdWd1b1NoRURqbVhXNlFzeElCRldZ?=
 =?utf-8?B?Uk95NnZSMmRSd1JuRW5FelBIMEF6RXc5Mkc3MDBSQzZUSmljSUtDNXp6RFdY?=
 =?utf-8?B?ZDdDY0k3SlNnSUMxYTdQdGZ3UitmZXNzWkQzd1pCSFFsVVVIVzdtaUJneG1K?=
 =?utf-8?B?aUhRZWpVMnJhWENsNTFzZGl4a0FyMWNsTU5RelNuUXdMMktpUkxKei9DejJ2?=
 =?utf-8?B?ZHJkTVdlY0gzeGJrQXAwY0NxNHYyK3hmU3FJY3pRUHh3R1d6YUhZZkVDcHkz?=
 =?utf-8?B?WHV4dnE5RjRjZWxuTFg1bjR3RUY0UXM0eGlGQmxub0NOU2tjd1JxNUlSbFl0?=
 =?utf-8?B?aXdhaWIvbWZRc0d5UkNTRlg5TnZlQnFVRExqdnNsNFVDbVVheUlyQmI4UC9n?=
 =?utf-8?B?VDlFQ0t4amdXM2dOcEpKVnlGeFgzQVl1YzJSdm56Rk5EWlB4ZVFpdE9JWHlG?=
 =?utf-8?B?Rys4bWtMOHlYYjlzTS85c05iSWxwVFpIaC9JZnBJKzBMMy84dzJCbjVxVXZa?=
 =?utf-8?B?MnVRcXVva0N6OEtONE43bEcwbW9CeGpZcTBOL1pqMGxHcis3NWxxZ1ZzYmZ5?=
 =?utf-8?B?K2RVcjhQcWViZmFYQlBRc3JMcmFtRElIYkhzOWVFbEZ2VmUvWWR6cHJ1ZENw?=
 =?utf-8?B?R3I4T3NPc2JLekMvWU1tRXpNY0l3ZTdLMzEzaGJOSDVxYllQRk1IeE4yaWo1?=
 =?utf-8?B?eXRmWG96SUdWTTB4MjVRZjdkZ3B6cjczV2FJRW8rWFZpU05FeHVxWS9vRkx0?=
 =?utf-8?B?YWZzb0ttaDlUN0NzWW0vRWNhejRxU0k2ZjVEdTZiUk5rT0ZpUW96bWthREpu?=
 =?utf-8?B?eUlaZlRCc1Z2VlVjUXdtUk5kbmJxamxUM0x1VlpNY1pPQmZFR2tibnVITDk0?=
 =?utf-8?B?cHdsNzNEeWE4aHFRd0VsVWxKTGcrQjVJc0Vvc3kzRVU1LzgzelJlOEZpTGRm?=
 =?utf-8?B?OHU4OTNXeGJ3TjRWeUxTR1oxaDVKZ2EvSzl1bVlBNGhiN0VCZUZaUGt0SEdS?=
 =?utf-8?B?c1NZYWJreUdBS3RrT1NzcmNvNVpmbkM5M1JhWEY3RlloTXUwcHg1ZTZKRFVO?=
 =?utf-8?B?dmlsYUI3aFdudVVEMlJqZXAvWi9PeTBOMU9aUkZ4WkhOald5T1ZZNW9KVzlr?=
 =?utf-8?B?ODlMNXZoQW5jS2JVaTg2U0htNXd2bUREOG9Oc2RpbTRyRDJ3MnFWS1ZQQjhs?=
 =?utf-8?B?Nkl1ajJmRitqazByNFNJWURIMlRJNyt2QkJGejNzeFB5bjdXWTkveDJ2TTZn?=
 =?utf-8?B?c0RmakJaSkZTZC9ERjBFQWcydU9KL3B3NmNqWllUd1Z4cWJuakhUa20wYThK?=
 =?utf-8?B?Nmc3WXdYWDNhZEJiRnpaeVBvWUxRajAyQTN5dnpjTEwwRkZVSDhYUkwzR3p3?=
 =?utf-8?B?c1d4QXdUdk9Jc3VZMDZXR2RTcStaWi8vdHh5K25CMElXN2ZTZENZZ2ROb2ox?=
 =?utf-8?Q?msUUCc3KyWQQvN2oiRqdvFg2/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A48F61A0E9B384C977EB1C35361B363@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658c963e-36c6-45de-d5ca-08dbfd4d1a68
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 09:06:20.0162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ArKcMTZY/yK9y8r5UbvvrE3rpZFSlcPfvRd4AzlPRW6x5Uq9IivgTm/oETLF4pip5/cvRuuHgmCMG3D2PNY9nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8467

T24gRnJpLCAyMDIzLTEyLTE1IGF0IDE1OjAwICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+
IFJlbmFtZSBnY2VfcGxhdCB2YXJpYWJsZSBwb3N0Zml4IGZyb20gJ3YxfnY3JyB0byBTb0MgbmFt
ZXMuDQoNClJldmlld2VkLWJ5OiBDSyBIdSA8Y2suaHVAbWVkaWF0ZWsuY29tPg0KDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9tYWlsYm94L210ay1jbWRxLW1haWxib3guYyB8IDI0ICsrKysrKysr
KysrKy0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEy
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gYi9kcml2ZXJzL21haWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+IGlu
ZGV4IGRlODYyZTkxMzdkNS4uMTZjNTA0ZjhkOWQ1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL21h
aWxib3gvbXRrLWNtZHEtbWFpbGJveC5jDQo+ICsrKyBiL2RyaXZlcnMvbWFpbGJveC9tdGstY21k
cS1tYWlsYm94LmMNCj4gQEAgLTcwNiw0MiArNzA2LDQyIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qg
ZGV2X3BtX29wcyBjbWRxX3BtX29wcyA9IHsNCj4gIAkJCSAgIGNtZHFfcnVudGltZV9yZXN1bWUs
IE5VTEwpDQo+ICB9Ow0KPiAgDQo+IC1zdGF0aWMgY29uc3Qgc3RydWN0IGdjZV9wbGF0IGdjZV9w
bGF0X3YyID0gew0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF9tdDgx
NzMgPSB7DQo+ICAJLnRocmVhZF9uciA9IDE2LA0KPiAgCS5zaGlmdCA9IDAsDQo+ICAJLmNvbnRy
b2xfYnlfc3cgPSBmYWxzZSwNCj4gIAkuZ2NlX251bSA9IDENCj4gIH07DQo+ICANCj4gLXN0YXRp
YyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjMgPSB7DQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X210ODE4MyA9IHsNCj4gIAkudGhyZWFkX25yID0gMjQs
DQo+ICAJLnNoaWZ0ID0gMCwNCj4gIAkuY29udHJvbF9ieV9zdyA9IGZhbHNlLA0KPiAgCS5nY2Vf
bnVtID0gMQ0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2Vf
cGxhdF92NCA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfbXQ2
Nzc5ID0gew0KPiAgCS50aHJlYWRfbnIgPSAyNCwNCj4gIAkuc2hpZnQgPSAzLA0KPiAgCS5jb250
cm9sX2J5X3N3ID0gZmFsc2UsDQo+ICAJLmdjZV9udW0gPSAxDQo+ICB9Ow0KPiAgDQo+IC1zdGF0
aWMgY29uc3Qgc3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X3Y1ID0gew0KPiArc3RhdGljIGNvbnN0
IHN0cnVjdCBnY2VfcGxhdCBnY2VfcGxhdF9tdDgxOTIgPSB7DQo+ICAJLnRocmVhZF9uciA9IDI0
LA0KPiAgCS5zaGlmdCA9IDMsDQo+ICAJLmNvbnRyb2xfYnlfc3cgPSB0cnVlLA0KPiAgCS5nY2Vf
bnVtID0gMQ0KPiAgfTsNCj4gIA0KPiAtc3RhdGljIGNvbnN0IHN0cnVjdCBnY2VfcGxhdCBnY2Vf
cGxhdF92NiA9IHsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfbXQ4
MTk1ID0gew0KPiAgCS50aHJlYWRfbnIgPSAyNCwNCj4gIAkuc2hpZnQgPSAzLA0KPiAgCS5jb250
cm9sX2J5X3N3ID0gdHJ1ZSwNCj4gIAkuZ2NlX251bSA9IDINCj4gIH07DQo+ICANCj4gLXN0YXRp
YyBjb25zdCBzdHJ1Y3QgZ2NlX3BsYXQgZ2NlX3BsYXRfdjcgPSB7DQo+ICtzdGF0aWMgY29uc3Qg
c3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X210ODE4NiA9IHsNCj4gIAkudGhyZWFkX25yID0gMjQs
DQo+ICAJLnNoaWZ0ID0gMywNCj4gIAkuY29udHJvbF9ieV9zdyA9IHRydWUsDQo+IEBAIC03NTAs
MTIgKzc1MCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGdjZV9wbGF0IGdjZV9wbGF0X3Y3ID0g
ew0KPiAgfTsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgY21kcV9v
Zl9pZHNbXSA9IHsNCj4gLQl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdjZSIsIC5k
YXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfdjJ9LA0KPiAtCXsuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxODMtZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92M30sDQo+IC0J
ey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4Ni1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+ICop
JmdjZV9wbGF0X3Y3fSwNCj4gLQl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Nzc5LWdjZSIs
IC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfdjR9LA0KPiAtCXsuY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxOTItZ2NlIiwgLmRhdGEgPSAodm9pZA0KPiAqKSZnY2VfcGxhdF92NX0sDQo+
IC0Jey5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1nY2UiLCAuZGF0YSA9ICh2b2lkDQo+
ICopJmdjZV9wbGF0X3Y2fSwNCj4gKwl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWdj
ZSIsIC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfbXQ4MTczfSwNCj4gKwl7LmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ4MTgzLWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRf
bXQ4MTgzfSwNCj4gKwl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg2LWdjZSIsIC5kYXRh
ID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfbXQ4MTg2fSwNCj4gKwl7LmNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ2Nzc5LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfbXQ2Nzc5fSwN
Cj4gKwl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWdjZSIsIC5kYXRhID0gKHZvaWQN
Cj4gKikmZ2NlX3BsYXRfbXQ4MTkyfSwNCj4gKwl7LmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTk1LWdjZSIsIC5kYXRhID0gKHZvaWQNCj4gKikmZ2NlX3BsYXRfbXQ4MTk1fSwNCj4gIAl7fQ0K
PiAgfTsNCj4gIA0K

