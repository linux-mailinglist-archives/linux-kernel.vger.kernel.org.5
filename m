Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB17775AAF1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjGTJf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjGTJfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:35:40 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760792717
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:30:54 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5216f44d881so717943a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689845368; x=1692437368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9v/NyCrI4EzkDt9EAmshDvGJM2CpilgtcwKIHXzlEGk=;
        b=cm3sk9kXEPgW3mYvIJKWgHIbyXxBIyeP2GTzXYpaMPjDpJ/uaI7lCU6PWmZxS7v1s0
         E8o0r8kOa3X0Iz1hpieE0ahN498wbAqczIEOvz0eyVNLLW0vboO74MPckWNaYGTBffGx
         x6NFgB6TCeNxzODYAuCKMAlymb9r7XrFQ6QDOfs4x2gnmnZpuC/FHgE1u6mX4XjNt1jo
         BdTvidWmBY0iisUGw4ge4LkJRAHcTIQjyFTZRTIncfeMUYZUAZmMMwmAl2wgfiyDULXy
         5RILXJ+CzsEZ4gwj0nF783r+dn7Mt/nYVi/4Ih0gXIx/PGL0n8c9LL3Y+xp1pWj/58YZ
         L3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689845368; x=1692437368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9v/NyCrI4EzkDt9EAmshDvGJM2CpilgtcwKIHXzlEGk=;
        b=CDzxSWXAP7oOuqrdQV/480DoD/XeTdwyJAb6DZNkGKXTgub8ollaUtawfy+UUzExU6
         V4vymSV3ISlVS3T7WJKvMvKON/8DAn4NC9RPiWgR6sBOMygIiOUh0Vy1/rmk6qywuSn0
         WQ8p6PTYI9emcC0E4pJk+o5BQAVnYvfZUWLw0Z9s6Uri3qGI5R1GYBgbJrlmuvbOpsYE
         8W4EsXBxa2T7LmbL57NOPyN5zNtjiLa+sctirtK2vQLPUnDWGwVN+G1bReJpljhOh57S
         iumiXkiL+GUcGgxg3iQ2STOIwoq60DYP9hbWsPJeT+hz8hTE/mYrnPzFcHaMvDdA4xv9
         8WRw==
X-Gm-Message-State: ABy/qLYs1Aoi6r7YuTOzBRazufUmJEJhbjjDPMUTT2QGC5sTvWwahVCW
        6qfGUB3co5SWeqoTQ9XxuFf+nA==
X-Google-Smtp-Source: APBJJlEEj98eLgSZMkjuQISPkfJD8TekAKb3FPjOs8P62kj4VtSlkNTRHhSJ/x9oW5axUArfoycKKg==
X-Received: by 2002:aa7:c309:0:b0:51d:d4c0:eea5 with SMTP id l9-20020aa7c309000000b0051dd4c0eea5mr3670330edq.40.1689845367972;
        Thu, 20 Jul 2023 02:29:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7cb51000000b005217a24addbsm481875edt.20.2023.07.20.02.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 02:29:27 -0700 (PDT)
Message-ID: <2d3f49f1-1bd4-45ec-8bdf-2d76d338a384@linaro.org>
Date:   Thu, 20 Jul 2023 11:29:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] ARM: s5pv210: Explicitly include correct DT includes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230717225446.3211738-1-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717225446.3211738-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/07/2023 00:54, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it was merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.

Your SoB is missing.

Best regards,
Krzysztof

