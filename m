Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9542F809000
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjLGS20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 13:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjLGS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 13:28:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EE31709
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 10:28:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F0CC433C7;
        Thu,  7 Dec 2023 18:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701973712;
        bh=oUtjZ+VCwu0p6Zdm0+PMZHE5os+JzirK45maCcLFLZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G41HUC1kewwWxdmisy1k+mtURaptTgqBN3Ot5SqLNnSxHulnqvYUQ8hrMoZC3Gj+C
         bdOrzxYlaYRd2DhcPRBis+su/vydwNbNU1uNX40OSt2W0Gby3b0UZ0hQcmK8MYbVea
         isD9GxQEpcWW6+XJkRe57pNziM8KzouUAJRDzrjTh3qxajLv/Y3cm4waUAYboP19O4
         dc1HxrnBESGdJD5nbynnOQvbGH9geK6/rILKW5cHF1BVehqGWk5OZMh4je8gTkm9hb
         kFclZCtMB4G5cvWfsTixd9YnZWj3W+AdB9uRl6+PZI8WgVGziEpBAXRJF/nRC8JGbR
         gB215Dmnno5pg==
Date:   Thu, 7 Dec 2023 18:28:27 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Gergo Koteles <soyer@irl.hu>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <baojun.xu@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 11/16] ASoC: tas2781: use 0 as default prog/conf index
Message-ID: <a07270d1-ef63-4558-83aa-223b97b1a93e@sirena.org.uk>
References: <cover.1701906455.git.soyer@irl.hu>
 <88229933b7aaf0777cbe611979712e4e144b1ca1.1701906455.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mtri/UqkWBaX0XWB"
Content-Disposition: inline
In-Reply-To: <88229933b7aaf0777cbe611979712e4e144b1ca1.1701906455.git.soyer@irl.hu>
X-Cookie: Two is company, three is an orgy.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mtri/UqkWBaX0XWB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 07, 2023 at 01:04:27AM +0100, Gergo Koteles wrote:

> Invalid indexes are not the best default values.

I'm guessing this is just fallout from the previous (not really
explained patch)?  Is there perhaps some bootstrapping issue here with
ensuring that the program and configuration get written to the device if
the user doesn't explicitly select something in a control?

--Mtri/UqkWBaX0XWB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVyDsoACgkQJNaLcl1U
h9DGpQf/TQARSIEymiOBOzo5cGEpx/8ZwokjtMX7jsnFlo7PvAc6gfo8VM9mxveo
50R+n3iX5Pmcyf+MAXLcFVDfW/+8lHTiGV0X/KZUBoh76QUk1y3Pwfc+xPylhknp
rxtIAOu+D7ViODrLm00ODKFfVnb69+fpMaZEmfsmQJHsZByc5UU7m1gk9i7IxhDg
UXJrBimr02zmiF4AWdyzUVP3rJPCqld6ciVFHwgB3uoA4+LnNEfgjiIbnb1Y/ip1
qwNmUJpIDEa0exen/Vp95H7fdBKM5wV2H2ivj5D4H4He0FlTS+zEjd6C/+eSY3cA
GCUzFTelOBOyxOEre7TNzJbXivrxzA==
=45un
-----END PGP SIGNATURE-----

--Mtri/UqkWBaX0XWB--
