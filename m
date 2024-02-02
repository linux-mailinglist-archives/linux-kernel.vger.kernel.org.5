Return-Path: <linux-kernel+bounces-49715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A0846E77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB99F1F27789
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129146214D;
	Fri,  2 Feb 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MezYQCha"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2061.outbound.protection.outlook.com [40.107.20.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19294171C2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871399; cv=fail; b=nXgVIKy4jBChq+UMqHFd3wwi+Nl2Upu+GY1Iu5MAG8eIxjHoi9K2WmMTJVYzMu+SoJfR+rx4TowybyqVkh2dAHNv2eUXV8a8WmSaRhmYEiPDZHi0RifwuHHE4x0/op0Opp42GbhFmS4pI5xD0ITKDNzFZKsQBYVH2/XjJ0uuPw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871399; c=relaxed/simple;
	bh=6IOLJwHXk9mOrfIMWqqa4jCq24JpLd+Z0S9NljOgMSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EX8shSnfcutozVMFZCIfWSfQ+XyX3WekUqmyq8K3qzxhSZYZ+sx12lXx3O99TegAZ2cEj5dxWpDlKoUTh+S1Q1HXN0wUjNSonvjBiQlgn1rHNPoSlcV7SmiQSIbg32t5KJ4Hgfj+wrrOxK1YUVKUM0mKu2UhWDkfsM8T5NOppe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MezYQCha; arc=fail smtp.client-ip=40.107.20.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZrqDI5UpVDawyHinNhWFpWLbHefsxJmIxyWWaMWoH9zC1bOukC0I4mjeSsjKzjZloHEtG4+Zuyqd0ocquPbjbpIc7ZU3rdRluf9nf1WkbjYk+478oRWp+YfG+zSpzwgz4pEUZSjVcCcDGTo9rzqTDo4YBq481HpD0UFF93Le7qANezpBa5yNkxr9B91Snped7+fPWpszRk0sXRxN0cH6EY+dryMtlMerg7uXF0jZZCvOASwmVHDihiZp2rqx5biPO2ONjMD+YQrEqvL05IukelreFy6L+nv11e/rycr5LC7CQpC+6trolJnQ5jg/3V0N8aFELctzKJpTb82nFHNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6IOLJwHXk9mOrfIMWqqa4jCq24JpLd+Z0S9NljOgMSg=;
 b=mrD7qpbgZOkguDcfujAyMbDaxqtJdt/DQSqPhz1ifsaJkpj3pf3hZTHer7OcHeBxtOVxwn6vgniiMkri24/XqovDmm7EvqTh7ikh/DhmCChg1RNjh+6GtIZDCndsBYXgA3au1Ny6//1evb+YYk/LlJixYtOY4mVRjse0xYdJkQk3xOHHI2kgTLPl0ClENbAGEPkmej6PSlU0KoIQpcGpXp0Zhs6GUHelgNTQeNjSTWB6Ztj0Ed84M28HUxxqlknnupBAVI9+xN1F54m4i3A0QEhe5Ts44LbFmLp61+JcJZN3SHsJTrDcQw/r+AYTHh8llYTvNH4hV98Nvl3QJzEaFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6IOLJwHXk9mOrfIMWqqa4jCq24JpLd+Z0S9NljOgMSg=;
 b=MezYQChao300E6kxOODip/gFRZh6tU9+bvA7G11BHtGZ14wuuKAYOdBZZ2obXZGB6QvPim6KVpnwdG7H0Jo+nmjtlwZ8s7oW5Dfmdufk+JpO8UeJ7Et9CJVIOYhMIDVfwng1rzlrx5+aMqaXXnXlEHneRpog7xo6BEw9r/k+E/A=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB8528.eurprd04.prod.outlook.com (2603:10a6:102:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 10:56:34 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 10:56:34 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Saravana Kannan <saravanak@google.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] [PATCH v2 0/3] fw_devlink overlapping cycles fix
