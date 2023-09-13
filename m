Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4268579E974
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbjIMNg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjIMNgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:36:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7394219B1;
        Wed, 13 Sep 2023 06:36:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 55EB31F390;
        Wed, 13 Sep 2023 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694612177; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=UywHEU8QyoCqHjUnzK/CvHTIBTQyCYwKzGAzGPzzAE0=;
        b=cl7jBSeE24GPUS2/Vjr7pxE1l1HhpqeodkSawIn7AnAkMspK/ZTYF31KKdzOw8gASwtfDv
        2hGyheExp2r/xfN9WNKn6KatUx3hUvd7T886Tskdr9kmUEmbUEdbH6V00kafwkSeR4YsQG
        m/o1jLoL3EthBv+bwyu6pOgVjCE8Kro=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D91D213582;
        Wed, 13 Sep 2023 13:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0iCBM9C6AWWQSQAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 13 Sep 2023 13:36:16 +0000
Message-ID: <a9c40219-2d35-4b2c-9150-12386b53bad7@suse.com>
Date:   Wed, 13 Sep 2023 15:36:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] x86/xen: move paravirt lazy code
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        xen-devel@lists.xenproject.org
References: <20230913113828.18421-1-jgross@suse.com>
 <20230913113828.18421-3-jgross@suse.com>
 <20230913092646.5b087871@gandalf.local.home>
Content-Language: en-US
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
In-Reply-To: <20230913092646.5b087871@gandalf.local.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------3pzlhP0KJw5LafdvvkkTAoFS"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------3pzlhP0KJw5LafdvvkkTAoFS
Content-Type: multipart/mixed; boundary="------------Qn0U9WdgquTmsv08sK3l9avh";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 virtualization@lists.linux-foundation.org,
 linux-trace-kernel@vger.kernel.org, Ajay Kaher <akaher@vmware.com>,
 Alexey Makhalov <amakhalov@vmware.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, xen-devel@lists.xenproject.org
Message-ID: <a9c40219-2d35-4b2c-9150-12386b53bad7@suse.com>
Subject: Re: [PATCH 2/3] x86/xen: move paravirt lazy code
References: <20230913113828.18421-1-jgross@suse.com>
 <20230913113828.18421-3-jgross@suse.com>
 <20230913092646.5b087871@gandalf.local.home>
In-Reply-To: <20230913092646.5b087871@gandalf.local.home>

--------------Qn0U9WdgquTmsv08sK3l9avh
Content-Type: multipart/mixed; boundary="------------m7XwnswAohYEw97MOxfAzYFf"

