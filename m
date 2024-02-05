Return-Path: <linux-kernel+bounces-53926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1B684A819
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2031F2A749
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62DC0136994;
	Mon,  5 Feb 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRcE13el"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC1013698B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707165960; cv=none; b=tMCqttSrMEp99qWEUaogKhWQKL1x+dtNP4EWUHT5BdzRDUJrSvbBiBG65KdFeP4XlDoLis1rDuHdt/nTo7rDU8iaD/XpU02qhA8MO4bQnzLvwCHK2mqClLkXlPhcfCn4/CEsY1MeO+4z9wep+U/x5+FwX9zs6/PIkdDURz7EZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707165960; c=relaxed/simple;
	bh=X4i2QJjT+a4DcevN3hqV/iu9KdJwOXDYjejmyCsHs9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mpdDWaiweS7/TQ6spFCFDYCmZLDsyr84Feex5Dt8Vcvc7Fp7elAVKpvjcTdBgIOU9PgRmtbwBzVwOiW6HKoH+l14bj6A3xcjvSXBtvegVi5KexNsgNO2jVCSQ8KNgNIyiTlDsfN1mK8JHU7V1pSsHICYdU/LSDkgFuSUL6n618w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pRcE13el; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d8aadc624dso36366025ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 12:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707165957; x=1707770757; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oj6zERmX/v39V3SsfqElvJNjVKuk5X5kJW4faJdVaIg=;
        b=pRcE13elHU1XEkyCRbFzSdQvkG3MnVDJE9y7fNihzZZLtis9MYiKwNP5d9uxfutjsK
         d31oHyVALor3cO5QhbghOOnrRbAGyEiR4znPWgJA2s4MYNZLTTzgB5ApiWCejr7KS6PF
         aPzE+dVC5ulyc+NA6GYSL+kgSKo5IM9GVa89YSZ+V4SRQ4rHdRTuLpTy5Sr/KaCCUY4W
         BudNs4+3bOu6XZRBaAOZ9CmtL05WpASpc7D4/yIaykEPxW+9E9dTTzuS9Td8tsNyjNWC
         Vq1pYho+YNyHnQBOwtK/pVHme+xwFkKuzxcUdDe6O7IK58Kywc8DVoQGeZSy9X0h2ayc
         sneg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707165957; x=1707770757;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oj6zERmX/v39V3SsfqElvJNjVKuk5X5kJW4faJdVaIg=;
        b=H+QLrzWtN4IRuS8N+XbW/3K2WTUdFXpchls9GFRIy4E6fpP2hoCuvxF4+oEDqe7N5x
         tM/pdo4FSdzxqX/aFmZhomhOBgGTylGaB+LnRuucYzGSTtcDW97tRziZoW4SBGjQXAD2
         i1rqHG7q7xqKWybSeWp63s83nPl893J6ENyPcNgSn5cw54/uMvH5bAs7dGIw+H9ZDUTx
         of2xr5v+t3TiMaZ5g2kYlp6l65sEI0AF4xrVCFWoe/ZQtpQLSEEWZ0DnQpj6gmocAt3o
         M2Mw9dHI2bdSO9PSLB8PkA6suIfyXooiH0GUqrceA24cDswFQsaikMkMsAFN3fQaRsFE
         5HJw==
X-Gm-Message-State: AOJu0Ywp7xtXVXEstbxNrJlBVBnbcv6wCoYUYmR2If9DU8EO3k3bhjjg
	6j9IgAmN5vzK+aqgDOTIa7403GrpV+tI5xaQIIz/ZKCBmxc/SwllV0cFB4hnw6d3mJ8YMQUaBtw
	1
X-Google-Smtp-Source: AGHT+IGjX1ytXEAA6Kirm+Njlc+gpnXa8qeD4ZUzvYpYaTr63EQdU4+A5vj1DUVukzfHazPkNMWMPg==
X-Received: by 2002:a17:903:487:b0:1d9:af60:a7e3 with SMTP id jj7-20020a170903048700b001d9af60a7e3mr661393plb.27.1707165957125;
        Mon, 05 Feb 2024 12:45:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXulepnxquf5u1/JWqyyuXFoN8LbkpPzrTLBWpqxE1kozjGaeWV/SE2KCyBN36X5ADOWNnvns3L0lKhdF6oa6QBE5N3ikr6EX9wpTkP/0MvmpHq/UACFWGCqHPFgoUShyjdso95x8ppKDS/eaHmPlYKKRj+5qvsy9hDXA42I5liL2JYigIBM+T1NPI=
Received: from p14s ([2604:3d09:148c:c800:c88e:5ce2:4df2:aaa0])
        by smtp.gmail.com with ESMTPSA id ka5-20020a170903334500b001d8edfec673sm297917plb.214.2024.02.05.12.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 12:45:56 -0800 (PST)
Date: Mon, 5 Feb 2024 13:45:54 -0700
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] rpmsg: core: make rpmsg_bus const
Message-ID: <ZcFJAggfRqLexzpD@p14s>
References: <20240204-bus_cleanup-rpmsg-v1-1-1703508c23b7@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-rpmsg-v1-1-1703508c23b7@marliere.net>

On Sun, Feb 04, 2024 at 05:32:05PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the rpmsg_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/rpmsg/rpmsg_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
> index 8abc7d022ff7..4295c01a2861 100644
> --- a/drivers/rpmsg/rpmsg_core.c
> +++ b/drivers/rpmsg/rpmsg_core.c
> @@ -605,7 +605,7 @@ static void rpmsg_dev_remove(struct device *dev)
>  		rpmsg_destroy_ept(rpdev->ept);
>  }
>  
> -static struct bus_type rpmsg_bus = {
> +static const struct bus_type rpmsg_bus = {
>  	.name		= "rpmsg",
>  	.match		= rpmsg_dev_match,
>  	.dev_groups	= rpmsg_dev_groups,
>

Applied.

Thanks,
Mathieu

> ---
> base-commit: 80255b24efbe83a6a01600484b6959259a30ded5
> change-id: 20240204-bus_cleanup-rpmsg-1a5f6ab69a24
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

