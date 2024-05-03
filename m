Return-Path: <linux-kernel+bounces-167851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2D98BB03A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 951A1285944
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F6153BDE;
	Fri,  3 May 2024 15:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="rPaxwx6D"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA113B593
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 15:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751153; cv=none; b=TAhlFRrJu/Rm37mBWwHpo8F4gLH6B4iLDP5W2LoqDCA7V3q+ImLVIkniZuq+Al/6mTz5/xgLCrv0H4X2VfK6SIm5Rh/gTLsNnx0v7Xq3GKKU7CqYwXE38/UQzUPIWqb7vWoqjdSSalQ4617qbrUbWcGF9oREjexDSEWrOFN7Myw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751153; c=relaxed/simple;
	bh=fUaq/OER+1YjX7jh3aDlC30fid4qNUAszsmop75G2ys=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OxVF9JuQqUT7FnYG1TKpF4IMbi/iyZvJhLZd3FBJAOwCFnkth7fjKmr46MupctYjlUW1eKjFlmioJ56l1wJbmMlC8FLlwJhETpHoLrIpOLRsqYhryIVwfNolHB6Vw169ShiCWDuDvfBSRsWXdCVxj77LqFaSfXuA7JDVM0/Bkgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=rPaxwx6D; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6ee2fda66easo3032730a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 08:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1714751150; x=1715355950; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lhI9yrOs8CfZH6O0uthOl9q2oyvn0I4hgTlooPx6s7Q=;
        b=rPaxwx6DJCEo6CUA20OMZUF35MjlOl+EFkK5300JgUFzLIVGq4EFjQPa4LVOsZu7gG
         x0CRgZIkRgvxYmEYkTj1a/Hy1zETcHn3XJQXNCLrlIjwuPFygzerJTi0Y0qKxS2a5BWQ
         16anriBIRu+FBTyeBMIdZ297P8ZKbG4jZd5Bbt7PxCc/jpT0ae5pAoeazuum8wSJGhdW
         9Wpgq8doFsIoIUYpnkcNsELgQAO7blmD2Rc9bJLy+nG+iPADj1s9COHB4StC7+TxDeLR
         hmrECD1W/ovaITlgFufLWrUhMX8g2ASAN4rAaS1gVCFpBZlX2GgE90+fv+8WxUtKJUMj
         3Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751150; x=1715355950;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhI9yrOs8CfZH6O0uthOl9q2oyvn0I4hgTlooPx6s7Q=;
        b=qKJz8kXJfuNEdTAmSJCHa8IjwuwJar+EmAgsWJLtnoJdekSYciijdu44UAkJsIwz8I
         CZIQ9um214GMRLhlTvGn+x7RLo9XF3e0fhQQ1uaQhOWXz4vRiEaO1izUIpPN6m3xNCzg
         ZvqSacoDHIzhLwjj2YrsLls0XC9xEXcD7jKmW8Z5CNlQ3gNpFjQgUT5k2YPd4IJdUZ70
         1a6IvGziyEZTeQVXrYV3MU+a0u44aVwF9BJ6w+UUO92hufi1Y0iNgccFTtbXgnBzHLCO
         xuKNFgOjx08KMKlMGTO2DjwxnDejXVsqSph+9K1duFnMDQxO4EHu4p2TZGgR8/7nPb9z
         ndfA==
X-Forwarded-Encrypted: i=1; AJvYcCUu/fcx4OIHwIW0HmwwIubK7kQ8i9wU0Iqq1AGFXKIyh0TgTBwQ1OhEGuNmHZPFBDQUoC9jyIVA2zE/ekFy2kDrLvmrsBAJeUM2Qlwv
X-Gm-Message-State: AOJu0YxjMMdZQP0/f2aU3X0y3qU+TAIECtF1Mxz+YWlJcNf1bOChMnoG
	NucCoo0Nig8JCOifEGar5hCEs/HqBlrYpvZFCyoFJIaCyLXh5Dyn2CeEQB+yGpy14G5oyfTCKoq
	0hdo=
X-Google-Smtp-Source: AGHT+IG+DHh8GvHSrOBGw3RTRskRbLb5djVyMax1LElsUz89VQIsBT1Casz2tEAHJdHp4BCTsvIuZw==
X-Received: by 2002:a05:6830:1212:b0:6eb:c365:e68e with SMTP id r18-20020a056830121200b006ebc365e68emr3519049otp.25.1714751149969;
        Fri, 03 May 2024 08:45:49 -0700 (PDT)
