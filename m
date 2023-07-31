Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE10F769737
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 15:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbjGaNK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 09:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjGaNKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 09:10:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81362A0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 06:10:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 36D6B1F74C;
        Mon, 31 Jul 2023 13:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690809022; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wcbaQg4/dqxK6MuQ0th0oR/TR1mGTvs9EhhnSOJmTF0=;
        b=RwrCS+uVvS3SwFdx4mwsR2gqg2VR4OW87xUNKzZZ9aqkNgh3HZfKaDZP0q8Ds43F5eyKed
        hKs627Kn1WCM7OrfvbujUwK5mQCRxPzsffhlHqNfBj02nrIC/NoT+6nhFTLkKwNi8POnKX
        MxYcSMrigcN+az7UB/7c6tD6WrgoPDc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3327133F7;
        Mon, 31 Jul 2023 13:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SOz7Mb2yx2SGMAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 31 Jul 2023 13:10:21 +0000
Message-ID: <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com>
Date:   Mon, 31 Jul 2023 15:10:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
Content-Language: en-US
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
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <87v8e0nskd.ffs@tglx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DNdklLoONX907bjG9QoVWyCy"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DNdklLoONX907bjG9QoVWyCy
Content-Type: multipart/mixed; boundary="------------4zswmoDPIWE6q92YmJ2w6Oid";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
In-Reply-To: <87v8e0nskd.ffs@tglx>

--------------4zswmoDPIWE6q92YmJ2w6Oid
Content-Type: multipart/mixed; boundary="------------LhJcVauKQYpSdQsS7AfQ0d4c"

