Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C47F4CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbjKVQkZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:40:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235222AbjKVQkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:40:03 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC5B199A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:38:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-507973f3b65so9861070e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700671132; x=1701275932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tfN8vV15Ea9/EIcc8eCkqmRkgeAQEYZd6rWJeYZUq3w=;
        b=PcmgUgG+hzjqL3nkPVgARJi0FxNJNH02pxK5Iz9YYrArQeKJkmnloMSAWUd9H4LGXt
         HOFosgpCwYBRc9YIzFeO8daWSVUsepjEgTyJCqDtDTH+bK+gqm0AkQNiDWRZ2qTaoKyt
         O318cpmw4gXFXjeI73XyzvWGzl/e8LPEyIGnfasIiD3AOogdtXpY8QYE7V3+SaVIA5Rg
         U9ceIi13DUz5sP7raszYmoLLN/TkXWknqyMXWcgqoD1XkDjL51tN9GxqvBgBBMNEE2Bz
         OCE4sTmAN+rldcr3J970s30QMAqgPL8O6i2HW+R1yruo0FkJQWMz85AP8KfEB+2PVGKb
         Dk2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700671132; x=1701275932;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tfN8vV15Ea9/EIcc8eCkqmRkgeAQEYZd6rWJeYZUq3w=;
        b=okKxug9HfnUteCNDPykC88yAGnFypnQNaF7u3qXT0mV1S47A6gbo+0JQbptvTMUFVS
         UYX5YeKhz6MKbcEp1z1h5Jvyzov9ObnUdVEfHg5ENJGKaG7NT23qBm4gPkYc/bcMVrZd
         A3ESsrVdRBhlOjg+8seLWBHg5jhAw1n8vfOox3bjqv+r5jBUqO4V6XxIuAPHGU1GLPMk
         UrQLupb7Wy/WYp8ieyiVDOH2CPxTzaa17RRyAF/x6lG+pNJn0ENToq5n3PkdCE+R28c9
         LIB7ryFzD/qiYwKLjytuSpsSZvaMqUdjniAKO6C7hkUaOpwAYXAxIEzdncoooVUu5HOe
         JViQ==
X-Gm-Message-State: AOJu0YxPLXimv03Co6SKJ7Gjh1qWtZHQpahCG+f1fKcq+Iy9IzY1L7y+
        xooscdTk3qki4ct+RzvRAyNqzrU1KTQ20BAK0gpfxXv0
X-Google-Smtp-Source: AGHT+IHKb7OWKqCJ2bI45C9RLV06lHjgr4MW3iZszai98Cva3bxT3FNafWP1S5OJsucSj7tAjtCa+g==
X-Received: by 2002:a05:6512:684:b0:508:1a2c:46d0 with SMTP id t4-20020a056512068400b005081a2c46d0mr2724979lfe.15.1700671131691;
        Wed, 22 Nov 2023 08:38:51 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id w3-20020ac25983000000b0050aa51bd5b5sm1587819lfn.136.2023.11.22.08.38.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:38:51 -0800 (PST)
Message-ID: <e52c69d4-a2b7-4d9e-9ccd-08d7746c3312@linaro.org>
Date:   Wed, 22 Nov 2023 17:38:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: dts: qcom: Add PM8937 PMIC
Content-Language: en-US
To:     Dang Huynh <danct12@riseup.net>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
 <20231121-pm8937-v2-3-b0171ab62075@riseup.net>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-pm8937-v2-3-b0171ab62075@riseup.net>
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



On 11/21/23 06:35, Dang Huynh wrote:
> The PM8937 features integrated peripherals like ADC, GPIO controller,
> MPPs, PON keys and others.
> 
> Add the device tree so that any boards with this PMIC can use it.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Dang Huynh <danct12@riseup.net>
> ---
No users?

Konrad
