Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C245579B465
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345109AbjIKVPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235640AbjIKJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:14:44 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2125.outbound.protection.outlook.com [40.107.114.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBB1CCD;
        Mon, 11 Sep 2023 02:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiKtuP4mSSWTU68KEMiaYNRRm4Z3ComHtvYmsQnegje7vGikdYwVaLbYbsSJbY5WMn43E07Bn2NrQjv8JdrKnA/dithwXnpQ8O3Yf1hSbGB5X4PfooMsz5ggCLAlXdrYZo68lw7SX4Zq7zyTX4Gvu7h0OowAcZqUyL/9tv24tEyjkLHEn8BdcBQkMUBdL7Gtlu9dKYn5yXAMlIYCXXkKgamkNlgzbhKpLwQ1ktbEFk+oTndyqvojLW0CuqaKgUl3UQgIkGTU5owYYS9Z1LRCmB5JeO0F6eB237G1Bv33wbRN4glZev/Us+S2vi7m81O+yZP9WI7Q5iCo3CqesY8MQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn0HRmyWtvaf4gXAEinG5tdtiCA9joubImnlbw/tPfk=;
 b=XmON+Um1kU9D8XM2+hhBVRWGRoZvXsZnDWth05S7PB6YLlJLMnrWkCnt/5Dd4kh+vTkiFNxdBVu70i3+T++gZnCjh72hsOuMywybte+dSHmFX6aJVlf8r7ja/cXA5EbBaLYvZ4eg+V+iH7q6qSUhEDBuDEQ6M2PpsNcmJD6+MlNAdbpUTQuYBdaSjxgjr9LBCORcVl4vd9hhYoepCfSILXad9DCfpxc7T51TyuaY6v2IZ5AWLSKVkguRthw7KVmypDRk03qKR27PV6lO/iZ+r36WkY37xrzcZogMVAKjAEQx/MNY2pk6RdHN3UfffdDAG3m88fwngE0TKIaLcuIbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn0HRmyWtvaf4gXAEinG5tdtiCA9joubImnlbw/tPfk=;
 b=Mq7APxLzT3B6UPXNc+cOruRJQ5EDIYn/54sOkoVpzcnqHJ4L4vqQdoNRJh2E4aKK2lfrQNJiPxCFwQpWRN1bmtTxoPD5g5s/xgs3EktpSyiFPEjOl468pi/IGGhaVzCmNgXZ3noESJl87tW8N0ZuuIm5fCttl359n05NneOJ3uM=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TY3PR01MB9763.jpnprd01.prod.outlook.com (2603:1096:400:22c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Mon, 11 Sep
 2023 09:14:35 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::9d23:32f5:9325:3706%5]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 09:14:35 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
CC:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH 1/2] media: mt9p031: Extend match support for OF tables
Thread-Topic: [PATCH 1/2] media: mt9p031: Extend match support for OF tables
Thread-Index: AQHZ5AAUb1WsR5L3Y02tx/63I1nzfLAVVp6AgAAAj2A=
Date:   Mon, 11 Sep 2023 09:14:35 +0000
Message-ID: <OS0PR01MB59226056EAA42B93D123CFB586F2A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230910160126.70122-1-biju.das.jz@bp.renesas.com>
 <20230910160126.70122-2-biju.das.jz@bp.renesas.com>
 <tlaikk73c5gc6y3bk6evuwtlizletaws7tuc5nk36hz2adkydp@duv2tjpqnios>
