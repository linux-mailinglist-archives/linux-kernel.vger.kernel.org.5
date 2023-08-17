Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9405577FDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354485AbjHQSiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 14:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354536AbjHQSh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 14:37:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7552D58;
        Thu, 17 Aug 2023 11:37:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B97465E4E;
        Thu, 17 Aug 2023 18:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE641C433C8;
        Thu, 17 Aug 2023 18:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692297473;
        bh=J1tPV6jQIewMY9GqKdF7CJ1Ugw1zr8eM5AVuLf/L0g8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IeaDQ5ERihR/mIysXnv/euGcikJX6N1dufHVNiLHh+YxAVAIQ/8/IQaLAt3aWCy00
         nh+0CbFcyLMPCGk3gpdDbk2VuPLV7pib8vvzSgnNmIsHfIh75rPwzjDyom955V72Au
         2TPoMD5w6+CAX40KY4dWbtqLJQpbH8X2CCMZhbDfIG/z3+NygYUCJZ1BqjfQ+1wg63
         li3/Z6cNFwZIsbm1cCoZBa6AVLemYj9aBf6IdBDMkY6lOiFC0K8OA4nFTcHSUS7ki6
         wS2rczHZlyEbAfAlmD8UAJCtcNPvXDHRzfrKqAWxBjIrE0VY56idLvrmC3Fv/lun6J
         YMP91lQ6DFSog==
Message-ID: <df8fdd4a-490f-6b2a-03b6-0333e3302dce@kernel.org>
Date:   Thu, 17 Aug 2023 20:37:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: struct_size() using sizeof() vs offsetof()
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
 <202308161913.91369D4A@keescook>
 <09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org>
 <f12c6f14-66c4-6afb-e768-fa7abcfd1bbc@embeddedor.com>
Content-Language: en-US
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <f12c6f14-66c4-6afb-e768-fa7abcfd1bbc@embeddedor.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Xh7qrg5HpYoyXwFXOw9K6fJj"
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Xh7qrg5HpYoyXwFXOw9K6fJj
Content-Type: multipart/mixed; boundary="------------ThNUh2l6BvNzlwUntttNYjTA";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Message-ID: <df8fdd4a-490f-6b2a-03b6-0333e3302dce@kernel.org>
Subject: Re: struct_size() using sizeof() vs offsetof()
References: <74e8cf91-d095-33e3-c548-34d80b691089@kernel.org>
 <202308161913.91369D4A@keescook>
 <09b4a2ce-da74-3a19-6961-67883f634d98@kernel.org>
 <f12c6f14-66c4-6afb-e768-fa7abcfd1bbc@embeddedor.com>
In-Reply-To: <f12c6f14-66c4-6afb-e768-fa7abcfd1bbc@embeddedor.com>

--------------ThNUh2l6BvNzlwUntttNYjTA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 2023-08-17 18:05, Gustavo A. R. Silva wrote:
>=20
>> -               tp_c =3D kzalloc(sizeof(*tp_c), GFP_KERNEL);
>> +               tp_c =3D kzalloc(struct_size(tp_c, hlist->ht, 1), GFP_=
KERNEL);
>=20
> I just sent a fix[1].
>=20
> Thanks for reporting this! :)

:-)

> --
> Gustavo
>=20
> [1] https://lore.kernel.org/linux-hardening/ZN5DvRyq6JNz20l1@work/

Please CC me in that thread.  I want to know when the patch is installed,=
 to
prepare my own against that tree.

Cheers,
Alex

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------ThNUh2l6BvNzlwUntttNYjTA--

--------------Xh7qrg5HpYoyXwFXOw9K6fJj
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTeaPcACgkQnowa+77/
2zIl5w/+OKSRGZm51bd3xnO2rIs1JY0VYPGOkZw27tBxPTE2tGOJs+A6gnLL5ZLw
K8f4GrCOb9Edhr1To+Li7mu1dQ0nyWgmHr3gOslUT7w1z5x7pRGGhMPVRzAf9f+Z
DA8EPt1/OIhL1UVgraGkSArFTFo2dYgJ3eADMwfHNc7w2nUEqtL6wJAjTqayYMTj
AzYxTpwG0yP1Kg2FZ7U5ddUfm/mJDoXfbsc9emCcYVHhaozZfvEjOLaf3FrzxOnh
sFDHcdccYk7WTVxsVAd3S8L7OlIeQKN7S7lTYt+xR72yWKr0Oz05XWCWV5Qg0efT
XCGDE01ux24dkI8xJaEwxUUoG2kAsxHgB0NrJClCUBYayj0GS9hSNiVdJxcNBqY+
zhHvufnyCOnpzptd/7beIe/cqio1uS/WXV4DEC3MNVAsGLCj6fC0R1v2dDpV5Mpo
cwXiQidg9sGZuznUTyV20WNbCHBZ4QalODkhbNQHtSQZ8422SXfQIse0EUYoGxoE
qJLGazO2bQJRa9+wka94s+d9GL9ey8govd9vHZY+oI7XsvYIjAcOrBM1R4n3KGqz
a4BmCqhZs3lYEE9xiWz6VBC0YXJQQDci061q3yAf+3Sne2cm7ktzE+yQU3SHAsBy
3nd/pi6YkQZANQA9v9rnukPIULVQ1IehhyQ8hhR41kINAIqv54Q=
=MET1
-----END PGP SIGNATURE-----

--------------Xh7qrg5HpYoyXwFXOw9K6fJj--
