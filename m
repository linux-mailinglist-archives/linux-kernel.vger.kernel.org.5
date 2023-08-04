Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A922976FE97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 12:35:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjHDKfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 06:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHDKfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 06:35:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370632118
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 03:35:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D339C1F8AC;
        Fri,  4 Aug 2023 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691145324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dOrns3aHmALo5VEFClwKv4k5zfS2WAJjPptWmdcbyC4=;
        b=nJUBH/vfKgOAOX/DrcQxg/3LON8/S2QVTGUFTNj5TmMPsot0C2MVuZQ9oOIwVO6fXvdBWP
        P3WvqOKjRaXncnPnz0rjg252GKsyKWyMXKSIW9Xodd03iKD0nnpLnnBvD1REeSAZPY1+Vj
        m4AdwaH0KjPfGUS9OmT4o+uKILaY7rc=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72C45133B5;
        Fri,  4 Aug 2023 10:35:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3leVGmzUzGSKOAAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 04 Aug 2023 10:35:24 +0000
Message-ID: <f3c20dd0-9914-f646-0aaa-400dffd2bb2b@suse.com>
Date:   Fri, 4 Aug 2023 12:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
References: <20230804075734.8372-1-xin3.li@intel.com>
 <f0077c58-9192-9c81-6c2d-df845bfb7815@citrix.com>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
In-Reply-To: <f0077c58-9192-9c81-6c2d-df845bfb7815@citrix.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------RIwth9b5TBuxUuYcpfetUToe"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------RIwth9b5TBuxUuYcpfetUToe
Content-Type: multipart/mixed; boundary="------------YNwf55S3kJowPLPrhqJxF54y";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Xin Li <xin3.li@intel.com>,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <f3c20dd0-9914-f646-0aaa-400dffd2bb2b@suse.com>
Subject: Re: [RFC PATCH 1/1] x86/traps: Get rid of exception handlers' second
 argument error code
References: <20230804075734.8372-1-xin3.li@intel.com>
 <f0077c58-9192-9c81-6c2d-df845bfb7815@citrix.com>
In-Reply-To: <f0077c58-9192-9c81-6c2d-df845bfb7815@citrix.com>

--------------YNwf55S3kJowPLPrhqJxF54y
Content-Type: multipart/mixed; boundary="------------FpShGNDVei6igLcFbXS9kvzt"

--------------FpShGNDVei6igLcFbXS9kvzt
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMDguMjMgMTI6MjUsIEFuZHJldyBDb29wZXIgd3JvdGU6DQo+IE9uIDA0LzA4LzIw
MjMgODo1NyBhbSwgWGluIExpIHdyb3RlOg0KPj4gSSBoYXZlbid0IGNoZWNrZWQgWGVuIGlt
cGxpY2F0aW9ucyB3aXRoIHRoaXMgY2hhbmdlLCBpLmUuLCBkb2VzIFhlbg0KPj4gaHlwZXJ2
aXNvciBuZWVkIHRvIGFkanVzdCBob3cgaXQgcGFzc2VzIGFyZ3VtZW50cyB0byBQViBndWVz
dHM/DQo+IA0KPiBUaGlzIGlzIGFuIGludGVybmFsIGRldGFpbCBvZiBob3cgTGludXggaGFu
ZGxlcyBkYXRhIG9uIGl0J3Mgc3RhY2tzLA0KPiBpc24ndCBpdD8NCj4gDQo+IFRoZSBYZW4g
Y29kZSBpbiBMaW51eCB3aWxsIG5lZWQgYWRqdXN0bWVudCB0byBtYXRjaCwgYnV0IHRoaXMg
aXMgbm90IGENCj4gaHlwZXJ2aXNvciBBQkkgKHdoaWNoIG9idmlvdXNseSBjYW4ndCBhbmQg
d29uJ3QgY2hhbmdlKS4NCg0KVGhlIG9ubHkgYWRhcHRpb24gb2YgWGVuIGNvZGUgd2lsbCBu
ZWVkIHRvIGhhcHBlbiBmb3IgdGhlIG9ubHkgdXNlIG9mDQpERUZJTkVfSURURU5UUllfUkFX
X0VSUk9SQ09ERSgpIHRoZXJlLCBhbmQgdGhpcyB5b3UgaGF2ZSBjb3ZlcmVkIGluIHlvdXIN
CnBhdGNoIGFscmVhZHkuDQoNCg0KSnVlcmdlbg0KDQo=
--------------FpShGNDVei6igLcFbXS9kvzt
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------FpShGNDVei6igLcFbXS9kvzt--

--------------YNwf55S3kJowPLPrhqJxF54y--

--------------RIwth9b5TBuxUuYcpfetUToe
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmTM1GsFAwAAAAAACgkQsN6d1ii/Ey98
xQf/eHKCtZfr2yrcxk/rSFLFayb4L8I2VDcv5ljxLHvPEsCm8nzjl/H3tOqNecMOjI1ezu16HS9m
xVE6gTW2KDa17ZVxjXsuJlTpiaHhe13bXyJ957jDIW0gfEvbB342HmfFKeUe+8wSNvERvtPfXorE
B9cPpNrQsn1Be8G2QWHtMNNrWtsMvLp+IjyQzIH2G8DRx30nd/rJT3YX3lrNOekp1Tj3V4IuX6e7
DUYHW0EUklkXexzsQfCzyznT63ZwWkydOS0UPXn4IfTKYTY3WIxqnZPkn5fjGZXGsd279avPYUYe
G5NbUK4Dhj6mrxyFsQITsf+0ZR/REp/7CRUjaRHvgw==
=HCZR
-----END PGP SIGNATURE-----

--------------RIwth9b5TBuxUuYcpfetUToe--
