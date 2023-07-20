Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9782D75A3B7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:00:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGTBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGTBA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:00:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A029692;
        Wed, 19 Jul 2023 18:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689814824;
        bh=LfUF9ZhH9pFwsiMhXc+/2cqBqLy7keH0umsg+6P4TXo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T1Bu1+OvHepCre2l6Kv6kJ9sQaSAGxMsnPqeatADFAnWkScuEMXJoz6L+arMgNj4U
         R20erCgI1MQ8dTMKL18WuMy37GmWpSFFcDQy0SdhM8hiP2MivEpwaNhgTLq9Xdam+c
         0Y+k+I2owNnjrYtAg3ucbM9KTcRfZ40oFT7iB5WuF/Ldsl7e1szfbTJfkbq4rNruJ4
         e7o3XKye3H2Issf7OZja1+MtR2u0quguR+Cr/9hW7IasSE4/neVA0WwgBxzwoDETE4
         bXl24vYvfF6qQQa3AJ19qk3iDoEWKxc2CEIZqsTake2LzEnhPHBQzGnPzz/8BTwecJ
         SS9O71NljDTjg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5vVv6dLmz4wZn;
        Thu, 20 Jul 2023 11:00:23 +1000 (AEST)
Date:   Thu, 20 Jul 2023 11:00:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Winston Wen <wentao@uniontech.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the cifs tree
Message-ID: <20230720110021.3f2f9457@canb.auug.org.au>
In-Reply-To: <CAH2r5mugNKYBNXm7AuPFL=V=77Qkm3q6TtXCj-B0kugmpL0aYQ@mail.gmail.com>
References: <20230720103540.0436273d@canb.auug.org.au>
        <CAH2r5mugNKYBNXm7AuPFL=V=77Qkm3q6TtXCj-B0kugmpL0aYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/FIrPqV5zDJ.FH04/BPP=TU=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/FIrPqV5zDJ.FH04/BPP=TU=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 19 Jul 2023 19:47:42 -0500 Steve French <smfrench@gmail.com> wrote:
>
> Winston had an updated version of the patch - just replaced it with
> his updated one which does a cast to (char *)
>=20
>           ses->local_nls =3D load_nls((char *)ctx->local_nls->charset);
>=20
> But as he noted in an earlier email thread:
> > Perhaps I should make a change to load_nls() to take a const char *
> > instead of char *? If this make sense, I'll do it soon. =20
>=20
> which is probably cleaner

s/probably/definitely/  ;-)

--=20
Cheers,
Stephen Rothwell

--Sig_/FIrPqV5zDJ.FH04/BPP=TU=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4hyYACgkQAVBC80lX
0GxH8gf/Tx5aW0j6Mj4Q3aumRfNgl8nFIUfWng73joDDPna1bV9ck4lD2PaTbcgQ
FhK9et4v/hkYfhjcmqern74/rlueEjpMa6+k1cf5Zrl8fzsWv8CirTJ7FfcPDJJP
GjYf+jEyG6+V63RcOu97DriNKQ4CsIHto3LPvtygG2JCUqJWQ1YvetpiLo91iQFa
CDweL6LLEteaUdwctceikPv9vNxcpo3+gR9pMjtxCu/VlIHviyduZ/mHEUZF1X7h
Jwj3O+ikbpNZ5r4mxdruWp5C/0OXmSog1Yk04iZjOWzRFzb4jCBBgCFcsQKq6u0A
TWL7fn9eL3QgP2vMPXxh2765MK/6wA==
=oC+X
-----END PGP SIGNATURE-----

--Sig_/FIrPqV5zDJ.FH04/BPP=TU=--
