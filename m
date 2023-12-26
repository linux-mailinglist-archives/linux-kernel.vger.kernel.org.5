Return-Path: <linux-kernel+bounces-11413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE2781E5EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EAF1C21D43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 08:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D87C4CB5C;
	Tue, 26 Dec 2023 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="aOc+qg9L";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="FCCSKODg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ACA4CB3C;
	Tue, 26 Dec 2023 08:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b3f421fca3c811eeba30773df0976c77-20231226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=tFZttR3JtCZx8d+NeE8X859CFOvQmc3vVav6Dy0b4fg=;
	b=aOc+qg9L8jV3wxXHvl2u6hJTCnuN6z1iszg8R15F3qotFWee2Y7dii5BWcJ9Piu9qaczfhjHKtC0j1TD4u3KGW07Ue8WWwzW0jCKRy8naZ00vFAMvkvf9R8DxxBOrOMvt2Rda2iRVCiSWB8FdktqVP6QFVkl9rMnAn4aAUJ4SVU=;
X-CID-CACHE: Type:Local,Time:202312261557+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:56d1e6af-3e84-40de-b5e8-5569ed51ac9e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:5d391d7,CLOUDID:99622d82-8d4f-477b-89d2-1e3bdbef96d1,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
	DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b3f421fca3c811eeba30773df0976c77-20231226
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <ck.hu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 200059689; Tue, 26 Dec 2023 16:28:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Dec 2023 16:28:09 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Dec 2023 16:28:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZ0ulEDnpz+ghlJ/OteGUrtZ9zFw3GRmEX20ZBquNqrFbNlpJCfwUydaNH657kjwaK5NE8P0PW8Av5EVvEDV7IRywFp5GX8umcvlhWJzpYxhGqn4oziwrfhiOLrMaZ6smG+q9bGx4iypTf9boEuu0Qheyds+kwZHg75gH3HdaHrdI1bUyieFUYI2OpXyEuY0fjEhMo8FUr1vYhQs2x60MBv4Ds+vmS7vAEU2oSOX/2MXXFYLNkd1Yayb4TqEE4/PMmWP/LXsoQlHBEyXZC9EQArPsXHd5jerIa8TI9cmWL7Fw8M4rg/8clAUTU+Si+/W5ra+rlhD2luM3s/3jaeOrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFZttR3JtCZx8d+NeE8X859CFOvQmc3vVav6Dy0b4fg=;
 b=K537MG5U5nDH5mSNM+yrFoZ9FhJww5XQNrkFIcYmcNC0XOt7512evRvom41l9W4sVHVAhXXnEfTD9pjPJUB32Ngc6TfaIhah/MO+cJav5yjo5T2pIhVT9RnItHIxJ8jb5QZ/qQDg7teNXY+TO9466OLh23Hgh7jJK0BY50L5itfJUgVyT+6b5KkXOZf4B+KgbzFA26+WQ/jKqbhe7tfFjMvQFID0PGSyD30d2GBFKQQ6NFYNcIrAf1Sy6n9p9Ty66DsfbDaJghCaQKXuPfRCdZ4ykUL8IPgH088qBbDDK2pAnvnwuXqWTq6FGuMg4km9sXOMX3fUuy4e3fFUWWNs7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tFZttR3JtCZx8d+NeE8X859CFOvQmc3vVav6Dy0b4fg=;
 b=FCCSKODgLzacC0okVHV7dAsN82oaZ8zeHjjlV/+qALBa1jyipiZN/LkH2VIdOlO/CD/2UBxwsixsa61P6JOzqdlnoZXssYuyRd1pYLPfPcVXkuI9Tecquo2nY4TPm5uYS+2vU9z8BTnOn8j1Xr7C9HSBWQjFwRw1RC3rLSBGaJE=
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com (2603:1096:400:1f4::13)
 by PUZPR03MB6158.apcprd03.prod.outlook.com (2603:1096:301:b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.27; Tue, 26 Dec
 2023 08:28:03 +0000
Received: from TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762]) by TYZPR03MB6624.apcprd03.prod.outlook.com
 ([fe80::eb43:57cb:edfd:3762%7]) with mapi id 15.20.7113.027; Tue, 26 Dec 2023
 08:28:03 +0000
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
Thread-Index: AQHaNJMHlgU6p3MSPUCi0pus2NsH47C7QbsA
Date: Tue, 26 Dec 2023 08:28:03 +0000
Message-ID: <a0c9d84f8a2d6efdfd7502f796e5629a8471c9eb.camel@mediatek.com>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
	 <20231222045228.27826-9-jason-jh.lin@mediatek.com>
