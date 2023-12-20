Return-Path: <linux-kernel+bounces-6297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84068196EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090771C254D3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F368BF6;
	Wed, 20 Dec 2023 02:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="tva1dMMg";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="PjT/CrKS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BFC63A3;
	Wed, 20 Dec 2023 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: ecdc28489ee111eea5db2bebc7c28f94-20231220
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=WnEJ4Up1Ti/4VSSTxhMnWNTOyyanAtNeLRSoA8RaWhk=;
	b=tva1dMMg0hFToSArgpsk3+wqH7o9/n8sdjWn4S3G/d4DMdWJd7pUmTPL9KdqAd/6eF2a+UrQTVpYhbpb+aLd7u5xAlZ8oLs9zBt2C2YnYqjQeIY+lgQa38IrLZtlSgIHY3gzpIOyj+ViGVFpeakPo5ZOVDRbF53plxPuSShabq4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:34e3b286-5f46-4be4-90cf-91e801a563e9,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:78449006-e3db-4819-888b-ba062b0c4c4b,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: ecdc28489ee111eea5db2bebc7c28f94-20231220
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jason-jh.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 107080768; Wed, 20 Dec 2023 10:46:07 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 20 Dec 2023 10:46:06 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 20 Dec 2023 10:46:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvUJhG48FKopmDOp/UCi4hbVQ0rtoPY7NyaBsIZsOcFtvC93WQ1n3/GIYzg/fw/Uhg2TiOTONR+QG8C9wGHmD29nW0F9ahINrmdRBaaM84yuNBNPl1coHMCeICFrB8OqJTerw303P072QIeaYYLTW3L8kNaH56g+iiF4my0MHu2umT4JRktxHXPjsLVHRc4mpk9w+QLpYedon0+YWz80sFg1DS/TSledZnWb0fC6O2WSbBs6JfXZHm7I0CKw42D0OCJigEuwuNrznMcyUGPyUv0r2rSAm5fwjNnIrFRn2jPGr4p7FXSgBwj6qGI4y14jfyD4elEDo2o3J0ujpj1iQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WnEJ4Up1Ti/4VSSTxhMnWNTOyyanAtNeLRSoA8RaWhk=;
 b=f1tjOekHGBbQM7Dk1DUfMV3bPDmOddNvdR6uJ4b3XBFQA6r/J+Kr1npJ2or8W7jFe4ZP/2CU0vEnpwdaoDgn4bHQWMqYtOXx8ZxWdo2pllHNorGoS4+6KpTgyFPteiqQ2znRA0pq7Zd9K4vmUHPGfhaY/JPi3UWafyUJhGyoIltIA2sM3zT3X2jcFi3wSOmAuSBT9qyDx+GM4jewPmX0uNxUmpOILNr3Bhc/ijZFi7IQvej9rU+97E6jj9Z6OQmDpeR6ivScPtytnyxKSG3JlGK9KOp+/Ga2ViIMgw/ud6WJ6Z4g8oMB38jC90C8QSI0R+zwI8jg268kdIiHCGG9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WnEJ4Up1Ti/4VSSTxhMnWNTOyyanAtNeLRSoA8RaWhk=;
 b=PjT/CrKSV1Y5/E1VK2GOwupd9Ex3PL6Y5pzJUMaDwgQqlbLFjl5clWBrkXFfAoZlAle2APQr3uMW+vEbmVjBzwei7fVf/poizF4OKEvM09Kpz5H/FEIxkn7j0GZpdQ0NSdgE5wlYahl5mXQf1S4Pk5qRG35aUVgX/J1vPVHMdM0=
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com (2603:1096:101:149::11)
 by TYZPR03MB5341.apcprd03.prod.outlook.com (2603:1096:405:7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 02:46:03 +0000
Received: from SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88]) by SEYPR03MB7682.apcprd03.prod.outlook.com
 ([fe80::ebb9:e872:cb84:4a88%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 02:46:03 +0000
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
	"jason-jh.lin@mediatek.corp-partner.google.com"
	<jason-jh.lin@mediatek.corp-partner.google.com>,
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
Subject: Re: [PATCH 0/3] Add mediatek,gce-events definition to
 mediatek,gce-mailbox bindings
Thread-Topic: [PATCH 0/3] Add mediatek,gce-events definition to
 mediatek,gce-mailbox bindings
Thread-Index: AQHaMY16oSm2Ip0zqkue7ETHplek47Cw1PSAgAClRwA=
Date: Wed, 20 Dec 2023 02:46:03 +0000
Message-ID: <6bb9deec93ec4d9b3dc7a8b587903565964eb0a4.camel@mediatek.com>
References: <20231218083604.7327-1-jason-jh.lin@mediatek.com>
	 <20231219-joyous-tarmac-aaf601623859@spud>
In-Reply-To: <20231219-joyous-tarmac-aaf601623859@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR03MB7682:EE_|TYZPR03MB5341:EE_
x-ms-office365-filtering-correlation-id: 11662437-dfb8-4326-2cf3-08dc0105cec9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiM6bk8oKG8Kmc72WFEU6LyefsKT24nAdGqTU0MurV8MQjl6TTLNnk8MAX8MAvaX7DuJ6DlMAEEI58bobu3ZvJDVC0UkmoM1embNSefjN9EbZ2BMVx49Q01FnQhWDKIiLGSSIjgwec5TGAPxWT7bod2m/gpQL1bCIJPZlKoy97N07INQ6bIgPrd1hL8Drsq5kn9LN7JF0gJZ739ys7H+61U84daXepG7qTHDRZgZ/9/jiq7X6/3VLzKLhPhVseJma9gkBiyjjHBpXS9xqhAXVzJZNwfQwhd68S74rYjavnd/VvvbKY4OR5BJ0e03NO7AMBgPUg+HRxRjuZkrRVzYsWev/wDlFzmScM1igwjYhveCLySfZXUuNfVTaY/vI+38G2wKdpis4PA62VgVeRHCpEz1RNTP9ACNIC4ogcloLRXximyWbHXWd6WNYJI6mACBVE/oeu1oEsewGXJC9TOrucxJJUXsdNsCv48R3y2fj4d9DQI74YO1P9uTJhII07s6DuJ1yMMlQ8OX8olR1s7VPybuh9fMovzctWrdMILfrXyLIJdZN/QHGajuVTlyGSAQ+M25DaGM/A9BjMN6D7oZ6rGzYJdkDCAaBXWWJ+Dc3d1eW06/JzN2E42B/lZMlcAIZWB8+Pp+cTF1jJTm3w7mnbTVgRaNCLBZubXtL1oNtyc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR03MB7682.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38070700009)(7416002)(91956017)(4326008)(26005)(83380400001)(15650500001)(5660300002)(6512007)(6506007)(8676002)(8936002)(54906003)(66476007)(66556008)(66946007)(76116006)(66446008)(64756008)(6916009)(6486002)(2616005)(478600001)(316002)(38100700002)(122000001)(85182001)(36756003)(71200400001)(4001150100001)(2906002)(86362001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGJjK3U4ekVhQXlIS1crUVNBOXFxeVZlZFExT0w2VkdRcU84ZkhJRWtBWTlU?=
 =?utf-8?B?clNUL1MyS29pN3FQUVlTSkt1VXpnNW1uemdTaE9odlpwbGFCWUJ6MURyUWJI?=
 =?utf-8?B?V05aVkxOR21WajYrS2dpYVhIZzVSOEI5bmRacVI2U2NIN25aQVVMem1uTkY5?=
 =?utf-8?B?ejZnRmpUS08yWjZndTRsNmo1RlpKNEtNd3hNZHpLNEVUZlNvZERHWCtpSlBh?=
 =?utf-8?B?NEpiYmFSTmhaWU9lNnY4cjdobUIxbXpGdmlVOXA3c1Bac0hYMm56dEFwZTJI?=
 =?utf-8?B?V0FoYmllNVlvVkpwT0t2aUQrcGhnSW9aQ09zeUhYbXRQVTRaYjdYVHZVcFlX?=
 =?utf-8?B?L3NjZm9DVmt5WkxDT3lhVnFEZmwxVzlJUFREcFJTZjEwYjJUQjFYMEQ3WEtZ?=
 =?utf-8?B?d2JBa3pZWFhNWEJXV0lZdndUb1FqRUZlRnNiNDhjQWt0Q1ZMZ1NjTVU3YURP?=
 =?utf-8?B?MDFkOWNqcWsxK0loSk9OVlhndnVMZHRCcC8wZVFoQ21la0MyeEYzRE9KTFVw?=
 =?utf-8?B?M3dJSDJ0N2xJQVRLOWJvMHlPaWxRaURnd2N5ZVNndGxheWNCdWxVbE52Vk9C?=
 =?utf-8?B?RlF3S0hxbW1VMFlNYWFWQmVhREpPZkVqWGFoeDllU0E4OERKVG05bDlPdFZq?=
 =?utf-8?B?N2tXQng3OTEwOEYydDJDemlZbUhlK1JTZXpkNXNXVU8zZUZGR090bGhYK2dU?=
 =?utf-8?B?ZUtsWGVsVGdIMWR4ZEtVcDRiTmtZTVd5WTNkQVFhMHJ5eERBcUNrclVwZGc5?=
 =?utf-8?B?OWQxOTJLdDI1NWFNSFdUZlhzZ1NmQVZ4N0p4OFh3aEtYVTI0ZTRLeTNrVXNx?=
 =?utf-8?B?QmxkN0JTbUkrSFg4djFtdjIzSTBxekxmWTdiSkcvODIzdGhLNVIrdjF4Ykxj?=
 =?utf-8?B?RUNDQWZNL251Vmc0NVkvcWt0OVlXR2wvVXdYT1NGR2lMSk5yYWV5TlJLa2Qw?=
 =?utf-8?B?d0FYQnF4dWxJRFIrNXZ2Uk4rdEV0MXAyQ202dmIwcmhkN0FYcEpESHpYVnNR?=
 =?utf-8?B?Qnp0YUg0VkpkRk9jNStxM0VnaXQ4SldZL2JyUHRUcmt1cSt2RnFHSlRGUHBy?=
 =?utf-8?B?RHlPdVFubzV6L0VibG5xRkNBZjQ4ckY2MjhIMEZ0SkYwQ2gxazNBOUhrYkFZ?=
 =?utf-8?B?b1dkb2c2NC9sQWoyS3dKcFJtNE1oSUNvdmVOWmRWZld5UkgwV3hQMmhqRFRp?=
 =?utf-8?B?OTV1bHA3eXBnWXB1MThBdTkwbmtRdG9LK2Zoc1M1b3RxSTFGbzZYU25EZkVU?=
 =?utf-8?B?NEU1R1dSd3d3WDhLV0Mra1pVOWpNMFRmMW5LRGtaWHIxd2d3QllSVU43MENP?=
 =?utf-8?B?ZE00OXdIeEdaaHJmczloK0E0cHBvZUtOc2tBSGtKeXpIZ3czVVFSTENONG53?=
 =?utf-8?B?ZFZpcVA5M3d0Q3FCcDRsUFJha0xDeEZNa1BLZFJpNWxKVk5CM0JTQi9XZWFa?=
 =?utf-8?B?bHlDQ0JHUXFDZHNLUm9FSGh4UXJxL1JSeThqdVpRQm4wKzQwZEVXTlQ0VVNC?=
 =?utf-8?B?a0JEanc4QW1COU1lWjVra0YvN0lUaWpxNEdIdElHQWM4MnRCZmQwK1VyZ0lx?=
 =?utf-8?B?N3VwUTh6cXNFU2VRcHZ4TXZHN0VreFNiK0lSRjFFM0FmQWlWMVFpRnFSdHlN?=
 =?utf-8?B?OTEwdmExU0lBOE44a216TWdnVzJwd1NRSXdhb1puWFNLVmU2M2FvTFJxWldv?=
 =?utf-8?B?Y2RDelQ5cU1SSW85WTI4S09QRko5VmVsYm9UY3gwRnlMaHlXd0pyRWx3WE85?=
 =?utf-8?B?UjBjck4wMElaeHQ3bGVUd1hacjgvRlM4dGxPT05WdUNKUG1sTGg1WXU1eTk0?=
 =?utf-8?B?Tmlnb1haQVI5ZW9oTVFOb1ZMQlZwQ0F6OHNNTnhXMFZiRzFNWWhMZk9aRmtO?=
 =?utf-8?B?RE1pNXlKK2ZpN0hQdWZnZ0V3UG1DbmI4dTAxR29xUTZZQVhLVHhoaWE3ZjdV?=
 =?utf-8?B?NkN3c0JKajAxYXBMN3V6WExOZlF3MnF5S3pwV1VGRGIzdkF4MkVRSFkvcWdY?=
 =?utf-8?B?UnFFZDNCSkIzemx0L2tOMk9pNG1xK3ZnTWtjT1hDWjZVb1NPMmZjc3BJMllx?=
 =?utf-8?B?ank2RFZrT0NrV2JRaGtNaEZ3NkU2NlprUU1YYkd5MmVQc2Y2bjJrQWJXckY5?=
 =?utf-8?B?OTQ3SXhIVGVxMFhhQzN0UzlmQ0pmbS8vN1A2aGdSS1YydFUwU3NWcXptQW15?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C88DAF561C28F4D9073E56203CB110F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR03MB7682.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11662437-dfb8-4326-2cf3-08dc0105cec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 02:46:03.5135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AN1PmC6gGLoF9Vt8GdoS2QAX5gWJFD92Kn5bSnaSslggPQsK2M46qJLYIu3QRIVPlPHUGBNEUTgrYLGoDaTPGSCuRfgln+u45fDEyJJ56b8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB5341

SGkgQ29ub3IsDQoNClRoYW5rcyBmb3IgdGhlIHJldmlld3MuDQoNCk9uIFR1ZSwgMjAyMy0xMi0x
OSBhdCAxNjo1NCArMDAwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBNb24sIERlYyAxOCwg
MjAyMyBhdCAwNDozNjowMVBNICswODAwLCBKYXNvbi1KSC5MaW4gd3JvdGU6DQo+ID4gRnJvbTog
SmFzb24tamggTGluIDxqYXNvbi1qaC5saW5AbWVkaWF0ZWsuY29ycC1wYXJ0bmVyLmdvb2dsZS5j
b20+DQo+ID4gDQo+ID4gU2luY2UgbWVkaWF0ZWssZ2NlLWV2ZW50cyBwcm9wZXJ0eSBpcyBhIEhX
IGV2ZW50IHNpZ25hbCBmcm9tIEdDRSwNCj4gPiBpdCBzaG91bGQgYmUgZGVmaW5lZCBpbiBtZWRp
YXRlayxnY2UtbWFpbGJveC55YW1sLg0KPiA+IA0KPiA+IENoYW5nZSB0aGUgZGVzY3JpcHRpb24g
b2YgbWVkaWF0ZWssZ2NlLWV2ZW50cyBwcm9wZXJ0eSBleGlzdGVkIGluDQo+ID4gb3RoZXIgYmlu
ZGluZ3MgdG8gcmVmZXJlbmNlIG1lZGlhdGVrLGdjZS1tYWlsYm94LnlhbWwuDQo+IA0KPiBJIGRv
bid0IHVuZGVyc3RhbmQgdGhpcyBzZXJpZXMuIEkgd291bGQgdW5kZXJzdGFuZCBpdCBpZiB0aGUg
cHJvcGVydHkNCj4gc2hvdWxkIGJlIHJlbGF0ZWQgdG8gdGhlIG1haWxib3ggcHJvdmlkZXIgYW5k
IGl0IGlzIG1vdmVkIHRoZXJlIGZyb20NCj4gdGhlDQo+IG1haWxib3ggY29uc3VtZXIsIGJ1dCB0
aGlzIHNlcmllcyBkb2VzIG5vdCBkbyB0aGF0LiBJbnN0ZWFkIHRoZQ0KPiBzZXJpZXMNCj4gbm93
IGRvY3VtZW50cyB0aGlzIHByb3BlcnR5IGZvciBib3RoIGNvbnN1bWVycyBhbmQgcHJvdmlkZXJz
Lg0KSSB3YW50IHRvIG1vdmUgcHJvcGVydGllcyByZWxhdGVkIHRvIE1lZGlhVGVrJ3MgcHJvcHJp
ZXRhcnkgR0NFIEhXIHRvIGENCmNvbW1vbiBwbGFjZSBhbmQgbGV0IGl0IHJlZmVyZW5jZWQgYnkg
bWFpbGJveCBwcm92aWRlcnMgYW5kIGNvbnN1bWVycy4NCg0KQW5kIEkgYWxzbyB3YW50IHRvIGFk
ZCB0aGlzIHByb3BlcnR5IGludG8gYSBtYWlsYm94IHByb3ZpZGVyLCBidXQgbWF5YmUNCm5vdCBp
biB0aGlzIHNlcmllcy4gSSdsbCBtb3ZlIHRoaXMgbW9kaWZpY2F0aW9uIGludG8gYW5vdGhlciBz
ZXJpZXMuDQoNCj4gDQo+IFNlY29uZGx5IGl0IHJlbW92ZXMgdGhlIHR5cGVkZWYgZnJvbSB0aGUg
Y29uc3VtZXJzLCB3aGljaCBtYWtlcyBubw0KPiBzZW5zZQ0KPiBpZiB0aGlzIGlzIGEgdmFsaWQg
cHJvcGVydHkgdGhlcmUuDQo+IA0KT0ssIEkgd2lsbCBrZWVwIHRoZSAkcmVmIGZvciB0aGUgY29u
c3VtZXJzLg0KDQo+IElzIHlvdXIgaW50ZW50aW9uIHRvIGRvY3VtZW50IGEgcHJvcGVydHkgdGhh
dCBzaG91bGQgYmUgY29tbW9uIGFjcm9zcw0KPiBhbGwgY29uc3VtZXJzIGluIGEgc2luZ2xlIHBs
YWNlPyBJZiB0aGF0IGlzIHlvdXIgZ29hbCwgdGhlbiBzb21ldGhpbmcNCj4gbGlrZSBzcGktcGVy
aXBoZXJhbC1wcm9wcy55YW1sIGlzIHdoYXQgeW91IG5lZWQgaGVyZS4NCj4gDQpUaGFua3MgZm9y
IHlvdXIgZXhhbXBsZS4NCg0KU2luY2UgdGhlc2UgcHJvcGVydGllcyBmb3IgdGhlIEdDRSBIVyBh
cmUgTWVkaWFUZWsgc3BlY2lmaWMsIEkgd2lsbCB0cnkNCnRvIHNlbmQgYSBzZXJpZXMgdG8gY3Jl
YXRlIGEgbWVkaWF0ZWssZ2NlLXByb3BzLnlhbWwgdG8gbGlzdCBhbGwgdGhlc2UNCnByb3BlcnRp
ZXMuIEFuZCBtb2RpZnkgYWxsIHRoZXNlIHByb3BlcnRpZXMgaW4gbWFpbGJveCBjb25zdW1lcnMu
DQoNClJlZ2FyZHMsDQpKYXNvbi1KSC5MaW4NCg0KPiBDb25mdXNlZCwNCj4gQ29ub3IuDQo=

