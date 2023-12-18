Return-Path: <linux-kernel+bounces-3257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9BF816A00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 10:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 891EA1F23359
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0406711CAF;
	Mon, 18 Dec 2023 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m+Jdg4Pq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B08125AD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 09:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6d47bb467a9so903847b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 01:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702892381; x=1703497181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTYEtunIedVhrIrUbrN5OGHL/0lewttUjOiPfnpbhG4=;
        b=m+Jdg4Pqa3KDO8JRupZ6tkl5k3/Jt03n+UEIpevEeTp+GWpZCDVjpZber2RoIODSwX
         1BiHGKp7s2b4jleJcEWhMkm5XFOF+6RI/4A0/QEExdiSMXfK9+z5o2XM7r7PflsZpFfu
         +gpF6AszArOKAGLXwgqnHkoEPUAoG4Txl2syQdTMOG7VqzfzTeKrRHSdVjytiLJ/Sm+k
         CcGqLgHTd0xmbK9W8t4gewtKuhAPmtND+A9FC27W6d1JOttqMnZEbbcgRBFCFiXVm9uk
         BTmLIGB5qtdfrd1R4xfdayECrvc1pFx9LR7z6RfWh7hlfoFMgq1dz06ZAJ8q35q1PgJc
         9jrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702892381; x=1703497181;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BTYEtunIedVhrIrUbrN5OGHL/0lewttUjOiPfnpbhG4=;
        b=mdoJaHrkToR5N3CZWK8FZNyWhTj/1QnZLwRB7d+BYP8I0ZWsoRZORGwXGP5anUs9YP
         jNdF9G2U5JLhcUdiJbwdH4gBN5pl9MGBl3TdYx8B+FbBZ2EbFiXxJvIyFhkdSy/fd+tg
         /0DMBLGw2b3sQIUU+gJWsdBLQpcVN4bjCuuuGL2CtU4mA80ylrj1eYDtPEudDvS+BYWd
         aSc1YKWy+RJTqGDJ/egsfJ1VAsmiDADJ+YB6oBePQNU7GKL8m7VqGFOq3IJqAB23QGGY
         nKcV5erKwidP8eiAY2casNrWKLCZ4jZriNV8lVGFknvFipyCRdgVpNXzpR+q17XbiAlv
         Nofg==
X-Gm-Message-State: AOJu0YxWZzyZpsGdmBrcTqGOe6TZdW9VJLKrYa+iomBv2dmhnBJ0uwPy
	JdFExd3h8aIH6uI3cLzJfXGIvA==
X-Google-Smtp-Source: AGHT+IF92lD4uQGcOvnMiAVb7hcO4gcbwh7m7LghWfKxV9vSCKKOHDlYmmYLmBb0BH9hREskDXqLvQ==
X-Received: by 2002:a05:6a20:3712:b0:194:341e:8f5c with SMTP id t18-20020a056a20371200b00194341e8f5cmr1602230pze.50.1702892381093;
        Mon, 18 Dec 2023 01:39:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:b425:da5d:c0cf:a505? ([2a01:e0a:982:cbb0:b425:da5d:c0cf:a505])
        by smtp.gmail.com with ESMTPSA id e10-20020aa798ca000000b006d7bfb2f30csm1333167pfm.148.2023.12.18.01.39.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 01:39:40 -0800 (PST)
Message-ID: <db90068a-8eac-458e-bc22-aceb59870f5d@linaro.org>
Date: Mon, 18 Dec 2023 10:39:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v9 08/12] clk: meson: g12a: make VCLK2 and ENCL clock path
 configurable by CCF
Content-Language: en-US, fr
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Jagan Teki <jagan@amarulasolutions.com>, Nicolas Belin
 <nbelin@baylibre.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Remi Pommarel
 <repk@triplefau.lt>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-phy@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-0-95256ed139e6@linaro.org>
 <20231124-amlogic-v6-4-upstream-dsi-ccf-vim3-v9-8-95256ed139e6@linaro.org>
 <1jbkbjdxk8.fsf@starbuckisacylon.baylibre.com>
 <b23ddc3b-d995-4cd6-91f2-3efa59d345a5@linaro.org>
 <1j34wvdtux.fsf@starbuckisacylon.baylibre.com>
 <41a1246e-c885-460a-8208-16844e95e1ae@linaro.org>
 <1jjzq3zhaw.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1jjzq3zhaw.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 27/11/2023 09:38, Jerome Brunet wrote:
