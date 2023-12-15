Return-Path: <linux-kernel+bounces-1359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F12814DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85A1284760
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2152F3FB36;
	Fri, 15 Dec 2023 17:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ORQ+4YXq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E9C3FB0B;
	Fri, 15 Dec 2023 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9qcX9KuXgoERlz1kjtjKG7ROeacwCAgo0vP8jCcr9Ec=; b=ORQ+4YXqvsUSjuX0YGzYHrBr1k
	CQckn5EBhLVUtwbxr4rD8GCpW3vuoLNYUDgHZW6W0sD78vwT+AyKuG765zUacgXkBYvwKc4V159er
	ANgDEMQA09+xgjpgxoM3/iE85nZstnlXwb1ci8IjcWgPxd1+QiJrszty8loN7lASBfiB6VRkL0ur5
	nZy1dQLiU6JbzPQfZsC7heTAe2MrMpFHKEVNFDABZsGTxKU3co897RYFA9dJfZ1nCwujnqcEndRfa
	g+IeiAY+xoEz1kzRNHbSHsnPfrEYan/5O1Ch9Xn/WPY+VARGeIULkAUyRRhOyxI6YpOEt2wCzBKfN
	8VyK0goQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rEBgV-003zF6-35;
	Fri, 15 Dec 2023 17:09:11 +0000
Message-ID: <f47bba41-a2a6-404d-8bd6-b67bf7d369b2@infradead.org>
Date: Fri, 15 Dec 2023 09:09:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] gpio: xilinx: remove excess kernel doc
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
 Srinivas Neeli <srinivas.neeli@amd.com>, Michal Simek
 <michal.simek@amd.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Marc Zyngier <maz@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 kernel test robot <lkp@intel.com>
References: <20231215090943.9245-1-brgl@bgdev.pl>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215090943.9245-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/15/23 01:09, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The irqchip field has been removed from struct xgpio_instance so remove
> the doc as well.
> 
> Fixes: b4510f8fd5d0 ("gpio: xilinx: Convert to immutable irq_chip")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202312150239.IyuTVvrL-lkp@intel.com/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  drivers/gpio/gpio-xilinx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-xilinx.c b/drivers/gpio/gpio-xilinx.c
> index 823198368250..7348df385198 100644
> --- a/drivers/gpio/gpio-xilinx.c
> +++ b/drivers/gpio/gpio-xilinx.c
> @@ -52,7 +52,6 @@
>   * @dir: GPIO direction shadow register
>   * @gpio_lock: Lock used for synchronization
>   * @irq: IRQ used by GPIO device
> - * @irqchip: IRQ chip
>   * @enable: GPIO IRQ enable/disable bitfield
>   * @rising_edge: GPIO IRQ rising edge enable/disable bitfield
>   * @falling_edge: GPIO IRQ falling edge enable/disable bitfield

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

