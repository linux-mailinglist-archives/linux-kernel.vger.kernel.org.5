Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9239775D948
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 05:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjGVDBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 23:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjGVDBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 23:01:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CACA10F4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 20:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689994883;
        bh=8WAvXoQqLuMqtLTnvKzEcTqmb/uCI/ucvc1IDEyZglI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=projGdOz5MBOYASHzzYjkAQtlyby1xV2fwhN562j33HN1LDR933djfkgNA3r1MDlx
         86r8Qly5e549o/GMztBlhb4nYoTWlRQZPZF8jOftfDI2UGF3nbIxzTWML8gJWsudOd
         hUSdi3PAjB7v67sj41+j+/1hQi4cW/gJ+PXKcmuOLTk2oSKqEl50h2/z2BJ5GuZmpU
         lq2AlvnWZKOhbonoxTs4fJJrrEVI+Gr8h+CaWJQGgLtlzjsenC7Ney86vLfZhgtseN
         fRN0XivWw2zpdwAF1Ajk0MxKT3rkL9URhYtqCf+eT7VOsx42OkYWBK+hOt9CKuDxpe
         ZGEyRmzH+xEDw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R7B5Y4ryhz4wyC;
        Sat, 22 Jul 2023 13:01:21 +1000 (AEST)
Date:   Sat, 22 Jul 2023 13:01:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Willy Tarreau <w@1wt.eu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Thomas =?UTF-8?B?V2Vp?= =?UTF-8?B?w59zY2h1aA==?= 
        <thomas@t-8ch.de>, linux-kernel@vger.kernel.org
Subject: Re: Upcoming nolibc pull request for the next merge window
Message-ID: <20230722130120.6e4c0eab@canb.auug.org.au>
In-Reply-To: <7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop>
References: <7afafb6c-9664-44a1-bc8f-d20239db1dd5@paulmck-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f6xPJD0E9.JEJSA=IOUah=V";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f6xPJD0E9.JEJSA=IOUah=V
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri, 21 Jul 2023 10:39:48 -0700 "Paul E. McKenney" <paulmck@kernel.org> =
wrote:
>
> This is just to let you know that Willy and I are adding co-maintainers
> for nolibc.  Shuah Khan will join me as administrative maintainer,
> and will be sending the pull request to you for the next merge window.
>=20
> Similarly, Thomas Wei=C3=9Fschuh will be joining Willy as technical maint=
ainer
> for nolibc.  With luck, this won't affect you, but in case you come across
> a nolibc issue, please reach out to Thomas as well as Willy, Shuah,
> and myself.  There will of course be an update to the MAINTAINERS file
> in the near future, but just to let you know in the meantime.

Would it make sense to add a separate nolibc branch to linux-next (and
no longer merge it into the rcu branch?  Or are there dependencies
between the two?

--=20
Cheers,
Stephen Rothwell

--Sig_/f6xPJD0E9.JEJSA=IOUah=V
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS7RoAACgkQAVBC80lX
0GwEpQf8DGSNxYOqncvhe6TSjmTRwRchkHVoZw5f3p7/oLvX2+669rLWjWca8KeN
nT89melFYeW51AwPeKiWuHl3tbYfPh2+0rl9izRvdQrR69lv9Zo6qJN7a37FlA2k
8IDrs5A1444p6co6cFSc56jmWOPsby9Es2sc0tFDpi9HWIXgyp3UpCcrr94Y3Nzw
Ki893QVUDwFXec0J0MzG5fsiYtY95ygbuhp6hGq0YO1v9W2JiWFA3wrUiyiTXBl9
epb35Hfw/uGpvgvBZX3/R1p78qBJCLUygbsB4jCBzVBswNNFYN3MBShpHUzHmmAE
pf4uFIBaij7z68H5CiCzsmP9K1MXHw==
=laiU
-----END PGP SIGNATURE-----

--Sig_/f6xPJD0E9.JEJSA=IOUah=V--
