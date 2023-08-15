Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBC977C731
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 07:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbjHOFoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 01:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbjHOFnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 01:43:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBB2106
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:43:13 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b9bf52cd08so74563471fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 22:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692078191; x=1692682991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jw6ZKn2vNcjA9MqDmrsGFXdRmKd5KhjNUkjx2Uq1Kd0=;
        b=BKPeeD2U5MUnrhf2RZMUCETsWAXISwTYH1oSOI+t2Vck3SDjGoEiNzMWDyFmdcHs/j
         uyTL46pkrEV5ecqCe3sq2Pnn6PUCw/k+qZsRw471glKKDFPifLXrTwy2V40oVR7V+rEQ
         q3jBlmWdxIrFdkIho2LetNiOrmtJnPyxYIEXGh5vtVMQRgT3UFee42wen2p8fcX0zbg6
         0QTT1v/c2mt1LDGjwZCnJsAZqyDF1qW5UCUXq8znpC/GwRrsQMAOo2wrp950tBowieZB
         rizyV7w0X1IOn7f34tjjcw5F5PoRHjKpvJn//xBWCEld44q4wJsYWMzXy7IFITeD4IeO
         kGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692078191; x=1692682991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jw6ZKn2vNcjA9MqDmrsGFXdRmKd5KhjNUkjx2Uq1Kd0=;
        b=KQu4faIE7bY7Y90+8srHM+2H8IluB2lc1yHAorlE6ndiaWBN30b3t6itg/3UmCHhUt
         HojuLRyM35keSfVS7J9qxZLMOUjQka1JRk5w3mzszGJG1vLd1cIcNjOFNRNKten6vFHA
         77M8/S/yP+apom5DEWD/nMgNH/kUefW/2aSpSL3poJi4ON0HAuIK/2ygl9b47oiLLGEO
         VSu3M/OTrbBE8ScVpA3FkaGa63tOzh3kq+s2Y5D5Q5kZbvZunKyx+V5yN/6TTa1GbtZp
         5ArWxypN5x8tA1rI5MNKXv+zIe2IkaxjHk31OTVP/6oglIsQxoq0Zk4qzhm94GAVfMP6
         MyWw==
X-Gm-Message-State: AOJu0YxWnl6mZsz2nrsiTCsnLeBGuH1FeOYmxb4rVuHzSNOEubp1nkyx
        HjU8MQSBor+YEo99gzAjhqmNAA==
X-Google-Smtp-Source: AGHT+IEvyC3KHqPI4Aqoe7nlXlx/XKraQasiWSzM4QIIBy+bofI9pfUzQQxcwHNZtVA6mH3J4pDrQQ==
X-Received: by 2002:a2e:8317:0:b0:2b9:ecc5:d1de with SMTP id a23-20020a2e8317000000b002b9ecc5d1demr6962968ljh.37.1692078191458;
        Mon, 14 Aug 2023 22:43:11 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c00cb00b003fe29f6b61bsm16416026wmm.46.2023.08.14.22.43.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 22:43:11 -0700 (PDT)
Message-ID: <c70422eb-ca6d-ed86-dd15-dfa555e64c89@linaro.org>
Date:   Tue, 15 Aug 2023 07:43:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 02/14] dt-bindings: display/msm/gmu: Allow passing QMP
 handle
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230628-topic-a7xx_drmmsm-v2-0-1439e1b2343f@linaro.org>
 <20230628-topic-a7xx_drmmsm-v2-2-1439e1b2343f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230628-topic-a7xx_drmmsm-v2-2-1439e1b2343f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 23:02, Konrad Dybcio wrote:
> When booting the GMU, the QMP mailbox should be pinged about some tunables
> (e.g. adaptive clock distribution state). To achieve that, a reference to
> it is necessary. Allow it and require it with A730.
> 
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> # sm8450
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/display/msm/gmu.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

