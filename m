Return-Path: <linux-kernel+bounces-127535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4386A894D44
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE71AB2287C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BCD3EA98;
	Tue,  2 Apr 2024 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zK2hD57U"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5AE3F8F7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712045706; cv=none; b=rBCLRV/W3U940mHRgP/WtFspKyW4A8WFUlBsSdmOXPLKJRK30Y/ftudGTEImpOWDDeCk+apmJO5Nt4HOlO4QUrerh5KCy3BcAP/O8oqXTbX4UxVKYkDEAVgvhM/CWJDkdzpqNkocUpZQW48+rjdFlfm6fzCoGui0PT2ukNQVvwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712045706; c=relaxed/simple;
	bh=WHKlKK9EohBii9S28CpjTtid7am0PVMA0+L4lb8P/ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pm7i19BJ3q6HYY8DJKgtqxOpj7IObLtrIPyEohd9paIgchi6f3wRwvJTUKyMNFjyWERSeRSAxBhOXe3aMrWICSu2QNHxEqfjpGNox29IRXEihNDjXHc00+RqX8P/UC5QOUV/O3W2+k6+DDb9G171OP4yi4/yxLKrbccR8+sP+qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zK2hD57U; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-515a81928faso5963716e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 01:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1712045701; x=1712650501; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3PznuhWiRn2DrV3csjzqryBja8/5+Nu4cCrKqzgvwQ=;
        b=zK2hD57Uw4d7KcPwYwn5sX3nRvY2YGDGlEvIe5l4lk7nKT/VvFcw2R+QdQ7QoT5G7p
         nO5Pw6mTZmgBOx1JGZkRiJNe03cyou23ZHYLTzDx0C1ePwD94rZlpkCiX6XLVHInIA78
         PhbW0CZQNWDrwzGw9ZQvP4VdIu3ASQTQDbYRLbl8kJZ09hCzORVTUEFyWXgEcLTNH8/t
         GC29W2lGGVxbHccSQ4wsdV8aU7Q27f72HGIGCun3VEUaNJe9XarbjQ/swMhuQkHoZIeW
         /wRWBdjLhVkkCU1TYhMJ10EfBq0v811gSNHdkVPWBiW8YykadovXDCvNlPJHfYdL/FMz
         L/LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712045701; x=1712650501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3PznuhWiRn2DrV3csjzqryBja8/5+Nu4cCrKqzgvwQ=;
        b=HdBoTABZ2TfykLRGECdaSMBL3DEAhDaAngwgeWkiuQZIcWAVJFRGjNoklOY8S+GuOq
         jcZ0340a3hyet5TljLjhjFnGl+0kn62TX6edklhGFuYr4O233RiUJEJfiXmCispFbhfW
         uREa/BtQNeSGU78RatWLAiaVqOnVXdgyrk9/kyJG3dttnxowNv6VEOwOWL51PxcXJyOM
         6V7TOhuMHPyRrCmocPpyXakAFPFwWVzkPhDYduJ0rOb64a9whJfxqyDoVQfUJADrQXGi
         4GoMCc7gPg+t81jlnZkfdYTxcGthKyQZbSYWyIGsSbxALnYBsx6mZx6X+mHN1GBn7gvy
         fprA==
X-Forwarded-Encrypted: i=1; AJvYcCVvaYUKj2yr8mpKIPWqfEfhIeZG0iu1ZRWeaU6Pxhd2oKjgm+f89gNaX8BDjKzst2ODFx/TlseqQLMnmiZNDMFof1wmezIhyFZHd21/
X-Gm-Message-State: AOJu0YwZrD0b6vLuRKKm17+k3N6m970S84+Sm7Jdwf+gXmi2tDaxvcc0
	t5wTLddvrKKCyoI6a1aaYlmmRNifXuZqLIeZYMtGYzL1fZuzs9abHQzGqKEu9nU=
X-Google-Smtp-Source: AGHT+IHkFlWoscZhEInW5OhjLwpBACUlxhPfxaPo/RekIXvF+sTH5Dof1mRxSuBgUyl0Z87+l4jIwg==
X-Received: by 2002:a05:6512:ba4:b0:513:ed0f:36c4 with SMTP id b36-20020a0565120ba400b00513ed0f36c4mr9690442lfv.43.1712045700495;
        Tue, 02 Apr 2024 01:15:00 -0700 (PDT)
Received: from blmsp ([2001:4091:a246:821e:6f3b:6b50:4762:8343])
        by smtp.gmail.com with ESMTPSA id bg3-20020a05600c3c8300b0041481207b23sm17246308wmb.8.2024.04.02.01.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 01:15:00 -0700 (PDT)
Date: Tue, 2 Apr 2024 10:14:59 +0200
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Andrew Davis <afd@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Nishanth Menon <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] firmware: ti_sci: Use devm_register_restart_handler()
Message-ID: <rurlwebigvl7xdttvw6khaaksf2gyybxyiq5li3dqaksgswrty@5ulps4fobiln>
References: <20240326223730.54639-1-afd@ti.com>
 <20240326223730.54639-2-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240326223730.54639-2-afd@ti.com>

On Tue, Mar 26, 2024 at 05:37:27PM -0500, Andrew Davis wrote:
> Use device life-cycle managed register function to simplify probe.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

Best
Markus

> ---
>  drivers/firmware/ti_sci.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 8b9a2556de16d..9885e1763591b 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -87,7 +87,6 @@ struct ti_sci_desc {
>   * struct ti_sci_info - Structure representing a TI SCI instance
>   * @dev:	Device pointer
>   * @desc:	SoC description for this instance
> - * @nb:	Reboot Notifier block
>   * @d:		Debugfs file entry
>   * @debug_region: Memory region where the debug message are available
>   * @debug_region_size: Debug region size
> @@ -103,7 +102,6 @@ struct ti_sci_desc {
>   */
>  struct ti_sci_info {
>  	struct device *dev;
> -	struct notifier_block nb;
>  	const struct ti_sci_desc *desc;
>  	struct dentry *d;
>  	void __iomem *debug_region;
> @@ -122,7 +120,6 @@ struct ti_sci_info {
>  
>  #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
>  #define handle_to_ti_sci_info(h) container_of(h, struct ti_sci_info, handle)
> -#define reboot_to_ti_sci_info(n) container_of(n, struct ti_sci_info, nb)
>  
>  #ifdef CONFIG_DEBUG_FS
>  
> @@ -3254,10 +3251,9 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_ti_sci_get_resource);
>  
> -static int tisci_reboot_handler(struct notifier_block *nb, unsigned long mode,
> -				void *cmd)
> +static int tisci_reboot_handler(struct sys_off_data *data)
>  {
> -	struct ti_sci_info *info = reboot_to_ti_sci_info(nb);
> +	struct ti_sci_info *info = data->cb_data;
>  	const struct ti_sci_handle *handle = &info->handle;
>  
>  	ti_sci_cmd_core_reboot(handle);
> @@ -3400,10 +3396,9 @@ static int ti_sci_probe(struct platform_device *pdev)
>  	ti_sci_setup_ops(info);
>  
>  	if (reboot) {
> -		info->nb.notifier_call = tisci_reboot_handler;
> -		info->nb.priority = 128;
> -
> -		ret = register_restart_handler(&info->nb);
> +		ret = devm_register_restart_handler(dev,
> +						    tisci_reboot_handler,
> +						    info);
>  		if (ret) {
>  			dev_err(dev, "reboot registration fail(%d)\n", ret);
>  			goto out;
> -- 
> 2.39.2
> 

