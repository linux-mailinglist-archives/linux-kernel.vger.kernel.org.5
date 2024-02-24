Return-Path: <linux-kernel+bounces-79779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336B5862692
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EC621C2155E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D505482FF;
	Sat, 24 Feb 2024 18:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWCdyINQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCFF481AA;
	Sat, 24 Feb 2024 18:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708797867; cv=none; b=A7x4rV5Lynnue+822dRjf5mNiJCgo72bYuzeibfvugGVOZhCgoupJ9ttRGA+NtntW6mLkyTKGodQeG+ubKzITyqfIuGALiaIa+yeHtHZgu4b/NawQzlhskhXuK8D334/u3p/WdSh6vvTkf3RAMO9jKoIspN2hRlZ3IF9nXPnPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708797867; c=relaxed/simple;
	bh=QmT8MdCSr7KPTmwGSS0ilcphDzbBIWDJY5BB9pL8zdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oq8uUpdZZU02DIz4ZJbvOHEKnAHmm4w4RcHysEKEQcE2tnTdAyS+OSfWwYY350LoSiRvzX0P4tD7yZYAwOqlUEVbTx6RguR3G+xmcBNPXbCeAG1GUU2qnNfNq2LETROC4q04rg1TfMayMeoZt30HZU7K++4cg1Ejv7iu8S8q02Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWCdyINQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FF7C433C7;
	Sat, 24 Feb 2024 18:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708797867;
	bh=QmT8MdCSr7KPTmwGSS0ilcphDzbBIWDJY5BB9pL8zdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dWCdyINQw+nkabydQ0iEJyEdBNkaNvPVYuJ85EkWSKENRhW+Y3liD9ZQZ4c7IUQXW
	 Hat/iSXCglhCGbHAOq5gKYGhTcU+ve922qKd3fkEvjgK+RXjl8kPFLA3EDgY+rfs4K
	 NQeG7MMW9N9jLWV3hxLexv53GRPJ2vZZFJUttWDTq7d3fDjRvyHGCbAyE1KKOwOBjR
	 zneEC6fcQI9pmoHtt5+IqmKMyY4NMew+xA/bUt6lItFvAik9WJ9osf/y5QCpulNDVt
	 BFhaiFqMP9PtJseJhF9OiG6/pshAaDW0AiajCVJVvS6T/pC7hNOK0K7+PWZVr1Y4/L
	 8Zc/olHvqoBfg==
Date: Sat, 24 Feb 2024 18:04:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, ang.iglesiasg@gmail.com,
 andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drivers: iio: pressure: Sort headers of BMPxxx SPI
 driver
Message-ID: <20240224180412.0b23a105@jic23-huawei>
In-Reply-To: <20240220224329.53729-1-vassilisamir@gmail.com>
References: <20240220224329.53729-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 23:43:28 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Alphabetical sorting and separation of headers for the BMPxxx
> SPI driver.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Hi Vasileios,

No. This ends up as a dependency of the fix which will want backporting.
This would make it a non minimal change. As such the reordering comes
after the other patch (and not until it is upstream).

All that needed to happen was bits.h being first of the includes in the
fixes patch so that a sort later was minimal.  Doing that had no impact
on the complexity of the fix to backport so was just good code hygiene
in that would simplify the resort to follow.

Anyhow, dropping this for now.  Please send an update version
next cycle once the fix is upstream

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/bmp280-spi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index e8a5fed07e88..fd7ec6a5bca3 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -4,11 +4,12 @@
>   *
>   * Inspired by the older BMP085 driver drivers/misc/bmp085-spi.c
>   */
> -#include <linux/module.h>
> -#include <linux/spi/spi.h>
>  #include <linux/err.h>
> +#include <linux/module.h>
>  #include <linux/regmap.h>
>  
> +#include <linux/spi/spi.h>
> +
>  #include "bmp280.h"
>  
>  static int bmp280_regmap_spi_write(void *context, const void *data,


