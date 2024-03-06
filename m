Return-Path: <linux-kernel+bounces-94603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DB2874204
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED2E7B2268F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 21:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265DE1B5A0;
	Wed,  6 Mar 2024 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2OAHOQoK"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8DD1B279;
	Wed,  6 Mar 2024 21:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709760823; cv=none; b=bzP9RwQW1HW17EMlk/vW2T5QdQ4eH6lbXDRo16K2hdCmZs/qsL97fEwJoQzDCOHUZoLz1TTHJ4tEZJBTAkRDNXd3oQNbcJDqkZEy7cURaoV/rgwaZoav2XbKr4uPyNbjmeV/cs95dlloygaeYbf7o3NV2fSxbl4kTQ1Txodb4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709760823; c=relaxed/simple;
	bh=WwtjLWIbHJ/TVHDFwIRnR16/fskHM4sGx3BEsNjsR0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5DVgRYPIUKpd6ygjtLlLv0nfp9Vf96X/EAQm5lHk/PUouSDjbgbIYPS98DovaMxzGtCodMDPtGrhqhpXR0fJP31tSZhDurTcLV2uoGTytoWTCjS+Sce4bd1depabYvrIde2qpy+Z7GvedR1IVWJO0TO38LkBkJPibMhYY5lu1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2OAHOQoK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=h3wE/+dLb1K+dVotenQ/b6hhlA2sOF3ioe/WmimHjKA=; b=2OAHOQoKOqw8hlNA4f06T0KCrN
	dTTBxlVCqjjd0GJqMVfsooRGu/VhXSzO9q93yBI4zYwd9bXJPLrj/0AUXowB4OAVR3j4jeOOGeCi7
	Ti30CGws98UnZktkTc0qlVcxMLOJt8bOddCyJmosb/gk1MS1oz1AGdJ/9Dk7abmG/5BeQm9KlWduA
	6Y8BI4M6RvAeU91mSYM1dsafQMjSPk42OKX9NbhVhGyMqKp/8Ai57YHpCTFIaeTdhr3e+e8OrLKI+
	2E2eqlhpF4Es5Lx4BFtsQxvA8fROA/b3KJi+8A63jTG4QJx6xORCtxutEg+LJ9zK7aIYgj3l96xC/
	nK8cWlYw==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhytP-00000001xO7-0Iyp;
	Wed, 06 Mar 2024 21:33:39 +0000
Message-ID: <b81edf65-45bd-4412-b373-16732a0d1abd@infradead.org>
Date: Wed, 6 Mar 2024 13:33:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: w1: Remove w1_gpio_platform_data
Content-Language: en-US
To: Ayush Singh <ayushdevel1325@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org,
 corbet@lwn.net
References: <20240306194629.356001-1-ayushdevel1325@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240306194629.356001-1-ayushdevel1325@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/6/24 11:46, Ayush Singh wrote:
> `linux/w1-gpio.h` was removed in a previous patch and should no longer be
> needed for using w1 gpio.
> 
> - Removal Patch: https://lore.kernel.org/all/cover.1701727212.git.u.kleine-koenig@pengutronix.de/
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>

Possibly add:
Fixes: 9c0a5b3f9e55 ("w1: gpio: Don't use platform data for driver data")

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/w1/masters/w1-gpio.rst | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/Documentation/w1/masters/w1-gpio.rst b/Documentation/w1/masters/w1-gpio.rst
> index 15236605503b..5d7eebc291bb 100644
> --- a/Documentation/w1/masters/w1-gpio.rst
> +++ b/Documentation/w1/masters/w1-gpio.rst
> @@ -20,7 +20,6 @@ Example (mach-at91)
>  ::
>  
>    #include <linux/gpio/machine.h>
> -  #include <linux/w1-gpio.h>
>  
>    static struct gpiod_lookup_table foo_w1_gpiod_table = {
>  	.dev_id = "w1-gpio",
> @@ -30,14 +29,9 @@ Example (mach-at91)
>  	},
>    };
>  
> -  static struct w1_gpio_platform_data foo_w1_gpio_pdata = {
> -	.ext_pullup_enable_pin	= -EINVAL,
> -  };
> -
>    static struct platform_device foo_w1_device = {
>  	.name			= "w1-gpio",
>  	.id			= -1,
> -	.dev.platform_data	= &foo_w1_gpio_pdata,
>    };
>  
>    ...

-- 
#Randy

