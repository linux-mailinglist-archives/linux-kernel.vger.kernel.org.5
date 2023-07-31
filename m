Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A48769AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjGaPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjGaPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:18:04 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA351703
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:18:02 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so7295653e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690816681; x=1691421481;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EHSZTqhdf12dvB2wCgIzNCUIZxw+5/2MGAB0jSuGq8=;
        b=TFLn7IUo8sDEb9ZgZCvceFM2KDMIn76Uv8sUYkDw5frYLNLQc0b93ePY9CM63UbQ7w
         btp5G5tL4zsajz75UlAq9MzUALhNOOUJ+DwWBj8z06geNCMGHO+QxTLgJ067tm+xd2yo
         yUEOfm+1X3fXXDKFiOOVpUqI+g/cT4k9bC2g3GynV5sPzLNJS4wlkc82QY0saCbnQPNt
         eSP1ZKaO8qUxUsejufE/eLhzjIKNMe40dq4QVC2DVmkBPlm0tunF63m8Ldu2NP780u4g
         1EK8BwqCw4DWhExaf//dOOMCknhQEGhv5TOfimrqx3UdUIsLwmcqDI0KPftzz9m1HBzS
         U79g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690816681; x=1691421481;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EHSZTqhdf12dvB2wCgIzNCUIZxw+5/2MGAB0jSuGq8=;
        b=l3iX+E59dJA5v25DBksz3E8ple0806eV98btBcTwNoQ93Kpm6WfFr60Bahr1rdoT6m
         Iy5KtqimDgQeZjkkfOubQR9sE5wgDFL6zM+//Bq/jnj6/gpx8letIJpwBNTHV2OfXzTX
         7HLqZyoNhp27rd/Cq27X6UQxW/7DMwus45mkS2prLhuGx63GgVNhceeYEdPteIGVkPrO
         /kzV12mn8dydikdPvwhzIW5lcwa87eFYAO+hLZn6v6Q/PfLhtzPz9WAPEXM/cxqfIKE6
         jao3h/1ScfZWhqTMlwpJbCGzwC4Kjjmkte6+TmSFV+4yYxSGFDj/B0X5M2TCnJbRnTPz
         2hMw==
X-Gm-Message-State: ABy/qLZM9PeekUiLBRfm+oib55pE4X8rsryxigHwFHFBgbAvC4oElkjD
        SAtgJJLJZOlb7r+dP7o2sONnCQ==
X-Google-Smtp-Source: APBJJlGdf4mBViLU9DywMnYgAiIENEFp5pjsZyncw/WX9zB7lUGTOD1GKie2/DFw+s4Ej6NjVqVX/w==
X-Received: by 2002:ac2:58c8:0:b0:4fb:978e:95b8 with SMTP id u8-20020ac258c8000000b004fb978e95b8mr80421lfo.59.1690816681109;
        Mon, 31 Jul 2023 08:18:01 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id w16-20020a50fa90000000b0052275deb475sm5568560edr.23.2023.07.31.08.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 08:18:00 -0700 (PDT)
Message-ID: <defe7fb9-37b0-df31-9e66-0a126a865813@linaro.org>
Date:   Mon, 31 Jul 2023 17:17:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2] dt-bindings: iio: admv1014: make all regs required
Content-Language: en-US
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731144404.389255-1-antoniu.miclaus@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731144404.389255-1-antoniu.miclaus@analog.com>
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

On 31/07/2023 16:44, Antoniu Miclaus wrote:
> Make the regulators required in the dt bindings.
> 
> Despite the fact that the datasheet is not explicit enough, all the
> specifications of the part are built around these pins being supplied.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

