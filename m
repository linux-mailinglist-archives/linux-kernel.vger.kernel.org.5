Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A97797B24
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 20:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343496AbjIGSFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 14:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343556AbjIGSFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 14:05:09 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69EBA1FD5;
        Thu,  7 Sep 2023 11:04:44 -0700 (PDT)
Message-ID: <64c88fce-9745-4dfa-be65-75994b05817f@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694109011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=zeOCI4aINKlUle4Z4caiMqwno7CVtpizI5fPp9sr6Is=;
        b=QE3/5KpHC4ojsekfrzjhkIdM7mLk9ilq9G8r3IlTF4bxfjh1OpS+VHNT7hw+xQ0pvUDQAn
        pr+Pnhjf/7llofa/8VNhQCyMRDCHNFt+5Zj94dePR1gRIxERExmjUW6YEJr0Jsf3gqC7iH
        ASK3zKmFjPU5MOlA5kYSRBKV8p6DasdR0EuYOWMAWRyElF0jRy4mREcGmA20gVvNiPD5Cu
        II2a7xbGEz9hKaAFBGIbqqa1CnHuVcIebkv3LqUQCjmsHHkLNLI3wohwr/+ZOjWOjZpXWp
        xG+lVDCQZdnUorDlJR05tymGBnmkG+kz8zex2bX85CN3kZ6ySKlSZSc94A9FsWvTroBa1B
        6rQFqzg68PUgsNBAM1gR/o1HMBZkJicLkLSIrApYSt+9ZMgfWvqO4RkOw/lwTHv37H4Znl
        AEQJTsY3Qz+LQuOL6nq+mxHSbTRV8Fushy9EqFF5lQYixi2F7ln3edReitoVpADXZGmnQT
        E8rs8XBbkHNeF+tFCF96wU4Cr/crm0MOAl7hB82AMLEYi4SxpwgO+ZRmcagwZUSSYm8jQW
        b8p42vmGzZJGdYzQEzzIX+exDGHlwlb3rEkdnxhZJT5aBpdo/Qp5THIKtO6Cj6LyVn/MrQ
        ZYYLIivAhkelR8I80SMvCYBkc8BiA24oUzfVGTkWgkpIFgEPL+2bc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694109011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=zeOCI4aINKlUle4Z4caiMqwno7CVtpizI5fPp9sr6Is=;
        b=06OBVLGnaG2mqpaU1CxyjlruJJVmVI6UTEEypHu1CHoTgKU8fxsszBZMmefEi6GlLZztBS
        5dl1TL0tUy//t5CA==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date:   Thu, 7 Sep 2023 20:50:06 +0300
MIME-Version: 1.0
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Claudio Sampaio <patola@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Linux Stable <stable@vger.kernel.org>
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Content-Language: en-US-large
From:   Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ajTduOLHYKtpl0ajI1PCNmk0"
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
--------------ajTduOLHYKtpl0ajI1PCNmk0
Content-Type: multipart/mixed; boundary="------------Ofy8W1ZH5w46U0oq8rGhaOMo";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Claudio Sampaio <patola@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions <regressions@lists.linux.dev>,
 Linux NVMe <linux-nvme@lists.infradead.org>,
 Linux Stable <stable@vger.kernel.org>
Message-ID: <64c88fce-9745-4dfa-be65-75994b05817f@archlinux.org>
Subject: Re: Fwd: Lexar NM790 SSDs are not recognized anymore after 6.1.50 LTS
References: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>
In-Reply-To: <8af186ba-5f64-2102-8f9c-3969b0906893@gmail.com>

