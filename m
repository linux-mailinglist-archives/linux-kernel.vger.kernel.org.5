Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48893756D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGQTUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGQTUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:20:15 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F39EED;
        Mon, 17 Jul 2023 12:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689621612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VH54V72aOY3ogSKUOINjMnAMtLyl5t2LpD7MwgpBD1k=;
        b=yP2aG/l/BcAOIH9TVYi+sSms/ywPuGo+vB9qPeY/YWR/dpOVAMFasz5X3Lk79VnXxkuZJA
        jahCOB2APvNis4xyyvFFGg6gWEuB8dYtA/S3NJHahOWyTmCy4lagb+zsg1mbE5CtfXHQgi
        RXhFo+EX+9xJaQBIh/7VM7OitWq3rUA=
Message-ID: <1f77bcc8ec861dc2abb9defb062ed9178d3d292e.camel@crapouillou.net>
Subject: Re: [PATCH v2 02/10] pinctrl: baytrail: Make use of pm_ptr()
From:   Paul Cercueil <paul@crapouillou.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Date:   Mon, 17 Jul 2023 21:20:09 +0200
In-Reply-To: <20230717172821.62827-3-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-3-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSwKCkxlIGx1bmRpIDE3IGp1aWxsZXQgMjAyMyDDoCAyMDoyOCArMDMwMCwgQW5keSBT
aGV2Y2hlbmtvIGEgw6ljcml0wqA6Cj4gQ2xlYW5pbmcgdXAgdGhlIGRyaXZlciB0byB1c2UgcG1f
cHRyKCkgYW5kICpfUE1fT1BTKCkgbWFjcm9zIHRoYXQKPiBtYWtlIGl0IHNpbXBsZXIgYW5kIGFs
bG93cyB0aGUgY29tcGlsZXIgdG8gcmVtb3ZlIHRob3NlIGZ1bmN0aW9ucwo+IGlmIGJ1aWx0IHdp
dGhvdXQgQ09ORklHX1BNIGFuZCBDT05GSUdfUE1fU0xFRVAgc3VwcG9ydC4KPiAKPiBTaWduZWQt
b2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNv
bT4KClJldmlld2VkLWJ5OiBQYXVsIENlcmN1ZWlsIDxwYXVsQGNyYXBvdWlsbG91Lm5ldD4KCkNo
ZWVycywKLVBhdWwKCj4gLS0tCj4gwqBkcml2ZXJzL3BpbmN0cmwvaW50ZWwvcGluY3RybC1iYXl0
cmFpbC5jIHwgMTEgKysrLS0tLS0tLS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDggZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGluY3RybC9pbnRl
bC9waW5jdHJsLWJheXRyYWlsLmMKPiBiL2RyaXZlcnMvcGluY3RybC9pbnRlbC9waW5jdHJsLWJh
eXRyYWlsLmMKPiBpbmRleCAyN2FlZjYyZmM3YzAuLjY2YWFiYWM2YmU5YyAxMDA2NDQKPiAtLS0g
YS9kcml2ZXJzL3BpbmN0cmwvaW50ZWwvcGluY3RybC1iYXl0cmFpbC5jCj4gKysrIGIvZHJpdmVy
cy9waW5jdHJsL2ludGVsL3BpbmN0cmwtYmF5dHJhaWwuYwo+IEBAIC0xNzMzLDcgKzE3MzMsNiBA
QCBzdGF0aWMgaW50IGJ5dF9waW5jdHJsX3Byb2JlKHN0cnVjdAo+IHBsYXRmb3JtX2RldmljZSAq
cGRldikKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqB9Cj4gwqAKPiAtI2lmZGVmIENP
TkZJR19QTV9TTEVFUAo+IMKgc3RhdGljIGludCBieXRfZ3Bpb19zdXNwZW5kKHN0cnVjdCBkZXZp
Y2UgKmRldikKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGludGVsX3BpbmN0cmwgKnZn
ID0gZGV2X2dldF9kcnZkYXRhKGRldik7Cj4gQEAgLTE4MTcsOSArMTgxNiw3IEBAIHN0YXRpYyBp
bnQgYnl0X2dwaW9fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikKPiDCoMKgwqDCoMKgwqDCoMKg
cmF3X3NwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmJ5dF9sb2NrLCBmbGFncyk7Cj4gwqDCoMKgwqDC
oMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IC0jZW5kaWYKPiDCoAo+IC0jaWZkZWYgQ09ORklHX1BN
Cj4gwqBzdGF0aWMgaW50IGJ5dF9ncGlvX3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpk
ZXYpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IEBAIC0xODI5LDE5ICsxODI2
LDE3IEBAIHN0YXRpYyBpbnQgYnl0X2dwaW9fcnVudGltZV9yZXN1bWUoc3RydWN0Cj4gZGV2aWNl
ICpkZXYpCj4gwqB7Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IMKgfQo+IC0jZW5kaWYK
PiDCoAo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZfcG1fb3BzIGJ5dF9ncGlvX3BtX29wcyA9
IHsKPiAtwqDCoMKgwqDCoMKgwqBTRVRfTEFURV9TWVNURU1fU0xFRVBfUE1fT1BTKGJ5dF9ncGlv
X3N1c3BlbmQsCj4gYnl0X2dwaW9fcmVzdW1lKQo+IC3CoMKgwqDCoMKgwqDCoFNFVF9SVU5USU1F
X1BNX09QUyhieXRfZ3Bpb19ydW50aW1lX3N1c3BlbmQsCj4gYnl0X2dwaW9fcnVudGltZV9yZXN1
bWUsCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IE5VTEwpCj4gK8KgwqDCoMKgwqDCoMKgTEFURV9TWVNURU1fU0xFRVBfUE1fT1BTKGJ5dF9ncGlv
X3N1c3BlbmQsIGJ5dF9ncGlvX3Jlc3VtZSkKPiArwqDCoMKgwqDCoMKgwqBSVU5USU1FX1BNX09Q
UyhieXRfZ3Bpb19ydW50aW1lX3N1c3BlbmQsCj4gYnl0X2dwaW9fcnVudGltZV9yZXN1bWUsIE5V
TEwpCj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBieXRfZ3Bp
b19kcml2ZXIgPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoC5wcm9iZcKgwqDCoMKgwqDCoMKgwqDCoCA9
IGJ5dF9waW5jdHJsX3Byb2JlLAo+IMKgwqDCoMKgwqDCoMKgwqAuZHJpdmVywqDCoMKgwqDCoMKg
wqDCoCA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5uYW1lwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqA9ICJieXRfZ3BpbyIsCj4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoC5wbcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoD0gJmJ5dF9ncGlvX3BtX29wcywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLnBtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgPSBwbV9wdHIo
JmJ5dF9ncGlvX3BtX29wcyksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAuYWNw
aV9tYXRjaF90YWJsZcKgwqDCoMKgwqDCoMKgPSBieXRfZ3Bpb19hY3BpX21hdGNoLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnN1cHByZXNzX2JpbmRfYXR0cnPCoMKgwqDCoD0g
dHJ1ZSwKPiDCoMKgwqDCoMKgwqDCoMKgfSwKCg==

