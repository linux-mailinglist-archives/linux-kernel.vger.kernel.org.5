Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A177692E4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231757AbjGaKRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbjGaKRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:17:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C74E5B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:17:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 455E31F74B;
        Mon, 31 Jul 2023 10:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690798630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o7E7AG6V+H9uXj00mZ/zg9yul7kcIzbZKz1pk8qwM2U=;
        b=WXfhjW+P0JW9ibpUdi5nlWpssQRy6833k6eyeF9FHy4pmLHmVHGgscz2nHPiIhHLxIfafV
        N3nvn/AtBrlJE8MEUjLFizhvpPUz9Ly+vb3joKLjEgakuyRcTCPNyr4ecFIVUsbY6N3msK
        OROepi/MZgzPP3EEuhBzo3VmgAlqvko=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E54B6133F7;
        Mon, 31 Jul 2023 10:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FoG3NiWKx2Q1VQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 31 Jul 2023 10:17:09 +0000
Message-ID: <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com>
Date:   Mon, 31 Jul 2023 12:17:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch V2 16/58] x86/apic: Sanitize num_processors handling
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20230724131206.500814398@linutronix.de>
 <20230724132045.555787669@linutronix.de>
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230724132045.555787669@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------QreWLrnDs2Ciw7NwrqtdTzIf"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------QreWLrnDs2Ciw7NwrqtdTzIf
Content-Type: multipart/mixed; boundary="------------z8jpxiEEXSjIcGxr3OxTVhvR";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com>
Subject: Re: [patch V2 16/58] x86/apic: Sanitize num_processors handling
References: <20230724131206.500814398@linutronix.de>
 <20230724132045.555787669@linutronix.de>
In-Reply-To: <20230724132045.555787669@linutronix.de>

--------------z8jpxiEEXSjIcGxr3OxTVhvR
Content-Type: multipart/mixed; boundary="------------oCn939xV0v7H2I6SyWYhZv6s"

