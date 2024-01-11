Return-Path: <linux-kernel+bounces-23198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1326E82A8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B33286AD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ABD3DDC1;
	Thu, 11 Jan 2024 08:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Acs4L3C0"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7A2E544
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3368b9bbeb4so4771590f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 00:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704961153; x=1705565953; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4qHeI/z66hlwEDi1tGbM9yP5c2kAe5foIFfSXCRpNE=;
        b=Acs4L3C0LJCQLHKxWGFp+PX345K3pSmxATroorgT2qmm79NFUkUSS/TFbE2EwkhkNz
         t9wkPUTBQJOLNKDK+CNRJ5E88Q7d7GtW8G45tWjj7oyUXH9bVzNEaHdswJmRfooq/V2v
         Ok48a9YU/eLPVYP31FpdQs/9T7hS+iUZPMyYeIdO3RIpkvL9VITgNErhLNn/9nddGltR
         B5zkNCsRZWadK8sNy2NpQLkZBYPEXiORnUCGnVCtC89yX4UdB46RgG6chX+CYT+X1IWr
         3km14UcpQjtxej9NMtoKUsSUvb2vn+QX7rIb0l3MqKm85dWJq1IzXtwgEvmJdWrTA98b
         byFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704961153; x=1705565953;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+4qHeI/z66hlwEDi1tGbM9yP5c2kAe5foIFfSXCRpNE=;
        b=UOVNjlQT7lXzD2Rgck4MwOfVrZbBUMhoN4Sto01RoHgvvWECgO498LDeK5KJ32IT6n
         WAeSipMrviu+dzCgAShWksHf6C/pu6ZV12JPO1DNgy2x1QZQD0sN0Jv1RYr9lwyRtRPv
         hCnjTXxrikWy/VB5gWWgSx6CIvrlHhiKERyZ7GAoPke5CYfFWhTLFE6/kf2BKg39qJk0
         +ySAKBWR5j2RJ3IUAMP+37u0eKo6lFnMT2uYUe6upfZP2rlTzs90gYGJfjoShAbJqWoh
         O5+0huXTNzgHWUmaK2NZwwdOjK5+p6dngPs1vqyaSv2u6h1lOZr6cXJQjoDZo5fsLF63
         MMKQ==
X-Gm-Message-State: AOJu0Yx302DHOboI6xtnYbqkfT8UaYRRmqyFhPRoVLXTEjeRxpdNe1Ld
	hxeTv8/xMRCl7a6R/LGaRK/VYmQPpLmFVw==
X-Google-Smtp-Source: AGHT+IG1MXGBZm+5oHqUHBJdJ1Gjre9hhkiIT+3tfrKpHjQyQgK7AuNU3ufYjUEJBIcpbc9DMxgMRg==
X-Received: by 2002:adf:ed4e:0:b0:336:4bbc:72e4 with SMTP id u14-20020adfed4e000000b003364bbc72e4mr189239wro.81.1704961153283;
        Thu, 11 Jan 2024 00:19:13 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a5aa:e466:ae57:5a26? ([2a01:e0a:982:cbb0:a5aa:e466:ae57:5a26])
        by smtp.gmail.com with ESMTPSA id x18-20020adfffd2000000b003377680c55bsm555821wrs.16.2024.01.11.00.19.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 00:19:12 -0800 (PST)
Message-ID: <b2caf65d-4bc8-4e16-b4db-b24006e3dce6@linaro.org>
Date: Thu, 11 Jan 2024 09:19:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 00/24] Support more Amlogic SoC families in crypto
 driver
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 clabbe@baylibre.com, herbert@gondor.apana.org.au, davem@davemloft.net,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 khilman@baylibre.com, jbrunet@baylibre.com, artin.blumenstingl@googlemail.com
Cc: linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@salutedevices.com
References: <20240110201216.18016-1-avromanov@salutedevices.com>
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
In-Reply-To: <20240110201216.18016-1-avromanov@salutedevices.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi !

On 10/01/2024 21:11, Alexey Romanov wrote:
> Hello!
> 
> This patchset expand the funcionality of the Amlogic
> crypto driver by adding support for more SoC families:
> AXG, G12A, G12B, SM1, A1, S4.
> 
> Also specify and enable crypto node in device tree
> for reference Amlogic devices.
> 
> Tested on AXG, G12A/B, SM1, A1 and S4 devices via
> custom tests and trcypt module.

Thanks a lot for the patchset, it's very welcome!

Could you provide some procedure used to test and test dumps for all the platforms, like `cryptsetup benchmark` or a summary of tcrypt tests output ?

Thanks,
Neil

> 
> Alexey Romanov (17):
>    drivers: crypto: meson: don't hardcode IRQ count
>    drivers: crypto: meson: make CLK controller optional
>    drviers: crypto: meson: add platform data
>    drivers: crypto: meson: add MMIO helpers
>    drivers: crypto: meson: move get_engine_number()
>    drivers: crypto: meson: use fallback for 192-bit keys
>    drivers: crypto: meson: add support for G12-series
>    drivers: crypto: meson: add support for AXG-series
>    dt-bindings: crypto: meson: add new compatibles
>    arch: arm64: dts: meson: a1: add crypto node
>    arch: arm64: dts: meson: s4: add crypto node
>    arch: arm64: dts: meson: g12: add crypto node
>    arch: arm64: dts: meson: axg: add crypto node
>    arch: arm64: dts: meson: s4-s805x2-aq222: enable crypto node
>    arch: arm64: dts: meson: a1-ad401: enable crypto node
>    arch: arm64: dts: meson: axg-s400: enable crypto node
>    arch: arm64: dts: meson: g12a-u200: enable crypto node
> 
> Jan Dakinevich (7):
>    drivers: crypto: meson: drop status field from meson_flow
>    drivers: crypto: meson: move algs definition and cipher API to
>      cipher.c
>    drivers: crypto: meson: cleanup defines
>    drivers: crypto: meson: process more than MAXDESCS descriptors
>    drivers: crypto: meson: avoid kzalloc in engine thread
>    drivers: crypto: meson: introduce hasher
>    drivers: crypto: meson: add support for AES-CTR
> 
>   .../bindings/crypto/amlogic,gxl-crypto.yaml   |   2 +
>   .../arm64/boot/dts/amlogic/meson-a1-ad401.dts |   4 +
>   arch/arm64/boot/dts/amlogic/meson-a1.dtsi     |   8 +
>   .../arm64/boot/dts/amlogic/meson-axg-s400.dts |   4 +
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi    |   7 +
>   .../boot/dts/amlogic/meson-g12-common.dtsi    |   7 +
>   .../boot/dts/amlogic/meson-g12a-u200.dts      |   4 +
>   .../dts/amlogic/meson-s4-s805x2-aq222.dts     |   4 +
>   arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |   7 +
>   drivers/crypto/amlogic/Makefile               |   2 +-
>   drivers/crypto/amlogic/amlogic-gxl-cipher.c   | 591 ++++++++++++------
>   drivers/crypto/amlogic/amlogic-gxl-core.c     | 260 ++++----
>   drivers/crypto/amlogic/amlogic-gxl-hasher.c   | 448 +++++++++++++
>   drivers/crypto/amlogic/amlogic-gxl.h          | 116 +++-
>   14 files changed, 1135 insertions(+), 329 deletions(-)
>   create mode 100644 drivers/crypto/amlogic/amlogic-gxl-hasher.c
> 


