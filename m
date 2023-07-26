Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BC4762E60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232333AbjGZHpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjGZHpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:45:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F5235AA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:40:21 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fe04882c66so2656318e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690357220; x=1690962020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MrGrHnQrbIoFamYjn9058MR5lLvFefPovOxE0StWjvc=;
        b=V98cul3aoo4cXu4BqviS2YiVMNEUs01YyPhv3FmsvFgvIDqurdOV10G4Rv2VAPm+uc
         VStsCYJmKA0mfai2zwWIpd9m7cKBlz1a3X7khSZDWsKYAjenMmUX62mBdhOHE+DamTl9
         1E8QXTNWDGeZBsO4kih5e2WF8xcGKTii3YgYsOPRmaW8VyhHJM914trdHEiUFVIeBOFe
         m3H7JSu9uM9XPmTVm23XsZQMK16Loz/esMMsoVl7JGquBltpTFS293x0lESRsIR8RTj+
         KjE1iTJqj4kOMIks3GyOrYl1QV+nWKH5Ts5Z1Djvdz0xOWdms1+lqHXWiT/t11yNGXHu
         sQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690357220; x=1690962020;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MrGrHnQrbIoFamYjn9058MR5lLvFefPovOxE0StWjvc=;
        b=je/GRqI5Hpa4XH0CFM7pU6IVvqleLWwR2M3rmz7iE+Ak/jFdbc79ncBqZb2FWXask3
         HWBcEINrCZdjhkU3rZlhq7ZPRsoKQ26gFDeHcaV4R0zn0mugB1p36QiBEvnNDsSw5f7m
         OY14ZiYOhALbs+d06zElzxjid/VzWhNKqvkLDBbnb1DxbwnH2jRxma1Hn6X3pLMg2TXp
         8GsP2PQV4kY3jaY4r70G4iThPOBUM4fPxQuYgdA2HlPW19MM1sQ7fO2431c+18py5A6O
         WLDdf+WpEIatV8+yGAaDZG9Chd9h7vz0trey8UB8/TSeet3JhZQyPuUwsZxoTll1xfaA
         3oQw==
X-Gm-Message-State: ABy/qLbZ+OL/WcBHb4FbDumsTAP60X76CitUEv6uE7QEm4C+BbNkOg4A
        yMuBuqGuGPgaUg+OpR4rABlCXQ==
X-Google-Smtp-Source: APBJJlFCf7TN7XhSdBYPnYX0V2XVHlZhqjPtFmbgmR5I177m4djgceEOcb1GY+XoNMQT8voTP7xerA==
X-Received: by 2002:a05:6512:3286:b0:4fe:c6c:ac95 with SMTP id p6-20020a056512328600b004fe0c6cac95mr836470lfe.35.1690357220056;
        Wed, 26 Jul 2023 00:40:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k6-20020a056402048600b0051bfc85afaasm8429075edv.86.2023.07.26.00.40.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 00:40:19 -0700 (PDT)
Message-ID: <312a2e60-efc0-855b-e33b-a1ec8411d595@linaro.org>
Date:   Wed, 26 Jul 2023 09:40:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: add uart13 node
Content-Language: en-US
To:     qaz6750 lzy <qaz6750@outlook.com>, andersson@kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <SY7P282MB37870BD990E8EB855A735E15B203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SY7P282MB37870BD990E8EB855A735E15B203A@SY7P282MB3787.AUSP282.PROD.OUTLOOK.COM>
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

On 25/07/2023 09:22, qaz6750 lzy wrote:
> Bluetooth on SM8150 requires uart13
> 
> Signed-off-by: qaz6750 lzy <qaz6750@outlook.com>

Not much improved here. We talked about this, sorry.

Best regards,
Krzysztof

