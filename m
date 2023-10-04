Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA177B9698
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbjJDVkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbjJDVkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:40:09 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2123.outbound.protection.outlook.com [40.107.105.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF6D3C1;
        Wed,  4 Oct 2023 14:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKb68K/5mSG5dE5D9FtRoAwOaK27QJ3UiXv/4iQ5I/7oSFLe2eZsGFHZ/uTSSbIl/Squ3+8GjYowRtX9qzwGOgfUY6INPYCanA7x6I0JtYxQL9y2fz6o5PQUTo7Uk0m4vDqs8jDgJ1Z3Pu9BhPdBcwQkWAkEGD+CT4FIGXoIb34W69QIn45SMzQEvuuZd0pqxONpt2EqLh17o/BShJpm1hAkaQKxi6Enqlayuq4qcw+ZC9f7xavEUrIol2MwiWMZNBnUy19pz6pXx8bB8vMGtMn029V+D66rsVAZcnypS6N9Ti9Gunuhx5yfp8sUePgVjo7AP0DB5ochjda9DVpL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/RFr04QFmYxKa55s5HcgsRokvpGfTFU3IGjBKdK8zk=;
 b=Cuvm5VSIBzJGAxrRZVewEUC/2aQKkhYIFRxafA5ZILfFIKnYJ57WX1WhlVe7xQ3tbLf+G2Y1oR0OX0TNaDxmR2qtd9+Um4IjmJ+8NaBVk6WiL3LzRoiOlzxie3G41imMeRuUHO/KcTdT+Iru8k0cYg4pr6COgwjsWy+JbeTN5VpsYy/MBEAHmcmZP3VYhwfriszhs/u4OqlS1h2+48Uw/TcbJd4psSgLCMfdQ/aMCf6p2xpM9G2EioaynEt1a8JJeYFU2hSKn+FpunoTaQeSEd+U0O5ld1PowLWBhDQLHOgiTwgoRvnNL/J8nShB7aYSAjsW7h6a0Xz8Nph1AgZUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/RFr04QFmYxKa55s5HcgsRokvpGfTFU3IGjBKdK8zk=;
 b=GUq0DOlIPU8OZ1/gOQPw+5Ze80mI5hFf5OTKKCBAhN40KY3F74OZ+WCLNhnrszTvcD/uwd3unqghjSq/JkQ6JFtlAUFDcszV45VhHPLhIu+5ctd9oqzSTKGHuc/hpyjyD9zkKadOheAvuwn0sQW7KhycND8KOhVD98yUbrjWzQQ=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AM9PR03MB7930.eurprd03.prod.outlook.com (2603:10a6:20b:439::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Wed, 4 Oct
 2023 21:39:58 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::620a:c21c:f077:8069]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::620a:c21c:f077:8069%5]) with mapi id 15.20.6838.029; Wed, 4 Oct 2023
 21:39:58 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Rob Herring <robh@kernel.org>
CC:     =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <alvin@pqrs.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: si5351: convert to yaml
Thread-Topic: [PATCH v2 1/4] dt-bindings: clock: si5351: convert to yaml
Thread-Index: AQHZ9o172nD/7tvDCkmM9q6Ey5mxHrA5tBeAgAB1cAA=
Date:   Wed, 4 Oct 2023 21:39:57 +0000
Message-ID: <mkeegnnfuxmutdkun7tprz27miyeisvhppsdp5mxmeq4kykecy@b576w45hwcbd>
References: <20231004063712.3348978-1-alvin@pqrs.dk>
 <20231004063712.3348978-2-alvin@pqrs.dk>
 <20231004143937.GA3091822-robh@kernel.org>
