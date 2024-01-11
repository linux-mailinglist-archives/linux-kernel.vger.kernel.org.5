Return-Path: <linux-kernel+bounces-23888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2549282B33D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3653E1C26DB6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECA50278;
	Thu, 11 Jan 2024 16:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="femNaw1b"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CE950248;
	Thu, 11 Jan 2024 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3t8yfQ4ZHRFtSDDhl+qKnHk350yBOWrhKrlDgqx4fZXgHB+nlsbdluW5KvMrx/UY5mb0N9A4yt2VHiiegJe2tdGshm2+GK/DawXfM6xIhprq3QeF6aqXs7RqOTpaY/VhB7ihkDpz8jqFT5+ayFbF9T6qz5cQfr36ox9WRTeu8Z1fBrpv1XQNSgsQlvf9ikUjCq/9TV7fTiQTvz7nhF0WqZNpN7Ofz6ZqfRI/fBS0Z0arK5TEcMG6mgkfiDNUQOMjIGat9h2Q7zMiLO9NwFbQs04huZbR79XhEIsFuhZTF51g6FzKxSbe2UfKiSn16wFm8YK66g5S3SByacu/FHS1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JpjShV4jjcuPTYqdGLNXJx+bnhQnqh0n6mwl0BDF6w=;
 b=ofLsxJIKFsP/wBlJ0jBpcf344uArshPEdJ5cFoFbhIC4znbVwBaQBxbNqfP6DyoFFgl8qo8CsVxst2FQMNWDuJHQEt0dCM1oEA1cRuGmMiNMK67u+VVt/1+DoI3O64wGDzOI0mdooTML0xxKSs/S7MjV/DD8U/ImB8DykvCsSeUsWIaYh8uynYqnE6mx4og4zX+rBpgXPv/eYK5t23oV7XmUn8GeMPIgD/ZD1NL2ojMRZK4vl2J75M6SW6NpGElDQAKdiljM0PXXy7HjVpVp9btyj+n5LszUHFsf17Hu1b3ejRM51TtjtEMXmDQLBG2V8MZ5zpPqU3nSObpUBCpxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JpjShV4jjcuPTYqdGLNXJx+bnhQnqh0n6mwl0BDF6w=;
 b=femNaw1bJbiEbnjmgQfr6G/9HHK2UCQ17e0DotlSdXdvWQa51hHpiRfcc31j6oUuVPLAAM6CP1RTMrhogDXRDeV2yD9z9fGzS7+APXT4T3GvFbde3vFnkJHsBFrRKJiO7EpUueWalwMEKsRsNEuzqEAYeYVD+FvrH9ycj8jdN0Q=
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com (2603:10a6:10:103::23)
 by AS8PR06MB7862.eurprd06.prod.outlook.com (2603:10a6:20b:3c8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 16:45:27 +0000
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039]) by DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039%5]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 16:45:26 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Topic: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Index: AQHaRKoS6UQg1dt3TU+QGYO25gfEa7DUzvGAgAAC4gA=
Date: Thu, 11 Jan 2024 16:45:26 +0000
Message-ID: <a4af4a08-6eea-420b-b76f-47f4e836b476@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <c795aa28-b6a2-4db8-b941-05b51b44f1fe@lunn.ch>
In-Reply-To: <c795aa28-b6a2-4db8-b941-05b51b44f1fe@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6332:EE_|AS8PR06MB7862:EE_
x-ms-office365-filtering-correlation-id: 52eb0767-cd6a-484c-202e-08dc12c4b6bb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GwomvUtwNwsr3MFfGvaEr6izqEqhYJGOkSKLWYiL+qdLDVItcd6DVJZNE91hNh7eXxQnhOzkN0uL2vCrWeLj10xhMMnwe1+x/AKBujqUXWOsEdKx1XJA/cL0rLUzxVgus3i1ZY6Khb35K8A1EIsKcn+ynaQGQXDlXtZdmZ/JaVZ3cw9su2JDAcCrGK/PXen2F7Z/Xcb9ZYI++6nhKAuOKZsWvCnAA74paADPaRNEgTg8SofXd8nS5P18OVVHBXaL2jp1khgsnOKsoU5P4gptqxu2g6CL6IPQViqgECUOZr8Nl9fRFV40Gs2ViCaqNJxkmeMAngFgsoXnqVAsc/TX0+yO+CF/ZlUgKwIS3uceVbGaq4zvCVzyyO+PkJu6gzZQGKOABSP1Nan/RseyUuZQEyL7Rusbna+BhDsBB0lMIDEriWmitVEfkQ2sRd03j0JovkelELd2VjyHEs6ZpS1lOohtcIsMhl2CxqEk73wR0tjSKBFlAPl/91GYl17J/Ct3Q0wdzpsFhdX5wuEtJ/iCcJd3EsYHOeyqqWiN5aRVZJUpUMZicHI9DSZPUpBDKBB8wKd/qLxZk5NKaG5gjoCUcOF9+ZqdtMEmSBsps/ZQvGqqkejQ2X3xqiFOM9q9fylAAgXHduDCbI6cWzm9Ti4Ge4EsxlfEdeS7th/Cu21KqxXKV89CeE6PhNGIeCgyHtiLeWN7+zEC0oXPuDUDKaioleD0WrsLh+1AlkxUft8c7r0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6332.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(230373577357003)(230173577357003)(230473577357003)(230922051799003)(230273577357003)(186009)(1800799012)(451199024)(64100799003)(53546011)(6916009)(316002)(31686004)(54906003)(38100700002)(122000001)(5660300002)(6506007)(6512007)(66446008)(64756008)(66476007)(76116006)(107886003)(71200400001)(66556008)(2906002)(7416002)(66946007)(6486002)(966005)(8936002)(4326008)(8676002)(45080400002)(478600001)(2616005)(26005)(91956017)(41300700001)(31696002)(36756003)(86362001)(38070700009)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzJySEI2aEdNM0tpQ3NBUUFwMXpsdkl0UmFwc3FzZXRETFFya0VIQWx5Wmgy?=
 =?utf-8?B?bmdTa05aeGhTVWcyRFJibEpLdUkva1UzdjRHVGtGVjlnamtqSHJxaUhjZzQ5?=
 =?utf-8?B?TUpLM3I4cmx0ZjNpRjJuam9ETkJBQkRkUEsvakNGa1l5YUdrcURYZktaaGxo?=
 =?utf-8?B?OHpDUjYrZ3hLWStJSWlWNFJuMkdCVG9WdjZkQVI5dzNsOUcwS1B4MjVUc1lZ?=
 =?utf-8?B?ZzY3Z1cyb3ZWTFl0N3h3MTQ5cjFCeC9qQkUwYUJxajZEd3VvZEtIWlpmSThv?=
 =?utf-8?B?SHRLOEF4YXp6Y041d2E4QU96WU11emZCSTFwWElvUnVBSFlYc1hlNW5JQVVq?=
 =?utf-8?B?RlI1YVhROENDT2x6YXZWOTg4c1RuK2VZcmhOV1B5Uk05amVIaVZKZUpZY1li?=
 =?utf-8?B?c280RGlsUmJra3hwTThEeUV4VlhJb0c4YVo1UEp1b3h4aithTXl5a0w0Ly9L?=
 =?utf-8?B?Ykc0NVVGTXB5MU9NMFkybmlxVndBRExiQVEvQ2xwUlduTVNCcUoxYUhnRkpZ?=
 =?utf-8?B?bnMyVWgyc0NUeXJmS0xzd2xtT3NhWlMrdnQ5NWdmNXN4MlBxeVRxQUVuMUtl?=
 =?utf-8?B?QW5ldGUwTmpEa1NHZVFWRDhOZTB5TGpqa1FsR21aa3ZtVXFQa2I4MDJ6WUd3?=
 =?utf-8?B?cUhPN3k3bjUxWlViaDEya0piR1E3MXEycHRjcUw2Wno1aGdWWG8yWFpNSnB6?=
 =?utf-8?B?b055empjanYyZEpJR2ZVUzBEOU82YWRvNFZLbGJqam9GUFdhN0hKQktvemtw?=
 =?utf-8?B?bkEyMUJqaGdwRER5ejVvcDZEMGhJeXhFcnFadkIzVU4wUXYzRUZETWFDWUxX?=
 =?utf-8?B?YTNvYlZoWC90K3kvVXAwZWphc2NnYUUrQlFmK1MvTjdSckdyTUNoWmZHM1R6?=
 =?utf-8?B?c2NXemRFUGdoODN0TWwrMWVLMkhRdncrSXBsbHBhVGQ4OTBJWmN4TEdNWkFE?=
 =?utf-8?B?cG0yYUR2azErb29TSEEvaEZoWTNhc2ZuQkpuS0xRZmlVVGs4YnlmS1doQURU?=
 =?utf-8?B?dU51M3FJVXY5eVFoZFZiSFdWR1hXM0swM0ViQndxYlBjYk5oY2FtV0VvQlBG?=
 =?utf-8?B?NG5jZi9USy93TjNrMWVydTFZeFhMa1F4bFlmSDkxaGpEdXgvNWdKS1Nod1d3?=
 =?utf-8?B?UkVpUXdJZjFlVXpGY1laWUxpb095QktoeTBDdHp3UzY0LzJmZTd1WFRRN2Zo?=
 =?utf-8?B?U1d0SjVhVytXY0xqTnoxL3Uza1AvY3ZsMmVZdllLWWpteWVkcmJpS3NiOVdK?=
 =?utf-8?B?dHVGaHNxdEp2Yzcwby9ta1hWQWw0SjMyTDlRRkR0MGk2dDJUSVo0Vm13NFUx?=
 =?utf-8?B?cVJ5RGg5WmczbHErTFRuaGZMbEJXZUhxbEVTbUlUaDdIbnIyTGtXWHd4TkM4?=
 =?utf-8?B?QktObjBkNGJuN3VTcXJZdFlvNCtoVFVtOWpVbHd4Q0dGbVpWMmdwSjI3QzNX?=
 =?utf-8?B?K3QxSlZLVUxkcFhmaklyUitiN3VBd2d0UWVpSnpTMlFPZzhJdDVvc0VzYkxo?=
 =?utf-8?B?Rm5kdmZoSjJvR2IzdEM1aXdXNncwd2FjNng3VWYxdGo0blU1SndNUWdqbEFr?=
 =?utf-8?B?Mmt3NnFvUVJILzhVTjE5V1RoNWxSVDJyOVRRaEl3TmwybG1FT0RRRkxSUVNl?=
 =?utf-8?B?L0pSbUMyOXAvYzFLcjliT1hoVVpQanBnTFFyblk3Y3A0R2RhamVmL0FnQUs4?=
 =?utf-8?B?WEdNWUU5d29uSE5BNWFQZjZad3IvS2E4QmRpUW1XZW4yVVBtNFg5SEF5RWVX?=
 =?utf-8?B?Q0ZIR3hkdmozMG9kUUpuMHR1RnQ1TUtDZE5PZ1lxV0NSUlBNTXdRdENwL1A3?=
 =?utf-8?B?bW9lcFJPMldFdnppUkhPS3dyYVZKcUVkSVc0cmp0dzRQZkhMbkRRZ20rMkEy?=
 =?utf-8?B?NFp5akNyamtTVGVOK2I1RmZ6bWFGWTZZVFlVMUlINzYwODVKWGpyaHJ2YTU1?=
 =?utf-8?B?Ym1YUDl4Sk5lb01uVng3S0hLZVY0VW9tclhVdGJDM3M2SVVoakRwem9QQ3Mw?=
 =?utf-8?B?MHNnWHdhendBUGh3YXBmNllLL09BdWRsVmV3Y1hMVnk4aS84d2lGUEptQnND?=
 =?utf-8?B?ZkVxYXFQelpNbG9IcEJoTGJ4THVIbGl4NzkrWVA1c1hSOHdkTmFYU1RySkow?=
 =?utf-8?B?NUt5a2ttZjBQcXVwaUVwT2lOYXF3dDNYRFQrMmE5dDZhakhBVHp3NDM3alFM?=
 =?utf-8?B?bVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <55C86D06B8F04047ABDC3BC85CB54FCA@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR06MB6332.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52eb0767-cd6a-484c-202e-08dc12c4b6bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 16:45:26.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H4AQZtPqvVF4+3Ik0jq9+eM7Cy4X4vkkFHc4YpuTdHYthgiEKT3N4QsvES09R4D4ZWyfd/iFqZZO8SHEKTnVdioeTNc6PeGQXf8zUzzrptOYpsgbHVey7KtmaioUXNbz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7862

