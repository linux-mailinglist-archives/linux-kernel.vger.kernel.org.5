Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5039760D5F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjGYIoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjGYIn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:43:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8BB2100
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:42:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A099E2238C;
        Tue, 25 Jul 2023 08:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690274542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LN7abiJtxMulznyHMJQAdbbO9gDCYknD/hJxzBUtmVQ=;
        b=PATFFidW84PmyG8pAzJVd201JO8jdl1/apw99ALckAW7AXbBWQTc9E1tK3+1EpvVQDMd3d
        Z/yk47DhnFqy8JFvJkaA05WLhbJg9BDA6XwN2zQBoNzb08PR2XmmDpChaSRijWTREZ8BSi
        jeBI26Bn9ejxZio9MBPpKtncxgcyieU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5155113342;
        Tue, 25 Jul 2023 08:42:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DjgWEe6Kv2TuPgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 25 Jul 2023 08:42:22 +0000
Message-ID: <938e9198-8684-6e1b-d3a9-4601bedd2004@suse.com>
Date:   Tue, 25 Jul 2023 10:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 2/2] xen: privcmd: Add support for irqfd
Content-Language: en-US
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
 <8c1ea7faa0fe5deed1b2c86ea0f73e824f8a001d.1690190453.git.viresh.kumar@linaro.org>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <8c1ea7faa0fe5deed1b2c86ea0f73e824f8a001d.1690190453.git.viresh.kumar@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------0pVDYdB0AhBfd9mnjxflwa0K"
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
--------------0pVDYdB0AhBfd9mnjxflwa0K
Content-Type: multipart/mixed; boundary="------------cU0FjSzGoxJGMDvaoRzrxGMA";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Viresh Kumar <viresh.kumar@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org, Erik Schilling <erik.schilling@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <938e9198-8684-6e1b-d3a9-4601bedd2004@suse.com>
Subject: Re: [PATCH V3 2/2] xen: privcmd: Add support for irqfd
References: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
 <8c1ea7faa0fe5deed1b2c86ea0f73e824f8a001d.1690190453.git.viresh.kumar@linaro.org>
In-Reply-To: <8c1ea7faa0fe5deed1b2c86ea0f73e824f8a001d.1690190453.git.viresh.kumar@linaro.org>

--------------cU0FjSzGoxJGMDvaoRzrxGMA
Content-Type: multipart/mixed; boundary="------------dN83e0dptSsRjzwwXIJxoum7"

--------------dN83e0dptSsRjzwwXIJxoum7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDcuMjMgMDg6NDcsIFZpcmVzaCBLdW1hciB3cm90ZToNCj4gWGVuIHByb3ZpZGVz
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
Zz4NCj4gLS0tDQo+IFYyLjEtPlYzDQo+IC0gTm8gY2hhbmdlcw0KPiANCj4gVjItPlYyLjEN
Cj4gLSBTZWxlY3QgRVZFTlRGRCBmcm9tIEtjb25maWcNCj4gDQo+IFYxLT5WMjoNCj4gLSBJ
bXByb3ZlIGVycm9yIGhhbmRsaW5nLg0KPiAtIFJlbW92ZSB0aGUgdW5uZWNlc3NhcnkgdXNh
Z2Ugb2YgbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKCkuDQo+IC0gUmVzdHJpY3QgdGhlIHVz
ZSBvZiBYRU5fRE1PUF9zZXRfaXJxX2xldmVsIHRvIG9ubHkgQVJNNjQuDQo+IA0KPiAgIGRy
aXZlcnMveGVuL0tjb25maWcgICAgICAgIHwgICAxICsNCj4gICBkcml2ZXJzL3hlbi9wcml2
Y21kLmMgICAgICB8IDI3NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
DQo+ICAgaW5jbHVkZS91YXBpL3hlbi9wcml2Y21kLmggfCAgMTQgKysNCj4gICAzIGZpbGVz
IGNoYW5nZWQsIDI4OSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMveGVuL0tjb25maWcgYi9kcml2ZXJzL3hlbi9LY29uZmlnDQo+
IGluZGV4IGQ1ZDdjNDAyYjY1MS4uNzk2NzM5M2M1NWE0IDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL3hlbi9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMveGVuL0tjb25maWcNCj4gQEAgLTI2
MSw2ICsyNjEsNyBAQCBjb25maWcgWEVOX1NDU0lfQkFDS0VORA0KPiAgIGNvbmZpZyBYRU5f
UFJJVkNNRA0KPiAgIAl0cmlzdGF0ZSAiWGVuIGh5cGVyY2FsbCBwYXNzdGhyb3VnaCBkcml2
ZXIiDQo+ICAgCWRlcGVuZHMgb24gWEVODQo+ICsJc2VsZWN0IEVWRU5URkQNCg0KSSBkb24n
dCBsaWtlIHRoaXMuIENhbiB3ZSBtYXliZSBhZGQgYW5vdGhlciBib29sIGNvbmZpZyBpdGVt
IGRlcGVuZGluZyBvbg0KWEVOX1BSSVZDTUQsIEVWRU5URkQgYW5kIFhFTl9WSVJUSU8sIHdo
aWNoIGNhbiB0aGVuIGJlIHVzZWQgdG8gZ3VhcmQgdGhlDQpjb2RlIGFkZGl0aW9ucyB0byBw
cml2Y21kLmM/DQoNClRoaXMgd291bGQgYXZvaWQgYWRkaW5nIGFkZGl0aW9uYWwgY29kZSBm
b3IgZXZlcnlvbmUuDQoNCg0KSnVlcmdlbg0K
--------------dN83e0dptSsRjzwwXIJxoum7
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------dN83e0dptSsRjzwwXIJxoum7--

--------------cU0FjSzGoxJGMDvaoRzrxGMA--

--------------0pVDYdB0AhBfd9mnjxflwa0K
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmS/iu0FAwAAAAAACgkQsN6d1ii/Ey8L
ZAgAgGWQ0HJDC93HDXPsqUP9EcQznNgD/sLKmwPOK44NADZZQZbVsnQBCUWM07L10NMR2DHXrczI
pR/G/PEXWQwT+taHkSgYnsacP2u2toXo0YT6bez76Ycg2SaDV/CWHZXJHNJC3tasajgqP15+xPvo
M0OSufBdOAVNHjNrp+L03AgeCBPW6wIdd/2i298Z7e4T9OmWPjC3wzKPRNIz/x5ikfP9v1bwp/Sa
ZB0n91pKvs0Md6OeNE0+dcK0F1WNojvX637J809uFgI+CokLfTyEKt/QQ9V/aHHKadlgQDRJ1sb0
h6sk3nYDlLpWJc5p4HAT0kRqNp/FHsLzzO+4YZGASQ==
=OaDI
-----END PGP SIGNATURE-----

--------------0pVDYdB0AhBfd9mnjxflwa0K--
