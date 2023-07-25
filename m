Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45AF760C78
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGYHy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGYHyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:54:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A47FBF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:54:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 36B371F74C;
        Tue, 25 Jul 2023 07:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690271693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=igjqLOUndV0llKBZReZGwl1hYmK7O2hDw+Z4/9yZX8M=;
        b=C7adS2yoYoVvIyH20vrfTMjPB5nDwXUo24uzLpbZJFiwqaXX2xMWQwmxQQlPR7yMhOi1JR
        A+uIvUfe7nioZ+ilkBOmzcIdRFAJTVfX7a8JdULfy5rmDfJhbkPajAmjOUq55MKP8D8Trv
        KXHkgqQyYJevZjHmagGb8oTSXM6vWYU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C339513342;
        Tue, 25 Jul 2023 07:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YejKLcx/v2QtJAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 25 Jul 2023 07:54:52 +0000
Message-ID: <8466d82c-d4ff-8302-2475-ae1acc09da38@suse.com>
Date:   Tue, 25 Jul 2023 09:54:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V3 1/2] xen: Update dm_op.h from Xen public header
Content-Language: en-US
To:     Jan Beulich <jbeulich@suse.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        stratos-dev@op-lists.linaro.org,
        Erik Schilling <erik.schilling@linaro.org>,
        Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
References: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
 <1498bef6-ded0-1b1f-a5ca-e8755800b489@suse.com>
 <20230725070914.m3dxlokedrgjlgcu@vireshk-i7>
 <3770f13f-0621-48af-4c79-880a0ffaa8a6@suse.com>
 <20230725074218.zcgbkkx5pfgszimu@vireshk-i7>
 <920ede72-c2fb-c814-7b1c-aa488e400f83@suse.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <920ede72-c2fb-c814-7b1c-aa488e400f83@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------JL4MhcBsBYwNo14ivZLIVRNV"
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
--------------JL4MhcBsBYwNo14ivZLIVRNV
Content-Type: multipart/mixed; boundary="------------YVvyqzcome6DaI7ZaEhR27cg";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Jan Beulich <jbeulich@suse.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org, Erik Schilling <erik.schilling@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Message-ID: <8466d82c-d4ff-8302-2475-ae1acc09da38@suse.com>
Subject: Re: [PATCH V3 1/2] xen: Update dm_op.h from Xen public header
References: <ffae9d7021829fea19fd93fda3c30b52b0af923e.1690190453.git.viresh.kumar@linaro.org>
 <1498bef6-ded0-1b1f-a5ca-e8755800b489@suse.com>
 <20230725070914.m3dxlokedrgjlgcu@vireshk-i7>
 <3770f13f-0621-48af-4c79-880a0ffaa8a6@suse.com>
 <20230725074218.zcgbkkx5pfgszimu@vireshk-i7>
 <920ede72-c2fb-c814-7b1c-aa488e400f83@suse.com>
In-Reply-To: <920ede72-c2fb-c814-7b1c-aa488e400f83@suse.com>

--------------YVvyqzcome6DaI7ZaEhR27cg
Content-Type: multipart/mixed; boundary="------------hzgYDLsIxTgAe0GpXazwiSlp"

