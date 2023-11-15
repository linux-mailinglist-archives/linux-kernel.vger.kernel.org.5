Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9EE7EBE32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 08:41:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbjKOHlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 02:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjKOHlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 02:41:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DA9C8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 23:41:11 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4920E204C5;
        Wed, 15 Nov 2023 07:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1700034069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=lj76I4LglM36u8FrCyyMKkgBIxzk6y8UQtrQmIFIuDY=;
        b=gfNlek14eyvtRl3C887GKLOzUsdorROXgEH+FX208Db6d/5g0PEaPZSoBXBe1c4kMBaL4K
        GXP98wNOIrJmb9qvmPgBDYAdPusoILVmHKmGHibIeJ2d14KY54lq/Bpw4qAEvEOpkUIu4f
        3elWKf1ObbQ/I5J5GRpruVn0K69vcdY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 23CCD13592;
        Wed, 15 Nov 2023 07:41:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +FE6BxV2VGWvdQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 15 Nov 2023 07:41:09 +0000
Message-ID: <dfcd84b8-4fb2-42fa-9346-fa447992f8cd@suse.com>
Date:   Wed, 15 Nov 2023 08:41:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] xen/events: remove some info_for_irq() calls in pirq
 handling
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-8-jgross@suse.com>
 <1a62fc9a-7bd2-4fed-a690-0a12f2724044@epam.com>
From:   Juergen Gross <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <1a62fc9a-7bd2-4fed-a690-0a12f2724044@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------L9xqdmzhDtNUNx8JjVurpTUb"
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -11.51
X-Spamd-Result: default: False [-11.51 / 50.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         HAS_ATTACHMENT(0.00)[];
         REPLY(-4.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         BAYES_HAM(-2.53)[97.87%];
         NEURAL_HAM_LONG(-3.00)[-0.999];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MIME_BASE64_TEXT(0.10)[];
         SIGNED_PGP(-2.00)[];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_UNKNOWN(0.10)[application/pgp-keys]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------L9xqdmzhDtNUNx8JjVurpTUb
Content-Type: multipart/mixed; boundary="------------EWOtSPW0q9KCzlgXWebVx00q";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <dfcd84b8-4fb2-42fa-9346-fa447992f8cd@suse.com>
Subject: Re: [PATCH 7/7] xen/events: remove some info_for_irq() calls in pirq
 handling
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-8-jgross@suse.com>
 <1a62fc9a-7bd2-4fed-a690-0a12f2724044@epam.com>
In-Reply-To: <1a62fc9a-7bd2-4fed-a690-0a12f2724044@epam.com>

--------------EWOtSPW0q9KCzlgXWebVx00q
Content-Type: multipart/mixed; boundary="------------VGWBPXiFjyjYWpV9nVkrBFdW"

--------------VGWBPXiFjyjYWpV9nVkrBFdW
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMTEuMjMgMTk6MTYsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gSGVs
bG8gSnVlcmdlbg0KPiANCj4gDQo+PiBJbnN0ZWFkIG9mIHRoZSBJUlEgbnVtYmVyIHVzZXIg
dGhlIHN0cnVjdCBpcnFfaW5mbyBwb2ludGVyIGFzIHBhcmFtZXRlcg0KPj4gaW4gdGhlIGlu
dGVybmFsIHBpcnEgcmVsYXRlZCBmdW5jdGlvbnMuIFRoaXMgYWxsb3dzIHRvIGRyb3Agc29t
ZSBjYWxscw0KPj4gb2YgaW5mb19mb3JfaXJxKCkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTog
SnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KPiANCj4gDQo+IExvb2tzIGdvb2Qs
IHNvDQo+IA0KPiBSZXZpZXdlZC1ieTogT2xla3NhbmRyIFR5c2hjaGVua28gPG9sZWtzYW5k
cl90eXNoY2hlbmtvQGVwYW0uY29tPg0KPiANCj4gDQo+IEp1c3Qgb25lIE5JVCBiZWxvdyAu
Li4NCj4gDQo+IA0KPiBbc25pcF0NCj4gDQo+PiAgICANCj4+IC1zdGF0aWMgdm9pZCBwaXJx
X3F1ZXJ5X3VubWFzayhpbnQgaXJxKQ0KPj4gK3N0YXRpYyB2b2lkIHBpcnFfcXVlcnlfdW5t
YXNrKHN0cnVjdCBpcnFfaW5mbyAqaW5mbykNCj4+ICAgIHsNCj4+ICAgIAlzdHJ1Y3QgcGh5
c2Rldl9pcnFfc3RhdHVzX3F1ZXJ5IGlycV9zdGF0dXM7DQo+PiAtCXN0cnVjdCBpcnFfaW5m
byAqaW5mbyA9IGluZm9fZm9yX2lycShpcnEpOw0KPj4gICAgDQo+PiAgICAJQlVHX09OKGlu
Zm8tPnR5cGUgIT0gSVJRVF9QSVJRKTsNCj4+ICAgIA0KPj4gLQlpcnFfc3RhdHVzLmlycSA9
IHBpcnFfZnJvbV9pcnEoaXJxKTsNCj4+ICsJaXJxX3N0YXR1cy5pcnEgPSBpbmZvLT51LnBp
cnEucGlycTsNCj4gDQo+IA0KPiAgICAuLi4gd2hhdCBpcyB0aGUgcmVhc29uIHRvIG9wZW4t
Y29kZSBwaXJxX2Zyb21faXJxKCkgaGVyZT8NCj4gRm9yIGV4YW1wbGUsIF9fc3RhcnR1cF9w
aXJxKCkgY29udGludWVzIHRvIHVzZSBoZWxwZXIgaW4gYWxtb3N0IHRoZSBzYW1lDQo+IHNp
dHVhdGlvbiAuLi4NCg0KR29vZCBjYXRjaC4gSSdsbCBjaGFuZ2UgdGhhdCwgZXNwZWNpYWxs
eSBhcyBpdCBhbGxvd3MgdG8gcmVtb3ZlIHRoZSBCVUdfT04oKQ0Kd2hpY2ggaXMgaW4gdGhl
IGhlbHBlciBhbHJlYWR5Lg0KDQoNCkp1ZXJnZW4NCg==
--------------VGWBPXiFjyjYWpV9nVkrBFdW
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

--------------VGWBPXiFjyjYWpV9nVkrBFdW--

--------------EWOtSPW0q9KCzlgXWebVx00q--

--------------L9xqdmzhDtNUNx8JjVurpTUb
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVUdhQFAwAAAAAACgkQsN6d1ii/Ey+f
Jgf/cOyx1sanDxmpt4m/qmnea1epC1AydeRJTX8a5lbl0KADOxq7Hekp/4xCG4qMjxwQSM+cQh4i
Ys5LWnhU9PePUvYBJxyGCMY8VR+KKyKxF+D6dbW3RGJU15iR0qu3CT7NxOOVHXHdBhzurWG4YV8f
63Io34OQTl5lSA1DAXFhyExf+YC+p7fZxt9S443znMz5aZ9XrbFy5lHaBwpET2wK0bc7pejgOLB5
EfmD7U5hgLF6sqmEWY1nhiWHE6LfmXNFpwv8mJ4/h1fWjtwqwsPJ7/cq1GLV10CRjH9kONfMTUDh
Z7KKckR6VfLuOQLMO5xfHmPFPCo1SnnCGTw/+yMSDw==
=CyJR
-----END PGP SIGNATURE-----

--------------L9xqdmzhDtNUNx8JjVurpTUb--
