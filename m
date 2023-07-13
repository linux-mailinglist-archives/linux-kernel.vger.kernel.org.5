Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B24647518D3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjGMGcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233991AbjGMGcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:32:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF401FC0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:32:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso2460625e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689229924; x=1691821924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ggpj2HpIwuIwps0pPKNt1KxoFIc7z8mhEvXCZwkez4I=;
        b=BdEgN0Zh7befL3eiroVtMlZu188tBVLVSLXDp2d7hyGm5HT2wgJxaIpYbOUXHeXFbi
         3hl82+p9Fhc+pV5DBLBY8Hkva/FMuh/jzX99Ozfi7TG1bpyQvfV9EP8W0+q6DpcYW+wo
         6L7JSxKGFOREsIkQwQgicvoR67rbu3qdjbqRZdQp038kQ5dHOXgBFPPRNDBhF/7KSQeU
         zijxNCk28UWM/ZO09jx/s1d9JEpnIC+3gAPNNWDGDmBz76e7USLElEJ6pZqy2XkX7Nie
         9cfsBostMu3if/dErm9wxWuzoGW83eXLrsmnL24p7pidJZmV5dKqFYTX1lM/I9fg7IMW
         6VAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689229924; x=1691821924;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ggpj2HpIwuIwps0pPKNt1KxoFIc7z8mhEvXCZwkez4I=;
        b=kRU+daxCPEwav6yrPYMPWF3LIuid8r4k3vCwSFq6I+lmz9i2SdyytrxyB10W1j5xyY
         XMr3Tm33vEx6ONAgEZL7F7ZX7e9ZJMO4dVw+6empVwNbky2yIl5XcbhBNW3nypHCxs0v
         pZ815OIhmOt8fMcBX/l6pzzt9N/lYDdZGlrq6OtjtKOhq5t1Ohs2PTxKQuLshYSaYxBe
         zrKW0F9GSXsIF24ZhOMdwh3Q8rWHmvD+f4ltlhYsiPDtIjofa3oJ8Fm6hJ85ZEu+j4ZL
         hd6F2OeGoc0IRxb1OBUlaRzLdYjaamzOeSY+ZTNYaNx55sfq5+iKyCsZ8Q5guUxqlJ+O
         lPgQ==
X-Gm-Message-State: ABy/qLZIo0oUOQI6zBHqNYoduvxdSW6XvCEakJOetD92rCjX48zhPfAL
        5iuAYQY57KYmpCVCsThSZ7XZMpIEoULX95873lHTKg==
X-Google-Smtp-Source: APBJJlH6hiMzxxBARZgDoXlXogR4LO5VsOQCXxTv6NYWVyWAE5jv1Zm04ZGCkmCZ2ZVTyl3abisbkw==
X-Received: by 2002:a1c:7514:0:b0:3fb:abd0:2b4b with SMTP id o20-20020a1c7514000000b003fbabd02b4bmr482493wmc.26.1689229924045;
        Wed, 12 Jul 2023 23:32:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003fbb618f7adsm6778960wmi.15.2023.07.12.23.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 23:32:03 -0700 (PDT)
Message-ID: <4c48796a-8e9c-ca5f-bacc-6811ea95f316@linaro.org>
Date:   Thu, 13 Jul 2023 08:32:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/5] dt-bindings: thermal: tsens: Add ipq5332
 compatible
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, amitk@kernel.org,
        thara.gopinath@gmail.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230713052732.787853-1-quic_ipkumar@quicinc.com>
 <20230713052732.787853-3-quic_ipkumar@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230713052732.787853-3-quic_ipkumar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2023 07:27, Praveenkumar I wrote:
> IPQ5332 uses TSENS v2.3.3 with combined interrupt. RPM is not
> available in the SoC, hence adding new compatible to have the
> sensor enablement and calibration function.
> 
> This patch also adds nvmem-cell-names for ipq5332
> 
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

