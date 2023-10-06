Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4237BC27C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbjJFWt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjJFWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:49:56 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD2393;
        Fri,  6 Oct 2023 15:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1696632590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/La+bAQr6pbo7yXrDUvr9bsXfjHbKwNCBXnfzuP/Bw=;
        b=TefHFfqsF9Oydyb1jzb3mELyju5aT68PwLr1aPdoGLxRB7p72sY2HNen+OYdFycmkgJoB2
        zrwuiw0hsfJT7375dizXLJUzA3PYmqvJQiERFhoszcvyIOK/eseyDuwhRbfmKQAUA0ZbLm
        2/pzkvcvQG96hLE32NGmH8Mq3ubksE8=
Message-ID: <034f46130949c89dd144f51f0c1bca152367ee78.camel@crapouillou.net>
Subject: Re: [PATCH] mmc: jz4740: Use device_get_match_data()
From:   Paul Cercueil <paul@crapouillou.net>
To:     Rob Herring <robh@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 07 Oct 2023 00:49:48 +0200
In-Reply-To: <20231006224343.441720-1-robh@kernel.org>
References: <20231006224343.441720-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUm9iLAoKTGUgdmVuZHJlZGkgMDYgb2N0b2JyZSAyMDIzIMOgIDE3OjQzIC0wNTAwLCBSb2Ig
SGVycmluZyBhIMOpY3JpdMKgOgo+IFVzZSBwcmVmZXJyZWQgZGV2aWNlX2dldF9tYXRjaF9kYXRh
KCkgaW5zdGVhZCBvZiBvZl9tYXRjaF9kZXZpY2UoKSB0bwo+IGdldCB0aGUgZHJpdmVyIG1hdGNo
IGRhdGEuIFdpdGggdGhpcywgYWRqdXN0IHRoZSBpbmNsdWRlcyB0bwo+IGV4cGxpY2l0bHkKPiBp
bmNsdWRlIHRoZSBjb3JyZWN0IGhlYWRlcnMuCj4gCj4gU2lnbmVkLW9mZi1ieTogUm9iIEhlcnJp
bmcgPHJvYmhAa2VybmVsLm9yZz4KPiAtLS0KPiDCoGRyaXZlcnMvbW1jL2hvc3Qvano0NzQwX21t
Yy5jIHwgMTUgKysrKystLS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25z
KCspLCAxMCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9q
ejQ3NDBfbW1jLmMKPiBiL2RyaXZlcnMvbW1jL2hvc3Qvano0NzQwX21tYy5jCj4gaW5kZXggZjM3
OWNlNWI1ODJkLi42YTQ1OTkxY2EwNTYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9tbWMvaG9zdC9q
ejQ3NDBfbW1jLmMKPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L2p6NDc0MF9tbWMuYwo+IEBAIC0x
OCw5ICsxOCwxMCBAQAo+IMKgI2luY2x1ZGUgPGxpbnV4L21tYy9ob3N0Lmg+Cj4gwqAjaW5jbHVk
ZSA8bGludXgvbW1jL3Nsb3QtZ3Bpby5oPgo+IMKgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgo+
IC0jaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+Cj4gKyNpbmNsdWRlIDxsaW51eC9vZi5oPgo+
IMKgI2luY2x1ZGUgPGxpbnV4L3BpbmN0cmwvY29uc3VtZXIuaD4KPiDCoCNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4KPiArI2luY2x1ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+Cj4gwqAj
aW5jbHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgv
c2NhdHRlcmxpc3QuaD4KPiDCoAo+IEBAIC0xMDQwLDcgKzEwNDEsNiBAQCBzdGF0aWMgaW50IGp6
NDc0MF9tbWNfcHJvYmUoc3RydWN0Cj4gcGxhdGZvcm1fZGV2aWNlKiBwZGV2KQo+IMKgwqDCoMKg
wqDCoMKgwqBpbnQgcmV0Owo+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbW1jX2hvc3QgKm1tYzsK
PiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGp6NDc0MF9tbWNfaG9zdCAqaG9zdDsKPiAtwqDCoMKg
wqDCoMKgwqBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaDsKPiDCoAo+IMKgwqDCoMKg
wqDCoMKgwqBtbWMgPSBtbWNfYWxsb2NfaG9zdChzaXplb2Yoc3RydWN0IGp6NDc0MF9tbWNfaG9z
dCksICZwZGV2LQo+ID5kZXYpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIW1tYykgewo+IEBAIC0x
MDUwLDEzICsxMDUwLDggQEAgc3RhdGljIGludCBqejQ3NDBfbW1jX3Byb2JlKHN0cnVjdAo+IHBs
YXRmb3JtX2RldmljZSogcGRldikKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBob3N0ID0gbW1jX3By
aXYobW1jKTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoG1hdGNoID0gb2ZfbWF0Y2hfZGV2aWNlKGp6
NDc0MF9tbWNfb2ZfbWF0Y2gsICZwZGV2LT5kZXYpOwo+IC3CoMKgwqDCoMKgwqDCoGlmIChtYXRj
aCkgewo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBob3N0LT52ZXJzaW9uID0gKGVu
dW0gano0NzQwX21tY192ZXJzaW9uKW1hdGNoLT5kYXRhOwo+IC3CoMKgwqDCoMKgwqDCoH0gZWxz
ZSB7Cj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC8qIEpaNDc0MCBzaG91bGQgYmUg
dGhlIG9ubHkgb25lIHVzaW5nIGxlZ2FjeSBwcm9iZQo+ICovCj4gLcKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGhvc3QtPnZlcnNpb24gPSBKWl9NTUNfSlo0NzQwOwo+IC3CoMKgwqDCoMKg
wqDCoH0KPiArwqDCoMKgwqDCoMKgwqAvKiBEZWZhdWx0IGlmIG5vIG1hdGNoIGlzIEpaNDc0MCAq
Lwo+ICvCoMKgwqDCoMKgwqDCoGhvc3QtPnZlcnNpb24gPSAoZW51bQo+IGp6NDc0MF9tbWNfdmVy
c2lvbilkZXZpY2VfZ2V0X21hdGNoX2RhdGEoJnBkZXYtPmRldik7CgpQcmV0dHkgY2xldmVyLgoK
UmV2aWV3ZWQtYnk6IFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PgoKQ2hlZXJz
LAotUGF1bAoKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqByZXQgPSBtbWNfb2ZfcGFyc2UobW1jKTsK
PiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJldCkgewo+IEBAIC0xMjAwLDcgKzExOTUsNyBAQCBzdGF0
aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBqejQ3NDBfbW1jX2RyaXZlcgo+ID0gewo+IMKgwqDC
oMKgwqDCoMKgwqAuZHJpdmVyID0gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
Lm5hbWUgPSAiano0NzQwLW1tYyIsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAu
cHJvYmVfdHlwZSA9IFBST0JFX1BSRUZFUl9BU1lOQ0hST05PVVMsCj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoC5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX3B0cihqejQ3NDBfbW1j
X29mX21hdGNoKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgLm9mX21hdGNoX3Rh
YmxlID0gano0NzQwX21tY19vZl9tYXRjaCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoC5wbSA9IHBtX3NsZWVwX3B0cigmano0NzQwX21tY19wbV9vcHMpLAo+IMKgwqDCoMKgwqDC
oMKgwqB9LAo+IMKgfTsKCg==

