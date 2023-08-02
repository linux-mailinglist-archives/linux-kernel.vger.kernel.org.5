Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA0776CC23
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjHBL4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbjHBL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:56:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC65E273A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:56:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 854B21F74D;
        Wed,  2 Aug 2023 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690977399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XMK9R+QQseObqkUFXRQpHJRWnpwg0vdKiMgN6PaIokk=;
        b=TuShkOPcLwrF2uabKtMNgirjCXYDHIfm7NjFI2GbFYBRqvNX+Kd7BTHr5N2boo9nvEcqHp
        l0x/S7N5BAo0evgG/SyXXXK+PeCWAhdq1oaICIpZKa5rCKOlxkeJjaTd7jYVi+01s1mYoL
        uSr6TNInxigzPApgbfZ+6Oor/AOrgqI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36AD413909;
        Wed,  2 Aug 2023 11:56:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7wYCDHdEymQKOQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Aug 2023 11:56:39 +0000
Message-ID: <2529ef0a-efad-d36c-42b1-478f0869326c@suse.com>
Date:   Wed, 2 Aug 2023 13:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch V3 00/40] x86/cpu: Rework the topology evaluation
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
References: <20230802101635.459108805@linutronix.de>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230802101635.459108805@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bdMmOvZbS0X2bt8wUYPQynHw"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bdMmOvZbS0X2bt8wUYPQynHw
Content-Type: multipart/mixed; boundary="------------3SsGS4jdEppOEAjEximbuPmy";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Michael Kelley <mikelley@microsoft.com>, Wei Liu <wei.liu@kernel.org>
Message-ID: <2529ef0a-efad-d36c-42b1-478f0869326c@suse.com>
Subject: Re: [patch V3 00/40] x86/cpu: Rework the topology evaluation
References: <20230802101635.459108805@linutronix.de>
In-Reply-To: <20230802101635.459108805@linutronix.de>

--------------3SsGS4jdEppOEAjEximbuPmy
Content-Type: multipart/mixed; boundary="------------ArlPww6NodM75mCSG0VERF30"

