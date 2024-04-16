Return-Path: <linux-kernel+bounces-146084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997788A6018
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 03:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56B31289E9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1864C98;
	Tue, 16 Apr 2024 01:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BskwGHFi"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2205223
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713230303; cv=none; b=b9TV8MCa0xeYBtz32Rf4/wSl8f0h6/Ds9L2fDm6wedLFam0WSNgPIo2OgJfrTm6lZ1Vaj7wfiqMSrW+XypJB3IBWEs9RZ2DprydP347vQ6WZH/BD3BYHMszqMpgcCSx535b76G7ELBbn+fdN7we5EoImLSBYGf6N61el9uA4UoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713230303; c=relaxed/simple;
	bh=1qvjpJt3jRPZP3O/80pfTwah1p1Vwls/OOUs64VkZhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKAQwMXemLcUn1GZ+IGN9eQ7/3OzFrh6xupHYKrsSv+gwTRMQP0MxtjpCxUCS+NT4lpMbgUivVguiFUpIMlb4ohXPWBv+tzpnWzo4UYZV8cLIK0O9ioECGnFcvzXI6S6mb130Ewdd9u6Jrh8cfCT0NYlRddUo/wr5VZ5niCVHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BskwGHFi; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5176f217b7bso6626059e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 18:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713230299; x=1713835099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VYYp2/ymyynKr4E4UaWvwoSlif1IqUuPBOarTvfMGUY=;
        b=BskwGHFidS7xY63QBj3xu3xb56FBpdJiiIiimDqetKr2Az8Ukir9aLYPPCfqyGwO+O
         2z4HvxwTwtoRoZSCCpJNi3KImLnUudfZqiJ1WrL6X875JspBMz+t9s5ztObBqpSSASoZ
         8CiUV5Maa98YzEjGf5lVvnmjHqmD3TvYS8IgpeSl51lDMLqd+0lteerOxBNtAON8FsWm
         fOzdIQVOF0t7U2Tw4131h7jwH7HGbaweFlgcFE4PETzJFyL3/u/rFdwM09eZ3wn7y1Ks
         WixtZsxB8ncAxYU2Tue6I68bDNOjQlTXvaLDIdJzROdphkKTp7aybv1K5M/VppceIIXs
         onOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713230299; x=1713835099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VYYp2/ymyynKr4E4UaWvwoSlif1IqUuPBOarTvfMGUY=;
        b=a++rMVzLsSUl65frS3uw9W9LfmmdeTKYFS3Bc2DXgj/mj2JcHQuN7IK5vmGGJrs3wO
         bJzD4DJqaukkvvX8XKaW5Dg2nGYEyju9RKXgUjdys4t4olg4il9JWk0RpMBONi3+xCwr
         CI73KSMJYKF3TFpc0OoJ+hl6oeMjzWQPccD0QQyEjQmPVIsip6lICi8LNt7jzPuP5pJw
         5jf81anW0wQWQ6l72/ouRQXay2bpXGyiFCLUk2SCIfPMUjzJMY/EhBDVzh3FxogFhKeM
         IUlrfq1tEs/cGHmbiBoPi+Rn2IbWbmRFRIQxUvEQrh/ArGeMKvzNFJucV+15/xQbBcJ4
         kU0w==
X-Forwarded-Encrypted: i=1; AJvYcCXOUjdYxmmAmczgItMLDI0NFNxo0JGUmQpv9xRUPckcMj97sOohtUl27mFnkpVeJmpMMNHHY3Ck3W06tQH1pTkAQyHlDcFyMKeY/g3u
X-Gm-Message-State: AOJu0Yyum9ju30BpmzoEHOwCwQVR0zgk5DVhpLPYwA5a4mU+cR2Z03o0
	oCZ15Gdbm/+xlFtbLtAvjN1vm7jAz4crUNBizTg34ZF+2eMIEX/7mV4A2bxgpk4=
X-Google-Smtp-Source: AGHT+IGtZaxlgwAHmZ/z2k0KkTHsoUAQLBPMNvduRQSASeruObRUVt30aWE4VNZTKGFu/1BexV9HMg==
X-Received: by 2002:ac2:538c:0:b0:515:9c73:e29a with SMTP id g12-20020ac2538c000000b005159c73e29amr8603965lfh.66.1713230299475;
        Mon, 15 Apr 2024 18:18:19 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id b15-20020a056512304f00b00518e1e77eb2sm493616lfb.179.2024.04.15.18.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 18:18:19 -0700 (PDT)
Date: Tue, 16 Apr 2024 04:18:17 +0300
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
Subject: Re: [PATCH v3 4/9] drm/bridge: lt9611: Don't log an error when DSI
 host can't be found
Message-ID: <gcq33bcaindlrllyhjdcmfvn4irmr5onisekajdxji43rsrpt5@g5cbavz5xfcs>
References: <20240415-anx7625-defer-log-no-dsi-host-v3-0-619a28148e5c@collabora.com>
 <20240415-anx7625-defer-log-no-dsi-host-v3-4-619a28148e5c@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415-anx7625-defer-log-no-dsi-host-v3-4-619a28148e5c@collabora.com>

On Mon, Apr 15, 2024 at 05:49:32PM -0400, Nícolas F. R. A. Prado wrote:
> Given that failing to find a DSI host causes the driver to defer probe,
> make use of dev_err_probe() to log the reason. This makes the defer
> probe reason available and avoids alerting userspace about something
> that is not necessarily an error.
> 
> Fixes: 23278bf54afe ("drm/bridge: Introduce LT9611 DSI to HDMI bridge")
> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

