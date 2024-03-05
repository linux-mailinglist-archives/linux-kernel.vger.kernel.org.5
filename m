Return-Path: <linux-kernel+bounces-91982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D7587195A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7525B1C22645
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820DA5381B;
	Tue,  5 Mar 2024 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="cneJRC1W"
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC234CB58;
	Tue,  5 Mar 2024 09:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.97.38.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709630138; cv=none; b=Vv/4saRXkE9JF+EXU6xauSviaeEZ1tD2R3LAJvTTaxI3XxsbweLQmgcQC6Y8c/Dij83/XgpF9/Ra5aWYqWCOtRfaFblBmy7Qj3ZrpmvjFH95EdlaxN6WESiyy5K33f3MdRcb9Zpi4keUY8vaHOd+/yyjIhs0IpCRD/qxVmCQboE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709630138; c=relaxed/simple;
	bh=IbzJMiuRl/06Ox7g/1p/ACiqfUkIoetzfNZUXvgf0qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwis69HtJddP0cXEKH786Ac6nxkjxEwLoNgeZbNLmgGDzY895IMhkKezbOaOOp1x8qoa7wlzLCoJe8TZhOlbnyoh6s5UgqjeIHnQAUcpetB3iAZJ6MVCsVB0L7AC115GgEZcT4yMWENm8I0rfVVL7QIaRn4wjnYJSDRiGbd1jdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=cneJRC1W; arc=none smtp.client-ip=88.97.38.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1709630128; bh=IbzJMiuRl/06Ox7g/1p/ACiqfUkIoetzfNZUXvgf0qs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cneJRC1WGR7VwfAsD80JHdv3PPGMSKuFJM/zFvGWS6wFwSPkZwCIZchwhnC5cOkXS
	 xT59ca/+YaqhvkbtUWvy5sN6tdxMdYtqCKuecvF8DDjIIRo2hwlmNLOzyP85HjU5dh
	 kPE5I1nO7azEdYEX4SaJPpxhZ15hg48p91ASPchpOSTrihLYtjKkKtlcbZ2M/2IOwR
	 JDcYwnGIjruUamx2+M5cH9M1vsyknDISp08LQA8vecV0l3AEaL1WGYijykeRqNvBel
	 s9yrT0HxyeXFwFQF92/s/9W/BGYNZ6D9DHpsOF+Azu7Pa5/d6DBRABSmyMhEdLyJfB
	 oSasSzO0FB17A==
Received: by gofer.mess.org (Postfix, from userid 1000)
	id 9F7231000B8; Tue,  5 Mar 2024 09:15:28 +0000 (GMT)
Date: Tue, 5 Mar 2024 09:15:28 +0000
From: Sean Young <sean@mess.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v1 1/1] media: ir-spi: Remove unused of_gpio.h
Message-ID: <ZebisPvr_eFPm_0o@gofer.mess.org>
References: <20240304180331.1200827-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304180331.1200827-1-andriy.shevchenko@linux.intel.com>

On Mon, Mar 04, 2024 at 08:03:31PM +0200, Andy Shevchenko wrote:
> of_gpio.h is deprecated and subject to remove.
> The driver doesn't use it, simply remove the unused header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/rc/ir-spi.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/media/rc/ir-spi.c b/drivers/media/rc/ir-spi.c
> index bbc81bed4f90..8afc3cd70b87 100644
> --- a/drivers/media/rc/ir-spi.c
> +++ b/drivers/media/rc/ir-spi.c
> @@ -8,7 +8,6 @@
>  #include <linux/fs.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
> -#include <linux/of_gpio.h>

This does not build, I get errors saying of_property_read_bool() is undefined.
I think we need linux/of.h instead of linux/of_gpio.h.


Sean

>  #include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
>  #include <media/rc-core.h>
> -- 
> 2.43.0.rc1.1.gbec44491f096

