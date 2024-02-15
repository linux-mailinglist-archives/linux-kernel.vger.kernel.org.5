Return-Path: <linux-kernel+bounces-66390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A76855C07
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 094F41F212E1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CF012B90;
	Thu, 15 Feb 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b="ABpf9BJF"
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [94.124.121.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F8411702
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.124.121.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707984571; cv=none; b=jq4VO6Q4/SrX8XPWldx27Gt41IKEx5LMMzKUpCZB7NvwIQq2M/WPlEN7dKpHPJz+Cch2wNwvTVsasSwAs1ccXdlgPKWbAGl0PZmuzSup839rddHFKq/CMIE0E3jpKPhZmZF0QSJkSsWZgDSMfTwY9Md5ejjgRDT47LunhTTwbh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707984571; c=relaxed/simple;
	bh=rvQ+BGvz4Ur3Y3yGG6aT2h/S6cdZvcGtvjc69nxLSmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WrxG2Cd3eug922lBHCfRU1zwx7eZWqszDtCQa132nOCCy0aXqw5uqfNaFz3A+KQL0/A4VQ5ycG8YChdfwbWrJ/hDLNRKOIAApUrbp+UA+n/1GmCRvqVAzS2T3BwrdcbVUi4CSf9zvTrrB3Z8ID+qP82p8ZAxYoaxcfICBiVMnoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl; spf=pass smtp.mailfrom=protonic.nl; dkim=pass (2048-bit key) header.d=protonic.nl header.i=@protonic.nl header.b=ABpf9BJF; arc=none smtp.client-ip=94.124.121.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=protonic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonic.nl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=protonic.nl; s=202111;
	h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
	 message-id:subject:cc:to:from:date:from;
	bh=fNfrKgN3kLObdycvA/+kY7RqzkR6TPDMJgFqmqIeLZ8=;
	b=ABpf9BJF2XW8rQnAHZShtEsCvWTovWqO9KGW1M9yXTygOEPPe3r++vfHI14nJ3D/QQVCg1E2orsrP
	 MXMjumKRqtFUfK5B56ep4KQJrQE+ZyiXv2WFGsMlUnsjhYQmpE//UIvM93X7RYhZSvuvklSheQYs3z
	 +OC5qEFGNErGqES1VJnCsjA6pUTqeJ1O/YJaIEVp4pn4oYRrUjuFrGHMUAsXNwWm7VRKk1yFJt9FZA
	 KYidvQlhy9MpZLuwHv3w7kHB/7VCjcvE/j+s8OHwAZcTxbvrL7WIdJaSWzPzXS+imhaFZsKRcmPKv7
	 qilOUfwf1ubeuqZVv4rXg20BLHiazsw==
X-MSG-ID: 847ace45-cbd9-11ee-ba6d-0050568164d1
Date: Thu, 15 Feb 2024 09:09:18 +0100
From: Robin van der Gracht <robin@protonic.nl>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Andy
 Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Paul Burton <paulburton@kernel.org>
Subject: Re: [PATCH v2 11/15] auxdisplay: ht16k33: Move ht16k33_linedisp_ops
 down
Message-ID: <20240215090918.31ac2006@ERD993>
In-Reply-To: <20240212170423.2860895-12-andriy.shevchenko@linux.intel.com>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
	<20240212170423.2860895-12-andriy.shevchenko@linux.intel.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 19:01:44 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> We will need the update functions to be defined before
> ht16k33_linedisp_ops. Move the latter down in the code.
> No functional change intended.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/auxdisplay/ht16k33.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/auxdisplay/ht16k33.c b/drivers/auxdisplay/ht16k33.c
> index 0cdf3fbdf81e..75c4a8d31642 100644
> --- a/drivers/auxdisplay/ht16k33.c
> +++ b/drivers/auxdisplay/ht16k33.c
> @@ -440,18 +440,6 @@ static void ht16k33_keypad_stop(struct input_dev *dev)
>  	disable_irq(keypad->client->irq);
>  }

Acked-by: Robin van der Gracht <robin@protonic.nl>

