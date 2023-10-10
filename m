Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BDD7C007B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233493AbjJJPg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbjJJPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:36:51 -0400
X-Greylist: delayed 178 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Oct 2023 08:36:48 PDT
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675C9B6;
        Tue, 10 Oct 2023 08:36:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696952025; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=apQCHxbzR1FOlK3PakJHpjLweQI9qMRuFP72ZtCzsMR4xRp009er6xRUfQ1tW+C+eN
    Gy2gRN/v9R4juY9xCuC9RHJd/caqlJqs1nwToiJeB/AnzqPNv1Xp2l/uTr/2LctDXAxs
    Oi3s2iTGySWKJLzyG932PZSYvY+VDD1T1vcJ8yU1NpkZ7GjRZkK/SM/Tv+F1okggDz19
    CG0nNTVGIaK56DzsYGKHqLE+WNajgYLD9ZA2dlLmavp3zOJqLwsRdXDq6+XlzPG6hqGN
    dP5z+FzJd9Dj09IZJzsfMWSinYoMAFrj7PTpbFbh4x4OpOTq119rl0mlEM1ppreXd9pF
    xj+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696952025;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yKRicMPMQDDgG2hdmIL9MNT4ou+YYmkHVXjO4CkZXNI=;
    b=l3HImAhklLpqHY0GxsMMFJhLJg8fiEvLrrnSuQMrTZZmDkHo49W9shNbqPu8df0PNb
    Ln0Vmxn9utC1Eon+oDvUh3FJhGtl3ugh1fLOEh7/i6ewT+IV9kLeCR23d8jd2gZVtikZ
    N21mtEoc8eHDt6uRy/Vh0ITxxqPP8RVAA/h0oiMRafcdhwk8aBwG/oncRwg/741IAQs+
    FghJorxQyK0Cs0Ir0wDFHDjfyvPyEz18JHa9y0uXB3UK/lk8YVQcwo/SkCO2bFcU67sn
    Xik7e6zGKUcMUG8DVbsvEdIBzcSVjW9uNUDDiknf9KgvPirrPA3EvisWOEWX/1/f1Tx2
    uRTw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696952025;
    s=strato-dkim-0002; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yKRicMPMQDDgG2hdmIL9MNT4ou+YYmkHVXjO4CkZXNI=;
    b=AaUhGOxYASCWn1B467IMTDTJeEpuFSZ7SkCO0ISmszqQrgDjEq6GjgeAYaEX0/wDtA
    Tk5oHS62sRvNGjb//XWAVIfFyA5F+uHtsb2zxu/Bq4j1KfUJv7gQoxT1CII3G/3YGreD
    s5MBq/zCOzgtmaLTrojUVwmnhf4HLTf6yJQhYQatt3qus8W6eJy3JU+AOPYE/TF5UtIm
    ZA9bwAAGd9dYUC1F/4d4xsr2eHsq04hLLuK5BenrnspnIZTifcaa2hDaId/ebEeVBYtg
    VbizJqCiABY6LOZ3UJbhQB7iUJ1wTtu8qmDaDEvUONbTycfn9BrbvCRSPlBodY0AD4MY
    BIOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696952025;
    s=strato-dkim-0003; d=iokpp.de;
    h=References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=yKRicMPMQDDgG2hdmIL9MNT4ou+YYmkHVXjO4CkZXNI=;
    b=SlyKcnmhFMg5K3ZzkfcA8FgYySpxZusCY2yP5p/iuSnBSQ6TsrgP3T1C1t8QAM7YtR
    qg/5twBtmJKs9BRbiMBA==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSeBwhhSxarlUcu05JCAPyj3VPAceccYJs0uz"
Received: from [10.176.234.119]
    by smtp.strato.de (RZmta 49.8.2 AUTH)
    with ESMTPSA id V04024z9AFXiL8K
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 10 Oct 2023 17:33:44 +0200 (CEST)
Message-ID: <254df9b8ca7475ad9dbd3a303c60e1f99eca9c56.camel@iokpp.de>
Subject: Re: [PATCH v4] mmc: Add quirk MMC_QUIRK_BROKEN_CACHE_FLUSH for
 Micron eMMC Q2J54A
From:   Bean Huo <beanhuo@iokpp.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     adrian.hunter@intel.com, beanhuo@micron.com,
        jakub.kwapisz@toradex.com, rafael.beims@toradex.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Tue, 10 Oct 2023 17:33:43 +0200
In-Reply-To: <CAPDyKFpgPEhVuTbxe5YhYQ0W6907SwJRxSQLB1F2FbVW3zKHxg@mail.gmail.com>
References: <20231001194943.658299-1-beanhuo@iokpp.de>
         <CAPDyKFpgPEhVuTbxe5YhYQ0W6907SwJRxSQLB1F2FbVW3zKHxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVWxmLAoKdGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCBJIGRpZG4ndCBxdWl0ZSBnZXQgeW91
