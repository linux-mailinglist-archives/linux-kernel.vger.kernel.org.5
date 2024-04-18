Return-Path: <linux-kernel+bounces-149772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A26778A95A0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AA951F22C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0531115AAB8;
	Thu, 18 Apr 2024 09:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bh9tgDQW"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2077.outbound.protection.outlook.com [40.107.15.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509A158A13;
	Thu, 18 Apr 2024 09:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713431312; cv=fail; b=FeMXN2z9G+J8STB8OPo/NJJqpG55e3YMuOoiKpkCSIApPEyhERB6dP2DymCzg5hAUoE+2UB2WUtKCAvX5s+rB9bXWjvK8/4tctsPza/Vn6W2e+3mNNxhI8yID4jEHfmxAbpMbGQXOjGz7QcpUlbFQgInoZTLytBDsjBERZpkwZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713431312; c=relaxed/simple;
	bh=0xQVtMF4J7/fROewCk7gS4/BXiVMH/TRPX0H6zqWDcg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RAkef0q8FmhJMARhgz0XNGGvAZS0PRwV8omXKwGawPLLbvChiXdzuig8NEKD7QpQy/hW6sTDccjIK6KrE+9kv94iAUAKT7R+a+kIvobJyj9i/OLKGx3MePNgYoQxcsRf4kPSjoMq462tpoaq4Q4Zmye/k5sn+CroScoDxnCWb6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bh9tgDQW; arc=fail smtp.client-ip=40.107.15.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LyFbynB8mkwl2LMUeep4vT+jRS3DeR1hFCWO4QxHkD3BBERB+ovOFl3Z2HkC6OUkXbb2IhXNxJeaO0+sXwO3GcmtipedH5UVlrcADQavsd/hKG47GC0VVX+pLD7+ElTstO+XawzdKkN03cAyKK0l2WX8IWIuWgPGPmh03boMbB5kQGNsp6VOGuvHqe2nLt3Mt1kj9PBcJljM0WjU2SVCNY99gBpvV5L9c23Hv0qLwre03ZS0FGfOqtAD5QhLtwqnyr8YGRyTyZpwwa7IX+ifw/TV6Ndr6aDRIegeLr7Ep+8T9Nm8+ga9OkSTsfgsk1K6BAnM25unaE1i1xoc6tarJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xQVtMF4J7/fROewCk7gS4/BXiVMH/TRPX0H6zqWDcg=;
 b=nUYtB15dMwJoDe9oM9Ic/3CJ0cjS5d4rZwFDQHNUAkIeXoxnbRq6RabZR+GoXy42mda5w778qV/u/7deOiVvABK0/mOKAid7l13GkeGC1g9HyuQ3CHe1isxTDucYcymhCvBeC0HYrlttJBgpEY3VhMuUV9t/n/MW+mhiZkmCwBTw7yf2mNhx3VW5aQuOttB1+6++K/Q7tdPepmIlICxGtmTobEQHgymt9n5Y1Vn7d8UXmvkoxGFV9WTenWDrZWKOQqCt/Juk0yNoqYxi0w5j/jhyGS8lOdA/lsQ471A0KprJKqEcj8giLvxFfBI1kBYZ0KSmajtzu31+dKy3b/VC9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xQVtMF4J7/fROewCk7gS4/BXiVMH/TRPX0H6zqWDcg=;
 b=Bh9tgDQWJp07MUNLeMrHAYmuRj4ghrK20HxJGuBW65QndWelISUJ7u45ewYlVbLjARAX9yBRR5q70D0BNRU1Ou4JBJJP848U6i74055ApE6TmFrxlrZL7Kf5GNvEUyiPy4+BmQqOR6HvX59g8fMRZp8yS0XJnS4cUsu2ryiV2FA=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by GVXPR04MB10449.eurprd04.prod.outlook.com (2603:10a6:150:1dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 09:08:25 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::2274:2bca:7778:b464%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 09:08:25 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, "briannorris@chromium.org"
	<briannorris@chromium.org>, Kalle Valo <kvalo@kernel.org>,
	"francesco@dolcini.it" <francesco@dolcini.it>, Pete Hsieh
	<tsung-hsien.hsieh@nxp.com>, rafael.beims <rafael.beims@toradex.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v10 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v10 0/2] wifi: mwifiex: add code to support
 host mlme
