Return-Path: <linux-kernel+bounces-147495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 354808A7536
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E45F328475B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF32139D11;
	Tue, 16 Apr 2024 20:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R5G8RGE9"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC31386D6
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297995; cv=none; b=r2CgBfnsIzv4G0UZG+ERG/BDjRE273Bp/7+o2ReLkLPGReZ6eMu+MffJVjl2ZPwB1pQmsYMoCNgX1O//3DxWfpIldh2LpOP+21svLQxRBS8G56EMw1qDDQPPtNDozM/mLb3OroI28I46jG1R15ii9HkUIK6Fwp6FjinnDkhNhCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297995; c=relaxed/simple;
	bh=WCfdox0lZ4JU2XxlbwtEtZyOeRf8pkyLJiEQQjBVp4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVTLle/8QNG5uCCDwqPww5WvSUpJr4W4irpKqqjSPmOc0/Q9/CYFuH4EWzsgQnMWwiULIg+6l6QRbKfiZKL3rvUsvxlQ2AqTWqRK1epIWH1N6S8ABTT7UdWEZY5IIJ5NCOnn5frXfkw6/d/uhSJGqXCwxGLPSOXR0RKbSSsH4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R5G8RGE9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516d0162fa1so6176000e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 13:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713297991; x=1713902791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5WM/kJl6/lgxNKvGcl2foDF49S8YDknOQYG0ZwPqeq4=;
        b=R5G8RGE9Zwq+sTWKsv6YwvB24hLh7UgTloZgPLnG2QkKzTrVbmWkNuWLzdMm7U1ZBu
         QMzbNVUkuKlyph0KM4c064Y1nPaxcMHzF7gwx44gyYjeaiUP0tDImL4M877MPtXZdP9a
         +DZtwaUD+rvL4dZgB+Vgz/1mt/8EqpZn9RhJ3qiLKNq+Jk76vZenLyjcQGl3I9ZwE5SD
         EHcGnSbbQ7Js1UvcsBSQxj40fF/C6pmtmI3n7luPp9KPJi6Blih6BwyD9IY89m/BJasY
         FHycbwYXYw9HReUCOIbRzDXEkS8/Vj7Wit6g4VW/m9RaIFxSAt2bsBy3yvsu1kkwMVwA
         LBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713297991; x=1713902791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WM/kJl6/lgxNKvGcl2foDF49S8YDknOQYG0ZwPqeq4=;
        b=Ftz0A4tMV7lSxmMBkza/cP+fTZO0PiR90qsDDbziCbqSgKJN2FcIjQD8nQ+Z/uTHmw
         LEs+9eTJWXC4xfa75ldbcxXXjBx2k71U8jHIk9iQ1f0sklwvy7q2PH6U3zfeUxzNoFXW
         yQ4Ffr0LHWFESVxpifZ84QbtA1UgTsLWBqEbjxZT+4WSRNBAGBlDR6BxqUV0RRWVpOVo
         OniUQsgR+J2t4uXJ2bSSEoK0cKJc8IDhUwJMNHuWVYzgCKolR//DudO+kZTaEs1ensx+
         cwzq+XEHt+QgLVUcjo9g2pX2d2R6nRNZjkhqjvlNcnOcMXdGKmcfTRGoaAdz4zdoquw1
         AzCA==
X-Forwarded-Encrypted: i=1; AJvYcCWCWV1PrM6GOHbsSExmBoWsF/nGeBINn0MmddavErmOwMCl/tnvaEjYBtyDqFvcev16T/eDfkPNU+MK76L8HjcElasxx6iUC/GrSmzk
X-Gm-Message-State: AOJu0Yw5rQVJoTfn3074OOdKWyIWyK5yFEERE/uDt7fQlJ7r27m/16kK
	AujMFm/qDf2hfaN8PQiDCy11GA7JhPbBhwcSECOoboF6vTZJH1wGheMZUdhr4nM=
X-Google-Smtp-Source: AGHT+IFmHOkNwWKSnm1HBfTZnquMULqoBRj7rBVPJKHrN8vOG01l/YisFvkz/QvNtFNORfqb4oKlMA==
X-Received: by 2002:ac2:4ac8:0:b0:516:d1af:adc1 with SMTP id m8-20020ac24ac8000000b00516d1afadc1mr10003114lfp.9.1713297991264;
        Tue, 16 Apr 2024 13:06:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id p27-20020ac246db000000b00518948d6910sm1254318lfo.205.2024.04.16.13.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 13:06:20 -0700 (PDT)
Date: Tue, 16 Apr 2024 23:06:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: David Wronek <david@mainlining.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marijn Suijten <marijn.suijten@somainline.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/panel: Add driver for EDO RM69380 OLED panel
Message-ID: <ni6kkq6brpnlve2nkcbsi3j5zmcfwurh2wj2nlypwpp2vqxrpd@ktgncxudgeu6>
References: <20240416-raydium-rm69380-driver-v3-0-21600ac4ce5f@mainlining.org>
 <20240416-raydium-rm69380-driver-v3-2-21600ac4ce5f@mainlining.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416-raydium-rm69380-driver-v3-2-21600ac4ce5f@mainlining.org>

On Tue, Apr 16, 2024 at 08:30:49PM +0200, David Wronek wrote:
> Add support for the 2560x1600@90Hz OLED panel by EDO bundled with a
> Raydium RM69380 controller, as found on the Lenovo Xiaoxin Pad Pro 2021.
> 
> Signed-off-by: David Wronek <david@mainlining.org>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |  14 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-raydium-rm69380.c | 367 ++++++++++++++++++++++++++
>  3 files changed, 382 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

