Return-Path: <linux-kernel+bounces-48887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C63C8462D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1B928E015
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ABC3FE3D;
	Thu,  1 Feb 2024 21:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYhAJw//"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0F39AE1;
	Thu,  1 Feb 2024 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824053; cv=none; b=Uak3q6fovuTrGQ6irIPfGICYVR6/6afdPLjz5lGScydMdAvIKR/Ha7ZIPGsrj8heY0Ul5oFuu9USIkaIAmsbS2Wh/ipeb4gjhrXDLzP7rEYiWVRvrELSdlwX1XSIfR1w2P79RKfrvzAbn89EXGPA6OMhjEYh+YXMgar4h6gDgzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824053; c=relaxed/simple;
	bh=ONdXqAS27cKeOgWX4XGTKCxg4rE0mzWElHVnnYMMb0Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=khxhwSxLDnLzjIdYRf0JZGlz3N+SgDTU1UeUf+6SBoSQeUBK47wAcA3uuk18bvU3k9yTfrG83HMqz2/VEq/jaA28iuim+dgoqHSgNBcucMECnn/FwC7u904JZr5lKQUlIl0uxu6CALvToLATsy7OmaqQxjriTPztTHU9S2cVVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYhAJw//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEB5C433C7;
	Thu,  1 Feb 2024 21:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706824052;
	bh=ONdXqAS27cKeOgWX4XGTKCxg4rE0mzWElHVnnYMMb0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYhAJw//yARcM3TA6pVCkI4LUiBLE5XWbQdyIJ2IOE9XeeW9PXuRT0u1fpPxxrkwp
	 Hurjt/dBf8xwi23T1FksMdv9e36XHyjvhrDNFhBSr1xRnTYLMYbJE3ILCL/Xokm/MD
	 5zQO0eFXQidwjXeacacwmmo5pMdGivYcXVl5OsSlyzb4uDD6zF3QHkW/ipNCSyCrkX
	 ruFySuh4tDJV4Rf4YFiYpBgTsdWdhvZKAcl5M+3wneiWVFJ2zo1QtBfWDecyRoxa73
	 fETXEmGDyXWVSu/j1Xloaznpi7OcrAoyx70CgInqn+hTw2H52XDK3rA5SorsXzUwVT
	 KByKrTZWMbAOA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Feb 2024 23:47:13 +0200
Message-Id: <CYU2MG4IOJ0Q.2UJOTK999FCCC@suppilovahvero>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mark Brown" <broonie@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 <kernel@pengutronix.de>, "Moritz Fischer" <mdf@kernel.org>, "Wu Hao"
 <hao.wu@intel.com>, "Xu Yilun" <yilun.xu@intel.com>, "Tom Rix"
 <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexander Aring" <alex.aring@gmail.com>,
 "Stefan Schmidt" <stefan@datenfreihafen.org>, "Miquel Raynal"
 <miquel.raynal@bootlin.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-wpan@vger.kernel.org>,
 <netdev@vger.kernel.org>, "Lars-Peter Clausen" <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, "Jonathan Cameron"
 <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Dmitry Torokhov"
 <dmitry.torokhov@gmail.com>, <linux-input@vger.kernel.org>, "Ulf Hansson"
 <ulf.hansson@linaro.org>, "Rayyan Ansari" <rayyan@ansari.sh>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>, "Martin Tuma"
 <martin.tuma@digiteqautomotive.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, <linux-media@vger.kernel.org>, "Sergey Kozlov"
 <serjk@netup.ru>, "Arnd Bergmann" <arnd@arndb.de>, "Yang Yingliang"
 <yangyingliang@huawei.com>, <linux-mmc@vger.kernel.org>, "Richard
 Weinberger" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob
 Herring" <robh@kernel.org>, "Heiko Stuebner" <heiko@sntech.de>, "Michal
 Simek" <michal.simek@amd.com>, "Amit Kumar Mahapatra via Alsa-devel"
 <alsa-devel@alsa-project.org>, <linux-mtd@lists.infradead.org>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>, =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 "Simon Horman" <horms@kernel.org>, "Ronald Wahl" <ronald.wahl@raritan.com>,
 "Benson Leung" <bleung@chromium.org>, "Tzung-Bi Shih" <tzungbi@kernel.org>,
 "Guenter Roeck" <groeck@chromium.org>, <chrome-platform@lists.linux.dev>,
 "Max Filippov" <jcmvbkbc@gmail.com>, <linux-spi@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Bjorn Andersson"
 <andersson@kernel.org>, "Konrad Dybcio" <konrad.dybcio@linaro.org>,
 <linux-arm-msm@vger.kernel.org>, "Matthias Brugger"
 <matthias.bgg@gmail.com>, "AngeloGioacchino Del Regno"
 <angelogioacchino.delregno@collabora.com>,
 <linux-mediatek@lists.infradead.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, "Javier Martinez Canillas" <javierm@redhat.com>,
 "Amit Kumar Mahapatra" <amit.kumar-mahapatra@amd.com>,
 <dri-devel@lists.freedesktop.org>, <linux-fbdev@vger.kernel.org>,
 <linux-staging@lists.linux.dev>, "Viresh Kumar" <vireshk@kernel.org>, "Rui
 Miguel Silva" <rmfrfs@gmail.com>, "Johan Hovold" <johan@kernel.org>, "Alex
 Elder" <elder@kernel.org>, <greybus-dev@lists.linaro.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>, "Herve Codina"
 <herve.codina@bootlin.com>, "Alan Stern" <stern@rowland.harvard.edu>, "Aaro
 Koskinen" <aaro.koskinen@iki.fi>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@linaro.org>, <linux-usb@vger.kernel.org>, "Helge
 Deller" <deller@gmx.de>, "Dario Binacchi"
 <dario.binacchi@amarulasolutions.com>, "Kalle Valo" <kvalo@kernel.org>,
 "Dmitry Antipov" <dmantipov@yandex.ru>, <libertas-dev@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "James Clark" <james.clark@arm.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v2 00/33] spi: get rid of some legacy macros
X-Mailer: aerc 0.15.2
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
 <2024012417-prissy-sworn-bc55@gregkh>
 <c1e38a30-5075-4d01-af24-ac684e77cf29@sirena.org.uk>
In-Reply-To: <c1e38a30-5075-4d01-af24-ac684e77cf29@sirena.org.uk>

On Wed Jan 24, 2024 at 7:22 PM EET, Mark Brown wrote:
> On Wed, Jan 24, 2024 at 09:13:49AM -0800, Greg Kroah-Hartman wrote:
> > On Mon, Jan 22, 2024 at 07:06:55PM +0100, Uwe Kleine-K=C3=B6nig wrote:
>
> > > Note that Jonathan Cameron has already applied patch 3 to his tree, i=
t
> > > didn't appear in a public tree though yet. I still included it here t=
o
> > > make the kernel build bots happy.
>
> > Are we supposed to take the individual changes in our different
> > subsystem trees, or do you want them all to go through the spi tree?
>
> Given that the final patch removes the legacy interfaces I'm expecting
> to take them via SPI.

+1

least fuss approach

BR, Jarkko

