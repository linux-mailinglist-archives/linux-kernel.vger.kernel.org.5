Return-Path: <linux-kernel+bounces-50604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E75847B7B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA8F28EE1A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DB0F82C60;
	Fri,  2 Feb 2024 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uPhtJpsD"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080381757
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706909140; cv=none; b=YxLPLepMxd/NhvCS01Br5HV9GJthBLfB6rYJH/sHkXCaJSuT88/IrewfPXMt6xCG9fZxyPlgn335jjZ6V7YUZ/rIThSSSqt6xex1v19IoKTLDTRThMG1I3APgvZBQP7fa5KY8eyQKcNLKWuL/sW1aR1opRFrdZzGiw4anfF0PbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706909140; c=relaxed/simple;
	bh=yHdjpgAxFmkCMJYBGgkLlTADiZ8kTy5DYRCIr3Qaxi4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oOLYFGRQG/g/rYMD/yL+lvS/K0rFDHcsJhFsY1B9wLLt0EUiM3q8lFGF8ZMlnk4TU5LGWIDIYS2mh7+3ACUj31WPjZ65c9VuUCWNZvvWn0JL0toMEzFSvsR8SREJvWPi2Yj5V0NiuCRehmefeDF6NDmem9RRykKd0iMIU85KrAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uPhtJpsD; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40f033c2e30so22246455e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706909136; x=1707513936; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2l1vKjEO69fnmNEf9Uo/eu3DjX9aySgEHPSFlO9MDc=;
        b=uPhtJpsDzbz5j0vMt5ubW4+x5e6bho1RhxG1fE3PhfP7etpSRkl00smfBHtKb9mGYy
         XvE1ljdNoe64hTMh4iAHepObMkUCy1O7YHYOAjGN7+R8PN1/hRnNH2mH9HT3vH4fCOHN
         +GAZ3xTuMdZK0hlwXWr7g2p/Zr807BU84To9vawoqxan0BNLKZTRVLS1TCbk6kd3WsbY
         LPgw5w8HSYPiGPwo6bsIK/V6btTmmB1HjErrJnWS7BVxHDIfUI35KxHxre9tfgwxm7zZ
         txGrLb1ZPwqJtraCHVyMVm19Az86FM/ouYZG4pGGJ2BaW9qi9cXBqsXa9Y2QVIbB4Ioo
         8+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706909136; x=1707513936;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G2l1vKjEO69fnmNEf9Uo/eu3DjX9aySgEHPSFlO9MDc=;
        b=czXDUbKqHORYoPoVK4EBDw1oegVxUvP03jL21q3k2V2GUP2akbLn3rA60LWAjv8fNu
         fSTnEF6r2v02nr1DxVKvF4qWdVuGs4lQrbq0fZ0Uqv+bKTx0u3MTj6i+Imf5kJuwxrWt
         E0tLhW2mbQg2kyDVtwOHFUgh1lTcghYHw8yIgjEagHrQl5GKKyXCxwoCOTOnnkzPCX5+
         qB1NIXSgy+QAC6NqRv09cXXImpz+i/IAdfNWRgoxM1fE0dpPOXm8nsaE+hjfjtwdW5o6
         H+y/egLqfIpzr+J6qeqy9+xThNqTiYohxXkU0fMVublan46RE5JLeCwX7q2u0OFsXXYC
         Haxg==
X-Gm-Message-State: AOJu0YwfrJlyBfUQr7WkVVShVjzkB/89gesSsU+aig3dP/J/1lgqGS/W
	AgQTebb2PDqa1lECHCSjUegFBW8a0xLitLHKIEZoj/fAjRNvyo/g/9JHa2c1GUFSgdXbKcnMvRa
	KlVY8N/Af
