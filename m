Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF09076A9C1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjHAHIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHAHIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:08:20 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EF41716
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:08:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 00A351F6E6;
        Tue,  1 Aug 2023 07:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690873698; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AoBXTXyuz+vRPhe5JwPsPpzufyYSV/OzkOaqo4WkjFA=;
        b=r7kZE6EoEuUirA3VBp7HBmFqszSmxp1duPgOPBWef0XH/dhZzpIOy8N99/EvpHmjPLk9OD
        7z9IpC9+lDaf0jF45yKy2OzctiyaNLIjQKSAoWapfHJtlCxmJ0wiV09IiIAp4k7MYFZPP3
        T6D5BlnF5SAZZwop1r52oIonts3mrYE=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2ADE13919;
        Tue,  1 Aug 2023 07:08:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G4dEJmGvyGSjdwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 01 Aug 2023 07:08:17 +0000
Message-ID: <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com>
Date:   Tue, 1 Aug 2023 09:08:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
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
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx> <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
In-Reply-To: <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------jpBGtiV3OGo6AolawpkxNu4A"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------jpBGtiV3OGo6AolawpkxNu4A
Content-Type: multipart/mixed; boundary="------------gasiVRhyhJm0FBJ084iNFdjy";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <f0d5b71b-4344-2f35-03ee-3af6ebd038b2@suse.com>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx> <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
In-Reply-To: <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>

--------------gasiVRhyhJm0FBJ084iNFdjy
Content-Type: multipart/mixed; boundary="------------7VGKm0nFMg0nts76TS09Lrr3"

