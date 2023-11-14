Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2506F7EABAD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbjKNIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:35:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjKNIfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:35:52 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30371A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:35:48 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3724C218E2;
        Tue, 14 Nov 2023 08:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699950947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=dzIWCh5MpLCeLASJNY0yoA637+Iu339U+HHNlj3vIxQ=;
        b=ZPw9J25LOsfdr7ALU67EPo3zLR8mmwdwOtVKv5YbvDnWqbPenZ9l+zGfG9tF1LFGCAk6Ce
        571n7fU00TqFDXMYDVzzrXm+ZS4jTU1hv6odYcOgeNxr3qu9vvfaVRyFGYrDGLSRWytbkv
        tvtxjI2kJ8GK7dgwxcFZgzGlrosaAc0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1065E13460;
        Tue, 14 Nov 2023 08:35:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kFUhAmMxU2UsdAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Nov 2023 08:35:47 +0000
Message-ID: <c29136e0-054f-449d-b9f6-8116e3eea0c6@suse.com>
Date:   Tue, 14 Nov 2023 09:35:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] xen/events: drop xen_allocate_irqs_dynamic()
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-6-jgross@suse.com>
 <955c998f-4550-4945-8dab-c5901d833074@epam.com>
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
In-Reply-To: <955c998f-4550-4945-8dab-c5901d833074@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------CqdUozqydKvJ07V094SCcURh"
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -8.23
X-Spamd-Result: default: False [-8.23 / 50.00];
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
         BAYES_HAM(-0.24)[72.79%];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         MIME_BASE64_TEXT(0.10)[];
         SIGNED_PGP(-2.00)[];
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
--------------CqdUozqydKvJ07V094SCcURh
Content-Type: multipart/mixed; boundary="------------ZPOkSKMcA8WHGngl8Ke9BGNX";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <c29136e0-054f-449d-b9f6-8116e3eea0c6@suse.com>
Subject: Re: [PATCH 5/7] xen/events: drop xen_allocate_irqs_dynamic()
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-6-jgross@suse.com>
 <955c998f-4550-4945-8dab-c5901d833074@epam.com>
In-Reply-To: <955c998f-4550-4945-8dab-c5901d833074@epam.com>

--------------ZPOkSKMcA8WHGngl8Ke9BGNX
Content-Type: multipart/mixed; boundary="------------ThMSNRXs2jBoX3z142UeB0GG"

