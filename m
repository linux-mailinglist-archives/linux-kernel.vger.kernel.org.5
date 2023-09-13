Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6225079E2D2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239173AbjIMI7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239120AbjIMI72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:59:28 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8DB1998
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:59:24 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502934c88b7so10678727e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694595562; x=1695200362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qLErzD/mwog96LhgXuy4nFZw1VfF89gkGq1kHZ2MIYc=;
        b=aItYAQg3uBZIHxkDA4c6QjbnbMAEMrASxz9c4AiaNhq3qc0ZHzlJGI96NF7rV0jdVX
         7Au+JiOkNMf1v7IrZ4o0+x3m+S93t7M70+TEQKfP1LJN8C3FDGKxbe3/BiZ9qOUOvHK2
         ocMtlqyQkWsrIOSVyf3t5EN/dlnYTs2ZLDYROJ6QuWCGtMCt4taRKIskK8cItceQ45WY
         5HwzuAikJjWLUJtXzNGfV5Rd4CyQMUOoDMeH97arf0eWqIRi/BYCcV2gt3PDprNCYXlW
         EKacUosE0ZujCzUDSoOQUOnVQCTd3GnbtGjSuh1xrsHHQHLeYR0n+yYUIc8eDqtI9Imy
         81Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694595562; x=1695200362;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qLErzD/mwog96LhgXuy4nFZw1VfF89gkGq1kHZ2MIYc=;
        b=gjjyxPALtJOV6vz+fTjdVkZsiyFES42iB2XVYPwIbdJLwtdoT+Je29aC+tSYCps8mt
         BCKZHs6+cJAkH8bCaMxOSh/v3dXBTM2ZGgORtNu5iIYOd0Pv0cYcOSbzsFkShaHcz8RV
         YUkIAHvNykrY6A4uq5SQR6p7x+lBJfF53R3D2gfOLlDZUUdf1ymKHOxsJ+oBjKEU7mqq
         x2pGrykbDykTeSljQkVY4dRL3tBZwObYhWT/ADHoWwZ+htGOlhdDHkp/1RybCaqvmMY4
         A7CG0JGKicWl5io/sQLULoqgMVZlSB0IaizGbehxvj8E48p/e9IEYjtNUnDuO00yRZWC
         1ezA==
X-Gm-Message-State: AOJu0Yx6t3u4KhoxPwuP7+T0s37x5GXMzsBsXKaSx17A72g7q6cXGLww
        98jt6rLpxqEaxOYUJGLBxb1wdrXw5Eu8n2hL1btVSg==
X-Google-Smtp-Source: AGHT+IHAwk94eMLi6+ESHMi99gYJBLCgj+CVZozSlTblFS4Xbd4zrORMlJdioHk7S56R484slaSayw==
X-Received: by 2002:a05:6512:3416:b0:4f8:4245:ed57 with SMTP id i22-20020a056512341600b004f84245ed57mr1821261lfr.35.1694595562391;
        Wed, 13 Sep 2023 01:59:22 -0700 (PDT)
Received: from [192.168.37.232] (178235177106.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.106])
        by smtp.gmail.com with ESMTPSA id q24-20020a170906941800b0098921e1b064sm8031799ejx.181.2023.09.13.01.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 01:59:22 -0700 (PDT)
Message-ID: <1b8c72e3-956b-41d4-ab96-198b5a388eba@linaro.org>
Date:   Wed, 13 Sep 2023 10:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] arm64: dts: qcom: msm8916: Reserve MBA memory
 dynamically
Content-Language: en-US
To:     Stephan Gerhold <stephan@gerhold.net>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
 <20230911-msm8916-rmem-v1-5-b7089ec3e3a1@gerhold.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230911-msm8916-rmem-v1-5-b7089ec3e3a1@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.2023 19:41, Stephan Gerhold wrote:
> At a first glance the MBA memory region on MSM8916 looks intentionally
> placed at the fixed address 0x8ea00000. This is what the ELF headers of
> the firmware specify as base address, and the typical Qualcomm-specific
> bits suggest the binary is not relocatable.
> 
> However, on a closer look this is pointless: Unlike other firmware
> images the hardware expects to have the raw ELF image loaded to the MBA
> region, including the ELF header (without parsing it at all). This
> means that we actually just load the ELF header (not the code!) at
> 0x8ea00000. The real LOAD segments follow at arbitrary aligned
> addresses depending on the structure of the ELF binary.
> 
> In practice it looks like we can use an arbitrary 1 MiB-aligned region
> for MBA. The downstream/vendor kernel just allocates this dynamically
> at an arbitrary (aligned) address.
> 
> Drop the pointless fixed address and use the new dynamic reserved
> memory mechanism to allocate a region close to the others. This reduces
> gaps in the memory map and provides Linux with more contiguous memory.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
