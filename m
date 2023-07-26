Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F4C7634EE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjGZLaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjGZL34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:29:56 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D252D42
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:29:36 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51ff0e3d8c1so9455334a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690370966; x=1690975766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q/+qs7g1gY1JEPTRBZFLaASNIU4sFMJxs/L0tYvhMjY=;
        b=LMOTOExY/Ce2QY2Gt8va7AB1wsxRDCK59KI0IIXoXQ4umPJtpsNtQIaFxj0I79btPg
         /w+x3huP2IS7bkIy/8oyamDSwNo9DhuMf67w8IufA1znp8QofXt6EMKTUXFFaa28hWYv
         KrzNlThQEt3QLwH4NSd9cgucLag+9SvS1hr6112LjOrCQ7VrQGK62TSNo5amOQSf8Kt1
         PBBbIkJ3xci+fMPCxnswDal15zmHGeQsEgn6OEQOlhDaNTGJ/jpneDx+ZpQghYccJO4c
         rNnAfwE6jshbRiJNmXGjXYE1YWdyvGXIkkkTOYprxM6KGaJ7wTFhALdvJAUaTcJ9/+K4
         oj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690370966; x=1690975766;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/+qs7g1gY1JEPTRBZFLaASNIU4sFMJxs/L0tYvhMjY=;
        b=Loc5EQE28HW6UIG+HJG3YIRw7hfc74b1HKVnEPQrBhJOcyuyoWiRp7ugA28lMwoSOa
         K3wEJmSUn+/19NJ0G1vzg4eZ6TjPKRypML/AVWm9DvPY0luh8kEoIscubPl3jGbr3pth
         1pAKdViJJLjqKJRMETr+mmaVIbizAgBQJWN2owbJwD4RybMkEaZ5bruMbSJSPwkzNYsZ
         4udIqhJ7hfSdTBbVtqAUcPhjuHWLbyEFb8g68IUr5JW0W+oVcs2ejBRRmlwnhDbhl8VB
         fhE8Z/XfYOamIZ4U1G51VmIEBKey9DWH/pmfN0cV5RjD+5mPfNIkUkpAOMgRdFC2K42i
         GyLw==
X-Gm-Message-State: ABy/qLaA3X+/QOYAgrQ5Lp0E7yyMyM8WaaxrpWsezuMhcrmiOXxReTYk
        431pnMtoH3JUmpqg/Si/kp2UOg==
X-Google-Smtp-Source: APBJJlFXaiNUU2g8AEtAdBi80dzeE4xS5unNsLEWeVyMmrC1zd+jJ/UWtOksRH2QuqpxDrlxqiew1A==
X-Received: by 2002:aa7:d9c9:0:b0:522:4d16:752 with SMTP id v9-20020aa7d9c9000000b005224d160752mr1298800eds.21.1690370965884;
        Wed, 26 Jul 2023 04:29:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id g8-20020a056402114800b0051dd16f7e50sm8626244edw.44.2023.07.26.04.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 04:29:25 -0700 (PDT)
Message-ID: <43b4b62d-edea-c571-4f80-b0d4be78e527@linaro.org>
Date:   Wed, 26 Jul 2023 13:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v5 1/2] dt-bindings: display/msm: mdss-common: add
 memory-region property
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
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713165238.2814849-1-amit.pundir@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 18:52, Amit Pundir wrote:
> Add and document the reserved memory region property in the
> mdss-common schema.
> 
> For now (sdm845-db845c), it points to a framebuffer memory
> region reserved by the bootloader for splash screen.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

