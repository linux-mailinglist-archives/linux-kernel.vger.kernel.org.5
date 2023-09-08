Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55912798B24
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245367AbjIHRDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 13:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245284AbjIHRDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 13:03:21 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0DF199F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 10:03:16 -0700 (PDT)
Message-ID: <dee1e345-7df7-4ecb-b8f6-4828632429c6@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1694192594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=LXfimIk+p+DPjO+FnT78eZEGMiaUfwRetRIMYdvL4cE=;
        b=aQdqsE1ncZsp36yrUBhshJcVMlzr8gdhd1bdYfokf0iv8IlhLQqsQwvuH4DzSUQWysfFHH
        7QiulPJg5khjQn2sd221GrPXHbWdec33Ugb6jnRcqPMw0hjMIz4cQWzpNl4D2zTxGtPHMi
        UNoxKJcbL2xSB0LAgEU96Ajjy1NpflFAEjEjKPRi/kkzLuj1OfBRC03P4mUNrONJ0bO43E
        7TPfqDQOrgkJI0ZsQdNbK2OvNqZblmuuoVAmk/FUCWjmqNeY0bh06LSVDxB+hwJXt0uHnO
        xQqACfQGMft5cw9XBzVcNEcg9R5++gycXtvbVk/XI70cYMviFEKW/Y0rdcwL+A3Ru/2xvF
        QMVgt2B8DRsjabMliPnCTdkxR5hKs1T3TBr5RYFZCygCnZMeVGtiwRplVmDLRrCp1Epusm
        0CxVTLeBC3Q1jFZ88dKISIFq65tdD9eWDO+FhFHGmlVkQALStx2yZ/+Hp8yS3On2y8H5VN
        QIhrNztYeSZn/f6mV+pbGpeHA7UgL8onHSngE5IJqeItFjH2K5dexEnHsVyi2xN3oKVrww
        VwmfJzOtyghbCAspTmGzACH0sGx7ujAP3PG/bn5tFQmyqCZUZiwtoj7ZnhtsH+UYtXPTOL
        dhZl8Qi3d8NS9X7jq1prh/erANtOns83bQ4rwR+bTF+8B4mWmqj0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1694192594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=LXfimIk+p+DPjO+FnT78eZEGMiaUfwRetRIMYdvL4cE=;
        b=1w+7XZ9sJkrZEIcy0Z1uB+6nhl5ms96GRxAQTPCNX8JwPI+D6JmdeY1AD60jugNtgKmgJ1
        ptYKLlkSMrRfCaDA==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=felixonmars smtp.mailfrom=felixonmars@archlinux.org
Date:   Fri, 8 Sep 2023 20:03:08 +0300
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
Content-Language: en-US-large
To:     Keith Busch <kbusch@kernel.org>
Cc:     highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, xuwd1@hotmail.com
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZPtREsG8XGGEFgg4@kbusch-mbp.dhcp.thefacebook.com>
From:   Felix Yan <felixonmars@archlinux.org>
Autocrypt: addr=felixonmars@archlinux.org; keydata=
 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
In-Reply-To: <ZPtREsG8XGGEFgg4@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------SpT6E6sNJK7Qfln0t747BneH"
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
--------------SpT6E6sNJK7Qfln0t747BneH
Content-Type: multipart/mixed; boundary="------------jNtJ0WUzuKhb085q1FisWqZL";
 protected-headers="v1"
From: Felix Yan <felixonmars@archlinux.org>
To: Keith Busch <kbusch@kernel.org>
Cc: highenthalpyh@gmail.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, xuwd1@hotmail.com
Message-ID: <dee1e345-7df7-4ecb-b8f6-4828632429c6@archlinux.org>
Subject: Re: [PATCH] nvme-pci: ignore bogus CRTO according to NVME 2.0 spec
References: <20230908155442.31423-1-felixonmars@archlinux.org>
 <ZPtREsG8XGGEFgg4@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <ZPtREsG8XGGEFgg4@kbusch-mbp.dhcp.thefacebook.com>