In-Reply-To: <20231004143937.GA3091822-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AM9PR03MB7930:EE_
x-ms-office365-filtering-correlation-id: 2f4da2ca-ac1e-43c8-bb65-08dbc5227498
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ozhew78UJuzEVV8kN1vyDH+VCyWXwFafWcxDP+39x8iq41Bu26ZQz6OnKY4AneJRFsZF3frCzOCC12VvBb/q0fSzxDL2EyKSh0f46KVo4GD4MBCkllaEpCvkEIUfYJxOzY6MJaJRFCfwKSoU8YC7/kIOu8CO9uYNRamICrEcVssPqB/vsAQqAXLQqTWH+mlXhgdW/o4FkVSW2A/pQ9wmiddaTgKzBe+1e2UizI+uPm561tXQF8t5aVEX840WNTOmQujnS1CILULNW7xXDHottgLC62pclfApziKTN+TG/dTFiZRKMBk6vUq3KfvLo7AYnPks/Wj+uEA9gSMcSpsc7VvRo/VLd+S4OJgqA91GSyaL9+MDdH8A6jO1rMDMjq/L69Gq+rfc6CSrijIlj0xIa7KZQr3wnIJ1mfnLxIfGP0x0A1cqanVXs8floq/mWZGRJHI97FJItBGFJy93gyvki2P9JJYHe+cAoweg2DIS0yXOVXjG9TG56acnbD/p9Iyclr/GxF0ya88SHinF4QqjSRJqcjXJirtDEQgF0GPB2kEuOmN750wXV1mVY6Rg1GHmtIPz5UjNmKnHhZuCiyWvoI0wDGJqiyrwTjiz6xHB3M2GElHWEBJwTwhOaxa0/3Or
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(346002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(66446008)(64756008)(54906003)(66476007)(66946007)(66556008)(6916009)(316002)(41300700001)(6512007)(9686003)(6506007)(26005)(71200400001)(85182001)(478600001)(6486002)(85202003)(38100700002)(38070700005)(122000001)(86362001)(83380400001)(33716001)(91956017)(76116006)(7416002)(2906002)(4326008)(8936002)(5660300002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3RGd3JxcWpoZ0J0WEEveGZnNVhXd0xQUTkwMTI5MVJWMUNDcC83K0pqbnlu?=
 =?utf-8?B?TS8xaVgxSFk4VzZQOTR2azl2NjVGM3R6NFZOZDkrNGpHZnozRjZreXdNTmtX?=
 =?utf-8?B?eE1FVEhGc3MwY2x6SXdnemJsZXFhMkV6QWl1Yzh0SUUrUFFCMDV1NVB4VEtP?=
 =?utf-8?B?TS9DbGt3YnptYld3aWFBNFRPdkVIdEpOOW8xMDRoa1QvejRyRE91bjg2UWd6?=
 =?utf-8?B?blEzYXVTUmpCaHZJZWdEL0k1V25ycS94ZkNDSllXMVdOcTNmajhHaEFPOWVq?=
 =?utf-8?B?Y0ZZOHphT2kyM3lvdjBTY2x6Yy9JdkIxUFRRYUwvYzRvVTdsZlJuQjlHUHVS?=
 =?utf-8?B?bCtpVG5tUFNaR2c1dHdPRnl1L2lZeVJVRFdYWDJLdEE5WGtDNjl1RTVUS25s?=
 =?utf-8?B?TExzaWZzR2dkOEV3ZmVLa09Fbk9zWXJ2UDVpRVdWdjVWYUdOTitkN1IyN0sw?=
 =?utf-8?B?blFwWHVKMUdkRk9WRXJJOGtER3RSRjlkVFEvMEZjRlpsMUhPMUlWVGdvS2lr?=
 =?utf-8?B?ZWMranRpVXp4SlFuVlQ0RXQ1dDQ4SVBwY3d0Z2xNSytIcVJleFh5NkR4LzlC?=
 =?utf-8?B?bVVmQ01DcFZZUjkrNGlrYXUxcTFmeVA1Mm9KWVFzZE4zb2ZjcFhJUkc3Wmg5?=
 =?utf-8?B?WHZrVGRKckJONW1iTXZCbGg2cTV6YzEvVzBrbVE3VkVoUEF0UmkrQXBZOTkz?=
 =?utf-8?B?L1VSQ0tUVUE1bzVWQnFFdU1hV2tLZG80SEtTUXpRQUFQZTlyRTdsbndlZW9t?=
 =?utf-8?B?cDUxQ0ZtMjRDVDlNV1N6Vy9uVCt1NTZjQTNTOHBSYmtPclVsSFN5QnpMa2pw?=
 =?utf-8?B?dzQ2SW1HZmFya2cvemV4YjlxUHQzK0pyQkI4aG9XTXVBcEZPTitFVTNIb1Z3?=
 =?utf-8?B?MitUOWVORUM0QlQzY0lJWHB5dEViS1llOTRWek11VHB5OEJKUmdzWldWdldF?=
 =?utf-8?B?NkZ6L2FJeiszNnEzYzJZTUFDU2dzWlZCZm9ZSW83aEx6MVppOEJlVDNLNDQv?=
 =?utf-8?B?TmVVSHh3U0VqdWpVK1NkUEFBYVB5MWVVQ1BlRW95WVBybmEvUGhJMy9uREZn?=
 =?utf-8?B?VjhSQ1BZeGpGNW9xOGZ6WlFvcE9xeG5paE1La0hrTGl2NkFxWm5iT1UxbElT?=
 =?utf-8?B?RkRCSE9VbW9IUjRnRWc3dWdhaDl2VGxhOHlpNC8xVlIzb2gxVngvRDRzVERh?=
 =?utf-8?B?QjNaK1NFNDZpclgxU0hIY0YwTWlqQmxRaEVyc1BrSEFZZ1dEaEdxQ1QyUENE?=
 =?utf-8?B?QUREQ0lYeXJCK1JSREF3Qy9XWUlBM2FjR0hjNjZZYVE0Z1pYTEtjTXJZTVNI?=
 =?utf-8?B?b2V1R1RlbnJGTGRUb00yRnZFTFhWTUh1aWRLL3k4L281SkhiYmtSOCt2TEJt?=
 =?utf-8?B?SEZPYXBRWTBvamR4b1lKOGYxenZ5ZklpTGNXTzJGSTFGZW1ndlFldldlWVFL?=
 =?utf-8?B?S3BVdCtxLzFsY0FxcFFiTllMOThjZWpDck1MNCtROEZ3SmhjZ0xDLzNOZkFo?=
 =?utf-8?B?THdWNDhtY1F0YkZCSHNIdG5YL3lVeWhaTTBjaklxbXh0VlBlS3d3Tk92aWk0?=
 =?utf-8?B?K1A0czUwaERQb1NYeHE1TFhpdHV2K0xRNFg0cDVDaG5kTlQ5dk04MW91Yk5j?=
 =?utf-8?B?ZXFBalNaSWtXTWlHQ1ljQ3hXMEhOYk9jZ05oanZQdlF3OVByYjhseGlhZVFq?=
 =?utf-8?B?TXhPRXo2YWVBbEs4ekg5aTVxL294ZVZoRE1INll3UGloZDNTZE9HTFZqM2FW?=
 =?utf-8?B?NEZXakRkdVZLa2pUVHZaSGVJSVFVQUsxZFg1TDZsaUVheU1MejVDMnN5Z29q?=
 =?utf-8?B?dFY4SjhjT0pYclk5Q2IzWjhOQkJrekZ0dzJQL3JmWUlleU8yRHQxL1RXektV?=
 =?utf-8?B?bWxpVHZBTFl2QlVNNGRuVVB4UXRkcmY4U2F3Ylo4RG05TFZ2TTZmWUtKa0JZ?=
 =?utf-8?B?YVhVNWs3SjhXOUhkem5hRUpaaEdVSmMxN2U2cTJrL094OFZYVTh6YmhNTXFO?=
 =?utf-8?B?djE2ejhaekNrdjRRMnJHTENHRDNWeG92WllsMmJGRm93Uk1yRUJWR0hHM1Bu?=
 =?utf-8?B?VzdxWXl6NmxrcXNyL2M1QzRiWURMUGhkQ0hsTitjZlp5czFsVjJ6c2ZGMEp5?=
 =?utf-8?Q?cPlhfvzJGWCu08ElfGr1GwR4E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61F82774FB2232439A4425C7B8827394@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4da2ca-ac1e-43c8-bb65-08dbc5227498
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 21:39:57.8257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: box8D+tzK8a8GY8/oJqC+wxSg09JhcWWyl6m5Rv3bseVpwmQ3BcQ6uHrGyHLVbLrDTpr//rR/tmujNy11O4BLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7930
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBPY3QgMDQsIDIwMjMgYXQgMDk6Mzk6MzdBTSAtMDUwMCwgUm9iIEhlcnJpbmcgd3Jv
dGU6DQo+ID4gKyAgICAgIHNpbGFicyxtdWx0aXN5bnRoLXNvdXJjZToNCj4gPiArICAgICAgICAk
cmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgICAg
ICBlbnVtOiBbIDAsIDEgXQ0KPiA+ICsgICAgICAgIGRlc2NyaXB0aW9uOiB8DQo+IA0KPiBEb24n
dCBuZWVkICd8JyBpZiBubyBmb3JtYXR0aW5nIHRvIHByZXNlcnZlLg0KDQpJIHRob3VnaHQgdGhl
IGxpbmUgd291bGQgYmUgdG9vIGxvbmcgb3RoZXJ3aXNlLg0KQ29sdW1uIHdpZHRoIGlzIDgwIGlu
IGR0LXNjaGVtYSBhcyB3ZWxsLCByaWdodD8NCg0KPiANCj4gPiArICAgICAgICAgIFNvdXJjZSBQ
TEwgQSAoMCkgb3IgQiAoMSkgZm9yIHRoZSBjb3JyZXNwb25kaW5nIG11bHRpc3ludGggZGl2aWRl
ci4NCj4gPiArDQoNClsuLi5dDQoNCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVz
Og0KPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250YWluczoNCj4g
PiArICAgICAgICAgICAgZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHNpbGFicyxzaTUzNTFh
DQo+ID4gKyAgICAgICAgICAgICAgLSBzaWxhYnMsc2k1MzUxYS1tc29wDQo+ID4gKyAgICAgICAg
ICAgICAgLSBzaWxhYnMsc2k1MzUxYg0KPiANCj4gSXNuJ3QgdGhpcyBqdXN0IHRoZSAnZWxzZScg
Zm9yIHRoZSBuZXh0IG9uZT8gT3IgbW9yZSBwYXJ0cyBhcmUgY29taW5nPw0KDQpOb3Qgc3VyZSBp
ZiBtb3JlIHBhcnRzIGFyZSBjb21pbmcgLSB0aGVzZSBhcmUgdGhlIG9ubHkgb25lcyBJIGFtIGF3
YXJlIG9mLiBCdXQgSQ0KaGF2ZSBub3QgY2hlY2tlZCB0aG9yb3VnaGx5LiBJIHRob3VnaHQgaXQg
YmV0dGVyIHRvIGJlIGV4cGxpY2l0LCBidXQgSSB3aWxsDQpjaGFuZ2UgdGhlIG5leHQgb25lIHRv
IGFuIGVsc2U6IGluIHYzIHVubGVzcyB5b3UgY2hhbmdlIHlvdXIgbWluZC4NCg0KPiANCj4gPiAr
ICAgIHRoZW46DQo+ID4gKyAgICAgIHByb3BlcnRpZXM6DQo+ID4gKyAgICAgICAgY2xvY2tzOg0K
PiA+ICsgICAgICAgICAgbWluSXRlbXM6IDENCj4gPiArICAgICAgICAgIG1heEl0ZW1zOiAxDQo+
ID4gKyAgICAgICAgY2xvY2stbmFtZXM6DQo+ID4gKyAgICAgICAgICBpdGVtczoNCj4gPiArICAg
ICAgICAgICAgLSBjb25zdDogeHRhbA0KPiA+ICsNCj4gPiArICAtIGlmOg0KPiA+ICsgICAgICBw
cm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNvbXBhdGlibGU6DQo+ID4gKyAgICAgICAgICBjb250
YWluczoNCj4gPiArICAgICAgICAgICAgY29uc3Q6IHNpbGFicyxzaTUzNTFjDQo+ID4gKyAgICB0
aGVuOg0KPiA+ICsgICAgICBwcm9wZXJ0aWVzOg0KPiA+ICsgICAgICAgIGNsb2NrczoNCj4gPiAr
ICAgICAgICAgIG1pbkl0ZW1zOiAxDQo+ID4gKyAgICAgICAgICBtYXhJdGVtczogMg0KPiA+ICsg
ICAgICAgIGNsb2NrLW5hbWVzOg0KPiA+ICsgICAgICAgICAgbWluSXRlbXM6IDENCj4gPiArICAg
ICAgICAgIGl0ZW1zOg0KPiA+ICsgICAgICAgICAgICAtIGNvbnN0OiB4dGFsDQo+ID4gKyAgICAg
ICAgICAgIC0gY29uc3Q6IGNsa2luDQo+IA0KPiBEZWZpbmUgY2xvY2tzIGFuZCBjbG9jay1uYW1l
cyBhdCB0aGUgdG9wIGxldmVsIGFuZCBqdXN0IHVzZSANCj4gbWluSXRlbXMvbWF4SXRlbXMgaW4g
dGhlIGlmL3RoZW4gc2NoZW1hcy4NCg0KSSB3YXMgdHJ5aW5nIHRvIGltcGx5IGhlcmUgdGhhdCBp
dCBpcyBpbnZhbGlkIHRvIHNwZWNpZnkgY2xraW4gZm9yIHRoZSBmb3JtZXINCnRocmVlIHBhcnQg
dHlwZXMgLSBvbmx5IGZvciB0aGUgc2k1MzUxYy4gSWYgSSBzcGVjaWZ5IGJvdGggaW4gdGhlIHRv
cC1sZXZlbA0KY2xvY2stbmFtZXM6aXRlbXMgdGhlbiBpdCB3b3VsZCBhbGxvdyBzb21ldGhpbmcg
bGlrZSB0aGlzOg0KDQogIGNsayB7DQogICAgY29tcGF0aWJsZSA9ICJzaWxhYnMsc2k1MzUxYS1t
c29wIjsNCiAgICBjbG9ja3MgPSA8JnJlZjI1PjsNCiAgICBjbG9jay1uYW1lcyA9ICJjbGtpbiI7
IC8qIG5vdCBPSyAtIFNpNTM1MUEtTVNPUCBvbmx5IHN1cHBvcnRzIFhUQUwgKi8NCiAgfTsNCg0K
S2luZCByZWdhcmRzLA0KQWx2aW4=
