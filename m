Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFF179C6D2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 08:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjILGTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 02:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjILGTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 02:19:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4EAE75
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:19:39 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-31c65820134so4829034f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694499578; x=1695104378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LtxyNVrqbqYRJntPYqZndFwb10b1oYoWvN2Bf9PQuYo=;
        b=GUQH8+ZxmTeeKoxqZWBBi1PbW82jumecnWfJSIRdZ22i54OWKSzy2g8NcPdB1Oqr/P
         JuORppIq+Il47kVjr/YJQ1gS3H4192yP5xszYn6hYzaVz6DVwgVKCGd/DojDaa/yMLLj
         fjdum30GcB7XhoqDTWBCis0+v/wLDPgwhSIvnujwzoi3MzVy+fIUxqOfB9c0XvMc9i0O
         l4E7cQpl3xoaSutArVP64AeGoT0OoeNtRchSIWI7HEwQsIV/RnTqcsHG9ZrIQHE6i+Oy
         X8BHwdjJe+CPxJ305iYkSgAvXFo5tZ3XAw65fnHCTEKaBYxMCPqWtLZ2h4YRyUAsjc/F
         0zjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694499578; x=1695104378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtxyNVrqbqYRJntPYqZndFwb10b1oYoWvN2Bf9PQuYo=;
        b=O+i+1zsEBrtq05N1d8uR4GcMreUU+C8r3qd47X4ZeHEpHeZg2z7cY7hOBTLe1Jdl04
         lNkqUzMSfaAziCxMjSSQ0l95x/bRauv6q+thx8r2b27kaqx8QnKU/MrthGuL0NAxliD4
         TPEkJIP9Q7OjO4Z4Cwi8C9rP/R5o1APxbS1O4TRYSIDHYR1SEX08otcmvZ5yjfjanPUU
         vw5HoxyBhI5Yw2nzWdqsYSnbYT/sj/v11IZFweTEH+3fWjIRZUd0rf6BcTN7Ym2bZQV/
         0lCZb7oYEymwQLUyIbrcgn5widylBT151FMhhhxMUr7D+3JbmANggdkRKnOpx21T2pvd
         iBJQ==
X-Gm-Message-State: AOJu0YxOfZfu5c4eb1kG0byo1Ew8nXBIHnX2833mu00JaYubZXu+/t3e
        ISvqqLZ22uhX4UyZ3nELysr40g==
X-Google-Smtp-Source: AGHT+IFoILfNqUC5S/cn8wwndgL995YGOyCzCehNmLqCcFugaMLUnmwzzE3PQaVZ2KiMh+6Cco4orQ==
X-Received: by 2002:a5d:688f:0:b0:317:dada:2417 with SMTP id h15-20020a5d688f000000b00317dada2417mr9990021wru.31.1694499578114;
        Mon, 11 Sep 2023 23:19:38 -0700 (PDT)
Received: from [192.168.0.163] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d43c5000000b003180fdf5589sm12001027wrr.6.2023.09.11.23.19.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 23:19:37 -0700 (PDT)
Message-ID: <5d13f9c7-665d-4ff5-962d-940898b24754@linaro.org>
Date:   Tue, 12 Sep 2023 07:19:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFT 00/20] Venus cleanups
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230911-topic-mars-v1-0-a7d38bf87bdb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2023 16:10, Konrad Dybcio wrote:
> With the driver supporting multiple generations of hardware, some mold
> has definitely grown over the code..
> 
> This series attempts to amend this situation a bit by commonizing some
> code paths and fixing some bugs while at it.
> 
> Only tested on SM8250.
> 
> Definitely needs testing on:
> 
> - SDM845 with old bindings
> - SDM845 with new bindings or 7180
> - MSM8916
> - MSM8996
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Don't we have both a db410c and db845c in Bjorn's lab you could test 
this on ?

---
bod