ciBwb2ludHM6CgpPbiBUdWUsIDIwMjMtMTAtMTAgYXQgMTY6MjAgKzAyMDAsIFVsZiBIYW5zc29u
IHdyb3RlOgo+ID4gQEAgLTIzODEsOCArMjM4MSwxMSBAQCBlbnVtIG1tY19pc3N1ZWQgbW1jX2Js
a19tcV9pc3N1ZV9ycShzdHJ1Y3QKPiA+IG1tY19xdWV1ZSAqbXEsIHN0cnVjdCByZXF1ZXN0ICpy
ZXEpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
fQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dCA9IG1tY19ibGtfY3FlX2lzc3VlX2ZsdXNoKG1xLCByZXEpOwo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOwo+ID4gLcKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBSRVFfT1BfUkVBRDoKPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGNhc2UgUkVRX09QX1dSSVRFOgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChtbWNfY2FyZF9icm9rZW5fY2FjaGVfZmx1
c2goY2FyZCkgJiYKPiA+ICFjYXJkLT53cml0dGVuX2ZsYWcpCj4gCj4gSXQgbG9va3Mgc3VwZXJm
bHVvdXMgdG8gbWUgdG8gY2hlY2sgbW1jX2NhcmRfYnJva2VuX2NhY2hlX2ZsdXNoKCkgYW5kCj4g
IWNhcmQtPndyaXR0ZW5fZmxhZy4gSnVzdCBzZXQgdGhlIGNhcmQtPndyaXR0ZW5fZmxhZyB1bmNv
bmRpdGlvbmFsbHkuCgp3aGF0IGRpZCB5b3UgbWVhbiAiSnVzdCBzZXQgdGhlIGNhcmQtPndyaXR0
ZW5fZmxhZyB1bmNvbmRpdGlvbmFsbHkuIj8KVGhpcyBtZWFucyBJIGp1c3QgbmVlZCB0byBjaGVj
ayBjYXJkLT53cml0dGVuX2ZsYWcgYW5kIHNldCBjYXJkLQo+d3JpdHRlbl9mbGFnIHRvIHRydWUg
YW5kIGZhbHNlIGluIHRoZSBjYXNlCk1NQ19RVUlSS19CUk9LRU5fQ0FDSEVfRkxVU0g/IG9yIGRv
bid0IG5lZWQgdG8gY2FsbAptbWNfY2FyZF9icm9rZW5fY2FjaGVfZmx1c2goKT8KCj4gCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGNhcmQtPndyaXR0ZW5fZmxhZyA9IHRydWU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmFsbHRocm91Z2g7Cj4gPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBjYXNlIFJFUV9PUF9SRUFEOgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChob3N0LT5jcWVfZW5hYmxlZCkKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgcmV0ID0gbW1jX2Jsa19jcWVfaXNzdWVfcndfcnEobXEsCj4gPiByZXEpOwo+ID4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVsc2UKPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL21tYy9jb3JlL2NhcmQuaCBiL2RyaXZlcnMvbW1jL2NvcmUvY2Fy
ZC5oCj4gPiBpbmRleCA0ZWRmOTA1N2ZhNzkuLmI3NzU0YTFiOGQ5NyAxMDA2NDQKPiA+IC0tLSBh
L2RyaXZlcnMvbW1jL2NvcmUvY2FyZC5oCj4gPiArKysgYi9kcml2ZXJzL21tYy9jb3JlL2NhcmQu
aAo+ID4gQEAgLTI4MCw0ICsyODAsOCBAQCBzdGF0aWMgaW5saW5lIGludAo+ID4gbW1jX2NhcmRf
YnJva2VuX3NkX2NhY2hlKGNvbnN0IHN0cnVjdCBtbWNfY2FyZCAqYykKPiA+IMKgwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIGMtPnF1aXJrcyAmIE1NQ19RVUlSS19CUk9LRU5fU0RfQ0FDSEU7Cj4gPiDC
oCB9Cj4gPiAKPiA+ICtzdGF0aWMgaW5saW5lIGludCBtbWNfY2FyZF9icm9rZW5fY2FjaGVfZmx1
c2goY29uc3Qgc3RydWN0Cj4gPiBtbWNfY2FyZCAqYykKPiA+ICt7Cj4gPiArwqDCoMKgwqDCoMKg
IHJldHVybiBjLT5xdWlya3MgJiBNTUNfUVVJUktfQlJPS0VOX0NBQ0hFX0ZMVVNIOwo+ID4gK30K
PiA+IMKgICNlbmRpZgo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMgYi9k
cml2ZXJzL21tYy9jb3JlL21tYy5jCj4gPiBpbmRleCA4OWNkNDhmY2VjNzkuLjQ3ODk2YzMyMDg2
ZSAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvbW1jLmMKPiA+ICsrKyBiL2RyaXZl
cnMvbW1jL2NvcmUvbW1jLmMKPiA+IEBAIC0xOTI5LDYgKzE5MjksOCBAQCBzdGF0aWMgaW50IG1t
Y19pbml0X2NhcmQoc3RydWN0IG1tY19ob3N0Cj4gPiAqaG9zdCwgdTMyIG9jciwKPiA+IMKgwqDC
oMKgwqDCoMKgwqAgaWYgKCFvbGRjYXJkKQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaG9zdC0+Y2FyZCA9IGNhcmQ7Cj4gPiAKPiA+ICvCoMKgwqDCoMKgwqAgY2FyZC0+d3Jp
dHRlbl9mbGFnID0gZmFsc2U7Cj4gPiArCj4gCj4gSG93IGFib3V0IGRvaW5nIHRoaXMgYWZ0ZXIg
YSBzdWNjZXNzZnVsIGZsdXNoIG9wZXJhdGlvbiBpbnN0ZWFkPyBJbgo+IG90aGVyIHdvcmRzIGlu
IF9tbWNfZmx1c2hfY2FjaGUoKS4KCkhlcmUgaW5pdGlhbGl6ZXMgZmxhZyBhbmQgdGhlIHBhdGNo
IGlzIGludGVudGluZyB0byBlbGltaW5hdGUgdGhlIGNhY2hlCmZsdXNoIGNvbW1hbmQgYmVmb3Jl
IHdyaXRpbmcuIHdoYXQgZG8geW91IG1lYW4gYWRkaW5nIGluCm1tY19mbHVzaF9jYWNoZSgpPwoK
CktpbmQgcmVnYXJkcywKQmVhbgoK

