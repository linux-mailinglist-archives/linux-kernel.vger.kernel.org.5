Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86D779A5DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235005AbjIKISw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 04:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjIKISt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:18:49 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB5DBB;
        Mon, 11 Sep 2023 01:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqzGIScCO5zfqCAwZ6ZItraFlCVQnRHIJtjiW/u327j2Hva5+K8AZK1Am2GeI0VeVwbYRwI98x7pFK8LM+k/ZcBtOeDFt6UK1mcnTvk8FywW5ElaywIhCkRq21VI73GEpPYJUu/bQXAVXcHOJAgUp2i2bK/WjVeo4VuPqZ/JC+oTADmUM1AzEMDpeE+QTDPqhNzW/iKKYuYI4H/7HKgNCUj5wEd3MoTw8Qhb8HrVuitZ0VYQeR4C+ICNisNJW9rrghrHPsoYu4hciy4FKUbhHbKp9gZ2HKbx3bMSPqePO69Gocyy3EEn9CVSpMLyneXJdXcXtwr7jlXPb+T8kVVd6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBxdnot/0G1zKP9jUDNzr9OPBqRDt2mAfTfr6ngBFyU=;
 b=DoCQxGP80XCvCq9AuPpdttrWnvruIHy6hyWynj2/b2oJglt+Ox3P4rCcHi3RaE5AMj8JFe76RSJ4P5AIRcLvKV22SwC58oYIsG5F7aLaS2LTgNCv/J8i6GLijP9XVmbVd7hXvWCI9sO70/hy6deDubUTIYZtfGgGyN7/wRw40BIG7HK6MGH5cUkYeMfA4HnbumSrKG0W61GFYQ6tv7a+Eql6uLxhxyuNncDu3mo/fmzPjW1ukOzpt7sUunZPqIPk+TDrVLGwyo4CJqt6bkoMxxO7xGPdKFVoVNInIMq4t5U+ZJXTUZ1RM6OSQxAuiD3zoQsawdBOEA/iRBnatAV78g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBxdnot/0G1zKP9jUDNzr9OPBqRDt2mAfTfr6ngBFyU=;
 b=g65brCz6c+xm1pHHlDWu9W+wSKxOv/uHPtjJ9r73QSqY8C0F944Z23bb7XWE72Apv+x2DRvrGj4QXWHvKzissZMO/DWWDNdURcNZzIaCTar++roOzMv0+ugQk6ebqlgJexVtc7qwAaz7iqvWVY8OLs+dze0HwK/YZpS9PJCojTw=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB10238.jpnprd01.prod.outlook.com (2603:1096:400:1d8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Mon, 11 Sep
 2023 08:18:37 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 08:18:37 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
CC:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH 1/2] media: i2c: ov7670: Extend match support for OF
 tables
Thread-Topic: [PATCH 1/2] media: i2c: ov7670: Extend match support for OF
 tables
Thread-Index: AQHZ4/eSnKz2XXcofUqmQ7iVrpfpo7AVRlQAgAABd4A=
Date:   Mon, 11 Sep 2023 08:18:37 +0000
Message-ID: <OS0PR01MB5922821AF13AE6E2368B195486F2A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230910150033.50596-1-biju.das.jz@bp.renesas.com>
 <20230910150033.50596-2-biju.das.jz@bp.renesas.com>
 <6yvrergos76akx42x33owvxwlye5nsgp6tgywqkfzcbmiaywhc@vx6ubzvrmtq2>
