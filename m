Return-Path: <linux-kernel+bounces-122612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCD088FA62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:53:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2FA1C296B5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E015A115;
	Thu, 28 Mar 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqyNBkDc"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36945C03D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 08:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711615916; cv=none; b=Y9FZtYsK8ZV3UzJHjewWg4/yhSTzXx6EdWsydwQ73+dUwBPzQs6Lm3n7WsbbPT1HkZYiq49N+TFbqjVH46MhIW1FAkkAuVriXF5GPpTRSgIsVJveJNHITioXqptDNCE0OOulYXdqW1/sfU83/iqU7DJxzrySG7JnC9o+RxhIKYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711615916; c=relaxed/simple;
	bh=lm6JU4IeaTm7jFBqmtVsXOaOAc5/BlghhXFO3XM/ozg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Ezpgc09q6L/yz2TDB3OAE3ka/an7tBIIszp7KlVlaWmUSEVTq5ueXCQhMveHzS6eyMLgOR0yRqArQRtWSGX4lInqHBvnyYNOIFNxSk8/wDLQrpz62S4VOs6jnXPv8BnuOg8mlcGIMW2vi06npoaAl2VZIIpMJxD8UcEsSZYOfLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OqyNBkDc; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-341cf77b86dso584097f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 01:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711615912; x=1712220712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Z16nDYO14OlggL2k+8tkNqpLiDh6RkJfQheHk95wXc=;
        b=OqyNBkDccrQjEQxQbkuVubWUCMeaQmNrWycyxpVFx/1+gptLpP5gMDMDOUOQQCD3fu
         bcoXVgEiSi9PRn+Ko0XcfgSianOz0egjVIILGeWLwKtEITgJOTuQktXLz2Z18u5oJtq9
         //WVxL8ezFWukEKH3pcZ9RaKuRIDnEYfOHJOiUAwD5p6sgotuBjWOj+GnVQs05ddbWFq
         9n7EfWCiWaG4p8HtDvxisU5jdQyNjDcJTPWa9Vmzxe+ism87vg+9Ci2WuVSwcbSJl/zd
         Nr/jMREWn/Iq14YZZXoDhkn0LHDrBHcjrHxvGbvT1+/Gu8Nns9dMBMclmhiiWFrLFeWN
         iVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711615912; x=1712220712;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8Z16nDYO14OlggL2k+8tkNqpLiDh6RkJfQheHk95wXc=;
        b=wQMsA2AsJKlwVjT3OB4iwCcEVLaK38sBl275no/XgHigYLrwQ1Rmk3bE8VwjR54X4r
         N0cH/3ueNCx8qSt/T9dqCiFhR5QQUAr1DdCU01ECt0BLg3h1p3xC6+qHAZs5HYAZbSVg
         /9as4nJj8kJosi6DejxXdrIkXtakkUP2d+yeaMnRJSCGfHjmB6u42QgANkBFMQp97WaI
         7n8vXItwyJrqL37J8vcPv8Nddq3+/KTolucPw2YnQKlO65hV+tF46F8/gMqbd0zlh/NV
         36Szh3tHIp3DA6sEKctaevX2Mvb/XCX9fA1MzFzP0dtoBVoe88rRbjRASPeZtdOVqVQA
         2obQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3dORNS4QB+jTH+dSjcGoewWvgYyzlHa1KQbRmf9KXLCqog0s75V+yHu4B9l2emE9ifE71MVIIwQSfZESW8oEe7N3d7Wq+xSuTeMXU
X-Gm-Message-State: AOJu0Yzbd8hc60hovYbSXMIZIdArNt6VEcg3pGL40GQaq/dRvRnrHBYy
	lMLQ4PLPP4Jf92DmWxhNsqbTYrCTxC0W40i8Qd7qilG/GJcvTLzNPd69fRUgfjk=
