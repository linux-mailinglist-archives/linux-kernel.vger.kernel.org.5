Return-Path: <linux-kernel+bounces-49362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E08984692E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B77B21F273DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134817BCD;
	Fri,  2 Feb 2024 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rYDSX1x4"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF8317BBA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858479; cv=none; b=JEKWAzj5EKbD5EMB8K9vNPrqupqA1SYCalObOXbXMsm5lI0xjWlv0kxwiJ9kuCQ1+DHaAl0d85rlvrcHHwP8pUKtI+bQS2iPeps01KKnuaXWtt7HuYo2odq4WrrpXZYNxcTMXcS7M6uvfwPIF9IJUTKKn5J1JaktfnU76mYLwsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858479; c=relaxed/simple;
	bh=lpTM8i3qAGSiY4E67knpu4ci12EK/1WfR/fXKv773eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyyePNnFp8j1xvG3PyYp5kgueIjU8lGiSlew8XRL9HRtL5cmEg+FJDz1xaJJ7BJA/NlFl3wJMJ8BzO8dFI6HwLvA6Z6FDcjVGuLUJKN/9QU75TFtktxCjlovyLcR2pjDB76fVTw4sDuc4LeE4gS9aRSOg3oXF1lE7SDzNzCSfMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rYDSX1x4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a35b32bd055so228138966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:21:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706858476; x=1707463276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rynCR7DUuWYPX0uSmJQ3t5lmPk1yuAmXaxIJOHoQI7E=;
        b=rYDSX1x46/VjrLR9A2yUp8d5IV8+fIL+MJrJiCRcdUsBvIBX+LJG+uG71pSe5Pntl/
         Eg9IhAstzam6OJOtY4DzgIUDPB5oof6flPpwhw7bStvQYYhGfXK3QB/6Xs7DvbuLLyn/
         ubdFTaJiAFkEszCAFol8NzNczjhg6suAmVIKwF046SqgwTWQpZT++84ROVVNVgiIoozh
         fppK+JzPLKajXmgkmkPWtsi2WjwQd3krpU+1vvEZCRsbxrKP6+dfcnpF3+iMrZ899bfv
         jEuI3eiYKsEhK7hrcRmdKgGm48jfcH7tPB+7EvBMU9GPrFIkfJec07Hp81U3Ltd26RsL
         hoJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858476; x=1707463276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rynCR7DUuWYPX0uSmJQ3t5lmPk1yuAmXaxIJOHoQI7E=;
        b=GVmvoFuDaDholD3MqPjd8KxsvEpAe+EzhATM1SeDIVeaQGNawKg9XSOn8WBmc20l0s
         rfuP7XipmbKDLIDp2j4FfbuBbqjb/n8EwrzMGkdZfE5oVAHV8EYeZd7wUxefonLz/SY6
         Xlpc8sJ5qbmo1i4va/p6TD7cEpWZuZfXDqclh7onmgi8a58EiT2Kh6HRCaEQ3Gmnm4iW
         VXhNn6wx4EyaHIvT2EPSFYDH9pUcNENr53RE8cAcXKpCef73vaVYzU1umsWrn8QNjsrE
         fQzAFr5Zsu3ymHzYxXp4O+wIGCOa89W6Hovr77bPLzg8AIRJJ9zzU0yruei/9zRR+rHj
         TEvw==
X-Gm-Message-State: AOJu0Yy5Dv2y0v/9lKhymYudPp/5CIljKwQ63utAPNlGfdR6prz5wgkE
	9bFNttcHXz5TXZkHhGYwAe/UCFYyii2rQw21IxxZ/ep1hzJjOHdbx+Fua9PGVCA=
X-Google-Smtp-Source: AGHT+IHyFuUb47frdawTnmd/JjYOHapvFHmXI/c0K9LOuiYQvjT6KjLwQDkDiJ5b/D3nZiVjarwlJA==
X-Received: by 2002:a17:906:304e:b0:a30:4189:4e10 with SMTP id d14-20020a170906304e00b00a3041894e10mr786033ejd.53.1706858475842;
        Thu, 01 Feb 2024 23:21:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV7YI6mqnDVH0uFCEJYm+8NVVZE/Nt68934vPNYx8qXgR5csU5taYye9/7ohZBqK8bkwv/fwawi/urQuvGLGFSrs3JWDyUDCxAoK41JGw3j6qmFCPnzSVaINsHsGoGIjpX+VuSDMI2sFJRhrD5fo5FQLA66O6PdL5XQllsK6gPC86qxRc1zzTxuOXfM6J70RPVOmHPEEmDmVg8bPVQkowIZ5C54FYPsrQmCjrCoihKezjIXQwh1thzPtcOyGWMf6uopIEd0eEba+UTpBw==
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id un1-20020a170907cb8100b00a35de0619dbsm567619ejc.200.2024.02.01.23.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:21:15 -0800 (PST)
Date: Fri, 2 Feb 2024 10:21:08 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Meir Elisha <meir6264@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Ruan Jinjie <ruanjinjie@huawei.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] Staging: rtl8723bs: Remove extra spaces
Message-ID: <78dc8263-b866-4d44-9f02-194c8a79fccb@moroto.mountain>
References: <20240201140459.438479-1-meir6264@Gmail.com>
 <20240201140459.438479-3-meir6264@Gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201140459.438479-3-meir6264@Gmail.com>

On Thu, Feb 01, 2024 at 04:04:57PM +0200, Meir Elisha wrote:
> Fix checkpatch warning: please, no space before tabs
> 
> Signed-off-by: Meir Elisha <meir6264@Gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 63 ++++++++++-------------
>  1 file changed, 26 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 5568215b35bd..44b77c1ba992 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -169,7 +169,6 @@ void _rtw_free_network(struct	mlme_priv *pmlmepriv, struct wlan_network *pnetwor
>  {
>  	unsigned int delta_time;
>  	u32 lifetime = SCANQUEUE_LIFETIME;
> -/* 	_irqL irqL; */
>  	struct __queue *free_queue = &(pmlmepriv->free_bss_pool);
>  
>  	if (!pnetwork)

Please the "delete dead code" stuff into a separate patch.  It's a
little bit easier to review when patches are split up like that.

regards,
dan carpenter


