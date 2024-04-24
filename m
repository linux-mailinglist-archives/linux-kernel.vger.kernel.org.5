Return-Path: <linux-kernel+bounces-156429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9018B02B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF6D1F23468
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7F1581ED;
	Wed, 24 Apr 2024 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l0qYoG5h"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B5157A58
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713941706; cv=none; b=fR4TSKwc+VylairGJjZNdg4gGIy1mAT9isDoyqtUMB290Vygq1iZQ2tJluaVaiQ/SzpjdGmf27htCZ8MlA+tAueINN7A+9mz+cCZh+qQB6SgfdtEpRTSq1Ju3pjB37//A3iO3Sk2IkkMXOR8cYFFwxUYQLD0dHkO+VBO0VFRQVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713941706; c=relaxed/simple;
	bh=2XhfFwctqsbzovhmTIjCDs+a1BFCDnVkY5bwnZTc/OA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PieJ5Jsn//iVBithXyUIQ5OVNcGWnlpNngXUoabXd5G21Lq30rx6pLL0eEDEKk1VGUHZ9K6awwCeAB8j5Pu6al4ujH8MWee6H6HdG3F1j6+DJPnOSmWuttFa6atIJP416HOHOvtDHSYvtxh86M8Yig/iWTXDBWdIJd2X6u6x2wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l0qYoG5h; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-346f4266e59so4786123f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713941703; x=1714546503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r+RiNkpTT67c+Jikygw60JZoKtr1v3HMpfdb1pwNcq0=;
        b=l0qYoG5h+OQuBclB9xVj/lDQ/f/dOpKTes1F8IbpjPmL2l4xRwusj0+xuntIWdqPYD
         FiScGYzph1agVTMBx2uySMWTC8QU6ojE6Co9o1r4qAiXZNnz1nboBBZzsQzhilTBCXsf
         MuRTdv6JRWxoXFYDEp/TV+wtWxIQqOGBNPnL4hUjT5lS+yijeZ3unmLLrI08TlzD3saQ
         IUSFLCfVio5gaO1+ApSxdq0P1kpfulf1GI/bspg2Rdd6hhsohjyrCj+DmJhOkATD6YjO
         cBorLZVS+b4kX4CRmfiDtAVKSNSJxKfakKWW6viIPGm70ALAtCea59tJHWrJadARRvEG
         wL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713941703; x=1714546503;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r+RiNkpTT67c+Jikygw60JZoKtr1v3HMpfdb1pwNcq0=;
        b=FU50nnbK5jxJSveLs9XMRIf82YmU4FmfASnIMujXRd7hsYSuRKjFkNDXrMrFLEpM36
         yvoZ7XuitZM2/EBxXEFpr8FBu99HNCFQ37UGI7Hva6yHq9mY4iBT+gH4wNDGgr2kRJWe
         wrBnnCXeVq10ezNN5MxFiUNLk8KMBrXIL3v0hrCP+9LaHZPYjH4GooZcfxy+8jZdnvCL
         IAFQcPDIVSHOE8zZwfg3ErM1A+XB6goLiBV4pqprTsDQ4fgivOqRqfpYMwT9IuOu/x9a
         v2xwEUP3VDmrwMTJ2PLxb/CYeUv22iv8WvCJ7KqAq2fo4WtQUNlOHlZPY3aXmkUh+8tL
         37Ew==
X-Forwarded-Encrypted: i=1; AJvYcCWTjgUZSEERvTRz6btMcduE6F8VKJwX2zFlqOMNqG2HiPDO3Vzct3eviNLeaa7PCj5vCX0ulDvQHtwIt3YXigcNxLDWVd+NJ/UoPHGN
X-Gm-Message-State: AOJu0YyPfZGoah6JGF1703lX5b23JPwdxoa2AXH1myg5I/DTBGj2R5WS
	4sblSmcT+F8KhKKk+kHLtV/EOwNlO9REoFb8JPbqiJpcJP+xOaYof1EVjz7qwCo=
X-Google-Smtp-Source: AGHT+IGNKWVBieVz255aNClvsH+2jzONPqPRM0oOAr8zVyqkqb54fuCgxynR0VPAmuJ8zf9n/6rDLw==
X-Received: by 2002:a5d:518e:0:b0:347:70ce:c5e3 with SMTP id k14-20020a5d518e000000b0034770cec5e3mr1030693wrv.19.1713941702840;
        Tue, 23 Apr 2024 23:55:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7? ([2a01:e0a:982:cbb0:ed3e:c90b:dd74:51a7])
        by smtp.gmail.com with ESMTPSA id j13-20020a056000124d00b0034b7906c716sm3152170wrx.106.2024.04.23.23.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 23:55:02 -0700 (PDT)
Message-ID: <bd98ec65-c21d-4a32-a922-ada50fb65801@linaro.org>
Date: Wed, 24 Apr 2024 08:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] drm/panel/lg-sw43408: mark sw43408_backlight_ops as
 static
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
References: <20240420-panel-sw43408-fix-v1-0-b282ff725242@linaro.org>
 <20240420-panel-sw43408-fix-v1-2-b282ff725242@linaro.org>
Content-Language: en-US, fr
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
Organization: Linaro
In-Reply-To: <20240420-panel-sw43408-fix-v1-2-b282ff725242@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/04/2024 04:41, Dmitry Baryshkov wrote:
> Fix sparse warning regarding symbol 'sw43408_backlight_ops' not being
> declared.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404200739.hbWZvOhR-lkp@intel.com/
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

No fixed either ?

> ---
>   drivers/gpu/drm/panel/panel-lg-sw43408.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> index 115f4702d59f..2b3a73696dce 100644
> --- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
> +++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
> @@ -182,7 +182,7 @@ static int sw43408_backlight_update_status(struct backlight_device *bl)
>   	return mipi_dsi_dcs_set_display_brightness_large(dsi, brightness);
>   }
>   
> -const struct backlight_ops sw43408_backlight_ops = {
> +static const struct backlight_ops sw43408_backlight_ops = {
>   	.update_status = sw43408_backlight_update_status,
>   };
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

