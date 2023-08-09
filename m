Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1011C775106
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjHICqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjHICqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:46:44 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2119.outbound.protection.outlook.com [40.107.117.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E3198A;
        Tue,  8 Aug 2023 19:46:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ewa5aQ22TrFSc1bxX+EWe1BZmMHfobLLwrUoij5y+mNPPA3gXvQ1MsRG8c1LmFcvtWKAbzJ0cEl4wU8VM9OMGJHMr3kc65KbeDVe4UeZNgXl9sExpjdQICasXSLQIVY0rs2D2mOTpbQPQ/N+BEOa1D42h+B3RA6pNthymKlDCx2WwU/XHVJaWZptKmT/3PqF9Ot+vAJv5QEKyY4t+QiA12C8ftQkkMbpHR7v/qT6gASlh1E3TQ6CngZ6xfm+aJFSWy3lF0w0kqQiIYZKi6DKrsElwF3oVM7LmEiUJpCrDgqMLdSkBCgDN9Axgf/3LTJyQjtHBh7jpQhB7XrS46u+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nfr2Xxdd2+8XRAhraXa1FDwAbeuvPcJfjb1Qz0keE4U=;
 b=iBUUMrVVHdwOseFazfycO3z50sUQ3GUjAkjp6IiP10gzSlAbTugP9gxMOzr3xLM9/xT697gaIbUEAaqZl9KjKG0lkmM7PImIz9d8dCrldJpML+cVp+dPSt1UFDz4fvsyQh97O0314xvtZlgprTIDSag/kujA1ICL+aL7DXYLrT/QVtOcqGQLkXyQzKhDKZUC7KQauJx7ev5SahlAB3XJPXa2xpfrH1y1fBw6JobNgKBNaWfZinP5XtCKHJMnf/8SDBLM9a7gOwKtlqxcGhijdoI+ztitmiY/7bbLAHWVJZ7UabTZcMN2ZqxC/+SsUg3kJouyyZ4/Zd1Gatgrrupp0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nfr2Xxdd2+8XRAhraXa1FDwAbeuvPcJfjb1Qz0keE4U=;
 b=eJuCBJ+WBYU3qPBLRlW6EpnzMRwhcqKUnpLs/tvY3NQss2O4aW0FzLY8orQ66U4RHTvFly+z1Umnq3ZxHC8jDHdZhieHTsJpm8k7ExuzvY4aYmyT/xG92ESG9yykYPpt6k0MJyMJ7PlrSYWaTXaH42PDkB9bn6mYXCDc7R4W9SmAkQ0ObenxnJ7HuI9vuuNG66pQu+4Nl0CuYD2ftbNHvNisieOgd5D6J2PRisvPtTAb8YT1Faj7ZpU5o/JMgNlKpWqIO5ohKPx8yEglaQ1GbfjUQOazu2eTXFAeK1OoXo4UcY9RvxZjRjEt2HZ9GIPsSPsZqvfh54D10WS+QN8dug==
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com (2603:1096:400:465::12)
 by PUZPR06MB5936.apcprd06.prod.outlook.com (2603:1096:301:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 02:46:35 +0000
Received: from TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::3261:9707:fa4e:572f]) by TYZPR06MB6567.apcprd06.prod.outlook.com
 ([fe80::3261:9707:fa4e:572f%2]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 02:46:35 +0000
From:   Dylan Hung <dylan_hung@aspeedtech.com>
To:     Jeremy Kerr <jk@codeconstruct.com.au>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     BMC-SW <BMC-SW@aspeedtech.com>,
        "kobedylan@gmail.com" <kobedylan@gmail.com>
Subject: RE: [PATCH 0/3] Add Aspeed AST2600 I3C support
Thread-Topic: [PATCH 0/3] Add Aspeed AST2600 I3C support
Thread-Index: AQHZyg78ndVj9Ombp0W1p1fw4rNeCK/hFv0AgAAsIPA=
Date:   Wed, 9 Aug 2023 02:46:34 +0000
Message-ID: <TYZPR06MB656732D4E436B711CB560B449C12A@TYZPR06MB6567.apcprd06.prod.outlook.com>
References: <20230808154241.749641-1-dylan_hung@aspeedtech.com>
 <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
In-Reply-To: <d8d577e91779e045d5a2c7d701f65133a15b5d64.camel@codeconstruct.com.au>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB6567:EE_|PUZPR06MB5936:EE_
x-ms-office365-filtering-correlation-id: b3be7e93-5131-4cdd-df9b-08db9882d8a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SolHJYSp8FaIfK4Cv3d9Or02igctTfrzF59vSBIvI13yQo4h16m4WQRq8KfoktrZf9pGR9QTY2JPnpXK4MgnID5wUjpqcwOqeowdd8/gUcBdfxlIIWVlYhI29MDAdWZK4QeI9BxI6XODVWACIbtELRBT3ftGG9+hPYlO0XlHKERMpd0LrLuTyyFj/naWuAHrhq5sW5Epwc1udmL5MawUEwee1og4DSaYDeISrqRBwreQPTxwE40UQdULd7TimRxAa/FPJpNMW4ItfX6sjDh1aaPwv8iBKHVS5M2MRgmTRwMdLM7LMnlWKt5AXucLmUVe6W3IoftmjYvtE9yIVHuW9ZXIuCJoi/xPnBC1CCHaE5MyhQHGy+tttnlax/OZzTViR4yVoqTL3Cw93Ee3AW2zzS3ZiXAGcDht4/GTSkMRucRxRLMWw+Ma+KhiX4xCMUGHUZGa0b+yK3yXVERs6/NnT4LX/9xaZotqmw59UPfhTSZZP49wqO5CQ7uB+TyVjS+HLve2G2LdVuE28EHChgoGBMNQZuZ+eSJDI7wKRzgiYUkKoG2W1BTk58Y4SmQ/od+aaDku5Bm4o3Crvowceu1MZEGEBCMpPeqKJV6mIx6L87uNkIltIhK4vQHm7xrV2UBx
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6567.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(136003)(376002)(366004)(396003)(346002)(451199021)(186006)(1800799006)(478600001)(71200400001)(7696005)(9686003)(54906003)(966005)(110136005)(83380400001)(53546011)(6506007)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(4326008)(316002)(86362001)(55016003)(33656002)(41300700001)(2906002)(38070700005)(921005)(7416002)(5660300002)(26005)(122000001)(52536014)(38100700002)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dk5pcExPWkxGMXZFdFNqMm9Kd0MrWi9XcjI5clNyTVVyOTNYYUMvRTZoN0Ro?=
 =?utf-8?B?UlprS05VaXdZK0dSK3RzdGcyVWJ3dGcwTHl3TjhqRVdQeXFRb0g3eCtIc2JU?=
 =?utf-8?B?eGY2UnQvMmpEMWYrNTQ4TmZEd0E4b1ZFTzFmek4yNm1ybTRaQStxQWcySnpG?=
 =?utf-8?B?V0kzWmx5RCtrelVPWXl0eWpPSHFzRzVob2h4bWFyZTZFaE9TZHB0ZE40bzJV?=
 =?utf-8?B?TWIvWU1TZzladDVGdE5XZEJWR1NnTTlQekU3aDRyZmxOT2VwbUtSRXFVeUhY?=
 =?utf-8?B?cUNmdEg4cnI0Zk5XamRBWjVVYmRUeDBuQ1BZVGduZEdyU2RnWFMvelBSdTNm?=
 =?utf-8?B?L3pNT0s5RGdWRkVxdit1WkxSNXRXMGU4Vmw1MFhTRkEzMVdwMVc5ZGxJRG1S?=
 =?utf-8?B?Q2c2b2Y2VVFFY1EzWXFYWmdOV1FKTUNNSzlrVWllUkJGaTRTRjdhUGJKVVd5?=
 =?utf-8?B?RlNMYldPSXFwTkRPRUVQaHVKbE1PcGhpanVyWTZBalJ6MC9IY2ZJZlZiMFo2?=
 =?utf-8?B?Vmh3VGQya1JzWmY3VmhKcHN4NkdrdU1XUEV2dU1JbnE5aXR0c1djTVNIcXJD?=
 =?utf-8?B?ejg0RTRFMHMyMnRSTWZIL2pmeStrTVNYWTJHNk1SV2QwZVVkdGF6ZStGSW9l?=
 =?utf-8?B?MFlidUdzRTM3MGl6Yi9WODhGZFRNdkpmUFlIUzNrdzlPYW9qMUc0ZTd0QkRY?=
 =?utf-8?B?Zy9OZzh1Q3N3NzlHRG5sMERQano2WElrR0NmbnNCUFBpZHhadm1sL2dyeWF4?=
 =?utf-8?B?N2FCYjRubzdtZldncFV1dWZ5VEFQV0M3SGxqY0JvQWFqNHVUVStBMWVrSWZ0?=
 =?utf-8?B?NXl0MDFGUjBHSFlxSlVmUmU0SW5OcmpJaGhHSGlON0JvMG9NNlpJQU92aHpx?=
 =?utf-8?B?ZDYrMXh2RElESzc4ZitmYURNbXpwYWtrbk9nRFYxNE1GbzhON2JucVBYQ0wy?=
 =?utf-8?B?SGtYTlp0QVNldWQ5WkN1aGlhbTFLR3h5clpBMVVIMDdEK0RoSmx6Z1NGMXJn?=
 =?utf-8?B?SGxaS04zUm9odzRFL1UvS2FkWHU2bitITzkwZmRjcXE0dExCUzJQUHYyd3ZE?=
 =?utf-8?B?Ym85Mlg3d3prRFNNWmthL1FUTlNOcnJFMmFOc2ZOQ3JIVEZDNHZHQ1JXeFZi?=
 =?utf-8?B?d0FEczVqV21RQkFxcUdHSEtDRzFwVm1xdnNzY2JiS1ROZmE1NzJBWC95L1pu?=
 =?utf-8?B?OHpsaU1OcnN1UUpHaWo1SFcwMnZRUzhacEk3M1V3TVNMSHpoL2cvWXJzOGlx?=
 =?utf-8?B?MFV4WkdmZW5UUzliekNqUnNVMGhEck9KNmtoMWQwKzl5Skt2dy9rVWt0TEJa?=
 =?utf-8?B?dStWQUVzc095V0dFTmEvTlpqblh0Z3NNcEVwV0NTUkJVU2Y1M0NoZmo1bmxP?=
 =?utf-8?B?Z1p5enA3M1FpUGR1aVdNOFppZW14a2hoYllLOG93dE5sZlFud1VpZGRWRThB?=
 =?utf-8?B?K3RxTHpJRzZyQnNVSTBhbU5rRHJWRkE0RUVxUFVQSE00N25QaWtlRlAvU2VP?=
 =?utf-8?B?NDR1QkJVR2xDTWs1RDZiVElOMHVYNnV0eStJc0UrTUdwV2ZXTjBQNElUM05N?=
 =?utf-8?B?Ny9kNDVDQk9sK05aSkdicVcrOWovcjBka0pibDUwSElEekEvS3NPZ2xCdU9L?=
 =?utf-8?B?QmZWREowakhCZGZqYi9uOEUyRmhnZ2xtOHhwRk9GNWFrdUI5Ri85QlNpSnBt?=
 =?utf-8?B?dmJCaHpkTkNZS1pGR0JKSmJNWTZoR3pTbmJxTkZLb05wVDBXRDdTUzB5K3hB?=
 =?utf-8?B?b0NWeVhyTmRoNEltNWJPeVZVQUlWMmdMVG9ZUVpiMnpmYlJ3a2UwaWU1Q21z?=
 =?utf-8?B?UWVvNWdDUU50VWlRcGREK25OVTZUV3VIREFlamxpdklFR2t6SW9sS0J3RUhE?=
 =?utf-8?B?WUcwZWR5RG5OMGpHVlN5VTlwZ3VnbE1pTVYxNlJhVHUwOUZYd3gwb0lkTGFh?=
 =?utf-8?B?TkpMV1c1OFllYWFVN1NBclYwN1phYVliUmlKYzFqVHlPYTdBQmF2TnZYSmY0?=
 =?utf-8?B?Q3hldHdJV2g4Q3ZyWit3aGFKV2YvdkxoVXMrS1BpY1Nxb3VNb0p6amYxZU5U?=
 =?utf-8?B?OUhrWVVMMk5aTkYxeUV4WCtremtZdkEwOUtzN3ZaV2UzK3VkUFY2RDF5K1JJ?=
 =?utf-8?Q?8nhREK0LloOsS/R5PTg2wmeCd?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3be7e93-5131-4cdd-df9b-08db9882d8a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 02:46:35.0175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D5ag1pYllpXF7hiXW3Sx6NMS+PbIVQ9MrUzDDfz4HuEDHWeZ9m2ACX7DiLbwU2EhYjU/t8BZ73T3VL7gwSpAppaRPadpyMalY4Vb33M283Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5936
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgSmVyZW15LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEplcmVt
eSBLZXJyIFttYWlsdG86amtAY29kZWNvbnN0cnVjdC5jb20uYXVdDQo+IFNlbnQ6IFdlZG5lc2Rh
eSwgQXVndXN0IDksIDIwMjMgODowOCBBTQ0KPiBUbzogRHlsYW4gSHVuZyA8ZHlsYW5faHVuZ0Bh
c3BlZWR0ZWNoLmNvbT47DQo+IGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tOyByb2JoK2R0
QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3Ir
ZHRAa2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7DQo+IGFuZHJld0Bhai5pZC5hdTsgcC56YWJl
bEBwZW5ndXRyb25peC5kZTsgbGludXgtaTNjQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5v
cmc7DQo+IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxhYnMub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IENjOiBCTUMtU1cgPEJNQy1TV0Bhc3BlZWR0ZWNoLmNvbT47IGtvYmVkeWxh
bkBnbWFpbC5jb20NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzNdIEFkZCBBc3BlZWQgQVNUMjYw
MCBJM0Mgc3VwcG9ydA0KPiANCj4gSGkgRHlsYW4sDQo+IA0KPiA+IFRoaXMgcGF0Y2ggc2VyaWVz
IGludHJvZHVjZXMgdGhlIG5lY2Vzc2FyeSBjaGFuZ2VzIHRvIGVuYWJsZSBJM0MNCj4gPiBzdXBw
b3J0IGZvciB0aGUgQXNwZWVkIEFTVDI2MDAgSTNDIGNvbnRyb2xsZXIuIFNwZWNpZmljYWxseSwg
aXQNCj4gPiBhZGRyZXNzZXMgdGhlIG1pc3NpbmcgcGluY3RybCBjb25maWd1cmF0aW9uIGFuZCBy
ZXNldCBjb250cm9sIGZvciB0aGUNCj4gPiBJM0MgZnVuY3Rpb25hbGl0eS4NCj4gDQo+ICsxIGZv
ciB0aGUgcGluY3RybCBjaGFuZ2VzIGZvciB0aGUgSTNDMSBhbmQgSTNDMiBjb250cm9sbGVycyAo
SSdsbA0KPiByZXZpZXcgYW5kIGFjayBzZXBhcmF0ZWx5KS4gSSBoYXZlIGJlZW4gdGVzdGluZyBv
biBJM0MzIGFuZCB1cCwgYnV0IGp1c3Qgbm90DQo+IHdpdGggdGhlIEhWSTNDIG9uIDEgJiAyLCBo
ZW5jZSBubyBwaW5jdHJsIGRlZmluaXRpb24gdGhlcmUuDQo+IA0KPiBIb3dldmVyLCBJIGRvbid0
IHRoaW5rIHRoZSBvdGhlciB0d28gYXJlIG5lZWRlZC4NCj4gDQo+IEZvciAyLzMgYW5kIDMvMywg
eW91J3JlIGFkZGluZyBhIHJlc2V0IGNvbnRyb2wgZm9yIHRoZSBnbG9iYWwgcmVnaXN0ZXIgYmxv
Y2sNCj4gd2l0aGluIHRoZSBwZXItY29udHJvbGxlciBkcml2ZXIsIGJ1dCB3ZSBjYW4gYWxyZWFk
eSBkbyB0aGF0IG9uIGEgZ2xvYmFsIGJhc2lzDQo+IHdpdGggdGhlIGV4aXN0aW5nIHN5c2NvbiBk
ZXZpY2UuIEhlbmNlIHRoaXMgZWFybGllciBjaGFuZ2U6DQo+IA0KPiANCj4gaHR0cHM6Ly9naXQu
a2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0L2Nv
bW1pdC9kcmkNCj4gdmVycy9tZmQvc3lzY29uLmM/aWQ9N2QxZTNiZDk0ODI4YWQ5ZmM4NmY1NTI1
M2NkNmZlYzhlZGQ2NTM5NA0KPiANCj4gRm9yIHRoaXMsIEkgaGF2ZToNCj4gDQo+ICAgICAmaTNj
IHsNCj4gICAgICAgICBpM2NfZ2xvYmFsOiBpM2MtZ2xvYmFsIHsNCj4gICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJhc3BlZWQsYXN0MjYwMC1pM2MtZ2xvYmFsIiwgInNpbXBsZS1tZmQiLA0KPiAi
c3lzY29uIjsNCj4gICAgICAgICAgICAgcmVzZXRzID0gPCZzeXNjb24gQVNQRUVEX1JFU0VUX0kz
Q19ETUE+Ow0KPiAgICAgICAgICAgICByZWcgPSA8MHgwIDB4MTAwMD47DQo+ICAgICAgICAgfTsN
Cj4gDQo+ICAgICAgICAgaTNjMjogaTNjLW1hc3RlckA0MDAwIHsNCj4gICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJhc3BlZWQsYXN0MjYwMC1pM2MiOw0KPiAgICAgICAgICAgICByZWcgPSA8MHg0
MDAwIDB4MTAwMD47DQo+ICAgICAgICAgICAgIGNsb2NrcyA9IDwmc3lzY29uIEFTUEVFRF9DTEtf
R0FURV9JM0MyQ0xLPjsNCj4gICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsN
Cj4gICAgICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX2kzYzNfZGVmYXVsdD47DQo+ICAg
ICAgICAgICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxMDQgSVJRX1RZUEVfTEVWRUxfSElHSD47
DQo+ICAgICAgICAgICAgIGFzcGVlZCxnbG9iYWwtcmVncyA9IDwmaTNjX2dsb2JhbCAyPjsNCj4g
ICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gICAgICAgICB9Ow0KPiANCj4gICAg
ICAgICAvKiAuLi4gKi8NCj4gICAgIH07DQo+IA0KPiAtIHdpdGggbm8gY2hhbmdlcyBuZWVkZWQg
dG8gYW55IGJpbmRpbmdzLiBJIGhhdmVuJ3QgbmVlZGVkIGFueSBvdGhlciByZXNldHM7DQo+IGFy
ZSB0aGVyZSBwZXItY29udHJvbGxlciByZXNldHMgc3BlY2lmaWVkIGluIHRoZSBIVyBkb2NzIHlv
dSBoYXZlPw0KPiANCj4gRG9lcyB0aGF0IHdvcmsgZm9yIHlvdT8gSWYgeW91J2QgbGlrZSB0byB0
ZXN0LCBmZWVsIGZyZWUgdG8gdXNlIG15IHNhbXBsZSBkdHMgYXQ6DQo+IA0KPiANCj4gaHR0cHM6
Ly9naXRodWIuY29tL0NvZGVDb25zdHJ1Y3QvbGludXgvY29tbWl0LzA1Y2FjMjQ3MDVmYTYyZDIx
NzZlY2JiDQo+IGJmMTVkOTU1Y2ZlODZlNzUzDQo+IA0KPiBDaGVlcnMsDQo+IA0KPiANCj4gSmVy
ZW15DQo=
