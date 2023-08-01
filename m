Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EFD76A97D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjHAGtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbjHAGt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:49:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E97BF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:49:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0D60D21E61;
        Tue,  1 Aug 2023 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690872567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/yhkXEGUnoi2bbahIHqo2c3hTcFA6obEn4JF7MRoxnw=;
        b=botn5WbzABi72rxuIdkb31XB2xrGyAC/UPXJYymXxtVyB6WTaBReCLdGJXQoxkaci6Lzho
        My0iOF6DfH0nqCvciTSGo9J4JD1rD0RiveNh4abDbNuI1BJhgfz8sKjIio4M/rLQ8aT9Xm
        hy/J/tXWeRyqF410cH+Md8JJDDSwfCk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AF16C13919;
        Tue,  1 Aug 2023 06:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id id87KfaqyGQsbgAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 01 Aug 2023 06:49:26 +0000
Message-ID: <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
Date:   Tue, 1 Aug 2023 08:49:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <87v8dzl0wm.ffs@tglx>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------76sXpEwktRVrqEXDihbD4Vc6"
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
--------------76sXpEwktRVrqEXDihbD4Vc6
Content-Type: multipart/mixed; boundary="------------u7wQbiSI5P0GTEr30gu9XtCs";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <807ac0ad-b2c4-4a10-a82c-6d95649ae4dc@suse.com>
Subject: Re: [patch V2 50/58] x86/apic: Provide common init infrastructure
References: <20230724131206.500814398@linutronix.de>
 <20230724132047.554355840@linutronix.de>
 <abfa4548-4367-d8fa-f23f-b2ca4a912258@suse.com> <87v8e0nskd.ffs@tglx>
 <b4f0e874-1e35-e523-8e5a-710bc54af52d@suse.com> <87pm48nktc.ffs@tglx>
 <87v8dzl0wm.ffs@tglx>
In-Reply-To: <87v8dzl0wm.ffs@tglx>

--------------u7wQbiSI5P0GTEr30gu9XtCs
Content-Type: multipart/mixed; boundary="------------nZ576G05vtnIHHpcOaE55d0N"

--------------nZ576G05vtnIHHpcOaE55d0N
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDguMjMgMDg6NDEsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gTW9uLCBK
dWwgMzEgMjAyMyBhdCAxNzo0OCwgVGhvbWFzIEdsZWl4bmVyIHdyb3RlOg0KPiANCj4+IE9u
IE1vbiwgSnVsIDMxIDIwMjMgYXQgMTU6MTAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+Pj4g
T24gMzEuMDcuMjMgMTU6MDEsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4+Pj4+ICAgICBh
cGljX2RyaXZlcih4ZW5fcHZfYXBpYyk7DQo+Pj4+DQo+Pj4+IEkgd29uZGVyIHdoZXRoZXIg
dGhpcyBleHBsaWNpdCBpbnN0YWxsIGlzIGFjdHVhbGx5IG5lZWRlZCBhdCBhbGwuDQo+Pj4+
IFNob3VsZG4ndCB0aGUgZHJpdmVyIGJlIGluc3RhbGxlZCB2aWEgdGhlIEFQSUMgcHJvYmlu
ZyBtZWNoYW5pc20NCj4+Pj4gYXV0b21hZ2ljYWxseT8NCj4+Pg0KPj4+IE9ubHkgaW4gY2Fz
ZSB4ODZfaW5pdC5pcnEuaW50cl9tb2RlX2luaXQgaXMgc2V0IGFwcHJvcHJpYXRlbHkuIFRv
ZGF5IGl0IGlzDQo+Pj4gYSBub3AgZm9yIFhlbiBQViwgYnV0IHRoYXQgY2FuIGJlIGNoYW5n
ZWQuIEknbGwgaGF2ZSBhIGxvb2suDQo+Pg0KPj4gWW91IGNvdWxkIHNpbXBseSBzZXQgdGhh
dCBjYWxsYmFjayB0byBkZWZhdWx0X3NldHVwX2FwaWNfcm91dGluZygpIGFuZA0KPj4gYmUg
ZG9uZSB3aXRoIGl0Lg0KPiANCj4gRG9lc24ndCB3b3JrIGJlY2F1c2UgWEVOIG92ZXJyaWRl
cyBpdCBhbHJlYWR5LiBTbyBzdXJlLCBsZXRzIGp1c3QgZ28NCg0KSXQgaXMgb3ZlcnJpZGlu
ZyBpdCB3aXRoIHg4Nl9pbml0X25vb3AoKS4NCg0KPiB3aXRoIHRoZSBzb2x1dGlvbiB5b3Ug
cHJvcG9zZWQuIE9uZSBtb3JlIHVnbHkgb3IgbGVzcyBpbiBYRU4vUFYgZG9lcyBub3QNCj4g
cmVhbGx5IG1hdHRlciBtdWNoIDopDQo+IA0KPiBMZXQgbWUgZ3JhYiB0aGlzIGFuZCBwdXQg
aXQgaW50byB0aGUgcmlnaHQgcG9zaXRpb24gaW4gdGhlIHF1ZXVlLg0KDQpXYWl0IGEgZmV3
IG1pbnV0ZXMsIHBsZWFzZS4gSSdtIGp1c3QgYWJvdXQgdG8gdGVzdCB5b3VyIHN1Z2dlc3Rp
b24uDQoNCg0KSnVlcmdlbg0KDQo=
--------------nZ576G05vtnIHHpcOaE55d0N
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------nZ576G05vtnIHHpcOaE55d0N--

--------------u7wQbiSI5P0GTEr30gu9XtCs--

--------------76sXpEwktRVrqEXDihbD4Vc6
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTIqvYFAwAAAAAACgkQsN6d1ii/Ey8H
cgf/fwS5GFq9g2gvt1EeaCq9za7wo5uzUrI7L1BFQKtwGAlTcooyy+wo9GBp7CB2uYpBAORWOpcN
wZz2F91LPkN/AvwDtzlAsBF2cBuyD7Ic2Tzd2Knxg/fPob2XwZ+YjF4Yj0G/vYSaaNtbzaNOAsvg
EEDNyfbLHjserNfvFJ/QGcF2CmyVd9wuLL2F+3WzFiYjLMqulk1aSiYqZfG7gB1FeEfQCvFs2QaB
MPJ8TSrrI/4qO/2jD3vuXDzSCGezz02P2E4sveEIn+uQausRG8xnDrNPQEFYrPnvCDdKVZRt4/kc
06x/hy17WkGvucABS8oA4ylS6jrzb00ILS2+x+JCDA==
=qEES
-----END PGP SIGNATURE-----

--------------76sXpEwktRVrqEXDihbD4Vc6--
