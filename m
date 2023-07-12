Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7443F7511DE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjGLUgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbjGLUgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:36:48 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC891FE9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:36:45 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C11E22C04D4;
        Thu, 13 Jul 2023 08:36:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1689194202;
        bh=AS60128qFleQjW20PaEmveAPE8fT7xoNhkA4y1k5GD8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=g7sJ/Ixhu5obcG2DhuSCchb/rPatvPchMlhiPjgVIAMKzlagbJdUhGk4eVX5BcCH5
         kW2t8EKenPRBHv8vDVL7v7Qp+v4QxV8nikefRKNhP4YZr4wnEDYSjj5sMcg+hpjxER
         Bxe5uyfkA62j0wE+Gd5BY15yzT1S2f/FA/Kje8S/VT9Sd1IjY3PasqQ787kUiB5Zdr
         SeFtG4ro+bsMYL/KJolwOKbXHO9B6dhypIF6QH3MuPfnb0fIbzSTKtZDuIax7OVmZL
         gBv8IyprGXb9tagX0aVKa9NQLXeh7kSF3nzuV+k4HWU2H59fK+waVm5+gchHNEDzbi
         WTyHIhTRgVncQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64af0eda0001>; Thu, 13 Jul 2023 08:36:42 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 08:36:42 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Thu, 13 Jul 2023 08:36:42 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.030; Thu, 13 Jul 2023 08:36:42 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: mtd: Add AC5 specific binding
Thread-Topic: [PATCH v3 1/3] dt-bindings: mtd: Add AC5 specific binding
Thread-Index: AQHZrWGOJlokQC0VCkWPPyueyMwEwa+1Vd8AgACHVIA=
Date:   Wed, 12 Jul 2023 20:36:42 +0000
Message-ID: <4b780ed6-4c77-f881-f332-fd728474cb4c@alliedtelesis.co.nz>
References: <20230703035044.2063303-1-chris.packham@alliedtelesis.co.nz>
 <20230703035044.2063303-2-chris.packham@alliedtelesis.co.nz>
 <20230712143220.06a3d6eb@xps-13>
In-Reply-To: <20230712143220.06a3d6eb@xps-13>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA2E1168B846DA419BD7AF02A09A481F@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=OKtZIhSB c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=ws7JD89P4LkA:10 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=b3QAFjprZ98drIJmpsIA:9 a=QEXdDO2ut3YA:10 a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlxdWVsLA0KDQpPbiAxMy8wNy8yMyAwMDozMiwgTWlxdWVsIFJheW5hbCB3cm90ZToNCj4g
SGkgQ2hyaXMsDQo+DQo+IGNocmlzLnBhY2toYW1AYWxsaWVkdGVsZXNpcy5jby5ueiB3cm90ZSBv
biBNb24sICAzIEp1bCAyMDIzIDE1OjUwOjQyDQo+ICsxMjAwOg0KPg0KPj4gQWRkIGJpbmRpbmcg
Zm9yIEFDNSBTb0MuIFRoaXMgU29DIG9ubHkgc3VwcG9ydHMgTkFORCBTRFIgdGltaW5ncyB1cCB0
bw0KPj4gbW9kZSAzIHNvIGEgc3BlY2lmaWMgY29tcGF0aWJsZSB2YWx1ZSBpcyBuZWVkZWQuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXMgUGFja2hhbSA8Y2hyaXMucGFja2hhbUBhbGxpZWR0
ZWxlc2lzLmNvLm56Pg0KPj4gQWNrZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1p
Y3JvY2hpcC5jb20+DQo+IEkgbmVlZCBEVC1iaW5kaW5nIG1haW50YWluZXIncyBhY2sgdG8gdGFr
ZSB0aGlzIHBhdGNoLCBidXQgdGhpcyBjb21taXQNCj4gZGlkIG5vdCByZWNlaXZlIGZlZWRiYWNr
IChwb3NpdGl2ZSBvZiBuZWdhdGl2ZSkgZnJvbSB0aGVtIGFuZCBpcyBubw0KPiBsb25nZXIgaW4g
dGhlaXIgcGF0Y2h3b3JrLiBDYW4geW91IHBsZWFzZSByZXNlbmQgdGhlIHNlcmllcz8NCg0KQ29u
b3IncyBhY2sgd2FzIHByb3ZpZGVkIG9uDQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4
LW10ZC8yMDIzMDYyNi1pbW11bml0eS1sYWdnZWQtZWFhZTAxODJhZDBjQHNwdWQvDQoNCklzIHRo
aXMgc3VmZmljaWVudD8gSSdtIGhhcHB5IHRvIHJlc2VuZCBpZiBuZWVkZWQuDQoNCj4NCj4gVGhl
IG90aGVyIHBhdGNoZXMgTEdUTS4NCj4NCj4NCj4+IC0tLQ0KPj4NCj4+IE5vdGVzOg0KPj4gICAg
ICBDaGFuZ2VzIGluIHYzOg0KPj4gICAgICAtIENvbGxlY3QgYWNrIGZyb20gQ29ub3INCj4+ICAg
ICAgQ2hhbmdlcyBpbiB2MjoNCj4+ICAgICAgLSBLZWVwIGNvbXBhdGlibGVzIGluIGFscGhhYmV0
aWNhbCBvcmRlcg0KPj4gICAgICAtIEV4cGxhaW4gQUM1IGxpbWl0YXRpb25zIGluIGNvbW1pdCBt
ZXNzYWdlDQo+Pg0KPj4gICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tdGQvbWFydmVsbCxuYW5k
LWNvbnRyb2xsZXIueWFtbCAgICAgICAgIHwgMSArDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbXRkL21hcnZlbGwsbmFuZC1jb250cm9sbGVyLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZlbGwsbmFuZC1jb250cm9sbGVyLnlhbWwNCj4+
IGluZGV4IGExMDcyOWJiMTg0MC4uMWVjZWE4NDhlOGI5IDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL210ZC9tYXJ2ZWxsLG5hbmQtY29udHJvbGxlci55
YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbXRkL21hcnZl
bGwsbmFuZC1jb250cm9sbGVyLnlhbWwNCj4+IEBAIC0xNiw2ICsxNiw3IEBAIHByb3BlcnRpZXM6
DQo+PiAgICAgICAgICAgICAtIGNvbnN0OiBtYXJ2ZWxsLGFybWFkYS04ay1uYW5kLWNvbnRyb2xs
ZXINCj4+ICAgICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGwsYXJtYWRhMzcwLW5hbmQtY29udHJv
bGxlcg0KPj4gICAgICAgICAtIGVudW06DQo+PiArICAgICAgICAgIC0gbWFydmVsbCxhYzUtbmFu
ZC1jb250cm9sbGVyDQo+PiAgICAgICAgICAgICAtIG1hcnZlbGwsYXJtYWRhMzcwLW5hbmQtY29u
dHJvbGxlcg0KPj4gICAgICAgICAgICAgLSBtYXJ2ZWxsLHB4YTN4eC1uYW5kLWNvbnRyb2xsZXIN
Cj4+ICAgICAgICAgLSBkZXNjcmlwdGlvbjogbGVnYWN5IGJpbmRpbmdzDQo+DQo+IFRoYW5rcywN
Cj4gTWlxdcOobA==
