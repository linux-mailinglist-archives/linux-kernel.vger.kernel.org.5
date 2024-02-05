Return-Path: <linux-kernel+bounces-52227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC18495AD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC2C1F24ADE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0131173D;
	Mon,  5 Feb 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zGiByVvU"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51DE1170E
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123089; cv=none; b=oYboFfOKkL14cagirQqkzIFyxoCZXGva1RqGLy/ftuoOTJnKSqaVDkYmG88wI1yYSJIJs1fqt7yi9AYALjiijAp1/7jiLVNC/Ak/W07MQHePl/cFxWm2sMa6gUcpK84bCL44eLTlzZhHjDpa9vMKclPUcu0ldxm3py80DpNOnnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123089; c=relaxed/simple;
	bh=D9mmiJbXQpG+nwXV5hAuOZEm476Yhkoeg8X9g/ft9Ps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bpQkdcTFllxz9NmR4RO34onJ+JejUc7w2YzV6433IV5rYb+umcHRNEbpCIi3YtQ3gz497oiR9mJvu3c3Tt0rCutPOJi+4PPlgvjj3gCSpKSpYs/HAkiRwUlwe0Q13X6M3OONQfurWljI8D/ollrrVR5Rald6vKdqhDvIsTDB2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zGiByVvU; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40fc6578423so24627355e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 00:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707123086; x=1707727886; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YqRUU6pWIpicQvpTSqgYz/3iwXAOTziCuAH0zZKlZuU=;
        b=zGiByVvUaJNnNB/Z8ZuN2Xq+y3ja9cb+BhYU4fiPv7TdXLZpw+UgjKLYa+yONMuHHh
         uVPl3w0GNRZPjft8vLS1USaQsovaFk0yS05Wy8xKByy+VaRiDFfQuRVNVAT094+wGW2h
         syQu9zkrnJ8dQHvJVceaG1uyJ2YFe8PvkAXq17KjZc4Kfr1LmRyNYWpAxY4PFGDrK9y/
         qNWgj/tOjJLp5nQlKbqelsrkT9trfamGBPEqvA0W0fqrcBGf3+/Fvhgei/rzfSs7vy+i
         Bs/jlErmrxq7mlyPXeRfglgb0p1vyoKgZYKtUFTZ3wniBh6PqPSQNcJythDUl6NslJdR
         9oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707123086; x=1707727886;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YqRUU6pWIpicQvpTSqgYz/3iwXAOTziCuAH0zZKlZuU=;
        b=tPcMywG6Q3KRuJx6Y8Grwtp8bbLH6tTuDLnzvWTZB7UAHAXXyvBHikrCDh4lI6ArbP
         zRvnKeEqyl55fdGhK4VjD+DXalJkdFK78j+BkCIzJ/awYH7l/6imr+xPN69Tlk4FvRC6
         w7d/G9zWi0eVtgx6pWu8RWV80eekelon/oYhjOLhcDOSBEJ414Jg7n4DStJChM1gaQZ/
         EQZ4zWkBSQu195rMIwXEy7nXkGmIdS2M+2muPPmq5NiXttDLuuMTF10Ax2T6zzHdbQIM
         KN1OzkaqHW6jgIzE6jgFIk7Iq8N2XR0l8TS1RG9TAtVtwK42YOwL1+i/fY8WCZ6MHVZq
         28Dg==
X-Gm-Message-State: AOJu0YyJJ3Dv1DtyKuecWY2B9Jy1TxDzNMNs28RNyH2HWrGbelFKHHXy
	+B/UHx+JGq9Lg2TGri7p7mJ69M8Np4FEsiZayKF1+3LZdbMMLFvl4s1BSSTa1o0=
