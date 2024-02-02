Return-Path: <linux-kernel+bounces-49447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFF2846A6C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05A41C25831
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDE7182CA;
	Fri,  2 Feb 2024 08:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EWH3J6gR"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18BC1802E
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706861512; cv=none; b=njEvbp60eUIz7Krtt6wP2mYjxcmcdzLlHK22oh5+hZdvtITNZzKIkMXo+llWf4gb45/5S+sRfbInGKmUxF2M1QEhEr06DuaRv2JxmbCyD6CWqJUU8ZML+04XIAxADHYMkgjMVkGFxuUPHYKNw7J3fXFZlASYSvterJonntwykrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706861512; c=relaxed/simple;
	bh=bTtGqCgt8+lUk9uK976uGz7vMakgO575FyOGcuvJdr8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sf2bAqSsJnB3ZmSlaNnpQXjxWfr8VhIr9x1d8DjW4Zt+WWaBJRmxWnoYg9UmtyWdyAsxgKI3TB51A42X0X+0g4Uie8tUGxkxPkXVBcbdv8hGfRmBQfvYbjM6PdGaWUYHUMzqn0dByZqxdSGqAKJVoF+GnFTEiypT9i4t4qbZCMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EWH3J6gR; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-511206d1c89so2385717e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 00:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706861509; x=1707466309; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A+phSLkXQoy73qpLUNAhiP2lrCdlciG3yr5Wt06yo40=;
        b=EWH3J6gRwn6yKZMdRkqaTMfqRe1ttj/J40J2sCNUueMRjr0prC0g6/IzFfv1LwqqsG
         QtNAvueYYavk/N5+M7tBEx8LTF7XgEMp6258k+3OmJjUkOFE+ZaDLlcdOO6RcATbC03m
         +xp9O+i36hmaDZRmsfklsHQV23DYbg9Fj9tQrNhIlqoX2UUDoUZj1Cvxh06p0/Ffqqj2
         dOhKwEdmLo7sKqlCNuYiXMqtdWC5Fq9cRxpLF1CeZisaaZHeL1kx3O0gahZfh+/twumO
         Ruh5Gbl+LkqCXIUaSP2ewvFHFBgfTO8twPiRs1aYPyvCCyQQhHt3FQRTk2PQB2x3ZrmG
         G7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706861509; x=1707466309;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A+phSLkXQoy73qpLUNAhiP2lrCdlciG3yr5Wt06yo40=;
        b=p4ajA3R4I6cEwQZj2gMRIAJvK4iIt0r3lMxmLJguacnZqg6UmqC28xVbYoCyNeQbWl
         iYv2RnyOaJNPVQrAAJBzWnq3tubh3JfBFehY4brOA8S1LjMXvKciQE6yC3htJU9WCTTh
         9JY2Y9aPIl2snfEcBbC1qGBf0tjzrTtiECMb233lnBE/VQglXxscztYxad3kL6wkMgM6
         1Do+pT3UF7ruOa5f17718IrpVsujppg+B3NNHKaInaB4payikoMS8nNzHgxvMLSjM9Al
         QcvEFoUY9fvqgHmGmb7c+03NoeXPoK9EhdZEOcb+9y8xu72MKq7PtsouvM5xFXRRvRRV
         DTJA==
X-Gm-Message-State: AOJu0Yyp+lQQEfxNGLl6MFB1DdZnljJtO3cuNaA6W0fL5clnQdEw2n21
	lHWY4R69gfSQMEo8tk3e7Kx/xsM4tUL/Z+z/vS/i0Kok2wCzg5t4jfBF+4bphlo=
