Return-Path: <linux-kernel+bounces-152249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3808ABB5D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 13:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 082DBB21358
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 11:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11E429CF3;
	Sat, 20 Apr 2024 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTJGGyme"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100C614AB0;
	Sat, 20 Apr 2024 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713612405; cv=none; b=oJ0/SQ+XUu5vj1xW2Vd56BM6LoFzU1NRdX4Y2N9iSagDOYLrg88hTOwb6O7nrl/tx7P6VoXvknEZhQBVVzpI8o+x2SLhdOm3saqSSOjUlzsJ9CdnoivyqzWVC0+YJ3acDyfle80xQ7bRR2elV5YPbEP+JRJLo/uOsI3goBOCuec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713612405; c=relaxed/simple;
	bh=W1jrRMAF9VcqBsPoRBvKtSWvA7+W/9752WNwN1ubh+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbeYQ5qukREQPQF5utXpFbKlG6Yxt8z9DE/CRWgXvNFX7MDzeEmgugKZYH85Ba7Pdb8PcEZJrymxPO3JnaC9dpfD9QlXY/NRnZEgO4T4tB33Dezr+UF9HwtSLG86BjFQTctvFdxBO/eI8M35qnFXb6WIH1xe/Esqm6oOfJK9OjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTJGGyme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEE4C072AA;
	Sat, 20 Apr 2024 11:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713612404;
	bh=W1jrRMAF9VcqBsPoRBvKtSWvA7+W/9752WNwN1ubh+Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nTJGGymeUy9DKgZqMHGlcn9M7gnOpuSK6AHkruq5vRLrojZtL6kNcaF/zleXd6v64
	 v4PVLQKeVWlB+redmB2LRnngAU4qh49+qUj213WelNmU0nTKvtAkJZ1BCdJJEydoAh
	 yendaF5khz6jiVmU0U48kD5+9YlwsQ/5EsloXqkK0lqMnCULIYQE7l6ltWa6mP37Lr
	 jJiQSd8CsKz8WOaM123dDihYv3EwcWYNlHQNkRoeKhPzQSDNFBxqGd7ezj4IlBq5Xu
	 OR51Bf/Isooy8o9jgOOCyV36UAdlGppGXNL4V1eUEz/lVnpSJRATp923rah23pwSzk
	 MEKpnfgFdzk2g==
Date: Sat, 20 Apr 2024 12:26:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Martijn Braam <martijn@brixit.nl>
Subject: Re: [PATCH v1 1/1] iio: light: stk3310: Drop most likely fake ACPI
 ID
Message-ID: <20240420122633.79b4185b@jic23-huawei>
In-Reply-To: <20240415141852.853490-1-andriy.shevchenko@linux.intel.com>
References: <20240415141852.853490-1-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 17:18:52 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> The commit in question does not proove that ACPI ID exists.
> Quite likely it was a cargo cult addition while doint that
> for DT-based enumeration.  Drop most likely fake ACPI ID.
> 
> Googling for STK3335 gives no useful results in regard to DSDT.
> 
> Fixes: 677f16813a92 ("iio: light: stk3310: Add support for stk3335")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Hi Andy,

It's been there quite a while (5 years) so whilst I agree it should
never have gone in without a known DSDT in the wild, I'm not sure we
should remove it at this point.

Definitely not with a fixes tag as I don't want to see this picked up
for stable and breaking some old consumer device we don't know about.

If there is a good maintenance reason to scrap these I'm in favour,
but if it's just tidying up errors from the past that have no
real impact then I'm not so sure.

Maybe we need a 'deprecated' marking for acpi ids that always prints
a message telling people not to make them up.  Mind you what would that
do beyond make us feel better?

Jonathan
> ---
>  drivers/iio/light/stk3310.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
> index 7b71ad71d78d..08d471438175 100644
> --- a/drivers/iio/light/stk3310.c
> +++ b/drivers/iio/light/stk3310.c
> @@ -693,7 +693,6 @@ MODULE_DEVICE_TABLE(i2c, stk3310_i2c_id);
>  static const struct acpi_device_id stk3310_acpi_id[] = {
>  	{"STK3310", 0},
>  	{"STK3311", 0},
> -	{"STK3335", 0},
>  	{}
>  };
>  


