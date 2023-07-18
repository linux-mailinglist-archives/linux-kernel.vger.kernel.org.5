Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47779758069
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbjGRPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjGRPHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:07:43 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2105.outbound.protection.outlook.com [40.107.114.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080A891;
        Tue, 18 Jul 2023 08:07:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0hTQaf+3TcMwOp7fRj0V1TEc7x7bUGPvv55HyQ7hwQukePGItL+JMfq2tT+XQZhjEZFhuxRswK1OTdPD9z6ZWIx/q4myKCodL72uPVphNJhw+KV5r/jIh/CHAzuAdoelY6lYT80BMhbqJQytNPv+y5NAAr6olyrF7QoNi6y/AiUJLNUbT02WRj2EQYksd0Bt7j+qYrgNLclTc+AMowpdVN8rjVeMRC0fLJf4rDMbsvLLyX04GSzhbG4UA91oXqIt/qkEeYCElsMC3X/Hmf2jdOya1QEEcUgJSduKhqpe3WmPsx09Sn9MtsBDCMlbGQxub1nzJIKPVUGRYOFnK8/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/Eg83XT/OZY3GaSdzfbgiHBD3psOG2rMQ/50F3KGaY=;
 b=JlIOEzAtRPJg0cibVtKokA0a9zq16Xjh4e6XO228u4tscHv3dSxnOWWp7TLiOXQs3nsBetMVPh8Ri3GLNp1S2qoPj56SXJdTarnP+HLfmSFQk1Pa5bSk1smExZiUlyG/QUZaPnaJdylSVgDJSeVZxeWdfUVNQb4uUV9Bu7g/uGrwAnVeBdaa0WxdJguYxhj17IpeQ7wE/wINeBOBaq7p4X98D+S4GHpkZVVrQ/aZNDErYG8fb8+yKDPsWYnHOCK1we29BCJpwLrBIyOr0kS9O/z3mD8ZzUm9QMqB3ftx3hPSA3mcHGJFIUWhyfjsR69DuzHqEGXZ1+rHxaw+cgYBjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/Eg83XT/OZY3GaSdzfbgiHBD3psOG2rMQ/50F3KGaY=;
 b=evYXRz3kTzTvSHE+l2UWNitAJpIJyzHiQ7CfXGTeGxOllTkoL56d2P43x5oKsc1c68DOmw7Uw7lbBzg2MGEGy7yxj4xlO9jAcLxxOc9S+zVc/hKf0UhjIf2vrvjNW1sRmTNslX13ozaE1AGWrjgL9W9hfx+o81vskgIOlljag7k=
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com (2603:1096:400:169::11)
 by TYWPR01MB11933.jpnprd01.prod.outlook.com (2603:1096:400:3fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 15:07:35 +0000
Received: from TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0]) by TYWPR01MB8775.jpnprd01.prod.outlook.com
 ([fe80::231a:7573:1ada:5bc0%7]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 15:07:35 +0000
From:   Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To:     Randy Dunlap <rd.dunlab@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
CC:     Biju Das <biju.das.jz@bp.renesas.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>
Subject: RE: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Topic: [PATCH v2] pwm: fix pwm-rz-mtu3.c build errors
Thread-Index: AQHZuULZAAUI+Oq1mUSjty3QZPTfk6+/b6uggAApK4CAAAeO8A==
Date:   Tue, 18 Jul 2023 15:07:35 +0000
Message-ID: <TYWPR01MB877573685497B68FFB2590BBC238A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
References: <ac8d6190-06ae-b538-1293-07efedbfe94e@gmail.com>
 <TYWPR01MB877550F95CF000B63E9AD022C238A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
 <364507a5-ea2e-6280-cc9e-394e09d6edf7@gmail.com>
In-Reply-To: <364507a5-ea2e-6280-cc9e-394e09d6edf7@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB8775:EE_|TYWPR01MB11933:EE_
x-ms-office365-filtering-correlation-id: 09cf32f3-f5dd-46d3-5b9d-08db87a0b804
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Tq1qUVlH4/TT6mqnlNDZLgY31z3gJ5s6aeQqC2TIMMtYam1HSW0LhAkQO9Yx4SCV9k6DgaeAHoIVIRmq6P5YcrgiUrBW80HTiaKEOx9YV6MtxUngRzZjUeb9vd7AWOlPbPniKlzE8F0e/MBQAGX3Q0wDu0WIWbNKodUQGePDN7WtTurMkAmIqXb8/3agxxqcMOMXd6kF6pCRqP88K71orS+IrFpWEpXt1pEir9RdbmezonWqvCjZLEgm3vb8jdo5EhjufpcgAH2WUrlK6vH9hrnH90DG2QuGLJzrjEPi6P0SwhbavlDrXsNwSHXC4hr7yLkqZrarFxwqKdq/d2yPhiarc/n0qZEvg4m0rO2eXJ8T7JZrMQpFbJosGJjqpYphUKMMpYt4qHpbXkQYTzXLGcWDs3NX7tTZ9e/eyfMObd6YOhiCtV3NQTZL1yaobN15Wzse3Z/q0Gve2w6O6FvgMnqjpVDcPBCR2ofqMAT79jrisdzjDICuKUzOODUvXuIWShUU+r6dX+OEUIa6+gx9/qTYhseOm5eFx+H+cZhLKcqU5xEcruDvrClp5sbVKl0cYX+lAHpqdu1favopCxCdrXEvUI4fXqNakzfkT9IXw3Pon+D7xGmTUZr8it5nDeb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8775.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(451199021)(66556008)(66476007)(66446008)(54906003)(110136005)(186003)(86362001)(64756008)(76116006)(4326008)(66946007)(478600001)(41300700001)(9686003)(316002)(7696005)(71200400001)(38100700002)(8936002)(8676002)(38070700005)(6506007)(5660300002)(52536014)(83380400001)(2906002)(122000001)(53546011)(55016003)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0ZCL2dMeVdJMGRwNmhVbFRxazVLMWVneDI2NkNSaThuSGhvUFFyN3ZZaWtk?=
 =?utf-8?B?cy9JTDUrUnVxUERSblRQQnNYcm1NVTdIM3hmRlNIeGVtVVdEeHhmdEQvZSt4?=
 =?utf-8?B?Q1hyakRKWGpncnNkUmdKVEd2VWZtVzNxcWdzYTh1RDNIWWc3aEFSeEg4a3Fp?=
 =?utf-8?B?eUJCZ3NCdE1UUkM0ZTY0aldTa3MzZnp5cmtwWUNSMURuZ1BJQ1FtRFh3aTla?=
 =?utf-8?B?UjI4dkI5U2U2dTdIRjBCcVdBT2M5QnR3MXA1dFhTSmlpTGEzdE9vUVJNV3dq?=
 =?utf-8?B?clFMNU5sMjdEcklNdUFJSjZjVmpSQXc2R2tJd1lPNXlvR0ZQbGxJaDE2dnpz?=
 =?utf-8?B?SFhCVmMrTXk5cUlTUm85YW1NaVpQU3dRTHFkaXY3amhMeUFHOFMvUDd1RklV?=
 =?utf-8?B?RklmR2VGRkxQUUI4aThYTmY0ck9WWFRwS1BuQ2hSQ1RUbVY0Ukd4K3ViVE11?=
 =?utf-8?B?R1FCME1HcFFkQTd1TjBmWUJRaDBTcGRrOHRDL0JUQWNIUmFqdC9UalZyVmd6?=
 =?utf-8?B?NXhtOXBjU25NNEpTNGFkUkN6S0JaY1JiaWRKaStJWms4c2JmZ0tOeWFQaGV2?=
 =?utf-8?B?dkNoOU9iNDllRGQ5UkUwUnJESzN3SmxmWGFyOGEwV2htSHNmN2hCWUJZZUVl?=
 =?utf-8?B?QldjNWFjWkNjTVRDME5GZ0x3LzIySFBCQVRxNC9hQWZyVCtUK25UYnloT09x?=
 =?utf-8?B?cHpYQWNsQ2phQmxvemtDRjRaYSt1d1Z1QlMzR2lRbXB2Y01aZG5WcEJab2hG?=
 =?utf-8?B?UU1lZ0pibitMUlVVV0Z0MmM2ZWtVNDgrQkE0Y0RSMVNUSEVLSGI2emJSVEFQ?=
 =?utf-8?B?bWJqdzVlVG5RZmd3OHRiWEYvdDdEd3g5cHhXNSt0TzZsTTlLS2RrbWR6RVpt?=
 =?utf-8?B?MS9TdUlCSXFQM0VvOThlQmt0UzI0ank0MkZGMkp0eDNIQlJoMTFmNk1lNXNi?=
 =?utf-8?B?T2ZuZGI5ZUhOZUNaYnBPZzRnQjJCOERTS3BLQUg3ZmIxeFgwd2VqSTk1Rnd0?=
 =?utf-8?B?ajE5UVJiUG8zNWlyM3lwS1RGY2pPNEhuajJjNkRrUHhCL1JoY2NnY1k0SnR4?=
 =?utf-8?B?Z2NXcWZJOE40MUdOTGQ5UGVpQk5WMW9Ub1E1ajF6c3cxd3hkQXZzbTZqeGxh?=
 =?utf-8?B?RTdmaGprdmdxNGErQ2I2V0ovMzZQb1JGRnJKUGtQSnVpNEhaMzlmN2gxS3pT?=
 =?utf-8?B?ekN5WmM4WFRFSkxMWm52SUQ2Z3d3S2JNQlRnbU4wTkxDZko4Qzl3VXpoN1kw?=
 =?utf-8?B?bjZuVXlPdHZoS3hDaWJ5dkNDUXRiOW5zSmdwai9PZkExa1lZN0syL2N5WnBa?=
 =?utf-8?B?Zkd2VTJrQXozZ1p3NkVtQ05DZDZyRkc4WUdyK0h1dnoxRzIwUGhKNHRHL2lI?=
 =?utf-8?B?WlRMbmd2NjFTaWJ3ekE2MDNLT0F0d1ExTTc1RlRsSVFrS2NZTXNmZWJGb1V6?=
 =?utf-8?B?Y2JOcTd2bjJQWDlYRnkxUW9JemhycnRhTTlXK20vTS9RRzNwQW83ZlNvYWlM?=
 =?utf-8?B?QitPdSs5QzhUZ3VOaHYxWE45VGN6T2NWQytkUThzSGpjRjhRMWZwTUluTWVF?=
 =?utf-8?B?NHloQkd0c1VsVWtNN2xXN01xb3RwcHc3eE92ZjdYZ3BZZmZqeUMvWitPNnlQ?=
 =?utf-8?B?bjBxb001Rk0vY3lvMGxJVnBVV1N2NkZGbWU3Q05iT3o4bmZtU0I5SDNGTjll?=
 =?utf-8?B?cUN3QW1WRTYxTmIwcEY5L21QejlZQjZya0pyRW1UdjNYeHF0b0RtbENDeW0y?=
 =?utf-8?B?dG9QanFxM1lKZ0tGRk13Z0JZd040QUdBaWhtRzNvanNxckhkb3J1OUFtWVVX?=
 =?utf-8?B?MDcxMkluVllKQWZjYysrN2pISEI4NTNiUTgwaHhnandpalZkUXNEaEZ6U1Zm?=
 =?utf-8?B?M3FzVlNidWJ0d3Ava0tSbHFxRmt5ck82eTM4cDBQMUpFUS91UnRLdVBVUWpx?=
 =?utf-8?B?ZitMRjdKU09xNFlzMGZ3blpraXlibEUzOXBKZklQRjV3WnJWUk53eDlPcUVK?=
 =?utf-8?B?WUhncjQrWW80TmRKOFFYYkdpWlZYbnFRT0dkU0FYWEI0MHJlNlNMOEpLWGlv?=
 =?utf-8?B?clJ3eU13SHFvdXVnVVIxMjFpNEUyN1ZsNlJlMGtSWFRQM2ZHTjN6dU1XTjhh?=
 =?utf-8?Q?2JYVNJrv2C/Bme8ZXSv4yD6O0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8775.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cf32f3-f5dd-46d3-5b9d-08db87a0b804
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2023 15:07:35.4483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qAr/6U5vzDg8skHbsJzak3BqOICvPZssBoM9OfjxKIFSc9pfiJLvdvfnMVHzjXw9OsdfutGcXhEycFLbOIAiqB7pyJfBxIlK0sP68ip+ihk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUmFuZHksDQoNCj4gRnJvbTogUmFuZHkgRHVubGFwIDxyZC5kdW5sYWJAZ21haWwuY29tPg0K
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBwd206IGZpeCBwd20tcnotbXR1My5jIGJ1aWxkIGVy
cm9ycw0KPiANCj4gT24gNy8xOC8yMyAwNToxMywgRmFicml6aW8gQ2FzdHJvIHdyb3RlOg0KPiA+
IEhpIFJhbmR5LA0KPiA+DQo+ID4+IEZyb206IFJhbmR5IER1bmxhcCA8cmQuZHVubGFiQGdtYWls
LmNvbT4NCj4gPj4gU3ViamVjdDogW1BBVENIIHYyXSBwd206IGZpeCBwd20tcnotbXR1My5jIGJ1
aWxkIGVycm9ycw0KPiA+Pg0KPiA+PiBGcm9tOiBSYW5keSBEdW5sYXAgPHJkLmR1bmxhYkBnbWFp
bC5jb20+DQo+ID4+DQo+ID4+IFdoZW4gKE1GRCkgUlpfTVRVMz1tIGFuZCBQV01fUlpfTVRVMz15
LCB0aGVyZSBhcmUgbnVtZXJvdXMgYnVpbGQNCj4gPj4gZXJyb3JzOg0KPiA+Pg0KPiA+Pg0KPiA+
PiBNb2RpZnkgdGhlIGRlcGVuZGVuY2llcyBvZiBQV01fUlpfTVRVMyBzbyB0aGF0IENPTVBJTEVf
VEVTVCBpcw0KPiA+PiBzdGlsbCBhbGxvd2VkIGJ1dCBQV01fUlpfTVRVMyBkZXBlbmRzIG9uIFJa
X01UVTMgaWYgaXQgaXMgYmVpbmcNCj4gYnVpbHQNCj4gPj4gYnV0IGFsc28gYWxsb3cgdGhlIGxh
dHRlciBub3QgdG8gYmUgYnVpbHQuDQo+ID4+DQo+ID4+ICBkcml2ZXJzL3B3bS9LY29uZmlnIHwg
ICAgMyArKy0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPj4NCj4gPj4gZGlmZiAtLSBhL2RyaXZlcnMvcHdtL0tjb25maWcgYi9kcml2ZXJz
L3B3bS9LY29uZmlnDQo+ID4+IC0tLSBhL2RyaXZlcnMvcHdtL0tjb25maWcNCj4gPj4gKysrIGIv
ZHJpdmVycy9wd20vS2NvbmZpZw0KPiA+PiBAQCAtNTA1LDcgKzUwNSw4IEBAIGNvbmZpZyBQV01f
Uk9DS0NISVANCj4gPj4NCj4gPj4gIGNvbmZpZyBQV01fUlpfTVRVMw0KPiA+PiAgCXRyaXN0YXRl
ICJSZW5lc2FzIFJaL0cyTCBNVFUzYSBQV00gVGltZXIgc3VwcG9ydCINCj4gPj4gLQlkZXBlbmRz
IG9uIFJaX01UVTMgfHwgQ09NUElMRV9URVNUDQo+ID4+ICsJZGVwZW5kcyBvbiBDT01QSUxFX1RF
U1QNCj4gPj4gKwlkZXBlbmRzIG9uIFJaX01UVTMgfHwgUlpfTVRVMz1uDQo+ID4NCj4gPiBJc24n
dCB0aGlzIGEgdGF1dG9sb2d5Pw0KPiANCj4gTm90IGF0IGFsbC4gSXQncyB1c2VkIGluIEtjb25m
aWcgcXVpdGUgYSBiaXQuDQo+IFRoaXMgaXMgdHJpc3RhdGUgbG9naWMuDQo+IA0KPiBJdCBzYXlz
IHRoYXQgaWYgUlpfTVRVMyBpcyB5L20sIFBXTV9SWl9NVFUzIGlzIGxpbWl0ZWQgYnkgdGhhdC4N
Cj4gQnV0IGlmIFJaX01UVTMgaXMgbiwgUFdNX1JaX01UVTMgY2FuIGJlIHkgb3IgbS4NCj4gDQo+
IElzIHRoYXQgY2xlYXJlcj8NCg0KSXQgaXMsIHRoYW5rcyBmb3IgdGhlIGV4cGxhbmF0aW9uIQ0K
DQpDaGVlcnMsDQpGYWINCg0KPiANCj4gLS0NCj4gflJhbmR5DQoNCg==
