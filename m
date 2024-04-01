Return-Path: <linux-kernel+bounces-126468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8DD893864
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E503282CE9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 06:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6250F946C;
	Mon,  1 Apr 2024 06:32:55 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2138.outbound.protection.partner.outlook.cn [139.219.146.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE41BA2E;
	Mon,  1 Apr 2024 06:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711953174; cv=fail; b=o1+E/sJA9W35bYtMw5mZS2OIXJTmc5SQoN8oHmo287YAKFu13uQEFRMC2IQJ2jclFQZoS1+9Gp1oaxaj1/5e01mNTWyBgMDAmXebGP7Rv0etZ8TVk+96A74q2RtzvUyCI1UU2r2V7pvK4CLQyZpDWV3Z1Co3zBM5JfDdTOsLDpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711953174; c=relaxed/simple;
	bh=UdTmOTYk+eLYc4KGIe6aQ+rFGC7vE5IbSmnLQMNARVk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NbQqT7FxDYsU3ahUL4y9dscWYziP9s6cDj9hr8GMhhOv3DMnPsg9stZ8+5uGb6F8jWzD1B9UK3PYDhnTG0AF/10JuMuYMesXWgaIe3QE0oci5wIg4vQ5oYN571kosdbV0h6MEHzA97lt3jXbJ+KcAclauYt5n1SgpUK3KkSsl5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZG9q3LXYTGgdkycJLJdeLMLxmKY5tLBg2+1Pfl+PTZ0hKqhLcrij0McVMbN/lSeIEzhFv4Tktt6BLooxlNBOgXgxilSgBOM2FOr7qKmmVWMUwzIOb4Kh2c65uQdfQpduUwJSYV0NPjnpfjczuBJwo5f/zlRvLpgyH1quKoRAqddgr9OR5C6nDj5qlJFeLp+zaz3KggYmR/wlGHviYi7ejGYH1rOfQD0oEYho6jwYvkX10Lgn1m3jU69TeFFq5Gg1taqNmEfx4SMHQS+mhi1u02R4taiojJHRYeEAFgXR3LHlp5+DbnQaFK2fP2CYzQ0As8n4EOzb9l0CN5ihV5Gi3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdTmOTYk+eLYc4KGIe6aQ+rFGC7vE5IbSmnLQMNARVk=;
 b=HsEDd2lrXeHEmtfcj8qFu6DCY9A8B2rgA18fDoSOj1fNyM+jaubpuWqxCAq2USYSe/eHBqNWCkFGqIWwKijgCErpw3I3vhJjCoTIlAb9sHD/24Sz3p09a/fOl14Nhcx1haq0im6QsJgx9tM0ZSbkmq9tD7N1mNNxqbR+ANGfN9h+mak9repGuBH3ciO66/qbKHa/ck+dfMQBwaVFwPmw8CNrDHVOF1yoDkK1uHqcRpbCVFmFQHuG3fQxvJwY/BLumpRNiRNsh0dnXq4Fy8TjG028HBZw2Mj2b46LBrD9f4yPfcaCPXqUP9GvqPPgI0ZYGitOz7Q8vJFoPLC893Z06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1100.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.26; Mon, 1 Apr
 2024 06:32:42 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::9a50:2c82:c5d4:2b3d]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::9a50:2c82:c5d4:2b3d%4])
 with mapi id 15.20.7409.028; Mon, 1 Apr 2024 06:32:42 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Mark Brown
	<broonie@kernel.org>
CC: Liam Girdwood <lgirdwood@gmail.com>, Claudiu Beznea
	<Claudiu.Beznea@microchip.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>
Subject:
 =?utf-8?B?UkU6IOWbnuWkjTogW1BBVENIIHYyIDEvMl0gQVNvQzogZHQtYmluZGluZ3M6?=
 =?utf-8?Q?_Add_bindings_for_Cadence_I2S-MC_controller?=
Thread-Topic:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjIgMS8yXSBBU29DOiBkdC1iaW5kaW5nczogQWRk?=
 =?utf-8?Q?_bindings_for_Cadence_I2S-MC_controller?=
Thread-Index:
 AQHaeqVg8Gitft8lDUSWv/hm2rXn9rFB3QUAgAeCKECAAD4OAIAAZEYQgAET4QCAAv1iEIAAlEQAgAAfyICAACi/gIAEFYKA
