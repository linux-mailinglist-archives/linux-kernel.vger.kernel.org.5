Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858157F4CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343920AbjKVQiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjKVQia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:38:30 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A64D7E
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:36:45 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507bd644a96so9926965e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700671003; x=1701275803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Di9yvxAWs36hcl+GloFnlKFwW1mBj+fjSlK/jwxdAQM=;
        b=oN5xUV94HrL7BKN5Ade08Vm35dgqeH1NMXo3HQohWHILA9tvUBRi2Lm7gsFDQNrJb7
         e8xuDo3UGGCDKit34L/k3BeTBZWLpK9AKMnX7T8K7M4nqDxz70uRj3eOTWce8FL7bZAi
         jxs4I7L43xp0xX+X1+7Ze0EqIvmurnI4McnKCKc1gPHhi5Upm+j0xgPuw7i8/KSZG4DZ
         7Z6ATL3oPia0OFCgIVqZdTHMUN4wPODsEz9Sv0AqEA7GEH6fPbrWda/MvlajmU1GQ40O
         HTGIePIA2QQ5IcpQgYICiTSkWCV5eK9rJ6qPnPoqymty/yjRzqI38xHlkvJTtZf/YmiK
         D5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700671003; x=1701275803;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Di9yvxAWs36hcl+GloFnlKFwW1mBj+fjSlK/jwxdAQM=;
        b=Gh8yJHQ3MeIfGYy9kP13l+Fqsoe0/dhXkNrQNrileTnpQtmIbgNpS73lvuFrT0N1RT
         LmD7HAEQPwiA5HWfhEeRUm17S4+mwiZdRdhSQ19C1LgjL8Nerg9fqz/YrIi9DjELD5iv
         DrvY2DsopShgNruvLhq/9pvxyz1JNp5iXJEyw42IO4zopVLiljl8jbxsGCNt8OQPlgzs
         u295cOr/LR2Ja993muQEyRb9eXBpxcz8HJVZj6iYRkDEwmL43RtStfkPIPW8kZDSZS4P
         CHgKcACNLG1iJU0PRO6wn79KKjs04PnZoxoiJh4W7CIsCE4c14/TWNNWtx712KlhjF0O
         W5qg==
X-Gm-Message-State: AOJu0Yy2wBugQZejy5rJD+FwMssphvY9rjibGvzjgfFZ157PA8CpnG1Y
        0NK/genQrwSGDzPF4A4qVgoj6w==
X-Google-Smtp-Source: AGHT+IEeYpgfIB9AcjGXHssX5gEEWWel0dxoxZr2hxjJQgw+ykJg8pA81nzhlfCL5YWHQizaN8YVOw==
X-Received: by 2002:a05:6512:104e:b0:509:8db5:5163 with SMTP id c14-20020a056512104e00b005098db55163mr3071234lfb.0.1700671003426;
        Wed, 22 Nov 2023 08:36:43 -0800 (PST)
Received: from [172.30.204.227] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id s3-20020a195e03000000b005095614210dsm1928088lfb.241.2023.11.22.08.36.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 08:36:43 -0800 (PST)
Message-ID: <4dd3fa87-f568-4a11-a3ef-5452aa2f7312@linaro.org>
Date:   Wed, 22 Nov 2023 17:36:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] arm64: dts: qcom: add initial SM8650 dtsi
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231121-topic-sm8650-upstream-dt-v3-0-db9d0507ffd3@linaro.org>
 <20231121-topic-sm8650-upstream-dt-v3-2-db9d0507ffd3@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231121-topic-sm8650-upstream-dt-v3-2-db9d0507ffd3@linaro.org>
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



On 11/21/23 12:00, Neil Armstrong wrote:
> Add initial DTSI for the Qualcomm SM8650 platform,
> only contains nodes which doesn't depend on interconnect.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
[...]

It's quite a bit to chew through, but I don't think I have
anything to point out now

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
