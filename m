Return-Path: <linux-kernel+bounces-150918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BEA8AA6B2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9561F21741
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A0A443D;
	Fri, 19 Apr 2024 01:51:35 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2120.outbound.protection.partner.outlook.cn [139.219.17.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EC4137E;
	Fri, 19 Apr 2024 01:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713491494; cv=fail; b=hl5Pr1cmzHqbk5NILl1VqwUtVEPBp6KB4StcgxTyourN4b56Qmr3SnyhsmUvDbE7dQWx9iRVAxHzkM/OwmrRJTPMXauwcuTNhZqi+3Al9BXmZdkHT35/SqmhkfLYp1DXkthgrnunx3SBXKzbv2im+m1G6jWtyYLgscMX/zq1F9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713491494; c=relaxed/simple;
	bh=mjv6tU8XVcUAO32q2h5Z9o5BNPP5NkrVcaVTPo+DicI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L4m/j886y9Nf8yZZ7n4lxMZR4qPCybqmUl2MaU8zAY+38wGW2lff409Y6oYH2arFZxh18Rwb6bve0OgEjJuZWIpPtssrVAhCdmvOGbz2ngpB1+CGbBwdX7tSmOkn0a43IonI+TjFrxfopXOVejkkk/WT+h5roro51egNZ8Hwdzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R5QTPvr8GHxFOAlUGSUs4Pd2siRdESCpzzmxDkD+uzxY9ehS3kVM0VM0oc1hD381F3tEkxh4ec4A95e4MQ+keH2aMAaDBnfvDPH19T1nvLedHaq/ulGjzDZ2uWGYVqjxdFQe1BSYhZGirX8cZy998/QNtaDrOaWvBO1hm9YoKZklmZ+RX/O1Faw+8FcyF1HacUYkvY6IqPqw0m+ZZez0PPZWhILkuxq5mdfIx5VYid9NlUPYL6r3OFe+qUuk2QzqEiv40ZlwvQtc91qdGWYGozBgMpt8ouUHz2TWtVdSAEUM9MGNqOp1RL+456zv6007Q8XGYA/PMNmA9rkR/HH1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mjv6tU8XVcUAO32q2h5Z9o5BNPP5NkrVcaVTPo+DicI=;
 b=VcToSS6CR+cdnW4ve01nmuwqanS9dC3bor5v9VbT8hj+X+PYYXD+wqMurtudw86FqXuKFt+YXKK/pq1vXEb8YvO+pDE3nMNnH1iioIWHH4x8SUjWy1Nm+klvX3GuZqjIxm4iN6uUB4bRJDFTwHE0Z39kvpf8lgIIx7rRL45FusXec9aResaQICTGK5xzyCc7q8wXXS8ojq0dNgEsVFYqKTPEZBhiiWDJEr8XlYE1QTK3tjDQshD46rjeMXcdwteVOfRIMbmsTVBiKqQpG2ylZBcAxv8AZOAmITwz8JM7uRHweTj+w8cnShETmYMSS63cQeLHziz8xW0Madietq+PWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::10) by SHXPR01MB0846.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Fri, 19 Apr
 2024 01:17:38 +0000
Received: from SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
 ([fe80::b0af:4c9d:2058:a344]) by
 SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn ([fe80::b0af:4c9d:2058:a344%7])
 with mapi id 15.20.7409.055; Fri, 19 Apr 2024 01:17:38 +0000
From: Changhuang Liang <changhuang.liang@starfivetech.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Jack Zhu
	<jack.zhu@starfivetech.com>, "linux-media@vger.kernel.org"
	<linux-media@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-staging@lists.linux.dev"
	<linux-staging@lists.linux.dev>
Subject:
 =?gb2312?B?u9i4tDogu9i4tDogW3YxXSBzdGFnaW5nOiBtZWRpYTogc3RhcmZpdmU6IENs?=
 =?gb2312?B?ZWFuIHBhZCBzZWxlY3Rpb24gaW4gaXNwX3RyeV9mb3JtYXQoKQ==?=
