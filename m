Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE4B7D4A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbjJXIdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232620AbjJXId3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:33:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF84111
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:27 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40839807e82so24139645e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698136405; x=1698741205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jJlpvBYoBqkeP6viXimI/fz/jz7qnR4PL2nyYbSGRbk=;
        b=l99GcEpt0zLsS7remIKDiJh3J4ipNgYmitnlxqPD7gXmfJIM33vJwH6n9iIG7JIkgv
         bbggGDCTR+ablPXWM74ztIY5tv/JKHJEJGEVsGifcRkaTgwKPu31c4ZakiN/2uzDguLn
         ErdCmWFNwTGphfD/EfOCVjk6OKUCPcenBF7OqlsM4HXA+jGMgzKmUM7G6lOnwtflFyZ5
         yNqIPioWUjMrCEmesNtB+4aCDsEX5nPXWWWCGY80Alg3DMjJjKtMhl6Je/RBRCsPQdEh
         k2GVH/S+Fqdpu26fNe9JprWqAWA64bt5Dyy4iI3WHCDftXcn2d1iGFC+DeVP5WH9oJw+
         8+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698136405; x=1698741205;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJlpvBYoBqkeP6viXimI/fz/jz7qnR4PL2nyYbSGRbk=;
        b=k29LgQkVUwYgxK7X2BWh1F7QFcciIZk6HzWyKEUjwZ7KcNDBBBW2L26BPxh/Yw6y/h
         eb+uKqX45nYD8o+4hZMJh38ddMHKph+cmgw/LzEDkdG2+MnFXa7VbAf1AzQHNa/hJwAY
         J75yxcZARjw6hHA7eDBlQFFfSBql+vyBBlf/P/TL2+L3GpsO6mg+FHOYanqZqbqkNvvl
         aTPxtDaTLWtXKKNwqD6b7cfK8IjLab616kZx0QKmbsnVMsr2/rr6NRpuRIijmkO9U9vV
         5s9Y12/CZFf7rY0qffeGN4eHRy6g594RQz+UN0q00zN1uA5H4lT9zdzWNYCupydEs3te
         FQ1A==
X-Gm-Message-State: AOJu0YypgZvqKmOtDEHndso5qjpUqSWfE/rqYvYoVEyNANVruX099YZM
        zhJ/+FxHhrdn/nsxQBFQSsbF7w==
X-Google-Smtp-Source: AGHT+IGXMQldjSZrIjsfGTCegfjL7yUmsGtk0NazA1wG7UG/G2dJTJIwxlLltLgkFXCnMTUC4TFtXw==
X-Received: by 2002:a05:600c:5101:b0:403:aced:f7f4 with SMTP id o1-20020a05600c510100b00403acedf7f4mr14287485wms.12.1698136405174;
        Tue, 24 Oct 2023 01:33:25 -0700 (PDT)
Received: from [172.30.205.198] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q19-20020a05600c46d300b0040836519dd9sm11408994wmo.25.2023.10.24.01.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 01:33:24 -0700 (PDT)
Message-ID: <72a9ce0f-1bdf-4d97-a9f6-1aba532b0f18@linaro.org>
Date:   Tue, 24 Oct 2023 10:33:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: msm8916-longcheer-l8150: Add
 battery and charger
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20231023-pm8916-dtsi-bms-lbc-v2-0-343e3dbf423e@trvn.ru>
 <20231023-pm8916-dtsi-bms-lbc-v2-3-343e3dbf423e@trvn.ru>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231023-pm8916-dtsi-bms-lbc-v2-3-343e3dbf423e@trvn.ru>
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



On 10/23/23 08:20, Nikita Travkin wrote:
> Longcheer L8150 doesn't have any dedicated fuel-gauge or charger,
> instead making use of the pmic hardware blocks for those purposes.
> 
> Add pm8916 bms and charger, as well as the battery cell description
> that those blocks rely on.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
Doesn't apply on next, please rebase.

Konrad
