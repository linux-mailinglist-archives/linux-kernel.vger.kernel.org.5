Return-Path: <linux-kernel+bounces-8814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8C881BCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04B2C286C99
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDDF59917;
	Thu, 21 Dec 2023 17:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tk3+QT11"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481858219;
	Thu, 21 Dec 2023 17:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BC9C433C9;
	Thu, 21 Dec 2023 17:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703178595;
	bh=fwWCA+/2aNcUtFGWesDvkOAlr50KRVlrQSFAaNv6f9w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tk3+QT113I1oYUZMMPaCJv6aQD9JNepfNeiVHJRf3tcgRTr60NC8rU7iOzsADJZTq
	 Ktd700/TiviKuagT66UYZb1affGnP2IP4HnlMTKZSXifxk9hZRPj9fao03WNJEdkP0
	 c4soamHunNqMYLiCt9TJCGtY1N5jr2I1HRNfB8m342mFH15/4cdsRyRswE5kU78T/h
	 aE/SsjCRQyV/c7Po4x8s8VGvbijaE5MasDauNExRuXORlnWRQr+kygSwAUgdbBzVTW
	 XRWtz1HuuxeUtbwVzU0jX6JEqsemln2q2eOypJpoIkWsPJ9k33+Kt36d5KfY8J98sO
	 AauAmN3wWPtOg==
Date: Thu, 21 Dec 2023 17:09:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angel Iglesias <ang.iglesiasg@gmail.com>, Akinobu Mita
 <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: Add missing bmp085 to SPI id
 table
Message-ID: <20231221170941.38a0c15a@jic23-huawei>
In-Reply-To: <CACRpkdZqjX39knEMVnhZPCZZAF8YN0yDww5nvS0tEn_pP0R2fg@mail.gmail.com>
References: <20231220184753.6472-1-semen.protsenko@linaro.org>
	<CACRpkdZqjX39knEMVnhZPCZZAF8YN0yDww5nvS0tEn_pP0R2fg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Dec 2023 20:07:57 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Wed, Dec 20, 2023 at 7:47=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
>=20
> > "bmp085" is missing in bmp280_spi_id[] table, which leads to the next
> > warning in dmesg:
> >
> >     SPI driver bmp280 has no spi_device_id for bosch,bmp085
> >
> > Add "bmp085" to bmp280_spi_id[] by mimicking its existing description in
> > bmp280_of_spi_match[] table to fix the above warning.
> >
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > Fixes: b26b4e91700f ("iio: pressure: bmp280: add SPI interface driver")=
 =20
>=20
> Right! Thanks for fixing this Sam!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>=20
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

J
> Yours,
> Linus Walleij


