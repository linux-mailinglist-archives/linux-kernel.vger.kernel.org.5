Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9DB76960C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 14:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjGaMUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 08:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjGaMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 08:20:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748C31997
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 05:20:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D89731F460;
        Mon, 31 Jul 2023 12:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690806014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4CAp73pPEUY7P+2mBrNLMuna63aiMRN98+0jGbp+50I=;
        b=jfcb7Sv5cy0te/8+JH5QKbOK2bpa28olYfdrkq0sLI9XtExLaPY140K38pxjKPVlY8INSu
        MznqIeKwbpOA7qq0GvIPevLE39lpRZovl3oVd8tl3aJ/p4vfsu9E+NqUpg7kR7YnmwUUmW
        1SXQuSmgJP25tCUB97+RBPys7wA3NUw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83E5C133F7;
        Mon, 31 Jul 2023 12:20:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5WJzHv6mx2RSFgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 31 Jul 2023 12:20:14 +0000
Message-ID: <98d68bd9-fbb9-f084-a99b-48d7b277a413@suse.com>
Date:   Mon, 31 Jul 2023 14:20:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
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
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [patch V2 00/58] x86/apic: Decrapification and static calls
In-Reply-To: <20230724131206.500814398@linutronix.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------byrOS0jxfQFNYVntzoFARnej"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------byrOS0jxfQFNYVntzoFARnej
Content-Type: multipart/mixed; boundary="------------IaCw00JmXknyDfp71FZeMdHV";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <98d68bd9-fbb9-f084-a99b-48d7b277a413@suse.com>
Subject: Re: [patch V2 00/58] x86/apic: Decrapification and static calls
References: <20230724131206.500814398@linutronix.de>
In-Reply-To: <20230724131206.500814398@linutronix.de>

--------------IaCw00JmXknyDfp71FZeMdHV
Content-Type: multipart/mixed; boundary="------------CwfYPtZdvYe0X8VyZcNYUcIK"

--------------CwfYPtZdvYe0X8VyZcNYUcIK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjQuMDcuMjMgMTU6MzMsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gSGkhDQo+IA0K
PiBUaGlzIGlzIHRoZSBmb2xsb3cgdXAgdG86DQo+IA0KPiAgICBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9sa21sLzIwMjMwNzE3MjIzMDQ5LjMyNzg2NTk4MUBsaW51dHJvbml4LmRlDQo+
IA0KPiB3aGljaCBhZGRyZXNzZXMgdGhlIHJldmlldyBmZWVkYmFjayBhbmQgc29tZSBtaW5v
ciAwZGF5LXJvYm90IGZhbGxvdXQuDQo+IA0KPiBUTERSOiBUaGlzIGNsZWFucyB1cCBhY2Ny
dWVkIGFuZCBwYXJ0aWFsbHkgdW51c2VkIGd1bmsgaW4gb3JkZXIgdG8gY29udmVydA0KPiB0
aGUgQVBJQyBjYWxsYmFja3MgdG8gc3RhdGljIGNhbGxzLg0KPiANCj4gVGhlIGNoYW5nZXMg
dnMuIFYxOg0KPiANCj4gICAgLSBGaXhlZCB0aGUgbWlub3IgZmFsbG91dCByZXBvcnRlZCBi
eSBNaWNoYWVsIGFuZCBQZXRlcg0KPiANCj4gICAgLSBNb3BwZWQgdXAgWEVOL1BWIGV2ZW4g
bW9yZSAtIEp1ZXJnZW4NCj4gDQo+ICAgIC0gRml4ZWQgdXAgYSBwbGFjZSB3aGljaCBzdGls
bCB3cm90ZSBpbnRvIG1wX2xhcGljX2FkZHIgZGlyZWN0bHkgaW4NCj4gICAgICBtcHBhcnNl
DQo+IA0KPiAgICAtIEFkZHJlc3NlZCAwZGF5IGZhbGxvdXQgb24gMzJiaXQgd2l0aCBLVk0g
Z3Vlc3QgZW5hYmxlZCBhbmQgbG9jYWwgQVBJQw0KPiAgICAgIGRpc2FibGVkLiBTaWdoIQ0K
PiANCj4gVGhlIHNlcmllcyBpcyBhbHNvIGF2YWlsYWJsZSBmcm9tIGdpdDoNCj4gDQo+ICAg
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90Z2x4L2Rl
dmVsLmdpdCBhcGljLXN0YXRpYy1jYWxsLXYyDQo+IA0KDQpXaXRoIHRoZSBjaGFuZ2VzIHN1
Z2dlc3RlZCBmb3IgcGF0Y2hlcyAxNiBhbmQgNTAgdGhpcyBzZXJpZXMgc2VlbXMgdG8gd29y
aw0KZmluZSBmb3IgWGVuIFBWIChkb20wIGFuZCBkb21VKS4NCg0KDQpKdWVyZ2VuDQo=
--------------CwfYPtZdvYe0X8VyZcNYUcIK
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------CwfYPtZdvYe0X8VyZcNYUcIK--

--------------IaCw00JmXknyDfp71FZeMdHV--

--------------byrOS0jxfQFNYVntzoFARnej
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTHpv0FAwAAAAAACgkQsN6d1ii/Ey9W
0Qf/XMWAoAyOj8/TSVBPW/R8OfK6iXvb+yt6WT+B1CeYe6cH9ZEo9Zp5TaeRlFKaFyJkQYt5JNYU
JF6Fh+s1SWm29nJQrXal2fi3qh8pwbyxm4kY3Wzo7TEQSbCFHyt6Y8mAqqAMCnFnEjnaKxYlXS31
1yrPK266WGmLRtFtvX7CZersvGfCW1UgOzQ5ot1y5eVICYf+TAqz/2wREggwGPYRKdJziFPq833I
qrtDefPxbFSfpPG3ujqQVwQzfZJpQ6uXY2Oh9ajkOF86o77dRMe3PvZ58zudN+WhikVuacYwxvKa
0bBcueAUY3LlmJeUfnveCy1/vY/XB4byp6mgRKnEnw==
=cj4U
-----END PGP SIGNATURE-----

--------------byrOS0jxfQFNYVntzoFARnej--
