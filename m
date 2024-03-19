Return-Path: <linux-kernel+bounces-107420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A4687FC34
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202E41C22374
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F81B45940;
	Tue, 19 Mar 2024 10:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t0o/JiE8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3A2A8D7
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 10:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710845641; cv=none; b=QcR3Ck0egBMSDimU7mEM2ClTiUF2el10Vn1gYGunVD9gEZBT4WrCDmkiLM9IZN9yhw4dCD92H6B+MR4IyZRvM4FboxzPXeasWSYqIqwici7oV16nzb6uAqwcyrXyBCZ0aUeYhdFoeFIn3vDMO0VXQb19HQ362JInZCoPvAF/6r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710845641; c=relaxed/simple;
	bh=0CFj6WLTbL2G6/h3lbw6P9chFf3lSBNHLOBxuvKPaDc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kFNYBfWaPDHFGTPmfWKWUF1wZBq2GJ6GqJMwobnKanQLFIKtVFn26mbcCZ20wpchWGfkd9a6XMWAzNM2HqCzoYBx/KrwV5WdnqHGPVMD/yU05rMCoQczu+6iuW1R4D3d2a3O2le/layEZi8g6KI3pBX7SctxlWsfGruUXqJ1b8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t0o/JiE8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513d23be0b6so5622825e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710845638; x=1711450438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/DjqoQiR0R0fc2p4xoiFRrU53XeCEIiGCOv5JI1nK8=;
        b=t0o/JiE89P8G4I1iP8NXaiK+xuXsEhEU0qf2p71Xp2PgKSti6o8U/wWKSaLcdJ/hVN
         gDotiqjInMuVvC0XX8scXIjIKjQsovsmr+ZNqHVyQCAYwP+urs5uXuhs78/Pvm6u4Bsh
         SopTeZYDSLaahL1XxDtWyUJMVCr3WpH8KqZrIdR0tB4OUP9sMQs032+c468XxosLUh22
         XygGzl5UT0YryKfb08X3aA2GrUNmSgDKfZFBpyDsTAlRuHSqJFSYbNLj1IRJ3JnQw+GE
         XrF6aKm8LA7gH4LZjwG3oqknhuLF4FnCnq0bZsSfeP3SMV/tpwFZ2Zejq6vos/Vkfc/t
         Qmcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710845638; x=1711450438;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d/DjqoQiR0R0fc2p4xoiFRrU53XeCEIiGCOv5JI1nK8=;
        b=MdqPkTlXj4xx2oXel19o/FBELvNoJ73m6OUZ+E4iczX3PT7SlxOpqYrggkrvc5XjDn
         KH25VKW8QPAvYGOOXdxBjuBIjKWK89+/MiI5CXsQx1HIZEvvynb38LtIls/XO5U9TzlL
         uv0fB6biOM6VWb3CNqFieGC1Zc2laDZOm9WcVj9qs0gntftxCyMfL64F/p1Wcz4JjOCt
         vxuOcnViyICp9CTBoP7NsHXDFlcSJSNYZ3/VKZYlf8vplM6KcPFbIbiguWl+t4KXaQTd
         PCYYInbn1UYIDxjPu0bp88TfmEkmwcKeP2tCamFpYicTepKWa3wsfhE5GKDvmoS7eVrq
         LZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCW0aqWfMGMQJJiZOJGceLRgDq+8sh4z6ehd3RLlHfCA1/wCc14rI+HAidgzjUCfHxapCL9Wrv5FLEikQF68Mk8LefaxNP02URGeG7ZR
X-Gm-Message-State: AOJu0YziPoAMMbCcrRpJm2a9ZICjoNQKwgn8HRKkBsHfXxzs1syvzQVd
	8BOfhSUNfE6Y+CNnokdMJbuS+d/EyEOj60qV6pw+W+C6f2M+/GIGMjfKYg10x90=
X-Google-Smtp-Source: AGHT+IE+4biFzS6VHwcFyzJJDB/i6rUdj6OVW4UaAM9KlShxmO5wvl+5UviUmjPZTFTj75cJF5rC5Q==
X-Received: by 2002:ac2:504f:0:b0:513:a140:fbf8 with SMTP id a15-20020ac2504f000000b00513a140fbf8mr1778581lfm.30.1710845638000;
        Tue, 19 Mar 2024 03:53:58 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:2fcf:6f16:3b3b:da8e? ([2a01:e0a:982:cbb0:2fcf:6f16:3b3b:da8e])
        by smtp.gmail.com with ESMTPSA id q11-20020a05600c46cb00b0041312d21a35sm21261582wmo.7.2024.03.19.03.53.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 03:53:57 -0700 (PDT)
