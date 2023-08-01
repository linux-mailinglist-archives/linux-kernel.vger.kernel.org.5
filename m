Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233D876A8C7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjHAGND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjHAGMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:12:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6204C1BFD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:12:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 14FAA1F88B;
        Tue,  1 Aug 2023 06:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690870357; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uXod+oPZWofOb0Ajk4WM3rL3kkkIPaL3yFHPPIYPIQY=;
        b=pBbcYzxNa/DS3VirgW08nMoa1V2e/8E82kieSX3523VZ2mnUkI1TXNDpzwP2KL2DY5Lbnq
        vVOgWZxY/MmOzbDpdy+JowrISk7afvLiGF9shNAbxJkD9tcrNcywZRXsMg16JizRvng/c+
        sjqCUN3Eefi5L0xe63GNeq4B2E+2xIk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6051139BD;
        Tue,  1 Aug 2023 06:12:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RTicJlSiyGRyXAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 01 Aug 2023 06:12:36 +0000
Message-ID: <1abc7aed-c544-c0cd-eccd-00bc4a7e6b5c@suse.com>
Date:   Tue, 1 Aug 2023 08:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [patch V2 16/58] x86/apic: Sanitize num_processors handling
Content-Language: en-US
From:   Juergen Gross <jgross@suse.com>
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
 <20230724132045.555787669@linutronix.de>
 <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com> <87y1iwnt34.ffs@tglx>
 <87mszcnkfa.ffs@tglx> <4bf0020b-dff9-091f-dcb4-45f1ee864e2a@suse.com>
In-Reply-To: <4bf0020b-dff9-091f-dcb4-45f1ee864e2a@suse.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZKJwLQ61rOgeNjrZIwwTvHwv"
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
--------------ZKJwLQ61rOgeNjrZIwwTvHwv
Content-Type: multipart/mixed; boundary="------------ZktMQY4OQEOQeNFyc0iLaz0S";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Arjan van de Ven <arjan@linux.intel.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Peter Keresztes Schmidt <peter@keresztesschmidt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <1abc7aed-c544-c0cd-eccd-00bc4a7e6b5c@suse.com>
Subject: Re: [patch V2 16/58] x86/apic: Sanitize num_processors handling
References: <20230724131206.500814398@linutronix.de>
 <20230724132045.555787669@linutronix.de>
 <d232e50f-01fc-ef2e-db29-3f790d960c0e@suse.com> <87y1iwnt34.ffs@tglx>
 <87mszcnkfa.ffs@tglx> <4bf0020b-dff9-091f-dcb4-45f1ee864e2a@suse.com>
In-Reply-To: <4bf0020b-dff9-091f-dcb4-45f1ee864e2a@suse.com>

--------------ZktMQY4OQEOQeNFyc0iLaz0S
Content-Type: multipart/mixed; boundary="------------ta4NAle2hNubBgq8kvU6FPvk"

