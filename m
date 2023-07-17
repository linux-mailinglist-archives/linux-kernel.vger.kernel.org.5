Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8F1756D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbjGQTcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjGQTcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:32:43 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEBD12A;
        Mon, 17 Jul 2023 12:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1689621782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f2FsRW/iD1SQYNbltu5CgyPfz65E+yDxeasl/fxtjIM=;
        b=QUSTalgEXSQDjPMLrB5o7QMCahRiCifDFiugm9rnJcn71JCyT7aOLymUOW/gQZyyCiY6hr
        lbE3nKSj+Z4PhaVzbZbruA3x7Vy7tFZknM9Ts+Ht4ZWqsyw8XWam2OvmFRb7OQ5mbs1LP6
        Ru1DyJG3Rjmuhfv6vH5laLD4/TLKACc=
Message-ID: <108dbf8d020d7a4335743aa196ec7be9c8a777a3.camel@crapouillou.net>
Subject: Re: [PATCH v2 05/10] pinctrl: lynxpoint: Make use of pm_ptr()
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
Date:   Mon, 17 Jul 2023 21:23:00 +0200
In-Reply-To: <20230717172821.62827-6-andriy.shevchenko@linux.intel.com>
References: <20230717172821.62827-1-andriy.shevchenko@linux.intel.com>
         <20230717172821.62827-6-andriy.shevchenko@linux.intel.com>
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
ZWVycywKLVBhdWwKCj4gLS0tCj4gwqBkcml2ZXJzL3BpbmN0cmwvaW50ZWwvcGluY3RybC1seW54
cG9pbnQuYyB8IDcgKysrLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwg
NCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL2ludGVsL3Bp
bmN0cmwtbHlueHBvaW50LmMKPiBiL2RyaXZlcnMvcGluY3RybC9pbnRlbC9waW5jdHJsLWx5bnhw
b2ludC5jCj4gaW5kZXggY2RhY2U1NWFhZWFjLi41MGQ5MmJmODBlMjAgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9waW5jdHJsL2ludGVsL3BpbmN0cmwtbHlueHBvaW50LmMKPiArKysgYi9kcml2ZXJz
L3BpbmN0cmwvaW50ZWwvcGluY3RybC1seW54cG9pbnQuYwo+IEBAIC05NDgsOSArOTQ4LDggQEAg
c3RhdGljIGludCBscF9ncGlvX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCj4gwqB9Cj4gwqAK
PiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBscF9ncGlvX3BtX29wcyA9IHsKPiAt
wqDCoMKgwqDCoMKgwqAucnVudGltZV9zdXNwZW5kID0gbHBfZ3Bpb19ydW50aW1lX3N1c3BlbmQs
Cj4gLcKgwqDCoMKgwqDCoMKgLnJ1bnRpbWVfcmVzdW1lID0gbHBfZ3Bpb19ydW50aW1lX3Jlc3Vt
ZSwKPiAtwqDCoMKgwqDCoMKgwqAucmVzdW1lID0gbHBfZ3Bpb19yZXN1bWUsCj4gK8KgwqDCoMKg
wqDCoMKgU1lTVEVNX1NMRUVQX1BNX09QUyhOVUxMLCBscF9ncGlvX3Jlc3VtZSkKPiArwqDCoMKg
wqDCoMKgwqBSVU5USU1FX1BNX09QUyhscF9ncGlvX3J1bnRpbWVfc3VzcGVuZCwKPiBscF9ncGlv
X3J1bnRpbWVfcmVzdW1lLCBOVUxMKQo+IMKgfTsKPiDCoAo+IMKgc3RhdGljIGNvbnN0IHN0cnVj
dCBhY3BpX2RldmljZV9pZCBseW54cG9pbnRfZ3Bpb19hY3BpX21hdGNoW10gPSB7Cj4gQEAgLTk2
NSw3ICs5NjQsNyBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBscF9ncGlvX2RyaXZl
ciA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgLnJlbW92ZcKgwqDCoMKgwqDCoMKgwqAgPSBscF9ncGlv
X3JlbW92ZSwKPiDCoMKgwqDCoMKgwqDCoMKgLmRyaXZlcsKgwqDCoMKgwqDCoMKgwqAgPSB7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAubmFtZcKgwqAgPSAibHBfZ3BpbyIsCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5wbcKgwqDCoMKgwqA9ICZscF9ncGlvX3Bt
X29wcywKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLnBtwqDCoMKgwqDCoD0gcG1f
cHRyKCZscF9ncGlvX3BtX29wcyksCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
YWNwaV9tYXRjaF90YWJsZSA9IGx5bnhwb2ludF9ncGlvX2FjcGlfbWF0Y2gsCj4gwqDCoMKgwqDC
oMKgwqDCoH0sCj4gwqB9OwoK