--------------Ofy8W1ZH5w46U0oq8rGhaOMo
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS80LzIzIDE0OjA3LCBCYWdhcyBTYW5qYXlhIHdyb3RlOg0KPiBIaSwNCj4gDQo+IEkg
bm90aWNlIGEgcmVncmVzc2lvbiByZXBvcnQgb24gQnVnemlsbGEgWzFdLiBRdW90aW5nIGZy
b20gaXQ6DQo+IA0KPj4gSSBib3VnaHQgYSBuZXcgNCBUQiBMZXhhciBOTTc5MCBhbmQgSSB3
YXMgdXNpbmcga2VybmVsIDYuMy4xMyBhdCB0aGUgdGltZS4gSXQgd2Fzbid0IHJlY29nbml6
ZWQsIHdpdGggdGhlc2UgbWVzc2FnZXMgaW4gZG1lc2c6DQo+Pg0KPj4gWyAzNTguOTUwMTQ3
XSBudm1lIG52bWUwOiBwY2kgZnVuY3Rpb24gMDAwMDowNjowMC4wDQo+PiBbIDM1OC45NTgz
MjddIG52bWUgbnZtZTA6IERldmljZSBub3QgcmVhZHk7IGFib3J0aW5nIGluaXRpYWxpc2F0
aW9uLCBDU1RTPTB4MA0KDQpIaSwNCg0KVGhpcyBsb29rcyB2ZXJ5IG11Y2ggdGhlIHNhbWUg
YXMgdGhlIG90aGVyIE1BWElPIE1BUDE2MDIgaXNzdWUgbWVudGlvbmVkIA0KaW46IA0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC83Y2Q2OTNkZC1hNmQ3LTRhYWItYWVmMC03NmE4
MzY2Y2VlZTZAYXJjaGxpbnV4Lm9yZy8gDQphbmQgTGV4YXIgTk03OTAgaXMgaW5kZWVkIGFs
c28gdXNpbmcgdGhlIHNhbWUgY29udHJvbGxlci4NCg0KQW5kIGFzIEkgaGF2ZSBtZW50aW9u
ZWQgdGhlcmUsIDYuMSBMVFMga2VybmVscyB3b3JrIHdpdGhvdXQgYSBwcm9ibGVtIA0KYmVj
YXVzZSB0aGVyZSBhcmUgc29tZSBkaWZmZXJlbmNlcyBhdCBjYWxjdWxhdGluZyB0aGUgcmVz
dWx0aW5nIHRpbWVvdXQgDQp2YWx1ZS4gTGF0ZXN0IGtlcm5lbHMgaW5jbHVkaW5nIHRoZSA2
LjUueCBicmFuY2ggbWFrZXMgdGhlIGVuZGluZyByZXN1bHQgDQp6ZXJvIGFuZCBicmVha3Mg
YWxsIDQgVGlCIFNTRHMgd2l0aCB0aGlzIGNvbnRyb2xsZXIgYXMgZmFyIGFzIEkga25vdy4N
Cg0KLS0gDQpSZWdhcmRzLA0KRmVsaXggWWFuDQoNCg==

--------------Ofy8W1ZH5w46U0oq8rGhaOMo--

--------------ajTduOLHYKtpl0ajI1PCNmk0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmT6DU4FAwAAAAAACgkQeGxj8zDXy5Kg
wA/+KUKz9G1U2JqA2jAoiwr4SE+IHiFlRkcjA0dtR/u01rfKnPMPBqttkJjEsD8NEoSE3+c7OgS5
0hlvx6Hb2UmsUI29H7aZLmj6lInQVbzs0ZpCODWhttQY9Ao1lGf1HKevLJ/HbvuaO2uiJ9d7qDYK
7f4gkA2TLhrbLakrsdWQkPXFkxFzXuFT/QeUM8C2RQ2HMXou/k2qEuaJu171NPb+UAIvbPSmb9sK
BI7HY/Ym0JvHLxi7wQdsmYKjo4Y3RC8k5fhPXNVuNMMt+vzrnWmSOYmCyiBTfYfRvvmFKB6sB9kK
nbyoNSDmUh4pd/rmp4x6Ybs5XA+XOfOJzSTYHLlJCxVImHrDSGcAUHMSbQ0tuNzwuL4PSHkushmn
HtJwZa09EoSPINL4xNdFsICcPSQOTyXYxf6afkx+mmMKuexB3yAxB/Kvs2cXOymh0LldcDJdJ3Gr
t8dn/8AwIj/qrPwB2GKFqn9IonH3Cb8vsgx8J69D6/qI3r4DMzPz3gWGJSXzM73gu2aLCleo5eU5
kLUTLDkcMMC8k+gZksGwb761M0UNJiBn512B79gbwVVE/xzv8G0c8pLPgAeowPv2Kk0FRRtZaAgO
sFoAGXFv8pUYndnXrLh/hU3lPF8AlRt4GuMTLPfRtlMJnwCQkdTBWjQ4OPU1fX/eWN8f9FnD+QId
71k=
=nJc6
-----END PGP SIGNATURE-----

--------------ajTduOLHYKtpl0ajI1PCNmk0--
