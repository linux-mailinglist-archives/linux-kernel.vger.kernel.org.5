Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235B377CCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236194AbjHOMa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237237AbjHOMam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:30:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F790198E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:30:36 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so11191338a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692102635; x=1692707435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04Eq/C0GWaDiYcCYrFqsfXpuwAiZ6F9rzb+joKB8tu4=;
        b=QALSGAwR/1jBMsDbraRK442+gevrVJNG2FA/em8vCb76K+1CLqdtNDinvvKckWUAKb
         nwWZbPUM+DSirsEK5uyxcmn8S8hAn5Xod/kW2nrh/fkQAqzkjWnXdnNXwVdJUaNzQB+9
         923puvHwQehggdSWpl8rXNaWQESFdtr3rBSMTfJ0XhA3iJ7VM7eRnNMGDV8P9pbtgU9u
         jSkyPN/Xx4xN6McyfRYhiQ6ZhgydMGN7R5qMxqaR/D0L9sIOrgPFNcY0ACv8lzeiHPqq
         aIhw8Fbag6QtCnFlSAEjGaCFazLXlW8A4KfSRlxujewqaUju/XrYCd30AEr9yBevpaVn
         vFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692102635; x=1692707435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=04Eq/C0GWaDiYcCYrFqsfXpuwAiZ6F9rzb+joKB8tu4=;
        b=WgS45WCjI2/+AD4CNBrhL8I2TUbZfuO/6sZbh8ynAXbQovN55f1x7tJ7Po9dqSQfIh
         vpWpj9Md2gU9xnO2STFNw2Rr9BhKNIg89OU8YBxChlywFExV+biNLZs//9+eoVdB3cJl
         sV3w8xAYxIcquCcMEVFJPfkKrpddoB0e6mLB9b5n4dt+fBCKcHZ8Cu63IL3DAoj6RrDP
         pVcz85bhttD94c/whmnjNHDALGdGIbReqzWE6m4fcAo4G5m6l3nuHc3kwQuTlF/hceLP
         tCaKT9Pfl1Vmfw3LNFGeYW3sDPaWWPxpvnyviTbj5MO9utibXqgm+mxRA5lRkX/EU6SX
         D0sQ==
X-Gm-Message-State: AOJu0YxoEuaQ3u5nfT1cKQicQ4KU+1NDaTAzU/LBqcZ64Ge2wPa/QiLJ
        jyl3jWKp6m+m/tV8YKQXwKWFXw==
X-Google-Smtp-Source: AGHT+IHMvevtOqubR2zho6uMnwXtb+bjSLnRsMD5Yz9mGAKFCGHRaAcI1M3zTC7JreGower4LClqog==
X-Received: by 2002:a05:6402:12c9:b0:521:ad49:8493 with SMTP id k9-20020a05640212c900b00521ad498493mr1949191edx.6.1692102634865;
        Tue, 15 Aug 2023 05:30:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7d64a000000b00521d2f7459fsm6791546edr.49.2023.08.15.05.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 05:30:34 -0700 (PDT)
Message-ID: <079b6c94-0507-4ff1-86c3-14d6a6080b4b@linaro.org>
Date:   Tue, 15 Aug 2023 14:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/3] dt-bindings: pci: qcom: Add binding for
 operating-points-v2
Content-Language: en-US
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        quic_parass@quicinc.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <1692102408-7010-1-git-send-email-quic_krichai@quicinc.com>
 <1692102408-7010-2-git-send-email-quic_krichai@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1692102408-7010-2-git-send-email-quic_krichai@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/08/2023 14:26, Krishna chaitanya chundru wrote:
> This adds a binding documenting operating-points-v2.

1. Missing blank line. Don't write patches by yourself, but use tools
which create proper commit automatically. Every decent editor does it.

2. Please do not use "This commit/patch", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

3. A nit, subject: drop second/last, redundant "binding for". The
"dt-bindings" prefix is already stating that these are bindings.


> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 81971be4..6bc99c5 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -121,6 +121,8 @@ properties:
>      description: GPIO controlled connection to WAKE# signal
>      maxItems: 1
>  
> +  operating-points-v2: true

phandle without actual table (opp-table) is rather meaningless.

Best regards,
Krzysztof

