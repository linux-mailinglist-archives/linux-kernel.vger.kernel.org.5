Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7A8769342
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjGaKiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjGaKiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:38:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E11CE46;
        Mon, 31 Jul 2023 03:38:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36VAbtPN026793;
        Mon, 31 Jul 2023 05:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1690799875;
        bh=rdoeLA+LTIYPBmilKunFS3ami5rOW1Fjwprp4Stzh3Y=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hKs8tPVWeT29T8jE6mxgRCZ2ozJVHDov909fgN71sLVkstOUYlk5lDEjLL6VhqmHO
         q39uHQm5VEBxmxnx2N3mEw59s49bVNB6Mom+d04vD00kWUzGYQ2JgtrNosj3+wRku7
         bU6Tnid7eSuVfzm3DC7ula8tKv0JWaYxeyLIm8eY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36VAbtu9091983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jul 2023 05:37:55 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 31
 Jul 2023 05:37:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 31 Jul 2023 05:37:55 -0500
Received: from [172.24.227.147] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36VAbquS013273;
        Mon, 31 Jul 2023 05:37:53 -0500
Message-ID: <857a5ea2-1440-58ee-3a42-c16a1c2f3849@ti.com>
Date:   Mon, 31 Jul 2023 16:07:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] clk: keystone: syscon-clk: Fix audio refclk
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Francesco Dolcini <francesco.dolcini@toradex.com>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
References: <20230728222639.110409-1-francesco@dolcini.it>
From:   Jai Luthra <j-luthra@ti.com>
In-Reply-To: <20230728222639.110409-1-francesco@dolcini.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature";
        boundary="------------m59ae0fcjb63YEhw5SrE3W7l"
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------m59ae0fcjb63YEhw5SrE3W7l
Content-Type: multipart/mixed; boundary="------------22PrGEPBb6x1zzLM2CkfgzBd";
 protected-headers="v1"
From: Jai Luthra <j-luthra@ti.com>
To: Francesco Dolcini <francesco@dolcini.it>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Message-ID: <857a5ea2-1440-58ee-3a42-c16a1c2f3849@ti.com>
Subject: Re: [PATCH v1] clk: keystone: syscon-clk: Fix audio refclk
References: <20230728222639.110409-1-francesco@dolcini.it>
In-Reply-To: <20230728222639.110409-1-francesco@dolcini.it>

--------------22PrGEPBb6x1zzLM2CkfgzBd
Content-Type: multipart/mixed; boundary="------------UzDifYG6NHzFC1HNlw6SqpfU"

