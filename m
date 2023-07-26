Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66D27634F5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjGZLaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbjGZLaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:30:07 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE219AF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:30:01 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-52227884855so5700990a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690370999; x=1690975799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=onPbV8Yv+Ue98mrxtxqkTtpVYJaOzehqj+NNEv4BhAY=;
        b=T5Oly7FluqjUGaa3lMgD/oPQ2J+nYChOgoHh0jYspY5uXfnE5MYT68UsCB3SjoGnFQ
         FppOWSh1MMLtLlGVIhLDk80CzltGf8n0bY7LbZRLYLaCBZDOqOZ1HtmVYMQnHzseWQzX
         v4w1WbDM/bozmL701yPTBbu6Ixc2TBHPJdHGhfqc6T9O1T/Qa1N43ddjF25ap/TZnj7y
         5hk3yJUQlIFxnRWT4FNF242L13jbB7r1iEGB5w+kTDi/te5hlCGLKFxTkNjC23DSJdfA
         6gRlLeuyAOh7mpG+mGiCeuxaWY71tVSERdRQ3u6jpvurjUHVpuwxU1y8CbGt9pDVVYYi
         QpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690370999; x=1690975799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=onPbV8Yv+Ue98mrxtxqkTtpVYJaOzehqj+NNEv4BhAY=;
        b=lCys2XSV1vF/lkClPZH0NZsgbxbqy/DmLHeSqr+7hBECGQ/hB4jLcl8LxcYU0GdmRx
         BGJh34rjCPvezX3C6YkOAqZtFv5TQAy6fTx3Z8ZU+hyejEmaI3+mV0vcr7HsJPs2Bd4B
         hdo8abbWZ3UxKO7ENBhzqsNVqK+i+9xQU0OKEPHVZ+61QVYkgXwaW8+kGiNfZHGGiU/z
         y8EjxbeGyszZsjGGaYG2+YMr/b0LEUm7uqvjgMqysJVrib2koHe1Oqsb4hxwaK/h7zJ0
         gCDY4pX0+LFXRGlGEBpYTHSFciniMlFeOb491O4BVGNsSqU35T6HseNq7W5fEE9BplcZ
         e0kQ==
X-Gm-Message-State: ABy/qLb2q/cWI3UWWBAWpsTFIge//U+/b9+vYQxX9rSNkIUhSw4ke2wV
        +vRNQ1U0OGg35n0kQ2duX6zVzw==
X-Google-Smtp-Source: APBJJlGhsZALbMTZop+J6WRH+YKEaAOscUT56bRny+XG/qT9JQFYAWirvKrTQSzu9bEF7f9tZf78gw==
X-Received: by 2002:aa7:dcca:0:b0:522:4de8:f3e2 with SMTP id w10-20020aa7dcca000000b005224de8f3e2mr1563220edu.22.1690370999558;
        Wed, 26 Jul 2023 04:29:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id b9-20020aa7c6c9000000b0051d9ee1c9d3sm8686862eds.84.2023.07.26.04.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 04:29:58 -0700 (PDT)
Message-ID: <3ef4f91f-0afd-0246-4f8a-210aedb0b94c@linaro.org>
Date:   Wed, 26 Jul 2023 13:29:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 2/2] arm64: dts: qcom: sdm845-db845c: Mark cont splash
 memory region as reserved
Content-Language: en-US
To:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230713165238.2814849-1-amit.pundir@linaro.org>
 <20230713165238.2814849-2-amit.pundir@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713165238.2814849-2-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 18:52, Amit Pundir wrote:
> Adding a reserved memory region for the framebuffer memory
> (the splash memory region set up by the bootloader).
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---

I think your commit msg misses describing the actual problem, impact to
users and finally cc-stable.

Best regards,
Krzysztof

