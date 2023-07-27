Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66394765377
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbjG0MUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbjG0MUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:20:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584A72D43;
        Thu, 27 Jul 2023 05:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690460418; x=1721996418;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=pm571lf/NF5VKoby4JVT29zsyb/bRjuQ6aiM/zU3oaA=;
  b=1HClK4pzHyUfOG2AbXv0DnufHc5g3zHIZAjiI/ZJAFc53sKQpqbU2iux
   p9IvGOMlvM7hlQxKeYOPb7XU6FQ1QrDW9xppveb9qKIhoXfeD05KLRXWV
   O38GthGzDEtPy6gWqRUHXYyFKtOviIjBnWdAflDZG9w6Zeesd7dbfAitW
   nvp2fh3nF+O+7RyVTF2e5vUQvZImQYS/uknNChsx3JLoVZ2iQn7Z8CBLX
   93sT0IR7QO1o5iVtQLde5TCxM9EY8UbLBJWukcgZmtpXb27mmtSSY5pB8
   n4oGv7NmAcU5TdFbzw/0BGkrfZHoUVX0+1vJ4OUpnM8/Jj1LN+gEPL225
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="225568596"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2023 05:20:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 27 Jul 2023 05:20:05 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 27 Jul 2023 05:20:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V0Xs617vMAcNv7HfgsT1lmOwsOpUcbMoV7meI8QN29gTaGGwDeRn3R9ppbD/c6vFR+TK896t4pnSFhd3AxcIVX3kR0lYPpS0uAiP5Ldz0NEa9pLHTu5Rv4UvKgVkdE80dAqLW+fJzdxi8Bk+UDQ2K4JicsIMnMeF+Ij2cOfXgI9muzb4R33O6EaONxh0k7oekTi859iPjgjyJV5JdXKHXsJXk2VtTQctqnp1jKRIgYOPzHMaZO3FKBHJaPOxDtO8Y7oUYV3YSBcSMAiqzm49xokwvi420F50P08UufI+P/NT4oC0INoFNVy81SKwOfx9DnQyizGuor/7LhXd/v9Mdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pm571lf/NF5VKoby4JVT29zsyb/bRjuQ6aiM/zU3oaA=;
 b=Z3RoMYmVqHqSkbuo7Jyp+DabdGLb5DdoWVhlFIbyQ59MNceIxtSbOS8VnuxV7IKjYDW/wbaldkPrKL+K6dR0LN8IQ9e7a44jtx50JddG9FQ4h1PBHdk58cjs6tdrxd9pVN6NFvUW7n9LnvkHhMkYvSeIjGhJ+/xT+197ueR27wvoqcplltaFriygKTd9l9qKBzkdtLuCyGn9xVF9ZeWAWf/EN75Yh6hLemR6gT4fSawvHTiY4jW4vYu6WAKtPwUwkFu6reimvoihJB3GKa9y6WDmPjF+XrKsNN25CNOvQt6fyfrOK4JTgmwHX6qFV8UuqL99HEjqh58xboQnk8QNPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pm571lf/NF5VKoby4JVT29zsyb/bRjuQ6aiM/zU3oaA=;
 b=Xoi0+q1YQxOyw1f31SqvA6Jcc8wXo6msQSUBfaDcUICoRGpHu7Za01uVaQGNyxoJ6HSivvUd0tp1RzAwpZ77QPi1Y+gk9Bj0RrU3Z8KR0EkxtWYylvdbXcz0Xlb0PEPtWU+OPSSerHXY64D3d3mOIUNVmUUT5JAqXV/APssyfFY=