X-Google-Smtp-Source: AGHT+IFFRlYYbYbfxCl751fzPqVcTtiNOx74uwltdXB9jT1S9GqCxRnzy4+OMEE6v3Ty+Rp7w9Oj1g==
X-Received: by 2002:ac2:442d:0:b0:511:2fd7:b0cb with SMTP id w13-20020ac2442d000000b005112fd7b0cbmr729854lfl.49.1706861508887;
        Fri, 02 Feb 2024 00:11:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUnFuUOJ29IlEpe5oQXZvV9EUSS6+0XBTclwUAKeYrVhaEa/i37TuwOG5e4hptV3jvEelVhcZDgseWrWtxH74ltZjitsaU77bkS1JUpWsb6RNvdsmo4i2BrdOJPI2u7tKtIR5Hi3oOfrZ7ThHPksAaLtvQNs7RIs2UFXKndxmP775aMOknS7k28b6Nn
Received: from ?IPV6:2a01:e0a:982:cbb0:560a:f70f:7627:2c48? ([2a01:e0a:982:cbb0:560a:f70f:7627:2c48])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c228d00b0040fb0c90da6sm6547641wmf.14.2024.02.02.00.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:11:48 -0800 (PST)
Message-ID: <d8e32f3d-1658-4dcd-a1dd-e37b664986ae@linaro.org>
Date: Fri, 2 Feb 2024 09:11:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 00/16] Add missing features to FastRPC driver
Content-Language: en-US, fr
To: Ekansh Gupta <quic_ekangupt@quicinc.com>, srinivas.kandagatla@linaro.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
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
In-Reply-To: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 02/02/2024 07:40, Ekansh Gupta wrote:
> This patch series adds the listed features that have been missing
> in upstream fastRPC driver.
> 
> - Redesign and improve remote heap management.
> - Add static PD restart support for audio and sensors PD using
>    PDR framework.
> - Add changes to support multimode invocation ioctl request. This
>    ioctl call facilitates multiple types of requests from user including
>    CRC check, performance counters, shared context bank usage, etc.
>    This series also carries patch to save and restore interrupted
>    context.
> - Add early wakeup support to allow DSP user to send early response
>    to CPU and improve fastrpc performance.
> - Add polling mode support with which driver polls on memory to avoid
>    CPU from going to low power modes.
> - Add notifications frameworks to provide users with the DSP PD status
>    notifications.
> - Add a control mechanism to allow users to clean up DSP user PD
> - Add wakelock management support
> - Add DSP signalling support
> - Add check for untrusted applications and allow trusted processed to
>    offload to system unsigned PD.

Could you precise:
- Which workload are you fixing
- Which platforms are concerned
- Which platforms were tested

So far I've been trying to run the "getserial" on SM8550-QRD and SM8650-QRD without
success, would those changes fix this ?
Is there any chance we could get an open-source minimal implementation of a fastRPC SDK using
the open-source Hexagon LLVM like we have for the AIC100 ?
It would definitely help validating the upstream fastRPC implementation.

Thanks,
Neil

> 
> Ekansh Gupta (16):
>    misc: fastrpc: Redesign remote heap management
>    misc: fastrpc: Add support for unsigned PD
>    misc: fastrpc: Add static PD restart support
>    misc: fastrpc: Add fastrpc multimode invoke request support
>    misc: fastrpc: Add CRC support for remote buffers
>    misc: fastrpc: Capture kernel and DSP performance counters
>    misc: fastrpc: Add support to save and restore interrupted
>    misc: fastrpc: Add support to allocate shared context bank
>    misc: fastrpc: Add early wakeup support for fastRPC driver
>    misc: fastrpc: Add polling mode support for fastRPC driver
>    misc: fastrpc: Add DSP PD notification support
>    misc: fastrpc: Add support for users to clean up DSP user PD
>    misc: fastrpc: Add wakelock management support
>    misc: fastrpc: Add DSP signal support
>    misc: fastrpc: Restrict untrusted apk to spawn privileged PD
>    misc: fastrpc: Add system unsigned PD support
> 
>   drivers/misc/fastrpc.c      | 1949 +++++++++++++++++++++++++++++++----
>   include/uapi/misc/fastrpc.h |  112 ++
>   2 files changed, 1844 insertions(+), 217 deletions(-)
> 


