Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BF97594A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjGSLug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGSLua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:50:30 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40442170E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1689767424; x=1692359424;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6TayMIbwLtGf8ga1EeYBcxxX3br5/uQwKHx9GHCERww=;
        b=LLth0KR7oao8FfDiqt6nSdYTEq5oBwBiZALdo/M4fjhXzTHm1jGCOIoEHLsEPwxx
        /cQrM7uk6oq4c90VE5YM5AKXgYgGlBSAWJqjc2zkacT1A7G+fPORhij5tdJnd6MN
        bdSDyg5Ss9ZqHfUtmjJ+yohaYYzG0i0OTxQibVQ8apc=;
X-AuditID: ac14000a-917fe70000007ecb-45-64b7ce0017d7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 8F.D8.32459.00EC7B46; Wed, 19 Jul 2023 13:50:24 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jul
 2023 13:50:42 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Wed, 19 Jul 2023 13:50:42 +0200
From:   =?utf-8?B?U3RlZmFuIFJpZWRtw7xsbGVy?= <S.Riedmueller@phytec.de>
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "andrej.picej@norik.com" <andrej.picej@norik.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?U3RlZmFuIE3DvGxsZXItS2xpZXNlcg==?= 
        <S.Mueller-Klieser@phytec.de>,
        "upstream@phytec.de" <upstream@phytec.de>
Subject: Re: [PATCH v2 3/3] ARM: dts: imx6: phycore: Rely on PMIC reboot/reset
 handler
Thread-Topic: [PATCH v2 3/3] ARM: dts: imx6: phycore: Rely on PMIC
 reboot/reset handler
Thread-Index: AQHZujZYvRuJhhLzmEmfWExqJgVZ8K/A2HEA
Date:   Wed, 19 Jul 2023 11:50:42 +0000
Message-ID: <d00c1404bea50dab7db9063acef1f0b8f2ae74a9.camel@phytec.de>
References: <20230719114328.2239818-1-andrej.picej@norik.com>
         <20230719114328.2239818-3-andrej.picej@norik.com>
In-Reply-To: <20230719114328.2239818-3-andrej.picej@norik.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A64C0F8DA98A984391E1CF8E774FB578@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWyRpKBR5fh3PYUg6fnRSym7mW0WLP3HJPF
        /CPnWC0eXvW3WDV1J4tF34uHzBabHl9jtej6tZLZ4vKuOWwWrXuPsFv83b6JxeLFFnEHHo+d
        s+6ye2xa1cnmcefaHjaPzUvqPb5/3cDqsfHdDiaP/r8GHp83yQVwRHHZpKTmZJalFunbJXBl
        fJvWzlLwRKCifcpxlgbGNQJdjBwcEgImEsdbHbsYuTiEBJYwSczrnswE4TxglHiz5CU7hLOR
        UWLFrA+MXYycHGwCLhKf276xgSREBI4zS6z9MoUFxGEWOMUkceb1A2aQKmGBCImN276wg+wQ
        EYiUeDc7F8I0knh3PwWkgkVAVeLQ9yYmEJtXwE3ied82dhBbSKBIYsKPGWC7OAXsJG6v7mAB
        sRkFZCU6G96B1TMLiEtsevadFcSWEBCQWLLnPDOELSrx8vE/qLi8xIlb05hA1jILaEqs36UP
        0Woh8fzhR2YIW1FiSvdDdogTBCVOznzCMoFRfBaSDbMQumch6Z6FpHsWku4FjKyrGIVyM5Oz
        U4sys/UKMipLUpP1UlI3MYJiX4SBawdj3xyPQ4xMHIyHGCU4mJVEeB9d3pYixJuSWFmVWpQf
        X1Sak1p8iFGag0VJnPd+D1OikEB6YklqdmpqQWoRTJaJg1OqgZHnRJDQjusBPx+vdDW0sEvm
        //p3C4vNRsms87cWKT7ameHrOeO99aa/liqT357998dRYtJi0bBliZuSNj9bkDLrknL+zus7
        dz3e/vqE67qFVnIr9hUd0tov+Kr6WtO5nOkbFskft/hw5laMrV7Ku5OpxstvPBDYeyCdvbai
        1+nkp0x1s7cq9+KmKLEUZyQaajEXFScCAB45VCDrAgAA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVqLA0KDQpPbiBXZWQsIDIwMjMtMDctMTkgYXQgMTM6NDMgKzAyMDAsIEFuZHJlaiBQ
