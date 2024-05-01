Return-Path: <linux-kernel+bounces-165350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 722D18B8B98
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FC31C210D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495BB12EBE6;
	Wed,  1 May 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRiDdFzy"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE42B433D4
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572056; cv=none; b=BtZWklhnXO1ObasnjVyG9/QvN2QHY4lZ6VqGJITjxiyIhYmaOVIprXKsqcLOEWeMm1Hvjz8Q640SJAQ+4X1mLt0UxP+s/qton/AtQTHMSOilNjfby54Ff836wDnIqVu2UT+amqz4xvD8Usb1mWByvyogpiAjYOArHe2LczAnzkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572056; c=relaxed/simple;
	bh=rdAIHRb5K1bT7Od1HyC3wAX9P/OYSoTvMRkvbnnLFZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7eM2D5U1R07qkXzCbqR99k4td+mv4qB9kf1DOQzbyvcX2S28pPD43iQeofH8D45OkzncwS+uvQqE8uIJMNL9FeJUHLArj33Aa3CaU/d3jqUZ9Ezh4ie7UlisQMH9Zj2jI5Exnwe7gcRg8WLvinT+2cIP/4xEQ2SkgY4kzVXfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRiDdFzy; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41a1d2a7b81so4390105e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714572053; x=1715176853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ce2ghPDIUabAJ7BTjIQdi05k+ciDOHn/xruVAQep5Rs=;
        b=YRiDdFzyvXbRV0lWN+NP62wNgE4BdxE+QIFhuCQTLEukyMUZ2wyv1sH6b5MWgSKskB
         KbhAHHktWIw9YMf6r18tDfuc+iEr8k1KL6q+kJdqXY3FoCezaRB/s5CD/3ZPOPKxtBsS
         OXGIAjue0HqIGq8jOhQH0c04n2gCa2EGGvBllqjR63By+i1RVGxDkH/SJPf4x+2RQiGQ
         VCsauKVylD5wTqRMyTGMw3uMIO4HtPMPrELfyIZzekjQyMWS3lZK7BUBOY8WPfyKcjT9
         nFvPct2v/etEMdW/7PyY81J4Y44K/MOScqM3FemJKwvV4U5Bvgak7XD+LZZNd1Pm8bRh
         U0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714572053; x=1715176853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce2ghPDIUabAJ7BTjIQdi05k+ciDOHn/xruVAQep5Rs=;
        b=ihRIwEMu5GLBX4lehy42dUqTeXzNDe050cTnRop3ovbX66lw9Sj7aiTIQg2aIZbgO6
         TUY+miHrvQ/PV08+vcTWy2Gdg/hK976afwR+Ye3oLKyunTzqrV/PkU2oW1k0m2h4HMWm
         7nGX+fJDhUysF+efMBuNTVYxt783U1qqzffLEkjhPOX6xeYSqEHhrVeIi4k7dIxwitgh
         g8ffRSyRkMZgACKNWxiWaFKWRYwtbmvuytAH0rmEz3Ze0U9MdTkpRj86xiMpbzPmIw0j
         9Oct8fG1QzseVknhS+Dvd3C97429fXI+KUkL8/LOtt3Nk8NKZco6Mu5RoPScJMj2k8C2
         4ZKA==
X-Forwarded-Encrypted: i=1; AJvYcCUFj80sbEh6uXjLFmM1RB5qsi1+1BBpjKrpQGMGB4VKmfoqb9uYrE3Wpfhx14USxcrHA50W0M63N0jy8BG9Y9cF5ZiptfJjz0O5DNf7
X-Gm-Message-State: AOJu0YyaqhDt6+AiDVFnpUhiW4ZBLD3VbQB+5CWzlMy+3g4VgUWkLHIu
	0yJ/wF5gkxdlPHt/WxawTbqmD1zPGmdBK7N0GkCivKlwD44aVrlk2g2oaoxF9lKLLW8pQBdij/T
	4
X-Google-Smtp-Source: AGHT+IEhJeHYMc24dikdGnQsg7CdYY79Z3xZ0Or5bhU4+pyqRK8XrrawQDghDkZ/w6GQsTHKEF5j4w==
X-Received: by 2002:a05:600c:4e8e:b0:41c:2334:fffd with SMTP id f14-20020a05600c4e8e00b0041c2334fffdmr2398224wmq.9.1714572053033;
        Wed, 01 May 2024 07:00:53 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id bg4-20020a05600c3c8400b0041bf29ab003sm2313844wmb.30.2024.05.01.07.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 07:00:52 -0700 (PDT)
Date: Wed, 1 May 2024 17:00:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
	andriy.shevchenko@linux.intel.com, robh@kernel.org,
	felixkimbu1@gmail.com, krzysztof.kozlowski@linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: pi433: Use class_create instead of
 class_register.
Message-ID: <cc00ea68-0ec9-40af-a147-e8f67f7f29d0@moroto.mountain>
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-2-ikobh7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501055820.603272-2-ikobh7@gmail.com>

On Wed, May 01, 2024 at 08:58:19AM +0300, Shahar Avidar wrote:
> Make use of a higher level API.
> Reduce global memory allocation from struct class to pointer size.

Doesn't this move the memory in the opposite direction from what we
want?  Originally, it's static const.  Isn't that the simplest best
kind of memory?

regards,
dan carpenter


