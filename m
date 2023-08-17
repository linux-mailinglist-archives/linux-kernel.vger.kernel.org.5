Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6157577F03B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 07:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348108AbjHQFdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 01:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348115AbjHQFdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 01:33:08 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35CBE55
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 22:33:03 -0700 (PDT)
Message-ID: <7cd693dd-a6d7-4aab-aef0-76a8366ceee6@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1692250381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=I7WeYnfcifQhebWaXV3SSVO+etmZCeR3UBW60p2Wglo=;
        b=jJo/nT1IalgeQkAHMB2AKbu96ZoOVtC3uESR2TtCh/dvc3TydtmyWYuFrLEJ4k4TF0ONc2
        NT7K+gI/jjxunCFP8G2o90QC3WbgeWw8yeW25tZpetFwwBzAOX1U4TLPD0qvKmL7EFrvfd
        8ORTicU0iXyyos02VA7603ovrsV9Qe9b6D2q7g08lm9MTs4mqxqc02/zwXRLjQe+iQAfQe
        lU9wLAlwZQy56KpcvmWp2h+ctTy0wAgskcmM2xpYPzNtWYeJ0RIG0MyXeZAUngB+Bzv/Ty
        bMM8p2sEhPtCotsL1BRKI5b2kor1yKFFaKwsfmZzcM13UfIXJtFgmzFwzacupPRlMslT1D
        uHElCQ9tVU0mcPzpR5aqWrtQ1em3LSQ1BcR9gd+BESi2i4iZQ3KaXZdZqEQET0lLcF3MA0
        rUpefrEoqgBcYAFj0apIsVhUGn1nQWdIhsKWbpn4OHqQLjU78Dd8chXsrZtgquvRsTuFve
        g282EhOAl8OE32a1g7EXslqhjYwRlxvyXu92EauxgXEd9hnC3BFkbasrktbNW17DtI8NSL
        MJimCO6d8hMqtWhesU3ow5EKMFT05lwsA34woFoSniixGe8Uh4jjG3nfdWrvkLmMONeIg1
        n5BNBDiADnx7IeNNSkjazav+yqFPWuUTT7FxQQl8WQhUZF6KaVeK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1692250381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=I7WeYnfcifQhebWaXV3SSVO+etmZCeR3UBW60p2Wglo=;
        b=4GsxeAb8YJCzBUF6UHiUMMzZz9jyPavHlpIM3WinZsYyLrKnGhVxkxQzIlUR+3KXUyXqh4
        jl4vXPx4HG3kQvBA==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date:   Thu, 17 Aug 2023 08:32:52 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO
 MAP1602
Content-Language: en-US-large
To:     Han Gao <highenthalpyh@gmail.com>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Xu <xuwd1@hotmail.com>
References: <20230714131333.5858-1-highenthalpyh@gmail.com>
From:   Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <20230714131333.5858-1-highenthalpyh@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------bW0SZp00VRK2ZZ00c0uzUkeZ"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------bW0SZp00VRK2ZZ00c0uzUkeZ
Content-Type: multipart/mixed; boundary="------------0DW0vqODtza9vCHLJ02v03Ef";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Han Gao <highenthalpyh@gmail.com>, kbusch@kernel.org, axboe@kernel.dk,
 hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 David Xu <xuwd1@hotmail.com>
Message-ID: <7cd693dd-a6d7-4aab-aef0-76a8366ceee6@archlinux.org>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_DELAY_BEFORE_CHK_RDY for MAXIO
 MAP1602
References: <20230714131333.5858-1-highenthalpyh@gmail.com>
In-Reply-To: <20230714131333.5858-1-highenthalpyh@gmail.com>

