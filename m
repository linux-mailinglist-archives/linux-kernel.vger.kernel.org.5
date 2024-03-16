Return-Path: <linux-kernel+bounces-105259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C29887DB25
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89C41F2228B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9A81BDEB;
	Sat, 16 Mar 2024 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lc3lappg"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA51BDCE
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710611172; cv=none; b=SMv1r31ZvwV+ciJJwwz/ezeBy+tPs62CISt/98g/tdh55HXvsClMteDcyXO3BjohYIc50pcW5SPujECUgkewDwWkt6pMm+LSefgERQFPT1NnmAGtBmmMo2EZXZpSgAlqJ1Hvh/ZJQmRwrQhU6dLGcM3zv7k1uUS2+GN0Hn/Kim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710611172; c=relaxed/simple;
	bh=M+4DEEEUEl0afhjUYKQAgk6p04F83BEyWto2vdZHvhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IiwNJIrcegOfcroIyJ5SR1TsuIP6tEIYd4EF3qFsbwIeddN3cWdjL2F5QVghe5Yu9YpeDtEUotXAVnYBjx4iTn1M03Qx8YN93whdBzg1R/O4e1C8dW9BdICLk8QAYb732y3McyD6QP/9MamJPosaDCkYIqyphUcdjctG1MAW+P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lc3lappg; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc74e33fe1bso2738277276.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710611169; x=1711215969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/jDQnfexRAaZBb4mA5SjsUMEcUJqWlLJO4zyEq1ignU=;
        b=lc3lappg+XzmbUgBd0FNnBhVgwhHSjCDk2vlMmeKgEYWzvRWQJDNKAtaZcbupKbJ+f
         1KWMSfRmrRxqvs3ccfAMRCQ2G8UzoYaU8BGAlZ6oMLywRKWki2WsAvaWPLHb5ost2lWI
         z8obp82LO5tK8jIz8dePY4oHmUa1+w2ps+zGaa3N+byF39nhK38oOUR71nFcf7YkRy1K
         niqoYZbz4KYJQpf8ZKiO4pxi8BRztX1bSXrld2frW3pzLst+4hX9SvEw3eZcEhLumxUL
         gmshAhS8OmHRnoDHajfNfESvgfejgVbbBsvNNk2j3pFg184AnprZ6Uw90JCyl6FLDTtQ
         0HJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710611169; x=1711215969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jDQnfexRAaZBb4mA5SjsUMEcUJqWlLJO4zyEq1ignU=;
        b=sRekSkz67VUMqcHe46C9jXufp7gPKlF7kD6mRayTCFPc3wjjgesBYRblZcW2PIeWd9
         0IQf4g0uga9c/uQr3DuzyuSw5F3cFhbHyTT7k2YwuO8oWa/u+JqcGzOOclIQi+oFs+y8
         MoKL16mTTqP/FnYAhfTSbexfbk+Gpz4G6LPsoYMbW1f0G2Sq3TBVWoeP+JheWRXz7Z8m
         IAT727cZGcsagS4fuYqmk9jalTK16IUQF3yxeStih35Tg3Mqqy28NRiB4e18eY0VB4P4
         ZZ2aYOXuuWXwVaCzOKFk0d023XLkwaN1mfWUVvk2nEImECeHsvTi+b+VMRVNT7O6hJg3
         Uy8w==
X-Forwarded-Encrypted: i=1; AJvYcCXUI2BMBCN0z1g1gRdH8oIPO3Lan9TPTMqDBFRwciWhi0Vn+/+Q8Q+yV41qZzPF9aaGI9pCrZCC0BrofedS9u1NxiZCurOiH3y8lSdK
X-Gm-Message-State: AOJu0YygR57LCklnWU5KWUyE7dcli0Aff7shfbLgHG5Md9IrRE5juuO2
	NJsGDurdlUJa9/dt/83vZIlptJgIkZDDcIgrU0BlTR74OajXkVoGoDo2ZWAioT94qY/e9t1uyXH
	eACFuYKokyXVbRQxPI/udtwxPEv5eR/tIYasKcQ==
X-Google-Smtp-Source: AGHT+IGdC5E7PAsxboi42yhdSl7XjiyhZK/iuxmm2lnN7sgPMVcZcSoWPk2e/QRJOpCUBVbGokHqNfQucKWzg0H4Do0=
X-Received: by 2002:a25:8485:0:b0:dcd:a9ad:7d67 with SMTP id
 v5-20020a258485000000b00dcda9ad7d67mr7019806ybk.8.1710611169344; Sat, 16 Mar
 2024 10:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316174419.1170460-1-sui.jingfeng@linux.dev>
In-Reply-To: <20240316174419.1170460-1-sui.jingfeng@linux.dev>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 16 Mar 2024 19:45:57 +0200
Message-ID: <CAA8EJprwFdTfWYRprRL=Gt3PrnQeH-SnYAPvYEfr+=kM0G1H9w@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: it66121: Remove a duplicated invoke of of_device_is_available()
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Phong LE <ple@baylibre.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 19:44, Sui Jingfeng <sui.jingfeng@linux.dev> wrote:
>
> The calling of of_device_is_available() in it66121_probe() is duplicated,
> as the of_graph_get_remote_node() has already do the check for us. There
> is no need to call it again, thus delete the later one.
>
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 6 ------
>  1 file changed, 6 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