Thread-Topic: [EXT] [PATCH v2 0/3] fw_devlink overlapping cycles fix
Thread-Index: AQHaVb4gBFvYiJORz0SPF3se+VrlObD237LA
Date: Fri, 2 Feb 2024 10:56:34 +0000
Message-ID:
 <DU2PR04MB88222DD29340CDD9FDC66DDA8C422@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240202095636.868578-1-saravanak@google.com>
In-Reply-To: <20240202095636.868578-1-saravanak@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|PAXPR04MB8528:EE_
x-ms-office365-filtering-correlation-id: d9674f86-3482-4870-9395-08dc23dd9f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tRnPQd5PxPMYGSKDv5jczhu6kjkQZVnAbWjo4u8lviUDb9A1FXe51UC8DuThg0zg41py3Z6fhYS/WFspwRbvLVjRcago3076wxCZ9IVlurnxOiwMNVU1Bp1eTzqFHHTEpEOBlcplQ2ovwUKMHZgEnH3lIHfpocynP5NrWHeiGyYiEjmqHTg3jaNSx/jPvlYt6KHd3f8Yn0dbxFPKH52EjaF/Uzs5YXhlmofp3W0oqV4tXmYqabqMZYVfPZzkLsyYK1h7TnLGlCldH+kaVDwGzauU+rnp1MHakBp4D/m/HxcMPjPYR65Ntgwa6euTM9gcwZkSpz5oifSxUoujxfkTnhVL2nmijJz4j7hAFUNUD9v3a/NrN8XbR/E261gWyvOSrTbNbblo4Odm4vgU4mutYdrIEm293M3f0YfSc3U2CrHqkWNKVk8eobOBU2qL6nb9HsFCeFU/omlDnlah4bOR/J9qPLULAGOYczNFPjcTgmsXY33ZY6LzEyl9/8HJk+kc8UzI6YNE9UEhATX3xp8F4rq7+YscE+ko6JUqKpxrX6amAmjXfSCCY0JkmU+sNGIehYIaAjSb5M8rDBzT06MFhwEvLb6UxptQ/Sn3W+Ktq4M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(122000001)(38100700002)(4744005)(5660300002)(33656002)(2906002)(38070700009)(71200400001)(6506007)(7696005)(9686003)(478600001)(83380400001)(26005)(4326008)(8936002)(8676002)(52536014)(316002)(66446008)(54906003)(66476007)(66556008)(64756008)(86362001)(76116006)(110136005)(66946007)(41300700001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MWRNYXc3SGp5ZUpUbEZTYmxLN0x1VVJoTHYrTHVyZXZuZ3lHTzhwYzBxS3pR?=
 =?utf-8?B?azN2Sm5RMEcvVG1oY1hhWWZobEpaWWV6SEdhL0tPUVdSaG5QL1NpS1hFOUsv?=
 =?utf-8?B?YjZha2wxSlhSWDNiUEF2UzJZZkUvRTV1aytmZ3lkbmJwY2tnUHhwNjNyWjZQ?=
 =?utf-8?B?a1drWnVXZDZlNGNrWC90SVR0MlNhS3dHbzVWMnVmb1hrdVV3U2I5Z2xsNXU5?=
 =?utf-8?B?cFVZSHBWYlJId2w2RXJMeFMyR1drL3ROczR5LzRsSkpMK2NlWjdJU29LdHNh?=
 =?utf-8?B?MklsNWpmYXFpaU1MT0RQbHQvSlJ0eldPdS9IRlhGVHBKdzhaOVNIZkZ1NW5r?=
 =?utf-8?B?dmZ2UmZGcnMweTR3WGpBc1ZSUEtvK2xSOWtabXovQWpOTFJBcVdIUFRpUkQ4?=
 =?utf-8?B?NGxoN2N2Um8rZ0FTb0ZrMkpUN3ovcGVPV0gyL2xRVFlBZThwTjdXaFcvaWpt?=
 =?utf-8?B?MG9DM09TWStWWkhsNmxZVnY4eXlzV2cyVS9MZGE0dmtUWndkRlB0MGtzR0Rm?=
 =?utf-8?B?ZVVObS9ZR2QzVnZ0NndpQlJ0VVpUMXdabGFKTy96VGdtb21CNjl3RitscjZR?=
 =?utf-8?B?QjY2RTBJZFF1eFZqVVpCK2ZJUTdBTUVRYVRWV1l4R1pzV1hRUDAvMkVES0R4?=
 =?utf-8?B?dmwxWGVjVEJaMmVtUGNHZFl3ZW9mSGVCeVMyc0MxMU1oNjVJaElLRUIwVG84?=
 =?utf-8?B?cVdObFN2anZmNmFUNW9rZTUxNnBWRG5QSjBMZ0lJYmd5ZnJKTmtrSC9HZzlY?=
 =?utf-8?B?WW9mTVpCTVZMTWEyaGhZV293MCtFS0pyNC8ydmtEUFYyUW1OVHNhMjdDcVY3?=
 =?utf-8?B?THVISEw5elQzVlJVWEQvcDJqK1hEYXJxZWw4WmNyck8zNytMa3dDZWJ0TWVS?=
 =?utf-8?B?c1hzZlJKWXVQZnpXTWUzRFdyanVEQmFleFdyMkREZzFoZXlXY3BjMDJEclpQ?=
 =?utf-8?B?TE55cStadnN3N2V6R2piYTVvNlZ2RnhpbU1XdWpzWW9DaDEySkNlRjkxNGpW?=
 =?utf-8?B?VkJLWXBFeFNnbFdieVpQY3RhMjk2R21aUE9tVmcvTjZiZjhMK2prVkpuR2g0?=
 =?utf-8?B?ZlhsZTBJOHRxSEpWTmU3RmpyRE9hdE9sajZMbkJRY0I0NnlnY1ovVmVRY3ZH?=
 =?utf-8?B?Zkcya3BoTXZLVjVMT1MySE9GWmdLMWhIbnNTSnhMV0UvZFBYODhidmRZQ004?=
 =?utf-8?B?ME1GMEEyZlF0K0VlR1F0MVpYclhyUVV0Um12eTNHUWlSS3lEZy95SWFZZm95?=
 =?utf-8?B?b3RlaFdldkk5aE1YS1VVZkpzclhhdlBaUGZYc2dPaVJHMks1SE9wU2cvb0J4?=
 =?utf-8?B?NE1NdnBhRHRtK3RUVytabEhlQnp6Um1NN1pnTFY3Yk9IelcvSis0T2NVdFBj?=
 =?utf-8?B?RjkvWWVwdVRWaTU0ZFdZZjZkNG9CSXJwcHpkTmJ1TFZPand0ZUxOaE9rUWZN?=
 =?utf-8?B?a3Jxc2hvamU5NjZ2V3ozZ2ZjSzMvbFJqak9jR2lqTG0zd0NVdlpJTkwvTHhw?=
 =?utf-8?B?dmpHTjViNG43NzRMYjIyQzY2UTBWZmd6aGdTM1FsTTM1bDlrZG5ObmZHS2lV?=
 =?utf-8?B?R3dGSkVVZ0FpdEtjYWF5a0NBT0gzZlR3NTlDSkZVSm1OVDQwZS9oc2ZOcGdm?=
 =?utf-8?B?THdLaFJES0lrRkFSSWlnblM4bWhsN09nM0JjKzJrNmtTTHYyOS9FNld6MklO?=
 =?utf-8?B?Z0dUM09wRVJYbWs1VkxKcmROMGNSL0JSM1V3WW1id0hXYXM1Sk9oUDZQaG5q?=
 =?utf-8?B?RVdGMDRKZjZlWkhEL0lHOThjT2hvRi8zM1R1QXcyNk16TTNoc3g3ak9wYlVk?=
 =?utf-8?B?TjJKVURXMHpzSFA3ZmFhaExIWWRQNDFBaEpNaU9ZKy85eW9mcEtTOVM1QThR?=
 =?utf-8?B?U2cyWC95aDB3Q3JvMVZsQVJ1MXJrQW5KTHA3RSt5NXNVYXdscTdWZHZickdR?=
 =?utf-8?B?REpGZlMyejc1RCtDL05kNmJ2dWJmRksyMUtqcFBZeHpIdmFNNWxLSXFVSW9h?=
 =?utf-8?B?OFU4Y0dYR1JMK2RKOFBWSnU5aWtCeEp4VWNnYVZ5Q0pNaWpNak9WQjlraGEv?=
 =?utf-8?B?aXdNYXBVV1A4YzlERjErekhDaGJRUmV3ZlphOUphSi9FcGJHVGFSOEh3U1g1?=
 =?utf-8?Q?0/z4=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9674f86-3482-4870-9395-08dc23dd9f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 10:56:34.2633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ihwOjnW+fFPipq2SEzEF0HbTNmKX5RGhdY0/B4RjXRWvbrrLXrD/Eotoe/3JUOyDlwFxck42PMvs91zihMvPUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8528

SGkgU2FyYXZhbmEsDQoNCj4gU3ViamVjdDogW0VYVF0gW1BBVENIIHYyIDAvM10gZndfZGV2bGlu
ayBvdmVybGFwcGluZyBjeWNsZXMgZml4DQo+DQo+IFRoaXMgaXMgbWFpbmx5IGEgYnVnIGZpeCB3
aXRoIGEgYWRkaXRpb25hbCBsb2dnaW5nIGltcHJvdmVtZW50LiBMb3RzIG9mDQo+IGRldGFpbHMg
aW4gUGF0Y2ggMi8zLg0KPiANCj4gR3JlZywNCj4gDQo+IENhbiB5b3UgcGxlYXNlIHB1bGwgdGhl
c2UgaW50byA2LjgtcmNYIGFmdGVyIFh1IGdpdmVzIHRoZSBUZXN0ZWQtYnk/DQo+IA0KPiBYdSwN
Cj4gDQo+IENhbiB5b3UgcGxlYXNlIHRlc3QgdGhpcyB3aG9sZSBzZXJpZXMgYW5kIGdpdmUgeW91
ciBUZXN0ZWQtYnkgaWYgaXQNCj4gZml4ZXMgeW91ciBpc3N1ZT8gQWxzbywgZnJvbSBub3cgb24s
IHRvIGRlYnVnIGN5Y2xlcyB5b3UganVzdCBuZWVkIHRvDQo+IHNlYXJjaCBmb3IgZGVidWcgbGV2
ZWwgbG9ncyB3aXRoICJjeWNsZToiIGluIHRoZSBtZXNzYWdlIGFuZCBjb252ZXJ0DQo+IHRoZW0g
YWxsIHRvIGluZm8gbGV2ZWwgbG9ncy4NCg0KT2theS4gSSBzZWUuDQoNCj4gDQo+IHYxIC0+IHYy
Og0KPiBQYXRjaCAzOiBUd2Vha2VkIHRoZSBsb2cgbWVzc2FnZXMgYW5kIHRoZSBjb21taXQgdGV4
dC4NCj4gDQo+IFNhcmF2YW5hIEthbm5hbiAoMyk6DQo+ICAgZHJpdmVyIGNvcmU6IEZpeCBkZXZp
Y2VfbGlua19mbGFnX2lzX3N5bmNfc3RhdGVfb25seSgpDQo+ICAgZHJpdmVyIGNvcmU6IGZ3X2Rl
dmxpbms6IEltcHJvdmUgZGV0ZWN0aW9uIG9mIG92ZXJsYXBwaW5nIGN5Y2xlcw0KPiAgIGRyaXZl
ciBjb3JlOiBmd19kZXZsaW5rOiBJbXByb3ZlIGxvZ3MgZm9yIGN5Y2xlIGRldGVjdGlvbg0KDQpG
b3IgdGhpcyBzZXJpZXM6DQoNClRlc3RlZC1ieTogWHUgWWFuZyA8eHUueWFuZ18yQG54cC5jb20+
DQoNClRoYW5rcywNClh1IFlhbmcNCg0K

