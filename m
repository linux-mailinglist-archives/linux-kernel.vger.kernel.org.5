Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD4878A384
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 01:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjH0Xmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 19:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjH0Xmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 19:42:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D98D8;
        Sun, 27 Aug 2023 16:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1693179750;
        bh=oQw+CaWDrGtDtZjGxuU+HGlxJuh5yV8okwZVL9K0+IY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G6C9BfwvMcJgGzMFNuI0cvRPk77V5vmZHVy5oVhzs4M/uVVC3l3xe4H7Ye2wThWsM
         UkdfpQgj547GcQ/JzBGKp2UAza/GY8AU49zrrL+0k41Vv/7iuioulYSrWpy+SQeu+c
         V6Q9TbbkM/EA+94ifNVwQPEO3QvgrCeGsvKmFFzS8u5tYkuNs0gywax0Z4Ma09bD+5
         cwMD1bWk2xtwOIhQcpKHBZBhA6l/E4YPnAwHj5DKqe4BsDiOT30PGBQNE3Cx2QQLBX
         TtmFCIcrnAUyQnI0gZVTarZH/HD1F9pmuQbFMhXLasugb+WUm6y5jpAKaam1vxpxc8
         CLfYb+DPBgfdA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RYqx23qrzz4wb8;
        Mon, 28 Aug 2023 09:42:30 +1000 (AEST)
Date:   Mon, 28 Aug 2023 09:42:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] s390 updates for 6.6 merge window
Message-ID: <20230828094228.2381967f@canb.auug.org.au>
In-Reply-To: <20230827203401.5559-B-hca@linux.ibm.com>
References: <20230827203058.5559-A-hca@linux.ibm.com>
        <20230827203401.5559-B-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/c=PxV_9WEcCkRj9cHpf=UNd";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/c=PxV_9WEcCkRj9cHpf=UNd
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Heiko,

On Sun, 27 Aug 2023 22:34:01 +0200 Heiko Carstens <hca@linux.ibm.com> wrote:
>
> On Sun, Aug 27, 2023 at 10:31:00PM +0200, Heiko Carstens wrote:
>=20
> Maybe I'm doing something wrong, but below is the rather large diff
> of the merge commit, using "git diff HEAD HEAD^@", where HEAD is the
> merge commit.

Something weird there.  I just see the arch/s390/Kconfig part (I use
git diff-tree <merge commit>).  What did you merge?

I can't see any commits affecting kernel/Kconfig.kexec in the s390
branch in linux-next.
--=20
Cheers,
Stephen Rothwell

--Sig_/c=PxV_9WEcCkRj9cHpf=UNd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTr32QACgkQAVBC80lX
0GyQ7wf1FNIfepFsUDSfIHgK1DUpYria/ObmqgZbD7b6GqwjC7Ed/jNIbxnwAJTZ
S6b0MUZa0XFbOnOBWjek+kc7II9WXPxdmLE2sH13cDVzqUJ1is63GUwSMVGfmN34
iZdXQakCHLIQXVtoT9esdGfwiAp+URxshJqS41xTQFNC9HLDVcYN70T36nQ7Uzel
oDFfuOtIphh+3wnUGImovqMoSp/JyAhfc5UX3EjhLcDOrxl/ZC66V2CLriNUYIlE
ziJhLJ3rZqxgnXuFaFkZEE1grOi7kTfWfVTQGtmY2E07jJGjgB+CnqG8x1mRaEAn
iK90W4q6aVngh/eV7Pg6qJ4J+U8V
=+vIK
-----END PGP SIGNATURE-----

--Sig_/c=PxV_9WEcCkRj9cHpf=UNd--
