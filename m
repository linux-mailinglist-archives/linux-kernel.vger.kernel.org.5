Return-Path: <linux-kernel+bounces-129185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A08966AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1D228A2D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C56CDD3;
	Wed,  3 Apr 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YDOWMJ4Z"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A026CDB9
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712129735; cv=none; b=rpyKNqbBf1iXSFsm9YPm6vUJxiOwNMtgrWUmzt3xvtShM6Jb9MPiCW2n5sH1T6AuRyKBWwvqHlWAXVysvpgXcNNKm8UkyvfQTnUCiAvpSxV/ybqLd4I4WGOTug3MIESkKlY0bIBfD3eIb5xTop7dRZRK2vSoE61mQP7BEviXYQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712129735; c=relaxed/simple;
	bh=x4a72RZmGjZKZGDt91umGicCKihZ9hBwXB13LJV9dto=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bJVfsPEDb1oLs/EFfALDyG6c04Y+gvLomNRirmLRS6Qhc5rMpKk9TYtjb5nlmh2/S69MFxvjTu/m/TejQ1dU73vDfL2Q8Of80yzOh+l5XkDTDiHHfXmJ31TIGn6OHTqv34X0u/F2DB5z9gKIuVCl+744w3RemVBG/A4xKst6Drw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YDOWMJ4Z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41624c40b44so1005785e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 00:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712129731; x=1712734531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zk6yUkP6W1rULwKkjyUHjYr2nx3DKKi0BVPn7REXL4U=;
        b=YDOWMJ4Z6RoW2CMue0O84bOIE+0CFMRCRNe6MJWeFNfMAYUxfihVtulPjWgrFZCQN+
         3C92qEemeOo61JMEvDrWDarJuJnF25gJ7M4MvJwgu+6uPeg0aKgo6J/j+pQsJpJ/3fgn
         kjHw9aya0sLiTR1ykP5RHmnQ7xCWudedUAuWTbuxXt7OBwQfJnRjvt2YI8s5GlNuMDEM
         rCVa12HDt4wNuNzZKWeh4pDCKJzv40paXu+soCc7xABvCXjBVINVuts+Lm/RnBvom6H8
         j/pFBH+laqAHzv+C3FLKgE1wf5iKXk74PZwj9hjjK5zNCKXYvOzYqh0Nd28CgcWltCZ0
         Ahew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712129731; x=1712734531;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zk6yUkP6W1rULwKkjyUHjYr2nx3DKKi0BVPn7REXL4U=;
        b=M/dyKtDjfJ/hzuYuov7FO3VdCTAz9uHUau1IztKinvHRIVWQK5DJxz+L3IuaXuvmNL
         5z6YxsHAoykyxbWAmli6pcHT4aWuMmTMO2cFKaM7jvqtwAoU2gR5PP6NrcrnLpLH7+KW
         6qbxni4U0P5NAIq/zCgIJDsrbY0ysbdEXsdSp7ONHqXeasiSd+ThDCiTv/K4WAVlk3O7
         inO6osWazDgIod06+MLVETjgJS6zrNt3bcEAU/AjWl+ws5wUZnEBhOWwo4TN5tJ69Mbj
         Za8pvKdbPVgrAGTBWNmuebr2CRLfSqY6iZXHdj3v/Kvg/OoUKYQEo0mvmq2NNWkt3rnh
         4xOw==
X-Forwarded-Encrypted: i=1; AJvYcCWcAE06bGl70/mM9wFdbw5jXzrEY0BO/JYLNDxzJHkUYLYHS/OIJLMoKGuO31aqH4yox63mN2viFQIfEsd9UQ6DIvv96s70iq4KYnbU
X-Gm-Message-State: AOJu0YyFegzbcp0iiTFcXDx+m/sh+cjStItdYQBhMJgo+qcnbHMhfooj
	syZ3ym82ecES8f2Y0kYEKhVRgYku4ijYMW2GYn3SaG96pjJ7bTA0fmyWNBw+kGk=