In-Reply-To: <tlaikk73c5gc6y3bk6evuwtlizletaws7tuc5nk36hz2adkydp@duv2tjpqnios>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TY3PR01MB9763:EE_
x-ms-office365-filtering-correlation-id: c628f483-3f4c-4c29-7673-08dbb2a78485
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fSpqCwSbuTCNAFAsAyPXxKBGxBq1frJ0lhwl68bSB7poxUzU0nDEHZpVHjZ6sEs3dT4Kxn015TQsOXNlMNYNiS+3BQTa/KcnMIcmqVs6BwglAQb6ileCwF8RraD2GVNxjxfaJH9Fns9BJt1Zlx3c6r1OOzjoBE+y5yalXeqneQw1FRWHn5AQUoPeK+w9R1zN7ZdafSDDXE5vH+BQut3uX3w2jGBd7p5GixTGW1TWxrw6CkMxExJKxB2zyti3NHeYmDcPd920q1tJgYmb6ZOh+PNBCIFOpyms7L12uiCY3HKUtOi66wS7TJcoxCn1O7UDsPr9AYWPkC+vICpPY+8Wfyxfs5wqjI9cvDInZv64NRDP0aqA8NkjXc/XrJEkNlXKbuzriOC1B7iPp7BsWm3+JJsTMgEny0tDzuVaUWY26ZHQNwK4ofsV6TDbtxnuDSyI4M9T05fwk55btQbtRi6RKW7BBpZWi5SNAUlKt8nc9wBNrIzXH545usPeghA5QglqBI3EjkXeP8jSXrNCbFajZeDEwVXJKG0D6aQG3ACRkV+1QnsVHWMJ9US6u0ZbORoMYnMyHSOCKGiBdptyBq+5VR/XrJGgdOz41ApCj0IXAEM00o7O+ujKBNIS2lWLw6Hq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199024)(1800799009)(186009)(122000001)(71200400001)(7696005)(6506007)(52536014)(33656002)(86362001)(38100700002)(38070700005)(55016003)(26005)(2906002)(9686003)(478600001)(83380400001)(5660300002)(41300700001)(4326008)(76116006)(6916009)(316002)(8676002)(8936002)(66446008)(64756008)(54906003)(66476007)(66556008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWRUcHR5aTZMSHFWM05yVXZHbkNnWXRCc3Q0VzhWQmtrRmpTNnpPNkc2UUtS?=
 =?utf-8?B?L21OLzUyT2FTbjdxTWw5VVlzSW53cjk0OEVIcnloUjFqTEd1VkNmNTVRZElJ?=
 =?utf-8?B?T1pEbURCY1ZBUCtlUTlMWGdiK2g2dWllK21hU1pXVGtpc1lmRmxuaVhjOGtH?=
 =?utf-8?B?VVQwdVZ5aSt4K1ZSekZaSDhzRWQ0Zk9sQ08wQVZzYmVOZzB5NDZTaFNPa1Rz?=
 =?utf-8?B?YWt3R21aUFJaaVpDekxOSXY0Vzh4Z1V5bU1rR0FaUVFpQkc5UG10T2JUVld2?=
 =?utf-8?B?eCtkL2toR3I0RlFab1dRNjg5SXJMU1o0eDVBR1dzSkNDRW9idmNoNGFDdVZQ?=
 =?utf-8?B?UVd4Vkc4cldDdjJMcVA0ZUpyenZDWmNHSUlnNXpJbjI0TUNNRUVKYXFCelVL?=
 =?utf-8?B?ZmxIRUlPYXFqUzA1SW0zTmhHU2wzeE1VQys0c3c4VHdjSFRRWk1FMC9aN3JC?=
 =?utf-8?B?ZXZHdFRtZDRiaGs2eWxXazRzanA0am1rZWhISkZDUVVFejNuYnRyblljNHFt?=
 =?utf-8?B?dmgrNVBFZjlSeGFjYTZEYnhzcHk4SDBPTHFUaW90Zjc4cGJDTUtyQ3NhSnd1?=
 =?utf-8?B?UXFMRjZBdm00K2JoMjMxaDkvNEV2S3pwRnB4ejR5U2dWUCtYTUc3ZnpITFJ5?=
 =?utf-8?B?ejRxRFU5KzFhSFA5MkkzWllnWnFodVdLRE00Q1BvN1M5TTVyM3RZQjN6QUJl?=
 =?utf-8?B?Tlk5bXRoRElOMlUzZElaQ3ZLa2p1YlFRWW5UbGxvOHJTUldqeFNuajAzUU44?=
 =?utf-8?B?TlUvdUw5aWx6Q2lkNkhlaTJwOE01MHpjYU55cHBySzJuNDRDQUZuZkN6KzVx?=
 =?utf-8?B?Q1ZlVnNvR0M2TWZlUTl6cUM5K0Fzc25Lall1b0UwSVpLY2g0dk9IZ09LUFph?=
 =?utf-8?B?SEJXQ1Z1V1Y1TENHLzFST1ZqbXpMakFRK0lqL056OTBWTzNaK00xVHhkTzYy?=
 =?utf-8?B?c2hCclpWc0VFZjM1OHRLOHVkQVR1eFF5U3BOT2h5WmJaNWUwK1BqZkNHcjNY?=
 =?utf-8?B?NjhMRUFjaUozOWR3TElOSHl1K2RSaDZSUzJXcHBGaDJDUEhSZnpXK3lua3kv?=
 =?utf-8?B?T3Q5aXM0NW00eG1iYVB2a1JSVnpiQjR1TmJ1RU0vT0NWY1JkeDNMWWVpTjBV?=
 =?utf-8?B?NVdQdFpSRXNyaC93UGwxemVPU3NKd1cxN3A0dDZYc2U3MDE4TUQrbjhRcDQ1?=
 =?utf-8?B?M3hEKzl0S3RqcnBMeU1jaHhWR3Y3SWt2dm5sT2JrOWwwQ2tUYjN1N3c5bUhC?=
 =?utf-8?B?U3ZVejV5OVRsbHBHMTRSQWdEWGk2eDE1emVYd3c4dFdEVWlVV3NEOTJ1Nmsw?=
 =?utf-8?B?OGRkR0Y2clRZL2VpdHBwOW1lQXJkeGhrMmwrUnJYT3JaQTU1ZzVIKzZ5WW4v?=
 =?utf-8?B?M1hQRjEwZ1FhbWZWem1lSG1TUCtRWXIrdU00MWpzallNbUVyOEM5REU5cmwz?=
 =?utf-8?B?bGw3cTJmL3hsUW9TTng3Rk5OOHZDaXBMbzc0Q044bnYwUWREV0xnTWNjTDZj?=
 =?utf-8?B?eTQ0a1d0cjNRZURkZ3gxaXUyUDNEVHlqYlgrSWR2KzkvdlJjekFhZDlpcWxu?=
 =?utf-8?B?d1ZxMkFwZjJGR0hnVXdnYWhZMERybUZNbm5ieXg2MDZ0bDJxYnd4cU5xM3ZH?=
 =?utf-8?B?V0FqVHRjMDVwSUo4OU5tUy9FcE1VekZPbzBaMTd6TWxjVHZML0FhS00vbVNx?=
 =?utf-8?B?UVl1SENlOHQwTDFrb25pcUJRVWpGV0MzQ0tqYUZWcUVkRzViNkJQdFlwS2dV?=
 =?utf-8?B?N01PcjRnRUNDMytOZXZKaURBUWN1dWNTbE5zY2dKZll6d0pjNGRFeEJFcTBw?=
 =?utf-8?B?R1ZLUFhUeTJad0tzQWpqekJkek1TUzh4TTV4WElEamNNWG5ERGx0M1BwbWNH?=
 =?utf-8?B?d0hsd0wwN2xvTUJPOTR0QjZiTnRQbWlPa0tsd0MxbnE0cW50clpGQUJuT3NU?=
 =?utf-8?B?dzlma0d0dC9nZUVwdGc2ejBQUG5nZzUxeXFmWWRTMGZSWS9jc2dmbUtsZ1VB?=
 =?utf-8?B?cXhPOVZhNmx6S2UrQ0tTeTZEQjJVanA3M0NSVzIxWWdramwwRk0rYzZmaGF6?=
 =?utf-8?B?cG5qOWZIR2JzTDdUaXJtVFQrSE1HMzU4ZC84N090a0hiQldvWDVicHBrS0hk?=
 =?utf-8?B?cXpuMzFSVzczd1czbmI2MlIxL3hyVi8zdm5BclR2YjdnNGpXTlozbHBXd1hQ?=
 =?utf-8?B?VEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c628f483-3f4c-4c29-7673-08dbb2a78485
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 09:14:35.5614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4tPNgrDcM8wKKHHBzPTHiFGC/nCGD35OR0FxXh2OKDHZXKVEWQgShJm2xzb3ONur5wXj3Gz0P7MPsYXNSDqTqShQMvRc/lSACSyN7Jk7yzM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB9763
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmFjb3BvIE1vbmRpLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjay4NCg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDEvMl0gbWVkaWE6IG10OXAwMzE6IEV4dGVuZCBtYXRjaCBzdXBwb3J0IGZv
ciBPRiB0YWJsZXMNCj4gDQo+IEhpIEJpanUNCj4gDQo+IE9uIFN1biwgU2VwIDEwLCAyMDIzIGF0
IDA1OjAxOjI1UE0gKzAxMDAsIEJpanUgRGFzIHdyb3RlOg0KPiA+IFRoZSBkcml2ZXIgaGFzIGFu
IE9GIG1hdGNoIHRhYmxlLCBzdGlsbCwgaXQgdXNlcyBhbiBJRCBsb29rdXAgdGFibGUNCj4gPiBm
b3IgcmV0cmlldmluZyBtYXRjaCBkYXRhLiBDdXJyZW50bHksIHRoZSBkcml2ZXIgaXMgd29ya2lu
ZyBvbiB0aGUNCj4gPiBhc3N1bXB0aW9uIHRoYXQgYW4gSTJDIGRldmljZSByZWdpc3RlcmVkIHZp
YSBPRiB3aWxsIGFsd2F5cyBtYXRjaCBhDQo+ID4gbGVnYWN5IEkyQyBkZXZpY2UgSUQuIFRoZSBj
b3JyZWN0IGFwcHJvYWNoIGlzIHRvIGhhdmUgYW4gT0YgZGV2aWNlIElEDQo+ID4gdGFibGUgdXNp
bmcgaTJjX2dldF9tYXRjaF9kYXRhKCkgaWYgdGhlIGRldmljZXMgYXJlIHJlZ2lzdGVyZWQgdmlh
IE9GL0lELg0KPiA+DQo+ID4gVW5pZnkgdGhlIE9GL0lEIHRhYmxlIGJ5IHVzaW5nIE1FRElBX0JV
U19GTVQgYXMgbWF0Y2ggZGF0YSBmb3IgYm90aA0KPiA+IHRoZXNlIHRhYmxlcyBhbmQgcmVwbGFj
ZSB0aGUgSUQgbG9va3VwIHRhYmxlIGZvciB0aGUgbWF0Y2ggZGF0YSBieQ0KPiA+IGkyY19nZXRf
bWF0Y2hfZGF0YSgpIGFuZCBzaW1wbGlmbHkgcHJvYmUoKSBhbmQgbXQ5cDAzMV9pbml0X2NmZygp
DQo+ID4NCj4gPiBEcm9wIG10OXAwMzFfaW5pdF9jZmcgYXMgdGhlcmUgaXMgbm8gdXNlci4NCj4g
Pg0KPiA+IFdoaWxlIGF0IGl0LCByZW1vdmUgdGhlIHRyYWlsaW5nIGNvbW1hIGluIHRoZSB0ZXJt
aW5hdG9yIGVudHJ5IGZvciB0aGUNCj4gPiBPRiB0YWJsZSBtYWtpbmcgY29kZSByb2J1c3QgYWdh
aW5zdCAodGhlb3JldGljYWwpIG1pc3JlYmFzZXMgb3Igb3RoZXINCj4gPiBzaW1pbGFyIHRoaW5n
cyB3aGVyZSB0aGUgbmV3IGVudHJ5IGdvZXMgX2FmdGVyXyB0aGUgdGVybWluYXRpb24NCj4gPiB3
aXRob3V0IHRoZSBjb21waWxlciBub3RpY2luZy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEJp
anUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9tZWRpYS9pMmMvbXQ5cDAzMS5jIHwgMzMgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCAyMiBkZWxldGlvbnMo
LSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21lZGlhL2kyYy9tdDlwMDMxLmMgYi9k
cml2ZXJzL21lZGlhL2kyYy9tdDlwMDMxLmMNCj4gPiBpbmRleCAzNDhmMWUxMDk4ZmIuLjU0MGNi
NTE5OTE1YyAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21lZGlhL2kyYy9tdDlwMDMxLmMNCj4g
PiArKysgYi9kcml2ZXJzL21lZGlhL2kyYy9tdDlwMDMxLmMNCj4gPiBAQCAtMTEyLDExICsxMTIs
NiBAQA0KPiA+ICAjZGVmaW5lIE1UOVAwMzFfVEVTVF9QQVRURVJOX1JFRAkJCTB4YTINCj4gPiAg
I2RlZmluZSBNVDlQMDMxX1RFU1RfUEFUVEVSTl9CTFVFCQkJMHhhMw0KPiA+DQo+ID4gLWVudW0g
bXQ5cDAzMV9tb2RlbCB7DQo+ID4gLQlNVDlQMDMxX01PREVMX0NPTE9SLA0KPiA+IC0JTVQ5UDAz
MV9NT0RFTF9NT05PQ0hST01FLA0KPiA+IC19Ow0KPiA+IC0NCj4gPiAgc3RydWN0IG10OXAwMzEg
ew0KPiA+ICAJc3RydWN0IHY0bDJfc3ViZGV2IHN1YmRldjsNCj4gPiAgCXN0cnVjdCBtZWRpYV9w
YWQgcGFkOw0KPiA+IEBAIC0xMjksNyArMTI0LDcgQEAgc3RydWN0IG10OXAwMzEgew0KPiA+ICAJ
c3RydWN0IGNsayAqY2xrOw0KPiA+ICAJc3RydWN0IHJlZ3VsYXRvcl9idWxrX2RhdGEgcmVndWxh
dG9yc1szXTsNCj4gPg0KPiA+IC0JZW51bSBtdDlwMDMxX21vZGVsIG1vZGVsOw0KPiA+ICsJdTMy
IGNvZGU7DQo+ID4gIAlzdHJ1Y3QgYXB0aW5hX3BsbCBwbGw7DQo+ID4gIAl1bnNpZ25lZCBpbnQg
Y2xrX2RpdjsNCj4gPiAgCWJvb2wgdXNlX3BsbDsNCj4gPiBAQCAtNzE0LDEyICs3MDksNyBAQCBz
dGF0aWMgaW50IG10OXAwMzFfaW5pdF9jZmcoc3RydWN0IHY0bDJfc3ViZGV2DQo+ICpzdWJkZXYs
DQo+ID4gIAljcm9wLT5oZWlnaHQgPSBNVDlQMDMxX1dJTkRPV19IRUlHSFRfREVGOw0KPiA+DQo+
ID4gIAlmb3JtYXQgPSBfX210OXAwMzFfZ2V0X3BhZF9mb3JtYXQobXQ5cDAzMSwgc2Rfc3RhdGUs
IDAsIHdoaWNoKTsNCj4gPiAtDQo+ID4gLQlpZiAobXQ5cDAzMS0+bW9kZWwgPT0gTVQ5UDAzMV9N
T0RFTF9NT05PQ0hST01FKQ0KPiA+IC0JCWZvcm1hdC0+Y29kZSA9IE1FRElBX0JVU19GTVRfWTEy
XzFYMTI7DQo+ID4gLQllbHNlDQo+ID4gLQkJZm9ybWF0LT5jb2RlID0gTUVESUFfQlVTX0ZNVF9T
R1JCRzEyXzFYMTI7DQo+ID4gLQ0KPiA+ICsJZm9ybWF0LT5jb2RlID0gbXQ5cDAzMS0+Y29kZTsN
Cj4gPiAgCWZvcm1hdC0+d2lkdGggPSBNVDlQMDMxX1dJTkRPV19XSURUSF9ERUY7DQo+ID4gIAlm
b3JtYXQtPmhlaWdodCA9IE1UOVAwMzFfV0lORE9XX0hFSUdIVF9ERUY7DQo+ID4gIAlmb3JtYXQt
PmZpZWxkID0gVjRMMl9GSUVMRF9OT05FOw0KPiA+IEBAIC0xMTA0LDcgKzEwOTQsNiBAQCBtdDlw
MDMxX2dldF9wZGF0YShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQ0KPiA+DQo+ID4gIHN0YXRp
YyBpbnQgbXQ5cDAzMV9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KSAgew0KPiA+IC0J
Y29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgKmRpZCA9IGkyY19jbGllbnRfZ2V0X2RldmljZV9p
ZChjbGllbnQpOw0KPiA+ICAJc3RydWN0IG10OXAwMzFfcGxhdGZvcm1fZGF0YSAqcGRhdGEgPSBt
dDlwMDMxX2dldF9wZGF0YShjbGllbnQpOw0KPiA+ICAJc3RydWN0IGkyY19hZGFwdGVyICphZGFw
dGVyID0gY2xpZW50LT5hZGFwdGVyOw0KPiA+ICAJc3RydWN0IG10OXAwMzEgKm10OXAwMzE7DQo+
ID4gQEAgLTExMjksNyArMTExOCw3IEBAIHN0YXRpYyBpbnQgbXQ5cDAzMV9wcm9iZShzdHJ1Y3Qg
aTJjX2NsaWVudCAqY2xpZW50KQ0KPiA+ICAJbXQ5cDAzMS0+cGRhdGEgPSBwZGF0YTsNCj4gPiAg
CW10OXAwMzEtPm91dHB1dF9jb250cm9sCT0gTVQ5UDAzMV9PVVRQVVRfQ09OVFJPTF9ERUY7DQo+
ID4gIAltdDlwMDMxLT5tb2RlMiA9IE1UOVAwMzFfUkVBRF9NT0RFXzJfUk9XX0JMQzsNCj4gPiAt
CW10OXAwMzEtPm1vZGVsID0gZGlkLT5kcml2ZXJfZGF0YTsNCj4gPiArCW10OXAwMzEtPmNvZGUg
PSAodWludHB0cl90KWkyY19nZXRfbWF0Y2hfZGF0YShjbGllbnQpOw0KPiA+DQo+ID4gIAltdDlw
MDMxLT5yZWd1bGF0b3JzWzBdLnN1cHBseSA9ICJ2ZGQiOw0KPiA+ICAJbXQ5cDAzMS0+cmVndWxh
dG9yc1sxXS5zdXBwbHkgPSAidmRkX2lvIjsNCj4gPiBAQCAtMTIyNiwxOSArMTIxNSwxOSBAQCBz
dGF0aWMgdm9pZCBtdDlwMDMxX3JlbW92ZShzdHJ1Y3QgaTJjX2NsaWVudA0KPiAqY2xpZW50KQ0K
PiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkIG10OXAw
MzFfaWRbXSA9IHsNCj4gPiAtCXsgIm10OXAwMDYiLCBNVDlQMDMxX01PREVMX0NPTE9SIH0sDQo+
ID4gLQl7ICJtdDlwMDMxIiwgTVQ5UDAzMV9NT0RFTF9DT0xPUiB9LA0KPiA+IC0JeyAibXQ5cDAz
MW0iLCBNVDlQMDMxX01PREVMX01PTk9DSFJPTUUgfSwNCj4gPiAtCXsgfQ0KPiA+ICsJeyAibXQ5
cDAwNiIsIE1FRElBX0JVU19GTVRfU0dSQkcxMl8xWDEyIH0sDQo+ID4gKwl7ICJtdDlwMDMxIiwg
TUVESUFfQlVTX0ZNVF9TR1JCRzEyXzFYMTIgfSwNCj4gPiArCXsgIm10OXAwMzFtIiwgTUVESUFf
QlVTX0ZNVF9ZMTJfMVgxMiB9LA0KPiA+ICsJeyAvKiBzZW50aW5lbCAqLyB9DQo+ID4gIH07DQo+
ID4gIE1PRFVMRV9ERVZJQ0VfVEFCTEUoaTJjLCBtdDlwMDMxX2lkKTsNCj4gPg0KPiA+ICAjaWYg
SVNfRU5BQkxFRChDT05GSUdfT0YpDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIG10OXAwMzFfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAtCXsgLmNvbXBhdGlibGUgPSAiYXB0aW5h
LG10OXAwMDYiLCB9LA0KPiA+IC0JeyAuY29tcGF0aWJsZSA9ICJhcHRpbmEsbXQ5cDAzMSIsIH0s
DQo+ID4gLQl7IC5jb21wYXRpYmxlID0gImFwdGluYSxtdDlwMDMxbSIsIH0sDQo+ID4gLQl7IC8q
IHNlbnRpbmVsICovIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImFwdGluYSxtdDlwMDA2Iiwg
LmRhdGEgPSAodm9pZA0KPiAqKU1FRElBX0JVU19GTVRfU0dSQkcxMl8xWDEyIH0sDQo+ID4gKwl7
IC5jb21wYXRpYmxlID0gImFwdGluYSxtdDlwMDMxIiwgLmRhdGEgPSAodm9pZA0KPiAqKU1FRElB
X0JVU19GTVRfU0dSQkcxMl8xWDEyIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImFwdGluYSxt
dDlwMDMxbSIsIC5kYXRhID0gKHZvaWQNCj4gKilNRURJQV9CVVNfRk1UX1kxMl8xWDEyIH0sDQo+
ID4gKwl7IC8qIHNlbnRpbmVsICovIH0NCj4gDQo+IEkga25vdyBpdCBtaWdodCBzb3VuZCBub3Qg
bmVjZXNzYXJ5LCBidXQgaXNuJ3QgaXQgYmV0dGVyIHRvIHdyYXAgdGhlDQo+IGZvcm1hdCBpbiBz
b21lIHNvcnQgb2YgcGVyLW1vZGVsIHN0cnVjdHVyZS4gSXQgd291bGQgYXZvaWQgYSBmZXcgdHlw
ZQ0KPiBjYXN0cyB0b28uIFVwIHRvIHlvdSB0aG91Z2gNCg0KVGhlIHByb2JsZW0gd2l0aCBzdHJ1
Y3R1cmUgaXMsIGl0IHdpbGwgaGF2ZSBvbmUNCnZhcmlhYmxlIGVudHJ5LiBJIGdvdCBzb21lIGZl
ZWRiYWNrIHJlbGF0ZWQgdG8gc2ltaWxhcg0KcGF0Y2hlcyBub3QgdG8gYWRkIGEgc2luZ2xlIHZh
cmlhYmxlIHRvIHN0cnVjdHVyZQ0KYW5kIHVzZSB0aGUgdmFsdWUgZGlyZWN0bHkgaW5zdGVhZC4N
Cg0KQ2hlZXJzLA0KQmlqdQ0KDQo+IA0KPiA+ICB9Ow0KPiA+ICBNT0RVTEVfREVWSUNFX1RBQkxF
KG9mLCBtdDlwMDMxX29mX21hdGNoKTsNCj4gPiAgI2VuZGlmDQo+ID4gLS0NCj4gPiAyLjI1LjEN
Cj4gPg0K
