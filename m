Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADAD8053E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjLEMM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347117AbjLEMKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 07:10:49 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CC2C3
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 04:10:54 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c9f4bb2e5eso39512111fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 04:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701778252; x=1702383052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3d56aD4ZvOlwf3rQa8BE6a+ZHLUy7yitH/6f5sNjUAc=;
        b=SfHfVYnOecitImpbyc2wCLQQQY+YExur+xxaRnDA2s+lOFi7RBX8IbGBP/T6H6wUd2
         op67pPmYciuhdpH8qjHm3pTsgk1y5piMUMH3Kk1Q0SBqtoJbjh+U/xLySPnPSu+dyeLE
         ja/6L8D1kdc8CiolGYWl8+luydwFHqynJWXHDbg/2tVgQPDZbt8J59eLFLYICEyRgrbS
         s5SSURQ8+fQemzjU6Dxd8kq7z9aCLUfn8hG6ncsl1bmyJaBOmd8mUmA7HCy+CJyZ5bU3
         783H0Y2lhfcSiTzKfzDZQu4+Bf+zWVMtwSk+RnrkGiimWkhqIe5dOZrWmq3K6bpD7R9K
         gCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701778252; x=1702383052;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3d56aD4ZvOlwf3rQa8BE6a+ZHLUy7yitH/6f5sNjUAc=;
        b=s/iNa7bGAY6oQkaLrMbjH9/fFUyfy/OLH/3bF7D/cU+fxZqpQ/BR/TDq9lGTy2EzEr
         hJlVFySrMfQgRB3VLyPCUj5sj2bQRVbNT1utSsY1P1KTae+E/ks3gfy4hfJjQKeT44Vk
         FvBbf+WbmkNnuroef1zDgCiqc/BxVx56RgSXXew9u98JlKFzEKnY/FS8Qpnqk+vzAafG
         2haWdDCVnagCDUXunqAWkuWKyFgBOr9owzNRcLyTl2VGKQUwTL4pmHk+OQ65tHGkwFEk
         VyF44sonlUA5c4DTZBpQTtQx6rrJed5nHbS0RiIebAAGdDOm4+8TRzVy8lICNH45LFXr
         SQUA==
X-Gm-Message-State: AOJu0Yy1xOXUwYvxcLd+uI36nu1fw1nbF/a6zjUcW2xfBnxAdMscfu17
        UTnCHOs3O75kvvgz7j7470wC2A==
X-Google-Smtp-Source: AGHT+IE+WjEqqHU2fdHdPRsbnB3CFXOLpcnW7QXcMtkl+6Oy/uQyfG5hwppL1Mvv/N+RgdCZ5vfsuQ==
X-Received: by 2002:a05:651c:89:b0:2ca:3b1:1da8 with SMTP id 9-20020a05651c008900b002ca03b11da8mr1567631ljq.104.1701778252652;
        Tue, 05 Dec 2023 04:10:52 -0800 (PST)
Received: from [172.30.204.197] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e2c16000000b002c9f7c2635fsm956195ljs.1.2023.12.05.04.10.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 04:10:52 -0800 (PST)
Message-ID: <44840b00-4016-43df-987a-5db0c46c70b0@linaro.org>
Date:   Tue, 5 Dec 2023 13:10:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: sm8650: add ADSP audio codec
 macros
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Neil Armstrong <neil.armstrong@linaro.org>
References: <20231204155746.302323-1-krzysztof.kozlowski@linaro.org>
 <20231204155746.302323-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231204155746.302323-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/4/23 16:57, Krzysztof Kozlowski wrote:
> Add the Low Power Audio SubSystem (LPASS) / ADSP audio codec macros on
> Qualcomm SM8650.  The nodes are very similar to SM8550.
> 
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
