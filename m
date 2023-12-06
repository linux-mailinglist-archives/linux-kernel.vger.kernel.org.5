Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CF8806FCB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378287AbjLFMdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378058AbjLFMdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:33:20 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80C4D3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:33:25 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2ca208940b3so8910331fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 04:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701866004; x=1702470804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i3zRu4zCL27OConZJ/dXxv4eky6lJ797ekbzBQIQO04=;
        b=IXNKmmkALdUYmNCaLPOkOPzqsmIR7eY3on8YPuaVQt9Wr0q/dtToVesgPg4MUPA+ZJ
         z+U9mfFROvwRFGAxIkSDReE9QHMz4qlVvmMommnBQH1+C276M1WErDuG7IhR4nTLZ+hT
         GFrdf9wvNA9ODHi9inf9verkrEekHGwv2qzVmrE7rvIJp8Ec5QH1ZcaFGq5KZNA+c58V
         qLJ+k/Jt4lUUNQDrBwjpSLMtohQcQmzVjzRwzRjpBMhZwFquFk+B+YD5ua0a20DgJHsM
         h/ck/AQlpHSqyn+avhpilp+LgLnNBK970InRUxwkXzUAPl4DijmCl9UtY+LCsqU6z4AH
         TCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701866004; x=1702470804;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i3zRu4zCL27OConZJ/dXxv4eky6lJ797ekbzBQIQO04=;
        b=mZDU1bPIDlbB5UAp5zXoY70uvA1JREn2KH00iYVpQNxPe2pNDZ0OUR4AgYgDVoBUua
         353/rjbZHAlolAa+94PEdYTpYOkrvCyw9rfMHwzhwyXsipdpqA1AgXkzWED6g9PAIZUn
         QX2mjUlf9hXp/IuQMIXpaJAia/rE3j0voshhPD8q4x1Fw/+wNMb9y3gOrJCCO21tsR6W
         q2SSBkiyL5KAIfJZ3IIDV1PRv2OBqq+maqXUSrr0dVhaXrXc10N8N4xXS59aMobdtK03
         8zwje9X54eQXR0Vj3C7Mrydj1Ol1P+NVMFwZnOFmEyapdGcuzdPRY8OJp32lHsD3XNA5
         6b8Q==
X-Gm-Message-State: AOJu0YzjmVhm6Yc2/UaicloNSigwXRrN5EidOegxYRGst/rCgsnYzPPx
        Cv7eE+OibslP6zGyjjvpg4MsSQ==
X-Google-Smtp-Source: AGHT+IFoYrIWZweW4wNRjzDa/vyq7mAaeL49kvARBEPAN6JpcwCEEcJFFsb4LcNLy+7tTIH6iLUxbg==
X-Received: by 2002:a2e:9b15:0:b0:2c9:fe01:7014 with SMTP id u21-20020a2e9b15000000b002c9fe017014mr515733lji.62.1701866003949;
        Wed, 06 Dec 2023 04:33:23 -0800 (PST)
Received: from [172.30.205.186] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t21-20020a2e8e75000000b002c9f82eb099sm1267851ljk.113.2023.12.06.04.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 04:33:23 -0800 (PST)
Message-ID: <88432969-a4ea-4fa4-a2c6-93d5fc9e8af8@linaro.org>
Date:   Wed, 6 Dec 2023 13:33:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ARM: dts: qcom: use defines for interrupts
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231205153317.346109-1-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231205153317.346109-1-krzysztof.kozlowski@linaro.org>
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



On 12/5/23 16:33, Krzysztof Kozlowski wrote:
> Replace hard-coded interrupt parts (GIC, flags) with standard defines
> for readability.  No changes in resulting DTBs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Convert few more values to defines (GIC_PPI) - the tedious part which
>     Konrad wanted.
> ---
Thanks!

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