--------------ArlPww6NodM75mCSG0VERF30
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDIuMDguMjMgMTI6MjAsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gSGkhDQo+IA0K
PiBUaGlzIGlzIHRoZSBmb2xsb3cgdXAgdG8gVjI6DQo+IA0KPiAgICBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjMwNzI4MTA1NjUwLjU2NTc5OTc0NEBsaW51dHJvbml4LmRl
DQo+IA0KPiB3aGljaCBhZGRyZXNzZXMgdGhlIHJldmlldyBmZWVkYmFjayBhbmQgc29tZSBm
YWxsb3V0IHJlcG9ydGVkIG9uIGFuZA0KPiBvZmYtbGlzdC4NCj4gDQo+IFRMRFI6DQo+IA0K
PiBUaGlzIHJld29ya3MgdGhlIHdheSBob3cgdG9wb2xvZ3kgaW5mb3JtYXRpb24gaXMgZXZh
bHVhdGVkIHZpYSBDUFVJRA0KPiBpbiBwcmVwYXJhdGlvbiBmb3IgYSBsYXJnZXIgdG9wb2xv
Z3kgbWFuYWdlbWVudCBvdmVyaGF1bCB0byBhZGRyZXNzDQo+IHNob3J0Y29taW5ncyBvZiB0
aGUgY3VycmVudCBjb2RlIHZzLiBoeWJyaWQgc3lzdGVtcyBhbmQgc3lzdGVtcyB3aGljaCBt
YWtlDQo+IHVzZSBvZiB0aGUgZXh0ZW5kZWQgdG9wb2xvZ3kgZG9tYWlucyBpbiBsZWFmIDB4
MWYuIEFzaWRlIG9mIHRoYXQgaXQncyBhbg0KPiBvdmVyZHVlIHNwcmluZyBjbGVhbmluZyB0
byBnZXQgcmlkIG9mIGFjY3VtdWxhdGVkIGxheWVycyBvZiBkdWN0IHRhcGUgYW5kDQo+IGhh
eXdpcmUuDQo+IA0KPiBXaGF0IGNoYW5nZWQgdnMuIFYyOg0KPiANCj4gICAgLSBEZWNvZGVk
IGFuZCBmaXhlZCB0aGUgZmFsbG91dCB2cy4gWEVOL1BWIHJlcG9ydGVkIGJ5IEp1ZXJnZW4u
IFRoYW5rcyB0bw0KPiAgICAgIEp1ZXJnZW4gZm9yIHRoZSByZW1vdGUgaGFuZCBkZWJ1Z2dp
bmcgc2Vzc2lvbnMhDQo+IA0KPiAgICAgIFRoYXQncyBhZGRyZXNzZWQgaW4gdGhlIGZpcnN0
IHR3byBuZXcgcGF0Y2hlcyBpbiB0aGlzIHNlcmllcy4gU3VtbWFyeToNCj4gICAgICBYRU4v
UFYgYm9vdGVkIGJ5IHB1cmUgY2hhbmNlIHNpbmNlIHRoZSBhZGRpdGlvbiBvZiBTTVQgY29u
dHJvbCA1IHllYXJzDQo+ICAgICAgYWdvLg0KPiANCj4gICAgLSBGaXhlZCB0aGUgb2ZmIGJ5
IG9uZSBpbiB0aGUgQU1EIHBhcnNlciB3aGljaCB3YXMgZGVidWdnZWQgYnkgTWljaGFlbA0K
PiANCj4gICAgLSBBZGRyZXNzZWQgcmV2aWV3IGNvbW1lbnRzIGZyb20gdmFyaW91cyBwZW9w
bGUNCj4gDQo+IEFzIGRpc2N1c3NlZCBpbjoNCj4gDQo+ICAgIGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvQllBUFIyMU1CMTY4ODlGRDIyNDM0NEIxQjI4QkUyMkExRDcwNUFAQllB
UFIyMU1CMTY4OC5uYW1wcmQyMS5wcm9kLm91dGxvb2suY29tDQo+ICAgIC4uLi4NCj4gICAg
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC84N3Iwb21qdDhjLmZmc0B0Z2x4DQo+IA0K
PiB0aGlzIHNlcmllcyB1bmZvcnR1bmF0ZWx5IGJyaW5ncyB0aGUgSHlwZXItViBCSU9TIGlu
Y29uc2lzdGVuY3kgaW50bw0KPiBlZmZlY3QsIHdoaWNoIHJlc3VsdHMgaW4gYSBzbGlnaHQg
cGVyZm9ybWFuY2UgaW1wYWN0LiBUaGUgTDMgYXNzb2NpYXRpb24NCj4gd2hpY2ggIndvcmtl
ZCIgc28gZmFyIGJ5IGV4cGxvaXRpbmcgdGhlIGluY29uc2lzdGVuY3kgb2YgdGhlIExpbnV4
IHRvcG9sb2d5DQo+IGNvZGUgaXMgbm90IGxvbmdlciBzdXBwb3J0YWJsZSBhcyB3ZSByZWFs
bHkgbmVlZCB0byBnZXQgdGhlIGFjdHVhbCBzaG9ydA0KPiBjb21pbmdzIG9mIG91ciB0b3Bv
bG9neSBtYW5hZ2VtZW50IGFkZHJlc3NlZCBpbiBhIGNvbnNpc3RlbnQgd2F5Lg0KPiANCj4g
VGhlIHNlcmllcyBpcyBiYXNlZCBvbiBWMyBvZiB0aGUgQVBJQyBjbGVhbnVwIHNlcmllczoN
Cj4gDQo+ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMzA4MDExMDMwNDIu
OTM2MDIwMzMyQGxpbnV0cm9uaXguZGUNCj4gDQo+IGFuZCBhbHNvIGF2YWlsYWJsZSBvbiB0
b3Agb2YgdGhhdCBmcm9tIGdpdDoNCj4gDQo+ICAgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9saW51eC9rZXJuZWwvZ2l0L3RnbHgvZGV2ZWwuZ2l0IHRvcG8tY3B1aWQtdjMNCj4g
DQo+IFRoYW5rcywNCj4gDQo+IAl0Z2x4DQoNCkZvciBYZW4gUFYgKGRvbTAgYW5kIHVucHJp
dmlsZWdlZCBndWVzdCk6DQoNClRlc3RlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1
c2UuY29tPg0KDQoNCkp1ZXJnZW4NCg0K
--------------ArlPww6NodM75mCSG0VERF30
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ArlPww6NodM75mCSG0VERF30--

--------------3SsGS4jdEppOEAjEximbuPmy--

--------------bdMmOvZbS0X2bt8wUYPQynHw
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTKRHYFAwAAAAAACgkQsN6d1ii/Ey8x
BQf9H7DKa39Nr6xxxjLY8hgjDH7KwHu6Futpdw/xh9rLvXYFC/Pt10g0CtYTk9f1o2PpWzhAUBSK
Du2ppGVZQBSY3qmWldEYrFxJtZJw9MpZQk1M7UYpoApmiemig7JvZlMPNyPTWHA5X9bhCsYUKRBm
EwfWhoZqD1Sw9faneG9tRp+/Rm4TpyUu4yrOETecxvUbRFHnsAn3HHF2wYjeEGxZezjoROIDp6E7
Zcaq7+Rlnam8KA+pRKzG8h+pwfwaqV/cKxQEgHBaqgXdHimds1XNFkpeTx514Kf1T9rIUyjf31Be
zCaYlRrsyn/mhpHSJP8GlB76I9n2XWhxVQ+mfFCVNg==
=isL0
-----END PGP SIGNATURE-----

--------------bdMmOvZbS0X2bt8wUYPQynHw--
