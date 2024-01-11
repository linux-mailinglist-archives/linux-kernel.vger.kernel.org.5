Return-Path: <linux-kernel+bounces-23178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 842D182A8AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D1AE282A8A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB395DF6E;
	Thu, 11 Jan 2024 08:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USfBTSYc"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AABDDC9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50eabd1c701so6067232e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704960164; x=1705564964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKxxuD3H1/DIN5QRJJMMz94OQAGexuvEeKEGvpZ2FHs=;
        b=USfBTSYcpHShaLwuY72MdFhuXHbBNUKYLw4miBST/nhG5QxMKn/3gZhdJqCZg0sbPu
         nHF2YqTUAssJ1pFxpipRQCg3RZxsCaRNabqLl4KFl3h0+A/mUxHkWcJmD6i2gRPT9LGM
         9pH49qpSK8RiMx/kERTNMoxQmyLIDMU264+VO74aa78jmfn3NOzlUPaV8vh894KYEifV
         iKPh0YSViJ2/0YdF9QC+n+FSNpsGzoNwlrsa8cdUvms8s5J32w143gFcsR6PnQPQQjIZ
         wH471PM7/1Upr2yQR6sKo+2Ht5dw1Hk2ieT2apzLwd5vOWMCeZ9TSFQLBMacwm3aczaJ
         C1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704960164; x=1705564964;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vKxxuD3H1/DIN5QRJJMMz94OQAGexuvEeKEGvpZ2FHs=;
        b=Mcf3Mem/NAtqPuuUUCL+nGSWp5f+eKO2GRBAqcpz700xcMdfhvwpXiFbe6ADNhQSrc
         DnB6BSLDCy7TRrkWLyB99FZI3D3tSMaNlsp+CjaAi7yTBufVwNPgPGtuQcXUV7mNrpl4
         YNncMZh0Hm6DDMXD1PEWJ+7CVGoZ3ko6WENWEltYy01hfVYpTysKHvl2aPhr3VmZD6CA
         vYzcXgtaxtgVGU1YYtA9eQgaKA0o0l0nOewUeRvh4S5XSfUymEksy+iT6ps19GdV2cg9
         3B3xfflO4tUwhlCXQs4D2uERVzDd0vTHAdbuViG2gm2rBAXlkGzYd/rzgBzDt0WqIrnx
         NL6g==
X-Gm-Message-State: AOJu0Yz0dzvRxcmPf6nCC0dt3T0jpidrxADEuvheTniPvM65FqvtwQU3
	LhIQFN0v9l5f/bZXQbGNys8=
X-Google-Smtp-Source: AGHT+IE+cflWxnqrTu8nKruzZQZ+XhqCz9LY20j6/G+0yYyso0tQ1rLPm6HgDdtJYv8dUH0qT0Be4Q==
X-Received: by 2002:ac2:5221:0:b0:50e:2551:c8ce with SMTP id i1-20020ac25221000000b0050e2551c8cemr378337lfl.119.1704960163317;
        Thu, 11 Jan 2024 00:02:43 -0800 (PST)
Received: from localhost (81-226-149-122-no518.tbcn.telia.com. [81.226.149.122])
        by smtp.gmail.com with ESMTPSA id k5-20020a05651239c500b0050e7bb8c7d9sm104793lfu.239.2024.01.11.00.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:02:42 -0800 (PST)
Date: Thu, 11 Jan 2024 09:02:41 +0100
From: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
To: GuoHua Chen <chenguohua_716@163.com>
Cc: airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de, 
	mripard@kernel.org, maarten.lankhorst@linux.intel.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: Clean up errors in cdv_intel_dp.h
Message-ID: <fhuiv5zj4t746eqn23puj7uog2uqdx7erzlsiwgrj76y7qjgx4@3rlihcbwacdf>
Mail-Followup-To: GuoHua Chen <chenguohua_716@163.com>, airlied@gmail.com, 
	daniel@ffwll.ch, tzimmermann@suse.de, mripard@kernel.org, 
	maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240111065648.9170-1-chenguohua_716@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111065648.9170-1-chenguohua_716@163.com>

On Thu, Jan 11, 2024 at 06:56:48AM +0000, GuoHua Chen wrote:

Hi,

Please use the correct prefix: drm/gma500

Also, the change is made in cdv_intel_dp.c and not cdv_intel_dp.h. This
seems to be wrong in most of the patches you sent.

Please send these fixes as a series. That makes them easier to process.

> Fix the following errors reported by checkpatch:
> 
> ERROR: else should follow close brace '}'
> 
> Signed-off-by: GuoHua Chen <chenguohua_716@163.com>
> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index 27cfeb6b470f..135a1226df1a 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -735,7 +735,7 @@ cdv_intel_dp_aux_native_read(struct gma_encoder *encoder,
>  		if ((ack & DP_AUX_NATIVE_REPLY_MASK) == DP_AUX_NATIVE_REPLY_ACK) {
>  			memcpy(recv, reply + 1, ret - 1);
>  			return ret - 1;
> -		} else 
> +		} else

This doesn't apply. Not sure what happened here. You're removing a
trailing space but the error in your description says you need to fix
the style of an if-else statement.

-Patrik

>  			if ((ack & DP_AUX_NATIVE_REPLY_MASK) == DP_AUX_NATIVE_REPLY_DEFER)
>  				udelay(100);
>  			else
> -- 
> 2.17.1
> 

