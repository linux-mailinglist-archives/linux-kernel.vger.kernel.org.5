Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE3D75595F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 04:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjGQCGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 22:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGQCGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 22:06:32 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022E6E56;
        Sun, 16 Jul 2023 19:06:29 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DF55924E2E2;
        Mon, 17 Jul 2023 10:06:26 +0800 (CST)
Received: from EXMBX164.cuchost.com (172.16.7.74) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 09:47:59 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX164.cuchost.com
 (172.16.6.74) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 09:47:59 +0800
Received: from EXMBX068.cuchost.com ([fe80::e99c:4abb:32f:d650]) by
 EXMBX068.cuchost.com ([fe80::e99c:4abb:32f:d650%16]) with mapi id
 15.00.1497.044; Mon, 17 Jul 2023 09:47:58 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: RE: [PATCH] crypto: starfive - Add AES skcipher and aead support
Thread-Topic: [PATCH] crypto: starfive - Add AES skcipher and aead support
Thread-Index: AQHZr7n26FgQfZeJP0WRHsOf15OHD6+4eR8AgATG1yA=
Date:   Mon, 17 Jul 2023 01:47:58 +0000
Message-ID: <1cd932eb3234436394bf46cfebc1df39@EXMBX068.cuchost.com>
References: <20230706032737.424378-1-jiajie.ho@starfivetech.com>
 <ZLEK1AYMmj24rIph@gondor.apana.org.au>
In-Reply-To: <ZLEK1AYMmj24rIph@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [161.142.156.125]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBUaGlzIGRvZXNuJ3QgY29tcGlsZToNCj4gDQo+ICAgQ0MgW01dICBkcml2ZXJzL2NyeXB0by9z
dGFyZml2ZS9qaDcxMTAtY3J5cC5vDQo+ICAgQ0MgW01dICBkcml2ZXJzL2NyeXB0by9zdGFyZml2
ZS9qaDcxMTAtaGFzaC5vDQo+ICAgQ0MgW01dICBkcml2ZXJzL2NyeXB0by9zdGFyZml2ZS9qaDcx
MTAtcnNhLm8NCj4gICBDQyBbTV0gIGRyaXZlcnMvY3J5cHRvL3N0YXJmaXZlL2poNzExMC1hZXMu
bw0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi4vZHJpdmVycy9jcnlwdG8vc3RhcmZpdmUvamg3
MTEwLWFlcy5jOjEzOg0KPiAuLi9kcml2ZXJzL2NyeXB0by9zdGFyZml2ZS9qaDcxMTAtY3J5cC5o
OjE4NDo0OTogZXJyb3I6IGZpZWxkIOKAmGFlc19kb25l4oCZIGhhcw0KPiBpbmNvbXBsZXRlIHR5
cGUNCj4gICAxODQgfCAgICAgICAgIHN0cnVjdCB0YXNrbGV0X3N0cnVjdCAgICAgICAgICAgICAg
ICAgICBhZXNfZG9uZTsNCj4gICAgICAgfCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBefn5+fn5+fg0KPiAuLi9kcml2ZXJzL2NyeXB0by9zdGFyZml2ZS9q
aDcxMTAtY3J5cC5oOjE4NTo0OTogZXJyb3I6IGZpZWxkIOKAmGhhc2hfZG9uZeKAmSBoYXMNCj4g
aW5jb21wbGV0ZSB0eXBlDQo+ICAgMTg1IHwgICAgICAgICBzdHJ1Y3QgdGFza2xldF9zdHJ1Y3Qg
ICAgICAgICAgICAgICAgICAgaGFzaF9kb25lOw0KPiAgICAgICB8ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fg0KPiBtYWtlWzZdOiAqKiog
Wy4uL3NjcmlwdHMvTWFrZWZpbGUuYnVpbGQ6MjQzOiBkcml2ZXJzL2NyeXB0by9zdGFyZml2ZS9q
aDcxMTAtDQo+IGFlcy5vXSBFcnJvciAxDQo+IG1ha2VbNl06ICoqKiBXYWl0aW5nIGZvciB1bmZp
bmlzaGVkIGpvYnMuLi4uDQo+IA0KDQpIaSBIZXJiZXJ0LA0KVGhhbmtzIGZvciByZXZpZXdpbmcg
dGhlIHBhdGNoLg0KSSBmb3VuZCBvdXQgdGhhdCBpdCdzIG1pc3NpbmcgaW50ZXJydXB0LmggaW5j
bHVkZS4gDQpJdCBpcyB3ZWlyZCB0aGF0IHRoZSBjb21waWxlIGVycm9yIGRpZCBub3Qgc2hvdyBp
biB0aGUgb3JpZ2luYWwgZHJpdmVyIGFuZCBvbiBteSBsb2NhbCBidWlsZC4NCkknbGwgZml4IHRo
aXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KSmlhIEppZQ0K
