Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F807BFB84
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjJJMdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 08:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231917AbjJJMdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 08:33:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0E8102;
        Tue, 10 Oct 2023 05:33:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26833C433C8;
        Tue, 10 Oct 2023 12:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696941221;
        bh=6czSRTftyYGlKbWOG1D22PcwxZAwDZn28yp1yUyg0oQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=bsHx/+dRAo5dDJmygSFEyW8QVp6AkcgFLWN3IkV75ZTJVBU4POOgSXD5pIe5xOSRX
         Ys0TbA7FAybW9f4f+nJ9PAOXiwSJ1aIB+2ovQHcNGQipDzqsVNh26ZngRMEL/obnyH
         MEQKYSJ4eu5iRWtzULMXqzs+SgPpkbmBC8F8wl9kp0Gu5wCCdjTxqrAjW5rYpvF1ws
         VjzHqUfH9/kTGHG3yMNIyYhXfvm0Bm5GD6I5sGAiFAeoitt7dQ5REBIJ5nKxMVN/7S
         6a2TbxCUHYUpBEA1zWNJEwSemkT4zZJQuVbllReaw/32ZhH+0OJm8GdSnph+r1SV+/
         ledH0U4q+bU6Q==
Message-ID: <8eeac047a59667912a45b21050a6e4c57d7cccd5.camel@kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>, torvalds@linux-foundation.org,
        peterz@infradead.org, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jejb@linux.ibm.com, David.Kaplan@amd.com, bp@alien8.de,
        mingo@kernel.org, x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 10 Oct 2023 15:33:36 +0300
In-Reply-To: <20231006051801.423973-1-sumit.garg@linaro.org>
References: <20231006051801.423973-1-sumit.garg@linaro.org>
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

