Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B95F7D076F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 06:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJTEvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 00:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjJTEvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 00:51:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565AD45;
        Thu, 19 Oct 2023 21:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697777475;
        bh=0CF8Qksp735ZSvCFf4empCveLmxBjINNgIpGWvpCz5k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jZ7WK1yYLVR11CHWLmMkYzBHVuoUD5GpwTvqM1uVxUsa4ozhI2wjQkfkRqvsUEafE
         NpG7/3+FIOgcn5A7UlcLmrjzqpXOIxXRHiEsH0R0Vh9Xe8y19Air4aoi3AdLpsnhB6
         LhTNx8S8JgNzu3MFXPFbALYBvQlOYocGO8ER7bYGd7NXvQKejoRRVIUVa3ypQrtPF+
         tah2ZkgEJMO0YQFgl/Aotc8+IMksd/SjouI9YHRJl4ZAmQ03gqDGY3xIV9TAnqLzK0
         CnIAVvT/51nnW5ydzZE8INA6dnXiPn1XLrQAn/Ldv2zxSQnX5pcSMDovYmNV50JNJe
         K2Ufl+Q7k7JQA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SBXGq0tyzz4wd7;
        Fri, 20 Oct 2023 15:51:15 +1100 (AEDT)
Date:   Fri, 20 Oct 2023 15:51:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bitmap tree
Message-ID: <20231020155113.31acd611@canb.auug.org.au>
In-Reply-To: <ZTIBESMp9qsRdVja@yury-ThinkPad>
References: <20231019170106.4159eac5@canb.auug.org.au>
        <ZTFSHqjkHLM5iAqH@yury-ThinkPad>
        <ZTIBESMp9qsRdVja@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hRLo_u7ar6GwjAzP/nhSU1z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hRLo_u7ar6GwjAzP/nhSU1z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Thu, 19 Oct 2023 21:24:49 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>
> On Thu, Oct 19, 2023 at 08:58:24AM -0700, Yury Norov wrote:
> > On Thu, Oct 19, 2023 at 05:01:06PM +1100, Stephen Rothwell wrote: =20
> > >=20
> > > After merging the bitmap tree, today's linux-next build (native perf)
> > > failed like this:
> > >=20
> > > In file included from /home/sfr/next/next/tools/perf/util/header.h:10,
> > >                  from /home/sfr/next/perf/pmu-events/pmu-events.c:3:
> > > /home/sfr/next/next/tools/include/linux/bitmap.h:5:10: fatal error: l=
inux/align.h: No such file or directory
> > >     5 | #include <linux/align.h>
> > >       |          ^~~~~~~~~~~~~~~
> > >=20
> > > Caused by commit
> > >=20
> > >   ed46ac8199f0 ("bitmap: introduce generic optimized bitmap_size()")
> > >=20
> > > I have used the bitmap tree from next-20231018 for today. =20
> >=20
> > Thanks, Stephen. I'll take a look and let you know when it's resolved. =
=20
>=20
> So the problem is that the patch "bitmap: introduce generic optimized
> bitmap_size()" adds reference to the linux/align.h, which doesn't exist
> in tools.
>=20
> I removed tools part of the patch entirely, and now tools/perf, for
> example, builds OK for me natively. The tree doesn't touch tools at
> all now, except for moving BYTES_TO_BITS() from a source file to a
> header, which looks safe.

Almost - see my other email.

> Can you please try the latest bitmap-for-next?

See above.

My "native" is PowerPC 64 LE.
--=20
Cheers,
Stephen Rothwell

--Sig_/hRLo_u7ar6GwjAzP/nhSU1z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUyB0IACgkQAVBC80lX
0Gy4VAf/ebNeNRhE/6+qDu61iY0amZalbPKfx2D7PLcC1MnlAJs4ZqeBCRKKrmfr
2+ILxp3Ph9ZNM0t/2XVhHes1ZC/JD3/f+b70ABTIHtfyre+htlS9lOoI7nK7QnVD
DysiveUuUXwCQ1G004JSfWv0UAJc1btcU5Llq7h0cQcIprGb4G1J7v3NKmjFHsr1
cVrd+GtLRqsQnGW9K1asnM8P29yRCu41fNGwfQx4rqNXQI9szT275utaKuNaciJl
wsfpxLlNzC0Uw3OJyJdRywjKyyWRJnek0NX6tZcWI5ihD4769xXa5Wsf1lVzm56n
fYcrr7L4pIL5nJbSSVid+50SXBZQOg==
=6kV7
-----END PGP SIGNATURE-----

--Sig_/hRLo_u7ar6GwjAzP/nhSU1z--
