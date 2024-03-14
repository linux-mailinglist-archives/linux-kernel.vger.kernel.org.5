Return-Path: <linux-kernel+bounces-103812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ACA87C4D9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D16DF1C21301
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B2B768EE;
	Thu, 14 Mar 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKCGxtdc"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979C576412;
	Thu, 14 Mar 2024 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710452846; cv=none; b=qgw3jMip+YXrueYms1YsPmSps6yizvzdmwGiqlLwOAkGdOCNSbnlofAl2mAvjdA2j1TAsi9mDFqqmBEtyJQIkpliENcSmD0mslOne4iJyOF8tUzrorpoEmfRJ77hGiqjZ8myFdEfcTFIntcnCTgDlHNxDynpAxkQxaqwlYjCi+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710452846; c=relaxed/simple;
	bh=BHM3ilCcEMf3RVGPfy62NJbGpgMj4Pcu6SfDkxglR4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaWyeegTLozBLTIpGRFMCFMcRhzQIcbGlzvwI4+2wDiwMJxIxU6nhen75URDx8N/trmBouSccGKAIPWMy5uQgvV2tlicaEsV8paUxbLmPVV10WC5owdaejH69xiRPFuyENEL69ZjMZzFy7+9zr/yxJD6AOYwPmrrTKx43erDFmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKCGxtdc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-413f76fcf41so7371315e9.3;
        Thu, 14 Mar 2024 14:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710452843; x=1711057643; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Laxe1h99cHydEOQ68WurdnvO/J/l86hrfaGpwpfsGxo=;
        b=NKCGxtdcrAmEnJUg8T7qDKRPq2rz3krSFi+hcbbYJyjyAT1qZp1gRWYeexK7fm81UN
         0wsZlXaDw29NyEOAI3bK+YEuUZjwoCiIC2hfKZqHeebQFpu2rBixQCPjAFzWQUk+nLIS
         nQr5xrQ+MmmPeyRS0SrrFPVTA6iXKlZjMX8HUqGJ4wmKr/ZXTah/V8PygqesdUtVCDva
         DipB2rNdhh7YfLcwOfQu9PSDo6kzHcqEt9854tmkiRtRrzebRV5BbLUmwlbGm8iZr3sO
         bW84fPcrhU6qRH0FbbQBJ0tJa+HntZeMe7+48/RwaUHpABq7LDd9YSaDHhJhbHfwMxQW
         0T2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710452843; x=1711057643;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Laxe1h99cHydEOQ68WurdnvO/J/l86hrfaGpwpfsGxo=;
        b=cUvrjiMU9GJrLi0V+NpEDFdl6MLHqGTwLUM0IK5aRGbd4Hl994V0K3QRCZLo1qGcbd
         /bSeLfI4DQGJQuUzIZxdRNZwNvoyRWMEv2lL84Db22/t00GEBGAgybetE+i1nQmmCbKY
         HSDsRdFfPmdhXXlmQ1038ilRtbf2O1/+10lmaIW3N9S3Q+j8/bKRlbZEs7MZHQ2Pung4
         2oGaIpBTiMfGTP/ISqdCHFVc9BXsTtq4xyiMcDclz0g8/ySieev1F0u1hR1ZPhBmNUNN
         6bA3vKqvJTmcPEhRxbXwY45BnfahcqXalpmt4NtiYSWTetw+uQOhXczuw51xp2sZEEpH
         KnGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNFDwC/sxaW1tteq3cbZ1z5w+zHcVJGctRzbE06dBa3H9PZ3IRxz7V5HTbVsIc7T5Il+AhfL7tNnWMH583k80JrPLBpE16
X-Gm-Message-State: AOJu0Yzh6djiCOi0EvsqeQhBHCUsmKcAzZMgUNj1u+NgMgKEgZ5TwBbq
	H7Opj31RCbWXG6U5y+FoI7A5+wh+zpvaAMBCF95htMQYDaCfKypN6ekYrkO7pQM=
X-Google-Smtp-Source: AGHT+IFLSKdZW9IL/j2mwTTm0WkUtmEItk+lPnbQoNQohr+S/NbJ5LArx1U2xX5obPtCgatc4eFLeg==
X-Received: by 2002:a05:600c:468d:b0:413:1d88:f85c with SMTP id p13-20020a05600c468d00b004131d88f85cmr2474165wmo.33.1710452842738;
        Thu, 14 Mar 2024 14:47:22 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id bd7-20020a05600c1f0700b00413f3ca39easm2710762wmb.5.2024.03.14.14.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 14:47:20 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 06D47BE2EE8; Thu, 14 Mar 2024 22:47:20 +0100 (CET)
Date: Thu, 14 Mar 2024 22:47:19 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
Message-ID: <ZfNwZ2dqQfw3Fsxe@eldamar.lan>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>

Hi Sasha,

On Wed, Mar 13, 2024 at 12:45:27PM -0400, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.10.213 release.
> There are 73 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Mar 15 04:46:39 PM UTC 2024.
> Anything received after that time might be too late.

This one still has the problem with the documentation build and does
not yet include:

https://lore.kernel.org/regressions/ZeZAHnzlmZoAhkqW@eldamar.lan/

Can you pick it up as well?

Regards,
Salvatore

