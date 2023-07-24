Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8CC75EA4D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 05:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjGXD7G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 23:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjGXD7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 23:59:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1501CB0;
        Sun, 23 Jul 2023 20:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690171140;
        bh=W86ZLaZwdyVATmon5YX5XAipgk3WHeaX4q7xnup33HI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CPQUhClFQlcV96NnwkLIOsv82b5N9aXFKX6q4G0zsEB0wc347Rc2LdJYXwhp68xbU
         3y7bx5oVelPIu7cWmuEtaFxiHWE9kO1c1slsxp+9TPPilfA0gKkggswZhovOjV4sbf
         T1VM8aCQ9yq08NZBLds1cG/NelSkYJk22Ea1klTJtr6kaICVaoZPCqCNd6OX89qI9l
         XA0HfP3hPWla6GJFntvp1N3mo9cpLU47iLrFDwYoK+frwRuwwk8KWpCBi815ahJVgb
         1xweK6Prqo/bKPjU029h7Mpn3i3eQLkN0u69+0qNpnEniZb0WSZtt95KuKA2qm5QKI
         gKvUIsmR+x42A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R8RH83R9Zz4wxx;
        Mon, 24 Jul 2023 13:58:59 +1000 (AEST)
Date:   Mon, 24 Jul 2023 13:58:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
Message-ID: <20230724135858.3c1abb01@canb.auug.org.au>
In-Reply-To: <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
References: <20230713121627.17990c86@canb.auug.org.au>
        <ZK/ruOD4QFPQ3Q5q@smile.fi.intel.com>
        <ZK/w5LFanElxZazG@smile.fi.intel.com>
        <ZLES/6iNcmR7H+f7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rI=3qm6trKPaAueSFxtHepy";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rI=3qm6trKPaAueSFxtHepy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Aall,

On Fri, 14 Jul 2023 12:18:55 +0300 Andy Shevchenko <andriy.shevchenko@linux=
.intel.com> wrote:
>
> On Thu, Jul 13, 2023 at 03:41:09PM +0300, Andy Shevchenko wrote:
> > On Thu, Jul 13, 2023 at 03:19:04PM +0300, Andy Shevchenko wrote: =20
> > > On Thu, Jul 13, 2023 at 12:16:27PM +1000, Stephen Rothwell wrote: =20
> > > >=20
> > > > After merging the sound-asoc tree, today's linux-next build (htmldo=
cs)
> > > > produced this warning:
> > > >=20
> > > > include/linux/int_log.h:1: warning: no structured comments found
> > > >=20
> > > > Introduced by commit
> > > >=20
> > > >   f97fa3dcb2db ("lib/math: Move dvb_math.c into lib/math/int_log.c"=
) =20
> > >=20
> > > Can you elaborate a bit, please?
> > >=20
> > > Seems to me to be a false positive, or unveils a bug somewhere else. =
=20
> >=20
> > Ah, now I understand. There is a header file that has descriptions but
> > EXPORT_SYMBOL. We have to drop keyword export from the index.
> >=20
> > Thank you for the report, I'll cook the patch ASAP. =20
>=20
> The 20230713165320.14199-1-andriy.shevchenko@linux.intel.com had been sen=
t.

But not yet applied by anyone :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/rI=3qm6trKPaAueSFxtHepy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS99wMACgkQAVBC80lX
0GxhaQf/fOfnO3y4pBpJLf6Zk9CE6jSKZjECrLlYfCn5OhxysagIUQ+N49gmcqda
aCcoXBBIUhbGq3VLQqa7IOdl0g+tYL3gzi2ga8sV6bFhEX2awhVAO9I5Ra96HsQO
A46MoQapPi+cuaSMeG4Hvjt4iddAhgpaJ1u6ER6hbK9olebocYJiLr4W+o54ZFCt
tQ63qz145MO+fUjpc0EeRKLnaLX9bEPVl1rMWZckef59qnwuK/hzIlfE7XU4OZEG
ckbh0cPVZQzSYWkFh6gY815zuZKVEGEJ4IC3qLN0eQSAym2LW4zHPhnfZ+u9iBiH
jq4pwihM+VYe0VlDKlnxzdUyfJ1Oyg==
=ZOi3
-----END PGP SIGNATURE-----

--Sig_/rI=3qm6trKPaAueSFxtHepy--
