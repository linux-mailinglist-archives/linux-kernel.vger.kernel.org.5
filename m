Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAB0769559
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 13:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGaL51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 07:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGaL5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 07:57:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E9C1A3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 04:57:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 327C51F385;
        Mon, 31 Jul 2023 11:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690804642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKIqS+DTbkcVKo22Hg+95cZLxs+C/nZoBiviUVxjNYA=;
        b=gZtREKCD2PV6bcf3t6PnoIj2A7l851pW7jrnpMqao8ucqC2IuF5vSY22CMftIO7gsZwJeI
        AYdalE8qsWhoD3n/M8ipl9ilXFtqZ7ytU5du+zJ5hNM4i872zueq1jzxvCJqCArhkxX0Js
        eAFG5Qpt3xdND599aspXXQwRBELg1Mg=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 025281322C;
        Mon, 31 Jul 2023 11:57:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tTmVOqGhx2ThCgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 31 Jul 2023 11:57:21 +0000
Message-ID: <cb9828c7-6901-2157-fce4-20f25a5a47c7@suse.com>
Date:   Mon, 31 Jul 2023 13:57:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Simon Gaiser <simon@invisiblethingslab.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>
References: <20230313134102.3157-1-simon@invisiblethingslab.com>
 <81ca146e-986c-b934-3567-2e1267a31ad7@invisiblethingslab.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH] xen/events: Add wakeup support to xen-pirq
In-Reply-To: <81ca146e-986c-b934-3567-2e1267a31ad7@invisiblethingslab.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vdEt5806AaAAMfjzKlwwXqSJ"
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
--------------vdEt5806AaAAMfjzKlwwXqSJ
Content-Type: multipart/mixed; boundary="------------hnhQy3Gx0sVG2isGs0t0CJIj";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Simon Gaiser <simon@invisiblethingslab.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Stefano Stabellini <sstabellini@kernel.org>
Message-ID: <cb9828c7-6901-2157-fce4-20f25a5a47c7@suse.com>
Subject: Re: [PATCH] xen/events: Add wakeup support to xen-pirq
References: <20230313134102.3157-1-simon@invisiblethingslab.com>
 <81ca146e-986c-b934-3567-2e1267a31ad7@invisiblethingslab.com>
In-Reply-To: <81ca146e-986c-b934-3567-2e1267a31ad7@invisiblethingslab.com>

--------------hnhQy3Gx0sVG2isGs0t0CJIj
Content-Type: multipart/mixed; boundary="------------5UanDc0ouIVA0LprL4AZTBoC"

