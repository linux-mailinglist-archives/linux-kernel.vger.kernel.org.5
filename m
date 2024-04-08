Return-Path: <linux-kernel+bounces-135423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0334889C1B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F4271F215F8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5E980630;
	Mon,  8 Apr 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3LUlY5K"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87262148
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 13:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712582380; cv=none; b=DdBTEZThhzxSqAGdPIozHAC31Wn4IfqVFPQ22uKB9k7mlXCHmpDmF8YhKtoePNGySwWaIRc/D7Q7AA8cBukZl2BuJKvs7XZXCz/KjsYhcLyJw3f2UWNCiD+Koxx7d0SMrdIdnV9QcLkU8QvgV9AwqzfOJR8TJifClg4RY0Z6jWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712582380; c=relaxed/simple;
	bh=+lKuPWmp60F04vkbZ6q9IeaerTNFPbtgDA4fEI5DRgw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ISIxs2zr2h0DeluscHv9m/f732cTf4wiv2kqrHw7W4+p+JDtdMOlXnZutlS6M+PHGr36OTetIuy6Os8yLFi8p10neV8qZdJIL+x91oMxX2MgfUZAZir/jxLo+S18lh6PHJyGW8pEFUXEx6TrNWzhL89Uiq4jqY1S4gpM/tMM2W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X3LUlY5K; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343d6b55c42so2889777f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712582377; x=1713187177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XYIK4LJue/cF21wmqnutz+6NKwjmC1hO8sQh8o/YKFM=;
        b=X3LUlY5KbNtjdKtMUv+zttMd63ylQhEx4LmpflM4FNLhsG6JGD0FPLPaVKupf00Ez6
         WNx3goVREvZWieQbWZwk7F8LuFLxVBcbp/6o1Cd2K4nqE1OGmPJCmaWsovklw9oViVel
         aIPGYHiT0w4vpS/jIr8U/JyuK7YT+NOc1hgKlFEf9V0filCosU76WA/hYiYCWUxMc7yO
         RrYIIcoGAkfXIlWTWSgS7AP7XcO7vEZFUQMgegRKQ2Z9X4arkHHeoy5a8VQh4Nu6k6W7
         ysJCWqbPZGJeIfTaZp1WYuE1ZE9Xo4VTbjo+C31wpnJq7630rJiyTOxMDUnmfN582s6e
         0naA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712582377; x=1713187177;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XYIK4LJue/cF21wmqnutz+6NKwjmC1hO8sQh8o/YKFM=;
        b=spTXOMVV8H3ZaIwDIP7JNmIW30lWVUysvXskhN01jAJNoyeym5ewACa9J9s3Slm9xK
         BCpFFRZ9kepP518hvtauqeSr56y4OpgoIY4HCi461b9YGykKVbwx1rZadZxcVDU9GNW0
         VwGqT0i+8AfMffjDEGYbN/RqFbx5vz4wU/xq4N3TRu40nhjxuXFUIRbB6+YpuWFNHOV8
         rtQLMrB7o4ALy3z+DYiSKlI30+b04Uf8bMwljqoacQG8U10/FPHUlALMke2o3aLWdhDr
         OJFzBBnS4vSAzzX6tgLZVe96aUubZjBDUTT+8XtUIZHNbBr3PdOg/qSHjsCR8KNtxNbl
         bQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCX4r4I9jr5BTSkjA5AnwAWfrfUD0MZqOeAPRRApGGWn9w6IfzTStRNd1IYM1NbtbIXVwptMBWAHbCOR8MntmV5YRrfWa47h/BavUYqX
X-Gm-Message-State: AOJu0YwCYJa+N/lkI5SYNM9nnJcpjzDE8kncFCPcis15t5XB3aTiAU5g
	V/uAGxa5EN4YiIg2LcFogLmOZAfVanv6+6Xk7/Iv78Gmx3b1+lU9Ydvk6NR5kkc=
X-Google-Smtp-Source: AGHT+IGxYINFTE0+L2NRQ33n6tYyXcB8vn7xaSfTbYTm2nlZEEHvY1s/I1R/oG9X6vidTNN9RnNa5w==
X-Received: by 2002:a5d:588b:0:b0:345:ca71:5ddc with SMTP id n11-20020a5d588b000000b00345ca715ddcmr2286456wrf.26.1712582376912;
        Mon, 08 Apr 2024 06:19:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b0c8:7091:4315:491e? ([2a01:e0a:982:cbb0:b0c8:7091:4315:491e])
        by smtp.gmail.com with ESMTPSA id jg25-20020a05600ca01900b00416928e239csm633018wmb.35.2024.04.08.06.19.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 06:19:36 -0700 (PDT)
Message-ID: <e428656d-5e5a-46cb-9382-1d8fe7805759@linaro.org>
Date: Mon, 8 Apr 2024 15:19:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: Khadas VIM3/3L New TS050 support patch
To: Jacobe Zang <jacobe.zang@wesion.com>,
 "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
 "quic_jesszhan@quicinc.com" <quic_jesszhan@quicinc.com>,
 "sam@ravnborg.org" <sam@ravnborg.org>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>,
 "tzimmermann@suse.de" <tzimmermann@suse.de>,
 "airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Nick Xie <nick@khadas.com>
References: <d9b282de6a7846269b595d9bdae9102dTYZPR03MB7001ED3D869727EE9331530A803D2@TYZPR03MB7001.apcprd03.prod.outlook.com>
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
In-Reply-To: <d9b282de6a7846269b595d9bdae9102dTYZPR03MB7001ED3D869727EE9331530A803D2@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jacobe,

On 08/04/2024 15:16, Jacobe Zang wrote:
> Subject: [PATCH] drm/panel: add New TS050 Panel support
> 
> Hello all,
> 
> I have made some changes to the panel-khadas-ts050.c. Here is a brief overview of what has been done:
> 
> - Add dt-bindings in document.
> - Add New TS050 Panel timing sequence.
> - Make it compatible with the old TS050 panel.
> - The only difference between them is the timing, so I change the node in overlay to identify the specific panel.
> - Changes in DTS doesn't push, because preceding commits have not been merged.
> 
> The proposed changes have been successfully run on Khadas VIM3/3L.
> 
> Please find the patch attached/inline.

You should read https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
and perhaps use a tool like b4 (https://b4.docs.kernel.org/en/latest/) to send your patches in text only,
you can follow https://www.marcusfolkesson.se/blog/use-b4-for-kernel-contributions/ for example.

I'm afraid this patchset will be rejected and not reviewed if sent in this format with patches as attachments.

Thanks,
Neil

> 
> Jacobe Zang (2):
>      drm/panel: add New TS050 panel support
>      dt-bindings: panel-simple-dsi: add New Khadas TS050 panel bindings
> 
> drivers/gpu/drm/panel/panel-khadas-ts050.c | 1119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------------
> Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml | 2 ++
> 
> ---
> Best Regards
> Jacobe 臧介皓
> Amazing Khadas, Always Amazes You!


