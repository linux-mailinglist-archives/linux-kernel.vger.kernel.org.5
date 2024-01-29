Return-Path: <linux-kernel+bounces-43445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B21118413F6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 21:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25DF1C23A32
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196F676026;
	Mon, 29 Jan 2024 20:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kl8smRR7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56314179AB;
	Mon, 29 Jan 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706558439; cv=none; b=AYxfOqgHez2UgxlaTWVNDzFnrvS+JyoNh9dC2mmEIuEe7mdiPcX9Eovdfe+w5ZxlWcg2RKyNmSTl9c7cxHyX7eNPQ/SQztBK7vok4EAYywWxNjBFdLgqsLi9bUZ1fJr3PlVH4rRRISH+3Dh9v/WTpJNf3BnGphVHQ5Guceo1xw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706558439; c=relaxed/simple;
	bh=C31f9kgHgCBHLfgf62xdSkCVJTlrGWi/a6jhdsgco0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jb8SRgGUKOIISNQk5GKdMlfu49FDKFKaSVvIMKuvMRJbVHiUDY9F9qQPLBlqaByeaUYfBfzjD2mVirBoKa9OuQXQpx5iLq28HpMslOkOfoXFxXkgZdNKfQwpgEJ6opfzfUJq58gptlWObIVGrBLHqdMQik+wzcp1LEHpwTH0aTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kl8smRR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 511FEC433C7;
	Mon, 29 Jan 2024 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706558438;
	bh=C31f9kgHgCBHLfgf62xdSkCVJTlrGWi/a6jhdsgco0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kl8smRR781c02QWcUKOMN5GkYs55RTgayDC+6RxWHQ6upbyDErDm7//rA8aKbkg5r
	 dTcry8nsG5mE/OiZF8AM/X0xs0ziztsOWw0VK5BwOuUkv1x+GCaFkj4ZnKkHZZaxgU
	 A6XvBNBVYRZ7sT9LX4Iy1+sp+BaJXa6ZanUkGwYJkEV1XqSnPRPw1qi0ROPzFCvAIo
	 RGlzeQOnXp2mdcqTWTbijyqOkI+7g5Vd4CKS4kaly40vVLiOg8SGc8n6x+3GRJuW0R
	 +EeVPqzxmicCC/ZR6XbDKx1Pa/oEUyslw3+NdxEzqQBpS30VeYwk2e6mJopW3EGAxs
	 hzfAM3pUqjA9g==
Date: Mon, 29 Jan 2024 20:00:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/2] iio: adc: ad7380: make ad7380_regmap_config static
Message-ID: <20240129200027.5a0ee6bb@jic23-huawei>
In-Reply-To: <20240129174150.655088-2-dlechner@baylibre.com>
References: <20240129174150.655088-1-dlechner@baylibre.com>
	<20240129174150.655088-2-dlechner@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jan 2024 11:41:49 -0600
David Lechner <dlechner@baylibre.com> wrote:

> ad7380_regmap_config is not used outside of ad7380.c, so make it static.
> 
> Fixes sparse warning:
> 
>      drivers/iio/adc/ad7380.c:205:28: sparse: sparse: symbol
>      'ad7380_regmap_config' was not declared. Should it be static?
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202401280629.5kknB57C-lkp@intel.com/
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I saw the report of this one and squished it in the original patch.

The second one I decide was a false positive so could wait a bit longer.
Still nice to get rid of that warning though.

> ---
>  drivers/iio/adc/ad7380.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> index 80712aaa9548..44b8b18ab213 100644
> --- a/drivers/iio/adc/ad7380.c
> +++ b/drivers/iio/adc/ad7380.c
> @@ -202,7 +202,7 @@ static int ad7380_regmap_reg_read(void *context, unsigned int reg,
>  	return 0;
>  }
>  
> -const struct regmap_config ad7380_regmap_config = {
> +static const struct regmap_config ad7380_regmap_config = {
>  	.reg_bits = 3,
>  	.val_bits = 12,
>  	.reg_read = ad7380_regmap_reg_read,


