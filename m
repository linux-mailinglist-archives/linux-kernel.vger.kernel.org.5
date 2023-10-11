Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC797C503A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJKKeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjJKKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:34:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47E292;
        Wed, 11 Oct 2023 03:34:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2633C433C9;
        Wed, 11 Oct 2023 10:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697020471;
        bh=woX3nAzbZTdgFyiPGo2Qva6o8So5SbxPp6WMWELScOQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jLe9TQw1lcO96kxUQxZ19hVoRBeiPznOx6GgHnV4GMsbQKn40QG+/lef0alvzHiOd
         l9pIvo7lD/Hiel+zGVzmiraMA31Pxyz4/QWGw7usOQlAdm1ccCIgxICzGvg5TavCmn
         3aZ6rpja9xjWn8nfY0DvC7UI67SqKn02r9aMehe7jFVVYU0U5z8eWinfX5jd+5UUaE
         rpnpjMGUmTa7I7Iay+i1G3pehAtpeF18AY8H8qq4wAvlikFN+MN1qeKe2ac3LXSDP7
         Cbfoc5LR0LgYh69rwdNh960JNX/Pdmx9gTDY2+GoJmd6aME1LyDGtzxmMof8vRFIak
         7r7cUQJEEjXJA==
Message-ID: <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Rollback init_trusted() consistently
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Oct 2023 13:34:26 +0300
In-Reply-To: <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
References: <20231010231616.3122392-1-jarkko@kernel.org>
         <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
         <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyMDIzLTEwLTExIGF0IDEzOjEyICswMzAwLCBKYXJra28gU2Fra2luZW4gd3JvdGU6
