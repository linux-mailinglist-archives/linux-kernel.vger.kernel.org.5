Return-Path: <linux-kernel+bounces-80471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4FF8668C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA6E1C215F3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5624118EB8;
	Mon, 26 Feb 2024 03:30:24 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2092.outbound.protection.partner.outlook.cn [139.219.146.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65854C91;
	Mon, 26 Feb 2024 03:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708918223; cv=fail; b=NFd02SmWrwURXxhkyYrGNXtSQtVw4Co+V8fs1yCuql5Dtr4MJGeUZfEux/wmce7FNhAtJd1v7XdKhtJyCDWQjzzqyhYOU9qihau6RiWymbEaN/94AfGwSoqmxO/4puTqhRM0J/4QH2C1NV9AJX3bfVjB1Cboq1MEMqf3vwFUwrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708918223; c=relaxed/simple;
	bh=JLxHZf4BFacB5shFrE3wEQQNY615eNA4WYyIQJZcUPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VhLJOqr4i2T+XuqTgk1Bqdzsdu7NLzAXRMmz7I02tPxqbzDSXybBIjMvlKImNqxIoF92GsdvMrcImsoBRkS+VTGnGMniddw8akOknDMWDS1Nih9t3DOScsb/E1Hm47sDdvlH/RXa4VebZFK6YJQ4TfCHMBXV+mafXCQvwYWNp9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBVfWtS93xjYbm8L+x7a6TXXoeiS79HOTAdL9WGfagWRqS7+8nLjotomAjMtx1P8kvH+MQXl7GCwTOGOI85IP2fK4YJKxw9wcaIIBbNzeyvjBfgmIf2JQcxGY/rzaKzXCMtpHJRtBhVZA17fancJoxd3Vh3GPZnkB5uPeRjmA6XjSr0X/LIOaVTnLvJW1PBhJJ+yOME5LLo4lMz1+KTLhYt9iSfMxPZvpYNv0lhm/uJ8P1iHjLJa2n26SJxEi3Ij322vyGOn8u3SzHYQxDpWOTtbh8A3LkD8PcAlG2R3KPZHTRGF07sLGums9OvUc/bEX2CPKrH8DTpDlEIxormw6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JLxHZf4BFacB5shFrE3wEQQNY615eNA4WYyIQJZcUPU=;
 b=HTi9J//Q8JO3p5NJzJkMtFJ7ix0u50IezUa2U7q156TshtZMBX0DwQAIabghBw/KpRwLz8X/h7rei0cibzoBBvJUxEseBCYi0DUwjhjMxlUalhukrH9Ubx/W6hFCCUZodve5mTIJjj9u4z55mhW86jVoPBaXIYMA+W5zRfPnqezRmXBVttOGHXgpclihLmMpUcB+y7WHE1gLDmfnFLkYxcGGUqfqsEHJQ5BeCNg1h/vt0m8bTiNBJ0fni+sOC1YD3qg9J0/E6B4oPPYt1Axw6aUpbtTx330bJXmvJQLPdMq5duP2jA7z40DocBiz7zS3oA+9Ym/0q18Ifo6kTLRGKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:3::6) by NT0PR01MB1232.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:11::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.48; Mon, 26 Feb
 2024 02:56:26 +0000
Received: from NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
 ([fe80::864d:4582:2361:d9c8]) by
 NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn ([fe80::864d:4582:2361:d9c8%3])
 with mapi id 15.20.7270.047; Mon, 26 Feb 2024 02:56:26 +0000
From: Shengyang Chen <shengyang.chen@starfivetech.com>
To: Vinod Koul <vkoul@kernel.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"kishon@kernel.org" <kishon@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	Minda Chen <minda.chen@starfivetech.com>, Changhuang Liang
	<changhuang.liang@starfivetech.com>, "rogerq@kernel.org" <rogerq@kernel.org>,
	"geert+renesas@glider.be" <geert+renesas@glider.be>, Keith Zhao
	<keith.zhao@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] phy: starfive: Add mipi dphy tx support
