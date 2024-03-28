Return-Path: <linux-kernel+bounces-122698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 669BE88FB98
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B94229A29F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34595FBB5;
	Thu, 28 Mar 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="R8lxLZ+x"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2116.outbound.protection.outlook.com [40.107.104.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AB5657B0;
	Thu, 28 Mar 2024 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618408; cv=fail; b=VQpp4PNVhy9vLuDpAmmDS6IoOHar4q4g/j5VPh/RNd30QwZyrBDGZWDnww5VvcMNEkYVvgw5BV8kFygsj/v6LuZsEAgE7naHLwh3+Pl03seLi8ZwLnJJD/zd5VkHtlI/nLDDZsZcpxKfPbC2pimG4/i660swliow3uXQgxwwF8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618408; c=relaxed/simple;
	bh=t9ORsLOs1gt63qM80R9rrSr+XQt5mHiVAxOu92ecNPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cRq2EzGQhtL3GscIfkXWuMo+LSURTDR1JfgjW8cVwfbp03vU38zKZm4sgiTH4io2RYI8qypF6A8qHTB/ZRHiNvBK3zgF+kdftwhlYnYm7FVFd+gisUubIUKF7W9Y9iGt7gu3gRZBMmNLlVYhOHvLz1qGV8UZHJXlPDK+ajJqJcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=R8lxLZ+x; arc=fail smtp.client-ip=40.107.104.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mc38q5Fk8N2Jg8nQczhNhcPEFFGOsixHtoVwRxNBTrg6ThTU9nnCB1g+5qg5eu7jCg2mgXry7pPrGNK3MSpSllI0Z1BXXzUM1XKgzxcnmN4HjzQtRhfmNlmeE0JR7O7HSzdaoy+DEe8eXKXhfRAaz1LSvNnz6gDIou1nCzv2NWTiR0M+qSpAUhyZegDtpbohuzOxneoafBbM3ksaVC7SmrvUrBmKjl2r0prj6LtDqnnIcwW3EQEv31bofWQjWznyBvR7RJ+RcA9IvHAFdphHm6aRKsoChdgxUgzzCzO4AYuhjZdyd+Y0WYKQbExIhdmLJvtrOmUflLoq+qRAuIFZhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9ORsLOs1gt63qM80R9rrSr+XQt5mHiVAxOu92ecNPQ=;
 b=TpxBA976jYTMyBPGxPrbO6jmxlm6WjJXBm3yOFATZIKLxUfgQIPBnJJupIXsWhbBk786gmu7Anc+yF2FLQDrXFJWW6IPSbZaBC6tTQ0e0P+o6mwnZgZUXGZg1ffENPlDkNYNJjmXOR7ah6kLoqZSc7To1B9ZyKD1D2Wcoxa1lH59Dfsn9+rXcoNxdv+ap/a7lGkA9XhpJkMOeu9BNuOxg+z9JltUAGuY6LTwbXRM7lLnZrUKZXaRtV8872iqy99PqPDhqvZKusUZGCApHJ7DlPYGfZAQttU0LIrOpQMk7ccaSPvYRxJ2NFh9Lp/MbIcjWEHGjjz9UmkWM8WYQDVjAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9ORsLOs1gt63qM80R9rrSr+XQt5mHiVAxOu92ecNPQ=;
 b=R8lxLZ+x/ny49G3DPQpKUhL1gzAfdGSAIJm22+htERXYXEY8BOLDiAZRVZ0uV/aFRFq11QkK46q3uJdivkUOX3bXplo1Q/R17kc3k1ymj5iNmJvqkDIEy3uOOW6a6WlZTDDDlpBDrzdME392six5Q85ItCjNXrxz8om9lDp6Em0=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB9125.eurprd04.prod.outlook.com (2603:10a6:20b:448::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:33:23 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:33:23 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
	<andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Topic: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Index:
 AQHae9lZw/gIYk6zDE+73DiBF+lb+bFDiiAAgAVVLYCAAAp+AIAAr8GAgADVrQCAAPl+AIAACiwAgAF2C4CAAAVTgA==
Date: Thu, 28 Mar 2024 09:33:23 +0000
Message-ID: <5ea0feb4-4d7e-4a10-9254-b034e368e8ad@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
 <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
 <e1836cb6-64cd-4866-9c0a-f0dda096aa18@linaro.org>
 <6a6e7c4d-d5fd-42ae-bc3d-a3978d65e8e4@solid-run.com>
 <b086a02c-624f-4225-a9fb-164095742ce9@linaro.org>
 <6af08a38-5239-4f5f-9e87-108e3400a6e6@solid-run.com>
 <62242f04-c18d-4da0-bd40-1be26886e41a@linaro.org>
 <1153cdd4-ed86-4a1f-ae4d-d9da1161f763@solid-run.com>
 <539eaf79-cff5-4bb7-84c8-7c9943c6d8ae@linaro.org>
In-Reply-To: <539eaf79-cff5-4bb7-84c8-7c9943c6d8ae@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB9125:EE_
x-ms-office365-filtering-correlation-id: b8e2bfc6-cb5c-4cf1-f43b-08dc4f0a1cf5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 d0cRBneDB6TJRkzVhA+993k7QuXWYNsjX75nCtThX6FtsNsOQa3hdjd2a/mwZ4smZL4PL8uHS1kHDV1nl/Ferjf5e4jC8bxdy2YJ27jIkKjUPKluyDiuiV4TfKxTq38ry6aUH0N8MyUlmg8+vv5Ihdjjk68Pn0u2gfyRahTjNs40Er0g4PVAWbfX6V/t+oIajlEmhjsZy8qowd009JY2s0CbsSkbpJE14ywmxttrurWbKwbaS0WsatvnPQQVE3TiEdOiunuafggwUmQ4NFgKkJ3DHeCznqJF1N6K104QZbtWl346i2mSGtob0UICZ8FObhGKLf06K4/wu3AQDVDgZKXDZMue76rCJCGro582GOTqGJeSNhbOdjP80Fg1sMRjAuubAAlHtGGQi79CEI29mG1MjK/AgfNvuRixxCosGur9448sdFOeB2vvLGBJ61amgINFo2Ur7DI0DncCe/YZySZVaqXzKvzPWe6FVH5JVPkJGMBwxGERecRRHZSOwyWzIHO+ebjoD/6CbCmsSPVDbuXf/kIrr4oZf1omEUy7rGsnhb/O9nyvHeN84ivlPNjl9Z6smcpSIBQUuahmoj20P4oqLmNWOqkoDlTR/4V1y/XYQJNm5wLAVnG5Thu5dTXEX8MZK3j5oe6iSK55LkHTgMw7SM2zWGMEl7ci4B3Zj6kKREnjbAQ79jAwoGJ9eS08QOlkUr6DPqBrq2jpn2f5IgvjCb1n/vBnhhScneVdthQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R09nbmVPdGRhU0pvK25FUm9RSWF1bUpCcFRCNk9TdHFRN3BuTGR2bXY2ZmFB?=
 =?utf-8?B?Z0FwT2tkdmxTMlNMeS9FL1lyMmx5S2pCaVJQMURhNStPY1Jkb2ZlRDVYY1JF?=
 =?utf-8?B?amlMbDhEd2dWSjNjdVczb3RUVi81QWRFOWJLUnlIWEQ5WVNYQXdQcGF1VVRt?=
 =?utf-8?B?ZzRVeGlwRE92UDl6ZGVPLzdtSERWNUV5ZmVXRi82UjFwN1JBbWNuODlmYTJk?=
 =?utf-8?B?VitGVm1EVEZZTTh3UTdrR2lKY2xIQzlSbGc5L2l3RXNWaXFHT1FZUzFqMGdi?=
 =?utf-8?B?S3FSQ0RRaEdYYUhyaTRuWWZadVpCaVlsOGpONlJFTFlPQTRBWlBYbTZEQThU?=
 =?utf-8?B?WDZodWMzRG1qMENwZjg4U1ZuN0R0eXNWSy9rNDBKT1NLcGFETFMxdmN0anpt?=
 =?utf-8?B?T25ZUHIybk81MjVmN0dXUE9nTUtnL3J3dCt5cVZWN2pxRnlkRUxJWTVNdUor?=
 =?utf-8?B?cWY4aDRtWUErRUxnVDkwYXJXY2hTMWJ1M2JxYnhhRlRXbUdtdkEyQTVTcFRG?=
 =?utf-8?B?RmpwcVZKVEltS3dxdXdkZ2h5RlMvRkdPWm8relpCOE02Y1pHN2RWK2h0Smhy?=
 =?utf-8?B?UmhMNnZjSDIwUUxJTHJwWXZHVGt3Q0xldEQ3TEF6Vm5tY0hjQ3dxTHkycThD?=
 =?utf-8?B?ZjJQbWFEMWt2Tk51MWdXZ1dobUl5a3Z2dDBFKzJtR1B1eThVYm1nKzRrZlBx?=
 =?utf-8?B?VkY1TFBLTWRtakpwR3JBbktOelRkaHpnUkJwNjR2cjhJd1c0aXQyOS9CdjhL?=
 =?utf-8?B?VVFoOTArVlVGTzlJTnJXNk5XMTF4ZFFETkMxMFkwYzlqaTNJeEsrSG1VQ0hh?=
 =?utf-8?B?SXRJRC9rNjlONDlnZDlBbCtoRTYyZDEwalFuOEh1Z2NDSnZSVWd6UllaT3Yr?=
 =?utf-8?B?dDFXQ1Yxcnl6YmwwWUpIUHNEa1U4U0VkRkZQbkRnL2h1U3JSK3NtVnQvdm9E?=
 =?utf-8?B?UHdGdDFSZmFPMzR3MmNPUmFOVEFNbmZUaUlhOU1pdzg3Ny9QOU1Na2cyWllV?=
 =?utf-8?B?RzBSVmNqQ1p2WnB5ZHQ2VXlqS3V2OG1yL1A3YWoxSHluTFM0UG9HU0wwWGtz?=
 =?utf-8?B?RnJETExxUWpiYWd0NDcydCtLNktyV2k5TEc1N3VVRkhPeGV2OVVFRk1nS1Jt?=
 =?utf-8?B?aGZCanJ5RkF0ekE5THRBUGFhRG1YamVqVHFTRFBnOWx2VjQ5cEYvckpXbkF6?=
 =?utf-8?B?RENCMWRoMmhvRTl3bWtsSldyZzBpODY2QmQ2YzNVM0xXYW45S1AyTW9lSFUw?=
 =?utf-8?B?ZnRTMmJCRER4UDFtWHhUSW91OG9mU1BiOFNvanZjWkttMTdQYVRFaWNFZEJ2?=
 =?utf-8?B?ZnRxYzZZblEwYmJQaHZxZ3Bsem1XK0U0LzBkcng0TFVlMEtXNUNoWDlIVG5R?=
 =?utf-8?B?QlB5MVZVVmF5T0ZNL0w2UmNrN053M2hJTmhuelNTcldoTjdNb1lqcG1iZzNU?=
 =?utf-8?B?bUZ1NzNsK3NvTHRkTVdaeVhuVVVWd00walVGZXRGcCt3eGlCN1BPaDNhd0x2?=
 =?utf-8?B?L2xvWVV5Z1QrYklEK0lRNFlsYUgrZWxuRjhlZXFUc0U4bmd3Tkkwa3VEWU9n?=
 =?utf-8?B?RFUvQyswbC8zVTRvRm9IQ0piNnhxUzV1dkNua1ZKMXNUaHNlNVJMYXJQQ0hJ?=
 =?utf-8?B?SmpNTW4zQmdWNXJIenk1UHFOSXJBNUJpVlRCNlc0Ni9iS3hUSzdSRVBoME1N?=
 =?utf-8?B?VW9Sb1ROYnlHRWZWRDI3VkZheHVxL0lBdmFJNXJMSFNOelN5WXhEY0hmdDF4?=
 =?utf-8?B?bE14VmRHY0hqelhUczU5ZU1VdjIrNzBFdktJdjF4dDY2NURrdmZQaVYyUFJw?=
 =?utf-8?B?YmxsL0ZhVWw3OUZrUGJjS3dDeEU5enNsVUpUd3ljS3hscHlTUFpyTWtyUVV2?=
 =?utf-8?B?b3UxUXU4SSt1c3ViQnFsZ3NIWDhlTi9OQXlXWTk0ZmdHNjNrQzB4RmYxODVk?=
 =?utf-8?B?Wm1IV01RN2ZWdDlvVUNLcTFZZlc0R3c0NFJWTTJxUFplM21WVTBKVzdpRWpo?=
 =?utf-8?B?bi9KUUdzWHowQ0pCWFNyQkU1YkthSjF5a2NmMUV4NFZNUVcvSWh0cGFHQjV2?=
 =?utf-8?B?V2NWdG1yWXdQQnNnNS9NRmtwZHVaU2ZmTWlpcFBucllUbWR0dWZjc1NjR2J2?=
 =?utf-8?Q?Sxzd4aMVZ7tgy/KqSsbbX++eF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <005D0D92D20118469CFCDDD65BA02090@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8e2bfc6-cb5c-4cf1-f43b-08dc4f0a1cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 09:33:23.3779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CphDEFLiBh9PXaCBN5wXLr/arhGU3xFC/Bmn28XUWuyILgPcC2LJjSC+Mgbx753nwK7sDprtdpZmpwpoG4fElg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9125

SGkgS3J6eXN6dG9mLA0KVGhhbmsgeW91IGZvciBhbGwgdGhlIGNvbW1lbnRzIHNvIGZhciENCg0K
QW0gMjguMDMuMjQgdW0gMTA6MTQgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAy
Ny8wMy8yMDI0IDExOjU1LCBKb3N1YSBNYXllciB3cm90ZToNCj4NCj4+PiBJIGRvbid0IGV2ZW4g
dW5kZXJzdGFuZCB3aGF0IGlzIHlvdXIgY2FzZS4NCj4+IEkgc2VlIDooDQo+PiBZZXMgdGhlcmUg
aXMgYSBkaXNjb25uZWN0ICpzb21ld2hlcmUqLg0KPj4NCj4gWW91ciB3YXkgb2YgcXVvdGluZywg
aW5jbHVkaW5nIHJlbW92aW5nIGJsYW5rIGxpbmVzLCB3ZWlyZCB3cmFwcGluZywNCj4gZG9lcyBu
b3QgbWFrZSBpdCBlYXN5IHRvIGFuc3dlciBhbnl0aGluZyBoZXJlLiBVc2UgZGVjZW50IGVtYWls
IGNsaWVudA0KPiB3aGljaCBzb2x2ZXMgYWxsIHRoZXNlIHByb2JsZW1zLg0KPg0KPj4gSSBzaGFs
bCB0cnkgYWdhaW46DQo+PiBNYXJ2ZWxsIGlzIHNlbGxpbmcgdHdvIGNoaXBzOg0KPj4gMS4gQ045
MTMwLCBIaWdoLVBlcmZvcm1hbmNlIE11bHRpLUNvcmUgQ1BVLCBTeXN0ZW0gb24gQ2hpcA0KPj4g
KGNhbiBiZSB1c2VkIGFsb25lKQ0KPiBTbyB0aGlzIGlzIHRoZSBtYWluIFNvQz8NCkNvcnJlY3Qu
DQo+DQo+PiAyLiA4OEY4MjE1LCBTb3V0aEJyaWRnZSBDb21tdW5pY2F0aW9uIFByb2Nlc3Nvciwg
U3lzdGVtIG9uIENoaXANCj4+IChvbmx5IHVzYWJsZSBpbiBjb21iaW5hdGlvbiB3aXRoIGEgQ045
MTMwKQ0KPj4NCj4+IE5vdywgaW4gdGVybXMgb2YgY29tcGF0aWJsZSBzdHJpbmcsIHdoYXQgaGFw
cGVucyB3aGVuIGEgYm9hcmQNCj4+IGhhcyBtdWx0aXBsZXMgb2YgdGhlc2U/DQo+IE11bHRpcGxl
IG9mIENOOTEzMD8gMnggQ045MTMwPw0KdGhpcyBzcGVjaWZpY2FsbHkgaXMgYW4gYWNhZGVtaWMg
cXVlc3Rpb24sDQp0aGUgbWFpbiBwb2ludCBpcyBtdWx0aXBsZSBzb3V0aGJyaWRnZXMgdG8gb25l
IENOOTEzMC4NCj4gTm90aGluZyBoYXBwZW5zLCBkb2VzIG5vdCByZWFsbHkgbWF0dGVyLg0KPiBB
bnl3YXkgdGhlIGNvbXBhdGlibGUgaXMganVzdCB0byB1bmlxdWVseSBpZGVudGlmeSB0aGUgZGV2
aWNlIGZvciB1c2VycywNCj4gbm90IHJlcHJlc2VudCBzb21lIHByb2dyYW1taW5nIG1vZGVsLCBi
ZWNhdXNlIHRoZXJlIGlzIG5vIHByb2dyYW1taW5nDQo+IG1vZGVsIG9mIGEgYm9hcmQuDQo+DQo+
Pj4gV2hhdCBpcyA5MTMxIGFuZCA5MTMyPw0KPj4gSSBoYXZlIG5vIGlkZWEgd2hvIGNhbWUgdXAg
d2l0aCA5MTMxIGFuZCA5MTMyLg0KPj4gQnV0IGV4cGxhbmF0aW9uIGlzIGdpdmVuIGJ5IEdyemVn
b3J6IEphc3pjenlrIDxqYXpAc2VtaWhhbGYuY29tPg0KPj4gd2hlbiBoZSBzdWJtaXR0ZWQgY245
MTMxLWRiLmR0cyAoTWFydmVsbCBldmFsdWF0aW9uIGJvYXJkKToNCj4+DQo+PiBFeHRlbmQgdGhl
IHN1cHBvcnQgb2YgdGhlIENOOTEzMCBieSBhZGRpbmcgYW4gZXh0ZXJuYWwgQ1AxMTUuDQo+PiBU
aGUgbGFzdCBudW1iZXIgaW5kaWNhdGVzIGhvdyBtYW55IGV4dGVybmFsIENQMTE1IGFyZSB1c2Vk
Lg0KPiBZb3UgdXNlIHRoZSBjb21wYXRpYmxlcyBpbiB5b3VyIHBhdGNoc2V0LCBzbyB5b3Ugc2hv
dWxkIGtub3csIG5vdCBtZS5JDQo+IGhhdmUgemVybyBrbm93bGVkZ2UsIGFsc28gYWN0dWFsbHkg
YWxtb3N0IHplcm8gaW50ZXJlc3QsIGluIGxlYXJuaW5nDQo+IHlvdXIgcGFydGljdWxhciBwbGF0
Zm9ybS4NCg0KRmFpciBlbm91Z2guDQoNCj4gSSB0cmllZCB0byBmaXh1cCBzb21lIGJpbmRpbmdz
IGFuZCBtYWludGFpbmVycw0KPiBmb3IgTWFydmVsbDogZmFpbGVkIHdpdGggbm90IHJlYWxseSBo
ZWxwZnVsIGNvbW1lbnRzLiBUaGVyZWZvcmUgSSBkb24ndA0KPiBjYXJlIGFueW1vcmUgYWJvdXQg
TWFydmVsbC4NCj4NCj4gWW91IDxjdXQ+IHNob3VsZCBrbm93IHdoYXQgaXMgdGhpcyBhYm91dCBh
bmQgY29tZQ0KPiB3aXRoIGV4cGxhbmF0aW9uIHRvIHRoZSBjb21tdW5pdHkuDQpJZiBJIHdhcyB0
byBjb21lIHVwIHdpdGggc29tZXRoaW5nIG5ldywgd2l0aG91dCBsb29raW5nIGF0IGV4aXN0aW5n
DQpEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdr
LThrLnlhbWwNCkkgd291bGQgZGVzY3JpYmUgdGhlIGhhcmR3YXJlIGxpa2UgdGhpczoNCg0KU29s
aWRSdW4gIkNOOTEzMSIgU29saWRXQU4gYm9hcmQgaXMgY29tcHRpYmxlIHdpdGg6DQotIHNvbGlk
cnVuLGNuOTEzMS1zb2xpZHdhbjoNCsKgIG5hbWUgb2YgdGhlIGNhcnJpZXIgYm9hcmQsIGFuZCBu
YW1lIG9mIHRoZSBjb21wbGV0ZSBwcm9kdWN0DQrCoCBpbmNsdWRlcyBvbmUgc291dGhicmlkZ2Ug
Y2hpcCwgYnV0IEkgZG9uJ3QgbmVlZCB0byBtZW50aW9uIGl0Pw0KLSBzb2xpZHJ1bixjbjkxMzAt
c3Itc29tOg0KwqAganVzdCB0aGUgc29tLCBpbmNsdWRpbmcgMXggQ045MTMwIFNvQw0KLSBtYXJ2
ZWxsLGNuOTEzMDoNCsKgIHRoaXMgaXMgdGhlIFNvQywgaW50ZXJuYWxseSBjb21iaW5pbmcgQVAr
Q1ANCsKgIEFQICpjb3VsZCogYmUgbWVudGlvbmVkLCBidXQgSSBkb24ndCBzZWUgYSByZWFzb24N
Cg0KPiBZb3U8Y3V0PnIgcGxhdGZvcm0gbWFpbnRhaW5lcnMgc2hvdWxkIGtub3cgd2hhdCBpcyB0
aGlzIGFib3V0IGFuZCBjb21lDQo+IHdpdGggZXhwbGFuYXRpb24gdG8gdGhlIGNvbW11bml0eS4N
CklzIHRoZXJlIGEgd2F5IGZvcndhcmQ/DQpXb3VsZCBpdCBiZSB3b3J0aCBjaGFsbGVuZ2luZyB0
aGUgZXhpc3RpbmcgYmluZGluZ3MgYnkgcHJvcG9zaW5nIChSRkMpDQpzcGVjaWZpYyBjaGFuZ2Vz
IGluIGxpbmUgd2l0aCB3aGF0IEkgZGVzY3JpYmVkIGFib3ZlPw0KDQoNCnNpbmNlcmVseQ0KSm9z
dWEgTWF5ZXINCg0K