Cj4gT24gV2VkLCAyMDIzLTEwLTExIGF0IDExOjI3ICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOgo+
ID4gT24gV2VkLCAxMSBPY3QgMjAyMyBhdCAwNDo0NiwgSmFya2tvIFNha2tpbmVuIDxqYXJra29A
a2VybmVsLm9yZz4gd3JvdGU6Cj4gPiA+IAo+ID4gPiBEbyBiaW5kIG5laXRoZXIgc3RhdGljIGNh
bGxzIG5vciB0cnVzdGVkX2tleV9leGl0KCkgYmVmb3JlIGEgc3VjY2Vzc2Z1bAo+ID4gPiBpbml0
LCBpbiBvcmRlciB0byBtYWludGFpbiBhIGNvbnNpc3RlbnQgc3RhdGUuIEluIGFkZGl0aW9uLCBk
ZXBhcnQgdGhlCj4gPiA+IGluaXRfdHJ1c3RlZCgpIGluIHRoZSBjYXNlIG9mIGEgcmVhbCBlcnJv
ciAoaS5lLiBnZXR0aW5nIGJhY2sgc29tZXRoaW5nCj4gPiA+IGVsc2UgdGhhbiAtRU5PREVWKS4K
PiA+ID4gCj4gPiA+IFJlcG9ydGVkLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgt
Zm91bmRhdGlvbi5vcmc+Cj4gPiA+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtaW50ZWdyaXR5L0NBSGstPXdoT1BvTGFXTThTOEdnb09QVDdhMituTUg1aDNUTEt0bj1SXzN3
NFIxX1V2Z0BtYWlsLmdtYWlsLmNvbS8KPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmfC
oCMgdjUuMTMrCj4gPiA+IEZpeGVzOiA1ZDA2ODJiZTMxODkgKCJLRVlTOiB0cnVzdGVkOiBBZGQg
Z2VuZXJpYyB0cnVzdGVkIGtleXMgZnJhbWV3b3JrIikKPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFy
a2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVsLm9yZz4KPiA+ID4gLS0tCj4gPiA+IMKgc2VjdXJp
dHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF9jb3JlLmMgfCAyMCArKysrKysrKysrLS0tLS0t
LS0tLQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkKPiA+ID4gCj4gPiA+IGRpZmYgLS1naXQgYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5
cy90cnVzdGVkX2NvcmUuYyBiL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfY29y
ZS5jCj4gPiA+IGluZGV4IDg1ZmI1YzIyNTI5YS4uZmVlMWFiMmM3MzRkIDEwMDY0NAo+ID4gPiAt
LS0gYS9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX2NvcmUuYwo+ID4gPiArKysg
Yi9zZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX2NvcmUuYwo+ID4gPiBAQCAtMzU4
LDE3ICszNTgsMTcgQEAgc3RhdGljIGludCBfX2luaXQgaW5pdF90cnVzdGVkKHZvaWQpCj4gPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIWdldF9yYW5kb20pCj4gPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ2V0X3JhbmRvbSA9
IGtlcm5lbF9nZXRfcmFuZG9tOwo+ID4gPiAKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RhdGljX2NhbGxfdXBkYXRlKHRydXN0ZWRfa2V5X3NlYWwsCj4gPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgdHJ1c3RlZF9rZXlfc291cmNlc1tpXS5vcHMtPnNlYWwpOwo+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdGF0aWNfY2FsbF91cGRhdGUodHJ1c3RlZF9rZXlfdW5zZWFsLAo+
ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHRydXN0ZWRfa2V5X3NvdXJjZXNbaV0ub3BzLT51bnNlYWwpOwo+ID4g
PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdGF0aWNfY2FsbF91cGRhdGUodHJ1c3Rl
ZF9rZXlfZ2V0X3JhbmRvbSwKPiA+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfcmFuZG9tKTsKPiA+ID4gLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdHJ1c3RlZF9rZXlfZXhpdCA9IHRydXN0ZWRfa2V5
X3NvdXJjZXNbaV0ub3BzLT5leGl0Owo+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBtaWdyYXRhYmxlID0gdHJ1c3RlZF9rZXlfc291cmNlc1tpXS5vcHMtPm1pZ3JhdGFibGU7Cj4g
PiA+IC0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldCA9IHRydXN0ZWRf
a2V5X3NvdXJjZXNbaV0ub3BzLT5pbml0KCk7Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmICghcmV0KQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
IXJldCkgewo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RhdGljX2NhbGxfdXBkYXRlKHRydXN0ZWRfa2V5X3NlYWwsIHRydXN0ZWRfa2V5X3NvdXJj
ZXNbaV0ub3BzLT5zZWFsKTsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHN0YXRpY19jYWxsX3VwZGF0ZSh0cnVzdGVkX2tleV91bnNlYWwsIHRydXN0
ZWRfa2V5X3NvdXJjZXNbaV0ub3BzLT51bnNlYWwpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdGljX2NhbGxfdXBkYXRlKHRydXN0ZWRfa2V5
X2dldF9yYW5kb20sIGdldF9yYW5kb20pOwo+ID4gPiArCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0cnVzdGVkX2tleV9leGl0ID0gdHJ1c3RlZF9r
ZXlfc291cmNlc1tpXS5vcHMtPmV4aXQ7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBtaWdyYXRhYmxlID0gdHJ1c3RlZF9rZXlfc291cmNlc1tpXS5v
cHMtPm1pZ3JhdGFibGU7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA+
ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJldCB8fCByZXQg
IT0gLUVOT0RFVikKPiA+IAo+ID4gQXMgbWVudGlvbmVkIGluIHRoZSBvdGhlciB0aHJlYWQsIHdl
IHNob3VsZCBhbGxvdyBvdGhlciB0cnVzdCBzb3VyY2VzCj4gPiB0byBiZSBpbml0aWFsaXplZCBp
ZiB0aGUgcHJpbWFyeSBvbmUgZmFpbHMuCj4gCj4gSSBzZW50IHRoZSBwYXRjaCBiZWZvcmUgSSBy
ZWNlaXZlZCB0aGF0IHJlc3BvbnNlIGJ1dCBoZXJlJ3Mgd2hhdCB5b3UKPiB3cm90ZToKPiAKPiAi
V2Ugc2hvdWxkIGdpdmUgb3RoZXIgdHJ1c3Qgc291cmNlcyBhIGNoYW5jZSB0byByZWdpc3RlciBm
b3IgdHJ1c3RlZAo+IGtleXMgaWYgdGhlIHByaW1hcnkgb25lIGZhaWxzLiIKPiAKPiAxLiBUaGlz
IGNvbmRpdGlvbiBpcyBsYWNraW5nIGFuIGlubGluZSBjb21tZW50Lgo+IDIuIE5laXRoZXIgdGhp
cyByZXNwb25zZSBvciB0aGUgb25lIHRoYXQgeW91IHBvaW50ZWQgb3V0IGhhcyBhbnkKPiDCoMKg
IGV4cGxhbmF0aW9uIHdoeSBmb3IgYW55IHN5c3RlbSBmYWlsdXJlIHRoZSBwcm9jZXNzIHNob3Vs
ZAo+IMKgwqAgY29udGludWUuCj4gCj4gWW91IHNob3VsZCByZWFsbHkga25vdyB0aGUgc2l0dWF0
aW9ucyAoZS5nLiBsaXN0IG9mIHBvc2l4IGVycm9yCj4gY29kZSkgd2hlbiB0aGUgcHJvY2VzcyBj
YW4gY29udGludWUgYW5kICJhbGxvdyBsaXN0IiB0aG9zZS4gVGhpcwo+IHdheSB3YXkgdG9vIGFi
c3RyYWN0LiBJdCBjYW5ub3QgYmUgbGV0IGFsbCBwb3NzaWJsZSBzeXN0ZW0gZmFpbHVyZXMKPiBw
YXNzLgoKQW5kIGl0IHdvdWxkIG5pY2UgaWYgaXQgcHJpbnRlZCBvdXQgc29tZXRoaW5nIGZvciBs
ZWdpdCBjYXNlcy4gTGlrZQoibm8gZGV2aWNlIGZvdW5kIiBldGMuIEFuZCBmb3IgcmVzdCBpdCBt
dXN0IHJlYWxseSB3aXRoZHJhdyB0aGUgd2hvbGUKcHJvY2Vzcy4KCkJSLCBKYXJra28K

