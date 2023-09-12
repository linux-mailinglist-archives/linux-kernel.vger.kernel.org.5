Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1FB79D17A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 14:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjILM6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 08:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbjILM6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 08:58:01 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8160C10D7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:57:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-401da71b83cso63553085e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 05:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694523467; x=1695128267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYU91k+Yt4At9Ky8Zo4xbD1ZbiophgceK/i0wy1hkcE=;
        b=oM1KeU9A9owCdaEte5TrhrLoFDn8eEZ7XFqowsD1+jCBHoOR4z2wGxC/KpgAQPYi4F
         JMUOa4Ys8L8NG4x7V6VGDDZMbLlYOTehcXJwokQtMG/1o10di+7wYCjXSp5KooITV8+b
         EOeja1DO9pwCsWmHCwv6+xyFklVDt9mosle/sfwmr/ste2tne5lCftxDt0o0dFQMzY7H
         LQpF6UkaPkQn5XtZFVaQQtdHoUURRZV83DQPmS4CVmzM0s60Rpjqgz6I7lDchF7LS5Ul
         Y9j4CWWs39wTaP/ACWSHx+aHJr6U3PYJ5kPU0ZnQQGRkXW0UQbQRnuwaBWOr+Y4+JEs4
         BGNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694523467; x=1695128267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kYU91k+Yt4At9Ky8Zo4xbD1ZbiophgceK/i0wy1hkcE=;
        b=K2a1eGbVGID4BugJ9Jpdgvdqshzs8mj40JRtbeN2t8IR3FoEFxAuB88fdp5w/mDAWC
         9yXyEXMlqTczYI/tko9AcnyllxJKq2wVItvLlsumFB5Gh4oo1Y8l31u0LPQleH9+1G4j
         yrzmny3ZLOL0qrQ6C3WTJJOWo1gqC19lXcN0R54kQUMPy1gZczKLaToMOCAPzjA9dilh
         uEdHwIfhz1tsy8zwNuHJm1AnOr2r+9vEyB5Yc9cThtpkXRX4FULt7oCldGOHPSJVd7gM
         03X7Kfo9JEX0pLodX6sC24hQqieAF5X197K2tY16b9T32AYnJV4imwR7xdZEHQlEnVTZ
         rWzg==
X-Gm-Message-State: AOJu0YwV208GO/lEzYFAnZ2TCmUzxII9mNbvLiObbif+/4DWmJe0lKYB
        PgzkES2gKPBDgrmaaM4oVyEqkw==
X-Google-Smtp-Source: AGHT+IEvBC5cBojbboN1wVPdVG3nssSxtqehgHtA+QFGwbidSUE5Ft50iLURqhRnLWY9y/XYtYnlYA==
X-Received: by 2002:a05:600c:228f:b0:401:d803:6246 with SMTP id 15-20020a05600c228f00b00401d8036246mr11053444wmf.2.1694523466766;
        Tue, 12 Sep 2023 05:57:46 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:6333:6696:6b64:4890? ([2a05:6e02:1041:c10:6333:6696:6b64:4890])
        by smtp.googlemail.com with ESMTPSA id t15-20020a7bc3cf000000b00402be2666bcsm16205152wmj.6.2023.09.12.05.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 05:57:46 -0700 (PDT)
Message-ID: <07a569b9-e691-64ea-dd65-3b49842af33d@linaro.org>
Date:   Tue, 12 Sep 2023 14:57:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Aw: regression with 33140e668b10 thermal/drivers/mediatek:
 Control buffer enablement tweaks
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Daniel Golle <daniel@makrotopia.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Riabchenko <d3adme4t@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <trinity-6713557b-fe0a-4dae-84aa-1aa86f7619fa-1693473911557@3c-app-gmx-bs12>
 <trinity-f3e7d8e0-2e93-4e84-a489-3993c819d2c3-1693488871086@3c-app-gmx-bs12>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <trinity-f3e7d8e0-2e93-4e84-a489-3993c819d2c3-1693488871086@3c-app-gmx-bs12>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Frank,

thanks for reporting and investigating the issue.


On 31/08/2023 15:34, Frank Wunderlich wrote:
> Hi,
> 
> looked a bit deeper into it and it looks like i only need to add the fields in the mtk_thermal_data struct
> 
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -690,6 +690,9 @@ static const struct mtk_thermal_data mt7986_thermal_data = {
>          .adcpnp = mt7986_adcpnp,
>          .sensor_mux_values = mt7986_mux_values,
>          .version = MTK_THERMAL_V3,
> +       .apmixed_buffer_ctl_reg = APMIXED_SYS_TS_CON1,
> +       .apmixed_buffer_ctl_mask = GENMASK(31, 6) | BIT(3),
> +       .apmixed_buffer_ctl_set = BIT(0),
>   };
> 
> in my quick test the temprature can be read again and i'm near room temperature...i though it was a bit higher before, but as far as i understand the code, the values were fixed before and only made it configurable.
> 
> if someone can confirm that i'm right, i can send official patch.

At the first glance, it seems the proposed change is correct and could 
be proposed as a hot fix.

However, the conditions with the version and the apmixed_buffer_ctl_reg 
looks a bit fuzzy.

Markus, can you revisit this part of code and consolidate the 
configurable approach ?

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

