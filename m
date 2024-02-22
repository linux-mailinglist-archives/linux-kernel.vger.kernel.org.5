Return-Path: <linux-kernel+bounces-77355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8420860445
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB5C28A3A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED97E6AF9F;
	Thu, 22 Feb 2024 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tyupwmMg"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB286AFB7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635622; cv=none; b=pfhlgvWqy3RSVUh1ZLB3wp3h2uJYFbuf7C7y2uL4dlNHgQmzDIBQOebZDShej7L6Fw/0A0A9HB6wt7AmvMeW5/f83C58HGejgLhsw7f/VmW1xU0MBj5ny4O23CiIUMN2h2UUS5eIq8tj24B1hZB95BgqVOn4YvVztKe1J6lWOlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635622; c=relaxed/simple;
	bh=HFx919FoBoatQ0QsWPsYN4OR0O/n414ORi4Ge3ph5Q4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nM8tauyczieWg/9SPwvcBUEbJS226jcioGMHa1N4/wxQ6yHhcTtyIaADXsFLjYWT1U372fO8gmI4IzPh5HWoHJTaDHyVEwDudKyi7krkYyfnlNMmf6DZIhj7bGMAs//FiazLiHPoL5hNalkRRhyoxX8FsKbG+WHuJ7RCn/yhOLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tyupwmMg; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dbed0710c74so140673276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708635619; x=1709240419; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dmvjj7fhOobzTivUlelD//oyOg39L8TaqEJkHM6CbjU=;
        b=tyupwmMgbdwGS1cp/Ek63vQhmqjDH9Ux5eZfR1JfKBmiID2zkGljsHX9TgPpJVqR3u
         E9ZsJ2eneLV5Lm+LJN06G3j2N/ZieEGXF6rs+hi9RrKewv6sORYoKhvYifFIfxEgacoI
         /p3b3ZJtJvRW2I68jvEDOJAc60zc6IcoqyX8tpgef3TFwlxvXMxHU7xkOZdPnEkyrHIo
         HIUCJbRBsJp8JFLGT8ANy8VUpK3Y5cHQCRE7L3jxlRbbm9u39Pb7bkbJf4b5iYzdeIJ8
         Hkvwty/42rwICyhj0mVZs4KLm1PM9h0ET1Ed4/fX3LuamhOBAjY5Q+NZXEJtOeDa8NgE
         o67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635619; x=1709240419;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dmvjj7fhOobzTivUlelD//oyOg39L8TaqEJkHM6CbjU=;
        b=nf3eNG0pN7GYYqcr91d6zGvo009MvPEla7P4R2SRb4J1aqE9lixi1wXwyVLBioEglT
         Wf9Lw81WHT+dAu8oN9wWJOuMxZT9Ea3iJupuloizFABFMM61Kl568a2BuAEDa8PtHyKP
         ISAYET7c60pP+dO6tYoLUjcvJ75y0+rpilJoc80ysNNnOId7yBkqzWG4qE10AB2uygvQ
         WUCdjUczag0pDYEgU4YYgdBO0/bXEcrQv8aAzpOeJEseTtbrE8ojrKMnS7I2V6xQMueQ
         SzQusNgudK/B2/1dPb3n2QAvnM11UEREjb2u2RAp9/idJQidMa3Kv8uSnUhrhn+A6Vr9
         BIgA==
X-Forwarded-Encrypted: i=1; AJvYcCWIHkq2WvLKE/2o1BNb/gcgk6ritdV/z2uH72avjVbY186Q46MeSOxAJjlUNmPek4jmuxUPv4951X9++CW1DiCmyS+lYQx2MBsB4U8M
X-Gm-Message-State: AOJu0YykX7XgzuJQdnlT6T0ZMzuxcFQCTcPX7QRmBu+rYnuokwvLYRYy
	DVLKAm/bAGoHR2DeUEHDV1iSC7wohLenfBqfi8qcqT0cTRdckJPZEL68p8VjER8Wr2ipAlo/ipl
	rs7Jwd6w0oyEXEMgRn/GrRZ98Ts88Tv4FKhEVmA==
X-Google-Smtp-Source: AGHT+IFdnFEXZ/1Ob2Rd+e7Qs1/dnY3m9z+vfb8chmIF2GjOTnC5mGKNn2WgjovOSKHSnuhiBw7HcB/7y1Jd6eekJXs=
X-Received: by 2002:a5b:d05:0:b0:dcc:8aaa:3ed3 with SMTP id
 y5-20020a5b0d05000000b00dcc8aaa3ed3mr303376ybp.16.1708635619664; Thu, 22 Feb
 2024 13:00:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-1-johan+linaro@kernel.org> <20240217150228.5788-2-johan+linaro@kernel.org>
In-Reply-To: <20240217150228.5788-2-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 23:00:08 +0200
Message-ID: <CAA8EJprBs8ASwZMAHFMQUEg7NN67rzRtUX--8h72-7F9R_=o6Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/bridge: aux-hpd: fix OF node leaks
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Vinod Koul <vkoul@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 17 Feb 2024 at 17:03, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> The two device node references taken during allocation need to be
> dropped when the auxiliary device is freed.
>
> Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/bridge/aux-hpd-bridge.c | 3 +++
>  1 file changed, 3 insertions(+)


-- 
With best wishes
Dmitry

