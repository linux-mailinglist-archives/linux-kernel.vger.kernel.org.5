Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3295078DFE6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241597AbjH3TYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245266AbjH3O7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:59:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8632BAC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:59:29 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c93638322so209642766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693407568; x=1694012368; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7Pco8x0/hB6HILgwz4l+QxrVcbf7lyLFRRGNnwxfq1o=;
        b=DFnGUkMUdckJSEvk0DYjBHlb8SLhK5xwz45g0/PXDKt92rYsX967kXil3GFHjAIncX
         6veCSWzBivI3w4C9x3sBULE0bVvr0EFcdbdGQkugCZQbx8z7zDzhMKmohFVqNfqCNmZj
         3BmdkQU3ZjOdVoFN3O4vVSgaMrGw7rY+5b2ynN0Z7WdeIjgaDHqfMScTuqi2k+ZzRi3a
         wttkveX/suTN43/PcDz0ORMUlWCMIrAf+b/8tQrclU28gfNlVEt1CSkRLJt92B2oJXIY
         iA6//A5zkk8q9k1JywjKBeTX+hhXAEiN5gKt0c4Qwc79wggMeAY00sHaSQmFJknEYM1c
         WuYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693407568; x=1694012368;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Pco8x0/hB6HILgwz4l+QxrVcbf7lyLFRRGNnwxfq1o=;
        b=hGAbBzeHR+wpZY2ID5NDr4NNbPjqfzGe0ZXCPjE52yntGamVaKuOh2ki42NQEVc9oj
         7fw0Tbvb88JHB0lrGQvf4vQ/YF8pGXEoD/NA4uujG/5YlfHOEtfZHep5iGf7FbT+4/bf
         5d3ck/CJUP0xNC9PfXNxiYiD2fEZi0GYthkBYKVtLv/6JOjL5zx/KlN2IwrttEISodO2
         l4noFw70pcrkJnxl88jZdoj/h+Uk/FzOEFU/3OV1gumLNxvGK1pwYADjoE6PG+D91KPC
         WyZ88ClE8HF7mZneCyw3fx4xrBjpR43f86h2KUbOqIStgpBcHVDJFepPxidNBIF2OINM
         Ecmw==
X-Gm-Message-State: AOJu0YxGWb8aYFAbwAbkoETukAN52q1OS7nyqsRLjJr1pop69eYX8KgW
        tiVtj11baFNoR8LVLYj1WGLCCQ==
X-Google-Smtp-Source: AGHT+IHETt+a5mNQcfbBOmCAbA2hvQdIyYaQzqqvLslZC+7ZinOVUto65zFfrT5R8AQJ/hYEOPcVPQ==
X-Received: by 2002:a17:906:518a:b0:9a2:295a:9bbc with SMTP id y10-20020a170906518a00b009a2295a9bbcmr2363706ejk.37.1693407568044;
        Wed, 30 Aug 2023 07:59:28 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id qm15-20020a170907674f00b0099290e2c163sm7209415ejc.204.2023.08.30.07.59.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 07:59:27 -0700 (PDT)
Message-ID: <6d124ccd-97d9-d431-0350-fa1445da62b2@linaro.org>
Date:   Wed, 30 Aug 2023 16:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] dt-bindings: mfd: stericsson,db8500-prcmu: Spelling
 s/Cortex A-/Cortex-A/
Content-Language: en-US
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0789000f012122a7fa27ef709c738101b00cd834.1693407196.git.geert+renesas@glider.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <0789000f012122a7fa27ef709c738101b00cd834.1693407196.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 16:53, Geert Uytterhoeven wrote:
> Fix a misspelling of "Cortex-A9".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/mfd/stericsson,db8500-prcmu.yaml        | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

