Return-Path: <linux-kernel+bounces-15220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E22882289A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 07:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 769421C22FF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 06:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91907179AF;
	Wed,  3 Jan 2024 06:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IJCgVDYJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="GMyvcnGu"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23BB18021;
	Wed,  3 Jan 2024 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8adcd574aa0411ee9e680517dc993faa-20240103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=k14aTunGEer0GrYRxXoYNZFanZbmNONjE9kZ7ZFApJo=;
	b=IJCgVDYJGlnFhXHG7E85JXjpRGjhlBzT0JPaiTvSfdofxiT3CILvgkkSm79mkHGFZHi3J+hccXJ/nTeXbF8KiLIfyKrzGRTQE2LreMiNqA2dV3biShlz9xKFoZDTh8IhUrVCKidN7FHW3nUeBTABj+KfAOYX5ib0Z8HnyLtwPuc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:98d89b8f-77e8-41cc-880b-dd89af084f2d,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:ec5f6f82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 8adcd574aa0411ee9e680517dc993faa-20240103
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 408813092; Wed, 03 Jan 2024 14:51:38 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Jan 2024 14:51:37 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Jan 2024 14:51:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWXcLhis6yL44iTDQfiO4ewDLrGTQF2JcbQ5SZ7cK9aj6Y4P5gDBboQiuFSS+hiwVf4AEqNtGFCJYyQxETe2onk4y8YKnRncxxlz3hl8nCocnd70U+FK0a6JLS+EDUCQUQiP7dEHXZFNOFmHph0Ejlc95HOzAsd7rErAhkf4pRjrYjB/7au63opFGmxjA208CdJYrCc2nDqbkikEdP232SVTB4yNUOqg+4yp3qrJ9WjLrgT27+qmhhnMZFBuhgpQtcfWa/myZe7dNOIP1Z41yTBE4FRvyW7ftBrKmAHZvaDqabFMxHuOTamkZhKvT4vhZJ5gB2Up21RrPEQcbYVVew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k14aTunGEer0GrYRxXoYNZFanZbmNONjE9kZ7ZFApJo=;
 b=V7+F3dmV00L3mLGxHQpm0gZJV30pvaFbI9W24MCSVJvApCrfQcdh9K6sKO6x3Sq2Qooz/q96tWn++NdwKYKRDEK4cLDSmQIgMdT+o3w4h0olkefItLd2Lgf2EKN7c8LL4GsETuQE/vBvUZnSHKUjqoQd6sK2Ylww3jtddlGklWJdFS/Ed7gVSNei6u6G5YbP+X5N2ZP7irrVbN/M+b0/4qTf7dsyU4QwOo7kHnB05uMb/oCNnJhp++ztMyCTBKT198a5Wbp5iFFdLW6KXbRD4SO6rRHmZgum1rAb3ikSloyst2g6r8NbmhmHPL/I0DR7Ibzj0Fq46uRVcs3OjwVzOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k14aTunGEer0GrYRxXoYNZFanZbmNONjE9kZ7ZFApJo=;
 b=GMyvcnGuIp1AsIlqceaRBLzqfP+A6r4mdJbbPQe7NeCqYB33faW0j3Tx5ehN13Wlb+MMfsQIMNBXCUgbmNVNBix/7YScrzEp5wzLIUJnRB/baW0SI+d7afwOs0SORdsmYnmQV7wvywOdom9akNM0VdSF2y4Alnyd64v8LA+oM+0=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by PSAPR03MB5605.apcprd03.prod.outlook.com (2603:1096:301:66::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 06:51:34 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::d006:ec9c:ff42:ff60%4]) with mapi id 15.20.7159.013; Wed, 3 Jan 2024
 06:51:34 +0000
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
Thread-Index: AQHaNJLdXM09BYKw50qe8M+Tbg/FILC7JTwAgAGJGgCAAUw3gIAJvuCA
Date: Wed, 3 Jan 2024 06:51:34 +0000
Message-ID: <f8beba92c764b7621e6f3ea8e520fb7e74d2bf1a.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
	 <957c5ec4fe3a1ad6eb44df37bd68cfedfcb0b926.camel@mediatek.com>
	 <db1591bdf52f3cd02335155c45cb7841da9fcbc1.camel@mediatek.com>
	 <ae7dba29db2591ca3d09020e1cebbbbbc24b1f18.camel@mediatek.com>
