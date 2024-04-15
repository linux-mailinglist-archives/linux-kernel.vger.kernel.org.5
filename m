Return-Path: <linux-kernel+bounces-145957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDAA8A5D40
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F01EB23110
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B416157A7D;
	Mon, 15 Apr 2024 21:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRiLQj3F"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A3F1EF1A;
	Mon, 15 Apr 2024 21:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217973; cv=none; b=a7KBq9GpTXvC2AUzIMu/Ld769TtwA7U/vPd22welGbrvmNFWcKjIxxPdsCAx4UA6wivHbnTHbWLKBkrOA5kcszxaPjC4Yh5FByLcslLX094fMIC2AB0a7IiueVbvsi4gaD0q/3VuFFCuwOifOjd/S7nLl017L/bWHDcsAt6GF3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217973; c=relaxed/simple;
	bh=EIxqbtF7X8OJhkSZ34XcJldP6NaBP3TS/sc+R0KsL2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TWRnSTh26e6G1wGzVQSxsHbuFa0ECuLM5klxo7anxePBdfaEZxYlqpzZfmzcOYlVu6b6tnaH+K7zcET2sdnBBlgy1i5gcJTuCHJqREsc0VI/MvfxM90EpKzbbbCt6LmRtmOYpMiPjv8GRQuKb/Xqv2inDuvFIuNubxA0GIeI0K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IRiLQj3F; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so1315250b3a.3;
        Mon, 15 Apr 2024 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713217971; x=1713822771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cS+AQ4/IMpU7MMSTgboRhawXdBLtuI6SDixG9B9jWWc=;
        b=IRiLQj3FoxjfwfhcDPK8v2ja80lbjwIgTyRUnli1pxNpRlVMhCU1MIPvrgoLmeIMFK
         Qm70lB37qyIA1/lVi/veAk51Ed8ynv7I0DUMGMEDk6US1vWQRlj/w4k2hLVEAJDwyLUW
         BY/mmr0KbmX4cXpft3EheePnfimWz5RAL2+ijtRPVOWmI5cYiHVFGK+c0PxFv3UxqcyS
         /bnPAkwQ2WxKqLsNzg+wKTuc9SlyYO87LZz+RYwvtYzHjBVCG9YKpvmyDluXtJXwJ3Wl
         YwKV/smXwH8XYTYbMTjMCcthTRxtVBXuDmlPDLPQD2IZaAUKnM6a4HutQaT8enVSwiFe
         zs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713217971; x=1713822771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cS+AQ4/IMpU7MMSTgboRhawXdBLtuI6SDixG9B9jWWc=;
        b=Y5PXwVGagLxPzroqg94rsHfmgNjPQLUGRG0WpdPMk/vP70FB2DTHN1hQhTWBrJQywY
         9m5uNPkUtLqwcpAsOxV4Q9o7HVecGgWKh/whZCGzMxHav/S6NrljJLTAHwCQofY6y10v
         q+ZIgaeNvXfcHnFtZtuY1r6AgOYT4tjhZWXUp+SLAXcSO6fILaGbMTtvAVRSa4LSudqA
         hZI9jLvObJIH9X3vxHapCsdY01kTsMKiwN5eYtJcJBRa0kW9w/6/WMRnB2FVrRHbl/Y1
         U+XFkpniK8ank/R4oBb9rSPTFhQgLotYKKjI8I4+hsmRNO3PdomXT5WwatZeYDcBIZHK
         OtRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhX7aO4aAYHzbACEjTC5QkNLH2tvWE+UFhe4UW9ZA55DWqiLt6L5Y/Qzuj14QK1dde4ywstbEHhNr+JCMi0bt78/Lo4ZTZkGJUf3LYvsFwo5X+wl7CHHHBNhqlXoX8uZ13474bRyBWLE744rEvNFr1Fis3uL5P6cuewWb4ghwWxbUJayUl2w==
X-Gm-Message-State: AOJu0YzQWohgZ/3bLpPJZHuPD2s5/oPRV7XLFNdfDjzyIo/svlz11yYH
	AJxwR5NPEvf6mDlhowPlOeTDMKpe5p+t2yC6olhfjrLubv2JDayq
X-Google-Smtp-Source: AGHT+IF3SE/VJ1vR7YdcE8vEvkSOWp4GAlyCk9/WmmCdu+ql9saddBk2le+lxsTZR8+tF2YMZVzKQg==
X-Received: by 2002:a05:6a21:8015:b0:1a9:9c20:6ca with SMTP id ou21-20020a056a21801500b001a99c2006camr8921350pzb.23.1713217971334;
        Mon, 15 Apr 2024 14:52:51 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:fbbe:421b:9296:f28c])
        by smtp.gmail.com with ESMTPSA id d18-20020a631d12000000b005e83b3ce8d9sm7486079pgd.8.2024.04.15.14.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 14:52:51 -0700 (PDT)
Date: Mon, 15 Apr 2024 14:52:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
	Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: Re: [PATCH 6/6] media: touchscreen: sur40: convert le16 to cpu
 before use
Message-ID: <Zh2hsNpoaYs7GvCN@google.com>
References: <20240410-smatch-v1-0-785d009a852b@chromium.org>
 <20240410-smatch-v1-6-785d009a852b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410-smatch-v1-6-785d009a852b@chromium.org>

On Wed, Apr 10, 2024 at 09:54:43PM +0000, Ricardo Ribalda wrote:
> Smatch found this issue:
> drivers/input/touchscreen/sur40.c:424:55: warning: incorrect type in argument 2 (different base types)
> drivers/input/touchscreen/sur40.c:424:55:    expected int key
> drivers/input/touchscreen/sur40.c:424:55:    got restricted __le16 [usertype] blob_id
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/input/touchscreen/sur40.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/sur40.c b/drivers/input/touchscreen/sur40.c
> index ae3aab4283370..5f2cf8881e724 100644
> --- a/drivers/input/touchscreen/sur40.c
> +++ b/drivers/input/touchscreen/sur40.c
> @@ -421,7 +421,7 @@ static void sur40_report_blob(struct sur40_blob *blob, struct input_dev *input)
>  	if (blob->type != SUR40_TOUCH)
>  		return;
>  
> -	slotnum = input_mt_get_slot_by_key(input, blob->blob_id);
> +	slotnum = input_mt_get_slot_by_key(input, le16_to_cpu(blob->blob_id));

We are not really using the real value of the ID for computations but only
as an opaque "key", so doing the conversion is not strictly necessary,
but it is cheap so we may as well do it.

>  	if (slotnum < 0 || slotnum >= MAX_CONTACTS)
>  		return;

Applied, thank you.

-- 
Dmitry

