Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435F1773FC9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjHHQxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjHHQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:52:15 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5234C178
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:58:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0CCA62247C;
        Tue,  8 Aug 2023 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691480403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=1Ryf8CMgU5LMYdyn/velrmcQmRJQi44p1KWAJ5dMx7w=;
        b=c7x8/YkqlPk0ZcDdLFKSScPrJkrWPMV8GFLrIzOjNDBRf1Wmhvbkbn3CwqzWHWSi5AID6W
        RO9rtmkQIpOmOhGJgLJQUx8s3m7ZTtGvLE1XDNInxroJorMxtbN1SXtxWLk4rNeZdeOxfc
        6UAJ2s/87EjWXMTID+ulPtO5Nacz+is=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8F69713451;
        Tue,  8 Aug 2023 07:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QjzWIFLx0WTzYwAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 08 Aug 2023 07:40:02 +0000
Message-ID: <8d650d5c-e7b8-99c3-e561-3d177e6189bd@suse.com>
Date:   Tue, 8 Aug 2023 09:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/53] x86/topology: The final installment
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andy@infradead.org>
References: <20230807130108.853357011@linutronix.de>
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
In-Reply-To: <20230807130108.853357011@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Ww2tR0C8w8fDezIlvNBeMAaG"
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
--------------Ww2tR0C8w8fDezIlvNBeMAaG
Content-Type: multipart/mixed; boundary="------------B1EAGj4C09WxELOnxXjXl071";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Michael Kelley <mikelley@microsoft.com>, Sohil Mehta
 <sohil.mehta@intel.com>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>
Message-ID: <8d650d5c-e7b8-99c3-e561-3d177e6189bd@suse.com>
Subject: Re: [patch 00/53] x86/topology: The final installment
References: <20230807130108.853357011@linutronix.de>
In-Reply-To: <20230807130108.853357011@linutronix.de>

--------------B1EAGj4C09WxELOnxXjXl071
Content-Type: multipart/mixed; boundary="------------KchcUZtiqi8Rore3CwGd3Aua"

