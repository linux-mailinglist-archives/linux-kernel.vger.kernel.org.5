Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D0478236C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 08:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbjHUGHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 02:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbjHUGHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 02:07:48 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFAC783
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:07:46 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9a2033978so46677411fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 23:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692598065; x=1693202865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=abC59mP6JAJMeQMLsAfe2u+ZdmRJRLE9AtCEXGBBljg=;
        b=tlubH/Cjia7U7baDNzn/xFBRuZiX0j0OWI8OyOgzdmezw3ZIpFouzSFpC80kDVmRCX
         2Kmhh9iWMa90EU0LO4bAqQOA5dkKy121HTQxOj6nj4WreA3YhYSapS9xQUX1iC4Ls5FW
         kswd4DhEEd7x/jUgQB8cfSxRPiz7cG/ooKi55phUys+bFyNNBrGoVyRZW0SVPebHLYQ7
         LvP+sD/Y7X6Qoyk5uOrjHEI9KEDKpmCBKzC7mXCuvLC02xnOP7BDKWX0sARRjpFJpj0b
         Q060GleYwbeZW8jTC1/InS50SshmVTYXTtd3M2Dv5YXQbPQkdkmVbXvkSWTy3yul6HsR
         wHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692598065; x=1693202865;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=abC59mP6JAJMeQMLsAfe2u+ZdmRJRLE9AtCEXGBBljg=;
        b=JjYNOye24T+8HwbP3ybteoTJdozzPFs+F2rzMyifjlIRoLFjxNaVgCqHToz3Y1rJvt
         0Bn1TOO4t73H+wW819lczDBmeAGOA5ec9/pYmOtc8QPBP/DSnWBgeI3I4T+IDC6A+wdT
         Enn2shrVlSvgcyFARmyXtTYa/bZ8158Z8Ieu2yND0NGapQuFThAi3lTfqkTvCesbtlED
         CEjEXNZOP7NgofqiapvsXFXQ1fH27VGJpGawVIPuvWl0EoN5iUX2+NLA+WkrgcYHdsn2
         ICpZEodEB22lhFikZPq6cG5I++M2/GESa96tyF5DPFpzcpMnrn3BB8Yihzx5UfmAXc0x
         anBQ==
X-Gm-Message-State: AOJu0Yzg63O842yvXeRmEqV/Dgyy0/nPCXP+weRJXQhVD97QPf5J9Ti0
        ZnNzl/zT+hJ/MFTEvnXHzEurZw==
X-Google-Smtp-Source: AGHT+IH6wBrCMNqusfsbYd6KwloxQeMounCo4oof+2Y9bKUVLZ4QpwHUSVeeCcxpZFabgVsKqsP2Fw==
X-Received: by 2002:a05:6512:2396:b0:4fd:fafd:1ed4 with SMTP id c22-20020a056512239600b004fdfafd1ed4mr4850733lfv.2.1692598064921;
        Sun, 20 Aug 2023 23:07:44 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id lg5-20020a170906f88500b009937dbabbd5sm5861855ejb.220.2023.08.20.23.07.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 23:07:44 -0700 (PDT)
Message-ID: <1f492c4e-2125-73eb-8523-389e24727516@linaro.org>
Date:   Mon, 21 Aug 2023 08:07:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/3] dt-bindings: crypto: qcom,prng: Add SM8450
Content-Language: en-US
To:     Om Prakash Singh <quic_omprsing@quicinc.com>,
        konrad.dybcio@linaro.org
Cc:     agross@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
        davem@davemloft.net, devicetree@vger.kernel.org,
        herbert@gondor.apana.org.au, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        robh+dt@kernel.org, vkoul@kernel.org
References: <20230811-topic-8450_prng-v1-1-01becceeb1ee@linaro.org>
 <20230818161720.3644424-1-quic_omprsing@quicinc.com>
 <2c208796-5ad6-c362-dabc-1228b978ca1d@linaro.org>
 <1cadb40e-b655-4b9b-9189-dfdb22a2c234@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1cadb40e-b655-4b9b-9189-dfdb22a2c234@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 02:52, Om Prakash Singh wrote:
> I meant first one. using "qcom,rng-ee".

Then please provide some reasons.

> 
> I am looking for generic compatible string for all SoCs for which core 
> clock can be optional, same as we have "qcom,prng-ee".

There is a generic compatible already... but anyway, is the clock really
optional? Or just configured by firmware?

> 
> If we are using SoC name in compatible string, for each SoC support we 
> need to update qcom,prng.yaml file.

So you were talking about second case from my email? Still not sure what
you want to propose, but just in case - please always follow DT bindings
guidelines:

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Best regards,
Krzysztof

