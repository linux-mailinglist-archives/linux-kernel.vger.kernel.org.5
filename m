Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3604C76A034
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGaSTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGaST3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:19:29 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39782119
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:19:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CF62D1FD69;
        Mon, 31 Jul 2023 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690827566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/3MU3w5vQXISYO+BuvN7lX+giIQ1CWw2cjqqdqe7WYk=;
        b=tYcDY/M6Fm12Y2rEd/k3bezYR7j03JV1AoXKhek/vSUz65HAJPyLWCSXxMkYBO1Yw6+D7P
        cf9dLiyL9ccRWNu2nXdsRBpXtSNCE4ba1ul/9e350JPrCxIeTtcjdHYGOrW4EmouzMWFi4
        9e+/ibNxzgy+5X2oA0UeVkcqAHjY9P0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 778F71322C;
        Mon, 31 Jul 2023 18:19:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id n+GCGy77x2QvRAAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 31 Jul 2023 18:19:26 +0000
Message-ID: <4bf0020b-dff9-091f-dcb4-45f1ee864e2a@suse.com>
Date:   Mon, 31 Jul 2023 20:19:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
 <20230724132045.555787669@linutronix.de>
 <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com> <87y1iwnt34.ffs@tglx>
 <87mszcnkfa.ffs@tglx>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [patch V2 16/58] x86/apic: Sanitize num_processors handling
In-Reply-To: <87mszcnkfa.ffs@tglx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------weZFS6RgpxPL656yEksnPD42"
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
--------------weZFS6RgpxPL656yEksnPD42
Content-Type: multipart/mixed; boundary="------------0zGExTVkkqYRZWVHI6ZEsEU1";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <4bf0020b-dff9-091f-dcb4-45f1ee864e2a@suse.com>
Subject: Re: [patch V2 16/58] x86/apic: Sanitize num_processors handling
References: <20230724131206.500814398@linutronix.de>
 <20230724132045.555787669@linutronix.de>
 <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com> <87y1iwnt34.ffs@tglx>
 <87mszcnkfa.ffs@tglx>
In-Reply-To: <87mszcnkfa.ffs@tglx>

--------------0zGExTVkkqYRZWVHI6ZEsEU1
Content-Type: multipart/mixed; boundary="------------bdfg8CwRoTF0fZOAOoISmCma"

