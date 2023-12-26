Return-Path: <linux-kernel+bounces-11568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 466EA81E845
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 17:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC76E1F23B2E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837604F5F3;
	Tue, 26 Dec 2023 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncXIt3XI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D028E4F5E1;
	Tue, 26 Dec 2023 16:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F53DC433C7;
	Tue, 26 Dec 2023 16:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703606599;
	bh=HoMZELXlpdrL9WlBHJaV2qiDNG7+Xz4JRKFkWqdFkSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ncXIt3XIXY4R4KruJCH+i8KZg/B7XkHMO5qc+jqpDUJemaanQ2e8XgtaNhXg8wdDw
	 0jrS8O6VHsRCmzRyGP0kmOLlfbrawUYiPBPltRZIFOS+yxCz+j0AeRlDyHju/nh7re
	 +DFpS7zpVWhHYjfJJcOudT4pnBEwMt/Q3hCTvdrJgVnzo+hPfQaoSUv2fWiuXUnpXt
	 KLiRs/qWzV4KN7q7EfXKQv9NUoCoIhuF27MGtwhGn4AKSRCHYyxBaChKN0xpNsuFyv
	 M0suIoDBcWRDDYQGmT1J9kR1BCJdqzi5UjTTJeJrRfBTZNkTYavtYiw0g2k9iA+egv
	 zjkbl0uwPrLkg==
Date: Tue, 26 Dec 2023 16:03:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: linux/iio.h: fix Excess kernel-doc description
 warning
Message-ID: <20231226160311.3db9ff73@jic23-huawei>
In-Reply-To: <20231223050556.13948-1-rdunlap@infradead.org>
References: <20231223050556.13948-1-rdunlap@infradead.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Dec 2023 21:05:56 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Remove the @of_xlate: lines to prevent the kernel-doc warning:
> 
> include/linux/iio/iio.h:534: warning: Excess struct member 'of_xlate' description in 'iio_info'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: linux-iio@vger.kernel.org
Applied.

Thanks,

Jonathan

> ---
>  include/linux/iio/iio.h |    6 ------
>  1 file changed, 6 deletions(-)
> 
> diff -- a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -434,13 +434,7 @@ struct iio_trigger; /* forward declarati
>   * @update_scan_mode:	function to configure device and scan buffer when
>   *			channels have changed
>   * @debugfs_reg_access:	function to read or write register value of device
> - * @of_xlate:		function pointer to obtain channel specifier index.
> - *			When #iio-cells is greater than '0', the driver could
> - *			provide a custom of_xlate function that reads the
> - *			*args* and returns the appropriate index in registered
> - *			IIO channels array.
>   * @fwnode_xlate:	fwnode based function pointer to obtain channel specifier index.
> - *			Functionally the same as @of_xlate.
>   * @hwfifo_set_watermark: function pointer to set the current hardware
>   *			fifo watermark level; see hwfifo_* entries in
>   *			Documentation/ABI/testing/sysfs-bus-iio for details on


