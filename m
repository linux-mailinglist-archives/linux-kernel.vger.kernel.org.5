Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5237380C238
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233908AbjLKHmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbjLKHmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:42:10 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6C9127
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:42:14 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2cb54ab7ffeso17128991fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 23:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702280532; x=1702885332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=isEx4Px7vt9AwtBEcan27JIxTrceu09splFCoGA5dbc=;
        b=AIIOCg7c3P6CsvlcFKXsEk2jwnecOok/KWxmL9Fp4SPTJCHuhjU7aSoomh2jNWjyB8
         IOrMVnzyXUIOO2I6ABbWjsuzh4wn+/9EvFMxDO/op8AIzqSqcygWLyhbtVHxBrLo8yOn
         da3V5dNjZ8fkckTGDAf1+W/fkaIRK40tefKd9nMc7BLvJbsQ+4afAkoPXzqgTHyIfYmI
         33xc/YyimIpOgQ/vQtDcFAwTvVP6UurB1fYN9jXB0xvliYL+xtbN9yqC930jMkjJt2HD
         pGX0vEW6gOIFTM3U4rX8CTh6tyL26Q1arqvvLzFXBMK/aJ83FzEhYypUSWoOWxmQBc0T
         +hYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702280532; x=1702885332;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=isEx4Px7vt9AwtBEcan27JIxTrceu09splFCoGA5dbc=;
        b=RLtwRbtwh0oalV/AoLCWwrYqlckFC4Z5iTxisY+Oyn7QQ0MFtlyKmj/8iyYCbZ8C31
         hAKDo3mb7ryf+hZIHynaJ+5HpLBhQawQFNyl8qQ0T4MrarN0G8/cY5GCFNxNyj3dvRsl
         9hqlYY7264civgDwYFH1ROLblXX6Z7Vugh0H3EV6HrZcfGym3i7KquUJ3zACF6pOcpLI
         6qsLuQ9G5OioFxnABPY0MBZwbYzD1jW40vf88gjviIjkjE7GuW4oetd6vLfqxthbROIo
         PGm90b2DBNO/fqzGI/foWkIId08HxKgNaQQO2b7GgTU1s0u0e2kGr1TLFGHEjtk+ByeM
         JeSQ==
X-Gm-Message-State: AOJu0Yzn/7ilQusJ+WhdGFveF267AErnwol/+UiEgFmNFXce8H+k/Vw3
        yUpPfFlMZjU4XQzEhkky1BNJLA==
X-Google-Smtp-Source: AGHT+IFNI74+YNQA3KSvGpKhUuTNU4PHfmLowVWnfUrcsdiQP4p/loRDXs+lYzLROz+4aagaMI7FQQ==
X-Received: by 2002:a2e:be21:0:b0:2cb:2b42:6d68 with SMTP id z33-20020a2ebe21000000b002cb2b426d68mr1342157ljq.4.1702280532766;
        Sun, 10 Dec 2023 23:42:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id s30-20020a05651c201e00b002ca0217f327sm1116269ljo.65.2023.12.10.23.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 23:42:12 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Jaewon Kim <jaewon02.kim@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20231208074527.50840-3-jaewon02.kim@samsung.com>
References: <20231208074527.50840-1-jaewon02.kim@samsung.com>
 <CGME20231208075020epcas2p30e46ea65e921664930b337510461892f@epcas2p3.samsung.com>
 <20231208074527.50840-3-jaewon02.kim@samsung.com>
Subject: Re: (subset) [PATCH v3 2/4] arm64: dts: exynos: add minimal
 support for exynosautov920 sadk board
Message-Id: <170228053058.12030.17311728279876504581.b4-ty@linaro.org>
Date:   Mon, 11 Dec 2023 08:42:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 08 Dec 2023 16:45:25 +0900, Jaewon Kim wrote:
> ExynosAutov920 SADK is ExynosAutov920 SoC based SADK(Samsung Automotive
> Development Kit) board. It has 16GB(8GB + 8GB) LPDDR5 RAM and 256GB
> (128GB + 128GB) UFS.
> 
> This is minimal support board device-tree.
>  * Serial console
>  * GPIO Key
>  * PWM FAN
> 
> [...]

Applied, thanks!

[2/4] arm64: dts: exynos: add minimal support for exynosautov920 sadk board
      https://git.kernel.org/krzk/linux/c/57de428eaca2b9af1a35df96c7adcad4b5ea79f9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