Received: from xanadu (modemcable018.15-162-184.mc.videotron.ca. [184.162.15.18])
        by smtp.gmail.com with ESMTPSA id h12-20020a05620a10ac00b0079285113b99sm23092qkk.50.2024.05.03.08.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:45:49 -0700 (PDT)
Date: Fri, 3 May 2024 11:45:48 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: Julien Panis <jpanis@baylibre.com>
cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
    Matthias Brugger <matthias.bgg@gmail.com>, 
    AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
    linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/2] thermal/drivers/mediatek/lvts_thermal: Fix wrong
 lvts_ctrl index
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
Message-ID: <qppo2o23-40r4-956p-9n35-p0556sp32spq@onlyvoer.pbz>
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com> <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-2-f605c50ca117@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 3 May 2024, Julien Panis wrote:

> In 'lvts_should_update_thresh()' and 'lvts_ctrl_start()' functions,
> the parameter passed to 'lvts_for_each_valid_sensor()' macro is always
> 'lvts_ctrl->lvts_data->lvts_ctrl'. In other words, the array index 0
> is systematically passed as 'struct lvts_ctrl_data' type item, even
> when another item should be consumed instead.
> 
> Hence, the 'valid_sensor_mask' value which is selected can be wrong
> because unrelated to the 'struct lvts_ctrl_data' type item that should
> be used. Hence, some thermal zone can be registered for a sensor 'i'
> that does not actually exist. Because of the invalid address used
> as 'lvts_sensor[i].msr', this situation ends up with a crash in
> 'lvts_get_temp()' function, where this 'msr' pointer is passed to
> 'readl_poll_timeout()' function. The following message is output:
> "Unable to handle kernel NULL pointer dereference at virtual
> address <msr>", with <msr> = 0.
> 
> This patch fixes the issue.
> 
> Fixes: 11e6f4c31447 ("thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor slots")
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

> ---
>  drivers/thermal/mediatek/lvts_thermal.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 18a796386cd0..d7df6f09938b 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -116,9 +116,9 @@ struct lvts_ctrl_data {
>  			      ((s2) ? BIT(2) : 0) | \
>  			      ((s3) ? BIT(3) : 0))
>  
> -#define lvts_for_each_valid_sensor(i, lvts_ctrl_data) \
> +#define lvts_for_each_valid_sensor(i, lvts_ctrl) \
>  	for ((i) = 0; (i) < LVTS_SENSOR_MAX; (i)++) \
> -		if (!((lvts_ctrl_data)->valid_sensor_mask & BIT(i))) \
> +		if (!((lvts_ctrl)->valid_sensor_mask & BIT(i))) \
>  			continue; \
>  		else
>  
> @@ -145,6 +145,7 @@ struct lvts_ctrl {
>  	const struct lvts_data *lvts_data;
>  	u32 calibration[LVTS_SENSOR_MAX];
>  	u32 hw_tshut_raw_temp;
> +	u8 valid_sensor_mask;
>  	int mode;
>  	void __iomem *base;
>  	int low_thresh;
> @@ -356,7 +357,7 @@ static bool lvts_should_update_thresh(struct lvts_ctrl *lvts_ctrl, int high)
>  	if (high > lvts_ctrl->high_thresh)
>  		return true;
>  
> -	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl)
> +	lvts_for_each_valid_sensor(i, lvts_ctrl)
>  		if (lvts_ctrl->sensors[i].high_thresh == lvts_ctrl->high_thresh
>  		    && lvts_ctrl->sensors[i].low_thresh == lvts_ctrl->low_thresh)
>  			return false;
> @@ -617,6 +618,8 @@ static int lvts_sensor_init(struct device *dev, struct lvts_ctrl *lvts_ctrl,
>  		lvts_sensor[i].high_thresh = INT_MIN;
>  	};
>  
> +	lvts_ctrl->valid_sensor_mask = lvts_ctrl_data->valid_sensor_mask;
> +
>  	return 0;
>  }
>  
> @@ -1112,7 +1115,7 @@ static int lvts_ctrl_start(struct device *dev, struct lvts_ctrl *lvts_ctrl)
>  	u32 *sensor_bitmap = lvts_ctrl->mode == LVTS_MSR_IMMEDIATE_MODE ?
>  			     sensor_imm_bitmap : sensor_filt_bitmap;
>  
> -	lvts_for_each_valid_sensor(i, lvts_ctrl->lvts_data->lvts_ctrl) {
> +	lvts_for_each_valid_sensor(i, lvts_ctrl) {
>  
>  		int dt_id = lvts_sensors[i].dt_id;
>  
> 
> -- 
> 2.37.3
> 
> 

