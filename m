Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A35D7B1EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbjI1Nvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 09:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjI1Nvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 09:51:48 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2100.outbound.protection.outlook.com [40.107.114.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644E911F;
        Thu, 28 Sep 2023 06:51:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBBd4rnL/Iz9IuA/Sgf7NtkQaf8yrG8ObZ63s7OVHjtx8uhK6kxWcxhqjpQcNp9/RWs+TST/46wTNgERkVfvpGe0v71tDnRVOWdZ0dAEHDCMBHHM21+vlfY6R5Fc7BszlE49DciLAPyoRHPv3SnBb2bOc7x1TK/DJ1sjj8L/ecXizQLD6kxzgLZrBxKcToBKD1w+LnIaWnaswctzK6SOBRXL+4BOLTWUycnAz5FoKZEUUVXTUwhRctlrynBZTbrn/vnp+i8Ju+SGteLbwcZRpnHAw/8jEpcLUTmZBkwTcwvw4O5Gl+SDugOyjl9KIQikvxEZ6j9VE1ntjDC/ks8Adw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHCnkf93ItlK3RA7MplDjUW2SzGj3D8FJCmhRMCv9w8=;
 b=kGPOIbreo/XzId6/9X8Xsll/pS8D68CZGvwVnO1qQEHO6280h59y274A2Km2equrxrTynJJhiEpJ9OX9aJYxgGfgRaYHyzek/VIjw0939iUhSuLywAV2KZCJ9CWckBssEG/NEJGmYTm8yfbZhBGGCgYLx01q0+RfFxB8qaVEaKsT6BDTl+CvDQJimZhLhHi1ICVQ2Sa9VrCOGhoyHP+ae/nlSs7dORNn/UZ0hVMG4glgJA9AJk6AF5vNnX3zw72Ui23HhZGVumKNdMs/ChkDQ3rQCA2WqU+ehliOP1ny+ETLt1j8fcu3Z2dKwskBGa/4CdoZizCt9pXe1VOHuPQtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHCnkf93ItlK3RA7MplDjUW2SzGj3D8FJCmhRMCv9w8=;
 b=VogHJ0l6CNW9JmB3w/2edz9pH1PK8oKodr83T9UO9rWHbLD3ZkU/fniSX/7bnKxKw6qdxfsv08+wbh64i2jEk6AvqVgcP1a4GWmEqREFsVG3oRRVqrQPak8AB9CmN3agdi7nGsffEN1KhX672jnpWxn12uZWxBnSBZU6qRK4Saw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9778.jpnprd01.prod.outlook.com (2603:1096:400:22f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.23; Thu, 28 Sep
 2023 13:51:40 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.024; Thu, 28 Sep 2023
 13:51:40 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Pavel Machek <pavel@ucw.cz>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: RE: [PATCH v2 1/2] leds: pca955x: Convert enum->pointer for data in
 the match tables
Thread-Topic: [PATCH v2 1/2] leds: pca955x: Convert enum->pointer for data in
 the match tables
Thread-Index: AQHZ7kIezxUJgmui7E22MmV6eJeaNLArJT+AgAUiAACAAAHEkA==
Date:   Thu, 28 Sep 2023 13:51:40 +0000
Message-ID: <OS0PR01MB5922F521B9FBBE7EA0D0646D86C1A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230923171921.53503-1-biju.das.jz@bp.renesas.com>
 <20230923171921.53503-2-biju.das.jz@bp.renesas.com>
 <ZRE08RkhG2C+Pi3l@smile.fi.intel.com> <20230928134420.GK9999@google.com>
In-Reply-To: <20230928134420.GK9999@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9778:EE_
x-ms-office365-filtering-correlation-id: 47b72b64-da6b-4983-e179-08dbc02a0ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LtTsyueQ0KsaAYlgDy3c2lcnR0NcPZAkatTmYhJop871sCnaFf3H+z94NydhNbQgZvdlY05NL17KYPKEFhfxtfgE9ILDICIv8rHIIrMGZIoaY/g0QLyaLDBG11srBUcv7cUSaAF5YLEipeUgbRfxN/HrNVOTnNk1u45+NcozYYzHgvQBdm8kX1l7qxrgo/ZHBmooBLEUjxgMlIa61s+5dwJ7pcx5x7+hlCGo7JbQWOwvDqMW6S7/1aQdV+IXXaFCMLARqTtXoXFm/iMBdXFHMechV5doe43zlmcoUKJIpylhLrxUMCbpxzcY5d5Tvvi6vYpIGzF2IV5sw2zfiWHJKXFsJCy4wkz3NKl1Xel5w+WzsnGMv6wlwNKuCc2LeEFj6a1LZxF62hPemTIs5PsLntTi0oqVjkVkFZH9GZ6KmjaRMoK3Kmg7c8Nur7CXWOwnGpxgeUUpBTyWe8fBiVGdFrK2wTBNpYWMYk7Bvl8TThsL+qNoeQ2g+70Nrp8bUmAlB/xCE20UCcpi9qyXf5ktO9FDg/p0kjn6eonP9+uIpHIw7pGdKj1gy9STOEMRBLPIR6pvRZYRQY3mNbJ+vbUqFLC3bOCQHhTiVTPjt0tcA0dpGNK2TJiu58EADJJr+Ahv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(2906002)(4326008)(52536014)(41300700001)(316002)(8676002)(8936002)(5660300002)(55016003)(66946007)(66446008)(66476007)(66556008)(54906003)(110136005)(33656002)(64756008)(478600001)(86362001)(76116006)(6506007)(7696005)(71200400001)(53546011)(9686003)(38100700002)(38070700005)(122000001)(26005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1JRVE0vd3M4QTU4cW5qdUp2MjdPcGo0R1VYVldJQTBJQWtvbVE3bndLMDZS?=
 =?utf-8?B?bkNDNkVrYjYxSlA4QWRaNitOOXFNeXV1NlN5OXMxVE5Edm40WmtXTVpKdVVu?=
 =?utf-8?B?d0lxZ25tbC9jSFRYcGJCVzBFZk5Ga1NHOWEzZVZlM0lzL3U3bEh4d3ZSSUxP?=
 =?utf-8?B?Q3lEY2FZTmlhbk94aVdsTjcra0ZXNzNMT0YzVVJuZ2FudnRmMW1WUkRoUlh5?=
 =?utf-8?B?NmczTGpyMVNra25Scjlma1owdmJHV0tyR2RUOHRBalU3MldFWWhTa3RQSWR4?=
 =?utf-8?B?UFpUZGlPRkxsTmZJdnVWMVM2d3lHOFRHaGQ1b1V3THZlcllNcEtWT09XM29O?=
 =?utf-8?B?blUwaVR1Y3phVmpnR0NIT1lhUFhSa0dSeDJkTmRNK0FyOWZIUFNVbm9qcHM2?=
 =?utf-8?B?QVVBTG9sUWhIOGQxeVRTOVEzZHhvekl5eWM5NmovZFNLRFNHU0FnMFpOY3Q5?=
 =?utf-8?B?RzdyaXhqbUsxZ2hXMUwwVVZrdTBGQmwvMGhNQWxpY2xxem0xcTVrbktTSmJw?=
 =?utf-8?B?bGZLb3I1aml3NG55ZXB0SkhoVHcwRkJRMmxkSDE2K1JYOERrNjJaU0xjN0Za?=
 =?utf-8?B?eC80bFdVeVY1cXNnY2JNVzc0NEVRbFdOdStTYXBRcFBYbWwxaHJTbDU4U3Ja?=
 =?utf-8?B?L29TUnA3cE1Ma0NNZjRTYjB2aEpydGJTN2YwcVBNMStqM1BaN3F2VnR5TjM4?=
 =?utf-8?B?Mkt1U2dFbmF3VkZoMm9xaEpPRTF2Z3p2blJSVUNxM0UxQzVGZmhCM3hOandl?=
 =?utf-8?B?UitnbGpvdkZYeXMvcGN4elEvSzFNdDAyNmJYSWNuOE5wL3lqYVZ6WSs2WnZ1?=
 =?utf-8?B?K0hqNk1OZTd3ZzZHVGtDdlpGKzZCQWMyMVlsY2tSN0Y2NkdydE5BT25CWFVJ?=
 =?utf-8?B?ajY5SWp1S3BPM1RKeXNhWDY4enl3S1pGUyt0RTBuWmgrbThqUmhWTjhVSld4?=
 =?utf-8?B?Mml1eGVWWGM1R0NUWVhHSXFmTXJic29uUHFSSWp3M0JDcURSTCtCN3A0WXEz?=
 =?utf-8?B?M1Z2ZEJuV2loSHJReUZEZ2ZzbG13U3E5Q01VTWdGMFQ3OGZXUVdzaXFOd1JW?=
 =?utf-8?B?WjAxdHA5Q20vTU5iaXhONWhRdTNOQjVMMWswVTdJbWo2NHpxd3VmSjN4a2RD?=
 =?utf-8?B?WFFPMFQyWEtUeWpjRCtTY1J1cTJvZUdwWi9NY0RHNXhmS1p1VE1YZ3VEdU1I?=
 =?utf-8?B?M1Jpc0hMcWxCYmU2aFFlNEw4UUFheHhZd3hVWUJ3Y2JvdjcraXdGNEpmc2cw?=
 =?utf-8?B?a005TmU2ZlgxVnVldWtFbXZUL284aER2YzJWY0wxOVVNMmJBMU9wRVJ5dEIv?=
 =?utf-8?B?bFBhZWJDSXdhNzRlMHM2QWYzVTFVZHZEZ1Z6NzN6RjN4dXQ5RHg4cCtuWXdl?=
 =?utf-8?B?N2dzd1pqRmxqZmNEaG9CM0RhVUlzc2dBK1Z0WlVZeS9kOXdNd3IwTW1KeUp0?=
 =?utf-8?B?dU5jSmxUYzFHRWFkQ09yYWczVi94cEVRNWhqcmY4WkZLdGVONHk1S3poTW5n?=
 =?utf-8?B?QXpHbmFIM09ubEhJSFAwd24rbzRNVkpCRm9lc05sTEI2d0t5TU8rMjFIblhJ?=
 =?utf-8?B?ZDlNeUttWkxPSjJhRUZPLy8reGtib2R5R1VlaXFlQnVyRTRjVVdnd0JLdlB0?=
 =?utf-8?B?S2MvOWNBK2lSckpwT0NQRVFzTHpabG1sUEJnd0tQKzlQMUxGdnRwUEg0cXNV?=
 =?utf-8?B?MWlwOUZhcXN4NHg4MlVXMnpmL0ZuRkNxd3lzait4cG4yTlpOS2M0T1BCMkM5?=
 =?utf-8?B?R2J0azg2c0JqeWpreWE3dDlIb3FxVzFmTFNqM1RveGZpdWFGZnkwZlBUSERD?=
 =?utf-8?B?MzNrcFBZalJ2eDFEYlZ2NXNJUWVuQTNGcHR6Y2hDZFIyWk80enRDL3FJdVNH?=
 =?utf-8?B?S1J2SHMwNmRBdSs3N1lhOElIMVNsNk9obVYvQ2Y3bVlGbHFGZGRtN2tUNld6?=
 =?utf-8?B?c2xpK1laaEk1cGd6bUdqYjFCN0oyckp2WTRxRVNlbWRjN0RjL3dSUk5DYktV?=
 =?utf-8?B?cUlheTBVMjM0Vk9nQ1E2R3pZbjB3aTI3d0JNWWl2aW5QZkV4aVd6STFma1Fp?=
 =?utf-8?B?OUNkZytQQzF5N3loVlZWSmxwT3ZoOXJvZmNtK1c3ME9rM25UKzhCcWwzR3ZZ?=
 =?utf-8?B?WlFlRWp6VmExWkdVOThNa3RnZUtJejB6VzR4MlVlaEF4WXZVMnNONGZDTUpE?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47b72b64-da6b-4983-e179-08dbc02a0ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2023 13:51:40.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dEqnacE+wC8hUeQQptxrxONNWQgbFuX/wiEKqI89WK7ieDBROmv7mYkqJ1aZQXzEeWUJn2VKdZg415qmVU3HOeGtluGy8LxIOCkNN1Mx/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9778
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlIEpvbmVzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExl
ZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjgs
IDIwMjMgMjo0NCBQTQ0KPiBUbzogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0Bs
aW51eC5pbnRlbC5jb20+DQo+IENjOiBCaWp1IERhcyA8YmlqdS5kYXMuanpAYnAucmVuZXNhcy5j
b20+OyBQYXZlbCBNYWNoZWsgPHBhdmVsQHVjdy5jej47DQo+IGxpbnV4LWxlZHNAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBCaWp1IERhcw0KPiA8YmlqdS5k
YXMuYXVAZ21haWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gbGVkczogcGNh
OTU1eDogQ29udmVydCBlbnVtLT5wb2ludGVyIGZvciBkYXRhDQo+IGluIHRoZSBtYXRjaCB0YWJs
ZXMNCj4gDQo+IE9uIE1vbiwgMjUgU2VwIDIwMjMsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4g
DQo+ID4gT24gU2F0LCBTZXAgMjMsIDIwMjMgYXQgMDY6MTk6MjBQTSArMDEwMCwgQmlqdSBEYXMg
d3JvdGU6DQo+ID4gPiBDb252ZXJ0IGVudW0tPnBvaW50ZXIgZm9yIGRhdGEgaW4gdGhlIG1hdGNo
IHRhYmxlcywgc28gdGhhdA0KPiA+ID4gZGV2aWNlX2dldF9tYXRjaF9kYXRhKCkgY2FuIGRvIG1h
dGNoIGFnYWluc3QgT0YvQUNQSS9JMkMgdGFibGVzLA0KPiA+ID4gb25jZSBpMmMgYnVzIHR5cGUg
bWF0Y2ggc3VwcG9ydCBhZGRlZCB0byBpdC4NCj4gPiA+DQo+ID4gPiBSZXBsYWNlIGVudW0tPnN0
cnVjdCAqcGNhOTU1eF9jaGlwZGVmcyBmb3IgZGF0YSBpbiB0aGUgbWF0Y2ggdGFibGUuDQo+ID4g
PiBTaW1wbGlmeSB0aGUgcHJvYmUoKSBieSByZXBsYWNpbmcgZGV2aWNlX2dldF9tYXRjaF9kYXRh
KCkgYW5kIElEDQo+ID4gPiBsb29rdXAgZm9yIHJldHJpZXZpbmcgZGF0YSBieSBpMmNfZ2V0X21h
dGNoX2RhdGEoKS4NCj4gPiA+DQo+ID4gPiBXaGlsZSBhdCBpdCwgYWRkIGNvbnN0IGRlZmluaXRp
b24gdG8gcGNhOTU1eF9jaGlwZGVmc1tdLg0KPiA+DQo+ID4gLi4uDQo+ID4NCj4gPiA+IC0Jc3Ry
dWN0IHBjYTk1NXhfY2hpcGRlZgkqY2hpcGRlZjsNCj4gPiA+ICsJY29uc3Qgc3RydWN0IHBjYTk1
NXhfY2hpcGRlZgkqY2hpcGRlZjsNCj4gPg0KPiA+IE5vIG5lZWQgdG8gcHJlc2VydmUgVEFCKHMp
IGhlcmUuDQo+IA0KPiBGb2xsb3ctdXAgcGxlYXNlLg0KDQpTdXJlIHdpbGwgc2VuZCBhIGZvbGxv
dy11cCBwYXRjaCB0byBmaXggdGhpcyB0YWIgaXNzdWUgYXMgaXQgaXMgYSBzZXBhcmF0ZSBjaGFu
Z2UuDQoNCkNoZWVycywNCkJpanUNCg==
