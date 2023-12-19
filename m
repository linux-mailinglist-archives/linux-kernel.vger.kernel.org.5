Return-Path: <linux-kernel+bounces-4967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510E6818478
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA3B2850EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 642BD14A94;
	Tue, 19 Dec 2023 09:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBGMglUh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B70E14295
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40c3ca9472dso49572885e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702978320; x=1703583120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8d+QOU8zUm8QbxpYvbJ8bwCgdEIlJN4SLs1T/X2vfb8=;
        b=QBGMglUhW9yYmAbNGozHilh1IS88fmFlHTYEUm4OYf23LwGppIsl1MCNtdzXZE05Bh
         eGoDMIARQXPJntgRF+8j7jDgUMsGpe7BiwSyXKw0ktWdbJAqlJuzrAYOOoKg/EJWRfTh
         od4Q0BUs8YusVLZJkeNK4194sgevH+/44iiDN7LgZnUb6EDXbNri8fBI+OIIh8hZ+g5H
         A8L2yTRJVyX6aucn/d2SpmyMZ0dHW+ZwCsyrlWO+ou2LwzmXaaOw5yLgT7o1w8BTEKaJ
         MKhHpvAHkSBuviegdGKbZD8AH7Qjo4mahOszWizkHS7c/G/jONTe5ZDPCNke7OTvL7yz
         iQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702978320; x=1703583120;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:from:content-language:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8d+QOU8zUm8QbxpYvbJ8bwCgdEIlJN4SLs1T/X2vfb8=;
        b=j8ufVyIKFGxkNn23xF0Y1JncGprAI/iXXnO2MBIz/HADt4a5Yj1DFbtBeVFPSqE6Xt
         2529kW4u6QaqGwuPx5tXOxs3Z/KY2UpJbneNb4/xe32lkc3QbuyDkR9DXz7fnvQNeJqB
         A2lhPkgAmZbgzqdytQj74+n4f0c9as0TWThzzir2NWqmkl6i5xGzDQbqL1WH9FJLr4C3
         UMUyJORXObcTu5J3nR4CsYHipNPq7EgRXFsAEr4OzT6lBZFkNmfo+Wu+C4Xivt98xpoF
         JD36cutmtpurTip03uWUYZ0nywK2+ZDXrsIR2HZci6B9NL4xmd7J/hEvLR3htv1guKqs
         GEhg==
X-Gm-Message-State: AOJu0YzHlSuQHQa0vYMmPNg6xsUm+AIVbPelraXI3wybrpeCJ1dDXV/e
	5r9t1esubJtvwRcsSLtY6pXQJA==
X-Google-Smtp-Source: AGHT+IEKcawHVs1XcASn4G7P5IkWKcPU6h8xJVicsfUFRxN21iKQMmP7Vd1QKc9Kng8c8H7O4tv9aw==
X-Received: by 2002:a05:600c:b8c:b0:40c:6e0b:69d0 with SMTP id fl12-20020a05600c0b8c00b0040c6e0b69d0mr2567912wmb.12.1702978320152;
        Tue, 19 Dec 2023 01:32:00 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e99:1baf:483a:7533? ([2a01:e0a:982:cbb0:e99:1baf:483a:7533])
        by smtp.gmail.com with ESMTPSA id e2-20020a05600c4e4200b00407b93d8085sm2034921wmq.27.2023.12.19.01.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 01:31:59 -0800 (PST)
Message-ID: <e0d29b32-2302-4a2f-ba78-e76dd7b5e570@linaro.org>
Date: Tue, 19 Dec 2023 10:31:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v4 0/3] reset: amlogic-c3: add reset driver
Content-Language: en-US, fr
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Kevin Hilman <khilman@baylibre.com>, Rob Herring <robh+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 zelong dong <zelong.dong@amlogic.com>
Cc: linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 yonghui.yu@amlogic.com, kelvin.zhang@amlogic.com
References: <20230914064018.18790-1-zelong.dong@amlogic.com>
 <170126076055.2880660.13057388884278592366.b4-ty@linaro.org>
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
In-Reply-To: <170126076055.2880660.13057388884278592366.b4-ty@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29/11/2023 13:26, Neil Armstrong wrote:
> Hi,
> 
> On Thu, 14 Sep 2023 14:40:15 +0800, zelong dong wrote:
>> From: Zelong Dong <zelong.dong@amlogic.com>
>>
>> This patchset adds Reset controller driver support for Amlogic C3 SoC.
>> The RESET registers count and offset for C3 Soc are same as S4 Soc.
>>
>> Changes since v1:
>> - remove Change-ID
>> - run scripts/checkpatch.pl and fix reported warnings
>> - sort dts node by base reg offset
>>
>> [...]
> 
> Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.8/arm64-dt)
> 
> [3/3] arm64: dts: amlogic: add reset controller for Amlogic C3 SoC
>        https://git.kernel.org/amlogic/c/a5468f5ea9a01acf29d02745abae7b82482989d4

I'll need to drop this patch from v6.8/arm64-dt since the amlogic,c3-reset.h is missing from
my tree, I'll postpone it to v6.9.

Thanks,
Neil

> 
> These changes has been applied on the intermediate git tree [1].
> 
> The v6.8/arm64-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
> for inclusion in their intermediate git branches in order to be sent to Linus during
> the next merge window, or sooner if it's a set of fixes.
> 
> In the cases of fixes, those will be merged in the current release candidate
> kernel and as soon they appear on the Linux master branch they will be
> backported to the previous Stable and Long-Stable kernels [2].
> 
> The intermediate git branches are merged daily in the linux-next tree [3],
> people are encouraged testing these pre-release kernels and report issues on the
> relevant mailing-lists.
> 
> If problems are discovered on those changes, please submit a signed-off-by revert
> patch followed by a corrective changeset.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
> [3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 


