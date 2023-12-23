Return-Path: <linux-kernel+bounces-10548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA0D81D609
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 19:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B405E1C21068
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 18:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB771400D;
	Sat, 23 Dec 2023 18:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="u4OPMUnM";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HhPeOe5F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BAEFC03;
	Sat, 23 Dec 2023 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 7b4af6daa1c211eeba30773df0976c77-20231224
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GXmlOi1R8ePxiGWYXIqSZEjlGMiO58+5i6c/15321tk=;
	b=u4OPMUnM8DZfc9qOquTa4FyXvbj8B+Nke2qlrM8CvZWJLcjAPRFZuvFU3XdMj/tpEV5E0QSMbs+XdYFYgcYGAj3p5iAQZ1Ak5AGmmkf3uUm1YXv0i5QsE4u6obBsnPQOTn7ULYnts560tyvSiB/vLk2PlV/o2sB+yB5PefZx+s8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c417caf4-1c89-4153-9734-3cda4ec40d0a,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:4bc7692e-1ab8-4133-9780-81938111c800,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7b4af6daa1c211eeba30773df0976c77-20231224
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1028189155; Sun, 24 Dec 2023 02:38:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sun, 24 Dec 2023 02:38:34 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sun, 24 Dec 2023 02:38:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7OoZlG/4zsAVZb4XoOQBQX1+UKRDSaSOqdDjveDiCqcyL23aTC0M2dT+u5x4SH/9u216t3MzXrafEfaid/46aNBzvZRthGcB9melYgbhoB2WaWNYqbOk5pFuKyqlK+x+AfZeTGmqYmc6qv5oyeG0lDEuk7JkBWsyBIkRqa24da3PKwjMBtez+8tc3zp498NCgSiLdLsbeumZvDDu63OSMOHkNvtrkDHD7p8CY4bIfk14CKTn9h4ffLWn+r6bnLJyfT1N6gXUf7upc/dbTWFTGg+j8cD6KqaG466lJghJwRDOc1CcCyNgRSt/iiDnX781HVOQt4pr4BCEuZj66ZMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GXmlOi1R8ePxiGWYXIqSZEjlGMiO58+5i6c/15321tk=;
 b=jcK66kTi/ZtToMmP+8dUZnl4UUuV1n3ly4PjEKcdI7eCYodaf1rDFdyL2mYplDbEbgv5LoYaB3KvxFSG8Wv2OfuKFPDohve2ijfdZ3QkVtq7pZTNOaH9pJMvpm7769e4HJ5P3HAAt99i6TxKJEmUhB3YVXr29fJXM3XqDIdSqOuUzPtY3ne/v1J4wDuFMM8gQ8Vq6nVd7v9fAOkBYrWLMkhDkRS+SxsnN6a3IbUIIxzdFfjlaLEq71EksDFc75VTyKA2vqaC6IAC4qFS8FTeYTjNL7QHDFyiJKroPqMW5V3HaUcN0+aRFr0W6ViHGKL3D26cg8ISgC+1K5AzEolchQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GXmlOi1R8ePxiGWYXIqSZEjlGMiO58+5i6c/15321tk=;
 b=HhPeOe5FcLlZF/K+++5NdvVV4RGXjI4/1wJxYeCI5HFFKLguzJPDbpOGBt8OQr2ziBvM3TrncPPcdTd3Re077/oFnrS2GQJ5kGmXhSDVOYRrGL6gI6zpNdL6TTDr7Kb+L2ydln+49dK5EGMTWNAloTkl9dsM/I/lBts5cxjjaq0=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by SEZPR03MB7946.apcprd03.prod.outlook.com (2603:1096:101:186::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.22; Sat, 23 Dec
 2023 18:38:31 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.022; Sat, 23 Dec 2023
 18:38:31 +0000
From: =?utf-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= <Jason-JH.Lin@mediatek.com>
To: "conor@kernel.org" <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	=?utf-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	=?utf-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= <Johnson.Wang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?=
	<Shawn.Sung@mediatek.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	=?utf-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "jassisinghbrar@gmail.com"
	<jassisinghbrar@gmail.com>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 2/9] dt-bindings: mailbox: Add mboxes property for CMDQ
 secure driver