--------------5UanDc0ouIVA0LprL4AZTBoC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDcuMjMgMTI6MjksIFNpbW9uIEdhaXNlciB3cm90ZToNCj4gU2ltb24gR2Fpc2Vy
Og0KPj4gVGhpcyBhbGxvd3MgZW50ZXJpbmcgYW5kIGV4aXRpbmcgczJpZGxlLiBBY3R1YWwg
UzBpeCByZXNpZGVuY3kgaXMNCj4+IGFub3RoZXIgdG9waWMgWzFdLg0KPj4NCj4+IFdpdGhv
dXQgdGhpcyB0aGUgQUNQSSBjb2RlIGN1cnJlbnRseSBpZ25vcmVzIHRoZSBlcnJvciBlbmFi
bGVfaXJxX3dha2UoKQ0KPj4gcmV0dXJucyB3aGVuIGJlaW5nIHVzZWQgb24gYSB4ZW4tcGly
cSBhbmQgdGhlIHN5c3RlbSBnb2VzIHRvIGlkbGUgZm9yDQo+PiBldmVyIHNpbmNlIHRoZSB3
YWtldXAgSVJRIGRvZXNuJ3QgZ2V0cyBlbmFibGVkLiBXaXRoIFsyXSB0aGUgZXJyb3IgaXMN
Cj4+IGhhbmRsZWQgYW5kIHRoZSBzeXN0ZW0gcmVmdXNlcyB0byBnbyB0byBzMmlkbGUuDQo+
Pg0KPj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcveGVuLWRldmVsLzkwNTFlNDg0
LWIxMjgtNzE1YS05MjUzLTQ4YWY4ZTQ3YmI5ZEBpbnZpc2libGV0aGluZ3NsYWIuY29tLyAj
IFsxXQ0KPj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtYWNwaS8yMDIz
MDMxMzEyNTM0NC4yODkzLTEtc2ltb25AaW52aXNpYmxldGhpbmdzbGFiLmNvbS8gIyBbMl0N
Cj4+IFNpZ25lZC1vZmYtYnk6IFNpbW9uIEdhaXNlciA8c2ltb25AaW52aXNpYmxldGhpbmdz
bGFiLmNvbT4NCj4+IC0tLQ0KPj4NCj4+IFdoaWxlIEkgdGhpbmsgdGhhdCB0aGUgc2V0IG9m
IGZsYWdzIEkgc2V0IGlzIGNvcnJlY3QsIEknbSBub3QgZmFtaWxpYXINCj4+IHdpdGggdGhh
dCBjb2RlLCBzbyBwbGVhc2UgcGF5IHNwZWNpYWwgYXR0ZW50aW9uIGR1cmluZyByZXZpZXcg
aWYgdGhleQ0KPj4gYXJlIGFjdHVhbGx5IGNvcnJlY3QgZm9yIHhlbi1waXJxLg0KPj4NCj4+
ICAgZHJpdmVycy94ZW4vZXZlbnRzL2V2ZW50c19iYXNlLmMgfCA0ICsrKysNCj4+ICAgMSBm
aWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYyBiL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVu
dHNfYmFzZS5jDQo+PiBpbmRleCBjNzcxNWY4YmQ0NTIuLjk5MTA4MmYwNGYwNSAxMDA2NDQN
Cj4+IC0tLSBhL2RyaXZlcnMveGVuL2V2ZW50cy9ldmVudHNfYmFzZS5jDQo+PiArKysgYi9k
cml2ZXJzL3hlbi9ldmVudHMvZXZlbnRzX2Jhc2UuYw0KPj4gQEAgLTIxNzYsNiArMjE3Niwx
MCBAQCBzdGF0aWMgc3RydWN0IGlycV9jaGlwIHhlbl9waXJxX2NoaXAgX19yZWFkX21vc3Rs
eSA9IHsNCj4+ICAgCS5pcnFfc2V0X2FmZmluaXR5CT0gc2V0X2FmZmluaXR5X2lycSwNCj4+
ICAgDQo+PiAgIAkuaXJxX3JldHJpZ2dlcgkJPSByZXRyaWdnZXJfZHluaXJxLA0KPj4gKw0K
Pj4gKwkuZmxhZ3MgICAgICAgICAgICAgICAgICA9IElSUUNISVBfU0tJUF9TRVRfV0FLRSB8
DQo+PiArCQkJCSAgSVJRQ0hJUF9FTkFCTEVfV0FLRVVQX09OX1NVU1BFTkQgfA0KPj4gKwkJ
CQkgIElSUUNISVBfTUFTS19PTl9TVVNQRU5ELA0KPj4gICB9Ow0KPj4gICANCj4+ICAgc3Rh
dGljIHN0cnVjdCBpcnFfY2hpcCB4ZW5fcGVyY3B1X2NoaXAgX19yZWFkX21vc3RseSA9IHsN
Cj4gcGluZw0KDQpTb3JyeSBmb3Igbm90IGFuc3dlcmluZyBlYXJsaWVyLg0KDQpJJ20gbm90
IHN1cmUgYWJvdXQgdGhvc2UgZmxhZ3MgZWl0aGVyLiBVbmZvcnR1bmF0ZWx5IEkgaGF2ZW4n
dCBmb3VuZCBhbnkNCmRvY3VtZW50YXRpb24gb3IgY29tbWVudHMgZGVzY3JpYmluZyB0aGVp
ciBkZXRhaWxlZCBzZW1hbnRpY3MgaW4gYSB3YXkNCmVuYWJsaW5nIG1lIHRvIGRvIGEgdGhv
cm91Z2ggcmV2aWV3Lg0KDQpUaG9tYXMsIGFyZSB5b3Ugc2VlaW5nIGFueSBwcm9ibGVtcyB3
aXRoIHNwZWNpZnlpbmcgdGhvc2UgZmxhZ3M/DQoNCg0KSnVlcmdlbg0K
--------------5UanDc0ouIVA0LprL4AZTBoC
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------5UanDc0ouIVA0LprL4AZTBoC--

--------------hnhQy3Gx0sVG2isGs0t0CJIj--

--------------vdEt5806AaAAMfjzKlwwXqSJ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTHoaEFAwAAAAAACgkQsN6d1ii/Ey9T
mQf+MxoQhQG3qK8+lXVFo8Dcylx11qtwUjvNxY6uDyIz+AqtUwwar76liyoGY3V/Cp6FPFAUGVYx
4G6N0t7FJ9u1RlQIr2jfeLudxFhdu4LWjWrLgntfvN8E019UZF+YCPEaBppibfKQKLl3AkBRQvZl
4N6BeEfoFSunzCJyE25vTfUD10wbenfQI4yVGoPrkwzrz6hd+iTbuGDryMXnqRX2mddjpgnPZnmg
9RQCC99XkMi5a1NB8l3F6xQN86hT6V7uFvgm5PtVdEfsjivakoMzz+iQzyRNk7VAzR8HBzFZzjwm
5NNoPdJCQeVNrL+KJpz2eh2Mfb19EwJVbpzwhjyf5Q==
=kJ4I
-----END PGP SIGNATURE-----

--------------vdEt5806AaAAMfjzKlwwXqSJ--
