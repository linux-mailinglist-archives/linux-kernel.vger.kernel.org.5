Return-Path: <linux-kernel+bounces-36084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FCE839B51
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA9D32863B8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43D648CCF;
	Tue, 23 Jan 2024 21:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgoENUiO"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A073D566;
	Tue, 23 Jan 2024 21:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706046287; cv=none; b=hgh60MIWdiGRTfPTYVOfZY7zQostslpc+UDmSzPAkvlcPB9+SDRhVjZiiwdmdxLnrf4+gGsMeu/XNXXu0ZqSkbh075Djj+QIqkXDel3EXCjd7izxPvtfDw6VWpwfJ8B4H66CgrrvidkK9ku+OBAQE4LwAJTK0BQ8s45kqEQLfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706046287; c=relaxed/simple;
	bh=vDnjpIIbP4NzaPlkT4a++LVS2cc7fwQ3SA5eIisuHQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVg+octsuWGpu1geNn008lCGkEmrhRrADN3DzQ3SKX2tyeWK8ZB3paywNZPTrzAq5sMcwONGyAm/+pTk4WwoLs5iYZ9D/NxYebuRrg06mtop81IrNSLVWxYvBW7Ix9Jgr/B3JUR9IBVDjogLTITYNGL4wpJQkWlElyOmuQmf3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgoENUiO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68195c0c8d1so19601096d6.3;
        Tue, 23 Jan 2024 13:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706046284; x=1706651084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+3MCPcQUCArKpNYmWhAQQTPpuom6plcd1PN16ZZMXig=;
        b=YgoENUiOl0nq2N4AoetuYFjywC/QF/MHWSxF0Gbw/+Ig4PF/WfeblUyf5wGYWxcj11
         7Yuijxg+LLih0StjpiQPBalqoNCOd5QHnX9vyoSDObUXMIf8mN1yiJOWdhD+SC/PIQxm
         Ua4PyW9uzB6VutWRycMmgbjAt+sapPdbvsIwSKpkzaklnGst7ZWqCa2mSd1btQL0lpf5
         Vm643RoaBSPV5ZTB8UZvS74+6W2LChFjidrbd1cHA6LkCFyOMRqyjHPsrXIXo9Saf06c
         HZhbVgv1tDQvQuHQRULTt3wrj2/84E+CE8HKSCuiSms4jVA19HMBo3odTQCoYHo0Wnu/
         mMxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706046284; x=1706651084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+3MCPcQUCArKpNYmWhAQQTPpuom6plcd1PN16ZZMXig=;
        b=LBRhobvco9H+6CHjrSibz+EG9Vx9UxY+Ma4+x7d1bR9yELRDPRJfR8iflmqbJLfPnd
         NeQTi0/taGCqbNj0NlyGuTrjudc5MYkZI26hXxM2CBTZnVm3AEvTyr7FZ+oIywCockC/
         6ZM1wgcgW0E4cdffLCtH96UdwnuT407iGcOuPgIRAxKfPWLt8qlHkVis2hdM2MZwIdma
         yE77L2hJ9FfNv8Y2VA9xxQMcDnjnS+v/ISiMvOnb8UWGASEJuJgqjnojjHdS+bkEl2PN
         0vMENnzUfoIjPPIzYmr4VnQJcTgl3V1qPY47aD9IYsf2wpfFXVz7Ea6RfM36YkqMq51V
         JDfQ==
X-Gm-Message-State: AOJu0Yz8pUai9xdyc84huYiubSAEhpuYABgOxwrLYQAN8+hT8YjC7Is/
	tfnAxZ2tbLkvsyHx3KxVX/Y05M91zTsLBi6JxzTaedkUqtgk61nx
X-Google-Smtp-Source: AGHT+IEnM4O/QvGUTq4CzT6ynknyJ6uSBpQcVtYap/v7zSMVnEgBOB3nMcUgxjrQKSrrA3y6M3Nxzg==
X-Received: by 2002:ad4:5f0e:0:b0:681:7963:2aa8 with SMTP id fo14-20020ad45f0e000000b0068179632aa8mr1246200qvb.130.1706046284432;
        Tue, 23 Jan 2024 13:44:44 -0800 (PST)
Received: from errol.ini.cmu.edu ([72.95.245.133])
        by smtp.gmail.com with ESMTPSA id nf3-20020a0562143b8300b00685ad9090basm3606011qvb.97.2024.01.23.13.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:44:43 -0800 (PST)
Date: Tue, 23 Jan 2024 16:44:42 -0500
From: "Gabriel L. Somlo" <gsomlo@gmail.com>
To: Andrew Davis <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Joel Stanley <joel@jms.id.au>, Mark Brown <broonie@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 4/4] firmware: ti_sci: Use devm_register_restart_handler()
Message-ID: <ZbAzSjxbAgvvrV5l@errol.ini.cmu.edu>
References: <20240123164443.394642-1-afd@ti.com>
 <20240123164443.394642-5-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123164443.394642-5-afd@ti.com>
X-Clacks-Overhead: GNU Terry Pratchett

On Tue, Jan 23, 2024 at 10:44:43AM -0600, Andrew Davis wrote:
> Use device life-cycle managed register function to simplify probe.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>

Reviewed-by: Gabriel Somlo <gsomlo@gmail.com>

> ---
>  drivers/firmware/ti_sci.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 8b9a2556de16d..16501aa0b84cf 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -103,7 +103,6 @@ struct ti_sci_desc {
>   */
>  struct ti_sci_info {
>  	struct device *dev;
> -	struct notifier_block nb;
>  	const struct ti_sci_desc *desc;
>  	struct dentry *d;
>  	void __iomem *debug_region;
> @@ -122,7 +121,6 @@ struct ti_sci_info {
>  
>  #define cl_to_ti_sci_info(c)	container_of(c, struct ti_sci_info, cl)
>  #define handle_to_ti_sci_info(h) container_of(h, struct ti_sci_info, handle)
> -#define reboot_to_ti_sci_info(n) container_of(n, struct ti_sci_info, nb)
>  
>  #ifdef CONFIG_DEBUG_FS
>  
> @@ -3254,10 +3252,9 @@ devm_ti_sci_get_resource(const struct ti_sci_handle *handle, struct device *dev,
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
> @@ -3400,10 +3397,9 @@ static int ti_sci_probe(struct platform_device *pdev)
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

