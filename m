Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7699789DB7
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 13:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjH0Lyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 07:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjH0Lyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 07:54:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A12EC
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 04:54:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DE7860A72
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 11:54:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C82C433C7;
        Sun, 27 Aug 2023 11:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693137278;
        bh=HCKLU4HFrSpkJ4paDMdbG9pku8cUYKPpuatOjyuNsbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iW45c6CFIS1kelrm4x0b8zs7WioFmM2OjgyGFXP3jcNJk0+8qKXZpJFips+FVuPJm
         7IHW2a6YO8q+NeZxxBGmrGWyDTqKBZZCegYrY7u6wiBcm74B1Jlg27aphea8Lsv8By
         ILZWiF+MOv0GpLn+1/Uyiykqs6XZO3D7zRoFAcb7MtL+0wqyyGIYrexj6+srE98VRr
         igbKIvFoy8WXYefXXwjGaVKH6zsE0ElTGd7uzg8/+4qsyySR/9CxTep/TDo9lxtdTp
         DIfuVagnM6TnF8myMijK0OgNBeDiOMfqayAKc5Kw+p2TUMYTN5GsqIyhSbyNS2WJ+e
         uge25g38OXc2A==
Date:   Sun, 27 Aug 2023 12:54:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shengjiu Wang <shengjiu.wang@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: Question about simple-audio-card with dummy CODEC
Message-ID: <ZOs5exw+95zzzawK@finisterre.sirena.org.uk>
References: <CAHCN7xKQ549ExO83Yur=_MPv3aYFdR0nfzUSuEXO74OddAr5gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T0pIQEA2r2aEwbrh"
Content-Disposition: inline
In-Reply-To: <CAHCN7xKQ549ExO83Yur=_MPv3aYFdR0nfzUSuEXO74OddAr5gQ@mail.gmail.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T0pIQEA2r2aEwbrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 26, 2023 at 11:15:30PM -0500, Adam Ford wrote:

> I am asking what is the best way to let simple-audio-card  use a dummy
> codec?  If the dummy codec is the better option, what compatible name
> should I use?

We have a driver for DMICs, dmic.c - you should use that.  In general
you should never use the dummy CODEC, you should use a driver for the
specific thing on the board which will at least describe the
capabilities of the hardware even if it doesn't have any ops that do
anything.

--T0pIQEA2r2aEwbrh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTrOXcACgkQJNaLcl1U
h9BzZggAgccl5OyRQ19/3VMkvr0tLY6x0rAQCt8tQ7ni/4Dy4L/4RAIhcPc3jqJv
eORZtWbC4Gkj/vGVY9qEV78awLZsZ3+77LuwX1bznEJBzV0pe/RFeOSA+BdJ8UGd
cKopGGCieXIaW9t3nwGQbzd/Co4YST7r3dKlXctEy0WiD/tMTyAj809hhoWA5Ipj
BXpnMvv8Z4HtUbNyULHyzCNWYv5ZqGYjDmIbRmzmpVFHaPLOSjyJqOzro8KxbM13
f7bX0kfn4N4KgIXSr1yDWib/Pp3Uoyds5NEyN3XbEWCKANWRtKXcx/rZpV4ZHJhr
xDHPWsW6job7+554QriRZ98Lg+KzcQ==
=XbPJ
-----END PGP SIGNATURE-----

--T0pIQEA2r2aEwbrh--
