Return-Path: <linux-kernel+bounces-71318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3EF85A376
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 13:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDB5E1C23815
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6991E2E847;
	Mon, 19 Feb 2024 12:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AIqzeuSe"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B92E410
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 12:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708345924; cv=none; b=hMtSgtrWEluGyi99XSem9VfZW/549w6FUxz03W5NUyyyCtuKWpu21w5WBxczbFdPBdrLTEYd9eg7MqGDP42NVDGvb2w71Y33dT0Fxq72RQ6QS1s9KorHhslkjFHfe5b+zdQ1PxC5aRn8/qLUKQwGUUE8L2JQid1pUg2N0knnvXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708345924; c=relaxed/simple;
	bh=j6578wxWKqcx8ONxEVdRiQYKPP0Syiq2K9w0PPf/ewo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKPcshwJFo+5xKK/jLJ0T1XMgPOUpryGqR2/hQa7bEdn1GWfPzxAFmwmTGbIvtEfPKqsZjy9FhyIHv+cBFYOo54Cx3aiSwOdI+WsYAKN2BG+BUh1VWvong83SEzWDyB8E4VGUvhIAkZq5SpP09YNjjlrG9q4JfrD2YK3IYN/Lww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AIqzeuSe; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55a035669d5so6874793a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:32:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708345921; x=1708950721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H5rTBOT512LHdHzuBKt2E2Za1VrV48YhxTWcmimOXXM=;
        b=AIqzeuSeZYg137oUl4Xet+ISHfWTpkcaMMD+rffcceD3VIB4aJ/LWyHrnosyWw7gsZ
         c2PmMQCUfise+JZd86B9I8xXAJhkA5RJ7ILUX2nlLGy0GsAD3dnqv8RZbSEIwx7dqbqI
         eyuZX6r/ADjG8KN3G2oTS3TVpbwez3dnKfjDEBtogUSSgfVtL9866oZsDd4BzXW8z/WP
         nwVp119okOyDdvn5zA374AospP6XSW7lrRzWiqQeyfbci3/wSjushcLLWpXMqb9oc79S
         zGVWtLao+xdGYm4jhtdO39ByG4D+dTAGy0nwPrdNVY3cNbq4FBwlIiiq95hKPbQfQWcc
         +5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708345921; x=1708950721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5rTBOT512LHdHzuBKt2E2Za1VrV48YhxTWcmimOXXM=;
        b=oDztKqKV9ZFpBu8NqnuZZGIzjDBik4DMuFETb4U4QGRvmwg71OSWJRE+026GCmYoGk
         eqEYYJzlOUr/RzGX3rf3oUNzQiiEHNfn9chfrsYRGATEN6/DTEfeinUSxq/sw2H2w/2r
         9q4DPveAqnROEaCBgw9RnyaKp7+FKGski4yQ782N0rEm7ygIGMDG7A8vPO5AkcGweAd8
         BCrrvTY0Ak3HWmlNSMELQLC41zer1/XcMomjBBt+8dDmnV+IL8Pnx/YAqPgShO7gm+3L
         HUkEQgqj/O7jSZQLERRBy6dIaAcJ5BYONujaDc4NQYQq9KVT22PFmr1vVUagy3cEnyhB
         BIGg==
X-Forwarded-Encrypted: i=1; AJvYcCXYlAA0zGw5oeCTF/F1hsbrIzI1XEP4QMv9uSK76brldbPRAOi2hjz+QVcvAPY8YEzP4tQF0/FJt9+0FtEBZsPtE+2ywcZskC0vJIXd
X-Gm-Message-State: AOJu0Yw4EPFgkv4IYp9AvrPysOXdUP2zesQrgZuq0bY43L4Uc5yacpEt
	OLdEW6pOVjYiCNNtggWoAuLoZFHzInnqH+6k/DsPUGSeT3uZc+d54eG2f9XmppQ=
X-Google-Smtp-Source: AGHT+IEqPkau5gA1xSLGNYFbfj0SBd1j9tWIVJtBLMtRG5TURWbjPOmxSGxc5PG7FWezTEwt4jfqrg==
X-Received: by 2002:a05:6402:14d0:b0:564:66c1:d527 with SMTP id f16-20020a05640214d000b0056466c1d527mr2208068edx.36.1708345921462;
        Mon, 19 Feb 2024 04:32:01 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id i7-20020aa7c9c7000000b005649f17558bsm348699edt.42.2024.02.19.04.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:32:00 -0800 (PST)
Date: Mon, 19 Feb 2024 15:31:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: "Moritz C. Weber" <mo.c.weber@gmail.com>
Cc: florian.fainelli@broadcom.com, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Staging: vc04_services: bcm2835-camera: Fix code
 style checks
Message-ID: <4295c4b8-bcee-4a7f-8960-80b6d3934530@moroto.mountain>
References: <236d985c-1835-410f-b0b5-cacbd5fbf930@moroto.mountain>
 <20240219112234.8673-1-mo.c.weber@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219112234.8673-1-mo.c.weber@gmail.com>

On Mon, Feb 19, 2024 at 12:22:32PM +0100, Moritz C. Weber wrote:
> Resubmit these patches to address comments to rebase the 8 v2 changes into
> 2 patches topicwise
> Fix patches with same subject issue based on v2, which fixes multiple code
> style checks for better readability, consistency, and fixes typos from v1
> 
> Moritz C. Weber (2):
>   Staging: vc04_services: bcm2835-camera: fix blank line style check
>   Staging: vc04_services: bcm2835-camera: fix brace code style check
> 

Looks okay now.

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