T24gRnJpLCAyMDIzLTEwLTA2IGF0IDEwOjQ4ICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOgo+IFN0
YXRpYyBjYWxscyBpbnZvY2F0aW9ucyBhcmVuJ3Qgd2VsbCBzdXBwb3J0ZWQgZnJvbSBtb2R1bGUg
X19pbml0IGFuZAo+IF9fZXhpdCBmdW5jdGlvbnMuIEVzcGVjaWFsbHkgdGhlIHN0YXRpYyBjYWxs
IGZyb20gY2xlYW51cF90cnVzdGVkKCkgbGVkCj4gdG8gYSBjcmFzaCBvbiB4ODYga2VybmVsIHdp
dGggQ09ORklHX0RFQlVHX1ZJUlRVQUw9eS4KPiAKPiBIb3dldmVyLCB0aGUgdXNhZ2Ugb2Ygc3Rh
dGljIGNhbGwgaW52b2NhdGlvbnMgZm9yIHRydXN0ZWRfa2V5X2luaXQoKQo+IGFuZCB0cnVzdGVk
X2tleV9leGl0KCkgZG9uJ3QgYWRkIGFueSB2YWx1ZSBmcm9tIGVpdGhlciBhIHBlcmZvcm1hbmNl
IG9yCj4gc2VjdXJpdHkgcGVyc3BlY3RpdmUuIEhlbmNlIHN3aXRjaCB0byB1c2UgaW5kaXJlY3Qg
ZnVuY3Rpb24gY2FsbHMgaW5zdGVhZC4KPiAKPiBOb3RlIGhlcmUgdGhhdCBhbHRob3VnaCBpdCB3
aWxsIGZpeCB0aGUgY3VycmVudCBjcmFzaCByZXBvcnQsIHVsdGltYXRlbHkKPiB0aGUgc3RhdGlj
IGNhbGwgaW5mcmFzdHJ1Y3R1cmUgc2hvdWxkIGJlIGZpeGVkIHRvIGVpdGhlciBzdXBwb3J0IGl0
cwo+IGZ1dHVyZSB1c2FnZSBmcm9tIG1vZHVsZSBfX2luaXQgYW5kIF9fZXhpdCBmdW5jdGlvbnMg
b3Igbm90Lgo+IAo+IFJlcG9ydGVkLWJ5OiBIeWVvbmdnb24gWW9vIDw0Mi5oeWV5b29AZ21haWwu
Y29tPgo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvWlJoS3E2ZTVuRiUyRjRa
SVYxQGZlZG9yYS8jdAo+IEZpeGVzOiA1ZDA2ODJiZTMxODkgKCJLRVlTOiB0cnVzdGVkOiBBZGQg
Z2VuZXJpYyB0cnVzdGVkIGtleXMgZnJhbWV3b3JrIikKPiBTaWduZWQtb2ZmLWJ5OiBTdW1pdCBH
YXJnIDxzdW1pdC5nYXJnQGxpbmFyby5vcmc+Cj4gLS0tCj4gCj4gQ2hhbmdlcyBpbiB2MjoKPiAt
IFBvbGlzaCBjb21taXQgbWVzc2FnZSBhcyBwZXIgY29tbWVudHMgZnJvbSBNaW1pCj4gCj4gwqBz
ZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX2NvcmUuYyB8IDEzICsrKysrLS0tLS0t
LS0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4g
Cj4gZGlmZiAtLWdpdCBhL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfY29yZS5j
IGIvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF9jb3JlLmMKPiBpbmRleCBjNmZj
NTBkNjcyMTQuLjg1ZmI1YzIyNTI5YSAxMDA2NDQKPiAtLS0gYS9zZWN1cml0eS9rZXlzL3RydXN0
ZWQta2V5cy90cnVzdGVkX2NvcmUuYwo+ICsrKyBiL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlz
L3RydXN0ZWRfY29yZS5jCj4gQEAgLTQ0LDEzICs0NCwxMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHRydXN0ZWRfa2V5X3NvdXJjZSB0cnVzdGVkX2tleV9zb3VyY2VzW10gPSB7Cj4gwqAjZW5kaWYK
PiDCoH07Cj4gwqAKPiAtREVGSU5FX1NUQVRJQ19DQUxMX05VTEwodHJ1c3RlZF9rZXlfaW5pdCwg
KnRydXN0ZWRfa2V5X3NvdXJjZXNbMF0ub3BzLT5pbml0KTsKPiDCoERFRklORV9TVEFUSUNfQ0FM
TF9OVUxMKHRydXN0ZWRfa2V5X3NlYWwsICp0cnVzdGVkX2tleV9zb3VyY2VzWzBdLm9wcy0+c2Vh
bCk7Cj4gwqBERUZJTkVfU1RBVElDX0NBTExfTlVMTCh0cnVzdGVkX2tleV91bnNlYWwsCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgKnRydXN0ZWRfa2V5
X3NvdXJjZXNbMF0ub3BzLT51bnNlYWwpOwo+IMKgREVGSU5FX1NUQVRJQ19DQUxMX05VTEwodHJ1
c3RlZF9rZXlfZ2V0X3JhbmRvbSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAqdHJ1c3RlZF9rZXlfc291cmNlc1swXS5vcHMtPmdldF9yYW5kb20pOwo+
IC1ERUZJTkVfU1RBVElDX0NBTExfTlVMTCh0cnVzdGVkX2tleV9leGl0LCAqdHJ1c3RlZF9rZXlf
c291cmNlc1swXS5vcHMtPmV4aXQpOwo+ICtzdGF0aWMgdm9pZCAoKnRydXN0ZWRfa2V5X2V4aXQp
KHZvaWQpOwo+IMKgc3RhdGljIHVuc2lnbmVkIGNoYXIgbWlncmF0YWJsZTsKPiDCoAo+IMKgZW51
bSB7Cj4gQEAgLTM1OSwxOSArMzU4LDE2IEBAIHN0YXRpYyBpbnQgX19pbml0IGluaXRfdHJ1c3Rl
ZCh2b2lkKQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFnZXRfcmFuZG9t
KQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdldF9y
YW5kb20gPSBrZXJuZWxfZ2V0X3JhbmRvbTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBzdGF0aWNfY2FsbF91cGRhdGUodHJ1c3RlZF9rZXlfaW5pdCwKPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRydXN0ZWRfa2V5X3NvdXJjZXNbaV0ub3BzLT5pbml0KTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHN0YXRpY19jYWxsX3VwZGF0ZSh0cnVzdGVkX2tleV9zZWFsLAo+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHRydXN0ZWRfa2V5X3NvdXJjZXNbaV0ub3BzLT5zZWFsKTsKPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoHN0YXRpY19jYWxsX3VwZGF0ZSh0cnVzdGVkX2tleV91bnNlYWws
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdHJ1c3RlZF9rZXlfc291cmNlc1tpXS5vcHMtPnVuc2VhbCk7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBzdGF0aWNfY2FsbF91cGRhdGUodHJ1c3RlZF9r
ZXlfZ2V0X3JhbmRvbSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfcmFuZG9tKTsKPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgc3RhdGljX2NhbGxfdXBkYXRlKHRydXN0ZWRfa2V5X2V4aXQsCj4g
LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+ZXhpdCk7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRydXN0ZWRfa2V5X2V4aXQgPSB0cnVzdGVkX2tleV9zb3Vy
Y2VzW2ldLm9wcy0+ZXhpdDsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1pZ3Jh
dGFibGUgPSB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+bWlncmF0YWJsZTsKPiDCoAo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBzdGF0aWNfY2FsbCh0cnVzdGVkX2tl
eV9pbml0KSgpOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSB0cnVzdGVk
X2tleV9zb3VyY2VzW2ldLm9wcy0+aW5pdCgpOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgaWYgKCFyZXQpCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgYnJlYWs7Cj4gwqDCoMKgwqDCoMKgwqDCoH0KPiBAQCAtMzg4LDcgKzM4NCw4IEBA
IHN0YXRpYyBpbnQgX19pbml0IGluaXRfdHJ1c3RlZCh2b2lkKQo+IMKgCj4gwqBzdGF0aWMgdm9p
ZCBfX2V4aXQgY2xlYW51cF90cnVzdGVkKHZvaWQpCj4gwqB7Cj4gLcKgwqDCoMKgwqDCoMKgc3Rh
dGljX2NhbGxfY29uZCh0cnVzdGVkX2tleV9leGl0KSgpOwo+ICvCoMKgwqDCoMKgwqDCoGlmICh0
cnVzdGVkX2tleV9leGl0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAoKnRydXN0
ZWRfa2V5X2V4aXQpKCk7Cj4gwqB9Cj4gwqAKPiDCoGxhdGVfaW5pdGNhbGwoaW5pdF90cnVzdGVk
KTsKCldvdWxkIGl0IGJlIGxlc3MgY29uZnVzaW5nIHRvIHJlcXVpcmUgdHJ1c3RlZF9rZXlfZXhp
dCBmcm9tIGVhY2g/CgpCUiwgSmFya2tvCgo=

