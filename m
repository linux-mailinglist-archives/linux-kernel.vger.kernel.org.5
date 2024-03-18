Return-Path: <linux-kernel+bounces-105786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 738CD87E458
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D7FB20DAD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728942374E;
	Mon, 18 Mar 2024 07:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuNTpRhW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81E23748
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710748272; cv=none; b=Kp4TeiJBcmds9jYgbttm+vgEmTsMJxtZGkTpKe18n9FYStf4SHdR0otHWPx8oNcaHeipythfn9tkRCjBAvGwaut5Y7Wxz3ibiJsYySlUnGnaU48imd7QVcJc+nPq8STHJh+ZDXtKsA2V7WTafJvSVQPULAidZk/rr0aZohmf62Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710748272; c=relaxed/simple;
	bh=1hjlx7mByRkB+RyNSp9fPJzaTV+aHeoo2cmJHjptDeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGCHtIAUn2Pj9KCVvteTmgGD0HeAR905BKtTwhAIm3TSC7fncRFfolBoRu/L5sCabiY7RI86+8eEd86j3fmBg+ei6ucj35IWdDVwqwXdzc25MHjRpanNf7vq7vWes4ZdnqK7GfxUvbMMSHcasRwUvHJ8aWwT4XijMmGSu54Sxk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JuNTpRhW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so5469895a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710748270; x=1711353070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zcvM2U1RtWo67CL6QsElDR20ViRM+DDPM1wjn1TEfQQ=;
        b=JuNTpRhW1bCvcDxY2UYjkR2d4fb+zpEbRbBowesvRcQSDxSjprdUh4urwWuOFsMhZk
         vk4Oq0f6UjDkb9X57TBcMXgF/Sc1xQP8bmltF0W1CV6RxvECyzOHesudGUXeDBM+SQxT
         w0LQ0I7FEVMv+6PeFxUEUJopBtRkshn3shHOuVkeYJ+HTrggwM3Gq3pU9q9fxDAPeyXp
         W+iPQ7xe6PULekto9RBMhYOaoJmNN+YrjR/NQh+C/G/H+yrAd1cNP1Wl3iWRdSHDl8n5
         kpvjNpeJdEiuf7CjCqdWoU54sKLBsYd2//Dt99ZjDg7raKAVV+sjXascLsg3gckHei0/
         58VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710748270; x=1711353070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zcvM2U1RtWo67CL6QsElDR20ViRM+DDPM1wjn1TEfQQ=;
        b=oWZm1tlCyTobCwegcxVq3rp4/5hgSgUmmFe4/jGCBZHI1WN1kGxSRy76hM16F1y4B9
         XNiwLEteeoJ48mSZadMbK6fYt7t3WaP/uG3K2gP9WIXYmZgaKb3DgTPx4KTc+yixwUq+
         cgBCRTpEQYzWBj+joh7dsuMvj5mIZd5GghcEgU31TbyxWl2MnaaCg0kT+nzodjezQ3Le
         Bw4oKsNQpIpTQMsS3FIysit+HnW1Z+5kokADXFxDZUWE7oXsHtsiXOs5wwEH2bPTlRHf
         jJdf50FINtrD0Id+KbZYqv0SucynmDu+49tb7LPCxbe0Jc518mbACsS5xBtsLZzxvMI4
         w/aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYwc8uPQxHxK9cDgkvpQUDHOur0TQSzaDnDZ0GozW2hZxG7WcaX2C4QQWGa4sK1m7bi/qUld1jFB0X2kysqDmGBWfcUxe0F0EKPaK5
X-Gm-Message-State: AOJu0Yw1VOeGFbqBZ92wuD0bF39GGc7zi5Igql0S5K569K5C8FcoyU8g
	p5o1w5Zsl8NLIS8QMyumIn3f3GCF4QUGGIKPy539Mi8BCLdWdmD64ze21YFiggU=
X-Google-Smtp-Source: AGHT+IEvB22Xpy2Nc5E3LJxhstpPLCNC/esbvBM8MshhZNyxJrIkm791fYra/ATnXNOue/LBc3o8iA==
X-Received: by 2002:a05:6402:458a:b0:568:b851:f718 with SMTP id ig10-20020a056402458a00b00568b851f718mr4637155edb.40.1710748269582;
        Mon, 18 Mar 2024 00:51:09 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id cf13-20020a0564020b8d00b00569731a1eb2sm932904edb.46.2024.03.18.00.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 00:51:09 -0700 (PDT)
Date: Mon, 18 Mar 2024 10:51:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ayush Tiwari <ayushtiw0110@gmail.com>
Cc: Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8712: Fix line length exceeding 100 columns
Message-ID: <f004287a-d248-476c-9a3d-d24eab6a891f@moroto.mountain>
References: <ZfdIpVyUTIEGTp7j@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfdIpVyUTIEGTp7j@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>

On Mon, Mar 18, 2024 at 01:16:45AM +0530, Ayush Tiwari wrote:
> Split the argument list of the kthread_run function call across two
> lines to address the checkpatch warning "line length exceeds 100
> columns".
> 
> Signed-off-by: Ayush Tiwari <ayushtiw0110@gmail.com>
> ---
>  drivers/staging/rtl8712/os_intfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
> index 7554613fe7e1..e77fcfc465ba 100644
> --- a/drivers/staging/rtl8712/os_intfs.c
> +++ b/drivers/staging/rtl8712/os_intfs.c
> @@ -221,7 +221,8 @@ struct net_device *r8712_init_netdev(void)
>  
>  static u32 start_drv_threads(struct _adapter *padapter)
>  {
> -	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s", padapter->pnetdev->name);
> +	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
> +			padapter->pnetdev->name);

Please run checkpatch.pl on your patches.

regards,
dan carpenter