Message-ID: <10bcbff4-4e8d-4899-bf14-b28b59b5614a@linaro.org>
Date: Tue, 19 Mar 2024 11:53:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/7] phy: qcom: qmp-pcie: refactor clock register code
Content-Language: en-US, fr
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-0-926d7a4ccd80@linaro.org>
 <20240319-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v1-2-926d7a4ccd80@linaro.org>
 <CAA8EJpqbhc_Y+EBTdz1WTnAnZN=vkTUAzc6feH4NYgbdR-ZibQ@mail.gmail.com>
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
In-Reply-To: <CAA8EJpqbhc_Y+EBTdz1WTnAnZN=vkTUAzc6feH4NYgbdR-ZibQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/03/2024 11:50, Dmitry Baryshkov wrote:
> On Tue, 19 Mar 2024 at 12:45, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>>
>> The PCIe Gen4x2 PHY found in the SM8[456]50 SoCs have a second clock,
>> in order to expose it, split the current clock registering in two parts:
>> - CCF clock registering
>> - DT clock registering
>>
>> Also switch to devm_of_clk_add_hw_provider().
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 27 +++++++++++----------------
>>   1 file changed, 11 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index 8836bb1ff0cc..079b3e306489 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -3635,11 +3635,6 @@ static int qmp_pcie_clk_init(struct qmp_pcie *qmp)
>>          return devm_clk_bulk_get_optional(dev, num, qmp->clks);
>>   }
>>
>> -static void phy_clk_release_provider(void *res)
>> -{
>> -       of_clk_del_provider(res);
>> -}
>> -
>>   /*
>>    * Register a fixed rate pipe clock.
>>    *
>> @@ -3664,7 +3659,7 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
>>          struct clk_init_data init = { };
>>          int ret;
>>
>> -       ret = of_property_read_string(np, "clock-output-names", &init.name);
>> +       ret = of_property_read_string_index(np, "clock-output-names", 0, &init.name);
>>          if (ret) {
>>                  dev_err(qmp->dev, "%pOFn: No clock-output-names\n", np);
>>                  return ret;
>> @@ -3683,19 +3678,19 @@ static int phy_pipe_clk_register(struct qmp_pcie *qmp, struct device_node *np)
>>
>>          fixed->hw.init = &init;
>>
>> -       ret = devm_clk_hw_register(qmp->dev, &fixed->hw);
>> -       if (ret)
>> -               return ret;
>> +       return devm_clk_hw_register(qmp->dev, &fixed->hw);
>> +}
>>
>> -       ret = of_clk_add_hw_provider(np, of_clk_hw_simple_get, &fixed->hw);
>> +static int qmp_pcie_register_clocks(struct qmp_pcie *qmp, struct device_node *np)
>> +{
>> +       int ret;
>> +
>> +       ret = phy_pipe_clk_register(qmp, np);
>>          if (ret)
>>                  return ret;
>>
>> -       /*
>> -        * Roll a devm action because the clock provider is the child node, but
>> -        * the child node is not actually a device.
>> -        */
>> -       return devm_add_action_or_reset(qmp->dev, phy_clk_release_provider, np);
>> +       return devm_of_clk_add_hw_provider(qmp->dev, of_clk_hw_simple_get,
>> +                                          &qmp->pipe_clk_fixed.hw);
> 
> No. The driver has to register a clock provider at the np rather than
> at dev->of_node. Otherwise legacy DT will be broken.

Indeed

Thx
Neil

> 
>>   }
>>
>>   static int qmp_pcie_parse_dt_legacy(struct qmp_pcie *qmp, struct device_node *np)
>> @@ -3899,7 +3894,7 @@ static int qmp_pcie_probe(struct platform_device *pdev)
>>          if (ret)
>>                  goto err_node_put;
>>
>> -       ret = phy_pipe_clk_register(qmp, np);
>> +       ret = qmp_pcie_register_clocks(qmp, np);
>>          if (ret)
>>                  goto err_node_put;
>>
>>
>> --
>> 2.34.1
>>
>>
> 
> 


