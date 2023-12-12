Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02E280F211
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjLLQNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 11:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjLLQNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 11:13:31 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0573AD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:13:36 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c9fdf53abcso56772321fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702397615; x=1703002415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EieXF+G/Fj2+HMWIrp65YeNhRWmBnutanD5ialKbuFM=;
        b=glwcASmXoojWLO7P9pcbgQ8PaFeGkvCLQXTf5etZyP4oZVNMG4RZT2vqzbsc+5uMvE
         4PV1Ztg+CBLOCb7yAR+HOth6DwgO6NsG77sDuhTEngn10Dc7tAhuKnYTgBrKLivVv7j1
         NaL8BVXTyE6QhF6AoN1RDRhQ6W1LHPiRB7ZCL3rpmrXdZ/f8obFmwcK0hL5GKF5VRExf
         8grLScV1Rjy2u89YQ9GVd27WqUAv5JBKIxP0Pcu9dYd0TlUGBAA7fL3snagdjO/zWC+o
         9yThIpcW5Mm9ai4qbFQz+M0yLL59tfg5MtMJMminVMbrDKU0bcmecXQjE/Jmld0OZhtS
         r3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397615; x=1703002415;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EieXF+G/Fj2+HMWIrp65YeNhRWmBnutanD5ialKbuFM=;
        b=sJLQWweqf9c7+/Gje815RiVwwUaI/XUhN3GLehzYmO9sea2Oy9Rk1VtTQ36FwH4YlH
         od6K4w0Yn8A9ViHHLPtxBc+Q6ElVk/7ZkJp2u4wb0o3npIcY2ojt0ejg6KR9fEKEUQVg
         qIpOgSJUOLSAHPI/aOK5iky9JVDZfC9SaYOXmH6zAXVlQwtH16V6Z6JSrrjHX/XjGMK7
         2vVeQXyMCbjeFEtiguPKPiI9FtHWtsQdJ7UaxgpEuckPKyETlCLMTwacdA8DpxlSAisi
         lePM0x4lNxvnFAhzWgmN+DtBwhKI4X0VCp1nKi3R69bM1eoFLeZwGdmMvwXlKSF2/cy8
         DZ5g==
X-Gm-Message-State: AOJu0YwA1GYGDCe7OcfbDzqKcncWA7uDACWDB1ydYWckCElBnR0X4ujm
        XI9YthPQC81EbBOfKRIdkXzvV0kyeQNbRowR+KwdKg==
X-Google-Smtp-Source: AGHT+IEYA+Az4d9iUrd7j3wZih1isE7ATbKUF2CUBdcqcG9KL43Qwz32Rnbk2xRr12rDB28KqLPacA==
X-Received: by 2002:a2e:bc05:0:b0:2cb:280a:ad3c with SMTP id b5-20020a2ebc05000000b002cb280aad3cmr4713277ljf.13.1702397615111;
        Tue, 12 Dec 2023 08:13:35 -0800 (PST)
Received: from [172.30.205.64] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y26-20020a2e545a000000b002c9f2a716e2sm1676866ljd.54.2023.12.12.08.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 08:13:34 -0800 (PST)
Message-ID: <4542652d-f69a-474d-9c77-aa502da4d54c@linaro.org>
Date:   Tue, 12 Dec 2023 17:13:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: x1e80100: add LPASS LPI pin
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Abel Vesa <abel.vesa@linaro.org>
References: <20231212125632.54021-1-krzysztof.kozlowski@linaro.org>
 <20231212125632.54021-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231212125632.54021-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/12/23 13:56, Krzysztof Kozlowski wrote:
> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI) pin
> controller device node as part of audio subsystem in Qualcomm X1E80100
> SoC.
> 
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
