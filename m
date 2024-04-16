Return-Path: <linux-kernel+bounces-146085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A54EE8A601A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43FE61F23720
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91714C7E;
	Tue, 16 Apr 2024 01:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FWBGM97u"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A36FC7
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713230341; cv=none; b=nceZUYkMOyposGbVwI+bSWHOXnnMeBM2gtmwqEz819vvAhGZ0Jo5ceIRjETOz1uWH32U/ELunc+mrX2D7tsn4Fa8pX7QmqJmYWc+IMwDMu4dLVQEfE3Lx6rJHs6sjOvfOG8ShhC+yREMxQxtiZmmLEKmjAxE6e10NzNlR8GmoyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713230341; c=relaxed/simple;
	bh=T3Ub9CTBocqqsMgjGmcTGBv0ckjs+CI/cEJww9YWUk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qOvf0kOk40sEJ7Eyd+4KyDddlCwmviGgJqQubWBEqQXxpXBt782UZGbOmu+D+GfDMV2zgGk7NXT49o9TtsebzUPGkDH0TZw9LHLyKc1mVd32xCX7Sinhn64VzWS3soWb+HGEbDvvREa8Ri9qDMIHF1XuXVJ0Oi6hESyFRAE1658=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FWBGM97u; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d3776334so4998160e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713230337; x=1713835137; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V84Q9cVFBfzhJCyj19uweJAoXqH3wOGjSA4sDGt5T94=;
        b=FWBGM97u8K/h9PBKXQeVEKajpvPtSzvxqepGd2U9X2tVKA2HO6nOt1eTk03SvJdH//
         IYhctcNf5nm9cX0q+03eqPxZ9NJ30zqccxF7qPrQK1FGZUnl9dC1JkEE6HeDIcAeO7oO
         oqh3hAPU/+P6reNS9zB9m+XrqkMQH2zSCqkoi6/YTEsiZsHu9ilUD1XX+cyBttSBLuHT
         cGdZxxZ2NhNAcEE9j0xetQwtthyaNrDvgnjKcJ75VSUUD5QKgHtbsKStGwBXUpqs/B+p
         o0Xu8nPqL8Qig+wJn/qsVUMtyX7k36VD+F3nuwdMP1Ea7SS2k5lIhGFp0Ha2jYxVz2kg
         FGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713230337; x=1713835137;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V84Q9cVFBfzhJCyj19uweJAoXqH3wOGjSA4sDGt5T94=;
        b=lisuwV95Ht9ehMGROIg+lcKlp4qZB1GVR152UdVoeul8/tnlqORf+8q4lWrOfhXsGn
         xZ5hzGhQpFGCDhbeBXmzm3Ltx+yukE5VrDirDwZVueMCm5yjkVPUARQza3nzHWNVEnE/
         krwhZLUP0shUC3Qh7k+bVlpYhkJSFp00lomeOwy14ZW3AxXb9wTT4CUcBJdQEpz3dEau
         RshiM/Va04DVreNODUrIoGjkX6oqTao0D6JJR2VNPtqH713Tcaq3v6/t6lVv3YKndYmK
         d6d2BGsaXPNJqtpCIV3BEWaELiJ3jsOInIwCx6koPIAbGOl9FDvaq5GcMd6ztOie5L5X
         JTNQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8irl9u/fkilyrYBlq6sXlV949mUC2C0IEFR4du9bZ+XZCou/Pj8/Do+xZyuKOu/G3/rnX41V3ji+/dDkRY2GHi2kUnU6KqpG47Qi5
X-Gm-Message-State: AOJu0Yz8xopFZGVhY6DSceaXQbmOaaVHeY3a2QW+0li5NprCzLqcAztA
	th9FMtJodk4AxthSTnnGLto2qZ3gBSyeUaxdMSRj3i3fa6wNvQ9Y7rdS+hvi6bM=
X-Google-Smtp-Source: AGHT+IFWNBzccYch4p6khvIyf+Lk3SK7UVjljV/Hda5ozoFbl/KDRuaiAB21VcZyyqo2uS0i85rJow==
X-Received: by 2002:a05:6512:3d02:b0:516:d444:b26b with SMTP id d2-20020a0565123d0200b00516d444b26bmr10792490lfv.46.1713230337521;
        Mon, 15 Apr 2024 18:18:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25b89000000b00516b069b27esm1425539lfn.37.2024.04.15.18.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 18:18:57 -0700 (PDT)
Date: Tue, 16 Apr 2024 04:18:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, owen <qwt9588@gmail.com>, 
	Jagan Teki <jagan@amarulasolutions.com>, Marek Vasut <marex@denx.de>, 
	Adrien Grassein <adrien.grassein@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Bjorn Andersson <andersson@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Vinay Simha BN <simhavcs@gmail.com>, 
	Christopher Vollo <chris@renewoutreach.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: Re: [PATCH v3 5/9] drm/bridge: lt9611uxc: Don't log an error when
 DSI host can't be found
Message-ID: <wg7t7pnrpuz2dy3kj7eh5fmzxg2zwdnahm3yxlc6w35k6r3upy@txfrjhykfrko>
References: <20240415-anx7625-defer-log-no-dsi-host-v3-0-619a28148e5c@collabora.com>
 <20240415-anx7625-defer-log-no-dsi-host-v3-5-619a28148e5c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415-anx7625-defer-log-no-dsi-host-v3-5-619a28148e5c@collabora.com>

On Mon, Apr 15, 2024 at 05:49:33PM -0400, Nícolas F. R. A. Prado wrote:
> Given that failing to find a DSI host causes the driver to defer probe,
> make use of dev_err_probe() to log the reason. This makes the defer
> probe reason available and avoids alerting userspace about something
> that is not necessarily an error.
> 
> Fixes: 0cbbd5b1a012 ("drm: bridge: add support for lontium LT9611UXC bridge")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611uxc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

