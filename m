Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9157A1877
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjIOITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbjIOIS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 04:18:59 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2071.outbound.protection.outlook.com [40.107.117.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9947F272E;
        Fri, 15 Sep 2023 01:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TznqqpxYZo2fwreBS9mLkQPccWY6kct8aj0b73f4eFJklyBjNSacRoUmouylZxHXj/MLAvM3KNGHtq0h12lxlW4KzIFdbaOwx9jqtoAkLGW6BmjqBePtAr2wMiGIQPevUglxia3Ygc2vlDRkjWYmi/uvzHemSL6+7b5jDhoysJlS/B/lFwLBu1CyNzsVU8C6/xt2EFuo51ceQJNRcyL0IokGd1Jq6bWd2DMmXbqU5niXv3CGvg2BKkanPA/7Q1JwTxTq4Gy2zYSG/Gt2Y8l8u4xlW/eYvhjcTFK7nE50BBevMHphlmaVeSh1GfkAQyq3sDPAYJwa6Ojx5ppP04RBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7K6XTCe0vWOpd32g+EmyaFNl6k1h6e62R/RUe87Y/VY=;
 b=B5idbvRWi5GsdAFBF/OT7cK9EXBIe0McLSHvMg+WogAnyLrUvtExIUdPDeoSC0k8P82kTXOHYSjgQsG9Usi1v3wI0ZIQjKkfsiYrDGIT32G3b47LDYN/pCYKyIprN1T6qDExOt1bPm5HTCZY/8D6FHizRrtUoeDs6cuv6vxapPwbdL1ZUQusvdlzbwhHw+kn1gYcN15bzAcGVYcT+v6JcwJJI/DAX593AgJPXezXM7chiDLRdFKSfu0wJ7zMgHKdU8VTOxHF659/o6Itgg+yK00ir2uAB/Qpxs7lzXyCoRROViEN4CdsSlvx2KvSGOkZEKqelVSLufeeFcH+4dFRTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wiwynn.com; dmarc=pass action=none header.from=wiwynn.com;
 dkim=pass header.d=wiwynn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7K6XTCe0vWOpd32g+EmyaFNl6k1h6e62R/RUe87Y/VY=;
 b=dan+7jmXxmwaici2esdqVx7AEQJr14Qp+30sF2FLdIQqxonMKg9uD94xheOs+LjA9TEZFgTdS03CB69pLrD5mhngc4COOoDCZ52gWn/j59cPSmezD8yo4FNN4MKh9AdD9aU3VJzH5ISlqGVQ1vMPSy8OgpnTvpqWYrEDaQyaF9p1dNwZhH4JFw7qbp2fStWvrYo0DTFbeF6xxn3I3TTlBauzFXYYitxQmnx4c3ibhsuEatKx+oCtp6iwngwFoWnKg8+PYIYrqAhhtdycPIAULn+6oQgI4xs0l6m1qB0xI9NU/POfrT7BFUGDVFajXHShasWymu0bMoteyqJghhu2CQ==
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com (2603:1096:400:1f3::5)
 by KL1PR0401MB4163.apcprd04.prod.outlook.com (2603:1096:820:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 08:13:46 +0000
Received: from TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::5be7:ddc6:bdfa:73e4]) by TYZPR04MB5853.apcprd04.prod.outlook.com
 ([fe80::5be7:ddc6:bdfa:73e4%4]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:13:45 +0000
From:   Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Delphine_CC_Chiu/WYHQ/Wiwynn <Delphine_CC_Chiu@wiwynn.com>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Jean Delvare <jdelvare@suse.com>
CC:     "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hwmon: max31790: support to config PWM as TACH
Thread-Topic: [PATCH] hwmon: max31790: support to config PWM as TACH
Thread-Index: AQHZ4J74hgtrGBuSsE+/2qt904rcN7AN+tyAgAp5vZCAAFkAgIACxZvQ
Date:   Fri, 15 Sep 2023 08:13:45 +0000
Message-ID: <TYZPR04MB5853FF0A3C621EEF94CAC35DD6F6A@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20230906084837.3043030-1-Delphine_CC_Chiu@wiwynn.com>
 <20230906084837.3043030-3-Delphine_CC_Chiu@wiwynn.com>
 <8a3b41a2-0ab2-6213-04a1-54ab7263c647@roeck-us.net>
 <TYZPR04MB58533E15AA65FCDA0F603FA3D6F0A@TYZPR04MB5853.apcprd04.prod.outlook.com>
 <29e27f2a-3347-b6f4-2dd9-4c93afea87b7@roeck-us.net>
In-Reply-To: <29e27f2a-3347-b6f4-2dd9-4c93afea87b7@roeck-us.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wiwynn.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB5853:EE_|KL1PR0401MB4163:EE_
x-ms-office365-filtering-correlation-id: ce461d43-1323-4d4e-976a-08dbb5c3aecd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: br2XHLZlIGR3YLU3koXn2rvYz9CrjCsyvpsP0Nqpgu8iv5pGM4B/bKllXvYMbTm+uNW4cKdCTYKi2RXB/jSqeU7L6uhkaKGGW0QuJ/UgHhstHKisg1Smp3XY3s1vFLJG6zWMGBUZBmMlHCURE1NFqbT4BNvhm92O2947rg+f7cj5Vvy4G7u1AQo2igHt64AWBC+Mi6hjbjWF9lnXX3LqQTOuUptDqyEso1OpGyxW/VobYAJtX7oNV5U5/eE1YTF2Eq+vImwkCng2XLjojMjdMPOq4HebbeCM1ynuqzY65F2c7PJhEVGeo9IgMaJpYb9JsxlWd27nqfbEKrrYbUQ+xt4w8YyagEUdAIeCDij7fHF5L/rdNEhXHTMcQ0xOwPgMjp4WkiP8orrmfKWpWRa3Rugq0RdL/jKah/etskavtmo/WyS9UhXgC10wG8IBI+zQeY2GbJUSAVDP2/Vhd0l+N8HzeuD07+eFNaCd5bjP6XMuzc1R+ZcFMEfmm7CMG4jhqPnZxTarU4nFRrNzTc4v7fDEwZ5iA+suakzyiw8igiM63JQv3dlva+tThhGqdQlugc/C9GjTapRlI+zpDPP8mCmWus4PXP2H8YdywhDgv43oSoLutFxhepeCSzi3hvPQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB5853.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(451199024)(186009)(1800799009)(38100700002)(38070700005)(122000001)(41300700001)(86362001)(110136005)(66946007)(4326008)(66556008)(76116006)(66476007)(2906002)(55016003)(8936002)(66446008)(54906003)(64756008)(316002)(26005)(8676002)(53546011)(83380400001)(5660300002)(6506007)(9686003)(7696005)(71200400001)(478600001)(52536014)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MW8zTmplMHdiK3JqbEV6aHh4MTZyZzFvTzEyRC9OTEluN0pldnhKZVV2SWJr?=
 =?utf-8?B?SDUzVjZIWWFGWElQRFA4dVpmb0NQUWI2bTlyVDVzcXVYd3M3RStqRGZiZW9w?=
 =?utf-8?B?aUQrRHhWaHRhVWdVeUJNOUpHMVlIZnRhdlBOc2EwMGJQZW1HOEE2WXNTZVZk?=
 =?utf-8?B?OWllcjZhMjNwL0hYR1g5RkgvNStGOTI2OS9WK243QnI2VmFDTE5wVW9uemJM?=
 =?utf-8?B?VWJLVzVWWmdJZnBCZmNMMlR6c2wwbHA1azdMVndWTDc3NTU3SVJQa2FmYTNr?=
 =?utf-8?B?WmZZOVV6OGJmdlVrbFlEQW1GbTlnaHBTd2ZuMW16cGxqdG50aEpnMzNsL05U?=
 =?utf-8?B?TUpwcXZFalVWN2EvdDdCNE1rVTNQMmxZYnpZTGZVazBZR2RMODZlMEd3Q25s?=
 =?utf-8?B?eEF2bndMYkE5WUY5aXdORlFwaVBPTVVnV2FSZW5vLzFWSG9LT2dXdEFabFJr?=
 =?utf-8?B?RzNRVkdlWVdxRHNNUHMrTWZkODlGU2Q4U0tjek9KbmN4QkFyLy9vVXA0NHM3?=
 =?utf-8?B?eWF3RkRiZmN1SDNpUHpsbXMxK3lHMUs5d3JBc2tlRFVjdXB5UlN3dWJBQXIy?=
 =?utf-8?B?RkcxSWpSSUYzTnJQcTl2QXB1T3FuVTZVMVYzREJYYndvM3VYYnlsNEpGUjIr?=
 =?utf-8?B?djVIOEpGbHp5Ujl2SGJFNW96QWp4Z2NwRDUwT1Y2YUpRaWFYQXdIT080QzF3?=
 =?utf-8?B?QzVpUyszdGFQMzZxQ0grQnNsVi92K3FDZkkxQlRycTZwV280dTNxOUZZOWZJ?=
 =?utf-8?B?WXQ5WWhJV0hzMnplL1NWSlRONlpjUHpmV3hsRzNsM2dWUmM2WTZRUFh4NENt?=
 =?utf-8?B?VWNwTm1QRTFudjVVL01EVDZLaSs5UkNuYVVONGl5emRnN1BRR1FUdEVzNmM5?=
 =?utf-8?B?T0grdjlzUkhyZ0J4bzNUamxzcGk1YjhzalRyOXpvZkhxMHZtaTllYXMxd29x?=
 =?utf-8?B?S3c4TFdDYkc3RDh3VVIyRGNvbi9vNkhzME9STjFtZ3R1T0VsbUI4ZDNrVXJR?=
 =?utf-8?B?aUlZOTU5TytadmJIYXJ2dGppd3VHWDZpWGV5WnlKMURlbGRvTTZkb3BZMGZY?=
 =?utf-8?B?LzJIU2huMGZHT2JObFVyNlQxSjhzV1lhZlc0V1dUaDJRL2U5WEdXcy8xMFBs?=
 =?utf-8?B?Q2s2STRrRjhmQjY2UWVQZEk2MzRERFVJSWtQdDRlVnZucFc3V1lGN0NIKzFE?=
 =?utf-8?B?Z3VhWXh1ZnV1SElmbmd0M0FRNXRMWEF2ektkYnNUMGxIWm9Dd0g1WTcybCsv?=
 =?utf-8?B?WlpXT0QvQzBiUEU5YlVqTm9tYW4rV2gxUnVMdjRENFNMVzdhZVBSQzBiZGha?=
 =?utf-8?B?dFJwTkNjUUhvYzJ5d0tSaGowNWtUSnd3ei96SEdJSERPWS8vamZHelowZXpo?=
 =?utf-8?B?UzBwcnVvMEZVRFJYejZTUUVCOVFmbmRKdkpPN2ZWanE1Qms4dTl2QjlHVVFW?=
 =?utf-8?B?djdWTVdZZzI1K2VENktxcHoyWjFlS1F5NnBqU291UDBEdnZ1SXN3N0JsZmlP?=
 =?utf-8?B?UlRSY3doNzJTLzN4a0dnRWRUbFM4K0tRK0xkc2FVTklKQjhnanBsT3RqbUEv?=
 =?utf-8?B?Nk5NV1VnYW1ldW5WZHUyeDFYcC9NYUc4empnS2k5aWtTc3U0T3Q1c3dRd0Nu?=
 =?utf-8?B?bG1lNk9UWWdxZktUVFpLNzNHdHoyalRVbEtOWEFpbnVHbTJERmpxVDNMSGxt?=
 =?utf-8?B?WEFlVXRnV1pBR3drWkFJUW10Z2lhMWtjeFhZZUtLdU5DMUNLbFZ5clZQeXl5?=
 =?utf-8?B?TTlHbVN0YnlYUGFEdW1IZWg3WE9Pdm0ydUNHU0pqWlBxZ2xHRjN5dUJVTkU2?=
 =?utf-8?B?ck1Mc2ZuSEJmTDE5NXIyeUVPa0g1QXZPRGNycTRoR0Rkdno1bTlkWU1aTDI4?=
 =?utf-8?B?bm5HR1k0UkxOSUdCK3FQSG9SR3dETHd4eUlUU1ZPdTFLSnRKVjJaNENmdW90?=
 =?utf-8?B?dnpSMnpSU3U2bXRqTXdTeHJCWlEraUhLanNHMGg0cnlaTkYwZHYwYmVMajM1?=
 =?utf-8?B?K3hzUS9tV2srVSs1dy9HMUJlK2hYY1dVNU5Fd1EvQ2J5R1djT1FkY1RGcUJR?=
 =?utf-8?B?WDdOemM3V1lCWTFjdUZ3WHhyeU5xYUZMNmgrbHY3WTR0NGd0VjBnUmJqQytF?=
 =?utf-8?Q?8+WrKRhuXMceFz1x25T78H7LL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB5853.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce461d43-1323-4d4e-976a-08dbb5c3aecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2023 08:13:45.8848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUG1UKr7L0rh59iBunaPEF8touIHsLNCKD0QGOY+IjByoF2IiSdr2WVkCoUHSZs0YyJwlQm5VXfcEdrbIFwh1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4163
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogR3VlbnRlciBSb2VjayA8
Z3JvZWNrN0BnbWFpbC5jb20+IE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6IFdl
ZG5lc2RheSwgU2VwdGVtYmVyIDEzLCAyMDIzIDk6MzcgUE0NCj4gVG86IERlbHBoaW5lX0NDX0No
aXUvV1lIUS9XaXd5bm4gPERlbHBoaW5lX0NDX0NoaXVAd2l3eW5uLmNvbT47DQo+IHBhdHJpY2tA
c3R3Y3gueHl6OyBKZWFuIERlbHZhcmUgPGpkZWx2YXJlQHN1c2UuY29tPg0KPiBDYzogbGludXgt
aHdtb25Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGh3bW9uOiBtYXgzMTc5MDogc3VwcG9ydCB0byBjb25maWcgUFdN
IGFzIFRBQ0gNCj4gDQo+ICAgU2VjdXJpdHkgUmVtaW5kZXI6IFBsZWFzZSBiZSBhd2FyZSB0aGF0
IHRoaXMgZW1haWwgaXMgc2VudCBieSBhbiBleHRlcm5hbA0KPiBzZW5kZXIuDQo+IA0KPiBPbiA5
LzEzLzIzIDAxOjUxLCBEZWxwaGluZV9DQ19DaGl1L1dZSFEvV2l3eW5uIHdyb3RlOg0KPiANCj4g
WyAuLi4gXQ0KPiANCj4gPj4NCj4gPj4gVGhpcyBhc3N1bWVzIHRoYXQgdGhlIGNoYW5uZWwgaXMg
Y29uZmlndXJlZCBhcyBwd20uDQo+ID4+IFdoYXQgaWYgdGhlIEJJT1MgLyBST01NT04gY29uZmln
dXJlZCBhbm90aGVyIGNoYW5uZWwgd2hpY2ggeW91IHdhbnQNCj4gPj4gYXMgcHdtIGNoYW5uZWwg
YXMgZmFuIGlucHV0IGNoYW5uZWwgPw0KPiA+Pg0KPiA+IFRoaXMgd2lsbCBjb25maWcgdGhlIGNo
YW5uZWwgYXMgVEFDSC4NCj4gPiBDb3VsZCB5b3UgcHJvdmlkZSBtb3JlIGluZm9ybWF0aW9uIGFi
b3V0IHRoZSBzY2VuYXJpbyB5b3UgbWVudGlvbmVkPw0KPiA+IEluIG91ciBzeXN0ZW0sIHRoZXJl
IGlzIG9ubHkgQk1DIHRoYXQgd2lsbCBzZXQgdGhlIGNvbmZpZyBvZiBmYW4gZGV2aWNlLg0KPiAN
Cj4gUGxlYXNlIGtlZXAgaW4gbWluZCB0aGF0IHVwc3RyZWFtIGNvZGUgaXMgbm90IGludGVuZGVk
IHRvIG9ubHkgc3VwcG9ydCB5b3VyDQo+IHNwZWNpZmljIHVzZSBjYXNlLCBidXQgdGhlIHVzZSBj
YXNlIG9mIG90aGVycyBhcyB3ZWxsLiBZb3VyIHN5c3RlbSAodGhlIG9uZSB5b3UNCj4gaGF2ZSB0
b2RheSkgbWF5IG9ubHkgdXNlIHRoZSBjaGlwIGZvciBmYW4gc3BlZWQgbWVhc3VyZW1lbnQuIE90
aGVycyBtYXkNCj4gdXNlIGl0IHVzZSBpdCB0byBjb250cm9sIGZhbnMsIG9yIHlvdXIgaGFyZHdh
cmUgbWlnaHQgdG9tb3Jyb3cgYnVpbGQgYW5vdGhlcg0KPiBzeXN0ZW0gd2hlcmUgdGhlIGNoaXAg
dXMgdXNlZCB0byBjb250cm9sIHRoZSBmYW5zIGFzIHdlbGwuIFRob3NlIHVzZSBjYXNlcw0KPiBz
aG91bGQgYmUgY292ZXJlZCBieSB5b3VyIHBhdGNoIGFzIHdlbGwuDQo+IA0KPiBHdWVudGVyDQpI
aSBHdWVudGVyLA0KQWZ0ZXIgb3VyIGludGVybmFsIGRpc2N1c3Npb24sIHdlIHRob3VnaHQgdGhh
dCB0aGUgUFdNIG91dHB1dCBjaGFubmVsIG9mDQptYXgzMTc5MCBzaG91bGQgZWl0aGVyIGJlIFBX
TSBvdXRwdXQgb3IgVEFDSCBpbnB1dCBpbiBoYXJkd2FyZSBkZXNpZ24uDQpBbmQgdGhlIHByb3Bl
cnR5ICJwd20tYXMtdGFjaCIgaXMgb3B0aW9uYWwsIGlmIHVzZXJzIGRvbid0IHdhbnQgdG8gY29u
ZmlnDQphbnkgUFdNIG91dHB1dCBjaGFubmVsIGFzIFRBQ0ggaW5wdXQsIHRoZW4gdGhleSBkb24n
dCBuZWVkIHRvIGFkZCB0aGlzDQpwcm9wZXJ0eSBpbiBEVFMuDQpXb3VsZCBsaWtlIHRvIGtub3cg
aXMgdGhpcyBtZWV0IHlvdXIgZXhwZWN0YXRpb25zPw0KDQo=
