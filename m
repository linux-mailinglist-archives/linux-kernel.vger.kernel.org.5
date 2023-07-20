Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BA875B108
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231204AbjGTORi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGTORf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:17:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4AE2115
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:17:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98377c5d53eso147454066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 07:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689862650; x=1690467450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VupXp4erLaqfqQ+loiFYyUWWghT8xN1pvNk3qFGN7C8=;
        b=Hh2HdquZCYStqAQgY8iZx674bho0t6xJvrOyOWVNpSeic/e8C9r15smbpj5Ui/9guY
         cQVKBO8qkMd3C6jEEe3xJrGbpB+MpME4wJn7c9E4xCer/eKjGeE1a6kdUxPqyh3JiVb5
         7jTQCK5gADSC1YqSINaBfBxivgshg8kMLadC91XwjH0sQE6drrOniaKPPSJ9JTZlXKPC
         XOE6GpTpbRsrDu/535KpBTT9hhswFlMCxzbYNm91WQOpIkqlfSWlFwLxRa2qblFuQTlG
         4+Rs5hKRCvxYJz1Oi5XxlWkiyNQdBrNDMYjZ4pVrinFvoPNAyys+Cxh9QCQD5OuPuQpv
         IwoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689862650; x=1690467450;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VupXp4erLaqfqQ+loiFYyUWWghT8xN1pvNk3qFGN7C8=;
        b=OmlMHqf1Gpliwzm5lmaJjlubz/WFtgoogP2h2mnBI9zhZ0/+z3kYys7xK9tA2bV9Vz
         gcIlqvgsJQGlYY/AW5QkR3rejUCTuPNDcw24FxUnY83VxOpDPHHYNgnw/30JGj+zq6MI
         rhwX4l6Yq7YGSrghSw6Bv6wdCs7zB5IgRpEfq9DgkMKR3IqFYNrY5O5A/hevJ2AjBhba
         crh5hjLCs/iIcW9gASJuH/fAPDBcZCvJTtKwOZPR65hcf3JvIpclsr99UNhF4V8ZDpZd
         2Z5Wgs1GcaFv/I4vDS2v0tGx1neawo2FJbi+dZzAX52RS0cYLxEBm76Nmq3+c6qF4Aay
         Vukg==
X-Gm-Message-State: ABy/qLZOzJEYLV6I5AdnvpeplQTMQgvZ3rQ9p+lEJrRikEvqwt8z65ro
        VHfNA/g9YQGN1nJsJRfMSrRLyg==
X-Google-Smtp-Source: APBJJlGpx17dZ12AqvgDgT+/UIkUYpcozL86tSBoeS4cZIXvvrl4E8ocJ7uuSqOVM+f5qNcijmR7Sw==
X-Received: by 2002:a17:906:20dc:b0:99b:4956:e4e3 with SMTP id c28-20020a17090620dc00b0099b4956e4e3mr2455545ejc.8.1689862650321;
        Thu, 20 Jul 2023 07:17:30 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k17-20020a170906681100b00997d7aa59fasm788516ejr.14.2023.07.20.07.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 07:17:29 -0700 (PDT)
Message-ID: <05b63869-4427-f207-5896-307f56f5c9fc@linaro.org>
Date:   Thu, 20 Jul 2023 16:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: next: arm: dtbs/exynos4212-tab3-3g8.dts', needed by
 '__dtbs_install'.
To:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Artur Weber <aweber.kernel@gmail.com>
References: <CA+G9fYsfziBmQGQMGAKojhemCXssFyiNgk6aNjVXpJNNFh_5mg@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CA+G9fYsfziBmQGQMGAKojhemCXssFyiNgk6aNjVXpJNNFh_5mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 16:13, Naresh Kamboju wrote:
> Following build errors noticed while making dtbs_install for arm on
> Linux next-20230720 tag.
> 
> Regressions found on arm:
> 
>  - build/gcc-12-exynos_defconfig
>  - build/gcc-8-exynos_defconfig
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> make[4]: *** No rule to make target
> '/home/tuxbuild/.cache/tuxmake/builds/1/build/dtbsinstall/dtbs/exynos4212-tab3-3g8.dts',
> needed by '__dtbs_install'.
> make[4]: *** No rule to make target
> '/home/tuxbuild/.cache/tuxmake/builds/1/build/dtbsinstall/dtbs/exynos4212-tab3-lte8.dts',
> needed by '__dtbs_install'.
> make[4]: *** No rule to make target
> '/home/tuxbuild/.cache/tuxmake/builds/1/build/dtbsinstall/dtbs/exynos4212-tab3-wifi8.dts',
> needed by '__dtbs_install'.
> make[4]: Target '__dtbs_install' not remade because of errors.

Thanks, sent a fix:
https://lore.kernel.org/linux-arm-kernel/20230720141537.188869-1-krzysztof.kozlowski@linaro.org/T/#u

Best regards,
Krzysztof