--------------UzDifYG6NHzFC1HNlw6SqpfU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRnJhbmNlc2NvLA0KDQpPbiAyOS8wNy8yMyAwMzo1NiwgRnJhbmNlc2NvIERvbGNpbmkg
d3JvdGU6DQo+IEZyb206IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0
b3JhZGV4LmNvbT4NCj4gDQo+IEF1ZGlvIFJFRkNMSydzIGFyZSBub3Qgd29ya2luZyBjb3Jy
ZWN0bHksIHRyeWluZyB0byB1c2UgdGhlbSBsZWFkIHRvIHRoZQ0KPiBmb2xsb3dpbmcgZXJy
b3JzOg0KPiANCj4gWyAgICA2LjU3NTI3N10gb2ZfY2xrX2h3X29uZWNlbGxfZ2V0OiBpbnZh
bGlkIGluZGV4IDQyOTQ5MzQ1MjgNCj4gWyAgICA2LjU4MTUxNV0gd204OTA0IDEtMDAxYTog
RmFpbGVkIHRvIGdldCBNQ0xLDQo+IFsgICAgNi41ODYyOTBdIHdtODkwNDogcHJvYmUgb2Yg
MS0wMDFhIGZhaWxlZCB3aXRoIGVycm9yIC0yDQo+IA0KPiBUaGUgaXNzdWUgaXMgdGhhdCBB
dWRpbyBSRUZDTEsgaGFzICNjbG9jay1jZWxscyA9IDAgWzFdLCB3aGlsZSB0aGUgZHJpdmVy
DQo+IGlzIHJlZ2lzdGVyaW5nIHRob3NlIGNsb2NrcyBhc3N1bWluZyB0aGV5IGhhdmUgb25l
IGNlbGxzLiBGaXggdGhpcyBieQ0KPiByZWdpc3RlcmluZyB0aGUgY2xvY2sgd2l0aCBvZl9j
bGtfaHdfc2ltcGxlX2dldCgpIHdoZW4gdGhlcmUgaXMgb25seSBvbmUNCj4gaW5zdGFuY2Us
IGUuZy4gImF1ZGlvX3JlZmNsayIuDQoNCkdvb2QgY2F0Y2gsIEkgZGlkbid0IGVuY291bnRl
ciB0aGUgZG1lc2cgZXJyb3IgZHVyaW5nIG15IHRlc3RzIC0gDQpwcm9iYWJseSBiZWNhdXNl
IG9mIHplcm8taW5pdGlhbGl6ZWQgc3RydWN0cyBzbyBpZHggPSAwLg0KDQo+IA0KPiBbMV0g
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nsb2NrL3RpLGFtNjItYXVkaW8t
cmVmY2xrLnlhbWwNCj4gDQo+IEZpeGVzOiA2YWNhYjk2ZWUzMzcgKCJjbGs6IGtleXN0b25l
OiBzeXNjb24tY2xrOiBBZGQgc3VwcG9ydCBmb3IgYXVkaW8gcmVmY2xrIikNCj4gU2lnbmVk
LW9mZi1ieTogRnJhbmNlc2NvIERvbGNpbmkgPGZyYW5jZXNjby5kb2xjaW5pQHRvcmFkZXgu
Y29tPg0KDQpSZXZpZXdlZC1ieTogSmFpIEx1dGhyYSA8ai1sdXRocmFAdGkuY29tPg0KDQo+
IC0tLQ0KPiAgIGRyaXZlcnMvY2xrL2tleXN0b25lL3N5c2Nvbi1jbGsuYyB8IDggKysrKysr
LS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2tleXN0b25lL3N5c2Nvbi1jbGsu
YyBiL2RyaXZlcnMvY2xrL2tleXN0b25lL3N5c2Nvbi1jbGsuYw0KPiBpbmRleCBkMzNmNzQx
MTk0ODguLjZiMzM1Y2U1Y2MyNiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsva2V5c3Rv
bmUvc3lzY29uLWNsay5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2tleXN0b25lL3N5c2Nvbi1j
bGsuYw0KPiBAQCAtMTUxLDggKzE1MSwxMiBAQCBzdGF0aWMgaW50IHRpX3N5c2Nvbl9nYXRl
X2Nsa19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAkJCQkgZGF0
YVtpXS5uYW1lKTsNCj4gICAJfQ0KPiAgIA0KPiAtCXJldHVybiBkZXZtX29mX2Nsa19hZGRf
aHdfcHJvdmlkZXIoZGV2LCBvZl9jbGtfaHdfb25lY2VsbF9nZXQsDQo+IC0JCQkJCSAgIGh3
X2RhdGEpOw0KPiArCWlmIChudW1fY2xrcyA9PSAxKQ0KPiArCQlyZXR1cm4gZGV2bV9vZl9j
bGtfYWRkX2h3X3Byb3ZpZGVyKGRldiwgb2ZfY2xrX2h3X3NpbXBsZV9nZXQsDQo+ICsJCQkJ
CQkgICBod19kYXRhLT5od3NbMF0pOw0KPiArCWVsc2UNCj4gKwkJcmV0dXJuIGRldm1fb2Zf
Y2xrX2FkZF9od19wcm92aWRlcihkZXYsIG9mX2Nsa19od19vbmVjZWxsX2dldCwNCj4gKwkJ
CQkJCSAgIGh3X2RhdGEpOw0KPiAgIH0NCj4gICANCj4gICAjZGVmaW5lIFRJX1NZU0NPTl9D
TEtfR0FURShfbmFtZSwgX29mZnNldCwgX2JpdF9pZHgpCVwNCg0KLS0gDQpUaGFua3MsDQpK
YWkNCg0KR1BHIEZpbmdlcnByaW50OiA0REUwIEQ4MTggRTVENSA3NUU4IEQ0NUEgQUZDNSA0
M0RFIDkxRjkgMjQ5QSA3MTQ1DQo=
--------------UzDifYG6NHzFC1HNlw6SqpfU
Content-Type: application/pgp-keys; name="OpenPGP_0x43DE91F9249A7145.asc"
Content-Disposition: attachment; filename="OpenPGP_0x43DE91F9249A7145.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFmEXR8BEADWOeZ1xPbKjjrtEUIulq+07p4cYA5PXpYvG1k9w34Mcvr7B6Mu
OmGAM613yt+YcmYgmy+mFntn+HRirxclmDsqCekekRHkCIxzfweAlE611/yf3Dp+
QtJxFx3nJ/2ZTEzWn8boJOF4mb+GKKUUiDXQrYnuRMhf7/IqDYW4JH1u8f2dfgkh
onMq5KyOs+7bQJMKQgIb62qWeWwZJwQWYqpa8C+OBvnyobhhGn419jRmmOXKoicQ
6pnLYCpTDZI7XFryCBLy9+MhGXx+EulFXcgKwDZb+CapCJDc+6itUVao2bdd4Q63
Bdv+j3KE5gHS8rBgvEK0b85lwblPHGWmyG3Der57Opp1/JDeRlpaLplpgiTxodTj
QnJ3LMBYSlsEXONuMSc8RrkW4e59kRKmYUhoPDH42bNwq4R6M/yBdfEALC2YeBZ5
u1pfBwA11tcgwUWjlG7awCoSLFGU4i6wQVr8S5mEdsYfweMCcHkKUJOcoDyF9BHa
EhceIAQuq15d5qBjvAj7c8wkGV8kAl7dQI5iSo+ZWsCAv/2Xxmzfy9mXO+UFvyWT
hXnilMFwab4E8sF7aPE/9gdwd3OPDgtffgyhPfJtj/4E4/A/JmNb1N2f2mWRD9Bs
V4Z88nyXJv7B6u43RRVA5voIs1aQTFKXfcbL76tZCT6TiskTmTst9SXK5wARAQAB
zRxKYWkgTHV0aHJhIDxtZUBqYWlsdXRocmEuaW4+wsGWBBMBCABAAhsDBwsJCAcD
AgEGFQgCCQoLBBYCAwECHgECF4AWIQRN4NgY5dV16NRar8VD3pH5JJpxRQUCY5Sn
aQUJD7PkyQAKCRBD3pH5JJpxRfW4EADM6WKT14xoTsWkIh2uJ3F6G0ombZuTLKln
ub4fLNoLsTgRS2fCv8xeXfUQ4NzC+KzgbCF1IDU94zWDJrV1HqAVD5xoqbUAX2nu
nSuv676pqGzaIjvOEb6ZuQuLZfvrtJtz6Fax8moD9/jvN14LYHUyrvv7oVmj97mP
p2oqvMMaBCc2KSZIoH4TUtIi44ZzcgYgo7hz3B71E5ylPRqeCwyVn4IPyHo0bsKL
kAe+8DPZ0oDOfJkbfRoscXnLeT/YUiqLkr4QG8JlZuRC1DmyyiZCNk9vOKLFLN/h
c1xZPEA3Kv3QUmhfubWLzEFbqiJpMR2Z70P4WIznExYDuUsshwfWdlR68O8zd81r
3Rr7Pl0B0lhab0N0W32f3IraeUF4no2mKjU2KEOWpEIo6SAYnLt1KZR4FPMb/ntn
ytFBgf7gXwT7TSq0r1ziY2C/OdMrR/5OVuzoDHkLnF7CBc7BrnnWIB6bE1lO8AtW
zfsWavF0SG52CW/SWOOsTOfgP5R2Q2PI0/JO8185G1QzHEVPLQHRdSBRaEXMBOi6
xBhFUduQYze2h/rAAc1tpUZSj+Vuwqp+g2c2xsaEHwU4vzA93CwEaRFARAaGIz7d
B+lvgITkQGDkAtllFV6jPAlNWdO6hp3L1cA3oa2rECzWhKfBEGYjMK2elZsRwnIe
UIEOi7QWMM0qSmFpIEx1dGhyYSAoSUlJVC1EKSA8amFpMTUwNDNAaWlpdGQuYWMu
aW4+wsGWBBMBCABAAhsDBwsJCAcDAgEGFQgCCQoLBBYCAwECHgECF4AWIQRN4NgY
5dV16NRar8VD3pH5JJpxRQUCY5SnaAUJD7PkyQAKCRBD3pH5JJpxRS+wEACFWMTE
w4JxpUkiG9Qx5Mse8Jayr3Eot5goq5SHAxvU9XhloSvhvYwvtYTwgtcc0q2tNWdr
jANJO7EyibWo2CDmJwTbFPzd4NwhZHikuFyVjiY7hk1Le8OSB0gEs5LcBqRGNX1L
vEJbuuwT2YiEK1e8DyD3LtoG4Rj4gMVByNRDGMsACq9N2NzgHsaGS1p1JGmu9p82
8Ys10LVovmO0ol4WX/YIulfehOrRSANEoBmm1Wod4f0wRt9dLTyDije9kitT/pj7
RpA4Hj4HywZCIpau3YEduw4Yc8p8h4SKMRX6aYsXrJd5qyTFQXs0RQ5fPLHVpqiA
hQtcXc3Sux6L2v/yyBFF5QWyEgG27Fy1IIgKSXPOBizOwl6nKNDFIFlGqBKgHBjJ
SyB12krU46AEF5JWFypvqbTIJfRbSHrD1EjJG+OF8YiascWvWorLFpfLduHmR+qj
sPkAkDZjPJXSl4QCUN1p6AZzVSZeiPo1tqkSrFhcBUoT5zhl4d5SEtH1KiZ6bomg
sjLw5UsFUXT0NoZ4qKQ9bczJWXloBrK1N3A5GKTwDWno0UZzj83vC1dwdUMQbbYD
U+x+IM+cdYCLQ/8OQ4RSj99UtH+UZTyGwvI7x9xWkdsj7H5IinipEk77KzZg3q3D
Oy8kJvuU5dN/zy/eD20LESTYIkPtghYE6TZQ+s0cSmFpIEx1dGhyYSA8ai1sdXRo
cmFAdGkuY29tPsLBlAQTAQgAPhYhBE3g2Bjl1XXo1FqvxUPekfkkmnFFBQJjlKj2
AhsDBQkPs+TJBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEEPekfkkmnFFLOIP
/imtgbWNmbxFhUR1Ed8QUDE2R+RVFqxPNhWuzLcdA+CL75HU/AgDItd9Qz0gtrzc
/LmG1lKST3zUmLLMGf1iq2qXY56A/2hFKT3bOK3UCJeJKuAL1QWTTF2xmjDvG+xR
pJWkhhd4qfiYT13s8rImGg/UH3NJZ9wltMmWusaI2L8i0xvdohdh4/jaS4X9tMZg
YUUS1tYLwY08nGDfp2UhXsOLjR9d0fqx9258+cbEGx7p1NOAUNzuWtxYX8MkW4nR
kru+2DxIxQz7hUs44PAZVniBbbJq5UPAXENZaN6qJz//fpszrFNdRJwX473XuRh6
0cLPdIi3kCyhzYD7M6GqWtuyHLiMANIvRHOv5jXN9I8Wxva2TAxfUdwcp7Px3jSJ
L2+2Dao9ZiivRkz+6qxwEWmURYYnz0RQ2nKh2JX4VShebSBFJnaMISeSgtX2R41r
11dT6jr96Pa0kxWvRa3N8b8kIgDy8xmUaa16fIGxU2YeBdurD/GyCToKtUQlKi6S
JEmxSg4p+7zMYMeMSNDW5hnS/39xjuAFQRptRuq2in2gNdh69tw52/QOaEEyT2jg
4tcvqxMrDcD94QSBsgCQUJg/25CvwsTfdqMHZmUhvbn/bMVpG6/8uVVCP885p/UE
EVsCL4/oVUfvxKwXOIhlFx3C37PqSkRWZRdKjDL5x852zsFNBFmEXR8BEADEQP/T
snVgpZjWS3VUZhchI186W+roygn6x1HkcGG5K5/qbTFaXFOGTeYvJNGLkDLLzL+p
hGSXIzw7TzLXi9M/mTBzfPBUblXdWW5abN3g9gRpyp+Zc0YDUzRf2mK2a4zC2zKZ
oBGjXj7qY4di6qZnFaQRdSYsc2pbnHVUeOwVNPqdfvqievX+EYGATNV49MhVFBg1
VLsrYB+nasMriDLOCO0+PTCfPoBnJGYYbaEU1g+uP5NdJ6ylFJq6Ku+vQWtMxpMG
wBpdFv1QfksFBKRR9fFepHpgI+TdATQ955j62uD6UTj27DT4jJzGsMcbrTjy05xl
TSltViwlP2amlIm7P8wr1eCe6D1bvjIcSazig7jLJ4EnXHXYXky8AoJi11Mp+tUJ
LbkEP/m9HH4xdQUJwcqAzIJFy5zhH2eiXQsn9dwAegs1FsB1V1FZ3OuZjRg5oypl
u/AQOmh4Y8kLNbkZLeN/fVfqX+c5uH+Zfrq6xjJ2kke9RSwvtfuw6X2KVZXGkQNF
3IVcgnMcmsXk+8SbgpvT1Tus8zFnYaQphDgGozzoHkX+QUxO5KtPJ2EhgBLng1oE
D3VyxtsvtKHSVqe/g38umXPSbdg66ya8tjQ1buTSRHHyZwJNPstfO0M2M1URPTl+
2s8Dd6L57aqAqMRDbCqDAtwLuMsFRaXr5FNBzQARAQABwsF8BBgBCAAmAhsMFiEE
TeDYGOXVdejUWq/FQ96R+SSacUUFAmOUp3MFCQ+z5NQACgkQQ96R+SSacUXKEQ/+
JzIgWraYytdSoCMPGu2jc3IMmlgjuPEZ9Yx45g9pNNzAJ6CpZnVckkABA3B1SPBM
wBAn1SD6sAWQj9BYuEiijdWrvCUrtvpSjTolaV0gnYMVlWVuDfOP96yDvbChQ9Zl
B1PDeHzXAqITVrDcxSxD9MQ0VVYRXMG2GISSLHEfbEYl6WTRwBWKPhdgoEYOgwxK
ZsuuQ2+1sYA+RWZK2Rcdrg3HUqD07bsQLsaCzFBUEuvYh2p5ruwHBZ9yvUnRkQvS
zJvuztytP+LcxlQkPCtfIW45Om1FXpaZ4ByfbJWowcRGWqZ9eMCnwAOXXr9XXJvm
AvpPWhLx+Oe/pI0YcJZbEOzNwFuRFaNXaKcE3TfsFzlpUk9C7s5FULdKBlOhTtLc
wsZHzHdiau5AsVbsfjRo6eBcpaqlDkLOB/ndCu7sNepkXZgRZoZw4gws2R0tRFPk
s6AhqNYLqtCJNmi1Bq9tiv/qSPil05Kf2MpJnT5+R/GOVoMlEv/kmaymPmO6zcdf
SYOD3zT4n26smn4GonhmrYtOaE2CqDsneFFaOkgbX3T4tf6ytww8yW4FMrpONSUQ
12FZkOSw4OhisES68sDXWYgleBBTLw4o+YxtOOIZPFC/2egPhufVUhruk9sbhMJQ
Gawd22QfSCwCklKVTI9H+O5QG1i1RF+yvFT/eBHoaMM=3D
=3Ded/y
-----END PGP PUBLIC KEY BLOCK-----

