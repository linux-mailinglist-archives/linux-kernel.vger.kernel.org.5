Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15C27686F3
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 20:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjG3R7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjG3R7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:59:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B852133
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:59:51 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso5969184a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690739990; x=1691344790;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FSJqbfGxSZx2i5RNr9G8wPRqJiZZNE7sCK3iaL/cj9c=;
        b=UEQK+/H6QGddS09OZfyK5ujBTp3390temPIpEXmA4uvFc539be2qZnSMxdye34d4BW
         TtAmPbw+T2A0d2g9oOUxapzumGffqnnNJwRWxPK1nocjL+PvtraJZCETCSHjouJR2out
         /JB9304SQ2cLEPzGVYp4ePBxzq3ve5SuI8l1lKXU5wJNd6ePGT1hGVzxn0oY0VxAp2cz
         93eMdScLUeV7z6qPxvGLrIOoAic0LDfsd29Q2e6g7uLou1EAQftHnLQD21I3t1SHpxWf
         W12VAvcx2zwngZX6H+SviNX2AXRJtfDnh6fTCua5r1EiKVjNQl5YTLldZH3ZhzAeCYJv
         Y8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690739990; x=1691344790;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FSJqbfGxSZx2i5RNr9G8wPRqJiZZNE7sCK3iaL/cj9c=;
        b=ZXsh1XWBPxNUbdVnUBqchuEl86+u5JgQ+WGKO3OEQNuKTBMgUNKIPaxVvWMAR6gp5/
         ucW8+vyBiQ+kWKWZJG4yzSnioZK7Dy2Y1I9cX05hCIrXRs80pFFen4zrmPKCuvKYArSQ
         +IXVS3DtIkdyTNUE5VOx/xLEZw37tG4zTqViEeulLql307LIFe63X80CbRkDi56xgjQU
         aID083lsrudGun6xlHWpP5Pqh/NZTKDTONP0TEzdmoOdPwfhyg7Pqac0XOkjNomu8DNN
         RMI7P0HjjI4SSKZxbwKXV6wNOoHWFhpng6HxxkmsEpwAYAyhTBRzGtW7FQirmE+Gs1Vn
         Yzcg==
X-Gm-Message-State: ABy/qLYiGACLYipDvqjHBMHBPmFADrnpd7DyIyo0ng5zUGZjLqYa8d0C
        kjOSEdcjXMRyIAKx44+LeTFxtw==
X-Google-Smtp-Source: APBJJlGuuhpUzQK9aJWzdzJjIAbCdUFoEoexku10QfUbate8to98hDRjqKN9sK0ziuh9fO+4uC13Cw==
X-Received: by 2002:aa7:c9c9:0:b0:522:bff2:dd20 with SMTP id i9-20020aa7c9c9000000b00522bff2dd20mr2072533edt.13.1690739989992;
        Sun, 30 Jul 2023 10:59:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id y23-20020aa7c257000000b005226f281bc5sm4352411edo.25.2023.07.30.10.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 10:59:49 -0700 (PDT)
Message-ID: <a0d10d92-f0e2-7299-96d6-c2575240830b@linaro.org>
Date:   Sun, 30 Jul 2023 19:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] arm64: dts: qcom: use defines for interrupts
Content-Language: en-US
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230730112024.120903-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230730112024.120903-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2023 13:20, Krzysztof Kozlowski wrote:
> Replace hard-coded interrupt parts (GIC, flags) with standard defines
> for readability.  No changes in resulting DTBs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8939.dtsi |  2 +-
>  arch/arm64/boot/dts/qcom/sdm630.dtsi  | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 9 deletions(-)

This is incomplete. I found few more cases for arm64, so I will send a v2.

Best regards,
Krzysztof