Thread-Topic: [PATCH v3 2/2] phy: starfive: Add mipi dphy tx support
Thread-Index: AQHaWMRxUo4WJSHak0Kpzlw9p0kYlbD+sTaAgBdqMzCAAdYpAIAEGgjw
Date: Mon, 26 Feb 2024 02:56:26 +0000
Message-ID:
 <NT0PR01MB10703C124AECDF8B8F844DDBEF5AA@NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn>
References: <20240206061921.107372-1-shengyang.chen@starfivetech.com>
 <20240206061921.107372-3-shengyang.chen@starfivetech.com>
 <ZcNc8zZzsVU6viBL@matsya>
 <NT0PR01MB107009D37C2BBD9AC5B3CC4FEF56A@NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn>
 <ZdiLpvOgi8ztTT5V@matsya>
In-Reply-To: <ZdiLpvOgi8ztTT5V@matsya>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1070:EE_|NT0PR01MB1232:EE_
x-ms-office365-filtering-correlation-id: e52607a9-408b-4724-b8a2-08dc3676862e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 /uZnklIVyGIP+/Y94cdlNWLFSDKhCa9tZXefHF6vzIMhbQCQBgfej/HOu9d5zhjjchc5ypq9tLnL/1tbWp+NxBwMfLijPHifWoMXNu+sFg7I0P/nU5V5qJRrsY0ifPOA3RamdA8C4PknVpKZGyvrupmkuhUpGGkRQC43V+A4BPjuengVrvf2xzh05pKX1K7f++P0o1+yJIiNWPLZR5wDXULO4pqY56kyOuURJG/x7I8PwCxpAKuxwtZfsoDz1NjCfvILaSZcmLYlKD/NQHIItR4CdeiaSTBvzzhBHpm4MjNKA5cT0OPewreUbG6EDUecXG8KCEmB2bzPutYUa3ZiVhupT1gj1+Q2g4XO9RZuLJoHGE/vc6aqp7MOluFMj7ng+WD4Sq1hzY3inBwqIM5UBgWx/cZ9MVRghChQSKx7ylu+6urnswFseaXKxiDZ3U4DJZ93igF+DgW97H91CDCT7LWUYdMKKekM1BlFkWfMVyg0/lzfFNzev1Ud5MPRTnn6EAP/JV+22hGb3AGQItys5OR2kSPANA8hEimPn3Y6o1oAcf9deSju/IQYTmWdKy9xXTEjpdRGg0CebkXgl6Z3gLOMFTZQc3GcJQEuXvfsmy8nGPfpSfhhgS4pH4TG3cVI
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFFNZHJJOE9leDNhamxONGh0NlpZRE83SFdsL0N4Qkc4MWo1M3FnaUtpNWhr?=
 =?utf-8?B?R1V0UGVSak9HdmZRYXNrMkRlb1BJVXlDb2owUlc1MFcyZ0E5SGd2U1Q5ZjU0?=
 =?utf-8?B?OU1ZTzRUSU53ck5ydFdTSkw3M1JsY0pOSUVVczZXQWh4MHFteFlQL2ZiWG50?=
 =?utf-8?B?b3loTEgvOVFPYXJtdUtCQm1sWnkvMVZaWmdudHNYVVRnUjdUUFdVZlpkK0No?=
 =?utf-8?B?RmtvNjFPKzhBU29YdjArYzlSeFNHaERBeExkeHNkRGRWZlF1dmplYUw1Q1dQ?=
 =?utf-8?B?VlZOb3VuZkI1clllTHBsc3ZNMGx0OFk2L0liSC9NK25JYTlxV0k2Y2ZkaEJ3?=
 =?utf-8?B?ZEs3N1pzWFRGVkxKNHFVWVh0WjQyaWxjYkQ0aFpWOFd3ZXdKd3d1K01YNlc5?=
 =?utf-8?B?bG41RUpSSkY4MEx0OFBlaWlkRkxrSDRoMG14RjZQZkRZNFhsZHJvNXJjVGNw?=
 =?utf-8?B?b0oyeHhXZjJCSjBFY1lTQ3Y1K0ZSbkIvOE1VdDY3OGJqSDZlYlNQMUtTdWM3?=
 =?utf-8?B?ZS9VL0xtdUt2a251dnBxRWNVVlZ3RXoxSnk5RjNHdnN4dVpObzJvRzkyK0Mz?=
 =?utf-8?B?U21yNmhxcXlnWE45QzZ0NG1uQThrN04waTZSd2w0ZTV1ejNCSkpZY3RLZSs5?=
 =?utf-8?B?c1l3emdkeDZjSGl0bjArOVpjWjFxZTlMY3Q5c0RSYTA0OEt0QkEvcG5CT3Vq?=
 =?utf-8?B?Z0p1UUJCY2NzWEYyWEhPemVrZCt0TUdYbVNwTVEzbEFPY1BCWWFWdXNCVk15?=
 =?utf-8?B?bytSN0paYXBQL3k1dmN5SWtPYlBkNnlTNHFEckZ5SS9TdlI1SVNqWjZxbk9Z?=
 =?utf-8?B?QTYyVGU2em1RSExRRFh5bUlza09oS3NqS0pxTW1sdDFSZnphTVFFdTRqakRD?=
 =?utf-8?B?K2ZpdHZSdGlZS3o5N3p5N3kydlBQU2Z0TlpuWUwvS252em51TXFxKytUbndx?=
 =?utf-8?B?VWcwUU9GRXdwWXhpQnV5Nkg2RXkvaUt2R2h2bDZFdjBhSm1Sa1dNNTVETHA4?=
 =?utf-8?B?alNFaWxaRjRpWkRSeE5abUVNZytUank4TnZxREhKTDFDajZSSjhCYWRQcWQ1?=
 =?utf-8?B?YklrQlgwNkh4amFvaHlyYkcxMUdHeVRwT0ZOd0p0UzJ5TlEvRGxwWmcvMW1Z?=
 =?utf-8?B?TlM0TjlnWkgvT0pNRHQzVU9kOGRUUUE5cDlQeGpkeFROaTFlMVM5MXk1azJQ?=
 =?utf-8?B?eFJnSllFN2RUMVd6S3U3dlRGejVWclR0NVBSWjJBS1NXd1pmdTRUQmJKL0g0?=
 =?utf-8?B?OWpiVlFVdXVldUFXcllLMXJQK1h5QzE3eXRtMy9Ienh4TytKcjF4Qkw5VThR?=
 =?utf-8?B?em9HVm5vM251OG1wUURQS0ZsbVQzaUhwNDNveHphaC93SS8zYlpUcEp4QVBL?=
 =?utf-8?B?d0U0anljMVBUNEVqQjBUQjdHR3k2bkZlU0hSc3ZTRVZma2tnM3BMYkNLQ3lF?=
 =?utf-8?B?RWtubDJpWW0weVhlQlBqQi9oenR4cnJQbzdaNi9qUTBKamE5bU5RQ0lTaDlD?=
 =?utf-8?B?aEJ4dWkxS1VueENmcDBKR2c2cFp4S0VuYnRPWkMrSktiM1JjVVpSODh5WHFo?=
 =?utf-8?B?UVZUbjNRS1pwNDlyVXJISUNsaEJyZHN4L3BlREgrUVdiOUpWS21nWXRXYkxz?=
 =?utf-8?B?S212WXBDOUd2RWVXajlidHZTNGxOeFV1K0FZQ1JGMzRQVEd1RTJLbS9tZ25k?=
 =?utf-8?B?dUl6Ujc0UTcyc0VnaWIyUFZXQ2JCN3NHTHpDY3RpTHdiQjRiVUtoUXlvZndO?=
 =?utf-8?B?Q3dnd25nTUU1Sjd2cVpvcnNNRUMrTXovb3F3SUJZKzFBc0lGRmY2amszMGRp?=
 =?utf-8?B?RjRBbDF4ZWw3S0ZSNjhmRmUzZCtoM3B3TlROYldSd1JjV3ErMXhhakp6VEtE?=
 =?utf-8?B?RUgxVzY5WmRFbk95b2d6SzhRS2xnUlpoTWR3UUQ0azhLQWttaktjN29lYndy?=
 =?utf-8?B?dUJqL096dWt2R3dmelJBd20vbmFrOEk1Mm5QWW56MUQ0SDdPSUdnQ2VVTTNQ?=
 =?utf-8?B?SENXbitqekl3M3dQOEd0ek5QRzg3NGUrVEtRc0sxTENESCs1eThSSXZaa1hk?=
 =?utf-8?B?NlFCdnVKR2lwTWdlbVVscXFSYnR0aTQxMXNROWY5ci9iU1BYZ1l3V3ZUYXBQ?=
 =?utf-8?B?NnVZL0VmN2lMRmVaN3kydmZ3YXJuQ0N4LzI3cmlvVG96SUs2YkJJS3EybnRG?=
 =?utf-8?B?Ync9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1070.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: e52607a9-408b-4724-b8a2-08dc3676862e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 02:56:26.4495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqfdEH+Wy1HUB3YCAx15ixTut7fWnCH57k2MNEF4UnpI11E8Aigv5akK777PBeHEiJAp2Hb1AkDyfbr2wASqHcOQ2qhZzXQZtRwmT3Wi/+0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1232

