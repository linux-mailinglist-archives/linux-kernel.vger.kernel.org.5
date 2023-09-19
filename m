Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B917A5AD3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 09:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjISH0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 03:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjISH0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 03:26:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77461FC;
        Tue, 19 Sep 2023 00:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695108353;
        bh=BXA+1Kw/6obE3VF4wSJBx7IOy9FiYg0aqGCKSySeKIY=;
        h=Date:From:To:Cc:Subject:From;
        b=mVNQfPoP0InAQJvX/TjwplFu7e1SK12FdFHxLSD4agdk0SblOKcarmPLquEtZZ1BM
         SLdOtW6LbwCMQ43jPUlnjZLdz9IH+sMmiLLDU92qEx0gtyOUFxHbJuwhryBnWjb9A6
         6S4p2qyoW3fu8A2GRHQZKyAQi63dMGZZpnDm4N1dWfNtTAoMey5umPQIN1ppd/ooEU
         ter1KtEObPCII+QgZsv9+7E7+1IaThC4pgnJkTtAA+prnJAaY04tRFmkF/qAivQP3P
         bflh1nOXgF/4sZPoGOWThNO7Q6uPKUCD8M39pSFUD+l68W25oCgQg5VMV5mumKCHls
         L9AbGLIQFKd4w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RqY9Y2qZdz4xNq;
        Tue, 19 Sep 2023 17:25:53 +1000 (AEST)
Date:   Tue, 19 Sep 2023 17:25:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        David Chinner <david@fromorbit.com>,
        <linux-xfs@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the xfs tree
Message-ID: <20230919172549.5daa24d9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u_tJ0ZZJSxm79sbK/i1Q9mj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u_tJ0ZZJSxm79sbK/i1Q9mj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  74ad4693b647 ("xfs: fix log recovery when unknown rocompat bits are set")

Fixes tag

  Fixes: 9e037cb7972f ("xfs: check for unknown v5 feature bits in superbloc=
k write verifier"

has these problem(s):

  - Subject has leading but no trailing parentheses

--=20
Cheers,
Stephen Rothwell

--Sig_/u_tJ0ZZJSxm79sbK/i1Q9mj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUJTP0ACgkQAVBC80lX
0GybbAf8DVHxuSysAz4Hk4gS2DgE3nz/Y6aA8TzonDpsVUEmuqdGPGgaOkSNpxhp
Yj3eQfHy836C+0X/XOpJPtSseCfQDZCnT9g2MfvhN7B/nY6KG0BbYEhEYpe8fAtb
flA5a4dfH1pgjxpR4H5jaNtjL0A9n4Aqh9kfd5fHKsUeV5n67TC6hIsJgCpVJeUM
qyR2cl7bhuak5xglRZ5jdBPiekPXxHm6H6Skfu5sSJNNVJjbCRn0ukN6v6pmfc2V
IKdEOGfy9LdcwQ3S0wEJMfXtZZFi2D4sxSKvFtL8RYA+hTs/wwq6MxxwnjJWDfSa
eJEGq6XnSrWsySC83AOeVW663U5Psw==
=A81u
-----END PGP SIGNATURE-----

--Sig_/u_tJ0ZZJSxm79sbK/i1Q9mj--
