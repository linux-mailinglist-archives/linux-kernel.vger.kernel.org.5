Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AE27AD423
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjIYJEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjIYJEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:04:35 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3146DF;
        Mon, 25 Sep 2023 02:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1695632667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v7ac3hZtdvTVdyFeEAL7Uhu4y3aVyuKPapooxkCftvI=;
        b=h1Co+aUEgP/jyKqRhYLHkb4zBtClO36o1jT10q717JO4NmUG7V9SpuOv0ibYl0plLj1B0l
        av6gYyD86f3oJ94XiD2sa78sK8J9E8jkRTAhWuQeegbbRCMF4BjMWF4TN2BBwCSckyHDke
        QCLI/h6ULfsKZ0Q1wti3gRjVW2zRR1Q=
Message-ID: <dac3b4812951d8dabf1f4017c4813a8c9183f393.camel@crapouillou.net>
Subject: Re: [RFC PATCH v3 3/7] drm/panel: nv3052c: Allow specifying
 registers per panel
From:   Paul Cercueil <paul@crapouillou.net>
To:     John Watts <contact@jookia.org>, dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Chris Morgan <macromorgan@hotmail.com>,
        Jagan Teki <jagan@edgeble.ai>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 Sep 2023 11:04:25 +0200
In-Reply-To: <20230925021059.451019-4-contact@jookia.org>
References: <20230925021059.451019-1-contact@jookia.org>
         <20230925021059.451019-4-contact@jookia.org>
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

