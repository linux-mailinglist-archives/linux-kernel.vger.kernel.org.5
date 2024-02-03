Return-Path: <linux-kernel+bounces-51123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA658486D1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6892F284CDA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 14:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CA15DF0B;
	Sat,  3 Feb 2024 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW0N6jwv"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CCC5DF2D
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706971767; cv=none; b=dgpIQJpRi5KiI1U/O3n9VqakKZNdjqWkHGOFXLgi4XDT3z73LGAgghwwhIAHm/PmoT9JxXqmxHGN7GcJsi5yisA8BkucNYUI2HOKuOaK0IQALm1W99SXbrK1fpGD9yrTGuXC/sP/QNqX/AOyHGlfBnazEXcLN+PYtb9fzbh+Odk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706971767; c=relaxed/simple;
	bh=oTGrdNu/Zsgb5ggIIfn5UQgbiGCPFypv12nHJ/gcYps=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uv32hsYdLbIRezbZXx/+sAqi7SILWNEOMPg3ofcfdUTsfdz3wpniK9PaOmpBnKCaZAfQtxxkehb3RhGcGRKwSG2e0ralrkfGH6A5YOkcWBODOXTIYcDfIkpUsEH0ghZo6kRADt1QQfCHKSg108TSaQP1i93/in9i/vR6sCGW+pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HW0N6jwv; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40fd55c7f93so206125e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706971764; x=1707576564; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+qFWwBr6Hvcn11xuZYjbWXeQeB08RrBU+G+cOZ4qdqQ=;
        b=HW0N6jwvH8qJkh2GkNG1JGlmYIRFfMEgIgYN3UKtcFeVElAXLEteIL3n2iDIjsydOR
         9Zpo/rSA3vlKkjIZjWSXDwsQ4mZcv1QoyW9p79ju/9Fd8r7wx9kyVShFBqYYyWPKO44f
         A8JQuT09UXNSJ4CWpNRYBuw0hvUK8HDfE3hcAcK6NIgnAPDrFYiYzTSuzFZF12qviSBd
         LdZS/tnnqPiUkd7VPL5HcoPHUoGfTT+gEerMHluWdbY3c9yY1AQuQvTc+jnOqoMaAHFU
         vmy6JYcLWCa9DKCfsWTnIXGb63IB002Elqepjd04kcVs0BUdLeqHmOOLh6RVjS8gGO2k
         EO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706971764; x=1707576564;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+qFWwBr6Hvcn11xuZYjbWXeQeB08RrBU+G+cOZ4qdqQ=;
        b=U4Ui/R30BH9SD1OMMbz1QoxnJsFUrS/YKKR3eL2zagHYLIMIRYRXkfSqDwZrby8XLk
         JNIRbRvuSk59E+BUmgcZvOJuXVSS3mduMeuzW87aojUDDLkCBW8RACqvtHk+76C+BQZy
         jEStVP/g4U7H6DsCjqRC9Wvx5M8/DtDULLZmzC+cJKFYmocLg9PFibtyYMak8jI9bMUc
         KqzZyUjeTrKjPjggBaQ64K5FYDfjoZiwmRjyMpyC6D+gm7V7KXURt9usuQk7L5pjrsAh
         CrhV0MaXOCfPSQu3oXseQnkaVAAyco/WDsKYQbm7BLFTBTd92RaWL3kk4HcGF8lkRj8R
         ggZw==
X-Gm-Message-State: AOJu0YyiH+X4gbL6db0QZIw4yjV8p1WKLwWve+kZgu6drPLGohDLGV3N
	Dzwkstzp8XlGkQ95DQC0GDe92T3nHjcpyqjO+5xshfaWNUpLF+UBag4ISUiHuc4=
X-Google-Smtp-Source: AGHT+IHo6BBy7NFZiI4OHptx/CEW9WTWSLiSa2iHDninGnWOkDM2WUkgsSGWs3zzJp9iGEiIeUVzBA==
X-Received: by 2002:a05:600c:1910:b0:40f:b5d2:1af2 with SMTP id j16-20020a05600c191000b0040fb5d21af2mr1225981wmq.8.1706971764166;
        Sat, 03 Feb 2024 06:49:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUFq+EtJ/AX2PUD8zOpsPau+11PSHHbAhSSRTaHftqMPGWhA7X6QJx9wdQABtZ0rsj8KQRaSVEwcYHfyy82/Bk8nDGHHoSXOiHXknFn5r3x6ZqYavhp3dRBreFv6vx4HnMOoqbBNyOjzRUdnaJnno0EobkVmD7g8C0T40nEvN0ntAxNrSmETilwSfDfmV80gGsrghGP8AObT4HQ9uVq2pLh1MotJ/Axx0Jv6ohxFr6tjyrisJ35Rc9dVAT41iFKQvwX/2vNflQOzZW05Xg4a3HEKhWk69fE+hPrJ2k4/Lk2bUpjHzhbpqSk9wYGZnOE9IY5+ipq6DI=
Received: from ?IPV6:2001:67c:1810:f055:5044:617a:60fb:ed01? ([2001:67c:1810:f055:5044:617a:60fb:ed01])
        by smtp.gmail.com with ESMTPSA id o11-20020a5d58cb000000b00337d5cd0d8asm4169435wrf.90.2024.02.03.06.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 06:49:23 -0800 (PST)
Message-ID: <6e9030cc-3431-45c5-a7a8-0da02bafab09@linaro.org>
Date: Sat, 3 Feb 2024 15:49:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] interconnect: qcom: sm8650: Use correct ACV
 enable_mask
Content-Language: en-US, fr
To: Mike Tipton <quic_mdtipton@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, djakov@kernel.org
Cc: quic_rjendra@quicinc.com, quic_sibis@quicinc.com, abel.vesa@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240202014806.7876-1-quic_mdtipton@quicinc.com>
 <20240202014806.7876-2-quic_mdtipton@quicinc.com>
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
In-Reply-To: <20240202014806.7876-2-quic_mdtipton@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2024 02:48, Mike Tipton wrote:
> The ACV enable_mask is historically BIT(3), but it's BIT(0) on this
> target. Fix it.
> 
> Fixes: c062bcab5924 ("interconnect: qcom: introduce RPMh Network-On-Chip Interconnect on SM8650 SoC")
> Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
> ---
>   drivers/interconnect/qcom/sm8650.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/sm8650.c b/drivers/interconnect/qcom/sm8650.c
> index b83de54577b6..b962e6c233ef 100644
> --- a/drivers/interconnect/qcom/sm8650.c
> +++ b/drivers/interconnect/qcom/sm8650.c
> @@ -1160,7 +1160,7 @@ static struct qcom_icc_node qns_gemnoc_sf = {
>   
>   static struct qcom_icc_bcm bcm_acv = {
>   	.name = "ACV",
> -	.enable_mask = BIT(3),
> +	.enable_mask = BIT(0),
>   	.num_nodes = 1,
>   	.nodes = { &ebi },
>   };

Indeed it changed in the meantime


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

