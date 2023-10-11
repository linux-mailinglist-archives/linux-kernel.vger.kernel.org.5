Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1C17C4FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbjJKKMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjJKKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:12:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B33A4;
        Wed, 11 Oct 2023 03:12:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED25EC433C8;
        Wed, 11 Oct 2023 10:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697019127;
        bh=0ArQgzQ4dKVLY9l4ESHcxBl/89hy5GRkTw8PcjI+eQk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YVcO2DJPQ9FTgBiId6sWJhnpSYL3fO9MPn+hFyaRMESm+qo/ahgZglNFumE8XK/fW
         Wh99gFk5q6vG4BA/7/YE0YoTLsQUCoqks8u/xatRA4PtvLwoc3YDR4tY/oCu02FIES
         bK2TpLMCVfdrQQ2MCrAg/Uo6Q6gpoHoUTTDbMClABDIoA2MokI775YsQzrKV2Ys0m3
         SCRZ75iTQJe4UGG+fU70j/ypbc0WP3MEwFNELjJiKR78do+IsatvoqIZa8msLZa+eO
         t+h0kzh+9NRXCfaLEYoD9JRusXorC1+/AM/vLGYC8pvor9ocdbWHhiX3bHvxXCeZ+2
         FHyYnsFDfJt2A==
Message-ID: <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
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
Date:   Wed, 11 Oct 2023 13:12:02 +0300
In-Reply-To: <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
References: <20231010231616.3122392-1-jarkko@kernel.org>
         <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
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

