Return-Path: <linux-kernel+bounces-48414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA339845BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7124728904E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E125F47C;
	Thu,  1 Feb 2024 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YshmCJ8F"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F6F626D1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706801634; cv=none; b=KeYapt2iu/CZEePT8fJSQlOB9ooBgfMyt+wsTk/ppGLTAwkPSLw44+ypGDbTTWG9bfZJhhjeYz1calbGh93e1tr2RKfBCTOkQGMjONQ9kl8cIykmpxjZu6xNKa/vjFLW4kpCVcsBG/Wiw8SEyAVlfnkhhdG013kZ/7LZdzehUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706801634; c=relaxed/simple;
	bh=eTXyDe/sCdGRFyVh+yGZjd9aOv3znhbG5Dv6Kdy5Yqc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=O4cGrEYzHJC+/7f2Md4mkwSF3cfWOEYXohJj7UNuJSZVr55rqLzwHjapDeDPAxLZOkXePgfLyibvCrejV4RBDgxxepyKPQj8jK48/8jUUKOd0nKYgLWxPP2Thhr59xyyThMqGL0QQlSWQnJWZavh+JwHD4nvVi2xaAaNeZMo4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YshmCJ8F; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so9173205e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 07:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706801622; x=1707406422; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8JvUgMZwIx8AlhnaVTXbQPpAdyh9AsLq7PFqw0M+A1Y=;
        b=YshmCJ8FYnzsGr3A8sVJWr7ikj36eDfI+pFJbyYvvDMUpz4RSAwEVA3foARl3ejwGn
         jbjLG5cjHiP0913aY7N6WnHs5P7vzJLmIC4LByKZD+LWeFFHCRabrS/S1G/Xlq5T2msA
         4goh1/HDB4/oHkJw2nMsQI8OjNWez45LvVEIxbChVmIL6K3NZ1FJHY736TWByZmHPLCW
         fatIUnsn3UWHarI+l3xQBWth/Aj7qLkjiv07dmgiVF86kdI8Rfp3kQTUAIxcqv/3WRnS
         oRVPC0Flwm8tlIESY8FSP5x5aOJ5AeEj8lv23hNVZq35iugsCheu6+/+3Uy1iyjcoaPu
         Y7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706801622; x=1707406422;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8JvUgMZwIx8AlhnaVTXbQPpAdyh9AsLq7PFqw0M+A1Y=;
        b=C+NN9Ulpuo+gqR4kDBBnMseriEn3DqEFn05ToEryRjlh4pLGnWsrT68F1hTogKRqU1
         aDAVggP4oEAYTU6MNeBkMYT5uiWJnIBXPPjf9K1cjwJ7b/pkQp8IsnTp3uvfviFsxCSx
         TXTl1AuLViavxqKeoAmxfORpVlgFg+VbnBijehYiCydus/6bL2cfjuj8gO8rEuhAvPb+
         Cl2OAh1bPilX8ZcTT7BeKOTZxnQqKgmjZexOfH214/mZ6HOtJEUYZ8XBgDeaLObx9Jon
         tZxhYzQkAA+OfcOYtC4RJREjTwsvxNa+ZUs43VadXRJwA3ctspFMjUz39ZEZFacEVup8
         I3vQ==
X-Gm-Message-State: AOJu0YyHElzLlpnCJiIlXkFddb7yfbsOBYdmOdo8OzX1J1ko7o+T+cpY
	7w+qyjAoz9CIBZkl46URbiSxzG70OKhP63xRmYQLaYSRARqXbr5AK3ukZojrrw4=
X-Google-Smtp-Source: AGHT+IHzUyIRxjBu59ajjbN7g7HX4KvseTgNopVMelHW9Es0s0xOIIlIOyXC64waCkakwdFmf0jC+w==
X-Received: by 2002:a05:600c:4687:b0:40e:b260:eaad with SMTP id p7-20020a05600c468700b0040eb260eaadmr1917738wmo.28.1706801617860;
        Thu, 01 Feb 2024 07:33:37 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUVp5ep8WiMiLeUreqx9aOamhdD6u0e0seqSCX/0b8/XzkZuwBlNkABnrUha8Mg2kTfFrj5pHL61vaJiJR5PdnfUfH/mnA4ywjjB61Kp8EZxut9yBJcYVUONPX07RECwPoxtMKYo6v+nU9TH5oiNVMvIsuGc8O5w98jXxG45CZx06VNTm3eD8t2b+Ovj7CIIruGmaVl0vk7QsDBetJjYn7jaUQf/c0ZuIsyif6cwwX1ZHfikyBnF3fwslRrvzAcYJcE+GKIYk9+ZIgIGXdt4y5j6QGEJsh/lhi+8cfU/B6PMeU2AI8OZRIF/Li72UUjYcZDih4w4QVnaOgLT+W79jND9E11vL0uYfTBjQwYBIaOaGCkrLuT95KxwKiZhb4Sb1wVIeuRtKqys4UtRdUoKoigkdOI3n9Uzxp1BbXQmP7ek/2wWMhNC+LuSENuOjgA18iYfhG7zzfzmP7ZMnJULdsZAw==
Received: from ?IPV6:2a01:e0a:982:cbb0:59a1:12a0:fa7a:30f8? ([2a01:e0a:982:cbb0:59a1:12a0:fa7a:30f8])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b0040e89ade84bsm4833613wms.4.2024.02.01.07.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 07:33:37 -0800 (PST)
Message-ID: <7bcfa06b-f426-4575-9359-e97e4af52465@linaro.org>
Date: Thu, 1 Feb 2024 16:33:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] arch: arm64: dts: meson: a1: add assigned-clocks for
 usb node
To: Alexey Romanov <avromanov@salutedevices.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com
Cc: linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@salutedevices.com, Dmitry Rokosov <ddrokosov@salutedevices.com>
References: <20240124130623.3471236-1-avromanov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20240124130623.3471236-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24/01/2024 14:06, Alexey Romanov wrote:
> To ensure proper functionality of USB, it is necessary to use
> the rate of 64000000 for CLKID_USB_BUS. For instance, adb may
> not function correctly without this setting. This information
> has been derived from the vendor SDK.
> 
> Signed-off-by: Alexey Romanov <avromanov@salutedevices.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> index cf150f568335..b9fd69112535 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-a1.dtsi
> @@ -668,6 +668,8 @@ usb: usb@fe004400 {
>   				 <&clkc_periphs CLKID_USB_BUS>,
>   				 <&clkc_periphs CLKID_USB_CTRL_IN>;
>   			clock-names = "usb_ctrl", "usb_bus", "xtal_usb_ctrl";
> +			assigned-clocks = <&clkc_periphs CLKID_USB_BUS>;
> +			assigned-clock-rates = <64000000>;
>   			resets = <&reset RESET_USBCTRL>;
>   			reset-name = "usb_ctrl";
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