T24gMTEuMDEuMjQgMTc6MzUsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBbWW91IGRvbid0IG9mdGVu
IGdldCBlbWFpbCBmcm9tIGFuZHJld0BsdW5uLmNoLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRh
bnQgYXQgaHR0cHM6Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4N
Cj4gVGhpcyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNl
LiBQbGVhc2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2ht
ZW50cywgb3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4gT24gVGh1LCBKYW4gMTEs
IDIwMjQgYXQgMDU6MTk6MjVQTSArMDEwMCwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4gQWRk
IHByb3BlcnR5IHRpLGNmZy1kYWMtbWludXMgdG8gYWxsb3cgZm9yIHZvbHRhZ2UgdHVuaW5nDQo+
PiBvZiBsb2dpY2FsIGxldmVsIC0xIG9mIHRoZSBNTFQtMyBlbmNvZGVkIGRhdGEuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBvcGVzY3VAbGVpY2EtZ2Vv
c3lzdGVtcy5jb20+DQo+PiAtLS0NCj4+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL25ldC90aSxkcDgzODIyLnlhbWwgfCA5ICsrKysrKysrKw0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgOSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9uZXQvdGksZHA4MzgyMi55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4+IGluZGV4IGRiNzQ0NzQyMDdl
ZC4uMmYwMTAzMzNiZTQ5IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9uZXQvdGksZHA4MzgyMi55YW1sDQo+PiBAQCAtNjIsNiArNjIsMTUg
QEAgcHJvcGVydGllczoNCj4+ICAgICAgICAgIGZvciB0aGUgUEhZLiAgVGhlIGludGVybmFsIGRl
bGF5IGZvciB0aGUgUEhZIGlzIGZpeGVkIHRvIDMuNW5zIHJlbGF0aXZlDQo+PiAgICAgICAgICB0
byB0cmFuc21pdCBkYXRhLg0KPj4NCj4+ICsgIHRpLGNmZy1kYWMtbWludXM6DQo+PiArICAgIGRl
c2NyaXB0aW9uOiB8DQo+PiArICAgICAgIERQODM4MjYgUEhZIG9ubHkuDQo+PiArICAgICAgIFNl
dHMgdGhlIHZvbHRhZ2UgcmF0aW8gb2YgdGhlIGxvZ2ljYWwgbGV2ZWwgLTEgZm9yIHRoZSBNTFQt
MyBlbmNvZGVkIGRhdGEuDQo+PiArICAgICAgIDAgPSA1MCUsIDEgPSA1Ni4yNSUsIDIgPSA2Mi41
MCUsIDMgPSA2OC43NSUsIDQgPSA3NSUsIDUgPSA4MS4yNSUsIDYgPSA4Ny41MCUsDQo+PiArICAg
ICAgIDcgPSA5My43NSUsIDggPSAxMDAlLCA5ID0gMTA2LjI1JSwgMTAgPSAxMTIuNTAlLCAxMSA9
IDExOC43NSUsIDEyID0gMTI1JSwNCj4+ICsgICAgICAgMTMgPSAxMzEuMjUlLCAxNCA9IDEzNy41
MCUsIDE1ID0gMTQzLjc1JSwgMTYgPSAxNTAlLg0KPj4gKyAgICBlbnVtOiBbMCwgMSwgMiwgMywg
NCwgNSwgNiwgNywgOCwgOSwgMTAsIDExLCAxMiwgMTMsIDE0LCAxNSwgMTZdDQo+IFdlIHRyeSB0
byBhdm9pZCByZWdpc3RlciB2YWx1ZXMgaW4gRFQuIFdlIHVzZSByZWFsIHVuaXRzLiBUaGlzIGlz
IGENCj4gdm9sdGFnZSB5b3UgYXJlIGNvbmZpZ3VyaW5nLCBzbyBjYW4geW91IGNoYW5nZSB0aGUg
dW5pdCB0byBtaWxsaXZvbHRzPw0KPiBIYXZlIHRoZSBkcml2ZXIgZG8gdGhlIGNvbnZlcnNpb24g
b2Ygdm9sdHMgdG8gcmVnaXN0ZXIgdmFsdWUuDQo+DQo+IElzIGl0IHBvc3NpYmxlIHRvIGNvbmZp
Z3VyZSBhbnkgb2YgdGhlIG90aGVyIGxvZ2ljYWwgbGV2ZWxzPw0KDQpIaSBBbmRyZXcsDQpUaGVz
ZSBhcmUgbm90IHJhdyByZWdpc3RlciB2YWx1ZXMgYW5kIHRoZXNlIGFyZSBub3Qgdm9sdGFnZSB2
YWx1ZXMgYnV0IA0Kdm9sdGFnZSByYXRpb3MuIEknbSBtYXBwaW5nIHRoZSB2b2x0YWdlIHJhdGlv
cyB0byBlbnVtIHZhbHVlcyBbMC0xNl0gDQp3aGljaCBhcmUgY29udmVydGVkIHRvIHJlZ2lzdGVy
IHJhdyB2YWx1ZXMgYnkgdGhlIGRyaXZlci4gSSBkb24ndCBzZWUgYSANCmJldHRlciB3YXkgdG8g
ZG8gdGhpcy4NCg0KPiAgICAgIEFuZHJldw0KPg0KPiAtLS0NCj4gcHctYm90OiBjcg0KDQoNCg==

