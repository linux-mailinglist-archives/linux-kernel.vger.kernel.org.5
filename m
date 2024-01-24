Return-Path: <linux-kernel+bounces-37418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC10D83AFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DF23285CA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFACC12A17F;
	Wed, 24 Jan 2024 17:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzpFWfp6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0C37F7C4;
	Wed, 24 Jan 2024 17:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116942; cv=none; b=hBeIYGRlsjx5r9FV+aaqIxJhvT7L3FPMpEEC29PbrIbpEO56NeeSlh/GAUxBNxSS7m+MeW7ph/paj107VerDkY9VmPuIxEOZ8ZFPsCVwi17uoswACfHGB5z+LmEkzn4850FPD2Bx1klxIOWYFPTedHXW+omxEV/ge8MQo71jBhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116942; c=relaxed/simple;
	bh=J9cWHBzQAtoEqppKJznkEOwXANl/OtQJlMreI+w5+pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyplCo+6wUwP4Ld+g90II4utX7SzLDxkNtk9cI8u2vTFH0zidK/E2mvXh8Y3B9p7+u+ZxvBi8fSmAAt4CCreowdBP5KED2t+aK9wtIxEnqqGchftgLiM/zAQQvN6MvKJ7SiaYGv0bJBMQgQDOtiaCc8i4R1ZGD87VIgHc8YAoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzpFWfp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF93C433C7;
	Wed, 24 Jan 2024 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706116940;
	bh=J9cWHBzQAtoEqppKJznkEOwXANl/OtQJlMreI+w5+pM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LzpFWfp68rpr4dWHpdN+3IBhvKe1BMer+To6gMN52sFIqJGOHOg2ldSKjRXCcMb5m
	 TFWNLUoV1HFSfX27ssqcTmUNGmLjfsu/z7ab3gxQuXnjvSNFUQXmjhZEIyIhUWWEIT
	 CgAYNmzcDLnvRg+viWfwfm6By4Ffbj0ymjEy26C89CVOqr6JLR32V+zT7k2ef93fpP
	 1Ka1oOBMomGGEuXbLQOuhLohRSeVfalTXlkn0w18Bo0vP0gpL8EpG8vIchAhQdEue3
	 Cd0Kc25AAqNkrZ3Jhe5TUtRkxqZmjaKSQ074XXZPz2CPZUgeNzrq5mcjx4JO7BaCUH
	 nqaKOF7sEH13g==
Date: Wed, 24 Jan 2024 17:22:00 +0000
From: Mark Brown <broonie@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	kernel@pengutronix.de, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
	Rayyan Ansari <rayyan@ansari.sh>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, Sergey Kozlov <serjk@netup.ru>,
	Arnd Bergmann <arnd@arndb.de>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-mmc@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Michal Simek <michal.simek@amd.com>,
	Amit Kumar Mahapatra via Alsa-devel <alsa-devel@alsa-project.org>,
	linux-mtd@lists.infradead.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Ronald Wahl <ronald.wahl@raritan.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	chrome-platform@lists.linux.dev, Max Filippov <jcmvbkbc@gmail.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mediatek@lists.infradead.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-staging@lists.linux.dev, Viresh Kumar <vireshk@kernel.org>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org, Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-usb@vger.kernel.org, Helge Deller <deller@gmx.de>,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Kalle Valo <kvalo@kernel.org>, Dmitry Antipov <dmantipov@yandex.ru>,
	libertas-dev@lists.infradead.org, linux-wireless@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>, James Clark <james.clark@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 00/33] spi: get rid of some legacy macros
Message-ID: <c1e38a30-5075-4d01-af24-ac684e77cf29@sirena.org.uk>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
 <2024012417-prissy-sworn-bc55@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FdGjmVpGJ74QDTu1"
Content-Disposition: inline
In-Reply-To: <2024012417-prissy-sworn-bc55@gregkh>
X-Cookie: To err is human, to moo bovine.


--FdGjmVpGJ74QDTu1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 09:13:49AM -0800, Greg Kroah-Hartman wrote:
> On Mon, Jan 22, 2024 at 07:06:55PM +0100, Uwe Kleine-K=F6nig wrote:

> > Note that Jonathan Cameron has already applied patch 3 to his tree, it
> > didn't appear in a public tree though yet. I still included it here to
> > make the kernel build bots happy.

> Are we supposed to take the individual changes in our different
> subsystem trees, or do you want them all to go through the spi tree?

Given that the final patch removes the legacy interfaces I'm expecting
to take them via SPI.

--FdGjmVpGJ74QDTu1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWxRzcACgkQJNaLcl1U
h9CS5Af+OPZh7Z4aM5AF1TAMNJebJxrwbV+lfEa8zsdVnpHBXYpXokCrVwsSRBtM
yR/bt2+OoZjrVep6c0lufmewH58kEtQF4UazYao7MD2alCnwzn49m697Ubpnc/k9
iSCRd+E5ICMZuRdRrDAmd/To7o3jsg85SeN4qLdeer17NkjU6VS9vR6NlzImV/nS
MXj52eAHL5+EZIpIlwZSBkCxyEEsz/UFaGcFsKMonZ+24Oz5SXXWFhUWfiFCD+fA
DNZKxXJ9Vk2i5pCUsduff5giUUypwRqVP4C01wYMs7o3jkMZ2cQhtuH8iyDtKKMU
FSwO3bpbAgZzLbY2G2cqYZyEpqJ8Ow==
=E3cl
-----END PGP SIGNATURE-----

--FdGjmVpGJ74QDTu1--

