Return-Path: <linux-kernel+bounces-30837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47DB8324EF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C75EB21943
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5807F8F6F;
	Fri, 19 Jan 2024 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nKDYYAt+"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1487C6AA0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705648449; cv=none; b=N7QHFsda1gsqhomQQPqqVr4lOX3fHe65TitgGRB8UWB6XgpaD9Uupaj+0K0KrqSxjeNIwGa7j2c74yh0gHZ/or8zwcqqc+eENiKpuvLL2+BELndghy9hFWC2goQf9bhZDHo9VBIKbdMCZYvmC31T5AeyLf5d1HMW01yvJU1Njho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705648449; c=relaxed/simple;
	bh=+0T0th1rKcmyeEaP/OzGGn0TFYJ3ZGJGGrbEuBW5aoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3dglVg+fiu6ItrCLoAZ6XfWD/1NNhZkadd6NoMx3YvS8NOFFqQROkGf/XlK8tQwOISRPX7bbnEJ4ya+0340Sn8nbDINzHxRRRGQhQ9ChEka0feOZd3q2R8oXyn1Smm0245y9a/NNJuIRXf126oaJyVx6RmU8X55hOvT04ViGs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nKDYYAt+; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so5087075e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 23:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705648446; x=1706253246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i72MfFyOZMrd+BSQwwi+n4pSqhokb64bOd5tJv0/2UM=;
        b=nKDYYAt+qZ77YMOLkaGtKY/WsRdiSfxAhWtdgauBXqN5GzQYtPoSpoeV+m6kOWekmV
         q/KRYy6xphsLoH/Dk+GMyCrIgV0vCSe+DQwQmQqoJ86amTmXoQKJWm+tTnuXC+0ifubd
         7vI2ijAIwi5aQwRg57YlCfS2bk1KZmq9pqlyMDA3MS9YcOEslnuEg+nu1dnopo/PwcaQ
         eWGbBU4KzC5LjJnlol/auFqnmYqLS33S2EAh91Q8bH62nJTQibqHgYB0pdd2CA7wVGcv
         zM5aCzdiYFIKWyOt5l1izpE4SwCXZ0kbqYH++O+mJ5+lHZJgWBTpK/KLuEflRqVQk3fc
         KAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705648446; x=1706253246;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i72MfFyOZMrd+BSQwwi+n4pSqhokb64bOd5tJv0/2UM=;
        b=dfbW2uFcYFMOdbmRYvDMyVyu+RijBhs4rOmQtnm5SHXQjuTlTV3I+JimNIhaSb9W72
         3NXFQnYyC+QWdbP83af5O/ahh46NpWQ6WdJGRgxWDyJMl6A9yNTcMyVdOel8iEAh4vjV
         e49z40opzQsf3LxS0Ra7gZbrF8b/BIRlucbWg6x4B3/ONC7ioz4JlSbh5RoLtFD7fHoT
         8MQ8kwqgOXyw4PI3VxrZoulMCzWiPTCuDozsRAYk0Tz0nxGLLhj7tIUEZXXjjlwcEfXr
         ftQKkIwnC4PEX/4f0CBaunrd8b30yZjAUnJSmGTUzta6WEX98+ZibAYE/L0xGtd4hlI4
         7Uhg==
X-Gm-Message-State: AOJu0YzLihCPbc7kmIgdfRdX7EjnBcRRfD/rJy63KUduatsMJNCTBD4c
	AcZDTypiOtOO6yqH42NIH9Yj1gAj7hCzbGptLxtRpM988VkNGV4kySyglUS/8Fw=
X-Google-Smtp-Source: AGHT+IHl2Kkada6JZ4n+CkhFjQG/uScWhBunryRyzHRlXDI9RMUkV5Irt0J4JgQHuxoC6mETq4UhQQ==
X-Received: by 2002:a05:600c:3b0f:b0:40e:9f2f:3590 with SMTP id m15-20020a05600c3b0f00b0040e9f2f3590mr102316wms.272.1705648446196;
        Thu, 18 Jan 2024 23:14:06 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 2-20020a05600c020200b0040ea00a0b75sm14034wmi.0.2024.01.18.23.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 23:14:05 -0800 (PST)
Message-ID: <3494d23f-2a56-4f13-a619-e240d208d300@linaro.org>
Date: Fri, 19 Jan 2024 07:14:03 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] ASoC: codecs: wsa883x: fix PA volume control
Content-Language: en-US
To: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Banajit Goswami <bgoswami@quicinc.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-2-johan+linaro@kernel.org>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20240118165811.13672-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/01/2024 16:58, Johan Hovold wrote:
> The PA gain can be set in steps of 1.5 dB from -3 dB to 18 dB, that is,
> in fifteen levels.
> 
> Fix the range of the PA volume control to avoid having the first
> sixteen levels all map to -3 dB.
TBH, we really don't know what unsupported values map to w.r.t dB.

> 
> Note that level 0 (-3 dB) does not mute the PA so the mute flag should
> also not be set.
> 
> Fixes: cdb09e623143 ("ASoC: codecs: wsa883x: add control, dapm widgets and map")
> Cc: stable@vger.kernel.org      # 6.0
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   sound/soc/codecs/wsa883x.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> index cb83c569e18d..32983ca9afba 100644
> --- a/sound/soc/codecs/wsa883x.c
> +++ b/sound/soc/codecs/wsa883x.c
> @@ -1098,7 +1098,7 @@ static int wsa_dev_mode_put(struct snd_kcontrol *kcontrol,
>   	return 1;
>   }
>   
> -static const DECLARE_TLV_DB_SCALE(pa_gain, -300, 150, -300);
> +static const DECLARE_TLV_DB_SCALE(pa_gain, -300, 150, 0);
>   
>   static int wsa883x_get_swr_port(struct snd_kcontrol *kcontrol,
>   				struct snd_ctl_elem_value *ucontrol)
> @@ -1239,7 +1239,7 @@ static const struct snd_soc_dapm_widget wsa883x_dapm_widgets[] = {
>   
>   static const struct snd_kcontrol_new wsa883x_snd_controls[] = {
>   	SOC_SINGLE_RANGE_TLV("PA Volume", WSA883X_DRE_CTL_1, 1,
> -			     0x0, 0x1f, 1, pa_gain),
> +			     0x1, 0xf, 1, pa_gain),

gain field in register is Bit[5:1], so the max value of 0x1f is correct 
here. However the range of gains that it can actually support is only 0-15.

If we are artificially setting the max value of 0xf here, then somewhere 
we should ensure that Bit[5] is set to zero while programming the gain.

Whatever the mixer control is exposing is clearly reflecting what 
hardware is supporting.

--srini


>   	SOC_ENUM_EXT("WSA MODE", wsa_dev_mode_enum,
>   		     wsa_dev_mode_get, wsa_dev_mode_put),
>   	SOC_SINGLE_EXT("COMP Offset", SND_SOC_NOPM, 0, 4, 0,

