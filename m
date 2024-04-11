Return-Path: <linux-kernel+bounces-140477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A77D8A1533
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17660B22938
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B7C1494AF;
	Thu, 11 Apr 2024 13:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ee6KmjAa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD2D145330
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712840547; cv=none; b=dTSFfpmDaupdNxBImRj+XtVL1g2ZY9QfANxMG8BjzFKUZCJwJlElA41JANUd9UvKur1p1BUgVeuxvC45IX55p8d2VPbdsWzGax4wCPzGiS03xs1gCEpQVw8ProgPZOD1zgghz+2sVrJAMr5McyLYS4CB0bFR1ijVDies0uUi3VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712840547; c=relaxed/simple;
	bh=ESPFWmvyV872Cls+3qJkAOMORRylHqseq4oYKF5Kl6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQMkS29f8j3DcKTx9DKFwtk8KgwIuIuLIqHK6XkFYxK119ekS/RehjpnVHR7pTxt/aPK2qwdjkGUfNRF8sBhTe3ajsbNl6TJTs3q9qSZdRBMiwWYnrTuwmbTJT2T9Omru9azOPTMU7xKmTZZL8cYrk1NM3oZVlz4nWvcPQ8JqzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ee6KmjAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8D1C433C7;
	Thu, 11 Apr 2024 13:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712840545;
	bh=ESPFWmvyV872Cls+3qJkAOMORRylHqseq4oYKF5Kl6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ee6KmjAa0iU08hNRllNCEnQh0UApDES4rtN+e5IE7LAGD8HFeK2QEwjntD+qUM8AW
	 IjaB0Wd1j0wjJ6qE8T7kxieQV3mlO9zxSra9HUBoKwPoEo9FLMxDXxoxJqn+6Pua5z
	 /H8w6OU+v3lgnYG1XHwlemn3qlXETIZzfhKdxN58=
Date: Thu, 11 Apr 2024 15:02:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vamsi Attunuru <vattunuru@marvell.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] misc: mrvl-cn10k-dpi: add Octeon CN10K DPI
 administrative driver
Message-ID: <2024041152-symphony-strained-8370@gregkh>
References: <MW4PR18MB5244191AE625EE04141DAE2BA6272@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240312105657.1589333-1-vattunuru@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312105657.1589333-1-vattunuru@marvell.com>

On Tue, Mar 12, 2024 at 03:56:57AM -0700, Vamsi Attunuru wrote:
> --- /dev/null
> +++ b/include/uapi/misc/mrvl_cn10k_dpi.h
> @@ -0,0 +1,35 @@
> +// SPDX-License-Identifier: GPL-2.0

Wrong license for a uapi file, right?  Please work with your lawyers to
figure out the correct one if you have any questions.

> +/* Marvell Octeon CN10K DPI driver
> + *
> + * Copyright (C) 2024 Marvell.
> + *
> + */
> +
> +#ifndef __MRVL_CN10K_DPI_H__
> +#define __MRVL_CN10K_DPI_H__
> +
> +#include <linux/types.h>
> +
> +#define DPI_MAX_ENGINES 6
> +
> +struct dpi_mps_mrrs_cfg {
> +	u64 mrrs; /* Max read request size */
> +	u64 mps;  /* Max packet size */
> +	u64 port; /* Ebus port */
> +};
> +
> +struct dpi_engine_cfg {
> +	u64 fifo_mask; /* FIFO size mask in KBytes */
> +	u64 molr[DPI_MAX_ENGINES];
> +	u64 update_molr; /* '1' to update engine MOLR */

This is not how you create an ioctl, please read the kernel
documentation for how to do it properly please.  (hint, wrong data
types.)

Also, a pointer to the userspace code that is going to use this new api
you are creating would be apprecaited.

thanks,

greg k-h