In-Reply-To: <ae7dba29db2591ca3d09020e1cebbbbbc24b1f18.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|PSAPR03MB5605:EE_
x-ms-office365-filtering-correlation-id: 67616512-5d61-4ef5-c2a0-08dc0c286cd7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JgGyRk/cTyeYrJ813cYTRk2qzCU7/Xt8MNzznxa76fSgsiBmk/tkM6qVXlRCfzNMIkq8damuXPfpUsXHRYf43MwiI18unxPFWYmi8uqnsUxmj4WNuxEI9wRYMApMBAS7bXCeQZcF0eXru3okuMQhYgPGjWpMb0LqMh0o3jKqjMw8zEswmgFDr/NY99gaSIK5mEvczEhOUK55rjqY35oPs44+rjird6LAYQ6B7tm6pBy7GQNZQLH2/dYRXDfvR59kY5WSI336Vj5Iw0T2alclRdMZaZdfDheeH2iEQQQwmjqL82eBJPBvudCU/d1zwsSmwqTalJwNXeBuKjlEvKnq4cFLB71J+ajt7WFtCFEfvFgH6yA0QmBDoEermesxRUYBtITdpDNWd219istfz9Lk6LuU3sT1k6nAqMk51ok3kuf287cU5re9KqV1T3pJ28iNNs+SBuoP9Owhf3/LA6vabcJOZOdt+If/Ap2Mrl6Lbsj4FHScd0/gVs3rufAGmA/+hYtUqMQ02Jf/wtjImZ3U5Eng8rH5PhbCZl3NHWOMaDFKP7n4NGcwU4pYXUn/b30aVkr7ZPSF5NFxaPvh8iQun4TRq3XoqP5HH+m8odVYzLz6uJMeCmf9nXaJ1rjKobf4ItE2GvXZ/Hfy0ZXmXc44Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(83380400001)(4001150100001)(38100700002)(122000001)(110136005)(41300700001)(54906003)(8936002)(316002)(15650500001)(8676002)(5660300002)(7416002)(71200400001)(2906002)(4326008)(966005)(478600001)(66446008)(6486002)(66946007)(6506007)(64756008)(91956017)(76116006)(66556008)(6512007)(66476007)(38070700009)(86362001)(85182001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDJYRUtFMVZibmlmVWVPcEVSMGYxVU0zVTNjd0o0aUVHeUdyRy81cUNxSzl3?=
 =?utf-8?B?ZWp5V1RXb0x5V2RSb2tySEJqa2ZkSzV4L2tncERwcjBCYklWcjFTWmVOQzBO?=
 =?utf-8?B?QVFJZE1uNkdybmVUWkVCb1NkVjhtQWhveW5aUDl6Q3Y3SVhtbndkUWtZVHJi?=
 =?utf-8?B?U2VLZmtOZjM3VDZkSmMvYm1qSkxFR3hsZGFTY1doTUFReTJUMHB6NHNIeWFr?=
 =?utf-8?B?YW1QSWhzVjBzdGRTMzlIT1B2dXpSMVZaNlBSY3EyRHVqQ2hIWXl2UlJPejNv?=
 =?utf-8?B?N2ExOW1uZEQ5NjlSWFk3blc3bCtuSWE0VDJ0Ty94OWR6akNKSXBML2E4MWpj?=
 =?utf-8?B?TlE3SURGK1dMdkpDd1RsZTJtRmQ1Y21vRHNNcFhyWC9jQnpmZWdQcEdYUklQ?=
 =?utf-8?B?aTBxZ0F5VExzWGdPcitpNDZtd0NPZmFOcnQ3TCswbmNlZEF3ZjhKZUhXd0ky?=
 =?utf-8?B?VlhIbm4rZHBxVDJxWXZHbjFUM0pjamlRV3MxWnNmZkd6d1lsU2doS1poU3g1?=
 =?utf-8?B?RkVhRCtlcnlTOURsZDVZMHgyYkZ4cTU5QWZzNVkvQW85YWlGOGd5aXBtS1Jh?=
 =?utf-8?B?NTcrNFdaaGYwZDNGbE5NdHp0MnlCOXVTaFhEZG5LWFZmdVNQd2NpTzRucHdD?=
 =?utf-8?B?dUpFK1N2QXVud1pJbGcrYnJqNXN0aGlWckIzek9vMms2UTcxaFNyZFJMMmJW?=
 =?utf-8?B?S3NiNGdNRDVjYytJY0hwRUpBYnBiUk4wb3pYZ0xNbFdEUTRpL0dkTmh3T2M0?=
 =?utf-8?B?MzJ1YjVMUGlFbVFuUFIvbkFCbDlLdEFmZlR2S2ZIbFV5U3pQekViMmNCbGds?=
 =?utf-8?B?eXVkT1JyUmxWQnZqQnFKbHRuanlvdDQzZFNBRTFocGZYakwrdlFyUXZwQk1u?=
 =?utf-8?B?MTAvVXludWJ0MHZJQnlJbU5BSDlJZ1dhNktuNUg2ZWloM2RpcTk5SjJRZmlZ?=
 =?utf-8?B?ZWtpWXVqMTlJVkd4SG1RNDJjckxsUXpKYjJYNFEveGpmYmxDaXNWc2VoMCtW?=
 =?utf-8?B?OXkyNjFQejFQbk1Gd1FRRkhwSys1MDRpVVd1bUFmN0hSUFc0Y1ovd0laME9N?=
 =?utf-8?B?SGpTS1c3QVJmL0p1RjMvRVpGdjcyUWorRmc4QUVzRFlFWGdyS3JqZlFZZGFz?=
 =?utf-8?B?VlV2Vi9hajJLbGl0YTZFN0hkVE1NZkRadnlrQXFDNkZWNWlyc29FZ1RaZWFk?=
 =?utf-8?B?OW82WktKeWtaYXpEZkNHRzVydmp0ZllwMWFvZUhwUXJKMmR1Y3EwcWpYQ05l?=
 =?utf-8?B?bFI0Tkxhb29mUlgxb0laNFZnRlE3ZWlybUFlNjdLQnJvTmo5RnhZSXR3clVD?=
 =?utf-8?B?eUMvV1A3VEZvUm52VUdHWUI1K2lFVFhnak1ZWGNIVUVDYlFhNUI3b0pYN1J1?=
 =?utf-8?B?eEtOZE9jbDAzcjJDc3lOT2llbTNiNzBlcS8weVZTajJjKzJacXhBNnFKbXFT?=
 =?utf-8?B?cFNDSEdXZFdCMGhSaHJTV1g4cXEvZG5yN2ptenkzOUZuRm1QMGI3UEFHK1BY?=
 =?utf-8?B?UjZpM2d0c3hiM0k5L3l3bHN5dEhML1A4eUFvWHR6MjZkSzhDbUNjTEVXa3pv?=
 =?utf-8?B?bWRoaUxlM0N3dGpCU1dDMWh4cmozemJpOU1QRFNueU9sVXZyWmd2WmF4TEtX?=
 =?utf-8?B?L2xMN3lUa2w2WUhKTkxxNzhiOWxzV3Z0RVMxSnF1SXFLdWdubmpFUi93K1d4?=
 =?utf-8?B?NURUamU5SXMxZnJoTnJVb0MzeUxhYTlCOUNCUHUvT0N6RVFFZjdJNjdkaEI0?=
 =?utf-8?B?OENqK2d4YmxNZlFsZEgwc0k3WHFtZThtSFNndjlMejU5N1dLdmxPdGJZYVFq?=
 =?utf-8?B?TGcyVy9IdkNKUHg4QVBsU1U4Uk90S0lQOERWeXdFZ1NJazBDWTFHRldoV3Y0?=
 =?utf-8?B?VUJqZTVqVzVYNThOK1poZFJQdDUxNjEwY2ZaTzE3cEVBTjQ4S3dIcFlPZmdH?=
 =?utf-8?B?aGlFOER3a3N3b01MSE9nRzZ2SVdUSkV5SlJMaVFtaGxwN1JtL1ROOVY3TXJm?=
 =?utf-8?B?UTM1dUFLZnFPRkxQWGRBdE43YmxDOGcyR0I1aW8rT0oxeGdENXRMbFNCcGxp?=
 =?utf-8?B?d01ldmM4UTlqaHBTb1BnV3NhVFR5Z0puc09zVzJ4Z3dqM2ovYy92aEVXV3ZO?=
 =?utf-8?B?MWJVYTRaQkNOY1Qzb0c5Zmd5RldGVkoyZWwreTNaa0FRekJPL3lxQW9rY2xQ?=
 =?utf-8?B?ZEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE6FB918E9BBC341B59423ADC14413E2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67616512-5d61-4ef5-c2a0-08dc0c286cd7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2024 06:51:34.3482
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZAlQe1sBF5L45H+Oov9IGEvoHWocLB4DbTEbTQuCXAz6fc3OCcn1l0dLiLiD8zVuHQgrMMWUiuyBKoa95UdG8cHu3i7zell+ECNvyjYIzCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR03MB5605

T24gVGh1LCAyMDIzLTEyLTI4IGF0IDAyOjAyICswMDAwLCBDSyBIdSAo6IOh5L+K5YWJKSB3cm90
ZToNCj4gT24gV2VkLCAyMDIzLTEyLTI3IGF0IDA2OjEzICswMDAwLCBKYXNvbi1KSCBMaW4gKOae
l+edv+elpSkgd3JvdGU6DQo+ID4gSGkgQ0ssDQo+ID4gDQo+ID4gVGhhbmtzIGZvciB0aGUgcmV2
aWV3cy4NCj4gPiANCj4gPiBPbiBUdWUsIDIwMjMtMTItMjYgYXQgMDY6NDYgKzAwMDAsIENLIEh1
ICjog6Hkv4rlhYkpIHdyb3RlOg0KPiA+ID4gSGksIEphc29uOg0KPiA+ID4gDQo+ID4gPiBPbiBG
cmksIDIwMjMtMTItMjIgYXQgMTI6NTIgKzA4MDAsIEphc29uLUpILkxpbiB3cm90ZToNCj4gPiA+
ID4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0UgaGF2ZSB0byByZWFk
L3dyaXRlDQo+ID4gPiA+IHJlZ2lzdGdlcnMNCj4gPiA+ID4gaW4gdGhlIHNlY3VyZSB3b3JsZC4g
R0NFIHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzDQo+ID4gPiA+IHBlcm1pc3Npb24NCj4g
PiA+ID4gdG8NCj4gPiA+ID4gdGhlDQo+ID4gPiA+IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhl
IHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gPiA+ID4gDQo+ID4gPiA+IEFkZCBDTURRIHNlY3Vy
ZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIgaXMgYWJsZQ0KPiA+ID4g
PiB0bw0KPiA+ID4gPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29y
bGQuIFNvIHRoYXQgR0NFIGNhbg0KPiA+ID4gPiBleGVjdXRlDQo+ID4gPiA+IGFsbCBpbnN0cnVj
dGlvbnMgdG8gY29uZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+ID4gPiA+IA0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gDQo+ID4gPiBbc25pcF0NCj4gPiA+IA0KPiA+ID4gPiAr
DQo+ID4gPiA+ICtzdGF0aWMgaW50IGNtZHFfc2VjX3Nlc3Npb25faW5pdChzdHJ1Y3QgY21kcV9z
ZWNfY29udGV4dA0KPiA+ID4gPiAqY29udGV4dCkNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKwlpbnQg
ZXJyID0gMDsNCj4gPiA+ID4gKw0KPiA+ID4gPiArCWlmIChjb250ZXh0LT5zdGF0ZSA+PSBJV0Nf
U0VTX09QRU5FRCkgew0KPiA+ID4gPiArCQlwcl9kZWJ1Zygic2Vzc2lvbiBvcGVuZWQ6JXUiLCBj
b250ZXh0LT5zdGF0ZSk7DQo+ID4gPiA+ICsJCXJldHVybiAwOw0KPiA+ID4gPiArCX0NCj4gPiA+
ID4gKw0KPiA+ID4gPiArCXN3aXRjaCAoY29udGV4dC0+c3RhdGUpIHsNCj4gPiA+ID4gKwljYXNl
IElXQ19JTklUOg0KPiA+ID4gPiArCQllcnIgPSBjbWRxX3NlY19pbml0X2NvbnRleHQoJmNvbnRl
eHQtPnRlZV9jdHgpOw0KPiA+ID4gPiArCQlpZiAoZXJyKQ0KPiA+ID4gPiArCQkJcmV0dXJuIGVy
cjsNCj4gPiA+ID4gKwkJY29udGV4dC0+c3RhdGUgPSBJV0NfQ09OVEVYVF9JTklURUQ7DQo+ID4g
PiA+ICsJZmFsbHRocm91Z2g7DQo+ID4gPiA+ICsJY2FzZSBJV0NfQ09OVEVYVF9JTklURUQ6DQo+
ID4gPiA+ICsJCWlmIChjb250ZXh0LT5pd2NfbXNnKSB7DQo+ID4gPiA+ICsJCQlwcl9lcnIoIml3
Y01lc3NhZ2Ugbm90IE5VTEw6JXAiLA0KPiA+ID4gPiBjb250ZXh0LQ0KPiA+ID4gPiA+IGl3Y19t
c2cpOw0KPiA+ID4gPiANCj4gPiA+ID4gKwkJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiArCQl9
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJZXJyID0gY21kcV9zZWNfYWxsb2NhdGVfd3NtKCZjb250
ZXh0LT50ZWVfY3R4LA0KPiA+ID4gPiAmY29udGV4dC0+aXdjX21zZywNCj4gPiA+ID4gKwkJCQkJ
ICAgIHNpemVvZihzdHJ1Y3QNCj4gPiA+ID4gaXdjX2NtZHFfbWVzc2FnZV90KSk7DQo+ID4gPiA+
ICsJCWlmIChlcnIpDQo+ID4gPiA+ICsJCQlyZXR1cm4gZXJyOw0KPiA+ID4gPiArDQo+ID4gPiA+
ICsJCWNvbnRleHQtPnN0YXRlID0gSVdDX1dTTV9BTExPQ0FURUQ7DQo+ID4gPiA+ICsJZmFsbHRo
cm91Z2g7DQo+ID4gPiANCj4gPiA+IFNxdWFzaCBjbWRxX3NlY19zZXNzaW9uX2luaXQoKSBpbnRv
IGNtZHFfc2VjX21ib3hfb2ZfeGxhdGUoKSBhbmQNCj4gPiA+IGRyb3ANCj4gPiA+IHRoZSBjb250
ZXh0LT5zdGF0ZS4NCj4gPiA+IA0KPiA+ID4gUmVnYXJkcywNCj4gPiA+IENLDQo+ID4gPiANCj4g
PiANCj4gPiBjbWRxX3NlY19zZXNzaW9uX2luaXQoKSBpcyBjYWxsZWQgaW4gdGhlIGZpcnN0DQo+
ID4gY21kcV9zZWNfdGFza19zdWJtaXQoKS4NCj4gPiBJdCBtZWFucyB3ZSBkb24ndCBuZWVkIHRv
IGNvbm5lY3QgYSBzZXNzaW9uIHRvIFRFRSBvciBhbGxvY2F0ZQ0KPiA+IHNoYXJlDQo+ID4gbWVt
b3J5IGlmIG5vIG9uZSBzdWJtaXQgc2VjdXJlIHRhc2suDQo+ID4gDQo+ID4gT24gdGhlIG90aGVy
IGhhbmQsIG9wdGVlIG1heSBsb2FkIHNsb3dlciB0aGFuIGNtZHEgc2VjdXJlIGRyaXZlci4NCj4g
PiBJZg0KPiA+IHdlDQo+ID4gbW92ZSBpdCB0byB4bGF0ZSBzZWN1cmUgc2Vzc2lvbiBtYXkgaW5p
dCBmYWlsLg0KPiANCj4gRm9yIGRyaXZlciBwcm9iZSBkZXBlbmRlbmN5LCB5b3UgY291bGQgcmVm
ZXIgdG8gWzFdLiBJIHdvdWxkIGxpa2UNCj4gcmVzb3VyY2UgYWxsb2NhdGlvbiBhbmQgZnJlZSB0
byBiZSBzeW1tZXRyaWMuIFNvIG1heWJlIGFsbG9jYXRlL2ZyZWUNCj4gaW4NCj4gcHJvYmUvcmVt
b3ZlIG9yIHN0YXJ1cC9zaHV0ZG93bi4gSWYgdGhlIHNlY3VyZSBkcml2ZXIgaXMgcHJvYmVkLCBJ
DQo+IHRoaW5rIGl0IHdvdWxkIGZpbmFsbHkgYWxsb2NhdGUgc2VjdXJlIHJlc291cmNlLiBTbyBs
YXRlciBhbGxvY2F0aW9uDQo+IGhhcyBubyBtdWNoIGJlbmVmaXQgYW5kIG1ha2UgY29kZSBtb3Jl
IGNvbXBsaWNhdGVkLiANCj4gDQo+IFsxXSANCj4gDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1
Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXh0L2xpbnV4LW5leHQuZ2l0L2NvbW1pdC9kcml2ZXJz
L2dwdS9kcm0vbWVkaWF0ZWs/aD1uZXh0LTIwMjMxMjIyJmlkPWM4MDQ4ZGQwYjA3ZGY2ODcyNDgw
NTI1NGI5ZTk5NGQ5OWU5YTdhZjQNCj4gDQo+IFJlZ2FyZHMsDQo+IENLDQo+IA0KPiANCg0KSSd2
ZSB0cmllZCB0byBtb3ZlIHRoYXQgdG8gbWJveCBzdGFydHVwLCBidXQgSSBnb3QgYW4gZXJyb3Ig
d2hlbg0KdGVlX3NobV9yZWdpc3Rlcl9rZXJuZWxfYnVmKCkuDQoNCkknbGwgdHJ5IHRvIGZpeCBp
dCBmaXJzdCwgdGhlbiB0cnkgeW91ciBTT0ZUREVQIG1ldGhvZC4gVGhhbmtzIQ0KDQpSZWdhcmRz
LA0KSmFzb24tSkguTGluDQoNCj4gPiANCj4gPiBSZWdhcmRzLA0KPiA+IEphc29uLUpILkxpbg0K

