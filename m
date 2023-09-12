Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F4A79D94C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjILTHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjILTHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:07:32 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26733E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 12:07:28 -0700 (PDT)
Message-ID: <ca5729af-70db-4126-8973-f9036f41ede9@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694545645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=mmzyd0jnqZsyn+LRfXAOTBvUoO1+JhMqw43RAR6oESY=;
        b=htQLqDBSrSMyhahzLIwWIBh/L5bCmkxImj0vHycbviogHpns00Nae2foD5RAUZ07eqmFXk
        oNC03vcB8zqU+3oDc7hhmUGUinHwpjwxnezBTTGHG/poQM3rUzUJTo9qlJjQEmf0Qog5fq
        3MMaDib+6v2cChIKAbEWP+bFRWsN0SC5wNY5WqN1Y1lCHk8fU8x1bZs54w/Fl5qTbt4Bzl
        pZIrif/kUeLoFCCAj+PoeF2w/LqkjSTcuUo7FxJ42i0LmU4SCZk5TT2vXtg/eMWSYWG597
        rWk8CoEa0ijqAl8J/IJPnAKeEPwOrmf8QCiXVaQeoEdbSDTgnxTJRoSoK/Bzz8WMSTZ36M
        re6n2pscNnh9gy4SFMmhcsbirUHwOhTF48+/fhf5RTOLFNzT2jrPYtjOWLsOM6M5QfO5UR
        54YL6DIvkDO51Ys2TmFWUkPG5RTDXxWUyXUWb3x7TwIiIhzKXsq0dZAUR9/CM+SXjOs9nE
        JMorNg24VgsuV+3ZU+LAd9g2twlYNvnKJgfPRE2iSDOJkySlnUuIfoNtTPDvrb0etoWcWI
        EHtg2ZB3Hz9mTt/7Ygs5tQGtL7ZlWdutgjBWivODK+E59EnfAzu4QtSclBxhw/gxE8HQ2S
        oGRFnut789Y+AXtOjl+nlJFv6U1QM/jpot8nE08GK0+oznSpQuO7Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694545645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=mmzyd0jnqZsyn+LRfXAOTBvUoO1+JhMqw43RAR6oESY=;
        b=u0N7GyXEhmOPCvMxO5flPcd9GKPfAegMrHBA0M9PWzBGDXYSFV54ripOcsQzBIi1KhaiqO
        qKVxWsTaHexEriCw==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date:   Tue, 12 Sep 2023 22:07:21 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Content-Language: en-US-large
To:     Keith Busch <kbusch@kernel.org>
Cc:     highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwd1@hotmail.com, hch@lst.de
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
 <0f6ce98c-8f03-4ce1-badd-ae1346456a3e@archlinux.org>
 <ZQCHS2L59vRNmZbV@kbusch-mbp.dhcp.thefacebook.com>
From:   Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <ZQCHS2L59vRNmZbV@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------H841eNckoKp4go5G01Qhb02U"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------H841eNckoKp4go5G01Qhb02U
Content-Type: multipart/mixed; boundary="------------oVpTfcvphLmb39J1F7QwljMG";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Keith Busch <kbusch@kernel.org>
Cc: highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, xuwd1@hotmail.com, hch@lst.de
Message-ID: <ca5729af-70db-4126-8973-f9036f41ede9@archlinux.org>
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZP-cGgPzIX7WkNRb@kbusch-mbp.dhcp.thefacebook.com>
 <0f6ce98c-8f03-4ce1-badd-ae1346456a3e@archlinux.org>
 <ZQCHS2L59vRNmZbV@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZQCHS2L59vRNmZbV@kbusch-mbp.dhcp.thefacebook.com>

