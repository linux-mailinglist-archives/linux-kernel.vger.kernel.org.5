Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 337E87A3FAA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 05:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238770AbjIRDSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 23:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbjIRDSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 23:18:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3585DB;
        Sun, 17 Sep 2023 20:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695007110;
        bh=z5MwpFuh+8qs66DTIv9i9WjXUj51ek4NJRpSo+6YSQk=;
        h=Date:From:To:Cc:Subject:From;
        b=nwbspNmcMkc5ff3pjmtL/Cx6QhqSGhxqMzyzkrmhyOzoq3647fTMy3cOgqE1cMIyI
         gGS/LmjSV7viMDllFMYjpucpukI6fNrS/mBplQQIR0wgYaK/DwPcDcw/MyqxkgGMFp
         G9M7TXXXoSbkeNoVb0ZePSykGOs5alD5cWXmK8+uceO4AHKrAoagqOnLmFhh/YO1qz
         L/ATB+M0fTjKf+djXTS8hkYlJcNNFoa9H8tnI0zm0FRdy2i0yEXh9NxhJJDJMzdeZn
         BrW2y3kXPP86zUTJiRFow+K7ctY8O4ktE5MdIH7ORp+Qr8kWbsDamSeJer5FAgapyy
         AgmybVbWMzXww==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RpqkZ26wfz4x5F;
        Mon, 18 Sep 2023 13:18:30 +1000 (AEST)
Date:   Mon, 18 Sep 2023 13:18:29 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Usama Arif <usama.arif@bytedance.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20230918131829.5881ffc3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XdvXlMyfJuNr/8GFAe=8/9b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XdvXlMyfJuNr/8GFAe=8/9b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

mm/memblock.c:906: warning: Function parameter or member 'type' not describ=
ed in 'memblock_setclr_flag'

Introduced by commit

  70083e1c8ab4 ("memblock: pass memblock_type to memblock_setclr_flag")

--=20
Cheers,
Stephen Rothwell

--Sig_/XdvXlMyfJuNr/8GFAe=8/9b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUHwYUACgkQAVBC80lX
0GzRIwf/VqHToFGuJDIMG4Tk6UM2O7xeDZWeslxSYMqsnv+9QTlyNcpfIak0iioQ
9nuW6rfIauqs38m7PRm6uANdjkDBd9JWskyJ3OfNOCkL8CLUsfT17n5gEvvl+y9n
3KONKQ4V8Hvt47Nge8HPuFnHGQlsxLqbL/N4+kXeK/TTr40M7yF7u2rR0GkVdYSI
pMmP/kTv/4Lhol03ZGtN8XQ7YPDbpFQfhKFzA6MBEdDGO8GiP5AuBOBMxx2v9rr+
HqU9du0Z4he19J1Eu/4N5iBkn/QM1BA/7tuOIEnNytKgViaDfyLP2J1M2n0GU0aa
ky9E7N3fXWzTmev5ONH3wxAjRXcD4Q==
=eyN0
-----END PGP SIGNATURE-----

--Sig_/XdvXlMyfJuNr/8GFAe=8/9b--
