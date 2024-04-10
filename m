Return-Path: <linux-kernel+bounces-138972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864CA89FCCF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9D471C22D5C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C6EC17A93A;
	Wed, 10 Apr 2024 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YnpftKAq"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B58178CC3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712766471; cv=none; b=nvpvDsqR3QQPUPBJwnavQ+n7j4qSW52YmYbu83UtJeQdmIvMFUGtmw2JeMIe6ve4+dJMoFTiorx5Sf/KToMY8OKiRYj7oIeK26DmLQRpieNfA0QCxqqb9382eki/+ycRo3rBGk1xbst0+dIWUIcBgq0I9pS3W1iJgxkSjVVi9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712766471; c=relaxed/simple;
	bh=uf+Ar+PaJVa2pvz1CR23fbwdJ8KB4f9LguC6b01qqHQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=c20zA3xt2IzR2z8kQ0H2Q7MnNxRuoup/s6179DtaEvLi9gLcfLLo51Uwiz90r3jRuj/ZftOXYFH1Pn10TlSx8aNAp/m1CgfQcywB1PC7mCnG9b5c434bXXAXx4+0V1ypm7hgCY1gCtvpINANfKPKPgvjxN7f7VBMhwFJNiIdGuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YnpftKAq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4173f9e5d73so4628945e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712766468; x=1713371268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMyz12ylWRHt7vdLgyuPPMMusedD2QbyBwikKs7clRI=;
        b=YnpftKAqugXZ9suelMGLZYuSMhDhsbv9h39xcCng8Y7UV2Dyjo5TpQAGTeDmC8PeNF
         R2mRN9f08cQYidPs1773xoaJ7JV2/9I8Tt/+x50C45UtdutP7395c0oUEkOqI/XSRFM1
         3JpFAGhTrxyINGq1CIbvWH4p6MrxeTiZxBZpCKt6rdcAzA+lCqoeFIJ1ZkNOaA4U7KxN
         Iiimr4gyqf8pUtyXze7yN+Ig5nKhbK9uPoFsNn3kdmMKqkRAgaTbGTgElDAw9HmLWXEM
         6PqgpbYABG1hjh/AZ1rZ9M+BUcqg7MYtn26zYCq4HYXpm8l7bNYSPOoe7HS0zRJ40lqb
         MqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712766468; x=1713371268;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DMyz12ylWRHt7vdLgyuPPMMusedD2QbyBwikKs7clRI=;
        b=l36gucnBuFqdScdnA0Dw+O2Yj2kFJQEswGAZNLg3uGLMgKQ+il5MRWxQ07ipSVcNLp
         p17tl9JYddqL7SnlJpITkyEPP9832yY2zUh6GQJWMOzHFgnBZ7HNx0vjhffQ01f+sEVz
         Wq8bwyJllqePu3QOrb+s5zKBvVjh2qTLNCqG0k/YF1d+Kih8S1bQciur4bbMt5StWBve
         R8RAdVSV9CAFotzmyTP/dB9ffqhsVdEakjZGiS2ClrR8CC8wXtymbMLbtW5Ggq3/rK0N
         nEOt1dfKDbRAdWkeoi39ROjj+Hq3/UpKPUc5ALcDV0J1RYGk2nYs59nonQqblAQNr82s
         xt0w==
X-Forwarded-Encrypted: i=1; AJvYcCUf969nEBBfQL8ujD8DG+5Ztn5EfkwjDU+ZGPtobo+vn4L78eWqg+IfktWzeCFOsvKI6bZ8+rhH5BdRQ3fjWLC+0wLrBEhIDy7Texxm
X-Gm-Message-State: AOJu0Yw0gCTvVjxkqvwfEJ1m1jgx9AWLDqcnhGCitAqDzLJa4rufWSKE
	aczTA1Djfb7vOPgfqBUIeXVeo1HFjtEwjJF2VSmKUwK+nAV2GdlUUJkQ/Wh6asM=