Thread-Topic:
 =?gb2312?B?u9i4tDogW3YxXSBzdGFnaW5nOiBtZWRpYTogc3RhcmZpdmU6IENsZWFuIHBh?=
 =?gb2312?B?ZCBzZWxlY3Rpb24gaW4gaXNwX3RyeV9mb3JtYXQoKQ==?=
Thread-Index: AQHadCdXg2iQIaE4RE2+8VSiB5BEfLFtdhSwgAEKroCAAIRxcA==
Date: Fri, 19 Apr 2024 01:17:38 +0000
Message-ID:
 <SHXPR01MB0671B2D3F26A593730FD2A9DF20DA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
References: <20240312024520.11022-1-changhuang.liang@starfivetech.com>
 <SHXPR01MB06710239B9F69E2F0EC0CB01F20EA@SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn>
 <ea244234-38f0-4381-9c9a-b6c6076e7dcb@moroto.mountain>
In-Reply-To: <ea244234-38f0-4381-9c9a-b6c6076e7dcb@moroto.mountain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0671:EE_|SHXPR01MB0846:EE_
x-ms-office365-filtering-correlation-id: 3c240878-860a-45be-a0b6-08dc600e80ac
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XsExo4pGLcLpnb2pW1Gby0QzgLMyfL0aOhjrgKHFHfBU7GqfqxlexQnr2gVb4QsmdDdx1TKuPLxKzUSRQC8qpmjOhc2qCCyNg44jaTrnTHcr8SqAMGpfsdbt0i6K3mB72IyvFFXnk9OOO6pSdrsIXGs0H8dai/n14suKplkOiA0Kvyj46TQnW6g0kHMeNPbeN6kQO4mWHvCluHLBZTsE8QtRQY1dPSYJu1RnIsTEgY47xODv17DeRMef+RDO0uiDJyb6I8S8soWWlvmUvkYNElg7tb66gWxxuHI2uEdkSvbO4IFjrzWAUZMW5M3I30+t1yE6t3lj8QdVUknM2hYA+1ezrO02A62rL6xs7wWTAN1bjaCx4ndK290FZKLtZra3KiQ+QxNXEb3sH3qf+xWXZOxF6FB2YQK70s9Z2p46XvN9KCF6lUFpsgb/b0FN7uH2eApXcVhLttdV8OFV6WmAR2qZo9siEUSg/ra1RAXvfxWC0t3p51nN/rvmmouxcNfhtwCaWqUHUGXRPw27Cd9f4t/KqGJISC1xL3gqaGQ2sbI6ka+qiAHtjYR/hVfi35dzScE3D6ykDhYDTzZB95VgXgI2zBKZ0A+ImAHsqLLMcgmKgBV8afDsSphel0r6hEjZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(41320700004)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RmZLRWs1UGhyL0FlRDZnZ0k2aUFkQmRtM2VYQ1FXb2taUDNpTlFKODdsY2Vh?=
 =?gb2312?B?N1I1OU9kZm1UVXoyR3hTQTlQczhwVmJDQ3gwem8ycUovOG9BRStrZ3ptdjNN?=
 =?gb2312?B?U25zNkNEZTVzMUhWenlCMzdraGw2aFFWREhuTER5RktmL1NqOU1UUzZpQWQ5?=
 =?gb2312?B?WnQrT1BuS1ZPMnhScktWdzkrK1MyN0w4L0FVR1phaHgxZEJDOHBtbjVCR2tM?=
 =?gb2312?B?Zjlyc0VqdGkzUS9WcFZwRG1sMkpoRWtCYkV4aWgrcU8veDl4VUFTY0pRSklx?=
 =?gb2312?B?Wm5aK09BM0VBcXNwN2tTV1p0aG1qdWV2aDJtMVhoVko2NlBPTXEyb0w2TEE5?=
 =?gb2312?B?bVpVL2tKUkxKbHVFdzN2YlFEQnlDQXB2N0dRcm9SdXZsb3hXZ1gxRDYxejFy?=
 =?gb2312?B?NUI5SHRDMlFyY05yZ2FzRG1BUEI5LzUwM0pMZzF6d3QyaHRsM0o0ckhkT3BT?=
 =?gb2312?B?N3NQL3dBV2wycFZpS05NbUU3QVIzV3BmN0tMUFpIY2NhN1NGTUkvRm5sZVNm?=
 =?gb2312?B?YTB5Q2ZxeFlTLzkwWHJwcVZFeTcrclhvSlArdE1pZkdLRHR0MXR6NTE4L1ZR?=
 =?gb2312?B?ZFFyc2k2ZXZFbDF6ZGJoL3l2Y3Y0UkowVmNkS1NlNnNDR3d4VVRibDFJSzFY?=
 =?gb2312?B?Z2hCb0tFZ0dSS2FaaXorTjFLNHVEWXYvdDkwUjE3S0FkU0h4NHl4dTVtR2dC?=
 =?gb2312?B?YjhlcFBpRzEvUmo0MnJFaFQvMFY3ZkdQRUJGbzBiYi9oMnUxaTM0TllzZ3U1?=
 =?gb2312?B?dVMrangwS3ZxRWsrWjI4NzVpSlczcWdEOU0xeW9LSFg4STY4ay8zNVllRS9J?=
 =?gb2312?B?YzBGbVozbkxJdnY0a3g3QklNR2JNL0FOL1NGeE1MYWpvYlNiQ0FHNnJCdUdV?=
 =?gb2312?B?ekgwZ3FJajZmbmNiSmlqTU13WWdvRS9CRU5qdS9XSkJyM1pEL2FUTjVPZGJn?=
 =?gb2312?B?c3huQXBXOHI2ekVHSGRvUUFJQTdYa2N6U0ZZbytLQkpDMWpsWkQxZHhNa0t3?=
 =?gb2312?B?eE5Hd25GaUtpQmpwTnptUnUrUG8zamVvQXpnMllvSlI1NVBOUmV1M2VBb1hW?=
 =?gb2312?B?QXA3OHR1RCs4SnpvdUNkSVhGZHJhVEFjQ0FseWVUQ0lMVy94QWxQelFBSkkw?=
 =?gb2312?B?c1hrTCtyMFV4Y213em4vU3MvNjRpSWlSUzlBVE9mT0Z5TnVTOEl6Q2pLcFFP?=
 =?gb2312?B?ZU5IU0d4Ync2Zk9DM0FQdTNXOStCK0RTRHNZTWh5aDVlQ2txM0x5OW1NcE14?=
 =?gb2312?B?djM5N2RRMFkxMWRJWDBrSTJ2d0tNalM5VFcyMTV0SmdRK1o4LzdoWWZzVTRK?=
 =?gb2312?B?OFFDUzJWL1NiNlpLaGcrWmxjb1FkTzRQajIrUUEzU2ZoaC9TbWlHamVCRzd3?=
 =?gb2312?B?NVVkV0RIVE9FKzdVd1RNK0M3MitqbWlnVUlXZTRkaGVNNERBNzdsWFpFL0ZV?=
 =?gb2312?B?WHB1bE9CZ2VLcFl4VDNHZmJNRmlNRUZ2ZmpVTEV0R2RtWXovL1hvZEw5c1RC?=
 =?gb2312?B?MTZvQ3VVdytwZ05YcUliM2duWVVpbWV1N1NYT0pTY0tjdU5uSldDNE1RUSt0?=
 =?gb2312?B?VDlZUjJXVHRtZ3FubnJQZFpTN1VaWTUydlNWcTZobWoyLzdSUUYvamF6eDlw?=
 =?gb2312?B?SHYvODU1QjlyVlJRcTBDbG9lNlBZcDJYeXRTWks4U0xScDdaYWdYNitaR0kw?=
 =?gb2312?B?SmtLVXJ2ejZsK1pvVnl2eFBjMGM3TUhvV1BvTkRlck84K2M0N3Vpdzh3aXNp?=
 =?gb2312?B?VTZDQ1Q3eFRpNHdHVG95TGNuWnVjWTN2K2JlTXh3aXh3Y2NOS1FDYWhnS2FQ?=
 =?gb2312?B?ZEdIeFdpWFcvMW1tbitXa2sxMW4yZ2FiYjQ2a0J6ZERjbU1HY2FSZWh2UVJU?=
 =?gb2312?B?dzNCeDZ6b0lPajNaR3FYWDZlUjdkMWdzYk5yKzF5WjlJOW54cHQ0WGh3SjV4?=
 =?gb2312?B?SSs5Q3pNcG5NVUpnK3hrMk02d3NCdGlSMHZmeGpKMERUc2hWdU9BNk5yMU8r?=
 =?gb2312?B?YUZZL3YzL1NOejdKc2c2cWJkaW9YaTlUZDkzQlVub2pxbnNWOER6cGllbS9k?=
 =?gb2312?B?ZmwyVVN6TGs1YWdKMTZHK0dnTnAySHErOHprRDRrNzA3UDJOTTAxZ282bkhR?=
 =?gb2312?B?eTRnNk5TSWZ3QmtZRzliSGRta2tzUWFFaVRmTHVyekg4U1RoNDFSVWQ3djlh?=
 =?gb2312?B?dlE9PQ==?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0671.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c240878-860a-45be-a0b6-08dc600e80ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 01:17:38.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YkRuNWrex/4q4KQBRPr97bANq+n520VXlTnRqg8N81LMsZgQ2KkLckLG2t3Q+hOl2CqBsJIhIGouLahhc1OSEI+6TIVK8ah08jgs7otXJAUPOsl9eARBE5lXEE8sEG/M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0846