--------------0DW0vqODtza9vCHLJ02v03Ef
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNy8xNC8yMyAxNjoxMywgSGFuIEdhbyB3cm90ZToNCj4gNFRCIFNTRCB3aXRoIE1BWElP
IE1BUDE2MDIgY29udHJvbGxlciBpcyBjYW5ub3QgYnkgaW5pdGlhbGlzZWQNCj4gaW4gbnZt
ZV9lbmFibGVfY3RybCB3aXRoIGEgaGlnaCBwcm9iYWJpbGl0eSwgd2hpY2ggY2F1c2VkcyB0
aGUgc3lzdGVtDQo+IHRvIGJlIHVuYWJsZSB0byB1c2UgU1NELCBhbmQgU1NEIGRldmljZSBv
bmx5IGJlIHNob3duIGluIGxzcGNpLg0KPiANCj4gZG1lc2cgb3V0cHV0IG9mIHByb2JsZW0N
Cj4gDQo+IC0tLS0tLS0tLS0NCj4gbnZtZSBudm1lMTogRGV2aWNlIG5vdCByZWFkeTsgYWJv
cnRpbmcgaW5pdGlhbGlzYXRpb24sIENTVFM9MHgwDQo+IC0tLS0tLS0tLS0NCj4gDQo+IFBy
b2JsZW0gYW5kIGZpeCBhcmUgdmVyaWZpZWQgd2l0aCBteSBNQVAxNjAyIGNvbnRyb2xsZXIg
U1NEIGRldmljZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhhbiBHYW8gPGhpZ2hlbnRoYWxw
eWhAZ21haWwuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBYdSA8eHV3ZDFAaG90bWFp
bC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIHwgMyArKy0NCj4g
ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9kcml2ZXJzL252bWUv
aG9zdC9wY2kuYw0KPiBpbmRleCA0OTJmMzE5ZWJkZjMuLmY3NWMyNzczMGJkZSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMNCj4gKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvcGNpLmMNCj4gQEAgLTM0MjUsNyArMzQyNSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgcGNpX2RldmljZV9pZCBudm1lX2lkX3RhYmxlW10gPSB7DQo+ICAgCXsgUENJX0RFVklD
RSgweDFlNEIsIDB4MTIwMiksICAgLyogTUFYSU8gTUFQMTIwMiAqLw0KPiAgIAkJLmRyaXZl
cl9kYXRhID0gTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sDQo+ICAgCXsgUENJX0RFVklDRSgw
eDFlNEIsIDB4MTYwMiksICAgLyogTUFYSU8gTUFQMTYwMiAqLw0KPiAtCQkuZHJpdmVyX2Rh
dGEgPSBOVk1FX1FVSVJLX0JPR1VTX05JRCwgfSwNCj4gKwkJLmRyaXZlcl9kYXRhID0gTlZN
RV9RVUlSS19CT0dVU19OSUQgfA0KPiArCQkJCU5WTUVfUVVJUktfREVMQVlfQkVGT1JFX0NI
S19SRFksIH0sDQo+ICAgCXsgUENJX0RFVklDRSgweDFjYzEsIDB4NTM1MCksICAgLyogQURB
VEEgWFBHIEdBTU1JWCBTNTAgKi8NCj4gICAJCS5kcml2ZXJfZGF0YSA9IE5WTUVfUVVJUktf
Qk9HVVNfTklELCB9LA0KPiAgIAl7IFBDSV9ERVZJQ0UoMHgxZGJlLCAweDUyMzYpLCAgIC8q
IEFEQVRBIFhQRyBHQU1NSVggUzcwICovDQoNClVuZm9ydHVuYXRlbHkgdGhpcyBkb2Vzbid0
IGZpeCBpdCBmb3IgbWUuIEFzIHNvbWVvbmUgcG9pbnRlZCBvdXQgaW4gdGhlIA0KZm9ydW1z
IFsxXSwgdGhlIHF1aXJrIE5WTUVfUVVJUktfREVMQVlfQkVGT1JFX0NIS19SRFkgb25seSB0
YWtlcyBlZmZlY3QgDQppbiBudm1lX2Rpc2FibGVfY3RybCgpLCBidXQgd2UgYXJlIGhpdHRp
bmcgdGhlIHRpbWVvdXQgaXNzdWUgaW4gDQpudm1lX2VuYWJsZV9jdHJsKCkgaW5zdGVhZC4N
Cg0KSSBoYXZlIHRyaWVkIDYuNS1yYzUgd2l0aCBvciB3aXRob3V0IHRoaXMgcGF0Y2ggYnV0
IGdvdCBtaXhlZCByZXN1bHRzIA0KZHVlIHRvIGV2ZW4gbW9yZSBzZXZlcmUgZGlzay13cml0
aW5nIHJlbGF0ZWQgaXNzdWVzIChkZWFkbG9jayBpbiB3cml0aW5nIA0KdG8gYW55IGRpc2sp
Lg0KDQpXaXRoIHRoZSBmb2xsb3dpbmcgcGF0Y2ggdGFrZW4gZnJvbSB0aGUgZm9ydW1zLCB0
aGUgU1NEcyB3b3JrIGZsYXdsZXNzbHkgDQpvbiA2LjQuWCBrZXJuZWxzOg0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jIGIvZHJpdmVycy9udm1lL2hvc3QvY29y
ZS5jDQppbmRleCAzZWMzOGUyYjkxNzMuLmFiMjU4M2NiNDJhYSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KKysrIGIvZHJpdmVycy9udm1lL2hvc3QvY29yZS5j
DQpAQCAtMjQwOCw2ICsyNDA4LDcgQEAgaW50IG52bWVfZW5hYmxlX2N0cmwoc3RydWN0IG52
bWVfY3RybCAqY3RybCkNCiAgICAgICAgIH0gZWxzZSB7DQogICAgICAgICAgICAgICAgIHRp
bWVvdXQgPSBOVk1FX0NBUF9USU1FT1VUKGN0cmwtPmNhcCk7DQogICAgICAgICB9DQorICAg
ICAgIGRldl9pbmZvKGN0cmwtPmRldmljZSwgIltQQVRDSF0gbnZtZSBjb3JlIGdvdCB0aW1l
b3V0IA0KJXVcbiIsdGltZW91dCk7DQoNCiAgICAgICAgIGN0cmwtPmN0cmxfY29uZmlnIHw9
IChOVk1FX0NUUkxfUEFHRV9TSElGVCAtIDEyKSA8PCANCk5WTUVfQ0NfTVBTX1NISUZUOw0K
ICAgICAgICAgY3RybC0+Y3RybF9jb25maWcgfD0gTlZNRV9DQ19BTVNfUlIgfCBOVk1FX0ND
X1NITl9OT05FOw0KQEAgLTI0MjUsOCArMjQyNiw5IEBAIGludCBudm1lX2VuYWJsZV9jdHJs
KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpDQogICAgICAgICByZXQgPSBjdHJsLT5vcHMtPnJl
Z193cml0ZTMyKGN0cmwsIE5WTUVfUkVHX0NDLCBjdHJsLT5jdHJsX2NvbmZpZyk7DQogICAg
ICAgICBpZiAocmV0KQ0KICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KKyAgICAgICBk
ZXZfaW5mbyhjdHJsLT5kZXZpY2UsICJbUEFUQ0hdIG52bWVfd2FpdF9yZWFkeSBub3cgd2Fp
dCBmb3IgJXUsIA0KcHJldmlvdXNseSAldVxuIiwodGltZW91dCArIDEpICogMiwgKHRpbWVv
dXQgKyAxKS8yKTsNCiAgICAgICAgIHJldHVybiBudm1lX3dhaXRfcmVhZHkoY3RybCwgTlZN
RV9DU1RTX1JEWSwgTlZNRV9DU1RTX1JEWSwNCi0gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAodGltZW91dCArIDEpIC8gMiwgImluaXRpYWxpc2F0aW9uIik7DQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHRpbWVvdXQgKyAxKSAqIDIsICJpbml0aWFsaXNhdGlv
biIpOw0KICB9DQogIEVYUE9SVF9TWU1CT0xfR1BMKG52bWVfZW5hYmxlX2N0cmwpOw0KDQpE
ZWJ1ZyBvdXRwdXRzIGluIHRoZSBkbWVzZzoNCg0KWyAgICAxLjAzMDA1N10gbnZtZSBudm1l
MTogW1BBVENIXSBudm1lIGNvcmUgZ290IHRpbWVvdXQgMA0KWyAgICAxLjAzMDA2Ml0gbnZt
ZSBudm1lMTogW1BBVENIXSBudm1lX3dhaXRfcmVhZHkgbm93IHdhaXQgZm9yIDIsIA0KcHJl
dmlvdXNseSAwDQpbICAgIDEuMDMxMzU2XSBudm1lIG52bWUwOiBbUEFUQ0hdIG52bWUgY29y
ZSBnb3QgdGltZW91dCAwDQpbICAgIDEuMDMxMzY4XSBudm1lIG52bWUwOiBbUEFUQ0hdIG52
bWVfd2FpdF9yZWFkeSBub3cgd2FpdCBmb3IgMiwgDQpwcmV2aW91c2x5IDANCg0KNi4xIExU
UyBrZXJuZWxzIGRvbid0IGhhdmUgdGhpcyBwcm9ibGVtIGJlY2F1c2UgdGhlIHRpbWVvdXQg
aXNuJ3QgMCBoZXJlLg0KDQpXb3VsZCBpdCBiZSBhIGdvb2QgaWRlYSB0byBhcHBseSBOVk1F
X1FVSVJLX0RFTEFZX0JFRk9SRV9DSEtfUkRZIHRvIA0KbnZtZV9lbmFibGVfY3RybCB0b28/
IE9yIHNoYWxsIHdlIGFkZCBhbm90aGVyIHF1aXJrIGp1c3QgZm9yIHRoaXM/DQoNClsxXSAN
Cmh0dHBzOi8vd3d3LmNoaXBoZWxsLmNvbS9mb3J1bS5waHA/bW9kPXZpZXd0aHJlYWQmdGlk
PTI1MjQ2NjAmZXh0cmE9JnBhZ2U9NSZtb2JpbGU9bm8gDQooaW4gQ2hpbmVzZSkNCg0KLS0g
DQpSZWdhcmRzLA0KRmVsaXggWWFuDQoNCg==

