Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2687875BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239394AbjHXQmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236768AbjHXQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:41:50 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB0A1FC3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:41:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-991c786369cso933011966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692895284; x=1693500084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0FS7EMFMBMQsa9I3u4Ml+77nFwK7hyqXErIxoUJnqC0=;
        b=X0DN9LnAboT/3gx1J+Zds4OhktoyfAeJD8iTd6M/fgKPT6287EoXGlW8fFNIfHZcXa
         wXhNDXqpbszGLJyHYuilg/P0tcUTs+VZkSXfzrKofd0E6Up0V534lvzaBx7Ga/blUol4
         Bf9hgCXKulKGIvzssb+BjpfAIA6rcr1NSq6Y+3BTYC2QFuDUULVoBepILOUeE3mUxbuq
         InJo7gxcayRrzfu4IFM8OupZhZaIjV0DXrWm+HKChVHIV5Wtw2ttRLj/lJNeFloYyiH6
         XsnGE1EQuovXLp814r1Te9bngN2Z/X37fi8uohIqrtFwaN3cf2VvbKAe3c+G6bWKPGi9
         Jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692895284; x=1693500084;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0FS7EMFMBMQsa9I3u4Ml+77nFwK7hyqXErIxoUJnqC0=;
        b=VOqFVYr4UDe+EHXFCnx6kSI/OT3Uuul70US5eTpYjxdMW5dof4b9glDRAliI8veVnv
         KyMP8qYsW6TMtE4rhY/6gKmL7UijGykC/pMvkmeRMq/6Bf6tj3EBEzLlzNyoLqB26xa1
         d8aGQIP9CNiwLlpdzRQ8jXn1tQ4N+kMd6s8Mx77/RvIelJ/oE5ePHC/WJ85FyLVQhCxp
         Hfa2tpAp6F88aFSQJV3/4Eh0UGna6tN7kT8s50ExzFQa8i+/Y4fdDR2HlJhzfpk+JsYv
         Iy5SO58HWrIzHOfsByYOntgnkqk/0I6lEdC3pXgpRfdc+/Qu0fasO+FWXcJv37J7iCVm
         ZWEQ==
X-Gm-Message-State: AOJu0Yyqbuca5wK3VaHZxMQHwNwysZxXaoJElnjRjmQxJYPJBV7FizOJ
        WVKEC8k+WCjLkzuGXaK2ig7Ong==
X-Google-Smtp-Source: AGHT+IFNDVZV8EP0tO0tc1x5A4DMe/DGuNQHRROlfMng9ccWPr0BEmNVEmkQRSSovqIKaayywtoCVw==
X-Received: by 2002:a17:906:31c1:b0:99c:fb44:d4b6 with SMTP id f1-20020a17090631c100b0099cfb44d4b6mr11640073ejf.62.1692895284201;
        Thu, 24 Aug 2023 09:41:24 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id kf18-20020a17090776d200b0098748422178sm11086669ejc.56.2023.08.24.09.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 09:41:23 -0700 (PDT)
Message-ID: <79c6a70b-47f1-b625-46a5-617b895ded91@linaro.org>
Date:   Thu, 24 Aug 2023 18:41:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3] dt-bindings: irqchip: convert st,stih407-irq-syscfg to
 DT schema
Content-Language: en-US
To:     =?UTF-8?Q?Rapha=c3=abl_Gallais-Pou?= <rgallaispou@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20230823224453.126963-1-rgallaispou@gmail.com>
 <20230824134828.GA683810-robh@kernel.org>
 <530e8caf-a7ad-4c82-ab1b-58b728770703@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <530e8caf-a7ad-4c82-ab1b-58b728770703@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 18:32, Raphaël Gallais-Pou wrote:
>>> +  st,invert-ext:
>>> +    description: External IRQs can be inverted at will. This property inverts
>>> +      these IRQs using bitwise logic.
>>
>> So this is a mask?
> 
> Of course, I did not had clarity given the hour I sent this, but it is 
> indeed a bitmask.
>>
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 1, 2, 4]
>>
>> If so, then this is wrong if you want to set more than 1 bit.
> So knowing this is a mask, it can take any integer between 1 and 4 in 
> our case.

No, 1 + 4 = 5. *more than 1 bit*

Best regards,
Krzysztof