T24gV2VkLCAyMDIzLTEwLTExIGF0IDExOjI3ICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOgo+IE9u
IFdlZCwgMTEgT2N0IDIwMjMgYXQgMDQ6NDYsIEphcmtrbyBTYWtraW5lbiA8amFya2tvQGtlcm5l
bC5vcmc+IHdyb3RlOgo+ID4gCj4gPiBEbyBiaW5kIG5laXRoZXIgc3RhdGljIGNhbGxzIG5vciB0
cnVzdGVkX2tleV9leGl0KCkgYmVmb3JlIGEgc3VjY2Vzc2Z1bAo+ID4gaW5pdCwgaW4gb3JkZXIg
dG8gbWFpbnRhaW4gYSBjb25zaXN0ZW50IHN0YXRlLiBJbiBhZGRpdGlvbiwgZGVwYXJ0IHRoZQo+
ID4gaW5pdF90cnVzdGVkKCkgaW4gdGhlIGNhc2Ugb2YgYSByZWFsIGVycm9yIChpLmUuIGdldHRp
bmcgYmFjayBzb21ldGhpbmcKPiA+IGVsc2UgdGhhbiAtRU5PREVWKS4KPiA+IAo+ID4gUmVwb3J0
ZWQtYnk6IExpbnVzIFRvcnZhbGRzIDx0b3J2YWxkc0BsaW51eC1mb3VuZGF0aW9uLm9yZz4KPiA+
IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW50ZWdyaXR5L0NBSGstPXdo
T1BvTGFXTThTOEdnb09QVDdhMituTUg1aDNUTEt0bj1SXzN3NFIxX1V2Z0BtYWlsLmdtYWlsLmNv
bS8KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnwqAjIHY1LjEzKwo+ID4gRml4ZXM6IDVk
MDY4MmJlMzE4OSAoIktFWVM6IHRydXN0ZWQ6IEFkZCBnZW5lcmljIHRydXN0ZWQga2V5cyBmcmFt
ZXdvcmsiKQo+ID4gU2lnbmVkLW9mZi1ieTogSmFya2tvIFNha2tpbmVuIDxqYXJra29Aa2VybmVs
Lm9yZz4KPiA+IC0tLQo+ID4gwqBzZWN1cml0eS9rZXlzL3RydXN0ZWQta2V5cy90cnVzdGVkX2Nv
cmUuYyB8IDIwICsrKysrKysrKystLS0tLS0tLS0tCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAxMCBp
bnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL3NlY3Vy
aXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfY29yZS5jIGIvc2VjdXJpdHkva2V5cy90cnVz
dGVkLWtleXMvdHJ1c3RlZF9jb3JlLmMKPiA+IGluZGV4IDg1ZmI1YzIyNTI5YS4uZmVlMWFiMmM3
MzRkIDEwMDY0NAo+ID4gLS0tIGEvc2VjdXJpdHkva2V5cy90cnVzdGVkLWtleXMvdHJ1c3RlZF9j
b3JlLmMKPiA+ICsrKyBiL3NlY3VyaXR5L2tleXMvdHJ1c3RlZC1rZXlzL3RydXN0ZWRfY29yZS5j
Cj4gPiBAQCAtMzU4LDE3ICszNTgsMTcgQEAgc3RhdGljIGludCBfX2luaXQgaW5pdF90cnVzdGVk
KHZvaWQpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFnZXRfcmFuZG9t
KQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRf
cmFuZG9tID0ga2VybmVsX2dldF9yYW5kb207Cj4gPiAKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHN0YXRpY19jYWxsX3VwZGF0ZSh0cnVzdGVkX2tleV9zZWFsLAo+ID4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+c2VhbCk7Cj4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBzdGF0aWNfY2FsbF91cGRhdGUodHJ1c3RlZF9rZXlfdW5zZWFsLAo+
ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+dW5zZWFsKTsKPiA+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXRpY19jYWxsX3VwZGF0ZSh0cnVzdGVkX2tl
eV9nZXRfcmFuZG9tLAo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnZXRfcmFuZG9tKTsKPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHRydXN0ZWRfa2V5X2V4aXQgPSB0cnVzdGVkX2tleV9zb3VyY2Vz
W2ldLm9wcy0+ZXhpdDsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG1pZ3JhdGFi
bGUgPSB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+bWlncmF0YWJsZTsKPiA+IC0KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSB0cnVzdGVkX2tleV9zb3VyY2VzW2ld
Lm9wcy0+aW5pdCgpOwo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFyZXQp
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIXJldCkgewo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0YXRpY19jYWxsX3VwZGF0
ZSh0cnVzdGVkX2tleV9zZWFsLCB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+c2VhbCk7Cj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RhdGljX2Nh
bGxfdXBkYXRlKHRydXN0ZWRfa2V5X3Vuc2VhbCwgdHJ1c3RlZF9rZXlfc291cmNlc1tpXS5vcHMt
PnVuc2VhbCk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RhdGljX2NhbGxfdXBkYXRlKHRydXN0ZWRfa2V5X2dldF9yYW5kb20sIGdldF9yYW5kb20p
Owo+ID4gKwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHRydXN0ZWRfa2V5X2V4aXQgPSB0cnVzdGVkX2tleV9zb3VyY2VzW2ldLm9wcy0+ZXhpdDsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtaWdyYXRhYmxl
ID0gdHJ1c3RlZF9rZXlfc291cmNlc1tpXS5vcHMtPm1pZ3JhdGFibGU7Cj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoIXJldCB8fCByZXQgIT0gLUVOT0RFVikKPiAKPiBBcyBtZW50aW9uZWQgaW4gdGhl
IG90aGVyIHRocmVhZCwgd2Ugc2hvdWxkIGFsbG93IG90aGVyIHRydXN0IHNvdXJjZXMKPiB0byBi
ZSBpbml0aWFsaXplZCBpZiB0aGUgcHJpbWFyeSBvbmUgZmFpbHMuCgpJIHNlbnQgdGhlIHBhdGNo
IGJlZm9yZSBJIHJlY2VpdmVkIHRoYXQgcmVzcG9uc2UgYnV0IGhlcmUncyB3aGF0IHlvdQp3cm90
ZToKCiJXZSBzaG91bGQgZ2l2ZSBvdGhlciB0cnVzdCBzb3VyY2VzIGEgY2hhbmNlIHRvIHJlZ2lz
dGVyIGZvciB0cnVzdGVkCmtleXMgaWYgdGhlIHByaW1hcnkgb25lIGZhaWxzLiIKCjEuIFRoaXMg
Y29uZGl0aW9uIGlzIGxhY2tpbmcgYW4gaW5saW5lIGNvbW1lbnQuCjIuIE5laXRoZXIgdGhpcyBy
ZXNwb25zZSBvciB0aGUgb25lIHRoYXQgeW91IHBvaW50ZWQgb3V0IGhhcyBhbnkKICAgZXhwbGFu
YXRpb24gd2h5IGZvciBhbnkgc3lzdGVtIGZhaWx1cmUgdGhlIHByb2Nlc3Mgc2hvdWxkCiAgIGNv
bnRpbnVlLgoKWW91IHNob3VsZCByZWFsbHkga25vdyB0aGUgc2l0dWF0aW9ucyAoZS5nLiBsaXN0
IG9mIHBvc2l4IGVycm9yCmNvZGUpIHdoZW4gdGhlIHByb2Nlc3MgY2FuIGNvbnRpbnVlIGFuZCAi
YWxsb3cgbGlzdCIgdGhvc2UuIFRoaXMKd2F5IHdheSB0b28gYWJzdHJhY3QuIEl0IGNhbm5vdCBi
ZSBsZXQgYWxsIHBvc3NpYmxlIHN5c3RlbSBmYWlsdXJlcwpwYXNzLgoKQ2FuIHlvdSBlLmcuIGV4
cGxhaW4gYSBsZWdpdCB1c2UgY2FzZSB3aGVuIHNvbWV0aGluZyBlbHNlIGlzCnJldHVybmVkIHRo
YW4gLUVOT0RFViBidXQgaXQgaXMgY29vbCBhbmQgd2UgY2FuIGNvbnRpbnVlIGluIApzb21lIHJl
YWwgd29ybGQgdXNlIGNhc2U/CgpCUiwgSmFya2tvCg==