--------------oVpTfcvphLmb39J1F7QwljMG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS8xMi8yMyAxODo0NCwgS2VpdGggQnVzY2ggd3JvdGU6DQo+IE9uIFR1ZSwgU2VwIDEy
LCAyMDIzIGF0IDA5OjI2OjE5QU0gKzAzMDAsIEZlbGl4IFlhbiB3cm90ZToNCj4+DQo+PiBT
aG91bGQgd2UgYWxzbyBhcHBseSB0aGUgc2FtZSBtYXgoKSBvbiB0aGUgTlZNRV9DUlRPX0NS
SU1UIGJyYW5jaCB0aG91Z2g/DQo+PiBUaGUgc3BlYyBhY3R1YWxseSBzYXlzIHRoZSBzYW1l
IHRoaW5nIChUaW1lb3V0IHNob3VsZCBiZSBGRmgpIGZvciB0aGF0IHRvby4NCj4gDQo+IFRo
ZSBzcGVjIGlzIHdlaXJkIGhlcmU6IHRoZSBDQVAuVE8gdmFsdWUgZGVwZW5kcyBvbiB0aGUg
Q0Mgc2V0dGluZywgYnV0DQo+IHdlIHJlYWQgYW5kIGNhY2hlIENBUC5UTyBiZWZvcmUgc2V0
dGluZyBDQywgc28gVE8gaXMgYWx3YXlzIGFzc29jaWF0ZWQNCj4gdG8gQ1JXTVQuIFdlJ2xs
IG5lZWQgdG8gcmVmcmVzaCB0aGUgQ0FQIHZhbHVlIGFmdGVyIHRoZSBpbml0aWFsIENDDQo+
IHdyaXRlLCBidXQgYmVmb3JlIGZpbmFsIENDLkVOLg0KPiANCj4gLS0tDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL252bWUvaG9zdC9jb3JlLmMgYi9kcml2ZXJzL252bWUvaG9zdC9jb3Jl
LmMNCj4gaW5kZXggMzdiNmZhNzQ2NjYyMC4uNGFkYzBiMmYxMmYxZSAxMDA2NDQNCj4gLS0t
IGEvZHJpdmVycy9udm1lL2hvc3QvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvbnZtZS9ob3N0
L2NvcmUuYw0KPiBAQCAtMjI0NSwyNSArMjI0NSw4IEBAIGludCBudm1lX2VuYWJsZV9jdHJs
KHN0cnVjdCBudm1lX2N0cmwgKmN0cmwpDQo+ICAgCWVsc2UNCj4gICAJCWN0cmwtPmN0cmxf
Y29uZmlnID0gTlZNRV9DQ19DU1NfTlZNOw0KPiAgIA0KPiAtCWlmIChjdHJsLT5jYXAgJiBO
Vk1FX0NBUF9DUk1TX0NSV01TKSB7DQo+IC0JCXUzMiBjcnRvOw0KPiAtDQo+IC0JCXJldCA9
IGN0cmwtPm9wcy0+cmVnX3JlYWQzMihjdHJsLCBOVk1FX1JFR19DUlRPLCAmY3J0byk7DQo+
IC0JCWlmIChyZXQpIHsNCj4gLQkJCWRldl9lcnIoY3RybC0+ZGV2aWNlLCAiUmVhZGluZyBD
UlRPIGZhaWxlZCAoJWQpXG4iLA0KPiAtCQkJCXJldCk7DQo+IC0JCQlyZXR1cm4gcmV0Ow0K
PiAtCQl9DQo+IC0NCj4gLQkJaWYgKGN0cmwtPmNhcCAmIE5WTUVfQ0FQX0NSTVNfQ1JJTVMp
IHsNCj4gLQkJCWN0cmwtPmN0cmxfY29uZmlnIHw9IE5WTUVfQ0NfQ1JJTUU7DQo+IC0JCQl0
aW1lb3V0ID0gTlZNRV9DUlRPX0NSSU1UKGNydG8pOw0KPiAtCQl9IGVsc2Ugew0KPiAtCQkJ
dGltZW91dCA9IE5WTUVfQ1JUT19DUldNVChjcnRvKTsNCj4gLQkJfQ0KPiAtCX0gZWxzZSB7
DQo+IC0JCXRpbWVvdXQgPSBOVk1FX0NBUF9USU1FT1VUKGN0cmwtPmNhcCk7DQo+IC0JfQ0K
PiArCWlmIChjdHJsLT5jYXAgJiBOVk1FX0NBUF9DUk1TX0NSV01TICYmIGN0cmwtPmNhcCAm
IE5WTUVfQ0FQX0NSTVNfQ1JJTVMpDQo+ICsJCWN0cmwtPmN0cmxfY29uZmlnIHw9IE5WTUVf
Q0NfQ1JJTUU7DQo+ICAgDQo+ICAgCWN0cmwtPmN0cmxfY29uZmlnIHw9IChOVk1FX0NUUkxf
UEFHRV9TSElGVCAtIDEyKSA8PCBOVk1FX0NDX01QU19TSElGVDsNCj4gICAJY3RybC0+Y3Ry
bF9jb25maWcgfD0gTlZNRV9DQ19BTVNfUlIgfCBOVk1FX0NDX1NITl9OT05FOw0KPiBAQCAt
MjI3Nyw2ICsyMjYwLDMzIEBAIGludCBudm1lX2VuYWJsZV9jdHJsKHN0cnVjdCBudm1lX2N0
cmwgKmN0cmwpDQo+ICAgCWlmIChyZXQpDQo+ICAgCQlyZXR1cm4gcmV0Ow0KPiAgIA0KPiAr
CS8qIENBUCB2YWx1ZSBtYXkgY2hhbmdlIGFmdGVyIGluaXRpYWwgQ0Mgd3JpdGUgKi8NCj4g
KwlyZXQgPSBjdHJsLT5vcHMtPnJlZ19yZWFkNjQoY3RybCwgTlZNRV9SRUdfQ0FQLCAmY3Ry
bC0+Y2FwKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJdGlt
ZW91dCA9IE5WTUVfQ0FQX1RJTUVPVVQoY3RybC0+Y2FwKTsNCj4gKwlpZiAoY3RybC0+Y2Fw
ICYgTlZNRV9DQVBfQ1JNU19DUldNUykgew0KPiArCQl1MzIgY3J0bzsNCj4gKw0KPiArCQly
ZXQgPSBjdHJsLT5vcHMtPnJlZ19yZWFkMzIoY3RybCwgTlZNRV9SRUdfQ1JUTywgJmNydG8p
Ow0KPiArCQlpZiAocmV0KSB7DQo+ICsJCQlkZXZfZXJyKGN0cmwtPmRldmljZSwgIlJlYWRp
bmcgQ1JUTyBmYWlsZWQgKCVkKVxuIiwNCj4gKwkJCQlyZXQpOw0KPiArCQkJcmV0dXJuIHJl
dDsNCj4gKwkJfQ0KPiArDQo+ICsJCS8qDQo+ICsJCSAqIENSVE8gc2hvdWxkIGFsd2F5cyBi
ZSBncmVhdGVyIG9yIGVxdWFsIHRvIENBUC5UTywgYnV0IHNvbWUNCj4gKwkJICogZGV2aWNl
cyBhcmUga25vd24gdG8gZ2V0IHRoaXMgd3JvbmcuIFVzZSB0aGUgbGFyZ2VyIG9mIHRoZQ0K
PiArCQkgKiB0d28gdmFsdWVzLg0KPiArCQkgKi8NCj4gKwkJaWYgKGN0cmwtPmN0cmxfY29u
ZmlnICYgTlZNRV9DQ19DUklNRSkNCj4gKwkJCXRpbWVvdXQgPSBtYXgodGltZW91dCwgTlZN
RV9DUlRPX0NSSU1UKGNydG8pKTsNCj4gKwkJZWxzZQ0KPiArCQkJdGltZW91dCA9IG1heCh0
aW1lb3V0LCBOVk1FX0NSVE9fQ1JXTVQoY3J0bykpOw0KPiArCX0NCj4gKw0KPiAgIAljdHJs
LT5jdHJsX2NvbmZpZyB8PSBOVk1FX0NDX0VOQUJMRTsNCj4gICAJcmV0ID0gY3RybC0+b3Bz
LT5yZWdfd3JpdGUzMihjdHJsLCBOVk1FX1JFR19DQywgY3RybC0+Y3RybF9jb25maWcpOw0K
PiAgIAlpZiAocmV0KQ0KDQpUaGFua3MgZm9yIGdldHRpbmcgaW50byB0aGUgZGV0YWlscy4g
VGhpcyBsb29rcyBncmVhdCB0byBtZS4NCg0KSSBoYXZlIGFsc28gdHJpZWQgaXQgb24gdG9w
IG9mIDYuNS4yIGtlcm5lbCBhbmQgdmVyaWZpZWQgdGhhdCBpdCB3b3JrcyANCmFzIGV4cGVj
dGVkLg0KDQotLSANClJlZ2FyZHMsDQpGZWxpeCBZYW4NCg0K