X-Google-Smtp-Source: AGHT+IHEBZOZxowXtpo/c/Xaah4wsH4tucEmfywHPsgUII4iIa2gexhTWOs4OV5G/fhXTNN4tzj/VA==
X-Received: by 2002:a05:600c:5124:b0:40e:c564:a9ea with SMTP id o36-20020a05600c512400b0040ec564a9eamr2588613wms.20.1706909136202;
        Fri, 02 Feb 2024 13:25:36 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXk4gqCnDtl8MrBOQdVLHv4VmoDrdjiyhT9ApAAwqJHleblyFeGul2tpBUBcfRe988Jb+yJ3MpSACYV8IO2psd7EOAszjGwNK3aBQAU0EPlPeFBO0RpJ1kNrfT9gnUFKhWNZ7XQWSiF8i5lkQXLumJzXqAyQIOxyxqV2iizlpbpO05YWb5osenx8rheBDdytKvk+XocAZo/4srAkKHo3cn+q7dsypD1RfZX3wuFSlg9bA6LfnY1Y5xXJFxuhDHtjVz6sc8tXhMm4vAJ8vh+7DAQMyV1cO1M1Y7OmvDTp7AArwkvUT5/tpwxUwMbkjLnDALcWoSSBbKjbgo3NxbKH2pOQ4KtcNC56YorTgvCLn+S02cI/g==
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
        by smtp.gmail.com with ESMTPSA id fa18-20020a05600c519200b0040f22171921sm976140wmb.3.2024.02.02.13.25.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 13:25:35 -0800 (PST)
Message-ID: <4af20f9b-6e08-4646-a659-c02234bedb29@linaro.org>
Date: Fri, 2 Feb 2024 22:25:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] drm/panel: visionox-vtdr6130: Set prepare_prev_first
 flag
Content-Language: en-US, fr
To: Jessica Zhang <quic_jesszhan@quicinc.com>, quic_abhinavk@quicinc.com
Cc: Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 quic_parellan@quicinc.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240201-visionox-vtdr-prev-first-v2-1-32db52867624@quicinc.com>
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <20240201-visionox-vtdr-prev-first-v2-1-32db52867624@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 01:10, Jessica Zhang wrote:
> The DSI host must be enabled for the panel to be initialized in
> prepare(). Set the prepare_prev_first flag to guarantee this.
> 
> Signed-off-by: Jessica Zhang <quic_jesszhan@quicinc.com>
> ---
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Sam Ravnborg <sam@ravnborg.org>
> To: David Airlie <airlied@gmail.com>
> To: Daniel Vetter <daniel@ffwll.ch>
> To: Jessica Zhang <quic_jesszhan@quicinc.com>
> To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> To: Maxime Ripard <mripard@kernel.org>
> To: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: quic_abhinavk@quicinc.com
> Cc: quic_parellan@quicinc.com
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-kernel@vger.kernel.org
> 
> Changes in v2:
> - Corrected commit message to mention that DCS on commands are sent during
>    prepare() instead of probe()
> - Dropped Fixes tag
> - Rebased onto tip of linux-next
> - Link to v1: https://lore.kernel.org/r/20230725-visionox-vtdr-prev-first-v1-1-3bc44cec7dc6@quicinc.com
> ---
>   drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> index a23407b9f6fb6..540099253e1bd 100644
> --- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> +++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
> @@ -287,6 +287,7 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
>   	dsi->format = MIPI_DSI_FMT_RGB888;
>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_NO_EOT_PACKET |
>   			  MIPI_DSI_CLOCK_NON_CONTINUOUS;
> +	ctx->panel.prepare_prev_first = true;
>   
>   	drm_panel_init(&ctx->panel, dev, &visionox_vtdr6130_panel_funcs,
>   		       DRM_MODE_CONNECTOR_DSI);
> 
> ---
> base-commit: 51b70ff55ed88edd19b080a524063446bcc34b62
> change-id: 20230717-visionox-vtdr-prev-first-e00ae02eec9f
> 
> Best regards,

Thx for resending, it's time to merge those.

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

