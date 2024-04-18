Return-Path: <linux-kernel+bounces-149337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C14798A8FC8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 02:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E94B21B70
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32D8384;
	Thu, 18 Apr 2024 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t4+BbwsN"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B0181
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 00:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398681; cv=none; b=YKF6LJDoAl1xi0II9l/DbakQ6jIvxQr9H52QxIigyXkcY4NPbDD213t9jcokZLbuSuAQ4s9GrjLOG6/T5tAeP1i9lpKSgj37GQRzRwQbIcJy2I7qDyxX/lLsuUT+4IeZpXP0qee+xc8WdszYbA/jojqqdskTwEhioPV7cqp2s0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398681; c=relaxed/simple;
	bh=gx7jg1lBzi2TiU19uWZpxAi9bqthD1AM04xQcCDjrd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzSuUiM5enTPcCjIwZ5gPp8KuGKJuj6mllzvzKeFksiYKikSScXutx+hkFMbOEkXvPEI2BnVQAWLeOU9nnCh7GxJw9VvbhPFkYZ3JNod77eshghs5Ztd6SLcS45o+5+47v7kBaSk0FpK+EVeBjkbrZBUSQ6JDNcbUD1cfXnvB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t4+BbwsN; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2db101c11beso3400031fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713398677; x=1714003477; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyMD0vdpJTGU58R4FA68GHuoRK/sk6v35n6AZg7jKqA=;
        b=t4+BbwsNCHxPBoIaMLBueYdf3tXLHriMqxhtjoxBZCUO/y9Rw5lLoJ9Vd6W1EjK0/H
         mYUZ5h6vPV6ewvOXQuT1amxi1+eKJiEy4tzextpOe1MHVr81EaBaXSfGyZ3bAH2Hbc78
         sG1SAOHi3A3Wjpwrbnqg7r+/oS7tIoAZSbv3jUHIk9rt4fiYpuRDjzFWA5x5nlMtlw2U
         KNMYICoEJl5uCYqgbalGjs33Lwc65TvxEhElJwkOhxyHT9jmlq3oON9T9HmuQ2Gft3dv
         p80sJ5xd04ODDLgamsG1bKHKY0LjbTT4k5YvNCxWPSF8jMt2G/roJm46FedIUqx7Dk/O
         F/CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713398677; x=1714003477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyMD0vdpJTGU58R4FA68GHuoRK/sk6v35n6AZg7jKqA=;
        b=BQhnqWGougVQ43J2aP0k60GDH0XKP7Lw+Ci3wkZloffbsyhq/j6B9rLbVuWa4XpxbK
         y1SAUPtkL75oSXhcl63jt8sOupTXWG+Nn05q4FCwW72R3wtAZNKM2v5tVoYtlx9DpDLq
         GVHdqNEiklUa1Gzb9dWxi6XEpBRU00Ui9hLQWm9BkcZxbIxdwrrpj0XrfBMNX7TXxldW
         dW+mI0b+GLZVwFI4m/jmb4ovkpyi3m06MMYnoVWZYWsZrK3QOb519AU5Ps2mudn/FFt4
         Wni3Kz7siG22ATFqRoClkQPjSs6VwzET6/AIT88U3jQfP/OYB3J/i5tIYQoweG9QP/r9
         YBSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVij6dbEcuksFoTZFPniOcP6m+CGsnSgURZhHjfXZePBAVKkrjHh7NrLQvnpOuLe8Nm1LbQtJGFqJ7xaKU/klVHdaw+EviLJEOG+XA3
X-Gm-Message-State: AOJu0YzFZx27qKAXNoy8fJ6RDIjZ+XIivAsz5HfeExk/6OYV5l9viekR
	TnBp0EPGfvQ0jUTDSFj8cArevM+eRebxyz00L51qEWBKawLzirf2FyKZypIJJgk=
X-Google-Smtp-Source: AGHT+IEfQFM/00DQfWr4fRjU1vKMYz/rsbblnwdJZZ5z2LLaFZG8n06y4eExwX1km4x2k8m3TwgtOg==
X-Received: by 2002:a05:6512:32b7:b0:518:d685:9935 with SMTP id q23-20020a05651232b700b00518d6859935mr439018lfe.8.1713398677609;
        Wed, 17 Apr 2024 17:04:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id b6-20020a056512218600b00516c580b640sm42807lft.13.2024.04.17.17.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 17:04:37 -0700 (PDT)
Date: Thu, 18 Apr 2024 03:04:35 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Matthias Kaehlcke <mka@chromium.org>, Harigovindan P <harigovi@codeaurora.org>, 
	Ritesh Kumar <quic_riteshk@quicinc.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] drm/panel: novatek-nt36672e: stop calling
 regulator_set_load manually
Message-ID: <v5zrd5u2g6lyn2cax3uatk3ukdj5mcii4b5ng4ec5oorw3wkfg@zlfdnbmw6kkp>
References: <20240404-drop-panel-unregister-v1-0-9f56953c5fb9@linaro.org>
 <20240404-drop-panel-unregister-v1-4-9f56953c5fb9@linaro.org>
 <e89c5c19-7c8f-476b-a96a-a5bc330278ab@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e89c5c19-7c8f-476b-a96a-a5bc330278ab@quicinc.com>

On Wed, Apr 17, 2024 at 02:20:31PM -0700, Jessica Zhang wrote:
> 
> 
> On 4/4/2024 3:08 AM, Dmitry Baryshkov wrote:
> > Use .init_load_uA part of the bulk regulator API instead of calling
> > register_set_load() manually.
> 
> Hi Dmitry,
> 
> Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

I wonder why patch 4 was reviewed, but patch 3 was not.

-- 
With best wishes
Dmitry