In-Reply-To: <6yvrergos76akx42x33owvxwlye5nsgp6tgywqkfzcbmiaywhc@vx6ubzvrmtq2>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB10238:EE_
x-ms-office365-filtering-correlation-id: 5cb5d726-bcca-4b6d-b58b-08dbb29fb2fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rT2ahdRMHRT2zfsILzdcvznJ/IPxF+po7pnYEERqPUhBxyEVM1o2ZTgh4BsVGoLYyl6Eg70v0UtAMjI2BrSSVCSq5oF18CKDISnnzHAc1jwA08sXNQhcSpxYfvCDg2Ksvn2+uK1ao7k/nNXJCXUAzuBhbzxaamLm9Vgwnz3UKKkzBfs36N+RUNOxptzbRM/Y+WmA+PvUJMN35ylHTs6e1k9i5OV5lqOcecM+Kg9HxA86xJx/qKaycNggYDvGzsuZJQfryYCf5MSElaVAe7iQ4V25s/MtCiX7KM0phcN9GxeDTIq7S7WcjEE2mHuwKY0aMXv7TnDzcSqRAdo7NTSUI6aW4qT75I1ZOLFpLTyYzv6/v8Wpsi/KVif2SHtNxMmwEtPWS1trEYI2Kne1tNzYaSZTL2H0Hc8evInn++D3c6bBeD+AQeppsnN64cGTJ+nusAZdjodsMU3BD4J1ZD+x/OJcURTSYOc3Jqp1nLFiJBvx/zLyMKR4QWzSL8YQf+S+dZNypbIooZXKokf8a6Bvovd4Ux+gwhcrgvkkbGk4v3WLUyASB9MRWM35hX9mPf6Ff95EFa34xYjLkDXaq3A0qHM1K2wdFmGOFysL4RUgYbM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(396003)(376002)(136003)(1800799009)(186009)(451199024)(52536014)(6506007)(7696005)(71200400001)(9686003)(966005)(45080400002)(478600001)(83380400001)(26005)(2906002)(54906003)(64756008)(66446008)(66476007)(66946007)(66556008)(316002)(6916009)(76116006)(41300700001)(4326008)(8676002)(8936002)(122000001)(33656002)(86362001)(38100700002)(38070700005)(55016003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXhnTEFoT0JQbDJVMEwxbnU1bTBzbElWUE05Vy9hbGpnUGFoaSt3K0FQNkkv?=
 =?utf-8?B?bGxNT2hkcnRkUG9rZUYyNTB2b3FSWjJqK2hNeUhlUWt1bmxjclJuS3c4cG5q?=
 =?utf-8?B?Z0JISWtTdWM2ejhLOHU4ZlBQYTIyTGl0Zis0cFMvWkpKbmNBTG9jTjVDeTF0?=
 =?utf-8?B?d3dFM0o3Y2gxSVhLU0kzQm1TdTBMMU0wSlhTalpqcS9nQnRRN2FMbngvZW1t?=
 =?utf-8?B?SmRvUmRTTzhUNEhuTzJhN2tYM1F6WUVKVnJyLzVYR3hRbUoxRkNROVpkWTMr?=
 =?utf-8?B?QXBHSU9WSHJLeFlPYWxiZWlhajVHTHZyQXB1b1ZQZWZUem56TnVWZE04czg1?=
 =?utf-8?B?ZnNWdkdWQ1pwSGd4TUFRYzdTbnB1MVZBQkhjRStVUHpyNVFPcnB3SDhPQm1t?=
 =?utf-8?B?bXdLSGU0VEdWbUZaYzJpNzZyWXN1RzVEZlhHelJpd0FacmhGb2xVcFBsK0I1?=
 =?utf-8?B?N0NLUzgveXkrZUtTcFNReUpkUDkvME9sQXQ0bjZ1RGRQcEVJaHZhT2ppdjZP?=
 =?utf-8?B?RmUwR0t0V0dBNk50Y1lZZlkrNWY0bVFFWlBoblNlUVBIam5hYUdsQkNtcStL?=
 =?utf-8?B?U1ZqRnI0QllnNklldHNqZkdRTmRwRmlNWmZHcEkyaHBwZFlIVTBsb3ozWDNT?=
 =?utf-8?B?c1BNblRZR0pGTEU1Qmdyb2psV2lLYU1uaHpFU2NUbHF0anpQUU5zRWN3ajJs?=
 =?utf-8?B?Nmk0UW40a2Z2YmxTR3pEMDZlSFVrSGRRYVBlajFqNy9vVXhxRTIyY1lURmkr?=
 =?utf-8?B?OE95VXpCWVd4amdFTi9MckY1VG0yUmovVmg2RU9HYWI0YjA3MTVWcWowVi81?=
 =?utf-8?B?RmNmZWVXMmwrVktXQUE1eUF5VzQ2N3FmN0NBK2t0dEFpMVZxcW02RzUxdTM1?=
 =?utf-8?B?STR4QTU5Q0xiMjNJai9LTFhDaEU1OWJzMlZBNHQ1dkplaUl1eWdCTzIrenRH?=
 =?utf-8?B?dERHQ3FxellxZUZZUmNkWFZ4c3hjRDRjRzVyWU40ZExHYzg3RUp0TFZURmd0?=
 =?utf-8?B?VHZITndBUnI2RzRCN2VKbDd1eFJXS24xdEFJZVpRdEtwTFUrOWlKaXB3WUlh?=
 =?utf-8?B?V3lVejM4M2VTd2Y1QVVlTno5VHZKMEZJMnNKWE9qZFJqakp4MWlUalpLczlJ?=
 =?utf-8?B?VGZsMEFPMU1GakVTK3U1cHR6R0JIbkEyZFlrRTlXNDZuazRJMVVreGVDRC9a?=
 =?utf-8?B?MHhoM0VHYUppUHZ2WXhNM1pNZUtYai9IcWFDQ3RsYlRhU3A1TElpby9kVUhP?=
 =?utf-8?B?MHdOY0V5TDVOUXpOSldnaUhacjJGMlVPRjhsYTh1N1hqcG5WaldoaXB6RHZR?=
 =?utf-8?B?WnlqeUNCSWR0d0Q4akRrcDZzNE9RWTQyamdnVXRyZUhmWXovRFdnMDJvNWt4?=
 =?utf-8?B?ckh1bU81aVgzZFRyNTlHZ3FTSUYxQUxScTF3ZDVrSGRvSDhVczZ4K0xPZzBK?=
 =?utf-8?B?UjZ2Vm1temNtN3o1em1WcGo0UEZTRTQ3MzBwUjlxbXFTOVNTSUxvbjc0ZUxY?=
 =?utf-8?B?ZGxTNmNMTTg1bmxWRUQ0OERWL2FOcDllR2tOb2g0Tjg0eGMvTlA1WDQvdE1t?=
 =?utf-8?B?c2RjUUsyUldSZUkybElkbHJycFJpWWxZazRwOFJQWjZVNm5aWVpHNlkzc1RY?=
 =?utf-8?B?NFkzTFl2YUNJUlZZenU5SUl6ak5sZnB3aDExbXplZHd5ditzNmFuS3BGT3Nk?=
 =?utf-8?B?aXBITlBXTzVacWJmMlRPZGVjZUthQUZKWkdPN1FaNk16SXpiKzlNbktXZ0Fi?=
 =?utf-8?B?TEErN1NZZGFYRjhaTi90azk0U3RtZnB3R0p5b2RycDFQTndaUlRIeENtMjc4?=
 =?utf-8?B?Qk5IVnV5U25KaEVDSm96bGZLZEp1RWJXazk2S2JLcm5GSS84SjZFTzI4aFFS?=
 =?utf-8?B?NmxOZWNXempzY1dUMmVXdTA5RjdqUmE3S1gwM0NQbGhWcmUvYWVyejloV3RI?=
 =?utf-8?B?aG1xajlvMzBBaHVLZWNtZ1o1cnFkTFhmM3RkN2FtNVhVU0laWTloYUVWWEkz?=
 =?utf-8?B?ZDdqNEFKU0gyTGFsWVFRTXJUR3VIVXFuWnNaY0wyZktkMU51ODJhMDJjdSsr?=
 =?utf-8?B?T2p3eU81TVErNnNTQWZLY3dkbTFxYVAralJtOUNuSTJMenc2dU1pM2tBWlJ2?=
 =?utf-8?B?TUxHL0VwNEZGdC9PVTV1UmE2Wk5LQU9YSG1RSEwvL0ZYSXhDbGRsSjg3ekpy?=
 =?utf-8?B?Y0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb5d726-bcca-4b6d-b58b-08dbb29fb2fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 08:18:37.5174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfLMchfg/BKoyoY0ktdp8QCCU3Kw7ZpkN/XLJMPfCVqjoLGCC5+4qvIAiO9M8tAG0CCDNnyW/eRKrFR8un9K1Qv7KNyYXzonRPJkuys8a8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB10238
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFjb3BvIE1vbmRpLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDEvMl0gbWVkaWE6IGkyYzogb3Y3NjcwOiBFeHRlbmQgbWF0Y2ggc3VwcG9y
dCBmb3IgT0YNCj4gdGFibGVzDQo+IA0KPiBIaSBCaWp1DQo+IA0KPiBPbiBTdW4sIFNlcCAxMCwg
MjAyMyBhdCAwNDowMDozMlBNICswMTAwLCBCaWp1IERhcyB3cm90ZToNCj4gPiBUaGUgZHJpdmVy
IGhhcyBhbiBPRiBtYXRjaCB0YWJsZSwgc3RpbGwsIGl0IHVzZXMgYW4gSUQgbG9va3VwIHRhYmxl
DQo+ID4gZm9yIHJldHJpZXZpbmcgbWF0Y2ggZGF0YS4gQ3VycmVudGx5LCB0aGUgZHJpdmVyIGlz
IHdvcmtpbmcgb24gdGhlDQo+ID4gYXNzdW1wdGlvbiB0aGF0IGFuIEkyQyBkZXZpY2UgcmVnaXN0
ZXJlZCB2aWEgT0Ygd2lsbCBhbHdheXMgbWF0Y2ggYQ0KPiA+IGxlZ2FjeSBJMkMgZGV2aWNlIElE
LiBUaGUgY29ycmVjdCBhcHByb2FjaCBpcyB0byBoYXZlIGFuIE9GIGRldmljZSBJRA0KPiA+IHRh
YmxlIHVzaW5nIGkyY19nZXRfbWF0Y2hfZGF0YSgpIGlmIHRoZSBkZXZpY2VzIGFyZSByZWdpc3Rl
cmVkIHZpYSBPRi9JRC4NCj4gPg0KPiA+IFVuaWZ5IHRoZSBPRi9JRCB0YWJsZSBieSB1c2luZyBz
dHJ1Y3Qgb3Y3NjcwX2RldnR5cGUgYXMgbWF0Y2ggZGF0YSBmb3INCj4gPiBib3RoIHRoZXNlIHRh
YmxlcyBhbmQgcmVwbGFjZSB0aGUgSUQgbG9va3VwIHRhYmxlIGZvciB0aGUgbWF0Y2ggZGF0YQ0K
PiA+IGJ5IGkyY19nZXRfbWF0Y2hfZGF0YSgpLg0KPiA+DQo+ID4gU3BsaXQgdGhlIGFycmF5IG92
NzY3MF9kZXZkYXRhW10gYXMgaW5kaXZpZHVhbCB2YXJpYWJsZXMsIGFuZCBtYWtlDQo+ID4gbGlu
ZXMgc2hvcnRlciBieSByZWZlcnJpbmcgdG8gZS5nLiAmb3Y3NjcwX2RldmRhdGEgaW5zdGVhZCBv
Zg0KPiA+ICZvdjc2NzBfZGV2ZGF0YVtNT0RFTF9PVjc2NzBdLg0KPiA+DQo+ID4gRHJvcCBlbnVt
IG92NzY3MF9tb2RlbCBhcyB0aGVyZSBpcyBubyB1c2VyLg0KPiA+DQo+ID4gV2hpbGUgYXQgaXQs
IHJlbW92ZSB0aGUgdHJhaWxpbmcgY29tbWEgaW4gdGhlIHRlcm1pbmF0b3IgZW50cnkgZm9yIHRo
ZQ0KPiA+IE9GIHRhYmxlIG1ha2luZyBjb2RlIHJvYnVzdCBhZ2FpbnN0ICh0aGVvcmV0aWNhbCkg
bWlzcmViYXNlcyBvciBvdGhlcg0KPiA+IHNpbWlsYXIgdGhpbmdzIHdoZXJlIHRoZSBuZXcgZW50
cnkgZ29lcyBfYWZ0ZXJfIHRoZSB0ZXJtaW5hdGlvbg0KPiA+IHdpdGhvdXQgdGhlIGNvbXBpbGVy
IG5vdGljaW5nLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQmlqdSBEYXMgPGJpanUuZGFzLmp6
QGJwLnJlbmVzYXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21lZGlhL2kyYy9vdjc2NzAu
YyB8IDQ3DQo+ID4gKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDI3IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWVkaWEvaTJjL292NzY3MC5jIGIvZHJpdmVycy9tZWRp
YS9pMmMvb3Y3NjcwLmMNCj4gPiBpbmRleCAyZjU1NDkxZWY1NzEuLjY0NDQ1N2U2OTkzZCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL2kyYy9vdjc2NzAuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbWVkaWEvaTJjL292NzY3MC5jDQo+ID4gQEAgLTE4NiwxMSArMTg2LDYgQEAgTU9EVUxFX1BB
Uk1fREVTQyhkZWJ1ZywgIkRlYnVnIGxldmVsICgwLTEpIik7DQo+ID4gICNkZWZpbmUgUkVHX0hB
RUNDNwkweGFhCS8qIEhpc3QgQUVDL0FHQyBjb250cm9sIDcgKi8NCj4gPiAgI2RlZmluZSBSRUdf
QkQ2ME1BWAkweGFiCS8qIDYwaHogYmFuZGluZyBzdGVwIGxpbWl0ICovDQo+ID4NCj4gPiAtZW51
bSBvdjc2NzBfbW9kZWwgew0KPiA+IC0JTU9ERUxfT1Y3NjcwID0gMCwNCj4gPiAtCU1PREVMX09W
NzY3NSwNCj4gPiAtfTsNCj4gPiAtDQo+ID4gIHN0cnVjdCBvdjc2NzBfd2luX3NpemUgew0KPiA+
ICAJaW50CXdpZHRoOw0KPiA+ICAJaW50CWhlaWdodDsNCj4gPiBAQCAtMTc3NCwyMSArMTc2OSw2
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdjRsMl9zdWJkZXZfaW50ZXJuYWxfb3BzDQo+ID4gb3Y3
NjcwX3N1YmRldl9pbnRlcm5hbF9vcHMgPSB7DQo+ID4NCj4gPiAgLyoNCj4gPiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gLSAqLw0KPiA+DQo+ID4gLXN0YXRpYyBjb25zdCBzdHJ1Y3Qgb3Y3NjcwX2RldnR5
cGUgb3Y3NjcwX2RldmRhdGFbXSA9IHsNCj4gPiAtCVtNT0RFTF9PVjc2NzBdID0gew0KPiA+IC0J
CS53aW5fc2l6ZXMgPSBvdjc2NzBfd2luX3NpemVzLA0KPiA+IC0JCS5uX3dpbl9zaXplcyA9IEFS
UkFZX1NJWkUob3Y3NjcwX3dpbl9zaXplcyksDQo+ID4gLQkJLnNldF9mcmFtZXJhdGUgPSBvdjc2
NzBfc2V0X2ZyYW1lcmF0ZV9sZWdhY3ksDQo+ID4gLQkJLmdldF9mcmFtZXJhdGUgPSBvdjc2NzBf
Z2V0X2ZyYW1lcmF0ZV9sZWdhY3ksDQo+ID4gLQl9LA0KPiA+IC0JW01PREVMX09WNzY3NV0gPSB7
DQo+ID4gLQkJLndpbl9zaXplcyA9IG92NzY3NV93aW5fc2l6ZXMsDQo+ID4gLQkJLm5fd2luX3Np
emVzID0gQVJSQVlfU0laRShvdjc2NzVfd2luX3NpemVzKSwNCj4gPiAtCQkuc2V0X2ZyYW1lcmF0
ZSA9IG92NzY3NV9zZXRfZnJhbWVyYXRlLA0KPiA+IC0JCS5nZXRfZnJhbWVyYXRlID0gb3Y3Njc1
X2dldF9mcmFtZXJhdGUsDQo+ID4gLQl9LA0KPiA+IC19Ow0KPiA+IC0NCj4gPiAgc3RhdGljIGlu
dCBvdjc2NzBfaW5pdF9ncGlvKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIHN0cnVjdA0KPiA+
IG92NzY3MF9pbmZvICppbmZvKSAgew0KPiA+ICAJaW5mby0+cHdkbl9ncGlvID0gZGV2bV9ncGlv
ZF9nZXRfb3B0aW9uYWwoJmNsaWVudC0+ZGV2LCAicG93ZXJkb3duIiwNCj4gPiBAQCAtMTg0OSw3
ICsxODI5LDYgQEAgc3RhdGljIGludCBvdjc2NzBfcGFyc2VfZHQoc3RydWN0IGRldmljZSAqZGV2
LA0KPiA+DQo+ID4gIHN0YXRpYyBpbnQgb3Y3NjcwX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpj
bGllbnQpICB7DQo+ID4gLQljb25zdCBzdHJ1Y3QgaTJjX2RldmljZV9pZCAqaWQgPSBpMmNfY2xp
ZW50X2dldF9kZXZpY2VfaWQoY2xpZW50KTsNCj4gPiAgCXN0cnVjdCB2NGwyX2ZyYWN0IHRwZjsN
Cj4gPiAgCXN0cnVjdCB2NGwyX3N1YmRldiAqc2Q7DQo+ID4gIAlzdHJ1Y3Qgb3Y3NjcwX2luZm8g
KmluZm87DQo+ID4gQEAgLTE5MjMsNyArMTkwMiw3IEBAIHN0YXRpYyBpbnQgb3Y3NjcwX3Byb2Jl
KHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpDQo+ID4gIAl2NGxfaW5mbyhjbGllbnQsICJjaGlw
IGZvdW5kIEAgMHglMDJ4ICglcylcbiIsDQo+ID4gIAkJCWNsaWVudC0+YWRkciA8PCAxLCBjbGll
bnQtPmFkYXB0ZXItPm5hbWUpOw0KPiA+DQo+ID4gLQlpbmZvLT5kZXZ0eXBlID0gJm92NzY3MF9k
ZXZkYXRhW2lkLT5kcml2ZXJfZGF0YV07DQo+ID4gKwlpbmZvLT5kZXZ0eXBlID0gaTJjX2dldF9t
YXRjaF9kYXRhKGNsaWVudCk7DQo+IA0KPiBJIHdhcyBhYm91dCB0byBjb21wbGFpbiB0aGlzIGZ1
bmN0aW9uIGlzIG5vdCB1c2VkLCBidXQgdGhlbiBJIG5vdGljZWQgeW91DQo+IGp1c3QgaW50cm9k
dWNlZCBpdCwgc28gdGhpcyBpcyBsaWtlIHRoZSBmaXJzdCB1c2VyIQ0KDQpUaGlzIGRyaXZlciBp
cyBub3QgdGhlIGZpcnN0IHVzZXIuIE5vdyBwbGVudHkgb2YgdXNlcnMgYXJlIHRoZXJlIGluIExp
bnV4LW5leHQsIDYuNi1yYzEgYW5kICBbMV0NCg0KaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIv
c2NtL2xpbnV4L2tlcm5lbC9naXQvamljMjMvaWlvLmdpdC9sb2cvP2g9dGVzdGluZyZxdD1ncmVw
JnE9YmlqdS5kYXMNCg0KPiANCj4gDQo+ID4gIAlpbmZvLT5mbXQgPSAmb3Y3NjcwX2Zvcm1hdHNb
MF07DQo+ID4gIAlpbmZvLT53c2l6ZSA9ICZpbmZvLT5kZXZ0eXBlLT53aW5fc2l6ZXNbMF07DQo+
ID4NCj4gPiBAQCAtMjAxMywxNyArMTk5MiwzMSBAQCBzdGF0aWMgdm9pZCBvdjc2NzBfcmVtb3Zl
KHN0cnVjdCBpMmNfY2xpZW50DQo+ICpjbGllbnQpDQo+ID4gIAltZWRpYV9lbnRpdHlfY2xlYW51
cCgmaW5mby0+c2QuZW50aXR5KTsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1
Y3Qgb3Y3NjcwX2RldnR5cGUgb3Y3NjcwX2RldmRhdGEgPSB7DQo+ID4gKwkud2luX3NpemVzID0g
b3Y3NjcwX3dpbl9zaXplcywNCj4gPiArCS5uX3dpbl9zaXplcyA9IEFSUkFZX1NJWkUob3Y3Njcw
X3dpbl9zaXplcyksDQo+ID4gKwkuc2V0X2ZyYW1lcmF0ZSA9IG92NzY3MF9zZXRfZnJhbWVyYXRl
X2xlZ2FjeSwNCj4gPiArCS5nZXRfZnJhbWVyYXRlID0gb3Y3NjcwX2dldF9mcmFtZXJhdGVfbGVn
YWN5LCB9Ow0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvdjc2NzBfZGV2dHlwZSBv
djc2NzVfZGV2ZGF0YSA9IHsNCj4gPiArCS53aW5fc2l6ZXMgPSBvdjc2NzVfd2luX3NpemVzLA0K
PiA+ICsJLm5fd2luX3NpemVzID0gQVJSQVlfU0laRShvdjc2NzVfd2luX3NpemVzKSwNCj4gPiAr
CS5zZXRfZnJhbWVyYXRlID0gb3Y3Njc1X3NldF9mcmFtZXJhdGUsDQo+ID4gKwkuZ2V0X2ZyYW1l
cmF0ZSA9IG92NzY3NV9nZXRfZnJhbWVyYXRlLCB9Ow0KPiA+ICsNCj4gPiAgc3RhdGljIGNvbnN0
IHN0cnVjdCBpMmNfZGV2aWNlX2lkIG92NzY3MF9pZFtdID0gew0KPiA+IC0JeyAib3Y3NjcwIiwg
TU9ERUxfT1Y3NjcwIH0sDQo+ID4gLQl7ICJvdjc2NzUiLCBNT0RFTF9PVjc2NzUgfSwNCj4gPiAt
CXsgfQ0KPiA+ICsJeyAib3Y3NjcwIiwgKGtlcm5lbF91bG9uZ190KSZvdjc2NzBfZGV2ZGF0YSB9
LA0KPiA+ICsJeyAib3Y3Njc1IiwgKGtlcm5lbF91bG9uZ190KSZvdjc2NzVfZGV2ZGF0YSB9LA0K
PiA+ICsJeyAvKiBzZW50aW5lbCAqLyB9DQo+ID4gIH07DQo+ID4gIE1PRFVMRV9ERVZJQ0VfVEFC
TEUoaTJjLCBvdjc2NzBfaWQpOw0KPiA+DQo+ID4gICNpZiBJU19FTkFCTEVEKENPTkZJR19PRikN
Cj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgb3Y3NjcwX29mX21hdGNoW10g
PSB7DQo+ID4gLQl7IC5jb21wYXRpYmxlID0gIm92dGksb3Y3NjcwIiwgfSwNCj4gPiAtCXsgLyog
c2VudGluZWwgKi8gfSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAib3Z0aSxvdjc2NzAiLCAmb3Y3
NjcwX2RldmRhdGEgfSwNCj4gPiArCXsgLyogc2VudGluZWwgKi8gfQ0KPiANCj4gVGhlIHBhdGNo
IGxvb2tzIGdvb2QgdG8gbWUsIHdvdWxkIGJlIG5pY2UgdG8ga25vdyBpZiB5b3UgaGF2ZSBiZWVu
IGFibGUgdG8NCj4gcnVuLXRpbWUgdGVzdCBhdCBsZWFzdCBvbmUgb2YgdGhlIGRyaXZlcnMgeW91
IGhhdmUgbW92ZWQgdG8gdXNlDQo+IGkyY19nZXRfbWF0Y2hfZGF0YSgpLg0KDQpJIGFscmVhZHkg
ZG9uZSBzaW1pbGFyIHRlc3Rpbmcgb24gWzFdLCBbMl0gYW5kIFszXQ0KDQpbMV0gaHR0cHM6Ly9n
aXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0
L2NvbW1pdC8/aD12Ni42LXJjMSZpZD1iN2Y3M2I2ZTkyMWI0NTdhMjIyZTg2Y2Y1M2ZlMzk1MGM2
YjVhZWQ1DQoNClsyXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA4MzAxNDIzNTgu
Mjc1NDU5LTEtYmlqdS5kYXMuanpAYnAucmVuZXNhcy5jb20vDQoNClszXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvT1MwUFIwMU1CNTkyMkY1NUQxODgyNEYxNTUyMjgyNTkwODZFN0FAT1Mw
UFIwMU1CNTkyMi5qcG5wcmQwMS5wcm9kLm91dGxvb2suY29tLw0KDQpDaGVlcnMsDQpCaWp1DQoN
Cj4gDQo+IFJldmlld2VkLWJ5OiBKYWNvcG8gTW9uZGkgPGphY29wby5tb25kaStyZW5lc2FzQGlk
ZWFzb25ib2FyZC5jb20+DQo+IA0KPiA+ICB9Ow0KPiA+ICBNT0RVTEVfREVWSUNFX1RBQkxFKG9m
LCBvdjc2NzBfb2ZfbWF0Y2gpOyAgI2VuZGlmDQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0K
