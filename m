Return-Path: <linux-kernel+bounces-32436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D798E835BC4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FE9281C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 07:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1741A5BA;
	Mon, 22 Jan 2024 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8s3kWiD"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AB18C27
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705909085; cv=none; b=t5fHqP4Q3XOEI7Gn7JT8ho8oXCcjJnE01FXiBR9/rMl/jMtSAY2Ux08AzmR0tj06bpvhkjw5P9NcptYnqCdUz9lkks0IhAJE9QQM+N3D57ffVEDU/lR4nJ7CKws4UGnuLa1JWZG4roSjRXq7Tc3sGG9OFFRfqiodFV2OKwNMCfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705909085; c=relaxed/simple;
	bh=hCuz70FfdtuZnlCGYK4y7wSWkRTar5SysUT5b/7ao+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pUkH/bEEzV56wcdXCWGEDUW3VEaaJeCz3ilpcTOG5HJ0yOs59Rhiad+M7sWbx5Q0cjfRUwUpSvJdbg4Kq/1piliy3tRAC87vf1EskQcrIa5QkKkVx41bPvr6IhQSJfGkULMQOYwn/aF6zvCYbwNTAauptAS7toM4Jr17zthjU8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E8s3kWiD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3368abe1093so2414449f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 23:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705909082; x=1706513882; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iBHmiFCDuhhHhtLh28ouvjQZwCkrfYLQjVhhRH17R0Q=;
        b=E8s3kWiD+ix6QDKAoEXwUSnLrJCSJm5yAEAeQMwoHm53Moy/xlN2/JbHImJijxRPGR
         H1siLp8Dr9HtfK7BfOHzWYPQOHYnAwAA4mE5hc1UKTyqeo8mVNzXsmnZjTUSDJAyjDnZ
         4Tmtg9xRCA5OT4GoQrEKjmu+NWzkTiFz2DJANekmVrNs3wVeaCDx0n3QHTSK1iljPBCh
         lktbEqMIgiL8vcCMolBWVJEAfwJr8OIb1k6H8sGk5o0jTtKo+exhnXoXOt9QtWg0NxPq
         LY8FOQ042NO0ES8L8h7N0s+CNGt5FwRIqlYDvN8laWyB1oXnbJreE8ZQg1lNKylSatK8
         AKTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705909082; x=1706513882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBHmiFCDuhhHhtLh28ouvjQZwCkrfYLQjVhhRH17R0Q=;
        b=VKaksOKbOCkNbmY42GHeU33sKNo2Ppm5LG/2JlNT52FqqItmknyXXWiq/07g/pvIVe
         C0AYXCx7M/IbIcUs7rfVnmb/NHEOqoGigAvL4kR0zZK3Qf2+xePB/zzzi+PEP/PzVMOe
         XFZOFl/+sBq7kWc3TordPOp3SuguL9fpoElvrjYF1ZylBROmg0BmibO3xa3FqBte4Zwt
         9ehMZkEZ3eBTZTd/QzKbWXRosfg0JxYeKKt2Cg9uPVyirJMneceoER7bQ76C23C5+DwG
         FfgEY0pKm0BzLSJxosFxNaehtwvTMjTlMYGitRB0Cb7BHZUYsV9Q9Tel/yEwyrc4Xs1c
         zVDg==
X-Gm-Message-State: AOJu0YwE5wpLJM91ooQXxvzNXrpcDYRiTi6CG0E2arVQzx3lSq9o74Ih
	wFMgLTdE/91tJ45dc1KBtz6ay7zdbBbgfd86MJjbll08fLJ46cXH6GNpIaUAeOE=
X-Google-Smtp-Source: AGHT+IEa//FRNBYwDx24LzawyqOfvJpeHfudBdcuXr31gQGQGdHPir/G//42u906D1V0rsSKGxyWFQ==
X-Received: by 2002:adf:ffcd:0:b0:336:f22a:c16b with SMTP id x13-20020adfffcd000000b00336f22ac16bmr2191154wrs.45.1705909082518;
        Sun, 21 Jan 2024 23:38:02 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4d11000000b003392af92996sm5202076wrt.101.2024.01.21.23.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 23:38:01 -0800 (PST)
Date: Mon, 22 Jan 2024 10:37:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hoorad Farrokh <hourrad.f@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove unnecessary braces in while
 loop
Message-ID: <39fbf9df-d6da-4275-be3b-191108f94ec2@moroto.mountain>
References: <4ii7ptqhz7ion46dczabnevuj7tjfv4iofvzedms6tvfgsfu2e@6rvcsdyodny2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ii7ptqhz7ion46dczabnevuj7tjfv4iofvzedms6tvfgsfu2e@6rvcsdyodny2>

On Mon, Jan 22, 2024 at 09:01:27AM +1300, Hoorad Farrokh wrote:
> Fixed a linux coding style.
> 
> Reported by checkpath:
> 
> WARNING: braces {} are not necessary for single statement blocks
> 
> Signed-off-by: Hoorad Farrokh <hourrad.f@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> index 1593980d2c6a..0145c4da5ac0 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
> @@ -127,9 +127,8 @@ void kfree_all_stainfo(struct sta_priv *pstapriv)
>  	phead = get_list_head(&pstapriv->free_sta_queue);
>  	plist = get_next(phead);
>  
> -	while (phead != plist) {
> +	while (phead != plist)
>  		plist = get_next(plist);
> -	}

This function doesn't do anything...  The name says "free_all" but it
doesn't free anything.  I would prefer to fix this warning by adding
a comment:

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 1593980d2c6a..4f856d126517 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -129,6 +129,7 @@ void kfree_all_stainfo(struct sta_priv *pstapriv)
 
        while (phead != plist) {
                plist = get_next(plist);
+               /* FIXME: free something? */
        }
 
        spin_unlock_bh(&pstapriv->sta_hash_lock);

We can also try adding that to the KTODO list.

KTODO: why does kfree_all_stainfo() not free anything.

Perhaps there is code in the other rtl drivers which shows how this
should be done?

regards,
dan carpenter


