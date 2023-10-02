Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0ACB7B5388
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 15:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237234AbjJBMzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbjJBMzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:55:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F09B0;
        Mon,  2 Oct 2023 05:55:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4116EC433C8;
        Mon,  2 Oct 2023 12:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696251305;
        bh=M1E0aQTcKPqPpOVXRkLzvTlr/tOXmy+Lm7ozsdfR5Ts=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Njb26VRY73ArbIxu8CRCs71wwrsFTmbqx9OjEgbl+CpJrJ08n0s3qz/JHx7YWzD+t
         IEESmQ6T9NOY4jy+wFSELhDxOApdDfNP0mXvTA2+1Ey+8v+4RI29hIo3xbAY+f2LyA
         nK9YhljTUPkuwxCXtIeBNtKV6awphJ+N1oY/Vh0ukvOP2lFhpUJngplgYvBGc3eVAk
         kZscP1ItCutXmpWM0Dy/T5ZgXTPwPJF5uMeV6CRKve4wI120zaf9wDWKGcLEUj0Tal
         FsIQtylvIWy8Z1/C8FFdB74Y5fVKEJJPIgaSdqzkCVnCHkFDZHrk+VpiO9LIfPrSJm
         eYIwKOQZlk2Zg==
Date:   Mon, 2 Oct 2023 13:54:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>,
        mario.limonciello@amd.com, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Message-ID: <64c78944-4d62-4eda-b92b-3b415fea3333@sirena.org.uk>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
 <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
 <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
 <541ac45b-8de7-4fa2-85ee-456d34e60aa9@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y3s07sEkApCR/FW0"
Content-Disposition: inline
In-Reply-To: <541ac45b-8de7-4fa2-85ee-456d34e60aa9@leemhuis.info>
X-Cookie: Postage will be paid by addressee.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y3s07sEkApCR/FW0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 02:28:47PM +0200, Linux regression tracking (Thorst=
en Leemhuis) wrote:
> On 02.10.23 13:52, Mark Brown wrote:

> > x86 firmware descriptions are terrible, it's just an endless procession
> > of quirks.  The model for ACPI is not to describe key information in the
> > kernel and instead on Windows load device specific information from
> > separately supplied tables.  On Linux that translates into these endless
> > quirks, on Windows it's platform specific drivers for otherwise generic
> > audio hardware.

> I know all of that, but from the many recent regression reports and
> patches it seems quirks were not needed for a bunch of Lenovo machines
> before c008323fe361bd ("ASoC: amd: yc: Fix a non-functional mic on
> Lenovo 82SJ") [v6.5]. That made me wonder if that commit really did the
> right thing or if there is a underlying bug somewhere that the newly
> added quirks hide, as I had a few such situations during the past few
> months. If you or others the experts in this area say that this is not
> the case here then I'm totally fine with that, it was just a question.

Until someone tests or otherwise provides specific information on a
given machine we're just guessing about how it's wired up. =20

--y3s07sEkApCR/FW0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUavaMACgkQJNaLcl1U
h9BfhQf+NMxz5LFXKKLUI6Fkw2l2NPDiDWIevr7NcQr0fjBmf4mJei8Jv9zUXHWb
GctXb9s6EQvNS6lbUPhWPBsz5+U5knIFWIFpLuhs8N8MoSVWO0IltodXKPCIX7cx
ZxKiNV7JN0s/YSzQpRr+wPWXTUyYVRDpCCgJ/Fm+JH2TV4MU5dPnFTSb0eHTkEsZ
RjMlhF9RG81Vm1J+srCzUp2UaiTrA7g0ibCf5+iSf6fu18rOnyZw/THhhXlRQmbW
gCuM3yaySZZqhQoppGz5UjWfN11bw8wrDll9kDIOLGj1nvbWCJS3XvLOCjRUY1U3
6nnzwCZV39gIKRz8cIb3KwIjEUYlFw==
=fv+B
-----END PGP SIGNATURE-----

--y3s07sEkApCR/FW0--
