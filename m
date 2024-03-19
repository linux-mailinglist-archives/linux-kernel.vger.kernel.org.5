Return-Path: <linux-kernel+bounces-107385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B5687FBC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55243B224E0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6117E571;
	Tue, 19 Mar 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="TmPDWK5u"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373FF7E10E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710843999; cv=none; b=Y2SQDA1dOU7sNxCrCOvYOS41P0NeS8s7jyPqvdsPsXXkTvsYStO68lBA9GRTELbkQMvmIpRdzxt0WP5ZWyzivNbqJgmIZG1NFH+g+LqCi5nzxlebVqg30ll7rclidmKfqYbTb/fVkeFMDbpNyaJBPN5GffrvsPT9ONRcqPSQU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710843999; c=relaxed/simple;
	bh=KnD+vRO//djJswqeZEr1YaSQjYy0/EtwXfN/5kheUCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSxaK5sbBnfXBmD2Arx68MKU0BAgIripHUcJ3g4FrDdY05Ar7NqAT5aESgzQHLFHfKNHfaoJb3LOTPVNghCh6WtaWikWZVrsecBgerBEBEeIlhLtcpKx+KtLrzzE0y7QYM0oVL3592+f92lQdHZM0cRcJCM/Daecllw2iuEoY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=TmPDWK5u; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41464711dc8so4074175e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1710843996; x=1711448796; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K/kY3ymT6Kq+NxxS6XmsIb0q0NFxAdsmufViWTvlYek=;
        b=TmPDWK5u7bwVWGpEtr4Rmq9FZZEiaCgG9QeBvSQ/zpP/aiQ6TXkFm4ktETWtKPZ+VI
         pqv5RUtOnUt69C+6UKT6a81W10CeT+aIKqVW+9ei6O6OkpeXrSqAMX5WutYOECezPZvl
         mJomE++giVcY+iamV8pePUz9nsWAWODBUAoquqXj7QysiUvtHoaTdZifI/LbkPHjwrd9
         Ps+7+JmiKjyTDjQ8nwdaiIEVbY+EBBKMSmw2/F1h7Fv0+sOwyAF2BfD7PQNhQ/MFcMJQ
         vni0aZKzK3JjCx2ncNRRn03052Q8YodzXxoN+OBMqD68nL5zRo3RLat0gZOIv4BrpQfR
         cylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710843996; x=1711448796;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/kY3ymT6Kq+NxxS6XmsIb0q0NFxAdsmufViWTvlYek=;
        b=wv7XgB/qvEk7NMS0+Xgz4pLKVu1BGKrKAebd6R72Lg3ZRmEwa3b+9A1PxOElv5GPCO
         J/gVyuvxccJFy89J9TFHv0EStRtYCrPAWwbKSSQv97ukz2+dJEMB5tmsvhEXELbjqlWW
         M/s2SEsJX5dEHSLMo+Q9fY4vfjPH4bw4Ym+PrfDuhLVsm5r0tkjSwFrCdYGcwcb8vJks
         0RB3aZf0B7FS6qrkdyzJxKTl96nU53Koxci3Xqeq7UNsjexBzdt6kI7+StEKtbmgPg+w
         /dAp4F5mksldXCXmH9Ud1YLZVZY2eXfAsTGkCbEixeNX/47h1SbeYIDk2x0twG97DS4B
         Bs4A==
X-Forwarded-Encrypted: i=1; AJvYcCVdQXTMzKjMl2YUBoPUi+Z3HP1lJsZehWTouQ+hJHtFCwPIk634GW6Hut/6dhrd043ZYD8zntm6+jmo5NCjxGP1xJHwx+/+4PH6bhG9
X-Gm-Message-State: AOJu0YxawUpYqAm5McTr/Hl4+frxnbxOF7Og93snjcl+X2wSJKATt7QW
	gLWNTrvA2P/xAtEYkKKgUZddj1JIx3m6ntKHdEwccQm0/epe3bLQPK4UvwURcb4=
X-Google-Smtp-Source: AGHT+IHIjYnO7QiQBrJZrPf4r2Een7JWME1nf9x6uC1++VadonVxo6i1A8GJYvEMNu8cP8iehDdUUg==
X-Received: by 2002:a05:600c:46c9:b0:414:64c8:5523 with SMTP id q9-20020a05600c46c900b0041464c85523mr1057390wmo.3.1710843996416;
        Tue, 19 Mar 2024 03:26:36 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k3-20020adff5c3000000b0033e7eba040dsm12133681wrp.97.2024.03.19.03.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 03:26:35 -0700 (PDT)
Date: Tue, 19 Mar 2024 11:26:32 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v7 0/5] ptp: clockmatrix: support 32-bit address
 space
Message-ID: <ZfloWPxw_iFJvLDs@nanopsycho>
References: <LV3P220MB1202C9E9B0C5CE022F78CA5DA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV3P220MB1202C9E9B0C5CE022F78CA5DA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>

Mon, Mar 18, 2024 at 06:32:08PM CET, lnimi@hotmail.com wrote:
>From: Min Li <min.li.xe@renesas.com>
>
>The main porpose of this series is [PATCH 1/5], which is to support read/write
>to the whole 32-bit address space. Other changes are increamental since
>[PATCH 1/5].

net-next is closed, send again next week.

> 
>
>Min Li (5):
>  ptp: clockmatrix: support 32-bit address space
>  ptp: clockmatrix: set write phase timer to 0 when not in PCW mode
>  ptp: clockmatrix: dco input-to-output delay is 20 FOD cycles + 8ns
>  ptp: clockmatrix: Fix caps.max_adj to reflect
>    DPLL_MAX_FREQ_OFFSET[MAX_FFO]
>  ptp: clockmatrix: move register and firmware related definition to
>    idt8a340_reg.h
>
> drivers/ptp/ptp_clockmatrix.c    | 120 ++++--
> drivers/ptp/ptp_clockmatrix.h    |  66 +--
> include/linux/mfd/idt8a340_reg.h | 664 ++++++++++++++++++-------------
> 3 files changed, 482 insertions(+), 368 deletions(-)
>
>-- 
>2.39.2
>
>

