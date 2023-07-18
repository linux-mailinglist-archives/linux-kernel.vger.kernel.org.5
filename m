Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DA77573A0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjGRGGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjGRGGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:06:35 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9B2F1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:06:33 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51e5e4c6026so7548345a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660392; x=1692252392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3E/REAd1PY+Cafajtk4h0rH83WVGTGX7hhI9F7Vli0=;
        b=AnEBkeGg+icA/9lTeVQ2Mt6YiwQ+FOnIiw143u9tuDa0YDZpQ49rej8OzOkYUBhPKK
         vbrJv+4LowZWShkbAyMF6rQQyRxA8zNryp/wRpFlSIi0249ank4AsA6vP4jIhqDWxs0a
         k4U+atFg6x/coIIuZDk/LKXzoz8cYvMGcNweMqvP2wR5fHwIHvRNEGDDmJrJVTTFnObE
         FIGSPOqzQi3AXxcvkfXyPMSeGIXm4FYq39/ATckEeXI/S50jb3+4AUC6iNZmzKvQbS5L
         lnMz949+C4W0NX7+Z2KTu7N5njLnc1JyoWgLhBrvi4nuQPzniXG1+GmGc2Conr6Rdq32
         40+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660392; x=1692252392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3E/REAd1PY+Cafajtk4h0rH83WVGTGX7hhI9F7Vli0=;
        b=Vf07Tj/L/Oy0HoOxWe6PzpaCNBLIKU6FWcSkxrpND9DqCZ0mGB5Lo999ywdgnR1liM
         VTNfEnDht6C5/FypTsWIA9FMcCGk4mwGXlxx9wl8boTz2euA/5LauCHdx6eEY9Snj/iO
         pdE8eXZBPHwzfo7E+7yiMsHWI+J42M/oD5KeRIZsSE+pGZZnhfH2ArooCZK6AoOGg131
         mDBjNKxTlz1thKqSXp4owGWDuQ4rf5c1+xZB+X41PS/blqoRkORFEeouI5JL8yka37e1
         YvD4p3DysvGawYUtjWxoE/B3wggIincAXxw2wRghuU+rfvRioYvrNSctOwnoCRcGNJvY
         h7vg==
X-Gm-Message-State: ABy/qLapuTCnIzIMi1ZbppBxWTPvEBsn6xz5lSGRomQR/L5tyEfFNogH
        iqtmKghdnGRQj0bumOv05m+RIA==
X-Google-Smtp-Source: APBJJlFYm/q1jH0wn2AtcjBZ6ivjdesS6NxsnwNVQYeWFkZoY71A9o2TCsdZjM9mActq7FJOXHme/w==
X-Received: by 2002:a17:907:20d2:b0:997:bb66:3d1 with SMTP id qq18-20020a17090720d200b00997bb6603d1mr5520876ejb.25.1689660392158;
        Mon, 17 Jul 2023 23:06:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e9-20020a170906374900b009893650453fsm554206ejc.173.2023.07.17.23.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:06:31 -0700 (PDT)
Message-ID: <a62141a9-a2c0-6568-cb05-5ef59250e10f@linaro.org>
Date:   Tue, 18 Jul 2023 08:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] arm64: dts: exynos: add pwm node for
 exynosautov9-sadk
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230718034201.136800-1-jaewon02.kim@samsung.com>
 <CGME20230718034723epcas2p354fc5502d4ed212c7f748d2849e6b60a@epcas2p3.samsung.com>
 <20230718034201.136800-3-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718034201.136800-3-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 05:42, Jaewon Kim wrote:
> Add pwm node to support fan on exynosautov9-sadk board.
> PWM channel 3 of ExynosAutov9 is connected to fan for SoC cooling
> in SADK board.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
>  arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 10 ++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> index 101f51bf565a..bc1815f6ada2 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> @@ -49,6 +49,12 @@
>  	};
>  };
>  
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_tout3>;
> +	status = "okay";

I think you miss disabling it.

> +};

Best regards,
Krzysztof