--------------UzDifYG6NHzFC1HNlw6SqpfU--

--------------22PrGEPBb6x1zzLM2CkfgzBd--

--------------m59ae0fcjb63YEhw5SrE3W7l
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEETeDYGOXVdejUWq/FQ96R+SSacUUFAmTHjwAACgkQQ96R+SSa
cUWJQw//SMoRnoLh1elCqNcE6PwCQnY1yUonSzDav3Y3gSwtqpBXHoTt2/r6bAhL
/sN75h+qNl4NaxKQ5Rtv0tfUD4QOXfTeJcrYFLn+3gT9flfxRWMd0p8nOxI3ZSth
mTEopon1jZVhCqBy4wHkTjWqzg9qzt9CY7YrA6KNMzmYriASwMLm+sulc2tY/QdG
8CpmV00gW7pCdK7ktU792X+FgNz15KkVIcSB9atvR+VmYQ8tUuOd3K3zTWwn1rWd
+5k+3QxiBpeBwaksz8MOiDeELCJcLd7usapb4qvqq0P2pJnwKtQSqI1MvBCjf6OH
kAtMNJ2CVtm5cE80qi8hOS3ptppLbr4sjIVJ424hE9UKMagr26CNhViiAOYI1ps5
1K1Q2rBJa/8JcXCrVhk4/4oiY18a2KscQynHwtFc3WDn3ydDaJOJXmuA1Vh7Wb+W
d+XkaNmU+meygdGDe9pNhFoJ8gUMsPSvmOP3jCzKQ9EhK4bzvAXknQNPXMTqpazy
b2/7mkXF1C0xvePdwZ4E1pzlDLhyk45BM2H/snXvNfozAZX+AlOd3LIsjH1+y/is
36trJjIhvcZsKJbSWXwJNWHqOsW60tHfnWuylBSHLWv/Hvto3YqNPvC1fOr7gb8z
WFETOD4LT4w3meEo+r6QPL1yw/efSYWJr20vc1VjLAtmvEKV388=
=NZ/D
-----END PGP SIGNATURE-----

--------------m59ae0fcjb63YEhw5SrE3W7l--