Date: Mon, 1 Apr 2024 06:32:42 +0000
Message-ID:
 <NTZPR01MB0956984A1436144E0D9B094D9F3FA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20240320090239.168743-1-xingyu.wu@starfivetech.com>
 <20240320090239.168743-2-xingyu.wu@starfivetech.com>
 <9d9efb8a-0b3c-4e7a-8673-07cd3b1f5f87@linaro.org>
 <NTZPR01MB0956BD6189974378958562D99F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <9b1a5100-8536-4b59-b2e7-d6ebd2ba9e66@linaro.org>
 <NTZPR01MB0956230296D881F112F92D119F35A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <16f72b4a-2aa9-49d5-a4aa-ed94eea1f32a@linaro.org>
 <NTZPR01MB09563633F5C3B5FBC95D61289F3AA@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <7b4a35d0-6764-4c6a-9f1d-57481324c680@linaro.org>
 <ZgbDx6oD+mMUIvH1@finisterre.sirena.org.uk>
 <7297bd78-4f74-4d23-afb3-9b7aecbe451d@linaro.org>
In-Reply-To: <7297bd78-4f74-4d23-afb3-9b7aecbe451d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1100:EE_
x-ms-office365-filtering-correlation-id: 24e99b83-9f84-4da4-3198-08dc521588b3
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XET/ZU+PV47XlAXbz8XdwuukBlahaM9KJS3yrsz/Ymeq+I5DkZ5t7Uc3TajL/lvmqvr/13OjMyMODI19V+7J5WN/XW5g1/cD6KB2OJJV+aqzXuwMVjo/kZgIYNc1LdtQO0tT5CAzGhtqtf6V2at2WvNW9AbYeD0Nn1zm7geZbB88QGtCkfdMAzGOhBG0ABzxn/rRNytVw26Ck7jiM0bi3cpo+SF3UjlkDL3XmK0e3RAKF9Zob6Xlmcip/eLwU1FtsF6TRgRm1W69jaJEQ4ZM5E/N1ITgIjiQ3d9gMMg3jvIS70Act0S908bBmViBDfSS8R1tNC7MUrXYrDiuFqUvU+aKWEIYne+k264MHmR+dB7IptjRjPcC+6l0l6AEpYhcPUVqi5YtQjgHY2V8hAaqb6E933+mjfogeHdSFRBayfjd0Gkkkc0wzVl5a2lopP5XyF7Xi3YUdYyy/bQNklBLvqwZH+1dpvpBR//WD0q4ZwxMvdZnwO/yt5rV8sT8a0+gjvgdvIp3CeP8YYrUeN9BgPhcAvDnGcDo/a1uBpX7vh1ne8p2BdkMwMN5B1B9e1KVELwcJvxxXq6CWMUxucbAReC/S31MAgBNPJ6SJpWoq7IoOrMk0Ir9V8rY2ballNe/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXdzNmNkWUg0U1RRNWQrNFYrcUtKeGpJTkh5aTk3TVFib1FzQm4xK3RYeHhn?=
 =?utf-8?B?YVdYKzdCcVhUSnBjU0JReFBXOVlEeEJvRGthQjVVY3p3cm4vUGowcTJkaHNT?=
 =?utf-8?B?Y2FhRDVDSE16L3R4Q3RMaElqK3l4aG1UQWU3Z2NBaVJHaEtvc2FxcEdOUnR1?=
 =?utf-8?B?RzBDVDBDY2dSZ1B1MUdISzhtVy9PaE9LQ0Z4akFFL2xGM29XTjNtdTgwUURP?=
 =?utf-8?B?NDcySjZoMG05UzdTUlFEQmRJWWFER2ZuUEN2VjZmQWVmYXJPVktqOGxnUVlO?=
 =?utf-8?B?RFgzQzF1ME5PcS9aV1lraXBlTWtURUlxQjc3QmVKaThBTnVCV0JESDBFbVVj?=
 =?utf-8?B?Q2dyODIvWUxLNkZVZExYdXV4WFFsM0NOUDgyK2JFNDZnUUpOUlJTSlNWYkFG?=
 =?utf-8?B?VFNvNXZwcWhLelFjZTlTV0o3dVJkRnNtanorditPbGR3MDU5VW0zMzZkTkRi?=
 =?utf-8?B?NVU4TnpkS0RMbHY4c0RXRFJHMUQ0d0o4clBSc0p2bXhnSkNhZFd4SjFxNUZy?=
 =?utf-8?B?RWJkK2lXcGtSQlBWMWZEeG9GaEttSE9ReWRJS2h0Zkg2dUlFSzNDYlErR0Zs?=
 =?utf-8?B?Y09yZStSdVZMRGtwSmtsYURsbUtteDJSMDRxK0lmSEtqeWd1LzNCSkFXeTEz?=
 =?utf-8?B?Nkx2TTlzS0FadmZDWW45UEVyUy90akpkWWtWclZJNkRFVUwrTngwaUdObXJQ?=
 =?utf-8?B?V0RQUmFac1laajEyWlJoa1BMU2VSQ2I2aEFJelpnR3RMTEtZQjVFR2NkZ3JC?=
 =?utf-8?B?TndKNmtVZFE1NXdHa0lwWk0xa3ZqRXQ2ZVhOTS9xcG52bDJySS9nQlZXVW1C?=
 =?utf-8?B?VEMxeCs1N0Z5MStnN1JWamxxaXI0dUhFdkZBTGlVY01IZzZxOTROeFRGTVBJ?=
 =?utf-8?B?ZXNhMDdKUjhabFBGcHpmQ05zNVR1TjdWZlMyYnY3ZDgwejJFSllXYVlWZDU2?=
 =?utf-8?B?MkIwMThYRW1ucEtGY1hSZkI1K2ZaNnBTenhkZ1pmWGZRK0QrTGE1Z1NFWi84?=
 =?utf-8?B?NXpsRmptamtmNkxBd2VoRHhBUEkrakFUclRNc01GZ0xjRUF0M1JhZVN4REpS?=
 =?utf-8?B?T2xYVVB2dFVVYXREbXRGZDJNQUNJbkRwV0RJdzhtZ2FDWVZsN3I1N1YxSCtk?=
 =?utf-8?B?N1dpTmJHdkdJWHViT1NTR0wwRXJPb0xKZm9mb0tkNHJha0ZZQTRZTGlhYmdv?=
 =?utf-8?B?TWFVUXFaQlo2M0NMSlgzV1hNSldNbWtRSEtPalpKZTNuUDRNTjFNWkM5QkdG?=
 =?utf-8?B?anJGYWdTQktEQ2xnVHhjcUNjN2tabGVtQ1ZDbERWS1dMU2w0OTRNbnpPc1lM?=
 =?utf-8?B?N1VYZllNaDk3TVZLalhBTkxUcmlPNElRdjdLaE5mMU82WW1uMVN3WXJSUGQr?=
 =?utf-8?B?emNhQmNWUC83cHBZTi9KcXdTR2pXcWdXemlCeHJOSGF0YTVONUVrbVpxekV5?=
 =?utf-8?B?bm53RTRXYVZXbDdjcVZJcithK3RMbGY4UUp1NFhyVUtQdE5VRG44cEVGUVZi?=
 =?utf-8?B?Z3E4WnNHVkRBYWh1bEYzNjJxK3NLdjg3Q2c3QWZOM054WTRpTkdCUnczSDFJ?=
 =?utf-8?B?ZVJRdnBxbWNOdWpROUM3MGNHV1NmSEY0MXZkYmRxZ0x6Z3pvYXAvaHVCU0xZ?=
 =?utf-8?B?RDlZZVF0dzZac2Q4QS82Yk1ydEZTTSszZk5zU0Q2ZDF4Z0xCYnFWMFQ3L1Bl?=
 =?utf-8?B?dkhuV012SkVQbUVORWc0V0kybE15WEtjN1VubzdvT2JFVUNSN2RoZWI5aTh1?=
 =?utf-8?B?WG9SQjZyRmtmSGIzTkdDSzlEd2dqQ2RJRXVyMERGYThZQityYXNOTjdRT0ll?=
 =?utf-8?B?aVFTbnNLM2ZCRUJ3RTZOdHRQcWppQnNSaHZmRElPTkdGa1dPcXdKQ3c5eFhK?=
 =?utf-8?B?b2Yxczh1ZWpocVhiRzVIUXNQMlF5K1ZKM0EyZWdzckJPbVFTTUQrcXUrZkVz?=
 =?utf-8?B?SnRPYjdoUzFnVkg3NGRUbzNyNSt1dUZvOW5LNmErZnAxeFdDUnVwd2dyWERu?=
 =?utf-8?B?MDRabnpabTNMeVJjWXJlSzZpS1dLSndCR3EvZnhieWQ5RmI1RDdJM3B5TlU5?=
 =?utf-8?B?QndTMHg1ZXZKbWtJbnlIb1pTMEdjcFc2cTNPQWRiMmZkWDZNYVA3Sm0xMG91?=
 =?utf-8?Q?itcptyzzlwZ5O/x5LLMFpQSPO?=
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
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 24e99b83-9f84-4da4-3198-08dc521588b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 06:32:42.0858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: to84wV/9mZX4M5O+qev6/25yeEmfHrODMkV2AV0aWh7FhdB078K0/ffNOSXRjL3on6qb4L2v6hNbOhwHI3rIGHNZu7y5QXI1Z2oED93Op20=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1100