--------------m7XwnswAohYEw97MOxfAzYFf
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDkuMjMgMTU6MjYsIFN0ZXZlbiBSb3N0ZWR0IHdyb3RlOg0KPiBPbiBXZWQsIDEz
IFNlcCAyMDIzIDEzOjM4OjI3ICswMjAwDQo+IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNl
LmNvbT4gd3JvdGU6DQo+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdHJhY2UvZXZlbnRz
L3hlbi5oIGIvaW5jbHVkZS90cmFjZS9ldmVudHMveGVuLmgNCj4+IGluZGV4IDQ0YTNmNTY1
MjY0ZC4uMDU3N2YwY2RkMjMxIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS90cmFjZS9ldmVu
dHMveGVuLmgNCj4+ICsrKyBiL2luY2x1ZGUvdHJhY2UvZXZlbnRzL3hlbi5oDQo+PiBAQCAt
NiwyNiArNiwyNiBAQA0KPj4gICAjZGVmaW5lIF9UUkFDRV9YRU5fSA0KPj4gICANCj4+ICAg
I2luY2x1ZGUgPGxpbnV4L3RyYWNlcG9pbnQuaD4NCj4+IC0jaW5jbHVkZSA8YXNtL3BhcmF2
aXJ0X3R5cGVzLmg+DQo+PiArI2luY2x1ZGUgPGFzbS94ZW4vaHlwZXJ2aXNvci5oPg0KPj4g
ICAjaW5jbHVkZSA8YXNtL3hlbi90cmFjZV90eXBlcy5oPg0KPj4gICANCj4+ICAgc3RydWN0
IG11bHRpY2FsbF9lbnRyeTsNCj4+ICAgDQo+PiAgIC8qIE11bHRpY2FsbHMgKi8NCj4+ICAg
REVDTEFSRV9FVkVOVF9DTEFTUyh4ZW5fbWNfX2JhdGNoLA0KPj4gLQkgICAgVFBfUFJPVE8o
ZW51bSBwYXJhdmlydF9sYXp5X21vZGUgbW9kZSksDQo+PiArCSAgICBUUF9QUk9UTyhlbnVt
IHhlbl9sYXp5X21vZGUgbW9kZSksDQo+PiAgIAkgICAgVFBfQVJHUyhtb2RlKSwNCj4+ICAg
CSAgICBUUF9TVFJVQ1RfX2VudHJ5KA0KPj4gLQkJICAgIF9fZmllbGQoZW51bSBwYXJhdmly
dF9sYXp5X21vZGUsIG1vZGUpDQo+PiArCQkgICAgX19maWVsZChlbnVtIHhlbl9sYXp5X21v
ZGUsIG1vZGUpDQo+PiAgIAkJICAgICksDQo+PiAgIAkgICAgVFBfZmFzdF9hc3NpZ24oX19l
bnRyeS0+bW9kZSA9IG1vZGUpLA0KPj4gICAJICAgIFRQX3ByaW50aygic3RhcnQgYmF0Y2gg
TEFaWV8lcyIsDQo+PiAtCQkgICAgICAoX19lbnRyeS0+bW9kZSA9PSBQQVJBVklSVF9MQVpZ
X01NVSkgPyAiTU1VIiA6DQo+PiAtCQkgICAgICAoX19lbnRyeS0+bW9kZSA9PSBQQVJBVklS
VF9MQVpZX0NQVSkgPyAiQ1BVIiA6ICJOT05FIikNCj4+ICsJCSAgICAgIChfX2VudHJ5LT5t
b2RlID09IFhFTl9MQVpZX01NVSkgPyAiTU1VIiA6DQo+PiArCQkgICAgICAoX19lbnRyeS0+
bW9kZSA9PSBYRU5fTEFaWV9DUFUpID8gIkNQVSIgOiAiTk9ORSIpDQo+IA0KPiBUaGVyZSdz
IGhlbHBlciBmdW5jdGlvbnMgdGhhdCBtYWtlIHRoZSBhYm92ZSBlYXNpZXIgdG8gaW1wbGVt
ZW50IGFzIHdlbGwgYXMNCj4gZXhwb3J0cyB0aGUgc3ltYm9scyBzbyB0aGF0IHVzZXIgc3Bh
Y2UgY2FuIHBhcnNlIHRoaXMgYmV0dGVyOg0KPiANCj4gVFJBQ0VfREVGSU5FX0VOVU0oWEVO
X0xBWllfTk9ORSk7DQo+IFRSQUNFX0RFRklORV9FTlVNKFhFTl9MQVpZX01NVSk7DQo+IFRS
QUNFX0RFRklORV9FTlVNKFhFTl9MQVpZX0NQVSk7DQo+IA0KPiBbLi5dDQo+IA0KPiAgICAJ
ICAgIFRQX3ByaW50aygic3RhcnQgYmF0Y2ggTEFaWV8lcyIsDQo+IAkJICAgICAgX19wcmlu
dF9zeW1ib2xpYyhtb2RlLA0KPiAJCQkJICAgICAgIHsgWEVOX0xBWllfTk9ORSwgIk5PTkUi
IH0sDQo+IAkJCQkgICAgICAgeyBYRU5fTEFaWV9NTVUsICAiTU1VICAgfSwNCj4gCQkJCSAg
ICAgICB7IFhFTl9MQVpZX0NQVSwgICJDUFUiICB9KSkNCj4gDQo+IFRoZW4gdXNlciBzcGFj
ZSBwYXJzZXJzIHRoYXQgcmVhZCB0aGUgcmF3IGRhdGEgY2FuIGNvbnZlcnQgdGhlc2UgZXZl
bnRzDQo+IGludG8gc29tZXRoaW5nIGh1bWFucyBjYW4gcmVhZC4NCg0KVGhhbmtzLiBJJ2xs
IGFkZCB0aGF0IHRvIGFub3RoZXIgcGF0Y2ggSSdtIGp1c3Qgd3JpdGluZyBmb3IgY2xlYW5p
bmcgdXANCmluY2x1ZGUvdHJhY2UvZXZlbnRzL3hlbi5oIChzb21lIGRlZmluZWQgdHJhY2Ug
ZXZlbnRzIGFyZSBubyBsb25nZXIgdXNlZCkuDQoNCg0KSnVlcmdlbg0K
--------------m7XwnswAohYEw97MOxfAzYFf
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------m7XwnswAohYEw97MOxfAzYFf--

--------------Qn0U9WdgquTmsv08sK3l9avh--

--------------3pzlhP0KJw5LafdvvkkTAoFS
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmUButAFAwAAAAAACgkQsN6d1ii/Ey8v
9AgAlOID708UmZj3K8hkqk6Pm9kbMOEhaTrQu1GKIcZaRDZScorxEdikvXWrlXRk3uEcxmt5iTom
px5TsHW874CxMXY14HFFsBSpMdw4JX65JfDHZuyBCpIEHhKWj7+6jGw1nDy25f+z+XuNMkwhmQNC
EKKsdtOrwLez9COjqgjkyc/y0W20IMKlbjsu2k+akXIBHoOs3FbOf8xpgYX1M7x8J8LyrQYKVFqT
HSjZ0YdF3dqif9Sts8QgsAjd+XF1SJI/mjspAhR5nJjnoeCNse+5VdTwjw2uJpHYrkqyEIuAbzdO
tQi+5vYlGoZIFmqnvFjKS23PXSg0mXHCMGDsDm5FlQ==
=kAEO
-----END PGP SIGNATURE-----

--------------3pzlhP0KJw5LafdvvkkTAoFS--
