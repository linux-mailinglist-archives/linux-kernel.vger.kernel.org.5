Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E02764650
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 07:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjG0Fzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 01:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjG0Fzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 01:55:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F184335A4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 22:54:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6F00E21B4A;
        Thu, 27 Jul 2023 05:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690437289; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6FH6OIxXDPjwY8sydASc46G8K1EY8W062wfCfb4fRCg=;
        b=HqhW8p9pnfIc8hqmnaUp9hzNa5djKaGAydk7hjJ130knCRHZNpY0aXsgitgLTSt/zZRQBu
        cy7ISdtJ3xNeHUbFtZnD2Mku0dyyGFtwolteWJ7DA9lr/Bm9q9oevlOnCVE5GVw5stMK+S
        34P2us1ndd5uo7U+ZAgeTG+gkSZC6bk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B1C81341F;
        Thu, 27 Jul 2023 05:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id s8W7CKkGwmS6CQAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 27 Jul 2023 05:54:49 +0000
Message-ID: <270ed8f7-c645-502e-39c5-c93823037b9c@suse.com>
Date:   Thu, 27 Jul 2023 07:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] xen/evtchn: Introduce new IOCTL to bind static evtchn
Content-Language: en-US
To:     Rahul Singh <rahul.singh@arm.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jane Malalane <jane.malalane@citrix.com>
References: <ae7329bf1713f83e4aad4f3fa0f316258c40a3e9.1689677042.git.rahul.singh@arm.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <ae7329bf1713f83e4aad4f3fa0f316258c40a3e9.1689677042.git.rahul.singh@arm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------4Tdk1AVzYvRkV0W5o1dum3uz"
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
--------------4Tdk1AVzYvRkV0W5o1dum3uz
Content-Type: multipart/mixed; boundary="------------JsMbhU8vs3WUa8yM8kUzxvI6";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Rahul Singh <rahul.singh@arm.com>, xen-devel@lists.xenproject.org,
 linux-kernel@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 David Woodhouse <dwmw@amazon.co.uk>, Jane Malalane <jane.malalane@citrix.com>
Message-ID: <270ed8f7-c645-502e-39c5-c93823037b9c@suse.com>
Subject: Re: [PATCH v3] xen/evtchn: Introduce new IOCTL to bind static evtchn
References: <ae7329bf1713f83e4aad4f3fa0f316258c40a3e9.1689677042.git.rahul.singh@arm.com>
In-Reply-To: <ae7329bf1713f83e4aad4f3fa0f316258c40a3e9.1689677042.git.rahul.singh@arm.com>

--------------JsMbhU8vs3WUa8yM8kUzxvI6
Content-Type: multipart/mixed; boundary="------------m72s06cVtq9GZZjNVYRxdBq1"

--------------m72s06cVtq9GZZjNVYRxdBq1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTguMDcuMjMgMTM6MzEsIFJhaHVsIFNpbmdoIHdyb3RlOg0KPiBYZW4gNC4xNyBzdXBw
b3J0c8KgdGhlIGNyZWF0aW9uIG9mIHN0YXRpYyBldnRjaG5zLiBUbyBhbGxvdyB1c2VyIHNw
YWNlDQo+IGFwcGxpY2F0aW9uIHRvIGJpbmQgc3RhdGljIGV2dGNobnMgaW50cm9kdWNlIG5l
dyBpb2N0bA0KPiAiSU9DVExfRVZUQ0hOX0JJTkRfU1RBVElDIi4gRXhpc3RpbmcgSU9DVEwg
ZG9pbmcgbW9yZSB0aGFuIGJpbmRpbmcNCj4gdGhhdOKAmXMgd2h5IHdlIG5lZWQgdG8gaW50
cm9kdWNlIHRoZSBuZXcgSU9DVEwgdG8gb25seSBiaW5kIHRoZSBzdGF0aWMNCj4gZXZlbnQg
Y2hhbm5lbHMuDQo+IA0KPiBTdGF0aWMgZXZ0Y2hucyB0byBiZSBhdmFpbGFibGUgZm9yIHVz
ZSBkdXJpbmcgdGhlIGxpZmV0aW1lIG9mIHRoZQ0KPiBndWVzdC4gV2hlbiB0aGUgYXBwbGlj
YXRpb24gZXhpdHMsIF9fdW5iaW5kX2Zyb21faXJxKCkgZW5kcyB1cCBiZWluZw0KPiBjYWxs
ZWQgZnJvbSByZWxlYXNlKCkgZmlsZSBvcGVyYXRpb25zIGJlY2F1c2Ugb2YgdGhhdCBzdGF0
aWMgZXZ0Y2hucw0KPiBhcmUgZ2V0dGluZyBjbG9zZWQuIFRvIGF2b2lkIGNsb3NpbmcgdGhl
IHN0YXRpYyBldmVudCBjaGFubmVsLCBhZGQgdGhlDQo+IG5ldyBib29sIHZhcmlhYmxlICJp
c19zdGF0aWMiIGluICJzdHJ1Y3QgaXJxX2luZm8iIHRvIG1hcmsgdGhlIGV2ZW50DQo+IGNo
YW5uZWwgc3RhdGljIHdoZW4gY3JlYXRpbmcgdGhlIGV2ZW50IGNoYW5uZWwgdG8gYXZvaWQg
Y2xvc2luZyB0aGUNCj4gc3RhdGljIGV2dGNobi4NCj4gDQo+IEFsc28sIHRha2UgdGhpcyBv
cHBvcnR1bml0eSB0byByZW1vdmUgdGhlIG9wZW4tY29kZWQgdmVyc2lvbiBvZiB0aGUNCj4g
ZXZ0Y2huIGNsb3NlIGluIGRyaXZlcnMveGVuL2V2dGNobi5jIGZpbGUgYW5kIHVzZSB4ZW5f
ZXZ0Y2huX2Nsb3NlKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYWh1bCBTaW5naCA8cmFo
dWwuc2luZ2hAYXJtLmNvbT4NCg0KUHVzaGVkIHRvIHhlbi90aXAuZ2l0IGZvci1saW51cy02
LjVhDQoNCg0KSnVlcmdlbg0KDQo=
--------------m72s06cVtq9GZZjNVYRxdBq1
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------m72s06cVtq9GZZjNVYRxdBq1--

--------------JsMbhU8vs3WUa8yM8kUzxvI6--

--------------4Tdk1AVzYvRkV0W5o1dum3uz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTCBqgFAwAAAAAACgkQsN6d1ii/Ey8p
3Af9HHbe22wpgQFipYJxDkdLtVudyWkHZ3Ao6K1SlQa5Cz+AO/CBQ28CrN2WnxSCfpmnzyhJ1YY/
1Zk3NcI4Jqs6Aj7vw3LCcpS/t1JpH2p5+xqS6dwW3HsVZ6/NTyT46iQFRnC3CxR+YT8KwsUfN80v
Ru85mn2Nm41J61JUFJEtJj66VVjeRuF2zVh2zG+/dOA+NsvvezP5RImEpYA8mmGYnUDnNjn0VBVG
aICgbAYCZ4qgPbJyMu8h8gdYWWUWmDet4yl6IfRhGNAvVSRbUtKdoYHplFPvQfgzmOht50W7XqVD
s3AoPqpeakiehqZrd9vGVk+sxN8RUCzfoZioTSGDWw==
=kdGh
-----END PGP SIGNATURE-----

--------------4Tdk1AVzYvRkV0W5o1dum3uz--
