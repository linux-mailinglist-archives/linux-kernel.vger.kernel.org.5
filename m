Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F4675C123
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjGUIRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbjGUIRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:17:05 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C3A2D60
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:17:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbab0d0b88so17155315e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689927421; x=1690532221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o6B+rnfSM0xcXsymXoRy0hO01EbexjC2r2BJi7Oh4Tg=;
        b=M3frvDxJ8Lx541wDYgYu/fFxid+iV9soVtPl2tef8QPqzhCKPM900nnmHqaOwD6yN4
         hoK39FKywAALhTAoI/g1FmjHG1lF4pe74P4zkqCICu1cEuGPBBb25wqDxqfgMT28HzAt
         4RbwizxZJBF865LH8V0OkV4jJWyQ3Dq7829KgzZ9+bIyYuxFZMIlcq1byFjsOzVrz6aa
         H52Gu7xyX/sGF8sns3uYqy5w0WjFijHb0xfBfuX/fKPDOohxostJgvAvx6Lih34JMPXk
         BFrn8GqdhHxK5b/E2EZmdr9wW4LqTldGxWCekV7WgksLAdQP1Z2ApBowwGHPDXp2D42j
         XwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689927421; x=1690532221;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6B+rnfSM0xcXsymXoRy0hO01EbexjC2r2BJi7Oh4Tg=;
        b=QMyEhNR3p6y+o8kJd7MSOfCk8UCjqKkY6H6oYtMnY3FZKy0AsxxCVQNpwAXTJxihdj
         rrKtUiyL4UeyQc8JO6Lp1CVAeUbyW5mK0Ufk1mysL7WoZ0ELQC00Hf7m8cZROm98bOPe
         2Yw9QSnRFGKc2KSwjBNt+GGuoUCjcv1R9OUblnl+kQPWVp+O4pnBp83c9+EYn1oMXI4K
         x+dy1dMRpZebGwa416EQNyNiSe1eW54EUP8VBTnio7G7fuNqgkcf3h6T/3P+G1ryngZa
         tu320IwuKCdukX41GtETf4Wcb31W7c9arGKSYLjkeTVgrCK4t5gdf2Y7Qe/IvYkcaC/Z
         VkRg==
X-Gm-Message-State: ABy/qLb7z++fgECwLXqpku/Rr2WqgwjZRWj+AnujpgydtCuVDs08EpWa
        HHjJpZChXl38S3713wjtQhe7Tw==
X-Google-Smtp-Source: APBJJlFUlwJlGXYQN9cg7lAdMveKlgbhYYK0b7nlHGwn3FLbMm3zs3wgdWU1pRTS5MnsuBi0I68UXA==
X-Received: by 2002:a5d:4eca:0:b0:314:2736:ba3e with SMTP id s10-20020a5d4eca000000b003142736ba3emr4614811wrv.3.1689927420908;
        Fri, 21 Jul 2023 01:17:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d6748000000b003143cb109d5sm3495784wrw.14.2023.07.21.01.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 01:17:00 -0700 (PDT)
Message-ID: <50b781c0-6800-84fc-1bfb-3f8831f728e0@linaro.org>
Date:   Fri, 21 Jul 2023 10:16:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: Add header file
 for Amlogic Meson-G12A SoCs
Content-Language: en-US
To:     Huqiang Qin <huqiang.qin@amlogic.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        linus.walleij@linaro.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20230721073214.1876417-1-huqiang.qin@amlogic.com>
 <20230721073214.1876417-2-huqiang.qin@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721073214.1876417-2-huqiang.qin@amlogic.com>
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

On 21/07/2023 09:32, Huqiang Qin wrote:
> Add a new dt-binding header that details the interrupt number of the GPIO.
> 
> Signed-off-by: Huqiang Qin <huqiang.qin@amlogic.com>
> ---
>  .../irq-meson-g12a-gpio.h                     | 126 ++++++++++++++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644 include/dt-bindings/interrupt-controller/irq-meson-g12a-gpio.h

Use compatible style as filename, so amlogic,meson-g12a-something-something.



Best regards,
Krzysztof

