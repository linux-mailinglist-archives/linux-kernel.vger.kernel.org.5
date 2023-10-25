Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2304D7D65C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjJYIu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjJYIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:50:22 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CAC1A1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:50:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a3b8b113so8078046e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698223818; x=1698828618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=42JgJL4inSij1dDJZcKoLha0/JD4nZAzUlXXA6vbSFk=;
        b=FKSqpr0ta9Vn7tSIRC9rZOG5CwTLG7E7SXNHiL6+KSNJTyvP3kcBoWcAnEuJVrfB0K
         rmNqaRW1H5fp+RsvPONDRDi5noyJN8FSxw/pGSTrx2XphZkhXv5LahTJxQH7piROpvW9
         maY+QocffrmbBPUWG28s/LQQY3+VIk+ZhPv3RhIZINKcE4J2s+IrMzucbYNDoe/xMKVZ
         nfLmJN0I6DWa0NBsJMpOEPR66f2iYPFEOSx0T3vZlLLXGgXMmSI6ncs2M8ViqIjBv8c3
         jjZvaiUsiDGJGT3o6dL2C9VRE7T8tJIqYZPUX/ZRR/3IzjJh2fZWfFKuKuEpQzHz/0a5
         Mu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698223818; x=1698828618;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=42JgJL4inSij1dDJZcKoLha0/JD4nZAzUlXXA6vbSFk=;
        b=uNhJLKoFUc+bmEu7q8FzY6Jhw4YIixw43v7411dWL7AzeuE2W+0j7t701ZOTI5rHtP
         CTjaQYZ1Rb2hVeLCohrD6cOisXlOdNVXNhH/ZBFJ//tcck4gORYT00XOA53qpui4WSr5
         dOLrNfnbBxVNqdldyrGW7epdRDJ65uA1gUQ0pzXfUveIiQLKV+K+XVrISHtcFFGocK7v
         Z7JzH8/2W7s269UMYtVesLJcF4OGeAwp3VEeQr8kbhgMmsOafzs25lUI4lAvOvECpqH2
         Ba+wVAEvOpBRxBBdIrkxQoGxKa6pxOX0hWs3L75l+1aqrO2xQq8uL+5iaVkssicdhE2w
         Ju/Q==
X-Gm-Message-State: AOJu0YzHwafq5G3A/bZGT4EvAQQOICjm4HhEC5U0fi6tBKzVKdLCwPt3
        8JjknS+dI0cV0TSqHN1o+q4hEw==
X-Google-Smtp-Source: AGHT+IFI/jAT9xMiMciXbNW+3Fnv+Y9Bc7x1R5bYbksqN4voIBEiqokYkWMFtRc95a6GWDmnR3p3+Q==
X-Received: by 2002:a05:6512:6c4:b0:507:a04c:76eb with SMTP id u4-20020a05651206c400b00507a04c76ebmr13233616lff.35.1698223818149;
        Wed, 25 Oct 2023 01:50:18 -0700 (PDT)
Received: from [172.30.204.57] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y7-20020a196407000000b005041f004d33sm2475831lfb.90.2023.10.25.01.50.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:50:17 -0700 (PDT)
Message-ID: <b7e6839d-69c6-4d89-805e-be6bfd384a2b@linaro.org>
Date:   Wed, 25 Oct 2023 10:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] soc: qcom: llcc: Add configuration data for SM8650
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-llcc-v1-0-ba4566225424@linaro.org>
 <20231025-topic-sm8650-upstream-llcc-v1-2-ba4566225424@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231025-topic-sm8650-upstream-llcc-v1-2-ba4566225424@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/23 09:31, Neil Armstrong wrote:
> Add Last Level Cache Controller support for the SM8650 platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
Did you double-check with the docs for the latest hw
revision?

Konrad
