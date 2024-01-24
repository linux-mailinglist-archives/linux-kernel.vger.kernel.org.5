Return-Path: <linux-kernel+bounces-36666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D05E83A4BF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D7D5282718
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528018046;
	Wed, 24 Jan 2024 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="huG7CqZ5"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D715C18037
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086692; cv=none; b=SHs66VfOjIzhCBcWqC4ePvZWs6HPNBG/gK416Ddmn7VeGftobK0z3mEkBR+GNru96Sb/tfh2NIQ+qJcI/1UKYNVVSn1jTHI8ME8qWqRkXnDnhLbYB9VS/b82EpXB6ZSh0Fr3B7UcCXn40F1/9+53GAvEDcdNXAGkkgYkBwXQniA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086692; c=relaxed/simple;
	bh=toj0UISkiBOlqTne8wRnYSSozCtyXOg/TgCdgB0UOzs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=L/tYbYkLBgvc1h9W/urm3k9ItGTQqeZS67mSUqT/JISw+B2sYM3jPGCq4ctCt+gbmr3bt4UUSAzQq/Hc1MqM2MP5IBIpHpIGyGWekYwQLitGse7rtPxw95Y+QgwtONyTyBjThRZnEoMCWwIRoIVqvP/ctuCnyFajAZO4Ng0CcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=huG7CqZ5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3394dc2ae23so383651f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706086689; x=1706691489; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztaP5iJjQnXrgl0zMMgX8A+csccy+mQSF5M8vkU9Z2U=;
        b=huG7CqZ5dBuCS5M2Erz93/hCkEccPDATD7I7OlzPlrUKG+mYJELMlFW9OKrg0MeqCa
         bcVtkF9N72H6oE5OpCeKY93E6nq93Dn2OTABwZhELEx60BITSDizWSwuVfrEn5M7zv8w
         wK/V2XFjZ8ect/AI91Me0pzEuPQ2tTd9bkSAn0hIEmMsCwvO8ZjS62BMTz5/JtIXXLOg
         WglDza2//TWMh2LH0Qb/GDf1oS63RuQOpSetSCm/mIUwa3zJwk3ihVJuGLkU87biZNL2
         xN8cU2K6dy0bnIHNrkmHhtktaRgQ8/9CveQwerauPYUHrcXfxtuwG2yiXJhd8BB03lBY
         xUUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086689; x=1706691489;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ztaP5iJjQnXrgl0zMMgX8A+csccy+mQSF5M8vkU9Z2U=;
        b=f11L20Wfy5jiq97YloT8FtT5XPT04Y2lwZNNiJ2nJndTe/8j5aEYjU8TSpykCADDz4
         SPik8wpXlTQ406vHSCo+5PmRRZa1xgig2gYkPdmES9wSOwudKdzMxcua92dyLR00V8XJ
         /hXwdO04QZoI8cSET82Oq88UvhVmGpxmwd9fCtzFGUEXxmTRMa/5LpAFn5NiwNb3IIaa
         JPZ+St5G+ije/HiAg5LZv6fhCNsiUJbiWyMjD5tz/hNhSy5VKwe48V/s7oFuFtVloMlM
         HLpKOMUSyjrywoe4czhan5jUQav5mtSZ9oh0IUczmbDUIGEO94K7gkcBOp2O9SD147qh
         9VMw==
X-Gm-Message-State: AOJu0YxMHAiesvc+TUd9rRnW4AfRb0bfi3Om1ZUxhybZb4MniX6dFDAq
	x9Qw9RTlrN2W6tMg/gZEPlfT33AsDj2ka2vtvvJRq1mn7tElcimVJ8lCCMTiLUU=
X-Google-Smtp-Source: AGHT+IF+1DNPW9ZmN2qeaSvbY7hn2ZCDh2EuftJzvf6GGLnETy6hh/0C5Quq9lTYEfAGJZSYTWh9hg==
X-Received: by 2002:a05:6000:922:b0:337:be12:5846 with SMTP id cx2-20020a056000092200b00337be125846mr192591wrb.163.1706086688975;
        Wed, 24 Jan 2024 00:58:08 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654? ([2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654])
        by smtp.gmail.com with ESMTPSA id j28-20020adfb31c000000b003393457afc2sm7885382wrd.95.2024.01.24.00.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 00:58:08 -0800 (PST)
Message-ID: <e6b8befb-82e8-4803-929c-32e86d1e825a@linaro.org>
Date: Wed, 24 Jan 2024 09:58:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/2] phy: qcom: qmp-pcie: Update PCIe PHY settings for
 SM8550
Content-Language: en-US, fr
To: Qiang Yu <quic_qianyu@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
 kishon@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, quic_cang@quicinc.com, quic_mrana@quicinc.com
References: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
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
In-Reply-To: <1703742157-69840-1-git-send-email-quic_qianyu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 28/12/2023 06:42, Qiang Yu wrote:
> Align PCIe0/PCIe1 PHY settings with SM8550 latest PCIe PHY Hardware
> Programming Guide.
> 
> Can Guo (1):
>    phy: qcom: qmp-pcie: Update PCIe1 PHY settings for SM8550
> 
> Qiang Yu (1):
>    phy: qcom: qmp-pcie: Update PCIe0 PHY settings for SM8550
> 
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c             | 20 ++++++++++++++------
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6.h      |  2 ++
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v6_20.h   |  2 ++
>   drivers/phy/qualcomm/phy-qcom-qmp-pcs-v6_20.h        |  1 +
>   .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v6_20.h   |  2 ++
>   5 files changed, 21 insertions(+), 6 deletions(-)
> 

- On SM8550-HDK:
# lspci
0000:00:00.0 PCI bridge: Qualcomm Device 0113
0000:01:00.0 Network controller: Qualcomm Device 1107 (rev 01)
0001:00:00.0 PCI bridge: Qualcomm Device 0113
0001:01:00.0 Non-Volatile memory controller: Phison Electronics Corporation E12 NVMe Controller (rev 01)


# lspci -nvv
0000:00:00.0 0604: 17cb:0113 (prog-if 00 [Normal decode])
		LnkCap:	Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <4us, L1 <8us
		LnkSta:	Speed 5GT/s, Width x2
0001:00:00.0 0604: 17cb:0113 (prog-if 00 [Normal decode])
		LnkCap:	Port #0, Speed 16GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <4us, L1 <8us
		LnkSta:	Speed 8GT/s, Width x2

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK

- On SM8550-QRD:
# lspci
00:00.0 PCI bridge: Qualcomm Device 0113
01:00.0 Network controller: Qualcomm Device 1107 (rev 01)

# lspci -nvv
		LnkCap:	Port #0, Speed 8GT/s, Width x2, ASPM L0s L1, Exit Latency L0s <4us, L1 <8us
		LnkSta:	Speed 5GT/s, Width x2

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD

Thanks,
Neil

