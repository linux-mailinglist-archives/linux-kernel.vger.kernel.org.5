Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5206876CC1D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 13:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjHBLzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 07:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjHBLzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 07:55:21 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE601710
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 04:55:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 92A2521B0A;
        Wed,  2 Aug 2023 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690977318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fyXFrlmlEuxjB2gPFhddRNbTtG90QXCVOzv8x2AJbZY=;
        b=O/T2p/k4hn8kjGbqy6Us/oZlXHl9jiyukpw87o2/zVyaXgHro+1YGZ92Mk6/abwQj77aiK
        rLI93DBjQ8zsWtroQsvqvZfoNESvpI8gYgDxC9M+XOlkLsGJzB86fA8lB7AgbcWWEIFoRd
        ZdpITi/sgGhGNSuWGCjVPmT37yQSNu8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42E3B13909;
        Wed,  2 Aug 2023 11:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AXmaDiZEymQrOAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 02 Aug 2023 11:55:18 +0000
Message-ID: <a340a4e1-c9ae-f959-dade-d79cfe9f4eb5@suse.com>
Date:   Wed, 2 Aug 2023 13:55:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch V3 00/60] x86/apic: Decrapification and static calls
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wei Liu <wei.liu@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Peter Keresztes Schmidt <peter@keresztesschmidt.de>
References: <20230801103042.936020332@linutronix.de>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <20230801103042.936020332@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------vC19l9f9XC8W0nHpXasNyca0"
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
--------------vC19l9f9XC8W0nHpXasNyca0
Content-Type: multipart/mixed; boundary="------------4Sy4recgA7lQesFz63cWYq9e";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>
Message-ID: <a340a4e1-c9ae-f959-dade-d79cfe9f4eb5@suse.com>
Subject: Re: [patch V3 00/60] x86/apic: Decrapification and static calls
References: <20230801103042.936020332@linutronix.de>
In-Reply-To: <20230801103042.936020332@linutronix.de>

--------------4Sy4recgA7lQesFz63cWYq9e
Content-Type: multipart/mixed; boundary="------------83dbtYTDd4raYOV5Y30uetkQ"

--------------83dbtYTDd4raYOV5Y30uetkQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDEuMDguMjMgMTI6NDYsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gSGkhDQo+IA0K
PiBUaGlzIGlzIHRoZSBmb2xsb3cgdXAgdG86DQo+IA0KPiAgICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjMwNzI0MTMxMjA2LjUwMDgxNDM5OEBsaW51dHJvbml4LmRlDQo+
IA0KPiB3aGljaCBhZGRyZXNzZXMgdGhlIFhFTiBQViBmYWxsb3V0IGRlY29kZWQgYnkgSnVl
cmdlbi4NCj4gDQo+IFRMRFI6IFRoaXMgY2xlYW5zIHVwIGFjY3J1ZWQgYW5kIHBhcnRpYWxs
eSB1bnVzZWQgZ3VuayBpbiBvcmRlciB0byBjb252ZXJ0DQo+IHRoZSBBUElDIGNhbGxiYWNr
cyB0byBzdGF0aWMgY2FsbHMuDQo+IA0KPiBUaGUgY2hhbmdlcyB2cy4gVjI6DQo+IA0KPiAg
ICAtIFVuYnJlYWsgWEVOL1BWIC0gSnVlcmdlbg0KPiANCj4gICAgICBSZXN1bHRpbmcgZGVs
dGEgcGF0Y2ggYmVsb3cuDQo+IA0KPiAgICAtIFJlYmFzZWQgdG8gNi41LXJjNCBpbiBwcmVw
YXJhdGlvbiBmb3IgdGhlIENQVUlEIG92ZXJoYXVsIG9uIHRvcCwgd2hpY2gNCj4gICAgICBo
YXMgc29tZSBjb2xsaXNpb25zIGR1ZSB0byB0aGUgcmVjZW50IG1pdGlnYXRpb24gbXVjay4N
Cj4gDQo+IFRoZSBzZXJpZXMgaXMgYWxzbyBhdmFpbGFibGUgZnJvbSBnaXQ6DQo+IA0KPiAg
ICBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdGdseC9k
ZXZlbC5naXQgYXBpYy1zdGF0aWMtY2FsbC12Mw0KPiANCj4gVGhhbmtzLA0KPiANCj4gCXRn
bHgNCg0KRm9yIFhlbiBQViAoZG9tMCBhbmQgdW5wcml2aWxlZ2VkIGd1ZXN0KToNCg0KVGVz
dGVkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+DQoNCg0KSnVlcmdlbg0K
DQo=
--------------83dbtYTDd4raYOV5Y30uetkQ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------83dbtYTDd4raYOV5Y30uetkQ--

--------------4Sy4recgA7lQesFz63cWYq9e--

--------------vC19l9f9XC8W0nHpXasNyca0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTKRCUFAwAAAAAACgkQsN6d1ii/Ey8H
zAgAgFvBIVNzLMmdQ3hiQLrAH087mtpJiDknPyBajTnLVF2Ziq8bmDoiRRTpL97ulnAGPZxU5Qgv
aFaSIdNXkl3Th8kPDbAthCb0RiRigdXsTYc1a1lFqW6hhiXCLlgO7eaMNf/IyKflEFK2JIQDoQTK
txvZUJc5a1dEsi2igdXygRG0INSq4+49BkcQDPJHxLlVeujdRpZSpUlzXNfEYC3b52z65vHE+5o3
0O7GPVHaijjTzjEYMqlOPN10fR27aa7k+nxUG/F27mfzE+pYBaZt+NnSBRI1PyTgedlqpgcdR3qj
Rs/kyBDv8uLoJwKN9hLTSaoHuQ5kZIPdiuU5JpzATg==
=kzUf
-----END PGP SIGNATURE-----

--------------vC19l9f9XC8W0nHpXasNyca0--
