Return-Path: <linux-kernel+bounces-23906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863BA82B382
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1371C25F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D126854BC1;
	Thu, 11 Jan 2024 16:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="UwsrgpME"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2134.outbound.protection.outlook.com [40.107.7.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A02153E37;
	Thu, 11 Jan 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DeJf4yrdyoFXcAWuG/Uz9NxNSaRusFMER0uQaLDjd/bO3yLh+JkAYiMAzyaXUL/i08WfPFHsb1LmQ9lJe92rY/21ngQQMC6f9RSYD0yMsg3XeEgKMygZUew0kzKEwstxnQ2GFOEl12bu+idSjux6L5j8Z7yka7VBWdo+mfYduQNb9QTtJcSdyQUgqyqLcs1USfVF8hcIESKw1Na3rUxkQymy5RF80K36G+dM71Uqafr+T8D7mWXfkpZMY4K9ZTeL4znnnARGxwMhxmwaygjVBoqadL337MbwOW6G3SwqQwTGJrWjoEiIP0rC8JafcFO2bqhVRuy29biI9FA6xOuOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u7jOCp+77SIEY3uHVjM7WRVe5RLbbfbxHfoUd8RwIKM=;
 b=J/U7mi8FM7sgTIgLFlmmd2XWLbcowEbhBQ/wSn6dpxH5OYpQmHDvGByhVqF0FWdGoe3emallTnkQlTUBZnfTJeKn+rk8j3etptv5UBhA6WkQQt/3HZ5w4j+AWSFNbOKAajnFnXD0Iy0OmhbV4RESpe1qrkzZkkhQUKDAVv5PYKsE7AM9Ei5wvrMlCsRtCGvTfzFuPPcQDh37atbMpry2xDN+1i1Aemn8aQwhYJzanW7kd8/jNlHIX8UgvdLR/IxnPNMXJ+Bic3JoSdGBEaYKrCJ7mHoZTECAeZzME2g9r+cqfXvM2L1CnNJdhB14/sfnMobmVS3bUWcT1WaOPtKt6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7jOCp+77SIEY3uHVjM7WRVe5RLbbfbxHfoUd8RwIKM=;
 b=UwsrgpMEmiameQ3Wn4WoFd3xoKeiNKzo0vZ1wqbPeo52kqMcAyImA9Bxs1ADePdHzIdEMXNQ2ZTh/9CkcONMDjMLwj4eqp89A3uvSRxisQZjSsl/5jY/ZphMecG2V+oqP3m1qslYLD2LyvZMYq7vHaWUtT58jHgK0UEYPAd+E20=
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com (2603:10a6:10:103::23)
 by AS8PR06MB7480.eurprd06.prod.outlook.com (2603:10a6:20b:332::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 16:59:06 +0000
Received: from DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039]) by DB8PR06MB6332.eurprd06.prod.outlook.com
 ([fe80::2ef6:99ac:4fcc:7039%5]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 16:59:06 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Topic: [PATCH 1/3] dt-bindings: net: dp83826: add ti,cfg-dac-minus
 binding
Thread-Index: AQHaRKoS6UQg1dt3TU+QGYO25gfEa7DUzvGAgAAC4gCAAAHngIAAAemA
Date: Thu, 11 Jan 2024 16:59:06 +0000
Message-ID: <c5b4613a-261d-429b-b59c-c264bc53e315@leica-geosystems.com>
References: <20240111161927.3689084-1-catalin.popescu@leica-geosystems.com>
 <c795aa28-b6a2-4db8-b941-05b51b44f1fe@lunn.ch>
 <a4af4a08-6eea-420b-b76f-47f4e836b476@leica-geosystems.com>
 <ZaAcvwWbNmSpw/xt@shell.armlinux.org.uk>
In-Reply-To: <ZaAcvwWbNmSpw/xt@shell.armlinux.org.uk>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB8PR06MB6332:EE_|AS8PR06MB7480:EE_
x-ms-office365-filtering-correlation-id: 24e91041-6e64-4d95-6dad-08dc12c69f4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 B5Ux1PHKVnwsW19nMN/VFNN3UYiuXkotRHMdTBF9W6uecsEShFhcBTt0NFY2WSGGFwUty5vWWdgfCM5HhCJ3F43yCG4EqmiOkN2KqzlwzSM/C8h923I3pTlCCSfg3oVHRHALzoZzoxLIhfuhcqWozo0W+wePUsWyg6Ho41gLh7cgYnu+XI4/AhhY/6zYDqaZJmuiYLQZ03jZiVZU71yMfFv+v081v3+DDcO8CjA0CrY86EOwNeGVRhoLMYOwItO+/bUzO9gSL4zw+ci29BXpf+2cKNh7Gm/iwTjzEPE9GD8XhGlldlr5TK+GgJcPx2N1HgrwQDYZXPzD091cvTLxujjV0l+mUCFQhx5tRgGzA/E4XKjIefAqu+AsMpK4VRbJ6EHu1ogO+Ao8/UoDDGwGAGFRcWSmiWLmAeI5RsMrdx6lebxO/Dg9uLwgEAnRvuZUL6pB6yQuOky2accqhaPQMKmGS+a0u8/4VYU7RzBxdWCbBjQ7PMPdspvKbmwH1k9G35FKNeGpcfaqdqqPfysve5xOBhKGLL5W0TJwNVWH9Uw117KikiMAvCuHNEqle3BLHcfKA103ZaQV854TUHEDRQE+XnLX35EDEvAERxFdRJGJMsS0eAaC7auA0C2BBvfz6MQi18GsdoZ/tEmEPHATz/Du8Hy5J9MkiJkoaCIO0oPd2fHlSZmBB0e3u2VM60qzDWtrYHLdtktjMtexo2NMRAPmWWUsmwaheh+JPRfYWK8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR06MB6332.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(230473577357003)(230273577357003)(230373577357003)(230173577357003)(1800799012)(186009)(64100799003)(451199024)(36756003)(38070700009)(31686004)(86362001)(31696002)(122000001)(76116006)(107886003)(26005)(45080400002)(478600001)(966005)(2616005)(71200400001)(38100700002)(91956017)(6486002)(53546011)(6506007)(6512007)(4326008)(64756008)(66476007)(316002)(6916009)(66446008)(66556008)(66946007)(2906002)(54906003)(5660300002)(8676002)(7416002)(8936002)(41300700001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmZ0UldyUGgvaVBOWXBlUU9wU0todHAwd21JaVBBQXJSNXU4c3MvSkdyYncx?=
 =?utf-8?B?Y2lWMTNqaDlrZENKRXFZL0c2a3hPUU1TNnpxbXJGdExWT1ptSDRSMys1VzlT?=
 =?utf-8?B?Y3ErN2RjNmVWSEMvZ2ZEN2FKK0t1OGVORWVENzk3KzQrdllOcER4ZE9PTm5v?=
 =?utf-8?B?WCtnemtrNWh1MXlrRHFZTXFHcU00ZzJOYU1ja05GekVGMkV6QitZeElqT0M0?=
 =?utf-8?B?RzZ2NW0wM1crTkkvUXVRa2cxVnFEZjk1dTBya2tDeDBOZUdoMlU2b1hsaXY3?=
 =?utf-8?B?N0JERmM2QXVpQVNGRDB3ZStzaXVPdEY5b2Y3WFpPS011U09uMklLdTBTamEv?=
 =?utf-8?B?U3RTNmdrdStOaWpaZkhOTVZWSUZoUm14ZDFHaGZWNld4bDcyY2JnakZVakNa?=
 =?utf-8?B?a2ZlWXZJOUpSS21EV0QyMEsxV295cy9MeWxQVjJpdXpZa1ZieDdtKzZLaGx2?=
 =?utf-8?B?RDBTRTcwMSsxM0R6eFVDai9nUTJ5d1QyNmUyRGRsZjB0Vk42MHAyNnY1c1Vy?=
 =?utf-8?B?cmEyRG5icmJ6RXVkVHVmQzg3WjFQNFlRb1RqTkhDQUdDcHFBbGJjMEZ6RmpT?=
 =?utf-8?B?NmdVemtTU1BQbWhqeG5jQVEzbjZVbGJkM2RrT01XZGVuYzUvZmdvZjhXZ0RE?=
 =?utf-8?B?Tk04b0NKdWNNYTJsdDdaa2hNY2pBeFNjeTF1ZVowTDZDWGF3azJlUnZQQTVN?=
 =?utf-8?B?anhNb253dFY4UjNYdUdoKzlXVE5DYndnWWJrNzRDZVVwaHl1bWRlNkxndjUr?=
 =?utf-8?B?MXVwZ1k5bzVGdVpNRFEzdFpJeFpHMDNMUjFWc2pkUnkvRW56c2xEcDJteWhE?=
 =?utf-8?B?bUFpeUdzSVFpUGxDdHFveDFSWWs3Wm5FY2ppb1hrdS9FdlFVeWtCOGlrbUVZ?=
 =?utf-8?B?YzV1ZUhRUm1tRHlZcGdpcU5kdHltcDZGYkRSWE1tVU1EUWphVW9jRll2TE1C?=
 =?utf-8?B?V0ZjQzFTZnJWNnE2YktZMWFYZ0hjN0EwRU5aS0VaaXBkT3IvWVN2RGR6V3JZ?=
 =?utf-8?B?WldUbGJFcFNpRzhYQ0ZoRjlZMkpuRkR1TWZrdFVsdzIxcnlhSVV4bW1UN1kv?=
 =?utf-8?B?eDNBY1hnRjRyQzNGUlY5ZWZiVWhyeXNNd2ErT0lFUTJ6MjVaaFVwZ21PeEI1?=
 =?utf-8?B?RXNkbWdwZjNoWTZBSU9iczBqaUZKMjNJdXVQekJNKzRzSzFyRVdPNVNJbi9n?=
 =?utf-8?B?YVNzVjlFdFdLaUY2KzJYV3l2cmZPbWVYMjJqbTdqSmFDM25kM1VoNVFaWmlZ?=
 =?utf-8?B?ZG5pYTQ5bHlNUDdOTTgwVWJsalYxMlhUUWxSTTJtRFZuS3dOMSttaG1iYnox?=
 =?utf-8?B?U0FDMzlYNUltYnpvYk5iYTFhSTl4Um9mWWxIemliYllUaTVRZWVTc2Z1aDNT?=
 =?utf-8?B?YkRwQlFrWUJlVWEybGNodzZvbjNDcFhVb3VrV3dnUDdLTXJqVHpLRzZhd3FH?=
 =?utf-8?B?aUQxdm93Znc2YjZuV1VndlJYaGlPcWN5M0VtQ2o5ZFRyYmthZnJqcVBFRGNl?=
 =?utf-8?B?bWhnWnNaWGpUTTRISEJEd2VmZUFPNHZzTUprM0hYd3FXUzBBQ1FmN0xjRjNL?=
 =?utf-8?B?VUIvTzZNUXNXTWt2d2lsMkE2RzVyd1BvRTVBOTNZS0psTjF0VytLalJ1NHl2?=
 =?utf-8?B?TmFoL2wzRjNja3Z2RG9FNEg1VkZlUHRoTlhxZ0kwSHFvd0JDTlIvK0RTdVhR?=
 =?utf-8?B?MnVTOUM2SW5sTW1OZW4xZjMzNTlOc1hrcE5kSFNDOVlIaytESm1FMk16cDMy?=
 =?utf-8?B?M3VQZGwvY2x2UHlnNzdJSm8zM0NQVHlUR1JGQWdBMHhEVExodVgrREM0NkJk?=
 =?utf-8?B?cENzSkVMd0VWMTJZMGJLbUdxdGRnMXJTdnlac1djTll5QUlOYnVHbXV1VWpL?=
 =?utf-8?B?RXlFOFB4RG5CUGFnOUJWSGlJRzlJWGIwcFlvdU1DRW5YdnhqQmZPcGcxcGsz?=
 =?utf-8?B?U2RmTitOUU1XWXpmdlVhNjR0QmxUT0pVZXN6RHY2N2tGcWh5dnd3K285QklN?=
 =?utf-8?B?eXZ5MWJWd1FhUWJ1b1N3d0wxRmNnQ01NSDZYdWN3Mmo3V0ZVTmljN0pzYnlF?=
 =?utf-8?B?azN0anpGM0VWLzZKV1B1UmhwcnZqZ2dSU2xtNW9Xem1ubnJRSTd0NmpOQ1pE?=
 =?utf-8?B?a1RldktmQm9Jc28xbklEMG9TVW1OT1Z4aE02cDRFYXFSSVQ4eEtXNW9nT1F6?=
 =?utf-8?B?Ymc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D858B390801F824A8E57720D1EB74A2F@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e91041-6e64-4d95-6dad-08dc12c69f4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 16:59:06.4539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+ihsXV+Le0Bo4kai8QG59V7r9QqAS8L30tws/w/TvPLdrSBTD5JcJZJsTFHesSBTVC9Aq4zJ9Fo+B1XdJtPsDZpV5LYeMzrd9fYYpX+CSxmxLKmnBUaoFLmq06BIq7B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7480

T24gMTEuMDEuMjQgMTc6NTIsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSB3cm90ZToNCj4gVGhpcyBl
bWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2Ug
YmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3Ig
cmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4NCj4NCj4gT24gVGh1LCBKYW4gMTEsIDIwMjQgYXQg
MDQ6NDU6MjZQTSArMDAwMCwgUE9QRVNDVSBDYXRhbGluIHdyb3RlOg0KPj4gT24gMTEuMDEuMjQg
MTc6MzUsIEFuZHJldyBMdW5uIHdyb3RlOg0KPj4+IFtZb3UgZG9uJ3Qgb2Z0ZW4gZ2V0IGVtYWls
IGZyb20gYW5kcmV3QGx1bm4uY2guIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRw
czovL2FrYS5tcy9MZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPj4+DQo+Pj4gVGhp
cyBlbWFpbCBpcyBub3QgZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVh
c2UgYmUgY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywg
b3IgcmVwbHlpbmcgdG8gdGhpcyBlbWFpbC4NCj4+Pg0KPj4+DQo+Pj4gT24gVGh1LCBKYW4gMTEs
IDIwMjQgYXQgMDU6MTk6MjVQTSArMDEwMCwgQ2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4+PiBB
ZGQgcHJvcGVydHkgdGksY2ZnLWRhYy1taW51cyB0byBhbGxvdyBmb3Igdm9sdGFnZSB0dW5pbmcN
Cj4+Pj4gb2YgbG9naWNhbCBsZXZlbCAtMSBvZiB0aGUgTUxULTMgZW5jb2RlZCBkYXRhLg0KPj4+
Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDYXRhbGluIFBvcGVzY3UgPGNhdGFsaW4ucG9wZXNjdUBs
ZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9uZXQvdGksZHA4MzgyMi55YW1sIHwgOSArKysrKysrKysNCj4+Pj4g
ICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L3RpLGRwODM4MjIueWFtbA0K
Pj4+PiBpbmRleCBkYjc0NDc0MjA3ZWQuLjJmMDEwMzMzYmU0OSAxMDA2NDQNCj4+Pj4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIyLnlhbWwNCj4+
Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC90aSxkcDgzODIy
LnlhbWwNCj4+Pj4gQEAgLTYyLDYgKzYyLDE1IEBAIHByb3BlcnRpZXM6DQo+Pj4+ICAgICAgICAg
ICBmb3IgdGhlIFBIWS4gIFRoZSBpbnRlcm5hbCBkZWxheSBmb3IgdGhlIFBIWSBpcyBmaXhlZCB0
byAzLjVucyByZWxhdGl2ZQ0KPj4+PiAgICAgICAgICAgdG8gdHJhbnNtaXQgZGF0YS4NCj4+Pj4N
Cj4+Pj4gKyAgdGksY2ZnLWRhYy1taW51czoNCj4+Pj4gKyAgICBkZXNjcmlwdGlvbjogfA0KPj4+
PiArICAgICAgIERQODM4MjYgUEhZIG9ubHkuDQo+Pj4+ICsgICAgICAgU2V0cyB0aGUgdm9sdGFn
ZSByYXRpbyBvZiB0aGUgbG9naWNhbCBsZXZlbCAtMSBmb3IgdGhlIE1MVC0zIGVuY29kZWQgZGF0
YS4NCj4+Pj4gKyAgICAgICAwID0gNTAlLCAxID0gNTYuMjUlLCAyID0gNjIuNTAlLCAzID0gNjgu
NzUlLCA0ID0gNzUlLCA1ID0gODEuMjUlLCA2ID0gODcuNTAlLA0KPj4+PiArICAgICAgIDcgPSA5
My43NSUsIDggPSAxMDAlLCA5ID0gMTA2LjI1JSwgMTAgPSAxMTIuNTAlLCAxMSA9IDExOC43NSUs
IDEyID0gMTI1JSwNCj4+Pj4gKyAgICAgICAxMyA9IDEzMS4yNSUsIDE0ID0gMTM3LjUwJSwgMTUg
PSAxNDMuNzUlLCAxNiA9IDE1MCUuDQo+Pj4+ICsgICAgZW51bTogWzAsIDEsIDIsIDMsIDQsIDUs
IDYsIDcsIDgsIDksIDEwLCAxMSwgMTIsIDEzLCAxNCwgMTUsIDE2XQ0KPj4+IFdlIHRyeSB0byBh
dm9pZCByZWdpc3RlciB2YWx1ZXMgaW4gRFQuIFdlIHVzZSByZWFsIHVuaXRzLiBUaGlzIGlzIGEN
Cj4+PiB2b2x0YWdlIHlvdSBhcmUgY29uZmlndXJpbmcsIHNvIGNhbiB5b3UgY2hhbmdlIHRoZSB1
bml0IHRvIG1pbGxpdm9sdHM/DQo+Pj4gSGF2ZSB0aGUgZHJpdmVyIGRvIHRoZSBjb252ZXJzaW9u
IG9mIHZvbHRzIHRvIHJlZ2lzdGVyIHZhbHVlLg0KPj4+DQo+Pj4gSXMgaXQgcG9zc2libGUgdG8g
Y29uZmlndXJlIGFueSBvZiB0aGUgb3RoZXIgbG9naWNhbCBsZXZlbHM/DQo+PiBIaSBBbmRyZXcs
DQo+PiBUaGVzZSBhcmUgbm90IHJhdyByZWdpc3RlciB2YWx1ZXMgYW5kIHRoZXNlIGFyZSBub3Qg
dm9sdGFnZSB2YWx1ZXMgYnV0DQo+PiB2b2x0YWdlIHJhdGlvcy4gSSdtIG1hcHBpbmcgdGhlIHZv
bHRhZ2UgcmF0aW9zIHRvIGVudW0gdmFsdWVzIFswLTE2XQ0KPj4gd2hpY2ggYXJlIGNvbnZlcnRl
ZCB0byByZWdpc3RlciByYXcgdmFsdWVzIGJ5IHRoZSBkcml2ZXIuIEkgZG9uJ3Qgc2VlIGENCj4+
IGJldHRlciB3YXkgdG8gZG8gdGhpcy4NCj4gICAgICAgICAgZW51bTogWyA1MDAwLCA1NjI1LCA2
MjUwLCA2ODc1LCA3NTAwLCA4MTI1LCA4NzUwLCA5Mzc1LCAxMDAwMCwNCj4gICAgICAgICAgICAg
ICAgICAxMDYyNSwgMTEyNTAsIDExODc1LCAxMjUwMCAxMzEyNSwgMTM3NTAsIDE0Mzc1LCAxNTAw
MCBdDQo+DQo+ID8NCkknbSBva2F5IHdpdGggdGhhdCBhcHByb2FjaCBpZiB0aGVyZSdzIG5vIGJl
dHRlciBvbmUuIEkgd291bGQgbmVlZCB0bw0KcmVtb3ZlIHRoZSByZWdpc3RlciByYXcgdmFsdWVz
IHRhYmxlcyBmcm9tIHRoZSBkcml2ZXIgYW5kIHVzZSBhIHN3aXRjaA0Kc3RhdGVtZW50IHRvIG1h
cCB0aG9zZSB2YWx1ZXMgdG8gcmF3IHZhbHVlcy4NCj4NCj4gLS0NCj4gUk1LJ3MgUGF0Y2ggc3lz
dGVtOiBodHRwczovL3d3dy5hcm1saW51eC5vcmcudWsvZGV2ZWxvcGVyL3BhdGNoZXMvDQo+IEZU
VFAgaXMgaGVyZSEgODBNYnBzIGRvd24gMTBNYnBzIHVwLiBEZWNlbnQgY29ubmVjdGl2aXR5IGF0
IGxhc3QhDQoNCg0K

