Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC2A7AC7C6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 13:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjIXLlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 07:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXLld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 07:41:33 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED87103
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 04:41:26 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so5472070a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 04:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695555685; x=1696160485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmGyCBQAHmjeBS0vkEvgn/fb8DOR1oVjNQmbaMrjvLU=;
        b=Mv4+2JfPZsZBM+49lzb4pjYK2eAjyiol4TgzHPbIRFKx2/LYg6Vg6AsPQ1mYC9fxAS
         wjjKKMIYMKKhjl+0Of7hgOO7pTBy4FGWNh/7rUFNQCxO7MZTal9Brq+OKvIx8usbahQT
         qtD0dNxsrYIxawRr4Qyk5AfCkkXPCBs6P9rWohgjO0xr3uhvgIKpQ2Wxi+hg3Ff0Joks
         iVSHeKvqdI6ol8c+SQ63DtfmmtOfpsItvYqEykWIomop5bAYMKLYumUsFTWtG5xVc5Za
         rhWpU/LEOljT/CQsb/hVXmwnOWsOUK8YWIMMrkKW0PSChD99HEARNJga5tsXP+7IDdZT
         coxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695555685; x=1696160485;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DmGyCBQAHmjeBS0vkEvgn/fb8DOR1oVjNQmbaMrjvLU=;
        b=VwGFcJdzfLwi9Bw6N+WfTYH4AqSP8I2dSoXM2iWCwm0BMqFCq03xkn8u+qRgUgSPUW
         hSUtcCMKMyc2SDhbNKs42M3t3YYLSTJZ3FycsLlhfBseEJtgWsHSGadi7LvSizXjJx04
         +ishFkt0jfvbeFZoP8SNcQGIaXZmHxdrnuN5pGWeDjvsEKG6LB3nDL4nR/C7Ie6v1qih
         RQWOoaQjoTyUGau83mgGRc2bU9YyzWPEFzrT3RDn3/b5AUtYhy7f7TtU2B5w1qAsk6kN
         xb/OAttRNaNEFjW4lm3hkTVm5THKnhZv90Ie5HNiIl77Edu3urVbMEpIX/fuGNjiqapH
         xk2g==
X-Gm-Message-State: AOJu0YyTrsA5TnAQ+dpoIUSRsl8uKRZlOrmT/HbNtT5Uv1ZBN9ZGaTHk
        +4Z3pXlQooVWWIZX5HYld17plw==
X-Google-Smtp-Source: AGHT+IHBpebMWCos5SP2RTVgowZ15+1Skx7BLOxMnh6TQpWwE2B07iMmUPw8+UnB8MbybOCT8dj8eg==
X-Received: by 2002:aa7:c741:0:b0:533:5c03:5fce with SMTP id c1-20020aa7c741000000b005335c035fcemr3479696eds.5.1695555684782;
        Sun, 24 Sep 2023 04:41:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id w25-20020aa7d299000000b005329f1aa071sm4265405edq.10.2023.09.24.04.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 04:41:24 -0700 (PDT)
Message-ID: <b3813a4e-3956-254c-a7cf-0fca65dc2cdd@linaro.org>
Date:   Sun, 24 Sep 2023 13:41:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: ERR_PTR(0) in a couple of places
To:     "Dr. David Alan Gilbert" <dave@treblig.org>,
        matthew.brost@intel.com, mgreer@animalcreek.com
Cc:     linux-kernel@vger.kernel.org, airlied@gmail.com,
        intel-gfx@lists.freedesktop.org
References: <ZQ+Fo9WKyGphwI8R@gallifrey>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZQ+Fo9WKyGphwI8R@gallifrey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2023 02:41, Dr. David Alan Gilbert wrote:
> Hi,
>   I randomly noticed there are a couple of places in the kernel that
> do
>    ERR_PTR(0);
> 
> and thought that was odd - shouldn't those just be NULL's ?
> 
> 1) i915
>   drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c : 47
> 
>     if (i <= 1)
>       return ERR_PTR(0);
> 
>   from f9d72092cb490 
> 
> 2) trf7970a
>   drivers/nfc/trf7970a.c : 896
> 
>       trf->ignore_timeout =
>          !cancel_delayed_work(&trf->timeout_work);
>       trf->rx_skb = ERR_PTR(0);

I would guess that code is relying on rx_skb being valid pointer or ERR
(if (!IS_ERR(...))).

Best regards,
Krzysztof