--------------KchcUZtiqi8Rore3CwGd3Aua
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDcuMDguMjMgMTU6NTIsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gSGkhDQo+IA0K
PiBUaGlzIGlzIHRoZSAoZm9yIG5vdykgbGFzdCBwYXJ0IG9mIHJld29ya2luZyB0b3BvbG9n
eSBlbnVtZXJhdGlvbiBhbmQNCj4gbWFuYWdlbWVudC4gSXQncyBiYXNlZCBvbiB0aGUgQVBJ
QyBhbmQgQ1BVSUQgcmV3b3JrIHNlcmllcyB3aGljaCBjYW4gYmUNCj4gZm91bmQgaGVyZToN
Cj4gDQo+ICAgICAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjMwODAyMTAx
NjM1LjQ1OTEwODgwNUBsaW51dHJvbml4LmRlDQo+IA0KPiBXaXRoIHRoZXNlIHByZXBhcmF0
b3J5IGNoYW5nZXMgaW4gcGxhY2UsIGl0J3Mgbm93IHBvc3NpYmxlIHRvIGFkZHJlc3MgdGhl
DQo+IHJlYWwgaXNzdWVzIG9mIHRoZSBjdXJyZW50IHRvcG9sb2d5IGNvZGU6DQo+IA0KPiAg
ICAtIFdyb25nIGNvcmUgY291bnQgb24gaHlicmlkIHN5c3RlbXMNCj4gDQo+ICAgIC0gSGV1
cmlzdGljcyBiYXNlZCBzaXplIGluZm9ybWF0aW9uIGZvciBwYWNrYWdlcyBhbmQgZGllcyB3
aGljaA0KPiAgICAgIGFyZSBmYWlsaW5nIHRvIHdvcmsgY29ycmVjdGx5IHdpdGggY2VydGFp
biBjb21tYW5kIGxpbmUgcGFyYW1ldGVycy4NCj4gDQo+ICAgIC0gRnVsbCBldmFsdWF0aW9u
IGZhaWwgZm9yIGEgdGhlb3JldGljYWwgaHlicmlkIHN5c3RlbSB3aGljaCBib290cw0KPiAg
ICAgIGZyb20gYW4gRS1jb3JlDQo+IA0KPiAgICAtIFRoZSBjb21wbGV0ZSBpbnNhbml0eSBv
ZiBtYW5pcHVsYXRpbmcgZ2xvYmFsIGRhdGEgZnJvbSBmaXJtd2FyZSBwYXJzZXJzDQo+ICAg
ICAgb3IgdGhlIFhFTi9QViBmYWtlIFNNUCBlbnVtZXJhdGlvbi4gVGhlIGxhdHRlciBpcyBy
ZWFsbHkgYSBwaWVjZSBvZiBhcnQuDQo+IA0KPiBUaGlzIHNlcmllcyBhZGRyZXNzZXMgdGhp
cyBieQ0KPiANCj4gICAgLSBNb3BwaW5nIHVwIHNvbWUgbW9yZSBoaXN0b3JpY2FsIHRlY2hu
aWNhbCBkZWJ0DQo+IA0KPiAgICAtIENvbnNvbGlkYXRpbmcgYWxsIHRvcG9sb2d5IHJlbGV2
YW50IGZ1bmN0aW9uYWxpdHkgaW50byBvbmUgcGxhY2UNCj4gDQo+ICAgIC0gUHJvdmlkaW5n
IHNlcGFyYXRlIGludGVyZmFjZXMgZm9yIGJvb3QgdGltZSBhbmQgQUNQSSBob3RwbHVnIG9w
ZXJhdGlvbnMNCj4gDQo+ICAgIC0gQSBzYW5lIG9yZGVyaW5nIG9mIGNvbW1hbmQgbGluZSBv
cHRpb25zIGFuZCByZXN0cmljdGlvbnMNCj4gDQo+ICAgIC0gQSBzZW5zaWJsZSB3YXkgdG8g
aGFuZGxlIHRoZSBCU1AgcHJvYmxlbSBpbiBrZHVtcCBrZXJuZWxzIGluc3RlYWQgb2YNCj4g
ICAgICB0aGUgdW5yZWxpYWJsZSBjb21tYW5kIGxpbmUgb3B0aW9uLg0KPiANCj4gICAgLSBD
b25maW5lbWVudCBvZiB0b3BvbG9neSByZWxldmFudCB2YXJpYWJsZXMgYnkgcmVwbGFjaW5n
IHRoZSBYRU4vUFYgU01QDQo+ICAgICAgZW51bWVyYXRpb24gZmFrZSB3aXRoIHNvbWV0aGlu
ZyBoYWxmd2F5cyBzZW5zaWJsZS4NCj4gDQo+ICAgIC0gRXZhbHVhdGlvbiBvZiBzaXplcyBi
eSBhbmFseXNpbmcgdGhlIHRvcG9sb2d5IHZpYSB0aGUgQ1BVSUQgcHJvdmlkZWQNCj4gICAg
ICBBUElDIElEIHNlZ21lbnRhdGlvbiBhbmQgdGhlIGFjdHVhbCBBUElDIElEcyB3aGljaCBh
cmUgcmVnaXN0ZXJlZCBhdA0KPiAgICAgIGJvb3QgdGltZS4NCj4gDQo+ICAgIC0gUmVtb3Zh
bCBvZiBoZXVyaXN0aWNzIGFuZCBicm9rZW4gc2l6ZSBjYWxjdWxhdGlvbnMNCj4gDQo+IFRo
ZSBpZGVhIGJlaGluZCB0aGlzIGlzIHRoZSBmb2xsb3dpbmc6DQo+IA0KPiBUaGUgQVBJQyBJ
RHMgZGVzY3JpYmUgdGhlIHN5c3RlbSB0b3BvbG9neSBpbiBtdWx0aXBsZSBkb21haW4gbGV2
ZWxzLiBUaGUNCj4gQ1BVSUQgdG9wb2xvZ3kgcGFyc2VyIHByb3ZpZGVzIHRoZSBpbmZvcm1h
dGlvbiB3aGljaCBwYXJ0IG9mIHRoZSBBUElDIElEIGlzDQo+IGFzc29jaWF0ZWQgdG8gdGhl
IGluZGl2aWR1YWwgbGV2ZWxzIChJbnRlbCB0ZXJtaW5vbG9neSk6DQo+IA0KPiAgICAgW1JP
T1RdW1BBQ0tBR0VdW0RJRV1bVElMRV1bTU9EVUxFXVtDT1JFXVtUSFJFQURdDQo+IA0KPiBU
aGUgcm9vdCBzcGFjZSBjb250YWlucyB0aGUgcGFja2FnZSAoc29ja2V0KSBJRHMuIE5vdCBl
bnVtZXJhdGVkIGxldmVscw0KPiBjb25zdW1lIDAgYml0cyBzcGFjZSwgYnV0IGNvbmNlcHR1
YWxseSB0aGV5IGFyZSBhbHdheXMgcmVwcmVzZW50ZWQuIElmDQo+IGUuZy4gb25seSBDT1JF
IGFuZCBUSFJFQUQgbGV2ZWxzIGFyZSBlbnVtZXJhdGVkIHRoZW4gdGhlIERJRSwgTU9EVUxF
IGFuZA0KPiBUSUxFIGhhdmUgdGhlIHNhbWUgcGh5c2ljYWwgSUQgYXMgdGhlIFBBQ0tBR0Uu
DQo+IA0KPiBJZiBTTVQgaXMgbm90IHN1cHBvcnRlZCwgdGhlbiB0aGUgVEhSRUFEIGRvbWFp
biBpcyBzdGlsbCB1c2VkLiBJdCB0aGVuDQo+IGhhcyB0aGUgc2FtZSBwaHlzaWNhbCBJRCBh
cyB0aGUgQ09SRSBkb21haW4gYW5kIGlzIHRoZSBvbmx5IGNoaWxkIG9mDQo+IHRoZSBjb3Jl
IGRvbWFpbi4NCj4gDQo+IFRoaXMgYWxsb3dzIGFuIHVuaWZpZWQgdmlldyBvbiB0aGUgc3lz
dGVtIGluZGVwZW5kZW50IG9mIHRoZSBlbnVtZXJhdGVkDQo+IGRvbWFpbiBsZXZlbHMgd2l0
aG91dCByZXF1aXJpbmcgYW55IGNvbmRpdGlvbmFscyBpbiB0aGUgY29kZS4NCj4gDQo+IEFN
RCBkb2VzIG9ubHkgZXhwb3NlIDQgZG9tYWluIGxldmVscyB3aXRoIG9idmlvdXNseSBkaWZm
ZXJlbnQgdGVybWlub2xvZ3ksDQo+IGJ1dCB0aGF0IGNhbiBiZSBlYXNpbHkgbWFwcGVkIGlu
dG8gdGhlIEludGVsIHZhcmlhbnQgd2l0aCBhIHRyaXZpYWwgbG9va3VwDQo+IHRhYmxlIGFk
ZGVkIHRvIHRoZSBDUFVJRCBwYXJzZXIuDQo+IA0KPiBUaGUgcmVzdWx0aW5nIHRvcG9sb2d5
IGluZm9ybWF0aW9uIG9mIGFuIEFETCBoeWJyaWQgc3lzdGVtIHdpdGggOCBQLUNvcmVzDQo+
IGFuZCA4IEUtQ29yZXMgbG9va3MgbGlrZSB0aGlzOg0KPiANCj4gICBDUFUgdG9wbzogTWF4
LiBsb2dpY2FsIHBhY2thZ2VzOiAgIDENCj4gICBDUFUgdG9wbzogTWF4LiBsb2dpY2FsIGRp
ZXM6ICAgICAgIDENCj4gICBDUFUgdG9wbzogTWF4LiBkaWVzIHBlciBwYWNrYWdlOiAgIDEN
Cj4gICBDUFUgdG9wbzogTWF4LiB0aHJlYWRzIHBlciBjb3JlOiAgIDINCj4gICBDUFUgdG9w
bzogTnVtLiBjb3JlcyBwZXIgcGFja2FnZTogICAgMTYNCj4gICBDUFUgdG9wbzogTnVtLiB0
aHJlYWRzIHBlciBwYWNrYWdlOiAgMjQNCj4gICBDUFUgdG9wbzogQWxsb3dpbmcgMjQgcHJl
c2VudCBDUFVzIHBsdXMgMCBob3RwbHVnIENQVXMNCj4gICBDUFUgdG9wbzogVGhyZWFkICAg
IDogICAgMjQNCj4gICBDUFUgdG9wbzogQ29yZSAgICAgIDogICAgMTYNCj4gICBDUFUgdG9w
bzogTW9kdWxlICAgIDogICAgIDENCj4gICBDUFUgdG9wbzogVGlsZSAgICAgIDogICAgIDEN
Cj4gICBDUFUgdG9wbzogRGllICAgICAgIDogICAgIDENCj4gICBDUFUgdG9wbzogUGFja2Fn
ZSAgIDogICAgIDENCj4gDQo+IFRoaXMgaXMgaGFwcGVuaW5nIG9uIHRoZSBib290IENQVSBi
ZWZvcmUgYW55IG9mIHRoZSBBUHMgaXMgc3RhcnRlZCBhbmQNCj4gcHJvdmlkZXMgY29ycmVj
dCBzaXplIGluZm9ybWF0aW9uIHJpZ2h0IGZyb20gdGhlIHN0YXJ0Lg0KPiANCj4gRXZlbiB0
aGUgWEVOL1BWIHRyYWlud3JlY2sgbWFrZXMgdXNlIG9mIHRoaXMgbm93LiBPbiBEb20wIGl0
IHV0aWxpemVzIHRoZQ0KPiBNQURUIGFuZCBvbiBEb21VIGl0IHByb3ZpZGVzIGZha2UgQVBJ
QyBJRHMsIHdoaWNoIGNvbWJpbmVkIHdpdGggdGhlDQo+IHByb3ZpZGVkIENQVUlEIGluZm9y
bWF0aW9uIG1ha2UgaXQgYXQgbGVhc3QgbG9vayBoYWxmd2F5cyByZWFsaXN0aWMgaW5zdGVh
ZA0KPiBvZiBjbGFpbWluZyB0byBoYXZlIG9uZSBDUFUgcGVyIHBhY2thZ2UgYXMgdGhlIGN1
cnJlbnQgdXBzdHJlYW0gY29kZSBkb2VzLg0KPiANCj4gVGhpcyBpcyBzb2xlbHkgYWRkcmVz
c2luZyB0aGUgY29yZSB0b3BvbG9neSBpc3N1ZXMsIGJ1dCB0aGVyZSBpcyBhIHBsYW4gZm9y
DQo+IGZ1cnRoZXIgY29uc29saWRhdGlvbiBvZiBvdGhlciB0b3BvbG9neSByZWxhdGVkIGlu
Zm9ybWF0aW9uIGludG8gb25lIHNpbmdsZQ0KPiBzb3VyY2Ugb2YgaW5mb3JtYXRpb24gaW5z
dGVhZCBvZiBoYXZpbmcgYSBnYXppbGxpb24gb2YgbG9jYWxpemVkIHNwZWNpYWwNCj4gcGFy
c2VycyBhbmQgcmVwcmVzZW50YXRpb25zIGFsbCBvdmVyIHRoZSBwbGFjZS4gVGhlcmUgYXJl
IHF1aXRlIHNvbWUgb3RoZXINCj4gdGhpbmdzIHdoaWNoIGNhbiBiZSBzaW1wbGlmaWVkIG9u
IHRvcCBvZiB0aGlzLCBsaWtlIHVwZGF0aW5nIHRoZSB2YXJpb3VzDQo+IGNwdW1hc2tzIGR1
cmluZyBDUFUgYnJpbmd1cCwgYnV0IHRoYXQncyBhbGwgbGVmdCBmb3IgbGF0ZXIuDQo+IA0K
PiBTbyBhbm90aGVyIDUzIHBhdGNoZXMgbGF0ZXIsIHRoZSByZXN1bHRpbmcgZGlmZnN0YXQg
aXM6DQo+IA0KPiAgICAgNjQgZmlsZXMgY2hhbmdlZCwgODMwIGluc2VydGlvbnMoKyksIDk1
NSBkZWxldGlvbnMoLSkNCj4gDQo+IGFuZCB0aGUgY29tYm8gZGlmZnN0YXQgb2YgYWxsIHRo
cmVlIHNlcmllcyBjb21iaW5lZDoNCj4gDQo+ICAgIDExNSBmaWxlcyBjaGFuZ2VkLCAyNDE0
IGluc2VydGlvbnMoKyksIDMwMzUgZGVsZXRpb25zKC0pDQo+IA0KPiBUaGUgY3VycmVudCBz
ZXJpZXMgYXBwbGllcyBvbiB0b3Agb2YNCj4gDQo+ICAgICBnaXQ6Ly9naXQua2VybmVsLm9y
Zy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9kZXZlbC5naXQgdG9wby1jcHVpZC12
Mw0KPiANCj4gYW5kIGlzIGF2YWlsYWJsZSBmcm9tIGdpdCBoZXJlOg0KPiANCj4gICAgIGdp
dDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90Z2x4L2RldmVs
LmdpdCB0b3BvLWZ1bGwtdjENCg0KVGVzdGVkIG9uIGFuIEludGVsIHN5c3RlbSB3aXRoIFhl
bjoNCg0KLSBQViBkb20wIGlzIHdvcmtpbmcgZmluZS4gSSBjb3VsZG4ndCB0ZXN0IHBoeXNp
Y2FsIGNwdSBob3RwbHVnLCBidXQgcmVtb3ZpbmcNCiAgIGFuZCB0aGVuIHJlLWFkZGluZyB2
Y3B1cyB0byBkb20wIHdvcmtlZC4NCg0KLSBQViBkb21VIGlzIHdvcmtpbmcgZmluZSwgdG9v
LiBBIHRlc3Qgd2l0aCBzdGFydGluZyB1c2luZyAyIHZjcHVzIGluaXRpYWxseQ0KICAgYW5k
IG9ubGluaW5nIGFub3RoZXIgMiB2Y3B1cyBsYXRlciB3YXMgZG9pbmcgZmluZS4NCg0KU28g
Zm9yIFhlbiBQViB5b3UgY2FuIGFkZCBteToNCg0KVGVzdGVkLWJ5OiBKdWVyZ2VuIEdyb3Nz
IDxqZ3Jvc3NAc3VzZS5jb20+DQoNCk9uZSBvdGhlciB0aGluZyB0byBtZW50aW9uOiB3aXRo
IHRoaXMgc2VyaWVzIHRoZSByZXBvcnRlZCB0b3BvbG9neSB2aWEgImxzY3B1Ig0KYW5kICJj
YXQgL3Byb2MvY3B1aW5mbyIgaW5zaWRlIGEgUFYgZ3Vlc3QvZG9tMCBpcyBsb29raW5nIHNh
bmUgZm9yIHRoZSBmaXJzdA0KdGltZS4gOi0pDQoNClRoYW5rcyBmb3IgdGhpcyBzaWduaWZp
Y2FudCBpbXByb3ZlbWVudCENCg0KDQpKdWVyZ2VuDQo=
--------------KchcUZtiqi8Rore3CwGd3Aua
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------KchcUZtiqi8Rore3CwGd3Aua--

--------------B1EAGj4C09WxELOnxXjXl071--

--------------Ww2tR0C8w8fDezIlvNBeMAaG
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTR8VEFAwAAAAAACgkQsN6d1ii/Ey+4
qQf8CkmE8agU7Tj1B5pp6sv/6IGcVE5hocebz9kN+GAMgnALg4Oax0Ty5xYc7IbNYWadP2Hjq4bw
/vxgo4LbT30cXoFzBg0LekJVL2POEUifKlGB8H35EsieCe0EcGXT4QEU4OUasQ/Fv+FxNdT1HyiE
MqVp7RThbRi9905GJdHNgq5MWgqg518IKWglqIT/VaULi/nomozB4qkFrX1psK93NR2RkOIm3Ne8
e8dHOOl67a6IySr3S6Ai2nyXAVf53Lw1uR4LI6i+P1AXMTZQZ8A234k6jA0xs9+JqfXe+TTLwFZO
iux7XMUjpTrYx/QDGwy/Z/iJcsiYmB6FcVrfGo90Xw==
=/0+b
-----END PGP SIGNATURE-----

--------------Ww2tR0C8w8fDezIlvNBeMAaG--