--------------ta4NAle2hNubBgq8kvU6FPvk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDcuMjMgMjA6MTksIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+IE9uIDMxLjA3LjIz
IDE3OjU3LCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+PiBPbiBNb24sIEp1bCAzMSAyMDIz
IGF0IDE0OjUwLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+Pj4gV2h5IGNhbid0IFhFTlBW
IHByZXRlbmQgdGhhdCBpdCBoYXMgYSBzbXAgY29uZmlndXJhdGlvbiBkZXRlY3RlZCwNCj4+
PiBpLmUuIHNldHRpbmcgc21wX2ZvdW5kX2NvbmZpZyBhcyBhbnkgb3RoZXIgc3BlY2lhbCBn
ZXRfc21wX2NvbmZpZygpDQo+Pj4gaW1wbGVtZW50YXRpb24gZG9lcz8NCj4+DQo+PiBUaGUg
YmVsb3cgc2hvdWxkIGRvIHRoZSB0cmljaywgbm8/DQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0
aGF0LCB5ZXMuDQo+IA0KPiBJJ20ganVzdCBodW50aW5nIGFub3RoZXIgcmVncmVzc2lvbiBp
biB0aGUgc2VyaWVzLiBXaXRoIHBhdGNoIDIzIG9mIHRoZQ0KPiB0b3BvbG9neSBzZXJpZXMg
YXBwbGllZCB0aGUgQVBzIG9mIGEgWGVuIFBWIGd1ZXN0cyB3b24ndCBiZSBvbmxpbmVkLiBJ
DQo+IGd1ZXNzIHRoaXMgaXMgZHVlIHRvIG1pc3NpbmcgdG9wb2xvZ3kgZGF0YSBpbml0aWFs
aXphdGlvbiBzb21ld2hlcmUgaW4NCj4gdGhlIFhlbiByZWxhdGVkIGNvZGUuDQo+IA0KPiBJ
J2xsIGNoZWNrIHlvdXIgc3VnZ2VzdGlvbiBhZnRlciBmaW5kaW5nIHRoZSByZWFzb24gZm9y
IHRoZSByZWdyZXNzaW9uLg0KPiANCj4+DQo+Pg0KPj4gLS0tIGEvYXJjaC94ODYveGVuL3Nt
cF9wdi5jDQo+PiArKysgYi9hcmNoL3g4Ni94ZW4vc21wX3B2LmMNCj4+IEBAIC0xODIsNyAr
MTgyLDggQEAgc3RhdGljIHZvaWQgX19pbml0IF9nZXRfc21wX2NvbmZpZyh1bnNpZw0KPj4g
wqDCoMKgwqDCoCBpZiAoc3VidHJhY3QpDQo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0X25y
X2NwdV9pZHMobnJfY3B1X2lkcyAtIHN1YnRyYWN0KTsNCj4+IMKgICNlbmRpZg0KPj4gLQ0K
Pj4gK8KgwqDCoCAvKiBQcmV0ZW5kIHRvIGJlIGEgcHJvcGVyIGVudW1lcmF0ZWQgc3lzdGVt
ICovDQo+PiArwqDCoMKgIHNtcF9mb3VuZF9jb25maWcgPSAxOw0KPj4gwqAgfQ0KPj4gwqAg
c3RhdGljIHZvaWQgX19pbml0IHhlbl9wdl9zbXBfcHJlcGFyZV9ib290X2NwdSh2b2lkKQ0K
PiANCg0KSXQgaXMgd29ya2luZyBmaW5lLg0KDQoNCkp1ZXJnZW4NCg==
--------------ta4NAle2hNubBgq8kvU6FPvk
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------ta4NAle2hNubBgq8kvU6FPvk--

--------------ZktMQY4OQEOQeNFyc0iLaz0S--

--------------ZKJwLQ61rOgeNjrZIwwTvHwv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTIolQFAwAAAAAACgkQsN6d1ii/Ey+p
LggAiOM0Z9CDKxPn9qhWrHPyikIgm1EhHiydVFVDh8+G0DbEF65z1qykz31gtj1JkG6aElAJ9d+g
WpxeLzC/lHTaCQKP650rKW40+2mRegDUiJrSUIBcn7giY5ZgFAz/kALMF1Sn6SyWcdcYtCsNG98V
iox9nYRO47Ynaa8H6WQC1RRHGCtXRQhS68gHw6yxUQoA5k3Tzt6kXTx94b0ALfW4sDLWQszuzybR
hHpbKaghDSje2qDQ2rtvPFneebJuvXJixEl9zQwPb150XLz2k39UXrVP9xM87wM8QHsWvhxnND4D
i0ht5jrDKr520tlOu5d5YLvXceZ2zguiSkvj64HUsw==
=Bl0h
-----END PGP SIGNATURE-----

--------------ZKJwLQ61rOgeNjrZIwwTvHwv--
