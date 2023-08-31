Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20EC78F55B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbjHaWXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbjHaWXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:23:06 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1CFB5
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:23:03 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id D61902C018A;
        Fri,  1 Sep 2023 10:22:59 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1693520579;
        bh=/Dx9lwBhy7aLn3yNxBpIYSI7vTIkWfYBZyHu+D8I5M8=;
        h=From:To:Subject:Date:From;
        b=EnxK2b6UIet75kObHtdvsm9EvqA8L+pXEwFeGoZoEaWXKWpD9S50RQzd2OYSvdmP0
         IEqHuuW2VW5aMwHiWSJbgIBtb9lfqQ2HNUvFWxG07f0v4JOATbrY66tqt1JycMhWv4
         qYig5l8noFlHiXHag3mxaxBOlaMt/UuvhArPwAlMxZHhzqxnysj+Cmtgd4aCSj+COm
         LW0pK6EcVtq8NTm4DImx/soEITqkSJct58QtOC6LGDh2NLeKNTCnIejhDa1azkoq74
         o0vqM0qGq60ZoiOGFngLsh/gXYKGJc5phx6VoBtaQ1HYbfjh+wUNw+Bur+yECGqP3d
         JcJId7SpT/0vg==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B64f112c30001>; Fri, 01 Sep 2023 10:22:59 +1200
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Fri, 1 Sep 2023 10:22:59 +1200
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.037; Fri, 1 Sep 2023 10:22:59 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>
Subject: Build failures for specific .dtb file on v6.5
Thread-Topic: Build failures for specific .dtb file on v6.5
Thread-Index: AQHZ3FmyiwelnZWiQk+WOldARXNLsg==
Date:   Thu, 31 Aug 2023 22:22:59 +0000
Message-ID: <d76d5ea3-6e6b-4899-b125-1166d86ff359@alliedtelesis.co.nz>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.33.22.30]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D57420C9C24981468E7738D0878046CB@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=fYfTNHYF c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=zNV7Rl7Rt7sA:10 a=W0Rc6id6NaKoFi5Yx2MA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkluIGVhcmxpZXIga2VybmVsIHZlcnNpb25zIChqdXN0IHJlY29uZmlybWVkIG9uIHY2
LjQpIEkgY2FuIGRvDQoNCiDCoCBtYWtlIEFSQ0g9YXJtIE89YnVpbGQgbXVsdGlfdjdfZGVmY29u
ZmlnDQogwqAgbWFrZSBBUkNIPWFybSBPPWJ1aWxkIGFybWFkYS14cC1kYi1keGJjMi5kdGINCg0K
YW5kIHRoYXQgb25lIHNwZWNpZmljIC5kdGIgZmlsZSB3aWxsIGJlIGdlbmVyYXRlZC4NCg0KV2l0
aCB2Ni41IChhbmQgbWFzdGVyLCBjdXJyZW50bHkgODdkZmQ4NWMzODkyKcKgIEkgZ2V0IHRoZSBm
b2xsb3dpbmcgZXJyb3INCg0KIMKgIG1ha2UgQVJDSD1hcm0gTz1idWlsZCBtdWx0aV92N19kZWZj
b25maWcNCiDCoCBtYWtlIEFSQ0g9YXJtIE89YnVpbGQgYXJtYWRhLXhwLWRiLWR4YmMyLmR0Yg0K
IMKgIC4uLg0KIMKgIG1ha2VbM106ICoqKiBObyBydWxlIHRvIG1ha2UgdGFyZ2V0IA0KJ2FyY2gv
YXJtL2Jvb3QvZHRzL2FybWFkYS14cC1kYi1keGJjMi5kdGInLsKgIFN0b3AuDQogwqAgbWFrZVsy
XTogKioqIFtzcmMvbGludXgvTWFrZWZpbGU6MTQ2OTogYXJtYWRhLXhwLWRiLWR4YmMyLmR0Yl0g
RXJyb3IgMg0KIMKgIG1ha2VbMV06ICoqKiBbc3JjL2xpbnV4L01ha2VmaWxlOjIzNDogX19zdWIt
bWFrZV0gRXJyb3IgMg0KIMKgIG1ha2VbMV06IExlYXZpbmcgZGlyZWN0b3J5ICdzcmMvbGludXgv
YnVpbGQnDQogwqAgbWFrZTogKioqIFtNYWtlZmlsZToyMzQ6IF9fc3ViLW1ha2VdIEVycm9yIDIN
Cg0KSSB3YXNuJ3QgZW50aXJlbHkgc3VyZSB3aGljaCBtYWlsaW5nIGxpc3QgdG8gZGlyZWN0IHRo
aXMgYXQgc28gSSd2ZSBjYXN0IA0KdGhlIG5ldCBmYWlybHkgd2lkZS4gSSdsbCB0cnkgdG8gc2V0
dXAgYW4gYXV0b21hdGVkIGJpc2VjdCBhbmQgcmVwb3J0IA0KYmFjayBpZiBJIG5hcnJvdyB0aGUg
cHJvYmxlbSBkb3duLg0KDQpUaGFua3MsDQpDaHJpcw0K