--------------oCn939xV0v7H2I6SyWYhZv6s
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDcuMjMgMTU6MzQsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gbnVtX3Byb2Nl
c3NvcnMgaXMgMCBieSBkZWZhdWx0IGFuZCBvbmx5IGdldHMgaW5jcmVtZW50ZWQgd2hlbiBs
b2NhbCBBUElDcw0KPiBhcmUgcmVnaXN0ZXJlZC4NCj4gDQo+IE1ha2UgaW5pdF9hcGljX21h
cHBpbmdzKCksIHdoaWNoIHRyaWVzIHRvIGVuYWJsZSB0aGUgbG9jYWwgQVBJQyBpbiB0aGUg
Y2FzZQ0KPiB0aGF0IG5vIFNNUCBjb25maWd1cmF0aW9uIHdhcyBmb3VuZCBzZXQgbnVtX3By
b2Nlc3NvcnMgdG8gMS4NCj4gDQo+IFRoaXMgYWxsb3dzIHRvIHJlbW92ZSB5ZXQgYW5vdGhl
ciBjaGVjayBmb3IgdGhlIGxvY2FsIEFQSUMgYW5kIHlldCBhbm90aGVyDQo+IHBsYWNlIHdo
aWNoIHJlZ2lzdGVycyB0aGUgYm9vdCBDUFVzIGxvY2FsIEFQSUMgSUQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4NCj4gQWNr
ZWQtYnk6IFBldGVyIFppamxzdHJhIChJbnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPg0K
PiAtLS0NCj4gICBhcmNoL3g4Ni9rZXJuZWwvYXBpYy9hcGljLmMgfCAgICA5ICsrKysrKy0t
LQ0KPiAgIGFyY2gveDg2L2tlcm5lbC9zbXBib290LmMgICB8ICAgMTggLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIxIGRlbGV0
aW9ucygtKQ0KPiANCj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpYy5jDQo+ICsr
KyBiL2FyY2gveDg2L2tlcm5lbC9hcGljL2FwaWMuYw0KPiBAQCAtMjEzMCw5ICsyMTMwLDEy
IEBAIHZvaWQgX19pbml0IGluaXRfYXBpY19tYXBwaW5ncyh2b2lkKQ0KPiAgIAlpZiAoeDJh
cGljX21vZGUpDQo+ICAgCQlyZXR1cm47DQo+ICAgDQo+IC0JaWYgKCFzbXBfZm91bmRfY29u
ZmlnICYmICFkZXRlY3RfaW5pdF9BUElDKCkpIHsNCj4gLQkJcHJfaW5mbygiQVBJQzogZGlz
YWJsZSBhcGljIGZhY2lsaXR5XG4iKTsNCj4gLQkJYXBpY19kaXNhYmxlKCk7DQo+ICsJaWYg
KCFzbXBfZm91bmRfY29uZmlnKSB7DQo+ICsJCWlmICghZGV0ZWN0X2luaXRfQVBJQygpKSB7
DQo+ICsJCQlwcl9pbmZvKCJBUElDOiBkaXNhYmxlIGFwaWMgZmFjaWxpdHlcbiIpOw0KPiAr
CQkJYXBpY19kaXNhYmxlKCk7DQo+ICsJCX0NCj4gKwkJbnVtX3Byb2Nlc3NvcnMgPSAxOw0K
PiAgIAl9DQo+ICAgfQ0KPiAgIA0KDQpUaGlzIGlzIGludHJvZHVjaW5nIGEgcmVncmVzc2lv
biBmb3IgWGVuIFBWIGd1ZXN0czogdGhvc2UgaGF2ZSBubyBBQ1BJDQp0YWJsZXMsIHNvIHNt
cF9mb3VuZF9jb25maWcgd2lsbCBiZSAwLiBPVE9IIG51bV9wcm9jZXNzb3JzIGhhcyBiZWVu
IHNldA0KYWxyZWFkeSB1c2luZyBoeXBlcnZpc29yIGRhdGEsIHNvIHNldHRpbmcgbnVtX3By
b2Nlc3NvcnMgdG8gMSBoZXJlIHdpbGwNCm92ZXJ3cml0ZSB0aGUgcHJldmlvdXMgc2V0dGlu
Zy4NCg0KQmVsb3cgZGlmZiBvbiB0b3AgaXMgZml4aW5nIHRoZSBwcm9ibGVtOg0KDQpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL2FwaWMvYXBpYy5jIGIvYXJjaC94ODYva2VybmVs
L2FwaWMvYXBpYy5jDQppbmRleCA1NjRkNTg0YzhiOTkuLjU5YzEyYjIwYzYzNSAxMDA2NDQN
Ci0tLSBhL2FyY2gveDg2L2tlcm5lbC9hcGljL2FwaWMuYw0KKysrIGIvYXJjaC94ODYva2Vy
bmVsL2FwaWMvYXBpYy5jDQpAQCAtMjEzNSw3ICsyMTM1LDEzIEBAIHZvaWQgX19pbml0IGlu
aXRfYXBpY19tYXBwaW5ncyh2b2lkKQ0KICAgICAgICAgICAgICAgICAgICAgICAgIHByX2lu
Zm8oIkFQSUM6IGRpc2FibGUgYXBpYyBmYWNpbGl0eVxuIik7DQogICAgICAgICAgICAgICAg
ICAgICAgICAgYXBpY19kaXNhYmxlKCk7DQogICAgICAgICAgICAgICAgIH0NCi0gICAgICAg
ICAgICAgICBudW1fcHJvY2Vzc29ycyA9IDE7DQorDQorICAgICAgICAgICAgICAgLyoNCisg
ICAgICAgICAgICAgICAgKiBVbnByaXZpbGVnZWQgWGVuIFBWIGd1ZXN0cyBoYXZlIHNtcF9m
b3VuZF9jb25maWcgPSAwLCBidXQNCisgICAgICAgICAgICAgICAgKiB0aGV5IGhhdmUgc2V0
IG51bV9wcm9jZXNzb3JzIGFscmVhZHkgZnJvbSBoeXBlcnZpc29yIGRhdGEuDQorICAgICAg
ICAgICAgICAgICovDQorICAgICAgICAgICAgICAgaWYgKCFudW1fcHJvY2Vzc29ycykNCisg
ICAgICAgICAgICAgICAgICAgICAgIG51bV9wcm9jZXNzb3JzID0gMTsNCiAgICAgICAgIH0N
CiAgfQ0KDQoNCkp1ZXJnZW4NCg==
--------------oCn939xV0v7H2I6SyWYhZv6s
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------oCn939xV0v7H2I6SyWYhZv6s--

--------------z8jpxiEEXSjIcGxr3OxTVhvR--

--------------QreWLrnDs2Ciw7NwrqtdTzIf
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTHiiUFAwAAAAAACgkQsN6d1ii/Ey9p
0wf+J+y73XZ0sKMJm+uTHtqhHSHqry9IYtpdqY6v2Gd83xLWheMGKb2zNzng9lTwFjT2vZK0Xcrf
hCndNNnTdTsg2Vdach0Bz1/eiEAnt1Z0KNCFoKVbtz131h8MHopUjfej9w9NSxzpTxVYPjHx9KzV
odax79buX1uBtbVD22wollizB7qm3aOe/jaIR4Ykb2qJCgcSWQRp/8MxllxXsY1IHrkmQ6fD7VB/
BhHPne92bAPIEJgxN9ydaAZdGTY1A+l5uXmDjRT3Pt+V6ArhCeXRCnbBJyGYEgH+Lj7Csq2k3L6I
W1nSRCvjMoDOmrWjsrg0PiUy/bpKnUvNO3EPaDKnmA==
=1CvN
-----END PGP SIGNATURE-----

--------------QreWLrnDs2Ciw7NwrqtdTzIf--
