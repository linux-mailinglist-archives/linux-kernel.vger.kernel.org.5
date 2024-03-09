Return-Path: <linux-kernel+bounces-97974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DF18772A2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CFB0B21813
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6265B2C6B4;
	Sat,  9 Mar 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YO53GVUv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345F23741;
	Sat,  9 Mar 2024 18:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007753; cv=none; b=YNVcL3cpTUntKaqrvKA1OTcq0PrhymAgp0dSQUc31BSKWxI604G39UM6UFCc0A0Zdk/ZQjHyxAknHyuTVSRtIB5jfiN/WpkARlff53ITy3L8Os/k9FffNXxxYzsazr7oPmKx5SGiMUX40LP4kSTbTn0ofiwaMCdoAodB/PH7i1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007753; c=relaxed/simple;
	bh=KsNJRK30YRexf6tTEpqvy2ij5HCVsecJKh44sAsCnXo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JO4MvvprNOE4NGZ9nd1bbfRd8LxorsjYr4EfNnJwyZyHYg5uUaf8XGJyQfwA0CW6W4BDJ/eX5TQXYw1hRBSuMLW/wvRGUifSSa7fBcT8ELh4uS4gMo4V+WwioB8v8dKWiKkWX90BYb7G/FGBBLN7MK3t9yryD7NweMYfuSYOIOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YO53GVUv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA29BC433C7;
	Sat,  9 Mar 2024 18:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710007753;
	bh=KsNJRK30YRexf6tTEpqvy2ij5HCVsecJKh44sAsCnXo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YO53GVUvMbM6uwssX5dDPaLatj7JHM5AiX2wGLyHQzCXeGtt7TalXVJeU53EOJgPY
	 h0B3g70yD+NcPUMKRNKtMJED4nEDaLqk8BEHkWweoGR7A6yGVEX1Qoji8GwxCLKC3g
	 uPpPfL+hjWltJnZDMVT2sk7XulbtQB0R8GhHpRRuo+lmRrEC+EvCNGhKbODvP/VL2W
	 IBRoTzRWMbZM4iihKjkBK5n8+eW2/r9CtX5AZEQo1O2IBQpPe+eIKN68jqu1WOlypR
	 y7SVRO8NV0r2skvLGVlmKQZCNvjoECmARdS58Ey0oPMMeOAoC/6BpY5JutRv7pfmRx
	 7VXOo0uYXv5/A==
Date: Sat, 9 Mar 2024 18:09:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: pressure: BMP280 core driver headers sorting
Message-ID: <20240309180900.3d61fd31@jic23-huawei>
In-Reply-To: <20240303165300.468011-2-vassilisamir@gmail.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
	<20240303165300.468011-2-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  3 Mar 2024 17:52:57 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Sort headers in alphabetical order.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> ---
>  drivers/iio/pressure/bmp280-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index fe8734468ed3..29a8b7195076 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -27,20 +27,20 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/bitfield.h>
> -#include <linux/device.h>
> -#include <linux/module.h>
> -#include <linux/nvmem-provider.h>
> -#include <linux/regmap.h>
> +#include <linux/completion.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>

I'm fairly sure nothing from sysfs.h is used in this file so good to drop it.

> -#include <linux/gpio/consumer.h>
> -#include <linux/regulator/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h> /* For irq_get_irq_data() */
> -#include <linux/completion.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <asm/unaligned.h>
>  


