Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE028033A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234896AbjLDM7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:59:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235352AbjLDM71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:59:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83588101
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:59:33 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EC66122063;
        Mon,  4 Dec 2023 12:59:31 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D37C1398A;
        Mon,  4 Dec 2023 12:59:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id /A0IJTPNbWWDEwAAD6G6ig
        (envelope-from <jgross@suse.com>); Mon, 04 Dec 2023 12:59:31 +0000
Message-ID: <df186d0d-3178-48fe-a633-3b8f8016f5cf@suse.com>
Date:   Mon, 4 Dec 2023 13:59:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/xen: add CPU dependencies for 32-bit build
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
References: <20231204084722.3789473-1-arnd@kernel.org>
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
In-Reply-To: <20231204084722.3789473-1-arnd@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------dPJG4frez8typ20Ia4vOpSRn"
X-Spamd-Bar: +++++++++++++++
X-Spam-Score: 15.00
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        spf=fail (smtp-out1.suse.de: domain of jgross@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=jgross@suse.com;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine)
X-Rspamd-Queue-Id: EC66122063
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         TO_DN_SOME(0.00)[];
         HAS_ATTACHMENT(0.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         MIME_BASE64_TEXT(0.10)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.00)[28.52%];
         MIME_UNKNOWN(0.10)[application/pgp-keys];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         RCVD_TLS_ALL(0.00)[]
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------dPJG4frez8typ20Ia4vOpSRn
Content-Type: multipart/mixed; boundary="------------EdsUZfSArgzQumTGljWE0fbO";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Arnd Bergmann <arnd@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>, "H. Peter Anvin"
 <hpa@zytor.com>, xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Message-ID: <df186d0d-3178-48fe-a633-3b8f8016f5cf@suse.com>
Subject: Re: [PATCH 1/2] x86/xen: add CPU dependencies for 32-bit build
References: <20231204084722.3789473-1-arnd@kernel.org>
In-Reply-To: <20231204084722.3789473-1-arnd@kernel.org>

--------------EdsUZfSArgzQumTGljWE0fbO
Content-Type: multipart/mixed; boundary="------------O8w0R37XlgbuJOEYjnu0t7ya"

--------------O8w0R37XlgbuJOEYjnu0t7ya
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMDQuMTIuMjMgMDk6NDcsIEFybmQgQmVyZ21hbm4gd3JvdGU6DQo+IEZyb206IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IA0KPiBYZW4gb25seSBzdXBwb3J0cyBtb2Rl
cm4gQ1BVcyBldmVuIHdoZW4gcnVubmluZyBhIDMyLWJpdCBrZXJuZWwsIGFuZCBpdCBub3cN
Cj4gcmVxdWlyZXMgYSBrZXJuZWwgYnVpbHQgZm9yIGEgNjQgYnl0ZSAob3IgbGFyZ2VyKSBj
YWNoZSBsaW5lOg0KPiANCj4gSW4gZmlsZSBpbmNsdWRlZCBmcm9tIDxjb21tYW5kLWxpbmU+
Og0KPiBJbiBmdW5jdGlvbiAneGVuX3ZjcHVfc2V0dXAnLA0KPiAgICAgIGlubGluZWQgZnJv
bSAneGVuX3ZjcHVfc2V0dXBfcmVzdG9yZScgYXQgYXJjaC94ODYveGVuL2VubGlnaHRlbi5j
OjExMTozLA0KPiAgICAgIGlubGluZWQgZnJvbSAneGVuX3ZjcHVfcmVzdG9yZScgYXQgYXJj
aC94ODYveGVuL2VubGlnaHRlbi5jOjE0MTozOg0KPiBpbmNsdWRlL2xpbnV4L2NvbXBpbGVy
X3R5cGVzLmg6NDM1OjQ1OiBlcnJvcjogY2FsbCB0byAnX19jb21waWxldGltZV9hc3NlcnRf
Mjg3JyBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSBlcnJvcjogQlVJTERfQlVHX09OIGZhaWxl
ZDogc2l6ZW9mKCp2Y3B1cCkgPiBTTVBfQ0FDSEVfQllURVMNCj4gYXJjaC94ODYveGVuL2Vu
bGlnaHRlbi5jOjE2Njo5OiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8gJ0JVSUxEX0JV
R19PTicNCj4gICAgMTY2IHwgICAgICAgICBCVUlMRF9CVUdfT04oc2l6ZW9mKCp2Y3B1cCkg
PiBTTVBfQ0FDSEVfQllURVMpOw0KPiAgICAgICAgfCAgICAgICAgIF5+fn5+fn5+fn5+fg0K
PiANCj4gRW5mb3JjZSB0aGUgZGVwZW5kZW5jeSB3aXRoIGEgd2hpdGVsaXN0IG9mIENQVSBj
b25maWd1cmF0aW9ucy4gSW4gbm9ybWFsDQo+IGRpc3RybyBrZXJuZWxzLCBDT05GSUdfWDg2
X0dFTkVSSUMgaXMgZW5hYmxlZCwgYW5kIHRoaXMgd29ya3MgZmluZS4gV2hlbiB0aGlzDQo+
IGlzIG5vdCBzZXQsIHN0aWxsIGFsbG93IFhlbiB0byBiZSBidWlsdCBvbiBrZXJuZWxzIHRo
YXQgdGFyZ2V0IGEgNjQtYml0DQo+IGNhcGFibGUgQ1BVLg0KPiANCj4gRml4ZXM6IGRiMjgz
MjMwOWE4MiAoIng4Ni94ZW46IGZpeCBwZXJjcHUgdmNwdV9pbmZvIGFsbG9jYXRpb24iKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPg0KDQpSZXZp
ZXdlZC1ieTogSnVlcmdlbiBHcm9zcyA8amdyb3NzQHN1c2UuY29tPg0KDQoNCkp1ZXJnZW4N
Cg0K
--------------O8w0R37XlgbuJOEYjnu0t7ya
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------O8w0R37XlgbuJOEYjnu0t7ya--

--------------EdsUZfSArgzQumTGljWE0fbO--

--------------dPJG4frez8typ20Ia4vOpSRn
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVtzTMFAwAAAAAACgkQsN6d1ii/Ey99
nggAnng/G5X6K9f9/BxLAI9EH7d8ySR9UjVM4UOJ7VwrASAO10xftaLy/U7asJfhjgpH4JOrtEvF
rrIGODKrjybCOWECfe9TUgg5kCboBomEgR9WaUZpQf6ONmiwVk9q57FzhcjU0t3A1zEzkrfGHxdq
NRIgcaae8T0qvGQW6be7py9zsIyBRHzZBGvoMrvDtTU8trt9qHhcSbPaOWBdnHgPDNaDs5klRVgV
GcIO2iyBgBCkIP28OlZVFoGYRaVhSixQIzcrBOkdGiQxMYwkmup5JvWXNiDwbNIfhDtfrmFT7hG0
NaU0TPIT5h3R5fPCtCzaxr314b4yt6gCuVSyjFnKTg==
=n1vE
-----END PGP SIGNATURE-----

--------------dPJG4frez8typ20Ia4vOpSRn--
