Return-Path: <linux-kernel+bounces-145727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE5F8A5A13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 20:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD3762840A5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511181553B9;
	Mon, 15 Apr 2024 18:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pWt4E/ZV"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0872B154C02
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713206655; cv=none; b=EYsM3GNFhoT0BoemhKH/GRf8KlscTba/5HIiEJhqCpBRyR8PYnRHMnD7jGPd66TAibSs5WaDguz7GnIlrArwZ0U96cOzz/YrJVlvW5hpJBni6gslSkcqj+HAG8g/pgjp39leJ+iANnU5LbXYXOr4G55ZHAQn2PyXhzu1Pm8NUp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713206655; c=relaxed/simple;
	bh=60i9If0tq0o2mZLjvpsyWL4GCs+3OULSbJ4F5ixEQh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qhq4hPPWnK3u4+IX0S300+SrRjEPzDRMTVcmTwuIgMNd38WYU0AEnwtR6F7CjusOlKgWAjdmuRHG1c2DuVd6HzkulkjMAvxoFmV2+UdRikxORlgRaZJq0kV/Sm/qfVgc6TqbDJ9hxWr354zdRgyymJ2Xxfgx+VPMzIDwvDxJns8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pWt4E/ZV; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so4411463e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713206651; x=1713811451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oD18VQRDP+ap0IgBvoFVrf3gThgHXlFnC51QDZapYN0=;
        b=pWt4E/ZV47rvg/l9MhncS2Wbv6we6om8ENaiHytvWdALltn/6IxlWenASiTKzznZ55
         EwpJq5tgs3B/CGE5NXH65WqFxoVHypQjKb9QRnT4Y80UMENLa/vfhyr+abDFZ884MJMF
         VfNSb4AtsjQ824hjkwzVmFeyq6igTx8haZ4SVN/dFGcA5X3kh+l2WhYo7iRbdaQkREMn
         v30vMmxZbkj9U/QRVV6uua66wycE6eWW5ARVeOziS3gMWLWzfZRuW5NWZp/P3SGNgskM
         fo8cnu7SZLjzZ6xHAo7O8xmyW1DJ0ySNA5k9U66Oa7cvv6bPhYQgOQXbvgZuZdcbymRl
         7QeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713206651; x=1713811451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD18VQRDP+ap0IgBvoFVrf3gThgHXlFnC51QDZapYN0=;
        b=daM3Nx5HwG8wU2tacfP+4EhNbblpXdlpg1pUTu85j23ZYeXJQ41H3SDDk1Nr5Td3ct
         bkSP8zIxctyMK7lA6OFdG44/c0R4niYeKk32ZnlSSB0I+CXfCwmsgFJmUmiVsn/zHago
         uGgDkCMfLob7ea0MbXQOKy+iiRD+0viW1k0kytwKOsHKIRVsWqxSR3xc4pskVjwSs330
         p3U7QFmS49fMMEFjBJPi1xFhZytxuol7wqUAC9rUfzTWz7oYU8swO8s8YTpbIoXlHXGw
         HSPlDmpQTfLXtEpYSkqsJn5FK/ddcPrJ+pqdUux/RQ3ZQXjTX0l/D21S8sk1jMF0DaOb
         5V8w==
X-Forwarded-Encrypted: i=1; AJvYcCXFYO3jnZkKVVSLoq6vwgPIEKcX2bL+5wbS21CpNsaHOaOv/VFNY4TsAECvesyS/l2mORkQHoEk93Zzw5QiEOGPcklQGg9D4BetG7Jt
X-Gm-Message-State: AOJu0Yy6fyFTzcPqhbJ82yv/exm115UR1AsQHVcfFfH84IIPN6z4qlyL
	YiVoLAackOze27/hLjy+nBM7zR5uiSzQW/SYlYtvKi57AETkxF692STObxRhoRM=
X-Google-Smtp-Source: AGHT+IHknDAe+KUxipXpx+FV+BhpaJIDcUIdMXSJOmosuICRnKv+l0P7B2XTRrhaFBoyLOftrYjAkA==
X-Received: by 2002:a05:6512:1081:b0:518:b7dd:36a3 with SMTP id j1-20020a056512108100b00518b7dd36a3mr4385673lfg.54.1713206651050;
        Mon, 15 Apr 2024 11:44:11 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709060d4a00b00a46a9cdcfa5sm5742455ejh.162.2024.04.15.11.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 11:44:10 -0700 (PDT)
Date: Mon, 15 Apr 2024 21:44:06 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sumadhura Kalyan <opensourcecond@gmail.com>
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	gregkh@linuxfoundation.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] staging: vc04_services: Re-align function parameters
Message-ID: <1791cc7b-2ea9-406c-b958-61f83736a986@moroto.mountain>
References: <20240415171138.5849-1-opensourcecond@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415171138.5849-1-opensourcecond@gmail.com>

On Mon, Apr 15, 2024 at 10:41:38PM +0530, Sumadhura Kalyan wrote:
> Checkpatch complains that:
> 
> CHECK: Lines should not end with a '('
> +typedef void (*vchiq_mmal_buffer_cb)(
> 
> Re-align the function parameters to make checkpatch happy.
> 
> Signed-off-by: Sumadhura Kalyan <opensourcecond@gmail.com>
> ---
> v3 -> v4: Repharse the subject line.

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