aWNlaiB3cm90ZToNCj4gRHVlIHRvIHRoZSBtaXNzaW5nIHNpZ25hbCBjb25uZWN0aW9uIGJldHdl
ZW4gaS5NWDYgV0RPR19CIHBpbiBhbmQgdGhlDQo+IFBNSUNzIGV4dGVybmFsIHJlc2V0LCB0aGUg
aW50ZXJuYWwgaS5NWDYgd2F0Y2hkb2cgaXMgbm90IGFibGUgdG8gcmVzZXQNCj4gdGhlIHBoeUNP
UkUgaS5NWDYgU29NIHByb3Blcmx5LiBUaHVzIGRpc2FibGUgdGhlIGludGVybmFsIGkuTVg2IHdh
dGNoZG9nDQo+IHRvIHByZXZlbnQgdW5leHBlY3RlZCBQTUlDIHNldHRpbmdzIGFmdGVyIHJlc2V0
Lg0KPiANCj4gTk9URTogVGhpcyBwYXRjaCBzaG91bGQgbm90IGJlIGJhY2twb3J0ZWQgYXMgaXQg
bWlnaHQgYnJlYWsgZXhpc3RpbmcNCj4gdXNlcyBhbmQgZml4ZXMgaW4gYm9vdGxvYWRlcnMuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmRyZWogUGljZWogPGFuZHJlai5waWNlakBub3Jpay5jb20+
DQoNClJldmlld2VkLWJ5OiBTdGVmYW4gUmllZG3DvGxsZXIgPHMucmllZG11ZWxsZXJAcGh5dGVj
LmRlPg0KDQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiDCoC0gbmV3IHBhdGNoDQo+IMKgLSBp
Lk1YNiBwaHlDT1JFcyBoYXZlIHRoZSBzYW1lIHByb2JsZW0gYXMgcGh5RkxFWCBkZXZpY2VzLg0K
PiAtLS0NCj4gwqBhcmNoL2FybS9ib290L2R0cy9ueHAvaW14L2lteDZxZGwtcGh5dGVjLXBoeWNv
cmUtc29tLmR0c2kgfCA4ICsrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFk
bC1waHl0ZWMtcGh5Y29yZS1zb20uZHRzaQ0KPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgv
aW14NnFkbC1waHl0ZWMtcGh5Y29yZS1zb20uZHRzaQ0KPiBpbmRleCAyOGE4MDUzODQ2NjguLjg2
YjQyNjllMGUwMSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9pbXg2
cWRsLXBoeXRlYy1waHljb3JlLXNvbS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL254
cC9pbXgvaW14NnFkbC1waHl0ZWMtcGh5Y29yZS1zb20uZHRzaQ0KPiBAQCAtMzA5LDMgKzMwOSwx
MSBAQCBNWDZRRExfUEFEX1NENF9EQVQ3X19TRDRfREFUQTfCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoDB4MTcwNTkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA+Ow0KPiDCoMKg
wqDCoMKgwqDCoMKgfTsNCj4gwqB9Ow0KPiArDQo+ICsmd2RvZzEgew0KPiArwqDCoMKgwqDCoMKg
wqAvKg0KPiArwqDCoMKgwqDCoMKgwqAgKiBSZWx5IG9uIFBNSUMgcmVib290IGhhbmRsZXIuIElu
dGVybmFsIGkuTVg2IHdhdGNoZG9nLCB0aGF0IGlzDQo+IGFsc28NCj4gK8KgwqDCoMKgwqDCoMKg
ICogdXNlZCBmb3IgcmVib290LCBkb2VzIG5vdCByZXNldCBhbGwgZXh0ZXJuYWwgUE1JQyB2b2x0
YWdlcyBvbg0KPiByZXNldC4NCj4gK8KgwqDCoMKgwqDCoMKgICovDQo+ICvCoMKgwqDCoMKgwqDC
oHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICt9Ow0K
