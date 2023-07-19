Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9CF1759494
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGSLth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGSLtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:49:35 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F55C7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1689767362; x=1692359362;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=s3SfUHLDoHQ9D2o5HMY3KB6nOOANyL/Of0yxevezC2c=;
        b=cRA5U8Q/l4ycIUS0srsopJ6Cc+UNKYh7t3N5sdyehcb48t3/2KZRy6nydPffEJRV
        2ER+XWtJA+Y55RWpXdc92e3kWKANiOSL1iu3X7Zc0U1hDogfYJ0+WdOnGOueLl/n
        CLJOe84VSH0mN069La/0Y7ygg9lpVvk3u9pZI3eqLjk=;
X-AuditID: ac14000a-923ff70000007ecb-10-64b7cdc20574
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E5.D8.32459.2CDC7B46; Wed, 19 Jul 2023 13:49:22 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jul
 2023 13:49:22 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Wed, 19 Jul 2023 13:49:41 +0200
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
Subject: Re: [PATCH v2 1/3] ARM: dts: imx6: phytec: fix RTC interrupt level
Thread-Topic: [PATCH v2 1/3] ARM: dts: imx6: phytec: fix RTC interrupt level
Thread-Index: AQHZujZYwhDq3JUyW0qf/O3X4BzlVK/A2CcA
Date:   Wed, 19 Jul 2023 11:49:41 +0000
Message-ID: <79bb474aaf49fca37ede6cefce241aec6eeade0d.camel@phytec.de>
References: <20230719114328.2239818-1-andrej.picej@norik.com>
In-Reply-To: <20230719114328.2239818-1-andrej.picej@norik.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <66404B180153F7409EBCA3C558D1CFBB@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWyRpKBV/fQ2e0pBq3dVhZT9zJarNl7jsli
        /pFzrBYPr/pbrJq6k8Wi78VDZotNj6+xWnT9WslscXnXHDaL1r1H2C3+bt/EYvFii7gDj8fO
        WXfZPTat6mTzuHNtD5vH5iX1Ht+/bmD12PhuB5NH/18Dj8+b5AI4orhsUlJzMstSi/TtErgy
        Oi4+Yi+YwlexZvlcxgbGJ7xdjJwcEgImEove3WXpYuTiEBJYwiSx89FVZgjnAaPEzoN/oJyN
        jBK/Nn9jA2lhE3CR+NwGYnNxiAgcZ5ZY+2UKWD+zwCkmiTOvHzCDVAkLeEv82t3KCmKLCPhI
        rFz+ih3CNpL4v/AfkM3BwSKgKrFgtjhImFfATeLsr98sILaQgK3E1hurmEBsTgE7iXNXFoPF
        GQVkJTob3oHFmQXEJTY9+84K8YOAxJI955khbFGJl4//QcXlJU7cmsYEsopZQFNi/S59iFYL
        iSPHlkGNUZSY0v2QHeIEQYmTM5+wTGAUn4VkwyyE7llIumch6Z6FpHsBI+sqRqHczOTs1KLM
        bL2CjMqS1GS9lNRNjKD4F2Hg2sHYN8fjECMTB+MhRgkOZiUR3keXt6UI8aYkVlalFuXHF5Xm
        pBYfYpTmYFES573fw5QoJJCeWJKanZpakFoEk2Xi4JRqYGQucTwR0PGsvXuGSqn8wzU5cY57
        Pgnun6o1P1Kszvf8x322j7ZwaLw+f7/aWF5HslXymNunSmapxpenzWfc/CW/qJWhlr/c/MyP
        D70HZ7ZlHyj7YDZTbGrtwRfaHT0SZXJ9sv8m813b9M8nfGHYBE/bPUwHL7/1z3LPnbxO9pbO
        wqm3a5/2fFNiKc5INNRiLipOBADOqa5o7QIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVqLA0KDQpPbiBXZWQsIDIwMjMtMDctMTkgYXQgMTM6NDMgKzAyMDAsIEFuZHJlaiBQ
aWNlaiB3cm90ZToNCj4gUlRDIGludGVycnVwdCBsZXZlbCBzaG91bGQgYmUgc2V0IHRvICJMT1ci
LiBUaGlzIHdhcyByZXZlYWxlZCBieSB0aGUNCj4gaW50cm9kdWN0aW9uIG9mIGNvbW1pdDoNCj4g
DQo+IMKgIGYxODE5ODdlZjQ3NyAoInJ0YzogbTQxdDgwOiB1c2UgSVJRIGZsYWdzIG9idGFpbmVk
IGZyb20gZndub2RlIikNCj4gDQo+IHdoaWNoIGNoYW5nZWQgdGhlIHdheSBJUlEgdHlwZSBpcyBv
YnRhaW5lZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlaiBQaWNlaiA8YW5kcmVqLnBpY2Vq
QG5vcmlrLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBSaWVkbcO8bGxlciA8cy5yaWVkbXVl
bGxlckBwaHl0ZWMuZGU+DQoNCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+IMKgLSBubyBjaGFu
Z2VzDQo+IC0tLQ0KPiDCoGFyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC1waHl0ZWMt
bWlyYS5kdHNpIHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgv
aW14NnFkbC1waHl0ZWMtbWlyYS5kdHNpDQo+IGIvYXJjaC9hcm0vYm9vdC9kdHMvbnhwL2lteC9p
bXg2cWRsLXBoeXRlYy1taXJhLmR0c2kNCj4gaW5kZXggMWE1OTljMjk0YWI4Li4xY2E0ZDIxOTYw
OWYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC1waHl0
ZWMtbWlyYS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL254cC9pbXgvaW14NnFkbC1w
aHl0ZWMtbWlyYS5kdHNpDQo+IEBAIC0xODIsNyArMTgyLDcgQEAgaTJjX3J0YzogcnRjQDY4IHsN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxf
cnRjX2ludD47DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVnID0gPDB4Njg+
Ow0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdC1wYXJlbnQgPSA8
JmdwaW83PjsNCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGludGVycnVwdHMgPSA8
OCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGludGVycnVwdHMgPSA8OCBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+IMKgwqDCoMKgwqDCoMKgwqB9
Ow0KPiDCoH07DQo=