In-Reply-To: <20231222045228.27826-9-jason-jh.lin@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR03MB6624:EE_|PUZPR03MB6158:EE_
x-ms-office365-filtering-correlation-id: b4d6521d-b3ce-4be2-e984-08dc05ec93ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzgsXUO0YK2hoj0elLeWsE6S7fbZSkm0R0QgrgEU4JLEgfl9vEklIdgnevKyFgxcWKqF0S5pPWbpU/h62hgCX/NK+4TrQsIrYwtn/fE4P1EvcSOpU5eWrhmFmtVy4mLM6dh4rY7Rs3VIMzUU0ap3a09bP9wG+iOIe2MhxF2149OqOjZrIieWnnYg8hYbHpEDX5TT6EkUOlZ+pGnovF8Ewfhiuc2jA4ADcXZkr9BY6BTNBRBD6DuHrzPVgK6W3dEWBki1W0Lkqp1xPdkjjO4Vgi8Eb1CDQU/Zak5Axs2C/Tok5QF+5Q/iUNFcuwDMvJ+hHTu8QaU/bUGVZqT58A5sFdIlGW5ddrHsMEis5KlGoQK63pMtV8PsDDp6GJ4HRaj6KnNHcHlCs8o/7KWy30/9KO0SOKRZ9rH5oNaoaQTdV1PzRsswQtX86CRMnWUetzF7sm5UbEpP5SbljBi+zla0fTtshIHnDV4VDqCm94H+I27lAdlP1ZH6iC/S4Kjy2woM45Nv3a1nLOL16ZTyK60Ja+3EinEcv3Ttx2BcOWQmoPTuki3B9qp53eMpveSR5v97dFpvdGKtztIuxlXdH2t1kzXZ5L2XyNQYe1aVUXwqFGGK7MZhtDPQVFpzhYw1WCa2biV90NAbZztH2zXR4wKZ4xIHLfqL0M2kx9hEM62kRCo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6624.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38070700009)(83380400001)(110136005)(76116006)(54906003)(316002)(64756008)(66446008)(66946007)(66556008)(66476007)(8936002)(4326008)(8676002)(6512007)(6506007)(71200400001)(478600001)(2616005)(26005)(38100700002)(6486002)(41300700001)(4001150100001)(5660300002)(15650500001)(7416002)(2906002)(122000001)(85182001)(86362001)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cnJhaC9hMGVXd3Z6MTI0TTBPTFp0NFRWUEI5cVhRbWYvdysxZlB0N1FSdFBP?=
 =?utf-8?B?NmxYRE5hWmNzVFdQUGc5UmIrN3ZiSWNSSWVYYjJkRXFybWVrWms3Vkk3UWxW?=
 =?utf-8?B?RjBta1pEeGNMMmREUjFjb3FPa2pFOGdZeDFBdDVnNXhEVUM4cEM4cWpYVzNa?=
 =?utf-8?B?cXFLeHBWeitCQ2RLYk1PaXZBMHMzUWNTZUgyTWNFV3JzSHRIN3hzeHFXYitj?=
 =?utf-8?B?UUx1b25ZdGxmNzBHMSswREZyM2Vva3NQT1ZoUXcydmNna2d4UE5yUWNhcnZN?=
 =?utf-8?B?RHJlOCtxajZ4SXhpREl1TlY4amEzK1pKWnFYRUx2SjFxSXBxSzZtem1ZalRk?=
 =?utf-8?B?Nzl6RHhrUGlVeVVyVU1ZR2piaEhBTGNJUHQrdzdUOXNOZ01CcC9QdDgyUy82?=
 =?utf-8?B?V2JPZDYwVW1ueStaVFlJUUZqb0xzSitQMTFjWXgvUHlkUlk3R1NLYWtlOHo4?=
 =?utf-8?B?V1huY2lSNFRwMnRlOEhNdkZEKzY4N1E4NXlWenhtdmx6Z29Rak8zQXZpRHk3?=
 =?utf-8?B?T3ZqSzlCY2FDV0hGbm0ySE9tek4zNFc5VDgrcHFvNHdWWWZsQVo4VitSa3lI?=
 =?utf-8?B?QkhFL0p0Qkd1UTFjVjNyV3U4eG10YitXWjl1WnlRWUtLdDlXZDI3blFSSXJD?=
 =?utf-8?B?cXIvNDVEczErT0NJN2txUXRIcFhSbjBUU3h2b01PUEVpZ0l3ZnZGbWpMTVcr?=
 =?utf-8?B?OVdJbitTS1B2Z1VZZlcyTXo4aU9qNmtSRzhnMUpHS2RQS0NWM0VxV2NaOU14?=
 =?utf-8?B?R0Z6OFlhR3dmUHV3T0taekxIZHNtYS9LWGlxUkhBTjVaRzAzV0xNKzZyMGJG?=
 =?utf-8?B?cTVTZUFRWWFRRElodG42S21tR0pUR1dXVUwvbjNmdWhFazVlSnhxQ3BiQm9E?=
 =?utf-8?B?M2VrUDhzdnYwN0k1MDFLMkhIWGtpcTJTMHJGTU5hVzk1UTZOVnpjbHVRMU8x?=
 =?utf-8?B?NnVDQjF6WEdZbGtsZ3FJOS9RcktZcjh5ZWdjbFcwZ0Q2T1hxRUkyWVhNL2Mx?=
 =?utf-8?B?aFBwQmU1aE5GR0ZLS1F5QmJ1bGRJRGRPNWRkQ1VYQ0tCOXphYUh3NkFyc0hm?=
 =?utf-8?B?dndOekJQMUpGOFdMWE5aYi9GeU1zeFI0YlhQczI5ZjZyN3JKRFoxc2w1Vzdh?=
 =?utf-8?B?RTJIeGsyL3FpNG5WY2w1YmgxR1FBMW10UVJvRlErMFJuL3NwbWtXNFdEdWVa?=
 =?utf-8?B?SGZhMXducm5xV09LaUZqRWkwMkIyQ3BFZ2t3Z1hnRncvVDRjdW9xTklFM01R?=
 =?utf-8?B?Z00xOHB3YjA4TFptUWNHTTduWDZmMkozaWVIRXhuTHdrSXQwclFpNWRkYmRJ?=
 =?utf-8?B?MGtwcHV4N09NSTJtYVh0dkp2NDJxTGk4OCtsZkw0blZvT0VFSEU3N3g2TEQ0?=
 =?utf-8?B?dW9hVGFFQlFyZFhzOGUwZTRMNzNjejQveENTaHZpK0k1RHNVbTJ2RktzbEFx?=
 =?utf-8?B?UFFOS2REWlVKelQ4MW42cGNackVtNEFOSGJZNThoaEk5eDYrOHJCU0RsY29o?=
 =?utf-8?B?VmZONzdUeTdXZlhTTURIYzJURXZBc3FRcWpiV0w0cDR0M3VJWk9lbzVyc29x?=
 =?utf-8?B?eHJudVR4b0VrOWpFRURaNXhvOW9PTEx5Y3NmQjRjOVlnQ3F0bG5tWkZuSjRr?=
 =?utf-8?B?YmM4a3I4YUNYcUthcU5RVnA5dnRFVkZvNitlNG9jYTRTZkRHZTJtUkdyK3hM?=
 =?utf-8?B?SElSb2JMMHRyTk9rQjZrbVU4VTdPWkoycHUzM0cwOTFOYjJTTmFWNDU5SlE4?=
 =?utf-8?B?UXptOFZ5NzFUbGhIWEYvQ2JDdE8zTUZ1NEplREE1aU92a1dhODBQRVRLaWFk?=
 =?utf-8?B?QzVmaDloTElKU0xjL1l1OVhDVWdSeE94MlFLSGE2UlE2MlF2d2t2dUtNbzYz?=
 =?utf-8?B?Rm8yQnZlOVR1TUdsS2N6dGZ5K2hrNUN5ajBxL3ZyQkZndnZUUjV5TjFoeXp1?=
 =?utf-8?B?ak52Y3NKdDNVNmlGVFlNd1pXTU1zY1g1blVrZnkzREJ5azhsbysyTjZTdHZs?=
 =?utf-8?B?UnV4K3F4U1ZrQzBkZXFPbzN5cU1MQU9vRGZ6bVVWc29RdmFLbE03cm9WNis2?=
 =?utf-8?B?WXJtVlJRbzkvRFFydmh6b3N6c0dzQmVQdmVSc1J2bFZyRVJIN1FDOC9hbE0r?=
 =?utf-8?Q?YDIUrDW36Xgs/vCnVdfYqq3m6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <94076ABA1BAF5749B1C03494761C2648@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6624.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4d6521d-b3ce-4be2-e984-08dc05ec93ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2023 08:28:03.1708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B8DShUI4MncEJv80PLp1OtylUYjoXiqDGW65i0sn0PsvoFJB/ptuf7JSUE1UlIkCj8kp/fH2V2vkix+q03o9Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6158
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--11.726700-8.000000
X-TMASE-MatchedRID: nVQUmLJJeyYOwH4pD14DsPHkpkyUphL9qQ9UezeTkThu4FknyqyshF1Q
	po5pNysMe29pTfBhqOY7b3Js3F6vVD1LciJB3541o65WJt1k1O8TbU1KYGoQp3vsbfoZixUT8Fh
	GjTp5WPdNWTyNFwAkqZEiauE3RX01vH9OmaDmUGO3D7EeeyZCM30tCKdnhB58pTwPRvSoXL2y5/
	tFZu9S3Ku6xVHLhqfxIAcCikR3vq+3bl/mfQl259accG603AhIeGV3Si1tGGeFIXQog1GYOUxpt
	b4Fw+10
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--11.726700-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	ED3A1A6D1040BA87A8D281F48D95DB6C69758ED78D6BB9BBE318587F314199E42000:8

