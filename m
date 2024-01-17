Return-Path: <linux-kernel+bounces-29292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD46830C45
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02A51F261ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698822F16;
	Wed, 17 Jan 2024 17:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t9VKz8Jp"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C039C22EE3
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705514040; cv=none; b=IwIowDWBP22UZN4oVksWQpZtGvWKAEsr3ZWYgKS5koC89S04caRCZcp60Nlz6owE34ow/cwrSvvqpxjZofSchwJLjDgi5Z9eRQk69IZ0i0op8k/5B3QoZ7XIIDt79u92IBm+sNeI68i8l4RdRxFt0hrTPtiK8jRxnPeNCozQJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705514040; c=relaxed/simple;
	bh=JjfVt3N71j4YPkrlh+5PUtWAmKzZVN5cdfHnZnYczp0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:
	 Content-Language:To:Cc:References:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding; b=Wu4nz26+RqbhAd1uXGTnJWFsG3Oy+8VKacJe7MgWFp33TGCVWezxjUWl+u+GGx8YXCwvUHmWi3cXEhmQquJ7zzwdnVqB2wQ26tEZhqCBXzwXSFrctEGcXEeaExW6X5kJiiFwliZpt747vBs6ldq8f1gks5Tyqd6QB3t6f1b4W78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t9VKz8Jp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e72a567eeso37796575e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 09:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705514037; x=1706118837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eW5dEglpjib4OhaJPnLBXWIaNV1VhhWKpxCN1epSIBk=;
        b=t9VKz8Jpk6GgEJeeeIG0oKqauKJ/Ika+8YJmknIiD/MPQEZ+CoaA8J0+zL2ln0amZb
         CPx80YB5tm3TjvOS+ku+jbt736Z3b4kSlAaCyn8iYLJxrYthoZ07PD+pWm4VhH4V3+qe
         vecrD2LuJqj7pCPkT80EqU2xT04dg1p2eun+X2Xi4iicoHQTFS4d43CaUzyklN1y6rK/
         qhNV3TqodNl0j04DwJhGhisKzvYlCB1MeDQq+33YE0pvk9BnReOyDNWJKQa7IdoHlCjN
         pKHTTtL7Kpgd5u1HC2ytatHqub1K3D+5+Xgqdemuv+qEIDPVZyt2YXT+VrbuyHxVwuPP
         VZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705514037; x=1706118837;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eW5dEglpjib4OhaJPnLBXWIaNV1VhhWKpxCN1epSIBk=;
        b=xAFyqcUaz3kwUfss4u8eBiLepzRtC5vA7e3YkcGbIxqLiSUAzQetkgTat3LCGzbwqJ
         PRep6HROb0yMRowPrMdKUxccqya7/t83sgJn60TRIm2w1mIFeW9OoSFDpRTKwFeGIG0d
         5mVIcj3FwlicKtOJ0f0IPHsWFUKTIC1E6g0IdShRUE0wl5tjn3bgaG08/bDj+XOf1K+b
         37P2LGCIFKquMtsCsW9kLLLWcnn9FeluBb8+Cu+ogvXeVeADI0O/VIYC1NuQ6ivu74g6
         akztjKufNUWqTA02HEAMq4F+849HjAygYNvtMdEuhpL099ecVQ87MccAu2wmmqPnG8DH
         j8Tg==
X-Gm-Message-State: AOJu0Yzn5NLDDfwX2yIrm0Zb/wK0FVK3T+3CW5A344I3xj1tBQP5/Xy8
	s7rV4j1EC8UoOpXpFuMvb00M3d+LR7fbgg==
X-Google-Smtp-Source: AGHT+IF9x4mzdWYcyOfkG+g6M+1NIbBX7DCz1g2FkPEH84IOqSkzdWWBeewh4OkOtgYis9oLLtkJWg==
X-Received: by 2002:a05:600c:a41:b0:40e:38a3:70f2 with SMTP id c1-20020a05600c0a4100b0040e38a370f2mr2358767wmq.65.1705514037014;
        Wed, 17 Jan 2024 09:53:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1? ([2a01:e0a:982:cbb0:de9a:cd03:1fa1:d6f1])
        by smtp.gmail.com with ESMTPSA id fa6-20020a05600c518600b0040e861ad5d2sm5252331wmb.0.2024.01.17.09.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 09:53:56 -0800 (PST)
