Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED6B783DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234711AbjHVKN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjHVKN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:13:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310AC18B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 03:13:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E2FD022C0E;
        Tue, 22 Aug 2023 10:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1692699201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=xxCcJFVkWGPHiHfALfVE0+DCBpvjCYia2iGwSRYbf5w=;
        b=KQx9SdXusYeOdhZYEB6tFvaZ3ekgvv0NUG5SjUl+6toL/UGNYm8VhFUwKeaztbS1lh7F5p
        xsfiJ6TJXM1WjQNFkNZxEecQmGe7wIopHs1/WQ8170L4hzf2zULhINQCM1CKGCKpI5/fDw
        1StxxGOm8nN5RyTYtZHR/VUoUWyZfNk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92FB013919;
        Tue, 22 Aug 2023 10:13:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0EiQIkGK5GTqHQAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 22 Aug 2023 10:13:21 +0000
Message-ID: <54463c4e-53a3-42ef-9d9f-541f89e8c9ef@suse.com>
Date:   Tue, 22 Aug 2023 12:13:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] xen: privcmd: Add support for irqfd
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
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <8e724ac1f50c2bc1eb8da9b3ff6166f1372570aa.1692697321.git.viresh.kumar@linaro.org>
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
In-Reply-To: <8e724ac1f50c2bc1eb8da9b3ff6166f1372570aa.1692697321.git.viresh.kumar@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ta7AK0jE88raaRbponKSi42H"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ta7AK0jE88raaRbponKSi42H
Content-Type: multipart/mixed; boundary="------------11VIutkP0Hpet8JeFn8Lb0aZ";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org, Erik Schilling <erik.schilling@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <54463c4e-53a3-42ef-9d9f-541f89e8c9ef@suse.com>
Subject: Re: [PATCH V5] xen: privcmd: Add support for irqfd
References: <8e724ac1f50c2bc1eb8da9b3ff6166f1372570aa.1692697321.git.viresh.kumar@linaro.org>
In-Reply-To: <8e724ac1f50c2bc1eb8da9b3ff6166f1372570aa.1692697321.git.viresh.kumar@linaro.org>

--------------11VIutkP0Hpet8JeFn8Lb0aZ
Content-Type: multipart/mixed; boundary="------------tabT1XCUkQLuhkT5gVwGPtP8"

--------------tabT1XCUkQLuhkT5gVwGPtP8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjIuMDguMjMgMTE6NDUsIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gWGVuIHByb3ZpZGVz
IHN1cHBvcnQgZm9yIGluamVjdGluZyBpbnRlcnJ1cHRzIHRvIHRoZSBndWVzdHMgdmlhIHRo
ZQ0KPiBIWVBFUlZJU09SX2RtX29wKCkgaHlwZXJjYWxsLiBUaGUgc2FtZSBpcyB1c2VkIGJ5
IHRoZSBWaXJ0aW8gYmFzZWQNCj4gZGV2aWNlIGJhY2tlbmQgaW1wbGVtZW50YXRpb25zLCBp
biBhbiBpbmVmZmljaWVudCBtYW5uZXIgY3VycmVudGx5Lg0KPiANCj4gR2VuZXJhbGx5LCB0
aGUgVmlydGlvIGJhY2tlbmRzIGFyZSBpbXBsZW1lbnRlZCB0byB3b3JrIHdpdGggdGhlIEV2
ZW50ZmQNCj4gYmFzZWQgbWVjaGFuaXNtLiBJbiBvcmRlciB0byBtYWtlIHN1Y2ggYmFja2Vu
ZHMgd29yayB3aXRoIFhlbiwgYW5vdGhlcg0KPiBzb2Z0d2FyZSBsYXllciBuZWVkcyB0byBw
b2xsIHRoZSBFdmVudGZkcyBhbmQgcmFpc2UgYW4gaW50ZXJydXB0IHRvIHRoZQ0KPiBndWVz
dCB1c2luZyB0aGUgWGVuIGJhc2VkIG1lY2hhbmlzbS4gVGhpcyByZXN1bHRzIGluIGFuIGV4
dHJhIGNvbnRleHQNCj4gc3dpdGNoLg0KPiANCj4gVGhpcyBpcyBub3QgYSBuZXcgcHJvYmxl
bSBpbiBMaW51eCB0aG91Z2guIEl0IGlzIHByZXNlbnQgd2l0aCBvdGhlcg0KPiBoeXBlcnZp
c29ycyBsaWtlIEtWTSwgZXRjLiBhcyB3ZWxsLiBUaGUgZ2VuZXJpYyBzb2x1dGlvbiBpbXBs
ZW1lbnRlZCBpbg0KPiB0aGUga2VybmVsIGZvciB0aGVtIGlzIHRvIHByb3ZpZGUgYW4gSU9D
VEwgY2FsbCB0byBwYXNzIHRoZSBpbnRlcnJ1cHQNCj4gZGV0YWlscyBhbmQgZXZlbnRmZCwg
d2hpY2ggbGV0cyB0aGUga2VybmVsIHRha2UgY2FyZSBvZiBwb2xsaW5nIHRoZQ0KPiBldmVu
dGZkIGFuZCByYWlzaW5nIG9mIHRoZSBpbnRlcnJ1cHQsIGluc3RlYWQgb2YgaGFuZGxpbmcg
dGhpcyBpbiB1c2VyDQo+IHNwYWNlICh3aGljaCBpbnZvbHZlcyBhbiBleHRyYSBjb250ZXh0
IHN3aXRjaCkuDQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgc3VwcG9ydCB0byBpbmplY3QgYSBz
cGVjaWZpYyBpbnRlcnJ1cHQgdG8gZ3Vlc3QgdXNpbmcNCj4gdGhlIGV2ZW50ZmQgbWVjaGFu
aXNtLCBieSBwcmV2ZW50aW5nIHRoZSBleHRyYSBjb250ZXh0IHN3aXRjaC4NCj4gDQo+IElu
c3BpcmVkIGJ5IGV4aXN0aW5nIGltcGxlbWVudGF0aW9ucyBmb3IgS1ZNLCBldGMuLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogVmlyZXNoIEt1bWFyIDx2aXJlc2gua3VtYXJAbGluYXJvLm9y
Zz4NCg0KUmV2aWV3ZWQtYnk6IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCg0K
DQpKdWVyZ2VuDQoNCg==
--------------tabT1XCUkQLuhkT5gVwGPtP8
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------tabT1XCUkQLuhkT5gVwGPtP8--

--------------11VIutkP0Hpet8JeFn8Lb0aZ--

--------------ta7AK0jE88raaRbponKSi42H
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTkikEFAwAAAAAACgkQsN6d1ii/Ey+b
ZQf/c2Y5JkxuVsReoIua5GNLlHD+KlZJZhhjGbu4BjqyPmDLamsF3OHciwYdiIB/dtLjR/0S/c2a
GYF7KqPHeN34f+dv+fmZ8MdDETgql012DXoFSzKcR/9l1mgG9uwFd1WgyJhVrS3t6j4RXzdmQpm7
j4W8QZALDS+W58XYma8/x2IlNcNVE0I202EkU7b0TpnleXg+6g1FjGdlLTUMiA9uER0AG/VysO7l
OWiuAzCKa527YbY9DCYo2ssV+tNEvFyi2AjyL+6uyZ6J3XltSdzGkazbFtxIzCQhoiraJxPJJ6Wm
U++p7oNrhxBrX6NOqDxL1ikiqFtpmpw6bEVuBoAUYQ==
=XKIk
-----END PGP SIGNATURE-----

--------------ta7AK0jE88raaRbponKSi42H--
