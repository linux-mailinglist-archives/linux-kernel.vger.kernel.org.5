Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599A479C6E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjILG03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjILG02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:26:28 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D0EAF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:26:24 -0700 (PDT)
Message-ID: <0f6ce98c-8f03-4ce1-badd-ae1346456a3e@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694499981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=aNUbpcZKyS33tsMES6/JtJfttTT3nS6SkoP+CW5Fg3M=;
        b=vfCAvUIoAjMdV7SpQ+o2/P1BhUwWB0D287Y05OicbJcDxEykKvUefT9JcnFyP9y4N0N6/b
        O+L3QpbbC0pvKlhuLOpF033swO8IDBI1jXWF0ILlO8+gMdvpJAdO6VajqnChJorNPo8x3y
        0Dgrtt41bonrxBU32/k/QKUt+HK2dKBKbZlCu+79dqysVP86ZzMT2Uru2iWxsfi96V3M01
        GjCY1G2DOvraq9a8s3SToZFBqEfMSS9cNBEAUoLxBtH5xhoZivbN69y+ozEDNDBoQ2lTNV
        eaoLqt9hgqq4aXYxQi9YpkPnYdTdKQaI/sELDdvPT777SkeH4kditt7PKF2DQtFnB5at2T
        Oeahw0fuswUgGAC0P9Hw0sdcQcaoWcgoGQUjRO2p9FZy2Jcs427CUuj0fztQhi/qpY3JdG
        NjgVPCrT8QGap2KCWy0DnFoNzgvFL2iH1Rnc5bv13d/X8ly8NoFAucfdjS4cM4/KgH5QM/
        JV2Jgeu8slW+i/zVHpH2U6oad0jXn6AIBJrWIn2TzhR0VNxid7MjLBMwREPKK5prO/boco
        qiFCBFMR1cz/Z1DT4HD7LAO/or6PNiNnfsSUwqbQYz+j852pzdfhCKNPmJ4mbvm3EJi+fM
        jSaofSbUDzOkB6gUZZKp89aGj6RDQDL4LxMi9PWPC1ubVGgR6gIVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694499981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=aNUbpcZKyS33tsMES6/JtJfttTT3nS6SkoP+CW5Fg3M=;
        b=+ux4rQgMcJMZa8cDqWHgls+BZfCmoRgcP0V5KWpsx4VE3Ux10lCFFUOkvPpR0qQdQsQYxN
        fqyhzCRuCHaPanAA==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date:   Tue, 12 Sep 2023 09:26:19 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Content-Language: en-US-large
To:     Keith Busch <kbusch@kernel.org>
Cc:     highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwd1@hotmail.com
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
From:   Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oD3lDKLB2nOmfEsRYr4l7whR"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oD3lDKLB2nOmfEsRYr4l7whR
Content-Type: multipart/mixed; boundary="------------RyMy3k0Lef9HrxHkgX042o6X";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Keith Busch <kbusch@kernel.org>
Cc: highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, xuwd1@hotmail.com
Message-ID: <0f6ce98c-8f03-4ce1-badd-ae1346456a3e@archlinux.org>
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>