Message-ID: <105a6adb-bef3-4c89-a6db-7f27bcd46200@linaro.org>
Date: Wed, 17 Jan 2024 18:53:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/9] PCI: introduce the concept of power sequencing of
 PCIe devices
Content-Language: en-US, fr
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kalle Valo <kvalo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Arnd Bergmann <arnd@arndb.de>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Robert Richter <rrichter@amd.com>, Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <terry.bowman@amd.com>, Lukas Wunner <lukas@wunner.de>,
 Huacai Chen <chenhuacai@kernel.org>, Alex Elder <elder@linaro.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240117160748.37682-1-brgl@bgdev.pl>
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
In-Reply-To: <20240117160748.37682-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 17:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The responses to the RFC were rather positive so here's a proper series.
> 
> During last year's Linux Plumbers we had several discussions centered
> around the need to power-on PCI devices before they can be detected on
> the bus.
> 
> The consensus during the conference was that we need to introduce a
> class of "PCI slot drivers" that would handle the power-sequencing.
> 
> After some additional brain-storming with Manivannan and the realization
> that DT maintainers won't like adding any "fake" nodes not representing
> actual devices, we decided to reuse existing PCI infrastructure.
> 
> The general idea is to instantiate platform devices for child nodes of
> the PCIe port DT node. For those nodes for which a power-sequencing
> driver exists, we bind it and let it probe. The driver then triggers a
> rescan of the PCI bus with the aim of detecting the now powered-on
> device. The device will consume the same DT node as the platform,
> power-sequencing device. We use device links to make the latter become
> the parent of the former.
> 
> The main advantage of this approach is not modifying the existing DT in
> any way and especially not adding any "fake" platform devices.
> 
> Changes since RFC:
> - move the pwrseq functionality out of the port driver and into PCI core
> - add support for WCN7850 to the first pwrseq driver (and update bindings)
> - describe the WLAN modules in sm8550-qrd and sm8650-qrd
> - rework Kconfig options, drop the defconfig changes from the series as
>    they are no longer needed
> - drop the dt-binding changes for PCI vendor codes
> - extend the DT bindings for ath11k_pci with strict property checking
> - various minor tweaks and fixes
> 
> Bartosz Golaszewski (7):
>    arm64: dts: qcom: qrb5165-rb5: describe the WLAN module of QCA6390
>    PCI: create platform devices for child OF nodes of the port node
>    PCI: hold the rescan mutex when scanning for the first time
>    PCI/pwrseq: add pwrseq core code
>    dt-bindings: wireless: ath11k: describe QCA6390
>    dt-bindings: wireless: ath11k: describe WCN7850
>    PCI/pwrseq: add a pwrseq driver for QCA6390
> 
> Neil Armstrong (2):
>    arm64: dts: qcom: sm8550-qrd: add Wifi nodes
>    arm64: dts: qcom: sm8650-qrd: add Wifi nodes
> 
>   .../net/wireless/qcom,ath11k-pci.yaml         |  89 ++++++
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dts      |  29 ++
>   arch/arm64/boot/dts/qcom/sm8250.dtsi          |  10 +
>   arch/arm64/boot/dts/qcom/sm8550-qrd.dts       |  37 +++
>   arch/arm64/boot/dts/qcom/sm8550.dtsi          |  10 +
>   arch/arm64/boot/dts/qcom/sm8650-qrd.dts       |  29 ++
>   arch/arm64/boot/dts/qcom/sm8650.dtsi          |  10 +
>   drivers/pci/Kconfig                           |   1 +
>   drivers/pci/Makefile                          |   1 +
>   drivers/pci/bus.c                             |   9 +-
>   drivers/pci/probe.c                           |   2 +
>   drivers/pci/pwrseq/Kconfig                    |  16 ++
>   drivers/pci/pwrseq/Makefile                   |   4 +
>   drivers/pci/pwrseq/pci-pwrseq-qca6390.c       | 267 ++++++++++++++++++
>   drivers/pci/pwrseq/pwrseq.c                   |  82 ++++++
>   drivers/pci/remove.c                          |   3 +-
>   include/linux/pci-pwrseq.h                    |  24 ++
>   17 files changed, 621 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/pci/pwrseq/Kconfig
>   create mode 100644 drivers/pci/pwrseq/Makefile
>   create mode 100644 drivers/pci/pwrseq/pci-pwrseq-qca6390.c
>   create mode 100644 drivers/pci/pwrseq/pwrseq.c
>   create mode 100644 include/linux/pci-pwrseq.h
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

Thanks,
Neil

