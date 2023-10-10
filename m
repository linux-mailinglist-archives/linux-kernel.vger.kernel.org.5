Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6527C0414
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343747AbjJJTIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 15:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjJJTIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 15:08:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2B94;
        Tue, 10 Oct 2023 12:08:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678C9C433C7;
        Tue, 10 Oct 2023 19:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696964882;
        bh=I4IwqI6o5EhRjLQqTCDG+E/JeqNlQV76sSp8+NcTha8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nwCl05G4myE0QT6K/QH33/YxjZJ4rVCdwkNGqGECLOTPMv2DPeaZK4avoshi1q4bF
         Ly5twb+qSLxhVxYapcxB0UuQrtOmhK6Ig/X6ctIhM8G/S3NHPWQwfWi5S+KZIVpmIx
         tGgXxf0f7u2Oi+hpn0GxbS6mOcdupoxo422Vc1zJUQDDzyFA8jbY1Hv2cYglHmuoNt
         Wabq03SAcqF2aY7ZM2tXu3kMH4TV81BdQ8FwJOu7z4DwkFVdFVLDt9LUR2w2Dzqw9b
         q9N1t/A3Z/Z8Aca7Idy22LDluQt5BmXnT623WnQXcZOPLpmiH8A3UWCPtygA3xH7du
         RLJ77bnzKJQEA==
Message-ID: <2c6d1ba5537e38fe45bc5cbd1ed111d856f7bb3e.camel@kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>
Cc:     peterz@infradead.org, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 10 Oct 2023 22:07:57 +0300
In-Reply-To: <8a8c14694d5ff62e385163bf0852fd3adb675087.camel@kernel.org>
References: <20231006051801.423973-1-sumit.garg@linaro.org>
         <CAHk-=whOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=R_3w4R1_Uvg@mail.gmail.com>
         <8a8c14694d5ff62e385163bf0852fd3adb675087.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEwLTEwIGF0IDIyOjA1ICswMzAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
Cj4gT24gVHVlLCAyMDIzLTEwLTEwIGF0IDExOjI4IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90
ZToKPiA+IE9uIFRodSwgNSBPY3QgMjAyMyBhdCAyMjoxOCwgU3VtaXQgR2FyZyA8c3VtaXQuZ2Fy
Z0BsaW5hcm8ub3JnPiB3cm90ZToKPiA+ID4gCj4gPiA+IFN0YXRpYyBjYWxscyBpbnZvY2F0aW9u
cyBhcmVuJ3Qgd2VsbCBzdXBwb3J0ZWQgZnJvbSBtb2R1bGUgX19pbml0IGFuZAo+ID4gPiBfX2V4
aXQgZnVuY3Rpb25zLiBFc3BlY2lhbGx5IHRoZSBzdGF0aWMgY2FsbCBmcm9tIGNsZWFudXBfdHJ1
c3RlZCgpIGxlZAo+ID4gPiB0byBhIGNyYXNoIG9uIHg4NiBrZXJuZWwgd2l0aCBDT05GSUdfREVC
VUdfVklSVFVBTD15Lgo+ID4gPiAKPiA+ID4gSG93ZXZlciwgdGhlIHVzYWdlIG9mIHN0YXRpYyBj
YWxsIGludm9jYXRpb25zIGZvciB0cnVzdGVkX2tleV9pbml0KCkKPiA+ID4gYW5kIHRydXN0ZWRf
a2V5X2V4aXQoKSBkb24ndCBhZGQgYW55IHZhbHVlIGZyb20gZWl0aGVyIGEgcGVyZm9ybWFuY2Ug
b3IKPiA+ID4gc2VjdXJpdHkgcGVyc3BlY3RpdmUuIEhlbmNlIHN3aXRjaCB0byB1c2UgaW5kaXJl
Y3QgZnVuY3Rpb24gY2FsbHMgaW5zdGVhZC4KPiA+IAo+ID4gSSBhcHBsaWVkIHRoaXMgcGF0Y2gg
dG8gbXkgdHJlZSwgc2luY2UgaXQgaXMgYSBmaXggZm9yIHRoZSBpc3N1ZSwgYW5kCj4gPiBkb2Vz
bid0IGNoYW5nZSBhbnkgbG9naWMgb3RoZXJ3aXNlLgo+ID4gCj4gPiBIb3dldmVyLCBJIGRvIG5v
dGUgdGhhdCB0aGUgY29kZSBsb2dpYyBpcyBjb21wbGV0ZWx5IGJyb2tlbi4gSXQgd2FzCj4gPiBi
cm9rZW4gYmVmb3JlIHRvbywgYW5kIGFwcGFyZW50bHkgY2F1c2VzIG5vIHByb2JsZW1zLCBidXQg
aXQncyBzdGlsbAo+ID4gd3JvbmcuCj4gPiAKPiA+IFRoYXQncyBhIHNlcGFyYXRlIGlzc3VlLCBh
bmQgd291bGQgd2FudCBhIHNlcGFyYXRlIHBhdGNoLCBidXQgc2luY2UgSQo+ID4gbm90aWNlZCBp
dCB3aGVuIGFwcGx5aW5nIHRoaXMgb25lLCBJJ20gcmVwbHlpbmcgaGVyZToKPiA+IAo+ID4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cnVzdGVkX2tleV9leGl0ID0gdHJ1c3RlZF9r
ZXlfc291cmNlc1tpXS5vcHMtPmV4aXQ7Cj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBtaWdyYXRhYmxlID0gdHJ1c3RlZF9rZXlfc291cmNlc1tpXS5vcHMtPm1pZ3JhdGFibGU7
Cj4gPiA+IAo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBzdGF0aWNf
Y2FsbCh0cnVzdGVkX2tleV9pbml0KSgpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCByZXQgPSB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+aW5pdCgpOwo+ID4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyZXQpCj4gPiA+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiAKPiA+IE5vdGUgaG93
IHRoaXMgc2V0cyAidHJ1c3RlZF9rZXlfZXhpdCIgZXZlbiB3aGVuIHRoZSAtPmluaXQoKSBmdW5j
dGlvbiBmYWlscy4KPiAKPiBTdW1pdCwgY2FuIHlvdSByZW1pbmQgbWUgd2h5IHRoaXMgY29udGlu
dWVzICpvbiBhbnkgZmFpbHVyZSo/Cj4gCj4gRS5nLiBzb21ldGhpbmcgbGlrZSB0aGlzIHdvdWxk
IG1ha2UgbW9yZSBzZW5zZSB0byBtZToKPiAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoHJldCA9IHRydXN0ZWRfa2V5X3NvdXJjZXNbaV0ub3BzLT5pbml0KCk7Cj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoIXJldCkgewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXRpY19jYWxsX3VwZGF0ZSh0cnVzdGVkX2tl
eV9zZWFsLCB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+c2VhbCk7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdGljX2NhbGxfdXBkYXRlKHRy
dXN0ZWRfa2V5X3Vuc2VhbCwgdHJ1c3RlZF9rZXlfc291cmNlc1tpXS5vcHMtPnVuc2VhbCk7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RhdGljX2Nh
bGxfdXBkYXRlKHRydXN0ZWRfa2V5X2dldF9yYW5kb20sIGdldF9yYW5kb20pOwo+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXRpY19jYWxsX3VwZGF0
ZSh0cnVzdGVkX2tleV9leGl0LCB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+ZXhpdCk7CgpQ
bGVhc2UgaWdub3JlIHRoZSBsaW5lIGFib3ZlIDotKQoKQlIsIEphcmtrbwo=