X-Google-Smtp-Source: AGHT+IHy/MxXCnVTpL7akYMlfGf/5b/GqskHacgJBue5slPJxjHyclv+1Q6ddcA0c6SLuRjScxeoew==
X-Received: by 2002:a5d:51c3:0:b0:341:bda1:f650 with SMTP id n3-20020a5d51c3000000b00341bda1f650mr1811349wrv.15.1711615911615;
        Thu, 28 Mar 2024 01:51:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6306:1c7a:72c2:892a? ([2a01:e0a:982:cbb0:6306:1c7a:72c2:892a])
        by smtp.gmail.com with ESMTPSA id a9-20020a056000050900b00341d7596ec0sm1160342wrf.15.2024.03.28.01.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 01:51:51 -0700 (PDT)
Message-ID: <9af9cfd1-38c7-4f38-a652-fd046f427f98@linaro.org>
Date: Thu, 28 Mar 2024 09:51:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND v6 3/5] spmi: pmic-arb: Make the APID init a
 version operation
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
References: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
 <20240326-spmi-multi-master-support-v6-3-1c87d8306c5b@linaro.org>
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
In-Reply-To: <20240326-spmi-multi-master-support-v6-3-1c87d8306c5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2024 17:28, Abel Vesa wrote:
> Rather than using conditionals in probe function, add the APID init
> as a version specific operation. Due to v7, which supports multiple
> buses, pass on the bus index to be used for sorting out the apid base
> and count.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/spmi/spmi-pmic-arb.c | 199 +++++++++++++++++++++++++++----------------
>   1 file changed, 124 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 9ed1180fe31f..38fed8a585fe 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -183,6 +183,7 @@ struct spmi_pmic_arb {
>    * struct pmic_arb_ver_ops - version dependent functionality.
>    *
>    * @ver_str:		version string.
> + * @init_apid:		finds the apid base and count
>    * @ppid_to_apid:	finds the apid for a given ppid.
>    * @non_data_cmd:	on v1 issues an spmi non-data command.
>    *			on v2 no HW support, returns -EOPNOTSUPP.
> @@ -202,6 +203,7 @@ struct spmi_pmic_arb {
>    */
>   struct pmic_arb_ver_ops {
>   	const char *ver_str;
> +	int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
>   	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
>   	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
>   	int (*offset)(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> @@ -942,6 +944,38 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
>   	return 0;
>   }
>   
> +static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
> +{
> +	/*
> +	 * Initialize max_apid/min_apid to the opposite bounds, during
> +	 * the irq domain translation, we are sure to update these
> +	 */
> +	pmic_arb->max_apid = 0;
> +	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
> +
> +	return 0;
> +}
> +
> +static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
> +{
> +	u32 *mapping_table;
> +
> +	if (index) {
> +		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
> +			index);
> +		return -EINVAL;
> +	}
> +
> +	mapping_table = devm_kcalloc(&pmic_arb->spmic->dev, pmic_arb->max_periphs,
> +				     sizeof(*mapping_table), GFP_KERNEL);
> +	if (!mapping_table)
> +		return -ENOMEM;
> +
> +	pmic_arb->mapping_table = mapping_table;

Can you specify in the spmi_pmic_arb->mapping_table struct documentation the mapping_table
is only used in v1 ? or even better rename it to mapping_table_v1

> +
> +	return pmic_arb_init_apid_min_max(pmic_arb);
> +}
> +
>   static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>   {
>   	u32 *mapping_table = pmic_arb->mapping_table;
> @@ -1144,6 +1178,40 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>   	return 0x1000 * pmic_arb->ee + 0x8000 * apid;
>   }
>   
> +static int pmic_arb_init_apid_v5(struct spmi_pmic_arb *pmic_arb, int index)
> +{
> +	int ret;
> +
> +	if (index) {
> +		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
> +			index);
> +		return -EINVAL;
> +	}
> +
> +	pmic_arb->base_apid = 0;
> +	pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
> +					   PMIC_ARB_FEATURES_PERIPH_MASK;
> +
> +	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
> +		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
> +			pmic_arb->base_apid + pmic_arb->apid_count);
> +		return -EINVAL;
> +	}
> +
> +	ret = pmic_arb_init_apid_min_max(pmic_arb);
> +	if (ret)
> +		return ret;
> +
> +	ret = pmic_arb_read_apid_map_v5(pmic_arb);
> +	if (ret) {
> +		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * v5 offset per ee and per apid for observer channels and per apid for
>    * read/write channels.
> @@ -1178,6 +1246,49 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>   	return offset;
>   }
>   
> +/*
> + * Only v7 supports 2 buses. Each bus will get a different apid count, read
> + * from different registers.
> + */
> +static int pmic_arb_init_apid_v7(struct spmi_pmic_arb *pmic_arb, int index)
> +{
> +	int ret;
> +
> +	if (index == 0) {
> +		pmic_arb->base_apid = 0;
> +		pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
> +						   PMIC_ARB_FEATURES_PERIPH_MASK;
> +	} else if (index == 1) {
> +		pmic_arb->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
> +						  PMIC_ARB_FEATURES_PERIPH_MASK;
> +		pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
> +						   PMIC_ARB_FEATURES_PERIPH_MASK;
> +	} else {
> +		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
> +			index);
> +		return -EINVAL;
> +	}
> +
> +	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
> +		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
> +			pmic_arb->base_apid + pmic_arb->apid_count);
> +		return -EINVAL;
> +	}
> +
> +	ret = pmic_arb_init_apid_min_max(pmic_arb);
> +	if (ret)
> +		return ret;
> +
> +	ret = pmic_arb_read_apid_map_v5(pmic_arb);
> +	if (ret) {
> +		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   /*
>    * v7 offset per ee and per apid for observer channels and per apid for
>    * read/write channels.
> @@ -1358,6 +1469,7 @@ pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
>   
>   static const struct pmic_arb_ver_ops pmic_arb_v1 = {
>   	.ver_str		= "v1",
> +	.init_apid		= pmic_arb_init_apid_v1,
>   	.ppid_to_apid		= pmic_arb_ppid_to_apid_v1,
>   	.non_data_cmd		= pmic_arb_non_data_cmd_v1,
>   	.offset			= pmic_arb_offset_v1,
> @@ -1372,6 +1484,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
>   
>   static const struct pmic_arb_ver_ops pmic_arb_v2 = {
>   	.ver_str		= "v2",
> +	.init_apid		= pmic_arb_init_apid_v1,
>   	.ppid_to_apid		= pmic_arb_ppid_to_apid_v2,
>   	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
>   	.offset			= pmic_arb_offset_v2,
> @@ -1386,6 +1499,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
>   
>   static const struct pmic_arb_ver_ops pmic_arb_v3 = {
>   	.ver_str		= "v3",
> +	.init_apid		= pmic_arb_init_apid_v1,
>   	.ppid_to_apid		= pmic_arb_ppid_to_apid_v2,
>   	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
>   	.offset			= pmic_arb_offset_v2,
> @@ -1400,6 +1514,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
>   
>   static const struct pmic_arb_ver_ops pmic_arb_v5 = {
>   	.ver_str		= "v5",
> +	.init_apid		= pmic_arb_init_apid_v5,
>   	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
>   	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
>   	.offset			= pmic_arb_offset_v5,
> @@ -1414,6 +1529,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
>   
>   static const struct pmic_arb_ver_ops pmic_arb_v7 = {
>   	.ver_str		= "v7",
> +	.init_apid		= pmic_arb_init_apid_v7,
>   	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
>   	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
>   	.offset			= pmic_arb_offset_v7,
> @@ -1439,7 +1555,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>   	struct spmi_controller *ctrl;
>   	struct resource *res;
>   	void __iomem *core;
> -	u32 *mapping_table;
>   	u32 channel, ee, hw_ver;
>   	int err;
>   
> @@ -1467,12 +1582,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>   
>   	pmic_arb->core_size = resource_size(res);
>   
> -	pmic_arb->ppid_to_apid = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PPID,
> -					      sizeof(*pmic_arb->ppid_to_apid),
> -					      GFP_KERNEL);
> -	if (!pmic_arb->ppid_to_apid)
> -		return -ENOMEM;
> -
>   	hw_ver = readl_relaxed(core + PMIC_ARB_VERSION);
>   
>   	if (hw_ver < PMIC_ARB_VERSION_V2_MIN) {
> @@ -1506,58 +1615,17 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>   			return PTR_ERR(pmic_arb->wr_base);
>   	}
>   
> -	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
> +	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
> +		 pmic_arb->ver_ops->ver_str, hw_ver);
>   
> -	if (hw_ver >= PMIC_ARB_VERSION_V7_MIN) {
> +	if (hw_ver < PMIC_ARB_VERSION_V7_MIN)
> +		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
> +	else
>   		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
> -		/* Optional property for v7: */
> -		of_property_read_u32(pdev->dev.of_node, "qcom,bus-id",
> -					&pmic_arb->bus_instance);
> -		if (pmic_arb->bus_instance > 1) {
> -			dev_err(&pdev->dev, "invalid bus instance (%u) specified\n",
> -				pmic_arb->bus_instance);
> -			return -EINVAL;
> -		}
> -
> -		if (pmic_arb->bus_instance == 0) {
> -			pmic_arb->base_apid = 0;
> -			pmic_arb->apid_count =
> -				readl_relaxed(core + PMIC_ARB_FEATURES) &
> -				PMIC_ARB_FEATURES_PERIPH_MASK;
> -		} else {
> -			pmic_arb->base_apid =
> -				readl_relaxed(core + PMIC_ARB_FEATURES) &
> -				PMIC_ARB_FEATURES_PERIPH_MASK;
> -			pmic_arb->apid_count =
> -				readl_relaxed(core + PMIC_ARB_FEATURES1) &
> -				PMIC_ARB_FEATURES_PERIPH_MASK;
> -		}
>   
> -		if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
> -			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
> -				pmic_arb->base_apid + pmic_arb->apid_count);
> -			return -EINVAL;
> -		}
> -	} else if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
> -		pmic_arb->base_apid = 0;
> -		pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES) &
> -					PMIC_ARB_FEATURES_PERIPH_MASK;
> -
> -		if (pmic_arb->apid_count > pmic_arb->max_periphs) {
> -			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
> -				pmic_arb->apid_count);
> -			return -EINVAL;
> -		}
> -	}
> -
> -	pmic_arb->apid_data = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
> -					   sizeof(*pmic_arb->apid_data),
> -					   GFP_KERNEL);
> -	if (!pmic_arb->apid_data)
> -		return -ENOMEM;
> -
> -	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
> -		 pmic_arb->ver_ops->ver_str, hw_ver);
> +	err = pmic_arb->ver_ops->init_apid(pmic_arb, 0);
> +	if (err)
> +		return err;
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
>   	pmic_arb->intr = devm_ioremap_resource(&ctrl->dev, res);
> @@ -1599,16 +1667,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>   	}
>   
>   	pmic_arb->ee = ee;
> -	mapping_table = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
> -					sizeof(*mapping_table), GFP_KERNEL);
> -	if (!mapping_table)
> -		return -ENOMEM;
> -
> -	pmic_arb->mapping_table = mapping_table;
> -	/* Initialize max_apid/min_apid to the opposite bounds, during
> -	 * the irq domain translation, we are sure to update these */
> -	pmic_arb->max_apid = 0;
> -	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
>   
>   	platform_set_drvdata(pdev, ctrl);
>   	raw_spin_lock_init(&pmic_arb->lock);
> @@ -1617,15 +1675,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>   	ctrl->read_cmd = pmic_arb_read_cmd;
>   	ctrl->write_cmd = pmic_arb_write_cmd;
>   
> -	if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
> -		err = pmic_arb_read_apid_map_v5(pmic_arb);
> -		if (err) {
> -			dev_err(&pdev->dev, "could not read APID->PPID mapping table, rc= %d\n",
> -				err);
> -			return err;
> -		}
> -	}
> -
>   	dev_dbg(&pdev->dev, "adding irq domain\n");
>   	pmic_arb->domain = irq_domain_add_tree(pdev->dev.of_node,
>   					 &pmic_arb_irq_domain_ops, pmic_arb);
> 
With that clarified:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

