Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8259C7BC2F6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 01:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbjJFXcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 19:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjJFXcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 19:32:53 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B85E9F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 16:32:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50433d8385cso3507442e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 16:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696635169; x=1697239969; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CBdkACARktQj/BUAzO0d3dZU3fqLQe8rUQ2Y7YM0Idc=;
        b=y0PIMkCN+7+HKA70URuZZ6T/ZZ/z3uIJV6arqlQDaaoBRbrIG/JVyKtEpYSheuWeHh
         oPyLMYXnfO21hwiOSs2T+64vSfmdGAMmEN0KfOHcGgM4QbwqErD3upMvicabchLSp3+s
         ny3AszBr2RZu7RrSqZGaohvyJqgnjvE5jEa39HgbCOXNFJBYcB3Msqr4228jHXsP1fDr
         r/D0Q3pyKmbbRY5D5SUxbd4u9j0MpIApzUsWQ6WHkb4JrDD0ozHYIjToh01I4ihs2ik/
         sNK+O6DGD/uKWaHe5QIH3W5wBuENs0bQk+FvqNKYRF0PnDAD+G6FIz6sElUBvITThmMm
         5EEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696635169; x=1697239969;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CBdkACARktQj/BUAzO0d3dZU3fqLQe8rUQ2Y7YM0Idc=;
        b=sHikOjzDYXDoLx4Aze08kUcgT1Nrs83o1vnOUInEAMFfYsvSArAi2Ajm//+BcgJTlq
         99Z+i4k/6fAYgmLKDVNWK2Ov4/r4xL3HE8yXrh2hg/FmeoDbpac1BWXK3N3FBmz/VX/c
         0jtI8x173bgoiLBvfAjv1skRe0ylSA1TAhHH1Y58Rwo+/q72df4hNEJQKqiKRIRMrRP6
         RXnAMEgwJtXrw3/30AzsceO2PsWQbjLYjb1eWAdAgVLph1Klku9Bk3eIUpii+37tZFtA
         KGrrQWnViID2mMTtXsiqj/SfCjoXmD2hc3o/mBBExgwgwVSC9voX9xkXF6gFuGPL+JQC
         bOFQ==
X-Gm-Message-State: AOJu0Yz3o5gHmtSlmn/i+lG75xsEHUPEM2zOwFzOIH/iig+CXYlmec3M
        P8h4pROa+7xBXlQHsUGfh+r31A==
X-Google-Smtp-Source: AGHT+IHwU4sYwr94MWkFEDLPbT+iSK4FSvWZfKmUnM6f2jkur0QlNvIi+BqqPl6MnY+NtVY6Q/1T0g==
X-Received: by 2002:a05:6512:473:b0:4fb:8948:2b28 with SMTP id x19-20020a056512047300b004fb89482b28mr7632978lfd.63.1696635168835;
        Fri, 06 Oct 2023 16:32:48 -0700 (PDT)
Received: from [192.168.200.173] (178235177147.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.147])
        by smtp.gmail.com with ESMTPSA id z6-20020ac24186000000b00502e2ab7118sm473280lfh.50.2023.10.06.16.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 16:32:48 -0700 (PDT)
Message-ID: <5da2ba4f-5bf7-46ff-8204-0c169042dbfa@linaro.org>
Date:   Sat, 7 Oct 2023 01:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: qcm6490: Add qcm6490 dts file
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, luca.weiss@fairphone.com
References: <20231003175456.14774-1-quic_kbajaj@quicinc.com>
 <20231003175456.14774-3-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20231003175456.14774-3-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.10.2023 19:54, Komal Bajaj wrote:
> Add qcm6490 devicetree file for QCM6490 SoC and QCM6490 IDP
> platform. QCM6490 is derived from SC7280 meant for various
> form factor including IoT.
> 
> Supported features are, as of now:
> * Debug UART
> * eMMC
> * USB
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
[...]

> diff --git a/arch/arm64/boot/dts/qcom/qcm6490.dtsi b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
> new file mode 100644
> index 000000000000..b93270cae9ae
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/qcm6490.dtsi
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: BSD-3-Clause
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include "sc7280.dtsi"
> +
> +/*
> + * Delete unused sc7280 memory nodes and define the memory regions
> + * required by qcm6490
> + */
> +/delete-node/ &rmtfs_mem;
> +/delete-node/ &wlan_ce_mem;
> +
> +/{
> +	reserved-memory {
> +		cdsp_secure_heap_mem: cdsp-secure-heap@81800000 {
> +			reg = <0x0 0x81800000 0x0 0x1e00000>;
> +			no-map;
> +		};
> +
> +		camera_mem: camera@84300000 {
Uhh.. this is totally not the same memory map that I have on a
random msm-5.4 source+devicetree drop (which does in turn align
with the one on QCM6490 Fairphone 5, as it should because it's
a rebadged reference device for the most part)..

Did you guys *really* redo it between software releases?

This SoC family has been on the market for quite some time,
breaking software expectations like that is not cool, especially
on a product with a promised lifespan of 10 years or whatever!

With that, this really seems more of a change that would belong
in the IDP dts than the 6490-common one..

Konrad
