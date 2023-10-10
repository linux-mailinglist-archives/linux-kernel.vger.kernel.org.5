Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE047BF926
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjJJLFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjJJLFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:05:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2139.outbound.protection.outlook.com [40.107.22.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017EF94;
        Tue, 10 Oct 2023 04:05:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLx4RYEp9c7WlC2lWoQD6g77HbdK5SSAQt+jVNFFh21Ht95nx2VeHWEdcRrfvajjT5XyVUZuAu9I7ZiYrYc8U7WSdH/Lf3ScgX/pen9dhlNDfrmva16C86LHbksuQm41PzGV0ug5lgBe3fRgt8v37QbfBqURjPWsXNBg7onLCcrSp7CrltFOB6nyyKrVn40/0ThRdcrsgnn+XEYWVc9q78aDmrMl/26GixJx562RxiofGEOSz7fMtqI+e4uK6izLt/8X/X0+YY4jQfQxjskAZ3DoD1qEVX/7UwM3MJBtkan90zM+Het/iq4Tslhx98KqzWTXt5BHsuKa2JGERyaNeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vXhlDOgIjRxJ4spgsnebm0qC+OrG2CknNZx1kLuAPQ=;
 b=dbjHr/uPHuzC2pVcHvSHZ4bzBwRaZG0b6+gj79T0Tgf16gQ46r13+8wCqzcmhXB/IzABjmo9Q+5q60I70LFujS9k1gRZc7wPerlrqmwG7qxGNcw36lhFVTlhlB8FuwRGufm+u+8KchVIPhKAbXwzDFKQ6cIqqGT/qNaig+zDg/C50Y2WfrxIXNnyfwiQh0+a+Jio3228J5gXRm9rJv3HNAYrIF5CG3pyRK7AC6cy3tBcH3S9OBWI+sst3b7Q0s49W5FG6ekgpT0/KQPNLwdtTOxAjHfN0ltXTmRNuJ7t6DjPADIGFq1Bj/fNxMG6Flr9gOHPbgcYnTk+GUJGz9jxfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vXhlDOgIjRxJ4spgsnebm0qC+OrG2CknNZx1kLuAPQ=;
 b=kTP5h0SPE8dN0sfeDAxtMy1tWihse3QzvQaK53B3wcmOk416sMrIAjgZttannvYXM6qvFTs2CJGG2U4VvPQ0AKeshZlaB+MmMFvKjLnaZm4xbC1rfPraHgD3e8xaBczJapuXnGdttm5Guo2Jq+Xn8porKWd5H0YAirr34qJnLSg=
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com (2603:10a6:20b:26::24)
 by AS8PR03MB6728.eurprd03.prod.outlook.com (2603:10a6:20b:29f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 11:05:05 +0000
Received: from AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::fb3c:4931:e74e:c691]) by AM6PR03MB3943.eurprd03.prod.outlook.com
 ([fe80::fb3c:4931:e74e:c691%3]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 11:05:04 +0000
From:   =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To:     Justin Stitt <justinstitt@google.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
Thread-Topic: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
Thread-Index: AQHZ+wIbcwTMjUrkiUmY/MMUWpl2xrBC3TkA
Date:   Tue, 10 Oct 2023 11:05:04 +0000
Message-ID: <gcp232latw2qcszw47fpverzp5bw6jwcc7ktj3y2t3xlnwigff@n4lqte6u5eav>
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR03MB3943:EE_|AS8PR03MB6728:EE_
x-ms-office365-filtering-correlation-id: 156ab21a-41f2-49be-daf5-08dbc980c1c6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EOTl/xwlf7PnmD7H1M6V0r8JsR+fv8C15RyQsvHb7WR43EFPJuaaiLkFmC+gZSRPbyHvK0Eca8bgp+HqTMivcxwK/lUR7137llaNxL7iqo0Rp2Lkf3wtbUStD9ij9tG1117gUxEyM3Cnck0Is5oe+bJ0Br3ZnLnZpJS8lv/A9nyobtNEFZyXTXXbx/TwsqWAe8UB/EbQ5CqfyIEeAlmnUA9QiUHRJ1oabd/jqatkXGyo/utOjCOthAu8GLMobS05QY/44Fa3xTRuXvnOhKr6HzrAaoaEsTgVB86NLjZVYBjFZTXvW0137Tg22LTaRS20t9lMiK42qwkDHIKIuWChnm1DTPk2A5WfkQmsNB4G1ToaK2Q11C+nnDJQCSW9P6Kn8hUV6Uf9RNx1XeRmc60TqW1vwjyZpixprvePnOUUjBGdjaoeQoa2+4wlKukGX+o3fd8Lxe3oY+la0YtiLVY+jGBzLsw9xkUFUrL4EdKHwH34pPqg2NBBJWuKlh2Xfc883qXdv2aPy1V2TPKm52dRSO+lmPsCQirJryRQZdgn/LSVNs6H4/o4jw6/SkakjKsCRcb3mChb19J7saWOQa4CkVRYHRxx0kMMHu2nDtmfXe4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR03MB3943.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39850400004)(376002)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(85182001)(85202003)(71200400001)(478600001)(66574015)(33716001)(26005)(83380400001)(38070700005)(9686003)(122000001)(6512007)(6506007)(86362001)(2906002)(6486002)(966005)(38100700002)(41300700001)(5660300002)(66556008)(66446008)(66946007)(91956017)(66476007)(316002)(64756008)(6916009)(54906003)(8676002)(4326008)(8936002)(76116006)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDhyVWR2ZVU4TTVrTnhFWGgzeVZJdjRKT0NkZnU0dVlRbjlsYnRxbzRiWEVH?=
 =?utf-8?B?VjdWWk0vRFY2djEwS1NFb2ZXYVluWm5TaEsrdGxSaS9IOWc1SmhDZVNhRDhZ?=
 =?utf-8?B?SEFhZytFVlIrT01IWmFHQVBHdmp1OCtGaHZPakpnVlJ5SjdiOGhzMWJaNnJp?=
 =?utf-8?B?Vy92STJ0cDVzQ2Fjc3FsU29tVlczUFUxajduU0wrRTRMdHAzVVVKVWJ5bTli?=
 =?utf-8?B?MWpuRWRpWEgzLzE0dXRYMkVMeTIzL3FuZmhwME13VzQ1ZU5lWm1WakRYZzJi?=
 =?utf-8?B?RmlDNkVEMTk0Ni83RXdFWlorM2FqZnBaRjVQMTVLRFBUeHlEL3NtMWwyYkRw?=
 =?utf-8?B?U3JMaTVQY2Y1TGdyM2xDZlNiajNEamhPeVo1dUVjR2NEMkp5VUc5bGlJRnlD?=
 =?utf-8?B?Ulh3Rm1acENKbEh2bmJjeTVRRThSWEw2MHVKTVBrbitWMDRVMDg4MEt0Wlpp?=
 =?utf-8?B?UDZWZ1N3Njcxcys5Z202NXlXRC9ONklsMEhkRUxxZUg3b1JJczQwN2UrU1Fa?=
 =?utf-8?B?RzMrNXFOV1FTMlhKSXdyWWxwa1dVT3N2QmtvMjlXT252ei9nMnQ4aXpqSEtt?=
 =?utf-8?B?K0xKWnFWb0xIVUZTRGxXeXp3Qm10Z2ljcFcrckhDOTlLZU9pc2dBUk80M09p?=
 =?utf-8?B?Mk10dCtoYlBEemZGNi9OOHdyZzR0S0IvaTQrVFhhbW53TkZvVjk2OWpLK3RN?=
 =?utf-8?B?L2pSQWNHZW12YmtxYjNiZXQ5NW9vS2ZmZ2JHNVNWeEhLQnd2SGhLUUdqTG1o?=
 =?utf-8?B?USs5VW13RUs3cm53dGhtd1labjJQdXUxYkF1ajU2ME5HVXJkTG5uMDV3bFFS?=
 =?utf-8?B?ZEJWN1duOHZSZ0Y2eVVzSTlHc3JoMmFCT0pHZ1llZXQ5QkpzME9Ybk94amZ6?=
 =?utf-8?B?dHVtNWs2QzRqNWJOWDRCb2NGYWlTL1lUN3o4d3cxQ21rL1VLckNRbURlbTV6?=
 =?utf-8?B?bHdSM0lDd3ZuOFp5MmR1Nnh0MktaZ0JzenlSbklLMmhSRkc1emowY1ExVzJN?=
 =?utf-8?B?aU1RSDNMd24rakZuN2pBbW9mblpvbHRPK2J3YTEyVE1UalBHVWkzU2E5ZzlN?=
 =?utf-8?B?TlFHdzlyUG1wZGgrYTk0bC9XeTkxTllneDBhOTN6WlNiT2pXS1haUWY3alpu?=
 =?utf-8?B?a0VIYUc5clBuemtnTkpkZjBCUjR4T1RLdzhSWjdXekJuWnJaNnlldC9vV0k3?=
 =?utf-8?B?MERPR1JQQ2NPdnpMaEptVVNZZlQ0SXMzNGNGQjZoRER4R0ZWOUhJY2I2a1JU?=
 =?utf-8?B?THRheGlreDBUU1lJUG9QYkZZa0ZJWGhXYUxHTFQvRUxoUDBmYnZUaFluRkEy?=
 =?utf-8?B?NWlkVFBRV1h2dVFNQ3RraFVkb3JqSVpLK1diZFlOU1B2aFp6RzF6amdjN04w?=
 =?utf-8?B?UFhQOWNkSTZBQXlDOGdFYTU5L005a2IxemZkOThNaTBSTXY2RXlqaDk3aDZJ?=
 =?utf-8?B?aGxscXhydFFhS2QxTHozRnltcjdaaWRrWkZIUkxRclZBa00ySzczTDY0dkFj?=
 =?utf-8?B?dU90TGRORnRvL1VIWTFackxvaWJYbG13SlNGbkNIR0NqdDR4UXFYUXpkNWd1?=
 =?utf-8?B?SWxtU3Q0Q3hyZm5kS1ZnZXZreWxDdm9pY3FoUUhTS3ROREZvTi93a3N2Vzhj?=
 =?utf-8?B?dFdIQkMrdmU5M1o5Vk1TY3pYYzJGc3hZSXRTKzc1TE9mcFpZZ0VpT3gyamRw?=
 =?utf-8?B?TUVWRUZ3Zmc3bHZLbEt6dWd6TmZzUUphK25SVUFOYWNiR2hpVVh0ZHk2SGpH?=
 =?utf-8?B?emo2eTFGNlB6YWxtNTdVenZJYTBMdHQveXZHRVB5MU03U1dMUzFEZFQ2WXlK?=
 =?utf-8?B?REJFeE5DclRESmhZZGJvZm9BbytTV0VRZ1dOTGNqYVk0Mjh2NGh0cWVzSkdI?=
 =?utf-8?B?dVJCbmh5Vk9DSjlKbjd2d0hrWUc0LytQaDB6WGFSdUJ2WTBTcEJnZjdzOGtz?=
 =?utf-8?B?clZWYzNKaS9Ic1pveUk2UERUYkhGbGhQY1BINnNPMVFWZXBZYXZ0dGFsck52?=
 =?utf-8?B?OTZSYTEzWUNVc0V5WFlvQWhSL0NwQlRjRDU5QXFOWjZpYmoyNDBPSVk3Z1Rm?=
 =?utf-8?B?VVp4RHRkTzZtRGtlRlYzRkZPbDVvdURBZ0MzTTRwV1dyL1d5aGtWOEhYODkw?=
 =?utf-8?Q?TD5BD8EopbeDtfx8K6vaNhsav?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <36D414BC04F399449DC165FAC2D57080@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB3943.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156ab21a-41f2-49be-daf5-08dbc980c1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Oct 2023 11:05:04.6895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XQjUf/oNG4bJJwH3JL+hZe8J8sfYwpw8soNgxoxbsyQ79f4rL8RIoEG7j/03VddBdFEIXMrJm/C5e8gjoQKkGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6728
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBPY3QgMDksIDIwMjMgYXQgMTA6NDM6NTlQTSArMDAwMCwgSnVzdGluIFN0aXR0IHdy
b3RlOg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGp1c3RpbnN0aXR0QGdvb2ds
ZS5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9MZWFy
bkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPiANCj4gYHN0cm5jcHlgIGlzIGRlcHJlY2F0
ZWQgZm9yIHVzZSBvbiBOVUwtdGVybWluYXRlZCBkZXN0aW5hdGlvbiBzdHJpbmdzDQo+IFsxXSBh
bmQgYXMgc3VjaCB3ZSBzaG91bGQgcHJlZmVyIG1vcmUgcm9idXN0IGFuZCBsZXNzIGFtYmlndW91
cyBzdHJpbmcNCj4gaW50ZXJmYWNlcy4NCj4gDQo+IGV0aHRvb2xfc3ByaW50ZigpIGlzIGRlc2ln
bmVkIHNwZWNpZmljYWxseSBmb3IgZ2V0X3N0cmluZ3MoKSB1c2FnZS4NCj4gTGV0J3MgcmVwbGFj
ZSBzdHJuY3B5IGluIGZhdm9yIG9mIHRoaXMgbW9yZSByb2J1c3QgYW5kIGVhc2llciB0bw0KPiB1
bmRlcnN0YW5kIGludGVyZmFjZS4NCj4gDQo+IExpbms6IGh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcv
ZG9jL2h0bWwvbGF0ZXN0L3Byb2Nlc3MvZGVwcmVjYXRlZC5odG1sI3N0cm5jcHktb24tbnVsLXRl
cm1pbmF0ZWQtc3RyaW5ncyBbMV0NCj4gTGluazogaHR0cHM6Ly9tYW5wYWdlcy5kZWJpYW4ub3Jn
L3Rlc3RpbmcvbGludXgtbWFudWFsLTQuOC9zdHJzY3B5LjkuZW4uaHRtbCBbMl0NCj4gTGluazog
aHR0cHM6Ly9naXRodWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzkwDQo+IENjOiBsaW51eC1oYXJk
ZW5pbmdAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IEp1c3RpbiBTdGl0dCA8anVz
dGluc3RpdHRAZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IEFsdmluIMWgaXByYWdhIDxhbHNp
QGJhbmctb2x1ZnNlbi5kaz4NCg0KPiAtLS0NCj4gTm90ZTogYnVpbGQtdGVzdGVkIG9ubHkuDQo+
IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL3JlYWx0ZWsvcnRsODM2NW1iLmMgfCAzICstLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjVtYi5jIGIvZHJpdmVycy9u
ZXQvZHNhL3JlYWx0ZWsvcnRsODM2NW1iLmMNCj4gaW5kZXggNDFlYTNiNWE0MmIxLi5kMTcxYzE4
ZGQzNTQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjVtYi5j
DQo+ICsrKyBiL2RyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzNjVtYi5jDQo+IEBAIC0xMzAz
LDggKzEzMDMsNyBAQCBzdGF0aWMgdm9pZCBydGw4MzY1bWJfZ2V0X3N0cmluZ3Moc3RydWN0IGRz
YV9zd2l0Y2ggKmRzLCBpbnQgcG9ydCwgdTMyIHN0cmluZ3NldA0KPiANCj4gICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgUlRMODM2NU1CX01JQl9FTkQ7IGkrKykgew0KPiAgICAgICAgICAgICAgICAg
c3RydWN0IHJ0bDgzNjVtYl9taWJfY291bnRlciAqbWliID0gJnJ0bDgzNjVtYl9taWJfY291bnRl
cnNbaV07DQo+IC0NCj4gLSAgICAgICAgICAgICAgIHN0cm5jcHkoZGF0YSArIGkgKiBFVEhfR1NU
UklOR19MRU4sIG1pYi0+bmFtZSwgRVRIX0dTVFJJTkdfTEVOKTsNCj4gKyAgICAgICAgICAgICAg
IGV0aHRvb2xfc3ByaW50ZigmZGF0YSwgIiVzIiwgbWliLT5uYW1lKTsNCj4gICAgICAgICB9DQo+
ICB9DQo+IA0KPiANCj4gLS0tDQo+IGJhc2UtY29tbWl0OiBjYmYzYTJjYjE1NmEyYzkxMWQ4ZjM4
ZDgyNDc4MTRiNGMwN2Y0OWEyDQo+IGNoYW5nZS1pZDogMjAyMzEwMDktc3RybmNweS1kcml2ZXJz
LW5ldC1kc2EtcmVhbHRlay1ydGw4MzY1bWItYy1iYjEwNmU0YzExMGMNCj4gDQo+IEJlc3QgcmVn
YXJkcywNCj4gLS0NCj4gSnVzdGluIFN0aXR0IDxqdXN0aW5zdGl0dEBnb29nbGUuY29tPg0KPg==
