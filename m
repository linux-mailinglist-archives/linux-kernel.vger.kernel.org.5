Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86BB78DD8B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244950AbjH3Svl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244116AbjH3MfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 08:35:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB4AE8
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:35:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-500c63c9625so2493830e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 05:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693398909; x=1694003709; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SAG+i5ZXFa59k8HflHYAPNmxFtGPfSD7NXS9CWIEhSY=;
        b=xydck9XNKDelsMEtPNwvSRxcqjz++Rd219GreT5P3jy5Ystip0aT8vGXTUSYbLuywS
         BBkfbCbs/DcZSfrvpDtTYKcxCYfN+7WDrQyKzrENmxQzZNIvut4Vw8cQnZozd1q7IMSp
         4O5sxAWZ9BpwTWkyFH5yXIpu564+GDf2f4u2kWV/3SUq6V+nj69l9L9cFM80geDNRI+P
         Imrq8T6JQZA5r5F2Rdflb9CqrFl2QzP6wNRBQs4Q++KeDNtwMjmJPsdle6k9fAhP9uHD
         D0RJTeUym93zHYA4XSF3aqaHehGRyJ3pZJ3zKQ6hXsDslIJf+qQ+iMNWTQS5Jjlh22D6
         4Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693398909; x=1694003709;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SAG+i5ZXFa59k8HflHYAPNmxFtGPfSD7NXS9CWIEhSY=;
        b=C3PK1f4xKc6YHVKxH6N1R61Fc7uwsMtlJf43wBHdCtrjjvmzkxNV//5SvLYyEUzPB2
         USnBqscq2eWUyPrlqLvHTdY4NSibsFvwkMplQZMLZ9xC8OdP/XTO3ohM9pO0VyOVmmhQ
         pnI2I32DeIrGc/PY3Ch0HMiDlhNCUEIqx7vmm7EUVAusplXwsrN9gREXcB/cL9BU0q4d
         M2+biFX78oUhdyO/nzkNS22nnYun9t/Acqbp8iBW39ihcUflJNviL49980CK1dUNNGZY
         e0T5W0q5Mwpl2XgExeO9oYFUTtIQ6a+G8ozFU4qCe7uUU7F6EVnw89zct59pgLlaHEMj
         UKeA==
X-Gm-Message-State: AOJu0Yzmhhh91lq7pvs8pV2rnAmdD5U3jJds0U8Ifpan9BjHPeMcdnuW
        VdlSoNk3I22j45JQ8FA40uHy7A==
X-Google-Smtp-Source: AGHT+IHBX3y+vsmG6PmdwN7XUxLV48CGXQgfBVG1U2kHtgK4cjT2jZdXmX2WnCjNpM8qwvuAj+kaKw==
X-Received: by 2002:ac2:5f52:0:b0:4fe:21f2:a04a with SMTP id 18-20020ac25f52000000b004fe21f2a04amr1360273lfz.8.1693398908492;
        Wed, 30 Aug 2023 05:35:08 -0700 (PDT)
Received: from [192.168.1.101] (abyl195.neoplus.adsl.tpnet.pl. [83.9.31.195])
        by smtp.gmail.com with ESMTPSA id v20-20020ac25614000000b004fbc82dd1a5sm2366788lfd.13.2023.08.30.05.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 05:35:08 -0700 (PDT)
Message-ID: <3a9238c2-d105-4c1f-92da-e1314d8ff053@linaro.org>
Date:   Wed, 30 Aug 2023 14:35:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/6] soc: qcom: llcc: Refactor llcc driver to support
 multiple configuration
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        srinivas.kandagatla@linaro.org, bryan.odonoghue@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230830105654.28057-1-quic_kbajaj@quicinc.com>
 <20230830105654.28057-3-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230830105654.28057-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.2023 12:56, Komal Bajaj wrote:
> Refactor driver to support multiple configuration for llcc on a target.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
