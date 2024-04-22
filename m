Return-Path: <linux-kernel+bounces-153974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 375488AD579
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684191C210AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505E8153BCC;
	Mon, 22 Apr 2024 20:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VpUNLEmA"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1341553B8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713816067; cv=none; b=sVy+/0BvtbuDWUEciBgi5CfEFbkzTc7QG9AuOeDGvfHZLkZPiDI8QUmBuqQv+6oJZqoaqvbq/C5ikbeZ1bgST+uTjH9RLyiz1tFSVpyykHKfffN7CxKYbBzQmDheUiXaua05d42tEZqIkeMj/M4rWMMnhym85SAgVqLvbqnhSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713816067; c=relaxed/simple;
	bh=+/Q5DBvhWS4Tha9Ij5gVAEun1OoP8dFS2ZBynxXJEnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn2g/WXqirT8uZp0hMv5PeNxIJFxlEIdXuRPlftq9Ua8y6hViV+UxV0HHfmb5pOMs/9BjtywJC95XYumw+CxjqxN/JLrbg2EEeTuc3CknJUqfUdC/LdnFPwOmMIFh3iafRrc/SNogGdXQ4diOonwmtCLauTv8fIjWmGfkD0C+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VpUNLEmA; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2dcbcfe117dso42089791fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713816062; x=1714420862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l/KzyeGjVvjPl3mw44prJgmddutMprerCYD3mvCURuo=;
        b=VpUNLEmAKd2KAEnnWN6+J3oZyZT3S1BjD2w23O2FI74HRb367vX9nX2lSmEdDjJ4PQ
         7qKCHxxvaGG+NCEXWr7NyWFNbWqQ7SBCGwyEjrl+SJytsbH9ClNexz0Ql9nkVAZ3CM+U
         jyxtehsk25NibtweG6nkdl5CEZ8AAjKm9qlJ2TzT5o0CxhMqtjZPjvsdQwfz5bNbCRqK
         XS72qEutpzPNL8wuzhhz2EHdQd33XFjOp4W0dgRNjviTstZMTZM3qBfUwXuBfxhrDnFV
         lvs4SL6Ki/9nyq2Z5Evi1Utzzxhj3VRukddU2bI8MaMFiOkpCLqCNhLcuR/i9kJFKhbM
         KDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713816062; x=1714420862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/KzyeGjVvjPl3mw44prJgmddutMprerCYD3mvCURuo=;
        b=tUVD379vvmhT6XUHTlcqXiF+HYM3zPLylj6dhk9rfWH8jKoWZR7laxeMxz5b0r5rAA
         nqjtAXj/qPTTPUXAqK7r83Glp5Qn5F4FwpfakjP1V71hgywyjdZLiP/eHM/hKlx43op3
         1mfFn3PoUZJRvHj7vV5JarYzl/fYGehAvYUR5B/Ojpj86+PqOIYGzF1BloBo9+aIEvnx
         5T6a7rm9hiR3NofS4UNPueW/Dj0M9cehcjx0RkCTo+eYc421G+M7QlEqsGzL5wRtujrU
         pwrw7DspTwpBXXdcWggUUmI5WhTjo51EKupfUoGG1Hou0+kz8l1LQsv05bQzQP1WFV8a
         E/5g==
X-Forwarded-Encrypted: i=1; AJvYcCW8IWBpFuhx5sbfmTXoFJQEJHX79tTKd0blRs1ibCEHojERZME73opyiIoL7FO2EWC9eSP7ysvNReEwEtc6NGnxkjhKNwmZTgWp3JPy
X-Gm-Message-State: AOJu0YyucF7HzDmhRsyF65SlxL1MoeE3EZ551OOwokkIzoEBfpEvdrG8
	KWg+1bVUqCtfTvXoIrKr6AuE3jk/yPdAkvCDIMTu3/ct4FnChkUudVFvpbpSNV0=
X-Google-Smtp-Source: AGHT+IEabZul5dxrpvaBVDKaplbJ0k/VcioOxOo78Zun52uaBZKpKHIJ3dRySN39XbdI9/aYEoQmOg==
X-Received: by 2002:a05:651c:2010:b0:2d8:3eaf:86d2 with SMTP id s16-20020a05651c201000b002d83eaf86d2mr7011409ljo.47.1713816062402;
        Mon, 22 Apr 2024 13:01:02 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id r28-20020a2e8e3c000000b002d28db9ce7bsm1556971ljk.20.2024.04.22.13.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:01:01 -0700 (PDT)
Date: Mon, 22 Apr 2024 23:01:00 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Phong LE <ple@baylibre.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/9] drm/bridge: display-connector: Add platform
 module alias
Message-ID: <d7rnvde4hlp2umn6usgfvbuwcz4x4ahoxp2lq7lcmdbv35k7ee@5lxfk5aw6slo>
References: <20240422191903.255642-1-sui.jingfeng@linux.dev>
 <20240422191903.255642-6-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422191903.255642-6-sui.jingfeng@linux.dev>

On Tue, Apr 23, 2024 at 03:18:59AM +0800, Sui Jingfeng wrote:
> Otherwise when compiled as module, this driver will not be probed on
> non-DT environment. This is a fundamential step to make this driver
> truely OF-independent.
> 
> Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
> ---
>  drivers/gpu/drm/bridge/display-connector.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
> index d80cb7bc59e6..7d9b4edf4025 100644
> --- a/drivers/gpu/drm/bridge/display-connector.c
> +++ b/drivers/gpu/drm/bridge/display-connector.c
> @@ -434,3 +434,4 @@ module_platform_driver(display_connector_driver);
>  MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
>  MODULE_DESCRIPTION("Display connector driver");
>  MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:display-connector");

Same comment as for one of the previous patches. Please add
platform_device_id table and corresponding MODULE_DEVICE_TABLE instead.

-- 
With best wishes
Dmitry

