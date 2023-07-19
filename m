Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2E975949B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGSLuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjGSLuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:50:08 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBDBD3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1689767399; x=1692359399;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Fij/JXu2NjQtsDkiP2TRLF2MphfmDiW02ZxTf94lkOY=;
        b=NHtJCdkQIXGlsxzvspt1X87UIR32RTX3VBcbQ1H+uXCtfTqvXj0IFGvkE+A6Hwjj
        7gP19nqQG+rErl2x5U/72LPu3G8jTVOZQI+JGyoIPlyOYjy4AIO+hagoYDdpDQwb
        h1fOjdg6jK9CfDPjqd/gnclIPYvQFnfoVMT7yZpPdts=;
X-AuditID: ac14000a-917fe70000007ecb-23-64b7cde71617
Received: from Diagnostix.phytec.de (Diagnostix.phytec.de [172.25.0.14])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 79.D8.32459.7EDC7B46; Wed, 19 Jul 2023 13:49:59 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Wed, 19 Jul
 2023 13:49:59 +0200
Received: from Berlix.phytec.de ([fe80::61cc:ebf0:7375:8768]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Wed, 19 Jul 2023 13:50:17 +0200
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
Subject: Re: [PATCH v2 2/3] ARM: dts: imx6: pfla02: Rely on PMIC reboot/reset
 handler
Thread-Topic: [PATCH v2 2/3] ARM: dts: imx6: pfla02: Rely on PMIC reboot/reset
 handler
Thread-Index: AQHZujZYhCsXxjcYtUSTQEeWR8I4da/A2FOA
Date:   Wed, 19 Jul 2023 11:50:17 +0000
Message-ID: <c75779173ff83cbf0b5bad7fcb946abfa1346a94.camel@phytec.de>
References: <20230719114328.2239818-1-andrej.picej@norik.com>
         <20230719114328.2239818-2-andrej.picej@norik.com>
In-Reply-To: <20230719114328.2239818-2-andrej.picej@norik.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2891ED0FDA0627468E63180913204163@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWyRpKBT/f52e0pBhfOaVhM3ctosWbvOSaL
        +UfOsVo8vOpvsWrqThaLvhcPmS02Pb7GatH1ayWzxeVdc9gsWvceYbf4u30Ti8WLLeIOPB47
        Z91l99i0qpPN4861PWwem5fUe3z/uoHVY+O7HUwe/X8NPD5vkgvgiOKySUnNySxLLdK3S+DK
        WLV3K3PBJ/6KxZub2BoY9/B3MXJySAiYSOxatoWli5GLQ0hgHZPE2k3roJwnjBIXdqxhgnA2
        MkrMPfebCaSFTcBF4nPbNzaQhIjAcWaJtV+mgLUwC5xikjjz+gEzSJWwQLjEtav/gBIcQFUR
        EkdafUDCIgJGEs/nr2YBsVkEVCUazk8Bs3kF3CRezPjICmILCRRJ3P77nxHE5hSwk3iz7SLY
        SEYBWYnOhndgRzALiEtsevadFeIHAYkle84zQ9iiEi8f/4OKy0ucuDWNCeQEZgFNifW79CFa
        LSQmzPnACmErSkzpfsgOcYKgxMmZT1gmMIrPQrJhFkL3LCTds5B0z0LSvYCRdRWjUG5mcnZq
        UWa2XkFGZUlqsl5K6iZGUPyLMHDtYOyb43GIkYmD8RCjBAezkgjvo8vbUoR4UxIrq1KL8uOL
        SnNSiw8xSnOwKInz3u9hShQSSE8sSc1OTS1ILYLJMnFwSjUwCiQrsSTVz2ud8MD59PfMD3vf
        zg1es6LmbImhyZIHH3T9griYNp4IttKSE1t87qXNv2wJvvNyu4QUlJvXxe9+legYWnPG6FNK
        2YQUkW/PztSZPhJclLokTy4138iz/bul7PnvWllGi+5vroyJfH7rzsGV2rqsJ47Lzox8m/lI
        xTpDfmZC7u8cJZbijERDLeai4kQA3BVAgO0CAAA=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5kcmVqLA0KDQpPbiBXZWQsIDIwMjMtMDctMTkgYXQgMTM6NDMgKzAyMDAsIEFuZHJlaiBQ
aWNlaiB3cm90ZToNCj4gRHVlIHRvIHRoZSBtaXNzaW5nIHNpZ25hbCBjb25uZWN0aW9uIGJldHdl
ZW4gaS5NWDYgV0RPR19CIHBpbiBhbmQgdGhlDQo+IFBNSUNzIGV4dGVybmFsIHJlc2V0LCB0aGUg
aW50ZXJuYWwgaS5NWDYgd2F0Y2hkb2cgaXMgbm90IGFibGUgdG8gcmVzZXQNCj4gdGhlIHBoeUZM
RVggU29NIHByb3Blcmx5LiBUaHVzIGRpc2FibGUgdGhlIGludGVybmFsIGkuTVg2IHdhdGNoZG9n
IHRvDQo+IHByZXZlbnQgdW5leHBlY3RlZCBQTUlDIHNldHRpbmdzIGFmdGVyIHJlc2V0Lg0KPiAN
Cj4gTk9URTogVGhpcyBwYXRjaCBzaG91bGQgbm90IGJlIGJhY2twb3J0ZWQgYXMgaXQgbWlnaHQg
YnJlYWsgZXhpc3RpbmcNCj4gdXNlcyBhbmQgZml4ZXMgaW4gYm9vdGxvYWRlcnMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBBbmRyZWogUGljZWogPGFuZHJlai5waWNlakBub3Jpay5jb20+DQoNClJl
dmlld2VkLWJ5OiBTdGVmYW4gUmllZG3DvGxsZXIgPHMucmllZG11ZWxsZXJAcGh5dGVjLmRlPg0K
DQo+IC0tLQ0KPiBDaGFuZ2VzIGluIHYyOg0KPiDCoC0gdGhpcyBpcyBhIHN1YnN0aXR1dGUgcGF0
Y2ggd2l0aCBhIHByb3BlciBmaXguDQo+IC0tLQ0KPiDCoGFyY2gvYXJtL2Jvb3QvZHRzL254cC9p
bXgvaW14NnFkbC1waHl0ZWMtcGZsYTAyLmR0c2kgfCA4ICsrKysrKysrDQo+IMKgMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3Qv
ZHRzL254cC9pbXgvaW14NnFkbC1waHl0ZWMtcGZsYTAyLmR0c2kNCj4gYi9hcmNoL2FybS9ib290
L2R0cy9ueHAvaW14L2lteDZxZGwtcGh5dGVjLXBmbGEwMi5kdHNpDQo+IGluZGV4IDgwYWRiMmEw
MmNjOS4uNjVmZDdiNGE2ZjI3IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9ueHAv
aW14L2lteDZxZGwtcGh5dGVjLXBmbGEwMi5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L254cC9pbXgvaW14NnFkbC1waHl0ZWMtcGZsYTAyLmR0c2kNCj4gQEAgLTQ2NCwzICs0NjQsMTEg
QEAgJnVzZGhjMyB7DQo+IMKgwqDCoMKgwqDCoMKgwqB2bW1jLXN1cHBseSA9IDwmdmRkX3NkMF9y
ZWc+Ow0KPiDCoMKgwqDCoMKgwqDCoMKgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gwqB9Ow0KPiAr
DQo+ICsmd2RvZzEgew0KPiArwqDCoMKgwqDCoMKgwqAvKg0KPiArwqDCoMKgwqDCoMKgwqAgKiBS
ZWx5IG9uIFBNSUMgcmVib290IGhhbmRsZXIuIEludGVybmFsIGkuTVg2IHdhdGNoZG9nLCB0aGF0
IGlzDQo+IGFsc28NCj4gK8KgwqDCoMKgwqDCoMKgICogdXNlZCBmb3IgcmVib290LCBkb2VzIG5v
dCByZXNldCBhbGwgZXh0ZXJuYWwgUE1JQyB2b2x0YWdlcyBvbg0KPiByZXNldC4NCj4gK8KgwqDC
oMKgwqDCoMKgICovDQo+ICvCoMKgwqDCoMKgwqDCoHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICt9
Ow0K