--------------7VGKm0nFMg0nts76TS09Lrr3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDguMjMgMDg6NDksIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDAxLjA4LjIz
IDA4OjQxLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+PiBPbiBNb24sIEp1bCAzMSAyMDIz
IGF0IDE3OjQ4LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pg0KPj4+IE9uIE1vbiwgSnVs
IDMxIDIwMjMgYXQgMTU6MTAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4+IE9uIDMxLjA3
LjIzIDE1OjAxLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4+Pj4gwqDCoMKgIGFwaWNf
ZHJpdmVyKHhlbl9wdl9hcGljKTsNCj4+Pj4+DQo+Pj4+PiBJIHdvbmRlciB3aGV0aGVyIHRo
aXMgZXhwbGljaXQgaW5zdGFsbCBpcyBhY3R1YWxseSBuZWVkZWQgYXQgYWxsLg0KPj4+Pj4g
U2hvdWxkbid0IHRoZSBkcml2ZXIgYmUgaW5zdGFsbGVkIHZpYSB0aGUgQVBJQyBwcm9iaW5n
IG1lY2hhbmlzbQ0KPj4+Pj4gYXV0b21hZ2ljYWxseT8NCj4+Pj4NCj4+Pj4gT25seSBpbiBj
YXNlIHg4Nl9pbml0LmlycS5pbnRyX21vZGVfaW5pdCBpcyBzZXQgYXBwcm9wcmlhdGVseS4g
VG9kYXkgaXQgaXMNCj4+Pj4gYSBub3AgZm9yIFhlbiBQViwgYnV0IHRoYXQgY2FuIGJlIGNo
YW5nZWQuIEknbGwgaGF2ZSBhIGxvb2suDQo+Pj4NCj4+PiBZb3UgY291bGQgc2ltcGx5IHNl
dCB0aGF0IGNhbGxiYWNrIHRvIGRlZmF1bHRfc2V0dXBfYXBpY19yb3V0aW5nKCkgYW5kDQo+
Pj4gYmUgZG9uZSB3aXRoIGl0Lg0KPj4NCj4+IERvZXNuJ3Qgd29yayBiZWNhdXNlIFhFTiBv
dmVycmlkZXMgaXQgYWxyZWFkeS4gU28gc3VyZSwgbGV0cyBqdXN0IGdvDQo+IA0KPiBJdCBp
cyBvdmVycmlkaW5nIGl0IHdpdGggeDg2X2luaXRfbm9vcCgpLg0KPiANCj4+IHdpdGggdGhl
IHNvbHV0aW9uIHlvdSBwcm9wb3NlZC4gT25lIG1vcmUgdWdseSBvciBsZXNzIGluIFhFTi9Q
ViBkb2VzIG5vdA0KPj4gcmVhbGx5IG1hdHRlciBtdWNoIDopDQo+Pg0KPj4gTGV0IG1lIGdy
YWIgdGhpcyBhbmQgcHV0IGl0IGludG8gdGhlIHJpZ2h0IHBvc2l0aW9uIGluIHRoZSBxdWV1
ZS4NCj4gDQo+IFdhaXQgYSBmZXcgbWludXRlcywgcGxlYXNlLiBJJ20ganVzdCBhYm91dCB0
byB0ZXN0IHlvdXIgc3VnZ2VzdGlvbi4NCg0KVXNpbmcgdGhlIGZvbGxvd2luZyBkaWZmIG9u
IHRvcCBvZiB5b3VyIHBhdGNoIGlzIHdvcmtpbmcgZmluZToNCg0KZGlmZiAtLWdpdCBhL2Fy
Y2gveDg2L3hlbi9hcGljLmMgYi9hcmNoL3g4Ni94ZW4vYXBpYy5jDQppbmRleCA4MDRhMjZi
N2M4NWUuLmQ3NzQzYmEwMjEyZCAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L3hlbi9hcGljLmMN
CisrKyBiL2FyY2gveDg2L3hlbi9hcGljLmMNCkBAIC0xNjYsMTEgKzE2Niw2IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCB4ZW5fYXBpY19jaGVjayh2b2lkKQ0KICB2b2lkIF9faW5pdCB4ZW5f
aW5pdF9hcGljKHZvaWQpDQogIHsNCiAgICAgICAgIHg4Nl9hcGljX29wcy5pb19hcGljX3Jl
YWQgPSB4ZW5faW9fYXBpY19yZWFkOw0KLSAgICAgICAvKiBPbiBQViBndWVzdHMgdGhlIEFQ
SUMgQ1BVSUQgYml0IGlzIGRpc2FibGVkIHNvIG5vbmUgb2YgdGhlDQotICAgICAgICAqIHJv
dXRpbmVzIGVuZCB1cCBleGVjdXRpbmcuICovDQotICAgICAgIGlmICgheGVuX2luaXRpYWxf
ZG9tYWluKCkpDQotICAgICAgICAgICAgICAgYXBpY19pbnN0YWxsX2RyaXZlcigmeGVuX3B2
X2FwaWMpOw0KLQ0KICAgICAgICAgeDg2X3BsYXRmb3JtLmFwaWNfcG9zdF9pbml0ID0geGVu
X2FwaWNfY2hlY2s7DQogIH0NCiAgYXBpY19kcml2ZXIoeGVuX3B2X2FwaWMpOw0KZGlmZiAt
LWdpdCBhL2FyY2gveDg2L3hlbi9lbmxpZ2h0ZW5fcHYuYyBiL2FyY2gveDg2L3hlbi9lbmxp
Z2h0ZW5fcHYuYw0KaW5kZXggOTNiNjU4MjQ4ZDAxLi4xNjRlNWJlMjNhNDUgMTAwNjQ0DQot
LS0gYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2LmMNCisrKyBiL2FyY2gveDg2L3hlbi9l
bmxpZ2h0ZW5fcHYuYw0KQEAgLTEzMjYsNyArMTMyNiw3IEBAIGFzbWxpbmthZ2UgX192aXNp
YmxlIHZvaWQgX19pbml0IHhlbl9zdGFydF9rZXJuZWwoc3RydWN0IA0Kc3RhcnRfaW5mbyAq
c2kpDQoNCiAgICAgICAgIHg4Nl9pbml0LnJlc291cmNlcy5tZW1vcnlfc2V0dXAgPSB4ZW5f
bWVtb3J5X3NldHVwOw0KICAgICAgICAgeDg2X2luaXQuaXJxcy5pbnRyX21vZGVfc2VsZWN0
ICA9IHg4Nl9pbml0X25vb3A7DQotICAgICAgIHg4Nl9pbml0LmlycXMuaW50cl9tb2RlX2lu
aXQgICAgPSB4ODZfaW5pdF9ub29wOw0KKyAgICAgICB4ODZfaW5pdC5pcnFzLmludHJfbW9k
ZV9pbml0ICAgID0geDg2XzY0X3Byb2JlX2FwaWM7DQogICAgICAgICB4ODZfaW5pdC5vZW0u
YXJjaF9zZXR1cCA9IHhlbl9hcmNoX3NldHVwOw0KICAgICAgICAgeDg2X2luaXQub2VtLmJh
bm5lciA9IHhlbl9iYW5uZXI7DQogICAgICAgICB4ODZfaW5pdC5oeXBlci5pbml0X3BsYXRm
b3JtID0geGVuX3B2X2luaXRfcGxhdGZvcm07DQoNCg0KSnVlcmdlbg0K
--------------7VGKm0nFMg0nts76TS09Lrr3
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------7VGKm0nFMg0nts76TS09Lrr3--

--------------gasiVRhyhJm0FBJ084iNFdjy--

--------------jpBGtiV3OGo6AolawpkxNu4A
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTIr2EFAwAAAAAACgkQsN6d1ii/Ey/F
XAgAmbDnItnibEEdO3lHVQi02J03kD3KgnacGQmUirOvsRcD8qsfKSRcRaZOISC8mFzoXkar+yTa
Y/rBYH5YekEBA8JTS1HjQY1UmrLYSjGevSlOCMteS6pwB7Qkm2F78hP+X6GGynK+WViqY6vYclHP
YhQ/d4ZEBweLB2hZpLH5RU4kizj3cTbulrQkba5eIpiK9SY0x5OHuHHHtMmDpZxS9OKayYOjUPQA
Zv4YrGE2USI72c5WY5kvKfoYRARXhSVwkq0GDWJpLt3yfdSwUIamawlBSB2SWMfkVZyEpjy53W7x
HqZ26VF7ZIzGrb0mRWwgY7RHppt6Jtuz5fyfbZ0N6A==
=cFi4
-----END PGP SIGNATURE-----

--------------jpBGtiV3OGo6AolawpkxNu4A--