SGksIFZpbm9kDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlub2Qg
S291bCA8dmtvdWxAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNOW5tDLmnIgyM+aXpSAyMDoxMg0K
PiBUbzogU2hlbmd5YW5nIENoZW4gPHNoZW5neWFuZy5jaGVuQHN0YXJmaXZldGVjaC5jb20+DQo+
IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVh
ZC5vcmc7DQo+IGtpc2hvbkBrZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGtyenlzenRv
Zi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsgcC56YWJl
bEBwZW5ndXRyb25peC5kZTsgTWluZGEgQ2hlbg0KPiA8bWluZGEuY2hlbkBzdGFyZml2ZXRlY2gu
Y29tPjsgQ2hhbmdodWFuZyBMaWFuZw0KPiA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2gu
Y29tPjsgcm9nZXJxQGtlcm5lbC5vcmc7DQo+IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBLZWl0
aCBaaGFvIDxrZWl0aC56aGFvQHN0YXJmaXZldGVjaC5jb20+Ow0KPiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMi8yXSBwaHk6IHN0YXJmaXZl
OiBBZGQgbWlwaSBkcGh5IHR4IHN1cHBvcnQNCj4gDQo+IE9uIDIyLTAyLTI0LCAwODo0OCwgU2hl
bmd5YW5nIENoZW4gd3JvdGU6DQo+ID4gSGksIFZpbm9kDQo+ID4NCj4gPiBUaGFua3MgZm9yIHJl
dmlldyBhbmQgY29tbWVudC4NCj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gPiA+IEZyb206IFZpbm9kIEtvdWwgPHZrb3VsQGtlcm5lbC5vcmc+DQo+ID4gPiBTZW50OiAy
MDI05bm0MuaciDfml6UgMTg6MzYNCj4gPiA+IFRvOiBTaGVuZ3lhbmcgQ2hlbiA8c2hlbmd5YW5n
LmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+IENjOiBkZXZpY2V0cmVlQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+ID4gPiBraXNob25Aa2VybmVs
Lm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+ID4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBs
aW5hcm8ub3JnOw0KPiA+ID4gY29ub3IrZHRAa2VybmVsLm9yZzsgcC56YWJlbEBwZW5ndXRyb25p
eC5kZTsgTWluZGEgQ2hlbg0KPiA+ID4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT47IENo
YW5naHVhbmcgTGlhbmcNCj4gPiA+IDxjaGFuZ2h1YW5nLmxpYW5nQHN0YXJmaXZldGVjaC5jb20+
OyByb2dlcnFAa2VybmVsLm9yZzsNCj4gPiA+IGdlZXJ0K3JlbmVzYXNAZ2xpZGVyLmJlOyBLZWl0
aCBaaGFvIDxrZWl0aC56aGFvQHN0YXJmaXZldGVjaC5jb20+Ow0KPiA+ID4gbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAyLzJdIHBoeTog
c3RhcmZpdmU6IEFkZCBtaXBpIGRwaHkgdHggc3VwcG9ydA0KPiA+ID4NCj4gPiA+IE9uIDA2LTAy
LTI0LCAxNDoxOSwgU2hlbmd5YW5nIENoZW4gd3JvdGU6DQo+ID4gPiA+IEFkZCBtaXBpIGRwaHkg
dHggc3VwcG9ydCBmb3IgdGhlIFN0YXJGaXZlIEpINzExMCBTb0MuDQo+ID4gPiA+IEl0IGlzIGEg
bW9kdWxlIHdoaWNoIGlzIHVzZWQgdG8gcmVjZWl2ZSBkYXRhIGZyb20gRFNJIGRyaXZlciBhbmQN
Cj4gPiA+ID4gdHJhbnNmZXIgZGF0YSB0byBEU0kgaW50ZXJmYWNlIGxpa2UgbWlwaSBzY3JlZW4u
DQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoZW5neWFuZyBDaGVuIDxzaGVuZ3lh
bmcuY2hlbkBzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gIE1BSU5UQUlO
RVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA3ICsNCj4gPiA+ID4gIGRyaXZl
cnMvcGh5L3N0YXJmaXZlL0tjb25maWcgICAgICAgICAgICAgIHwgIDEwICsNCj4gPiA+ID4gIGRy
aXZlcnMvcGh5L3N0YXJmaXZlL01ha2VmaWxlICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ID4g
IGRyaXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtZHBoeS10eC5jIHwgNjM1DQo+ID4gPiA+
ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gIDQgZmlsZXMgY2hhbmdlZCwgNjUzIGlu
c2VydGlvbnMoKykgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiBkcml2ZXJzL3BoeS9zdGFy
Zml2ZS9waHktamg3MTEwLWRwaHktdHguYw0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
TUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleA0KPiA+ID4gPiA5NDRiOGVjMzM2MzkuLjVl
MDYyYjczOTNjYiAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvTUFJTlRBSU5FUlMNCj4gPiA+ID4gKysr
IGIvTUFJTlRBSU5FUlMNCj4gPiA+ID4gQEAgLTIwODY0LDYgKzIwODY0LDEzIEBAIFM6CVN1cHBv
cnRlZA0KPiA+ID4gPiAgRjoJRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9z
dGFyZml2ZSxqaDcxMTAtZHBoeS1yeC55YW1sDQo+ID4gPiA+ICBGOglkcml2ZXJzL3BoeS9zdGFy
Zml2ZS9waHktamg3MTEwLWRwaHktcnguYw0KPiA+ID4gPg0KPiA+ID4gPiArU1RBUkZJVkUgSkg3
MTEwIERQSFkgVFggRFJJVkVSDQo+ID4gPiA+ICtNOglLZWl0aCBaaGFvIDxrZWl0aC56aGFvQHN0
YXJmaXZldGVjaC5jb20+DQo+ID4gPiA+ICtNOglTaGVuZ3lhbmcgQ2hlbiA8c2hlbmd5YW5nLmNo
ZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gPiA+ID4gK1M6CVN1cHBvcnRlZA0KPiA+ID4gPiArRjoJ
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BoeS9zdGFyZml2ZSxqaDcxMTAtZHBo
eS10eC55YW1sDQo+ID4gPiA+ICtGOglkcml2ZXJzL3BoeS9zdGFyZml2ZS9waHktamg3MTEwLWRw
aHktdHguYw0KPiA+ID4gPiArDQo+ID4gPiA+ICBTVEFSRklWRSBKSDcxMTAgTU1DL1NEL1NESU8g
RFJJVkVSDQo+ID4gPiA+ICBNOglXaWxsaWFtIFFpdSA8d2lsbGlhbS5xaXVAc3RhcmZpdmV0ZWNo
LmNvbT4NCj4gPiA+ID4gIFM6CVN1cHBvcnRlZA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9waHkvc3RhcmZpdmUvS2NvbmZpZw0KPiA+ID4gPiBiL2RyaXZlcnMvcGh5L3N0YXJmaXZlL0tj
b25maWcgaW5kZXggOTUwOGUyMTQzMDExLi5kMGNkZDdjYjRhMTMNCj4gPiA+ID4gMTAwNjQ0DQo+
ID4gPiA+IC0tLSBhL2RyaXZlcnMvcGh5L3N0YXJmaXZlL0tjb25maWcNCj4gPiA+ID4gKysrIGIv
ZHJpdmVycy9waHkvc3RhcmZpdmUvS2NvbmZpZw0KPiA+ID4gPiBAQCAtMTUsNiArMTUsMTYgQEAg
Y29uZmlnIFBIWV9TVEFSRklWRV9KSDcxMTBfRFBIWV9SWA0KPiA+ID4gPiAgCSAgc3lzdGVtLiBJ
ZiBNIGlzIHNlbGVjdGVkLCB0aGUgbW9kdWxlIHdpbGwgYmUgY2FsbGVkDQo+ID4gPiA+ICAJICBw
aHktamg3MTEwLWRwaHktcngua28uDQo+ID4gPiA+DQo+ID4gPiA+ICtjb25maWcgUEhZX1NUQVJG
SVZFX0pINzExMF9EUEhZX1RYDQo+ID4gPiA+ICsJdHJpc3RhdGUgIlN0YXJGaXZlIEpINzExMCBE
LVBIWSBUWCBTdXBwb3J0Ig0KPiA+ID4gPiArCWRlcGVuZHMgb24gSEFTX0lPTUVNDQo+ID4gPiA+
ICsJc2VsZWN0IEdFTkVSSUNfUEhZDQo+ID4gPiA+ICsJc2VsZWN0IEdFTkVSSUNfUEhZX01JUElf
RFBIWQ0KPiA+ID4gPiArCWhlbHANCj4gPiA+ID4gKwkgIENob29zZSB0aGlzIG9wdGlvbiBpZiB5
b3UgaGF2ZSBhIFN0YXJGaXZlIEQtUEhZIFRYIGluIHlvdXINCj4gPiA+ID4gKwkgIHN5c3RlbS4g
SWYgTSBpcyBzZWxlY3RlZCwgdGhlIG1vZHVsZSB3aWxsIGJlIGNhbGxlZA0KPiA+ID4gPiArCSAg
cGh5LWpoNzExMC1kcGh5LXR4LmtvLg0KPiA+ID4gPiArDQo+ID4gPiA+ICBjb25maWcgUEhZX1NU
QVJGSVZFX0pINzExMF9QQ0lFDQo+ID4gPiA+ICAJdHJpc3RhdGUgIlN0YXJmaXZlIEpINzExMCBQ
Q0lFIDIuMC9VU0IgMy4wIFBIWSBzdXBwb3J0Ig0KPiA+ID4gPiAgCWRlcGVuZHMgb24gSEFTX0lP
TUVNDQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9zdGFyZml2ZS9NYWtlZmlsZQ0K
PiA+ID4gPiBiL2RyaXZlcnMvcGh5L3N0YXJmaXZlL01ha2VmaWxlIGluZGV4IGIzOTEwMThiN2M0
Ny4uZWVkYzRhNmZlYzE1DQo+ID4gPiA+IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL3Bo
eS9zdGFyZml2ZS9NYWtlZmlsZQ0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BoeS9zdGFyZml2ZS9N
YWtlZmlsZQ0KPiA+ID4gPiBAQCAtMSw0ICsxLDUgQEANCj4gPiA+ID4gICMgU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjANCj4gPiA+ID4gIG9iai0kKENPTkZJR19QSFlfU1RBUkZJVkVf
Skg3MTEwX0RQSFlfUlgpCSs9DQo+IHBoeS1qaDcxMTAtZHBoeS1yeC5vDQo+ID4gPiA+ICtvYmot
JChDT05GSUdfUEhZX1NUQVJGSVZFX0pINzExMF9EUEhZX1RYKQkrPQ0KPiBwaHktamg3MTEwLWRw
aHktdHgubw0KPiA+ID4gPiAgb2JqLSQoQ09ORklHX1BIWV9TVEFSRklWRV9KSDcxMTBfUENJRSkJ
CSs9DQo+IHBoeS1qaDcxMTAtcGNpZS5vDQo+ID4gPiA+ICBvYmotJChDT05GSUdfUEhZX1NUQVJG
SVZFX0pINzExMF9VU0IpCQkrPSBwaHktamg3MTEwLXVzYi5vDQo+ID4gPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BoeS9zdGFyZml2ZS9waHktamg3MTEwLWRwaHktdHguYw0KPiA+ID4gPiBiL2Ry
aXZlcnMvcGh5L3N0YXJmaXZlL3BoeS1qaDcxMTAtZHBoeS10eC5jDQo+ID4gPiA+IG5ldyBmaWxl
IG1vZGUgMTAwNjQ0DQo+ID4gPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uMDBiZTExOGM5NjA2DQo+
ID4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9waHkvc3RhcmZpdmUv
cGh5LWpoNzExMC1kcGh5LXR4LmMNCj4gPiA+ID4gQEAgLTAsMCArMSw2MzUgQEANCj4gPiA+ID4g
Ky8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiA+ID4gPiArLyoNCj4gPiA+
ID4gKyAqIERQSFkgVFggZHJpdmVyIGZvciB0aGUgU3RhckZpdmUgSkg3MTEwIFNvQw0KPiA+ID4g
PiArICoNCj4gPiA+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyMyBTdGFyRml2ZSBUZWNobm9sb2d5
IENvLiwgTHRkLg0KPiA+ID4gPiArICogQXV0aG9yOiBLZWl0aCBaaGFvIDxrZWl0aC56aGFvQHN0
YXJmaXZldGVjaC5jb20+DQo+ID4gPiA+ICsgKiBBdXRob3I6IFNoZW5neWFuZyBDaGVuIDxzaGVu
Z3lhbmcuY2hlbkBzdGFyZml2ZXRlY2guY29tPiAgKi8NCj4gPiA+ID4gKw0KPiA+ID4gPiArI2lu
Y2x1ZGUgPGxpbnV4L2Nsay5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ID4g
PiA+ICsjaW5jbHVkZSA8bGludXgvbWZkL3N5c2Nvbi5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxp
bnV4L21vZHVsZS5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L29mLmg+DQo+ID4gPiA+ICsj
aW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvcGh5
L3BoeS5oPg0KPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3BoeS9waHktbWlwaS1kcGh5Lmg+ICNp
bmNsdWRlDQo+ID4gPiA+ICs8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+ICNpbmNsdWRlIDxsaW51
eC9wbV9ydW50aW1lLmg+ICNpbmNsdWRlDQo+ID4gPiA+ICs8bGludXgvcmVzZXQuaD4NCj4gPiA+
ID4gKw0KPiA+ID4gPiArI2RlZmluZSBTVEZfRFBIWV9BUEJJRlNBSUZfU1lTQ0ZHKHgpCQkJKHgp
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyNkZWZpbmUgIFNURl9EUEhZX0FPTl9QT1dFUl9SRUFEWV9O
X1NISUZUCQkweDBVDQo+ID4gPiA+ICsjZGVmaW5lICBTVEZfRFBIWV9BT05fUE9XRVJfUkVBRFlf
Tl9NQVNLCQlCSVQoMCkNCj4gPiA+ID4gKyNkZWZpbmUgIFNURl9EUEhZX0NGR19MMF9TV0FQX1NF
TF9TSElGVAkJCTB4Q1UNCj4gPiA+DQo+ID4gPiBsb3dlciBjYXNlIHBsZWFzZSwgaGVyZSBhbmQg
ZXZlcnl3aGVyZQ0KPiA+DQo+ID4gU29ycnksIEknbSBhIGxpdHRsZSBjb25mdXNlZCBhYm91dCB0
aGlzLg0KPiA+IERvIHlvdSBtZWFuIGNoYW5naW5nICcweENVJyB0byAnMHhDdSc/DQo+IA0KPiBO
b3BlLCBpdCBzaG91bGQgYmUgMHhjVSwgYWxsIHRoZSBoZXggdmFsdWVzIHNob3VsZCBiZSBpbiBs
b3dlciBjYXNlDQo+IA0KDQpPayBJIHNlZS4gVGhhbmtzIGZvciByZXBseQ0KV2lsbCBmaXggaXQg
aW4gbmV4dCB2ZXJzaW9uDQoNCj4gLS0NCj4gflZpbm9kDQoNCkJlc3QgUmVnYXJkcywNClNoZW5n
eWFuZw0KDQo=

