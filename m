Return-Path: <linux-kernel+bounces-155177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993F48AE64F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E062851D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03417135A6D;
	Tue, 23 Apr 2024 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrBJgZCf"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78CA12E1F1
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 12:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875795; cv=none; b=jziA4AtZHeKwylQFTNQYiOoBjFdK+a5vgN8IFH8rxRpr4R6Jp6GIEpvIWdGnK3dpsfpB91qGPLRQjGzSSRi/sj34HRpP1y1jOuWFFytlXqxTuZOwyCVnbThXdUKYyf4oY12P0KzD/mZ481OuOQOh5QDbGo+CdGv+8vsQPcKfOD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875795; c=relaxed/simple;
	bh=E/vCm6ZUaj+g8UsCNPxeL7wXwxO1N9+3euYMitEq/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3jcf9jm4KhaynSxXR4FYbBIXYTOQBGsxzl7ewZiiWd/P1LWIViUtoIEqExpQbj9s1r5Y93gvvWzyWUFwrzF4CpL8nhlB0zptPBQVvl4Yf4Kort6NnHM1xqJz1QAizbAv01Ku9f/gO40FIQT08k88eXWb7haZQ6ZaUtA9WqO6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrBJgZCf; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so6842333e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713875792; x=1714480592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcR6wiJNuQG5uBPTgnJ94TkYBXMQrI+Q5aD+z7eMSQc=;
        b=rrBJgZCfdutT2wNhzCScP2VBQyB2MB3y4pi1ErsvPfJyWsQJD8jTyG2EXB2jjVK9S8
         VY83830xyCMHqQuueKCw8wK5rn5L7W2nyhqIiiM4Hj4C4jM713wBy9Nwv7SHilM2joEx
         n04oZVAe8cxgN4qjHbcdUyviDeobqM9lmMBePMg2Pd0UZ9PW5ReRsBY/fAufRw+YwuXQ
         AQ8fj7rze7PCQIiSOxpvnZpNi25cpdp7o1+47/VNCXOd2paTICDTADVGn/Ub+N3X18T0
         /k/uUb9AE70HliTIdK3JehfDrIFqVRVTm6it6KH/sfOjAJ1sLIiE/OiM9Z8qRZt1brzV
         qtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713875792; x=1714480592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EcR6wiJNuQG5uBPTgnJ94TkYBXMQrI+Q5aD+z7eMSQc=;
        b=MoPYIpL6qz1tAdfBT9NEHZKRzTp8Qr+Sz7obnAbVeqagxFzQdvWAds9XWJEQGXDSNo
         n5McnLq8b2v32vf1nUQvA3dyQtEJjaXm1wGAJXiYKEQKCkEokK4Osidx1z3LDwqOgwWr
         cs+M5dX8iiBG7oz4zpmjdqYHV8q1GX2D7EFkHS0aaqPUaF7iNI1khWK9Kxh/6sK778Eg
         3PQ+eVJX0GQiDKnmQrNMgBLo9P1G+oZsF2arBUlwkYa/oRAkZqvBhjinFRROlw/nFDxo
         tjq/i9rJ0IO9jEHIFTLJzuNrL3OIIeyKzc6zRTVcovjf5O+AvkqCGVk7RdKoHnp2AODs
         Nhvg==
X-Forwarded-Encrypted: i=1; AJvYcCU5CfUaYejKt4ni69Fe0IKs9hBnI5LIJjwAqXQFcGH6MWiOLhfqeemexKZQeY5G+sWOqFqf25M9JI8MX049dEbHw36OdVXogFNDJJXC
X-Gm-Message-State: AOJu0Yydrs1Ihl41i3qipaRjVJbscF/Xu9YmVUOPCVUt7N7Cexq9qYi9
	YfwXATkCce5HOeCXv4GUvK6sRK67azarTk931j7N8aTlaIPXFX55jgx7VPcl5/Y=
X-Google-Smtp-Source: AGHT+IEJpRdPl93hf4hfOkqeiRE3xT9UUu8AhP8A1Hd+r8Zl367qDbSba7OkW4KPmf+cOR9c5qPLng==
X-Received: by 2002:ac2:5594:0:b0:519:27e5:83b7 with SMTP id v20-20020ac25594000000b0051927e583b7mr8063957lfg.27.1713875791850;
        Tue, 23 Apr 2024 05:36:31 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id d25-20020a196b19000000b0051af5cba0f3sm959407lfa.11.2024.04.23.05.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 05:36:31 -0700 (PDT)
Date: Tue, 23 Apr 2024 15:36:30 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/msm/dsi: Remove dsi_phy_write_[un]delay()
Message-ID: <r2mx33pvuivenwxawsihrblzmuqucxcog3m7i4dy5o4y2qycsh@76frmib5x7x2>
References: <20240423-topic-msm_cleanup-v1-0-b30f39f43b90@linaro.org>
 <20240423-topic-msm_cleanup-v1-2-b30f39f43b90@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423-topic-msm_cleanup-v1-2-b30f39f43b90@linaro.org>

On Tue, Apr 23, 2024 at 12:37:00AM +0200, Konrad Dybcio wrote:
> These are dummy wrappers that do literally nothing interesting.
> Remove them.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h      |  3 --
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c |  3 +-
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 81 +++++++++++++++++++-----------
>  3 files changed, 54 insertions(+), 33 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

