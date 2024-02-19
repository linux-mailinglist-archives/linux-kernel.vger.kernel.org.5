Return-Path: <linux-kernel+bounces-70784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA131859C58
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC3A1C21159
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A9E208D3;
	Mon, 19 Feb 2024 06:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LsmjvJoZ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA6C208B9
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324783; cv=none; b=RLh7O98AQUqcpBkFz13aED+a5bSOv3S0DImH7W2xn/elBuwdJMkPquSGE93IIpFgRlzEdAKt3+3PTf55g5o6wVg4EFANWp0kFtnA35B16ZXOgG/byrQ5gdqPUBcWlP7o1zJkLLqN/yoK2e5Hd4TjngQH63wmrdIyyuP+/vCD4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324783; c=relaxed/simple;
	bh=sjRZqFJmGiF9TRp752LBLHHMjWNbBVWBekq9/44Ejzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeDfctyx27kdJk77JNmSUE4PxBU83PgDycqXAupG2iO9p3b8MfAgKVLUa7RnJPpXwoP3+OslAAmL3bIiMf5tIxWUSfuht0aR8UP8xmN4HS1owvSrdPSwo1YrSN1K5pnUJMcntycTQ8JMmI9xqqZp8lORjSm7rx4TG1cA6o44U8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LsmjvJoZ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso3613652a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 22:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708324780; x=1708929580; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AmJlj9IwjLF3l7fXdAXhun2W1nnG7kbqGQDiD2NuR8k=;
        b=LsmjvJoZJDoUG8syVAf2jKckEZUfFgaFwqYAtrdDqGqE2B3zEAYxacJDdY1tqwGS3c
         urrQMldzFEMMts58XvRFOnMvoAUi55kEWXwP/fH/5g+QSuKjx30bTL4QxGS6EhbfDgp9
         tTXvhMuBK3DJTQEHoofhAzdpeMlKnMR+8bSgF15uYVwGxjBbFbJqUrebAoHewFNdznzJ
         MzI6SqPg9JH9KnJc+IHuxosNZD/k20G7DwFU79+XlRPrZ/ld7C+6tnepOjWRJqMD5PWu
         oI37pjt6zxkCAi3sqSKrm53IjaAJVFH5tB0qfxxa8yYoQgtarHWnH9ZcP5/WjFp7M9pl
         dmpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708324780; x=1708929580;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmJlj9IwjLF3l7fXdAXhun2W1nnG7kbqGQDiD2NuR8k=;
        b=I1YMh2vZCRLYcVPKsEKPIrVVkd/DJ8N5gMd5EdZMXlzvSK4JnQSBSK6M+0eJyBp5Y0
         Ve1G94EFh4FjXetTpazDGx7GeOFOrHyJdd4dGzmgTwKJhzBp8eNGKG0xNDRnlHQV+Abz
         CoWzrj/oMZ5QZbBZfxP5hbJdYtMk85ZA9Hg9taHUYO2PLNR9ThpagcwBmnpcGstsWjOT
         5OciXMRtLgj0MFqpRqaliLYCTB2+X9Z4tIxZt3hppUgJrGqDjvbKh5TEo2VYDfw4dE7J
         oFy1mgH0sYg6+i2Hxmv+/Zk6fRU/xPIjEQOPn6860LitRDGtr2w9DAOQVIU38QjgFv1r
         qbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi6j4kWiOMvqjJFvWlrPQrOSjR8Ex9kOkTYjhIO8HiInJXAYRuNLot/+1hcla/RfZrrXTJBPbBVHOzhwTfYA/I2iwI2NZ2cELwwQ56
X-Gm-Message-State: AOJu0YwAyH7MzxT8PP2IG3j6z+b9xTIeFfalNxjMfgcWdfVsNHQzYXnl
	CwWQFW4brzhKTDc9cQmXI7fIEgvXyfxGvtGTubHjPI0Dx+GxbfFkp8MI52tK7LU=
X-Google-Smtp-Source: AGHT+IE0lRySbhCpT61lK2s4dp+A3WXUcUSWKSoMrTpO4ff5uUV/6rODCAr8djn3WbbOkL261QrRJg==
X-Received: by 2002:a05:6402:784:b0:564:7962:4553 with SMTP id d4-20020a056402078400b0056479624553mr865356edy.16.1708324779644;
        Sun, 18 Feb 2024 22:39:39 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id eg43-20020a05640228ab00b0056454c668f9sm1279229edb.53.2024.02.18.22.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 22:39:39 -0800 (PST)
Date: Mon, 19 Feb 2024 09:39:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Moritz C. Weber" <mo.c.weber@gmail.com>
Cc: florian.fainelli@broadcom.com, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: vc04_services: bcm2835-camera: fixed several
 brace coding style checks
Message-ID: <8fe8c4bf-5fa3-4bfc-9535-b48df12f80ff@moroto.mountain>
References: <20240215220647.4096-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215220647.4096-1-mo.c.weber@gmail.com>

On Thu, Feb 15, 2024 at 11:06:47PM +0100, Moritz C. Weber wrote:
> @@ -406,12 +405,11 @@ static void buffer_cb(struct vchiq_mmal_instance *instance,
>  	    is_capturing(dev)) {
>  		v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
>  			 "Grab another frame as buffer has EOS");
> -		vchiq_mmal_port_parameter_set(
> -			instance,
> -			dev->capture.camera_port,
> -			MMAL_PARAMETER_CAPTURE,
> -			&dev->capture.frame_count,
> -			sizeof(dev->capture.frame_count));
> +		vchiq_mmal_port_parameter_set(instance,
> +					      dev->capture.camera_port,
> +					      MMAL_PARAMETER_CAPTURE,
> +					      #N(#O(#O(#O(#O(&dev->capture.frame_count,
                                              ^^^^^^^^^^^^^^^^

Wut?

> +					      sizeof(dev->capture.frame_count));
>  	}
>  }
>  
> @@ -420,11 +418,11 @@ static int enable_camera(struct bcm2835_mmal_dev *dev)
>  	int ret;
>  
>  	if (!dev->camera_use_count) {
> -		ret = vchiq_mmal_port_parameter_set(
> -			dev->instance,
> -			&dev->component[COMP_CAMERA]->control,
> -			MMAL_PARAMETER_CAMERA_NUM, &dev->camera_num,
> -			sizeof(dev->camera_num));
> +		ret = vchiq_mmal_port_parameter_set(dev->instance,
> +						    &dev->component[COMP_CAMERA]->control,
> +						    MMAL_PARAMETER_CAMERA_NUM,
> +						    &dev->camera_num,
> +						    **sizeof(dev->camera_num));

Also Wut???


regards,
dan carpenter