--------------oVpTfcvphLmb39J1F7QwljMG--

--------------H841eNckoKp4go5G01Qhb02U
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmUAtukFAwAAAAAACgkQeGxj8zDXy5Ln
hw//VkXgwFeUauQIO1ZMwcmUkeSAvP59qSJdp0kE5VVkM1XnTKKSaAqc+FfJLyo5F7CT7XmvIabG
hGtWxhKdb1CLFOtwlX60T3qh9NqlCOp4El1jrJt0/n9gu6upgzCCklcKi88khopl07f5hQRV2P25
17TEqVexYCoF7Ae5LZWQufp53mjDPW2BjCWbIAzuJaHAdv65EMCj1siebC1uCnYDIUwv1adXLc2z
pwZVB5LaoXVE5gTc9HBcs/TMZCpUvasY4zgw2j96fa85NG6TYrb6ASEt2ZlSmomGLT2OofXlU9VE
mKfyqWB42rn9D5eS+BS0ElNDFHzJCCQf/+seLfmtSyrhQQFoEkHdDyJF5TgA1TvWrnodxdC/vAde
NW8kXm6eyO/o6CniRwQVPftHpLieiBB/RV9PayD68l98N8qx7xaxr0FBtr87N7xXgc7sZYDuquo+
Rxgs6ETvPi2/28qKW9au6f701fjvk0nsSyyq4OyNQ1peswnzcXCWCrVKtgPPjfn1EwkvECfobXdc
8BMMSX7ZJfVhllgyaQwff28nFALKVI3PNtAavZK95vD2dsnWXwGlwY3C3wXoykdwLF0TaYoJUXhu
Q5gVmbZ3JKjmk1k6QY+GW+Csfvi8SqIwuzeuoQuDh0dgv2au2JNkvIE5B+wdRsSKOY4UNJSbD2Bq
DkA=
=H4hB
-----END PGP SIGNATURE-----

--------------H841eNckoKp4go5G01Qhb02U--