Thread-Index: AQHakVaU0Zrk1KIcmUW6VoYZOwDO7rFtlgUAgAAl5gA=
Date: Thu, 18 Apr 2024 09:08:25 +0000
Message-ID:
 <PA4PR04MB963815B9FDA6119683A28CADD10E2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240418060626.431202-1-yu-hao.lin@nxp.com>
 <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
In-Reply-To: <0ED16BAB-6E7D-487C-BBCA-E63FEF37C60D@holtmann.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|GVXPR04MB10449:EE_
x-ms-office365-filtering-correlation-id: 46fe41ef-2597-4f98-eee3-08dc5f871ae1
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 7lpslLr5wPS/o1cPMS+HaMx1V4l6Uc+KqtDVDZTJqM9v8uNgS2pNtpVjuwMpS4jEr9r2e83/eL4y8kmhQfCEdAlQFJ5APPWz5N0EuX2fdS9R3UPAWW9DEcUL+S4Hs0fPLXhwG2LyIOM2FLVlJEZ+h7+EGfKvLpvYx/nX91BECc/5YXDeAFZqln9MKZr9nBBHVRHQ3OsPxF1ZX6WQdOCZxYQ7GPa+LhSmbTayB5qZCPbCRaId19wbrKbZSgh6f11tG8SY8YxYYrfs1aGbRfn83FJdvgepeIBw+uXVb2uJNdfmi5WfKKTmrGa902w/Epc7y4mGp2LztrnKnjbOQeP0iVb2UzstBPQa9IwKLLUfxxXzpOxIGi+U5mzZQAHt5zJNzm325vx8qQfLMHt9ZVRhg14hjYiIiPqPkntHGMzDdolf4MuNbCRjlOHlekfWs4X6VSQ0LbKT59tZg2f9yFc3SE/p44WSV3e33dIDbNTeLeIWMcv8ZtLy8g3f7LRds/30sgMSiRuTyClAB9EqkGNJGOkTvUIocsykEDrRTVej5PWIJngSqYtfrQ3zxlD/ZGSsvCTPZTc4By6YMjf7GP1831o0HKOFaekqqzDuDZLygOAda58xGrHRQTy/7sAFS+xrKR0e2RpUCd9+RbP//PgPCL6f0uolIoRqS/QpAWGCcxp581ct6afUj1gDJSPVnWkMMpSeuab9050xx4cNkdsVnP3y8vIELfpJKG2qhsO15Vg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0xtRFhjRk9MMEhCTE1sN3o3VVhCZHRzS1JlZXNhaS93TmJkYmNodmdyaVMz?=
 =?utf-8?B?VEZNb25rMVk2M1oxRWpFTGdveGJXbWxucWhKYm5MVGhES0s1YVo5THo4L0Vw?=
 =?utf-8?B?U0RKQUhIQ0xWMUtRUi83bWppelIrUFYyK0ZvWUJwdy84Vm84TU9rcmZra3J4?=
 =?utf-8?B?djh0QlR0WTJ0dGE2M1Y0b1NOUllUdFkrcDVwS1Y0ajJQenJ6dDU3T0d0dC9K?=
 =?utf-8?B?bVFRMzAvcWhyRm82QTdzWHdhcjhnblRCQ01zdWN6L0JwTS8xTmJ4Qk9TbGoz?=
 =?utf-8?B?VDVHVnlHTUo5bXFtVkNmMFlNZVdKb1dYeUt2Z3FjYzNwdVVma3ZKYkhES0JZ?=
 =?utf-8?B?elk1bVRvYlltZTUyZkxSc0FCMStxdmJTYWdWN2kvMFNIWnkrVTBWSnBDN0xw?=
 =?utf-8?B?OXFCUzl5YXdUVU9UVFdOcy9sTDRwWlN3S1k2U2dWMkJGb2pKaHlxeTVrK3c3?=
 =?utf-8?B?RHlLbG5WaVk3UnNUMGFUZGREYTVLR0crTitFZFFXMHBDdFlMS1VFOU1jYUFZ?=
 =?utf-8?B?citoaTU3ejBtRGtQb3Y3ZEFXUisycStwTjRpaUIyMWkyQ1J4djBWR29XRDNq?=
 =?utf-8?B?OEZXT2VVbVM1QjF1K084ekxPeEE3LzUrSGJaWHFEcTlldVg0OFNEKytaelh4?=
 =?utf-8?B?MjBKeEVWVTBZMmhjSndQMmVMUkh6TFZNS2dTcWM4dHVXWnBhNjAwV2ZUUVYz?=
 =?utf-8?B?c3I3T0ZURVhwVGdxSUZrVXZVU3pXanRqcjF2TXNUaFQ2OUlzNjVkaE5TZ1p4?=
 =?utf-8?B?anZpa1l3U2pnUkxWbWNHR0I5SHRlTFE5WDBGV29YUU9taXRma1FHcnZqMnor?=
 =?utf-8?B?VnFCWk00M3l6cGdWaTBCTGJwaVVYNnpkS3N5eHdoMWlkY0h1eTA1aDhqVWxq?=
 =?utf-8?B?eWhiUXRtM3Rsanl5Q0FFNElJUHJUY0VoeTlRY0ZGNWhWSExPQWFqRzFOUDkv?=
 =?utf-8?B?RVkyOVA0NnRMYmRLVmNDU3VOdFhZY0RXZ0p0eDQ0N0pESUkwNkxTMHN3a1Np?=
 =?utf-8?B?eXFUb1I3Z1pZVDhBTjV2Sm1JMEJxK3JTM2Jya0pUSklzanhVd1cvcHYyeGdN?=
 =?utf-8?B?Ym14UFZ1RWQ4djZ2K3pRcTZ4YXd4V1VXK2E1QTE5WmxISEwwZFlyK21zNlQ3?=
 =?utf-8?B?RWVVRzVwNFFkTmN3bTJTYWRVWHViRnZveHRBejZ0UnVMcWF3bUIzTEdEVkdp?=
 =?utf-8?B?TmNTSVBMeDg4WnAvenRJblNUd3dtazFQQkZBVDVBSG05NTJERkhEZ2NyOHli?=
 =?utf-8?B?bURmN3pkY3VWV0ZxZ0IyY2E2N09vbTlodjR6TkdIa3VYdTBWQlIrVjVPSEtR?=
 =?utf-8?B?NHBMdXpsc1FPWktnWGk3MzlVWExhM2IzN2wvaC9SZWhzbmNBQ1FyOU5CMkJw?=
 =?utf-8?B?dHpacW51bHZrY0J1UjV2S1BCdEpEaC9QRHFvUzRmbjNPYSt0SlhxdWdzL2p4?=
 =?utf-8?B?UnA3cHFIUzIyZE54ZWJwSHJwWkxVT20yU0EvMVFkT2NLZitFSTFWMHNqYitr?=
 =?utf-8?B?MUgzWFZMZTFmT295WS9zbWJBOThMa3BlbG1WWlB0VWpSdm1zanRkT01lcUVW?=
 =?utf-8?B?WTRCME1UZkZXSG5mN1VGNDR1SVc5dHZ5S05ZMnR2L0tzZVc5U2Z6bjVMSDdi?=
 =?utf-8?B?QjAzV3pnSVBxQ1BqdGRzZ3Jkemc1eW9UZG9pUFVPNnYybFdrN21FUEphR2x4?=
 =?utf-8?B?YXQ0NDcyUTZpUWllS1FiNFpjK2VmQkJyU3dlbm1zcGVmNjNGdVc1K3R0eC9P?=
 =?utf-8?B?cVhNbWFSZmQycnBwREVKY1ZsYjZKNHREY0dRNmF4TDdaeWhHWllYcVIxMldZ?=
 =?utf-8?B?dTVsWHhxUUlEVEtYcmhqUERYRWlEWVlWNDF4M1ZJVWR5bjgwakp6VHhWNy81?=
 =?utf-8?B?ZCt2QThYYmpCN1p1OW5jQys3SFJWSldsK292NW1ETFdTYnNVN2NUZk5NeUI1?=
 =?utf-8?B?S1pHVE5Jb2lGV0dKWUtJT3hzRlIyeWhuRXpnRVN1M1dsTUR0TEZhdjk2NUlh?=
 =?utf-8?B?V0VtWldWZ0JBOVNkYVpLaWltWDU0dm5HVWNBRTM0WFkvMlU0b3UvaHhSVk9z?=
 =?utf-8?B?NmhnelBETkZiclRQNGRiNlYza0FSTS9Hdm5CSVpqZlFrbEVCYys4ancvUmlI?=
 =?utf-8?Q?hM4olV7HT9HPxZ9A0wydL+KmI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46fe41ef-2597-4f98-eee3-08dc5f871ae1
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2024 09:08:25.5639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uFBgzrYNPlvDYtY5fUoxjdpGwn0ky5WHIoJr81Bfzl9xRdtdJ61O9mgi1UusfXk1YIo8lMlZGMJEVRXP7ES2BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10449

