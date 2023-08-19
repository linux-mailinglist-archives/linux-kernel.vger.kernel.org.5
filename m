Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E1B7818DD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 12:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjHSKkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 06:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjHSKkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 06:40:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9732A108E2B
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 02:36:08 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c1f6f3884so216371166b.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 02:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692437767; x=1693042567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sXmf1PXc0L6m77MAsNB9+ZnrIQ5rFUeoN1zBa9T+k+s=;
        b=g6GSe3KRMg8aav5Zk4Awrlx453K6p9FvyV+iQj7OOS/hg4iEkUsHzgYcbMBRyEB3zK
         9bNlfV3z1yDmfmZ8X6jTiWet/yWsO2C8wMREFgCERMb6loF7v013mfPSgjsNbn37Qy4P
         eBQlktyuZPDwOcDxoaiIdxNKxoG+ZBlOIjrSAd+MfHJ3zlVesmXCC738wwJWJgcG4jR7
         gK3kNDQ9SXK2WSaiJ7LWkCgV/2QRXwN1MK1olqqBGzO+mLK6sNendkx20Lf4+ZBjMArr
         ffjcoeuIQEgC7Gz+C7JOu5oyGzqYsdF9a3iKEFomdy6nfm4MIyF5jOeicDZtEKI/WgXG
         lBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692437767; x=1693042567;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXmf1PXc0L6m77MAsNB9+ZnrIQ5rFUeoN1zBa9T+k+s=;
        b=PrH6+UTGvjtId5AvlNOwGj/RYXBtGrciO9zVhB9RDrG8VENJ9aK8xV9MPjnDo7ai2F
         3lwD1Y05BW1WtyVk3WdIlry8BY7QEDrVIrRxx1SXJgSQNPCH+Naa8XOiFz5ggBf+bgxH
         kUe8d/AWkoiZjo/7fCTvBFUhwp2V4G+fXPohQXP2jyRAeX8yD+K4y7vtvknVMpcOBzAv
         BzCY22EZc95StkR6A10MazDJ1AVf62D/XxOmtc4VzDpQutr+by3ImtKwywdyXw/rc4V2
         v9PabzYKgR6HiIAZwpEXuJaTHU0hahKYoaUlLYTMg+9qa1DW1Clp6ayg5dCPOc0l0nNI
         oyQw==
X-Gm-Message-State: AOJu0Ywk7P3j7hs2+Rz6sLVmMNpAxTPWGa/JsbzWdFrDqTxitAuIVZ3L
        owgvyixTBC1BOS+IJZZ1yYC2Bw==
X-Google-Smtp-Source: AGHT+IElIpQnP+n8uhTNiR6fC6b/X0C/ILO12LXuQRZE36J5I7WcRp68x93U9aJxY7JKru8QXXCG/A==
X-Received: by 2002:a17:906:3199:b0:993:6845:89d6 with SMTP id 25-20020a170906319900b00993684589d6mr1122648ejy.47.1692437767240;
        Sat, 19 Aug 2023 02:36:07 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id e4-20020a170906c00400b00992e94bcfabsm2390761ejz.167.2023.08.19.02.36.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Aug 2023 02:36:06 -0700 (PDT)
Message-ID: <13c6fd25-37c3-e2ac-3cf8-183aa1eb52d8@linaro.org>
Date:   Sat, 19 Aug 2023 11:36:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/5] dt-bindings: qcom: Add Sony Xperia 10 V
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
 <20230818-topic-10v-v1-1-dbb6464223c6@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230818-topic-10v-v1-1-dbb6464223c6@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/08/2023 17:23, Konrad Dybcio wrote:
> The SM6375-based Xperia 10 V is veeery similar to the previous year 10 IV,
> sharing a common base motherboard design.
> 
> The software configuration however is somewhat different, which requires
> us to allow using qcom,msm/board-id on sm6375. Sad.
> 
> Document the device.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

