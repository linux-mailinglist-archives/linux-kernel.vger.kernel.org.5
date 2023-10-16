Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A82A7CA060
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjJPHRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbjJPHRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:17:54 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFAEAD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:17:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 856AE21BD8;
        Mon, 16 Oct 2023 07:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697440669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=nfISWVpeuW/iV5R79FAnU+RItCcz5hFDD2ufVTIvwTc=;
        b=HjmzQCbLH2l3AOciNe4vczJeCQUSqDCqkip8eDU5VDeORChyfGHXCfuOqcelBl/1qiB0Gf
        2GeFY0yJ0If0y4Hss7d6+CBKf8qcxGsS0qCvwoYQpcYvP0v4hBzLaoqr40rx5q0UR3V2RV
        m5zMRnC3KQdOxN283Lcl1NLl2vu8RH0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C2E9138EF;
        Mon, 16 Oct 2023 07:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q8TLCJ3jLGVsXQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 16 Oct 2023 07:17:49 +0000
Message-ID: <109e682d-c257-47b9-9d95-ba927cae46db@suse.com>
Date:   Mon, 16 Oct 2023 09:17:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 3/4] xen: evtchn: Allow shared registration of IRQ
 handers
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <cover.1697439990.git.viresh.kumar@linaro.org>
 <99b1edfd3147c6b5d22a5139dab5861e767dc34a.1697439990.git.viresh.kumar@linaro.org>
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
In-Reply-To: <99b1edfd3147c6b5d22a5139dab5861e767dc34a.1697439990.git.viresh.kumar@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0DeSbFPoopNZI4BfBlhMslIu"
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.99
X-Spamd-Result: default: False [-2.99 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         BAYES_HAM(-0.00)[15.78%];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         HAS_ATTACHMENT(0.00)[];
         REPLY(-4.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MIME_BASE64_TEXT(0.10)[];
         RCPT_COUNT_TWELVE(0.00)[12];
         NEURAL_SPAM_LONG(3.00)[1.000];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_UNKNOWN(0.10)[application/pgp-keys]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------0DeSbFPoopNZI4BfBlhMslIu
Content-Type: multipart/mixed; boundary="------------12lMWqCZzejQlSAfuifK0UmU";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org, Erik Schilling <erik.schilling@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, Arnd Bergmann
 <arnd@kernel.org>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Message-ID: <109e682d-c257-47b9-9d95-ba927cae46db@suse.com>
Subject: Re: [PATCH V4 3/4] xen: evtchn: Allow shared registration of IRQ
 handers
References: <cover.1697439990.git.viresh.kumar@linaro.org>
 <99b1edfd3147c6b5d22a5139dab5861e767dc34a.1697439990.git.viresh.kumar@linaro.org>
In-Reply-To: <99b1edfd3147c6b5d22a5139dab5861e767dc34a.1697439990.git.viresh.kumar@linaro.org>

--------------12lMWqCZzejQlSAfuifK0UmU
Content-Type: multipart/mixed; boundary="------------TPBbdZfrM7mOno7xHWeOz5zO"

--------------TPBbdZfrM7mOno7xHWeOz5zO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTYuMTAuMjMgMDk6MTEsIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gQ3VycmVudGx5IHRo
ZSBoYW5kbGluZyBvZiBldmVudHMgaXMgc3VwcG9ydGVkIGVpdGhlciBpbiB0aGUga2VybmVs
IG9yDQo+IHVzZXJzcGFjZSwgYnV0IG5vdCBib3RoLg0KPiANCj4gSW4gb3JkZXIgdG8gc3Vw
cG9ydCBmYXN0IGRlbGl2ZXJ5IG9mIGludGVycnVwdHMgZnJvbSB0aGUgZ3Vlc3QgdG8gdGhl
DQo+IGJhY2tlbmQsIHdlIG5lZWQgdG8gaGFuZGxlIHRoZSBRdWV1ZSBub3RpZnkgcGFydCBv
ZiBWaXJ0aW8gcHJvdG9jb2wgaW4NCj4ga2VybmVsIGFuZCB0aGUgcmVzdCBpbiB1c2Vyc3Bh
Y2UuDQo+IA0KPiBVcGRhdGUgdGhlIGludGVycnVwdCBoYW5kbGVyIHJlZ2lzdHJhdGlvbiBm
bGFnIHRvIElSUUZfU0hBUkVEIGZvciBldmVudA0KPiBjaGFubmVscywgd2hpY2ggd291bGQg
YWxsb3cgbXVsdGlwbGUgZW50aXRpZXMgdG8gYmluZCB0aGVpciBpbnRlcnJ1cHQNCj4gaGFu
ZGxlciBmb3IgdGhlIHNhbWUgZXZlbnQgY2hhbm5lbCBwb3J0Lg0KPiANCj4gQWxzbyBpbmNy
ZW1lbnQgdGhlIHJlZmVyZW5jZSBjb3VudCBvZiBpcnFfaW5mbyB3aGVuIG11bHRpcGxlIGVu
dGl0aWVzDQo+IHRyeSB0byBiaW5kIGV2ZW50IGNoYW5uZWwgdG8gaXJxY2hpcCwgc28gdGhl
IHVuYmluZGluZyBoYXBwZW5zIG9ubHkNCj4gYWZ0ZXIgYWxsIHRoZSB1c2VycyBhcmUgZ29u
ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFZpcmVzaCBLdW1hciA8dmlyZXNoLmt1bWFyQGxp
bmFyby5vcmc+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5j
b20+DQoNCg0KSnVlcmdlbg0KDQo=
--------------TPBbdZfrM7mOno7xHWeOz5zO
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------TPBbdZfrM7mOno7xHWeOz5zO--

--------------12lMWqCZzejQlSAfuifK0UmU--

--------------0DeSbFPoopNZI4BfBlhMslIu
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmUs45wFAwAAAAAACgkQsN6d1ii/Ey8D
4Qf+IyXSq23XkKbZqP/f0IXxWnicHRScYES+yc35JU8u4sEBTtNpOTMJSB9KBPutPhKGXb1/pIIr
kTvVLQiwicqgsD0padwBGAeMG82mHLTGa8bvhqMwa8xfB42h6s4RAgSZjwM9vFcTq0IMIKjvJecB
OmlFLlhV/9etmBEfzgBXc5u6Ycek05JSaENrnz0BscU9x9D/JzDF0pqImo0aJ7E+lC/D/R2cHJCh
Fdnkn+FIEkDjPJOmUlEM0Khbq9a0XCNLsC6vK40sonL6ob7qujVFLu2NHdNJ4dGTRuonuau2LL7g
JG6GWENuko3sW4LKUTdYXtJ3rxy4HA7jMqNreWvDSA==
=Bmkd
-----END PGP SIGNATURE-----

--------------0DeSbFPoopNZI4BfBlhMslIu--
