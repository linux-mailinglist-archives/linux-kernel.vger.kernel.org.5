Return-Path: <linux-kernel+bounces-123153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767A2890310
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5721F23E9A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3703612F5A9;
	Thu, 28 Mar 2024 15:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpH1w0p/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3012DDB2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639698; cv=none; b=ea4D3OwA3zg839ZIGOSdEUSipwOF0TvDvrjFhliU2fJgV/HjVHDFccCiF9pEGMkLpfUzCFXmkYfi3nUM371X/2y7OxylsvSDp6+m/wcJ+c4iCfSx4ZtkQRXmP4yH5UFKucRAd+ip5vxAQI5t91hs+DNPlJ+1Bkqf62eLxUf4PkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639698; c=relaxed/simple;
	bh=zwapct/JUOe+SEP5Inv2iQOAznqb6ATi4pgATC1bsiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8dzp38mXxtx1hJLjgngS3SefDcs4VPJ8H285dFTfKH2Z/D1NrM+n/SGsMru3BcxXkS5Yx/hlxdwaAv7ajbm5pYwYlFT8hp8EVR583ZEPilzkKlnANU7Aamt4pvJrdyroVdt3xAKwaJxzpC04YPucb/S3vRk+8ny2kvSKeXlFYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpH1w0p/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2235c630aso3036495ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711639695; x=1712244495; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+QHEwpWhij98QQZZAdja5ZtVn6n47WKZdqS0GxiSu4s=;
        b=QpH1w0p/UTW88leG9Mv7SXXK0rg8PFMTW0J/ozXyRJafoQYPmk7metidE0+30bSqxc
         XLF88rWTXrrORnj4cwplZyTZtF1BGhoddPaGUZur+Sh+9pHxepIMSP/4mG+YODN2t4RS
         hXvznhQ082gjWfQxBSwGGqTSDS7yS1hR6EC2pgUR+Gc5sIgrDNRAlkiPjD3tiB2a98Hd
         7FF15tEKeHrDGWf2aNsNfLoFlFMN/5l+kdApLIKcrzjLvX/doDnsoEEANV93z3cmD359
         cZ0bpCPscV8xcngGOnCa4y6l/Fbsu58TaHkrhQAFSSYWvAKJyqxa1VjEa+w25NWZwvJ6
         Oqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639695; x=1712244495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QHEwpWhij98QQZZAdja5ZtVn6n47WKZdqS0GxiSu4s=;
        b=OhZ4tpqHAsznHMvvOwgbHE4lmDVrAL05CyL+KKEvocvr6Sq5iSdPLd5rtOd+PK0Zw0
         pQVFoAf71Hc+eYyx8gm03FZAtE+GIIcbLp0o6m7Af7j1IIDepLNv1DuuomlsMaYoe1c5
         7+8IJueuabdm4lxl8D3+4K5Gsy7Whmt5fiC7YZv3nmLQ41xbfeCDfsaKmlVVJVSh2aeQ
         bTjPzMqJ6I042Mo2ia0dPey9x366UJ4xIJ4QQyrycxoRg6H+xsBcVYv3bQcTctaYQMd6
         UO9Apa2RbcbZ7e4je8dIAEhELowjZ0HyJTf0y1ePsg8z+FM9I04Fc4tPanCS0VtNkqIP
         HOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlE5jpHE6RNU+X1xw95Fglx2hoRWSATdrnks1nyiK25c6rnkIFtGUz6B4w10XXlxcxKiSrL8SHBI1mfAsbRPauyjlgNnxniIMaTl9R
X-Gm-Message-State: AOJu0Yx7hLBaeMntJpCjXwYegdtudEIRG0sVVXgmH0zDIBlAz47XtRuh
	3rbIuck6y+x6gaEb4cX9Pe7Tw2IKdmjFhom0iBCmU7kA1e/dxkGdaeiMtEpMQfQ=
X-Google-Smtp-Source: AGHT+IHfGrijXuGPYHh2q9rckglh3vKg8jwtfAKIGexsFhrObZTIfyPHH4k7r6ut6Rcp7gCUhY+5AA==
X-Received: by 2002:a17:903:40c1:b0:1e2:23b9:eb1f with SMTP id t1-20020a17090340c100b001e223b9eb1fmr1132376pld.53.1711639694747;
        Thu, 28 Mar 2024 08:28:14 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:ff63:c57b:4625:b68c])
        by smtp.gmail.com with ESMTPSA id kg12-20020a170903060c00b001e09322cd1esm1719204plb.150.2024.03.28.08.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:28:14 -0700 (PDT)
Date: Thu, 28 Mar 2024 09:28:11 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: k3-dsp: Fix usage of omap_mbox_message
 and mbox_msg_t
Message-ID: <ZgWMi088/zORh0m3@p14s>
References: <20240325165808.31885-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325165808.31885-1-afd@ti.com>

Hi Andrew,

On Mon, Mar 25, 2024 at 11:58:06AM -0500, Andrew Davis wrote:
> The type of message sent using omap-mailbox is always u32. The definition
> of mbox_msg_t is uintptr_t which is wrong as that type changes based on
> the architecture (32bit vs 64bit). Use u32 unconditionally and remove
> the now unneeded omap-mailbox.h include.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/ti_k3_dsp_remoteproc.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_dsp_remoteproc.c b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> index 3555b535b1683..33b30cfb86c9d 100644
> --- a/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_dsp_remoteproc.c
> @@ -11,7 +11,6 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_reserved_mem.h>
> -#include <linux/omap-mailbox.h>
>  #include <linux/platform_device.h>
>  #include <linux/remoteproc.h>
>  #include <linux/reset.h>
> @@ -113,7 +112,7 @@ static void k3_dsp_rproc_mbox_callback(struct mbox_client *client, void *data)
>  						  client);
>  	struct device *dev = kproc->rproc->dev.parent;
>  	const char *name = kproc->rproc->name;
> -	u32 msg = omap_mbox_message(data);
> +	u32 msg = (u32)(uintptr_t)(data);
>  

Looking at omap-mailbox.h and unless I'm missing something, the end result is
the same.


>  	dev_dbg(dev, "mbox msg: 0x%x\n", msg);
>  
> @@ -152,11 +151,11 @@ static void k3_dsp_rproc_kick(struct rproc *rproc, int vqid)
>  {
>  	struct k3_dsp_rproc *kproc = rproc->priv;
>  	struct device *dev = rproc->dev.parent;
> -	mbox_msg_t msg = (mbox_msg_t)vqid;
> +	u32 msg = vqid;
>  	int ret;
> 

Here @vqid becomes a 'u32' rather than a 'uintptr'...

>  	/* send the index of the triggered virtqueue in the mailbox payload */
> -	ret = mbox_send_message(kproc->mbox, (void *)msg);
> +	ret = mbox_send_message(kproc->mbox, (void *)(uintptr_t)msg);

.. but here it is casted as a 'uintptr_t', which yields the same result.


I am puzzled - other than getting rid of a header file I don't see what else
this patch does.

Thanks,
Mathieu

>  	if (ret < 0)
>  		dev_err(dev, "failed to send mailbox message (%pe)\n",
>  			ERR_PTR(ret));
> -- 
> 2.39.2
> 

