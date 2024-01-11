Return-Path: <linux-kernel+bounces-23606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B6782AEFB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1798B1F22672
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395FD15E85;
	Thu, 11 Jan 2024 12:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="EI5VL3Eh"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2083.outbound.protection.outlook.com [40.107.12.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB3F15AF6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjovgxDq41DghF5vXuFp93nGSRitgEJTaXalk5TQLZRAM66sljzESGop1Zb4ClKF+vFl+CTGL0xbc6TS9kjyrH5wit2gsrlAZTLGBmmxAG0RQ9swkoeGLAIvkeKlf0DV/kw008Q3jpz1YvEquXEJvoAd5Ca1Wwc2lOAX1B2j875BV9r90qHZJVSwYsrw4pEHwEITw2Cp9iDPZ19v2TlmH7+HjtjOcdU/0rTjvIMZLYS9pri13HTiNgFG912tDdJa9SDzWxBu78s0h8Zqn6GRgH3EzmHl4n/QJdfH3LypbctRWd/UPjNLN+iI1slNQlLhAHRQ9BOXAfnTXH6Lk7t3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+NWK+wVQCyxmd802t6v93nT7tYjiz3menIJsGdtKwE=;
 b=mB4n+C6TcxP92w+50CTdToY/0sS4LIGiFry7pLUucCRA44hoZNZ9wJukn25Tp4a6SdnizBS/aGyRU7dcb5vSeCZsprvdSR+SN13ejp3vAhoHE0HaSRlwW7N/W2D9d4kk5AeNvt8O4emKYjNLJ9vHWckUuZIEZTN6p1ZCQVyXwoQuBMVtB/RtnQbjygaKZGrBdgEyWozYO2rmCIyNaoCzUaFXFJOyAPZtHJ8mOEwhBsQJIKCjlYD/l8VV9WAcnC8NROHxR1c1yuVICzhaDZHg148zN2GIVSGAv1zqHqNGrYfneCjGuxRBsjMOkcb6rSeJPvN9HS9L77T8jx/To2Sz8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+NWK+wVQCyxmd802t6v93nT7tYjiz3menIJsGdtKwE=;
 b=EI5VL3Ehhn1jjDQRcxYsgl2F+08hthCiBsilMiD0a92Y0mL9y3OcFgsRvEao71Mg3KXcvJyTianhbBNTsUZiYpJkLrv2yV44h7JV2QfuVMBX6DYJ0rT5J15E6r9qmla3gFFmc55TQ5b5idQBuHKHTDO59XojPWPzWCsu4xqxykFkdUUsE61BA9UmgBroe9af0hpFrOoxFoyOsjv9GzWJzV4RXU1WEBGLiZgQphhuR6orCTfAYCjh2gxgQ0lmYtAGmkPW9vskd98MqxbniGJVYVa4CPkLYAcjIRuNjEYe7xtuwdOH7wjLhZ2o2y6FHUGu1+uzfH1W84+Z9F7lGdZ8Ow==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2938.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:19::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 12:51:20 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f788:32b4:1c5e:f264]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::f788:32b4:1c5e:f264%7]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 12:51:20 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Zhiguo Jiang <justinjiang@vivo.com>, Andrew Morton
	<akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, Matthew
 Wilcox <willy@infradead.org>, Chris Li <chrisl@kernel.org>, Michal Hocko
	<mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Dan Schatzberg
	<schatzberg.dan@gmail.com>, Yosry Ahmed <yosryahmed@google.com>, Yue Zhao
	<findns94@gmail.com>, Hugh Dickins <hughd@google.com>, Johannes Weiner
	<hannes@cmpxchg.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