PiBGcm9tOiBNYXJjZWwgSG9sdG1hbm4gPG1hcmNlbEBob2x0bWFubi5vcmc+DQo+IFNlbnQ6IFRo
dXJzZGF5LCBBcHJpbCAxOCwgMjAyNCAyOjQ4IFBNDQo+IFRvOiBEYXZpZCBMaW4gPHl1LWhhby5s
aW5AbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgTEtNTCA8
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47DQo+IGJyaWFubm9ycmlzQGNocm9taXVtLm9y
ZzsgS2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz47DQo+IGZyYW5jZXNjb0Bkb2xjaW5pLml0
OyBQZXRlIEhzaWVoIDx0c3VuZy1oc2llbi5oc2llaEBueHAuY29tPjsgcmFmYWVsLmJlaW1zDQo+
IDxyYWZhZWwuYmVpbXNAdG9yYWRleC5jb20+OyBGcmFuY2VzY28gRG9sY2luaQ0KPiA8ZnJhbmNl
c2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggdjEw
IDAvMl0gd2lmaTogbXdpZmlleDogYWRkIGNvZGUgdG8gc3VwcG9ydCBob3N0DQo+IG1sbWUNCj4g
DQo+IEhpIERhdmlkLA0KPiANCj4gPiBXaXRoIGhvc3QgbWxtZToNCj4gPiBUZXN0ZWQtYnk6IDxy
YWZhZWwuYmVpbXNAdG9yYWRleC5jb20+ICNWZXJkaW4gQU02MiBJVzQxNiBTRCBXaXRob3V0DQo+
ID4gaG9zdCBtbG1lOg0KPiA+IFRlc3RlZC1ieTogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNj
by5kb2xjaW5pQHRvcmFkZXguY29tPiAjDQo+ID4gODhXODk5Ny1TRA0KPiA+DQo+ID4gVGhpcyBz
ZXJpZXMgYWRkIGhvc3QgYmFzZWQgTUxNRSBzdXBwb3J0IHRvIHRoZSBtd2lmaWV4IGRyaXZlciwg
dGhpcw0KPiA+IGVuYWJsZXMgV1BBMyBzdXBwb3J0IGluIGJvdGggY2xpZW50IGFuZCBBUCBtb2Rl
Lg0KPiA+IFRvIGVuYWJsZSBXUEEzLCBhIGZpcm13YXJlIHdpdGggY29ycmVzcG9uZGluZyBWMiBL
ZXkgQVBJIHN1cHBvcnQgaXMNCj4gPiByZXF1aXJlZC4NCj4gPiBUaGUgZmVhdHVyZSBpcyBjdXJy
ZW50bHkgb25seSBlbmFibGVkIG9uIE5YUCBJVzQxNiAoU0Q4OTc4KSwgYW5kIGl0DQo+ID4gd2Fz
IGludGVybmFsbHkgdmFsaWRhdGVkIGJ5IE5YUCBRQSB0ZWFtLiBPdGhlciBOWFAgV2ktRmkgY2hp
cHMNCj4gPiBzdXBwb3J0ZWQgaW4gY3VycmVudCBtd2lmaWV4IGFyZSBub3QgYWZmZWN0ZWQgYnkg
dGhpcyBjaGFuZ2UuDQo+IA0KPiBJIGFtIGEgYml0IGNvbmZ1c2VkIGhlcmUuIElmIHRoaXMgaXMg
anVzdCBmb3IgV1BBMyBzdXBwb3J0LCB0aGVuIHdhc27igJl0IHRoaXMNCj4gc3VwcG9zZSB0byBi
ZSBzb2x2ZWQgd2l0aCBleHRlcm5hbF9hdXRoIHN1cHBvcnQ/DQo+IA0KPiBSZWdhcmRzDQo+IA0K
PiBNYXJjZWwNCg0KRlcgY2FuJ3Qgc3VwcG9ydCBXUEEzLiBJbiBvcmRlciB0byBzdXBwb3J0IFdQ
QTMsIGRyaXZlciBzaG91bGQgbGV2ZXJhZ2UgTUxNRSBvZiB3cGFfc3VwcGxpY2FudCBhbmQgaG9z
dGFwZC4NClRoaXMgcGF0Y2ggaXMgdXNlZCB0byBsZXQgTUxNRSBpcyBydW5uaW5nIGJ5IHdwYV9z
dXBwbGljYW50IGFuZCBob3N0YXBkIGluc3RlYWQgb2YgaGFuZGxpbmcgYnkgRlcuDQoNCkRhdmlk
IA0K

