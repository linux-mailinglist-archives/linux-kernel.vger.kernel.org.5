Return-Path: <linux-kernel+bounces-51747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9270B848ED7
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 16:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2299E28359F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5BC225CB;
	Sun,  4 Feb 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxJbEc4O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0381E1B267;
	Sun,  4 Feb 2024 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707059778; cv=none; b=FDGKjVgOm8yNGol32E/du+xNETJBIi/dL421wcKnCQIxkwuy4A8Yh7Y+ehcjCT2zOq9W02PcpGhFoVQh29OWYVh7DCFn7hFtH61XaD8DNNuDrbysPqn0sNdcdut6Rjs5Lpcvp8Wp45ymjvYrvvnn/mYhU41IN8d4sy3XP8TYLHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707059778; c=relaxed/simple;
	bh=N+IZxtJrb//jVMwpX+DiymcG9TJlohHP740E/oZE8Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJdbjUTs2rTWSeoWGecP1RPQxc2fy5OW5pie9rq83HrQGpiExdBu73NTdhaSh3wBJer5hTCdYqZF0M7+sdCUxs2P1rr2/4qSmpEaM9EqPgmAoup77JAWdUDTvZi3edkVofr2GleAETm+OEG1dJYmzQdskvytG21kCrVGMLm8t4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxJbEc4O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE62C433C7;
	Sun,  4 Feb 2024 15:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707059777;
	bh=N+IZxtJrb//jVMwpX+DiymcG9TJlohHP740E/oZE8Iw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UxJbEc4OSbLAIY2rTIxMLKvB+fNuY546BD8KwacCDE7DOihzdP5KCbzCDXz/jxImX
	 IsuyvxNKqh/UgZ5R/GsqKZLrKX5Ncg6B0MsOHGdP4fhbU2LGxvYXl5JFW41n18kc7i
	 FoFNAnf33DOb7N+06+41RsFP5TG5xva+9dv2n54/EweQqsqXLIiyNKkXv8vcLoX4W8
	 b9ln8ZYJ4mfTUUnWPjYVs+xx/nsh5ZPpTF72GBS/lSfWyv/+o9pezllT9ieLUw2vhh
	 1SjaXez2IfJYH6myACtgy82LrwJ6CQhF6Al55Jc/RETPTIC3iCRaUnjguUIia91HVy
	 1B4qeBT9+H9Dw==
Date: Sun, 4 Feb 2024 15:16:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "open list:IIO SUBSYSTEM AND
 DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: accel: Fix a compilation problem
Message-ID: <20240204151605.237eb2a4@jic23-huawei>
In-Reply-To: <20240131225246.14169-1-mario.limonciello@amd.com>
References: <20240131225246.14169-1-mario.limonciello@amd.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jan 2024 16:52:46 -0600
Mario Limonciello <mario.limonciello@amd.com> wrote:

> The kernel fails when compiling without `CONFIG_REGMAP_I2C` but with
> `CONFIG_BMA400`.
> ```
> ld: drivers/iio/accel/bma400_i2c.o: in function `bma400_i2c_probe':
> bma400_i2c.c:(.text+0x23): undefined reference to `__devm_regmap_init_i2c'
> ```
> 
> This was caught with one of the kconfigs used by the LKP robot for a
> separate issue.
> 
> Link: https://download.01.org/0day-ci/archive/20240131/202401311634.FE5CBVwe-lkp@intel.com/config
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Good catch.  Ideally would have a fixes tag but it's a bit complex in this
case as they two parts landed in different series.
I've added both tags and marked it for stable.

Fixes: 465c811f1f20 ("iio: accel: Add driver for the BMA400")
Fixes: 9bea10642396 ("iio: accel: bma400: add support for bma400 spi")

> ---
>  drivers/iio/accel/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 91adcac875a4..c9d7afe489e8 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -219,10 +219,12 @@ config BMA400
>  
>  config BMA400_I2C
>  	tristate
> +	select REGMAP_I2C
>  	depends on BMA400
>  
>  config BMA400_SPI
>  	tristate
> +	select REGMAP_SPI
>  	depends on BMA400
>  
>  config BMC150_ACCEL


