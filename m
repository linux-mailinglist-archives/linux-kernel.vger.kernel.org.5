Return-Path: <linux-kernel+bounces-138863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342F889FB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 541921C22814
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1271116E86E;
	Wed, 10 Apr 2024 15:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gPxlIl0x"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E2F15D5C0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 15:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712762420; cv=none; b=hgk7Rypkk9iDyK8dMFpHj9hr/9dXpDz0GqdhN3d6ZG0sXkq5AAsiEDf/3XtL1i1OfXMsuOSMXdzD5123aIlRYNrpl3Zv8cer/1nv77msjkU5vnA/s1IW0uXWjtLjadntpT6SHEbgZBdt+DyEd4h/eV59xXAl2pwjbhqMALQ2AAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712762420; c=relaxed/simple;
	bh=ds4/JiXykXvmD/R10QHfU0kvOI9oY+KEWtKpZvNpOxs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ljuEs5AIFx45+1E6u5Dvcs8XQq7RHtYzhI/sQscB/BO7v1lHcokdNji95pRcihyTpz1J8p+suuexMrhcudbRkmfqGkKy0PmrqeYLzbfGg3bgh8f3IBxGPic4Vg1IR+1N6E1/EuHLfldpSfwQZ06Dop8UqkGJx1v1aN+OP5Anb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gPxlIl0x; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3465921600dso925047f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712762416; x=1713367216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4R3K7LNBl3184aok8Mf+8acLiZ1zYz0SQ3/7PRWvxQs=;
        b=gPxlIl0xiP5Od2+HT6kmbUZAPbRYhLzq/bpByio7GM/NRsMLNv002dqpgf2QnE/vt0
         IxAar7v/Cabg9kFp+XqJrC4YBRbi0SXOWNLsnXrPMbeexNWaHUpgYkXOgfbMziytRiZp
         2mkGShlec4eWKgeI0nWuky1pAcv9V+v0zXKKGWOwF81d9CQQSfsc4AGqel9QfYAAFi7Z
         iXjAf/Q8KEQaMql1zFVloZWQ/gvAmNvnRuBUSJaTbVN9ZdDjQNRpcF1QsXLAOY8NeV0q
         trD+WMRI9s8NBqA3jiv57ICJ72PXtLNx/OUtsiAyf5xaAmgM7zTxTvNHiegE5bIPhj6I
         KrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712762416; x=1713367216;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4R3K7LNBl3184aok8Mf+8acLiZ1zYz0SQ3/7PRWvxQs=;
        b=IWCGyU/t7+4U8F6pIuztAX2PxYSo1wBHDWdctyZSaptO+o50+IHTmOy9o9WFRFUGOa
         06Sjbb0J5XLfDRBg0GosG8Jyd0bevB1r8ZZHT1A33tEv3ymdiOKrpvyCsEFlIBElplCv
         CDZy84TxqrU6/2kbQrpHGkzWl6v51LCRmIB0BK9vNiikX/RduFR5fYYDFm011aW74TSp
         4DeDzTh08YRR/JAMeiUFi5Him0YdMlCUnpjByEUzFp5+HfulECFpJANUCfIuJDRP5lDc
         FqT4KbqCFIk6wFaIc6Ht6Qt8+MncwBTbZ2c7xxN7s72baJ6Nrml9LxNN+2wyX0F1dGlG
         25eA==
X-Forwarded-Encrypted: i=1; AJvYcCXMuyTGBPpG+/g+4Qy/DWBT2I72qlKdCJ9EuReaebCUhPGBo42lftDdHk4IeISQIHfJBPgJA63Y7bI3djDigYeeF2cPRV5O5xAN0CiS
X-Gm-Message-State: AOJu0YxbbN9I9kJA9MTJzkiUUClf+OiV9nCftDW7BGE36TWbNRwBtVVl
	MiYEQDp54IDRdizFA5yqiqkkj3FqpogsaoEQr0RYHAVK4aVJB3+LZjNlWUO+Bc8=
X-Google-Smtp-Source: AGHT+IHxgjP320DE2jUKQCRgcCpJqzP7jHw3GAQXoFs/HfmASu3+rbIL4V0ixmvpeRaEe7uw11zC2Q==
X-Received: by 2002:a05:6000:d4f:b0:33e:78ca:e039 with SMTP id du15-20020a0560000d4f00b0033e78cae039mr1744407wrb.59.1712762416285;
        Wed, 10 Apr 2024 08:20:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:760d:c2fa:a66b:fed3? ([2a01:e0a:982:cbb0:760d:c2fa:a66b:fed3])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b0034174875850sm14057849wrw.70.2024.04.10.08.20.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 08:20:15 -0700 (PDT)
Message-ID: <7c612f63-fd7d-4f5a-ace6-05b2bc29f3eb@linaro.org>
Date: Wed, 10 Apr 2024 17:20:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND] drm/armada: drop unneeded MODULE_ALIAS
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Russell King <linux@armlinux.org.uk>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240410082218.46525-1-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240410082218.46525-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/04/2024 10:22, Krzysztof Kozlowski wrote:
> The MODULE_DEVICE_TABLE already creates proper alias for platform
> driver.  Having another MODULE_ALIAS causes the alias to be duplicated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Resent third time
> https://lore.kernel.org/all/20220407202443.23000-1-krzysztof.kozlowski@linaro.org/
> 
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/gpu/drm/armada/armada_drv.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> index e51ecc4f7ef4..f48e2cf8de43 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -283,4 +283,3 @@ module_exit(armada_drm_exit);
>   MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
>   MODULE_DESCRIPTION("Armada DRM Driver");
>   MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:armada-drm");

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I think we'll need maxime or thomas ack to apply this via drm-misc-next

Neil