SGkgSm9obiwKCkxlIGx1bmRpIDI1IHNlcHRlbWJyZSAyMDIzIMOgIDEyOjEwICsxMDAwLCBKb2hu
IFdhdHRzIGEgw6ljcml0wqA6Cj4gUGFuZWwgaW5pdGlhbGl6YXRpb24gcmVnaXN0ZXJzIGFyZSBw
ZXItZGlzcGxheSBhbmQgbm90IHRpZWQgdG8gdGhlCj4gY29udHJvbGxlciBpdHNlbGYuIERpZmZl
cmVudCBwYW5lbHMgd2lsbCBzcGVjaWZ5IHRoZWlyIG93biByZWdpc3RlcnMuCj4gQXR0YWNoIHRo
ZSBzZXF1ZW5jZXMgdG8gdGhlIHBhbmVsIGluZm8gc3RydWN0IHNvIGZ1dHVyZSBwYW5lbHMKPiBj
YW4gc3BlY2lmeSB0aGVpciBvd24gc2VxdWVuY2VzLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEpvaG4g
V2F0dHMgPGNvbnRhY3RAam9va2lhLm9yZz4KPiBSZXZpZXdlZC1ieTogSmVzc2ljYSBaaGFuZyA8
cXVpY19qZXNzemhhbkBxdWljaW5jLmNvbT4KPiAtLS0KPiDCoC4uLi9ncHUvZHJtL3BhbmVsL3Bh
bmVsLW5ld3Zpc2lvbi1udjMwNTJjLmPCoMKgIHwgMjQgKysrKysrKysrKysrLS0tLS0KPiAtLQo+
IMKgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9wYW5lbC9wYW5lbC1uZXd2aXNpb24tbnYzMDUy
Yy5jCj4gYi9kcml2ZXJzL2dwdS9kcm0vcGFuZWwvcGFuZWwtbmV3dmlzaW9uLW52MzA1MmMuYwo+
IGluZGV4IDkwZGVhMjFmOTg1Ni4uMzgyMDYyYTc5YmE4IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9wYW5lbC9wYW5lbC1uZXd2aXNpb24tbnYzMDUyYy5jCj4gKysrIGIvZHJpdmVycy9n
cHUvZHJtL3BhbmVsL3BhbmVsLW5ld3Zpc2lvbi1udjMwNTJjLmMKPiBAQCAtMjAsMTEgKzIwLDE4
IEBACj4gwqAjaW5jbHVkZSA8ZHJtL2RybV9tb2Rlcy5oPgo+IMKgI2luY2x1ZGUgPGRybS9kcm1f
cGFuZWwuaD4KPiDCoAo+ICtzdHJ1Y3QgbnYzMDUyY19yZWcgewo+ICvCoMKgwqDCoMKgwqDCoHU4
IGNtZDsKPiArwqDCoMKgwqDCoMKgwqB1OCB2YWw7Cj4gK307Cj4gKwo+IMKgc3RydWN0IG52MzA1
MmNfcGFuZWxfaW5mbyB7Cj4gwqDCoMKgwqDCoMKgwqDCoGNvbnN0IHN0cnVjdCBkcm1fZGlzcGxh
eV9tb2RlICpkaXNwbGF5X21vZGVzOwo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgbnVt
X21vZGVzOwo+IMKgwqDCoMKgwqDCoMKgwqB1MTYgd2lkdGhfbW0sIGhlaWdodF9tbTsKPiDCoMKg
wqDCoMKgwqDCoMKgdTMyIGJ1c19mb3JtYXQsIGJ1c19mbGFnczsKPiArwqDCoMKgwqDCoMKgwqBj
b25zdCBzdHJ1Y3QgbnYzMDUyY19yZWcgKnBhbmVsX3JlZ3M7Cj4gK8KgwqDCoMKgwqDCoMKgaW50
IHBhbmVsX3JlZ3NfbGVuOwoKVGhpcyBjYW4gYmUgdW5zaWduZWQuCgo+IMKgfTsKPiDCoAo+IMKg
c3RydWN0IG52MzA1MmMgewo+IEBAIC0zNiwxMiArNDMsNyBAQCBzdHJ1Y3QgbnYzMDUyYyB7Cj4g
wqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBncGlvX2Rlc2MgKnJlc2V0X2dwaW87Cj4gwqB9Owo+IMKg
Cj4gLXN0cnVjdCBudjMwNTJjX3JlZyB7Cj4gLcKgwqDCoMKgwqDCoMKgdTggY21kOwo+IC3CoMKg
wqDCoMKgwqDCoHU4IHZhbDsKPiAtfTsKPiAtCj4gLXN0YXRpYyBjb25zdCBzdHJ1Y3QgbnYzMDUy
Y19yZWcgbnYzMDUyY19wYW5lbF9yZWdzW10gPSB7Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbnYz
MDUyY19yZWcgbHRrMDM1YzU0NDR0X3BhbmVsX3JlZ3NbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKg
Ly8gRVhUQyBDb21tYW5kIHNldCBlbmFibGUsIHNlbGVjdCBwYWdlIDEKPiDCoMKgwqDCoMKgwqDC
oMKgeyAweGZmLCAweDMwIH0sIHsgMHhmZiwgMHg1MiB9LCB7IDB4ZmYsIDB4MDEgfSwKPiDCoMKg
wqDCoMKgwqDCoMKgLy8gTW9zdGx5IHVua25vd24gcmVnaXN0ZXJzCj4gQEAgLTI0NCw2ICsyNDYs
OCBAQCBzdGF0aWMgaW5saW5lIHN0cnVjdCBudjMwNTJjICp0b19udjMwNTJjKHN0cnVjdAo+IGRy
bV9wYW5lbCAqcGFuZWwpCj4gwqBzdGF0aWMgaW50IG52MzA1MmNfcHJlcGFyZShzdHJ1Y3QgZHJt
X3BhbmVsICpwYW5lbCkKPiDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IG52MzA1MmMgKnBy
aXYgPSB0b19udjMwNTJjKHBhbmVsKTsKPiArwqDCoMKgwqDCoMKgwqBjb25zdCBzdHJ1Y3QgbnYz
MDUyY19yZWcgKnBhbmVsX3JlZ3MgPSBwcml2LT5wYW5lbF9pbmZvLQo+ID5wYW5lbF9yZWdzOwo+
ICvCoMKgwqDCoMKgwqDCoGludCBwYW5lbF9yZWdzX2xlbiA9IHByaXYtPnBhbmVsX2luZm8tPnBh
bmVsX3JlZ3NfbGVuOwoKU2FtZSBoZXJlLgoKV2l0aCB0aGlzIGZpeGVkIEknbSBoYXBweSB3aXRo
IHRoZSBwYXRjaC4KCkNoZWVycywKLVBhdWwKCj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBtaXBp
X2RiaSAqZGJpID0gJnByaXYtPmRiaTsKPiDCoMKgwqDCoMKgwqDCoMKgdW5zaWduZWQgaW50IGk7
Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBlcnI7Cj4gQEAgLTI2MCw5ICsyNjQsOSBAQCBzdGF0aWMg
aW50IG52MzA1MmNfcHJlcGFyZShzdHJ1Y3QgZHJtX3BhbmVsCj4gKnBhbmVsKQo+IMKgwqDCoMKg
wqDCoMKgwqBncGlvZF9zZXRfdmFsdWVfY2Fuc2xlZXAocHJpdi0+cmVzZXRfZ3BpbywgMCk7Cj4g
wqDCoMKgwqDCoMKgwqDCoHVzbGVlcF9yYW5nZSg1MDAwLCAyMDAwMCk7Cj4gwqAKPiAtwqDCoMKg
wqDCoMKgwqBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShudjMwNTJjX3BhbmVsX3JlZ3MpOyBp
KyspIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyID0gbWlwaV9kYmlfY29t
bWFuZChkYmksCj4gbnYzMDUyY19wYW5lbF9yZWdzW2ldLmNtZCwKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgbnYzMDUyY19wYW5lbF9yZWdzW2ldLnZhbCk7Cj4gK8KgwqDCoMKgwqDCoMKgZm9yIChpID0g
MDsgaSA8IHBhbmVsX3JlZ3NfbGVuOyBpKyspIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZXJyID0gbWlwaV9kYmlfY29tbWFuZChkYmksIHBhbmVsX3JlZ3NbaV0uY21kLAo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwYW5lbF9yZWdzW2ldLnZhbCk7Cj4gwqAKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmIChlcnIpIHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZfZXJyKHByaXYtPmRldiwgIlVuYWJsZSB0byBzZXQg
cmVnaXN0ZXI6Cj4gJWRcbiIsIGVycik7Cj4gQEAgLTQ2Myw2ICs0NjcsOCBAQCBzdGF0aWMgY29u
c3Qgc3RydWN0IG52MzA1MmNfcGFuZWxfaW5mbwo+IGx0azAzNWM1NDQ0dF9wYW5lbF9pbmZvID0g
ewo+IMKgwqDCoMKgwqDCoMKgwqAuaGVpZ2h0X21tID0gNjQsCj4gwqDCoMKgwqDCoMKgwqDCoC5i
dXNfZm9ybWF0ID0gTUVESUFfQlVTX0ZNVF9SR0I4ODhfMVgyNCwKPiDCoMKgwqDCoMKgwqDCoMKg
LmJ1c19mbGFncyA9IERSTV9CVVNfRkxBR19ERV9ISUdIIHwKPiBEUk1fQlVTX0ZMQUdfUElYREFU
QV9EUklWRV9ORUdFREdFLAo+ICvCoMKgwqDCoMKgwqDCoC5wYW5lbF9yZWdzID0gbHRrMDM1YzU0
NDR0X3BhbmVsX3JlZ3MsCj4gK8KgwqDCoMKgwqDCoMKgLnBhbmVsX3JlZ3NfbGVuID0gQVJSQVlf
U0laRShsdGswMzVjNTQ0NHRfcGFuZWxfcmVncyksCj4gwqB9Owo+IMKgCj4gwqBzdGF0aWMgY29u
c3Qgc3RydWN0IHNwaV9kZXZpY2VfaWQgbnYzMDUyY19pZHNbXSA9IHsKCg==

