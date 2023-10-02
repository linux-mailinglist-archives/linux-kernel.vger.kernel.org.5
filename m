Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5767B51BB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236787AbjJBLwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236780AbjJBLwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:52:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124D0C6;
        Mon,  2 Oct 2023 04:52:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F04C433C8;
        Mon,  2 Oct 2023 11:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696247532;
        bh=mD0QT0lkuP0r4ZV9BxCcQ5Sp1u63ujom7VHA8vIIfnQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Axrne4HGDwfESYO2ByS4rSXEtSHeXhf9vW/ONBjwi6qspv5IbIE0zKhUoG0DYzCLB
         84YMqwGTgFdOWWA/NcIeWt4G6F+YjgR4tAj0hp51BQX+BGGSfxE5/Te8Wbq5pO1/dB
         HiM5dVdMCAmE73sW6Ji0OwjSEgotKJjFNSdjs+3kgJ1T6PqnknFEIGnNwWeGd0YmbD
         kImsO0h8bP6jtcBvw9GzM1rtMnXdUdFr5bnBEDgxkv4nw4WqeNIuGwaRGBDOjdeuNy
         kT2mklnaBQroIIW0k3OH6+cTGGmmN1rJrVVPVJ5nv6WOmYD1rMe2oc2F4VK5GEZ9F1
         vASKikm+Wttyg==
Date:   Mon, 2 Oct 2023 12:52:04 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>,
        mario.limonciello@amd.com, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Message-ID: <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
 <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="KGb+AMvjQ5LP9ojj"
Content-Disposition: inline
In-Reply-To: <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
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


--KGb+AMvjQ5LP9ojj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 02, 2023 at 11:32:48AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:

> Makes me wonder: How many more such quirk entries will be needed? Will
> we have all machines listed soon, or do we expect that future Lenovo
> hardware will need entries as well? If it's the latter: are quirks
> really the right solution here, or do they just hide some bug or then
> need for code that automatically handles things?

x86 firmware descriptions are terrible, it's just an endless procession
of quirks.  The model for ACPI is not to describe key information in the
kernel and instead on Windows load device specific information from
separately supplied tables.  On Linux that translates into these endless
quirks, on Windows it's platform specific drivers for otherwise generic
audio hardware.

--KGb+AMvjQ5LP9ojj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUaruMACgkQJNaLcl1U
h9Bx7wf9FRyZSTh2EDOh9DlJhuxaY0I/WglGW1OTL05cnsL/2aJB17tn/OXVh6kV
63H5ZQ7Pkeb2JjyglqakUciSCmVUFP3wZAj1m/OOuUyNB1RiVvtWe6JQJDfzEsIX
QJoHO2nm2SGOmGy0JVOUcWDWXKxHo1L88+cimo7Sfj7yTLHBuRUMSqxpODOho1p6
Y0KAYgGtzlgAhGLTc5mRkWep5r05zosEpTHVSmx4lpVVTMb8+vzYGym+py/ghoux
G5b/wmqdWrVA69eGeyi5znMCXre8tzN0EujVE5C9Out07VJ4vpKG9tm9dMcSFNEg
jiLZrMEwNviwo0TkT2n8pfasqmsXbg==
=pKIL
-----END PGP SIGNATURE-----

--KGb+AMvjQ5LP9ojj--
