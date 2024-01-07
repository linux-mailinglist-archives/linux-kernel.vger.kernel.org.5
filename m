Return-Path: <linux-kernel+bounces-18900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715278264DD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805681C20C1D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 15:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88EC213AD8;
	Sun,  7 Jan 2024 15:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/e/N/Qm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDF413AC0;
	Sun,  7 Jan 2024 15:58:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790FBC433C8;
	Sun,  7 Jan 2024 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704643127;
	bh=hyV0n3TYTzj8XaPqJZ9Snjs6Ou2KsAmUpPfk6+9Pr9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D/e/N/QmNbh7aW5o13q79Qm9OfG62hFAxnlmxyhm51wA8sGhTYf40U+iSz9jOyguD
	 5nzb5zElE6FLYiQC3nwQa2vKJPfIV5jDuL7lhD7Z/DP4uHKmNWI2ZgL14kOb/gKs7S
	 /Y6Ge1fTTrzUqpRZAlPuHgLp6o9yowOBdlZkx7HzMOgIThC5wKbmOfSYndI7yMZiqP
	 /r6DWCXtnLoycW8MFQj+1cZV4aOpEb6mhoqkZto00PeYeT2jOT34ReRTo9ffBkx51D
	 1vnPy3hMmLc0PMD5uYV1DkFIxlKRMcTPX5Wx8JoWhfRfmc6n4x/T6O0FGsoB8iLq8q
	 /k0HRKLQ1Xgaw==
Date: Sun, 7 Jan 2024 15:58:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Christian Eggers <ceggers@arri.de>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 0/3] iio: light: add support for AMS AS7331
Message-ID: <20240107155838.376bdd1e@jic23-huawei>
In-Reply-To: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
References: <20240103-as7331-v2-0-6f0ad05e0482@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 03 Jan 2024 13:08:50 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The AMS AS7331 UV light sensor measures three ultraviolet bands (UVA,
> UVB and UVC, also known as deep UV or DUV) as well as temperature.
> 
> This device is practically identical to the AMS AS73211 XYZ True Color
> sensor that is already supported by the iio subsystem, except for the
> photodiodes used to aquire the desired light wavelengths.
> 
> In order to reuse code and reduce maintenance load, this series extends
> the AS73211 driver to support the AS7331 as well.
> 
> Note that the UVA and UVB light modifiers have not been merged into the
> mainline kernel yet, but they are already available in Greg's char-misc
> git tree which can be found at
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
> in the char-misc-next branch.
> 
> The original device AS73211 supported by the driver could only be tested
> briefly due to the lack of hardware. Instead, the i2c-stub module has
> been used to make sure that the driver registers the iio device properly
> and the attributes exported to sysfs are correct. Some basic register
> assignments reported the expected intensity scales and in principle
> nothing else should have been affected by the modifications in the code.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

Series applied - but given timing I'll only push this out as testing for
now as I'll want to rebase the IIO tree on rc1 once available in a couple of
weeks time.

Thanks,

Jonathan

> ---
> Changes in v2:
> - as73211.c: Use IIO_VAL_FRACTIONAL to retrieve scales of AS73211.
> - as73211.c: simplify device-specific data retrieval in probe function.
> - as73211.c: minor coding-style fix (shorter line).
> - Link to v1: https://lore.kernel.org/r/20231220-as7331-v1-0-745b73c27703@gmail.com
> 
> ---
> Javier Carrasco (3):
>       iio: light: as73211: use IIO_VAL_FRACTIONAL for intensity scales
>       dt-bindings: iio: light: as73211: add support for as7331
>       iio: light: as73211: add support for as7331
> 
>  .../devicetree/bindings/iio/light/ams,as73211.yaml |   7 +-
>  drivers/iio/light/Kconfig                          |   5 +-
>  drivers/iio/light/as73211.c                        | 142 +++++++++++++++++----
>  3 files changed, 123 insertions(+), 31 deletions(-)
> ---
> base-commit: e9215fcca2561b208c78359110ee4009b454f761
> change-id: 20231220-as7331-88a25ceeb66d
> 
> Best regards,