X-Google-Smtp-Source: AGHT+IHXvAP8cSVNeOWnJluu8rIyEeTJzOcu+0z22O8FJUnGbtq1azSw+RrgCvrNebeugbuXKrMsXA==
X-Received: by 2002:a05:600c:3b26:b0:414:9455:85e with SMTP id m38-20020a05600c3b2600b004149455085emr3363419wms.25.1712129731067;
        Wed, 03 Apr 2024 00:35:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:d6d:8d9b:bb47:c974? ([2a01:e0a:982:cbb0:d6d:8d9b:bb47:c974])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b00414807ef8dfsm20792252wms.5.2024.04.03.00.35.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 00:35:30 -0700 (PDT)
Message-ID: <43819edb-d65d-4639-80e9-1f3a505c016d@linaro.org>
Date: Wed, 3 Apr 2024 09:35:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v8 3/7] spmi: pmic-arb: Fix some compile warnings about
 members not being described
To: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20240402-spmi-multi-master-support-v8-0-ce6f2d14a058@linaro.org>
 <20240402-spmi-multi-master-support-v8-3-ce6f2d14a058@linaro.org>
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
In-Reply-To: <20240402-spmi-multi-master-support-v8-3-ce6f2d14a058@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2024 14:07, Abel Vesa wrote:
> Fix the following compile warnings:
> 
>   warning: Function parameter or struct member 'core' not described in 'spmi_pmic_arb'
>   warning: Function parameter or struct member 'core_size' not described in 'spmi_pmic_arb'
>   warning: Function parameter or struct member 'mapping_table_valid' not described in 'spmi_pmic_arb'
>   warning: Function parameter or struct member 'pmic_arb' not described in 'pmic_arb_read_data'
>   warning: Function parameter or struct member 'pmic_arb' not described in 'pmic_arb_write_data'
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/spmi/spmi-pmic-arb.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 9ed1180fe31f..704fd4506971 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -132,6 +132,8 @@ struct apid_data {
>    * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
>    * @intr:		address of the SPMI interrupt control registers.
>    * @cnfg:		address of the PMIC Arbiter configuration registers.
> + * @core:		core register base for v2 and above only (see above)
> + * @core_size:		core register base size
>    * @lock:		lock to synchronize accesses.
>    * @channel:		execution environment channel to use for accesses.
>    * @irq:		PMIC ARB interrupt.
> @@ -144,6 +146,7 @@ struct apid_data {
>    * @apid_count:		on v5 and v7: number of APIDs associated with the
>    *			particular SPMI bus instance
>    * @mapping_table:	in-memory copy of PPID -> APID mapping table.
> + * @mapping_table_valid:bitmap containing valid-only periphs
>    * @domain:		irq domain object for PMIC IRQ domain
>    * @spmic:		SPMI controller object
>    * @ver_ops:		version dependent operations.
> @@ -232,6 +235,7 @@ static inline void pmic_arb_set_rd_cmd(struct spmi_pmic_arb *pmic_arb,
>   
>   /**
>    * pmic_arb_read_data: reads pmic-arb's register and copy 1..4 bytes to buf
> + * @pmic_arb:	the SPMI PMIC arbiter
>    * @bc:		byte count -1. range: 0..3
>    * @reg:	register's address
>    * @buf:	output parameter, length must be bc + 1
> @@ -246,6 +250,7 @@ pmic_arb_read_data(struct spmi_pmic_arb *pmic_arb, u8 *buf, u32 reg, u8 bc)
>   
>   /**
>    * pmic_arb_write_data: write 1..4 bytes from buf to pmic-arb's register
> + * @pmic_arb:	the SPMI PMIC arbiter
>    * @bc:		byte-count -1. range: 0..3.
>    * @reg:	register's address.
>    * @buf:	buffer to write. length must be bc + 1.
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

