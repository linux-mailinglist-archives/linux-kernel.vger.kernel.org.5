Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24BB7EC911
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbjKOQxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:53:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKOQxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:53:19 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34BCF9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:53:16 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507e85ebf50so9333516e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700067195; x=1700671995; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGO9Oq0SdGkpzzE3uJylZH6OCZ5SuMtsEESQkZwIHuM=;
        b=TrIUm4g7TNZg55PzIoN1oFIaRDAr2HToIM2TxwDH29q0uj1KWOfFvauCtab5t4sW7n
         cgItpGGESzApfoUdIuqiqREdXvQDYbwh3acs+fMgpDnTLeWbA2JD5xAD8kvw6+dk/Mdd
         ScS4J2r7Eq1QL5KpIPcy26OxAndey3QSK+hQD4JIloRa4CMFzC4d7vEeDiSE2lm5asYp
         bccg1G65pQ6FCiHClDknoU4t3blHxkvYu6+So9vg6/44UdEykaBnhDydsgJHnqMkxWar
         HsNVue7DUzeaZc4Mg8VpFo0ZmU5QKNHnjz9dkZeHCyEEXa9Q9fSMQIjjLB2hr7lVdSTm
         zlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067195; x=1700671995;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pGO9Oq0SdGkpzzE3uJylZH6OCZ5SuMtsEESQkZwIHuM=;
        b=HrdKfp0085GQclINPAfdYUyJiuK8C2YjZpB98eZ4533wQyqY4m4C63MZ3d0TSV1OOH
         F6k4xG/wHePxBHnL/zgHJzBpDXkM073PAhLMcG8LOqemxxbXcwQs7yrlez5XZGeh2JWh
         ozNpMtBJjJzsLgjWQhz78rSOSbL9oxJW4GcMJhFAyYGETfUMpRshje/omm+XVsm//aPt
         FqixPzVrI4BhY94hc1Ei4fQbMhN45ZCMHks6zo/YBnf4MaA2tIJD+7lXjnsSungeIys5
         3ccRGwu1b8zrhqcnpWcjOTcDukZ9+Z23/QYTkK5NJG68nhFTDX8g4n4dGQB/ok6/DsnB
         Uu4g==
X-Gm-Message-State: AOJu0YxYDaH04zAOkixOzg/iS7NUM1jZkNL1ouV9tIzKad4GZr6dSx7m
        nYw6WOG6bkssE3IxDLQBqLijYg==
X-Google-Smtp-Source: AGHT+IFCM+c6ikxUOMfm7OdMmGp21KvVxvkGqhc0L81YSlh7wIW29WUSnANYhPJ9hJXmUWlxyT5I7g==
X-Received: by 2002:a05:6512:12cf:b0:509:d962:3c67 with SMTP id p15-20020a05651212cf00b00509d9623c67mr11619942lfg.20.1700067194926;
        Wed, 15 Nov 2023 08:53:14 -0800 (PST)
Received: from [172.30.204.150] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d25-20020a056512369900b005007fc9ccd0sm1688540lfs.113.2023.11.15.08.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:53:14 -0800 (PST)
Message-ID: <3332e356-89d9-4e64-94d6-ed75a5ec0144@linaro.org>
Date:   Wed, 15 Nov 2023 17:53:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ARM: dts: qcom: ipq4019: correct clock order in DWC3
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
 <20231112080136.12518-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231112080136.12518-3-krzysztof.kozlowski@linaro.org>
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
>    qcom-ipq4018-ap120c-ac.dtb: usb@60f8800: clock-names:0: 'core' was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
