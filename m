Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5119D7F4E1E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjKVRSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbjKVRSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:18:53 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6836F1B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:18:49 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-507a55302e0so10076818e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700673527; x=1701278327; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qBb7uvDdpiPhPtfYhGAJokE68U5HdEwFTqReQh4emMQ=;
        b=S9t4hjh0IGkvOECUN5WpW86UWyFg2iOL1PRLQZRAmsEGyRsDTjPQWlesYlhoxHKzml
         BLyPCxoOGb00HQ+eQP6gxFNjEWph6CZurjyjZngR0Q8v84mQPzuiHxz4Ff1EOAcVI4yt
         cvJ+NExGeOI9+tJNvvrO/GryWx8OVq0KSHTPuW17eSgFcRKixMr6tx917dI/pUuHFSwM
         FE+ZMW7e4j6kV5Ky43Tegug2H6F6x1G+w7UARods5EwRPu7R+7/39CuZ/bFRMkbVhNNN
         ttC//uNeXdLZbY0BHDg4QK/NifL+1bcn6LlNKsGVGdxqlu4MYEly+1Ca1WOaqoGfSXNb
         YsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673527; x=1701278327;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qBb7uvDdpiPhPtfYhGAJokE68U5HdEwFTqReQh4emMQ=;
        b=ehR5OmY7b0PKdJZ0GLueJg9Y6b1ApE2W2gnezdz/zcMcDZw90YgqT+fJYaMVFMuIh9
         51kU5ggcLiYKpFmF2zab7pqmoKdQtVYC9g7gseHFKkDnHV6TihB/9/XGIu+JDPVhRSLw
         b/XUAXkla0draFUnHGsy7XmUvMFtCB8vsUJS3ChxAyfQgUs9/rZ7tMx4CdjG/vKmZIfK
         jJUmt8M/visE4n5aRhdSf0xy6Ixqhrnen1zraTyukf5KT9agK7tmiJmkrXEdekXlm5CM
         BhpLjZvbq40vDBddlNHgNVfVA+CqB5oNzOFmPE5Rs3UxgAKAnSzcsG0xX6QYiKcpgyNw
         ieOQ==
X-Gm-Message-State: AOJu0Yzs0M5QsGgw9GwK4I4b/nfso1GsHv8+euU2mcVAG3Htnar2qsEX
        FRSk/XIolUJ8dMzIu48NJ9YiDQ==
X-Google-Smtp-Source: AGHT+IE7Lpl8F22WVyua+nXBTNkuJNuj346aRbY/a56nH2yZhpl0Y/3GTRWDi4MXCF7jUctLK5UgqA==
X-Received: by 2002:a19:4359:0:b0:508:11f5:8953 with SMTP id m25-20020a194359000000b0050811f58953mr2099727lfj.26.1700673527381;
        Wed, 22 Nov 2023 09:18:47 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id a1-20020a19ca01000000b005091492ac3fsm1922005lfg.175.2023.11.22.09.18.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 09:18:46 -0800 (PST)
Message-ID: <ebed123a-f952-4269-bf2c-0c0cd7d6e049@linaro.org>
Date:   Wed, 22 Nov 2023 18:18:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm6115: align mem timer size cells
 with bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231111164229.63803-1-krzysztof.kozlowski@linaro.org>
 <20231111164229.63803-4-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231111164229.63803-4-krzysztof.kozlowski@linaro.org>
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



On 11/11/23 17:42, Krzysztof Kozlowski wrote:
> Commit 70d1e09ebf19 ("arm64: dts: qcom: sm6115: Use 64 bit addressing")
> converted all addresses to 64-bit addressing, but the ARMv7 memory
> mapped architected timer bindings expect sizes up to 32-bit.  Keep
> 64-bit addressing but change size of memory mapping to 32-bit
> (size-cells=1) and adjust the ranges to match this.
> 
> This fixes dtbs_check warnings like:
> 
>    sm6115p-lenovo-j606f.dtb: timer@f120000: #size-cells:0:0: 1 was expected
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> I hope I got the ranges right. Not tested on hardware.
> ---
Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