T24gMzAvMDMvMjAyNCAwOjAyLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiANCj4gT24g
MjkvMDMvMjAyNCAxNDozNiwgTWFyayBCcm93biB3cm90ZToNCj4gPiBPbiBGcmksIE1hciAyOSwg
MjAyNCBhdCAxMjo0MjoyMlBNICswMTAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiA+
DQo+ID4+IEkgc3RhdGVkIGFuZCBJIGtlZXAgbXkgc3RhdGVtZW50IHRoYXQgc3VjaCBibG9jayBp
cyB1c3VhbGx5IG5vdA0KPiA+PiB1c2FibGUgb24gaXRzIG93biBhbmQgYWx3YXlzIG5lZWRzIHNv
bWUgc29ydCBvZiBxdWlya3Mgb3INCj4gPj4gU29DLXNwZWNpZmljIGltcGxlbWVudGF0aW9uLiBB
dCBsZWFzdCB0aGlzIGlzIHdoYXQgSSBzYXcgaW4gb3RoZXINCj4gPj4gc2ltaWxhciBjYXNlcywg
YnV0IG5vdCBleGFjdGx5IEkyUy4NCj4gPg0KPiA+IEkgd291bGRuJ3QgYmUgc28gcGVzc2ltaXN0
aWMsIGVzcGVjaWFsbHkgbm90IGZvciBJMlMgLSBhIGdvb2QgcG9ydGlvbg0KPiA+IG9mIHF1aXJr
cyB0aGVyZSBhcmUgZXh0cmEgZmVhdHVyZXMgcmF0aGVyIHRoYW4gdGhpbmdzIG5lZWRlZCBmb3Ig
YmFzaWMNCj4gPiBvcGVyYXRpb24sIGEgbG90IG9mIHRoaW5ncyB0aGF0IG1pZ2h0IGluIHRoZSBw
YXN0IGhhdmUgYmVlbiBxdWlya3MgZm9yDQo+ID4gYmFzaWMgb3BlcmF0aW9uIGFyZSB0aGVzZSBk
YXlzIGhpZGRlbiBiZWhpbmQgdGhlIERUIGJpbmRpbmdzLg0KPiANCj4gT0ssIEkgdHJ1c3QgeW91
ciBqdWRnZW1lbnQsIHNvIGNkbnMgYXMgZmFsbGJhY2sgc2VlbXMgb2theSwgYnV0IEkgZG9uJ3Qg
dGhpbmsgaXQNCj4gd2FycmFudHMgY2RucyBhcyB1c2VkIGFsb25lLiBOb3QgcGFydGljdWxhcmx5
IGJlY2F1c2UgY2RucyBpcyBkaWZmZXJlbnQsIGJ1dA0KPiBiZWNhdXNlIHdlIGV4cGVjdCBzcGVj
aWZpYyBTb0MgY29tcGF0aWJsZSBhbHdheXMuDQo+IA0KPiBUaHVzIGlmIGNkbnMsaTJzLW1jIHN0
YXlzLCB0aGVuOg0KPiANCj4gaXRlbXM6DQo+ICAgLSBlbnVtOg0KPiAgICAgICAtIHN0YXJmaXZl
LGpoODEwMC1pMnMNCj4gICAtIGNkbnMsaTJzLW1jDQo+IA0KDQpPSywgdGhhbmtzIEtyenlzenRv
ZiBhbmQgTWFyay4gSSB3aWxsIG1vZGlmeSBpdCBpbiBuZXh0IHBhdGNoLg0KDQpCZXN0IHJlZ2Fy
ZHMsDQpYaW5neXUgV3UNCg==

