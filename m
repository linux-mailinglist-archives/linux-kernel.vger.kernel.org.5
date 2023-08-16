Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFD777DA58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 08:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242077AbjHPGQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 02:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242096AbjHPGQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 02:16:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51E0F2684
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:15:59 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so91239871fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692166557; x=1692771357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZMfGb0rOA/7xqhNtRRPREKtakzDUuWzOzMq996gsEP0=;
        b=vN6UMP/XU8J5n+iOyYexM/xIIXYfqsetJrCDV/Ta0ER6rpfFlETuKV+CpkBf6Ct8AK
         ggT4h3yq7jdtfWRk49r8i00I1gQK75LsCClW2pfYXABXmicKhz0inFRQRr10vrw7adPP
         X47gc2cSIqliy2s8rFWHW5j0MpgX6mPgZZ3bTyAOSpDFZCLz5jGJ1NsyqyNbMFeXvQoU
         Hnkd7OZM2jBQqeLFzppL8SNXDeZZpg0aimPnHQrW4xrBEvLE37SP/g+lgFZ+P0rZGUVR
         8zJMUz9+UFqdMhuGnhOLZS78bTmoII5NktbtK6YIpoS8lu1g2e0j0fKkYbVV6dbn0JHw
         +3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692166557; x=1692771357;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMfGb0rOA/7xqhNtRRPREKtakzDUuWzOzMq996gsEP0=;
        b=LIHtVBfTcfClVFSPeUZ5T7hrxVn6vO0biK40kEIVb7hZvwRIL15crLBrToeGoooaPe
         +KMIQuCTTDw+rZ0txkmog2fZDhG2nHSXCtsFcCIvbEsCtMFtZYcCJ/kc3ffCmTVFz9Xc
         KF0uaxvhtw2VPO0ZGG5mapueOQFY9ZH3UrqtcSd41KdWIFYx5/0aoMwxDPQ96cfvd828
         SuKqwKUlfJ797GZaWtpcGbMUGlORZL7Wq9YAluqfF5+NF/zyu/R+0jmlTaH0Mrjwys7w
         aWWImESYdZj5GMu6svN6oE6sXpHcTrJWZSq/cXNzLeogkfuptuXG1lBUELrBy2sv4eCI
         iMzA==
X-Gm-Message-State: AOJu0YxxDeenoLMKR51lOFCWrZW8PRSUZ3Y0NQ24fC4ViOXaUC/O9N98
        R8EEQ3pO9y1W0TPSRrY5obcCxw==
X-Google-Smtp-Source: AGHT+IFW67iM9K/2flFifqFuA8nOR7be1cC94ihFx4kqQS3e0Sl5iMDdA6QDQ36NjhsOGBTBfkM33g==
X-Received: by 2002:a2e:97d6:0:b0:2b9:e0ba:752a with SMTP id m22-20020a2e97d6000000b002b9e0ba752amr603353ljj.53.1692166557057;
        Tue, 15 Aug 2023 23:15:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id e1-20020a5d5941000000b003141f96ed36sm20145891wri.0.2023.08.15.23.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 23:15:56 -0700 (PDT)
Message-ID: <83cc4b10-34bf-ea91-7756-f345c0071479@linaro.org>
Date:   Wed, 16 Aug 2023 08:15:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 1/5] dt-bindings: firmware: qcom,scm: Document SDI
 disable
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     computersforpeace@gmail.com
References: <20230815140030.1068590-1-robimarko@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230815140030.1068590-1-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 15:59, Robert Marko wrote:
> IPQ5018 has SDI (Secure Debug Image) enabled by TZ by default, and that
> means that WDT being asserted or just trying to reboot will hang the board
> in the debug mode and only pulling the power and repowering will help.
> Some IPQ4019 boards like Google WiFI have it enabled as well.
> 
> So, lets add a boolean property to indicate that SDI should be disabled.
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index 4233ea839bfc..bf753192498a 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -89,6 +89,14 @@ properties:
>        protocol to handle sleeping SCM calls.
>      maxItems: 1
>  
> +  qcom,sdi-disable:

The property should describe rather current hardware/firmware state,
instead of expressing your intention for OS what to do. Therefore rather:
qcom,sdi-enabled
or
qcom,secure-debug-image


Best regards,
Krzysztof

