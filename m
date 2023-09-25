Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2617AD0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjIYG54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbjIYG5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:57:54 -0400
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5574BBF
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
        q=dns/txt; i=@phytec.de; t=1695625055; x=1698217055;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ZL6QdmctwPD80BCN0eMjccXFE4Fs0al+u7xCPDt2oL4=;
        b=gusrtXJg+4skAICROmxKT/vqSGavZ9IWFgEa+LQGHxJL2jfktkGaeh1PqgQgj6Ac
        Z5USalA5j8DJrWVZF2WAjJV68C3gklOww3OglPvJUbJwDa36d7WgOdaXktFSD6SH
        fW3kt5Rz69ecEmbMWYt0pkm0et1Dbo40RScE7VcTu/A=;
X-AuditID: ac14000a-6d65670000001e37-ee-65112f5f2379
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id AA.FB.07735.F5F21156; Mon, 25 Sep 2023 08:57:35 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 25 Sep
 2023 08:57:35 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2375.018;
 Mon, 25 Sep 2023 08:57:34 +0200
From:   Yannic Moog <Y.Moog@phytec.de>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: add phyGATE-Tauri i.MX 8M Mini
 Support
Thread-Topic: [PATCH 2/2] arm64: dts: freescale: add phyGATE-Tauri i.MX 8M
 Mini Support
Thread-Index: AQHZ3LZeSU6tVNbtAk6h5VnF4xQ8n7Aqw8UAgABcZgA=
Date:   Mon, 25 Sep 2023 06:57:34 +0000
Message-ID: <07e0755c0204808295ef8f93b5a400849fb87899.camel@phytec.de>
References: <20230901-tauri_upstream_support-v1-0-ed30c6df789b@phytec.de>
         <20230901-tauri_upstream_support-v1-2-ed30c6df789b@phytec.de>
         <20230925012652.GG7231@dragon>
In-Reply-To: <20230925012652.GG7231@dragon>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B176DBA771BE4247A5ED2E9BBCB99D47@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWyRpKBVzdeXzDV4Pl5GYs1e88xWcw/co7V
        4uFVf4tVU3eyWPS9eMhscaj5AJPFpsfXWC26fq1ktri8aw6bReveI+wWf7dvYrF4sUXcovud
        ugOvx85Zd9k9Nq3qZPO4c20Pm8fmJfUe/d0trB4b3+1g8uj/a+DxeZNcAEcUl01Kak5mWWqR
        vl0CV8b7ZRuZC675V8yc9JGlgfGCbxcjJ4eEgInEjW93mboYuTiEBJYwSfydsRjKecAo0bak
        hxnC2cAosaL1PBtIC5uAisTJGZcYQWwRAX2J91v+soAUMQvMYpV49mEBC0hCWCBCoqVlDhNE
        UaTEnj3b2SFsK4nm081gNouAqsTCKTvA6nkF3CSmtM5ng9i2hlFizbX5zCAJTgFtieWtm8GK
        GAVkJTZsOA8WZxYQl9j07DsrxBMCEkv2QMQlBEQlXj7+BxWXlzhxaxrQERxA9ZoS63fpQ7Ra
        SGz9/p8VwlaUmNL9kB3iBkGJkzOfsExgFJ+FZMMshO5ZSLpnIemehaR7ASPrKkah3Mzk7NSi
        zGy9gozKktRkvZTUTYygVCDCwLWDsW+OxyFGJg7GQ4wSHMxKIry/nvGlCvGmJFZWpRblxxeV
        5qQWH2KU5mBREue938OUKCSQnliSmp2aWpBaBJNl4uCUamDcuNn/1WXtwjXMy/oERKdPqVXO
        cag77PjDe6n2g7a/ISa3RHYlSX1Le/gsVMtF//eV22qfjgmcd9ZglJTosF4zSdF9MvPuc6sr
        Vghe2HFhW/GZhOf9IUy7I/9my+tIBRWmnDbTVe2v0HtZpK8Zt1fDWF9wY8bRurh/LXy89Wzq
        rJ8NTfd9slRiKc5INNRiLipOBAC0sCoa8wIAAA==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gU2hhd24sCgpPbiBNb24sIDIwMjMtMDktMjUgYXQgMDk6MjYgKzA4MDAsIFNoYXduIEd1
