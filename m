Return-Path: <linux-kernel+bounces-6852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A342F819E82
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:54:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450211F230AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4894B2231D;
	Wed, 20 Dec 2023 11:54:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FAE22304
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 519A01FB;
	Wed, 20 Dec 2023 03:55:01 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AE0C3F5A1;
	Wed, 20 Dec 2023 03:54:15 -0800 (PST)
Date: Wed, 20 Dec 2023 11:54:12 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: fuyao <fuyao1697@cyg.com>
Cc: Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 maijianzhang <maijianzhang@allwinnertech.com>
Subject: Re: [PATCH RESEND] iio: adc: sun4i-gpadc-iio: adaptation interrupt
 number
Message-ID: <20231220115412.65bbc8c7@donnerap.manchester.arm.com>
In-Reply-To: <YwdhTlk+9h+9Mrwm@scg>
References: <YxmR5SPPY18O7LaG@google.com>
	<YwdhTlk+9h+9Mrwm@scg>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 15:23:17 +0800
fuyao <fuyao1697@cyg.com> wrote:

Hi,

> __platform_get_irq_byname determinies whether the interrupt
> number is 0 and returns EINVAL.

can you please say what this fixes, exactly? Is something not working at
the moment? Can you please provide parts of the error message?

And maybe expand the explanation a bit more? For instance mention that the
identifiers are used as IRQ resource numbers, where 0 is treated specially.

Cheers,
Andre

> 
> Signed-off-by: fuyao <fuyao1697@cyg.com>
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  include/linux/mfd/sun4i-gpadc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mfd/sun4i-gpadc.h b/include/linux/mfd/sun4i-gpadc.h
> index ea0ccf33a459..021f820f9d52 100644
> --- a/include/linux/mfd/sun4i-gpadc.h
> +++ b/include/linux/mfd/sun4i-gpadc.h
> @@ -81,8 +81,8 @@
>  #define SUN4I_GPADC_TEMP_DATA				0x20
>  #define SUN4I_GPADC_DATA				0x24
>  
> -#define SUN4I_GPADC_IRQ_FIFO_DATA			0
> -#define SUN4I_GPADC_IRQ_TEMP_DATA			1
> +#define SUN4I_GPADC_IRQ_FIFO_DATA			1
> +#define SUN4I_GPADC_IRQ_TEMP_DATA			2
>  
>  /* 10s delay before suspending the IP */
>  #define SUN4I_GPADC_AUTOSUSPEND_DELAY			10000


