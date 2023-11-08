Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384047E5301
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 11:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344022AbjKHKFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 05:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHKFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 05:05:17 -0500
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26DC1723;
        Wed,  8 Nov 2023 02:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1699437859;
        bh=JbGswtg42j2mQLtVVxfXX4yg/Wk+ANa6tA5gZ/Vcmy8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=aHUI3PR3YA3gIeSS5JbU3MsRxO+mpvyuLp6yYdBlH02Mee8Q17t7PEz+Pwl1TooAi
         Yt6vCqEYrVBr2nl5/gp+6Q1+lVhspzew6wwa6GNAsTT4gAoVxTlmeYTWxjUGQ5sxB3
         0+oE/ZyViyttc9yF9F7jHpP1gnmUbaMx9TxWmJIhLL62k95IAz33QLKYM4Y9g1Q8aa
         lZUUr+ss36yAzzBZ256ktdvOsym8wfgJKkOf1oBupspoOupw3WeWY38i1N8t1QWqv/
         +CfMag8CVESDvLtFxiSFDYehOYlZqCtWUKCAY7KlJyhMJRD84p2tB/rnR3WM/xTO7B
         L/bnQqJt1pMxA==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Fabio Estevam <festevam@denx.de>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        =?utf-8?B?U8OpYmFzdGllbiBTenltYW5za2k=?= 
        <sebastien.szymanski@armadeus.com>, Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] cpufreq: imx6q: Only disabling 792MHz OPP for i.MX6ULL
 types below 792MHz
Thread-Topic: [PATCH] cpufreq: imx6q: Only disabling 792MHz OPP for i.MX6ULL
 types below 792MHz
Thread-Index: AQHaEZg/SLm81pxRhEivWhTpKu7OhrBvEQeAgAEcF3A=
Date:   Wed, 8 Nov 2023 10:04:03 +0000
Message-ID: <5aa0882abf84401a869ad37f7ee8c889@dh-electronics.com>
References: <20231107163136.63440-1-cniedermaier@dh-electronics.com>
 <188c5e1cddc05f9bd44510e0a4f988df@denx.de>
In-Reply-To: <188c5e1cddc05f9bd44510e0a4f988df@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogRmFiaW8gRXN0ZXZhbQ0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgNywgMjAyMyA2OjQ4
IFBNDQo+IA0KPiBIaSBDaHJpc3RvcGgsDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2guDQo+
IA0KPiBPbiAwNy8xMS8yMDIzIDEzOjMxLCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+
PiBGb3IgYSA5MDBNSHogaS5NWDZVTEwgQ1BVIHRoZSA3OTJNSHogT1BQIGlzIGRpc2FibGVkLiBU
aGVyZSBpcyBubw0KPj4gY29udmluY2luZyByZWFzb24gdG8gZGlzYWJsZSB0aGlzIE9QUC4gSWYg
YSBDUFUgY2FuIHJ1biBhdCA5MDBNSHosDQo+PiBpdCBzaG91bGQgYWxzbyBiZSBhYmxlIHRvIGNv
cGUgd2l0aCA3OTJNSHouIExvb2tpbmcgYXQgdGhlIHZvbHRhZ2UNCj4+IGxldmVsIG9mIDc5Mk1I
eiBpbiBbMV0gKHBhZ2UgMjQsIHRhYmxlIDEwLiAiT3BlcmF0aW5nIFJhbmdlcyIpIHRoZQ0KPj4g
Y3VycmVudCBkZWZpbmVkIE9QUCBpcyBhYm92ZSB0aGUgbWluaW11bS4gU28gdGhlIHZvbHRhZ2Ug
bGV2ZWwNCj4+IHNob3VsZG4ndCBiZSBhIHByb2JsZW0uIEFsdGhvdWdoIGluIFsyXSAocGFnZSAy
NCwgdGFibGUgMTAuDQo+PiAiT3BlcmF0aW5nIFJhbmdlcyIpIDc5Mk1IeiBpc24ndCBtZW50aW9u
ZWQgdGhlcmUgaXNuJ3Qgbm90ZSB0aGF0DQo+PiA3OTJNSHogT1BQIGlzbid0IGFsbG93ZWQuIENo
YW5nZSBpdCB0byBvbmx5IGRpc2FibGUgNzkyTUh6IE9QUCBmb3INCj4gDQo+IEkgZmluZCB0aGlz
IHBhcnQ6DQo+IA0KPiAiNzkyTUh6IGlzbid0IG1lbnRpb25lZCB0aGVyZSBpc24ndCBub3RlIHRo
YXQgNzkyTUh6IE9QUCBpc24ndCBhbGxvd2VkLiINCj4gDQo+IGEgYml0IGNvbmZ1c2luZy4NCj4g
DQo+IE1heWJlOg0KPiANCj4gIkhvd2V2ZXIgaW4gWzJdIChwYWdlIDI0LCB0YWJsZSAxMC4gIk9w
ZXJhdGluZyBSYW5nZXMiKSwgaXQgaXMgbm90DQo+IG1lbnRpb25lZCB0aGF0IDc5Mk1IeiBPUFAg
aXNuJ3QgYWxsb3dlZC4iDQoNCllvdSBhcmUgcmlnaHQsIHlvdXIgc3VnZ2VzdGlvbiBleHByZXNz
ZXMgaXQgbW9yZSBjbGVhcmx5Lg0KSSB3aWxsIGNoYW5nZSBpdCBpbiBWMi4NCg0KPiANCj4gDQo+
PiBbMV0gaHR0cHM6Ly93d3cubnhwLmNvbS9kb2NzL2VuL2RhdGEtc2hlZXQvSU1YNlVMTElFQy5w
ZGYNCj4+IFsyXSBodHRwczovL3d3dy5ueHAuY29tL2RvY3MvZW4vZGF0YS1zaGVldC9JTVg2VUxM
Q0VDLnBkZg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25p
ZWRlcm1haWVyQGRoLWVsZWN0cm9uaWNzLmNvbT4NCj4+IFJldmlld2VkLWJ5OiBNYXJlayBWYXN1
dCA8bWFyZXhAZGVueC5kZT4NCj4gDQo+IEkgdGhpbmsgaXQgaXMgd29ydGggYWRkaW5nIGEgRml4
ZXMgdGFnIHNvIHRoYXQgdGhpcyBmaXggY291bGQgYmUNCj4gYmFja3BvcnRlZA0KPiB0byBzdGFi
bGUga2VybmVscy4NCg0KWW91IG1lYW4gdGhlIGZvbGxvd2luZyBmaXhlcyB0YWcgd2hlbiB0aGUg
Y2hhbmdlIHdhcyBpbnRyb2R1Y2VkPw0KRml4ZXM6IDBhYTlhYmQ0YzIxMiAoImNwdWZyZXE6IGlt
eDZxOiBjaGVjayBzcGVlZCBncmFkZXMgZm9yIGkuTVg2VUxMIikNCkJ1dCBpZiBJJ20gcmlnaHQs
IHRoZW4gaXQgZ29lcyBkb3duIHRvIHZlcnNpb24gNC4xOSBhbmQgbWF5YmUgdGhlDQpjb21taXQg
MTFhM2IwYWMzM2Q5ICgiY3B1ZnJlcTogaW14NnE6IGRvbid0IHdhcm4gZm9yIGRpc2FibGluZyBh
IG5vbi1leGlzdGluZyBmcmVxdWVuY3kiKQ0KaXMgYWxzbyBuZWVkZWQgdG8gZWFzaWx5IGFwcGx5
Lg0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==