--------------bdfg8CwRoTF0fZOAOoISmCma
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDcuMjMgMTc6NTcsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gTW9uLCBK
dWwgMzEgMjAyMyBhdCAxNDo1MCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPj4gV2h5IGNh
bid0IFhFTlBWIHByZXRlbmQgdGhhdCBpdCBoYXMgYSBzbXAgY29uZmlndXJhdGlvbiBkZXRl
Y3RlZCwNCj4+IGkuZS4gc2V0dGluZyBzbXBfZm91bmRfY29uZmlnIGFzIGFueSBvdGhlciBz
cGVjaWFsIGdldF9zbXBfY29uZmlnKCkNCj4+IGltcGxlbWVudGF0aW9uIGRvZXM/DQo+IA0K
PiBUaGUgYmVsb3cgc2hvdWxkIGRvIHRoZSB0cmljaywgbm8/DQoNClNvbWV0aGluZyBsaWtl
IHRoYXQsIHllcy4NCg0KSSdtIGp1c3QgaHVudGluZyBhbm90aGVyIHJlZ3Jlc3Npb24gaW4g
dGhlIHNlcmllcy4gV2l0aCBwYXRjaCAyMyBvZiB0aGUNCnRvcG9sb2d5IHNlcmllcyBhcHBs
aWVkIHRoZSBBUHMgb2YgYSBYZW4gUFYgZ3Vlc3RzIHdvbid0IGJlIG9ubGluZWQuIEkNCmd1
ZXNzIHRoaXMgaXMgZHVlIHRvIG1pc3NpbmcgdG9wb2xvZ3kgZGF0YSBpbml0aWFsaXphdGlv
biBzb21ld2hlcmUgaW4NCnRoZSBYZW4gcmVsYXRlZCBjb2RlLg0KDQpJJ2xsIGNoZWNrIHlv
dXIgc3VnZ2VzdGlvbiBhZnRlciBmaW5kaW5nIHRoZSByZWFzb24gZm9yIHRoZSByZWdyZXNz
aW9uLg0KDQoNCkp1ZXJnZW4NCg0KPiANCj4gDQo+IC0tLSBhL2FyY2gveDg2L3hlbi9zbXBf
cHYuYw0KPiArKysgYi9hcmNoL3g4Ni94ZW4vc21wX3B2LmMNCj4gQEAgLTE4Miw3ICsxODIs
OCBAQCBzdGF0aWMgdm9pZCBfX2luaXQgX2dldF9zbXBfY29uZmlnKHVuc2lnDQo+ICAgCWlm
IChzdWJ0cmFjdCkNCj4gICAJCXNldF9ucl9jcHVfaWRzKG5yX2NwdV9pZHMgLSBzdWJ0cmFj
dCk7DQo+ICAgI2VuZGlmDQo+IC0NCj4gKwkvKiBQcmV0ZW5kIHRvIGJlIGEgcHJvcGVyIGVu
dW1lcmF0ZWQgc3lzdGVtICovDQo+ICsJc21wX2ZvdW5kX2NvbmZpZyA9IDE7DQo+ICAgfQ0K
PiAgIA0KPiAgIHN0YXRpYyB2b2lkIF9faW5pdCB4ZW5fcHZfc21wX3ByZXBhcmVfYm9vdF9j
cHUodm9pZCkNCg0K
--------------bdfg8CwRoTF0fZOAOoISmCma
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjri
oyspZKOBycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2
kaV2KL9650I1SJvedYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i
1TXkH09XSSI8mEQ/ouNcMvIJNwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/B
BLUVbDa4+gmzDC9ezlZkTZG2t14zWPvxXP3FAp2pkW0xqG7/377qptDmrk42GlSK
N4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEBAAHNHEp1ZXJnZW4gR3Jvc3Mg
PGpnQHBmdXBmLm5ldD7CwHkEEwECACMFAlOMcBYCGwMHCwkIBwMCAQYVCAIJCgsE
FgIDAQIeAQIXgAAKCRCw3p3WKL8TL0KdB/93FcIZ3GCNwFU0u3EjNbNjmXBKDY4F
UGNQH2lvWAUy+dnyThpwdtF/jQ6j9RwE8VP0+NXcYpGJDWlNb9/JmYqLiX2Q3Tye
vpB0CA3dbBQp0OW0fgCetToGIQrg0MbD1C/sEOv8Mr4NAfbauXjZlvTj30H2jO0u
+6WGM6nHwbh2l5O8ZiHkH32iaSTfN7Eu5RnNVUJbvoPHZ8SlM4KWm8rG+lIkGurq
qu5gu8q8ZMKdsdGC4bBxdQKDKHEFExLJK/nRPFmAuGlId1E3fe10v5QL+qHI3EIP
tyfE7i9Hz6rVwi7lWKgh7pe0ZvatAudZ+JNIlBKptb64FaiIOAWDCx1SzR9KdWVy
Z2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+wsB5BBMBAgAjBQJTjHCvAhsDBwsJ
CAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/Ey/HmQf/RtI7kv5A2PS4
RF7HoZhPVPogNVbC4YA6lW7DrWf0teC0RR3MzXfy6pJ+7KLgkqMlrAbN/8Dvjoz7
8X+5vhH/rDLa9BuZQlhFmvcGtCF8eR0T1v0nC/nuAFVGy+67q2DH8As3KPu0344T
BDpAvr2uYM4tSqxK4DURx5INz4ZZ0WNFHcqsfvlGJALDeE0LhITTd9jLzdDad1pQ
SToCnLl6SBJZjDOX9QQcyUigZFtCXFst4dlsvddrxyqT1f17+2cFSdu7+ynLmXBK
7abQ3rwJY8SbRO2iRulogc5vr/RLMMlscDAiDkaFQWLoqHHOdfO9rURssHNN8WkM
nQfvUewRz80hSnVlcmdlbiBHcm9zcyA8amdyb3NzQG5vdmVsbC5jb20+wsB5BBMB
AgAjBQJTjHDXAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AACgkQsN6d1ii/
Ey8PUQf/ehmgCI9jB9hlgexLvgOtf7PJnFOXgMLdBQgBlVPO3/D9R8LtF9DBAFPN
hlrsfIG/SqICoRCqUcJ96Pn3P7UUinFG/I0ECGF4EvTE1jnDkfJZr6jrbjgyoZHi
w/4BNwSTL9rWASyLgqlA8u1mf+c2yUwcGhgkRAd1gOwungxcwzwqgljf0N51N5Jf
VRHRtyfwq/ge+YEkDGcTU6Y0sPOuj4Dyfm8fJzdfHNQsWq3PnczLVELStJNdapwP
OoE+lotufe3AM2vAEYJ9rTz3Cki4JFUsgLkHFqGZarrPGi1eyQcXeluldO3m91NK
/1xMI3/+8jbO0tsn1tqSEUGIJi7ox80eSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuZGU+wsB5BBMBAgAjBQJTjHDrAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgEC
F4AACgkQsN6d1ii/Ey+LhQf9GL45eU5vOowA2u5N3g3OZUEBmDHVVbqMtzwlmNC4
k9Kx39r5s2vcFl4tXqW7g9/ViXYuiDXb0RfUpZiIUW89siKrkzmQ5dM7wRqzgJpJ
wK8Bn2MIxAKArekWpiCKvBOB/Cc+3EXE78XdlxLyOi/NrmSGRIov0karw2RzMNOu
5D+jLRZQd1Sv27AR+IP3I8U4aqnhLpwhK7MEy9oCILlgZ1QZe49kpcumcZKORmzB
TNh30FVKK1EvmV2xAKDoaEOgQB4iFQLhJCdP1I5aSgM5IVFdn7v5YgEYuJYx37Io
N1EblHI//x/e2AaIHpzK5h88NEawQsaNRpNSrcfbFmAg987ATQRTjHAWAQgAyzH6
AOODMBjgfWE9VeCgsrwH3exNAU32gLq2xvjpWnHIs98ndPUDpnoxWQugJ6MpMncr
0xSwFmHEgnSEjK/PAjppgmyc57BwKII3sV4on+gDVFJR6Y8ZRwgnBC5mVM6JjQ5x
Dk8WRXljExRfUX9pNhdE5eBOZJrDRoLUmmjDtKzWaDhIg/+1Hzz93X4fCQkNVbVF
LELU9bMaLPBG/x5q4iYZ2k2ex6d47YE1ZFdMm6YBYMOljGkZKwYde5ldM9mo45mm
we0icXKLkpEdIXKTZeKDO+Hdv1aqFuAcccTg9RXDQjmwhC3yEmrmcfl0+rPghO0I
v3OOImwTEe4co3c1mwARAQABwsBfBBgBAgAJBQJTjHAWAhsMAAoJELDendYovxMv
Q/gH/1ha96vm4P/L+bQpJwrZ/dneZcmEwTbe8YFsw2V/Buv6Z4Mysln3nQK5ZadD
534CF7TDVft7fC4tU4PONxF5D+/tvgkPfDAfF77zy2AH1vJzQ1fOU8lYFpZXTXIH
b+559UqvIB8AdgR3SAJGHHt4RKA0F7f5ipYBBrC6cyXJyyoprT10EMvU8VGiwXvT
yJz3fjoYsdFzpWPlJEBRMedCot60g5dmbdrZ5DWClAr0yau47zpWj3enf1tLWaqc
suylWsviuGjKGw7KHQd3bxALOknAp4dN3QwBYCKuZ7AddY9yjynVaD5X7nF9nO5B
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------bdfg8CwRoTF0fZOAOoISmCma--

--------------0zGExTVkkqYRZWVHI6ZEsEU1--

--------------weZFS6RgpxPL656yEksnPD42
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTH+y0FAwAAAAAACgkQsN6d1ii/Ey8n
Swf9FqvmovsQjyKhjHxDABH647GcmppHx2VHOX8W1+2FJunqnva74vZ4Etw9dL6GCQSuZmuhnAQs
bDM8TRIznbxrwgqpRwJZ5jMzfeMpufEXRgZUqExE2U5qP3jZ7e7hiTYkzzvFe9Zw+qJ+yVY4EXZB
eRm5LB7n9NgdCoCh36hXSzuZmtERIkTD6lHZh+Rnmi6MMFES+370bcrUuNrpeSq1E/45nSeNJ/Y+
p1QH417hZ6hr4NakIl3RqFVOMviahngfxH/QYzAyfbrUrs6TlzalwRNRrAoUO3y0l4zMjZpdy3y/
pYjHKoy97ARzbttANNx9k4RSE6ICDZG8ipejo33Kgw==
=twK+
-----END PGP SIGNATURE-----

--------------weZFS6RgpxPL656yEksnPD42--
