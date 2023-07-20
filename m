Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C65C75B25C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGTPVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjGTPVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:21:21 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E552106;
        Thu, 20 Jul 2023 08:21:19 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso1511455e87.0;
        Thu, 20 Jul 2023 08:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689866478; x=1690471278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mnTujjggntaI1TmQTK0d3ossyVsbJfJshYOQ8cji1+g=;
        b=eYBY+0MqJpx4ADKrFOk20ov8zksVoswb1FqL1JkrQQJZQaZOVmbjDDRE5iv/ob6b2T
         TdZWg67WnIqEawluTRPPIMqogMLvCN76xbJPFjb8HrLO/Kaa6A+3kf6Bg8WoTGY0AxbS
         R1YAvfGwIRPkt/FuIXqwk8KQe1h7vT8q79SI481RZwXa+AqjKPFo5ZCCUlfHnACnBmI5
         NPewOhfrPnjFMnsrsdnqrmIY6Cmi71opkivYrRbSsqkT0wLbc9pUtaPdvv6Lf3dYYRI3
         b1mrv/1La9liZXsjVVVj2f/PMa6krpXBegrcHr71TmRRlmDYyfq4r4Z7MTEuYV4+tgZw
         8StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689866478; x=1690471278;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mnTujjggntaI1TmQTK0d3ossyVsbJfJshYOQ8cji1+g=;
        b=ataJXJTk4wRq8NzapUGVdmEcT9pfs/Melo8+rKePqM7kmuTG62j2EHM1LVrb7pDE9Z
         DMG4WKg7/yi78QH79yyVhcBbZH2oW3fKFUgk+CKxde1tpvtWT5r3GFcFuhSGBZfJSasd
         yTisHi7k4J6TF3gyS26NU0seWaSe79rQ0G0Od6+qHASGy9JRVkEw35nw5EHPKdKLO6nm
         Wl22L+l4LodhAnG8GYaYiepT8yZclhUblxV6tYh5qsyHEEUJUdIjx6yCEBOFYYFiEyLH
         btIc+pYvJ6BnPa+qeTfoYf1EvQN+d+uJ/aKQOoZ/5vNVvObjLmuKIAqmjWxAXTq/FIrO
         gKHg==
X-Gm-Message-State: ABy/qLbb/9JjGPjKikkHy0WEwHptJ3pCGzEfAnZjlXWuUsSnAb7Wf+Ac
        tzKb3qJ8+MRwL1PMb9SB80s=
X-Google-Smtp-Source: APBJJlEfv0/EHwJ7NV0K3JdyPsHFLdZdxhd9iuy4QjFGZdqWyjzfXmKeb9j6SF3A7f84ceZcyrxLRA==
X-Received: by 2002:a05:6512:368c:b0:4fb:85ad:b6e2 with SMTP id d12-20020a056512368c00b004fb85adb6e2mr2176714lfs.50.1689866477781;
        Thu, 20 Jul 2023 08:21:17 -0700 (PDT)
Received: from [192.168.0.34] (031011148015.gdynia.vectranet.pl. [31.11.148.15])
        by smtp.gmail.com with ESMTPSA id k24-20020ac24578000000b004fb7be56ff0sm246450lfm.292.2023.07.20.08.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 08:21:17 -0700 (PDT)
Message-ID: <bc13797b-d3b1-ac3a-5c87-16ca42e99138@gmail.com>
Date:   Thu, 20 Jul 2023 17:21:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: samsung: fix Exynos4212 Tab3 makefile entries
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linux Kernel Functional Testing <lkft@linaro.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
References: <20230720141537.188869-1-krzysztof.kozlowski@linaro.org>
From:   Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <20230720141537.188869-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.2023 16:15, Krzysztof Kozlowski wrote:
> Makefile targets are DTB, not DTS.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Closes: https://lore.kernel.org/linux-arm-kernel/CA+G9fYsfziBmQGQMGAKojhemCXssFyiNgk6aNjVXpJNNFh_5mg@mail.gmail.com/
> Fixes: ee37a457af1d ("ARM: dts: exynos: Add Samsung Galaxy Tab 3 8.0 boards")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm/boot/dts/samsung/Makefile | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Artur Weber <aweber.kernel@gmail.com>

Best regards
Artur
