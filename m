Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A47D1EAD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 19:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjJURky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjJURkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 13:40:52 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA2E126
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:40:46 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32dc9ff4a8fso1258553f8f.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697910044; x=1698514844; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YzRhsF4sW4AvdfvU56Au9DAitO9ZxYOt0TU6tMD+FLI=;
        b=voYWahPyLdBiOdLvqaXYKBN3PHSPBaoLMC/8WUzQqJNz5l5VqDlEvVJE1U3W6IjB1+
         gohQyoHgeYOhf+MS6e4c+3ND8N3dQE12ZnfTHWofJIi0epaQvjmrMkdPO8S82M1exwzz
         ghMFtl8hYTHNK6MNOkUbGCw1UpYVtf/4OzW/0JGD2T0mETNqPWmZAhFweYxrHPatUvOn
         8hG8MYn0mEtbEcIYyL+nzLOkyi3eb+CCIhdlkaionz/9q2VBHJqWuQ7iRTixQ6h8OKQi
         wX3G7G6YJ0OZdPo3X2b6qlzy8U5E3x2r0d+VPg7QEVNtyX3Vwkq5NYqjn79t1YRyS3z4
         onSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697910044; x=1698514844;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YzRhsF4sW4AvdfvU56Au9DAitO9ZxYOt0TU6tMD+FLI=;
        b=hBnL9bX7LQ9He2JWH+ibW5+M1Im2G+Uk/qZWMMYEuDpTgyU16Wme26UMGu4cyeCn1Z
         wuGSA3ymfc3kGTrgR6mzjqzdG8NHsAArzqkLGQesX3z52kKBkJx7iteY75dWev580s+T
         321Rno7AEk9P65FJjqBmZhoBp4QBfGpFBQVonc4thBAQ1mGIX8D/juv+J+bf7apvTuGS
         xgSMk3TQnL8bAdqwkTAA5aF3PeV7J9pTKwTjPRxGQooZ1EQX2Xxl+GRzpJilaVCuwBbg
         JXB/DXHFisQOR0GJrUtloeWbfn+7yr7Uwatcq0L0d5zYibw9Tac4Vpvc8wdk1y+/zHp4
         M8Rw==
X-Gm-Message-State: AOJu0YwEY1RmGk35I3APS0jcB9/EXHpHwDpRsR0qQKkrddPK877Si0rm
        5tVcTxdGlNaRKyHRh9khmkAlpg==
X-Google-Smtp-Source: AGHT+IGsCYeZnIKvQGD3fY3impqW8jzIRcM8ZcHOmFTUtDFPwTnoIpLIdfYpmP/bSacq+jJkahvJgg==
X-Received: by 2002:a05:6000:704:b0:32d:984e:97b2 with SMTP id bs4-20020a056000070400b0032d984e97b2mr4615806wrb.46.1697910044508;
        Sat, 21 Oct 2023 10:40:44 -0700 (PDT)
Received: from [10.66.66.3] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id i1-20020a05600011c100b0032dcb08bf94sm4089435wrx.60.2023.10.21.10.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:40:44 -0700 (PDT)
Message-ID: <20f48d75-da68-4ba5-aaeb-d9ee12df7e15@linaro.org>
Date:   Sat, 21 Oct 2023 19:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ASoC: qcom: Add support for WSA2 LPASS
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231019153541.49753-1-krzysztof.kozlowski@linaro.org>
 <20231019153541.49753-2-krzysztof.kozlowski@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231019153541.49753-2-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/23 17:35, Krzysztof Kozlowski wrote:
> Add support for Qualcomm WSA2 LPASS (Low Power Audio SubSystem) audio
> ports to several Qualcomm ADSP drivers: Q6APM LPASS DAIs, Q6DSP LPASS
> ports and shared Q6DSP Soundwire code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
Wouldn't

sound/soc/qcom/qdsp6/q6afe.c
sound/soc/qcom/qdsp6/q6routing.c
sound/soc/qcom/qdsp6/q6afe-dai.c

also require updates?

Konrad
