Return-Path: <linux-kernel+bounces-144133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4457C8A4238
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0D4E28228B
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687083F8C7;
	Sun, 14 Apr 2024 12:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="AZRzS+fw"
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A141E53F;
	Sun, 14 Apr 2024 12:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713096556; cv=none; b=qejIiKIZkwz3v7SKskzP+qQ6CoPXApVvAfUHYwWaMOF1bkMAjR74g4iOSqRSdI1PvGIUALx9PCamJeCusB8pGajrDrtQvRGyUbyNlZ6JgCr6D8lmFC0JTBxS0/olZKOS6ayIi6ngl/F42uhyH3b9XhYTpAYMGiOadScD0rQc2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713096556; c=relaxed/simple;
	bh=sZ6MvvpYLG2csFo5XgIBgIcSCOrtryJDcKj3GuzJ0Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krZqjKDlywPvtgPqhHzuhzHvVJJc4Z/JoI0cfW+YGpm6AdDya2/vKZcXrVMTQK/1Qh3avUvW3Gkpms21GnQ6r+V1nvm1P+oMHcw5X9HNJPFjSYqLME+15KliKp+Rc+Gs0i5roc/YhK3Cf/rhGl43AMRZBvqupXaRIJKYmAAJP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=AZRzS+fw; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vyfUrUVZekBJPvyfUrFamz; Sun, 14 Apr 2024 14:09:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713096551;
	bh=y4ec2/b3UC1Scrh9RirGlj8YTteHQuh4UxLRR7ROzEw=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=AZRzS+fwP3bEkhXZWpY0zYNMG98IEvLCLDs+FxNFr9EK5hcWLkSEruhrpuFGXfEo1
	 Eli5eiG8m4daOp+jhENuVikOeba67zSzDChHbuPjb7PwUvQcDqe/s7+VFEGEiBmabZ
	 okPwjlAn6a/ZrqeTmRcTRn0p9y8EXNpmvkUNK3Z7RotML+Nxgmf2cdHM2rq7taNVHZ
	 N13LGs0gyo3auQUowhWC8pFSPe6hlIfRl0M2VKPZQuEIWyEegYJvP9yHPnBjWvvEta
	 LxtNWKGMSWYUffVma5r17nq3BrjHo2oCo0+2XKtR69+Nd/Hj7g2BDEZZaLkk33DyWc
	 Pshryi+mvfBgg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 14:09:11 +0200
X-ME-IP: 86.243.17.157
Message-ID: <779bc8ae-0f24-4f34-8f20-633e6e6f2fc5@wanadoo.fr>
Date: Sun, 14 Apr 2024 14:09:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: function: Remove usage of the deprecated
 ida_simple_xx() API
To: Greg KH <gregkh@linuxfoundation.org>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <fb14757b434ebbad82c8771f19b73dc7ef81a91b.1705232365.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <fb14757b434ebbad82c8771f19b73dc7ef81a91b.1705232365.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 14/01/2024 à 12:39, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_max() is inclusive. So a -1 has been added when needed.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
> ---
>   drivers/usb/gadget/function/f_hid.c     | 6 +++---
>   drivers/usb/gadget/function/f_printer.c | 6 +++---
>   drivers/usb/gadget/function/rndis.c     | 4 ++--
>   3 files changed, 8 insertions(+), 8 deletions(-)
> 

Hi,

polite reminder.

CJ


> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index 3c8a9dd585c0..2db01e03bfbf 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -1029,9 +1029,9 @@ static inline int hidg_get_minor(void)
>   {
>   	int ret;
>   
> -	ret = ida_simple_get(&hidg_ida, 0, 0, GFP_KERNEL);
> +	ret = ida_alloc(&hidg_ida, GFP_KERNEL);
>   	if (ret >= HIDG_MINORS) {
> -		ida_simple_remove(&hidg_ida, ret);
> +		ida_free(&hidg_ida, ret);
>   		ret = -ENODEV;
>   	}
>   
> @@ -1176,7 +1176,7 @@ static const struct config_item_type hid_func_type = {
>   
>   static inline void hidg_put_minor(int minor)
>   {
> -	ida_simple_remove(&hidg_ida, minor);
> +	ida_free(&hidg_ida, minor);
>   }
>   
>   static void hidg_free_inst(struct usb_function_instance *f)
> diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
> index 076dd4c1be96..ba7d180cc9e6 100644
> --- a/drivers/usb/gadget/function/f_printer.c
> +++ b/drivers/usb/gadget/function/f_printer.c
> @@ -1312,9 +1312,9 @@ static inline int gprinter_get_minor(void)
>   {
>   	int ret;
>   
> -	ret = ida_simple_get(&printer_ida, 0, 0, GFP_KERNEL);
> +	ret = ida_alloc(&printer_ida, GFP_KERNEL);
>   	if (ret >= PRINTER_MINORS) {
> -		ida_simple_remove(&printer_ida, ret);
> +		ida_free(&printer_ida, ret);
>   		ret = -ENODEV;
>   	}
>   
> @@ -1323,7 +1323,7 @@ static inline int gprinter_get_minor(void)
>   
>   static inline void gprinter_put_minor(int minor)
>   {
> -	ida_simple_remove(&printer_ida, minor);
> +	ida_free(&printer_ida, minor);
>   }
>   
>   static int gprinter_setup(int);
> diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> index 29bf8664bf58..12c5d9cf450c 100644
> --- a/drivers/usb/gadget/function/rndis.c
> +++ b/drivers/usb/gadget/function/rndis.c
> @@ -869,12 +869,12 @@ EXPORT_SYMBOL_GPL(rndis_msg_parser);
>   
>   static inline int rndis_get_nr(void)
>   {
> -	return ida_simple_get(&rndis_ida, 0, 1000, GFP_KERNEL);
> +	return ida_alloc_max(&rndis_ida, 999, GFP_KERNEL);
>   }
>   
>   static inline void rndis_put_nr(int nr)
>   {
> -	ida_simple_remove(&rndis_ida, nr);
> +	ida_free(&rndis_ida, nr);
>   }
>   
>   struct rndis_params *rndis_register(void (*resp_avail)(void *v), void *v)


