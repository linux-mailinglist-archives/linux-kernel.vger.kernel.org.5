Return-Path: <linux-kernel+bounces-52835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBFA849D3E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5691F2349E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9722C1A9;
	Mon,  5 Feb 2024 14:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrpKqihx"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683322C19C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 14:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144118; cv=none; b=Lpf/2w2nKqBzEtMIZDxu4PdCSao4CLNoCSchTMPMdQvFXwGCQv4WhnaiKOIM8tm6PCHQFutc75OqoZg3Boc0H0+wJnL0ZTAXzQFPb4H2aeiNpdUePaXDdMeMpURoztTtuzM6NFtfqcf0DUbtSdqqmI3vkhw2bUGNJt/ds9hVZ3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144118; c=relaxed/simple;
	bh=KQhMNIwFvZsF0OT2RO5FnPqalWb/YnWmBS845Z+2/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGHwc8929woiuBG3YqXqTH+k12kc/gGeqvSP8zIY/R02Ke9Ftpbyts27m2o3V20I9J92HF4ByT5QhyhHEOlDmN/g8/kW+Zgcgc6KQkm94MExjaPpCr2z8OnS7ifC5Cx3HeQi2Xq4GLn5EoJx+duBPrUKPLpYgGKY9p9eIo+G98M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrpKqihx; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51121637524so6731527e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 06:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707144114; x=1707748914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fKULY3uf5fnHzulcbB3qwz6JapwOEnl8pUfTbYYscHU=;
        b=LrpKqihxJnR4haw1flXHENkJ0rk331V/cMTUIDai6tZmaTRzg5K4O4i0WUHLfu+Ymv
         MlJr9uAfe0JlxelSRFkJBMGe+o+A3LTUt2MmJFf366dX/qPzZMZmHgYhkrH3HD7L/w/H
         Nw55enMb9WmzkWVPCc5X+c1Zt8NbLpYoR34OnKl/c0UVYLtxbXFWE4bpyVIv0FIQUreC
         m1YHxvur+ZGd99x1vlwVgOU165S0bwn4h4OGbuc/fkzv+1ROBOQ7mpDdmSA7A7sxTWVn
         KUHehxT9eEsnwc8lMri4KAw+i8a0YL2OTvTt8g9ZXAedb+zUts+5vUzANHrFL8iQHiH4
         b/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707144114; x=1707748914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fKULY3uf5fnHzulcbB3qwz6JapwOEnl8pUfTbYYscHU=;
        b=EUXgzmVmUmGijxEjqq2fK2fCO8AyEC7xKkbZd6L2qGxEYSluR0YHX9yDy/f2tQ71WC
         Mm+pRgn9/oo0lJndei1wjCTX1lcUTKmJgebxs30EtkIpYCAXzrlqkOibj/I7pIyOBtgd
         0a/LpDXi69IbeyrsPPsgUuBcghVq3G6QffEjM9uXvtyB0XGZR12zAa7Idx3eWvWHByja
         CSTZjvE+Y2pxWbd2mnbJG2y15nC1BIG1pua7iRYrc0lMlOCXKEwsGE2JeFN43ihE/8+R
         J/ONB/oqSEwu1LMzU2mSSyA1KyOV24G/D3VNhli33Cttuv58XfThbAt+E7eFZuKB+p/Z
         YZmg==
X-Gm-Message-State: AOJu0YzGiU4ikHg9y0ZCtrph0l9MO0mcAOfj8c+IFd5pbiYbm2m48ujZ
	wyH8+zLmAarch8I8NMzHuhNl/QL/SzDRh961YWoruvhjQCQ3UrLL
X-Google-Smtp-Source: AGHT+IFVaO6UfEGZZs7onSCc6yna2Eo5pz7ReZec3ds7nPmJRI5cGABtimENzRY2tqxJnmvmTbBFow==
X-Received: by 2002:a05:6512:e9c:b0:511:4307:f6a4 with SMTP id bi28-20020a0565120e9c00b005114307f6a4mr5923350lfb.60.1707144114191;
        Mon, 05 Feb 2024 06:41:54 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX88uqq94ctAtYY5c7sacDO/mc/xq1yTBt7MutneLk1fxbDFxFnrUqfkfrX+/2NysP2iQsjW4xonxT3KE1kF5MpjwTILsBzMOdea7ne+ly7oBGKjsfe0xlEya8irgAVwN+dF19f/0q3TnHmtjG5DuSnRZ6TCFYYkFc8T3MpwW16VBoiPxpcbW8k0ztIXJnlxvF9FvLhDr6pXjrhJOpKcqqOJmsUlbOfzfqADyFN
Received: from gmail.com ([2001:1458:204:1::101:b2a1])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a35d7b6cb63sm4377770ejm.28.2024.02.05.06.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 06:41:53 -0800 (PST)
Date: Mon, 5 Feb 2024 15:41:52 +0100
From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
To: "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	industrypack-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipack: make ipack_bus_type const
Message-ID: <ZcDzsP8mRl3Rp9bx@gmail.com>
References: <20240204-bus_cleanup-ipack-v1-1-aef5e8f84d01@marliere.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240204-bus_cleanup-ipack-v1-1-aef5e8f84d01@marliere.net>

On Sun, Feb 04, 2024 at 05:00:13PM -0300, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ipack_bus_type variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> ---
>  drivers/ipack/ipack.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ipack/ipack.c b/drivers/ipack/ipack.c
> index b1471ba016a5..866bf48d803b 100644
> --- a/drivers/ipack/ipack.c
> +++ b/drivers/ipack/ipack.c
> @@ -187,7 +187,7 @@ static struct attribute *ipack_attrs[] = {
>  };
>  ATTRIBUTE_GROUPS(ipack);
>  
> -static struct bus_type ipack_bus_type = {
> +static const struct bus_type ipack_bus_type = {
>  	.name      = "ipack",
>  	.probe     = ipack_bus_probe,
>  	.match     = ipack_bus_match,
> 
> ---
> base-commit: 41b9fb381a486360b2daaec0c7480f8e3ff72bc7
> change-id: 20240204-bus_cleanup-ipack-7e502021db1f
> 
> Best regards,
> -- 
> Ricardo B. Marliere <ricardo@marliere.net>
> 

Hello Ricardo,

Thank you for your patch.

Acked-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>

Greg, would you please add it to your misc tree.

Thanks and regards,
Vaibhav Gupta

