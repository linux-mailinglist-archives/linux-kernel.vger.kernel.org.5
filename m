Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F6678F582
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347712AbjHaWeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjHaWef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:34:35 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD43E66
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:34:31 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E65B32C04CD;
        Fri,  1 Sep 2023 10:34:29 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1693521269;
        bh=n5gC2YhQbZVcpmSjtd8oohduINxqMRYtPQdYThrvdbo=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=zkMo+e17Y5XqoFdnvV8w5v3qcboaXD4KelhgPCaDP6q3IrWPDGntc5hPhfv/t/Xd8
         agRaz20oZBgq3xuuhZGq0G/NqHVV9P9RHMikV4vwDIzU6lzk7nWc39uhYO9TIYJPVh
         Ssr6Xyt/ZENjiwu9Ca8X7rD7etRpnE8nRR3peAFAHj4aUWSUV8kCI+kT4KkKge0u5t
         1dQ8aeBXU40BeRtriQyOumUqhC2a9ZB805wHX8lYkyIUkG6pwtvaDwChB86YYczIkL
         RvIQv8qehXaxbyzpHPAarKWMYGh/vYPNDHjv9rKMlUbh5HjkOWWTQsEBUoU4HBG1qf
         U2VNRn0RfizrQ==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64f115750001>; Fri, 01 Sep 2023 10:34:29 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 10:34:29 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.48; Fri, 1 Sep 2023 10:34:29 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.037; Fri, 1 Sep 2023 10:34:29 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Re: Build failures for specific .dtb file on v6.5
Thread-Topic: Build failures for specific .dtb file on v6.5
Thread-Index: AQHZ3FmyiwelnZWiQk+WOldARXNLsrAENL2A
Date:   Thu, 31 Aug 2023 22:34:29 +0000
Message-ID: <b3ca549a-71a8-497c-8350-ac5129737ff5@alliedtelesis.co.nz>
References: <d76d5ea3-6e6b-4899-b125-1166d86ff359@alliedtelesis.co.nz>
In-Reply-To: <d76d5ea3-6e6b-4899-b125-1166d86ff359@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AE93DD56F7123D4C90C75DB5F5340720@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fYfTNHYF c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=OgsSWGNpJA0bUecrG54A:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxLzA5LzIzIDEwOjIyLCBDaHJpcyBQYWNraGFtIHdyb3RlOg0KPiBIaSwNCj4NCj4gSW4g
ZWFybGllciBrZXJuZWwgdmVyc2lvbnMgKGp1c3QgcmVjb25maXJtZWQgb24gdjYuNCkgSSBjYW4g
ZG8NCj4NCj4gwqAgbWFrZSBBUkNIPWFybSBPPWJ1aWxkIG11bHRpX3Y3X2RlZmNvbmZpZw0KPiDC
oCBtYWtlIEFSQ0g9YXJtIE89YnVpbGQgYXJtYWRhLXhwLWRiLWR4YmMyLmR0Yg0KPg0KPiBhbmQg
dGhhdCBvbmUgc3BlY2lmaWMgLmR0YiBmaWxlIHdpbGwgYmUgZ2VuZXJhdGVkLg0KPg0KPiBXaXRo
IHY2LjUgKGFuZCBtYXN0ZXIsIGN1cnJlbnRseSA4N2RmZDg1YzM4OTIpwqAgSSBnZXQgdGhlIGZv
bGxvd2luZyBlcnJvcg0KPg0KPiDCoCBtYWtlIEFSQ0g9YXJtIE89YnVpbGQgbXVsdGlfdjdfZGVm
Y29uZmlnDQo+IMKgIG1ha2UgQVJDSD1hcm0gTz1idWlsZCBhcm1hZGEteHAtZGItZHhiYzIuZHRi
DQo+IMKgIC4uLg0KPiDCoCBtYWtlWzNdOiAqKiogTm8gcnVsZSB0byBtYWtlIHRhcmdldCANCj4g
J2FyY2gvYXJtL2Jvb3QvZHRzL2FybWFkYS14cC1kYi1keGJjMi5kdGInLsKgIFN0b3AuDQo+IMKg
IG1ha2VbMl06ICoqKiBbc3JjL2xpbnV4L01ha2VmaWxlOjE0Njk6IGFybWFkYS14cC1kYi1keGJj
Mi5kdGJdIEVycm9yIDINCj4gwqAgbWFrZVsxXTogKioqIFtzcmMvbGludXgvTWFrZWZpbGU6MjM0
OiBfX3N1Yi1tYWtlXSBFcnJvciAyDQo+IMKgIG1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICdz
cmMvbGludXgvYnVpbGQnDQo+IMKgIG1ha2U6ICoqKiBbTWFrZWZpbGU6MjM0OiBfX3N1Yi1tYWtl
XSBFcnJvciAyDQo+DQo+IEkgd2Fzbid0IGVudGlyZWx5IHN1cmUgd2hpY2ggbWFpbGluZyBsaXN0
IHRvIGRpcmVjdCB0aGlzIGF0IHNvIEkndmUgDQo+IGNhc3QgdGhlIG5ldCBmYWlybHkgd2lkZS4g
SSdsbCB0cnkgdG8gc2V0dXAgYW4gYXV0b21hdGVkIGJpc2VjdCBhbmQgDQo+IHJlcG9ydCBiYWNr
IGlmIEkgbmFycm93IHRoZSBwcm9ibGVtIGRvd24uDQoNCkJpc2VjdCBwb2ludHMgdG8gNzI0YmE2
NzUxNTMyICgiQVJNOiBkdHM6IE1vdmUgLmR0cyBmaWxlcyB0byB2ZW5kb3IgDQpzdWItZGlyZWN0
b3JpZXMiKSB3aGljaCBnaXZlbiB0aGUgc3ViamVjdCBtYWtlcyBzZW5zZS4gSSdsbCBhZGp1c3Qg
b3VyIA0KYnVpbGQgcmVjaXBlcyB0byB1c2UgdGhlIHZlbmRvciBwcmVmaXguIFNvcnJ5IGZvciB0
aGUgbm9pc2UuDQoNCg==