Thread-Topic: [PATCH v3 2/9] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Thread-Index: AQHaNJLL0ASpTiGjHE2rl0XbD7rPBbC1Z/EAgAHNXAA=
Date: Sat, 23 Dec 2023 18:38:31 +0000
Message-ID: <63d64568f6c1ee68b81f9d8efb7c3c090e42e5ec.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-3-jason-jh.lin@mediatek.com>
	 <20231222-unpicked-jaundice-837baa3092ed@spud>
In-Reply-To: <20231222-unpicked-jaundice-837baa3092ed@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|SEZPR03MB7946:EE_
x-ms-office365-filtering-correlation-id: 093fd51b-14f6-4d07-6073-08dc03e65cb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OvRvGVtVMJQUgdgaz7g6RbDX4ghyVBG6yoInV95bv6WBgfbOHdgTpSWkqiQ2HHjfd+B3yRuEEO7Kgc13IcBeGiIP0f6Zf4NpZ1sDImrQ+YCG/9CFhDUUmFbYnxUQ1uDw1gMudtbThxi9b43GlT5CweVenKPbfU5pghiEQ5uKW9o97k2w85s7Wn3/Oh1Q3tokBGaNpbxq0sNeSgwMnIuEDMcCl2IEqA7oiM/76+PnEufEEYg7uPzcMFy4HRWbA0cZrzYop/KRAYJ+/9uPJuykAmkaMrCO8vnimgrw8R8QR/bBFpT2t/75dd0FP1awR25w0vDFqOoSd2NC64PjOuhnpR1ehaSgn8TiRCfb6UXD7no9isk76/tCMPlUI1TdLCUIHCQZ0jGXUDtDAdZp+Mo9gZRp+y/ieYDstdy1cIZIck160CwymIJUDsYgCvtQ/ozJdneAcbuOVcs4h3PPcJt7N5zeiOIEOK1ERNk6ccUKNJ9I3ZbSwZL102F6zsal4GOW2sMqs3uhxyUau260eYxfpUK1l4QWmDRrWPmy2GVV4kXgQ/jJiV/K68jNVUqJGGSS0UdrAE5KxnyGgxmjDQQCIn5oUrDWcOL+6nKpGLI95GzMqbea15VvKlwaiXkRjn75VG3goNmU8qoD4vNpez50awmPc7om6qkqSNw2Au+HrLU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(122000001)(38100700002)(38070700009)(36756003)(85182001)(86362001)(26005)(2616005)(83380400001)(6506007)(41300700001)(6512007)(76116006)(66946007)(66476007)(66556008)(64756008)(66446008)(6916009)(91956017)(478600001)(71200400001)(6486002)(54906003)(316002)(2906002)(4744005)(5660300002)(15650500001)(7416002)(4001150100001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2FuL1JzTkcrb3BxZ3ViN1JHZFZUamNZbXpleUl3Z1Jkb1J6OEJ6SHU3Ykw5?=
 =?utf-8?B?Y05YZVlGSU41dWg2NEJGRzFKZDYwOTJFUUJWN3F5OWh5OEdYd3dVem5sSi9J?=
 =?utf-8?B?THFSU1drS1FjMm80bk1WU3ZMbEw0NlQ0bnpSWm8rWW9FbFU3b2p3bGVRMXBs?=
 =?utf-8?B?c3hHaVlwT2hjeHFnTW1sWmlmQWNEN2h1aW13akdEelgvZXc1NHFyQWpyUzFX?=
 =?utf-8?B?Q294K3dhalFLd1gvZVlzTGtoQmZVQmFGYmxtRTRJdFRCcERFdG5ZUXF0cUwz?=
 =?utf-8?B?OGNoVHpXRW1wR3FSc2pENEdiaCs3T1lNMmVPcmx4VFRBSHhzaEVGblZ2WCt1?=
 =?utf-8?B?MnI1ZDhBRUcybGJBck1SUjBXR0krblZNUVBZakpMYW1JWmVmRzMyaVo5OWxW?=
 =?utf-8?B?ZCtmVDE1ZkJ5MEhUeFcvT3FpbUpNd2wwbWJKYWhUN3Q4VlhXd1JweU9OQXNl?=
 =?utf-8?B?WmZPUzhOU3pHZldia2VNTWREcXhTZzlLYUFMaEhFV2x2Rk9DNDE1dUhSSHRW?=
 =?utf-8?B?VFd0enNVbTR0Ni9qMW4veURnQU9JNUc4SGsyc2R6ZGpuaVhKMDAza2c4N0tG?=
 =?utf-8?B?UDV2SzZSZ3pGMDMwTW81VkpvTVIrOC9kcGRYU3hhMTFSYVZROWhqWUtha2hn?=
 =?utf-8?B?RVBuSDVPQjJSckJMaklHYVJ6MlQ2anF2VFdyclBJa3Q5QUZqMHpBTCtZKzJB?=
 =?utf-8?B?NGF0bDlHOFcwMkFpK2p5ZzBGbzBNOUhXc01wVFg0eXMxU0FIdmZsVDIxUnVN?=
 =?utf-8?B?dnJ3V3E2Z1N5dWZYQzZpNlA2bS93NWtFcFFQNm9xSm9jNlRGcDkrU0NuM2hL?=
 =?utf-8?B?ZG9IRlZ5U1d6MkpRUXczYjd4NStTY204NnIwbUtPdG0xT1ZMb2RKTDI1MlNp?=
 =?utf-8?B?dDk3K2J1eldEOVhET1UySGw2UjZSc05VTkNISjJmNGtSV3pXM09wNVBVMi9j?=
 =?utf-8?B?UnZTY3luTmZIZTIyR1NXSjhJbUhvcFRQcDFEdkhRSjdYM2FORHdlQ3I4Vk5H?=
 =?utf-8?B?NmVKVjFXU2x3bTk0ZkxpYmVGMWFCZTZkUXpDL3BLL0NyeUVnSzVKbEdWS05W?=
 =?utf-8?B?YnQ5MGVmZGlZNDdvbUlsSHN0aW9ESkFmMktFdUFoWmRNVzhXSUdWWjlpNHlj?=
 =?utf-8?B?N1hnMFBSU0xsUzJjQ1BWWEgyWjM5VDJUZnB0bTZFVGxTYVQ4aDBneG5OVnp5?=
 =?utf-8?B?ZW9aOWxVdm5HTlRQUC9XSUd4aTRWM2JianJTTFFRM2NUOGxXTUUwQnQvaHNR?=
 =?utf-8?B?WXBFM003UStXYjg3MlpuUmx4TGh1M2tNcSt2V04wdTdYMGx5Z1Yyb0U4a0V6?=
 =?utf-8?B?OTJ2NG85c0x3UURiZUpWaWMwL2JJZFhLVzdGSm5zTEpIMXlPOE1zYk5ZVG9C?=
 =?utf-8?B?am91bWlLUUcwOHlvc2lLQVgzbGNaZmxlcEdQNlhJT1QvZnhIcW81WnpyVThJ?=
 =?utf-8?B?cjUxTG9UNkxmbFY1bitmbFpWanZmcWhBR00vS0kyNk1oYytvM1haMVRuWS9a?=
 =?utf-8?B?Uk5yOVlTVkxERG5nZ0wxcDh2K3NXd1h5NVc0dGZBbHp2QTA1a0FzKzhXWnp6?=
 =?utf-8?B?VDNnMTdndTM1OUlpaHJLbFFjS3NrQ3FXbTRsVzV2YmFHSlRNWi9ZTVhSc3VG?=
 =?utf-8?B?Y3VLOW1JNDZXNGp6aTN4TkdNcXNnNGw0cDJrckpiSERTcEJvTnA2VFFkVHVY?=
 =?utf-8?B?eVRaTlcrZ3JTbGhYMzh0SVRKTE9MUWc4M09FajJ3S1BKRnBjMWl1aWZacHIx?=
 =?utf-8?B?eGtGeGJXaHF4Y2xtVzYzTzJYN1FjMjhEamJQUzdPWUJIelVBRDdhalJCUDZF?=
 =?utf-8?B?RkQ5SWJLU0hZUW8vVG9jVWJjZzE5cFVmM2xXcVNOOWovY1ZDR3N1aUdPcktU?=
 =?utf-8?B?SVQ2bjJ1QnN4eS9kdG05UDk4aHQvM0I3K2RwdXhtNWYva25SbW9hSDNscy9p?=
 =?utf-8?B?VVI2eklBYVAwRExJMCs0NFJIVXQyWlM2MUdQdGNYT1BQZGwvUksxSDZpeHIz?=
 =?utf-8?B?N2owRG9wMWxWNmVXZVgzVWVlMG44WThOWnhOenA1ZlI3VWFpMGtOWm85RFov?=
 =?utf-8?B?Ky9tS3ZFbXFpOUR4UytrK0pFK3g5NGZiZUhGVVJCallYcmVoRnlQd2lzcUlK?=
 =?utf-8?B?SUYyc1c4RmZTVmdBeS9yL1NHanpIVmsrb0R0OVBHd1V1TEdTNzM4ekRnNVQ2?=
 =?utf-8?B?dFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C22F6CCB8C39EA4C92B0C2521F7E58B9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 093fd51b-14f6-4d07-6073-08dc03e65cb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2023 18:38:31.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cx0cbE/W/ysHDsinMt8xE2Bz0fKYjgK+9lXb/79U8WlxI6Gr4+HoRX0+NuEN5HTf4kseQBG0g+rY6uo55LzaJyy3x4fN0T/x3CiBblyspnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7946

SGkgQ29ub3IsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIEZyaSwgMjAyMy0xMi0y
MiBhdCAxNTowNyArMDAwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBGcmksIERlYyAyMiwg
MjAyMyBhdCAxMjo1MjoyMVBNICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gQWRkIG1i
b3hlcyB0byBkZWZpbmUgYSBHQ0UgbG9vcHBpbmcgdGhyZWFkIGFzIGEgc2VjdXJlIGlycSBoYW5k
bGVyLg0KPiA+IFRoaXMgcHJvcGVydHkgaXMgb25seSByZXF1aXJlZCBpZiBDTURRIHNlY3VyZSBk
cml2ZXIgaXMgc3VwcG9ydGVkLg0KPiANCj4gV2hhdCBkbyBkcml2ZXJzIGhhdmUgdG8gZG8gd2l0
aCB0aGlzPyBFaXRoZXIgdGhlIG1haWxib3ggY2hhbm5lbA0KPiBleGlzdHMNCj4gb3IgaXQgZG9l
cyBub3QuIFRoYXQgc2FpZCwgSSBhbSBub3Qgc3VyZSB3aHkgdGhpcyBzaG91bGQgYmUgaW4gRFQg
aW4NCj4gdGhlDQo+IGZpcnN0IHBsYWNlLCBjYW4ndCB0aGUgZHJpdmVyIGZvciB0aGUgbWFpbGJv
eCBjb250cm9sbGVyIHJlc2VydmUgYQ0KPiBjaGFubmVsIGZvciBpdHMgb3duIHVzZT8NCj4gDQo+
IFRoYW5rcywNCj4gQ29ub3IuDQoNClNpbmNlIHdlIGltcGxlbWVudGVkIG91ciBtdGstY21kcS1t
YWlsYm94IGRyaXZlciB3aXRoIG1haWxib3gNCmZyYW1ld29ya3MsIG9uZSBtYm94IGNoYW5uZWwg
Ym91bmRzIHRvIGEgR0NFIEhXIHRocmVhZC4NClNvIGlmIHdlIHdhbnQgdG8gcmVxdWVzdCBhIG1i
b3ggY2hhbm5lbCBmb3IgdXNpbmcgYSBHQ0UgSFcgdGhyZWFkIGZvcg0Kc2VjdXJlIGlycSBoYW5k
bGVyIGluIG10ay1jbWRxLW1haWxib3ggZHJpdmVyIGl0c2VsZiwgSSB0aGluayB3ZSBuZWVkDQp0
byBhZGQgdGhpcyBwcm9wZXJ0eSB0byBEVC4NCg0KUmVnYXJkcywNCkphc29uLUpILkxpbg0KDQpb
c25pcF0NCg==

