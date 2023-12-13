Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D364811D99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjLMS4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjLMS4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:56:05 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674CB2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:56:08 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9f099cf3aso109204031fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 10:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702493767; x=1703098567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fKSdIvUXJptSaydKKV+34gXP5RUCj8nQ0FIDDQ6EDoA=;
        b=QXIms8BKwv/TQHifd59cqsou3fJH0RDMQ0yOW5+JQS+qr8/wJsNZXxMRyTkDOezOeP
         +buOh0S+pA2Z8mfPAP2PKCkLUlwVblXv61K3zYMViq+shZtcSD4YKr+HGWo3EdedX3Yl
         SquXoPuLrI2PYrbx/Gsy9vrKDKgI3JiczCJ+/ztXVAeLVpn0zVZkHnBBttB5tkDsNQFb
         WOKTLaLJ9VSz+hT0zf8DrE6ccH0KOB4DXoD8p1Zdn3Mbci853CM7fAWMGsrIHdwcu1GA
         bHhSkIgTAkDTzX8rvxtumI+hqmbBDcQLfQ4Ws3rR8XlHrZhqb2UICm0/jlu/i4++9QCq
         vzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493767; x=1703098567;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKSdIvUXJptSaydKKV+34gXP5RUCj8nQ0FIDDQ6EDoA=;
        b=GY8oluxl0PA9Rk9J5Rwf5OH8i8JBhMlyR2O8gayJdqJj+OwLLWC9HGrq1y1xhN+Hpg
         l/BCvkNMYZC34ngAituT/qsp3xLYtC5EjdjLR4I3L7MD4ip1fKn3A11hxo14zLbTc9TV
         kbIamDEy53lQ3fKLwcC3tx0AtbLY17aSZrqfuIOhjPxJaMZFJ9vCLrntD2o4Gw6P7kv7
         r1QGYQ1qtDG6uYd3Ve1Ha14c/hGlWcBhLnb1dcSJH31BowMpXjdHDqg7OsvyLVckNwNS
         4E4qsW2BBly8NQiCyvhMhA+wsTSL6i0qvh/0/YyZc14BHXZ13ADX+wYyrgixAJyPUOEN
         FnnA==
X-Gm-Message-State: AOJu0YzZDyr7VenMXBkZz8cCJHdgtfikh9FU4PgVo9yvdzjDFoEDKDks
        nKF47CQLtbrhUihAe2PxDuicWZE27rzXvZ211hyfFm3f
X-Google-Smtp-Source: AGHT+IHmKyLw4EdkfaBNBActBS9fIfW5ZX2iyhAR1KnLVTypwTtv+sgrm/kBINLhCV1WT5KbKqZkVA==
X-Received: by 2002:a2e:a681:0:b0:2cc:3f83:e3f1 with SMTP id q1-20020a2ea681000000b002cc3f83e3f1mr171229lje.95.1702493766785;
        Wed, 13 Dec 2023 10:56:06 -0800 (PST)
Received: from [172.30.204.126] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y5-20020a05651c020500b002ca35a126e5sm1895017ljn.119.2023.12.13.10.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 10:56:06 -0800 (PST)
Message-ID: <8d292ba5-fe48-49dd-84af-0afe3204b877@linaro.org>
Date:   Wed, 13 Dec 2023 19:56:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8550: move Soundwire pinctrl to
 its nodes
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231213162536.171475-1-krzysztof.kozlowski@linaro.org>
 <20231213162536.171475-3-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231213162536.171475-3-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/13/23 17:25, Krzysztof Kozlowski wrote:
> Pin configuration for Soundwire bus should be set in Soundwire
> controller nodes, not in the associated macro codec node.  This
> placement change should not have big impact in general, because macro
> codec is a clock provider for Soundwire controller, thus its devices is
> probed first.  However it will have impact for disabled Soundwire buses,
> e.g. WSA2, because after this change the pins will be left in default
> state.
> 
> We also follow similar approach in newer SoCs, like Qualcomm SM8650.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
