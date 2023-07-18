Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533137580FB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 17:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbjGRPcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 11:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233676AbjGRPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 11:32:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D39211C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 08:32:02 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 699161FDEB;
        Tue, 18 Jul 2023 15:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689694320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xPciE77eEhpF/JUpB119F8/7kN+9J0BJHG0imJhlVcE=;
        b=AnI+HBLbQnSIzfWF1+w21xt6E197jI81TnZH4ZtV6aHD9J/igV3PXS/mo7s6iHHi79/Z2F
        rZiLjQc1HMOnj1X1kbeGukypevPyO752IwOuuURL/UN65U4JppFCutcqFXmBN+y4BEHPxo
        UaIQM3xZkTBXx/PeKLayjfOo+l0w20s=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2118813494;
        Tue, 18 Jul 2023 15:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id x1p2BnCwtmQHLAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 18 Jul 2023 15:32:00 +0000
Message-ID: <a89d5dab-4c52-0bff-ad35-080e62a57447@suse.com>
Date:   Tue, 18 Jul 2023 17:31:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch 54/58] x86/xen/apic: Mark apic __ro_after_init
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.297124390@linutronix.de>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230717223226.297124390@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------AiYKsPHbEf321LrRvSo0CSdR"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------AiYKsPHbEf321LrRvSo0CSdR
Content-Type: multipart/mixed; boundary="------------PVgJEY6FZ0BRMdoe5kV7PdSs";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>
Message-ID: <a89d5dab-4c52-0bff-ad35-080e62a57447@suse.com>
Subject: Re: [patch 54/58] x86/xen/apic: Mark apic __ro_after_init
References: <20230717223049.327865981@linutronix.de>
 <20230717223226.297124390@linutronix.de>
In-Reply-To: <20230717223226.297124390@linutronix.de>

--------------PVgJEY6FZ0BRMdoe5kV7PdSs
Content-Type: multipart/mixed; boundary="------------R3VBMvDMl3Flt6ZlSN00LrDX"

--------------R3VBMvDMl3Flt6ZlSN00LrDX
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTguMDcuMjMgMDE6MTUsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gTm90aGluZyBj
YW4gY2hhbmdlIGl0IHBvc3QgaW5pdC4NCj4gDQo+IFdoaWxlIGF0IGl0IG1vcCB1cCB0aGUg
d2hpdGVzcGFjZSBkYW1hZ2Ugd2hpY2ggY2F1c2VzIGV5ZWJsZWVkIGR1ZSB0byBhbg0KPiBl
ZGl0b3Igd2hpY2ggaXMgaGlnaGxpZ2h0aW5nIGl0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
VGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+DQo+IENjOiBKdWVyZ2VuIEdy
b3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQo+IC0tLQ0KPiAgIGFyY2gveDg2L3hlbi9hcGljLmMg
fCAgIDI0ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMoLSkNCj4gDQo+IC0tLSBhL2FyY2gveDg2
L3hlbi9hcGljLmMNCj4gKysrIGIvYXJjaC94ODYveGVuL2FwaWMuYw0KPiBAQCAtMTIzLDkg
KzEyMyw5IEBAIHN0YXRpYyBpbnQgeGVuX2NwdV9wcmVzZW50X3RvX2FwaWNpZChpbnQNCj4g
ICAJCXJldHVybiBCQURfQVBJQ0lEOw0KPiAgIH0NCj4gICANCj4gLXN0YXRpYyBzdHJ1Y3Qg
YXBpYyB4ZW5fcHZfYXBpYyA9IHsNCj4gLQkubmFtZSAJCQkJPSAiWGVuIFBWIiwNCj4gLQku
cHJvYmUgCQkJCT0geGVuX2FwaWNfcHJvYmVfcHYsDQo+ICtzdGF0aWMgc3RydWN0IGFwaWMg
eGVuX3B2X2FwaWMgX19yb19hZnRlcl9pbml0ID0gew0KPiArCS5uYW1lCQkJCT0gIlhlbiBQ
ViIsDQo+ICsJLnByb2JlCQkJCT0geGVuX2FwaWNfcHJvYmVfcHYsDQo+ICAgCS5hY3BpX21h
ZHRfb2VtX2NoZWNrCQk9IHhlbl9tYWR0X29lbV9jaGVjaywNCj4gICANCj4gICAJLyogLmRl
bGl2ZXJ5X21vZGUgYW5kIC5kZXN0X21vZGVfbG9naWNhbCBub3QgdXNlZCBieSBYRU5QViAq
Lw0KPiBAQCAtMTM4LDI0ICsxMzgsMjQgQEAgc3RhdGljIHN0cnVjdCBhcGljIHhlbl9wdl9h
cGljID0gew0KPiAgIAkucGh5c19wa2dfaWQJCQk9IHhlbl9waHlzX3BrZ19pZCwgLyogZGV0
ZWN0X2h0ICovDQo+ICAgDQo+ICAgCS5tYXhfYXBpY19pZAkJCT0gVUlOVF9NQVgsDQo+IC0J
LmdldF9hcGljX2lkIAkJCT0geGVuX2dldF9hcGljX2lkLA0KPiAtCS5zZXRfYXBpY19pZCAJ
CQk9IHhlbl9zZXRfYXBpY19pZCwgLyogQ2FuIGJlIE5VTEwgb24gMzItYml0LiAqLw0KPiAr
CS5nZXRfYXBpY19pZAkJCT0geGVuX2dldF9hcGljX2lkLA0KPiArCS5zZXRfYXBpY19pZAkJ
CT0geGVuX3NldF9hcGljX2lkLCAvKiBDYW4gYmUgTlVMTCBvbiAzMi1iaXQuICovDQoNCldo
aWxlIGNoYW5naW5nIHRoaXMgbGluZSwgY291bGQgeW91IHBsZWFzZSBkcm9wIHRoZSBjb21t
ZW50IGhlcmU/DQoNCjMyLWJpdCBpcyBpcnJlbGV2YW50LCBhcyBYZW4gUFYgaXMgNjQtYml0
IG9ubHkgdGhlc2UgZGF5cy4NCg0KDQpKdWVyZ2VuDQo=
--------------R3VBMvDMl3Flt6ZlSN00LrDX
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

--------------R3VBMvDMl3Flt6ZlSN00LrDX--

--------------PVgJEY6FZ0BRMdoe5kV7PdSs--

--------------AiYKsPHbEf321LrRvSo0CSdR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmS2sG8FAwAAAAAACgkQsN6d1ii/Ey8N
5Qf/c7bT4pO2hrIw14lTrAplmLmG+FSjsvytx5HzjxmIbAQooxCV1TkUzf5UMNDYhzeMHB+Ec9Dj
8fMc/4tmELkNC5/Bzsy8gQz9iEuRnG0v13Ne2Men3SLh9znBDxAazcnz0cLYOA+EwT9Vbrfrac/M
iWX1EcWxIJLKo6t8earVEyysgUc8P3ekyIdCkKcSovtUWSRjUoVNudhGsWP84+OexVIyMW/2FTtQ
FpC9In/pbqonv3RRumHJ1C2+NZKcUsDQoGkS6PItq45XIdvzlWXQeM35lbymFLwv2hmFiqX2G3gm
mpwv4/eo4n9GdTKBIIQrnrRcXxN2zFgFj3P1Am49xg==
=0Wj+
-----END PGP SIGNATURE-----

--------------AiYKsPHbEf321LrRvSo0CSdR--