--------------RyMy3k0Lef9HrxHkgX042o6X
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS8xMi8yMyAwMjowMCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IFdoYXQgZG8geW91IHRo
aW5rIGFib3V0IHRoaXMgY2hhbmdlIGluc3RlYWQ/IFdlIGRvbid0IG5lZWQgdG8gcHJpbnQg
YQ0KPiB3YXJuaW5nIG9uIGV2ZXJ5IGRldmljZSByZXNldCwgYnV0IHdlIHNob3VsZCBwcm9i
YWJseSBhZGQgYSBjb21tZW50DQo+IGV4cGxhaW5pbmcgd2h5IHRoaXMgaXMgaGFwcGVuaW5n
Lg0KPiANCj4gLS0tDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMg
Yi9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMNCj4gaW5kZXggMzdiNmZhNzQ2NjYyMC4uYjQ1
NzdhODYwZTY3NyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+
ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0L2NvcmUuYw0KPiBAQCAtMjI0NSw2ICsyMjQ1LDcg
QEAgaW50IG52bWVfZW5hYmxlX2N0cmwoc3RydWN0IG52bWVfY3RybCAqY3RybCkNCj4gICAJ
ZWxzZQ0KPiAgIAkJY3RybC0+Y3RybF9jb25maWcgPSBOVk1FX0NDX0NTU19OVk07DQo+ICAg
DQo+ICsJdGltZW91dCA9IE5WTUVfQ0FQX1RJTUVPVVQoY3RybC0+Y2FwKTsNCj4gICAJaWYg
KGN0cmwtPmNhcCAmIE5WTUVfQ0FQX0NSTVNfQ1JXTVMpIHsNCj4gICAJCXUzMiBjcnRvOw0K
PiAgIA0KPiBAQCAtMjI1NywxMiArMjI1OCwxNSBAQCBpbnQgbnZtZV9lbmFibGVfY3RybChz
dHJ1Y3QgbnZtZV9jdHJsICpjdHJsKQ0KPiAgIA0KPiAgIAkJaWYgKGN0cmwtPmNhcCAmIE5W
TUVfQ0FQX0NSTVNfQ1JJTVMpIHsNCj4gICAJCQljdHJsLT5jdHJsX2NvbmZpZyB8PSBOVk1F
X0NDX0NSSU1FOw0KPiAtCQkJdGltZW91dCA9IE5WTUVfQ1JUT19DUklNVChjcnRvKTsNCj4g
KwkJCS8qDQo+ICsJCQkgKiBDUklNVCBzaG91bGQgYWx3YXlzIGJlIGdyZWF0ZXIgb3IgZXF1
YWwgdG8gQ0FQLlRPLA0KPiArCQkJICogYnV0IHNvbWUgZGV2aWNlcyBhcmUga25vd24gdG8g
Z2V0IHRoaXMgd3JvbmcuIFVzZQ0KPiArCQkJICogdGhlIGxhcmdlciBvZiB0aGUgdHdvIHZh
bHVlcy4NCj4gKwkJCSAqLw0KPiArCQkJdGltZW91dCA9IG1heCh0aW1lb3V0LCBOVk1FX0NS
VE9fQ1JJTVQoY3J0bykpOw0KPiAgIAkJfSBlbHNlIHsNCj4gICAJCQl0aW1lb3V0ID0gTlZN
RV9DUlRPX0NSV01UKGNydG8pOw0KPiAgIAkJfQ0KPiAtCX0gZWxzZSB7DQo+IC0JCXRpbWVv
dXQgPSBOVk1FX0NBUF9USU1FT1VUKGN0cmwtPmNhcCk7DQo+ICAgCX0NCj4gICANCj4gICAJ
Y3RybC0+Y3RybF9jb25maWcgfD0gKE5WTUVfQ1RSTF9QQUdFX1NISUZUIC0gMTIpIDw8IE5W
TUVfQ0NfTVBTX1NISUZUOw0KDQpJJ20gZmluZSBlaXRoZXIgd2F5Lg0KDQpTaG91bGQgd2Ug
YWxzbyBhcHBseSB0aGUgc2FtZSBtYXgoKSBvbiB0aGUgTlZNRV9DUlRPX0NSSU1UIGJyYW5j
aCANCnRob3VnaD8gVGhlIHNwZWMgYWN0dWFsbHkgc2F5cyB0aGUgc2FtZSB0aGluZyAoVGlt
ZW91dCBzaG91bGQgYmUgRkZoKSANCmZvciB0aGF0IHRvby4NCg0KLS0gDQpSZWdhcmRzLA0K
RmVsaXggWWFuDQoNCg==

--------------RyMy3k0Lef9HrxHkgX042o6X--

--------------oD3lDKLB2nOmfEsRYr4l7whR
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmUABIsFAwAAAAAACgkQeGxj8zDXy5JZ
tQ//Ss35+lgOpISx+SQo1ZGjhqZ8wAhoWZ8D4YQw1nJZ1IBStliRjTV1VrLZsNfkBioXS3jtwPYK
rMii4K4i0rZeb22cvQ6lzs2CyYqLyUJIhtQCKhkPC95b1xlnVj9m6KSUoq71xYS1XKUBc/NRsyjj
K3jMsWwtWK+zQuK0N/LUJQ3HYZ81rGDKiRBc8FVkqBWm++Pk0k+5g6Qxoc44oHNxjqdrzC54Xzzp
yZOS1VhXhjr342SI0l619ABXokD93AirUHzPf18f4FwHCiwdrj9HBkAdbrigjhikVuTLgl3itFO9
Z0qBn32T43G+zR8gb3wFixrlXnt2O1b8tnnTH95MROzvuvKwQ2v1yfzAOLzPSYVRji9i45P78QJo
DZjSUV8JeoKjDncohFw9snD5yfzNt7FN5cKGRQQOEUeWeaAwjaMRq1xq1FhNhdmNnNw4xN52/e4Z
klWqzNRcg43Hma2vjWGWFb5qTiLXMwjcFYSrJw2sqheUEyi+x6zyjMB1bvbZmNJalEEB5o3A9zlb
7DYTg76xZ2BIbNfMQVRQhxUuvnyHPhvZk6WY8gDCz9yflP6CvkgI8jz3xbYNEpjLs0tLn/Kb5OuI
n7f0fP79GVH3ehN/bvKNwhqpRdTruAEIBLr5ErX7AO4/7miPoG9PeWa5/StwoPlr0XkTpX1H6Rst
Mrg=
=F4bC
-----END PGP SIGNATURE-----

--------------oD3lDKLB2nOmfEsRYr4l7whR--
