Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18B378BFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 09:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbjH2HwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 03:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjH2Hvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 03:51:50 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6563A194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:51:46 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99bf8e5ab39so528352766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 00:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693295505; x=1693900305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EqLCIfx/nQbDdaf7ISe4UiAeoOCZvB+r0pCvlD3LGTQ=;
        b=zPpL6N44WL7inyhdHAAHDUNf8j+oQF1Stzswm7B4hCLQCL4IF3ZUMkMUjB6ic/rmmH
         YpYaHvRJft527lOamtW3awCAvvzKceVPJfPEOdKr4qJrvwWFQWY620BktlS7NRz8urv3
         bb88702yHwxhP1KvND/aQyWJiG2pzL3S0E5x0lnJf5kZkVHb79Wq74ABZtciSEZVLsnh
         ognvLJYZmJf8NOfpJ9yvR2CRVL9rypn5k7JcRs8fz8lqhjSceJ7861N452i50QN8tGBZ
         ElSqUlSoSnwRLXxl+mPx746O4mghhd8Rsv8kG2KF2Wu8A4q8xow7cc3MCqV1LzeKKEK3
         ggLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693295505; x=1693900305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EqLCIfx/nQbDdaf7ISe4UiAeoOCZvB+r0pCvlD3LGTQ=;
        b=ADOIqVlqAf/C9GlSFPSGDZjSR2w9w+jgn8FyjAsGnA41ufF2y3gPUhx9NpJ2uYFWWK
         MhxqvmBZg9tlL6ReRy6dOWGntsjYr8VBkDX1icO3xOK/czXeNABz9+IorrPU6gRPN064
         AitSZhPcJTGUYQiI/d5QW1kaXGWYvMKAHEwH55hwNBX6TXqea7efqIoTuwyoRCJIudIB
         RE0/Cam1C7LUiJlc4IyGL+gloBP6+bj8oTPE6YG2N+PGbXiBLDETwRNfsc7otad/Awe5
         r3kTzjl85qNHJHRd8ovW+utuhQWxYnOh/f/LBu+acV7AoD8i91ET4+MwICSJ/LiG78vt
         eHQA==
X-Gm-Message-State: AOJu0YzlGQR68laVwT666WkwQOid0ktWbx8OfSyKE2c8hX88/MsCvs5K
        3UGleSGoeYfCDbJbZPKHtLgQgA==
X-Google-Smtp-Source: AGHT+IGDpUJD0SJNbKFg5McNu0Y7Pe/LRRlvTH3Z5Y9WrBT69j1eGeD+n5n8OJBMK0Bixn99CqCy6A==
X-Received: by 2002:a17:907:a053:b0:9a3:c4f4:12dc with SMTP id gz19-20020a170907a05300b009a3c4f412dcmr8842608ejc.7.1693295504932;
        Tue, 29 Aug 2023 00:51:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id sd26-20020a170906ce3a00b00997d76981e0sm5638413ejb.208.2023.08.29.00.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 00:51:44 -0700 (PDT)
Message-ID: <5d9a522c-7a36-2438-37af-5ee6ccb0cdc1@linaro.org>
Date:   Tue, 29 Aug 2023 09:51:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 01/11] firmware: qcom-scm: drop unneeded 'extern'
 specifiers
Content-Language: en-US
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230828192507.117334-1-bartosz.golaszewski@linaro.org>
 <20230828192507.117334-2-bartosz.golaszewski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828192507.117334-2-bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 21:24, Bartosz Golaszewski wrote:
> The 'extern' specifier in front of a function declaration has no effect.
> Remove all of them from the qcom-scm header.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  include/linux/firmware/qcom/qcom_scm.h | 101 ++++++++++++------

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

