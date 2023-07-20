Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9675AA9D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGTJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjGTJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:26:50 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44F649C3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:10:59 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-51e99584a82so724102a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689844258; x=1692436258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mLBhqc2CfVFX3pSGzYlz5mlevC+IfeuDoZjqLxaF6sM=;
        b=ODMXwbZojNAx4UA/2ZkgWb1F/Ts3Nhh2zIiwPD0o5RA3RYfK1KIVV8G+G4xdLt7j9z
         D/camQaRMZRUY5BEhsemCTECBR8nWE1CO9tmbqnggRkHvM9AADEzLpBxWEKdkVYzu11t
         +O6Zr0WX0nCkOsrcpUN5/8NCb7+O8cyHL7K4goj5bNAjRvigG4RecE4wdMLYIvN7XCe6
         5Q47ICljpGajs7GP3uwids1MGHadK7dXtnbLaPPDa4x6hcODxYKhD3TgqyiG1tozNw+v
         g0Aj+dOGED/5g1dYUNd3ERfZupcJICy0MqxFZSlurvfQaZ+loE88I2i8oepIIsrz0HqP
         tqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689844258; x=1692436258;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mLBhqc2CfVFX3pSGzYlz5mlevC+IfeuDoZjqLxaF6sM=;
        b=XLUBLMDHFhYCOZqHlfYND2DfkGJekJs3hytclDsOly8/wg1TnrDbtlmWedtFcRNIVa
         bLv5FR3OXZ3J/ygw06b/zQQY3tHTSnDyKuSHOrpYFT0L3UWmdM1TDe42PFCu8BS0r6nZ
         CChEQjigwNF4Qq0MuHsX4RatcEED06XXL2ZmER5VUjb1LACEjd951PKzm9x8WWTzqIxV
         57keYIU+R2Gs0KZFR8E/1OvAZC9wr3OnJrRqDQuP3PxExlYpdKX74MG4Tn+w7VCeYlhM
         6092i0+zx4EoGNArID7gmu73CeFyeVlXrLB4+Ca7KgpqoG9GBqOcF3g/Oja7Xo5BL9Rp
         5E5A==
X-Gm-Message-State: ABy/qLZIb0B4QoMc/O+GbxJfEzFNs1cEIfnWkrA/8cXfxd/RIBbQWWBV
        Q7T3M4cqh+fO5I9d05QgOA2v3lsal8ajrvZTH9U=
X-Google-Smtp-Source: APBJJlFyqabXcBinhEE6qmbAkQmoFxuTmiSDb/e+O0iJKWJOq7quud5femdWEEDE1R6DbBh2mNZlTQ==
X-Received: by 2002:a05:6512:20c3:b0:4fb:92df:a27c with SMTP id u3-20020a05651220c300b004fb92dfa27cmr1553589lfr.25.1689843512334;
        Thu, 20 Jul 2023 01:58:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003fc16ee2864sm633408wmi.48.2023.07.20.01.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 01:58:31 -0700 (PDT)
Message-ID: <5fdfe7b2-0afb-f7a1-c29a-4a7884ff8f1c@linaro.org>
Date:   Thu, 20 Jul 2023 10:58:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Add initial support for RDP404 of IPQ5018 family
Content-Language: en-US
To:     Hariharan K <quic_harihk@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_kathirav@quicinc.com, quic_arajkuma@quicinc.com,
        quic_anusha@quicinc.com
References: <20230720074302.13585-1-quic_harihk@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230720074302.13585-1-quic_harihk@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2023 09:43, Hariharan K wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 404 based on IPQ5018 family of SoC. This patch
> carries the support for Console UART and eMMC.
> 
> This series is based on the below series,
> https://lore.kernel.org/lkml/20230720072938.315
> 46-1-quic_harihk@quicinc.com/

Nope. You make it very difficult for us to review and follow your
submissions. Especially considering issues in the old ipq5018 submission.

Best regards,
Krzysztof

