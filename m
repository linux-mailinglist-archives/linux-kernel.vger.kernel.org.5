Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605D6757457
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjGRGhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:37:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjGRGhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:37:39 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2115.outbound.protection.outlook.com [40.107.114.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B31B1;
        Mon, 17 Jul 2023 23:37:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F3F7OHkAdGnbvrZhnrDTdS8oVrcAHqOC7rfmnsnVTifZcpWqMurVALPuNnnQF1LwfSy24OrE4RKmG7VK92OlGw35hWmewZYYb5C4cMaTL2irc9ZdhdfgcwcEbEquHM2zLui1RX7vqfpVRgIM+LoiJFXXjjxXYhRh/N8qrVPFvxg9/odezGElzcsYL6rnbW/2GvqFGH1nVTaFNfUzwyOx8PYqOCdtRD/unbxLescUrie0bM0Ns9DFZNmQlqN8hdEfE6C74brpAxQnw7jW40J+oxVN5+zcy3pMqNfpF2Ip+Y9AMQMkIwjPOR1YaZS3Bi12Y15y2h1zXVmNxn5bJetkJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPYPtwhWpRUxUoqlc4ulV0NtaZdE/Bo3YW0/FeM/ZYY=;
 b=A2ZvoRfRJrmYxQf5lSDVt7jRCZQ8z2uAgpsQRHChoURomUd+AQwvduoxObRRssXmWZpHjhEAVka8OQnPmnbIMv336efq0GvWiyPR6ISQDU/pwsttPKV+r31zUCsazYk/yF+jalCg+Lv50mbOMrw8H9ttJIVjgPoG0MReXkygdwO6yC8MDzxcRdL5U8Dg8x68PguQ6xyEbEEAoVuWuugi8U70zGa/Nz439nSQgP0kM+Lmfj67hM1amaKvegkEMbsam46CAupE/iB2MSYGiji36GD0M0CXLMpzUYRTZeDwrqNQ6CxslVjwA44gfUJyQkcs87ldXtHsfAEsgCQiucgpcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mPYPtwhWpRUxUoqlc4ulV0NtaZdE/Bo3YW0/FeM/ZYY=;
 b=ZeuNsezzRqnT9VMGuizQaX9L0kk6jQQ8RV3PT6EWPwPpDVLsMY++NY9KDrzlTKrSOAmwe+NjGfRATaxp8AN4pI5EobiYiYn5B1U0xwy1RfJg6wQKLNbV4/uS52zkS7cLoiBKTGLBqvS9IsCkzHmK0OnuRgv3A74nv4zD9HBtE1g=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OS3PR01MB5718.jpnprd01.prod.outlook.com (2603:1096:604:c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 06:37:34 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::834b:28df:28dc:7f95%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 06:37:33 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>
Subject: RE: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH] pwm: fi pwm-rz-mtu3.c build errors
Thread-Index: AQHZuTz3JvYeSdheY0298OUyurLS6a+/ES+w
Date:   Tue, 18 Jul 2023 06:37:33 +0000
Message-ID: <OS0PR01MB5922DB58198129A9D29E91D08638A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
In-Reply-To: <8a4de6c6-8d7c-a115-2a14-d264d6d28ccf@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OS3PR01MB5718:EE_
x-ms-office365-filtering-correlation-id: 9953d8d3-cd62-4f50-60b4-08db8759778f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iRh43IjFGztjCHZt/6jk/jjlWgOW8TXzHVoR+zHkFpaakV/TmvP4cX6+89sfts1iigSaV/fGh5DAiQRIqld1lNMgsPpl0dQZWN0HiqK6PcTME0zmB1r2kc/U18mcup2U4QhkTj5KuG/od8bIMweSIGqpI5O0FzKGnnKEG9xrMIApCDA6kJAMN+4JVccU8CZFeWKuJkRWqHXrrzEfwjEjniBMPaJ+4n3QqZlhPx0Mlf3y39bUT24/OjIjZuq4j/W1KXw9XyIons89L2yUP6QyiZqQUX6z1bS+fk8+nTfqsEB7EDtiH7Ho2qXWlUbSIKx3zTlGPaVOkAUqft/FQcufT1L2+SnUWkjgpQ6CedJhCWgB1xiVrkUX23FHqIAfiIcbfGkEE2kuIfkUJ5pF9bVG2sQSSn4VdsipRAbI2Dx2WSCUSkn1e6UktUX0Fe8NeJdHGJTb+tGEdTicRMZtJWbiNT9mT0gE7IvB7Uny/8gnxbRaNGyty9Fld0N5UM9oSGPBCm/XfES2Nccw9q+IXSNTLb7F7wHPzZCNOfwRs8ThCh5Y6PaeVYNn06gcNSjnq3d9cjWmu3v9HaA4DTuGRUR6aQn0iU6fZtteuEc9Gcm5cQI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(451199021)(7696005)(6506007)(26005)(9686003)(966005)(122000001)(66574015)(83380400001)(86362001)(38070700005)(38100700002)(33656002)(186003)(55016003)(110136005)(54906003)(478600001)(41300700001)(66946007)(316002)(5660300002)(66446008)(52536014)(64756008)(76116006)(4326008)(66556008)(66476007)(8676002)(8936002)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3UrN3ozYlJWenp2dGVBRGRFWko0Vy8rTnpVL0VuOHRid2NieHM2U0FNQUph?=
 =?utf-8?B?a0s3NUZjUElYaU4yV1dyZEZBeGpKeFRqWTdXQTQ3akpuMTVncDMvSWZhV2JJ?=
 =?utf-8?B?Y0lWVGdWTkpzL0x4czV3a3ZDdU5wdDFDaXJBVFdFcE0rcU1FRXlNYmlxSmxz?=
 =?utf-8?B?bUgwOHJwaERvdzZZZDRQbmp2VmRjbnJRZjNsZ0dJeHdWeEdaVUlGYWE1MzZU?=
 =?utf-8?B?VEFrZVNNRHlSV2JFclBXcVRIODlTaW43SXZoejBHQnFKTEo3cW5FeGdWOHhx?=
 =?utf-8?B?c1VKOEpjNHVuRXpOM05vWmZjQTdWanVDTi9FckNEOHN6dHNTdmZxcVZtb0Nl?=
 =?utf-8?B?clNDY0ZsME1tNUsyZ1BmZHh3U3hGNmwzQ2gwQXpUd3pqTnY4aGhHcWQ0TFF4?=
 =?utf-8?B?UHBRWGxZbWwrbFhBcW9MMHR1aldMaGpiQ21TUG5ENHN4TE9wVWZDRUl1d2ZG?=
 =?utf-8?B?dW9BM29JRW1GSDhGY3g0cnlGUXZ5cDBsaGt5OHFQcFZlVzgwSktoYU1Eak90?=
 =?utf-8?B?NmlxUjdkbElzYkpUN0N0elNlWVEwRU5vTlBQQ2VrdXV5RW9PL05JL0dqWkR6?=
 =?utf-8?B?K3IvWDN4M2w5ZWovbktibndEQnkrVURmWk1yM1ljcCs4VGE5ZnNYU1QwaUdn?=
 =?utf-8?B?YUNsSDcycUxpTVBRMUFRRmFnMnpYSHFIVVo0OUdJVjBYQmx5eE9oOUsvSXZS?=
 =?utf-8?B?ckhHakVsUFB6cjlJRkJ2TTFZMlZBVnh0VTdrNmZYdllCK1ZaZE5kSU8rR1Rt?=
 =?utf-8?B?b0dhSThQeWUrRGJEOVFiaWN4dFczbUM1aitOVEZkYm1sUGFYOU1xbW03bnRB?=
 =?utf-8?B?YXFuMEdwV0d0UUFhS0dXVDZoVzlpM3VxenBFYlliTWFvaithQ09lUlpZSGUy?=
 =?utf-8?B?S2hhY2RCdExtdUMzeUxpUzlUUVFhL1VxdTVzMTdZQkg0bm0vOWNsRm5WWEdD?=
 =?utf-8?B?RFovVnMweE82ejJBNko3MG9nQzNMWlBhZlJoQmpCa09LbWN6UU5tMlUyWWNE?=
 =?utf-8?B?Skh3V1pxMDhLOEdhNVYxaHNYVGlKNnJJekVNaW5mc3VxZk5mS3BMK3h2elh6?=
 =?utf-8?B?S25VS2xRMmhtRzdWQnNia0RaRlZ5cTBWNVM5Yi9FZlBxOFMwZG83U3h4MDFZ?=
 =?utf-8?B?UjlTR3BGUTVVck92SmhOQ1YzcUZGRi9zR1RSdklQNldseE1wamEwUzc0MGgr?=
 =?utf-8?B?TnAzbjNta3EyQWhoMmNVQ08xR2Vud2xqM0Njd2VDL2NoNE9ieHBSSHZSeE40?=
 =?utf-8?B?bytPbGhZcXlRVUl3L3JTcFdqZFRpcTlIaytDbnY2NUU0eTJZNjg1d3U2cXlN?=
 =?utf-8?B?eVEwdDI1dDdrTXNEQ0lmVFQyR1NhS1UyZkRGbGJOUkZMRzF5RDlzaExFN0sz?=
 =?utf-8?B?aWdDRXlvWSt3bzlaK1A4SU9lem5aUm9DNXN5TmpISUtyUlJYS1RnL2EzVG1l?=
 =?utf-8?B?MC9aQU41Z2NGOENwS0hmdER0L3dqcW01V3p2Zno5ZU16bEhOMDQrTU80a2Yv?=
 =?utf-8?B?MHFqQnQ2U0c4bXlLM3RHTjZTMnFGczJQelBQNjFab0dJcnA5WVhwdUhiblJW?=
 =?utf-8?B?dFZRK0NKc3BnWkFxTjRnVENLM0k3WjBxUkZZREY3Q2g2ZWR2RllJNFcva1Nz?=
 =?utf-8?B?UThRWDNsTFRJN3dET0sydVIrZVJia0JleHprRTNxaUNnZHFPK2lnb04vQW03?=
 =?utf-8?B?MFkvK1lva0I3b0E3SVQwRnZHMTNUbW43UU1lTVVKZzVEQzNTY1lJKzYveExL?=
 =?utf-8?B?eWxramJhTkhMYlJ1U1pVdGhuby9mTWNZY3ZsNmJtMnVuUytuT2ZqdkJ0VGp1?=
 =?utf-8?B?M3dnb01GRzAzOUFaMitLUEVTWUw4ZW5hSXEzYTdMRk5ScW9GVmVMQ2JSV3hJ?=
 =?utf-8?B?aXAyUHNUZExIK1U4Q3VIUXlkTXZJMTYwK2NqcWtBTkRXbjZFOTZudDJDUzhT?=
 =?utf-8?B?dHZQazBxR2xBNUhPdmp4L1hzSHl1VXJpUktSZ3RPek1wN0h1SmhkS3hraGJG?=
 =?utf-8?B?VmZhbmp1SmhFN1Z4Q1lFMlJKRHRoVk9kZjF6WGtCYVNMVXVMbnY2MVNZN0Ri?=
 =?utf-8?B?MWtyazd5VUJpeWxGWWN1MmozQlhyQ2FsS3JTMytRWHlmbXlPaGZBcHN1ZURa?=
 =?utf-8?Q?+kgAKNvvZ9jZlyjM6aKJeDQzd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9953d8d3-cd62-4f50-60b4-08db8759778f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 06:37:33.0725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoziwlPKo3Cs05sKEWgMs+/W6+V4ttls4SVlBINTzq9MqRWe792nhSqwIKBbxooGHmmV8R1dgJym19K5usyOHxBGpcosiIWW8K0jmI817l0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5718
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHkgRHVubGFwLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0
OiBbUEFUQ0hdIHB3bTogZmkgcHdtLXJ6LW10dTMuYyBidWlsZCBlcnJvcnMNCj4gDQo+IEZyb206
IFJhbmR5IER1bmxhcCA8cmR1bmxhcEBpbmZyYWRlYWQub3JnPg0KPiANCj4gV2hlbiAoTUZEKSBS
Wl9NVFUzPW0gYW5kIFBXTV9SWl9NVFUzPXksIHRoZXJlIGFyZSBudW1lcm91cyBidWlsZCBlcnJv
cnM6DQoNClJlY2VudGx5IGFkZGVkIG1vZHVsZSBzdXBwb3J0IGZvciBSWl9NVFUzWzFdLiBpZSwg
YWZ0ZXIgYWRkaW5nIFBXTSBzdXBwb3J0LiANCg0KWzFdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcv
cHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9oPW5l
eHQtMjAyMzA3MTgmaWQ9YjhiMjhiNzE4ZGRkNTZlNTQ2ZDQ0MTA3Y2Y3YzU3ZjNhMDdkN2VmZA0K
DQo+IA0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fY29uZmlnJzoN
Cj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzozNzQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8g
YHJ6X210dTNfZGlzYWJsZScNCj4gbGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6Mzc3OiB1
bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzXzhiaXRfY2hfd3JpdGUnDQo+IGxkOiB2
bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV93cml0ZV90Z3JfcmVnaXN0ZXJzJzoN
Cj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoxMTA6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8N
Cj4gYHJ6X210dTNfMTZiaXRfY2hfd3JpdGUnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9u
IGByel9tdHUzX3B3bV9jb25maWcnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjM4Mjog
dW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M184Yml0X2NoX3dyaXRlJw0KPiBsZDog
dm1saW51eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fd3JpdGVfdGdyX3JlZ2lzdGVycyc6
DQo+IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MTEwOiB1bmRlZmluZWQgcmVmZXJlbmNlIHRv
DQo+IGByel9tdHUzXzE2Yml0X2NoX3dyaXRlJw0KPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10
dTMuYzoxMTE6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hfd3Jp
dGUnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9jb25maWcnOg0K
PiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjM5NzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0byBg
cnpfbXR1M19lbmFibGUnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3
bV9kaXNhYmxlJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyNTk6IHVuZGVmaW5lZCBy
ZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfOGJpdF9jaF93cml0ZScNCj4gbGQ6IGRyaXZlcnMvcHdt
L3B3bS1yei1tdHUzLmM6MjY0OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvDQo+IGByel9tdHUzX2Rp
c2FibGUnDQo+IGxkOiB2bWxpbnV4Lm86IGluIGZ1bmN0aW9uIGByel9tdHUzX3B3bV9lbmFibGUn
Og0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5jOjIzMDogdW5kZWZpbmVkIHJlZmVyZW5jZSB0
bw0KPiBgcnpfbXR1M184Yml0X2NoX3dyaXRlJw0KPiBsZDogZHJpdmVycy9wd20vcHdtLXJ6LW10
dTMuYzoyMzQ6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfOGJpdF9jaF93cml0
ZScNCj4gbGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MjM4OiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvDQo+IGByel9tdHUzX2VuYWJsZScNCj4gbGQ6IHZtbGludXgubzogaW4gZnVuY3Rpb24g
YHJ6X210dTNfcHdtX2lzX2NoX2VuYWJsZWQnOg0KPiBkcml2ZXJzL3B3bS9wd20tcnotbXR1My5j
OjE1NTogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M19pc19lbmFibGVkJw0KPiBs
ZDogZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoxNjI6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8N
Cj4gYHJ6X210dTNfOGJpdF9jaF9yZWFkJw0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBg
cnpfbXR1M19wd21fcmVhZF90Z3JfcmVnaXN0ZXJzJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6LW10
dTMuYzoxMDI6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8NCj4gYHJ6X210dTNfMTZiaXRfY2hfcmVh
ZCcNCj4gbGQ6IGRyaXZlcnMvcHdtL3B3bS1yei1tdHUzLmM6MTAyOiB1bmRlZmluZWQgcmVmZXJl
bmNlIHRvDQo+IGByel9tdHUzXzE2Yml0X2NoX3JlYWQnDQo+IGxkOiBkcml2ZXJzL3B3bS9wd20t
cnotbXR1My5jOjEwMzogdW5kZWZpbmVkIHJlZmVyZW5jZSB0bw0KPiBgcnpfbXR1M18xNmJpdF9j
aF9yZWFkJw0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlvbiBgcnpfbXR1M19wd21fZ2V0X3N0
YXRlJzoNCj4gZHJpdmVycy9wd20vcHdtLXJ6LW10dTMuYzoyOTY6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8NCj4gYHJ6X210dTNfOGJpdF9jaF9yZWFkJw0KPiANCj4gTW9kaWZ5IHRoZSBkZXBlbmRl
bmNpZXMgb2YgUFdNX1JaX01UVTMgc28gdGhhdCBDT01QSUxFX1RFU1QgaXMgc3RpbGwNCj4gYWxs
b3dlZCBidXQgUFdNX1JaX01UVTMgZGVwZW5kcyBvbiBSWl9NVFUzIGlmIGl0IGlzIGJlaW5nIGJ1
aWx0IGJ1dCBhbHNvDQo+IGFsbG93IHRoZSBsYXR0ZXIgbm90IHRvIGJlIGJ1aWx0Lg0KPiANCj4g
Rml4ZXM6IDI1NGQzYTcyNzQyMSAoInB3bTogQWRkIFJlbmVzYXMgUlovRzJMIE1UVTNhIFBXTSBk
cml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFk
Lm9yZz4NCj4gQ2M6IEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gQ2M6
IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXguZGU+DQo+IENj
OiBUaGllcnJ5IFJlZGluZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPg0KPiBDYzogbGludXgt
cHdtQHZnZXIua2VybmVsLm9yZw0KDQpSZXZpZXdlZC1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6
QGJwLnJlbmVzYXMuY29tPg0KDQpDaGVlcnMsDQpCaWp1DQoNCj4gLS0tDQo+ICBkcml2ZXJzL3B3
bS9LY29uZmlnIHwgICAgMyArKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS0gYS9kcml2ZXJzL3B3bS9LY29uZmlnIGIvZHJp
dmVycy9wd20vS2NvbmZpZw0KPiAtLS0gYS9kcml2ZXJzL3B3bS9LY29uZmlnDQo+ICsrKyBiL2Ry
aXZlcnMvcHdtL0tjb25maWcNCj4gQEAgLTUwNSw3ICs1MDUsOCBAQCBjb25maWcgUFdNX1JPQ0tD
SElQDQo+IA0KPiAgY29uZmlnIFBXTV9SWl9NVFUzDQo+ICAJdHJpc3RhdGUgIlJlbmVzYXMgUlov
RzJMIE1UVTNhIFBXTSBUaW1lciBzdXBwb3J0Ig0KPiAtCWRlcGVuZHMgb24gUlpfTVRVMyB8fCBD
T01QSUxFX1RFU1QNCj4gKwlkZXBlbmRzIG9uIENPTVBJTEVfVEVTVA0KPiArCWRlcGVuZHMgb24g
UlpfTVRVMyB8fCBSWl9NVFUzPW4NCj4gIAlkZXBlbmRzIG9uIEhBU19JT01FTQ0KPiAgCWhlbHAN
Cj4gIAkgIFRoaXMgZHJpdmVyIGV4cG9zZXMgdGhlIE1UVTNhIFBXTSBUaW1lciBjb250cm9sbGVy
IGZvdW5kIGluDQo+IFJlbmVzYXMNCg==