byB3cm90ZToKPiBPbiBGcmksIFNlcCAwMSwgMjAyMyBhdCAxMToyNjoxN0FNICswMjAwLCBZYW5u
aWMgTW9vZyB3cm90ZToKPiA+IHBoeUdBVEUtVGF1cmkgdXNlcyBhIHBoeUNPUkUtaS5NWDhNTSBT
b00uIEFkZCBkZXZpY2UgdHJlZSBmb3IgdGhlCj4gPiBib2FyZC4KPiA+IAo+ID4gU2lnbmVkLW9m
Zi1ieTogWWFubmljIE1vb2cgPHkubW9vZ0BwaHl0ZWMuZGU+Cj4gPiAtLS0KPiA+IMKgYXJjaC9h
cm02NC9ib290L2R0cy9mcmVlc2NhbGUvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fMKgwqAgMSArCj4gPiDCoC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1tLXBoeWdhdGUtdGF1
cmktbC5kdHPCoCB8IDQ4OAo+ID4gKysrKysrKysrKysrKysrKysrKysrCj4gPiDCoDIgZmlsZXMg
Y2hhbmdlZCwgNDg5IGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlCj4gPiBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL01ha2VmaWxlCj4gPiBpbmRleCBhNzUwYmUxM2FjZTguLjY4ZTVhODc4ZTM1OSAx
MDA2NDQKPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL01ha2VmaWxlCj4g
PiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9NYWtlZmlsZQo+ID4gQEAgLTY2
LDYgKzY2LDcgQEAgZHRiLSQoQ09ORklHX0FSQ0hfTVhDKSArPSBpbXg4bW0tbXg4bWVubG8uZHRi
Cj4gPiDCoGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1tLW5pdHJvZ2VuLXIyLmR0Ygo+
ID4gwqBkdGItJChDT05GSUdfQVJDSF9NWEMpICs9IGlteDhtbS1waGcuZHRiCj4gPiDCoGR0Yi0k
KENPTkZJR19BUkNIX01YQykgKz0gaW14OG1tLXBoeWJvYXJkLXBvbGlzLXJkay5kdGIKPiA+ICtk
dGItJChDT05GSUdfQVJDSF9NWEMpICs9IGlteDhtbS1waHlnYXRlLXRhdXJpLWwuZHRiCj4gPiDC
oGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1tLXRxbWE4bXFtbC1tYmE4bXguZHRiCj4g
PiDCoGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1tLXZhci1zb20tc3ltcGhvbnkuZHRi
Cj4gPiDCoGR0Yi0kKENPTkZJR19BUkNIX01YQykgKz0gaW14OG1tLXZlbmljZS1ndzcxeHgtMHgu
ZHRiCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1t
LXBoeWdhdGUtdGF1cmktCj4gPiBsLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxl
L2lteDhtbS1waHlnYXRlLXRhdXJpLWwuZHRzCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NAo+ID4g
aW5kZXggMDAwMDAwMDAwMDAwLi40NTdiMjNhYTU3ZmQKPiA+IC0tLSAvZGV2L251bGwKPiA+ICsr
KyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtbS1waHlnYXRlLXRhdXJpLWwu
ZHRzCj4gPiBAQCAtMCwwICsxLDQ4OCBAQAo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wCj4gPiArLyoKPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjMgUEhZVEVDIE1lc3N0
ZWNobmlrIEdtYkgKPiA+ICsgKi8KPiA+ICsKPiA+ICsvZHRzLXYxLzsKPiA+ICsKPiA+ICsjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvbGVkcy9jb21tb24uaD4KPiA+ICsjaW5jbHVkZSAiaW14OG1tLXBo
eWNvcmUtc29tLmR0c2kiCj4gPiArCj4gPiArLyB7Cj4gPiArwqDCoMKgwqDCoMKgwqBtb2RlbCA9
ICJQSFlURUMgcGh5R0FURS1UYXVyaS1MLWlNWDhNTSI7Cj4gPiArwqDCoMKgwqDCoMKgwqBjb21w
YXRpYmxlID0gInBoeXRlYyxpbXg4bW0tcGh5Z2F0ZS10YXVyaS1sIiwKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAicGh5dGVjLGlteDhtbS1waHljb3JlLXNvbSIs
ICJmc2wsaW14OG1tIjsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGNob3NlbiB7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3Rkb3V0LXBhdGggPSAmdWFydDM7Cj4gPiArwqDC
oMKgwqDCoMKgwqB9Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgY2FuX29zY180MG06IGNhbi1j
bG9jayB7Cj4gCj4gQ2FuIHdlIG5hbWUgdGhlIGNvZGUgY2xvY2stY2FuPwo+IAo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiZml4ZWQtY2xvY2siOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDAw
MD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY2xvY2stb3V0cHV0LW5hbWVz
ID0gImNhbl9vc2NfNDBtIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAjY2xv
Y2stY2VsbHMgPSA8MD47Cj4gPiArwqDCoMKgwqDCoMKgwqB9Owo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoMKgZ3Bpby1rZXlzIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21w
YXRpYmxlID0gImdwaW8ta2V5cyI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZ3Bpb2tleXM+Owo+ID4gKwo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGtleSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdwaW9zID0gPCZncGlvMSA5IEdQSU9fQUNUSVZFX0xPVz47
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxhYmVs
ID0gIktFWS1BIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgbGludXgsY29kZSA9IDwzMD47Cj4gCj4gQ2FuIHdlIHVzZSB0aGUgY29uc3RhbnQgZGVm
aW5lZCBpbgo+IGluY2x1ZGUvZHQtYmluZGluZ3MvaW5wdXQvbGludXgtZXZlbnQtY29kZXMuaD8K
PiAKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Owo+ID4gK8KgwqDCoMKgwqDC
oMKgfTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoGxlZHMgewo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGNvbXBhdGlibGUgPSAiZ3Bpby1sZWRzIjsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBpbmN0cmwtMCA9IDwmcGluY3RybF9sZWRzPjsKPiA+
ICsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsZWQtMSB7Cj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbG9yID0gPExFRF9DT0xP
Ul9JRF9SRUQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBncGlvcyA9IDwmZ3BpbzUgNSBHUElPX0FDVElWRV9ISUdIPjsKPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGludXgsZGVmYXVsdC10cmlnZ2Vy
ID0gIm5vbmUiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gPiArCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbGVkLTIgewo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb2xvciA9IDxMRURfQ09MT1JfSURf
WUVMTE9XPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgZ3Bpb3MgPSA8JmdwaW80IDMwIEdQSU9fQUNUSVZFX0hJR0g+Owo+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsaW51eCxkZWZhdWx0LXRyaWdnZXIg
PSAibm9uZSI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfTsKPiA+ICvCoMKg
wqDCoMKgwqDCoH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqB1c2RoYzFfcHdyc2VxOiBwd3It
c2VxIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBjb21wYXRpYmxlID0gIm1t
Yy1wd3JzZXEtc2ltcGxlIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwb3N0
LXBvd2VyLW9uLWRlbGF5LW1zID0gPDEwMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcG93ZXItb2ZmLWRlbGF5LXVzID0gPDYwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZXNldC1ncGlvcyA9IDwmZ3BpbzIgNyBHUElPX0FDVElWRV9MT1c+Owo+ID4g
K8KgwqDCoMKgwqDCoMKgfTsKPiA+ICsKPiA+ICvCoMKgwqDCoMKgwqDCoHJlZ191c2JfaHViX3Zi
dXM6IHJlZ3VsYXRvci1odWItb3RnMSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGdwaW8gPSA8JmdwaW8xIDE0IEdQSU9fQUNUSVZFX0hJR0g+Owo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVuYWJsZS1hY3RpdmUtaGlnaDsKPiA+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+ID4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBpbmN0cmwtMCA9IDwmcGluY3RybF91c2Jo
dWJwd3I+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZ3VsYXRvci1uYW1l
ID0gInVzYl9odWJfdmJ1cyI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmVn
dWxhdG9yLW1heC1taWNyb3ZvbHQgPSA8NTAwMDAwMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NTAwMDAwMD47Cj4gPiArwqDC
oMKgwqDCoMKgwqB9Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgcmVnX3VzYl9vdGcxX3ZidXM6
IHJlZ3VsYXRvci11c2Itb3RnMSB7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Y29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoGdwaW8gPSA8JmdwaW8xIDEyIEdQSU9fQUNUSVZFX0hJR0g+Owo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVuYWJsZS1hY3RpdmUtaGlnaDsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBpbmN0cmwtMCA9IDwmcGluY3RybF91c2JvdGcx
cHdyPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3ItbmFtZSA9
ICJ1c2Jfb3RnMV92YnVzIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1
bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqByZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw1MDAwMDAwPjsKPiA+ICvCoMKg
wqDCoMKgwqDCoH07Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZWdfdXNkaGMyX3ZtbWM6IHJl
Z3VsYXRvci11c2RoYzIgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbXBh
dGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBlbmFibGUtYWN0aXZlLWhpZ2g7Cj4gCj4gQ2FuIHdlIG1vdmUgaXQgYWZ0ZXIgJ2dwaW8n
IHByb3BlcnR5Pwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdwaW8gPSA8
JmdwaW8yIDE5IEdQSU9fQUNUSVZFX0hJR0g+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoG9mZi1vbi1kZWxheS11cyA9IDwyMDAwMD47Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfcmVnX3VzZGhjMl92bW1jPjsK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0b3ItbWF4LW1pY3Jvdm9s
dCA9IDwzMzAwMDAwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZWd1bGF0
b3ItbWluLW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqByZWd1bGF0b3ItbmFtZSA9ICJWU0RfM1YzIjsKPiA+ICvCoMKgwqDCoMKgwqDCoH07
Cj4gPiArfTsKPiA+ICsKPiA+ICsmZWNzcGkxIHsKPiA+ICvCoMKgwqDCoMKgwqDCoGNzLWdwaW9z
ID0gPCZncGlvNSA5IEdQSU9fQUNUSVZFX0xPVz4sCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCA8JmdwaW81IDEzIEdQSU9fQUNUSVZFX0xPVz4sCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA8JmdwaW81IDIgR1BJT19BQ1RJVkVfTE9XPjsKPiA+
ICvCoMKgwqDCoMKgwqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7Cj4gPiArwqDCoMKgwqDC
oMKgwqBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZWNzcGkxICZwaW5jdHJsX2Vjc3BpMV9jcz47Cj4g
PiArwqDCoMKgwqDCoMKgwqAjYWRkcmVzcy1jZWxscyA9IDwxPjsKPiA+ICvCoMKgwqDCoMKgwqDC
oCNzaXplLWNlbGxzID0gPDA+Owo+ID4gK8KgwqDCoMKgwqDCoMKgc3RhdHVzID0gIm9rYXkiOwo+
ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgLyogQ0FOIE1DUDI1MVhGRCAqLwo+ID4gK8KgwqDCoMKg
wqDCoMKgY2FuMDogY2FuQDAgewo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNv
bXBhdGlibGUgPSAibWljcm9jaGlwLG1jcDI1MXhmZCI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY2xvY2tzID0gPCZjYW5fb3NjXzQwbT47Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0cyA9IDw4IElSUV9UWVBFX0xFVkVMX0xPVz47Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaW50ZXJydXB0LXBhcmVudCA9IDwmZ3BpbzE+
Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHBpbmN0cmwtbmFtZXMgPSAiZGVm
YXVsdCI7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcGluY3RybC0wID0gPCZw
aW5jdHJsX2Nhbl9pbnQ+Owo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlZyA9
IDwwPjsKPiAKPiBXZSB1c3VhbGx5IHB1dCAncmVnJyByaWdodCBhZnRlciAnY29tcGF0aWJsZScu
CgpUaGFua3MgZm9yIHBvaW50aW5nIHRoZXNlIHRoaW5ncyBvdXQsIHdpbGwgc2VuZCBhbiB1cGRh
dGVkIHZlcnNpb24uCgpZYW5uaWMKCj4gCj4gU2hhd24KCltzbmlwXQoK