--------------hzgYDLsIxTgAe0GpXazwiSlp
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjUuMDcuMjMgMDk6NDksIEphbiBCZXVsaWNoIHdyb3RlOg0KPiBPbiAyNS4wNy4yMDIz
IDA5OjQyLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+PiBPbiAyNS0wNy0yMywgMDk6MTgsIEph
biBCZXVsaWNoIHdyb3RlOg0KPj4+IEkgcXVlc3Rpb24gdGhhdCB1c2UsIGJ0dywgYnV0IGl0
IGlzIG5vdCB1cCB0byBtZSB0byBkZWNpZGUgd2hldGhlciB0bw0KPj4+IGFjY2VwdCBzdWNo
IGEgbGF5ZXJpbmcgdmlvbGF0aW9uIGluIExpbnV4LiBkbS1vcCBpcywgYXMgaXRzIG5hbWUg
c2F5cywNCj4+PiBmb3IgZGV2aWNlIG1vZGVscyB0byB1c2UuIFlvdXIgaW50ZW5kZWQgdXNl
IGRvZXNuJ3QgZmFsbCBpbiB0aGF0DQo+Pj4gY2F0ZWdvcnksIGFpdWkuIEltbyB0aGUgcHJl
c2VudCBjb250ZW50cyBvZiBkbV9vcC5oIGluIExpbnV4IGlzIGluZGVlZA0KPj4+IGFsbCBh
IGtlcm5lbCBpcyBzdXBwb3NlZCB0byBrbm93IGFib3V0LCB1bmxlc3MgaXQgd2FzIHRvIGdh
aW4gaW4ta2VybmVsDQo+Pj4gZGV2aWNlIG1vZGVscy4NCj4+DQo+PiBJcyB0aGVyZSBhbnkg
b3RoZXIgd2F5IGJ5IHdoaWNoIGFuIGludGVycnVwdCBjYW4gYmUgcmFpc2VkIGZvciB0aGUN
Cj4+IGd1ZXN0IFZNID8gSSB3YXMgb25seSBhd2FyZSBvZiB0aGlzIG1ldGhvZCBhbmQgc28g
aW1wbGVtZW50ZWQgaXQgbGlrZQ0KPj4gdGhpcy4NCj4+DQo+PiBJIGFtIG9wZW4gdG8gc3Vn
Z2VzdGlvbnMgb24gdGhpcy4NCj4gDQo+IFdlbGwuIEkgZG9uJ3Qga25vdyB5b3VyIHJlcXVp
cmVtZW50cy4gR2VuZXJhbGx5IEkgd291bGQgc3VnZ2VzdCB1c2luZw0KPiBldmVudCBjaGFu
bmVscywgbm90IGludGVycnVwdHMsIHdoZW4gdGFsa2luZyBhYm91dCBpbmplY3RpbmcgZXZl
bnRzDQo+IGludG8gZ3Vlc3RzLiBJZiBpdCBzdHJpY3RseSBuZWVkcyB0byBiZSBhbiBpbnRl
cnJ1cHQsIHRoZW4gSSBndWVzcyBhDQo+IG5vbi1kbS1vcCBtZWFucyB3b3VsZCBuZWVkIGlu
dHJvZHVjaW5nIGlmIG5vbmUgYWxyZWFkeSBleGlzdHMuDQoNCkkgdGhpbmsgdGhlIGJlc3Qg
d2F5IHdvdWxkIGJlIHRvIGxldCB0aGUgdXNlciBtb2RlIGRldmljZSBtb2RlbCAoaS5lLiB0
aGUNCmJhY2tlbmQpIGNvbnN0cnVjdCB0aGUgZG0tb3AgcGFyYW1ldGVycyBsaWtlIHFlbXUg
aXMgZG9pbmcgaXQgYW5kIHBhc3MgaXQNCnZpYSB0aGUgaW9jdGwgdG8gdGhlIHByaXZjbWQg
ZHJpdmVyIGFzIHBhcnQgb2Ygc3RydWN0IHByaXZjbWRfaXJxZmQuIFRoZW4NCml0IHdvdWxk
IGJlIG9wYXF1ZSB0byB0aGUga2VybmVsIGxpa2UgZXZlcnkgb3RoZXIgZG0tb3AuDQoNCg0K
SnVlcmdlbg0KDQo=
--------------hzgYDLsIxTgAe0GpXazwiSlp
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------hzgYDLsIxTgAe0GpXazwiSlp--

--------------YVvyqzcome6DaI7ZaEhR27cg--

--------------JL4MhcBsBYwNo14ivZLIVRNV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmS/f8wFAwAAAAAACgkQsN6d1ii/Ey9V
5Qf/afTWZb8SmxR62nYwuB7eC64OtFZRVwz55tH7meJhDs1Hvk6nGWXoprhtHmmtS2sEnQH6rR2r
oFk2jLq1TtV60vmkQpQyVgJRAmILxckUNgENMlsK+6SekVE8akLBXzQ2gchxZeu3xILJrRuB3CeA
8LiUuEN3vrjigrg+0COrO8AuRyx3sH39N2WGviVU6pa3eTsQdohpl79W4Y/R9wSDFDWOfIKd4jRl
FgICR88NxaY6vJjGVoNo4evpV3XhRzpnLrDXF3NLehYARKmS/EEHAa0kW1KMKH+yzOwehRpgbXgL
InTEzR4VULuhKSn+hauyNg0hKxKV3K/tmJMIhdO+SQ==
=hHoe
-----END PGP SIGNATURE-----

--------------JL4MhcBsBYwNo14ivZLIVRNV--