X-Google-Smtp-Source: AGHT+IGegh0vSxYW3a5j+7uZvmttsfLvI51V4yTn/JJl8jN96iBMjG/R8hWYYcYFsoELC83bVH9Phw==
X-Received: by 2002:a05:600c:4fd1:b0:416:6816:2b40 with SMTP id o17-20020a05600c4fd100b0041668162b40mr2026762wmq.28.1712766467829;
        Wed, 10 Apr 2024 09:27:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:760d:c2fa:a66b:fed3? ([2a01:e0a:982:cbb0:760d:c2fa:a66b:fed3])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c359200b0041674bf7d4csm2748727wmq.48.2024.04.10.09.27.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 09:27:47 -0700 (PDT)
Message-ID: <57735f4f-aa94-4ca7-8d5b-a95519c5ffd6@linaro.org>
Date: Wed, 10 Apr 2024 18:27:46 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/4] clk: qcom: dispcc-sm8450: fix DisplayPort clocks
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@somainline.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240408-dispcc-dp-clocks-v1-0-f9e44902c28d@linaro.org>
 <20240408-dispcc-dp-clocks-v1-1-f9e44902c28d@linaro.org>
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
In-Reply-To: <20240408-dispcc-dp-clocks-v1-1-f9e44902c28d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/04/2024 13:47, Dmitry Baryshkov wrote:
> On SM8450 DisplayPort link clocks use frequency tables inherited from
> the vendor kernel, it is not applicable in the upstream kernel. Drop
> frequency tables and use clk_byte2_ops for those clocks.
> 
> Fixes: 16fb89f92ec4 ("clk: qcom: Add support for Display Clock Controller on SM8450")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/clk/qcom/dispcc-sm8450.c | 20 ++++----------------
>   1 file changed, 4 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/clk/qcom/dispcc-sm8450.c b/drivers/clk/qcom/dispcc-sm8450.c
> index 92e9c4e7b13d..49bb4f58c391 100644
> --- a/drivers/clk/qcom/dispcc-sm8450.c
> +++ b/drivers/clk/qcom/dispcc-sm8450.c
> @@ -309,26 +309,17 @@ static struct clk_rcg2 disp_cc_mdss_dptx0_aux_clk_src = {
>   	},
>   };
>   
> -static const struct freq_tbl ftbl_disp_cc_mdss_dptx0_link_clk_src[] = {
> -	F(162000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
> -	F(270000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
> -	F(540000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
> -	F(810000, P_DP0_PHY_PLL_LINK_CLK, 1, 0, 0),
> -	{ }
> -};
> -
>   static struct clk_rcg2 disp_cc_mdss_dptx0_link_clk_src = {
>   	.cmd_rcgr = 0x819c,
>   	.mnd_width = 0,
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_3,
> -	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
>   	.clkr.hw.init = &(struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx0_link_clk_src",
>   		.parent_data = disp_cc_parent_data_3,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
>   		.flags = CLK_SET_RATE_PARENT,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_byte2_ops,
>   	},
>   };
>   
> @@ -382,13 +373,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx1_link_clk_src = {
>   	.mnd_width = 0,
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_3,
> -	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
>   	.clkr.hw.init = &(struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx1_link_clk_src",
>   		.parent_data = disp_cc_parent_data_3,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
>   		.flags = CLK_SET_RATE_PARENT,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_byte2_ops,
>   	},
>   };
>   
> @@ -442,13 +432,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx2_link_clk_src = {
>   	.mnd_width = 0,
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_3,
> -	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
>   	.clkr.hw.init = &(struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx2_link_clk_src",
>   		.parent_data = disp_cc_parent_data_3,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
>   		.flags = CLK_SET_RATE_PARENT,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_byte2_ops,
>   	},
>   };
>   
> @@ -502,13 +491,12 @@ static struct clk_rcg2 disp_cc_mdss_dptx3_link_clk_src = {
>   	.mnd_width = 0,
>   	.hid_width = 5,
>   	.parent_map = disp_cc_parent_map_3,
> -	.freq_tbl = ftbl_disp_cc_mdss_dptx0_link_clk_src,
>   	.clkr.hw.init = &(struct clk_init_data) {
>   		.name = "disp_cc_mdss_dptx3_link_clk_src",
>   		.parent_data = disp_cc_parent_data_3,
>   		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
>   		.flags = CLK_SET_RATE_PARENT,
> -		.ops = &clk_rcg2_ops,
> +		.ops = &clk_byte2_ops,
>   	},
>   };
>   
> 


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

I can't test, but I assume you tested on your HDK8450

Thanks,
Neil