SGksIGRhbg0KDQo+IE9uIFRodSwgQXByIDE4LCAyMDI0IGF0IDAxOjI3OjA0QU0gKzAwMDAsIENo
YW5naHVhbmcgTGlhbmcgd3JvdGU6DQo+ID4gSGksIEhhbnMNCj4gPg0KPiA+ID4gVGhlIGNvZGUg
dG8gc2VsZWN0IGlzcF9kZXYtPmZvcm1hdHNbXSBpcyBvdmVybHkgY29tcGxpY2F0ZWQuICBXZSBj
YW4NCj4gPiA+IGp1c3QgdXNlIHRoZSAicGFkIiBhcyB0aGUgaW5kZXguICBUaGlzIHdpbGwgbWFr
aW5nIGFkZGluZyBuZXcgcGFkcw0KPiA+ID4gZWFzaWVyIGluIGZ1dHVyZSBwYXRjaGVzLiAgTm8g
ZnVuY3Rpb25hbCBjaGFuZ2UuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2hhbmdodWFu
ZyBMaWFuZyA8Y2hhbmdodWFuZy5saWFuZ0BzdGFyZml2ZXRlY2guY29tPg0KPiA+ID4gLS0tDQo+
ID4NCj4gPiBDb3VsZCB5b3UgcGxlYXNlIGhlbHAgdG8gcmV2aWV3IHRoaXMgcGF0Y2gsIHRoYW5r
cyBmb3IgeW91ciB0aW1lLg0KPiANCj4gTGludXgtbWVkaWEgdXNlcyBwYXRjaHdvcmssIHNvIHBy
b2JhYmx5IGl0IHdhcyBtaXNzZWQgYmVjYXVzZSBpdCBkaWRuJ3QgaGF2ZQ0KPiBhIFtQQVRDSF0g
aW4gdGhlIHN1YmplY3QuICBKdXN0IHJlc2VuZC4NCj4gDQoNCkJ1dCBJIGNhbiBmaW5kIGl0IGlu
IHRoZSBwYXRjaHdvcms6DQpodHRwczovL3BhdGNod29yay5saW51eHR2Lm9yZy9wcm9qZWN0L2xp
bnV4LW1lZGlhL2xpc3QvP3BhcmFtPTMmcGFnZT00DQoNCnJlZ2FyZHMsDQpDaGFuZ2h1YW5nDQo=

