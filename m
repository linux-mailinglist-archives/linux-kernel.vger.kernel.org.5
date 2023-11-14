Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47D507EAB9B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjKNI2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjKNI2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:28:52 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2381A8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:28:49 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB4D41F86A;
        Tue, 14 Nov 2023 08:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699950527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=1VImW4B6srxfXA5nWuLhdIDVhpu29w9bggFGA6dC5dc=;
        b=XzRe5y8JUQsLEs8n8QZQ1FvRBv5c5YzWtiBu6mCXqoyKck1c+pKg5DUgHArOvsoSO6YQQC
        n8YHLcVpYf4uteBfcTEGXkIfZfTCSpLKHE5owUPNHPo/dQqkmnKU/wis0LOAPPSLLlaP7p
        elIFO5+CobI6oxsVnZNpdHjnLtco2u4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89B6B13460;
        Tue, 14 Nov 2023 08:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HOkrIL8vU2VQcAAAMHmgww
        (envelope-from <jgross@suse.com>); Tue, 14 Nov 2023 08:28:47 +0000
Message-ID: <54d307d7-6785-47b0-bc2a-698e46adc25f@suse.com>
Date:   Tue, 14 Nov 2023 09:28:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] xen/events: remove some simple helpers from
 events_base.c
Content-Language: en-US
To:     Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-5-jgross@suse.com>
 <b7b705e6-584b-4655-b005-521be3f23c1e@epam.com>
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
In-Reply-To: <b7b705e6-584b-4655-b005-521be3f23c1e@epam.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------tlfKjd7d3b3VFnEzLdQErORx"
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -4.41
X-Spamd-Result: default: False [-4.41 / 50.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         XM_UA_NO_VERSION(0.01)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
         HAS_ATTACHMENT(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         MIME_BASE64_TEXT_BOGUS(1.00)[];
         BAYES_HAM(-0.42)[78.09%];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         MIME_BASE64_TEXT(0.10)[];
         SIGNED_PGP(-2.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         MIME_UNKNOWN(0.10)[application/pgp-keys]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------tlfKjd7d3b3VFnEzLdQErORx
Content-Type: multipart/mixed; boundary="------------rpRBaSTtX6qjOtxWiXEMNL6e";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <54d307d7-6785-47b0-bc2a-698e46adc25f@suse.com>
Subject: Re: [PATCH 4/7] xen/events: remove some simple helpers from
 events_base.c
References: <20231016062831.20630-1-jgross@suse.com>
 <20231016062831.20630-5-jgross@suse.com>
 <b7b705e6-584b-4655-b005-521be3f23c1e@epam.com>
In-Reply-To: <b7b705e6-584b-4655-b005-521be3f23c1e@epam.com>

--------------rpRBaSTtX6qjOtxWiXEMNL6e
Content-Type: multipart/mixed; boundary="------------1lQOOysRt0k0EE08u1oWzwrQ"

--------------1lQOOysRt0k0EE08u1oWzwrQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMTEuMjMgMTg6MzUsIE9sZWtzYW5kciBUeXNoY2hlbmtvIHdyb3RlOg0KPiANCj4g
DQo+IE9uIDE2LjEwLjIzIDA5OjI4LCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0KPiANCj4gDQo+
IEhlbGxvIEp1ZXJnZW4uDQo+IA0KPiANCj4+IFRoZSBoZWxwZXIgZnVuY3Rpb25zIHR5cGVf
ZnJvbV9pcnEoKSBhbmQgY3B1X2Zyb21faXJxKCkgYXJlIGp1c3Qgb25lDQo+PiBsaW5lIGZ1
bmN0aW9ucyB1c2VkIG9ubHkgaW50ZXJuYWxseS4NCj4+DQo+PiBPcGVuIGNvZGUgdGhlbSB3
aGVyZSBuZWVkZWQuIEF0IHRoZSBzYW1lIHRpbWUgbW9kaWZ5IGFuZCByZW5hbWUNCj4+IGdl
dF9ldnRjaG5fdG9faXJxKCkgdG8gcmV0dXJuIGEgc3RydWN0IGlycV9pbmZvIGluc3RlYWQg
b2YgdGhlIElSUQ0KPj4gbnVtYmVyLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4g
R3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4gDQo+IA0KPiANCj4gW3NuaXBdDQo+IA0KPiAN
Cj4gDQo+Pg0KPj4gQEAgLTExODEsMTUgKzExNzIsMTYgQEAgc3RhdGljIGludCBiaW5kX2V2
dGNobl90b19pcnFfY2hpcChldnRjaG5fcG9ydF90IGV2dGNobiwgc3RydWN0IGlycV9jaGlw
ICpjaGlwLA0KPj4gICAgew0KPj4gICAgCWludCBpcnE7DQo+PiAgICAJaW50IHJldDsNCj4+
ICsJc3RydWN0IGlycV9pbmZvICppbmZvOw0KPj4gICAgDQo+PiAgICAJaWYgKGV2dGNobiA+
PSB4ZW5fZXZ0Y2huX21heF9jaGFubmVscygpKQ0KPj4gICAgCQlyZXR1cm4gLUVOT01FTTsN
Cj4gDQo+IA0KPiBJIGFzc3VtZSB0aGlzIGNoZWNrIGlzIGNhbGxlZCBoZXJlICgqYmVmb3Jl
KiBob2xkaW5nIGEgbG9jaykgYnkNCj4gaW50ZW50aW9uLCBhcyBldnRjaG5fdG9faW5mbygp
IGJlbG93IGNvbnRhaW5zIHRoZSBzYW1lIGNoZWNrLg0KDQpZZXMuDQoNCj4gDQo+PiAgICAN
Cj4+ICAgIAltdXRleF9sb2NrKCZpcnFfbWFwcGluZ191cGRhdGVfbG9jayk7DQo+PiAgICAN
Cj4+IC0JaXJxID0gZ2V0X2V2dGNobl90b19pcnEoZXZ0Y2huKTsNCj4+ICsJaW5mbyA9IGV2
dGNobl90b19pbmZvKGV2dGNobikgPg0KPj4gLQlpZiAoaXJxID09IC0xKSB7DQo+PiArCWlm
ICghaW5mbykgew0KPj4gICAgCQlpcnEgPSB4ZW5fYWxsb2NhdGVfaXJxX2R5bmFtaWMoKTsN
Cj4+ICAgIAkJaWYgKGlycSA8IDApDQo+PiAgICAJCQlnb3RvIG91dDsNCj4+IEBAIC0xMjEy
LDggKzEyMDQsOCBAQCBzdGF0aWMgaW50IGJpbmRfZXZ0Y2huX3RvX2lycV9jaGlwKGV2dGNo
bl9wb3J0X3QgZXZ0Y2huLCBzdHJ1Y3QgaXJxX2NoaXAgKmNoaXAsDQo+PiAgICAJCSAqLw0K
Pj4gICAgCQliaW5kX2V2dGNobl90b19jcHUoZXZ0Y2huLCAwLCBmYWxzZSk7DQo+PiAgICAJ
fSBlbHNlIHsNCj4+IC0JCXN0cnVjdCBpcnFfaW5mbyAqaW5mbyA9IGluZm9fZm9yX2lycShp
cnEpOw0KPj4gLQkJV0FSTl9PTihpbmZvID09IE5VTEwgfHwgaW5mby0+dHlwZSAhPSBJUlFU
X0VWVENITik7DQo+PiArCQlXQVJOX09OKGluZm8tPnR5cGUgIT0gSVJRVF9FVlRDSE4pOw0K
Pj4gKwkJaXJxID0gaW5mby0+aXJxOw0KPj4gICAgCX0NCj4gDQo+IA0KPiBUaGlzIGh1bmsg
ZG9lc24ndCBhcHBseSBjbGVhcmx5IHRvIHRoZSBsYXRlc3Qgc3RhdGUsIGJlY2F1c2Ugb2YN
Cj4gIjllOTBlNThjMTFiNyB4ZW46IGV2dGNobjogQWxsb3cgc2hhcmVkIHJlZ2lzdHJhdGlv
biBvZiBJUlEgaGFuZGVycyINCj4gd2VudCBpbi4gUGxlYXNlIHJlYmFzZS4NCj4gDQo+IA0K
PiBXaXRoIHRoYXQ6DQo+IFJldmlld2VkLWJ5OiBPbGVrc2FuZHIgVHlzaGNoZW5rbyA8b2xl
a3NhbmRyX3R5c2hjaGVua29AZXBhbS5jb20+DQoNClRoYW5rcywNCg0KDQpKdWVyZ2VuDQoN
Cg==
--------------1lQOOysRt0k0EE08u1oWzwrQ
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------1lQOOysRt0k0EE08u1oWzwrQ--

--------------rpRBaSTtX6qjOtxWiXEMNL6e--

--------------tlfKjd7d3b3VFnEzLdQErORx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmVTL74FAwAAAAAACgkQsN6d1ii/Ey/G
HAf+PzNlux/UYkkq7m/KJ8DOOP2nKXi5u0oKhFohSqxlsjaLOzQEO1zROt5UbKrjahI647eOUGNt
/s/yCMcIpgL/DjG3riW3kykBJm7O7d91BZQBTGDhhtEJGWW4ILkcQCSD5YBQ12wxuVMuss9yHaRn
UOJ+yxdQHNN6sQpV6LD9i3+xRM+RwJc7lTsDKqIZ6/Vt+fJL3ytu90MtjMWPvnwZKBaFdmcBNFHQ
5ldcD4F96jecp7tILPolC7bURR4N20r+sTQ5PNRWE1sIixEemiORN7r6KWyhd+fYivEblMymxfSA
sP3y13uJewdHjmRaxqoSIeigACW6cmEK7o2vZOlbzw==
=mHlO
-----END PGP SIGNATURE-----

--------------tlfKjd7d3b3VFnEzLdQErORx--