--------------LhJcVauKQYpSdQsS7AfQ0d4c
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDcuMjMgMTU6MDEsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gTW9uLCBK
dWwgMzEgMjAyMyBhdCAxMzozMSwgSnVlcmdlbiBHcm9zcyB3cm90ZToNCj4+IE9uIDI0LjA3
LjIzIDE1OjM1LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4gICAgc3RhdGljIHZvaWQg
X19pbml0IHhlbl9hcGljX2NoZWNrKHZvaWQpDQo+Pj4gICAgew0KPj4+IC0JaWYgKGFwaWMg
PT0gJnhlbl9wdl9hcGljKQ0KPj4+IC0JCXJldHVybjsNCj4+PiAtDQo+Pj4gLQlwcl9pbmZv
KCJTd2l0Y2hlZCBBUElDIHJvdXRpbmcgZnJvbSAlcyB0byAlcy5cbiIsIGFwaWMtPm5hbWUs
DQo+Pj4gLQkJeGVuX3B2X2FwaWMubmFtZSk7DQo+Pj4gLQlhcGljID0gJnhlbl9wdl9hcGlj
Ow0KPj4+ICsJYXBpY19pbnN0YWxsX2RyaXZlcigmeGVuX3B2X2FwaWMpOw0KPj4+ICAgIH0N
Cj4+PiArDQo+Pj4gICAgdm9pZCBfX2luaXQgeGVuX2luaXRfYXBpYyh2b2lkKQ0KPj4+ICAg
IHsNCj4+PiAgICAJeDg2X2FwaWNfb3BzLmlvX2FwaWNfcmVhZCA9IHhlbl9pb19hcGljX3Jl
YWQ7DQo+Pj4gICAgCS8qIE9uIFBWIGd1ZXN0cyB0aGUgQVBJQyBDUFVJRCBiaXQgaXMgZGlz
YWJsZWQgc28gbm9uZSBvZiB0aGUNCj4+PiAgICAJICogcm91dGluZXMgZW5kIHVwIGV4ZWN1
dGluZy4gKi8NCj4+PiAgICAJaWYgKCF4ZW5faW5pdGlhbF9kb21haW4oKSkNCj4+PiAtCQlh
cGljID0gJnhlbl9wdl9hcGljOw0KPj4+ICsJCWFwaWNfaW5zdGFsbF9kcml2ZXIoJnhlbl9w
dl9hcGljKTsNCj4+DQo+PiBUaGlzIGlzIHdvcmtpbmcsIGJ1dCBpdCBwcm9kdWNlcyBhIFdB
Uk4oKSBzcGxhdCB3aGVuIGJvb3RpbmcgYXMgYW4gdW5wcml2aWxlZ2VkDQo+PiBYZW4gUFYg
Z3Vlc3QgZnJvbSBzdGF0aWNfY2FsbCBwYXRjaGluZyAoc3RhdGljX2NhbGxfaW5pdCgpIGhh
c24ndCBiZWVuIGNhbGxlZA0KPj4geWV0KS4NCj4gDQo+IER1aCwgeWVzLiBJdCdzIHRvbyBl
YXJseS4NCj4gDQo+PiBUaGUgZGlmZiBiZWxvdyBvbiB0b3AgaXMgZml4aW5nIHRoZSBpc3N1
ZToNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYveGVuL2FwaWMuYyBiL2FyY2gveDg2
L3hlbi9hcGljLmMNCj4+IGluZGV4IDE4MzhhZWZjNjMyZi4uODRmMjQyNjg2NzBiIDEwMDY0
NA0KPj4gLS0tIGEvYXJjaC94ODYveGVuL2FwaWMuYw0KPj4gKysrIGIvYXJjaC94ODYveGVu
L2FwaWMuYw0KPj4gQEAgLTE2MywxNCArMTYzLDE4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB4
ZW5fYXBpY19jaGVjayh2b2lkKQ0KPj4gICAgICAgICAgIGFwaWNfaW5zdGFsbF9kcml2ZXIo
Jnhlbl9wdl9hcGljKTsNCj4+ICAgIH0NCj4+DQo+PiArdm9pZCBfX2luaXQgeGVuX2FwaWNf
aW5zdGFsbCh2b2lkKQ0KPj4gK3sNCj4+ICsgICAgICAgLyoNCj4+ICsgICAgICAgICogT24g
UFYgZ3Vlc3RzIHRoZSBBUElDIENQVUlEIGJpdCBpcyBkaXNhYmxlZCBzbyBub25lIG9mIHRo
ZQ0KPj4gKyAgICAgICAgKiByb3V0aW5lcyBlbmQgdXAgZXhlY3V0aW5nLg0KPj4gKyAgICAg
ICAgKi8NCj4+ICsgICAgICAgYXBpY19pbnN0YWxsX2RyaXZlcigmeGVuX3B2X2FwaWMpOw0K
Pj4gK30NCj4+ICsNCj4+ICAgIHZvaWQgX19pbml0IHhlbl9pbml0X2FwaWModm9pZCkNCj4+
ICAgIHsNCj4+ICAgICAgICAgICB4ODZfYXBpY19vcHMuaW9fYXBpY19yZWFkID0geGVuX2lv
X2FwaWNfcmVhZDsNCj4+IC0gICAgICAgLyogT24gUFYgZ3Vlc3RzIHRoZSBBUElDIENQVUlE
IGJpdCBpcyBkaXNhYmxlZCBzbyBub25lIG9mIHRoZQ0KPj4gLSAgICAgICAgKiByb3V0aW5l
cyBlbmQgdXAgZXhlY3V0aW5nLiAqLw0KPj4gLSAgICAgICBpZiAoIXhlbl9pbml0aWFsX2Rv
bWFpbigpKQ0KPj4gLSAgICAgICAgICAgICAgIGFwaWNfaW5zdGFsbF9kcml2ZXIoJnhlbl9w
dl9hcGljKTsNCj4+IC0NCj4+ICAgICAgICAgICB4ODZfcGxhdGZvcm0uYXBpY19wb3N0X2lu
aXQgPSB4ZW5fYXBpY19jaGVjazsNCj4+ICAgIH0NCj4+ICAgIGFwaWNfZHJpdmVyKHhlbl9w
dl9hcGljKTsNCj4gDQo+IEkgd29uZGVyIHdoZXRoZXIgdGhpcyBleHBsaWNpdCBpbnN0YWxs
IGlzIGFjdHVhbGx5IG5lZWRlZCBhdCBhbGwuDQo+IFNob3VsZG4ndCB0aGUgZHJpdmVyIGJl
IGluc3RhbGxlZCB2aWEgdGhlIEFQSUMgcHJvYmluZyBtZWNoYW5pc20NCj4gYXV0b21hZ2lj
YWxseT8NCg0KT25seSBpbiBjYXNlIHg4Nl9pbml0LmlycS5pbnRyX21vZGVfaW5pdCBpcyBz
ZXQgYXBwcm9wcmlhdGVseS4gVG9kYXkgaXQgaXMNCmEgbm9wIGZvciBYZW4gUFYsIGJ1dCB0
aGF0IGNhbiBiZSBjaGFuZ2VkLiBJJ2xsIGhhdmUgYSBsb29rLg0KDQoNCkp1ZXJnZW4NCg==

--------------LhJcVauKQYpSdQsS7AfQ0d4c
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------LhJcVauKQYpSdQsS7AfQ0d4c--

--------------4zswmoDPIWE6q92YmJ2w6Oid--

--------------DNdklLoONX907bjG9QoVWyCy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTHsr0FAwAAAAAACgkQsN6d1ii/Ey9S
8wf+Mhfdd5I8iDlJdKOjlS6f5Ac2U9cytlwIvYro/7pdFhqpAWXXVT++6M23a6UPin0nCcCTj3/N
0XerwnzY7mSbDHD1Z5wp1sXljmqwr8MiKWxSGMkfJLOMG9rVADzabjpV4ui5keIXmf+7SZok19kf
Nx6cZw9zHUQtlLNCCZONSKUa8VSTUeMrK4CQweoWY9LpXMq+g/GZ75KfUx1BDZAcclTML/68dYyw
UbzDg5fI2YhvntTBhAJucM5kxxwr5h8eBvvP1l9fBQqDDvD5OSx30jeMqnsGzFUxo4+Erd1h+IU7
ZF5+Z/4itO8ac+FGH7tqguqD9Cx9MnBWGzzSlMLCZw==
=u+Ml
-----END PGP SIGNATURE-----

--------------DNdklLoONX907bjG9QoVWyCy--
