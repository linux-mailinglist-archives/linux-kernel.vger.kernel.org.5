Return-Path: <linux-kernel+bounces-149320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6388A8F84
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 01:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1905C1C20DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 23:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63231487CE;
	Wed, 17 Apr 2024 23:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z078YmEd"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC384084E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 23:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396991; cv=none; b=JmRAktXQ5RYT4MEMa+An4snjRbGriRE9s872v9A7q8WdPQG4RlBtof38IxZEz82y27FR96oKETvGig7q4AiVt/FYTYfoGiRgp3wCVaWO3uzhFq0Wb5AUHKabkpLjhBlomNSvlMiPn5fea3jsXv/pujiNd0M3vAtPVZjaSsgYBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396991; c=relaxed/simple;
	bh=GAPp6KLkBdhPjfazIrelmotZOrQrWW6euSb4wdA8LNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB/EgQh8R+wZRIrvEGnXpc7CzpL7J/Y5eaxgBsZBsboIc91WjU5QnBcdloR/TySHOEVMRzO4wchhk31B9niR4lP+d4sApW5YjAcspyWm7ggueTW0mV3h+sr3HR2xueGUe1y8ghfCY4LvAFykS/BAXXLLlujrnJ4Fr2Ifms8sMC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z078YmEd; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518a56cdc03so231850e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713396988; x=1714001788; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+aUpmgDVeLgvB2gSLG8XIN5pGL3HNCRw5PXYjYZlX2s=;
        b=z078YmEd3J+ekfZVuXGd5k2dVlANTEtMTYBGunRFdKFTvvfB4Bt/yL1wd4619sYlkB
         WI+wIcTu6vt37zzJuKCH2gO6IbqjQwkrdJHqp4wQFFca10YYQUZB1dVAEWAf3Pgp+FTY
         V6vexldxcykW3nQfQ218zP7Uj7D4brX1UMxVFqQTDNEs7+gv5L98yEIqlRqeJ8jln2+S
         HQ5AQy1kOnq5WqxecI0rKEbETCTU5SW1rvfX5FEEbNPaL59AYmfhMUtD9qldhJUVEouT
         sZjA6Bpv0x4NdCI5vT73hicyWEta0o1GHADnncTfX1thGwVBmYiAukhmoOT861l7OK6Q
         8OsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396988; x=1714001788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+aUpmgDVeLgvB2gSLG8XIN5pGL3HNCRw5PXYjYZlX2s=;
        b=pME+5B7PCRbWTnMgz06eQUJPYERbb8Jwst/hNOKqFk5q529PRVQ7IIxuosA9XE1j45
         kIZhDz/qMjIKh6Y3l8U7EQ8E3B1oZHdg4PX8O4AB5vkgBV09s9t/t/8gsvtF+WoReMSD
         PLoBsgRicI9bHYhFBgJ0lStvlrddJOdbNxXUl8cibuOirSFJwge96vv/4cniM9RFGKWo
         EHXNVr6n+/eWzwaHarUd/3EYQmbvoR0iziOtkAtmgK3ldV5sDXAFflBPT2CY7v+nvH2W
         kUSBGMpsbsjYeXZ5CFBqq4JsjUXaLSq4Xpu98MNBazS4krctnIVgo+GYmMo6z8El20fp
         J+4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVw3eJGFIEhTv9pLsmD3nq/1nIzqOEZW02EAsvWM/611rYRga+LjsNcjJWNQOSFxwQfqSlUxWf8cGK+oqxzkSoLMbKsRX6r3AAG2KWF
X-Gm-Message-State: AOJu0Yzzo46xepSvoWMJBlLHxQGHwZwqiz3ms/Xs7k6oLzxDegtWDNJU
	nmjn2SJDlsJmhiQe1YrYqgfALervds/igvCtyMYi+fUqWW2blmfwXbTk1AJ4S4s=
X-Google-Smtp-Source: AGHT+IERQ79ZpiSXTN99GLjWRAUeUxpJZ+H08cR71Lgik0OTCXPJvVrs/pYv2CJjCEnsG4k28u0TvA==
X-Received: by 2002:ac2:5234:0:b0:516:d0c0:3c5 with SMTP id i20-20020ac25234000000b00516d0c003c5mr348212lfl.24.1713396987745;
        Wed, 17 Apr 2024 16:36:27 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id eq22-20020a056512489600b00515ce9f4a2bsm36470lfb.35.2024.04.17.16.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 16:36:27 -0700 (PDT)
Date: Thu, 18 Apr 2024 02:36:25 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Herman van Hazendonk <github.com@herrie.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] component: Support masters with no subcomponents
Message-ID: <4xywfprr7qkxpncmnhqjc3lrrcjbv46tsmlzz5yxvcr4xr2dnq@w57ni7u2hpvu>
References: <20240417-component-dummy-v1-1-b0854665c760@herrie.org>
 <CACRpkdbijfwYFhg2XigzVKoPDjU00K+arqaL_kP3FNxsS82gHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbijfwYFhg2XigzVKoPDjU00K+arqaL_kP3FNxsS82gHg@mail.gmail.com>

On Wed, Apr 17, 2024 at 01:39:16PM +0200, Linus Walleij wrote:
> Hi Herman,
> 
> thanks for your patch!
> 
> Do you actually have this working on real hardware? I never
> submitted this patch because I could not get the hardware
> working.
> 
> I was hoping for smarter people (Dmitry Baryshkov...) to step
> in and help out to actually make it work before submitting
> patches.

I have LVDS working on apq8064, but it requires fixes in the MMCC
driver, in the MDP4 driver and in DTS. I need to clean up them first
before even attempting to send them out. Also a PWM/LPG driver would
help as otherwise the power supply is quick to be overloaded by the
backlight.

Nevertheless, LVDS/LCDC-only MDP4 is a valid usecase, but it has to be
handled in the driver rather than in the core lib.

-- 
With best wishes
Dmitry

