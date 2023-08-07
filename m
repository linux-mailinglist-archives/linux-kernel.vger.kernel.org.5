Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9C3772D99
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 20:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjHGSSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 14:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjHGSSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 14:18:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8153FD;
        Mon,  7 Aug 2023 11:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5CE79620B6;
        Mon,  7 Aug 2023 18:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4279CC433C8;
        Mon,  7 Aug 2023 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691432282;
        bh=ZzcdCc8mVMjmxDstZshcYeL44h63uApvnQxp94Go52Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NhzmpDgFGAyeE3CO2Wjt/Ekw4AW7B8yWCVuDfFVHcsSDqokzh+qKr3DS8uch4cie8
         TKWTu6Qmr+tw77gLg/Ny3tVDT17TuL5aKpRF7A+bsz3KGrRitvlrEoSIgS9LpKk9qo
         fGc6zzIG+Z22mvzddWfden/BUdjTL7bqxSdUtTAcayUe6XPs70DO8Kpr+IuT9QmRrI
         PyhO8meNfLFTfEfr5Q2qlLYMBIeWYsuurHebppUMDIc9Tria+AHCNDV8SSH0/N6Dpw
         rWTgAyRkgvi8P31ZZdoZydyIiBdoC7S/2k0YHENDf5JTyFSzF7VeJLZ+Is10u6nuyq
         H+9J7mrzUBy+g==
Date:   Mon, 7 Aug 2023 19:17:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandru Ardelean <alex@shruggie.ro>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        nick.hawkins@hpe.com, verdun@hpe.com
Subject: Re: [PATCH] spi: gxp: removed unneeded call to platform_set_drvdata()
Message-ID: <196642e7-4136-4ba6-a918-8c759f27f818@sirena.org.uk>
References: <20230807130217.17853-1-aboutphysycs@gmail.com>
 <c867e685-7665-420b-9478-bce6eb067463@sirena.org.uk>
 <CAH3L5Qrzk-7WoF8+GKMYS40Dj_fxGpiLrTvVB_PJdA_VZVsDAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7gwrvj5+w54pKtcv"
Content-Disposition: inline
In-Reply-To: <CAH3L5Qrzk-7WoF8+GKMYS40Dj_fxGpiLrTvVB_PJdA_VZVsDAQ@mail.gmail.com>
X-Cookie: idleness, n.:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7gwrvj5+w54pKtcv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2023 at 08:38:27PM +0300, Alexandru Ardelean wrote:
> On Mon, Aug 7, 2023 at 4:27=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > On Mon, Aug 07, 2023 at 04:02:17PM +0300, Andrei Coardos wrote:

> > > This function call was found to be unnecessary as there is no equival=
ent
> > > platform_get_drvdata() call to access the private data of the driver.=
 Also,
> > > the private data is defined in this driver, so there is no risk of it=
 being
> > > accessed outside of this driver file.

> > That isn't enough of a check here - people can still reference the
> > driver data without going through the accessor function.

> So, is that like calling `platform_get_drvdata()` in a parent/chid
> device, to check if the driver-data is set?

That wasn't what I was thinking of, waht I was thinking of was just open
coding platform_get_drvdata() and looking directly at struct device.
Another common case is where drivers that support multiple bus types
will pass around the struct device and use dev_get_drvdata() to read the
data rather than using platform_get_drvdata().  The driver data can be
allocated and initialised with bus specific bits before being passed off
to the generic code.

That said the looking at the parent's driver data is definitely a thing
that happens with MFDs.

--7gwrvj5+w54pKtcv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTRNVUACgkQJNaLcl1U
h9DRbQf/UD6rT6THBwwsVjvF+9xmAJZdPPLu0/Bqms50iz2PhJKdjfhZfjo8vOXt
yWawMNetOUo3iUVxnMesYI43et1n+veZB9tA5qaXX5Fu2OBXOAnHHWdbha7f/99R
kdQ8+L+Hhw7rb+EalNBlx15aeo+b6iWJ1BiYFQ5PD2wLgHPUe24der7IbM1I0gRR
u+DUr9SEoGBpPtKT/0AzTtVlLPc0kFLOUIotXVqgkgISKxylhdOK1aErIjdGJM5P
3COmUmsJq5EyT9fm6+CC3Q/bPyCeYcZIwrouxPdImOM1AnGrW124BHTUVi8K8oVh
sR3JyZuBS1jCYiccd/JEi7agqqqWLw==
=NKz9
-----END PGP SIGNATURE-----

--7gwrvj5+w54pKtcv--