CC: "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: Re: [PATCH v1 0/2] *** SUBJECT HERE ***
Thread-Topic: [PATCH v1 0/2] *** SUBJECT HERE ***
Thread-Index: AQHaRIk/IAYlSLS+xUGTysOozCzF+LDUkKuA
Date: Thu, 11 Jan 2024 12:51:20 +0000
Message-ID: <92413d27-6a66-4868-bf94-b736c0c88ee3@csgroup.eu>
References: <20240111122451.682-1-justinjiang@vivo.com>
In-Reply-To: <20240111122451.682-1-justinjiang@vivo.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2938:EE_
x-ms-office365-filtering-correlation-id: a5de65e0-bbf4-4308-6cb8-08dc12a4026f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1LLdz0J8oG+8lHCijmCZibDA/Mc/5pwtlUEmbzibvXtfsI/870O5a5Ase2UKPdLK0PFzv/h/gvyjtRD88ENJYJtnVZDpqshhr0ZYiOoViim0umSsFartlSKd09BQDvag0I8B2CPVs+YL6Hy2rRF9r5Rz3qxHY9pFNRdnrLeX2YDCFmtvkFWIIc9v20hjklS2/JGG7Ur01bhGSDKWSa2KfukYxsq4zxljyqo/jYgVTpy/bL4ZdsMjImSIEzfIIOqvE3xSZPg1TViMQtYzdXncidSFDT+AaXOAQQJwzXtUEtU+G/2Nn8XyDMfMDi7/hIbTt8KC+O8sRq6M6bj9Jz3dl+KJevA7BYqHYvW0rq/E1TmdmGJToy9RWwsa0bkzAW/+Es2PRRSynlEW6A7NoGT4uB0HAPlKvpjrohe9NXEqv/sP5fmHmG21bsn8YMxKG4sBbp+Sk/XajDitWDai6kfs1C0vJ+2nM05ZDgwlxmiTZ9s/kI7DatgcgY0AFYV2TsbeHuZz3pF8oZC1yJqKxgKhdjwH2GQ30jsuDeP6oKsYbXydUzlkE+rVkxPYtQ4ZJhDXYrSUemEvIsLrSV9dxQ26a3hpmbD7ULsUBCN8pdytiO1UEiWNm95ZA6kyLVSVPpe9r+4N2QMynbpNXGAgCnN+Jb3/e8kGtfTNyatcWMQIf4QOdiBOYdaIna7zFmNg/BpPZgkxw1T9usOr4GET15ttRA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39850400004)(346002)(376002)(136003)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38070700009)(316002)(8676002)(8936002)(2906002)(7416002)(4744005)(921011)(5660300002)(122000001)(38100700002)(44832011)(4326008)(31686004)(83380400001)(6506007)(6486002)(2616005)(478600001)(966005)(26005)(71200400001)(66476007)(66574015)(41300700001)(66946007)(66556008)(76116006)(66446008)(64756008)(86362001)(31696002)(110136005)(6512007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b1ZKNW1GYVNFcFdDaytoMlNrV2FvZFp6OWcwK2F5T0Rqa0R1NEJEZTZUcmhk?=
 =?utf-8?B?c0JwT1F2NXNuK3NxdmVqeDNGb2V1OTBEVmZmRHNNNHlKUVZXRHlKV0toc01C?=
 =?utf-8?B?YWtoMEF5eUovdGJNbjFZQXQ0aDVJUUlrUC8rcjc1V3BVRUJ6eXE2aWFaeXly?=
 =?utf-8?B?UWVVNzN0YVI5aUFGeVFSUnFyelZ4VkwzN29SOXBJRjV6WGdHRzhOQW52eGZ2?=
 =?utf-8?B?eG9KRnpQQS80elZPaEtVclBnQyswMkt6c2daRU1RQ2pTWXlKbWIwQnlEdGtY?=
 =?utf-8?B?ZGhOeTgzNFA2K3l6cEduanE4YTlWeHowNWFhZW1VL3NDbUZ0NFpYZDhxaDcx?=
 =?utf-8?B?Y3N2TkwxSE4xa3hGMHZRWHp0My9rRVp4UW94RWNUWk1lNnJrT3hCU01NRGNP?=
 =?utf-8?B?ZUhsbC9uaFNVSkVoRjRZNkhveThqZkZ2NDBJd3k1UWFpbDBnQkVqbXRBaksx?=
 =?utf-8?B?WW5oZU8zWm9NMVhnbEJ0eC9ocDVHSU02QmJEKzF1Tk9VUThXNWJYcm54cEpx?=
 =?utf-8?B?d2kwbXNTanJUbUhSamEyODhBZkdNTUhzSHBLMjc1M3IzbWdtdGlZejJQSGFt?=
 =?utf-8?B?cWFERHVZay8wdkxNM29LaFVNRGp3bkdxYUNZb2xLcEtMZVc3SjVCbjFpSTJY?=
 =?utf-8?B?dkxnTXdjVEpNcXA2S0F6dFBUMGltZmlKTkRpaGN4RExydkJ6NWRtVytIRmNi?=
 =?utf-8?B?ZmFja2JtSWpRTlVYOHBlQTg2dDhWTVdEeDFzOG1kbGdVMkUxekVsN0tSVFNZ?=
 =?utf-8?B?UGllUmlmS2xEclQ2ZVg4bENNaDdCZk9DeWJSdGRnejJxYTBZZUM5SFFQTkp0?=
 =?utf-8?B?bGRvU1VtTWtlazUxNXNzVVdmazVOa2h5dUNvTlZ5M1FXSlFDaWg5Ymd2QzVK?=
 =?utf-8?B?SlFwdEpuOXB0V2JUaUhWZC9hNDEzd05BZURpaFRpSE9tdGRJVVhaMXN1SUpY?=
 =?utf-8?B?LzBUVW9OaXpNYkl0dXVrZHlTeEZ0NVg4Y3ZBaEZQaTZkUnA5MEo1MzhFUkZ3?=
 =?utf-8?B?NXp6a2Jyc29OU2xJV1AxdmNLSjM1MlNMbFJWU09sQ3lVVVVCVndwejg3eHVx?=
 =?utf-8?B?U2NyZ2U1TVg5NE5tbnlDV2QvSVF4enV0Kzh4UDNqYzRPK3c4QmdMamcyT3Bj?=
 =?utf-8?B?dHd1VUp3TmNNSEwrMERLZlRVQTVjN01EMU1hc0RBSk1wbFU2MUFjYnp1U3Z3?=
 =?utf-8?B?YzFveHRYWHFGTlRmbnNlZURBMDZPVjlrb1ZzK0JiTHBXei9scG9vcUt4NUtq?=
 =?utf-8?B?QnRPWDlQakNSNlgxNE9TWnkxSnZwRmRMc1FVS25lelZZV25WcUhVOTZ0WHZN?=
 =?utf-8?B?enY2YVNLNE1ST2RvbnQwYzdJWU1Yd0FnZFREeG5yL2J4OEVZQ2JCM2JBUERC?=
 =?utf-8?B?QWRQcmI3c2pKZ0t5eDVRN1c4TlQzTVBTVDJHbzd6MVk4TnlJY3BtVkxXRXUv?=
 =?utf-8?B?dHlyUTVaajVjcjNBUTY0aWo4eThSa1NHRnhFWUh1dS8vclhWeEZTNFJlQjgx?=
 =?utf-8?B?dnppMlg5bmhrSFdwYnltN0diVU5uVGt2RVlGUUI5emIzUDNkeDhkcU9mcmtK?=
 =?utf-8?B?VXlha3F3UHBpRVQzdDM3YXJPa1dETEJtTDRUNm5DUWJoQWVUT2JuOWsvTURS?=
 =?utf-8?B?bHpFcVFZVXA2djUrdjRWMm5uUXEvZFMyRW9ZdXlLZVhncjRTc0REdGNxMnNO?=
 =?utf-8?B?b1oxdnRwRmNPb1J4T21JTFFWSzdlVC82WlJneWljei9wL3VRcUs4dDhUMkQ4?=
 =?utf-8?B?cm0zZHlZem8wenJJZHJlNG9DVnpqenhrN1AyQjZGQzRqMlFqQkJCT0JEUVkx?=
 =?utf-8?B?VFpiSTlDSS9SNFRNUTVNVC8wZVlLWnUwWTRIaXo1emk0cWFNU0FYYmdGS3RT?=
 =?utf-8?B?dGU0ZFdBNkdXMmtvNy80cmVxZU4xbzBYWGFHU1N1TEFpUU42cTZlSWhQVEpX?=
 =?utf-8?B?NWZaa1pJRExjU0NQOVREaCs2bWZEeHRyVXZGT1RGaVN3RjczbS9sb25SNmc1?=
 =?utf-8?B?RnhZVU5FZFIzY3h1MytWZUxzTHFGR1JYYk0vbkIxTFNiWjVIaG5LV1JJSW95?=
 =?utf-8?B?YmlVYjZWb3RQNkUxU0U0MkVnVjNVVlJnU1RuV3hhRFY1dVUzenBMN0x0dWNC?=
 =?utf-8?Q?/L6MPF9r4Wb0OOU0xZHhDnV9m?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21AE34600178794E8875B1F5B276C02D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a5de65e0-bbf4-4308-6cb8-08dc12a4026f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 12:51:20.4514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gsWGy6TNzbEjeoqzAfPMT+QUt/4YWmwC2iZ6M5d4lOjBJxLpeIsOXr3Y7uKwE7kY92dl1S8/ukUi7M8E/lSomWjAebxkBjCmPhknHBnmYes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2938

DQoNCkxlIDExLzAxLzIwMjQgw6AgMTM6MjQsIFpoaWd1byBKaWFuZyBhIMOpY3JpdMKgOg0KPiBb
Vm91cyBuZSByZWNldmV6IHBhcyBzb3V2ZW50IGRlIGNvdXJyaWVycyBkZSBqdXN0aW5qaWFuZ0B2
aXZvLmNvbS4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6AgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+ICoqKiBCTFVS
QiBIRVJFICoqKg0KDQpZb3UgZm9yZ290IHRvIGZpbGwtaW4gdGhlIGNvdmVyIGxldHRlciBpdCBz
ZWVtcy4NCg0KQ2hyaXN0b3BoZQ0KDQoNCj4gDQo+IFpoaWd1byBKaWFuZyAoMik6DQo+ICAgIG1t
OnZtc2NhbjogZml4IHdvcmtpbmdzZXQgZXZpY3Rpb24gbWVtY2cgaXNzdWUNCj4gICAgbW06dm1z
Y2FuOiBmaXggc2hyaW5rIHNjIHBhcmFtZXRlcnMgaXNzdWUNCj4gDQo+ICAgaW5jbHVkZS9saW51
eC9zd2FwLmggfCAgMiArLQ0KPiAgIG1tL3Ztc2Nhbi5jICAgICAgICAgIHwgNDYgKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gICBtbS93b3JraW5nc2V0LmMg
ICAgICB8ICA2ICsrKy0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwg
MjcgZGVsZXRpb25zKC0pDQo+ICAgbW9kZSBjaGFuZ2UgMTAwNjQ0ID0+IDEwMDc1NSBpbmNsdWRl
L2xpbnV4L3N3YXAuaA0KPiAgIG1vZGUgY2hhbmdlIDEwMDY0NCA9PiAxMDA3NTUgbW0vdm1zY2Fu
LmMNCj4gICBtb2RlIGNoYW5nZSAxMDA2NDQgPT4gMTAwNzU1IG1tL3dvcmtpbmdzZXQuYw0KPiAN
Cj4gLS0NCj4gMi4zOS4wDQo+IA0KPiANCg==