X-Google-Smtp-Source: AGHT+IGes4t1JkIu1VjmVMGmYt0lNGywtvIAz4vn44iWF6QB4EmS9e2shjkPdoJizQQq1pQSNBHcaQ==
X-Received: by 2002:a5d:42cd:0:b0:33b:2add:3d5b with SMTP id t13-20020a5d42cd000000b0033b2add3d5bmr4679242wrr.50.1707123085905;
        Mon, 05 Feb 2024 00:51:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWVXuR6moWq15LGTxt4LAQhP6H7/2PJwTbJIATCn79HM9UvlaloY2oHS27ecqZeLBE0kmGLiibvWh9L2CXqjOnUL8XDmyWXR1gu01FRpuTR/01uzH67uiR7TaY133wmqWw+Rs+EMfhhMXfYIyxbnOHS2MWNOqHc5eeStPSnrXtAOdWERTcAXfd9XXdzJ/nMF+QAEDzgpusPL8nVOCCBAUlm8uwCwFIeTSWbZ/gDt4u7YUU8dTQL+1DxDRX+GxIP2gNOch+bHqYtFOyBhiHNWNSNh1/SgEq84Q0HRd/PGUAz078V3wmof7E7V7VVAhPmuskusA==
Received: from ?IPV6:2a01:e0a:982:cbb0:bbd9:ac3e:db1d:9662? ([2a01:e0a:982:cbb0:bbd9:ac3e:db1d:9662])
        by smtp.gmail.com with ESMTPSA id j4-20020a5d6044000000b0033b3b878bf6sm2383091wrt.89.2024.02.05.00.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 00:51:25 -0800 (PST)
Message-ID: <8f66f2b7-1a65-44ae-a7a6-20b0cfe22be2@linaro.org>
Date: Mon, 5 Feb 2024 09:51:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] ASoC: fix SND_SOC_WCD939X dependencies
Content-Language: en-US, fr
To: Arnd Bergmann <arnd@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Weidong Wang <wangweidong.a@awinic.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240204212207.3158914-1-arnd@kernel.org>
 <20240204212207.3158914-2-arnd@kernel.org>
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
In-Reply-To: <20240204212207.3158914-2-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/02/2024 22:22, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> SND_SOC_WCD939X has an optional dependency on TYPEC, so the newly added
> SND_SOC_WCD939X_SDW option that selects it needs the same dependency, otherwise
> it can fail randconfig builds like:
> 
> WARNING: unmet direct dependencies detected for SND_SOC_WCD939X
>    Depends on [m]: SOUND [=y] && SND [=y] && SND_SOC [=y] && SND_SOC_WCD939X_SDW [=y] && (SOUNDWIRE [=y] || !SOUNDWIRE [=y]) && (TYPEC [=m]
>   || !TYPEC [=m])
>    Selected by [y]:
>    - SND_SOC_WCD939X_SDW [=y] && SOUND [=y] && SND [=y] && SND_SOC [=y] && SOUNDWIRE [=y]
> arm-linux-gnueabi-ld: sound/soc/codecs/wcd939x.o: in function `wcd939x_soc_codec_remove':
> wcd939x.c:(.text+0x1950): undefined reference to `wcd_clsh_ctrl_free'
> arm-linux-gnueabi-ld: sound/soc/codecs/wcd939x.o: in function `wcd939x_codec_ear_dac_event':
> wcd939x.c:(.text+0x35d8): undefined reference to `wcd_clsh_ctrl_set_state'
> arm-linux-gnueabi-ld: sound/soc/codecs/wcd939x.o: in function `wcd939x_codec_enable_hphr_pa':
> wcd939x.c:(.text+0x39b0): undefined reference to `wcd_clsh_ctrl_set_state'
> arm-linux-gnueabi-ld: wcd939x.c:(.text+0x39dc): undefined reference to `wcd_clsh_set_hph_mode'
> arm-linux-gnueabi-ld: wcd939x.c:(.text+0x3bc0): undefined reference to `wcd_clsh_ctrl_set_state'
> 
> Fixes: be2af391cea0 ("ASoC: codecs: Add WCD939x Soundwire devices driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   sound/soc/codecs/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 75d88bd1dc6f..58ee431edfd8 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -2084,6 +2084,7 @@ config SND_SOC_WCD939X
>   
>   config SND_SOC_WCD939X_SDW
>   	tristate "WCD9390/WCD9395 Codec - SDW"
> +	depends on TYPEC || !TYPEC
>   	select SND_SOC_WCD939X
>   	select SND_SOC_WCD_MBHC
>   	select REGMAP_IRQ

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

