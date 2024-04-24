Return-Path: <linux-kernel+bounces-156067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034DD8AFD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53A7B22795
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 00:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427E4C9A;
	Wed, 24 Apr 2024 00:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kI22RwnQ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="evpqaj+V"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C914C61;
	Wed, 24 Apr 2024 00:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713920301; cv=fail; b=GPlI/Lm9jlCdhHBRqglLspWQMQt8UE/QQDQ1RAIHudz/1MYQ9raTgyJVOODo9vvAiw1g04siBfdYtfgEOSSMbtUFe6qSzGoc2Z/jp5/uZWOTNbSOQMiIaCh9HHIOWB+7zKpzPzdriBC9gRQQDwhgbm8bbHTpbkeqFLfjn1DmgZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713920301; c=relaxed/simple;
	bh=OQy3jXSiI2f8wePFSoBX/RLsXa0F5mqiML1dBipTTqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TlrEFqlTTQjB6LIT8DcPe9JmG3OUQIZmaeQPALgSHybt2Y4SPiMuFBOholvIY4ET+QjWnQGQ6asnITNe+7GrugB74rJMrvmoTo5gVm66Y2Wue1h7UHdiyRdS/DfiQeDRntaImF9kDmE5Ut1xpfB/rODMJzWVG32oAAS92BXfNi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kI22RwnQ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=evpqaj+V; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b86af67801d511ef935d6952f98a51a9-20240424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=OQy3jXSiI2f8wePFSoBX/RLsXa0F5mqiML1dBipTTqY=;
	b=kI22RwnQU8PSxj/s99v0LjsM0xfXt4uH9ULFGob0M5Zwi1kVzzpp8o+W26Gaffy5K2IM9cCP8HNCqB3x5f4TIB8WuqmUHHiYFw8iJxMNFutzpLCtF9lSZ7vD3SDObfgMNZ55gCbXYP1tqOdn9AV2lZllCgXD/1rrKvGfeo4wTts=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:1d1aaec4-ab11-48fa-b391-1fad9c0f8578,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:043e0883-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b86af67801d511ef935d6952f98a51a9-20240424
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <olivia.wen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 25932863; Wed, 24 Apr 2024 08:58:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 24 Apr 2024 08:58:09 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 24 Apr 2024 08:58:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3nm/s71M9jrxTHwHEouhh4nDuusgEqDyBSjx/QkmzJSE+q0s4vOSkUcw00VnwysxwIuMh0D6UGZ5DTzVxwuc5AhnDP2bvjC5OC707ewbRCwtUuE39+ITx+uatTWj9FyTjY/dooZ4/VtdiO4UN3LKrWgInc3rVuBH6oc/JtE3SUCOdcchX8ERZyGFg6EXsL6tNW7SA+6g+/l4e93F+fhAkaQEu+L0NJXLm/e4oGIfmLRyrzJj5nRCFcsMDxtyewfe1Xx/xZkuf4p4dwFvAVQ5CdCizMaaMQ4RdGXS8fmAcViAsP/IgHIP8z/5853GyiNbjEor4um++JN2rY21cXMfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQy3jXSiI2f8wePFSoBX/RLsXa0F5mqiML1dBipTTqY=;
 b=bq0RaSxjoQobfF7qXkJIGxnxPL4Ah0QRyc95vzdyZMHrZ/WU7dTCPhFomxSTEUQ6gBymr9bv3Jc8avHkjNKzCmJjZ8YMJyUqAFVtgUKel1YFn8IHKpl0BSHVJ4t9yD/CFOemh+B4uU5SZb7+6r8fYsfCIKKurmRcR2tiEMwuLZ+wogjanWjICh5CBwPhi0cPaR1cSQF+V8q8kfcbW2PE8cY5ALREBSknhdZzFPPPNv6FyBtP/ML2UMFHCbjHqN2mkXLmNtOr9igftyYR/kmWQyITbfWMCa2/RcoeuaOZiP8gAo92R7eSaSxZ0VthVMtUt/1lAb1ynswhMyMxiaCPJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQy3jXSiI2f8wePFSoBX/RLsXa0F5mqiML1dBipTTqY=;
 b=evpqaj+Vj365NqWgbb2JkGUFqA7cTyVESiMzRCacnuxAgspgpql0W1bWdwFAw5c69a6HgNfbn/PG/drMIME6HXbL7cQs2G4t+I2hoBgAhGlFlhHnPzRLYKsHD7oHnz3VclhJkJaE4SpdrMLZaWEjGrJ65pcAzwUSZ7XIxqpQ4gY=
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com (2603:1096:820:8c::14)
 by JH0PR03MB7836.apcprd03.prod.outlook.com (2603:1096:990:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 00:58:07 +0000
Received: from KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa]) by KL1PR03MB6226.apcprd03.prod.outlook.com
 ([fe80::85d1:1a4f:cc89:46fa%7]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 00:58:06 +0000
From: =?utf-8?B?T2xpdmlhIFdlbiAo5rip5YCp6IuTKQ==?= <Olivia.Wen@mediatek.com>
To: "robh@kernel.org" <robh@kernel.org>, "mathieu.poirier@linaro.org"
	<mathieu.poirier@linaro.org>, "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>, "andersson@kernel.org"
	<andersson@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	=?utf-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?=
	<Jason-ch.Chen@mediatek.com>, =?utf-8?B?WWF5YSBDaGFuZyAo5by16ZuF5riFKQ==?=
	<Yaya.Chang@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	=?utf-8?B?VGVkZHkgQ2hlbiAo6Zmz5Lm+5YWDKQ==?= <Teddy.Chen@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	=?utf-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= <TingHan.Shen@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
Thread-Topic: [PATCH 1/2] dt-bindings: remoteproc: mediatek: Support MT8188
 dual-core SCP
Thread-Index: AQHai+NzkV2m7c/nxE+B5uMVEPmmbLFkY5mA
Date: Wed, 24 Apr 2024 00:58:06 +0000
Message-ID: <66b3c11d7de51f4f2a3eeaf23bf6004c4cd01005.camel@mediatek.com>
References: <20240411033750.6476-1-olivia.wen@mediatek.com>
	 <20240411033750.6476-2-olivia.wen@mediatek.com>
	 <5cf005b9-d737-4509-a9fb-f0e59465482c@collabora.com>
	 <6e8e553b-8c5f-404a-a396-17d8b3440d93@collabora.com>
In-Reply-To: <6e8e553b-8c5f-404a-a396-17d8b3440d93@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR03MB6226:EE_|JH0PR03MB7836:EE_
x-ms-office365-filtering-correlation-id: edb7bd3b-ecda-4591-056e-08dc63f99a65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?VkVZWjVyZitMRU8yWXIrdnN6SGFxcUxRelRKVDdlU20waXRTOVR5eVNnVW12?=
 =?utf-8?B?NTRZd1Vpbk5aYTlZWkcyR200aW0zN3lYSUF3OWVUMDdiak9BcGFpQldHRmM5?=
 =?utf-8?B?M1ZvcCtnaDJ4WEVIWThrSy9IREVqdk8ybzY3YnBxZWpoV0hzUmVETTQrYlVZ?=
 =?utf-8?B?Uld6eHdFeTBQTkpsa3B0NWE2T2c3SnZLMnozbGc0dFVKU2pGcWpPTVg1Y2xR?=
 =?utf-8?B?Qlk5VC8wVVk2OGVyczYwTDFnMEJuZFVSM0tlRll5b2xIVzdwbFBxbkJEN2Uy?=
 =?utf-8?B?Z1kxREQzOHRkNGdFL0Q0d1lYbUJIUzJUVEUwRkY3VUZQVU9ZeDJHSWVpYTV0?=
 =?utf-8?B?MFZGYjdzRXg0aExQMUw5eEJHT2RIZG1ORE9pVlZRSjh1MnpaNHV1am9scVpZ?=
 =?utf-8?B?RytjbnBCblI3Z3c3Z0hYT28yUXFVUTdMY3RTenc5SFBZNHRVQkJ1UFV0RzB3?=
 =?utf-8?B?UE0wcS9SdkNrZFlnVllPY1lPTTlHZEUrRHJRaW5ON1pIS0p1eTZrWW83Qkxm?=
 =?utf-8?B?V2U1NGZsdVh0WmZ2QXF4U3BSVnl1RjMvMnJzeHhSejRUZjNIbDN5cWZIQXNo?=
 =?utf-8?B?bWI2bEFNSlJBSSt6a2d6S0hQMU9sbFA1Zmg0b3pYM2xhaCs1OERqbVE5QnVT?=
 =?utf-8?B?L0RyQk9vY0NiUmVIWS80dGU1Y1R1ZWNOZEFzYlRWMHRxV09JQ1kvVmo0SjBp?=
 =?utf-8?B?Rit3S0J2cW4zd2JzNGhmMmhYSVllZEhQa0lGazgvTFl6QWwvS1JnMFF2bmNZ?=
 =?utf-8?B?U0hJTmRTaEIraTk3c253dHNMVVlmR1Nvei91Y3MxQUdUWUI5NFFtTTdiSllJ?=
 =?utf-8?B?QTlGUk1FQlhoZUg3K3Fnb3dFUHdYNTE2dXhoTkFsZGZqTUQxSDNRbFM2d2xU?=
 =?utf-8?B?UGlsZjdKcWdTL1VrMkx2WENMU0hBQUlXTUVpMlVHL2lxSzNRK3l3Y0txVita?=
 =?utf-8?B?UkdCak51MG1Cb0N3bWRiLzVRL0lvRHdnbk93T1FVMFVpV0E0NlNYTVh4VEI2?=
 =?utf-8?B?bVY2ZmVISE0xc3dvREVqTklHMzFQSENIbkt2SW1TdWlpdmg5MWVnTFArdHlD?=
 =?utf-8?B?RDFTOXZLY1VwYSs3dnBwd3NpUU9CZ2g2c0VHMzNGTWZKQk1JTzhBNnp0V1p0?=
 =?utf-8?B?WWZTclBlcFF0Q3BxYXhwaE1wQVM0MCs0cTYvSUlVdnhDZUROOUdGS1ljanlF?=
 =?utf-8?B?UWNwREtENlVLT0pQeHh5YUxQS0lFbGRpczB6QXY2Vlc3eDRmN3oyWDMxNVI2?=
 =?utf-8?B?OE5yNkp3N2xGUWU1VXpHT2tyWDRVdzlnRy9sTnFGN2RvN3lKMTFOSzAvOWFG?=
 =?utf-8?B?NFJrT0hFY1QyK2NKemN5eUdFWmk5d1RaeW5Cd3JNaktwWm1pZ1AwazRUYjFu?=
 =?utf-8?B?cXlwTW44aWJwZTluWStzWStFdTNsMjVTVS9pK29jdkpUUk9KU1RlaHloZ3BN?=
 =?utf-8?B?Qm9FUTcyU2xYamxkbjk5b3Jqd1N2VmVGZ0ZCS3JUSTNvMGI2NXl6Nlc4NFNk?=
 =?utf-8?B?TmJQTVpibTdjL0U2VWs0c0hHRHU0QTUzY0xuZlM4R3pUL3k3MDFkN2FHbHFW?=
 =?utf-8?B?MlVnM1ZlUnB0dnRLVlByT0pNUkVtYXFZcVpFSnIrMkNtUkIrWlFoa0RpTEgr?=
 =?utf-8?B?RFBUMDV4L2Vlb2tDb1VMR0k1L0VZd2hjU2NISy9ucXArZWFvMEgvekk1U2VH?=
 =?utf-8?B?OWZYWGR2L0tObHhNbW9nbjhVRUYrVU44YklnRG5qNVFJY21rRGhGQUg4L3hJ?=
 =?utf-8?B?RFRwLzNhVW03RFVUaHNHN0M0SWhZMXEvRW9hUzdGdFl5elBNQVdhRnNKKy91?=
 =?utf-8?B?VkVVR2VRMG0wQ2xiTGovQT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB6226.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bE5qaVFhSy9TUk0rSHVBVEtKTnoxQks3N0prRC90RUhnWEtLc2lEZ09FWDU4?=
 =?utf-8?B?V3N4Wld1VVZ1elNtNUVDL01wTEVHT0lKUUpYSDZSOEFEWDZHYkd5am5BdVRs?=
 =?utf-8?B?RGgxdjIxclg1enhlUjFnejA4enA5MjE3bmlWS1hkekFYZE9zckV0MVAwaGR4?=
 =?utf-8?B?VWIyKzNreTBhVitXQkRMRGJrWjhGd0R0WGZsRGh1LzErU1FlbXhPUGhoVzVG?=
 =?utf-8?B?SWtzMWNpR1BaNUlNTm9pbnk3c08yVjB2c2syNDlBdlR5RjF0enloL2psdDll?=
 =?utf-8?B?L1lYR0xqWWNXL2h2Z0tBNVNISkF1Nnhrc0F5QjJVK01TbkNvVFdKWktLdHBn?=
 =?utf-8?B?Q0ZOZTdCUnRuVFVDMTJneTFJTGhlR3V5TGFJU2s4WE90NUpUWmJZaFYyUXhQ?=
 =?utf-8?B?NjliQ2lqazhoZHpwS0J0MHBTb3dSd0tFdE8yNHQ1L3IrMEwxVUV2UWM0YVpk?=
 =?utf-8?B?Q09MS29jRUxUb1pwWkFyR1VUN0xJY0w2MjlKc3QxU09tNUF5MEpYYVJYQUdO?=
 =?utf-8?B?cFB0NmVjOTUyQmRiaVpnTlR2M0pHdk04bkx1UFE1VFVZQ1V2aktQWTlUbVg5?=
 =?utf-8?B?Y2pveC9jNlBuRUpvOEZONlMrcmNDRjgrQS9qaWNQOFNuUXRmc3hGQStMRnNU?=
 =?utf-8?B?d1JkVFByNjNVSHJTZExOWTUxK0w1RXZEandzNHJjVVJhek9CUXY1UWt4eFBL?=
 =?utf-8?B?N2poM0ZBRW11eFBOWEEveHh5YWl1eVUzYURqZzhXd0FjbEtEZGdsQUFFWnNp?=
 =?utf-8?B?cG9RNDVhOWMxRmZvTW5Vb0pwNit5UFE5dEdaLzdMMDFlZXhiYVRkdk9YdjlW?=
 =?utf-8?B?dVhQV3B3TTMrN0hRUlBSUXdGR0NROTVXN25tOCtzZFIxU3pDbDBJWUpBWEZ6?=
 =?utf-8?B?ckhtTEJhc2pKQU9VemFRdlFJZXp3ZGxqaUt4NHV0dXNLRWVSaEZsVGhBNWF4?=
 =?utf-8?B?eXdoQzlVRzdrUDBBalAvcWdrQWF5M21OTlRMUmprN2NYZDBuYy83a2x1OWlE?=
 =?utf-8?B?d0lOaFZ4N05tY2QvdXNFbGxIaVBmVit2U1UwUGhCQmd1TEJ1V1paOWxZV0Iv?=
 =?utf-8?B?UjRneDJSQVYrSXE1bHhITU1hT3RPeHlWUG9XNG9vVDhnNWZlR0pYZlE3b2lT?=
 =?utf-8?B?VTZ2SEZVK085cVlsRXpWWVAxR1hpNkNrYm95a2tpUlVYbUtrMlVsN3NBd2py?=
 =?utf-8?B?bWM1RWp5WTZPcjN0bm42TCs0bktvSTk2TEpLMGdoMi82OE9nNXJiOEZiamFB?=
 =?utf-8?B?K1VlcU9nQ1kvZzJlakpUbVBXc1NsdzRxN2hFd1FWR0o1ZlpWeWFIT3p6UHFV?=
 =?utf-8?B?VGhnZldSQ0gzWFZhV1RJQktVSlp0cm8wclZiTXpJMFRSTmJrRUxqRkhMbU8r?=
 =?utf-8?B?MEw0cGN1VFgxNUswZnpiV2ZSL0JWcFR3dG5rWVpkYUtFOGZpNEc4cHA2ZjBI?=
 =?utf-8?B?QnRWNGNTcGEwRG42ekVmQUs4RTh2elpjeW9yd09YUHhpNUxNcnNzWVJPZG91?=
 =?utf-8?B?YTYrSWtRV2RvL1M4Rkh4cTBEeTJ1NzYyWkp4K2VnSXFDeFQ4NkZLTUgxMGh1?=
 =?utf-8?B?bEF4NDg4dXI0OW83SW1RTjFwMjRBQXhHcHE5RUY0NkVvNVdOZk1RdjdBT2dE?=
 =?utf-8?B?Y2EzTkwwMS9NdmFGNlBBcGdOWjdIOUU2QTlTd2ZxQ3NMc0tUM1ZldTRxa2dF?=
 =?utf-8?B?VHV3YXNKS3VaMkVVZHU4YVZIMUpNRVZacGJBSmZxWlJ6aXNmckNRejB3dElz?=
 =?utf-8?B?OXZFWkJ6aEwrTUN6Vk1tQ0hVcEpFOVRvdjVrSnVZSEdubURVdU10UlFPM3Vo?=
 =?utf-8?B?dmRYLzlYTStTYVdjbGpaODNHallwdUdiV3l5MkRHWEF4WE5GL3NsT0h6ak1r?=
 =?utf-8?B?NG5yV0xoZDZRU3JmQkFILy9JcHVGT3VtSjNzRTBDQnBWbnJvWlN1WEFNYVRJ?=
 =?utf-8?B?STlPd2FrU1dxcTRqbTRnWVEzOWdRUUsyOUxSQTN3eU1qQ1FPYzU4a0dpaDJr?=
 =?utf-8?B?RzMxWDhhbkU1QTg1YUVnb3ViUVQrVk4vWGZpc21Tb09EUFFxZFNLeFdxbmdy?=
 =?utf-8?B?bklSZ1RmeHdHditMcUtKVG85UEFlSzZsM1JiazQ0cjd5MG9Nc3BxdUtwcWNO?=
 =?utf-8?B?VWlHQ3Z0ZTZ3RVo5aG5lSE5wNGNxdzRjaGVXemJ3M255SEpieGxKZHlLNDRq?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <12A0D1ECBA0E58418B0FAFB82D9B7DDD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB6226.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edb7bd3b-ecda-4591-056e-08dc63f99a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 00:58:06.7984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1/ak8RX1MdeyMBVh7DqQpTYhwIaKY+GBIW4gBq4Yebf6TXPJjJfQJIJPDdmqw2uIabKiwbrNL1s/yeMlAddCcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB7836

SGkgQW5nZWxvR2lvYWNjaGlubywNCg0KT24gVGh1LCAyMDI0LTA0LTExIGF0IDA5OjM5ICswMjAw
LCBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyB3cm90ZToNCj4gSWwgMTEvMDQvMjQgMDk6MzQs
IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIGhhIHNjcml0dG86DQo+ID4gSWwgMTEvMDQvMjQg
MDU6MzcsIG9saXZpYS53ZW4gaGEgc2NyaXR0bzoNCj4gPiA+IFVuZGVyIGRpZmZlcmVudCBhcHBs
aWNhdGlvbnMsIHRoZSBNVDgxODggU0NQIGNhbiBiZSB1c2VkIGFzDQo+ID4gPiBzaW5nbGUtY29y
ZQ0KPiA+ID4gb3IgZHVhbC1jb3JlLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBvbGl2
aWEud2VuIDxvbGl2aWEud2VuQG1lZGlhdGVrLmNvbT4NCj4gPiA+IC0tLQ0KPiA+ID4gICBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9tdGssc2NwLnlhbWwgfCAz
DQo+ID4gPiArKy0NCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiBhL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9yZW1vdGVwcm9jL210ayxzY3AueWFtbCANCj4gPiA+IGIv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2MvbXRrLHNjcC55YW1s
DQo+ID4gPiBpbmRleCA1MDdmOThmLi43ZTdiNTY3IDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3JlbW90ZXByb2MvbXRrLHNjcC55YW1sDQo+ID4g
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmVtb3RlcHJvYy9tdGss
c2NwLnlhbWwNCj4gPiA+IEBAIC0yMiw3ICsyMiw3IEBAIHByb3BlcnRpZXM6DQo+ID4gPiAgICAg
ICAgIC0gbWVkaWF0ZWssbXQ4MTkyLXNjcA0KPiA+ID4gICAgICAgICAtIG1lZGlhdGVrLG10ODE5
NS1zY3ANCj4gPiA+ICAgICAgICAgLSBtZWRpYXRlayxtdDgxOTUtc2NwLWR1YWwNCj4gPiA+IC0N
Cj4gPiANCj4gPiBEb24ndCByZW1vdmUgdGhlIGJsYW5rIGxpbmUsIGl0J3MgdGhlcmUgZm9yIHJl
YWRhYmlsaXR5Lg0KPiA+IA0KPiA+ID4gKyAgICAgIC0gbWVkaWF0ZWssbXQ4MTg4LXNjcC1kdWFs
DQo+IA0KPiBBaCwgc29ycnksIG9uZSBtb3JlIGNvbW1lbnQuIFBsZWFzZSwga2VlcCB0aGUgZW50
cmllcyBvcmRlcmVkIGJ5DQo+IG5hbWUuDQo+IDgxODggZ29lcyBiZWZvcmUgODE5NS4NCj4gDQo+
ID4gDQo+ID4gQWZ0ZXIgYWRkcmVzc2luZyB0aGF0IGNvbW1lbnQsDQo+ID4gDQo+ID4gUmV2aWV3
ZWQtYnk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gPiBhbmdlbG9naW9hY2NoaW5v
LmRlbHJlZ25vQGNvbGxhYm9yYS5jb20+DQo+ID4gDQo+ID4gPiAgICAgcmVnOg0KPiA+ID4gICAg
ICAgZGVzY3JpcHRpb246DQo+ID4gPiAgICAgICAgIFNob3VsZCBjb250YWluIHRoZSBhZGRyZXNz
IHJhbmdlcyBmb3IgbWVtb3J5IHJlZ2lvbnMNCj4gPiA+IFNSQU0sIENGRywgYW5kLA0KPiA+ID4g
QEAgLTE5NSw2ICsxOTUsNyBAQCBhbGxPZjoNCj4gPiA+ICAgICAgICAgICBjb21wYXRpYmxlOg0K
PiA+ID4gICAgICAgICAgICAgZW51bToNCj4gPiA+ICAgICAgICAgICAgICAgLSBtZWRpYXRlayxt
dDgxOTUtc2NwLWR1YWwNCj4gPiA+ICsgICAgICAgICAgICAtIG1lZGlhdGVrLG10ODE4OC1zY3At
ZHVhbA0KPiANCj4gc2FtZSBoZXJlLg0KPiANCj4gPiA+ICAgICAgIHRoZW46DQo+ID4gPiAgICAg
ICAgIHByb3BlcnRpZXM6DQo+ID4gPiAgICAgICAgICAgcmVnOg0KPiA+IA0KPiA+IA0KPiANCg0K
VGhhbmtzIGZvciB0aGUgcmV2aWV3cy4NCkl0IHdpbGwgYmUgY29ycmVjdGVkIGluIHRoZSBuZXh0
IHZlcnNpb24uDQoNCkJlc3QgcmVnYXJkcywNCk9saXZpYQ0K

