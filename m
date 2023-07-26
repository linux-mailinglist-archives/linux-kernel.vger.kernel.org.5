Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275B1762AEE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjGZFno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjGZFnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:43:42 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49A5DA
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1690350218; x=1692942218;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vGEqLGv3NfFJhkyVWckVHsutEntaAotP2VPMUxzgwO8=;
        b=dHRCXNzFDEfz+T/+kTLZgzspp2IDnRrihMNmW1/wS4Ikq8pyO0ALMqrc73jSYFu2
        fDuBSb6nf5KOIZ8bLkKvzIvEKfopUVcldWmtEZ2tspIYGoGVkC4lwD7lEO/R5X+9
        9dHG0XDuMkoWaYEOCPpfTne3TYvpQj6jxnygHKWVGg4=;
X-AuditID: ac14000a-917fe70000007ecb-60-64c0b2897a6e
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 25.53.32459.982B0C46; Wed, 26 Jul 2023 07:43:37 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 26 Jul
 2023 07:43:37 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Wed, 26 Jul 2023 07:43:37 +0200
From:   Yannic Moog <Y.Moog@phytec.de>
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm-phycore: drop uncorrect vselect-en
Thread-Topic: [PATCH] arm64: dts: imx8mm-phycore: drop uncorrect vselect-en
Thread-Index: AQHZvwQlzTgmX+gCsEuqehe28iDArq/LaK+A
Date:   Wed, 26 Jul 2023 05:43:37 +0000
Message-ID: <3e2ae299b0c3c25bcdd8c592af2ba373febbb70a.camel@phytec.de>
References: <20230725142653.157510-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725142653.157510-1-krzysztof.kozlowski@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <849468F06EF0A84CAE5D16B00C39A446@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsWyRpKBR7dz04EUg7bjVhZr9p5jsph/5Byr
        xcOr/harpu5kseh78ZDZYu/rrewWmx5fY7Xo+rWS2eLyrjlsFq17j7Bb/N2+icXixRZxBx6P
        nbPusntsWtXJ5nHn2h42j81L6j02vtvB5NH/18Dj8ya5APYoLpuU1JzMstQifbsErow9D1cy
        Fqzhr7jUu5KlgfEHXxcjJ4eEgInEtnvXmLoYuTiEBJYwSZx8fxnKecAocejvA3YIZyOjxPdv
        a9lBWtgEVCROzrjECJIQEVjBKtFy4g4TSEJYwEviUPMyZhBbRMBbYt+ZuywQtpFEy/VjYM0s
        AqoSJ36sBLN5BdwkFp5cyQZiCwm4SBw68gRsDqeAq8T6vy/AbEYBWYkNG86DzWQWEJfY9Ow7
        K8TdAhJL9kDEJQREJV4+/gcVl5c4cWsaUC8HUL2mxPpd+hCtFhKXZ86FGqMoMaX7IdQJghIn
        Zz5hmcAoNgvJhlkI3bOQdM9C0j0LSfcCRtZVjEK5mcnZqUWZ2XoFGZUlqcl6KambGEHxLcLA
        tYOxb47HIUYmDsZDjBIczEoivIYx+1KEeFMSK6tSi/Lji0pzUosPMUpzsCiJ897vYUoUEkhP
        LEnNTk0tSC2CyTJxcEo1MG4LtWrJFCky3DbHo3GC/+Pt2w8yFPi+69ogMi/mfejhBwJR3/Te
        qM7dvvUW/9Or5UennHPVenk1+tVvoyNt5+tlHZMPTGOw13ro9Vnj3NP6lUlZSZqC11U/fn65
        WnzB3wnZRiEeXXFpbt8D9S35fb0rnFdydk8r2c7+oWiiQ9/ymWrLspanTVBiKc5INNRiLipO
        BABxiu2r3QIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTI1IGF0IDE2OjI2ICswMjAwLCBLcnp5c3p0b2YgS296bG93c2tpIHdy
b3RlOgo+IFRoZXJlIGlzIG5vICJ2c2VsZWN0LWVuIiBwcm9wZXJ0eSwgbmVpdGhlciBpbiB0aGUg
YmluZGluZ3Mgbm9yIGluIHRoZQo+IExpbnV4IGRyaXZlcjoKPiAKPiDCoCBpbXg4bW0tcGh5Ym9h
cmQtcG9saXMtcmRrLmR0YjogcG1pY0A4OiByZWd1bGF0b3JzOmxkbzI6IFVuZXZhbHVhdGVkCj4g
cHJvcGVydGllcyBhcmUgbm90IGFsbG93ZWQgKCd2c2VsZWN0LWVuJyB3YXMgdW5leHBlY3RlZCkK
PiAKPiBTaWduZWQtb2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93
c2tpQGxpbmFyby5vcmc+CgpSZXZpZXdlZC1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMu
ZGU+Cgo+IC0tLQo+IMKgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWNv
cmUtc29tLmR0c2kgfCAxIC0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHljb3Jl
LXNvbS5kdHNpCj4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bW0tcGh5Y29y
ZS1zb20uZHRzaQo+IGluZGV4IDQwNGY3ZGUwYjcyMi4uNjA2OTY3ODI0NGYzIDEwMDY0NAo+IC0t
LSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHljb3JlLXNvbS5kdHNp
Cj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWNvcmUtc29t
LmR0c2kKPiBAQCAtMTUxLDcgKzE1MSw2IEBAIHJlZ19udmNjX3NkMjogbGRvMiB7Cj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDMzMDAwMDA+Owo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3It
bWluLW1pY3Jvdm9sdCA9IDwxODAwMDAwPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVndWxhdG9yLW5hbWUgPSAiTlZD
Q19TRDIgKExETzIpIjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB2c2VsZWN0LWVuOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRv
ci1zdGF0ZS1tZW0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVndWxhdG9yLW9mZi1pbi1z
dXNwZW5kOwoK
