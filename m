Return-Path: <linux-kernel+bounces-98942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CD5878154
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81AB1F23213
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB83FB9C;
	Mon, 11 Mar 2024 14:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XygYDkFi"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60063E46D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710166189; cv=none; b=tUEQ+8EmfcXut4c5IY01EyiYv7P2lR0eEbtOHDLAwZ5sMtd3PIuCvAvK4Xze+znFk+5LE3sYtzjWtlK+he/qpd4pwzzHpdMUAWyqd4UHd3Kyng6gUvUvxldgN67uWkLjbIKo8w0JA+lgyod5Q4y3lpWiHUC5tK8hYAyOaZyrll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710166189; c=relaxed/simple;
	bh=mgxPhZa7itiP3y8g8ze/hDZxipnyP4hm2UnmBNC9sKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PiDeqjg8J2TzT5iTbi8jD0vJcpaffMigVo5c3/g3/znW474QEhaaqPUrm/NLQ0Lf4sU7PEct0MprQ2Qg1WYKSNa7B6tpLIKJd/VS+iHAEev1tWlRg1tPZ+lrziu5T3lgCRvaPfez9/5g23ZcTAxynHgw34Z2RZ0GJSKfD+XJ1O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XygYDkFi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132f780ee2so2628905e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710166186; x=1710770986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yl6YfvPFhweYRwRy68I4o7i+ufbSeARu9E5f/nZY69c=;
        b=XygYDkFi1bkYgo1RRRkW73zdHFOHiUwtQESmVsNePGCqOU2bsBUyoFCIrNkHCPpo+g
         Em0Mn4WcFwJ1ONg/IDg6m2b9XOVnXCopATRRnlqaM0TJ7G4CPpqyU6+qxeNBafoGXTrM
         01H/Y5mcGyYOs8diGo3MIf1qAWMteDyWov4q1LFpCs9L7zIfSVI5dpnUMvuzrvOdqTyl
         UrwvGT9RO/xST30fIGoEPAzuyaKI4ERjJ03pB/LFF5X33+H/AiqnXT3DRQD77Mba+2dj
         OEDWA4vrXWhOx87sSvaaE4+lTGIhyEKUFZTnbjwTerkJBLgzBK9Oe4yyB45fBRy+ilLh
         5OoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710166186; x=1710770986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yl6YfvPFhweYRwRy68I4o7i+ufbSeARu9E5f/nZY69c=;
        b=FRziUxF/Th8gtfv7PZ7wMd83gu5+25fYnRjGCbY7IEo1SdRRJWBjEWFmo50+VAqDzb
         EUb8Jy4xZjjEBM6QqJtCR+E3ElB853EBlKrkgNN0uHmS6Pe+5WOcVV9P2em/wYwrhB3v
         0UlRCx80qRaIFSLIwu9kBVOEMnFXAdOfwBmD5JWPfiN7bcgN2dzCGIxNbHSWmhPEEnAI
         Wfz2FpLPGrXIAnf1MmxXf7JOWUJe1Vtivf7fYfeCUa1/gxPS//INMD+03doQhFOVhu6I
         BSl0lQhDomD/+6M8IacR7flKUhPj0EZraWnHtrKCU7n5doMThkQUm8ha2I28Y8iifjxv
         KKfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJrG8hfziS7j/LL4J95s63mH7XDdnZ1tqrxbaBW/o7eM2M4GZwjaRPLES6x/X6U7QPh5uEe3QATzIWTSlDFKXSjc87Qdpv/XAaIfoL
X-Gm-Message-State: AOJu0Yx+Rua/LCBbdLMurtDmK52R2WGUR+8WA0jam80gPTQuFAXpoo2t
	D6zXZ0DN2/WF+WV9X7GPPZsKENhCLQX2zPGukSPTnd8C/HYzmvwCnax0wMd3MOw=
X-Google-Smtp-Source: AGHT+IGQYnC6s8vq/AC95aOrVG5lPMt5L/uK8n2CYBjMezpKRJ3nt4A8EEH/Dx53g29OqUA7Km8LVA==
X-Received: by 2002:a05:600c:4f50:b0:413:15a5:5029 with SMTP id m16-20020a05600c4f5000b0041315a55029mr6835212wmq.10.1710166186035;
        Mon, 11 Mar 2024 07:09:46 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a05600c1d8800b004122b7a680dsm9399239wms.21.2024.03.11.07.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 07:09:45 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:09:41 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Felix N. Kimbu" <felixkimbu1@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: cfg80211: Remove parentheses prism2_get_station
Message-ID: <ac756a79-0522-4286-a464-2a62a4fb1cde@moroto.mountain>
References: <Ze8LBf6xSjCRt4rd@MOLeToid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze8LBf6xSjCRt4rd@MOLeToid>

On Mon, Mar 11, 2024 at 02:45:41PM +0100, Felix N. Kimbu wrote:
> Remove unnecessary parentheses around 'wlandev->msdstate != WLAN_MSD_RUNNING'
> in static int prism2_get_station(...)
> 
> This change ensures adherence to coding style guidelines.
> 
> Signed-off-by: Felix N. Kimbu <felixkimbu1@gmail.com>
> ---
>  drivers/staging/wlan-ng/cfg80211.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> index 471bb310176f..7451fd2bb580 100644
> --- a/drivers/staging/wlan-ng/cfg80211.c
> +++ b/drivers/staging/wlan-ng/cfg80211.c
> @@ -247,7 +247,7 @@ static int prism2_get_station(struct wiphy *wiphy, struct net_device *dev,
>  
>  	memset(sinfo, 0, sizeof(*sinfo));
>  
> -	if (!wlandev || (wlandev->msdstate != WLAN_MSD_RUNNING))
> +	if (!wlandev || wlandev->msdstate != WLAN_MSD_RUNNING)

Sorry, we're ignoring this checkpatch warning.

https://lore.kernel.org/all/?q=prism2_get_station

regards,
dan carpenter


