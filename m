Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47ED47BFB99
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJJMfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjJJMft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:35:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A894;
        Tue, 10 Oct 2023 05:35:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD570C433C8;
        Tue, 10 Oct 2023 12:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696941347;
        bh=b7nUh1uQ6nC/Vhad6HRVLVfWcoL7dw7QIED5V55CPu4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SZLWYwVs5O+QBHcViu03bl7YgzcblktmpftyA/8AA4Z6Qb9iHl2CMaMEQtctg8QIm
         UfGuBgMsj6y53FuFr2hdPpxcxBQ+DNUnulxjpni6Uj+GWMB+P3WCBjLSvUAnDxHcbq
         babI4DDWTDRrgcnv3o/GKJYBL7Yj4YY0xq7RuKd4OeJMtNV0XCTk3ZjHd0vlWXZPyy
         1pJNqaMENnox4dmaljwMhwsneu0NFVzcv2js/g5UeIlUlSbYgag2erTpNCiuLRI7hg
         Nih0fWMnU0UIFGEuIbjYS4UxzuDNbwI95KYCI+XEp5UiaGXkY70UZcYoPnVn0Jw7wW
         ODYuCrLnODttg==
Message-ID: <276b9295c119c1e54471398a63fa33ade66b9975.camel@kernel.org>
Subject: Re: [PATCH] tpm: nuvoton: Use i2c_get_match_data()
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Rob Herring <robh@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 10 Oct 2023 15:35:44 +0300
In-Reply-To: <20231006214246.337426-1-robh@kernel.org>
References: <20231006214246.337426-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDE2OjQyIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToKPiBV
c2UgcHJlZmVycmVkIGkyY19nZXRfbWF0Y2hfZGF0YSgpIGluc3RlYWQgb2Ygb2ZfbWF0Y2hfZGV2
aWNlKCkgdG8KPiBnZXQgdGhlIGRyaXZlciBtYXRjaCBkYXRhLiBXaXRoIHRoaXMsIGFkanVzdCB0
aGUgaW5jbHVkZXMgdG8gZXhwbGljaXRseQo+IGluY2x1ZGUgdGhlIGNvcnJlY3QgaGVhZGVycy4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPgoKUGVyaGFw
cyBzZWxmLWV2aWRlbnQgYnV0IHRvIGhhdmUgYSBjbG9zZWQgc3Rvcnkgd291bGQgYmUgbmljZSB0
b3VjaAp0byB3cml0ZSBkb3duIHRoZSByZWFzb24gZm9yIHRoZSBzd2l0Y2guCgpCUiwgSmFya2tv
Cgo+IC0tLQo+IMKgZHJpdmVycy9jaGFyL3RwbS90cG1faTJjX251dm90b24uYyB8IDE1ICsrKyst
LS0tLS0tLS0tLQo+IMKgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hhci90cG0vdHBtX2kyY19udXZvdG9u
LmMgYi9kcml2ZXJzL2NoYXIvdHBtL3RwbV9pMmNfbnV2b3Rvbi5jCj4gaW5kZXggZDdiZTAzYzQx
MDk4Li41NDkwZjdlMGZhNDMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy9jaGFyL3RwbS90cG1faTJj
X251dm90b24uYwo+ICsrKyBiL2RyaXZlcnMvY2hhci90cG0vdHBtX2kyY19udXZvdG9uLmMKPiBA
QCAtMTksNyArMTksOCBAQAo+IMKgI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgo+IMKgI2lu
Y2x1ZGUgPGxpbnV4L3dhaXQuaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9pMmMuaD4KPiAtI2luY2x1
ZGUgPGxpbnV4L29mX2RldmljZS5oPgo+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4KPiArI2luY2x1
ZGUgPGxpbnV4L3Byb3BlcnR5Lmg+Cj4gwqAjaW5jbHVkZSAidHBtLmgiCj4gwqAKPiDCoC8qIEky
QyBpbnRlcmZhY2Ugb2Zmc2V0cyAqLwo+IEBAIC01MjQsNyArNTI1LDYgQEAgc3RhdGljIGludCBn
ZXRfdmlkKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQsIHUzMiAqcmVzKQo+IMKgCj4gwqBzdGF0
aWMgaW50IGkyY19udXZvdG9uX3Byb2JlKHN0cnVjdCBpMmNfY2xpZW50ICpjbGllbnQpCj4gwqB7
Cj4gLcKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IGkyY19kZXZpY2VfaWQgKmlkID0gaTJjX2Ns
aWVudF9nZXRfZGV2aWNlX2lkKGNsaWVudCk7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCByYzsKPiDC
oMKgwqDCoMKgwqDCoMKgc3RydWN0IHRwbV9jaGlwICpjaGlwOwo+IMKgwqDCoMKgwqDCoMKgwqBz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmY2xpZW50LT5kZXY7Cj4gQEAgLTU0NiwxNSArNTQ2LDggQEAg
c3RhdGljIGludCBpMmNfbnV2b3Rvbl9wcm9iZShzdHJ1Y3QgaTJjX2NsaWVudCAqY2xpZW50KQo+
IMKgwqDCoMKgwqDCoMKgwqBpZiAoIXByaXYpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVOT01FTTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGlmIChkZXYtPm9mX25v
ZGUpIHsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCAqb2ZfaWQ7Cj4gLQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBvZl9p
ZCA9IG9mX21hdGNoX2RldmljZShkZXYtPmRyaXZlci0+b2ZfbWF0Y2hfdGFibGUsIGRldik7Cj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChvZl9pZCAmJiBvZl9pZC0+ZGF0YSA9
PSBPRl9JU19UUE0yKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgY2hpcC0+ZmxhZ3MgfD0gVFBNX0NISVBfRkxBR19UUE0yOwo+IC3CoMKgwqDCoMKgwqDC
oH0gZWxzZQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoaWQtPmRyaXZlcl9k
YXRhID09IEkyQ19JU19UUE0yKQo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgY2hpcC0+ZmxhZ3MgfD0gVFBNX0NISVBfRkxBR19UUE0yOwo+ICvCoMKgwqDC
oMKgwqDCoGlmIChpMmNfZ2V0X21hdGNoX2RhdGEoY2xpZW50KSkKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgY2hpcC0+ZmxhZ3MgfD0gVFBNX0NISVBfRkxBR19UUE0yOwo+IMKgCj4g
wqDCoMKgwqDCoMKgwqDCoGluaXRfd2FpdHF1ZXVlX2hlYWQoJnByaXYtPnJlYWRfcXVldWUpOwo+
IMKgCgpObyBjb21wbGFpbnMgYWJvdXQgdGhlIGNvZGUgY2hhbmdlLgoKQlIsIEphcmtrbwoK

