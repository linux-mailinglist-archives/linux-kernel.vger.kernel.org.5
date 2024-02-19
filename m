Return-Path: <linux-kernel+bounces-70944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF055859E7E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA41F21890
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB42D21357;
	Mon, 19 Feb 2024 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HeibHX57"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E10E2232E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 08:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708331862; cv=none; b=YMUB8ND+/VH0jcsYPfzuPwA/KhFHwHIt270HYYVfl82OxsgFbbhMG/1XmL4lzjJKQiQDaP2q7iAUOH/v7NZfocLUo1tKcKSxe6dlTynQMVO3mkdmo6E6jf81FVuAnDmdpQj9D2nuf7cOzv0gRebY09er+5fOQPyVHJ0YVjj4Jmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708331862; c=relaxed/simple;
	bh=6wXm00HoFVeR77N0uDWT2cDT8fh9HFeGMbTDCNTzj2w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gsswj+azK7la5kkRyNlZDVQlQ5CV8bWDl343CHJUTsIsPaXAo1E31fS9Ho40MTiJXfKtVhPlfmYzYl5J/04ApviwyQE6vGZ5fanmdBebK0LOJ2eRSJmg9zy+4QaSMrvaOF5POZl1BqlYjIRpiLPzVsdcEZrq4NGLxDft65lWbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HeibHX57; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5101cd91017so5214509e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 00:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708331858; x=1708936658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ot3mhi97s6/9aZCMB2riyQgz1wZSt/7mTvF+Ozc5gEg=;
        b=HeibHX57ZbzdWfO8x/+RholsIKv4DerpwdB2y52hOZuqCMJBOY/xgIVWFDyE7K3yEQ
         eupDC7OQkMUOyzzZHPh8e5bIhnKUB7UrFT0xuKB3XjDl2X2C9oAGxkp7yDXii75/aG0z
         LMD0qmj2A7bV5FJ8q13TjoY1fcoV0CWkzTFNPcxkZ6wJZamYEQSJGyKgHQRXLpWRLHZo
         uaghqT4RP6nevua2ntMkjl7claETu8WQ7EtB3eF7hPyCrURFp9Q0yR5PlZUTvv3gPWSQ
         UcBUKiBVLW/GAUdXeSjQSk0ChehDiBURlBzNt6GDG10C9O7HLCZVpaKITv7g9CcOoMoa
         wcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708331858; x=1708936658;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ot3mhi97s6/9aZCMB2riyQgz1wZSt/7mTvF+Ozc5gEg=;
        b=liaLh6SogUuo+8THUY8Pc6PtJyc6wxS0bvKrFTehwXvBAkmJLiX8s5l9rSKDCM4VRw
         aHGRjDO7WMGst72oUPpp3D5TQIIDOHvVC6iu+zGhx/wzkI4l2b1g0C0REhdnqQ8Zvn9/
         mCpwAqq/Gz2lHFA23bKNRJy8dOSsO2BRi73/8yDfjlte0cSFMTcsB1iaCX4sWquF8WAV
         fegdXYRE4NRbvWObrEbcyof073233gApByuEmUWSM7+Clh/9dflp0zaL6pXCY8k1h37A
         VAy12aiD7QM3b8jBTmwg0JUifayWNZzTrijb57HqZO9+ibSHDtrJKaPvAftgU4lxuoRe
         VJXw==
X-Forwarded-Encrypted: i=1; AJvYcCURkkxx+VRKfVgU4udl1+HUyV6SAyDo886He6hvBrTHuthqkvgFAj+xbp98jxYmMWEesxL1mMCRCJeOYcFfZ4wp1997YkLCJM8W+5ec
X-Gm-Message-State: AOJu0Yx0fG8UKxru8ugDa7dzp6IE90r4ui84zIc4IUMgPbkfDhqkUONL
	FvT/Hi36AgJ3qegB2En6L7a/LcV0a0i1FY+IQDyBVxIDKHEvBc2ffXxvfFQfB2w=
X-Google-Smtp-Source: AGHT+IGB2EfGRcnx45+mLUJnUMRu9qt4x4481hQ1u7jhQm5TGGPwPbM1n8o7wqWntRV0wH74bmP/xg==
X-Received: by 2002:a19:f815:0:b0:512:aae7:d79a with SMTP id a21-20020a19f815000000b00512aae7d79amr2161561lff.27.1708331858584;
        Mon, 19 Feb 2024 00:37:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f? ([2a01:e0a:982:cbb0:9470:c6e0:c87a:fa9f])
        by smtp.gmail.com with ESMTPSA id g19-20020a7bc4d3000000b004126101915esm4868608wmk.4.2024.02.19.00.37.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 00:37:38 -0800 (PST)
Message-ID: <f1dd75d3-d86b-447a-8a76-73da7d14c936@linaro.org>
Date: Mon, 19 Feb 2024 09:37:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/3] ARM: dts: amlogic: Three small binding check error
 fixes
Content-Language: en-US, fr
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
References: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
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
In-Reply-To: <20240218111959.1811676-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/02/2024 12:19, Martin Blumenstingl wrote:
> This series contains three small binding check fixes.
> Nothing functional was broken before, so no need to backpport any of
> these to -stable.
> 
> 
> Martin Blumenstingl (3):
>    ARM: dts: meson: fix bus node names
>    ARM: dts: meson8: fix &hwrng node compatible string
>    ARM: dts: meson8b: fix &hwrng node compatible string
> 
>   arch/arm/boot/dts/amlogic/meson.dtsi   | 6 +++---
>   arch/arm/boot/dts/amlogic/meson8.dtsi  | 1 -
>   arch/arm/boot/dts/amlogic/meson8b.dtsi | 1 -
>   3 files changed, 3 insertions(+), 5 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

