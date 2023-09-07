Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830B67977E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241720AbjIGQgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240717AbjIGQgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:36:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE824C05
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:40:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcf2de59cso137004166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 08:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694101154; x=1694705954; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7Y6zFmhlb8oBiHulr6SNzDGIOTaQJEEOwxmUItsSBI=;
        b=BB4CXCsm1cyjr7swlhzgTBgZ8tMTjP42yfWIv2+pjHkw8Oi/hWhaELGnnp9s6hM1ob
         p00Xwnv3wCFxdpHfUezFYuxtGXGNeXrmvLjfFoxQD2DpmzE6XWk5pkDD059RtRfgkt3s
         6cV0DxGVZzBd18mRF/8MF4LLwIPNkpdt9mm4BQDMB+BkuwC+S4QgBtqOmmunO6wJjFC8
         RluLVYiiXhTbOiyjd+jmqCy4Wg5N2iesL6zRoB2nlHMyKS1stQaA5qBSnI2s5xKyPyhe
         qQhaEHozTz1UqNGSewfvvscBrWbwbOGqeBVkVkMKUX0p+/sdcUhr5bUhTPOlLCW6aKGV
         rbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694101154; x=1694705954;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7Y6zFmhlb8oBiHulr6SNzDGIOTaQJEEOwxmUItsSBI=;
        b=RZeWvWa5JudSdqZFjkLUqcfJZnPwH51/e3FzrDRqZ90D637tdbniyriV6AMhJOeeW3
         QBlpY26oqOfpPCbV0u8EQIYf0WMQUhBSt+yBnYWaYv6lkKWGz8EehYQpwQxp9b8ajrEU
         Sp8NCcPuNCuzUpJvPxrtAuGcBHRAFWsRuBEAl0Ru4cFkV8RiD8etEZNFiGiEAN9IdUFs
         M878KFcol+tkC/jhhkEwJP0B3TXHqMAgWxsqzYyvZuuWP6Tfqk+7l/YsOkcraHV8u0q9
         QhMGSKdHY98zeFdbSy64f5guWmpHXLK435pEU189cPImcZoqDW3U94/9jqaGsV5cCOFH
         a3yA==
X-Gm-Message-State: AOJu0YyWT02jkXSd504KOtFH4PZMUUVE8l7xGA/kIhv62v/+6ECoUS2Z
        CT2BaMwh4Wu+b+XptqtkGCED0Y8mLlncA3fboWU=
X-Google-Smtp-Source: AGHT+IEKmnSNSlUtiCWpMx5epfLO+Rm4w2bJrzAa6Be3omHD0KXp967h3WlCKIuq9OnSAsdvXE+3AA==
X-Received: by 2002:a05:6402:3c2:b0:522:2dcc:afb6 with SMTP id t2-20020a05640203c200b005222dccafb6mr3798766edw.7.1694066597001;
        Wed, 06 Sep 2023 23:03:17 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id t3-20020aa7d4c3000000b0051bed21a635sm9237337edr.74.2023.09.06.23.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 23:03:16 -0700 (PDT)
Message-ID: <3f68d3bf-3273-2339-ea41-3362ced3c91b@linaro.org>
Date:   Thu, 7 Sep 2023 08:03:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v1 05/10] dt-bindings: cpufreq: qcom-cpufreq-nvmem:
 document IPQ5332
Content-Language: en-US
To:     Varadarajan Narayanan <quic_varada@quicinc.com>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        quic_kathirav@quicinc.com, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <8fe23b5401362e214078648926a00f7ceefaa542.1693996662.git.quic_varada@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8fe23b5401362e214078648926a00f7ceefaa542.1693996662.git.quic_varada@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2023 07:21, Varadarajan Narayanan wrote:
> Document IPQ5332 compatible for Qcom NVMEM CPUFreq driver.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

