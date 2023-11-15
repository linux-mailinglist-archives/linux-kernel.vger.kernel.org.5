Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B417EC907
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjKOQvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbjKOQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:51:20 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8781012F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:51:17 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so97675071fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700067076; x=1700671876; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1i4q+KeQwsIi0Qm6oURv67PVM/qypPfRLYO5kbNQm4=;
        b=gPkbMXjPTUTqH23ETdUmkfCOrhTb16/l3EuJuPTyNqwiUoaewGfjxyI5miEjfXHcQI
         +lhSsGUkR81ah4OEtFtrL6qOLO0erPQsJm3sOvA2qY+nmfzcWYLrm54H4ktpOAdBwpL/
         blfz36M6dpZgVYMS++HU3z8ppAugAevyiYAVPhUfHq6jmCkE1Qg+8L8sWYZG7QbLUnVA
         Xrns6gBQCaKtoAwIvxHoGul6v9rqbjxq5F7e7i3CB9/zL+tedLz/a2JUtK3ODjiLd0RM
         LDj/sbCAGTcFKfc0vyYu3rGQPZEH7p79DnVsgDBsvkSBbTzAc7f6F5uOliTTgKRYzmux
         0DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067076; x=1700671876;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1i4q+KeQwsIi0Qm6oURv67PVM/qypPfRLYO5kbNQm4=;
        b=dOoGx85rtFdNUEcSdSGPLyDA66PLIpbHrpj3BVD5Hf9GQukguXK/IYkKtQhorOho8H
         4yMKTXHsusO7n8E9ah9K37OO+Zsh5MPgjoP6Ym9vnYhmmJKSHaYtRzzm4rrODtOe0FiB
         6h6G+CKeR+s2iAncK494LOIirGgrH0XN6j+iYkLKN97HRM1inOU5OUu3sof9jx7SEE5C
         rko4WBVsz1NwHIR96D9PD8YgtCfL+eTT8ET2k/eGnsIsuE5787d8pnkBSqiLpaF3SI/9
         Xuqw/mfeI/0ZWSVKGPfGckc51CEmCiPvle3GC+gZoNFYbf0ZF3P/tYYFKyF2kvxxiVoJ
         yP6A==
X-Gm-Message-State: AOJu0YwE/SA/Rc3o7tg6qL6wF37kLUgtZHggpCiiFUVJ9PzS/YmbJXup
        Vhg8J/LgbIS/RQJksCogOJ0qqZa8b65iccVigZ4uuw==
X-Google-Smtp-Source: AGHT+IE4JiixN7a3K++e1hfkKsL/80lUrULgomKmtJuUWg3Kmvjn04eARLlsLi6SfALUNEIRcD7KqA==
X-Received: by 2002:a2e:8758:0:b0:2c7:fa6:7183 with SMTP id q24-20020a2e8758000000b002c70fa67183mr4832341ljj.47.1700067075770;
        Wed, 15 Nov 2023 08:51:15 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a13-20020a2ebe8d000000b002c12c2094e4sm1705775ljr.74.2023.11.15.08.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:51:15 -0800 (PST)
Message-ID: <a4e60c81-da6a-447f-a986-e23224602ae4@linaro.org>
Date:   Wed, 15 Nov 2023 17:51:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] ARM: dts: qcom: sdx65: correct clock order in DWC3
 node
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231112080136.12518-1-krzysztof.kozlowski@linaro.org>
 <20231112080136.12518-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231112080136.12518-2-krzysztof.kozlowski@linaro.org>
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



On 11/12/23 09:01, Krzysztof Kozlowski wrote:
> Align the order of clocks in Qualcomm DWC3 USB controller to match
> bindings.  Linux driver does not care about the order.  This fixes
> dtbs_check warning:
> 
>    qcom-sdx65-mtp.dtb: usb@a6f8800: clock-names:3: 'sleep' was expected
>    qcom-sdx65-mtp.dtb: usb@a6f8800: clock-names:4: 'mock_utmi' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
