Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFB17BA537
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241785AbjJEQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239727AbjJEQMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:36 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A60B57EDD;
        Thu,  5 Oct 2023 08:48:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DU03WLD483Rgc+KU37G/uYVfdHWWzV43FJL6QY4M2j1pdPeqvBojT1uFXhQUt7pMRTUjhtpNoPm4xE4nIIzllB44YjtbxugT9rMAbWauUamORkyhl1UoBbCqkeiVcyrceitI40UfapqoQjZDHSvV0Ei/I7BBh/V9BUCSJUSZ0J6Iz8yavao/ZKLfktHUZMjkpZpwJiyYpMy+uwNniAja7aU1aj0KYYlOiRzVE7iNTr4iGWG91qz8ey5sDsLJlOJd9cNIKZ/hC/mfsYD9qZmjrElFZ5X9tLnT02e4N6mbwmKISRuVKMmK5/vcPdOrFjnDDxHWTZbgpQ3TcqCWdm2Oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7zwibwE8OcaK3ya3oZJVb4f+k/Kbl9oGXUsxMhgGAgQ=;
 b=GZDoNqqOxMY+j/KVTlZooKUQ6ExW1lZuwjWydONkscb5/8dQvL5ounI2V5cQulaJoXqTuhS6gCHDNz0sOYHLxdi804LGwfLZibM5NHQNjvTe9qvGBnj+j4TSpxEuyn4bBe20/+yrAFusDqLYVthMSBps1hHakiWFmnIFwf5TJqJKappQzIX6NS9zWZ7BtHy3VbgHWQDWLovtegvky/urn/NIVI7heu7zwzXohLPDQ5P0t054exOzAAmUzWQB8OdkJv9FhKRim4tNc323PAySLCE2g50X7FXjuF2KITGEr6GjXbI0wGHbz0QFygpq6xr6TC8LxiXLJE5mcE9YIEzs4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7zwibwE8OcaK3ya3oZJVb4f+k/Kbl9oGXUsxMhgGAgQ=;
 b=A+QPOf4/L6zgvYAbXz7d99klyvMtUqOoaEMQsv5s4WcVy06lEz/uZ9kGYGi0UT2DE69M4bG436AQtvJcNs8KAZ50lRKHQiw1DvjxZxQxNB+nsELIFgLMsHmVVyPvQlGHvbtzIPeidG2yaw+2GeqMmy517iUFr60++F+DJynhZ3w=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by OSZPR01MB8186.jpnprd01.prod.outlook.com (2603:1096:604:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 15:48:44 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::fb78:2e8c:f7f9:5629%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 15:48:44 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Lee Jones <lee@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v3 0/2] Match data improvements for pca955x driver
Thread-Topic: [PATCH v3 0/2] Match data improvements for pca955x driver
Thread-Index: AQHZ88dsO0axnR78PE2fJjAKMlDh77A7M2UAgAAjXYA=
Date:   Thu, 5 Oct 2023 15:48:44 +0000
Message-ID: <OS0PR01MB59221DB73988292DE753DF6F86CAA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20230930175615.13301-1-biju.das.jz@bp.renesas.com>
 <20231005131140.GC681678@google.com>