--------------ThMSNRXs2jBoX3z142UeB0GG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMTEuMjMgMDk6MjAsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gDQo+
IEhlbGxvIEp1ZXJnZW4NCj4gDQo+PiBJbnN0ZWFkIG9mIGhhdmluZyBhIGNvbW1vbiBmdW5j
dGlvbiBmb3IgYWxsb2NhdGluZyBhIHNpbmdsZSBJUlEgb3IgYQ0KPj4gY29uc2VjdXRpdmUg
bnVtYmVyIG9mIElSUXMsIHNwbGl0IHVwIHRoZSBmdW5jdGlvbmFsaXR5IGludG8gdGhlIGNh
bGxlcnMNCj4+IG9mIHhlbl9hbGxvY2F0ZV9pcnFzX2R5bmFtaWMoKS4NCj4+DQo+PiBUaGlz
IGFsbG93cyB0byBoYW5kbGUgYW55IGFsbG9jYXRpb24gZXJyb3IgaW4geGVuX2lycV9pbml0
KCkgZ3JhY2VmdWxseQ0KPj4gaW5zdGVhZCBvZiBwYW5pY2luZyB0aGUgc3lzdGVtLiBMZXQg
eGVuX2lycV9pbml0KCkgcmV0dXJuIHRoZSBpcnFfaW5mbw0KPj4gcG9pbnRlciBvciBOVUxM
IGluIGNhc2Ugb2YgYW4gYWxsb2NhdGlvbiBlcnJvci4NCj4+DQo+PiBBZGRpdGlvbmFsbHkg
c2V0IHRoZSBJUlEgaW50byBpcnFfaW5mbyBhbHJlYWR5IGF0IGFsbG9jYXRpb24gdGltZSwg
YXMNCj4+IG90aGVyd2lzZSB0aGUgSVJRIHdvdWxkIGJlICcwJyAod2hpY2ggaXMgYSB2YWxp
ZCBJUlEgbnVtYmVyKSB1bnRpbA0KPj4gYmVpbmcgc2V0Lg0KPj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gICAgZHJp
dmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMgfCA3NCArKysrKysrKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLQ0KPj4gICAgMSBmaWxlIGNoYW5nZWQsIDQ0IGluc2VydGlvbnMoKyks
IDMwIGRlbGV0aW9ucygtKQ0KPj4NCj4gDQo+IFtzbmlwXQ0KPiANCj4+IEBAIC0xNzI1LDYg
KzE3MzgsNyBAQCB2b2lkIHJlYmluZF9ldnRjaG5faXJxKGV2dGNobl9wb3J0X3QgZXZ0Y2hu
LCBpbnQgaXJxKQ0KPj4gICAgCSAgIHNvIHRoZXJlIHNob3VsZCBiZSBhIHByb3BlciB0eXBl
ICovDQo+PiAgICAJQlVHX09OKGluZm8tPnR5cGUgPT0gSVJRVF9VTkJPVU5EKTsNCj4+ICAg
IA0KPj4gKwlpbmZvLT5pcnEgPSBpcnE7DQo+IA0KPiANCj4gSSBmYWlsZWQgdG8gdW5kZXJz
dGFuZCB3aHkgdGhpcyBpcyBhZGRlZCBoZXJlLiBEb2Vzbid0IGlycSByZW1haW4gdGhlDQo+
IHNhbWUsIGFuZCBpbmZvLT5pcnEgcmVtYWlucyB2YWxpZD8gQ291bGQgeW91IHBsZWFzZSBj
bGFyaWZ5Lg0KDQpUaGUgSVJRIHJlbWFpbnMgdGhlIHNhbWUsIGJ1dCB0aGUgZXZlbnQgY2hh
bm5lbCBjb3VsZCBjaGFuZ2UuDQoNClRoaXMgc2V0dGluZyBvZiBpbmZvLT5pcnEgY29tcGVu
c2F0ZXMgZm9yIHRoZSByZWxhdGVkIHJlbW92YWwgaW4NCnhlbl9pcnFfaW5mb19jb21tb25f
c2V0dXAoKS4NCg0KPiANCj4gT3RoZXIgY2hhbmdlcyBsZ3RtLg0KDQoNCkp1ZXJnZW4NCg0K

--------------ThMSNRXs2jBoX3z142UeB0GG
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ThMSNRXs2jBoX3z142UeB0GG--

--------------ZPOkSKMcA8WHGngl8Ke9BGNX--

--------------CqdUozqydKvJ07V094SCcURh
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVTMWIFAwAAAAAACgkQsN6d1ii/Ey9K
uAf/UxfxCnwQHu88qZ4b5S677JjI2O0opJpC7142quVD0fC402HJ+aB13+1Ve7d8xPIkigQHr/nv
GHRDETDjPNM/DymzC2aEqP0XLdNrmlO3nqQizpj34dcyz2xTwcp83Ce4iQ9JgZUFZiTuqcDaAFb3
YiFpC+LXsFjotB1juy1l4uCydAgt1l9wEdZ4Lv3Q4+XA6o8LKb6UzNOhSU6f1tdvrtM3OM+l+SEJ
TaBks2xPtbd1M90Ek8hIb70hXceaE69YVEp+s1KAz9G70fsuxreIbOOhep2DsuRte08n9C+iWvwC
h7espDeTBgr3u3hoDJlKFa4x/DQ3L2DDvzlPF54yvQ==
=7KyR
-----END PGP SIGNATURE-----

--------------CqdUozqydKvJ07V094SCcURh--