> 
>>>
>>>>
>>>> I suspect mipi_dsi_pxclk_div was added to achieve fractional vclk/bitclk ratios,
>>>> since it doesn't exist on AXG. Not sure we would ever need it... and none
>>>> of the other upstream DSI drivers supports such setups.
>>>>
>>>> The main reasons I set only mipi_dsi_pxclk in DT is because :
>>>> 1) the DSI controller requires a bitclk to respond, pclk is not enough
>>>> 2) GP0 is disabled with an invalid config at cold boot, thus we cannot
>>>> rely on a default/safe rate on an initial prepare_enable().
>>>> This permits setting initial valid state for the DSI controller, while
>>>> the actual bitclk and vclk are calculated dynamically with panel/bridge
>>>> runtime parameters.
>>> Nothing against setting rate in DT when it is static. Setting it then
>>> overriding it is not easy to follow.
>>
>> Yup, would be simpler to only have parenting set in DT, since it must
>> stay static, I'm fine trying to move rate setup to code.
>>
>>> To work around GP0 not being set, assuming you want to keep rate
>>> propagation as it is, you could call clk_set_rate() on cts_encl (possibly w/o
>>> enabling it) to force a setup on gp0 then clk_prepare_enable() on
>>> pxclk. You'd get a your safe rate on GP0 and the clock you need on pxclk.
>>> It is a bit hackish. Might be better to claim gp0 in your driver to
>>> manage it directly, cutting rate propagation above it to control each
>>> branch of the subtree as you need. It seems you need to have control over
>>> that anyway and it would be clear GP0 is expected to belong to DSI.
>>
>> Controlling the PLL from the DSI controller seems violating too much layers,
>> DSI controller driver is not feed directly by the PLL so it's a non-sense
>> regarding DT properties.
> 
> Not sure what you mean by this. You have shown in your the commit
> message that the DSI clocks make significant subtree. I don't see a
> problem if you need to manage the root of that subtree. I'd be great if
> you didn't need to, but it is what it is ...

I really think the choice of PLL should not be done by the DSI controller,
but by the Video pipeline driver or statically until we can do this.

My point is that we should only define the clocks that are related to each
hardware, for example the whole VCLK/VCLK2 clocks should be defined for the
VPU HW, then only the few endpoint clocks should be defined for the HDMI
or DSI controllers, PHY clock and ENCI/ENCP for HDMI, DSI and ENCL for DSI.

The big plan is to entirely switch to CCF for VPU, but first I want to have
DSI working, and since DSI needs GP0, we need CCF for that so the intermediate
plan is to have partial CCF handling only for DSI with fixed clock tree in DT,
then in the future the Meson DRM driver would set up the appropriate clock
tree for HDMI, DSI, Composite and perhaps DP for T7 SoCs then the controller
bridge will call the clk_set_rate() in the same design I did for DSI.

Here's the tracked item: https://gitlab.com/amlogic-foss/mainline-linux-issues-tracker/-/issues/9

CCF clock control is a mandatory item to solved dual-head display: https://gitlab.com/amlogic-foss/mainline-linux-issues-tracker/-/issues/6

> 
>>
>> Setting a safe clock from the DSI controller probe is an idea, but again I
>> don't know which value I should use...
> 
> You mentionned that the problem comes DSI bridges that needs to change
> at runtime. I don't know much about those TBH, but is there
> anyway you can come up with a static GP0 rate that would then be able to
> divide to serve all the rates bridge would need in your use case ?

No, there's no such things in the DSI world, MIPI only specifies the electrical
and transport layer, everything else is custom per vendor.

> 
> GP0 can go a lot higher than ~100MHz and there are dividers unused in the
> tree it seems.
> 
> I suppose there is a finite number of required rate for each use case ?
> If there are not too many and there is a common divider that allows a
> common rate GP0 can do, it would solve your problem. It's a lot of if
> but It is worth checking.
> 
> This is how audio works and DT assigned rate is a good match in this case.

Yeah I know, but I would love it but no...

> 
>>
>> I'll review the clk parenting flags and try to hack something.
>>
>> Thanks,
>> Neil
>>
>>

Thanks,
Neil