In-Reply-To: <20231005131140.GC681678@google.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|OSZPR01MB8186:EE_
x-ms-office365-filtering-correlation-id: 73a96c4d-1b61-4466-d270-08dbc5ba8e0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WWvTIc4GkPYcb2xII1VSHNtt2SX8C+wPoNA35+Vvn1wgaY4/U1ykzMS4fZYxUvl/+qpdUMZNq01jvrMlDQXEIXEoD+4zmPWB8/LFOmy5/9zoEn7phvb2SkxXPdnmbO2tct5ChNPhjbPcP7hL2tYmVJne27S63TjMdY0hNYtw7w3rhmHPbVm4iJwhlNrI28H2CKt51GRUMx91FnTzQ//fiD07GF5fEjOj5/ej/QgFueyN3uERXHw7ND/IsKkUoyuS5tsXsC/DTGITD6gOsIjFYTvVwZAkKMTwQcXm04TvhZkXRzExj55e/lVhgREm1F8YIlLvZQhBXigXTDXBN5Z9B7gY8xhi5xGiGKTJ9/g2sqmMbjX1O3qx7IhC7TZhpnmear9SW/BNfODY7k2px6gWu5KRU9EULePo8Soyf0LOTMEMntmPk6zZDQFh2inBUo/qkhSUK5qSQ0pxOnamekJtKIK3j1dxX6gpsZD9cKdK0qbaZHojwAxm9ALRgWfJKg+wsSnMLySuXDtSGWIn76AQp11BahUIgK1vr6ooh69w4p8ulr7sJg2LClFdY5gjc2Us0JWXIq6klvwRCT0jPbr3lHbB2sAj3ocs0n1CUfam+Qs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(9686003)(7696005)(6506007)(53546011)(71200400001)(86362001)(38070700005)(122000001)(38100700002)(33656002)(55016003)(966005)(2906002)(8676002)(478600001)(83380400001)(4326008)(52536014)(316002)(26005)(8936002)(41300700001)(64756008)(54906003)(66946007)(76116006)(6916009)(5660300002)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU9hdjF3dDZWckpOUFMwRFYybS9zaU11TXQ1QkFFb1k2VTVxVDYyRnNENlFJ?=
 =?utf-8?B?SktlbnZpZVNvWVFSb1A1RjJKbUIyTHRlaVRoVU9DRW1BSG9UUGxsZTlKYW9Y?=
 =?utf-8?B?TTZUMkxHUUFBQ2tmVkpUUEVQeTJ2SWU0c3lWM0ozeVhCeHdZbm8rc2Nscklh?=
 =?utf-8?B?bFlZWjRJVlFCcnhleGFDaGU4VlRKY0c5RFIyQWRRV3NWcU5ucHJ3ZGFXRXdv?=
 =?utf-8?B?clBTbUxYVnpJaDBFWEUvLy93T1Uzb3RSV2JJUnlYMlRIRUZzOE1DZVJmcXMy?=
 =?utf-8?B?QzZwMG9yb0dkQW5DS0t2MWVWUEFIRXhaUElmNC96R0JZYTFZR015UCsycy9V?=
 =?utf-8?B?WDl6d0JreE1lQ0U2bGh4WVFOQjNxZzZMTGl5amZ6eDluemVnVmpmQVhScEtI?=
 =?utf-8?B?cXhVSldXeVo3cmFsd3c5ekpNejByMXZja2tDVUR5Yi9KVkpISEc1ZGxYbFZ1?=
 =?utf-8?B?U1J6RE5ncGcrbEJGc3NwRUZOcER1R3MrR2JxaXZoUm9RN1dUcFI5cnA3Wis4?=
 =?utf-8?B?eURMNTE1Rm96VkUzUllDYmtOdEhWalM4QnAzWXFkU0cyeExYS2V5dGpvNjQr?=
 =?utf-8?B?RXhvT1haVEdQYTUzTCtlcWNPcUNnRzNiTmcrUXBkV2J0RWExZlovMkw5WlVu?=
 =?utf-8?B?RTdrdDBoTURnZzJGcGg4eHFFQURQY24zWEEyMVhjMnhkWlBUKzhTUmQ5V1FD?=
 =?utf-8?B?aXRJMHF6Q1FyZFRZQXZZdG82c2dIbTM4RXRvOVBUbk04MkFkbjRyVkhFV2Uw?=
 =?utf-8?B?c25MZnpFVThWM3hVREhjZ01nckVwNWtON1BWTlR1Y1B0UWtVY2xoUWthenB0?=
 =?utf-8?B?RnU3Q0N0MjdBUTh4Y3UwcHJ3RTRFQmUvQi92SFNQQ3c2WW4yeWVNNzAxaGFM?=
 =?utf-8?B?QndSSHRnUUp3VHFoYlEyS0ZlYjFSczBrYnFyOWc1WEFQV2Vhakd6QS9ySTlC?=
 =?utf-8?B?cDhXUzh6QnZaMEVqYVQ5ZkZ2RDNMcW5BSWN3d24wQ05YTmVEY0Q3QWZ6N29p?=
 =?utf-8?B?dDdJTlJSWUorbVFHbjRRYzZWdHlmdDcwSkM3RGlQNDcwd0UxRnQ3YnRUL256?=
 =?utf-8?B?K0syclRQWG96VmhSTVhuOVNkQmQ0eW9aRHJjdys5dnlYWENlaSt6MktPMXRz?=
 =?utf-8?B?REFCY3E1bElkdGpKZFppOXdXQm82QmFpb1FJS2ZEckhhRjNSc015c0tFcFhm?=
 =?utf-8?B?NjQrU2lJQmR4TDJRcVcrYjRVNWtrcStoK2dFT2p2Ry8weGFVU1BERzBKS0pH?=
 =?utf-8?B?ZDcrMWVSUUt6d2Nhb2VxNmNzQWFYakVMYURlZWc1Mk81UnI0MGkxSnBMZStC?=
 =?utf-8?B?d0E5c3RWUk1XaXFYK0UwV0xJRmU2MzRUZ1dVUEpOcU0wR09KZG03aXY4K0Mw?=
 =?utf-8?B?V2ZoNmZ3MXZCdDdGanBmMzdYQTM1K0ZHcEV3MlB2VjJJRlZBaEg3UmxPQVBC?=
 =?utf-8?B?dTVlc3RKM0VGa0xuaEZ6T2lRU0JnU3RQQ3FBUFFDYTlnNnltYmpFNEV3V1hQ?=
 =?utf-8?B?WFcxeXd1KzRsbS9HaWc4U000UFk0UVFDQjczUlpHYWtEUXIvUDZWenNwYUV6?=
 =?utf-8?B?L2V4NCtaS2wremQxVkE2UmpnQVV1NzJMTGNEOEtNZjBCcTNmVjJMdk9MTFQr?=
 =?utf-8?B?TVNQdnpCaUN4N2l6NisvWk02Q1ZiazgvbW4vOEVKbytGUWFhaXlJWEQ2Rkt3?=
 =?utf-8?B?OWRUNEIxMVBoRVlPNEZYZXI0ZlVtdlc5amJBdEM5eXhIUlVrbHBoSXU3d1hv?=
 =?utf-8?B?OGc5ZjNuczJZWnJBeldsT2cvM3poUU1jTHRaNUZneDVpaTZDVUNkeVNIQ3gx?=
 =?utf-8?B?aHpKVi9NN3RRY2JZZUxldFdnSGtUWDhyZzRRV2tOUVRzbXFsNWx2NERUODNT?=
 =?utf-8?B?OE8wOGRneEdzcTg3dk9uVmxYbm9jSkdmRFdWbFYyMU9tMDQwSE9kNnZCcm5q?=
 =?utf-8?B?YlVnQTM5dXNPcTZjV2VFRDdyd2hxRFlMSU9xT0xTQVE3V3FNdzc4ZTE2MDlJ?=
 =?utf-8?B?ZWtSVDJDTHczTUxjcXZaSG5tUXdZN1EvSTVVR2t4THpGWG9hbkh2U0t4NE91?=
 =?utf-8?B?UnNLSDFlNFVUcktsU0x4QzhXenJldThsMWpYWUF2bmRqeTB4ampYNWJFS0JK?=
 =?utf-8?B?a2MxOFNqVkxVV2IzdjM4ZDJTMGJjbUgrblVteHNKbUxzWlM0M1cyajFFSCtl?=
 =?utf-8?B?b1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a96c4d-1b61-4466-d270-08dbc5ba8e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 15:48:44.0433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gDhDJmybQCpg5xqr9ZonmYxsrTP6cWs6TkD/EmKKHPRo7N7RhZlKGNjH/FBqdKrA6vTWxN8ejj+f+m8Lwv0uq5g1KEx36kqj5KGsQ6zi1Eo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8186
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGVlIEpvbmVzLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExl
ZSBKb25lcyA8bGVlQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IFRodXJzZGF5LCBPY3RvYmVyIDUsIDIw
MjMgMjoxMiBQTQ0KPiBUbzogQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29tPg0K
PiBDYzogUGF2ZWwgTWFjaGVrIDxwYXZlbEB1Y3cuY3o+OyBsaW51eC1sZWRzQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEJpanUgRGFzIDxiaWp1LmRh
cy5hdUBnbWFpbC5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4gPGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAwLzJdIE1hdGNoIGRhdGEg
aW1wcm92ZW1lbnRzIGZvciBwY2E5NTV4IGRyaXZlcg0KPiANCj4gT24gU2F0LCAzMCBTZXAgMjAy
MywgQmlqdSBEYXMgd3JvdGU6DQo+IA0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVzIGFpbXMgdG8gYWRk
IG1hdGNoIGRhdGEgaW1wcm92ZW1lbnRzIGZvciBwY2E5NTV4IGRyaXZlci4NCj4gPg0KPiA+IFRo
aXMgcGF0Y2ggc2VyaWVzIGlzIG9ubHkgY29tcGlsZSB0ZXN0ZWQuDQo+ID4NCj4gPiB2Mi0+djM6
DQo+ID4gICogQWRkZWQgUmIgdGFnIGZyb20gQW5keS4NCj4gPiAgKiBEcm9wcGVkIHRhYnMgZnJv
bSBzdHJ1Y3QgcGNhOTU1eC4NCj4gPiB2MS0+djI6DQo+ID4gICogQWRkZWQgUmIgdGFnIGZyb20g
TGVlIEpvbmVzIGZvciBwYXRjaCMxLg0KPiA+ICAqIEFkZWVkIHBhdGNoIzIgZm9yIGNsZWFudXAg
b2YgT0YvSUQgdGFibGUgdGVybWluYXRvcnMuDQo+ID4NCj4gPiBCaWp1IERhcyAoMik6DQo+ID4g
ICBsZWRzOiBwY2E5NTV4OiBDb252ZXJ0IGVudW0tPnBvaW50ZXIgZm9yIGRhdGEgaW4gdGhlIG1h
dGNoIHRhYmxlcw0KPiA+ICAgbGVkczogcGNhOTU1eDogQ2xlYW51cCBPRi9JRCB0YWJsZSB0ZXJt
aW5hdG9ycw0KPiA+DQo+ID4gIGRyaXZlcnMvbGVkcy9sZWRzLXBjYTk1NXguYyB8IDcxICsrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI5
IGluc2VydGlvbnMoKyksIDQyIGRlbGV0aW9ucygtKQ0KPiANCj4gVGhlc2Ugbm8gbG9uZ2VyIGFw
cGx5Lg0KPiANCj4gUGxlYXNlIHJlYmFzZSBhbmQgc3VibWl0IGEgW1JFU0VORF0gc28gSSBjYW4g
YXBwbHkgdGhlbS4NCg0KQ2FuIHlvdSBwbGVhc2UgcG9pbnQgbWUgdG8gdGhlIHRyZWUgSSBuZWVk
IHRvIHJlYmFzZT8NCg0KSSBiZWxpZXZlIHByZXZpb3VzbHkgSSBoYXZlIHJlYmFzZWQgd2l0aCBb
MV0sIFBsZWFzZSBjb25maXJtLg0KDQpbMV0NCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L2xlZS9sZWRzLmdpdD9oPWZvci1sZWRzLW5leHQNCg0KQ2hlZXJz
LA0KQmlqdQ0KDQo=