--------------0DW0vqODtza9vCHLJ02v03Ef--

--------------bW0SZp00VRK2ZZ00c0uzUkeZ
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmTdsQUFAwAAAAAACgkQeGxj8zDXy5Jf
MRAAoO1YdWVakyW/dWECr2O+xtfNWBpSw/nRpjrlEuF5NcZaQ48Q4Vdua8OdpSYxub2Z0NMqJvgr
Fh7qKYM6sp3rieWIR3gU+iYwfbntiTgi2iF+TZjEiDmD23luCAkUWYzPcuB3pxwW6dXzjR+SbIt0
gaaJ8okdrUMmLmVHmh/uLNx4NyDVGEK9tNpsOHEiFJnH5iMLtvvXbelTVL21K/o8UT00SRIATyVx
hH85BQr28ayPfyTWwN+uLVpuqYwQ3sbsvdhym51U9VygmEIn72VukkUt/Sdo+/S9xKfSE1syeqb5
hzt2iY7v4AvQYwmO1wTJYmzNMcOHIX+Mto2ZxlPNuSUFFlPQsZtwmTEyw0XsQ9z0ycARKkstZvGD
+nHbcqT+jg/ts3S6b6OQttUZ25u16Njw5Vy9bgz16QZTDCgTX2ux0Dn3A0fvXfgXB1pbWz8TIf4A
FCAf/cDiIPZHl8L/xBSH6lDlIX35r3dMhsVFxDgNgw0ELR7H+4rIfqdmzKsIZJ0A8LDuqAXv8NEz
LYksFitMo1rGEmVLnmHpTUPI0coL1w3plD5odDRgYtkYHFz2EEvS32Do/dmA7c1B7rmxHdYYGOUB
36KPvgZG3DsfgekJ27GX7s3+ZCrYvrSe8p1QQglqAlaoIVo/D1gMOgjEDQ+2SnbX+z8jEoh4g8Fj
gKU=
=Mhrn
-----END PGP SIGNATURE-----

--------------bW0SZp00VRK2ZZ00c0uzUkeZ--
