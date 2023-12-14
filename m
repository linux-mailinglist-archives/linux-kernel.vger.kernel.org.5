Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205B7812DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443965AbjLNK5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443821AbjLNK44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:56:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F971FDA
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 02:56:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22312C433C7;
        Thu, 14 Dec 2023 10:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702551365;
        bh=D5o6l3wN/A0AzdkfzCJLlF4j6x2lNjUAr69eYDp9ii8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ROTiuxiKLcUEU/QgjAwxSE4yOVU17cC9b+JrpyXCCup4tV3vGYkuRvaCeK6CUUo86
         tY3vdb/BMDcLXOEX8y+andPDbXg46+25Twq3jFqFAJ4JdLxa2N2Jdj0cBZcF+KDss/
         W1AwdGQ9Taqzu7y7k7uFZx7E0Lu4r2f/36pp9EPJiKBgg8IVc8N/RghxCWjkS1clMU
         K+hx/jc+EtsKOX8wQxYP61mb0ekENbdZhS+VKxB2HKdZ1NgsUlzI1kflyUC+lPeaLw
         25hYBkZetNk1/vSNJ6a0A+Gk+G398Yqe9ZVIf4CEdWZV4TLfYNsh4Jb6lzPTjEnfuq
         dbhDlpN1niNrA==
Date:   Thu, 14 Dec 2023 10:56:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: SOF: Move sof_of_machine_select() to core.c from
 sof-of-dev.c
Message-ID: <32f59e8e-2dc6-4fab-b32f-0220c99ff0ef@sirena.org.uk>
References: <20231204033549.2020289-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="usW1bNavSoBzSGhB"
Content-Disposition: inline
In-Reply-To: <20231204033549.2020289-1-wenst@chromium.org>
X-Cookie: Don't get mad, get interest.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--usW1bNavSoBzSGhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 04, 2023 at 11:35:47AM +0800, Chen-Yu Tsai wrote:
> This reverts commit 014fdeb0d747304111cfecf93df4407c1a0c80db.
>=20
> Commit 014fdeb0d747 ("ASoC: SOF: Move sof_of_machine_select() to
> sof-of-dev.c from sof-audio.c") caused a circular dependency between
> the snd_sof and snd_sof_of modules:

This doesn't apply against current code, please check and resend.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--usW1bNavSoBzSGhB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV63z8ACgkQJNaLcl1U
h9BYqwf7BnnlFFe8IXBcVnwVe89isLMqt2rcFs/1QluSDslQblODxH85D2e9f4j/
Da/uLb41osW6b4vs5uJf4L5kEfmMdtMO+BIc7/OFTmWO0Euv8xB+g0kqFL0bQ091
hNg0pQuXpNiV2lMBwxvUp7aTBWdXD3Sf/OhuaPhMzH1t3mRyB6xW55b9Cwsar9Pn
hmb0sCGiMFBpwrtQff1WQBS1QQ6A4cBWbyvWpgUxHJQEpyV8trjv+t81NxN9ycfx
ydzrEwd0caLFhw4LOT6k8Ao6A6IGloWwIpPNAeHGX6uuz6s6c8Bhzg4YG9UjvzNI
kwQsNa+9F3ex+XtTfnIhYZoYth64IQ==
=jtvh
-----END PGP SIGNATURE-----

--usW1bNavSoBzSGhB--