SGksIEphc29uOg0KDQpPbiBGcmksIDIwMjMtMTItMjIgYXQgMTI6NTIgKzA4MDAsIEphc29uLUpI
LkxpbiB3cm90ZToNCj4gVG8gc3VwcG9ydCBzZWN1cmUgdmlkZW8gcGF0aCBmZWF0dXJlLCBHQ0Ug
aGF2ZSB0byByZWFkL3dyaXRlDQo+IHJlZ2lzdGdlcnMNCj4gaW4gdGhlIHNlY3VyZSB3b3JsZC4g
R0NFIHdpbGwgZW5hYmxlIHRoZSBzZWN1cmUgYWNjZXNzIHBlcm1pc3Npb24gdG8NCj4gdGhlDQo+
IEhXIHdobyB3YW50cyB0byBhY2Nlc3MgdGhlIHNlY3VyZSBjb250ZW50IGJ1ZmZlci4NCj4gDQo+
IEFkZCBDTURRIHNlY3VyZSBtYWlsYm94IGRyaXZlciB0byBtYWtlIENNRFEgY2xpZW50IHVzZXIg
aXMgYWJsZSB0bw0KPiBzZW5kaW5nIHRoZWlyIEhXIHNldHRpbmdzIHRvIHRoZSBzZWN1cmUgd29y
bGQuIFNvIHRoYXQgR0NFIGNhbg0KPiBleGVjdXRlDQo+IGFsbCBpbnN0cnVjdGlvbnMgdG8gY29u
ZmlndXJlIEhXIGluIHRoZSBzZWN1cmUgd29ybGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
bi1KSC5MaW4gPGphc29uLWpoLmxpbkBtZWRpYXRlay5jb20+DQo+IC0tLQ0KDQpbc25pcF0NCg0K
PiArDQo+ICtpbnQgY21kcV9zZWNfcGt0X3dyaXRlKHN0cnVjdCBjbWRxX3BrdCAqcGt0LCB1MzIg
YWRkciwgdTY0IGJhc2UsDQo+ICsJCSAgICAgICBjb25zdCBlbnVtIGNtZHFfaXdjX2FkZHJfbWV0
YWRhdGFfdHlwZSB0eXBlLA0KPiArCQkgICAgICAgY29uc3QgdTMyIG9mZnNldCwgY29uc3QgdTMy
IHNpemUsIGNvbnN0IHUzMg0KPiBwb3J0KQ0KPiArew0KPiArCWludCByZXQ7DQo+ICsNCj4gKwly
ZXQgPSBjbWRxX3BrdF9hc3NpZ24ocGt0LCBDTURRX1RIUl9TUFJfSURYMCwgYWRkcik7DQo+ICsJ
aWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldCA9IGNtZHFfcGt0X3dyaXRl
X3NfcmVnX3ZhbHVlKHBrdCwgQ01EUV9USFJfU1BSX0lEWDAsDQo+ICh1MzIpYmFzZSk7DQo+ICsJ
aWYgKHJldCkNCj4gKwkJcmV0dXJuIHJldDsNCj4gKw0KPiArCXJldHVybiBjbWRxX3NlY19hcHBl
bmRfbWV0YWRhdGEocGt0LCB0eXBlLCBiYXNlLCBvZmZzZXQsIHNpemUsDQo+IHBvcnQpOw0KDQpX
aHkgZG8geW91IGFwcGVuZCB0aGlzIG1ldGFkYXRhPyBJdCBsb29rcyBsaWtlIFRFRSB3b3VsZCB1
c2UgdGhpcyBtZXRhDQpkYXRhIHRvIGNoZWNrIGNvbW1hbmQgaXMgc2VjdXJlIG9yIG5vdC4gQnV0
IHRoaXMgbWV0YSBkYXRhIGlzIGluIG5vcm1hbA0Kd29ybGQsIHNvIGl0IG1heSBiZSBtb2RpZmll
ZCBieSBoYWNrZXIuIEkgdGhpbmsgVEVFIHNob3VsZCBjaGVjaw0KY29tbWFuZCBidWZmZXIgZGly
ZWN0bHkgbm90IGJ5IHRoZSBtZXRhIGRhdGEuDQoNClJlZ2FyZHMsDQpDSw0KDQo+ICt9DQo+ICtF
WFBPUlRfU1lNQk9MX0dQTChjbWRxX3NlY19wa3Rfd3JpdGUpOw0KPiArDQo=

