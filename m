Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27797760A06
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbjGYGGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjGYGGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:06:40 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE73910EC
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:06:38 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-992b66e5affso864806666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690265197; x=1690869997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1+rBrDMf6/YCCV9GWBEFNjqK9epDBLmCM30wwhgc0XA=;
        b=sCN1WfNezGCexrEFFl2k3pCbh8Po50n3j8qJJiy3/pFFCMcSmZK5J4+CzgvlJYDpKi
         E21E8yBNxwlkC1xpRX+QMCIGR/9l/tyN+SMchU4dfosedsPw69QJWiJO1wZbK6cHv9Pw
         tEhQYi507VdUg/4S3eMtRe548csHDi92zzcyGG8y+cTjJhfj06GCjIXgsg3VXYjf5cd1
         ftyYoEn3PILAPrczHWFOwqJ6N92kD0BELC8D9MGInyK9dkgsgivt2PcozpNPS9ZoTy6P
         YmvGRF2oTOtcqik7T00+L1Oott389A8GnPzqzZIHQ484IX41voeFatu9u/VlRRoneknb
         iRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690265197; x=1690869997;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+rBrDMf6/YCCV9GWBEFNjqK9epDBLmCM30wwhgc0XA=;
        b=gBAMlaO/lVCI8jMYaEXMgG2uaZKWRS9yaZtnnKRcdqsitBbLKfJDF+niY4BGodTyti
         UqjbZlqzGIDjY5qv6nDEzzag+qKlFA63hajDT9IWtV52BpSsp4rfy9z0h8TLc9vAMPKH
         /Y6W9MTb1xqa7A7DNWBrqZ1kGP1RKCES2nj8CwjsS3rWNbOwVbscIpHmSZehDowsIfPA
         pb+ZCTn5qfbeMPoDf1/cDFo7ZaeAqOjucL/kTG2jIfnJYy/PFqbDTmBrJAHaBV+6H/WX
         OMSYYcHrNt20aX9dTx5OyxxYEiTxw0TNSVXXGW7qExpErke0XFcYYP/Zc2q4wVnIxOxB
         s9/A==
X-Gm-Message-State: ABy/qLbkhOfuAvdzFwgkanCTASolLwlx0kILiqSRWgFY1GhRTI+DSXrc
        t18geHRhHRb0l9GEa5egBzpOlA==
X-Google-Smtp-Source: APBJJlFvcFbvG7cXX6P0mi+QmqsUpeD16yf1MLZ+B25x2XZ+7UUUwldacPyuaTOHKuip/jxiV8lEQg==
X-Received: by 2002:a17:906:304f:b0:98e:1156:1a35 with SMTP id d15-20020a170906304f00b0098e11561a35mr11924556ejd.74.1690265197371;
        Mon, 24 Jul 2023 23:06:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906494700b00965a4350411sm7677651ejt.9.2023.07.24.23.06.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 23:06:36 -0700 (PDT)
Message-ID: <c57550dd-d028-5721-d6fa-702b1e80baf7@linaro.org>
Date:   Tue, 25 Jul 2023 08:06:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: Add qcom specific hvc transport
 for SCMI
Content-Language: en-US
To:     Nikunj Kela <quic_nkela@quicinc.com>, sudeep.holla@arm.com
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20230724164419.16092-1-quic_nkela@quicinc.com>
 <20230724164419.16092-3-quic_nkela@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230724164419.16092-3-quic_nkela@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 18:44, Nikunj Kela wrote:
> Introduce compatible "qcom,scmi-hvc-shmem" for SCMI
> transport channel for Qualcomm virtual platforms.
> The compatible mandates a shared memory channel.
> 
> Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

This looks fine for me, but I did not investigate whether Sudeep's
concerns were solved/answered fully.


Best regards,
Krzysztof

