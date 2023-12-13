Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2546B811CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377455AbjLMSkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjLMSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:39:58 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C133B12B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:40:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2cc3dd2d897so6589441fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702492803; x=1703097603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ol6nvI3xbrouU9id0Mvjg5S7+/mxK6nwvUyef7QNfDo=;
        b=ocTx0uuMP6Qgjvbs6/r3JAAsysaaXHlmSjsTovcuTCwHK1I1JCQP79FjKd11iC4nn+
         9gQfCGMbfUFvT7pzzuT7uaAy33EczJEZ/p8yLLhdWU+UotsoyiLf+JDwAACk9wGWapMZ
         5IYqSnGzXxHJ1AxXzVX8Uabcp1CcocFx3XFjkaALhTcpqSMWp4TWApMBPps8IhLjtq9a
         aruRK+qlU30qd8SyndYQhv7K7EGqCg5Gwnw3qrUhPLX2iPpurlwhUnSChwvVDF+nyIfY
         llvhTtP1gENY1r2LVI1PuwDPpn3ko4c24qcF/UXAXYxsqobIrnHCVT8MjnM3XNizxtF0
         9tPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702492803; x=1703097603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ol6nvI3xbrouU9id0Mvjg5S7+/mxK6nwvUyef7QNfDo=;
        b=C+9pxUmR1+3J4mSu6AWNEZ/Gx8Q8HzbolOaM7xmDxtoeu2l7BUBwd7RalxcSAu2kiJ
         pOE82wgkSrUeUX+lEfp8AbL1Vqi7JYZLrUfwn7x+fbklfavsRgrhKJL29Y2wi/i0akHu
         NZtLEPI1B3fsIffTw1h5ObL99uQZZQaQGChuloazU3QAvGQBRYThGKVKc3IsrR6I6uWD
         uG6K/cnIdEpcbiMqcukroLaqYXdAUUkAgatVYIX7qtsZm1F8g3kDprMt4J/3EKIb8Hhb
         haIoGVRFCZzw0pwVnsBpWUQ7BCtKeWhSXOUtVkulNk523mQjyf9F77k7UuVEnm+9/aLF
         XgdA==
X-Gm-Message-State: AOJu0YyMx9qSCNh7SadLLabAW+hNGvjNzl02oxysFq6i5nvqQHQQrLxE
        zewt0VObknHxK2HWsgbBsmLxDQ==
X-Google-Smtp-Source: AGHT+IEatj0Tn8aANvUUeB4wkvdtU24i+33W2pAE/l99W6gdO8QW7OmX9LNBTTroUxtZvYb8vioDOQ==
X-Received: by 2002:a05:6512:e88:b0:50c:e70:7b8b with SMTP id bi8-20020a0565120e8800b0050c0e707b8bmr5288901lfb.2.1702492802872;
        Wed, 13 Dec 2023 10:40:02 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id 13-20020ac2484d000000b0050bc59642casm1664598lfy.286.2023.12.13.10.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:40:02 -0800 (PST)
Message-ID: <6e9c93a6-48d0-4200-903c-caf271e2531d@linaro.org>
Date:   Wed, 13 Dec 2023 19:39:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] ARM/arm64: dts: qcom: fix USB wakeup interrupt
 types
To:     Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231120164331.8116-1-johan+linaro@kernel.org>
 <ZXc7KcjF82EgiXWd@hovoldconsulting.com>
 <06354190-b572-46e4-8036-0fae7f15dd15@quicinc.com>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <06354190-b572-46e4-8036-0fae7f15dd15@quicinc.com>
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



On 12/12/23 10:30, Krishna Kurapati PSSNV wrote:

[...]

> SM6375, I think GIC_SPI is fine but I will try to get back on this.
interrupts-extended = <&intc GIC_SPI 302 IRQ_TYPE_LEVEL_HIGH>,
                                               <&mpm 12 IRQ_TYPE_LEVEL_HIGH>,
                                               <&mpm 93 IRQ_TYPE_EDGE_BOTH>,
                                               <&mpm 94 IRQ_TYPE_EDGE_BOTH>;
                         interrupt-names = "hs_phy_irq",
                                           "ss_phy_irq",
                                           "dm_hs_phy_irq",
                                           "dp_hs_phy_irq";

the mpm node is not yet upstream (I only managed to untangle the
related mess recently), I'll submit this soon.

Thanks Krishna and Johan for looking into this!

Konrad
