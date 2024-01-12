Return-Path: <linux-kernel+bounces-24517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055D682BDB2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900562814D1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB9C57328;
	Fri, 12 Jan 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYKIC9a5"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC2F5D8F5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e67e90d4cso1824935e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705052880; x=1705657680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovZ/Rsc76gCmScDPQUgFFZxG8LWAV54uOr42sgWehgw=;
        b=QYKIC9a5X4D3+fIlBeR9MdedZSQQXUli1B6Mt7PNtGNp0IpXqIaDzEECcRt0osR7xj
         Yik5OtvuOVUvMy0m7g3c6U4Y56mKCWE675evOpQ18NzuWUBLK5LwLxqJvA/LoritN8t/
         7Uzt5dNrQb7ZmNXp8m1BCAaDK4dfrvgLazWlwR+OU68Z1CBJnkBrJsPMWc62pqkEmBLV
         U1I8wmwCE5rmNQX5QTGIwgq0doIfWROWiTsaXnMRj+ST1QNpqRlgnyKmR8MQzBt5FpXC
         QFhF1owHWgp5FaQ5EXGLTi6g/hAAvUKAdGrKBpJJ7aBECwz9FjyuznJO+XolaOfGXNtu
         dSfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705052880; x=1705657680;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ovZ/Rsc76gCmScDPQUgFFZxG8LWAV54uOr42sgWehgw=;
        b=fUd83IIZktNt10l/e3dDkiAT/jogtfN8RWQSahzfD/FDCwFf+r31qzPYe6ChqoyfxT
         TL3u2SLXGfRc29WFdP9ooJ5B0pSh4yd+XDJj3pDfScU2/fqBLhVA/1NQ6XM0XWj02Dke
         15AoOP9a5dOuyVrWrOtcDhodAAn5EH7xaxPnal3y6WWs7vsL4XUB1GS0bkqQe4OJPDj4
         5If6Lf8Txky+bIkv5kFTiYulpQLF+ivPppNQcjbldoDM9Zb3PPESdzwMdC6WU8fHU4ky
         baQ2p7/QCCHAT1JLruYXEunTqj0kH/BvHfVMywu2T8Jk8D+YkWEVerJdYMbZBo8KlbV3
         Ueeg==
X-Gm-Message-State: AOJu0YygNQJvc9L0eLZB4Wq16EIrxHp/tfiHLWZfaKorOAozB4vQqcpK
	/vk6uw9PjEAK0SbrFPvvFFMvQiFpvvcOQg==
X-Google-Smtp-Source: AGHT+IFCVQiCGA8CwwGN9Z4mOg5MdzbzmpZUSAPck2ahtMQxmi5wqVGJ970b76RdmjniT6cRu5oLeg==
X-Received: by 2002:a05:600c:b92:b0:40e:4838:f374 with SMTP id fl18-20020a05600c0b9200b0040e4838f374mr391476wmb.78.1705052879754;
        Fri, 12 Jan 2024 01:47:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:59d5:231:f1ee:77f? ([2a01:e0a:982:cbb0:59d5:231:f1ee:77f])
        by smtp.gmail.com with ESMTPSA id v23-20020a5d5917000000b00337876596d1sm3373237wrd.111.2024.01.12.01.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 01:47:59 -0800 (PST)
Message-ID: <a5c22fd2-8967-47ad-b936-4d1fdc4ab64d@linaro.org>
Date: Fri, 12 Jan 2024 10:47:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: Ignore notifications
 before initialization
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Xilin Wu <wuxilin123@gmail.com>
References: <20240103-topic-battmgr2-v2-1-c07b9206a2a5@linaro.org>
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
In-Reply-To: <20240103-topic-battmgr2-v2-1-c07b9206a2a5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03/01/2024 13:36, Konrad Dybcio wrote:
> Commit b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power
> supplies after PDR is up") moved the devm_power_supply_register() calls
> so that the power supply devices are not registered before we go through
> the entire initialization sequence (power up the ADSP remote processor,
> wait for it to come online, coordinate with userspace..).
> 
> Some firmware versions (e.g. on SM8550) seem to leave battmgr at least
> partly initialized when exiting the bootloader and loading Linux. Check
> if the power supply devices are registered before consuming the battmgr
> notifications.
> 
> Fixes: b43f7ddc2b7a ("power: supply: qcom_battmgr: Register the power supplies after PDR is up")
> Reported-by: Xilin Wu <wuxilin123@gmail.com>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Changes in v2:
> - Fix the commit title
> - Link to v1: https://lore.kernel.org/linux-arm-msm/d9cf7d9d-60d9-4637-97bf-c9840452899e@linaro.org/T/#t
> ---
>   drivers/power/supply/qcom_battmgr.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index a12e2a66d516..7d85292eb839 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -1271,6 +1271,10 @@ static void qcom_battmgr_callback(const void *data, size_t len, void *priv)
>   	struct qcom_battmgr *battmgr = priv;
>   	unsigned int opcode = le32_to_cpu(hdr->opcode);
>   
> +	/* Ignore the pings that come before Linux cleanly initializes the battmgr stack */
> +	if (!battmgr->bat_psy)
> +		return;
> +
>   	if (opcode == BATTMGR_NOTIFICATION)
>   		qcom_battmgr_notification(battmgr, data, len);
>   	else if (battmgr->variant == QCOM_BATTMGR_SC8280XP)
> 
> ---
> base-commit: 0fef202ac2f8e6d9ad21aead648278f1226b9053
> change-id: 20240103-topic-battmgr2-15c17fac6d35
> 
> Best regards,

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

