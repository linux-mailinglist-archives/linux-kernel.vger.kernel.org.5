Return-Path: <linux-kernel+bounces-125710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 956C1892AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 12:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02E2DB219FD
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD98364AA;
	Sat, 30 Mar 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n5h/uOFr"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42592C859
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 11:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711799191; cv=none; b=S3XJO9rdW5AqdCGuW9Ke/mD7CAWM/cn4+6y5UBiPGsla/aBNAG5kDXq983zSlVPm9q7aChOdXPc8ceLU9Roc74Jku3NM7wyXLab+fv1ccoCIxluPkCxkn5IOamd9WXAIuNk5EYAFU5+dwMziA3Yvxy3+0m6lMpvhqa+iJkl0Sho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711799191; c=relaxed/simple;
	bh=nDnJp8XF/zw1aA5vl1kh4mTSuUfliiJCeQP1o73zw88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H4IDpiPijCp3w/En/jamKU/nzwKoksxrlvhHfVzMOjh4wlhFza4R0rd2ut3GuAwjpMqAXlGzyoWrSftW45mKQURkWcGEzOBNlSC8P1YlKJqRC3hjKGA/zt34pcrnJOkFhiGeMs7Sz5gNxC26C74c+3xVYwCEQ4Z35/nS6CeQ17Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n5h/uOFr; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-341730bfc46so1926793f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711799188; x=1712403988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=flb2sceZGeMo+7mqoXsVVwFaBDIsSMNyF6H27QzTvtk=;
        b=n5h/uOFrAq/kmUY4tR1ww11BeSZFHRsHihogxJZJkq8cofGPZFx+laxM165ihBKhfW
         ZlfhTYrI+KKiQIQxdx18hvpEh3HGo8BMhpFSoiSVHCFqgSVWafiBGsPLIiw1GwJ28q4V
         coATt/lGg5Y6leCvDfFRe0ruTXauTH81ZJr+5Xwv5AUrEgGCmn6EdKCQBtsifq0DMLPT
         I3cIxEofjAYnWEIBizjA3O5lfHNFg+/nJaqiPqeIwiQEd3SiiA3cWjkEi1Z6DdF0Bxud
         xkv6CKneRbaaLn6ytb7kSb738Wo7MkS7tfv+gMdgpXrBOQ3RrGXuVh5H7VQJBMtgxvHP
         FSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711799188; x=1712403988;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=flb2sceZGeMo+7mqoXsVVwFaBDIsSMNyF6H27QzTvtk=;
        b=nQ1luyl4d0NXNBmXBA5OEGqQh+9yeUkwZEDhK4S0PmYpo8inZk/yPahxZVPbY37c7v
         nkwRq36wa2WmTG7KIPpDQoe2jgd+gRu5OniUg0KuMFVbrhDOwpssiekxl5KdRFEuA4DJ
         ZNaxRdaFQd/mkrulABDRqVDWBYSl6Dm0HJ8vYCs2YUxuoaIdpJYMDjpNxSCDVntqlDTG
         1+2psyQiGsksixdsCjUwChcTS/SOouj1QGg4ccl0H+6ZkbDiklk3mINdWClnQFCT9YF5
         a4wVN0bPe/wOPNjMzz8zonIiZSGBBMsuAshHjoPK5Asowp5DYprJ4oPzyOJ1hBQsYF6/
         rTvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxxZJzYITfLA8NCdXNRGUqwQxmwp/uTKZ+Y48Q69A3iklcAhYWxCBqkQIjUDnm2W4qfGWzz55p5XXTT4drFTh2cfiMSsRwZbr6+KUv
X-Gm-Message-State: AOJu0YxZpFEw1QYxshSAxP6qbGtf7/ZXaOE8uv26AOwUOn+6MXQ6h3No
	zHvqlTRAq1jmoaHiDjWn2eeDn6hnwORCeFObIMOu4+fi81hSj0tAg+SBVPzsM/Y=
X-Google-Smtp-Source: AGHT+IE1gEdHicUgGPo2BqNk4UwXpeuxHhKW55jxUbvv1GvwuzjIBRq3/NYcBvcrjImp6KgUE/fodQ==
X-Received: by 2002:a05:6000:1743:b0:33e:4969:f05a with SMTP id m3-20020a056000174300b0033e4969f05amr2683763wrf.37.1711799188247;
        Sat, 30 Mar 2024 04:46:28 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id d8-20020adfef88000000b0033ed7181fd1sm6267909wro.62.2024.03.30.04.46.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Mar 2024 04:46:27 -0700 (PDT)
Message-ID: <d6b0f9d2-a489-4c0e-9c77-0e3eab49d3cb@linaro.org>
Date: Sat, 30 Mar 2024 12:46:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] soc: qcom: llcc: Add regmap for Broadcast_AND
 region
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240329-llcc-broadcast-and-v4-0-107c76fd8ceb@quicinc.com>
 <20240329-llcc-broadcast-and-v4-2-107c76fd8ceb@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240329-llcc-broadcast-and-v4-2-107c76fd8ceb@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 22:53, Unnathi Chalicheemala wrote:
> Define new regmap structure for Broadcast_AND region and initialize
> this regmap when HW block version is greater than 4.1, otherwise
> initialize as a NULL pointer for backwards compatibility.
> 

> +	struct regmap *regmap;
>  	u32 act_ctrl_reg;
>  	u32 act_clear_reg;
>  	u32 status_reg;
> @@ -849,7 +850,8 @@ static int llcc_update_act_ctrl(u32 sid,
>  		return ret;
>  
>  	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
> -		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
> +		regmap = drv_data->bcast_and_regmap ?: drv_data->bcast_regmap;
> +		ret = regmap_read_poll_timeout(regmap, status_reg,
>  				      slice_status, (slice_status & ACT_COMPLETE),
>  				      0, LLCC_STATUS_READ_DELAY);
>  		if (ret)
> @@ -1284,6 +1286,16 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>  
>  	drv_data->version = version;
>  
> +	/* Applicable only when drv_data->version >= 4.1 */
> +	drv_data->bcast_and_regmap = qcom_llcc_init_mmio(pdev, i + 1, "llcc_broadcast_and_base");
> +	if (IS_ERR(drv_data->bcast_and_regmap)) {

I am pretty sure this breaks all users. Can you please explain how do
you maintain ABI and that IS_ERR() is applied only for version >= 4.1?

Best regards,
Krzysztof


