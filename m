Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7137792C73
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjIERbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjIERa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:30:57 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A993BE31
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 09:56:06 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4cbso3713691a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693932599; x=1694537399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SDmEkkiomzbm/t0kyOHY3bm7nezdvpUGCm1Gee0mEtE=;
        b=KA52YT5/Aa7h/7BHI5TEjC4kU4BHmqUqzH31JKe83xEmTU9Bl2KGTPcvEIvAFqLB9w
         8lyPtbyeXhK+k+RSEnAdA1tBTT82WgB12ucfgt4CKUjR9vg5ATLq0KYoKs7uszBoWNki
         scBtx/vht7qui26kF4WbHT0N4rYDQIiI/4XHN+Qcq8zP7NVjNnYolcIM1aqDeb12sm+E
         c0ntrtzXlh2KjQyLEk8lEnLy5AoExBSguxAopPV5Ftm4cGQKJvuPuO+2ZzjJrTTelOd/
         xPpEePzy9KOVVfM8IdF7vYu4aVvVgeTN5TFRX1/ovCtfUi8rW5yg2v4mcL4Dl0c0EXtD
         RPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693932599; x=1694537399;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDmEkkiomzbm/t0kyOHY3bm7nezdvpUGCm1Gee0mEtE=;
        b=koYMsgY/Q9VwZMQckdEfzTqQHXo1TAsBLzX4kep2d+I8GxdZnPK5sOprQ5CfN78Ro1
         p79/W37dBymLiUYebYvMlsgn1StPe1gt5WZh7QRP9D60yfqUgVWFPRlGzoEGNIMvsRFq
         CePNJTRj2HsgPhu2U4qglrhycThiZn97had8RiVAJcIed/bnjLVXe+g2zPiIhD02O34Z
         o4oRqcdtbGv2++OH5yHGLXL2sSVEeUY/bTnl2qbkhs5q9NaeQxrkqGE+TmzRytmUD0xK
         2vklRKPozGt6o8TMDFTZm7eHzUztlMaYIl8wIYzS17HnmJP2MVWQWpcgEfIxhzxeCcM8
         pzSA==
X-Gm-Message-State: AOJu0YyTaC5m4arjJ/D83yUnFkiupau7qEta5mUq8MxC0lst1Vh+xFSQ
        EvS6BWTsL4OQ/aAbkpr+eykKFhNpZ96S+MymcU+umg==
X-Google-Smtp-Source: AGHT+IG95JkmN66/glE3KZ9evrj4ynCBfjln8sFmAB+NvGPgcflf1KTh5SG7UN7y6QuRyekGl9BiHg==
X-Received: by 2002:a17:907:7714:b0:9a2:1df2:8e08 with SMTP id kw20-20020a170907771400b009a21df28e08mr219686ejc.45.1693930070557;
        Tue, 05 Sep 2023 09:07:50 -0700 (PDT)
Received: from [192.168.37.232] (178235177232.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.232])
        by smtp.gmail.com with ESMTPSA id rl21-20020a170907217500b0099315454e76sm7701782ejb.211.2023.09.05.09.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 09:07:50 -0700 (PDT)
Message-ID: <5446a3fd-59bc-4297-b3c4-204d014ac3cd@linaro.org>
Date:   Tue, 5 Sep 2023 18:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: ipq6018: Fix tcsr_mutex register
 size
Content-Language: en-US
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com,
        baolin.wang@linux.alibaba.com, linux-remoteproc@vger.kernel.org
Cc:     quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com, stable@vger.kernel.org
References: <20230905095535.1263113-1-quic_viswanat@quicinc.com>
 <20230905095535.1263113-2-quic_viswanat@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230905095535.1263113-2-quic_viswanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.09.2023 11:55, Vignesh Viswanathan wrote:
> IPQ6018's TCSR Mutex HW lock register has 32 locks of size 4KB each.
> Total size of the TCSR Mutex registers is 128KB.
> 
> Fix size of the tcsr_mutex hwlock register to 0x20000.
> 
> Changes in v2:
>  - Drop change to remove qcom,ipq6018-tcsr-mutex compatible string
>  - Added Fixes and stable tags
> 
> Cc: stable@vger.kernel.org
> Fixes: 5bf635621245 ("arm64: dts: ipq6018: Add a few device nodes")
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
