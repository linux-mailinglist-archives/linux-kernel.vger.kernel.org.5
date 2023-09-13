Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0052579E3A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 11:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239376AbjIMJ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 05:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239329AbjIMJ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 05:27:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A699D19A7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:27:35 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-502b0d23f28so6193653e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 02:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694597254; x=1695202054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HS+TSYJtWKq1E+DACcXYtJXQQi+9W2JQkUnTiY0vyu8=;
        b=YWXoTFx7l2nIEgdyTiYyFw1uU+OSvQozze/MFl36/RhozMr9uC2NAQNzWjaR7HP/fU
         u3q7Tfe8NHT2nxMnR3PQMrpDihM7D8wuQRzbyjDphoNQjQHu9VdoVzvj3KutUwRsigc8
         skCH6nQsKT8IhzoizTOZGFCSbyEiBl7hrkqlyESI3ljrlrDblBOkCJzHsrcNDGtrf8gS
         J2+7CJjwKXHYSnrTlNVusaJGDgszkQ/pRFVIPZPOlZvIwmimQyLgFNPx6cZZIOceVWze
         gNOHzlcS/03JMYEZ5xWxdEJsIIb0XcL1z9LadLthWxNRkwjENHUltcUDTRZQCg/IazD0
         6fSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694597254; x=1695202054;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HS+TSYJtWKq1E+DACcXYtJXQQi+9W2JQkUnTiY0vyu8=;
        b=jxBchhvvoTlka1vskf1AMGKSYibrF3p4+3ZhZbJvWuryt+OuaL6mWbfGWJJYD3aoQB
         /gEqqTaqirRdyZnEuyYXbXj5y/dlnTQkQpMLvI/IjZMZZAKoGOPuFr+nSTcbfWHVMGDL
         sKo16LHRVsVmNC+o88G5hbZrilyRseIaRchGuBkcpMn7HJlw30K5Rrut/MIaPRKfmETM
         vZRaVseu8RG3ieH97BVLvR5ItrQyGBOxX1cpOo1fgcVLDX/Zotv1Y6KTN8fOPHJtZjb8
         eoPfN/+OlWj9yzxiSdlw2psUOtSKtrYEjU9CojIioL/GGikKWHY2xG3txn+VgbhHNa2z
         JeSA==
X-Gm-Message-State: AOJu0YyHGUXWsJLmslprcOFnxRbFnNwxRzO//h3XHYg7Biqam5vEigcf
        diiTEinayk1PDW2TrCPiEHZq5A==
X-Google-Smtp-Source: AGHT+IEeFEW6oc3gnUF+0bGJwKOToA1DyUTF4/Bun2mvGLvKOPSpg4WLwyz2PWawDogKN/gZ3aOJXw==
X-Received: by 2002:a05:6512:36c9:b0:4fb:7559:aea3 with SMTP id e9-20020a05651236c900b004fb7559aea3mr1303560lfs.39.1694597253873;
        Wed, 13 Sep 2023 02:27:33 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:47c3:1e57:f54:3370? ([2a01:e0a:982:cbb0:47c3:1e57:f54:3370])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600c11ce00b003fee8502999sm1468810wmi.18.2023.09.13.02.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 02:27:33 -0700 (PDT)
Message-ID: <65099fa0-e1e7-43ca-8528-18faf289ab6f@linaro.org>
Date:   Wed, 13 Sep 2023 11:27:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] pmdomain: Rename the genpd subsystem to pmdomain
Content-Language: en-US, fr
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@amd.com>,
        Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andreas Farber <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230912221127.487327-1-ulf.hansson@linaro.org>
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
In-Reply-To: <20230912221127.487327-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 00:11, Ulf Hansson wrote:
> It has been pointed out that naming a subsystem "genpd" isn't very
> self-explanatory and the acronym itself that means Generic Power Domain, is
> known only by a limited group of people.
> 
> In a way to improve the situation, let's rename the subsystem to pmdomain,
> which ideally should indicate that this is about so called Power Domains or
> "PM domains" as we often also use within the Linux Kernel terminology.
> 
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   MAINTAINERS                                   | 22 +++++++++----------

<snip>

>   drivers/{genpd => pmdomain}/actions/owl-sps.c |  0
>   drivers/{genpd => pmdomain}/amlogic/Makefile  |  0
>   .../amlogic/meson-ee-pwrc.c                   |  0
>   .../amlogic/meson-gx-pwrc-vpu.c               |  0
>   .../amlogic/meson-secure-pwrc.c               |  0

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>

<snip>

Thanks,
Neil