Received: from SA1PR11MB7016.namprd11.prod.outlook.com (2603:10b6:806:2b6::8)
 by IA0PR11MB7910.namprd11.prod.outlook.com (2603:10b6:208:40d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Thu, 27 Jul
 2023 12:20:03 +0000
Received: from SA1PR11MB7016.namprd11.prod.outlook.com
 ([fe80::601d:b48f:3c57:26a4]) by SA1PR11MB7016.namprd11.prod.outlook.com
 ([fe80::601d:b48f:3c57:26a4%4]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 12:20:03 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <claudiu.beznea@tuxon.dev>, <frank.li@vivo.com>,
        <gregkh@linuxfoundation.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/30] usb: gadget/atmel_usba_udc: Use
 devm_platform_get_and_ioremap_resource()
Thread-Topic: [PATCH 08/30] usb: gadget/atmel_usba_udc: Use
 devm_platform_get_and_ioremap_resource()
Thread-Index: AQHZv7XSWm2uxR5m4EyjMvGHZd1Ar6/NGIeAgABxZoA=
Date:   Thu, 27 Jul 2023 12:20:03 +0000
Message-ID: <4e4e2a26-56b7-90c8-b0e9-8d4de639b237@microchip.com>
References: <20230726113816.888-1-frank.li@vivo.com>
 <20230726113816.888-8-frank.li@vivo.com>
 <9887e7a5-2422-4ab1-baf8-6eb0e27c1314@tuxon.dev>
In-Reply-To: <9887e7a5-2422-4ab1-baf8-6eb0e27c1314@tuxon.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB7016:EE_|IA0PR11MB7910:EE_
x-ms-office365-filtering-correlation-id: b3985a4b-e838-4f72-faf9-08db8e9bce48
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z50zZburJCNqWro4P6fXeNqMHIpd8wlRH1dQnU85yaTNQ9ap/DOSDy2YuQN/N2E2EAZJNvnEWOt6ZmfrCoDlKbwWnn4y0/DCBMOoWlFg66HE/jv989+UO5G2LaOV8RTBeybQImAVLjzYDZpRB0FW3SIBdH6myyQ5sjakRysR22OHZhxWi0xYta5Chm6vU6KGK3aZnwE4rXDgcp2hkY04bE2u4YSz1YXSUYOPWFmk3s/vkbIY4njOTq/j1zKhsrszhytbdv7JumDT/PYLsXoa5cDRjYIZ15cGy7swpfYSga9tgEzl84eFRBz/I6j29qs1PeY8AvUTk/yXghaJ29LfDRUswJbl74QxmV+z8mYz6nAN4NNTYSjkyzO8HG19GUcEwVp46Q8xsfVTjzcJ1m0F5PJOyLWdedvZr2QwJAjf6k9bacAYKrKCcAJWLFp2YOL48kWx2j/mWeum7UWkY7+H+3dVn1m319YAHw/OD4gQRfXvt0zLu1B7lhsusHQlz+LF6DtNQ70ikD0taZ7Ccueuy4ugjlJGYx7TSq/yE85Bo2dN2kCTIjxEK3CIJwTUgafKz68v/r7G+XfwRXmLrZt7YHCdz5XYdC1l9D45Rq4U5hBzpxn6mOnagTACOBiqaj6Rn9V+PQjcTs2n2DLsHfZTTqBq2rBTC4c94oYAQhyXmcm5bCBmePsCArvWG3acB3u5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB7016.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(366004)(39860400002)(136003)(376002)(451199021)(66446008)(91956017)(66946007)(66556008)(64756008)(54906003)(76116006)(66476007)(53546011)(122000001)(6506007)(31686004)(6486002)(38070700005)(4326008)(6512007)(6636002)(316002)(31696002)(110136005)(478600001)(71200400001)(86362001)(5660300002)(38100700002)(26005)(8936002)(8676002)(36756003)(2616005)(186003)(41300700001)(83380400001)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Rk1RTHF4OVFEcFFYSmpPb1VBaWMxOEcxcUpGQ2gxM0FQVm9nbW0xRFRWcENi?=
 =?utf-8?B?S1FWbUIwUlNJbW43MTkzbXdVRVJYcVRwZVpsNDhWYTdKTk1XT09mQjd3eGVE?=
 =?utf-8?B?a2J3bElsQkZlYjZMd3lsWHprMTVwTFpFZSs2azFpTGFUVUZjK0ducG10Q2Z3?=
 =?utf-8?B?cndLeGFBZTkyeTFPS3F2UnV5dXJUNUFna1hhYXcxdXN6S0JmM0g2UjczZURY?=
 =?utf-8?B?eVRObE1sem9NTGdmRFVBTzloYnJWb3BQbDNaNUlKMzEvMkJObko4WENiclhq?=
 =?utf-8?B?akZPQU9tYmhMRFdJU2lkcDZ0bFpGSG9RREJvZ21rZHlmYzdqWkZZYWtsUDM0?=
 =?utf-8?B?VWN4WlFqVldCSkh3TnowVFFaSkJBWUx2SWpKTy9MOTlteWpWeHgxQzJZZWFE?=
 =?utf-8?B?b1JYUit2Mmw2djd2RkhpVnFSWVlqc2s1WkhvSFZ2b3hjSmZJNFlpZk5JbjY0?=
 =?utf-8?B?U1JqTXIweW43VFFsU1p1T1kwREZvZEtTdnhUbE1JQUlwUWlCSm51NjhkR09y?=
 =?utf-8?B?OTJPQlYxMnM1SUttL0RyaFJGU1VBK0VrMTYxQ0Q1dm5TNWE3RGNBYThWRGhT?=
 =?utf-8?B?RnpBc0Y1S0xTQU83Q3Y1TWxXQTJrdWhTa3ZSQ1JMRkdhSFRXQU93OXVTcHhK?=
 =?utf-8?B?Rmh3Z04yVHEvN3B1aUtnd1IzQTJWT2RVeXhQaUF2ZFFlbXBVVDRaU3FYYXBn?=
 =?utf-8?B?Zldzc2txMzBzK0k1NWw2c1RVVUsyMEFaak5uSkFNYVZmeDFRSmV2SVJuUkV4?=
 =?utf-8?B?QjBxZWQ4NURvWXZqTmlHVFl5YW5PU1VKb2Y3Zlc5QkZCMTIwUUVIZG95YlVr?=
 =?utf-8?B?MEdWWXlEY1EwTkpZR1N6Ui9VK05BV2xvRDZwZDNFcHFEcTVKam1KNk9SY25x?=
 =?utf-8?B?NW5BaFF6LzVsZkpzTms5TVJIeHJPT1dxZDlBQjBXcXJ1M2JYeUZlcEoxNmJ2?=
 =?utf-8?B?V0wva3ByYTNBN3VWTFlvZlVwUmRUd05tUkdqdU0vVFJiVFpyeUlqb3FHZXVl?=
 =?utf-8?B?Y0pseWZ6V1g2U1RWc3g2Z3g0Y0l6a1F5cktPbDFCMm1kS0NTeitGMktRVVAz?=
 =?utf-8?B?Zm96SXV0bzVGZEF0TWJKcU9ENDZTSjdCWWRkNXE1MWptUkdLbzFOZkE4K1ZF?=
 =?utf-8?B?UFY2ZExhdzdEcndHa1VJN2hxSmUwNXA1UmI1ckZWMVdwN0JkdUZYdmppdDBx?=
 =?utf-8?B?Q1JrZjV5MGd3V3g0WG96UHZEa0U5YldKSmRoUWluSEgyZkQwMEhnK0tSQVdv?=
 =?utf-8?B?ei8zcWh0Z0paTkFzT2F6bVY2c0MweDVkdlZCZC9qemVrZmh0bjFjTU9iZ1hG?=
 =?utf-8?B?dXJBemFjbWxwbkV6WWliaDBSNTlkdkFmbzBuVjVhSUpYaksvMDNJMmJKVG9O?=
 =?utf-8?B?UEhDYklQY0h3Qnc5OHBrbldDNkNCSkhvemRBQ284Sm5XZnZEM1psWXk5OVlp?=
 =?utf-8?B?TDRxODh3SUcxUzNKeWxPRGFVZ2Vvcy9icXpsL3VoVHZiOTJLYjBlSmlxc1lm?=
 =?utf-8?B?TnhxeS84TklaV0RFS3pVVWp6Y1h6aWU0cHRSY0NlNUVWM3Z3UlF6N1VLZmxa?=
 =?utf-8?B?Z1cyRWxDeFBPZjhWSE84a1N3NTl0Y1hIZmgzUVQ0UXJTYnk4RWVWblJZb0NB?=
 =?utf-8?B?UHoraEdkOU5SSUFrVkZ1eGFiVzc4bTdLMjYwbzlTbEJlOHYzSWlEcWk3c0Fw?=
 =?utf-8?B?MnRLQm1OeFNoSGF6Y1BlZDlvSCtveGhMTFB0OGQ3UjN0QXFJenUyTkJncmpp?=
 =?utf-8?B?NUYzcHF2ZDFtQ1N0QWZybnZGNHdMdy80MzhNKytreUdacFlOb0w5WURtV2lG?=
 =?utf-8?B?WERYOEZDY1FkQlBIWWR2bHoxWUxyejdxNStwLzE1M3AyVGNubVBTa0VOSWZ4?=
 =?utf-8?B?WG1mNlNscGpmNmg1clNoQ280Ym10VHVHNVMrOFVaK0RqRFRyb1B6ZEtNcjVV?=
 =?utf-8?B?VklBU3ErcWtmMFJ6S0s4VURxN0NLeUJTQW9ObUZJR1pZNUhhNG9uYjcxblRj?=
 =?utf-8?B?KzVFeHFqc3VGaExlUER5TnpzUjdZZnNMZ2lOWlh5bUplRjNpbDArbnFDMzJK?=
 =?utf-8?B?UU9uTUNrdmtJL0V0V3dKSmNEOTZWU2NRdGp4VG9yTURQVUJ5NGh0VG5GQUlQ?=
 =?utf-8?B?UUQrd0QwWjBzUmFhN25LSm55YzBHMk5EQ1lUUEV1T0Fadm4yMC9IbXNsdnVn?=
 =?utf-8?B?WlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE62F70AEFD6CF4F9B97EB05A675F6EC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB7016.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3985a4b-e838-4f72-faf9-08db8e9bce48
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 12:20:03.4700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KfnK3jMnPAt0P7uTczHlWAr28mR4p4Ru6Z0Zxj7qGi83KHyxgKIjfv9QY8ye/955o3MO1Yy75+2TTmDKuDsi6OLgp+/Gtlu7hE7U4OHBzDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7910
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yNy8yMyAwODozNCwgY2xhdWRpdSBiZXpuZWEgd3JvdGU6DQo+IA0KPiBPbiAyNi4wNy4y
MDIzIDE0OjM3LCBZYW5ndGFvIExpIHdyb3RlOg0KPj4gQ29udmVydCBwbGF0Zm9ybV9nZXRfcmVz
b3VyY2UoKSwgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgdG8gYSBzaW5nbGUNCj4+IGNhbGwgdG8g
ZGV2bV9wbGF0Zm9ybV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UoKSwgYXMgdGhpcyBpcyBleGFj
dGx5DQo+PiB3aGF0IHRoaXMgZnVuY3Rpb24gZG9lcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZ
YW5ndGFvIExpIDxmcmFuay5saUB2aXZvLmNvbT4NCj4gDQo+IFJldmlld2VkLWJ5OiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KDQpBY2tlZC1ieTogQ3Jpc3RpYW4g
Qmlyc2FuIDxjcmlzdGlhbi5iaXJzYW5AbWljcm9jaGlwLmNvbT4NCg0KPiANCj4+IC0tLQ0KPj4g
wqAgZHJpdmVycy91c2IvZ2FkZ2V0L3VkYy9hdG1lbF91c2JhX3VkYy5jIHwgNiArKy0tLS0NCj4+
IMKgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYyBi
L2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRtZWxfdXNiYV91ZGMuYw0KPj4gaW5kZXggNmMwZWQz
ZmE1ZWIxLi4wMmIxYmVmNWUyMmUgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQv
dWRjL2F0bWVsX3VzYmFfdWRjLmMNCj4+ICsrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC91ZGMvYXRt
ZWxfdXNiYV91ZGMuYw0KPj4gQEAgLTIyODUsMTUgKzIyODUsMTMgQEAgc3RhdGljIGludCB1c2Jh
X3VkY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gwqDCoMKgwqDCoCB1
ZGMtPmdhZGdldCA9IHVzYmFfZ2FkZ2V0X3RlbXBsYXRlOw0KPj4gwqDCoMKgwqDCoCBJTklUX0xJ
U1RfSEVBRCgmdWRjLT5nYWRnZXQuZXBfbGlzdCk7DQo+Pg0KPj4gLcKgwqDCoMKgIHJlcyA9IHBs
YXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgQ1RSTF9JT01FTV9JRCk7
DQo+PiAtwqDCoMKgwqAgdWRjLT5yZWdzID0gZGV2bV9pb3JlbWFwX3Jlc291cmNlKCZwZGV2LT5k
ZXYsIHJlcyk7DQo+PiArwqDCoMKgwqAgdWRjLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9nZXRfYW5k
X2lvcmVtYXBfcmVzb3VyY2UocGRldiwgQ1RSTF9JT01FTV9JRCwgJnJlcyk7DQo+PiDCoMKgwqDC
oMKgIGlmIChJU19FUlIodWRjLT5yZWdzKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiBQVFJfRVJSKHVkYy0+cmVncyk7DQo+PiDCoMKgwqDCoMKgIGRldl9pbmZvKCZwZGV2
LT5kZXYsICJNTUlPIHJlZ2lzdGVycyBhdCAlcFIgbWFwcGVkIGF0ICVwXG4iLA0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXMsIHVkYy0+cmVncyk7DQo+Pg0KPj4gLcKgwqDCoMKg
IHJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgRklGT19J
T01FTV9JRCk7DQo+PiAtwqDCoMKgwqAgdWRjLT5maWZvID0gZGV2bV9pb3JlbWFwX3Jlc291cmNl
KCZwZGV2LT5kZXYsIHJlcyk7DQo+PiArwqDCoMKgwqAgdWRjLT5maWZvID0gZGV2bV9wbGF0Zm9y
bV9nZXRfYW5kX2lvcmVtYXBfcmVzb3VyY2UocGRldiwgRklGT19JT01FTV9JRCwgJnJlcyk7DQo+
PiDCoMKgwqDCoMKgIGlmIChJU19FUlIodWRjLT5maWZvKSkNCj4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHJldHVybiBQVFJfRVJSKHVkYy0+Zmlmbyk7DQo+PiDCoMKgwqDCoMKgIGRldl9p
bmZvKCZwZGV2LT5kZXYsICJGSUZPIGF0ICVwUiBtYXBwZWQgYXQgJXBcbiIsIHJlcywgdWRjLT5m
aWZvKTsNCg0K
