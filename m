Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2047D17F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 23:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjJTVWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 17:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjJTVWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 17:22:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E86AD67;
        Fri, 20 Oct 2023 14:21:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2948C433C7;
        Fri, 20 Oct 2023 21:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697836915;
        bh=BLrgnESXlM0bQhQQkhWCSUxl2XgKQbgE2i5fnpBrc3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tbAx+zdTw3EmJEMpY/z3xQDVT6pMUekObKYRuLy18CAvtNXOLDqT2TQkAHws9I/Ox
         kbtovzNKZzwGZmJnhfSKgwZZwdkzmnBE7S6J+6Sl1bJbFOGiXPDOGNIbaiF7wOPGDc
         7Zo1Ek8L3/NabFUuQoMPIMDPL6vfe/73k1XKI7nL/5SVtLcmovXnqihFFEDFOy50ge
         4XjMZUEtakggZKWIykJMPZU2NPdHya4DravYwENNSY0TgOkS7TDL7jwt6Jp+vokjeP
         o8YqjvoA92DhhxAviAa+UeWkU4AWlMO+fjcvpVM45IWFXR3zSA+toM2YMVXdBSg7B8
         6DZAyiECd4psQ==
Date:   Fri, 20 Oct 2023 22:21:48 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        stable@vger.kernel.org,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        sound-open-firmware@alsa-project.org
Subject: Re: [PATCH v1] ALSA: SOF: sof-pci-dev: Fix community key quirk
 detection
Message-ID: <79d83b16-518c-4fb1-9652-662a552e3ef3@sirena.org.uk>
References: <20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bvpm8AcR9ruTek1u"
Content-Disposition: inline
In-Reply-To: <20231020145953.v1.1.Iaf5702dc3f8af0fd2f81a22ba2da1a5e15b3604c@changeid>
X-Cookie: teamwork, n.:
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bvpm8AcR9ruTek1u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 20, 2023 at 02:59:53PM -0600, Mark Hasemeyer wrote:
> Some Chromebooks do not populate the product family DMI value resulting
> in firmware load failures.
>=20
> Add another quirk detection entry that looks for "Google" in the BIOS
> version. Theoretically, PRODUCT_FAMILY could be replaced with
> BIOS_VERSION, but it is left as a quirk to be conservative.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--bvpm8AcR9ruTek1u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUy72sACgkQJNaLcl1U
h9AxzAf/Ys7JElKki9A5mFI+I/HvoapP5WVYJNn5ppsCL/Dr6gn1KkfoZxqx7csY
OC1getUOZyrh8/6iqxWKOyyfd6M7wi/CrRYVyRVRnKngH9f9B92K8cKa8HQI3o2t
MvTmnMvg4w0Cpb3scmXznUv6XjdE7pkjHiK4A5OQ2KjiJqjXmqvo7OEOr/D4FNEn
VOMJOG7zCxIfqS121p9ko65ovDfgvrT5FeJBuHeURQkIKXphtP2W5NzwitML4c4H
wBqJd7ZwkikVYzZOSdAXRVQY6huD79jPrbERTp9bDIrEkFsDO47Q9XmxCnl1A4gs
lz5u3eUIF++Y/RxoX9dxNSj4Zh7DTg==
=Bm0n
-----END PGP SIGNATURE-----

--bvpm8AcR9ruTek1u--
