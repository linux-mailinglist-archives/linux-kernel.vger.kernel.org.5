Return-Path: <linux-kernel+bounces-123379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE49890796
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7D22A247D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE198171A1;
	Thu, 28 Mar 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1DNL4FE"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A452D792;
	Thu, 28 Mar 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711648331; cv=none; b=Mt8elujLByMgdGBYUxifRD6UhLEAtgxZd5Q1tj7tzrzg6l8Divjp+ZU0RZOSsHqYiqoaS8ZgeFusc5Qwfeu1V1gc/78knoC2jqmS9aUGSmb6jXzAN3AkHEhhsKhwcZBl+BCPOuIxXsZvGuKG+iPH81jlgAW22sItALerLpGu5Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711648331; c=relaxed/simple;
	bh=+Ca5qoB6abbwq94BOat1CPhCCY8h1Y191rzETEJ7zgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5D7SOig5McHGrV0Rn63r2UZDjztKvMdjzYP8dIj6gPEWUYsOGYEsHtrrHI6aqsKOb5e6KjDGv6aMr6YyI/RajC8Pkrf3Z33QIzi6mC4/w390kHb5GYk4EsCmKA11lCtSRgcosO55ckeMBvVnHrPh8oeh6xCWwdsdXt+2kSyc5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1DNL4FE; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ea838bf357so1110732b3a.0;
        Thu, 28 Mar 2024 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711648329; x=1712253129; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGayx7O9Q31q05Nt0uhu4ViYlgHgf9Z3LztihitVGcQ=;
        b=k1DNL4FEcjk8LhAiHgkYh8R846+//bGW6Lq1sEpsmLhC8mYgx9EREVKGkOnlph5w+J
         psUEMCgf/tOTLcGVIX+dPgE+ObtrITFn3trS4LdqXssNzj43Q4fbQw75+cZzx2+1lzCC
         qDwAe0FObcruDDlVheiYUIYWLiVfriNRg4w5FVoppDA8JbxLVNOb80rgbL0DsYf7wA53
         djohQFKt1ibnRkg25okKLxE2wDFmn2SQ40j/gw/7qY3d/MhPAnvE30INjC4B9aNgpXSu
         gCZu41aUY2y2pT7ucM1cB+WeYASALQsceVFRIlk/NQIuEDrvqSzLUJwPoo97bYrNepPd
         EGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711648329; x=1712253129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGayx7O9Q31q05Nt0uhu4ViYlgHgf9Z3LztihitVGcQ=;
        b=TaoYfjJT1rhtZwtnbb3mu+yX+27874i8LPAaI96Kv3VAUAVt1/vDjpVW4e/uXbhF+m
         2WGRbYKeAL1AXAUq8b0QZvVGafEh3EDLsAwgPkmXlSQN0O9U85YkkuXPUVTItLB9sre6
         BIgOuG1afQ+20vYcFlJfRswU3vUr342gUEYzZJBdbuNhup2aiQW1tv2aZwRD8iTCLusd
         zlz/gJ/zRRrL78nEO3w6XvyA3NDQtVBsDyiT7ouRSUnJMZXNAP2GllutYt3051GNJmj8
         0iY04HCsUtjHxpdq7SeeJHPWshZ1G4r2AQJ62a9aM2dMvOgnd7uImRklCzai96d2VcuE
         nQdA==
X-Forwarded-Encrypted: i=1; AJvYcCUCnCr9XQh/f78g9J9rHZ/H1xxcrk82t2gI0JT+bo9ICp/lRWnDi5amHKH5xo5P8DA4qfrlMlRhGi7e+oyL5s/hv+AfRqQ5UzpfiZve
X-Gm-Message-State: AOJu0YyC8KDzSijPmI2smAu6nibDXKKT86lXXztlcy6yKinml8AGjWpe
	8NzI7OD7FcWBu9uEbESw20NDTbELid+HDCrExfZWQmB5ngvNRcZZ
X-Google-Smtp-Source: AGHT+IGnWA1lvzTheAjnKpDpk6BGTn4H+I8IAYW3WJYvGODV8ZPRe5o0F3hO52Y+4Y3dpl0ZSShvVA==
X-Received: by 2002:a05:6a21:191:b0:1a3:e2d1:7c5d with SMTP id le17-20020a056a21019100b001a3e2d17c5dmr4509520pzb.6.1711648328923;
        Thu, 28 Mar 2024 10:52:08 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:493e:82a3:49f9:d88])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00230600b006e580678dfbsm1637713pfh.193.2024.03.28.10.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 10:52:08 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:52:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Frieder Hannenheim <friederhannenheim@riseup.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input/touchscreen: synaptics_tcm_oncell: add driver
Message-ID: <ZgWuRucvmKBetBfX@google.com>
References: <20240327214643.7055-1-friederhannenheim@riseup.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327214643.7055-1-friederhannenheim@riseup.net>

Hi Frieder,

On Wed, Mar 27, 2024 at 10:39:12PM +0100, Frieder Hannenheim wrote:
> This is a bit of a stripped down and partially reworked driver for the
> synaptics_tcm_oncell touchscreen. I based my work off the driver in the
> LineageOS kernel found at
> https://github.com/LineageOS/android_kernel_oneplus_sm8250 branch
> lineage-20. The code was originally written by OnePlus developers but
> I'm not sure how to credit them correctly.

So the first question is: does this device not use Synaptics RMI4
protocol?

I am CCing Marge Yang of Synaptics who may shed some light on the kind
of touch controller this is.

Thanks.

-- 
Dmitry

