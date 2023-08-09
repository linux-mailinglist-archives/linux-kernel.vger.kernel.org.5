Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B543E77551D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjHIIXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjHIIXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:23:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D210B1FD5;
        Wed,  9 Aug 2023 01:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691569404;
        bh=enf9bph1wuJpPvU4K7BocBHl7NFXVwdefewDqRR55wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WyPxR3yyhyT/VvDfG048zln7d84Nn56TYDE9HVYaRHoliOhC7iT2HKo8rLe3mNMBp
         30EMU1xNB3yU8VfA1ZWubDylB/uq828Mc+ldtMUcixKDD/lER6l+OOGdZc/WqxtGo1
         n1aruXEJuAVQaVCcHif2EjwaCIiGwn+OOuy2cEwuFOll69LELD+8Y1Wyo38KgJlkvj
         PMZZ0cxjw8uQrYdqKgR96IVnIZMEV57uvX11tcjazkmd2eXkMZNtkRbCX7yFjbIcVH
         /oyFu1sLVKjcV+CGbXXBmA+Md7NuNYbEUMtyGSd9pKAa8Gq9zA1uxp6egnu3mN6UN6
         gHdijzd5hJRaQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RLNNr27Slz4wbP;
        Wed,  9 Aug 2023 18:23:24 +1000 (AEST)
Date:   Wed, 9 Aug 2023 18:23:22 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the aspeed tree
Message-ID: <20230809182322.4b829476@canb.auug.org.au>
In-Reply-To: <CACPK8XfsVMQEXz3fCFnbii1EbJ_Ev99qjKjXbuLR6nY1BHh4mA@mail.gmail.com>
References: <20230711095101.6277674b@canb.auug.org.au>
        <20230720104019.11dee2b2@canb.auug.org.au>
        <20230802100618.3cbf4712@canb.auug.org.au>
        <CACPK8XfsVMQEXz3fCFnbii1EbJ_Ev99qjKjXbuLR6nY1BHh4mA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3DW.hdvGT9h.+iwacqjX3Zc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3DW.hdvGT9h.+iwacqjX3Zc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Wed, 9 Aug 2023 07:57:58 +0000 Joel Stanley <joel@jms.id.au> wrote:
>
> On Wed, 2 Aug 2023 at 00:06, Stephen Rothwell <sfr@canb.auug.org.au> wrot=
e:
> > > > Presumably introduced by commit
> > > >
> > > >   267c95dc9f80 ("ARM: dts: aspeed: bonnell: Add DIMM SPD") =20
> > >
> > > I am still getting those warnings. =20
> >
> > Any progress with this? =20
>=20
> I've pushed some changes that should resolve this.

Thanks
--=20
Cheers,
Stephen Rothwell

--Sig_/3DW.hdvGT9h.+iwacqjX3Zc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTTTPoACgkQAVBC80lX
0GzQbggAhzGmZoMIiE7ioOODdh+tXRHtOujiYSpynYt6c5rXsY8otDFuQPHMAvVb
shTHJ8tLqa3s6Tj3BonaOfYJxnzecol59oagEkg1df2eiWc/oGyvm+JCWZGkflQt
xSr3K4B1ovuSKYPnG5gNFJNMw1N6v7jwYDG+vyN636pBMs2w8dQN6fxP4EaMt6Am
yjMuyhTa4ov+OECULfqXdjU1gP1zO9T9D0aP7kB4/r+VhQCNOFQonU5X7xZfklXU
n4C0X+KYoo+cRcjMtXyPkHuYqKpXxVB4B8OklE0byifwkMqaI4e1RA/b0DcIdQ90
o3ieAlzfFFQMm7rzwzsNAjblevA+dg==
=rdLr
-----END PGP SIGNATURE-----

--Sig_/3DW.hdvGT9h.+iwacqjX3Zc--