--------------jNtJ0WUzuKhb085q1FisWqZL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gOS84LzIzIDE5OjUxLCBLZWl0aCBCdXNjaCB3cm90ZToNCj4gT24gRnJpLCBTZXAgMDgs
IDIwMjMgYXQgMDY6NTQ6NDJQTSArMDMwMCwgRmVsaXggWWFuIHdyb3RlOg0KPj4gTlZNRSAy
LjAgc3BlYyBzZWN0aW9uIDMuMS4zIHN1Z2dlc3RzIHRoYXQgIlNvZnR3YXJlIHNob3VsZCBu
b3QgcmVseSBvbg0KPj4gMGggYmVpbmcgcmV0dXJuZWQiLiBIZXJlIHdlIHNob3VsZCBzYWZl
Z3VhcmQgdGltZW91dCByZWFkcyB3aGVuIENSVE8gaXMgMCBhbmQNCj4+IGZhbGxiYWNrIHRv
IHRoZSBvbGQgTlZNRSAxLjQgY29tcGF0aWJsZSBmaWVsZC4NCj4gDQo+IE5vdCBzdXJlIEkg
Zm9sbG93IHdoYXQgeW91J3JlIHNheWluZyBoZXJlLiBXZSdyZSBub3QgcmVhbGx5IHJlbHlp
bmcgb24NCj4gQ1JUTyBiZWluZyAwLiBJdCB3YXMgYSBub24temVybyBjYXBhYmlsaXR5IGJp
dCB0aGF0IHRvbGQgdGhlIGRyaXZlciB0bw0KPiB1c2UgQ1JUTywgYW5kIDAgaXMgcG90ZW50
aWFsbHkgYSB2YWxpZCB2YWx1ZSBhIGNvbnRyb2xsZXIgY291bGQgcmVwb3J0Lg0KDQpTb3Jy
eSwgSSBhY3R1YWxseSBtZWFudCB0aGUgb3Bwb3NpdGU6IElmIHRoZSB3aG9sZSBDUlRPIGZp
ZWxkIGlzIHplcm9lZCwgDQp3ZSBwcm9iYWJseSBzaG91bGRuJ3QgcmVseSBvbiBpdCBhcyBw
ZXIgdGhlIHNwZWMgc2F5cy4NCg0KSSB1bmRlcnN0YW5kIHRoYXQgMCBjb3VsZCBiZSBhIHZh
bGlkIHZhbHVlLCB0aGUgc3BlYyBfbWF5XyBiZSBhIGxpdHRsZSANCmJpdCB1bmNsZWFyIGhl
cmUgdGhlbiwgaWYgSSB1bmRlcnN0YW5kIGl0IGNvcnJlY3RseS4NCg0KLS0gDQpSZWdhcmRz
LA0KRmVsaXggWWFuDQoNCg==

--------------jNtJ0WUzuKhb085q1FisWqZL--

--------------SpT6E6sNJK7Qfln0t747BneH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEtZcfLFwQqaCMYAMPeGxj8zDXy5IFAmT7U8wFAwAAAAAACgkQeGxj8zDXy5KP
exAAujnNyyAmV4WWLgmcwK6te3boqXNwxUmDLQaO1jDTW45oR0NwtoDseonqEJ7vKyEIo5h9OY2d
sBKwep1i62s/nPBt6brndZS+DThdPrI/NzhbfITNIoxlMJOinhh0FOWidsESAW46D1xxcxQa4y9/
rzYUSEwDNRR18aXlv9d/YOf1QKvNsXWwrwnvj3KTO5TjHrp6VOLZQT01r+eN+vywCS5683Db7XVH
CUQpOO0SlmCbbr8rTU1Li7zNxUSZcZVO+x5OaGuhTjDGkgWDb+occXE9Aa+jQ/22xTyYy2GIDF/7
G7Nr/VZT3jICEMRG0bkqHm3+jociegcj4m+udpWGNqA9QkwdKvb21C3u9Ijwrn1vylJ7qja3HCrA
ziaIe6LGQkOFUE0bH4HtzGoZzEY2v2WbRBurYfAC5y6FxAhx4wV9XOWxoG3GQkDszfIu57lS51TX
d8HVj7DlYHOabYDe/C0yOomBmIYPErzlBzpdQnr+tCG4gElXLxBHqnmdrMVfEyNuhgYVtGxbLPoE
W2MuYC/RSZEy6z9HhlZ7G3l4ACKfyOWrzX+RV48/5sUc3/UHg87MH+qbVciAL9BPJ2J8NcD/+nc4
pDkOjPGbiqoqB9tBgqEC6qCpRARswMGRhuDAPl2NB413KojyMZZrqyIbGcVS+K3QC4ZR+43KK6uH
aPw=
=p9IC
-----END PGP SIGNATURE-----

--------------SpT6E6sNJK7Qfln0t747BneH--
